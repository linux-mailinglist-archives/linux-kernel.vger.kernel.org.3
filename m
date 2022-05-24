Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9512D5333BD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 01:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242517AbiEXXBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 19:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242505AbiEXXBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 19:01:11 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C435FBF
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 16:01:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q21so18069491ejm.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 16:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfXveykq3TD1zXiLiN8Xn+jomOknax5klVDzfrxBWaI=;
        b=OVloHcVb8ZYQpTxf0U+F/gbrHMubuXtp7VHA1LNpOxiXYLSNwA4Eiz4qJxhrVc+FgR
         KzEyZhevzpjaUF9s8t0Qt8/rEIIp+N+hfCHG8CMS8QgZ3gvLVuDcHsq+cesjge/jtvaO
         HU9dsk2rML4K/QvxL+gdujr/Sd703RETVGdLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfXveykq3TD1zXiLiN8Xn+jomOknax5klVDzfrxBWaI=;
        b=z1o7GCGxzKKsLR6QxK3rGU4cNIgueLLAXOGA+EgzfYaTNoAxscfURg/v1/+cfBiJ2G
         aGgUA31Sus6jHIQK0dRXtI8epemdhRAl5wRFmI6g7z9rOshw8F1d4ayosbwh2V4kIqxk
         ePLLa4b/yKFkTCWy1JeB0Griaj9Vove26RRnbf2u8cLRFBMxAgeiwKt56t5lo5txF6uO
         +jAahTDL6vLvvcu0pYGTjHc+nTiHIkMPNYtMugkKfeAurTap8jdWv7Of1Zr97M5uetdQ
         FGVkZeq5ofTATpKriQXPymbEwvimRCN7PjA2bpci24NkQZSfRRtd5IJmN+wvuA6j6cL1
         MO0g==
X-Gm-Message-State: AOAM532cQV3Pp7Mn1g+2VsY0fIEr94/+AasTvAL3oSMTl7ohVRf6Vi6G
        jtIAS2OGEq+ut9LhSf+45J15Q7j9dnABtv3BQC4=
X-Google-Smtp-Source: ABdhPJzgVZZkG2IS/3BBC2ccX5DjQe1ClmTSKu+hZXEBtghvofOVjHB3FVRkE0dsUdVYbY82+xCk/w==
X-Received: by 2002:a17:907:3e98:b0:6fe:be1c:af86 with SMTP id hs24-20020a1709073e9800b006febe1caf86mr16026504ejc.632.1653433266808;
        Tue, 24 May 2022 16:01:06 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id s6-20020a056402520600b0042b765c2448sm2522321edd.80.2022.05.24.16.01.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 16:01:05 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id i8-20020a1c3b08000000b003974edd7c56so105929wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 16:01:05 -0700 (PDT)
X-Received: by 2002:a05:600c:3d8c:b0:394:6097:9994 with SMTP id
 bi12-20020a05600c3d8c00b0039460979994mr5614440wmb.29.1653433264517; Tue, 24
 May 2022 16:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220520143502.v4.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
 <20220520143502.v4.3.I9804fcd5d6c8552ab25f598dd7a3ea71b15b55f0@changeid>
 <7c1598a9-476d-0115-ab13-11dfa0d89436@linaro.org> <CAD=FV=UC+eFZaUiPQNKBMmLmjx21YpH4Yeg3Yz9NiDLXnh+nDg@mail.gmail.com>
 <ef83d1b7-ac05-754a-1d57-2ae467e075ec@linaro.org>
In-Reply-To: <ef83d1b7-ac05-754a-1d57-2ae467e075ec@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 May 2022 16:00:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VxP0T5_eyuOmLoa1Zpbd6md_G0YJBVCE_xV50Q_AYeDQ@mail.gmail.com>
Message-ID: <CAD=FV=VxP0T5_eyuOmLoa1Zpbd6md_G0YJBVCE_xV50Q_AYeDQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: arm: qcom: Add sc7180 Chromebook
 board bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        patches@lists.linux.dev,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Julius Werner <jwerner@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 24, 2022 at 2:34 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 23/05/2022 18:16, Doug Anderson wrote:
> > Hi,
> >
> > On Sun, May 22, 2022 at 12:57 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 20/05/2022 23:38, Douglas Anderson wrote:
> >>> This copy-pastes compatibles from sc7180-based boards from the device
> >>> trees to the yaml file so that `make dtbs_check` will be happy.
> >>>
> >>> NOTES:
> >>> - I make no attempt to try to share an "item" for all sc7180 based
> >>>   Chromebooks. Because of the revision matching scheme used by the
> >>>   Chromebook bootloader, at times we need a different number of
> >>>   revisions listed.
> >>> - Some of the odd entries in here (like google,homestar-rev23 or the
> >>>   fact that "Google Lazor Limozeen without Touchscreen" changed from
> >>>   sku5 to sku6) are not typos but simply reflect reality.
> >>> - Many revisions of boards here never actually went to consumers, but
> >>>   they are still in use within various companies that were involved in
> >>>   Chromebook development. Since Chromebooks are developed with an
> >>>   "upstream first" methodology, having these revisions supported with
> >>>   upstream Linux is important. Making it easy for Chromebooks to be
> >>>   developed with an "upstream first" methodology is valuable to the
> >>>   upstream community because it improves the quality of upstream and
> >>>   gets Chromebooks supported with vanilla upstream faster.
> >>>
> >>> One other note here is that, though the bootloader effectively treats
> >>> the list of compatibles in a given device tree as unordered, some
> >>> people would prefer future boards to list higher-numbered revisions
> >>> first in the list. Chromebooks here are not changing and typically
> >>> list lower revisions first just to avoid churn.
> >>>
> >>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> >>> ---
> >>>
> >>> (no changes since v3)
> >>>
> >>> Changes in v3:
> >>> - Split link to Chromebook boot doc into a separate patch.
> >>> - Added a note to desc about revision ordering within a device tree.
> >>>
> >>> Changes in v2:
> >>> - Add link to doc about how Chromebook devicetrees work.
> >>> - Use a "description" instead of a comment for each item.
> >>> - Use the marketing name instead of the code name where possible.
> >>>
> >>>  .../devicetree/bindings/arm/qcom.yaml         | 182 +++++++++++++++++-
> >>>  1 file changed, 181 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> >>> index 5ac28e11ea7b..01e40ea40724 100644
> >>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> >>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> >>> @@ -219,11 +219,191 @@ properties:
> >>>                - qcom,ipq8074-hk10-c2
> >>>            - const: qcom,ipq8074
> >>>
> >>> -      - items:
> >>> +      - description: Qualcomm Technologies, Inc. SC7180 IDP
> >>> +        items:
> >>>            - enum:
> >>>                - qcom,sc7180-idp
> >>>            - const: qcom,sc7180
> >>>
> >>> +      - description: HP Chromebook x2 11c (rev1 - 2)
> >>> +        items:
> >>> +          - const: google,coachz-rev1
> >>> +          - const: google,coachz-rev2
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: HP Chromebook x2 11c (newest rev)
> >>> +        items:
> >>> +          - const: google,coachz
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: HP Chromebook x2 11c with LTE (rev1 - 2)
> >>> +        items:
> >>> +          - const: google,coachz-rev1-sku0
> >>> +          - const: google,coachz-rev2-sku0
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: HP Chromebook x2 11c with LTE (newest rev)
> >>> +        items:
> >>> +          - const: google,coachz-sku0
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Lenovo Chromebook Duet 5 13 (rev2)
> >>> +        items:
> >>> +          - const: google,homestar-rev2
> >>> +          - const: google,homestar-rev23
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Lenovo Chromebook Duet 5 13 (rev3)
> >>> +        items:
> >>> +          - const: google,homestar-rev3
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Lenovo Chromebook Duet 5 13 (newest rev)
> >>> +        items:
> >>> +          - const: google,homestar
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Acer Chromebook Spin 513 (rev0)
> >>> +        items:
> >>> +          - const: google,lazor-rev0
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Acer Chromebook Spin 513 (rev1 - 2)
> >>> +        items:
> >>> +          - const: google,lazor-rev1
> >>> +          - const: google,lazor-rev2
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Acer Chromebook Spin 513 (rev3 - 8)
> >>> +        items:
> >>> +          - const: google,lazor-rev3
> >>> +          - const: google,lazor-rev4
> >>> +          - const: google,lazor-rev5
> >>> +          - const: google,lazor-rev6
> >>> +          - const: google,lazor-rev7
> >>> +          - const: google,lazor-rev8
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Acer Chromebook Spin 513 (newest rev)
> >>> +        items:
> >>> +          - const: google,lazor
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Acer Chromebook Spin 513 with KB Backlight (rev1 - 2)
> >>> +        items:
> >>> +          - const: google,lazor-rev1-sku2
> >>> +          - const: google,lazor-rev2-sku2
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Acer Chromebook Spin 513 with KB Backlight (rev3 - 8)
> >>> +        items:
> >>> +          - const: google,lazor-rev3-sku2
> >>> +          - const: google,lazor-rev4-sku2
> >>> +          - const: google,lazor-rev5-sku2
> >>> +          - const: google,lazor-rev6-sku2
> >>> +          - const: google,lazor-rev7-sku2
> >>> +          - const: google,lazor-rev8-sku2
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Acer Chromebook Spin 513 with KB Backlight (newest rev)
> >>> +        items:
> >>> +          - const: google,lazor-sku2
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Acer Chromebook Spin 513 with LTE (rev1 - 2)
> >>> +        items:
> >>> +          - const: google,lazor-rev1-sku0
> >>> +          - const: google,lazor-rev2-sku0
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Acer Chromebook Spin 513 with LTE (rev3 - 8)
> >>> +        items:
> >>> +          - const: google,lazor-rev3-sku0
> >>> +          - const: google,lazor-rev4-sku0
> >>> +          - const: google,lazor-rev5-sku0
> >>> +          - const: google,lazor-rev6-sku0
> >>> +          - const: google,lazor-rev7-sku0
> >>> +          - const: google,lazor-rev8-sku0
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Acer Chromebook Spin 513 with LTE (newest rev)
> >>> +        items:
> >>> +          - const: google,lazor-sku0
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Acer Chromebook 511 (rev4 - rev8)
> >>> +        items:
> >>> +          - const: google,lazor-rev4-sku4
> >>> +          - const: google,lazor-rev5-sku4
> >>> +          - const: google,lazor-rev6-sku4
> >>> +          - const: google,lazor-rev7-sku4
> >>> +          - const: google,lazor-rev8-sku4
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Acer Chromebook 511 (newest rev)
> >>> +        items:
> >>> +          - const: google,lazor-sku4
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Acer Chromebook 511 without Touchscreen (rev4)
> >>> +        items:
> >>> +          - const: google,lazor-rev4-sku5
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Acer Chromebook 511 without Touchscreen (rev5 - rev8)
> >>> +        items:
> >>> +          - const: google,lazor-rev5-sku5
> >>> +          - const: google,lazor-rev5-sku6
> >>> +          - const: google,lazor-rev6-sku6
> >>> +          - const: google,lazor-rev7-sku6
> >>> +          - const: google,lazor-rev8-sku6
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Acer Chromebook 511 without Touchscreen (newest rev)
> >>> +        items:
> >>> +          - const: google,lazor-sku6
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Sharp Dynabook Chromebook C1 (rev1)
> >>> +        items:
> >>> +          - const: google,pompom-rev1
> >>> +          - const: qcom,sc7180
> >>> +
> >>> +      - description: Sharp Dynabook Chromebook C1 (rev2)
> >>> +        items:
> >>> +          - const: google,pompom-rev2
> >>
> >> I understand why you do not share "item" (your first notes) for some of
> >> boards, but I don't get why "google,pompom-rev1" cannot be combined with
> >> "google,pompom-rev2". Do you see any chances to alter the bindings for
> >> these two boards?
> >>
> >> The same for other such cases (not newest revision).
> >
> > Yeah, I thought about it when I was writing the file and decided
> > against it. I guess it's just a style decision. If we combine these
> > two then I guess it raises the question: do we only combine entries
> > that list a single revision if they're the same board, or do we have
> > one uber entry at the end of the list that combines all
> > single-revision sc7180 Chromebooks? ...and in either case, what should
> > the description be?
> >
> > Personally, though it takes up more lines of code, I prefer the
> > simplicity of having each entry here correspond to a single dts file.
> >
> > Unless you feel really strongly about it, I'd tend to leave the
> > decision here to Bjorn.
>
> Sure. I would prefer to combine such obvious entries, so not everything
> into one, but the same boards with revision/SKU difference.
>
> For both cases:
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

OK, thanks! For now, I'll wait for a tiebreaker. If Bjorn or Stephen
or Matthias wants to chime in and says they'd prefer things be
combined too then I'll spin like that. Otherwise, I'll leave it like
this.

-Doug
