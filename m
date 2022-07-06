Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA6D567D80
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 06:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiGFEu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 00:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGFEu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 00:50:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B4CEEE0C;
        Tue,  5 Jul 2022 21:50:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B94B152B;
        Tue,  5 Jul 2022 21:50:53 -0700 (PDT)
Received: from [10.163.43.16] (unknown [10.163.43.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B20893F70D;
        Tue,  5 Jul 2022 21:50:50 -0700 (PDT)
Message-ID: <ef6ee347-4248-9f06-f1a1-9f18613e97dc@arm.com>
Date:   Wed, 6 Jul 2022 10:20:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] xtensa: noMMU: fix vm_get_page_prot definition
Content-Language: en-US
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220705221411.3381797-1-jcmvbkbc@gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220705221411.3381797-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Max,

I could reproduce the build failure with nommu_kc705_defconfig.

On 7/6/22 03:44, Max Filippov wrote:
> Don't define protection_map and don't use DECLARE_VM_GET_PAGE_PROT in
> noMMU configs, because in that case the definition for vm_get_page_prot
> is provided by the include/linux/mm.h

Right, a fallback (!CONFIG_MMU) stub definition is provided there.
 
> 
> Fixes: 61ab8053710f ("xtensa/mm: enable ARCH_HAS_VM_GET_PAGE_PROT")
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  arch/xtensa/mm/init.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
> index fb830ec8183c..b2587a1a7c46 100644
> --- a/arch/xtensa/mm/init.c
> +++ b/arch/xtensa/mm/init.c
> @@ -217,6 +217,7 @@ static int __init parse_memmap_opt(char *str)
>  }
>  early_param("memmap", parse_memmap_opt);
>  
> +#ifdef CONFIG_MMU
>  static const pgprot_t protection_map[16] = {
>  	[VM_NONE]					= PAGE_NONE,
>  	[VM_READ]					= PAGE_READONLY,
> @@ -236,3 +237,4 @@ static const pgprot_t protection_map[16] = {
>  	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED_EXEC
>  };
>  DECLARE_VM_GET_PAGE_PROT
> +#endif

LGTM and fixes the build problem.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewing CONFIG_MMU dependency for other platforms ....

* powerpc    - No CONFIG_MMU found - config MMU - bool default y
* sparc      - No CONFIG_MMU found - config MMU - bool default y
* arm64      - No CONFIG_MMU found - config MMU - bool default y
* x86        - No CONFIG_MMU found - config MMU - bool default y
* microblaze - No CONFIG_MMU found - config MMU - bool default y
* loongarch  - No CONFIG_MMU found - config MMU - bool default y
* openrisc   - No CONFIG_MMU found - config MMU - bool default y
* xtensa     - This fix here
* hexagon    - No CONFIG_MMU found - config MMU - bool default y
* parisc     - No CONFIG_MMU found - config MMU - bool default y
* alpha      - No CONFIG_MMU found - config MMU - bool default y
* nios2      - No CONFIG_MMU found - config MMU - bool default y
* riscv	     - Both protection_map[] and DECLARE_VM_GET_PAGE_PROT
               are inside CONFIG_MMU
* csky       - No CONFIG_MMU found - config MMU - bool default y
* s390       - No CONFIG_MMU found - config MMU - bool default y
* ia64       - No CONFIG_MMU found - config MMU - bool default y
* mips       - No CONFIG_MMU found - config MMU - bool default y
* m68k	     - Both protection_map[] and DECLARE_VM_GET_PAGE_PROT
               are inside CONFIG_MMU (SUN3, MOTOROLA, COLDFIRE)
* arc        - No CONFIG_MMU found - config MMU - bool default y
* arm	     - Both protection_map[] and DECLARE_VM_GET_PAGE_PROT
               are inside CONFIG_MMU
* um         - No CONFIG_MMU found - config MMU - bool default y
* sh	     - Both protection_map[] and DECLARE_VM_GET_PAGE_PROT
               needs to be moved inside CONFIG_MMU, will send a
	       patch soon.

So apart from xtensa and sh, no other platform seems to have this
CONFIG_MMU related build problem. But please do let me know if I
might have missed something.

- Anshuman
