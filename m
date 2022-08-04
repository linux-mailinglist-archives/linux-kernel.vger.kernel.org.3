Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927D258959F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 03:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbiHDBWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 21:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiHDBWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 21:22:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F29C422DA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 18:22:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so4007808pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 18:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qmHsy1Q+Qy+99H5+YhBfxvmg0PPmS0+X89adjUkkWlw=;
        b=egbM4EiiUdEHQLRS/2yKD3DZ4MP6J9Mk1CGfB35ObRvvaaY6IXA66MG5k8Qo55AoFs
         ctp2C1vQhACDvBI2UdPJIsPWnHsfa6snU+TpTRTXpUawVLctXjdsvlVZtyyKeMNMTomD
         2QqWB7Z4P0NKlmmKTl9t/ucTIMsYOnM7pxLC0w9ze8hlBAO4kBRZCLYHw2xMHU9v8WqL
         /XmPuuOXl2hDMKw+VCoysvzcCJw8/gP2/pIYmZLAaqVPxwz4TJzQzzWIaGqKc/OURk1n
         sh9NGRs8rWpVYk8I7sYI4QCFHbDJcfBnkHDH5JS9y43lSKvdtC9zq5/lu5YX3XDrupNv
         jHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qmHsy1Q+Qy+99H5+YhBfxvmg0PPmS0+X89adjUkkWlw=;
        b=Nft8j2fTCnod0N6W0sOzwhVbIqqJ0dnM4XVqch4SGM3DUN9x7pjBg8s2+z4zKe4f/x
         XPH2zg2DuzMsfSGWOdllmOH75LCpCdtXk2j8S1WEBYHC2qfuwLnqxmDweDJ+yNCghEWL
         FCDf7yrmLQzvR/qcmhxDiV91PcI53byOKft4xsJbh5s5vl2kTuI/m1d25vNyJoYr8sQw
         lZUIs05v4C0vHqgmjPwR+/Nxf5xOHmpbNXjz0m7BzNh8je9LOR9OV4ZX8VPrAjiQ8xq5
         AsOxe63J469GF1bi6IeKYK1KiKmyCOqs0gV2CV5o4X1k+kEvb0XRkSJVMJQ0TvXrzb0j
         0cCA==
X-Gm-Message-State: ACgBeo0Hk2OjJm7F7eX0GFl/3pRvGnzE5+5qTpmbVfqmJBzOM7TR/4Rw
        VMs1g7znN5arwRFlvovNYrGXeA==
X-Google-Smtp-Source: AA6agR7fBYO45a1xSzVN0avfLorSv9B0IgodrJtibOF42oGgzMcuWlzUebdLrPQfVHJgIGSKVrkbvg==
X-Received: by 2002:a17:903:185:b0:16c:3af7:dbc8 with SMTP id z5-20020a170903018500b0016c3af7dbc8mr28798986plg.147.1659576123297;
        Wed, 03 Aug 2022 18:22:03 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.113.38.16clouds.com. [173.242.113.38])
        by smtp.gmail.com with ESMTPSA id n6-20020a170903110600b0016f09d217c1sm2685227plh.281.2022.08.03.18.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 18:22:02 -0700 (PDT)
Date:   Thu, 4 Aug 2022 09:21:58 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf symbol: Fail to read phdr workaround
Message-ID: <20220804012158.GC133193@leoy-ThinkPad-X240s>
References: <20220731164923.691193-1-irogers@google.com>
 <20220801015259.GA101027@leoy-ThinkPad-X240s>
 <CAP-5=fVSjCQ4jeAeyP5THnQVyXDpKd6Ob33C7PDwFB_6+YSXuw@mail.gmail.com>
 <YufJP5YqeEBM51HL@kernel.org>
 <20220803152527.GA133193@leoy-ThinkPad-X240s>
 <CAP-5=fX1B9qv1kPLfRx59kgeEwNOzFVnaNm34YiLFpc3JMTQpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fX1B9qv1kPLfRx59kgeEwNOzFVnaNm34YiLFpc3JMTQpA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 05:26:39PM -0700, Ian Rogers wrote:

[...]

> > The question is how we can specify the path for the lib
> > libperf-jvmti.so in the testing script?
> >
> > If we can run the test case from the root folder of Linux kernel
> > source code, the lib libperf-jvmti.so can be found in the folder
> > $linux/tools/perf, but for the integration testing the lib should be
> > placed in an installed folder.  Any suggestion if we have exited
> > way to specify the path for libperf-jvmti.so, or need to introduce a
> > new shell envorinment variable for the lib path?
> 
> There is a hack in 'perf test' where we assume a few paths to tests:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/tests/builtin-test.c?h=perf/core#n308
> so in this case we could look in the same directory. There is also a
> #define for PERF_EXEC_PATH.

Thanks for the info.  I will try to search paths like the buildin-test.c
file, and the lib libperf-jvmti.so is installed in the folder
"$HOME/lib64/", I will check if can reuse PERF_EXEC_PATH for this
case.

> I'd prefer it if the test could be self contained for example:
> 
> echo "int fib(int x) { return x > 1 ? fib(x - 2) + fib(x - 1) : 1; }
> int q = 0; for(int i=0; i < 10; i++) q += fib(i);
> System.out.println(q);" | /tmp/perf/perf record -k 1 jshell
> -J-agentpath:/tmp/perf/libperf-jvmti.so
> 
> where jshell runs on the JVM and so we should get some jitted execution time.

Will do.  Appreciate for sharing this!

Leo
