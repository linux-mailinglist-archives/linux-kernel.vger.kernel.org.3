Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A785134A2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346895AbiD1NQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346420AbiD1NQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:16:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148321C116
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:13:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 987386206B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FE1C385A0;
        Thu, 28 Apr 2022 13:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651151585;
        bh=u3Cve7iEq9Aj7tMuCV9JVcMUOZZm1kbZE8quTsQa4u8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3PbyFYlU3uZY/nMO/NJe/6XHGak3exrygvMRrqszVawor0oulWyVXi2UNTJ2ElHg
         a/82QXDjnA0wfmZDaYYH/ft58BDYgpZQL3RMqm6YiaO69Opc821hU3sKCwYHNPrBk9
         F76VVMK7VC/r/TYaPnaV7aBrf74cvhhadQeU+EKDG20yjfBtDN4IyoJYd1z5XEoO76
         biNody94i6V/0SnEeWBUwm55nRkgMfaD6nHiS2w9BXxgLszBwB5TIdH04kFxXshPhk
         Pggm4q7rCUgne83T/UkVBH4Wg7uyYf3nLtLFsbwDuRktHoXIbW9d6GvGauqeFWAhom
         u96xh/SeGfR9Q==
Date:   Thu, 28 Apr 2022 14:13:00 +0100
From:   Will Deacon <will@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2] arm64: add the printing of tpidr_elx in __show_regs()
Message-ID: <20220428131259.GA14810@willie-the-truck>
References: <20220316062408.1113-1-thunder.leizhen@huawei.com>
 <20220428102156.GA14123@willie-the-truck>
 <4c956c17-6e13-37a1-7da3-b2c8243c2c01@huawei.com>
 <d3570761-1273-831f-dfbe-aefbadfa37f7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3570761-1273-831f-dfbe-aefbadfa37f7@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 08:03:50PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/4/28 19:07, Leizhen (ThunderTown) wrote:
> > 
> > 
> > On 2022/4/28 18:21, Will Deacon wrote:
> >> On Wed, Mar 16, 2022 at 02:24:08PM +0800, Zhen Lei wrote:
> >>> Commit 7158627686f0 ("arm64: percpu: implement optimised pcpu access
> >>> using tpidr_el1") and commit 6d99b68933fb ("arm64: alternatives: use
> >>> tpidr_el2 on VHE hosts") use tpidr_elx to cache my_cpu_offset to optimize
> >>> pcpu access. However, when performing reverse execution based on the
> >>> registers and the memory contents in kdump, this information is sometimes
> >>> required if there is a pcpu access.
> >>>
> >>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>> ---
> >>>  arch/arm64/kernel/process.c | 11 +++++++++++
> >>>  1 file changed, 11 insertions(+)
> >>>
> >>> v1 --> v2:
> >>> Directly print the tpidr_elx register of the current exception level.
> >>> Avoid coupling with the implementation of 'my_cpu_offset'.
> >>>
> >>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> >>> index 5369e649fa79ff8..738932e6fa4e947 100644
> >>> --- a/arch/arm64/kernel/process.c
> >>> +++ b/arch/arm64/kernel/process.c
> >>> @@ -216,6 +216,17 @@ void __show_regs(struct pt_regs *regs)
> >>>  	show_regs_print_info(KERN_DEFAULT);
> >>>  	print_pstate(regs);
> >>>  
> >>> +	switch (read_sysreg(CurrentEL)) {
> >>
> >> This should use is_kernel_in_hyp_mode() to detect if we're running at El2.
> 
> static inline bool is_kernel_in_hyp_mode(void)
> {
>         return read_sysreg(CurrentEL) == CurrentEL_EL2;
> }
> 
> I think it's more intuitive to use "switch (read_sysreg(CurrentEL))".

No, I disagree with you here, sorry.

> >>> +	case CurrentEL_EL1:
> >>> +		printk("tpidr_el1 : %016llx\n", read_sysreg(TPIDR_EL1));
> >>> +		break;
> >>> +	case CurrentEL_EL2:
> >>> +		printk("tpidr_el2 : %016llx\n", read_sysreg(TPIDR_EL2));
> >>> +		break;
> >>> +	default:
> >>> +		break;
> >>> +	}
> >>
> >> I think this path can be triggered directly from usermode, so we really
> >> shouldn't be printing raw kernel virtual addresses here.
> > 
> > I run echo c > /proc/sysrq-trigger and didn't trigger this path, but maybe
> > there's another way. Analysis from the other side, except for the instruction
> > address, all generic registers r0-r31 is output as raw. There's also an
> > opportunity to contain the instruction address.
> 
> On second thought, there seemed to be nothing wrong with it. The user need
> to have capable() first. Then the address of the perpcu memory is not static,
> the memory is dynamically allocated, exposing it is no different than exposing sp.

If show_unhandled_signals is set, then I think any fatal signal takes this
path, no?

Will
