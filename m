Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207BE522E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244129AbiEKImQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244061AbiEKIlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:41:44 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCFC644D5;
        Wed, 11 May 2022 01:41:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VCvCvO-_1652258498;
Received: from 30.30.99.144(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCvCvO-_1652258498)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 May 2022 16:41:39 +0800
Message-ID: <0009a4cd-2826-e8be-e671-f050d4f18d5d@linux.alibaba.com>
Date:   Wed, 11 May 2022 16:42:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: linux-next: build failure after merge of the mm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220511181531.7f27a5c1@canb.auug.org.au>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220511181531.7f27a5c1@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/2022 4:15 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (sparc64 defconfig)
> failed like this:
> 
> In file included from include/linux/hugetlb.h:757,
>                   from arch/sparc/mm/hugetlbpage.c:11:
> arch/sparc/include/asm/hugetlb.h: In function 'huge_ptep_clear_flush':
> arch/sparc/include/asm/hugetlb.h:27:1: error: no return statement in function returning non-void [-Werror=return-type]
>     27 | }
>        | ^
> 
> (and many more)
> 
> Caused by commit
> 
>    083af99303b9 ("mm: change huge_ptep_clear_flush() to return the original pte")
> 
> I applied the following hack to make it build.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 11 May 2022 18:10:56 +1000
> Subject: [PATCH] fix up for "mm: change huge_ptep_clear_flush() to return the original pte"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Sorry again. I think I also missed other ARCHs' changes. Need include 
below fixes.

diff --git a/arch/ia64/include/asm/hugetlb.h 
b/arch/ia64/include/asm/hugetlb.h
index 65d3811..026ead4 100644
--- a/arch/ia64/include/asm/hugetlb.h
+++ b/arch/ia64/include/asm/hugetlb.h
@@ -26,6 +26,7 @@ static inline int is_hugepage_only_range(struct 
mm_struct *mm,
  static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
                                           unsigned long addr, pte_t *ptep)
  {
+       return *ptep;
  }

  #include <asm-generic/hugetlb.h>
diff --git a/arch/parisc/include/asm/hugetlb.h 
b/arch/parisc/include/asm/hugetlb.h
index 25bc560..f7f078c 100644
--- a/arch/parisc/include/asm/hugetlb.h
+++ b/arch/parisc/include/asm/hugetlb.h
@@ -31,6 +31,7 @@ static inline int prepare_hugepage_range(struct file 
*file,
  static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
                                           unsigned long addr, pte_t *ptep)
  {
+       return *ptep;
  }

  #define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
index e727cc9..4d3ba39 100644
--- a/arch/sh/include/asm/hugetlb.h
+++ b/arch/sh/include/asm/hugetlb.h
@@ -24,6 +24,7 @@ static inline int prepare_hugepage_range(struct file 
*file,
  static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
                                           unsigned long addr, pte_t *ptep)
  {
+       return *ptep;
  }

  static inline void arch_clear_hugepage_flags(struct page *page)
diff --git a/arch/sparc/include/asm/hugetlb.h 
b/arch/sparc/include/asm/hugetlb.h
index b50aa6f..0a26cca 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -24,6 +24,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, 
unsigned long addr,
  static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
                                           unsigned long addr, pte_t *ptep)
  {
+       return *ptep;
  }

  #define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT

> ---
>   arch/sparc/include/asm/hugetlb.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
> index b50aa6f8f9ab..0a26cca24232 100644
> --- a/arch/sparc/include/asm/hugetlb.h
> +++ b/arch/sparc/include/asm/hugetlb.h
> @@ -24,6 +24,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
>   static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>   					  unsigned long addr, pte_t *ptep)
>   {
> +	return *ptep;
>   }
>   
>   #define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
