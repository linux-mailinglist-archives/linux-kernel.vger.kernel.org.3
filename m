Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F231D560ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 22:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiF2UEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 16:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiF2UEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 16:04:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E683227B2E;
        Wed, 29 Jun 2022 13:04:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPW0Dq7PfAr5msG6Lbzv3rfgnw7ggxcFeK/xHZ80ATK57zI7znvTozXNoytVcgxofQJ+Kwr0sknGeMKDt+sQlf/+ZDWhdolwJWlALXFHj4la1rwmDcxVQvKn4ONAuNZJtfqe9G4eeVXdFd/sSQZDlQ98+MXb8fsf92vxGNMjYFNXVDvu/afepm+G6USlpkjayK+hfoAsyL0ZmD0VdNaMGxalGvmJlM27P3u7mQDgf2BBVGwWFNYmflGrTtgf5lXHf6l8g7Wrm9YJghYY+tmzibR+19+oHMKrDvZr3YdKyNgXSffHbVPDCiywswi3KVdIUgATqV+R6rsBIrEIsfirVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAywXrlulQ+NbpJHaAcnt0ynJNjLIRkJ2AiRVI4uSqY=;
 b=UW5D8bY2IWyNoj9EyMylRDMgWUxRn7g753UPbgjdTyueVX8/Bs3NK06VLxt3ay1wuXk5zm9/A9O7qSP4JN3IMWy7y8Ic3fldrFmmuogmPHFb2pfB/sC+nrdFMfAdsbr+YOi5k6UHTSf2jC/X4S36Z+VddPCJx55WWwo3PfDC2E3I9auVn0yK0uLmrWQ2VdAvbzh5Ol6+jTva3Mxa2eG+FIKICcZMsWeQ9dEO6/8rDQOYuTpMLPNvBCmlHwwLnPsW8tQmIbvr80SAemrIPsTZ5aJOwNtN7a/G3TGozrnE7wvr8p/GWPicVZj+Ks5XdhXdXL5+RWy76yj9nl0R8FeFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAywXrlulQ+NbpJHaAcnt0ynJNjLIRkJ2AiRVI4uSqY=;
 b=FC9zjiYoFyBDd8rNDwb1t8YEzBKgf/p+he/xOMD0MAq6t7zW1cZcibujTUfWKzAJpBj8C6ONsKRxGGV80hPb9QWCdrXPMro7t4bF/4LaKlCVgJ2+CsPPYFl0TNkUayY0MXSmJwyj6GXCy+LyvVA/LUWa+E1fwufVDsm1YSKbNj0=
Received: from DS7PR05CA0089.namprd05.prod.outlook.com (2603:10b6:8:56::6) by
 LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 20:04:30 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::6f) by DS7PR05CA0089.outlook.office365.com
 (2603:10b6:8:56::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.7 via Frontend
 Transport; Wed, 29 Jun 2022 20:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 20:04:30 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 15:04:29 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>
CC:     Perry Yuan <perry.yuan@amd.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is supported
Date:   Wed, 29 Jun 2022 15:04:32 -0500
Message-ID: <20220629200433.6103-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91f89409-fc75-4fbc-5548-08da5a0a9400
X-MS-TrafficTypeDiagnostic: LV2PR12MB5942:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2mi1ieKNcXfcU2HNkb6Ve3w2coyUBU7uwBtxKfpPDY6me9r4LvlPXIVmV9rPdO3LgSZk/s1tx7XBQhMrjWoogPG/UyZnYeUmfeHmHrDn6TQGl7mCDL8MfVbXKdADYVajX/W5pKPe4nNdKfkne6ABol4hzJSsfdRmgSa/Ylv7+ZVTnOcS7qMwz0+408D0rBT2Rvs6QkQdnS9c7+9Qb61DVfw9VRwaxXWroPl64Iyt0HQ9dGYt9uKP/VoTTLjEQM+VgSfdwt4MS9pZg4idbsZxmrrYa3r/i8y0xA1GvAmNcTnDbAf/NmJlMx0d3ormPQh/8iht8xkDG79z4YQCm5N+jUrmmqOYaHEs6bTJQQNLjLGjtEYV19vZVcAJQd8L+SH1ju6NiVtY6sa86UQ5S6gl6lqNiOA0a10nezt3Z3jwExWJ0aGvmi64UXjletyeKVldWqBOIRC0TGiZUsYmYqZXCnLy7f1+ioApdngUtu30UT69PQo3QKVkn6uYIgzDmBUhzfdJIIEFxT8g1AYVUjQ4k3kcfU8xhI81s+O5zy2w+6tiPdwM7GAZDZmkS5glZyQvQ7nVLuuPSjroOwN+uHuG1wN3UPGFR72rGwmp1SwlCXfRL9SI1eDzsWVnEr2krmQSqdL7Hz2m30f5q+Ifg2VYRgjvbpRAl2CGkwuQCi0BtI/oLOmOiZnPnPSjITvG9+p93S8dx8Gm+idjTOUelJOmYuM+oP7SowD5vWXZVt2y4etgIYMCpC1rKOO6uQdZMAzYzKzEaDPHPdr7MYdnaY8xnm3Cdvf5/Dm4NnCf6qT5iYKRRSdv/+hct9eWnh00LY0a2+dVm4AEIjJ6xnytw5JkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(40470700004)(46966006)(36840700001)(70206006)(316002)(426003)(40460700003)(26005)(1076003)(36756003)(8676002)(8936002)(82740400003)(40480700001)(81166007)(82310400005)(2906002)(7696005)(2616005)(16526019)(86362001)(356005)(4326008)(70586007)(54906003)(83380400001)(6666004)(336012)(186003)(36860700001)(44832011)(47076005)(110136005)(41300700001)(5660300002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 20:04:30.4475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f89409-fc75-4fbc-5548-08da5a0a9400
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 72f2ecb7ece7 ("ACPI: bus: Set CPPC _OSC bits for all and
when CPPC_LIB is supported") added support for claiming to
support CPPC in _OSC on non-Intel platforms.

This unfortunately caused a regression on a vartiety of AMD
platforms in the field because a number of AMD platforms don't set
the `_OSC` bit 5 or 6 to indicate CPPC or CPPC v2 support.

As these AMD platforms already claim CPPC support via a dedicated
MSR from `X86_FEATURE_CPPC`, use that to enable this feature rather
than requiring the `_OSC` on platforms with a dedicated MSR.

If there is additional breakage on the shared memory designs also
missing this _OSC, additional follow up changes may be needed.

Fixes: 72f2ecb7ece7 ("Set CPPC _OSC bits for all and when CPPC_LIB is supported")
Reported-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Make the code easier to follow (suggested by Rafael)
 * Update commit message to reflect this is only fixing the MSR case
   and that any other breakage from 72f2ecb7ece7 will need additional
   follow ups
 drivers/acpi/cppc_acpi.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 903528f7e187..cc154519c608 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -629,7 +629,15 @@ static bool is_cppc_supported(int revision, int num_ent)
 		return false;
 	}
 
-	return true;
+	if (!osc_sb_cppc_not_supported)
+		return true;
+
+	pr_debug("Firmware missing _OSC support\n");
+#ifdef CONFIG_X86
+	return boot_cpu_has(X86_FEATURE_CPPC);
+#else
+	return false;
+#endif
 }
 
 /*
@@ -684,9 +692,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	acpi_status status;
 	int ret = -ENODATA;
 
-	if (osc_sb_cppc_not_supported)
-		return -ENODEV;
-
 	/* Parse the ACPI _CPC table for this CPU. */
 	status = acpi_evaluate_object_typed(handle, "_CPC", NULL, &output,
 			ACPI_TYPE_PACKAGE);
-- 
2.25.1

