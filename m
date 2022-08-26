Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFFB5A2839
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343937AbiHZNFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343953AbiHZNFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:05:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0621F623
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:05:22 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 202so1350302pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=CHTCunlpvy9js5sdVWAAlZTqUYUZ7Iaa0wqOedrNwHI=;
        b=h3HcFtjP7/AnVHUZVv1r9YFQtSPge8mn4LlAXrSafWS5Ym1Y0N0FWtnK715/Ty5FNp
         pQquKsGavtHhFQQEOpmxzZHkFlDUxkZBI63wz71Nb/uGvSzDZk/fGsPSv7krJWyXzV27
         fpUOmVpwZTUZayOZ1dez3L0at8LJzcHKOPyd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=CHTCunlpvy9js5sdVWAAlZTqUYUZ7Iaa0wqOedrNwHI=;
        b=emoGe4pJdVFm0qS+S08z5zFFcf3Hq49ykViOn1FQDCQuYYHVJlTG8ZbGVWYCNjy+Fj
         16GpJlI4KhHQ/uMgnGacNj1zJiNKb5jl8+vaYlfh07mjofJrqgczB5TooJEeZ14tgi+N
         eEJ0SK3rPQQV1HaBwOfNz5OVqpJEGZbDXlERovoBm5OyXArtKNnqPGvICu49dyEn4zxj
         OE6sEVKScaqvU01Mjz1bjblRReoyje5NBDUV2pGFJ0bYJETQA7zark+Cs7gVIYS6AxZN
         ri0Iip4wpfOgoa2Z61T7FvAX6HDnvwLcH3N1pCffta2j03mbieXyh494LQrkN+3n6p2K
         E9dw==
X-Gm-Message-State: ACgBeo3YJwSYgKzWLL4jipkimZIuSbU+o3N9q4lhan/DgAoHoN1dnNFX
        gWpoUZRMVqq8xgCbuaYAGQbm0Q==
X-Google-Smtp-Source: AA6agR6QMXVT+Is/zY+vj5eb09KzV5ldD7r7frhK93V8Wk7JvJLzRo44KiYFalLZ5j50lg3iDeTnEw==
X-Received: by 2002:a63:6b05:0:b0:41c:2216:d2b2 with SMTP id g5-20020a636b05000000b0041c2216d2b2mr3300925pgc.118.1661519121548;
        Fri, 26 Aug 2022 06:05:21 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:2a3c:773f:ac25:a127])
        by smtp.gmail.com with UTF8SMTPSA id o9-20020a17090a4b4900b001fbb0f0b00fsm1570275pjl.35.2022.08.26.06.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 06:05:21 -0700 (PDT)
Date:   Fri, 26 Aug 2022 06:05:19 -0700
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
Message-ID: <YwjFD9uHnSxoZHvT@google.com>
References: <20220822115246.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
 <20220822115246.2.If09027f73daa6e1ed95f5eab02326b543c67132e@changeid>
 <YwS3FCOqIeajMEgz@hovoldconsulting.com>
 <YwUDjaG6n95Ddij2@google.com>
 <YwXlsK3pjK/q1xwO@hovoldconsulting.com>
 <Ywf02oIXEL8G/Heo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ywf02oIXEL8G/Heo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
> 
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
> 
> On Chrome OS we currently work around that with a version of commit
> d9be8d5c5b03 ("usb: dwc3: qcom: Keep power domain on to retain controller
> status") which was reverted upstream. I'm not sure whether USB worked after
> resume before we enabled wakeup support. I would have sworn it did, but we
> landed an old version of the wakeup patches a long time ago, so my
> memory might be failing me.

I need to remind myself that keeping the GDSC on is only needed when the PHYs
are kept on. The PHYs were always off before wakeup support was added, which
is why USB wasn't broken after suspend in the pre-wakeup days.

> I wonder what the status on other QC platforms is, from a quick grep it
> seems only msm8953 sets the USB gdsc to ALWAYS_ON.
