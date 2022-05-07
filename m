Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A47D51E6B1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 13:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446287AbiEGLrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 07:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiEGLrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 07:47:49 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129F547398;
        Sat,  7 May 2022 04:44:03 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2f7d621d1caso104513787b3.11;
        Sat, 07 May 2022 04:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9MOQZCLM9tndvvAIgvvf8nfJ90wdD6mwqwPCAcBgMQc=;
        b=Y4TnKKNM3WdzsSeONQXzi01Edvqv3bD8qk+LURWWedAXlfJqQvnJFm4nEa7Re4nsYC
         4yLxmHcbU9h8CckErbhJfNB2UUA9ma6XdiYZ/K7S6aYW1tLaIQAQBwu4xNzz5f9R5Kw0
         PVilO/DPoVw3lGwRggMCFYTRrW0jldywioyCLNU4ehWR9UOxQ3Up8MluiJLrern9PnJJ
         lgv5rSPZu/Hc0jm5981SELz5W88vN1ZWa3ZzlqDAARu98nldReQoWAjBmck8QvWUpyUV
         QsFcF8LeF/oypqXPvmdyplBYRBq1kWFBnFM3d0yorcrt8etx9t8B3l+oe4Vf41pkZM9o
         WG8A==
X-Gm-Message-State: AOAM530JVRsrfcnlZkAoMgj3Vfzj9Dv0vZgKMeMTS8QvNmOONGnLoe9c
        ffxm3f+6PYpP3NahC8BXEZOE1Sr1eepVK9jNZ08=
X-Google-Smtp-Source: ABdhPJyPBjXsBnNAOGooKjQhes3+s7T6g2NnqiNuz2irYPvv4jOxqc6kNjLoyXwFJh/kbltFvHUmcWgah9xURY6piYw=
X-Received: by 2002:a81:2dc5:0:b0:2f5:c6c8:9ee5 with SMTP id
 t188-20020a812dc5000000b002f5c6c89ee5mr6366303ywt.518.1651923842223; Sat, 07
 May 2022 04:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220426155229.436681-1-mailhol.vincent@wanadoo.fr> <CAK7LNAST1uRCLaNwfSLbO-sEy9MdjB54i2EkA6NOw=etNi8oBQ@mail.gmail.com>
In-Reply-To: <CAK7LNAST1uRCLaNwfSLbO-sEy9MdjB54i2EkA6NOw=etNi8oBQ@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 7 May 2022 20:43:50 +0900
Message-ID: <CAMZ6RqKpU++hxn2BNNox4G0zrjLs-w+S+UTiteGDqFemNRjjfg@mail.gmail.com>
Subject: Re: [RFC PATCH] kbuild: call checksyscalls.sh and check-atomics.sh
 only if prerequisites change
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat. 30 Apr 2022 at 02:11, Masahiro Yamada <masahiroy@kernel.org> wrote:
> On Wed, Apr 27, 2022 at 12:52 AM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
> >
> > Currently, checksyscalls.sh and check-atomics.sh are executed
> > unconditionally. Most developers will not modify the files being
> > checked by those scripts and thus do not need to execute these again
> > for each iterative make. Change Kbuild target so that those two
> > scripts get executed only if the prerequisite are modified.
> >
> > In order to implement this we:
> >
> >   1. use the if_change macro instead of cmd. c.f. [1]
> >
> >   2. create two dot files: scripts/.checksyscalls and
> >   scripts/atomic/.check-atomics to keep track of whether the script
> >   were already executed or not. Otherwise, the prerequisite would
> >   always be considered as newer than the target (c.f. output "due to
> >   target missing" of make V=2).
> >
> >   3. modify the CLEAN_FILES target of the root Makefile to removed the
> >   two temporary dot files created in 2.
> >
> > We also added an additional dependency to include/linux/atomic/* for
> > check-atomics.sh to make sure that the script gets executed again if
> > the header are modified. check-atomics.sh already has a dependency
> > toward include/generated/asm-offsets.h and so no additional
> > dependencies were added.
> >
> > [1] https://www.kernel.org/doc/html/latest/kbuild/makefiles.html#command-change-detection
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> > Sending this as RFC because I am not an expert of Kbuild. The use of
> > the dot files was my best shot at tackling this issue. Maybe there is
> > a smarter way which I just missed?
> >
> > If I receive no comments for the next two weeks, I will resend this
> > patch without the RFC tag.
> > ---
> >  Kbuild   | 14 ++++++++------
> >  Makefile |  3 ++-
> >  2 files changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/Kbuild b/Kbuild
> > index fa441b98c9f6..d579f4971aa3 100644
> > --- a/Kbuild
> > +++ b/Kbuild
> > @@ -39,21 +39,23 @@ $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
> >  #####
> >  # Check for missing system calls
> >
> > -always-y += missing-syscalls
> > +always-y += scripts/.missing-syscalls
> >
> >  quiet_cmd_syscalls = CALL    $<
> >        cmd_syscalls = $(CONFIG_SHELL) $< $(CC) $(c_flags) $(missing_syscalls_flags)
> >
> > -missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
> > -       $(call cmd,syscalls)
> > +scripts/.missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
> > +       $(call if_changed,syscalls)
> > +       @touch $@
>
> I am not sure about this hunk.
>
> Avoiding the needless preprocess is good.
> But, it is better to display a warning somewhere (maybe 'all' target)
> until the required syscall is implemented.

The classic way to achieve is to raise an error, not a warning.

This should have been achievable through CONFIG_WERROR, however,
the below commit deactivated it with -Wno-error (rationale of why
this was an issue is missing).

commit 20fbb11fe4ea ("don't make the syscall checking produce errors
from warnings")

If we just warn, I am not sure how to emit a warning each time
until it gets fixed. The normal behaviour everywhere else is to
only warn during the first build and be quiet (unless
dependencies change).

> Also, you need to check the timestamp of syscall_32.tbl.
> When it is updated (i.e. when a new syscall is added),
> this check must be re-run.

ACK

Regardless of the above discussion, I think I will give up on
checksyscalls.sh, at least for the moment. The patch assumed that
checksyscalls.sh would only be called from ./Kbuild. It appears
that there is another user: arch/mips/Makefile c.f. kernel test
robot's report:
https://lore.kernel.org/llvm/202205030015.JCmg5yPS-lkp@intel.com/

Because of that, only creating a single empty file to check the
timestamp is insufficient and I could not find a smart way to
manage all this.

> >  #####
> >  # Check atomic headers are up-to-date
> >
> > -always-y += old-atomics
> > +always-y += scripts/atomic/.old-atomics
> >
> >  quiet_cmd_atomics = CALL    $<
> >        cmd_atomics = $(CONFIG_SHELL) $<
> >
> > -old-atomics: scripts/atomic/check-atomics.sh FORCE
> > -       $(call cmd,atomics)
> > +scripts/atomic/.old-atomics: scripts/atomic/check-atomics.sh $(wildcard include/linux/atomic/*) FORCE
> > +       $(call if_changed,atomics)
> > +       @touch $@
>
>
> Presumably, this is wrong.
> If the header is manually edited, Kbuild must stop the build.

Currently (i.e. before my patch), Kbuild does not stop the build either.
c.f. check-atomics.sh which returns 0 inconditionally:
https://elixir.bootlin.com/linux/v5.17/source/scripts/atomic/check-atomics.sh#L33

This can be easily remediated by making check-atomics.sh return
an error code if the check does not succeed.

> This change just lets it keep going, and
> what is worse, the warning is completely silenced
> second time.

Same comment as before, I expect warnings to only be raised once,
making this an error would solve the issue.

I will send a v2 but only for check-atomics.sh


Yours sincerely,
Vincent Mailhol
