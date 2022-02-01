Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE624A67B4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbiBAWWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:22:30 -0500
Received: from mail-dm6nam08on2042.outbound.protection.outlook.com ([40.107.102.42]:12766
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234350AbiBAWW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:22:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQdkAKwDDqfDPGgxsLnUkiOOzio1tk+kLinybpsg7fewGeqkR9+yYZZWLNshgYhTuJMYaTGEm5kf5QtghmsUhDr3fW9QFqM6G49vMNzjUU0mbyEU28BQ62drIg2rS3AeD14mLgOdgJ0RDj5awaj8QJlfgssQDtZj7Ua5oCQ/rfEWepT+PQRBJObjvxjNRevpu+Pun6wn+uV2YW0WcMnmUNzq8zUZ4+iyn/9kQ3yU15MvDrMewWtsJEwev4eUs5HCYFsIRLBCaY0g+/i2fuHV0VAt9UZmNsHvtYCVnLhYA7yeR2L0HCae4nKynUqQW0zyKAMFB9LulpIRW7kAGNgLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlKQ0eBCt4IhYW3j1N6j27Gz2N7a3ioPsgKoYOAVjLI=;
 b=F2pXFf3nlXv17QahSokAFVqs7ECv6jeLUWGpfMjOTTAGXkHaU/E5u5AMAEi4yJ4T+cM4oJYtkqWNAolQFEmek4FjVG9WQsXfDIOZ8J8QxnK/roYqsRywYjUf58BgTh6SQimpHDPeIP+vYyBhu604PgF59jK0YKFW9PC294BIzXbbsn20SrVaRVGHLrpkTqAQk7qbpr9e+Pou0AKVacib7FUiD4UkbKGi2xE24hG1mVE6DyyybZPQhYbDLYIHUh6n+WAQo99a7GzQSdbRK0h4gomOA+ZkrAU4TRmLKk7fqibhTM7GiFXznJdPn+cdWnX9ljhzJhuy6TwcUTms8AqCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlKQ0eBCt4IhYW3j1N6j27Gz2N7a3ioPsgKoYOAVjLI=;
 b=gwjzZ6rSJ/K5TpGFBWSqqSrq85HVPrOllMCTLsVqip28dasvJdJ4z3Ak9ZM45pqtSrVbUYjlN5irIi4pRTJ9BZPEXka4xba7+mKjEXcn4kuRAvpky5T35whjfJrsSu71fqGl2eWQYuU2iuU6hra5Guja2uvtCX0VRhYdNkOOeqie2YZR1MZyknSuytd9DbisIVUPF7/yKQ3ttkOcLQhBEGlkunXP58kPNU0ZgADpJJnSQgR9MHaUOhDZDM8N4PZOJ5vVZzDGE0xQtEgtsY0w2xhe6XJXwR1tjNSGxJfmw6WY8bYSwY4K4Ck35vaTiRChO/5gl+Z5D/Kk+GIg/cUDgA==
Received: from DM6PR17CA0004.namprd17.prod.outlook.com (2603:10b6:5:1b3::17)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 1 Feb
 2022 22:22:25 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::57) by DM6PR17CA0004.outlook.office365.com
 (2603:10b6:5:1b3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21 via Frontend
 Transport; Tue, 1 Feb 2022 22:22:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Tue, 1 Feb 2022 22:22:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 22:22:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 14:22:24 -0800
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 14:22:24 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v4 01/11] Documentation: Add HTE subsystem guide
Date:   Tue, 1 Feb 2022 14:26:20 -0800
Message-ID: <20220201222630.21246-2-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220201222630.21246-1-dipenp@nvidia.com>
References: <20220201222630.21246-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62718464-d935-4ce3-9dfc-08d9e5d15352
X-MS-TrafficTypeDiagnostic: DM6PR12MB4076:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4076C85868EF25329B521B3EAE269@DM6PR12MB4076.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YGAoNj0HFhaUmtMFPQGKCDPyDKVSDY97vo53LxbzLVgb0oHJQ+PwkcCXAAKVOVZfc7Fuj1PKrFuIkZC8BeORnuCz+Bq6ALOpGHgp4j0OONTikWOvgN7ov/4oQfcORuogbCH4WA/Rj6rnMwXsYel5qtDujORLEjz8kkBL3Gtit7E9ndJQxEpUbnp1IlhF6YdnAcaLx6CD9TJ3O87sxtoEmKu3DyxSAZF0P1Mv4gK2lP3HPxdXCoHrK7bhQB5zpBcbr6a5YfSCz11ppA1QXWBgjQIjpcTc0G6YFOnNY3PUfLbTyXnHRXnlBe2kBO+yjQveHr929lZqkNPLks0/e9ckzJ0ed0FBXXOxdQZ4ouULN9NjiVUoDRUvYmUv3Pw5atCZA4p52j0V8OdDCMQM4QGioQQoy9DMeMBL2Z4gT0JeOYmy9+BR/JflsroNiWT0w1p03V+KbNy/RaYFg6Ye6ipafhQUWpIO64fu3HtdoQ+9vmhJox8AWt/EpV38Qik4M/vMXMvrObaSIQ8T08cBIlD+q+UmpskvATrebMl5qrdKzsFJswJ/rDfStl1rwzM4sQKld7Tm1M2VPD/d64Z9QMvSohNYAb0EhqTAyQ0jqav8auoPHMwhZ0V2DuSc/Xu5LZS6D0rdh8mDpBjBBvpUagsDLihqLCttnEbZl3Nlnndom9neFI0vgJpgU2oV/SmQ1XlEz/R2ifSt0nNUNAtTARB0rjRK/ZEcIRK8kkzDHEqv3RbBQVj2Mao14KQgLgfYIZvL4keX087wQZX5+MoO8zvL9A==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(81166007)(110136005)(921005)(356005)(86362001)(83380400001)(7416002)(5660300002)(2906002)(82310400004)(7696005)(70586007)(6666004)(70206006)(8936002)(8676002)(36756003)(186003)(4326008)(47076005)(2616005)(336012)(40460700003)(107886003)(316002)(26005)(426003)(36860700001)(1076003)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 22:22:25.7234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62718464-d935-4ce3-9dfc-08d9e5d15352
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding hte document which can help understand various APIs implemented
in HTE framework for the HTE producers and the consumers.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 Documentation/hte/hte.rst | 83 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/hte/hte.rst

diff --git a/Documentation/hte/hte.rst b/Documentation/hte/hte.rst
new file mode 100644
index 000000000000..f82113e540b8
--- /dev/null
+++ b/Documentation/hte/hte.rst
@@ -0,0 +1,83 @@
+============================================
+The Linux Hardware Timestamping Engine (HTE)
+============================================
+
+:Author: Dipen Patel
+
+Introduction
+------------
+
+Certain devices have built in hardware timestamping engines which can
+monitor sets of system signals, lines, buses etc... in realtime for state
+change; upon detecting the change they can automatically store the timestamp at
+the moment of occurrence. Such functionality may help achieve better accuracy
+in obtaining timestamps than using software counterparts i.e. ktime and
+friends.
+
+This document describes the API that can be used by hardware timestamping
+engine provider and consumer drivers that want to use the hardware timestamping
+engine (HTE) framework. Both consumers and providers must include
+#include <linux/hte.h>.
+
+The HTE framework APIs for the providers
+----------------------------------------
+
+.. kernel-doc:: drivers/hte/hte.c
+   :functions: devm_hte_register_chip hte_push_ts_ns
+
+The HTE framework APIs for the consumers
+----------------------------------------
+
+.. kernel-doc:: drivers/hte/hte.c
+   :functions: devm_of_hte_request_ts_ns hte_req_ts_by_linedata_ns hte_release_ts hte_enable_ts hte_disable_ts hte_get_clk_src_info
+
+The HTE framework public structures
+-----------------------------------
+.. kernel-doc:: include/linux/hte.h
+
+More on the HTE timestamp data
+------------------------------
+The struct hte_ts_data is used to pass timestamp details between the consumers
+and the providers. It expresses timestamp data in nanoseconds in u64 data
+type. For now all the HTE APIs using struct hte_ts_data require tsc to be in
+nanoseconds. An example of the typical hte_ts_data data life cycle, for the
+GPIO line is as follows::
+
+ - Monitors GPIO line change.
+ - Detects the state change on GPIO line.
+ - Converts timestamps in nanoseconds and stores it in tsc.
+ - Stores GPIO raw level in raw_level variable if the provider has that
+ hardware capability.
+ - Pushes this hte_ts_data object to HTE subsystem.
+ - HTE subsystem increments seq counter and invokes consumer provided callback.
+ Based on callback return value, the HTE starts a kernel thread and invokes
+ secondary callback in the thread context.
+
+HTE subsystem debugfs attributes
+--------------------------------
+HTE subsystem creates debugfs attributes at ``/sys/kernel/debug/hte/``.
+It also creates line/signal-related debugfs attributes at
+``/sys/kernel/debug/hte/<provider>/<label or line id>/``.
+
+`ts_requested`
+		The total number of entities requested from the given provider,
+		where entity is specified by the provider and could represent
+		lines, GPIO, chip signals, buses etc...
+                The attribute will be available at
+		``/sys/kernel/debug/hte/<provider>/``.
+
+		Read-only value
+
+`total_ts`
+		The total number of entities supported by the provider.
+                The attribute will be available at
+		``/sys/kernel/debug/hte/<provider>/``.
+
+		Read-only value
+
+`dropped_timestamps`
+		The dropped timestamps for a given line.
+                The attribute will be available at
+		``/sys/kernel/debug/hte/<provider>/<label or line id>/``.
+
+		Read-only value
-- 
2.17.1

