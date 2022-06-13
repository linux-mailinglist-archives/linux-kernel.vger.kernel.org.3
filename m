Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DFB549F35
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbiFMUdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiFMUc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:32:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF014EDFF;
        Mon, 13 Jun 2022 12:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9650E614E5;
        Mon, 13 Jun 2022 19:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBD9C34114;
        Mon, 13 Jun 2022 19:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655148188;
        bh=cGzgiVX76UAAcfqHUrWTEeILPgaF7+NxwFD2qiA9Byo=;
        h=From:To:Cc:Subject:Date:From;
        b=M3+DSZd3q4NeDzubpoFEG0LRXr4LEMK8+jIuQc1ahEyKx3LS7iN2w3FKSzfDbsuBo
         RGWEMWpXAAFKuTFdBbOJa3habBZZC1/2vqfzBOD/ld/Nj2dNHh4LAD0yyIERLatlx8
         yU+4qH1HR9s2Li/YZZkoLJTMtKBdXEYUjChhkb0eNQNLAwuRib6fWuDoArwgG3ljwH
         wdfCIyZp7ImmJFIybNZMyOGvA1j8CQq5IwSoM6hMFQeeGC7xzVIrc9yOANLdfBHNs+
         iShclX1F6W/e8LcoO5TN/+oGey2QstGn25+cxmaxpi3MB9+VK/LsACQ4AnHvNCbqpN
         696xYDsh2ackg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Extend DAMOS for Proactive LRU-lists Sorting
Date:   Mon, 13 Jun 2022 19:22:52 +0000
Message-Id: <20220613192301.8817-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from RFC
================

Compared to the RFC
(https://lore.kernel.org/damon/20220513150000.25797-1-sj@kernel.org/), this
version of the patchset contains below changes.

- Use more self-explaining DAMOS action names
- Put more evaluation results
- Introduce a static kernel module for easy use of conservatively-tuned
  DAMON-based proactive LRU-lists sorting

Introduction
============

In short, this patchset 1) extends DAMON-based Operation Schemes (DAMOS) for
low overhead data access pattern based LRU-lists sorting, and 2) implements a
static kernel module for easy use of conservatively-tuned version of that using
the extended DAMOS capability.

Background
----------

As page-granularity access checking overhead could be significant on huge
systems, LRU lists are normally not proactively sorted but partially and
reactively sorted for special events including specific user requests, system
calls and memory pressure.  As a result, LRU lists are sometimes not so
perfectly prepared to be used as a trustworthy access pattern source for some
situations including reclamation target pages selection under sudden memory
pressure.

DAMON-based Proactive LRU-lists Sorting
---------------------------------------

Because DAMON can identify access patterns of best-effort accuracy while
inducing only user-specified range of overhead, using DAMON for Proactive
LRU-lists Sorting (PLRUS) could be helpful for this situation.  The idea is
quite simple.  Find hot pages and cold pages using DAMON, and prioritize hot
pages while deprioritizing cold pages on their LRU-lists.

This patchset extends DAMON to support such schemes by introducing a couple of
new DAMOS actions for prioritizing and deprioritizing memory regions of
specific access patterns on their LRU-lists.  In detail, this patchset simply
uses 'mark_page_accessed()' and 'deactivate_page()' functions for
prioritization and deprioritization of pages on their LRU lists, respectively.

To make the scheme easy to use without complex tuning for common situations,
this patchset further implements a static kernel module called 'DAMON_LRU_SORT'
using the extended DAMOS functionality.  It proactively sorts LRU-lists using
DAMON with conservatively chosen default hotness/coldness thresholds and small
CPU usage quota limit.  That is, the module under its default parameters will
make no harm for common situation but provide some level of benefit for systems
having clear hot/cold access pattern under only memory pressure while consuming
only limited small portion of CPU time.

Related Works
-------------

Proactive reclamation is well known to be helpful for reducing non-optimal
reclamation target selection caused performance drops.  However, proactive
reclamation is not a best option for some cases, because it could incur
additional I/O.  For an example, it could be prohitive for systems using
storage devices that total number of writes is limited, or cloud block storages
that charges every I/O.

Some proactive reclamation approaches[1,2] induce a level of memory pressure
using memcg files or swappiness while monitoring PSI.  As reclamation target
selection is still relying on the original LRU-lists mechanism, using
DAMON-based proactive reclamation before inducing the proactive reclamation
could allow more memory saving with same level of performance overhead, or less
performance overhead with same level of memory saving.

[1] https://blogs.oracle.com/linux/post/anticipating-your-memory-needs
[2] https://www.pdl.cmu.edu/ftp/NVM/tmo_asplos22.pdf

Evaluation
==========

In short, PLRUS achieves 10% memory PSI (some) reduction, 14% major page faults
reduction, and 3.74% speedup under memory pressure.

Setup
-----

To show the effect of PLRUS, I run PARSEC3 and SPLASH-2X benchmarks under below
variant systems and measure a few metrics including the runtime of each
workload, number of system-wide major page faults, and system-wide memory PSI
(some).

- orig: v5.18-rc4 based mm-unstable kernel + this patchset, but no DAMON scheme
        applied.
- mprs: Same to 'orig' but artificial memory pressure is induced.
- plrus: Same to 'mprs' but a radically tuned PLRUS scheme is applied to the
         entire physical address space of the system.

For the artificial memory pressure, I set 'memory.limit_in_bytes' to 75% of the
running workload's peak RSS, wait 1 second, remove the pressure by setting it
to 200% of the peak RSS, wait 10 seconds, and repeat the procedure until the
workload finishes[1].  I use zram based swap device.  The tests are
automated[2].

[1] https://github.com/awslabs/damon-tests/blob/next/perf/runners/back/0009_memcg_pressure.sh
[2] https://github.com/awslabs/damon-tests/blob/next/perf/full_once_config.sh

Radically Tuned PLRUS
---------------------

To show effect of PLRUS on the PARSEC3/SPLASH-2X workloads which runs for no
long time, we use radically tuned version of PLRUS.  The version asks DAMON to
do the proactive LRU-lists sorting as below.

1. Find any memory regions shown some accesses (approximately >=20 accesses per
   100 sampling) and prioritize pages of the regions on their LRU lists using
   up to 2% CPU time.  Under the CPU time limit, prioritize regions having
   higher access frequency and kept the access frequency longer first.

2. Find any memory regions shown no access for at least >=5 seconds and
   deprioritize pages of the rgions on their LRU lists using up to 2% CPU time.
   Under the CPU time limit, deprioritize regions that not accessed for longer
   time first.

Results
-------

I repeat the tests 25 times and calculate average of the measured numbers.  The
results are as below:

    metric               orig        mprs         plrus        plrus/mprs
    runtime_seconds      190.06      292.83       281.87       0.96
    pgmajfaults          852.55      8769420.00   7525040.00   0.86
    memory_psi_some_us   106911.00   6943420.00   6220920.00   0.90

The first row is for legend.  The first cell shows the metric that the
following cells of the row shows.  Second, third, and fourth cells show the
metrics under the configs shown at the first row of the cell, and the fifth
cell shows the metric under 'plrus' divided by the metric under 'mprs'.  Second
row shows the averaged runtime of the workloads in seconds.  Third row shows
the number of system-wide major page faults while the test was ongoing.  Fourth
row shows the system-wide memory pressure stall for some processes in
microseconds while the test was ongoing.

In short, PLRUS achieves 10% memory PSI (some) reduction, 14% major page faults
reduction, and 3.74% speedup under memory pressure.  We also confirmed the CPU
usage of kdamond was 2.61% of single CPU, which is below 4% as expected.

Sequence of Patches
===================

The first and second patch cleans up DAMON debugfs interface and DAMOS_PAGEOUT
handling code of physical address space monitoring operations implementation
for easier extension of the code.

The thrid and fourth patches implement a new DAMOS action called 'lru_prio',
which prioritizes pages under memory regions which have a user-specified access
pattern, and document it, respectively.  The fifth and sixth patches implement
yet another new DAMOS action called 'lru_deprio', which deprioritizes pages
under memory regions which have a user-specified access pattern, and document
it, respectively.

The seventh patch implements a static kernel module called 'damon_lru_sort',
which utilizes the DAMON-based proactive LRU-lists sorting under conservatively
chosen default parameter.  Finally, the eighth patch documents
'damon_lru_sort'.

SeongJae Park (8):
  mm/damon/dbgfs: add and use mappings between 'schemes' action inputs
    and 'damos_action' values
  mm/damon/paddr: use a separate function for 'DAMOS_PAGEOUT' handling
  mm/damon/schemes: add 'LRU_PRIO' DAMOS action
  Docs/admin-guide/damon/sysfs: document 'LRU_PRIO' scheme action
  mm/damon/schemes: add 'LRU_DEPRIO' action
  Docs/admin-guide/damon/sysfs: document 'LRU_DEPRIO' scheme action
  mm/damon: introduce DAMON-based LRU-lists Sorting
  Docs/admin-guide/damon: add a document for DAMON_LRU_SORT

 Documentation/admin-guide/mm/damon/index.rst  |   1 +
 .../admin-guide/mm/damon/lru_sort.rst         | 294 ++++++++++
 Documentation/admin-guide/mm/damon/usage.rst  |   2 +
 include/linux/damon.h                         |   4 +
 mm/damon/Kconfig                              |   8 +
 mm/damon/Makefile                             |   1 +
 mm/damon/dbgfs.c                              |  64 +-
 mm/damon/lru_sort.c                           | 546 ++++++++++++++++++
 mm/damon/ops-common.c                         |  42 ++
 mm/damon/ops-common.h                         |   2 +
 mm/damon/paddr.c                              |  60 +-
 mm/damon/sysfs.c                              |   2 +
 12 files changed, 1006 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/damon/lru_sort.rst
 create mode 100644 mm/damon/lru_sort.c

-- 
2.25.1

