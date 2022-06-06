Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250A453E716
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbiFFPPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240369AbiFFPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:14:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDDF118D10;
        Mon,  6 Jun 2022 08:14:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id q21so29613464ejm.1;
        Mon, 06 Jun 2022 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GYSZo6XHpAMyhvRqkjuy1lYBsylet9wRGEIDu+7oMAg=;
        b=Sjpbo1f3mz+MDObOhOImNTpeNo2ne+Ui6zvvn7v/z35jvASMQcDf/nUUd0HRF/t/Ea
         4h8P2FFMK6drGKIuDe7GJdr4VJiUqql9Zkf5vd/qkcjzjYBEosbzEWuLOrLbtWtJTZSQ
         go1rdCHGLfc6Rtc6BxG+G5Motw9DHduYGE4PafmLUcSrSbFALoldaHcCiFu4vi+Mr2Sz
         dbKFzNplwkQu7TA9PrRtYSaK/hXBl8xLBphmb6NCeocwI6CMhlaBO8hk/x93chFTKKDY
         8kzV7kkTNyDaEkCVvOKZY3q6zuxOX2mlyAq41FsA19gzg7LN43M2Vp0WkKAaaEY0ZPwO
         +UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GYSZo6XHpAMyhvRqkjuy1lYBsylet9wRGEIDu+7oMAg=;
        b=yqDRtZHeTcZjwWfH6L8o3LI47h6PRBG2EDksl3jt0AszMPkQl7YycHMujME8Dp6jDV
         YfKWAsnezjRumAoU1nrsd8Z9+7wMrUk8p5B4z+gAbML3AwrZUIVJIm3wVmZULBjCfJNc
         VfKnmM6I2+FQUxEwx0rAJbN466ztrMO0VWj/vw0Vs20JW5iAqEOHYOh5vqrz/qLY4zvz
         rgp6LOh6dl/8wLQIU816X0o8ZX8LbiD/F/wDy2t0xdYuRX0sZNNjUvIghyPs0xhD3RnM
         aFEPPVOk5eF9bHeEyP2R12gSRYNm93Dok/32Orr2eT6JGzxIHxZnwSnPJIU7ZFEEZO8C
         ocqw==
X-Gm-Message-State: AOAM532BHF+q5QPses+B4Ux3awYPjfvkr+6V2fpv90DIqRn0GFFqKfba
        Kwsew3c1ZpOgcTHywPqAB6M=
X-Google-Smtp-Source: ABdhPJyUO4QhLpj5hQB1ExfVx6GyV11SpB7T0Mr7aQNaOcyQYh/tJ5wxoOy0jfL291yecIhfv8GacA==
X-Received: by 2002:a17:907:7811:b0:6ef:a896:b407 with SMTP id la17-20020a170907781100b006efa896b407mr21254860ejc.645.1654528484015;
        Mon, 06 Jun 2022 08:14:44 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id be5-20020a0564021a2500b0042e09f44f81sm7494001edb.38.2022.06.06.08.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:14:43 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        =?UTF-8?q?=EF=BF=BDecki?= <rafal@milecki.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] mtd: core: introduce of support for dynamic partitions
Date:   Mon,  6 Jun 2022 17:14:17 +0200
Message-Id: <20220606151417.19227-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220606151417.19227-1-ansuelsmth@gmail.com>
References: <20220606151417.19227-1-ansuelsmth@gmail.com>
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
2.36.1

