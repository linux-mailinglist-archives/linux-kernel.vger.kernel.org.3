Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD9B5B0FCD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiIGW2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIGW2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:28:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E59915C7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 15:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CB3961A74
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 22:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68270C433D6;
        Wed,  7 Sep 2022 22:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662589720;
        bh=pJsmgTbGHNW/yAcK2hWWKM88ZL8a30t4f/K7+7+aV6o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o9wKUbADFIRtWiT/CEd6HReWuUu0oRHglS/gghzyUOFyc7H89qQkrJIVxCIVTcp/l
         8gG2O+dB5t9/6YOgxNqUVmWPMGqfQwwghxJuPLXLWRRwDUPs4fdFTA6MoaXjLxsrNq
         RGMjDppnaqq2sxjU58qy4PakQJaCXml30mL8Sj/utjBMRbxUaRXMr2+cKP9adwIw5V
         yVO3iQ+8QMor+VDKrsBwWT7yiJrg6k043hDhVHAOPtFwdUKlrXxWY7aYnkLSmc4kbG
         6+36FrlWY5jKorE7eMdaEmSkVYHwuGO4Tt0q4i7v1VbNa4Pz/ozgQTGqC+5k/dHjAm
         FMrgS7e303ddQ==
Date:   Thu, 8 Sep 2022 07:28:36 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Liao Chang <liaochang1@huawei.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, mhiramat@kernel.org,
        rostedt@goodmis.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv/kprobe: Optimize the performance of patching
 instruction slot
Message-Id: <20220908072836.0e9e0833ddfa4d413a2254be@kernel.org>
In-Reply-To: <YxjTF2FlIJbbKq0p@xhacker>
References: <20220907023327.85630-1-liaochang1@huawei.com>
        <YxjTF2FlIJbbKq0p@xhacker>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 01:21:27 +0800
Jisheng Zhang <jszhang@kernel.org> wrote:

> On Wed, Sep 07, 2022 at 10:33:27AM +0800, Liao Chang wrote:
> > Since no race condition occurs on each instruction slot, hence it is
> > safe to patch instruction slot without stopping machine.
> 
> hmm, IMHO there's race when arming kprobe under SMP, so stopping
> machine is necessary here. Maybe I misundertand something.

Yeah, usually the self modifying code needs stop other CPUs some known
points so that other CPUs does not execute the instruction which will
be modified.
Even if a chip ensures that, is that safe for other implementations?
(Does RISC-V specification guarantee this behavior?)

Thank you,

> 
> > 
> > Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > ---
> >  arch/riscv/kernel/probes/kprobes.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> > index e6e950b7cf32..eff7d7fab535 100644
> > --- a/arch/riscv/kernel/probes/kprobes.c
> > +++ b/arch/riscv/kernel/probes/kprobes.c
> > @@ -24,12 +24,14 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
> >  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
> >  {
> >  	unsigned long offset = GET_INSN_LENGTH(p->opcode);
> > +	const kprobe_opcode_t brk_insn = __BUG_INSN_32;
> > +	kprobe_opcode_t slot[MAX_INSN_SIZE];
> >  
> >  	p->ainsn.api.restore = (unsigned long)p->addr + offset;
> >  
> > -	patch_text(p->ainsn.api.insn, p->opcode);
> > -	patch_text((void *)((unsigned long)(p->ainsn.api.insn) + offset),
> > -		   __BUG_INSN_32);
> > +	memcpy(slot, &p->opcode, offset);
> > +	memcpy((void *)((unsigned long)slot + offset), &brk_insn, 4);
> > +	patch_text_nosync(p->ainsn.api.insn, slot, offset + 4);
> >  }
> >  
> >  static void __kprobes arch_prepare_simulate(struct kprobe *p)
> > -- 
> > 2.17.1
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
