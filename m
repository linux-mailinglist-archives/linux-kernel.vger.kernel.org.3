Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAE8538C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244733AbiEaIDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244720AbiEaIDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:03:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7CC9155E;
        Tue, 31 May 2022 01:03:14 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24V7pnxE010470;
        Tue, 31 May 2022 07:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=fCDCNg9Fl0rDsWI5cVbkr7yPCpu4aY2vi3Um9DXKuyo=;
 b=TwuPNcBR4U1XYDHdlIDZYKqcL5KJT69oeeTAf0vy5m7ooDBj90SBRisXK63xMXHvK8l0
 Ov/cquTEsxXxBim+UukTU2rsQcn6NprZ4HWRN68SlwYgZXcr9qZgM89RGc6MwoI/bqEL
 o6GOS/aiaC9dqiy4ahWeqSt5T6xN5hmciCI34Qmd0QVrEU1vbyvV2QBCOIg+JzaMgATb
 8jaFh0BsNFxNOHSjg3UgeRvf/2N2Wujv9geXH5fdOj7Ye52btvKTOJPDKvku8NHfDMem
 dO2O0Q0YLPZWYG0qyBQJvfeeNv5XIulDxvgh2q56ULI3MONZBMZ+0s0xvmHu5XqW+/Ip CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gdf0hr3k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 07:59:47 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24V7qjhT012512;
        Tue, 31 May 2022 07:59:46 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gdf0hr3jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 07:59:46 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24V7rKjg027282;
        Tue, 31 May 2022 07:59:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3gbbynkrfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 07:59:44 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24V7xfmo55443962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 07:59:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FAF642041;
        Tue, 31 May 2022 07:59:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B44A34203F;
        Tue, 31 May 2022 07:59:38 +0000 (GMT)
Received: from osiris (unknown [9.145.72.89])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 31 May 2022 07:59:38 +0000 (GMT)
Date:   Tue, 31 May 2022 09:59:37 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Stafford Horne <shorne@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Brian Cain <bcain@quicinc.com>, x86@kernel.org,
        linux-parisc@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Richard Weinberger <richard@nod.at>,
        linux-hexagon@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Janosch Frank <frankja@linux.ibm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-ia64@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Russell King <linux@armlinux.org.uk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jonas Bonn <jonas@southpole.se>, sparclinux@vger.kernel.org,
        linux-csky@vger.kernel.org, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-um@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>,
        Matt Turner <mattst88@gmail.com>,
        linux-m68k@lists.linux-m68k.org, Paul Mackerras <paulus@samba.org>,
        linux-xtensa@linux-xtensa.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Hildenbrand <david@redhat.com>,
        openrisc@lists.librecores.org,
        linux-arm-kernel@lists.infradead.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Chris Zankel <chris@zankel.net>,
        Hugh Dickins <hughd@google.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rich Felker <dalias@libc.org>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andy Lutomirski <luto@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-snps-arc@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v5] mm: Avoid unnecessary page fault retires on shared
 memory types
Message-ID: <YpXK6VO8y6ZQlimG@osiris>
References: <20220530183450.42886-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530183450.42886-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RLhB66egEP1T9U1MkMA8rdmyk-WXjxeE
X-Proofpoint-ORIG-GUID: ToZrP-uDPxbUpDXuMZf7xPxYmVzsS7TL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_02,2022-05-30_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205310038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 02:34:50PM -0400, Peter Xu wrote:
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
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Vineet Gupta <vgupta@kernel.org>
> Acked-by: Guo Ren <guoren@kernel.org>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
...
>  arch/s390/mm/fault.c          | 12 ++++++++++++
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index e173b6187ad5..973dcd05c293 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -433,6 +433,17 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  			goto out_up;
>  		goto out;
>  	}
> +
> +	/* The fault is fully completed (including releasing mmap lock) */
> +	if (fault & VM_FAULT_COMPLETED) {
> +		if (gmap) {
> +			mmap_read_lock(mm);
> +			goto out_gmap;
> +		}
> +		fault = 0;
> +		goto out;
> +	}
> +
>  	if (unlikely(fault & VM_FAULT_ERROR))
>  		goto out_up;
>  
> @@ -452,6 +463,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  		mmap_read_lock(mm);
>  		goto retry;
>  	}
> +out_gmap:
>  	if (IS_ENABLED(CONFIG_PGSTE) && gmap) {
>  		address =  __gmap_link(gmap, current->thread.gmap_addr,
>  				       address);

FWIW:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
