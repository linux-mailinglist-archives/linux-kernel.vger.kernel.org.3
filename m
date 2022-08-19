Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B20A599FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 18:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352116AbiHSQTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 12:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352108AbiHSQPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 12:15:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330E5D83ED;
        Fri, 19 Aug 2022 08:58:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D94561644;
        Fri, 19 Aug 2022 15:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CCBC433C1;
        Fri, 19 Aug 2022 15:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660924718;
        bh=jZkm9DTACQV+CBvNGwKYZM0g86biojOTExli8sSeSBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b9yiSyZeJErT7d9JnfdCGOhfzh3cyYM4ixrg4XFeiNauXu5J3I9j/C8qKwnFdo6Ih
         9NhAEQqCMNsRIfUxA5xcl07bt5ChbG2uSgpAWasMqkqo5Er5iR7VaI35jDdnhqoTet
         4G6QkVgp7tDfnvn5loQ5NhX9lAONn0MmnmX5jfKpEKy3G1TsCBG8DKNRl3EMDT9eFM
         76GRmncGRPQpI6xV1bE3drTV+fRu9+YabOQrzbTomxRzS/qTcRPXpvlsAFaD7GFfnA
         L/kB8FUACwjYcfw8/YN6SS43ImvyHrLCb5HiIVgjDlkR9i0M9VaKeOy4rHu481zuQ0
         p78Zi5RCO04xw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0BEFC4035A; Fri, 19 Aug 2022 12:58:36 -0300 (-03)
Date:   Fri, 19 Aug 2022 12:58:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v2 4/6] perf cpumap: Fix alignment for masks in event
 encoding
Message-ID: <Yv+zK8UxUAP83zkp@kernel.org>
References: <20220614143353.1559597-1-irogers@google.com>
 <20220614143353.1559597-5-irogers@google.com>
 <Yv60COAP90TEiWkx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv60COAP90TEiWkx@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 18, 2022 at 06:50:00PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jun 14, 2022 at 07:33:51AM -0700, Ian Rogers escreveu:
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
> > Fix the mask struct by creating explicit 32 and 64-bit variants, use a
> > union to avoid data[] and casts; the struct must be packed so the
> > layout matches the existing perf.data layout. Taking an address of a
> > member of a packed struct breaks alignment so pass the packed
> > perf_record_cpu_map_data to functions, so they can access variables with
> > the right alignment.
> > 
> > As the 64-bit version has 4 bytes of padding, optimizing writing to only
> > write the 32-bit version.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/include/perf/event.h | 36 +++++++++++--
> >  tools/perf/tests/cpumap.c           | 19 ++++---
> >  tools/perf/util/cpumap.c            | 80 +++++++++++++++++++++++------
> >  tools/perf/util/cpumap.h            |  4 +-
> >  tools/perf/util/session.c           | 30 +++++------
> >  tools/perf/util/synthetic-events.c  | 34 +++++++-----
> >  6 files changed, 143 insertions(+), 60 deletions(-)
> > 
> > diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> > index e7758707cadd..d2d32589758a 100644
> > --- a/tools/lib/perf/include/perf/event.h
> > +++ b/tools/lib/perf/include/perf/event.h
> > @@ -6,6 +6,7 @@
> >  #include <linux/types.h>
> >  #include <linux/limits.h>
> >  #include <linux/bpf.h>
> > +#include <linux/compiler.h>
> >  #include <sys/types.h> /* pid_t */
> >  
> >  #define event_contains(obj, mem) ((obj).header.size > offsetof(typeof(obj), mem))
> > @@ -153,20 +154,47 @@ enum {
> >  	PERF_CPU_MAP__MASK = 1,
> >  };
> >  
> > +/*
> > + * Array encoding of a perf_cpu_map where nr is the number of entries in cpu[]
> > + * and each entry is a value for a CPU in the map.
> > + */
> >  struct cpu_map_entries {
> >  	__u16			 nr;
> >  	__u16			 cpu[];
> >  };
> >  
> > -struct perf_record_record_cpu_map {
> > +/* Bitmap encoding of a perf_cpu_map where bitmap entries are 32-bit. */
> > +struct perf_record_mask_cpu_map32 {
> > +	/* Number of mask values. */
> >  	__u16			 nr;
> > +	/* Constant 4. */
> >  	__u16			 long_size;
> > -	unsigned long		 mask[];
> > +	/* Bitmap data. */
> > +	__u32			 mask[];
> >  };
> >  
> > -struct perf_record_cpu_map_data {
> > +/* Bitmap encoding of a perf_cpu_map where bitmap entries are 64-bit. */
> > +struct perf_record_mask_cpu_map64 {
> > +	/* Number of mask values. */
> > +	__u16			 nr;
> > +	/* Constant 8. */
> > +	__u16			 long_size;
> > +	/* Legacy padding. */
> > +	char                     __pad[4];
> > +	/* Bitmap data. */
> > +	__u64			 mask[];
> > +};
> > +
> > +struct __packed perf_record_cpu_map_data {
> 
> In various places I'm getting this:
> 
> [perfbuilder@five x-riscv]$ export BUILD_TARBALL=http://192.168.86.14/perf/perf-6.0.0-rc1.tar.xz
> [perfbuilder@five x-riscv]$ time dm .
>    1     5.47 ubuntu:22.04-x-riscv64        : FAIL gcc version 11.2.0 (Ubuntu 11.2.0-16ubuntu1)
>     In file included from mmap.c:10:
>     /git/perf-6.0.0-rc1/tools/lib/perf/include/perf/event.h:190:34: error: packed attribute causes inefficient alignment for 'type' [-Werror=attributes]
>       190 |         __u16                    type;
>           |                                  ^~~~
>     cc1: all warnings being treated as errors
>     In file included from util/event.h:12,
>                      from builtin-diff.c:12:
>     /git/perf-6.0.0-rc1/tools/lib/perf/include/perf/event.h:190:34: error: packed attribute causes inefficient alignment for 'type' [-Werror=attributes]
>       190 |         __u16                    type;
>           |                                  ^~~~
>     In file included from util/events_stats.h:6,
>                      from util/evlist.h:12,
>                      from builtin-evlist.c:11:
>     /git/perf-6.0.0-rc1/tools/lib/perf/include/perf/event.h:190:34: error: packed attribute causes inefficient alignment for 'type' [-Werror=attributes]
>       190 |         __u16                    type;
>           |                                  ^~~~
> 
> So probably we need to disable this -Werror=attributes in some
> architectures?

Slapped this there:

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpacked"
#pragma GCC diagnostic ignored "-Wattributes"

struct __packed perf_record_cpu_map_data {
        __u16                    type;
        union {
                /* Used when type == PERF_CPU_MAP__CPUS. */
                struct cpu_map_entries cpus_data;
                /* Used when type == PERF_CPU_MAP__MASK and long_size == 4. */
                struct perf_record_mask_cpu_map32 mask32_data;
                /* Used when type == PERF_CPU_MAP__MASK and long_size == 8. */
                struct perf_record_mask_cpu_map64 mask64_data;
        };
};

#pragma GCC diagnostic pop

