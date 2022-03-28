Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0354E9572
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242532AbiC1Lng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242041AbiC1LeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:34:01 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225D82AF3;
        Mon, 28 Mar 2022 04:25:14 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7F48422248;
        Mon, 28 Mar 2022 13:25:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648466711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zBw+PYlzDnA680TyMVGBJYf23zpR2sb+VpxY5mvvU9I=;
        b=vLCRgnd8MfJftkjWMSnRCUsvnW1ULm+gTn2AMh9LNgY/JQOtNe1qQ+DaQe5IsKkKHboYYw
        jAJN0M27y7MQNQJY/4szyRLF3GP/qjs67iAkkue3bUc/EKwGENMTiSpOpXtTLNxDKj9lu0
        judQLNVfV8u/IgJL/vp8Ock8+KqR2Dw=
From:   Michael Walle <michael@walle.cc>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH v2 1/4] lib: add generic polynomial calculation
Date:   Mon, 28 Mar 2022 13:25:02 +0200
Message-Id: <20220328112505.3025374-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220328112505.3025374-1-michael@walle.cc>
References: <20220328112505.3025374-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some temperature and voltage sensors use a polynomial to convert between
raw data points and actual temperature or voltage. The polynomial is
usually the result of a curve fitting of the diode characteristic.

The BT1 PVT hwmon driver already uses such a polynonmial calculation
which is rather generic. Move it to lib/ so other drivers can reuse it.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 include/linux/polynomial.h |  35 ++++++++++++
 lib/Kconfig                |   3 ++
 lib/Makefile               |   2 +
 lib/polynomial.c           | 108 +++++++++++++++++++++++++++++++++++++
 4 files changed, 148 insertions(+)
 create mode 100644 include/linux/polynomial.h
 create mode 100644 lib/polynomial.c

diff --git a/include/linux/polynomial.h b/include/linux/polynomial.h
new file mode 100644
index 000000000000..9e074a0bb6fa
--- /dev/null
+++ b/include/linux/polynomial.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
+ */
+
+#ifndef _POLYNOMIAL_H
+#define _POLYNOMIAL_H
+
+/*
+ * struct polynomial_term - one term descriptor of a polynomial
+ * @deg: degree of the term.
+ * @coef: multiplication factor of the term.
+ * @divider: distributed divider per each degree.
+ * @divider_leftover: divider leftover, which couldn't be redistributed.
+ */
+struct polynomial_term {
+	unsigned int deg;
+	long coef;
+	long divider;
+	long divider_leftover;
+};
+
+/*
+ * struct polynomial - a polynomial descriptor
+ * @total_divider: total data divider.
+ * @terms: polynomial terms, last term must have degree of 0
+ */
+struct polynomial {
+	long total_divider;
+	struct polynomial_term terms[];
+};
+
+long polynomial_calc(const struct polynomial *poly, long data);
+
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index 087e06b4cdfd..6a843639814f 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -737,3 +737,6 @@ config PLDMFW
 
 config ASN1_ENCODER
        tristate
+
+config POLYNOMIAL
+       tristate
diff --git a/lib/Makefile b/lib/Makefile
index 6b9ffc1bd1ee..89fcae891361 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -263,6 +263,8 @@ obj-$(CONFIG_MEMREGION) += memregion.o
 obj-$(CONFIG_STMP_DEVICE) += stmp_device.o
 obj-$(CONFIG_IRQ_POLL) += irq_poll.o
 
+obj-$(CONFIG_POLYNOMIAL) += polynomial.o
+
 # stackdepot.c should not be instrumented or call instrumented functions.
 # Prevent the compiler from calling builtins like memcmp() or bcmp() from this
 # file.
diff --git a/lib/polynomial.c b/lib/polynomial.c
new file mode 100644
index 000000000000..66d383445fec
--- /dev/null
+++ b/lib/polynomial.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generic polynomial calculation using integer coefficients.
+ *
+ * Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
+ *
+ * Authors:
+ *   Maxim Kaurkin <maxim.kaurkin@baikalelectronics.ru>
+ *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/polynomial.h>
+
+/*
+ * Originally this was part of drivers/hwmon/bt1-pvt.c.
+ * There the following conversion is used and should serve as an example here:
+ *
+ * The original translation formulae of the temperature (in degrees of Celsius)
+ * to PVT data and vice-versa are following:
+ *
+ * N = 1.8322e-8*(T^4) + 2.343e-5*(T^3) + 8.7018e-3*(T^2) + 3.9269*(T^1) +
+ *     1.7204e2
+ * T = -1.6743e-11*(N^4) + 8.1542e-8*(N^3) + -1.8201e-4*(N^2) +
+ *     3.1020e-1*(N^1) - 4.838e1
+ *
+ * where T = [-48.380, 147.438]C and N = [0, 1023].
+ *
+ * They must be accordingly altered to be suitable for the integer arithmetics.
+ * The technique is called 'factor redistribution', which just makes sure the
+ * multiplications and divisions are made so to have a result of the operations
+ * within the integer numbers limit. In addition we need to translate the
+ * formulae to accept millidegrees of Celsius. Here what they look like after
+ * the alterations:
+ *
+ * N = (18322e-20*(T^4) + 2343e-13*(T^3) + 87018e-9*(T^2) + 39269e-3*T +
+ *     17204e2) / 1e4
+ * T = -16743e-12*(D^4) + 81542e-9*(D^3) - 182010e-6*(D^2) + 310200e-3*D -
+ *     48380
+ * where T = [-48380, 147438] mC and N = [0, 1023].
+ *
+ * static const struct polynomial poly_temp_to_N = {
+ *         .total_divider = 10000,
+ *         .terms = {
+ *                 {4, 18322, 10000, 10000},
+ *                 {3, 2343, 10000, 10},
+ *                 {2, 87018, 10000, 10},
+ *                 {1, 39269, 1000, 1},
+ *                 {0, 1720400, 1, 1}
+ *         }
+ * };
+ *
+ * static const struct polynomial poly_N_to_temp = {
+ *         .total_divider = 1,
+ *         .terms = {
+ *                 {4, -16743, 1000, 1},
+ *                 {3, 81542, 1000, 1},
+ *                 {2, -182010, 1000, 1},
+ *                 {1, 310200, 1000, 1},
+ *                 {0, -48380, 1, 1}
+ *         }
+ * };
+ */
+
+/**
+ * polynomial_calc - calculate a polynomial using integer arithmetic
+ *
+ * @poly: pointer to the descriptor of the polynomial
+ * @data: input value of the polynimal
+ *
+ * Calculate the result of a polynomial using only integer arithmetic. For
+ * this to work without too much loss of precision the coefficients has to
+ * be altered. This is called factor redistribution.
+ *
+ * Returns the result of the polynomial calculation.
+ */
+long polynomial_calc(const struct polynomial *poly, long data)
+{
+	const struct polynomial_term *term = poly->terms;
+	long total_divider = poly->total_divider ?: 1;
+	long tmp, ret = 0;
+	int deg;
+
+	/*
+	 * Here is the polynomial calculation function, which performs the
+	 * redistributed terms calculations. It's pretty straightforward.
+	 * We walk over each degree term up to the free one, and perform
+	 * the redistributed multiplication of the term coefficient, its
+	 * divider (as for the rationale fraction representation), data
+	 * power and the rational fraction divider leftover. Then all of
+	 * this is collected in a total sum variable, which value is
+	 * normalized by the total divider before being returned.
+	 */
+	do {
+		tmp = term->coef;
+		for (deg = 0; deg < term->deg; ++deg)
+			tmp = mult_frac(tmp, data, term->divider);
+		ret += tmp / term->divider_leftover;
+	} while ((term++)->deg);
+
+	return ret / total_divider;
+}
+EXPORT_SYMBOL_GPL(polynomial_calc);
+
+MODULE_DESCRIPTION("Generic polynomial calculations");
+MODULE_LICENSE("GPL");
-- 
2.30.2

