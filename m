Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97921520326
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbiEIRH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiEIRHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:07:25 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2342BE9FB;
        Mon,  9 May 2022 10:03:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVFdR5ayfAW5mb9Z/JYg4QytmlNsWnW2OSg0wGPz8oOfW09ZJX2bdWyHG3W090xhkTz/YsgA42paCFttT5WfxxHjy8aLT70PCItSLDbgs5GlBgskOgPqLFHFbWK2UMDbM7io3DEMRF2RD2JabFYvD6tduD97P5wD3HYnba6cpBq54cAZhztyglyMbDW/itL7mYhrw7qyvaDG4BPG+VjsaY1nl0red0Y+SkzQg3C28kqmg3Dmod/1Ts2eow1zTWwF8noMH38xCX0DosIQKvGDifjDlkHCxuQrfMSX+EIVn3rYw4+EGoHByVGCCITxuwz7TGunNWbxNCIWUCDJzRboCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbv0Hp0abU0aDG6vWHem3z86IwXQwLQHV8Zmvk79G9Q=;
 b=BuZPqqXK8LsymOutxEYGSkK5JMDfPOpenQtFAIn3YKyHXq/EEPEBMxoGBn+M3Ba9dytwBdYpzRMqcO5yTg8eKQs55z18U8rdh3KFEyaEZ2tBoJUeeaEBoS0nT6e7OvZ8KHqJ9BBnIz6L2svjCCm9W+cv8pRAmMZ0k87wfXn32KsPGqAaSryNDWhzGk44Ulg1j9Qjaa1QMmbC1LYb1hz6wQTmbPUqkSvz4PJQzegvok6bNycAhCgJKGhLNaWbd8clDtfFw+1Q1stgPFXdnk48RDjsP73rhbjIiwVkgo5HKERQPXveVUW8xjjXA6M3tSmdfLxOEQoT5GRhpz03iHEtdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=rowland.harvard.edu
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbv0Hp0abU0aDG6vWHem3z86IwXQwLQHV8Zmvk79G9Q=;
 b=XKKuR5Gae1NKNDkU5WAmfiFrkkhx+oyUvHB+eFg4xJNzQEKx83tYgqB1AGSms6SnyJiuQJ3m0uux8NKqooJNup9rwc1A7duzudvJ5E+yU4SwpEVGX4L5ugpi5kTQzt2AUhkg8+a7iDklK1ZAi/xZTEIvhjvD0MDZoDeqD1ep0hI=
Received: from DS7PR05CA0006.namprd05.prod.outlook.com (2603:10b6:5:3b9::11)
 by BL3PR02MB7857.namprd02.prod.outlook.com (2603:10b6:208:33c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 17:03:27 +0000
Received: from DM3NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::bd) by DS7PR05CA0006.outlook.office365.com
 (2603:10b6:5:3b9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Mon, 9 May 2022 17:03:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT018.mail.protection.outlook.com (10.13.4.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 17:03:26 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 9 May 2022 10:03:08 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 9 May 2022 10:03:08 -0700
Envelope-to: git@xilinx.com,
 stern@rowland.harvard.edu,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [10.140.6.18] (port=51690 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1no6mp-0007cZ-V1; Mon, 09 May 2022 10:03:08 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-usb@vger.kernel.org>, <radheys@xilinx.com>,
        <git@xilinx.com>, <sivadur@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH] usb: host: ehci-xilinx: adding description for return value
Date:   Mon, 9 May 2022 22:32:52 +0530
Message-ID: <20220509170252.28271-1-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf7cd9ec-86f4-4ff6-1013-08da31ddd589
X-MS-TrafficTypeDiagnostic: BL3PR02MB7857:EE_
X-Microsoft-Antispam-PRVS: <BL3PR02MB785799A714073EC4B6677908D4C69@BL3PR02MB7857.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERKOag0pfgni7O8OYC/xhsFqiEKEWqwlnx4lNpYOR6M3iu2LdSRzEEeGT6hARQoaD7A22cmLyBjNCI0BTEAf4HM6HBkC6tCRd9sZCWDXt/cXB87Unt2M3FC97+q18GZwFXGVEFsZz+R7gZTV/3kSw2dMwAG43qXE0thcGxR4lEPVe6AXNymGwFhOM7E+dCf87aBw44bKYLc7DMrNrApjzO++qSwwAiaxBHnNCOl+oASbqjJRwrp+nTC1gPeV8QC60opW679zkzGEWM+rWrk3/tu1hHZoLWdn7ZjAYU6/VtpkuIpmc0y9J8UsdWiR4LHBI44d4f7JPKvIiDf6dUsE8ih6S0UMWb3qdu2f0aTxvnGXsUZ6OK9NoTe759Jv+i9u7YHecKAgEAlwg5zZtlZ00iNmsTJLoLd28trQNjZZFxFfk8HhF5WaVdu3kRu73ArOkgxv3jQ+eRF0XQfQMVjo9XksCRxf0f9ou1apYAzlN9l1uEDFldAImY0WxequaOBgkwKIuk2QoFpekwEX111Ita01/58dSoOhFHkeNfrOouBCAduyzaUe6EgkL4QCJM1cdsx9Ui5HsUYK5VqRR0Q4GdFSozgm+o/7rJYYyS1bot3igAbPva2Mk7X/YDzknd6dwsjFAyn7Q53myAnehLSgs+u3CjQMXgZaMhUlnPg3eeHb8dnddfL+VXTaeHPfP6gA2uzs0aBOzQ+nkpHX0YXN5frjnAkk4rPtdMH8WFu2HGo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(7696005)(6666004)(47076005)(508600001)(186003)(26005)(40460700003)(7636003)(110136005)(36860700001)(82310400005)(54906003)(83380400001)(336012)(426003)(1076003)(107886003)(5660300002)(2616005)(9786002)(8936002)(36756003)(70206006)(2906002)(44832011)(70586007)(316002)(4326008)(8676002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 17:03:26.5472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7cd9ec-86f4-4ff6-1013-08da31ddd589
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7857
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves kernel-doc warnings to add return value description
in function comments.

Addressed warnings:

drivers/usb/host/ehci-xilinx-of.c:37: warning: No description found for return value of 'ehci_xilinx_port_handed_over'
drivers/usb/host/ehci-xilinx-of.c:117: warning: No description found for return value of 'ehci_hcd_xilinx_of_probe'
drivers/usb/host/ehci-xilinx-of.c:201: warning: No description found for return value of 'ehci_hcd_xilinx_of_remove'

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 drivers/usb/host/ehci-xilinx-of.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/host/ehci-xilinx-of.c b/drivers/usb/host/ehci-xilinx-of.c
index a9c6d18..0811a5b 100644
--- a/drivers/usb/host/ehci-xilinx-of.c
+++ b/drivers/usb/host/ehci-xilinx-of.c
@@ -32,6 +32,8 @@
  * There are cases when the host controller fails to enable the port due to,
  * for example, insufficient power that can be supplied to the device from
  * the USB bus. In those cases, the messages printed here are not helpful.
+ *
+ * Return: Always return 0
  */
 static int ehci_xilinx_port_handed_over(struct usb_hcd *hcd, int portnum)
 {
@@ -110,6 +112,8 @@ static const struct hc_driver ehci_xilinx_of_hc_driver = {
  * host controller. Because the Xilinx USB host controller can be configured
  * as HS only or HS/FS only, it checks the configuration in the device tree
  * entry, and sets an appropriate value for hcd->has_tt.
+ *
+ * Return: zero on success, negative error code otherwise
  */
 static int ehci_hcd_xilinx_of_probe(struct platform_device *op)
 {
@@ -194,6 +198,8 @@ static int ehci_hcd_xilinx_of_probe(struct platform_device *op)
  *
  * Remove the hcd structure, and release resources that has been requested
  * during probe.
+ *
+ * Return: Always return 0
  */
 static int ehci_hcd_xilinx_of_remove(struct platform_device *op)
 {
-- 
2.7.4

