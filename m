Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9F34BA96C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245059AbiBQTPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:15:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245035AbiBQTPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:15:00 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2074.outbound.protection.outlook.com [40.107.96.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA349025A;
        Thu, 17 Feb 2022 11:14:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZB6JnkT5RvdxaMWuu+RsAAvetMe/KqwSaJY+le8Pe+VAIql+8jQSzN+O9Cq3tooUwNilEFNqSi69YYM+nW+/efgKIwJx6SqALeD1mlHeOAAGOH85XEWwOqMJFsw+ThIklRrEIZ+qSn48r1k1c7+nl/3x9/5tBRwMXaU48G1eKaWRCnFTsvqZJ2eFq0S7WSgny3ezwv6cyBz9OTT+OtDYk5rGYPclcgseHYajAYb9hVmcfakaCWEPiJDVp+BpRhS3GtmoXSUmkYZh9CJQY7GtbhDmauoHHW+9t/b2W6ghlbvKHHXxdyThKEWmU3P6Z7YCooxPq6Vt+4xmZ9KsQfoglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKtS+m2X/zvvqkzobqHAxRy6RQYhGRx+qxgr6ASLPqc=;
 b=E2FAmZGQfl09lMxzfeCMUCEHgtzaQ72FG4MIftITgtt1PlK77yOjOHfSvkoQef5BNVybrycIOq4hdtNzUkV9hSULP63iYaBBiynL2+hodPjbt3x1rxQhIhht4O0RpCT/KPlEWPmEcyVtw2UANXk16QHG2oWD4Z8XdgfEF3CLUnu4o0FTUYEsQ8TOfmkFHfAPp+gIQgnq+HAB9qjIWg7QjSgIaAUfjBYOPI5//SRFgxPv1uDuT2Y17F44Zpp3fEng4H/q2OauUiRHYhliY7RwjxxhvI/cGCHxDYjOzYMSXixb5pmN+obw/fwsUhWVnrANa8NArCczHxkdc2Q306F9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKtS+m2X/zvvqkzobqHAxRy6RQYhGRx+qxgr6ASLPqc=;
 b=PnJkKpgkC6XXUfB8vnasswpFLtdy7M67b8NTixiv1LPYPIe5zkitKazzN3d2CzqqFpbkNRxhBAW0WHYnHjW8x8m3Nl5oM4qml7BKd8vgruu2OFzG6BqjDadubFy40b+FClqOM0tkDPO86d8PlJgzeQb7EoZNACQVnNI9sd8Qdoo=
Received: from BN6PR22CA0065.namprd22.prod.outlook.com (2603:10b6:404:ca::27)
 by CY4PR02MB2279.namprd02.prod.outlook.com (2603:10b6:903:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Thu, 17 Feb
 2022 19:14:41 +0000
Received: from BN1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::af) by BN6PR22CA0065.outlook.office365.com
 (2603:10b6:404:ca::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.20 via Frontend
 Transport; Thu, 17 Feb 2022 19:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT010.mail.protection.outlook.com (10.13.2.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 17 Feb 2022 19:14:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 17 Feb 2022 11:14:35 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 17 Feb 2022 11:14:35 -0800
Envelope-to: git@xilinx.com,
 herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.15] (port=57270 helo=xhdharshah40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1nKmEc-0002nF-G6; Thu, 17 Feb 2022 11:14:34 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>, <git@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [PATCH V2 2/4] firmware: xilinx: Add ZynqMP SHA API for SHA3 functionality
Date:   Fri, 18 Feb 2022 00:44:22 +0530
Message-ID: <1645125264-11033-3-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1645125264-11033-1-git-send-email-harsha.harsha@xilinx.com>
References: <1645125264-11033-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f666f652-1130-4e1c-bfd0-08d9f249bf2e
X-MS-TrafficTypeDiagnostic: CY4PR02MB2279:EE_
X-Microsoft-Antispam-PRVS: <CY4PR02MB22796308AF77D81288E777FADE369@CY4PR02MB2279.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ng83sYTzIs/O33QKL91t8jYI8NwIuRKrxyKr357v4EfN8Ch1FqWvXtf4Bl6TIw7E5ky1StrQ4zPFHqXjsCN0qIpsB0U9N3IsJWC524J4GUuOfkd6aJVZuO5fptjnfWmCsyk7QZYwFNZPbFo9+po7jfkS/LIIm/gdg2Hor8ceEbPHXqPEyx72ibdciSAkdSQ4Y0AV8G4nOlwDa/HjVA8qGIm45DrJBlXeBPUoMRuUP3+gWlaWEPprk0Dy9IyC37Zt6sZ9FsL+VD4wuEqOGkWc+Za/7viohN4KgW7Oe0o5yzWm3xueWIa3szfeQGf9aBJeAsJW8f7CaWqG9Jkywg2UCiJDSW0oUk8X6oUkJd9/CGHSLH7WNozK9i8UGtiEVr6IxdcXxrNRHPK5VfUa+fxGqGT9x5hUW5jKtHubAJQ4aB50opxoU4jmfjqaDFjKfhY9fGlIRwWgHbeulV++CLq8gr4uYdHiroylXadXKC2n7cHgDVaq3TotaSoe65I7hIR7iWILPU1Uo7pcY9PpT0kIirdacLD5G2AAMYsqNdv08sWLGDWQf46Egep//N+/hYHTSskOcYXuzP5ft+xs3WWoTEnzScvc7SEa8FAD9qgY0LT4GMWUdfxr3zYhbesXdO8ZHGOyMEiew+NkK0SmPF34je39oCTPaLkEgkQOjvH6PDuU08DS0Vyskabh1Bl/D5tFD6Cxh6BKyX/xO5yHYYlSCEpXGQ4XVXOJnNdx4OtqAws=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(83380400001)(36756003)(70206006)(4326008)(6636002)(8676002)(54906003)(7696005)(5660300002)(70586007)(40460700003)(316002)(7636003)(6666004)(9786002)(356005)(36860700001)(2906002)(107886003)(2616005)(82310400004)(47076005)(186003)(26005)(508600001)(426003)(336012)(110136005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 19:14:40.2119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f666f652-1130-4e1c-bfd0-08d9f249bf2e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2279
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds zynqmp_pm_sha_hash API in the ZynqMP firmware to compute
SHA3 hash of given data.

Signed-off-by: Harsha <harsha.harsha@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 26 ++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  8 ++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 450c5f6..5e5b0bb 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1121,6 +1121,32 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 EXPORT_SYMBOL_GPL(zynqmp_pm_aes_engine);
 
 /**
+ * zynqmp_pm_sha_hash - Access the SHA engine to calculate the hash
+ * @address:	Address of the data/ Address of output buffer where
+ *		hash should be stored.
+ * @size:	Size of the data.
+ * @flags:
+ *	BIT(0) - for initializing csudma driver and SHA3(Here address
+ *		 and size inputs can be NULL).
+ *	BIT(1) - to call Sha3_Update API which can be called multiple
+ *		 times when data is not contiguous.
+ *	BIT(2) - to get final hash of the whole updated data.
+ *		 Hash will be overwritten at provided address with
+ *		 48 bytes.
+ *
+ * Return:	Returns status, either success or error code.
+ */
+int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags)
+{
+	u32 lower_addr = lower_32_bits(address);
+	u32 upper_addr = upper_32_bits(address);
+
+	return zynqmp_pm_invoke_fn(PM_SECURE_SHA, upper_addr, lower_addr,
+				   size, flags, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_sha_hash);
+
+/**
  * zynqmp_pm_register_notifier() - PM API for register a subsystem
  *                                to be notified about specific
  *                                event/error.
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 907cb01..f6783f5 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -93,6 +93,7 @@ enum pm_api_id {
 	PM_FPGA_LOAD = 22,
 	PM_FPGA_GET_STATUS = 23,
 	PM_GET_CHIPID = 24,
+	PM_SECURE_SHA = 26,
 	PM_PINCTRL_REQUEST = 28,
 	PM_PINCTRL_RELEASE = 29,
 	PM_PINCTRL_GET_FUNCTION = 30,
@@ -427,6 +428,7 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 			      const u32 qos,
 			      const enum zynqmp_pm_request_ack ack);
 int zynqmp_pm_aes_engine(const u64 address, u32 *out);
+int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_get_status(u32 *value);
 int zynqmp_pm_write_ggs(u32 index, u32 value);
@@ -601,6 +603,12 @@ static inline int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_sha_hash(const u64 address, const u32 size,
+				     const u32 flags)
+{
+	return -ENODEV;
+}
+
 static inline int zynqmp_pm_fpga_load(const u64 address, const u32 size,
 				      const u32 flags)
 {
-- 
1.8.2.1

