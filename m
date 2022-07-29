Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A563D584983
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiG2CB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiG2CBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:01:24 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF3778DF3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:01:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k8so2159700wrd.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKo8b4je0iqGq0uiZqH7zNlb83Vh1FNB/a+r4AK80T8=;
        b=qh/wY2GLSdmFq98iuNUcPy+KISCMDt6bBos/1GYLClu9zYRT/nXaP5i+OJ8hXmfVO6
         UXskbmrAJp4z/3BdcnKPVmml7oVvCQ7bXKvfMOYp9kt2psTEm3gGWndKuoWJzn4nq/Xr
         RO77QEI12dSndxUphWJJYr6AR2gmPIa4wKvB286Z92abF3FDI/bREF0n1EK7gZ20GbXk
         j+C1LiRus03zDSAWa5zspECdBRh0egOKxK4KH0/Y9Jsl5mnGCa8EOl1u2pYUJf3Tcwtt
         zzhJVyewPd6rv6b9xZvVXMMAGskp7iBeqCnx2dmhiyMaX/9z7WZyyfn9xEDHdsKfyzVu
         mURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKo8b4je0iqGq0uiZqH7zNlb83Vh1FNB/a+r4AK80T8=;
        b=Q7RZxZ8UvjWml/CnvywcP7YUUcFsqU/nDe+b19VllX+YlB5IvhR5A42O6x6RPzSx1L
         E3vKOrE3VMmaugWLW+nloeOtiQd+AlFNSGn3jgvEJZXaNLG/SKDA73antAdyDTRjIVI6
         h1SUXGFV4NlLIEL/syzjs1/8klyfCvNm2xoBxcIu9kGv5vKlXI7+S0dWxytIDB/CbCMx
         2j8Cofb9DY5DPFmDtu/4VxLrYolGC6WSPxie+mIgutpGOUFxnK6rlm4NvjKdXr7zAszr
         cMAbInfaVmOez6TBu/ZCO9pukKQIqTRolM/09PKTGYzOuygGKOb+Py5mDNrMufvXcPNZ
         TWhw==
X-Gm-Message-State: ACgBeo0P/o6pxVcyg1/Iiu3NONVPZM+TJGsMq97o05rNz0cFquLqKXHr
        URvqbA46xgeJGKJB3gzyLTDE7LsaZW6tD4gS7L6FBQ==
X-Google-Smtp-Source: AA6agR5cPNsIfML6yyQKPbDjRDBRwyuxiIL3O1NzD4HMAqamz2pbk6MDyllQ67IBlyD/TQOOtay5gTHQrQvjOVSig1Y=
X-Received: by 2002:a5d:6d4e:0:b0:21e:660e:55bf with SMTP id
 k14-20020a5d6d4e000000b0021e660e55bfmr824800wri.343.1659060081456; Thu, 28
 Jul 2022 19:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com> <CAP-5=fVwWDyD5R7mkdGEqP1dchDOsdmrAPbaZFE7bUjYM3pYFA@mail.gmail.com>
In-Reply-To: <CAP-5=fVwWDyD5R7mkdGEqP1dchDOsdmrAPbaZFE7bUjYM3pYFA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 28 Jul 2022 19:01:09 -0700
Message-ID: <CAP-5=fVyyj4nwam3grTAw94w8Ad+qZP6LDxYZv17vP2ph6pXwA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Corrections to cpu map event encoding
To:     Peter Zijlstra <peterz@infradead.org>,
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
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:01 AM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Jun 14, 2022 at 7:33 AM Ian Rogers <irogers@google.com> wrote:
> >
> > A mask encoding of a cpu map is laid out as:
> >   u16 nr
> >   u16 long_size
> >   unsigned long mask[];
> > However, the mask may be 8-byte aligned meaning there is a 4-byte pad
> > after long_size. This means 32-bit and 64-bit builds see the mask as
> > being at different offsets. On top of this the structure is in the byte
> > data[] encoded as:
> >   u16 type
> >   char data[]
> > This means the mask's struct isn't the required 4 or 8 byte aligned, but
> > is offset by 2. Consequently the long reads and writes are causing
> > undefined behavior as the alignment is broken.
> >
> > These changes do minor clean up with const, visibility of functions
> > and using the constant time max function. It then adds 32 and 64-bit
> > mask encoding variants, packed to match current alignment. Taking the
> > address of a packed struct leads to unaligned data, so function
> > arguments are altered to be passed the packed struct. To compact the
> > mask encoding further and drop the padding, the 4-byte variant is
> > preferred. Finally a new range encoding is added, that reduces the
> > size of the common case of a range of CPUs to a single u64.
> >
> > On a 72 CPU (hyperthread) machine the original encoding of all CPUs is:
> > 0x9a98 [0x28]: event: 74
> > .
> > . ... raw event: size 40 bytes
> > .  0000:  4a 00 00 00 00 00 28 00 01 00 02 00 08 00 00 00  J.....(.........
> > .  0010:  00 00 ff ff ff ff ff ff ff ff ff 00 00 00 00 00  ................
> > .  0020:  00 00 00 00 00 00 00 00                          ........
> >
> > 0 0 0x9a98 [0x28]: PERF_RECORD_CPU_MAP
> >
> > Using the 4-byte encoding it is:
> > 0x9a98@pipe [0x20]: event: 74
> > .
> > . ... raw event: size 32 bytes
> > .  0000:  4a 00 00 00 00 00 20 00 01 00 03 00 04 00 ff ff  J..... .........
> > .  0010:  ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00 00  ................
> >
> > 0 0 0x9a98 [0x20]: PERF_RECORD_CPU_MAP
> >
> > Finally, with the range encoding it is:
> > 0x9ab8@pipe [0x10]: event: 74
> > .
> > . ... raw event: size 16 bytes
> > .  0000:  4a 00 00 00 00 00 10 00 02 00 00 00 00 00 47 00  J.............G.
> >
> > 0 0 0x9ab8 [0x10]: PERF_RECORD_CPU_MAP
> >
> > v2. Fixes a bug in the size computation of the update header
> >     introduced by the last patch (Add range data encoding) and caught
> >     by address sanitizer.
> >
> > Ian Rogers (6):
> >   perf cpumap: Const map for max
> >   perf cpumap: Synthetic events and const/static
> >   perf cpumap: Compute mask size in constant time
> >   perf cpumap: Fix alignment for masks in event encoding
> >   perf events: Prefer union over variable length array
> >   perf cpumap: Add range data encoding
>
> Ping. There was some feedback on this change but nothing to create a
> v3. Feedback/acked-by/reviewed-by appreciated.

Ping. Feedback appreciated.

Thanks,
Ian

> Thanks,
> Ian
>
> >  tools/lib/perf/cpumap.c              |   2 +-
> >  tools/lib/perf/include/perf/cpumap.h |   2 +-
> >  tools/lib/perf/include/perf/event.h  |  61 ++++++++-
> >  tools/perf/tests/cpumap.c            |  71 ++++++++---
> >  tools/perf/tests/event_update.c      |  14 +--
> >  tools/perf/util/cpumap.c             | 111 +++++++++++++---
> >  tools/perf/util/cpumap.h             |   4 +-
> >  tools/perf/util/event.h              |   4 -
> >  tools/perf/util/header.c             |  24 ++--
> >  tools/perf/util/session.c            |  35 +++---
> >  tools/perf/util/synthetic-events.c   | 182 +++++++++++++--------------
> >  tools/perf/util/synthetic-events.h   |   2 +-
> >  12 files changed, 327 insertions(+), 185 deletions(-)
> >
> > --
> > 2.36.1.476.g0c4daa206d-goog
> >
