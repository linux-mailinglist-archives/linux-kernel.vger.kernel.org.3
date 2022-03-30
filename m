Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66174EC5F4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346357AbiC3Nv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346349AbiC3Nv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:51:56 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D74FA216;
        Wed, 30 Mar 2022 06:50:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h1so24521767edj.1;
        Wed, 30 Mar 2022 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y7pqT7vD7H7ZH3vY2pYSiPbBFtiXOL05aDa1RXn365A=;
        b=KrRVct+mSEvyTGpWJVfpNVJdVSa3WSGFL3YyVNCYVF5iatrcoIFQCb7VkQMGH5n4oI
         k1IR1flTmDZrV2BqpX+ky1ywkQC64dxQXe+2K2CB0k1OhRtRCuKtgfRtB1qLCdeaBHnh
         Zo0HB3QbJOrMW/jLUF0A3+pTuqb0ZyXWjKl2pcVhizVuS5DJD60yB+i7ImnKTP+TP8r/
         gXF9BMJ8isIV2/5s3E/yh+L2cH83qzgSU43FM9DRgZs3GEsZ+gr5RqQauWYtsLDomhJB
         1PTGLmhgoaUwQSvFz5faBbpmVLPoOc99bz2i90XiJnbOY7xlz7yDaacPsBsD/m1UBaSO
         Knrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y7pqT7vD7H7ZH3vY2pYSiPbBFtiXOL05aDa1RXn365A=;
        b=oAVszhWy7kjpyi8FNIXpaaTaijpmH0hKfNup3niTK/cZIDVBbStPs7za3vT3Ro7i9L
         NqiDYjehRanEC/R01uxmAX11Rk6IkISk1x3nrPmqaabT/bni7ri8PEoXr2ruG5LKilVS
         zBlAXxQg3uTglL5xoqTTtusW2PIo4kDsrByBKYZnN4slkcr46wCxee9p/rNfJ6ZgioCY
         Sgh9YTGr+sjVr5S2N6rpilW/ngKBEaZ625lEW5P703+VLXud6uNu5+E/rLGd5gcL7AZk
         TUpAu4kb1wwLHQq37Kyu+OWLKcuZC76nPpfmpRn0/zOYxywDmYcr06mn1Md/9J54XTvV
         LYPA==
X-Gm-Message-State: AOAM532C1J7PtwOkB3gzYQXW+F/oToXduk3KdlMTWn9I61K05vAqu+Fi
        Uc72BRYw+8GGCUpxYQxoAp0=
X-Google-Smtp-Source: ABdhPJwigneTEKQ43MeAMlo8GRAs+WD7sIjtv4XQm0ncTJGhHO93oJgobYHQQDhpallNk219UD6X3Q==
X-Received: by 2002:a05:6402:3452:b0:418:f963:42a3 with SMTP id l18-20020a056402345200b00418f96342a3mr10909132edc.12.1648648208286;
        Wed, 30 Mar 2022 06:50:08 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id i11-20020a50fd0b000000b0041936bc0f7esm10006802eds.52.2022.03.30.06.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:50:07 -0700 (PDT)
Date:   Wed, 30 Mar 2022 15:50:05 +0200
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/7] libperf: Add interface for overflow check of
 sampling events
Message-ID: <YkRgDdI8PKH5C7lV@krava>
References: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 01:38:22PM +0900, Shunsuke Nakamura wrote:
> This patch series adds interface for overflow check of sampling events
> to libperf.
> 
> First patch fixes a typo in the error message that I noticed.
> 
> Second patch move 'open_flags' from tools/perf to evsel::open_flags.
> 
> Third patch adds a interface to perform IOC_REFRESH and IOC_PERIOD.
> 
> Fourth patch introduce perf_{evsel, evlist}__open_opt() with extensible
> structure opts.
> 
> Fifth patch adds a interface to check overflowed events.
> 
> Sixth and seventh patch adds tests.
> 
> ---
> Previous version at:
> https://lore.kernel.org/linux-perf-users/20220225103114.144239-1-nakamura.shun@fujitsu.com/
> 
> Changes in v2:
>  - Delete perf_evsel__set_close_on_exec() function
>  - Introduce perf_{evsel, evlist}__open_opt() with extensible structure
>    opts
>  - Fix perf_evsel__set_signal() to a internal function
>  - Add bool type argument to perf_evsel__check_{fd, fd_cpu}() to indicate
>    overflow results

looks good.. it got more clear to me, sending some comments


> 
> 
> Shunsuke Nakamura (7):
>   libperf tests: Fix typo in the error message
>   libperf: Move 'open_flags' from tools/perf to evsel::open_flags
>   libperf: Add perf_evsel__{refresh, period}() functions
>   libperf: Introduce perf_{evsel, evlist}__open_opt with extensible
>     struct opts
>   libperf: Add perf_evsel__check_overflow() functions
>   libperf test: Add test_stat_overflow()
>   libperf test: Add test_stat_overflow_event()

I'm getting:

[root@krava perf]# make tests
running static:
- running tests/test-cpumap.c...OK
- running tests/test-threadmap.c...OK
- running tests/test-evlist.c...OK
- running tests/test-evsel.c...FAILED tests/test-evsel.c:286 failed to overflow count
FAILED tests/test-evsel.c:286 failed to overflow count
  FAILED (2)
FAILED tests/main.c:13 test evsel
make: *** [Makefile:162: tests] Error 255

thanks,
jirka

> 
>  tools/lib/perf/Documentation/libperf.txt |  22 +++
>  tools/lib/perf/evlist.c                  |  20 +++
>  tools/lib/perf/evsel.c                   | 210 ++++++++++++++++++++++-
>  tools/lib/perf/include/internal/evsel.h  |   2 +
>  tools/lib/perf/include/perf/evlist.h     |   3 +
>  tools/lib/perf/include/perf/evsel.h      |  35 ++++
>  tools/lib/perf/internal.h                |  44 +++++
>  tools/lib/perf/libperf.map               |   8 +
>  tools/lib/perf/tests/test-evlist.c       | 135 ++++++++++++++-
>  tools/lib/perf/tests/test-evsel.c        | 111 ++++++++++++
>  tools/perf/util/evsel.c                  |  16 +-
>  tools/perf/util/evsel.h                  |   1 -
>  12 files changed, 588 insertions(+), 19 deletions(-)
> 
> -- 
> 2.25.1
> 
