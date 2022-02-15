Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B393E4B70FC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbiBOQc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:32:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241595AbiBOQc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:32:26 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2133.outbound.protection.outlook.com [40.107.215.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6695D8A307;
        Tue, 15 Feb 2022 08:32:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luGCss8EgH95nF/qhnND6LfdKcrBeGkN/OWFtMMOBkWVUFQRbpnQdUGw/qJwpLEQkAEwfqEtHwIFh8XdG9OgVNkNBw0DeOZjUBXqKBmu5kKgHfz2CqN/LDJ2z2REJbtmY5CZaAhWkTHO14nvnXL8ZIUMz10HIjOUlZrK3AaTt0BFVfDzcrcA3N0HSGKSDVuzkWogsxWawBs0FvA+SdfT72mx8PyoEN99mPJp453SJEoh0UAug8smSv8H05xIsNMKPKaWr2rkGbIuZtqYTskXsEjWoOq+n0JsIhOtPi5kB6nj3f7oe2hFKUlSdjTA6pLkosuW2ckyYgTwuu+/hJbkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIV+h6IouVs8I7hwgkiHXMX6ZLTzGHSCGVqdSP+V6FY=;
 b=f3wCxAl/QIR3RqeXWXWLwi1ySuctuUXJTJ8yx/H1TXi4Wf/TPQlqDFUGTQ/ljyecWY3zX/LkFDq7FeHabC2Uwa4m6Y2QDed/aSLP/Ld+Ov/NuaSgtFjUoKSJiUonHXcEGPIbepW9Gh99BjsMWTS1J5enFynHLGzihUhzTHGML9oXeLtmO6qUVx66XT+a6VSfnpE74PRknl7F0b+T6PUnAYDCjCWr2sQJ4JBTNOe3YTA2d4uR+epjTnF2h+JX4jU3b3h+XXVmeJlXKSMtHRsu0v7wt854mNlAoekdoCsmizV0DNKyDcncCBM7gQl9dF5sBOkdZ9K4GwjZIEDwAAUN8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIV+h6IouVs8I7hwgkiHXMX6ZLTzGHSCGVqdSP+V6FY=;
 b=EAHhLZSs80MvSQCDPSRytnO+RPPGxsQLFxUR2RSu9qNem9f+IEiokO+Wnn/AiROv4W3FRvR+sWJlLXDUOCL7g/EcBrFH4ocLwRg70sJ59N/2yrJ9ZVD4cS6LKOo8L/9n9TgabbQJxo4t44jPbEi0uch7oYLyvSH04/tkQaGHfo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SI2PR04MB5695.apcprd04.prod.outlook.com (2603:1096:4:1a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Tue, 15 Feb
 2022 16:32:10 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 16:32:10 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v3 10/10] ARM: dts: aspeed: bletchley: cleanup redundant nodes
Date:   Wed, 16 Feb 2022 00:31:51 +0800
Message-Id: <20220215163151.32252-11-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215163151.32252-1-potin.lai@quantatw.com>
References: <20220215163151.32252-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e35a4170-8589-4133-330d-08d9f0a0b68a
X-MS-TrafficTypeDiagnostic: SI2PR04MB5695:EE_
X-Microsoft-Antispam-PRVS: <SI2PR04MB5695BDA9DADF75DED5FA10068E349@SI2PR04MB5695.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbGJqX61w6jP/dDViONrqgM4CHwPBxC6ifnlxS9vqrW2h1S6UPYdo4C+daGmILqbGSZOaZO78ijYDY/as0c8CixEOzgqzx26JrM1VrX+diwBsWqSPhEIPLk38Nt3WLzzLqdVXjCb1NvAnXV/b/tjEIvHE/HnujMXg2DcmENeRn5fjwoTc3djQy8un35uFgKWhbyzCtJC/lMpSbG1Mz8Xa6MpIxHbfnxBK5vZCf5yb6ljAdB81DG7w+uk4DzFZ2PHZFN1Y6GwYDHQOoUdIkbYRRYbLrGU3z8UtYPyuTf8JFOT+PDZql0AvniRxlmwL9wsk8dceSk+KrTUoSmXZkB/oeJ3aBSF1QrBpPQIETJUhid5r1RuSzai2abygr/GkeeUuWjLgR3SiGvCLyken7rBx3EK9wzugol2WMrtQ+AeL+nbhHAkce+h03cuhwA26zLIoVSCPEmSd6YA6GDEErtzOwbnUIEdNik3RayiYo4fEI1zVgyCIgTxpdPeG60dmj/4M3IJaT7XZXPq0RsV4rdnaQqOXQQBxsVuywS7bSIrVCQz5pzrreVm8OrXCXIsiLk0oMOfO41qGcyJz5NTzJsaepr+M2mGoauo27N7H/QA1aXdRTpEwYBkilqtDKbtXXPSpHDXud3fimCM8s2/BUfPxV7KujbCcZ2LDCU0Kw4RnwnAaY6ZKGWxSR7DKknz8gRy4yGZABjWUAwJkYNBMqXKdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(6666004)(83380400001)(38350700002)(5660300002)(52116002)(8676002)(86362001)(2906002)(6512007)(36756003)(186003)(2616005)(1076003)(6506007)(26005)(107886003)(54906003)(110136005)(6486002)(66556008)(66946007)(8936002)(316002)(508600001)(4744005)(44832011)(66476007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+QIg71MWgoqaHuMmYbvv6SDmhTbspaENuyY6w1+OzC9SIhyWF7kh7HXTHkHb?=
 =?us-ascii?Q?Ft36teYP14fXloIRdgUASrsPoY21d7UpFH6Itl2cmecQywjCSJ7qoAxK6X19?=
 =?us-ascii?Q?PeVFeT1dGIp77nNvcaGRXzI5BmIT8EXbOq5mOGEBVyqYYquFk851lBuFjh9f?=
 =?us-ascii?Q?TiMSG7d3wdcZOlOVTU5NUrdAIuPm1pTgVcS7DSQSW1LeqNrf7Ibpi7wXWUKP?=
 =?us-ascii?Q?O5qzuCLkAHvGPRWXQ4eSu2FAnp64jHZXG+2txp0VU78UUGDJNFT4zi7q4csQ?=
 =?us-ascii?Q?xqm/NLAS7E6JHh8KxzS6/FceieX53VsI7zOrG9+ug4R73wORikj5S8jn9NoF?=
 =?us-ascii?Q?j30enC47+B+zLFNgK7cwBNP/AY/+Z30vx2AmCFmuQF0JAdbYiDGLbV11P+3g?=
 =?us-ascii?Q?mJlM4K4xYjK0mMExpnBen+EagcbTIzKw8ZKQlAFK2AFpw9OqOtcVr3GCIrmV?=
 =?us-ascii?Q?K9MXfnxpx13+AGa/SARCtqd6O/mMQTE5+kqergdoDMGNa+USYfe/EyhYaXj3?=
 =?us-ascii?Q?gqELbFZGQAJd/pjwkT06N5JWWgipJEiqPbTcCEUzBRADf1Qu+ZYqm+NLHkAh?=
 =?us-ascii?Q?c92WI/pkSv1qk9T3myxSQ/DGSP+PktJo/WvN4epInrSJ4ES2yi1/HLTQ5Ls1?=
 =?us-ascii?Q?ijTZalomBSSaNkx3e6q3O6m9HzdvhfoB5TRuELLj13LYVrwOID4PtzV1O7s6?=
 =?us-ascii?Q?Rr5veEiugAUB0CqYaWIXE5mFNEY4q4wRYSjpM4MPNfbj2Vy47kpvzOWVKd8h?=
 =?us-ascii?Q?l5Cn+Lgk5S7xrTB8wgvbxFTl8sGxX0q+SonI7CB7I2Ye35em39zIPIYVt4zS?=
 =?us-ascii?Q?qk8DcT7WWMpvwR0EA+mSSV0JZuCfo8vcbsYECOEQhadI7/ypaOWTrycSxqQV?=
 =?us-ascii?Q?otGdPcBpXqgG6pSctgRO4XjCIDrjgCxvwvA4KpJjdrSrcqlQrZrp9VjeOvzS?=
 =?us-ascii?Q?JY7p51cacRh9eL8H2R91CjVpxKxfcRTL3n1BbPTo3B6Ggd+VHYty0iOCNF6b?=
 =?us-ascii?Q?KQE6OUVyEnwiW5D93iHeHmEMTV5CUWjT72OPssLZ/09XSnm7PUzEg/mvdpAw?=
 =?us-ascii?Q?tCBZ06HDpYfsJpmzoK/TZe5CETyg2uqv1ObynnNfB8GAR0ZbCn29SAHiojDE?=
 =?us-ascii?Q?4/Gg37yTXZ2btK1iIxTcK6g4DKgODD5FRn4fDYnEttz+L0uXEuOfAcFyAxru?=
 =?us-ascii?Q?I18X9f7LWofXP0suzF+7mkStkmD/tAp2GQ/wxu3AaM3nwNbDXWHo6DPIzMYe?=
 =?us-ascii?Q?k8xLi97Ik4I5QxSdpe5hY3R+Ex0hZKhuNdfW8Q6Yk1BeUs4/t0WxNGCLAlhZ?=
 =?us-ascii?Q?nKEhUOWyuCqcr7vPt7yWpyZdJeMOtwSd9UwAYX2R2/phlYlenrldpVI0o19K?=
 =?us-ascii?Q?basLD/L0OsJMkJTUG0ugtX5L6lryFhpaoq7fS7I32Ae+W7amlGQRiL5RUKr7?=
 =?us-ascii?Q?S15YM+hZ4AdbG9+SrTWMSpNK4edzQ/J6DD9JptyH7uvC0Gl7MfDEF2IOTTUM?=
 =?us-ascii?Q?80r12y8zFNipvdOOFCpbLW192d4xxkg3kQS6dOtOo/0NkJh2aEL13pBprVb4?=
 =?us-ascii?Q?LxA+h/IKl515Nq+EsFGcH0Spd2G32XLIu5Gj0eZzF7ug/q9P60wamldVwFvl?=
 =?us-ascii?Q?MFb125SsLtwYvkH67xgI5iE=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35a4170-8589-4133-330d-08d9f0a0b68a
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:32:09.8985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qHu0I5iRSh40JH5U+ahx96W/IIVDN8ChVJx3NUczxSWKCF0Uwk0XBT94dgD0SdILxVtPYcBPozNoqnOXb+xEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5695
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cleanup following nodes

1. Remove redundant i2c1 node.
2. Disable in-chip rtc, use battery-backed external rtc (pcf85263)
   instead.

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 494654338542..eaf1bc261ee3 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -225,10 +225,6 @@
 	};
 };
 
-&rtc {
-	status = "okay";
-};
-
 &fmc {
 	status = "okay";
 	flash@0 {
@@ -386,10 +382,6 @@
 	};
 };
 
-&i2c1 {
-	status = "okay";
-};
-
 &i2c2 {
 	status = "okay";
 	ina230@45 {
@@ -679,6 +671,7 @@
 	};
 
 	rtc@51 {
+		/* in-chip rtc disabled, use external rtc (battery-backed) */
 		compatible = "nxp,pcf85263";
 		reg = <0x51>;
 	};
-- 
2.17.1

