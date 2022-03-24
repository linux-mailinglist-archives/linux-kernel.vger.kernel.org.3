Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA1B4E5CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 02:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347097AbiCXBM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 21:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiCXBM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:12:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CFF91AEB;
        Wed, 23 Mar 2022 18:10:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E024B821DC;
        Thu, 24 Mar 2022 01:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5579C340E8;
        Thu, 24 Mar 2022 01:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648084253;
        bh=CsZP5UnSAKxZK3a75AHDxNk3N6tA7qLD8H2KhkTJABQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HJy7j2KmJIUPfXGjZpgJuLuo0cE1Na4spt86TjDCiY5dXQDs/1HONbDGUJz4m+zZ+
         Jr3J8MUDbMwKep69i59cAcfHAz+oW0lPrUxgEAU/++LQN2DiT4jxH3vby+3Imp9Ng0
         Uqqdn756Ar07iiSWUt5vHQxpdWX1rQPGLWmahEwMKZwC+bxnif9bxcNWV4NCBVVlfa
         wboCRx8yVXma7pXdL1Ns1zh1IF5xV0qgTOeYyM1Q5TqJ+Pd1Nor0uHMW5xd2Ij+DuZ
         3Sy6sQRMpBjr96dnryEl/lAF/zFIBboLzpPjJwTdphVutmqhORwtvX20RQaHhz8733
         +RIzPczgJVxsA==
Date:   Thu, 24 Mar 2022 10:10:48 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] bootconfig: Support embedding a bootconfig file
 in kernel
Message-Id: <20220324101048.c929020fd15bc14b50a3fff1@kernel.org>
In-Reply-To: <CAKwvOdk8is=R2qhgKuS_CddvtZzgeJC1Uht84x--TcYykfaiHw@mail.gmail.com>
References: <164724890153.731226.1478494969800777757.stgit@devnote2>
        <164724892075.731226.14103557516176115189.stgit@devnote2>
        <20220316191649.GA11547@pswork>
        <20220318101445.fdb151efe58c6c3a1c572500@kernel.org>
        <20220321183500.GA4065@pswork>
        <20220322120311.690f237b63ddfd9c0e4f78ec@kernel.org>
        <20220322190219.GA26859@pswork>
        <20220323091617.495bfdf5281a543b27f2656f@kernel.org>
        <CAKwvOdk8is=R2qhgKuS_CddvtZzgeJC1Uht84x--TcYykfaiHw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nick,

On Wed, 23 Mar 2022 10:11:53 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Tue, Mar 22, 2022 at 5:16 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Tue, 22 Mar 2022 20:02:19 +0100
> > Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> >
> > > Hello Masami Hiramatsu,
> > >
> > > On Tue, Mar 22, 2022 at 12:03:11PM +0900, Masami Hiramatsu wrote:
> > > > On Mon, 21 Mar 2022 19:35:00 +0100
> > > > Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> > > >
> > > > > Hello Masami Hiramatsu,
> > > > >
> > > > > On Fri, Mar 18, 2022 at 10:14:45AM +0900, Masami Hiramatsu wrote:
> > > > > > On Wed, 16 Mar 2022 20:16:49 +0100
> > > > > > Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> > > > > >
> > > > > > > Hello Masami Hiramatsu,
> > > > > > >
> > > > > > > Also noted that a change in default.bconf requries a clean build, is it
> > > > > > > expected behaviour?
> > > > > >
> > > > > > default.bconf will be always updated if CONFIG_EMBED_BOOT_CONFIG=y. So you can
> > > > > > do incremental build. (I tested it with the incremental build environment)
> > > > > >
> > > > >
> > > > > Thanks, your observation made me to further experiment ther incremental build.
> > > > >
> > > > > Below are the observations I have:
> > > > >
> > > > > When I use GCC for a build; yes, the modified default.conf was observed on
> > > > > the target.
> > > > >
> > > > > But when I use clang; either with FULL or THIN LTO, the modified
> > > > > default.conf doesnt get reflected on the target.
> > > >
> > > > Hmm, curious. So you just add 'CC=clang' on the make command line, right?
> > > Yes, CC=clang ARCH=arm64 LLVM=1. As specified here:
> > > https://docs.kernel.org/kbuild/llvm.html.
> 
> You should just need LLVM=1 (and ARCH=arm64) at this point. LLVM=1
> implies CC=clang.

OK.

> 
> Also, here's the start of the lore thread for folks:
> https://lore.kernel.org/linux-doc/164724892075.731226.14103557516176115189.stgit@devnote2/

Thanks for the link!

> 
> > >
> > > > Can you confirm that following line in your build log,
> > > >
> > > >   GEN     lib/default.bconf
> > > >
> > > Yes, I do see above line. Indeed lib/default.bconf will get incremental
> > > change.
> > >
> > >   GEN     lib/default.bconf
> > >   CC      lib/bootconfig.o
> > >   AR      lib/lib.a
> > >
> > > > and the timestamp of lib/bootconfig.o is built after lib/default.bconf file?
> > > >
> > > Yes, verified timestamp for all above artifacts including vmlinux.o.
> > >
> > > ex:
> > > -rw-rw-r-- 1 psrinivasaia psrinivasaia 22K Mar 22 14:50
> > > ../out/lib/bootconfig.o
> > > -rw-rw-r-- 1 psrinivasaia psrinivasaia 355 Mar 22 14:50
> > > ../out/lib/default.bconf
> > > -rw-rw-r-- 1 psrinivasaia psrinivasaia 54M Mar 22 14:50 ../out/vmlinux.o
> > >
> > > As said incremnetal change was refelected in artifact default.bconf.
> > > But not in vmlinux.o/vmlinux, used below command to verify.
> >
> > Interesting! This sounds clang's issue, because the make command rebuilds
> > the object file including new default.bconf, but the linker (lld?)
> > doesn't link it again correctly.
> 
> Sounds like missing FORCE directives in the Makefiles, perhaps?

Hmm, as you can see in my patch, the default.bconf (contents) already
has the FORCE directive as below.

+ifeq ($(CONFIG_EMBED_BOOT_CONFIG),y)
+# Since the specified bootconfig file can be switched, we forcibly update the
+# default.bconf file always.
+$(obj)/default.bconf: FORCE
+       $(call cmd,defbconf)
+
+quiet_cmd_defbconf = GEN     $@
+      cmd_defbconf = cat < /dev/null $(CONFIG_EMBED_BOOT_CONFIG_FILE) > $@
+clean-files    += default.bconf
+$(obj)/bootconfig.o: $(obj)/default.bconf
+endif

And since bootconfig.o depends on the default.bconf, it is at least compiled
as Padmanabha reported above. If I missed something, please tell me.

> 
> Sami, do you recall any issues like this when implementing
> commit dc5723b02e52 ("kbuild: add support for Clang LTO")
> ?
> 
> >
> > >
> > > llvm-objdump  -s -j .init.data ../out/vmlinux
> > >
> > > On target too, /proc/bootconfig shows old data.
> > >
> > > > And is that related to CONFIG_LTO? What happen if CONFIG_LTO=n?
> > > >
> > > Yes;  CONFIG_LTO_NONE=y  issue not observed even with LLVM binutils.
> >
> > And this issue is related to LTO. Maybe LTO ignores the '.init.data'
> > section update. (Perhaps, LTO only checks the function code hash or
> > something like that instead of the timestamp, and ignore whole object
> > file if all of them are not updated.)
> 
> Sounds like this is a result of the above issue?

As I said above, I used FORCE for the default.bconf and confirmed that
the bootconfig.c is compiled (updated). Thus I think FORCE correctly
works.

I'm not sure how LTO is implemented, but if the LTO works based on the
intermediate representation(IR), I guess it doesn't handle inline asm
".incbin" directive in IR. I mean if the linker only checks the inline
asm as a "string" in the .c file, it will miss the update of the contents
of .incbin directive, because inline asm code itself is not changed.
However the object file itself is updated, since the .incbin directive
embeds an external file to the object file.
This is just my guess. I would like to ask LLVM maintainers to help
checking the safeness of using ".incbin" directive with LTO.
(Note that this is also affects other parts which uses .incbin, like
 /proc/config.gz)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
