Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F349C51DE7A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 19:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352054AbiEFR6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 13:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345374AbiEFR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 13:58:02 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10EA5A15A;
        Fri,  6 May 2022 10:54:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apbKnJDJkmfJZodETRRNgesKLRf1PPH/gvndp3VuEzzoAX2VK20799/4VntrN4aEge9mNsd8TnMpXdpvLvnVYOe0P9pTIOn/djXbJ7GEdRbragMBSYc3+2u5+VFzMx9ur+uTijNGA62ubWnvI5aTs5EwwebonRz1ELq0mGZvfNXlA6d6Cl+RBv5P36KTtX44U4r+cZ5nd0SWExIm5bmpGzy51Bj+yq5+i38k2Nd4WnN2WFuWOByJGcH9jLRqqrxFjw/FdGUGhvxLlEjktEnS+H9UT0uPiLRmaRCQW0M28Vq2A5mCfwUuXJRjQz/Vo4WED0zj+iXndk8aMf8gQrqLkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2Fq1+v9a+8RCcgwkeLTrI+Us5bOsnjSpQ3uLUZwBeA=;
 b=CL0mmbEk3uUf15t2qvRWYn/ABfR1VlFOxigkoUOhv03ztEf0ZUCCIpuwZnBlupSYURn1JlgEkxgtrTdbHXkbJPnVVGClq4PCajNv+QqguTxYIvzhqCFvSl7IJJOHB1ValIjwoyDqE7xgrg8FFIr3+5tWy32rDQlaV1+PzddIRKWIhsl2keaQ28O1iAisA5O9abq0SuMj0GlXYHHx+38zjhPEFaCuA/ZA9/OCOpHTDGWfZcvNgE4jRIUaLOjpMFU/e9pLAZReEEw1MXneGOjNPEfJ1pT7b+Lh4JZV5nY1YXJE/TU2mAiWMZFcTSXqBstmE30reRNK3sh7IWmLqcq8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2Fq1+v9a+8RCcgwkeLTrI+Us5bOsnjSpQ3uLUZwBeA=;
 b=ITJJQxViHN+8lS2r/76/+kVOmGsFnUpMjdkqshYf+KQJNjEuTSK9fLDSIj/GbDEFLP5EnX22qekiZ68rRrbYuGvphvxLAXxCKrWgNRcBAUJZuvZAndb0hnMRO76uEYN5D3VANBuSgnYJn6+19re2DFEKH+7bnehSV1FuIrIenRM=
Received: from BN0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:408:141::17)
 by MW4PR02MB7442.namprd02.prod.outlook.com (2603:10b6:303:75::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 6 May
 2022 17:54:17 +0000
Received: from BN1NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::6e) by BN0PR07CA0002.outlook.office365.com
 (2603:10b6:408:141::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Fri, 6 May 2022 17:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT054.mail.protection.outlook.com (10.13.2.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 17:54:16 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 6 May 2022 10:54:12 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 6 May 2022 10:54:12 -0700
Envelope-to: git@xilinx.com,
 balbi@kernel.org,
 gregkh@linuxfoundation.org,
 lee.jones@linaro.org,
 christophe.jaillet@wanadoo.fr,
 szymon.heidrich@gmail.com,
 jakobkoschel@gmail.com,
 linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=49800 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1nn29b-000Fxi-IX; Fri, 06 May 2022 10:54:11 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        <shubhrajyoti.datta@xilinx.com>, <lee.jones@linaro.org>,
        <christophe.jaillet@wanadoo.fr>, <szymon.heidrich@gmail.com>,
        <jakobkoschel@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <radheys@xilinx.com>, <git@xilinx.com>, <sivadur@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH] usb: gadget: udc: Remove useless variable assignment in xudc_read_fifo()
Date:   Fri, 6 May 2022 23:23:49 +0530
Message-ID: <20220506175349.10102-1-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36fa55f2-1d61-4e94-6a9e-08da2f897015
X-MS-TrafficTypeDiagnostic: MW4PR02MB7442:EE_
X-Microsoft-Antispam-PRVS: <MW4PR02MB7442B42E0C3DC4BF620DD41ED4C59@MW4PR02MB7442.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpicT/bBCiCf3B/tvNF/NYZXnc5gaeZqMabkaK5GA4wmT0WVqjGkoJ8YwgNFJk4pFNb+vyAzwAYcEOHbnSK39b2sLBvBEe/ykviPxFwWnVjhSIN1MSvtRxrHYnNmeNgdoIOFvmtA7kGSrtolsC40sKFevdKYCBJWaJUkAx5Qhyr6Nse9Bcd3hFYVpQmYvxxdwEG6veR5cpMSwieFhbDbUXZEK6gazEFgEOxQx6OYRvdnjfHcQzgl5gviFEwn5531UJ3wrI3AeOfPMBeWG/BcLOvETwRNcEQK0SbDqUhFXsozXZmkayY2Du2DbUtklFLMOYDthg+ljCbFJw9rQqu3ZWkHOKF2fMmwHo6YmO3VjUDkkXC6HeCHMao31A/AVV8ZU8uXjfgOtiHexyOMiRPbVmLdGjSSvacv8rCGW2/O7jTCyJlNnDKPabkrNVupMmAc6lwRKFTeLBbQbD6a0RzPIAwf0undZ5QbZBteMKn3ks0upFt108JEo4gbhjYk8FvgCwA7cHxNpN5zwhndXjJU+2Xs+HeomREzWfw7C6oKLmy9zl21qcf4TUQzt0yuiilHFOX5IHQDIB4MG0hrV2dlv6x+PqhBsBE7VaXcH5lPhTQQ+r1YpdSbrO7kvl5xS20U5PZBFrmuwz+Nj+kJJyy+SSRmMc2dw50sIgHW3gCnbDRciCtEmzbd9NsVyEoyYAth+34f2dwOUkWny7+IEZCn7nS/cjA/4OpySMJtUEhgitqQhyIMJ8/H2zpx7wV6EEMhRwK7xQHTw1QhmQl7hEBzDs3PfwC1ZZ+DI+JqWSH/Dw4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(2906002)(44832011)(6666004)(7696005)(4744005)(36756003)(5660300002)(8676002)(4326008)(70206006)(26005)(70586007)(9786002)(40460700003)(8936002)(110136005)(7636003)(107886003)(1076003)(54906003)(2616005)(316002)(921005)(356005)(186003)(82310400005)(47076005)(83380400001)(426003)(336012)(36860700001)(102446001)(83996005)(2101003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 17:54:16.2573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fa55f2-1d61-4e94-6a9e-08da2f897015
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7442
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused variables assignment warning.
Value assigned to variable bufferspace is overwritten, before
it can be used. This makes such variable assignment useless.

Reported Coverity warning: UNUSED_VALUE

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 9369801..adfa1ab 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -632,7 +632,7 @@ static int xudc_read_fifo(struct xusb_ep *ep, struct xusb_req *req)
 		dev_dbg(udc->dev, "read %s, %d bytes%s req %p %d/%d\n",
 			ep->ep_usb.name, count, is_short ? "/S" : "", req,
 			req->usb_req.actual, req->usb_req.length);
-		bufferspace -= count;
+
 		/* Completion */
 		if ((req->usb_req.actual == req->usb_req.length) || is_short) {
 			if (udc->dma_enabled && req->usb_req.length)
-- 
2.7.4

