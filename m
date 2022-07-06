Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21999568F34
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiGFQbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiGFQbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:31:47 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2108.outbound.protection.outlook.com [40.107.20.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF1E275DC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 09:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcR9ZVIPytoHHicKZFBbKehkjBT1IQeQg+kM0VEo4ad5SqmFomraWBizqa6N374CLuN0ny0jyUcjcW4iO45nnwZXY46yf1WfxyyXjZXt7P40cvn3mevSdC7N3Ys7PnUuqcI1AOBR13b3KeNUMJ5p+nkfI5tTeCkjCZOSChfXgsVjsK8CLhsUJYmqc9e55qAjwAZnoKsdSpER/2f0thHn7yCyJoPRTzPkPXen5fTsx6LkoiXsJR3gLc/S0X7CeCvjA24uU9wouFP6j5GkXXFFO+Kpeb/tk0AdZ5QwtTIBJXiYoFTKS97I4EhOnqyzJoRixucoZcvD9qAO4qw7aXN3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORy0rKBHiml0eFJ9guRmvuCweZ8Vt6uYTRbhIIqLJGg=;
 b=H/njlGYOMF/qzBHMLgVi++Ry6lMH7cHYrwqkgi+NDkv83b9L48zR7qTGlg0eLE3A2Dj+qYX91unHF1lx6sL5YE8iLYY3iW0Yse17U8L4K2grcCi+CCyIC9/iB8HhTomnaqWYhln6WnQQuR5dH2USxosmJFURFfwK2R8QH01y0LSTtsl2k8PGeVLDzAYh/eeu+kQHbV0VPNkZWrE9Y3kuhQdMNtgi47gZwpclnI/sEN4HzWDdkHnpJhzj7khd2BYCc+7gdrHsDR/jSFJpiwWV3Heu9PSq8UH5WpqR9op44jaEelDF1h9i9Pn+mNj63UhxtTEvufNU6+Y2eZo9D/DBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORy0rKBHiml0eFJ9guRmvuCweZ8Vt6uYTRbhIIqLJGg=;
 b=l1bXWjGegMuLUbFh6V27BI0EMbOj+MarfPWAPXXei/cXAiXQXHIZgFwz1L48F8kWouKhqs7GUvJVeQjUxfSWZJuedeu+Ekow5ZlZ5WnPeYUJMhbOPnmVk5Z2HzyQKJM3FHBeu+mv/OIefMNHEVC/RtFuNRKu5eUcRCcKz+96NH8=
Received: from AM7PR02CA0006.eurprd02.prod.outlook.com (2603:10a6:20b:100::16)
 by DB7PR07MB5864.eurprd07.prod.outlook.com (2603:10a6:10:5a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 6 Jul
 2022 16:31:43 +0000
Received: from AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:100:cafe::22) by AM7PR02CA0006.outlook.office365.com
 (2603:10a6:20b:100::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Wed, 6 Jul 2022 16:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 AM5EUR03FT005.mail.protection.outlook.com (10.152.16.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 16:31:43 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 266GVet0030828;
        Wed, 6 Jul 2022 16:31:40 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        florian.fainelli@broadcom.com,
        Kursad Oney <kursad.oney@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: module: Teach unwinder about PLTs
Date:   Wed,  6 Jul 2022 18:31:35 +0200
Message-Id: <20220706163135.53874-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 19b87037-9634-40d0-803b-08da5f6d0312
X-MS-TrafficTypeDiagnostic: DB7PR07MB5864:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wh4vYHxK8MomwPTtkwCQqRJSMt7L4LgUbQEptKoCyfcJ2+20Rll4eqnzIa2Rd6zRmfaosOlB26rF1ZkZb1Vu6AVZ6jajm1fUW98C0biXmuKtC12dRm05jMmzNTdETkpjz3i97yq1eKwMQnCUnNXOyHkfCWLMOmrcRiplIc5yHMoKC6fIbMiZf8/gn7rMyXH58ciST0opl6sTH2gkxRxgedyBY5120oj2mb3wC+gK9590JZtZ6VvTxNV2GpSwW9LDPVaogkt6IQ6iNidqUbsZeb1kHl1iutdQIzmOkInX5jYI63H6R4V9Uuipc65H4QtZ8qJVaWPoi3CGfkUhEio+KkfXKszjSzGRVFoBkS97EfEfHP2R6B2wP3Ekd/a0E1db1MXw3fptOPBPcDE1kp0HqieNZYyDWSlCF35hhjjGEYJOZ19OSJSNRqq6nsMMX9s+p/xHd+zTLQwWZcgks7s/Xvj/ivwl0faRMX2uxvb/1QVGX54tFuWCFFpURKZsZxTdQQRxBkJjankwviP8xBP1OZs75hIfjZwoQGe8BeYA3awsmLT0v1c0HJ5+adRrQDY8WeEbL9j4ZfkhTVVnJ33a3R/7L2dsqxsHY9PuyrkiQfCsHqmuAQTQDF5QmFN7lwzImneessP8zNJW+wF0Sunr9poTOQkopj2LW1d7/NHDqeeO+aBMwm3vRZdYNgKD/aF9grLwFaI4xsTo2pUHtIVjcxV8GVQBg8Q4w/TMUoc+skyyncENgvDycTd8VeR20N5TnpOhHuzfZ5Dc/cgQa1ON6NUfPLgGALf4X6V/Q4T5YV1P0gLfNh76f5yDqIUGv560NMgalIXwQze/CLbpbEVh/E20hKa7TqlQ0J9oVd48Xe5j4Y3HUzihOGL4hJKYvD2+ltva0zn0BMftwcb4FD9myWwvUgNXKXNUX9W3pQ/A+v0=
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(40470700004)(36840700001)(46966006)(8936002)(26005)(8676002)(70206006)(70586007)(2616005)(4326008)(478600001)(40460700003)(54906003)(86362001)(6916009)(5660300002)(186003)(6666004)(41300700001)(316002)(40480700001)(36860700001)(34020700004)(336012)(966005)(47076005)(83380400001)(356005)(82960400001)(81166007)(82740400003)(82310400005)(1076003)(36756003)(2906002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 16:31:43.3339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b87037-9634-40d0-803b-08da5f6d0312
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB5864
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

"unwind: Index not found eef26358" warnings keep popping up on
CONFIG_ARM_MODULE_PLTS-enabled systems if the PC points to a PLT veneer.
Teach the unwinder how to deal with them, taking into account they don't
change state of the stack or register file except loading PC.

Tested-by: Kursad Oney <kursad.oney@broadcom.com>
Link: https://lore.kernel.org/linux-arm-kernel/20200402153845.30985-1-kursad.oney@broadcom.com/
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/include/asm/module.h |  5 +++++
 arch/arm/kernel/module-plts.c | 14 ++++++++++++++
 arch/arm/kernel/unwind.c      | 13 ++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 5546c9751478c..07c51a34f77d5 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -37,6 +37,11 @@ struct mod_arch_specific {
 
 struct module;
 u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val);
+#ifdef CONFIG_ARM_MODULE_PLTS
+bool in_module_plt(unsigned long loc);
+#else
+static inline bool in_module_plt(unsigned long loc) { return false; }
+#endif
 
 #ifdef CONFIG_THUMB2_KERNEL
 #define HAVE_ARCH_KALLSYMS_SYMBOL_VALUE
diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index 1fc309b41f944..af7c322ebed68 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -284,3 +284,17 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		 mod->arch.core.plt->sh_size, mod->arch.init.plt->sh_size);
 	return 0;
 }
+
+bool in_module_plt(unsigned long loc)
+{
+	struct module *mod;
+	bool ret;
+
+	preempt_disable();
+	mod = __module_text_address(loc);
+	ret = mod && (loc - (u32)mod->arch.core.plt_ent < mod->arch.core.plt_count * PLT_ENT_SIZE ||
+		      loc - (u32)mod->arch.init.plt_ent < mod->arch.init.plt_count * PLT_ENT_SIZE);
+	preempt_enable();
+
+	return ret;
+}
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index a37ea6c772cd5..53be7ea6181b3 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/module.h>
 
 #include <asm/stacktrace.h>
 #include <asm/traps.h>
@@ -395,8 +396,18 @@ int unwind_frame(struct stackframe *frame)
 
 	idx = unwind_find_idx(frame->pc);
 	if (!idx) {
-		if (frame->pc && kernel_text_address(frame->pc))
+		if (frame->pc && kernel_text_address(frame->pc)) {
+			if (in_module_plt(frame->pc) && frame->pc != frame->lr) {
+				/*
+				 * Quoting Ard: Veneers only set PC using a
+				 * PC+immediate LDR, and so they don't affect
+				 * the state of the stack or the register file
+				 */
+				frame->pc = frame->lr;
+				return URC_OK;
+			}
 			pr_warn("unwind: Index not found %08lx\n", frame->pc);
+		}
 		return -URC_FAILURE;
 	}
 
-- 
2.35.1

