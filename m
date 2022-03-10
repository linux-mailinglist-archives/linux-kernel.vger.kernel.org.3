Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56A44D5360
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343726AbiCJVFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240910AbiCJVFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:05:09 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0ADE0AF5;
        Thu, 10 Mar 2022 13:04:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A35PUVIwzl5I87e73UKytiRT+NX8mdy7b90WWoDhvGX3qIZNb0/lEhmSWN/7rIa8cXIOr1Ktb0l/IeMesCggF1ZTKC5oUc4uljHVr0z94d35TSMn7bIXNGUljsuIwDVESFPUg4i1btMgdbzuC1cihJ8AfA/HiV7i0bW7tfjymPBZ5inlQfsAzmtCugkgNb8pMScZ8q5VDMocuZR29L74J44ZJIXL8xcfl0FwjUks2HEXRtCYf+5almmhC16l7b2MoGbdv6d4rexjhxc6kNJxy3PbNsfMsgmHgvYlOKmXNhSi0VcIAJkKs2Eio7xKNDUAJnDV86T/zw/oUE8oT9uWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxhsBdnK87/cgowtU4sJnthRJHvviADoflEZ93URbsQ=;
 b=BDP1ZoGmh4jIxqKbKvII+qtulgsvRcouuzYTxo9gt3MFqdiIjqSAxlNY7HFM38ehL4omD9gwEPfwlC/uhPWlknvvgyFbIj64CjzJ1kw34DNEVZY4icUkI0DAwJ2CDzYz55kOmtXEltfJcBW+dhdBpN47V6tRZUsRF1/vo+2OCvcueeyTbnQsa0Ae5x8pzVp6XR2AIoJ/9BUNKdxnpidtUk6z2P6xXHWG9E1GlnitVm7puL3ncUz/rgWVhIpI2S1BRf9wivUu89mh38It60lNaU5kKrGwPyLc+x3mW7Q7tPrCZTWb6g0ofdKy9s95s/5i78ed1Z9yP1pg+bHrP1FmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxhsBdnK87/cgowtU4sJnthRJHvviADoflEZ93URbsQ=;
 b=j4x5SiYuv8brB4z0T5EGPd7rYoFJEnM6IcmkxffHqd5PpvZQ7tzdwLhJDPY84me9u+I2xbfLUNUVHG4afGnKVsKPXikZWzJBgloY3EvffdzbHziPt2fX+JL9Mvr/q8UTxp6i2G3NbJDKZ6NyZnAwKlVMLbJhxGGjo5zp45bx4nk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by AM6PR08MB5078.eurprd08.prod.outlook.com (2603:10a6:20b:e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 21:04:05 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.5038.030; Thu, 10 Mar 2022
 21:04:05 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Levin Du <djw@t-chip.com.cn>, Tianling Shen <cnsztl@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alex Bee <knaerzche@gmail.com>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH v2 0/3] arm64: dts: rockchip: add basic dts for the radxa rock3 model a
Date:   Thu, 10 Mar 2022 22:03:49 +0100
Message-Id: <20220310210352.451136-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0132.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::11) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95c0a598-42ee-431c-3d1d-08da02d98261
X-MS-TrafficTypeDiagnostic: AM6PR08MB5078:EE_
X-Microsoft-Antispam-PRVS: <AM6PR08MB5078DE225EA666B2BDCA64F0F20B9@AM6PR08MB5078.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7/GeXZTe/BNFuptaYzzaxsMK2rLO1CaWYCrrHTemwH7ndqRDvrvUu4NAA+ueMs/zwY5RZ6Tw5EF188sFMwcrPRnCJf8chvowgZvpayzPi0bZARLcgRRnGtWhbodqpLt7JGHYQ+lDWiEjoPdtffmtyME4NDtuYUYsZzyhPNXf/ixkMFzK6WrC8A87C9zl5FO3osSxPTrN5tMFZqWnf8UJ1rndgpqcNzxDfX1zbLAZ/MZHjSfW2cxTH5MoywRDR1EdG4PkQicQoI5OE2B5v399MP1LjzhjNslMVmD827K4Nex/CZb6aSDURNf1OrjpmjS83h9gt/X0VU9nMrK3iJHdbeyZaBDsPnkHTodnAXIevZ0LYZa/qV89b8//3nPUfNl2l/ss0xgEHRSunXaOX8mTzGzGjXjdkvvC/WINk0q4nRDMe7sUjJqKT9KAbCcx1rTRZOE6zk7/ejOxp6/9PLEOutTFyaJkyb8izafLusrFU/guwoF9ids6vaEhDf6xDj+Lq6CYfJbOJG/t4FBiOd6IULMoknc3+atH118FYw/IItN6iyM2ulFq3B7Wi4LYzwfft1fkPGbkH9Lj009VcvS3EpIg6gFI3YSdX3JFQoWinY6Dv8+kocCeO5gTiilCiYysJ3GnBHpYnGlnnbw40QTdvFIusoe2nwVqG57eI9+RQPXSf47450gJz/XbHZEb4kN5JAuzfxxZ01/Ri2WlrBhOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(4744005)(54906003)(186003)(44832011)(52116002)(86362001)(6486002)(66556008)(66476007)(4326008)(7416002)(5660300002)(6666004)(8936002)(66946007)(316002)(36756003)(6506007)(6512007)(38100700002)(8676002)(2906002)(107886003)(2616005)(1076003)(129723003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MPUYCc/hrIcqQtMTPCHuWq19ZlGQvHGi9lPD8NFcEOp5xk5Npdolv7lYFGId?=
 =?us-ascii?Q?ZFxgCShrxqtOESx5RiqUcP6wbW1NYIUqjR+sG9VRNNjNyezgUHoW8I92QgJE?=
 =?us-ascii?Q?8dq7fHZckUR+0dlF4l4kbCp/fVxim0/V90+stFG4dax9ANDHn3ZaGAAP3Hb5?=
 =?us-ascii?Q?7r49fuQiCK/OvGF1XVCeR1gKmPW5VSj8YTwz1/CQNNwUYiGkeqOLJXyf+8If?=
 =?us-ascii?Q?uTfF3arhsY5jSaONTyfCdXHDcnxhLqUWxceZr2ByiOwU/NL6HzN2LK330gg+?=
 =?us-ascii?Q?Hc6U0KemthjTiZY06vhclFAm9fyi2bq0xXdMBHp6+NNpI4KWW8dKLMDy20aG?=
 =?us-ascii?Q?0d6aprLBBalOFZ2hZxvgDrPTd6nn89QlV8iI1nd7zrlReqaKnoYVjQ6Dt6KG?=
 =?us-ascii?Q?TzmYfiFDAs5VFohxDPqmS8y3MjJv9YwSwcFXiw2dT6PR26vsDkQy1g4CJ41l?=
 =?us-ascii?Q?tw+KzublWtIbkNHP5LtRVTETEkaAoKJmvFeChyfHNYShO/TIvcGrY+HtUSv8?=
 =?us-ascii?Q?1pSoTHow8XulISZV+xrN1D4K9Ov7kIBNO3wRJsUysrzwAJNedD/xwmKO5rnV?=
 =?us-ascii?Q?+0gFSHP1lGkzieKMwQEYqhh6gDuYH5peW0DLZfZBu3aQHZFnAqgdtwbzbKbj?=
 =?us-ascii?Q?hbGiYft7SPv4PozIRhDMHdR6yRoAZFN6kGPz6aQWW9CgtjmbdAxi4YKISr3S?=
 =?us-ascii?Q?uYTMfHN+jmzmvsigHZ906u12bzA3F2GtSfC+WWAxhDCyLe1ivBygUWsYIz7A?=
 =?us-ascii?Q?Qn8VP9US57Kx2YJODf+AqCM6uutlhOvI7azS6LznlxVQCjdRVi80oKaYcgpu?=
 =?us-ascii?Q?Rbpd1Ne3Poj6DkI+eWXiNDk1+DhKBIPbgbg97ncTzu/+WZP0e2xl5UZPrXUf?=
 =?us-ascii?Q?1YPKncKpynuO/zjChew3NWr5Dla5IgrAE0RqK7CCDFeh9AR5BisCxZ4eG0YH?=
 =?us-ascii?Q?0la9HijYtxAKCiRXkZgbU35Pi4V8h9+2ydxGXv1uVZZEU7fiZiemwwd3GKLp?=
 =?us-ascii?Q?6mtRqH8X/mVcou/BhilNGHGTvf2q4KwbPTIs9MVu2h+V9Lt8EtrXnkJ68C+5?=
 =?us-ascii?Q?IDpm8H4O/CArKUrrUrslQccWZRLLvuD0F1PZLkZDL8QEfKjdPRKt14VDloID?=
 =?us-ascii?Q?BC2ZzeFc8b/edXv3lJ+eSQChjr94dTCBur1lxFg4BUAbg6hdXlCoPxGpZ1GG?=
 =?us-ascii?Q?pWhwncahc2eTOOKyrPcx58/+9v2F1mFeDj4mkbXuj/5XOIhjG7nkpimV7lTp?=
 =?us-ascii?Q?rBPBODpElHfAzxN3vrlavWiIEh9Uh27t6xp5qO66rsGkdA47Sr1AbO5I/f/w?=
 =?us-ascii?Q?xyehdsHjB7hd3aqmZm+byyvA9ZBoNenNkwp8XAPfUL+OwxxF4Dh/oeaXT3Zb?=
 =?us-ascii?Q?gQnBv5Bk87gNV9xEh1lbP9J4zi9JpbiRiHPskkYSHKDUK8AoV2gylcw3+wEG?=
 =?us-ascii?Q?VHYoruZTrUTszyKLQXjYhThC7ORGksivbxL1MsAx/Q+UP28ZES+ZRMlNlXc8?=
 =?us-ascii?Q?N1gz1WoRKCu/t8uaeqk5DjOu0Zt8LJCBpTDB1cjXVbXfSWZ3kgSBr6QFKZ2Y?=
 =?us-ascii?Q?kgkj5sxhEITi2IvMF8w=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c0a598-42ee-431c-3d1d-08da02d98261
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 21:04:04.6790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMh33CA5+Wr5/wEK7PCCd/c7sJGQnC2DQoaGWOoGsIoIxr0msnWB1OUuyQeNkQ46HpwoK2RPqgM3j+y1w6LO5rEwNC9O+X67sTc7fmsIbEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5078
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

This series introduces basic support for the Radxa ROCK3 Model A
featuring the Rockchip RK3568 SoC. The basic support includes Ethernet,
USB2 and the headphone connector.

Patch 3 adds support for the Video Output Processor (VOP) 2 and the
HDMI output. It requires the VOP2/HDMI TX patches (which are discussed
on the list) and can be considered as RFC.

v2 adds the missing entry in the Makefile and Rob's Acked-by: on the
dt-bindings patch.

Looking forward to your comments!

Best regards,
Michael

Michael Riesch (3):
  dt-bindings: arm: rockchip: add radxa rock3 model a
  arm64: dts: rockchip: add basic dts for the radxa rock3 model a
  arm64: dts: rockchip: enable vop2 and hdmi tx on rock-3a

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 548 ++++++++++++++++++
 3 files changed, 554 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts

-- 
2.30.2

