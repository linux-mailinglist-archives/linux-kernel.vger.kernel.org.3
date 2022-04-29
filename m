Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F46F515165
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379368AbiD2RP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244469AbiD2RP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:15:57 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE103914B;
        Fri, 29 Apr 2022 10:12:38 -0700 (PDT)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 23THCCOg002537;
        Sat, 30 Apr 2022 02:12:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 23THCCOg002537
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651252333;
        bh=67OrUMxmi8c2orxD4qJYEnt8eFDU607uv+w+xWvgsbI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G1+Igqp3LdvVUYVkvD2XWWDkrazVuKwzj3MokRMF2sVuQ77Ti/SyEQE1Sdp4g5rWn
         pxpdmVave9hNUfHkqAKR1RKablgomr+gn4TrX015VXi/mFi4K8JnSrmXWgGACIhv8h
         bDCAv+d2Xl0r8aQTe2qGO9gYIBed0rVhHNc3R3ZHvvKYVPfazLh4Ki7FOxhows097j
         r1cZZM+Y6sLBJ8ylHcX/+U0uSyvt4lohO7FicSPQ9T5Tuxo9ja2ByDO9lVLEt7cyJg
         wKb2YcVawqveGYXSH/QIt9Dz3Mav2rkrMKljpeAn50pVL1XSWV2r9uy6p6AQnCV1v8
         8LHZzQ5PybV7w==
X-Nifty-SrcIP: [209.85.216.46]
Received: by mail-pj1-f46.google.com with SMTP id iq10so7676981pjb.0;
        Fri, 29 Apr 2022 10:12:12 -0700 (PDT)
X-Gm-Message-State: AOAM532cetTCDVZDYT9VFdtI2/Hs6t9rGKyxSbNTeVOivFAwXLm6nvZr
        RaS+e9QdcgqLsr6jN74HBYNKFKYHAm3mdESvhyo=
X-Google-Smtp-Source: ABdhPJwdwySlw6cb0FmE+czfzMkfz3BUnPYoAYs+/L1RcfNAhr9w0+UCL8KJjpANjNYpdjIV8RVG9lwGeugMqUdWCdE=
X-Received: by 2002:a17:90a:e7d1:b0:1da:30d0:9327 with SMTP id
 kb17-20020a17090ae7d100b001da30d09327mr160696pjb.144.1651252331727; Fri, 29
 Apr 2022 10:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220426155229.436681-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220426155229.436681-1-mailhol.vincent@wanadoo.fr>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 30 Apr 2022 02:11:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAST1uRCLaNwfSLbO-sEy9MdjB54i2EkA6NOw=etNi8oBQ@mail.gmail.com>
Message-ID: <CAK7LNAST1uRCLaNwfSLbO-sEy9MdjB54i2EkA6NOw=etNi8oBQ@mail.gmail.com>
Subject: Re: [RFC PATCH] kbuild: call checksyscalls.sh and check-atomics.sh
 only if prerequisites change
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 12:52 AM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> Currently, checksyscalls.sh and check-atomics.sh are executed
> unconditionally. Most developers will not modify the files being
> checked by those scripts and thus do not need to execute these again
> for each iterative make. Change Kbuild target so that those two
> scripts get executed only if the prerequisite are modified.
>
> In order to implement this we:
>
>   1. use the if_change macro instead of cmd. c.f. [1]
>
>   2. create two dot files: scripts/.checksyscalls and
>   scripts/atomic/.check-atomics to keep track of whether the script
>   were already executed or not. Otherwise, the prerequisite would
>   always be considered as newer than the target (c.f. output "due to
>   target missing" of make V=2).
>
>   3. modify the CLEAN_FILES target of the root Makefile to removed the
>   two temporary dot files created in 2.
>
> We also added an additional dependency to include/linux/atomic/* for
> check-atomics.sh to make sure that the script gets executed again if
> the header are modified. check-atomics.sh already has a dependency
> toward include/generated/asm-offsets.h and so no additional
> dependencies were added.
>
> [1] https://www.kernel.org/doc/html/latest/kbuild/makefiles.html#command-change-detection
>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> Sending this as RFC because I am not an expert of Kbuild. The use of
> the dot files was my best shot at tackling this issue. Maybe there is
> a smarter way which I just missed?
>
> If I receive no comments for the next two weeks, I will resend this
> patch without the RFC tag.
> ---
>  Kbuild   | 14 ++++++++------
>  Makefile |  3 ++-
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/Kbuild b/Kbuild
> index fa441b98c9f6..d579f4971aa3 100644
> --- a/Kbuild
> +++ b/Kbuild
> @@ -39,21 +39,23 @@ $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
>  #####
>  # Check for missing system calls
>
> -always-y += missing-syscalls
> +always-y += scripts/.missing-syscalls
>
>  quiet_cmd_syscalls = CALL    $<
>        cmd_syscalls = $(CONFIG_SHELL) $< $(CC) $(c_flags) $(missing_syscalls_flags)
>
> -missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
> -       $(call cmd,syscalls)
> +scripts/.missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
> +       $(call if_changed,syscalls)
> +       @touch $@

I am not sure about this hunk.

Avoiding the needless preprocess is good.
But, it is better to display a warning somewhere (maybe 'all' target)
until the required syscall is implemented.

Also, you need to check the timestamp of syscall_32.tbl.
When it is updated (i.e. when a new syscall is added),
this check must be re-run.


>  #####
>  # Check atomic headers are up-to-date
>
> -always-y += old-atomics
> +always-y += scripts/atomic/.old-atomics
>
>  quiet_cmd_atomics = CALL    $<
>        cmd_atomics = $(CONFIG_SHELL) $<
>
> -old-atomics: scripts/atomic/check-atomics.sh FORCE
> -       $(call cmd,atomics)
> +scripts/atomic/.old-atomics: scripts/atomic/check-atomics.sh $(wildcard include/linux/atomic/*) FORCE
> +       $(call if_changed,atomics)
> +       @touch $@


Presumably, this is wrong.
If the header is manually edited, Kbuild must stop the build.

This change just lets it keep going, and
what is worse, the warning is completely silenced
second time.







> diff --git a/Makefile b/Makefile
> index fa5112a0ec1b..b18af9d4248a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1483,7 +1483,8 @@ endif # CONFIG_MODULES
>  # Directories & files removed with 'make clean'
>  CLEAN_FILES += include/ksym vmlinux.symvers modules-only.symvers \
>                modules.builtin modules.builtin.modinfo modules.nsdeps \
> -              compile_commands.json .thinlto-cache
> +              compile_commands.json .thinlto-cache \
> +              scripts/.missing-syscalls scripts/atomic/.old-atomics
>
>  # Directories & files removed with 'make mrproper'
>  MRPROPER_FILES += include/config include/generated          \
> --
> 2.35.1
>


-- 
Best Regards
Masahiro Yamada
