Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BE15A554C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiH2UIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiH2UIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:08:49 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C1490C6F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:08:48 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id b2so6918310qkh.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qbFnYh6+yxExljXv7kC6ED4iDTkPIabJD2w6r78FSkQ=;
        b=Gtf1g/NXxYZTaLMDW1gcFmpDCBO7bmirrujsGt82JUvmWp7Y1l2zK7QOCmSZwnJcoY
         bOfhEL5HKvYzYnSdH6PUx0/+IDQ5DnR5jCCdMCOc90OfqgE12xC7wOlWBiMxhT5xbTSA
         kDz22UDaG0jqo5VhkBozq3hOuahHSOyrg5fDBJ5Y99esy/ZFF649pHGKRR0hQOLehzQh
         Etmm7LtzVwr78luRpifIl/a6iDgAgxhP5dyBnXKjQbTOdU7tQJ5PqljPi3fBJSN5uS8Z
         ZWa0GWtVL9/dRfVBpaWhEx8Y1qY7aBbnvmSQg5oK8oSEoeuZmVFZuTFhHJXGMonruDRG
         b9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qbFnYh6+yxExljXv7kC6ED4iDTkPIabJD2w6r78FSkQ=;
        b=vMjFXAu1h/FLYutmJQ2/RmB14cnEgTANKB0M+1pMAf/kZLOxVq5kYRdVHjjK4k62oE
         8WHbX90ajPNK81Mx+H5GF7Ja0oWqBuv7YcHGupcHQwLUUIBBjCXZq1XNDksFaa/MvOZe
         3ig34bE1TdqyWMQJ0XzoefpqNWhov1vaqWXwPxamlcrxj4mtGLE0UZkvj2jPUIxRo6wo
         kCzS3CqPKI9FhE3MRTXIGG8cjY38Wissh0nXicmV3pnpFQ3R6By09L0j9FHX0yTsMnxh
         hNuDO466oBHDzy5lfmbOmkMrqyBR9hsiYBOD0Uss1CMthL37WtVqbMMMk6neimWWk5bL
         5WOQ==
X-Gm-Message-State: ACgBeo0w6WdRTohD3aV347atC5WP+yr2mLLPFtKg7IGfI/v9RhFYnIRP
        krZ2cdnV9tJObYmPM2lOmGgOylmkJ29GZt0uVe04mA==
X-Google-Smtp-Source: AA6agR7AJf9AOAAtuDFL/SEeBpsglgsS3c78XCsHe+mZR6Ycv5JsqxwDnoulWonFip+nUJqMiv9nqp+8v3nbJaDxNwE=
X-Received: by 2002:a37:e118:0:b0:6ba:e5ce:123b with SMTP id
 c24-20020a37e118000000b006bae5ce123bmr9555944qkm.221.1661803727353; Mon, 29
 Aug 2022 13:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220826230639.1249436-1-yosryahmed@google.com>
In-Reply-To: <20220826230639.1249436-1-yosryahmed@google.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 29 Aug 2022 13:08:36 -0700
Message-ID: <CA+khW7iN6hyyBBR+4ey+9pNmEyKPZS82-C9kZ2NRXKMEOXHrng@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: simplify cgroup_hierarchical_stats selftest
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 4:06 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> The cgroup_hierarchical_stats selftest is complicated. It has to be,
> because it tests an entire workflow of recording, aggregating, and
> dumping cgroup stats. However, some of the complexity is unnecessary.
> The test now enables the memory controller in a cgroup hierarchy, invokes
> reclaim, measure reclaim time, THEN uses that reclaim time to test the
> stats collection and aggregation. We don't need to use such a
> complicated stat, as the context in which the stat is collected is
> orthogonal.
>
> Simplify the test by using a simple stat instead of reclaim time, the
> total number of times a process has ever entered a cgroup. This makes
> the test simpler and removes the dependency on the memory controller and
> the memory reclaim interface.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---

Yosry, please tag the patch with the repo it should be applied on:
bpf-next or bpf.

>
> When the test failed on Alexei's setup because the memory controller was
> not enabled I realized this is an unnecessary dependency for the test,
> which inspired this patch :) I am not sure if this prompt a Fixes tag as
> the test wasn't broken.
>
> ---
>  .../prog_tests/cgroup_hierarchical_stats.c    | 157 ++++++---------
>  .../bpf/progs/cgroup_hierarchical_stats.c     | 181 ++++++------------
>  2 files changed, 118 insertions(+), 220 deletions(-)
>
[...]
> diff --git a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> index 8ab4253a1592..c74362854948 100644
> --- a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> +++ b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Functions to manage eBPF programs attached to cgroup subsystems
> - *

Please also add comments here explaining what the programs in this file do.

>   * Copyright 2022 Google LLC.
>   */
[...]
>
> -SEC("tp_btf/mm_vmscan_memcg_reclaim_begin")
> -int BPF_PROG(vmscan_start, int order, gfp_t gfp_flags)
> +SEC("fentry/cgroup_attach_task")

Can we select an attachpoint that is more stable? It seems
'cgroup_attach_task' is an internal helper function in cgroup, and its
signature can change. I'd prefer using those commonly used tracepoints
and EXPORT'ed functions. IMHO their interfaces are more stable.

> +int BPF_PROG(counter, struct cgroup *dst_cgrp, struct task_struct *leader,
> +            bool threadgroup)
>  {
> -       struct task_struct *task = bpf_get_current_task_btf();
> -       __u64 *start_time_ptr;
> -
> -       start_time_ptr = bpf_task_storage_get(&vmscan_start_time, task, 0,
> -                                             BPF_LOCAL_STORAGE_GET_F_CREATE);
> -       if (start_time_ptr)
> -               *start_time_ptr = bpf_ktime_get_ns();
> -       return 0;
> -}
[...]
>  }
> --
> 2.37.2.672.g94769d06f0-goog
>
