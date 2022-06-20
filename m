Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5420C550F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 06:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbiFTEpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 00:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiFTEpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 00:45:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A022B859
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 21:45:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 268D21042;
        Sun, 19 Jun 2022 21:45:32 -0700 (PDT)
Received: from [10.163.42.162] (unknown [10.163.42.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04BA53F7D7;
        Sun, 19 Jun 2022 21:45:28 -0700 (PDT)
Message-ID: <da75a2d1-afc5-b6ff-dce0-ef0b20dbfde0@arm.com>
Date:   Mon, 20 Jun 2022 10:15:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3 1/2] mm/mmap: Restrict generic protection_map[] array
 visibility
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, hch@infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20220616040924.1022607-2-anshuman.khandual@arm.com>
 <202206162004.ak9KTfMD-lkp@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <202206162004.ak9KTfMD-lkp@intel.com>
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


On 6/16/22 18:14, kernel test robot wrote:
> Hi Anshuman,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/mm-mmap-Drop-__SXXX-__PXXX-macros-from-across-platforms/20220616-121132
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220616/202206162004.ak9KTfMD-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/4eb89368b130fe235d5e587bcc2eec18bb688e2d
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Anshuman-Khandual/mm-mmap-Drop-__SXXX-__PXXX-macros-from-across-platforms/20220616-121132
>         git checkout 4eb89368b130fe235d5e587bcc2eec18bb688e2d
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/x86/include/asm/percpu.h:27,
>                     from arch/x86/include/asm/preempt.h:6,
>                     from include/linux/preempt.h:78,
>                     from include/linux/spinlock.h:55,
>                     from include/linux/mmzone.h:8,
>                     from include/linux/gfp.h:6,
>                     from include/linux/mm.h:7,
>                     from arch/x86/mm/mem_encrypt_amd.c:14:
>    arch/x86/mm/mem_encrypt_amd.c: In function 'sme_early_init':
>>> arch/x86/mm/mem_encrypt_amd.c:499:36: error: 'protection_map' undeclared (first use in this function)
>      499 |         for (i = 0; i < ARRAY_SIZE(protection_map); i++)
>          |                                    ^~~~~~~~~~~~~~
>    include/linux/kernel.h:55:33: note: in definition of macro 'ARRAY_SIZE'
>       55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>          |                                 ^~~
>    arch/x86/mm/mem_encrypt_amd.c:499:36: note: each undeclared identifier is reported only once for each function it appears in
>      499 |         for (i = 0; i < ARRAY_SIZE(protection_map); i++)
>          |                                    ^~~~~~~~~~~~~~
>    include/linux/kernel.h:55:33: note: in definition of macro 'ARRAY_SIZE'
>       55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>          |                                 ^~~
>    In file included from include/linux/bits.h:22,
>                     from include/linux/ratelimit_types.h:5,
>                     from include/linux/printk.h:9,
>                     from include/asm-generic/bug.h:22,
>                     from arch/x86/include/asm/bug.h:87,
>                     from include/linux/bug.h:5,
>                     from include/linux/mmdebug.h:5,
>                     from include/linux/mm.h:6,
>                     from arch/x86/mm/mem_encrypt_amd.c:14:
>    include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
>       16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>          |                                                   ^
>    include/linux/compiler.h:240:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
>      240 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>          |                                 ^~~~~~~~~~~~~~~~~
>    include/linux/kernel.h:55:59: note: in expansion of macro '__must_be_array'
>       55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>          |                                                           ^~~~~~~~~~~~~~~
>    arch/x86/mm/mem_encrypt_amd.c:499:25: note: in expansion of macro 'ARRAY_SIZE'
>      499 |         for (i = 0; i < ARRAY_SIZE(protection_map); i++)
>          |                         ^~~~~~~~~~

This patch fixes the build failure here.

diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index f6d038e2cd8e..d0c2ec1bb659 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -484,6 +484,8 @@ void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, boo
        enc_dec_hypercall(vaddr, npages, enc);
 }
 
+extern pgprot_t protection_map[16];
+
 void __init sme_early_init(void)
 {
        unsigned int i;
diff --git a/arch/x86/mm/pgprot.c b/arch/x86/mm/pgprot.c
index 7eca1b009af6..96eca0b2ec90 100644
--- a/arch/x86/mm/pgprot.c
+++ b/arch/x86/mm/pgprot.c
@@ -4,7 +4,7 @@
 #include <linux/mm.h>
 #include <asm/pgtable.h>
 
-static pgprot_t protection_map[16] __ro_after_init = {
+pgprot_t protection_map[16] __ro_after_init = {
        [VM_NONE]                                       = PAGE_NONE,
        [VM_READ]                                       = PAGE_READONLY,
        [VM_WRITE]                                      = PAGE_COPY,
