Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15414CB1E2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245375AbiCBWKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbiCBWKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:10:24 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2427AC9A1E;
        Wed,  2 Mar 2022 14:09:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie2AJ8/FTeniFcDKKcP8S8mT4a4WyBHeNpMxAP9y1WDgDdjFpgs2WrKGqMM3M9jIwi1t0VaPkIB+LuqJiwBH54qabH9TrmISYkrCYp8Y/sdBPprpWj0NXoNO75aJ9YxYgCcCMgx7DEUCxwkh9y8ZQHNy0S7/bNjqMznk6/KU5rpIbIey8qh8zD8RyvSDqb1XHNEvACLLd3LBPpIcca8snlhcEOPeROZGKUFOSdJLKoEpkvwFqLrBUgwjjHeXxBmiXzMT2mV9P3O4joxt3v74bTMJ5ar812sQvbEQewzVBzrhkRcws6XEX4Dks+LmHHz/15pTjObbwByvuoaWoKPu3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCqrZxd0x4LHePB1u+6qaISBjHoGsYqMHfzHZnmCBVg=;
 b=JBXmyJdjFCcwJsK92pPWeuv6r2B9lObehuQ1NsTE4LejWctOs5U0leWM2cKph5xNx7ES3jDzby2z0ofRRaFLMhxOED5obbwGQAPr5w7bf901hCg7Q/YazLQfoImiOGG41yaXdAlZ1GH0Wj6ul/FqHT93muZEV4IYavqg0Qmh/knhbkc3/g9VWh+GdxRDs8sGX02qYHHG+Alz7rkYdTnTAXLgUsZPyeQ4cIo41CBqY88sJzguArJ0/1XcIWDfzcT8NEe60PEDdCiIbprDgHFPbJ8MlgEl4nkXWT1Slpn04TL4P9LZhUdZbI6KIg/FpwNfO8JzzP/E6H5mUeZ6nZ1jNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCqrZxd0x4LHePB1u+6qaISBjHoGsYqMHfzHZnmCBVg=;
 b=sVKb3mq6wRwO5DFz0XbKB4mPgnnQd40JV56DLpePuLgO2ZMBPvhsTIUXqv8LSxEHYQu38eP9aImEArfAIZfNVqaVl4w+zLl95E9sDi9imVMNLBdmuIyEbfsxkajy0xgyHEaiVq98aIbMMuO7ZUb6tf2j0NzQDE26lwnzge+Ye14=
Received: from BN6PR22CA0037.namprd22.prod.outlook.com (2603:10b6:404:37::23)
 by BN8PR12MB3524.namprd12.prod.outlook.com (2603:10b6:408:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 22:09:20 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::b1) by BN6PR22CA0037.outlook.office365.com
 (2603:10b6:404:37::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 2 Mar 2022 22:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 2 Mar 2022 22:09:20 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Mar
 2022 16:09:18 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/5] drivers/thunderbolt: don't resume switches without uid set
Date:   Wed, 2 Mar 2022 16:07:06 -0600
Message-ID: <20220302220709.3138846-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302220709.3138846-1-mario.limonciello@amd.com>
References: <20220302220709.3138846-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b88c5a6b-ed1e-45de-7831-08d9fc994d18
X-MS-TrafficTypeDiagnostic: BN8PR12MB3524:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB352407E6BA93B1F85CD5D385E2039@BN8PR12MB3524.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BwAE/BQsGYJ7cXf0PbsQVY3TdnnxNALTakd+wWLSUz3P/8T48TdYyIAzNELp6NxSv8QKmC+WSTUQz7hDDwNK74bE0tO2LSHyc5Lz2Q0Ws4qGBLWAsvk3M0xPIOSSvZppkQk2wBs1mQ4IZbQ4SA9KlMGMCCSpM90ktO+D2aGaw1OHfxSkkugDYOfcI/q9poBi7VOx9cUhdcJqY/cml9rlK3MGQ52UubQ5gncY38b6BLhf59Kot0ND7MmPgOyHg0k5+v7Sxc4uv2jXluI1x4sCCKm/Hdeu0j8/cC7kw8YXGvD1h9wtuP3K5lC/IdtTfvW57qDlqLdopZIC9ah9mU+YegwmUI/RbeKqDBcxiuHfaXSao3h4FhLDmIWnX46XsYKLCg6LH4ApSIHNNROm1R+R47kZ0FwMW5IJmx63W/8uKMnRORNzv80rO+HjcJ5DtwdxoZEH5x+x/7drnu0YhF1nuzjGgrVd3zi4/SdABk200KODQrwnxV+UqAtQdDqA5/Op9id6CaNLdM2hwtm1dm+0t2dyV5mz3Eo/RW6x1rWTB06tSZekh9zhSQWJkBlHLIbT/xvbv8kKlWGemjzMRDydPMZhd0GC4tY9jzgX9K76GAjni/FocySRtvHFEo6p2K0BiojhYWderDiYe1LAkE6BzPDSj+CC4Uca9TIiOeQUmWJrXRFAZaNiBcV+SxLtYl2SCDDw72H875DDVXaAkns04g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(1076003)(36756003)(36860700001)(426003)(336012)(54906003)(6916009)(44832011)(2906002)(83380400001)(16526019)(47076005)(2616005)(8936002)(26005)(6666004)(5660300002)(186003)(316002)(82310400004)(508600001)(4326008)(81166007)(356005)(86362001)(70586007)(8676002)(70206006)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 22:09:20.2499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b88c5a6b-ed1e-45de-7831-08d9fc994d18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3524
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switches might not have a uid set if the DROM read failed during
initialization previously.

Normally upon resume the uid is re-read to confirm it's the same
device connected.
* If the DROM read failed during init but then succeeded during
  resume it could either be a new device or faulty device
* If the DROM read failed during init and also failed during resume
  it might be a different device plugged in all together.

Detect this situation and prevent re-using the same configuration in
these cirucmstances.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/switch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index b5fb3e76ed09..294518af4ee4 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2980,6 +2980,10 @@ int tb_switch_resume(struct tb_switch *sw)
 			return err;
 		}
 
+		/* We don't have any way to confirm this was the same device */
+		if (!sw->uid)
+			return -ENODEV;
+
 		if (tb_switch_is_usb4(sw))
 			err = usb4_switch_read_uid(sw, &uid);
 		else
-- 
2.34.1

