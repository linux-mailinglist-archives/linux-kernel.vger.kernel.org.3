Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA2D532F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbiEXRFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbiEXRFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:05:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC197983D;
        Tue, 24 May 2022 10:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Al4KdHw4U9I2K1YQ6XYLFLPiueAYqwzn2Z8NwyksjtfpAioAdfyWIzN5TXgS/HZ7Bz1BJ+Ia4bp48Y7t6mE2zz507Vt7dS/gfTmcNEkMfAYRpy7a7XLClMVwqYlKDbBfJJrl82pehRokW84ai1awUv32+wIwwEtKSYXLEWY4F+RWK+mw9gdS5j6sZinhR4FLI3Fo770JoIBefAIj8vSzZpNWrd/6yDUFBKatWxYWRLBdExhaIAloJilW7eymRb/Z2wVWx1myhTmskG1gq3sl66EtNMeEi/L4vJRZh0v2pG5cz9Fgjr6Ws8vAOXmo5Ym4wwpqghRh7G0fIRNLICe21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKlaon0w9WJiUFAvv4xgquJqPEvrmdkURbVT1zaLDOo=;
 b=gcwypWQqEP6qOtGgskVhlAegG9ivxQDZn638T8YjE/B4l4HrUfSpiz62y0IXMr94EUdrCRdy/xzukPrFqhwBeSmbv11Zm7sZ5MoHe+8CELSkiDYKBtFzIMeMAuXxrWYUfb9G+xk9CVCDDOxXBQbpn/rbOu9746f4QITYjnbJ9iH9i3KrUbdPJp+haJaKBRKId06OQ+nTwx0DaoS0SzmdrVXdSULaGmBZo4SwNxF467FkFX/Dn5ZhxbxLJR9xgQ20smtpIGcsvltnwyzwIzvSIfzaLru3gMc8xq9UCaYjCuIGR0dP4uV7f5WSDxRIk9mKPRxw7aze8xi2X0wEnt01ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKlaon0w9WJiUFAvv4xgquJqPEvrmdkURbVT1zaLDOo=;
 b=ZPl9HrLg4yBUuh0/zPp+ymtFuwqpmAI86zDlXpAM5I7V0kgInpNVWc1waDUHUSYvB+3f/uArXM3tIlCYCnuGeNwe7pHQW2LtgY3EqfnQWs+Lln0drGFejMcMZBNbyDqWucxxv3ufArvoj/3qC+K8tB3djrWS7mzoG3hTmI1H2Jg=
Received: from BN0PR04CA0093.namprd04.prod.outlook.com (2603:10b6:408:ec::8)
 by SN1PR12MB2367.namprd12.prod.outlook.com (2603:10b6:802:26::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Tue, 24 May
 2022 17:05:17 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::a1) by BN0PR04CA0093.outlook.office365.com
 (2603:10b6:408:ec::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.21 via Frontend
 Transport; Tue, 24 May 2022 17:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 17:05:17 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 12:05:14 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/3] ahci: Document the loss of hotplug by new LPM policy
Date:   Tue, 24 May 2022 12:05:08 -0500
Message-ID: <20220524170508.563-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524170508.563-1-mario.limonciello@amd.com>
References: <20220524170508.563-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ea70655-8d65-4178-21cf-08da3da793cf
X-MS-TrafficTypeDiagnostic: SN1PR12MB2367:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2367D614577BD3793EB33EC6E2D79@SN1PR12MB2367.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwVCN3CgnhoO8nXvFphBDOwW1zj8RJNeM0LQxYYos/BWlL6wcjW/Vm5FB5Cxk1HzdbVe2oVQbi35bup9GlQhl/R31MCjcbIvEvcj2g2UZddhtgapDIt5mn+niBy71+SXUjSxQZz6/PAVW4xKePsiuZF05erGv/XgE25q0Yu78PrDzXN5Ne4cCSkpWzOKvHXWVLV19hjb4qboGo+nbNH+3TQ7eUrZp6kfcbgU4Sr1vRAFOf8NGgxCGSShNoRlrPfSb+p2xD7QwGXqdxwcEymkDTNk7dY+ywbkQtY3SsWIDqcUxnFPdBMzS0WlVq7monrEWCXKGWjr6dH3IU5qja7Eqs0UdcCWOSDda7tCrBtZrIDVdLhHzm2sAZB9I621lIJhpiCHJ6qvvQ5jtPcWE6w+dFsXHjBC7g6DiTQPZKbgHsdXXiNhjQPpij6kDS1ZrbpxMzAR53jLTxE/Gdc1HLxE6b8ALLDQGot1mtWl0gTKjUhN2B3tqG/1VHglNBSdhdcyDSv/JzyK925BlrtbQiBZ1qlJaO49Gdv0Hya4FaCC/SWjJ5jles+RjthAob0wrNeWs0QHzKh5cMTyaVF1WtBlIsazXR5uKQ8s8xUmt9Luc7pPEhNadJZxuYVYKgJY27DKmOGJZ49EI0lhLJW1W5+JAu/dGRP+cs/goP7zwNSdlR4UNj629VQhTVi2/F2VXZVThv/OV5fYWZJiejqp0qfbA513F573u/Fhe7yK0IdWgbdxTf13SXd3qiBkZx/d+YSRYibsEQmBY+7BYPcQo87E90H7LUUmineMDSKIcXi9kjKk1zlLk6H5fgfa6P+f3guL8ACa81y5OOR0eczn4YE3Gw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(86362001)(186003)(426003)(70206006)(5660300002)(47076005)(2616005)(966005)(54906003)(7696005)(26005)(6666004)(1076003)(36756003)(508600001)(82310400005)(36860700001)(70586007)(336012)(16526019)(2906002)(8676002)(316002)(4326008)(6916009)(81166007)(8936002)(44832011)(83380400001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 17:05:17.4223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea70655-8d65-4178-21cf-08da3da793cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per AHCI spec v1.3.1, "7.3 Native Hot Plug Support", once LPM is
enabled hotplug support needs to be disabled.

The LPM code always followed this and disabled the port when no
drives were connected, but as more machines will be exposed to
this code it might be an unexpected behavior to some users.

Add a note to parameter documentation to explain the new behavior.

Link: https://bugs.launchpad.net/bugs/1971576
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e6bd212004d..4dcd9a3ba4a5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -279,6 +279,13 @@
 			3 => Medium power with Device Initiated PM enabled
 			4 => Minimum power
 
+			NOTE: Enabling LPM when no drive is connected will disable
+			the port which means hotplug will not work.
+
+			If hotplug is an important use case, this can be modified
+			at runtime by changing
+			/sys/module/ahci/parameters/lpm_policy
+
 	ALSA		[HW,ALSA]
 			See Documentation/sound/alsa-configuration.rst
 
-- 
2.34.1

