Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EF249D9C3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 06:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiA0FBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 00:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiA0FBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 00:01:32 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03631C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 21:01:32 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id h14so1536279plf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 21:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4WM44B/NC7a0HeWoHpvCPlwdzgz9p2YQGoPd7Uf57rc=;
        b=FuKhOS2Z6v6+EP8HMgoyRv4d9WUob6v9JooGXGSJaFzOnRuN4K5pyxfK4FTHmKMz0r
         ZsxbucRIOwvGOxPRho2vaQoXMhschprW7e7XsS2AAXRi0qUEQHqGM3GH+2w1V23zNgHW
         fCL/+OH6qnYvyhp73psmLwS0THivJUVFB6r7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4WM44B/NC7a0HeWoHpvCPlwdzgz9p2YQGoPd7Uf57rc=;
        b=KFphDFObWnlYLPcMRytWoW1gxBL6uLsSrGk0d+saMtKfmw2ox9N/K7/q6FDNmWYdoK
         xVLaizDgcOeELRWDFt7EGAnUBdrUZGPZ+npSpUdcF7dcSIeYFUz5ZdYv16Pl+KRYNeGc
         gOrJgfN9Qj5bGJROSkll+pBaiitAopWAWX0a5aR2G4JAYl8/w5A/T5hwyistcm8a+QrH
         cCr67p70p3ylpQUUPAp1hJPCKCU/ASgRpeedhwuD2SVJxeby2ap8zop+oZkUU6mlO94w
         jV+h3um9RxKKA8+Z4WLXxHkp0O6yLXIj8OZWR9DGCzz/jROR7W4cn2cgyg3+7WPKco2i
         wFqw==
X-Gm-Message-State: AOAM531nM3pT89/j6E+mz+2dX69aNNmsiGLaChCDbEcB82rxZImre8JA
        JnWJpENi5MgC4qu9+bP73d1UwA==
X-Google-Smtp-Source: ABdhPJx9PtGSMahxBvYgIfDnPuhaXjNIxjih2vnsajIaVJz1hYOu4DDqJrglaHjOVQC1fRVIMDqoOg==
X-Received: by 2002:a17:90b:1b46:: with SMTP id nv6mr2449798pjb.178.1643259691459;
        Wed, 26 Jan 2022 21:01:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gx10sm878175pjb.7.2022.01.26.21.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 21:01:31 -0800 (PST)
Date:   Wed, 26 Jan 2022 21:01:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Akira Kawata <akirakawata1@gmail.com>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        lukas.bulwahn@gmail.com, kernel test robot <lkp@intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
Message-ID: <202201261955.F86F391@keescook>
References: <20211212232414.1402199-1-akirakawata1@gmail.com>
 <20211212232414.1402199-2-akirakawata1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212232414.1402199-2-akirakawata1@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 08:24:11AM +0900, Akira Kawata wrote:
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=197921
> 
> As pointed out in the discussion of buglink, we cannot calculate AT_PHDR
> as the sum of load_addr and exec->e_phoff.
> 
> : The AT_PHDR of ELF auxiliary vectors should point to the memory address
> : of program header. But binfmt_elf.c calculates this address as follows:
> :
> : NEW_AUX_ENT(AT_PHDR, load_addr + exec->e_phoff);
> :
> : which is wrong since e_phoff is the file offset of program header and
> : load_addr is the memory base address from PT_LOAD entry.
> :
> : The ld.so uses AT_PHDR as the memory address of program header. In normal
> : case, since the e_phoff is usually 64 and in the first PT_LOAD region, it
> : is the correct program header address.
> :
> : But if the address of program header isn't equal to the first PT_LOAD
> : address + e_phoff (e.g.  Put the program header in other non-consecutive
> : PT_LOAD region), ld.so will try to read program header from wrong address
> : then crash or use incorrect program header.
> 
> This is because exec->e_phoff
> is the offset of PHDRs in the file and the address of PHDRs in the
> memory may differ from it. This patch fixes the bug by calculating the
> address of program headers from PT_LOADs directly.
> 
> Signed-off-by: Akira Kawata <akirakawata1@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  fs/binfmt_elf.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index beeb1247b5c4..828e88841cb4 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -170,8 +170,8 @@ static int padzero(unsigned long elf_bss)
>  
>  static int
>  create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
> -		unsigned long load_addr, unsigned long interp_load_addr,
> -		unsigned long e_entry)
> +		unsigned long interp_load_addr,
> +		unsigned long e_entry, unsigned long phdr_addr)
>  {
>  	struct mm_struct *mm = current->mm;
>  	unsigned long p = bprm->p;
> @@ -257,7 +257,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>  	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
>  	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
>  	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
> -	NEW_AUX_ENT(AT_PHDR, load_addr + exec->e_phoff);
> +	NEW_AUX_ENT(AT_PHDR, phdr_addr);
>  	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
>  	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
>  	NEW_AUX_ENT(AT_BASE, interp_load_addr);
> @@ -822,7 +822,7 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
>  static int load_elf_binary(struct linux_binprm *bprm)
>  {
>  	struct file *interpreter = NULL; /* to shut gcc up */
> - 	unsigned long load_addr = 0, load_bias = 0;
> +	unsigned long load_addr, load_bias = 0, phdr_addr = 0;
>  	int load_addr_set = 0;
>  	unsigned long error;
>  	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
> @@ -1168,6 +1168,13 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  				reloc_func_desc = load_bias;
>  			}
>  		}
> +
> +		if (elf_ppnt->p_offset <= elf_ex->e_phoff &&
> +		    elf_ex->e_phoff < elf_ppnt->p_offset + elf_ppnt->p_filesz) {
> +			phdr_addr = elf_ex->e_phoff - elf_ppnt->p_offset +
> +				    elf_ppnt->p_vaddr;
> +		}

This chunk could really use a comment above it. Maybe something like:

/*
 * Figure out which segment in the file contains the Program
 * Header table, and map to the associated memory address.
 */

Some additional thoughts:

1) The ELF spec says e_phoff is 0 if there's no program header table.

The old code would just pass the load_addr as a result. This patch will
now retain the same result (phdr_addr defaults to 0). I wonder if there
is a bug in this behavior, though? (To be addressed in a different patch
if needed...)

2) This finds any matching segment, not just PT_PHDR, which is good,
since PT_PHDR isn't strictly required.

> +
>  		k = elf_ppnt->p_vaddr;
>  		if ((elf_ppnt->p_flags & PF_X) && k < start_code)
>  			start_code = k;
> @@ -1203,6 +1210,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	}
>  
>  	e_entry = elf_ex->e_entry + load_bias;
> +	phdr_addr += load_bias;
>  	elf_bss += load_bias;
>  	elf_brk += load_bias;
>  	start_code += load_bias;
> @@ -1266,8 +1274,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		goto out;
>  #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
>  
> -	retval = create_elf_tables(bprm, elf_ex,
> -			  load_addr, interp_load_addr, e_entry);
> +	retval = create_elf_tables(bprm, elf_ex, interp_load_addr,
> +				   e_entry, phdr_addr);
>  	if (retval < 0)
>  		goto out;

Looks good!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
