Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA47522670
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 23:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiEJVno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 17:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiEJVnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 17:43:41 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C406024F0CD
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:43:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id p18so349726edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JE1ryK3sFFaZpqLHuF4NT4pM8/q2oJCkuMH2NRrxWwk=;
        b=UMCjE/GJyeRlpXcLvxAjSgAKgcgANfb//EG2WUd71BZf+62ZGEjKPE+xFJHNrgi25q
         f/nnP8NBmQAIYJOomN7He1W39UCjnMwXBbwlO4gflTisczQg9XlhUlyVT4rvsCLdU2zp
         qnyPa9oPLPuPspS+y0RzhTOQVDFihYiyLymU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JE1ryK3sFFaZpqLHuF4NT4pM8/q2oJCkuMH2NRrxWwk=;
        b=vpvjondRe6ulmLmezmpvTEdpmOTIvgsNyt/JqSjwFtpRLXkvT0K0q72Y45Nrw+2E/r
         n1SlBsQBmxzIqcpA5oRp8zPfsRfre5Zr2+8CFJiKhPdhmE+RcbfRamNaLNWvnXdIcg4q
         lrPLf/PX18XXkrYlKztLSTQGl2qO1TjyWl/+q26zC1/xR30R94PQQ8jB4cP0GgmE+yfH
         E4i8PVeZGBiENyMdhX3Vm450bvutc8VIZcXRaXsQnQgXGY8anOQUh4eK5KN6HlOuQbqf
         FnHfKXzVTOqsppZDCFOdIIoqUChzfUiZgvIqH3HILx9TtePYV78BaQORbDMFMDTIeQMW
         z2xA==
X-Gm-Message-State: AOAM532MgIeNdSnIZoUrPo8RQ34u2ekmncqCc29xKtuMtoSffAjS44/z
        UwB0R7zbX/RSW8dOVmojxwctbF+O+h9sME+BX+g=
X-Google-Smtp-Source: ABdhPJxfHtg9yaHIZnJex8opZvMW/GFp1UjPvHmsExEUwmHuGG+iCX+vAT7pRfuGOWE9NsxM64wIoA==
X-Received: by 2002:aa7:dcd5:0:b0:425:e49f:db86 with SMTP id w21-20020aa7dcd5000000b00425e49fdb86mr25624592edu.202.1652219018072;
        Tue, 10 May 2022 14:43:38 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id u15-20020aa7db8f000000b004275cef32efsm175048edt.6.2022.05.10.14.43.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 14:43:37 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so166044wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:43:37 -0700 (PDT)
X-Received: by 2002:a05:600c:4f13:b0:394:8978:7707 with SMTP id
 l19-20020a05600c4f1300b0039489787707mr1887184wmq.34.1652219016683; Tue, 10
 May 2022 14:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220510104656.1.Id98b473e08c950f9a461826dde187ef7705a928c@changeid>
 <CAD=FV=U33QSjnD7ERdVBb+hk4yooGU5=C0FtnhFsDME_MePR0w@mail.gmail.com> <YnrZQ4ggqxjlacL1@google.com>
In-Reply-To: <YnrZQ4ggqxjlacL1@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 10 May 2022 14:43:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VNNP0k_xS=qDUrO2jyNG3r=HB4nz+C0uRZLDBiBuCYZg@mail.gmail.com>
Message-ID: <CAD=FV=VNNP0k_xS=qDUrO2jyNG3r=HB4nz+C0uRZLDBiBuCYZg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Set modem FW path for Chrome OS boards
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 10, 2022 at 2:29 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Tue, May 10, 2022 at 12:49:30PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, May 10, 2022 at 10:47 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > >
> > > Specify the path of the modem FW for SC7280 Chrome OS boards in
> > > the 'remoteproc_mpss' node.
> > >
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > >
> > >  arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > > index 9f4a9c263c35..995c5bd12549 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > > @@ -89,6 +89,8 @@ &remoteproc_mpss {
> > >         compatible = "qcom,sc7280-mss-pil";
> > >         iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
> > >         memory-region = <&mba_mem>, <&mpss_mem>;
> > > +       firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
> > > +                       "qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
> >
> > We don't necessarily need to change anything, but a few thoughts:
> >
> > 1. I guess technically we don't actually need the "modem" subdirectory
> > for herobrine, right? WiFi works differently on sc7280 so we won't
> > have a "no modem" modem firmware. ...but I guess it doesn't hurt to
> > have it and it's nice to keep it symmetric.
>
> Yeah, it seems nice to keep it symmetric and also indicate for what
> kind of device the firmware is for. 'sc7280-herobrine' (or
> 'sc7280-chrome') doesn't reveal that.
>
> > 2. Whenever we're ready to support WiFi only SKUs then I guess it'll
> > still be OK to specify the firmware name. We'll just set the status of
> > "&mdss_dp" to "disabled".
>
> Yes, specifying the FW name is not a problem. Either we'll set the
> status of 'remoteproc_mpss' to 'disabled' or have a DT snippet for
> the modem that is only included for SKUs with a modem.
>
> > 3. It's slightly weird that we're using the name "herobrine" but
> > putting the change in the "chrome-common.dtsi" file. Should it be
> > "sc7280-chrome" instead?
>
> Currently OS images have the FW in 'qcom/sc7280-herobrine', but we
> could change that if desired. If we change the path we could also
> consider to change it to 'qcom/sc7280-q6v5' or 'qcom/sc7280-mpss'
> instead of 'qcom/sc7280-chrome/modem'.

OK. I'm OK w/ it being "qcom/sc7280-herobrine". So I guess:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
