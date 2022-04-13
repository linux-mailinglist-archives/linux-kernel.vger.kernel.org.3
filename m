Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F764FFFFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbiDMUbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbiDMUa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:30:57 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1095C83B0B;
        Wed, 13 Apr 2022 13:28:34 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id o2so5539167lfu.13;
        Wed, 13 Apr 2022 13:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CujCbp/sw+khaMiFxer85R28JC7xz+rn3pwqBuSA5a8=;
        b=wVcKQz7+i2gNvbzEiVQkU2NOM4klnbSiX/bfk5JhEKW3CCdAjlbMyjjMP+iqL5JcsV
         YRx/BNBxpMmvxgUR9CMfeeWnKk65RQyv/lt7nLolMeLNt4u0DU2Jhsfb3TIhs2j/wUZS
         VY1L6ToAHG7szUuMereHc1ReEUiosX+UlermqwsGC6QTtcdiPlYuAip11Y94PNeDNyQ0
         EbLrdy/MekVoxTUIIdR2K6gRpv3ZlNaK8sUQoIys9a21x4+7Y/5sgTsf3pzYsu8ysIdr
         Bgur+Jh9KetwPJTTVocX9zcqgX+5OKy0VYzezyjjWMTDN3/Gon06f5+Ccn0HQ6pvutLl
         CLww==
X-Gm-Message-State: AOAM532ezeD7xv8vENRk3k0AFPaa6wR+ZNk7VWCGg8lJrlnVcwUw9uoU
        EnMR+Hq9bZF+/VsuH7Bbe1LDpPXDsKwyb2BMBkQ=
X-Google-Smtp-Source: ABdhPJyluSBAO6ZKxyhld5cSe7DUtYi1Hm4e/CMZd5/P8jWPcPR/Cuaw+fCb884KrHifRVnNq0S/qBHAxM+PV/u7Eh8=
X-Received: by 2002:a05:6512:3404:b0:44a:310f:72f7 with SMTP id
 i4-20020a056512340400b0044a310f72f7mr31031455lfr.47.1649881712413; Wed, 13
 Apr 2022 13:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220412154817.2728324-1-irogers@google.com> <YlX5U+Qelf/rBdau@google.com>
 <CAP-5=fUDQGtNn39xDSxagwVzN95dohNrfiU_a3pU8zkiv2-6tw@mail.gmail.com>
In-Reply-To: <CAP-5=fUDQGtNn39xDSxagwVzN95dohNrfiU_a3pU8zkiv2-6tw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 13 Apr 2022 13:28:21 -0700
Message-ID: <CAM9d7chuo033D8016uFq_idYjDusTKtndxV1VyZ-nCrdy0qU_A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Tidy up symbol end fixup
To:     Ian Rogers <irogers@google.com>
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
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
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

On Tue, Apr 12, 2022 at 4:48 PM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Apr 12, 2022 at 3:12 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Tue, Apr 12, 2022 at 08:48:13AM -0700, Ian Rogers wrote:
> > > Fixing up more symbol ends as introduced in:
> > > https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/
> > > caused perf annotate to run into memory limits - every symbol holds
> > > all the disassembled code in the annotation, and so making symbols
> > > ends further away dramatically increased memory usage (40MB to
> > >  >1GB). Modify the symbol end logic so that special kernel cases aren't
> > > applied in the common case.
> > >
> > > v2. Drops a merged patch. Fixes a build issue with libbfd enabled.
> >
> > How about just like this?  We can get rid of arch functions as they
> > mostly do the same thing (kernel vs module boundary check).
> >
> > Not tested. ;-)
> >
> > Thanks,
> > Namhyung
> >
> > --------------8<-------------
> >
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index dea0fc495185..df41d7266d91 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -35,6 +35,7 @@
> >  #include "path.h"
> >  #include <linux/ctype.h>
> >  #include <linux/zalloc.h>
> > +#include <internal/lib.h>  // page_size
> >
> >  #include <elf.h>
> >  #include <limits.h>
> > @@ -231,8 +226,16 @@ void symbols__fixup_end(struct rb_root_cached *symbols)
> >                 prev = curr;
> >                 curr = rb_entry(nd, struct symbol, rb_node);
> >
> > -               if (prev->end == prev->start || prev->end != curr->start)
> > -                       arch__symbols__fixup_end(prev, curr);
> > +               if (prev->end == prev->start) {
> > +                       /* Last kernel symbol mapped to end of page */
>
> I like the simpler logic but don't like applying this in symbol-elf
> given the comment says it is kernel specific - so we could keep the
> is_kernel change.

I'm fine with the change. :)

>
> > +                       if (!strchr(prev->name, '[') != !strchr(curr->name, '['))
>
> I find this condition not to be intention revealing. On ARM there is
> also an || for the condition reversed. When this is in an is_kernel
> block then I think it is clear this is kernel hack, so I think it is
> good to comment on what the condition is for.

Yeah, usually modules are loaded after the kernel image but
it seems ARM could load them before the kernel.
So I made the change not to call strchr() again.

But we might need to consider the special "[__builtin_kprobes]"
symbols.

>
> > +                               prev->end = roundup(prev->end + 1, page_size);
>
> Currently the roundup varies per architecture, but it is not clear to
> me that it matters.

Yeah, it would be the same as the logic for the last entry to be
more conservative.

>
> > +                       else
>
> I think we should comment here that we're extending zero sized symbols
> to the start of the next symbol.

Sounds good.

Thanks,
Namhyung


>
> > +                               prev->end = curr->start;
> > +
> > +                       pr_debug4("%s sym:%s end:%#" PRIx64 "\n",
> > +                                 __func__, prev->name, prev->end);
> > +               }
>
> Thanks,
> Ian
>
> >         }
> >
> >         /* Last entry */
