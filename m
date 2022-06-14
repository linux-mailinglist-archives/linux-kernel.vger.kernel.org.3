Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E73954B833
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbiFNR7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343828AbiFNR7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:59:22 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D437428E3A;
        Tue, 14 Jun 2022 10:59:21 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id bf7so11332177oib.11;
        Tue, 14 Jun 2022 10:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hu4Kf3msvJUEvc3qCtVSjs2pcHPwEIRm3avc6l6WqOE=;
        b=5Hwq/OozOGZMxp4LfVzIJIXFGR28A9Xap3yXcY/81VZSXhw4OyPgfRLdvOrqEhq2P6
         1zOr+dl2eDOnyiLSUIxlb5Bef6HzYaJ8W1oOoFokZXU7k0TpyzqwVqvXbRquJjqHa2sV
         CQJDWej+lS+xQ7J4M9uEmEkZbRnFnrQGCfx8uTVdAPhBqLkM88ewlQUwWW+U6ti36HNc
         kGiZU6R6iQav7WKylawSdAxAxnS/WQuHS2FP6bNaRIBH5BclyTU/zbN8OkIxL27B2Ue+
         eO7lj/xozUb0YK6kNmmiDCKICYa93cnIRZllIZIE981TpO2tn6YMAEJ29MRUYYut1vaz
         uAug==
X-Gm-Message-State: AJIora9IGgQPXOy2VE1VF0J9daK8QZJv+4629Q3kLDN8ihieOzgU+ojQ
        mFsTGbGYHUjVV+3NfAJWJfSLisBGdz84y+h3VAmUysd/Ess=
X-Google-Smtp-Source: AGRyM1vnf9JCyhp4j7xystbfLm40BTPb6XNVL3PEVL1/oV221CVtZOwZLRvpzwhck3w46F6CSKGZks29Ulm706P38qM=
X-Received: by 2002:a05:6808:1385:b0:32f:729e:4869 with SMTP id
 c5-20020a056808138500b0032f729e4869mr116832oiw.5.1655229561140; Tue, 14 Jun
 2022 10:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220610025449.2089232-1-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220610025449.2089232-1-zhengjun.xing@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 14 Jun 2022 10:59:10 -0700
Message-ID: <CAM9d7cjSynKt+CfoPqHQHNJt=to3LmdQqh_x6rKJSUcx6qFbsA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add perf stat default events for hybrid machines
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, alexander.shishkin@intel.com,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
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

Hello,

On Thu, Jun 9, 2022 at 7:55 PM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> The patch series is to clean up the existing perf stat default and support
> the perf metrics Topdown for the p-core PMU in the perf stat default. The
> first 4 patches are the clean-up patch and fixing the "--detailed" issue.
> The last patch adds support for the perf metrics Topdown, the perf metrics
> Topdown support for e-core PMU will be implemented later separately.
>
> Kan Liang (4):
>   perf stat: Revert "perf stat: Add default hybrid events"
>   perf evsel: Add arch_evsel__hw_name()
>   perf evlist: Always use arch_evlist__add_default_attrs()
>   perf x86 evlist: Add default hybrid events for perf stat
>
> Zhengjun Xing (1):
>   perf stat: Add topdown metrics in the default perf stat on the hybrid
>     machine

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  tools/perf/arch/x86/util/evlist.c  | 64 +++++++++++++++++++++++++-----
>  tools/perf/arch/x86/util/evsel.c   | 20 ++++++++++
>  tools/perf/arch/x86/util/topdown.c | 51 ++++++++++++++++++++++++
>  tools/perf/arch/x86/util/topdown.h |  1 +
>  tools/perf/builtin-stat.c          | 50 ++++-------------------
>  tools/perf/util/evlist.c           | 11 +++--
>  tools/perf/util/evlist.h           |  9 ++++-
>  tools/perf/util/evsel.c            |  7 +++-
>  tools/perf/util/evsel.h            |  1 +
>  tools/perf/util/stat-display.c     |  2 +-
>  tools/perf/util/topdown.c          |  7 ++++
>  tools/perf/util/topdown.h          |  3 +-
>  12 files changed, 166 insertions(+), 60 deletions(-)
>
> --
> 2.25.1
>
