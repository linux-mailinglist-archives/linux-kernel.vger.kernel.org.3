Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0147849B608
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578498AbiAYOUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387998AbiAYOO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:14:57 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD9BC061744;
        Tue, 25 Jan 2022 06:14:56 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l5so46051922edv.3;
        Tue, 25 Jan 2022 06:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k+CgfQJbyed6dtUDLhZo4uiteDWSo0FQKuqRzl0IeVw=;
        b=bYATyVvaBSeEE52mObJNrtCyRpMGqOMNkUxMHfHFsdMbJx+GFlcDZFawVTpRb2M6jd
         QqfkVSweYUIfdBzBjJ8nEemJGbV9to/5C0YnLh75J0TrV0ebCuo44+s9sg6gIEVmhDCA
         LNG5kq7ZMCCjeie8XRa0m4CTegkPxlw4sj7pe/XZbnV2/Hl+qsKTSwlzlJz7UnOL4VSE
         L/V4K5WqXQ4z/QUTmpOzSHauq6rS7JO+Btez9ZMmxTONP6XxEW864IixNECdXo9+BMwv
         VjB8IU/iZHiQkMYruhiU73gwKcryJb7It7J5ay/KEt+MNhu44YtTmXHgJI8EuxXzWkNZ
         H11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k+CgfQJbyed6dtUDLhZo4uiteDWSo0FQKuqRzl0IeVw=;
        b=gphnAPgL5r7OvJJkyp6+TxHrLruQUAc7gUiJpmsf8v3P9LGEd9+4X3Zrcephpx8f/T
         mSQQye4XQuItOMc7g5X2MvpZmV87fAa32J2ukqPAKQ5d5PUM6gT1PeP6n4sFYqfzkcy/
         ZM4Zs2RHHUztbkBcJ+BhiptNkJPpxun8BCNFPbZgtYdSwUCCU8h72bl2+w7ty5W9TCI2
         1Etj3nuAz5LC2TBcgrzG7sqtczSKJ7XQO6RfY0h7k4RWugn+zjY13y4Fw5VbRHX9ei8U
         TF0TZuQyZ5M/lpb6FIplEi3rUNizFkxRZ6PwfzJcbsumpdmGYqlzAamZYh8AACy7Tuc7
         JEsg==
X-Gm-Message-State: AOAM531LXTPMQYjVpiozgpsVcgRxIKXKHxVQKnC+gF5XBPPBJuPRLJ46
        KgD2a2pTAzrdGIgn5d+IdT5EKyT2f6PQsw==
X-Google-Smtp-Source: ABdhPJxR4z1J9aUIgzhuPP3EwJYNQiMKrZpekbZb9uwX2w62yIB0i7WedFAVwCDGuJXWuIi7OqrJsg==
X-Received: by 2002:a17:907:9495:: with SMTP id dm21mr16065429ejc.467.1643120094730;
        Tue, 25 Jan 2022 06:14:54 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-144-044.77.10.pool.telefonica.de. [77.10.144.44])
        by smtp.gmail.com with ESMTPSA id lu44sm6292929ejb.145.2022.01.25.06.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:14:54 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 4/9] selinux: enclose macro arguments in parenthesis
Date:   Tue, 25 Jan 2022 15:14:14 +0100
Message-Id: <20220125141422.32655-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125141422.32655-1-cgzones@googlemail.com>
References: <20220125141422.32655-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enclose the macro arguments in parenthesis to avoid potential evaluation
order issues.

Note the xperm and ebitmap macros are still not side-effect safe due to
double evaluation.

Reported by clang-tidy [bugprone-macro-parentheses]

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/include/security.h | 4 ++--
 security/selinux/ss/ebitmap.h       | 6 +++---
 security/selinux/ss/sidtab.c        | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 6482e0efb368..d91a5672de99 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -254,8 +254,8 @@ struct av_decision {
 #define XPERMS_AUDITALLOW 2
 #define XPERMS_DONTAUDIT 4
 
-#define security_xperm_set(perms, x) (perms[x >> 5] |= 1 << (x & 0x1f))
-#define security_xperm_test(perms, x) (1 & (perms[x >> 5] >> (x & 0x1f)))
+#define security_xperm_set(perms, x) ((perms)[(x) >> 5] |= 1 << ((x) & 0x1f))
+#define security_xperm_test(perms, x) (1 & ((perms)[(x) >> 5] >> ((x) & 0x1f)))
 struct extended_perms_data {
 	u32 p[8];
 };
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index 9eb2d0af2805..58eb822f11ee 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -118,9 +118,9 @@ static inline void ebitmap_node_clr_bit(struct ebitmap_node *n,
 }
 
 #define ebitmap_for_each_positive_bit(e, n, bit)	\
-	for (bit = ebitmap_start_positive(e, &n);	\
-	     bit < ebitmap_length(e);			\
-	     bit = ebitmap_next_positive(e, &n, bit))	\
+	for ((bit) = ebitmap_start_positive(e, &(n));	\
+	     (bit) < ebitmap_length(e);			\
+	     (bit) = ebitmap_next_positive(e, &(n), bit))	\
 
 int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
 int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index 293ec048af08..a54b8652bfb5 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -27,8 +27,8 @@ struct sidtab_str_cache {
 	char str[];
 };
 
-#define index_to_sid(index) (index + SECINITSID_NUM + 1)
-#define sid_to_index(sid) (sid - (SECINITSID_NUM + 1))
+#define index_to_sid(index) ((index) + SECINITSID_NUM + 1)
+#define sid_to_index(sid) ((sid) - (SECINITSID_NUM + 1))
 
 int sidtab_init(struct sidtab *s)
 {
-- 
2.34.1

