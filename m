Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B29597182
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbiHQOkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240297AbiHQOkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:40:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633B87330C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:39:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B235F614EC
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA31C433C1;
        Wed, 17 Aug 2022 14:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660747166;
        bh=D2F5rhQcvdQNsiT8HtBPBvUKoSwn9XOVx+QjpXWS2Bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N0tg25bb4yMVbc2/THbcZW6YZykHnEAvJ25bUxovHiM35NM3GrgF6VWqxAa5cbn6h
         iPxzqoNhqR/D23BBn3UaIWPe/+MrNiaUMcFTzrAWvJqjJzH/qwITp0K3feYHru+Kcd
         SMp90lCO0If5gfJjS3fEpfLW+PdpcBthUGRK0fOtEF8HbpFvAyqT9Z/WjYYPb7vI9o
         ig/SmCQU0s9LYO22TstjwWjAOov1nCMFmHuonI5SDpIpoJZGMPYMad53jjfaxE93S+
         OXP9UyTBOmeuYzGImmAc0LG0hgUkB9COA39grfwiTb+rtqXEEeN2PghkTZ6TjjKblG
         7gq06Qurh5nSQ==
Date:   Wed, 17 Aug 2022 22:30:07 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     atishp@atishpatra.org, ajones@ventanamicro.com,
        linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, daolu@rivosinc.com,
        Conor.Dooley@microchip.com, re@w6rz.net, apatel@ventanamicro.com
Subject: Re: [PATCH] riscv: Ensure isa-ext static keys are writable
Message-ID: <Yvz7byY9F0ow1bgf@xhacker>
References: <CAOnJCU+Gx44ESHWyku7Kb6u5QnzjXiZcat5XmVWjksdFpcQ6nA@mail.gmail.com>
 <mhng-dd00cb27-4162-48aa-834d-30fb90e194cf@palmer-mbp2014>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mhng-dd00cb27-4162-48aa-834d-30fb90e194cf@palmer-mbp2014>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 09:29:36PM -0700, Palmer Dabbelt wrote:
> On Tue, 16 Aug 2022 16:41:46 PDT (-0700), atishp@atishpatra.org wrote:
> > On Tue, Aug 16, 2022 at 9:31 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> > > 
> > > riscv_isa_ext_keys[] is an array of static keys used in the unified
> > > ISA extension framework. The keys added to this array may be used
> > > anywhere, including in modules. Ensure the keys remain writable by
> > > placing them in the data section.
> > > 
> > > The need to change riscv_isa_ext_keys[]'s section was found when the
> > > kvm module started failing to load. Commit 8eb060e10185 ("arch/riscv:
> > > add Zihintpause support") adds a static branch check for a newly
> > > added isa-ext key to cpu_relax(), which kvm uses.
> >> > > 
> > > Fixes: c360cbec3511 ("riscv: introduce unified static key mechanism for ISA extensions")
> > > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > > > > ---
> > >  arch/riscv/kernel/cpufeature.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > > index 553d755483ed..3b5583db9d80 100644
> > > --- a/arch/riscv/kernel/cpufeature.c
> > > +++ b/arch/riscv/kernel/cpufeature.c
> > > @@ -28,7 +28,7 @@ unsigned long elf_hwcap __read_mostly;
> > >  /* Host ISA bitmap */
> > >  static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
> > > 
> > > -__ro_after_init DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
> > > +DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
> > >  EXPORT_SYMBOL(riscv_isa_ext_keys);
> > > 
> > >  /**
> > > --
> > > 2.37.1
> > > 
> > > 
> > > --
> > > kvm-riscv mailing list
> > > kvm-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kvm-riscv
> > 
> > Thanks for the quick fix. Tested with kvm guests booting in Qemu.
> > 
> > Tested-by: Atish Patra <atishp@rivosinc.com>

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

Thanks for catching the bug in my code.

> 
> Thanks, I hadn't realized how static keys work but looks like having them as
> __ro_after_init was always bogus.  Sorry to break stuff, looks like I should be

Sorry for breaking the static isa extension key usage in modules.
It's a good idea to make them readonly, but need to cope with the usage
in module properly. This may be a good improvement item.

> loading some module (probably KVM, as it's in the defconfig) during testing.
> 
> This is on fixes, I'm planning on sending it up later this week.
