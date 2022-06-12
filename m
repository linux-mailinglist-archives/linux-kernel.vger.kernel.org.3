Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE67547C26
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 23:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbiFLVJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 17:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiFLVJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 17:09:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE22D75;
        Sun, 12 Jun 2022 14:09:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id s12so7635409ejx.3;
        Sun, 12 Jun 2022 14:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mLPNjDUnvcjmZ4FMqBCTRmEclsWEYRrVtqGZBPO5x7k=;
        b=SjqL5tWU78T5/Uz9HugJ/z0Tg9BpHS0Tf5P5vvdgWNO9JNa5FcCqu/4DftsHA2r7vx
         TmnfLfvFeZb064ZzDB8W3dwDL5ZCA9E1R0smXX9Q990NGgZcmT985MKDpMEEtdhJsy9u
         /7Zhs38nA33vbY8OyKPgvkE5u34Cy1XsQHPfpvlxK5Ejen+40f+VsLJ2GrUeLOShtbcj
         UtynMWGStxnAJ0GVL/pm+FpzO4bU77yreznnBrv8Cap0X9BQQPTU3GAJGWeHMOoKP6Vl
         ArmBZkCcwm6+NjwOJm/o9YHwnoiqmxGLqh74msCXz50P4Pdh553PQ3Wl59/apvD007OQ
         GF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mLPNjDUnvcjmZ4FMqBCTRmEclsWEYRrVtqGZBPO5x7k=;
        b=30KfZPoJFezJIWDBzPLXCpOH+kMVp7Porcg8g28blnQTsDgBqEYsciKmrtnzsEeobd
         iE6PIsL7sMMwSV69dD0Od7bhvbiUbycliU6CnMta19e66A4SAz231vrL6/x+GCnF6v4J
         kjFCrd6HdSwt9uOZ5pPHA974amjMqa1/aYdam1Lgt69lJos+230pZNZLhk0EntVOxY5c
         6eFjflnj96Ma3P6nclJ+5OJEkCU5pbpGHbHmk86xBakqHumuUQjxaXsw9eCu1CvsqbXz
         Z1ko2BxYtvtFJDZ9r6IkfavS2wzt4XdkcG+vyA+X+F63caxvpWmNPCuN0FDN0TN5xt+n
         NpcA==
X-Gm-Message-State: AOAM530N4BOjW5USff//P7sKT1Tzs6GHikMVzS/S6KoodC4m85Xx7581
        yjf97miKLrMHPn+K2los4n0=
X-Google-Smtp-Source: ABdhPJxf8a6zY47Y+E83LFTn8PcaN6GpEYohhYO0tp4yZMZaCK/233usfpgdu80Pfd1WtXcyhDOJ5Q==
X-Received: by 2002:a17:906:3693:b0:718:4125:f08d with SMTP id a19-20020a170906369300b007184125f08dmr2447118ejc.146.1655068149494;
        Sun, 12 Jun 2022 14:09:09 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id io11-20020a17090780cb00b00715c322bda1sm1243661ejc.69.2022.06.12.14.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 14:09:09 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Luca Weiss <luca@z3ntu.xyz>, Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Thierry Reding <treding@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/3] ARM: sunxi: Remove A31 and A23/A33 platform SMP code
Date:   Sun, 12 Jun 2022 23:09:07 +0200
Message-ID: <2833034.e9J7NaK4W3@kista>
In-Reply-To: <20220531045038.42230-1-samuel@sholland.org>
References: <20220531045038.42230-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 31. maj 2022 ob 06:50:35 CEST je Samuel Holland napisal(a):
> This series is preparation for converting the PRCM MFD and legacy clock
> drivers to a CCU clock driver. The platform SMP code references the PRCM
> node to map its MMIO space, which will break when the PRCM node is
> removed/replaced.

Why can't we just leave old platform code? If older dtb file is used, it would 
still work. Actually, isn't trivial to support new CCU binding too, just by 
including new CCU compatible string? IIUC new CCU node will have same address 
as current PRCM node.

Best regards,
Jernej

> 
> Since PSCI has been available for 7+ years, instead of trying to deal
> with the migration, I think it's safe to just delete this code.
> 
> 
> Samuel Holland (3):
>   ARM: sunxi: Remove A31 and A23/A33 platform SMP code
>   ARM: dts: sunxi: Remove obsolete CPU enable methods
>   dt-bindings: arm: Remove obsolete CPU enable methods
> 
>  .../devicetree/bindings/arm/cpus.yaml         |   2 -
>  arch/arm/boot/dts/sun6i-a31.dtsi              |   1 -
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi          |   1 -
>  arch/arm/mach-sunxi/Makefile                  |   1 -
>  arch/arm/mach-sunxi/platsmp.c                 | 194 ------------------
>  5 files changed, 199 deletions(-)
>  delete mode 100644 arch/arm/mach-sunxi/platsmp.c
> 
> -- 
> 2.35.1
> 
> 


