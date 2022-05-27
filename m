Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7585358D7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 07:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243226AbiE0Fjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 01:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiE0Fj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 01:39:29 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E08266AE2;
        Thu, 26 May 2022 22:39:28 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-f2bb84f9edso4657949fac.10;
        Thu, 26 May 2022 22:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2j31mgyTy2/RMpvPafIuRR/7M5aCsOn5pH1JxQKELh0=;
        b=WLF0ZKcKkqyL/2e9Vrm4jJIU7Iq70SjWVWeR4mG+diJpadGhfuylwbDWHZVjDdFbuq
         Hxc+zHrNjRLjtRhI1yhC+nolDKLNrwOV2/oaWTaoh4VCK67BB0z5yPlcOmnthCOgtmez
         8jkwQgYPNLUuG0ZEbUiSy7uVEpWFtrO5L4UM+4mbtXpWMiQIVZp0eLdp45xYgN9Jmvmc
         aulsD6JeO/TIOhvHj+bALfaW9BR7tPWEUeyaMI8bJbO4wOxVeH/I0lrHRJ+FP9F521BK
         /lEKp/SRZycKZGHLE0LZwkZV2trusLGaniTNIWTP9EnU7l+Xe/n5XI3K1uCmL30r4C8o
         Jgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2j31mgyTy2/RMpvPafIuRR/7M5aCsOn5pH1JxQKELh0=;
        b=BNbKxGUp6nZBq3hFA1YncaPUzKL8qpEIMs3rWgr6v39diaLCfFbRSX/wLlLoYjrgaW
         iZNzVm+zgE4EQ+gTr6TLlvLkeK31+Y/z17Iu5F9m56355jwvM+HPeG2nX3iFnpR6TNUw
         RR5uix6MwAd6t+cuFAb1Jh56gui+nozuUl4s+6Zg44S3BEYf4IBWJDRQouz+mDf5YMm+
         Z157VqCmh/Keg4Dt4xdZ2TQsT2jzunnPw51fxFzuKEOwgJa33Mby4oF6hR2TW8y2vgBx
         JCIT6f4nbPa8wmFDCHzjcRxJ+9/hrgxfMAKF6WMpfTx2OmXL5sX5IyT6SKEUpRAMzlq1
         rMUg==
X-Gm-Message-State: AOAM5320CJCnAsf0/QNp3+XFa0zxnHyh99tuedtHSSGS4Ff/eLQ0KYrA
        FNZ9Q1TKmZ+YoQxUbFrAUdNU/20eXVCw1BPniiw=
X-Google-Smtp-Source: ABdhPJy8+6PjRSs5xseRfaJdStvLUZHZV5vQKgs4hS+3gJJgloJJ42WfwmBmCJpVr7XfQyeK+DIvF8/HIUAjs0cVwxU=
X-Received: by 2002:a05:6870:5ba6:b0:f1:5840:f38e with SMTP id
 em38-20020a0568705ba600b000f15840f38emr3323758oab.210.1653629967367; Thu, 26
 May 2022 22:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220524234531.1949-1-peterx@redhat.com>
In-Reply-To: <20220524234531.1949-1-peterx@redhat.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 26 May 2022 22:39:15 -0700
Message-ID: <CAMo8BfJWzUnwPyWKsBsW2-x7t=Go5Mwb643kXm5BfpVDAeaeWA@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Avoid unnecessary page fault retires on shared
 memory types
To:     Peter Xu <peterx@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Richard Henderson <rth@twiddle.net>,
        David Hildenbrand <david@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michal Simek <monstr@monstr.eu>,
        Russell King <linux@armlinux.org.uk>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonas Bonn <jonas@southpole.se>, Will Deacon <will@kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        openrisc@lists.librecores.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Chris Zankel <chris@zankel.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        linux-csky@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Stafford Horne <shorne@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>, linux-mips@vger.kernel.org,
        Helge Deller <deller@gmx.de>, Vineet Gupta <vgupta@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-um@lists.infradead.org,
        "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dinh Nguyen <dinguyen@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-snps-arc@lists.infradead.org,
        Hugh Dickins <hughd@google.com>, Rich Felker <dalias@libc.org>,
        Andy Lutomirski <luto@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linuxppc-dev@lists.ozlabs.org, Brian Cain <bcain@quicinc.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 4:45 PM Peter Xu <peterx@redhat.com> wrote:
>
> I observed that for each of the shared file-backed page faults, we're very
> likely to retry one more time for the 1st write fault upon no page.  It's
> because we'll need to release the mmap lock for dirty rate limit purpose
> with balance_dirty_pages_ratelimited() (in fault_dirty_shared_page()).
>
> Then after that throttling we return VM_FAULT_RETRY.
>
> We did that probably because VM_FAULT_RETRY is the only way we can return
> to the fault handler at that time telling it we've released the mmap lock.
>
> However that's not ideal because it's very likely the fault does not need
> to be retried at all since the pgtable was well installed before the
> throttling, so the next continuous fault (including taking mmap read lock,
> walk the pgtable, etc.) could be in most cases unnecessary.
>
> It's not only slowing down page faults for shared file-backed, but also add
> more mmap lock contention which is in most cases not needed at all.
>
> To observe this, one could try to write to some shmem page and look at
> "pgfault" value in /proc/vmstat, then we should expect 2 counts for each
> shmem write simply because we retried, and vm event "pgfault" will capture
> that.
>
> To make it more efficient, add a new VM_FAULT_COMPLETED return code just to
> show that we've completed the whole fault and released the lock.  It's also
> a hint that we should very possibly not need another fault immediately on
> this page because we've just completed it.
>
> This patch provides a ~12% perf boost on my aarch64 test VM with a simple
> program sequentially dirtying 400MB shmem file being mmap()ed and these are
> the time it needs:
>
>   Before: 650.980 ms (+-1.94%)
>   After:  569.396 ms (+-1.38%)
>
> I believe it could help more than that.
>
> We need some special care on GUP and the s390 pgfault handler (for gmap
> code before returning from pgfault), the rest changes in the page fault
> handlers should be relatively straightforward.
>
> Another thing to mention is that mm_account_fault() does take this new
> fault as a generic fault to be accounted, unlike VM_FAULT_RETRY.
>
> I explicitly didn't touch hmm_vma_fault() and break_ksm() because they do
> not handle VM_FAULT_RETRY even with existing code, so I'm literally keeping
> them as-is.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>
> v3:
> - Rebase to akpm/mm-unstable
> - Copy arch maintainers
> ---

For xtensa:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
