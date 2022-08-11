Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E5158FC9D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbiHKMn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbiHKMnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:43:23 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926C189827;
        Thu, 11 Aug 2022 05:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMuyO6bHZDR/2CfY9c0AdnhDHihXBEzVM4rZ5xrwD/MTKfyrfTKYJZplILPTgAp1Qy/LYAhPBfBfIRdVD0eYF2OQqidP13928D2ROTlvyg7/+RxBqnk/iX1IgItsV5TtC05X20nzXCHBXEX+FMQwMefm1QzKyjCo6Q6ZHc/C3ue13YAW+U/4ETBjRZZMBOFebXHJsGO1E1lF93R8wGvNyPOxCGsMSB4ImbWNGXN017a9/KnqrY9F9Fi56CBGbxvzx0hTwQRnTdNy08ZQ47gxtRCrelAslHHWX9wGkPc3yC9eb1NisjXX+1UXljbZKgeoOmgyoCxnevAjhidXIVWNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1MOsxOS16NN4Po+v1WBhPXLvDhUn7P5R/wV+Nbgrrk=;
 b=ih5YvT0d0SBU86/KUGVVH0/eTfz71Bf4+TBC2h2BWhf0L85Dlj92XUqfcRqv5jFjvXG/20QSiqeFTyfA4zPK0083ppcayqY6U6gHY39m+jGKGTK2DgyOJv0vKgI+B3pkpVHOxHwZrYEFU3ekIISBjDyKsouJMvNmkMFVc2xYrorFYb/qBgIQFFvlCQg3aGtq0Wr5FPtBTBIGaGt6OqyXxzIF77hbkECqXonNleBxhZlzBWOnTpNgQW4i/oxcXQ51ClL5vwY2uJ4T/kcvdNKV76btedl3y+QQ13HybhHWF0eG81cTNQw//sZGWYlMfsubrTuLR66UgWn2U3brg5luWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1MOsxOS16NN4Po+v1WBhPXLvDhUn7P5R/wV+Nbgrrk=;
 b=PxMJPPVdOITBYbs5emvADu9+Iotznx2gQ4NWBsY1isfxbF8/pvQdkezRGdWqTMZG6a3rWVegT2l1biT3OnIJDJpxjfJLeNlvr8lUxih389zZTsuJ7fj68/j/dwflTKh6nCe6eB+I81TvHkdUXVMq6qaXpcOSO6bb0kzl8i7I5TA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by VI1PR0402MB2832.eurprd04.prod.outlook.com (2603:10a6:800:b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Thu, 11 Aug
 2022 12:43:20 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 12:43:19 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/3] dt-bindings: firmware: imx: Add imx-scu gpio node
Date:   Thu, 11 Aug 2022 07:41:34 -0500
Message-Id: <20220811124135.95299-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811124135.95299-1-shenwei.wang@nxp.com>
References: <20220811124135.95299-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::17) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2cacd12-eae8-44b7-3490-08da7b9711de
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2832:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eCWXDNAAiHF7O0zst8sSjSNy/kqGV4148HoY/Ay4RShcwlvhQ0x0NTGDqablvOAboSwu08ry/8ELXZ42eHvyZv69wXJkk1eDX9/3gTnQjXXwshFqlA/JdwpvApMjMK9l5kCobzjmDWFBk/q2gFi+wq01ZxrdOxFPQgmhlkOF4Stmc8isUuco/u6xk2ZRP09tY6BLtalIucZt6M/DCckgnVp+mWUwyAFZi9WjEWKt3aRVq5OPEFrur2RTk2AZTbvGYOPEjPBOjznnHiHBQtp+jAExPeDutvRxJLC0KGZwGHd6Dg/eZHIBlrDLnk6WnRS0Ad1W8oOD5WbHBXsuHeYwHW4rp2LV1d4E2VhQCu5zdrSb1BfYgdbDZaS1YOlT7trBlKMf3et8iAKH6rTp4le2HemybUDt7aNyXN18o30A34ZBq1YoQaN5OrmfiXPVoctpc5t6Pa/kXrWhj74R+nKmR8Znkfp7FZXWCcNk3qj/BKP14jpg5FV8oEQui/TReYQH9OgK8zw9BkxxW+R3rApNuxl85NgdXclkghORN3YyRxGVY5Ikc7UPhyBIatKyu/nF2BS+fEQTAU6hQBi1eIOx5AcuEy0XDCfCOpJK4GwE6eQ5II3Dw4fqT2x8EbbzXdVfDhuQc4rmJYeNiIBWVlQZwbsZB5ru04vm/y+MjOV7SVwYHGUlRiQPNSfI09tUgBAUkKiXGaiW0enXe3/Vm8uBLw2J+5u0RWNB3VfaYKYHzixlMJ2LEz7h/XueEfzfQeEMsKhoUvqYcPhRy2Y/kMhpiQiFFgjAknGx04ag7fVNNxpibXB4+06GGSAGEoblBiEB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(6666004)(186003)(6636002)(41300700001)(478600001)(1076003)(83380400001)(2906002)(36756003)(316002)(26005)(7416002)(38350700002)(8936002)(6512007)(52116002)(6506007)(44832011)(2616005)(5660300002)(55236004)(4744005)(86362001)(66476007)(8676002)(66556008)(66946007)(4326008)(6486002)(54906003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gYZkU1Zc0ChmGEnfVIgrALAYjO0YkTnAGqTKZleglH6DWCKHPmrgoKP4RBkk?=
 =?us-ascii?Q?oatTvwkdYlKhwHvmm5BfdJDWUOjtZ8K7YYh6WWD0Lls3UsFro6V63CIgdILl?=
 =?us-ascii?Q?x7t5ZmH5zeuNzNVh8cHc14OdvaOPxC3zmpUIg0sNoqRC8Ry3PBfP8Vuqz9oo?=
 =?us-ascii?Q?pppre9noFJQeCqtdv3UBov6STlmK6opYYsWIbijkOzysBQiS4q1rAzvq63Ba?=
 =?us-ascii?Q?vDnK+2p4MTV+tSWWcmrIKPaV9BhcDiKQfBvVN1L5EHdv1ECzOH2FiXdVtrGh?=
 =?us-ascii?Q?JdajopCy+GvuBIXkITx357MHKhiPscogprBLr9q0nIiLZZDGOq9Or4jINtz3?=
 =?us-ascii?Q?FhkxDEyxSE7uV2e4QP5G1YQ4qCw7C8wW4mPUmB1kos9hqUkwZlTpDowDqCiu?=
 =?us-ascii?Q?v7EwA1sebfgGXxFArMUBx7/SjWS5+y2KI/gTWhfKQemg/F2IM7yigCh+8n2m?=
 =?us-ascii?Q?kVFZ/v74fmqbHqDHPGQaklF2lleghIntr2JTen9TUpwwbmTFEhAWz+YluE9b?=
 =?us-ascii?Q?VwBsA1kViaqqHX4UFX+QSMpgF+8mOEDa6uGzG7tLyKOL3/Y+WgEwMLzFx+Gy?=
 =?us-ascii?Q?IuAyb2vuWE5PbAdTSKtOpCoMUlmXRHpycikVmXTAfKGIioLLoIr8n4p2cMIP?=
 =?us-ascii?Q?O9cSVLCmZ4BCXQVOAj6fiHeTVkTsO/b5RQPrFN8fghRFiBO3wzYTV8yHaX7+?=
 =?us-ascii?Q?6vq/d0sAynQ4Km0fymSmJkrLUcg+ji9lqHIe3ui9bdsK3Cydxk0409beDTmu?=
 =?us-ascii?Q?RBRfShOdgUbFqdVp3Y8NjwF2NjmQWTEYJyjgIRqIxB/8RGfEoJzqd1C+2szn?=
 =?us-ascii?Q?8vb4O1ROLIvX9BJD4WiIjnsyBchEqSrppAtDTvnbRDgQe0UmJroF3x9yaasq?=
 =?us-ascii?Q?gVJWNaD0lXNIpMzTKBuf3C2dL3TzKIgkcnAscRyC1z5KlCr6f2+K1n5C8xgI?=
 =?us-ascii?Q?4cNr1SFz3zIJcXbfvwt0GtVPGg9wn+0DvZCFmgwSXP+/U1HHuy9xmHA3yepj?=
 =?us-ascii?Q?MHNnVX0unIVh9O1bnWiETcYXE2Z1p+XYQSmnYhBVorEQvVLzRI08MAX/Z8sh?=
 =?us-ascii?Q?8Iz55vCU0+Yy4cwEMPKmWGuOWqR47o4YU/cO7h7mH7OJwwnTuj1I4Gy17Zxn?=
 =?us-ascii?Q?SarzXS9WB8heWCK7Odluq01vcs3RhmjsMprI5jEwuFjHK32VoYY9d/rd0cm6?=
 =?us-ascii?Q?op4rd3xKUyTH7fOVW0mD7twWfP3Ll8Yq0SK1WSqHGDqimSfu+NfGddX/yqIa?=
 =?us-ascii?Q?4gRIEHP8g1tIskQ8PEEuQm3qoGm0X5dsjsgM9thalRYHvgrdZRaxQIykTRA9?=
 =?us-ascii?Q?edS+F+tavGNAwNneI8tdDC7hc2LpRgzKPcvJw0WYBAiIbxd4b2RmaL6gWFcr?=
 =?us-ascii?Q?K9Btrmrfq/7JalRh4lYuUWBwHZtwxUoC0UVafSXvpRlAexCwNp/elp7BYXcS?=
 =?us-ascii?Q?zzQVfWZcHtlPScZTREbJd/qrMPgqx4IUgfjXhrS03j6A+XbKkSDRrS90Yt+u?=
 =?us-ascii?Q?zO4jozX28e3AEH08+QsstHx5fAUfl8RdOTLZftJcEDyAp3oKVplC3rKxShS2?=
 =?us-ascii?Q?rLcjxbgqFCR9KhjGxlWTIOr6M2nwu2mAvex8rgtqoNv95UVstg2f9YCNX0nv?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cacd12-eae8-44b7-3490-08da7b9711de
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:43:19.8743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7qkGH3FM425BWBqZYQZ+wEMd1liY5e8wK/8Z/YQCCiA05MZ6VfUBwg9tI7kXjwhUlyk10GQBC2ZpWFPllA7Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description for imx-scu gpio subnode.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/firmware/fsl,scu.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
index b40b0ef56978..1fe61c2599e4 100644
--- a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
+++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
@@ -30,6 +30,11 @@ properties:
       Clock controller node that provides the clocks controlled by the SCU
     $ref: /schemas/clock/fsl,scu-clk.yaml
 
+  gpio:
+    description:
+      Control the GPIO PINs on SCU domain over the firmware APIs
+    $ref: /schemas/gpio/fsl,imx-sc-gpio.yaml
+
   ocotp:
     description:
       OCOTP controller node provided by the SCU
-- 
2.25.1

