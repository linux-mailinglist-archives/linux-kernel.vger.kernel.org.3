Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8A550CAAF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 15:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbiDWNll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 09:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiDWNlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:41:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCB2174F56;
        Sat, 23 Apr 2022 06:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FBCBB8077D;
        Sat, 23 Apr 2022 13:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27113C385A5;
        Sat, 23 Apr 2022 13:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650721120;
        bh=1iuqdE/gMCK/IrEB1cps2joJ8q8TDslu7dsCHyQdk3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PqhKrvSOkUQJzntv042bNJrnI5ExqK27Ys0YSXQmTvP8xMjZUIkrz9FV3a0ov7W1I
         LcJPNXxfJIhwMhU+icUIJ9cbwVXWzLvH80HIi4QC55WkTj/zQq8+5nSaCDudhszTYh
         jH/lBlH0BPzV22xse/CPKXKb9ddt/VUAJ44n6bUyKCEh5K+f33Xy/SNLgBymglJkmD
         H06xI2qiHYBMC3povZSv84IDtYb6l/N8NqK5zY1+AZSAZZOv13RBUN43GbHHvD9kJ3
         wMITBo9YKWhpI86ijjap321Cvx3NQ0avpN67qu4zs+ViXGBxPf2h/ZmY7gHLiga1GJ
         CJ+Ra4/cJNlQw==
Date:   Sat, 23 Apr 2022 19:08:31 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     hemantk@codeaurora.org, gregkh@linuxfoundation.org,
        loic.poulain@linaro.org, bbhatt@codeaurora.org,
        christophe.jaillet@wanadoo.fr, thomas.ulrich@thalesgroup.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bus: mhi: host: Add support for Cinterion
 MV32-WA/MV32-WB
Message-ID: <20220423133831.GQ374560@thinkpad>
References: <20220421092141.3984-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421092141.3984-1-slark_xiao@163.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 05:21:41PM +0800, Slark Xiao wrote:
> MV32-WA is designed based on Qualcomm SDX62, and
> MV32-WB is designed based on QUalcomm SDX65. Both
> products' enumeration would align with previous
> product MV31-W.So we merge MV31 and MV32 to MV3X
> for some common settings.
> 
> Fixes: 87693e092bd0 ("bus: mhi: pci_generic: Add Cinterion MV31-W PCIe to MHI")
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Applied to mhi-next!

Thanks,
Mani

> ---
>  drivers/bus/mhi/host/pci_generic.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 9527b7d63840..ef8c16746b76 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -371,7 +371,7 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
>  	.sideband_wake = false,
>  };
>  
> -static const struct mhi_channel_config mhi_mv31_channels[] = {
> +static const struct mhi_channel_config mhi_mv3x_channels[] = {
>  	MHI_CHANNEL_CONFIG_UL(0, "LOOPBACK", 64, 0),
>  	MHI_CHANNEL_CONFIG_DL(1, "LOOPBACK", 64, 0),
>  	/* MBIM Control Channel */
> @@ -382,25 +382,33 @@ static const struct mhi_channel_config mhi_mv31_channels[] = {
>  	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 512, 3),
>  };
>  
> -static struct mhi_event_config mhi_mv31_events[] = {
> +static struct mhi_event_config mhi_mv3x_events[] = {
>  	MHI_EVENT_CONFIG_CTRL(0, 256),
>  	MHI_EVENT_CONFIG_DATA(1, 256),
>  	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
>  	MHI_EVENT_CONFIG_HW_DATA(3, 1024, 101),
>  };
>  
> -static const struct mhi_controller_config modem_mv31_config = {
> +static const struct mhi_controller_config modem_mv3x_config = {
>  	.max_channels = 128,
>  	.timeout_ms = 20000,
> -	.num_channels = ARRAY_SIZE(mhi_mv31_channels),
> -	.ch_cfg = mhi_mv31_channels,
> -	.num_events = ARRAY_SIZE(mhi_mv31_events),
> -	.event_cfg = mhi_mv31_events,
> +	.num_channels = ARRAY_SIZE(mhi_mv3x_channels),
> +	.ch_cfg = mhi_mv3x_channels,
> +	.num_events = ARRAY_SIZE(mhi_mv3x_events),
> +	.event_cfg = mhi_mv3x_events,
>  };
>  
>  static const struct mhi_pci_dev_info mhi_mv31_info = {
>  	.name = "cinterion-mv31",
> -	.config = &modem_mv31_config,
> +	.config = &modem_mv3x_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32,
> +	.mru_default = 32768,
> +};
> +
> +static const struct mhi_pci_dev_info mhi_mv32_info = {
> +	.name = "cinterion-mv32",
> +	.config = &modem_mv3x_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
>  	.mru_default = 32768,
> @@ -475,6 +483,12 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  	/* MV31-W (Cinterion) */
>  	{ PCI_DEVICE(0x1269, 0x00b3),
>  		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
> +	/* MV32-WA (Cinterion) */
> +	{ PCI_DEVICE(0x1269, 0x00ba),
> +		.driver_data = (kernel_ulong_t) &mhi_mv32_info },
> +	/* MV32-WB (Cinterion) */
> +	{ PCI_DEVICE(0x1269, 0x00bb),
> +		.driver_data = (kernel_ulong_t) &mhi_mv32_info },
>  	{  }
>  };
>  MODULE_DEVICE_TABLE(pci, mhi_pci_id_table);
> -- 
> 2.25.1
> 
