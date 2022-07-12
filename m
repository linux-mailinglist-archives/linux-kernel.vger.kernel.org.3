Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40271571C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiGLO32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiGLO3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:29:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A1DC7F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:29:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ez10so14600871ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UpQJKKbtg93cX86UuSBO9tVRJrPAdwmdctCEOdnSRnU=;
        b=ijq11B8dVKWd4WwXQdLWGL47Ff65ZWhCh8I3SE5MaxMAad6+ff+0LigbAoCe2JY4iV
         3LYhRmAzDWby1Q6v0gv1VaqErS7z7UeZOhoWW35oxwjCuJ3tvmQYNhvS3m9DSj3ZipSe
         75C5HfTf7UALfjjpZlu/UxdxlwILLB1WhqUf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UpQJKKbtg93cX86UuSBO9tVRJrPAdwmdctCEOdnSRnU=;
        b=PPLN+kCaaAMHx1IpqIIEgK165/X7SmTjA6IxFSORNMf/kMYJKQR7JyqJMblrwnfC0J
         ICk1ofyerGCRIfq4vGrEaoP/GP4rE0VHvy2c3BNsdCixOZ6Y74eT5jUzqk0EgaSgIrEM
         tUIO79Faus7o8hDM0vgGnMC+F/coR8ecDU42szuc7GMGc9WQZiLsefJ9VYwuUNXUsxjK
         Rjd31NQbnrmDB2n3hFgaeT+JrcK278jnaQ9j4n54yP3EABcfouvjKGshsEfSizREovwc
         jnuOnhkGrUG3lbZIx0lx3jzfQwoBTWm3u69nBdOVTyPod/+5VVsNlRFm1OlaoRhGX68B
         iO2Q==
X-Gm-Message-State: AJIora+JjQnT4sm58XVUU127e2y7hgzRVa1CWNqGNK9mULAQ9QmRwcPj
        NXF2uOx2anUkg87X3X6gNPXEsDHo8PljwYmBF34=
X-Google-Smtp-Source: AGRyM1urVUaZPWI0RrNKGSED+xIGP4FuOathQyMz1Jg+F2cUm56uRRZmoC0i6z1jlj4zyvp719a7Kw==
X-Received: by 2002:a17:907:62a6:b0:6ef:8118:d3e2 with SMTP id nd38-20020a17090762a600b006ef8118d3e2mr23596090ejc.605.1657636161137;
        Tue, 12 Jul 2022 07:29:21 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id o2-20020aa7dd42000000b0043ad162b5e3sm3953538edw.18.2022.07.12.07.29.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 07:29:19 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id v16so11400441wrd.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:29:19 -0700 (PDT)
X-Received: by 2002:adf:d1c1:0:b0:21b:a5e9:b7b2 with SMTP id
 b1-20020adfd1c1000000b0021ba5e9b7b2mr22505619wrd.405.1657636159126; Tue, 12
 Jul 2022 07:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220711082940.39539-1-krzysztof.kozlowski@linaro.org>
 <20220711082940.39539-3-krzysztof.kozlowski@linaro.org> <CAD=FV=WUCPzzZHAPqoz-vhmcVxzYDxkKQs=+1tLZvsQjWe4q3Q@mail.gmail.com>
 <f8744ff8-15a0-bf31-c49f-b1bb35ba5cdd@linaro.org> <CAD=FV=X2ZfwwDO_hSSN35ObfvBbBbPjMoSB4GvS7m0yJieNg3Q@mail.gmail.com>
 <629ede41-326b-9c84-4bb8-2f7e695ca928@linaro.org>
In-Reply-To: <629ede41-326b-9c84-4bb8-2f7e695ca928@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 12 Jul 2022 07:29:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W7dypM9=uqaY650TGfiV4EaZR9EBH_3svQefyNv-oE7Q@mail.gmail.com>
Message-ID: <CAD=FV=W7dypM9=uqaY650TGfiV4EaZR9EBH_3svQefyNv-oE7Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: mmc: sdhci-msm: constrain reg-names
 perp variants
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 12, 2022 at 12:02 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/07/2022 17:11, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Jul 11, 2022 at 7:53 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 11/07/2022 16:52, Doug Anderson wrote:
> >>> Hi
> >>>
> >>> On Mon, Jul 11, 2022 at 1:29 AM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> The entries in arrays must have fixed order, so the bindings and Linux
> >>>> driver expecting various combinations of 'reg' addresses was never
> >>>> actually conforming to guidelines.
> >>>>
> >>>> The 'core' reg entry is valid only for SDCC v4 and lower, so disallow it
> >>>> in SDCC v5.  SDCC v4 supports CQE and ICE, so allow them, even though
> >>>> the qcom,sdhci-msm-v4 compatible is used also for earlier SoCs with SDCC
> >>>> v2 or v3, so it is not entirely accurate.
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>>
> >>>> ---
> >>>>
> >>>> Changes since v1:
> >>>> 1. Rework the patch based on Doug's feedback.
> >>>> ---
> >>>>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 61 ++++++++++++-------
> >>>>  1 file changed, 38 insertions(+), 23 deletions(-)
> >>>
> >>> In the ${SUBJECT} I'm not sure what a "perp variant" is. Is that a
> >>> typo or just a phrase I'm not aware of?
> >>
> >> Should be:
> >> "per variants"
> >>
> >>>
> >>>
> >>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> >>>> index fc6e5221985a..2f0fdd65e908 100644
> >>>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> >>>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> >>>> @@ -49,33 +49,11 @@ properties:
> >>>>
> >>>>    reg:
> >>>>      minItems: 1
> >>>> -    items:
> >>>> -      - description: Host controller register map
> >>>> -      - description: SD Core register map
> >>>> -      - description: CQE register map
> >>>> -      - description: Inline Crypto Engine register map
> >>>> +    maxItems: 4
> >>>>
> >>>>    reg-names:
> >>>>      minItems: 1
> >>>>      maxItems: 4
> >>>> -    oneOf:
> >>>> -      - items:
> >>>> -          - const: hc
> >>>> -      - items:
> >>>> -          - const: hc
> >>>> -          - const: core
> >>>> -      - items:
> >>>> -          - const: hc
> >>>> -          - const: cqhci
> >>>> -      - items:
> >>>> -          - const: hc
> >>>> -          - const: cqhci
> >>>> -          - const: ice
> >>>> -      - items:
> >>>> -          - const: hc
> >>>> -          - const: core
> >>>> -          - const: cqhci
> >>>> -          - const: ice
> >>>>
> >>>>    clocks:
> >>>>      minItems: 3
> >>>> @@ -177,6 +155,43 @@ required:
> >>>>  allOf:
> >>>>    - $ref: mmc-controller.yaml#
> >>>>
> >>>> +  - if:
> >>>> +      properties:
> >>>> +        compatible:
> >>>> +          contains:
> >>>> +            enum:
> >>>> +              - qcom,sdhci-msm-v4
> >>>> +    then:
> >>>> +      properties:
> >>>> +        reg:
> >>>> +          minItems: 2
> >>>> +          items:
> >>>> +            - description: Host controller register map
> >>>> +            - description: SD Core register map
> >>>> +            - description: CQE register map
> >>>> +            - description: Inline Crypto Engine register map
> >>>> +        reg-names:
> >>>> +          minItems: 2
> >>>> +          items:
> >>>> +            - const: hc
> >>>> +            - const: core
> >>>> +            - const: cqhci
> >>>> +            - const: ice
> >>>> +    else:
> >>>> +      properties:
> >>>> +        reg:
> >>>> +          minItems: 1
> >>>> +          items:
> >>>> +            - description: Host controller register map
> >>>> +            - description: CQE register map
> >>>> +            - description: Inline Crypto Engine register map
> >>>> +        reg-names:
> >>>> +          minItems: 1
> >>>> +          items:
> >>>> +            - const: hc
> >>>> +            - const: cqhci
> >>>> +            - const: ice
> >>>
> >>> Do you need to set "maxItems" here? If you don't then will it inherit
> >>> the maxItems of 4 from above?
> >>
> >> No, items determine the size instead.
> >
> > Can you just remove the "maxItems" from above then? Does it buy us anything?
>
> There is no maxItems directly here...

Sorry, I mean above in the schema. After your patch the schema is effectively:

reg:
  minItems: 1
  maxItems: 4
reg-names:
  minItems: 1
  maxItems: 4

...

allOf:
  - if:
      blah-blah-blah
    then:
      properties:
        reg:
          minItems: 2
          items:
            - description: ...
            - description: ...
            - description: ...
            - description: ...
        reg-names:
          blah-blah-blah
    else:
      blah-blah-blah

I'm asking about the maxItems _above_, AKA in the section:

reg:
  minItems: 1
  maxItems: 4
reg-names:
  minItems: 1
  maxItems: 4

Can we remove the "maxItems: 4" from the above and have it just be:

reg:
  minItems: 1
reg-names:
  minItems: 1

-Doug
