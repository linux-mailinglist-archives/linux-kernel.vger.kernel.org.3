Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8088A4A3126
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 18:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352956AbiA2Rxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 12:53:47 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36154
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352799AbiA2Rxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 12:53:40 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2F2473F203
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 17:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643478819;
        bh=91aS3XOwWU5WTC4z2AKsnFVg6zaKlD32D1AoEn9HL0o=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=E21VNXUt524h0sbVwI4fgzz/YBSyybn5SY8Im7+UN2sXYdWxO/os+LcA2X6ccf55n
         DM+yYRs3Ot6KVWm00PXxnYs2X0i2TG02C76T8b7hCfeWSep/pcqoYhmbpOMriIy2cV
         q8vJ9Si7pqIWgmQwwimrjnxZg345PIO6gawwk5zEBSD5v/6PWI9UvwjBaPS0xO3gTa
         DW+8OpDDjI+E3APGTppf/Pik2j8r8s4S7FyLWVy8fvgEiGn1pMx85buqVwKgqe0KqV
         1bfp1GIIadGa4Bm8We3pBD0bBLlcBv9iH/8i8S0ZERdYGT9BeP7o2/PILyVNt8vpEx
         MaoKMIll97FWg==
Received: by mail-ed1-f72.google.com with SMTP id o25-20020a056402039900b0040631c2a67dso4637202edv.19
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 09:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91aS3XOwWU5WTC4z2AKsnFVg6zaKlD32D1AoEn9HL0o=;
        b=FtVeh/9sqVN+oHD3CLuJTqH9/5VTriwaBmM3oXG9axwOrtawQ+9d8aiJhovoiYC5IJ
         rXgEQSF5flTJRo3afmgqZ+X1AKXE2hELTQvorbsP1f40G/N3g6JHCL7ouZ7ffKsFbnEt
         0GXPOL9GTNotWpr/gNyCapkoVSXt27iExgPQfBhgUrZmmJZJcW03qMRXFIMtVh/8ZcX9
         i3RaIodraakOUpGiXa+slhhOlCEBcSGR85vF/61KYFRHd5Q34Ows9UZNf7izFUqbIXTp
         VdAJ3EA/B+WSTUmt3PPHo+FjN2Gz/jXaA8E09+FKK2jI+74dmsMofI6emJDYvDl0Wq+c
         f3EQ==
X-Gm-Message-State: AOAM530vB8h2YPtGXGh6JgID2dRhT+xcE3JeT58vcbsPtiG8lCmnJmlB
        LiWyOU4g6WV/E5t+imJVcve9WF7spNhCNxKc+rXNPc8kNpYIT/Q0qnIvTlshcT5a9KTwNsKTosH
        5QlL09r0vxMUlmQV9j528dPKMZN8QJEC9IPUo6xKSdw==
X-Received: by 2002:a17:907:a421:: with SMTP id sg33mr11650257ejc.108.1643478817848;
        Sat, 29 Jan 2022 09:53:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVNBn0kTfD4ogoNz392MYFzdBWozh3HfQi6t0ug4M8C7NNR8mOzvuDFSeROfurwcbyoSTatw==
X-Received: by 2002:a17:907:a421:: with SMTP id sg33mr11650253ejc.108.1643478817711;
        Sat, 29 Jan 2022 09:53:37 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id s12sm11236266ejx.184.2022.01.29.09.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 09:53:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 3/5] mfd: exynos-lpass: Drop unneeded syscon.h include
Date:   Sat, 29 Jan 2022 18:53:30 +0100
Message-Id: <20220129175332.298666-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
References: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscon regmap is not used since commit addebf1588ab ("mfd: exynos-lpass:
Remove pad retention control").

Fixes: addebf1588ab ("mfd: exynos-lpass: Remove pad retention control")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mfd/exynos-lpass.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index 99bd0e73c19c..166cd21088cd 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
-- 
2.32.0

