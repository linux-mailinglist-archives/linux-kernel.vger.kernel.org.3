Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6464E7093
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354352AbiCYKJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358679AbiCYKJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:09:01 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50071.outbound.protection.outlook.com [40.107.5.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8190D0839;
        Fri, 25 Mar 2022 03:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6+ku8+vG8g1wkxi591GaAe0AcGqXRsUHV7g7aM1xb59xmZtEJ3S9e3iFpC+nvzhOgztmQD+ayFpLKPDm4GOwa95zCAsV/xkK7bQPJMfe4hrLfE3+ygbaLyy2nHN5UfdhELazD55JiaiJbWTAcecBo475IL7zbbp7LmE4JF4WqDOU2FTmo1uqcVr9kygk9K34IugmL44Z0zb4qwD9KQHG2VcEAcurrDAhbg+7x94WIDucwTVRGZx9l/005incDeD5Wy9gMoRvVsHVu31gYZ60sqGKVlNuxaDYvhEH+rtS2r3w8b7mDsjhwfomsbbH1Qh+IfRcwWECxgGJPtwWtHmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKdYwUtJFBDXAbgY3+awfNJ8/NU94tldhhS5SQatz0I=;
 b=kpqq+3APxgv8vGeN9kJVVBt3yRuE35Or24pwkYMV5Kqw0LuqmZP/OU3GHYk66/ik9Q9tfmjboNMhnnQFD9KprQPNGTd66iU3FMIoKdNVep8zea7uJhVLJ+QnOWYy4/FZO3vhdII6UMKHAlewUqkpb2vgqJBOTBheRH5Q1hPUtWtUTfvwoJBYSXytxK5otIKWManf83/h7rk2bquOVPIP6olB1OVzJMoe3yPxpMfkmt769nxFMunSbz/38XQV6pN/HiTaoIVVcA9Ap5rl0c9aiaLPYutQt0ASoV0Vm0c+lY5vv5cF1z0UOhPD2iIUwUNKAXK7MFM6QOXIDlH8Up/wUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKdYwUtJFBDXAbgY3+awfNJ8/NU94tldhhS5SQatz0I=;
 b=T+r2L9iubeYqlDf6Bj8E74UEx7A6ToOXb90MbZkHrTKTDaw31cYK+jBatzOZlVvUPZwZlbFawny+mcZPkl8lGSgrZna0DgO1/cZ0+geX+WNGSuHjC15KZRjFEsr3HRjtabz50q+GZvI8IwD8fqtHEvK4lcyJVrpLiLWvEd3tfxg=
Received: from AM6P192CA0075.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::16)
 by VI1PR10MB1709.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:802:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.21; Fri, 25 Mar
 2022 10:07:00 +0000
Received: from VE1EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8d:cafe::45) by AM6P192CA0075.outlook.office365.com
 (2603:10a6:209:8d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 10:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.203) by
 VE1EUR03FT022.mail.protection.outlook.com (10.152.18.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 10:06:59 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 25 Mar
 2022 11:06:57 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 25 Mar 2022 11:06:57 +0100
Received: from localhost.localdomain (10.167.1.162) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 25 Mar 2022
 11:06:54 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <robh+dt@kernel.org>,
        <tony@atomide.com>, <bcousson@baylibre.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>, <Gireesh.Hiremath@in.bosch.com>
Subject: [PATCH 12/15] ARM: dts: am335x: Guardian: Disable DMA property of USB1
Date:   Fri, 25 Mar 2022 10:06:10 +0000
Message-ID: <20220325100613.1494-13-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
References: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.162]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a70bdd3e-d342-4db4-d02d-08da0e4733a2
X-MS-TrafficTypeDiagnostic: VI1PR10MB1709:EE_
X-Microsoft-Antispam-PRVS: <VI1PR10MB1709847C6C3C105842F6D9A5A61A9@VI1PR10MB1709.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GhuTVW1I80hkSl4aCPJuja1uKWJXhj/Ycf02JSc25MKF5j2ARV649edGbjB2hbYYLinLE0rwauV//v90p1ZXISNLdKOZDA+aAinZzLJHWVblwFmJVkZtAZFCfSheroR7a0BY4vYllgdQRdi9PAbQhAN4rSzq4VfzPE+2t4LcS1O2TFk/pJoyKvRYXVsEqkkcPUFF+XWoARFuIy5EwMA/+pv/wcgsqExuYysbplwPfS8Ftb3yrh5o1eX0tky7riYgBm3ACOhEwKuYjjne+zV6SFKvGSAWB2xW9Ef3fV0DPN3/UGFGahcgVuYy/QAW7dkrfnzwzNgWIkDDNB2gRpHc8Vh/v8gZrlztvJW5rR2srByWclsH9kcT4+41Mk6qz5zWPtR7Ra3V1GubSff0aej/C46IvL2MAZUNAtwk4GNoRyCaHYOw/2/VvN9pRtjCp/7xnfSfLiZktBjbHRjGb5tAWsojoUG9Klr6VsfKoLpG41qXU5+CQLX0HJgqH0uptAUzxCYp9vJYQtUlZWJQyA3Kjylkv5M10QtJzyo3eu5jiZRKhHdsdSP33/z6kbU/1rLyTnIC9cT8PqakTkIv6KXBcdj4fs9h84aVr9+iceJu3r7p7DjeOZ/B3Yf0LzhKMhise+TSnvbBdYY0da4+NIHDB7C40dp9sGTjfHuYMPtCMuGv/QQMzz0w57w37YHatlo9xxUonPDY2kaqa2jGqZ4Xnw==
X-Forefront-Antispam-Report: CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82960400001)(107886003)(356005)(54906003)(47076005)(1076003)(6666004)(2616005)(81166007)(26005)(336012)(5660300002)(8936002)(4744005)(86362001)(83380400001)(16526019)(186003)(70586007)(36860700001)(70206006)(508600001)(82310400004)(110136005)(40460700003)(316002)(8676002)(2876002)(4326008)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:06:59.7027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a70bdd3e-d342-4db4-d02d-08da0e4733a2
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT022.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1709
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

 * Dispble DMA property of USB1

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
---
 arch/arm/boot/dts/am335x-guardian.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 9f60f5430f36..93576f136368 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -395,6 +395,8 @@
 
 &usb1 {
 	dr_mode = "host";
+	/delete-property/dmas;
+	/delete-property/dma-names;
 };
 
 &am33xx_pinmux {
-- 
2.20.1

