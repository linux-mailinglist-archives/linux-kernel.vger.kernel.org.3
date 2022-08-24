Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E1B59F5AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiHXIsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbiHXIsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:48:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABEA7AC00;
        Wed, 24 Aug 2022 01:47:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25F12617AE;
        Wed, 24 Aug 2022 08:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FF0C433D6;
        Wed, 24 Aug 2022 08:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661330862;
        bh=KsYrz7x6IcbX0pgtIwi510gAC8itg404yw0MYtsog74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y1M0khDi+IP4HCcNiZ09RpeBhBSSog68O8ucahvlGBkZvemyAPXzntTYDV4/LPl3l
         ZkOPnxhflT6SNwsh/b5C6qsFvpoh0Z2tFNBesdyWWdJnVR2s3O1OcwSUAxBIKlLhxD
         kGmpQOD427tZJwa3JpjmaGD8L45/ttt9tMNwK7W9aR0dL89OcNh1r08tiKzw94fGO3
         1xCGDta2tFX+SyenXianEog0Zam0s3gJPjGvYVbiOD4/i7bhD+juUjv2BL4+SSX/L8
         SEYJFX1yY4FMpyjyhF/gUbI8L5KLHg+SGb0QPLrNqBm1kMEGdv3nH6rI2SNDj3R4JS
         dwJbRsEWOk5lg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oQm36-0004ZD-Cb; Wed, 24 Aug 2022 10:47:45 +0200
Date:   Wed, 24 Aug 2022 10:47:44 +0200
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
Message-ID: <YwXlsK3pjK/q1xwO@hovoldconsulting.com>
References: <20220822115246.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
 <20220822115246.2.If09027f73daa6e1ed95f5eab02326b543c67132e@changeid>
 <YwS3FCOqIeajMEgz@hovoldconsulting.com>
 <YwUDjaG6n95Ddij2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwUDjaG6n95Ddij2@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 09:42:53AM -0700, Matthias Kaehlcke wrote:
> On Tue, Aug 23, 2022 at 01:16:36PM +0200, Johan Hovold wrote:
> > On Mon, Aug 22, 2022 at 11:53:11AM -0700, Matthias Kaehlcke wrote:
> > > Set GENPD_FLAG_ACTIVE_WAKEUP for the USB GDSC power domains of SC7280.
> > > 
> > > Suggested-by: Johan Hovold <johan+linaro@kernel.org>
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > 
> > >  drivers/clk/qcom/gcc-sc7280.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
> > > index 7ff64d4d5920..4ff855269467 100644
> > > --- a/drivers/clk/qcom/gcc-sc7280.c
> > > +++ b/drivers/clk/qcom/gcc-sc7280.c
> > > @@ -3125,6 +3125,7 @@ static struct gdsc gcc_usb30_prim_gdsc = {
> > >  	.gdscr = 0xf004,
> > >  	.pd = {
> > >  		.name = "gcc_usb30_prim_gdsc",
> > > +		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
> > 
> > Have you verified that the power-domain doesn't need to remain on also
> > when USB isn't used for wakeup?
> 
> So far I haven't observed issues with this on sc7180 and sc7280 when USB
> wakeup is disabled.

Ok, good.

I would have assumed that it needed to stay always-on before the
s/device_can_wakeup/device_may_wakeup/ change as before that the PHYs
would be left on regardless of the (sysfs) wakeup setting.

> > This is the case for sc8280xp and indicates that there are further
> > missing pieces here (at least for that platform).
> 
> What are you observing on sc8280xp when wakeup is disabled?

The wakeup setting doesn't seem to have anything to do with the genpd
issues on sc8280xp and the controller doesn't resume properly regardless
of whether the PHYs have been disabled or not during suspend unless the
PD is left on.

Wakeup itself notably works either way.

Johan
