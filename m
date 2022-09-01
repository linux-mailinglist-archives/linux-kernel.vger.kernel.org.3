Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52605A905A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiIAHdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbiIAHcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:32:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC4275385;
        Thu,  1 Sep 2022 00:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxaRjPXrlovx3HUJrbsBsRSbLi/PsgQJJPrFZCiWLx0PLCi+anLGkFgz0/OFNTDdQbmw747OjiCLRzgmFAElk8yYm8iWQn0oqwvDXAD839zqkZPyrAtJmlaKDKkshu5ZfDLvJhQYsDWiIjnumc9MdsEMFSYnQXLsTzot2G6mLG5y1m8fPZhcpxzIg4R/ARX/Z8PFgqqgDVzY39rpPl3+eT+XFggY1XcfOnro/yBPdnGdp8GYadrZ/kMA9ossyp0ias+dqQBSZkRXPg/pwZBkFSIPPv55G/iMqeQXpl9WBoqFo4z8mS1BgVraq38K86fxkrD1XJ7fXnAGoAwvfOpPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx8kUA9NwQ0apaSQPrbjUFtSy6LFo5vERAMcEpnOd00=;
 b=RxlqnDh1c7uRCIw5woHrnyko3wM5gaJn5gZ0YFZv8MeDtozz/et1eDdlM95BqAlIjEpZjPyQiX3tk++BFU+AKOb98p5rcJW9AknaDzfEsj/SRaqRgwQVYN2vDX98VEk2uLvVdcg4Ez0b52rr/Lbi9MncrDs2btPhZECQVM5SjTeSH6F+wfmLT0yMt70TuNZnjL0KcSb9LgC6qoroLx1jC198IQMrNK1F1TM/LovQofrLZRwH0L4C2mUiZWgo+Z6g/3G5ymE2ROuMXRlHcoBafTXh//y4AgBvT6JHEPVnPEbVuXskQ2aGUgG2KbuuN3wgGo2KESlaD9hi2Z8DXXJ1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx8kUA9NwQ0apaSQPrbjUFtSy6LFo5vERAMcEpnOd00=;
 b=gRhwVvzzBE/1LYooq63j+sv1uo7XPzvMhlB2MnMnrSjVS+N1GMbhoM03vhiH2kHoxnCDxMQbC1iu69J27hXPJAlywYz2BxkRUxbzyUjFb0fBHsU7TocUqvrK99gOg9kbbhcidJ5h9E2wUAJkTFVwk7/si+OmrqRHyMjTbLh47W8=
Received: from MW4PR04CA0067.namprd04.prod.outlook.com (2603:10b6:303:6b::12)
 by SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 1 Sep
 2022 07:30:06 +0000
Received: from CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::7b) by MW4PR04CA0067.outlook.office365.com
 (2603:10b6:303:6b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 07:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT096.mail.protection.outlook.com (10.13.175.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 07:30:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 02:30:02 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 1 Sep 2022 02:29:58 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <saikrishna12468@gmail.com>,
        <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH v2 1/2] dt-bindings: mtd: spi-nor: Add reset-gpios property
Date:   Thu, 1 Sep 2022 12:59:13 +0530
Message-ID: <20220901072914.30205-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220901072914.30205-1-sai.krishna.potthuri@amd.com>
References: <20220901072914.30205-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04794441-b0c1-479d-788d-08da8bebcade
X-MS-TrafficTypeDiagnostic: SA1PR12MB7037:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i1c38dn6Ywr4Fd8rKbu/VbyUpVXO5mVfn5n4D9zbXQc2RCSHuxP6FdChk4EO0dWuxS7kRS5+950G23YXBKou+RrZJpB4JDiPaEU8Vp7LM5TMI8XRLJiwqt8HmOjDXDRQEPhokwU07Y0PpW2chbJbGMfjqxDsut2XGhlm8nSdcQlYlKGNMwW4IyeeCfUuMkI88buaHgagKOHfNHItwY9Rtzg+j+7BUH0yjvJi+w1P7QYAvKU5+ThndMKK+fT8Bd7l0i06yacXf0cPz3DCaeTcBgff3WYmQqsJAZogYXaPPtDcQi+niMhTM88NdrecZiLmNDKU8jGALbvPCB4SQJ1R1OFzuqd5wPnNwWMRnaXX0S7xhampVu46/uryMuggEunk4yFe5euNxuSvZ9Z4R4287hJfFlkmIS1ryMGNsdYeCy7vpAcCby7NPQ9Hpux6E47pakUvhk6oBY5nDBk35tjZIFMWoH5FsVoi/cqsTOX0AKMp6+Vn750F8tNa1id4P3+B6qy3wYhLCVT4v8Ie+OBnMkwgoOgfrNlluJjm8GI+WvTbE1DNsSChs34PE94C85lR3RkPjiGEtyYgO4QLyWKp3lFcnCYl4yTLyBAMwn+WjpKcf6qTjSV5dGJeYzkriLt+/sx8t3CDiPFzcr5dVO2KwYlPyZx4bm13MpJ9i2lkMRRF8/ZqlcQOhIwbw5hNaPYAZSBEM7jw6bXrS5VjJE4jO0bmbZ7yrZS9pepTsSJ/1+Ai4zfDGgzlJCAVJkTSDyEmlIT7GMvqSuNPVoLATRT1pP9o/UwUnwZgT4ZAYhBm8ppSCbnJ/Iw6iv+QsExrXwxg
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(40470700004)(36840700001)(46966006)(4326008)(356005)(2616005)(478600001)(36860700001)(336012)(47076005)(8936002)(1076003)(186003)(82740400003)(40460700003)(426003)(5660300002)(70586007)(81166007)(8676002)(36756003)(7416002)(41300700001)(2906002)(316002)(70206006)(40480700001)(26005)(54906003)(82310400005)(103116003)(4744005)(110136005)(6666004)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:30:06.1780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04794441-b0c1-479d-788d-08da8bebcade
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI-NOR flashes have RESET pin which can be toggled using GPIO
controller, for those platforms reset-gpios property can be used to
reset the flash device.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 7149784a36ac..4e98f78be750 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -70,6 +70,12 @@ properties:
       be used on such systems, to denote the absence of a reliable reset
       mechanism.
 
+  reset-gpios:
+    description:
+      A GPIO line connected to the RESET (active low) signal of the device.
+      If "broken-flash-reset" is present then having this property does not
+      make any difference.
+
   partitions:
     type: object
 
-- 
2.17.1

