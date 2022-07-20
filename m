Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1009B57B9A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiGTPao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiGTPam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:30:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4571ADBF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:30:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i132-20020a1c3b8a000000b003a2fa488efdso1577280wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbQQtxk91yWYRZraNSUPdpEN5EtZ/LYwfMBL5CTtBFk=;
        b=ZgSdDrcTcr6JhWUwgLeeh1yQ9u58+Ab4TLY/9NWJ14ctjS/Cf0hA1uIf+uSICo6sG+
         ja1ASwrj+j4d7rSxdTiJhAQaduieXoyDaMRRlIyE0izCCB/pe5JK0sLW441PeVUHkiss
         LqOTAbZGsNFTPI0Wr7XJRjxLZmSlinOdklUBHdsOfcdm9HZaWty1jPocbHnuUYDX6pkR
         bTyuznMgGyweD+DMnuutQjBH7vifM4LqFkYE1JochPDmhfeOW66S5FbRQRq8aGJCIUPp
         0fUPHKbaf0ArxF2itLLHnf45BDUn7TOIwaTwwAErb6AT9Cns6qZ/jQtv7C9YsUaZIcnJ
         XZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbQQtxk91yWYRZraNSUPdpEN5EtZ/LYwfMBL5CTtBFk=;
        b=baQrP/YBl8OoJg7GVQGfcoiP4DbVCguDgy7KsRCg/ydw12lHTnvrIvvcIJA5BsZCrU
         X37e9E8mLZOfMBcWWNrZhTmyi1IHQZfE/bRMHEZSJ4qmcYsbcFATSdNsgBkEMtXm3vot
         pR63/dYy4aDdPPoh8/Oe+4w6lcfZstaDg7g7dKMkPXPjSOHB5VymTYgaN0fldZd0SEjR
         8vPaItbQIPuDCJLeTHDdMg57QlvbzQMmJzQElQOzxnBPskK8fQtlGqzoLm/6CrXNVDDX
         sdd0bkKFUQTqLbcWizliovfDObsiskBJq3HQxOW/f35sYFDW83OSp32uZfshc0fS/Qyr
         BQ/g==
X-Gm-Message-State: AJIora9PNjFREWW4IRVKsYhLcsG5TJpgKuu4ryfj1trwtSxXyxHjRZRi
        cw6x2xweJpcCEkcP1dugfIQeYfnxh+/Q3aDHSgZj6A==
X-Google-Smtp-Source: AGRyM1sy4lIt5WZk/5VWHmNj+E1KQce0Jhi+vNS6UD5M14DwPu5vweqB/Nip957rArEL/RP2momlLO0zY+G4KGjgDBI=
X-Received: by 2002:a05:600c:19d2:b0:3a3:2cdb:cc02 with SMTP id
 u18-20020a05600c19d200b003a32cdbcc02mr1916330wmq.182.1658331040002; Wed, 20
 Jul 2022 08:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-6-elver@google.com>
In-Reply-To: <20220704150514.48816-6-elver@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 08:30:26 -0700
Message-ID: <CAP-5=fUySGaL32RQH5AuXjRCuBe8E6Nacarg8z1nkS38RkzZHg@mail.gmail.com>
Subject: Re: [PATCH v3 05/14] perf/hw_breakpoint: Mark data __ro_after_init
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
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

On Mon, Jul 4, 2022 at 8:06 AM Marco Elver <elver@google.com> wrote:
>
> Mark read-only data after initialization as __ro_after_init.
>
> While we are here, turn 'constraints_initialized' into a bool.
>
> Signed-off-by: Marco Elver <elver@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  kernel/events/hw_breakpoint.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 6d09edc80d19..7df46b276452 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -46,7 +46,7 @@ struct bp_cpuinfo {
>  };
>
>  static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
> -static int nr_slots[TYPE_MAX];
> +static int nr_slots[TYPE_MAX] __ro_after_init;
>
>  static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
>  {
> @@ -62,7 +62,7 @@ static const struct rhashtable_params task_bps_ht_params = {
>         .automatic_shrinking = true,
>  };
>
> -static int constraints_initialized;
> +static bool constraints_initialized __ro_after_init;
>
>  /* Gather the number of total pinned and un-pinned bp in a cpuset */
>  struct bp_busy_slots {
> @@ -739,7 +739,7 @@ int __init init_hw_breakpoint(void)
>         if (ret)
>                 goto err;
>
> -       constraints_initialized = 1;
> +       constraints_initialized = true;
>
>         perf_pmu_register(&perf_breakpoint, "breakpoint", PERF_TYPE_BREAKPOINT);
>
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
