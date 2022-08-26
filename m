Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03ED5A217A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245105AbiHZHMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiHZHMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:12:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8598DC04CA;
        Fri, 26 Aug 2022 00:12:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C5C8B82F0D;
        Fri, 26 Aug 2022 07:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF99BC433D6;
        Fri, 26 Aug 2022 07:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661497923;
        bh=kt9JPLC7CCExSXRZP3B3Wuc6p/ol2wlUIiF6Mx920cY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOIyLxoTBtPfoPkZ1fEpC8lLHH9HEQ45oxTFNAyrOCgvvgM4Pk3sFb4O/DehvstRX
         NQNc5d9w1thudV4z3KkGq5qz79AYwOv4oF0ubvUZOq2BWmSe4Yrt+WeVZvi6g9e6Yy
         r6kez22pAFvaQAv5P8Im+vG8fWXCsGBZh+2n1V8j3yakNicCLBzLR+L2PrXNm0PTjm
         5sAOnlnv7haOjBHnZJFw5T6DhAZAVCxaOmBUVz1riv7VlBNKoo1FlxZPiFDmS4HpYX
         YkaJ1TZG6jfrlFgLzl7xkMWWC4jci8hXX11ltNvVQAH+XOvsNxWUTvNOiFJLpAuEg+
         Di2cKANXXGtKw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oRTVj-0000oJ-J0; Fri, 26 Aug 2022 09:12:11 +0200
Date:   Fri, 26 Aug 2022 09:12:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/2] clk: qcom: gcc-sc7280: Keep USB GDSC power domains
 on when USB wakeup is enabled
Message-ID: <YwhyS7a8djIFPSOq@hovoldconsulting.com>
References: <20220822115246.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
 <20220822115246.2.If09027f73daa6e1ed95f5eab02326b543c67132e@changeid>
 <YwS3FCOqIeajMEgz@hovoldconsulting.com>
 <YwUDjaG6n95Ddij2@google.com>
 <YwXlsK3pjK/q1xwO@hovoldconsulting.com>
 <Ywf02oIXEL8G/Heo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ywf02oIXEL8G/Heo@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 03:16:58PM -0700, Matthias Kaehlcke wrote:
> On Wed, Aug 24, 2022 at 10:47:44AM +0200, Johan Hovold wrote:
> > On Tue, Aug 23, 2022 at 09:42:53AM -0700, Matthias Kaehlcke wrote:
> > > On Tue, Aug 23, 2022 at 01:16:36PM +0200, Johan Hovold wrote:
> > > > On Mon, Aug 22, 2022 at 11:53:11AM -0700, Matthias Kaehlcke wrote:
> > > > > Set GENPD_FLAG_ACTIVE_WAKEUP for the USB GDSC power domains of SC7280.
> > > > > 
> > > > > Suggested-by: Johan Hovold <johan+linaro@kernel.org>
> > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > ---
> > > > > 
> > > > >  drivers/clk/qcom/gcc-sc7280.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
> > > > > index 7ff64d4d5920..4ff855269467 100644
> > > > > --- a/drivers/clk/qcom/gcc-sc7280.c
> > > > > +++ b/drivers/clk/qcom/gcc-sc7280.c
> > > > > @@ -3125,6 +3125,7 @@ static struct gdsc gcc_usb30_prim_gdsc = {
> > > > >  	.gdscr = 0xf004,
> > > > >  	.pd = {
> > > > >  		.name = "gcc_usb30_prim_gdsc",
> > > > > +		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
> > > > 
> > > > Have you verified that the power-domain doesn't need to remain on also
> > > > when USB isn't used for wakeup?
> > > 
> > > So far I haven't observed issues with this on sc7180 and sc7280 when USB
> > > wakeup is disabled.
> > 
> > Ok, good.
> > 
> > I would have assumed that it needed to stay always-on before the
> > s/device_can_wakeup/device_may_wakeup/ change as before that the PHYs
> > would be left on regardless of the (sysfs) wakeup setting.
> 
> That make sense, not sure why GENPD_FLAG_ACTIVE_WAKEUP works with wakeup
> disabled.
> 
> In any case setting the genpd flags directly in the gdsc descriptor doesn't
> seem to be the right thing to do. With GENPD_FLAG_ALWAYS_ON my sc7280 system
> stalls at boot. It boots when ALWAYS_ON is set in the gdsc flags, which ends
> up setting GENPD_FLAG_ALWAYS_ON of the genpd. I'll send a new version of this
> series which sets the correct flag.

Yes, GENPD_FLAG_ALWAYS_ON needs to be set via the gdsc ALWAYS_ON flag as
genpd expects the PD to be on when registered or else it silently errors
out...

	https://lore.kernel.org/all/20220805121250.10347-3-johan+linaro@kernel.org/

> > > > This is the case for sc8280xp and indicates that there are further
> > > > missing pieces here (at least for that platform).
> > > 
> > > What are you observing on sc8280xp when wakeup is disabled?
> > 
> > The wakeup setting doesn't seem to have anything to do with the genpd
> > issues on sc8280xp and the controller doesn't resume properly regardless
> > of whether the PHYs have been disabled or not during suspend unless the
> > PD is left on.
> 
> I'm essentially seeing the same. USB is hosed after resume unless the PD
> is left on.

Thanks for confirming.
 
> On Chrome OS we currently work around that with a version of commit
> d9be8d5c5b03 ("usb: dwc3: qcom: Keep power domain on to retain controller
> status") which was reverted upstream. I'm not sure whether USB worked after
> resume before we enabled wakeup support. I would have sworn it did, but we
> landed an old version of the wakeup patches a long time ago, so my
> memory might be failing me.
> 
> I wonder what the status on other QC platforms is, from a quick grep it
> seems only msm8953 sets the USB gdsc to ALWAYS_ON.

Yes, this is likely needed on other platforms as well.

Johan
