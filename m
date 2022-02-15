Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDB84B775C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242439AbiBORTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:19:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbiBORTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:19:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E145D1AF33;
        Tue, 15 Feb 2022 09:19:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DBCCB81BD1;
        Tue, 15 Feb 2022 17:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD143C340EB;
        Tue, 15 Feb 2022 17:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644945563;
        bh=+n6mRRBEYWRJAd6xR7iQWKIB+Wl/GVSfhc9EU4PluQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjF7ZVnX9OMxBAIgrWHui3/2VLDtgcJF5du3s1ed48kTCTZdfqvCcT4ai8AGVVKea
         kKqvO1K4VR8WN3RT6H59DMHGQ/HwxhNNN2/UKjajgLMYelGR9kHKle+VuzQKVyWpiM
         A0UqbTJ3lL5BqdxZT36RoxRrPEpVD6RmJyU3PfiY=
Date:   Tue, 15 Feb 2022 18:19:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     hminas@synopsys.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        amelie.delaunay@foss.st.com, alexandre.torgue@foss.st.com
Subject: Re: [PATCH v2] usb: dwc2: drd: fix soft connect when gadget is
 unconfigured
Message-ID: <Ygvgl1SXevlyzz8t@kroah.com>
References: <1644923059-3619-1-git-send-email-fabrice.gasnier@foss.st.com>
 <Yguy5OMW477VmMuv@kroah.com>
 <dab7c8fe-0cf5-66a6-bf84-25fe84b4a221@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dab7c8fe-0cf5-66a6-bf84-25fe84b4a221@foss.st.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 04:42:46PM +0100, Fabrice Gasnier wrote:
> On 2/15/22 3:04 PM, Greg KH wrote:
> > On Tue, Feb 15, 2022 at 12:04:19PM +0100, Fabrice Gasnier wrote:
> >> When the gadget driver hasn't been (yet) configured, and the cable is
> >> connected to a HOST, the SFTDISCON gets cleared unconditionally, so the
> >> HOST tries to enumerate it.
> >> At the host side, this can result in a stuck USB port or worse. When
> >> getting lucky, some dmesg can be observed at the host side:
> >>  new high-speed USB device number ...
> >>  device descriptor read/64, error -110
> >>
> >> Fix it in drd, by checking the enabled flag before calling
> >> dwc2_hsotg_core_connect(). It will be called later, once configured,
> >> by the normal flow:
> >> - udc_bind_to_driver
> >>  - usb_gadget_connect
> >>    - dwc2_hsotg_pullup
> >>      - dwc2_hsotg_core_connect
> >>
> >> Fixes: 17f934024e84 ("usb: dwc2: override PHY input signals with usb role switch support")
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> >> ---
> >> Changes in v2:
> >> - Fix build error: 'struct dwc2_hsotg' has no member named 'enabled';
> >>   as reported by the kernel test robot.
> >>   https://lore.kernel.org/all/202202112236.AwoOTtHO-lkp@intel.com/
> >>   Add dwc2_is_device_enabled() macro to handle this.
> >> ---
> >>  drivers/usb/dwc2/core.h | 2 ++
> >>  drivers/usb/dwc2/drd.c  | 6 ++++--
> >>  2 files changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
> >> index 8a63da3..8a7751b 100644
> >> --- a/drivers/usb/dwc2/core.h
> >> +++ b/drivers/usb/dwc2/core.h
> >> @@ -1418,6 +1418,7 @@ void dwc2_hsotg_core_connect(struct dwc2_hsotg *hsotg);
> >>  void dwc2_hsotg_disconnect(struct dwc2_hsotg *dwc2);
> >>  int dwc2_hsotg_set_test_mode(struct dwc2_hsotg *hsotg, int testmode);
> >>  #define dwc2_is_device_connected(hsotg) (hsotg->connected)
> >> +#define dwc2_is_device_enabled(hsotg) ((hsotg)->enabled)
> > 
> > Why the extra ()?  dwc2_is_device_connected does not have it, so this
> > one probably should not either, right?
> 
> Hi Greg,
> 
> I was wondering the same, checkpatch complains without it:
> 
> CHECK: Macro argument 'hsotg' may be better as '(hsotg)' to avoid
> precedence issues

checkpatch is wrong here, this is a structure pointer, not anything you
could ever use that could be evaluated any other way.

> I can remove the extra () in a v3 if you wish ?

Please do.

thanks,

greg k-h
