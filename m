Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28764B6599
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbiBOINN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:13:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiBOINK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:13:10 -0500
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00050.outbound.protection.outlook.com [40.107.0.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729C5E09F;
        Tue, 15 Feb 2022 00:12:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRd3bnvhyDL6rxwpEOW4gy68PDjV2WX0SuV1RvKkXhpr1Pg8jpc7hQf+D4+snczEp5ojWq0bSUUU1kQ65PJEOFKVvBqZVCumuRPo9GvmeShQbe5sE9C0Y0irluwkgFypDwjGCsYv0c07FzuyfTXz9fedFUumsalyd/Fk9U2DEVVKoNVuFCal3ROeXQn2sk1HXmrqNtVXoqWGVEA5/McmW9z602KWFVE1MaOp9UuP4CNBd5PpcHsG3NDd/gDONPBVNaPv7O33YbY9Rrx8A7yLKUQ4BQ1MrXb2VQaqCrcbguRiPlrHQzcWN3KJWtQCkE9YJLNduCjCZTXGeJhq0fuDdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOwm9m3URtZP+AU0KsxKEfx+E6fM3XXxeCHiVCOoH3I=;
 b=nNRsiyRKUqVEAUxvoWUiJaOmYgoSRkVxaSKu5Z+Z37ayseJLZbPbQpsx+MCCr+kl0243VbXQ9C20DBO3X+bTU3LUcvx39gh9ZO5KQs7XbuTJLSsMrtefOaFg2N0hqi7+BF8babMkuBt2UMf64i4gkdVdg27K7dvofH4HP3FMx2x7MYtVSKhoCdz2Oe2ofRgVUeGD84jmZulluEPs5v0W7qudDjTdj0pM+VLLb6JpSuSecyguzSwVOo8V09WsGD02LlU99L+Kba2sfuRzhvuCMNuGTMuCqkZLFdOMSRCeSLWsmaPYvVWdUkB0zn6dGcG1osZUajz0vxj5nrhyricJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOwm9m3URtZP+AU0KsxKEfx+E6fM3XXxeCHiVCOoH3I=;
 b=Sspb/pV4qXe3GXoS6r3zwnUwp2W0zKwIxtS/d8x24DPxF6/ewDYJ1ClzGE2me1VyGdN/xcCHCOMGft8xfavbfFN21KkajxxXTFokHHT/W/ue5BnXpkI0MyPu5X5G3YWNZv6er1DcO+fiRadLa11NeLhjHDC3C8qN7igm7GYRdP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6740.eurprd04.prod.outlook.com (2603:10a6:208:16b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 08:12:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 08:12:52 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: watchdog: imx7ulp-wdt: Add imx93 compatible string
Date:   Tue, 15 Feb 2022 16:12:02 +0800
Message-Id: <20220215081202.787853-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ba63c83-433f-48b7-36d4-08d9f05af682
X-MS-TrafficTypeDiagnostic: AM0PR04MB6740:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6740186F1A48EE037C1303B4C9349@AM0PR04MB6740.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zf77OVN3g3oVqXz/GxZjflSmPiEd/PD9W1eBN+SE7z2goaCBvM6b/tF/QJCumBHJq06mjuE267UOyOoE3bbjRae3KccGFTPToglTzGnYZpvtbu4Ty8aIJ0ZTed6AfF2IUFdAD3RxEuCW/FXAC1bg8bmymRIBG+wqO5A8r4kEm5Idfdn1ZmUvyx4MHaKk5CL6vwMd9d7F5RcfFYuBJOKfHNTVeUU9vc5/NpGHApFAimn98WvCugqQmotsmYjHx2ZLSUYJMrOc2EShEJ0CCK7Fuc8cKwKS2FSVBXHRB629C+nOeJ7LMULnA7WsA+y+IglITyqZ5CdAENFIaO0aybAav3QPE3PPro+PgioIWL+CdlpSN5KmJKK2bEyKuzsLrznE9fcyUrGeqzhxMomJkgJfiwuv2Sa2c5GQlKCjPPJfuCuGjqjoYB7QWi3mX46EuNx/8sxgOD45y8K+ZmAmcpZV76iRM7NSRcZKICNT4OYuLno+mc2bu83DJ/7fPM/FEX8aJUYoCKa4VJ+koMv3lh1ERTepE7KYsI9f/FCGH+kPpxeWBKmmV5PJ01FWdB+d40uzI6rTxKVACM1v+PWoDyxl7SRBsQp67UUCH8XdngFE4ID+p2su6rILfVq/yMsID7XS1+iLPFxgu7YADfHkBRiDGyKix5H4M8hrZ0EHmRbGb7qDXlzVDXoYYGBvq64vOUHcuKRj02nu6GR3MbUG8gS16g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(66476007)(66556008)(86362001)(1076003)(66946007)(4326008)(8676002)(8936002)(2616005)(5660300002)(52116002)(7416002)(6506007)(6512007)(6666004)(4744005)(186003)(508600001)(316002)(38350700002)(38100700002)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d9uh9OHQ7UXgsKKgBofrRf3R+iWbLEPdtvDYQc7BW62uAD3E96chsMS44WM2?=
 =?us-ascii?Q?YlQVfapzV71A8MJEq1FC6Mzh575SazmRohEjRJb/gan0gNhlwFXnjURJouYw?=
 =?us-ascii?Q?tCMEY08tDyXFqzSTEaGj0X2zedITQUHeSPkkOzwcqMZEPMPCp9qkMZZ3NAxC?=
 =?us-ascii?Q?VECYPazHIGS2SJHUPS4O0lQlWFKSz/0zvmO4b2buhJRNbcd56sIv5f8FkN6N?=
 =?us-ascii?Q?1h4R4+4LsBxkaSEzyJgNKWwZugQdcTbxSg1li3/P0h+w5zNNIwSCwEc9L79O?=
 =?us-ascii?Q?DRt9Wygkyo1I7PBMIpxD0xKNkPI11vIp0sn9UwtCywjc4NB+cvKq0Y195CVm?=
 =?us-ascii?Q?HhQQ03cljxkc5rK0tHbGUNjvJlSv9taakAwSY1HTgsZeZ1LexgwpF3oJ1F7L?=
 =?us-ascii?Q?0PUNRKcpwiFoU+3tHc4XuL1JWUEmneHm7lTUTPbPPKd5UbiXID0PTOXen3z0?=
 =?us-ascii?Q?Jy5OIL/GoJoqxqPAYqh6VQexRNDO1PYbFtJwwBqCpK9TFuyPYWNfPy1aGoFl?=
 =?us-ascii?Q?9nxSRBeiE9VsodvlDpT7j8TpOkHr+hvpsmiX2bWOP0gTrlUXEkSYg+mKmdNE?=
 =?us-ascii?Q?5VLjmTuK7T+XKu8u5C9cJpCe7tbebC39nGvNOETnlrIXlHQaldo0yfn4wpVg?=
 =?us-ascii?Q?LyaO3PJd0CGuHygA9yl9mfqy1/VqZULCF2DpBUy21IDDTFQ+LqSg/6nYYUKW?=
 =?us-ascii?Q?u1fM685qLAU3V/2S8vJB1XZy6fBOKUuGusykkzuAgl1H7pWSUepEAAf/MwfM?=
 =?us-ascii?Q?y55MjdoXX6vsUNhrMBipOufkzYAniqPZGYC/NEpUqiQ83mvbsEwhW1sl6L0v?=
 =?us-ascii?Q?6AUnS7AvS/Mrn/IEqBv/xCYgXK+DSMMsACFdHdjMU1yMNOs7pi2DcJvOZMHf?=
 =?us-ascii?Q?h+n0bzxl2O9DMmpRqFNzlcYNrHYVQqoQooK2k/VTfRD3B29p0g7O4ku3bATe?=
 =?us-ascii?Q?H14nFHhL3tVInY8UWYqE5LI8sDq48XS1+ReR3NFkVzCzg+6xJkErCAL7yUMk?=
 =?us-ascii?Q?fIIfoFWkPUd1zHAIsklEDMge/gJUE05kYkte/wQMADskVewBzxNBvF+ugHfL?=
 =?us-ascii?Q?XsOXd1iyLvG2U9DaKQp+985pQRpyAfgb7h/djxH/Mj9rBMgGlRUc0aTnBDC+?=
 =?us-ascii?Q?kEPYBs8RvoKb9EmEfMifPIE1fj7DoNhDCCATl0g0Chv8d4YVk+bt76u1oaCD?=
 =?us-ascii?Q?O2/0Yma8v09KjweOGBXtod0foPF5ZyhnDOb0Yw0cVD3MHeP7IwW9e8miZ1wt?=
 =?us-ascii?Q?I6oJ91NsncWJnWG9amhme3vmHPCF+hIrdsMCUFr6DL/FOj4iWbPdxC5sIgh4?=
 =?us-ascii?Q?KW6w8K4fzwIq59cwoftjuDqzf6yx2rb1TBB7FLBm0JN9kEcMZ/S4f6YhTo0d?=
 =?us-ascii?Q?01hz00p51VJTENWYgqHk6MNlY5EKZevkPrlfydVRvaVL3bG4HRnCtbCW005c?=
 =?us-ascii?Q?n84YXnBrFiQdfJAN1DUlOPqSch2T7Lv8rmRNcgTr9v+dh5zOAgGCSh227CZh?=
 =?us-ascii?Q?R0DTT0sf4rpjwZDOIvyb9FNPiPt/jNlhhR0gD0cH8lTaZCbLpsNVJVA9jWJp?=
 =?us-ascii?Q?FaHOcOodk+2Z7jHxYl3jxj56WKKJXkn+1TJOSMXX6LVDEz/JlJIgZKtX6GjO?=
 =?us-ascii?Q?T0doV6NBUwOx3UpVA2Z/k6c=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba63c83-433f-48b7-36d4-08d9f05af682
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 08:12:52.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkGintu3WaG/O0nCneV/hiLOCJq2LkbS2KH0uRb8d5L+d6p6JOfVkdByuPefflhKh7xmFOAJbQuW6aNjaNuLDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6740
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The wdog on i.MX93 is modified from i.MX8ULP with some changes,
it uses one compatible string, so add i.MX93 support.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
index fb603a20e396..12da179ed6c0 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
@@ -19,6 +19,7 @@ properties:
       - items:
           - const: fsl,imx8ulp-wdt
           - const: fsl,imx7ulp-wdt
+      - const: fsl,imx93-wdt
 
   reg:
     maxItems: 1
-- 
2.25.1

