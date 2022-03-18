Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006584DE19D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 20:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbiCRTLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 15:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiCRTLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 15:11:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975F71903C4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:10:17 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g19so10237171pfc.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IzmP5X2K1BS5f1i59g5bK2cyyZHxNOqC8TIBy5CRON4=;
        b=TL+wPZUOExCQFV7t11tRDwapOCTIkSSbQ3UsI0+BOkK6x2ELC2+xCHZOx1E+I2zUwk
         5NpYAK+IF8/D0YZD5qRYWVHtLBUFliQg23d4ZDDtJFNfQGHFB/xn+rJivIZ011tNWvXn
         ml7a3xOpzyL0ARzIjGrzfZdybZDks/V/ioMucV2XagHr5dimIH4klZ1R2nLiFrawhnKY
         RY9np4SEMrkH6ABb/FjkYc/+HmbXgCxfp7QfLX44cUlTJ374NW1SAgq2Iseqw60HPFPJ
         2B0mFA6XJk9fLzR5/hjmjeYsXHrKlaUnpS3cK0VxeuZSNY4eTdYUDdmqZPOb+aaEhjuh
         7nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IzmP5X2K1BS5f1i59g5bK2cyyZHxNOqC8TIBy5CRON4=;
        b=0v8eQ/MbQ9DnII4XaGmhkCS4Q9vLPLOJGmlC9TwXGISgEBjmPMkx4d89I5TlqxBNHp
         uA7msrE/9R0193Znqved3eBkWt/EypbnBJpQGDUbZ3Nro1zpYo/XAe27V+4qejj9MRCW
         qUmLfmmKQcPOQu0WmHwLKzEDNyzZSjs4MjKChduN7Ms15CyA5mGQZm6e96Tu+8mVJpt0
         W7Q7nGqUDUOTJXwQe2nQ9Ab83DRBtnNZ5OGYFSfYFv3rVcQ4sZsmbhWJ5tAbOvUtdPaQ
         km/0oG869wru2eCp13Sor2vzb/bzRR/siFHsVqfDKGK5KEsQucXyX6vMP9rM6s4o2gEq
         lCpg==
X-Gm-Message-State: AOAM5335K9/XCaeAesRPiJWrGWXvWhGP//kLpULLcu3HVFiCEVz3XYO0
        S5ZYCaRQkAaPdMsAYn55iA1u+fSrLZM=
X-Google-Smtp-Source: ABdhPJwTCoFRb4Bt/BtKUBmCoZ3A/qBpEhjsTq9nW8uLy5cCi0mR2bIVa0UIjj6KvHK2VbrNvhrI0Q==
X-Received: by 2002:a62:8308:0:b0:4fa:7bcd:d0e6 with SMTP id h8-20020a628308000000b004fa7bcdd0e6mr1672788pfe.35.1647630616872;
        Fri, 18 Mar 2022 12:10:16 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:a64c:198c:4e57:caeb])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a199000b001bf4b1b268bsm8523113pji.44.2022.03.18.12.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 12:10:16 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: make gc_urgent and gc_segment_mode sysfs node readable
Date:   Fri, 18 Mar 2022 12:10:12 -0700
Message-Id: <20220318191012.4113266-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
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

From: Daeho Jeong <daehojeong@google.com>

Changed a way of showing values of them to use strings.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/sysfs.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index fe29bcb70f46..f2613cc83888 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -41,6 +41,16 @@ enum {
 	ATGC_INFO,	/* struct atgc_management */
 };
 
+const char *gc_mode_names[MAX_GC_MODE] = {
+	"GC_NORMAL",
+	"GC_IDLE_CB",
+	"GC_IDLE_GREEDY",
+	"GC_IDLE_AT",
+	"GC_URGENT_HIGH",
+	"GC_URGENT_LOW",
+	"GC_URGENT_MID"
+};
+
 struct f2fs_attr {
 	struct attribute attr;
 	ssize_t (*show)(struct f2fs_attr *, struct f2fs_sb_info *, char *);
@@ -316,8 +326,13 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		return sysfs_emit(buf, "%u\n", sbi->compr_new_inode);
 #endif
 
+	if (!strcmp(a->attr.name, "gc_urgent"))
+		return sysfs_emit(buf, "%s\n",
+				gc_mode_names[sbi->gc_mode]);
+
 	if (!strcmp(a->attr.name, "gc_segment_mode"))
-		return sysfs_emit(buf, "%u\n", sbi->gc_segment_mode);
+		return sysfs_emit(buf, "%s\n",
+				gc_mode_names[sbi->gc_segment_mode]);
 
 	if (!strcmp(a->attr.name, "gc_reclaimed_segments")) {
 		return sysfs_emit(buf, "%u\n",
-- 
2.35.1.894.gb6a874cedc-goog

