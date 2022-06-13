Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E77B54825B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiFMIgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbiFMIgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:36:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D361EC4C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:36:32 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s37so2451231pfg.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pCJJn3iWRw6OnrX8kY2ouhNb0P2eNnNgWizzY/eWgek=;
        b=P1aeYEk9YAXBnUC5Mbf4BRVshjLqMIeKCceANPYqNNesrWlwaok23++oR4V6n+wk0E
         tQHlK2SLP/zlx0A6Gg8W/lKSF8h/JZ1GY6EOpZ5eUOs407TRPaflfG/RdRcujnhjICeF
         rAP6gE3LQyr7J1OE/eKzZ6nhQAD1n/IXPveUT+NTb6tvm/xdarYsAmtOeanYcIlVyAEe
         Y0tl/ofM6A2bWYxN6ldp9pPHGY1iglsJsMDhOj3DmUamiV7SjJ7wmouTtUtjmlbXrbp0
         2PqS78JlCAf/qHp+J9STnNHWimzWDWKhQX95gINIUflj33kRMaIJv7N4tcudyQ7e3vwu
         3G8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pCJJn3iWRw6OnrX8kY2ouhNb0P2eNnNgWizzY/eWgek=;
        b=ItAhBNUFl0FM4sl1q9S+ljAnUbD36ub6ELiPbiPYCDRIq96ByCSFFqSe3etr5fRmwZ
         S0Hmy9XS05ac2QpACCAF0G8gN0OUJ5957Kod+rjJBcVPJVDdUrjib+GECSeSi/KWvo7g
         qkHUzmp25JDIylgb2XPXgrLFoYdC8AGCu+7TZADMKVw/kEFbnWlVu9aKdkuInGrJjzTb
         qCi0M4mvd/NpcQeRuFMIWosp9ggQGr3/4r8OoMyl2xSiqIleUuGlKTNN7mPpHfKbec5S
         YPzYS2BDiuqBPWJV7Dkb3LUsDIriMQ3ym0Wmaa1MG2RvxBYsuzzAyw4Iiv/8Mnf1mAGs
         mzVA==
X-Gm-Message-State: AOAM5306NkGqumck+yGl+5wr1vuieoZ8hMsirTTQ/HMbMfA198m7jvsh
        iNn+dEUM+PU/I2YXKkvsEWgzMUFyaycroQ==
X-Google-Smtp-Source: ABdhPJwZYU1lKJtMIo3S0zKZ4guU0/nRbTnCYw4fiWtvqW1tjhFXeRZp94z+1kRtbg3++dI5/EjTJA==
X-Received: by 2002:a05:6a00:10d0:b0:4f7:5af4:47b6 with SMTP id d16-20020a056a0010d000b004f75af447b6mr58501582pfu.6.1655109391656;
        Mon, 13 Jun 2022 01:36:31 -0700 (PDT)
Received: from localhost.localdomain (l3b2w1.cn. [159.138.1.25])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902684f00b00163ffbc4f74sm4472306pln.49.2022.06.13.01.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 01:36:31 -0700 (PDT)
From:   binglei wang <l3b2w1@gmail.com>
X-Google-Original-From: binglei wang
To:     mhiramat@kernel.org
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        binglei wang <l3b2w1@gmail.com>
Subject: [PATCH 2/2] kprobes: refactor populate_kprobe_blacklist()
Date:   Mon, 13 Jun 2022 16:36:27 +0800
Message-Id: <20220613083627.22388-1-l3b2w1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: binglei wang <l3b2w1@gmail.com>

Just make it seems orderly

Signed-off-by: binglei wang <l3b2w1@gmail.com>
---
 kernel/kprobes.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f4a829d98..b2b1ef7bc 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2475,6 +2475,26 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
 	return 0;
 }
 
+/* Add all symbols marked with NOKPROBE_SYMBOL into kprobe blacklist */
+static int __init kprobe_add_nokpb_blacklist(unsigned long *start,
+					     unsigned long *end)
+{
+	unsigned long entry;
+	unsigned long *iter;
+	int ret = 0;
+
+	for (iter = start; iter < end; iter++) {
+		entry = (unsigned long)dereference_symbol_descriptor((void *)*iter);
+		ret = kprobe_add_ksym_blacklist(entry);
+		if (ret == -EINVAL)
+			continue;
+		if (ret < 0)
+			return ret;
+	}
+
+	return ret;
+}
+
 /* Remove all symbols in given area from kprobe blacklist */
 static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
 {
@@ -2528,21 +2548,15 @@ int __init __weak arch_populate_kprobe_blacklist(void)
  * since a kprobe need not necessarily be at the beginning
  * of a function.
  */
-static int __init populate_kprobe_blacklist(unsigned long *start,
-					     unsigned long *end)
+static int __init populate_kprobe_blacklist(void)
 {
-	unsigned long entry;
-	unsigned long *iter;
 	int ret;
 
-	for (iter = start; iter < end; iter++) {
-		entry = (unsigned long)dereference_symbol_descriptor((void *)*iter);
-		ret = kprobe_add_ksym_blacklist(entry);
-		if (ret == -EINVAL)
-			continue;
-		if (ret < 0)
-			return ret;
-	}
+	/* Symbols in '__start/__stop_kprobe_blacklist' are blacklisted */
+	ret = kprobe_add_nokpb_blacklist(__start_kprobe_blacklist,
+					__stop_kprobe_blacklist);
+	if (ret)
+		return ret;
 
 	/* Symbols in '__kprobes_text' are blacklisted */
 	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
@@ -2690,8 +2704,7 @@ static int __init init_kprobes(void)
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++)
 		INIT_HLIST_HEAD(&kprobe_table[i]);
 
-	err = populate_kprobe_blacklist(__start_kprobe_blacklist,
-					__stop_kprobe_blacklist);
+	err = populate_kprobe_blacklist();
 	if (err)
 		pr_err("Failed to populate blacklist (error %d), kprobes not restricted, be careful using them!\n", err);
 
-- 
2.27.0

