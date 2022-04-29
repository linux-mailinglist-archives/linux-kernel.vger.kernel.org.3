Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7589515076
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378869AbiD2QNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378889AbiD2QNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:13:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5BA3EBB3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:10:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y3so16290668ejo.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38G2yLvTesO/mAjiyLWZJ7vMR9eg3xKJsvKaGBhlj48=;
        b=Z6/QtEfer9f+OTdeWiWLTDLQrtwaSk794Vgsbs8yANjijC/n6xI7dAdrszE6zXzZs3
         eDk12zl2F8a46AyeYidW8tq2bsM7D0pA7biW1+/+uO/MCZkgqGi0OHA0fOrQzuzRKcVd
         w63F5C7NaCxtPl8jO7Bxi1shpsUpt6qi/ApdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38G2yLvTesO/mAjiyLWZJ7vMR9eg3xKJsvKaGBhlj48=;
        b=IFfEJSeKrD6EjkIzAX3BHvNgClHoD8UU7m3I3UNSWi0e8Ag3dz7S+hKnEoCurTlSri
         pd1XMiaW2JDVXij3BCJWRfwI2p4uY0utlzZhPNQxWELkv9YZGraGQNolhK9/T0zsvDT+
         15lmxDjDuDSDJEhVU/KT2yDTKiXFBM/78fqxADlOGo0e9eKT7rQQAV6uj/4/M+OZZMgL
         E560+7gTLNx2ZjSi23ocVtUOl4J6OP8Zm/gjQl3kYN7RFFj+RLVwxAYUifbVcQan9ePu
         opJTMH4fi9m6smGLQY8iEcrapBMhZvOWyoZ6gwIXg4stBBAQt3OxH2+T0615WHTkBrGl
         vbmw==
X-Gm-Message-State: AOAM530tNZlMLB/9LEeiiNcQGjG0ginCOjE1eW9KSkxvxCR43058XmXZ
        Ia22Lio8s1gzR4uJYvJUyo1czEFoLUPGGKNa
X-Google-Smtp-Source: ABdhPJzhTA4vJJF7ezTYK7WvgnY1F1Sr/DhVMhRUIjr8gNVbV3GLKoFP2cjkz6ioA1fNXGC7BLDnRg==
X-Received: by 2002:a17:907:3f02:b0:6f3:5c42:321a with SMTP id hq2-20020a1709073f0200b006f35c42321amr13715ejc.521.1651248620531;
        Fri, 29 Apr 2022 09:10:20 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id qx16-20020a170907b59000b006f3ef214e60sm770061ejc.198.2022.04.29.09.10.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 09:10:20 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id x18so11452660wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:10:19 -0700 (PDT)
X-Received: by 2002:adf:f50d:0:b0:20a:e096:ef with SMTP id q13-20020adff50d000000b0020ae09600efmr17925110wro.679.1651248619233;
 Fri, 29 Apr 2022 09:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <1651079383-7665-1-git-send-email-quic_srivasam@quicinc.com>
 <1651079383-7665-5-git-send-email-quic_srivasam@quicinc.com> <YmsrB6Q89II5w1+9@google.com>
In-Reply-To: <YmsrB6Q89II5w1+9@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 29 Apr 2022 09:10:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XxeZsiOVVBDK_vmx0nhT7roB2FqcaPXsH3+jzTHFXMxw@mail.gmail.com>
Message-ID: <CAD=FV=XxeZsiOVVBDK_vmx0nhT7roB2FqcaPXsH3+jzTHFXMxw@mail.gmail.com>
Subject: Re: [PATCH v12 4/4] arm64: dts: qcom: sc7280-herobrine: Add lpi
 pinmux properties for CRD 3.0/3.1
To:     Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        quic_rohkumar@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 28, 2022 at 5:02 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Wed, Apr 27, 2022 at 10:39:43PM +0530, Srinivasa Rao Mandadapu wrote:
> > Add LPASS LPI pinctrl properties, which are required for Audio
> > functionality on herobrine based platforms of rev5+
> > (aka CRD 3.0/3.1) boards.
> >
> > Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> > Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> > Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>
> I'm not super firm in pinctrl territory, a few maybe silly questions
> below.
>
> >  arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 84 +++++++++++++++++++++++
> >  1 file changed, 84 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> > index deaea3a..dfc42df 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> > @@ -111,6 +111,90 @@ ap_ts_pen_1v8: &i2c13 {
> >   * - If a pin is not hooked up on Qcard, it gets no name.
> >   */
> >
> > +&lpass_dmic01 {
> > +     clk {
> > +             drive-strength = <8>;
> > +     };

Ugh, I've been distracted and I hadn't realized we were back to the
two-level syntax. Definitely not my favorite for all the reasons I
talked about [1]. I guess you took Bjorn's silence to my response to
mean that you should switch back to this way? :(

Bjorn: can you clarify?

[1] https://lore.kernel.org/r/CAD=FV=VicFiX6QkBksZs1KLwJ5x4eCte6j5RWOBPN+WwiXm2Cw@mail.gmail.com/

> > +};
> > +
> > +&lpass_dmic01_sleep {
> > +     clk {
> > +             drive-strength = <2>;
>
> Does the drive strength really matter in the sleep state, is the SoC actively
> driving the pin?

My understanding is that if a pin is left as an output in sleep state
that there is a slight benefit to switching it to drive-strength 2.


> > +             bias-disable;
>
> What should this be in active/default state? If I understand correctly
> after a transition from 'sleep' to 'default' this setting will remain,
> since the default config doesn't specify a setting for bias.

Your understanding matches mine but I haven't tested it and I remember
sometimes being surprised in this corner of pinmux before. I think
it's better to put the bias in the default state if it should be that
way all the time, or have a bias in both the default and sleep state
if they need to be different.
