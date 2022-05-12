Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89A7525465
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357457AbiELSCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357463AbiELSCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:02:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806B12F3AB;
        Thu, 12 May 2022 11:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObTjsNB9a8wr8XqNZUH7unF99TDLEJMjf4L47t1ojn+RlEIsmHWHHY2UyYPi4aJy7fbo9SS+kxvzb5KgiwBs/PCVcGBbaB4b5WQc3ULtrJOLWmE+nYDsS6S/ory1nOayn3u1d56B40+/Mbt1x4tTDCHHm0vYX9HAFpgZiaBjv9XSLyU4rkHNlZZ19a1qG7aSTxJFjHY5SVD759zNuGqZH8LBE9EdaXEuPTUwmQL9SuflsCmL6102Pdzd9KLarODh5L0WaZH6Q8IErk3pijfkbV/mXcMlifzK4gQn4/0AE4D668gykI3aBl4HvvynXC1O5fr2YBWsaFnr1/OZtd5UFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0NEAZbcL3Cttzurcyd+0XeylrS5T43t0Jzk04zfkPQ=;
 b=iqsOQKgQsO14JpMHME1w+zSmzY6dunsaosPpB0uRIOKIRTQLERJv7xpazum07ae9NqrmyjPhjoNABqFL2QEPZ7JyrHlOMehEhWuTt3E8ryIWcY9OYecr/hFrZ7LqbPemvvcXm9BF40sdJB9JdmvhNiv3Ggyti4bqA5+RVkMqgrCufgagwBwMVzo5d+9SX65jeytTui8Ow6vH7ld2aDQUW3pjg6BADpocyR7v4pNC/wbxsjXQ8BRTeKNoBbrc9ZhWrlLSyvoKHcKxN72h/Bvvvvg/w1UFXBTeXRhYLJQmKJLIOeKiXdFY2E/6YFXmtWwvlN9xg7OUrLBoUz1Oa6fVAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0NEAZbcL3Cttzurcyd+0XeylrS5T43t0Jzk04zfkPQ=;
 b=lrp9w/fp4FGv3594uPJ10CKt0vYyvlpURpMk36Uck2NjJgGLXUb3x4QFlAsP9GHnMaYiYuP2l9ctw03vrKxxkCPeaB2eFS9b/gW2EhzfBtAqiQWvbNKeVLbRB6mtDSdGhRFteC3zNdm6UWv2mmw2uxO+P2rG+QarHUzldFKIjyw=
Received: from DM5PR07CA0117.namprd07.prod.outlook.com (2603:10b6:4:ae::46) by
 BY5PR12MB3698.namprd12.prod.outlook.com (2603:10b6:a03:194::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Thu, 12 May
 2022 18:02:00 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::5c) by DM5PR07CA0117.outlook.office365.com
 (2603:10b6:4:ae::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Thu, 12 May 2022 18:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 18:02:00 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 12 May
 2022 13:01:59 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <jikos@kernel.org>
CC:     <basavaraj.natikar@amd.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        David Chang <David.Chang@amd.com>
Subject: [PATCH] HID: amd_sfh: Don't show client init failed as error when discovery fails
Date:   Thu, 12 May 2022 13:00:43 -0500
Message-ID: <20220512180043.26206-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e266193a-314e-4717-8ec8-08da34418323
X-MS-TrafficTypeDiagnostic: BY5PR12MB3698:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB369814F11D519CB07A6EDD63E2CB9@BY5PR12MB3698.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HT2TCClecP23Q7SwXvP4o5oA5UNSP/FGFd0lzTHI5XOLu/y7hudNWOf08eOfaKnWX86YFRYbJGqB7jrBWljvFJ3smHqVP6hY1Eahnmgc61CAAkOiMym9XzoBpEGYCbLfRWRldH1K2AgVys1hRd+t+G4XnXy6SEAoe+9sWZe8ASeYJV/gNa15li2fq5ZZM8Tjr27HqsZhBh6MimEOsHc/7FCr5Pis2+YhzI47f0ssPN+Fv3t2UpIqmowIB20iuOed9C8XPPcOW5yNz8X6rMUQONMu6uTDK24GllvohrSazEI9MqzSdlAV2Sd1FVw+1lmOO0Lt51jorbAX53sf1oWuzivuvn0nk8O5r7hm11ygfoPcdwxhw3Un7qghRbA+vfz8hIxqTG/gt0lAuo1avv8mz3zQx6x5iYK4guGDmUnsW6RZe9yM6L6FoajMk5SjffUXBg4XM9pBRJz3z7fJgbAlbQa1zM0F1Sysx9a0MiwXZcX4yhmNzOq8dS0VWNzuyA2inQX9w5jakfQ93DzsdWXQQmdtsFHw/uuu7cggFsE7ULU3sIpGFVBHBHujrhuwZgY9raNPMKxZWrBe7izGT4EVu6cwRQQVLgmmQ4HfcMtaITVabi4xjUxOiocdg54Chvs86WbiIGi5png8KCeV/c1FPEkXX1/Ntzp2qEiUWULZtOE+7QR2wnz3jaFco6yZu2lhL+TXf9n/T40gg1BVqT7rTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(6916009)(1076003)(40460700003)(316002)(7696005)(16526019)(26005)(186003)(83380400001)(2616005)(36756003)(54906003)(508600001)(5660300002)(8676002)(8936002)(82310400005)(2906002)(81166007)(4326008)(86362001)(70586007)(70206006)(356005)(336012)(6666004)(47076005)(426003)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 18:02:00.3073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e266193a-314e-4717-8ec8-08da34418323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3698
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sensor discovery fails, this means that the system doesn't have
any sensors connected and a user should only be notified at most one time.
A message is already displayed at WARN level of "failed ot discover,
sensors not enabled".  It's pointless to show that the client init failed
at ERR level for the same condition.

Check the return code and don't display this message in thoes conditions.

Fixes: b5d7f43e97da ("HID: amd_sfh: Add support for sensor discovery")
Reported-by: David Chang <David.Chang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index dadc491bbf6b..1441787a154a 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -327,7 +327,8 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	rc = amd_sfh_hid_client_init(privdata);
 	if (rc) {
 		amd_sfh_clear_intr(privdata);
-		dev_err(&pdev->dev, "amd_sfh_hid_client_init failed\n");
+		if (rc != -EOPNOTSUPP)
+			dev_err(&pdev->dev, "amd_sfh_hid_client_init failed\n");
 		return rc;
 	}
 
-- 
2.34.1

