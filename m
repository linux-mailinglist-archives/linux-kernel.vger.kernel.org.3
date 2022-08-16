Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BBD59635A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbiHPTvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbiHPTvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:51:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8213175CEE;
        Tue, 16 Aug 2022 12:51:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37208B81AC0;
        Tue, 16 Aug 2022 19:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94208C433D6;
        Tue, 16 Aug 2022 19:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660679479;
        bh=9Q/pf0so7WSGxkB12FCvUhVTrgPXVhTi5aoIK6pQDLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUNMJUmgWfPgwP8Aota1389YB7L5X0XscSLVhS1KJwYqSVYBdSyvTwjLV9QnbbrWG
         ZYafSXuh9vcEwX8SC8w90hgtcsO/nZz3nX9NIvSMNNNrzfmB3pjUvW/cUcz4N4zYvJ
         gjbIgOrM/TqGwzMRLafOsnFjB31ZzlzUhSl3x0Zsq4CyA2QKeLXyvpU9NEBMPz8BvA
         v6oKSC6zM6fmedT5eEU3JzS4YpsEd7aNFy+rJweGOpnViW0rBmM/0kkpAoi3+yT7pj
         SXQBSjAil3wjJqI+FFrgIZhf9CUJJDQX1w6CQHPwnObdb6nIZlkkUeHZZSPS9iOne2
         ff6HRgU2PIIFQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0DFB04035A; Tue, 16 Aug 2022 16:51:16 -0300 (-03)
Date:   Tue, 16 Aug 2022 16:51:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
Subject: Re: [PATCH v2 0/6] Corrections to cpu map event encoding
Message-ID: <Yvv1M05H9Dkj+GN0@kernel.org>
References: <20220614143353.1559597-1-irogers@google.com>
 <Yuwqq1g5EgCzUohJ@krava>
 <CAP-5=fX-Ex1uv0hxCwDkkAyFV6VQNPRB5uSPpCDNgqu5ZV=bCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fX-Ex1uv0hxCwDkkAyFV6VQNPRB5uSPpCDNgqu5ZV=bCA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Aug 14, 2022 at 04:05:19PM -0700, Ian Rogers escreveu:
> Hi,
> 
> It looks like we missed this one. Can it get into the next PR as a fix?

I've queued up to 4/6 for perf/urgent, 5 and 6 will go to perf/core once
I merge perf/urgent there, i.e. after I send this to Linus.

- Arnaldo
 
> Thanks,
> Ian
> 
> 
> On Thu, Aug 4, 2022 at 1:23 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > On Tue, Jun 14, 2022 at 07:33:47AM -0700, Ian Rogers wrote:
> > > A mask encoding of a cpu map is laid out as:
> > >   u16 nr
> > >   u16 long_size
> > >   unsigned long mask[];
> > > However, the mask may be 8-byte aligned meaning there is a 4-byte pad
> > > after long_size. This means 32-bit and 64-bit builds see the mask as
> > > being at different offsets. On top of this the structure is in the byte
> > > data[] encoded as:
> > >   u16 type
> > >   char data[]
> > > This means the mask's struct isn't the required 4 or 8 byte aligned, but
> > > is offset by 2. Consequently the long reads and writes are causing
> > > undefined behavior as the alignment is broken.
> > >
> > > These changes do minor clean up with const, visibility of functions
> > > and using the constant time max function. It then adds 32 and 64-bit
> > > mask encoding variants, packed to match current alignment. Taking the
> > > address of a packed struct leads to unaligned data, so function
> > > arguments are altered to be passed the packed struct. To compact the
> > > mask encoding further and drop the padding, the 4-byte variant is
> > > preferred. Finally a new range encoding is added, that reduces the
> > > size of the common case of a range of CPUs to a single u64.
> > >
> > > On a 72 CPU (hyperthread) machine the original encoding of all CPUs is:
> > > 0x9a98 [0x28]: event: 74
> > > .
> > > . ... raw event: size 40 bytes
> > > .  0000:  4a 00 00 00 00 00 28 00 01 00 02 00 08 00 00 00
> > J.....(.........
> > > .  0010:  00 00 ff ff ff ff ff ff ff ff ff 00 00 00 00 00
> > ................
> > > .  0020:  00 00 00 00 00 00 00 00                          ........
> >
> > >
> > > 0 0 0x9a98 [0x28]: PERF_RECORD_CPU_MAP
> > >
> > > Using the 4-byte encoding it is:
> > > 0x9a98@pipe [0x20]: event: 74
> > > .
> > > . ... raw event: size 32 bytes
> > > .  0000:  4a 00 00 00 00 00 20 00 01 00 03 00 04 00 ff ff  J.....
> > .........
> > > .  0010:  ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00 00
> > ................
> > >
> > > 0 0 0x9a98 [0x20]: PERF_RECORD_CPU_MAP
> > >
> > > Finally, with the range encoding it is:
> > > 0x9ab8@pipe [0x10]: event: 74
> > > .
> > > . ... raw event: size 16 bytes
> > > .  0000:  4a 00 00 00 00 00 10 00 02 00 00 00 00 00 47 00
> > J.............G.
> > >
> > > 0 0 0x9ab8 [0x10]: PERF_RECORD_CPU_MAP
> > >
> > > v2. Fixes a bug in the size computation of the update header
> > >     introduced by the last patch (Add range data encoding) and caught
> > >     by address sanitizer.
> > >
> > > Ian Rogers (6):
> > >   perf cpumap: Const map for max
> > >   perf cpumap: Synthetic events and const/static
> > >   perf cpumap: Compute mask size in constant time
> > >   perf cpumap: Fix alignment for masks in event encoding
> > >   perf events: Prefer union over variable length array
> > >   perf cpumap: Add range data encoding
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> > thanks,
> > jirka
> >
> > >
> > >  tools/lib/perf/cpumap.c              |   2 +-
> > >  tools/lib/perf/include/perf/cpumap.h |   2 +-
> > >  tools/lib/perf/include/perf/event.h  |  61 ++++++++-
> > >  tools/perf/tests/cpumap.c            |  71 ++++++++---
> > >  tools/perf/tests/event_update.c      |  14 +--
> > >  tools/perf/util/cpumap.c             | 111 +++++++++++++---
> > >  tools/perf/util/cpumap.h             |   4 +-
> > >  tools/perf/util/event.h              |   4 -
> > >  tools/perf/util/header.c             |  24 ++--
> > >  tools/perf/util/session.c            |  35 +++---
> > >  tools/perf/util/synthetic-events.c   | 182 +++++++++++++--------------
> > >  tools/perf/util/synthetic-events.h   |   2 +-
> > >  12 files changed, 327 insertions(+), 185 deletions(-)
> > >
> > > --
> > > 2.36.1.476.g0c4daa206d-goog
> > >
> >

-- 

- Arnaldo
