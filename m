Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F20C57B95E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241277AbiGTPOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiGTPOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:14:06 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062F35A14F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:14:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id va17so33695072ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYFr7W/TB3/Ge01WvDEcFFO3MPdvM4AewhxOk12JihE=;
        b=NYEJaqBE0dq70riib/CJZNibK32KtA1ArsXU+Lmhye2iKLvxy6n1jMwFEBApp4cWBH
         opUSurPSBd2q2OYyJb9UQwbXXL/IQzMA41/uOqGxuhsPJ4BBFLa+nYgYO/uZiCIoxHwv
         9fXUwXVx3WkP/Yi3kObsfDZUz1wL/YvWK8L50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYFr7W/TB3/Ge01WvDEcFFO3MPdvM4AewhxOk12JihE=;
        b=CmBowHHiOXBQ1gql7HUrWTsPJKrJhrMiS9RfW3Ce6Yh8VdjE/9dLclpgoAH1KhrtW5
         H0OIDrga6tyeMs80yeHcjGx2mATv4Av0ECNZCo5Wu0fD4wJnasStRUyUNmwjX7xb/TQv
         R42dL5vRdjzl8b/I/+0rNED3V3qgFa6QEiw9XPYwfuFdeD4AHzjD4xOaw04mW4q9fDkb
         OPCTmFuzzQweGvJvGi75PtAEVKYxMATf5qJQC5yoGcBlXtVGrbgqXFOjQJlueBzlTu/R
         Y9plUJko4rsqupI59punYW7J5O2vDlp6SAbzpCMPfwk7xdHd/C9ZR/GquW0Rjtbj8et2
         f/ew==
X-Gm-Message-State: AJIora8GBasbi3fHLSni/qI8V/DrL0zXgoYOAaXDJOJ7yYNwMTKrHgoS
        XNy0oiKvVl2WxpLzmXe0Q12GS+XNCkoCs3GuUbU=
X-Google-Smtp-Source: AGRyM1ueNpHyaWxgUYj3guNFER9mh2E5T5FTZVOpo9ye65Dh2uZTeNLuxbW/9l7KxNVFd+SUsaCXHg==
X-Received: by 2002:a17:907:1629:b0:72b:68e9:bf2c with SMTP id hb41-20020a170907162900b0072b68e9bf2cmr35689379ejc.760.1658330044070;
        Wed, 20 Jul 2022 08:14:04 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id e16-20020a170906315000b0070e238ff66fsm8054266eje.96.2022.07.20.08.14.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 08:14:01 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id h8so3847530wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:14:01 -0700 (PDT)
X-Received: by 2002:a5d:5889:0:b0:21d:bccd:38e3 with SMTP id
 n9-20020a5d5889000000b0021dbccd38e3mr30328783wrf.659.1658330040897; Wed, 20
 Jul 2022 08:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220720025058.1.I5bfba8857ea0d43c747ecdc3a950875abd56927f@changeid>
 <7a04c9af-0ccb-7711-249f-73908fe7ec36@linaro.org>
In-Reply-To: <7a04c9af-0ccb-7711-249f-73908fe7ec36@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 20 Jul 2022 08:13:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V1MqQzNxq_L8sGtu2JwAAL_FWKXkw9bhCHcD0DycFMUw@mail.gmail.com>
Message-ID: <CAD=FV=V1MqQzNxq_L8sGtu2JwAAL_FWKXkw9bhCHcD0DycFMUw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Add SKU6 for sc7180-trogdor-pazquel-lte-parade
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 19, 2022 at 11:10 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/07/2022 04:51, Yunlong Jia wrote:
> > SKU6 is LTE(w/o eSIM)+WIFI+Parade
> >
> > Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
> > ---
> >
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
> > index 764c451c1a857..4649eaec6318d 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
> > @@ -14,7 +14,7 @@
> >
> >  / {
> >       model = "Google Pazquel (Parade,LTE)";
> > -     compatible = "google,pazquel-sku4", "qcom,sc7180";
> > +     compatible = "google,pazquel-sku4", "google,pazquel-sku6", "qcom,sc7180";
>
> You miss binding change and sku6 should be rather added before sku4 as
> it is more specific, isn't it?

Just to close the loop: the order doesn't matter at all. Neither sku4
nor sku6 is "more specific". One has the eSIM stuffed and one doesn't.
I don't personally care about what order these are listed in, though,
so if Krzysztof is happier with "sku6" being first then I'm OK w/ it
as long as it matches the bindings.

-Doug
