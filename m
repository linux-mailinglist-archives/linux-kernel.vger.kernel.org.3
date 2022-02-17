Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906044BA598
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241381AbiBQQUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:20:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiBQQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:20:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0FE27019C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:19:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9129B8068E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 16:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B78BC340E8;
        Thu, 17 Feb 2022 16:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645114785;
        bh=xRpSRW/NxZIB5tKXptMtP6Y4M91PvC3Uxhmzl6GwJ6s=;
        h=From:To:Cc:Subject:Date:From;
        b=Fxr33xJon8uAnaxViuAz6dyW9NPO/maV1BqLbEarP9CmwaaFgULoD9/nhGT3RFSkD
         Z8OlkZbRI7fUkuSJg07xN4Fxfk1q/I4AhwXr0dyp3hwirbxUYbmWLka17If4JwI3Q4
         5KyBftpi0UDyZZhQEHU+Bia3cza3Im2pddj3o7I8jyrbMFbuA5GXEvjya0yf5E+ILe
         OTllDVHwH2qVZ0l0GE4m30jHgC3M1urfX6jvLWmtERSO58LvKvGcviqPRtGJqiE2Kk
         9OtaqFJss0STmrxqeMtl3mGPisPHkwsYO2oCauCJhHtsWsGDPhzm9ulMERLNTZMd98
         d0EaHtx5dp92Q==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     rientjes@google.com, xhao@linux.alibaba.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH 0/4] Introduce DAMON sysfs interface
Date:   Thu, 17 Feb 2022 16:19:34 +0000
Message-Id: <20220217161938.8874-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON's debugfs-based user interface served very well, so far.  However, it
unnecessarily depends on debugfs, while DAMON is not aimed to be used for only
debugging.  Also, the interface receives multiple values via one file.  For
example, schemes file receives 18 values.  As a result, it is not only hard to
be used, but also difficult to be extended.  Especially, keeping backward
compatibility of user space tools is getting only challenging.  It would be
better to implement another reliable and flexible interface and deprecate the
debugfs interface in long term.

For the reason, this patchset introduces a sysfs-based new user interface of
DAMON.  The idea of the new interface is, using directory hierarchies and
making one file for one value.  For a short example, users can do the virtual
address monitoring via the interface as below:

    # cd /sys/kernel/mm/damon/admin/
    # echo 1 > kdamonds/nr
    # echo 1 > kdamonds/0/contexts/nr
    # echo vaddr > kdamonds/0/contexts/0/damon_type
    # echo 1 > kdamonds/0/contexts/0/targets/nr
    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid
    # echo on > kdamonds/0/state

Changes that will be made for dropping RFC tag
----------------------------------------------

As the RFC tag means, this is not for merged in the mainline but only for early
comments.  Therefore, this version is not implementing all the features of
DAMON debugfs interface but only basic virtual address space monitoring.  The
official version of the patchset will provide all the features that DAMON
debugfs interface is providing.  Also, this RFC patchset lacks formal
documentation.  It will be a part of the official version.

Future plan of DAMON debugfs interface deprecation
--------------------------------------------------

Once the official version of this patchset is merged, DAMON debugfs interface
development will be frozen.  That is, we will keep the interface works as is
now, but it will not provide any new feature of DAMON.  The support will be
continued only until next LTS release.  After that, we will drop DAMON debugfs
interface.  Changes to the documentation for explicitly announcing the
deprecation plan would be a part of the official version of this patchset.

Main difference between DAMON_DBGFS and DAMON_SYSFS
---------------------------------------------------

DAMON debugfs interface allows multiple monitoring contexts, but it asks users
to turn those all on and off at once.  It's not a big problem but makes the
operation a little bit complex.  DAMON_SYSFS allows users to turn on and off
monitoring contexts individually.

The Hierarchy
=============

In a glance, the files hierarchy of the sysfs interface is as below.

    /sys/kernel/mm/damon/admin
    │ kdamonds
    │ │ nr
    │ │ 0/
    │ │ │ state,pid
    │ │ │ contexts
    │ │ │ │ nr
    │ │ │ │ 0/
    │ │ │ │ │ damon_type
    │ │ │ │ │ monitoring_attrs/
    │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
    │ │ │ │ │ │ nr_regions/min,max
    │ │ │ │ │ targets/
    │ │ │ │ │ │ nr
    │ │ │ │ │ │ 0/
    │ │ │ │ │ │ │ pid
    │ │ │ │ │ │ │ regions/
    │ │ │ │ │ │ │ │ nr
    │ │ │ │ │ │ │ │ 0/
    │ │ │ │ │ │ │ │ │ start,end
    │ │ │ │ │ │ │ │ ...
    │ │ │ │ │ │ ...
    │ │ │ │ │ ...
    │ │ ...

Root
----

The root of the DAMON sysfs is /sys/kernel/mm/damon/, and it has one directory
named 'admin'.  The directory contains the interface for privileged user space
programs.  User space tools or deamons having root permission could use this
directory.  In a future, sibling directories for non-root user space tools or
deamons (we could allow them to do monitong of their own virtual address space)
or control of in-kernel DAMON-based deamons could be created.

kdamonds/
---------

The monitoring-related information including request specifications and results
are called DAMON context.  DAMON executes a set of the contexts with a kernel
thread called kdamond (for now, only one context per kdamond is supported), and
multiple kdamonds could run in parallel.  This directory has files for
controlling the kdamonds.

In the beginning, this directory has only one file, 'nr'.  Writing a number
(`N`) to the file creates the number of child directories named `0` to `N-1`.
Each directory represents each kdamond.

kdamonds/<N>/
-------------

In each kdamond directory, two files (`state` and `pid`) and one directory
(`contexts`) reside.

Reading `state` returns `on` if the kdamond is currently running, or `off` if
it is not running.  Writing `on` or `off` makes the kdamond be in the state.
If the state is `on`, reading `pid` shows the pid of the kdamond thread.

`contexts` directory resembles `kdamonds`.  It contains files for controlling
the monitoring contexts that this kdamond will execute.

kdamonds/<N>/contexts/
----------------------

In the beginning, this directory has only one file, 'nr'.  Writing a number
(`N`) to the file creates the number of child directories named as `0` to
`N-1`.  Each directory represents each monitoring context.  At the moment, only
one context per kdamond is supported, so only `0` or `1` can be written to the
file.

contexts/<N>/
-------------

In each context directory, one file (`operations`) and two directories
(`monitoring_attrs` and `targets`) reside.

DAMON supports multiple types of monitoring operations, including those for
virtual address space and physical address space.  You can set and show what
type of monitoring operations you want to use with the context by writing one
of below keywords to, and reading the file.

- vaddr: Monitor virtual address spaces of specific processes

Files for specifying attributes of the monitoring including required quality
and efficiency of the monitoring are in `monitoring_attrs` directory, while
files for specifying to what memory regions the monitoring should be done are
in `targets` directory.

contexts/<N>/monitoring_attrs/
------------------------------

In this directory, you can show two directories, `intervals` and `nr_regions`.

Under `intervals` directory, three files for DAMON's sampling interval
(`sample_us`), aggregation interval (`aggr_us`) and update interval
(`update_us`) exist.  You can set and get the values by writing to and reading
from the files.

Under `nr_regions` directory, two files for the lower-bound and upper-bound of
DAMON's monitoring regions (`min` and `max`, respectively), which controls the
monitoring overhead, reside.  You can set and get the values by writing to and
rading from the files.

For more details about the intervals and monitoring regions range, please read
the Design document[1].

[1] https://docs.kernel.org/vm/damon/design.html

contexts/<N>/targets/
---------------------

In the beginning, this directory has only one file, 'nr'.  Writing a number
(`N`) to the file creates the number of child directories named `0` to `N-1`.
Each directory represents each monitoring target.

targets/<N>/
------------

In each target directory, one file (`pid`) exists.

You can make the context to monitor the virtual address space of a process by
writing the pid of the process to the file, and show what process's virtual
address space the context is set to monitor by reading the file.

SeongJae Park (4):
  mm/damon: Implement a sysfs-based DAMON user interface
  mm/damon/core: Allow non-exclusive DAMON start/stop
  mm/damon/sysfs: Link DAMON to 'state' file read/write functions
  selftests/damon: Add a test for DAMON sysfs interface

 include/linux/damon.h                  |    2 +-
 mm/damon/Kconfig                       |    7 +
 mm/damon/Makefile                      |    1 +
 mm/damon/core.c                        |   22 +-
 mm/damon/dbgfs.c                       |    2 +-
 mm/damon/reclaim.c                     |    2 +-
 mm/damon/sysfs.c                       | 1258 ++++++++++++++++++++++++
 tools/testing/selftests/damon/Makefile |    1 +
 tools/testing/selftests/damon/sysfs.sh |  200 ++++
 9 files changed, 1486 insertions(+), 9 deletions(-)
 create mode 100644 mm/damon/sysfs.c
 create mode 100755 tools/testing/selftests/damon/sysfs.sh

-- 
2.17.1

