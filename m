Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9EA56BF6A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbiGHQwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239442AbiGHQw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:52:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420A66D562
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 09:52:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d16so24989137wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s0XfCwq1N84D8d+Bd71Y8W2ctBRkNLutNbDG99JaGLk=;
        b=OVdnpd0nKJZVPzxXch/kRl1vyfX9DswHo36Itmhty3n7RjAIxzxsxux/XxLhwhqLlC
         o7Odden0AcXL5G+K4qsogijDUyOyAJSQDFUX7zokGFCWpEB5yQQzD3TV5zcDD7Z4Nkrz
         5jJRQYMN967/aEHtRbQR9knnCuAVvGDzYTGWabmnPa+wRT9X8yWRxhySsCBP66GsA4ML
         0gToW7Bxl7GnxNxk8G3b2QnulCqGbzdagkO/EZ9LvaT0Zt+m4+BlgLmveltcXjj6HquZ
         NviMSeQ2sXSTZ1lzaH7wnkKBRHfxfScJDXjqdLxtND+RTrow92vjkAIzYxJrQigvd7r2
         du6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s0XfCwq1N84D8d+Bd71Y8W2ctBRkNLutNbDG99JaGLk=;
        b=oihTC75AYEW2DfD0/GSS+QaqwgNKza5g9NBeHbnIRSwk6TEOPsN9mAhwk/mmZj81Op
         mMk+c1iYo+xpUe0R01CfUVq5YlJZ1E77PAAWiJdPvx5FdcmnOOXjXfxq6/5iqwiQXvNs
         Rq/U/KGlnObfMtdQGoxMeBK8Kntu4mrWFQdpPHwbgPfLlR0r56IpOd4qCAm4xYNSvaTa
         4aeyDosO0W9V71j/FkUMu3WuzgJoJYrsSEjzWxW/U8NOECau0wKmOdg3sZtcr1RPrLmo
         RQEEhQBJlSCTgVPtGSfM2lEMnxUEm1PXoIRlk9wldNE1MEodYJzI6nOJ6UoxT/KCEuAT
         e2AA==
X-Gm-Message-State: AJIora87J+Vs8nOEMt2MFJk9GP4zJStuThfGw30S3e7Cnk4Z86nABJu1
        Ufx3pteU/iswzFy7/Dnji0m63g==
X-Google-Smtp-Source: AGRyM1uvLMpGpA7gwhZSjBYRSPeUZ1/+GhpIpOpEFe+A3fyjIVqAN+KUqhGtl3QFut+L1LRAiPBxyQ==
X-Received: by 2002:a5d:6a01:0:b0:21a:338c:4862 with SMTP id m1-20020a5d6a01000000b0021a338c4862mr4086239wru.631.1657299146876;
        Fri, 08 Jul 2022 09:52:26 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d4d8a000000b0021d4aca9d1esm24809118wru.99.2022.07.08.09.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:52:26 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     devicetree@vger.kernel.org, frowand.list@gmail.com
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH] of/irq: parse interrupts-extended during irq init heirarchy calculation
Date:   Fri,  8 Jul 2022 17:52:25 +0100
Message-Id: <20220708165225.269192-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the irq controler code works out the heirarchy for initialialisation
it only looks at interrupt-parent properties, but controllers such as the
RISC-V PLIC use a extended-interrupt property and therefore do not get
properly considered during initialisation.

This means that if anything changes in the driver initialisation order
then the PLIC can get called before the CLINT nodes, and thus interrupts
do not get configured properly and the init continues without noticing
the error until drivers fail due to having no interrupts delivered.

Add code to the of_irq_init that checks for the extended-interrupt
property and adds these parent nodes so that they can be considered
during the calculations of whether an irq controller node can be
initialised.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/of/irq.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index d22f605fa7ee..abfee1fb8717 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -507,11 +507,32 @@ EXPORT_SYMBOL_GPL(of_irq_to_resource_table);
 
 struct of_intc_desc {
 	struct list_head	list;
+	struct list_head	parents;
 	of_irq_init_cb_t	irq_init_cb;
 	struct device_node	*dev;
 	struct device_node	*interrupt_parent;
 };
 
+static bool of_irq_init_check_parents(struct of_intc_desc *desc,
+				      struct device_node *parent)
+{
+	struct of_intc_desc *search, *temp_desc;
+
+	if (list_empty(&desc->parents))
+		return desc->interrupt_parent == parent;
+
+	list_for_each_entry_safe(search, temp_desc, &desc->parents, list) {
+		if (search->interrupt_parent == parent) {
+			pr_debug("%s: %pOF removing %pOF\n",
+				__func__, desc->dev, search->interrupt_parent);
+			list_del(&search->list);
+			kfree(search);
+		}
+	}
+
+	return list_empty(&desc->parents);
+}
+
 /**
  * of_irq_init - Scan and init matching interrupt controllers in DT
  * @matches: 0 terminated array of nodes to match and init function to call
@@ -548,6 +569,7 @@ void __init of_irq_init(const struct of_device_id *matches)
 			goto err;
 		}
 
+		INIT_LIST_HEAD(&desc->parents);
 		desc->irq_init_cb = match->data;
 		desc->dev = of_node_get(np);
 		/*
@@ -563,6 +585,40 @@ void __init of_irq_init(const struct of_device_id *matches)
 			desc->interrupt_parent = NULL;
 		}
 		list_add_tail(&desc->list, &intc_desc_list);
+
+		/*
+		 * If the irq controller has an interrupts-extended
+		 * property then go through it to find out if there
+		 * are any parents in there to consider.
+		 */
+		if (!desc->interrupt_parent &&
+		    of_find_property(np, "interrupts-extended", NULL)) {
+			struct of_phandle_args irq;
+			int nr_irqs = of_irq_count(np);
+			int index, res;
+
+			pr_debug("%s: %pOF interrupts-extended, %d irqs\n",
+				__func__, np, nr_irqs);
+
+			for (index = 0; index < nr_irqs; index++) {
+				res = of_parse_phandle_with_args(np, "interrupts-extended",
+								 "#interrupt-cells", index, &irq);
+				if (res) {
+					goto err;
+				}
+
+				pr_debug("%s: %pOF parent %pOF\n", __func__, np, irq.np);
+				if (irq.np == np)
+					continue;
+
+				temp_desc = kzalloc(sizeof(*temp_desc), GFP_KERNEL);
+				if (!temp_desc)
+					goto err;
+
+				temp_desc->interrupt_parent = irq.np;
+				list_add_tail(&temp_desc->list, &desc->parents);
+			}
+		}
 	}
 
 	/*
@@ -579,14 +635,14 @@ void __init of_irq_init(const struct of_device_id *matches)
 		list_for_each_entry_safe(desc, temp_desc, &intc_desc_list, list) {
 			int ret;
 
-			if (desc->interrupt_parent != parent)
+			if (!of_irq_init_check_parents(desc, parent))
 				continue;
 
 			list_del(&desc->list);
 
 			of_node_set_flag(desc->dev, OF_POPULATED);
 
-			pr_debug("of_irq_init: init %pOF (%p), parent %p\n",
+			pr_debug("of_irq_init: init %pOF (%px), parent %px\n",
 				 desc->dev,
 				 desc->dev, desc->interrupt_parent);
 			ret = desc->irq_init_cb(desc->dev,
-- 
2.35.1

