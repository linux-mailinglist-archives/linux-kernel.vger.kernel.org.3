Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750E2522804
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 01:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbiEJX72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 19:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239399AbiEJX7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 19:59:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74720224402
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 16:58:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so531634pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 16:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MVicVoJ+TrALEU2dXbajOs+0toQ+N0zOTIwRHd372VE=;
        b=elygfoJ6jdCUKIGkaFpXhWKX1lUIZ6HXBUgpvizKy5HetuXChlKNoMfqbcqTh5XASK
         +1305w7e4+xyXP64/tFrLvaW23wyfPErAvuV7B5MTyskiRV0Xpd1uLJzmj1zjlJRdjj9
         YGYJaQss5QRJcIomyVJPMq4LVqOMB2vDXq4tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MVicVoJ+TrALEU2dXbajOs+0toQ+N0zOTIwRHd372VE=;
        b=QnjVKTIFHB21ZAl5mm4jwPv2Y0cPO9vVrgRyER0dWYLmGmLet/1rl6TEObii+8kkGv
         r9Cceq/V8WbOOx24RkO2Bm/zTlxLssy9Ybel86+SF1CFYPIyKsI6Y7XcKuwB82/rQHOn
         +cwmsEWhXh1lsXi7wjw9iWr4SK8GINZ3fsjWdqt5jGI6N1N0fb7nZ/1bpeuLKgO1yl3w
         MXPgaeKwb0ZFO0pT9EIhztwkKpWQhOfCnxUaFxGFPj7hxWkB6CZNn8vlo974dcGJhvfa
         y/B92GNg8KV1w0VnsMoGOhi+9Lbq/f1sntADRYSwpfMjvllvvQDUWbirq5yrSNfck3nX
         R+NA==
X-Gm-Message-State: AOAM533lyurGNBpdjCbusllXd+EY4OWn2RbxgvBi6yPR1LYl0h/FzHtB
        8rmp1SKEWJekNHdjYuwmMLEUXA==
X-Google-Smtp-Source: ABdhPJy/IkDWHwXIujDP698RYnO/J68k5WqJwyrvvUbZ1MZJtuS+SdODMwvT+8v5fy67ad4j762C+g==
X-Received: by 2002:a17:90a:7645:b0:1dd:2482:e4b3 with SMTP id s5-20020a17090a764500b001dd2482e4b3mr2324604pjl.204.1652227106927;
        Tue, 10 May 2022 16:58:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b11-20020a170903228b00b0015eaa9797e8sm193186plh.172.2022.05.10.16.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 16:58:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-hardening@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] big_keys: Use struct for internal payload
Date:   Tue, 10 May 2022 16:58:17 -0700
Message-Id: <20220510235817.3627784-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7729; h=from:subject; bh=c98cT0wFABSs1ubFVptJpzmYSiaWgubsH31Bhn/VSsk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBievwYyfrJEiabIkxaAe4GlYzMSukYR3j833rJK6yS 0vpWRaSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYnr8GAAKCRCJcvTf3G3AJj6rD/ sH9pngx8uqZGZAIkhCKZ1oYdiRN/w5vub6ZWNer+ao/PFNTQlDvAUQ/wwD+xov1BK73KYrDVOF2MKv olHAOsqIc66bPPrXaotH4ztQ1YLA+0Iqe3eFElniqMBVK7pzmvU0jllQTb5RfxbCl9V9y+iGUXjbVk i5bKu1pSOEWrn9scyHjiVaBH35KKLgv3MedjkNzYzMHvIAKQ5EvO0+8kZ1FEOIvYAypZntZoXog6jR WejfW2HhA3HoGc7tlAtSdgilJNYMMwgE+hU1AvI5H5erySu45fOFIHMVEoSQlWzj4dnFWVZMZ7znai vknf3IYBsNKHHVdmppmbf9zNtv6Ovmp/ifZEpHT9g3lxcJXxz3SCpLLnCe3T8ejG7ls/ZC2ant0iH/ 6lawRNIj09BUs2MRC+B5jzMXZvF8Gs68lK8uTmXRoeqPzFoO37UxgSLWGKikLkpnXG4jtvG62jcekE 3NmJsiGnFexhjcmBxe07Xa9W0ztZoj+vtI7Es4IpeDZnhR4e9UEhx8MTQRXwIStk1qytyHPOYUgQI0 Duy2q7HdnazsXjJ7OVVCaM3YXghNg8d29rVA7nGHIWZaaeizNhGkuf0D1aGEnc7+k5/9g7GcANoP/m L3gZYdtQRzAqWVygPWTM/Z9TiPAwlHYt53n+WsDMtsxy9eJVUZHSHb/2T4Gw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The randstruct GCC plugin gets upset when it sees struct path (which is
randomized) being assigned from a "void *" (which it cannot type-check).

There's no need for these casts, as the entire internal payload use is
following a normal struct layout. Convert the enum-based void * offset
dereferencing to the new big_key_payload struct. No meaningful machine
code changes result after this change, and source readability is improved.

Drop the randstruct exception now that there is no "confusing" cross-type
assignment.

Cc: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-hardening@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/randomize_layout_plugin.c |  2 -
 security/keys/big_key.c                       | 73 +++++++++----------
 2 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 19214e573137..5836a7fc7532 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -50,8 +50,6 @@ static const struct whitelist_entry whitelist[] = {
 	{ "drivers/net/ethernet/sun/niu.c", "page", "address_space" },
 	/* unix_skb_parms via UNIXCB() buffer */
 	{ "net/unix/af_unix.c", "unix_skb_parms", "char" },
-	/* big_key payload.data struct splashing */
-	{ "security/keys/big_key.c", "path", "void *" },
 	{ }
 };
 
diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index d17e5f09eeb8..c3367622c683 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -20,12 +20,13 @@
 /*
  * Layout of key payload words.
  */
-enum {
-	big_key_data,
-	big_key_path,
-	big_key_path_2nd_part,
-	big_key_len,
+struct big_key_payload {
+	u8 *data;
+	struct path path;
+	size_t length;
 };
+#define to_big_key_payload(payload)			\
+	(struct big_key_payload *)((payload).data)
 
 /*
  * If the data is under this limit, there's no point creating a shm file to
@@ -55,7 +56,7 @@ struct key_type key_type_big_key = {
  */
 int big_key_preparse(struct key_preparsed_payload *prep)
 {
-	struct path *path = (struct path *)&prep->payload.data[big_key_path];
+	struct big_key_payload *payload = to_big_key_payload(prep->payload);
 	struct file *file;
 	u8 *buf, *enckey;
 	ssize_t written;
@@ -63,13 +64,15 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 	size_t enclen = datalen + CHACHA20POLY1305_AUTHTAG_SIZE;
 	int ret;
 
+	BUILD_BUG_ON(sizeof(*payload) != sizeof(prep->payload.data));
+
 	if (datalen <= 0 || datalen > 1024 * 1024 || !prep->data)
 		return -EINVAL;
 
 	/* Set an arbitrary quota */
 	prep->quotalen = 16;
 
-	prep->payload.data[big_key_len] = (void *)(unsigned long)datalen;
+	payload->length = datalen;
 
 	if (datalen > BIG_KEY_FILE_THRESHOLD) {
 		/* Create a shmem file to store the data in.  This will permit the data
@@ -117,9 +120,9 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 		/* Pin the mount and dentry to the key so that we can open it again
 		 * later
 		 */
-		prep->payload.data[big_key_data] = enckey;
-		*path = file->f_path;
-		path_get(path);
+		payload->data = enckey;
+		payload->path = file->f_path;
+		path_get(&payload->path);
 		fput(file);
 		kvfree_sensitive(buf, enclen);
 	} else {
@@ -129,7 +132,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 		if (!data)
 			return -ENOMEM;
 
-		prep->payload.data[big_key_data] = data;
+		payload->data = data;
 		memcpy(data, prep->data, prep->datalen);
 	}
 	return 0;
@@ -148,12 +151,11 @@ int big_key_preparse(struct key_preparsed_payload *prep)
  */
 void big_key_free_preparse(struct key_preparsed_payload *prep)
 {
-	if (prep->datalen > BIG_KEY_FILE_THRESHOLD) {
-		struct path *path = (struct path *)&prep->payload.data[big_key_path];
+	struct big_key_payload *payload = to_big_key_payload(prep->payload);
 
-		path_put(path);
-	}
-	kfree_sensitive(prep->payload.data[big_key_data]);
+	if (prep->datalen > BIG_KEY_FILE_THRESHOLD)
+		path_put(&payload->path);
+	kfree_sensitive(payload->data);
 }
 
 /*
@@ -162,13 +164,12 @@ void big_key_free_preparse(struct key_preparsed_payload *prep)
  */
 void big_key_revoke(struct key *key)
 {
-	struct path *path = (struct path *)&key->payload.data[big_key_path];
+	struct big_key_payload *payload = to_big_key_payload(key->payload);
 
 	/* clear the quota */
 	key_payload_reserve(key, 0);
-	if (key_is_positive(key) &&
-	    (size_t)key->payload.data[big_key_len] > BIG_KEY_FILE_THRESHOLD)
-		vfs_truncate(path, 0);
+	if (key_is_positive(key) && payload->length > BIG_KEY_FILE_THRESHOLD)
+		vfs_truncate(&payload->path, 0);
 }
 
 /*
@@ -176,17 +177,15 @@ void big_key_revoke(struct key *key)
  */
 void big_key_destroy(struct key *key)
 {
-	size_t datalen = (size_t)key->payload.data[big_key_len];
-
-	if (datalen > BIG_KEY_FILE_THRESHOLD) {
-		struct path *path = (struct path *)&key->payload.data[big_key_path];
+	struct big_key_payload *payload = to_big_key_payload(key->payload);
 
-		path_put(path);
-		path->mnt = NULL;
-		path->dentry = NULL;
+	if (payload->length > BIG_KEY_FILE_THRESHOLD) {
+		path_put(&payload->path);
+		payload->path.mnt = NULL;
+		payload->path.dentry = NULL;
 	}
-	kfree_sensitive(key->payload.data[big_key_data]);
-	key->payload.data[big_key_data] = NULL;
+	kfree_sensitive(payload->data);
+	payload->data = NULL;
 }
 
 /*
@@ -211,14 +210,14 @@ int big_key_update(struct key *key, struct key_preparsed_payload *prep)
  */
 void big_key_describe(const struct key *key, struct seq_file *m)
 {
-	size_t datalen = (size_t)key->payload.data[big_key_len];
+	struct big_key_payload *payload = to_big_key_payload(key->payload);
 
 	seq_puts(m, key->description);
 
 	if (key_is_positive(key))
 		seq_printf(m, ": %zu [%s]",
-			   datalen,
-			   datalen > BIG_KEY_FILE_THRESHOLD ? "file" : "buff");
+			   payload->length,
+			   payload->length > BIG_KEY_FILE_THRESHOLD ? "file" : "buff");
 }
 
 /*
@@ -227,16 +226,16 @@ void big_key_describe(const struct key *key, struct seq_file *m)
  */
 long big_key_read(const struct key *key, char *buffer, size_t buflen)
 {
-	size_t datalen = (size_t)key->payload.data[big_key_len];
+	struct big_key_payload *payload = to_big_key_payload(key->payload);
+	size_t datalen = payload->length;
 	long ret;
 
 	if (!buffer || buflen < datalen)
 		return datalen;
 
 	if (datalen > BIG_KEY_FILE_THRESHOLD) {
-		struct path *path = (struct path *)&key->payload.data[big_key_path];
 		struct file *file;
-		u8 *buf, *enckey = (u8 *)key->payload.data[big_key_data];
+		u8 *buf, *enckey = payload->data;
 		size_t enclen = datalen + CHACHA20POLY1305_AUTHTAG_SIZE;
 		loff_t pos = 0;
 
@@ -244,7 +243,7 @@ long big_key_read(const struct key *key, char *buffer, size_t buflen)
 		if (!buf)
 			return -ENOMEM;
 
-		file = dentry_open(path, O_RDONLY, current_cred());
+		file = dentry_open(&payload->path, O_RDONLY, current_cred());
 		if (IS_ERR(file)) {
 			ret = PTR_ERR(file);
 			goto error;
@@ -274,7 +273,7 @@ long big_key_read(const struct key *key, char *buffer, size_t buflen)
 		kvfree_sensitive(buf, enclen);
 	} else {
 		ret = datalen;
-		memcpy(buffer, key->payload.data[big_key_data], datalen);
+		memcpy(buffer, payload->data, datalen);
 	}
 
 	return ret;
-- 
2.32.0

