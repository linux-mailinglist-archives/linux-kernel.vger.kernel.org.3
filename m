Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C01569D8D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbiGGIiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiGGIh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:37:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5177F4F199
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:37:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b26so25285452wrc.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=abVct3gFPTleVwlkxr292THL1sNRNK8PgBmO/9HJXCI=;
        b=vn0flu9MW1pSkawzZyj52K6aja+bt23HA6wmB2x9Kkfdp7Xd2shvOgxcan20A/TmkC
         mOX51GpNPNJILOSvgLZRkruKUnMe7fLjew3zsLQTN7MmTNcYWuK/EJbrt2wCBz6aW8AT
         x73mEghaDHHkVRKYZQpYkFPaXxjUBz5GiOhW0VQD9i8jOKJhiM9d1vuaRlOSD53wLmBr
         sJ8m8foHKMk3EcJN7gPwaP5BZzZvUyByrqAtkXxkuZfuLetTzq8Fp3lcyR4ay3SLNrH3
         m+xQs3yJ1859YHOsJYkcEtHHZPg9vqDdo5v1MDZPVjQQDoslKtcS9jXhtJz1RbxcaDTo
         Rr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=abVct3gFPTleVwlkxr292THL1sNRNK8PgBmO/9HJXCI=;
        b=qtoJa6AgRr++jiTMQ0uQI65j+yzJMxWtMdVCUey2yyfLKheXtmOM3nlsQJwOukneCs
         8U+W/npdDx2Ihwz2XS4iXRKxcfFe2djFTLyYZTdJ57ZKOCdice3rskRlw+932S16xE9E
         tsqaA7JfVgs+2h82xFV+seVYmuUu5sl/RRu5zvi+GDBiGoMAsbyNbFqqEaRZAetBoGZM
         dbEdr5kNYhIqqop5GmmqEUsbUb/LpVW/9MusyPnR7QXboJSgW/esPqPOSME3y5UBJyoD
         ZOYnigpE9mfk4xmL+W1CJ7wk9hTobITGGavBC+fiHKK9K662AR5aw9+VSKALfgCV89md
         tqzg==
X-Gm-Message-State: AJIora/Mmn0f+AyNtEZDTeb9CTERBcGitYOoBzbkaNVMjzlDc7EAJyMu
        ROLJpiuZCgzEyCgCqLHSWnyc/Q==
X-Google-Smtp-Source: AGRyM1shCU2H4w9v75oD2tgujLOfTjQOmrrVfjjs4CYHJNZDG8I5AOH/bGufuGGuNpZAVt0EjUjaVQ==
X-Received: by 2002:a05:6000:15c6:b0:21d:17da:29ca with SMTP id y6-20020a05600015c600b0021d17da29camr41374738wry.94.1657183073842;
        Thu, 07 Jul 2022 01:37:53 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id g10-20020a5d698a000000b0021d83eed0e9sm1479968wru.30.2022.07.07.01.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:37:53 -0700 (PDT)
Date:   Thu, 7 Jul 2022 10:37:50 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, john@metanate.com, heiko@sntech.de,
        p.zabel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        didi.debian@cknow.org, herbert@gondor.apana.org.au,
        sboyd@kernel.org, mturquette@baylibre.com,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v8 25/33] dt-bindings: crypto: rockchip: convert to new
 driver bindings
Message-ID: <YsabXrOyAsCkUUVN@Red>
References: <20220706090412.806101-1-clabbe@baylibre.com>
 <20220706090412.806101-26-clabbe@baylibre.com>
 <1657114144.957232.4099933.nullmailer@robh.at.kernel.org>
 <YsWcGDwPCX+/95i3@Red>
 <3e47b853-bb82-8766-8884-3da931c038a2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e47b853-bb82-8766-8884-3da931c038a2@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Jul 06, 2022 at 05:25:21PM +0200, Krzysztof Kozlowski a écrit :
> On 06/07/2022 16:28, LABBE Corentin wrote:
> > Le Wed, Jul 06, 2022 at 07:29:04AM -0600, Rob Herring a écrit :
> >> On Wed, 06 Jul 2022 09:04:04 +0000, Corentin Labbe wrote:
> >>> The latest addition to the rockchip crypto driver need to update the
> >>> driver bindings.
> >>>
> >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> >>> ---
> >>>  .../crypto/rockchip,rk3288-crypto.yaml        | 85 +++++++++++++++++--
> >>>  1 file changed, 77 insertions(+), 8 deletions(-)
> >>>
> >>
> >> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> >> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >>
> >> yamllint warnings/errors:
> >>
> >> dtschema/dtc warnings/errors:
> >> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml: allOf:0:then:properties:clock-names: 'oneOf' conditional failed, one must be fixed:
> >> 	[{'const': 'aclk'}, {'const': 'hclk'}, {'const': 'sclk'}, {'const': 'apb_pclk'}] is too long
> >> 	[{'const': 'aclk'}, {'const': 'hclk'}, {'const': 'sclk'}, {'const': 'apb_pclk'}] is too short
> >> 	False schema does not allow 4
> >> 	1 was expected
> >> 	4 is greater than the maximum of 2
> >> 	4 is greater than the maximum of 3
> > 
> > Hello
> > 
> > I upgraded to dt-schema 2022.07 and fail to reproduce all errors.
> 
> Visible on older dtschema (2022.6.dev10+gcd64f75fe091), visible on
> newest (2022.7).
> 
> Exactly the same error.
> 

Hello

I am sorry, I finally succesfully reproduced it.
Just doing what the hints gives (removing max/min-items) from "static" list fix the issue.

Does I need to remove your Reviewed-by ?

Thanks
