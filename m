Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A28490B40
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbiAQPPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:15:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4418 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbiAQPPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:15:34 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JcwPS6HF2z67fK4;
        Mon, 17 Jan 2022 23:12:28 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 17 Jan 2022 16:15:31 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 15:15:27 +0000
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <kjain@linux.ibm.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/3] perf: Support event alias in form foo-bar-baz
Date:   Mon, 17 Jan 2022 23:10:12 +0800
Message-ID: <1642432215-234089-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently event aliases in the form foo-bar-baz are not supported.

The HiSilicon D06 platform has uncore event aliases in that form, and
using those aliases fail:

$ ./perf list sdir-home-migrate 
  
List of pre-defined events (to be used in -e): 
  
uncore hha:
  sdir-home-migrate 
 [Unit: hisi_sccl,hha]  

$ sudo ./perf stat -e sdir-home-migrate  
event syntax error: 'sdir-home-migrate'  
                        \___ parser error  
Run 'perf list' for a list of valid events  
  
 Usage: perf stat [<options>] [<command>]
  
 -e, --event <event>event selector. use 'perf list' to list available events

This series added support for such an event alias form.

I am no expert on l+y, so any and all review here would be appreciated,
especially the last patch which is marked as RFC (for that same reason).

The series is based on acme perf/core @ 9bce13ea88f8.

John Garry (3):
  perf parse-events: Support event alias in form foo-bar-baz
  perf test: Add pmu-events test for aliases with hyphens
  perf test: Add parse-events test for aliases with hyphens

 .../arch/test/test_soc/cpu/uncore.json        | 16 +++++
 tools/perf/tests/parse-events.c               | 49 ++++++++++++++
 tools/perf/tests/pmu-events.c                 | 32 +++++++++
 tools/perf/util/parse-events.c                | 67 ++++++++++++++++---
 tools/perf/util/parse-events.h                |  1 +
 tools/perf/util/parse-events.l                |  2 +
 tools/perf/util/parse-events.y                | 17 ++++-
 7 files changed, 171 insertions(+), 13 deletions(-)

-- 
2.26.2

