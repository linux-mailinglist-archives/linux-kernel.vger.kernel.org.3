Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B18A48AF8D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241949AbiAKO3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241936AbiAKO3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:29:18 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128F9C061757
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 06:29:18 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d19so2796696wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 06:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cVpO0twPTQYfaXvPrtKidZn97kp3fh1pXoSqkP4do5M=;
        b=A6pNOFu2UXG3kppLMdQlce00YTOBthcO5R3s/QHOsLu7xl2a2dNlSJuXTDWN+IKkvN
         hed+rczKtREGBW+Dz/wzknJMwLjN7tKA838lwxJo7RZL/BNu6Z2ZLR8ChGYeHRXiGVDw
         qtBeQGcAZwl0avn8kaSY1eEv9Px7e5frQLxQZJAyKgaAu7TaHjAXk4ue5JDGEj3ZK9j3
         t3RXi9LXY62E3KY6KyKKEvnt8Zh+Th+E25tZndDWNoUe/wAulsKxqvsNBtsyRt2crOAZ
         tw57338YczPFLw0iR4iyAi5YO0Tm1oiK0Y25W63xyPhXWFH7SKdPPYNFeUlAqx9BmNmO
         WGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cVpO0twPTQYfaXvPrtKidZn97kp3fh1pXoSqkP4do5M=;
        b=LXUD0mS7lW6Xipo5/gxI+W1ijmLwiX/4u0g47PrL75opICMozG7eLWbsrOgJIKpk0x
         x92I/2DSAFUOtAh6ZBiYOwoMyK6VtJCv5+LIGZXCB3xx6GFKSDxuGlJLpWLRrPMlXYiS
         eoH5WVsyNa4gczUSKiKRZkoh62rabAu48e9YxTeabx2WcRNKonHB3B5rKxT24Cesxqg+
         enXbIuhZFDKMWqhMG7o+TFpzjzXx2irQfpclTAptYBAu9U5wVgnIjOp+rPDFsbFrJ3S3
         CxK4aXVoPKX2Q4AcB6GSz8g8k6++NqH26VviVCsdyH5AuiZEH4G20m4BPYXG/A/8WAno
         uEtg==
X-Gm-Message-State: AOAM530DJf57BQmcHeJlEB5BylAcqnq4WP7cgeT1dQSBk9jIsutPd5ZZ
        HG0bvFOSxJDSpwDqPSOLcv1bmg==
X-Google-Smtp-Source: ABdhPJz569ql8rw4+Bp8dedwXG13FhgJT9VU8wnYfLgstT9Lg7arvKTCBiy0HFx1TJAMO4b9AOzrvA==
X-Received: by 2002:a05:6000:1687:: with SMTP id y7mr4090466wrd.234.1641911356619;
        Tue, 11 Jan 2022 06:29:16 -0800 (PST)
Received: from smtpclient.apple (global-5-142.nat-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id bg19sm2204544wmb.47.2022.01.11.06.29.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jan 2022 06:29:16 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [RFC PATCH 0/1] perf tools: Add 'm' event modifier for counting
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20220111142054.18733-1-nikita.shubin@maquefel.me>
Date:   Tue, 11 Jan 2022 14:29:15 +0000
Cc:     Atish Patra <atishp@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux <linux@yadro.com>, Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Song Liu <song@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <B6E7919C-9414-4CC1-BB86-7D358085CECD@jrtc27.com>
References: <20220111142054.18733-1-nikita.shubin@maquefel.me>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jan 2022, at 14:20, Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> 
> From: Nikita Shubin <n.shubin@yadro.com>
> 
> This patch is a proposal to add Machine Mode modifier that is currently 
> available only for RISC-V for perf tool.
> 
> We don't currently have a level that is lower than kernel, so i don't 
> see we can reuse something existing for this purpose.
> 
> The exclude_machine bit seems harmless to as no one will proccess it apart 
> of riscv.

Armv8 has equivalent bits in PMEVTYPER<n>_EL0 and PMCCFILTR_EL0 for
EL-based filtering, which includes filtering EL3.

Jess

> Patch depends on Atish Patra PMU series:
> https://lwn.net/Articles/879905/
> + some modifications to pass execlude event to SBI PMU extension
> 
> Tested with qemu.
> 
> Nikita Shubin (1):
>  perf tools: Add 'm' event modifier for counting machine
> 
> include/uapi/linux/perf_event.h        |  3 ++-
> tools/include/uapi/linux/perf_event.h  |  3 ++-
> tools/perf/Documentation/perf-list.txt |  1 +
> tools/perf/tests/parse-events.c        | 18 ++++++++++++++++++
> tools/perf/util/evsel.c                |  4 +++-
> tools/perf/util/parse-events.c         | 18 +++++++++++++-----
> tools/perf/util/parse-events.l         |  2 +-
> 7 files changed, 40 insertions(+), 9 deletions(-)
> 
> -- 
> 2.31.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

