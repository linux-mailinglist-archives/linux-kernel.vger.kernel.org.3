Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8DE468BD3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhLEPiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbhLEPiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:38:14 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2A1C061714;
        Sun,  5 Dec 2021 07:34:47 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g14so32286879edb.8;
        Sun, 05 Dec 2021 07:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UdRPiodimLxKgd3VQYDEd5uUOMLuFtvcHYMaCkDgJKo=;
        b=LWhB8NiPDskeOMed92Cb5webZArYv1R8hg5xqVqgbuwW113yrqc19TfuyGnxhYAl2L
         0p077JWHT49O/BcQwDmuRqD+bwSZ3IQNcrlWoVLbUvLsFQfZKpXbGOrUCRc2B4UtbFao
         jdlxzv9YtBIfKh0ai02n4uaYQ+/iLc/ASG2SyPHNBOog6UspzBY+I7sY8D3uef/UKQv0
         na/Dam19BnFvEDnEjX/vL8ox+1r/jX9ysn1T7a2p/OWAgqz5VeyZ3QyzxdrJREL1Apzj
         b3cotMZ2sn8u+TZCbIQlEqQ1kLqfidfO0CCofsKDDhoHXbh+juwfaF7XZ6n5jlm6w597
         qgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UdRPiodimLxKgd3VQYDEd5uUOMLuFtvcHYMaCkDgJKo=;
        b=dbu6kZ7PGwgXu7m9F8vprl2FKSDd4H9zUdGGLCDZVZuCuNpm/rRwjvk0XTlsfllR/O
         1/wLE4z/oRp+2Tm3APpjOC18v+9vBVSx4CLUem+oUJytw69b9rlgQZy0eO+zqaOhpixj
         0sgwFb3TQXQGWp2lndvBbUbQ5abC8j+b2q+/1jS1fXPbHZ/VKdS1WG5M3FRif41oOX8U
         ti+EWQ00DXOUpbdWnyIPttl5toRoQ0qaVmRKu0wzzrfsAzLNfb20Y0ZH8jfCvXEu2U65
         FRFg/QLP8tVIDx3Ptiy3434/JJdlwDtYjdClyziYUZmdjxIqwuA43Y6F0dIY61zrwYsE
         ruAQ==
X-Gm-Message-State: AOAM531a8P1waB4/K7JZwffKLePbEfQjhW0JkxvqqJwIrtj6JzXYFujk
        Y/RQ6HPObQdtiHULNVDVgHE=
X-Google-Smtp-Source: ABdhPJyKi7+9GFkhUCVMnV1j+vsuLjDrNZJQjsIQ0kZXfuLTG0Svp75g+6ergkFe2GndT5pHQUdK5w==
X-Received: by 2002:a17:907:3d01:: with SMTP id gm1mr39057270ejc.219.1638718486045;
        Sun, 05 Dec 2021 07:34:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.googlemail.com with ESMTPSA id sa17sm5529941ejc.123.2021.12.05.07.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 07:34:45 -0800 (PST)
From:   David Virag <virag.david003@gmail.com>
Cc:     David Virag <virag.david003@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: clock: Add bindings definitions for Exynos7885 CMU
Date:   Sun,  5 Dec 2021 16:32:56 +0100
Message-Id: <20211205153302.76418-3-virag.david003@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205153302.76418-1-virag.david003@gmail.com>
References: <20211205153302.76418-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like on Exynos850, the clock controller driver is designed to have
separate instances for each particular CMU, so clock IDs start from 1
for each CMU in this bindings header too.

Signed-off-by: David Virag <virag.david003@gmail.com>
---
 include/dt-bindings/clock/exynos7885.h | 115 +++++++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 include/dt-bindings/clock/exynos7885.h

diff --git a/include/dt-bindings/clock/exynos7885.h b/include/dt-bindings/clock/exynos7885.h
new file mode 100644
index 000000000000..1f8701691d62
--- /dev/null
+++ b/include/dt-bindings/clock/exynos7885.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021 Dávid Virág
+ *
+ * Device Tree binding constants for Exynos7885 clock controller.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_EXYNOS_7885_H
+#define _DT_BINDINGS_CLOCK_EXYNOS_7885_H
+
+/* CMU_TOP */
+#define CLK_FOUT_SHARED0_PLL		1
+#define CLK_FOUT_SHARED1_PLL		2
+#define CLK_DOUT_SHARED0_DIV2		3
+#define CLK_DOUT_SHARED0_DIV3		4
+#define CLK_DOUT_SHARED0_DIV4		5
+#define CLK_DOUT_SHARED0_DIV5		6
+#define CLK_DOUT_SHARED1_DIV2		7
+#define CLK_DOUT_SHARED1_DIV3		8
+#define CLK_DOUT_SHARED1_DIV4		9
+#define CLK_MOUT_CORE_BUS		10
+#define CLK_MOUT_CORE_CCI		11
+#define CLK_MOUT_CORE_G3D		12
+#define CLK_DOUT_CORE_BUS		13
+#define CLK_DOUT_CORE_CCI		14
+#define CLK_DOUT_CORE_G3D		15
+#define CLK_GOUT_CORE_BUS		16
+#define CLK_GOUT_CORE_CCI		17
+#define CLK_GOUT_CORE_G3D		18
+#define CLK_MOUT_PERI_BUS		19
+#define CLK_MOUT_PERI_SPI0		20
+#define CLK_MOUT_PERI_SPI1		21
+#define CLK_MOUT_PERI_UART0		22
+#define CLK_MOUT_PERI_UART1		23
+#define CLK_MOUT_PERI_UART2		24
+#define CLK_MOUT_PERI_USI0		25
+#define CLK_MOUT_PERI_USI1		26
+#define CLK_MOUT_PERI_USI2		27
+#define CLK_DOUT_PERI_BUS		28
+#define CLK_DOUT_PERI_SPI0		29
+#define CLK_DOUT_PERI_SPI1		30
+#define CLK_DOUT_PERI_UART0		31
+#define CLK_DOUT_PERI_UART1		32
+#define CLK_DOUT_PERI_UART2		33
+#define CLK_DOUT_PERI_USI0		34
+#define CLK_DOUT_PERI_USI1		35
+#define CLK_DOUT_PERI_USI2		36
+#define CLK_GOUT_PERI_BUS		37
+#define CLK_GOUT_PERI_SPI0		38
+#define CLK_GOUT_PERI_SPI1		39
+#define CLK_GOUT_PERI_UART0		40
+#define CLK_GOUT_PERI_UART1		41
+#define CLK_GOUT_PERI_UART2		42
+#define CLK_GOUT_PERI_USI0		43
+#define CLK_GOUT_PERI_USI1		44
+#define CLK_GOUT_PERI_USI2		45
+#define TOP_NR_CLK			46
+
+/* CMU_CORE */
+#define CLK_MOUT_CORE_BUS_USER		1
+#define CLK_MOUT_CORE_CCI_USER		2
+#define CLK_MOUT_CORE_G3D_USER		3
+#define CLK_MOUT_CORE_GIC		4
+#define CLK_DOUT_CORE_BUSP		5
+#define CLK_GOUT_CCI_ACLK		6
+#define CLK_GOUT_GIC400_CLK		7
+#define CORE_NR_CLK			8
+
+/* CMU_PERI */
+#define CLK_MOUT_PERI_BUS_USER		1
+#define CLK_MOUT_PERI_SPI0_USER		2
+#define CLK_MOUT_PERI_SPI1_USER		3
+#define CLK_MOUT_PERI_UART0_USER	4
+#define CLK_MOUT_PERI_UART1_USER	5
+#define CLK_MOUT_PERI_UART2_USER	6
+#define CLK_MOUT_PERI_USI0_USER		7
+#define CLK_MOUT_PERI_USI1_USER		8
+#define CLK_MOUT_PERI_USI2_USER		9
+#define CLK_GOUT_GPIO_TOP_PCLK		10
+#define CLK_GOUT_HSI2C0_PCLK		11
+#define CLK_GOUT_HSI2C1_PCLK		12
+#define CLK_GOUT_HSI2C2_PCLK		13
+#define CLK_GOUT_HSI2C3_PCLK		14
+#define CLK_GOUT_I2C0_PCLK		15
+#define CLK_GOUT_I2C1_PCLK		16
+#define CLK_GOUT_I2C2_PCLK		17
+#define CLK_GOUT_I2C3_PCLK		18
+#define CLK_GOUT_I2C4_PCLK		19
+#define CLK_GOUT_I2C5_PCLK		20
+#define CLK_GOUT_I2C6_PCLK		21
+#define CLK_GOUT_I2C7_PCLK		22
+#define CLK_GOUT_PWM_MOTOR_PCLK		23
+#define CLK_GOUT_SPI0_PCLK		24
+#define CLK_GOUT_SPI0_EXT_CLK		25
+#define CLK_GOUT_SPI1_PCLK		26
+#define CLK_GOUT_SPI1_EXT_CLK		27
+#define CLK_GOUT_UART0_EXT_UCLK		28
+#define CLK_GOUT_UART0_PCLK		29
+#define CLK_GOUT_UART1_EXT_UCLK		30
+#define CLK_GOUT_UART1_PCLK		31
+#define CLK_GOUT_UART2_EXT_UCLK		32
+#define CLK_GOUT_UART2_PCLK		33
+#define CLK_GOUT_USI0_PCLK		34
+#define CLK_GOUT_USI0_SCLK		35
+#define CLK_GOUT_USI1_PCLK		36
+#define CLK_GOUT_USI1_SCLK		37
+#define CLK_GOUT_USI2_PCLK		38
+#define CLK_GOUT_USI2_SCLK		39
+#define CLK_GOUT_MCT_PCLK		40
+#define CLK_GOUT_SYSREG_PERI_PCLK	41
+#define CLK_GOUT_WDT0_PCLK		42
+#define CLK_GOUT_WDT1_PCLK		43
+#define PERI_NR_CLK			44
+
+#endif /* _DT_BINDINGS_CLOCK_EXYNOS_7885_H */
-- 
2.34.1

