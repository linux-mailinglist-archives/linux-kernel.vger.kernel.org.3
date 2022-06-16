Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE3654DDE1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376491AbiFPJIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359247AbiFPJIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:08:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2409B4756F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qrHyXuJPKZh7ZM1zFO0NX5HEyIc3Jst88sq5+SSmSzQ=; b=hRDKrI5OemVxkmWh4VTAQCIF2L
        RS2ide6shPXTGW3WD5apsQiPVhE69HyE2GW+IrJVOzabgDRnttRkJ4ojYIz6eRSo9JS/k9rIIzHvc
        SNYCfhcnmC/VSYwv7r314UltRc9bLyrl43uguH1uaFofZLQr0pnD1mq1HyBOETypADrxALzs04PAb
        4AcdE7r4YnPogc+uA/+W6MiEuRZpKnBYu62Md1M6YXQGgTD/L899vi+mYDeG1+4u/P40hfK77D6R2
        pKabbnebKW4Z7HsKR+ePdL97RzlUK55/hWbE/OoDy3KBUOyRsKvRNaWbVEr82HjQ1LWZ1rCJpZkP6
        uAyjn0nQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1lU4-001ot2-JX; Thu, 16 Jun 2022 09:08:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 560E130023F;
        Thu, 16 Jun 2022 11:08:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C8042018EF8F; Thu, 16 Jun 2022 11:08:07 +0200 (CEST)
Date:   Thu, 16 Jun 2022 11:08:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, namit@vmware.com
Subject: Re: [PATCHv3 4/8] x86/mm: Handle LAM on context switch
Message-ID: <Yqry9+efzp6lml89@hirez.programming.kicks-ass.net>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-5-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610143527.22974-5-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 05:35:23PM +0300, Kirill A. Shutemov wrote:

> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index 4af5579c7ef7..5b93dad93ff4 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -86,6 +86,9 @@ struct tlb_state {
>  		unsigned long		last_user_mm_spec;
>  	};
>  
> +#ifdef CONFIG_X86_64
> +	u64 lam_cr3_mask;
> +#endif
>  	u16 loaded_mm_asid;
>  	u16 next_asid;
>  

Urgh.. so there's a comment there that states:

/*
 * 6 because 6 should be plenty and struct tlb_state will fit in two cache
 * lines.
 */
#define TLB_NR_DYN_ASIDS        6

And then look at tlb_state:

struct tlb_state {
	struct mm_struct *         loaded_mm;            /*     0     8 */
	union {
		struct mm_struct * last_user_mm;         /*     8     8 */
		long unsigned int  last_user_mm_spec;    /*     8     8 */
	};                                               /*     8     8 */
	u16                        loaded_mm_asid;       /*    16     2 */
	u16                        next_asid;            /*    18     2 */
	bool                       invalidate_other;     /*    20     1 */

	/* XXX 1 byte hole, try to pack */

	short unsigned int         user_pcid_flush_mask; /*    22     2 */
	long unsigned int          cr4;                  /*    24     8 */
	struct tlb_context         ctxs[6];              /*    32    96 */

	/* size: 128, cachelines: 2, members: 8 */
	/* sum members: 127, holes: 1, sum holes: 1 */
};

If you add that u64 as you do, you'll wreck all that.

Either use that one spare byte, or find room elsewhere I suppose.
