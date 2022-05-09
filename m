Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A894852027E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239180AbiEIQhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239174AbiEIQhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:37:20 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3EA28E4F1;
        Mon,  9 May 2022 09:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCVlziAwEgZW+GLidLCznrUZrDtaZRxaKy+CWYyYraa/opjH1T38hmZLywyNvmD1RsTkb/i6t/unc+4e2BFiwctsk2aErKJ2HLCF8k9h9oHvoHGCZav6hWBLrWJToQyAdeC3NwZRvasGU14UQyhwhOkQPwMp90qRkJBiKG4v/9cLjGysc9QSG02JLoEzLPXghuqEvKGt9abgQ5CxbkIhI+IPpw0MvIyOX0MKqj0WaT6DNAikidtQuxDna13KfKJv8pUwrjrnmrvXgiz16ub0SDoJCnWaYc5MMbm/30hs9CXroYpSLYHu5b3LaDmMaWWZ54LlvONXjKzLLQC6sGy9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYOfcJXz+JfCaBtYV9/fnKrUFuEE+Qp2qI8iPH4UxR8=;
 b=YSgXah4vClCew4nD15oDar5AyAJGgkA1cG/uHPFY/4G6PUBkSajDJ6CmKGrKDyHckRtLK/1QdaZr2Sj8iV68kBAFL6vVAjhvXbLACFvzceBrhkA52zoWpGl8AQkY/E5q0IwTKWMqjEv8TA16u732cZq4ENqst5owSqtxc/7BCj4/iC3+Z8ZeVGcnHbpmIdQ32GYBmNTY/dlmc9Fjg0Z3RoDETuXsM5Kzq1i886WHF3v7wyA7MifHuOcspHmOmzCGnY3nXHfUlTWWxR1I+WEv5VHALKjbMtwEZDftGOZbMZdbQ8JMw0h8OXfUYkgMiIMOUrXQ2+ZAgxsPw3cgwdKEYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYOfcJXz+JfCaBtYV9/fnKrUFuEE+Qp2qI8iPH4UxR8=;
 b=HZXZjhbCs/gUfBcbfsqsvwHRp01KI1tpQKLl8OP62dnIsmAxtDbp48JvyiVvk+xRE+RReyZtGHJVnSIBkwmVulVU2b9q8PPwYu7cwYcQel+0IqWs1ZBbTkXpHzukoZHnm93IFqQmN/piVO7Rvx/D6hWEQHqOjhFncQQs/guwKUc=
Received: from DM6PR08CA0022.namprd08.prod.outlook.com (2603:10b6:5:80::35) by
 BYAPR12MB3191.namprd12.prod.outlook.com (2603:10b6:a03:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 16:33:22 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::bb) by DM6PR08CA0022.outlook.office365.com
 (2603:10b6:5:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27 via Frontend
 Transport; Mon, 9 May 2022 16:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 16:33:21 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 11:33:04 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <ionut_n2001@yahoo.com>
Subject: [PATCH] Watchdog: sp5100_tco: Lower verbosity of disabled watchdog hardware
Date:   Mon, 9 May 2022 11:33:04 -0500
Message-ID: <20220509163304.86-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b22e4a7-ecfc-45a0-2817-08da31d9a187
X-MS-TrafficTypeDiagnostic: BYAPR12MB3191:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB31918D29B33F3A0AC4403611E2C69@BYAPR12MB3191.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDAUYEGUE3NfjDQRgFYdjEF91R0co618gbXBJGHSGXQ/VXTQW5hF3juZPrSSn+NmTjS4lngw0MtS8Z/VI0/+aSW4nwzi7oAxUgp5esRwq7ykRWa4gV/iDTyHZ8B03vyJRvtgsncYgYczD9EEmyu0DkyDRjEzsHClPRh57xTNmGbJCgepsjXVwOsPeK08isvrPCVNmzO4A42WEY5Qecf4cBywEHjI1AbPQKg/4EV2abP1Jk5dwNQrDpZLv8fdrpZ1/+TzIcsZPGm7bIa7LQRHdtt5SGEN9qOkjHgcHoVFL37PFdjSgRS7eGESf84Ngh8hQjwLWn9NrMk+8aJ+VwLMAfCk/NjiMmtid+bZSoxEJUOW7EezxYmFWChR0kivPdetNN3V/+bxc6eoGr38vArdTOGK8p1F9pCxM7UmOGqMIQ+Irrj7ctB9+kDb9oxS7B7bNnRh0FCRjAvKGOPGg+cvNR3gKjPZjYSpCDgyHdvC8rNqMt7Pzj28uz29k89nk6moXfi/aJLfREJlzsJkNzT/wO1e/a8Jv/P23x1T+gkHyJdr60616kogE3ELCc0AsC//GQ8rQvQHfJtJ9DKiLApNxfUE6K9cs0tLMjkXOeiNo5kziDA+yXchllpW3F5UU6HeVb9I/Q9lcUImax8dTCP5WQB4UZ1r1HGFD/PFfB3EGwEgQVhT7qEx72nKt/BVOMZxoNRzB8qJxO/oAQQkO6twNhBPCEZ2Cg7YxXVRrv1/y5ZQE2IueCYp35Wv/dEChOhD4c+bkxQ41CfPdPuF3U9RAVUKtj/03bPXP7FCruvtNOo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(1076003)(2616005)(4326008)(70206006)(8936002)(110136005)(70586007)(8676002)(316002)(86362001)(356005)(81166007)(26005)(7696005)(508600001)(966005)(2906002)(36860700001)(40460700003)(336012)(426003)(47076005)(36756003)(82310400005)(44832011)(83380400001)(4744005)(186003)(5660300002)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 16:33:21.2906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b22e4a7-ecfc-45a0-2817-08da31d9a187
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If watchdog hardware has been disabled, currently the kernel driver
will show at err level during probe:

"Watchdog hardware is disabled"

This is unnecessarily verbose as there is already a -ENODEV returned.
Lower the level to debug.

Reported-by: ionut_n2001@yahoo.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215762
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/watchdog/sp5100_tco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 86ffb58fbc85..e51ecbd5c8b7 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -286,7 +286,7 @@ static int sp5100_tco_timer_init(struct sp5100_tco *tco)
 
 	val = readl(SP5100_WDT_CONTROL(tco->tcobase));
 	if (val & SP5100_WDT_DISABLED) {
-		dev_err(dev, "Watchdog hardware is disabled\n");
+		dev_dbg(dev, "Watchdog hardware is disabled\n");
 		return -ENODEV;
 	}
 
-- 
2.34.1

