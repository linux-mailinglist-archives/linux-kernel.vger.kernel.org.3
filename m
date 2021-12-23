Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B63247DD8F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 02:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbhLWB6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 20:58:20 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33900 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhLWB6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 20:58:18 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JKCy86Pbwzcc69;
        Thu, 23 Dec 2021 09:57:52 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (7.185.36.158) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 09:58:16 +0800
Received: from [10.174.179.208] (10.174.179.208) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 09:58:15 +0800
Message-ID: <1f7127f4-6f32-8b4f-5bc2-3f35a337bc1a@huawei.com>
Date:   Thu, 23 Dec 2021 09:58:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   yaowenbin <yaowenbin1@huawei.com>
Subject: [PATCH] perf record: Add O_EXCL flag for opening perf.data file
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <thunder.leizhen@huawei.com>, <rickyman7@gmail.com>,
        <ak@linux.intel.com>, <adrian.hunter@intel.com>,
        <yaowenbin1@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hewenliang4@huawei.com>, <wuxu.wu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the following command is executed, a coredump file is generated.
	$ perf record -e cpu-clock sleep 3 & perf record -e cpu-clock sleep 3 &
	[1] 213456
	[2] 213457
	[ perf record: Woken up 1 times to write data ]
	[ perf record: Woken up 1 times to write data ]
	[ perf record: Captured and wrote 0.012 MB perf.data (4 samples) ]
	[1]-  Bus error               (core dumped) perf record -e cpu-clock sleep 3
	[2]+  Done                    perf record -e cpu-clock sleep 3

It is a problem of concurrent access of perf.data file. When several
processes execute "perf record" command in the same directory
concurrently, they may open the same perf.data file, and write
the same file, causing data confusion. It may cause coredump when
reading the file. Then add O_EXCL flag to ensure that there is only
one process operating the perf.data file in the same directory concurrently.

After adding O_EXCL flag, the open operation will fail if there is
a perf.data file existing in the same directory, so also rename the
perf.data file to perf.data.old even if the size of perf.data is zero.

Signed-off-by: yaowenbin <yaowenbin1@huawei.com>
---
 tools/perf/util/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index f5d260b1df4d..92cf0aa3ed83 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -201,7 +201,7 @@ static int check_backup(struct perf_data *data)
 	if (perf_data__is_read(data))
 		return 0;

-	if (!stat(data->path, &st) && st.st_size) {
+	if (!stat(data->path, &st)) {
 		char oldname[PATH_MAX];
 		int ret;

@@ -285,7 +285,7 @@ static int open_file_write(struct perf_data *data)
 	int fd;
 	char sbuf[STRERR_BUFSIZE];

-	fd = open(data->file.path, O_CREAT|O_RDWR|O_TRUNC|O_CLOEXEC,
+	fd = open(data->file.path, O_CREAT|O_RDWR|O_TRUNC|O_CLOEXEC|O_EXCL,
 		  S_IRUSR|S_IWUSR);

 	if (fd < 0)
--
2.27.0
