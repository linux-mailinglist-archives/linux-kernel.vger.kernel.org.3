Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356405195FC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 05:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344371AbiEDDcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 23:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343502AbiEDDbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 23:31:51 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E1613A
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 20:28:16 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id r11so365626ybg.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 20:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9FJwQCrIwdOgk5TBiW4fZIwz7YdVA9O8EgN31+EQpM=;
        b=A/kA4+FBweAr9lVyBTELBbGu9MrjxfHDgMNZieroE6twWBKa0ozA98z4GsZqBTYDW3
         S+tkUjiaivxuGA18dVlvBzfgH+HV7zi/eOwfotkb4xUzCI4jLNDndRmkC6uX5AoFPpPD
         oqpkzdvGprG1P/w7A4UNVO05F4hH/9zHUb1ZXsIDaXWQ0WWHvAuZuK0KyjDHRTbEUIGk
         ZLhqJxvvriMH1Eggz9hshHRAMZPLyHPkyEJdF1YFpMvVGNgp8/A8Cb3bkKiMj5ayRHCd
         xiWy0YffXzZk/qMbQfHVulsO2vqDggBXWwv3hg5pXTtM5GVcPV+U1G51GTFqnMyXsauT
         i4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9FJwQCrIwdOgk5TBiW4fZIwz7YdVA9O8EgN31+EQpM=;
        b=kSKoeS0txatfBEOpqZ5zI/NrCgoKNhoWw+QrmOg5FWrwBBqtjCCjIBUM6B0D0aj9Ve
         J+eoLjpmUB59DMBqac2DPV0M1VqyW5tTm0DcmlcYo9sY02T3nQkdggE12AT8mLBd1iGo
         +8p/m2eFa+dGXi2MurAisYFe7Fks7YoL2oDTK/ElDTRn7+6ZYSuVr/8mhctAMRZMoxwO
         8H/BEvP8Bx07+m9lxZ7AXQChb1ogldr6JlLO+rBCgXhXUHObzDke1nWcqBbYylwpN3MW
         /iPpYMpn9n56uem7g7HtolIcl/+JliZ0CIFU05sB+yG2vmzugKbzKON8APWs9VivHDnQ
         3Qtw==
X-Gm-Message-State: AOAM531khc+sQwx2kOk73oMnmHVYMeN0u5I8M6u9YxsM8q7qg496AQMV
        qha1URDK26na42XP5zGIS1JRSM+pYbfk4cQFrm25L7K/jvs=
X-Google-Smtp-Source: ABdhPJxg5zoFR8qLr9OHBxcx2aPHWBf18tbQHiTK5nxyByE5sZWTpONjJFbTOZEPKdz4f+cpktC++OySLL9aSPyzZzs=
X-Received: by 2002:a25:d1d6:0:b0:649:73e3:e49e with SMTP id
 i205-20020a25d1d6000000b0064973e3e49emr9738209ybg.315.1651634895588; Tue, 03
 May 2022 20:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220502045102.40005-1-ppbuk5246@gmail.com> <20220504120903.057867b1b2e2fb2b2a542470@kernel.org>
In-Reply-To: <20220504120903.057867b1b2e2fb2b2a542470@kernel.org>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Wed, 4 May 2022 12:28:01 +0900
Message-ID: <CAM7-yPT5DDUvQiyVmExa4=6hdK0mSW7eWxmXYSZN=ErAUM9suA@mail.gmail.com>
Subject: Re: [PATCH] kprobe: sync issue's on ftraced-kprobe.
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, naveen.n.rao@linux.ibm.com,
        "David S. Miller" <davem@davemloft.net>, rostedt@goodmis.org,
        yun.wang@linux.alibaba.com, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> NAK this, because get_kprobes() doesn't require the kprobe_mutex in
> the preempt-disabled context. Please read the comment of get_kprobe().
>
> /*
>  * This routine is called either:
>  *      - under the 'kprobe_mutex' - during kprobe_[un]register().
>  *                              OR
>  *      - with preemption disabled - from architecture specific code.
>  */
> struct kprobe *get_kprobe(void *addr)

> Moreover, we can not use mutex inside kprobe handler because it runs
> in the interrupt context.

Actually, I think it's in the preemption disabled in situation.
What I mentioned is actually it seems inside the kprobe handler which
installed via ftrace isn't interrupt context.

#ifdef CONFIG_KPROBES_ON_FTRACE
static struct ftrace_ops kprobe_ftrace_ops __read_mostly = {
 >---.func = kprobe_ftrace_handler,
 >---.flags = FTRACE_OPS_FL_SAVE_REGS,
 };

In case of optimized kprobe it disables preemption when it enter
"optimized callback"
And the trampoline isn't the interrupted context.
It's also the same to install kprobe via ftraced .
When I see the ftraced patched code, I couldn't find any interrupt and
preemption disable code.
But it seems to allow preemption in ftarce handler.
(In the ftrace_reg_caller, ftace_reg_end, and other ftrace trampoline code also)

What I understand is break point based kprobe is only interrupted
disabled status
But optimized kprobe and ftarced kprobe isn't interrupted disabled status.
For this, optimized kprobe disable disable preemption in "optimized_callback"

But ftrace kprobe isn't preemption disabled nor interrupt-disabled context.

That's why I sent patches and I experienced the problem above.

Am I missing something?

Thx.
