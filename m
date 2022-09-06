Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EA65AE4EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbiIFKAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239151AbiIFKAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:00:10 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2139.outbound.protection.outlook.com [40.107.21.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DE132B95;
        Tue,  6 Sep 2022 03:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5PehMOdQj+foSE+xevE4zyPudJZr1TwGKmgNr8dzNG+Otj6zXIb/aw5zRZtqdLzuMVnd8Cc58hbF6b3NzQczWsWky/2cD0b8N0h0q6ob2pG/4A93OKvndZs0nAWN7Is7tP7truL9992K0+LY4aAZeTHEnbKvG2uCOlZNt+jtd1C6FH93+o8htsaopgweuU3WvUkSe4Hy5Wrcu+P0kiDC2xSwB8EG8bD9uWBpF2nHNG3/qIu07PUp7wcpwb2LsNaBYHAekFCIisYRItLL1kJvGFfBtEwz30tNO87AfcjA/0W9cI2HXrKU+y/GVjOioQ8eHibchF2A+MmGMccNuSLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJJAWXk1x1T7abYFWJ1icyFH9PvVfUGdq0h+dCR1jpc=;
 b=kRvduEvesbPs2SRGx7Duq1PYVbs1JFP90gYtxtDdpQDZlECznexQ0soV1vw4bREFhk/kPkHq1TzpCfSxs8ZbZBnA2rrc3JMdOi9bH918f6eqFI2N1Nivb+YncMHkcjvvSlKzeijiMi6VQd17lmZcxINx3eg9nG/q+Pn3AYhabj6+xoS9rdaGdwMu5lLdp9Cg+1sjqTXh8MAQBBnDkJC3LQKXtfFZbM+eT8+VqW+1HdU92tlGTGy/5lFBLbbdXCDaX/lnmSoyYG51SXeyqes76k0KWl4kRTGceC2ZmUm5LLLAMgL4zYybGKUkgXNxp2j8neFFnEz7IiQEPgfo+n4gOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJJAWXk1x1T7abYFWJ1icyFH9PvVfUGdq0h+dCR1jpc=;
 b=tKSvOgPW+AK9IFcakLXvWpCdBdAJnvFU8pJ9yBcKhFn2l+Y7welcgbzwaf7Zj3DFsH7pA6jXTUQ0Xk2WKEYE5gNF6cWfoRzTqKEGI+yz8HjP3ABh873yhUXhgw8TXNWMdHcS1K5Z+7TTD4wytZwe6gnCIxNVwZQ+goLbJjeNxdY=
Received: from FR3P281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1d::6) by
 AM5PR0701MB2755.eurprd07.prod.outlook.com (2603:10a6:203:77::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 10:00:03 +0000
Received: from VE1EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:1d:cafe::49) by FR3P281CA0007.outlook.office365.com
 (2603:10a6:d10:1d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Tue, 6 Sep 2022 10:00:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 VE1EUR03FT038.mail.protection.outlook.com (10.152.19.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Tue, 6 Sep 2022 10:00:03 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 2869xo1t000637;
        Tue, 6 Sep 2022 10:00:02 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-mips@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mips: Select SPARSEMEM_EXTREME for CAVIUM_OCTEON_SOC
Date:   Tue,  6 Sep 2022 11:59:42 +0200
Message-Id: <20220906095943.60296-2-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20220906095943.60296-1-alexander.sverdlin@nokia.com>
References: <20220906095943.60296-1-alexander.sverdlin@nokia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 22717365-5ce2-4d7d-36d0-08da8fee91c8
X-MS-TrafficTypeDiagnostic: AM5PR0701MB2755:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9yQFhr1IHsaeisEQcfes9nWGoCou0uXf5iZE4T4FxzA9lgD0TQnGCnxPnla5gZYsEmh8MjVZDvi/acQ6xtD3EWMlHBBysWsQBUVd20zlPNSqwHGG2/WmRJtjtmu6j3Wz5pzbkper6nDOuWlM5gFEmitFGo5G3dJZzV8T7gfZeIwLRUMzqEYl/SISeBYbXVbuaWA9M1IOPoV10DlJkSHnlftzfbnpJ6qWAmNG7sZXQrYUpu6t6D1MimfMyo2TYji43inWibfSydKWnn54AHClK/YihHiKgYq9SPBM/fZpCM16GjMLdAJJTUtsch1PMbEBp/AbMleu63T7mw0srdsxn21PGZ95sasISu4i+HEU2e7G9R+2vkDDjuc5zLozrGD35BCtuy9c8FBSvKNU82wHs3ofofeXJV8Y+6xE08AmQo6LB4kNiS19E2UzwtNCO2SwL9ThucSXt3+Qu672hzFcEl85SqSpVMCr1i/i51NLkOIA1+FlZ/jvHeSSOEW0TiOiFKIiSp45vIe+Px2kpTSYd0spYR8F52Qt6HPJcCLcS8mrFsjeIlRC0HqiPz1YF79U6OkXgZ/SltpB/cQ6BvkB6HqpJZU7hTTVsrSnw2FrjosDkVUjEfwJNcsE6t0vIqX6ZTGltlwoUpzJWtU61uOgZ4aSbiIqgp3JGg0r+dBKhp/ygoLPGtL6jN/sVct0Ta02sWi54SpDAvFTGxVC4DyjkJFwKpY6UCkSF5+Whzp1PsPYe0f4nT5v83jqDLe8V6kB+BVheFwNFnmmnWAlYuf60jZ1vE2JKLDkZO0xsIuGAks=
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(396003)(36840700001)(46966006)(40470700004)(8676002)(4326008)(70586007)(316002)(70206006)(82960400001)(356005)(86362001)(81166007)(36756003)(82740400003)(36860700001)(478600001)(47076005)(186003)(83380400001)(26005)(6666004)(41300700001)(40460700003)(82310400005)(40480700001)(54906003)(6916009)(2616005)(336012)(1076003)(8936002)(4744005)(5660300002)(2906002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0701MB2755
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

Commit c46173183657 ("MIPS: Add NUMA support for Loongson-3") has increased
.bss size of the Octeon kernel from 16k to 16M. Providing the conditions
for SPARSEMEM_EXTREME avoids the waste of memory.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ec21f89..79cfa1c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2669,7 +2669,7 @@ config ARCH_FLATMEM_ENABLE
 
 config ARCH_SPARSEMEM_ENABLE
 	bool
-	select SPARSEMEM_STATIC if !SGI_IP27
+	select SPARSEMEM_STATIC if MACH_LOONGSON64
 
 config NUMA
 	bool "NUMA Support"
-- 
2.10.2

