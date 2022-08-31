Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C099A5A7D72
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiHaMdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiHaMds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:33:48 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66710D1E0D;
        Wed, 31 Aug 2022 05:33:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u22so13977183plq.12;
        Wed, 31 Aug 2022 05:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=T8LspyZYDTEpTIxxPwfNCu3DLAUxPbRtj1oShlZDBwo=;
        b=aDWWMYJzpL7RrBYcW6bsRvtClCBnicCZDIeXu+xZo62Q4Qek91JZihy0Fyh2PeuDe9
         7reIh08dGtCuyBOadDiWzIovllKjL7UP2fZ+Tb+/GsiIWmI182Jcyc5NxKyuy79YiZfW
         iaOBCQ1+xUVcCAOjxPvS29sdaaSK6glJ3g1wmlJc5jGjyjGdpC3Rthp9eB//nxqI+Rkf
         yVqWrDn4L0TSv0HYE6Ff0hS0GkWiinyED+ZVLNqDgAA/BoUESLQnAY0Nm2cuI8zPul7a
         ppvmYPnhDsJHaCJutgGdTFZ8X1mPZTwMr214UdNPKhL1+BsgAVee6DuB1omWrYyisV6b
         qqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=T8LspyZYDTEpTIxxPwfNCu3DLAUxPbRtj1oShlZDBwo=;
        b=LJdItGf5Lo3bkh8G0orgOxHdFMxNSj6OV6/dHUXIe6pZn7AoscX23NmktmwWkbc9gy
         tWKna6ChvjAfZhrySSNIUtGQviD+Q/1/RnfIFUmUyz+1hetZKW2PNfICoX6I33+Q55aZ
         uka1qMobzqvXpoppVEssjnkvWJrQqjU27hZep13/3zov86syVltcfjoCekVS5LVVqpHJ
         2QDP4r02SSYxCcGNTV1WhgofzdCeHztI9RLmSg5FrBaP2jiMEdBypT6ttv+jdBEfFrWp
         cjR7ysz8Qpl6ybp5B7qlSZut4zSnkLBiU15c2+orJ9h+g9B1CVrdqkq+/KXrDNasMzuY
         SzZw==
X-Gm-Message-State: ACgBeo3cK+igxHusJQfVxoVRbcXXAEdhbmBgqXamadLNcLNCp9G1z1si
        uuUitOoF/TjGlB2h8aBBhQ0=
X-Google-Smtp-Source: AA6agR4q+xqCTT6Y5NBimZvaU3IzSfsuj58jX1CR55YC42lOYbvJf20v+xatHq5Rtyi8PLjwDXakFA==
X-Received: by 2002:a17:902:d509:b0:16f:1e1:2067 with SMTP id b9-20020a170902d50900b0016f01e12067mr25171649plg.140.1661949226982;
        Wed, 31 Aug 2022 05:33:46 -0700 (PDT)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id a22-20020aa794b6000000b00517c84fd24asm11427017pfl.172.2022.08.31.05.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:33:45 -0700 (PDT)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     bonbons@linux-vserver.org, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxuezhi1@coolpad.com
Subject: [PATCH] HID: hid-picolcd_core: convert sysfs snprintf to sysfs_emit
Date:   Wed, 31 Aug 2022 20:33:40 +0800
Message-Id: <20220831123340.238632-1-zhangxuezhi3@gmail.com>
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

From: zhangxuezhi1 <zhangxuezhi1@coolpad.com>

Fix up all sysfs show entries to use sysfs_emit

Signed-off-by: zhangxuezhi1 <zhangxuezhi1@coolpad.com>
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

