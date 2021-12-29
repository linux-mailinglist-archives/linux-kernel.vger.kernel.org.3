Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A63F4812DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 13:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbhL2MrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 07:47:19 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39820
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238986AbhL2MrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 07:47:13 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C1961402EC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640782031;
        bh=b8unpukURFoj9tYv6hEHKZIOPqKdbI+UT8tS2dxzJ3A=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=R4ZIwpfuxfIM8Fel1C+ZHbPMbz/8dB64avjBxLCwqNhsguXVTn8rbVU2Vuci4ic93
         1xr6BuQMSIy3gMMjX8Gg+POP09tLBICqyiguX3eD8FZZp4eb7OmWN5hR/nfcqUKDNz
         Z6U/zv36ahIqJF2vvcPfLOkji6gVN5sKgD6WCaAJowVB6Gmt5cH+nrK7wMMVqiMhZI
         7LB+oUFscOiXd8JGDbD7u9qR60LJbRndTM0m3F/Fy+Sc4qPkqJcUe9Oyzya+1uTsy+
         SlnBKhwYdO4ZBdAqJVGi/vQtTGRTKPbHqAzegSBIBJPgeDW1r6kD5eQkauamA69bu5
         nFVLQWRtBeSkA==
Received: by mail-lj1-f199.google.com with SMTP id u9-20020a05651c140900b0022dd165d92bso3653902lje.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 04:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b8unpukURFoj9tYv6hEHKZIOPqKdbI+UT8tS2dxzJ3A=;
        b=SF1DlqAdYbY/ngA1ECFRjucsR0PDVxFLKhsBtU/Ew9pNCCcjiPzlH9uhg/Be8qGJNF
         ttCDQpknMF7pG6oU0/nrmyBKj7Y3GhLMnzzQ4iP+lQ397Aohdxg4HVwa1mk0b6V9Xkyj
         uguMLKhnwITdq1jlPl7KRWewWyjDYTVaV64pDYofXw5k84GkFcfTB2Ci5mhOgf7Xg0g+
         h2CLXzqQXBSfDXcLU5Gq25F6AWDVVvZpOcf5bGHgm6uouL9SvSrNEknA+bKFEpel7RB2
         W2s1DgLWtV6eKiMklV8EMeHONmtoZkLRYMRMCzj8xfLmGrP4pLblF5ZgjVmhFWdrCIfr
         8gzg==
X-Gm-Message-State: AOAM531kF4Im0PRHnUwBCJAbqQtUuKcEb6l5nB5YYUnsKWtExM7cF/TE
        MV+8izPtM86VuGmxOXh1ES2jdow4EyeAoOMPLY4RC57bi9dFWnx2a4TgXiZT6IyAFXO0PmtI1gI
        nuzjrLxm+R7gWBx5GT5EL9l//gNzyZghMQ3YhZTtnzw==
X-Received: by 2002:a2e:574b:: with SMTP id r11mr16745438ljd.489.1640782027276;
        Wed, 29 Dec 2021 04:47:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLiHFDic96sN498wDn0DRNBEIHxbIVncu3lh3X6e7AC89ghZepVCvnmS0/L/+JzAFD33udSA==
X-Received: by 2002:a2e:574b:: with SMTP id r11mr16745428ljd.489.1640782027109;
        Wed, 29 Dec 2021 04:47:07 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id e11sm711158ljn.73.2021.12.29.04.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 04:47:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 5/5] MAINTAINERS: mfd: cover MAX77843 by Maxim PMIC/MUIC for Exynos boards entry
Date:   Wed, 29 Dec 2021 13:46:31 +0100
Message-Id: <20211229124631.21576-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211229124631.21576-1-krzysztof.kozlowski@canonical.com>
References: <20211229124631.21576-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX77843 is used in Exynos5433-based TM2 boards and shares some
parts of code with MAX77693 (regulator and haptic motor drivers).
Include all MAX77843 drivers in the entry for Maxim PMIC/MUIC drivers
for Exynos boards, so they will receive some dedicated review coverage.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5f2758531bc..d1f8f312f322 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11693,8 +11693,10 @@ L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
+F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
 F:	Documentation/devicetree/bindings/mfd/max14577.txt
+F:	drivers/*/*max77843.c
 F:	drivers/*/max14577*.c
 F:	drivers/*/max77686*.c
 F:	drivers/*/max77693*.c
-- 
2.32.0

