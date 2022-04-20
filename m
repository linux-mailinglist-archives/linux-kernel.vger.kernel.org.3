Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA8150823B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359771AbiDTHes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359819AbiDTHeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:34:44 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E443B550;
        Wed, 20 Apr 2022 00:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbNN44zpVqENT/npo1ptUhD7r72GYN7DtIGtwszIN2qQXHFv1rh9QVsw5/JbWFPjsz6JGP+OxKkvXjB3uJKW230tk7afBHZVXmVU9Wm5epj8QcQ+Di3eTnEFX+j2Ms6nGUteeWBJFX9m39Dyxyfv4rOwigEZFwgK318zDRMgq54nmXbPQ8+3ZiDM5JDB/DX+EENGIiQPo6YndKC5Si6uwvXvEh0NCfdDiBR4GY2dG7rYBKlGiSJAcmyYPJd3njj/ck7bLcKhFvU/+5Xy30SsCBSYbTkcCz2xR38MjFqrfedVCF5dIn6kq0KOcB2AqAGySAsJz8+7KX2JglE3DFEF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fBw8nQBGDRBUdWGdHrESTuPnUT9Rrkye6zwMCyQnDs=;
 b=ZF3s1PsbgKCfsGlbd4dDvLNK9RFywzrIz9fxe995bZ+ZBkk4/94Mqfd7YBUPY/Owts2merP0CA1jDD7pW8BDrRT20t6JrkfwQHNFONaxqHTG5sT3IeZ9FFVQ85+kspkialwWLLsuZSm0Jgds8SDEOrv94/wgIEVRwVif6X5USOS5jWr0n3AczO/08zTT198FORcEmjiqLm+biqH05xv27Wszku5OZH+woXMcEiKMqaAEUcvO5jebdVgnW+goiZXHA9oUicYhGh9ScYatTcdS5KrwmyLT9W7BqfemBaI6zfyqmDHy7kxYDnW3adlhCC7THbp6nI6lM1LPrsBuyu4Zug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fBw8nQBGDRBUdWGdHrESTuPnUT9Rrkye6zwMCyQnDs=;
 b=B0RQmAPWn+trB6d9bFAitWUU1NciArhQxiw8WdGCR9wlEBnYODZaFw3vYHXv6SNUsHxhnIzjuGKHoyT7o4mpvTgfd6XowD2SoKgvxxyP7b0XWd8COOdVOCSn1gnDApRfjmS33+2OPJjs+GeLqi0KhruTuzKQoJySRJ3AbtuFvzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by AS8PR04MB8628.eurprd04.prod.outlook.com (2603:10a6:20b:42b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 07:31:50 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 07:31:50 +0000
From:   Changming Huang <jerry.huang@nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Changming Huang <jerry.huang@nxp.com>
Subject: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech sx1301
Date:   Wed, 20 Apr 2022 15:31:45 +0800
Message-Id: <20220420073146.38086-1-jerry.huang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b22bab82-0d16-4e3b-ad1f-08da229fd529
X-MS-TrafficTypeDiagnostic: AS8PR04MB8628:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB86281A487FFC3E20E74009B4FEF59@AS8PR04MB8628.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XE0M7IQsci1XN0C46slOjTYZFqG54VZ9+YSsewCzfest4bp8eznXcAYN00bW3cL3ylPK1Hu1nmE0iw/XbQVylI+KqQsCsIixzREGppA0mh0alaASmtTpWv8JzAHd7hKMfkHWPOPAmfnlR6I9rvogE6ru6k++U+xv52yDQPCZo4gcqm3LkVlLUgSEr6veRHrRdneoD+SR8k2HNj0rdHzh5/xspVccMOl/jdKIILRoX50gMlXYtHNoj0xvQIzH9DqYTHpyJE7T6gqqyT3eqGe26iSKAFCNX3yyp4hPxX5ogJ18YCBbFYizQLhF0oJKzRfu2m+yAgQ1cuLpSMqGwEMMaHkYRyM5oWraWiz+BPnspu2kvwmTz2LYt9jXyl4bv/2PLLS5jWZiKuGaYw3MwoGV9wA4Y/FMeswl0kEGO3r6gAkcvtvN2h6E7mSzdK6wWUDL2Xpze4cMCZ4vWCcNGj+DQumKEjHoAypul/2tGKiOFOHR/bOn8vdmWTL87gABdUduyPQrHQZ5ajVR4VsCGs0/tES0TAcqxz/je1J0Lv9HJAmbhO69yLbgpM3byJ5+JE6BrcKl9+e5kJFslf0Az062QOnVxxktfBC4Zjhfk6fx8z7Qt3KDD51W1S6JENYRlx6OVLFQr0FqUghta4+/76DHqZRvqpXKOUCn8qJYa2wgxGFeEvfRBhAwuk5lTHtH8lewPPqSIBxSLeXrtpCz+AeqtnjgS5p5PY9YwGIJnYw0IJcTtCXK355eSt7e/ebLiDLHPicJkb6SrVvJQdioa5pI4uxePVipcETDYT8NuhmggVWWhF2n/YkwXhhJG/ppNUrB4DyeyIZyWV52EboF2J7Oqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(66476007)(4326008)(66556008)(966005)(316002)(8676002)(36756003)(66946007)(38350700002)(38100700002)(86362001)(6506007)(6666004)(2616005)(1076003)(26005)(6512007)(186003)(52116002)(8936002)(508600001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m/TNxjx3/oM4iA9p59W7MCLyEjn+mb/3PKbwYgWm5iptIct4J79AkBzy8WGh?=
 =?us-ascii?Q?qtfNdb6ZGio+DZyEiMkRKKIkZaWMq9GTKCAcotDgTrW89fKpEtKULcSIeBdr?=
 =?us-ascii?Q?9AKbCohv2QVaKJtKwpDIm56U0EM948q5/KLxYnarh1WHB0LZapdb0EPdziud?=
 =?us-ascii?Q?blLWzmQ4quwnYJEFtaVUPc+1mkHMJdLJliBxQWRgRooH9hlMO/XKpCnhYiUc?=
 =?us-ascii?Q?bpPYyG8jhwCNNe4QjHVz8D1/cCu+9GWkiWL7eHd/r8vJ5epKehHpl1i6dNRA?=
 =?us-ascii?Q?xl1MR5mrrBxmtYLZyLnLGWmocEkVOul1/JJZ8eNaK1J20sZ9NqFpuWFfGU3Q?=
 =?us-ascii?Q?wbge5Eus9wMlsoM406MIP9Ynzum0da9r8pwgH8/xU9yydjv3bGLGRg0BjLFn?=
 =?us-ascii?Q?pYhYPLdmJqW6o/LaQwRtpmsEhIefNh0Igic2wTyysx6nXex8V1OQGGnlWMmC?=
 =?us-ascii?Q?djQnZvv0r+XC1x7t2lxxFvKldXIzZdaC3kN9BfanPRisgOcEluBjG2TXq+V1?=
 =?us-ascii?Q?kkL5nfD7q2aibB1kTVQxMJ0RmpIi7BBbHWtDjpnU6k5pUMRenaKCCMmUCDXx?=
 =?us-ascii?Q?VQLADGFnvQQPdC6lyqpXj2f7epBzw7/tKDEfvHdHJbtc8Ej3H5U6ql+Dcpny?=
 =?us-ascii?Q?zi0NGSIXRTMVlHMsLS6R/ls3mM/DWC12SJwDr6VCwoYdjpe5LMewPBmgmI6X?=
 =?us-ascii?Q?LePsaXSWkTKmH55JoeUO5xMSwNnqh20v5Ltoyj5ukFVRWUL8H8bGB0n5VkGi?=
 =?us-ascii?Q?gz/zoD8tZlIkT47wZ7lv+iFkb2mFVnxBnfLtCb1EkM8Upd/tfXgMaStW8UcT?=
 =?us-ascii?Q?8i5LvnKCIreGPd3vm6jC+J3oKkGRM0qlzVhGcGhpx30PTyKy2q8yWmCqXWet?=
 =?us-ascii?Q?i/4H4N12VKbqp75jot9zLWzbOk7Y1Ml8cBbGTO3hRQyXOwF+4fd802bXY7OH?=
 =?us-ascii?Q?slosfxwSPEurTH+3QMwI+KRiwDcbTAieGlT2WiopyfFF1gxMqXvlPSAufdJ7?=
 =?us-ascii?Q?zMZ6EPuA0U4GuoltObD7mntoi0ciaYHebanXDZWqRR8zDdBikW/9Orsr8+c5?=
 =?us-ascii?Q?g9IADTJH9ZfJNHOSWm9Z0YYHgwfQ73lviDJ5ldPK3IJPl4omD/cOyT8sAlb5?=
 =?us-ascii?Q?q8HVjoPD2nh8dY+fEC9IL1RVdizVcbD/kjUFpe9ykBD3A5etuE2MwnVpHlUb?=
 =?us-ascii?Q?c5HPdCctqj/CBrrXdwkIRIwNKiLZN2UHVvnKS5fjBeLVOyo49Hyx/rtT4GTq?=
 =?us-ascii?Q?BZ7U70gtL7q1BEXhCS9y5n5zkVVYvMvVro/rP7b2+VUacV4Lox30xtfUy5ZD?=
 =?us-ascii?Q?ZRNpDjZzCEePrxLpr5G/AJFxPPoE0EfWSP6JCGEOEpQqcKcQEnMD+qk5rMq8?=
 =?us-ascii?Q?4N3ffTe3rUy2nSU8jX0jQg4FB0ZqK5PvXYANEvWmYI6nDdm9r5MftrvAEnnK?=
 =?us-ascii?Q?kCf5p+0L3vZXMHUKe3fUfIrTdzK3QN1WbuMkxjyo6JC7fYgBguJLmdda2OJz?=
 =?us-ascii?Q?0D3BP8tgezjFXxOqxOOXVyZdPM1AMO59ffM56OCOZBwYRs5owsev7KSe4Ewr?=
 =?us-ascii?Q?f60jc+EZHGMnpHQwg2IKCe+e9znBtrRISS2NU5LkIh/gJHWssm147HNX3xxT?=
 =?us-ascii?Q?SERJ8hcF2YlBAytaEy1/admGwqQXtOfMsNdr+n5gGdlwjVFbf1tlAqqOvOFz?=
 =?us-ascii?Q?WcmgXlLcSK9lb3HxxadO3NqTuCL7ks7MPrUQAU94P6bywp5k0XF7LTKnlP8/?=
 =?us-ascii?Q?EtpW4u7bBw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22bab82-0d16-4e3b-ad1f-08da229fd529
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 07:31:49.9487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLMjKJg58/QmpA6oLyntTInbqai9dBxeugaYYX2YMbara4ZN0NVr2Sy2OKbx4claaLpuG+20hP691A7dthwAfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8628
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT Binding doc for semtech sx1301

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
---
changes in v4:
  - rename example node, adjust description
changes in v3:
  - add the dt-bindings

 .../bindings/spi/semtech,sx1301.yaml          | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/semtech,sx1301.yaml

diff --git a/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml b/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml
new file mode 100644
index 000000000000..420fe8d23a1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/semtech,sx1301.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Semtech sx1301 SPI controller bindings
+
+maintainers:
+  - Changming Huang <jerry.huang@nxp.com>
+
+allOf:
+  - $ref: "spi-controller.yaml"
+
+properties:
+  compatible:
+    const: semtech,sx1301
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  fsl,spi-cs-sck-delay: true
+
+  fsl,spi-sck-cs-delay: true
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    spi@0 {
+      compatible = "semtech,sx1301";
+      reg = <0>;
+      spi-max-frequency = <2000000>;
+      fsl,spi-cs-sck-delay = <1000000>;
+      fsl,spi-sck-cs-delay = <50>;
+    };
+
+...
-- 
2.25.1

