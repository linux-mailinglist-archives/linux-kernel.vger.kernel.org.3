Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8058533360
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242088AbiEXWOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbiEXWOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:14:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C949A5E15D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:14:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id n23so24869916edy.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+elu8HOIJCNzoXwM8a/Ht/vnqA4Rhu06lefXdgtds4=;
        b=NxzeGiHg0tvynMPU1vS1YvYZfw2jxq+By5KuaQiOGvVfhyOWodNcpbpFHt4+Pm6Tc7
         aqRwbLogqbuN8srCynyYLcrzgASJp8eqO8R1YtEq0cQXqb2UlIO+Q1woO+6TXoJsrXOa
         q+i6QwErpQZbWY5Vq5HLuD+yUYvBhPOmxiX6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+elu8HOIJCNzoXwM8a/Ht/vnqA4Rhu06lefXdgtds4=;
        b=q69krTxzoAeQQOtQbK0FIhtV09wGnbZiz6nw4rknws6WX8jWzKNTyjmdWIKgDysz16
         dTUus7wbPQ9O9ue2NknLcoad3PZe/p6odM5hK8RANJnb/kyfMbG57L+MvBBotHozc3DY
         z5UoFAoJxh8WuQHrYXNwWDNQLb/J2JjP6mkJCQuLnRg6ukavhiD2OUlhu+jnWclQjBh/
         2I2KiypV4qE7WnEiwcwjI4kRyb0pn7NhkbGySAXSN79mbidH3AOWM9aR1MnXV0R9QmXO
         YH9wzU/VZpYssvqGrjvVSCsohsp8KNBHFkZKEgBAxVWldG9RWBJCMRK1gPYmXYJHf2gB
         44ag==
X-Gm-Message-State: AOAM532S0RNdDON7as1UMqsRMWZZcmZZOn59e/GulEVcNCVHWgtttI6Q
        A47PAO9v0EccADMbTbyJpcWst23udaVuORcwP/s=
X-Google-Smtp-Source: ABdhPJyt2I9ZdmZUVy0LuuRBzsHwfFHpbfrmO3AR86Aq4ZjvZJW6A+Vp0yFjpAOEfdY0VXd+362+Fw==
X-Received: by 2002:a05:6402:144b:b0:42a:c86e:7ac8 with SMTP id d11-20020a056402144b00b0042ac86e7ac8mr31405812edx.175.1653430476018;
        Tue, 24 May 2022 15:14:36 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id f3-20020a1709063f4300b006f3ef214e6esm7576100ejj.212.2022.05.24.15.14.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 15:14:34 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id m20so16498635wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:14:34 -0700 (PDT)
X-Received: by 2002:a5d:6483:0:b0:20f:d046:6382 with SMTP id
 o3-20020a5d6483000000b0020fd0466382mr13173466wri.342.1653430473511; Tue, 24
 May 2022 15:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220524134840.1.I80072b8815ac08c12af8f379a33cc2d83693dc51@changeid>
 <311a23c9-e31d-e20d-8ba9-80d3197e8d1d@somainline.org>
In-Reply-To: <311a23c9-e31d-e20d-8ba9-80d3197e8d1d@somainline.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 May 2022 15:14:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WKgPWxEL+mhb9cCGOLObJEPtX_sHLQ1z3rz3usDG1m+Q@mail.gmail.com>
Message-ID: <CAD=FV=WKgPWxEL+mhb9cCGOLObJEPtX_sHLQ1z3rz3usDG1m+Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add touchscreen to villager
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 24, 2022 at 2:13 PM Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
>
> On 24/05/2022 22:48, Douglas Anderson wrote:
> > This adds the touchscreen to the sc7280-herobrine-villager device
> > tree. Note that the touchscreen on villager actually uses the reset
> > line and thus we use the more specific "elan,ekth6915" compatible
> > which allows us to specify the reset.
> >
> > The fact that villager's touchscreen uses the reset line can be
> > contrasted against the touchscreen for CRD/herobrine-r1. On those
> > boards, even though the touchscreen goes to the display, it's not
> > hooked up to anything there.
> >
> > In order to keep the line parked on herobrine/CRD, we'll move the
> > pullup from the qcard.dtsi file to the specific boards. This allows us
> > to disable the pullup in the villager device tree since the pin is an
> > output.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > This uses bindings introduced in the patch ("dt-bindings: HID:
> > i2c-hid: elan: Introduce bindings for Elan eKTH6915") [1].
> >
> > [1] https://lore.kernel.org/r/20220523142257.v2.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid
> >
> >   .../boot/dts/qcom/sc7280-herobrine-crd.dts    | 11 ++++++++
> >   .../qcom/sc7280-herobrine-herobrine-r1.dts    | 11 ++++++++
> >   .../dts/qcom/sc7280-herobrine-villager-r0.dts | 25 +++++++++++++++++++
> >   arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  1 -
> >   4 files changed, 47 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> > index a4ac33c4fd59..b79d84d7870a 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> > @@ -134,6 +134,17 @@ &sdhc_2 {
> >       status = "okay";
> >   };
> >
> > +/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
>
> Please drop this line, this isn't msm-3.4. It's immediately obvious that
> if a pin is referenced by a label and it is not defined in this file
> (because otherwise it wouldn't be both defined and referenced here..),
> it comes from a previously included device tree.

In general these headings specify a change in sort ordering. Without
them then either we intersperse pinctrl overrides with other stuff,
which IMO is overall worse or people have no idea why the sort
ordering changes.


> > @@ -604,7 +604,6 @@ ts_int_conn: ts-int-conn {
> >       ts_rst_conn: ts-rst-conn {
> >               pins = "gpio54";
> >               function = "gpio";
> > -             bias-pull-up;
>
> If you overwrite it where it should be overwritten, wouldn't it make
> more sense to leave bias-pull-up here as a default configuration for
> boards that don't have a peculiar routed-but-NC line?

Yeah, it'd be nice.  ...but because of the way "bias" is specified in
the device tree it means an ugly "/delete-property" in places that
actually route the line. I believe that, style wise, the preference is
to avoid delete-property and move the bias toward board files in cases
like this. Bjorn can feel free to override me if he disagrees.

-Doug
