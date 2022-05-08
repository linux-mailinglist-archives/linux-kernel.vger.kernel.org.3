Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F9351EF79
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbiEHTF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238341AbiEHSB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:01:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B8B558C
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 10:57:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n18so11928808plg.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 10:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Yha8YXFmSTCwJOACS5ryysDBCF5HLsNhYhG1Pfc1Jk=;
        b=PuA6skDHu+1odQ73rVsqYOfaFpILwYOxgSXjfUFkinJcZ9JsQCGqrKrbEtl5dWXxD1
         aU1jxDG2wrusCvQgo4AvvwB3tg+I63Jeag/fo8aNvN+XPeXnU/FrYq1GnP/ZJyj54GkA
         7PqFslEW352FBd463fvn6IB3D7qsfHGZ9GFV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Yha8YXFmSTCwJOACS5ryysDBCF5HLsNhYhG1Pfc1Jk=;
        b=N47XwHf5GZcvUhW8gVV0oxFwz2YbtEzgw/RWNsPvkAf4C92QVt1U2P046tOaf1uv/q
         +218mFmN1e/804d9Q+GEZaD/c1lUKH50WeP1HHXeMXjtN9B9RmG6S4CXQgCpySTZz/xO
         OpVdaJGbDY2shX7WcZDAHo/DM7dOw3BOXXfeoQjhH8hYNy2IbYzEf2rh3pgtZwDsGNTY
         4pI66q9+V8cdtPKAd+OgaVg8ZaqCJOFpTDkyCeyYkT7oeYJaPMQVuycR+o73VDhvTqo8
         Du0D9WkY/NGL9wGTdRLkCBtGBYT4leZfIW6h7lDwXl8D9PWU3j0CQWt37294829dgMug
         VSPQ==
X-Gm-Message-State: AOAM530aUPGrdICxTt33ZzWPRcl22Ny2BmkgAqDbvF+kfDW8YXGXCoRI
        U0ZlaKD2kDLFTovk5x4eFEaFtg==
X-Google-Smtp-Source: ABdhPJwFYxH9PXHkN+BXhWFaY5rn4lwyKLHVqKXGtzu72UqPAwEUVVY8R7D4oO3fum0fWvqyLTvQRQ==
X-Received: by 2002:a17:902:768a:b0:159:71e:971e with SMTP id m10-20020a170902768a00b00159071e971emr12764810pll.163.1652032654667;
        Sun, 08 May 2022 10:57:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s13-20020a056a00178d00b0050dc7628139sm7193031pfg.19.2022.05.08.10.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 10:57:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-hardening@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] big_keys: Use struct for internal payload
Date:   Sun,  8 May 2022 10:57:31 -0700
Message-Id: <20220508175732.2693426-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7559; h=from:subject; bh=6yjZF1eeLJcME/kQGtC/QjTDIfuxcqry8vsXZwhINiE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBieASLSW30lM+bd7UdG/gtSXstFwsIeNBUKhUEOq+n Yw4ND3yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYngEiwAKCRCJcvTf3G3AJvrvEA Cg9QzTwJdZQo0zDz63uUNZEEopn69q72fsIrZvaRyJfD3+yA5xRDms/q16p5P5FX8sPzy/dc0tE/RB flTF5etTCALZQr9FDB1vu9uUxy89Ht6d0+gQmlIGiZ+6gNfh2p1eO14fmzGGAObOy0ZRTN7sznqsKv uirIMSYLeCtUKh6IDJZPg2JIshxtRwIHWjCZu4GCItEh20pyaGSFqeh/uD6HaHmgKFbmLzOvqLknvu Rx1kREDqySfrIPmqgALTWQwUZiir6RFwRinvE3lM3ZvHZpHqp+LYb4uQ/ubkTh2FE/IcIggtfnNe2W unuqNSqIhpbJQjEQ/Ay84wzzA/S+FQzl83kEeQ+ebMWjnb6+7ydcRcxtcwDXAhpmNQeGih1O/mGmeq Kab98RDRJTnKvt9oTgTuC2bhHI/PB36emxBl0Na2mwF+OdgjpNUt7kMRmf1vLIUKwlVhh+ZRdbA6QK Mgo6B/8skuig0rnEj5RHl/VNs8XCYcj9jXS7YgoG+FqHXtYNlIykecA0o0XVRvRoqyMa/keGLp8eH3 FYCkJk/T+VZFOlXWxVvYAtDzunDVBJSgU0R4/w+zxejNAre9RgBFA+ERYM7wUl6PhFaCLf0u5YOlxs YYrASekELKgaSOr8g67vEn0Ykpi4FHHM6oW95Yg433DDSeX6fvDP5Mbvti+w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-hardening@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/randomize_layout_plugin.c |  2 -
 security/keys/big_key.c                       | 64 ++++++++++---------
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index c2ec81b68505..727512eebb3b 100644
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
index d17e5f09eeb8..625869939099 100644
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
@@ -148,12 +151,14 @@ int big_key_preparse(struct key_preparsed_payload *prep)
  */
 void big_key_free_preparse(struct key_preparsed_payload *prep)
 {
+	struct big_key_payload *payload = to_big_key_payload(prep->payload);
+
 	if (prep->datalen > BIG_KEY_FILE_THRESHOLD) {
-		struct path *path = (struct path *)&prep->payload.data[big_key_path];
+		struct path *path = &payload->path;
 
 		path_put(path);
 	}
-	kfree_sensitive(prep->payload.data[big_key_data]);
+	kfree_sensitive(payload->data);
 }
 
 /*
@@ -162,13 +167,12 @@ void big_key_free_preparse(struct key_preparsed_payload *prep)
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
@@ -176,17 +180,17 @@ void big_key_revoke(struct key *key)
  */
 void big_key_destroy(struct key *key)
 {
-	size_t datalen = (size_t)key->payload.data[big_key_len];
+	struct big_key_payload *payload = to_big_key_payload(key->payload);
 
-	if (datalen > BIG_KEY_FILE_THRESHOLD) {
-		struct path *path = (struct path *)&key->payload.data[big_key_path];
+	if (payload->length > BIG_KEY_FILE_THRESHOLD) {
+		struct path *path = &payload->path;
 
 		path_put(path);
 		path->mnt = NULL;
 		path->dentry = NULL;
 	}
-	kfree_sensitive(key->payload.data[big_key_data]);
-	key->payload.data[big_key_data] = NULL;
+	kfree_sensitive(payload->data);
+	payload->data = NULL;
 }
 
 /*
@@ -211,14 +215,14 @@ int big_key_update(struct key *key, struct key_preparsed_payload *prep)
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
@@ -227,16 +231,16 @@ void big_key_describe(const struct key *key, struct seq_file *m)
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
 
@@ -244,7 +248,7 @@ long big_key_read(const struct key *key, char *buffer, size_t buflen)
 		if (!buf)
 			return -ENOMEM;
 
-		file = dentry_open(path, O_RDONLY, current_cred());
+		file = dentry_open(&payload->path, O_RDONLY, current_cred());
 		if (IS_ERR(file)) {
 			ret = PTR_ERR(file);
 			goto error;
@@ -274,7 +278,7 @@ long big_key_read(const struct key *key, char *buffer, size_t buflen)
 		kvfree_sensitive(buf, enclen);
 	} else {
 		ret = datalen;
-		memcpy(buffer, key->payload.data[big_key_data], datalen);
+		memcpy(buffer, payload->data, datalen);
 	}
 
 	return ret;
-- 
2.32.0

