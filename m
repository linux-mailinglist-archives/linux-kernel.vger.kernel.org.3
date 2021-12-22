Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2BA47D79C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345177AbhLVTXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345143AbhLVTX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:23:29 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1527C061574;
        Wed, 22 Dec 2021 11:23:28 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id m12so5387167ljj.6;
        Wed, 22 Dec 2021 11:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lmbFZL+w3ae5fA8Ekugn4kVFo17QFX/FP2wMDhmpXOY=;
        b=dLkU6AGwDBB6d4GVp30/fEalwT0Rx9ebq1BcO5klzW6rkEb/e+tG1O3AOZR/yJTtQQ
         aIAo3/NHhIu8dhs0GITQUxLl9a2TZfCwsquZNOdTt72wm6dz/qR76e3EjalYEOp/+s5q
         hMwb0T07cV/AYLAF0NaHxzhkPBWO/NOXC1s74QJBqoHaH5M9F/il4HB26iMWhbveWczd
         XE/rInO3uHgT9TxKdKjGzigX/JRyvv1PFGVeZHfo2RfNGjhYSEwBvMMHrWWsuKziMzPh
         6VWfQdvFfkU5PgYYHUiqnu77heZjTKNFSqmbeKxBVC58bbZWnuGHx7ucjYIMbRiPoq7W
         D7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lmbFZL+w3ae5fA8Ekugn4kVFo17QFX/FP2wMDhmpXOY=;
        b=rMJotDD8qlt/zN9kSPXqSpg1yCtOjBj6aXveejgLD5RRA4iomxJ3Ybm7Go7V3MIScP
         7eVWWJvTIWmX2k6/1H0hB1XMSJzcsUeJ49SA08GjQjBGpMaZ0LCaf5IbmdBCp6nA7b7/
         tT+OCeqWLRoTXZP+fyGqB6+WJTRqgbEt7muLaB92yQXRbk5H04GFP2q1/Mjigw4zNhN+
         BbPwV1hy1m0Yo50gh2ajvrDSJmtEeQTT24TthCPh6V+Uw9ZG7IkZT4meL/7ClGqWq0BS
         5JrUBs3TXo0KP/aaY+13wJHJ56hbYeibZaBWTUxySYee1C5HRU5Ibn77EgszpmNZZ0CU
         cyXg==
X-Gm-Message-State: AOAM532HV947mnrAuc1VCbevJ+2gfpzvjs0oW+AncKsmFg/U/uBHvN4s
        mPKP3byyZbY3omgNWdrdUVw=
X-Google-Smtp-Source: ABdhPJyH7Sk5P7qxvMVO//EGRVpJIfX+mHzWGnfgzVV5YTrnxZvCPZsAr1ZxxgF2O6AXROF/SfJVlw==
X-Received: by 2002:a2e:a4b6:: with SMTP id g22mr2867341ljm.447.1640201007302;
        Wed, 22 Dec 2021 11:23:27 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id q10sm242070lfm.163.2021.12.22.11.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 11:23:26 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/3] mtd: core: call devm_of_platform_populate() for MTD devices
Date:   Wed, 22 Dec 2021 20:23:18 +0100
Message-Id: <20211222192320.21974-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This adds support for bindings present in MTD devices (applies to
partitions too) nodes. The purpose of this change is to allow drivers
handle MTD device (partition) data. Some partitions may contain info
that requires parsing & processing.

An example can be U-Boot partition that contains block with environment
variables somehwere in a middle. That block should be described in DT
and parsed by a specific driver.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/mtd/mtdcore.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 70f492dce158..07b75e6ca111 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -19,6 +19,7 @@
 #include <linux/ioctl.h>
 #include <linux/init.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/proc_fs.h>
 #include <linux/idr.h>
 #include <linux/backing-dev.h>
@@ -690,6 +691,9 @@ int add_mtd_device(struct mtd_info *mtd)
 		not->add(mtd);
 
 	mutex_unlock(&mtd_table_mutex);
+
+	devm_of_platform_populate(&mtd->dev);
+
 	/* We _know_ we aren't being removed, because
 	   our caller is still holding us here. So none
 	   of this try_ nonsense, and no bitching about it
-- 
2.31.1

