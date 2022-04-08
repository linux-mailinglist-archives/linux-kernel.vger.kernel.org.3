Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690144FA049
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 01:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240065AbiDHXyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 19:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiDHXyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 19:54:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0533C1B29E7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 16:52:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c7so15123741wrd.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 16:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Z5lmTeyx84Yo2aB1/h1dMObiSZnUIdjrOa7dhn9z+0=;
        b=bWrf8tXOOR8KJK7v9SrFzKCWzYyURowo3Mex/cgaWSy0JHDrBN5HbmpK0nYBuvar+5
         hQbnXjbZsp7mu6M40ZDEUBVg+r0T1Muvri627DKFFIgkezlfeTJQSFF2kmDHiIP6xOxY
         u6+ylUb+xzzk1Bm8UKJppu+9esqExyHMHhtxm389OAPwJ3q7fBzdS6qgiIRCClFTpixB
         KupVRwkNVe5fcJDFhyxzRO0m/00vtg4zSw241C14U2jbyrzsCesen08pgQQjo2mIaoCV
         jVQXPJhmzNIq/6XPeBz0GNrNQmnv834mZI9BFdU85VA6JI2Km9PSLYbsq3lZSfReDUvf
         HISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Z5lmTeyx84Yo2aB1/h1dMObiSZnUIdjrOa7dhn9z+0=;
        b=w6H8mQDWcT7SyQTjSFXTyDOC/BMhbCEV/gt0yxWi7hzZ1RkI2SAviUlhJPw3ZaUzvN
         xM5l0W935Hs4k9IugwuydTn5dJEMoXPpjpM2KDxuA8ic6yEjJDOvv+mA456IwKsZrpy5
         RgpKcRui/5pWDXWW/yrpUi7iW0dFXODpqF6lYOGErq4ttmwl7691SU79eGg8S38BjxYv
         vvEU/p08IOGu4KBqH0onk3CUS43eo6IAJryH02XJETw/YOZfHN9Ajt0wH1jgh6p4GqNG
         xey0i4Wet+XkWnNr+cIs0bK/sfr36TmrY6afaO6L0cdzzbNjBH9CRd1RBgerW27ewPVT
         jy4g==
X-Gm-Message-State: AOAM533DeE0JxnVF5wXEOLN77DOTk5upXzrdHMKXoE9p06IEmbVgFROS
        X9QyJRT7jjUZaZz6xjxxUBnIv4BYwL0ZnfIAtEvQvg==
X-Google-Smtp-Source: ABdhPJwhpFPHZ6T5uG1eJYKJykakLx69sYt54ZUlpc0GREa0vdDTuFMxX6xYub8+/m83iXAOcL9lfessfIuumOJOb78=
X-Received: by 2002:adf:f6c4:0:b0:206:1581:dabc with SMTP id
 y4-20020adff6c4000000b002061581dabcmr16707057wrp.375.1649461933269; Fri, 08
 Apr 2022 16:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220407230503.1265036-1-irogers@google.com> <CAM9d7cjM5jpPfdWUvoezYYJoz_Sh1rHpGHVGAvxOqxzb=AKBVQ@mail.gmail.com>
In-Reply-To: <CAM9d7cjM5jpPfdWUvoezYYJoz_Sh1rHpGHVGAvxOqxzb=AKBVQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 8 Apr 2022 16:52:00 -0700
Message-ID: <CAP-5=fULT859R4-x4RRsvKEUSrGYySVVSxtWSWYUoKC0M0vCYg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Tidy up symbol end fixup
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Michael Petlan <mpetlan@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
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
        Thomas Richter <tmricht@linux.ibm.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Denis Nikitin <denik@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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

On Fri, Apr 8, 2022 at 10:15 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Thu, Apr 7, 2022 at 4:05 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Fixing up more symbol ends as introduced in:
> > https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/
> > caused perf annotate to run into memory limits - every symbol holds
> > all the disassembled code in the annotation, and so making symbols
> > ends further away dramatically increased memory usage (40MB to
> >  >1GB). Modify the symbol end logic so that special kernel cases aren't
> > applied in the common case.
>
> I'm not sure what was the actual problem the patch tried to solve.
> It seems like a specific problem on powerpc + kprobes and now
> it affects all other architectures.

Thanks Namhyung, this patch set reverts that.

> In the above commit, optinsn_slot and kprobe_optinsn_page will
> have the same address and optinsn_slot cannot be fixed up.
> But I guess the kprobe_optinsn_page still can be fixed up and
> you can use the symbol instead, no?
>
> To me, it'd be better to revert the change and add a special
> handling for the kprobe insn pages as they appear as
> modules.
>
> Also, all the arch symbols fixup routine seem to do the same
> then we might move it to the general logic.

Agreed. It isn't possible for me to test that behavior and so the
change tries to make the behavior clearer and to isolate Michael's
change to PowerPC. I like the idea of removing the weak symbols and
making the behavior common. I also don't know why we're trying to fix
broken elf file symbols and don't just let the assembly/compiler
writers fix that.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Minor fix to perf annotate to not stall when stderr is full.
> >
> > Ian Rogers (5):
> >   perf annotate: Drop objdump stderr
> >   perf symbols: Always do architecture specific fixups
> >   perf symbols: Add is_kernel argument to fixup end
> >   perf symbol: By default only fix zero length symbols
> >   perf symbols: More specific architecture end fixing
> >
> >  tools/perf/arch/arm64/util/machine.c   | 14 +++++++++-----
> >  tools/perf/arch/powerpc/util/machine.c | 10 +++++++---
> >  tools/perf/arch/s390/util/machine.c    | 12 ++++++++----
> >  tools/perf/util/annotate.c             |  1 +
> >  tools/perf/util/symbol-elf.c           |  2 +-
> >  tools/perf/util/symbol.c               | 14 ++++++++------
> >  tools/perf/util/symbol.h               |  4 ++--
> >  7 files changed, 36 insertions(+), 21 deletions(-)
> >
> > --
> > 2.35.1.1178.g4f1659d476-goog
> >
