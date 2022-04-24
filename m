Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDAC50D280
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 16:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbiDXO5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 10:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239551AbiDXO5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 10:57:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF35615376B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:54:44 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g23so8694627edy.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXaQ5O6aW8iOE3VBZEqJgvs17b11E7AVbZySzMC4mZo=;
        b=lFLRsmUweurnZio4Op9D3iGC6LXYcYZfRxPk4bYIxlu7WaTFQMqqwV/9yf7mQ7FA+9
         uJRb017zkfqE0vUj4jbbRSfmY3FM5Fr63eQN08zS0JkxNODus+apiVB3VUCrod99TaAb
         41RpDVD6xWpqYD0FQuh/l4MmspWZ5Htvi/NVhBzxD6Xi+BqEek/nl0ROvJuyFehoJvWb
         MuONtx6hapPxAMeo1gvfCW8czIqz73J3F57DzPsIqQdjQdF2lYRmy3Wmmxf6DSo9n+1Q
         rDyDS/Q1p+FgPnNHXV8ZFdOMcojlVsUAFHuCHPEpRvMBOofmRsfBdhLYiVkTaxYEtCvf
         vLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXaQ5O6aW8iOE3VBZEqJgvs17b11E7AVbZySzMC4mZo=;
        b=VTcS4ZiKo60q893Y/WWQA3/kWRzLVXSoPaWxxlEEeMxiW+MI/eYKajbOeROVt4bQNm
         AuFB31CBIkkyzwRxwZupcaYiVpSXUkp5T52w+PoYy6HnhmwMADnTl6amgz1Gk5Jf9hxr
         rt71nCHzM/GnlD8MHsS+EL0z4a6hPfbJWI6TExp+2OnE5S1uFXV4BVwgiYBXXqBIpxh2
         zuJyoSC4LJS3qSslN+oytog+NthkGTc9hbSPPmIAX2Gb49BCDMNAMbRMTBpuY1hU/8WT
         Lh4Kf7rvRFMORTB03dt6b/yrmbwPgao4U7el9+yj1qg7/nNEm4U7fvtNpXAkmz24fIgn
         pkUQ==
X-Gm-Message-State: AOAM531P3JewF8HE21SRrHnkkHk1YmkGdHifA7XOzMWXqa8dUrWOUWIR
        xBU7+RRtYeU3w8ZyESj2rI11cA==
X-Google-Smtp-Source: ABdhPJyBj/3ZR5Z4mHJautXp1JxdAru2RHWfVsabA5bNk+VNIPYcKegIT+Ze+i41iNOexvZP+d1MkA==
X-Received: by 2002:a50:eb87:0:b0:425:c3e2:17a9 with SMTP id y7-20020a50eb87000000b00425c3e217a9mr11268271edr.109.1650812083494;
        Sun, 24 Apr 2022 07:54:43 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l17-20020a056402231100b0041d98ed7ad8sm3387712eda.46.2022.04.24.07.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 07:54:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: [RESEND PATCH v2] dt-bindings: timer: exynos4210-mct: describe known hardware and its interrupts
Date:   Sun, 24 Apr 2022 16:54:40 +0200
Message-Id: <165081207650.53958.14139766049160653161.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407194127.19004-1-krzysztof.kozlowski@linaro.org>
References: <20220407194127.19004-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022 21:41:27 +0200, Krzysztof Kozlowski wrote:
> Most of the Samsung Exynos SoCs use almost the same Multi-Core Timer
> block, so only two compatibles were used so far (for Exynos4210 and
> Exynos4412 flavors) with Exynos4210-one being used in most of the SoCs.
> However the Exynos4210 flavor actually differs by number of interrupts.
> 
> Add new compatibles, maintaining backward compatibility with Exynos4210,
> and constraints for number of interrupts.  This allows to exactly match
> the Exynos MCT hardware.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: timer: exynos4210-mct: describe known hardware and its interrupts
      commit: 5fe580196dd9b7d8eb2a99629055bb4ffa00f262

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
