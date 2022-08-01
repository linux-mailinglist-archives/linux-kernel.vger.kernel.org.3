Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CA4586D3F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbiHAOt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiHAOtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:49:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FFC3C8E7;
        Mon,  1 Aug 2022 07:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELroC6QQzNAmNh/ZNSvEYL5TbdetCCd6kycF9pwu7p9axVT50RaZcIIVxWuxtYTt+jk07TgXta3Im2ZHCsd4/S/6NYI6XKMyA7SFCttnJX9BJad5REhxtDUTMxQXXBoQ/fci/Ivt+xeQDDeifXDdRGCyoLIFNlr0jPgv7ZRf3oGgSXYLHheQk/E/YsrF8VAxpW2jUYmbYuGn/6fEvi4xxrZ1SO6fZHUP+lH4E1EjCapAokD9MOAxTkZ4kHdEqJ3XICCNVFyQAZhydtGX7PIbz4I7Usgvc5q0YkZ3W9X+f2Mnr1ZylzYqjA+wfWJ7WQwPIu+WWbwCncFXcfHVW1AGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrP2dtp8+WyUqggtfhy9tbd15iRfJ/Umtu6VxQjbocc=;
 b=d4mSbWtQMgBz9BDNDY4rGbOeA4/rrxEXg86v6TPX7BZhDVyzCERAsL/6hwp3I7TogtKJlEEP2U1OU4HyhNDwabJW286iouinJFsVgOYU6ttoDBXRYbEu8sQY57H6985E6Qic3WvqBaH8G0VeM4gewl+7Z0lQ8B5MuXB7UuARU22jPaf+2HOMqZfPWAWJjFmnt9+FFxtGuQY0boGYgmWsAPbw7iujtQUohOp152ldlKSCRqjeaQFvtL1MQWD7Ge5QcG4NdKeoVnss617E2wIvauzEPjiBqiWJuEHZqqnapnPJDYQtYAvVsiQilGoqAVeQvzHbbc9CpQ1euRmCeMt6Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrP2dtp8+WyUqggtfhy9tbd15iRfJ/Umtu6VxQjbocc=;
 b=0tKPFtKrpu06kRozAQVxyJfK3x8UgMrmkLJiZwVf4BuMFB+ONzP5qfPBj4KU5Q03gKI0/Imq26i6ynvKoNPviDzwPHPHWaTjlBEedqKYl5KNf43oCnb4Od2pTp4lOLdLfpO3Iqhh4qsIwgI5Zee5F/yD/gmCF0i8TRE0O9szciU=
Received: from MW4PR04CA0034.namprd04.prod.outlook.com (2603:10b6:303:6a::9)
 by CY4PR12MB1686.namprd12.prod.outlook.com (2603:10b6:910:c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 14:49:52 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::37) by MW4PR04CA0034.outlook.office365.com
 (2603:10b6:303:6a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23 via Frontend
 Transport; Mon, 1 Aug 2022 14:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Mon, 1 Aug 2022 14:49:52 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 1 Aug
 2022 09:49:51 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     kernel test robot <lkp@intel.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] pinctrl: amd: Fix an unused variable
Date:   Mon, 1 Aug 2022 09:49:52 -0500
Message-ID: <20220801144952.141-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 232d3863-fee6-4d40-ec50-08da73cd177b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1686:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4cSml9cuix3AkUUMIlU8bTusp4jiP67G3x6PR1csbn/IWYe9a/cBnAL8CXMLcXHrGlcbi+YaHG+3IECtCzrZGN6ZodeYPfcN6Pr+VZDEjS8pue88dJbrURYwKJomiM3yL8TikNTwKRdgs/fA0pemhmfbqi3Z2D3HAxkv22Y3sOHWJ8DwyOrpKGqbtF9XqDDX1KXKAqXQq5fOakPxC6hMxthmwRmdXMTpfPCRSD6PElNTxVD//gFoVSfB42MNpkKEPOalOcMBrVf+tqUbXVQMabUOEJwcaDnfiYS3pExjpblF0ZmAOvCJdQHfOY6DC+2dznFHRTmUyp7zB7SkEL82f/ldDMcgHsbrXaJTdzu7LMOBFudHgB0e7kXX5gSJ2vBS55OP4unrNsNf2nym645jOtzALv1F3rRP+aGHSHWTUG9iJ3zZ/iYlP/ZpOfqOqsQJDacD9SKregz/bpQra4DfKXU2iQPz4VMHc5GQHrmBuTLzZwiTorbAkEqobEQg2FGKPhughtDBi+h5ZbLQftcaldFRnzVtOmtLbFvMK9qhmXBw8tmwm8uOuOuh45O5vQTGzxbAOx+mgyIdLqYTV52xc5s9pgXWCreI6xwIElyPFLfKKAdgPJ5DjZoQQfmkknLEcM7pmzAaO6fvgPJYshQaDYEZVjs5LLBrD6G+AqL57HpUkn7JXtNqBiH6QtAsdRY/IIaL0RdJJK8BAV+OOBzSFmvZVW1Ma8bLA3LuoKEsGqKWF2pmM+a2usxgIISRggQszdYFBfmFiNIaDNn4yEZMLFR7AHFl2ny2NRDI1IR0Xo0d8T6l1leO5WAyqRIPtqLemSVESUWPdXiw7Jpoa7OLzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(40470700004)(36756003)(2906002)(8936002)(82310400005)(40480700001)(81166007)(4326008)(70206006)(70586007)(110136005)(316002)(54906003)(478600001)(8676002)(40460700003)(86362001)(5660300002)(1076003)(41300700001)(82740400003)(336012)(426003)(83380400001)(7696005)(47076005)(16526019)(186003)(2616005)(26005)(36860700001)(44832011)(4744005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 14:49:52.3958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232d3863-fee6-4d40-ec50-08da73cd177b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1686
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`char *output_enable` is no longer used once switching to unicode
output.

Fixes: e8129a076a50 ("pinctrl: amd: Use unicode for debugfs output")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 492b76f2c03e..4691a33bc374 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -216,7 +216,6 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 	char *pull_up_enable;
 	char *pull_down_enable;
 	char *orientation;
-	char *output_enable;
 	char debounce_value[40];
 	char *debounce_enable;
 
-- 
2.34.1

