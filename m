Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14C1553FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 03:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355537AbiFVBLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 21:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354643AbiFVBLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:11:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33E23191B;
        Tue, 21 Jun 2022 18:11:06 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w17so21183390wrg.7;
        Tue, 21 Jun 2022 18:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zIg/BRRxdkYhUPWpTwl1+aMNGlh1YT/9AIwW2tFGVlk=;
        b=AXrxQDkmAUcOCh+UdnnNbIqZOiuzmon7wk7L3jQI2qCCZA8YVEcXCRkl6ttkGrC+uD
         1oZfkW48SVoSfGaftqyfa1tYqP/kAuYxDfxuL0aEGxXysRyavyrhehp174XmhMPMTFkl
         oFDJZWSoO+PmgKaEn1KCuJP1n8oeaEB75I6zvTSqmlKyVJCeXTI/1p3fdqUBJN/mDKsm
         AueMlVSrR4rqimpS6LVne+TzC1yGsf1Z/RM20Pp7utN889Niyi6efKIXQqYU5CxnNhyy
         T3k9UtoDMSAWLWjsinDxlci6KqXUVoTycCR1v3FKsCVh2QyqqJ4JCwBfG2tQo4JSqfiG
         Nrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zIg/BRRxdkYhUPWpTwl1+aMNGlh1YT/9AIwW2tFGVlk=;
        b=o66zqGCokQUGN9vzbJTN6zeZoG9e6W3Jy+YmTV/B0mFNO5k/Y1Js4CwMiAMuAyZnwN
         hpVQctX69RSt3H2MPvgpAbiR1osKk9hBrmkPKrbIVLToZZXlJr8xUObGWbmlo3js7zPc
         Iv3DKln6qqOOrK5Ki7i6f/zDtgV1fRXUqaZUKXsFvgcuITmODb/s5SbwJbMAr9F9dgbP
         CjmJYNu7zgNkz1pVULWGN8D3Zil4brdiBMvd7S+q5Fr2wBPaSg5MW13HIUzI5X1Lyjyk
         Jv4b14Bet1stEF8XhEHmJYjxICuZbWt9NkNg5DHO8zrZaFhjIfZpnEvRFU9bQfgAnip5
         V/1g==
X-Gm-Message-State: AJIora8FoXtgIbEbrbqN+LN52Q7aEZB/SFX0HPRQy+jkMTp+VWL66tyU
        cguPp9/MpthnVhAE/669XAE=
X-Google-Smtp-Source: AGRyM1v/u5MWPXIFPc5OhGTADPYHN20NOfalAr5VlbRCN6NuUJstWYLreXzWuGpBBOaxhXwWMUMwHQ==
X-Received: by 2002:a05:6000:50:b0:21a:3d97:14fd with SMTP id k16-20020a056000005000b0021a3d9714fdmr618139wrx.685.1655860265052;
        Tue, 21 Jun 2022 18:11:05 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id x13-20020adfdd8d000000b0021b81855c1csm16560086wrl.27.2022.06.21.18.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 18:11:04 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        =?UTF-8?q?=EF=BF=BDecki?= <rafal@milecki.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] mtd: core: introduce of support for dynamic partitions
Date:   Wed, 22 Jun 2022 03:06:28 +0200
Message-Id: <20220622010628.30414-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622010628.30414-1-ansuelsmth@gmail.com>
References: <20220622010628.30414-1-ansuelsmth@gmail.com>
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
parser. This is problematic for the NVMEM subsystem that requires an OF
node to detect NVMEM cells.

To fix this problem, introduce an additional logic that will try to
assign an OF node to the MTD if declared.

On MTD addition, it will be checked if the MTD has an OF node and if
not declared will check if a partition with the same label / node name is
declared in DTS. If an exact match is found, the partition dynamically
allocated by the parser will have a connected OF node.

The NVMEM subsystem will detect the OF node and register any NVMEM cells
declared statically in the DTS.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mtd/mtdcore.c | 61 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 7731796024e0..e9d534b9971d 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -546,6 +546,66 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	return 0;
 }
 
+static void mtd_check_of_node(struct mtd_info *mtd)
+{
+	struct device_node *partitions, *parent_dn, *mtd_dn = NULL;
+	const char *pname, *prefix = "partition-";
+	int plen, mtd_name_len, offset, prefix_len;
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
+	prefix_len = strlen(prefix);
+	mtd_name_len = strlen(mtd->name);
+
+	/* Search if a partition is defined with the same name */
+	for_each_child_of_node(partitions, mtd_dn) {
+		offset = 0;
+
+		/* Skip partition with no/wrong prefix */
+		if (!of_node_name_prefix(mtd_dn, "partition-"))
+			continue;
+
+		/* Label have priority. Check that first */
+		if (of_property_read_string(mtd_dn, "label", &pname)) {
+			of_property_read_string(mtd_dn, "name", &pname);
+			offset = prefix_len;
+		}
+
+		plen = strlen(pname) - offset;
+		if (plen == mtd_name_len &&
+		    !strncmp(mtd->name, pname + offset, plen)) {
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
@@ -651,6 +711,7 @@ int add_mtd_device(struct mtd_info *mtd)
 	mtd->dev.devt = MTD_DEVT(i);
 	dev_set_name(&mtd->dev, "mtd%d", i);
 	dev_set_drvdata(&mtd->dev, mtd);
+	mtd_check_of_node(mtd);
 	of_node_get(mtd_get_of_node(mtd));
 	error = device_register(&mtd->dev);
 	if (error)
-- 
2.36.1

