Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F53647C4D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbhLURQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240272AbhLURQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:16:49 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9184CC061574;
        Tue, 21 Dec 2021 09:16:49 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id s15so1805619pfk.6;
        Tue, 21 Dec 2021 09:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5d1iZ4tBCObo6GoBZAkx6IXPWVQge2J0dQJ5ihkSow=;
        b=WGVUGt0Nl7gvtCF6g7NtUxI7fsmtdxHQXofjdduPbxdGV8lnFi7HWLiF9SVZVmu7W1
         Cuu8P/ISDzDJXS8vsJ7rlxc1uS0TOf65TuV869xOk0x4BQ8zsS7wzrdhWBk7MDGKGYYa
         q3BFe1xaUmT56D4NikoxsJDybQIRdAi21VVjjMVzUn3VUeQwfWLGqhNkHa9g/6UnPXid
         5bJ1IiAIMPSZ/Drj8IO210X5B5cA0FxjD54RPhij3Xt/+KvHZSUGWyVMsIGKrGX5JwSv
         5Lym28+5IMEC6URraUe6g7AcM4jkNcjUygif5ef0OS2Qr8l5slruRqXT2d3P/2/4YRS+
         NH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5d1iZ4tBCObo6GoBZAkx6IXPWVQge2J0dQJ5ihkSow=;
        b=q2o6hs1satzRRDPBR5NAqp1gTpVUKZJo3I2zsPZs9CaIYM/VofZGOntqpjZUop/3Kq
         eB85/EY/sqpGldf8hGeE5LWsMW2ToW8EmL0kCUakmo7yQEUB+yNsTKVuob1v1cQZ9+kt
         JzSDbPZVY3VNi0FqIXeVOWAL9AoDjMnHLZB9gfASJ1NLnvnFnzAxgNkfgd1Tq7wVAssm
         RscIi5hrNzWZ+RuVq9P2j6p65NNdgX8BIBMLxLum4CVHBrDlbMe+4+hx1eUG9brpU+1P
         ugXFLrxAeuPc5Bm/LkvvouOnY0W88oYWp0IqRChFSag3P67Q+F0llYNEy/Xv7Opb7VtQ
         jx5Q==
X-Gm-Message-State: AOAM5314B63by0Td3czjX9AXKg4P5jQb2tqsF/sPxJtV/Geg6RQRYhY5
        kbHb0wDnB1PddH7rYC0+bRew2Z6plb7MJ0Ro+dP3pTnOkGWFTw==
X-Google-Smtp-Source: ABdhPJx7Kw/z2OH1yiCEQKPzAxsl8uDLhU3SUXefvt/HElPhTM7OUa6m35t4/f+PvcGN9LowJyE9RzOGV/gkBizcfWw=
X-Received: by 2002:a05:6a00:b8e:b0:4ba:cbf2:516e with SMTP id
 g14-20020a056a000b8e00b004bacbf2516emr4221955pfj.72.1640107009013; Tue, 21
 Dec 2021 09:16:49 -0800 (PST)
MIME-Version: 1.0
References: <LO2P265MB2671DF8D82C0C6A1504D85D6939F9@LO2P265MB2671.GBRP265.PROD.OUTLOOK.COM>
 <LO2P265MB267173F563B0A2CA5995FA2C939F9@LO2P265MB2671.GBRP265.PROD.OUTLOOK.COM>
 <106F23FD-3768-4CF0-893D-EDFE4A0BA2BF@sophos.com> <YbEIe+jxzQTFPHwk@bombadil.infradead.org>
 <DB2D69B2-B523-4626-BDCE-CE7DEFCD9268@sophos.com> <YbJpvT/zRBuyuNxT@bombadil.infradead.org>
 <DFAD7F0E-4D95-40FC-8FB6-D488EB81A530@sophos.com> <YcDXrwXDw7nI6u2b@bombadil.infradead.org>
 <CALkUMdSPZ2Qr8CYMpckRsjizyPapcOcd77_JOcj=73nervwOEg@mail.gmail.com>
In-Reply-To: <CALkUMdSPZ2Qr8CYMpckRsjizyPapcOcd77_JOcj=73nervwOEg@mail.gmail.com>
From:   Vimal Agrawal <avimalin@gmail.com>
Date:   Tue, 21 Dec 2021 22:46:37 +0530
Message-ID: <CALkUMdTZr_QXQ7xjPGMU3ou3EJwa9cPxOtLeLVQ9B4Tw3H6iwA@mail.gmail.com>
Subject: Re: [PATCH] kernel/module.c: fix for symbol decode in stack trace for
 stripped modules
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Vimal Agrawal <Vimal.Agrawal@sophos.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

I tried on linux->next (tag next-20211220). I am able to reproduce
problem with .init.text symbol with following test patch in
lib/test_module.c:

diff --git a/lib/test_module.c b/lib/test_module.c

index debd19e35198..ca7ff49dec14 100644

--- a/lib/test_module.c

+++ b/lib/test_module.c

@@ -14,10 +14,35 @@

 #include <linux/module.h>

 #include <linux/printk.h>



+int g_x=1;

+struct init_struct {

+    void (*init)(int);

+    void (*start)(int);

+};

+

+

+static void test_module_warn_start(int x)

+{

+        if (x) WARN_ON_ONCE(1);

+}

+

+static void __init test_module_warn_init(int x)

+{

+        if (x) WARN_ON_ONCE(1);

+}

+

+

+static struct init_struct my_init_struct = {

+.init = test_module_warn_init,

+.start = test_module_warn_start,

+};

+

+

 static int __init test_module_init(void)

 {

        pr_warn("Hello, world\n");

-

+       my_init_struct.init(1);

+       /* my_init_struct.start(1); */

        return 0;

 }

register dump in dmesg shows:

[10585.879220] CPU: 0 PID: 31999 Comm: insmod Tainted: G        W   E
   5.16.0-rc5-next-20211220 #1

[10585.879223] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006

[10585.879225] RIP: 0010:0xffffffffc0363004

[10585.879230] Code: Unable to access opcode bytes at RIP 0xffffffffc0362fda.

[10585.879231] RSP: 0018:ffffad6443247bb0 EFLAGS: 00010202

[10585.879234] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000

[10585.879236] RDX: 0000000000000000 RSI: ffffffffa538e589 RDI: 0000000000000001

[10585.879238] RBP: ffffad6443247bb8 R08: 0000000000000000 R09: ffffad64432479b0

[10585.879239] R10: ffffad64432479a8 R11: ffffffffa5755248 R12: ffffffffc0363007

[10585.879241] R13: ffff8b5be9b35340 R14: 0000000000000000 R15: 0000000000000000

[10585.879243] FS:  00007fb7c60f4400(0000) GS:ffff8b5cc0e00000(0000)
knlGS:0000000000000000

[10585.879246] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

[10585.879247] CR2: ffffffffc0362fda CR3: 000000005c8c0005 CR4: 00000000000706f0

note that it could not decode RIP ( i.e. 0010:0xffffffffc0363004)

I am not able to reproduce the same with .text symbol consistently but
I remember I was able to reproduce it yesterday. It is kind of
dependent on the way symbols are generated based on code.

steps to repro :
1. patch test_module.c with above patch
2. build module using > make lib/test_module.ko
3. strip it using > strip --strip-unneeded test_module.ko
4. load it using insmod
5. check register dump in dmesg

Note that I did this test on vanilla kernel without my fix and I have
not tested it with my fix yet.

but I found another problem while I was trying this.

with few changes, I could see that it is decoding .text address
against the .init.text symbol. See following:

[ 9288.523510] address of init_module is ffffffffc0363000
[ 9288.523802] address of test_module_warn_start is ffffffffc0615000
[ 9288.523857] RIP: 0010:init_module+0x2b201e/0x2b2023 [test_module]

init_module is in .init.text and test_module_warn_start is in .text.
This looks wrong to me ( see big offset from the symbol i.e.
init_module+0x2b201e). It should decode the address to the symbol in
same elf section. Someone who is looking at dmesg is interested in
offset from some symbol in the same sections as sections are loaded at
different addresses in memory.
I think there should be a check in find_kallsyms_symbol to ignore
symbols from other sections when we are trying to decode an address to
a symbol.
or start with bestval from same section instead of starting with first symbol

find_kallsyms_symbol::
...
bestval = kallsyms_symbol_value(&kallsyms->symtab[best]);
...

Not sure if I am missing something here.

Vimal


On Tue, Dec 21, 2021 at 2:36 PM Vimal Agrawal <avimalin@gmail.com> wrote:
>
> Hi Luis,
>
> Please see https://github.com/crash-utility/crash/commit/03e3937ec7d1b356039433137cc6e531379ca454
> ( function store_module_symbols_v2  in file symbols.c). This was one
> of the initial commit for crash utility.
>
> I will work on linux-next and update you.
>
> Vimal
>
> On Tue, Dec 21, 2021 at 12:51 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Mon, Dec 20, 2021 at 08:57:46AM +0000, Vimal Agrawal wrote:
> > > Hi Luis,
> > >
> > > Sorry for goof up with inline replies. I found that gmail supports bottom-posting so I will be replying inline from gmail next time. I will send the next patch using git send-email.
> > >
> > > Looks like it has been there in crash source for very long.
> > >
> > > store_module_symbols_v2
> > >         sprintf(buf2, "%s%s", "_MODULE_START_", mod_name);
> > >             sprintf(buf3, "%s%s", "_MODULE_INIT_START_", mod_name);
> >
> > Can you point to the commit that added it? Preferably if you can have
> > a URL I can just use to see the change?
> >
> > > I will test it first on latest ubuntu which has kernel version 5.13.0-22.
> >
> > No, that's not sufficient, I really want you to use either Linus' latest
> > tree or linux-next.
> >
> >   Luis
