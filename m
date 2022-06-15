Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB8754D1D1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346699AbiFOTnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiFOTnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:43:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B157C2BB22;
        Wed, 15 Jun 2022 12:43:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id v1so25184569ejg.13;
        Wed, 15 Jun 2022 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NeAaQxHNgpvGGApabF2dZ5cx3n1PATnxM0M/iIuIjaA=;
        b=k14tMQCVOVeOrgEvHimQMUqpKcCa52Ahn9gpZ0rCs6UBPmduwGS/RyEeSxGl32iBsa
         6sdJ2TwTf6gszE58GZjCVQJGrDA8gpYriykjwER+3ZPpzBx0LofuIzLo3P27yLoq7fgW
         7Rt6xQ+cd9bin8kCAxVf9OAmEkf0xoPvJLzAq1UnhUnZXXHDizAgllKcQfoCJgc78lH8
         f21xjPvnjHZJTTHcF5sfaryaMZuoSMBC9rM7poPFB2MPk1aJEBojUV7SB2CYo3Di4L+B
         +NVJ/3Qlpw2Fql50DHr+uEEqIoYmTRaMWDB+tUmgCak9rIhAlxwXqizC2JzH6fYVEb/l
         H8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NeAaQxHNgpvGGApabF2dZ5cx3n1PATnxM0M/iIuIjaA=;
        b=sWHJISgtiap00yCxFljoeqYtyqS97W9cmeon1t7c7mgT9HhBEHoIQ9+zEQTPuwiNlt
         uZs9f1R002sQ+WZE2UsHuXwHMDOCUmwMERy9/vuqcYCpeJZoA9paicyKKUirad4mTovp
         EQDgHuwSoa6ly9ZoiYcoYUfOG+6c5dgebgVMkd8ncmB0Fb5ub6obsT40bsvsrNTBO0RU
         8o0is8p3htu/2e9ZusWTacb35mBNllldDRtfTHC7l+dd3OlgIuNocXDz/KdbtOXnIwO0
         ipCbQxy43aquftOWzKKGQGppHgS9s5vG6V0/7nNRWFIEXuGxDpbBA14thmk7sW3o2edZ
         Vftg==
X-Gm-Message-State: AJIora/leGycxIUwYn9pY6ZMjQZMdyiitGM5AOUkYsv0CAIsspkl6Ooa
        9Fe9Zl/az1GkQhRzS9BGrhQ=
X-Google-Smtp-Source: AGRyM1sAO6s8WrkND9IqSLFNkOoSsbBsyq8tmeli3+/6WTSIMEkds8HRFI63vvFEhffvyAQFIfxN2g==
X-Received: by 2002:a17:906:9244:b0:70c:f626:944d with SMTP id c4-20020a170906924400b0070cf626944dmr1300802ejx.496.1655322191129;
        Wed, 15 Jun 2022 12:43:11 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d750000000b0042bd6f745fasm18096eds.92.2022.06.15.12.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 12:43:10 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tom Rini <trini@konsulko.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V4 1/2] mtd: allow getting MTD device associated with a specific DT node
Date:   Wed, 15 Jun 2022 21:42:59 +0200
Message-Id: <20220615194300.13358-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

MTD subsystem API allows interacting with MTD devices (e.g. reading,
writing, handling bad blocks). So far a random driver could get MTD
device only by its name (get_mtd_device_nm()). This change allows
getting them also by a DT node.

This API is required for drivers handling DT defined MTD partitions in a
specific way (e.g. U-Boot (sub)partition with environment variables).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
V3: First introduction of of_get_mtd_device_by_node()
V4: Use EPROBE_DEFER

Srinivas: in V3 Miquel said it's OK to push this patch through NVMEM 
---
 drivers/mtd/mtdcore.c   | 28 ++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 9eb0680db312..3613cc142f25 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1154,6 +1154,34 @@ int __get_mtd_device(struct mtd_info *mtd)
 }
 EXPORT_SYMBOL_GPL(__get_mtd_device);
 
+/**
+ * of_get_mtd_device_by_node - obtain an MTD device associated with a given node
+ *
+ * @np: device tree node
+ */
+struct mtd_info *of_get_mtd_device_by_node(struct device_node *np)
+{
+	struct mtd_info *mtd = NULL;
+	struct mtd_info *tmp;
+	int err;
+
+	mutex_lock(&mtd_table_mutex);
+
+	err = -EPROBE_DEFER;
+	mtd_for_each_device(tmp) {
+		if (mtd_get_of_node(tmp) == np) {
+			mtd = tmp;
+			err = __get_mtd_device(mtd);
+			break;
+		}
+	}
+
+	mutex_unlock(&mtd_table_mutex);
+
+	return err ? ERR_PTR(err) : mtd;
+}
+EXPORT_SYMBOL_GPL(of_get_mtd_device_by_node);
+
 /**
  *	get_mtd_device_nm - obtain a validated handle for an MTD device by
  *	device name
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 955aee14b0f7..6fc841ceef31 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -677,6 +677,7 @@ extern int mtd_device_unregister(struct mtd_info *master);
 extern struct mtd_info *get_mtd_device(struct mtd_info *mtd, int num);
 extern int __get_mtd_device(struct mtd_info *mtd);
 extern void __put_mtd_device(struct mtd_info *mtd);
+extern struct mtd_info *of_get_mtd_device_by_node(struct device_node *np);
 extern struct mtd_info *get_mtd_device_nm(const char *name);
 extern void put_mtd_device(struct mtd_info *mtd);
 
-- 
2.34.1

