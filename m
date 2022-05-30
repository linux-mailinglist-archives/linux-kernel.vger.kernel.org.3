Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724F75380DB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 16:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiE3Ntg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbiE3Nn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:43:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106C89AE40;
        Mon, 30 May 2022 06:32:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C90260F5E;
        Mon, 30 May 2022 13:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CBBC385B8;
        Mon, 30 May 2022 13:31:55 +0000 (UTC)
Date:   Mon, 30 May 2022 14:31:52 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        Matt Turner <mattst88@gmail.com>, linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Cain <bcain@quicinc.com>, Borislav Petkov <bp@alien8.de>,
        linux-alpha@vger.kernel.org, Alistair Popple <apopple@nvidia.com>,
        Jonas Bonn <jonas@southpole.se>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vgupta@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        Richard Henderson <rth@twiddle.net>,
        Guo Ren <guoren@kernel.org>, linux-parisc@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-um@lists.infradead.org, "H . Peter Anvin" <hpa@zytor.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        openrisc@lists.librecores.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-hexagon@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Stafford Horne <shorne@gmail.com>, linux-csky@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "David S . Miller" <davem@davemloft.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-riscv@lists.infradead.org, Max Filippov <jcmvbkbc@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Chris Zankel <chris@zankel.net>,
        Michal Simek <monstr@monstr.eu>, x86@kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Richard Weinberger <richard@nod.at>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4] mm: Avoid unnecessary page fault retires on shared
 memory types
Message-ID: <YpTHSNQxzQxwJ4vQ@arm.com>
References: <20220527193936.30678-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527193936.30678-1-peterx@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 03:39:36PM -0400, Peter Xu wrote:
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 77341b160aca..e401d416bbd6 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -607,6 +607,10 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
>  		return 0;
>  	}
>  
> +	/* The fault is fully completed (including releasing mmap lock) */
> +	if (fault & VM_FAULT_COMPLETED)
> +		return 0;
> +
>  	if (fault & VM_FAULT_RETRY) {
>  		mm_flags |= FAULT_FLAG_TRIED;
>  		goto retry;

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
