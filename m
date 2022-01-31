Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8BA4A496A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbiAaOfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:35:48 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47646
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236840AbiAaOfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:35:46 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7E6773F1D9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643639739;
        bh=mN1fqbFpMzpoEmtDuIC6Dm/iTWIjedREVpcgBANl36k=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=v34Oew5qCDIwwmEhPjtMinFxId7UG7xobhvEKyqWKyxjGjeQZnh7Jgaes+YLIJS18
         It5D9yX/+mxuOHC/KlGKiN6SGIyO1CCA5TLbhoXfs55NlvLHWdqZR7JhhjqWjdBSV7
         XEE2Egb8ZkoZySepjye3gZE/bgGSpU8vUe86l3EVDMGH/St3PPZvxlqhLSshzLKJ36
         EpJFHy7BmAWdg9aqcabyITZX2T5USHsCmrWBPrUkQ8Vm89cfP685d27KXj21lNZibl
         hxsf35B2TAhGMcz7KdIHvbHuPifE/dUa4LyR7zqOndCGEoZChg99w69UaZE1JlO2Py
         RWCI6XJAr4lDQ==
Received: by mail-ed1-f69.google.com with SMTP id en7-20020a056402528700b00404aba0a6ffso7035424edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 06:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mN1fqbFpMzpoEmtDuIC6Dm/iTWIjedREVpcgBANl36k=;
        b=lAXLhfDHRTu0fyzsqACxdfdLgs6zo00opJabKhLc8zxdL2j1GoY3hUHib4LINcYxX6
         r20RAgk0GU5ntTDIyvm0uFlxC8gGMkTSM0KYUqSHk89CuH974k0Ci6O5K4NX75s436kA
         dn/gfDzEAoRRuRjuTi5qMhBAVPGHRGTfse97GUIioMtnGyxIpWJ+jVDJ1Wtq9d2v7yyE
         A2GpFsDLarsq3RTQT+2XpIcVsdr9InR8HDGaXsbLI3fVHSGpY6kQslh9lm+HNtx59N8D
         pBTHZ1+5c22JG7TC2L4I07AsCif+g6BtTnIgd6uqi8upMNKmKKGeQ3QwEdnrq7cgzklo
         uITw==
X-Gm-Message-State: AOAM530vL2QPDLGU3+vLiJ93X5zcnHhjUGBhc6IN4HUyyspasG2bqrT8
        5owYDNH1WkvTrRMhBncDAwFEqCn8pFx+pX+0h5y9bSNtKf7gyXHTUzAN6rmmPl5uHBYlmWuCLZd
        aekO+EYWn2vLSTeMzRjrHI+z3yOQVgeJCvQDlBXiNDw==
X-Received: by 2002:a17:907:3da1:: with SMTP id he33mr16949202ejc.603.1643639738963;
        Mon, 31 Jan 2022 06:35:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4GNJxyhqwfB03F6E6tsE1hPORTToge8FEFloC2ibh4V7CNNEKMKGR1HGsnKFgfIpvlFrbiw==
X-Received: by 2002:a17:907:3da1:: with SMTP id he33mr16949190ejc.603.1643639738818;
        Mon, 31 Jan 2022 06:35:38 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m16sm9971298eji.110.2022.01.31.06.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 06:35:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        David Virag <virag.david003@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Youngmin Nam <youngmin.nam@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v6 0/2] arm64: dts: exynos: Add E850-96 board support
Date:   Mon, 31 Jan 2022 15:35:00 +0100
Message-Id: <164363969164.158734.10738186621268035629.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131130849.2667-1-semen.protsenko@linaro.org>
References: <20220131130849.2667-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 15:08:47 +0200, Sam Protsenko wrote:
> WinLink's E850-96 is a dev board based on Exynos850 SoC [1]. The board's
> design follows 96boards specifications, hence it's compatible with
> 96boards mezzanines [2].
> 
> This patch series adds the initial support for E850-96 board and
> Exynos850 SoC. Only basic platform components are enabled at the moment
> (like serial, I2C, eMMC, RTC, WDT, clock driver, etc). Right now with
> this patch series it's possible to run the kernel with BusyBox rootfs as
> a RAM disk. More features are coming soon.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: exynos: Add initial Exynos850 SoC support
      commit: bfb3c7fa3950f2dece0bfec1df5fbce7117345af
[2/2] arm64: dts: exynos: Add initial E850-96 board support
      commit: 363e52998c839ce77d7d5dd6f3e575bb68449afd

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
