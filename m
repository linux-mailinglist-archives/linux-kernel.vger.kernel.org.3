Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5A14EC9EC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349021AbiC3Qs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349089AbiC3QsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:48:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2CDA27971B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:46:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC5341576;
        Wed, 30 Mar 2022 09:46:22 -0700 (PDT)
Received: from [10.57.8.120] (unknown [10.57.8.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07EAF3F66F;
        Wed, 30 Mar 2022 09:46:20 -0700 (PDT)
Message-ID: <31fe187d-3997-73b7-3dfe-ded740e70567@arm.com>
Date:   Wed, 30 Mar 2022 17:46:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 21/22] firmware: arm_scmi: Add SCMI v3.1 Perf power-cost
 in microwatts
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
 <20220330150551.2573938-22-cristian.marussi@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220330150551.2573938-22-cristian.marussi@arm.com>
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



On 3/30/22 16:05, Cristian Marussi wrote:
> Add SCMIv3.1 internal support for parsing message attributes reporting
> the capability of a performance domain to report power-cost in microwatts.
> 
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   drivers/firmware/arm_scmi/perf.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index e1aa0ed67971..65ffda5495d6 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -45,6 +45,7 @@ struct scmi_msg_resp_perf_attributes {
>   	__le16 num_domains;
>   	__le16 flags;
>   #define POWER_SCALE_IN_MILLIWATT(x)	((x) & BIT(0))
> +#define POWER_SCALE_IN_MICROWATT(x)	((x) & BIT(1))
>   	__le32 stats_addr_low;
>   	__le32 stats_addr_high;
>   	__le32 stats_size;
> @@ -170,6 +171,7 @@ struct scmi_perf_info {
>   	u32 version;
>   	int num_domains;
>   	bool power_scale_mw;
> +	bool power_scale_uw;
>   	u64 stats_addr;
>   	u32 stats_size;
>   	struct perf_dom_info *dom_info;
> @@ -200,6 +202,8 @@ static int scmi_perf_attributes_get(const struct scmi_protocol_handle *ph,
>   
>   		pi->num_domains = le16_to_cpu(attr->num_domains);
>   		pi->power_scale_mw = POWER_SCALE_IN_MILLIWATT(flags);
> +		if (PROTOCOL_REV_MAJOR(pi->version) >= 0x3)
> +			pi->power_scale_uw = POWER_SCALE_IN_MICROWATT(flags);
>   		pi->stats_addr = le32_to_cpu(attr->stats_addr_low) |
>   				(u64)le32_to_cpu(attr->stats_addr_high) << 32;
>   		pi->stats_size = le32_to_cpu(attr->stats_size);

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

I'll send a follow-up patch which is using this information when this
patch gets into linux-next.
