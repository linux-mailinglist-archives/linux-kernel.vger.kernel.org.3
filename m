Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C084C45C1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbiBYNQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiBYNQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:16:48 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518EF1FE579;
        Fri, 25 Feb 2022 05:16:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIopU597FkPKLSEXkcZJO/19DyfNTmYOnOrWxCDrUiAhr1qMqycZPtrwQtTPH8Pinz1UWXYa7CHjNzT71jA0KTVccxzUbg+hioP4YtPjSTF0wZmyBDwHyOJUI3rKOKr1B2RHGCXLvDq9iaLsbwl+kgjuDE95o8ZZGGMvFEYGIzIxO1VLcW7Hwfg1tEF9TJav/coJeEEihfxkbeHk4KTD4Eiid5gAl3/zFCpt2+79L4C2LZ3TbHexTmKnrEqoNvfMezyae4X0huObm2rZk89VkI73db/lrHcQaza2g4VpPCqC2Ew62A2qcRV6GNP+0Q/CHv+L5K8VL6f9SuWJK4bjeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wissWNh538t+jfob6SX7qAojapmbWq4t3xPFlIinXI=;
 b=OVuteHDZW6YJ495xqXN4K3KsWE7pp4yQip/Yse/qrgbrj+Ncws5ajmR/DnBLuks881Nui8KIEkcgAMggWd3JUbN+SmrEwxyrQZUtOcD0xovyCGTEdk86+a7IPBaK85v2wsJdurQDqtIswtQqDysqhuToHoK7kBefYjyExdRnRZLZTAdqLq3yMqDkjoDJOgC5FSehs86oG1bV5N+T13B0kDz2nuyZRxY/i19swrPNXGfjIj6GUrnjbryQzGLxIvVvdCAUE7KPiHUGugUyET1LxIU7syuIwqNoNLcnmjNzvMZ1Bu2OT1Xk4AZi1RaxI1afowBJvxZn4CwCRN0Gi04ERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wissWNh538t+jfob6SX7qAojapmbWq4t3xPFlIinXI=;
 b=S5JrDWRS+A1MhnEPy8i8PrNwKi43PuXAk9uURaJrurby/maOuAX/sK2ECBxiayPBNLGvqQPETxVXc+YHh7kn7047es8C0DdN6/KRQSq0uft3y9G3eoNY7hi3/h6Zeq7SNfd5lcBvGT6Wa4vz91PVcYmtTfqFEqUQuDUVt6U95ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by AM0PR08MB5332.eurprd08.prod.outlook.com (2603:10a6:208:17e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 13:16:14 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.4995.028; Fri, 25 Feb 2022
 13:16:13 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Simon Xue <xxm@rock-chips.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: [PATCH v2 0/4] arm64: dts: rockchip: add usb3 support to rk356x
Date:   Fri, 25 Feb 2022 14:15:58 +0100
Message-Id: <20220225131602.2283499-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0109.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::6) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed3fc01e-6d3d-486e-ebcf-08d9f860ff6d
X-MS-TrafficTypeDiagnostic: AM0PR08MB5332:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB5332E9A48457C5728C2C37E4F23E9@AM0PR08MB5332.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+swemphyyXVlCfMvjtQ/iYLFBfypOu1Xr9UFwMJBfVzC75aOMaoIptBexHv1IlUQ7/6SpwNypQ8Oij+sj1S1vu3HHTnZSZ3b0gSrWZM5Dfy06Loo+gJwpNE9aZdhPYf+BLwbNRT+2EVfWbB6c/h083qobarc/VAVPiZlxIUQ74OBLlaeT7BmTDVyfTlYGL/iM3IT2oSGVs2uGF/Jb4ulUAzEUNs+Vu0L3/lOxf8VMcMDflcBt8WTZGoAaGqmqQdSqfx7JoO1WjvhNRk66pAqoCJ0y4UphqGwcRV1efCGXoOfEg/fDsNsr+IlpzTcxnrqt25eWy9xB/X1GSyRu6ZsZxqADFEevRkcsc1OeeV0Jdbk4XVK+YgnbVJA9kz0O2fMUVZXI2cZjDHmlov5Ia6okupmNxcVFbMv+rVeR8IIZ7yuWrAaeQF3D+8LoVowJFkDsbXTm8FyBYVt8Ow3pHpbfjHGsSIYU8XoNGCMEGaFZ6JOPDmWJcjCWhdq+uE/kLjeb+3YWarCl7ylpQZhPFvzG1DMbOanb5DLBest/yVPCwsBN1F7G7pB13zpzqH45v2q3yg6Ew2abKiqgd58waGlyLRagLfEdzKcw1k1gN/KB4oWZbJzcjxxl+rZjKvlxVKSG8nU8INB6hGhKyoybB8og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(39850400004)(396003)(376002)(136003)(346002)(6506007)(52116002)(186003)(2616005)(2906002)(54906003)(8936002)(1076003)(6666004)(83380400001)(6512007)(86362001)(7416002)(8676002)(508600001)(66476007)(66946007)(66556008)(36756003)(4326008)(6486002)(5660300002)(44832011)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D/RFY63LUneoNpiE97eW5+d2MTYrwnnEMgjatezkD3Ako82uLjgTMokxqQgM?=
 =?us-ascii?Q?5SpAQka1XdqHHlmrB0kwnp7ALu0YdzAY71P5CqZwLD8NIDDDHpgzuMyZqASq?=
 =?us-ascii?Q?BpUEXz51cz9sf7NOMmsOks44RFw6ggB8cdtmSfBMpwR5ve3kUI+2WU2WSZhS?=
 =?us-ascii?Q?dIjVDPFZa5bHbW/D2VFVpP07RxqAf0derkfa9PDDWM3Yb+bBE9YwqsHoyY/L?=
 =?us-ascii?Q?V2dc136OZjqQZJa0rEslzJq2QbfJDaqtwhKQblXGRy6vS+L4qtgZ+XsWMHL/?=
 =?us-ascii?Q?tov5HduW6TJ5YtUikr+SmIeV2PGo2gLl1pYkKjwR9Tl7zC7f0cor93c213tr?=
 =?us-ascii?Q?wRsNaYRsZPTFYpOhwVkurxVz/3BwB+2kWT5tFBXduS7HaUYKzKFrEWOrJfb1?=
 =?us-ascii?Q?8dvrXWu9AaMR786TYaNXCtBFUrmdpSyW00gJKlpX3NSQWLefWahxCfcdAlir?=
 =?us-ascii?Q?Ah4KAR5tD1uhhIVzDiH7XpIpDdYMVJ5xzHxuz6rKSJ88cyNcHHw1kYlhO2cW?=
 =?us-ascii?Q?iau8KL9pJmqYy45Vk5KIKL84HyRXQC0K7AOXUwhlNa6HJq6LzFEKnnzJPHaQ?=
 =?us-ascii?Q?+KJQ3Roech9iYniIxYwtQxNM7RCrC6PE2CASmDtVjGIsKIh15WnAkZq7QLSg?=
 =?us-ascii?Q?lYV0CltlMyh5MCvbUIdKflFXVak8nST4tLj/BD5VznsuJaSxbySRUITWE8cW?=
 =?us-ascii?Q?f7mhx8PluObyVkrkSTjWwDENE9caLpbtyad/QcIui3fbHWe9jvaDtfQlo9CJ?=
 =?us-ascii?Q?PmyCZl/fCduu4ApyciOdLPeE7qVaeB3qenk9/gaANzPY/8Cei4Q3VSZTgZez?=
 =?us-ascii?Q?QoBkKvZSJhHWQe79Ab9asVv8OE54M1Bjud+AsbIOd1x/lz4vzGVYlrjYLfE1?=
 =?us-ascii?Q?WydErL4jC5CTm6plpfsv60OAfnPSRKxJ8vFtCA6Lzk0kojW0jUXChOrmH76M?=
 =?us-ascii?Q?FYbMVZpB4jkHU3SO3MuX+C2U2tojsJhK0oqwh0SMt00bcbJh5WYvEJFMMXxU?=
 =?us-ascii?Q?1okl8E9OFFp5/+C0rZAAonljKCIvw/EsIulT8qOIZEMwFs4FyhERfpiuIT7J?=
 =?us-ascii?Q?NAWWU1M+T5lZOHKb7PWo4oH6/4G+RApzP+5Fe17C2NXPKu3BnU4Bivjrdtbu?=
 =?us-ascii?Q?a51g34U8FpjLWIhqcfweYlOY/D3yXuVnJhx0V0frHzu2vwkup+ourgRcwouy?=
 =?us-ascii?Q?KROmyeR/YxhhXu5CW8RZk2sck81bQiBvbREz3kyBXHFpM4aTetsyEVU5utuP?=
 =?us-ascii?Q?B2XyfXGA4rLj7kIsSgKw9HiRJUbbYFZsHU3L/3dvySjD3Jn1DmFsLZNs3rFj?=
 =?us-ascii?Q?sqAJad5JDJuOZC4j80MV58jImtwc3maTTUGTSw6mUGBervvBy7w7MuqHHdSI?=
 =?us-ascii?Q?zgBhwfYrtQuH/gqLtxmD2q7hhWIguaObTEOAuK14gNA1R2ySgoAoJzWlrohd?=
 =?us-ascii?Q?m/wAEU7FeVY6tr8s0t1trLwv0+BFSfJpQ8QU4vPflTVHcz+VIYr+m0AzIsOn?=
 =?us-ascii?Q?deCIQ0A37Neb6JOtFuar4/ooNQvQZqxnpk9cElU0rSFhEFpUaEJSB8c2HVLB?=
 =?us-ascii?Q?0JMLdMTvWo7DzzERLkhlfukZuka8ULt3qamnNaDx1tarRft5ZpG5O/6S/aVM?=
 =?us-ascii?Q?jPU2StQObtE+9UN5E8gHkzKCBePsYyk9+iCzJnN3QyJTLgvheCd/CmKgOEGE?=
 =?us-ascii?Q?vDu0Vevk6rWYK3PZM/IqSLNgvhgzwRmXIx9njvdD3PVAdVRxf3J4ZWbIn97g?=
 =?us-ascii?Q?vAZlYvDAEN3H3wXFtJJsL+Wc5iS17yc=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3fc01e-6d3d-486e-ebcf-08d9f860ff6d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 13:16:13.8234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eN4REzegwkvvONYYmg5V+lqfC16/MyWFfDr/CN/ht5xMKrJbnlMIIl90ctUf2U36a6T3LGxmKtCjUSbux/MAy4sshdElm3l/ZyJ1ilK0VYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5332
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series introduces the USB 3.0 xHCI controller nodes and enables
them on the RK3568 EVB1. USB 3.0 host and gadget operation have been
tested successfully.

The second version of the series considers Johan's comments which
helped a lot to clean things up and get rid of the dtbs_check issues.

Looking forward to your comments!

Best regards,
Michael

Changes since v1:
- move power domain PD_PIPE to rk356x
- add rockchip,rk3568-dwc3 compatible to documentation
- merge subnodes with corresponding nodes
- remove all quirks (add at a later stage if required)

Michael Riesch (4):
  arm64: dts: rockchip: move power domain PD_PIPE to rk356x
  dt-bindings: usb: add rk3568 compatible to rockchip,dwc3
  arm64: dts: rockchip: add the usb3 nodes to rk356x
  arm64: dts: rockchip: add usb3 support to rk3568-evb1-v10

 .../bindings/usb/rockchip,dwc3.yaml           |  2 +
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 46 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      | 17 ++-----
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 44 ++++++++++++++++++
 4 files changed, 95 insertions(+), 14 deletions(-)

-- 
2.30.2

