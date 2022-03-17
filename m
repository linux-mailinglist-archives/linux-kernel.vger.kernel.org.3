Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0944DD07B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiCQWFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiCQWFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:05:04 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A168E116B52
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:03:45 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id e22so7464803ioe.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTabM7n0BoyDX6ZD2j1IXdmhWUV9Un2uw2keLgRSpCA=;
        b=B7vyF3M3g03Oull46QpewO+Evk7OZKsDT2Dl3123BE9ScGlhRxPaFPHX0Wn4ji5F9x
         d5xzwzdbyqNY2CNoeTejfMdV3kD+BtTkOKDV3O8TuB4CjeBdW4cmpWk4HhvuthtcWDf5
         eRs2E3lfbxX4vRXOh62LnkRhV/PlgPnau5DWBi0MPiIZZj03sOs0iW6vyLoJnkkVu5ZY
         F1Da53joklwPYW9449PxQi1h80vhkf0o60ZjXtW9zgeH+xHLPXtF/X5hacYn4RKRb/+L
         kKA6kT/KIWkajcvYJiCdK6FvCFYd9hXrLOCaFrY4WrK8mMjgbh1CviY0KGqb2HFdBDF8
         AVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTabM7n0BoyDX6ZD2j1IXdmhWUV9Un2uw2keLgRSpCA=;
        b=54MteByLfzM0X+fXLzE5SIvFxX1fGwT1O6BlBqu2zEOxBXItVdXNepBfUaamkImVAb
         A/jqR9ylOPL4Q4PWOJj/pK/PR1kCAx5Lxr6CWzdlbCoHkRy7ynjGTwY3msNRtJSLZjTa
         GLQB0pGAdLseEwzVsgJfUkjUOtbtyglkRq6xHu5zMexE89oCOnxOz8iBPZYDbAtzh7Ar
         W9VPawIsBtGWtfRpP/2R0PnzzDK7PX2qo8m0DZ0GckreDD8G7RHU3SqiJZuszQaljZz4
         ccYKJ4IWu/QIEHPSTXw0DI1HOwT6KtG0qBP0fMEnFmZ/Xz1EwGXbPnmHqx8ov720gT8Y
         QR+w==
X-Gm-Message-State: AOAM5313MWMXA9LXi5694qF46WWSQheHZLBJB/OxHAwj9htOXNIb6DL5
        gOdvu8mPYQ9EwFG+qQgcMgOEjaBAnPV1/s9KQOE=
X-Google-Smtp-Source: ABdhPJzmpC3FaPzymZm0MUm+gkG7m5Ndgj5W+M3ddfE+XAu+jt4cb9fOCxWgzYR99WehbuHz/6/roL2lsfaqPRu78vg=
X-Received: by 2002:a05:6638:33a8:b0:319:cb5c:f6d9 with SMTP id
 h40-20020a05663833a800b00319cb5cf6d9mr3189302jav.93.1647554625049; Thu, 17
 Mar 2022 15:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220317152458.213689956@goodmis.org> <20220317152522.284233550@goodmis.org>
In-Reply-To: <20220317152522.284233550@goodmis.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Mar 2022 15:03:33 -0700
Message-ID: <CAEf4BzaN_HnyAkVYeUmYoxvW01cFKR2FW0MwZJBL3gvkRw0TYg@mail.gmail.com>
Subject: Re: [for-next][PATCH 03/13] fprobe: Add ftrace based probe APIs
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 8:25 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: Masami Hiramatsu <mhiramat@kernel.org>
>
> The fprobe is a wrapper API for ftrace function tracer.
> Unlike kprobes, this probes only supports the function entry, but this
> can probe multiple functions by one fprobe. The usage is similar, user
> will set their callback to fprobe::entry_handler and call
> register_fprobe*() with probed functions.
> There are 3 registration interfaces,
>
>  - register_fprobe() takes filtering patterns of the functin names.
>  - register_fprobe_ips() takes an array of ftrace-location addresses.
>  - register_fprobe_syms() takes an array of function names.
>
> The registered fprobes can be unregistered with unregister_fprobe().
> e.g.
>
> struct fprobe fp = { .entry_handler = user_handler };
> const char *targets[] = { "func1", "func2", "func3"};
> ...
>
> ret = register_fprobe_syms(&fp, targets, ARRAY_SIZE(targets));
>
> ...
>
> unregister_fprobe(&fp);
>
> Link: https://lkml.kernel.org/r/164735283857.1084943.1154436951479395551.stgit@devnote2
>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@chromium.org>
> Cc: "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: "David S . Miller" <davem@davemloft.net>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

Hey Steven!

Do I understand correctly that this patch set was applied in your
tree? I was under the impression that we agreed to route this through
the bpf-next tree earlier (see [0]), but I might have misunderstood
something, sorry.

Either way, the reason it matters is because Jiri's multi-attach
kprobe patch set ([1]) is depending on Masami's patches and having
fprobe patches in bpf-next tree would simplify logistics
significantly.

So I wonder if it's still possible to route it through bpf-next?

If not, we'd need a way to get these changes into the bpf-next tree
somehow. Having it in a separate branch that we can merge would be a
way to go about this, I presume? But it's certainly a more complicated
way, so it would be preferable to back it out and land through
bpf-next.

Please let me know how we should proceed. Thanks!

  [0] https://lore.kernel.org/bpf/CAEf4BzaugZWf6f_0JzA-mqaGfp52tCwEp5dWdhpeVt6GjDLQ3Q@mail.gmail.com/
  [1] https://lore.kernel.org/bpf/20220316122419.933957-1-jolsa@kernel.org/

>  include/linux/fprobe.h |  87 +++++++++++++++++
>  kernel/trace/Kconfig   |  12 +++
>  kernel/trace/Makefile  |   1 +
>  kernel/trace/fprobe.c  | 211 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 311 insertions(+)
>  create mode 100644 include/linux/fprobe.h
>  create mode 100644 kernel/trace/fprobe.c
>

[...]
