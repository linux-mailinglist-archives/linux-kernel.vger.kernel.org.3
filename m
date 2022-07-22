Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF87157E97F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbiGVWIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbiGVWIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:08:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E4776EB7;
        Fri, 22 Jul 2022 15:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=babKHHW6phzuFVZHOHR2vsjMGkujC6kzgVY5goGMNETM/Paqj4UCQY1oaWGiqUIp8hvmMw53KM/U8l3W02nyDhRwuG6qTSv+eL70kGXhSwXLoyepwCqtkf9AnHHVPG9rsQ0Sk3sHy42/ZR+6Kl4HV2yBEXhAXoCxEBmj+8bNpB1pykCjrikV9AogpKwcrW+IKF8hCr97n8OhYDAByfa0L9XzVyN6k53uGR0TrhC5M641rEAh8OpklegeawWlmNVIEMMQkiqo8E7z0o4+2ezNNEAkKIzKLTKryEKUSs1Qqj12G6l8cPwbDQ0PbwYUefsYPP0+30aT4FZQKumSz/WcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/1JjYnGCzGnluRBUfFNHapZL5Z5LaMpZPx9ojOrH3A=;
 b=J5vi60/7NwWL6PXxi2PW7baPWwWXZOKFyQZcy8ah2mRIFbd4P1HdFnUAuCq2mhmG+bXisPh8aevi8QSCCyUWkA+6acHJ1Aa68LF4w8MuuEqtJg8ZRqrgQkTFFTw2YLi1HSqtt2CjnzBBvZ0W3OJaiGxoYKKJpG/8TtsmZGQB99tnan88Tdnrmxhps1tMZD+EiZnlMRYhi8TmFeibPdTh1TnucPc7Oqs5wZ49CWFffzS3ljbqVsMWGtYb9vPWkqel8/MQwYhs2/EQaOFuyqpwHgwVlIsPDqa6qQi8Dv47IOR0IxWvch0va4v5WTftO1uSevsCoaX1CoRD7PDPG3P6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/1JjYnGCzGnluRBUfFNHapZL5Z5LaMpZPx9ojOrH3A=;
 b=osxnga+YXvcfhtWrlRB9pHOwTEWfjq/kYW70/uMCd9s6HKcJw/0BCsQ4cSmqvIpEO7Bti8EIpVsKaG29mS5OnQ1grJzFBwn1bYPKowxv5NsVbc0cz/dyHXJvHAphfSDQcTe0bkBxGKrU4EEbXWLr/TD2womlZu61P9+HejNrQHo=
Received: from BN0PR04CA0064.namprd04.prod.outlook.com (2603:10b6:408:ea::9)
 by DM6PR12MB3099.namprd12.prod.outlook.com (2603:10b6:5:38::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 22 Jul
 2022 22:08:16 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::17) by BN0PR04CA0064.outlook.office365.com
 (2603:10b6:408:ea::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Fri, 22 Jul 2022 22:08:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 22:08:16 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 17:08:15 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] pinctrl: amd: Fix newline declaration in debugfs output
Date:   Fri, 22 Jul 2022 17:08:09 -0500
Message-ID: <20220722220810.28894-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9456fa0-a888-4f28-a713-08da6c2ead9e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3099:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8biqH0HcJ0AdR8/k8VBB1CT9pLzdp0MCZklnJqKLPH6X03qzXH0UT27gO0A79GDASDtroD4Ko3RRktAnVDLGGVO6KAv01JSxzQfZgXwse/QQa9FNjVLdKhQnroUru+Oci0nQ6zTkYKYkmhbh/ni8ylOuR/zw015cdWg4Q5vxVfwsk4K4VsNClu+krT4CGO8itBb8q5Y2bkGbt8qeWyiF8D1ddFLQsxkvq//wqvQ7spq41IjG8LQlnMXLwTIOtanvYj3d7DgVXlT1fKryR3sCbXhYFbdv0/Kd5f8MJXHfk061/CJkkcuaIAmzQi7KHvkbeLZBLsxR/hKcDUZ9/586jOM5EugVNktt9k0VWDX4KF51hlM3EaeFhzclQnLUPx0c1NSvr6fb3TrKDsRN/HOyEb1zbt02/vf1CeZf1KUJ6zVnJuSxVBPdtBmhs72talESmWPa6r6vCCZTwd+M+U7KQIv1uNyuSQsMqWREaxrXHX5xj432aAkdM1tR+vwwQpIeDquOGCVmSY8tZt6D8YQAcUzsoyli+lf1J0bR9Pw8y6rqYXaOnCS+3rs4uxgAkXOIq9x23lurVxtntq8u8kpsJuwvcT/6ezY8iPtISWREvFW/QCjP4pT1FSm5QyMMOE+lWDuWOWJZ+rE/43hLKjiqSpfd1ADJM+fR8XdbfTZs3xDlJP/dBS4b7hEbYbl0DuQCseTbGHPr3xp4OcD5LxhAYoxpIeOADXtlC62PUn7M6sQA8thdPFA9Xv0sRvFVzOETkZk9XY9NTwTXCTd28TwO1OM2PCj+2v5JnRK9uWsNR8pQ22bEStGmm80wdCxx5ugbB2rpSPaGqJ0DUQwMZmEaVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(40470700004)(46966006)(36840700001)(86362001)(316002)(36756003)(40460700003)(336012)(54906003)(82740400003)(5660300002)(81166007)(110136005)(356005)(8936002)(426003)(4326008)(4744005)(6666004)(1076003)(7696005)(40480700001)(83380400001)(478600001)(82310400005)(26005)(70586007)(8676002)(70206006)(186003)(2906002)(36860700001)(41300700001)(47076005)(2616005)(16526019)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 22:08:16.2872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9456fa0-a888-4f28-a713-08da6c2ead9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3099
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the debugfs output for pinctrl-amd puts the first line
combined with "GPIO bank".  This makes it a little harder to process
as the file needs to be manually corrected for the mistake.

Change this to be a new line character instead.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 0645c2c24f50..b7f34352b5d4 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -224,7 +224,7 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 	char *debounce_enable;
 
 	for (bank = 0; bank < gpio_dev->hwbank_num; bank++) {
-		seq_printf(s, "GPIO bank%d\t", bank);
+		seq_printf(s, "GPIO bank%d\n", bank);
 
 		switch (bank) {
 		case 0:
-- 
2.34.1

