Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115264DD7D9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbiCRKVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbiCRKVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:21:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F141EFE06
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:20:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso4572900wmr.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YYBm1RX0czLMaWTTQInKeCgdVYhgkLcZ7jFkas/Rfhs=;
        b=AUl19gddWU+TGkn91rwswKtkRuunsoS1xg6IvUppECEb8oSzjSfXJv2d87cqXYs3Yy
         95nkaF7kHo7GBGVTNaBNkuO6Rp5JM8YHyT8tVX8NcbKasWURoUqgjvOhVr+6gsjwxf67
         6VqySP3QaYydQWitA3XNyI6fTecEOPfuXE2b/2PqMFm9CN17Tvi8nhCUC2lm71oY1H+o
         2GWqd42sqZxKapISXzA8vBpYH53HlV8UMGJz1fKwf0WuqukOHYuMyfohAKbTkm1O00uV
         wU2oONr93WQy0UguF3b7ebHHu3pc+OUgVdXyQBp284tjYnM5VG8acVPte/GGuH+vp6P+
         tK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YYBm1RX0czLMaWTTQInKeCgdVYhgkLcZ7jFkas/Rfhs=;
        b=yvFhEM56Moay41IVblcmJx1QXmeJVep81d7ZqlAOiUe4V8KqP9LU1qLcZ8nlhU1nyV
         QPjqVPH2dwMWiebqSicT+w4NeMndoZOkdo6DJXhy1C/Um6L0SRkBE/87rQsiYrInpjjT
         QwzRrL3ahaHxuXIHAqRC4FRzpdv81aY+1Pm4KxbRzP8BvoriW7+T/GPPuJERcEKm8M0b
         SVOn1QgByaWIjZvg59vtpCSTfjzM+4Zn957avS2iy6b7gN6Z0hK8nn/r6QsevITIoDth
         LZQNrKOuCcuWoUfUFCbGX46rqMuh7gXA3SSorYbPqy+DjSxpnQwp5juCSj/UsNJndoru
         81eQ==
X-Gm-Message-State: AOAM532lKImldVBgaLVs8IrRTRNGtsmVUTIy940cpP1O5ZIxAMTT8z4s
        mbQlheiEoPZ0RMsPaOVj19wLVA==
X-Google-Smtp-Source: ABdhPJykd7CP6qm5/RS39Zs+vu5rb4PuIDjEBZiEVPnAb1oCr3QXbjSKOIF+Kzx93wjR66zRLBNlTA==
X-Received: by 2002:a7b:c7c3:0:b0:389:cbf1:fadf with SMTP id z3-20020a7bc7c3000000b00389cbf1fadfmr15021009wmk.147.1647598802494;
        Fri, 18 Mar 2022 03:20:02 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id f10-20020adffcca000000b00203e6a34d3esm5889436wrs.99.2022.03.18.03.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 03:20:01 -0700 (PDT)
Date:   Fri, 18 Mar 2022 11:20:00 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        herbert@gondor.apana.org.au, davem@davemloft.net
Subject: Re: [PATCH v3] dt-bindings: crypto: convert rockchip-crypto to yaml
Message-ID: <YjRc0Cf8m/kpcwAQ@Red>
References: <20220211115925.3382735-1-clabbe@baylibre.com>
 <f078ac6f-5605-7b86-5734-cbbf7dc52c71@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f078ac6f-5605-7b86-5734-cbbf7dc52c71@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
> 

Hello

I came back on this as I got access to a rk3288-miqi, and crypto does not work at all.
This is due to ACLK_DMAC1 not being enabled.

While not touching it work on rk3399 and rk3328, rk3288 seems to need it.

Probably the DMA controller goes to sleep under PM.

Any idea on how to create a dependency so dma controller does not sleep ?
