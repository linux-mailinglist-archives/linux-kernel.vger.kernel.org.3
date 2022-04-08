Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D84F9B74
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbiDHRRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbiDHRRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:17:39 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8BFAE5F;
        Fri,  8 Apr 2022 10:15:35 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id p10so16111777lfa.12;
        Fri, 08 Apr 2022 10:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BVoXI5fgim3/iK2/LX7lFIzEYssjRbCGQ7oINBoW+5Y=;
        b=Ht5pw85XY7vbBclZjidb1ElcN4DNsKMK/Py8TmN0GOb3ms8KG91+OpK/BQgGBRj1//
         TqY46wg0/szGeMpexa34JzuVScztna88l4dlHNojQrtrjyp9/LlQw0usBTuXMa/f39bz
         0CiVvKgxtBR+pNQUDi7ScP5RTYC2BujhGv6bQB2ilc88WblW3H0MTqbFd4ssOddy6VFH
         VHdxRVxin2ySla2Efx92uHk5xt2epWqKC493a6R/t4GvF7u+ia8HuOm1Nr/4A08tb8Ab
         WWtEXtThHaSTgU3ZNVOOa1xVlbAua6bXDCn69Egqg9XsNWCTP9Kun6QE9vEoS8QbdMLx
         f4rg==
X-Gm-Message-State: AOAM533axevof8W2wKKnbbuKTnV4sfo9kUkmXEbTgdNFsMZT/aWKz+dm
        4mstMq/+HpuCKOVhDKzzaf2+sPS0R6CV4HpLtyk=
X-Google-Smtp-Source: ABdhPJwc51dJyE7Ya2f2tQc7Sxdh+v1i3t8ZfqPLAfkmC3RvJJIBUn1ad3Zk5J7iQrZoGX7O7ODyG9qRUtTRJhBVdpQ=
X-Received: by 2002:a05:6512:3094:b0:44a:6dcc:42da with SMTP id
 z20-20020a056512309400b0044a6dcc42damr13479257lfd.454.1649438133504; Fri, 08
 Apr 2022 10:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220407230503.1265036-1-irogers@google.com>
In-Reply-To: <20220407230503.1265036-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 8 Apr 2022 10:15:22 -0700
Message-ID: <CAM9d7cjM5jpPfdWUvoezYYJoz_Sh1rHpGHVGAvxOqxzb=AKBVQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Tidy up symbol end fixup
To:     Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
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
        Thomas Richter <tmricht@linux.ibm.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
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

Hi Ian,

On Thu, Apr 7, 2022 at 4:05 PM Ian Rogers <irogers@google.com> wrote:
>
> Fixing up more symbol ends as introduced in:
> https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/
> caused perf annotate to run into memory limits - every symbol holds
> all the disassembled code in the annotation, and so making symbols
> ends further away dramatically increased memory usage (40MB to
>  >1GB). Modify the symbol end logic so that special kernel cases aren't
> applied in the common case.

I'm not sure what was the actual problem the patch tried to solve.
It seems like a specific problem on powerpc + kprobes and now
it affects all other architectures.

In the above commit, optinsn_slot and kprobe_optinsn_page will
have the same address and optinsn_slot cannot be fixed up.
But I guess the kprobe_optinsn_page still can be fixed up and
you can use the symbol instead, no?

To me, it'd be better to revert the change and add a special
handling for the kprobe insn pages as they appear as
modules.

Also, all the arch symbols fixup routine seem to do the same
then we might move it to the general logic.

Thanks,
Namhyung

>
> Minor fix to perf annotate to not stall when stderr is full.
>
> Ian Rogers (5):
>   perf annotate: Drop objdump stderr
>   perf symbols: Always do architecture specific fixups
>   perf symbols: Add is_kernel argument to fixup end
>   perf symbol: By default only fix zero length symbols
>   perf symbols: More specific architecture end fixing
>
>  tools/perf/arch/arm64/util/machine.c   | 14 +++++++++-----
>  tools/perf/arch/powerpc/util/machine.c | 10 +++++++---
>  tools/perf/arch/s390/util/machine.c    | 12 ++++++++----
>  tools/perf/util/annotate.c             |  1 +
>  tools/perf/util/symbol-elf.c           |  2 +-
>  tools/perf/util/symbol.c               | 14 ++++++++------
>  tools/perf/util/symbol.h               |  4 ++--
>  7 files changed, 36 insertions(+), 21 deletions(-)
>
> --
> 2.35.1.1178.g4f1659d476-goog
>
