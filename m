Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3BD4E7098
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358202AbiCYKJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358697AbiCYKJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:09:01 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F37D082F;
        Fri, 25 Mar 2022 03:07:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMi7ZvRy9VXZZJr35Gcp9WcQhHQpfUxKAM5Hhh/ntDHes5j9W6K3v2q4jWWeiNXNkQDj5uS7uqZU/HXTXIgV1OnB6iCpoW2976qDqoqAeImSux/aZOw4DRsQPQIjudAx2+GUeKhnaFbdI2H5erkthhfL9pZ9ZHKI86/0m9YF1f3j+HxigJvsYcdbhEu2+z0MUVTS5mACKgVlP5D1/WqFxU6QVUCui2jWfpJBsroS3+9R1xr89X9Gc7rXyRpgfD61ShA/c1UKgCTYjE7fGuEjFa1qVmiRMc0WIV1HPIGuGhB8/PCFhob4cXlA9Og7CJWmVnGFB6PJuR4JEJ8UHjp0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvM7aN9zvw+Cp4AA9WKp9NRTVhoqkh1g079U01OaGbQ=;
 b=iHoDVr4K2A1NTtq/mESDTAUnBQ2NUsOxxFDYS+5flcPVU4tlo8tJ3k9juY1gLIaSf+CdYF+5+a59AdLxMffXiahzzR51vOug/IKpRMRRHpd94+GH9WtqBfuGF90PqMDGyRqeItV0gwZBCgFasadGvKrvTir3e3G7o8e2wVUm8XoKSI9hFIzSuhKmhyewShbj8X6D8u50+LWqe6ad1ElsDTNvXqT+H70FgT8PRhBTm5GAvjNP+FXjfMBGW4ICfG8DQA5IDrM3yWj2i/dflwwH95J4POAkBa/sFPRIFCGBha5rqqH7++I+qDdUyejoH4ZjOP+0CGRAECGSkPcLvzqgcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.199) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvM7aN9zvw+Cp4AA9WKp9NRTVhoqkh1g079U01OaGbQ=;
 b=dIlXGZMDNcsABuosU67rn1Ba13Bg4hUpwpe2ZXs4iuf67DR+voJqyr45PoHFJGX6CamKEtITg0o/WL65ApU7E4UK+zXJwEOQtOglh8FwxVTRJPQJkpRuK3o+PaLgyFY8pSzO4meCghoGSZOD+dnVVq0PaZ1j5SHdS5kOONPM55g=
Received: from DB6PR07CA0198.eurprd07.prod.outlook.com (2603:10a6:6:42::28) by
 HE1PR1001MB1449.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f1::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.17; Fri, 25 Mar 2022 10:07:04 +0000
Received: from DB5EUR03FT006.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:42:cafe::cd) by DB6PR07CA0198.outlook.office365.com
 (2603:10a6:6:42::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.8 via Frontend
 Transport; Fri, 25 Mar 2022 10:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.199)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.199 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.199; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.199) by
 DB5EUR03FT006.mail.protection.outlook.com (10.152.20.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 10:07:04 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 25 Mar
 2022 11:07:02 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 25 Mar 2022 11:07:02 +0100
Received: from localhost.localdomain (10.167.1.162) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 25 Mar 2022
 11:06:59 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <robh+dt@kernel.org>,
        <tony@atomide.com>, <bcousson@baylibre.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>, <Gireesh.Hiremath@in.bosch.com>
Subject: [PATCH 14/15] ARM: dts: am335x: Guardian: Add gpio line manes
Date:   Fri, 25 Mar 2022 10:06:12 +0000
Message-ID: <20220325100613.1494-15-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
References: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.162]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c37bf0b-d8e9-45c7-7454-08da0e473660
X-MS-TrafficTypeDiagnostic: HE1PR1001MB1449:EE_
X-Microsoft-Antispam-PRVS: <HE1PR1001MB14490D12268DA1D25F9D04F1A61A9@HE1PR1001MB1449.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bUIpmsNRtL7jD5bTrB6i3Lf/cFuEsFrGC79iCEr7QBLwdnJse8PYkICzonLnDyy7/OSbEv//xyK+bmYdvEBobfFDVh1T1iVASeq6pqD37/2UloOKtSMPOIDIa3SXYZy249DagUXClIoIaFY7nuQjtCvjVD7+aLAOaSKHYzzmDVtolVNHv/Fv9L3F8YVAIxTaIT6kMPBAKvtKaRoW/+7r4xOFSrlOtNFu78q2ZN5iAt7ZFyQ5A1d2+XvtfufOEniZQWo9/n2g6MAJFGuyW2ii8cC0TDGR2NSr2zUGfIJj5hE2/3JY+h77uf3IHCJpZwgMGA3B90W90ARRgn5Mj74cf3UC8o7OG4JppTNQ6WnByWDW59P6tPRiycHnkymVaKKb2Tk/aIX26oRZqn1YqH+0IoHoM3LxgUYVu/rTkBd+BOah7HWgR3obVWyOc4zqBQSlcjMM+qG2/Nk9k/J8R7pAvbi2kvs8/6vRi7jPx67L3+DCKUw3w4G87HcKyuZJmmqw8NuxhQvhurzxyorBRmxnZuok8XlIzRxcxUhJCOSAsaH3hzA5OOzGCt0o2Zyx/QvXmWeZLBsCkzFmpk3aatjRhSayvDbkGDDulzSXqFE0dm3zYmzJ+Rog16ft9JLBHFX5Kg201hwWNlry1uGyWiIPPnevkryD4gxpXhoUvLIVBWqL4YWHjQlZ80R8yW/NU9CdlZDAPtSCASdHzFJtJzbyrw==
X-Forefront-Antispam-Report: CIP:139.15.153.199;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70586007)(70206006)(2616005)(508600001)(86362001)(1076003)(26005)(186003)(16526019)(107886003)(47076005)(8936002)(8676002)(5660300002)(4326008)(316002)(54906003)(110136005)(36860700001)(2876002)(2906002)(82310400004)(40460700003)(6666004)(82960400001)(356005)(81166007)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:07:04.3010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c37bf0b-d8e9-45c7-7454-08da0e473660
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.199];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT006.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1449
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

 * assign name to gpio line

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 arch/arm/boot/dts/am335x-guardian.dts | 74 +++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index b225210d5e11..cc56b4510930 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -382,6 +382,80 @@
 	};
 };
 
+&gpio0 {
+	gpio-line-names =
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"MirxWakeup",
+		"",
+		"";
+};
+
+&gpio3 {
+	ti,gpio-always-on;
+	ti,no-reset-on-init;
+	gpio-line-names =
+		"",
+		"MirxBtReset",
+		"",
+		"CcVolAdcEn",
+		"MirxBlePause",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"AspEn",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"BatVolAdcEn",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins>;
-- 
2.20.1

