Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2F7504C63
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 07:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiDRFsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 01:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiDRFr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 01:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79E0A11C3B
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 22:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650260716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T1o3lDkKjJ1ubV1pkELZ5kYo2o2QIP5NYLC4ArKgbfs=;
        b=YZK2eEao9KmN3vJzDeomLl4tJYArXLuxlNKJhqYJNFBhjSAoBLcDkYJn5PbuSgq+7/DIdx
        OPN52k0ej9il3Lmm+QYs2QCTKdacnti/I/8IRy1vsUqrNzChBrbHMLZOnDT38sFA7VvP9n
        V+S/1i86cuxVJO/wHveFf+kRyDRpwQs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-eYxiXXP1PkOFLtNOItlS3Q-1; Mon, 18 Apr 2022 01:45:14 -0400
X-MC-Unique: eYxiXXP1PkOFLtNOItlS3Q-1
Received: by mail-pl1-f200.google.com with SMTP id q6-20020a170902eb8600b001588e49dcaaso7110936plg.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 22:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T1o3lDkKjJ1ubV1pkELZ5kYo2o2QIP5NYLC4ArKgbfs=;
        b=rGUXsq6Rh9tLmWjAUOs4lNl8jgXtwaq+qZW+CNiQc+0K3b6ntyn8lRP8D79Yuh5Vp+
         phjoj6haBSMHI2qbCZnOEbBHsawSg6X4oZKWcSb3u6OQViLRdgAN8tOowHN9Jhg3fD2X
         ccIji8hYk+k2qI+FUaPMefeS3/gZGxDfVPqMGrKquX8HSi8fHo40f8yQUJi+exkRyg6i
         nK/YJZ//4Zb7AHpEAdgXMBOwDXYh97owpJ/SlTm5UDWpmHWNXLfQYhmThW1D43EBDkgb
         xVMNVTMSYO3o+YoyvUSQznz3QlTfpmNKG/F3Jfo35XQ72PlRMK2dm+NPm0wNqcnhv51c
         fnAg==
X-Gm-Message-State: AOAM532ITDuJd6u/9shHc9s0+7n12AAnpQ+fSWsuEl+PP1fRh3NoquTe
        0F6wHm1RLupwb+ZD4XGU0qZWBrpRIVDdWBMdj5r1Lqc2FTNp/v9amLCu94m6eRpy0YJCZwm6H8i
        x/rXe6iR30LUOO4AX+Eg+gRt9
X-Received: by 2002:aa7:9110:0:b0:4fa:e388:af57 with SMTP id 16-20020aa79110000000b004fae388af57mr10410813pfh.1.1650260713598;
        Sun, 17 Apr 2022 22:45:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymR0oZfWlFYrAEf8qnTbPoW8P8tQF737+NvuBY9kYfxQXTP0JBlH5CEWGh43eAvxmeN/jnaw==
X-Received: by 2002:aa7:9110:0:b0:4fa:e388:af57 with SMTP id 16-20020aa79110000000b004fae388af57mr10410797pfh.1.1650260713196;
        Sun, 17 Apr 2022 22:45:13 -0700 (PDT)
Received: from localhost ([240e:3a1:2e1:fc30:496c:36d3:5798:d144])
        by smtp.gmail.com with ESMTPSA id p17-20020a056a0026d100b00505ff62176asm10524875pfw.180.2022.04.17.22.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 22:45:12 -0700 (PDT)
Date:   Mon, 18 Apr 2022 13:42:37 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Yinghai Lu <yinghai@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/4] kexec, KEYS: make the code in
 bzImage64_verify_sig generic
Message-ID: <20220418054237.2rjt357op5nhttvk@Rk>
References: <20220414014344.228523-1-coxu@redhat.com>
 <20220414014344.228523-3-coxu@redhat.com>
 <YlzChw5kPOlPmK9Z@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YlzChw5kPOlPmK9Z@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 09:53:32AM +0800, Baoquan He wrote:
>On 04/14/22 at 09:43am, Coiby Xu wrote:
>> commit 278311e417be ("kexec, KEYS: Make use of platform keyring for
>> signature verify") adds platform keyring support on x86 kexec but not
>> arm64.
>>
>> The code in bzImage64_verify_sig makes use of system keyrings including
>> .buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to
>> verify signed kernel image as PE file. Make it generic so both x86_64
>> and arm64 can use it.
>>
>> Fixes: 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
>
>Will the code in bzImage64_verify_sig generic not being genric cause any
>issue? Asking this because I don't get why making code generic need add
>'Fixes' tag.

Thanks for raising this question! This Fixes tag is for the problem
as described in the 1st paragraph of the commit message and making the
code generic is the solution. But if I misuse the Fixes tag, I can drop
it.

>
>> Cc: kexec@lists.infradead.org
>> Cc: keyrings@vger.kernel.org
>> Cc: linux-security-module@vger.kernel.org
>> Cc: stable@kernel.org
>> Reviewed-by: Michal Suchanek <msuchanek@suse.de>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  arch/x86/kernel/kexec-bzimage64.c | 20 +-------------------
>>  include/linux/kexec.h             |  7 +++++++
>>  kernel/kexec_file.c               | 17 +++++++++++++++++
>>  3 files changed, 25 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>> index 170d0fd68b1f..f299b48f9c9f 100644
>> --- a/arch/x86/kernel/kexec-bzimage64.c
>> +++ b/arch/x86/kernel/kexec-bzimage64.c
>> @@ -17,7 +17,6 @@
>>  #include <linux/kernel.h>
>>  #include <linux/mm.h>
>>  #include <linux/efi.h>
>> -#include <linux/verification.h>
>>
>>  #include <asm/bootparam.h>
>>  #include <asm/setup.h>
>> @@ -528,28 +527,11 @@ static int bzImage64_cleanup(void *loader_data)
>>  	return 0;
>>  }
>>
>> -#ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
>> -static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
>> -{
>> -	int ret;
>> -
>> -	ret = verify_pefile_signature(kernel, kernel_len,
>> -				      VERIFY_USE_SECONDARY_KEYRING,
>> -				      VERIFYING_KEXEC_PE_SIGNATURE);
>> -	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
>> -		ret = verify_pefile_signature(kernel, kernel_len,
>> -					      VERIFY_USE_PLATFORM_KEYRING,
>> -					      VERIFYING_KEXEC_PE_SIGNATURE);
>> -	}
>> -	return ret;
>> -}
>> -#endif
>> -
>>  const struct kexec_file_ops kexec_bzImage64_ops = {
>>  	.probe = bzImage64_probe,
>>  	.load = bzImage64_load,
>>  	.cleanup = bzImage64_cleanup,
>>  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
>> -	.verify_sig = bzImage64_verify_sig,
>> +	.verify_sig = kexec_kernel_verify_pe_sig,
>>  #endif
>>  };
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 413235c6c797..da83abfc628b 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -19,6 +19,7 @@
>>  #include <asm/io.h>
>>
>>  #include <uapi/linux/kexec.h>
>> +#include <linux/verification.h>
>>
>>  /* Location of a reserved region to hold the crash kernel.
>>   */
>> @@ -202,6 +203,12 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
>>  				 const Elf_Shdr *relsec,
>>  				 const Elf_Shdr *symtab);
>>  int arch_kimage_file_post_load_cleanup(struct kimage *image);
>> +#ifdef CONFIG_KEXEC_SIG
>> +#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
>> +int kexec_kernel_verify_pe_sig(const char *kernel,
>> +				    unsigned long kernel_len);
>> +#endif
>> +#endif
>>  int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>>
>>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 3720435807eb..754885b96aab 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -165,6 +165,23 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>>  }
>>
>>  #ifdef CONFIG_KEXEC_SIG
>> +#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
>> +int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
>> +{
>> +	int ret;
>> +
>> +	ret = verify_pefile_signature(kernel, kernel_len,
>> +				      VERIFY_USE_SECONDARY_KEYRING,
>> +				      VERIFYING_KEXEC_PE_SIGNATURE);
>> +	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
>> +		ret = verify_pefile_signature(kernel, kernel_len,
>> +					      VERIFY_USE_PLATFORM_KEYRING,
>> +					      VERIFYING_KEXEC_PE_SIGNATURE);
>> +	}
>> +	return ret;
>> +}
>> +#endif
>> +
>>  static int kexec_image_verify_sig(struct kimage *image, void *buf,
>>  		unsigned long buf_len)
>>  {
>> --
>> 2.34.1
>>
>

-- 
Best regards,
Coiby

