Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055CD54E5FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377884AbiFPP0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiFPP0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:26:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE4E3E0DE;
        Thu, 16 Jun 2022 08:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tbnhsc3E4UQYDXIGfcTHkcH3l52rg99/tiyMDXwfG/AbNVGBYUQ8z70o+K9J7i7976K7Gft6WhYaIrT5SgdKhLzP8Dkjs+2ScVnYz9OV7vdBES4GJo1NkwR9Pxm4LC25lCa695+QirwgtQ/uIF0ivCRsSJFU88WTQU+4oQxAq8eGkEX4DHk3yc85P2mcUctA8jIjg7hAB0vpIRuMh10VoplVEmJjpgTpES9HgSPKpKeLhr18Aum716R0Qhee26G/4iOiHHoS9jbR5AUscz2PRZjGD3R21jH3gwMCh6Nw/aWPAtzxluamFhfuJth+yPkgqXG14DdA5iH/kGX+3WPJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=056zqaav/O9xoKQlj4ASR/869+2G+tddCqrZV62HdDs=;
 b=lQ+3TU5kSqtKje5+uXiY6FjA+bRscvx5ZQi8Sw40P+QBYtUvplfUtA0tk2b8JCEBBODzwmnU2yosWQW1tKOfOUtgXAgj8O4HAfP9AbuEMqYkqKwbQtSpo3sy4i1fi+GZiiK+oCgXYfPfbeB8rs5fUOqHEH9jjk8yXJfsKRGumP2+pB26/PMcC0U2njTgGz6J77zjhYfliDewp13B/xa7FyNzTVPqZg+sN9ElNe/q6j8qSb071q1dYfGzhEGQFSHmv8DtkzR5RIooILhjAgDtMi3YwiQWwhAwU7PuIbTyWfbY5tRc21/CautgU1ehKX0XOFofyK5xrmNENcpUnzQzaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=056zqaav/O9xoKQlj4ASR/869+2G+tddCqrZV62HdDs=;
 b=N3c3kniTI+UJcteEedK3Mw+4RLSN+v8SAt9Q20tBwzyMmJkJ1Rt3IrXYeUZYP981DGlQ/v04HVh6c+rNlw+tzBYRjYIS1xsqan2EYlyqnYCtXPlSZf9aAOSl74RNlUc/r9MpAz+GKLyyXfjwzE2x5m949zMkswP89nkMPbe2qWM=
Received: from DM3PR08CA0001.namprd08.prod.outlook.com (2603:10b6:0:52::11) by
 MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Thu, 16 Jun
 2022 15:26:32 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::51) by DM3PR08CA0001.outlook.office365.com
 (2603:10b6:0:52::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Thu, 16 Jun 2022 15:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 15:26:32 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 10:26:30 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        John Allen <john.allen@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH] crypto: ccp - During shutdown, check SEV data pointer before using
Date:   Thu, 16 Jun 2022 10:26:18 -0500
Message-ID: <7be057567582b480fd10a8d3d8d6574af4a73f2a.1655393178.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3ddbd94-ee49-4277-92df-08da4fac97c0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4437:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4437DE20196F6C25874EBFD5ECAC9@MN2PR12MB4437.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8ShrgbVUPzpbrnZV6XyKfGFJzAvdKvl7zCSONeQnO184k59LzYFxgtirHQI3Q4UoxYV4Em3QDlnnX6rF+EMj/563zT0uKGodniojY+veh27ya6PLyPxlpMkm8wK4SdDHZAxK8Pfxjqf2l8c8FCNiqiacHCq45NIgV76XB9aGubsfRYmqOI35bB6HXbGgUKMuYb6zcSP5Noox/gP+A6wxNjvlGmaNGyDZa0EoxfRjIfJOmYWcMVAltu5Fakgx/EOBeuqPJllUAA4ECx/1R6ZpmoOjOrqEplxRkziErOw8zUM6mpfmuFUkflIqIPU6q6YkFzLHY5ia2VK95xcrD2g4/LKkKBMUW7ZDdtR9HoZCb14PoylRI4vQwNfcVIxZgHZXn7yqnpQycmYMScAqNqyVaS273PfpyUnPT/0boOR3EB68AWjGhRBfT3rx2BamOkc9WzplgIik66A3+H3YQYUvjrTINgwi/jHuPyeHl7cUmC6HXE2MvsdTsK374thGrlY81ltE0B77fWBhxH74zyR2LMsgV+8O76CXYCV+r8rUEQCbzruoHW8RIlqCdQOmj7pYpD5ow6192Q5glzPURwn6xFdeUIXnPh8p0kNWWM8ZvKCaPKTaO3DL5MK7ZntmVYQNWO6ud36CQ0OvFdTTdyFtx++re4X9+21hjJjJ/vcYy3myn4GyskM67BcwB4nMMJrJQ6rDUxLljh0XHKpx8iGFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(110136005)(498600001)(356005)(8936002)(54906003)(40460700003)(316002)(5660300002)(81166007)(4326008)(8676002)(70586007)(70206006)(6666004)(83380400001)(36860700001)(16526019)(426003)(2616005)(47076005)(186003)(86362001)(26005)(82310400005)(2906002)(336012)(36756003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 15:26:32.4202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ddbd94-ee49-4277-92df-08da4fac97c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On shutdown, each CCP device instance performs shutdown processing.
However, __sev_platform_shutdown_locked() uses the controlling psp
structure to obtain the pointer to the sev_device structure. However,
during driver initialization, it is possible that an error can be received
from the firmware that results in the sev_data pointer being cleared from
the controlling psp structure. The __sev_platform_shutdown_locked()
function does not check for this situation and will segfault.

While not common, this scenario should be accounted for. Add a check for a
NULL sev_device structure before attempting to use it.

Fixes: 5441a07a127f ("crypto: ccp - shutdown SEV firmware on kexec")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 799b476fc3e8..7baf7659c7c5 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -503,7 +503,7 @@ static int __sev_platform_shutdown_locked(int *error)
 	struct sev_device *sev = psp_master->sev_data;
 	int ret;
 
-	if (sev->state == SEV_STATE_UNINIT)
+	if (!sev || sev->state == SEV_STATE_UNINIT)
 		return 0;
 
 	ret = __sev_do_cmd_locked(SEV_CMD_SHUTDOWN, NULL, error);
-- 
2.36.1

