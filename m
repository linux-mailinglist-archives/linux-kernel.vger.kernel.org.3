Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD41B5731AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiGMI5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbiGMI44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A8FFBE0E5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657702615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UJpfFalp5kAlQVV58/bIcpvpU+XYL1+EPm66BGoWFEA=;
        b=eg0sF9HYKypNSP6YI+gPCfwboLo3t48V9bLoA39D3NG1pyL7Featk24z5ib7ztjUkjS1Ju
        gNkkeIFa32zTy7ZqekBUuvk1iZ67xX4GfGklmpUH0P9C9a2H8XTBx65m71BxHxSTwaF63j
        1cmVOlUgemXKCwapYK0RZagqUiLqp4M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-QegPMPW2OkODWiNGYGklpQ-1; Wed, 13 Jul 2022 04:56:52 -0400
X-MC-Unique: QegPMPW2OkODWiNGYGklpQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C98818A64EA;
        Wed, 13 Jul 2022 08:56:51 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCAF42166B26;
        Wed, 13 Jul 2022 08:56:48 +0000 (UTC)
From:   xiubli@redhat.com
To:     ceph-devel@vger.kernel.org, idryomov@gmail.com, jlayton@kernel.org
Cc:     vshankar@redhat.com, linux-kernel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] ceph: fix up test_dummy_encryption handling for new mount API
Date:   Wed, 13 Jul 2022 16:56:41 +0800
Message-Id: <20220713085641.50232-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

From Eric the "fscrypt_set_test_dummy_encryption()" will be removed
in the next circle. Switch it to new APIs.

Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/crypto.c |  4 +--
 fs/ceph/super.c  | 94 ++++++++++++++++++++++++------------------------
 fs/ceph/super.h  |  5 ++-
 3 files changed, 52 insertions(+), 51 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 7e0c48e12554..5b807f8f4c69 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -127,7 +127,7 @@ static bool ceph_crypt_empty_dir(struct inode *inode)
 
 static const union fscrypt_policy *ceph_get_dummy_policy(struct super_block *sb)
 {
-	return ceph_sb_to_client(sb)->dummy_enc_policy.policy;
+	return ceph_sb_to_client(sb)->fsc_dummy_enc_policy.policy;
 }
 
 static struct fscrypt_operations ceph_fscrypt_ops = {
@@ -144,7 +144,7 @@ void ceph_fscrypt_set_ops(struct super_block *sb)
 
 void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc)
 {
-	fscrypt_free_dummy_policy(&fsc->dummy_enc_policy);
+	fscrypt_free_dummy_policy(&fsc->fsc_dummy_enc_policy);
 }
 
 int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index fa59a804b32c..4ac4a90755a2 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -591,10 +591,16 @@ static int ceph_parse_mount_param(struct fs_context *fc,
 		break;
 	case Opt_test_dummy_encryption:
 #ifdef CONFIG_FS_ENCRYPTION
-		kfree(fsopt->test_dummy_encryption);
-		fsopt->test_dummy_encryption = param->string;
-		param->string = NULL;
-		fsopt->flags |= CEPH_MOUNT_OPT_TEST_DUMMY_ENC;
+		fscrypt_free_dummy_policy(&fsopt->dummy_enc_policy);
+		ret = fscrypt_parse_test_dummy_encryption(param,
+						&fsopt->dummy_enc_policy);
+		if (ret == -EINVAL) {
+			warnfc(fc, "Value of option \"%s\" is unrecognized",
+			       param->key);
+		} else if (ret == -EEXIST) {
+			warnfc(fc, "Conflicting test_dummy_encryption options");
+			ret = -EINVAL;
+		}
 #else
 		warnfc(fc,
 		       "FS encryption not supported: test_dummy_encryption mount option ignored");
@@ -620,7 +626,7 @@ static void destroy_mount_options(struct ceph_mount_options *args)
 	kfree(args->server_path);
 	kfree(args->fscache_uniq);
 	kfree(args->mon_addr);
-	kfree(args->test_dummy_encryption);
+	fscrypt_free_dummy_policy(&args->dummy_enc_policy);
 	kfree(args);
 }
 
@@ -1080,51 +1086,47 @@ static struct dentry *open_root_dentry(struct ceph_fs_client *fsc,
 	return root;
 }
 
-#ifdef CONFIG_FS_ENCRYPTION
-static int ceph_set_test_dummy_encryption(struct super_block *sb, struct fs_context *fc,
-						struct ceph_mount_options *fsopt)
+static int ceph_apply_test_dummy_encryption(struct super_block *sb,
+					    struct fs_context *fc,
+					    struct ceph_mount_options *fsopt)
 {
-	/*
-	 * No changing encryption context on remount. Note that
-	 * fscrypt_set_test_dummy_encryption will validate the version
-	 * string passed in (if any).
-	 */
-	if (fsopt->flags & CEPH_MOUNT_OPT_TEST_DUMMY_ENC) {
-		struct ceph_fs_client *fsc = sb->s_fs_info;
-		int err = 0;
+	struct ceph_fs_client *fsc = sb->s_fs_info;
+	int err;
 
-		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE && !fsc->dummy_enc_policy.policy) {
-			errorfc(fc, "Can't set test_dummy_encryption on remount");
-			return -EEXIST;
-		}
+	if (!fscrypt_is_dummy_policy_set(&fsopt->dummy_enc_policy))
+		return 0;
 
-		err = fscrypt_set_test_dummy_encryption(sb,
-							fsc->mount_options->test_dummy_encryption,
-							&fsc->dummy_enc_policy);
-		if (err) {
-			if (err == -EEXIST)
-				errorfc(fc, "Can't change test_dummy_encryption on remount");
-			else if (err == -EINVAL)
-				errorfc(fc, "Value of option \"%s\" is unrecognized",
-					fsc->mount_options->test_dummy_encryption);
-			else
-				errorfc(fc, "Error processing option \"%s\" [%d]",
-					fsc->mount_options->test_dummy_encryption, err);
-			return err;
-		}
-		warnfc(fc, "test_dummy_encryption mode enabled");
+	/* No changing encryption context on remount. */
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE &&
+	    !fscrypt_is_dummy_policy_set(&fsc->fsc_dummy_enc_policy)) {
+		if (fscrypt_dummy_policies_equal(&fsopt->dummy_enc_policy,
+						 &fsc->fsc_dummy_enc_policy))
+			return 0;
+		errorfc(fc, "Can't set test_dummy_encryption on remount");
+		return -EINVAL;
 	}
+
+	/* Also make sure fsopt doesn't contain a conflicting value. */
+	if (fscrypt_is_dummy_policy_set(&fsc->fsc_dummy_enc_policy)) {
+		if (fscrypt_dummy_policies_equal(&fsopt->dummy_enc_policy,
+						 &fsc->fsc_dummy_enc_policy))
+			return 0;
+		errorfc(fc, "Conflicting test_dummy_encryption options");
+		return -EINVAL;
+	}
+
+	fsc->fsc_dummy_enc_policy = fsopt->dummy_enc_policy;
+	memset(&fsopt->dummy_enc_policy, 0, sizeof(fsopt->dummy_enc_policy));
+
+	err = fscrypt_add_test_dummy_key(sb, &fsc->fsc_dummy_enc_policy);
+	if (err) {
+		errorfc(fc, "Error adding test dummy encryption key, %d", err);
+		return err;
+	}
+
+	warnfc(fc, "test_dummy_encryption mode enabled");
 	return 0;
 }
-#else
-static inline int ceph_set_test_dummy_encryption(struct super_block *sb, struct fs_context *fc,
-						struct ceph_mount_options *fsopt)
-{
-	if (fsopt->flags & CEPH_MOUNT_OPT_TEST_DUMMY_ENC)
-		warnfc(fc, "test_dummy_encryption mode ignored");
-	return 0;
-}
-#endif
 
 /*
  * mount: join the ceph cluster, and open root directory.
@@ -1154,7 +1156,7 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
 				goto out;
 		}
 
-		err = ceph_set_test_dummy_encryption(fsc->sb, fc, fsc->mount_options);
+		err = ceph_apply_test_dummy_encryption(fsc->sb, fc, fsc->mount_options);
 		if (err)
 			goto out;
 
@@ -1373,7 +1375,7 @@ static int ceph_reconfigure_fc(struct fs_context *fc)
 	struct super_block *sb = fc->root->d_sb;
 	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
 
-	err = ceph_set_test_dummy_encryption(sb, fc, fsopt);
+	err = ceph_apply_test_dummy_encryption(sb, fc, fsopt);
 	if (err)
 		return err;
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index bfc8bfcea799..5ea0ac6450dd 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -44,7 +44,6 @@
 #define CEPH_MOUNT_OPT_ASYNC_DIROPS    (1<<15) /* allow async directory ops */
 #define CEPH_MOUNT_OPT_NOPAGECACHE     (1<<16) /* bypass pagecache altogether */
 #define CEPH_MOUNT_OPT_SPARSEREAD      (1<<17) /* always do sparse reads */
-#define CEPH_MOUNT_OPT_TEST_DUMMY_ENC  (1<<18) /* enable dummy encryption (for testing) */
 
 #define CEPH_MOUNT_OPT_DEFAULT			\
 	(CEPH_MOUNT_OPT_DCACHE |		\
@@ -101,7 +100,7 @@ struct ceph_mount_options {
 	char *server_path;    /* default NULL (means "/") */
 	char *fscache_uniq;   /* default NULL */
 	char *mon_addr;
-	char *test_dummy_encryption;	/* default NULL */
+	struct fscrypt_dummy_policy dummy_enc_policy;
 };
 
 #define CEPH_ASYNC_CREATE_CONFLICT_BITS 8
@@ -148,7 +147,7 @@ struct ceph_fs_client {
 	struct fscache_volume *fscache;
 #endif
 #ifdef CONFIG_FS_ENCRYPTION
-	struct fscrypt_dummy_policy dummy_enc_policy;
+	struct fscrypt_dummy_policy fsc_dummy_enc_policy;
 #endif
 };
 
-- 
2.36.0.rc1

