Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F894974EA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbiAWTPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:15:24 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60382
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229533AbiAWTPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:15:23 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C3C3E3F1C4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642965321;
        bh=kttBDEdyIUQqupR/U1rqVQBMHSd3WLkJ4zI9eGg9wQQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=VIDv2/pZ4QETtUTVPC+VV9HaIGX+hni9eMx83rsLikeO2NpxpvFyszpKpX4o8NhHl
         iQuo4ar5kG/86Kiig6bm/Akn4ohAAckOcJerhkkQ9LepxgzawcpLcMXZLuFhZSRXG3
         MgCpB0kHLFdvXZ4mCFtwkytuOhQEyZfFAsR2DoGmlUA0CUuftoV/xIQpQatNKN7fYN
         IzurB32sF+LYI/4aTwPfGfnjwy4bJl8pRPsY5e6MgTdU0llnMca9ba55Z21ehAncVh
         2ZVMuv9d9Zn7VMube1Xoz8I/m34bHet8UxfFJFwvghPaE3VVHwU96dxAZE4heHWGuZ
         iuNnBGLZmwNpQ==
Received: by mail-ed1-f70.google.com with SMTP id f21-20020a50d555000000b00407a8d03b5fso1718699edj.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kttBDEdyIUQqupR/U1rqVQBMHSd3WLkJ4zI9eGg9wQQ=;
        b=iW/ppKw7xzuHTdbK3LJhsrNUGb3WPgu/ABJwKbUD9JZrT0cccBrbeDMln7MTX+/0Hr
         u4eEjzBHsTS6+5sRU/uehVp0vmqnJklatdPswS1KweibEGyyyi/vZUdVPE7JjR8d4ic4
         G6bZ+SjIDCV/xMdbSnExBRbRE2kjhDEw6pJBMrDk+iM+fdN4n4Y7+nsWN5jyva8G0Qnd
         JUD4c6551VpPEywdCKQYBl4vsQ036cso3TV9yVq4wsf4haHyM4kwN1x8VhqmI2KuJvf5
         SQPTRNBgvhy7qfJ5qgToHIxjqDF0qHZaAQIjdEXXrEGttJt/iYiIr9oG0elJyZl3iKae
         GlTg==
X-Gm-Message-State: AOAM533p5CJ1u/c0DDuqV5x/qe2tq0K4chSHEBdmKrCyuagqyttSIFfC
        WjR2G/jDlkOAzWdmB4F+RQ65GMqp3jl01ofdS0ipxFiIOTkuMkJd58U5OFTTKSI70TXOxe9qNVW
        GOjWfEEnyaHcExtap9wRGl0YMH+cRCXGwC4DCwvQn8w==
X-Received: by 2002:a17:907:3e23:: with SMTP id hp35mr10799028ejc.760.1642965319188;
        Sun, 23 Jan 2022 11:15:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrMCE5tnqRZTbX68vFuTajb/35wJ5WKt4eGBj0OadG/VHHPHLxoIH7afhLw/1dm8/A/bhcVg==
X-Received: by 2002:a17:907:3e23:: with SMTP id hp35mr10799006ejc.760.1642965318935;
        Sun, 23 Jan 2022 11:15:18 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id oz18sm4063910ejb.106.2022.01.23.11.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 11:15:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     semen.protsenko@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Henrik Grimler <henrik@grimler.se>, cw00.choi@samsung.com,
        linux-kernel@vger.kernel.org, virag.david003@gmail.com,
        ~postmarketos/upstreaming@lists.sr.ht, robh+dt@kernel.org,
        m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org,
        martin.juecker@gmail.com, alim.akhtar@samsung.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v3 0/3] Add initial support for exynos5420-chagall-wifi
Date:   Sun, 23 Jan 2022 20:15:16 +0100
Message-Id: <164296530944.41526.610812018359584856.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220118185746.299832-1-henrik@grimler.se>
References: <20220118185746.299832-1-henrik@grimler.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2022 19:57:43 +0100, Henrik Grimler wrote:
> Samsung's tablet Galaxy Tab S 10.5" (wifi) has codename Chagall WiFi
> and is one of several tablets released in 2014 based on Exynos 5420.
> This initial devicetree adds support for accessing device over USB or
> UART, and allows using a rootfs in either the internal eMMC or an
> external sdcard.  4 out of 8 CPUs are brought up when device boots,
> which is the same as on the somewhat similar board
> exynos5420-arndale-octa.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: arm: samsung: document Chagall WiFi board binding
      commit: 9998104515d4197d774e5384df750c6384915707
[2/3] ARM: exynos: only do SMC_CMD_CPU1BOOT call on Exynos4
      commit: 534aaa1802eae339d0439feafe3c1217f5643b20
[3/3] ARM: dts: Add support for Samsung Chagall WiFi
      commit: 535f7fffed880312830c72d9c593b59ec741dd8e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
