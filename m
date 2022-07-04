Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE4956568D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiGDNHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiGDNHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:07:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270DCFD2A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:07:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fz10so3214601pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9vSwpNfijyGK+xrrZ4ktPT+fDOfewidBPv0KVUyPN8w=;
        b=Daog+0QETcPjLevzyo5ThG79RtkL0CqCom7hkuuYfksUjPFSbwWnYTNzUMbILHd3DI
         NF1Qu78ynNuVBxEGzjJEW2qnzI3y0NlEbiFDJGw/MChBXZLPJDw4s259eT+D8Q2dqa2O
         yOnCOXah3RBd3klHMY5xP1wra1/75G4UsvbFKuZDY4PSjMixVMfunsFERDgtnueWwMV3
         ND/H2alGaUoJjcDfh6LnEOhOt/TSLoZggVW3qSZeSBlH4a3TDZNNpyT0qs1Ol4svOKNy
         uWbzHe1aZIJfglIzmsFY1d/CanOtzrCclAfIoT6/1GdK1Tjs+VC2knvI6NRXWMjNBO/8
         uJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9vSwpNfijyGK+xrrZ4ktPT+fDOfewidBPv0KVUyPN8w=;
        b=CajiJMHYe+st0TJhyj/wndDj+X7x2Q2npvL544sH4L4iorQr65rb4J89Xap3DqLo3n
         P33ujdeZJoV2tPHGlr2Niz0pv4mIWM9wRs8jGwde8oCSEWA3h9k6QGwmwRPRaESYMv1B
         N/mf86XJFXJy6t7t8bWXLwTwMnYkrT5Db1VNplz+7euY3ypYYxRyNJO79K7hJsPxcb9M
         tzWOTJA0PtTBYs0kZV/9HmoQp/gKLKTWkp+RGaJwz6FbpjF5jfq0n48AQtX1YiOZrQ7T
         Q7/EJeOyFrN3piL11AZ8bniBU2Q9LY5s5asMCtx7NLugUF9PWfSor1UitZN9m4+YvFBT
         EPow==
X-Gm-Message-State: AJIora97t5dwhAz6AZZy0RzEamJy+XGh/PB0jR+MkiDJKa9dlBd5OOlo
        yrCjeoPgUdjeKsYft3ZSTpn5iQ==
X-Google-Smtp-Source: AGRyM1u4sHIQ7MddMLsKSjsK4IcE4neuK6lXp6uptFSzLUxcH3x1D2Q7Xm2DlPLadoDisFpUznRMQw==
X-Received: by 2002:a17:903:1108:b0:168:fa61:1456 with SMTP id n8-20020a170903110800b00168fa611456mr36044412plh.162.1656940037531;
        Mon, 04 Jul 2022 06:07:17 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([154.3.32.171])
        by smtp.gmail.com with ESMTPSA id 185-20020a6205c2000000b005284d10d8f6sm4577395pff.215.2022.07.04.06.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 06:07:17 -0700 (PDT)
Date:   Mon, 4 Jul 2022 21:07:12 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: interconnect: Update property for
 icc-rpm path tag
Message-ID: <20220704130712.GD659023@leoy-ThinkPad-X240s>
References: <20220704093029.1126609-1-leo.yan@linaro.org>
 <20220704093029.1126609-2-leo.yan@linaro.org>
 <18f1ee4a-5787-40d7-2eb5-50a43298845d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18f1ee4a-5787-40d7-2eb5-50a43298845d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 02:47:13PM +0200, Krzysztof Kozlowski wrote:
> On 04/07/2022 11:30, Leo Yan wrote:
> > To support path tag in icc-rpm driver, the "#interconnect-cells"
> > property is updated as enumerate values: 1 or 2.  Setting to 1 means
> > it is compatible with old DT binding that interconnect path only
> > contains node id; if set to 2 for "#interconnect-cells" property, then
> > the second specifier is used as a tag (e.g. vote for which buckets).
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  .../devicetree/bindings/interconnect/qcom,rpm.yaml         | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> > index 8a676fef8c1d..cdfe419e7339 100644
> > --- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> > +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> > @@ -45,7 +45,12 @@ properties:
> >        - qcom,sdm660-snoc
> >  
> >    '#interconnect-cells':
> > -    const: 1
> > +    description: |
> > +      Number of interconnect specifier. Value: <1> is one cell in a
> > +      interconnect specifier for the interconnect node id, <2> requires
> > +      the interconnect node id and an extra path tag.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Ah, too fast.  No ack. This ref is also pointless and not explained in
> commit msg.

I referred other DT binding file for adding $ref to specify property
type [1], so it's confused why it's pointless, anyway, I can drop $ref
in next spin.

Thanks a lot for the review!

Leo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/arm/l2c2x0.yaml#n153
