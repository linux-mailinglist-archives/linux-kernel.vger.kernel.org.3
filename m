Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740A457DBF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiGVIL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiGVIL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:11:57 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2101.outbound.protection.outlook.com [40.92.107.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EA89D50D;
        Fri, 22 Jul 2022 01:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AF7vwUHXVHvpbRA8035dbqb70R2sQ3Gbj+uPz+iQtwLsRrCCnx/Th+hxwwgAyoe4WZVaCb/OSA0AqQMc+Gc9xRr6KrEuFwBSuzkT0SY2kdw62KRoDL52iUkIX6b898zx/Avqo7+Hzi/kFCw5KJ/PIYSv3PnrxFhsH1KOnb3jT3nA+9l/5+9DVISRoMZCMCScdMNctGCSlmnq3H29uvC44NPk1kl7VkGi9ctcNDlr2ohFFjXiaCWwns1wJBrfT99ndJp2FQteJozqyl/zke12PoRjTTmvI7xqOY7fFHB8XFYx1AjS1ecJHqVbxJST+7yDwous9ZxrSExXZBFhrHHp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exwOuFErh7/eR+UF9YDNo8aYCW0/s+7zGIDwS5u1RKc=;
 b=KvqWTMWFmPbdx7OPWDErlwShT+ga9TdOyoZrFNNml7CH7/zTJwrBAkBA7gZNh/S2iuEvtCtUFaYyMb9PAHmhC9t4PFPSqnJEUU7ZWtA384tK4D7MZkWQ2ww3G4wWwe6APOO/7ovp4psE+hgsE8rjteoxU9NU88iiO1sjGyzbbVvnqyOR/qXh7hv93Yofwsj6THuHFpPoHvX/i84YR9aep9hHob9ifOMJSWx5I3Jgxa4inFBulct92a4NR+Zl5q+RCSfCwFZE41YwIU9LauoXLeYSBWmD3ctQ4tB5meNLj0iMrZF4gdOmquIngWhngBviyVFFZJUYrbFeNUd0UYh8jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exwOuFErh7/eR+UF9YDNo8aYCW0/s+7zGIDwS5u1RKc=;
 b=AnvgXl/ZNsBvrNaylRm92VIdNOOii5q/dBuGSfdlIFH94MnAvLEWHH/Pq1MXe6GAFr8yEp/9OOVAV56wzNrkUL024WvwDQTWYgUJ4Imc7giwT42dMIXcZBGhcKeuoZD5/A6SKT6fKt8izVqRObxqpMGBWso/AUi3O/6RLvDOX//zIa7K+2ECeYcDbdkvRyULpsSy/AoM1Zg7FRvJtpXE1wUGEI/+aFsCpFV8YYvQ57jAHfLtUuVYXuzn+x7RV6XnKaYHS4LSIIVbMGO7ffnbPkqnY0Sy4xtA6jLKKknfmV6U0lSl4l1ZXEbPljkPQWzVNpv45jg//aLbT99pP1el8A==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 PS1PR03MB4889.apcprd03.prod.outlook.com (2603:1096:300:78::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.1; Fri, 22 Jul 2022 08:11:50 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5482.001; Fri, 22 Jul 2022
 08:11:50 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v7 1/3] dt-bindings: arm: qcom: document sc7280 and villager board
Date:   Fri, 22 Jul 2022 16:11:25 +0800
Message-ID: <SG2PR03MB500658668FBB9BE1DC2B3F24CC909@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722081127.228971-1-jinghung.chen3@hotmail.com>
References: <20220722081127.228971-1-jinghung.chen3@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [AhGeGsDN1XU0OnPAP8LvcuLcTYZT69TY]
X-ClientProxiedBy: TYWPR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::13) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220722161112.v7.1.I338c337971904724a52c65641f601d3bcab7a990@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 826479aa-849c-4df6-4f48-08da6bb9d3ba
X-MS-TrafficTypeDiagnostic: PS1PR03MB4889:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jR0bClqKJOjwU8BEFePq8nIFbHLTmI4f+wCLS7DX5Jz4TAxGY9gGRDEaYl2jArDCjf+MbZRblU091w7byS9zGyxnNuP8UcKcJoQ7tY2HkVJWOtkebbQav43rO15fgq+c8E0e4PcUxUhChN18E+2CMui6LiJsydyou1U9PwHb/Zivq3JQcpdHfh+OyNnl4m7HZlvGX8ypVEYqoQ6hTGqR8qU+Na9LgpF3c4Wlmjw+9OlCOU/kSEb0Yg4ZQeWWgEGqCIE2luyMs/9og088JUj9ITIR8xBGQ8HUGOlIqb3f/GoI68yX4blkxKgawmMpec8s53IJ20jAdjnSbU15azUxtWHpX0i3K/hIn4vfUDBDrg9aUcLsxMu6DLrdCei+fX22tmoNEncPZhlXZ5htJPn+VAAZm3pJKC8h0NtMTRNVTqxQrVgndSkd7Ab5CifGi/I5Fmtzmr+Rbzyh7npPJqf1Fxpx8mkO3gfJeguF5Go7GfVMlpbA7zNtqreqivdd3JILRmKKCCcCxyQ+Po5hogJUhK1RFER8SBz3KR/ahFK1RycU1Osj86udi4B5Zq2coOVbG3acKQn/7VN7nTiFQ1C1d7DK1Rtu0MY2BjJEdwVN+6EkA+WQRdDKYm7LcH+MpEYw
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bdrm7s+iQIXlCfu1CyhFRGCZXKvJIrrLiRIlISXyVyoFNxfROwIv0tGU0yn0?=
 =?us-ascii?Q?OAM8aDT3ZKEDgDrV3M07TBRT3vCYAl2BajEXJXIhgps09eAWQoJAeHz8haQA?=
 =?us-ascii?Q?GGG+99mAVxzahganlgVXuTM8zeRBnQ/jGdu0jx/sUUU5yy3JOorgnOVUrrYI?=
 =?us-ascii?Q?aRtqx0wo1YB87YTAc6jitUYuJDtNpRN7jcBgLbBH/YnXFinUT8VmWRiCwDWi?=
 =?us-ascii?Q?hNF84NRdgxVAic535wkuAufbsaWIEvtZn/VQ5+5YTgqYlLc4X9hZtDmQGPpk?=
 =?us-ascii?Q?mxDKMAocttGYZ1opMgEgjh8Xs5zy6dJQEm0zlaZz55grUo6hGU3DrfRObRzg?=
 =?us-ascii?Q?v3ljMSGgGq84MzfMZdb8Lp0a1n6IXk5Vr0hLqeJ9UFqSonxEjp+UKx0KcOG5?=
 =?us-ascii?Q?TBihfvewjrjtKkNUlbypvCyZMJNnpx+bCl06NVgWVcVRU3+by88wjMOoAIkS?=
 =?us-ascii?Q?uSiSf9YYNeP+hPELLPqldAUbQIuN2Q3lLYyvKPzdgbO2aoaQH10BusuNZO6k?=
 =?us-ascii?Q?NVwH5wP6O7svb7Tb/1T8PU948foja2IgD00yqrvKJAAgtKcfXy2aN34FQJIJ?=
 =?us-ascii?Q?36JwSlqfx3swME2i4pUKq8wlE3q2uspTsPsTj6L/Fgp854YQW4eInH1ty9G9?=
 =?us-ascii?Q?nL140SHPlVt5NChBGBpSIMEHEgveKGxUYfH9qSyS+QpNdaux5N6OL9th6ZMa?=
 =?us-ascii?Q?QlUDqXKe69w13hQ/SOV/kn1MVXuZI0RcA6xvlyRzQFxgYaaoGsIUfPd60lMx?=
 =?us-ascii?Q?6Hm+xK32WtoTqJf2eDzVoiVIfDWF0GrWW81SHRGyyhgUMXgy/Bv2IWpCR8oF?=
 =?us-ascii?Q?WcG2N1exhjI8PJ5YzQrLIHyCvW/9HpaSVDJnVVhwis7gjiWuXqgLTwq6IXBK?=
 =?us-ascii?Q?NTDrituLpPo0PX2MMpdgq+rKxbFTQdlWFZSN1T0BnJc7vcK0Zp6mseM5kbMn?=
 =?us-ascii?Q?FzqNjHUb0bHmC8IsqGPobkvwpHTF2a8fw+LeYSwJRxvu7xx97DjGHzwq2L9k?=
 =?us-ascii?Q?ae58V/jbntFNgBfcTALPv8C231K5k9optSLyqp7rUUiEpj3Pg5w99qYLKJep?=
 =?us-ascii?Q?Kedxlz5VYJY9HakVMcBqgmdXFRCa3dDQdtH6QM+L9NwnCfrqDSGOhESQCObM?=
 =?us-ascii?Q?5Essv1+bhqH8JGCvvFR7AzHhqusauMq4BHNY45hXrFKoPlMJ1y6YCl2xcDbo?=
 =?us-ascii?Q?0qeWr7R3T/muQO2TW6mM0Cg6TxErSVJYrN8KHIlacqdDw3004varbHqUm7P2?=
 =?us-ascii?Q?QPou4FhJWsq4TIHrGkTXNGkyLO993aSmEI2x3SaeGJybyZ2e0vbZNaH4Ue6j?=
 =?us-ascii?Q?000=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 826479aa-849c-4df6-4f48-08da6bb9d3ba
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 08:11:49.9795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR03MB4889
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a LTE skus for Chromebook Villager to the yaml.

Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
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

