Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6095D57347B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiGMKml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiGMKmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:42:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45F9FD538;
        Wed, 13 Jul 2022 03:42:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F0AAB81D83;
        Wed, 13 Jul 2022 10:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4116DC34114;
        Wed, 13 Jul 2022 10:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657708953;
        bh=KBP8Zkt8OsKR5l/DpkcGqVsbbFUbQupeujsVYF7Cf+w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lmeTFJMrJ07VP06v9uVDlz9ZCEMLR6q2Fll1kZbm0ossVjURH02UJ35PLSMQsXruy
         1b0wXpIxNq0Mt3JhrFf0APtCATujxpqWsIiWYmsyWsMaklhP72KYa2A5tKFTEhfY9f
         5oozuOwxv3xZemuQQbAtdKPYamiTXP99IbGyq4UGCA6zsQ6pRU02tdfPijjqA6aZ4X
         5FssePgVuUjXkwN3oDGgwEpVH/KuG+uTjBKuRSh+4h1h7y8FYenH7KXNres1SR20Z2
         9EYyVMRism4qcRsRICPR1fTCUcYAHVIpIhva/XP5DAmglEEZo6J0GYbP9BkMBW7PLy
         65OdrVkkE4vWQ==
Message-ID: <c280ce5cc43474aa17767530bf280045b128e7af.camel@kernel.org>
Subject: Re: [PATCH] ceph: fix up test_dummy_encryption handling for new
 mount API
From:   Jeff Layton <jlayton@kernel.org>
To:     xiubli@redhat.com, ceph-devel@vger.kernel.org, idryomov@gmail.com
Cc:     vshankar@redhat.com, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Date:   Wed, 13 Jul 2022 06:42:31 -0400
In-Reply-To: <20220713085641.50232-1-xiubli@redhat.com>
References: <20220713085641.50232-1-xiubli@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-13 at 16:56 +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
>=20
> From Eric the "fscrypt_set_test_dummy_encryption()" will be removed
> in the next circle. Switch it to new APIs.
>=20
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/ceph/crypto.c |  4 +--
>  fs/ceph/super.c  | 94 ++++++++++++++++++++++++------------------------
>  fs/ceph/super.h  |  5 ++-
>  3 files changed, 52 insertions(+), 51 deletions(-)
>=20
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index 7e0c48e12554..5b807f8f4c69 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -127,7 +127,7 @@ static bool ceph_crypt_empty_dir(struct inode *inode)
> =20
>  static const union fscrypt_policy *ceph_get_dummy_policy(struct super_bl=
ock *sb)
>  {
> -	return ceph_sb_to_client(sb)->dummy_enc_policy.policy;
> +	return ceph_sb_to_client(sb)->fsc_dummy_enc_policy.policy;
>  }
> =20
>  static struct fscrypt_operations ceph_fscrypt_ops =3D {
> @@ -144,7 +144,7 @@ void ceph_fscrypt_set_ops(struct super_block *sb)
> =20
>  void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc)
>  {
> -	fscrypt_free_dummy_policy(&fsc->dummy_enc_policy);
> +	fscrypt_free_dummy_policy(&fsc->fsc_dummy_enc_policy);
>  }
> =20
>  int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index fa59a804b32c..4ac4a90755a2 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -591,10 +591,16 @@ static int ceph_parse_mount_param(struct fs_context=
 *fc,
>  		break;
>  	case Opt_test_dummy_encryption:
>  #ifdef CONFIG_FS_ENCRYPTION
> -		kfree(fsopt->test_dummy_encryption);
> -		fsopt->test_dummy_encryption =3D param->string;
> -		param->string =3D NULL;
> -		fsopt->flags |=3D CEPH_MOUNT_OPT_TEST_DUMMY_ENC;
> +		fscrypt_free_dummy_policy(&fsopt->dummy_enc_policy);
> +		ret =3D fscrypt_parse_test_dummy_encryption(param,
> +						&fsopt->dummy_enc_policy);
> +		if (ret =3D=3D -EINVAL) {
> +			warnfc(fc, "Value of option \"%s\" is unrecognized",
> +			       param->key);
> +		} else if (ret =3D=3D -EEXIST) {
> +			warnfc(fc, "Conflicting test_dummy_encryption options");
> +			ret =3D -EINVAL;
> +		}
>  #else
>  		warnfc(fc,
>  		       "FS encryption not supported: test_dummy_encryption mount optio=
n ignored");
> @@ -620,7 +626,7 @@ static void destroy_mount_options(struct ceph_mount_o=
ptions *args)
>  	kfree(args->server_path);
>  	kfree(args->fscache_uniq);
>  	kfree(args->mon_addr);
> -	kfree(args->test_dummy_encryption);
> +	fscrypt_free_dummy_policy(&args->dummy_enc_policy);
>  	kfree(args);
>  }
> =20
> @@ -1080,51 +1086,47 @@ static struct dentry *open_root_dentry(struct cep=
h_fs_client *fsc,
>  	return root;
>  }
> =20
> -#ifdef CONFIG_FS_ENCRYPTION
> -static int ceph_set_test_dummy_encryption(struct super_block *sb, struct=
 fs_context *fc,
> -						struct ceph_mount_options *fsopt)
> +static int ceph_apply_test_dummy_encryption(struct super_block *sb,
> +					    struct fs_context *fc,
> +					    struct ceph_mount_options *fsopt)
>  {
> -	/*
> -	 * No changing encryption context on remount. Note that
> -	 * fscrypt_set_test_dummy_encryption will validate the version
> -	 * string passed in (if any).
> -	 */
> -	if (fsopt->flags & CEPH_MOUNT_OPT_TEST_DUMMY_ENC) {
> -		struct ceph_fs_client *fsc =3D sb->s_fs_info;
> -		int err =3D 0;
> +	struct ceph_fs_client *fsc =3D sb->s_fs_info;
> +	int err;
> =20
> -		if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE && !fsc->dummy_enc_p=
olicy.policy) {
> -			errorfc(fc, "Can't set test_dummy_encryption on remount");
> -			return -EEXIST;
> -		}
> +	if (!fscrypt_is_dummy_policy_set(&fsopt->dummy_enc_policy))
> +		return 0;
> =20
> -		err =3D fscrypt_set_test_dummy_encryption(sb,
> -							fsc->mount_options->test_dummy_encryption,
> -							&fsc->dummy_enc_policy);
> -		if (err) {
> -			if (err =3D=3D -EEXIST)
> -				errorfc(fc, "Can't change test_dummy_encryption on remount");
> -			else if (err =3D=3D -EINVAL)
> -				errorfc(fc, "Value of option \"%s\" is unrecognized",
> -					fsc->mount_options->test_dummy_encryption);
> -			else
> -				errorfc(fc, "Error processing option \"%s\" [%d]",
> -					fsc->mount_options->test_dummy_encryption, err);
> -			return err;
> -		}
> -		warnfc(fc, "test_dummy_encryption mode enabled");
> +	/* No changing encryption context on remount. */
> +	if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE &&
> +	    !fscrypt_is_dummy_policy_set(&fsc->fsc_dummy_enc_policy)) {
> +		if (fscrypt_dummy_policies_equal(&fsopt->dummy_enc_policy,
> +						 &fsc->fsc_dummy_enc_policy))
> +			return 0;
> +		errorfc(fc, "Can't set test_dummy_encryption on remount");
> +		return -EINVAL;
>  	}
> +
> +	/* Also make sure fsopt doesn't contain a conflicting value. */
> +	if (fscrypt_is_dummy_policy_set(&fsc->fsc_dummy_enc_policy)) {
> +		if (fscrypt_dummy_policies_equal(&fsopt->dummy_enc_policy,
> +						 &fsc->fsc_dummy_enc_policy))
> +			return 0;
> +		errorfc(fc, "Conflicting test_dummy_encryption options");
> +		return -EINVAL;
> +	}
> +
> +	fsc->fsc_dummy_enc_policy =3D fsopt->dummy_enc_policy;
> +	memset(&fsopt->dummy_enc_policy, 0, sizeof(fsopt->dummy_enc_policy));
> +
> +	err =3D fscrypt_add_test_dummy_key(sb, &fsc->fsc_dummy_enc_policy);
> +	if (err) {
> +		errorfc(fc, "Error adding test dummy encryption key, %d", err);
> +		return err;
> +	}
> +
> +	warnfc(fc, "test_dummy_encryption mode enabled");
>  	return 0;
>  }
> -#else
> -static inline int ceph_set_test_dummy_encryption(struct super_block *sb,=
 struct fs_context *fc,
> -						struct ceph_mount_options *fsopt)
> -{
> -	if (fsopt->flags & CEPH_MOUNT_OPT_TEST_DUMMY_ENC)
> -		warnfc(fc, "test_dummy_encryption mode ignored");
> -	return 0;
> -}
> -#endif
> =20
>  /*
>   * mount: join the ceph cluster, and open root directory.
> @@ -1154,7 +1156,7 @@ static struct dentry *ceph_real_mount(struct ceph_f=
s_client *fsc,
>  				goto out;
>  		}
> =20
> -		err =3D ceph_set_test_dummy_encryption(fsc->sb, fc, fsc->mount_options=
);
> +		err =3D ceph_apply_test_dummy_encryption(fsc->sb, fc, fsc->mount_optio=
ns);
>  		if (err)
>  			goto out;
> =20
> @@ -1373,7 +1375,7 @@ static int ceph_reconfigure_fc(struct fs_context *f=
c)
>  	struct super_block *sb =3D fc->root->d_sb;
>  	struct ceph_fs_client *fsc =3D ceph_sb_to_client(sb);
> =20
> -	err =3D ceph_set_test_dummy_encryption(sb, fc, fsopt);
> +	err =3D ceph_apply_test_dummy_encryption(sb, fc, fsopt);
>  	if (err)
>  		return err;
> =20
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index bfc8bfcea799..5ea0ac6450dd 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -44,7 +44,6 @@
>  #define CEPH_MOUNT_OPT_ASYNC_DIROPS    (1<<15) /* allow async directory =
ops */
>  #define CEPH_MOUNT_OPT_NOPAGECACHE     (1<<16) /* bypass pagecache altog=
ether */
>  #define CEPH_MOUNT_OPT_SPARSEREAD      (1<<17) /* always do sparse reads=
 */
> -#define CEPH_MOUNT_OPT_TEST_DUMMY_ENC  (1<<18) /* enable dummy encryptio=
n (for testing) */
> =20
>  #define CEPH_MOUNT_OPT_DEFAULT			\
>  	(CEPH_MOUNT_OPT_DCACHE |		\
> @@ -101,7 +100,7 @@ struct ceph_mount_options {
>  	char *server_path;    /* default NULL (means "/") */
>  	char *fscache_uniq;   /* default NULL */
>  	char *mon_addr;
> -	char *test_dummy_encryption;	/* default NULL */
> +	struct fscrypt_dummy_policy dummy_enc_policy;
>  };
> =20
>  #define CEPH_ASYNC_CREATE_CONFLICT_BITS 8
> @@ -148,7 +147,7 @@ struct ceph_fs_client {
>  	struct fscache_volume *fscache;
>  #endif
>  #ifdef CONFIG_FS_ENCRYPTION
> -	struct fscrypt_dummy_policy dummy_enc_policy;
> +	struct fscrypt_dummy_policy fsc_dummy_enc_policy;
>  #endif
>  };
> =20

LGTM

Reviewed-by: Jeff Layton <jlayton@kernel.org>
