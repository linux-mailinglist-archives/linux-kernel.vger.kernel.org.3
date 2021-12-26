Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E638647F5B7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 08:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhLZHvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 02:51:11 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30111 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhLZHvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 02:51:10 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JMCZd4qj1z1DKDk;
        Sun, 26 Dec 2021 15:47:53 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 26 Dec 2021 15:51:07 +0800
Received: from huawei.com (10.175.100.227) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sun, 26 Dec
 2021 15:51:01 +0800
From:   Tang Yizhou <tangyizhou@huawei.com>
To:     <viresh.kumar@linaro.org>, <rafael.j.wysocki@intel.com>,
        <rafael@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <zhengbin13@huawei.com>,
        Tang Yizhou <tangyizhou@huawei.com>
Subject: [PATCH] Documentation: power: Update outdated contents in opp.rst
Date:   Sun, 26 Dec 2021 16:18:39 +0800
Message-ID: <20211226081839.13948-1-tangyizhou@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three problems have been revised:
1. CONFIG_PM_OPP no longer depends on CONFIG_PM.
2. opp_find_freq_{ceil, floor} is renamed as dev_pm_opp_find_freq_{ceil,
   floor}.
3. Make it clear that the 'opp' struct is actually dev_pm_opp.

Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
---
 Documentation/power/opp.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/power/opp.rst b/Documentation/power/opp.rst
index e3cc4f349ea8..a7c03c470980 100644
--- a/Documentation/power/opp.rst
+++ b/Documentation/power/opp.rst
@@ -48,9 +48,9 @@ We can represent these as three OPPs as the following {Hz, uV} tuples:
 OPP library provides a set of helper functions to organize and query the OPP
 information. The library is located in drivers/opp/ directory and the header
 is located in include/linux/pm_opp.h. OPP library can be enabled by enabling
-CONFIG_PM_OPP from power management menuconfig menu. OPP library depends on
-CONFIG_PM as certain SoCs such as Texas Instrument's OMAP framework allows to
-optionally boot at a certain OPP without needing cpufreq.
+CONFIG_PM_OPP from power management menuconfig menu. Certain SoCs such as Texas
+Instrument's OMAP framework allows to optionally boot at a certain OPP without
+needing cpufreq.
 
 Typical usage of the OPP library is as follows::
 
@@ -75,8 +75,8 @@ operations until that OPP could be re-enabled if possible.
 
 OPP library facilitates this concept in its implementation. The following
 operational functions operate only on available opps:
-opp_find_freq_{ceil, floor}, dev_pm_opp_get_voltage, dev_pm_opp_get_freq,
-dev_pm_opp_get_opp_count
+dev_pm_opp_find_freq_{ceil, floor}, dev_pm_opp_get_voltage, dev_pm_opp_get_freq,
+dev_pm_opp_get_opp_count.
 
 dev_pm_opp_find_freq_exact is meant to be used to find the opp pointer
 which can then be used for dev_pm_opp_enable/disable functions to make an
@@ -103,7 +103,7 @@ dev_pm_opp_add
 	The OPP is defined using the frequency and voltage. Once added, the OPP
 	is assumed to be available and control of its availability can be done
 	with the dev_pm_opp_enable/disable functions. OPP library
-	internally stores and manages this information in the opp struct.
+	internally stores and manages this information in the dev_pm_opp struct.
 	This function may be used by SoC framework to define a optimal list
 	as per the demands of SoC usage environment.
 
@@ -247,7 +247,7 @@ dev_pm_opp_disable
 5. OPP Data Retrieval Functions
 ===============================
 Since OPP library abstracts away the OPP information, a set of functions to pull
-information from the OPP structure is necessary. Once an OPP pointer is
+information from the dev_pm_opp structure is necessary. Once an OPP pointer is
 retrieved using the search functions, the following functions can be used by SoC
 framework to retrieve the information represented inside the OPP layer.
 
-- 
2.17.1

