Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9860573496
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiGMKtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiGMKtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F25AF6829
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657709381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4iSRKAh2WOknEOTLoiGqu+KnAPhB6D5WXL9Uh1JDhk=;
        b=bE5/aaEpEB7eq77G7eC/uluoqIMb2++m1xA5LqWyMUl3VDZskjVa37KwIFvXVTO8QXakEx
        JhSjN+BFi5QDIOhUXUrrqnTtxKinz6ekVWaZj+juUP/AXPOFe6ob/L88iX/3nJTTs2mMsH
        uc/MI4CB5v51+ATAyafhc9GB4cVwdX4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-deLRh3obNRuPMAzZVlLPVQ-1; Wed, 13 Jul 2022 06:49:40 -0400
X-MC-Unique: deLRh3obNRuPMAzZVlLPVQ-1
Received: by mail-pf1-f200.google.com with SMTP id h5-20020a62b405000000b00528c76085e4so3836499pfn.15
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y4iSRKAh2WOknEOTLoiGqu+KnAPhB6D5WXL9Uh1JDhk=;
        b=cpv9i9rY08ROhqCgSBRj/bpLi8Dl/ILlACPLi/hHB+WwlHv71aL9n4qR11t9KH6qMA
         DRH2YI+FocIPBwujJcNGoSwHVKK2+dWwyn3DHiHPuDPY/dQsRs5pJeIrKuxSLOxMRr9t
         7hYUfAr7tL4kHRopFTcUlGyGG8h8abpdGdDjaDiGvuh6ExdSzJf3B2CNauN4O3vcjnQL
         +jDcfuS+lz1PMxMF6W/7v97nVDmdUW7vATd0vVUOR23aCE1abPKpdzwmxpgqwVe6pbz8
         wc8jde/l1plmvMlSgrr8a2zH/tVmBaMQQNDMQabUKbVOpM5lBa8Lsc7UkhSUAQ5uT1ru
         q5RA==
X-Gm-Message-State: AJIora/OQKGOX2ZE9VIPM+czm8hSuk9L2oUCDGrsoaC2qMuK2fTm1U0W
        7v3VnEuBdEgQifSvwwrCy1FCO1B4eTZ9HmwXVzwfMW9Lr1iEhpfrII3huidcJeihiKX5bO3scJP
        SWuCyAGpCzab4RYMJRZ0DK3BI
X-Received: by 2002:a63:6bc4:0:b0:40d:fd98:bb21 with SMTP id g187-20020a636bc4000000b0040dfd98bb21mr2381406pgc.249.1657709379096;
        Wed, 13 Jul 2022 03:49:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t/pgVPuQnqGTvQ2bM7jVP3fI6VvEpcGmG9Bl/0BXp+cqYoQrmW8ARh1cGFCo0DJkcHhve/JA==
X-Received: by 2002:a63:6bc4:0:b0:40d:fd98:bb21 with SMTP id g187-20020a636bc4000000b0040dfd98bb21mr2381378pgc.249.1657709378675;
        Wed, 13 Jul 2022 03:49:38 -0700 (PDT)
Received: from [10.72.14.22] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z8-20020a1709027e8800b0016c6e360ff6sm1384882pla.303.2022.07.13.03.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 03:49:37 -0700 (PDT)
Subject: Re: [PATCH] ceph: fix up test_dummy_encryption handling for new mount
 API
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        idryomov@gmail.com
Cc:     vshankar@redhat.com, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
References: <20220713085641.50232-1-xiubli@redhat.com>
 <c280ce5cc43474aa17767530bf280045b128e7af.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <a84ca75d-7909-64c4-d91a-15caae05d704@redhat.com>
Date:   Wed, 13 Jul 2022 18:49:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c280ce5cc43474aa17767530bf280045b128e7af.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

Thanks Jeff.

I will fold this into the previous commit.

-- Xiubo

