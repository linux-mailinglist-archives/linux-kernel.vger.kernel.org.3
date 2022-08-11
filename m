Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF26F58FA8A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiHKKOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiHKKOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:14:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E89C14028
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:14:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i14so32677964ejg.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=UpvdQiXiaoWE7lmdI46FMRRQoH8NCO0q4oDKow84fM0=;
        b=UMK/Hou07kBp+Xwl3DSQCFMY2dhZk3AM02CB+Y/hkhC9tRM4tNcdrdtrheQxQTs+nV
         bTbKOcgpLsq3iXo1nfrWs75vuxP3NhqbDotrKZb6Mg3gY8zrBrvAyM16Cw9cTD5Na1KH
         /7KCdEwvErJFkCgG/yvinPxkkkX/UR6rqSYOThIhRm1CsWJ2HJQ08tB7P2kV+aySQg3n
         dhFEkWsSRRUQl4bgHrgUs1uyfDYsG7Rlfi5n/jBtATPNk3lMuBF1ePQfj8CrH5tkPABj
         3rxhuPzhvuj14cmrZtz1QEDjEw0+SobtvG5u4Eopx2CRN9lg89Tz2gKB5xgoriu2dSwx
         gKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=UpvdQiXiaoWE7lmdI46FMRRQoH8NCO0q4oDKow84fM0=;
        b=WWQlfwWvXoa9gU9mVULsxYWQtQ955p5LF22CNcV7s2wb6H3SfFxdhLKZ+TlF3Zmv+C
         SX4kyh6EqmyAJtjUkAwpPeNyAkP0vVBCyF9No1TgVyPQ85Ad8umFFOnYqQU+ZrgpEfCm
         oQRZGFEkz1zNfEWKR39HjdFz3chUnF1J3wyqz9aAnGtHIm1VVOhzmSOEtwpzyATFsDqA
         y3pVA9oT+mcTqsmbjsbsJwR4yoXgiMz8jySHAFgRndMwBpIkdNSZRwyn5iJYfOEdE3Gg
         HPXV999tX5csYl7VJKX78xNDXh7gUgXbQpbUZ0ALOp0J7pRNEN1Sl7S2N3J5k5wnrjNM
         RzwQ==
X-Gm-Message-State: ACgBeo1LumtDuGLgpxyc1PIx3qgt3FCh+i+gdNht9SIFND1dQ/8EaMSu
        BMH37Q7kpKy1w8ghIsREFbCaXg==
X-Google-Smtp-Source: AA6agR5L2wWzNcCPE7/bJF3PDQb95PoMLxtTDASXrh6z5KvVlnXynNFIDpNjNBO239jdMWu9vzaw7Q==
X-Received: by 2002:a17:907:209c:b0:731:27bb:da8c with SMTP id pv28-20020a170907209c00b0073127bbda8cmr16525790ejb.555.1660212884692;
        Thu, 11 Aug 2022 03:14:44 -0700 (PDT)
Received: from blmsp ([2001:4090:a243:8036:200c:a862:4253:884])
        by smtp.gmail.com with ESMTPSA id x17-20020a1709060ef100b0072b6d91b056sm3386837eji.142.2022.08.11.03.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 03:14:44 -0700 (PDT)
Date:   Thu, 11 Aug 2022 12:14:43 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: Add MT8365 power domains
Message-ID: <20220811101443.eevyf5xnctmo5y4f@blmsp>
References: <20220725081853.1636444-1-msp@baylibre.com>
 <20220725081853.1636444-2-msp@baylibre.com>
 <bbdde7ce-4512-2e61-5e1a-e22e5cb91184@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbdde7ce-4512-2e61-5e1a-e22e5cb91184@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Mon, Jul 25, 2022 at 10:54:58AM +0200, AngeloGioacchino Del Regno wrote:
> Il 25/07/22 10:18, Markus Schneider-Pargmann ha scritto:
> > From: Fabien Parent <fparent@baylibre.com>
> > 
> > Add power domains dt-bindings for MT8365.
> > 
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> > 
> > Notes:
> >      Changes in v2:
> >      - Made include/dt-bindings/power/mt8365-power.h dual-license.
> > 
> >   .../power/mediatek,power-controller.yaml      |  2 ++
> >   include/dt-bindings/power/mt8365-power.h      | 19 +++++++++++++++++++
> >   2 files changed, 21 insertions(+)
> >   create mode 100644 include/dt-bindings/power/mt8365-power.h
> > 
> > diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > index 135c6f722091..2c6d3e4246b2 100644
> > --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > @@ -29,6 +29,7 @@ properties:
> >         - mediatek,mt8186-power-controller
> >         - mediatek,mt8192-power-controller
> >         - mediatek,mt8195-power-controller
> > +      - mediatek,mt8365-power-controller
> >     '#power-domain-cells':
> >       const: 1
> > @@ -67,6 +68,7 @@ patternProperties:
> >                 "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
> >                 "include/dt-bindings/power/mt8192-power.h" - for MT8192 type power domain.
> >                 "include/dt-bindings/power/mt8195-power.h" - for MT8195 type power domain.
> > +              "include/dt-bindings/power/mt8365-power.h" - for MT8365 type power domain.
> >           maxItems: 1
> >         clocks:
> > diff --git a/include/dt-bindings/power/mt8365-power.h b/include/dt-bindings/power/mt8365-power.h
> > new file mode 100644
> > index 000000000000..e6cfd0ec7871
> > --- /dev/null
> > +++ b/include/dt-bindings/power/mt8365-power.h
> 
> Please rename this file to add the vendor prefix.
> 
> mediatek,mt8365-power.h

Thank you for your feedback.

There are currently 12 'mt*-power.h' files without vendor prefix in that
directory. I can change it, but it seems very inconsistent.

Best,
Markus
