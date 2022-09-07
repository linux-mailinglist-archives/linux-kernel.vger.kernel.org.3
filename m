Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FDC5B0B80
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIGRav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIGRat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:30:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49FC9F1AC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:30:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61345619C0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 17:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C814C433C1;
        Wed,  7 Sep 2022 17:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662571845;
        bh=sTFHKzRTmE4hLkwfjSXF938Aw9yrEtQkwAmeaka9rfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HfFLCI7fMLzE5aK8JJSfj7i0reK0wOtw+imOGRCdGPVuwmqKzItva9dK1OhkQGslA
         y+o5Xtle1k0xknoNKl6J+1zt1ci+VWZtiC+HLBhesKckl1Bbn62GxJWQwK7p2MBHEx
         HZ8uf4rvc28wA9U5fHIBksC4d9bBKWG6bbK7Hbx1uXlJEoLKI/E4q79mEg8tgTkcvK
         orBj87E08K/78WOLQ7jUqmgnW4VdadULt/+dv4BhGhyDfAgPE8hqk6e0V7+vm+mZWr
         mFJXH9DhaTFEkAPYswIIvmWkOXS/fvZXLCMC5PWocE1cMiJZRpq6SQDvH1shyidNMi
         rcub+uixsZXEg==
Date:   Thu, 8 Sep 2022 01:21:27 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org, rostedt@goodmis.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv/kprobe: Optimize the performance of patching
 instruction slot
Message-ID: <YxjTF2FlIJbbKq0p@xhacker>
References: <20220907023327.85630-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220907023327.85630-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 10:33:27AM +0800, Liao Chang wrote:
> Since no race condition occurs on each instruction slot, hence it is
> safe to patch instruction slot without stopping machine.

hmm, IMHO there's race when arming kprobe under SMP, so stopping
machine is necessary here. Maybe I misundertand something.

> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/riscv/kernel/probes/kprobes.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index e6e950b7cf32..eff7d7fab535 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -24,12 +24,14 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
>  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>  {
>  	unsigned long offset = GET_INSN_LENGTH(p->opcode);
> +	const kprobe_opcode_t brk_insn = __BUG_INSN_32;
> +	kprobe_opcode_t slot[MAX_INSN_SIZE];
>  
>  	p->ainsn.api.restore = (unsigned long)p->addr + offset;
>  
> -	patch_text(p->ainsn.api.insn, p->opcode);
> -	patch_text((void *)((unsigned long)(p->ainsn.api.insn) + offset),
> -		   __BUG_INSN_32);
> +	memcpy(slot, &p->opcode, offset);
> +	memcpy((void *)((unsigned long)slot + offset), &brk_insn, 4);
> +	patch_text_nosync(p->ainsn.api.insn, slot, offset + 4);
>  }
>  
>  static void __kprobes arch_prepare_simulate(struct kprobe *p)
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
