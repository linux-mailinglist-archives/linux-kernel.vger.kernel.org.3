Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350005A7E60
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiHaNMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiHaNMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:12:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D841C6943;
        Wed, 31 Aug 2022 06:12:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p8-20020a17090ad30800b001fdfc8c7567so3397899pju.1;
        Wed, 31 Aug 2022 06:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=kG9J8mc34kOWDD2HFXJian4iWEnEH3T2McwksneBIHg=;
        b=bE/3Fd7YL3nsg9guk3Aygn/bv3CAtQIEIQblh8EtIYEgp2X//5HtiBW4KquwIXNSYY
         pl+OXbMNexL84AVrgGE3q0PiOAVmO+xjqt/7T6wafW6kivDKCYHAvqMnVS6Jm5yzCziI
         bxGU7eFn+1hdhTPO2WdZizeUzIJZHDlib03sbDZ3IzODsY+HHdxPBrMqjogzqTpxAudM
         jmbmM8XON+IcJYc6v7ceXwAd2RJp8nI9UmpOnedM3WJFUTxbxu+npWHDV9YJ2pgQKjgP
         /hOtJJxuua0x03YCK2nxPNCkcElWzQKKbRcH7c1HHpu8YfgF0njMmWmI6ZPz9IFaaqHn
         VqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kG9J8mc34kOWDD2HFXJian4iWEnEH3T2McwksneBIHg=;
        b=dMGYDviUZ4xtTmWOMpaqpk2uFCmShkdGXVziJC7IVXmF1NTd5BqjqV4uyirKPNwq+/
         FZNjBT+xTIUQ7lY1VrN1p5JOs69ueo97TpS8e+G1agm5/SfbCBc5Vqkuls0dJyIaaTq/
         nRSKnYTeNFIA34p1Ydkymbu1QoeHlw+9PbrdT+PEjldTqV1ytVq5pOasR+vWkDv4iTwC
         X5UlKR8YaKhaREsdYhSvzl//UcOOCjNY0BHdGs3r9TFxsmDStM0K5M4T2P4OHby+urTs
         BQ8zIC0MS51WH2d/ioSa+uuulzGc2x2+X++oHwAxkVRr+iaQ6D/DYKjfefSdfwKhIqRV
         LqvA==
X-Gm-Message-State: ACgBeo0iQzG1pGEYi+ylTfTHWHl0ams7I2p+iyiDyVv5LWgs9zlKlYLg
        XxIa7L/WdbQXwICB868Mq/0=
X-Google-Smtp-Source: AA6agR5M3QMcB32EBw2NHvEdrw6lQ32HuP7em2K51zuNjcLgntIUv8FzpoWIbXtnBUhIy4Grpox49A==
X-Received: by 2002:a17:903:2c7:b0:16c:ebf6:db22 with SMTP id s7-20020a17090302c700b0016cebf6db22mr25686465plk.16.1661951554432;
        Wed, 31 Aug 2022 06:12:34 -0700 (PDT)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id b11-20020aa78ecb000000b0053abbad37a4sm1429871pfr.123.2022.08.31.06.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 06:12:33 -0700 (PDT)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     bonbons@linux-vserver.org, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxuezhi1@coolpad.com
Subject: [PATCH v2] HID: hid-picolcd_core: convert sysfs snprintf to sysfs_emit
Date:   Wed, 31 Aug 2022 21:12:28 +0800
Message-Id: <20220831131228.240026-1-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>

Fix up all sysfs show entries to use sysfs_emit

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
v2: fix the From line and Signed-off-by line.
---
 drivers/hid/hid-picolcd_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index bbda231a7ce3..fa46fb6eab3f 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -256,9 +256,9 @@ static ssize_t picolcd_operation_mode_show(struct device *dev,
 	struct picolcd_data *data = dev_get_drvdata(dev);
 
 	if (data->status & PICOLCD_BOOTLOADER)
-		return snprintf(buf, PAGE_SIZE, "[bootloader] lcd\n");
+		return sysfs_emit(buf, "[bootloader] lcd\n");
 	else
-		return snprintf(buf, PAGE_SIZE, "bootloader [lcd]\n");
+		return sysfs_emit(buf, "bootloader [lcd]\n");
 }
 
 static ssize_t picolcd_operation_mode_store(struct device *dev,
@@ -301,7 +301,7 @@ static ssize_t picolcd_operation_mode_delay_show(struct device *dev,
 {
 	struct picolcd_data *data = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%hu\n", data->opmode_delay);
+	return sysfs_emit(buf, "%hu\n", data->opmode_delay);
 }
 
 static ssize_t picolcd_operation_mode_delay_store(struct device *dev,
-- 
2.25.1

