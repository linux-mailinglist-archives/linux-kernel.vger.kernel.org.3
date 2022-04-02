Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291E44F0616
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 22:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343941AbiDBUNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 16:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239817AbiDBUN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 16:13:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900951107C8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 13:11:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso3328983wmz.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 13:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rK/lRSYk0qbxwtkUDAG4yOb3rw3v6oUTvUr8udIrHE8=;
        b=vY8hkEVh0+ifaT2+wLmFTky/Nk6iUZJPbjkSgKIFZGr+Akbqb8GBBgaf+DB33BWZA1
         NGa26e7vdb4mmht90cL1L3J5Ct2lQWk5DSiRWKcQ7Za/+ZQ9ijIj4PGNaY5U2AfQ3FDt
         Jtqze+nO3WDUoR/AxWx7Ftu8ZWzwo5ECxSE0W2eLDS1oTxK+iY4mxVNemVfTIzCAZ6Oi
         v73dBH4BN24PdN/yt6Umu/8Hm7HGltvVTENsjRDtwkHIKX663ofPUhpHMEdCoggJFvJE
         6bK6gAAii3XAjqvxGW0gqiB7L6ImqbRdBDA+5nT7oW4aHznVgQNIgIAU5GUmD4oKSSS/
         ZnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rK/lRSYk0qbxwtkUDAG4yOb3rw3v6oUTvUr8udIrHE8=;
        b=YX7KEdiwzdMHPVJB8BGQT6ci5ybbIjepc25HKOyBl9vHHR4kw3LMWelhjIgtmXPPl+
         gkI4b8uCcXV9lRWKrKBnxkoIleyYt9WehoUjo1t+MaCorW8swyDxiZMGvZUXq36XwnuY
         bqHU9ov/22svckBoaIO1AR9a7DcOO6GvCB0eZtxw7HtCwkgkWcS595snjWzjO54Ji+rO
         vIIExEJ6hHmqworrFaVjwiBPAlZspaW9a35aB537RXk/GcMeQhi9KV6j7bg5arikedSD
         3+dnMERk+Vz8vT869p2FxC89otpJ3fzoFiV/VOXAA2u2b0Hfk5WXe5ljTAgSWz696BBY
         qmlw==
X-Gm-Message-State: AOAM5325FVSRr9XzssFZ40eexMx9y9QBXBBUM6pQZ6GYmTYB3qm6rbLP
        34k8BQRj4XFpS++yCa1LvHhXqg==
X-Google-Smtp-Source: ABdhPJyUjvxCYYY4p/glROv5L6dVxic7FGGuUAZ5dktxpN3G3iTBNLImeY1GuI7xa+JbsFyOeg6p0Q==
X-Received: by 2002:a05:600c:3d12:b0:38c:a561:f622 with SMTP id bh18-20020a05600c3d1200b0038ca561f622mr13451791wmb.139.1648930293152;
        Sat, 02 Apr 2022 13:11:33 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id n14-20020a7bcbce000000b0038c7776a300sm18769828wmi.0.2022.04.02.13.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 13:11:32 -0700 (PDT)
Date:   Sat, 2 Apr 2022 22:11:30 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 27/33] dt-bindings: crypto: convert rockchip-crypto to
 yaml
Message-ID: <Ykit8n8etuZWGsfY@Red>
References: <20220401201804.2867154-1-clabbe@baylibre.com>
 <20220401201804.2867154-28-clabbe@baylibre.com>
 <3969db0e-50e8-e042-4696-97f56bd38999@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3969db0e-50e8-e042-4696-97f56bd38999@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, Apr 02, 2022 at 02:10:21PM +0200, Krzysztof Kozlowski a écrit :
> On 01/04/2022 22:17, Corentin Labbe wrote:
> > Convert rockchip-crypto to yaml
> 
> s/yaml/YAML/
> and a full stop.
> 
> Looks good but please mention in commit msg that the names for clocks
> and resets will be provided in next patch. Otherwise it looks like
> incomplete conversion.

Hello

I forgot clock-names in this patch, i will fix that (and other comments) in v5.

Thanks

> 
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  .../crypto/rockchip,rk3288-crypto.yaml        | 59 +++++++++++++++++++
> >  .../bindings/crypto/rockchip-crypto.txt       | 28 ---------
> >  2 files changed, 59 insertions(+), 28 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> > new file mode 100644
> > index 000000000000..66db671118c3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> > @@ -0,0 +1,59 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/crypto/rockchip,rk3288-crypto.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip Electronics And Security Accelerator
> 
> Remove "And". It looks like company name is the name of the hardware.
> 
> Best regards,
> Krzysztof
