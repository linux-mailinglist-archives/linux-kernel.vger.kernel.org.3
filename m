Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE174D0089
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbiCGN5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbiCGN5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:57:31 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E39E8C7F2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:56:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/2VUqPcsAdtTFGLNe8SmrDveBvkY+rx/b2WJOAG8Q/loVkyOdKl6Zzgn17V/el3NtjM74bVNR+K4ab3WZRnxPMEp8Xse3Ypm0KtExVWoilXmO37CjqWH7UOPlC4108LNOemM+WXXYMmqiWPMt2Wx3k5retfhOImtEe2UAXCnohG0VBv1SRFsMGXtUKO/7GfaWD2Bc6bsK4NqjAJqoxidc3oFzyL92Qc6I7k2XqQ0kj3/NX1LHakEsGVn4R11/5sH35xAPIiR2AHNFz9VyeU37h5xNNZgInJhmY014Yc4x1D/eHK/XMP9jUR2WlhKF7CO+kPENR4jVxa4RFNtwCUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+squGTqW8Uh453GoT1krmDOnrHRsrFx9ogwVSVTsRXI=;
 b=dC/ZPMZC9IskxFMlSvJUrathATsCPo/w6Y6vV+WdhmtYlWH/3vhMhkVRL4kCOjWzn2hwxcDqjhBILG3ixq3ACw50Ft+cM+EXSHpRWP0vm9ImLJK47LZc2ZojSOPcoufiZ4Tovrp1BWoZlpx7c0zmk2nBQ2HA15UJsi/Z57U0nl0E+NVW4/Jacc9UuzqJefGKJ0uR1mtHo+P1vfb1PhUBv0myMT/Q2LtbjTtq5XdWxu1SoJEqevn1iqgPsh7fe+zV/TqcU9tN2hiMRuu9jZ8bU+O4ejlVmdJBGEyEYrmzv5NDmxK/BTTJKiL8aeUT3qaJXU+YALE58U43//JziVaMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+squGTqW8Uh453GoT1krmDOnrHRsrFx9ogwVSVTsRXI=;
 b=QfbxB2w+s3HBTEbb1TghS/fMmzgdpssQRJQ56xIocCjDjAlMIMgO1eXfXkJaEhu5u9a8GOV18RIDMrdZv08sOW0ksbnrwPv6cmCgWuGe63yu/c9imq6eiDjUVKiuRwCkFSibKbgXxAinfnyQ8wa6QTbdFxq0rsD5z/ZWfZPEVQqvCujqzIyvVvgVvo1XqfWi9xUnJGbe2yfoOHyKWZs8RMTWaT9cRz4G8upYsuQLzSQ8YgBHrHaTXYqHmJpgvOJJU/RmaJ4ss536EV66IwaugAvJbeVAuiTjlIcDTuIS9ttUtUyj2p86P6ipKfQZKiQ5A/suqRSjCbx2iFQAJTgd3g==
Received: from BN6PR20CA0057.namprd20.prod.outlook.com (2603:10b6:404:151::19)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 13:56:33 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::ba) by BN6PR20CA0057.outlook.office365.com
 (2603:10b6:404:151::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 13:56:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 13:56:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Mar
 2022 13:56:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 7 Mar 2022
 05:56:31 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Mon, 7 Mar 2022 05:56:29 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <thierry.reding@gmail.com>
CC:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH v2] reset: ACPI reset support
Date:   Mon, 7 Mar 2022 19:26:26 +0530
Message-ID: <20220307135626.16673-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 708b77ab-5061-445f-73ae-08da004249f5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4483:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB44835705551E6D1E915BD383C3089@DM6PR12MB4483.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFKCQVK/nFFRLa5EqgoW4ta9aOcKWunxpHBhe9Os2cduPHrTwPHYo5+LkNJ/wSyOQcYz9GMpLXpW30iuYFZIGj2HOHBrTVRSmnqI3YdYr4F9AXoqVzfoeJ+7D4J4LPWe7f2DM1l3Frfg6amIco8zTX/8DiBneA0oAnDtJt261ZNu2PU0KO8/cK9OLH8M/IugiAEGpCqKGG1cKEnZ+suJq3jv+Ec7IIRFHS5k/4Tp40mBOGn9sT3apkjxC+LeC00vZohi9akBAqgIkTSdtUDolLbU1qLfL/mDPfOdl5arzwx3HzcfWv8tm+O/yj/9rZlail5eg7TmpjTeboE24ETIx2dY0SZQvRhtvn3ACKnIokeatwqY6qeak2W5kQpnMI6Y33Kr4FEycvbW9VdWJ9sBP27v8/jT5NMQEORJ5hYh3+o6j0mflCp/JNrKJEtPQYiGzwIZe1d+Xxk4qhDwerFQrdwSRCyVV0R5xrbRXSP3RBBtfR2BpDtgI7Ofa3ulunai8E4Odu3OVuoR7CXO9a17crsb84nXQNpSqY6xvceJ/RwcVk9pFjt69bQMzvRxnwvOSFhYtoiOtqdBxbHNYKhUKrakr1fpKdwAEYoiqU4CDLRN3XIjeDaF+2xXetJG2YR3CNIn+7e4WPs+w50i33e12N91sFRwdqpVfdbIAJ6MMga4kTwx+Kxme45tUVW7eLVS243cBEfKUUfPojtbIGzLzw==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(186003)(26005)(2616005)(2906002)(86362001)(40460700003)(426003)(1076003)(8936002)(5660300002)(36756003)(107886003)(356005)(8676002)(83380400001)(4326008)(36860700001)(7696005)(82310400004)(316002)(6666004)(110136005)(47076005)(70586007)(70206006)(508600001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 13:56:33.3135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 708b77ab-5061-445f-73ae-08da004249f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the IO devices like I2C or SPI require reset at runtime to
recover from an error condition without changing the power state of
the system. Added check for ACPI handle and a call to method '__RST'
if supported. Devices using device tree method are unaffected by this.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
v2:
- add error checks.

drivers/reset/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 61e688882643..45749d623f36 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -12,6 +12,7 @@
 #include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/acpi.h>
 #include <linux/reset.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
@@ -1100,13 +1101,23 @@ EXPORT_SYMBOL_GPL(__devm_reset_control_bulk_get);
  *
  * Convenience wrapper for __reset_control_get() and reset_control_reset().
  * This is useful for the common case of devices with single, dedicated reset
- * lines.
+ * lines. _RST firmware method will be called for devices with ACPI.
  */
 int __device_reset(struct device *dev, bool optional)
 {
 	struct reset_control *rstc;
 	int ret;
 
+	acpi_handle handle = ACPI_HANDLE(dev);
+
+	if (handle) {
+		if (!acpi_has_method(handle, "_RST"))
+			return optional ? 0 : -ENOENT;
+		if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL,
+						      NULL)))
+			return -EIO;
+	}
+
 	rstc = __reset_control_get(dev, NULL, 0, 0, optional, true);
 	if (IS_ERR(rstc))
 		return PTR_ERR(rstc);
-- 
2.17.1

