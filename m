Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972BC50083E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240911AbiDNI2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240853AbiDNI2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:28:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1DE38784;
        Thu, 14 Apr 2022 01:26:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEtB3kdGp0Yp6sKmSSjs4vR/qm2y+Kg6ASWDQXT8/qQSOqH8QlW5MW7Ehj9FopW8coBvO6BHH2HzUR7hs0TJHIKyORc4wTZFMP6pz9Jm0ZDKUQbmpj/7aqYsEcmyV3CFnU5+O60M3xezDPi0wUlV+lLx44K35nmYuNKCaL5N0rfOsExs4rNpS0gNnPV7dNHf2S4T3CLKmxO/cA2/6dufyuw05x7C+NJi4gpvuWupuOTsCdnAuZtWTRX9izh1SDJzfNzl152bZR1en2CQjScIWZNZtED7pMOMXaH+Ikq6jfmTxUg9GSgQTTszLkxIFsawE647QQc1sjm687OBJsiO6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7bc20+NkX0dQ//Rc5wraQOWWtAtCCBUoN/hzZtc1LY=;
 b=QvQIF/p0/s4xPW9m60Tf90JJsDQuiB1SzU2djWhpRXAdlzzuCvI6QrzdOhJ3cJEr8QON+2TxQHx1XInXopKPFz0+U+Z3NwzrQj+VRGtmrJrM0YUcDNvYhL7C89gOqwRkcJ4VRX880jxlG/v40eSxjx2Sheeo5UyWXQvzeeYiNxTiMF3eu9jinwMxeSt+xixYV9HW3XB12ieb14LqGCh/X7uSN04idpeZ9DKZUGLEmE1NDhfXkzbgQLqsy1JKnUdi1w53b2JEhRmIPEZd/2sdGUWGsZmxkQh20JnchdJwF+ByugCSzEXtVVH4gnQQlVWFPMthn7eDjXZtqGwAbK3Qdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7bc20+NkX0dQ//Rc5wraQOWWtAtCCBUoN/hzZtc1LY=;
 b=BwuipoIhPTRfdjOomXG3J6xO9Ab0Ui+2TYSlsFva9vU4ADhamp+qvCiwIBJF+/Hzryw8XfpVpY5KlhVzFoHwdGA/nkwWG7CabGmMLpmslRAMVHjmcIZBsBW3OIzg8vi3PVLTaQYBHOxawwPNQuXhbBcxo6XZHfgXSN7f+FjBHoJINs69Bg2SqOv+11t4F2q5BO/UloK0QWfw1rSwBBKa1kRywbyMCU+fglS7GeU5FxeEgJB9G9X0x00dwEtmJ7d8sj2Si4SzL6HzdBqTVe5hHnN0UsSaDi/JiakQH09/zs1/BJgC/ezQycgRehnyq7djwFZAa4EMPENKCB3/VCjNwQ==
Received: from MW2PR16CA0053.namprd16.prod.outlook.com (2603:10b6:907:1::30)
 by DM5PR12MB1388.namprd12.prod.outlook.com (2603:10b6:3:78::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Thu, 14 Apr 2022 08:26:06 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::2f) by MW2PR16CA0053.outlook.office365.com
 (2603:10b6:907:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Thu, 14 Apr 2022 08:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 08:26:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 14 Apr
 2022 08:26:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Apr
 2022 01:26:04 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 14 Apr 2022 01:25:59 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <akhilrajeev@nvidia.com>,
        <rgumasta@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>, <mkumard@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <kkartik@nvidia.com>
Subject: [PATCH 4/6] arm64: tegra: Enable native timers on Tegra186
Date:   Thu, 14 Apr 2022 13:55:36 +0530
Message-ID: <1649924738-17990-5-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649924738-17990-1-git-send-email-kkartik@nvidia.com>
References: <1649924738-17990-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 931f0d7f-1661-412f-3f7a-08da1df06baa
X-MS-TrafficTypeDiagnostic: DM5PR12MB1388:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB138859C673413BCEDAD801D6CDEF9@DM5PR12MB1388.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cfx18GjQ281xcXHC+1Pw3hEUpfcibJVkigIAszzmhrySZZQWZUxKZrktdm/ig/5a7Gj4znQTxzh7LDmgFuSHhO57IaDTnfPq0gbFUN7lcJCWv5rbGZI07Mgh1qRNXReKfNAGp9pwHH6uSC6YYp18jkrcQb1A1HfhR8kq7MsozIaku7ACRjCB3Vy8OXw3+S2cdGS6Adb5lyYmRBbUegnNjf+xsw6MY1bj71z/UR/gqYhc3fH40JSfnFX4BUSWb8QtDQHQfDCuoyKb7Ak7q8nY1RfBbjq1Bcieyy1MQmeTTHMLXaz1zTbwRGg31soSaAQuDwoEwXnetQ3ULASN8N+AQU5Q7JW+dwJSJ+aL0pGqbsm0ipB+0s0LYnFakcKPabOmxRSMRMEo3fs/Z2+hXjiZC8ye3BaC+qvSqstL4ZuolzudZUWjmuapV9AE5se6dNKITH4uu+T61CRqRkayan/Yd/N0Y8/0D5Xp+NbQgssPib2RZM6mlsC8ARgQUOozOKjZ2iHdsrWv7HxxmxXHx41XOMbHQhFYVvKOfrzg+WnhQZmUI7Tf1dnx/MfXA728ET1ZbY+UigitxAMNnfdvqu28Cl/kxf0d1ImnuZBXFKjDM5GSDVcnKbAnQ2BqH5E/kqZGHsMRWcWSV5ElTqYfI1xi2STCusfHpq5k7dlFdIDXV+sQJMa90gTZ5wE26KjGwjFNrqJGcodFiTw3ZaELjny4Rd3EBTuJmu9cabcPTe2DYw4=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(110136005)(4744005)(2616005)(83380400001)(8676002)(8936002)(40460700003)(6666004)(2906002)(316002)(7696005)(36860700001)(921005)(186003)(82310400005)(356005)(70206006)(70586007)(5660300002)(36756003)(508600001)(7049001)(26005)(336012)(86362001)(426003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 08:26:06.0772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 931f0d7f-1661-412f-3f7a-08da1df06baa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1388
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index e9b40f5d79ec..9969eaa39018 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -563,7 +563,7 @@
 			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
+		status = "okay";
 	};
 
 	uarta: serial@3100000 {
-- 
2.17.1

