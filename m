Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C237573FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiGMW5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGMW5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:57:19 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC354F6AA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPMnw8DzF38W0wfKFXMz7BcXTAviZKiOtWCmyMsfcFv71vhZQHB0JE5cEkbgkA47aZflLK+6YBadWJYOF3jpFNh6GnQ1aWN/HlOSMU2qq/em15bHh2r8bGt65SzJ8Zs6ewNsToPE+2CkTEYu2c3rCy3DaWbA30Palvvak9A4NI3IdN5Up0zjSAbe2fLJerAfUH/TQoqWmyTUFdULhVViDtEvimQAttAIGEl6U7JpncKyshMvGkFbJdq+xedIDBWKSiuwek7HuKQgMVHrX5SzVEMZDDkk7NyK6lhGBUJxswhqZZUdkRqQV/9RyyGsk4tcgn8dFCyTHpmqWo9S1/MHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWN6qb3LmVqgGNlejfdYzF0+Ae13n8zN70Q9tUPAXf4=;
 b=ArSA6iwQDvrWHIDls3O9EaMwj29q0sBc6XG2rrgEXN4iCGltGGwnPEZufSCkIk2PxTi3hvFJB2926+6laYdNFrz5Sb5SRIO4ktM47CARAx0gXA1ZEeUzCJqi/cfELmFrVKHDPTznc3Ef4/SJk+sOwIPQouCg5Bc4ki5ZvTx0i/qbBRgnKaFfuIlk49WmKKI3rrNeYifrylYsIKJAO57Ce0FQ56KF4TMBLfkpzeLEZJj7ROgKQiMG25CA61G41Wy2PB2r9GbQ5jffG+tZKG+LKoy5rz03wA2u3F9gCG00d9mbzYAPOkCpJUv4frg54oXb2k8zTMEnwaLYa0+eXSsZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWN6qb3LmVqgGNlejfdYzF0+Ae13n8zN70Q9tUPAXf4=;
 b=oxP6Lb2ga6R4IMAsldNQdPeoUwUv/uCPbfAv18We9ETsknGs6wyDXsLOxTNdTgHrW78y+79/jzY4h8D9aMyjirTBwWdqlErpJepvZNJJAcppc9sfeOY4T6pQ8pvN886nohSSgGglq3c/KlpYtPvvumvZU3ZppoOLjFYRgIUCvyY=
Received: from BN9PR03CA0533.namprd03.prod.outlook.com (2603:10b6:408:131::28)
 by MW2PR12MB2569.namprd12.prod.outlook.com (2603:10b6:907:11::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 22:57:12 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::5b) by BN9PR03CA0533.outlook.office365.com
 (2603:10b6:408:131::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Wed, 13 Jul 2022 22:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 22:57:11 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 17:57:07 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
        <ashish.kalra@amd.com>, <jon.grimm@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 1/9] iommu/amd: Change macro for IOMMU control register bit shift to decimal value
Date:   Wed, 13 Jul 2022 17:56:43 -0500
Message-ID: <20220713225651.20758-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220713225651.20758-1-suravee.suthikulpanit@amd.com>
References: <20220713225651.20758-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83e48eec-645a-480e-c91b-08da6523057b
X-MS-TrafficTypeDiagnostic: MW2PR12MB2569:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GehDdZDVosumYtf/4wXD4dpnUSQ8ChQUAoGrwTV46wLmy5ZxmgyPMH7L59zto2F99u4zb3YjBA/G2K5JXD6R+NhcdaR2pJQGSyIHYKHtX9hE4+nVrYtphH9KILXvPvAleM6UW/STL+BGR/1+/3smGjC8yIPuzorSDEl0f01b1tBjbDgh/PcAT9ASrn+5JwteIfK8bwwxctpofXZ3NaII8NfxypdltQKZZP2BvhoAoKUf2OeBOhJsL8ov+xxI1PJp3L6zvy4w0cBgtoo1yBnQF9B+zNs5KDFsRl4sBCDKsjtaQjno4sYrWD4B9eVYTrvddF1mkYzzAIWkW8VjOKqYusTfCenL5AvwBH1mY4r8WsI5CyGUYdqEGh0LDgBLgVZjUSFRKLnp2+NRVlq66AqtMEA8pbErtMkN7DSZNlxIOWYLghE2d2B8aH7ZoGEYUQtNwVXC/BYHqUS0gHG5fpTBRt9Sqn8vJywA+E8QBPLNpTiYqPTygorA8/kV3L0zg/P/lkxs8Du7msZsMS4uEjxSHAWMoDgXqS/nSwVLFDC71MHsgFryMTT4G1TosuaAW7p2EdxCBZXMyhYODfBDzARRpwsE/wKb7sPn/JhkPDpdo2ZHdqV+fR7IOMehimoGylkSUUAeIYqqNQ8vAMNBUoq/Sj8Gw4v6KRztMrspVNF+btsjl3Z9gUyquPa1lrKeLYlEH04cg4pA6j4uqwuUsIgI7IyUtfNPJjkmtaJxp5XDtv1O62lnEHmVDnANUAml98RU1VyP8ACYvDNzXN1Hp0HE4M0mFL8L3FjY8CbWawpSHaU+retuGTDHRNUEbN3GYCHIBOVVKpm+62Bp3swjvOHCHVVWvBQ3wc8EgjtC/IqdSJI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(376002)(39860400002)(36840700001)(46966006)(40470700004)(6666004)(70206006)(478600001)(8936002)(40460700003)(2906002)(82310400005)(44832011)(7696005)(54906003)(41300700001)(2616005)(26005)(86362001)(110136005)(83380400001)(81166007)(1076003)(16526019)(82740400003)(316002)(186003)(4326008)(36756003)(5660300002)(8676002)(336012)(40480700001)(356005)(426003)(36860700001)(70586007)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 22:57:11.5199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e48eec-645a-480e-c91b-08da6523057b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2569
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no functional change.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 42 ++++++++++++++---------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 40f52d02c5b9..7c830e3c7a91 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -143,27 +143,27 @@
 #define EVENT_FLAG_I		0x008
 
 /* feature control bits */
-#define CONTROL_IOMMU_EN        0x00ULL
-#define CONTROL_HT_TUN_EN       0x01ULL
-#define CONTROL_EVT_LOG_EN      0x02ULL
-#define CONTROL_EVT_INT_EN      0x03ULL
-#define CONTROL_COMWAIT_EN      0x04ULL
-#define CONTROL_INV_TIMEOUT	0x05ULL
-#define CONTROL_PASSPW_EN       0x08ULL
-#define CONTROL_RESPASSPW_EN    0x09ULL
-#define CONTROL_COHERENT_EN     0x0aULL
-#define CONTROL_ISOC_EN         0x0bULL
-#define CONTROL_CMDBUF_EN       0x0cULL
-#define CONTROL_PPRLOG_EN       0x0dULL
-#define CONTROL_PPRINT_EN       0x0eULL
-#define CONTROL_PPR_EN          0x0fULL
-#define CONTROL_GT_EN           0x10ULL
-#define CONTROL_GA_EN           0x11ULL
-#define CONTROL_GAM_EN          0x19ULL
-#define CONTROL_GALOG_EN        0x1CULL
-#define CONTROL_GAINT_EN        0x1DULL
-#define CONTROL_XT_EN           0x32ULL
-#define CONTROL_INTCAPXT_EN     0x33ULL
+#define CONTROL_IOMMU_EN	0
+#define CONTROL_HT_TUN_EN	1
+#define CONTROL_EVT_LOG_EN	2
+#define CONTROL_EVT_INT_EN	3
+#define CONTROL_COMWAIT_EN	4
+#define CONTROL_INV_TIMEOUT	5
+#define CONTROL_PASSPW_EN	8
+#define CONTROL_RESPASSPW_EN	9
+#define CONTROL_COHERENT_EN	10
+#define CONTROL_ISOC_EN		11
+#define CONTROL_CMDBUF_EN	12
+#define CONTROL_PPRLOG_EN	13
+#define CONTROL_PPRINT_EN	14
+#define CONTROL_PPR_EN		15
+#define CONTROL_GT_EN		16
+#define CONTROL_GA_EN		17
+#define CONTROL_GAM_EN		25
+#define CONTROL_GALOG_EN	28
+#define CONTROL_GAINT_EN	29
+#define CONTROL_XT_EN		50
+#define CONTROL_INTCAPXT_EN	51
 
 #define CTRL_INV_TO_MASK	(7 << CONTROL_INV_TIMEOUT)
 #define CTRL_INV_TO_NONE	0
-- 
2.32.0

