Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825EF57A4C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbiGSRNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238402AbiGSRNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:13:13 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE7C54667
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIiqcRXZenq69FS1nnCH3ZAR+S1MpRcTwwdIc7xSVyrT1j35nVaKzxdoLYEbPHyES7RBBR5qKIg/Kx//ylzlrPU/RfNCp2uEWrdqqCB8oJrpm95HzH9YJwcK/Vd8gvXiR+jlW9GFnyn2W1XMHVHUT5F/rVOVUfntf1jJvtHpeTFl2IUf8+fK/NO4GcJY8qBvTTEpd4g04voVDBKE7ZiihzKTR9pq6ECdVMOd30tXjeOKOrsqx518JRCCRFI3GagoyrqHn+LZOPSQIEZ+atSwh0G5DfQMDj6SzEZEKvevfHeO+bqem23LK+Mg+Jq4+CAShUWulpyZSGchlfRxBtHkJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHAyabTfYcT4LdxTc2BAjkFFpnLflIwskfObK6i0FwM=;
 b=LdMy8wO136Kx2pVkwiL2K3/lmhIr2fOCMi9ATqreMg8mv9Fj5m55Hd3LfbVCerlHIZKzuEdOw2b6vGfi8NGM1ZhpzbZcNBWlcUWzwmunfa9BJ7mxOlySwWADcxoyB251gaGT07950oyoYPwIVnAl920IHaIfKZPxLi+xsVjozMTu1yEfPx5J8VVF0TRp6rJgVBcunWi9gG6gCaVPJz92R/oOgDTnEdXoZQ7rgYvQyiMu6r31XeaUwabLOvXLJC9OwkuJQasypzWM91gdnQtpKeySd53DvLis2OEKpB9TNsdOb6jgq+o96N8ca9tHMdOH9NKnUHvmPOj2cdkVlEj+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHAyabTfYcT4LdxTc2BAjkFFpnLflIwskfObK6i0FwM=;
 b=T8eZ7vbh2KYvz/0J+/mups/ji4ARpZIM7glF3ASbus3Kh5oN3gLnA0IeJNHGbgTv8x8p6qdVd/BXxE9+7qULfXlFQuM09Z699aAe5va/86XAbLeYRLXHmKG6Q9uXsi2tCYsonXJkiythRvtHHnAVxdsoDAhmcXNx66qFzkGMTrU=
Received: from DM6PR02CA0158.namprd02.prod.outlook.com (2603:10b6:5:332::25)
 by MWHPR12MB1582.namprd12.prod.outlook.com (2603:10b6:301:10::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Tue, 19 Jul
 2022 17:13:09 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::74) by DM6PR02CA0158.outlook.office365.com
 (2603:10b6:5:332::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.24 via Frontend
 Transport; Tue, 19 Jul 2022 17:13:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 17:13:08 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 12:13:01 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Borislav Petkov <bp@suse.de>, Michael Roth <michael.roth@amd.com>,
        "Ashish Kalra" <ashish.kalra@amd.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] virt: sev-guest: Pass the appropriate argument type to iounmap()
Date:   Tue, 19 Jul 2022 12:12:52 -0500
Message-ID: <31a05c67017d023a61453787033ae16f04dd7377.1658250771.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fea0597-3e21-4345-b938-08da69a9f3c4
X-MS-TrafficTypeDiagnostic: MWHPR12MB1582:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQY6LOrmwxHPCvHIN2SzVHGdMll3Nb0PQQ+Ve66/41vc6xY8NwE2p3vrXF/ErbXYwlxUJGpNSFkzBQB+KDTltatflwb+LzQX00qfFiPPukowvMb5JBRNsaL2X/UtkqdSdi5JZBCM9yW3S/mYz7G9dXAYoSLFGFao9GyOjGD3WJJ5Uc1PaIjMB3cGOGrfuciN3wMcBj8JSN9uSy2oY0ldBgc2bu3lOa4w8vCkpmz+QyeIII6C9PZ2bs0CZw2q2EWmnkpb7a9w/EwMyy+h1ZRRPqqXB8xhDBrswQHCCrJPLTJhM+owMUzS5jvdGG2iIODYzkKpOmnRAYioeGcm0RqI9jj0YT4qcK16hDmgq4dGxn4JlpKdsbuLHpPaS9Av/ymJ8N1Xv6G4Mg6o590zmcFaWd/wGGQy3hXPNSSiKqEoNhDgicunJ/8W2WKnLfn0FX0Q0OGpKZ5aDQLAe440+ra2q3OReIfWU6KQyU+9YZDbeq/0uto3rkx8ubuFqciUGLowhA4Qvc4VUY6qC008081wc2MWz+7CfTSKsi48cP/W8IGWmpvTdM1woWdJkWSOF5zRk3yej1bbmDfFl/17TtVvShAyK/OSpB6OA6iwPqkkqK1wnq19W2Yhn5Sy26P6XXkIMMDoZsAyjFXtWJVyuQDN2JwevbvvL4p0HEGay2CJRSJGf+32YOBxAbaOsPV/YWOr5EwSFa+pZZPe7iR3YKmhBD1YF64AkB2dWweKdaxOkDIN7/MfZJUa9nI3uhT+JuQf2GLQGncWRgOiJnQxh3Invo5nN7wRN86wxPzrcV0SQSgtzC2PBKw3DUPnK7Wlapk4Nl6kcqshq7KiwGnFPjApcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966006)(36840700001)(40470700004)(4326008)(70206006)(41300700001)(8676002)(2906002)(70586007)(2616005)(478600001)(5660300002)(6666004)(7696005)(110136005)(186003)(86362001)(81166007)(26005)(40460700003)(8936002)(54906003)(82310400005)(36756003)(36860700001)(40480700001)(356005)(83380400001)(316002)(426003)(82740400003)(47076005)(16526019)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 17:13:08.5398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fea0597-3e21-4345-b938-08da69a9f3c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1582
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a sparse warning in sev_guest_probe() where the wrong argument type is
provided to iounmap().

Reported-by: kernel test robot <lkp@intel.com>
Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 90ce16b6e05f..f422f9c58ba7 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -632,16 +632,19 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct snp_guest_dev *snp_dev;
 	struct miscdevice *misc;
+	void __iomem *mapping;
 	int ret;
 
 	if (!dev->platform_data)
 		return -ENODEV;
 
 	data = (struct sev_guest_platform_data *)dev->platform_data;
-	layout = (__force void *)ioremap_encrypted(data->secrets_gpa, PAGE_SIZE);
-	if (!layout)
+	mapping = ioremap_encrypted(data->secrets_gpa, PAGE_SIZE);
+	if (!mapping)
 		return -ENODEV;
 
+	layout = (__force void *)mapping;
+
 	ret = -ENOMEM;
 	snp_dev = devm_kzalloc(&pdev->dev, sizeof(struct snp_guest_dev), GFP_KERNEL);
 	if (!snp_dev)
@@ -706,7 +709,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 e_free_request:
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
 e_unmap:
-	iounmap(layout);
+	iounmap(mapping);
 	return ret;
 }
 
-- 
2.36.1

