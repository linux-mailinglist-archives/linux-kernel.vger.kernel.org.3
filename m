Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0714EA75F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiC2FrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiC2FrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:47:09 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2045.outbound.protection.outlook.com [40.107.100.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A411C118;
        Mon, 28 Mar 2022 22:45:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTCWuCYF0cX/iVoZAUjRSrQ7Uyx1dLQq26RpUAjI1zzNXizMmJ1Azv1vTh/Zmanmd4JIIn7yb+QBEFDEU/N1z5wvG91qptiWkfoRM6TEj48bwTa3EbpKSPPKGZXSsaVlQv3UEwmwzqBBCdPMqkFid3bhyddXxY/yf9x3DYYdK+Mhmmoki7WjXk2mtRsPW6yKzR+L1mfWm1WL9N5b9cpeVC/wVGP9bbunPXV7mS08Ut2B3Cz8yRhGCGMsCAbmkfSxAymLmXmCVQHaua/MVLVGD4dQETkrwP8xRkrv9MQdTyyOUp3a8t814jhUn5TXCG7yZ23+9RPYRx8bPTzexgZ0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVg8g1ZszVftaMW8PQlVTPQjJXLGjXIShmHMOqdM5ZQ=;
 b=XhQdyQyhKusEazzgVPJ/1qPuoMxIApqs8BXoxk0lp9vO8wRj7jYnf7+K7iO783c/moARgMei8OcZIT2Y/BQ40JXWF8OZzbwTLGE8IlVgS6auO7CANRf3D826zya2K6M96d5tWmQ4xtZFN8RM3LYO9NqLDgyn58QxtMXzKPz/1NLL5j5igM3U7mEmXqPW54dCOxF2msw+JRfLYtJx2Suye1S5KYzd1ws6tUrNpsQ6iexcZkH5He9WP4GF4pmgCe9ivqxbAHV8NwM3NHvfAsD6T0OZMf+AKkJG2Ql8TCX3Wfh0n+rrQcgopihTFIMhaTt7+bf3JMegGfnDDRK0SLWVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVg8g1ZszVftaMW8PQlVTPQjJXLGjXIShmHMOqdM5ZQ=;
 b=FvN2EDf3rZxvWBqOkHBVulyQsEyw4sJpNO7npgqQCcM0jCeoLCsF66FuLjpyBhmKeiG0sX+3ZvaaVX0eX+xl45X5FmLZriBhqkBnpStGSJLgwJk0w8zBQnwHxdCo5i5ZvBk00EdEQZRaIwTzp60H+8aScFvsUvijy5GV7ubvY+A0HPeMMWsFk0wpkM+F63mgYuPzcmCmLQ4ouBKogeB8jouWYEBGgoIu0HRJZ0t+CRmlKphXpfDwBzc6/XnORibKmx7L8joZs5LOFCSOgbE3aTgUDlAV9VG4pwJ7LhQhkZWrR0hryP6PHwJ8HbNIewNhrq4G6DFIn4fGbNAJRh44nQ==
Received: from MW4PR03CA0104.namprd03.prod.outlook.com (2603:10b6:303:b7::19)
 by BL0PR12MB4964.namprd12.prod.outlook.com (2603:10b6:208:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 05:45:24 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::1c) by MW4PR03CA0104.outlook.office365.com
 (2603:10b6:303:b7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Tue, 29 Mar 2022 05:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 05:45:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 29 Mar
 2022 05:45:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 28 Mar
 2022 22:45:22 -0700
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 28 Mar 2022 22:45:22 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v5 01/11] Documentation: Add HTE subsystem guide
Date:   Mon, 28 Mar 2022 22:45:11 -0700
Message-ID: <20220329054521.14420-2-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220329054521.14420-1-dipenp@nvidia.com>
References: <20220329054521.14420-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ec5506c-aa56-4af1-2c1e-08da1147520a
X-MS-TrafficTypeDiagnostic: BL0PR12MB4964:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB496424A4E2F8AB967974EE27AE1E9@BL0PR12MB4964.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyWgGgwy29wQXaij+JGUA/CIS9tEuAqrjOPNZG4Q5esGSbaMe5VrOl/QWVPVMyHiMgRHwDdsoGPnbHA4mkHORbflGyxf4OcPU3vXsw6a/P3ESHyKAx4bpyZ6m5eIlDbzEj84KtQDIunME16gIvAZXXOe2iQJw0KnqCEzleCu6E/k98WHddkd/9Aa1h12S9AyGJv8GmfMUIyEq6CVau7SR+SuIbk45bkyKDv+BweERKm+JOeCYwu4uxJjHxQ3UpJnTso4U7UKI8AzQzWurjBGbJimw9uKBMzztzb0eZ5gNM3zR2VqS2jIFBYLkgF6SeCEfz+jIzCA4RWFpB2AOpTAutkTa+pnuTqSpJPkttR3IgnxjYyMz/X0BsrygIOvdrQjyrZTKoxgEDVYSoelQbQXEeppsyErNlN4Pm1rKwBSURsuZKGl076mAMkIvCAxPycjridaFVPm2tbHWbhEXvCLZrxDD3pYsjaTgR0J7KA83NdTijgXRD6RqmCxL31KmBXYVxh4aieolvZCa1vn2wNqGxKM8S5firpu9kYr6zRjtdJDOgrRW4jESOMLnuuvUhTwl0sFKUpQa+991MYox4IY+gz8h28Q+BEvjPHXAgqSnDc8epl/NFYrwz+YHhlcw2LM3+e9mYJTGzZ1ClmQTjAPUZ2JSv/P2R/ofekc8XP37Vlx8kAv9kUQd4jOtElJ9hSHyL66IGeddv+I4XmUSsOIGxyj3o0IVxmUdnnJUZrYF5pTuxT6DEMgJegGm4DfjwLCBfsuNBHbuhofNsRNib9zMQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(8676002)(6666004)(82310400004)(7696005)(508600001)(70586007)(47076005)(86362001)(316002)(110136005)(70206006)(336012)(426003)(40460700003)(36860700001)(83380400001)(81166007)(2906002)(356005)(26005)(8936002)(2616005)(107886003)(1076003)(186003)(921005)(36756003)(5660300002)(7416002)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 05:45:24.2001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec5506c-aa56-4af1-2c1e-08da1147520a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4964
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding hte document which can help understand various APIs implemented
in HTE framework for the HTE producers and the consumers.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
Changes in v2:
- Removed explanation, instead added kernel-doc references.

Changes in v3:
- Addressed grammatical errors.

Changes in v4:
- Added new API hte_req_ts_by_linedata_ns description.
- Removed hte_req_ts_by_hte_name.

 Documentation/hte/hte.rst | 83 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/hte/hte.rst

diff --git a/Documentation/hte/hte.rst b/Documentation/hte/hte.rst
new file mode 100644
index 000000000000..7ac3e2fdb952
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
+ Based on callback return value, the HTE core invokes secondary callback in
+ the thread context.
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

