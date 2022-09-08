Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF405B150E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiIHGsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiIHGrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:47:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD45D2B14;
        Wed,  7 Sep 2022 23:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTaDcPigMdhbj0YicKMMgEiGDVw5djFAJH487EB2A4/Cv5M0eXu5jA4kVL68aQoVnkpFeyjTX5KHnhXAg/IjoJqAD/FZPm4pCqx+cVvUw63Y5mzWh5y4+npxFR1Ww9wsXyDruNho1esKt8hQv7QgcZqKiJHo0U/kx25aVClRDbnGuDPZ+FLnbscF8IznSy+pEbpcRMY/zJRo/s0TqrUq3dzZvZPHGSr9v20kx5xUV5PypaZAfXLq+rsqWa+31O9qQqLrQ7D4P04681VYU9pT7+Y/STrf+p+54i7VQfuPShLNjS1kEq/CNtc442dICNHgGxDW6mfoSutjKVu6V7RY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHK5EvK9TnBnZEFaZTF0Yo8cucx2lBYdOBK9n8Qfluc=;
 b=PmRm0HqVfS9/wqVGZXLNslk+x00VttW1mgFpv1dQxuR8//2fsPY2RJ0wQRyfFnbAArMqtT1hfLvuwE2TVX+hM0aYhAfdZznfz1tE7DLoAtKSWIgVg9NNHmWylITRqabIKfLYRNkulJY0HrkItleu6FEc4PHq7Ok8khSCmGG+0NiLqW+8tvrUMGntlS2tAmuUWcbPMRyHMQRrGb0BlwLI1x8ksjNPEngafziQlsm2uEbIbuQKIPTUJNB0zqGy0P7E1vjn7DXzy3NckBy/0Wdt1YxPnDTLX0BQM9EMcZWxx5IA5pQFWiH+zsFyTE1wQ3DL/EY3mkCU1W2bY+SFjPuF5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHK5EvK9TnBnZEFaZTF0Yo8cucx2lBYdOBK9n8Qfluc=;
 b=AlLd5XjagGzO3RTDuN8dPod5htDfHK6pl05COqVxlXWHM9f+yyNz5mG2z1qLNf2qtWvK/kKpw8nIP+iYvL8ijMSkYuVzYleD+GZvpbS1Z6fEAxKtsIXGGWeNYcz80yLkTOUTGlDI2SS8rw9ViBPFWDjPifxo2Cgo7nao8KGjoMc=
Received: from BN9PR03CA0803.namprd03.prod.outlook.com (2603:10b6:408:13f::28)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 06:47:32 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::f5) by BN9PR03CA0803.outlook.office365.com
 (2603:10b6:408:13f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Thu, 8 Sep 2022 06:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.9 via Frontend Transport; Thu, 8 Sep 2022 06:47:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 01:47:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 23:47:11 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 8 Sep 2022 01:47:07 -0500
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
Subject: [PATCH v3 0/2] mtd: spi-nor: Add flash device reset support
Date:   Thu, 8 Sep 2022 12:14:26 +0530
Message-ID: <20220908064428.2962-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: d0973cf0-3d4c-45ca-ab76-08da91660188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HOBtMoafTg7z0dPwB4KS36nXzgvs+tKG4Ro1vdKktq3oilVS2q5YbBQt3ScOiUtKXJNVAjdk8I4/GBWlygfd1T88u2x8NxaFb957fU+Mduw/+LV592YY/a6lmyr1ZP0Z3Wpxvdogam4J/9NpQd9FtKAVpegLEAgehSPxiiD46JBLyesG6xfRpHeiaO7MCQRFWTmyvwK1II1mH881JSXs+CJ1DfxkbevIvHbHK4YY49bENMAbsK9HNYJJ3YakXQ9Ji2Ds9h6QpXETwctmsD74Gqr1dLBVHxeOg2a/pdmnSl5uuOTomZFJQLdBbQYKxKpDsyw32hdHAyyz2rpireQvZfi3zCRckDMNbRT0PBsiC+qL8hiXf4JlygraDafPYhDG1NKiTxv5EO3W6hvNfy8yDF5vIkbqCxlv32hSkXXReRFgqynHbsn5qTb8hILi3F7yCfAFG8gWyjBTx7En7umHMnXwSx9FQD7NtDO8uhwE1cm+3fnvs5Mfoo58CJhUVq9Y7TW0b+zbsYjsFCXq6QM205/plc1mmHIm/C6CjpDHlA8l/BRXHGudWAnMGalPBzqmuXTq+SegG1PAY40EsBlu2ew/5xA1ipzswnOmRJNG35qxK/FO1RF3v5le7AvxVsn7KKqyxg8Fw00WyNnCPEFxl/LG0dtnTYrNXR8XKLP31bK23mrw8Li5BSx/291aZgFHLHRR65Zzr6ZzCj0eMFMEcKMTE8X2vBIsMi6b7ple45lWShElwMDYn4Q2/3yVhpnty7E6fIZCy4jFk8+nILKiKb9qeA9bGMMaKPNpHvJWGz3vfry3VizylDqdue89MuB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(46966006)(40470700004)(36840700001)(110136005)(316002)(5660300002)(103116003)(83380400001)(36756003)(54906003)(4326008)(7416002)(4744005)(8676002)(70206006)(2906002)(8936002)(70586007)(36860700001)(47076005)(82310400005)(426003)(26005)(41300700001)(478600001)(40480700001)(86362001)(82740400003)(2616005)(186003)(1076003)(336012)(6666004)(356005)(81166007)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 06:47:32.4147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0973cf0-3d4c-45ca-ab76-08da91660188
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update spi-nor dt-binding and spi-nor core to support flash device reset
using reset-gpios property.

changes in v3:
-> 1/2 - Add reset-gpios property in the example dts.

changes in v2:
-> 1/2 - Updated the description of the 'reset-gpios' property.
-> 2/2 - Updated the reset sequence to match with "active low" flag in
device-tree, also removed unwanted comments.
-> 2/2 - Updated the logic to perform the flash reset unconditionally.
-> 2/2 - Updated the delay values to support more number of flash devices.


Sai Krishna Potthuri (2):
  dt-bindings: mtd: spi-nor: Add reset-gpios property
  mtd: spi-nor: Add support for flash reset

 .../bindings/mtd/jedec,spi-nor.yaml           |  8 ++++++
 drivers/mtd/spi-nor/core.c                    | 25 +++++++++++++++++++
 2 files changed, 33 insertions(+)

-- 
2.17.1

