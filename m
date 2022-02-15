Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5BB4B60AD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiBOCDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:03:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiBOCCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:02:46 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213E7149BBE;
        Mon, 14 Feb 2022 18:00:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuwGCvcXQKj0Y832XJNwoKnI+3JS5ENgSbuw3MW1QIS1h54e0qraV7zaBJq0uPvU7hcGHhy+BdYD4FJLbmmDbdtOS4S/BmwiFdcckBNhjxE7BnRQ9nVuq+O222M31dvgXaWEqpCuDY4bkNlDwSLq8NlAQCdK0yTskGPbeTkgQCZG1f4tqd2hcn3BHjnpJW9ldQUb3WZg1GVObvmDNLG+pvy0WnDgOZE+OATMFDek/vm8gtKm0nWYDNgAY/3DYXh2qS9Sh8hEmmJjhEdNY3ZVOvd68zkT0UjG28msfaxOjXaeWSgl6gsn2cSCzbastC/Rt1Ph+KW/kvlfPNZHPoovMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nazLyr+9673Yx97hI6Q64mmsVrFFb/nHv+itswRpYwo=;
 b=F/bPRI2fdb9qFidIE3xbQUMmnuX9M1jyBvXtZw9yy5z/9CYYwMrBVMCJENQhl/nPRvd9Xh440kPz79GguP8LH8rUJOKTq9U3abK66vCX9d5W3MJgfwMUUET+KhG8b2HNU5uQLGYVjUO/BV3RUgnPL+Vje123mnGz323ROuLxx3tg9udzlvyDDO/GQz9570xs2uqh89bWci+Z9LsfuSNbp7/PeUMy80G21mbGS9HhHatBmch/WpCiLrxG2H08wVXtbYh54MJkFj3R7+huGN0uxr5dWz5AYLBU1grSNQKhmn8DSMrAUD8QcpQGMlhowsiKHXi3mfPyh/ih0nrp4QMBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nazLyr+9673Yx97hI6Q64mmsVrFFb/nHv+itswRpYwo=;
 b=NgUubEt1TX7h1gJL8hfG2uMB492e52645Vzpyal80wFjqbTzcSTVkQEs507+L0vN91kyef2caep1rRchBXo06QMmr6O/iy+8PxKir+xFMEpamclydvj+1PlV0jisEa+J3q+pYUuVBJZsN76w4RAGomZdW00lmzG2R0IIkVEeMDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SG2PR06MB5240.apcprd06.prod.outlook.com (2603:1096:4:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Tue, 15 Feb
 2022 02:00:00 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 02:00:00 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] spi: add missing pci_dev_put() before return
Date:   Mon, 14 Feb 2022 17:59:46 -0800
Message-Id: <1644890386-65119-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19e8f8f1-8aa7-452e-0148-08d9f026df74
X-MS-TrafficTypeDiagnostic: SG2PR06MB5240:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB52400E5270EFD4C4219107AEBD349@SG2PR06MB5240.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GtISiDMlyx/wV4Nlk6qFF0RK5rtoNXnQSxqFUCs0XPFPBo9pLBz8HtyvhXh+Hmd/oEc72TX3WtKW/AyIWGmBVL1dkjdcge3g4zf+3dTIELkiSmex352AqtJsk92bTRd6Yz0K63vK9T5kQVDQ0675DkaOyHeIUNinv0pc1VZ21dSF5KKzsEnYG4vuDLmCxt/pD5mB4tfjWsjLoWapN0CfveoFUKc+dMRjWG4oedZYigNXefddrLH9HEkHBDLXItAlvjBV5zQTcPbMg4yiI2z/zrZ5LX6fUW7wrVqIHCge1S9RF9DHqf+aSpk8nxaB8rynZhEJ5t4YI/KjoDkgUiDdJv20wrX5rpKUhXWspLoQue2TO/jm1KutAYuVB0adB7RvaInhI9VtH3x3BjjJsUIqGivWSLWiHyHOfJ/bZfgnO8DaQsGrFkHnsBKDyDFrof5wcBGaxhE07xGrNEkLbPWr0qmLHu7KgGj/z2YGIphwB/8B9yyDI857eFt/kJgFjobZft7PUErt4gFmP3SpMl6lcqJRd1jQ9U3I0ZQigxyAEVzOWjwaxp0lA9RzaMH79hDeNoSVvvvVdDSuAlhzJeTHLVs7/sVyB/S7LtvRyfPG9aAR7svnMxSbo/sGh+Zx3LCz2n+LxQMUnZ6JCW8wywQMG+qodYa1rlhCQE69bnE8wCtlA0bChdHMdX9e3Ly9y5L3FIRSEOd5MN/dI9x9FdbBIy1vDowaJ68pRSuwkTT+W60=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(36756003)(66946007)(38100700002)(316002)(2616005)(6486002)(66476007)(4326008)(66556008)(107886003)(186003)(26005)(6666004)(8676002)(2906002)(6512007)(86362001)(110136005)(508600001)(4744005)(5660300002)(8936002)(52116002)(6506007)(41080700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0y4PV+ZqLUQaKsqa0QUG/OH5QMSUNyVudXsLDlf7X7Gi8/nXolqVPD1OiA4K?=
 =?us-ascii?Q?bDgqSnZo4HCuffPGRpXt4Yzf/PPl/tXLshyz6KumIGPzqKIiqvytQKGdBlVT?=
 =?us-ascii?Q?nKvWu+KSTaladQnTXwwKb9LT0xwJluuMj1cEGM29T1Pg3iyFFRthgaBATtGC?=
 =?us-ascii?Q?xGIiCTf8Y7mANI0eGhTjxfxNRAnyvk9vG1FXVCpmci7SgUGTP0987th5pgtc?=
 =?us-ascii?Q?kfJhRRk4fa/BE2Uk7tfApiyuG1N98CudJOXrNdu0pC1N9dKJJoBRkfgvraWJ?=
 =?us-ascii?Q?EVTt/OeA3k8zMgG+nMgh4py0oYcSQSnPVWj9+VqOOOI1nOSOWF6UEOIQ6Xfe?=
 =?us-ascii?Q?qxCVggrRxrxCyonzCX3rxL2IX7XxcR0CIb4bXtDX2kSks4cLjR2ZMabPDt+2?=
 =?us-ascii?Q?3nDamqc8DdyFVek3i5HVVfBib68ayinQyRNaH+elhSqaz9JUg7z/83+L58QO?=
 =?us-ascii?Q?7KbP70b5QoxnecG3IuQey0s47hNHkkMPzgva1Y+KU4h968ZMkYTZPGdyfYyW?=
 =?us-ascii?Q?fQJ+qndWqpn8oKeiMkWW3hLOUSoxNEbCzJ6TglZdNFZazedYBFr++w7LfUfU?=
 =?us-ascii?Q?Z++3omFwO5yBku0JJnH/A73KRkkUEDovksklarQ1Tt84TyDbpwGztdyN9GVB?=
 =?us-ascii?Q?ugP83pYFHvo6C+H4xfWejr2hTd9yWIbCpOxOx3/WWjX9mX2ajGwxeW5SYe2M?=
 =?us-ascii?Q?kEZPBdldy8MxRXNdMIxWpY2l1ndWDqr6XLIHt7egNyNxkTXf8sO3h/t/ACfJ?=
 =?us-ascii?Q?fIGYQoFo3fVxm6Ocwem6dSyX/QuEcxDIfeF3CpnO7VI+vuSojQdFH861g0gV?=
 =?us-ascii?Q?MqS1otXaa6OPGj6aRZo5ln/HPEvOdOmSqY8OaavFrsXZUawlh3Tqi2wZAqLc?=
 =?us-ascii?Q?8H5ybVojFh50oQEeDHX0vzfO5UTRrrvBV4R3ZtKv4pTQA+T0hUT3qY/s2irM?=
 =?us-ascii?Q?22rfiFCiyaUSh9lKyR/5NsqyEubWpswQex8+VXFIUGQ8arehmmq5pXLu4dL2?=
 =?us-ascii?Q?dyPTTHi+m6/fD3qR2jKSY65V0rS9OBgHTFkuI6KslW8rSxNkI/I26ZLHrZbj?=
 =?us-ascii?Q?hfoDswb7b6Irl1shd8Pll8fiFKRz9EFfRVY0Vh+gAn87B2Eu6KhIqyQIZDvQ?=
 =?us-ascii?Q?ZP0aKv5KpptEDXwZVeSRRdDnsGWrBDAMihbkRCrhix4d1tsSlzIbwcL6q4aC?=
 =?us-ascii?Q?49NjNNvkAP+RkaN8TPU9Il5QrpqPuyibA2oJaIyioQoLxp9+tLhFBx8ourbN?=
 =?us-ascii?Q?kAGwcN9gi4osKJg79aE+EpGvrVMcOI3FYtwayMXywhD5pSfNC2aixMzBCCBA?=
 =?us-ascii?Q?T2ifrD2yJj9KOxVhZabWL6ONU77TsX27vMwHqLKUUZZ1X5lCq0nKKKbBGKSI?=
 =?us-ascii?Q?BGi+rNNeIZFctxLLroalDoZFbNGyns1RtdWEZ7GEsQV9GvxGi6PKFdKT3qjv?=
 =?us-ascii?Q?Y+6u6oHBrYNafatF1RuDnLR+KlGnMX0biMG77AjjjPvAa4O+BNpWLvMZbSPR?=
 =?us-ascii?Q?Gya6BMLOtaz9q5TN2vyBEWM4vyFQk0a+HvoJ+G+odO22z/lHtrGYRZaYNnZv?=
 =?us-ascii?Q?RQ/eoj/4LgM3BG01xkhZayLIBYxpZc/7tj4S6Hr5/tdtT79uA0MprAAyA96I?=
 =?us-ascii?Q?GdDy/PLGujfoO7Gua/E84sQ=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e8f8f1-8aa7-452e-0148-08d9f026df74
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 01:59:59.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1eoiG7fyRFkp2oe4XEmnGRzU9qS4y3nKFDV2jxK4Pk/dwuo1/XtfO2jeuWdc2K8n5pNAv+lJg2vM3fgODtR5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5240
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

pci_get_slot() increases its reference count, the caller must
decrement the reference count by calling pci_dev_put()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 2e134eb..5fb2f44
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -102,6 +102,8 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 	}
 
 	c->dma_filter = lpss_dma_filter;
+	pci_dev_put(dma_dev);
+
 	return 0;
 }
 
-- 
2.7.4

