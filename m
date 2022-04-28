Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94437513B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350923AbiD1SVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350909AbiD1SUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:20:40 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB0B5D5DB;
        Thu, 28 Apr 2022 11:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RB0OAQ/gKLfRyOD0Zg57FocyVF00jm0TaAyVN2ALXg+y/ib6UpEO3nCk/ggb+iqXbNJ5zinc9Ugw+Zsm94A+xC+m9KbUeb2y1iH1YB5DEJdd3oh4s2Nbe0/ZEtMARqTzKn0yR8rk8ZODP4jyF6IVQrcepc3to1q7vpj2yE9TXOleiLOy970UmO4Mb1ngUawVxnD/yPuO4Inw6D7bR+z3d02tdDWXuyaE+MU10GoSzRWH+ZjpQNUH41Pf22Eqj48rNeaSnD4r/jhE6KXknVVIpJyh2L0H/63BDZsK7h9mkaMLo0trIfG3ml9Sk6EECBqOG1RTyGCar8aNwEJgKz5mfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/F8E7QDBuM2Of2bZrW64IJvZUhykVsBgBNnau240MMk=;
 b=XMibZG3dhMa3v4y0jKahQJipGG5XnP+MFF3jNV3/gTSPxKhtBll+unlgqNJG9M4IzkVphMSRfi5sW5GlzOIGIF6JczvUpItb4KXnSGmen7Y6QMkpWCZcR4w1II695xVkPu9zpK7/50RiXOlyh2KsaTQoWRNjBp/R016DZF5YFxFstkKWoE/RelSKQGXyb6qIVFUO+q9dMNL8vC4/PeQ2rK8xqOLD1oKyS+uMi8Z8abwvvlvyaVjOSIje6lqHZvCc8nkjHfdNONZnYtQeNkkqPC4s+vYd8x3mSAIl69Pw9KrUwuvryUxAZxaJ2SrLCK4xzkX61uWPXKIPWuKPzfB+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/F8E7QDBuM2Of2bZrW64IJvZUhykVsBgBNnau240MMk=;
 b=IEF9mA25jZ/WunEDapVbqU6kn1YLDv6ftddEgE6TVpcf8kNgp5K5xyxT5/jcO20wNT0pL8HHQ2tUcMasvX632W2xCjS8kcZxUNqNN2skmeL6BkhOX3LL69CB2bZiEeuHLqM9330YpDrrLL88vB+F460Oul1dERQJDXxF+Ku8EeJdBiJa5Whv3UZy4/GjW33/o67SOikHnNbT+IzAaAr9h1KhoW7V4RwDHvcmn4G2SJ0URkQS/DtUZCOCuaKniDJsJG/8xyKwU6vvGHhwkaeMQeCGPlGRDOlBecvldbTQVMXxga6Zuwqt5IX2vob3HVNqVUkpSGAw634mQAPmPhD63A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB6775.eurprd03.prod.outlook.com (2603:10a6:20b:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Thu, 28 Apr
 2022 18:17:19 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c%5]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 18:17:19 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>, Andrew Lunn <andrew@lunn.ch>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 3/9] dt-bindings: nvmem: sfp: Add TA_PROG_SFP supply
Date:   Thu, 28 Apr 2022 14:16:57 -0400
Message-Id: <20220428181703.2194171-4-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220428181703.2194171-1-sean.anderson@seco.com>
References: <20220428181703.2194171-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::32) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dabd2419-65db-4f6d-1862-08da294354f1
X-MS-TrafficTypeDiagnostic: AS8PR03MB6775:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB67750499E1EE55A39E91211E96FD9@AS8PR03MB6775.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dICjrVz+1XoS9UGV/usSMwGj/0gEWgH1QuAM/itC+YDqfX40UOECCPpFLkg/Q9W9FJCH5i2vds2M+h6W2Kgj4mjA251mtlrd0LIkPGG3/thbxjTOx5qE2UNekR82/LlobapYCa7rZZqYyFvzyuApW8fVy2falIuE3eAOXWzln3xCM4QvG8PC1PMJCTRvEQ12UV13FYOtlAKA+coevxZCJ4cPqYMTHYEzSr72PiWoSuRISGBWqPp3DETxbzrycxbjBsSs7ohvPI3GrfmdjcUjll3qpM85GWc3zWDKSWoyflLgFYFk7J2nSVU2BFqlFjbM78yzPSAXR5Sa5tkVW5PnGcD2QKFYCMYzEzXcJMnvC2n2zPL1yqVeM/99n2xDI3zCjs30ULcJE1hBcP5R9GLW7wRjGGtnODSSRz7hEhl3Xy/eylBQS5h9BOjqQuR+rIynoxkH3ndxTLbgXEID5drFvvJNa0pYMtCmLk7H0LbIp8yy8gI5BhH1gQTVNJauOKbosppaIG2r4x+30GRJk09JpEAwGLHL8iwuaqhTH+QvQUflmdFRnknTiHy0PVX3MOZNXlG+u/TeqWZeQXQQ8MpS1MWplnXl6Xoq292l7SUZJ5dQ4SAiUQYbC0K/ZHpFqeoUXkNjTP4VJUXHhZThgEK+EuM8Udwk3tnlirl/GLm8ZjySWZNIK6g5VlJYUcX3ksx9TM45dAvcMqroSF7WI3DrtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(6486002)(86362001)(6666004)(2906002)(44832011)(1076003)(38350700002)(508600001)(7416002)(83380400001)(38100700002)(316002)(66946007)(186003)(66476007)(8676002)(66556008)(4326008)(36756003)(6506007)(54906003)(2616005)(107886003)(6512007)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tp+lsupy1vpc2VGFQhyDhqnYm/mp8kaFIBvitXx8srxP1B7i6QxpfZtPNrBj?=
 =?us-ascii?Q?ATAmVsgN0CpWPeYZdfDfNlz6ncW9hPCjs03mHdNhh/fp7qncreOj5CWsEDEc?=
 =?us-ascii?Q?nL9z4SL1oGimi+IGLVbxlly4siNMrz9rXgT4QRNQf1tJi5hNKe5jBU+Glc7A?=
 =?us-ascii?Q?XYrYuP57aOtgsJO2JaLvhKfF5LVG/Vp7AedEF8lJ8ClDCR8DcF08iEM7naRe?=
 =?us-ascii?Q?44KMZteU+dPaLxPsIjO9+Ob3aeFYl5heAQtq/8c/sr08mRofGZzGSzTVXJdE?=
 =?us-ascii?Q?ORosTF6MFGFIuJHsihGEvEpo/p+lb+XtrUBLKEJjmL7gNxkc4mwfUmuCMACd?=
 =?us-ascii?Q?a5kih7WrLs1ZVyBkpgcIzMXWK6+Bt8CLcmPbFXwlcnhDDUqw8UMH/eZVcFm2?=
 =?us-ascii?Q?uIAVEwvdeQAXvx0j3nFKV3HG0sWDF53oWNXoj9NEtqFnwYLjbspfhSTkDC6q?=
 =?us-ascii?Q?egf9APU50iN3jJVM0/wbnKXwFjh04RW34PaHirmAbxPZXckCZ8MYBaKBDIMK?=
 =?us-ascii?Q?lxVgAerpPr4n2VND2CqqLktlegp9007WpmMmhs35f421KlJYtB4bZ0VeJP3S?=
 =?us-ascii?Q?UxaYMEz2nWWEu1BJ//Dg6NpV+w4KfYU9nhkca5wLyDEi8Wcbngk0dYEulDez?=
 =?us-ascii?Q?yycQ/5USFk4y7LCedqVmMKPY1LhvBz/o8C/yeYGMUOIV5koYUCHskCE6sKGs?=
 =?us-ascii?Q?AT5q6nPrSfVLl1pLNXTF1HEIkPHIVFeRBmYZ3Od1vqDqYGdx/L0OANbwnqu2?=
 =?us-ascii?Q?pcAnqZWnfZJ9XApWFGSz1MkOD0g5YoY1qblIefmRpo06WyFP1rC3bkMafWQd?=
 =?us-ascii?Q?Hv9LzTSYqHVmtpFV6bTNJFloBbjb4MDbG85JT1+0tWtuvEwpYWbGHNF6HgIy?=
 =?us-ascii?Q?hNwdSAoEJ7q34L/5twZ18YA27D2Pkuh8H4e9blGkWjzXFshQHHF8WPOdTuO+?=
 =?us-ascii?Q?Ixim/YqNybezEJPGLJzTx8PKTMGD7EU9kdKTcWcVDOhKlGWQ0gUIk1SYMfBn?=
 =?us-ascii?Q?9cQyd3HYrYyAnjZGqRgZZpS9VVjm+kvfI0IWxvoFlEgSNcqWGpFqRWT9JMGe?=
 =?us-ascii?Q?rnVveFIzRcklyIXU2vDeHrScgY2qNj3aIFt7ZeZo7c+v4NnekQxhTXDtEZ+o?=
 =?us-ascii?Q?kCSfYtcc+fLNxQzRaDiyGiT3gaBRFOjjoxUbBMATt8nV0cmwWfpgA0uvX0yU?=
 =?us-ascii?Q?+lcmEhdOb/4qts2+hDpVPv4NJKl3Vxh070x1NHXGyftlQR7+iigZfBTP8pbd?=
 =?us-ascii?Q?7VDv/aT8dDQGhHVlciC/Eia8y7m+5rVVniNMGfrd5HSEdhrR3vlIX5QAweqD?=
 =?us-ascii?Q?7ptVpFYalbabfvMAZBtOz2Jk+mScUeAAaQF+rX26WKUkI1iCu+wA1ZBMBBTI?=
 =?us-ascii?Q?I5VbOOup9RWTFwKoVi8TN0q4UZg54CsKFsNVAn9L+5ARHukPjCHs4wFhZzW7?=
 =?us-ascii?Q?YgL0cJDUyFaNRVWE57VWXmnG+b8m+rfgiCZl0BKOm4e4pREQE0XGLTrblWoP?=
 =?us-ascii?Q?I+S5+JeypeXbf6WgtDdA17qxL+NcFQZ6+oSsh69vMcNJeVZ0JBsHBupO+Gcy?=
 =?us-ascii?Q?Mm3LtEUu6dD43G3IsQVz3aoJs4XKn6fU09H4vDE73yJfLlbWNAQdpIUPwkN6?=
 =?us-ascii?Q?0QwYAdhvZY7kAm3V6lRH3zdnmFLIf2uSid3RDkp2MX4A81gq8pxKICSovfxc?=
 =?us-ascii?Q?ScuFhctg8zDV1XwoKuBE3PFt67CfjzmQM3LZz2APwZ3+9EDO9nMaVQWbkmmM?=
 =?us-ascii?Q?NFcr470KPK+O/F0lH+s6zu6F3ru9Z/8=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dabd2419-65db-4f6d-1862-08da294354f1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:17:19.3793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4KXLOuZQgW/hO8y4iyxBLhgxB20Y0UTgfXTUmAvXGLP8Io63hm583kP+vZDOdLs+bIIdjY3GGLbmqEW3mkVqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6775
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TA_PROG_SFP supply must be enabled to program the fuses, and
disabled to read the fuses (such as at power-on-reset). On many boards,
this supply is controlled by a jumper. The user must manually insert or
remove it at the appropriate time in the programming process. However,
on other boards this supply is controlled by an FPGA or a GPIO. In
these cases, the driver can automatically enable and disable it as
necessary.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

(no changes since v2)

Changes in v2:
- Mention "regulator" in the description for ta-prog-sfp-supply

 .../devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index 54086f50157d..c5d7375b840a 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -32,6 +32,11 @@ properties:
   clock-names:
     const: sfp
 
+  ta-prog-sfp-supply:
+    description:
+      The regulator for the TA_PROG_SFP pin. It will be enabled for programming
+      and disabled for reading.
+
 required:
   - compatible
   - reg
-- 
2.35.1.1320.gc452695387.dirty

