Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8415E58ED56
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiHJNb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiHJNb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:31:27 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BC537F95;
        Wed, 10 Aug 2022 06:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHXDIsKZ8WaOBBV7O5n75m+l9c56fdLHGzFZYWR+Dbaiu8yY69deANeVe5rGk7PggrUpVq4VXQa7ZauOTgs4cgoOS7POWXla0suhGaGSIqco/K2cPSzApCr4KJgEKTlls/pV2kz+kY2ubBx5jeXOZ3i195GCNf9Q1IMs+FcB807quW1bM9bZon6wkRsIpArc0zguUUrbUpSdZCp4i7JA3lHD5cJSBOnrLhdfR3MJPd5+odySuh3M4rBDtDw5uLLYChlXs3QoYmO1w9Yh3Li6Vej7+WGbaEtOzguqUmjsUqkFDvbYsR64I7/6PShmogml4LXFfJ/3JJYipTE4dnwyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZhEYKDCGCye1ggPV1h/VMfHtFa06yozuuJkWhLaP50=;
 b=iKHXVtVs381jzftx2GoX+dfwmWeHINQOwPkjfcq9g/UcqP3UfOalDe/KXCDZUsqmiDc/CDs5UEPW7IuyUX9FDSAGAY/XvqpFbHH2cf3/GfLPrII3Tq5XlMHMRx26mjiDeSXxKRoh+h2wqxdYLSkAmFpmUDTn9NtJVksWRWf2Iy2QDKO08rMSPgoEJlsegEygf9M+E0NNMUjPdqV439kRm5FwTI4MXGlWYh8PAuZm87TArG1IE4uUgpy6zqN7dji5hxxDP5UnLRbx1VOzloDH5qU1l6YYB1vmikDnyctTOOv5nprrKdubJ0pF0KV/N1lSmmsQ51RP/ZHnHfYnUMrLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZhEYKDCGCye1ggPV1h/VMfHtFa06yozuuJkWhLaP50=;
 b=kOZfyxpei/5opnwwlfnw1Zj4ggCPc26QeOru1mDQptGtZ6L9xHRedyvqsL2WHnj1rlbl6euIlJsIcrCSvOJ7UZlBSj811fgRINjw2TP/EoHqADxreFal/5zqVzg99cTlV9rMXMcknZazj3JC9X6y4+X4q+bkc7pKc+wDEYh2FAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Wed, 10 Aug
 2022 13:31:22 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Wed, 10 Aug 2022
 13:31:22 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v3 1/3] dt-bindings: gpio: Add imx scu gpio driver bindings
Date:   Wed, 10 Aug 2022 08:30:03 -0500
Message-Id: <20220810133005.74653-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810133005.74653-1-shenwei.wang@nxp.com>
References: <20220810133005.74653-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d172922-6c90-4e4b-fad2-08da7ad49d64
X-MS-TrafficTypeDiagnostic: AM6PR04MB6630:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8HBRsKYfsYa6bQeL5FBMltZ9wr0RIF5wIbO+LL294YeLqTr3YUJoMuKU18gxkxCZnG01FpSZTW3thk+BsO60akC4eKl+1Yvaq8wBB24Cg1iuXUIHxuRn1FMq7od26FD5zbfPoyavcfBv65g30RazuR1FW1y3itC6/UsahRL3+0kFqES0FLlrJEtxD/rCDInG8g0LsCcHbyGUs571yjgOavV2kRjGLybs8XKMtvPZYa4ucfZISfDngltbRmQiSPeCnvJdPsms3wdOmyO4w7KxF/mAFIa5cafSASOxpsEeoJi9aOntmaYO14SMW3pHPHeWFuzkQgeCZnJPitrqd02wjT0cGpha2rdTa2HqbrkUhtJuIzDJCW6fJ9bcB3UQtORDKrG7f2EEDjIhi/DZ6PDUpxF8sHk7qMVXzOMnC+49xE5kydEuNwr3YEkwwv3aAtD2zfOn4YcbpykZ2SzzpFwWrTv143osQ3OoywigkboTTdeqeLd2W1T3xaQ6jvsm1k5P4X7HVHE0MY1yF+XAqvlBjiXokHY3EhTEYtP5AOXQ8TzrEeyAcTlHrLe88e7yYxBFdin6oIhUCEgy7Cz449MDXJZH08VT4/rI7XIv8CkEgOdQl94DOqMmNx7DnLYbk2KttBWO2F3CDhrRa2niFHwTZAixYWlImAOcuEUSwTdmEQxboTsPfIetAGqL0vUbUPZ+d10OFNbAHtBid2afVRqmq2KPDtiJi/9pyLARGrbpxc7NgSyJVXgSs8NohawKbqqLs2dSHkCLxTVeGfFV5D2mXEPZhcDQoj4QkfkT3wemkm/UYwmhQ0aaGG0BOLD5bxS6cmJo6IQNw0d9tgQxAf+RMvoAS2JcTiVn/hZWWNzfbla0zrDLCFrF4nGp0MCtQGa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(478600001)(2906002)(186003)(55236004)(36756003)(8936002)(44832011)(6666004)(52116002)(966005)(1076003)(6486002)(2616005)(316002)(66476007)(66946007)(6506007)(5660300002)(26005)(38100700002)(6512007)(6636002)(8676002)(66556008)(4326008)(7416002)(38350700002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CjUaLC+TOXJ6/aAI6hwjScqIdgA+40VRNq4muA0vrpSCRaYLEtty6h3cyRl9?=
 =?us-ascii?Q?+OvsvNTxQrKN41TwxacaRTKZBi9mpikpMwcIarA2joXCC/8VrKvQ+x9UQM7J?=
 =?us-ascii?Q?A5g5cahA4via23GBbMWgFYaDZ08s7hDU92RxWfhxwwTAEerO22FrjPAcCBQ8?=
 =?us-ascii?Q?RLfUpidDvAm5cR/KtX6a0A/bZyJKU+tLcFG17XlAPgIMgmsgNVBtz5mzYrME?=
 =?us-ascii?Q?5THk16gmiK09rISZm7mm/0tUiuoQ8OuiF0XK7HFsPyTx42ZWo2v8iFSMQfBW?=
 =?us-ascii?Q?NMnjdbSH/SMkkQKPARWDyi9jJ4DDErvBcxH8pshS7SNeWrmn+AuPcaNPraLk?=
 =?us-ascii?Q?9ddErKTMcJtKXSfdwOZDKB0RSaHZrC0sM0+Tc2ocCC9yMf2HyHolK2wYnPH7?=
 =?us-ascii?Q?EX5O1Ae0FBBsHrsq3oTsbxXJwr34d5k8pQpnb03ZrurjeGa1VV1caMTDbMTj?=
 =?us-ascii?Q?Jhq9mUopv5yHuhMtZTabzlgTKHgqS2C7chXDG2N+dkVB3iDMx6EFCTqqGm/n?=
 =?us-ascii?Q?E5b5qrW2l/LzgTc0zjYMp7Lw2zJzg9UaKNDloboDI3Y6lRQ6DgUkpRuFDBWc?=
 =?us-ascii?Q?wjpdE/6ZHJab/vBINM5KBdI+RCuUYGUBo3ss7c+JW3V4orL4yBfifU37M4Ka?=
 =?us-ascii?Q?LyuxNQDYJcATabidp4VE/zKE1rNunoQEVFcg1WCXE1JzHNCHs2Okr0GbEUQa?=
 =?us-ascii?Q?2oQsjqq7s2tTCczPqonu0Cmj10z2dVMA7E+pcgsnpw2LaMxTODbIphCeIR+A?=
 =?us-ascii?Q?XkGyJIcsRrFwg6ZZL4qEgtixlZV1KXjKcJJVZQ3+OmUJE3BjnTTb0ej2Ugnb?=
 =?us-ascii?Q?nxVmJC2yRYlwfQuieoStVEQU1X9r7yDZXn5NEMuf3hhv2v3LR0JADZR6FVes?=
 =?us-ascii?Q?C6+KsYSieq7MROj86r5YEWnrZXjyOHa0ODI88w4SWo1qZgzLEDHVWlZZ5a2z?=
 =?us-ascii?Q?ZckhMb0rZe5SB6oOcp47pr6Yw+rnC5VmE158+D26XEaThX0BqyIfsHtOGq56?=
 =?us-ascii?Q?rcHK69+P+1QDQXOXocozCeLhEZ5MkZ186UZuzt/NTmSIoqpICexQ0q/E4wFF?=
 =?us-ascii?Q?Of7PMAvQgL7qH5BQsNMW3oqCDEn3nRVt7il0G9NJo68NxYQjy3+CWdYpx+s3?=
 =?us-ascii?Q?ZEQ5EwXU8r88Cp81q/QR35lvZap6xzXDBlND2bqg2ASV238koTe/Gk2jwcrV?=
 =?us-ascii?Q?D2sMRi0l3K1jGh4TveP1wYlWT7N0IIN55V4OP/VXzd2bcbqQO5K3sVvpJPVZ?=
 =?us-ascii?Q?M7b4ODZDPF2u+2w9zKpVKGFecMuIgpcExJzvwdsOdiC1HAJtQXisCKCWJcRF?=
 =?us-ascii?Q?33/SQqoXP2gF0qbWBAwFyXR2npDiiv8nqVwggDnMDpHOIkfBDBT1FuHG3mxD?=
 =?us-ascii?Q?hr7V4y1xjSHEQWx7hShqrUvOaI+P8xXFy6l8Plpltb6+LdU/qyk6gp8gPf7s?=
 =?us-ascii?Q?5+wJd9XRrHmF8G3Sy3nIXHp2NHzRUgTtllOSVWm79F8wY2c5epmQOkHKF4RK?=
 =?us-ascii?Q?p4jQAYEV3XEPoIT6CCbgrhM6pLjIPB7mS7daC7sjd+YisKvvjVm/W9gJR4iu?=
 =?us-ascii?Q?WYqrHxO/5YNUnh9IvqaPH9QNQHvYivqWp3/zELErxfMiHFl+MUtM/gKTsSyd?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d172922-6c90-4e4b-fad2-08da7ad49d64
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 13:31:22.0842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuafJIl1dnkinM+iV5OLKDA1iV9KfCCyW4BHaW/w2ounqy1A4NxpUiqwKCG3e7i1wO/d0UoJs5ry8i/249bEKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6630
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for the imx scu gpio driver.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 .../bindings/gpio/fsl,imx-sc-gpio.yaml        | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/fsl,imx-sc-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/fsl,imx-sc-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl,imx-sc-gpio.yaml
new file mode 100644
index 000000000000..66abff316c0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/fsl,imx-sc-gpio.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/fsl,imx-sc-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO driver over IMX SCU firmware API
+
+maintainers:
+  - Shenwei Wang <shenwei.wang@nxp.com>
+
+description: |
+  This module provides the standard interface to control the
+  resource pins in SCU domain on i.MX8 platforms.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qxp-sc-gpio
+      - fsl,imx-scu-gpio
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+required:
+  - compatible
+  - "#gpio-cells"
+  - gpio-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio0: gpio {
+        compatible = "fsl,imx8qxp-sc-gpio";
+        gpio-controller;
+        #gpio-cells = <2>;
+    };
-- 
2.25.1

