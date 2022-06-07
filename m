Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5A453FCD5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242480AbiFGLD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242852AbiFGLAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:00:54 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150049.outbound.protection.outlook.com [40.107.15.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F2CB879;
        Tue,  7 Jun 2022 04:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkRV2u2N5tKXa0v9PKFcohd4S3R2M7JphkbSW6+7AnbTvyI3ZEy9aHN5OrO9KLVkkRDrlW3P51Lr/hFQRtgPWD0Lc7rC9QaADzAzlk+Tcuk9//VQS56GcS5i/wCBSkTIPcix3YJqnXB1/AE0bnXtFCwk9XquZNYt8jOpR8TBaed22wETG2sTxhunqz6smUaqYXva3/SoF2thOdsEjnYrCZsDm5kx6SuzlawWPucq4524xIwM+5gISaIQCrSVbJ+b4O6r+rjIP7FUwJJxViQAyV5vuCtmVhE01Y1m82FTxxYKo1GZq5TMunrRwbZpUXGbZlOSj1lyNevpyxzR79wf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55h+NaVl0XKl1rtWZy5eTzZiYSagvGWYdlGDWjWDGNo=;
 b=mvIRNCklxXQOTwA5X8vwhz2pB12QbDkuqT8xyp8FSoK4cvRgzT+p8SPz4c22AyRKsF9Qu2Zmra1K1ZkFJ4NVABvk2/x0NIQWP44+rDYsvprYOJlVj+y0ui2go6Vk0RfaG7JyxPQuenRGNsFYtX0RtGX+hBGZpB6K6Cy4bTVYhG+A7YiBLPWbyjRvx92/Nw1Tk3WCzl5Aq7Vwh+QcZydpqyJxZaBhDY7+8UnA6DblYUzmmueZlnAc1Guv5bryHA14w84og3CLNUYr7pRVAKDX5gW3MbvIqMiqCJnPVcOz8V6khb1yuzPT6w3iGyVh8GQloHV5nS2qPM+X1T9LKC7u2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55h+NaVl0XKl1rtWZy5eTzZiYSagvGWYdlGDWjWDGNo=;
 b=ltDElec+PW0z1bI+DLtBDVCdHBFb0PMyKOum1V4Uqa3172fSAs+GNbciRHV+CrjnCX2LAx0Gpq1Wr4fwgKEcw0e7PcRtb2ykSfgdlPTYsSOOflRg7pahKi+0cmY+rEZ42PD03ei730goWQUupKxypcJqYCVifuZf7RT/RQ8Th78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB3008.eurprd04.prod.outlook.com (2603:10a6:802:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 11:00:13 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 11:00:13 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/10] dt-bindings: arm: freescale: Add fsl,scu-ocotp yaml file
Date:   Tue,  7 Jun 2022 13:59:46 +0300
Message-Id: <20220607105951.1821519-6-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220607105951.1821519-1-abel.vesa@nxp.com>
References: <20220607105951.1821519-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0602CA0007.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::17) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c0351c3-aa12-4de8-669c-08da4874e5bd
X-MS-TrafficTypeDiagnostic: VI1PR04MB3008:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB300839318095395D99CCDA41F6A59@VI1PR04MB3008.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHj327We/9WcbMRx29Xwxt86hmYPMoPgn4QoTPxst886kUTAuqZBnRwzfgEtqMYSvvAGK8gQIdnZokkA8pgTAHA301k479CzdvJvEujUakW0eilEsQt228TzZgnqzatcfiLtUVd2n9QfNC2NB0tiSgAXytEMTej4gkc27WJNyd64ZUfWOfHJB9jD/kWFXFqUjqHIRhNT8UhmSzxqRmhUTD4yZD1bmXmy4XNpmbKjzcYhsTmMUN0OKctjDJ/bYIVCRAVAjtvvDFASrRJwFrdbmlDzVKH5M1KHTKxd5JTqi/mrhR8V0wdXCQOVl++Mg+gpSV7HT7s7NL9m1oBwXEiyeLS0WSxca2Y8hdNXg106yA1hohKnvYj5W5jUfi0DY/dAOCGsXNgAYX1mD+MhQT7LGXl2bAQaGPP5rSusTx2a4teZYQkK2R9Y93MrgGNM23FH8ZKy4xggTNOsR5S62z8Tf9It1sykDtEzhkv4TG6uRQwDatFSMkBP2egZGzeh8/1wvf/yIFimVoJ877ldfz+C0MS20Pgf5FA2jeuV6UoXIIbM598M4v/Ak1TNoUbotygzWdxFTGL3lUjGx8fzd/J1R5szHEkffX00UU4PdwKfOfCJIpBohq9/1UOkt5jPPl0k1PTkFrFRi5jovb5s4/3K7vm5IlYPV9q9sEir282oZubjv90uxvIlL6giMt2VR27TT1KRArfAgQsxXSdyfWlzs2tN3+iC6KPkouxLSzZ0Omz4dI/qRSfJvABxQ241/0LsRaE0Yi/faMyRhUiujBPtXnPOA2HZDqpd+ggwqoJYP0foBYXmKy8rnZqoyIH84Eoz3hiy4t6BA3BJnKq7xAj1ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(36756003)(38350700002)(38100700002)(6666004)(966005)(52116002)(6486002)(86362001)(4326008)(66476007)(8676002)(2616005)(8936002)(186003)(5660300002)(2906002)(44832011)(508600001)(66556008)(1076003)(83380400001)(316002)(54906003)(110136005)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eYy1ZdVeMrk5VkNWLQQlaaKY7EDjG8dzmjSAEweBkAEiod1rvBkSh2tWbQRH?=
 =?us-ascii?Q?/YCLk7T1ScqvlzLOxZ8DUGq6XCwb3kkQyjQ9jHx5st7Xr/L4Xn7o2WFV1x51?=
 =?us-ascii?Q?FA3/W6VMEuJJIBshqw6akcAO06H7MNnCbaHLfcn6mqCuuQtriMdM2cmme2rg?=
 =?us-ascii?Q?IU4oHp2E8BC+rQNR1Tx2WCglv5ryQlyr898P2//LZcL8DQsFXaeC16yHTCmQ?=
 =?us-ascii?Q?ZAX5V04BUK9qyXNdd6x7P0+ceMqvsFvOY34yzeE0ipuCSB4rcxL6xY8Fk7PR?=
 =?us-ascii?Q?kCsGjEtQ1u+3mA3cwWx9WA5Ce0P1e7Fo61KDP0Tg4NHCeWzWcPjuRChn/46H?=
 =?us-ascii?Q?2rdt30HymApselQOYAduioFJKIT95HbN3ithamK+Fe/GkBFg7ALRtSAL7RwA?=
 =?us-ascii?Q?H3UAWJyCVNt9XqLn/jRMzeDq74w4+9I4x3ZA+jJhmHVHxoauW1S4HoF4IZ7t?=
 =?us-ascii?Q?t15ei0X/oON5Fd6x700hUL4+OYlX08Hp+85nGyNYNWlyoHwD66HyA3uwcKcR?=
 =?us-ascii?Q?O9r0vR/IV08/gyeARTlma+ATH9sJ/X91QSzgFLj3xaLXIRvIcEWXjkcY8Wzm?=
 =?us-ascii?Q?FfIQOb//jZFVMzMk9ujpZU9KuIsILO2kfsJqy5agfiZFV9cozO+hhap5pZc3?=
 =?us-ascii?Q?vr86+maObYBNF9ueI7pfjhZ1ZF5e/+tGtcBZVJGRM3/NmmiRT7qAPkoa7ljq?=
 =?us-ascii?Q?dWwVpTq1zi3wy1T0i8tGQXQbZyLmJwMJq0onptpqWu+ZXOz6qCtuh/9inbIH?=
 =?us-ascii?Q?E7ZfrPgqVD16pl7NhFAJ+1E5uAr11YOQfZj9yqNfm88l3kSRtnt+SSqV1eBt?=
 =?us-ascii?Q?p20+9uyyxq6txE2Z1tLZFAqrDdB8Lm6+E+1qNbZ+jZSwprazBQltNby8iNoq?=
 =?us-ascii?Q?NtkfNT6Bv0fDBvYKeXY+SWlNP/L7ru59bgSdS+z35y42Ad5knOEhu/t4FLhV?=
 =?us-ascii?Q?E/R2YvaKitY4G+eoHzAomrHMjMNh+rNUmwE2eKbS517OVisShgh9womcborp?=
 =?us-ascii?Q?b+p9O+TWfsw4UQ7X7bO8EtLdmZgD3mkgplKemsq3e4REfXkbpaJzR7qj8fxh?=
 =?us-ascii?Q?wEbQEVWO25Dk1L+Q2ctJJklL/PHevP240IDdmd3QmyWq/bU+kpYmC9SlueCY?=
 =?us-ascii?Q?Bq9JCULKsz/dxaYEWFhjJrnNn6fNLkrDQUkwyiQLtdMQ/dXoGCJfx7mYCU5X?=
 =?us-ascii?Q?U9DfhTzS/ayqwj/B8VVjZDpqe4LBiRTrnU/ee48qc34S9TeLnmDUlpAxXKX2?=
 =?us-ascii?Q?HmAh78JDY9QwpGWLIGQkvS3xSIeYwQmIS8Cg8e0XfwEu/fv+LT/WQoKdejCq?=
 =?us-ascii?Q?9Pr1HDOjp4XbZN+4N6xqeQDOQmCKaO8ZIaQvHNBDinqEamoV8bTKlT/01gFP?=
 =?us-ascii?Q?HStei/Q3i37bDYswBKluSziKLTxew72fwbJyM6wLGUgIcUM+ICQKocK0+89S?=
 =?us-ascii?Q?Kw1sCFwtxAUrJrZL68CVMIJLyud22HqUXyn75WlN1qXh27Z42B7DMI/2B0uE?=
 =?us-ascii?Q?GS2wtTk9GSeq4CTFacQi5emdrJXVsqNlTl68nqLokP5OPXlv5VLLW+xAE6rY?=
 =?us-ascii?Q?T084kdPlbPLuR3o0wgSFKq2tWeHvUAX9m4qLkyKJzcu9/xuInfZ52wqBQ5Jr?=
 =?us-ascii?Q?lTITtZUg/5zfknS8KmAWwR0fDzYWvI+RpPFUBfkDG9NndnxELQUwDdJjGOfI?=
 =?us-ascii?Q?JUC0weVkWAOuTw5XXK1x/9jlMWlYiV72/Edv6Tn/+woeNP4tLmYqSxWiVokw?=
 =?us-ascii?Q?WINaKR7vUQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0351c3-aa12-4de8-669c-08da4874e5bd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:00:13.5710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkQ68hgqIFMB74JcNzmiJZMXu+DX8dVrvov9ZjT3GO+pRKUTFK6QEdMgnt/F1mrq4q+B/knnuguLWao1h/OURQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents separately the ocotp child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu-ocotp.yaml | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-ocotp.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-ocotp.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-ocotp.yaml
new file mode 100644
index 000000000000..1c2d2486f366
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-ocotp.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-ocotp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - OCOTP bindings based on SCU Message Protocol
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  Detailed bindings are described in bindings/nvmem/nvmem.txt
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx8qm-scu-ocotp
+              - fsl,imx8qxp-scu-ocotp
+      - items:
+          - const: fsl,imx8qxp-scu-ocotp
+
+  '#address-cells':
+    const: 1
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  "^mac@[0-9[a-f]*$":
+    type: object
+
+additionalProperties: false
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
-- 
2.34.3

