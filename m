Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96C9526589
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381675AbiEMPBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381873AbiEMPBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:01:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0BF41FA1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:00:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B45F0B83029
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E07C34100;
        Fri, 13 May 2022 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652454030;
        bh=5vC3vzYpZTxhXWTpgV66fIf/Eo66LEeoiwACiNeyYM8=;
        h=From:To:Cc:Subject:Date:From;
        b=Ibj3izuUayhSGrfOeEFi9XH+UAERxoJH+qW1q/XpZ9x3i0FQ5CyQGpCEbpy4BGVuC
         t6KXoD9jPnQDinTGdsem8j3aFRZZ5XECLlX7qgjBlfx6isDUl9ET/mUl5yj/bbI3co
         XzpfAq/MDtmnHkcxOfRK4Y/4IoXVH7n56kAsrlG3cnqLtHm6KUjHCPsDiQpCCWZ7+0
         W9OFYnrOxQz8Qw7SM+++Bj1ncExNBRXOBQIsAmGiKG/95zW6w1I0lyUR07TLQJuYyU
         q0/P5B7kcRHLRe+KzxExWS8PGd5sc8DyPOUBrN0MfrcBhiRUDQN4VIqQPzbYtW7Eke
         UJsDUELpeOPTw==
From:   SeongJae Park <sj@kernel.org>
Cc:     linux-damon@amazon.com, damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [RFC PATCH 0/3] mm/damon/schemes: Extend DAMOS for Proactive LRU-lists Sorting
Date:   Fri, 13 May 2022 16:59:57 +0200
Message-Id: <20220513150000.25797-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Introduction
============

As page-granularity access checking overhead could be too significant on huge
systems, LRU lists are normally sorted reactively and partially for special
events including explicit system calls and memory pressure.  As a result, LRU
lists could be not well sorted to be used for finding good reclamation target
pages, especially when memory pressure is first happened after a while.

Proactive reclamation is well known to be helpful for minimizing the memory
pressure performance drops.  However, proactive reclamation could incur
additional I/O, so not a best option for some cases.  For an example, cloud
block storages would charge each I/O.

Using DAMON for Proactive LRU-lists Sorting (PLRUS) could be helpful for this
situation, as DAMON can identify access patterns while inducing only controlled
overhead.  The idea is simple.  Find hot pages and cold pages using DAMON, and
do 'mark_page_accessed()' for the hot pages while doing 'deactivate_page()' for
the cold pages.  This patchset extends DAMON to support PLRUS by introducing a
new DAMOS action for doing the 'mark_page_accessed()' to memory regions of a
specific access pattern, and supporting 'cold' DAMOS action from the physical
address space monitoring operations set.

In terms of making reclamation less harmful, PLRUS will work similar to the
proactive reclamation, but avoids the additional I/Os.  Of course, PLRUS will
not reduce memory utilization on its own, unlike proactive reclamation.  If
that's a problem, doing DAMON-based proactive reclamation (DAMON_RECLAIM)
simultaneously for only super cold pages, or for severe memory pressure could
work.  One additional advantage of PLRUS is that it makes LRU lists a more
trustworthy source of access patterns.

Example DAMON-based Operation Schemes for PLRUS
===============================================

So, users will be able to do PLRUS via DAMON-based Operation Schemes (DAMOS)
after applying this patchset.  An example of such DAMOS config for PLRUS would
be something like below.  Sorry for the crippy format.  Please refer to the
parser script[1] for detail of the format.  In short, this config asks DAMON to

1. find any memory regions of >=4K size having shown at least some access
   (approximately 20 accesses per 100 sampling) and apply 'mark_accessed()' to
   those using up to 2% CPU time.  Under the CPU time limit, apply the function
   to regions having higher access frequency and kept the access frequency
   longer first.

2. find any memory regions of >=4K size having shown no access for 200ms or
   more and 'deactivate()' those using up to 2% CPU time.  Under the CPU time
   limit, apply the function to regions kept the no access longer first.

    # format is:
    # <min/max size> <min/max frequency (0-100)> <min/max age> <action> \
    # 		<quota> <weights> <watermarks>
 
    # LRU-activate hot pages (more hot ones first) under 2% CPU usage limit
    4K  max         20 max           min max         hot \
    		20ms 0B 1s      0 7 3   free_mem_rate 5s 1000 999 0
 
    # LRU-deactivate cold pages (colder ones first) under 2% CPU usage limit
    4K  max         min min         20ms max         cold \
    		20ms 0B 1s      0 3 7   free_mem_rate 5s 1000 999 0

[1] https://github.com/awslabs/damo/blob/next/_convert_damos.py

Evaluation
==========

To show the effect of PLRUS, I ran PARSEC3 and SPLASH-2X benchmarks under below
variant kernels and measured the runtime of each workload.

- orig: Latest mm-unstable kernel + this patchset, but no DAMON scheme applied.
- mprs: Same to orig but have artificial memory pressure.
- plrus: Same to mprs but above example PLRUS scheme is applied to the physical
         address space of the system.

For the artificial memory pressure, I set memory.limit_in_bytes to 75% of the
running workload's peak RSS, wait 3 seconds, remove the pressure by setting it
to 200% of the running workload's peak RSS, wait 30 seconds, and repeat the
procedure until the workload finishes[1].  I use zram based swap device.  The
tests are automated[2].

I repeat the tests five times and calculate average runtime of the five
measurements.  The results are as below:

    runtime_secs            orig    mprs    plrus   plrus/mprs
    parsec3/blackscholes    139.35  139.68  140.37  1.00
    parsec3/bodytrack       124.67  127.26  128.31  1.01
    parsec3/canneal         207.61  400.95  355.23  0.89
    parsec3/dedup           18.30   18.84   19.30   1.02
    parsec3/facesim         350.42  353.69  349.14  0.99
    parsec3/fluidanimate    338.57  337.16  342.18  1.01
    parsec3/freqmine        434.39  435.67  436.49  1.00
    parsec3/raytrace        182.24  186.18  189.08  1.02
    parsec3/streamcluster   634.49  2993.27 2576.04 0.86
    parsec3/swaptions       221.68  221.84  221.97  1.00
    parsec3/vips            87.82   103.01  103.18  1.00
    parsec3/x264            108.92  132.82  128.22  0.97
    splash2x/barnes         130.30  135.87  138.52  1.02
    splash2x/fft            62.09   98.33   99.85   1.02
    splash2x/lu_cb          132.15  135.49  135.22  1.00
    splash2x/lu_ncb         149.89  154.92  155.26  1.00
    splash2x/ocean_cp       80.04   108.20  113.85  1.05
    splash2x/ocean_ncp      163.70  217.40  231.09  1.06
    splash2x/radiosity      142.32  143.13  144.50  1.01
    splash2x/radix          50.28   78.21   85.96   1.10
    splash2x/raytrace       133.75  134.21  136.21  1.01
    splash2x/volrend        120.39  121.72  120.87  0.99
    splash2x/water_nsquared 373.37  388.31  398.72  1.03
    splash2x/water_spatial  133.81  143.73  144.00  1.00
    total                   4520.54 7309.87 6893.55 0.94
    average                 188.36  304.58  287.23  0.94

The second, third, and fourth cells shows the runtime of each workload under
the configs in seconds, and the fifth cell shows the plrus runtime divided by
mprs runtime.

On average, 'plrus' achieves about 6% speedup under memory pressure.  For the
two best cases (parsec3/canneal and parsec3/streamcluster), 'plrus' achieves
about 11% and 14% speedup under memory pressure.  Please note that the scheme
is not tuned for each workload, applied to entire system memory, and uses only
up to 4% single CPU time.

[1] https://github.com/awslabs/damon-tests/blob/next/perf/runners/back/0009_memcg_pressure.sh
[2] https://github.com/awslabs/damon-tests/tree/next/perf

Sequence of Patches
===================

The first patch cleans up DAMOS_PAGEOUT handling code of physical address space
monitoring operations implementation for easier extension of the code.  The
second patch implements a new DAMOS action called 'hot', which applies
'mark_page_accessed()' to the pages under the memory regions having the target
access pattern.  Finally, the third patch makes the physical address space
monitoring operations implementation supports the 'cold' action, which applies
'deactivate_page()' to the pages under the memory regions having the target
access pattern.

SeongJae Park (3):
  mm/damon/paddr: move DAMOS_PAGEOUT handling to a separate function
  mm/damon/schemes: Support 'hot' action
  mm/damon/paddr: Support DAMOS_COLD

 include/linux/damon.h |  2 ++
 mm/damon/ops-common.c | 42 ++++++++++++++++++++++++++++++
 mm/damon/ops-common.h |  2 ++
 mm/damon/paddr.c      | 60 ++++++++++++++++++++++++++++++++++++++-----
 mm/damon/sysfs.c      |  1 +
 5 files changed, 101 insertions(+), 6 deletions(-)

-- 
2.17.1

