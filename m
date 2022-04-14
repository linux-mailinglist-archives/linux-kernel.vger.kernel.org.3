Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CBA5003D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiDNBwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239541AbiDNBwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 927BA220FD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649901015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbIFt/hLvdmgH3emaym9nt7Eav8nywDFZBlv3s8K7FA=;
        b=B0U81MKWdYdR+ct83RL0WXqDgaCf3o3037cTqkwHl9lRhgyYEHHMJMVpLtTycYNrdbq99Y
        BaOSlCOUYG/Ikvqq5FADb6G0QFHR03JuFhgswvZwl/VqMEQ75uIfemiPY3Xg+FZyZLpXfU
        IKhnV1PH5UPlGA9IyURKE2ATsgq0x8c=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-m4fYUIkbOkilLK99beb6bA-1; Wed, 13 Apr 2022 21:50:14 -0400
X-MC-Unique: m4fYUIkbOkilLK99beb6bA-1
Received: by mail-pg1-f200.google.com with SMTP id b18-20020a63d812000000b0037e1aa59c0bso1974431pgh.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LbIFt/hLvdmgH3emaym9nt7Eav8nywDFZBlv3s8K7FA=;
        b=oRZ6SByWI+J7oAgpJCaKOdQv0sGhgU+Pk/VkgyB+uMCY218Jht62TyW9+OncmCV/5n
         kCx9OB8Y6Yi0ucv+ExCg46wsQul2lGrA6Joh1rYTKHd4er5UpUHWZGEuaPwZsNhxzl2G
         KQMaQPyF1SVatvv8PK/9eAOrLL54icbptuK8mLx+FBwecagrK2bzisIi1ETyZ8OEjiNo
         yMmx1pDND25971xqzBSAp+BlRU/wAVT/StxO2E9QSZzPH7DceEo6NhwBpBXlpctBS0JF
         /JFnuf76EWYXsnShIG5B8awpKEGYRq+GoeSYxlrZ7BIFyY95f1YNc8Myn6GQFWzJ8Pw5
         JulQ==
X-Gm-Message-State: AOAM531Lq5mYBgtqngZT+WCeR9WQLkph4ms/B/83jKM4Ep5E0k35aAoD
        9PdN+v16/QpqH1c3ScFiBIDxnBUSxERey2Xx/OVQkyyY2NKccsWLwcsLUnsycHLdnHU2nzVNg6k
        TvTLLNM2lQatNolOWIKQ7aBnZ
X-Received: by 2002:a63:1725:0:b0:39d:7957:7396 with SMTP id x37-20020a631725000000b0039d79577396mr391339pgl.156.1649901013275;
        Wed, 13 Apr 2022 18:50:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy8B6dsOxZIo58DE4+eOkMN6SM4w55xIwVO/TCzGYn0DvJ2qrUhkiBU4XfrhpTrC/j2yzOSA==
X-Received: by 2002:a63:1725:0:b0:39d:7957:7396 with SMTP id x37-20020a631725000000b0039d79577396mr391315pgl.156.1649901012971;
        Wed, 13 Apr 2022 18:50:12 -0700 (PDT)
Received: from localhost ([240e:3a1:31c:360:52fc:c968:cb41:efbc])
        by smtp.gmail.com with ESMTPSA id y3-20020a056a00190300b004fa2411bb92sm345861pfi.93.2022.04.13.18.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:50:12 -0700 (PDT)
Date:   Thu, 14 Apr 2022 09:46:05 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] kexec, KEYS: make the code in
 bzImage64_verify_sig generic
Message-ID: <20220414014605.etdihzqs764v74gf@Rk>
References: <20220401013118.348084-1-coxu@redhat.com>
 <20220401013118.348084-3-coxu@redhat.com>
 <20220411085411.GZ163591@kunlun.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411085411.GZ163591@kunlun.suse.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 10:54:11AM +0200, Michal Suchánek wrote:
>On Fri, Apr 01, 2022 at 09:31:17AM +0800, Coiby Xu wrote:
>> The code in bzImage64_verify_sig could make use of system keyrings
>s/could make/makes/
>> including .buitin_trusted_keys, .secondary_trusted_keys and .platform
>> keyring to verify signed kernel image as PE file. Make it generic so
>> both x86_64 and arm64 can use it.
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  arch/x86/kernel/kexec-bzimage64.c | 13 +------------
>>  include/linux/kexec.h             |  7 +++++++
>>  kernel/kexec_file.c               | 17 +++++++++++++++++
>>  3 files changed, 25 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>> index 170d0fd68b1f..f73aab3fde33 100644
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
>> @@ -531,17 +530,7 @@ static int bzImage64_cleanup(void *loader_data)
>>  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
>>  static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
>>  {
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
>> +	return kexec_kernel_verify_pe_sig(kernel, kernel_len);
>>  }
>
>Maybe you can completely eliminate bzImage64_verify_sig and directly
>assign kexec_kernel_verify_pe_sig to the fops?
>
>Other than that
>
>Reviewed-by: Michal Suchanek <msuchanek@suse.de>

Applied, thanks for the suggestion and reviewing the patch!

>

>>  #endif
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 755fed183224..2fe39e946988 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -19,6 +19,7 @@
>>  #include <asm/io.h>
>>
>>  #include <uapi/linux/kexec.h>
>> +#include <linux/verification.h>
>>
>>  #ifdef CONFIG_KEXEC_CORE
>>  #include <linux/list.h>
>> @@ -196,6 +197,12 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
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

