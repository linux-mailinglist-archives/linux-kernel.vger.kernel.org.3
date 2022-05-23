Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5858D531045
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbiEWLax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbiEWLau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:30:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9889A4F479
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E08PxoH98zZWNcsQTml9UIBnY5vPvwwBlSrdXHIS1o/mascHnGtpHmWwESt+TwGg724wgdl8/K7BMRU0G234P65ULBg3Q+TG0zE5MafCEBLi/JBG5vIp3kRuUl+ebrHMeRZ+2kbWQfFHWjIsfbBJtK3mSIfDNNyVVcW1cvnIdlGZo7a0w5tPbbkuPv683QTlxGWp2t+8Vpdtc+V5de6sL8LwDwHyGA+DVbCvq64A0pfI/8GsfHGhlOAoKTy8vVMImzDijhGqVOL6JxryKw4pBaOMY2J+Vc0pxgmFodO0AOoMbEiDUkiwbQUPpOCGkm27uPy3jdePLBJsl6ZnPw6zeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMTYoLt11ZaYE1U1BYzrGqbPnmLeIEx2aYALfI6mm3c=;
 b=aC25XajS0uqa6eDsSTi8y5HLa2BphosTC1fTklRs+pOCsio0JejtpKJc0Xv7RCT4Loe/C5sDCDcw1a20olOLTUgCk784InMEWXF6/7FjZboMvHDUP7YGXMOKPVlk69XvK1Jwt6Q63v5xvdkFuicxDYXXNExP4SFNeZnq59siMitNAVstyLgltlfuOC/S9sAPrq6YqkKyvYSsQwYpsfwBAQJJaFjfzY8LVkxSkSfEthln+tAD9zrNpy3VX5+761FiuhOwDOLa1DUTJrGChvN28GrGRsHP5IAeHSHGtt97Rn/1e7HpO2Z0kU9PVZLAEVj1LG32JRF0HqddFTOWLWbvYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMTYoLt11ZaYE1U1BYzrGqbPnmLeIEx2aYALfI6mm3c=;
 b=1iW6Smha3SjxHmx4wWK+Jb1aLPi0WyUx7sUUpSwGNABEypzTcgvo04fIAdP3/t9kFQcxhPufTQqVPRO+DcXslzcmW0VyRi23or1lH5VdiCd0CzYAyiOFjQNu/ODnMry6g9dP2mGU6CFVRsO2Wt9qF9O4v6WrtxNNybasfZgMz8A=
Received: from MWHPR14CA0016.namprd14.prod.outlook.com (2603:10b6:300:ae::26)
 by MWHPR12MB1741.namprd12.prod.outlook.com (2603:10b6:300:10f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 11:30:44 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::7) by MWHPR14CA0016.outlook.office365.com
 (2603:10b6:300:ae::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17 via Frontend
 Transport; Mon, 23 May 2022 11:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 11:30:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 06:30:42 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 23 May 2022 06:30:33 -0500
From:   Syed Saba kareem <ssabakar@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <ajitkumar.pandey@amd.com>,
        Syed Saba kareem <ssabakar@amd.com>,
        kernel test robot <lkp@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: SOF: amd: Fixed Build error
Date:   Mon, 23 May 2022 16:59:53 +0530
Message-ID: <20220523112956.3087604-1-ssabakar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 473b6918-063a-4e42-e74c-08da3cafac87
X-MS-TrafficTypeDiagnostic: MWHPR12MB1741:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB17418B1844CE394131CCAE77FCD49@MWHPR12MB1741.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9VyrolCUyTupML8s61CX2FedS2aQ69OiOQUERtUNcje5sHdH6BdCSI7o72kXcvhaMfWUrxKx061RPKMgJiKrROaYWyT6A3UnUKc1Us6rd//iPVEu+6jENsWUmcsXw/Fwby0SVQR6xDDDuodunwTaSzrapwiQCxmKlGNzeb4w99f75fRUqso/amBO0qHoJrqM8EuaqooLuDyYSMMNfiJK06ti8jBi+/06ZsuA+mFq1xOJ8MKy3/EIqYGN4C6lCXfm403cbRQFzGfRNdoERs/eWBogzxBd29lYSZ3zNoi2KwAWkDWL+WBwCFuoZXMxQD+hbMY9GCL2zMfKLcio8Qa3gCf0QGxXkpzEE+3gFgr+rnNDWg040cUW6YLq/j3Vnq+aYCnfTU3Kny5++DFbwGKdYMzsFDFqyv0Z79kfqQaABCCXs7O/FZnN3TSRhhv7Cyd2ZehiWMnrtALg8XbI3vjrum1fuDOtIqyEscS2d6tFZ24SC+qgaUIi89pKBFJRHaEPrksNQW9DG5ZVOi+N1C9fnd0LTmhSBrP9K5F3MystrY/cPML32BLdYBeUPMRYrBHwHpsp0jW7yd5MpFX72ZeQj7igF/NaS3/ywkO4rDNpH97fL657kAR8EiHr22aT3zfDE6gC7G1tLdVp6a8Sf1QMKwJeb7lIAwLWdcB8iIMOvuAzjpakc2U23nMaOL0HZVdc/63IBjntBrnhwaY8SKK2iA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400005)(2616005)(70206006)(70586007)(8676002)(4326008)(356005)(7696005)(508600001)(54906003)(110136005)(316002)(40460700003)(26005)(81166007)(186003)(6666004)(8936002)(5660300002)(1076003)(4744005)(47076005)(336012)(426003)(2906002)(36860700001)(36756003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 11:30:43.5846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 473b6918-063a-4e42-e74c-08da3cafac87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1741
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add linux/module.h in acp-pci.c to solve the below dependency

All error/warnings (new ones prefixed by >>):

>> sound/soc/amd/acp/acp-pci.c:148:1: warning: data definition has no type or storage class
148 | MODULE_DEVICE_TABLE(pci, acp_pci_ids);
| ^~~~~~~~~~~~~~~~~~~
>> sound/soc/amd/acp/acp-pci.c:148:1: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE' [-Werror=implicit-int]
...

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Syed Saba Kareem<ssabakar@amd.com>
---
 sound/soc/amd/acp/acp-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index 340e39d7f420..c893963ee2d0 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -16,6 +16,7 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/module.h>
 
 #include "amd.h"
 #include "../mach-config.h"
-- 
2.25.1

