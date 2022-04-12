Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E24F4FEBA6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiDLXvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiDLXvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:51:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7011FB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:48:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t1so291189wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lkI41JF3glGgO0AK4EpfNmpVmEtcA068KzSynd/K3x4=;
        b=oYAIU3qZkT4Pqst1lJguZvTH6N4db91UNv7MKU3GzUFF64j1mV7XJt1y205deV2B30
         I2Fw4+Nt5awZRI3KM1HxBEH2bzsn0ZEGupKWZ88CYy7Ke2/LqzvQFna0YrHaH9EMCEat
         zRRlPrwoOJ7iOJvJfjgGG2tJYsBWlRNxlfux/fzEkelP+xLlQm3tZDV/QMQZ7/+VuTSb
         PrafhvVzIHVxRSo0thUbZSxYrgNocxjo2ddpgiNZE5LCCGhesdQvj8MDKWkm0Ggqn/P9
         3/hHke6hq+wvGuODOvToHjSbtlCEvGY5OCneLT2m3CconB9zolhd65BPJp56WjAFOD4h
         Ympw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lkI41JF3glGgO0AK4EpfNmpVmEtcA068KzSynd/K3x4=;
        b=QYQvn2IgNZFjdQ1X44wdLZDynAadeOJxtFzNjWsisZfIdban47Vu+pBnUlIc+axiRN
         CiEU/FlEfLkQmvYCw059ozaUokA6gTI4C/+cD6qIiH1L0gDrEoYzdS+JxZXp8bw5Ztp0
         9pYufQSI+10PmS6lES2nflYyFk09iEqaw3J+WTxWG0cYFMbGqzAs2WCxxSFnLCI1YLXw
         dPTWOWDDSQfaOTbJrxSX/HMykNcQ3ru7SXhsft7L/jTVMGnCJ5txQF8iqNxKrPTUNiTg
         Btd9CiuKAnnNmw4UudXDSIDfLWVgReDthGppDA9RzQ2wHwd1z24dlzUNJplfdIWaqyvZ
         zkLw==
X-Gm-Message-State: AOAM531aIpwzYZthOtegGRhFh4Vgtlo/HMGVBwlS/uILgtbE1JTwqyS1
        tLyigLaXuBSilOF1I4lF5wZ4uc79XIdi2kMuEZCgeg==
X-Google-Smtp-Source: ABdhPJzQEF6ln2cBWbRlqVbdVROYbIRp/hFzVIu8iG19W/gHz9aR6E8sJurCEHQLQxIb1Fye1sh4H66XW89c4fQUbuI=
X-Received: by 2002:a5d:6241:0:b0:207:ac0e:3549 with SMTP id
 m1-20020a5d6241000000b00207ac0e3549mr6211995wrv.343.1649807322726; Tue, 12
 Apr 2022 16:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220412154817.2728324-1-irogers@google.com> <YlX5U+Qelf/rBdau@google.com>
In-Reply-To: <YlX5U+Qelf/rBdau@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 Apr 2022 16:48:28 -0700
Message-ID: <CAP-5=fUDQGtNn39xDSxagwVzN95dohNrfiU_a3pU8zkiv2-6tw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Tidy up symbol end fixup
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        James Clark <james.clark@arm.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        German Gomez <german.gomez@arm.com>,
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Tue, Apr 12, 2022 at 3:12 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Tue, Apr 12, 2022 at 08:48:13AM -0700, Ian Rogers wrote:
> > Fixing up more symbol ends as introduced in:
> > https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/
> > caused perf annotate to run into memory limits - every symbol holds
> > all the disassembled code in the annotation, and so making symbols
> > ends further away dramatically increased memory usage (40MB to
> >  >1GB). Modify the symbol end logic so that special kernel cases aren't
> > applied in the common case.
> >
> > v2. Drops a merged patch. Fixes a build issue with libbfd enabled.
>
> How about just like this?  We can get rid of arch functions as they
> mostly do the same thing (kernel vs module boundary check).
>
> Not tested. ;-)
>
> Thanks,
> Namhyung
>
> --------------8<-------------
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index dea0fc495185..df41d7266d91 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -35,6 +35,7 @@
>  #include "path.h"
>  #include <linux/ctype.h>
>  #include <linux/zalloc.h>
> +#include <internal/lib.h>  // page_size
>
>  #include <elf.h>
>  #include <limits.h>
> @@ -231,8 +226,16 @@ void symbols__fixup_end(struct rb_root_cached *symbols)
>                 prev = curr;
>                 curr = rb_entry(nd, struct symbol, rb_node);
>
> -               if (prev->end == prev->start || prev->end != curr->start)
> -                       arch__symbols__fixup_end(prev, curr);
> +               if (prev->end == prev->start) {
> +                       /* Last kernel symbol mapped to end of page */

I like the simpler logic but don't like applying this in symbol-elf
given the comment says it is kernel specific - so we could keep the
is_kernel change.

> +                       if (!strchr(prev->name, '[') != !strchr(curr->name, '['))

I find this condition not to be intention revealing. On ARM there is
also an || for the condition reversed. When this is in an is_kernel
block then I think it is clear this is kernel hack, so I think it is
good to comment on what the condition is for.

> +                               prev->end = roundup(prev->end + 1, page_size);

Currently the roundup varies per architecture, but it is not clear to
me that it matters.

> +                       else

I think we should comment here that we're extending zero sized symbols
to the start of the next symbol.

> +                               prev->end = curr->start;
> +
> +                       pr_debug4("%s sym:%s end:%#" PRIx64 "\n",
> +                                 __func__, prev->name, prev->end);
> +               }

Thanks,
Ian

>         }
>
>         /* Last entry */
