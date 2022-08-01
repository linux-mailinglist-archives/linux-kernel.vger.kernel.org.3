Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26EA586418
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiHAGdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHAGdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:33:42 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2086.outbound.protection.outlook.com [40.107.96.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB841260D
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 23:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvDkfvdzzZaLlqY4WyvEjtu0QeV07pp47ghhMNamdZuViA/3EVVWNRmPI1Usa1UeEUBBXpnvKgDkBx4+0ISRKnqyNRRPx3vkGcENThiuzNqU4z+dcwAI18845LAZ4aOhNer/IvlLQUjiN4xBJ6yCO4iX6D4dVGLVozuxMQLaZQMfWmJE/NgfTA8a42TfGg9pl4NFzmllXv97FrtI6Ize1I1anSGjO+JyON3m03SdEJrYsTlCcOw1FdtUrBGmG+TPtGL3TwS1dCZRkRSdYlBSbT2KRGiYpgCc5dz3BLRIMe1vVR2OIEBUy10akZUV1h1fGiDWyxtyEm7qO+J+ICfj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOnqBKpZ3jqGq6a7EOROe3ZK21YwoLbzbO+O27efrbQ=;
 b=L1voWu9aNB/LA4613DHjNkG+k/VTa4oBx8nHDGkpQIcYcUsX/z56WKCJEqfdt3hyoECkOU7ddqUXNaYpyDpeAtj+I08c41839DZzE1fJ+7wzSkURbwh1yqx53FarE4+EFw7GGOFhbetZWFgLys9oMnZsPMEjLBGztuinig6IIIqyfryUKrJw1xbx0+He710PC1QFG/7SggHbSbFljNpOClsSUdBH/fR5fPYIl+5h8DmEf/OXcNKzwz4a16KEQUpaigrzJGJYtXEcZlnyRczIOP3STOcjMwa19XgEKWHi1nj49roBX0iRrLCGom+r/3cAGmf81XYv2pAEwb4meLGtYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOnqBKpZ3jqGq6a7EOROe3ZK21YwoLbzbO+O27efrbQ=;
 b=1AxNPoHQQG/qGEl8iCenJkWO2rcAu00C9nHS2er+xkGEyzHgarPVK0ZxHLUIvITuGuuGiOXd6yU3Tit1KjfIHR3jv3PVdvcZk1w92ANuTWwIbXMJRn36emRawFxz/DcKzLjo2gPp2K3sY6lFSIauIxTjzwG/Ye1UXOsfgJrPfeo=
Received: from BN9PR03CA0774.namprd03.prod.outlook.com (2603:10b6:408:13a::29)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 06:33:38 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::f4) by BN9PR03CA0774.outlook.office365.com
 (2603:10b6:408:13a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24 via Frontend
 Transport; Mon, 1 Aug 2022 06:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Mon, 1 Aug 2022 06:33:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 1 Aug
 2022 01:31:52 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Mon, 1 Aug 2022 01:31:42 -0500
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
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ASoC: amd: acp: Modify dai_id macros to be more generic
Date:   Mon, 1 Aug 2022 12:04:56 +0530
Message-ID: <20220801063501.51439-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e4b38eb-3b07-4584-03a4-08da7387c488
X-MS-TrafficTypeDiagnostic: PH7PR12MB6809:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KzHEDRsk6c92paFVux2qo35wvo1HHYdAyMg0Z7e+iAC7Mt4zZUXyAzo0o8B6MbK4TRwPTzOPJWGFhA8SAWkeD88/A1x0B0MahqCDRukXVGBFrL/2wbnagtBM9IDNglQ1UtkGAZ5bpCTocwKDVRk5kSo6pwSPPNb/Hkvy/CytPweT0WIpJhm6YDqkc06/aiQ0NykMZ+oRI4stY+nz6ly9z6BM+PM8ZCmWRHgUroVZYfCXR1ElYjQO8/BztR8dkGb7d42EF5BEIbHpHm+FG6HgnSOPv55d5PSIb1Z38QIm+N4LQ4iiSWxICwrUuh9cjdMCPRl0yAg6oiWFW0sopcSLTe7x0JWH2NbuuxD5TCluV2hp4zfo2Qp3av0WzeBWubj3iDGm8raQaGy6YjH9T2U2nWmLjEV/uUtNDOTJbq7DnOGr/5Sg4MMWaFJoW6ifi/co4VRtbs0joIgZLkONyydvYA8qYjozYqrp9qw295Zq1lmYHYddI6wtA0q3pbyHfDVP7MRlj97hOgiJWf1U3asw4BkMzWH3FukPd81o5OaK+e2dz9z4rXH5c/yYW+cDwpdX5tuIe7iz4qV5xZFBe6lFVtOi/epshuNclY4dnLxVYsekajMmh9BvtQtKm9FqWM71pGbsWa8y7ab9Yc3Xp5VVWvdsAJ/At254h1D5StBt122LbaPsmEdmeTHA0BRAw/HG143bxBlAKK1YNTqYcusMw3u/l8+JVZrIVh9K5szKKRXjdX55KPqtGF8EmBnzLW2ksRwAVWVCzBvgy/zzXGknXLKsVtsYhCB5oJNOG8k7/NJOphKBA6+/yu3gSJtrbPasQ8rrWIMrxeAsvHv8ZjBhRX6SnuW2k6YdzMOV/gVLVnw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(36840700001)(46966006)(40470700004)(86362001)(2906002)(5660300002)(40480700001)(41300700001)(1076003)(186003)(426003)(40460700003)(336012)(47076005)(6666004)(26005)(82310400005)(7696005)(36756003)(110136005)(54906003)(478600001)(82740400003)(356005)(36860700001)(4744005)(316002)(4326008)(8676002)(8936002)(2616005)(81166007)(70586007)(70206006)(83380400001)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 06:33:38.0592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4b38eb-3b07-4584-03a4-08da7387c488
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change dai_id macros to make I2S instances in order.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---

Changes since v1:
    -- Change commit description.

 sound/soc/amd/acp/amd.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index af9603724a68..60a7c95f134f 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -21,9 +21,9 @@
 #define ACP3X_DEV			3
 #define ACP6X_DEV			6
 
-#define I2S_SP_INSTANCE			0x00
-#define I2S_BT_INSTANCE			0x01
-#define DMIC_INSTANCE			0x02
+#define DMIC_INSTANCE			0x00
+#define I2S_SP_INSTANCE			0x01
+#define I2S_BT_INSTANCE			0x02
 #define I2S_HS_INSTANCE			0x03
 
 #define MEM_WINDOW_START		0x4080000
-- 
2.25.1

