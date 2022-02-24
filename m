Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE94C4C2F73
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbiBXPW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236267AbiBXPWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:22:02 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15FD1B1DED;
        Thu, 24 Feb 2022 07:21:11 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hw13so5059622ejc.9;
        Thu, 24 Feb 2022 07:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZuVEAxmh+A8QIoKXF28VboWqjl4yi9SC0NLu7C8jv84=;
        b=n3Q06AMtyRcuxRSJyhB/yrIWuWgxAFi1LbplrUxmyQN/ZgfzcCKvSQHWSmQDJo55nP
         8Epr2RLKr0und+LLk1hXJ6zP96VRQsHUKNvtk/cDri3dxKGfBmB8boSYFDQf9nqQY2cm
         nyEyP6MzXEA1BKod3YjulPtpl+AFqx79fg6JDlUmJTUWetbjJneVGrbxbnCrA96tvvq/
         Px8XPs2Pm1iwicZxkoAdO0slJAmhzwIj6zFkOTeNM1Mg5EgUxwQNQps3ACEnpxAdRD6x
         jcrTeHWKzTtnj8e+QNuBbZ3OwowpwWvQmKPUrnsO2RYIjwqHXgsEpKtbiJM8MuHxjxYh
         S1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZuVEAxmh+A8QIoKXF28VboWqjl4yi9SC0NLu7C8jv84=;
        b=rSO92k7IlvasJ2ltE7WC9iO+RgH3mQah0B3Eowbys+kcVR8+BaMVilcyW2l8JXZB9n
         tGClhCQHPfpfAJQz5QUQclrTK7xX9NJ/P+hHFu1doW9n66HjmOanQqUcvSfj9kU6rjD0
         iBA3ngyNrtqnX3wiuo515fYOzNJUc85FGV9pcovVxA9GmNpihgMgUSCCFo4RbGNDdPxY
         qHvBXCd55bEpFARquUWL5Av8nv8rz1LqTWvKmEyZxCjicIH7EekkjfieG00CXtY7lEiE
         AAO8XH1OisDVEkYJ7dLuraHgxTrUAnGveUYtVIo/ZsRbsGMxF3+e8PaBg27hbSZOA7/B
         2JiQ==
X-Gm-Message-State: AOAM531FH5TMB9+/9rkoHjUO6Epm1p/sDkZ74OEqMN3uiuA7cPHnAImX
        g/A5odZoxIWShdtuLdhYupU=
X-Google-Smtp-Source: ABdhPJzpI29HmPXQ5CbpYZFiGvhNQ9X+Dmm0glvUDWLbhPo43pUwG74L/Lqm4wzWja6thoIHtLgFKQ==
X-Received: by 2002:a17:906:360a:b0:6b9:1f8:9cdd with SMTP id q10-20020a170906360a00b006b901f89cddmr2733357ejb.461.1645716067180;
        Thu, 24 Feb 2022 07:21:07 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.108.128])
        by smtp.googlemail.com with ESMTPSA id x12sm1501980edv.57.2022.02.24.07.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:21:06 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC RFT PATCH v3 2/2] mtd: core: introduce of support for dynamic partitions
Date:   Thu, 24 Feb 2022 16:20:43 +0100
Message-Id: <20220224152043.27777-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224152043.27777-1-ansuelsmth@gmail.com>
References: <20220224152043.27777-1-ansuelsmth@gmail.com>
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

We have many parser that register mtd partitions at runtime. One example
is the cmdlinepart or the smem-part parser where the compatible is defined
in the dts and the partitions gets detected and registered by the
parser. This is problematic for the NVMEM subsystem that requires an OF node
to detect NVMEM cells.

To fix this problem, introduce an additional logic that will try to
assign an OF node to the MTD if declared.

On MTD addition, it will be checked if the MTD has an OF node and if
not declared will check if a partition with the same name / label is
declared in DTS. If an exact match is found, the partition dynamically
allocated by the parser will have a connected OF node.

The NVMEM subsystem will detect the OF node and register any NVMEM cells
declared statically in the DTS.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/mtd/mtdcore.c | 56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 9186268d361b..80e28a288f65 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -563,6 +563,61 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	return 0;
 }
 
+static void mtd_check_of_node(struct mtd_info *mtd)
+{
+	struct device_node *partitions, *parent_dn, *mtd_dn = NULL;
+	const char *mtd_name, *suffix = "-dynamic";
+	int plen, suffix_len = 8;
+	struct mtd_info *parent;
+	bool found = false;
+
+	/* Check if MTD already has a device node */
+	if (dev_of_node(&mtd->dev))
+		return;
+
+	/* Check if a partitions node exist */
+	parent = mtd->parent;
+	parent_dn = dev_of_node(&parent->dev);
+	if (!parent_dn)
+		return;
+
+	partitions = of_get_child_by_name(parent_dn, "partitions");
+	if (!partitions)
+		goto exit_parent;
+
+	/* Search if a partition is defined with the same name */
+	for_each_child_of_node(partitions, mtd_dn) {
+		mtd_name = of_get_property(mtd_dn, "label", &plen);
+		if (!mtd_name) {
+			mtd_name = of_get_property(mtd_dn, "name", &plen);
+
+			/* Check correct suffix */
+			if (plen <= suffix_len ||
+			    strncmp(mtd_name + plen - suffix_len, suffix, suffix_len))
+				continue;
+
+			plen = plen - suffix_len;
+		}
+
+		if (!strncmp(mtd->name, mtd_name, plen)) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		goto exit_partitions;
+
+	/* Set of_node only for nvmem */
+	if (of_device_is_compatible(mtd_dn, "nvmem-cells"))
+		mtd_set_of_node(mtd, mtd_dn);
+
+exit_partitions:
+	of_node_put(partitions);
+exit_parent:
+	of_node_put(parent_dn);
+}
+
 /**
  *	add_mtd_device - register an MTD device
  *	@mtd: pointer to new MTD device info structure
@@ -668,6 +723,7 @@ int add_mtd_device(struct mtd_info *mtd)
 	mtd->dev.devt = MTD_DEVT(i);
 	dev_set_name(&mtd->dev, "mtd%d", i);
 	dev_set_drvdata(&mtd->dev, mtd);
+	mtd_check_of_node(mtd);
 	of_node_get(mtd_get_of_node(mtd));
 	error = device_register(&mtd->dev);
 	if (error)
-- 
2.34.1

