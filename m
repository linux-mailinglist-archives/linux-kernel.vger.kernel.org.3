Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D28B547790
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 22:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiFKUr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 16:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiFKUrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 16:47:24 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3718F120;
        Sat, 11 Jun 2022 13:47:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u12so4126726eja.8;
        Sat, 11 Jun 2022 13:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KVeFonmBJ+8ElS2S3DJZc1evp03zBLOPTs54ViZe9rI=;
        b=VNhZ4ylxFT+9aZ3DF1PBnm574in+3ZH0iAhReGS6WJYBSQ6cGlPLsZar5dVJTbxnT6
         I0u6TWviVpZbZecoivK+BeYpDGn972LHbC3AIv+343GxvBDm6BYzwhplxMtQfwLvOlqo
         Lm78Rh+LRB/pt1MZHzsAYrrkWzd3G+DF696jYUibKGieF/4IPKLjSZncF+Dh64rxNIx4
         T1wvW9gvRJJpjAvmLqrdjYjZN9Hpi4+pKjH8anxdOsW37eCYYIp4kls/yhLI/BgwMi0U
         8Ydxmd6LAvWNzd7x6VwwcpzfXEikmFSU6fm5nzmi04+9lHk0pc7gBP6YlZOtC9KhRLkW
         dRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KVeFonmBJ+8ElS2S3DJZc1evp03zBLOPTs54ViZe9rI=;
        b=HERI855EtG0HJPVIAyai/Yl0haBUU1AeuL9fnGrcs7F11KHLK85u5qiLSSJK4uQ0Cl
         czyRu/jla6ZiQ7P91Mi+WeEllWByKj8KCXYrUiYA+aqsFgYnrJtrw2piBRqtogAyOgTp
         rGHXvJfNYxo0g5Oxwfv6vJW7RxjuG4YjzXdLPVUiNTDX5A3ABI5+a+R7sKc4kyq2gUSx
         KV7SWbdyQ30G1MmhbOOTUo7gaKidTJPW1B68dMAiVlZmfGMBg+Ru/RzDAbT3pMT8s2L7
         w4ExZAUyP9otOjy4XDW8aU8DKwaWD5RdfVrVzLSeO0718w6fBkFGBrrpJvapDFcSjdgF
         pHfA==
X-Gm-Message-State: AOAM532P36Typ8kGo7ZktsLQ+L9cz2g8WpbNDteVcGs82kF1l8Xa0bV4
        ENZzKQKcr8fzO5IPnnYJt5cg0iaVA04=
X-Google-Smtp-Source: ABdhPJxJaEekiae9+T38NAh/Cbqf/UH8IJceqQ9PqWUff+jhXYrvlmHH7HyeVTNnd0V2hLZEv49f3g==
X-Received: by 2002:a17:906:9244:b0:70c:f626:944d with SMTP id c4-20020a170906924400b0070cf626944dmr41572371ejx.496.1654980429683;
        Sat, 11 Jun 2022 13:47:09 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906301600b006f52dbc192bsm1490672ejz.37.2022.06.11.13.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 13:47:09 -0700 (PDT)
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
Subject: [PATCH V3 1/2] mtd: allow getting MTD device associated with a specific DT node
Date:   Sat, 11 Jun 2022 22:46:50 +0200
Message-Id: <20220611204651.19947-1-zajec5@gmail.com>
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
---
V3: First introduction of of_get_mtd_device_by_node()

mtd maintainers: please let know how would you like this patch
processed. Would that be OK for you to Review/Ack it and let it go
through NVMEM tree?
---
 drivers/mtd/mtdcore.c   | 28 ++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 9eb0680db312..7dc214271c85 100644
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
+	err = -ENODEV;
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

