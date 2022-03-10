Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306154D5068
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244141AbiCJR1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbiCJR1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:27:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12F024F2B;
        Thu, 10 Mar 2022 09:26:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6917B21106;
        Thu, 10 Mar 2022 17:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646933164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y6x0at21h+/Dg2sUoIZKBbHpKNQLxf2+waXR+AsoGPw=;
        b=vhccKev6ZRzQ3Bgvfasc2rqSaNs1sm1zyzIfHs+Fo2MQYAamafgI7vJQiEpeEItfE07Oig
        IrvhUqFtaynD2CRZZe/oQt+41XKgiW0qaCj02g8HDqeIalaSa6EMACQlCd5RGM9VaczOLC
        untX5kd686Xs0vybRZsb/pU1/7fbScI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646933164;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y6x0at21h+/Dg2sUoIZKBbHpKNQLxf2+waXR+AsoGPw=;
        b=6VxqoXSQlSDT90W9BegMo93XD/NfdkXJxN1LDDRaNd5DVyxysMyiyCdqP0QH4/pvo9gVO7
        ilybb+QKWLLX1JDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00A9C13A66;
        Thu, 10 Mar 2022 17:26:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OJvVOKs0KmI0MQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 10 Mar 2022 17:26:03 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id a4025dcb;
        Thu, 10 Mar 2022 17:26:17 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [RFC PATCH 2/2] ceph: add support for handling encrypted snapshot names in subtree
Date:   Thu, 10 Mar 2022 17:26:16 +0000
Message-Id: <20220310172616.16212-3-lhenriques@suse.de>
In-Reply-To: <20220310172616.16212-1-lhenriques@suse.de>
References: <20220310172616.16212-1-lhenriques@suse.de>
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
 fs/ceph/crypto.c | 146 +++++++++++++++++++++++++++++++++++++++++------
 fs/ceph/crypto.h |   9 ++-
 2 files changed, 134 insertions(+), 21 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 5a87e7385d3f..e315e3650ea7 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -128,15 +128,89 @@ void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_se
 	swap(req->r_fscrypt_auth, as->fscrypt_auth);
 }
 
-int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf)
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
+{
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
+int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *dentry, char *buf)
 {
+	struct inode *dir = parent;
+	struct qstr iname;
+	int name_len = dentry->d_name.len;
 	u32 len;
 	int elen;
 	int ret;
-	u8 *cryptbuf;
+	u8 *cryptbuf = NULL;
 
 	WARN_ON_ONCE(!fscrypt_has_encryption_key(parent));
 
+	iname.name = dentry->d_name.name;
+	iname.len = dentry->d_name.len;
+
+	/* Handle the special case of snapshot names that start with '_' */
+	if ((ceph_snap(dir) == CEPH_SNAPDIR) && (iname.name[0] == '_')) {
+		dir = parse_longname(parent, iname.name, &name_len);
+		if (IS_ERR(dir))
+			return PTR_ERR(dir);
+		iname.name++; /* skip initial '_' */
+		iname.len = name_len;
+	}
+
 	/*
 	 * convert cleartext dentry name to ciphertext
 	 * if result is longer than CEPH_NOKEY_NAME_MAX,
@@ -144,18 +218,22 @@ int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentr
 	 *
 	 * See: fscrypt_setup_filename
 	 */
-	if (!fscrypt_fname_encrypted_size(parent, dentry->d_name.len, NAME_MAX, &len))
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
 
-	ret = fscrypt_fname_encrypt(parent, &dentry->d_name, cryptbuf, len);
+	ret = fscrypt_fname_encrypt(dir, &iname, cryptbuf, len);
 	if (ret) {
-		kfree(cryptbuf);
-		return ret;
+		elen = ret;
+		goto out;
 	}
 
 	/* hash the end if the name is long enough */
@@ -171,8 +249,18 @@ int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentr
 
 	/* base64 encode the encrypted name */
 	elen = fscrypt_base64url_encode(cryptbuf, len, buf);
-	kfree(cryptbuf);
 	dout("base64-encoded ciphertext name = %.*s\n", elen, buf);
+	if ((elen > 0) && (dir != parent)) {
+		char tmp_buf[FSCRYPT_BASE64URL_CHARS(NAME_MAX)];
+
+		elen = sprintf(tmp_buf, "_%.*s_%ld", elen, buf, dir->i_ino);
+		memcpy(buf, tmp_buf, elen);
+	}
+out:
+	kfree(cryptbuf);
+	if (dir != parent)
+		iput(dir);
+
 	return elen;
 }
 
@@ -197,8 +285,11 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 	int ret;
 	struct fscrypt_str _tname = FSTR_INIT(NULL, 0);
 	struct fscrypt_str iname;
+	struct inode *dir = fname->dir;
+	char *name = fname->name;
+	int name_len = fname->name_len;
 
-	if (!IS_ENCRYPTED(fname->dir)) {
+	if (!IS_ENCRYPTED(dir)) {
 		oname->name = fname->name;
 		oname->len = fname->name_len;
 		return 0;
@@ -208,20 +299,29 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 	if (fname->name_len > FSCRYPT_BASE64URL_CHARS(NAME_MAX))
 		return -EIO;
 
-	ret = __fscrypt_prepare_readdir(fname->dir);
+	/* Handle the special case of snapshot names that start with '_' */
+	if ((ceph_snap(dir) == CEPH_SNAPDIR) && (name[0] == '_')) {
+		dir = parse_longname(dir, name, &name_len);
+		if (IS_ERR(dir))
+			return PTR_ERR(dir);
+		name++; /* skip '_' */
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
 		memcpy(oname->name, fname->name, fname->name_len);
 		oname->len = fname->name_len;
 		if (is_nokey)
 			*is_nokey = true;
-		return 0;
+		ret = 0;
+		goto out_inode;
 	}
 
 	if (fname->ctext_len == 0) {
@@ -230,11 +330,11 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
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
@@ -246,9 +346,19 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 		iname.len = fname->ctext_len;
 	}
 
-	ret = fscrypt_fname_disk_to_usr(fname->dir, 0, 0, &iname, oname);
+	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
+	if (!ret && (dir != fname->dir)) {
+		name_len = snprintf(tname->name, tname->len, "_%.*s_%ld",
+				    oname->len, oname->name,
+				    dir->i_ino);
+		memcpy(oname->name, tname->name, name_len);
+		oname->len = name_len;
+	}
 out:
 	fscrypt_fname_free_buffer(&_tname);
+out_inode:
+	if ((dir != fname->dir) && !IS_ERR(dir))
+		iput(dir);
 	return ret;
 }
 
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 1e08f8a64ad6..189af2404165 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -75,13 +75,16 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_fscrypt_auth *fa)
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
 
@@ -90,7 +93,7 @@ void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
 int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
 				 struct ceph_acl_sec_ctx *as);
 void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as);
-int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf);
+int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *dentry, char *buf);
 
 static inline int ceph_fname_alloc_buffer(struct inode *parent, struct fscrypt_str *fname)
 {
