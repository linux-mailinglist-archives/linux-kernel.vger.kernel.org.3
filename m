Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F38F568B30
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbiGFO2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiGFO2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:28:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4A51C923
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:28:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r14so16545374wrg.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ftt1gf1maseGqC1Gii2R8eooTq30YUOm7AExkJ1sGBI=;
        b=Idoj3f1+WjxFSaC8dyFJ6WmfifQA2Bwuj5QgzV8Fe9fCvZIDrYQbVnffG8rK4Nhc4M
         jvHyyMmjSeGMeDEH4iox8BuBGuO6q8XyI23QONyQjrKEGWhId2FvvYQYj+rZeGaB0/eo
         MUdXlaK5JbXGM0j2k3ek6BkgxAY9GaYqGOl+mn/4rhtdprQ7qgjNalgVk6pGjrDjT7Ku
         eeUWJoM0DPwXvseOzmAuU3AAzE03J0h5k3FeeTVa3m4j4nFPgILNL7MqTRu2UnVmw5aX
         1zZugYcVyqVJ3+nz8LREpA3sfLCyT180zGZkVMDZPDaXbPkBCuENIrpeSE4U0KAp5FG1
         0IlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ftt1gf1maseGqC1Gii2R8eooTq30YUOm7AExkJ1sGBI=;
        b=ioOYjFgjTM2ExsJJnXEUuplTiJpRomLRqurMf71SZf9cYjAo57dagQmuky03t7Y9qL
         RxtXropq4E6VzSCNMug+kCvGBUThAWrZemIXe8P7Sp76rgwRo6PblULAhO4kZEjlQzIm
         FM6sUFzpDIp+yeudSqe5S3c3yyWpJjutGxeO+nDmd9WUOXzLl4YDYDkUI3aF5dCkcTzw
         Opqmvs6mlaTBAedbSQqbd6KawiCNiSF+pfLoCa7TrP2F77MkYtxvFmSJVZjua45NJkqi
         rI8sJG1LlReOy7R76Jdvizo2nYKZI7h3yiX9EyPAE7+9VIjuvYvdA9ApcmK9rJmNi7aN
         vHhQ==
X-Gm-Message-State: AJIora9QQFFUKtOX4zymBMA1mauIlduK9gqdprZrh6DTnBZwKSNoUrpa
        fV2VRp8wtoRvjApaXnh9d5qS4g==
X-Google-Smtp-Source: AGRyM1s/EpMgC9IgMxTtWr1OjAkAw4mmTjNBAsTu4Zuo0mz4gDkedlTMxCZZ9t17GTaZzEa0+7q8Kg==
X-Received: by 2002:adf:ea08:0:b0:21d:6dbf:6366 with SMTP id q8-20020adfea08000000b0021d6dbf6366mr13294602wrm.137.1657117724247;
        Wed, 06 Jul 2022 07:28:44 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id y5-20020a056000108500b002167efdd549sm8046055wrw.38.2022.07.06.07.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 07:28:43 -0700 (PDT)
Date:   Wed, 6 Jul 2022 16:28:40 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     john@metanate.com, heiko@sntech.de, p.zabel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, didi.debian@cknow.org,
        herbert@gondor.apana.org.au, sboyd@kernel.org,
        mturquette@baylibre.com, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 25/33] dt-bindings: crypto: rockchip: convert to new
 driver bindings
Message-ID: <YsWcGDwPCX+/95i3@Red>
References: <20220706090412.806101-1-clabbe@baylibre.com>
 <20220706090412.806101-26-clabbe@baylibre.com>
 <1657114144.957232.4099933.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1657114144.957232.4099933.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Jul 06, 2022 at 07:29:04AM -0600, Rob Herring a écrit :
> On Wed, 06 Jul 2022 09:04:04 +0000, Corentin Labbe wrote:
> > The latest addition to the rockchip crypto driver need to update the
> > driver bindings.
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  .../crypto/rockchip,rk3288-crypto.yaml        | 85 +++++++++++++++++--
> >  1 file changed, 77 insertions(+), 8 deletions(-)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml: allOf:0:then:properties:clock-names: 'oneOf' conditional failed, one must be fixed:
> 	[{'const': 'aclk'}, {'const': 'hclk'}, {'const': 'sclk'}, {'const': 'apb_pclk'}] is too long
> 	[{'const': 'aclk'}, {'const': 'hclk'}, {'const': 'sclk'}, {'const': 'apb_pclk'}] is too short
> 	False schema does not allow 4
> 	1 was expected
> 	4 is greater than the maximum of 2
> 	4 is greater than the maximum of 3

Hello

I upgraded to dt-schema 2022.07 and fail to reproduce all errors.

Regards
