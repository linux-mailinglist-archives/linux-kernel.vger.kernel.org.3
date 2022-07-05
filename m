Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BDA566199
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 04:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbiGEC6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 22:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiGEC6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:58:13 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2099.outbound.protection.outlook.com [40.92.52.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAFD12D05;
        Mon,  4 Jul 2022 19:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL/3t1zoB8fYeQ/6Tct4ZMvswBiEFtB2NmOXnwk4Ocu+De17bO5o8hXN44PkgKxClhl32rCH94DEDotzp86mA50cl8V6pzVf9ix3nH5eIQEqBFodDF7jtU0v/66huKZMmO/q06IextZ3D1O9t8v19vmC796rElMf9zxbV1exVbUdXStvFLZbu+mTVvu/P3hHqHg/5jUGgdZ2NHblrS4lt9NbvVKJb67+GEA48pryoXei6xnD18urry4T0ejHrFYt6qxNiA7iyyDRfaepxZVqTjSXY1hzmGJnZ+QW0zrI72S/VEfPysq29Qvj0eVKpa3lm+atqGZtOMVwMlrZ/wE4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xu2QCmmsgYW0wcUH/dSWvo7GOsQf6oQh29SYx0FmU7U=;
 b=TS2Y76+Sfao8wuxU8hp+hVZvCotylPHCaX8hJYn1Ru9tFQc7O5JjisvRXGGDPOobNRzALMOKonP13XYv+SZ9+uLhKRKI9L2Ot9iU91zjidVvkKo87HQkzz0XPGu2+0jIzDFwlirEwBoOyjroRnImyeBiPzs9yW7qSm+acoGoq01NdQwXYyHD6OySyZ/O/fSe6+5V3JBLiZHpBQd23ErVJrjtr373gg0HkrVa1fIKg4nGU119xYmS/JBV5Yxye20viAex9Kxn0XjyNEAqZ/FWXZqZfDX/MbnYt5qM3InAP430LfuKKfB05xisPb9GxocowwHStHnD2HWg8q/vo1ke7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu2QCmmsgYW0wcUH/dSWvo7GOsQf6oQh29SYx0FmU7U=;
 b=Y0wZz7bU/V8SVaRQ8J2lqxKz5+XP13mK50KJYdNnA2VqSyPtna92Es/qqe2mOlmqgv97RnJ0fnvvHJPAPwOVwusk1752ZpuajDUFLOdg6X1PdB7yeBQjskISllYlszdsv+kaIJIfL3bMtoIZl8lN+Cufkz2cgT8PHXXzZyX2JD+B5wMiKD0V1HfhzeYy4sDf5T7LJUi5jkIWodSaZilGUadnZsgoorEliyslxQk1iiE0HKKi3oSr6ZlbU7SzYNBa97iAthlUmowaFQL1E0QiEQHn6fnMC4D/4ZquTlcrtn1pYVvA9x9isep0oFlrQNiLJsAn50vUf6DUo9xIwEkYXg==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 SI2PR03MB6461.apcprd03.prod.outlook.com (2603:1096:4:1a1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.14; Tue, 5 Jul 2022 02:58:06 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5417.012; Tue, 5 Jul 2022
 02:58:06 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] [v3 1/2] arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
Date:   Tue,  5 Jul 2022 10:57:47 +0800
Message-ID: <SG2PR03MB5006CBD49DB3052D57A6ABF0CC819@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [aKfn2yCU3H0Zl0JnNC/6gyhcLRkTHCwg]
X-ClientProxiedBy: TYAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:404:14::27) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220705105730.1.Ie6e9ee9bf889abfdd1a44d9f7a61b62c0c5c97c3@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a893f8a-b8d2-4040-99f6-08da5e322ee9
X-MS-TrafficTypeDiagnostic: SI2PR03MB6461:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HjC5U5Sc5tqrRNooUF0bKlaNYS375UvaVGYCVfZM84j2n7VqOT1WocdOvJ9H3K5FmtbV+6La6nMfaFl1k2apahTYRwTTSEYoGxvNQjE/nkkDAX97Azs4MNi+DfSSRcTbjSYavS2VsJ5j2fXdIBRW3e8EB36nGhdwsD1KiVYWbD6V2hOMPF0Me+OwQ8s5nLGLHMOG5qjToCYQpJ11KzuZvJsthiMcWIGr9ZSdajGPJ352bQWqGXMiN9DZlFZRYW9dPgZUUBIl53mrTOL0A+ShN2CkzPUrcNOQDQpxAjKdy6SUN5wJpiWb1KClavzmjWRIstO0SHZHIYGhwO0jz+nwcyrlbmbDHvHJE2TYczqZtHpTUJvn/vM/CtZdYs/A/86XkyuQ6A2NcmF9RX4BHmbfHjj7fU51/zomGWZkDBlh8MK1F3oV0qlsVIFKcw+OlsWl+6SOEYy4DcgA8x8GXL+aB2GAV8en5sEyhdAeISYPB3g2gl2xt2RV2DInwifIyGVipoeph1DawtOP0+n5T0zYVZ0h8b9Nw6acgqoOYrZTnTXtNb4jpWc0guksRU2xI5k3UOQE+h5PWjeocmUzjD++zhUIWVVESpjlR+sGg1UQz7r5C9GwDUZfGRWduqqD8vjAsGe6/VmlM47J/KMIc0jgKA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FfXXnG6wsV9t8EvWioToxysd0/ZbRpmwi6WtEa8o8M2aOPfOneWKkiDKk4mx?=
 =?us-ascii?Q?d4Mj8qxV92UlcuX5YtFqbcVTB7g4DuiwQbt68opiKX7rK9XJVgfvKryY32Dn?=
 =?us-ascii?Q?qigTx4uGv43rm+R88PHNOBf/YuwPLr7i21Kkvir3AIkS7P7oD/VHQkZtCSJz?=
 =?us-ascii?Q?oENbRGqf6jl5g0xtqpRgte+wuiUpyHiiwM4ZqQpoTA0oO8HHBSEQdXyP9JKy?=
 =?us-ascii?Q?8ZFyaowdDBI4eJXcssV3LlAuTzYx1AibZUVYGrAFvNtptN33IqGc7E8bFJQx?=
 =?us-ascii?Q?wRMo6rqJH58I3y1y27o6FYv+92IrkpCtzqytyzICs3Ex5BRyKp/WyLi23i0O?=
 =?us-ascii?Q?POsXrOM0BxYAHoIn3iPdvB8NOQXRhkKkcMTLC5sXJYHrs8/KXdP915JKvc/u?=
 =?us-ascii?Q?0XpNnsCKFLeLgE/+VbVVMs1Gn4vz3dBzsaguA4IWgwxSRRDrKrBtmQkdjlpZ?=
 =?us-ascii?Q?3b9JHOZUAgIWoTLN7MVwR1rzNL5+y4HH3DRB+sJw5CMw/f1tDVDEY8fOe/Y3?=
 =?us-ascii?Q?ZzcECDoMHvkTEqytYkWR4fAQTVhgrxkmiYCBJaE4mu26QOvoCofaIHXajZ9V?=
 =?us-ascii?Q?pWqkzZBwSl3w0wljYgu275uFJIlqtjeXPyUjdSZTAAkDWEVflU6Iy8vt0pn+?=
 =?us-ascii?Q?FfGX1N1e1pEsQmV0TnryUut64usStss1jGYNhnUKD+Gw2yK/N3g6ATFC/VLj?=
 =?us-ascii?Q?aC5dEiyBV4Aajf4S2lTVD7XTM1lD0Ric2/Jnt3A6rXacT4HDpbX2S/eedBwT?=
 =?us-ascii?Q?gk5Gr07zEfUW7MfJ1fYXHwpOjQLDiHuviD7kd4gekZJX78n7NBwWnBtO986r?=
 =?us-ascii?Q?vrCDZltnmqaXga/OY3QCtKrMZ7Fn1XAUWfXRxCAz9tE6A/WN8+qFd2+kwXEm?=
 =?us-ascii?Q?i+QmrOnwpwQf63VjCrzTgZbR7O5ZWjU9sBSU/egnSaN7OldIR+uwZKElLToF?=
 =?us-ascii?Q?eG5dBgYIu5L+f2NoTx0sEY/uJ+4LLSyF/mesL+eaNacrbw8oOWjMXVoGNvKY?=
 =?us-ascii?Q?Duy5W1OQ0CQ4gCPJiAivrk5psoYKMjcbIoYQBhF/svU6Wh9RILYuWXCgcE+8?=
 =?us-ascii?Q?rH9efTcEa0RkYZNOGPOPJm73jChQ3AnWGBZxz4yFCf/R+wDzqQoVhh2biHUT?=
 =?us-ascii?Q?7o6CcRnk1Bkp3KYwqEHDCDDZ8x4DSN4H7cg0p1X4GuoPn8UKIp/rzr3r9mrj?=
 =?us-ascii?Q?yNyNXro21+pnwaEIA34Q0dR/HFpGGc26YJxmvruBzNZF09EbdKM1mWsx4+3D?=
 =?us-ascii?Q?I1CdTLdvssJJ2oEvyJRVHNXBpxS9RdNxXRUeRCtOaE/72/RVa9My708a8B9q?=
 =?us-ascii?Q?hp8=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a893f8a-b8d2-4040-99f6-08da5e322ee9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 02:58:05.9470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6461
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a LTE skus for Chromebook Villager to the yaml.

Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
---

The format of the added items is based on the below document.
Documentation/arm/google/chromebook-boot-flow.rst

Changes in v2:
- Update the patch title and the commit message
Changes in v3:
- Update patch title

---
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

