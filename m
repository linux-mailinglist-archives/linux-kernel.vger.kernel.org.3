Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C080D4AD769
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355495AbiBHLfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356933AbiBHLNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:13:25 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF66C03FEC0;
        Tue,  8 Feb 2022 03:13:24 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d187so18257171pfa.10;
        Tue, 08 Feb 2022 03:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YFEQKVVzNOaEHuMlWL4qcYpT1olb/F5tx4dvneQW0yo=;
        b=DOyJNPmLYfphjf28z8dEI2zNLTZH0O+dyFYtDB4JU/lTCTtmRvRS4QDv5YQG4WYdyo
         fWv4RC1G4KKy4KyGaequKGEgRd0NONo0kDVq7o4AWx5qUzPqD2bpNv8RSOLjALeSx9zA
         98l83ln6V8NGazxfSglQLVCXXcDn2izWhye2fe14WiwRsTDJe9jKtIY0ml3jRvpD3vU/
         Sau4WULphxcdOK8CAjMgTZyhL2fy2RTfdhCDfi+tngAs5WkVmI/ca7Ks4TIrjnc47Bvo
         Svh4wr8ChE5A3KoXGCF1lEvVQFxT6goCMOE/EFPI8TsBAQmlwM6tneTQiSRr7cNGBJwN
         cIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFEQKVVzNOaEHuMlWL4qcYpT1olb/F5tx4dvneQW0yo=;
        b=trf397VaKmeW6JirufigKhXorN7W/OsPe802LMvPzT6NGOLCdxrlGJsVYxSegPnB2z
         IpoOx6oQwyLvbaJCteAjq3d9MZHH1UlpK+f6+VvVyd7eW91ovR6lcTF5sW5wFlux+Ea5
         om9Koro837/QBJxmpIm/kKPKBBqAPjrGoUXXftG+rnbfTU59Fyif/FQ3HsupD0LJXZKq
         PqAhGNBNeBKbzdwCeZvLh4RifohI1TTQuL9GLfD0D82uBlshLuz/Ce7tWMEvGHjmLYmk
         BELVoAc8y5c2/WH+lpWJkUg0Eu7u/U62jv0/zwfmcXC/l/IR/uUEkyITgD8h4WUJ9FL9
         NuvA==
X-Gm-Message-State: AOAM530/h/u/bZqWZZwhQAnRGHbE2Vy3vuDqs+Kc8qWIV3LUOIZ/UUjG
        16V8XbTttEYbTTYpVM0ryEXfL/wkgvjNmwwsT5g=
X-Google-Smtp-Source: ABdhPJzdONo62zeDu6h1dBWNsmEjg4DmZB9Osgwxi5ELrZsFeghB3SV8KVUTVkxfTuPWGRrpTfXHBp5YFYvUjroGzTo=
X-Received: by 2002:a65:4c08:: with SMTP id u8mr3054349pgq.90.1644318803836;
 Tue, 08 Feb 2022 03:13:23 -0800 (PST)
MIME-Version: 1.0
References: <CALkUMdSVV=Vju3TtryObKney7Q1TJLgGd7G7OB4X3FW9eJf4-w@mail.gmail.com>
 <20220208110231.2896-1-vimal.agrawal@sophos.com>
In-Reply-To: <20220208110231.2896-1-vimal.agrawal@sophos.com>
From:   Vimal Agrawal <avimalin@gmail.com>
Date:   Tue, 8 Feb 2022 16:43:12 +0530
Message-ID: <CALkUMdQmyo861C87+oVG7=sf_xPL05DvUd29aiE+GQ3S9f4ALw@mail.gmail.com>
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

Hi Luis,

I tried to fix the existing 'best' logic so that my hunk can come
under (!best) in patch v6.

test_module.ko with symbols
============================
vimal@ubuntu2:~/linux-next/linux/lib$ sudo dmesg
[ 4955.983315] test_module: module verification failed: signature
and/or required key missing - tainting kernel
[ 4955.983972] test_module: Hello, world
[ 4955.983975] symbol name for address of test_module_warn_init is
test_module_warn_init+0x0/0x7 [test_module]
[ 4955.983989] symbol name for address of test_module_warn_start is
test_module_warn_start+0x0/0x7 [test_module]
[ 4955.983999] symbol name for address of fun_ptr is
fun_ptr+0x0/0xfffffffffffff000 [test_module]

test_module.ko with symbols stripped using --strip-unneeded
============================================================
vimal@ubuntu2:~/linux-next/linux/lib$ !nm
nm test_module.ko
0000000000000000 r .LC0
0000000000000000 D __this_module
                 U _printk
0000000000000000 T cleanup_module
0000000000000007 T init_module

vimal@ubuntu2:~/linux-next/linux/lib$ sudo dmesg
[ 5043.436960] test_module: Hello, world
[ 5043.436966] symbol name for address of test_module_warn_init is
[module __init]+0x0/0x7 [test_module]
[ 5043.436979] symbol name for address of test_module_warn_start is
[module]+0x0/0x7 [test_module]
[ 5043.436988] symbol name for address of fun_ptr is
cleanup_module+0x1ff9/0xff9 [test_module]

patch in test_module.c used for testing:
diff --git a/lib/test_module.c b/lib/test_module.c
index debd19e35198..068fce67c41a 100644
--- a/lib/test_module.c
+++ b/lib/test_module.c
@@ -14,9 +14,25 @@
 #include <linux/module.h>
 #include <linux/printk.h>

+
+static void test_module_warn_start(int x)
+{
+        if (x) WARN_ON_ONCE(1);
+}
+
+static void (*fun_ptr)(int) = &test_module_warn_start;
+
+static void __init test_module_warn_init(int x)
+{
+        if (x) WARN_ON_ONCE(1);
+}
+
 static int __init test_module_init(void)
 {
        pr_warn("Hello, world\n");
+        printk("symbol name for address of test_module_warn_init is
%pS\n", test_module_warn_init);
+        printk("symbol name for address of test_module_warn_start is
%pS\n", test_module_warn_start);
+        printk("symbol name for address of fun_ptr is %pS\n", &fun_ptr);

        return 0;
 }

Note that it is still not fully correct for fun_ptr ( which is .data
or .ro) as it is resolving to cleanup_module in .text.
To fix this, we need to have information in core_layout for the range
of .data and .text separately or have
something like data_layout for data. That will be beyond the scope of
this patch.

I am not sure why you are not able to reproduce. If you can share the
output of > nm test_module.ko after
stripping and after using my patch for test_module.c then I can
possibly make out. I think kernel configs
should not matter, it is how test_module.ko is built and stripped that
should define this.

Vimal

On Tue, Feb 8, 2022 at 4:32 PM Vimal Agrawal <avimalin@gmail.com> wrote:
>
> If kernel modules are stripped off symbols for some reason then stack
> traces in dmesg do not show symbol name for address. It just prints
> absolute address sometimes (if there is no good match with any symbol)
>
> This was seen with OpenWrt which uses option INSTALL_MOD_STRIP=
> "--strip-unneeded" at kernel/module build/install time, and so modules
> are stripped off unneeded symbols.
>
> [245864.699580]  do_nmi+0x12f/0x370
> [245864.699583]  end_repeat_nmi+0x16/0x50
> [245864.699585] RIP: 0010:0xffffffffc06b67ec                           <<<<<<<<
> [245864.699585] RSP: 0000:ffffaaa540cffe48 EFLAGS: 00000097
> [245864.699586] RAX: 0000000000000001 RBX: ffff93357a729000 RCX: 0000000000000001
> [245864.699587] RDX: ffff93357a729050 RSI: 0000000000000000 RDI: ffff93357a729000
> [245864.699588] RBP: ffff9335cf521300 R08: 0000000000000001 R09: 0000000000000004
> [245864.699588] R10: ffffaaa545b23ed0 R11: 0000000000000001 R12: ffffffffc06b61a0
> [245864.699589] R13: ffffaaa540cffe60 R14: ffff9335c77fa3c0 R15: ffff9335cf51d7c0
> [245864.699590]  ? 0xffffffffc06b61a0
> [245864.699592]  ? 0xffffffffc06b67ec                                  <<<<<<<<
> [245864.699593]  ? 0xffffffffc06b67ec
> [245864.699594]  </NMI>
>
> Note RIP: 0010:0xffffffffc06b67ec and 0xffffffffc06b67ec printed in above
> stack trace as absolute address. There is no easy way in case box crashes
> as we loose information on load address of specific module.
>
> This changes the symbol decoding (in kernel/module.c) such that it can
> print offset from start of section (.text or .init.text) in case there
> is no good match with any symbol.
>
> It will now decode address in such cases to [module]+ offset/size or
> [module __init]+offset/size depending on where the address lies (in
> core/.text or init/.init.text section of module).
>
> One can use objdump/readelf/nm to find symbols with offset from .init.text
> and .text sections.
>
> steps to reproduce the problem:
> -------------------------------
> 1. Add WARN_ON_ONCE(1) in module e.g. test_module.c
> 2. Build and strip the module using --strip-unneeded option
> 3. Load the module and check RIP in dmesg
>
> tests done:
> -----------
> 1. Added WARN_ON_ONE(1) in functions of a module for testing
> -------------------------------------------------------------
> [  407.934085] CPU: 0 PID: 2956 Comm: insmod Tainted: G        W   E     5.16.0-rc5-next-20211220+ #2
> [  407.934087] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> [  407.934088] RIP: 0010:[module __init]+0x4/0x7 [test_module]
> [  407.934097] Code: Unable to access opcode bytes at RIP 0xffffffffc07edfda.
> [  407.934098] RSP: 0018:ffffb21440487c20 EFLAGS: 00010202
> [  407.934100] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [  407.934101] RDX: 0000000000000000 RSI: ffffffff9c38e5e1 RDI: 0000000000000001
> [  407.934102] RBP: ffffb21440487c28 R08: 0000000000000000 R09: ffffb21440487a20
> [  407.934103] R10: ffffb21440487a18 R11: ffffffff9c755248 R12: ffffffffc07ee007
> [  407.934104] R13: ffff92a0f1e260b0 R14: 0000000000000000 R15: 0000000000000000
> [  407.934105] FS:  00007f578ebc4400(0000) GS:ffff92a1c0e00000(0000) knlGS:0000000000000000
> [  407.934107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  407.934108] CR2: ffffffffc07edfda CR3: 00000000063ea006 CR4: 00000000000706f0
> [  407.934113] Call Trace:
> [  407.934114]  <TASK>
> [  407.934116]  ? init_module+0x55/0xff9 [test_module]
> ...
> [  407.934232] CPU: 0 PID: 2956 Comm: insmod Tainted: G        W   E     5.16.0-rc5-next-20211220+ #2
> [  407.934234] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> [  407.934242] RIP: 0010:[module]+0x4/0x7 [test_module]
> [  407.934248] Code: Unable to access opcode bytes at RIP 0xffffffffc07e1fda.
> [  407.934249] RSP: 0018:ffffb21440487c20 EFLAGS: 00010202
> [  407.934251] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [  407.934252] RDX: 0000000000000000 RSI: ffffffff9c38e5e1 RDI: 0000000000000001
> [  407.934253] RBP: ffffb21440487c28 R08: 0000000000000000 R09: ffffb21440487a20
> [  407.934254] R10: ffffb21440487a18 R11: ffffffff9c755248 R12: ffffffffc07ee007
> [  407.934255] R13: ffff92a0f1e260b0 R14: 0000000000000000 R15: 0000000000000000
> [  407.934256] FS:  00007f578ebc4400(0000) GS:ffff92a1c0e00000(0000) knlGS:0000000000000000
> [  407.934257] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  407.934258] CR2: ffffffffc07e1fda CR3: 00000000063ea006 CR4: 00000000000706f0
> [  407.934260] Call Trace:
> [  407.934260]  <TASK>
> [  407.934261]  ? init_module+0x5a/0xff9 [test_module]
>
> note that it is able to decode RIP to an offset from module start or
> init start now.
>
> tested on linux->next (tag next-20211220)
>
> Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
> Acked-by: Nishit Shah <nishit.shah@sophos.com>
> Suggested-by: Dirk VanDerMerwe <Dirk.VanDerMerwe@Sophos.com>
> ---
>  kernel/module.c | 44 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/module.c b/kernel/module.c
> index 24dab046e16c..635e631c92f1 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -4260,6 +4260,19 @@ static const char *kallsyms_symbol_name(struct mod_kallsyms *kallsyms, unsigned
>         return kallsyms->strtab + kallsyms->symtab[symnum].st_name;
>  }
>
> +/*
> + * Check if module address (addr) passed is as per init passed
> + * if init is true then check in init layout
> + * else check in core layout
> + */
> +bool match_address_layout(struct module *mod, unsigned long addr, bool init)
> +{
> +       if (init)
> +               return within_module_init(addr, mod);
> +       else
> +               return within_module_core(addr, mod);
> +}
> +
>  /*
>   * Given a module and address, find the corresponding symbol and return its name
>   * while providing its size and offset if needed.
> @@ -4270,14 +4283,22 @@ static const char *find_kallsyms_symbol(struct module *mod,
>                                         unsigned long *offset)
>  {
>         unsigned int i, best = 0;
> -       unsigned long nextval, bestval;
> +       unsigned long baseval, nextval, bestval;
>         struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
> +       char *module_base_name;
> +       bool is_init_address = false;
>
>         /* At worse, next value is at end of module */
> -       if (within_module_init(addr, mod))
> +       if (within_module_init(addr, mod)) {
> +               baseval = (unsigned long)mod->init_layout.base;
>                 nextval = (unsigned long)mod->init_layout.base+mod->init_layout.text_size;
> -       else
> +               module_base_name = "[module __init]";
> +               is_init_address = true;
> +       } else {
> +               baseval = (unsigned long)mod->core_layout.base;
>                 nextval = (unsigned long)mod->core_layout.base+mod->core_layout.text_size;
> +               module_base_name = "[module]";
> +       }
>
>         bestval = kallsyms_symbol_value(&kallsyms->symtab[best]);
>
> @@ -4300,7 +4321,8 @@ static const char *find_kallsyms_symbol(struct module *mod,
>                     || is_arm_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
>                         continue;
>
> -               if (thisval <= addr && thisval > bestval) {
> +               if ((thisval <= addr && thisval > bestval) &&
> +                       (match_address_layout(mod, thisval, is_init_address))) {
>                         best = i;
>                         bestval = thisval;
>                 }
> @@ -4308,8 +4330,20 @@ static const char *find_kallsyms_symbol(struct module *mod,
>                         nextval = thisval;
>         }
>
> -       if (!best)
> +       if (!best) {
> +               if (is_module_text_address(addr)) {
> +                       /*
> +                        * return MODULE base and offset if we could not find
> +                        * any best match for text address
> +                        */
> +                       if (size)
> +                               *size = nextval - baseval;
> +                       if (offset)
> +                               *offset = addr - baseval;
> +                       return module_base_name;
> +               }
>                 return NULL;
> +       }
>
>         if (size)
>                 *size = nextval - bestval;
> --
> 2.32.0
>
