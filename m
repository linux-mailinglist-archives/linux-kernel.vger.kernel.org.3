Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE4C49038D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbiAQIQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:16:00 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16715 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbiAQIP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:15:59 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jcl4b05S4zZfB6;
        Mon, 17 Jan 2022 16:12:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 16:15:57 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Guo Yang <guoyang2@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH] cpuidle: menu: Fix long delay issue when tick stopped
Date:   Mon, 17 Jan 2022 16:16:15 +0800
Message-ID: <20220117081615.45449-1-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Yang <guoyang2@huawei.com>

The network delay was always big on arm server tested by qperf,
the reason was that the cpu entered deep power down idle state(like intel
C6) and can't goto a shallow one.

The intervals in @get_typical_interval() was much smaller than predicted_ns
in @menu_select(), so the predict state is always deepest and cause long
time network delay.

Every time when the cpu got an interrupt from the network, the cpu was
waken up and did the IRQ, after that the cpu enter @menu_select()
but the @tick_nohz_tick_stopped() was true and get a big data->next_timer_ns,
the cpu can never goto a shallow state util the data->next_timer_ns timeout.
Below was the print when the issue occurrence.

[   37.082861] intervals = 36us
[   37.082875] intervals = 15us
[   37.082888] intervals = 22us
[   37.082902] intervals = 35us
[   37.082915] intervals = 34us
[   37.082929] intervals = 39us
[   37.082942] intervals = 39us
[   37.082956] intervals = 35us
[   37.082970] target_residency_ns = 10000, predicted_ns = 35832710
[   37.082998] target_residency_ns = 600000, predicted_ns = 35832710
[   37.083037] intervals = 36us
[   37.083050] intervals = 15us
[   37.083064] intervals = 22us
[   37.083077] intervals = 35us
[   37.083091] intervals = 34us
[   37.083104] intervals = 39us
[   37.083118] intervals = 39us
[   37.083131] intervals = 35us
[   37.083145] target_residency_ns = 10000, predicted_ns = 35657420
[   37.083174] target_residency_ns = 600000, predicted_ns = 35657420
[   37.083212] intervals = 36us
[   37.083225] intervals = 15us
[   37.083239] intervals = 22us
[   37.083253] intervals = 35us
[   37.083266] intervals = 34us
[   37.083279] intervals = 39us
[   37.083293] intervals = 39us
[   37.083307] intervals = 35us
[   37.083320] target_residency_ns = 10000, predicted_ns = 35482140
[   37.083349] target_residency_ns = 600000, predicted_ns = 35482140

Add idle tick wakeup judge before change predicted_ns.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Guo Yang <guoyang2@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/cpuidle/governors/menu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index c492268..3f03843 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -313,7 +313,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 				get_typical_interval(data, predicted_us)) *
 				NSEC_PER_USEC;
 
-	if (tick_nohz_tick_stopped()) {
+	if (tick_nohz_tick_stopped() && data->tick_wakeup) {
 		/*
 		 * If the tick is already stopped, the cost of possible short
 		 * idle duration misprediction is much higher, because the CPU
-- 
1.8.3.1

