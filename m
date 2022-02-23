Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890494C0D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiBWHZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbiBWHZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:25:36 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09797033B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:25:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDEioTE2DGr89w1V8STtqEO+TzXVIPq+DZEwe4CO6JvzCt/fizuDNS4sgGisOTsyQdTBXihAYwCvZpizoLVHD+QtwMSZpna0ykfvy0Ro9saQoWHnvkUhbVtzJ5a3n6rPpJJl+UNbwEltFKexIy0bfR6b3lkWGLGLLyvAE+u+o+HAJjOCOR9SMO+FXGmaC8QLyd09SLyrKYAMDrCf5WSpyUBk8Hfs4AEslnMx7JblmuhUAyTGCo7dwZY2N4w7jAGAJWpxmjFZPrDUP319SE+01c1J2v0CgA3KyE9GzkcCjQl9kdcMyGc0RIKGr0YKZehGJs15e9f2xQ5xMjkk9qzPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTO65rPdmswhIwJtUcDHe4bDzdsQNBWL3CBniXbDuMQ=;
 b=lDWuu82tEhRMlU9anjXULYfeX+53LVmgwlGWYN7HVrQcLeuBdzP+7YNkq2+g+74IHVSqvsLakSbZ78RuzqB+xcyxpGWVfyLy0VNOUExjfjiGwmxkgM0Ws+FdVVpmo6rs6M2qhVWKej8m9f1Rrr+ewm+2xCyqessN7kzcblsech5Y/oDcwZYKxEWbQ0hPHXg0zGJPh03gP5x/dQ6da6pLGjl2QQV1T6iQOFM0OFJQhlhOnJ8xnYbbQEAKldM8NDOQbdN/Wz65+URM/HGJsJryYRtx/uzKv9b2FUtcDvmuKZMNhu0cdnafzdFqgVnBr6c1JTwSkby7DrH2+8/n8AGN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTO65rPdmswhIwJtUcDHe4bDzdsQNBWL3CBniXbDuMQ=;
 b=f1R59bwDYmwDdNd/q9+T7JUxK3yrJKQOe7wg5QFh9r1bPZKN7tiS830Vm6JhTu7H+tFBn+ULw/lewnsWzF3hk8BklWbgXZ0I1+o5HTY8YFH7jPP9oMlHQEwNdxBnsO+aSJEBzVVQ6nk5f2bauyQsimoXSqdx7IOwnvKDimcEcBY=
Received: from MWHPR13CA0018.namprd13.prod.outlook.com (2603:10b6:300:16::28)
 by CY4PR12MB1256.namprd12.prod.outlook.com (2603:10b6:903:3d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 23 Feb
 2022 07:25:03 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::6c) by MWHPR13CA0018.outlook.office365.com
 (2603:10b6:300:16::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.9 via Frontend
 Transport; Wed, 23 Feb 2022 07:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 07:25:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Feb
 2022 01:24:55 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Feb
 2022 01:24:54 -0600
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 23 Feb 2022 01:24:51 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>, <wtli@nuvoton.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/9] ASoC: amd: vg: update DAI link name
Date:   Wed, 23 Feb 2022 12:49:36 +0530
Message-ID: <20220223071959.13539-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
References: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72ca46f7-0a9e-4c65-9997-08d9f69d9b98
X-MS-TrafficTypeDiagnostic: CY4PR12MB1256:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1256D0F6B65935D00F8B5FA3973C9@CY4PR12MB1256.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /25mKJruHUh1lCeQRHsIqwmfgwngPndaJN2T+lBt1gDzZxbuBbpMAchVNWQB5wTuqmgPu9kP3tC+TtMppe3CntBS4AR2g8kXbbYPZqvCWFMvpx1zzSqHj5O0EncHuCakfEn73wke7sOfIr10PUiOo3D/jgf587Q41myGpSOzAShmjHgj9vXHXukVPaGN46WlZxs67H85wBMoipZky08t8BUh0MZBmWuMmgVXnM2hviydrF4MEP3bqaBWLqMreLCesV/CRHwMncWEWtkBmuiS2/JZAouTNKspce26Afnp1JUmgkV4J0BDwWKN4KWOJ+s0qT+FH+tAVaXx+yegS6U04FDcSs0t/DuBDgRQh8d6oRRUOjqjaJC5lhCNAeXCl47eu7+Lee/vpQklhXqu9J5AezBmqFMPJ7HBwR96NCGczaWa2zsv0WOodXmeK5zNP90xcZgoChd+wBXc1fGhpwpFysW6/x/+f4IiJj3sRubd34kVXCX0DXACgDCgZ7x28N6P+ZaipeS1j1s3wrJ1ryeIvwlR4Iqyj6E9flFwBtSTNqir6bYiH3x4cPUnsoDoZ3iDAT7OXgZH0gyEq1Lt2FV3idPfpw0Qr9TPe+/R+3aqiYRO67JlIlPEr/KKkGYkCMQhorofwOma/uyVHtbawJO1OWXHAZJXYp1GrTHv5T7gd/u08jJrspUeZwTgr/vYPI9mxQdsvC2G+6VPNQj8sAOqRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(15650500001)(4744005)(70586007)(336012)(508600001)(36860700001)(316002)(82310400004)(70206006)(4326008)(426003)(8676002)(5660300002)(2616005)(7696005)(186003)(1076003)(40460700003)(83380400001)(26005)(81166007)(86362001)(8936002)(36756003)(356005)(54906003)(2906002)(47076005)(6666004)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 07:25:02.8528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ca46f7-0a9e-4c65-9997-08d9f69d9b98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update DAI link name as "acp5x-8821-play".

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index 18b2fdc8dc9e..287efd9282db 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -242,7 +242,7 @@ SND_SOC_DAILINK_DEF(platform,
 
 static struct snd_soc_dai_link acp5x_dai[] = {
 	{
-		.name = "acp5x-8825-play",
+		.name = "acp5x-8821-play",
 		.stream_name = "Playback/Capture",
 		.dai_fmt = SND_SOC_DAIFMT_I2S  | SND_SOC_DAIFMT_NB_NF |
 			   SND_SOC_DAIFMT_CBC_CFC,
-- 
2.17.1

