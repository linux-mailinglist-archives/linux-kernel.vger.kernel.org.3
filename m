Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C82F5889CE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbiHCJvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbiHCJvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:51:17 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2754E5C9DA;
        Wed,  3 Aug 2022 02:49:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rgip0EOSsiaBRSmLeY4dvQN2JU/UhyF9wi7dghwyZjJuZHIkZtUkRGgMO1H6vvAGjMufed6A7VqSch9YHsY9PO4aJGwnpnHCfFpnGxBX/V8VumSRDhbwCcKsai6ezt19dbSJi61/GdqC0Inm3gTFpA3Zo3sbec40zis6V6kHvqzeT22DZSTny4mgRE8HlweemwneJPeCYPnGt9dymJvFZPw7tizbiEEieEI8en6EAn6mphDcWF+mQ/Ily5ozke4GPS+ZxE914SFaCmg01OXlCPle75flw+CPnO27s7+/7f3LSeRYoeMy0jZ7ZY0kxqnfHuAQYzT2OOfSM11aqLfxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDbqe6PXSJWyMZIC/B+QB8miZyKE75OHiDHKXsV9KxA=;
 b=fDorSynPZywUMgsxQ/sBnTN2BvAOh/0rGpVcTnsl+ByX4P4azCLfmfRwGolr4CyWCejt85C6gWqrjTciy/CvV2c71JRsvA2AGy4xK2LQAxSukPwN3E4rwNvz/lkkRKUSDI6SJfdD7KcWZkj8FS4fSQuEiIAWpgs7xWnHiUKY5ricL3ecdI1ZNpJCADmJBjPA570GGaEe8Z8f4kxXgz73y9HDOT7noOOlqdhx9bTxIOejfIvMZsDs+wPmeR6bkJB6e7WxYf8UbhaGdElMfMsHmXw5x9LQj9LGodSvqNmjZRhocLT8exLEi3PH1ffTuqjhpXcyO76VhDi0OtXnZDKuUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDbqe6PXSJWyMZIC/B+QB8miZyKE75OHiDHKXsV9KxA=;
 b=bRVi0jJ9pfUJpH6KZeeX1Q65/8xqTKEK6kMKV/R3sDEUnYBkUMVr0lPLhoaDtD5haxbFiT17LZGZLRe9AMgTPPE75/B4GFpTojT1kBvhQ7iiZgSMWaR1iz9jIip86BMZY9Q8hIagX+ZGHdv01Li9lMIdGeBBDolZuo0Fw3c9TSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2891.eurprd04.prod.outlook.com (2603:10a6:3:df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 09:49:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 09:49:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] arm64: dts: imx93: clk update
Date:   Wed,  3 Aug 2022 17:51:01 +0800
Message-Id: <20220803095103.3883035-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::33)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0da28922-ae5c-4277-405e-08da753578f0
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2891:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zAzdC6y7y9T33jKEBmBIL6p3K8dCo2tDtjCoIrh2bINKuccg3glUkj7hDLtHZkueYJSNGi+GJM4xDvDlOMDwW2jHVP2tiOdssSCxTPrASjpJGejz9xVcCwgk19YgQNWwhgQ6x0m4HPRFWleYA8v8KSEr/WNOkZFJuuHxrzy7YjI0xCuCBqemF1udOwZ/OPzi/cNBgeRukKOv21+94bei4iR+PgayJC8p3Nc/bTeA56y5FA1xBMAYPEQHD8+o3FvDSTkpRE9Q8EyTJTJf/KJfKnrobFLV+v/1S3wHknEZaJZWeyVUMNH83B1RidYR8zW6ZZI2N5fL4C8A2Su1BxDPPyQ5aGeGCi55MAaV31/Oq8kn/owtiwZyJ4DRJzQGSBMVF5Q7zAaQ4o4QR5hRNJRbp+4a9c2KEab5VZvHt9A5Z5aftJaW2Y99YcQDB1TXh837aBRN+6d8ch5oITPKJ/0jTz6pG2NfmKK6dGQZegtfZhXlQDBkoB5XKtNnrt+k0BcR6twpfQJPgSKLSsGCeeYdJa3aHLeewe0Z14ibJWBwHAwpMkaR+S2rslxBPmZCP0uby08kCJtUv6jWlTRtga4HxQpDC3G3dn4nSivHw/OKmhkjhqRp4ESyYzO2pJ2y1FWPec7ZeN6iqKjgY+iNgRPb1g+qXKHwVZgI+IOL3GU1mWHAuvJLXqHMeWfVyWbfsrXpbISnmi1bKTs13KKD/NT/8NXjhoAH4++9Kje9anPGEEOi5iXHT+JsYKXhAtU6spwRfy9AXN3a4Z5qFESYrUW7Ei1UGqTk3HtD748OR0st7j0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(6486002)(5660300002)(478600001)(4326008)(2906002)(66556008)(66476007)(66946007)(8676002)(38100700002)(8936002)(4744005)(38350700002)(52116002)(86362001)(1076003)(2616005)(186003)(41300700001)(6666004)(6512007)(6506007)(26005)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DieP15lNNVZkAMTfJyV/sT4VZzMAV993JZR+lWc5B21dOkYDCgxpvD7JgadX?=
 =?us-ascii?Q?zqDMNnXSEFXczJsztYPjiSoCwARReQi8buRKCSMDflXZGsD3YJu3JBT/g6OX?=
 =?us-ascii?Q?3YSl+zBZI8AbVPM2DlLMGCuqdpdJPU2ZfdQpNSdgijfyWe1BM4l4gAX5XeBZ?=
 =?us-ascii?Q?qaKA/gtB8VcKGgOfccekCfcvXKw7bHvpg/3MuOBYEPdhklKwiODZKBjx5ykb?=
 =?us-ascii?Q?zqRcErLRxpLtArmlnVScymIJdemUKFnsH7DN7CPpkud2xbqcdiaTAoJjZ9Jy?=
 =?us-ascii?Q?vnd8x5qguOtGUZwXU3DoRgxSk04GAmUZnz5tMcnThah06vkInZOydDAUZwsp?=
 =?us-ascii?Q?q3udJV3cWDioWBnAVq5SgmxnCAifte1xOk9q/a0Dod2PXSeswX4NPHWuv2mu?=
 =?us-ascii?Q?jd9bl8gb7UavwCA6T3pKg3QTBQJJ+PYDCdW32Bx51bKFkvjtD2YFOi1q5UV/?=
 =?us-ascii?Q?ckaSZNGYdHwjhyUit5BglnufQTFFO3tcj8UAlNjct69DGqDrne9Mo/1veRal?=
 =?us-ascii?Q?qvulqPi2jgsAMQWJL2IjoKIukPhFsOhcEcHiR0/o2wzVOAGuQZ2UI2SDiTrJ?=
 =?us-ascii?Q?DlEUesaGAaSDy2wCGo+ho4BSFOLZYyFvQzXvzOlTSRAi8mLpqEd3+tGribQH?=
 =?us-ascii?Q?++VN6RuSNa6rdlEfMQzpIPJrVvoOvCOs6yPNIh08VtfByHLPl7goEEofcusV?=
 =?us-ascii?Q?mYYZtQsdLPj0JlQ6Ttta1C+h2kWEoDGne9jXQm9kUyMPJU0KMGaRjQSDLjVL?=
 =?us-ascii?Q?AOXDYeC9LLWeNo8oS8apGEYfNMjRpNi7ndztbQW4s/FWuJtfpHiBenJ7FVYq?=
 =?us-ascii?Q?pBhhr98hnnx2ek7HgKMz8w1YTSoyBMokNieOr1H0KCJBqV4+h0tIlaL0BHV1?=
 =?us-ascii?Q?nX2ETTDhkmKYAt6WHeNjfLAAZnbR5rW5NRcoX27exQbgQtQBSaVYSCYCtyfs?=
 =?us-ascii?Q?DghXPjs+9QNjEopy6ZM0zdxTeamqpe3HlCQO+QnduqUtJ2+xaKi6z8/VaVIb?=
 =?us-ascii?Q?egbygWsZVcMQFuqcqDsPyv63caowH/y1BjZsw1hd5Gj3LcZzciFm3wyYP+QP?=
 =?us-ascii?Q?nPqyQZZ0cCBNFAsHfuavXUetPZwiHWvutkswhHsYhcS5pFgXjF8HA/58RZJy?=
 =?us-ascii?Q?zMVhuy7KtjzIiTKw6EIrq1v9W3EZAU0p40qu+tHe8XuykwV8qCJ5b2+1cwLh?=
 =?us-ascii?Q?sbQBirfkjT44jTyxptGS6PLaWamM6feegTMjLkla81x3pUiFKgl8diQFSwAs?=
 =?us-ascii?Q?iwEXOz26VfmaDCwdBF8qLw1gojifjcWMIwVfLzPS6U4H63T19i21aH5h6t5d?=
 =?us-ascii?Q?6GJZxsgTMtDjCpZhfhUVLHz/z2QrL0rWadMu9wcVsLnpxZ84WK5y7ctyxSMN?=
 =?us-ascii?Q?GfA5zFIX+pjU0GuPmtp+nhDskAyhrPXDG1jzUR1YrDDrKVJKEyANuhm0k84q?=
 =?us-ascii?Q?bFaNOgc1N3a32ZnKsDvFXUQQDdNTfo9WcSHzbDAU+NbU68pr8sg6v4vHoTNe?=
 =?us-ascii?Q?ZEF5nwGNcFzc4JvAv5itW3pRJgIutXKrt04L3KXnTNDTxWTRTCWqLsgE3iqo?=
 =?us-ascii?Q?0h8uVZ0qgcNn2Apy/swgmJaHlL0xBAMNq0wZQZ66?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da28922-ae5c-4277-405e-08da753578f0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 09:49:35.2501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZS10PY24cafUUZfIku8Js9xSqnCJsMF63RsMHUZLW9fjmrN9p1tYOJXLXnYrkQI0uiEFLvxVeK1CsSEpZMqvvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2891
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Correct sdhc clk
Add gpio clk

Haibo Chen (1):
  arm64: dts: imx93: assign the correct ipg/ahb clock for usdhc

Peng Fan (1):
  arm64: dts: imx93: add gpio clk

 arch/arm64/boot/dts/freescale/imx93.dtsi | 27 ++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

-- 
2.25.1

