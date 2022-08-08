Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FBE58C431
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242012AbiHHHhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238022AbiHHHgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:36:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE73D63F5;
        Mon,  8 Aug 2022 00:36:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v3so9939701wrp.0;
        Mon, 08 Aug 2022 00:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=GRGLnW8E8mUO0LyGXfRjcXOiLBVZkZP5SwK6+3yfymY=;
        b=pqsP5mwjn/PwKN5JoyrF2z9QV6yFEslOYjydd0881rKkM8XN+ZbEK3+v0Bcnf8TKh+
         pEtw5/BNUrlvyDbPActG/kyobneLgVov7BC4vENj1UNQsSHcA+ZevxWsM5dftFDcE1Pn
         OaQ/bEM2Ljzi4Uu3bSiARyVInllJVxMCjGxha7P8e1iHUX62ttDDalU1yTtfIr1aL7hX
         ol/0wCSV/GoHrWpi2ROun9LP1/AjvpHMQHZiiHOK9Ds+kIuLgWGa2wAunuPAdZ85YOnA
         gCYGP++ZkSJrH5IwmfwabVe7BgCurF+vHXoA0yFtpJT/IHZBGx46HF6lmKh65HNX9sIO
         qEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GRGLnW8E8mUO0LyGXfRjcXOiLBVZkZP5SwK6+3yfymY=;
        b=JHRm9h91HN+kMKUpTMTJVPpCawDK+Ak2oWeXluQkalQRh/tkHaH5+chZduB+L0YQxx
         WcCbKrY1Nx+eTBXbZJRmsnr9TK4jP+DLhr7vPrR0pMhSso86c+mc+u0rNAyiw/vDJANr
         Sr2kMTotvhRwxQRKqhvMoIz8kQumoSFxuLF+S518N4peMcKRFrJnqKmjVRltXzfIDTec
         o3/CNPO8Akc2iJcbKCl2Cz6IL+vaWa3i5eoX2ixi6WdhqOHuFQsqY0vS9UeFqgZK2TST
         NBVzd+1d9fIh8dOFTEkJsGzoQZHRUQEqnOGUOYuuzDwmlOhTHtbQqH9PryYnu3EggMEI
         Vm1Q==
X-Gm-Message-State: ACgBeo2BVDvqmi19goC3Xx3Ue1J2uFCW7YGVx3xlkwqBZDqXukwJvsvg
        hUZwWmoQIAMDpQn93Uz6ehs=
X-Google-Smtp-Source: AA6agR6/62/dTqrwa3mqy8I8sCk6wBeYtOXfYO6mRdP1NgxoND/JnjOUjTwASVvTe738TbbKB8Xf+Q==
X-Received: by 2002:a05:6000:168e:b0:220:87da:c3e4 with SMTP id y14-20020a056000168e00b0022087dac3e4mr10249256wrd.559.1659944202363;
        Mon, 08 Aug 2022 00:36:42 -0700 (PDT)
Received: from localhost.localdomain ([105.235.133.111])
        by smtp.gmail.com with ESMTPSA id cc11-20020a5d5c0b000000b002205ffe88edsm8333364wrb.31.2022.08.08.00.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 00:36:42 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] soc: qcom: Add PMIC secure register write helpers
Date:   Mon,  8 Aug 2022 08:34:57 +0100
Message-Id: <20220808073459.396278-7-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808073459.396278-1-y.oudjana@protonmail.com>
References: <20220808073459.396278-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Some peripheral blocks in Qualcomm PMICs such as some in the
switch-mode battery charger and fuel gauge of PMI8994 and later
have secure registers that need to be unlocked first before being
written to. Add some helper functions to do what is needed to
write to those registers.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 MAINTAINERS                       |  6 +++
 drivers/soc/qcom/Kconfig          |  4 ++
 drivers/soc/qcom/Makefile         |  1 +
 drivers/soc/qcom/pmic-sec-write.c | 82 +++++++++++++++++++++++++++++++
 include/soc/qcom/pmic-sec-write.h |  9 ++++
 5 files changed, 102 insertions(+)
 create mode 100644 drivers/soc/qcom/pmic-sec-write.c
 create mode 100644 include/soc/qcom/pmic-sec-write.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e9f5893c0eb..f6cf3a27d132 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16942,6 +16942,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
 F:	drivers/mtd/nand/raw/qcom_nandc.c
 
+QUALCOMM PMIC SECURE WRITE HELPERS
+M:	Yassine Oudjana <y.oudjana@protonmail.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/soc/qcom/pmic-sec-write.c
+
 QUALCOMM RMNET DRIVER
 M:	Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
 M:	Sean Tranchetti <quic_stranche@quicinc.com>
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e0d7a5459562..ecc3aeb75ba7 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -91,6 +91,10 @@ config QCOM_PDR_HELPERS
 	tristate
 	select QCOM_QMI_HELPERS
 
+config QCOM_PMIC_SEC_WRITE
+	tristate
+	depends on REGMAP
+
 config QCOM_QMI_HELPERS
 	tristate
 	depends on NET
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index d66604aff2b0..058f499820cd 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -29,3 +29,4 @@ obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
 obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
 obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
 obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
+obj-$(CONFIG_QCOM_PMIC_SEC_WRITE)	+= pmic-sec-write.o
diff --git a/drivers/soc/qcom/pmic-sec-write.c b/drivers/soc/qcom/pmic-sec-write.c
new file mode 100644
index 000000000000..8072c6115f2e
--- /dev/null
+++ b/drivers/soc/qcom/pmic-sec-write.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Helper functions for secure register writes on Qualcomm PMICs
+ */
+
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+
+#define SEC_ACCESS_ADDR		0x00d0
+#define SEC_ACCESS_VALUE	0x00a5
+#define PERPH_BASE_MASK		0xff00
+
+static DEFINE_SPINLOCK(sec_access_lock);
+
+/**
+ * @brief qcom_pmic_sec_write() - Write to a secure register
+ *
+ * @param regmap Pointer to regmap
+ * @param addr   Address of register to write into
+ * @param val    Buffer to write bytes from
+ * @param len    Length of register in bytes
+ * @return 0 on success, -errno on failure
+ *
+ * @details: Some blocks have registers that need to be unlocked first before
+ * being written to. This function unlocks secure registers in the peripheral
+ * block of a given register then writes a given value to the register.
+ */
+int qcom_pmic_sec_write(struct regmap *regmap, u16 addr, u8 *val, int len)
+{
+	unsigned long flags;
+	unsigned int perph_base;
+	int ret;
+
+	spin_lock_irqsave(&sec_access_lock, flags);
+
+	/* Get peripheral base of given register */
+	perph_base = (addr & PERPH_BASE_MASK);
+
+	ret = regmap_write(regmap, perph_base + SEC_ACCESS_ADDR,
+			   SEC_ACCESS_VALUE);
+	if (ret)
+		goto out;
+
+	ret = regmap_bulk_write(regmap, addr, val, len);
+out:
+	spin_unlock_irqrestore(&sec_access_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_pmic_sec_write);
+
+/**
+ * @brief qcom_pmic_sec_masked_write() - Masked write to secure registers
+ *
+ * @param regmap Pointer to regmap
+ * @param addr   Address of register to write into
+ * @param mask   Mask to apply on value
+ * @param val    value to be written
+ * @return 0 on success, -errno on failure
+ *
+ * @details: Masked version of smbchg_sec_write().
+ */
+int qcom_pmic_sec_masked_write(struct regmap *regmap, u16 addr, u8 mask, u8 val)
+{
+	int reg;
+	int ret;
+
+	ret = regmap_read(regmap, addr, &reg);
+	if (ret)
+		return ret;
+
+	reg &= ~mask;
+	reg |= val & mask;
+
+	return qcom_pmic_sec_write(regmap, addr, (u8 *)&reg, 1);
+}
+EXPORT_SYMBOL_GPL(qcom_pmic_sec_masked_write);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Qualcomm PMIC secure write helpers");
+MODULE_LICENSE("GPL");
diff --git a/include/soc/qcom/pmic-sec-write.h b/include/soc/qcom/pmic-sec-write.h
new file mode 100644
index 000000000000..cc2229620ca4
--- /dev/null
+++ b/include/soc/qcom/pmic-sec-write.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_ARCH_QCOM_PMIC_SEC_WRITE_H__
+#define __SOC_ARCH_QCOM_PMIC_SEC_WRITE_H__
+
+int qcom_pmic_sec_write(struct regmap *regmap, u16 addr, u8 *val, int len);
+int qcom_pmic_sec_masked_write(struct regmap *regmap, u16 addr, u8 mask, u8 val);
+
+#endif
-- 
2.37.1

