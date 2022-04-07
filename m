Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929A64F6F43
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 02:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiDGAhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 20:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiDGAhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 20:37:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E4160CF1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 17:35:39 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d3so5549828wrb.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 17:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5w7pUYCbRdBoHa23cUuLdtaiZ1u8JBOmoeVCOxsIYc=;
        b=lSGGwciFyhcHxHrK4MGsKqf6mYWIK7XeAV9X6Ge2D0VhNLhHx/gwJMXF5BH0DpP+GB
         h73rtZ1tJpdS9PcVsl0FK+qGEKypM3oVDcY3ixChg8X9yh4eXf1lj9CRUJQK/Q7k931W
         XbeoeUtd5dTImccrVaZWtNTL6d2CrdVolvKnTIkElTjmUweaJYw6yk4Wl+hv8gzYnmCF
         P655omeQrQL24Ge/kIrFpnU1vYiYFb3YyZwkI1Y/jQxvEeRAcQaQpI0ziuKqLYRQYWW3
         elSZl3U9nXUTl5715B+AfHf7fYqqQmGzgcinnHH2DekdU7jqdp9DfE5At+p1s5zM6sEl
         5mKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5w7pUYCbRdBoHa23cUuLdtaiZ1u8JBOmoeVCOxsIYc=;
        b=6evRPC+hyK2WEOeHrEGVAFn/KwPvQ/9Yv68HBpqG2tKmO16U41P0JIMb/6yuwjB9Qz
         eIbj07AidZC3+FbCaciBcR6hRkXZ1sHXSdGBw/L+fkEM+4R12zUkwRumlVNmYrCLBxOG
         A8r3gx7HKDNW5njI2QfvDoIza8kDmZT+I9aOjtUgx6Cu8sU4r+tpvlD6Bj87t4cqp6OM
         gES5oYmYlW8BoDKo0xKR+Srr2A7ufz8zHk946yzZebECEeLO5d4wPJQ9R5Uglty308Xx
         xUq+LNbjG+q0olBLIc60v5huFXt4wps8Z6UwLDKCwucJW7SpuBCkX85hvE7spHA3d1so
         CeGg==
X-Gm-Message-State: AOAM530D7RUrK8BDM3VFxm6R2HlyIQCo9VYb5dcOcn1LiS5IuXagJQD/
        i7rUrMLcrV5yhWyoRuQXihlspZXAmJ1QxjjVQbnPsA==
X-Google-Smtp-Source: ABdhPJxwQ7LbJWlplVesSThlFIU2SvtGMkR+Qg5qKG4mzVo/T1gr9HGXrn3Kr1VLtJhXRSOIM2LowYeaqh2FwAaDhCE=
X-Received: by 2002:adf:8123:0:b0:206:1759:f164 with SMTP id
 32-20020adf8123000000b002061759f164mr8827189wrm.654.1649291738024; Wed, 06
 Apr 2022 17:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220406175113.87881-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20220406175113.87881-1-atrajeev@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 Apr 2022 17:35:24 -0700
Message-ID: <CAP-5=fXRphB0gU6CxAuj9Fy40sbwub23RbLLo=5LEY=-_D=3+g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Fix perf bench numa, futex and epoll to work with
 machines having #CPUs > 1K
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, disgoel@linux.vnet.ibm.com,
        mpe@ellerman.id.au, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 10:51 AM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> The perf benchmark for collections: numa, futex and epoll
> hits failure in system configuration with CPU's more than 1024.
> These benchmarks uses "sched_getaffinity" and "sched_setaffinity"
> in the code to work with affinity.
>
> Example snippet from numa benchmark:
> <<>>
> perf: bench/numa.c:302: bind_to_node: Assertion `!(ret)' failed.
> Aborted (core dumped)
> <<>>
>
> bind_to_node function uses "sched_getaffinity" to save the cpumask.
> This fails with EINVAL because the default mask size in glibc is 1024.
>
> Similarly in futex and epoll benchmark, uses sched_setaffinity during
> pthread_create with affinity. And since it returns EINVAL in such system
> configuration, benchmark doesn't run.
>
> To overcome this 1024 CPUs mask size limitation of cpu_set_t,
> change the mask size using the CPU_*_S macros ie, use CPU_ALLOC to
> allocate cpumask, CPU_ALLOC_SIZE for size, CPU_SET_S to set mask bit.
>
> Fix all the relevant places in the code to use mask size which is large
> enough to represent number of possible CPU's in the system.
>
> Fix parse_setup_cpu_list function in numa bench to check if input CPU
> is online before binding task to that CPU. This is to fix failures where,
> though CPU number is within max CPU, it could happen that CPU is offline.
> Here, sched_setaffinity will result in failure when using cpumask having
> that cpu bit set in the mask.
>
> Patch 1 and Patch 2 address fix for perf bench futex and perf bench
> epoll benchmark. Patch 3 and Patch 4 address fix in perf bench numa
> benchmark
>
> Athira Rajeev (4):
>   tools/perf: Fix perf bench futex to correct usage of affinity for
>     machines with #CPUs > 1K
>   tools/perf: Fix perf bench epoll to correct usage of affinity for
>     machines with #CPUs > 1K
>   tools/perf: Fix perf numa bench to fix usage of affinity for machines
>     with #CPUs > 1K
>   tools/perf: Fix perf bench numa testcase to check if CPU used to bind
>     task is online
>
> Changelog:
> From v1 -> v2:
>  Addressed review comment from Ian Rogers to do
>  CPU_FREE in a cleaner way.
>  Added Tested-by from Disha Goel


The whole set:
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/bench/epoll-ctl.c           |  25 ++++--
>  tools/perf/bench/epoll-wait.c          |  25 ++++--
>  tools/perf/bench/futex-hash.c          |  26 ++++--
>  tools/perf/bench/futex-lock-pi.c       |  21 +++--
>  tools/perf/bench/futex-requeue.c       |  21 +++--
>  tools/perf/bench/futex-wake-parallel.c |  21 +++--
>  tools/perf/bench/futex-wake.c          |  22 ++++--
>  tools/perf/bench/numa.c                | 105 ++++++++++++++++++-------
>  tools/perf/util/header.c               |  43 ++++++++++
>  tools/perf/util/header.h               |   1 +
>  10 files changed, 242 insertions(+), 68 deletions(-)
>
> --
> 2.35.1
>
