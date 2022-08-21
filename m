Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAD359B624
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 21:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiHUTbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 15:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiHUTaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 15:30:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10F52126F
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 12:30:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gb36so17539764ejc.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 12:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=al/JK9bLAqtsJplBLWLcTS1nU3F111F1zdBO/LEL9wg=;
        b=nXRjlTi+phBUSTGftVZKmdDJ/ujyKrfT4Og9+ltD1iRWGX+ClXijUYjK5hxzbckk9h
         dAf0uPqzrkm+avXsxkuFZRp79LyhHUTgvHEroR5FPFbsyGFKGIUE0RF+RU36JIDfIAGO
         xXHNpTbl+h+BX0hLPK+fIas8vaxchWMIxOBgSNVKjeiQGpEdt8Bj+cuKPL7fzuvN6u0H
         Qvpd+b3X6GTXnXJiHJgeYNtpfveK8nA0jbP91YNHFuhfJURpN1xtqZ4sXAxR++CwjZ8E
         IiUOULzQRntbWYIw/sWs+zWtjOfY+aGbA9S6H03anuGVucvB5Uq9fwFZViISSHCEzar9
         5GIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=al/JK9bLAqtsJplBLWLcTS1nU3F111F1zdBO/LEL9wg=;
        b=QwTY/tkKxap/KNrTax8jyZRhVlJ/eblkA1wvOUd/lvbROowmphegpzKZsT1s+gjG+o
         jqby7+slM8KEByJTBQhOpsHfEs625/1gSySn5//EjbpqHnGa5EoYsN0n2NGs9lqsyFMB
         1uH5x3Ym3BW9Qx7Znk3wgdmI106YciwC+XyoNlED7qJp0gdPnr0ndvQKgRh2WgiSsPOi
         8rd3hp3mRG1Er6xmHIoyJTqCGhzsc08XFerWcSGubtAJ2W6PkGscX8Rpa4i+ynAi7mGO
         rmyaREvFXYcrWs9hzGxeigAb3F26a+uF+WBtoY/0MVWHIqNcRWB+pzAdHGzu/AqelSQA
         Gb9Q==
X-Gm-Message-State: ACgBeo2/tBhSe4meQrV4S7z3CMcJt0JYIeeMr03HnXNzRT/7e0TLjYcy
        W88cvkp7se+qkih5W4jAi36aJqnUtx8dQA==
X-Google-Smtp-Source: AA6agR6swrgCXxEJciGtG3Z40ciBqeDbfoUJYSs5UIOCs2EMaVukNQ562kq6RJfCjl3hgDHnIYqgYw==
X-Received: by 2002:a17:906:58c7:b0:722:f4bf:cb75 with SMTP id e7-20020a17090658c700b00722f4bfcb75mr10826781ejs.450.1661110221871;
        Sun, 21 Aug 2022 12:30:21 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7c0cf000000b0043bbc9503ddsm6932174edp.76.2022.08.21.12.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 12:30:21 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] iversion: Use atomic64_try_cmpxchg
Date:   Sun, 21 Aug 2022 21:30:11 +0200
Message-Id: <20220821193011.88208-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Use atomic64_try_cmpxchg instead of
atomic64_cmpxchg (*ptr, old, new) == old in inode_set_max_iversion_raw,
inode_maybe_inc_version and inode_query_iversion. x86 CMPXCHG instruction
returns success in ZF flag, so this change saves a compare after cmpxchg
(and related move instruction in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old"
when cmpxchg fails, enabling further code simplifications.

The loop in inode_maybe_inc_iversion improves from:

    5563:	48 89 ca             	mov    %rcx,%rdx
    5566:	48 89 c8             	mov    %rcx,%rax
    5569:	48 83 e2 fe          	and    $0xfffffffffffffffe,%rdx
    556d:	48 83 c2 02          	add    $0x2,%rdx
    5571:	f0 48 0f b1 16       	lock cmpxchg %rdx,(%rsi)
    5576:	48 39 c1             	cmp    %rax,%rcx
    5579:	0f 84 85 fc ff ff    	je     5204 <...>
    557f:	48 89 c1             	mov    %rax,%rcx
    5582:	eb df                	jmp    5563 <...>

to:

    5563:	48 89 c2             	mov    %rax,%rdx
    5566:	48 83 e2 fe          	and    $0xfffffffffffffffe,%rdx
    556a:	48 83 c2 02          	add    $0x2,%rdx
    556e:	f0 48 0f b1 11       	lock cmpxchg %rdx,(%rcx)
    5573:	0f 84 8b fc ff ff    	je     5204 <...>
    5579:	eb e8                	jmp    5563 <...>

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/iversion.h | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/include/linux/iversion.h b/include/linux/iversion.h
index 3bfebde5a1a6..eb5a15810169 100644
--- a/include/linux/iversion.h
+++ b/include/linux/iversion.h
@@ -123,17 +123,12 @@ inode_peek_iversion_raw(const struct inode *inode)
 static inline void
 inode_set_max_iversion_raw(struct inode *inode, u64 val)
 {
-	u64 cur, old;
+	u64 cur = inode_peek_iversion_raw(inode);
 
-	cur = inode_peek_iversion_raw(inode);
-	for (;;) {
+	do {
 		if (cur > val)
 			break;
-		old = atomic64_cmpxchg(&inode->i_version, cur, val);
-		if (likely(old == cur))
-			break;
-		cur = old;
-	}
+	} while (!atomic64_try_cmpxchg(&inode->i_version, &cur, val));
 }
 
 /**
@@ -197,7 +192,7 @@ inode_set_iversion_queried(struct inode *inode, u64 val)
 static inline bool
 inode_maybe_inc_iversion(struct inode *inode, bool force)
 {
-	u64 cur, old, new;
+	u64 cur, new;
 
 	/*
 	 * The i_version field is not strictly ordered with any other inode
@@ -211,19 +206,14 @@ inode_maybe_inc_iversion(struct inode *inode, bool force)
 	 */
 	smp_mb();
 	cur = inode_peek_iversion_raw(inode);
-	for (;;) {
+	do {
 		/* If flag is clear then we needn't do anything */
 		if (!force && !(cur & I_VERSION_QUERIED))
 			return false;
 
 		/* Since lowest bit is flag, add 2 to avoid it */
 		new = (cur & ~I_VERSION_QUERIED) + I_VERSION_INCREMENT;
-
-		old = atomic64_cmpxchg(&inode->i_version, cur, new);
-		if (likely(old == cur))
-			break;
-		cur = old;
-	}
+	} while (!atomic64_try_cmpxchg(&inode->i_version, &cur, new));
 	return true;
 }
 
@@ -304,10 +294,10 @@ inode_peek_iversion(const struct inode *inode)
 static inline u64
 inode_query_iversion(struct inode *inode)
 {
-	u64 cur, old, new;
+	u64 cur, new;
 
 	cur = inode_peek_iversion_raw(inode);
-	for (;;) {
+	do {
 		/* If flag is already set, then no need to swap */
 		if (cur & I_VERSION_QUERIED) {
 			/*
@@ -320,11 +310,7 @@ inode_query_iversion(struct inode *inode)
 		}
 
 		new = cur | I_VERSION_QUERIED;
-		old = atomic64_cmpxchg(&inode->i_version, cur, new);
-		if (likely(old == cur))
-			break;
-		cur = old;
-	}
+	} while (!atomic64_try_cmpxchg(&inode->i_version, &cur, new));
 	return cur >> I_VERSION_QUERIED_SHIFT;
 }
 
-- 
2.37.1

