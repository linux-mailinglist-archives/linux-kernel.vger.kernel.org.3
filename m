Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A015915C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbiHLTC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiHLTC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:02:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9780A2E7;
        Fri, 12 Aug 2022 12:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B023B82532;
        Fri, 12 Aug 2022 19:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1C7C433D6;
        Fri, 12 Aug 2022 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660330973;
        bh=MFK5pQXQAeFIYVQLPuNMr/kHAjpScCwzUYnAX6y1KHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ndnmwBh/iSJtROTMRlvmxthd0lkRV7s0BHBl9gElmDzMPEhz7iPhRcG+Rbuagb+Zu
         PQMdG2/i4hEsz64twY0DneGiUnXamiSiB9mQCtA80wPpCRFfttRzEQnGHObCIajsGf
         3jICwJM9X2rTECKcsu0xiDla5T0A55hvbkAcCQv/0bOmA6KCv2uU4pKLZEqkmWpLil
         LRcQ9JcR0qQnI9pSK1VKZaD7Rr2lwhb/y7jqKmKWzQZpPuVaqqKybE6oi7nWAySSGx
         z8lW5P9c8PSHM+J0QMguugicnyzDaQLfsRV5kT+UKeGtgVhGIdPGPrlC3wXLQEFxDg
         be3OlWnxpyfCQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CAF584035A; Fri, 12 Aug 2022 16:02:50 -0300 (-03)
Date:   Fri, 12 Aug 2022 16:02:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>, carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 00/14] perf: test: Add trace data quality tests for
 CoreSight
Message-ID: <Yvaj2ukXV+SLIBR0@kernel.org>
References: <20220812121641.336465-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812121641.336465-1-carsten.haitzler@foss.arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 12, 2022 at 01:16:27PM +0100, carsten.haitzler@foss.arm.com escreveu:
> From: Carsten Haitzler <carsten.haitzler@arm.com>
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

Leo, can you please check if your previous Reviewed-by tags stand for
this new version?

Thanks,

- Arnaldo
 
> 
> Carsten Haitzler (14):
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
>  .../trace/coresight/coresight-perf.rst        | 158 +++++++++++++
>  MAINTAINERS                                   |   1 +
>  tools/perf/.gitignore                         |   6 +-
>  .../perf/Documentation/perf-arm-coresight.txt |   5 +
>  tools/perf/Makefile.config                    |   2 +
>  tools/perf/Makefile.perf                      |  17 +-
>  tools/perf/tests/Build                        |   1 +
>  tools/perf/tests/builtin-test-list.c          | 207 ++++++++++++++++++
>  tools/perf/tests/builtin-test-list.h          |  12 +
>  tools/perf/tests/builtin-test.c               | 152 ++-----------
>  tools/perf/tests/shell/coresight/Makefile     |  30 +++
>  .../tests/shell/coresight/Makefile.miniconfig |  14 ++
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
>  30 files changed, 1094 insertions(+), 139 deletions(-)
>  create mode 100644 Documentation/trace/coresight/coresight-perf.rst
>  create mode 100644 tools/perf/Documentation/perf-arm-coresight.txt
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

-- 

- Arnaldo
