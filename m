Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC614CA373
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbiCBLVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241423AbiCBLUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:20:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6676EB38
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:19:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82D37617CB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E627FC340F4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646219992;
        bh=rKqEy+mljiJeDH91pzeIIiBqaH2MgyBfQqWXX4aKmok=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JPIfXGZkoZFuGm/k72Osm5X+bYdhBxMIarc3B2pvc/DjsK2TnXr/IvOGEDW2QmGNY
         Z+D+7hql2Gy6NF3FcjsPbzs1RVJZ/wGkfvh8YcTCTkfsU2Vorra3LkRQIkO4QQNzrK
         pO23r2sFIEzF2aDJNuj47mWlronOn0dD2/Ru+64urdY/aRyQ5Fhirqd7yLMeyW/aug
         /Kce2RQ9uW9rdfW2GjtEJIT5ut8Xflu6y7RNGEZk9140gWVLxFHPPYea4Dz8tyzAeb
         iCQ5ntAP+7Asn4laM7X8nuBN61e9JXIS2yzKaRbPFNBWR2CH85rFKSEDMXIGqaS+rF
         afI6lMc13Y5qg==
Received: by mail-yb1-f173.google.com with SMTP id t63so246729ybi.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 03:19:52 -0800 (PST)
X-Gm-Message-State: AOAM533ddWT0iBAYby5PM8gW7d1ydjex2B8NfvTzisSU/jU6wp9KQoWe
        /HutSIN/hEppAR3nNfghQqKF4R4DimRzeFr0QPU=
X-Google-Smtp-Source: ABdhPJyir58z4IxNt3S3okNfI1T+pimKwbjFWQ+Pg+yFw0nwumcefF/SJx5vKgpw93AkHpCC5rOmjnNzE3SNJbeATEo=
X-Received: by 2002:a25:6c43:0:b0:61d:e94b:3c55 with SMTP id
 h64-20020a256c43000000b0061de94b3c55mr28960913ybc.224.1646219991940; Wed, 02
 Mar 2022 03:19:51 -0800 (PST)
MIME-Version: 1.0
References: <Yh5ASXVoWoMj7/Rr@Red> <Yh5AlfprVAZvJDJA@shell.armlinux.org.uk>
 <CAMj1kXGRTM99F_Q29Q4G2Q4L6WSHn2YY+_QZCXQGmw=yWPe1mQ@mail.gmail.com>
 <CAMj1kXEy6n3zZ8Z51kP=tTuOU0xCXLLfC-b6BMpdsjMoM7zGBg@mail.gmail.com>
 <Yh8tWdiWPgZLyQtx@Red> <CAMj1kXGRtdftpoqmd7HBonBBS67jO=YWzoESPAagGfQBZUDQWg@mail.gmail.com>
 <Yh8w7ldudhmbYv4N@Red> <CAMj1kXHri2_tnYhu2gE9xTUOxLY9v1=zODCo1BGfjFTKukiedA@mail.gmail.com>
 <Yh9CbcrfDvN2Z9Y9@Red> <Yh9RI64fThQfnJgS@shell.armlinux.org.uk>
In-Reply-To: <Yh9RI64fThQfnJgS@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 2 Mar 2022 12:19:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGVwXzAAyDeJqAi+eK1hOB3uShiBb_LORL-_YNvikbsAw@mail.gmail.com>
Message-ID: <CAMj1kXGVwXzAAyDeJqAi+eK1hOB3uShiBb_LORL-_YNvikbsAw@mail.gmail.com>
Subject: Re: boot flooded with unwind: Index not found
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 12:12, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Mar 02, 2022 at 11:09:49AM +0100, Corentin Labbe wrote:
> > The crash disappeared (but the suspicious RCU usage is still here).
>
> As the trace on those is:
>
> [    0.239629]  unwind_backtrace from show_stack+0x10/0x14
> [    0.239654]  show_stack from init_stack+0x1c54/0x2000
>
> unwind_backtrace() and show_stack() are both C code, the compiler will
> emit the unwind information for it. show_stack() isn't called from
> assembly code, only from C code, so the next function's unwind
> information should also be generated by the compiler.
>
> However, init_stack is not a function - it's an array of unsigned long.
> There is no way this should appear in the trace, and this suggests that
> the unwind of show_stack() has gone wrong.
>
> I don't see anything obvious in Ard's changes that would cause that
> though.
>
> Did it used to work fine with previous versions of linux-next - those
> versions where we had Ard's "arm-vmap-stacks-v6" tag merged in
> (commit 2fa394824493) and did this only appear when I merged
> "arm-ftrace-for-rmk" (commit 74aaaa1e9bba) ? Did merging
> "arm-ftrace-for-rmk" cause any change in your .config?
>

I can reproduce the RCU warnings, and I have tracked this down to the
change I made to return_address() for the graph tracer, which I
thought was justified after removing the call to
kernel_text_address():

--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -35,26 +35,8 @@ static inline unsigned long
ftrace_call_adjust(unsigned long addr)

 #ifndef __ASSEMBLY__

-#if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND)
-/*
- * return_address uses walk_stackframe to do it's work.  If both
- * CONFIG_FRAME_POINTER=y and CONFIG_ARM_UNWIND=y walk_stackframe uses unwind
- * information.  For this to work in the function tracer many functions would
- * have to be marked with __notrace.  So for now just depend on
- * !CONFIG_ARM_UNWIND.
- */
-
 void *return_address(unsigned int);

-#else
-
-static inline void *return_address(unsigned int level)
-{
-       return NULL;
-}
-
-#endif
-
 #define ftrace_return_address(n) return_address(n)

 #define ARCH_HAS_SYSCALL_MATCH_SYM_NAME

However, the function graph tracer works happily with this bit
reverted, and so that is probably the best course of action here.

I have already sent the patch that reintroduces the
kernel_text_address() check - would you prefer a v2 of that one with
this change incorporated? Or a second patch that just reverts the
above? (Given that the bogus dereference was invoked from
return_address() as well, I suspect that this change would make the
get_kernel_nofault() change I proposed in this thread redundant)
