Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7279C598098
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 11:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbiHRJMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 05:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbiHRJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:12:34 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BA9B0B0F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 02:12:32 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id by6so1097409ljb.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc;
        bh=LSSLTgSMFFP5fHWDipdig1f1bl2a47JUwYw0fptCRRM=;
        b=pTgBBomklNCmyaeRkuMe2YioJx/62lZpHXpYqteXmel2YGsYeq5VNRua5bjpp2jiC0
         ZvQSf7UGL9kWFnpAIojRB/BCsvxO3O22HMo6qMx80K0ummMbH/AYivyjEoPiYCrlP/UT
         BD7lq9fFRy0MKBRMXRasVdGYrmcId2j6hiCc1lOyKBz441j7A7nJppu3uxIlSNXdsJs0
         PIscMWn8Iw1U1hcKXM3/WVfmV3NEXyjjbjPSTjJ+l/CjpTAFQMaRNzUTHT/PT+2s/Jm6
         wdnjThTVhyx+6w/lJzfUjEJ73NSBymnr0MtkdxxxtDxSqt+Sp338tsZ2VBnxWaLSPKB8
         DTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=LSSLTgSMFFP5fHWDipdig1f1bl2a47JUwYw0fptCRRM=;
        b=Dx/ahA0VVgOLkcLT8dnyg3SIrTeg9pfU4+zrWnkHibf6OxiOxMYCgr2W3wkkAjJdli
         wwIoruX/5RcKzCjom+u/DyVa19meo6yQlV1rYEJMzZTxon4CEBc+b1l3RsGRk77wLp29
         5bKpX+hGDuTS4OcpBIPXdnJVYLcuh/ydfK3RQfD0YtSW8V9HBuIRriOSCxZgCJwAd/OR
         aBx0QINFdJiJTH8SiKiWfQh4BEYZGVR9s0BFvytwJG6MYIASv+7vUezcYgQjMNsvaYSu
         FfU6EimV3ByyPWTM6HMXLc9wFOT+wLvvdodjxUDOukdtvQ+6hudXpy0sm/vB8uFRd0ic
         S+bA==
X-Gm-Message-State: ACgBeo2Fpx8LW6y3OUexASZF9KExU8ch2mn2D7Aw/M8ZpCDkixrgKVql
        NXOAxPA8RexaBX8DVsBpnnONJA==
X-Google-Smtp-Source: AA6agR74U8TOaEtyR5T+AGhIPfKz8pv9p2w+usFrWPEBoqzQiWJaztOlr7cav8wUmaoZlLIAzvJSlA==
X-Received: by 2002:a05:651c:12c4:b0:25d:d71c:e249 with SMTP id 4-20020a05651c12c400b0025dd71ce249mr563652lje.17.1660813951145;
        Thu, 18 Aug 2022 02:12:31 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.143])
        by smtp.gmail.com with ESMTPSA id r2-20020a2e8e22000000b00261a8e56fe4sm146615ljk.55.2022.08.18.02.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 02:12:30 -0700 (PDT)
Message-ID: <d73bd478-e373-f759-2acb-2777f6bba06f@openvz.org>
Date:   Thu, 18 Aug 2022 12:12:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Vasily Averin <vvs@openvz.org>
Subject: [RFC PATCH] simple_xattr: switch from list to rb_tree
To:     Roman Gushchin <roman.gushchin@linux.dev>, mkoutny@suse.com,
        tj@kernel.org
Cc:     gregkh@linuxfoundation.org, hannes@cmpxchg.org, kernel@openvz.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, shakeelb@google.com,
        songmuchun@bytedance.com, viro@zeniv.linux.org.uk,
        Christian Brauner <brauner@kernel.org>
References: <62188f37-f816-08e9-cdd5-8df23131746d@openvz.org>
Content-Language: en-US
In-Reply-To: <62188f37-f816-08e9-cdd5-8df23131746d@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch was announced here:
https://lore.kernel.org/all/62188f37-f816-08e9-cdd5-8df23131746d@openvz.org/
"5) simple_xattrs: replace list to rb-tree
  This significantly reduces the search time for existing entries."

It was compiled but was not tested yet.
---
Currently simple_xattr uses a list to store existing entries.
If the list grows, the presence check may be slow and potentially
lead to problems. Red-black tree should work more efficiently
in this situation.

This patch replaces list to rb_tree and switches simple_xattr_* calls
to its using.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 fs/xattr.c            | 109 ++++++++++++++++++++++++++++++++----------
 include/linux/xattr.h |  13 +++--
 2 files changed, 92 insertions(+), 30 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 6401703707f2..672f2214fcfd 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1021,6 +1021,60 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
 	return new_xattr;
 }
 
+static struct simple_xattr *simple_xattr_rb_search(struct rb_root *root,
+						   const char* name)
+{
+	struct rb_node **new = &(root->rb_node), *parent = NULL;
+
+	/* Figure out where to put new node */
+	while (*new)
+	{
+		struct simple_xattr *xattr;
+		int result;
+
+		xattr = container_of(*new, struct simple_xattr, node);
+		result = strcmp(xattr->name, name);
+
+		parent = *new;
+		if (result < 0)
+			new = &((*new)->rb_left);
+		else if (result > 0)
+			new = &((*new)->rb_right);
+		else
+			return xattr;
+	}
+	return NULL;
+}
+
+static bool simple_xattr_rb_insert(struct rb_root *root,
+				   struct simple_xattr *new_xattr)
+{
+	struct rb_node **new = &(root->rb_node), *parent = NULL;
+
+	/* Figure out where to put new node */
+	while (*new) {
+		struct simple_xattr *xattr;
+		int result;
+
+		xattr = container_of(*new, struct simple_xattr, node);
+		result = strcmp(xattr->name, new_xattr->name);
+
+		parent = *new;
+		if (result < 0)
+			new = &((*new)->rb_left);
+		else if (result > 0)
+			new = &((*new)->rb_right);
+		else
+			return false;
+	}
+
+	/* Add new node and rebalance tree. */
+	rb_link_node(&new_xattr->node, parent, new);
+	rb_insert_color(&new_xattr->node, root);
+
+	return true;
+}
+
 /*
  * xattr GET operation for in-memory/pseudo filesystems
  */
@@ -1031,10 +1085,8 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 	int ret = -ENODATA;
 
 	spin_lock(&xattrs->lock);
-	list_for_each_entry(xattr, &xattrs->head, list) {
-		if (strcmp(name, xattr->name))
-			continue;
-
+	xattr = simple_xattr_rb_search(&xattrs->rb_root, name);
+	if (xattr) {
 		ret = xattr->size;
 		if (buffer) {
 			if (size < xattr->size)
@@ -1042,7 +1094,6 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 			else
 				memcpy(buffer, xattr->value, xattr->size);
 		}
-		break;
 	}
 	spin_unlock(&xattrs->lock);
 	return ret;
@@ -1067,7 +1118,7 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 		     const void *value, size_t size, int flags,
 		     ssize_t *removed_size)
 {
-	struct simple_xattr *xattr;
+	struct simple_xattr *xattr = NULL;
 	struct simple_xattr *new_xattr = NULL;
 	int err = 0;
 
@@ -1088,31 +1139,36 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 	}
 
 	spin_lock(&xattrs->lock);
-	list_for_each_entry(xattr, &xattrs->head, list) {
-		if (!strcmp(name, xattr->name)) {
-			if (flags & XATTR_CREATE) {
-				xattr = new_xattr;
-				err = -EEXIST;
-			} else if (new_xattr) {
-				list_replace(&xattr->list, &new_xattr->list);
+	if ((flags & XATTR_CREATE) && new_xattr) {
+		/* create new */
+		if (!simple_xattr_rb_insert(&xattrs->rb_root, new_xattr)) {
+			/* already exist */
+			xattr = new_xattr;
+			err = -EEXIST;
+		}
+	} else {
+		/* replace or remove */
+		xattr = simple_xattr_rb_search(&xattrs->rb_root, name);
+		if (xattr) {
+			/* found */
+			if (!new_xattr) {
+				/* remove existing */
+				rb_erase(&xattr->node, &xattrs->rb_root);
 				if (removed_size)
 					*removed_size = xattr->size;
 			} else {
-				list_del(&xattr->list);
+				/* replace existing */
+				rb_replace_node(&xattr->node, &new_xattr->node,
+						&xattrs->rb_root);
 				if (removed_size)
 					*removed_size = xattr->size;
 			}
-			goto out;
+		} else if (new_xattr) {
+			/* not found, incorrect replace */
+			xattr = new_xattr;
+			err = -ENODATA;
 		}
 	}
-	if (flags & XATTR_REPLACE) {
-		xattr = new_xattr;
-		err = -ENODATA;
-	} else {
-		list_add(&new_xattr->list, &xattrs->head);
-		xattr = NULL;
-	}
-out:
 	spin_unlock(&xattrs->lock);
 	if (xattr) {
 		kfree(xattr->name);
@@ -1149,6 +1205,7 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 {
 	bool trusted = capable(CAP_SYS_ADMIN);
 	struct simple_xattr *xattr;
+	struct rb_node *node;
 	ssize_t remaining_size = size;
 	int err = 0;
 
@@ -1170,7 +1227,9 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 #endif
 
 	spin_lock(&xattrs->lock);
-	list_for_each_entry(xattr, &xattrs->head, list) {
+	for (node = rb_first(&xattrs->rb_root); node; node = rb_next(node)) {
+		xattr = container_of(node, struct simple_xattr, node);
+
 		/* skip "trusted." attributes for unprivileged callers */
 		if (!trusted && xattr_is_trusted(xattr->name))
 			continue;
@@ -1191,6 +1250,6 @@ void simple_xattr_list_add(struct simple_xattrs *xattrs,
 			   struct simple_xattr *new_xattr)
 {
 	spin_lock(&xattrs->lock);
-	list_add(&new_xattr->list, &xattrs->head);
+	simple_xattr_rb_insert(&xattrs->rb_root, new_xattr);
 	spin_unlock(&xattrs->lock);
 }
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 979a9d3e5bfb..bbe81cfb7a4d 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -80,12 +80,12 @@ static inline const char *xattr_prefix(const struct xattr_handler *handler)
 }
 
 struct simple_xattrs {
-	struct list_head head;
+	struct rb_root rb_root;
 	spinlock_t lock;
 };
 
 struct simple_xattr {
-	struct list_head list;
+	struct rb_node node;
 	char *name;
 	size_t size;
 	char value[];
@@ -96,7 +96,7 @@ struct simple_xattr {
  */
 static inline void simple_xattrs_init(struct simple_xattrs *xattrs)
 {
-	INIT_LIST_HEAD(&xattrs->head);
+	xattrs->rb_root = RB_ROOT;
 	spin_lock_init(&xattrs->lock);
 }
 
@@ -105,9 +105,12 @@ static inline void simple_xattrs_init(struct simple_xattrs *xattrs)
  */
 static inline void simple_xattrs_free(struct simple_xattrs *xattrs)
 {
-	struct simple_xattr *xattr, *node;
+	struct simple_xattr *xattr;
+	struct rb_node *node;
 
-	list_for_each_entry_safe(xattr, node, &xattrs->head, list) {
+	while ((node = rb_first(&xattrs->rb_root))) {
+		rb_erase(node, &xattrs->rb_root);
+		xattr = container_of(node, struct simple_xattr, node);
 		kfree(xattr->name);
 		kvfree(xattr);
 	}
-- 
2.34.1

