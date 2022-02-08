Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD4F4AE0B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384845AbiBHSZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384833AbiBHSZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:25:13 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD217C06157B;
        Tue,  8 Feb 2022 10:25:12 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so2737934pja.3;
        Tue, 08 Feb 2022 10:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kkwoERgZ8Jlut6Lk7JAIcGRRdxVGuQqkIXK7TH27gHQ=;
        b=VoLrXCOWiuJAoJLDB3xPFGMgDnUJU1UPcsRWkYIBDnMRqO6H41ggBrdnl0w8t7aN/e
         naauuIV25G1bTrvyBCzj/k0ubsY2FCcewwB2NY201IQ+ofAVYnJ0V4pocmwwt/HLFz5m
         ef6aCliMfgYdNPb7jJqs08v26qx7z0ytAx0+9R6qc/pAgyEnr2qslTxpSbkZKxQCuw0p
         ix2Pr7uNU9y0CuCFF3aRAQghun1xApyzDeSqL/ol7hm/zyTOVeWGE0ABigakQeXoXTpK
         tx78f5zZ5aE8HnMtTHpWLCcvBTjhFjdWPM9RCXjC4BI8R4GwqSEAqN/3rzrhDHim7+JQ
         8I1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kkwoERgZ8Jlut6Lk7JAIcGRRdxVGuQqkIXK7TH27gHQ=;
        b=42Ez66k6tdrvwnloPa+YC6jjQ65FJSllTOo1nrz0W+NQm9deb5Zqny/E/a5+mkbFvr
         vtZBN0JoJ3LrfGHbS+dRc/acJnIOtXR88b0Pp4LS7VtJMnYmHcz4MCLBivyxynIWaBhR
         vOkyswyAZxxv3Ub0UrAMWxP25tM3OydSP9Scj89vbCJSEWc+/grThOrrtvIJ8gfxB10m
         P0L51/1L+j0IShPGPfDm1r5d+nDemFEkpDy+X7pcV2Ju0h9pNi0dXX5+pN4HIHDX6MUM
         SpTWzN9uRiMVEhwSPZiEOdBV8GfpBJQwcIskxJrtzQ6uV6KQVtRVq3dw+kCcUInQyBZI
         FJ5A==
X-Gm-Message-State: AOAM531qzFncG1Wnrwaa7YCbNdCLS7Xz+dYB8vPr00l+It1CfwIsNZi+
        Ycc1p5uEVkL/iU5cI8PTxPfEULlvz9cxjS2j5MU=
X-Google-Smtp-Source: ABdhPJwtts6gCsTftV6KSWrv9PmcMLMFOla6ODzYmPxBXJBI8UQUQY/29XPt/ULN5JET7Wzf5Z3yTThKXWaDSuhkN34=
X-Received: by 2002:a17:90a:d343:: with SMTP id i3mr2772028pjx.104.1644344711976;
 Tue, 08 Feb 2022 10:25:11 -0800 (PST)
MIME-Version: 1.0
References: <CALkUMdSVV=Vju3TtryObKney7Q1TJLgGd7G7OB4X3FW9eJf4-w@mail.gmail.com>
 <20220208110231.2896-1-vimal.agrawal@sophos.com> <YgKyC4ZRud0JW1PF@bombadil.infradead.org>
In-Reply-To: <YgKyC4ZRud0JW1PF@bombadil.infradead.org>
From:   Vimal Agrawal <avimalin@gmail.com>
Date:   Tue, 8 Feb 2022 23:55:00 +0530
Message-ID: <CALkUMdSeO2pKrVrfo6ReBXs2UX-wsGPPatb-CtyqP02hyjS+mw@mail.gmail.com>
Subject: Re: [PATCH v6] modules: add heuristic when stripping unneeded symbols
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        Vimal Agrawal <vimal.agrawal@sophos.com>,
        nishit.shah@sophos.com, gregkh@linuxfoundation.org,
        Dirk VanDerMerwe <Dirk.VanDerMerwe@sophos.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > If kernel modules are stripped off symbols for some reason
>
> For some reason? Are you kidding? It is by design.
>
I meant that symbols can be stripped for various reasons e.g. if
stripped using --strip-unneeded option.

> > then stack
> > traces in dmesg do not show symbol name for address. It just prints
> > absolute address sometimes (if there is no good match with any symbol)
>
> Yes that is by design.
>
but we can improve it to show the offset from init start or core start
which can help for decoding later.

> > Note RIP: 0010:0xffffffffc06b67ec and 0xffffffffc06b67ec printed in above
> > stack trace as absolute address. There is no easy way in case box crashes
> > as we loose information on load address of specific module.
>
> Mentioning this note makes little sense, just say how the above doesn't help you
> easily identify the root cause of an address, and how this is just part
> of consequences of stripping symbols. Because developers using
> INSTALL_MOD_STRIP="--strip-unneeded"  know that they are trading off
> debugging live crashes over reducing the kernel and module binary size.
>
Ok

> > This changes the symbol decoding (in kernel/module.c) such that it can
> > print offset from start of section (.text or .init.text) in case there
> > is no good match with any symbol.
>
> No, this is adding a new heuristic to help in cases where no good match
> for a symbol was found, and typically this can be when symbols are
> stripped.
>
Ok
> > It will now decode address in such cases to [module]+ offset/size or
> > [module __init]+offset/size depending on where the address lies (in
> > core/.text or init/.init.text section of module).
> >
> > One can use objdump/readelf/nm to find symbols with offset from .init.text
> > and .text sections.
> >
> > steps to reproduce the problem:
> > -------------------------------
> > 1. Add WARN_ON_ONCE(1) in module e.g. test_module.c
> > 2. Build and strip the module using --strip-unneeded option
> > 3. Load the module and check RIP in dmesg
> >
> > tests done:
> > -----------
> > 1. Added WARN_ON_ONE(1) in functions of a module for testing
> > -------------------------------------------------------------
> > [  407.934085] CPU: 0 PID: 2956 Comm: insmod Tainted: G        W   E     5.16.0-rc5-next-20211220+ #2
> > [  407.934087] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> > [  407.934088] RIP: 0010:[module __init]+0x4/0x7 [test_module]
> > [  407.934097] Code: Unable to access opcode bytes at RIP 0xffffffffc07edfda.
> > [  407.934098] RSP: 0018:ffffb21440487c20 EFLAGS: 00010202
> > [  407.934100] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > [  407.934101] RDX: 0000000000000000 RSI: ffffffff9c38e5e1 RDI: 0000000000000001
> > [  407.934102] RBP: ffffb21440487c28 R08: 0000000000000000 R09: ffffb21440487a20
> > [  407.934103] R10: ffffb21440487a18 R11: ffffffff9c755248 R12: ffffffffc07ee007
> > [  407.934104] R13: ffff92a0f1e260b0 R14: 0000000000000000 R15: 0000000000000000
> > [  407.934105] FS:  00007f578ebc4400(0000) GS:ffff92a1c0e00000(0000) knlGS:0000000000000000
> > [  407.934107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  407.934108] CR2: ffffffffc07edfda CR3: 00000000063ea006 CR4: 00000000000706f0
> > [  407.934113] Call Trace:
> > [  407.934114]  <TASK>
> > [  407.934116]  ? init_module+0x55/0xff9 [test_module]
> > ...
> > [  407.934232] CPU: 0 PID: 2956 Comm: insmod Tainted: G        W   E     5.16.0-rc5-next-20211220+ #2
> > [  407.934234] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> > [  407.934242] RIP: 0010:[module]+0x4/0x7 [test_module]
> > [  407.934248] Code: Unable to access opcode bytes at RIP 0xffffffffc07e1fda.
> > [  407.934249] RSP: 0018:ffffb21440487c20 EFLAGS: 00010202
> > [  407.934251] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > [  407.934252] RDX: 0000000000000000 RSI: ffffffff9c38e5e1 RDI: 0000000000000001
> > [  407.934253] RBP: ffffb21440487c28 R08: 0000000000000000 R09: ffffb21440487a20
> > [  407.934254] R10: ffffb21440487a18 R11: ffffffff9c755248 R12: ffffffffc07ee007
> > [  407.934255] R13: ffff92a0f1e260b0 R14: 0000000000000000 R15: 0000000000000000
> > [  407.934256] FS:  00007f578ebc4400(0000) GS:ffff92a1c0e00000(0000) knlGS:0000000000000000
> > [  407.934257] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  407.934258] CR2: ffffffffc07e1fda CR3: 00000000063ea006 CR4: 00000000000706f0
> > [  407.934260] Call Trace:
> > [  407.934260]  <TASK>
> > [  407.934261]  ? init_module+0x5a/0xff9 [test_module]
> >
> > note that it is able to decode RIP to an offset from module start or
> > init start now.
> >
> > tested on linux->next (tag next-20211220)
> >
> > Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
> > Acked-by: Nishit Shah <nishit.shah@sophos.com>
> > Suggested-by: Dirk VanDerMerwe <Dirk.VanDerMerwe@Sophos.com>
> > ---
> >  kernel/module.c | 44 +++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 39 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 24dab046e16c..635e631c92f1 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -4260,6 +4260,19 @@ static const char *kallsyms_symbol_name(struct mod_kallsyms *kallsyms, unsigned
> >       return kallsyms->strtab + kallsyms->symtab[symnum].st_name;
> >  }
> >
> > +/*
> > + * Check if module address (addr) passed is as per init passed
> > + * if init is true then check in init layout
> > + * else check in core layout
> > + */
> > +bool match_address_layout(struct module *mod, unsigned long addr, bool init)
> > +{
> > +     if (init)
> > +             return within_module_init(addr, mod);
> > +     else
> > +             return within_module_core(addr, mod);
> > +}
> > +
> >  /*
> >   * Given a module and address, find the corresponding symbol and return its name
> >   * while providing its size and offset if needed.
> > @@ -4270,14 +4283,22 @@ static const char *find_kallsyms_symbol(struct module *mod,
> >                                       unsigned long *offset)
> >  {
> >       unsigned int i, best = 0;
> > -     unsigned long nextval, bestval;
> > +     unsigned long baseval, nextval, bestval;
> >       struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
> > +     char *module_base_name;
> > +     bool is_init_address = false;
> >
> >       /* At worse, next value is at end of module */
> > -     if (within_module_init(addr, mod))
> > +     if (within_module_init(addr, mod)) {
> > +             baseval = (unsigned long)mod->init_layout.base;
> >               nextval = (unsigned long)mod->init_layout.base+mod->init_layout.text_size;
> > -     else
> > +             module_base_name = "[module __init]";
> > +             is_init_address = true;
> > +     } else {
> > +             baseval = (unsigned long)mod->core_layout.base;
> >               nextval = (unsigned long)mod->core_layout.base+mod->core_layout.text_size;
> > +             module_base_name = "[module]";
> > +     }
> >
>
>
> To make all this readible and easier to follow please break down your
> work into 3 patches:
>
> 1) You add the above branch and add baseval as you do now and you also
> use it on the nextval assigmment. So something like this:
>
> +             baseval = (unsigned long)mod->init_layout.base;
> -             nextval = (unsigned long)mod->init_layout.base+mod->init_layout.text_size;
> +             nextval = baseval + mod->init_layout.text_size;
>
> You would do that for the core_layout branch too.
>
> This would make only one single change to the code. That is just one
> patch. And that patch introduces no functional changes. You would
> clarify that on the commit log, to make it clear there is no possible
> regression risks with it.
>
> >       bestval = kallsyms_symbol_value(&kallsyms->symtab[best]);
> >
> > @@ -4300,7 +4321,8 @@ static const char *find_kallsyms_symbol(struct module *mod,
> >                   || is_arm_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
> >                       continue;
> >
> > -             if (thisval <= addr && thisval > bestval) {
> > +             if ((thisval <= addr && thisval > bestval) &&
> > +                     (match_address_layout(mod, thisval, is_init_address))) {
>
> OK your 2nd patch will be:
>
> 2) You add match_address_layout() and the is_init_address bool. This is
> a fix found through code inspection. You can clarify that the issue has
> only been found when --strip-unneeded is used, however, that the fix
> could potentialy solve other false symbol. At this point in time no
> known cases are known where the reported symbol returned is invalid,
> but this sanity check makes sense even for cases where no striping is
> used. You can also mention that you this fix is also being added to
> be able to add a new heuristic later for cases where --strip-unneeded
> is used.
>
> >                       best = i;
> >                       bestval = thisval;
> >               }
> > @@ -4308,8 +4330,20 @@ static const char *find_kallsyms_symbol(struct module *mod,
> >                       nextval = thisval;
> >       }
> >
> > -     if (!best)
> > +     if (!best) {
> > +             if (is_module_text_address(addr)) {
> > +                     /*
> > +                      * return MODULE base and offset if we could not find
> > +                      * any best match for text address
> > +                      */
> > +                     if (size)
> > +                             *size = nextval - baseval;
> > +                     if (offset)
> > +                             *offset = addr - baseval;
> > +                     return module_base_name;
> > +             }
> >               return NULL;
>
> And then patch 3 is this new change. Please test the config I sent you
> though, I have not been able to reproduce your setup yet.
>
>   Luis
sure I will do as suggested. Thanks.

Vimal
