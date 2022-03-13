Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB1B4D724D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 04:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiCMDWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 22:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCMDWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 22:22:43 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD504C431
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 19:21:35 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 9so10873939pll.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 19:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hf1lU5ooM988RQKG5kd6WE1LnruM9x2R9ClOKkalAqM=;
        b=CfBJ/3pQ5HYq1zGd8zyiY+cojfefvddC3Wd+07g1KWHyGAQ2+B5f7w81rerkGYltGJ
         dH/Oyy8OJ2zffe7Dd8brs43WSsLIR+MoEi4mVMkqeX8+cuWZqO+MzREPgEMUv2JiwmEp
         7PRXQWzyflac47QNf2AuNTDz+DQEuGXWBdbcImDuMp3YK90G1doSS3gHTXSX1UeHSyKJ
         iLonNorTwmsEh93kC4Yn76At1vGAfjtHQu3BHrXXXunppOQfClLKhAvF64dJnA6X3ywl
         cufuawcx0KODpj/+gzhAHvY/9yNDbpLwvLt9nKDunZz0J5J2sQJ2ekthG9EJ/x4XRKjf
         o2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hf1lU5ooM988RQKG5kd6WE1LnruM9x2R9ClOKkalAqM=;
        b=VVXz3unylEeX0/D4az//w6ALTdhF5K3lQNQ9piolXoEYl5KEez4w8aWE/3uiiJ0yoi
         IJRX93Bcl4n+qTZHT0uNd7X3hDQ38mIEC3WVdxsVkOAYh7CNLur5w3O2Owds7VLo13gU
         mA4PjxoQ5noVZ4JhDAUeUkaThW9KFo41wBXHm38GvWWq+4Id+Q4MvULDn1Dc5v1OYRa6
         wqBi2sUrS3G9xbxsxw4Nm/uaRo83SRsTmkN1KNiJtBup2YuA9JSxccJUsRzsnp/K8kBF
         v39GdwNjqFiMQuJ2UY5KTyCtIDBWNllQ3bi2QMfd88R36CuIEHx9T0Dz4E43irgNu9Z/
         VbRA==
X-Gm-Message-State: AOAM530xhCxic0gRWAW0Nyf7TJfRjIa3qeSbJNKBpzaFrIB2549xTxA+
        QWH7IiSTXz6JidPgVUv6N4g25kf1lgsdmU24
X-Google-Smtp-Source: ABdhPJyUjc3Wrouq7LpAHIB8VqerD8hasNgbq+9DtzU+SzF4hMF2j/leWFql5snBmZuofuT0FW500g==
X-Received: by 2002:a17:902:ce0a:b0:14f:bdcd:a56 with SMTP id k10-20020a170902ce0a00b0014fbdcd0a56mr17446297plg.97.1647141694823;
        Sat, 12 Mar 2022 19:21:34 -0800 (PST)
Received: from localhost.localdomain ([119.3.102.56])
        by smtp.gmail.com with ESMTPSA id j11-20020a63230b000000b00372a08b584asm12431762pgj.47.2022.03.12.19.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 19:21:34 -0800 (PST)
From:   Bang Li <libang.linuxer@gmail.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, Bang Li <libang.linuxer@gmail.com>
Subject: [PATCH] kprobes: Allow both @symbol_name and @addr to exist
Date:   Sun, 13 Mar 2022 11:21:25 +0800
Message-Id: <20220313032125.124094-1-libang.linuxer@gmail.com>
X-Mailer: git-send-email 2.25.1
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

If the address found by the @symbol_name is equal to the @addr, this case
should be considered a valid parameter combinations.

Example:

static struct kprobe kp = {
    .symbol_name    = "kernel_clone",
    .addr           = (kprobe_opcode_t*)kernel_clone,
};

Signed-off-by: Bang Li <libang.linuxer@gmail.com>
---
 kernel/kprobes.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 94cab8c9ce56..70d4ed9e7dc7 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1497,13 +1497,19 @@ bool within_kprobe_blacklist(unsigned long addr)
 static kprobe_opcode_t *_kprobe_addr(kprobe_opcode_t *addr,
 			const char *symbol_name, unsigned int offset)
 {
-	if ((symbol_name && addr) || (!symbol_name && !addr))
+	kprobe_opcode_t *symbol_addr;
+
+	if (!symbol_name && !addr)
 		goto invalid;
 
 	if (symbol_name) {
-		addr = kprobe_lookup_name(symbol_name, offset);
-		if (!addr)
+		symbol_addr = kprobe_lookup_name(symbol_name, offset);
+		if (!symbol_addr)
 			return ERR_PTR(-ENOENT);
+
+		if (addr && symbol_addr != addr)
+			goto invalid;
+		addr = symbol_addr;
 	}
 
 	addr = (kprobe_opcode_t *)(((char *)addr) + offset);
@@ -2062,8 +2068,7 @@ bool __weak arch_kprobe_on_func_entry(unsigned long offset)
  * function entry address or not.
  * This returns 0 if it is the function entry, or -EINVAL if it is not.
  * And also it returns -ENOENT if it fails the symbol or address lookup.
- * Caller must pass @addr or @sym (either one must be NULL), or this
- * returns -EINVAL.
+ * Caller must pass @addr or @sym, or this returns -EINVAL.
  */
 int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
 {
-- 
2.25.1

