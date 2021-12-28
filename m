Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8072548058D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 02:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbhL1Bqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 20:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbhL1Bqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 20:46:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1AEC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 17:46:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FC7DB80DB5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 01:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AB0C36AF1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 01:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640655997;
        bh=mjMPdfsMzHzMEpxECmqLNdrjmh9lTK/VO8tIjj96n1Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gbRipaF7oEYv5HCfvCUZqxneuNKKpkl3/96GQInRJQFaieuvwP3kYFHxWtOSzccam
         bI+ED2V7KceRwbKLif4Uj+8eGVkLPnEkffxeUy0feqioOJn8lm9NO/OdJV3mx2C7gV
         zlsMCOfMi0pD29fyY2L6xky7sAJ60TA4+jCP47zm78rB2OGJ02IMgW0/TP3ZcLRieo
         mslX2u9OlfvFeQDoqhB6DL6M4pnaFrlRzD5QvoksFK7FjkP78K7E8CeavhOs1L0sqA
         0TRyH67/+GDpzwXvupnwlUnA/QMkoKyO0s04zhOP8YsBwZcrFg+3GFnVHy1ebWz/AD
         YxKHKy3sW5XEQ==
Received: by mail-vk1-f177.google.com with SMTP id h5so1352948vkp.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 17:46:37 -0800 (PST)
X-Gm-Message-State: AOAM531B9YesRdPJnhUjneUD+qR+D5MlxAOt113XyLyTkxoSifR0KmPg
        xRIjhpOKV3pSTNcVGvtq4WH6nULFk8zZUCQ9p48=
X-Google-Smtp-Source: ABdhPJxRNTQvGHYbvLAVVWqYBnBsGTNB+DeDNm+ZAPMfyl/Fd6VZlGDo6UDhmeH+oYK1YxfdcWfxBubXCJj7gCVvtyc=
X-Received: by 2002:a1f:e243:: with SMTP id z64mr5352942vkg.28.1640655995969;
 Mon, 27 Dec 2021 17:46:35 -0800 (PST)
MIME-Version: 1.0
References: <20211227184851.2297759-1-nathan@kernel.org> <20211227184851.2297759-4-nathan@kernel.org>
In-Reply-To: <20211227184851.2297759-4-nathan@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 28 Dec 2021 09:46:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSB8rT=g_v=NAE1YmM_qNWAVj=H5mrnty-zPVXOKYCARg@mail.gmail.com>
Message-ID: <CAJF2gTSB8rT=g_v=NAE1YmM_qNWAVj=H5mrnty-zPVXOKYCARg@mail.gmail.com>
Subject: Re: [PATCH 3/3] csky: Fix function name in csky_alignment() and die()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Brian Cain <bcain@codeaurora.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

Three wrong parts in csky! you forgot mm/fault.c.

Eric's patch seems not to cc me? Why arm64 is correct, csky is wrong. -_*!

here is the wrong patch part:
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9ae24e3b72be1..11a28cace2d25 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -302,7 +302,7 @@ static void die_kernel_fault(const char *msg,
unsigned long addr,
show_pte(addr);
die("Oops", regs, esr);
bust_spinlocks(0);
- do_exit(SIGKILL);
+ make_task_dead(SIGKILL);
}
#ifdef CONFIG_KASAN_HW_TAGS
diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
index cb2a0d94a144d..5e2fb45d605cf 100644
--- a/arch/csky/abiv1/alignment.c
+++ b/arch/csky/abiv1/alignment.c
@@ -294,7 +294,7 @@ bad_area:
__func__, opcode, rz, rx, imm, addr);
show_regs(regs);
bust_spinlocks(0);
- do_exit(SIGKILL);
+ make_dead_task(SIGKILL);
}
force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr);
diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
index e5fbf8653a215..88a47035b9256 100644
--- a/arch/csky/kernel/traps.c
+++ b/arch/csky/kernel/traps.c
@@ -109,7 +109,7 @@ void die(struct pt_regs *regs, const char *str)
if (panic_on_oops)
panic("Fatal exception");
if (ret != NOTIFY_STOP)
- do_exit(SIGSEGV);
+ make_dead_task(SIGSEGV);
}
void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 466ad949818a6..7215a46b6b8eb 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -67,7 +67,7 @@ static inline void no_context(struct pt_regs *regs,
unsigned long addr)
pr_alert("Unable to handle kernel paging request at virtual "
"addr 0x%08lx, pc: 0x%08lx\n", addr, regs->pc);
die(regs, "Oops");
- do_exit(SIGKILL);
+ make_task_dead(SIGKILL);
}

On Tue, Dec 28, 2021 at 2:50 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> When building ARCH=csky defconfig:
>
> arch/csky/kernel/traps.c: In function 'die':
> arch/csky/kernel/traps.c:112:17: error: implicit declaration of function
> 'make_dead_task' [-Werror=implicit-function-declaration]
>   112 |                 make_dead_task(SIGSEGV);
>       |                 ^~~~~~~~~~~~~~
>
> The function's name is make_task_dead(), change it so there is no more
> build error.
>
> Fixes: 0e25498f8cd4 ("exit: Add and use make_task_dead.")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/csky/abiv1/alignment.c | 2 +-
>  arch/csky/kernel/traps.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
> index 5e2fb45d605c..2df115d0e210 100644
> --- a/arch/csky/abiv1/alignment.c
> +++ b/arch/csky/abiv1/alignment.c
> @@ -294,7 +294,7 @@ void csky_alignment(struct pt_regs *regs)
>                                 __func__, opcode, rz, rx, imm, addr);
>                 show_regs(regs);
>                 bust_spinlocks(0);
> -               make_dead_task(SIGKILL);
> +               make_task_dead(SIGKILL);
>         }
>
>         force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr);
> diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
> index 88a47035b925..50481d12d236 100644
> --- a/arch/csky/kernel/traps.c
> +++ b/arch/csky/kernel/traps.c
> @@ -109,7 +109,7 @@ void die(struct pt_regs *regs, const char *str)
>         if (panic_on_oops)
>                 panic("Fatal exception");
>         if (ret != NOTIFY_STOP)
> -               make_dead_task(SIGSEGV);
> +               make_task_dead(SIGSEGV);
>  }
>
>  void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
> --
> 2.34.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
