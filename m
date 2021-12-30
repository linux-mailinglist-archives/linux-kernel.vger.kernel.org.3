Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC68481AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 10:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbhL3JFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 04:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhL3JFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 04:05:01 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C1FC061574;
        Thu, 30 Dec 2021 01:05:00 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id k27so39619796ljc.4;
        Thu, 30 Dec 2021 01:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lmbFZL+w3ae5fA8Ekugn4kVFo17QFX/FP2wMDhmpXOY=;
        b=fZ3Ev8jtzPAShYqCKYkyXWe3FmPDZnj7vyEXvF+vYDVGRaGPvO77jfdto7S1XqUswj
         QcBtyL7Odns/FjPcn8i77XfX8uw3nXXOGgdqXjzNk3AGHTFy1eKQrBNNXtXOkeffgeZ1
         c8W0gijcymflJTG3xsh5uzF7CxXxIttJODsgU9IWH2NtJOEHcEr0ijiCjDxkSp5wXfvh
         l9qeaNv8Q9RtT2J02jglo9sUQbcmether37dSrKBTif8nLY2wQTPlFpMMKHtQMWtjsUw
         53J06f4RK0v4LZzNhjOE/Pioen5R87IXCZOqs1saTiC2qdfMz3c3a7odQZAmwjgZFPaB
         /LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lmbFZL+w3ae5fA8Ekugn4kVFo17QFX/FP2wMDhmpXOY=;
        b=rqy2D1tmDqKSMn+uYC/PR4AVlnV7vtlVKXTL5w3ZTN+dGtFz2IlJEHKPh3HuO8Q1Lb
         rPdJy1Mg9VBr3OpeAjK7DkSSSuCD0FrH+zqSMaRCKSgcAsH5IHLEObLDeIB3TobvtEwJ
         GsrLhvPEoNRVsEHLn2Cwc41wPQu+wXs2zBeSyCBGynwQdYWyaQ3D9/XB13pvCYPxMzIu
         Q63+VxcJaNiww7AwDMD1JQ6b8Bdvz96MS6Tjd0EouvUcFM1jNjZso1iM+B2BBlbx/cJ5
         1kp2NAIofWaMxD0BljzK1TUHVxtX+ttgFeugwIoux7DS8B/HV1C0Vomk12w0iHOhZ4TZ
         qutQ==
X-Gm-Message-State: AOAM530GWasw8qE6g/tCYughzRgNEViFRw1GiVYScj8WEYo9z/DLAp22
        Qocv6FEL3PudKJh/coXublk=
X-Google-Smtp-Source: ABdhPJwaT7mr00o0HB88uX9XEw8ZrPCDI/+I5R7gN/sb04GsaTBMK3qqUB2tX4Pv9zVp4pLr/qvGMQ==
X-Received: by 2002:a2e:1602:: with SMTP id w2mr26247986ljd.517.1640855099102;
        Thu, 30 Dec 2021 01:04:59 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id d5sm2440007lfl.242.2021.12.30.01.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 01:04:58 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 1/3] mtd: core: call devm_of_platform_populate() for MTD devices
Date:   Thu, 30 Dec 2021 10:04:47 +0100
Message-Id: <20211230090449.11808-1-zajec5@gmail.com>
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

