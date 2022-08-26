Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A473E5A2C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344684AbiHZQUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344654AbiHZQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:20:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF92DB7CF
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:20:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bs25so2391732wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zzUl8oGEgJMTlOJPy7VJibE5hKJrOS3klLzu+K6mIGI=;
        b=AUXpZ8o3OzsJFe3HFNnQVRYKL+5Z2LIyptjGTfOIPlrPcqx0kUV9ZrF3HDoPmmvjRK
         U4hDGe4LP/tZwofzgFGa3f8D6BE2Nogk8L1rW1OqW3SQQV3K71U2YlnZbOUG1Ji99JKN
         5sZQogZHUiUhbbWAoBQee4Az/ov84ugpEq52Sy2SfEp2b1Mq3J/humyf7lO4IOQtSkhT
         BKRAfYtaW48wuzb8YgNJoL21kqihA+w4YdhQvWVjQ3NWvUVmHSf5zymQhVFz5wvHZnuG
         4qeleKj2qJMIW+W88sGPnSbnkeRtdA98Q0Ne2J8ho3EEHhYe6Bxi5O3Rg4cFPv7HNt6g
         2Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zzUl8oGEgJMTlOJPy7VJibE5hKJrOS3klLzu+K6mIGI=;
        b=C534H3ynrNem86Jm/VoN1XuqJys9+6/b09CZ5DMSxVRqTjK/InmrtwWyqOeZMSunho
         DgJNfiftkoGzgManrRBNpehPwYTcyeX20owc2GWlzB4ZlQAqWRMEyoVacj9ignDEt8Wr
         ZZmj7D6mf2fc8Rft+mNIiFPPW98T0oPiHCm8yzqBmckNi7eXuKl5tcnOKqZJcdcqu356
         fsHjFZpiamZD4aXWY1xTVf9f2io3BI6RY1kcEphCLHubtQ245CdQLQI7oFi3LU2YAynN
         tVBCL53Pi/u7a0lb9u+gl04A0tZkqpJXiaT+S2bS/vbdPYjSzeFmkYOL/fjCD/WpO8vA
         ZiSw==
X-Gm-Message-State: ACgBeo0rY2i40kHiHKFKvV/jDaid1N203SdpGhcpuWFdQ6WGQLn5lyKU
        Wdg1Z84tjH6HaKwk1ijBfUdFAyEGkpL4KNWXyiYHWQ==
X-Google-Smtp-Source: AA6agR4OxdnySTgDZkCtUgd+3IgyOo9ffBzPm5djKnBcX8tHzsP4orSo0vbogLgM8gN8HZo17s2VIyi8qY6Xiyfc7Aw=
X-Received: by 2002:a05:6000:1008:b0:225:58e0:223f with SMTP id
 a8-20020a056000100800b0022558e0223fmr226802wrx.375.1661530832589; Fri, 26 Aug
 2022 09:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com> <20220614143353.1559597-5-irogers@google.com>
 <YwjDLl8QXQzaCYaS@tuxmaker.boeblingen.de.ibm.com>
In-Reply-To: <YwjDLl8QXQzaCYaS@tuxmaker.boeblingen.de.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Aug 2022 09:20:20 -0700
Message-ID: <CAP-5=fWTP+_6oLhTYowvpvGrn05784rHkzJgBZcoqZobE1M_Tg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] perf cpumap: Fix alignment for masks in event encoding
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
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

On Fri, Aug 26, 2022 at 5:57 AM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> On Tue, Jun 14, 2022 at 07:33:51AM -0700, Ian Rogers wrote:
>
> Hi Ian,
>
> Although it is committed, still have a question.
>
> > index e7758707cadd..d2d32589758a 100644
> > --- a/tools/lib/perf/include/perf/event.h
> > +++ b/tools/lib/perf/include/perf/event.h
> > @@ -6,6 +6,7 @@
> >  #include <linux/types.h>
> >  #include <linux/limits.h>
> >  #include <linux/bpf.h>
> > +#include <linux/compiler.h>
>
> Is it correct approach to include it into user-exposed headers?
> AFAICT headers_install.sh strips #include <linux/compiler.h> and
> compiler*.h itself do not get installed with make headers_install.
>
> [...]
>
> > +struct __packed perf_record_cpu_map_data {
>
> And it is only needed to pull __packed macro, right?
>
> Thanks!

Hi Alexander,

I can see your point about compiler.h, it is true that it is just
being used for the __packed definition. Why don't you write your
proposed change as a patch and send it to LKML? libperf is more of an
experimental library than a stable API. We don't currently have any
build tests for things outside of the kernel tree.

Thanks,
Ian
