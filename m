Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF76577C93
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiGRHbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbiGRHb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:31:29 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2099.outbound.protection.outlook.com [40.92.52.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF3A13CD5;
        Mon, 18 Jul 2022 00:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XS+Bmp9yxMXBIyCUfAOdmXVMQsYV3yegScQN2Ved4OkgnmPtuTtS3m/1uG7APgB7hRpDt+Gvu+hiB5wp5s2xzKVsaIhB4mZQXq8GUnkKc0o3hM9qJnT2iv7KZlC0dcVQUwYDpKo2tvajQPDvpcj+V76mkzQcpRb7h22Kb+q3g4ZMH305gs5ZdNNdBSEhJPJpEMLFrLhEPJHpuL3b0Fqz+LL5B3+gFG6Gd/3PHJ6BoNu0gDaJFqpuDvCYnQ4wJdsJOlm1h9T7KK2GpnZifixn2mcEolN9XrV4MberkS1OonXIeHMGuH6D3hCraG1IlcNWWM+RNFc/WROLbzVVOOcRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exwOuFErh7/eR+UF9YDNo8aYCW0/s+7zGIDwS5u1RKc=;
 b=HntXkySmpNQQDLJsf7kHFqxJM9XL4KAfcWOwMCvL2X4k5RtQIBaQm/JoqyWgustxU1vIQn+9iSF8wTgSyjvXmwD0qIbjTtU7mkUrVojdRFDHaOhAf1tM6vsQkn8c4JWwMpnm76unyXA2cjk65cGefcAtfmfLvb74t8vPi7NBiCm2Lyg9AmqhvGfl0+VYi8cvnLHDPYqkrLyWoNhk50plhGitq4jN4TptxmqDJWTsGC1gwkIRJgV85iOnn/mw64++oFiE4bEneNAQ2j5h2RFa5a6WDZAmHsrj5jCFprV23U4UyBliC+I8zmOl/y7LHOA+yMwNfY/ft5e3X4zvWrHezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exwOuFErh7/eR+UF9YDNo8aYCW0/s+7zGIDwS5u1RKc=;
 b=e3vw/XTQp7CJAxcu1Uq8XaXIZi6Xbu8uiGMcJyyZVHg1KFD31dEVedbzsmsOsAQFUvlyeUNFC5Uj74tcXskYuSuxmKOXxvgs69ESBaiTG2h9MPvGxDsGmgvEk+mbgNk6Wxm11x0ipPDDdTbjqXlkBhmdxsJnDsKdjOuFd+ey+niKuG5ZNvlQNo039DEzYbSnmkbTnN84WRn1wvuniOVsriEK8RofCr+p4lIviwYXvSAcSdb2wqNB1BKgP+Og7lfNgAQbjMKam4h0bswftBPyC7GqA0DKKbcHZwlLblW3wa9KAqaPSPckm+WLybNaiLi6338mPj9jsHo7WLrtZG0ZOw==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 SI2PR03MB5468.apcprd03.prod.outlook.com (2603:1096:4:104::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.11; Mon, 18 Jul 2022 07:31:23 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5458.015; Mon, 18 Jul 2022
 07:31:23 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 1/3] dt-bindings: arm: qcom: document sc7280 and villager board
Date:   Mon, 18 Jul 2022 15:31:02 +0800
Message-ID: <SG2PR03MB500654EF43123FBDF5F35C05CC8C9@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718073104.146985-1-jinghung.chen3@hotmail.com>
References: <20220718073104.146985-1-jinghung.chen3@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [nvBKtQ79XO6ISD2mtXEJ4bR+rfmDcI+m]
X-ClientProxiedBy: TYCP286CA0136.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::20) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220718153048.v6.1.I338c337971904724a52c65641f601d3bcab7a990@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a356024e-9174-4b7a-664c-08da688f8448
X-MS-TrafficTypeDiagnostic: SI2PR03MB5468:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: shOX9OffZ7zNoYDW1TuqcAOeZwpa3tR6f+Jh+0NuxXbKSkfTyj0EXTtHUoeQJnKag2B16mo0qVMZaGLmkF6FwSWow3XJhPYLKayW4xO2kjjMJYeLUwUII/bF2WYIngA7quGDxyfllAyT44vVB4aneJ5cSZh+Ve7wIehGSTFa6javpMJXRNAH2bSubdNurCXKPFP6vjzwNsN95nx9LYpQI9bn3WjhO8f6J7XDFDp986n9IAQZxcMW2tCa8yDkThJeJN3cwR0Y1VPSZjIYJ/+VTP9R7VpyYt/k4O3H+K1AFta2IoZe24n6l2uNCQiKiw9k5mT2nnpRmwTapXa/JSqkoBRRvXtc/qYT37AzrR75Bw9c1i5zzJJC/DsefyPNYXcSQ6PaFQOygh6Xed3U5MjFFAr9mxe4ZgkIOVvC9OrK+fhRel7ZN9Q8xwkJKRPPfQis+4lxkpxmIrIr5lzNNVTpf7AAMpY/VVuIKqCL+IXGG4RtTRwkCVwROcsqNUZiAfUYznXsIDVFOzy8QIbAokL84Wwcx+60192Fesc7g6eyGj+fC3k6wY394PKAEDFdui484iVpkAlDzfIb5dZc4vChqEw+4aWCXyxKFW2k2GCDLRrspzdo5/YUKHzHjsyqb/cbWj5tdDsyBJpTyUm5GPJ1jw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QRDypxkL0uKUrkpunfFLrHheKTcQNk2WQJzhrJY2q7nmhfSUFoltt0vtOp5X?=
 =?us-ascii?Q?RQSqxiBhxL5vGNGI8MybFz3B+ng4vNcTHM9lIeomH0aaAy91f9hqTG8N0J8i?=
 =?us-ascii?Q?RWPVJLA5bXK+9TLJdugVcCsiIt3Ywmc4sm1FbySdgvrXouWnBYhz5l6Q4bEE?=
 =?us-ascii?Q?BU6lJmNSsw3I2hTHt0qXnH4dNBzDN1mJwtsgkbtnW/CMbp6FfXzrIEZp4PtQ?=
 =?us-ascii?Q?Aa0p/FBHcSS/JC0//7+LLiAhxKFyM+TXcwWtbk3BLpmmxxvBg4rVNkJEdOzx?=
 =?us-ascii?Q?PI/RfpbfQV1g5gIolrebPvqJodal/VDyVPwZ0o+thCfquCRY/14hIDPOReEY?=
 =?us-ascii?Q?axlGmm6Ngo9nJmGHZdAmW6mB3AH6iWxMhZveFvKeWnH/L3Akov9vdyrapecJ?=
 =?us-ascii?Q?V8YKSB+PIcd9GLl07svd6mdsE13vAoE1giZx0Lb+mMHcFcnsoA+Gt8gOg/qW?=
 =?us-ascii?Q?Fo2whcztcj0A2qzddwB6ZCa4L3NaFWMyoKX8uuFINRHhAkr09lxXPkSZBX5n?=
 =?us-ascii?Q?VJaLdh8DpiwKaR7mSLsXF6f68SB4CoWRx8HohvzCx+u2HlGUmzVJqYPMmW/j?=
 =?us-ascii?Q?X5cZMgNd2FjjG6y44BsxVYjIEIl1SCVcrF5GI19UWfmOeLOW3rnF6bUSDUx7?=
 =?us-ascii?Q?9gwNQwjUVwIW3kaTuT6GZRTWVP2n2sbZax5CRGIgvLxNIIanGgEu+eVNor3g?=
 =?us-ascii?Q?yEcPYw7nWBomLMEtI1UHCSxTDkMGFNJgh9EM4crxGuk/FeanJJ2v7+4aT/Jk?=
 =?us-ascii?Q?w5iizUeFmSr2FgXnrWDZFb5HywApdKyWxmklLskHwLdOEl8JL5yUaX6kR3ps?=
 =?us-ascii?Q?Y2Ql/L50RjeqtU4fL8Rv1xJiWv5NuySG2dCb3aNIX26A/E60YS5+TaiNpo5O?=
 =?us-ascii?Q?sIrcUjgoMoQdwoT4gST+lt0l+bZKQ8XKuJHvDkCvL3ROqYzWEc4rIAno4AMP?=
 =?us-ascii?Q?Ww7v7Fu86v0wqmAABGICXz3jm3wWIYwQ85vol0g9eNtIbdXf7MWZNMRe7gz9?=
 =?us-ascii?Q?oTZB9+j6PQaZnMABvTyHMRzNHCr78hSOt84uN282AeM0ADr58L5U5cZnIcmb?=
 =?us-ascii?Q?W9Sk/vcfhWcZsdep1m9s9vs3R1XMnaesQk0KJMO6IAaVDxD91RFxjDThK90t?=
 =?us-ascii?Q?BNPMtXV0/Iz3CoEbUQpW/N61lXpijJD3SSUYwZXRhW3thEZdfA9GmVD9jOET?=
 =?us-ascii?Q?eiiVbliXJ+kBJjckn1SNwaiWUE63OpaYTbkYKc8MiiuDLeNp08ljzw/F0jNe?=
 =?us-ascii?Q?Z2cHt6y8jMtO3vbWO0NHTljM18vZYrI3z4n90Qwpl31RDeq+JvR1c29vQtkH?=
 =?us-ascii?Q?LDs=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a356024e-9174-4b7a-664c-08da688f8448
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 07:31:23.8108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5468
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
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

