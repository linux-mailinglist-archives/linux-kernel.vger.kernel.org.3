Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F56052C799
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 01:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiERXdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 19:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiERXdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 19:33:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D670614D31;
        Wed, 18 May 2022 16:33:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t6so4792797wra.4;
        Wed, 18 May 2022 16:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=o3G9z8T78DTVnGIhhir4CiLyiUwFhPexNUSMPntUVWo=;
        b=cPyTooRLhSLuj4xtKEF+jqq05kUgSoP1/SoepWsIb42B23Nn+toWC9ie4Bhw5xdETM
         TGW6MNWUcosF15M5vEf9kh41fmBFqQC26h8O9sx18ZJ1tLbfLkVC1YKx4tDVRSNz0xD4
         ilIAwbgGThFwD2TGTVm6vA4nEJaXmteCdLoIj4Bpe52m6Y6YnJEKfhBZukrfrE6NJugE
         cfFLSwRHXDanuANwkl8jx+179uR0WEe7v+0LjYnFBl4uzDiNrS7kPQwk7JxDFSRPYVyS
         PeF2FPmB0VKNmau4XdHADfVmi7zY1ksyD53iYl4lETvmtpvOiMIC7Zqgi/gyGlDU4fnR
         TvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o3G9z8T78DTVnGIhhir4CiLyiUwFhPexNUSMPntUVWo=;
        b=3prX4I05xeq5HtduVxnVO2yzoF0GfWZh4FPQ4dVGJS3EGfbCiAMjVvCN0ZihE9h2ee
         DcgCFK396f33KDhAy9Fnxx2rCnglpdbPZOhQJOviMQ2O9UIaiNQsUxHOeMwGeZyjAYct
         ctp7T15dIZmmobkbB2Bx0NXTRHAX7w+KPhcwq8Hsarv7L8j7oFOcq0st47Tf7G3eV6dJ
         jEfRcJ9sElsAcGZiTCk8DT+5XgWyAR5HPt9fllABpUx5zryTdFyMr5CkKQVsMLiSe95T
         hICVT7Hyl1FXfOfvGwLCZ7YO7RcXqE3NujhNwK9nXzjuAvQF9gigZ21HnMnfXmCG+Qv5
         K3XA==
X-Gm-Message-State: AOAM532vnEg8Kco4swTwHF3pcgdGDOfPQzW87GUCRxGjwAX0nwRW2VB8
        dcrb5ZKRzBhAQfFIJ3WEfuU=
X-Google-Smtp-Source: ABdhPJwyBZdPuWSVpQ3TXkUHx8UnAbrjTQmm5q5gHUpjnyDq+SevbOrKWD4RXJBrhJ0oQRGAhJVxnw==
X-Received: by 2002:a5d:6dab:0:b0:20c:84b1:5d4e with SMTP id u11-20020a5d6dab000000b0020c84b15d4emr1597515wrs.470.1652916793270;
        Wed, 18 May 2022 16:33:13 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id j25-20020adfa799000000b0020d042efd11sm3217476wrc.61.2022.05.18.16.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 16:33:12 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] mtd: core: introduce of support for dynamic partitions
Date:   Thu, 19 May 2022 01:32:58 +0200
Message-Id: <20220518233258.5483-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220518233258.5483-1-ansuelsmth@gmail.com>
References: <20220518233258.5483-1-ansuelsmth@gmail.com>
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
not declared will check if a partition with the same label is
declared in DTS. If an exact match is found, the partition dynamically
allocated by the parser will have a connected OF node.

The NVMEM subsystem will detect the OF node and register any NVMEM cells
declared statically in the DTS.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/mtd/mtdcore.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 7731796024e0..807194efb580 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -546,6 +546,54 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	return 0;
 }
 
+static void mtd_check_of_node(struct mtd_info *mtd)
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
+	partitions = of_get_child_by_name(parent_dn, "partitions");
+	if (!partitions)
+		goto exit_parent;
+
+	/* Search if a partition is defined with the same name */
+	for_each_child_of_node(partitions, mtd_dn) {
+		/* Skip partition with no label */
+		mtd_name = of_get_property(mtd_dn, "label", &plen);
+		if (!mtd_name)
+			continue;
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
@@ -651,6 +699,7 @@ int add_mtd_device(struct mtd_info *mtd)
 	mtd->dev.devt = MTD_DEVT(i);
 	dev_set_name(&mtd->dev, "mtd%d", i);
 	dev_set_drvdata(&mtd->dev, mtd);
+	mtd_check_of_node(mtd);
 	of_node_get(mtd_get_of_node(mtd));
 	error = device_register(&mtd->dev);
 	if (error)
-- 
2.34.1

