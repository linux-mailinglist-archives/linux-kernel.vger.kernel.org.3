Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CFB56D1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 01:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiGJXGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 19:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiGJXGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 19:06:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4417B10FC0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:06:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o19-20020a05600c511300b003a2de48b4bbso2699388wms.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w2PeNTtURN4eXiGBF6CxKQXSRiBt5jDvHMJleZnMrb8=;
        b=SfvM5oJytjZQ0qgq6y6BcnOrkFe6G++JtjOTDQFIQy2kgaAxgwLpB5KAEhdQ4dKMz8
         HoBc+ochk9ozAdgUZ13Hd59aOuAajgWW+mcNk2uZta1Rod3/cklDhVfxVNBZLtY6j3n9
         DMs9Rfu47zEtjoLQm4yf2J0eUMwvOXkXwrh3RIy3Eavm7GoxQ85kk/KYwqOAe32aIaHr
         Hx4M1hZpVcUo0CZp3kcDklEjgh4BRVuFJR/GVf1kBEiFg4rxNH3WY6BU5dkBDHxSugGZ
         fxOCN3PTL3wdpk3L8tQiP5NSQwhY5JCCh1Lm4StdUnkpP2qNOUb7MtzEWBes5MwEu43z
         89Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w2PeNTtURN4eXiGBF6CxKQXSRiBt5jDvHMJleZnMrb8=;
        b=U+0GrdhN3fOufRW3s7f/K/FnukHFOWZyihgXQ0knuCKhwpeUnZlIl2/ptuVCAyn2tU
         p7d9kM2z7rkegaaNth4lVORPo2VmeuxVV5J2ufGOcuB7m9rY38IrIU7YuFwgwH8jRknC
         cltoZfd35haWv6DErxiLruWRzFRGEpDuckljdLiD3B3ciipYyVWxTGQJrGI+RyJDKHhH
         qpOC1Z8Nl3PNqW91MjyujQW49kVgpawcUZdqX6jwwIEqtOfWiuLwH+vpI+9VTnrpgxmA
         mFYsHs1UW8/JzLYd+zCUfGljfJSyGvVpgpVSPx25GlXoCYy5q9oJ7jtBjFsIY0iG1KDn
         H/2A==
X-Gm-Message-State: AJIora/z7MGU2dN3a3KEV+pEMrEJ8M0UibdEwnlYUWNGcYaeFYccg2h4
        +Hl5xHgBc8p6lT7gN8cewNHm2g==
X-Google-Smtp-Source: AGRyM1sZmV2sI4U7V2nh9Zjsi3UJqRjqwe+PtYS7xEw2DVSpOkpBC8oL9Ojd/vLUIfssJW2LX5R2Pg==
X-Received: by 2002:a05:600c:210d:b0:3a2:e686:e14 with SMTP id u13-20020a05600c210d00b003a2e6860e14mr3277007wml.25.1657494370779;
        Sun, 10 Jul 2022 16:06:10 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id k1-20020adfd841000000b0021d73772c87sm4398867wrl.91.2022.07.10.16.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 16:06:10 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] iommu/exynos: Check if SysMMU v7 has VM registers
Date:   Mon, 11 Jul 2022 02:06:01 +0300
Message-Id: <20220710230603.13526-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220710230603.13526-1-semen.protsenko@linaro.org>
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SysMMU v7 can have Virtual Machine registers, which implement multiple
translation domains. The driver should know if it's true or not, as VM
registers shouldn't be accessed if not present. Read corresponding
capabilities register to obtain that info, and store it in driver data.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Removed the 'const' qualifier for local non-pointer variables

 drivers/iommu/exynos-iommu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 0cb1ce10db51..48681189ccf8 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -135,6 +135,9 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define CFG_SYSSEL	(1 << 22) /* System MMU 3.2 only */
 #define CFG_FLPDCACHE	(1 << 20) /* System MMU 3.2+ only */
 
+#define CAPA0_CAPA1_EXIST		BIT(11)
+#define CAPA1_VCR_ENABLED		BIT(14)
+
 /* common registers */
 #define REG_MMU_VERSION		0x034
 
@@ -154,6 +157,10 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define REG_V5_FAULT_AR_VA	0x070
 #define REG_V5_FAULT_AW_VA	0x080
 
+/* v7.x registers */
+#define REG_V7_CAPA0		0x870
+#define REG_V7_CAPA1		0x874
+
 #define has_sysmmu(dev)		(dev_iommu_priv_get(dev) != NULL)
 
 enum {
@@ -298,6 +305,9 @@ struct sysmmu_drvdata {
 
 	struct iommu_device iommu;	/* IOMMU core handle */
 	const unsigned int *regs;	/* register set */
+
+	/* v7 fields */
+	bool has_vcr;			/* virtual machine control register */
 };
 
 static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
@@ -411,11 +421,27 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
 		MMU_MAJ_VER(data->version), MMU_MIN_VER(data->version));
 }
 
+static bool __sysmmu_has_capa1(struct sysmmu_drvdata *data)
+{
+	u32 capa0 = readl(data->sfrbase + REG_V7_CAPA0);
+
+	return capa0 & CAPA0_CAPA1_EXIST;
+}
+
+static void __sysmmu_get_vcr(struct sysmmu_drvdata *data)
+{
+	u32 capa1 = readl(data->sfrbase + REG_V7_CAPA1);
+
+	data->has_vcr = capa1 & CAPA1_VCR_ENABLED;
+}
+
 static void sysmmu_get_hw_info(struct sysmmu_drvdata *data)
 {
 	__sysmmu_enable_clocks(data);
 
 	__sysmmu_get_version(data);
+	if (MMU_MAJ_VER(data->version) >= 7 && __sysmmu_has_capa1(data))
+		__sysmmu_get_vcr(data);
 	if (MMU_MAJ_VER(data->version) < 5)
 		data->regs = sysmmu_regs[REG_SET_V1];
 	else
-- 
2.30.2

