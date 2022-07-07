Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F3156A27F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiGGMvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbiGGMvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:51:25 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893BF2BB26;
        Thu,  7 Jul 2022 05:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3QWG7pOQWo+YqkSvf7xb8tVNi55IKeJl/IPReZzWKVunoT+1ZCMCjhEBYKQTkr0e5WzFu9UieExoR/GOtthz76WRkPLEsWp2jNlX25l7V/pmgfmyYFHOvY95Xq8BYdJn7VsGtzOtS7JRQMdliju9opb/6r/SIM5a8xIlHWHV5MG5VruA0MnFKHKTBB2hAD/pDm25WGh/vdZ2THhfqpwa8sHyL1Bkvd56RC0TXRtogSO4MFnG6jLh/8dflJb9L86U3ec2h6oRjRRZM+agWzTHZQrjunnYFExQ1a6t/QWnHHMrwuTn6ldQOGp2eJ9P2n2segc8WkrAAmJr72qCSjRuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Kz85yYUbxnwvpC4arxrA4iTfdPVQDrC9l2zM4f/6+4=;
 b=mJ11zlOWvRXEwLLEiKi/2S3OH3PeiJ33w4w+e97HiWKoZbc3TBnTSKBjHP2+aJzI2rmx7/U8dIivZMpJ3yZcc2uBGUtqGeo19nCW75FLboS0/wHUELQrl4OoHS1pB01wsBdlsBMYo9KSPIYAwYIw8ZnZYBE06goJbktIGdiKmSvWaKgqJqd0Zrz5raRmtmlDmHxGZqt2H+KIntWZmiBLmGChCaDkR/GvFnzkxmxHTDyS+wtStmyvNbDBRieIvBmrUxteOZBuBcYVpe8atn6ejVGy2AAbzXIPr7ZkXZK7EBH/KVEVzLtwkitaXediWETzMAZAzmjyemA3WGOhRJwxkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Kz85yYUbxnwvpC4arxrA4iTfdPVQDrC9l2zM4f/6+4=;
 b=LKn20bmLXnQ2m0f8rdCgmKqo9wU+ucYEXiETgxV2BDq+V1yR9fMykog1mpg2kECl1QUdvcwb/QJqyK3SUcBMDWF8sdg9UmyKFJZIBuL3RRLT7Iv+GDPzlwQ3/EHGNb5qp+nEVLeCVaR3y9ct2giGcJNbTbtJ6thiCXXvYuEMHKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB6418.eurprd04.prod.outlook.com (2603:10a6:208:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 12:51:19 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:51:19 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Viorel Suman <viorel.suman@oss.nxp.com>
Subject: [PATCH v8 09/15] dt-bindings: firmware: Add fsl,scu yaml file
Date:   Thu,  7 Jul 2022 15:50:16 +0300
Message-Id: <20220707125022.1156498-10-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
References: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P192CA0026.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::31) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa5c995c-4058-4625-4688-08da60176351
X-MS-TrafficTypeDiagnostic: AM0PR04MB6418:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 38bYnt4fytq6JJnB6t2V8KRHPYQXCP/5Jc2GCDuLq51pgaS2KbdjCASFwphpDgN0eXLSo3ksb76nI2R8ULb37sOej4xgL6RlloLwfMsrfT6nuyOkXGvKxGuWckawEEVh2bn/cv7ksdQH9bwlDoFPluaF6wEJR5N7JLb1WOuBAEGE4dBPu1V1mE2oKkZFpTQ766E5ePUwBSUGaMwJYi38qPXPuKpe83U3k/qX3sQPyBSIw0HaxgvKGUJr2SEotVva6mOgAAxHf1yWAs6EM6PuGI/KEOi1tJXhWVcSPbTZ5jpkKnxaZSSUT47+i2AXbcLtsdaumB+oiLPRGk4Mx3YwwjVTte+sa2iUW0UFJoGbPVeA0rRhPKeVF2LDXO7VwRAnyhx9oPfGKX9+Wh7YivUTtSXVpcjucNxaXkjydTZnOJpQrLd/B5Sd5U83g5I3RDRdfuYsixz6/hcnRZEjUpKSpxpxnSMLDZLFs9K/uVRT0BoNTw0gHSys1poWKWXl6FUYa9F0ybvs0aJ8v6DNJQAU/EHP6kzQyYKn/2HgtsYyblwcbsnD8w+5+tD/wbueo7TdFf9jeWUDJme3U0rByrqC14A8r1/MQeYt2QeTXARV3cVwx7PylSAUhHPG+pEAt/n+6Z+zeip1aW1f+CQtV5ZXO1/iplow4TvKwogVu+gRSHgmryS8DpeAOBJLrHQyXGVwiwfmddnPuPxHyO3bIs1wKcPJS5jbzo3BA0IIx/fqwsl2dYo4MUreuR1iN0Szp5O+mSMYwacj8FIBaVK+adU+7HvAymu37DyGiDdHBZzSwESaVeyDfVzkVCsqeUqvTB4Rwz8F036KVi/bx3FV1owxwIxRwzD3oSum6fJna/NnPfdbwMcwJ806nxGLUh9uoEjYejzCef1z4v6lJlhI91+tyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(6666004)(86362001)(5660300002)(966005)(38350700002)(6486002)(316002)(38100700002)(2906002)(41300700001)(7416002)(478600001)(921005)(7406005)(66946007)(66476007)(6512007)(66556008)(8676002)(4326008)(8936002)(186003)(52116002)(83380400001)(26005)(110136005)(2616005)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qXBkYRh6Zl+gZ7S0Nw53ENxC9NLSvvjldp4Dqt6zeWIQC9ekdh9iwP1w40?=
 =?iso-8859-1?Q?ksk0buPVRTRR9dSxRyM4LAQ0uhp+AZDxTfH6Ag8Nw8t9PTmaXd5pexLJWm?=
 =?iso-8859-1?Q?Tl2L8QqWSDr3P9iLgCJIGDBvRA+TpIVBET/TFtmcJyY/X9u8lCV8nN/Fkj?=
 =?iso-8859-1?Q?QtegJayy6gQ7DbPf+a0sjJ2MYmVsHJ0Mh4RVMb6lpDgeKYmcQ53vghSArd?=
 =?iso-8859-1?Q?p9bkm95+reYiKrSeqkh70JHO/7FwgH9XMFsUrFIEcxebrdBjHwIkwuafcZ?=
 =?iso-8859-1?Q?bMqrxVmHaOxpVlNE0x0L0wjJKadZgdzelKH/ou2eM9mt3nq8NU1KdtLI4l?=
 =?iso-8859-1?Q?FGEm2Itr3GNB8kmT5yIrBo2gLO5zCQaQ3ySa1pJXuNAjMklsLXrn0i5++g?=
 =?iso-8859-1?Q?rRXwE5XIiX2UAh9szhVtcAn2utvWeKqEK6yDZpNHuUYh/krNvwU7appJ3T?=
 =?iso-8859-1?Q?k0u36adPZzPgYqoGpMgkZ1mFEE2Y4ZCKs7pN8i/ekJ/DpHvO1DttDXDY6W?=
 =?iso-8859-1?Q?8yxxqnlNI0oD83wW7AVdHaABxmEAl4EBP0W8BqlMkAJb3Nio/LX5o750Se?=
 =?iso-8859-1?Q?9fbZM9il4JQORB4I35E/94bW0vHAacSfenJjiWLINQNvHKZwVcSJl52cuR?=
 =?iso-8859-1?Q?PHvD0C0N1hz9PU1dmNAn1lhXgB878WKvuMpiLL4wKU64jIw7DNN4ErqutF?=
 =?iso-8859-1?Q?g9IA5ONX6c00J/S5HRBG2f7/ucgC/O3W1Ea0soName+aDUc3cXeB/gvD79?=
 =?iso-8859-1?Q?swi5Ix2jpUYyNAsbTaX+fMLbl3UuCXM7m1+nNex3ZI/L8CXr6p9CByZclb?=
 =?iso-8859-1?Q?X+avytbc2WL9mwxvM+H8M7qdI6hoMyu1aColm4XgQghx/fMeZZ+XevlBsW?=
 =?iso-8859-1?Q?z64y0I+MTNUqHlV34aHG9RGtMhpej45yTMr2Z06zHraWqEvEuaqsHtCWJp?=
 =?iso-8859-1?Q?MtIWfr8f2pScClsMJ+gytTB/0vFUOSAJfNmHZgyb+5DP/bdRf4oqeZYMp5?=
 =?iso-8859-1?Q?IsEuT2I2vi04hP32RT9x8oKIRKcsK3HsBVxQNJ31v8l7da7Bfo+ISookYo?=
 =?iso-8859-1?Q?QW+c5srcNaid9UPwA2ZKFDQaPSGQ5cOFoaz3KBGAIHB2uL6kGVY/w8lIRs?=
 =?iso-8859-1?Q?5hAHStN4hk48gIAKfzIMMp0v6VL6MyDVtpGuC/6xfHuqAmOBkV2xpdn/HG?=
 =?iso-8859-1?Q?uL08yAPTDRw5+jTyx4ZBVktNRyOdngHA+1jZ/K+7ml6F5NF71Xe5Ct3Az5?=
 =?iso-8859-1?Q?hb+C9+JkgQWnmVzujDnPjnfGZF+IaV3QPAI48WnNf1IO66D8KN9QY/foOx?=
 =?iso-8859-1?Q?bQWCEAnI5t771YV8LV0fwhWokb0OGWUTeqiPlmfmbhTOlBaaq4W97c6rku?=
 =?iso-8859-1?Q?/AknTtACUZcdQPst1ZaHBpEDOBKnJu1Xt/zch6iSkkuc38eDmK8wE+AvRR?=
 =?iso-8859-1?Q?+82eG+pSrZJldnbxFV+Hu5ZaINW/lFLekwvWJQH9K9BnbGo+VLLkKQ9HrX?=
 =?iso-8859-1?Q?09Jx5/qkLxw+yKxb2L5CfwFe3gC5BVPZJ7VqGY8CH1Io6QBMiAKukiCj56?=
 =?iso-8859-1?Q?yqk1gLZ7sDJNIQsz26WMdtVuqa313XReGfoW+BbOtEIEwv4O3D3zvfA/AM?=
 =?iso-8859-1?Q?UG6B3VSayZtO77e2gr76oQOph7sqD9Plx+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5c995c-4058-4625-4688-08da60176351
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:51:19.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lk16wwm1t0mSYkYEgo5+hzjkPhdLcX1Ug/wYgz5Fxx4cXQAbTlP51Vyp4dJHJg2FnG6o87JupwBCInFYIYhNow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6418
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch adds the
fsl,scu.yaml in the firmware bindings folder. This one is only for
the main SCU node. The old txt file will be removed only after all
the child nodes have been properly switch to yaml.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu.txt        |  96 --------
 .../devicetree/bindings/firmware/fsl,scu.yaml | 210 ++++++++++++++++++
 2 files changed, 210 insertions(+), 96 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
 create mode 100644 Documentation/devicetree/bindings/firmware/fsl,scu.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
deleted file mode 100644
index e1cc72741f1f..000000000000
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ /dev/null
@@ -1,96 +0,0 @@
-NXP i.MX System Controller Firmware (SCFW)
---------------------------------------------------------------------
-
-The System Controller Firmware (SCFW) is a low-level system function
-which runs on a dedicated Cortex-M core to provide power, clock, and
-resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
-(QM, QP), and i.MX8QX (QXP, DX).
-
-The AP communicates with the SC using a multi-ported MU module found
-in the LSIO subsystem. The current definition of this MU module provides
-5 remote AP connections to the SC to support up to 5 execution environments
-(TZ, HV, standard Linux, etc.). The SC side of this MU module interfaces
-with the LSIO DSC IP bus. The SC firmware will communicate with this MU
-using the MSI bus.
-
-System Controller Device Node:
-============================================================
-
-The scu node with the following properties shall be under the /firmware/ node.
-
-Required properties:
--------------------
-- compatible:	should be "fsl,imx-scu".
-- mbox-names:	should include "tx0", "tx1", "tx2", "tx3",
-			       "rx0", "rx1", "rx2", "rx3";
-		include "gip3" if want to support general MU interrupt.
-- mboxes:	List of phandle of 4 MU channels for tx, 4 MU channels for
-		rx, and 1 optional MU channel for general interrupt.
-		All MU channels must be in the same MU instance.
-		Cross instances are not allowed. The MU instance can only
-		be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
-		to make sure use the one which is not conflict with other
-		execution environments. e.g. ATF.
-		Note:
-		Channel 0 must be "tx0" or "rx0".
-		Channel 1 must be "tx1" or "rx1".
-		Channel 2 must be "tx2" or "rx2".
-		Channel 3 must be "tx3" or "rx3".
-		General interrupt rx channel must be "gip3".
-		e.g.
-		mboxes = <&lsio_mu1 0 0
-			  &lsio_mu1 0 1
-			  &lsio_mu1 0 2
-			  &lsio_mu1 0 3
-			  &lsio_mu1 1 0
-			  &lsio_mu1 1 1
-			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3
-			  &lsio_mu1 3 3>;
-		See Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
-		for detailed mailbox binding.
-
-Note: Each mu which supports general interrupt should have an alias correctly
-numbered in "aliases" node.
-e.g.
-aliases {
-	mu1 = &lsio_mu1;
-};
-
-i.MX SCU Client Device Node:
-============================================================
-
-Client nodes are maintained as children of the relevant IMX-SCU device node.
-
-Example (imx8qxp):
--------------
-aliases {
-	mu1 = &lsio_mu1;
-};
-
-lsio_mu1: mailbox@5d1c0000 {
-	...
-	#mbox-cells = <2>;
-};
-
-firmware {
-	scu {
-		compatible = "fsl,imx-scu";
-		mbox-names = "tx0", "tx1", "tx2", "tx3",
-			     "rx0", "rx1", "rx2", "rx3",
-			     "gip3";
-		mboxes = <&lsio_mu1 0 0
-			  &lsio_mu1 0 1
-			  &lsio_mu1 0 2
-			  &lsio_mu1 0 3
-			  &lsio_mu1 1 0
-			  &lsio_mu1 1 1
-			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3
-			  &lsio_mu1 3 3>;
-	};
-};
-
-serial@5a060000 {
-	...
-};
diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
new file mode 100644
index 000000000000..b40b0ef56978
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
@@ -0,0 +1,210 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/fsl,scu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX System Controller Firmware (SCFW)
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description:
+  The System Controller Firmware (SCFW) is a low-level system function
+  which runs on a dedicated Cortex-M core to provide power, clock, and
+  resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
+  (QM, QP), and i.MX8QX (QXP, DX).
+  The AP communicates with the SC using a multi-ported MU module found
+  in the LSIO subsystem. The current definition of this MU module provides
+  5 remote AP connections to the SC to support up to 5 execution environments
+  (TZ, HV, standard Linux, etc.). The SC side of this MU module interfaces
+  with the LSIO DSC IP bus. The SC firmware will communicate with this MU
+  using the MSI bus.
+
+properties:
+  compatible:
+    const: fsl,imx-scu
+
+  clock-controller:
+    description:
+      Clock controller node that provides the clocks controlled by the SCU
+    $ref: /schemas/clock/fsl,scu-clk.yaml
+
+  ocotp:
+    description:
+      OCOTP controller node provided by the SCU
+    $ref: /schemas/nvmem/fsl,scu-ocotp.yaml
+
+  keys:
+    description:
+      Keys provided by the SCU
+    $ref: /schemas/input/fsl,scu-key.yaml
+
+  mboxes:
+    description:
+      A list of phandles of TX MU channels followed by a list of phandles of
+      RX MU channels. The list may include at the end one more optional MU
+      channel for general interrupt. The number of expected tx and rx
+      channels is 1 TX and 1 RX channels if MU instance is "fsl,imx8-mu-scu"
+      compatible, 4 TX and 4 RX channels otherwise. All MU channels must be
+      within the same MU instance. Cross instances are not allowed. The MU
+      instance can only be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users
+      need to ensure that one is used that does not conflict with other
+      execution environments such as ATF.
+    oneOf:
+      - items:
+          - description: TX0 MU channel
+          - description: RX0 MU channel
+      - items:
+          - description: TX0 MU channel
+          - description: RX0 MU channel
+          - description: optional MU channel for general interrupt
+      - items:
+          - description: TX0 MU channel
+          - description: TX1 MU channel
+          - description: TX2 MU channel
+          - description: TX3 MU channel
+          - description: RX0 MU channel
+          - description: RX1 MU channel
+          - description: RX2 MU channel
+          - description: RX3 MU channel
+      - items:
+          - description: TX0 MU channel
+          - description: TX1 MU channel
+          - description: TX2 MU channel
+          - description: TX3 MU channel
+          - description: RX0 MU channel
+          - description: RX1 MU channel
+          - description: RX2 MU channel
+          - description: RX3 MU channel
+          - description: optional MU channel for general interrupt
+
+  mbox-names:
+    oneOf:
+      - items:
+          - const: tx0
+          - const: rx0
+      - items:
+          - const: tx0
+          - const: rx0
+          - const: gip3
+      - items:
+          - const: tx0
+          - const: tx1
+          - const: tx2
+          - const: tx3
+          - const: rx0
+          - const: rx1
+          - const: rx2
+          - const: rx3
+      - items:
+          - const: tx0
+          - const: tx1
+          - const: tx2
+          - const: tx3
+          - const: rx0
+          - const: rx1
+          - const: rx2
+          - const: rx3
+          - const: gip3
+
+  pinctrl:
+    description:
+      Pin controller provided by the SCU
+    $ref: /schemas/pinctrl/fsl,scu-pinctrl.yaml
+
+  power-controller:
+    description:
+      Power domains controller node that provides the power domains
+      controlled by the SCU
+    $ref: /schemas/power/fsl,scu-pd.yaml
+
+  rtc:
+    description:
+      RTC controller provided by the SCU
+    $ref: /schemas/rtc/fsl,scu-rtc.yaml
+
+  thermal-sensor:
+    description:
+      Thermal sensor provided by the SCU
+    $ref: /schemas/thermal/fsl,scu-thermal.yaml
+
+  watchdog:
+    description:
+      Watchdog controller provided by the SCU
+    $ref: /schemas/watchdog/fsl,scu-wdt.yaml
+
+required:
+  - compatible
+  - mbox-names
+  - mboxes
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/pinctrl/pads-imx8qxp.h>
+
+    firmware {
+        system-controller {
+            compatible = "fsl,imx-scu";
+            mbox-names = "tx0", "tx1", "tx2", "tx3",
+                         "rx0", "rx1", "rx2", "rx3",
+                         "gip3";
+            mboxes = <&lsio_mu1 0 0 &lsio_mu1 0 1 &lsio_mu1 0 2 &lsio_mu1 0 3
+                      &lsio_mu1 1 0 &lsio_mu1 1 1 &lsio_mu1 1 2 &lsio_mu1 1 3
+                      &lsio_mu1 3 3>;
+
+            clock-controller {
+                compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
+                #clock-cells = <2>;
+            };
+
+            pinctrl {
+                compatible = "fsl,imx8qxp-iomuxc";
+
+                pinctrl_lpuart0: lpuart0grp {
+                    fsl,pins = <
+                        IMX8QXP_UART0_RX_ADMA_UART0_RX   0x06000020
+                        IMX8QXP_UART0_TX_ADMA_UART0_TX   0x06000020
+                    >;
+                };
+            };
+
+            ocotp {
+                compatible = "fsl,imx8qxp-scu-ocotp";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                fec_mac0: mac@2c4 {
+                    reg = <0x2c4 6>;
+                };
+            };
+
+            power-controller {
+                compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
+                #power-domain-cells = <1>;
+            };
+
+            rtc {
+                compatible = "fsl,imx8qxp-sc-rtc";
+            };
+
+            keys {
+                compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
+                linux,keycodes = <KEY_POWER>;
+            };
+
+            watchdog {
+                compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
+                timeout-sec = <60>;
+            };
+
+            thermal-sensor {
+                compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
+                #thermal-sensor-cells = <1>;
+            };
+        };
+    };
-- 
2.25.1

