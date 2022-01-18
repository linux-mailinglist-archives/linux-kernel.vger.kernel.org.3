Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498EC491296
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 01:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243872AbiARASs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 19:18:48 -0500
Received: from mail-bn7nam10on2086.outbound.protection.outlook.com ([40.107.92.86]:14752
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238466AbiARASm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 19:18:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToTUmVm5QQkL3MJ6P+f7NFrJjnqShjfP+Kjk5arpwc0MoO2BBSMNGrS3cV2GApuLxavtiCS7J9tl56VbOSYFnzDrPMmqvaeFMllyK5CgOLQxctCwvh6ApPacMnz4zKJ/vows6mmNMnmi+rBv6+F0UZ/RULnaV4tBHIKzvvHvrAAQ+D8cmlhVuV+QfQIK9fUOu1Z0VzI4/+o1pEwCXst44rcmzCs79qwU70uxRZG/qF9ZD6Z6P+Dh0OquUnWGx4Vq2yUS1Xzy+o9zOHdKGXRSKe0MUu7ApxEkx6hoXOO07UBbLhBSR22YUMmC8lV5GE4KdAWBGrcpiSeAhKQ8yX/d0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOUjm4cGKB7ebQSCwjMFXei8vUTXVa4NXxhueZB+HuQ=;
 b=SWqdFrl/MiIy3OZQP6DENBNyzXPfOIW1nsI6dV8EDYnUcG4zhErMSYbOeXzwA/WpN/MtymSQVQXr3d9jMRaZTAc9BFp0KSHCZIoaPQ1MXLKE9HR7xpFCYmhA25Ax6kCxi6OfvySZrJNVw/47QDfDeO3jhS9WmKD6z6OuU9Cc6aZ0btrVeiR7gmaAoNJ2ti6jcGn6SzyLaIKeu3wpMMfHdhMWo0grcNaBxNR8bDr5lDDM3zq2ydMeJzmuD/6AUeEkafJcZo3prkJ27TLF/qLMmbV/LkfHny+6zck4HaYXYY/vBAfkVJ8X7ew/CtkYSNHMVEHYMzv4FXs6uvveDvPCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOUjm4cGKB7ebQSCwjMFXei8vUTXVa4NXxhueZB+HuQ=;
 b=HzLHTIIjAsAaY4TqEyVwD4yFGYecVbgN+lnvw3OqBC/fqr0+SwmNAbTGR55pMHr8SOMaBI4ruWnw/p++jjL9uBSvaGeuJKjs6Ognsi32tA0QQVkLNJ/0WmkiPU6WRvA9n3EhnfGFIt0w9SB8FeCQ80/RHxU1VcHhyzdGSNmwCGd+SK7/vf7yxW+caJZO72Kb6iHYtkoOE9PbTNu0bgFRpEn8DhuWToFBmL+Bhe+WCjxMurEC4F1NKvZ0XZQOspG30DBbUdVXkjXs+PF/LHb1pvWiJqxufoaojyoZxcmHJg7iE4TE2NZq0B6SPWWYeVW+IXwR/SIeLQKRd6feqmtIAg==
Received: from CO2PR04CA0087.namprd04.prod.outlook.com (2603:10b6:104:6::13)
 by DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 00:18:40 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::f3) by CO2PR04CA0087.outlook.office365.com
 (2603:10b6:104:6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 00:18:39 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:39 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 17 Jan
 2022 16:18:38 -0800
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:38 +0000
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [RFC v4 01/11] Documentation: Add HTE subsystem guide
Date:   Mon, 17 Jan 2022 16:22:04 -0800
Message-ID: <20220118002214.18271-2-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118002214.18271-1-dipenp@nvidia.com>
References: <20220118002214.18271-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6572184-5682-4d73-2d6f-08d9da1813f0
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB266702AB9FA212F7C3002A03AE589@DM6PR12MB2667.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tin2VCfADakOxXBQKPzYtMNJjS1vWbDzhW1Lvpwvd25AlI3D7V31c/MlCf2eBow5LgBv+kJkw1FxVsCzYjoH/F0hHMGuvGi7r3tipohW7Yqy0MHOe8uuSfZ+wVTfIzxOCY9E5vlfnW4TogmVuCM8I1+xL2hezGKl+YkXMP8HNPPioqiWQZpdQKEJ2zsZCApwISxhNsByZVrbKsiU8v4zvA/ZBjxkVW0wN4ywLa3UcI9XNM8ce2MirT7XOPlWw26kb11GaS8ju+yXwFk1kPIMxYv7Ve5WVXzlUJQtaML3V4DR8r0BIaBXo9LgPSqzU2hoY/gPDX9JPCcBnZy13aY1oVmw1f1TWTGavJlo+tbPiqLi6RsNUZIXX4JLOtkvp3yH0QG+4d6p4UnniVaC8mBZIpSXOrCBZswzdT1ZP815qEpNyDBIHfTLlcKQPGlMtxa1mmKfUPwXaJvvNngS1tcw0LugjhHAGiUkdaBJURpXBtxNGgtqSCRwE++VpMNcJHuzcWT1voTGseWnHW+bWTpa1zkAAxj4uaqA9F1hjvGEbZfLjbyi5J8lkKwKMWpFt+D3dZrkBgTsOGroBgbTijBhmpabTYfke7BsHvoqD2OA0VT5ZjmQknTSWadKqTqXCT6f0UXwhfQ4X3BlcePWLBp7qsIs51nHJGBJwuTxuXYK0KW2OsQKgt+/iVNRbCEBR+vqwaply+2fjucmmPkuMfG1I0U0xeyhcalI97FHtNO3dgCxzOOqPYs2jmOCqiQsAiNxzfqGYILEF9avwFU/o3QAs07yTarB/Cy/fo3U9Op/T/vs1y3Tjpkjno2qYeywMD+QPEYunXeGvXGnIwdqWK2FWMIMCkLLWZKuMPne1J3X/mg=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(107886003)(83380400001)(110136005)(47076005)(36756003)(921005)(4326008)(356005)(2906002)(6666004)(82310400004)(40460700001)(70586007)(7696005)(336012)(316002)(26005)(426003)(186003)(70206006)(5660300002)(7416002)(81166007)(8936002)(508600001)(8676002)(1076003)(36860700001)(86362001)(2616005)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 00:18:39.7119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6572184-5682-4d73-2d6f-08d9da1813f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2667
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

