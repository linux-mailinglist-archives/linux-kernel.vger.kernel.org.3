Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF556599D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348599AbiHSOBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348088AbiHSOBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:01:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF23100F02;
        Fri, 19 Aug 2022 07:01:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFH8LTpSuEL9N7evyf0+Sw4HXgrR0ClCR7cPZbgUYJOs/Lq4Khxf7h+fVztwNoZqlLdgu1WNScsHRjdWWBx9tyFKnW2mxkOUwdnDYtzEMo18qd1yTWveXRnSUV17abHghKpmDx8fvi0rrvAhR8i0pi1m+uSYYNNEfSiAqU7VrBlBROjzmdq17SZw12eD3ftvN9eJjKCX1r+ObU137LpSoWQE+nRTB+5BTQD2/R6gYLfmVeJiISxVQ/OS43Agercss8u4HPeQDW6ZexbQ4j7Ci+gcHbXOXwrIXaY/zw/LxPal0AttRpeO/Tr4GUqzbQfIEZY8vphg5wSOZNiq85RYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYTkj8xFA3R2cKbZBR39a2NwQ/2nj1ToZHO80BLKq4E=;
 b=AWaOWzxPqbD/T8r58CN6A+svccLG9xjKJsOUs78b09aqWwgkm1Z9DH/KyvcHDplqHErlgbD6bhSBaN2X24Mg67A0VMd1/8h+afexU6zqVsVwrg6kJk34JgwQxczlF9rdPYE5iY6mFNfMrQkwvl3nw22YPTIUXzqFdd2hhCamnmn8Zu8c8JRcWovt814yXWUQdJ4V+eizaQHFoa8DuRYCWtq0IVYFMWEKPWXPyYxEd4NtFiBFVILjNkbFweZ/gJVujFwTBwK0l1bJam/XLMTihqNPxjw8wt+b4rnyMLnEO20YpDucMWOurCQiwRnfifbLoV/z+xAiHKyYavjAowtoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lenovo.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYTkj8xFA3R2cKbZBR39a2NwQ/2nj1ToZHO80BLKq4E=;
 b=ZB/Q9nuw/qJSmd4FCRespHfb4zXHetAxy6nQCBbCeKytaoUgLjweoeIkK/zu4rZqDr36F6TGyFBqYIaQi8rLvBFTqNJXxs+dkSNSsBQiZ47A8hN/GqUgm5sa+giBglRpwnsAyf217y+Snhdd58I3GZ87H7DWicWfjiMN+f3mXm0=
Received: from MW4PR04CA0037.namprd04.prod.outlook.com (2603:10b6:303:6a::12)
 by DM6PR12MB3852.namprd12.prod.outlook.com (2603:10b6:5:14a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Fri, 19 Aug
 2022 14:01:45 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::6e) by MW4PR04CA0037.outlook.office365.com
 (2603:10b6:303:6a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19 via Frontend
 Transport; Fri, 19 Aug 2022 14:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Fri, 19 Aug 2022 14:01:44 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 19 Aug
 2022 09:01:42 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <markpearson@lenovo.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>, <madcatx@atlas.cz>,
        <ibm-acpi-devel@lists.sourceforge.net>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] platform/x86: thinkpad_acpi: Explicitly set to balanced mode on startup
Date:   Fri, 19 Aug 2022 09:01:42 -0500
Message-ID: <20220819140142.4925-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97636eda-d74f-4a84-9e18-08da81eb597c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3852:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Q+MrYM6IdrsZ6nedzmFGxo09NIRYSlCqlHpJkDeDMg0Fttl7sZiABt6g62kkO3q89nzUyJgV6QVf+f3fSRlYUkxh9g+4X6q7c7UlCSGuT2pdHphyhfnKAYjeQyU9MQrwtsU7i6ybzkt3qo2SyrMcpHQU6tCEUse6AFbn/Imnu3ujq0t6jX68pad606DVMA+W1hc6roR1/PvPyykQPEsxF2p6VP4waDYNelNPzI1zPHDmRDmkcT7oEysai5YgL9BenJijx7GLXF+VJxEHKjgIxzWKaUGONcb+4+rStKGy1P2vmyAiKZlBqbvkeaa6TjjO/CdZjqNHosGK1vX5VHXTIpbcR2oltNSoL4w2feI3dEnsUhoUCXFpxMsNEQvgC3mklG8OIMHW0qM8JT1QFLRQtpmIcjvoaGmC6WMzBoAWQ4OJQYJLC8wBnMKBENMzRucyPKwBMhUz1UvhKzQc1Lju4jkdXBTqpt0QAEougQN9jy9VqzjUUq3ymEc+5TmXN8s3L7nDX+VP7+kQ5u+64XlVsuNreNR4m+oUd78mdkXD+wPGwVfVIRVniq8Qd5k3g6B3lsa0P3lLSyubdRf6rIlXqMFiW8wkdFQW6ICBT0MWb3usECUmffAVnGOX6/eLwce7Y3DdnSzM30dpY0vOkLm1mrIyIpv+6AhVVurBsKpXNrbsTFJVm1w0O5nu9q+AjGQ5lesUI57LQRBfb+tXaVYcjsCtS8DPzqQd7zg9eB2G0frFmjR8Fe7DmPvu/yNfslHFucu5nspgKcXac7SfnsZGy5aazY+n3sJ8V226E56h37kqWwUmN05hiTc7y+ktjMHg1Q31EqxnlzZlc5YxOqQWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(40470700004)(46966006)(36840700001)(81166007)(47076005)(82310400005)(5660300002)(8936002)(2906002)(44832011)(4326008)(8676002)(41300700001)(7696005)(26005)(36756003)(186003)(336012)(966005)(16526019)(478600001)(2616005)(1076003)(426003)(40480700001)(86362001)(40460700003)(356005)(36860700001)(82740400003)(110136005)(70586007)(54906003)(70206006)(316002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 14:01:44.3108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97636eda-d74f-4a84-9e18-08da81eb597c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3852
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was observed that on a Thinkpad T14 Gen1 (AMD) that the platform
profile is starting up in 'low-power' mode after refreshing what the
firmware had.  This is most likely a firmware bug, but as a harmless
workaround set the default profile to 'balanced' at thinkpad_acpi startup.

Reported-and-tested-by: madcatx@atlas.cz
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216347
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 22d4e8633e30..e7e86c0b9ad7 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10590,12 +10590,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 		return -ENODEV;
 
 	/* Ensure initial values are correct */
-	dytc_profile_refresh();
-
-	/* Set AMT correctly now we know current profile */
-	if ((dytc_capabilities & BIT(DYTC_FC_PSC)) &&
-	    (dytc_capabilities & BIT(DYTC_FC_AMT)))
-	    dytc_control_amt(dytc_current_profile == PLATFORM_PROFILE_BALANCED);
+	dytc_profile_set(NULL, PLATFORM_PROFILE_BALANCED);
 
 	return 0;
 }
-- 
2.34.1

