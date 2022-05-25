Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C8D533E12
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244478AbiEYNmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiEYNmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:42:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970A6633B4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:42:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 589D4B81DA8
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7707C385B8;
        Wed, 25 May 2022 13:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653486138;
        bh=2qPbWRcSRsl4LlFjbtIBkM7PQ9cUCKoA7Q1w7x4JsG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g32X/wmOcFhk3gydR4eQIpEK9yC6yh6BhsAwB+Bei9id1+rTaE0pBnl4YQ5zG9HAk
         uixuL892t//cAiE1g+7rsa8PXGaLIl9HJhNNQ8YJ7wJEFPF5/I/5x4MskCP//+h4/j
         +kCPBr20/Hcnvcbo/aUaWk7bZiKAJnHuBkEDt9QEXqZojmuaX92nJoQ37z0ua2T+el
         ZXDSEXU41qi/ofBq0EK5g4ct9JAYxs5NulkPjiB7D43V6DX/VDJP/w6ADMtTiX4Qw4
         rXTBUN59EJEjQOphiuAgDBm12opD3Qd5kyKpWfbWf+/P6oLNcSsC29YTMiOOI/t5R5
         2GdYKGZeq5i0w==
Date:   Wed, 25 May 2022 21:33:39 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Liao Chang <liaochang1@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] riscv/kprobe: reclaim insn_slot on kprobe
 unregistration
Message-ID: <Yo4wM8qvD/xTfRK1@xhacker>
References: <20220525014424.20717-1-liaochang1@huawei.com>
 <CAJF2gTS9_1D+K-ok2vxQpbq6B7zxv1K-t8cfcu1hFjF=7a5yxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJF2gTS9_1D+K-ok2vxQpbq6B7zxv1K-t8cfcu1hFjF=7a5yxQ@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 02:23:50PM +0800, Guo Ren wrote:
> On Wed, May 25, 2022 at 9:46 AM Liao Chang <liaochang1@huawei.com> wrote:
> >
> > On kprobe registration kernel allocate one insn_slot for new kprobe,
> > but it forget to reclaim the insn_slot on unregistration, leading to a
> > potential leakage.
> >
> > Reported-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
> > Signed-off-by: Liao Chang <liaochang1@huawei.com>

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> > v2:
> >   Add Reported-by tag
> >
> >  arch/riscv/kernel/probes/kprobes.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> > index e6e950b7cf32..f12eb1fbb52c 100644
> > --- a/arch/riscv/kernel/probes/kprobes.c
> > +++ b/arch/riscv/kernel/probes/kprobes.c
> > @@ -110,6 +110,10 @@ void __kprobes arch_disarm_kprobe(struct kprobe *p)
> >
> >  void __kprobes arch_remove_kprobe(struct kprobe *p)
> >  {
> > +       if (p->ainsn.api.insn) {
> > +               free_insn_slot(p->ainsn.api.insn, 0);
> > +               p->ainsn.api.insn = NULL;
> > +       }
> Thx reviewed-by: Guo Ren <guoren@kernel.org>
> 
> You also could give a fixup patch to csky, thx:
> 
> diff --git a/arch/csky/kernel/probes/kprobes.c
> b/arch/csky/kernel/probes/kprobes.c
> index 42920f25e73c..661da54b418f 100644
> --- a/arch/csky/kernel/probes/kprobes.c
> +++ b/arch/csky/kernel/probes/kprobes.c
> @@ -124,6 +124,10 @@ void __kprobes arch_disarm_kprobe(struct kprobe *p)
> 
>  void __kprobes arch_remove_kprobe(struct kprobe *p)
>  {
> +       if (p->ainsn.api.insn) {
> +               free_insn_slot(p->ainsn.api.insn, 0);
> +               p->ainsn.api.insn = NULL;
> +       }
>  }
> 
>  static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
> 
> >  }
> >
> >  static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
> > --
> > 2.17.1
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/
