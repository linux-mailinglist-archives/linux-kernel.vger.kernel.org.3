Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6525AE346
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbiIFIoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239501AbiIFInb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:43:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A817A6555D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gRAbSu+qYZ/sJhD3A71yXMZFADBWv+Eht0jraA34zZ4=; b=Jfdik1W1RQN3C9DTIjLDt1yPyQ
        xrp/njvpvvpQGvRIoNSFZuoCgEUIkFtfq4uN4CVyijur36UsUyIlm7Z+yn8bI+3fA512uDEQ145Fc
        WdLNav/S5knTNwvCTFwMwbk5ucuY8UFbNP1ssklhydwR3JyLY9lC9bASRLUHTzn5Umw/qh+oaVmmv
        mLaiiT+PGFhIdxtfwaubrfFiMGgS48nQKQ10po2jrN9eLv1sB7IJxWaqV5vRBMT3rXcXf7+mxzhgg
        kn2PmXuGvv34DdLA7hvUS54o3lnU8RDS9AHG5IyRWRDn0rjUdnV5vNiNMnpo4r1AFt/tF4xfvh21Z
        eMZtlx/g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVU7H-00AEiY-40; Tue, 06 Sep 2022 08:39:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CBCDD300244;
        Tue,  6 Sep 2022 10:39:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ADD5E209D2D1D; Tue,  6 Sep 2022 10:39:27 +0200 (CEST)
Date:   Tue, 6 Sep 2022 10:39:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Bharata B Rao <bharata@amd.com>, ananth.narayan@amd.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <YxcHP3WYNp0/lWS6@hirez.programming.kicks-ass.net>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <20220904010001.knlcejmw4lg2uzy3@box.shutemov.name>
 <64519d0b-b696-db47-52c2-303451e10c09@amd.com>
 <20220905134457.a2f7uluq42frsgwe@box.shutemov.name>
 <YxYIAVx2qJLMDJlC@hirez.programming.kicks-ass.net>
 <20220905153517.k6ctaqqtkcyu2zmn@box.shutemov.name>
 <YxYZ6Q+JVg79aDNS@hirez.programming.kicks-ass.net>
 <20220905164708.ewx5lulbqdjrk3mx@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905164708.ewx5lulbqdjrk3mx@box.shutemov.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 07:47:08PM +0300, Kirill A. Shutemov wrote:

> Fair enough. How about this?
> 
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 803241dfc473..1a03c65a9c0f 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -22,6 +22,8 @@ static inline bool pagefault_disabled(void);
>  #endif
>  
>  #ifdef CONFIG_X86_64
> +DECLARE_STATIC_KEY_FALSE(tagged_addr_key);
> +
>  /*
>   * Mask out tag bits from the address.
>   *
> @@ -30,8 +32,10 @@ static inline bool pagefault_disabled(void);
>   */
>  #define untagged_addr(mm, addr)	({					\
>  	u64 __addr = (__force u64)(addr);				\
> -	s64 sign = (s64)__addr >> 63;					\
> -	__addr &= (mm)->context.untag_mask | sign;			\
> +	if (static_branch_unlikely(&tagged_addr_key)) {			\
> +		s64 sign = (s64)__addr >> 63;				\
> +		__addr &= (mm)->context.untag_mask | sign;		\
> +	}								\
>  	(__force __typeof__(addr))__addr;				\
>  })
>  
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 337f80a0862f..63194bf43c9a 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -742,6 +742,9 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
>  }
>  #endif
>  
> +DEFINE_STATIC_KEY_FALSE(tagged_addr_key);

So here you use the: false-unlikely scenario which seems suboptimal in
this case, I was thinking the false-likely case would generate better
code (see the comment in linux/jump_label.h).

> +EXPORT_SYMBOL_GPL(tagged_addr_key);
> +
>  static void enable_lam_func(void *mm)
>  {
>  	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
> @@ -813,6 +816,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
>  	}
>  
>  	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
> +	static_branch_enable(&tagged_addr_key);
>  out:
>  	mutex_unlock(&mm->context.lock);
>  	mmap_write_unlock(mm);

Aside from the one nit above, this looks about right.
