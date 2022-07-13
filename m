Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42325736B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiGMMzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbiGMMzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3820D73927
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657716945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MyhgJNgSJQ9iXfy8wNUB0xJJACQTSSOXqa+XU8lWAOg=;
        b=GWBaNd5dZY73/OZdF7jjiV+/uccDlnCnQZAMr0J8mPi5e1/Ok8C7voY/+klBfLJHiYUJCj
        FpkwyOtEdkIsG/fASQUK/bieKvKAJiYMjSyXLEnKZOhDA3dfBn9a6JPDzziygaJa3QK9uS
        QAm9vYgJvAhARqbp+tpN8mcyD4PXFas=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-hfFwNP3qMaCeJf58vOqoPw-1; Wed, 13 Jul 2022 08:55:44 -0400
X-MC-Unique: hfFwNP3qMaCeJf58vOqoPw-1
Received: by mail-pf1-f200.google.com with SMTP id i21-20020aa79095000000b00528bd947f66so3962050pfa.18
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MyhgJNgSJQ9iXfy8wNUB0xJJACQTSSOXqa+XU8lWAOg=;
        b=Nki1CyBI2dk3EeHngdhs0LvIrNTRwV5LoIUVn/Z9Y8LB5Bj+n38sZXBW0P3nDJsgGs
         nYU175g/RuFq+8LbEtTd3Kw+/wS/T5S2yaAB5EbtyYAfxKLPvCB/jI7jTw00Pe1s3e05
         SF6nK1EQL6RVKvtDvYDlULvMaMYFdS5nrSXjgoaf5OwDV+e0Dd8fyFJcEtlSMktp0y3F
         rL3vZ44fQ6TkUKEmSxS/RfoZ4RxzmDTZ1WKK5LK6oRldi6aYtD8w7r6GV5Oo0/GLfPJg
         cw7eM8ircAedeqk4wkiNq1eRrVmLIw3xjI1Clp9IyZV/K0tkcjtAAN/0epcaHBnwy65b
         J3fQ==
X-Gm-Message-State: AJIora/9cp2OOpPFnMTH3pmezI8QV3ReP1iO8OE3GoUkmAawHJ2EG74J
        H3zORo3fIQxxfhUadsrdaanBth1tDilIpPe1ap2C9hN54vj6arj7TcQBG0I+iN7YPJu562Gk3vK
        OkjbSA5QJXds6aT5MpO5KNmlP
X-Received: by 2002:a17:902:c7cb:b0:16b:dc5d:8959 with SMTP id r11-20020a170902c7cb00b0016bdc5d8959mr3338687pla.87.1657716943069;
        Wed, 13 Jul 2022 05:55:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uWvUc9i7wRwERlL9Odg68OfqIXYU2+RVWc2oO13SEY1Jklnwm9ZEuxdBDgfdYyPBp2gLAljQ==
X-Received: by 2002:a17:902:c7cb:b0:16b:dc5d:8959 with SMTP id r11-20020a170902c7cb00b0016bdc5d8959mr3338657pla.87.1657716942626;
        Wed, 13 Jul 2022 05:55:42 -0700 (PDT)
Received: from [10.72.14.22] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902b68100b0016bd62bc003sm8760331pls.141.2022.07.13.05.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 05:55:41 -0700 (PDT)
Subject: Re: [PATCH] ceph: fix up test_dummy_encryption handling for new mount
 API
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        idryomov@gmail.com
Cc:     vshankar@redhat.com, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
References: <20220713085641.50232-1-xiubli@redhat.com>
 <c280ce5cc43474aa17767530bf280045b128e7af.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <b82c4486-42ea-cdd1-8204-6dcc95836f72@redhat.com>
Date:   Wed, 13 Jul 2022 20:55:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c280ce5cc43474aa17767530bf280045b128e7af.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

I am rebasing the 'wip-fscrypt' branch to the 'testing', and there is 
one commit conflicts:

commit 81faddddbef409bcaa1aa3d89e59606cde94dab7
Author: Jeff Layton <jlayton@kernel.org>
Date:   Wed Dec 1 09:21:39 2021 -0500

     ceph: add infrastructure for file encryption and decryption

     ...and allow test_dummy_encryption to bypass content encryption
     if mounted with test_dummy_encryption=clear.

     Reviewed-by: Xiubo Li <xiubli@redhat.com>
     Signed-off-by: Jeff Layton <jlayton@kernel.org>

And the conflicts are:

[xiubli@fedora ]$ cat fs/ceph/super.h.rej
--- fs/ceph/super.h
+++ fs/ceph/super.h
@@ -45,6 +45,7 @@
  #define CEPH_MOUNT_OPT_NOPAGECACHE     (1<<16) /* bypass pagecache 
altogether */
  #define CEPH_MOUNT_OPT_SPARSEREAD      (1<<17) /* always do sparse 
reads */
  #define CEPH_MOUNT_OPT_TEST_DUMMY_ENC  (1<<18) /* enable dummy 
encryption (for testing) */
+#define CEPH_MOUNT_OPT_DUMMY_ENC_CLEAR (1<<19) /* don't actually 
encrypt content */

  #define CEPH_MOUNT_OPT_DEFAULT            \
      (CEPH_MOUNT_OPT_DCACHE |        \

[xiubli@fedora ]$ cat fs/ceph/super.c.rej
--- fs/ceph/super.c
+++ fs/ceph/super.c
@@ -1098,6 +1098,14 @@ static int ceph_set_test_dummy_encryption(struct 
super_block *sb, struct fs_cont
              return -EEXIST;
          }

+        /* HACK: allow for cleartext "encryption" in files for testing */
+        if (fsc->mount_options->test_dummy_encryption &&
+ !strcmp(fsc->mount_options->test_dummy_encryption, "clear")) {
+            fsopt->flags |= CEPH_MOUNT_OPT_DUMMY_ENC_CLEAR;
+ kfree(fsc->mount_options->test_dummy_encryption);
+            fsc->mount_options->test_dummy_encryption = NULL;
+        }
+
          err = fscrypt_set_test_dummy_encryption(sb,
fsc->mount_options->test_dummy_encryption,
                              &fsc->dummy_enc_policy);

And I have pushed the tmp patches to 
https://github.com/lxbsz/ceph-client/commits/lxb-wip-fscrypt3.

Please take a look is that okay ?

Thanks

-- Xiubo



On 7/13/22 6:42 PM, Jeff Layton wrote:
> On Wed, 2022-07-13 at 16:56 +0800, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>>  From Eric the "fscrypt_set_test_dummy_encryption()" will be removed
>> in the next circle. Switch it to new APIs.
>>
>> Cc: Eric Biggers <ebiggers@kernel.org>
>> Cc: Jeff Layton <jlayton@kernel.org>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/crypto.c |  4 +--
>>   fs/ceph/super.c  | 94 ++++++++++++++++++++++++------------------------
>>   fs/ceph/super.h  |  5 ++-
>>   3 files changed, 52 insertions(+), 51 deletions(-)
>>
>> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>> index 7e0c48e12554..5b807f8f4c69 100644
>> --- a/fs/ceph/crypto.c
>> +++ b/fs/ceph/crypto.c
>> @@ -127,7 +127,7 @@ static bool ceph_crypt_empty_dir(struct inode *inode)
>>   
>>   static const union fscrypt_policy *ceph_get_dummy_policy(struct super_block *sb)
>>   {
>> -	return ceph_sb_to_client(sb)->dummy_enc_policy.policy;
>> +	return ceph_sb_to_client(sb)->fsc_dummy_enc_policy.policy;
>>   }
>>   
>>   static struct fscrypt_operations ceph_fscrypt_ops = {
>> @@ -144,7 +144,7 @@ void ceph_fscrypt_set_ops(struct super_block *sb)
>>   
>>   void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc)
>>   {
>> -	fscrypt_free_dummy_policy(&fsc->dummy_enc_policy);
>> +	fscrypt_free_dummy_policy(&fsc->fsc_dummy_enc_policy);
>>   }
>>   
>>   int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>> index fa59a804b32c..4ac4a90755a2 100644
>> --- a/fs/ceph/super.c
>> +++ b/fs/ceph/super.c
>> @@ -591,10 +591,16 @@ static int ceph_parse_mount_param(struct fs_context *fc,
>>   		break;
>>   	case Opt_test_dummy_encryption:
>>   #ifdef CONFIG_FS_ENCRYPTION
>> -		kfree(fsopt->test_dummy_encryption);
>> -		fsopt->test_dummy_encryption = param->string;
>> -		param->string = NULL;
>> -		fsopt->flags |= CEPH_MOUNT_OPT_TEST_DUMMY_ENC;
>> +		fscrypt_free_dummy_policy(&fsopt->dummy_enc_policy);
>> +		ret = fscrypt_parse_test_dummy_encryption(param,
>> +						&fsopt->dummy_enc_policy);
>> +		if (ret == -EINVAL) {
>> +			warnfc(fc, "Value of option \"%s\" is unrecognized",
>> +			       param->key);
>> +		} else if (ret == -EEXIST) {
>> +			warnfc(fc, "Conflicting test_dummy_encryption options");
>> +			ret = -EINVAL;
>> +		}
>>   #else
>>   		warnfc(fc,
>>   		       "FS encryption not supported: test_dummy_encryption mount option ignored");
>> @@ -620,7 +626,7 @@ static void destroy_mount_options(struct ceph_mount_options *args)
>>   	kfree(args->server_path);
>>   	kfree(args->fscache_uniq);
>>   	kfree(args->mon_addr);
>> -	kfree(args->test_dummy_encryption);
>> +	fscrypt_free_dummy_policy(&args->dummy_enc_policy);
>>   	kfree(args);
>>   }
>>   
>> @@ -1080,51 +1086,47 @@ static struct dentry *open_root_dentry(struct ceph_fs_client *fsc,
>>   	return root;
>>   }
>>   
>> -#ifdef CONFIG_FS_ENCRYPTION
>> -static int ceph_set_test_dummy_encryption(struct super_block *sb, struct fs_context *fc,
>> -						struct ceph_mount_options *fsopt)
>> +static int ceph_apply_test_dummy_encryption(struct super_block *sb,
>> +					    struct fs_context *fc,
>> +					    struct ceph_mount_options *fsopt)
>>   {
>> -	/*
>> -	 * No changing encryption context on remount. Note that
>> -	 * fscrypt_set_test_dummy_encryption will validate the version
>> -	 * string passed in (if any).
>> -	 */
>> -	if (fsopt->flags & CEPH_MOUNT_OPT_TEST_DUMMY_ENC) {
>> -		struct ceph_fs_client *fsc = sb->s_fs_info;
>> -		int err = 0;
>> +	struct ceph_fs_client *fsc = sb->s_fs_info;
>> +	int err;
>>   
>> -		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE && !fsc->dummy_enc_policy.policy) {
>> -			errorfc(fc, "Can't set test_dummy_encryption on remount");
>> -			return -EEXIST;
>> -		}
>> +	if (!fscrypt_is_dummy_policy_set(&fsopt->dummy_enc_policy))
>> +		return 0;
>>   
>> -		err = fscrypt_set_test_dummy_encryption(sb,
>> -							fsc->mount_options->test_dummy_encryption,
>> -							&fsc->dummy_enc_policy);
>> -		if (err) {
>> -			if (err == -EEXIST)
>> -				errorfc(fc, "Can't change test_dummy_encryption on remount");
>> -			else if (err == -EINVAL)
>> -				errorfc(fc, "Value of option \"%s\" is unrecognized",
>> -					fsc->mount_options->test_dummy_encryption);
>> -			else
>> -				errorfc(fc, "Error processing option \"%s\" [%d]",
>> -					fsc->mount_options->test_dummy_encryption, err);
>> -			return err;
>> -		}
>> -		warnfc(fc, "test_dummy_encryption mode enabled");
>> +	/* No changing encryption context on remount. */
>> +	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE &&
>> +	    !fscrypt_is_dummy_policy_set(&fsc->fsc_dummy_enc_policy)) {
>> +		if (fscrypt_dummy_policies_equal(&fsopt->dummy_enc_policy,
>> +						 &fsc->fsc_dummy_enc_policy))
>> +			return 0;
>> +		errorfc(fc, "Can't set test_dummy_encryption on remount");
>> +		return -EINVAL;
>>   	}
>> +
>> +	/* Also make sure fsopt doesn't contain a conflicting value. */
>> +	if (fscrypt_is_dummy_policy_set(&fsc->fsc_dummy_enc_policy)) {
>> +		if (fscrypt_dummy_policies_equal(&fsopt->dummy_enc_policy,
>> +						 &fsc->fsc_dummy_enc_policy))
>> +			return 0;
>> +		errorfc(fc, "Conflicting test_dummy_encryption options");
>> +		return -EINVAL;
>> +	}
>> +
>> +	fsc->fsc_dummy_enc_policy = fsopt->dummy_enc_policy;
>> +	memset(&fsopt->dummy_enc_policy, 0, sizeof(fsopt->dummy_enc_policy));
>> +
>> +	err = fscrypt_add_test_dummy_key(sb, &fsc->fsc_dummy_enc_policy);
>> +	if (err) {
>> +		errorfc(fc, "Error adding test dummy encryption key, %d", err);
>> +		return err;
>> +	}
>> +
>> +	warnfc(fc, "test_dummy_encryption mode enabled");
>>   	return 0;
>>   }
>> -#else
>> -static inline int ceph_set_test_dummy_encryption(struct super_block *sb, struct fs_context *fc,
>> -						struct ceph_mount_options *fsopt)
>> -{
>> -	if (fsopt->flags & CEPH_MOUNT_OPT_TEST_DUMMY_ENC)
>> -		warnfc(fc, "test_dummy_encryption mode ignored");
>> -	return 0;
>> -}
>> -#endif
>>   
>>   /*
>>    * mount: join the ceph cluster, and open root directory.
>> @@ -1154,7 +1156,7 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
>>   				goto out;
>>   		}
>>   
>> -		err = ceph_set_test_dummy_encryption(fsc->sb, fc, fsc->mount_options);
>> +		err = ceph_apply_test_dummy_encryption(fsc->sb, fc, fsc->mount_options);
>>   		if (err)
>>   			goto out;
>>   
>> @@ -1373,7 +1375,7 @@ static int ceph_reconfigure_fc(struct fs_context *fc)
>>   	struct super_block *sb = fc->root->d_sb;
>>   	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
>>   
>> -	err = ceph_set_test_dummy_encryption(sb, fc, fsopt);
>> +	err = ceph_apply_test_dummy_encryption(sb, fc, fsopt);
>>   	if (err)
>>   		return err;
>>   
>> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
>> index bfc8bfcea799..5ea0ac6450dd 100644
>> --- a/fs/ceph/super.h
>> +++ b/fs/ceph/super.h
>> @@ -44,7 +44,6 @@
>>   #define CEPH_MOUNT_OPT_ASYNC_DIROPS    (1<<15) /* allow async directory ops */
>>   #define CEPH_MOUNT_OPT_NOPAGECACHE     (1<<16) /* bypass pagecache altogether */
>>   #define CEPH_MOUNT_OPT_SPARSEREAD      (1<<17) /* always do sparse reads */
>> -#define CEPH_MOUNT_OPT_TEST_DUMMY_ENC  (1<<18) /* enable dummy encryption (for testing) */
>>   
>>   #define CEPH_MOUNT_OPT_DEFAULT			\
>>   	(CEPH_MOUNT_OPT_DCACHE |		\
>> @@ -101,7 +100,7 @@ struct ceph_mount_options {
>>   	char *server_path;    /* default NULL (means "/") */
>>   	char *fscache_uniq;   /* default NULL */
>>   	char *mon_addr;
>> -	char *test_dummy_encryption;	/* default NULL */
>> +	struct fscrypt_dummy_policy dummy_enc_policy;
>>   };
>>   
>>   #define CEPH_ASYNC_CREATE_CONFLICT_BITS 8
>> @@ -148,7 +147,7 @@ struct ceph_fs_client {
>>   	struct fscache_volume *fscache;
>>   #endif
>>   #ifdef CONFIG_FS_ENCRYPTION
>> -	struct fscrypt_dummy_policy dummy_enc_policy;
>> +	struct fscrypt_dummy_policy fsc_dummy_enc_policy;
>>   #endif
>>   };
>>   
> LGTM
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>

