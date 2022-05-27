Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713A85362C7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352535AbiE0Mlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352529AbiE0Mjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:39:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839482CE07;
        Fri, 27 May 2022 05:26:28 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RATwTb021454;
        Fri, 27 May 2022 12:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=RVk/+c6nPK5D2qeDI0zLbVO1lqN1tQYD0TzNeMii76M=;
 b=CdGIqDdzBXd3h2dRHpL1DShFdmTRQ/K3BNoowjsJ7U4uRWdEUL24qUkp9B9CCe4qwI1x
 ueMHE+3+v1uC7fMJZdhALNq0R69QTPr2X7t7hmmcYdqjvUF+dOgF+KjoQRzbmFzsymwU
 4TRs+Fcb59XpwhBMszKHjkfxh5jERETh0DSQF2mQOARMUdDnfiEcL/AxzL9Ab0Nz2WHK
 SDNr7raIw4jjkxtIKRrkZp9dwvFLuLsudS4hJ9Ynj7wBxCmCSFMaztPXonoUGxJ1hjXA
 3uotVOEbohqQcj6NjHHndqMeFT50tNx88feHmMQrikGztx2louDZC2dPTlWt2pNYYxwq Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gavxnsywe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:23:53 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24RBpM9d025770;
        Fri, 27 May 2022 12:23:52 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gavxnsyvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:23:52 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24RCLTLO021408;
        Fri, 27 May 2022 12:23:49 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3g9ucga110-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:23:49 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24RCNkSu32899416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 12:23:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 225BAAE04D;
        Fri, 27 May 2022 12:23:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0D99AE045;
        Fri, 27 May 2022 12:23:43 +0000 (GMT)
Received: from osiris (unknown [9.145.57.114])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 27 May 2022 12:23:43 +0000 (GMT)
Date:   Fri, 27 May 2022 14:23:42 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
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
        Johannes Weiner <hannes@cmpxchg.org>,
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
        "David S . Miller" <davem@davemloft.net>,
        Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3] mm: Avoid unnecessary page fault retires on shared
 memory types
Message-ID: <YpDCzvLER9AYJJc8@osiris>
References: <20220524234531.1949-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524234531.1949-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B856HEmp0-oPmnQmmWvfQf-2fQL_698C
X-Proofpoint-GUID: YnY8uuN2fOATVDxq6iTcIl1znLlGk8-q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_03,2022-05-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205270057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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
...
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index e173b6187ad5..9503a7cfaf03 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -339,6 +339,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  	unsigned long address;
>  	unsigned int flags;
>  	vm_fault_t fault;
> +	bool need_unlock = true;
>  	bool is_write;
>  
>  	tsk = current;
> @@ -433,6 +434,13 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  			goto out_up;
>  		goto out;
>  	}
> +
> +	/* The fault is fully completed (including releasing mmap lock) */
> +	if (fault & VM_FAULT_COMPLETED) {
> +		need_unlock = false;
> +		goto out_gmap;
> +	}
> +
>  	if (unlikely(fault & VM_FAULT_ERROR))
>  		goto out_up;
>  
> @@ -452,6 +460,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  		mmap_read_lock(mm);
>  		goto retry;
>  	}
> +out_gmap:
>  	if (IS_ENABLED(CONFIG_PGSTE) && gmap) {
>  		address =  __gmap_link(gmap, current->thread.gmap_addr,
>  				       address);
> @@ -466,7 +475,8 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  	}
>  	fault = 0;
>  out_up:
> -	mmap_read_unlock(mm);
> +	if (need_unlock)
> +		mmap_read_unlock(mm);
>  out:

This seems to be incorrect. __gmap_link() requires the mmap_lock to be
held. Christian, Janosch, or David, could you please check?
