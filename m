Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951AD4C0D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbiBWHYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbiBWHYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:24:45 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2066.outbound.protection.outlook.com [40.107.102.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360426EB16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:24:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiqgEdD0yo/vJosm5tAMtHiu9l5xEXo16VfGrylwa5P78d8+sMlNDLD+SXJnSuWHfEJ82wW/c+odAOG03wlTOrpup1DiU/b9xK5pgJ5G/0B8hmsmG8liXBxwoC2jgY+jWS4u1lwd5MqyNdFjx8ahDBCfwQ7fxhDjkmOTR434OLz8eILW3askIEKGzcph6NyD0xUqFrN1kmJI7TrVmyMyD4pNmfyVHg/Pro9FCM/MJcE4BNa4c6tgSwlnVHCaizlKm6UdnUC9baWcULuM7y1yIFYAgBTsb9s7omLqsyGLKZyuyZ9Jx3skIf1muzqfYnkPCDwSD7J223lfRxraY9cbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNZdMwv7f9vordSmao+DeoLfrkUT4J7OyzKY+uIv7DY=;
 b=FjUVY07YA2pcVl0KS7Xvmu/CfGuyyMw1mM9nQCibCXazme7jMkCnjlevaaQ3zZOo7KSdqxhgdsdWbkCwBntRuNBuPfBrjcQXVyxMLOHM5CzLDtfY4F+LLKjXpb9giNxlByax7P1iTMEYBXROblUgNsDPAGSGyd8C7Kl3d/tTwRvMP7g+Rwbj2XpyB72Mx5opsxTFzRLVomXkO3yEx5XwkiG1hHI8WOcHs6blDamVlihK5SQpyyC7KVIfhPapEtIc0cx+VffuHihXkhMKXCwqFTcAvOk+DGp9ZhtmAj0JgDwakfDbd1e6FdpLUn4Y9VeCrKWwwK3n9fXJ9MWr/GZAKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNZdMwv7f9vordSmao+DeoLfrkUT4J7OyzKY+uIv7DY=;
 b=vuSuFqoa49jSrINIWHEw5jeAlcxQLox863W728kRR7gRstlPtjVvPsJe+wo/pbaaAWmhvreS+i3ywp8EWq53frzvPfYR+Wv6vSEORIBcV9RzzSvAA1x5OFqnNKcuHSS0DTvNoZGglJIZ992o9T5OOrZveNTUf91mC42Ej0GJ7RI=
Received: from BN6PR14CA0042.namprd14.prod.outlook.com (2603:10b6:404:13f::28)
 by DM6PR12MB3819.namprd12.prod.outlook.com (2603:10b6:5:1c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 07:24:16 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::88) by BN6PR14CA0042.outlook.office365.com
 (2603:10b6:404:13f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Wed, 23 Feb 2022 07:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 07:24:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Feb
 2022 01:24:11 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Feb
 2022 01:23:58 -0600
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 23 Feb 2022 01:23:55 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>, <wtli@nuvoton.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/9] ASoC: nau8821: enable no_capture_mute flag
Date:   Wed, 23 Feb 2022 12:49:32 +0530
Message-ID: <20220223071959.13539-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
References: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff7e0e9f-a554-43f6-ee25-08d9f69d7f9c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3819:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3819EAFD54DF1DCA06604AD3973C9@DM6PR12MB3819.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9egyPvR2XUM+NrKSjjwhlT21my6TYOXVzj374RLMCE35u3GqbIVo3oQlMtZx17cFa16yGiQc0zzrq/0k89K1+p2zxQ1Aivs9cvL9B9hzBINpcEdSENUECto4fhq3PMTo1APAGMrMddp66E4fVTvTptiqb3uSA2c5tiMVUaRswrUeeTru6idASuLMJgw9kuIOvBap89OFr4pJMg6N8yS3PQNCdMFFaSPIs2oaXW4U9Bthiw4KUxlxC6MAY7IScDi5LIG1fDOYoxK5n5o1XzC7oYoRO54cwya5rkIwpdNIRdmUeeNLvEnjgXWaFDjT0mf5o98xMS11oI8l+FXgZeI5ReKm905lL2tLTwkN3RtmIp1zQCm88VG4YxRcN8l5m8eSuY/VWUyXHC8+0MpbJ+tYwmZNVmsex1v8XhTat5SDIAFyMCN9r0GBFsECbOejF/33fVydvt2CqVMrYFOmtgKP9pciyHMFki6j8j95Rq50qeTT40FTUVjG+A2eD/lpBNOHWyZeK/WGZGyjwG7kkKW3O15nvnvJMyfhnxMKHTpcQW0w0seYp2Y1EXEWUyHOKpuHS0Z0YMDSqKA8lZndqMHaQufFrYRUTg0u4fQJ3N6+kUGxwjAyoyO4RtSsalrwdhfpR7q8q8uQBP7KAyRjZYPW/PJ4OTaWK4JDrZF0V/QdrkDFw1YqD8hTo1tVTjdbAp1NFO2bn7YKQv9C2I8XQIYDXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(81166007)(1076003)(186003)(70206006)(70586007)(2616005)(26005)(8676002)(316002)(508600001)(82310400004)(356005)(86362001)(7696005)(83380400001)(426003)(36756003)(40460700003)(110136005)(54906003)(8936002)(47076005)(36860700001)(6666004)(4744005)(336012)(5660300002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 07:24:16.0300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7e0e9f-a554-43f6-ee25-08d9f69d7f9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable no_capture_mute_flag in nau8821 codec driver.
This will fix active playback stream mute issue when capture
stream got closed.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/codecs/nau8821.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index 2de818377484..d67dc27890a9 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -814,6 +814,7 @@ static const struct snd_soc_dai_ops nau8821_dai_ops = {
 	.hw_params = nau8821_hw_params,
 	.set_fmt = nau8821_set_dai_fmt,
 	.mute_stream = nau8821_digital_mute,
+	.no_capture_mute = 1,
 };
 
 #define NAU8821_RATES SNDRV_PCM_RATE_8000_192000
-- 
2.17.1

