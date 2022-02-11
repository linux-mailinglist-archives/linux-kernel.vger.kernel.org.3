Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6774B1E17
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245646AbiBKGEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:04:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243911AbiBKGED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:04:03 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665835F41;
        Thu, 10 Feb 2022 22:04:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjoCcJgJfj+yKM68Yuf9WiRBuUkVGeGKR/I5cmGdQknrFLs4qingxtJwoAf4s7WhsAJIXyAZc8VADqqNb7RIOPFJ0wk5+77QvA0ACMLZIAnTatTDRBZay1TOxgWpWpNFeSiDbmd3wCLIFPPjaBuyyyCLiTKPaO//ibaKyGMBSTRmEKmuabtLgIDRNTR7ypoPXkZ1yuDFQqpoQesHmyEWmyekuAuonjpdLGYs/79BlQOfDT0he1PCZawdAmyN61jnDvq6ZJELkuTWbiRLE3iv0tEmbJoLHhOBPQpFCu3Od/hcK3tdYp52kE+sVEFETTvn1+puqjHuCILP98nSe33F4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMp1oW0OsgwM8a3XMrIbvwsXrSi+u6hAwiS1/lAE3yQ=;
 b=TJhFeFkA/2VS59EuGloqGWBdIwbLvgLN9QgXqKfzRoazOlMwQu1qAwg6NvULOxEndzDAcXUJyAZHCzQxPVpbNtSpkMPfSnaeRq7+3nvtZ1/pSz4qq9YicP6ZUEj2PsKvkhFsyYF6FS8tc9SSDaur/RGJ14MrfibSWb7F/rY4m6dT0bmM4jQF4PImkiFfV7KGK+fZTtFP/841xt0bBZYtPtdTSm0r0RhivIJ4oeI6fkKM7nMS88iUkZW6kpBbi6FuY2drA15MYQyULgkf9TmaYyzaOPD1tMK5uNdWJCL1cps4OAO0iUJNOBlvRD0Uzi6jduL/fixgEr5MdHSlASqebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMp1oW0OsgwM8a3XMrIbvwsXrSi+u6hAwiS1/lAE3yQ=;
 b=T/M3SgqNmLzwacTq+midIcaleHztoO62fNlW9YCghGTAqoFdHwFNRYuDO+g7qFMiMY9zf4WOa3t/siJ+76nrqqTwWV3bpF1OEqJznzgXPd8acgXUCmJ24VeYBtuvZkklcpNhxKsJloAFmBpjBE8wawGynPAVk/AWWCcFcnvx0i8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7113.eurprd04.prod.outlook.com (2603:10a6:10:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 06:03:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 06:03:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/5] dt-bindings: mailbox: imx-mu: add i.MX93 MU
Date:   Fri, 11 Feb 2022 14:02:57 +0800
Message-Id: <20220211060301.1852772-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211060301.1852772-1-peng.fan@oss.nxp.com>
References: <20220211060301.1852772-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 882d089d-1a16-4099-e725-08d9ed244b77
X-MS-TrafficTypeDiagnostic: DB8PR04MB7113:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7113996967BF8F20B74A0EF8C9309@DB8PR04MB7113.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KEhYQRtOdzd20fmxt6J9Xx5wAP3nOtBBugpNd0Eva7SDnH2U8lqjXtUMo0ygzSFMVlSMCCx1mTgYHAmSVFBGl/Y6QD2OP7rluxRKHM9S6WEkWFWzaMiOS5T2r2hITVVEdQHOn+96a3p5XdpzurjFHQRrG9x0RyPZUDKfdFRyfM7yrDDawOZCuw7qLD4WQuKTINvSFwPw0CDTdohZCXY6I75Xhvq6mI5AIhaEVDfASWNuKt9Dy1IdvT80dLfCMVhMw+R8aZZtf6nsSSwXhHTMSorquDlFOrKPt/qYPRO0AmEYr0NSWigwMNai4Rh9TbXdZGhETgr5gFdxmUeQcBpP1T9tzFm2m/HnCozcFE8WMpa7nJqpmdl8O2QSERdFn5cgVjXCraecQuCu+XdP0YgXtOUXLs0WNb50QQtUKwIMKguJmZbi+Y2BUYbprRP8YuG+USmOGFnUVqMWjmeuY5igoojhTV1N8FOF3VsnIWEz4H8fQxxAiOsf4aHDsFmpDQWaA9CIWQS/Mr4pkQqHEGCO6CbIT+7pSJrVGejTNw33+e/ywZtXMI+9ciO1bg0hj2Scgz6ZNdqNOAcFlrGl9mTM4o7zpPD6hHcKFRjXNFTATLYp3S+6IXlRqy8UGkQ+xrse9FeyedzaQwtdfj1QluEvSlDhMIec23hhGuBQodRmnPrgOa5vWgvSD90cj0WaeVhqRbhsty+tpiBtcXKQpW8BbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(186003)(26005)(8676002)(4326008)(6486002)(2906002)(66556008)(66946007)(66476007)(508600001)(316002)(1076003)(2616005)(86362001)(38100700002)(38350700002)(7416002)(6506007)(8936002)(83380400001)(15650500001)(5660300002)(52116002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZO9MMNVnXzoQVIXS50PEDx5UWcnxqXPTx5OKewoNfe17eMmjaHEpS6R8XGa3?=
 =?us-ascii?Q?UD9PX9dNWLZlq/o+d43fVdOFkCgqKe8RiFdE57jWQgwzpiugXAPTgj3t2SpE?=
 =?us-ascii?Q?Uhgv434gEG0H15lnfSW0vuNaY+tWpYlw25kEAVctKGEGSACLj51/sYvdLQGt?=
 =?us-ascii?Q?6bLzctoBtK5vYi365MpBDqJ/6yWM2Eh13k7c9+0jCtA8OxMBwk6e6fUDKzCU?=
 =?us-ascii?Q?5t47j66zxJn7RC5vrlesnfcszWg+i63ueAewsAhC89YitydKVfDC6aso1q8m?=
 =?us-ascii?Q?nuQOL6jA0HLAFIY/176nxaCHdW/ilY04brgTQRM/vd2cxRVBXZ6MdRw1H4LW?=
 =?us-ascii?Q?VFJ8tXJkGou+SIr9Wk46T/cTu1OS5/NqOA3658OlHmU3A4mjoGoTz09CsWrA?=
 =?us-ascii?Q?zxTtlHWWEym1RbXNU3ct8NkRfMuhVoaJs7mDE/Ri4u52bkVQI1MwrnP+Q+Kx?=
 =?us-ascii?Q?b17ALiwJYYKNQvRwtchWcS9pKkUZ2dJCsw8NUj36RaGYKDURYqVb4KeJZhJO?=
 =?us-ascii?Q?4eA3I6rKlBVHFvprEDQe+/aHCFHoSJQ+PndSYm3gaDsn5aZNZyAitosXjdTz?=
 =?us-ascii?Q?B7NygIbDJT5Zu9o8jehYFBHwh4wanyuEJ1RRc6FazoTWqwES70HE4WHow+EP?=
 =?us-ascii?Q?TMCShUxCOeBWI1i+dwp7mnzz8vYggR95qIpJ31NFK67NXnYC2yNzLw72WQc/?=
 =?us-ascii?Q?sdNv2LEbsMIIHZ0R9Nuzw6pC4KI6x1o+k5nEIPTP2aAP782GhJGpE6xAWSO1?=
 =?us-ascii?Q?fr0j0QbhheNlXRvF075NSwvIR0forLx0qIFUgOdfgmj+uInRRsTJbxqzTSRw?=
 =?us-ascii?Q?XsL/bTeVMqhgmJxgjJdSRL78vazTXVpQz9yVYJVEr2MKBczU113P/oDPtjLl?=
 =?us-ascii?Q?4xDKk9yPP4XdAbvAm+G1FVX15lmenelbOsxwcC3Ktdigd5Win5iNv27TOzh4?=
 =?us-ascii?Q?TGeNBZCVLDeHnSxNAv/kjtzRhOPhiNzBuhBa0Bedpeo4Q+tG0JuHKemvelsg?=
 =?us-ascii?Q?m70//HVPjG869bBWEt0oAwjd87JxWS7nXW21all/M3E3knqn6gnJrX6nXkgH?=
 =?us-ascii?Q?cpFgoT3wgBLQhnGRm6jRv5sdyeg/QVjWJPxsYDSpvfkYet5BdvEmv7K2z2XY?=
 =?us-ascii?Q?0ITrjNw8WZg2aifPxl+WM7V/48phwoeo/ZJm1vR33GWZx20+iGzgCil99eLV?=
 =?us-ascii?Q?pRI2dFDwY9q/w3h2mSOSqH0Jfeym5VT9OuqXP/GmwholQZdDLrr+6pbaWWvy?=
 =?us-ascii?Q?m4Sa92oa8GKHYVhYOpT5ccjKwVZV6IxQTVxsISF5HftevLuwYWWTtvLQR3VE?=
 =?us-ascii?Q?6I//UjnQ9ONtFo0R3YyE+qvSPpa2MsU4CVAmbLBYHvVpFo7gYh7A3ZzyM1GW?=
 =?us-ascii?Q?DokM/Ee7aKP3KX+AY1QZee9vOZw+2CPFAjWqiaMmEP2TLPuEOF44Qp0QdVww?=
 =?us-ascii?Q?Xa79bGip0k5hlEithW0TvfIfnQBCi2kDKT+g2ZOtXXHL4nzE6gxg5aeSz5Yf?=
 =?us-ascii?Q?FvPXYexAqsxEALY7sGxnRRrgX7+SCqNtWCQK/OuowJgMRxEDy92GF7LQXN+x?=
 =?us-ascii?Q?Ar7TJXGy5Vgm+jt78mgfm8yoWSrGv2502NlXIee6BAAsjTW82e7keVEmsdd4?=
 =?us-ascii?Q?MEgO/HmIya4AhFWxhoEKu7U=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882d089d-1a16-4099-e725-08d9ed244b77
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 06:03:59.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRECkvWDoZ6IrVLvm/e3o/SwwYBAl9szx/mKuQP4ohDpPYnv0xm9QXv9H/EpEHza+fAArwnar/HUF30MVhlgYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7113
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add bindings for i.MX93 MU which derived from i.MX8ULP

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index f865b806ae6a..6d056d5e16bf 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -30,6 +30,9 @@ properties:
       - const: fsl,imx8-mu-scu
       - const: fsl,imx8-mu-seco
       - const: fsl,imx8ulp-mu-s4
+      - items:
+          - const: fsl,imx93-mu
+          - const: fsl,imx8ulp-mu
       - items:
           - enum:
               - fsl,imx7s-mu
-- 
2.25.1

