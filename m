Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74AB50C21E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiDVWJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiDVWHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:07:41 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on20621.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DFA223C62;
        Fri, 22 Apr 2022 13:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtNV8P/fOChhoVPhE/a1zTgj3PgWgkTsdjJtuiMQoLQPd8aS/vH0+wEP2kqV7huufZhybY7Px8a02TwjKD+sxcrT1vY+jwR4ICIx9p7UtWTZPx5L/5yDXDdNwUvULmq0Mg1oRRbBF8rDzhxCaGEd2Xf+ONbHS94lh+ediWdXarawRuZTS3LeMhegDTTo2sqJWtbfAeDsRmUuSxd8XXA+6luZzmiq02mJN/MHRFPFg0zEH49BNIOxbIPN/V/zGGTomCjlqGIGiemPai8HnHP0VPBN3QapIlIXFL6X8esEHKyznhXJRrlVmf3nYO11hPRkXicabjUy6ld7VDsxxddhUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40X+RSsRAcPXLU7KW0N+BBXEZG6j662+2UxcqZ47xOQ=;
 b=m9pkI9Z0t752smSN8RzM6YUZFd/a/s0s4go1ukfyZ6w2cLq9p1GAaQPk99XrpXuUteysRp7gqSmk5sIrhh9USyPPe9RNWUg6u/WZawI5kz78KEqDMy2NsOht41/e8KyVw0k3EgSeTtzJSbnYqO4VvNAEW+08gIDIYM0FGwEONITFfTJh/aUNKtljyufdnG74l8qzMhJe08JLssXyulLXRdbzXHekMJHsBiZcGfFIOkhBeaFVn27Ehnz6NyxCytmygPONWgHuIC2JhVBHioE0f3ALiPZzxrBi8c4BTGLOF8Wps92APG4j5zvgV1KAjUmcAxOIx2AWyALdlOfBUEQ5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40X+RSsRAcPXLU7KW0N+BBXEZG6j662+2UxcqZ47xOQ=;
 b=NtmVht2kpfedh1meN085Jf2R/ds+h0nARVCdT4mTHkAxdPxIw95fN7BYSmaliMJu2HbVvWdoSSJsVR+h1Q08yaP5eap6VSjfgL9floKbowG1MkxRTobAtyn29OAw9h1ue4hySmBmePdv3k4+3IwRoihNyzrcNp/mujxpKcfGzjvb+DsOUZmCLMf13F649xPzcXkMaWj5gp8XyZoOuvofG6FdelggEjy6o9/KEjFajtES8OGOSIj4+7NJ4ZqfS84eB2DhtxbHKsWdG7RCttrJ/ezrx+vnAA5oPnSArwH5kBW3MRdj1F7/ucmW5zvw04lt8sN1rQlpoh+1wjkLGt+IrA==
Received: from BN9PR03CA0205.namprd03.prod.outlook.com (2603:10b6:408:f9::30)
 by DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 20:53:06 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::e1) by BN9PR03CA0205.outlook.office365.com
 (2603:10b6:408:f9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 22 Apr 2022 20:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 20:53:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 22 Apr
 2022 20:52:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 13:52:18 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 22 Apr 2022 13:52:18 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v6 01/10] Documentation: Add HTE subsystem guide
Date:   Fri, 22 Apr 2022 13:52:12 -0700
Message-ID: <20220422205221.952-2-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220422205221.952-1-dipenp@nvidia.com>
References: <20220422205221.952-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91ddd315-9f53-439f-7872-08da24a219d3
X-MS-TrafficTypeDiagnostic: DM5PR12MB2486:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2486714CE2A1D2C2648A9D52AEF79@DM5PR12MB2486.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ENKPmpGPE6ffAXDMl3DR8HNeFXmgFbtcMx5GSYDXMP2q85enORtsCpDZrjQl4tpYODyvqEK2fw/q00E0Rwsctm+xWBsSkEgTzWFIbUr3ybS7RlDM/5aFLcQsUaudfsFOK+tTn8LQoZKfSeDkgPew3K/GNxkq9Rpl/hEWOWUU0e3YJ22jfFEpPuWGhTSORZgdWwP2BZY+ZqnWMJu995Et5wm/xXVG+r1fsq+wko6IM1HfczOr9RZR7hvbo9gAauMh56nqXSrnezOWS/t7IJLAnoaXpAuJJ+/4sCMVqfczJj2GUSEAnooLpJejrrrX2hZVZSi6vFQqHtpYxNQKcNMdqQ/IRdKx4uu5f7N39hbe4GWx90TCDx2KJzZhM+qEFEOnypewP/kctEtMLuJzHbx9SwmxfBvpckvfK2NQnveydG9dvjk2rWnTqSyg5MQ5o6ejgh0sO2eb3/mBT2lN7/wpM70VeGMK16wm4WdNqqI0MVWVhP/AFi0/z7bLUI2cjMG2NwcLoJKrgyxyZla7JMzTYTkfbCqmIHPjrmxgx87ZOKK5ZOBn+xvwHn0hhZUCmhJOfJtudPo984Q0oeDIQZKHt17c4IWsuulaGBFQdabQH3BslOyZS0wYImAIxMPTrZSZoCtKUv//WThxqOSxzSyiZtwxRxak6u/0WK/mT5HrSoJ/dD0ElfggGkF6600987gr0IGFbjh9OFIXpr18U1IJ4p/UuIC9Y51wmTxoCmlzWf6fLiZ4xLng0QndguK6lu7uMpwilx6FFby6ujJ3I8240g==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(26005)(107886003)(40460700003)(316002)(36756003)(81166007)(47076005)(1076003)(110136005)(2616005)(82310400005)(426003)(336012)(70586007)(70206006)(186003)(7416002)(2906002)(8676002)(4326008)(8936002)(5660300002)(7696005)(36860700001)(83380400001)(508600001)(921005)(356005)(6666004)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 20:53:06.1219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ddd315-9f53-439f-7872-08da24a219d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2486
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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

Changes in v6:
- Added hte_init_line_attr, hte_ts_get, of_hte_req_count.
- Removed devm_of_hte_request_ts_ns, hte_req_ts_by_linedata_ns, hte_release_ts.
- Replaced above with devm_hte_request_ts_ns, hte_request_ts_ns, hte_ts_put.
- Addressed review comments.

 Documentation/hte/hte.rst | 77 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/hte/hte.rst

diff --git a/Documentation/hte/hte.rst b/Documentation/hte/hte.rst
new file mode 100644
index 000000000000..75100a9bc35f
--- /dev/null
+++ b/Documentation/hte/hte.rst
@@ -0,0 +1,77 @@
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
+``#include <linux/hte.h>``.
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
+   :functions: hte_init_line_attr hte_ts_get hte_ts_put devm_hte_request_ts_ns hte_request_ts_ns hte_enable_ts hte_disable_ts of_hte_req_count hte_get_clk_src_info
+
+The HTE framework public structures
+-----------------------------------
+.. kernel-doc:: include/linux/hte.h
+
+More on the HTE timestamp data
+------------------------------
+The ``struct hte_ts_data`` is used to pass timestamp details between the
+consumers and the providers. It expresses timestamp data in nanoseconds in
+u64. An example of the typical timestamp data life cycle, for the GPIO line is
+as follows::
+
+ - Monitors GPIO line change.
+ - Detects the state change on GPIO line.
+ - Converts timestamps in nanoseconds.
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
+``/sys/kernel/debug/hte/<provider>/<label or line id>/``. Note that these
+attributes are read-only.
+
+`ts_requested`
+		The total number of entities requested from the given provider,
+		where entity is specified by the provider and could represent
+		lines, GPIO, chip signals, buses etc...
+                The attribute will be available at
+		``/sys/kernel/debug/hte/<provider>/``.
+
+`total_ts`
+		The total number of entities supported by the provider.
+                The attribute will be available at
+		``/sys/kernel/debug/hte/<provider>/``.
+
+`dropped_timestamps`
+		The dropped timestamps for a given line.
+                The attribute will be available at
+		``/sys/kernel/debug/hte/<provider>/<label or line id>/``.
-- 
2.17.1

