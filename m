Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8476C57ED34
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbiGWJm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbiGWJmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:42:20 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60086.outbound.protection.outlook.com [40.107.6.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2722C32EF8;
        Sat, 23 Jul 2022 02:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpH06qX/igbA49qBu2bztHH/r3HfGtCC6vebbE7X5P9RfeJZahimSklYlsqo1wKPtRywu01hyAk07NMu9d4iIm0it9MGwe6h38Jd7z/204uF5wgyPOz3ONaWYFIcbfRDZ0qEAwYs6pj35YqN+QQv566KUDgw9+bhqY+nlmqYGYFW+l1b+gP8PgnkqvgDXKpCidZZ2BcJK7g4jH19T85je867xy/uSvMWc9wdOVpMHLkm0X4dv7S6KAWiCB70Uz+MvTWlXo8OK7rqR6TArNZQghrwnWaBwNZcwFKsifM9nOz8Y2EKgUf4avrV7X0MAVMTEV9/6e651j3CybAv48214g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnbEuBElwu2DfdoLm5hP4usyrjpNNqWuBIFUDPg+F90=;
 b=ORSlWJ3JG129oATkTJFRpbh6CWsIIIFcN/0mw4fCRqk4QK7taEdB9nmadAyfgcpx0C8NpR9cSEL3nMAxU08WcHCo+vzpVq3zqUQJ+bCb6CiMks/yitCJylUHWxHuxkcZ08gIHB8KY2bJCqQumAuCPVeqhZ8k8Zlu0mtPUSERVnmooanov7zr2yyqLuEIkOJbSumR2SKwYtLroQUGdazMhLAWzkAAdnWfnVz9yKwa0SkI2qyDxmJF6RK5wHhhrLBQ+Q8vxNHKxaccrK0DNzTIeW4Hguyi3q9LBnx1FUAhmKqozxjadS9WqJlDOuJiPWskkQHFZxrLr8wrrnXk6OWy5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnbEuBElwu2DfdoLm5hP4usyrjpNNqWuBIFUDPg+F90=;
 b=E01eCL/jNFBv7QeOLIiSHyorTIfWNPaQ+NyltqFYlFV+NCnOf/vzYtERw2145ONyQevYjnin3F090PwE0UCPYrSyYpQXmWRGxNIecAAAXDUSk7WvHSJqxO5J3thz/7CBPkRw2tEVNcSb8s9SSVy1WqtmrkrlnXQpUW6ZF1jN7F4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3685.eurprd04.prod.outlook.com (2603:10a6:209:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Sat, 23 Jul
 2022 09:42:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Sat, 23 Jul 2022
 09:42:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com,
        festevam@gmail.com, ping.bai@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/9] dt-bindings: pinctrl: imx8mp: use minItems for fsl,pins
Date:   Sat, 23 Jul 2022 17:43:30 +0800
Message-Id: <20220723094335.3577048-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
References: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6d07568-bd5b-4c68-8bd8-08da6c8f9e65
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3685:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WO4xEk6K1j/z6tNzofdjdr/UmCm0aFBNG+d+z/vlhYZK2vY1EAEl/VxQ0NUYlGY865O7lT0m6C3yuIP0bAtLb4Pajq4TD7mgw8wh0GAbPFxc3YfONyrhAncO74h8WJnCineC+AWWV2ytuBo9OBAdBCZRlYbOvLoA1oxNl3Dob+2qDAJdbwR+Y4uGgGCrG1yxM+qsZxVSHdRRq+tsk141JI3rguP23V7QTmjk+n9c1JLGWZtTh39Jd4DheiOnccsHx4ZZf93qnen+kJDxHjf8eFWJ4SO4n1g84RJN74qciD/gqRTdpsm9JPnd1I35lrQlXNMCX3TtxJvivuP1x1Ei6l1kFrM0d1I7H+s2IgS1XYFzybiDZn4n61INcJmmhgpFFnGvYFni6NIS+nd3Y4bPzO2XyONtsqpVGn/oLxI0DEmOdaLNjFf6n9hwzNo7JUVjX4sY7ynNvpKdXbqnfQ5oiIqfSGey3lOA9ZUeXUmuEuv22vEJaZNAQrUiFC/YxuUmqP48WCEEBw5obySzACLRMQ2dM5T0M5esVnxkSUqV9yFEynn4AG87LpUpBK7DaeN89V2lms/VD5NKrrfJ86uH1iRz7IHajy3qQ6lQiX8yC94svDTVgdR1ZFEJTAtWxBZVa0qGQw1FvmAp8mUtNax6IKZBED6PX9gOc/yKIYIrZkrdc+X2RWqVHkaZN6WYG3cDsG9ZbrafMwauRAf1RUQwCxOKfP6Zi8i1Fx13tYUzvoYvqR4ipTFAJdbtn59RBUjIf/doxtICAw7bMrTbCoKgIYzH7BqYjnSwsoFSj4DwMeaWvGFFfo4rId9o9Vi3VHjKBR1ZbszawwI580dah3nkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(316002)(5660300002)(66476007)(4326008)(8936002)(6506007)(7416002)(6512007)(186003)(2906002)(66946007)(66556008)(8676002)(86362001)(52116002)(4744005)(38100700002)(38350700002)(478600001)(6666004)(1076003)(6486002)(26005)(41300700001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AwhDyWMXQX+2+jBUmLEqj9G1jFBmAkGnbO31c7ZwYSo4et8+oQthUB/0MSA4?=
 =?us-ascii?Q?iu1tOIpAvp1AXlUZHwox4ba4vLEfr1HBul7bswOHwqSFczeYAUdxf81Cwi5w?=
 =?us-ascii?Q?HeMcbijUab1m5qFJOF4qPH86NhZbrN0SdtiJ4Gvo8CwilvjN1ia17mwDKuo/?=
 =?us-ascii?Q?QnIwpjKKITWRVUpOAp5ZKIoi/XcB6+hfl2a5cRt5BGTfF1ldJKM/YPXjbMlP?=
 =?us-ascii?Q?OPBK3gMh+wJZLiy5UGm1ND5Twvk+hxsjJaEDzaAc+KfdbG3o+O4gtmEgyyKT?=
 =?us-ascii?Q?sPFTxki/V60MA+7rE/xLOS9F6kijtO7OzVmPcl8ldT8rv7eiJPWq6+AjMvky?=
 =?us-ascii?Q?Bz05j9j5Jrk00tzoaEaYln584DnrbIQghfhs6UhygSdEKJ+vY9Ca8IUQQrs/?=
 =?us-ascii?Q?KqY0T2G+Y+mSDoRlsFa/fLOqPsNKOASIb2h+enHem41+EHWkpf9uURxQD41Z?=
 =?us-ascii?Q?zqFLBv5GnAg3IFuQC5+bIBVx3Ac2uPPXg6ZeW/8K/iRjpRJKbjolMubBbWXs?=
 =?us-ascii?Q?mWYpj/3h2Z2oCisqfL3rCKoHROl/Hat+xV3YlsGzgD2Xab6Gcf9Ol1Luhi4b?=
 =?us-ascii?Q?LUNhGEs+HmJtEPo4rk2nD2/yXS4xid4nPRXfZ75f0Fh5T6eqlb/fLGelRxOA?=
 =?us-ascii?Q?UNYw3Vobkqw7cEclnjc0M6sfSC5VCelfJuwWuE7f7zdW5mTs4ACXiEcPNLcQ?=
 =?us-ascii?Q?tatO9PwtLiO8gXsr5s2kt7uQQrj+SLT977mme7fdaH2UMTb9/o1KjwTj/pI8?=
 =?us-ascii?Q?KPFGiGIhDKcwsz7o1TaBwWNNl8bH3ARFIjx1N3Lcfe9coi4AFjA7tiRNUyBA?=
 =?us-ascii?Q?RJbahcCKNTqNad2YSIEMuH4vkX+NDRrz/uKazCBFlK0BDjJ4qFsNKmW1d7pQ?=
 =?us-ascii?Q?8ndclDYldFoP8GOPicVKxHicsBN622yPq0coJRWSdWF7fWa7GdXGwvOkIryg?=
 =?us-ascii?Q?dTpoctGCpkHMB132vbnhX/qrOdBXYvdV66yySuyXAc59ueI/r792ZiesNjkj?=
 =?us-ascii?Q?XxjJcNVW5WgOPBqpgJeqf3aeHlgweBjtqlA3P8wH577sPARKLwt1ucCAwVK3?=
 =?us-ascii?Q?O2gjbezcRqwIouqnT9MMdPm+H54RYE2+8MGuyEQM+lSWlRBYg1x0AXmklGIx?=
 =?us-ascii?Q?3Rbtf+r/g/UZ++KcZ1F1EWFZRj71jKTmXeQU6o+f8UEd1KIq+CD+f12wGxKb?=
 =?us-ascii?Q?yU6oz0ZB09IyOjV0U/94nNK2llMl1Tw8GooW6e6HQB/SQI1FKFTdxRga0L+2?=
 =?us-ascii?Q?ISmo9m5HG78l7dkhQdxf35qZ+vFZXaCrdvFVK3/QuqMjI77M5MwHyNP6mNje?=
 =?us-ascii?Q?DLeJx1wyPeB27pvBxhPyDG6OeAx9dsTbOGmc2atkAxv13dWNgQMZqEwQZP3o?=
 =?us-ascii?Q?FT2T6MQHDU9WnFyB/40keiFh4bx9S7MQXUqE7XZkFm8HIYnsTXuFZMUkiO5z?=
 =?us-ascii?Q?ARLfnYaY/mbsJsatiQRqEo4fbjv1vgGR8TfjhhIKJMFlkzYKOiVPYYjbtFww?=
 =?us-ascii?Q?ziE1bV6aWpWe8V4CWQCtENSdRJDEa9t+4rsM/RJdwyEgkkIEMEtd6IhDxEtO?=
 =?us-ascii?Q?hUmDXCDK6GQzpEAL7EIyPa+MSRFHDJTaqLDrgQet?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d07568-bd5b-4c68-8bd8-08da6c8f9e65
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 09:42:12.3048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwESYBBJB6wetIrcPDYkpfJJijOoZ17yqz78ukpwI0/hWeEbqUf4ODw9w5knDxXaej57fCm9KGa7qPvdLtV4Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3685
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use minItems for fsl,pins

Fixes: 61bccd918c83 ("dt-bindings: pinctrl: imx8mp: Replace the uint32-array with uint32-matrix")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml
index 4eed3a4e153a..d489e1c8d5a0 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml
@@ -52,6 +52,7 @@ patternProperties:
                 "input_val" indicates the select input value to be applied.
             - description: |
                 "pad_setting" indicates the pad configuration value to be applied.
+          minItems: 1
 
     required:
       - fsl,pins
-- 
2.25.1

