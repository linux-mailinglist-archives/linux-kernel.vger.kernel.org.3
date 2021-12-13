Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AD8472AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbhLMLMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:12:55 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:34854
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234581AbhLMLMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:12:54 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 713FC3F20A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639393973;
        bh=dyuKF4BAHeuRIOQc7e3kDFRJ6K0OTMq0h/Tat1BAxlc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=bMcMhcJx4Qmdx7M+4YSzxBFcG7oULWmH5m0uheenK5pB0u3Q77fjribG3A2ygBTbo
         waJE178hQc/GfsdlddXXT/xxpXxaqekVL+PgxfJpirPDnxHq34SWzCZTR19iK2NsIm
         MOs0VpF615RdenN5UCFozy7ThebRvVCNXnCntExZKTVRbvECzdr9uCjRd168IAXn+6
         mjEvUrbtvokZkyEUYGvgq2tFTZCjLL9DEkwzrHb2GYY2Q+ENJzaETFYQC4TZJ42CQT
         ZpyWRwENf04szZ9kl9WxpiQuc8Ze9MQXQyzkXmzMRJ+aiX46Zw10QmGNV8UW7rP2Or
         E7RwYquC3ib6g==
Received: by mail-lf1-f72.google.com with SMTP id q13-20020a19f20d000000b0041fcb65b6c7so5131524lfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 03:12:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dyuKF4BAHeuRIOQc7e3kDFRJ6K0OTMq0h/Tat1BAxlc=;
        b=jor1NUFgTpheZNVIE+b5Zoy0LEapMi4trLokz18gkPBTktZhjwcJT4NAWD9f8+nskz
         mnft9fAyqSFLxsJWZWndxMFATwIiT9iGYfRnxwYSabUGA8gq54Gbv3Pq2MTEMZ7etPxf
         ek36sIwjeWsJXvQ9xd4tkwIrRBrA0ifM6FcpeUXVndMxnCEVCShZmW/JuY3mMDvrxEOo
         1CgEf+sktasA1SGhKqXt3e1adtI1O0ucBmT9Yv6lZBLx69DsZWibv7WfXkMiTUFs0YsG
         UD9XnU8EK7P3AgSKowNg0oZKM26VX+QGcK1rux/B/a0MGRMrzSVcaDmhTYWWBGSujEcG
         HOnQ==
X-Gm-Message-State: AOAM531SO7oVNEsilNdYDMGpvrJFubDQp0sPrah5poLwshiDWsgdj7Yl
        EocJPJ0x7Q8Irf6i/WxjaVwwbofZgF5FoHWKKQCZMcCwtUu9KGjP+8ZeFGr4j193SicUBvmLpQv
        DcANhVJdlfu39HrCtejXNMRFfrFt7dlsQIRv1Dsbwow==
X-Received: by 2002:ac2:4e11:: with SMTP id e17mr28408236lfr.126.1639393971805;
        Mon, 13 Dec 2021 03:12:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1IzXqmfov2eGoZQZq7xcYOB6+DRCqVGkPLZlbedDR/KWTooAqu//trmEodH0hP+3eA1oDOA==
X-Received: by 2002:ac2:4e11:: with SMTP id e17mr28408116lfr.126.1639393970107;
        Mon, 13 Dec 2021 03:12:50 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id i11sm1387791lfu.141.2021.12.13.03.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 03:12:49 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 2/5] soc: samsung: Add USI driver
Date:   Mon, 13 Dec 2021 12:12:42 +0100
Message-Id: <163939390678.7492.6547802857453426522.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211204195757.8600-3-semen.protsenko@linaro.org>
References: <20211204195757.8600-1-semen.protsenko@linaro.org> <20211204195757.8600-3-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Dec 2021 21:57:54 +0200, Sam Protsenko wrote:
> USIv2 IP-core is found on modern ARM64 Exynos SoCs (like Exynos850) and
> provides selectable serial protocol (one of: UART, SPI, I2C). USIv2
> registers usually reside in the same register map as a particular
> underlying protocol it implements, but have some particular offset. E.g.
> on Exynos850 the USI_UART has 0x13820000 base address, where UART
> registers have 0x00..0x40 offsets, and USI registers have 0xc0..0xdc
> offsets. Desired protocol can be chosen via SW_CONF register from System
> Register block of the same domain as USI.
> 
> [...]

Applied, thanks!

[2/5] soc: samsung: Add USI driver
      commit: cc4fcd60ac51d99ef75fa80f14ac6202f46c3dfc

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
