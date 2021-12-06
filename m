Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E313D469809
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245563AbhLFOLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:11:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35616 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245536AbhLFOK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:10:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DD04B810A6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 14:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E533C341C6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 14:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638799616;
        bh=jNpkyBy2LEGK+pxuJ/fKbBsEFdWq80XEaW8rDiD8myI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vJBeh8P7FgOVbaf6+WdHqBqTfrThX/CbOfvOpM5acPTZHWsrgMXuEyNFftaxUjgb3
         632wpulGaVuLbdiki6inUoPD069ir8YBEoxr3o3Sm+eVamuMhJDBzW49gwrVZYpgO3
         Nl7rC7bS8VgjuSD9pv+Z4a1rNBjlHOSP2+QhbQtaf4ErqRh4hKibXTzuIeFXKe0ZEI
         cEH42sdZPfnZQ9109aGu0lN6XnE7xKvt1ZJNsBEkaX7JBOqaSMUbqH+omKgVRJ1msR
         sB+XaSCbY1Mla6p6QZBhn0d2vSrzN1SxIgvqG9S8aDR+gxpekYx1s5DY+XiOz8lLaR
         xDeNLycvLGXPQ==
Received: by mail-ot1-f49.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so13668435oto.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 06:06:56 -0800 (PST)
X-Gm-Message-State: AOAM530Khu8KxIaabHiCDwvtffGn+aBL9aFk9V8y8WSJbOa82DX8QbZz
        39I1XIuvVY1NDHICKtq+jvfRgGcIKJCAtjMr0qc=
X-Google-Smtp-Source: ABdhPJyiw5qG991h0TE1ROErwx9As3VFpT4FfBGnAOM+JglRm9rq+LXsqYZwdSKWo4vdn0AOTG+0Fj+DsUz+AeTw3os=
X-Received: by 2002:a05:6830:1514:: with SMTP id k20mr28885568otp.147.1638799615415;
 Mon, 06 Dec 2021 06:06:55 -0800 (PST)
MIME-Version: 1.0
References: <20211206124715.4101571-1-mark.rutland@arm.com>
In-Reply-To: <20211206124715.4101571-1-mark.rutland@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 6 Dec 2021 15:06:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHUtyn9K91jkqdU69-acvGkYsPZ-yeb7dALOeztDpfDvg@mail.gmail.com>
Message-ID: <CAMj1kXHUtyn9K91jkqdU69-acvGkYsPZ-yeb7dALOeztDpfDvg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] linkage: better symbol aliasing
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Slaby <jslaby@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Fuad Tabba <tabba@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 at 13:47, Mark Rutland <mark.rutland@arm.com> wrote:
>
> This series aims to make symbol aliasing simpler and more consistent.
> The basic idea is to replace SYM_FUNC_START_ALIAS(alias) and
> SYM_FUNC_END_ALIAS(alias) with a new SYM_FUNC_ALIAS(alias, name), so
> that e.g.
>
>     SYM_FUNC_START(func)
>     SYM_FUNC_START_ALIAS(alias1)
>     SYM_FUNC_START_ALIAS(alias2)
>         ... asm insns ...
>     SYM_FUNC_END(func)
>     SYM_FUNC_END_ALIAS(alias1)
>     SYM_FUNC_END_ALIAS(alias2)
>     EXPORT_SYMBOL(alias1)
>     EXPORT_SYMBOL(alias2)
>
> ... can become:
>
>     SYM_FUNC_START(name)
>         ... asm insns ...
>     SYM_FUNC_END(name)
>
>     SYM_FUNC_ALIAS(alias1, func)
>     EXPORT_SYMBOL(alias1)
>
>     SYM_FUNC_ALIAS(alias2, func)
>     EXPORT_SYMBOL(alias2)
>
> This avoids repetition and hopefully make it easier to ensure
> consistency (e.g. so each function has a single canonical name and
> associated metadata).
>
> I'm sending this as an RFC since I want to check:
>
> a) People are happy with the idea in principle.
>
> b) People are happy with the implementation within <linux/linkage.h>.
>
> ... and I haven't yet converted the headers under tools/, which is
> largely a copy+paste job.
>
> I've build+boot tested arm64 and x86 defconfig without issues, and I've
> pushed the series to my `linkage/alias-rework` branch on git.kernel.org,
> atop v5.16-rc3:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git linkage/alias-rework
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=linkage/alias-rework
>
> Thanks,
> Mark.
>
> Mark Rutland (6):
>   linkage: add SYM_{ENTRY,START,END}_AT()
>   linkage: add SYM_FUNC_{LOCAL_,}ALIAS()
>   arm64: remove __dma_*_area() aliases
>   arm64: clean up symbol aliasing
>   x86: clean up symbol aliasing
>   linkage: remove START/END ALIAS macros
>

I never understood why we had these start/end markers in the first
place for alias definitions, so good riddance.

Acked-by: Ard Biesheuvel <ardb@kernel.org>


>  Documentation/asm-annotations.rst  | 11 ++--
>  arch/arm64/include/asm/linkage.h   | 24 ---------
>  arch/arm64/kvm/hyp/nvhe/cache.S    |  5 +-
>  arch/arm64/lib/clear_page.S        |  5 +-
>  arch/arm64/lib/copy_page.S         |  5 +-
>  arch/arm64/lib/memchr.S            |  5 +-
>  arch/arm64/lib/memcmp.S            |  6 +--
>  arch/arm64/lib/memcpy.S            | 21 ++++----
>  arch/arm64/lib/memset.S            | 12 +++--
>  arch/arm64/lib/strchr.S            |  6 ++-
>  arch/arm64/lib/strcmp.S            |  6 +--
>  arch/arm64/lib/strlen.S            |  6 +--
>  arch/arm64/lib/strncmp.S           |  8 +--
>  arch/arm64/lib/strnlen.S           |  6 ++-
>  arch/arm64/lib/strrchr.S           |  5 +-
>  arch/arm64/mm/cache.S              | 59 +++++++++-----------
>  arch/x86/boot/compressed/head_32.S |  3 +-
>  arch/x86/boot/compressed/head_64.S |  3 +-
>  arch/x86/lib/memcpy_64.S           | 10 ++--
>  arch/x86/lib/memmove_64.S          |  4 +-
>  arch/x86/lib/memset_64.S           |  6 +--
>  include/linux/linkage.h            | 86 ++++++++++++++++++------------
>  22 files changed, 146 insertions(+), 156 deletions(-)
>
> --
> 2.30.2
>
