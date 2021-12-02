Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1A7466433
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346710AbhLBNED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 08:04:03 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29147 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhLBNEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 08:04:02 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J4bcG17j1zXdSG;
        Thu,  2 Dec 2021 20:58:38 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 21:00:37 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 2 Dec
 2021 21:00:37 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <john.stultz@linaro.org>, <tglx@linutronix.de>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>,
        <liaoyu15@huawei.com>
Subject: [PATCH] time: Normalize timespec64 before timespec64_compare()
Date:   Thu, 2 Dec 2021 21:07:07 +0800
Message-ID: <20211202130707.3910459-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing unnormalized timespec64 to timespec64_compare() may cause
incorrect results.

For example:
  wall_to_monotonic = {tv_sec = -10, tv_nsec = 900000000}
  ts_delta = {tv_sec = -9, tv_nsec = -900000000}

timespec64_compare() returns -1, but actually wall_to_monotonic > ts_delta.
This will cause wall_to_monotonic to become a positive number.

Use timespec64_sub() instead of direct subtraction to avoid this.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 include/linux/time64.h    | 2 ++
 kernel/time/timekeeping.c | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/time64.h b/include/linux/time64.h
index 81b9686a2079..f74a36d253cd 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -50,6 +50,8 @@ static inline int timespec64_equal(const struct timespec64 *a,
  * lhs < rhs:  return <0
  * lhs == rhs: return 0
  * lhs > rhs:  return >0
+ *
+ * Note: Both lhs and rhs must be normalized.
  */
 static inline int timespec64_compare(const struct timespec64 *lhs, const struct timespec64 *rhs)
 {
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

