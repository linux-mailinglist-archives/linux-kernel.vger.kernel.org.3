Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987DB472DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbhLMNvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:51:43 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29127 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbhLMNvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:51:42 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JCNBz3X64z1DMHh;
        Mon, 13 Dec 2021 21:48:43 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 21:51:40 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 13 Dec
 2021 21:51:40 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <john.stultz@linaro.org>
CC:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>, <liaoyu15@huawei.com>
Subject: [PATCH v2] timekeeping: Make sure wall_to_monotonic isn't positive
Date:   Mon, 13 Dec 2021 21:57:27 +0800
Message-ID: <20211213135727.1656662-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit e1d7ba873555 ("time: Always make sure wall_to_monotonic
isn't positive"), we can still change wall_to_monotonic to positive
by running the following code:
    int main(void)
    {
        struct timespec time;

        clock_gettime(CLOCK_MONOTONIC, &time);
        time.tv_nsec = 0;
        clock_settime(CLOCK_REALTIME, &time);
        return 0;
    }

The reason is that the parameters of timespec64_compare() may be
unnormalized, and timespec64_compare() simply compare tv_sec,
for example:
  wall_to_monotonic = {tv_sec = -10, tv_nsec = 900000000}
  ts_delta = {tv_sec = -9, tv_nsec = -900000000}

timespec64_compare() result is wall_to_monotonic < ts_delta, but
actually wall_to_monotonic > ts_delta. After normalized, the result
of timespec64_compare() is correct:
  wall_to_monotonic = {tv_sec = -10, tv_nsec = 900000000}
  ts_delta = {tv_sec = -10, tv_nsec = 100000000}

Use timespec64_sub() to ensure ts_delta normalized, and the code
looks more concise.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 kernel/time/timekeeping.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b348749a9fc6..dcdcb85121e4 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1306,8 +1306,7 @@ int do_settimeofday64(const struct timespec64 *ts)
 	timekeeping_forward_now(tk);
 
 	xt = tk_xtime(tk);
-	ts_delta.tv_sec = ts->tv_sec - xt.tv_sec;
-	ts_delta.tv_nsec = ts->tv_nsec - xt.tv_nsec;
+	ts_delta = timespec64_sub(*ts, xt);
 
 	if (timespec64_compare(&tk->wall_to_monotonic, &ts_delta) > 0) {
 		ret = -EINVAL;
-- 
2.25.1

