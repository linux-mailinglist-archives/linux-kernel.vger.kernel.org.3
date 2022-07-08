Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF7A56B70E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbiGHKIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbiGHKIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:08:16 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D3184EC5;
        Fri,  8 Jul 2022 03:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oD/vQUJv+GHUZGA9YuqhtFGpqWmItd2Oh+OJMfZtcvsk0xMR/7jItBydWqgOyNvcwU7Lt29hats0oJKxGt2Jgcs/z6tDwE5w5vyLvoP2+WuFr9vAbfiEddA/ChXpqoz7IUs/JJNp/hSvXyVeXJlFQsQGCfmA6z3k+i/K0XIZMoTVX2hIbu498ouN57E3aMdS3emgC5OZV9olgO0x5iMvU8g0kk/bG8oskROIdESFs30qPwL9yY3TWBzqUuP+/si1QF/8ZZ9jmW42lh88/g81mMmZvui1BYss4OF5lywzjQ8dj9ypnBnq37vqvghwc9H6LCZwDzFdv2rV6/uTQBh97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dzf6yby0RvyaSJDqpgac6Xwu1ueqt4Uj/OymCymLT7E=;
 b=P4uFtdEzELJ04vInOBLDHjo/h/BCLAIwMiRiOmHourrXGXk4pyHGQ2FcKJnyHShurS2MfBXCw4KENFFO5/u8aqngtTKVaYdiQYjxWik60gbdkledltRzpF2H6o1VMMCuZkP6sSb19i85EvIAP6CITfTK5vd3zWv3HVDB64Q8KqFSY2KtJZ/f8oHa04f850BHcXuBHgVJqmjUAJ8GSvMr08a2sNyea0jJ7Ij4zYtqKHWxnf4rvcLSONEmcx1L75+pAogdg5Y8iEI6mpDhXd9JCzwnlMQwTz6Fb7tIYJNssb0F5aZz0HufZzS9pu9AOITVVmonSDqCL8bZI1paWGmq5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dzf6yby0RvyaSJDqpgac6Xwu1ueqt4Uj/OymCymLT7E=;
 b=IUzoAStpHQwc+tKAatTSUEbSerfT1039VURLK4N/BcXSmsKok75YFRBVKAPg8LJ06V7Gxo+8ZKp0nROm1f4qRwWYD/IhoMmywCARDkiYjX+D7r260GJFmffAgWKGNI75sIwrYSuBqlOjdVZDHAnu40gqGCO9n6YOPc7QIABe0K8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com (2603:10a6:10:24d::9)
 by DB9PR04MB9474.eurprd04.prod.outlook.com (2603:10a6:10:368::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 10:08:11 +0000
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::1c1b:6695:20d7:fd10]) by DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::1c1b:6695:20d7:fd10%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 10:08:11 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     linus.walleij@linaro.org, aisheng.dong@nxp.com, festevam@gmail.com,
        shawnguo@kernel.org, stefan@agner.ch
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] MAINTAINERS: Update freescale pin controllers maintainer
Date:   Fri,  8 Jul 2022 18:09:52 +0800
Message-Id: <20220708100952.1998673-1-ping.bai@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To DB9PR04MB8412.eurprd04.prod.outlook.com
 (2603:10a6:10:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 469253df-9fc8-42fd-c6aa-08da60c9c344
X-MS-TrafficTypeDiagnostic: DB9PR04MB9474:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5UqAEEFU0kow5K4OsEatcVej09BmNB6HCu8S2+vlgum2kcEiESPKUw29Avy+1iI73K/OJqXhpXXTlR+0iaBfhlXESPlrluh97DZ4qsujwJ0zVDpjBn9nVcCpzEXxqMevwcLP4tbKHhV7mPRLTcw0KuX+mvvLDbmyMA6SCStUTSSGZwTEJGHKchOxD6vc6ZxLv6RZUGBTD+CGBLmDGWiKEX1njsrDUYR2306zTOTNlE1NGyi3cltGqOLtNaRaVJxZ1Csku8QKBr/H3v4mFBOaTiGefOP3xjA0uSm72lPwSh5pjZRAvSf0CeCWz6vPayIqEY1U1XCkoX5rP6UQt4tQUpg2NmBUucVWFJSOpH+K7fAR9rC9HmOAWqV8SCt9soDlKDnjbZ757YfQ8dikfSqH6eBJD8PW/cDqGjYdgH8uOcbLISxAD7b61npSZ2pokIoXcgi+iPVLa+I6kA5yDgTCFxHLUkfZwaHUzoU+5duXrKZVVQkzRidJTUeKSSBToq4hmEWRZUbdNRHHkP2HS6Wo6coid4LUHxj5AWn2M0z3VB8Cd0bZ7Ix54LU8GY7awPFWNkjRKKkf2TmPaV2r/qdAKZHOavsGblzpI4+UoPqf3C6Mhbg5kzWSVhGq6RypKJ1FbBi22JMxo8tIrKErh4OV2oHguO5jY9fC8Eb65gKi6OLxR5z2l1NqCUKuSQXDrd4JtngdFJ9axDSevsvObOn5Uy6d+llajGsEDhmqM31J9DaV/quyqzE7vemAYe2wEMEwpFRqFClqHXawhY0XEXI4jJr6moz+FhHYld5G/1I14YBzxuHcQ3lwrozIAlC1dMS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8412.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(316002)(36756003)(6486002)(4326008)(66556008)(8676002)(66476007)(66946007)(6666004)(4744005)(86362001)(41300700001)(478600001)(8936002)(5660300002)(1076003)(2616005)(6512007)(26005)(2906002)(52116002)(6506007)(38350700002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8Ujzi6t2oZG8sODFddnm/xGR/pz7SmDMZV2nZv3AGSHtKGJOERbUkyrB5MX?=
 =?us-ascii?Q?Qps6F6IGA4QyA738qyjKpwJvdtsuXmfmLHfg/Elyxn7VmQ2L7/0NW5rNRJSX?=
 =?us-ascii?Q?qUpERbZ657g6puICkkdfvch0Apae2jQIaXnMOaHVunaVM+aJzRGBsMW92TgC?=
 =?us-ascii?Q?8ODKpPVWJQsrRNMbm6c4YDSEdhIWryIjBcSGCHvEDv6/ZCmEGoY3uWynL3g5?=
 =?us-ascii?Q?CjcH6NdrMVpoEP0EKgaKt3kHlGfSV19UGca8rTYZ4DLDOWBrPkLMoUojCKG9?=
 =?us-ascii?Q?/0vxzcxLDn0PtP1xzulFmH0TViWUongm4zMsE1dNuGBUalcIVdn6EfrkOwIM?=
 =?us-ascii?Q?mOe5rfSQAKQ89aakYwinJakvVHhh9VAzH3cu0wikWWyq+bu9Xn77GD4Tn601?=
 =?us-ascii?Q?omwky+4CXAICetZOb2dOFM+N/hOXReo4q2NfYzlamm/Bg60XHs4hH9RQFzHM?=
 =?us-ascii?Q?AfSJdVmQSkzRDPjc+bSYENoAiVvCXV/vTNohNNd8MATjd/35MHSOBf5d2dQR?=
 =?us-ascii?Q?M8N80Nxfc/jIrktHlpf5YTi09blqtHD4s0rQ/VFzqZPmssnk5m4OpPfzkZ/z?=
 =?us-ascii?Q?hXdI1sxIieP/LFLhAReb6JyUSMzThvRbcOj634JBqGhZJnvM1gOIVQdfptp2?=
 =?us-ascii?Q?OD2FGS+OMJWkzmtcAK+TBQ533F91gacGPew3bvhGuR1VycKJ/2mPL3DyW+3H?=
 =?us-ascii?Q?Ih02iaPEbmEpB3unzLwdnH78DafVIBFx2HkMfT2sDWw9GJ4hfToqW3PQV/vB?=
 =?us-ascii?Q?pohugvzt2Lkns5mW4gEOxK2L8ilt27vd1W7hlhswYgxSzvOcSn4RbB8DJOMH?=
 =?us-ascii?Q?+4zptCMXilFWdh3hUn9K02nyAYsYMzQPs4/21B2jH/saXrfO03cMyi/ShGK0?=
 =?us-ascii?Q?3vkAxcz/TyblzvoAEfPkpep4anpSNsLI59DwcIcX/UZnT7qJ2oeh2L23tQA/?=
 =?us-ascii?Q?xHjskPJgst6/xEawsDfLpqAN31vvz0dfsv3+49FRfr2ywLL8yY+9rrr5KgFj?=
 =?us-ascii?Q?dceOoN/ttNob/bsbz0oHLcWxkr30QHCXgJlf9/iqh3P/GCqEI5Drw3nrotNR?=
 =?us-ascii?Q?Jh8F8ByygG2Td93NpxPrKjYB/k/LucJ0F9O7cEjKDuAyjOKP+uoalbjRqsMG?=
 =?us-ascii?Q?K6KX3Nxedwy1mgC2UNhUR0SoXV6Y4XzWBBsvl9PEwqU3c+vXmPDLrnPGPET3?=
 =?us-ascii?Q?o+rHAHcY+9si7ZaZZLKrz1blSNNmbnnYU9UwzA8cXSvxHcQb3M9syf/0J9xF?=
 =?us-ascii?Q?ZA5xGMj3q7kp4xpqrQ9jsaO0ptvtWQxFvzdhyzq70WnyjNAB8v8llI5R/CzI?=
 =?us-ascii?Q?VYR+bN9YAGMdJt8dL92vsdkBkY3zQKKS6G3VV3UOND+tsI0TNYmgsgYbBfrw?=
 =?us-ascii?Q?uNxkTjavPzAyM8SV7kShW/NFU9WtdF53yrNwOID4m6K1Wy6dDCjHOUfwLIlS?=
 =?us-ascii?Q?vMTLkqN/6ezcqGF2IVBR2hriaZ00wYXo66HukGVfF4/hgS0MudU1py3tDCTC?=
 =?us-ascii?Q?SBFzlQbqj33KAjGPOTBSxhjVOVfzKdpbI4D1VG397jbCpbQ5QVgBnbOrixt9?=
 =?us-ascii?Q?GhbP44a9PO1/MHxzRb04D1Ku0uFNgCMCYdCs+L05?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469253df-9fc8-42fd-c6aa-08da60c9c344
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8412.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 10:08:11.0540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXED3GEZFG/g2ets/ub9RcDlvZYOBoUb2b4NRI4UfqztI5tsLs5tVIIQqDN5bk/X69s5IVoMSAwPmpMwStDENg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9474
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as co-maintainer of freescale pin controllers driver.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6d879cb0afd..fbed6cc287b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15557,6 +15557,7 @@ M:	Dong Aisheng <aisheng.dong@nxp.com>
 M:	Fabio Estevam <festevam@gmail.com>
 M:	Shawn Guo <shawnguo@kernel.org>
 M:	Stefan Agner <stefan@agner.ch>
+M:	Jacky Bai <ping.bai@nxp.com>
 R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
-- 
2.25.1

