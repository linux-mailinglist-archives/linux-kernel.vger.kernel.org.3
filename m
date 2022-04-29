Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63B55149EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359588AbiD2Mym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359567AbiD2My0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:54:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D49B3695;
        Fri, 29 Apr 2022 05:51:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a21so8975260edb.1;
        Fri, 29 Apr 2022 05:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wYLNkQDRIReLtuo3nph35Lv13qW9BGvsKSf7RZPP9xg=;
        b=A62YDg43ZJFVz+Vc0gpIGYmqdZfuoXw19LxJxPOFelkvshyFVf7ot1cCaV2dhGMSOn
         mJJ53CdisMbvmESH3a1v/MpSU0FIMn3I5D9zlmrnNOGf+5Q91EdO7HdcQ9+ModUAEegb
         SgpzCXSfFCvsBnsPkrqHf6hOQ099ysfpwEAbbLXTK9hZbKufE4DAdkZ5osrU2CDfL6Qp
         yRnDXZZPkTSE51RRa7oA4hCk6H7RpI7qeY2FYPGNqEs6DP1NHVQz3tZOKPnuLUlqHrEv
         OtJxU5orp0zKXc4IlkPd/XWtw7jz4GQyRBENfOzGl82iilR4KYhJkIgEp47onw6Vyc4l
         44AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wYLNkQDRIReLtuo3nph35Lv13qW9BGvsKSf7RZPP9xg=;
        b=TjD/cIBtf0Fm8jgjk3uTvJXKnT2Rz/tXXhToF5Cj3mn+qLstq5gaDM3tZooTisXlIy
         HryMt6hrbjQIHqGx4m+TBF7GEGJFbsTexez/BImCRkgEzWQhyogNCdhI8N32sE2t/hUb
         ufTxh4ZeNWOqf3Bnr89gnYhjvReGy4jFkO1aeGw/SCJ+PepmT1snSVjWSwmr9yZeeBWT
         kM1qJNR04sNE0aTMcF1Vyj/gpfitdAUzuwmuDDtID57zizZ9uClyGDv8UsYQv0GOPD0D
         LGxSA8lADrccBMTsOFA/yf7pDG2l208TqcfyYaP8NbJ6hp1CzY1p8bweJlcT272ERywp
         MeAQ==
X-Gm-Message-State: AOAM531WZ8Qq080ei00zv9eah0GzId7qyq4dect2m/c0kvFErkwr3I6t
        CPM0ZzB9B+PRF4Pcm++0UOlcKXUOJa0=
X-Google-Smtp-Source: ABdhPJwD9ryKCvmVR5tY0PkuFcZhNw6EywaHCs5BHyiQ7YPCknGIaZbHuubrGmR+oMLbh9bnGyyLOQ==
X-Received: by 2002:a05:6402:3486:b0:425:f2c6:9695 with SMTP id v6-20020a056402348600b00425f2c69695mr24131738edc.2.1651236665223;
        Fri, 29 Apr 2022 05:51:05 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id hf27-20020a1709072c5b00b006f3ef214e33sm615347ejc.153.2022.04.29.05.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:51:04 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3 2/2] mtd: core: introduce of support for dynamic partitions
Date:   Fri, 29 Apr 2022 14:48:25 +0200
Message-Id: <20220429124825.21477-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220429124825.21477-1-ansuelsmth@gmail.com>
References: <20220429124825.21477-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 7731796024e0..ffca53fcc19a 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -546,6 +546,61 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
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
@@ -651,6 +706,7 @@ int add_mtd_device(struct mtd_info *mtd)
 	mtd->dev.devt = MTD_DEVT(i);
 	dev_set_name(&mtd->dev, "mtd%d", i);
 	dev_set_drvdata(&mtd->dev, mtd);
+	mtd_check_of_node(mtd);
 	of_node_get(mtd_get_of_node(mtd));
 	error = device_register(&mtd->dev);
 	if (error)
-- 
2.34.1

