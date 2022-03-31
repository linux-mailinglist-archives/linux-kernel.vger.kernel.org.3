Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD3D4ED963
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbiCaMKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbiCaMKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:10:36 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2137.outbound.protection.outlook.com [40.107.255.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7517D31513
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTE1h4y8fGaOZw1xaMXA+7Gn9bCG7jw+ko6CpVJ7aUb/kznNuNzte1PMuSSxfpaIlAysKPM59VDcVpd4UzGl7h1qSc1niQFj1yNwYsnF7q89h/+7TOr1Tq+DKytI5V7uYmHfAboBZ5vqUi1RM0yEDrWEoxFIVfet7y5doid7BYkRsERDCj+RF2jDl2dl8nO5PU8ehQgXd81OXbAWmunubq6hP1ZQCtUGdujRJRfG4zvCsc7s00dV2JiSv8+n5WCfhGfnGwV2c/9fHpsHDsqZ93rsExlck0cM/dzZqw2zsN7pnmosugpHMc024Kksys1QpFyBgx+79iUgPjxetpAAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+0wcEHDFaSjHIBW4mg57qHIxShqM19A4XovI/5fakw=;
 b=LRGRNuSCrrTedOrfP/ezMbhEtgYt6gGiaAQWwcnoKPUUcjevZFKw1g9wf+QBSJUZ9eSr0FFtyxa36qAEvNyikOjKy97M9gnK9d5By2ChlZqBkzMzPaEipoE6+/pKuAcqaCcMbzvUSqcB/I2s43+7fJoXO49xJT2Cu6fCWbJ9yLKlQoF6zhnHn0aH6nCwTlnFjudAAvbEFHOoqsu02foy0izJBHt9X/+9SWZvYul3LArQnulrZfnf/scjhWidHaRTyCS269VllLqfVNG0GvAHIaNSG76HL5rf7OHwSz+Y81PRHQF7FGp5AAv7IJKyOy251xtc2nkoW9lUfN8wzBJITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+0wcEHDFaSjHIBW4mg57qHIxShqM19A4XovI/5fakw=;
 b=fkdOuLvU3RFYwuyLJAYelOQdLLL6EL8aGkhJuppne9FZjUXZH9HuCrS7iWr7Wpdui7oMWcNQ5nmHGTBnVVHpkxuIk/aLYenZq3u6mwadHtb0Ip6ZJsGQ7qbIG3q18uugD8Ar0WWDuBRJH50p7w412z7T7OmSoPiacFDYivlV97I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SI2PR06MB3882.apcprd06.prod.outlook.com (2603:1096:4:ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23; Thu, 31 Mar
 2022 12:08:47 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::6c6e:d8af:2d3c:3507]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::6c6e:d8af:2d3c:3507%7]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 12:08:47 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] staging: r8188eu: remove duplicate assignment
Date:   Thu, 31 Mar 2022 05:08:34 -0700
Message-Id: <1648728514-37390-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0047.apcprd04.prod.outlook.com
 (2603:1096:202:14::15) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef10fb5c-c499-4804-126a-08da130f3598
X-MS-TrafficTypeDiagnostic: SI2PR06MB3882:EE_
X-Microsoft-Antispam-PRVS: <SI2PR06MB3882DD350EBCB440AA44C73CBDE19@SI2PR06MB3882.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k3zkNMlPZhyV8J+44J58vtx9RCHcQgyHixKfhfFJ7ax7g5z6cjxg2+PiFYkDmU5liI2VzQI49LPwzSq/Ijfwnj7/ztr8Ae22hz7RN49Bo99p261OZ3zZK2KVHcR9moLi11sH91oGGXiSrq8uYFxOa5pQ+hEdN/50j4BW3nGRxE6xrVig/Pi8z9uf/X0wNhvShoHqcNTuS7eWpOni6xLXGTiO8W2bHSuoIsxtSK9l+PA9gOm7ZN3UqfyeJAq4A2rWUtfwzKk77u83K7EqYGdodkO9WcGECf4PztgHg6uleqLUPdoKqcs4whzBm/9xMqhfM+42CA40rlfaM40jskpjHQTM71l7i+Nrt9M8Lqn/jIN24l6OlIWP/rK0HmpNko4t6GsykfG6dbTTmkLNi/nHHlKN5GI+wT+yXS4TfPo6kEvhBsMWhwiOnShhRhWEJp2yRWGerO6vUFAFX49gQ8Uz/uCgPRq/gJlpN1lkbCnquwGeczywI/NS6HCaQZx7xLQOg/P/lvn/fIC0HfD4IrWYXLnzmVKoETjRdfR9npYiwfQBpqls2IpseVRGc5P8BoLc18sNUlCyneBZIlZ42DE7ahM3iwwo7PxGI8sMs9/KvXd4icl6whMnzlkWzaB9+WwRl98pOJknkuqtkCohSM28w4jP+uzO9iNAyESesyyzvkB1CxxUeBiDYCkHa0TXE40gzZPNqvXxEcY+TK1m5LYOuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(86362001)(316002)(8936002)(4326008)(66946007)(66556008)(66476007)(8676002)(107886003)(2616005)(26005)(186003)(83380400001)(6666004)(508600001)(6486002)(6512007)(52116002)(6506007)(36756003)(4744005)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NWazgiXjUlGgOV2+RU4RtyEG3y8zjgyVh7QrIkfdc72hXAvNA+zeMBvrqZRR?=
 =?us-ascii?Q?P9JYhHAIpJaMDe99jqBR4nLzaY/Eo70Vn9d2iDjteMVRZguZzqb/QK9ug/vN?=
 =?us-ascii?Q?t+5oovgYL4ScrogCWO6mM/81OuhqdheUAd4NADjtOkkb4qy++18ncYFeZQpY?=
 =?us-ascii?Q?uaeugeGuDqEzDNaebCWgimqUcY4LPErWVj5q52vJ3CdtYTtwUkkw4TS+jPaf?=
 =?us-ascii?Q?jJLgnWLQutYxRJzVjIK8lMNHj9A+4LZfuPQutIsMff/g6lwD0Sqxdk1zY2Dy?=
 =?us-ascii?Q?pxFhYctEkvjA2d5J5Sk94BjHJGqc3l+d6OrL1LkJ31DEajaUEWHq7HHhzonE?=
 =?us-ascii?Q?VwZLPuCfafMDiGHkfxCItbVi8wxxTa96Fxgj3RKWkMCoYq9OQN9/8PP0bDW3?=
 =?us-ascii?Q?gzfWBW/0jAsnRGgT5HVDbx3dtCZfC5uEi/W5wqRjLVO/6G3o2dJ1A2a4Dat5?=
 =?us-ascii?Q?sVb30TIqofyn9HL+ptDcZhFgKacshyqWtKGOV5+5KefEYnEzR1GQMceLWhfC?=
 =?us-ascii?Q?PbHHA4l9d8SFZS2qZtP92X75o4Fv8Oebsa5E17BMKRnmlcmQIjovNDprLKUE?=
 =?us-ascii?Q?YFoX+VHe9gyebjlQe+sQrTU7xfPtcLeYolhIYV7RWe1inPlFPGs2O5slLuMn?=
 =?us-ascii?Q?wlxLSdZf5d/TRvJpHZ/+Hy/5rLsRg3e8GIPvzWSuyPLorovE3tu2cvm0OhQF?=
 =?us-ascii?Q?EAj1QHl40FJYekfsPfWAZpLHxQKRsmMMJCIgXl38SZuYpTNUckxcDh0jAV53?=
 =?us-ascii?Q?S1b3q34dhJndZt1tBrBGzqIdO+z0sVUn2t+Uh58KDg+OzGYrypSzXbWAp2CS?=
 =?us-ascii?Q?zDcflcencu1eodsuzLvBleZQQM8WAi1SZ1Mg4ipKfvo/RGXR1PnWtP8hOBrp?=
 =?us-ascii?Q?1+ikNDssWNn9v7dJ4p4ERVt4tyFiowpV0nAtlqz6R7FNtX04d1Jjw9dnuzbe?=
 =?us-ascii?Q?BO/WiMebN/AAC653PhX8784eZDR4Xj1CF7QMmlhOn5hkcwzZDuHj4HDZvZma?=
 =?us-ascii?Q?SAWiYKnQ34n16C0/qxOdCqVLsjQ9zmQDL0xp1Fj/sH/Swlq3WsL4JORjCPFX?=
 =?us-ascii?Q?Xho5SoHV/+ejhgQfKBK54cY/Gx08uy5gKFe1SQiXVCaUuv1QT5xnyX3pPCyC?=
 =?us-ascii?Q?kQffc6Hesnu/kX/91D91vFmgprBOSxGCbQeDS0cn0RB1UxPSqx8Y9E++EHq7?=
 =?us-ascii?Q?cssb0B0XtVZXAz0WU1mx4/XKDfrpgpghQDiwcc2GdaYkHaehIq5A56V1DVpy?=
 =?us-ascii?Q?21bXh17KmtoCSak14q3r/I1xuToKBV5rlgO1e5zeBSQ8ovdm2OPXmOpWWUpM?=
 =?us-ascii?Q?ZaZdaz3UiMJBxBEdyqliqHHJn5Zt80Y1Xlw+QfIpoiwtF6SCWmkH+vFvFD4j?=
 =?us-ascii?Q?S314mD/NWtfFGIjbPpIN6n4iZYBAbRcblZ8WDagSz06m88mi9b4ZR7nP06Ej?=
 =?us-ascii?Q?7/vTXURVdhQv66rgXnZoqS3uwi8fmzPwGeH2KjFjDyjI4u6m9T0MoTKWO3ka?=
 =?us-ascii?Q?OWZ9EZcvEppMgbxZ1THhvUa0IMnnyPfHUA28VqOn3jPJFgDI4RLkTQfDoOJ3?=
 =?us-ascii?Q?QBrl4cwB/L7QkiiYK5piAuHtGyt6ppB1D0Y1r9mdSPmtbqLg/pQgtlV3tGfP?=
 =?us-ascii?Q?mflyUgcB75LUaKR8hOwe8k082alraSgAHqeceMHoJBwtZmnsNI6RUCc9LebD?=
 =?us-ascii?Q?h+YWUegeRNWzxjKFaNtSD8lIydJjRdspt0Xeu31LmJ8yntdZbHJk9Gdj1HNW?=
 =?us-ascii?Q?UEPlyQ6pHA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef10fb5c-c499-4804-126a-08da130f3598
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 12:08:47.2660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pY34/54Txwbb4W+zG0M+0ukNqI5YOF5wB66r6byt/iGp4SkljeXQOzkbX48LhatCI7mqf4bIYAGKrwBxDfXUpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3882
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

netdev_alloc_skb() has assigned ssi->netdev to skb->dev if successed,
no need to repeat assignment.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 673c30e..e5d6cd6
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -260,7 +260,6 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 
 		pkt_copy = netdev_alloc_skb(adapt->pnetdev, alloc_sz);
 		if (pkt_copy) {
-			pkt_copy->dev = adapt->pnetdev;
 			precvframe->pkt = pkt_copy;
 			precvframe->rx_head = pkt_copy->data;
 			precvframe->rx_end = pkt_copy->data + alloc_sz;
-- 
2.7.4

