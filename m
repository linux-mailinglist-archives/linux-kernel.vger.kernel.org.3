Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD0656C335
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240054AbiGHUvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbiGHUvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:51:00 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2923884EEA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:51:00 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id e1-20020a05683013c100b0061c1a6b8d11so1847otq.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 13:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iOGIydgMFyNgxWS6MSkgAIHo8uyw56XkP591wy7NS5w=;
        b=zp1aP5SFkM+DSdELm+do03k/BLomnSrFi1UjsUcdFdj/QmZ1YHYmC7coW0RNTVAgVR
         QYSWil0RE47jOnrBLXLIew3Xosff1Bk7wpXm79co8Ro5PvMwTCkmrWPb/gtkZvWwR3M4
         H1eipJvtPmbv3aSkYVozGXHo+OP5z7SjA5ounHzyxxm5sWEhw1zp7rBpAF05GfnNEwG6
         oYkFWW3BqAeuFThsHBGBY7Za2ZIeKpPyrihfyUVoGLfiZRPQZLb0btDSuqJXj4Sdq7HH
         TOPyjAyGELCkxsu33F2yM1Et12ObcvuNCFttH5LVsJfBWICLuyOjv7fyfZuAV/Hd0GmW
         hZeQ==
X-Gm-Message-State: AJIora+mfF9fyh1PWTFOOErIEMXa8XXwiBU0lny3yXfzdC15zwVhAr+0
        3eq8YZFWaHftKUmGT+kAUK3zb5Pj1MgSwQ0n1kW3xnoQ
X-Google-Smtp-Source: AGRyM1v2mcWJ0OjwOjGsBUU8j6+N4X0VfPk8e1CjLVl5EYg0Om7aQnrtDFo1RzXNDqN5ruhZyQ+djiMIjZt6q2zDl+g=
X-Received: by 2002:a05:6830:1da2:b0:616:93a7:be5f with SMTP id
 z2-20020a0568301da200b0061693a7be5fmr2392924oti.247.1657313459436; Fri, 08
 Jul 2022 13:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220707090900.572584-1-naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <20220707090900.572584-1-naveen.n.rao@linux.vnet.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 8 Jul 2022 13:50:48 -0700
Message-ID: <CAM9d7cjUVd+O3Ftg3vSAEHnZqS2ZAGez26BjyjY_ZZ3ce40qyA@mail.gmail.com>
Subject: Re: [PATCH v2] perf trace: Fix SIGSEGV when processing syscall args
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, cclaudio@linux.ibm.com,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jul 7, 2022 at 2:09 AM Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
>
> On powerpc, 'perf trace' is crashing with a SIGSEGV when trying to
> process a perf.data file created with 'perf trace record -p':
>
>   #0  0x00000001225b8988 in syscall_arg__scnprintf_augmented_string <snip> at builtin-trace.c:1492
>   #1  syscall_arg__scnprintf_filename <snip> at builtin-trace.c:1492
>   #2  syscall_arg__scnprintf_filename <snip> at builtin-trace.c:1486
>   #3  0x00000001225bdd9c in syscall_arg_fmt__scnprintf_val <snip> at builtin-trace.c:1973
>   #4  syscall__scnprintf_args <snip> at builtin-trace.c:2041
>   #5  0x00000001225bff04 in trace__sys_enter <snip> at builtin-trace.c:2319
>
> That points to the below code in tools/perf/builtin-trace.c:
>         /*
>          * If this is raw_syscalls.sys_enter, then it always comes with the 6 possible
>          * arguments, even if the syscall being handled, say "openat", uses only 4 arguments
>          * this breaks syscall__augmented_args() check for augmented args, as we calculate
>          * syscall->args_size using each syscalls:sys_enter_NAME tracefs format file,
>          * so when handling, say the openat syscall, we end up getting 6 args for the
>          * raw_syscalls:sys_enter event, when we expected just 4, we end up mistakenly
>          * thinking that the extra 2 u64 args are the augmented filename, so just check
>          * here and avoid using augmented syscalls when the evsel is the raw_syscalls one.
>          */
>         if (evsel != trace->syscalls.events.sys_enter)
>                 augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
>
> As the comment points out, we should not be trying to augment the args
> for raw_syscalls. However, when processing a perf.data file, we are not
> initializing those properly. Fix the same.
>
> Reported-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/perf/builtin-trace.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 897fc504918b91..f075cf37a65ef8 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4280,6 +4280,7 @@ static int trace__replay(struct trace *trace)
>                 goto out;
>
>         evsel = evlist__find_tracepoint_by_name(session->evlist, "raw_syscalls:sys_enter");
> +       trace->syscalls.events.sys_enter = evsel;
>         /* older kernels have syscalls tp versus raw_syscalls */

Isn't it better to set it after the NULL check below?

>         if (evsel == NULL)
>                 evsel = evlist__find_tracepoint_by_name(session->evlist, "syscalls:sys_enter");
> @@ -4292,6 +4293,7 @@ static int trace__replay(struct trace *trace)
>         }
>
>         evsel = evlist__find_tracepoint_by_name(session->evlist, "raw_syscalls:sys_exit");
> +       trace->syscalls.events.sys_exit = evsel;

Ditto.

Thanks,
Namhyung


>         if (evsel == NULL)
>                 evsel = evlist__find_tracepoint_by_name(session->evlist, "syscalls:sys_exit");
>         if (evsel &&
>
> base-commit: 52f28b7bac75da9b8508f17438c9a8d83ab48e5d
> --
> 2.36.1
>
