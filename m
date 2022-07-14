Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDE1575634
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbiGNUMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGNUMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:12:45 -0400
Received: from www.kot-begemot.co.uk (ivanoab7.miniserver.com [37.128.132.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B8E40BFB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:12:42 -0700 (PDT)
Received: from [192.168.18.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1oC5C4-0009zM-Sz; Thu, 14 Jul 2022 20:12:21 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1oC5Bx-006COF-6k; Thu, 14 Jul 2022 21:12:14 +0100
Message-ID: <3e1e7b85-f868-3f7b-6b31-2cdd0330eea1@cambridgegreys.com>
Date:   Thu, 14 Jul 2022 21:12:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] um: Replace to_phys() and to_virt() with less generic
 function names
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Richard Weinberger <richard@nod.at>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220714184600.3981953-1-linux@roeck-us.net>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <20220714184600.3981953-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.0
X-Spam-Score: -0.9
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2022 19:46, Guenter Roeck wrote:
> to_virt() and to_phys() are very generic and may be defined by drivers.
> As it turns out, commit 9409c9b6709e ("pmem: refactor pmem_clear_poison()")
> did exactly that. This results in build errors such as the following
> when trying to build um:allmodconfig.
> 
> drivers/nvdimm/pmem.c: In function ‘pmem_dax_zero_page_range’:
> ./arch/um/include/asm/page.h:105:20: error:
> 			too few arguments to function ‘to_phys’
>    105 | #define __pa(virt) to_phys((void *) (unsigned long) (virt))
>        |                    ^~~~~~~
> 
> Use less generic function names for the um specific to_phys() and to_virt()
> functions to fix the problem and to avoid similar problems in the future.
> 
> Fixes: 9409c9b6709e ("pmem: refactor pmem_clear_poison()")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   arch/um/include/asm/page.h      | 4 ++--
>   arch/um/include/shared/mem.h    | 4 ++--
>   arch/um/os-Linux/skas/process.c | 6 +++---
>   3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
> index 95af12e82a32..cdbd9653aa14 100644
> --- a/arch/um/include/asm/page.h
> +++ b/arch/um/include/asm/page.h
> @@ -102,8 +102,8 @@ extern unsigned long uml_physmem;
>    * casting is the right thing, but 32-bit UML can't have 64-bit virtual
>    * addresses
>    */
> -#define __pa(virt) to_phys((void *) (unsigned long) (virt))
> -#define __va(phys) to_virt((unsigned long) (phys))
> +#define __pa(virt) uml_to_phys((void *) (unsigned long) (virt))
> +#define __va(phys) uml_to_virt((unsigned long) (phys))
>   
>   #define phys_to_pfn(p) ((p) >> PAGE_SHIFT)
>   #define pfn_to_phys(pfn) PFN_PHYS(pfn)
> diff --git a/arch/um/include/shared/mem.h b/arch/um/include/shared/mem.h
> index 4862c91d4213..98aacd544108 100644
> --- a/arch/um/include/shared/mem.h
> +++ b/arch/um/include/shared/mem.h
> @@ -9,12 +9,12 @@
>   extern int phys_mapping(unsigned long phys, unsigned long long *offset_out);
>   
>   extern unsigned long uml_physmem;
> -static inline unsigned long to_phys(void *virt)
> +static inline unsigned long uml_to_phys(void *virt)
>   {
>   	return(((unsigned long) virt) - uml_physmem);
>   }
>   
> -static inline void *to_virt(unsigned long phys)
> +static inline void *uml_to_virt(unsigned long phys)
>   {
>   	return((void *) uml_physmem + phys);
>   }
> diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
> index 87d3129e7362..c316c993a949 100644
> --- a/arch/um/os-Linux/skas/process.c
> +++ b/arch/um/os-Linux/skas/process.c
> @@ -251,7 +251,7 @@ static int userspace_tramp(void *stack)
>   	signal(SIGTERM, SIG_DFL);
>   	signal(SIGWINCH, SIG_IGN);
>   
> -	fd = phys_mapping(to_phys(__syscall_stub_start), &offset);
> +	fd = phys_mapping(uml_to_phys(__syscall_stub_start), &offset);
>   	addr = mmap64((void *) STUB_CODE, UM_KERN_PAGE_SIZE,
>   		      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
>   	if (addr == MAP_FAILED) {
> @@ -261,7 +261,7 @@ static int userspace_tramp(void *stack)
>   	}
>   
>   	if (stack != NULL) {
> -		fd = phys_mapping(to_phys(stack), &offset);
> +		fd = phys_mapping(uml_to_phys(stack), &offset);
>   		addr = mmap((void *) STUB_DATA,
>   			    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
>   			    MAP_FIXED | MAP_SHARED, fd, offset);
> @@ -534,7 +534,7 @@ int copy_context_skas0(unsigned long new_stack, int pid)
>   	struct stub_data *data = (struct stub_data *) current_stack;
>   	struct stub_data *child_data = (struct stub_data *) new_stack;
>   	unsigned long long new_offset;
> -	int new_fd = phys_mapping(to_phys((void *)new_stack), &new_offset);
> +	int new_fd = phys_mapping(uml_to_phys((void *)new_stack), &new_offset);
>   
>   	/*
>   	 * prepare offset and fd of child's stack as argument for parent's

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
