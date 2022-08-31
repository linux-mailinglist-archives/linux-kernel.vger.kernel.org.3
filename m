Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA8D5A78BC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiHaIRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiHaIQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:16:58 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A23AC59EA;
        Wed, 31 Aug 2022 01:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqKowGid0VCHW2HI06KFe5KIiWOuJeIQIT5jsE7XWw3M9wMwJcaeE/olyYmcZCKqDe2x9DsAHUN8cOxlnUjgA74NDBzwaQDQgfifNTwlZYxf8UgM6Bw3CydaHphoXGdkEyXUQD6AEqB17v5oNGSarJ822f8b58f4m2QJbtTPekBLnss5Pg42z0sDkQoGST+tmSQM3QMZLyer9pHr4SuOFzAr+8fhO7B80xURsQV91JTNFTMU9o9yn2d70+BfMxihJT7O8LolZnIGOOX5Za6UJaAMGfGf8VapI+cNJqlpCpmGBYHAjWovtOi3HX+Gk4WqefH/2EQKStRqwm5WFi3ggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ej+pItJOBPaWy64t4W0XWbAdeK8lWkJUJ44Rq1Ur+vo=;
 b=kHfQLEe8zjagZ+GMqDc9q+CFONOCZlLlwC4exOOEAHezu2sdInt7bM61Wb0tevVS21qypm/kaaU56ZdRLjbiuQgnCE+bcDd03arX4yZw+zRhL0MVsvP7kWTHXdp246Ro6YAboFiqaugAd3Y3ZnCo5yno9/R5mBgev8MK8YZ2OcuWrU/tX//JxJYv9sGoL5swA93PECRx2pGpJqTHmx/1gpeJTrKfnV7FE2VafHs4odhqcKrQ/8ReOU6N1J+8v2tp4xWswcLMGgJR8MEvytlJPepfb/kRZiw0SsMLmn+YKVwgKOxt3Xb2ZZl2R1zwXeeKIsqEGOI7+1fF5HkAJa5jmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej+pItJOBPaWy64t4W0XWbAdeK8lWkJUJ44Rq1Ur+vo=;
 b=YZuAl+5iC15Q4wfp68ZH8Z1xwjug57yBldkX25GSTGaz4M5cqXjHaV3IID0v4Eq1D7jhu3BGXPNK0ZNBurrEj641mfnAVu6NQsH5yBjbOx/2+Xwvp3ACsrqUY4/jbrEw3arLhv6J52JySSRnm/CBtQOtDUzTzhJ/au/oI0IUoXc=
Received: from MW4PR03CA0279.namprd03.prod.outlook.com (2603:10b6:303:b5::14)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 08:16:48 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::78) by MW4PR03CA0279.outlook.office365.com
 (2603:10b6:303:b5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 08:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:16:47 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:16:41 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>
Subject: [PATCH 02/15] cxl/core: Check physical address before mapping it in devm_cxl_iomap_block()
Date:   Wed, 31 Aug 2022 10:15:50 +0200
Message-ID: <20220831081603.3415-3-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220831081603.3415-1-rrichter@amd.com>
References: <20220831081603.3415-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a524fb3-f5cf-429e-bada-08da8b29264b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4266:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FOBIN3QzXOpL+o11i7RHsCyH3xqLnq+makXie2cluk0Oev4fvU9sf7FbJEjVZ0neWFa93s/EitWPfmssYi5nja4Oq9grd9cpSh5EfmMfR3oZ/T9qYZA5PPWuaVY5PlCpOROQ5/OF+fDX9lg85VYvvfNPHs1G962VVAezxlaMdcRrs3/ziIXSkJUR05PH+m3kdQNEbxzrMWa2UhqFkgUf+KOZr63h6epST2ht8IN3Cy2wCF/9xP0J3AxCEv5334zohlixY2EdJsL70rcx7YyazdjHT4qlVdU6wpGYGN0opgLs3ogBWdFr5vmBowOhXFhGyY3q4S8zokpTBlo0cicJTKtAuxKaZLn+ps/BtuZHx9TSdfojAFZf1xlsShSCehRFZNO7oFrNCXkmXPbFCNt8iDapTo+8Ede0kJQt8dJWl3TjVTQrLNpC8mYys4ySA2nfthLhN0Kg1MvRYp5qqtAPFEIraVdoV8mfi2lReDWkka15rfdFI0n7q9cfrPWqwOXXT8UHnvk3U7/T3tx6I9aLjkwMGoRLetidet5x3kqquJ8wWUcXpKUaPmXzh6ACMCyUmeircQpPuDG5B9uMvnzQr+S9iKB8NF6hwlde8jcMmrqkfbXWsNV4Cw1KBl1xklA5Ql4VWN6roMV7+9W8BS64GPFlD4Y4oz83f/Jg42LIp5Zb+jo8LTzv/YgMXiZrt6CKF+tPMJaU7ozCP70L89qmeXTLp7IHpKwlyCH5J6iUVLFK1h1IvFDx3tULewz+JuZ1vw7x1pY5K5eqMwE7oOPAkQYvqwx4kv4v3wikB03ByE9WkRLwU/6/MYsLdeYPIvnq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(376002)(136003)(46966006)(40470700004)(36840700001)(2906002)(82740400003)(82310400005)(6666004)(2616005)(426003)(47076005)(26005)(83380400001)(16526019)(36860700001)(40480700001)(336012)(110136005)(8676002)(70586007)(40460700003)(4326008)(70206006)(54906003)(4744005)(186003)(81166007)(316002)(1076003)(41300700001)(7416002)(356005)(8936002)(478600001)(36756003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:16:47.6888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a524fb3-f5cf-429e-bada-08da8b29264b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The physical base address of a CXL range can be invalid and is then
set to CXL_RESOURCE_NONE. Early check this case before mapping a
memory block in devm_cxl_iomap_block().

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/regs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 39a129c57d40..f216c017a474 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -165,6 +165,9 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 	void __iomem *ret_val;
 	struct resource *res;
 
+	if (addr == CXL_RESOURCE_NONE)
+		return NULL;
+
 	res = devm_request_mem_region(dev, addr, length, dev_name(dev));
 	if (!res) {
 		resource_size_t end = addr + length - 1;
-- 
2.30.2

