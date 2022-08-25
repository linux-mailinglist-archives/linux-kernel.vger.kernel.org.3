Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C284D5A11A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242345AbiHYNMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242311AbiHYNMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:12:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3974FAF498;
        Thu, 25 Aug 2022 06:12:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9B7B61CC9;
        Thu, 25 Aug 2022 13:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA8BC433C1;
        Thu, 25 Aug 2022 13:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661433166;
        bh=1A8MlJBKL7ti8oE6S1Sc5dQu/847fbAMiXE+ZJuXN9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fU3aclXUIEYOn0MawgcJtV4A3NGIP/JYDfL1LdFFrbU1kA9j0VT05sXbF8zlqj0Ue
         yMmu1lkhWWGaM+mLsyfEezG9y3zac/xlHC9upcwTFy/9RIzpRigRYX026qTxhuZxxI
         RlcK1Lr/SdnpXNkYZyLqqmz1svCWvyUPpzXOOztxhuHOW8rgARI/stawKmbdLQfP3G
         7cY4YRAfAm5KwBNhbCgpbXpwk9aTeAfhCo6MZSAOrgN94ms/TCoazXYgvfnC6dX/3D
         aMHB2LmlVDph5VveV1+ii1w6GijEibVivm5OwORRNQ8twFoihQpMgTqChOqbeMKTOp
         6QbcK2zObaZIg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oRCfE-00051D-0x; Thu, 25 Aug 2022 15:12:52 +0200
Date:   Thu, 25 Aug 2022 15:12:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: keep PHYs disabled during suspend
Message-ID: <Ywd1VBjbQTUeD+vD@hovoldconsulting.com>
References: <20220823124047.14634-1-johan+linaro@kernel.org>
 <YwUdbkyL8GgvLQJA@google.com>
 <YwXhANZ8l6E9yQDe@hovoldconsulting.com>
 <YwZUzeCTw2BupuMm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwZUzeCTw2BupuMm@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 09:41:49AM -0700, Matthias Kaehlcke wrote:
> On Wed, Aug 24, 2022 at 10:27:44AM +0200, Johan Hovold wrote:
> > On Tue, Aug 23, 2022 at 11:33:18AM -0700, Matthias Kaehlcke wrote:
> > > Hi Johan,
> > > 
> > > On Tue, Aug 23, 2022 at 02:40:47PM +0200, Johan Hovold wrote:
> > > > Commit 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system
> > > > suspend") started leaving the PHYs enabled during suspend for
> > > > wakeup-capable controllers even though it turns out this had nothing to
> > > > do with wakeup.
> > > > 
> > > > Rather, the wakeup capability flag was (ab-)used as a proxy to configure
> > > > the suspend behaviour in an attempt to reduce power leakage on some
> > > > platforms.
> > > > 
> > > > Stop abusing the wakeup configuration and restore the 5.19 behaviour of
> > > > keeping the PHYs powered off during suspend. If needed, a dedicated
> > > > mechanism for configuring the PHY power state during suspend can be
> > > > added later.
> > > > 
> > > > Fixes: 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system suspend")
> > > > Link: https://lore.kernel.org/r/Yuv7AM/5jtO/pgcm@google.com
> > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > > ---

> > > > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > > > index 9a94b1ab8f7a..9995395baa12 100644
> > > > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > > > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > > > @@ -904,7 +904,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
> > > >  
> > > >  	wakeup_source = of_property_read_bool(dev->of_node, "wakeup-source");
> > > >  	device_init_wakeup(&pdev->dev, wakeup_source);
> > > > -	device_init_wakeup(&qcom->dwc3->dev, wakeup_source);
> > > 
> > > Surprisingly this part breaks wakeup on sc7x80, with the above removal
> > > of the device_may_wakeup() checks it is not clear to me why wakeup needs
> > > to be enabled for the core.
> > 
> > I can't explain that behaviour either. This change doesn't affect the
> > wakeup_path flag and genpd, and notably wakeup still works here with
> > sc8280xp.

> It turns out the dwc3 core wakeup flags are evaluated by:
> 
> 	int usb_phy_roothub_suspend(struct device *controller_dev,
> 	                            struct usb_phy_roothub *phy_roothub)
> 	{
> 		usb_phy_roothub_power_off(phy_roothub);
> 
> 		/* keep the PHYs initialized so the device can wake up the system */
> 		if (device_may_wakeup(controller_dev))
> 			return 0;
> 
> 		return usb_phy_roothub_exit(phy_roothub);
> 	}
> 
> 'controller_dev' is the dwc3 core. The root hub is un-initialized when wakeup is
> disabled. That causes wakeup to fail, and also happens to be the/one cause of
> the high power consumption of an onboard USB hub that I mentioned earlier in
> another thread.

Bah, I forgot about the USB core PHY management mess. This should be
disabled as the dwc3 driver manages the PHYs itself.

But because it currently enabled, the PHY was kept powered-on by USB
core (unless dropping device_init_wakeup()) and this indicates that that
is indeed needed for wakeup on your platform.

So this patch should be dropped, and I'll send a patch disabling the USB
core PHY management for dwc3 instead.

Johan
