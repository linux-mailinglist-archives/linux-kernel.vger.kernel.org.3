Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E153FDD8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243159AbiFGLrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243117AbiFGLrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:47:24 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83555A45C;
        Tue,  7 Jun 2022 04:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M22G7jbJUj+LFrX8bSGD8X1L0am1ZHHtALlPaZmdFJn/i2JJKNYCsgezGPTJvgFepHomVsbDPuW0CRuNM80GRGuNANEC5jvaUeQBN9HAkpo2T0Vt/h83IiKBTDEPT+MxX/X05fxP76fgzTaVewuva5/2groP7iJwy/xHbDtRDHRAONbX3JBdTfiKZsWc781DHp0JFO9LLIP5JN/c8pRxikZukH7+EbHI8isYnmw6XSNoBAla173D9NUC/EBv4+c9RlTv9QxFWkB7CDzA0GnU34SBnN70ulz5jkyeVY9nklVEwqKhFB42BCFpBhZGC1Xf+sC4cNheBOURxOHDrdS7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JX5NrfXoF10D+Fk2qYDmPDN7LKEQCsru83G+1gNbV7A=;
 b=ltHnpzrvwJ5uAICmUN0AdwLEAIK1zdy4MUQqdVOaXTdTB61MkwO4pXuDWKvtfgiACNE82WdlV7tMozYXS9fAwrSY8IPHopevNr/FaIRb11z/sIagbuMhZvASFUoZFE1h7vjU4m2jSpfj4zk6U1DH5MJRpgth0GvPFyJMjHALVWWEVQyBd6Tvat8Bt0akJYMktgaIorUBz0TYClBMC6C0Ifvrdyp8gKEsk+EOwDWbuanBYxuP98+sMugbd/oNJU8ROKV3BGPbKG1zxF0+RVenaFzyjZNVua7/U1ms9HNPvVkEwu8QvyomECXt1+iBP8elqAgY4QxcEXBV+EdISM2m8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JX5NrfXoF10D+Fk2qYDmPDN7LKEQCsru83G+1gNbV7A=;
 b=Cnk05Ll0ZSI90P1vuA44Ug94TdulVNT0pq0cG/G+azIxqDH9cP+CsVkhXTUzyGNe0VqxM96sV0GP2CeU28euZ13dhTreJfxOGLQk2ttsM45lYH33sGWkbW6I7ki+lvvLlvO5FH/zsSRKjyxx2gll+5vuQTnS6eagVfbiztyEhnzjQtvRPxema2b9YIDnD0n7esCCXAsGT6zSwuxANtaFhWHg6jSXPEYiJPiAFmgWJzDLqdzrfe2wGLMSc6lzHp3qYdHU3SJHYD7jgRapHmQt5CJ9n8j4LXRdbAcOfVqgGAg6lTmFoo/FMUhqclamiDuBnMoIZqq2EJBCURSJmYFW5Q==
Received: from DM5PR07CA0127.namprd07.prod.outlook.com (2603:10b6:3:13e::17)
 by CY4PR12MB1207.namprd12.prod.outlook.com (2603:10b6:903:39::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 11:47:19 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::7b) by DM5PR07CA0127.outlook.office365.com
 (2603:10b6:3:13e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 7 Jun 2022 11:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 11:47:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Tue, 7 Jun 2022 11:47:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 04:47:17 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 7 Jun 2022 04:47:14 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ashishsingha@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>
Subject: [Patch V3 3/3] spi: dt-bindings: Add compatible for Tegra241 QSPI
Date:   Tue, 7 Jun 2022 17:16:59 +0530
Message-ID: <20220607114659.54314-4-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220607114659.54314-1-kyarlagadda@nvidia.com>
References: <20220607114659.54314-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33381336-fc82-483c-9203-08da487b79e4
X-MS-TrafficTypeDiagnostic: CY4PR12MB1207:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB120705C086C17F74C5D17E08C3A59@CY4PR12MB1207.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZStOi4ATHrC2Q6YbkwDtP75V3mPEwG/On6IFyjPBnEjouak2/1uTERGL3lxz92OlF2xHfba6u0mbntOoiEEbP+9A/42HR+WJBvbg36bp8ZjQW3Zey//6irnxYQfc1EYdw5hp4p6pB8mO4YUaImxSvGlHWmTTp7kWwzZwPLERX6Rb6D9cvIrScbzxOqGsGL5SadvSZHL6QKHGh2ynzm8jyQ4kp+M6uiUrKaFgjxJj1lf+lbTL5tRP3KQCSr1sJVShazqWzsdP5oGgcTK4GNtGSbxsVwuOFkRDdZAaAB/aCt8c2XbdpP/gzxOkMIXlsQbZoH2Vb8IB06SJWzNXqsLsjBvEekp4HDxkYAC53Sqpl5Q7w2fo1+hgn9/P0YJLbR6UCPzvrEjdhuezkywGIDkzPzSNm/S+uBP2WLBgwQA+1/onopqfYp8aAcpBoC0QF1qXiTxK35wRZLc63aZhX5WBirIJ1AkoCrMsWOopZ+ZntHTXYRZ1KF9jcPGfS6NpWonmBddz+Ta7G4KrZDNuRujXwhWwq22VcxMFOyKpMgV1R/MrZ3HsnqyLsBbzBK2knHVmKQH84olRWOvcjNlpNg3yjg+6m4bOy6QOd1IvEfTf7l6rg0OoHFC5R6vnMY4r4vBvNNXbCO271usa8FP6shcmEUgfM2Yuj4T7xsXKrjPo8vWrAv7S4cL6MWaPaplKkrnSbQrNccuxmtACCD64PeZqBQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70206006)(4326008)(70586007)(8676002)(4744005)(508600001)(86362001)(81166007)(2906002)(6666004)(7696005)(8936002)(316002)(36860700001)(26005)(356005)(5660300002)(186003)(426003)(82310400005)(336012)(47076005)(107886003)(110136005)(2616005)(1076003)(54906003)(40460700003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:47:18.8296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33381336-fc82-483c-9203-08da487b79e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1207
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible for Tegra241 QSPI controller which has
multiple chip select lines.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index e79f0b2560a4..6b733e5c1163 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -20,6 +20,7 @@ properties:
       - nvidia,tegra186-qspi
       - nvidia,tegra194-qspi
       - nvidia,tegra234-qspi
+      - nvidia,tegra241-qspi
 
   reg:
     maxItems: 1
-- 
2.17.1

