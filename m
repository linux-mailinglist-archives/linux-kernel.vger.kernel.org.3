Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBBF4B2F18
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353678AbiBKVGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:06:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiBKVGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:06:12 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A232D2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:06:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nkx/a1/f3U5L98njJF1FEd6BF7G8kDrOwe+CQOE18/O3f6WY2yq7P9t/l7vWnSx9AzCumIB/6LBeFkevpPZbPoG5VuIfInQfYvuPX+UhzdBebu290ltw3LiqGILHTyMCZOBrKg9NuBcJouQ3XDyKp4QlpfxYV8V4HC1CpC9v9RULe9rSmXuM29UU+7ufU8aIV78Vl2ehTCSTzl+aKqLcjSkm3d8YcOw1FxOo8brz/2pTqXBflMt7PB+HEHx2bSqjNaB0oGxlW7KwYWiIQ6wvOj7QUlhyY083AUp6ZfEpYYkWRBFdSA/l50FGoLL7Cy9rKQTklrM0ctbtC3A2X/1k8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovyTE8YL6rUObqjY9WVHSAc4XDBj1+SL7sr/2ie6hGU=;
 b=jpkPsZGYZWDu9GhsjUGgECyP/6V5CNlakf0czY9uhj3df0NJHUv+aKsqplOL8hvoXNxPMaquGrUH6ucMa3P0wNDdbcuRJzdyYw7qElStMfmaEiVcjeeuTOfX5whn003Ri34ommIsnwdWW3cKNdastphLZawIEpXPQ9HO0CQPaqTw23ug9SRxthaq/EbIH6Ev5eFdueKq97bHXJoKOg7q3v2lHZasqpYn5aT0rKpObDSZeObKKB5Z7s6nLl0ClFYcmIziQg/WrkGFqZE3TR/bgIfRg4vHtbamzQcRgZoiy3lSVVFC2vQyAbeCvvG1OP/DdciRa7nIRCzM1a6yEviRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovyTE8YL6rUObqjY9WVHSAc4XDBj1+SL7sr/2ie6hGU=;
 b=yrzSTABe0zB4+l0SSC0LDqn2a4dEF6YwTfRagDy5IXL1sTsC/0y+ydF/I4HdjUCgsFkeECjktNYMtTWENFyvUNEUbtoq8Md1C2Q9bx6AvRDQnJf6h+4k8vWxc0u+5ePRz5j9sjbIY7TQFOn2Dd5cqR7aXudS6W9nNMsXjn8meII=
Received: from BN9PR03CA0964.namprd03.prod.outlook.com (2603:10b6:408:109::9)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 21:06:08 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::11) by BN9PR03CA0964.outlook.office365.com
 (2603:10b6:408:109::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 21:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 21:06:08 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 15:06:06 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        <hughsient@gmail.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        <linux-kernel@vger.kernel.org>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 1/4] crypto: ccp: Use cc_platform_has to determine SEV presence
Date:   Fri, 11 Feb 2022 15:02:52 -0600
Message-ID: <20220211210255.9820-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211210255.9820-1-mario.limonciello@amd.com>
References: <20220211210255.9820-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 634e93b0-aeaa-4ed9-8bc9-08d9eda25308
X-MS-TrafficTypeDiagnostic: MN2PR12MB4127:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4127E9A4C9CCC87407293407E2309@MN2PR12MB4127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Z5hVkj6OSFpgZm6aI5K5Gowf9Fzb4inh9w5SM/8XxJ8vWZCWxd3yzWmk1oxTFnsX7D4RMXWiEeOER1YQnrEeRX/DpYchzc7ldd6I1mkmv/lGzsWKY+czSDr5St9+iSbdR1IpkbnzqB1xjcUdXpvWUhNgPVsUBwqjLUZxy/htdBLGVbXzJ+cyDtEgv1Ydh9w6P/3/LcacsEb9ElTRxqmdTIB5Fd8toIHgiz0iMpkuWwlTO3EHk+E6CYDlFOPcGH6KaBYOIqyZDjMpYP4bjRGatu1eXgNCcbVIiZqqTRTrKqWxqBX8gTLeju5VPNTQQtdZhpkPPkE+KWmpOvvFJRq2yM+C5ssfQ0QBJxo9vrNw0Ahx3bhqUSsmDss1+6J3QZVmPHcWmbrld+BpeGV3bmkYTYoTHpBde/UcMaZM95wd3Q4dss0PF2N8gvKqQZ0uzISFzp1xN+kmZbRVSWnwrKkdi64tibib8HW9YiTloT8y0pcT1f0FqziR72eNHQ+nLd4IK8RJ+WwJY4EKZ8GSlB9mVaGQGVcsnFHxbd+QbR79Tzpl2864PTaxD0yXQ4Tnsbi5TkWFZNg+bXP+EAlDquVBEQOq1TqpvFS9h43ch9qiXigTSQmjkvIIpcb+7qbDWe79O2bGaLLaXUpozufNl/077ppoGkF9XYiCDCs9Ta3Dk6m76ZHzta16rYGgNG8nHkmDfWdGqugcTQR7PD8j+ob1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(54906003)(356005)(86362001)(36860700001)(426003)(5660300002)(4744005)(4326008)(40460700003)(110136005)(336012)(44832011)(81166007)(8936002)(83380400001)(508600001)(82310400004)(8676002)(186003)(316002)(70586007)(6666004)(1076003)(2616005)(2906002)(26005)(36756003)(70206006)(47076005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:06:08.2564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 634e93b0-aeaa-4ed9-8bc9-08d9eda25308
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU feature flag shouldn't be used to determine if SEV is active,
that's what `cc_platform_has` is for.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 8fd774a10edc..e061eb6a039c 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1148,7 +1148,7 @@ int sev_dev_init(struct psp_device *psp)
 	struct sev_device *sev;
 	int ret = -ENOMEM;
 
-	if (!boot_cpu_has(X86_FEATURE_SEV)) {
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		dev_info_once(dev, "SEV: memory encryption not enabled by BIOS\n");
 		return 0;
 	}
-- 
2.34.1

