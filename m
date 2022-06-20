Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22524550F05
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbiFTDoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbiFTDoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:44:20 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD49BF6E;
        Sun, 19 Jun 2022 20:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwYgBBixOpMdYzc4OUY/G9Xsh4z8Rj7YLu7MLI8UDgUlF2cfUu8XmJaXdiMqMIsEeVqTH1e/rKSCpmNeA5oG+II3c3xcxGL8kD5zfu8fFu5NY1VEnS4iG68RmHZvpljCVI6yUZxyYMtPDpfZvKA8rum5mFFbUqCoQPiJVvj1qWa7q7RPICTPf/daijptyCKJFK5ajmso/DYTDbkzN9+gBJexr2uk7HB9X7l0KmVZDNPq9ZvbRCJM7wRRS7+zpLGf4XK+5TCGkea631oZKaoeQHLqywD25IeV6o9SfSezeU4Lw+cBDzdgntBObMj6dnity+t/fXjl+ugwIjS453OHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrLWL77nXlg8hwzfXMRQnkjSd5EmyvmAaXWblNIKYx4=;
 b=Aqa1A6g4yMd0ixy51olSo2W24Poaor4yQLG05/jIQqO/rsMMY4lVBIuPS9A4y4NXX/vq/2DG8TL6rPR/9P72TruPVWOTg8smF6J4Bv1ej+0mIwuFb9Ba6pQrLWbpNZP6Yh9e65yw6WycvYP9tkcdW43hW25GGStQeJHjsRBBAWmlYA3l7e8kq9/8VRm+8DS0DUy8ceWglO2x5+a233iVD3y/rlcqNlo4nvSkczxgm4COCLEt/bpt6fkfmSDocxh8lv9XYES22ZGt1fqeTRj47TcUd6WIOFcOUH4swUq5d1spnHhghitCJUmicvVd11O+TsmHunB0GbzGrjxateEbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrLWL77nXlg8hwzfXMRQnkjSd5EmyvmAaXWblNIKYx4=;
 b=KIvQSB1VCEeL9oXzRGtKzDwWdq4HJ7Ewl7YF8oxLDnsM9CbVCDkVYm0dyzi3Egnsb3DfVLJAbBWLotvypRLLHfXKEjfsojby7u6NpvJCYJZ5fsYIvYUM9/C3NLnXsNe/vlCfFe7RZcW9VCNu1JKPckOWsTw84CcXJS+YvoQwWnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA4PR04MB7965.eurprd04.prod.outlook.com (2603:10a6:102:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Mon, 20 Jun
 2022 03:44:16 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%6]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 03:44:16 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add prefix for Mixel, Inc.
Date:   Mon, 20 Jun 2022 11:45:31 +0800
Message-Id: <20220620034533.4108170-2-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620034533.4108170-1-victor.liu@nxp.com>
References: <20220620034533.4108170-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e20a5595-df3e-445a-8ec4-08da526f25c1
X-MS-TrafficTypeDiagnostic: PA4PR04MB7965:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB7965D2186CF66B51D46DAB7798B09@PA4PR04MB7965.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPi6eFw1uKKNSczanvjFI7kqcsLFJMtfmcfGJoMCbIBYwg6xDqroT+OoJDvO8GyT72McPfGDa95MnL3kyp5WFT1k+XfDswboxAmlMsqT5tzwjGJgeV76UEYBdO4CLNegpnHcf1ZxBY7WnO5DNZTDW3EywCoU2a3Lrf7j82f2pKnM2QjBVZvNXrfBzI/Md1ANAg/f2kPjWYZhee55SJkmHhDPLUCmCYzHuQSGbRPnzPfNqKLzh5COAed6hVg/PA9A9fvB/wbuGHgLw35XzZ7PY2gMiaKy1yJY5zQsNQX08vsCOacyi9PKGDy6age2ledjl2dtK+DHF0IFb48sEM07LW2Q+vqXQzcDTkvhv1DQWCWQP7pNS7hJ1xX6Bkkf/DS5ZXOFILqQTg+erCADgKNTMlvWZEiVO0P1KuEIqiUU1eqU9n1Bsx19OiscTVvcnP2YW4KKRASj0AOq45DH4SoJgkHx+A5JLWv6LE4NRO4PrTygZbdhK7qwwuApAa8uia/tO0oZNM7tNM+xt5rNTBwnCTN9QNRq65OsLGf1C0QHffXWO7z28SKvK/I0Cg5y/ka2HxqtX4Dx+IRPM9MMaWkWzSjd0f0nZtNRJ/cM8mL2btWmFbWEnasTcelkqU4hPgCc8hfWN5XD7s4rm+iwBjUvgGipt726QHoEky93l0nEQ+ivrNsnZKpDgSPPu2KfezJ7/a5T0bF5r+OhaXYVObnkm8BNaJECVux01iZs3qUBIZlMApKj5EbFGGhMOKl67AlIs55cMtmvTsECIupo8eIQ30jsdd0IFAY3qSo6DMutn3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6506007)(66556008)(52116002)(7416002)(5660300002)(316002)(4744005)(26005)(6512007)(6666004)(66476007)(498600001)(86362001)(8936002)(8676002)(66946007)(6486002)(4326008)(2906002)(1076003)(2616005)(186003)(36756003)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Lc+F0arqldD3tAqUURuTZ38rutatVvTKie4MtKoe/FI1k0R3We3usUc7k3o?=
 =?us-ascii?Q?bBLYDLLXZDeNbGNWu4Zc2YW5AR4+oUZEpsAog0TTFax3wetck8QBZ/oFNy3y?=
 =?us-ascii?Q?o7ExH2ZrsEWWam3QFYuKhheNuv9Ftnerv51XEE/qCi7hpqKs0u7s8XNWlFH0?=
 =?us-ascii?Q?L4uv0Ub7apd+wdy9f7Mh0ff7JnPVf7Z6N2tPPP+B0r9z6viJmZWMX3qlwFWq?=
 =?us-ascii?Q?5FH+ukAsw3DXlpyjV0QPuEVd7R4FKt7uIqEGt3ZAAVPButQ6O1SjXqXp0jaN?=
 =?us-ascii?Q?TA9ZAeddfzgArDqWratEqnMgPsM2QTyftPVyd5YbhE+VFfqe+NKVKS38B7Lb?=
 =?us-ascii?Q?ynpxDGPuuK3x1Y2yei0J5xwig8f5lleWBUCvCDKugS2RTT4wM2U/HABz1piW?=
 =?us-ascii?Q?xgDbhkRfUAm8Ihu/2rU/7UVV7mk+7AxAYXKvp7noDay4T3e3+IhB78rn2SOO?=
 =?us-ascii?Q?p6BvyRAXTl+Bvs5Y+5bWxeofj/PFKqqUSrI0wKULDVDm4DEnOLgg0kNqVkU6?=
 =?us-ascii?Q?eoSrPSuZtapsvsASAmPrBnwA897Mt1FO4a+O1UHkFS5kSEp4ySuCT8ocXbHJ?=
 =?us-ascii?Q?6mogHOMg/G371x0D2ArTg7OivcAtGVQc+Vh2ECGwjgrdSXBisES8rSYsqv3F?=
 =?us-ascii?Q?myS4kVBG5FOWdei26xjq64kgAWKu38LRw+Yc5IUrncyxWq9wk4abXmUAovda?=
 =?us-ascii?Q?Xlk9QZ+6bcXuFuAHLY7GeR4mzHgoqaYcPfbUvHwo3jWs9HhLXWqyVRJLy533?=
 =?us-ascii?Q?7fAlzs6XK0KEuF5vwY8JtZLQ3Ba2oLvPvennAavr81j4FDDFuCXZKVmH/l96?=
 =?us-ascii?Q?4S8ipE2DfiA5bRsN6jYh/TnVYSYt+TP3ll/c9ZxFdu6o12tIQpFVMJh+ERvu?=
 =?us-ascii?Q?Uk/UNrPCfR9UzGHGC6+cjf76IMenCHotxIBVgdPItNnoVkBVaGyz3MfNu1uB?=
 =?us-ascii?Q?gqSAFJvqgNPRz28NA21QDDgzP/9aTnbJRM5mvi+Uf2sQBvB/pOha3Z9auGGG?=
 =?us-ascii?Q?sSthMrm9F7oAswuzjeLLjG+2wausZOAAna3gkrMuH4bpGsDzdie7hSjFQR2R?=
 =?us-ascii?Q?HrV3Yo1u9hzbaYpJCXhwLydvfcAEmuo/uCG+JxvAstB5c8p3q71Vbp604nxK?=
 =?us-ascii?Q?NVKiH5EzLGCI5/+e7Cj/bKFY9DUzsjuZb1upw/w468v0Lr7ZbpKBRPdgQAHV?=
 =?us-ascii?Q?suQ88tU6/y+zXwMKNEWFJRDG0Sy8S+pquGUmNIzN5Wa6vc6MYG7JU/qWjJSj?=
 =?us-ascii?Q?YOjs4HRttJMk7EUqMoYYn3KsgsaZfHLrh1UGhVP+HDQ0Z+YttFykR5/7AF5s?=
 =?us-ascii?Q?6bNuGvdFhc7UyRAcpwaWWnnRaWd0mF2JjCyV8G8sbVGIIDqu0LL/In+jDVgS?=
 =?us-ascii?Q?uyZIaXC4glDYob3Bo/4Nj/NnQ2QewpOEakx1LpveKotsLtmbRPqCPepgfJpT?=
 =?us-ascii?Q?jNoZmM1Fyt0Pp56CzRwx/1fuRV/+1NZBUCsPlNS3H6+1K9G8DPvMgXke5Ko3?=
 =?us-ascii?Q?CYwojuDM0jFp4lXigyRc2EQzLg5t7p6TKy+/yGZdjYccM52r/kqZK+YWXJxP?=
 =?us-ascii?Q?yuWCUPusJA2gSnF58rvW/RuQKy5PvtfpMcWJJQdJzlfnupCzCy0yVxVHwxpg?=
 =?us-ascii?Q?9pmXa6zp0itdeNG5ldWAm9kz9SsxMxZyYQXU12EaOzxfvb5T4r1lPuE+tnPc?=
 =?us-ascii?Q?feV/lLRlL+ZJZUZNhoGOhWg7eJ6qUM4SihPkFt4rP+Bw7nSvweMddbGpjYUa?=
 =?us-ascii?Q?Oyjda41Caw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20a5595-df3e-445a-8ec4-08da526f25c1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 03:44:15.7604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5R38AI/+O5ibreC/ZGYVXHFldHpez3RqGAI5/jb9LYY1dBCk1J0h4170u7dxgIuAqoUdFfEr48akQb8vjMo6Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7965
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vendor prefix entry for Mixel, Inc. (https://www.mixel.com).

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v1->v2:
* Newly introduced in v2. (Krzysztof)

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6bb20b4554d7..bbce3b060710 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -792,6 +792,8 @@ patternProperties:
     description: MiraMEMS Sensing Technology Co., Ltd.
   "^mitsubishi,.*":
     description: Mitsubishi Electric Corporation
+  "^mixel,.*":
+    description: Mixel, Inc.
   "^miyoo,.*":
     description: Miyoo
   "^mntre,.*":
-- 
2.25.1

