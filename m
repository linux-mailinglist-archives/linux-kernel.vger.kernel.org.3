Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29D04BC6B9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 08:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241249AbiBSHdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 02:33:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbiBSHdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 02:33:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55BC48311
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 23:33:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CB55B8006F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 07:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A8DC340EF;
        Sat, 19 Feb 2022 07:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645255998;
        bh=614FNkoWHrfwRnbpfM3As7ed3TVJxAFokHvmZjVr8IU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WIupzCRzvfCi47ZKZBcMIFmdWd7BCtN0ts570dK8MSngQkewmmnTfVAcEUrxy9fkV
         M6M6H4X+KhEX/82l+GrvKXmJeoJl0DLMbrATlvh0qSxpjsmqoyNjGuAA424dsS/DCC
         eGZ/YH/FpCYS9xXR1YvKFsgjPp/CO/gBB1HhV4+8=
Date:   Sat, 19 Feb 2022 08:33:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Desmond Yan <desmond.yan@broadcom.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] misc: bcm-vk: add kconfig for supporting viper
 chip
Message-ID: <YhCdNyRxGYmhx21f@kroah.com>
References: <20220218200811.17136-1-desmond.yan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218200811.17136-1-desmond.yan@broadcom.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 12:08:11PM -0800, Desmond Yan wrote:
> Add kconfig for enabling bcm-vk driver to support the viper chip.
> Default is off and only explicitly configured that the viper chip
> would be discovered by the driver and loaded for usage.
> 
> Tested-by: Desmond Yan <desmond.yan@broadcom.com>
> Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
> ---
>  drivers/misc/bcm-vk/Kconfig      | 10 ++++++++++
>  drivers/misc/bcm-vk/bcm_vk_dev.c |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/misc/bcm-vk/Kconfig b/drivers/misc/bcm-vk/Kconfig
> index 68a972772b99..43910a378163 100644
> --- a/drivers/misc/bcm-vk/Kconfig
> +++ b/drivers/misc/bcm-vk/Kconfig
> @@ -16,6 +16,16 @@ config BCM_VK
>  
>  	  If unsure, say N.
>  
> +config BCM_VK_VIPER
> +	bool "VK driver for VIPER"
> +	depends on BCM_VK
> +	help
> +	  Turn on to enable using the vk driver for the viper variant.
> +	  Used for development environments where viper uses VK driver
> +	  and VK firmware rather than an alternate firmware and driver.
> +
> +	  If unsure, say N.
> +
>  config BCM_VK_TTY
>  	bool "Enable tty ports on a Broadcom VK Accelerator device"
>  	depends on TTY
> diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
> index ad639ee85b2a..41dbfa4fa4a5 100644
> --- a/drivers/misc/bcm-vk/bcm_vk_dev.c
> +++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
> @@ -1633,7 +1633,9 @@ static void bcm_vk_shutdown(struct pci_dev *pdev)
>  
>  static const struct pci_device_id bcm_vk_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_VALKYRIE), },
> +#if defined(CONFIG_BCM_VK_VIPER)
>  	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_VIPER), },
> +#endif

Why do you need a new config option just to add a new device id?  Why
would you ever NOT want this option enabled as there is no other driver
for this hardware?

thanks,

greg k-h
