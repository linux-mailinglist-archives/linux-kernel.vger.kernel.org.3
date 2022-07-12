Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049D9571B58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiGLNc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiGLNcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:32:22 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CB8B628B;
        Tue, 12 Jul 2022 06:32:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBs6FwBxQ/Tuno9CWMG2F/+KgQz4Wd4J6Z54LCt1oWbN2j8rmUvlzNTpT3Z9UqMgMTZYUZd/7xrXRoljoM/K/sGy5axahq3kLni3A72yWYkeIGyKHaTH3FyUWMVd4YsHyJiCYVKT5mOqM3ns8/AJS0QTEXmXUiy3Bu9JiC2UjLM3eTeicuweCUbOSnvk+wszlAKKQyczQ/3Dl3Z2zrOxNJRqqGX1sROyqsf/AsW+rD0FV38F0weHQvoPGod3mpQN3m2EdIQ1y9O8IYOxhEtuk1Ewq8/kpoi6ZOHCngV2WDp9SZjsfTWbYUk008jxxu2IUWcC07G1s0XgyOjatObAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwhKwuR2JjNuDNRDeUk61bc9qQUrfny4xTn78NY/rJY=;
 b=OUqby3kk4VNU0NiBDVHzXVXvayN3jj7t4v9q+wvOtjp6dIo/HDFtKC/s41sN9gXqoJDREFmhBILN2CK0ZbozFPMt+LBGmAtuw2XYZlGir1R2C8rZb3xtrlxl0IGiaczb9PZPRE8AxkXx2lNj7duXgz909axVhDKmF164c62kL+h1hk3eUaaQgCOOyHutxCCp1CLqucMCXSnaD66Ec2RV39xMvybZobDly1gaeIpLmideZc/MHivom7/qSgRgr7MyH3TwwNp0OM7y9AGj2+9ze5BkziHafMys4MIymWzMkLF0GCSpDrOHRTTYYTvWt2gQ6dBJ82LIQL7IeR6LD0o+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwhKwuR2JjNuDNRDeUk61bc9qQUrfny4xTn78NY/rJY=;
 b=uZhi9JFDPOfL4X7tWhhAmEgODq+0rfEX9qUjNWIRGgkoa3NCEyKzjiycxeqFaa5Pr5F3rS6YvjIPwlZZDpqAi0H623F0BUUXvWtiY61Dh52qqyzWXiAgPbeCr0V5wOWv+8eMQGdLoYb0LbyZ3CTg7I9PjBa7NwCol58CJEZuD7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by DBAPR08MB5608.eurprd08.prod.outlook.com
 (2603:10a6:10:1a5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 13:32:20 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b%9]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 13:32:20 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH 3/3] arm64: dts: rockchip: specify pinctrl for i2c adapters on rock-3a
Date:   Tue, 12 Jul 2022 15:32:04 +0200
Message-Id: <20220712133204.2524942-3-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220712133204.2524942-1-michael.riesch@wolfvision.net>
References: <20220712133204.2524942-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0076.eurprd09.prod.outlook.com
 (2603:10a6:802:29::20) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c9f07a0-d047-4118-7af2-08da640af263
X-MS-TrafficTypeDiagnostic: DBAPR08MB5608:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FV4YEV/Ezo1yvLmS2gBIgv9zezUVTStHB/iBvMy3IvSwAnlP4cA35gNiiSMfE9zBEaBHACBnrmEBY+SAowOL6prSeMMFP+2puZOmySssNjyQxjz7q5tpGXLam4AVxv+hmtVB4Px/Zq2AnR+/gBbkC6TqzWxUFs4ixXB/LVDe+xABs5Wla69CBHrKJijGwyUBgrXjQBnxu07B+yPdh0b5U9YY5KY1dkHfFGSInDjO0m/w2IaXMd6q+umU73BZ0BLpdNO1E7IrwkrNDp5qmYbtyc4K29lA7bV2quDtCi52ZmlcQQf8H2ynHeptgW1IpCPPuSRJkt4mwFKKytgNX9In26BZjszCLRRLbgmySWCRBuUwLt+cgF4GQ4/0pdDWppZqWaeeooQrAtZhr5qaGil1/sq2yn/y3cnKNdOowW4GkDcIZLpCGaBEOr0kU8Kv6XADocNQSzweGL9h+6uREckEPCg6Jb9uxcRu5eVfzxzfs5NAHF1inPlfsj/YXsyWoEViRmV7FnzFbF3A5S8uty+wwhvpofEL+zsYleAFdWdY5bibW4XyG/eQR1xjMZOpHj3VUruRdI0d7NGewXrd3CVG09HCW7SDptYTcSyKoB2ug4gXzTdZ0Xlg1Jkst/G62Kd1v0eIKsxXIplXSrpYBNVT5pqC6TP7qdR9JFSm5a2EHH9TPAhBY+54Wrd9xRv1sGnCLsjwJ6bl67ODi1XLQvNpjjX+hapO++Dpw6XVuA720oiBbw9zDWmJABnn0bj6Bs2r+D9a9iA7N83pju53x6lNzBB5pHF8vIwSjzc6vR+MMLFDYs98x2d/kKzZmGz3+Xiu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(376002)(136003)(346002)(366004)(396003)(478600001)(41300700001)(6486002)(66946007)(38100700002)(2906002)(38350700002)(6506007)(52116002)(26005)(66476007)(86362001)(8676002)(4326008)(186003)(66556008)(316002)(107886003)(1076003)(54906003)(2616005)(36756003)(8936002)(5660300002)(6666004)(4744005)(44832011)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ymZO1TNWr5RyV9Ur2aocGcS5wVB97pbYDUOWKsyiPFXZ9/9XnZT4LPcm8ynd?=
 =?us-ascii?Q?0OYcvhCPjJQrt5AhHIwXDRDvYprTOVk9XwsBA0+s6LGbpRb5Sx77KHs8ZpER?=
 =?us-ascii?Q?TEyFu/eqKuoJGx+uKZv/JkDcQAmuLjIaZjVVwb6P9dUhxesb6FiADx3iv5KF?=
 =?us-ascii?Q?XlL5vI6tNBMiC2I8tUVuRxQ9zvVJpgKmWg+FkYn2Yvwyw1aePdRTV3hQAZTB?=
 =?us-ascii?Q?nbpoLYwnz7AE4+YO8kNvkn8UT2cGZfOcigP58ipV7c6cmKH9eAaKzlx0b5jk?=
 =?us-ascii?Q?v9gGjAxwtMfV0vMjB9tuYjkE9xalQuKCs65KELj8qhzzyE3QvA3eYTDt0Gf2?=
 =?us-ascii?Q?nuYh5YODM2XIcQFEVQdoJ7ExQiFc+MQPrBKYl+rHbrRJybT8gIxwF+AVeXS3?=
 =?us-ascii?Q?e4n7zabF/8ximYtVQvTlGFeyg2wth4iJt8iomYpRGUfx3ubwzT5Wi0Ew0KTr?=
 =?us-ascii?Q?KH9a3mic6KSg9Bc9Lw5Xxvus1X7nc6Xy+P+gy2t+zwYCwesfDPGdMW9Yho8r?=
 =?us-ascii?Q?TKA9n+CZEV+dxnIGWqUmYQdJadI4PhX7zQueSkba9XsFmRTKo3U3DgyKTpah?=
 =?us-ascii?Q?PzhEu0NBfTw32OTL1yV40FM1oJzyC5+hy5FX/IvI+6na+e9XJMf2pxSfeZT+?=
 =?us-ascii?Q?Um2daF2w+X+AAcY6Fjf7ijwd5o7fsKab9nNbhcOvpf+XuunlXge7Yceao1OA?=
 =?us-ascii?Q?1iFkwohOzlEwTQgyYELvgbFaf4J5FJtdJv31skD5DB8REuDMWVqSyXvaV53I?=
 =?us-ascii?Q?CUMQCGXrp2GuoXTQ3xTDvIrgIZJnjofP5WA6hw+O9ba+yKJHXjopRcJWu2Qa?=
 =?us-ascii?Q?xvchSTh29LELttTtwzx2nEpeOLu12ipDv58L5+puciEA0+eYDTMqPey0r1Q3?=
 =?us-ascii?Q?PBsI04p7jbbKMlH2Gqrra5RDDLynbzbOpbpGoDSmVBqFPgKN5MWG8vj+fzun?=
 =?us-ascii?Q?2ZCLw0qttxG6KcMuLjyE7GfFXJnLnQ4lro6mIa+IcuhkvwORUzikoRN4npRS?=
 =?us-ascii?Q?kg+Mv9rmHEK7gcpA7DrT9ji6Bo1qCd8I/90uhYRjqi6r/QCS96RgI7AapKWa?=
 =?us-ascii?Q?txFt7m/xoYYkr6grz4trwWrLAKjZod9E8zI3ty8lNAtSWGUm/Gz/0e4MgeA2?=
 =?us-ascii?Q?CNnTMe9ILrfobv94pLPd8nE86PCsRn6TppOKrNIZ8UsFfNoVJNQXtYlnCXBV?=
 =?us-ascii?Q?8EgCafOOc57r3FzvaSJgXlkcg7z7gzASRKt9qdY4ov+m+3lrC+VoepYS+Pz0?=
 =?us-ascii?Q?xkXkhRsd+Jjm/0fGziKIsF93gDjhgCMc/Uzz+gG9lMpBKw6lIAjUW8IQ2coS?=
 =?us-ascii?Q?m2A1F6qY7NDWiaeGdHESxbsYDky3gcNIH7k8n9l/n1jzq4copFF8K2qWA021?=
 =?us-ascii?Q?u71Cnd/joayEEka2vZygfyj6gzyC904mltbPyWqSopgFW5O4bP/BAlGTSvj1?=
 =?us-ascii?Q?F0qG7OfD3bZTM+WpquizDXtKWbGY46flIS6Ejc9otOMYa8C0NjL3GckfhJP+?=
 =?us-ascii?Q?w3KIW1C7oYCgFgvlmF4vHDoWv3PGpnJPSYh47ZfIB2LmDBR4yYoLPpKtFduc?=
 =?us-ascii?Q?g/SEA226H4iMyGBPnLIR43uconHMFySlVvZs9XdoCxxIapFU3tG2j7tixeKC?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9f07a0-d047-4118-7af2-08da640af263
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 13:32:20.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cNsar2VfCZCjbIQq3Yc+OrxV0egiF2vSnk9nlUXchJ4StpK/k0kXlA2gd5DAcEZquszMki9jUj6wPw/kCyOhF7Wl7kHEDED+eKQjmp/TqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5608
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Radxa ROCK3 Model A the I2C adapters related to the MIPI DSI
connector and the M.2/NGFF connector use the non-default pins.
Specify the correct pinctrl but leave the adapters disabled (as
they are supposed to be activated by overlays that describe the
external hardware).

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index 33581a36c9c3..8c533ee0c5c4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -468,6 +468,18 @@ codec {
 	};
 };
 
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3m1_xfer>;
+	status = "disabled";
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4m1_xfer>;
+	status = "disabled";
+};
+
 &i2s1_8ch {
 	rockchip,trcm-sync-tx-only;
 	status = "okay";
-- 
2.30.2

