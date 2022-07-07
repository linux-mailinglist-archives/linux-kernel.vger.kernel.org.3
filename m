Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9DE56A484
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiGGNwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbiGGNvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:51:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182754D4CE;
        Thu,  7 Jul 2022 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cHtPqf0EZi6Rmr2HnZOjOrCXsqzXZi//SFvwSsuDJxg=; b=HSq2FS0mqQIs+Q8D5ZU9Sfzo5y
        Y0+meYy1GAId0uW0Qfe0IafRM4UVJsLS12rsfb8JHVlmiYw8PqYYQw/2exCuPuB1wZ+GQyfE9sFZ8
        aUP1HqEnFahXi8DUojJjffY/uTGSyVPpFkwA47f+e+PP2Lxaux4gckd9gjazwICe/Jjbqh02KNJNN
        pEOGZliIuhyqCq34U94wK2EhcDpRwmz1wYiJvBPMc71rAmin8S0ELfj90xgEhFViQ+AsuctRpOXpw
        mxpY5/TAIG9fWOkn3ruzr2kEFVr57RPPkNJWkk9zj+fb8R/7G4i4POj5aDbwEHxq5VhMdWVutO/Ut
        1k7+rSkw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9Rsw-001IU7-Nf; Thu, 07 Jul 2022 13:49:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 908C3300872;
        Thu,  7 Jul 2022 15:49:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5083920CA4D3D; Thu,  7 Jul 2022 15:49:34 +0200 (CEST)
Date:   Thu, 7 Jul 2022 15:49:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, arnd@arndb.de,
        linux-kernel@vger.kernel.org, darren@os.amperecomputing.com,
        yangyicong@hisilicon.com, huzhanyuan@oppo.com, lipeifeng@oppo.com,
        zhangshiming@oppo.com, guojian@oppo.com, realmz6@gmail.com,
        Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 4/4] arm64: support batched/deferred tlb shootdown during
 page reclamation
Message-ID: <Ysbkbt7cvUWSShtc@hirez.programming.kicks-ass.net>
References: <20220707125242.425242-1-21cnbao@gmail.com>
 <20220707125242.425242-5-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707125242.425242-5-21cnbao@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 12:52:42AM +1200, Barry Song wrote:

> diff --git a/arch/arm64/include/asm/tlbbatch.h b/arch/arm64/include/asm/tlbbatch.h
> new file mode 100644
> index 000000000000..fedb0b87b8db
> --- /dev/null
> +++ b/arch/arm64/include/asm/tlbbatch.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ARCH_ARM64_TLBBATCH_H
> +#define _ARCH_ARM64_TLBBATCH_H
> +
> +struct arch_tlbflush_unmap_batch {
> +	/*
> +	 * For arm64, HW can do tlb shootdown, so we don't
> +	 * need to record cpumask for sending IPI
> +	 */
> +};
> +
> +#endif /* _ARCH_ARM64_TLBBATCH_H */
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 412a3b9a3c25..b3ed163267ca 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -272,6 +272,19 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
>  	dsb(ish);
>  }
>  
> +static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
> +					struct mm_struct *mm,
> +					struct vm_area_struct *vma,
> +					unsigned long uaddr)
> +{
> +	flush_tlb_page_nosync(vma, uaddr);
> +}

You're passing that vma along just to get the mm, that's quite silly and
trivially fixed.


diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 412a3b9a3c25..87505ecce1f0 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -254,17 +254,23 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 	dsb(ish);
 }
 
-static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
-					 unsigned long uaddr)
+static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
+					   unsigned long uaddr)
 {
 	unsigned long addr;
 
 	dsb(ishst);
-	addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
+	addr = __TLBI_VADDR(uaddr, ASID(mm));
 	__tlbi(vale1is, addr);
 	__tlbi_user(vale1is, addr);
 }
 
+static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
+					 unsigned long uaddr)
+{
+	return __flush_tlb_page_nosync(vma->vm_mm, uaddr);
+}
+
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				  unsigned long uaddr)
 {
