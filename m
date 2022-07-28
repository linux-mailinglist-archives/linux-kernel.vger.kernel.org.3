Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A6A5843BE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiG1P5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiG1P5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:57:18 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150043.outbound.protection.outlook.com [40.107.15.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FF162A45;
        Thu, 28 Jul 2022 08:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUGtCpKCjEhTv5vRCNK8bf0uM37qL3gpQq/lrAZT6QlkhFwBLPxK0Ajt4wLETPKC/Dq9pqVQY1ORlWx/MA7MOYsscXToUFL+3K4FUBXhyP8IXBo/L4WNRIzIuO1vwmFVb6KQzW21i6JMB+J4sauCPs5FiL27S6i65P6PMV68KKSqjmhz6kkmxZb91VDHWXZ0aj3C92evhJlbvrViAwH4OAkZigVYG+mtmkPBFUxmcU1pHQoffI/vSfsw5KcgJ6zcoUMZGW163z2j5DnzZCTV6GWF32M4zSrfjw3NFPz8PfWDdc8E5lR16Xsi4snVg52bYcINr8E2pMDm+fbEoboDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/SIkLdlwCfAKaSHnpyBQjoFHswi4PZziFDzWcXh9Yo=;
 b=kbyZ66tDVkyEmor7bB41uDaCD4BIy2+ZSpb06FZEmdbuiHbHZgIzWZp6xyXxRhOp9cDPImXDpEkIGRA7bx+ZbXzn4TrXqwOtvZgRp2k4sYdIMlqmF/yiz8HuYjNGCrk2B8i/k0eoj/T8XlvOUU14PCSGs/2uwrlDg7YmcESa7LAhtvFM+D9XQn7sRQw9AIMxU2RHav7rNOHZQNKZGAeDwf36RJnCd9XvMOYdGMf1Af/sPgl3tweU8kAzaNzO8m82T32D1/8SsDuHrewkjxHRZeYPs40yd1m3FS+ZmZ7IYw0APVBKcR3ar9WHgvNpDY8OG1oiaPZKW6uboB39DUCLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/SIkLdlwCfAKaSHnpyBQjoFHswi4PZziFDzWcXh9Yo=;
 b=rrW4cPb065HkfK1Ibb40IdxLyOtMwUdy7lJvOeqVoXnTvVEanwfkoa1ygLt9VBSLgTAN/htZ1V+dvW17NQgQhJomf1ZOCniufOFzki4bzxhFLBsrcUiWR12HPIyxkmc4+ACHTWrqZTT2h5c1RnX2n04W0ToAzlWzTH5hhN+CJvb8B5ieEc5jz42a04FI/YdjSvyrNTEZJ9mEj6pF5ZO1NUtEPB0VrEkSgvc/t4bGG2XPwOCgsVuWhmbhTnnh7ISBnaShIGpDhSowsixVIE60csj4hhLtE1727T//3m5wmTL06GasM9pLyvAUIqfD7F5VwuZIGsTbp5fqjawb8WmQ3g==
Received: from DB8P191CA0025.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::35)
 by DB7PR10MB2139.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Thu, 28 Jul
 2022 15:57:15 +0000
Received: from DB5EUR01FT030.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:130:cafe::5f) by DB8P191CA0025.outlook.office365.com
 (2603:10a6:10:130::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Thu, 28 Jul 2022 15:57:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT030.mail.protection.outlook.com (10.152.4.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 15:57:15 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 28 Jul 2022 17:57:14 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.242) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 28 Jul 2022 17:57:13 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 4/4] platform/x86: simatic-ipc: enable watchdog for 227G
Date:   Thu, 28 Jul 2022 17:56:52 +0200
Message-ID: <20220728155652.29516-5-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220728155652.29516-1-henning.schild@siemens.com>
References: <20220728155652.29516-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.242]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.447500-8.000000
X-TMASE-MatchedRID: L90KqhDWgfOUYAP3WXIsZ3Cm15xQGrnE2mwVXKpQ3BdHg88w74mNDktc
        8DbogbSE31GU/N5W5BDT/pFzauZLmXEK4P8QtiVHs3gZaLIY9no/aaS8hrB/2J4CIKY/Hg3AaZG
        o0EeYG97Gr09tQ7Cw/1BIVsvVu9ABIAcCikR3vq9vibMxAqYXjWHFPUyW8t4AX3DcTx0UaPNCEh
        brM/bogi6eQ3HQcWnw
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.447500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: A15FED269835BF8CF7C1A137653E6D19B4BCC571B4C79D2B4C34F32CAAC23B342000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc4a0a34-4daf-4f0d-0db4-08da70b1d76a
X-MS-TrafficTypeDiagnostic: DB7PR10MB2139:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vs2I7TvauCllnICd7bydGgqEk0wJVt9bnm0kJrHxXc2jaTT+cJZtxUoGs0wVut3Kwp1T6ikTinQhtdEMNE7gDGduktX39JDS2OD4V1j0T19berWsLDFgWpPmNFHFfpC2nHMHU0x7TA11aOoOgf/Iirku3TQP2Io5DL03MOPbZ/Q9LUHTUR1UgIXb7RZnt55aqL0tPbsME0iHLjJsZb68P4QLpwtdFIBJ4spLpJK1PqAL+3JpVqRTxbuY2No/mUPy8i9Zg2QvFJexHThyF1PD128FW8xtRQ0wHrpT7b+u16bBV8lXZJe+B6FeDAwpEjAL2l3Kwke/83A8zXo4CISf6Cs/6hDzmIGUJR7FrN+Ib3ew+OYq9cs95uikFlwhD5LXkfiGvoLg/Lavnv5+wFPXP1Dpfdbhw60kP+abhxgNXABvwFzqFotrUA3BqBd1JcrmuYOdhDgRX8SJ7zaDd6wAUn5L0GbvJ9FrQmNyc8eHCc/xanRQq8/uE3i1hNKIFYezTtEdSXbF2t3O0IEQQIA1u6hw9CYfIo1p9u1VAbiW1ekbNQAfj3yVNz5bMnyJxE993X3TjT6RaTLCfPyprpsRU20qeQudyMgKtCr7/Nq73sk8d+cgCI1lFETxz5/QU7kdKvMwPigXU52PcZA+ekUy7ezpraKBD9y+Md1jncjynZXs4jZQR1ZZlCDpaTiXPD86H/cht/5Pj1+M/VMot4x0z+yQDkN7kagrCIaJ8rsnXdIosIwARUl7tsGyVtpnnj0BnFx7tmQG1QnXbOyUf4BYpynkUDFv7xMf1VM0GjthcvrcfMROzLTRLhp77UlTSXFUPM/qh81iyLTLIQ+JFS58xg==
X-Forefront-Antispam-Report: CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(39860400002)(346002)(36840700001)(40470700004)(46966006)(336012)(1076003)(36860700001)(82310400005)(2906002)(107886003)(478600001)(47076005)(26005)(41300700001)(2616005)(40480700001)(16526019)(83380400001)(316002)(4744005)(44832011)(186003)(5660300002)(86362001)(4326008)(6666004)(81166007)(54906003)(8676002)(70586007)(8936002)(356005)(82740400003)(110136005)(956004)(36756003)(70206006)(82960400001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 15:57:15.1139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4a0a34-4daf-4f0d-0db4-08da70b1d76a
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT030.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2139
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just load the watchdog module, after having identified that machine.
That watchdog module does not have any autoloading support.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/simatic-ipc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index 1825ef21a86d..8dd686d1c9f1 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -96,6 +96,9 @@ static int register_platform_devices(u32 station_id)
 			 ipc_wdt_platform_device->name);
 	}
 
+	if (station_id == SIMATIC_IPC_IPC227G)
+		request_module("w83627hf_wdt");
+
 	if (ledmode == SIMATIC_IPC_DEVICE_NONE &&
 	    wdtmode == SIMATIC_IPC_DEVICE_NONE) {
 		pr_warn("unsupported IPC detected, station id=%08x\n",
-- 
2.35.1

