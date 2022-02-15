Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39F04B65AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiBOIOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:14:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbiBOIOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:14:41 -0500
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00053.outbound.protection.outlook.com [40.107.0.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660326D846;
        Tue, 15 Feb 2022 00:14:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkZIuC4oUVBe3lDGaBIJXcI/xgquMwdZJfa5xaFnSmiXuerAp+mDFs1FJH0N5DM3gMNIQXmT/s3WnvpCt8iVsZ/OXCbIPmuMrgdsQE3P6ANBb8PciHe5y0mJ803WoOJAK7ZaVIjjo6/dE8TjQt+RBJMBWmbjIYFiTXf4XllLbFj9MqM8jCqqUu1kdwc4nscEcF4O8zL/AWw/3G8oF0GB1y38ldSeyi1wfbHVPOzDyd5oTcpI/ptvYozpGWyQKNXkDcNtzaZ0JTYDwfBgYvtNgF9eVWg64fMVHmb2wWhPTpqMsLU563dUKmv4/9JhOt4IE4sH3wgTtjktINi4ta3b1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzTgS/lP7kulmUOeKTTsrjtgTojFvq61T25gngHmu0Q=;
 b=NplDOLLe/COCioHjBZmwH4LQIOIMCZjrgCt3DYwoxsfCVHFo8uhlynpHpmqM62JjlSMeOcMahBlCg58+/B5Fi1QyLp6YvUwrdyHyGhbXYxF6TJbIVLfxAo63VDFGzpbTwydhzUCi9hZcuc01p0FwKCJGy2NNFzAro9rebisyegBY7sA3V7FBzeJ7tSw1legq3dKy57K73Hz6m1ZVX/EyGxsMbMhQqnxheb3hS9xs9p0oXf53apqHTzoZxGakePt3qNRIowlAjvqZW+8Nlp44hBXHBlNoJnq0dwiwYYRf9jbS+YiKGpiERWfOP6IZNET8/Rzd5MJ86IAS8Gx+DYFeyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzTgS/lP7kulmUOeKTTsrjtgTojFvq61T25gngHmu0Q=;
 b=DBpQ2V8A8IgA/qJyjvy/c7/i/+uvP3O6sLK1KNv9ynIwNdvklU5bgaqL2XfC8X0cdNoa+W3EegZPTMDcSXLt91AiqEe1VcXfV/qOVhDdYB1syxSV1eZDtpkdaBiHpGPDdbOzooBsiMx7iP3sjgWSTr7Jeisq4hx9vVPGzsNkzr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6740.eurprd04.prod.outlook.com (2603:10a6:208:16b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 08:14:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 08:14:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: serial: fsl-lpuart: Add imx93 compatible string
Date:   Tue, 15 Feb 2022 16:13:34 +0800
Message-Id: <20220215081334.788419-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0138.apcprd04.prod.outlook.com
 (2603:1096:3:16::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f296146-69e1-4195-ce29-08d9f05b2df8
X-MS-TrafficTypeDiagnostic: AM0PR04MB6740:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB674049FF3EC7C048FDD3F904C9349@AM0PR04MB6740.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDTaYRVb2JTr1Wnvawk9stlMOPAKpP8k4TR8ASRYZxFKu/DIR8FmfwgyfOVa/HJfTx83oNnI+8z/gYZru6bqerlrN/gIGeLdWqnsVVljFuxbPEWPe4S7nWLE6BvcC4WMZ/1opcp51XtBPQP3/3I7+fhN8jSrgGCpRCVFjacNXvl9Yll4D58T4kTe9WQQPi+18Z0GwLOT5kD0zu/0retef169jESu2mluO/o32EI4H3Ol0kBGoKB+ZHHV+C4K80ZLZnL4gtZUKJbpULPqlbWRtUcerByx50KvpEU/Z1ornU6KAP5CmWCBHLGFbnKAWQP9ogmrwFf7nyTBnMrTVEekRUtdYiFR9nkZ5VyyqCbV8zuGGhuFyWq4Y4x5dOd6uw92H5QgRL07fD/kPW/qwoa/f5HGy4/ajO9D6XKVxs5TkaVKJQefwMOk3i1O+ilCQezTBZNgpUcePnBlIdJgrKDqGPahv+ewh+otFmX1FPZAE3jqA26ykcY4h6hVuQltN0a+gPfM63Iw3VampN/MqVAeZ5l6jJnCa/NN5rX3oO+B83RvjfMQXfxuhZSKg73X1VLKQ+ZDFD0sYNn8e204E77htKte0SfVZOaMlLrBsKnoBNzlpcKQKvkC4v+YZlEmLNAfn3yAEss4aiBskKEC/YK8LewqbckN7n7eh9EQyJT1XEznFcyoAmyER7rQ6Z3BVOslBbOBvXiWETZJG+ex+JGXcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(66476007)(66556008)(86362001)(1076003)(66946007)(83380400001)(4326008)(8676002)(8936002)(2616005)(5660300002)(52116002)(6506007)(6512007)(6666004)(4744005)(186003)(508600001)(316002)(38350700002)(38100700002)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FogTcMLmnoSq5Tn7DCpXBEl+Ltt08blYDzw2a3bV816WpKGlxU55R7YCINYy?=
 =?us-ascii?Q?umyFu8L6+iTvIEpsWlYafsgzaK00LTrL/p82wO+xXjMpktX8VAOj9fOvVxTG?=
 =?us-ascii?Q?/XAD0UXvdYsQnZjt5dfkH2aivqHrghytoi6ZHvlFxBpwFJPbZIL3wpoGKFiE?=
 =?us-ascii?Q?HFnLOHFPMjK0KDpvYcQvMqNzRBpnO6XSM/g2cR0zqaM8KMopI7fSsxlxwiRV?=
 =?us-ascii?Q?WPc8+XIHeLFlT4HBencTfyMnvTcEIjN2HMh4yNJ9JVSl7KqXROtaW4um2eot?=
 =?us-ascii?Q?dOLHHne/3Ea2c7uh96bO5R83YZJkGIxbc72/EladFEF+U192jzM5v42X9BA1?=
 =?us-ascii?Q?Sdg36USBTcyq8LIwN1Si53inJ1a+38eu4wRdtUEylN3Ku2eL963Q0X4zILfs?=
 =?us-ascii?Q?5Pkhw5ivUUu7UlW+e7HFOG4wKyoMD2Q1w50K7lSeGW1C+SN1PLRL9NoAGj8w?=
 =?us-ascii?Q?qHl93DhQHUsmofzqe8gYb8teuKF4mGN0qK1sHCCCooLuFnrQ0GMyz8JPxZCJ?=
 =?us-ascii?Q?fFvrAeXSliLpL4eg1p3HGiJDrF8sYER+8Bix79OgDjvBUaQozbQWCfSx79pt?=
 =?us-ascii?Q?N+8olgsxovpOSemmmgYRS3XtIsINsS2fve7WOKS5qraFbOihXvyBCjcJiegR?=
 =?us-ascii?Q?k9UC9l0U4YwLtCDlYMODc6WDneaSgcVnNCE+t8h27vsNXRcET9wN2HJGxyD5?=
 =?us-ascii?Q?HtoZbDKspFqGjDUBX2TgQKAO+ZAPJB0gJwbtHvzCcJ5nG4GUlTd2HCyLUt07?=
 =?us-ascii?Q?S3QS88AxSO30NmPNjnmK1R0hCxf6Dv4VWuc1+879c9496//YrUfbl2x7sItY?=
 =?us-ascii?Q?QxkHrLCtOCP+RE18+HY4S0CFm9vYupVT6it1l+sOexvoDGDYht/eZP+e0ZCx?=
 =?us-ascii?Q?o/KpKhcQFINTfsquL0YtVXT3AwQ4tuJCc+kg0Rr7YDYNJSt/ylnzPSOaPQ3W?=
 =?us-ascii?Q?LDfuAhDFMj7NZwDdkj6MgXssOH697294E2+17b2XunNO/7I12QDT0ZrV0hA7?=
 =?us-ascii?Q?XdjLsDACFD0ryD5Td2YiBpcsLSJOPth9X5rHUsgYgCRPFYJFMyneAarD2tFT?=
 =?us-ascii?Q?wnz9NlJHQynvtTyzjlwQdDIKe+KeTlxS+Fcm8dujMxOzw7D8E+IJdbNXVntr?=
 =?us-ascii?Q?GZPOQu7n9UjnzUV136z14pNgnH8KFYQDukDC+/14jkUn3iLKWWOeTw5CJzsf?=
 =?us-ascii?Q?m1xRLNCzeiyFr5/BIGZseHlFYfbR1CtoO+A5AMzznQuBQGZ4iUPtu64DrJiW?=
 =?us-ascii?Q?Gly/DZ6GR8PwlkOdk8/i4iZaQupXEMlPg+gYCLseyZBgWmVMOCmYkWhYtC/C?=
 =?us-ascii?Q?Bgqvy0+uVjhJw0mnO13hvoxsp/Mpj+NcKvkK2m53AL4sJqcCLXaCMUaIim+r?=
 =?us-ascii?Q?ubMcuZiAF4OukaJCkiD+6J45yzF+1tbmW8+4/2tNA3q8clcL3DrC4nSVV5PY?=
 =?us-ascii?Q?5Bg+PD+DC2ajQhNcDBe0cKa84g80Erw2CRsNDqpcMHPLwPy9u9/5HHVyeT/x?=
 =?us-ascii?Q?STUqxA246VrONohU7Y9xb2UHM8yP/heIl6XrpWlBUHqcnrYKhSHdvl8KS2Z0?=
 =?us-ascii?Q?jHz1G1L/Gypgr6dO5WFSPb+bp2aZlA4XGnQfF8zhNQ3RB/u03q9zsTRH3QdH?=
 =?us-ascii?Q?Xa3vmE6P9pJczImFArMJ7p4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f296146-69e1-4195-ce29-08d9f05b2df8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 08:14:25.6406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qq01bHeRBn4U4GwYbsAflND+Y21R3seIM3XtJvzeho9BdKiNrcNNPJb/vb9TLfwWR+8A1U1JDNPlpfQyBQXyQw==
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

The lpuart on i.MX93 is derived from i.MX8ULP with some industrial
enhancements, it uses three compatible strings, so update the
compatible string for i.MX93. But for a few instants,
DTR_B, DSR_B, DCD_B and RIN_B pins are supported, so use one compatible
string fsl,imx93-lpuart-v2

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index 6e04e3848261..d7805f31ccc2 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -24,6 +24,8 @@ properties:
           - fsl,imxrt1050-lpuart
       - items:
           - enum:
+              - fsl,imx93-lpuart
+              - fsl,imx93-lpuart-v2
               - fsl,imx8qxp-lpuart
               - fsl,imx8ulp-lpuart
           - const: fsl,imx7ulp-lpuart
-- 
2.25.1

