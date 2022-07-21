Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C10E57C44B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiGUGSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGUGSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:18:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD294504F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnpUX4LskkGW+Y2ZQxghqTHgymmMgZqrUFRRRs4zIQhsZ0VsYAHjwXiDKCxu/7kf9WDP9fWrgL75VwWLtw4U3+a8xDHD1I9NYWAZYVxKB6g7DsoPjrw+kY1Jja88VuYq2pnQfEsmCe8rQblpiufPi5UpkRU14m04Nl6EQoP6tltGc2sQxgKrT0omke+uamXl4ZxC/c4xA1rb6qrRxK4ipycNHes4MEjmRgMhku5SWaSOtW8agWauNv+RfRzPcywdsm1MpygZ1NoSsladUSiBLWtccqNP1ZkTT+TrKNyPcV19YW2RmRb5FUCEwNsudILxWwOxoJnPXYPdmuaY5xBbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eThbKtCT178v2dr8J5T+2E9j8WFE2t0DDdgclW/YKac=;
 b=g7Pgq1oe1qgzqmu8956W5+qgK6OZZLycsCpbL7i6+wz0T88SJO8H3A7n3KTvJnQTFX4ApbaT05AtaMEi+zUCsQUuM+VPXm8DaqFmE0JOTxvYfqo0xrOOUkmsIQ9X7IobhVvLCgfOoi38JDat0F2XobRtJAOTD1bDP/ygSBegh4hwb13IYqf/jdtePbXRJSaBAY1D3MnUI1iTZmQ5QVkIjl2YPmC8YHmM/w/RHRINiUxlFMa3NE/AgfY9x02cGNACh/fNb/pYY460e6Xc99sp069E8G6Bo7CV6yclx1QgNjJWW9I8WGfL944AXCps59wMpGA6Cj72Fw8zVgsln5Kmyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eThbKtCT178v2dr8J5T+2E9j8WFE2t0DDdgclW/YKac=;
 b=NRNDA4VECAx8KfCl9ZlWAXwOyyUxDGehiVHVz63X8phLN391En7KRlpT9vOzsMApci17J52sKD8Zy895ygm83ooB+ELOvXGBAcafc0m0iCe7bBApB/Te+ZEhJqcofoeS7Bewco95H06wSpcJMtmv6k18J0/Tm0goQQaYqL2BdP4=
Received: from BN7PR02CA0005.namprd02.prod.outlook.com (2603:10b6:408:20::18)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 06:18:01 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::43) by BN7PR02CA0005.outlook.office365.com
 (2603:10b6:408:20::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12 via Frontend
 Transport; Thu, 21 Jul 2022 06:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 06:18:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 01:18:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 01:18:00 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 21 Jul 2022 01:17:50 -0500
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <ssabakar@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] ASoC: amd: acp: Drop superfluous mmap callback
Date:   Thu, 21 Jul 2022 11:50:34 +0530
Message-ID: <20220721062043.3016985-2-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721062043.3016985-1-venkataprasad.potturu@amd.com>
References: <20220721062043.3016985-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fa08c2e-adfc-40b3-f4f9-08da6ae0c3be
X-MS-TrafficTypeDiagnostic: MN0PR12MB5713:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcE9IjBKZiR6nUcI8/gAWLXvrwfYuc1KYA4LzUmzRptfVdw9MFqfRdWKvGoW60Kxw3zCR36VAeGvIWlqM/GUL0o9HGvnzrX5nGQQ5gcLPUh72DvIU6zN4MDPDjbU/yk3sB4bW5INlJORtCE3tEOc0WyxP8VaRU01+1tQCxGwetRsRkVvGTxiaR6a96KN7OqBRG4T+4p7lzaWo+8UQsCOWYfh1hC0oMEFqnm889Hg5Qy843T9XKqhWc8Xb/Lxie0lwjGesMipWTA05YqLqln/d2oNRX49ePCU5TgZFYI0JMuFZIpW5edCCURn+vgxc4sai8nkoOaUMEBQCP36hXXLuIPwtkliVKJvZIC1IZdbQ9gvv9xf4Q5M1wP8AtsSuKaF7UAAK47u7f37ax4hsjGblJ/r+3W87BdWsw5uNunIqoFtH8rpe5AMu77eTwW878Z9j43DwQOpuzn65fXCRhmFIOzsoI2LVdWCbg+gaItChsThxWS4rGuDjVznGa5c6kRmrBn+UOf55JI4jAW0z+d1P2GwMOSTiWmhnca4+uz2C8KTi1AkFC2jnC/tgrrGGsz5J1lzMQQXUfHmL8OX5sdHGirmsWlHgh8wc0dT3eHlLqJ0q4hOiKwQsD1Xp0fcZpafVo7VNCTkDQ42saHRlnmvWfFSOM7D7ORncVe9GAv17mTGXauHSGHQoyFD68RTf3wZ+uRv8ZLGqTRXRfM7J9mstsxzTLIPn26Y/LUHp8VRwpFI20gqv3x9Eq10WJ7VQpYzn/IENsn3PVC4h53Byt0fOwQO4v8vjEFdoScaEHjfxsV9T21TeTRyIE18ipLm6ZB4+6eac+VEZj2mUFora93FFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(40470700004)(46966006)(70206006)(70586007)(8936002)(5660300002)(4326008)(8676002)(82310400005)(40480700001)(36860700001)(54906003)(40460700003)(83380400001)(2906002)(478600001)(82740400003)(86362001)(36756003)(356005)(426003)(336012)(316002)(81166007)(26005)(1076003)(2616005)(186003)(47076005)(110136005)(7696005)(41300700001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 06:18:01.4855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa08c2e-adfc-40b3-f4f9-08da6ae0c3be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove mmap callback as ASoC AMD drivers just call
the standard mmap handler.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-platform.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index b1ca52274375..10730d33c3b0 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -258,13 +258,6 @@ static int acp_dma_new(struct snd_soc_component *component,
 	return 0;
 }
 
-static int acp_dma_mmap(struct snd_soc_component *component,
-			struct snd_pcm_substream *substream,
-			struct vm_area_struct *vma)
-{
-	return snd_pcm_lib_default_mmap(substream, vma);
-}
-
 static int acp_dma_close(struct snd_soc_component *component,
 			 struct snd_pcm_substream *substream)
 {
@@ -288,7 +281,6 @@ static const struct snd_soc_component_driver acp_pcm_component = {
 	.close			= acp_dma_close,
 	.hw_params		= acp_dma_hw_params,
 	.pointer		= acp_dma_pointer,
-	.mmap			= acp_dma_mmap,
 	.pcm_construct		= acp_dma_new,
 	.legacy_dai_naming	= 1,
 };
-- 
2.25.1

