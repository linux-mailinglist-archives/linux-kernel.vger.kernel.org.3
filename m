Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA53536D58
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 16:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbiE1Ou5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 10:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiE1Ouy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 10:50:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62BB264C
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 07:50:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso4183038wmp.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 07:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87UMH55qhP/F7dWZ9iWyn0juZKRL0czGeuBEHHkp02w=;
        b=M9m1lPTfTKvLG11Iinnl/uRVdXiNC3C5HJ0y5+ViXA8hxKj1xwRcTeA9olVCFnJV4G
         gDXPkWbrL9UWtaWw+Lks/+5xWKY+ZCwtL75nZ92Yz9Ufodq62YAr+BvMHP2CAUGPkH3d
         qxGfTVdggo3HUHLhkdAhz9IeFn/ZKO+I3ANHGE0g/mCvRX7fhccPDWuvPjmE/u9whzoo
         829N4hm41WQ6OsBaFPAGinqkCCh52VpiJkFq+poS3P/8NRcIHDnti1c7HQFThlcxn3/5
         uwn5obDh2cpu7xj0Ef4I53Dc8/QHVOsNTOjmUUrim14VQLjkqgFbfk5Qn2AEYpRJSqBP
         8/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87UMH55qhP/F7dWZ9iWyn0juZKRL0czGeuBEHHkp02w=;
        b=w7zY/LQKJNAnawTf75PciogoV/UrvBSGGImGrnkqhSIUHbVWYfs5ltcr1HK8LdMiq/
         xFxDa22OYqZWzaAjxT6SbhavZlnG03/0lA53FtyUmqEjOpL7sfFr66JT3tcSIP+Zk9bq
         NzkfrmNh+lOT44sU1BmHj4JzNBDXmk7xf7zjI5HUagsvW6+nEZRkBFoZzwE1/dS3VUaq
         mV5t0Tn8A1jx9uyPZvrTHcbRN9IjMMFkVCnazLwZqxodePZMIPEIDEgh0lvgu7FXFsgR
         85W1GQGKdY8nGRGUsT6kDLlOX5UgWM3xQ4pljs90g9dvahw82KhZjdYM6Z7rf4dKIYBR
         3EUg==
X-Gm-Message-State: AOAM530utIsIhv68La4gAEfMz5j/ig8ng7A/JFAVkkvnws9WG5qqD+ew
        ayDpSusCabTalGvRJ4wySHpTenAvvDhMlSyCFXa4Pg==
X-Google-Smtp-Source: ABdhPJzSEwzqsO95j0XjL3L/Xm8X5uH89ZDVdeqFw90w0VN31mx0ycB4ilkIPcwx0g5cwuWKPFT5dWuqIfdMbKeh2Vw=
X-Received: by 2002:a05:600c:19cb:b0:397:51db:446f with SMTP id
 u11-20020a05600c19cb00b0039751db446fmr11533653wmq.182.1653749452050; Sat, 28
 May 2022 07:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220527040407.4193232-1-irogers@google.com> <YpCeo6APNtXvrTPJ@hirez.programming.kicks-ass.net>
 <76dce5d3-6c69-e403-c4d9-f882967a4467@linux.intel.com> <YpIrVSGH314djkh9@worktop.programming.kicks-ass.net>
In-Reply-To: <YpIrVSGH314djkh9@worktop.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 28 May 2022 07:50:40 -0700
Message-ID: <CAP-5=fWwG+Gt+E7M8EYuDhgrvfUQLbP7ODn18r_axshqKxwuYA@mail.gmail.com>
Subject: Re: [PATCH v2] perf metrics: Add literal for system TSC frequency
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
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

On Sat, May 28, 2022 at 7:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, May 27, 2022 at 07:54:19AM -0700, Andi Kleen wrote:
>
> > > This all seems bonghits inspired... and perf actually does expose the
> > > tsc frequency. What do you think is in perf_event_mmap_page::time_* ?
> >
> >
> > That's not really available to perf stat, which is the primary metrics user.
>
> Why not? You can mmap any perf-fd (even software events) and these
> fields should be filled out.
>
> It should work on any x86 CPU that has a TSC. The only caveat is that
> the kernel must not have marked the TSC unstable.
>
> It could even work for virt -- all you need is for virt to use
> native_sched_clock() instead of the paravirt nonsense.

It will at least fail if inherit is enabled, no?

Thanks,
Ian
