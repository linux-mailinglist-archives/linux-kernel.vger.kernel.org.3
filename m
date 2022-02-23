Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B214C138F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbiBWNGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240711AbiBWNGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:06:22 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1329859C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:05:54 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so1015775wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6Iisim3PKzqx+0SuQ2EiWiTngQbIiBBSQFYW4bmZFG4=;
        b=xL6fA/11WclCJM2MxlSqzWBaUxk7fA+4OI+SITJI3HuBC6aQNHwmvUdRbzI1PWCJjl
         nouFQQhqbAdlbueFM4m4nechphstnnVXOLaT+TT5I1cZyq1ZPuPhF4HtYie6PMauU2Xm
         O5y8ACzbRTCySsiNoG6ClSYFzXpaVUE25zrItpI4eg7w2gdceTjzAoMqekdca/mwhw2A
         0X4OPqCP0xw5cQdDChXDAKGE2Ptt3GNilnfvPJ8MJzcV8cI1QihpzAVp+jpbSy84uxJA
         kpLQ+TDO5gjA0kM/GLr8jOWm0+Gk3p8/LGu0A7nCV+J5YODK8d8N5fL0XBhB1Yox5U0G
         ArZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6Iisim3PKzqx+0SuQ2EiWiTngQbIiBBSQFYW4bmZFG4=;
        b=IvYrWRAEUaHrMpC90uRv2JIdMw4bnGOqERG+Ou8Jiq/263VCpD2MrMfOl6n4lT6n1S
         1SHoWdNYHDGkq8kZwWavhYYHMWwrSq1NOu4n8KTccEBx3elb421EOLHQriLRRIWMmxhc
         3J6hG7VzVpI4FWhpIJwrE7KU1w7E/snNg+IJ7agwoLErHyFqP9XLidWTWZXXLJxnEfv+
         PHGxzBWzTl977Z5kN1nAiNtCQN+O35LGT7bn+Q7TecwK4ujm9Bh22jOF4r92w3UfsQFf
         FovEWPjb5Eo1dASx+hMXJjsfwkqjzyCund7W7u2Jy3ZZOZuH6rav5R2O7/DSEvzzKb/S
         S3aA==
X-Gm-Message-State: AOAM533J510FmOrpgULNyAsjABaRdHwEUosGe89ymBNV0er7ujX5qaCd
        uJA6/Q+1a4Ycg6hGosydvmE1Uw==
X-Google-Smtp-Source: ABdhPJxjlMvrB5Zg7n5QG4YhSseGskPdLA0ieLEpVQkkvGr/YjdvxZNHAECAhketBqw3EMUC5LVe9w==
X-Received: by 2002:a05:600c:4f93:b0:37b:c4c1:e806 with SMTP id n19-20020a05600c4f9300b0037bc4c1e806mr7711932wmq.104.1645621552724;
        Wed, 23 Feb 2022 05:05:52 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id s2sm5334745wmc.45.2022.02.23.05.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 05:05:52 -0800 (PST)
Date:   Wed, 23 Feb 2022 14:05:50 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        herbert@gondor.apana.org.au, davem@davemloft.net
Subject: Re: [PATCH v3] dt-bindings: crypto: convert rockchip-crypto to yaml
Message-ID: <YhYxLmBYa+DMCnuz@Red>
References: <20220211115925.3382735-1-clabbe@baylibre.com>
 <f078ac6f-5605-7b86-5734-cbbf7dc52c71@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f078ac6f-5605-7b86-5734-cbbf7dc52c71@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Feb 15, 2022 at 03:07:56PM +0100, Johan Jonker a écrit :
> Hi Heiko,
> 
> On 2/11/22 12:59, Corentin Labbe wrote:
> > Convert rockchip-crypto to yaml
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> > Changes since v1:
> > - fixed example
> > - renamed to a new name
> > - fixed some maxItems
> > 
> > Change since v2:
> > - Fixed maintainers section
> > 
> >  .../crypto/rockchip,rk3288-crypto.yaml        | 66 +++++++++++++++++++
> >  .../bindings/crypto/rockchip-crypto.txt       | 28 --------
> >  2 files changed, 66 insertions(+), 28 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> 
> rockchip,crypto.yaml


Hello

DT maintainer asked for rockchip,rk3288-crypto, so I will keep it.

> 
> >  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> > new file mode 100644
> > index 000000000000..2e1e9fa711c4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> > @@ -0,0 +1,66 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/crypto/rockchip,rk3288-crypto.yaml#
> 
> rockchip,crypto.yaml
> 
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip Electronics And Security Accelerator
> > +
> > +maintainers:
> > +  - Heiko Stuebner <heiko@sntech.de>
> > +
> > +properties:
> > +  compatible:
> 
>     oneOf:
>       - const: rockchip,rk3288-crypto
>       - items:
>           - enum:
>               - rockchip,rk3228-crypto
>               - rockchip,rk3328-crypto
>               - rockchip,rk3368-crypto
>               - rockchip,rk3399-crypto
>           - const: rockchip,rk3288-crypto
> 
> rk3288 was the first in line that had support, so we use that as fall
> back string.

I will dont add compatible which are not handled by the driver unless DT maintainer said I should.

> 
> > +    const: rockchip,rk3288-crypto
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: clock data
> > +      - description: clock data
> > +      - description: clock crypto accelerator
> 
> > +      - description: clock dma
> 
> remove ???
> 
> > +
> > +  clock-names:
> > +    items:
> > +      - const: aclk
> > +      - const: hclk
> > +      - const: sclk
> 
> > +      - const: apb_pclk
> 
> remove ???
> 
> Similar to the rk3568 pclk_xpcs discussion ACLK_DMAC1 belongs to the
> dmac_bus_s node and should have been enabled by the DMA driver I think.
> Could you advise if this is correct or should we remove parsing/enabling
> ACLK_DMAC1 in rk3288_crypto.c in order to it easier
> porting/adding/syncing nodes for other SoC types?
> 
> Johan

I tested on my rk3328-rock64 and I confirm apb_pclk is unnessecary.
I will issue patch for fixing this.

Regards
