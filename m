Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1312C59A58E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350024AbiHSSLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350366AbiHSSKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:10:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9552C658;
        Fri, 19 Aug 2022 11:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqLoctpFmadJnl8Z5FK9XMuPtajXQTPn2foKIETR7fpwG0k0ITpt3KSeMa+02tCD+ukTWwCzAULRhtw/uCgkqRLvhEqN1UY84eml3aqMrhdGfYIk4+gfJtbJ1fWRDyNwGnfc5fg/Q8gxJ7OUqbvO6+6Jq+tF4yIGUpT7JfvRFYNMkjSqJeBhUDtDNu97quVFCfvX/L/pjDdi0VSsSyU66IRUC9so+nKwHvi+rEDmbQCx3nadkShWMdUzGQdcEvBEQkEnq0j0rRZ2YIKAc+LMZdzDxxeuJjwbWrGiYCQ2U2+TwVhFJZu3YGyHNRcvqoPeZ2oXmkCuGswiDA/VpOGjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Q5NaB7wUfiz4yjp32oggH3JnkRguUaXaVZkmVjuHKg=;
 b=dxYcee1kRf2B0huuiGGwHLyMIIdsgfSSAhf0Dn2H7s634S5BbfOdBIU3Q6Y90yR8PG2vrHB55oBFZ3r1P9cLodpHUbUFtNV0kVGp/YG+w/g7nWrj4r8MaQK8zDVRS+IY5c6h9vALZ+V1R51JF+X7Wn/Kn5iyDzIDqCEi2zKKavtbTqsZ8aF8nTGz1foi5AgmzTdekrzoBdjFqfLNJyFhCZLnLTgh4KVbrMWWoFQQMpf+6dPc0YOzEm9OVO6Y/RidY7NUVUYZtstbQ/JxgzK/Gq4+oECOSgM5h7j0phmKYPOCdmUG2E7zLiUtLpSdW7vkaWeuuQfScRe605uOy+16cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lenovo.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Q5NaB7wUfiz4yjp32oggH3JnkRguUaXaVZkmVjuHKg=;
 b=NzvwpIZk42MVf8Ldm/P14Ic5Hkk/iNBeMbRO+D/jDDOwyLShOT3QnM+hJAak5lh36WDPhO4QZC4o4YcOkQPROENzIgP4mNLW1hswDYW0sdJGCfuObalXKy6lonDVXSReXTUVwjH9omzRP1fbMIN9KZsSllJZz60Tla+/c/0/x2E=
Received: from DM6PR03CA0078.namprd03.prod.outlook.com (2603:10b6:5:333::11)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Fri, 19 Aug
 2022 18:01:03 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::20) by DM6PR03CA0078.outlook.office365.com
 (2603:10b6:5:333::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16 via Frontend
 Transport; Fri, 19 Aug 2022 18:01:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Fri, 19 Aug 2022 18:01:02 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 19 Aug
 2022 13:01:00 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mark Pearson <markpearson@lenovo.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>, <madcatx@atlas.cz>,
        <ibm-acpi-devel@lists.sourceforge.net>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] platform/x86: thinkpad_acpi: Explicitly set to balanced mode on startup
Date:   Fri, 19 Aug 2022 13:01:00 -0500
Message-ID: <20220819180101.6383-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0be0d1f6-2753-479f-c29a-08da820cc77b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lEeQATsFI/PO2uC0ebDiZpuC887k+pPfmwBUwVaunaljlxw7ciWeZPHzdm2HytBpvM84m3t2LoLh57mFmqoTyp7netGsygI5vT8b49N9dIF9+rPMz95+Bmh+6qh6HgRzaRHX+74b6z4cMI93Fzuu9RoCMEvlhbk1DzRUdmwvMQXZKdmInTTnn9rHxLmlMj1T7r7d/O2A83iVFXZjqpL1p0AJ13CsA6M+w0PKLtS8hvIOHH/FEa8MgZ27TJyvJR4WgJzNexksCph1Rg4QhiyGo/bEeSimZYDA9JN7uq+8v+wXP07nHJ4HKHUKLroqvGA41/yEiGmD+T1HlhEbjNL+CKqpjQyjiWmCkrsyP4K4QIyRqwgjfknELZxavjU0NM987alQu2ogxNQDQfbbLCban36CWuLBOilFlzb0vNBkeJHNLXy5G88jmJlHM5JjKhfetpdpniLx9ag4Zp2dyQBxAf+hXfBJghQMhqf5lPPJ2V2/xvygAynzV7Gy7SZHnK3ufggq/D4Z8TzabrQIcY9U+PBn8L91tZvZA1fvtVB9WXGbAHtIXCi5B3wZshxlv2WQ/gpN1s+cSx5msmXByWZtUuv+LXPjtchJlmeuxjXKujlSQq6TNl1ZcamIgdPvD16qbw9dicEouPBos9JFvRODCiQEv+zrZ+WZY2uEZWwSYvZr7B+d8GRdjo/cOy8NKXpYwZ78gSPvXalZxy4K4nURufFNshOpEqxUPQ40mjMtKAXiW0dcbcWtL1kqQnryNxtA07Z1X5bop0dmbOVdUDNKzoFj/lc0k/br++qxCnXnD//1x/ZfGuOFslmvresujVY9KLlwtdOb0vJOiN79pTC/Gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(40470700004)(36840700001)(46966006)(36756003)(478600001)(336012)(426003)(47076005)(1076003)(16526019)(82310400005)(186003)(110136005)(966005)(36860700001)(2906002)(316002)(2616005)(41300700001)(26005)(70206006)(40460700003)(8676002)(82740400003)(70586007)(54906003)(4326008)(83380400001)(40480700001)(7696005)(81166007)(86362001)(5660300002)(8936002)(44832011)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 18:01:02.3404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be0d1f6-2753-479f-c29a-08da820cc77b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
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

Reported-by: madcatx@atlas.cz
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216347
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2
 * Only run on AMD systems (PSC mode)

 drivers/platform/x86/thinkpad_acpi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 22d4e8633e30..2dbb9fc011a7 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10592,10 +10592,9 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 	/* Ensure initial values are correct */
 	dytc_profile_refresh();
 
-	/* Set AMT correctly now we know current profile */
-	if ((dytc_capabilities & BIT(DYTC_FC_PSC)) &&
-	    (dytc_capabilities & BIT(DYTC_FC_AMT)))
-	    dytc_control_amt(dytc_current_profile == PLATFORM_PROFILE_BALANCED);
+	/* Workaround for https://bugzilla.kernel.org/show_bug.cgi?id=216347 */
+	if (dytc_capabilities & BIT(DYTC_FC_PSC))
+		dytc_profile_set(NULL, PLATFORM_PROFILE_BALANCED);
 
 	return 0;
 }
-- 
2.34.1

