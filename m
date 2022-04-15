Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282E8502780
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351807AbiDOJnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351795AbiDOJne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4933C92D09
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650015664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h/1JCepYENbf71BepdLs1YbkeOFNfXucyH17mK6yMh0=;
        b=P4YlSyiZVt5WyIPAO7FzLhswtB7xChoRCqtA5Hg5jqYVnkdQSRDobbMB2ocz3+zGvWFxy+
        qwcImrDfgi9YVctRJeBU0ZQ5A1Pj79LQw6Nv+aDj9fegHhef2kBYyiqAL5TYGd72evopKg
        VFhgFi2jnQkCkTtOei0AcwtM1kdFLzU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-lvksoOZINKWxiqL-kL0lJQ-1; Fri, 15 Apr 2022 05:41:03 -0400
X-MC-Unique: lvksoOZINKWxiqL-kL0lJQ-1
Received: by mail-pf1-f200.google.com with SMTP id j185-20020a62c5c2000000b0050822009f1bso3052874pfg.23
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h/1JCepYENbf71BepdLs1YbkeOFNfXucyH17mK6yMh0=;
        b=Qs0jfWBRsRPhdLPztrfdZkU6sk6CbRBOb+z2v0BuNgI62cm/rcFe0Uc45U+IHqK1rB
         Y7f/g6dzKUrgMcTu4sFHLZoAg9r3i30vjVmc4bATJAnvEDR4sEWoDo1AVpxiFHqBP4b8
         0LG9Y/iWhOhZmI47KJ3FFoCMmDw0008b+dTuqbdBOHwPP1GtQXyrIhEb57urIqMZqA/r
         kXKWsg1G5EXDsm/IDBwwl/iSa+2pftTOdYhPePtRtjsZYU051OuoMq01vekNQiWNENDa
         fobNB4umELCtKpYJtgigOkWu2ph9opU0E4VtPtFiq1hDorgwgnuRtZfpYd1S1hb5MVgf
         cvTQ==
X-Gm-Message-State: AOAM5325ux6gDep4erewp3OsMHkmzCX34hogQDmBR0CGg4AVhZxJTJ2x
        7zl1UyVfqlnyMi/dm/M2SHWZ+b0NeSJfuHWmw2b5X7siQy8ZkMmv0OxQUtrBXBw34oLl5rLj3es
        8c7lzUPImphMdksuRvq4ZzIo5
X-Received: by 2002:a63:1b20:0:b0:382:70f9:dc24 with SMTP id b32-20020a631b20000000b0038270f9dc24mr5565804pgb.485.1650015661931;
        Fri, 15 Apr 2022 02:41:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQDFG3xXhNMasYOz+54LcHe6OLSQeA86AaCczvVXkLHAleqFPwF0nDj11Z+KebJClfH8oefA==
X-Received: by 2002:a63:1b20:0:b0:382:70f9:dc24 with SMTP id b32-20020a631b20000000b0038270f9dc24mr5565778pgb.485.1650015661542;
        Fri, 15 Apr 2022 02:41:01 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k13-20020aa7820d000000b004fa72a52040sm2267691pfi.172.2022.04.15.02.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 02:41:00 -0700 (PDT)
Date:   Fri, 15 Apr 2022 17:37:35 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        stable@kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/4] kexec: clean up arch_kexec_kernel_verify_sig
Message-ID: <20220415093735.74eusyuuboa32aqs@Rk>
References: <20220414014344.228523-1-coxu@redhat.com>
 <20220414014344.228523-2-coxu@redhat.com>
 <YleYmZAAnF5aOan3@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YleYmZAAnF5aOan3@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 11:44:25AM +0800, Baoquan He wrote:
>On 04/14/22 at 09:43am, Coiby Xu wrote:
>> Currently there is no arch-specific implementation of
>> arch_kexec_kernel_verify_sig. Even if we want to add an implementation
>> for an architecture in the future, we can simply use "(struct
>> kexec_file_ops*)->verify_sig". So clean it up.
>>
>> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
>> Cc: stable@kernel.org
>
>It should be not worth noticing stable kernel that a clean up patch need
>be back ported.

Thanks for the suggestion! For the 2nd and 3rd patch, I'll add prerequisite
info,

Cc: stable@kernel.org # 34d5960af253: kexec: clean up arch_kexec_kernel_verify_sig

and 

Cc: stable@kernel.org # 34d5960af253: kexec: clean up arch_kexec_kernel_verify_sig
Cc: stable@kernel.org # 83b7bb2d49ae: kexec, KEYS: make the code in bzImage64_verify_sig generic

respectively.

>
>Otherwise this looks good to me,
>
>Acked-by: Baoquan He <bhe@redhat.com>

Thanks for reviewing the patch!

>
>> Reviewed-by: Michal Suchanek <msuchanek@suse.de>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  include/linux/kexec.h |  4 ----
>>  kernel/kexec_file.c   | 34 +++++++++++++---------------------
>>  2 files changed, 13 insertions(+), 25 deletions(-)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 58d1b58a971e..413235c6c797 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -202,10 +202,6 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
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

