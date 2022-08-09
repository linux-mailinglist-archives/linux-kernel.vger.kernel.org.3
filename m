Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7EF58E118
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbiHIUaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiHIUaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:30:16 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2054.outbound.protection.outlook.com [40.107.212.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9762BE5C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:30:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLAkSdlsHbawIV0HomYW8rI/4plvogbe0IfX5NzaCA5O1Y1JSaRE72NLnrQqnhkx1St89DFioSoO36UjbLDd6d2eMKtT6omW6aAH5e1lZ34enOXfvx+D5Xr6T0meGJOCnIGfCHNC2ACkyJ71keCO+Gr/wqBNMVOHO4eVkgJiqTUzH8aQdq07BQGVwlMXm6+oWvyFYz5xW2OW8tpl8lBxNGSp2p4JVCSxK4Z9otlsdBW0EeSJBY7JPryNPAvC+1rMAtAT7BYErlOJij/wRMb0XGwC7mVoRX4Ulur2vd4/GScE1MOF53BOPfKuyy1qSC17zCFwB199Fch9w4zJCSwy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWM8bIbkFQ16Gy1RQdq1jhfpdugLZk7AFzv0mPueTWc=;
 b=PvO/CqLDsWS7FQzSpDgp1nm7ETvlrg4yaRWBLjCEIsA9I+zzp8HNBc2yfK8tiqiyviXBkHaHSkwLKXSAdRDq5f/VRJuBroNxE61lD16Sw4e4LCzoOJdAJjyDVa73otKw0ntjs3RMnXNd5cy0+ZVWKr9Q1vrF08G4p+cIWxFYXwsjqtnJ9Yx/Xel2Zix54mR9Si8s1JUudVlgRw71fXDSmhHky7tifah830nMT0GIvdtu3comJzgUVL7aD3SuUKwL8GW58WeX2w09Q6tP2MWrZBxGY+LKoBXVy0IOdKu4jF8LZndDFkmGP3g91AV8D/uyb6lfOpj3sZpVzjJ1R3aNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWM8bIbkFQ16Gy1RQdq1jhfpdugLZk7AFzv0mPueTWc=;
 b=5P2w8ALhBnEJmlaPCQq//g9odsFGXJgRVQtkXPgXq4Yf9IG4l3h6GCpsPETMoKL+r6Q7BrZJk3Ftlxnzc9Ms9tE/twwHVdxcHu7PIi6R6u5rY8IcIFOzR0nPzepkX43HSYC1HSLMCXo+eH2YTKvrouqwjDIJsBKFPgNocpRYFeg=
Received: from BN9PR03CA0034.namprd03.prod.outlook.com (2603:10b6:408:fb::9)
 by CY4PR12MB1253.namprd12.prod.outlook.com (2603:10b6:903:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 9 Aug
 2022 20:30:13 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::e7) by BN9PR03CA0034.outlook.office365.com
 (2603:10b6:408:fb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Tue, 9 Aug 2022 20:30:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 20:30:13 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 9 Aug
 2022 15:30:09 -0500
From:   John Allen <john.allen@amd.com>
To:     <linux-firmware@kernel.org>, <jwboyer@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, John Allen <john.allen@amd.com>
Subject: [PATCH] Add amd-ucode README file
Date:   Tue, 9 Aug 2022 20:29:50 +0000
Message-ID: <20220809202950.297935-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96bc4f71-871f-47b4-95da-08da7a45f66b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1253:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UB3q7lVhI3kHfvXAphe+KBXUbwYJ0SQ1M+xxbeWwhR2qL46g2ULgdSVyKAAMO7NVZpNHwfgQ1ZB/YHXBxf8fNMJRYcAS14WMykJDCg7qsMDPuwKI6nSonro6vB+8cxhA6AcHM4jnhiAeB1LhIQoMhFNxxgi1hYKiO2XdwIzIvmNKVE6+PNhvi9Z9dAY89S8O+JXYnVow+vUI91nBNTAuQOCPj5XW3Xavhc6e1bQJ9l4bq3WAFrk+WkFWNTrC8Hjiy7GtyTRD5i/rPaoAzKcbIGeiW3i58V5L/c46I5e7zBWlflN6VXYxmlyQlqV0d0Dc+ULGoET8ghXNkoGn1oEsN6+pLIVY4rS0O+3MarU/3XiRCJCTAjk4Ldx6tBxHY5eBq7jm4ZY8lwH4yWnVno8ecsTOj5h14lJITAa6fZRLzyCEXCSY+NW0Xm6RxO/xgQgVnEQW+1J0z8Q1E8/oJZvmeQTxbOWqWVKU57rOdnHABJdba0LTz34/rc7Ry6JpCodE/GtH/pYnPcTXodPjyNFV33M4WpYMrWValL+FxfVUZVw9XvHViw+iv8aplJZY84xAetkR3ssLjR9CWQRXsyV02GxieGdBoCpNfLvoWVRHrVWKWKHs+M2At2O4RxC7xLjsS8mUA+u7qIAUS0fsqywt1/w44/06t1gqm7omEzSxbGtDucQqiA+i/psZe7bFGTxP/DcloxNv2XqKrehXnsx3MKCwsV69G/iifwQjZXW0WSk2IHili6wAgNkVxyXbJHsLzl0dM3ScnTUsONMiA8cr1pT5kwBdgX1FAAMKhD1GS4A+Wr1yiX8XVPqSrq1K21YGUkuPbNFakPnLOZ/ntHpu7FiP4sj+F3WJcVaiMU1TdKuk8uCB/eBA5aAdzcUu9jIK
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(36840700001)(46966006)(40470700004)(316002)(70206006)(5660300002)(8676002)(4326008)(40480700001)(54906003)(70586007)(110136005)(40460700003)(86362001)(478600001)(186003)(82310400005)(44832011)(8936002)(2906002)(36860700001)(36756003)(82740400003)(81166007)(356005)(6666004)(26005)(41300700001)(7696005)(426003)(2616005)(336012)(16526019)(1076003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 20:30:13.1299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bc4f71-871f-47b4-95da-08da7a45f66b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1253
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create new README file describing the microcode patch levels included in the
microcode container files in the amd-ucode directory.

Signed-off-by: John Allen <john.allen@amd.com>
---
 amd-ucode/README | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 amd-ucode/README

diff --git a/amd-ucode/README b/amd-ucode/README
new file mode 100644
index 0000000..f1ad2bb
--- /dev/null
+++ b/amd-ucode/README
@@ -0,0 +1,41 @@
+This repository includes microcode container files for family 15h, 16h,
+17h, and 19h AMD CPUs. Microcode patches for families earlier than 15h are
+included in the microcode_amd.bin microcode container file. The microcode
+patches included in an AMD CPU microcode container file can be listed using
+the script in the following git repository:
+https://github.com/AMDESE/amd_ucode_info
+
+The microcode patches included in the container files in this directory are
+listed below:
+
+Microcode patches in microcode_amd.bin:
+  Family=0x10 Model=0x02 Stepping=0x02: Patch=0x01000083 Length=960 bytes
+  Family=0x10 Model=0x02 Stepping=0x0a: Patch=0x01000084 Length=960 bytes
+  Family=0x10 Model=0x06 Stepping=0x02: Patch=0x010000c7 Length=960 bytes
+  Family=0x10 Model=0x05 Stepping=0x03: Patch=0x010000c8 Length=960 bytes
+  Family=0x10 Model=0x09 Stepping=0x01: Patch=0x010000d9 Length=960 bytes
+  Family=0x10 Model=0x08 Stepping=0x00: Patch=0x010000da Length=960 bytes
+  Family=0x10 Model=0x05 Stepping=0x02: Patch=0x010000db Length=960 bytes
+  Family=0x10 Model=0x0a Stepping=0x00: Patch=0x010000dc Length=960 bytes
+  Family=0x11 Model=0x03 Stepping=0x01: Patch=0x02000032 Length=512 bytes
+  Family=0x12 Model=0x01 Stepping=0x00: Patch=0x03000027 Length=960 bytes
+  Family=0x14 Model=0x01 Stepping=0x00: Patch=0x05000029 Length=1568 bytes
+  Family=0x14 Model=0x02 Stepping=0x00: Patch=0x05000119 Length=1568 bytes
+
+Microcode patches in microcode_amd_fam15h.bin:
+  Family=0x15 Model=0x01 Stepping=0x02: Patch=0x0600063e Length=2592 bytes
+  Family=0x15 Model=0x02 Stepping=0x00: Patch=0x06000852 Length=2592 bytes
+  Family=0x15 Model=0x10 Stepping=0x01: Patch=0x06001119 Length=2592 bytes
+
+Microcode patches in microcode_amd_fam16h.bin:
+  Family=0x16 Model=0x00 Stepping=0x01: Patch=0x0700010f Length=3458 bytes
+
+Microcode patches in microcode_amd_fam17h.bin:
+  Family=0x17 Model=0x08 Stepping=0x02: Patch=0x0800820d Length=3200 bytes
+  Family=0x17 Model=0x01 Stepping=0x02: Patch=0x0800126e Length=3200 bytes
+  Family=0x17 Model=0x31 Stepping=0x00: Patch=0x08301055 Length=3200 bytes
+
+Microcode patches in microcode_amd_fam19h.bin:
+  Family=0x19 Model=0x01 Stepping=0x00: Patch=0x0a001058 Length=5568 bytes
+  Family=0x19 Model=0x01 Stepping=0x01: Patch=0x0a001173 Length=5568 bytes
+  Family=0x19 Model=0x01 Stepping=0x02: Patch=0x0a001229 Length=5568 bytes
-- 
2.25.1

