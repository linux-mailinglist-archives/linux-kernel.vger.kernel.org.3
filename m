Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF805135C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347680AbiD1Nzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbiD1Nzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:55:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE03694A2;
        Thu, 28 Apr 2022 06:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C17B0B82D0B;
        Thu, 28 Apr 2022 13:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5544CC385A9;
        Thu, 28 Apr 2022 13:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651153951;
        bh=ODsMq+Ft6dlX/IlXg4fQJ5/+B9MFbJhJJW4Q4ktgLxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eAQ2tkW+noTloQZoa3bawPAwbQnElGK0hQb/COxBVytIy6TX2Ejj95XwXO+nGKI4V
         a35LPeQNI3AIi+uz4Y2X02zHmwACwr/q+20eHNrLBfNE34fNxJ2KeHgsln3ygah9pt
         vhlJAX11NIXY1yVt0UyfYUE9G4vJ9G1RSxC1sCkzDZuGtWCJji9+r52pOdC0Mijy9S
         dzOH2OrF9bf3tm5tZARzRxaFs1rhiUgKa5f2T/po64gaLVpRdYVu+nYCGECuapIQbR
         M8KBuFnmaSCBXBMpURObGEofM5FOAzBsH3evsgzBAR7rnlFndWKvQOtFKy9+0mykuQ
         Lq6lRBWsKXJFA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D0F09400B1; Thu, 28 Apr 2022 10:52:28 -0300 (-03)
Date:   Thu, 28 Apr 2022 10:52:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Song Liu <songliubraving@fb.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/3] perf tools: Tidy up symbol end fixup (v3)
Message-ID: <YmqcHFtVTfvCCbTW@kernel.org>
References: <20220416004048.1514900-1-namhyung@kernel.org>
 <CAP-5=fUUeqimTKoO9PQbm4yDWXZtTqxWm9ZAsNt1=K5N1Rq_Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUUeqimTKoO9PQbm4yDWXZtTqxWm9ZAsNt1=K5N1Rq_Lg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 25, 2022 at 01:59:03PM -0700, Ian Rogers escreveu:
> On Fri, Apr 15, 2022 at 5:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > This work is a follow-up of Ian's previous one at
> >   https://lore.kernel.org/all/20220412154817.2728324-1-irogers@google.com/
> >
> > Fixing up more symbol ends as introduced in:
> >   https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/
> >
> > it caused perf annotate to run into memory limits - every symbol holds
> > all the disassembled code in the annotation, and so making symbols
> > ends further away dramatically increased memory usage (40MB to >1GB).
> >
> > Modify the symbol end fixup logic so that special kernel cases aren't
> > applied in the common case.
> >
> > v3 changes)
> >  * rename is_kernel to is_kallsyms
> >  * move the logic to generic function
> >  * remove arch-specific functions
> >
> > Thanks,
> > Namhyung
> 
> Thanks Namhyung! The series:
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf/urgent.

- Arnaldo

 
> > Namhyung Kim (3):
> >   perf symbol: Pass is_kallsyms to symbols__fixup_end()
> >   perf symbol: Update symbols__fixup_end()
> >   perf symbol: Remove arch__symbols__fixup_end()
> >
> >  tools/perf/arch/arm64/util/machine.c   | 21 ---------------
> >  tools/perf/arch/powerpc/util/Build     |  1 -
> >  tools/perf/arch/powerpc/util/machine.c | 25 -----------------
> >  tools/perf/arch/s390/util/machine.c    | 16 -----------
> >  tools/perf/util/symbol-elf.c           |  2 +-
> >  tools/perf/util/symbol.c               | 37 +++++++++++++++++++-------
> >  tools/perf/util/symbol.h               |  3 +--
> >  7 files changed, 29 insertions(+), 76 deletions(-)
> >  delete mode 100644 tools/perf/arch/powerpc/util/machine.c
> >
> >
> > base-commit: 41204da4c16071be9090940b18f566832d46becc
> > --
> > 2.36.0.rc0.470.gd361397f0d-goog
> >

-- 

- Arnaldo
