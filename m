Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A970246DC5D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbhLHThP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239635AbhLHTg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:36:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9720C061746;
        Wed,  8 Dec 2021 11:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=+432gjxvF2P6YtDUv0/lfHRhxKUBPDK7OirmuNbKVAE=; b=g+doX68AbVJw7q4wT72ygmoeTe
        viUht2ZLq25UOhA6XA7YY4l9JKgA13jnqfMzfo6VW4FN3VpdNWIfddZJ+sI5ZkJRNdHavDPXY5ohZ
        YlD+yHvMmhnMNK+PA227Gpv6FOyTEmbuicoOW2DkhMQNYf0ivtszbbfk5qcRggi2AFAAZpy+sPqOA
        fNtrWoe817P7z/MqSa5PgDnTdVBHBjpfHQ3TR1LC36uGFp4fVJUe3vXDbu1/URXVwrs6N2Yx4vwzF
        aMuNoJMJgFWcZwUUuVsaIBNgtbjea/TpuGqq4GSvR6a39MtnRTJ+atHhrr3gZWQ+JIk1AYUe9QmTT
        ZcIA1e6A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv2gl-00E4nE-V1; Wed, 08 Dec 2021 19:33:15 +0000
Date:   Wed, 8 Dec 2021 11:33:15 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vimal Agrawal <Vimal.Agrawal@sophos.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org
Cc:     "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/module.c: fix for symbol decode in stack trace
 for stripped modules
Message-ID: <YbEIe+jxzQTFPHwk@bombadil.infradead.org>
References: <LO2P265MB2671DF8D82C0C6A1504D85D6939F9@LO2P265MB2671.GBRP265.PROD.OUTLOOK.COM>
 <LO2P265MB267173F563B0A2CA5995FA2C939F9@LO2P265MB2671.GBRP265.PROD.OUTLOOK.COM>
 <106F23FD-3768-4CF0-893D-EDFE4A0BA2BF@sophos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <106F23FD-3768-4CF0-893D-EDFE4A0BA2BF@sophos.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your patch! I will note to start off with that unfortunately
whatever it is you use to send emails leaves them with UTF encodings
which does not let me easily download the patches using lore. For
instance, this is what I see:

https://lore.kernel.org/all/106F23FD-3768-4CF0-893D-EDFE4A0BA2BF@sophos.com/raw

Here is an example of a good patch:

https://lore.kernel.org/all/20211129034509.2646872-2-ming.lei@redhat.com/raw

What are you using to send patches? Consider using git send-email.
I think your mailer is sending the emails out as MIME attachments.

On Mon, Nov 22, 2021 at 02:02:30PM +0000, Vimal Agrawal wrote:
> If kernel modules are stripped off symbols (say built by using strip --
> strip-unneeded)

OK so is your build system using something like:

make install modules_install INSTALL_MOD_STRIP="--strip-unneeded"

At least that's one way to strip modules using upstream techniques since
the 2.6 kernel days. Because it would be wise for us to document *how* to
reproduce the issue you are seeing in your commit log.

> then stack traces in dmesg do not show module name or
> symbol name for addresses.

as intended. So there is actually no issue and your patch is not a fix.
It is an optimization to help readers with a hint. So if we get anywhere
with this patch I'd say change the subject to relate it to
a heuristic enhancement for INSTALL_MOD_STRIP when --strip-unneeded is used.

> It just prints absolute address ( without any
> reference of module)
> e.g.
> 
> [245864.699580]  do_nmi+0x12f/0x370
> [245864.699583]  end_repeat_nmi+0x16/0x50
> [245864.699585] RIP: 0010:0xffffffffc06b67ec                           <<<<<<<<
> [245864.699585] RSP: 0000:ffffaaa540cffe48 EFLAGS: 00000097
> [245864.699586] RAX: 0000000000000001 RBX: ffff93357a729000 RCX: 0000000000000001
> [245864.699587] RDX: ffff93357a729050 RSI: 0000000000000000 RDI: ffff93357a729000
> [245864.699588] RBP: ffff9335cf521300 R08: 0000000000000001 R09: 0000000000000004
> [245864.699588] R10: ffffaaa545b23ed0 R11: 0000000000000001 R12: ffffffffc06b61a0
> [245864.699589] R13: ffffaaa540cffe60 R14: ffff9335c77fa3c0 R15: ffff9335cf51d7c0
> [245864.699590]  ? 0xffffffffc06b61a0
> [245864.699592]  ? 0xffffffffc06b67ec                                  <<<<<<<<
> [245864.699593]  ? 0xffffffffc06b67ec
> [245864.699594]  </NMI>
> 
> Note RIP: 0010:0xffffffffc06b67ec and 0xffffffffc06b67ec printed in above
> stack trace as absolute address.
> There is no easy way in case box crashes as we loose /proc/modules to see
> load address of modules to map address to one specific module. It will be
> really good to give some hint of module and offset inside module section
> about such addresses.
> 
> so changed kernel/module.c so that it can decode address to _MODULE_START_+
> offset/size or _MODULE_INIT_+offset/size depending on where the address
> lies (in core/.text or init/.init.text section of module).
> 
> e.g. nfnm_queue_net_init+0x2f1/0x393 [nfnetmap_queue] printed in case of
> symbols present shows up as 0010:0xffffffffc06b67ec in case symbols are
> absent. With modified logic, it will be shown as _MODULE_INIT_+0x2f1/0x393
> [nfnetmap_queue]
> 
> This will help for developer to debug and map this to actual nfnm_queue_net
> _init symbol later. One can use objdump/readelf/nm to find symbols with
> offset in .init.text and .text sections.
> 
> tests done:
> ===========
> 1. added WARN_ON_ONE(1) in init_module of a module
> ----------------------------------------------------
> [53.795977] task: ffff9d60094b3000 task.stack: ffff9d602c704000
> [53.795978] RIP: 0010:_MODULE_INIT_+0x2f1/0x393 [nfnetmap_queue]   <=====

Huh, if the module is already printed (the [nfnetmap_queue]) why even
have _MODULE_INIT_ and instead we just say:

[53.795978] RIP: 0010:[module __init]+0x2f1/0x393 [nfnetmap_queue]

This way if you come up with other heuristics this can also be put in
the [] and we'd document that.

> [53.795979] RSP: 0018:ffff9d602c707c40 EFLAGS: 00010286
> [53.795980] RAX: 0000000000000047 RBX: ffff9d600b4c0800 RCX: 0000000000000006
> [53.795980] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff9d603fc172f0
> [53.795981] RBP: 0000000000000000 R08: 00000000000004bd R09: 0000000000000002
> [53.795981] R10: ffffffffc2250083 R11: 0000000000000001 R12: ffff9d5fb785a870
> [53.795982] R13: 00000000fffffff4 R14: ffff9d5fb785a800 R15: 0000000000000000
> [53.795983] FS:  00007ffb73c2ab80(0000) GS:ffff9d603fc00000(0000)
> [53.795983] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [53.795984] CR2: 00000000f76e6270 CR3: 0000000107c0c006 CR4: 00000000001606f0
> [53.796014] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [53.796014] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [53.796015] Call Trace:
> [53.796022]  ops_init.constprop.8+0x81/0x110
> [53.796024]  register_pernet_operations+0x92/0xc0
> [53.796026]  ? _MODULE_INIT_+0x393/0x393 [nfnetmap_queue]          <======
> [53.796027]  register_pernet_subsys+0x1f/0x40
> [53.796028]  init_module+0x51/0xc6d [nfnetmap_queue]
> [53.796031]  do_one_initcall+0x36/0x160
> 
> 2. added a call to sprint_symbol in a module
> ---------------------------------------------
> $ decode for symbol nfnm_queue_flush+16:
> _MODULE_START_+0x7e0/0x1daa [nfnetmap_queue]                       <======
> 
> $ nm nfnetmap_queue.ko | grep _flush
> 00000000000007d0 t nfnm_queue_flush
> 0x7d0 + 16d = 0x7e0 so this offset maps to symbol nfnm_queue_flush
> 
> tested on kernel 4.14.38
> 
> Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
> ---
>  kernel/module.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 84a9141a5e15..d55fb8405151 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -4259,12 +4259,19 @@ static const char *find_kallsyms_symbol(struct module *mod,
>         unsigned int i, best = 0;
>         unsigned long nextval, bestval;
>         struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
> +       char *module_base_name = "_MODULE_START_";

I don't think "_MODULE_START_" tells the user anything clear.
If we're going to use heuristics best we use a nomenclature we
can expand later and not be cryptic.

So maybe just [module] is good enough.

We don't have to initialize this as well, as its either one or the other.

> +       unsigned long module_base_address = 0;
> 
>         /* At worse, next value is at end of module */
> -       if (within_module_init(addr, mod))
> +       if (within_module_init(addr, mod)) {
>                 nextval = (unsigned long)mod->init_layout.base+mod->init_layout.text_size;
> -       else
> +               module_base_address = (unsigned long)mod->init_layout.base;
> +               module_base_name = "_MODULE_INIT_";
> +       } else {
>                 nextval = (unsigned long)mod->core_layout.base+mod->core_layout.text_size;
> +               module_base_address = (unsigned long)mod->core_layout.base;
> +               module_base_name = "_MODULE_START_";
> +       }
> 
>         bestval = kallsyms_symbol_value(&kallsyms->symtab[best]);
> 
> @@ -4295,8 +4302,14 @@ static const char *find_kallsyms_symbol(struct module *mod,
>                         nextval = thisval;
>         }
> 
> -       if (!best)
> -               return NULL;
> +       if (!best) {
> +               /* return MODULE base and offset from it */
> +               if (size)
> +                       *size = nextval - module_base_address;
> +               if (offset)
> +                       *offset = addr - module_base_address;
> +               return module_base_name;

Have you tested this on recent kernels? If not please test this there
as I cannot reproduce with your changes taking effect at all. In fact
this branch is not hit at all.

  Luis
