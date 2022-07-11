Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A97B5706B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiGKPLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiGKPLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:11:47 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F1374E04
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:11:46 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id l24so5157793ion.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xninKA70EtexcdYCbdfuTinCaP7pxcUur1I8bK0NPTw=;
        b=OKNN2Re5+g4wHUiVyzepFDVWZOXbvcZGQio3rTb0i4xibe7JSuEzbHrs4S05ZN6i78
         sgkq6ZFhZVQQkc5t3f0VvdAB31FviPnkCYj3b5bH0gdYLrYCm00hqvh4HCRUj2dy9Ap5
         Q02/02O/jxHXt17YhY2tvweobdiXpz005KJ8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xninKA70EtexcdYCbdfuTinCaP7pxcUur1I8bK0NPTw=;
        b=1IY4izakVpuuO3To9lNZuLVYtgWRIhlM30HtNoBMIfmPIrVhDO+za9TqKgYp8pf23z
         8BMuUuV7TEG0BFuduvroqztkhkyuBOBHD8jXYXyqQjqDydlhC7Ygch+kHNCbDvhANNkL
         jW+Zd0QVKlLSwNf7M5mXdN6oDf4DG5DFA/uD85GierZIf1YLPw2tY2EacDfr7epCSZH5
         w7XqZghh9gqZqb8aGZLgU1HRKMsGf8vZ3kUMVtC9atAnpNwJxQMMK2nEvBuxr/VNhjcD
         8mmhCKKIKEMrYkFQ77Xw8VsrMywoqW2snulezzrHh2cXzBzopzqHj2Yepxf2LQStOyMN
         LkDA==
X-Gm-Message-State: AJIora9SDlXXK5FNp8wusBwFU4d1PPfUsJlbg3cfhIlfJ+suIBiWx+QB
        9QA3HquXxhbb+wPmAZ0MW0BexZ2utFBNd4JgWWY=
X-Google-Smtp-Source: AGRyM1uLGf+/mRay4LBcWjJVLcIwCPCbcdCy1D4pBhFzJCkq4R7+EOLnxnbyOpCE+VIgrlWIFFPC3A==
X-Received: by 2002:a05:6638:35a4:b0:33c:8f1d:5835 with SMTP id v36-20020a05663835a400b0033c8f1d5835mr10424211jal.37.1657552305425;
        Mon, 11 Jul 2022 08:11:45 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id o22-20020a02a1d6000000b0032e2996cadesm3023654jah.66.2022.07.11.08.11.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 08:11:44 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id y2so5159945ior.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:11:43 -0700 (PDT)
X-Received: by 2002:a05:6602:2d48:b0:67b:73f5:7e74 with SMTP id
 d8-20020a0566022d4800b0067b73f57e74mr8746907iow.154.1657552303271; Mon, 11
 Jul 2022 08:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220711082940.39539-1-krzysztof.kozlowski@linaro.org>
 <20220711082940.39539-3-krzysztof.kozlowski@linaro.org> <CAD=FV=WUCPzzZHAPqoz-vhmcVxzYDxkKQs=+1tLZvsQjWe4q3Q@mail.gmail.com>
 <f8744ff8-15a0-bf31-c49f-b1bb35ba5cdd@linaro.org>
In-Reply-To: <f8744ff8-15a0-bf31-c49f-b1bb35ba5cdd@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jul 2022 08:11:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X2ZfwwDO_hSSN35ObfvBbBbPjMoSB4GvS7m0yJieNg3Q@mail.gmail.com>
Message-ID: <CAD=FV=X2ZfwwDO_hSSN35ObfvBbBbPjMoSB4GvS7m0yJieNg3Q@mail.gmail.com>
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

On Mon, Jul 11, 2022 at 7:53 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/07/2022 16:52, Doug Anderson wrote:
> > Hi
> >
> > On Mon, Jul 11, 2022 at 1:29 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> The entries in arrays must have fixed order, so the bindings and Linux
> >> driver expecting various combinations of 'reg' addresses was never
> >> actually conforming to guidelines.
> >>
> >> The 'core' reg entry is valid only for SDCC v4 and lower, so disallow it
> >> in SDCC v5.  SDCC v4 supports CQE and ICE, so allow them, even though
> >> the qcom,sdhci-msm-v4 compatible is used also for earlier SoCs with SDCC
> >> v2 or v3, so it is not entirely accurate.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> Changes since v1:
> >> 1. Rework the patch based on Doug's feedback.
> >> ---
> >>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 61 ++++++++++++-------
> >>  1 file changed, 38 insertions(+), 23 deletions(-)
> >
> > In the ${SUBJECT} I'm not sure what a "perp variant" is. Is that a
> > typo or just a phrase I'm not aware of?
>
> Should be:
> "per variants"
>
> >
> >
> >> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> >> index fc6e5221985a..2f0fdd65e908 100644
> >> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> >> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> >> @@ -49,33 +49,11 @@ properties:
> >>
> >>    reg:
> >>      minItems: 1
> >> -    items:
> >> -      - description: Host controller register map
> >> -      - description: SD Core register map
> >> -      - description: CQE register map
> >> -      - description: Inline Crypto Engine register map
> >> +    maxItems: 4
> >>
> >>    reg-names:
> >>      minItems: 1
> >>      maxItems: 4
> >> -    oneOf:
> >> -      - items:
> >> -          - const: hc
> >> -      - items:
> >> -          - const: hc
> >> -          - const: core
> >> -      - items:
> >> -          - const: hc
> >> -          - const: cqhci
> >> -      - items:
> >> -          - const: hc
> >> -          - const: cqhci
> >> -          - const: ice
> >> -      - items:
> >> -          - const: hc
> >> -          - const: core
> >> -          - const: cqhci
> >> -          - const: ice
> >>
> >>    clocks:
> >>      minItems: 3
> >> @@ -177,6 +155,43 @@ required:
> >>  allOf:
> >>    - $ref: mmc-controller.yaml#
> >>
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - qcom,sdhci-msm-v4
> >> +    then:
> >> +      properties:
> >> +        reg:
> >> +          minItems: 2
> >> +          items:
> >> +            - description: Host controller register map
> >> +            - description: SD Core register map
> >> +            - description: CQE register map
> >> +            - description: Inline Crypto Engine register map
> >> +        reg-names:
> >> +          minItems: 2
> >> +          items:
> >> +            - const: hc
> >> +            - const: core
> >> +            - const: cqhci
> >> +            - const: ice
> >> +    else:
> >> +      properties:
> >> +        reg:
> >> +          minItems: 1
> >> +          items:
> >> +            - description: Host controller register map
> >> +            - description: CQE register map
> >> +            - description: Inline Crypto Engine register map
> >> +        reg-names:
> >> +          minItems: 1
> >> +          items:
> >> +            - const: hc
> >> +            - const: cqhci
> >> +            - const: ice
> >
> > Do you need to set "maxItems" here? If you don't then will it inherit
> > the maxItems of 4 from above?
>
> No, items determine the size instead.

Can you just remove the "maxItems" from above then? Does it buy us anything?

In any case, with the ${SUBJECT} fixed:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
