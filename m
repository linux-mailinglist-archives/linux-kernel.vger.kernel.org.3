Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9704B8407
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiBPJXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:23:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiBPJXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:23:10 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F381B10A3;
        Wed, 16 Feb 2022 01:22:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRr+41NxgvFZLbUlFEpoT+6PJfbDJ9Qfezah9bNjz3WTC+qeM58PDfkTyvgH3vufcfQN4EQ4q27hhX5Y7DJyh5h6MQ3jJ5lh+XY/+enpSH5JsiU+qKYswOF9mCbFFI9OEYW5mXVrboQxOAmjz4Jd2a8zJ5Y8qrh3FSYraq+v3cBj/lK+qfCXGNJ3MpwrO5cSR6ACXzovTkr+Ne2+TC/8xjprUHRvp4KTeZDO5ZnGlu86aFVIup7+OYgfGidEfnLyAKm70AtGe7W1aUJ9yuX5Ffrn/L4Ws9DlWyrkah3lJB+8CMz4FaX7ThZd85TowP0XYKuvDE32DJV9A05vToSXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyzCqJeD1HQ0eLP5+04rVR1LsYSQBNJgx+wbf5BLld8=;
 b=iJsSRTJ9fPUz3kbUGn53ai0ULebxBAKoviCE/biYNMnUJgzZKHKJ3UGNe1eVfNftT6c5rg5xVaXoGUUvraxuCKym96sTubYFA94lqr4s5+dSEiT5vDGmQpoi2oYY5VQd01oONrNaTE8vdpfWpc4h7/+8S9SDboBiX12fsk7R3nUcqg/MfvLCXDR4o0N52kdiVSIG0wNG1lRpOzb2zKyUw115Z3Hn/j8yzc7BUES39xqxTCU670LHRgiDUSZKEThuY8jFynIjBRx/H381xFS6RE7yXC7fbIXHEbZvcvWAjeDKfBstOcXF/2IxX5/h5s+I9O5Qrf8NNnzf6zOUEe/pvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyzCqJeD1HQ0eLP5+04rVR1LsYSQBNJgx+wbf5BLld8=;
 b=Y7Fcd4B3FlECB2EZVpjV7X+IEHovfjS0ReLkHdDhS84VKM+IDvaO53osNngEQTjYkk0TnZyXwYGbLGgv1bpBBx6YlbhQveSUnD7CkjxseZpFNTrk/QBoh0rIcaEpF974s78aOLIWG0V3jBkD1QQd97cbWxJJrk+AImMj1KfAGwHTHB13+03LT10Y3kNbipYwjDe83tbgNuh6A0PsTPIDcVolyXU6CARtfcHLvxUuyMmFyQKgoLWWxXDZ9tyEsA12mZll1N4noUYUpEAcY4eOv9w8esqVqLrTK6PJQpG3s2Etvur3IKKlHRVVAAe7OJg/dOBqv+VUfYHtV3zcncUA9w==
Received: from MW3PR05CA0007.namprd05.prod.outlook.com (2603:10b6:303:2b::12)
 by MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 09:22:56 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::e2) by MW3PR05CA0007.outlook.office365.com
 (2603:10b6:303:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.8 via Frontend
 Transport; Wed, 16 Feb 2022 09:22:56 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 09:22:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 16 Feb
 2022 09:22:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 16 Feb 2022
 01:22:54 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 16 Feb 2022 01:22:51 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <spujar@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v3 2/6] ALSA: hda/tegra: Hardcode GCAP ISS value on T234
Date:   Wed, 16 Feb 2022 14:52:36 +0530
Message-ID: <20220216092240.26464-3-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220216092240.26464-1-mkumard@nvidia.com>
References: <20220216092240.26464-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15e88258-6295-45de-c345-08d9f12dea2a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB252437EA4DFD51ABA466BF1BC1359@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ekfXF6D79sgn2s8HL44Vfl8Uy7Mh4eOUSHEMI07n5cAC2fbn53P+pNHozc4oj86hxytMVpYmiq1RP2NT7y0sLN0QDJ7tY9rfIjV8YKnf+bzCIq4uAQs5YR2wfVuXvp+OepQKdp7v1rO9vJFlywLbvSDW5UNCBRgAPzqD6LvelnV+LzbNMQGn4M7ou46u7p789uGMll3s62iOs3tPI9xHmQ1S+muPSNh30XesAvxE4KpJEsL0w56Ny7qh7mOrB00yt3Wg20ECb72BBl824hFpvZjT5VdNf/EwcUOOCeID1NZ5H0kTub61nH5cd+1fW3XUe1dUQ/pmTEcKLVMzsPgQCj2QZXmPXlUZuOO5kDpVgiJDablfRM0f26ULHeXpPdCbrvc2MuJro4JimfBaYErjevpT8YyDMniMvqLRmESMSfDmMbInSHPDMjg6KALu2+m0u4rv+1VqHdWhrBM9Kr+xBSXZ8NBQD/nCKLUHzc2e8OH+23AR0veDOlboPHbvvO6XABlDlZrrFZhiCUtWmsDtmWCSJGn55AorERIF8HjkXmao9vE4uJvvIXjoZFTL5UaYzmN7yNyF+omYzhguz7gdmKB0zy4FeetP3XFoBsCoKydlcLcBqo6cYbrOwX0QLOC6jhrOGz0lssHWACr2dabGRj+ALLIOK+HwFfCSLGxlpxZAmi0uvdey/nBPJB9faIegxvRzrwSRi4Lxmt0Ris3jlWHVsOu0l6d6yKc62HV+hP8=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6636002)(36860700001)(1076003)(63370400001)(336012)(426003)(63350400001)(2906002)(186003)(26005)(47076005)(36756003)(40460700003)(54906003)(6666004)(86362001)(8936002)(7696005)(5660300002)(316002)(4326008)(110136005)(2616005)(107886003)(70206006)(70586007)(82310400004)(356005)(81166007)(8676002)(508600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 09:22:55.3035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e88258-6295-45de-c345-08d9f12dea2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCAP register on Tegra234 implies no Input Streams(ISS)
supported, but the HW output stream descriptor programming
should start with offset 0x20*4 from base stream descriptor
address. This will be a problem while calculating the offset
for output stream descriptor which will be considering input
stream also. So here output stream starts with offset 0 which
is wrong as HW register for output stream offset starts with 4.
So hardcode the input stream numbers to 4 to avoid the issue
in offset calculation.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 95df52b0505b..2347d0304f93 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -315,6 +315,18 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 	 * hardcoded value
 	 */
 	chip->capture_streams = (gcap >> 8) & 0x0f;
+
+	/* The GCAP register on Tegra234 implies no Input Streams(ISS) support,
+	 * but the HW output stream descriptor programming should start with
+	 * offset 0x20*4 from base stream descriptor address. This will be a
+	 * problem while calculating the offset for output stream descriptor
+	 * which will be considering input stream also. So here output stream
+	 * starts with offset 0 which is wrong as HW register for output stream
+	 * offset starts with 4.
+	 */
+	if (of_device_is_compatible(np, "nvidia,tegra234-hda"))
+		chip->capture_streams = 4;
+
 	chip->playback_streams = (gcap >> 12) & 0x0f;
 	if (!chip->playback_streams && !chip->capture_streams) {
 		/* gcap didn't give any info, switching to old method */
-- 
2.17.1

