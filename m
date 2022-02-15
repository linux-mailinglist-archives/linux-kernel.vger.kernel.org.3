Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E674B6E46
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbiBOOEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:04:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiBOOEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:04:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F4B2C66A;
        Tue, 15 Feb 2022 06:04:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D115161745;
        Tue, 15 Feb 2022 14:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D82AC340EB;
        Tue, 15 Feb 2022 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644933868;
        bh=355sKNy7QprICvidLmVg5A/VTWtCgubbSjFyGihoFQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6U7CNYgyGcaTMDAHdmMDrZiAAmQI11fdOjdK1TpR0/ahCxPqvnHgSbqaCHOGDqA7
         MvQVbTXf1S/YngCd1hBQUhmtyVhKkEsVYig11lrKTnFNU+vM565uueqsBQ5eTaK3HH
         tk1CJ0/bRJYu3a3LroDR3iLI5Zx23lA2oe1QT+mk=
Date:   Tue, 15 Feb 2022 15:04:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     hminas@synopsys.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        amelie.delaunay@foss.st.com, alexandre.torgue@foss.st.com
Subject: Re: [PATCH v2] usb: dwc2: drd: fix soft connect when gadget is
 unconfigured
Message-ID: <Yguy5OMW477VmMuv@kroah.com>
References: <1644923059-3619-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644923059-3619-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 12:04:19PM +0100, Fabrice Gasnier wrote:
> When the gadget driver hasn't been (yet) configured, and the cable is
> connected to a HOST, the SFTDISCON gets cleared unconditionally, so the
> HOST tries to enumerate it.
> At the host side, this can result in a stuck USB port or worse. When
> getting lucky, some dmesg can be observed at the host side:
>  new high-speed USB device number ...
>  device descriptor read/64, error -110
> 
> Fix it in drd, by checking the enabled flag before calling
> dwc2_hsotg_core_connect(). It will be called later, once configured,
> by the normal flow:
> - udc_bind_to_driver
>  - usb_gadget_connect
>    - dwc2_hsotg_pullup
>      - dwc2_hsotg_core_connect
> 
> Fixes: 17f934024e84 ("usb: dwc2: override PHY input signals with usb role switch support")
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in v2:
> - Fix build error: 'struct dwc2_hsotg' has no member named 'enabled';
>   as reported by the kernel test robot.
>   https://lore.kernel.org/all/202202112236.AwoOTtHO-lkp@intel.com/
>   Add dwc2_is_device_enabled() macro to handle this.
> ---
>  drivers/usb/dwc2/core.h | 2 ++
>  drivers/usb/dwc2/drd.c  | 6 ++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
> index 8a63da3..8a7751b 100644
> --- a/drivers/usb/dwc2/core.h
> +++ b/drivers/usb/dwc2/core.h
> @@ -1418,6 +1418,7 @@ void dwc2_hsotg_core_connect(struct dwc2_hsotg *hsotg);
>  void dwc2_hsotg_disconnect(struct dwc2_hsotg *dwc2);
>  int dwc2_hsotg_set_test_mode(struct dwc2_hsotg *hsotg, int testmode);
>  #define dwc2_is_device_connected(hsotg) (hsotg->connected)
> +#define dwc2_is_device_enabled(hsotg) ((hsotg)->enabled)

Why the extra ()?  dwc2_is_device_connected does not have it, so this
one probably should not either, right?

thanks,

greg k-h
