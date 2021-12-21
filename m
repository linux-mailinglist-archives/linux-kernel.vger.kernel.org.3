Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D20347C94D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 23:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhLUWp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 17:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhLUWp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:45:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BB2C061574;
        Tue, 21 Dec 2021 14:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uTRns1vPXnmHk2kENaxADvcGunx11zxH3w72DUTm1PM=; b=weks5fK3L7ZmqQ4ZxxOvo0117c
        36kycXcg0dTmB0U34mQRYclNMu1e2l/u/5PY+Gj0teZt8X/wJYx37fFcnMxMKMSlVsjrdREsC3J7Z
        bdFfV2zOuANBBKd4Cn0CUqbP1Z5xrbjH2WwLRAzgvupnDbepYqX5CpN93AOM9tl/VLXKh9WgyF0XQ
        xUAlZ7pmt/y2nQfhQ8+Pq/zGJOfsAKQH15vGXFfpWumdFAlM/j28jYC0scRiV/mT91vg4rW63sbB7
        uCc9rJsvsZoxdDe/Dt9Z8pWZwu9TzEzzYUSYZjCABR3O7Pj37dyG/mTd3NzHLfBZ0nO62valhiNFQ
        5N0jnbBQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mznsi-008evV-Ij; Tue, 21 Dec 2021 22:45:16 +0000
Date:   Tue, 21 Dec 2021 14:45:16 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vimal Agrawal <avimalin@gmail.com>
Cc:     Vimal Agrawal <Vimal.Agrawal@sophos.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/module.c: fix for symbol decode in stack trace
 for stripped modules
Message-ID: <YcJY/CZ+Rh/3TCoO@bombadil.infradead.org>
References: <LO2P265MB2671DF8D82C0C6A1504D85D6939F9@LO2P265MB2671.GBRP265.PROD.OUTLOOK.COM>
 <LO2P265MB267173F563B0A2CA5995FA2C939F9@LO2P265MB2671.GBRP265.PROD.OUTLOOK.COM>
 <106F23FD-3768-4CF0-893D-EDFE4A0BA2BF@sophos.com>
 <YbEIe+jxzQTFPHwk@bombadil.infradead.org>
 <DB2D69B2-B523-4626-BDCE-CE7DEFCD9268@sophos.com>
 <YbJpvT/zRBuyuNxT@bombadil.infradead.org>
 <DFAD7F0E-4D95-40FC-8FB6-D488EB81A530@sophos.com>
 <YcDXrwXDw7nI6u2b@bombadil.infradead.org>
 <CALkUMdSPZ2Qr8CYMpckRsjizyPapcOcd77_JOcj=73nervwOEg@mail.gmail.com>
 <CALkUMdTZr_QXQ7xjPGMU3ou3EJwa9cPxOtLeLVQ9B4Tw3H6iwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALkUMdTZr_QXQ7xjPGMU3ou3EJwa9cPxOtLeLVQ9B4Tw3H6iwA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:46:37PM +0530, Vimal Agrawal wrote:
> Hi Luis,
> 
> I tried on linux->next (tag next-20211220). I am able to reproduce
> problem with .init.text symbol with following test patch in
> lib/test_module.c:
> 
> diff --git a/lib/test_module.c b/lib/test_module.c

Your mailer is still making things odd:

> 
> index debd19e35198..ca7ff49dec14 100644
> 
> --- a/lib/test_module.c
> 
> +++ b/lib/test_module.c
> 
> @@ -14,10 +14,35 @@

It adds new lines where it is not needed.

> 
>  #include <linux/module.h>
> 
>  #include <linux/printk.h>
> 
> 
> 
> +int g_x=1;
> 
> +struct init_struct {
> 
> +    void (*init)(int);
> 
> +    void (*start)(int);
> 
> +};
> 
> +
> 
> +
> 
> +static void test_module_warn_start(int x)
> 
> +{
> 
> +        if (x) WARN_ON_ONCE(1);
> 
> +}
> 
> +
> 
> +static void __init test_module_warn_init(int x)
> 
> +{
> 
> +        if (x) WARN_ON_ONCE(1);
> 
> +}
> 
> +
> 
> +
> 
> +static struct init_struct my_init_struct = {
> 
> +.init = test_module_warn_init,
> 
> +.start = test_module_warn_start,
> 
> +};
> 
> +
> 
> +
> 
>  static int __init test_module_init(void)
> 
>  {
> 
>         pr_warn("Hello, world\n");
> 
> -
> 
> +       my_init_struct.init(1);
> 
> +       /* my_init_struct.start(1); */
> 
>         return 0;
> 
>  }
> 
> register dump in dmesg shows:
> 
> [10585.879220] CPU: 0 PID: 31999 Comm: insmod Tainted: G        W   E
>    5.16.0-rc5-next-20211220 #1
> 
> [10585.879223] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> VirtualBox 12/01/2006
> 
> [10585.879225] RIP: 0010:0xffffffffc0363004
> 
> [10585.879230] Code: Unable to access opcode bytes at RIP 0xffffffffc0362fda.
> 
> [10585.879231] RSP: 0018:ffffad6443247bb0 EFLAGS: 00010202
> 
> [10585.879234] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> 
> [10585.879236] RDX: 0000000000000000 RSI: ffffffffa538e589 RDI: 0000000000000001
> 
> [10585.879238] RBP: ffffad6443247bb8 R08: 0000000000000000 R09: ffffad64432479b0
> 
> [10585.879239] R10: ffffad64432479a8 R11: ffffffffa5755248 R12: ffffffffc0363007
> 
> [10585.879241] R13: ffff8b5be9b35340 R14: 0000000000000000 R15: 0000000000000000
> 
> [10585.879243] FS:  00007fb7c60f4400(0000) GS:ffff8b5cc0e00000(0000)
> knlGS:0000000000000000
> 
> [10585.879246] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 
> [10585.879247] CR2: ffffffffc0362fda CR3: 000000005c8c0005 CR4: 00000000000706f0
> 
> note that it could not decode RIP ( i.e. 0010:0xffffffffc0363004)
> 
> I am not able to reproduce the same with .text symbol consistently but
> I remember I was able to reproduce it yesterday. It is kind of
> dependent on the way symbols are generated based on code.
> 
> steps to repro :
> 1. patch test_module.c with above patch
> 2. build module using > make lib/test_module.ko
> 3. strip it using > strip --strip-unneeded test_module.ko
> 4. load it using insmod
> 5. check register dump in dmesg

OK with out your patch yes obviously things are opaque.

> 
> Note that I did this test on vanilla kernel without my fix and I have
> not tested it with my fix yet.

Please stop calling your changes a fix. It is not a fix. It is adding
new heuristics.

And not sure I follow. I just want you to focus on linux-next.

> but I found another problem while I was trying this.
> 
> with few changes, I could see that it is decoding .text address
> against the .init.text symbol. See following:
> 
> [ 9288.523510] address of init_module is ffffffffc0363000
> [ 9288.523802] address of test_module_warn_start is ffffffffc0615000
> [ 9288.523857] RIP: 0010:init_module+0x2b201e/0x2b2023 [test_module]
> 
> init_module is in .init.text and test_module_warn_start is in .text.
> This looks wrong to me ( see big offset from the symbol i.e.
> init_module+0x2b201e). It should decode the address to the symbol in
> same elf section. Someone who is looking at dmesg is interested in
> offset from some symbol in the same sections as sections are loaded at
> different addresses in memory.
> I think there should be a check in find_kallsyms_symbol to ignore
> symbols from other sections when we are trying to decode an address to
> a symbol.
> or start with bestval from same section instead of starting with first symbol
> 
> find_kallsyms_symbol::
> ...
> bestval = kallsyms_symbol_value(&kallsyms->symtab[best]);
> ...
> 
> Not sure if I am missing something here.

Please send a new patch with proper instructions there, so I can test.
The first patch didn't even make it to the archive as it was botched.

Also modify the commit log as I requested.

  Luis
