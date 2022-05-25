Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AD7533CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243122AbiEYMod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239352AbiEYMoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:44:24 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C9F9158D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:44:21 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b200so8203337qkc.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w0F6iR9EKs/zIprBUHWYk0xdfCPICb6b6FOC3ooI/Qg=;
        b=LMEKNyEIRYPV5QWJlwplZCx+Yze+80z3MALcLFPz5jKdddgbR28N/X6bo9Jvgd00MP
         WWkcUcb1+z91voFM8WjtduJpm5pvevvusNqH0PzjaxsPqwHpEmvLG6H17fO8d+8uqQ/c
         xW/rbo+trH8MjL1X/foXOCmesnHHx99Tmug43Nb91EXZFTR7KAdlglnJRYtL1NUTbXz5
         2CGVavB8u5eJ5bdNx8JVu0TNi6KB2NiCnWSVtKfIEdRU3i4wp/Kah2nDHcLAJXmplYfJ
         xzofRGg4rofGSre9mJv/qm1XS4Pms5gIR+r4L8hjS8Owdd3qkT56i/sicOD/din7w+oO
         VJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w0F6iR9EKs/zIprBUHWYk0xdfCPICb6b6FOC3ooI/Qg=;
        b=JpoHunza15nYa/LDPjqJmLcGtv8bP34udXxzDH8tN3TDFhtgOtRdMI73UuAhcN2/KQ
         D6cOmPEyoUFNwsPS8fIqcwNpL9+d0MLuhwyUIWolDlVZnYyRX7fY52teXi8Nc0ri2Goa
         azBDkfSZcTXyP8OJ7aIReDfaMEgFk78+88qSxgwQ3Cz/X91w7H1p0vb+m04VkH8qZT3Z
         kLqTNI6XS+59VO/fOvamvobE4siQY9s56p+7jzwIYGcL/mDlUCxhoEmvfMXnHRO32r/0
         8V1JZjFAsqM90W2dfTiwdA1mOrX3B9sYg+0Xn0V28O8tai2nPYmmguIo+Rf+TXxDKDK+
         wndQ==
X-Gm-Message-State: AOAM531H01ASvRWNGHQ2tOoDke+6g4L0yPEQWQw1ClvkZuZHq2ySt5gV
        djIFu3kSMN2ILXLZLbveCiLPxQ==
X-Google-Smtp-Source: ABdhPJx/POKWSCbmzd2neCxXDwISwEb1wGzjcuEavupLeI/smDQTCNVGAU9PwpCoNv+A6qxiW2wj4Q==
X-Received: by 2002:a05:620a:4047:b0:6a0:5dae:ad67 with SMTP id i7-20020a05620a404700b006a05daead67mr19946570qko.530.1653482659851;
        Wed, 25 May 2022 05:44:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:741f])
        by smtp.gmail.com with ESMTPSA id g25-20020ac870d9000000b002f9433ed963sm1207797qtp.64.2022.05.25.05.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:44:19 -0700 (PDT)
Date:   Wed, 25 May 2022 08:44:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Richard Henderson <rth@twiddle.net>,
        David Hildenbrand <david@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michal Simek <monstr@monstr.eu>,
        Russell King <linux@armlinux.org.uk>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-riscv@lists.infradead.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonas Bonn <jonas@southpole.se>, Will Deacon <will@kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        openrisc@lists.librecores.org, linux-s390@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        linux-m68k@lists.linux-m68k.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Chris Zankel <chris@zankel.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        sparclinux@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Stafford Horne <shorne@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-xtensa@linux-xtensa.org, Nicholas Piggin <npiggin@gmail.com>,
        linux-sh@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>, linux-mips@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>,
        Helge Deller <deller@gmx.de>, Vineet Gupta <vgupta@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-um@lists.infradead.org, linux-alpha@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-ia64@vger.kernel.org,
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
        linux-parisc@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3] mm: Avoid unnecessary page fault retires on shared
 memory types
Message-ID: <Yo4kojxZfjNiZI7/@cmpxchg.org>
References: <20220524234531.1949-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524234531.1949-1-peterx@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 07:45:31PM -0400, Peter Xu wrote:
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

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
