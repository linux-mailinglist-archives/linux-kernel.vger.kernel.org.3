Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8955B58A1E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbiHDUXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiHDUXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:23:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395E26D556;
        Thu,  4 Aug 2022 13:23:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id m4so1338790ejr.3;
        Thu, 04 Aug 2022 13:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=jXfSwIVHH5n0bd8ihUeImZw7y0OX8igYXCyoA7ZaxS0=;
        b=LwAXYbKVkp+zbNDblZPDf5TS4z/8LXvzWeOvJhDHqCaj+dRAy2vmB/oSk7HnWNsC2c
         JxKzLvRfwevhn4fzSUG//t5CW8rvx1UmRD5wsfAUAtO3rCUpgBGuwjWINVmWvicQixNS
         l9H9BP8Dtk3F1oORE/lpWh84boBRpJ8PeUCehbfivHUJ8dE002kGiiRq5Wfn6qVDEP58
         ZA2IsJL7kshfxUGMLPNIN3H947Mfkc5eD2iliO8I3DscF0DEuMmNRqiSsPsG8CIrBlc+
         od9TjS8/l90kO4XsvsNsligDjxHb86lzqVoLHw1TL+ZyrInSTD9hdp7hS9G44unqf2NO
         xHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=jXfSwIVHH5n0bd8ihUeImZw7y0OX8igYXCyoA7ZaxS0=;
        b=vPOJCwM6NPUSr6XEL0SycxqildAGkN+ierIxgA7NLpenZsYd4EimtjacpgLKdIb8E6
         OWAiew1n4mOBx/PHialWI0Y+AMv3spXyiocXmu7NmkNgRUH8D89821MbADY9ra3kizNl
         ajNpYby4geRBtItdAu1lxYZDyKi7KMiEMpN1vnnQ83yxaMK9kDpyqe0+BK82CBmjLbAE
         07Xb8QtPnMYEV66vSIQlsBdlutNY9rxdH/Uvj+69Yz3n53a/vzBcvAwxa5DAI1hyJiSZ
         s9A+X+W5zpMuNU7OPXpDbFNJqpCdeu7U4DvSsSVoSQaWiGjYd8D4NRjsXhEWq8lSqqYv
         cfjA==
X-Gm-Message-State: ACgBeo3YpHd5FJVopfh5/hoCKQjI30AprnzNdEM3gXp0NseoNIoMvEA0
        K1U0EIUdLIDesL2Nl4Hlzjs=
X-Google-Smtp-Source: AA6agR4oyK0YED/1FR9FdT7TBlIRZ/M2U896QReMZ+uLFHSeBWKZpEarxRCoOOb6t4tG6jpBFAzqOw==
X-Received: by 2002:a17:906:ef8b:b0:730:d348:61b9 with SMTP id ze11-20020a170906ef8b00b00730d34861b9mr2654647ejb.350.1659644589481;
        Thu, 04 Aug 2022 13:23:09 -0700 (PDT)
Received: from krava ([83.240.62.222])
        by smtp.gmail.com with ESMTPSA id kx16-20020a170907775000b00724261b592esm661620ejc.186.2022.08.04.13.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 13:23:09 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 4 Aug 2022 22:23:07 +0200
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <Yuwqq1g5EgCzUohJ@krava>
References: <20220614143353.1559597-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614143353.1559597-1-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 07:33:47AM -0700, Ian Rogers wrote:
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

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
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
