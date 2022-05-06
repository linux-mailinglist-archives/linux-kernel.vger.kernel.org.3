Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176D051D533
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390822AbiEFKNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390809AbiEFKNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:13:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5411A5DA7F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:09:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B96714BF;
        Fri,  6 May 2022 03:09:51 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.65.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AD5F3FA31;
        Fri,  6 May 2022 03:09:50 -0700 (PDT)
Date:   Fri, 6 May 2022 11:09:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: add the printing of tpidr_elx in __show_regs()
Message-ID: <YnTz6oFEQGDBrIpi@FVFF77S0Q05N>
References: <20220505095640.312-1-thunder.leizhen@huawei.com>
 <YnPLQJhu5B1Cxvoh@FVFF77S0Q05N.cambridge.arm.com>
 <c6c22386-af37-1acc-63e9-2bb85028aa8c@huawei.com>
 <307e4def-1e4a-1110-e644-d485b9959ab1@huawei.com>
 <7c1207fa-56aa-1b33-31fd-3ec395b08f2b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c1207fa-56aa-1b33-31fd-3ec395b08f2b@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 04:16:55PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/5/5 21:34, Leizhen (ThunderTown) wrote:
> > On 2022/5/5 21:26, Leizhen (ThunderTown) wrote:
> >> On 2022/5/5 21:04, Mark Rutland wrote:
> >>> On Thu, May 05, 2022 at 05:56:40PM +0800, Zhen Lei wrote:
> >>>> Commit 7158627686f0 ("arm64: percpu: implement optimised pcpu access
> >>>> using tpidr_el1") and commit 6d99b68933fb ("arm64: alternatives: use
> >>>> tpidr_el2 on VHE hosts") use tpidr_elx to cache my_cpu_offset to optimize
> >>>> pcpu access. However, when performing reverse execution based on the
> >>>> registers and the memory contents in kdump, this information is sometimes
> >>>> required if there is a pcpu access.
> >>>>
> >>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>>> ---
> >>>>  arch/arm64/kernel/process.c | 5 +++++
> >>>>  1 file changed, 5 insertions(+)
> >>>>
> >>>> v2 --> v3:
> >>>> 1) Relace "switch (read_sysreg(CurrentEL))" statement with
> >>>>    "if (is_kernel_in_hyp_mode())" statement.
> >>>> 2) Change the register name to lowercase.
> >>>>
> >>>> v1 --> v2:
> >>>> Directly print the tpidr_elx register of the current exception level.
> >>>> Avoid coupling with the implementation of 'my_cpu_offset'.
> >>>>
> >>>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> >>>> index 7fa97df55e3ad3f..7b6bccce9721c36 100644
> >>>> --- a/arch/arm64/kernel/process.c
> >>>> +++ b/arch/arm64/kernel/process.c
> >>>> @@ -216,6 +216,11 @@ void __show_regs(struct pt_regs *regs)
> >>>>  	show_regs_print_info(KERN_DEFAULT);
> >>>>  	print_pstate(regs);
> >>>>  
> >>>> +	if (is_kernel_in_hyp_mode())
> >>>> +		printk("tpidr_el2 : %016llx\n", read_sysreg(tpidr_el2));
> >>>> +	else
> >>>> +		printk("tpidr_el1 : %016llx\n", read_sysreg(tpidr_el1));
> >>>
> >>> If we care about the offset specifically, this would be simpler as:
> >>>
> >>> 	printk("cpu offset : 0x%016lx\n", __my_cpu_offset());
> >>
> >> The function name is __show_regs(), so not using register name may not be good.
> >> In fact, some other architectures may also have this problem. If we use my_cpu_offset,
> >> we may need to put it in a public.
> > 
> > The other idea is to back up each my_cpu_offset in an array. In this way, the offset can
> > be queried through vmcore even if it is not printed.
> 
> Sorry, __per_cpu_offset[NR_CPUS] is always defined.

Surely that's in the vmcore already? It's just data in memory.

Thanks,
Mark.
