Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91324D2C54
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiCIJmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiCIJmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:42:10 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50074.outbound.protection.outlook.com [40.107.5.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C862C107082;
        Wed,  9 Mar 2022 01:41:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doSXs0GTze7ZXVb14eIc2sGNZrZXNQp1QlXQKmwlKUpSZFqkjM94Cw6x3NV0JweumrfnQT8F3ZMGPsd37RcRnLCKhGR8SbBpQEc8NWkjoq6HK77K7+Z08AHNUt2WyBqKGvEpddp+SkpoPAGRqe3UMW6Lf0/A1/KnoHyno4727O4IUnZSJbC0XjJNhg1nDUL5N/VKLArEV8n7Oj+R9eMrLDSe95xSAkRViNFm72zfca8OUP6OBKvmFZqEtwYHOTe5wEkZUxpDryUVyDYxIMaTuTtQ9CALnEqJd7rIiMj2w7WtxT9P+QeAh4sxqju+OMrQOEfoVQXnsbqSQKlKPY+cxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExLTEwXgXZgnyy71qgkAc2gC/WZ3/iTeNkvgGN+0f/c=;
 b=TPyFjoE7IYkvkXAXqQ792xnBQGUDxxJdApS2SXm9j8Nh4G/1QT8d//+qkHVBvkv62c48hU6i372HEM5VREDVqiXvT4vVWefjiqOU2bTG4GVeedxd8Muv4z6nSIpDfzSRAjdWJwNDrj9PvsaGYfUu/Bqhvgt1JphgjW68Z74g1cEVEbvvOaMPqE3p1CIuCokhv2D0DWC2vd8O8HfloVxvJYSZyC1bVXQrcfih0PvBEGe0ss3K5hQFVTloWdNdMBxBBpGN5QNwo7cjbzBji/Al/wVw23khLTKrGKq7cs6ub4etGrC1Gr69re5GhKiKlVukoQbgDc5OndEzWebDPHhaMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExLTEwXgXZgnyy71qgkAc2gC/WZ3/iTeNkvgGN+0f/c=;
 b=EFrJP8mvjG+uclhiw6gIoeRWgbd0290V2X8QnB0LCakuD8gTIyDk/YNphY4n4nK3jXUs98A5Ojku0mBgMgPlDlRGBBXR2lauyWR8ZpNoqYCGIlxII1B3KMWolyNM0/z1oeZE1I3QMzxbiQWxflq01evbsxrgJbvz+phEvTHksBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB6043.eurprd04.prod.outlook.com (2603:10a6:10:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 09:41:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 09:41:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/6] dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
Date:   Wed,  9 Mar 2022 18:21:13 +0800
Message-Id: <20220309102118.8131-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220309102118.8131-1-peng.fan@oss.nxp.com>
References: <20220309102118.8131-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38e72da6-01dc-48a8-d94a-08da01b0f03a
X-MS-TrafficTypeDiagnostic: DBBPR04MB6043:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB60436AB6658EEAD5ED0E9DF9C90A9@DBBPR04MB6043.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wA/d4gN1WYbqOCSJKh6DBU4o6ZaYtl0YeUoVPmGCRk276t+sUdBMRgRReVtfMd25tOZKxnL0gSj7JpazVAv05n5w9jtb132x9wKhjIAtkmetRmZN4b9Qe7XmWMW1zLCmROHD/LQOBEdrebkrlQZdh4fo5vzspoS7qSkTJrJehkcHLNrUXQ2WzRNKlmNQLoV5W8/olM0RI/uIsM382XrbGTAGZ2Mi+CbBI9lAyDAvELE6Eyirgg43NqvYkzZa3glltIlv3qjeiV9uit5M+3Oh+4iT7TwFkVhsA5Iu4Ryi3flSetjvjKRokrHLs/GuYuApLvh1/cqLswA0FV0AzkZsL/wLYPJkR8IaLlgS7+r16pL5n1LP6yqCJWu6hNTpdQ4s030gMdqh8XiO6/14uwexMd7Hh7T3Hjt7LO5upOlZjD/x3gQ9eAnKf0M9wwYPomqhgL0lfxqiKXqDv4Ev6Mw3BzwWcCX9+a3PsjM6OhkRvtW2b+UFis/AMcYX5Iv0KeFI6BhaRdDiQ+O1K4qvK42iDyH73Tu/g6B8LdKuQg8bvlc7RojhJ2Abp3tP+aYRsdmxZf8/b/2PWlTdAPjvkvlLI8A2ALts12YKJ7McQuGnj/X9XaVcbHMSIkNmlSRnBNcT8qMc2DPI7eDPpVASw39LR3RTI1Gei4djoFDLYqvuciDqN2ybF6lb0Vk2EIYJl1YjYqTg6EdryjpsvJJgep05kQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(52116002)(66476007)(66556008)(66946007)(6512007)(8676002)(8936002)(7416002)(2906002)(6506007)(4326008)(6666004)(6486002)(38350700002)(38100700002)(5660300002)(498600001)(1076003)(186003)(26005)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ur/dcav8L+v8CRh+0pHtYnCVaGnGOksYKaXRN4oSoYyDcnVT7B1gv8vhggRI?=
 =?us-ascii?Q?xFo6G32S0q9bMN7/oSEede12bZdkPWuWUi5KA1xG0iCAvy/+ataEH5x5VsRS?=
 =?us-ascii?Q?ktZSDk83qHYC7zHtIdfmjUWabebQaL1s9z9+gOHj3tSs5jrEJvGZSaEp2mEV?=
 =?us-ascii?Q?EhnhijSx3X9+NWeB/2Jd/GcHFeI2Xim6/q9ifDhiF0GneZIAwT4baV5Y3hJa?=
 =?us-ascii?Q?9s5P6LEeWB0pjvtEMJKhy8YiHc3XdfVqEa1ClKPHLCxa5AZm6L/wXT/V+OM1?=
 =?us-ascii?Q?Ir1YHlDRts9vrvvuJ2zcy+dIaqHWd+beXDK2XkU1meg7tkY9FZ52BOgm2SP+?=
 =?us-ascii?Q?HzveRSBBa2fNrXhW8YE8XIuXydVxcHujzm/FR0gcOaI+Ef5z3fgBcxm5fHGp?=
 =?us-ascii?Q?xvxdtrKRHf8T5u5a1zPzXb9HmA5MYGECQ3lenrFE3Z6uCQhoXmNvuuSHgYFP?=
 =?us-ascii?Q?2Ve4ePW/ZO/IrFt0Qjk+LmpdUdsVVsqxP8rFMNNitYzYVAGyohO3jDpxzf71?=
 =?us-ascii?Q?2lulp94BHbQYi0MG2Cp6yvX4XtXGwC0zcyFjDP7VpfPweV2YFZL6NUA/JZi8?=
 =?us-ascii?Q?WcIzB5cC2db7LmRmhpTsqwcfaHSFzdE/C1zdep9c8F/no9uX7LXHrCuyml4j?=
 =?us-ascii?Q?ONnDfLaNx1ht3kphXzCJH6gMDFIsl60M1FwHvvTAoy4n+bMifnZy5S+nm9qG?=
 =?us-ascii?Q?TGqaLhI/WaToFh/tpLsUEbLXcNuwzenm7yzSwjcqvyhsJF+ubrAvPlpAmAwh?=
 =?us-ascii?Q?Acft6dnB5hdDMCqD4RqOhs2cWXNY/MOvm9IKREbbYeBQEqI0j/D0zuKB5uXb?=
 =?us-ascii?Q?oWxIZ3WA4SaOe8OLQ2ApTIEp7vZhRVODE8cgmoCH7eg+GSn0DoGmhZnIN1OL?=
 =?us-ascii?Q?IaNNmZN4f6bGTfnYGlBF2DEA98JA366yVITdFWaoyEF+gXLszrGAjn2ZuSpH?=
 =?us-ascii?Q?yNWJLjvlU6eYrhA1CKLNPoyfowPu0wig9cDFy2Fe/dEL7rOA734FOsma26Iu?=
 =?us-ascii?Q?g/kM9IlaZaTWdTj4PfZW6eqJ3tGBuwggnETFUM+okxqOiiGoYipr/8MsacD2?=
 =?us-ascii?Q?zy2UrwKLEa+lW88NmyMbkvoRgn1/GskZtR01ax9gC8H3MAm/G5huYHhVz5JB?=
 =?us-ascii?Q?/2Ouznsj9O7ffdxaqjtbd8rIhOGxPNJEmk7CpzoZPyp4ri4u0UNbhjiYDajR?=
 =?us-ascii?Q?4zfDeXQJ+W0qsBcYpzdWMf4cl8kpuKCCaF8GSEsjISSbwd2QxtG/2bnZGuoq?=
 =?us-ascii?Q?4RfLjGsD8xETOQiUJ33Hp4xH1h4XorOgKQU7wxFMtvQAiOj9HQPcLTQH4IWt?=
 =?us-ascii?Q?gHni8VKI6vLsLEbLzIIztFCq9kyq13jQEuiSSg9xnqtro7yD/uWQQvwEdISA?=
 =?us-ascii?Q?QUZ8c7gZ0oJ7gABGtYsBH0xjU54VACa/3D2HapU201q3TllMe8DsbDOW7w+Y?=
 =?us-ascii?Q?JLdUCpRBd/P8qW/n564NsBCacpfLW0qWdJLxCU6Q4okk4SBED36WpcC0pC4I?=
 =?us-ascii?Q?1D0zDy3fsb/8dmKSJfK8t8HXYAq0hWEu07UwQ2xzQ5pXd+XzbxdmuR8o9lZO?=
 =?us-ascii?Q?iCmvlxWNWBeSQBXm2kW6kyGkx/zuWIrAwwJIxLc0BAfXeJlOed/m8RkUl9Zk?=
 =?us-ascii?Q?nGSXM7kp+TS23y+FajDlBjE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e72da6-01dc-48a8-d94a-08da01b0f03a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 09:41:08.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Op2EpQ2j7p9d6dEGadcWXuAvgt5wXvjahWOtKH2hDpznrsPQzYk9yWYRntCkJjPlkikvrW9Uz4/tQPpwHJzNrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6043
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8QXP compatible

Add a new property rsrc-id(resource id) for SoC which supports
SCFW(System Controller Firmware). SCFW manages resources using resource
id, here the rsrc-id is used to check whether remote process is under
control of Linux or not.

To i.MX8QM/QXP, when M4 is in the same hardware partition with Cortex-A
cores, need power up M4 through SCFW, then M4 could start. So introduce
power-domains property.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/remoteproc/fsl,imx-rproc.yaml        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
index fc16d903353e..f25c203dd2f9 100644
--- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
@@ -19,6 +19,7 @@ properties:
       - fsl,imx8mm-cm4
       - fsl,imx8mn-cm7
       - fsl,imx8mp-cm7
+      - fsl,imx8qxp-cm4
       - fsl,imx8ulp-cm33
       - fsl,imx7d-cm4
       - fsl,imx7ulp-cm4
@@ -27,6 +28,11 @@ properties:
   clocks:
     maxItems: 1
 
+  entry:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Specify cpu entry address for SCU enabled processor.
+
   syscon:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -59,6 +65,15 @@ properties:
       Indicate whether need to load the default firmware and start the remote
       processor automatically.
 
+  power-domains:
+    maxItems: 8
+
+  rsrc-id:
+    description:
+      This property is to specify the resource id of the remote processor in SoC
+      which supports SCFW
+    maxItems: 1
+
 required:
   - compatible
 
-- 
2.30.0

