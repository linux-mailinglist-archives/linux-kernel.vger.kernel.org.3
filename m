Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEEC4E219C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345056AbiCUH4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345050AbiCUH4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:56:12 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10076.outbound.protection.outlook.com [40.107.1.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C5015FE9;
        Mon, 21 Mar 2022 00:54:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGiIrz7/qDrDc9Y+3TCzceXubpcelkYwxLKnaNRbciUoRwvyKce3A0UJUxPfn/Kvc4Ojat6kP/S4vYluHXpfgi8i+15VmjYsv7vx/+OshBvt5t/XOgCGdtjyP8DcW3I4XumlGyhslGhtWeCdEGwK4Q0G+RdT6NfrT1pNZMoAzOpLj7lYYmrb4RrkL/oHy8oXECa1ld3xpgHNViEVfA5CZzGiwlxPgDqhdk6FDod2z/ZV8mhjfb10P7xNXVsbknFIk4ariP50uHKbsVDxRmUNRPJH00i3wTBuyusyMN1YC2Ml35OmTN3Q7DiGDS6eJRajSUgGgrKpmmqs5l+Xevyuuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZprN6CftB84QD4rwWDrKS5EAY+XnZ12JaMFCTCk3QM=;
 b=ayxxCooTuDyHrmplWkdZvk4J37BobPljpZIqQJhl8RNHa31lYWW3p8yD1MhZNKrQ+3Ts+KKE71QGcqcVKaJeMHCwbYgFgpDS1fTD9NLJI+OGpFng/RbGvLs3PRnVz+nfIRSjRpCG7LHaKM3bjYEaEMIUUapPEPZkaiehi9hYOFhynaUnd9h5qeQAKPY/xyPf4QYiD3phXlhmjhcDPW0Ry8T5Gbm896hYiWbX2Ol5Ggn0+rVZ+j8t56O+UKBz3IjJIQ6xM6RI3PXrDQFJT0jh6bzdzXl+y9ouxBgK54mS1MMa2N2r/cgJ/Z3J0+W3wF7dvh3tLs6j/3XN5bCB/XjfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZprN6CftB84QD4rwWDrKS5EAY+XnZ12JaMFCTCk3QM=;
 b=rKoPNBtbb9wu4sKiNdM/vXuyKtiSF5fdjn44+I9jPuxSPQKajGFMfM/NDPdFuiaqqVQMBh4rPBVINYEMum4xf5qofDNRvf3Nqr0B2AB8X0sO1ovbPYCDVNQXyKvpRmLZK0mjlDAkjqlVUKJn1RsmHAFc63Y4nHx+5Wu7DHp1eR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB7PR04MB4204.eurprd04.prod.outlook.com (2603:10a6:5:22::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Mon, 21 Mar
 2022 07:54:45 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557%5]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 07:54:45 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzk+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, manish.narani@xilinx.com,
        michal.simek@xilinx.com, dinguyen@kernel.org, bp@suse.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 1/2] dt-bindings: memory: snps,ddrc-3.80a compatible also need interrupts
Date:   Mon, 21 Mar 2022 15:51:30 +0800
Message-Id: <20220321075131.17811-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220321075131.17811-1-sherry.sun@nxp.com>
References: <20220321075131.17811-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 030735e8-6cb1-4807-5bf2-08da0b10104c
X-MS-TrafficTypeDiagnostic: DB7PR04MB4204:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB4204307811EC32DC4F7B55F592169@DB7PR04MB4204.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IxAgN0TTw/JKimmAXtzUu9YnTFj4n7Y9pq7t0oMMGYMrj8dMBG05SqogKD2RwzTdhscpdsJpsZKjBMhQ2mv225FSxjD84XpRKtNcNJfOOt6xJrCG5iZuY4+hVNzyzdCk0pT2q4oQHOHxDjAEy88RQqr8BlAZapGKjJzK+xKt6dZk+I0/9MUwK6V0WbJPvfIFBsel+5R2fHA6iBF0lj0yLLMCh61NfeqOcqhhVNJfSLVpyFfK3TqwrjkfkKjnXWwm/h57YM/jeuhhIu+Pb+Kvk9S9ydbhRC1NSV3Zhy/FAupHGhnceXgh3IlWQU+vMOgdN5PjbxVLgic6PCOBnRIUPHn4MtOjxytu+P/CKvoRWbSRe5KAytAWyr+ZKHmGBP9dq9MLbhFwmNRotSxRnbVZOO069dX2W/S0LtzliCSPcNgv7k2EJFIaMMAG99dGl8r4uzlIMUJSVFZRQHjXld+hl4FmEFycF4Sdha4SrQduM73f6aFdRDd4SR4qVLhv/ekBJXG2Rt0etRMsaDuHADDArWaZJq9kRelYr6losfZKDNGwzoLnYa4q71x7rmE//0YRP/JVkoDv6GEp9Qmn4YvkGGjgnjeU7vpZ5aARIDg69lgkHzQ0qixL52EVPq8Slf7bHvbZBmAhM9zTXKaOO5QfQh1MB5mk3iNSMHu2MLCIP4rRIL64Sj11iwU2b2Y0VTTzXILKuogbB87Ob+ud6cNsRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(186003)(83380400001)(8676002)(6486002)(2906002)(26005)(7416002)(316002)(6666004)(44832011)(38100700002)(38350700002)(508600001)(4326008)(1076003)(86362001)(36756003)(5660300002)(66476007)(66556008)(66946007)(52116002)(2616005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kBawpF1r2Yn8r8fsQKOPguk8e2hURbDGrjLLd+HlkrxhRkME7FYbeeh2ggrk?=
 =?us-ascii?Q?heabba4H6cPeCjuuiwCtMEQVPGVNx4qAVY1oVPSE8hrj30eRGFAIZiomqTb3?=
 =?us-ascii?Q?8rNxaONv2I0w7H5a6/p1xZeavpJZHxh8tp8sTZc3hAb83gE4sQFANwArxj7D?=
 =?us-ascii?Q?BsCuXTddqPaSbLN7T03D3N0fYaVXQh4mZv4ZsgNekFA3gdz1HFSF8CMKLsGl?=
 =?us-ascii?Q?1VwsZzatqO/4Jpf3X74occ1ld+HIqnF4eY72qUMq+uSxA1tgl73Rxp/ZA7Hc?=
 =?us-ascii?Q?F6GGitzyQkcc0iqxKZZpcyJFRJUT7VW14ughgzDwr73mtAOIkMWOpH71pwyA?=
 =?us-ascii?Q?UcvOihgoA+ME0p60nMofT+0WhlVgdnBZ9BeJgfciqz8BLYyRoPcHkRZDlMo7?=
 =?us-ascii?Q?iV59vmnLkDeOXN4Z+z8ziVySRtVRICHJg2DHXg8pxaqvpLK5qS4PMVf4xaf5?=
 =?us-ascii?Q?DSlLRT2hj0tdPdaDIWTl6jP55xy/DbIymxcjUc/RZTEPcOLrcLtdyAkj5vzl?=
 =?us-ascii?Q?mPYPxwePJoNVIsmu89u9L/JX+zW+ZLLp9Eq2Rci4JmghWo45ZgtpQy83m+Qt?=
 =?us-ascii?Q?gKO+ueOqUOG2mLFXzB6h/DddZq+OBubEhK7yWFrdpdEYKUHmyvLnT+HMHRNj?=
 =?us-ascii?Q?6mdY9jzCrHZadNpTCS0MNOcvhHhrMzWpaGsU1ilbXgwJEUU5h3/RBS37skSc?=
 =?us-ascii?Q?sCYfFenNael6DsYWOJeCZ7v3xqsJqCyWmF3XQcDXs1ooy0PANaFO+0glLCEL?=
 =?us-ascii?Q?bNDgc/pgeeE+0o5XNjjwl15pZTzsGRKMTGdxtMjfc1JNF6D49+MVS3NkLiBa?=
 =?us-ascii?Q?y40FEiW8CVYhCVquXPVxyoSVLDhIjCLzELJMCB1KMBXRQ2FCERmXYxToHu+C?=
 =?us-ascii?Q?oWMIVYixSUC+2fonc7qgelgU6ANtgG5kkZsIrUZscwFTReN95MyKwdViPJuE?=
 =?us-ascii?Q?MdJWhbOngTI5fpmDAgYY+ge4DdcRu0xcWDan47b38FNRvLPRqZ89qTp6TKWm?=
 =?us-ascii?Q?9qhopofqOj4jeSrqZXU67+lL+YRWiW142IHWydTcpM0elKqhIUyn2ncP9Pyr?=
 =?us-ascii?Q?W+x63FsT2pHqeE8yTF3Q6NZaHu2hMJm+Sgd9UYnyL8emR62XwP/WWtylvr1f?=
 =?us-ascii?Q?MJnXXexJspQTsxuPqbZw4+USwkAArPnfp/ynsY6LWRTDA5BcXaaQ3+Aa6Q74?=
 =?us-ascii?Q?dcH5Sz78wo/2swJ4vVIuI1ptKGXz3ysfcd2mcGYshJtL6sgF583XUT5M6BLR?=
 =?us-ascii?Q?McOpkiKjvcLZe0ijLEZKsnuGPeu2EXTk/OcPxSawsL+i97lSk7kZLBbe5/E6?=
 =?us-ascii?Q?JUhEDCOni+mlz/PIwoGRVTt1YXUQzYEQ3MEK4IxtaX1rMT3bMpCgoJjl0cLE?=
 =?us-ascii?Q?YGO0Ce1PBoDXKLzJvfQPN7iLzqqKXYp99tYl53w984DYt3anlpDNHsYU9+du?=
 =?us-ascii?Q?QX3QGeQItzEy8ObALlGS2zFuTqJs15dh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030735e8-6cb1-4807-5bf2-08da0b10104c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 07:54:45.0775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPc2qyUId7pmZcOqPO6SAsOktG2W+sp0kdBWOqIX3skYmwEPLqBlSGEiroX5aIEj2v0Q/LALsEu3yjFJsAjkzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4204
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the snps,ddrc-3.80a compatible, the interrupts property is also
required, also order the compatibles by name (s goes before x).

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../bindings/memory-controllers/synopsys,ddrc-ecc.yaml      | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml b/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
index fb7ae38a9c86..e3bc6ebce090 100644
--- a/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
@@ -24,9 +24,9 @@ description: |
 properties:
   compatible:
     enum:
+      - snps,ddrc-3.80a
       - xlnx,zynq-ddrc-a05
       - xlnx,zynqmp-ddrc-2.40a
-      - snps,ddrc-3.80a
 
   interrupts:
     maxItems: 1
@@ -43,7 +43,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: xlnx,zynqmp-ddrc-2.40a
+            enum:
+              - snps,ddrc-3.80a
+              - xlnx,zynqmp-ddrc-2.40a
     then:
       required:
         - interrupts
-- 
2.17.1

