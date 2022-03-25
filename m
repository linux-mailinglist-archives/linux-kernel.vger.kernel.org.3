Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AC04E70A4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356936AbiCYKIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358648AbiCYKIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:08:34 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E62D080C;
        Fri, 25 Mar 2022 03:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8mN/k9tFFxwszTV/FjOrJc5lJMuhW6gUqUk+I5g4Acfq/VzvB+kD4+HdIDUMSYbNBeThyjVjF8V84ZRSrzH3YUISEMopinXP4oyPpeOqRX+CV6mgPoYOpUNL07y7ytqtxN4CeSfDNT78C4mgwbgvDHujlmKZiW3cfRo2QiyZ05QctMdGfE61DnMw6zzrkRwiDweJEAmPTxtkkdXyyqNINKbzgK82/ofuIUTW+yL0zqT+oHDb20zlJGpKZMxt4RIfEnHiWd+Tyxkt+osai1biACckAjUbQvGCZSMg7wSWOgVSBrZGVGypYJ8v2FEjylC0B1ok49G1mv0gNmB0CCsCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7p4OLwNayPv1A68tMspXYk5BPncr/SOa0FNurPL3ps=;
 b=Svc1xWVEQoSumWCR7U6VX+dgK/GWVVcu35gjS2Sr0oP6KFJ1LralDHkw611Vdv4oJaIX1ihUoFfcAY2cI/jESsijdfATbRmQ0CIPcVoDV3zZXzxU8j0id45EbdoitVDcDwXtghMmkEm3yvqifqcd/VUsctRydoKJ6rdmZCzz8bjBR1u0uOn7OL0gyFePXbgTIRr0hNGL4PC2cs4HB+LjUXUVBft/Nfu268wSewsJ6zYXAlLcy2lvtM+5Wgd1qp3o5/qyEZs3U+VFoC5cTXcLp3m3uu9SJXGYohgKTrnoefaE1YsWGHFioZiZ2jPCjxlSl55gXRdJ7Df1sHJ1dsPbUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7p4OLwNayPv1A68tMspXYk5BPncr/SOa0FNurPL3ps=;
 b=JrAHNz9rUefrhcotsn3zZ/SszmHsKZ6kWzg/Bw1fs5Zz2vhNVsv5eBtM3S8iOQkthcQIyflyIfKWdlcDPjhbkzqGzXnRWssstNKbBsomGmn/iJFdtJrgjrTjQ8MJ/1RPaHQKM+QIuYGDvucuGL3Yg1AFG2n3ZCvzRrSgXOLO8wM=
Received: from AS9PR06CA0136.eurprd06.prod.outlook.com (2603:10a6:20b:467::28)
 by AM6PR10MB2423.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 25 Mar
 2022 10:06:56 +0000
Received: from VE1EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:467:cafe::80) by AS9PR06CA0136.outlook.office365.com
 (2603:10a6:20b:467::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.21 via Frontend
 Transport; Fri, 25 Mar 2022 10:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.203) by
 VE1EUR03FT049.mail.protection.outlook.com (10.152.19.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 10:06:55 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 25 Mar
 2022 11:06:48 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 25 Mar 2022 11:06:48 +0100
Received: from localhost.localdomain (10.167.1.162) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 25 Mar 2022
 11:06:46 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <robh+dt@kernel.org>,
        <tony@atomide.com>, <bcousson@baylibre.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>, <Gireesh.Hiremath@in.bosch.com>
Subject: [PATCH 08/15] ARM: dts: am335x: Guardian: Update regulator node name
Date:   Fri, 25 Mar 2022 10:06:06 +0000
Message-ID: <20220325100613.1494-9-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
References: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.162]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 714acd78-9517-4081-480d-08da0e473149
X-MS-TrafficTypeDiagnostic: AM6PR10MB2423:EE_
X-Microsoft-Antispam-PRVS: <AM6PR10MB24230DA5322AA00826C2AF7DA61A9@AM6PR10MB2423.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngccysLjEJ1fPOCC8EMIhnxI1MnFeDw7/Z+dUH9mTuGKLGiNWbUqmYhl6huvKe/BJ41h7bH3ghI2aONISez+1QoEjN4t8lBJI3GuImQFnABQV0As6yY7h/VoYbYD/n9wAsuH2hOTGizwIIPHCSlbrot0AoFJNrzRLuT8Hu0eag+k++TVObS0ilQ8dWfYKy5sN/UFalmCYEiyYUEVAj4KQAgp8neaGdm2S8Zw/yKShFnBb91c19cp0nFWITJBdzjRjjFuNkVVTgn8pBhiAS/ge/JvIXZJa8fIOTyA29zYQCUJBP4YoQ919xJNkVoyR+UotckyXyCFkOwOR0DyYfuya3aWp7pG9C1IFtzI2P+5FFNziTjgYB48GJsGpA3nkY2DPrwF4c7nwOiJ/sSkMQjbHgHTlWqU++TtN7Qa28cmcX0oFcP0LZdsl9xr0pbW1TaBv59E5UVhd2MSq+vxNexOryLexICX93pe9a8/w5YbhoiymGt+j76NZAjhGbM86/7dRtUtC14JEVl+Z6cJr/oY2pxRkrIujtzv85535910mVO9+93+bpDQ/ylARM8erS6VslEKMe4O/RzWC/NAQhQgkLkZXqHmWa6VrKsc32wFF6NuuqJKv8pZeO0pKP7IWxilX9e8/ohAX50WPAa6XMKvmQlu1nAeSbM6AROnVSheqI8fzC9+VkFs0SLaf26cFqjmrc5D70uITu/N051ArhneOA==
X-Forefront-Antispam-Report: CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(54906003)(508600001)(356005)(110136005)(2906002)(70206006)(36860700001)(81166007)(70586007)(8676002)(4326008)(6666004)(82310400004)(8936002)(47076005)(2876002)(107886003)(5660300002)(15650500001)(316002)(186003)(83380400001)(2616005)(82960400001)(26005)(1076003)(16526019)(336012)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:06:55.7706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 714acd78-9517-4081-480d-08da0e473149
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2423
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

 * Update mmcsd voltage regulator node name

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 arch/arm/boot/dts/am335x-guardian.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index ed4cd51dd838..e0186043f18c 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -108,7 +108,7 @@
 		ti,clock-source = <0x01>;
 	};
 
-	vmmcsd_fixed: regulator-3v3 {
+	vmmcsd_fixed: fixedregulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmcsd_fixed";
 		regulator-min-microvolt = <3300000>;
@@ -303,6 +303,7 @@
 		};
 
 		dcdc2_reg: regulator@1 {
+			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
 			regulator-name = "vdd_mpu";
 			regulator-min-microvolt = <925000>;
 			regulator-max-microvolt = <1351500>;
@@ -311,6 +312,7 @@
 		};
 
 		dcdc3_reg: regulator@2 {
+			/* VDD_CORE voltage limits 0.95V - 1.1V with +/-4% tolerance */
 			regulator-name = "vdd_core";
 			regulator-min-microvolt = <925000>;
 			regulator-max-microvolt = <1150000>;
-- 
2.20.1

