Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5CF591C36
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 20:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbiHMSKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 14:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240063AbiHMSK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 14:10:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD70BC4;
        Sat, 13 Aug 2022 11:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4A6EB80AC1;
        Sat, 13 Aug 2022 18:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BC3C433C1;
        Sat, 13 Aug 2022 18:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660414221;
        bh=1ap23fJJCwbBtktINfroSywC6QnbkAUw+hSg8nGuA1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/wYiFSuk/s2gnhQEgG378SJMon0CZGzwUs4695XhAgbY48o+1/8zV6q0vwhjMmsj
         e4Yy69kY4RMJlY/4fdo3RMYh6MlepihfruC3ugVSVZyCq33uwVe7COaZqMeAyOYOoI
         7TE2LtEtEOPfAv/xWvgNd2NL4Z7uwxKPPe1LhzQN8iOQmnZ84sMsM8+a3ozdPS+lk0
         kuPbMtbhL5vCmrnSHgbS01hUChKNQ8JokbTwAXAmVLz9TbnMHFU5f5uYL7voo8erM5
         0i2Z+4RlSwj0c27XUuHjPwrDVMY9Wg1N9lWA8FlmnY8m6SIPmoeAZwz9chUVoSlrdm
         f7dXLPG3SlJZw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D3F274035A; Sat, 13 Aug 2022 15:10:18 -0300 (-03)
Date:   Sat, 13 Aug 2022 15:10:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     carsten.haitzler@foss.arm.com, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 00/14] perf: test: Add trace data quality tests for
 CoreSight
Message-ID: <YvfpCnZ30tKFBfG+@kernel.org>
References: <20220812121641.336465-1-carsten.haitzler@foss.arm.com>
 <Yvaj2ukXV+SLIBR0@kernel.org>
 <20220813141739.GB687527@leoy-huanghe.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220813141739.GB687527@leoy-huanghe.lan>
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

Em Sat, Aug 13, 2022 at 10:17:39PM +0800, Leo Yan escreveu:
> On Fri, Aug 12, 2022 at 04:02:50PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Aug 12, 2022 at 01:16:27PM +0100, carsten.haitzler@foss.arm.com escreveu:
> > > From: Carsten Haitzler <carsten.haitzler@arm.com>
> > > 
> > > This is a prelude to adding more tests to shell tests and in order to
> > > support putting those tests into subdirectories, I need to change the
> > > test code that scans/finds and runs them.
> > > 
> > > To support subdirs I have to recurse so it's time to refactor the code to
> > > allow this and centralize the shell script finding into one location and
> > > only one single scan that builds a list of all the found tests in memory
> > > instead of it being duplicated in 3 places.
> > > 
> > > This code also optimizes things like knowing the max width of desciption
> > > strings (as we can do that while we scan instead of a whole new pass
> > > of opening files). It also more cleanly filters scripts to see only
> > > *.sh files thus skipping random other files in directories like *~
> > > backup files, other random junk/data files that may appear and the
> > > scripts must be executable to make the cut (this ensures the script
> > > lib dir is not seen as scripts to run). This avoids perf test running
> > > previous older versions of test scripts that are editor backup files
> > > as well as skipping perf.data files that may appear and so on.
> > > 
> > > Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> > 
> > Leo, can you please check if your previous Reviewed-by tags stand for
> > this new version?
> 
> Yeah, after applied this patch series on the repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git, branch perf/core;
> it has merging conflict for the patch 03 "perf test: Add build infra for perf
> test tools for CoreSight tests".  It's good to rebase this patch set on the
> latest perf/core branch.
> 
> I compared patch set v5 and v7, confirmed the my comments have been addressed
> in v7.  Carsten also has updated patches' author address, it is same with the
> address used in SoB, this is the right thing to do (Sorry I missed that).
> 
> I tested this patch set on my Juno board and observed a regression related with
> CTI driver, the regression is not relevant with this patch set, I have
> reported it on CoreSight mailing list.  This will be investigated separatly.
> 
> When played these test cases, I observed a failure for below case; but when I
> re-run the case again and it passed.
> 
>   # ./perf test -v 78
>    78: CoreSight / Thread Loop 10 Threads - Check TID                  :
>   --- start ---
>   test child forked, pid 6233
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.380 MB ./perf-thread_loop-check-tid-10th.data ]
>   Thread IDs  6242 6242 6242 6242 6242 6242 6242 6242 not found in perf AUX data
>   test child finished with -1
>   ---- end ----
>   CoreSight / Thread Loop 10 Threads - Check TID: FAILED!
> 
> You could see the perf data file is abnormally small (0.380 MiB), it should be
> an issue for perf cs-etm record.  I don't think this is an issue for the test
> case itself, we need to look at this issue later.
> 
> So with fixing the merging conflict:
> 
> Tested-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

  [PATCH v7 14/14] perf test: Add relevant documentation about CoreSight testing
    + Tested-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
    + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
---
Total patches: 14
---
NOTE: some trailers ignored due to from/email mismatches:
    ! Trailer: Link: https://lore.kernel.org/r/20220728145256.2985298-1-carsten.haitzler@foss.arm.com
     Msg From: Arnaldo Carvalho de Melo <acme@kernel.org>
NOTE: Rerun with -S to apply them anyway
---
Cover: ./v7_20220812_carsten_haitzler_perf_test_add_trace_data_quality_tests_for_coresight.cover
 Link: https://lore.kernel.org/r/20220812121641.336465-1-carsten.haitzler@foss.arm.com
 Base: not specified
       git am ./v7_20220812_carsten_haitzler_perf_test_add_trace_data_quality_tests_for_coresight.mbx
⬢[acme@toolbox perf]$        git am ./v7_20220812_carsten_haitzler_perf_test_add_trace_data_quality_tests_for_coresight.mbx
Applying: perf test: Refactor shell tests allowing subdirs
.git/rebase-apply/patch:56: trailing whitespace.
/*
warning: 1 line adds whitespace errors.
tools/perf/tests/builtin-test-list.c:29: trailing whitespace.
+/*
⬢[acme@toolbox perf]$


Fixing... 

- Arnaldo
