Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4D84D2C53
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiCIJmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiCIJmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:42:15 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50085.outbound.protection.outlook.com [40.107.5.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46BC10708C;
        Wed,  9 Mar 2022 01:41:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KU18m2Z33aHwjUx6hZXf8mhARa4qnB5nYuurRa3qWOi7+gAffy8mHef65pehO9xPJbHkN6l4iSjkmQ3+JuflYRObeYbkCJlXuM+HEqsnwQ+ffOY2cKzBpRBzlzG4wDniPasMj5MugcHRaVzzxuvpMvlBOCPxxvQn8U18nctOYclWMcYZ5QT50cSCQ0n9PubeJbHw01VEXndoTSL+vKJ8Yt7jSUt5xqKKCyv9vgOvDs2aDznTNLDvEsBPvIA3xa7rGnL4HCigLsFVdXY5ztiqWrAUbREMXMtOeymBgTtuIrKdRH1tSj5hKvHPAk9S5cLAOQcCfzkalgFwyxL5tU5/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/8yEkjUJ9cM9HYZi+vzoG+zthQuHeqTOJqAMHsBTPI=;
 b=LC8ZTKrGH8SMPk7NFw9FgslyPuRfxmN1YiPmI6uDjEPltQlhtiI6Rmk/f5mCCEZmh4GWFx25AyEq1xONlyZAtgYZNJJIbqgBO+rYrHj9uAIh0VF84EHFK4IneMB1DzItkuvt0p5/ZvsuR6HfAwRXqFYdRrxuSlIj5JOXPS6hNft5K801v+19Sw9UcgTFTcaxpIAsnyDCLFEAGX5nq+nrtIhGICGjVPriktb5QDcbLX+/gL8JH70BUCf5gHx+yU0tOeo+Lepo4nNct6ZIaVeogR5H16V+oi1JPonGcY8P4pMueUsoxGSlEb6XP+Sg2M/+YCoXFTaKAA3Fb7vGpIymnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/8yEkjUJ9cM9HYZi+vzoG+zthQuHeqTOJqAMHsBTPI=;
 b=atMVmtgwyOHqJUj2nZ9FIIdTYFNbtd5s7JhEHouUHXD7o9Zeb7JVt/UZp4swRlWKRaT8jwgRYeqfP4NQaPw/XbpAHTjeJrVGZlM8QxijjS/a+4RulAW4/hdf0ilRzXENqFKo6ZmHAQATiyfjx3G2ZyqUBUxUExO78cqDtlFRrUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB6043.eurprd04.prod.outlook.com (2603:10a6:10:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 09:41:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 09:41:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/6] dt-bindings: remoteproc: imx_rproc: support i.MX8QM
Date:   Wed,  9 Mar 2022 18:21:14 +0800
Message-Id: <20220309102118.8131-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ae60381e-e0ba-44f9-d00f-08da01b0f303
X-MS-TrafficTypeDiagnostic: DBBPR04MB6043:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB604355300B0478188171B1D7C90A9@DBBPR04MB6043.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wda/5QNK2BU9OhOcyLSvSpdPkN4uS3IsmIaLdFDkdb046HjJe1yDXseefSZx+6hVVDciwlvqmGE5AOflndkO84YMEVziSOqtp5KF/xExwBOojC9a+dfnUhh8p8rzJInRjG1qsuJo25G1ooil2GG/V0UX0NvTGFDTfOiAhsNdi7cIgX5M8Gp7aVQ9jnjIHTHixGH7SOIJ5sP4wnEm0/ucV0CLy28NTgBbzOBJXvgS/+kQ1c8zBX7DWZ/dCOiElX9wI64FlpjyZstmoDoLmqAAxyDYjvM6dVgbNrN/EiwDNGxr/4lTf1fluEQCAEjCcAbC3y1AZN10Sk9L7ahg6LjLOtWTyB88hVt8/TDAPVunwJ/FGbpuykOE9v94BiGFfdFjDLY1pDR+TLJ0ceGCHiy6H6WouO3yJG3iwtAyrSqDt4ci7RGPYW3+bwQCfbN7BXwjkZkKMpyY7lw2Qzi+FvNYByl+D63RZLgTolrhlZQ+9euS+TUEEDLSGDCk4temJg6fXby7KPsZNKUo3w5ugmpL89nXvIJKPvWG0dOoJKdJynIPR+tga5U/PCFoLS0uTRHE6VPzshCw15ZFOXnupJ8C7aYGLhO0jO0CiX8fdD31naKvNjPu2F8+DJ8gRAHxwU5AHP/w+K3pHso8a7aGNycQITDHE12k1H1ewLzFk94kWkgUpccZM93NZMS2krPML/fo1+FqrIINHfjOnuWrFb6hJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(52116002)(66476007)(66556008)(66946007)(4744005)(6512007)(8676002)(8936002)(7416002)(2906002)(6506007)(4326008)(6486002)(38350700002)(38100700002)(5660300002)(498600001)(1076003)(186003)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TAb3Rwi0t7abseI6f1FMhXuzEkFEg/6fk2Ttr2NPC1/yI+ZyexLb/b50Y0/j?=
 =?us-ascii?Q?V7IlRKP+hJgUwIVJtKv01zzr736UiMQJKp3rTnmw7Wu73gHXWGMC7gj5S3qt?=
 =?us-ascii?Q?I7tF758lm37xdrNlD85ybzJq9oy+eqZ+3woUCrvV5qVNcOz8caevA4t8OEIX?=
 =?us-ascii?Q?Ju1xipSeidSW44LyzguZQyMzjBih7cV6ri2dY0DaTYwEvCxBl2+TCGl5CTKR?=
 =?us-ascii?Q?ZEHYVNSA7yTy+4KsTxJSrbxz+Y/dpEbxiBt1tjr+2Q9tFS3aPRRnFV7BGpP8?=
 =?us-ascii?Q?LAqIFY1MQ01zfmKWcyUtHorhldfpaVDhbBnY7Y+6vWB1Bwx0EB2588PliGZ0?=
 =?us-ascii?Q?rt1tMY3b18MD9YmdPYRjkuyzOiC5Je3MmcRUiQE9BxR10nYcdxCLvE40SEaj?=
 =?us-ascii?Q?HPDiBkvrgg3pztPj3wRKOl+v4eoWYFjQ5ibic386s7rp0vUmBKRFzS0oCfwG?=
 =?us-ascii?Q?OdcESlfAwNQIms3FsVDaJVhq6gNJ0mrDi2PGUdLhg3TeDlg2GOLW1ux+mv7Y?=
 =?us-ascii?Q?N87mIZB45HMZqwgw9+396stBS5y440rSYQVctKMAor75xsoJ/+DyELFd6Fvo?=
 =?us-ascii?Q?5PC3Re0oDvjVsRPT0xGF8cq1sQJL1AkNYj50cEja6lKKbilE709XlyFfi8Nb?=
 =?us-ascii?Q?x7iPCm6zCFGbdeECw+rgp6lNpjZZbhgVWRhMyErZanT1C0OQq1mMRTiFoDZA?=
 =?us-ascii?Q?GyGFBhkHHhqp6bjPe25IduOZ4wYkXoRM69GVeVW1cxac5XJu9rXQ9KlE1tyl?=
 =?us-ascii?Q?tyZrhJYKQQKoZXSiJBZ0BZU+zXWgNPGk+sgrGBYAdqdshWihYzEIsD9ylVus?=
 =?us-ascii?Q?lrXibX9tIdk9mCJdEwYhk3MJrVc41Z/6ZoNOhqXSFulW+iXrThVSNmHM1PYf?=
 =?us-ascii?Q?py/yQSQaWE6WD24Saoa2xRGT4iesf5LtyN/bZ3l98Z9LTUBe5qfnDAKc3+YA?=
 =?us-ascii?Q?IGAkjkQLJtZhOj1Q40XeQVdEs4qFMWYU/tscwzcMhD2dwP6LmWZUj4f59A+Z?=
 =?us-ascii?Q?TO/owY0eIjgj5lzX+GLXXxUQzkycwY+YrLbDSUePVqPQPztPfM+pb8yw/cWo?=
 =?us-ascii?Q?E+j0oB1h73+Qg9sKPFyMVnJVGjsEyiMZOztV7dCZ4oxUHJy3niMQkNcluDdB?=
 =?us-ascii?Q?XIvc+gxsJsBfIst2nPseAlciqf1wKVXYO/0vRsRyzHROHZrVliABZfgsPrup?=
 =?us-ascii?Q?cVx/WpHFTp/wgOh+VL94TzlxbWCCaTiaOqqydnGwjCW32k9UoOGXNm62g4Zi?=
 =?us-ascii?Q?1bgnK3cOcDVeJ2UC5DjakURyNtsjxOmQ0OHeuF7rNGXzN5Ax1Da0H7zlQOiL?=
 =?us-ascii?Q?2MmUecNmlVwQC5cDec8DIcxQVVI0vd/gIyAnb2mGsJ34Q0/34ZRz5mgr0GHT?=
 =?us-ascii?Q?LqVg8R2MTa46SfCtxTGrGxXrgAa0elknUljz/iYpvHJG3A2A2g/QFOkee407?=
 =?us-ascii?Q?v6W6hIktZNzA45DhbixFghAEyTp0X7rt87L84tYOx0GPnc6lB75hj1LLWA0P?=
 =?us-ascii?Q?YeyneSzKHCtjNey7+S+6qgW89lcy2nNn97PBRBt8pXJWcdyrGdFSj0jHec0a?=
 =?us-ascii?Q?17NDKtVE/D/jW0a4oWCpWQY74ywzXlTGPYC7OipQ9Zhjqwi05odcsLyvQC54?=
 =?us-ascii?Q?UM6EpS7KOuObnLAFggXQCec=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae60381e-e0ba-44f9-d00f-08da01b0f303
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 09:41:13.2456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQkFCmLh5rK1eM8YskuxwqI/dc21DOeUG+wcH/p4ds3NsRxakaovcdRZo5V7ULXLyJyzegBOjwn/Kv5A5WpT0g==
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

Add i.MX8QM compatible

There are two general purpose M4, so add reg property to indicate the
id.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
index f25c203dd2f9..41d366cff3cd 100644
--- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
@@ -20,6 +20,7 @@ properties:
       - fsl,imx8mn-cm7
       - fsl,imx8mp-cm7
       - fsl,imx8qxp-cm4
+      - fsl,imx8qm-cm4
       - fsl,imx8ulp-cm33
       - fsl,imx7d-cm4
       - fsl,imx7ulp-cm4
@@ -68,6 +69,9 @@ properties:
   power-domains:
     maxItems: 8
 
+  reg:
+    maxItems: 1
+
   rsrc-id:
     description:
       This property is to specify the resource id of the remote processor in SoC
-- 
2.30.0

