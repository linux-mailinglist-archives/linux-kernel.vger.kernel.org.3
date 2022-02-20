Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E934BD06E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 18:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244458AbiBTRkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 12:40:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242485AbiBTRkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:40:04 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E4F4A92D;
        Sun, 20 Feb 2022 09:39:42 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id m17so24762595edc.13;
        Sun, 20 Feb 2022 09:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GWlVA6bqW04iyoIdnqOqg4FogTrKkslVGuWpN+mp7C4=;
        b=ZXPrnn5JakCpGzz+pLKO/QmYkH5Yq5OFtJpqO6BeL+Q4kbvp/64UYovG1W52RYi4fn
         eDpCk4TLyfZNORnwDqQKy2G7iB9t9veUMYYzGxfVJko/3liND8EHG36bWIADM63Tg+Cr
         4YjcguJ9Sq00cEQaKOZRfukTM/eMF8O0WeBxdWNvXT/zN8nRqWSQMV7u3IYCk1mzaH4e
         g6R4+frRdiJh9VHcL3jZrVAXCTkInUWEAupqN1nNdKrBRr+f43X3AmmXSijGYLQ7dO1b
         5t6+1dYcTWN+V4bZS1RTIvqVln13kAhW2VHiGKuBVD4W+BZgc+EBGOvT0z5SFA0BqR2m
         PCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GWlVA6bqW04iyoIdnqOqg4FogTrKkslVGuWpN+mp7C4=;
        b=rA40HjZUWF9jhQVA6BQI4sOiUJuQJegeg589URjWIGAnolFVtLjCl6F0GMOuD5XIJQ
         uPk1iFhTOTd7vYE6uAVS69TzpV8ktp+/f31YbIkgsDx3OCo699hlNJGaeSvvALkpTdfq
         EdKQJJrPM6hmkSwSamOE8rvUvY3i/0EV+s8bHrM4FTnzjQw3/R0BtXB8Ee/rPAwBmynJ
         uEQ6s0ItvjxERPmbmdrl7rg164HNnkx4jDdNrkRh0vxg3GH8Pi4rRL441rkO99n/IcB0
         EbXT2VRDjJpWoGhpr76FrQgm9jX66Rr3f6M2CnE8AVCmQRh8Eir4HRRW0IXa0ai6Os2T
         S29Q==
X-Gm-Message-State: AOAM531cIMJramtfbXmLkxJW1v7MABK8QxYqWGR2SBEg8A7UJBoQTuGF
        TKvSzJWiz617MxTkw7gWKGo=
X-Google-Smtp-Source: ABdhPJzToGjW+8krUy2PN6oNNb9xwnTzztrk8RzYmAacrb6WIpKb8jN+PL3FBq9ejq7tL7A2N2dtoQ==
X-Received: by 2002:a50:e187:0:b0:406:fb92:80ce with SMTP id k7-20020a50e187000000b00406fb9280cemr17539249edl.164.1645378781006;
        Sun, 20 Feb 2022 09:39:41 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id i5sm4416721ejo.188.2022.02.20.09.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:39:40 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC RFT PATCH v2 2/2] mtd: core: introduce of support for dynamic partitions
Date:   Sun, 20 Feb 2022 18:39:05 +0100
Message-Id: <20220220173905.14165-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220173905.14165-1-ansuelsmth@gmail.com>
References: <20220220173905.14165-1-ansuelsmth@gmail.com>
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
 drivers/mtd/mtdcore.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 9186268d361b..636b0a02f6cf 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -563,6 +563,50 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	return 0;
 }
 
+void mtd_check_of_node(struct mtd_info *mtd)
+{
+	struct device_node *partitions, *parent_dn, *mtd_dn = NULL;
+	struct mtd_info *parent;
+	const char *mtd_name;
+	bool found = false;
+	int plen;
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
+	partitions = of_get_compatible_child(parent_dn, "partitions");
+	if (!partitions)
+		goto exit_parent;
+
+	/* Search if a partition is defined with the same name */
+	for_each_child_of_node(partitions, mtd_dn) {
+		mtd_name = of_get_property(mtd_dn, "label", &plen);
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
@@ -668,6 +712,7 @@ int add_mtd_device(struct mtd_info *mtd)
 	mtd->dev.devt = MTD_DEVT(i);
 	dev_set_name(&mtd->dev, "mtd%d", i);
 	dev_set_drvdata(&mtd->dev, mtd);
+	mtd_check_of_node(mtd);
 	of_node_get(mtd_get_of_node(mtd));
 	error = device_register(&mtd->dev);
 	if (error)
-- 
2.34.1

