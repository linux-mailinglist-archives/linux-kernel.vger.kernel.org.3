Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEF75072F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354634AbiDSQdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiDSQdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:33:41 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A5B167E5;
        Tue, 19 Apr 2022 09:30:57 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id i20so31988704ybj.7;
        Tue, 19 Apr 2022 09:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1swu2cTkh+aC67hs8/dbpRCHUF/l5DGtGfoyG/d6XKk=;
        b=J1/ruRcPMJaZq7qjrrx0TXkP7nD6MSIfWnWk/OX7rYokdQP1KbskYA6fUlCZvLuSFn
         g8uX9SA372G0zPzbIjeC09mCtoKuZs25RzV9vnfZ0oZ/Jdzkf8kftk3/lwdpyJK6PcqR
         6EyuXx2Rl+iyHeD5syP8HVXch2F0mjzBt61d5L92QNS4nfooxLW+Rayw5VObfyZ3dIOr
         cUzikfsP2hXeHmEbH/8AiaEvbdqDHH3hIuyYLrImNgzx4xOM+2g5zLhU7fQN3GeRSEf6
         dVzVMf740SlVQuXgLcyRldJ7VXU8zR2IGdx/DSH5Z57QJmMIaplMBfJ6wNpP71kXh2kY
         0ang==
X-Gm-Message-State: AOAM532Jv5Yd0NMFwGFd1HYvdjFkBWCR8sNAdcXmDnlY2zMCYLaFYTmD
        UmAh9CSZWyqlp9bcaPEaWJug3tFwHILyI0wrpho=
X-Google-Smtp-Source: ABdhPJwgJQoyFgoJ4viOOB7zae8VQfrZU3484x23p0NkjJKHc4tOrAbCdxVE+zqLVq/2BAz68JJcq87Hc3UBhR5fH7w=
X-Received: by 2002:a05:6902:187:b0:63d:9c95:edca with SMTP id
 t7-20020a056902018700b0063d9c95edcamr15432354ybh.81.1650385856684; Tue, 19
 Apr 2022 09:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220415133356.179706384@linutronix.de> <20220415161206.817702355@linutronix.de>
In-Reply-To: <20220415161206.817702355@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Apr 2022 18:30:45 +0200
Message-ID: <CAJZ5v0hzpitKZJxuP_UuMWpJJoYaLBqd4iHawn44HzYXYHkf1g@mail.gmail.com>
Subject: Re: [patch 08/10] x86/aperfmperf: Store aperf/mperf data for cpu
 frequency reads
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
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

On Fri, Apr 15, 2022 at 9:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Now that the MSR readout is unconditional, store the results in the per CPU
> data structure along with a jiffies timestamp for the CPU frequency readout
> code.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/cpu/aperfmperf.c |   14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -24,11 +24,17 @@
>  #include "cpu.h"
>
>  struct aperfmperf {
> +       seqcount_t      seq;
> +       unsigned long   last_update;
> +       u64             acnt;
> +       u64             mcnt;
>         u64             aperf;
>         u64             mperf;
>  };
>
> -static DEFINE_PER_CPU_SHARED_ALIGNED(struct aperfmperf, cpu_samples);
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct aperfmperf, cpu_samples) = {
> +       .seq = SEQCNT_ZERO(cpu_samples.seq)
> +};
>
>  struct aperfmperf_sample {
>         unsigned int    khz;
> @@ -515,6 +521,12 @@ void arch_scale_freq_tick(void)
>         s->aperf = aperf;
>         s->mperf = mperf;
>
> +       raw_write_seqcount_begin(&s->seq);
> +       s->last_update = jiffies;
> +       s->acnt = acnt;
> +       s->mcnt = mcnt;
> +       raw_write_seqcount_end(&s->seq);
> +
>         scale_freq_tick(acnt, mcnt);
>  }
>
>
