Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FC8599A31
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348370AbiHSKxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348329AbiHSKxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:53:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB2518E0E;
        Fri, 19 Aug 2022 03:53:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i14so8086207ejg.6;
        Fri, 19 Aug 2022 03:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=n5b4gLRU57ol540m2Lq3kAyOpI/C7q+KhHBbiuYFG8c=;
        b=T3r6NyvDUNtGuj+rZ+Hn42RdMF1v7WVa8uFIibUt8zAUonA6guWpxoczM/f32PhfE6
         U65PguvwHmGNZctml0Ri8gYGLDqd9KR/uM6LzO9UV2PWvrVa/EkW5/lLV2h2EoXpgHog
         gEAnqAC40u9txvLlibzOVUxKJ6Molcb5M/WV/glfb06habP2yHAK+MtPX9fx3/oNBtY6
         USosV7XZzrEDusPNkaOrbLinXoKY874vrvZPS8lUZ5c7+ltMBESFiLmJsHGC1NEMx86H
         l7Z/At6zuIvgkGtcAJS86Jxbx4emtkt3Zhf0emTt9WyL98HWlhYqxSIjZLb+s3RdGjA9
         jxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=n5b4gLRU57ol540m2Lq3kAyOpI/C7q+KhHBbiuYFG8c=;
        b=oh2/R1ePHWx5bVxJ+cpdNENo39mKdlUSntW7rKPxHz0uDJfC866McVjybb4ShSaUUE
         JpH1yYqxU3rvqRlR7noMnLCGcsnrUkvmi0DXXazJ01KJzDW3sIq+OX3gxMFNLaeTFJvH
         vqB7MTI9d4R1aNpWL5j3EOgB67d7ljFj43kPgSOaBU6C6sM5K9pgJ6k87VdMgAPDVGj7
         sqifP17YoHH8bv8Zsho0KRar5iEhtX65Gwb4m3KUhkrwIlRjo/no6H+SGkMVHYKMq4cj
         1gqA91bOOgCRVpfNtM+tB/mlhpnN2b0BYBJ5GwCzZO9VS9iQzJrtPo27Lc4QumkwkJ/F
         l9og==
X-Gm-Message-State: ACgBeo32CdVmntuLCdlph6QTJBF6wj063qOONGnYCEppSMz/jXYfcfxS
        Z8ubZGwrherGKClgCsLpC8djpeep7kXDMQ==
X-Google-Smtp-Source: AA6agR7nfOZ70HATwB16aoplj2aeP9duhtMh70mmEzLHilxIcynZATqKzF5vG7eaDPQTvGR7dnV4Tg==
X-Received: by 2002:a17:906:eecb:b0:73c:5bcb:8eb3 with SMTP id wu11-20020a170906eecb00b0073c5bcb8eb3mr3001998ejb.284.1660906408423;
        Fri, 19 Aug 2022 03:53:28 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id s13-20020a05640217cd00b00445f660de5csm2831373edy.85.2022.08.19.03.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 03:53:28 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 19 Aug 2022 12:53:26 +0200
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/4] perf tools: Support reading PERF_FORMAT_LOST (v3)
Message-ID: <Yv9rplmtHB5fZsv+@krava>
References: <20220819003644.508916-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819003644.508916-1-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 05:36:40PM -0700, Namhyung Kim wrote:
> Hello,
> 
> The kernel v6.0 added PERF_FORMAT_LOST which can read a number of lost
> samples for the given event.  As it can change the output format of
> read(2) and perf sample data, it needs to access them carefully.
> 
> Changes in v3)
>  * add sample_read_group__for_each()  (Jiri)

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> Changes in v2)
>  * add a comment in perf_evsel__read_group()  (Jiri)
>  * simplify perf_evsel__adjust_values()  (Jiri)
> 
> 
> You can get the code from 'perf/read-lost-v3' brach on
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> Namhyung Kim (4):
>   tools headers UAPI: Sync linux/perf_event.h with the kernel sources
>   tools lib perf: Handle read format in perf_evsel__read()
>   tools lib perf: Add a test case for read formats
>   perf tools: Support reading PERF_FORMAT_LOST
> 
>  tools/include/uapi/linux/perf_event.h         |   5 +-
>  tools/lib/perf/evsel.c                        |  79 ++++++++-
>  tools/lib/perf/include/perf/event.h           |   3 +-
>  tools/lib/perf/include/perf/evsel.h           |   4 +-
>  tools/lib/perf/tests/test-evsel.c             | 161 ++++++++++++++++++
>  tools/perf/tests/sample-parsing.c             |  14 +-
>  tools/perf/util/event.h                       |  21 ++-
>  tools/perf/util/evsel.c                       |  29 ++--
>  .../scripting-engines/trace-event-python.c    |  19 ++-
>  tools/perf/util/session.c                     |  35 ++--
>  tools/perf/util/synthetic-events.c            |  32 +++-
>  11 files changed, 356 insertions(+), 46 deletions(-)
> 
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> -- 
> 2.37.1.595.g718a3a8f04-goog
> 
