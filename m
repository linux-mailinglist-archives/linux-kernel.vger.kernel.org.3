Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FFE561919
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbiF3L1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiF3L0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:26:55 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2126.outbound.protection.outlook.com [40.107.21.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E8E51B04
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=de2zwqfgYCkckAy73QdGmDKZdduMZm06lV/ukkP7dQGRsXF+LNoVhRnxq+/M7VOaoUwnqrtZ5SRrj6iRtjUOQ2I+6fLYDfL5Ra2Pw9lkOYa1EkBfq9FflMzPKqQ7lkvLlnvqpK5S4iKNVQG/RS/19dqR50mYSjkHFFsAn6SKB6nMWeWVKDTStU3c6iYQXgaOmicQv7QipTCeYlWDk6kgYV06H2dwmQB7ChBzzEVnDyuxU8XgdEtAXjp1jJnflZORbwRuynTamv1gLoojnyopllIJWk3xS6UBOIyKxZ3AepvP6gYvtHOWJQLo21dektg+xNUxszo3oa/yVex9//GdnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNAPCMu9OGm4o+IZmuFYKax8zzMElTJkMVSaPMs3zSM=;
 b=Xn4pSd2nnOokd9ehfNROVwlfbVL4RBT8o0v2RFvsEzGUroiFbzCt0fQfeK86h04jwcF6GbYwnPDAaEzMx4kjSB/qmMQLe2QtCA3YkzaBpr6c4MoCkJWM4vyfkBHqZmjC4J5SsUi/Twhzcpz1pN03KnpmwJPCO0ZzmnUypO32CEXYlHVM92n9uDSgiM4tMkbfFRpd4U60RqJpzbI6PdbRnHyy2DJwqa0MMUY6Z8Pr6WMhJvycfR2uwl6irFU5GBEhGXzbGwOlgC/K5NDsutCH842kC276mwC8w7gzep7oTFRbtSWiTblat/k8zVLJOdOaOKezA76AkmqdC6tcb6bUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.159.232.72) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNAPCMu9OGm4o+IZmuFYKax8zzMElTJkMVSaPMs3zSM=;
 b=lZMFPuRbx5E0Lc5z4RXVCHPP2BG9qHvKx0zGa062K16/tMPRodli4ONXBILsPf/Rfphq1iw4CMWG6PejbcpiwR2N/Lmz11fQb3tXorCmJECjpvtc9kGWWEy878Lb7hSGe7L0TvkyuNYYWWDcJzi71lAlNeBvdfMzXJNcWnpPV6c=
Received: from DB9PR02CA0030.eurprd02.prod.outlook.com (2603:10a6:10:1d9::35)
 by DB8P122MB0156.EURP122.PROD.OUTLOOK.COM (2603:10a6:10:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.22; Thu, 30 Jun
 2022 11:26:52 +0000
Received: from DB5EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::fb) by DB9PR02CA0030.outlook.office365.com
 (2603:10a6:10:1d9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 11:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.159.232.72)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 212.159.232.72 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.159.232.72;
 helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (212.159.232.72) by
 DB5EUR01FT059.mail.protection.outlook.com (10.152.4.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 11:26:51 +0000
Received: from smtprelay-eur1.philips.com ([130.144.57.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by ext-eur1.smtp.philips.com with ESMTP
        id 6kPmoelKXl9Zi6sJvoXdVH; Thu, 30 Jun 2022 13:26:51 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
        by smtprelay-eur1.philips.com with ESMTP
        id 6sJvodLaKBXNN6sJvoZUwo; Thu, 30 Jun 2022 13:26:51 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xr12.bbl.ms.philips.com (bbl2xr12.bbl.ms.philips.com [130.143.222.238])
        by mail.bbl.ms.philips.com (Postfix) with ESMTP id 87B7A1833B6;
        Thu, 30 Jun 2022 13:26:51 +0200 (CEST)
Received: by bbl2xr12.bbl.ms.philips.com (Postfix, from userid 1876)
        id 80FDB2A00D9; Thu, 30 Jun 2022 13:26:51 +0200 (CEST)
From:   Julian Haller <julian.haller@bbl.ms.philips.com>
To:     linux-kernel@vger.kernel.org
Cc:     julian.haller@philips.com, zbr@ioremap.net
Subject: [PATCH 1/4] w1: ds1wm: Fix check for resource size
Date:   Thu, 30 Jun 2022 13:26:48 +0200
Message-Id: <20220630112651.2739425-1-julian.haller@bbl.ms.philips.com>
X-Mailer: git-send-email 2.25.1
Reply-To: julian.haller@philips.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aebb327b-064d-4651-08f1-08da5a8b6e0a
X-MS-TrafficTypeDiagnostic: DB8P122MB0156:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JTvAbIh3hUdNMq6J0RcXDlTJPkGUwOfxJlGCJQ+bXVTB7K8C22IgYeMcye1Jlxv0gfgFGSWYRubM7FZNyd+O5oJ+YVX0+BgilxhWoEf9b7yiZOCfKvhFltL1GxxrsxhCYr+s/5WIQOYEIHUeoAV524r7A05icrEPZPMabLvhQonLNronFjC5ZtersK398rpm8acYKoNfDtZZRe8vDBjkQ6L4zQM/1EfjGcF3r5JIK8em425gLq8y0RFjGe5fOc/GSfJPh5H9nKtlfRBvSH0Uf66VT5M26ltiWj1cf1CmYsuOdCgYcjmCQbIR2IMuzINmf045C9I5B5gyGT+ZnQcttG4ts10HX/OpLrs2ZLlx/c+xFsv5j+I0CmBcbeCYQC2WS7Nqey0aXNbLLFSH9hgo/H6OYyfDfqC5UW1pKVtpQpHUZVFZdCbhnmtbmpXXTKbHSgKYCc3EAy7rQ03iZdK7xooVquPx0t1RD5eMIq03i6Eac418wfieAy6E9V+ted5OIQGYpBYVrxo4h84zrffPVdFxrIaYEbIzetjWe+SlulCevGJeBoXBnv4CbyBPinsncPZlKuaxujVD+3HLMS/txOMwWQ507LZiHiewgiLGTLyvxFcXM7fuam+9tAuuHLfwuK14pvCyV2Zhi2/K/vctw87fW0k7KvdB+g0G0FId1sippmlpDrLk7Zg1tUq6zQIqV1K4ii+iZuyjbQB08amSxreeBMefiNZyTkxlWHILqjF1aBGS5CqtUkVV6AB9fRbTZmQ7ForpONpL61qp9l1ufPzMrOmkK4Fm5MFDjx4Dl5k/KL2VAqfQDYSHST/4F389pR2XFd8wMDkfwKzTxCR3MbbQCDZ1/CZi6GNuA+B1w/IrFX6ODVCbQhmT3bpJSoZ
X-Forefront-Antispam-Report: CIP:212.159.232.72;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(396003)(36840700001)(40470700004)(46966006)(44832011)(1076003)(5660300002)(478600001)(2616005)(40460700003)(186003)(83380400001)(4326008)(8676002)(8936002)(70206006)(40480700001)(70586007)(47076005)(107886003)(7636003)(26005)(356005)(36860700001)(6266002)(82960400001)(6666004)(41300700001)(426003)(82740400003)(82310400005)(2906002)(336012)(316002)(42186006)(6916009)(7596003)(32563001)(473944003);DIR:OUT;SFP:1102;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 11:26:51.8738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aebb327b-064d-4651-08f1-08da5a8b6e0a
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[212.159.232.72];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P122MB0156
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Haller <julian.haller@philips.com>

Commit 242b476f821b ("w1: ds1wm: fix register offset (bus shift)
calculation") introduced a check for the minimum resource size to span
at least 8 registers. However, the DS1WM only has 6 registers:

DS1WM_CMD       0x00    /* R/W 4 bits command */
DS1WM_DATA      0x01    /* R/W 8 bits, transmit/receive buffer */
DS1WM_INT       0x02    /* R/W interrupt status */
DS1WM_INT_EN    0x03    /* R/W interrupt enable */
DS1WM_CLKDIV    0x04    /* R/W 5 bits of divisor and pre-scale */
DS1WM_CNTRL     0x05    /* R/W master control register */

This causes the probe to fail incorrectly when the actual resource size of
6 is specified instead of 8.

Fixes: 242b476f821b ("w1: ds1wm: fix register offset (bus shift) calculation")
Signed-off-by: Julian Haller <julian.haller@philips.com>
---
 drivers/w1/masters/ds1wm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/masters/ds1wm.c b/drivers/w1/masters/ds1wm.c
index f661695fb589..0ecb14772f30 100644
--- a/drivers/w1/masters/ds1wm.c
+++ b/drivers/w1/masters/ds1wm.c
@@ -544,13 +544,12 @@ static int ds1wm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ds1wm_data->bus_shift = plat->bus_shift;
-	/* make sure resource has space for 8 registers */
-	if ((8 << ds1wm_data->bus_shift) > resource_size(res)) {
+	/* make sure resource has space for 6 registers */
+	if ((6 << ds1wm_data->bus_shift) > resource_size(res)) {
 		dev_err(&ds1wm_data->pdev->dev,
 			"memory resource size %d to small, should be %d\n",
 			(int)resource_size(res),
-			8 << ds1wm_data->bus_shift);
+			6 << ds1wm_data->bus_shift);
 		return -EINVAL;
 	}
 
-- 
2.25.1

