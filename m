Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689784D9FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350024AbiCOQVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349990AbiCOQU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:20:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD5C1CFDF;
        Tue, 15 Mar 2022 09:19:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D667A21902;
        Tue, 15 Mar 2022 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647361184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tACsPoKaAuDlM9T70UUmifqByODe7nAYiHju8sF0WHw=;
        b=iqeYWx7kDO0UgDEYgjc6ffhjzzqms4N67DA8b4otRZQZdW1TU8B2qEXFBI5solmZTO7Ymo
        f5bzkznK2y1TWoTBpwfXwImdLIHxAExuwIirsWBj/L92Kqi3zQ5Q+Yz9TsZj77ro6K4lsI
        FN0XuB+0PTehB4vHizxJf7sCd/LKT1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647361184;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tACsPoKaAuDlM9T70UUmifqByODe7nAYiHju8sF0WHw=;
        b=ONIRZqq79yLesrvUS38M+MJUpBbG2267LrM8tgeqPqilqpt627V0+vVkE4rmtT/DzcvkMC
        O1IybZQe9tRG+SBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A5E213B4E;
        Tue, 15 Mar 2022 16:19:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oK8CF6C8MGIKPQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 15 Mar 2022 16:19:44 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 707ed306;
        Tue, 15 Mar 2022 16:20:01 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [RFC PATCH v2 2/3] ceph: add support for handling encrypted snapshot names
Date:   Tue, 15 Mar 2022 16:19:58 +0000
Message-Id: <20220315161959.19453-3-lhenriques@suse.de>
In-Reply-To: <20220315161959.19453-1-lhenriques@suse.de>
References: <20220315161959.19453-1-lhenriques@suse.de>
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

When creating a snapshot, the .snap directories for every subdirectory will
show the snapshot name in the "long format":

  # mkdir .snap/my-snap
  # ls my-dir/.snap/
  _my-snap_1099511627782

Encrypted snapshots will need to be able to handle these snapshot names by
encrypting/decrypting only the snapshot part of the string ('my-snap').

Also, since the MDS prevents snapshot names to be bigger than 240 characters
it is necessary to adapt CEPH_NOHASH_NAME_MAX to accommodate this extra
limitation.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/crypto.c | 158 +++++++++++++++++++++++++++++++++++++++++------
 fs/ceph/crypto.h |  11 ++--
 2 files changed, 145 insertions(+), 24 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index c125a79019b3..06a4b918201c 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -128,18 +128,95 @@ void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_se
 	swap(req->r_fscrypt_auth, as->fscrypt_auth);
 }
 
-int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr *d_name, char *buf)
+/*
+ * User-created snapshots can't start with '_'.  Snapshots that start with this
+ * character are special (hint: there aren't real snapshots) and use the
+ * following format:
+ *
+ *   _<SNAPSHOT-NAME>_<INODE-NUMBER>
+ *
+ * where:
+ *  - <SNAPSHOT-NAME> - the real snapshot name that may need to be decrypted,
+ *  - <INODE-NUMBER> - the inode number for the actual snapshot
+ *
+ * This function parses these snapshot names and returns the inode
+ * <INODE-NUMBER>.  'name_len' will also bet set with the <SNAPSHOT-NAME>
+ * length.
+ */
+static struct inode *parse_longname(const struct inode *parent, const char *name,
+				    int *name_len)
 {
+	struct inode *dir = NULL;
+	struct ceph_vino vino = { .snap = CEPH_NOSNAP };
+	char *inode_number;
+	char *name_end;
+	int orig_len = *name_len;
+	int ret = -EIO;
+
+	/* Skip initial '_' */
+	name++;
+	name_end = strrchr(name, '_');
+	if (!name_end) {
+		dout("Failed to parse long snapshot name: %s\n", name);
+		return ERR_PTR(-EIO);
+	}
+	*name_len = (name_end - name);
+	if (*name_len <= 0) {
+		pr_err("Failed to parse long snapshot name\n");
+		return ERR_PTR(-EIO);
+	}
+
+	/* Get the inode number */
+	inode_number = kmemdup_nul(name_end + 1,
+				   orig_len - *name_len - 2,
+				   GFP_KERNEL);
+	if (!inode_number)
+		return ERR_PTR(-ENOMEM);
+	ret = kstrtou64(inode_number, 0, &vino.ino);
+	if (ret) {
+		dout("Failed to parse inode number: %s\n", name);
+		dir = ERR_PTR(ret);
+		goto out;
+	}
+
+	/* And finally the inode */
+	dir = ceph_get_inode(parent->i_sb, vino, NULL);
+	if (IS_ERR(dir))
+		dout("Can't find inode %s (%s)\n", inode_number, name);
+
+out:
+	kfree(inode_number);
+	return dir;
+}
+
+int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name, char *buf)
+{
+	struct inode *dir = parent;
+	struct qstr iname;
 	u32 len;
+	int name_len;
 	int elen;
 	int ret;
-	u8 *cryptbuf;
+	u8 *cryptbuf = NULL;
 
 	if (!fscrypt_has_encryption_key(parent)) {
 		memcpy(buf, d_name->name, d_name->len);
 		return d_name->len;
 	}
 
+	iname.name = d_name->name;
+	name_len = d_name->len;
+
+	/* Handle the special case of snapshot names that start with '_' */
+	if ((ceph_snap(dir) == CEPH_SNAPDIR) && (name_len > 0) &&
+	    (iname.name[0] == '_')) {
+		dir = parse_longname(parent, iname.name, &name_len);
+		if (IS_ERR(dir))
+			return PTR_ERR(dir);
+		iname.name++; /* skip initial '_' */
+	}
+	iname.len = name_len;
+
 	/*
 	 * convert cleartext d_name to ciphertext
 	 * if result is longer than CEPH_NOKEY_NAME_MAX,
@@ -147,18 +224,22 @@ int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr *d_name,
 	 *
 	 * See: fscrypt_setup_filename
 	 */
-	if (!fscrypt_fname_encrypted_size(parent, d_name->len, NAME_MAX, &len))
-		return -ENAMETOOLONG;
+	if (!fscrypt_fname_encrypted_size(dir, iname.len, NAME_MAX, &len)) {
+		elen = -ENAMETOOLONG;
+		goto out;
+	}
 
 	/* Allocate a buffer appropriate to hold the result */
 	cryptbuf = kmalloc(len > CEPH_NOHASH_NAME_MAX ? NAME_MAX : len, GFP_KERNEL);
-	if (!cryptbuf)
-		return -ENOMEM;
+	if (!cryptbuf) {
+		elen = -ENOMEM;
+		goto out;
+	}
 
-	ret = fscrypt_fname_encrypt(parent, d_name, cryptbuf, len);
+	ret = fscrypt_fname_encrypt(dir, &iname, cryptbuf, len);
 	if (ret) {
-		kfree(cryptbuf);
-		return ret;
+		elen = ret;
+		goto out;
 	}
 
 	/* hash the end if the name is long enough */
@@ -174,12 +255,24 @@ int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr *d_name,
 
 	/* base64 encode the encrypted name */
 	elen = fscrypt_base64url_encode(cryptbuf, len, buf);
-	kfree(cryptbuf);
 	dout("base64-encoded ciphertext name = %.*s\n", elen, buf);
+
+	if ((elen > 0) && (dir != parent)) {
+		char tmp_buf[FSCRYPT_BASE64URL_CHARS(NAME_MAX)];
+
+		elen = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
+				elen, buf, dir->i_ino);
+		memcpy(buf, tmp_buf, elen);
+	}
+
+out:
+	kfree(cryptbuf);
+	if (dir != parent)
+		iput(dir);
 	return elen;
 }
 
-int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf)
+int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *dentry, char *buf)
 {
 	WARN_ON_ONCE(!fscrypt_has_encryption_key(parent));
 
@@ -204,11 +297,14 @@ int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentr
 int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 		      struct fscrypt_str *oname, bool *is_nokey)
 {
-	int ret;
+	struct inode *dir = fname->dir;
 	struct fscrypt_str _tname = FSTR_INIT(NULL, 0);
 	struct fscrypt_str iname;
+	char *name = fname->name;
+	int name_len = fname->name_len;
+	int ret;
 
-	if (!IS_ENCRYPTED(fname->dir)) {
+	if (!IS_ENCRYPTED(dir)) {
 		oname->name = fname->name;
 		oname->len = fname->name_len;
 		return 0;
@@ -218,15 +314,24 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 	if (fname->name_len > NAME_MAX || fname->ctext_len > NAME_MAX)
 		return -EIO;
 
-	ret = __fscrypt_prepare_readdir(fname->dir);
+	/* Handle the special case of snapshot names that start with '_' */
+	if ((ceph_snap(dir) == CEPH_SNAPDIR) && (name_len > 0) &&
+	    (name[0] == '_')) {
+		dir = parse_longname(dir, name, &name_len);
+		if (IS_ERR(dir))
+			return PTR_ERR(dir);
+		name++; /* skip initial '_' */
+	}
+
+	ret = __fscrypt_prepare_readdir(dir);
 	if (ret)
-		return ret;
+		goto out_inode;
 
 	/*
 	 * Use the raw dentry name as sent by the MDS instead of
 	 * generating a nokey name via fscrypt.
 	 */
-	if (!fscrypt_has_encryption_key(fname->dir)) {
+	if (!fscrypt_has_encryption_key(dir)) {
 		if (fname->no_copy)
 			oname->name = fname->name;
 		else
@@ -234,7 +339,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 		oname->len = fname->name_len;
 		if (is_nokey)
 			*is_nokey = true;
-		return 0;
+		ret = 0;
+		goto out_inode;
 	}
 
 	if (fname->ctext_len == 0) {
@@ -243,11 +349,11 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 		if (!tname) {
 			ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
 			if (ret)
-				return ret;
+				goto out_inode;
 			tname = &_tname;
 		}
 
-		declen = fscrypt_base64url_decode(fname->name, fname->name_len, tname->name);
+		declen = fscrypt_base64url_decode(name, name_len, tname->name);
 		if (declen <= 0) {
 			ret = -EIO;
 			goto out;
@@ -259,9 +365,21 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 		iname.len = fname->ctext_len;
 	}
 
-	ret = fscrypt_fname_disk_to_usr(fname->dir, 0, 0, &iname, oname);
+	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
+	if (!ret && (dir != fname->dir)) {
+		char tmp_buf[FSCRYPT_BASE64URL_CHARS(NAME_MAX)];
+
+		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
+				    oname->len, oname->name, dir->i_ino);
+		memcpy(oname->name, tmp_buf, name_len);
+		oname->len = name_len;
+	}
+
 out:
 	fscrypt_fname_free_buffer(&_tname);
+out_inode:
+	if ((dir != fname->dir) && !IS_ERR(dir))
+		iput(dir);
 	return ret;
 }
 
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 185fb4799a6d..e38a842e02a6 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -76,13 +76,16 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_fscrypt_auth *fa)
  * smaller size. If the ciphertext name is longer than the value below, then
  * sha256 hash the remaining bytes.
  *
- * 189 bytes => 252 bytes base64-encoded, which is <= NAME_MAX (255)
+ * 180 bytes => 240 bytes base64-encoded, which is <= NAME_MAX (255)
+ *
+ * (Note: 240 bytes is the maximum size allowed for snapshot names to take into
+ *  account the format: '_<SNAPSHOT-NAME>_<INODE-NUMBER>')
  *
  * Note that for long names that end up having their tail portion hashed, we
  * must also store the full encrypted name (in the dentry's alternate_name
  * field).
  */
-#define CEPH_NOHASH_NAME_MAX (189 - SHA256_DIGEST_SIZE)
+#define CEPH_NOHASH_NAME_MAX (180 - SHA256_DIGEST_SIZE)
 
 void ceph_fscrypt_set_ops(struct super_block *sb);
 
@@ -91,8 +94,8 @@ void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
 int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
 				 struct ceph_acl_sec_ctx *as);
 void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as);
-int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr *d_name, char *buf);
-int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf);
+int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name, char *buf);
+int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *dentry, char *buf);
 
 static inline int ceph_fname_alloc_buffer(struct inode *parent, struct fscrypt_str *fname)
 {
