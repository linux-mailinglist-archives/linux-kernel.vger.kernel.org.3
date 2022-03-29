Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF3B4EA4DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiC2CBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiC2CBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:01:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06A15F4D6;
        Mon, 28 Mar 2022 19:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAkfkV666HHNadsQaRxWjlbR5Kpndfym1iSsPOMWGDAAU5EAdAOPFajheioLr9e+Hm55WUNCLK4nidMY2fZBVCOLdCeBkMzC9ysKsqB7MqVxQVVDa2qAHq3xcqB5s90ITRwqXWIPAQD4JoeKL60vXTVQBD7oBO9DcqDRwLcPwutsZ9L8/a+qetK9gTBScK/F3Ru/+FDNu3/kDebhciIa9xizJxN5E3drEWyJ1d+taBWn2nsnzcIg5ZU2C297tJtXwZNq30io95/TSFVH/WS0f0vtOcoA7q48PFfflTD9L+qjowAHjGxl5zjpfZm8JcbLQcM4LEblzFAjuxrgcve8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZKx6wPfMRfaf76kByvsdVKI4n7f3Z4Z0doV92WyDcA=;
 b=lNce6NKUOtQYRp/QR+dTX+VrUGTOjo8P9AhKLsXhg85s9Pm83aY0ZFqKbBrVSQbwAcQdx04WWQo5aJMEaac4DwTH/0BcEcoIhLcpS91G80KdPp3d8pDsneTyeWbAwR+V305Hst7fVcsz2/1slHy1bUd+DjLZtnfOR8Ri7B2xLPa6IhOZN+QKVRQFWGNM5IaL1rGhSdzUBRFbJ4A41PzOaL4pCqVpj5ZNOBN+HM3KBESqJS9dmtmokwFmWdf+knD0ECMZC2XJOMzv+e5EiZEiKvkL4sg31wf1s98Bwl9pnp2xvtsMd5j6qnxqSkPBCQ89bM3E271QpQx8fWzW/lY8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZKx6wPfMRfaf76kByvsdVKI4n7f3Z4Z0doV92WyDcA=;
 b=QDAb1doAsrl2QRstR0fD23k8UR05ij5p20sonMB+vBaO5CESjYaHdh6i/N6Dq9mUntXadeR0SKRpwlH9RbXbDEEvCLf0HE6lkfUdXd6SvoXnYFJ13Ljvkb0pGQiN1biCcd+Nr9l+XDiYSVYKv+WKjtn0oSFsIDD8LAGynfyUyj8=
Received: from DS7PR03CA0248.namprd03.prod.outlook.com (2603:10b6:5:3b3::13)
 by CY4PR12MB1672.namprd12.prod.outlook.com (2603:10b6:910:11::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 01:59:59 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::75) by DS7PR03CA0248.outlook.office365.com
 (2603:10b6:5:3b3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Tue, 29 Mar 2022 01:59:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 01:59:58 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 20:59:54 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 1/3] cpufreq: Export acpu_cpufreq_exit for other drivers to call
Date:   Mon, 28 Mar 2022 20:59:45 -0500
Message-ID: <20220329015947.565-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329015947.565-1-mario.limonciello@amd.com>
References: <20220329015947.565-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbb39446-9069-4725-3414-08da1127d432
X-MS-TrafficTypeDiagnostic: CY4PR12MB1672:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1672B061F62E67070605D9B5E21E9@CY4PR12MB1672.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3mI7EdGcsdWc2vADAHQn7IWPNiW8F6lVE7miCDqKrgrNRQlmp2D3ekiUQsJCmiMFce3wElZYUVC4KWHHw+WIiwf6maCw7wB++RcJJdugRX/8vRh8Fcbh6/01y7oD9Id5MGhzpj1TY20cBo5yW30d1M5ji9F0Sq/5dU2vtV1Tzk9pkqAI/zcDaJ+aU/VkPxyJ1ZtK68nhIUle3pTEdc5nWM+XeIAwCNWRIlxZHMPaLI/+B/O04uSfasy5c1ukq8wm5G1z/xUrh+gsY7EoRxqWc5agWSWul8tgZnmT2P804Jht7oizeFYKJTCMa5Trs/BnVj/5AhQFnZwv9d0B2L3mBUDlQOft+ltbzPv7ohyv8nlzc8VIpo+wPST1BW9bZPAmVf4O1i0vwm3Zpa49jfSLYP86I2SfzodtZqD7RBZOKVxotltqUQfWHm25EOYbZsImDw75pZB3WJQFWFQsN+o9nC0ZKei1mbenKC69pCNkirXL8RndWgNoVoq79LcthIWeLM9mVidMCqU+t5d+Cz/gkuKqMaFDvML/PyaBc6945WV44d45Cvp/RzDBoDABY7bxs4qCAcnsi6IyDDQmRqpEtbbhIDJYrhmfoC9sIWVuckEvujc6F7ajW5wS+aOIOWrG1eSriGPsuC6W8v6lb0Ro41aS/6dSN29zvoL4gfCbLqYbdwFrN+wPGm4eAoLuuuuCBL7Smi2K9yKIVTRtKGM6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(8676002)(4326008)(70206006)(6666004)(2616005)(70586007)(7696005)(508600001)(83380400001)(82310400004)(40460700003)(36756003)(86362001)(36860700001)(336012)(426003)(44832011)(8936002)(5660300002)(54906003)(110136005)(16526019)(26005)(316002)(1076003)(186003)(4744005)(356005)(2906002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 01:59:58.6709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb39446-9069-4725-3414-08da1127d432
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1672
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the only way to load an alternative cpufreq driver is to unload
acpi-cpufreq first.

Loosen that restriction to allow other kernel modules to unregister a
registered driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Export symbol instead of changing internals

 drivers/cpufreq/acpi-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 3d514b82d055..92ac978c1c53 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -1033,7 +1033,7 @@ static int __init acpi_cpufreq_init(void)
 	return ret;
 }
 
-static void __exit acpi_cpufreq_exit(void)
+void __exit acpi_cpufreq_exit(void)
 {
 	pr_debug("%s\n", __func__);
 
@@ -1043,6 +1043,7 @@ static void __exit acpi_cpufreq_exit(void)
 
 	free_acpi_perf_data();
 }
+EXPORT_SYMBOL_GPL(acpi_cpufreq_exit);
 
 module_param(acpi_pstate_strict, uint, 0644);
 MODULE_PARM_DESC(acpi_pstate_strict,
-- 
2.34.1

