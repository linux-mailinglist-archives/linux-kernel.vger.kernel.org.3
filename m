Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A5A4FE5B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354619AbiDLQX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244084AbiDLQXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:23:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEA95D1AB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:21:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e8so12071833wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IaklH84rCrU4lpiXP8yvmTmjobzVXsRZJg68fB8ePQQ=;
        b=i3Q1ntS34MHnFnrjwc0Pbeet7hWR1qSDsWaKlXU5MtWO9FTbHXUXWY84f0wOAKyn/a
         qElYCluYnJQttU4yE1fwZ8ELRgwX8oH/ee23KVlJ0QRQFz1LjbvmUTd2YWD2ppbJLn9R
         7ftv3OxWcznJyZGMv5eJ7KLHnvK166uBHoiodxemrDgxQbzCXLEtpvXvZWqKaEFz4Eyp
         KxJLn5TTsK84FNSYFp1k7Ze/BhvPKVgicjKa5c8N18uqyoiUT0APkzgrEmOdQWk3DvPp
         eN6xdNexFUiMIrrw0vKuQ/4n7Dva1rZITGZA+ECi7joUeqyCahCx1w88UZxx4p4FIlfA
         uKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IaklH84rCrU4lpiXP8yvmTmjobzVXsRZJg68fB8ePQQ=;
        b=f/q4BRWhIxxs7lvu6BT+wQaGaXRT5oJQqmWAKLl6HC6xqYwAjOWLh82Odff7FqfE5v
         8kNUq3lHmwIj/OY2bRyQx3Cjik/vtx6hjZlorP8JzbqD2YEsochKqgdvHQIQmNnvkQFP
         nEjbWEuOepgRDJ/AwoT9ZZMgInJKDa50W9YJ89W6Ww6HpYk/4keSA5aTcPJ/NL6eqFvE
         6IRPv4ryGJgXHFOAH/3TutqT1yQZJw8nTgBSeZ8Z7HV3xaHgW+66TyHxc7s+Rp82jUv9
         42YdtBKtahLDX4CUeCVG+OgZGiQ8F5peq0caNzSnP2whC2YQFepd9J4C5NTgWOaDNjiN
         kQ7A==
X-Gm-Message-State: AOAM531KUxJVuf5BzRpsei/KHRveaLJJWpo+f5amhvLLvLTiC/DEklS9
        cgAMC98bBr///gUcTkLtlOjXUPSs6xe7mKj5wVGmvQ==
X-Google-Smtp-Source: ABdhPJw3cfndLH3ZUhpSzzjuo9DBHjuzswehgTFoF0He2DYxPgFCa/mATA8WHqbj7bEk2KuOvbIrutr8YUle9ZXKziw=
X-Received: by 2002:adf:8123:0:b0:206:1759:f164 with SMTP id
 32-20020adf8123000000b002061759f164mr30353021wrm.654.1649780463588; Tue, 12
 Apr 2022 09:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220412154817.2728324-1-irogers@google.com>
In-Reply-To: <20220412154817.2728324-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 Apr 2022 09:20:51 -0700
Message-ID: <CAP-5=fX8YatuJZG6dYftwWy0NnkRyJWqtyw7D0WAU9xDjh+b0Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Tidy up symbol end fixup
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Li Huafei <lihuafei1@huawei.com>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        William Cohen <wcohen@redhat.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Denis Nikitin <denik@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
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

On Tue, Apr 12, 2022 at 8:48 AM Ian Rogers <irogers@google.com> wrote:
>
> Fixing up more symbol ends as introduced in:
> https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/
> caused perf annotate to run into memory limits - every symbol holds
> all the disassembled code in the annotation, and so making symbols
> ends further away dramatically increased memory usage (40MB to
>  >1GB). Modify the symbol end logic so that special kernel cases aren't
> applied in the common case.
>
> v2. Drops a merged patch. Fixes a build issue with libbfd enabled.
>
> Ian Rogers (4):
>   perf symbols: Always do architecture specific fixups
>   perf symbols: Add is_kernel argument to fixup end
>   perf symbol: By default only fix zero length symbols
>   perf symbols: More specific architecture end fixing
>
>  tools/perf/arch/arm64/util/machine.c   | 14 +++++++++-----
>  tools/perf/arch/powerpc/util/machine.c | 10 +++++++---
>  tools/perf/arch/s390/util/machine.c    | 12 ++++++++----
>  tools/perf/util/symbol-elf.c           |  2 +-
>  tools/perf/util/symbol.c               | 16 +++++++++-------
>  tools/perf/util/symbol.h               |  4 ++--
>  6 files changed, 36 insertions(+), 22 deletions(-)

Missed the:

Signed-off-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> --
> 2.35.1.1178.g4f1659d476-goog
>
