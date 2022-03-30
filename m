Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7324EC6C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347005AbiC3Oko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346998AbiC3Oki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:40:38 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2088.outbound.protection.outlook.com [40.107.101.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F673546B9;
        Wed, 30 Mar 2022 07:38:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5Scef/kWAQpcbG/b5wL1ba05esITw3AAqB5Ifi3LOOkrKZ3e1Y2zPHl4eyAtjE4VBqrm3sgxqW91EQ5PpLP5eiDx4GAwn+6CIXFi4Peu9cC/oHWt57cDJS5PjLQp5H3blsOD6MooOfRTn3MBqgZdqU9FiAo3FIslA93ckq+VvpnEFV0M5PVhl6/JLUXk3eXMXMhcFFxUedbp1hZq5jyFSRm3uplleoRrgmvQBMREKxHpk4GEIZjikatfyXkYuRytkK8FwwHihEHEDXTnHQkFzho+HzGYarpc3iMgYS2L5As0gzzBibcbasr49MIuxAgJMwPdZUWP8YnKhZrAVTaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jiZqiuA4bL/Xl4sXyXV/fFxhFrzn1JlNSbgW6WB1YI=;
 b=TA+vsAlxnoNe1tzFTbqcOVysq8U/Qin0D38CxuscO5S7GCx3Due9+hhax5/I3MQzXEmvW0qPIAJ6mBT5GKoVUAoLGqmPorvX7IfR8xUvbfv3cVuWSeHf5fHMlazjVFFJeNbaN/iGIax3sKpVzNF4T+xFMzVKjQYA933zMw1+7sYh2oYwdxesaOwPV/3N3ai6gTqcZ68KPtCcW4YW/E7D/9LUDuUXU1vaQWrvoMHOAroT0lKVn3aUCd4YpWejUPq+5FFhx8cLww9hiDRCXLIApqRbw1Syx+Ur4eLAltpPLvM7DWe/cejwrYO0v2COxf+n4O+tphIlPQr6JHT2uPe11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jiZqiuA4bL/Xl4sXyXV/fFxhFrzn1JlNSbgW6WB1YI=;
 b=f4s3MBvus0LOjo6yoEAXcHl3SEjzlTwUx6JG7p1q3T4Z6SbsuBRGdg8LkYyZbmxo81T1AaftY/843uQJo4sJHn5ppvZdzudnj7KNpWdzlFWkY8zT/gQRTV9l96u8CjQkAuztIhwTtMZIfC6BjRrxD2rMryk++/kcuW7huj0wWqcHdRsg7nqFkJnYObUUNwPCwR74qATp0XTUDkZeV3yJ8TjqMoDryzIEFoEE63Uj2QWKX71+99mIMj+DtJjXlGe7Vm6LmqhXaxXjrj3LGpo2h0ns6GEzwK9UKjB4MzQnfutq9uo0O8+w2t3BlsZPH0203y65Zx37xtq51bGKn+kWRw==
Received: from MW4PR02CA0003.namprd02.prod.outlook.com (2603:10b6:303:16d::30)
 by MN2PR12MB3150.namprd12.prod.outlook.com (2603:10b6:208:c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 14:38:50 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::43) by MW4PR02CA0003.outlook.office365.com
 (2603:10b6:303:16d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Wed, 30 Mar 2022 14:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Wed, 30 Mar 2022 14:38:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 30 Mar
 2022 14:38:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 30 Mar
 2022 07:38:49 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 30 Mar 2022 07:38:45 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v2 3/4] arm64: tegra: add node for tegra234 cpufreq
Date:   Wed, 30 Mar 2022 20:08:18 +0530
Message-ID: <20220330143819.27476-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330143819.27476-1-sumitg@nvidia.com>
References: <20220330143819.27476-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1c2cbc4-06ee-4b60-d467-08da125b01b1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3150:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3150AB53B6BDC906D1A29B94B91F9@MN2PR12MB3150.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Ylf41GvlWdf1x74EmHTobTzy6nL4y3wBzz2etccQxLhrXWnj1U/p1DS2dI4ey5gzSJWN4PxdfLT01RfJk0/udSld14tsyJkECHl8jT6hgtvKp/3eOGzGjb3bcX7Mmryb6jINWGkL8ZyvlFjtn37NkeyfcpGo2uL7eLhcaXZW4uWaltewWNbTjnufhOjitlApJkyz48Gn+zfAzYQN+hHpqelR+iR5H2jw2ityNdFB5PmAeamAOQSDLfWOec5KnSh2IzIiHcuD/x1ss6A8Zzb4O/uW+mlLQmeOFPB74watEE25sOrYHZ7mCUPe50LD7OH9xBGXfByd1a9uI5i29x95eIL35A4EzMSFZMnRRyAhCe0VoaO5pk3XYh/wb0BV6wkRQKemm+K0Rr9bdzZf4yvyWqd/FdH+nv32OSZWx9Sd8s2/rvrtldGRApm8g8PkBWEa8VUhfkSJ3/wp/xoTRNHXSbSNQKJsEPUWrZRvKjWkp1+v8SggmdnYhPuAwX22cl4J8wviEC4FTAyfsJDtPgYITO05F8HWxUK6uaRVmZ3EUmvJgzZYNh3aQaImOBh1+YwdwvPE7po0AdJgJrJTtt2tc3DDT5VzgdZgQtTs3tZsVNEa52cWAm0tHm32u+9UvQLP9yHiLVAXpN3YEN2AIdm6pb1Ska92EoVol59FxdGiG/PedI7cDgQP4dmt3E40NbWTinh8x0SU0t0ItJSw1PlXaao4ep0rwIczxWmD4PoijU=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(1076003)(26005)(40460700003)(110136005)(107886003)(2616005)(336012)(70586007)(70206006)(316002)(54906003)(186003)(86362001)(8676002)(4326008)(82310400004)(426003)(508600001)(81166007)(6666004)(36860700001)(8936002)(921005)(47076005)(7696005)(4744005)(5660300002)(36756003)(2906002)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 14:38:50.5008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c2cbc4-06ee-4b60-d467-08da125b01b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3150
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding cclpex node to represent Tegra234 cpufreq.
Tegra234 uses some of the CRAB (Control Register Access Bus)
registers for cpu frequency requests. These registers are
memory mapped to CCPLEX_MMCRAB_ARM region. In this node, mapping
the range of MMCRAB registers required only for cpu frequency info.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index aaace605bdaa..610207f3f967 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -1258,6 +1258,13 @@
 		};
 	};
 
+	ccplex@e000000 {
+		compatible = "nvidia,tegra234-ccplex-cluster";
+		reg = <0x0 0x0e000000 0x0 0x5ffff>;
+		nvidia,bpmp = <&bpmp>;
+		status = "okay";
+	};
+
 	sram@40000000 {
 		compatible = "nvidia,tegra234-sysram", "mmio-sram";
 		reg = <0x0 0x40000000 0x0 0x80000>;
-- 
2.17.1

