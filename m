Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664694B65B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiBOIQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:16:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiBOIQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:16:06 -0500
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00076.outbound.protection.outlook.com [40.107.0.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1A76D84E;
        Tue, 15 Feb 2022 00:15:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVvCkGguuCeDMYVvk3cq9oL7G5lHk/5oqWzLxgg6ICOP/k3ZYEWh6bjOVeHQfoJ2TBX9eN4H1cFdC8vkoY8SrAcfaiDwyoCQ3OH5JOoNEpqDm2qMZN4TaY6fMSdqe7pxb3XrPadfOM/9YoKozGhiZ+KxSJfdxOfik+opVb/NMZ7LRBSJQjvg7iyjZ44MFqwBymS2t6ACK+dgDAQ+tOJqZb8C2QnPksHLYU7jOMpDxvEfO665SS9u9+F8/w9onhUU4fBg9hyPj2LQYROVnl5FJcmMfV2AKxplJgf+Gy3n7C3aMiXAGmEQ8sFhoPkU7GtPkFSD0SMDtiQJo56oDZHZqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eIDbczcjXk34wyXQhC1s4jlWwXlQCbex+bjIBplkGA=;
 b=EzpfEuxHH6mlruk7cPiRCA+RjHnChjKghgimywabC+zZMyhpxgaPzpKVkWFj9LH6zKQvhhLNPysakLbZ8jOwihq/9Xhey7Q1vQHsDJlEj49v1BQSBUtrzKG4td3jP4RLbWH+m2LYKKQJHYTF3Tc2sawTRoVQUcPhSjrUUsH5u9fz4SUbY6iAhOBauLONa3foP9mg6FVV5u+b8gcCV1DAMrXj2JAlfEvsCxXKFY6yeABNWmSQknjXNJYa69yZ3obSZez8F8rhfXLvRTOCsopqDCeyrCTvnYRfCnW8cNpd85h1sb673athghtEBx8foIloLxvPHgrKKHeCSiyVVDEm6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eIDbczcjXk34wyXQhC1s4jlWwXlQCbex+bjIBplkGA=;
 b=YyYTCaCF6avgK25ImOKLzvptsv1XMc8uNph/z4BALCbUZE9Vzp7Ex13FHCi5NCwszMQOCFRBII9rpwaOobnOIGClzjqiBRrz4NeGGgHH6ED3JyEHwrGdOw9WwWvc1QeghgYCEp9JkYMZAGxV4ixD6c6cLSbHLjji3dZp7BiItew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6740.eurprd04.prod.outlook.com (2603:10a6:208:16b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 08:15:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 08:15:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, shawnguo@kernel.org,
        kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: mmc: imx-esdhc: Add imx93 compatible string
Date:   Tue, 15 Feb 2022 16:15:02 +0800
Message-Id: <20220215081502.789067-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca5d2be7-37ff-4189-69ce-08d9f05b62de
X-MS-TrafficTypeDiagnostic: AM0PR04MB6740:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB674046F92385613EE8A9A6D5C9349@AM0PR04MB6740.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FLskQhY+A9x5QSSatOgw1pki9QCi/6bydcOf4dvTxc9uftB14U0pOo2kv1Qv78fKV7iTu7v4uJbXKFmrLe45qQ0GYEQiVakM3kroEV5RqwR40K9OvaP6Q2layxlOEfdPDf8hKPc1iWSuKik6UkenuiXVEeFkyJqnpMDrKXqyYdpt6auAfUxAEjdn8gOanhQYd+WO7TNMgnQ0xbakffa34zxaHe1J8Pp2PgmR5HPb3OU7ei/01Q9F9oVl3uFFawafp6jxYnNhEKG92jogjBla3xsy2WJvO1kwKP4SLGQ4IBu2YZDZMVlO9zYpmkJn8/zC/fvCSbveZfZ6iRF+OgfhuWlHxbLdUvqO1K+gCgztpFz//dlvztGVO8aFzauHe4DND8Cs6ahyHk1KpWqHiYG9Hhx97llA1HSkPyHU13mTIYstXoiNNTpDBkOUTP1nbAuOJ7AqNL10+Y2Ky65us5IjqWAHIdFXfgWSGCLUBYTW5ogU1uhRs6ItExqPx0LPBpIvL4rsDt0rn0opp5P67BnpA75BdTlSGOYp6Z2wc+f75+s/wA1NAeE4MULcqi/Wc0LoLEyGFSFWqAFCoRFepLZ205sUwGMgyIacGj9l4uZA4JjqM6U+sA99i5bTI+dVONpAdTn1me6ICweASFbpWfBHHbcJQ2ZPgeveDo3KC3r5IS9DTMtpUXAY3esKTH7/cPiyHiXbH7hokcw32y2CywAGNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(186003)(508600001)(38100700002)(38350700002)(6486002)(26005)(66946007)(1076003)(8936002)(8676002)(4326008)(66476007)(66556008)(86362001)(2906002)(6512007)(6666004)(4744005)(5660300002)(2616005)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GMw1R7F83/tsKNCG7Nwe7QQiCXWBKM8Z0yMp9rDuobWUAdWDA+7zh6KhBPwq?=
 =?us-ascii?Q?i2QE7sOxWsPuxdAb3b8TCJMUkHq6MhDeetlBUNDrl1Fo4g2LKFkdMq0/meGY?=
 =?us-ascii?Q?cbcYqH8Fp0/0p6xKriEM0n8rMyLHh/KtF5vy0VBYmIDM0PaXUbrcwdI5rCip?=
 =?us-ascii?Q?5z+pAhAaCZDM55wComLD9r//eTF13QJYaXZYDaclZKQ/qjxeEyYSxZOIlgfJ?=
 =?us-ascii?Q?YQYfWC4sB6vZryZksPs4G6XHsDwARQoyv7arQvrJTWQuYsmFhQ39b1gFDONh?=
 =?us-ascii?Q?KPP+8E/VckYprR6urQRZQ1ho64FX1zM/pz7fOCiVdt6tXtOW9qb7o384ozfw?=
 =?us-ascii?Q?XJ4XeuQ+jvs/jsjUHzxfFRh2n8aj5mLUPTIFV/G0wOUcFUqPQ5QoJGTQd/e4?=
 =?us-ascii?Q?x5qReBMWi797BUgbGCgezoeaFkUrxHFloU2UQPO7ONUUTxonVeYv35HkiT7Z?=
 =?us-ascii?Q?NWOAQJF0aW4UCiMPjhT0vkjja3MF7t7H4dUqPzNzluQDwGoDBSNccVLOgYZl?=
 =?us-ascii?Q?jS7wBSdDQrdrUTQ6GVjDYaggVNyOJitF1XwAq2sLzk3aldBYAYbo3JwjghSw?=
 =?us-ascii?Q?bqtGiB+LSJOyGzttiD7J91NYWM9dbGvZhWe9J6LNCYDIRKTU2lxeUP5JKim6?=
 =?us-ascii?Q?3ZMPW9PwLCUt9pPutBZFoIHc+LtZuIs0xouBYQAm/0aiF3pUu4jjw94JGR7S?=
 =?us-ascii?Q?0yliduDMqOBeHjgyMfU+8QLo/cHI1tpeoyNfB6BWB5vGdXs630Q2b1TBfay1?=
 =?us-ascii?Q?16TCszAsyhT/MrLwQeZvEOeO29Ru3JQTUqSWqlUS1GzREgakD0uyeb6D7beA?=
 =?us-ascii?Q?nFiEw+q6G1nF5wD25SgukRCarm0KfYG0Tmvg6EBOnT42dk9XvSXw7eatkHv2?=
 =?us-ascii?Q?kKH/qT8I1aMl89Nm2IGSUJqRDFjpLkDhk/t3d7DeuAELwulN3GwZ9M3nzAZB?=
 =?us-ascii?Q?szNtd/pEs+eG/N/Co3FUw52txNdoldxRehWNezBJXmMdSmw+A7l2fNZQXmw6?=
 =?us-ascii?Q?x+AKbYel7na4QX15gCVMJShQu4amFk4bG1dhIpBd7C5AK+dB/REW7WO6mcPO?=
 =?us-ascii?Q?4RUks8KKvQa2MRmlBI5agSUl+whEjxaRgk5j2drER/rWoxuZr7gB/OYk7pmw?=
 =?us-ascii?Q?D9vA8A3utpyXrGYeEVuTvOhjSn9c2SqgTk6w0Q4/mGdOAHy4vHS00WZZ8fbW?=
 =?us-ascii?Q?AI7NkHzALu6/hQ/gkNEEjvIIuVTjmt9MPsuLv0VzByx+okffLeFqJMTEDNsx?=
 =?us-ascii?Q?/roHJnM5w2dFoWwZbCtmuiDyK2H3khdrUH3/KXxf9OWIdtmLMslDbas4hZvn?=
 =?us-ascii?Q?6xDfkgmmC4YiGvFRuiMs+wMgnBA9alIitmNdGKHjo0s6UtZ+LzBK9R0CgXK5?=
 =?us-ascii?Q?r1KAbVKyKNC0VIX49dxLtsqvkVrYSLM0wqbrPszY0VlBt5QmrepfiKlHMyo6?=
 =?us-ascii?Q?R7n/OFVfRpobXhstwszbfE/jA4U+R7JmJIHsZ+G/vE/vU4BAXCQBygRu8TyI?=
 =?us-ascii?Q?cdnM1oboFRm8fJMEgZLkyTtGEoKz5T6fJ8ye8Z2WVZYszBhrav3H+Bo2wvZk?=
 =?us-ascii?Q?4nlaPoO0t5HNP0KCHkD0V/FQefR4mzAWFNH5/K77KpVDYNU6oM3f/i7TZVlW?=
 =?us-ascii?Q?hdW03qMbw4oxJSJ+esuqET8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5d2be7-37ff-4189-69ce-08d9f05b62de
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 08:15:54.4037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXBH547ZAgJ4c+idI6wbBEybad+PrRbARrWKYGxeOlJCz/d+JFiSSsgEVjq0nxFy2aXEi49YfnO8lQTG+sJI+Q==
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

Add i.MX93 compatible string, it uses two compatible strings.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 17acbc665f5a..7dbbcae9485c 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -47,6 +47,7 @@ properties:
           - const: fsl,imx7d-usdhc
       - items:
           - enum:
+              - fsl,imx93-usdhc
               - fsl,imx8ulp-usdhc
           - const: fsl,imx8mm-usdhc
 
-- 
2.25.1

