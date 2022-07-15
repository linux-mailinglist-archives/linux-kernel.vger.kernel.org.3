Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1258F5761FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiGOMkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGOMka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:40:30 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C2952DFE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:40:29 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id l11so8182334ybu.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFg14LcgZeTXkwnfeYDRgexezyvnv3PPOW7dv1pA4P8=;
        b=MgzKUYmwoAkXqXd5KzKLIkmvhgxw0vpQqzQDgoqaKs6pF/soK1ZNa2tOcOkV9L6PLZ
         wBVcJfEsn/tqWlctpkCwzUIVhBEmQM3AxvlDIuQgHbAIX5ov9ojWMhWbFkj3Zmv1RSdF
         JO5fTN4rb2liogKFZbHbd1/lqrHXmcW63mcaEa3re5Pcj9V0IXuVn9Z//MTEn2IsvS78
         Kso+taRua7VpAw4UpGcQWmYwXxjkX01mpE8mmCjdP871lLz/AoTH4guUdfIV6bvIBkkd
         ObTO1xyNdA7tOH6GMF+MpTLGkBoLhvcxPvVw1aF69x/Ds1WbV6/SjU8pxw/Nfcsc24rr
         gL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFg14LcgZeTXkwnfeYDRgexezyvnv3PPOW7dv1pA4P8=;
        b=sV2gR1qsOPKP7m/3JMU+kwyZorZ5jN9/sXoE8B/rRMksLn3xPZjerzmi+NvagTb8Vh
         /QBNT1Ak7ZZCYIfhf7UzF50BXf3Qt+2HI4hjtZWGPStKxAuJNowCY2UVbhIgcOqtj2+X
         aHfkvGitD+ySyZFkAtsSgl8pH0eBCNITIidU/lhymSWKBqY3WY5HTxfK0mnB8+ff10g3
         PP3g/NOlgvXeIoxcuiw7bES4wxvjLQvM1metE2D9jzCmDy2EhVrhDtltTEt4fX1AHgKG
         gP1U3vOszk4xD5rpULlnAMZII9IqE/40nxYOl3WOeP4HSEyu4ij7y9zmRMfdvg9xHgif
         mDpA==
X-Gm-Message-State: AJIora+hPFiPGUVreXl6g6ajVUZuiDIqRHB5bZOzI9eQduCJ+W4XUQ9B
        I2XZIQX9c0Gxuyfs8hwJrRqEN4ZN6uAbWHtlcK/mRw==
X-Google-Smtp-Source: AGRyM1sw01W+gq/gh9ZPzSWhiZEYPNEYPsXHwsXTS43Azg2CScUfHjXmj1/LWvn0fMHkp54AVE1N5zbFE2XE6uhCmkY=
X-Received: by 2002:a5b:885:0:b0:66f:a7f5:23a4 with SMTP id
 e5-20020a5b0885000000b0066fa7f523a4mr13203832ybq.87.1657888828869; Fri, 15
 Jul 2022 05:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220715120152.17760-1-pmladek@suse.com>
In-Reply-To: <20220715120152.17760-1-pmladek@suse.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 15 Jul 2022 14:39:52 +0200
Message-ID: <CANpmjNOHY1GC_Fab4T6J06vqW0vRf=4jQR0dG0MJoFOPpKzcUA@mail.gmail.com>
Subject: Re: [PATCH] printk: Make console tracepoint safe in NMI() context
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        kasan-dev@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 at 14:02, Petr Mladek <pmladek@suse.com> wrote:
>
> The commit 701850dc0c31bfadf75a0 ("printk, tracing: fix console
> tracepoint") moved the tracepoint from console_unlock() to
> vprintk_store(). As a result, it might be called in any
> context and triggered the following warning:
>
>   WARNING: CPU: 1 PID: 16462 at include/trace/events/printk.h:10 printk_sprint+0x81/0xda
>   Modules linked in: ppdev parport_pc parport
>   CPU: 1 PID: 16462 Comm: event_benchmark Not tainted 5.19.0-rc5-test+ #5
>   Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
>   EIP: printk_sprint+0x81/0xda
>   Code: 89 d8 e8 88 fc 33 00 e9 02 00 00 00 eb 6b 64 a1 a4 b8 91 c1 e8 fd d6 ff ff 84 c0 74 5c 64 a1 14 08 92 c1 a9 00 00 f0 00 74 02 <0f> 0b 64 ff 05 14 08 92 c1 b8 e0 c4 6b c1 e8 a5 dc 00 00 89 c7 e8
>   EAX: 80110001 EBX: c20a52f8 ECX: 0000000c EDX: 6d203036
>   ESI: 3df6004c EDI: 00000000 EBP: c61fbd7c ESP: c61fbd70
>   DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010006
>   CR0: 80050033 CR2: b7efc000 CR3: 05b80000 CR4: 001506f0
>   Call Trace:
>    vprintk_store+0x24b/0x2ff
>    vprintk+0x37/0x4d
>    _printk+0x14/0x16
>    nmi_handle+0x1ef/0x24e
>    ? find_next_bit.part.0+0x13/0x13
>    ? find_next_bit.part.0+0x13/0x13
>    ? function_trace_call+0xd8/0xd9
>    default_do_nmi+0x57/0x1af
>    ? trace_hardirqs_off_finish+0x2a/0xd9
>    ? to_kthread+0xf/0xf
>    exc_nmi+0x9b/0xf4
>    asm_exc_nmi+0xae/0x29c
>
> It comes from:
>
>   #define __DO_TRACE(name, args, cond, rcuidle) \
>   [...]
>                 /* srcu can't be used from NMI */       \
>                 WARN_ON_ONCE(rcuidle && in_nmi());      \
>
> It might be possible to make srcu working in NMI. But it
> would be slower on some architectures. It is not worth
> doing it just because of this tracepoint.
>
> It would be possible to disable this tracepoint in NMI
> or in rcuidle context. Where the rcuidle context looks
> more rare and thus more acceptable to be ignored.
>
> Alternative solution would be to move the tracepoint
> back to console code. But the location is less reliable
> by definition. Also the synchronization against other
> tracing messages is much worse.
>
> Let's ignore the tracepoint in rcuidle context as the least
> evil solution.
>
> Link: https://lore.kernel.org/r/20220712151655.GU1790663@paulmck-ThinkPad-P17-Gen-1
>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  include/trace/events/printk.h | 11 ++++++++++-
>  kernel/printk/printk.c        |  2 +-
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/include/trace/events/printk.h b/include/trace/events/printk.h
> index 13d405b2fd8b..a3ee720f41b5 100644
> --- a/include/trace/events/printk.h
> +++ b/include/trace/events/printk.h
> @@ -7,11 +7,20 @@
>
>  #include <linux/tracepoint.h>
>
> -TRACE_EVENT(console,
> +TRACE_EVENT_CONDITION(console,
>         TP_PROTO(const char *text, size_t len),
>
>         TP_ARGS(text, len),
>
> +       /*
> +        * trace_console_rcuidle() is not working in NMI. printk()
> +        * is used more often in NMI than in rcuidle context.
> +        * Choose the less evil solution here.
> +        *
> +        * raw_smp_processor_id() is reliable in rcuidle context.
> +        */
> +       TP_CONDITION(!rcu_is_idle_cpu(raw_smp_processor_id())),
> +

Couldn't this just use rcu_is_watching()?

  | * rcu_is_watching - see if RCU thinks that the current CPU is not idle

Thanks,
-- Marco
