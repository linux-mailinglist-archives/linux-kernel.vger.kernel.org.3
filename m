Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0A3471C05
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhLLSHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:07:07 -0500
Received: from mail-mw2nam08on2056.outbound.protection.outlook.com ([40.107.101.56]:45838
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231903AbhLLSHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:07:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5vfWyKudBOvo0VVsMFFy29RPjIPm+3NkOfilaeVWgncQReYQOevSY2OQDuTVmNhKvGB62vSsStfBDHZAHk0LzNUZmtvm6VzNESuy2T86ZVxJnDHy7A42Iatvw+LU5r9fPkAAdDPBPjR+QnYDaqbdY+85p7rdAiENKkk1UzLUaxMSBS2Fsc/OsvgrMFxvaofsAwkgOtgjS4HjN6+rWIrcCqh8fmzJ67NBSFATCOIri3CKJggHQMXy8m73H/u23RhrRfnvIYuc+Gydcq+yeWLEVG0saYZf33tgvBbzv/H84rvr/tMYx3NdeWAttz+POkmIsp8+Cfx0Ye4A+FV2ctXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtpW/c/nQQhTuOuknGvDubtDIGzfRXm0gTAqrKlvILA=;
 b=l6bmmLB0qfpXFJaYluIfsgfMP8K6pwmmXAf99OnjqyykeH8ccG+sQCr4tcABmjP3vLpIEn/uJGPQNWXl35dQJN46BaQkCJ9jylD5hgAp2u/Pf3ZqkgUhpGxYPvJJRJHA2+VKXyfmIPK+TaUHgkob4h+/kGluUCxP8v8r0sT7FRsaTEng4oMcS3BjAxLp5e3eXLd128EDjzN7GFrd2HlaHghr9G9Qah3bdKCg2pbG5bh9ut0+U+LF5Yk0dREhhU1zyYmf5eiB+inC0gD3T3cqtV1hgrmkUO7bURCzkfPwX/fdP7Wzr9L3+rdv6igsGE+GTK5l/OGHGZbEBTUAL64BLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtpW/c/nQQhTuOuknGvDubtDIGzfRXm0gTAqrKlvILA=;
 b=NY3qO08/FoOg5WErsxfUOxp1zlULV3rZ7ORJzAzs2thsAZZl/fjwcBJBncZde48qpIOtqYIGJKHCAiqjgh3bwy591mhznVq3ilrYxZunBFsynANJkJ22pj+3F996LbVex+D8Iov9IH7Do/AHGmR4IA+5CALqJwFn/yWcBUGngsY=
Received: from BN6PR13CA0071.namprd13.prod.outlook.com (2603:10b6:404:11::33)
 by BYAPR12MB3030.namprd12.prod.outlook.com (2603:10b6:a03:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Sun, 12 Dec
 2021 18:07:01 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::2d) by BN6PR13CA0071.outlook.office365.com
 (2603:10b6:404:11::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.10 via Frontend
 Transport; Sun, 12 Dec 2021 18:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Sun, 12 Dec 2021 18:07:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 12:07:00 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Sun, 12 Dec 2021 12:06:57 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/5] clk: x86: Use dynamic con_id string during clk registration
Date:   Sun, 12 Dec 2021 23:35:26 +0530
Message-ID: <20211212180527.1641362-5-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211212180527.1641362-1-AjitKumar.Pandey@amd.com>
References: <20211212180527.1641362-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3d658f8-eee0-4abf-295d-08d9bd9a31f6
X-MS-TrafficTypeDiagnostic: BYAPR12MB3030:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB30301315610A436509D2335382739@BYAPR12MB3030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GlcN3YusNZsk7rawxhf/bBnqOuHtYKHTHq0qknkznxUp3JXZWtKbB5+kgxRPnCnMmPtTzZbs4sF3i/PKFwKA0NN2Ce9v02Eq4+zSoybDEQdsYISjC5d64inhSqJFI9C9sbRyn8nqfqQOANYXtaSsKxHVi35b7375r/6Ff4la/IlFfaVFh8G3saXEjfFxLuXoIyDsKQ/qXd3RSodhc/IEAa6sUCjDQACK/cUAVeBE7pv8aupW7kicGzHNdk0RBohmGHpJmwCK4/sCaU99VTiyN9vLACIn8g9GPYkyBQWrR3fFvLEuwEGU7KQsvY1u7agy1E1SFg4cGBsYB+BXwwtNrlW78LNt8YJDfvE03C3/jqLSMF2K+km55FhiDny8IBBThPSx64hZ4NgRJ5nwArMqvaPJZGyaLtKPhVfbkBv5Ts6nJ+RLr7A78zCJ+zyyEJhHs0Snq8SoZylsQBpeKf7S6Fill4b6RhZ9lFrvnRGVKQY1WdfqXQEthmrclUCYOh7H08QW1O4uuAr2lKU1PbaiZI7mTYpE4K2qABUINwl9bzB1DZtEEKf0kO1gtB5FOLmm1QvmKvgV0zSbKUDHGs/lS5b51z1mvD/RwpyEaEPg6V5583koyBIQDL4/jighVpI+V8Pe5KrXNFw4/qKUMgSTVjD4M4YR+nb0lJ1M8hoNTEl1y0beKaG5AJaw7uQ94kuxWA4loFnUSSHGM+IDhFaz7RgTSnftGdwN+E0G3aRYWJ0YcMhv4lIjwVAWHeBnMAazdP64May9MnoMQnfHVU4zeuI5GBqGHJHZ54J8X2YLGT8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(6666004)(54906003)(4326008)(8676002)(86362001)(426003)(2616005)(47076005)(316002)(110136005)(356005)(40460700001)(8936002)(81166007)(70206006)(70586007)(36756003)(1076003)(82310400004)(508600001)(83380400001)(26005)(2906002)(336012)(7696005)(186003)(5660300002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2021 18:07:00.9996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d658f8-eee0-4abf-295d-08d9bd9a31f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3030
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace hard coded con_id string with fch_data->name. We have clk
consumers looking up with different clock names, hence use dynamic
con_id string during clk lookup registration. fch_data->name will
be initialized in acpi driver based on fmw property value.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
---
 drivers/clk/x86/clk-fch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index 6a726420bfcb..d41d519b9c2b 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -75,7 +75,7 @@ static int fch_clk_probe(struct platform_device *pdev)
 			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
 
 		devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE],
-			"oscout1", NULL);
+					    fch_data->name, NULL);
 	} else {
 		hws[CLK_48M_FIXED] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
 			NULL, 0, 48000000);
@@ -85,7 +85,7 @@ static int fch_clk_probe(struct platform_device *pdev)
 			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
 
 		devm_clk_hw_register_clkdev(&pdev->dev, hws[CLK_GATE_FIXED],
-			"oscout1", NULL);
+					    fch_data->name, NULL);
 	}
 
 	pci_dev_put(rdev);
-- 
2.25.1

