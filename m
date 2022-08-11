Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F15590430
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbiHKQfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238732AbiHKQdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:33:19 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB509C511
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:10:59 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s9so19790219ljs.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WadkdhIBGjyW48KVPQS6VOJJuHOgD7hkCQHU3CrW5r4=;
        b=C3xCsbJZiYMmFeHCimrB0ZWTrddOEX+yAAsE4dxCE9yo0bLODW7wRrPXo30JVEOom5
         lZNHHqS9Q9ZZ669V5YZig1BRGrMPtMWWBG/QlFeCS/lJtKLT0apW87uqtOtVWkOkY4Qs
         WmeqEqf0E1gwcAUa9HPdI/7tIXjdRDf1iNeBWrLwjPTPjzDbIrOzzECQFjQ4RbzKs6Qh
         zxSvxiLroFNglqXDtciMH1rPnme3UJxqWowBe/vLiHBv7564PAdavmXdSnKgG4wmLmnQ
         gXezuPik4TtYzLWaEZwNHJ+kdFBdTq+8rJciBrJYcoQnTCtygDRGanwmf8HwMjtZDpQ1
         O1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WadkdhIBGjyW48KVPQS6VOJJuHOgD7hkCQHU3CrW5r4=;
        b=NYEYrYZ25TuzsowSthHwZbigNIHF0RzMHMX8LrMsZ9VZ8zXbw7KxaXT3ZOBwSAvGJM
         cAEaJWFYJJAdWNLtkGm9p2oR5bzggdtAiDhfZMc7dvJUY5XujVGFwddL/7aHLdN1W+XC
         jcVDslaJFOlk5Ahxr4TdGzagXpBDvSzpFfxUnoUEs6+J9f6YNrB8jUd1QosRnYaRaO7t
         rPVvdObzPCDUB+eV5mb5BotJI1DaIyCxC95HMLy/PAs+GFJW9hTjp7ulW0uYMpkXqa4O
         5NlB15/CiavLddX1gCcgfiw5TK6lGy7IMs3/asuZYi0oLSNt+J8s7SUVQ2l4rJnfueWP
         LUlw==
X-Gm-Message-State: ACgBeo2Y1dnJe0ODw5i2KoSfg8YnTiEJ0WsDnqQGJ/zngSB8dAkq1Ta+
        09iXWReOppFsaykGW2jwMiLL3tIvKPkHpOCmKe8ZbFbjnwpNuQ==
X-Google-Smtp-Source: AA6agR74xNZCd6uAl/bb54mBPt8npYozN6IsBpDIaMgTRAEyfH6PecKixBxiPmO3DJQF+NYupvkuQvAHxJ/MOHbC5PU=
X-Received: by 2002:a05:651c:881:b0:25d:4865:f6b0 with SMTP id
 d1-20020a05651c088100b0025d4865f6b0mr9904673ljq.418.1660234257438; Thu, 11
 Aug 2022 09:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
In-Reply-To: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 11 Aug 2022 17:10:46 +0100
Message-ID: <CAJ9a7VhV3mXr4pGi2UZYkfCZzB6=trnE_U8vKytupWXB00cCCw@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] A patch series improving data quality of perf
 test for CoreSight
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carsten,

Been running the tests on my Dragonboard DB410 and see the following:-

1) for every test I get a warning of the form:-
[ 4167.796633] cma: cma_alloc: reserved: alloc failed, req-size: 4096
pages, ret: -12
meaning the initial allocation for teh perf buffer has failed.
is the allocation size for the perf buffer mmap fixed or can it be set
for the individual target?
Not sure if this is a worry - as far as I recall, if the ETR driver
cannot set a buffer size it reduces till it can.

2) A couple of the TID tests fail in my case, but the interesting
output I get if I use -v is=>


 77: CoreSight / Thread Loop 10 Threads - Check TID                  :
--- start ---
test child forked, pid 4646
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.005 MB
./perf-thread_loop-check-tid-10th.data ]
Warning:
Please install libunwind or libdw development packages during the perf build.
Warning:
AUX data lost 2 times out of 2!

Thread IDs  4662 4662 4662 4662 4662 4662 4662 4662 not found in perf AUX data
test child finished with -1
---- end ----
CoreSight / Thread Loop 10 Threads - Check TID: FAILED!
 78: CoreSight / Thread Loop 2 Threads - Check TID                   :
--- start ---
test child forked, pid 4693
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.005 MB
./perf-thread_loop-check-tid-2th.data ]
Warning:
Please install libunwind or libdw development packages during the perf build.
Thread IDs  4699 4699 not found in perf AUX data
test child finished with -1
---- end ----

Are we expecting the same TID to be repeated in that way?

Regards

Mike



On Thu, 28 Jul 2022 at 15:53, <carsten.haitzler@foss.arm.com> wrote:
>
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
>
> This is a prelude to adding more tests to shell tests and in order to
> support putting those tests into subdirectories, I need to change the
> test code that scans/finds and runs them.
>
> To support subdirs I have to recurse so it's time to refactor the code to
> allow this and centralize the shell script finding into one location and
> only one single scan that builds a list of all the found tests in memory
> instead of it being duplicated in 3 places.
>
> This code also optimizes things like knowing the max width of desciption
> strings (as we can do that while we scan instead of a whole new pass
> of opening files). It also more cleanly filters scripts to see only
> *.sh files thus skipping random other files in directories like *~
> backup files, other random junk/data files that may appear and the
> scripts must be executable to make the cut (this ensures the script
> lib dir is not seen as scripts to run). This avoids perf test running
> previous older versions of test scripts that are editor backup files
> as well as skipping perf.data files that may appear and so on.
>
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
>
> Carsten Haitzler (Rasterman) (14):
>   perf test: Refactor shell tests allowing subdirs
>   perf test: Add CoreSight shell lib shared code for future tests
>   perf test: Add build infra for perf test tools for CoreSight tests
>   perf test: Add asm pureloop test tool
>   perf test: Add asm pureloop test shell script
>   perf test: Add git ignore for perf data generated by the CoreSight
>     tests
>   perf test: Add memcpy thread test tool
>   perf test: Add memcpy thread test shell script
>   perf test: Add thread loop test tool
>   perf test: Add thread loop test shell scripts
>   perf test: Add unroll thread test tool
>   perf test: Add unroll thread test shell script
>   perf test: Add git ignore for tmp and output files of CoreSight tests
>   perf test: Add relevant documentation about CoreSight testing
>
>  .../trace/coresight/coresight-perf.rst        | 160 ++++++++++++++
>  MAINTAINERS                                   |   1 +
>  tools/perf/.gitignore                         |   6 +-
>  tools/perf/Documentation/arm-coresight.txt    |   5 +
>  tools/perf/Makefile.perf                      |  18 +-
>  tools/perf/tests/Build                        |   1 +
>  tools/perf/tests/builtin-test-list.c          | 207 ++++++++++++++++++
>  tools/perf/tests/builtin-test-list.h          |  12 +
>  tools/perf/tests/builtin-test.c               | 152 ++-----------
>  tools/perf/tests/shell/coresight/Makefile     |  30 +++
>  .../tests/shell/coresight/Makefile.miniconfig |  24 ++
>  .../tests/shell/coresight/asm_pure_loop.sh    |  18 ++
>  .../shell/coresight/asm_pure_loop/.gitignore  |   1 +
>  .../shell/coresight/asm_pure_loop/Makefile    |  34 +++
>  .../coresight/asm_pure_loop/asm_pure_loop.S   |  28 +++
>  .../shell/coresight/memcpy_thread/.gitignore  |   1 +
>  .../shell/coresight/memcpy_thread/Makefile    |  33 +++
>  .../coresight/memcpy_thread/memcpy_thread.c   |  79 +++++++
>  .../shell/coresight/memcpy_thread_16k_10.sh   |  18 ++
>  .../shell/coresight/thread_loop/.gitignore    |   1 +
>  .../shell/coresight/thread_loop/Makefile      |  33 +++
>  .../shell/coresight/thread_loop/thread_loop.c |  86 ++++++++
>  .../coresight/thread_loop_check_tid_10.sh     |  19 ++
>  .../coresight/thread_loop_check_tid_2.sh      |  19 ++
>  .../coresight/unroll_loop_thread/.gitignore   |   1 +
>  .../coresight/unroll_loop_thread/Makefile     |  33 +++
>  .../unroll_loop_thread/unroll_loop_thread.c   |  74 +++++++
>  .../shell/coresight/unroll_loop_thread_10.sh  |  18 ++
>  tools/perf/tests/shell/lib/coresight.sh       | 132 +++++++++++
>  29 files changed, 1105 insertions(+), 139 deletions(-)
>  create mode 100644 Documentation/trace/coresight/coresight-perf.rst
>  create mode 100644 tools/perf/Documentation/arm-coresight.txt
>  create mode 100644 tools/perf/tests/builtin-test-list.c
>  create mode 100644 tools/perf/tests/builtin-test-list.h
>  create mode 100644 tools/perf/tests/shell/coresight/Makefile
>  create mode 100644 tools/perf/tests/shell/coresight/Makefile.miniconfig
>  create mode 100755 tools/perf/tests/shell/coresight/asm_pure_loop.sh
>  create mode 100644 tools/perf/tests/shell/coresight/asm_pure_loop/.gitignore
>  create mode 100644 tools/perf/tests/shell/coresight/asm_pure_loop/Makefile
>  create mode 100644 tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
>  create mode 100644 tools/perf/tests/shell/coresight/memcpy_thread/.gitignore
>  create mode 100644 tools/perf/tests/shell/coresight/memcpy_thread/Makefile
>  create mode 100644 tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
>  create mode 100755 tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
>  create mode 100644 tools/perf/tests/shell/coresight/thread_loop/.gitignore
>  create mode 100644 tools/perf/tests/shell/coresight/thread_loop/Makefile
>  create mode 100644 tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
>  create mode 100755 tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
>  create mode 100755 tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
>  create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore
>  create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile
>  create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
>  create mode 100755 tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
>  create mode 100644 tools/perf/tests/shell/lib/coresight.sh
>
> --
> 2.32.0
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
