Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8019F47AAE1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhLTODy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:03:54 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42370 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbhLTODx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:03:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D5645CE10DA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271DCC36AED
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640009030;
        bh=bPKiX+8jJwxqxaprS1JmXvLTrG48KvnlDMVxkN7OFbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=neci6bJ5ARsw7TZS1v4XYQMlwGD3ZiVOlxc4GNe7v4DjRkqpEKXz4zQsiWp2TDMpw
         04dYKK3YfCidzlFI9iaYUl2sdtXh1dmWnfaKxMTNgUetCeUNNu6bKTQsLHgnKRR36m
         /be8L3FXxeylj9bOlyWqr0XEVdzQ5KGiXmU5NJL/PjdUEoZ0PBLQh3yxG4eJSh9rv1
         2FYsKABN4gCe9Y7AGow3th6BAKrTNel/dnZwIJe0LNoFAa577uoUZfiZs7FUGdxtv+
         M3sc4MLmTicHJJU+xzQUW6Ht82elcQJFVf0O3tUX5gS9UYH7H/EQJ6dSvrB1o02vpb
         HrfKMmfMCpllA==
Received: by mail-wr1-f50.google.com with SMTP id q16so20325958wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:03:50 -0800 (PST)
X-Gm-Message-State: AOAM533YaYm4oqc89HCdiRRdbm/5YtsfJuUorEZCsJEwIqWsGA4EFBQ+
        6ktNfbsEs8EZTQayv2fSvi8MxRKiEXC7OB7dNVw=
X-Google-Smtp-Source: ABdhPJzBpdpvGiiJ4qIik9Z4FCJ+PCqE74SgR6Q/Xbr20R+VLueDh0Qtg/ZmiHZcKIEFZM9TLRIylnJX1GqXS9T0VJI=
X-Received: by 2002:adf:c450:: with SMTP id a16mr12436578wrg.454.1640009028187;
 Mon, 20 Dec 2021 06:03:48 -0800 (PST)
MIME-Version: 1.0
References: <20211220140142.922323-1-frederic@kernel.org>
In-Reply-To: <20211220140142.922323-1-frederic@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 20 Dec 2021 15:03:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEBWJVGtRVKRkxeJc5bj4Cbb9oA_67PyJDYhTwiaHc7jA@mail.gmail.com>
Message-ID: <CAMj1kXEBWJVGtRVKRkxeJc5bj4Cbb9oA_67PyJDYhTwiaHc7jA@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: Support dynamic preemption v3
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Frederic,

On Mon, 20 Dec 2021 at 15:01, Frederic Weisbecker <frederic@kernel.org> wrote:
>
> Hi,
>
> I haven't seen much comments on the static key based version from Mark
> so I don't know which direction we'll eventually take. I still hope we
> can focus on a unified static call based implementation, considering
> there are other users waiting on arm64 static calls.
>

Which other users are you referring to here?

> So here is a rebase against the latest tip:sched/core and arm64 static
> call proposal.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
>         preempt/arm-v4
>
> HEAD: 6fc1c7e3d83c4e06b019b041894d9bb25f37ac6c
>
> Thanks,
>         Frederic
> ---
>
> Frederic Weisbecker (3):
>       sched/preempt: Prepare for supporting !CONFIG_GENERIC_ENTRY dynamic preemption
>       arm64: Implement IRQ exit preemption static call for dynamic preemption
>       arm64: Implement HAVE_PREEMPT_DYNAMIC
>
> Ard Biesheuvel (2):
>       static_call: Use non-function types to refer to the trampolines
>       arm64: implement support for static call trampolines
>
>
>  arch/Kconfig                         |  1 -
>  arch/arm64/Kconfig                   |  3 ++
>  arch/arm64/include/asm/preempt.h     | 23 ++++++++++-
>  arch/arm64/include/asm/static_call.h | 40 +++++++++++++++++++
>  arch/arm64/kernel/entry-common.c     | 15 +++++--
>  arch/arm64/kernel/patching.c         | 77 ++++++++++++++++++++++++++++++++++--
>  arch/arm64/kernel/vmlinux.lds.S      |  1 +
>  include/linux/entry-common.h         |  3 +-
>  include/linux/static_call.h          |  4 +-
>  include/linux/static_call_types.h    | 11 ++++--
>  kernel/sched/core.c                  |  6 ++-
>  11 files changed, 168 insertions(+), 16 deletions(-)
