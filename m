Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD6354DBA3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359366AbiFPHb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiFPHbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:31:51 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5AB50015;
        Thu, 16 Jun 2022 00:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmNTSUZd4qacUCWW+rq0jd4YtIaMYgNegPBpMank4xOQ+nefJGE2pvlDZ0AK/RVgVqAgOXb0ZM4Y9JPKeAdk2NHJbywWCyqUD8tEaRznBZHrqtbq3cFF+ZpadQgOVJ4EE3PNr3CRDuBrnCy1sbUUxHuM4IsIOwfGGYW1/zJRb0wjf0EQDAF9/7KTafQUG/eCvnV07CCJnZnYU9mOJXXHCp1I/VWi7BXIdev4Z4z62yTUjh5MYqsAOSXKcIifqhHdrS587onyfvdvx/Awm9Kg2QCFdCiCZmzE9jbsJuHYg34fiazrlf/ZFLCigyakY31gfUvu9AVc9eAdyPt7PcGi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPFhAUauzzpD4pDmJdZ1EpeEWmLCVCxW9wI9YINMrUU=;
 b=Z0xQrw7wEzv6owh74l+QxUrnZr6LP7Io3PAbE0gr+NOtlvi6qZfDROrGjPZmAsGi2Ojom/EL8nJMJmOn2yMhXj3bLgUffn8rJwSqzKiXuwZiSg6rrWHXybkkvnFj2Tx81TTKaLM6564alRlYmc1PiD2p8UqJcOLldB6KblKXHBAudAmw48+EogOpOvmUHFRr39Atehtj47/bxhqA6xQtAuiWjhVVSDSQZe5MsrL8eeEjuxqIcaYYqxyWaPxyk/BDSmL6/doTFbOCWJl62Xd4fP+me+pEW1fZ1RJ5zjEeG00ySxbUis0cxaFlZnKQcZaa0MdqrSqOgENN+rMZyYcJRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPFhAUauzzpD4pDmJdZ1EpeEWmLCVCxW9wI9YINMrUU=;
 b=Ye7HG+6GNtiomCuZNSOyQX6L9hVCePxsubj7le7WdKSikT+4MMArcVM6ZYfGWVN8lW/JpfnW5HvkL3RE/3R6xU06Wf7fZ/lx1LsVkopwlT55aA/l2n6UIRP/S+59YomUlcdPOPDiYUI06SlBhj6WQ1f6iMsBqzHc7YsUpn07MI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB4850.eurprd04.prod.outlook.com (2603:10a6:208:c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 07:31:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:31:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/9] dt-bindings: interconnect: imx8m: Add bindings for imx8mp noc
Date:   Thu, 16 Jun 2022 15:33:12 +0800
Message-Id: <20220616073320.2203000-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
References: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e99e3f2e-2cd2-4e90-b3a5-08da4f6a44fa
X-MS-TrafficTypeDiagnostic: AM0PR04MB4850:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB485001A2283828F02426FCC8C9AC9@AM0PR04MB4850.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7zGoDKoLJ3buJrju8lv0cY+QlXobx0S8pZ39iGNCkgLrrwOnhntslnwJseCAWpq9ctt28xEyzfJpUSTV8fWZ021R08i9gtFogYnQ+865+/myczBBsVlrJiAOvh3cTduNQqjXSBrYuRmcEgdQGjC1auUHvF2YeHqAcW3ZFBzHel8vByqxq3yJhMCJ2xz+sUPk1iXoYoVmuxX0pYPO4+jeYbtfcyZb/pCULsQeHbY3O7TCKfn1AdYTLVPFCipNNSIvt3enpfPMlIWi4lukj5ulDMmUMP0KpvaYRVJVEDHtQoNstimW4PoMFSARyblvs2HfLBu4a8tFnbqyn65YnnPLbWhJHmKVkmGla/dxxuM4DCeJQf5RE6S5Afs7fq7D1K9y4p1svxB93lyoyjW7c+eP4WuDCSbYfOZRXVMeanjKR5j4rlWBnH+/rjGJrUHoRZ3SlNZHc3NKhv6r3P5u8CE9xXx+nDEyWdKdXTj9TEM9Kej83O5SK2gctuw3a+EzkfPh7iFC/wiU7znBGRVq2QiU+cBkR3vUP75Ginb6F2/B+5kww1sGyjwmSLPnnKrlGaNl+84gvgtUm/6IGF9Bx+zGxRDtc5LMv/I8P0ZRjVpMfq3xlJlLwx6ekT9KRL/n2Cj3vrdzDWuKFxpqj/m7etDsFcadlvtLwDrc0vLn8O7SvLmBIgp8BVdAkE/3GR43gtaBSVygaJ2b7C6PEKvApOMytqbMu+PCKXkWZ3bZO10Kegs/RpMq/Rsq6EQwuZNm+3o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(66476007)(26005)(52116002)(6506007)(4326008)(66946007)(6512007)(2906002)(66556008)(2616005)(86362001)(6666004)(8936002)(38350700002)(316002)(38100700002)(8676002)(508600001)(7416002)(6486002)(4744005)(1076003)(186003)(83380400001)(921005)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D0i917MQ1UW1RVruX6kb7hHAJJp2dyLUUQIjYuGbMS4Slw7mY6wy/zUPwEtB?=
 =?us-ascii?Q?1rglhZ1y2tK8ZSi1PXQeEqDi9P2hA/Hhzxz5H37Zv/v493uF12PXl5gNRSLI?=
 =?us-ascii?Q?vut5wamdEhD84tvwnrP4gXhSJwEJXqVAYQJ9ufX+kLJx/fmZaf8FhOaU0wXE?=
 =?us-ascii?Q?9ZrDAwqbqAOpjVd+INui0EphzyQ1vOXc0Vh0LE6F4MLHVlpceuJpoN9fBXiw?=
 =?us-ascii?Q?1j3m5sBkTPu/bRkXCY9ptuhPl14E5RxyYA10NYmqfijVbCaZa4Y1SMrnJy/F?=
 =?us-ascii?Q?4jrygKVz/TEdoDEcApQnwwhTYTR23N3qAhC7CFZ0KffnZapp5ry+ae0v2r/0?=
 =?us-ascii?Q?X4zG8iVo6m2uFSGjy54qYbxU0IUd3M5xjq/+/kS0ggsJxU0ZlG54UnrA3XbY?=
 =?us-ascii?Q?hSdI0DmcE5OVWCnU3xLU4MorvME+uvbL06w9GIMVHAcAQaDNEgY4rfco34T/?=
 =?us-ascii?Q?J/FqbQKG/aAiUDhq6e/ZRWA9nAEkhfRqUA/0vwTwREMlanPNq7odWWd9XsOo?=
 =?us-ascii?Q?1PjOZkMNQtNWhJKCeLy3VpdVQCuBI8JB7HU9SzRR6UL5aE6LDskO3eunWXlo?=
 =?us-ascii?Q?fw/Oh9cjrBrf0K2Uun74Y9LvyDtLQwJ4Too+Gt4ouN+nu//2BgGGvmkUBK+o?=
 =?us-ascii?Q?nT9CX5KqqbtN8KFBC/HiYPXzsE58cH3YvNP9KhXKRpSyx6GGLudXaL5NFtGr?=
 =?us-ascii?Q?EOeRUqLiQBPuTCqjm+wP8Sh/ADCGLmB4/PaAfAwZ89sN9rtT7q/XpNf6hPlX?=
 =?us-ascii?Q?tW1t6O7UJHXkDu6kem8Wkht5/ypWZyDE1gVMi+ZNBCRXqb2hi13INfSXY2Im?=
 =?us-ascii?Q?MkxshEn9ah14M0FGmMumM7qeI59KTooKkvb8VnXUF3XQ/As8EH7fnuDriTnc?=
 =?us-ascii?Q?i3uhWgI7VLARGX9n5Ap3SD+IEmom4XKGFMc5suiCslYlAWdbBuOZIQyqKJ/V?=
 =?us-ascii?Q?h7dyb8CZhHg9keSlfSrygo7hJOeGcPsgQ/yEHUaHUyAty5uPXh0gl0KEV06S?=
 =?us-ascii?Q?WrlvzvSFZOq1RGOY986N8RdXPHiv5NDScr1GQSdg+GEwGTCzJSU41IsWWwyv?=
 =?us-ascii?Q?SX8JhRKpo3W5Hk1c2jW8jHMCIlkfUwc8Pq0Vv6kXm2mvPEFs5jug5k8ZZKzb?=
 =?us-ascii?Q?9yxQfO9P7dg5jHK/17gqwvNNhGtyYl805H/3hkHl2Oerj6dapbjAUYWWgMBC?=
 =?us-ascii?Q?u382CFLuXwu6P3Q5PtFF8L2zg9XwGu8lsmzQtjBU56qJYcolSdmHxdXRDJiP?=
 =?us-ascii?Q?9xqBkjCvRh29LDCvOjicm9ITsvKN7KQUGLloQ57hnF596qjiXyHy46VhCB6V?=
 =?us-ascii?Q?H7hJG/p8qL3Pn6/IIB5PMONHcAfoC+QlBdIz2jMPYT9rT8UExhW6niPHYkmv?=
 =?us-ascii?Q?PXLF0CBvhRf14pPpLBvA/eLHPIVqaxLtZpoNo0x8YruQ+6IdNRnVngh4LnA9?=
 =?us-ascii?Q?114JxjatA4Ua5h0L4+2xvl6aqLo2Nyd+JHRUPH9MaCuUGtyfdrsSnsVsityL?=
 =?us-ascii?Q?ZprthzvssEiRNvfS6FJ7+aCTeZJX5lb38v4bstgfaC7aPznDZcTsmB6isstM?=
 =?us-ascii?Q?FKWPAQPV3tp4QvwU4BjBLEvmJWYmQT5odQwZ70otnO/kZ+Jqz7tDzB44JCOd?=
 =?us-ascii?Q?xOeGItClTi6TENjgL1y3zF5G4mRyrWyJKtoMdbm63KdlP3yIgPMGgk+G5bZP?=
 =?us-ascii?Q?TPyj9v+TYcKI4w9tucpvWX2KF4Tvl+o6io7dwQNO/ShhIK1dmhm931djiVh3?=
 =?us-ascii?Q?cLYnK2RS7Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99e3f2e-2cd2-4e90-b3a5-08da4f6a44fa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:31:47.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WGNuchLRdjHPLFpR1+pFUC73qPg6VIUAHFS4OdZBWLaVCHsZCMOR/oYzAf9ckKwmLjUCQfjfdJcFe1F/xBwdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4850
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP features same NoC/NIC as i.MX8MM/N/Q, and use two compatible
strings.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml     | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
index b8204ed22dd5..09c8948b5e25 100644
--- a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
+++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
@@ -26,14 +26,16 @@ properties:
     oneOf:
       - items:
           - enum:
-              - fsl,imx8mn-nic
               - fsl,imx8mm-nic
+              - fsl,imx8mn-nic
+              - fsl,imx8mp-nic
               - fsl,imx8mq-nic
           - const: fsl,imx8m-nic
       - items:
           - enum:
-              - fsl,imx8mn-noc
               - fsl,imx8mm-noc
+              - fsl,imx8mn-noc
+              - fsl,imx8mp-noc
               - fsl,imx8mq-noc
           - const: fsl,imx8m-noc
       - const: fsl,imx8m-nic
-- 
2.25.1

