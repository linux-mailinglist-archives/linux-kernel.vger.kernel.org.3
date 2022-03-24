Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F224E66E4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351612AbiCXQWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350993AbiCXQWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:22:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8725F9E9CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:20:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h4so7335404wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=u+XoZ+fuIL/ZPqi/MqDlAYN5/s61cbWyTsDVR6ShDXg=;
        b=7x7yo5Bs1LpGDx1Z/m5ZaOu8cUAl21e7wWdU9yxKzW8vX0CjUGxZctK8KwWnscCoVZ
         9LxP65DgHeKtf/hZGwB3qLTaAxg9dIFAjsyvDPXqNwfjZtUKy31VfYnkNC7UVPNVhb6p
         DFWKacToNwykDGrrPa4EO7lI3DYAFLrP9A23HcrD22Cuy78HpnamrgybwQGMWkFwx1vF
         I2bjpDirPChL6lZVg/QNemvqzmFlvAhQfsuXZ3ej8UrR1kv1YekCXLTJiHsiaXPrtTae
         h+qV/ldDYsSEqJnAvk5LP5ZdsoTcHaGCBpcPUfGIqZo9CLNPQOMpHfRMEaa847gLl9Yx
         aBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=u+XoZ+fuIL/ZPqi/MqDlAYN5/s61cbWyTsDVR6ShDXg=;
        b=FhZL1PAYGkU/gUGX+PItdaGfAKT1WDGckXslApMsU9PKMQHWCi2Zc80mFn3+C5WPN0
         fBPWpeBafz6EfpKlgJcztQ5WeVrHkB7IDp7HSbPkaIICFVuuSscdF+dAz6gWOORSlMOV
         T1G7E6qhiZhKqT8ahPQ9YZ/YfYnC/E/3LWzel1hU4Z+ZyqQBlCymYS93Y8r0IO2R4LRu
         lbwIOuXz/uN3ugwFhDeYKWliG2i0wseB80mX2lt1kc5dmJu+xzuYPONBWhLD1vAdZtOa
         4D4MoGGfGRGAm667XDabGUNsbOCv0sXH8y3WbvPbso0svD53+bms3Of/T8C0myw2Ru0/
         lYPA==
X-Gm-Message-State: AOAM533NFIsruukLRIwOKg+j+XwXu8HKQ9+wAgyW86FULznwj5522Tku
        mtIdfgFaXMf/qW8ZeVGhVUXqnA==
X-Google-Smtp-Source: ABdhPJzeYjDJdSI+WUHT0aW2nK8ZdlM/pdZDaZr/eYh34FM+5W0i/XYyjvNvYiq5Hbek/iwW1aWLpQ==
X-Received: by 2002:a05:6000:181a:b0:205:9051:ab6d with SMTP id m26-20020a056000181a00b002059051ab6dmr5239391wrh.191.1648138841944;
        Thu, 24 Mar 2022 09:20:41 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id r2-20020a0560001b8200b00203dffb9598sm2914810wru.86.2022.03.24.09.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:20:41 -0700 (PDT)
Date:   Thu, 24 Mar 2022 17:20:39 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 21/26] dt-bindings: crypto: convert rockchip-crypto to
 yaml
Message-ID: <YjyaV68mTsJAr9Xm@Red>
References: <20220321200739.3572792-1-clabbe@baylibre.com>
 <20220321200739.3572792-22-clabbe@baylibre.com>
 <90ebea0b-1d67-98dc-2b49-a6e3b97a2c4a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90ebea0b-1d67-98dc-2b49-a6e3b97a2c4a@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Mar 22, 2022 at 07:04:43PM +0100, Krzysztof Kozlowski a écrit :
> On 21/03/2022 21:07, Corentin Labbe wrote:
> > Convert rockchip-crypto to yaml
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  .../crypto/rockchip,rk3288-crypto.yaml        | 84 +++++++++++++++++++
> >  .../bindings/crypto/rockchip-crypto.txt       | 28 -------
> >  2 files changed, 84 insertions(+), 28 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> > new file mode 100644
> > index 000000000000..a6be89a1c890
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> > @@ -0,0 +1,84 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/crypto/rockchip,rk3288-crypto.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip Electronics And Security Accelerator
> > +
> > +maintainers:
> > +  - Heiko Stuebner <heiko@sntech.de>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - rockchip,rk3288-crypto
> > +      - rockchip,rk3328-crypto
> > +      - rockchip,rk3399-crypto
> 
> Waaaait, what? Only rockchip,rk3288-crypto is in original bindings.

Hello

Yes, my way is an error.
Next time, I will split my patch in 2, first a 1 to 1 conversion, then a binding update.

> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 4
> > +
> > +  clock-names:
> > +    minItems: 4
> > +
> > +  resets:
> > +    maxItems: 1
> 
> You missed reset-names.
> 
> This patch is quite different than previous, in unexpected way. What
> happened here?
> 
> > +
> > +if:
> 
> Please define it after "allOf:", so it could be easily extended without
> changing indentation.
> 
> > +  properties:
> > +    compatible:
> > +      const: rockchip,rk3399-crypto
> > +then:
> > +  properties:
> > +    reg:
> > +      minItems: 2
> > +    interrupts:
> > +      minItems: 2
> 
> List interrupts. This is really different than your v1. It also looks
> different than original bindings and you did not mention any differences
> here, nor in the commit msg. Either explain in commit msg all
> differences (and why) or move them to separate commit.
> 
> You seem to change the bindings a lot (new properties, different
> constraints, new compatibles), so this should all go to separate commit.
> Now it is just confusing.
> 
> > +    clocks:
> > +      minItems: 6
> 
> You need maxItems. Everywhere.
> 
> > +    clock-names:
> > +      minItems: 6
> 
> List all items.
> 
> > +    resets:
> > +      minItems: 6
> > +else:
> > +  if:
> > +    properties:
> > +      compatible:
> > +        const: rockchip,rk3328-crypto
> > +  then:
> > +    properties:
> > +      clocks:
> > +        minItems: 3
> > +      clock-names:
> > +        minItems: 3
> > +
> 

I have create a binding update patch (https://github.com/montjoie/linux/commit/da05ef9bb488c16cfd15a47054f5b1161829b6bf)
But I have lot of problem, DT are not validating.
Example: Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.example.dtb: crypto@ff8a0000: resets: [[4294967295, 174]] is too short

I have tried also to set default resets/maxItems to 3 and setting it to 4 via an if. But I still got error like maxItems cannot be update after initial set.

Any idea on why my new binding update patch is failling ?

Regards
