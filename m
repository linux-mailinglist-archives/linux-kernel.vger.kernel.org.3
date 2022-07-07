Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5272856A39E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiGGN0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbiGGN0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:26:30 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2043.outbound.protection.outlook.com [40.107.212.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EAC2B256
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:26:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V24/EtVEf7tm31+FcrX2yTejksO/H+CG4BlYtlmJ1BvrdIA2ZV+ObgKZWr+mCJ2MfYmVutxvmctIO5AhUz4CBAY18MOAWFwb88VeBjfH12Z0ajOto5moKLvNUgpnedwlz1OqgngcuGsYpQvTHxv1+BzSnhB5af7AazfttPn6e4kOYV9pVcAqVZ9OQGdqdMWPk/xOuXxneq78Orms0JGrnP6Hn6MwvgU6UuZmRE6oaXIhzKhRZSiybrzZznHEftw/i0h2fr/HVYOTg4sUXclM4iHW//aKx2ffKvtYT6JGoip44FwGBqzvb1maoxbHk03MrYmfGmrJirvTmA89nCc4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfMly5rDRIY47P6XSIpWR64TGn5M3TgXr/DrSkfpN1I=;
 b=kDii3V5hJyPOQScdNcfaQoDKqIpGKGgnRtwWYffzn+DWDOrm6qpwbPcSq6A99avCQP59a83aaXQIih0FZGDOMsbXuEOdfy+/gUvzAtVSEORGsbFiK02gG/GN8fvWvdFQq99+tuuu4G9ojdXrIiSU9q5+9S/aCyCpLubldsjpwjbfXLtEyZyyRKemkGuCICFAw9NTcxQyns8mv/MyqXowtFebLGCLUUr8rXCJRlOSGKhcj2zz0SLgCdmhVFdDn5PrBiJhhMzpERhUzz3dpsISbucA3KJO56Dp8fGRAjXCi5kqWH6cxJtV9INfAOJvsJo5OqctF5302N2G7PTg5JJRKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfMly5rDRIY47P6XSIpWR64TGn5M3TgXr/DrSkfpN1I=;
 b=yrHkpd8syZuFSSC3IQXWaCXlry5uZPFaYNAvrRUoprvtyBj+vU0vi/td9TP3BRi1HNfYF3dYQVmtrkqnKi2jTjnBkrQP7d1CyXdNbj6BJwtvfl2/r9jDuhXRioO6wJXeXlgmT7U6ahLFP4PS44d5drTnm5oYAu0/QiS4N1jrBRg=
Received: from MWHPR14CA0012.namprd14.prod.outlook.com (2603:10b6:300:ae::22)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 13:26:27 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::74) by MWHPR14CA0012.outlook.office365.com
 (2603:10b6:300:ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Thu, 7 Jul 2022 13:26:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 13:26:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 08:26:26 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 7 Jul 2022 08:26:22 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <amadeuszx.slawinski@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <zhuning@everest-semi.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] ASoC: amd: remove unused header file inclusion
Date:   Thu, 7 Jul 2022 18:56:08 +0530
Message-ID: <20220707132613.3150931-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45566763-9762-4d9c-1cea-08da601c4b6f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4200:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8nqQr6/lPb6QPC98LFvNKhX8bsSl3EUgByW5kxotNNv32kon8cO8luVEla2CLb/LGUtoRGNPtmwXg3YVtoXGGa9+zW4FS7PaiUpx58SiqX87L7afLndLfx9CYoX3SuFqPmFXS4KvXDAbsfGh4WElXichpEjaiFtezYTcOEkGqCNxn09CaghmhlPi2YYM46gsPt7Iq8Cc9Wj8FR4Rrz/Y77gcH/uWINV65eVhsQ3o3TgwaAMRnsICVHAJa3f+FsKWeQDfvi3O3JgFZSJJkw5lHHIEL2SXDICZIfL7T05pmjnnPeIa4+0yNqEVYDsYt9xyRj/VFyAJVHBhZajYqUQy775wIavxh7eXF6wE7BPfq0aGSxdvpa1fHBFFDf63piovOvqhGJGY1AaEMDDbnORp3r12k/d+/FZnFGTQtq0clvn8simMw9hJGE7G6TSBsXghj4BIe9AMkm7rvkUe0XZRDfTy2LtUP7hFzxZAc7wntuJdbzDiMXts90xFL+IqFiqGKVH7wFUw6gqivFJGH47ZUTs3Y75L5qlQW2utVldQWQ/cK/SwqDClH8tLO9gE9/t12R26BzOyqamVn4bDBy1RPLn7Ll1JNCf3IxreOBCMX5xnm6TX+R9Nm+/vK7UVKaYXW5QILjOVjw7jM49bgurAMW7X903EqJO6/Nd9ZlX3gBQxMfzk124n76HAyjCYLt7vJ7sOhazog7Xy+VJuteuQDgXpecLOX2TQMt7XQt/kYAW67JNbsZkBdz4eGBki4JH3zE3QeQY3S5fGOeZAvclVDk9pDVzGOcTxMXIVvUJizMULEAJDNEoVyacN0Se8mJPx98MIJ5TuPaJIgEhcEOPlCcEth92IWf9jc3WSlD0NoHccj6aRfFiDhvLwoVWT7Rd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(40470700004)(36840700001)(46966006)(82310400005)(426003)(5660300002)(81166007)(8936002)(54906003)(70206006)(8676002)(86362001)(36860700001)(6666004)(4326008)(4744005)(110136005)(70586007)(356005)(41300700001)(316002)(40480700001)(2906002)(40460700003)(34020700004)(47076005)(7696005)(36756003)(26005)(2616005)(336012)(1076003)(82740400003)(186003)(83380400001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 13:26:26.5395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45566763-9762-4d9c-1cea-08da601c4b6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unused header file inclusion from Jadeite platform machine
driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-es8336.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/amd/acp-es8336.c b/sound/soc/amd/acp-es8336.c
index eec3d57092fa..8ce26c9b3ead 100644
--- a/sound/soc/amd/acp-es8336.c
+++ b/sound/soc/amd/acp-es8336.c
@@ -23,7 +23,6 @@
 #include <linux/module.h>
 #include <linux/acpi.h>
 
-#include "../codecs/es8316.h"
 #include "acp.h"
 
 #define DUAL_CHANNEL	2
-- 
2.25.1

