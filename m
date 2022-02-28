Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64294C70BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbiB1PfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbiB1PfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:35:04 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A1E13F45;
        Mon, 28 Feb 2022 07:34:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EP3EnQ1V+vFQjUR92u4GBSVz+hc0sLtkKogxBMBIjCUqDFKgNzNRSlkknh3JTAtgJ8r4b5WMMNdytG+jb/kriXOXKZI2jcNRz+YUQ6zv68+fXEc561yO/Xb7zbSyJX/SJJNN4wED5c1v+eprpR2MQbuZhlvpt5WH3vjJFX/iFgSbGuHL0ESIdI8dnZVbbOGerETvY3AmPjPuxhkyC1GkBgisBb1v8TcMpMiTEQ74SikgxLsWT7Iwh8TZLbjacb58Cq2zwlhPJoZ9iyMYwjpf8GxtRM0wm7focAMZhKp6wTf/hwx/KKIzFLtV5g/YVOvZ4v5KeJ1jXH7IFc54usCIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ff8eusduYTHK+ZDOwXUpauVCtlGTHEkj4j5ukv6xRXU=;
 b=C9pUOBarBuZSbktLRRgi3W8Jt/A5/hYxa6iNLKHKgmU83pI50/L6iaFdvZ/498H/elL5hpmku56byvKuTQoKrazkulPCInQjmSLYxbrfx7vcXAuP2BXoYFRI7PcLNmTdjG5qLwLHt+akB8nEwhWqRRV/wGpgsS2lW9JAQUYwGFtzz8CATaco3zqZGn+vHfUUj1591kOAiCZ96AvuxAZjwHzrvx4Y7uJj9irzwIpcQoiu3uUqmsh+dUR2t7tJ3r/jeFsZHUd+J47XPbL8ZUElqiHUOOXlzDT88BmjCqrnDPyMcI3bSo9onwJnoqHIjSV3KBpfonw0h8esK6gk/rJeOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff8eusduYTHK+ZDOwXUpauVCtlGTHEkj4j5ukv6xRXU=;
 b=uHRwRAd48od0OjUj1PBdp1g7xLcICOdazDhOtwECi6fWplXDk9Ehh+WHYOUKNmpXxRVUkd3ihlqbfxIPsuB9PlligS08B0oqtNZ7d/zWH51o0MSw4E6EPMvkxQHhnQTnm3wGK2KWgs/6Z8vqaJzLRFI1J/ykcYJWaPSo6rQHYGJ6+tkKrlsYdyWK6kulRuh2gVNP00OaN9e63jeG6Y9oEIeBDXFEUx1IyzMqcd0uCUUkJDMtBfRCQsgqo2RljWnIPxCqcizeu24X/3cGwC3TWBWNp4J6Gs6IeJXCfm0rIH6CJATPGo5riESW9KW5Wtt1FpPgEhsrlhkdzeLQ5n+OUg==
Received: from CO2PR05CA0104.namprd05.prod.outlook.com (2603:10b6:104:1::30)
 by DM6PR12MB5699.namprd12.prod.outlook.com (2603:10b6:5:35::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 15:34:23 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::de) by CO2PR05CA0104.outlook.office365.com
 (2603:10b6:104:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.10 via Frontend
 Transport; Mon, 28 Feb 2022 15:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 15:34:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 28 Feb
 2022 15:34:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 28 Feb 2022
 07:34:21 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Mon, 28 Feb 2022 07:34:19 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-gpio@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andy.shevchenko@gmail.com>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v2] gpio: tegra186: Add IRQ per bank for Tegra241
Date:   Mon, 28 Feb 2022 21:04:05 +0530
Message-ID: <20220228153405.49981-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fca3b12-96f2-41d4-ee13-08d9facfcbc7
X-MS-TrafficTypeDiagnostic: DM6PR12MB5699:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB5699CB5A4580239EC8AADD8FC0019@DM6PR12MB5699.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fp+yy0dTSoMfCjiqhb3ijpNUATxPmoVt7btdsm+//LC2iwebEWQKgnRqUBM1ir5L3Pmce0GJE5Vr1KsmYG+3YA9B84zccISIfdQhGHK+TRjR07Nj110TqP9p9iKtsIlAP8bRM3+OnkPR2K94HV0uq8OqhA+pVk3a52qNJ8+stnj91isW8rQgNqhG0qQbULwLoktEUf2te1N2HXVn5th928a37iXsOcHHxTYciX1DTtbN9IfeaWPTLkK8xqIARtydCOmT/sn7Gd+KkNM0uAI5YEAk0Vih0pSwKDqz7rIRlHWRXpz9GeNdQ2X/16vPiJ/h+SBU1YagoGagpLZw2s9alpnA/zCYgxpagt4dBDL8cL0Tg+Tvg4X0+zAZrZMYe2az3Spj5X3trWORfOqWSEAIbycotpH0N8w5AekLo1ynmHX1qttUG+ub5NVmmjKbca26wV3xkXWq+mD/Rvwiy8UmwQ8JOFpYepbpZEU358/04c6u4Qiuit+1nwrRDjgA+MKMea5y/wTt9rS7KPeIDi1NR4hZqDALEztWnQhat7sKNZWUZTGp+Yet404rCkUhQKJJl9cHZCAiNkqUL3pDpMU+TBK8E1tr7FBPCYf3TQemDvxkBhYTOT0FdYxxbnEf2inyD18f6BRN2oaOvlz7xU1eFjF7bqLgTtd0hRiDCq8zGvVQ+myT6W+LZ27sCUfP1HiVD9gdfjDiDvljUaFRpXyt0A==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70206006)(82310400004)(7696005)(6666004)(2906002)(36860700001)(5660300002)(83380400001)(86362001)(15650500001)(508600001)(426003)(1076003)(4744005)(8936002)(107886003)(47076005)(8676002)(4326008)(40460700003)(70586007)(186003)(2616005)(26005)(356005)(36756003)(110136005)(336012)(81166007)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 15:34:23.1812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fca3b12-96f2-41d4-ee13-08d9facfcbc7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5699
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the number of interrupts per bank for Tegra241 (Grace) to
fix the probe failure.

Fixes: d1056b771ddb ("gpio: tegra186: Add support for Tegra241")
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
v1->v2: Add 'Fixes' tag in the commit message

 drivers/gpio/gpio-tegra186.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 8d298beffd86..031fe105b58e 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -1075,6 +1075,7 @@ static const struct tegra_gpio_soc tegra241_main_soc = {
 	.ports = tegra241_main_ports,
 	.name = "tegra241-gpio",
 	.instance = 0,
+	.num_irqs_per_bank = 8,
 };
 
 #define TEGRA241_AON_GPIO_PORT(_name, _bank, _port, _pins)	\
@@ -1095,6 +1096,7 @@ static const struct tegra_gpio_soc tegra241_aon_soc = {
 	.ports = tegra241_aon_ports,
 	.name = "tegra241-gpio-aon",
 	.instance = 1,
+	.num_irqs_per_bank = 8,
 };
 
 static const struct of_device_id tegra186_gpio_of_match[] = {
-- 
2.17.1

