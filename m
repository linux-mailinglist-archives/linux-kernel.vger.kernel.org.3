Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ABD564F82
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiGDIPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiGDIPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:15:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89144BF64;
        Mon,  4 Jul 2022 01:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNsxPnvnnlVvQXTpnZq8PQt9rnNGExbA8dgHbzlCl0lqjyIOgd4jvqZNAx+fTUTQxoeagam9nJdcRhQTIxa0IbE5+pM3yxrQKLB31hVUqBVmA8SejFloc94PGxpjLy4vpMzYJODpzq6V6bkKf/uTN7KjnN3hne+iN0MzlohryCBSHDpxe3WZJ+0Qkjb24SlFQY9tc+2ieGRQN+rPzBxbpSyLtuv9ByPcNXk6IiMkousQEVfGyhAXbl8lmFa6Xu+YVh7wQsT23gaMWBKIf2OOzz20LNByvIy0M6Hrr9Ixa/d/q730aH9kB+QRQmeXnAcSt+xvR552p2aX7M0DzdTVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeLOet+QJ/Hmz6DRh3RFdcMlxSD5v2N07EybnP+/69o=;
 b=MNPjq/70Lfhvpi33mFSgy8hr5T3YKqMRKDdcfC5DYMyyMFgpnW/yRMRnY4+n7p0O0K6yAyTo7Vu/SZW/UFplb2kB/Z9A3WMwAEknzoS2aXxCDrmjqRdgcHWbJwIHrJ3ZYsipFRQtRls5hyZCcLw1t/nVKKeh6bZnzR9GYSHl040Q4mYBslnFOSM/AAOPvj/2fGNw+XAnDjjBIegChdmBOfXm00ULK6+/S06fIbSv2h1HzCDdnCVwTYgI5CDjyKR4dqW1tdCH8k8FSxT9YbroT1NRHA2fWAFPkxRHx87xCyg7xgn+zKH/YzoH4aor7WzoH6pfuESkH3eWzY8MmnX0gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeLOet+QJ/Hmz6DRh3RFdcMlxSD5v2N07EybnP+/69o=;
 b=i3//wkHL/hJuDhaFF8GYXEiEddl2vZl/PigrXx+01JMhnLVc5PGyHJdJIy5kLUAGaH84qaT4i0GV2cENSYkm9z0ZORJL0hXWfaKbfhQbp5ODaBeG4H2QFdKsD8cPo5vZ01gm2XNq1uo7G7DZu2PLZqHA/DQTYXdulDeaHzr/fgvqn8fNVbBV40Qs5jasrURjmBPBJ9Hgip/Siv/Eh8iapP82yVq9ZkEQDQdNN3nosEtWtSUCc+PmwodjedBN8U7eVvIa4ci7ufLRW9rmbXLD35O7JDEFOL77cSMgImB1qAfXtyKeESEhHJGCofeInRzI1ePD7l0ZPS2W9pNqouVC+w==
Received: from CO1PR15CA0095.namprd15.prod.outlook.com (2603:10b6:101:21::15)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 08:14:09 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::62) by CO1PR15CA0095.outlook.office365.com
 (2603:10b6:101:21::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20 via Frontend
 Transport; Mon, 4 Jul 2022 08:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5395.17 via Frontend Transport; Mon, 4 Jul 2022 08:14:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 4 Jul
 2022 08:14:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 4 Jul 2022
 01:14:07 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Mon, 4 Jul 2022 01:14:03 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <mperttunen@nvidia.com>,
        <rgumasta@nvidia.com>, <amhetre@nvidia.com>,
        <akhilrajeev@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <sumitg@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v3 4/6] arm64: tegra: Enable native timers on Tegra186
Date:   Mon, 4 Jul 2022 13:43:40 +0530
Message-ID: <1656922422-25823-5-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656922422-25823-1-git-send-email-kkartik@nvidia.com>
References: <1656922422-25823-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed13e4d1-6727-4a11-8fb4-08da5d952be7
X-MS-TrafficTypeDiagnostic: DM4PR12MB5357:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C89cSMefzxrWYt168qSO0qe1T3ims7R/0Maum+GIxxycu2rfvuqy0/oCqnCgB+gUS0Sjl1UQLEaFdSD5azzwL3IRHlM5uiZfa6AsUpsj9OEKgmcS53+jwc30iVJ1o4kLDEzgh51KVCSquy6gtqOFZUSQoQ+3AvsAaZ345XgFJCgn0JLmpFEUKQYEBhc9cqjCoP9f55kU8ELCBgB+dncpM+rQCvx+Lbioc/KC2Y2s4smLXJTo3h1FPZvm74vWYcJPZO4DS1Xf2iiQY+f8vlCnaUf+CS+7Cy8i3mBL7+L33WQXDeVN9SXni6P39KL1PDCxgjxNQBsC/EOSU093S4ZaF3AEZJoHhrpuMZ/4B6ynkQBeVcmDpROUgU38+fWqAyro6j0YpO94OFVvgMmaB8+iy0FX3M9DrWfAXt04vyL5eSzwWSaT0/a+VvDe6YMMUFg29ji0pI089ol/CgwqyHUDZweNgGn1ecvFnMjH7ODWHAGRfqa3/7CR5mnnAVFufjUuKeLvcUY0cJdwuelNvTmgQruCkYWu7p01bW6xN3Z6mL4weBG/RmDmaBL8SxfPzOhpv45kpp3D+q1UybI0c+OjpUH/qhCXguJa6+HLWRD9QLS86+gbDFgrjGkNKu6P1MvuDzPk/gFv7ffb7DZSp0/8ZjdRdVcbtIQIiQC61IwfnK08Rcfw1GdTESUTlPlLzaJGxrUb8D+Ia4ONCzdEPATe+dSYBczfRgUy4sKl4L3Hnp1eQr53v2CjYbjgKxOtReG7UXJznL3xp5E2gEUbf7ZbeeQp0HcJhV+9tnbg92qTa1UznbhDz8C0Kmn88h7DCI0hDQhBSFvwMy5GHWRr39RPad1xXGf0hUshYCp07h6E/OXoEOyIxXTdWQG5DCEz16tV
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(40470700004)(46966006)(36840700001)(7696005)(40460700003)(40480700001)(47076005)(36860700001)(426003)(4744005)(8936002)(5660300002)(6666004)(478600001)(336012)(2906002)(356005)(81166007)(921005)(83380400001)(82740400003)(110136005)(86362001)(186003)(36756003)(2616005)(41300700001)(26005)(82310400005)(70586007)(70206006)(8676002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 08:14:09.3358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed13e4d1-6727-4a11-8fb4-08da5d952be7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the native timers on Tegra186 chips to allow using the watchdog
functionality to recover from system hangs.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index a87b52434939..a07acdaf345f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -599,7 +599,7 @@
 			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
+		status = "okay";
 	};
 
 	uarta: serial@3100000 {
-- 
2.17.1

