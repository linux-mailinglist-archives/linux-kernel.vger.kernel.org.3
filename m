Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C5C4808BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 12:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhL1LNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 06:13:45 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17306 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhL1LNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 06:13:45 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JNX276M6vz9rvf;
        Tue, 28 Dec 2021 19:12:47 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 19:13:43 +0800
Received: from linux-suspe12sp5.huawei.com (10.67.133.38) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 19:13:43 +0800
From:   Zechuan Chen <chenzechuan1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <mhiramat@kernel.org>,
        <Jianlin.Lv@arm.com>, <chenzechuan1@huawei.com>,
        <ravi.bangoria@linux.ibm.com>, <yao.jin@linux.intel.com>,
        <yangjihong1@huawei.com>, <mpe@ellerman.id.au>,
        <naveen.n.rao@linux.vnet.ibm.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] powerpc/perf: fix ppc64 perf probe add events failed
Date:   Tue, 28 Dec 2021 19:13:38 +0800
Message-ID: <20211228111338.218602-1-chenzechuan1@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.133.38]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of commit bf794bf52a80 ("powerpc/kprobes: Fix kallsyms lookup
across powerpc ABIv1 and ABIv2"), in ppc64 ABIv1, our perf command
eliminates the need to use the prefix "." at the symbol name. But when
the command "perf probe -a schedule" is executed on ppc64 ABIv1, it
obtains two symbol address information through /proc/kallsyms, for example:

cat /proc/kallsyms | grep -w schedule
c000000000657020 T .schedule
c000000000d4fdb8 D schedule

The symbol "D schedule" is not a function symbol, and perf will print:
"p:probe/schedule _text+13958584"Failed to write event: Invalid argument

Therefore, when searching symbols from map and adding probe point for
them, a symbol type check is added. If the type of symbol is not a
function, skip it.

Fixes: bf794bf52a80 ("powerpc/kprobes: Fix kallsyms lookup across powerpc ABIv1 and ABIv2")

Signed-off-by: Zechuan Chen <chenzechuan1@huawei.com>
---
 tools/perf/util/probe-event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index b2a02c9ab8ea..a834918a0a0d 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -3083,6 +3083,9 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 	for (j = 0; j < num_matched_functions; j++) {
 		sym = syms[j];
 
+		if (sym->type != STT_FUNC)
+			continue;
+
 		/* There can be duplicated symbols in the map */
 		for (i = 0; i < j; i++)
 			if (sym->start == syms[i]->start) {
-- 
2.12.3

