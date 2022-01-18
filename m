Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39A64912BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 01:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244048AbiARATG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 19:19:06 -0500
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:39169
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243878AbiARASt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 19:18:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CStQ5fZn4tAE7eRGxTr55TsMHcJNiP16SY8x9ReY5FmLvoAPMRVo2PrbPKYW546efvccAM6h43H9JoHPaOqNnZ2rb992wO27iZQZQTup7ADbfUxnXJb8WYMMJGXOvu1I0ZWDpRieyKUJdBGYSPcqmYGTh83l+0nAuCpZ23N2JP2HHMDy72WE01R0MWGz7Ht6r2ZBwFwoSbDxlKnHxSIe5bPjNuY+tGpdIQVbo9znu2vCWPtXM0aK8ThIs1Uk14IipZaQ10lOSCz0VviRcDvOdkpnGtBUZ4bbgOHPQqfmYodNL3pp+nWD3ND54lI13PmOlpB5xT51GofATQzbBm/jJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arfCdPsLWsD+Wp0ypNL/XEOk0UeOVvq0Xn2HLNzr7i0=;
 b=TW0HM81P3J4fjKobIFsu5FZQ5CzG5Hc5hr1ObZPbC7JSFoomm9z5r35k7wcDcXjbRAmHQOwSMymhICbrDxCJ6Y3ifatV7GJawNbUHXQAQ/PLUeF9ubngESAVG4BxguQO69+eFPE9N9G/hylUh68ZFy1U/ctKCp+SHHby4IWX29oCx52RxJQLcki0YbXz8h0raF2k8MoaieMCWyV8ltIUAftr1WIhZVoL4T4Mwt7ZTC11ZEqixl8B/ElHbzp4n/weD8RKMGDE1eppCKFlrH2aBwfy14OBcUlIuMYIrsUIWYyLVvNApAdITlzg+oOBxeFjPPynfWeXAQUD+2s86hfQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arfCdPsLWsD+Wp0ypNL/XEOk0UeOVvq0Xn2HLNzr7i0=;
 b=IqVHbA1fDwxW2QFzZTOy4fiyftL7poWAzzqsaucy4sXTE7TH2uyiP9dob2OgGZu0gMkLiBB8vkrUjymBuqh/9/xXZ2+9acUASGX82IZJElUnVxpLa0EoQzsZItQnuIUg6GZIWrTcfV+7cKbm+Tz9QFrpHruPoI+GiiP5D2A8CKlc4h/7mwITiP392snfpRIdf3ALE3eQhnTKl5O1zXQKH5cAf97hMG0k+/VyvZNuHJtQ65csCeyc76jFcGLbyJabiFPY4CFT27oTON/RRsinl/3nVyA/BA8VpUxw+xkiy5yTzvYVy+JKGVCp8KNFN7hLBtghKVXFINhjnDHwI1F7MQ==
Received: from DM5PR15CA0065.namprd15.prod.outlook.com (2603:10b6:3:ae::27) by
 CH2PR12MB3910.namprd12.prod.outlook.com (2603:10b6:610:28::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Tue, 18 Jan 2022 00:18:47 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::65) by DM5PR15CA0065.outlook.office365.com
 (2603:10b6:3:ae::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 00:18:46 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:46 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 17 Jan
 2022 16:18:46 -0800
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:46 +0000
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [RFC v4 09/11] tools: gpio: Add new hardware clock type
Date:   Mon, 17 Jan 2022 16:22:12 -0800
Message-ID: <20220118002214.18271-10-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118002214.18271-1-dipenp@nvidia.com>
References: <20220118002214.18271-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7afcbb89-0f0b-41a0-faac-08d9da181834
X-MS-TrafficTypeDiagnostic: CH2PR12MB3910:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB391061FCAC0D7D66F4DA002EAE589@CH2PR12MB3910.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVE6Klb3Dsq/zgt7j2UALMpif3AZUb62lBXViMfzJg0JPcNIvpktilCkd3eTPHAklcP+/8H1JvX7FbgLPBvl4kLw62L6uDGdb9uIIdxVx05AF8N4q0GIyT0/U8gllaibe1quhltABiBinaR/ol0/6VUBuzf6NLZbo4egfULzhwCPVhruyQodPHohlQPVWtWUPqSMhTR827OsEVaB96JYLbiDqo/Y3K7k8+uXSBflBOLQg8+cM6KXivLhoEXcr4t2YH+T0McHd1PdRPtqSA2mFyTVbEJTS29VeCOXKELj+pEKNnEnS/vHcdf6ObbcDuo9L4taWcFD5Jy9Ty6YiOOGhgpMtel5GC/YEVdXU8FFK/x8Jk5wXPzEgQ1s0JJGJOiDeu2ci+60bYoDJMf4rzDM/sCK1rARWWdEjdQQPsOH9Gz/nt5WfZzPc6b4krZB2BAQ15dU/IrBOAVifOVHtNF6yK2syy20f41Eb8exeLLK6ZHUtpbMqebPGrSrMeTj+Fmmmp8JVvx79K9pHYLB+97qEalXOnl/cXvdS3fpgIJArjVCO06ryamrgwvDA9luYBFI0dC8l4zhtm6OZS7ICoMt2dATaD9wsD66EqTpbY3oeg28ITFwu7wn42To5h6ujlOIoCfB0SNYqjCbFsUO/jXLljkB7LMhWncy2P16tQIyvcjiIvdCRltfV+g0oppSHMfSof45gTfk53gA/7HETDfe1UrjhArhkVuQ43+NJg6QIrELfuChr37rCTEo5UFf88I0EJ2Ww2FsHAxhv6211m2Y/pWryG0VPJ6w+SXvGHf8nO9jNPPsUHyJN8Q98VzSPD/e5QOg4AOHobiosFwZVyFlUer1nULRvcV1OSLclF+bppI=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(26005)(36860700001)(82310400004)(426003)(110136005)(8676002)(1076003)(6666004)(336012)(2616005)(86362001)(40460700001)(5660300002)(36756003)(7416002)(47076005)(356005)(508600001)(70206006)(7696005)(8936002)(186003)(83380400001)(107886003)(81166007)(316002)(70586007)(2906002)(4326008)(921005)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 00:18:46.8581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afcbb89-0f0b-41a0-faac-08d9da181834
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3910
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpiolib-cdev is extended to support hardware clock type, this
patch reflects that fact.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 tools/gpio/gpio-event-mon.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/gpio/gpio-event-mon.c b/tools/gpio/gpio-event-mon.c
index a2b233fdb572..6c122952c589 100644
--- a/tools/gpio/gpio-event-mon.c
+++ b/tools/gpio/gpio-event-mon.c
@@ -149,6 +149,7 @@ void print_usage(void)
 		"  -r         Listen for rising edges\n"
 		"  -f         Listen for falling edges\n"
 		"  -w         Report the wall-clock time for events\n"
+		"  -t         Report the hardware timestamp for events\n"
 		"  -b <n>     Debounce the line with period n microseconds\n"
 		" [-c <n>]    Do <n> loops (optional, infinite loop if not stated)\n"
 		"  -?         This helptext\n"
@@ -174,7 +175,7 @@ int main(int argc, char **argv)
 
 	memset(&config, 0, sizeof(config));
 	config.flags = GPIO_V2_LINE_FLAG_INPUT;
-	while ((c = getopt(argc, argv, "c:n:o:b:dsrfw?")) != -1) {
+	while ((c = getopt(argc, argv, "c:n:o:b:dsrfwt?")) != -1) {
 		switch (c) {
 		case 'c':
 			loops = strtoul(optarg, NULL, 10);
@@ -208,6 +209,9 @@ int main(int argc, char **argv)
 		case 'w':
 			config.flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME;
 			break;
+		case 't':
+			config.flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE;
+			break;
 		case '?':
 			print_usage();
 			return -1;
-- 
2.17.1

