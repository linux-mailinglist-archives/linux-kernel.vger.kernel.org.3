Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90254C0D41
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbiBWH0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238690AbiBWHZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:25:48 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2089.outbound.protection.outlook.com [40.107.100.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBC96FA13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:25:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVf8p5Z5p/EA7QAT135jabXs9DjP6liX/A0xgnFudTEoXF4avuX0e4RHwi3Pg71dDd7FIMfx829GvC77mTFkag4wBD2iIQa0hUfKLnWM0RP7onv2vdCoPpl+/yB4FDH4J2aZAawjJUVG3btTHA04GtpmPuMVbMbG4pxRCjCnbEAg+U9w+meRIsOwvRfXvGS2Lgp/y96Wa/C4kIsUpUYiz0gdNJkkJApvxGrD5guTTyvZSqRNItvbqxx9zcv/nd+sbwxcEjFn+W3xPRzVAd9zrmV5KIA8hOzJ0oUSjc3rrQBpY3QI3SFQ+qv7Tdl+XigCsS8zS5YGv1HbMM2Bt3HT9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HC4ndKkpKXKWwiRAMnVGzBo7zxZ8TlguMupPQfnxF50=;
 b=ecWyta1tTxxf8O4q7V9vP9j6hNqnPaR7InqtSUFK8NGYnxjcLZ0LEAWa8/tcBEe37rzhjpPJ29UAhJnTJntgQCfvHQpeUrbGTbtTIg6Z1+2EYZEu230+b15pOm61qY5OSjM0+Y02J+i7doipDDd3eoqF9/pvg0FJwV7Ry5RCYP5YhdmpIBBT+LBxrYPDD6KjvotxqK5MH3wZB7EvxXkA35mSTHfJdElGdLi027z54C3Bz8cixp4PRU+k0JFY+WNgRqoN+7vWc9i1G4hmpOeebA3sLu94cSSD1aNK0/Bn4bxGwiqyIwcVvZWeN+psCCVJqKpGQORmyj8Ny1qCYp4Ydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HC4ndKkpKXKWwiRAMnVGzBo7zxZ8TlguMupPQfnxF50=;
 b=0JWB/TJ51pQLWKvFODxmxLAv5hB5zwdGVNih6Y99Beswq3tGCOpV6JUk1BqPLelnHwkrjBjVp3Ol83x8aMaFiy1u0Mc0fgd9LI+qatk3ywcRGhJoiFBia7eEO2vLtLWNgR9Ok3LFKvlrgAN6Dv/uCOEX72T5hNv+4hHX9D04Ovg=
Received: from MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::7) by
 MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 23 Feb
 2022 07:25:18 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::47) by MW4P221CA0002.outlook.office365.com
 (2603:10b6:303:8b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Wed, 23 Feb 2022 07:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 07:25:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Feb
 2022 01:25:15 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Feb
 2022 01:25:14 -0600
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 23 Feb 2022 01:25:12 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>, <wtli@nuvoton.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 9/9] ASoC: amd: vangogh: fix uninitialized symbol warning in machine driver
Date:   Wed, 23 Feb 2022 12:49:38 +0530
Message-ID: <20220223071959.13539-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
References: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30aa2c90-155b-474e-cf06-08d9f69da478
X-MS-TrafficTypeDiagnostic: MN2PR12MB4390:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB43908BBD6475A3551632AE80973C9@MN2PR12MB4390.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8wuWCBlam75QDvmi7hOQLnBHljZbInSLBcoW/ASINK3/pq0y2AFQAmqJ206Md1IG1j2TKzH6fh7BOoVfl6pjNRwCNoQVKFveM32qEW3H84Dwfz0DNRPmU1Iq7AoD3HhZkFa0viW9MjUgs8hT2fhu8SU9QE8h6fQThSaGXhKz1XutvU5/jgl0czSd0CtgW2R5W9poEJVvPMV1ZSMVdgv9g5g4SSvT/x2KwGkLEqg3jo0CJZoozaDexw/rNZSTqYL5tPpHH7SpRD3RibLi+UVWG1XBDU2yPtN3fM8Ojv3fJSSPWrs9u3e2srDYK/MsvgPyvEaTT83bcakVHq3kV7mTTlU466KeZDRw3/NE417z5VMamMajD6SFvtPva5G4SK3xcGwQItysLHp93NAU4YmHawd5rAzlSd0rspew0RRnMo60rqt5+21oXIvqycE2MVfyMFGe6818oHq3VUXwU0q7uZntizrrzQw8Xx3d4H3ezIsOkRNdtcPpvZsqy1qMo8rbZcTz5GV3rvVVCNmGembvw4dKyqMdPd6om+63P6QtenU1ZHiF3rYyQNMkUGw+lMQv3EaMZOgmz48u1UOti5U6oi/dNMI8c8Mpl6P/ThDOGPbYKJNB1CsW09tcA+Pzg97hxnsCPyp8ru/F0PBEYXjDnvIBry/49Lo16xUklkcwkWRzpy9TI4piwMzOSoO1yxJy+Q59sZkL/LH9V+a2HouMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(426003)(26005)(2616005)(186003)(336012)(1076003)(70206006)(70586007)(83380400001)(86362001)(6666004)(508600001)(110136005)(316002)(82310400004)(7696005)(54906003)(2906002)(36756003)(81166007)(5660300002)(356005)(4744005)(8936002)(40460700003)(36860700001)(4326008)(47076005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 07:25:17.7440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30aa2c90-155b-474e-cf06-08d9f69da478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed below smatch static checker warning.
sound/soc/amd/vangogh/acp5x-mach.c:190 acp5x_cs35l41_hw_params()
error: uninitialized symbol 'ret'.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index c574e80907f0..5ae3de76283e 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -177,6 +177,7 @@ static int acp5x_cs35l41_hw_params(struct snd_pcm_substream *substream,
 	unsigned int num_codecs = rtd->num_codecs;
 	unsigned int bclk_val;
 
+	ret = 0;
 	for (i = 0; i < num_codecs; i++) {
 		codec_dai = asoc_rtd_to_codec(rtd, i);
 		if ((strcmp(codec_dai->name, "spi-VLV1776:00") == 0) ||
-- 
2.17.1

