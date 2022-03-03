Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3754CBEA2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiCCNQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiCCNQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:16:28 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4731704CD;
        Thu,  3 Mar 2022 05:15:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lC06Hxn6HfF5ZimPrijCCBfM2t4nZFeiCLp2AoInzkLrReyKTGTvbcbR9oMVms3AOsS8Ki5LuEBCKT9itQiFDqJy/8Jz0jwWZlk+VJbaA6Q54d+GUFQ4O2szY3qbsvp4LRp8R+W4fJLRGK821hwDFB03dET5/zm8bXRZPnHb37rpTZG42nQy5kKW8WgfRKyMNKChT/byniYSs/ZXvqlcVNyuK8kMZ6BDNyEkXnSGPsRrtDUU27cObknXHqoAnfeTu+AZNixrIaiivcAWGuUetdaK9cO7znPZCiWLCh82fVCQQ6ieujl/y5c/k9weEAs27gH+cIOkRw67LezQiYc0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iek3zIrqS1TNhV+bG4CsDnTnOCSj0nawThqO7uD4IN0=;
 b=c8E6mKo9XnkRCyyUy1TgxQfAlslq50ZuCIAwPyBUTT+oHy3j3RcH78bp99H+YU5DJETrezN6E32V6KG/5dFq4ge4Q03oK6Qwvm8AO5r2vcHFy2iGoBx7JlX4iZnglCWVGO8poY1aLzXqzJB5dqbvwlCR6JqfeAIvm8jfpbOX2eRr0ko/+T0mVBE8GdaTd+Q4+Z7D4VH2OfoJM8VH3bKf+YxO2S8PIl6F+sxVTkdIpyGeWxBvHb10+a+AG6ZFbstxG34Lac2MXFNa9TF8rDMeXt19PCRqwssaxkZJBzYxXzDuZ1o69EZysVUPBzH0iXISmCldHwiJ6J1WQnYt7kJCNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iek3zIrqS1TNhV+bG4CsDnTnOCSj0nawThqO7uD4IN0=;
 b=HoZYVYmS6wmTcLU7IEELcgN1BqEuAh0I4aW4Qpgz8NVaIKCIgmHOFjeR64c+RlbktvBQ+ym43bMlC2u9bnkfLK0JnxzH2YY2UYrZmg0zxx1ozN3fL0LN7oNqaIxnegL5gZUJeuT5RFIAJmNGDDgsZlVx7nOmuLWrabjqHN0btQA=
Received: from DM5PR20CA0030.namprd20.prod.outlook.com (2603:10b6:3:13d::16)
 by BL0PR12MB4881.namprd12.prod.outlook.com (2603:10b6:208:1c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 13:15:40 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::52) by DM5PR20CA0030.outlook.office365.com
 (2603:10b6:3:13d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 3 Mar 2022 13:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 3 Mar 2022 13:15:40 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 07:15:38 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 2/5] thunderbolt: Do not resume routers if UID is not set
Date:   Thu, 3 Mar 2022 07:13:25 -0600
Message-ID: <20220303131328.4150454-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220303131328.4150454-1-mario.limonciello@amd.com>
References: <20220303131328.4150454-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f26d8b9e-e948-4f64-15a7-08d9fd17ea42
X-MS-TrafficTypeDiagnostic: BL0PR12MB4881:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4881FAB791D8F0147443CA2BE2049@BL0PR12MB4881.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwyguXconboeo6f42MnSgSrfN1l35/kPRi67sSgfzIwCLx7LHinjkxBLGffXp2mmFfoWWFQ43S+OUgOjHmDQ30zO0zsxvKyX4KMnqlTNW0NEzMliekbFkpCb3ajeoxnEFSWdO+LvHAwbMbWP2fVrVuKwiebAE87Q0tJED/5IRslrcMCO+ff3uLREmm0RVJFOjAlhLTnpIJpMS3iso8VZnZ7neS6TJ3dG7093wo260GdHXIw0YsznuLfS/Y4dbft9XT4D5J7fcB7szXhq8Od5e9/a60bEjfmsH8GhRriCZJpkdBiPzw2f3hgOeg4k30dPlaIRsNHeZzfWmYL6nGO4sVNrq9l4arB07k/mSY42qM/DROiGiQK3ZuNpDIH1P6N9VN74CJK4qulOgXjAmcrYr8lG4sAN9TkczSmFBVtFGO12O9SVOiNpxuDcgpORNigTywmUok1yAseXXohb/jXbcyW/DXap0/HpxFM+VBfW159u41uOfV1FasjQf19ZPQheoFLh/cnL1/3rPtMvrsFz7b89NsZ5YoXVeGtTZEab5RXlmPoUSnBQ8k7cbvXjk3hU3mWrGPHf5t0WIVHqYytlMn56B52awErVjJNJ+tt9rAFnt4SE0P3PehOoimtt2TgrBAQ7T2qdPnmCNfDIqQQfRHlUOMfNpUm/fRZRDFgKOrs5WLQSiTvfknHboTdbfhk0eeZou09zkZyHTejdTlnxlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6916009)(5660300002)(316002)(8936002)(8676002)(4326008)(2906002)(26005)(54906003)(1076003)(36756003)(40460700003)(186003)(86362001)(508600001)(6666004)(44832011)(70206006)(70586007)(36860700001)(81166007)(356005)(2616005)(82310400004)(426003)(336012)(16526019)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 13:15:40.4816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f26d8b9e-e948-4f64-15a7-08d9fd17ea42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4881
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Routers might not have a UID set if the DROM read failed during
initialization previously.

Normally upon resume the UID is re-read to confirm it's the same
device connected.
* If the DROM read failed during init but then succeeded during
  resume it could either be a new device or faulty device
* If the DROM read failed during init and also failed during resume
  it might be a different device plugged in all together.

Detect this situation and prevent re-using the same configuration in
these cirucmstances.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Update commit message
 drivers/thunderbolt/switch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index b5fb3e76ed09..294518af4ee4 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2980,6 +2980,10 @@ int tb_switch_resume(struct tb_switch *sw)
 			return err;
 		}
 
+		/* We don't have any way to confirm this was the same device */
+		if (!sw->uid)
+			return -ENODEV;
+
 		if (tb_switch_is_usb4(sw))
 			err = usb4_switch_read_uid(sw, &uid);
 		else
-- 
2.34.1

