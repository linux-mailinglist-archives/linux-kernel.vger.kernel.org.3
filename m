Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2E9501704
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356053AbiDNPS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347667AbiDNN70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:59:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFECF4707F;
        Thu, 14 Apr 2022 06:51:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5AE2A21615;
        Thu, 14 Apr 2022 13:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649944261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYu8vIYx3wq/1oLGXfYf1q5L4rYJ/h1RWxYRhBgaOaI=;
        b=nSNFWtCWGsgU2i333wP83WKVbq6mXMux4ySlC/iJnBopR6jAdOGpE3BEV16w3rdyfj6l7x
        HvA5jO54f4V6xcfNtvDZz03xtviqi9ZSvJnZguW9UIX7URb6U4a0KYCToOTI5j7u+EEZ6r
        fMLl5ppXBi/lw4zyMNvcaJJrCnnIoDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649944261;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYu8vIYx3wq/1oLGXfYf1q5L4rYJ/h1RWxYRhBgaOaI=;
        b=s8qiFMJDSx2Kl/uVuz0kHJgJvH6hKF/Zwm9eIrCyDjgDDdy0g444QHix3TiRD+gj6dF8/I
        1U2FPkocLdicipAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA5AB132C0;
        Thu, 14 Apr 2022 13:51:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8EJLNsQmWGJnTgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 14 Apr 2022 13:51:00 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 4d1c80aa;
        Thu, 14 Apr 2022 13:51:24 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v4 4/4] ceph: replace base64url by the encoding used for mailbox names
Date:   Thu, 14 Apr 2022 14:51:22 +0100
Message-Id: <20220414135122.26821-5-lhenriques@suse.de>
In-Reply-To: <20220414135122.26821-1-lhenriques@suse.de>
References: <20220414135122.26821-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The base64url encoding includes the '_' character, which may cause problems
in snapshot names (if the name starts with '_').  Thus, use the base64
encoding defined for IMAP mailbox names (RFC 3501), which uses '+' and ','
instead of '-' and '_'.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/crypto.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++--
 fs/ceph/crypto.h |  3 +++
 fs/ceph/dir.c    |  2 +-
 fs/ceph/inode.c  |  2 +-
 4 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 1fa9dd634a6f..1adf97b00a4f 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -1,4 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * The base64 encode/decode code was copied from fscrypt:
+ * Copyright (C) 2015, Google, Inc.
+ * Copyright (C) 2015, Motorola Mobility
+ * Written by Uday Savagaonkar, 2014.
+ * Modified by Jaegeuk Kim, 2015.
+ */
 #include <linux/ceph/ceph_debug.h>
 #include <linux/xattr.h>
 #include <linux/fscrypt.h>
@@ -8,6 +15,59 @@
 #include "mds_client.h"
 #include "crypto.h"
 
+/*
+ * The base64url encoding used by fscrypt includes the '_' character, which may
+ * cause problems in snapshot names (which can not starts with '_').  Thus, we
+ * used the base64 encoding defined for IMAP mailbox names (RFC 3501) instead,
+ * which replaces '-' and '_' by '+' and ','.
+ */
+static const char base64_table[65] =
+        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
+
+int ceph_base64_encode(const u8 *src, int srclen, char *dst)
+{
+	u32 ac = 0;
+	int bits = 0;
+	int i;
+	char *cp = dst;
+
+	for (i = 0; i < srclen; i++) {
+		ac = (ac << 8) | src[i];
+		bits += 8;
+		do {
+			bits -= 6;
+			*cp++ = base64_table[(ac >> bits) & 0x3f];
+		} while (bits >= 6);
+	}
+	if (bits)
+		*cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
+	return cp - dst;
+}
+
+int ceph_base64_decode(const char *src, int srclen, u8 *dst)
+{
+	u32 ac = 0;
+	int bits = 0;
+	int i;
+	u8 *bp = dst;
+
+	for (i = 0; i < srclen; i++) {
+		const char *p = strchr(base64_table, src[i]);
+
+		if (p == NULL || src[i] == 0)
+			return -1;
+		ac = (ac << 6) | (p - base64_table);
+		bits += 6;
+		if (bits >= 8) {
+			bits -= 8;
+			*bp++ = (u8)(ac >> bits);
+		}
+	}
+	if (ac & ((1 << bits) - 1))
+		return -1;
+	return bp - dst;
+}
+
 static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -261,7 +321,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name, char
 	}
 
 	/* base64 encode the encrypted name */
-	elen = fscrypt_base64url_encode(cryptbuf, len, buf);
+	elen = ceph_base64_encode(cryptbuf, len, buf);
 	dout("base64-encoded ciphertext name = %.*s\n", elen, buf);
 
 	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
@@ -367,7 +427,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 			tname = &_tname;
 		}
 
-		declen = fscrypt_base64url_decode(name, name_len, tname->name);
+		declen = ceph_base64_decode(name, name_len, tname->name);
 		if (declen <= 0) {
 			ret = -EIO;
 			goto out;
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 0e10f934af5c..63fb230fcb41 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -89,6 +89,9 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_fscrypt_auth *fa)
  */
 #define CEPH_NOHASH_NAME_MAX (180 - SHA256_DIGEST_SIZE)
 
+int ceph_base64_encode(const u8 *src, int srclen, char *dst);
+int ceph_base64_decode(const char *src, int srclen, u8 *dst);
+
 void ceph_fscrypt_set_ops(struct super_block *sb);
 
 void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 5ccf6453f02f..f48f1ff20927 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -966,7 +966,7 @@ static int prep_encrypted_symlink_target(struct ceph_mds_request *req, const cha
 		goto out;
 	}
 
-	len = fscrypt_base64url_encode(osd_link.name, osd_link.len, req->r_path2);
+	len = ceph_base64_encode(osd_link.name, osd_link.len, req->r_path2);
 	req->r_path2[len] = '\0';
 out:
 	fscrypt_fname_free_buffer(&osd_link);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 8e97efa2b1a7..1df2eab767ef 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -876,7 +876,7 @@ static int decode_encrypted_symlink(const char *encsym, int enclen, u8 **decsym)
 	if (!sym)
 		return -ENOMEM;
 
-	declen = fscrypt_base64url_decode(encsym, enclen, sym);
+	declen = ceph_base64_decode(encsym, enclen, sym);
 	if (declen < 0) {
 		pr_err("%s: can't decode symlink (%d). Content: %.*s\n",
 		       __func__, declen, enclen, encsym);
