Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C435A1C12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243612AbiHYWRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiHYWRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:17:02 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBFB2F004
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:17:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u22so2289plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=vBeKGRK+cVut8bnT/6A/lBEbRGscI4sDYwtvLgwZl6U=;
        b=F2p4W6OpYD0wiVHVa4HW9N6SRDY4WeCbz0KXJ48rzzY498kDUBYTVxhaII6smH2bl7
         pcIcQkWepEKfD5Kjjj3kYSawEceO4eGv+SGFZjIZ0JOoAIjgbJoaiiiekqXOFQ71QRRK
         uHY1EooZ5DsTIyZdDCXnakFYtopCAu+rSEDVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=vBeKGRK+cVut8bnT/6A/lBEbRGscI4sDYwtvLgwZl6U=;
        b=sjgGVDl5NBHwgYF9bN9bVbx5XJr4Sg5Xtme5+Gu7xO2Hlk8Z3ebhtLgAeJ5YWMAdLS
         g6RFL+9gJEnaOIXUgxvgnbnCEyzlqhhwuK406h5MtT19TMLjfVq91Iu4oT5PBEb5F28o
         Z5UQXLCO3OO0SVwEW4Gmr9F0zGwf8HZvLLx7E+NrCEmG6bgfO6alpmvu54phMvopH75p
         hMi4mBFwSphZw2NZHBmt2Vx3KVVfKNle5wz+Mu+TxHJihsopdwzVc7vTg0XrEdqQNpoz
         D+g3YTrrzUCAa7Jr6JcYV4epWeOMPWBAKlOHpUVof7MJ62VrIT0gL20d8gMoGuTOjViC
         m4bg==
X-Gm-Message-State: ACgBeo3mc/4td6xrZbUv068ncvCRYITwb2tGu78zCQAq9cNp9p0vX2yJ
        +NSY+mRiu5IwG3qpkK3Xs6DDWg==
X-Google-Smtp-Source: AA6agR5G1m9x4dJMFRPTSXgA6jT+Mbg6vfutpOV+lyq4yqeuTtNPsN56w4DyMpOhxmehjU5CznzYcg==
X-Received: by 2002:a17:90a:7805:b0:1fa:bdab:7d59 with SMTP id w5-20020a17090a780500b001fabdab7d59mr1141849pjk.37.1661465820535;
        Thu, 25 Aug 2022 15:17:00 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:d529:f79d:2a1a:4e61])
        by smtp.gmail.com with UTF8SMTPSA id w9-20020a17090a15c900b001fa9f86f20csm213319pjd.49.2022.08.25.15.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 15:17:00 -0700 (PDT)
Date:   Thu, 25 Aug 2022 15:16:58 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Johan Hovold <johan@kernel.org>
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
Message-ID: <Ywf02oIXEL8G/Heo@google.com>
References: <20220822115246.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
 <20220822115246.2.If09027f73daa6e1ed95f5eab02326b543c67132e@changeid>
 <YwS3FCOqIeajMEgz@hovoldconsulting.com>
 <YwUDjaG6n95Ddij2@google.com>
 <YwXlsK3pjK/q1xwO@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwXlsK3pjK/q1xwO@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 10:47:44AM +0200, Johan Hovold wrote:
> On Tue, Aug 23, 2022 at 09:42:53AM -0700, Matthias Kaehlcke wrote:
> > On Tue, Aug 23, 2022 at 01:16:36PM +0200, Johan Hovold wrote:
> > > On Mon, Aug 22, 2022 at 11:53:11AM -0700, Matthias Kaehlcke wrote:
> > > > Set GENPD_FLAG_ACTIVE_WAKEUP for the USB GDSC power domains of SC7280.
> > > > 
> > > > Suggested-by: Johan Hovold <johan+linaro@kernel.org>
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > ---
> > > > 
> > > >  drivers/clk/qcom/gcc-sc7280.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
> > > > index 7ff64d4d5920..4ff855269467 100644
> > > > --- a/drivers/clk/qcom/gcc-sc7280.c
> > > > +++ b/drivers/clk/qcom/gcc-sc7280.c
> > > > @@ -3125,6 +3125,7 @@ static struct gdsc gcc_usb30_prim_gdsc = {
> > > >  	.gdscr = 0xf004,
> > > >  	.pd = {
> > > >  		.name = "gcc_usb30_prim_gdsc",
> > > > +		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
> > > 
> > > Have you verified that the power-domain doesn't need to remain on also
> > > when USB isn't used for wakeup?
> > 
> > So far I haven't observed issues with this on sc7180 and sc7280 when USB
> > wakeup is disabled.
> 
> Ok, good.
> 
> I would have assumed that it needed to stay always-on before the
> s/device_can_wakeup/device_may_wakeup/ change as before that the PHYs
> would be left on regardless of the (sysfs) wakeup setting.

That make sense, not sure why GENPD_FLAG_ACTIVE_WAKEUP works with wakeup
disabled.

In any case setting the genpd flags directly in the gdsc descriptor doesn't
seem to be the right thing to do. With GENPD_FLAG_ALWAYS_ON my sc7280 system
stalls at boot. It boots when ALWAYS_ON is set in the gdsc flags, which ends
up setting GENPD_FLAG_ALWAYS_ON of the genpd. I'll send a new version of this
series which sets the correct flag.

> > > This is the case for sc8280xp and indicates that there are further
> > > missing pieces here (at least for that platform).
> > 
> > What are you observing on sc8280xp when wakeup is disabled?
> 
> The wakeup setting doesn't seem to have anything to do with the genpd
> issues on sc8280xp and the controller doesn't resume properly regardless
> of whether the PHYs have been disabled or not during suspend unless the
> PD is left on.

I'm essentially seeing the same. USB is hosed after resume unless the PD
is left on.

On Chrome OS we currently work around that with a version of commit
d9be8d5c5b03 ("usb: dwc3: qcom: Keep power domain on to retain controller
status") which was reverted upstream. I'm not sure whether USB worked after
resume before we enabled wakeup support. I would have sworn it did, but we
landed an old version of the wakeup patches a long time ago, so my
memory might be failing me.

I wonder what the status on other QC platforms is, from a quick grep it
seems only msm8953 sets the USB gdsc to ALWAYS_ON.
