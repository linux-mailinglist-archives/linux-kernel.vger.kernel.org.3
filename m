Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9EC507FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349110AbiDTDxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbiDTDxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:53:36 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30041.outbound.protection.outlook.com [40.107.3.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ED22612E;
        Tue, 19 Apr 2022 20:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhNfNPsJQzQs1W3qBSeybiKm9188IR3tBe7Z5r9FzQpajACTCbawOryxOS6DXX2Qf8pC0I5ZZsXJ7Sgatyv2FG2H7/T60mIlmyhmxvMstw2+SaDQMAZTbig8aQWpRjASN5NXeiTtBxVApKhqQK4WjUjk/APgOGySg2cM/zN0rvS1LSJVbI1l+e4DpemQMdBZLFJ1OPwAfIYo/BLdC3+3duHmVliQ0a48DQaxCV1EuTFXENSjlYYCmlahJuaJlyhMXsIAy+BES0yEdxt5LMkxqaLm4MgwLsFFoM5d0tjGVhUeapySVYBSS4AG10V0UkbJ0nfXeolWVED44fH0aArYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxlqP6OHIOCvlxRARt3ReLaM7NcJsSeYdUyyxvgI24Q=;
 b=m++l/VYtLNC5O+sZERStqA2EtV3K16Dkv3bPPxtYUPBjVfbR6oOLq7WPyMRcD0hiXFg9fl3x8sle9BdYFKvyt1/oQuJK4jNKeu0n0A58JQoljoPN+X2Guw8X6SBlhd+iCX+MC7LfA4asBKGuUgF4g9IKqmk++mmoX7cigfIefA1Fk0859LiE9GjKdDrlBZxFqh0hQZc8a6QPyEYp867RKxvF1hz/dPcoO8YrLLim90V804KsV2l7AZlsJkuhcmikxZSqKC6SIbO+iv9Y1wVvubi+rmU1Pr8wQO2+mOtIOpw13OOqMc/kXDwyOUULMVNytZDuCDdD9KUCCkbUbMKRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxlqP6OHIOCvlxRARt3ReLaM7NcJsSeYdUyyxvgI24Q=;
 b=N/iADxSuh7HgTuscAhCb8YvkeBaSZ6NZ9xFw700sF2Kck+Gvz/RKGYyLNpGVoYKxSJwnYRRGZCUVhvQa/zsEtak4BaqQeiIc3xfgGdanlWAuBPglU+RmLz8j7uDC8NDAJqEyGF6zMnCKgloM1is3jCuXJTyGatTHuPWbBg45Pw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by AM0PR04MB5025.eurprd04.prod.outlook.com (2603:10a6:208:cd::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 03:50:49 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 03:50:48 +0000
From:   Changming Huang <jerry.huang@nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Changming Huang <jerry.huang@nxp.com>
Subject: [PATCH 1/2 v3] dt-bindings: dspi: added for semtech sx1301
Date:   Wed, 20 Apr 2022 11:50:44 +0800
Message-Id: <20220420035045.33940-1-jerry.huang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To VE1PR04MB6477.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 045cf1be-b069-4303-cf7a-08da2280f4aa
X-MS-TrafficTypeDiagnostic: AM0PR04MB5025:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB50256B2AB5A1AF50085259F3FEF59@AM0PR04MB5025.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtW56lDBxxHmw/wznA4Yuk6xmzXH/fgkxwT4d9PPIsJJzasUFNZgTHK7Ga9sISDAQ5gQ1z0PoVRnXZLoEySKOhRdrqqT65ISKRQZ0wLQ01uPlUdIbxtSbN+jUR+zfxuDPxYtaS85UScdGtsGxuRf/0UVWkpnzmqQ+GHxmGVK6zqG0xIfBCMx+I2MTj4n3uOydCP8GbPwOjN63Z2jF1HYEp+TuottmSp9MxKNvBHU9VCyLkP/b6D7irPpOIPYUGvILHyHnTO/jMNCIP6mWW2wLk8lNvyy15rrLfkXsLYr8MSnGes5Wuznp4bt0P88C6oCZe4LDuLKJUAlK7HeekXfGmIjivXncqXWn1T2UPykGXLGPJcV9GvSj7PydbjF8T4LepmBUPTMg3DW9cUOuVMr2URwL4GIVeARrAGNdPgsgXv8F+CJ4ITQUMr7YV1uu/I/cQtwsxk/SwZPGQO0YfgVG+vxRhg1sBTTjyg7bP1yTked4Joc6k2wLhR9uaz4qdVLWrKbd2ZZuWXSi77yUHeA5iyKESlE8jzYexqbmGzsCjTQyWhYU4DLEymypjnh2CYxZ6YkA6rxw4nrGKozE9+yU4rn0Mq6WDnjYHiRdXUDbtVnoZhIK5DDZ6/1PQHwVbnpBTPw0ynSx0f3f69fSclTOuC3AsufbAdJqu3sugdRf5Ab/BIE39nx5epyaFI4fdsOKYeYITaiy1osWGgC9vGtUvJuBjuj0EDoFfn2+b4f3h5iKhsTUnJLpxoNvO6TPTDUA7reSmhbKOVIhZ7NIxp2p7Iu72pflhabwdqHvPloj6LWeWkTrbz+pSQ4P4hmPGrQsqVqxFfYfNGo8eW5OJWI5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(186003)(1076003)(66556008)(66476007)(4326008)(8676002)(316002)(38350700002)(38100700002)(36756003)(66946007)(5660300002)(52116002)(26005)(6486002)(6506007)(6512007)(6666004)(86362001)(508600001)(8936002)(966005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ED/fCgtHVqYjYQeZYg2ayg6JG7I6RDG/W+k14t+JPWJUXgL3KSfizo3TL5Ys?=
 =?us-ascii?Q?P77drbbYQOkM4siggSLW1JSMbqW5rJjCKd5qwglNEDgqvYGnMyDtEBhNqCtd?=
 =?us-ascii?Q?ci8cHKVzC1guwYo/dVlM/7lrDtow4MRwhwNKqsU94Q203S8JHC2px5qXiqk4?=
 =?us-ascii?Q?IeqpVrkv8C3JKYJVUKn2w4Rz8keodwVTCn4eibAD2io52e9+n7nKPvkkuj6z?=
 =?us-ascii?Q?4MdK32BcTNih0FzpUiz3xyQjzQVF5pmolbm/BkIZ7jRTZsyxfQK8G3xcHTCN?=
 =?us-ascii?Q?1IIKXZ+wpbKl+bUTNAgL7ozgn9idjIv/4SOGo9L+AK6TwqEM/XPyb7Je+FTt?=
 =?us-ascii?Q?eFwsaGLEdGt+1y0pJa8EY9tTVMzeTyq7fPVRQjSBVAzRZbuGul/p3CZ5XuHU?=
 =?us-ascii?Q?Vs5rWYLgcLjnhT7BUY6ENCDjOJv6LM1d8u6d7AtaLP13lQCmN8o6qH8cyO5M?=
 =?us-ascii?Q?VKGqeiAYTYk/+3qUe7gdTJvdclITMwzAZ2ej95G3FwR0uXWbvHPdcZy+eD6D?=
 =?us-ascii?Q?N7ttGmiFlbJC2TPknCcTeycMSefGZXlsr8aW/8obtf/0ayWWJE4cRaf3A5sp?=
 =?us-ascii?Q?swCwS+DQnV9IHzs/6WoPSoDsZ6BzGBCQUBVcqgHDCd0GgQpIChr8/oLvrlzN?=
 =?us-ascii?Q?BflcKgOW3aARj01Zc58BMJt8IfGz4mmp+agwuaQo8UwPmfxIdS6xTXcdj6Az?=
 =?us-ascii?Q?8ey1yHNq4CsJH8f362+Z2eVbB/vIxVC0x53Ex6lGxAm7jzZBXuFe187+ufA9?=
 =?us-ascii?Q?7VRs55jAYlOxdCW33eZn69TZ8o+woBVZ6A3WFZgFt72EHi+UJ720sBdHLSdc?=
 =?us-ascii?Q?lpT/P5Cy46uk9zqCUSg0KKjj0gzH8skWKOkBDRElDtd+hl/iBrasEOpn74CX?=
 =?us-ascii?Q?ENoh/uedED6cQZxqLZbzIOZKp/wUm+fZzYUTpMyqk/HjvVD+l8b4C7TSOcvo?=
 =?us-ascii?Q?ojTzJubjlNCJPemYnKDk+ejAsuMIwW+n+FUmioQMHysBERMKcDPNPbpW0XVY?=
 =?us-ascii?Q?UTWZElNkX0hCBYo+OrfYxFhJnQH2fBKqgZLGcQkJIbTz1qXghWWuXZTKQB2Q?=
 =?us-ascii?Q?icOpH65n5LiTbx+1+uMSS4IWKqBDlXg5TXkCeyqnF9oPCEro4xQbPBLWeqac?=
 =?us-ascii?Q?AKWAxkZ9JrS3DhEp1+L4m9rtDZJMqEw7TwhADwxYvCAZbKz8TUm6lTb1HfEl?=
 =?us-ascii?Q?2uMxHdOACfXNjmv7V45ZuYu4+IX5Ug+FpTDp+Is7eg3SKaOPKjmfF4Q2cthC?=
 =?us-ascii?Q?/wYNpujlbzCuVHhu+jeaa7sKJA8G4d8MAFwxwLOA2YPEDW0oZIDMjLasAefc?=
 =?us-ascii?Q?T3iqE5yN+zhbBTHBsRPuTqdorG3BqbJA1xnTcp0pTJEKndRBUP+260t6IV25?=
 =?us-ascii?Q?rO6Oig7bXKssTMABsJXXpw2IKJ/mdSpohmsokhbT9X8GNO9BH9lx/7QpWJgs?=
 =?us-ascii?Q?1sAsyOhKQqEXeiW4AVC+rvlH4fmtnyumR41U603iPwFeMOu+ZS7Qv+jBkfJ/?=
 =?us-ascii?Q?CHCN94DDzJF1FFJKD1Ih/n1TUHLH+7JulMJHdfUVflQ+cE48zlTYwZUDEZWU?=
 =?us-ascii?Q?m4W5ASFVeEH/mM0S61/JuocPTmtB38bSycR9DuC71JhdACnFr11p7Y49lIy1?=
 =?us-ascii?Q?7zB878mr5t7QHGE0zufGrjcJHdD9fYSCQgQHCBdrdCQSaKf/KHo+dgchUsLH?=
 =?us-ascii?Q?ICnmmFjSXe1aR5rEX8lk/mjme6BsKrKttRu9armv8cG9mWX1LRtnneTy+jTt?=
 =?us-ascii?Q?TFALY92cISbya3j7RZ4XXrwB48W1KnE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045cf1be-b069-4303-cf7a-08da2280f4aa
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 03:50:48.4683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2VFpB11RkDzI7tGK/0CEMC9AlgDsuBb0IwbXeW+M2kHTVYe+xkv+mWOpDYuZY8fxE7bfrVL5iKbtfu1rnD5kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5025
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
changes in v3:
  - add the dt-bindings

 .../bindings/spi/semtech,sx1301.yaml          | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/semtech,sx1301.yaml

diff --git a/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml b/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml
new file mode 100644
index 000000000000..f65fb5809218
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/semtech,sx1301.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Semtech sx1301 devicetree bindings
+
+allOf:
+  - $ref: "spi-controller.yaml"
+
+maintainers:
+  - Changming Huang <jerry.huang@nxp.com>
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
+    mikrobus@0 {
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

