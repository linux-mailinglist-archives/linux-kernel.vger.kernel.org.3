Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0136C4E3717
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbiCVDBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiCVDBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:01:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B64D200353
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647918020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U37WGfHK2Z4UGbsI49VyTpH6r1geuhtlIDY00CwNU9c=;
        b=CBGrKZOhL+037PR4Gtdb7shK6A3gHVXkfXOyh7aUcdO5gsU5bjClCry2anIyBFrfuwGXU1
        MLgn4eWNaoiBBys6Og3WhoRoeOAdfBXlep8WuMz+C8sU9F1GWFetJ1edJCygZNX/pKZAt3
        CQ6cLWU1zedZ1imku7zpshUcVLF64E0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-ZZ2LASLfMwWooXdirsTWLw-1; Mon, 21 Mar 2022 23:00:18 -0400
X-MC-Unique: ZZ2LASLfMwWooXdirsTWLw-1
Received: by mail-pj1-f71.google.com with SMTP id o15-20020a17090aac0f00b001c6595a43dbso572951pjq.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U37WGfHK2Z4UGbsI49VyTpH6r1geuhtlIDY00CwNU9c=;
        b=LempPMVgeVJr4H69F7ad2tZ7guFjp4LYFDT6ltU8Hc4awhBv95ZZVMFzlBn6k5u0h3
         jdFcgYaslrhM5a1BZTMA64mJL97GdLj0yD2GIP3h5E7MKpFTVZ4iPqI1RDi8qKhq1hoc
         z2jzQPOBIBSu95T7+bWTgDk6kquKu8Idsw23q9b4KBICDG21E0Jjmv93EGS3R0qebPNd
         vCMo+Ci5xzSkgKq098dKQt0UzM46wo/hFiSE5VrW85ooswUP0te0gr/gOIeauvcmwAGJ
         LWYfZBssowB9ms4St8ItX83cwAPljTvjVxg0TQJh06fxYpL6MTR/gIDm4wx22l6qNC0n
         OAEQ==
X-Gm-Message-State: AOAM531NRD/91t9el3cOHBQMbLyw/IAYsOb4aojJ5ICexCfNEAjCmpVg
        2B40S7vx2sx9hGPCrRHF1KvTPVDQOLcj2j5D6fHGXFiJgkXNyKCNFEqox9i5p+DUbFciJR7exJ/
        NDhUVgCxrJxdKaDKJKkdIJqee
X-Received: by 2002:a17:902:ca0b:b0:153:b9f5:83b6 with SMTP id w11-20020a170902ca0b00b00153b9f583b6mr16154200pld.166.1647918017071;
        Mon, 21 Mar 2022 20:00:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvjyr6pauiubtK/5p0j4vfltwVBlreCQd2F76HK9qCghZBEHK9XsTCeHpDHCJELQ737H4j0A==
X-Received: by 2002:a17:902:ca0b:b0:153:b9f5:83b6 with SMTP id w11-20020a170902ca0b00b00153b9f583b6mr16154154pld.166.1647918016474;
        Mon, 21 Mar 2022 20:00:16 -0700 (PDT)
Received: from localhost ([240e:3a1:2e5:800:f995:6136:f760:a3d0])
        by smtp.gmail.com with ESMTPSA id b20-20020a17090a991400b001befe07ae5csm768330pjp.22.2022.03.21.20.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 20:00:15 -0700 (PDT)
Date:   Tue, 22 Mar 2022 10:59:12 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] kexec: clean up arch_kexec_kernel_verify_sig
Message-ID: <20220322025912.r2ahc2ztx3npt7av@Rk>
References: <20220318094101.274950-1-coxu@redhat.com>
 <20220318094101.274950-2-coxu@redhat.com>
 <Yjf9TbBo5ysjM7Nl@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Yjf9TbBo5ysjM7Nl@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 12:21:33PM +0800, Baoquan He wrote:
>On 03/18/22 at 05:40pm, Coiby Xu wrote:
>> Commit 9ec4ecef0af7 ("kexec_file,x86,powerpc: factor out kexec_file_ops
>> functions") allows implementing the arch-specific implementation of kernel
>> image verification in kexec_file_ops->verify_sig. Currently, there is no
>
>Looking back at the old commit 9ec4ecef0af7, it mistakenly added a
>generic arch_kexec_kernel_verify_sig() which is marked as __weak,
>and expects any architecture will add a arch specified version if needed.
>In fact those arch specified difference has been removed by wrapping
>them into each architecture's own struct kexec_file_ops methods. Means
>in the commit, the generic arch_kexec_kernel_verify_sig() is unnecessary
>at all.

Thanks for looking at commit 9ec4ecef0af7 for me!

Although commit 9ec4ecef0af7 added some code in arch_kexec_kernel_verify_sig
so kexec_file_ops->verify_sig can be called, this commit doesn't add __weak
arch_kexec_kernel_verify_sig itself. And kexec_file_ops isn't supposed
to replace arch-specific implementation using __weak considering s390 and x86
still make use of __weak to implement its own version of 
arch_kexec_apply_relocations_add. How about the commit message as
follows?

   Currently this no arch-specific implementation of
   arch_kexec_kernel_verify_sig. Even if we want to add an implementation
   for an architecture in the future, we can simply use "(struct
   kexec_file_ops*)->verify_sig". So clean it up.
>
>Now, you clean up that uncessary function with code change.
>
>I think description telling above analysis could be clearer.
>
>> arch-specific implementation of arch_kexec_kernel_verify_sig. So clean it
>> up.
>>
>> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  include/linux/kexec.h |  4 ----
>>  kernel/kexec_file.c   | 34 +++++++++++++---------------------
>>  2 files changed, 13 insertions(+), 25 deletions(-)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 0c994ae37729..755fed183224 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -196,10 +196,6 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
>>  				 const Elf_Shdr *relsec,
>>  				 const Elf_Shdr *symtab);
>>  int arch_kimage_file_post_load_cleanup(struct kimage *image);
>> -#ifdef CONFIG_KEXEC_SIG
>> -int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>> -				 unsigned long buf_len);
>> -#endif
>>  int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>>
>>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 8347fc158d2b..3720435807eb 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -89,25 +89,6 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
>>  	return kexec_image_post_load_cleanup_default(image);
>>  }
>>
>> -#ifdef CONFIG_KEXEC_SIG
>> -static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
>> -					  unsigned long buf_len)
>> -{
>> -	if (!image->fops || !image->fops->verify_sig) {
>> -		pr_debug("kernel loader does not support signature verification.\n");
>> -		return -EKEYREJECTED;
>> -	}
>> -
>> -	return image->fops->verify_sig(buf, buf_len);
>> -}
>> -
>> -int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>> -					unsigned long buf_len)
>> -{
>> -	return kexec_image_verify_sig_default(image, buf, buf_len);
>> -}
>> -#endif
>> -
>>  /*
>>   * arch_kexec_apply_relocations_add - apply relocations of type RELA
>>   * @pi:		Purgatory to be relocated.
>> @@ -184,13 +165,24 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>>  }
>>
>>  #ifdef CONFIG_KEXEC_SIG
>> +static int kexec_image_verify_sig(struct kimage *image, void *buf,
>> +		unsigned long buf_len)
>> +{
>> +	if (!image->fops || !image->fops->verify_sig) {
>> +		pr_debug("kernel loader does not support signature verification.\n");
>> +		return -EKEYREJECTED;
>> +	}
>> +
>> +	return image->fops->verify_sig(buf, buf_len);
>> +}
>> +
>>  static int
>>  kimage_validate_signature(struct kimage *image)
>>  {
>>  	int ret;
>>
>> -	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
>> -					   image->kernel_buf_len);
>> +	ret = kexec_image_verify_sig(image, image->kernel_buf,
>> +			image->kernel_buf_len);
>>  	if (ret) {
>>
>>  		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
>> --
>> 2.34.1
>>
>

-- 
Best regards,
Coiby

