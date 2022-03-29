Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCF34EA5DF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiC2DTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiC2DR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:17:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8761D247C1D;
        Mon, 28 Mar 2022 20:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7eBfOhE67oUwDNkuQxm93P8xHFdMxi/7wPUS7hARFNuvP9ceVQbzEeHms/YXfSWT9Dcfyx4052c2HMKXKBuVhkBfhq1qyRGgGGuwk7OsVWwcWC54JvhnH1fzkBSAXGUjwwAPzB+wMgE6eEPZKw+qapk24Y88tElOCyWioOF+IiDCYReYf1lrt+O4j/8teKd+wIKiac9T6kLXrhYez3AG4tQg8sqA83fHoRoHAAlW5AzYUId7CmO3cE3+KnkK362sDJ1pDU+4k1aRHZIji0zceCIH2AEq6daYBpc7yaePQS5sj89/faYDh+1pz/v1aba3zVqgSMa5RmmOYOTE5qC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J7O4kk3tQimnKCE2CAtdQ7Z01mVVXKYeIjgyRkn9uo=;
 b=QlT6o9iutFYjeZre3QL2qEOqyanZM1cKm0jl0Lh6Z5YPpnXbQU4WkS8AnnTW2p0Abp5fGxk2ybrsSD7eYoziaQ29xabZ+Y+wBNFyYopdwUUgRtMpwgW3/WHC3ppj6RlE9s484pU4bpS8JGiOWIY6cc1rvO0jH/bjoF4L1b6yy7yp22aIjq9OadigaXK2DIf9BUXk6q+9jG9s1I+gAWUMeA10JOJ/VQVySyXeFDeREut1MU5Q6wDqEl9Hc393t496IqQyZGWTRA0x7sDxTe7EPvmgKgH1cg+xzjh/XPMPKu3sWPY/4RXMMp50h475zKo3os+l+m51ezn0OnxjDHkQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J7O4kk3tQimnKCE2CAtdQ7Z01mVVXKYeIjgyRkn9uo=;
 b=hMtWeLG1T+VYDe7H4KEIGZd0PIT+DAbrvbd/QHIN/oLNNSb23i1FrVnvZguUGJbrNSYdPPYVnlajqgUIE11kjGcK8YEs0L5/PIv7xZGIntZoHndErOJiMgcTcvFx3N1Qh5+/5IdU4x0dYwQgVNAFdNthgqwV6TbrcboMwUbJPY0=
Received: from DS7PR03CA0314.namprd03.prod.outlook.com (2603:10b6:8:2b::26) by
 CH0PR12MB5329.namprd12.prod.outlook.com (2603:10b6:610:d4::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Tue, 29 Mar 2022 03:16:10 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::cb) by DS7PR03CA0314.outlook.office365.com
 (2603:10b6:8:2b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Tue, 29 Mar 2022 03:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 03:16:09 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 22:15:56 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     open list <linux-kernel@vger.kernel.org>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER" 
        <linux-crypto@vger.kernel.org>,
        Kerneis Gabriel <Gabriel.Kerneis@ssi.gouv.fr>,
        Richard Hughes <hughsient@gmail.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 4/4] crypto: ccp: When TSME and SME both detected notify user
Date:   Mon, 28 Mar 2022 22:15:53 -0500
Message-ID: <20220329031553.798-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329031553.798-1-mario.limonciello@amd.com>
References: <20220329031553.798-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4819c36-75c7-4f58-538d-08da11327890
X-MS-TrafficTypeDiagnostic: CH0PR12MB5329:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5329AA8596695A234EEB2874E21E9@CH0PR12MB5329.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MUw97iWLe1gNLN735imp0isiWpEZBIN4/h3vmICaY7FeQHKmyslP459hVF5+gim3zeEu5hTe2+ZEM42ay3OGqp9kGOTPRfO38zejmeIR636JUCPuuOkC/fwQovjL9iGlO0h4Q60BliFD8Ed+25gBixv3Kopgl6gXw/ZdqUt1drEUg2/kBaD709ENP4vrKva13pyby598Neee6igZxFpVctYYetuXT+zMSP/+vgTNnl18h79qMZu5QQutpP7nIXNqi9QkxuTB6NkJ/r0uHc3DrgFnTsMhUx2MdTEtMLiXAUQZy66V6340+3pWOTd6S19p5DlZVthSfMZA30PtpXTdsIYNBZiC2x6XICXMkt7rTgXcjnzkXuEB7Cn0Oym2im0huve90S3PUvLJRlBBY99PEtVdDqHVfCezPRhWA/WhpAyCUeuNGY752xHPDbMMfcXA+1773U9cTJewqS1mpTAYKoCWFCSBlAVQhQhpmxv4HU7l+rLsVCjnoHPDgq/cD+JOtTed3D/NuPBgrqKhkeFl9aQw43GmtMO7dYfVm0WfQ45Y+BD+T2uUOX3H6r9/6zOpzKUIxuMnK3ubuS7C96XAN9sJHkjWlBYod4JE73fW+27LHr30dxHzXS2U7B8TO2SypvtLdvZNDPDpQ3Hv4kWaRwS226CB9MTPW3dQJPbX9cFu48fb2ZMpOaa0vxFeM8x0Oy6C09Yx0iScqgP/ak7/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(86362001)(36860700001)(82310400004)(40460700003)(316002)(356005)(54906003)(81166007)(110136005)(5660300002)(70586007)(44832011)(4326008)(508600001)(36756003)(2906002)(8676002)(70206006)(26005)(426003)(336012)(186003)(2616005)(7696005)(1076003)(83380400001)(16526019)(6666004)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 03:16:09.4170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4819c36-75c7-4f58-538d-08da11327890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5329
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SME flag is used to relay that memory encryption has been activated by
the kernel.

As it's technically possible to enable both SME and TSME at the same time,
detect this scenario and notify the user that enabling TSME and SME at the
same time is unnecessary.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/psp-dev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index 3f47b2d81e3c..0e3f1a332d61 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -74,6 +74,13 @@ static unsigned int psp_get_capability(struct psp_device *psp)
 	}
 	psp->capability = val;
 
+
+	/* Detect TSME / SME both enabled */
+	if (psp->capability & PSP_CAPABILITY_PSP_SECURITY_REPORTING &&
+	    psp->capability & (PSP_SECURITY_TSME_STATUS << PSP_CAPABILITY_PSP_SECURITY_OFFSET) &&
+	    boot_cpu_has(X86_FEATURE_SME))
+		dev_notice(psp->dev, "psp: TSME was enabled by the BIOS and SME was enabled by the kernel, this is unnecessary.\n");
+
 	return 0;
 }
 
-- 
2.34.1

