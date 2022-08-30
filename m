Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E59B5A67BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiH3PxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiH3PxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:53:02 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795E96DFB6;
        Tue, 30 Aug 2022 08:53:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u9so23084513ejy.5;
        Tue, 30 Aug 2022 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=nrfIRQX5q1nidyZ0oGiETnLL4SM/AYUZOLgvVu+qVak=;
        b=bFPCtMapHr9hdk7w3Av7NWI33E66yMc3+YhL2t4yUVSAjG9GnEofu/G0gN+mSEp/el
         mUVG/EgQcZK5fT0VhI6UUUqxFxdOrCayTMfdevs7BZex7Mz3HjuNvwkq1IyZtAG9duVE
         J4zNWRvqiyrFBsqu7aDHpFuLUADgpt6+OUFaBEF38Zm2YnUWUvYh1BjTn6/xlYP6auol
         o18XswejGu3CzscKiHpZvmdOUd80BgT+dz367ZCXrPGWnqzjMcfZNW3JAa/d8unX+VGE
         oB+nmf7Vbpi9PTK24h51s2v8PkRgq9rdUlVASAXATj/lXy5EQJkLsJrpvDCXD5pWELhQ
         rkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=nrfIRQX5q1nidyZ0oGiETnLL4SM/AYUZOLgvVu+qVak=;
        b=Uys+HzqBj9r3dhyVy8jq27jJw1k2kRUQ3vOYaqJ0rQUVdNnDvVq4SFH/Jde41C3hLq
         82d1iDkLLpcDcFtMl60z0IGOcJ/W4M/UYmIXaWAQKxxS61w8P7yzVo7kv3DluFcMCRVU
         /EAOC3Vr6L5Hc10IBdbZeOb909ZGWxb5dBXFSV6gGQfTzE7JD4lkmIlJvZQbo6nNd6mN
         5L6I1kxveSBYZuMed8khfdoBVmJNB9kYoaAhDxeUZpCuvBwvLfHQJExS6X/lD1udByc+
         /PbK/DekcuRj6YMmBtJkFn3rgMmJxdWpIt2wgLjp8mBFc6hS6Ok+BrkTl1xoTojYiO3H
         BUjA==
X-Gm-Message-State: ACgBeo3j7fMXjlzQX4Gop736H0EfMHSvWMs0DWFiSi3hVBLte5PO1Zko
        w9Zlgwr9TrTZwmEgS50htbRAGgiyKO4q7Q==
X-Google-Smtp-Source: AA6agR4Jto1AmLJIjDaOGO1a3YtP2fe5xc4smjcEyCQd9d9xj/QPNY5HA5knIU+0tktGvQZRuoAjLw==
X-Received: by 2002:a17:907:2816:b0:741:9246:17d2 with SMTP id eb22-20020a170907281600b00741924617d2mr6871761ejc.158.1661874779931;
        Tue, 30 Aug 2022 08:52:59 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-163-172.95.116.pool.telefonica.de. [95.116.163.172])
        by smtp.gmail.com with ESMTPSA id dk1-20020a0564021d8100b0043bea0a48d0sm7497931edb.22.2022.08.30.08.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 08:52:59 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: declare read-only parameters const
Date:   Tue, 30 Aug 2022 17:52:49 +0200
Message-Id: <20220830155253.19364-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Declare ebitmap, mls_level and mls_context parameters const where they
are only read from.  This allows callers to supply pointers to const
as arguments and increases readability.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
This patch is similar to userspace commits ("libsepol: mark read-only
parameters of ebitmap interfaces const") [1] and ("libsepol: mark
immutable mls and context parameter const") [2].
Pointers to const are for example used in the (for now userspace only)
policy validation code.

[1]: https://github.com/SELinuxProject/selinux/commit/390ec54d278a14d9c29b80cc4fc5cb9ba504ed13
[2]: https://github.com/SELinuxProject/selinux/commit/6359946633507db1d98b24638cf22eb5afdcd272
---
 security/selinux/ss/context.h   | 17 +++++++++--------
 security/selinux/ss/ebitmap.c   | 21 +++++++++++----------
 security/selinux/ss/ebitmap.h   | 18 +++++++++---------
 security/selinux/ss/mls_types.h |  4 ++--
 4 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index 62990aa1ec9e..eda32c3d4c0a 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -38,7 +38,7 @@ static inline void mls_context_init(struct context *c)
 	memset(&c->range, 0, sizeof(c->range));
 }
 
-static inline int mls_context_cpy(struct context *dst, struct context *src)
+static inline int mls_context_cpy(struct context *dst, const struct context *src)
 {
 	int rc;
 
@@ -58,7 +58,7 @@ static inline int mls_context_cpy(struct context *dst, struct context *src)
 /*
  * Sets both levels in the MLS range of 'dst' to the low level of 'src'.
  */
-static inline int mls_context_cpy_low(struct context *dst, struct context *src)
+static inline int mls_context_cpy_low(struct context *dst, const struct context *src)
 {
 	int rc;
 
@@ -78,7 +78,7 @@ static inline int mls_context_cpy_low(struct context *dst, struct context *src)
 /*
  * Sets both levels in the MLS range of 'dst' to the high level of 'src'.
  */
-static inline int mls_context_cpy_high(struct context *dst, struct context *src)
+static inline int mls_context_cpy_high(struct context *dst, const struct context *src)
 {
 	int rc;
 
@@ -97,9 +97,10 @@ static inline int mls_context_cpy_high(struct context *dst, struct context *src)
 
 
 static inline int mls_context_glblub(struct context *dst,
-				     struct context *c1, struct context *c2)
+				     const struct context *c1, const struct context *c2)
 {
-	struct mls_range *dr = &dst->range, *r1 = &c1->range, *r2 = &c2->range;
+	struct mls_range *dr = &dst->range;
+	const struct mls_range *r1 = &c1->range, *r2 = &c2->range;
 	int rc = 0;
 
 	if (r1->level[1].sens < r2->level[0].sens ||
@@ -127,7 +128,7 @@ static inline int mls_context_glblub(struct context *dst,
 	return rc;
 }
 
-static inline int mls_context_cmp(struct context *c1, struct context *c2)
+static inline int mls_context_cmp(const struct context *c1, const struct context *c2)
 {
 	return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
 		ebitmap_cmp(&c1->range.level[0].cat, &c2->range.level[0].cat) &&
@@ -147,7 +148,7 @@ static inline void context_init(struct context *c)
 	memset(c, 0, sizeof(*c));
 }
 
-static inline int context_cpy(struct context *dst, struct context *src)
+static inline int context_cpy(struct context *dst, const struct context *src)
 {
 	int rc;
 
@@ -180,7 +181,7 @@ static inline void context_destroy(struct context *c)
 	mls_context_destroy(c);
 }
 
-static inline int context_cmp(struct context *c1, struct context *c2)
+static inline int context_cmp(const struct context *c1, const struct context *c2)
 {
 	if (c1->len && c2->len)
 		return (c1->len == c2->len && !strcmp(c1->str, c2->str));
diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index abde349c8321..d31b87be9a1e 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -28,9 +28,9 @@
 
 static struct kmem_cache *ebitmap_node_cachep __ro_after_init;
 
-int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2)
+int ebitmap_cmp(const struct ebitmap *e1, const struct ebitmap *e2)
 {
-	struct ebitmap_node *n1, *n2;
+	const struct ebitmap_node *n1, *n2;
 
 	if (e1->highbit != e2->highbit)
 		return 0;
@@ -50,9 +50,10 @@ int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2)
 	return 1;
 }
 
-int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src)
+int ebitmap_cpy(struct ebitmap *dst, const struct ebitmap *src)
 {
-	struct ebitmap_node *n, *new, *prev;
+	struct ebitmap_node *new, *prev;
+	const struct ebitmap_node *n;
 
 	ebitmap_init(dst);
 	n = src->node;
@@ -78,7 +79,7 @@ int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src)
 	return 0;
 }
 
-int ebitmap_and(struct ebitmap *dst, struct ebitmap *e1, struct ebitmap *e2)
+int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1, const struct ebitmap *e2)
 {
 	struct ebitmap_node *n;
 	int bit, rc;
@@ -217,9 +218,9 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
  * if last_e2bit is non-zero, the highest set bit in e2 cannot exceed
  * last_e2bit.
  */
-int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2, u32 last_e2bit)
+int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2, u32 last_e2bit)
 {
-	struct ebitmap_node *n1, *n2;
+	const struct ebitmap_node *n1, *n2;
 	int i;
 
 	if (e1->highbit < e2->highbit)
@@ -258,9 +259,9 @@ int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2, u32 last_e2bit)
 	return 1;
 }
 
-int ebitmap_get_bit(struct ebitmap *e, unsigned long bit)
+int ebitmap_get_bit(const struct ebitmap *e, unsigned long bit)
 {
-	struct ebitmap_node *n;
+	const struct ebitmap_node *n;
 
 	if (e->highbit < bit)
 		return 0;
@@ -467,7 +468,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 	goto out;
 }
 
-int ebitmap_write(struct ebitmap *e, void *fp)
+int ebitmap_write(const struct ebitmap *e, void *fp)
 {
 	struct ebitmap_node *n;
 	u32 count;
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index 58eb822f11ee..e5b57dc3fc53 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -44,7 +44,7 @@ struct ebitmap {
 
 #define ebitmap_length(e) ((e)->highbit)
 
-static inline unsigned int ebitmap_start_positive(struct ebitmap *e,
+static inline unsigned int ebitmap_start_positive(const struct ebitmap *e,
 						  struct ebitmap_node **n)
 {
 	unsigned int ofs;
@@ -62,7 +62,7 @@ static inline void ebitmap_init(struct ebitmap *e)
 	memset(e, 0, sizeof(*e));
 }
 
-static inline unsigned int ebitmap_next_positive(struct ebitmap *e,
+static inline unsigned int ebitmap_next_positive(const struct ebitmap *e,
 						 struct ebitmap_node **n,
 						 unsigned int bit)
 {
@@ -85,7 +85,7 @@ static inline unsigned int ebitmap_next_positive(struct ebitmap *e,
 #define EBITMAP_NODE_OFFSET(node, bit)	\
 	(((bit) - (node)->startbit) % EBITMAP_UNIT_SIZE)
 
-static inline int ebitmap_node_get_bit(struct ebitmap_node *n,
+static inline int ebitmap_node_get_bit(const struct ebitmap_node *n,
 				       unsigned int bit)
 {
 	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
@@ -122,15 +122,15 @@ static inline void ebitmap_node_clr_bit(struct ebitmap_node *n,
 	     (bit) < ebitmap_length(e);			\
 	     (bit) = ebitmap_next_positive(e, &(n), bit))	\
 
-int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
-int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
-int ebitmap_and(struct ebitmap *dst, struct ebitmap *e1, struct ebitmap *e2);
-int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2, u32 last_e2bit);
-int ebitmap_get_bit(struct ebitmap *e, unsigned long bit);
+int ebitmap_cmp(const struct ebitmap *e1, const struct ebitmap *e2);
+int ebitmap_cpy(struct ebitmap *dst, const struct ebitmap *src);
+int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1, const struct ebitmap *e2);
+int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2, u32 last_e2bit);
+int ebitmap_get_bit(const struct ebitmap *e, unsigned long bit);
 int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value);
 void ebitmap_destroy(struct ebitmap *e);
 int ebitmap_read(struct ebitmap *e, void *fp);
-int ebitmap_write(struct ebitmap *e, void *fp);
+int ebitmap_write(const struct ebitmap *e, void *fp);
 u32 ebitmap_hash(const struct ebitmap *e, u32 hash);
 
 #ifdef CONFIG_NETLABEL
diff --git a/security/selinux/ss/mls_types.h b/security/selinux/ss/mls_types.h
index 068e0d7809db..7d48d5e52233 100644
--- a/security/selinux/ss/mls_types.h
+++ b/security/selinux/ss/mls_types.h
@@ -27,13 +27,13 @@ struct mls_range {
 	struct mls_level level[2]; /* low == level[0], high == level[1] */
 };
 
-static inline int mls_level_eq(struct mls_level *l1, struct mls_level *l2)
+static inline int mls_level_eq(const struct mls_level *l1, const struct mls_level *l2)
 {
 	return ((l1->sens == l2->sens) &&
 		ebitmap_cmp(&l1->cat, &l2->cat));
 }
 
-static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
+static inline int mls_level_dom(const struct mls_level *l1, const struct mls_level *l2)
 {
 	return ((l1->sens >= l2->sens) &&
 		ebitmap_contains(&l1->cat, &l2->cat, 0));
-- 
2.37.2

