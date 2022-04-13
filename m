Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEEF4FF420
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiDMJuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiDMJuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:50:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426453B57A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:48:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u15so2741399ejf.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tZnSmOkmR+jnc1UZfEUvwidpiK15ShpCuv6Rr5IrP40=;
        b=Kv5sRMwYbYjLPNYkT5zjBdF/EgxreH/N47wdvm5nxS4NHu5+7YjZKNwfB6J2+iOqq6
         JWv4gaCpGkJMWoOqF4iwlWD7rz/3thNwUfWsUbKZ5GAz6emJexgzZEeWVwxRpmG+Vp2j
         3JjJGJMuH/Gk/lczc/cwgmXRtLattQ+Ozj5MKE0G3OequExU70V9yEqvPoduH67ofMqr
         EdgMJgdH/v8fH2IQpYKnjsXrc1SqCL28IETwFKJ5ZOeT/uuf86Ypt4Vph3dns8VTIeWa
         ++pNvO+ej71sKcfHf9OGYD6um/tYuRQCJL3oM5/aJzjGF1Y1MnnCQ10fW9NlYjxZ7gbp
         GqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tZnSmOkmR+jnc1UZfEUvwidpiK15ShpCuv6Rr5IrP40=;
        b=zTt+c0WcGi4+4stA31QvZI6NehAf0dHs4r0kllW9bFt1ALHp8DHF+56h68C2T5942k
         ex84qBtPUyP2KbrQTOkVoc2qfej0Piddo99BicCTPUjmPuvhvH9+z0wiNpKBfH8SCj8C
         j873hU25VBDxz9JedEu0HcCudCrjFVSqKk/dhI+tJ6H4ChsWRZOyzY3Rg1szsMm5N7e+
         4ysLjlbgpo9yegxO1w+tZ0Ugh4ve/21gf1okBsVnbKQJzMZdNAv3m0p0v8Um3cog2EoM
         jTZyjgeUYUWlb9qHjJse3TCJREn7lW890H1sSfC5eS6uY18pdcgrpvt1cm4gPYH65t2k
         NOTQ==
X-Gm-Message-State: AOAM531SpAAq5Fx50Q30Hz8XXEFulDsOmi7d+T8fzDmluQ3mRG31GjuT
        VpcQftwaHtYofUY2RvuQhTLfDg==
X-Google-Smtp-Source: ABdhPJzbdegU2CQVHT6uOyVuIw7Q9eYpybbyI/IPRdZzTwDNFN1kuCqSxBg21H7LNchwJKPPoU+qaQ==
X-Received: by 2002:a17:906:81ca:b0:6e8:ad09:1951 with SMTP id e10-20020a17090681ca00b006e8ad091951mr7376712ejx.745.1649843295850;
        Wed, 13 Apr 2022 02:48:15 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id k7-20020a17090666c700b006e8688d5fcbsm5320165ejp.135.2022.04.13.02.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:48:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org, linux-mtd@lists.infradead.org,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>
Subject: Re: [PATCH v4] memory: renesas-rpc-if: Fix HF/OSPI data transfer in Manual Mode
Date:   Wed, 13 Apr 2022 11:48:12 +0200
Message-Id: <164984328891.36085.9849925261305937604.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cde9bfacf704c81865f57b15d1b48a4793da4286.1649681476.git.geert+renesas@glider.be>
References: <cde9bfacf704c81865f57b15d1b48a4793da4286.1649681476.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022 14:53:45 +0200, Geert Uytterhoeven wrote:
> HyperFlash devices fail to probe:
> 
>     rpc-if-hyperflash rpc-if-hyperflash: probing of hyperbus device failed
> 
> In HyperFlash or Octal-SPI Flash mode, the Transfer Data Enable bits
> (SPIDE) in the Manual Mode Enable Setting Register (SMENR) are derived
> from half of the transfer size, cfr. the rpcif_bits_set() helper
> function.  However, rpcif_reg_{read,write}() does not take the bus size
> into account, and does not double all Manual Mode Data Register access
> sizes when communicating with a HyperFlash or Octal-SPI Flash device.
> 
> [...]

Applied, thanks!

[1/1] memory: renesas-rpc-if: Fix HF/OSPI data transfer in Manual Mode
      commit: 953d7e7cedb49fec97807166be6fa1ecec1cf0c4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
