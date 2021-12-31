Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0390A482279
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 07:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241182AbhLaGZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 01:25:06 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:34862 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhLaGZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 01:25:05 -0500
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JQFV92SJvzccHb;
        Fri, 31 Dec 2021 14:24:33 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 14:25:02 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rui.xiang@huawei.com>
Subject: [PATCH 0/2] perf tools: Fix mis-matching of perf sub-commands
Date:   Fri, 31 Dec 2021 14:30:42 +0800
Message-ID: <20211231063044.2405691-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We support short command 'rec*' for 'record' and 'rep*' for 'report' in
lots of sub-commands, but the matching is not quite strict currnetly.

It may be puzzling sometime, like we mis-type a 'recport' to report but
it will perform 'record' in fact without any message. So fix the
mis-matching.

Wei Li (2):
  perf string: Add strcmp_prefix()
  perf tools: Enhance the matching of sub-commands

 tools/perf/builtin-c2c.c       |  5 +++--
 tools/perf/builtin-kmem.c      |  2 +-
 tools/perf/builtin-kvm.c       |  9 +++++----
 tools/perf/builtin-lock.c      |  5 +++--
 tools/perf/builtin-mem.c       |  5 +++--
 tools/perf/builtin-sched.c     |  4 ++--
 tools/perf/builtin-script.c    |  6 ++++--
 tools/perf/builtin-stat.c      |  4 ++--
 tools/perf/builtin-timechart.c |  3 ++-
 tools/perf/util/string.c       | 17 +++++++++++++++++
 tools/perf/util/string2.h      |  1 +
 11 files changed, 43 insertions(+), 18 deletions(-)

-- 
2.25.1

