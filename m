Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9C95B1DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiIHMuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiIHMuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:50:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605C733A28
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 106BAB820DA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1370C433D6;
        Thu,  8 Sep 2022 12:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662641402;
        bh=J94j2940gssPCzqo3VP0L2UgivzizFgy5WQH1s5iPoo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HDyjY3QKy9idICnbkRBMhuwAZ1LxZuFGp9MnTXxDq1g17pH/WlzjxBKHyea7iWnIM
         05D4y9+DU2mygC804n71CCvo4MvZX4/9mpDkxbEfviRRg+lg9b26NxgqCVqZyW+vVn
         etvvTdH2HBCvNkmyCT9jqfYmsFxU8EuPn4PeJ+6keUXxkvITPQQ1IX+tnVlHNjcBxT
         /Fs432/5lv1sc+/fSKZ2V8NOQ94dz7Kaw4w8akghz7Ew+HstIHoesRESs1zvLWyuuM
         8S/d0ofm0EJRlwS64Uk+F5e2taLV0NKemdda/HhjVV8Kr+jjP3sh5XVT/RjR93eXqV
         cc/NhyJMR34iA==
Date:   Thu, 8 Sep 2022 21:49:58 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "liaochang (A)" <liaochang1@huawei.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <mhiramat@kernel.org>, <rostedt@goodmis.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv/kprobe: Optimize the performance of patching
 instruction slot
Message-Id: <20220908214958.c8139533dccad1ee8f927214@kernel.org>
In-Reply-To: <a00328a1-47ee-3700-8cd8-1a9f4e0d7a2b@huawei.com>
References: <20220907023327.85630-1-liaochang1@huawei.com>
        <YxjTF2FlIJbbKq0p@xhacker>
        <a00328a1-47ee-3700-8cd8-1a9f4e0d7a2b@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 09:43:45 +0800
"liaochang (A)" <liaochang1@huawei.com> wrote:

> Thanks for comment.
> 
> 在 2022/9/8 1:21, Jisheng Zhang 写道:
> > On Wed, Sep 07, 2022 at 10:33:27AM +0800, Liao Chang wrote:
> >> Since no race condition occurs on each instruction slot, hence it is
> >> safe to patch instruction slot without stopping machine.
> > 
> > hmm, IMHO there's race when arming kprobe under SMP, so stopping
> > machine is necessary here. Maybe I misundertand something.
> > 
> 
> It is indeed necessary to stop machine when arm kprobe under SMP,
> but i don't think it need to stop machine when prepare instruction slot,
> two reasons:
> 
> 1. Instruction slot is dynamically allocated data.
> 2. Kernel would not execute instruction slot until original instruction
>    is replaced by breakpoint.

Ah, this is for ss (single step out of line) slot. So until
kprobe is enabled, this should not be used from other cores.
OK, then it should be safe.


> >>
> >> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> >> ---
> >>  arch/riscv/kernel/probes/kprobes.c | 8 +++++---
> >>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> >> index e6e950b7cf32..eff7d7fab535 100644
> >> --- a/arch/riscv/kernel/probes/kprobes.c
> >> +++ b/arch/riscv/kernel/probes/kprobes.c
> >> @@ -24,12 +24,14 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
> >>  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
> >>  {
> >>  	unsigned long offset = GET_INSN_LENGTH(p->opcode);
> >> +	const kprobe_opcode_t brk_insn = __BUG_INSN_32;
> >> +	kprobe_opcode_t slot[MAX_INSN_SIZE];
> >>  
> >>  	p->ainsn.api.restore = (unsigned long)p->addr + offset;
> >>  
> >> -	patch_text(p->ainsn.api.insn, p->opcode);
> >> -	patch_text((void *)((unsigned long)(p->ainsn.api.insn) + offset),
> >> -		   __BUG_INSN_32);
> >> +	memcpy(slot, &p->opcode, offset);
> >> +	memcpy((void *)((unsigned long)slot + offset), &brk_insn, 4);
> >> +	patch_text_nosync(p->ainsn.api.insn, slot, offset + 4);

BTW, didn't you have a macro for the size of __BUG_INSN_32?

Thank you,


> >>  }
> >>  
> >>  static void __kprobes arch_prepare_simulate(struct kprobe *p)
> >> -- 
> >> 2.17.1
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> > .
> 
> -- 
> BR,
> Liao, Chang


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
