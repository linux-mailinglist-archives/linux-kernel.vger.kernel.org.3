Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE1F4E4F85
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243299AbiCWJgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiCWJgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:36:42 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60087.outbound.protection.outlook.com [40.107.6.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8006E7B4;
        Wed, 23 Mar 2022 02:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1w0dV63M1aYDLTTjb9biET8XV2jfMKaKe1HwzDYQwwRU+4BVFwJ3uBcz9v9boelHlvSNRhfLVoGPeIXDpjRKFZFkoqwlmIfR0UbZEd9GiQghndrRmaqNYladM5qHsdaCycyCnM+16bRxDp2KwPTCJi4Zf7SGl29pQSwkuuCBWfxBsC3BekuAEpBrjMxDytZwsN9g+VnH/lZyseU0lFqVI4ACmpNSEiBYUg5OfKNRM7o08oxskr/Vgr2GpXp8bdy5HhbyHTdT0kxgk1vfL7375UU3qVsolMUZoAsGe+1l+vvreTqjaTQ9Ja+RzAY6xQjUQBxMHu/1K8rm05ILApatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RW+Wy/cWHWH80OMzya/xM16Pi5s9FJ+30ec7EZrCL3c=;
 b=K3/ULRILD6WquhaifTwgWNTIBZ5+/Yz/6y8cnJ/OEx1M7G8IYlCMminu8I7k2txgmshzmBswpPRFv2dApq5Moa1gc+RZEGZybr0kwtzprAIjei0sf9eeObX9ncjYTZxMzldlitsfACo4loijbAsnHlPwmg/G1LYmU5AeuZq2DXvuEVHYU5f+GHVAMbab9pxrdQtcm+41h4QgVexb/3h71zqBi1/v0i4UirfOJsgTc2n693f1AUM/Icw1Ege93D+fn2it52QnUAr1xBzY3cNyCgltR0toX6OmP04L7ZnrG2uFgdQYOW7TZz13CJlT9dll5Sx/gz9Y/ppCDMG3VNDbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RW+Wy/cWHWH80OMzya/xM16Pi5s9FJ+30ec7EZrCL3c=;
 b=PslrzTcXSlRfWr+NTCWDE3ERH5S2+OnXg+WlL8kixAq3xMTYoIkxcvaOfMPDTi6XWsLn1d3KRbElyMroRpcLeamPD9JuYDWDlTpyPfUZEm7lyN1EEPrungInUFLxr238h67aWn+90zGDkeFgpi0uKqecSBQfkAvZI5NxweIUg80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8095.eurprd04.prod.outlook.com (2603:10a6:102:1c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 09:35:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1d8b:d8d8:ca2b:efff]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1d8b:d8d8:ca2b:efff%3]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:35:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] dt-bindings: serial: fsl-lpuart: Add imx93 compatible string
Date:   Wed, 23 Mar 2022 17:36:59 +0800
Message-Id: <20220323093659.1722463-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 557e760c-0323-4724-fdae-08da0cb06c35
X-MS-TrafficTypeDiagnostic: PAXPR04MB8095:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB80957E0B721EFD56A455B803C9189@PAXPR04MB8095.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJJIfucVvt3z0Xgup43hObltmURBjbZxm5ZVL/JwRo7CiANOOzIZIO/6IhEYaxA4tv+5bnnko9/FY/S5igMfN9wFzSaSIwJSmYpCoy0eDuKdfXrWhpbqytoOtgszz0vpP8z0pIdfix8gPyRJyEaZGtx3W+Fz3bsFzAzFEW62Su2Qw2UEhKbmpr9KnUw4xsmSAqy/etJ5mTbObngLvuf6j1FOZvzgpEeawuCfYr2fcifTN+zQf+rzRd2DUVJd/bt7dC3ixkvZTYsl7rOXrgaJTEOv63/WlZXNJ4fOjwyj8WO2R1aPCIjWzBWsmH8YyhmvIDhJkug7p4FoslnESWGid6aUDANJJ3JFOJpLlrgYx5VpRbuaAQt+vDHq3Uvv+43dZSWZejVVPCHCsfRzKXG8J0vQCzMv4v2j+Z4c3MXYuTn+3EsYf14xqsp5UgiIbCeCUEq8Hf+1JhXaB/P8YIKnhQdJ6G9DKne4VnVQOCE+PjfbDvnYfY/r08YXssk6AwyuxE9l/DLMVCbWLNnbkErTMBwFXk+TZgznKcFa3vGduIKoPx70LPrnYXChnNqcgCbl4nSZ9zxcEZl5+AvEuKuEq8TEGBoVe+ADrb6bwqHGfE4wLBnykN7O7NNbxT5B+s6Sz2uktDOZFm7r3ioVGgSvt7pSJnU58VX+gLLlptfHKwedrhpURk/txj7MhYa16DbRMEpQSnbpwQyE/XpWxbP/MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(6506007)(26005)(186003)(6512007)(6666004)(2616005)(2906002)(66556008)(8676002)(4326008)(38350700002)(316002)(5660300002)(52116002)(38100700002)(66946007)(66476007)(83380400001)(508600001)(86362001)(4744005)(8936002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6S3qP23SEhZij7KXx9yNpqBTsr3rWLCST4wix2C1sb6OIj84+w7JqXl43WVU?=
 =?us-ascii?Q?yuNYoTDPbUja9/e/I3y00rP69EIJy7pqdl9fZnLo21udD7rkDYuC6iiKVKvS?=
 =?us-ascii?Q?FrF15tRoyd1t/Ir+mpITVm/jEYqS75ni+D03gbsjJJ8MeTelfe+ZwS81kAKC?=
 =?us-ascii?Q?Rgm/mEFc3QG1yjRo5XLrkmBm9q+iPaXYmsgrPxDi/b0m9dG3a7jeJkCPJzD4?=
 =?us-ascii?Q?n10ZIO//Lx5Y2pKsicgCPgjIpmIID6/earT0rNLuAcnZL+pOBy6ILFuIn41C?=
 =?us-ascii?Q?Qltj8T1/Peygylj2rpibYnaVXj3lQabr4DMLEDh0eVnV4DZeYiiLH+9ayyQr?=
 =?us-ascii?Q?oA3tSI32LGrhrY/RAXdrUex/x6EcDnvpl5umLxYMpD9e7emYF9+zttf6w09B?=
 =?us-ascii?Q?3j621xjPEtJ/xgFXsyF8vqAgg5a3EsThTxQv/640TOgFh76m0/LG9AlQg6XZ?=
 =?us-ascii?Q?rWc3yuHaODEBJQp6tdGVKcROW4WWkd9s5F7Jk716ngZRR0WCAr08TVB+Bcb0?=
 =?us-ascii?Q?LK6zy7wYeuAO3pFYgh/G9oQyEOwO1LHoyaPIW4x3d7cySFx75cb+/3Q6eNwU?=
 =?us-ascii?Q?i59fcsLzSih0m10zW6xuQ5PaPy9Y8bHT2RkHM7vlgIHGBbyGYPxdfCXWw7CM?=
 =?us-ascii?Q?0SdfqS6ZLhSwngp44pKD2j5jg84eOzAe97qYxT+HRfQeY5GIwsqBjIG1/o31?=
 =?us-ascii?Q?YH4hFXk60qc6jeg/h7B0VbbPypT/txRQi6EbJPSFO0jad/6l1tWuGIgLBAxV?=
 =?us-ascii?Q?bPA16Y8mr6mkgqpmVzbsOv+It2Afg9oGwcy8Hzv4V+H0mG3e1VJ1FhrDem+D?=
 =?us-ascii?Q?CR2Ajw+Cu1wwQPHzRdztcdyaSdUpt1uJopDGsLZ+h/NSOeJ1c3JthPBjMyZh?=
 =?us-ascii?Q?hnWoFgpweoAESNuv0OupmU2tY4EPTP+8YFfT9xqDGNaqF+GKred6UcSmKIVg?=
 =?us-ascii?Q?IVfmWRPmHGCfiSF0uyjIBVkMkmsA6x0OqVYC5sry6o4wyqaU9/uob9Hrce12?=
 =?us-ascii?Q?q3y/P2WKaQY23CYX9DVgszsE7eTkVxQqWdhiVyktNNpO8kks+R51tlUGKXvl?=
 =?us-ascii?Q?eqXtGq8phTz0U+TdOTX/HHbU+84JrcLRGHeQItrpHh7Oy42+LT/e9AJDDHG5?=
 =?us-ascii?Q?FoWQ7SwEyEeWYaQt7ocbjp0VHgAUAjFQB3NBqcfieFLtZXNVMHUhnLfINPhy?=
 =?us-ascii?Q?0XUz56K04af1UABGr2fVExu4SufRwc/6KJe1/VC3pHwQYRVysOy2h5KJNpmn?=
 =?us-ascii?Q?k6XMALhKWHRPLluYbfJm3gv7D34LGDOsoEg2bcBELlAisd7C2CD/7eQcHUHd?=
 =?us-ascii?Q?e7SyrVeRJ17bi9dxWZV70ky2Z9ypMBh4YjQ8fFh0uAoNWTjsbKhL63oLtfX5?=
 =?us-ascii?Q?G6cCqhiU15MWvHCP+q39p3LMHciVtM0X+0aLcEZSRkcQz+Ypai6WrLbRiKFH?=
 =?us-ascii?Q?dXIHN+VpQHjRCo//6waO3qcE90cYMQh6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557e760c-0323-4724-fdae-08da0cb06c35
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:35:09.9038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8zo8bE1qLDTkPPybnrmR4oRjdzQOvhMpPZ3YdPf6T5jSEmbYgKkFJ0DEto9pYBQcQlyYz8zxcbYxIwnz5c/gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8095
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The lpuart on i.MX93 is derived from i.MX7ULP with some industrial
enhancements, it uses two compatible strings, so update the
compatible string for i.MX93.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Drop fsl,imx93-lpuart-v2, that is software controllable per Design team,
 so we may update driver for that.
 Update commit message

 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index ff364bd0fbac..30eaa62e1aed 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -23,7 +23,9 @@ properties:
           - fsl,imx8qxp-lpuart
           - fsl,imxrt1050-lpuart
       - items:
-          - const: fsl,imx8ulp-lpuart
+          - enum:
+              - fsl,imx93-lpuart
+              - fsl,imx8ulp-lpuart
           - const: fsl,imx7ulp-lpuart
       - items:
           - enum:
-- 
2.25.1

