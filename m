Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280AC58CDE5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244092AbiHHSnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244504AbiHHSmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:42:43 -0400
Received: from matoro.tk (unknown [IPv6:2600:1700:4b10:9d80::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475762BD6;
        Mon,  8 Aug 2022 11:42:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; bh=waso6o/gLxP4dp0Ks9iZGKqqKBgpprYF0f4RtQrgunc=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20220801; t=1659984140; v=1; x=1660416140;
 b=tS3+PeZ4x7UIaxySNasrF1pt1JK67oV1k+KCwDmj0FfmR+DyxGPbcI2X7WphaJre39bKKqwz
 JHHhwd6oLizdTJV6NgyrpczO3SD7XlTVqVcnL6cgqepe3shMYX7p62lg0YJ6woTbii34nsJDrD5
 eOQoNKpWsC53wCBzs6RWIliLnoZmrzDF3JWHVVJDnFd8fcDROSqJysd8cEFjOeQbsIfBr4UHFBo
 LIQy4Rrjwa83VBWrL5SQaq0DqHvDe/Ljgv3Fmr5cHjFz38Ijno+QJLZKzG49ext/5lgxMr5AteD
 bBy4oL/zOHYQqabEVQRyF+3ckZnlOKc3Nt9lK0PCScNiCt6vE7LmS1AFo4TOTbcC8GCyJ1mOe14
 VmlPBMQGYi704VFuiifiMn3fuqXfLG/U0ibbkiv+VbNlq+vnrPV4vjOgRCpxukWJRM+uqWw0fju
 qFWmXfnvr2a7HOd3mDkz82Jj0hGCt0ES+LIDJLNXT8XTHqr6I+0gT/QFTQepnTUSJGzNyga1vR7
 jhNBDKOx0VrX50J+vk9fA/Y6/LWH4b0FxNTTEbGYOpnU/xx8XgzcCC7CAH97X/9xFvExnep1m1R
 Db3PJZUJz6muhm1tsfdIvwbp0q3k3TOos2YGryFxa8NKfJudNsdYTachK2NbyBSBwpZHWAFH/+b
 SAD76p7mvNE=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id d390d774; Mon, 08 Aug
 2022 14:42:20 -0400
MIME-Version: 1.0
Date:   Mon, 08 Aug 2022 14:42:20 -0400
From:   matoro <matoro_mailinglist_kernel@matoro.tk>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups (modpost,
 LTO, MODULE_REL_CRCS, export.h)
In-Reply-To: <CAK7LNATa1fdwQsuC3LOkzhr1SaR6ipJqe1b0fAC1pk3LX9wDhA@mail.gmail.com>
References: <20220513113930.10488-1-masahiroy@kernel.org>
 <CAK7LNAQvneCi11myLpkikuXh=i5PLtTaLe0nGpDZXgv_Q1L0Ow@mail.gmail.com>
 <2c496d24174e63b27ec047f383df6700@matoro.tk>
 <CAK7LNASWKhj0tZK6jA1PsYje+idTjzdbYa9avyGeakVScj843A@mail.gmail.com>
 <38a9853e59db8946999316ce3a6b4621@matoro.tk>
 <CAK7LNATa1fdwQsuC3LOkzhr1SaR6ipJqe1b0fAC1pk3LX9wDhA@mail.gmail.com>
Message-ID: <d4f30a7313f1ff43d0c919fc556f08fe@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That patch doesn't apply to the v5.19 stable tag, so I just manually 
edited and it worked perfect!  Thank you!!

Sorry I didn't mention that warning - I did see it, but it still showed 
up even on the old kernel, so I thought it was irrelevant.  Much 
appreciated!

-------- Original Message --------
Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups 
(modpost, LTO, MODULE_REL_CRCS, export.h)
Date: 2022-08-08 13:36
 From: Masahiro Yamada <masahiroy@kernel.org>
To: matoro <matoro_mailinglist_kernel@matoro.tk>

On Mon, Aug 8, 2022 at 10:27 PM matoro
<matoro_mailinglist_kernel@matoro.tk> wrote:
> 
> I have real hardware for all these arches in my collection.  I use it
> for testing the latest kernel and toolchains on as many of the
> less-popular arches as possible, exactly to find issues like this one 
> :)
> 
> Specifically we support all of these in Gentoo.  To double-check this
> wasn't a config issue, I asked another user who also runs sparc to try
> building 5.19 with his config (not copying mine), and he observed the
> same problem.  You can reach us in #gentoo-sparc on Libera.
> 
> As for testing, I make all this hardware available on an as-needed
> basis.  So if you can't or don't want to fiddle with qemu, just let me
> know (email or IRC, same username on Libera), and I will get you direct
> access to my hardware.  Thanks!!


I found the root cause.

When I build the sparc kernel, I see a warning

WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation
failed, symbol will not be versioned.


Then, modpost missed to write out the entry.

With the following patch, you will be able to load the module.

I will send a patch with a proper commit log tomorrow. I need some sleep 
now.



diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 29474cee10b1..337bd36a890a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2206,13 +2206,11 @@ static void add_exported_symbols(struct buffer
*buf, struct module *mod)
         /* record CRCs for exported symbols */
         buf_printf(buf, "\n");
         list_for_each_entry(sym, &mod->exported_symbols, list) {
-               if (!sym->crc_valid) {
+               if (!sym->crc_valid)
                         warn("EXPORT symbol \"%s\" [%s%s] version
generation failed, symbol will not be versioned.\n"
                              "Is \"%s\" prototyped in
<asm/asm-prototypes.h>?\n",
                              sym->name, mod->name, mod->is_vmlinux ? "" 
: ".ko",
                              sym->name);
-                       continue;
-               }

                 buf_printf(buf, "SYMBOL_CRC(%s, 0x%08x, \"%s\");\n",
                            sym->name, sym->crc, sym->is_gpl_only ? 
"_gpl" : "");














