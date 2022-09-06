Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE80A5AE4EF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbiIFKAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239293AbiIFKAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:00:12 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2118.outbound.protection.outlook.com [40.107.22.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855786F577;
        Tue,  6 Sep 2022 03:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rrk1YbMWP7djUdNYzauuZoXFyB6KPDKHrxJc1xcq3lZUU81xmpUQIY7znC7Og9/hU+sIkjEIzONbvAtlBO9PJ0NPFP3G7qYTunjzd/HCbt16BmYeqQ3AQiapZPlgF0bFYWXw3O0UxNAxPQXX3Ax0ILwZUa+z0nnwxjnOMB7ghpAZyBGumPoBuy2i1qEpKIqGAzPsAW0LBYP+/8ehbi1vlNhTpKkcTSRB93+ROi6/AnEurwto/CwE5jVDo1la/CTD+D9l20kSVU46x0wDHrYWCDBlFUoZf/+fva/qxevrgKuDJdWssE9isDMzELhDxt0wTZpEJ8nj7UVBlcjkWn2jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siILthPCZV4eQZTy3fTdzvlg3xwLeZZkKfDceVYYys0=;
 b=BkQhkWgDQfjTv1kHQZOkrnhF06necD7pd2B8FYc+MuSHmFyPwuAiJFAOOaJYWmBrqmQO2UH2LKg2RyXW+zj8iE1zKrv9vNDYyy56IeHyyfikPqabwEgP94eFb8Xcq7Sc7eYSkTPDnxCH8Qxc1hNw/CNRiDrsOEEvSaKl4cOQkr86GzGQCcxtL7wpktdoKDJT8iKlbDN5lgLKD6GK69P9Q6/cIZrWGUg5GcXgNuibHVcuHga1K6oU+PSJPx0ecPIvrlR28x3x+qy5WpDAOMS5ZePv/N9axinl/C/O+I5SXfaLF2Es4ajw03WZkIItE/9BNwAPVDRr4s40zmKMdCYRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siILthPCZV4eQZTy3fTdzvlg3xwLeZZkKfDceVYYys0=;
 b=KLihXTebEK+VetBo8XFQsW/Z1TZopmr1WqLze8ySNrrjr6s97wwuBOWIsymk47xdlsvTGNouqyVNQL1smwBabAPTokniXEEY8GNXGXU2QQ4pRr2KF2Ut7MI0wprsBrtHeFmfjy0K2LcmPjjNioddI0zPnJmzLNfDiXLn5B0sNAU=
Received: from AS9PR06CA0758.eurprd06.prod.outlook.com (2603:10a6:20b:484::14)
 by VI1PR0701MB2733.eurprd07.prod.outlook.com (2603:10a6:801:7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 10:00:08 +0000
Received: from VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:484:cafe::20) by AS9PR06CA0758.outlook.office365.com
 (2603:10a6:20b:484::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12 via Frontend
 Transport; Tue, 6 Sep 2022 10:00:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 VE1EUR03FT050.mail.protection.outlook.com (10.152.19.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Tue, 6 Sep 2022 10:00:08 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 2869xo1u000637;
        Tue, 6 Sep 2022 10:00:05 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-mips@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: OCTEON: irq: Fix octeon_irq_force_ciu_mapping()
Date:   Tue,  6 Sep 2022 11:59:43 +0200
Message-Id: <20220906095943.60296-3-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20220906095943.60296-1-alexander.sverdlin@nokia.com>
References: <20220906095943.60296-1-alexander.sverdlin@nokia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 25abee05-a95b-4767-f6d4-08da8fee9463
X-MS-TrafficTypeDiagnostic: VI1PR0701MB2733:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJe4apyZ+UNaDLHsgla/4YP/q5lRpRnS0dNN3sM5zggaZ5HlE0Y6H4G6nmUpSiDJXFTWqFFUwOIyPjwyJ4VXnUUArcjU8BnRlC11wdnw3aFSSIhFPaXwIlKBbqwFC5r0FDerevSbHf9Gazvp/0u8V+ZVNeDb9w0WtMeVuNwKpA3GATa3Su/nWxF4ssPz8HUzOQRFuLORk8SOI/yTaFSAM2mnZv2xRwULKhIynXgK9AHrMiGQgnGIuap0vGhLIZJUrewcavPTTAa9R3FJWt9Mrg6ZnYBbKlB6xu0Ezvv0+ksYlns8DsoiCTBl2Ir0+NDoai8buMROIxcUpxQ62ljPuzZRqk/av275t9JmU4LeGdO34GCSuMUfxl41e2wR+1Pw3XqYPQxsd1nxQFb3cnCqmxrCx9GmmyDgCephm0Z5CpM2K+eudOxrdX9kkCcpffkRnAfPF5zy+SYMCpnjGIb1ziPvUSWGfvMy5qRyKasZDqydDOGfqWw9/Je5E80cVtR6Itpy0odcUxfzsHeMuvp7tzYf2J15JllrFhwj5P72oMiQQNwYepuvCSH+CG9m+zYSQbzluRLeveKXGBnF/pu6wZTgyGlfmued64UHR6IqG3bdJUa2rYu2+VyldjJVbppo1a3lo6c0oAtmjqb9wgukN3gamcqzRaJY7RN841r9aUkOhEYkmwQXQpatr8Qy+UY72mwv7PAU6t0fb3XYkNacpz9bL2QoXGkIgD8dXYeiRuZwOjAbsmpCSuGwNiZAsOLEJGVMBDHVDo73bYcoyelJgduRqoglK2tit5LTyVLHiBESrAiF/2Kkqxa+OkV9xBDl
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(36840700001)(46966006)(40470700004)(1076003)(186003)(2616005)(8936002)(83380400001)(40480700001)(54906003)(2906002)(5660300002)(26005)(6666004)(86362001)(36756003)(47076005)(336012)(478600001)(41300700001)(356005)(82960400001)(81166007)(4326008)(70206006)(8676002)(70586007)(82310400005)(316002)(6916009)(45080400002)(82740400003)(36860700001)(40460700003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB2733
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

For irq_domain_associate() to work the virq descriptor has to be
pre-allocated in advance. Otherwise the following happens:

WARNING: CPU: 0 PID: 0 at .../kernel/irq/irqdomain.c:527 irq_domain_associate+0x298/0x2e8
error: virq128 is not allocated
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.78-... #1
        ...
Call Trace:
[<ffffffff801344c4>] show_stack+0x9c/0x130
[<ffffffff80769550>] dump_stack+0x90/0xd0
[<ffffffff801576d0>] __warn+0x118/0x130
[<ffffffff80157734>] warn_slowpath_fmt+0x4c/0x70
[<ffffffff801b83c0>] irq_domain_associate+0x298/0x2e8
[<ffffffff80a43bb8>] octeon_irq_init_ciu+0x4c8/0x53c
[<ffffffff80a76cbc>] of_irq_init+0x1e0/0x388
[<ffffffff80a452cc>] init_IRQ+0x4c/0xf4
[<ffffffff80a3cc00>] start_kernel+0x404/0x698

Use irq_alloc_desc_at() to avoid the above problem.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/mips/cavium-octeon/octeon-irq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 9cb9ed4..fd8043f 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -127,6 +127,16 @@ static void octeon_irq_free_cd(struct irq_domain *d, unsigned int irq)
 static int octeon_irq_force_ciu_mapping(struct irq_domain *domain,
 					int irq, int line, int bit)
 {
+	struct device_node *of_node;
+	int ret;
+
+	of_node = irq_domain_get_of_node(domain);
+	if (!of_node)
+		return -EINVAL;
+	ret = irq_alloc_desc_at(irq, of_node_to_nid(of_node));
+	if (ret < 0)
+		return ret;
+
 	return irq_domain_associate(domain, irq, line << 6 | bit);
 }
 
-- 
2.10.2

