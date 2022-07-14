Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4EC574630
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbiGNHxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbiGNHwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:52:41 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2069.outbound.protection.outlook.com [40.92.52.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC43B3A4B4;
        Thu, 14 Jul 2022 00:50:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZLTy36PByk/zgjtex//dluTXi0p+ldMQonJTrYUFefEg3SxV4Mg2wzFoMZ3mautKYjnaSCk/m+ec4UEAr8cUPswytW6yNIlFA7uE25Xg7eWypwgNt2Hxy9cFqHon4oUw9VEd4tgSdKKhAYy0dSyN2XWX9C3H4NWRh5h3XvZ/FVcIaOhwxjOnHAPZHe5hPjtcCI8z6wqCYilTWQwl4t9cwiLsXCpiJulqi0hMqvB22EhjJ1cNKCM3DaHG7FNmiijZxCfWKGKTWBE3KeFY9BkKvoXFtzEbdimt3Y3p8XYsIWXbnDjZyOPsI+WBQi8D5LXNHZ7ilSIFDfqXpATFLkEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRuJzuk28HHObygeIeDKC2QBA1auBskcEwoxh5C9laU=;
 b=T97ErTjmFf+k+L7SMjOyuU5OXlBSnbmqrVQIEFVA1slkCRxrflsbeeoINJyncPTVoW/4awFB7ArOHc5spCkOS/+q5faes/VMdHwr+W7Hh4j1rPzKG+FoVIbOZNfDxOEhz13H4YU2aXR5dcohtg0sCQ7VbqCOFnQJ0FOIVg+SzVE2JFLWAlNk9u3PcsYa2/vXyHcxBcLtv3iKo+N9oI44pVKaJ2CLudfRtyxeJXb8g0gHmzN1SHf3T5+KjTdv3NDvb+rl5MdJe/mmvicM3jKmA6JnD+4M3Z76e+A3T9kAQB9OAyfo3+iCIcsBMTSsoc0nmsSz7eSFu+2bL7pGlJEXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRuJzuk28HHObygeIeDKC2QBA1auBskcEwoxh5C9laU=;
 b=iA9ofhntj0Beutb6gYSuBM7esmYaas/HGCv1xBVrIRCF4IuoiKz/Ox7JVoSbPmBe9KW5Psry1qkZu2jS86r7N10Hiz2+NZyNCpHRWHDUvT65taVqQReX0fDioAseqXlLumE9usU4KdVSYX/Euudjz6N5hoxmH5EYV3VQhLypJ2wnGVmWRx6MSBIoaiTkbFgZuhhCiLOkEztcECdG9xnG524pJOZRZgjwVUjSidW6xbOf8WBcGxReybS3WosqB2aXFhsd1HVPlg9bnmTpwnkbSdxnDl04d2HMmxbEjNAR8f8Kyg61ZhCMfD+UboNbMkf1Y1AKWgPhSNqIAbNA3ndB4g==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 HK0PR03MB4868.apcprd03.prod.outlook.com (2603:1096:203:bb::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.11; Thu, 14 Jul 2022 07:50:33 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5438.012; Thu, 14 Jul 2022
 07:50:33 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: arm: qcom: document sc7280 and villager board
Date:   Thu, 14 Jul 2022 15:49:56 +0800
Message-ID: <SG2PR03MB500619860DC13133A0B5EB4FCC889@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714074958.86721-1-jinghung.chen3@hotmail.com>
References: <20220714074958.86721-1-jinghung.chen3@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [wyepbcFxg0e5Lu6NCE3M4GfRLn4fQu+R]
X-ClientProxiedBy: TYCPR01CA0015.jpnprd01.prod.outlook.com (2603:1096:405::27)
 To SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220714154940.v4.1.Ibc4bdca7fd27b8929b1b4632d6be23fc184e6efa@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd7aea41-1610-45f7-e7ea-08da656d8820
X-MS-TrafficTypeDiagnostic: HK0PR03MB4868:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Sanb4X6L/rPVHaHXti1ENwkIpTahKepe1NmFYQAU+by0Kh3GYvSIde9V5ddjlIfOquRd2kS9S4b/CNO81U2A2kfglC4rI/M6Xsa37RuDlKccjisjVSBUVVErFt3YK768G0Gn8TpuUuNf4fdMh+lVi3ZmTu54gfUMyf1LahKDp1speglQBoE6kDknzycJ5DuNoX4qWRRWvTBvMurgMDeqfpXFFtIroZ4gEJ0FycZFqtQVZy8sI4cDOU8WltkQ7P04dJmwlRxzryN27xgJK1xfXIkMhBYdwCgKtDd/kcKI/DYf3M07FMNGhYloMMBXytrFgEJ8EOM+G2GppHPISWAKi03DCJ1Oh+sOY19MSjFQZpIusRsPGWF0PxVLeNTBg74O++ScMoHjlFRQSpV+4LSV5cVtKHWfZW3ZaYyIzP04F+vYUFC6Kb+oeIYYSC//cHfBjWIVRMq70SNDBF29ULuxIFVEeygzmAsSnj0d8FD1D5mxL2YcEH2mqZ+mpWTIokCSAssUAojaj706e3Tie/ztcv7uNf4ud2j5ROcAuPNN4KlGg+ONWlzecLXXXwioDZXhucDFhK5ESFqYzMcKpxBAoGk6I+t7BTpsxjV+UHvZh7CYQ60rrjVBOvJhd5h7a7iy5lzq53kE68u4PYS16zbhQwxWldPKhNEMpk3//N3fJTMW85IHJ6kisok2FQax4AJDDKdGlHwPMfXfiwYN0SK/g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BL1XfwegyL8e69qVkShEftX6LzYSLnN/0uTSPKmo6X/na176MEUxTsbuEHyG?=
 =?us-ascii?Q?Kgtv2d82Sz+2A+p6zBGwiDcEB99+Rn5QujbOk6cf0/+cmkmc5mOeI7fDYlyL?=
 =?us-ascii?Q?5/XjG6q63nBjrSPCLljsNAK+qRW0qkIh6lX8SxaCvjXDjhinkUdPOMeGXPiC?=
 =?us-ascii?Q?P6Baaim0I2FU+2aXlJaLBSK5vTXG2pTJFyd+a7bfZDY1VZB+xdV/47oYCFaY?=
 =?us-ascii?Q?68TBWr4uPfAyROtjD9iZeRywu/pplz79pTuggotwTYF2dJYXgtFDEwIVx2iR?=
 =?us-ascii?Q?Zi3VYkB1GWOGbt7ok1CAfrbso65fB4c6pSrho5DwxPlYx8WaYn8qozd31EhB?=
 =?us-ascii?Q?kMVdRt+FHeD/1yqC3mscAqkeZ9DT+V0eU4nzVoe63lEyWYHjbXEZLOKsIAZQ?=
 =?us-ascii?Q?v9o5igCeAWrx+AC4b/Akoqwlu/Y5lF4d6ZhyH6g196U+/Mky9G+3d0DhS7/l?=
 =?us-ascii?Q?SLhQCxbv3zMv8zqRtGHY0vN//F14uuv5Hv0EvK/82Lb/Qw56zE7YVcVJfHTW?=
 =?us-ascii?Q?dO7Rh+yNNFGIoyidydg2ofQAnlEyKvxVK/p0WTsKImSD+Lxj4VAnYGImRXSI?=
 =?us-ascii?Q?L/n8YrUbPmn1lLi9f6rfIKM13jSbi/IaM6phE+y8sYxnAM2m73PaWErZkrf3?=
 =?us-ascii?Q?wtKgHu1sjU+nwhPTlgGwAuUkBYMj9W27TXgq5MIGUibUmdQxthrvddQj3KFT?=
 =?us-ascii?Q?SIu0/90G9NHBy0sIaCFeJDJ8wQuUlMu1dccZ5t7zEzBEyCDOLM1tF3A9CYU+?=
 =?us-ascii?Q?62BI7A0Wk/gmRpcJdatJR3WBTglNkyGjqiSiVoRmGcW0g30FP4SIa3xwZmbt?=
 =?us-ascii?Q?bwxGUf842wDOiGH0xRyyrTEvxtJM92MnWwFNWaNfXclj0bVo0bTgv/JndVBx?=
 =?us-ascii?Q?9Uy6ZFzcEj9H2/HxSUCCXA8N7Z8+IE67pkewjqlsidTHk3WuQm4xYMezXa7Y?=
 =?us-ascii?Q?mEDfvB8YMicTsCQQLjDDs9+DTT92voISpki1DDn55B0JDjzECDmgxtVRyYTf?=
 =?us-ascii?Q?NVHcq13N6j369YfmGhXvOWdzFAy59/Z7VSN0gdJP8TOhEPm/gT6pRVqH00X7?=
 =?us-ascii?Q?fZeg6y/SxDscLJRaZMGByBYBqa2IFiZfUOx4jP1QSg58nptqfF9fRNG5T2Yj?=
 =?us-ascii?Q?QkeUHAf/L9k7/KgEWhBmvghUp9kGhjpRtKpMQxFIJyRUpfZAqM5K5rqLxBJ6?=
 =?us-ascii?Q?onCtVnzcUZsapr2JMtF5coc31FmkZv3Qx3GNMvIokQa94UD2Rqpqx4T8njIm?=
 =?us-ascii?Q?iyx4RlZW91gGCuw4m2t/wJAWMq6yUNGON1ytixCy7g=3D=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7aea41-1610-45f7-e7ea-08da656d8820
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 07:50:33.8857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB4868
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a LTE skus for Chromebook Villager to the yaml.

Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>

---

(no changes since v2)

Changes in v2:
-Add this patch

 Documentation/devicetree/bindings/arm/qcom.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 4dd18fbf20b68..a136b1389c2ac 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -529,11 +529,26 @@ properties:
           - const: google,herobrine
           - const: qcom,sc7280
 
+      - description: Google Villager (rev0)
+        items:
+          - const: google,villager-rev0
+          - const: qcom,sc7280
+
       - description: Google Villager (newest rev)
         items:
           - const: google,villager
           - const: qcom,sc7280
 
+      - description: Google Villager with LTE (rev0)
+        items:
+          - const: google,villager-rev0-sku0
+          - const: qcom,sc7280
+
+      - description: Google Villager with LTE (newest rev)
+        items:
+          - const: google,villager-sku0
+          - const: qcom,sc7280
+
       - items:
           - enum:
               - lenovo,flex-5g
-- 
2.25.1

