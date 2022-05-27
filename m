Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A9E53646E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353496AbiE0O7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 10:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiE0O7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 10:59:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725072656D;
        Fri, 27 May 2022 07:59:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 711AFCE256E;
        Fri, 27 May 2022 14:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C535C34113;
        Fri, 27 May 2022 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653663553;
        bh=5ZBNSbfmjq92LowajidklGD+Z02KoWvQUl31Q4yU7uI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RB8t3Q7nazMIVRBTyfQUPn68EkiuLAT8CGFZYfb/zXniLNDEE1HY3/VcK+cRkLnvs
         jJDJK+Nwe0yhCH/xk2DzopLFyzkEm0sTWsK/dgJJex8TDFX+mDL+DnHFwd2Kp+OiM5
         5sQY6Er6cbQ69yyKbxhwBbnv1GDIn1rua4jv5+u8yoLWJqqvN8hC+wWypteDdDezpo
         PkflE4+Bi/+8Xe5/XV92rjQS0+meFviGLCcEO1gfmFKEtjaQoOX3cciqEPbgaSNj+b
         e6gllBRoXwZJa+6P3iiSRQtt2Xr+YEybqvbSJ2L6CgGrQZb9scBvzDJCzSIjtOAa+z
         XxKIloafgwV3Q==
Date:   Fri, 27 May 2022 07:59:11 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with the kbuild tree
Message-ID: <20220527145911.fsr4wwlgymgtxcrr@treble>
References: <20220523142431.10ff2f77@canb.auug.org.au>
 <20220523154758.11668628@canb.auug.org.au>
 <20220523162307.45dycvqld7maaj7l@treble>
 <CAK7LNAR5XWPhmTJV42sYiFCDan6DfB8gsOCJOWiqz4MV1cdE4Q@mail.gmail.com>
 <20220527044711.hrqxx5gz3jghydax@treble>
 <CAK7LNATeHZK+qv9e375fsZwtiuUE_MrfBA9Rhzz3uY8tF4EXUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNATeHZK+qv9e375fsZwtiuUE_MrfBA9Rhzz3uY8tF4EXUg@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 03:04:57PM +0900, Masahiro Yamada wrote:
> On Fri, May 27, 2022 at 1:47 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Fri, May 27, 2022 at 11:19:02AM +0900, Masahiro Yamada wrote:
> > > [1] original behavior in Josh's commit
> > >
> > > $ git checkout 753da4179d08b625d8df72e97724e22749969fd3
> > > $ make defconfig
> > > $ make -j8 kernel/
> > > $ head -n 1   kernel/.fork.o.cmd
> > >
> > >
> > > I do not see the "--linked" parameter in the objtool command.
> > >
> > >
> > >
> > >
> > > [2] behavior in linux-next
> > >
> > >
> > > $ git checkout next-20220523
> > > $ make defconfig
> > > $ make -j8 kernel/
> > > $ head -n 1   kernel/.fork.o.cmd
> > >
> > > I see the "--linked" parameter in the objtool command.
> > >
> > > kernel/fork.o  is a direct output from GCC,
> > > not from linker.
> >
> > Yes, good catch.  That flag should only be used for linked objects like
> > vmlinux.o or some_module.o.
> >
> > Objtool only runs on such objects when CONFIG_LTO_CLANG,
> > CONFIG_X86_KERNEL_IBT, or CONFIG_NOINSTR_VALIDATION (vmlinux.o-only) is
> > enabled.
> >
> > --
> > Josh
> 
> 
> When CONFIG_LTO_CLANG=y or CONFIG_X86_KERNEL_IBT=y
> is "--linked" necessary for single-object modules?

Yes.

> "single-object module" means a module that consists of only one object.
> 
> See this figure:
> https://patchwork.kernel.org/project/linux-kbuild/patch/20220513113930.10488-6-masahiroy@kernel.org/

Nice patch description!

> In your commit, --linked is passed to all *.prelink.o
> whether it consists of a single object or links
> multiple objects.

Yes, we want to keep that behavior.  Thanks!

-- 
Josh
