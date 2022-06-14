Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9F554A6F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353752AbiFNCnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353615AbiFNCm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:42:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EABC85159A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:21:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56A9A23A;
        Mon, 13 Jun 2022 19:20:39 -0700 (PDT)
Received: from [10.162.40.17] (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FE6E3F792;
        Mon, 13 Jun 2022 19:20:37 -0700 (PDT)
Message-ID: <27f29bb6-f82a-eefe-4774-0d2d1872482a@arm.com>
Date:   Tue, 14 Jun 2022 07:50:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2 2/2] mm/mmap: Drop generic protection_map[] array
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20220613053354.553579-3-anshuman.khandual@arm.com>
 <202206131716.tDWk9rLs-lkp@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <202206131716.tDWk9rLs-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/22 15:01, kernel test robot wrote:
> Hi Anshuman,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/mm-mmap-Drop-__SXXX-__PXXX-macros-from-across-platforms/20220613-133456
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> config: riscv-randconfig-r042-20220613 (https://download.01.org/0day-ci/archive/20220613/202206131716.tDWk9rLs-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/696f81b49f7b6316f652d795da4c0008efef4487
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Anshuman-Khandual/mm-mmap-Drop-__SXXX-__PXXX-macros-from-across-platforms/20220613-133456
>         git checkout 696f81b49f7b6316f652d795da4c0008efef4487
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> arch/riscv/mm/init.c:1224:59: error: 'PAGE_NONE' undeclared here (not in a function); did you mean 'SIGEV_NONE'?
>     1224 |         [VM_NONE]                                       = PAGE_NONE,
>          |                                                           ^~~~~~~~~
>          |                                                           SIGEV_NONE
>>> arch/riscv/mm/init.c:1225:59: error: 'PAGE_READ' undeclared here (not in a function); did you mean 'MAY_READ'?
>     1225 |         [VM_READ]                                       = PAGE_READ,
>          |                                                           ^~~~~~~~~
>          |                                                           MAY_READ
>>> arch/riscv/mm/init.c:1226:59: error: 'PAGE_COPY' undeclared here (not in a function)
>     1226 |         [VM_WRITE]                                      = PAGE_COPY,
>          |                                                           ^~~~~~~~~
>>> arch/riscv/mm/init.c:1228:59: error: 'PAGE_EXEC' undeclared here (not in a function); did you mean 'TASK_EXEC'?
>     1228 |         [VM_EXEC]                                       = PAGE_EXEC,
>          |                                                           ^~~~~~~~~
>          |                                                           TASK_EXEC
>>> arch/riscv/mm/init.c:1229:59: error: 'PAGE_READ_EXEC' undeclared here (not in a function); did you mean 'PAGE_KERNEL_EXEC'?
>     1229 |         [VM_EXEC | VM_READ]                             = PAGE_READ_EXEC,
>          |                                                           ^~~~~~~~~~~~~~
>          |                                                           PAGE_KERNEL_EXEC
>>> arch/riscv/mm/init.c:1230:59: error: 'PAGE_COPY_EXEC' undeclared here (not in a function); did you mean 'PAGE_KERNEL_EXEC'?
>     1230 |         [VM_EXEC | VM_WRITE]                            = PAGE_COPY_EXEC,
>          |                                                           ^~~~~~~~~~~~~~
>          |                                                           PAGE_KERNEL_EXEC
>>> arch/riscv/mm/init.c:1231:59: error: 'PAGE_COPY_READ_EXEC' undeclared here (not in a function)
>     1231 |         [VM_EXEC | VM_WRITE | VM_READ]                  = PAGE_COPY_READ_EXEC,
>          |                                                           ^~~~~~~~~~~~~~~~~~~
>>> arch/riscv/mm/init.c:1238:59: error: 'PAGE_SHARED_EXEC' undeclared here (not in a function); did you mean 'PAGE_SHARED'?
>     1238 |         [VM_SHARED | VM_EXEC | VM_WRITE]                = PAGE_SHARED_EXEC,
>          |                                                           ^~~~~~~~~~~~~~~~
>          |                                                           PAGE_SHARED
> 
> 
> vim +1224 arch/riscv/mm/init.c
> 
>   1222	
>   1223	pgprot_t protection_map[16] __ro_after_init = {
>> 1224		[VM_NONE]					= PAGE_NONE,
>> 1225		[VM_READ]					= PAGE_READ,
>> 1226		[VM_WRITE]					= PAGE_COPY,
>   1227		[VM_WRITE | VM_READ]				= PAGE_COPY,
>> 1228		[VM_EXEC]					= PAGE_EXEC,
>> 1229		[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
>> 1230		[VM_EXEC | VM_WRITE]				= PAGE_COPY_EXEC,
>> 1231		[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY_READ_EXEC,
>   1232		[VM_SHARED]					= PAGE_NONE,
>   1233		[VM_SHARED | VM_READ]				= PAGE_READ,
>   1234		[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
>   1235		[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
>   1236		[VM_SHARED | VM_EXEC]				= PAGE_EXEC,
>   1237		[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READ_EXEC,
>> 1238		[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED_EXEC,
> 

PAGE_XXXX[_YYYY] symbols on riscv are wrapped around with CONFIG_MMU, just
moving protection_map[] to appropriate place with CONFIG_MMU assert solves
this build problem.

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 5e4ed43f0d79..84ee476ba4a4 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -288,6 +288,25 @@ static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAG
 #define early_pg_dir           ((pgd_t *)XIP_FIXUP(early_pg_dir))
 #endif /* CONFIG_XIP_KERNEL */
 
+pgprot_t protection_map[16] __ro_after_init = {
+       [VM_NONE]                                       = PAGE_NONE,
+       [VM_READ]                                       = PAGE_READ,
+       [VM_WRITE]                                      = PAGE_COPY,
+       [VM_WRITE | VM_READ]                            = PAGE_COPY,
+       [VM_EXEC]                                       = PAGE_EXEC,
+       [VM_EXEC | VM_READ]                             = PAGE_READ_EXEC,
+       [VM_EXEC | VM_WRITE]                            = PAGE_COPY_EXEC,
+       [VM_EXEC | VM_WRITE | VM_READ]                  = PAGE_COPY_READ_EXEC,
+       [VM_SHARED]                                     = PAGE_NONE,
+       [VM_SHARED | VM_READ]                           = PAGE_READ,
+       [VM_SHARED | VM_WRITE]                          = PAGE_SHARED,
+       [VM_SHARED | VM_WRITE | VM_READ]                = PAGE_SHARED,
+       [VM_SHARED | VM_EXEC]                           = PAGE_EXEC,
+       [VM_SHARED | VM_EXEC | VM_READ]                 = PAGE_READ_EXEC,
+       [VM_SHARED | VM_EXEC | VM_WRITE]                = PAGE_SHARED_EXEC,
+       [VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]      = PAGE_SHARED_EXEC
+};
+
 void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 {
        unsigned long addr = __fix_to_virt(idx);
@@ -1219,22 +1238,3 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
        return vmemmap_populate_basepages(start, end, node, NULL);
 }
 #endif
-
-pgprot_t protection_map[16] __ro_after_init = {
-       [VM_NONE]                                       = PAGE_NONE,
-       [VM_READ]                                       = PAGE_READ,
-       [VM_WRITE]                                      = PAGE_COPY,
-       [VM_WRITE | VM_READ]                            = PAGE_COPY,
-       [VM_EXEC]                                       = PAGE_EXEC,
-       [VM_EXEC | VM_READ]                             = PAGE_READ_EXEC,
-       [VM_EXEC | VM_WRITE]                            = PAGE_COPY_EXEC,
-       [VM_EXEC | VM_WRITE | VM_READ]                  = PAGE_COPY_READ_EXEC,
-       [VM_SHARED]                                     = PAGE_NONE,
-       [VM_SHARED | VM_READ]                           = PAGE_READ,
-       [VM_SHARED | VM_WRITE]                          = PAGE_SHARED,
-       [VM_SHARED | VM_WRITE | VM_READ]                = PAGE_SHARED,
-       [VM_SHARED | VM_EXEC]                           = PAGE_EXEC,
-       [VM_SHARED | VM_EXEC | VM_READ]                 = PAGE_READ_EXEC,
-       [VM_SHARED | VM_EXEC | VM_WRITE]                = PAGE_SHARED_EXEC,
-       [VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]      = PAGE_SHARED_EXEC
-};
