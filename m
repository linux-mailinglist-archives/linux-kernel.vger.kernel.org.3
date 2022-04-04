Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F009F4F1DDA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387207AbiDDVmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379373AbiDDRDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:03:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7382740A22
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:01:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b15so11894029edn.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3H9g58AlHBPTQrDhIy8bA3VbPYT/p5tUvM0gVBca9kM=;
        b=CXS8DhcR4gnY7ZaqZuAj1sRKqwIDzdlFemejqYrMwifHuO/DJTGr9skQ0OhQKwolVi
         IYrbjUrpVFcVTsO/+gwVZbxc3wACQKWMoCliP41cFoxCpTyuRPQ9V2JfrzKUD9xeEBnZ
         9ASHxQXWKVlokRBzUmroiyaGsZag5M8n4ib220T1KlbMVz2BX+KKvoGboHlN3/zWm7xS
         RRrCl5YASsx3E8x2+RqCUyUrEcs/Wp8j0Us5ffs+jvy8yJtPKJouPI8qUYP1OLb1Ir2M
         2GKIAK/R9pTvioW4AJlqijBJj3rb2PUpoli4SgdyI//tldS270UpzzTd33mO50O+7MwV
         gnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3H9g58AlHBPTQrDhIy8bA3VbPYT/p5tUvM0gVBca9kM=;
        b=3mmidaQkYkKLFrIpvfcZpmuK+wlLM7hWNR1kIgAB2+mMwM5lMd3u2wmfWd8aWJpUtW
         RgQmmv6UK9juh33z2KlTqHMA6pKpNHm2cHa2ZmNFrgi+kWWqeMReMHtWyjExqsKSVMhO
         peKBILfkv2AxcvrDDp1evPInJSZVAPraUuLcsBygvCu44YcC/QbZzGDxzgUAAD8BPBjV
         vhDY/xAtHXmWh4hPo5rZeHw1EnoFW0CNzNEsXHMO0GuDRvZC0LqGEv2cCUp3e2tirB27
         ATR83M0sdpbb7yvVgTWzReX75L3dePB7Td/Wp2nSQyIWuK5wHOPup6Zgwxo+04dIZg0M
         uNKg==
X-Gm-Message-State: AOAM533jDcFJx44n+/Q/NURJqHGPNfthMZbxdMPSmUp6PvZ1F245F9ZP
        Gg3kwbyRagAh+tcVRS4aZHYgNJpJblwrtnRp
X-Google-Smtp-Source: ABdhPJwVtuji7QDmg3IAIKiltBHSnjyfm8HAaRf/K80CqRcwNqpO4nk2Qz2pabYVosG1AvuUJmDFCw==
X-Received: by 2002:a50:d0d5:0:b0:41c:be47:b959 with SMTP id g21-20020a50d0d5000000b0041cbe47b959mr1079093edf.337.1649091714542;
        Mon, 04 Apr 2022 10:01:54 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906d18500b006ce371f09d4sm4557770ejz.57.2022.04.04.10.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:01:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 2/3] ARM: dts: exynos: add a specific compatible to MCT
Date:   Mon,  4 Apr 2022 19:01:44 +0200
Message-Id: <164909169270.1688455.18335841373677729835.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225153650.289923-2-krzysztof.kozlowski@canonical.com>
References: <20220225153650.289923-1-krzysztof.kozlowski@canonical.com> <20220225153650.289923-2-krzysztof.kozlowski@canonical.com>
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

On Fri, 25 Feb 2022 16:36:49 +0100, Krzysztof Kozlowski wrote:
> One compatible is used for the Multi-Core Timer on most of the Samsung
> Exynos SoCs, which is correct but not specific enough.  These MCT blocks
> have different number of interrupts, so add a second specific
> compatible to Exynos3250 and all Exynos5 SoCs.
> 
> 

Applied, thanks!

[2/3] ARM: dts: exynos: add a specific compatible to MCT
      commit: cca50a59f60a6b2b5aa2c90d8c173da89f567ee3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
