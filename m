Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DE35071E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353859AbiDSPiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354055AbiDSPh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:37:57 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69DAB86D;
        Tue, 19 Apr 2022 08:35:08 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id d19so3311109ybc.5;
        Tue, 19 Apr 2022 08:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYK+mSus6lKX2J8+IsFXmSmlA2Ef7OVLzpY5/HdayQU=;
        b=1vWRS+SKfTOMQ41+nkvzPNmMv+QmXfavjtNUEGor68WJBuAnaVv46NdV1cVX4sSSdT
         n/fFdaEzeQle88onvg7B9xhTojuz2uY/AehxdyZ3E7rjUJGo1to0zLBSKrWA93qm70D2
         P6dG01Swbug1DQdbcGjaBGJZ6gEckf8Zt2yybwigRF2UCH9UVtXTf1Ckm2llO0BhhuxM
         XgNOdiJzBVdNZOJNQZdl9CRyluUpr27vYbk0cqhUYX6+VgQSS0CZH68QhjYGuUAyZ5uZ
         fGNFnH3XZ1s18gZMgha2GMCLCQu6SAL9KPW2rgH9GrQ8PE7ZfNLCepB5SVyRiBIs2d83
         XYqg==
X-Gm-Message-State: AOAM531wHevyrykZ3ph+hmrAPfApqRKL1tikxYXX2kCpBKRzsZOOQFfQ
        DQsWBRiLjQ/ihSzc9z4j4RZpuL1FgBqDdMpok+w=
X-Google-Smtp-Source: ABdhPJwDmO9+9C24sXjAZavu7CzsApnTtTT7vU16/f1c9ZI+vpUjXzYeo8Lw4VND0xYUMo6HcRe2v4Fqm3mIsA16qcw=
X-Received: by 2002:a25:ac9b:0:b0:641:3c32:bee7 with SMTP id
 x27-20020a25ac9b000000b006413c32bee7mr14411799ybi.633.1650382507645; Tue, 19
 Apr 2022 08:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220415133356.179706384@linutronix.de> <20220415161206.419880163@linutronix.de>
In-Reply-To: <20220415161206.419880163@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Apr 2022 17:34:56 +0200
Message-ID: <CAJZ5v0iNhn-TYiAWrY_m5+uOCOf-g3F-rzf1RjbEzmOcU4gVsQ@mail.gmail.com>
Subject: Re: [patch 01/10] x86/aperfmperf: Dont wake idle CPUs in arch_freq_get_on_cpu()
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

On Fri, Apr 15, 2022 at 9:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> aperfmperf_get_khz() already excludes idle CPUs from APERF/MPERF sampling
> and that's a reasonable decision. There is no point in sending up to two
> IPIs to an idle CPU just because someone reads a sysfs file.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/cpu/aperfmperf.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -139,6 +139,9 @@ unsigned int arch_freq_get_on_cpu(int cp
>         if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
>                 return 0;
>
> +       if (rcu_is_idle_cpu(cpu))
> +               return 0;
> +
>         if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
>                 return per_cpu(samples.khz, cpu);
>
>
