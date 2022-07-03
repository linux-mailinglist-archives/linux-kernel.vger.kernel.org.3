Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F77B564382
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 02:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiGCAep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 20:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiGCAen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 20:34:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F57FA1A3;
        Sat,  2 Jul 2022 17:34:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06AA0B8090A;
        Sun,  3 Jul 2022 00:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E56C34114;
        Sun,  3 Jul 2022 00:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656808479;
        bh=GWbu2ncOW4XEhbTywEpUPp+NsA8O3qnFaP4Md8AilIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ClJ4fW4UmKZs/j4/OXVDCrGOCbP+wQ5vqaGnV8gaRTdb+XVqQ33rDtUOAYZYwyq/t
         Yse9xFrgIFyG9sQ6Hx9S3neiDis0NcJWvSteAoeQvYcxO7A5E6PGoBqUwOPTYsjd75
         2qoFNOTFoB3uxSTj+gn43aYkno0y3120K23U8LdjLstQDq/omI1gei2oj8Zn8yKqLL
         ALfsSMYDwl1UYkAG229JW57mnVNcJfQbOCKOon0VuxMmNPhAn81eRhFRjossQARh0a
         OmOfycr3zdmqc6Ns/GTiv8T8x0V5A0YMRojJLHh/RX/sY+ZHKd0tXCDa8GtEjnow42
         Nv1hsqGmhYhGA==
Date:   Sun, 3 Jul 2022 08:34:34 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, sivadur@xilinx.com, radheys@xilinx.com
Subject: Re: [RFC PATCH] usb: chipidea: Add support for VBUS control with PHY
Message-ID: <20220703003434.GA1382015@Peter>
References: <20220524120802.9394-1-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524120802.9394-1-piyush.mehta@xilinx.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-24 17:38:02, Piyush Mehta wrote:
> Some platforms make use of VBUS control over PHY which means controller
> driver has to access PHY registers to turn on/off VBUS line.This patch
> adds support for such platforms in chipidea.
> 
> Flag 'CI_HDRC_PHY_VBUS_CONTROL' added to support VBus control feature.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
> We have created this patch as RFC, as I introduced a new flag
> (CI_HDRC_PHY_VBUS_CONTROL) and would like to get comment if
> it's the proper way to check for VBus support for zynq.
> ---
>  drivers/usb/chipidea/ci_hdrc_usb2.c | 1 +
>  drivers/usb/chipidea/host.c         | 7 +++++++
>  drivers/usb/chipidea/otg_fsm.c      | 7 +++++++
>  include/linux/usb/chipidea.h        | 1 +
>  4 files changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
> index 89e1d82..dc86b12 100644
> --- a/drivers/usb/chipidea/ci_hdrc_usb2.c
> +++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
> @@ -30,6 +30,7 @@ static const struct ci_hdrc_platform_data ci_default_pdata = {
>  
>  static const struct ci_hdrc_platform_data ci_zynq_pdata = {
>  	.capoffset	= DEF_CAPOFFSET,
> +	.flags          = CI_HDRC_PHY_VBUS_CONTROL,
>  };
>  
>  static const struct ci_hdrc_platform_data ci_zevio_pdata = {
> diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> index bdc3885..bc3634a 100644
> --- a/drivers/usb/chipidea/host.c
> +++ b/drivers/usb/chipidea/host.c
> @@ -63,6 +63,13 @@ static int ehci_ci_portpower(struct usb_hcd *hcd, int portnum, bool enable)
>  		priv->enabled = enable;
>  	}
>  
> +	if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL) {
> +		if (enable)
> +			usb_phy_vbus_on(ci->usb_phy);
> +		else
> +			usb_phy_vbus_off(ci->usb_phy);
> +	}
> +
>  	if (enable && (ci->platdata->phy_mode == USBPHY_INTERFACE_MODE_HSIC)) {
>  		/*
>  		 * Marvell 28nm HSIC PHY requires forcing the port to HS mode.
> diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
> index 6ed4b00..5ed9164 100644
> --- a/drivers/usb/chipidea/otg_fsm.c
> +++ b/drivers/usb/chipidea/otg_fsm.c
> @@ -471,6 +471,10 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
>  				return;
>  			}
>  		}
> +
> +		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
> +			usb_phy_vbus_on(ci->usb_phy);
> +
>  		/* Disable data pulse irq */
>  		hw_write_otgsc(ci, OTGSC_DPIE, 0);
>  
> @@ -480,6 +484,9 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
>  		if (ci->platdata->reg_vbus)
>  			regulator_disable(ci->platdata->reg_vbus);
>  
> +		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
> +			usb_phy_vbus_off(ci->usb_phy);
> +

Have your platform used OTG FSM? If not used, do not need to change it.
Otherwise, it is okay for me.

Peter

>  		fsm->a_bus_drop = 1;
>  		fsm->a_bus_req = 0;
>  	}
> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> index edf3342..ee38835 100644
> --- a/include/linux/usb/chipidea.h
> +++ b/include/linux/usb/chipidea.h
> @@ -62,6 +62,7 @@ struct ci_hdrc_platform_data {
>  #define CI_HDRC_REQUIRES_ALIGNED_DMA	BIT(13)
>  #define CI_HDRC_IMX_IS_HSIC		BIT(14)
>  #define CI_HDRC_PMQOS			BIT(15)
> +#define CI_HDRC_PHY_VBUS_CONTROL	BIT(16)
>  	enum usb_dr_mode	dr_mode;
>  #define CI_HDRC_CONTROLLER_RESET_EVENT		0
>  #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
> -- 
> 2.7.4
> 

-- 

Thanks,
Peter Chen

