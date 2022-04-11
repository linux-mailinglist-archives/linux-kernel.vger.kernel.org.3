Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1724FC69E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350147AbiDKVUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbiDKVUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:20:07 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181AF1B7B8;
        Mon, 11 Apr 2022 14:17:52 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s13so21739332ljd.5;
        Mon, 11 Apr 2022 14:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i0zDKPAt/qufZ/2jxiglBqBb3LU9NVf66CHpPtR+y0U=;
        b=SL7bvtN5kIiGOoqp4g1eJjN4b+D1XnkBCJjrGWEx3fqmVWNV2vI3QsrsCAwL+/TUhH
         TaofrnTJq7QNBNJw1e8Hxs7NXBWGMmBaGE5L5QP/YOlU5zTKHE3AyTO8ScvY9hOLqPXg
         165zanGQoZQO7gSM5qDrimAma3Iv27KTx/Pl65umQPJepvY146IlZQs7xww2soJstFqy
         jzbT/zaC85v9AuzePoFQYXQ6AFN+O+PWwH12KBX0P6uUpD9aTCjoAKo7qN04bIF0BZrp
         dro1Q37yiqwcHLriURQwEa9/0YW/kq4nMfn90QVZe4ndX/h3wwYh7W/8Tz0mitK5uDp4
         Q2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i0zDKPAt/qufZ/2jxiglBqBb3LU9NVf66CHpPtR+y0U=;
        b=tzPiGZqss6WQhn1ekJH8zsjz79gexMYbLunOtbIiCXRlBKc5CLSdEqf6WBoSMH/ikX
         lu1dzOi1m+Mr7M9KYVSAhByV6jvVCsz0shw9KK4zhbC5ZFPFfM0ewme9BmcKJPlezQvT
         TzZ8BA5pqEXvEiwqhYI+ZS7V50vp+Wo93rL45qVLH1u6JxHrUMyvRMSOovZ8d8scVNe/
         qgi9Luofgx+PTXPw/twEmdYWN/spD9mMhzx/PwOuas8PsBGFPiOjJMzo8OFhjN8TEKg4
         1UM/ToPeVkXPllp+jS54tEgyZotDB9uWSegNQKJ38lF2XwtVf6O4Ukcgg2HrGIzvvhcg
         0loQ==
X-Gm-Message-State: AOAM533su2IXI52fivpMrkim5GvkBWpk46zp8H2ftg5croFOW2/rQiwC
        taE4CVKjJ9YCC3b5eoOBOnA=
X-Google-Smtp-Source: ABdhPJxeTr2tnLXOWLID+EcB1R5yGfZdzHA5Pr5lRRx+5q2f6Pvr7LZvKQK3f8TLdcv5bY3x5nnvXg==
X-Received: by 2002:a2e:9a8b:0:b0:24b:4ffa:638f with SMTP id p11-20020a2e9a8b000000b0024b4ffa638fmr11338355lji.192.1649711870402;
        Mon, 11 Apr 2022 14:17:50 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id i4-20020a056512318400b0044a31d60589sm3428966lfe.86.2022.04.11.14.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:17:49 -0700 (PDT)
Date:   Tue, 12 Apr 2022 00:17:47 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, olof@lixom.net, dac2@pensando.io,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] dt-bindings: spi: dw: Add Pensando Elba SoC SPI
 Controller bindings
Message-ID: <20220411211747.ttpqk7s37j3gpzxp@mobilestation>
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-6-brad@pensando.io>
 <6769ea2d-9e6a-03b1-0e05-cb5b7379cb5e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6769ea2d-9e6a-03b1-0e05-cb5b7379cb5e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 08:52:34PM +0200, Krzysztof Kozlowski wrote:
> On 07/04/2022 01:36, Brad Larson wrote:
> > The Pensando Elba SoC has integrated the DW APB SPI Controller
> > and requires the property pensando,syscon-spics for access
> > to the spics control register.
> > 
> > Signed-off-by: Brad Larson <brad@pensando.io>
> > ---
> > Change from V3:
> > - Add required property pensando,syscon-spics to go with
> >   pensando,elba-spi
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> 
> >  .../bindings/spi/snps,dw-apb-ssi.yaml           | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > index d7e08b03e204..41c3bbf5a55c 100644
> > --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > @@ -37,6 +37,21 @@ allOf:
> >      else:
> >        required:
> >          - interrupts
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - pensando,elba-spi
> > +    then:
> > +      properties:
> > +        pensando,syscon-spics:
> > +          $ref: /schemas/types.yaml#/definitions/phandle
> > +          description:
> > +            Phandle to the system control device node which provides access to
> > +            the spics control register
> 

> It looks you only need to poke one register from spics, so it could be
> something like:
> 
>     items:
>       - items:
>           - description: Phandle to the system control device node
>           - description: spics control register offset

Right, especially seeing that's the way the elba-specific part of the
DW APB SSI driver expects the property being initialized.

-Sergey

> 
> 
> Best regards,
> Krzysztof
