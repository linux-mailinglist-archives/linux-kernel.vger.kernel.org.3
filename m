Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E6D4BE593
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381707AbiBUR2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:28:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbiBUR2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:28:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C624419C02;
        Mon, 21 Feb 2022 09:27:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F5DB1063;
        Mon, 21 Feb 2022 09:27:44 -0800 (PST)
Received: from [10.57.40.147] (unknown [10.57.40.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D1663F70D;
        Mon, 21 Feb 2022 09:27:42 -0800 (PST)
Message-ID: <71e94ac3-20fc-6f41-270f-fe246740e7e0@arm.com>
Date:   Mon, 21 Feb 2022 17:27:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 8/9] drm/tegra: vic: Implement get_streamid_offset
Content-Language: en-GB
To:     Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-9-mperttunen@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220218113952.3077606-9-mperttunen@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-18 11:39, Mikko Perttunen via iommu wrote:
> Implement the get_streamid_offset required for supporting context
> isolation. Since old firmware cannot support context isolation
> without hacks that we don't want to implement, check the firmware
> binary to see if context isolation should be enabled.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   drivers/gpu/drm/tegra/vic.c | 38 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
> index 1e342fa3d27b..2863ee5e0e67 100644
> --- a/drivers/gpu/drm/tegra/vic.c
> +++ b/drivers/gpu/drm/tegra/vic.c
> @@ -38,6 +38,8 @@ struct vic {
>   	struct clk *clk;
>   	struct reset_control *rst;
>   
> +	bool can_use_context;
> +
>   	/* Platform configuration */
>   	const struct vic_config *config;
>   };
> @@ -229,6 +231,7 @@ static int vic_load_firmware(struct vic *vic)
>   {
>   	struct host1x_client *client = &vic->client.base;
>   	struct tegra_drm *tegra = vic->client.drm;
> +	u32 fce_bin_data_offset;
>   	dma_addr_t iova;
>   	size_t size;
>   	void *virt;
> @@ -277,6 +280,25 @@ static int vic_load_firmware(struct vic *vic)
>   		vic->falcon.firmware.phys = phys;
>   	}
>   
> +	/*
> +	 * Check if firmware is new enough to not require mapping firmware
> +	 * to data buffer domains.
> +	 */
> +	fce_bin_data_offset = *(u32 *)(virt + VIC_UCODE_FCE_DATA_OFFSET);
> +
> +	if (!vic->config->supports_sid) {
> +		vic->can_use_context = false;
> +	} else if (fce_bin_data_offset != 0x0 && fce_bin_data_offset != 0xa5a5a5a5) {
> +		/*
> +		 * Firmware will access FCE through STREAMID0, so context
> +		 * isolation cannot be used.
> +		 */
> +		vic->can_use_context = false;
> +		dev_warn_once(vic->dev, "context isolation disabled due to old firmware\n");
> +	} else {
> +		vic->can_use_context = true;
> +	}
> +
>   	return 0;
>   
>   cleanup:
> @@ -358,10 +380,26 @@ static void vic_close_channel(struct tegra_drm_context *context)
>   	host1x_channel_put(context->channel);
>   }
>   
> +static int vic_get_streamid_offset(struct tegra_drm_client *client)
> +{
> +	struct vic *vic = to_vic(client);
> +	int err;
> +
> +	err = vic_load_firmware(vic);
> +	if (err < 0)
> +		return err;
> +
> +	if (vic->can_use_context)
> +		return 0x30;
> +	else
> +		return -ENOTSUPP;
> +}
> +
>   static const struct tegra_drm_client_ops vic_ops = {
>   	.open_channel = vic_open_channel,
>   	.close_channel = vic_close_channel,
>   	.submit = tegra_drm_submit,
> +	.get_streamid_offset = vic_get_streamid_offset,

The patch order seems off here, since the .get_streamid_offset member 
isn't defined yet.

Robin.

>   };
>   
>   #define NVIDIA_TEGRA_124_VIC_FIRMWARE "nvidia/tegra124/vic03_ucode.bin"
