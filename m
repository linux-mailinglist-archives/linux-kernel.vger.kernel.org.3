Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD7A535812
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 05:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbiE0Dgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 23:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiE0DgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 23:36:22 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2479313;
        Thu, 26 May 2022 20:36:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VEVWECf_1653622574;
Received: from 30.32.82.202(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VEVWECf_1653622574)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 May 2022 11:36:16 +0800
Message-ID: <ac245d62-2295-8cf6-6808-4a6eb6bdbd21@linux.alibaba.com>
Date:   Fri, 27 May 2022 11:36:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: mm: change huge_ptep_clear_flush() to return the original pte
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CA+G9fYtDBZaBGkEp5tRMM5C1xHEKeyyNK1S4WoKvrOoFxGm4KQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CA+G9fYtDBZaBGkEp5tRMM5C1xHEKeyyNK1S4WoKvrOoFxGm4KQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/27/2022 10:56 AM, Naresh Kamboju wrote:
> Following build failures noticed on arm64 on Linux mainline tree.
> 
> Which was detected and discussed at this email thread.
> https://lore.kernel.org/all/20220512193855.4f6ce32f@canb.auug.org.au/T/
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build errors:
> arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_clear_flush':
> arch/arm64/mm/hugetlbpage.c:515:16: error: implicit declaration of
> function 'get_clear_flush'; did you mean 'ptep_clear_flush'?
> [-Werror=implicit-function-declaration]
>    515 |         return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>        |                ^~~~~~~~~~~~~~~
>        |                ptep_clear_flush
> arch/arm64/mm/hugetlbpage.c:515:16: error: incompatible types when
> returning type 'int' but 'pte_t' was expected
>    515 |         return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>        |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/arm64/mm/hugetlbpage.c:516:1: error: control reaches end of
> non-void function [-Werror=return-type]
>    516 | }
>        | ^
> cc1: some warnings being treated as errors
> 
> metadata:
>      git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
>      git_describe: v5.18-9901-g7f50d4dfe816
>      git_sha: 7f50d4dfe816dd916a7cbf39039674825c2b388b
>      git_short_log: 7f50d4dfe816 (\Merge tag 'for-linus' of
> https://github.com/openrisc/linux\)
>      target_arch: arm64
>      toolchain: gcc-11

That is caused by commit:

00df1f1a133b ("mm: change huge_ptep_clear_flush() to return the original 
pte")

interacting with commit:

fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from get_clear_flush()")

And Catalin has fixed the conflict with below changes [1], not sure why 
it is not merged.

Linus, should I send a proper patch to fix this conflict for you?

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 30f5b76aabe9..9a999550df8e 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -485,12 +485,15 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct 
*vma,
  {
  	size_t pgsize;
  	int ncontig;
+	pte_t orig_pte;

  	if (!pte_cont(READ_ONCE(*ptep)))
  		return ptep_clear_flush(vma, addr, ptep);

  	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
-	return get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
+	orig_pte = get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
+	flush_tlb_range(vma, addr, addr + pgsize * ncontig);
+	return orig_pte;
  }

[1] https://lore.kernel.org/all/YnzqffV7STYS24Yn@arm.com/
