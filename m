Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79816578CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbiGRVeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbiGRVeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:34:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D97FF58E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HujOkwxQQsVVE+/AX3WLEFoFMPmP65oRdauqn2ox+31uV1nDZhX4fx8To4iBMiC+8zZj2GR8lbOvbTYSTB6Np5yQ/CamzuHzpEHG9gilGg1qcGzH0llcoaOEuYckdkvnbGjeteZzyjxyiLPzTTMMFvfkPXZbyyJ9yRRniZAm+fsZRjY3LUT9xj0x1iNtMEMYv0qAtOavH3W+zeopJJDxsQX2eytwq7c4XBvKM/2ZFOd9lWzoikB3Qh0I7BfFrUUfIf2x/2FJCNI8oyB4UqGnU5SEfZPa3tD8r5pdzHmqEPiHZng+eNHRkXlSx3WSJwZyqT+M9Z6vMASecNF4LnO5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lall0w3xu5vPH7W7jZkMKWOfPhPjku0BbcWBcBWFoFU=;
 b=GhUVvHTknabfy4qR6JhtgMWRdozh9W4kP4ISmThBs6NZPqnt7ku73CR9rvt7ri/81fNp0hjfdHCLYS7rWzfw8vpiMsEVDE1BYDdJNPah/7ur3rIaFNFsrVy7YNamf3ds1XjX1e5OcQZT9W9Fn8tp93lgy10ywelDgWjjwdA/vNX/E3+GjubSieLcHDtRoB0YiY3wxm536pe6NtjH8Vrj14xDvQUNycWJGh+k76daXtuSsCkbfBC2eRj3TjaG99D+x3S4jC+Ds9Vbox6nTEZ24qJQoIDjbJZxo4/rW6sUNuirj3Al5znOVvKFlh0ODKeF+ys2500mDivDmHWAcnbgBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lall0w3xu5vPH7W7jZkMKWOfPhPjku0BbcWBcBWFoFU=;
 b=KS+GRQ0ZkXSnz2AXXIlia/yWhddl4wFVhsbjBbF+9lyGUaCqnhOLHMboR9ARZ8FZP3r2rM9x/Xay9j5oy1CXnHAl4q8K23cnl9iBR9X5BmDGxlekQLcTA4L16HptaKl+G/HWpNJvm1N2rkof62VGPdEZN4xAFVg6An/FDZGOYlY=
Received: from DS7PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:3b5::20)
 by BN6PR12MB1396.namprd12.prod.outlook.com (2603:10b6:404:1b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 21:34:07 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::97) by DS7PR03CA0045.outlook.office365.com
 (2603:10b6:5:3b5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Mon, 18 Jul 2022 21:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Mon, 18 Jul 2022 21:34:07 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 18 Jul
 2022 16:34:06 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: yc: Decrease level of error message
Date:   Mon, 18 Jul 2022 16:34:02 -0500
Message-ID: <20220718213402.19497-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71a85bef-f784-4df7-1289-08da69053ebb
X-MS-TrafficTypeDiagnostic: BN6PR12MB1396:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwVL82gvTL0IJc3hPKgtD4r9el1D1f9UCtBTfHoxRBLsx+rkH66FzOVlBKyf+eJ89nJ3N5wQ7LGZN6jFI2lymLLTJIiA2q28QywZvErQpGjWCJcLT4EERURUH9MRggIrtl+Eg1D93h0caPzQsxiRYw5bhjrSh1wPM165op5zNac5Ca3f7Dr/hEIXll4mW8dg7ZMA5JuE7zyFxXjXV8wfYZ4RpNVrj0alNBngpdZfOd1Q4pfAgW0xOOu81tkWz+2Mu1cCvbY/8dEHo3fPnbgTeRq+Aa3H6YB1umupoPIjE0ReQeDT3FO/EnvSNE3K47uG8y+fxihL4yy7dvUZf6jOFCChVnflnzNQXRuNImXriaX48MRFI7W51JwInSPV0X29Z2gjyA0NetjzycBOU+XIMyXEkiGw3y0ghqc/pIlIbe+rWxLQXaUqlK95SPhKmy+X6VRzMrbFG56QaZhsBf3Jua0IKls7TKlfFXdB8Xg9eUU9fyjwJoBe6nx1peuZ8wqJA8v7JPdWKZ+IS69gWmwECtd4MIZLgSikuu7RzisdmC3b8eAJr8zK8MmLYA2p7rocPDOTvBo1dt1NiPGklc/GUm/YMC4PzXw8xEnD28zB/7KW7SqUDe1rcJxgtCbdB61YttUzlGCsVSJrTBpqX29q8GkZuFBx/IQi2uoS1anfi+Otws6KyPh+ZkXaCVrSWkZsgG/jIzqQNmRN+zyrsZ8I+IiCmRrmyqQzUbreIJhNcLeSStCzN12cgXRhUfwUWVn/e0DDJBbF0IcitQaL8BfNuw9BTtr77OCyJzO5Tlrlm3NWO9ndo4TMpmFcJUq8WmJ5kJAN8n58Nwpxutc26vQbhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(36840700001)(40470700004)(46966006)(83380400001)(186003)(26005)(44832011)(2906002)(15650500001)(41300700001)(6666004)(86362001)(7696005)(478600001)(8936002)(426003)(40460700003)(5660300002)(2616005)(16526019)(110136005)(54906003)(316002)(82310400005)(70586007)(82740400003)(81166007)(336012)(47076005)(40480700001)(36756003)(1076003)(36860700001)(8676002)(4326008)(356005)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 21:34:07.3609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a85bef-f784-4df7-1289-08da69053ebb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1396
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a number of platforms that contain acp3x controller a new ERR level
message is showing up:

`acp6x pci device not found`

This is because ACP3x and ACP6x share same PCI ID but can be identified
by PCI revision.  As this is expected behavior for a system with ACP3x
decrease message to debug.

Fixes: b1630fcbfde6c ("ASoC: amd: yc: add new YC platform varaint support")
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/yc/pci-acp6x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
index 20f7a99783f20..77c5fa1f7af14 100644
--- a/sound/soc/amd/yc/pci-acp6x.c
+++ b/sound/soc/amd/yc/pci-acp6x.c
@@ -159,7 +159,7 @@ static int snd_acp6x_probe(struct pci_dev *pci,
 	case 0x6f:
 		break;
 	default:
-		dev_err(&pci->dev, "acp6x pci device not found\n");
+		dev_dbg(&pci->dev, "acp6x pci device not found\n");
 		return -ENODEV;
 	}
 	if (pci_enable_device(pci)) {
-- 
2.25.1

