Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFC6481119
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbhL2IzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:55:23 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30190 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239391AbhL2IzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:55:22 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JP4tF0NHmz8w7T;
        Wed, 29 Dec 2021 16:52:53 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (7.185.36.158) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 16:55:20 +0800
Received: from [10.174.179.208] (10.174.179.208) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 16:55:20 +0800
Message-ID: <a91e3943-7ddc-f5c0-a7f5-360f073c20e6@huawei.com>
Date:   Wed, 29 Dec 2021 16:55:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <yaowenbin1@huawei.com>,
        <linux-kernel@vger.kernel.org>
CC:     <hewenliang4@huawei.com>, <wuxu.wu@huawei.com>
From:   yaowenbin <yaowenbin1@huawei.com>
Subject: [PATCH] perf top: add concurrent access protection of the SLsmg
 screen management
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the following command is executed several times, a coredump file is generated.
	$ timeout -k 9 5 perf top -e task-clock
	*******
	*******
	*******
	0.01%  [kernel]                  [k] __do_softirq
	0.01%  libpthread-2.28.so        [.] __pthread_mutex_lock
	0.01%  [kernel]                  [k] __ll_sc_atomic64_sub_return
	double free or corruption (!prev) perf top --sort comm,dso
	timeout: the monitored command dumped core

When we terminate "perf top" using sending signal method, SLsmg_reset_smg
function is called. SLsmg_reset_smg resets the SLsmg screen management routines
by freeing all memory allocated while it was active. However SLsmg_reinit_smg
function maybe be called by another thread. SLsmg_reinit_smg function will
free the same memory accessed by SLsmg_reset_smg functon, thus it results
in double free. SLsmg_reinit_smg function is called already protected by
ui__lock, so we fix the problem by adding pthread_mutex_trylock of ui__lock
when calling SLsmg_reset_smg function.

Signed-off-by: yaowenbin <yaowenbin1@huawei.com>
Signed-off-by: hewenliang <hewenliang4@huawei.com>
Signed-off-by: Wenyu Liu <liuwenyu7@huawei.com>
---
 tools/perf/ui/tui/setup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
index d4ac41679..1fdf92062 100644
--- a/tools/perf/ui/tui/setup.c
+++ b/tools/perf/ui/tui/setup.c
@@ -170,9 +170,11 @@ void ui__exit(bool wait_for_ok)
 				    "Press any key...", 0);

 	SLtt_set_cursor_visibility(1);
-	SLsmg_refresh();
-	SLsmg_reset_smg();
+	if (!pthread_mutex_trylock(&ui__lock)) {
+		SLsmg_refresh();
+		SLsmg_reset_smg();
+		pthread_mutex_unlock(&ui__lock);
+	}
 	SLang_reset_tty();
-
 	perf_error__unregister(&perf_tui_eops);
 }
--
2.27.0
