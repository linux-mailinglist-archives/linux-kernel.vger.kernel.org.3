Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9FA576579
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiGORBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbiGORBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:01:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCDC82F87
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:01:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id az2-20020a05600c600200b003a301c985fcso3144968wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tsymxV+5M24pPXH3QqQTNrAk6PRXpSjbDyG398pyk64=;
        b=PaXFRqZbS2vYPwidy+gX7fEd/Iz7nWSXaBdLxtE9h5WXaFeqYEWHPyu+jRlMA4k2op
         xDpCtZ1js6OEfv4SXZtldXyXuBYP/n6dDjhT8WeaM9GeYP/HRLqm1iAuOEZk53gFAD55
         Q5CBXBBuNf0BtoIKBW+g+tz1M5yWHoxefZeqv+c7s1U55CF/Yc8hbostSdxWYhzL07J5
         zzgwLjaSlqPgNbvtMQ03GI5ONQk+aJUCgSLYJKkEs+5+CemeTIfhCpLTntSKBZPYr4Y3
         9AGbsXq6H0eV+NskTVHfa2esu4/u+L0WQIE2nnT05HEXEwUB+6jEOvyIt/n9o+A7GJ9T
         YI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tsymxV+5M24pPXH3QqQTNrAk6PRXpSjbDyG398pyk64=;
        b=NrPWCmnB9L+m5V4iI1LWD3ZVNKidqH0MR9YLMYeX5PdM6oxRzZCCixTnIf0xqXRrfx
         q3XNlY5MC/J+4RvW/gI33XkzkA/7+40a73hv2Oj6y9RDDHiLYJVXxOIV4DxicJzszhQC
         o6M0ch84ltSZjWGOboqL7hrn+2gRVrQCSX/R1LND8jZM51sZUbaFpyVxP7fqwX7OBnvr
         0gF64wgrNQbVSTx670jVA0jUU6zuz/b/CEBw318+a/dVQkO3Q/+DAHpIxeh7BGf7Fu7/
         ev+nvOqixoL9Sa59U4xTDq4DVA6e/o5wVQlbtXWMkceV/xuw/CEWOVJhfLPB09xrJG0W
         GnsA==
X-Gm-Message-State: AJIora/phkBxxAWkSB9cjS4YjaXs7YDJ4Z+ulvH1k879cu3z2ki6Xn+d
        YVNCNpaLNlbK8u4i5xIeiyx7pLLOe4IBOPhmJZglrw==
X-Google-Smtp-Source: AGRyM1tZC04VmHLDoxsvJLcToSlBUAqYu0jlNwClIZndRX/isibUmuJZVXTzMIm7vOObJfxkqbLQ5pc2YkqvR+C7ffA=
X-Received: by 2002:a05:600c:4e8f:b0:3a1:8b21:ebbc with SMTP id
 f15-20020a05600c4e8f00b003a18b21ebbcmr15406013wmq.149.1657904509095; Fri, 15
 Jul 2022 10:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com>
In-Reply-To: <20220614143353.1559597-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 15 Jul 2022 10:01:36 -0700
Message-ID: <CAP-5=fVwWDyD5R7mkdGEqP1dchDOsdmrAPbaZFE7bUjYM3pYFA@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 7:33 AM Ian Rogers <irogers@google.com> wrote:
>
> A mask encoding of a cpu map is laid out as:
>   u16 nr
>   u16 long_size
>   unsigned long mask[];
> However, the mask may be 8-byte aligned meaning there is a 4-byte pad
> after long_size. This means 32-bit and 64-bit builds see the mask as
> being at different offsets. On top of this the structure is in the byte
> data[] encoded as:
>   u16 type
>   char data[]
> This means the mask's struct isn't the required 4 or 8 byte aligned, but
> is offset by 2. Consequently the long reads and writes are causing
> undefined behavior as the alignment is broken.
>
> These changes do minor clean up with const, visibility of functions
> and using the constant time max function. It then adds 32 and 64-bit
> mask encoding variants, packed to match current alignment. Taking the
> address of a packed struct leads to unaligned data, so function
> arguments are altered to be passed the packed struct. To compact the
> mask encoding further and drop the padding, the 4-byte variant is
> preferred. Finally a new range encoding is added, that reduces the
> size of the common case of a range of CPUs to a single u64.
>
> On a 72 CPU (hyperthread) machine the original encoding of all CPUs is:
> 0x9a98 [0x28]: event: 74
> .
> . ... raw event: size 40 bytes
> .  0000:  4a 00 00 00 00 00 28 00 01 00 02 00 08 00 00 00  J.....(.........
> .  0010:  00 00 ff ff ff ff ff ff ff ff ff 00 00 00 00 00  ................
> .  0020:  00 00 00 00 00 00 00 00                          ........
>
> 0 0 0x9a98 [0x28]: PERF_RECORD_CPU_MAP
>
> Using the 4-byte encoding it is:
> 0x9a98@pipe [0x20]: event: 74
> .
> . ... raw event: size 32 bytes
> .  0000:  4a 00 00 00 00 00 20 00 01 00 03 00 04 00 ff ff  J..... .........
> .  0010:  ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00 00  ................
>
> 0 0 0x9a98 [0x20]: PERF_RECORD_CPU_MAP
>
> Finally, with the range encoding it is:
> 0x9ab8@pipe [0x10]: event: 74
> .
> . ... raw event: size 16 bytes
> .  0000:  4a 00 00 00 00 00 10 00 02 00 00 00 00 00 47 00  J.............G.
>
> 0 0 0x9ab8 [0x10]: PERF_RECORD_CPU_MAP
>
> v2. Fixes a bug in the size computation of the update header
>     introduced by the last patch (Add range data encoding) and caught
>     by address sanitizer.
>
> Ian Rogers (6):
>   perf cpumap: Const map for max
>   perf cpumap: Synthetic events and const/static
>   perf cpumap: Compute mask size in constant time
>   perf cpumap: Fix alignment for masks in event encoding
>   perf events: Prefer union over variable length array
>   perf cpumap: Add range data encoding

Ping. There was some feedback on this change but nothing to create a
v3. Feedback/acked-by/reviewed-by appreciated.

Thanks,
Ian

>  tools/lib/perf/cpumap.c              |   2 +-
>  tools/lib/perf/include/perf/cpumap.h |   2 +-
>  tools/lib/perf/include/perf/event.h  |  61 ++++++++-
>  tools/perf/tests/cpumap.c            |  71 ++++++++---
>  tools/perf/tests/event_update.c      |  14 +--
>  tools/perf/util/cpumap.c             | 111 +++++++++++++---
>  tools/perf/util/cpumap.h             |   4 +-
>  tools/perf/util/event.h              |   4 -
>  tools/perf/util/header.c             |  24 ++--
>  tools/perf/util/session.c            |  35 +++---
>  tools/perf/util/synthetic-events.c   | 182 +++++++++++++--------------
>  tools/perf/util/synthetic-events.h   |   2 +-
>  12 files changed, 327 insertions(+), 185 deletions(-)
>
> --
> 2.36.1.476.g0c4daa206d-goog
>
