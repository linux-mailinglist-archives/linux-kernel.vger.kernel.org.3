Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65AA50BAB6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448947AbiDVOzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448858AbiDVOy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:54:59 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7125BE73;
        Fri, 22 Apr 2022 07:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyyGvGaujhSXeh+xHG0RJcTp5QR1UDuVzQoLuf2lXPRZlNUXyhgqwdkbToZVHwLG83EyZeT7P/TQTy08j9FqWd1fTJLSMKyBIokMszMtWNUrPl55ibyHBXFmANC/ZBq7IXeczPhhrdBVcX/vbxNS99TofWNwUp1HbjG933zKVfs8g4S6U+28IQwbVLHPXVrPRAWyAOzJ+AWvS6al0HRvazbDGxmAeuq/yZr7X1MCYNk/MCpixULj+oMwi6RKQn8hMb/pq6CMksRm2lnciL0kmpfr9sqIQb2g3xjJpsGm3z8n7tU22Wo7I5SXIxyxJZueiTq+/yn8EmaETlOAEvGAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RChCXrT67KoBpIukEbUSO1fleCfN5aKYFbekdndiBWY=;
 b=HpD0/TgoLJttFStXCeiJagdjN2SkU6NekuxlXI1xX/h0KyF6J9qxpfp5mCNPQ6do6Rwtare60UtdV63LtZAB2igm1cybPi8zOdQyevvBPwcLdy2KiBJBtN2/UvxP24vdXeIF/qL3b1Qgbljz+uYj1qNvUVyOsLwR9wuhxKRrVRc/4qj4W58d9lv4fMpy8e+kb7XHgri8YUgXb59c6Ft3orTgWrZzSHiIKUe7GzdIl3b2N7bw6wvaiZ9qscL1GZQxnu3c60E7Dw8o7uQ4XrIQg2IvYxEr6du9UvuXz7fPqjaTLT6kabkVDqW+peqAcH/DIyfTKP8jD2YX2BlDyrpoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RChCXrT67KoBpIukEbUSO1fleCfN5aKYFbekdndiBWY=;
 b=JFOeFv847Bn23jx8GoXXQd+duRuFTyrCgSURUW7fzBGiZqCiGh9aERLRLmt4qGYseewBoVJ11EwhMUKziJxkkzQipdQupBmy2qIB0WjNxZNtsA+y6q8jVOPFWqy4Gr0wr75h2FdMn8ZJBw7VSoTd5kXQdBhbVkpbH9H1q+TlJcQM+4/9hhy6omFbUcVqW0gkNscEkvkTIQdKPW7sOFsWSaeMP2OqjlbNTFvtIXbRuy5+20p0c4t0audopvFjdDbsgX0uqo85qZjdzV0DeMD9Q5TyM2Wc294bKJSfSvDpJBdpia5azEiEbxrxUF56j5dSv7VvZ42vOpWrUFt6y8y4QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DB6PR0302MB2792.eurprd03.prod.outlook.com (2603:10a6:4:af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:52:01 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 14:52:01 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 2/9] dt-bindings: nvmem: sfp: Add clock properties
Date:   Fri, 22 Apr 2022 10:51:40 -0400
Message-Id: <20220422145147.2210587-3-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220422145147.2210587-1-sean.anderson@seco.com>
References: <20220422145147.2210587-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::10) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21373054-5f57-4778-1215-08da246fa8b0
X-MS-TrafficTypeDiagnostic: DB6PR0302MB2792:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0302MB27928F5F75FD90750091368396F79@DB6PR0302MB2792.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NHaXjVLwTiBEtWuLaPXBlhACaBNmDRu8q4kGUfD/ilVyGIjRjkWSYeUAliqvkXXfAAPC/WnW1LdLSsIkG4SjxrSrqlusykopmKXcI8kdyq54Sa6kVY3qkYlC/A+um2JOjj7dqpAU6gG9QAlI+4LciSZUDXB5AauoHQvMAtFjv1bH5Xcef+WUfCdPaHERTA+ZI6YuehL3XhguN8G6eFMqTYicbMSaPGeg1SA/S2nTRhGwlWYiUxU5qmslHEn2/Vaa5boYnJXyDr5xwOXZ+nrK9YK3JqpwHLJ4dSbQwxaxhhemQEdn4mtB5bhs0cRcNhj4B46IUM6ysCQt5pcwjUqg6CIoTRlRqJCb1vjwujs9qndDAlhTNksPlBEdWpOe+fB4w5SR5KbwKoIlr3wUgQr6xD42kGLaRa1LkzS8DJkRz14GsSUrLwCOdWDxeoJwOtj+EOJyW1psqw88/lgEFjRGM8u6MqV+02UPHTr33oR4bmEnAXYaoUx5rkegEmHsMDPhULQ2DHpskpFV59j1mT63IbEtvbGMXDrKBhE+ct4Do9a7Ssu4UOX8M6u3zXJ0OQDSQJheGy2v83d4M91p49W60cQiZR52GGgdesoByjd+Ix+/0au8GfoSiYile17ScNcJEMhCo5MDW58UpuzJI65nJ1aPCHYhGQQ5gKsT8ZcjrL5Dxcl4pFQK4e5SxQbRatsqCw9pVfvg/e2c0oZTnNcYtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(36756003)(6486002)(508600001)(186003)(38100700002)(52116002)(83380400001)(8676002)(4326008)(66556008)(66946007)(66476007)(6512007)(86362001)(6506007)(316002)(2616005)(8936002)(26005)(1076003)(107886003)(54906003)(44832011)(7416002)(6666004)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AdxQeqAAkA4vHYA6jATMvUbGAzOm4ON5cTfPOpEIol246KES9B3IpwBXnpnm?=
 =?us-ascii?Q?HjSJEB1/1ywfMmzgJm71V8d4Ls+qo/3R5g1C4d6RirMXEQmdmHjrtxgLreHN?=
 =?us-ascii?Q?z3s+mRJRdH6OdOR72yK3Y3dxKtuSq94IAgGv4hi5PQUsaURLtKOZSsbNtZOr?=
 =?us-ascii?Q?1dHSBaVE2bogi/rEW2QDgqb8HD97+8RdqGI7SojD7oC5NkkXxrdKkxb3ufmR?=
 =?us-ascii?Q?boGZhLmRsCmQkUPqOpIzcpTTQmxnsFw2UgZnl2/cIN8d+OF8vcfXWhB8mPsz?=
 =?us-ascii?Q?Ir/YV5mNF5tUeo+hEuYc5sjadFLIpQEj3mvJG8iM9ax7SkuqtBNSyvN4xKLi?=
 =?us-ascii?Q?fdUkGSHgoPVjARw8k4Txt9R+BkdnPwU3f6+XlIabv9X6NN9P1cfI9c9h8Ao6?=
 =?us-ascii?Q?UzwYKDX1loOJ65HEA/gAUY+zxLERb482yU41Cj/bAcjQ6MsFWNujn6KfTQnr?=
 =?us-ascii?Q?mOMruU8SUtu8U0ZzK0rQxyjZVn/jkNSFkxgXCZw89bRU28ttqz+QPWcXCyha?=
 =?us-ascii?Q?irE2fMg2V2JDMY2/4ByqdIhoXPLxhB4zBqmCr8r2lPBY0V/6pF53lQlTnyhP?=
 =?us-ascii?Q?/nkYkwPQ63snhelRSET6q1JF5Is4H5nme0wOL0bP9tDsB6tXexXd88PpIOJt?=
 =?us-ascii?Q?JHSRD5EJ49NNEUcQaQ1HsJPuaLxDv8hEynsStvfoDNsuNr55nWEOkHxGq7HR?=
 =?us-ascii?Q?JaztfCXmGIIeIOERe3MUZHAKJgUp49VEB14Knuox34SIlxf3drjNG9eKtvc4?=
 =?us-ascii?Q?EF2r+4QRipMKHwJz6+FaZBonNxAR47QGIosfcbvMFV7JzrCLqlH/2elCguZr?=
 =?us-ascii?Q?WRGmoZGkm5joWzM5VLcdDdLlDzJo6TKzem9k2xShD4di7mZbaTdTn4oIfN8S?=
 =?us-ascii?Q?nlVC4SsiX1teb9zKFaKGcLQNN4wfVEKuZNiQzu8jlS7tLwFotp8HLDUcOkDr?=
 =?us-ascii?Q?SelyoTIPxGa435PogS1/YWdd5mQ++u1T/SXe89YOkIOSi7Pv0h6jA/upVXGr?=
 =?us-ascii?Q?y9OyGQFoLproeqL+G3WKqbjFnisl8zLdc5ecEh4EYjbzcl7RE2wgCYCxP93H?=
 =?us-ascii?Q?Ji/r4n8WnJoVF4U2sExRSS06glVF210ZtZ7h0mq6eg0Omfo/MAyXSGTBl+dN?=
 =?us-ascii?Q?SMyfrBdc1+IaZCycTwIkeYIeMzKlINSom5uLN1alN17gpj+z0ntn9dvkIIZv?=
 =?us-ascii?Q?pe6C9VTjQcdSQCmARvASl2CMXcFuGdgezed3OMhVpKkoBIksvDtgMqJOlcGU?=
 =?us-ascii?Q?bEuOsrLyHH2xwX/xfUBMU4jg+zQOS3YGHf9P5I2r+ou4AzgWiEyYRHYE3mrM?=
 =?us-ascii?Q?Q986n8j4B3h79R5/lgpqSj5gUot4RlsgsbN0Ibfm0oaeLXmRJSAeBNF+ucgI?=
 =?us-ascii?Q?l2lBh/3wLQQffMKfGSooO/p/7QybMA37LSXCouKep2CPA1Hmu7s38DJuPUqT?=
 =?us-ascii?Q?lfVO64d+NGpnid28l1onR4sCvz6H3e1yznCTZhPmnfvGBP3Uwgh0O2IRoAjQ?=
 =?us-ascii?Q?CEUZgKHJweQ26/90jJN3mRIL8ucXuLlf5yhE+l7+XfKBQIChQsW2sO2c6M6p?=
 =?us-ascii?Q?wXPDsAWXvzqlKmWYfpCsiSt2VWehYFPsmQICKy789U4KOOsby0KIy5lqKjbA?=
 =?us-ascii?Q?JEjS3wyeogRhITJczyEB8B38O33qfX/jwW1My12B+doZrjAG+MwIuwRcuHgo?=
 =?us-ascii?Q?2HFObeA4P1FLOF9Q/dkvAlbcBk8xwc9R9tdAXAXJSPOk6UpfbkqCt/FWnA++?=
 =?us-ascii?Q?7XYPVBhNoUSZjY9J0noMf86+12GZ9wg=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21373054-5f57-4778-1215-08da246fa8b0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:52:01.8458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T67w9bMd2kGGLOjfYXnJsgTFdUSFFlOKee6C5a/mxie46kHyFdSUJovAdGu9ZQYSdnhufh3LENtPtD9kibUNyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2792
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To program fuses, it is necessary to set the fuse programming time. This
is determined based on the value of the platform clock. Add a clock
property.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 .../bindings/nvmem/fsl,layerscape-sfp.yaml         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index b7798e903191..54086f50157d 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -24,15 +24,29 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+    description:
+      The SFP clock. Typically, this is the platform clock divided by 4.
+
+  clock-names:
+    const: sfp
+
 required:
   - compatible
   - reg
+  - clock-names
+  - clocks
 
 unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
     efuse@1e80000 {
         compatible = "fsl,ls1028a-sfp";
         reg = <0x1e80000 0x8000>;
+        clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+                            QORIQ_CLK_PLL_DIV(4)>;
+        clock-names = "sfp";
     };
-- 
2.35.1.1320.gc452695387.dirty

