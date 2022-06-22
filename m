Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D55F5542E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiFVGMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiFVGMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:12:36 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50075.outbound.protection.outlook.com [40.107.5.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469DF205CD;
        Tue, 21 Jun 2022 23:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7Hm5sgNrEDD9sBXTLVzdzDcYGYvtSj3TEF3BmUw6d/DVjUYa+enAog8Y4G33Hvn5F3vG+wIwoyuml9ns0AsO2sRiB0QMvf5s+loz/40l941PW9f2bN7mi3TKDZpiz/DMHphSbuRFCejW3hjGGog1gqfzchtefiiG3Kat3vZBI39t5+RF1rANBuHSGESFqQeP6newBY64MpGLGwyDHdcFDALyp92LJX+Bvyx58Dim8B0Y1GiWshnwBe0zQOabDlhYOwQyO66dn74XaT+gGTiyLAzx2eQf73Nqvz82/O5kLBqCWgcJdP3jL3Yvs81KuzZq17JgaeaxYxHe1xMeF2rvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igf+rCWJnk9M4X5AryTMM4EpgCPAVPcMI1nCvtQXu5E=;
 b=i5NoJ92VhBUSEoOvqsEF0yWVuGjRi1d3MfWvbIiKxfrtU2icoL0+HW+9r6D8Tr02dup0cuLgVKPlwx7cv5e0R2x/GfNw55Z1EzARc7UbMjpUJog0U27wlK6zpGNrAU4YbGJrn34FKo0+0rKz7Uz6OEtvLkWNxHW4Sy4EtwbLXPWqttJxd0i+NsDSHr55eQL6CJgMCS8smhYWpHKMUvkUoD1UJ5EAiyBQcOWyvuRtup0yc3VvEpxYBASeQkjEU69N1W1qQUqHbtDdU3Lz/IYGAwq4qDVFAPuqdmAKMI/bHGNJf2tciytCdRFrW3YdjgXHyGgQD/NHt8L1dn1xfrtQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igf+rCWJnk9M4X5AryTMM4EpgCPAVPcMI1nCvtQXu5E=;
 b=h/IskNVjHQLvpraNLhDRFQV79u7rdY7IvsOrc6jxd7CanTfwWdjCnycoywz24erq4WQu+tIk4QqNnUE6Rpk+NR7jGIFlen5bfGvb+HrQlVYUYuOs/1OU2lHiEgnmAqAEnAqeXSAQ4puvfJJkwZMzJOp2mFdk5TX3rD/KMlJMdVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7986.eurprd04.prod.outlook.com (2603:10a6:20b:245::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 06:12:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:12:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, hvilleneuve@dimonoff.com,
        l.stach@pengutronix.de, abbaraju.manojsai@amarulasolutions.com,
        jagan@amarulasolutions.com, matteo.lisi@engicam.com,
        tharvey@gateworks.com, t.remmet@phytec.de,
        u.kleine-koenig@pengutronix.de, t.remmet@phytec.deh,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 00/14] arm64: dts: imx8mp: correct pad settings
Date:   Wed, 22 Jun 2022 14:13:56 +0800
Message-Id: <20220622061410.853301-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8afd9276-3f73-4655-b5d6-08da541630de
X-MS-TrafficTypeDiagnostic: AM8PR04MB7986:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM8PR04MB79865D43E59CE13F1C40EAB6C9B29@AM8PR04MB7986.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WOfsJTVBHuNLMH7ZvI/nrG1kZNO0FmEPb857D70SUgkTLbHA2fBhCF7vO+sZACLNcMC/BwU13EnzfW4Ma5SWqZVu556FKQ1nmp3o4Hyi1rvVAtkXr4ku5PW9Etll1Kpo9oqor6lS0+Z2yl4lk2+OJD3G2w8YNkADNd1kwVhaGKRUft6KalvuHH1OT00ZmhJZdmlQYpJB1XkjSob7lx/VPFW6nmjMiX9FufVYEgWyQOGEqQJv7bT1Xo7domDfxvN0PQLFrpII/0bG1xNgeyfdgkhIc6jrl2aLly0SjgrTUwbsUJTZT5zhLOiyjEvXxI27IOyxoG334QR7B6qlR14Ux/1amAIOG7D8eehYUsU4dFN4LdVQ4fXtxMvGwJvr8booz0YiClzS61OrOiGrckrzfNi9s8t5MeGkJpVYjzXrByWhvsqjtDh5zfQeAwZTP+E3xsW5+vp2quPFjC6LhJKhN8H3t680TU99exIFt9jMT2yFZXzkhZzy8It0QC6lJCe18k6B70idO+OXXTVkzvIxGBYEELeUHnn5txZ9EsRC/acKoUbPT7mdLmJDR8z45UWi4TSaBvHBVYqt/wEE07BJ+DmMRbQ0hqpwNaODNfbYnuQ2epLK6Kz1C114QcfhTQBOu608dIHmgVdlCG6wYLTYrYqWcDampA+VjAnB4e0EjgF6CwMl1RKajXxYJjOd+Euk4B5XsNaxOo5Sr9gKY5Tf35Et492vQ837DvxUSbu7u0XJHIqTqvjARBHuqAfOXoQJEEPt/1/FACNxVspIK5/0xLJeUKDO0P6IC+cBzTkPN4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(26005)(2906002)(6666004)(52116002)(6506007)(86362001)(6512007)(316002)(38100700002)(1076003)(8676002)(66946007)(38350700002)(4326008)(66476007)(66556008)(2616005)(8936002)(7416002)(41300700001)(83380400001)(186003)(5660300002)(478600001)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nkDqD3gTMuuLh4FKTVuiTOp1TI/PjBIx8B7aNWInXBVkGUuIuktxSaivMfhM?=
 =?us-ascii?Q?xH/56rhKBJ/i8OT78ag2fLsbAi3MpjAFMKkUt1jNDGZQmJhDqCrZGsdTd+Um?=
 =?us-ascii?Q?Ezm07jvlqQ1fIZD0XSsiafrN7nXtbELC+87qgHH/jVXfr9wu0u2bN8KYtouM?=
 =?us-ascii?Q?gDK32zNgFLITEvvzE47EG1ZWCox3hyw7Cm0a6LlpKegdo26WPzrftokFU57X?=
 =?us-ascii?Q?m+7tbh8ruV589muor66DKU+Ddwg3Yg54ouqdRKM+p1KrCIMCWumoE2eyA2a7?=
 =?us-ascii?Q?TQ2Qu34MCv8BLNTwSZWZFJAybftjO/SAatKA/CUahbRDfc9B15t/zArrE1zi?=
 =?us-ascii?Q?bsln/Bf7HUYzxfNWuomhYI2MFNTDnNm+IcxHr7oUBJJdt8cnIllgeZAgVQgQ?=
 =?us-ascii?Q?mEelpbIfasctMahgkTgRVgDoPRqrkjeKbysFbItYHjPr/+LAOwv9xc4yuYcF?=
 =?us-ascii?Q?b4BTBI6wsIojd5Bmd/LIg/l7MCXG7vR40HhJW6vKfNb5cIjwhgWfHOce+sUz?=
 =?us-ascii?Q?Es7OxYP3oHt0DrF/SWT0UbIaUJXsweNtDRCEoQz5yAINZD1mZvsBLIO1bVy/?=
 =?us-ascii?Q?+UypSQJEqAvx4LD3E22c1XCwEbEvNDJY4+jBra535gBiYeirdqG7fol8lJHW?=
 =?us-ascii?Q?jpZLvlYD+UM29Sx9zKLViM5JfS5RSvjWczA4vFA3o1cmzG7bzAR1/qIyrnqC?=
 =?us-ascii?Q?aVJoL15ll0UXfCAMsmU4VR+HAzfC269TC2jWD7X4bJRZXKz5aLp8umFugoxh?=
 =?us-ascii?Q?+V9bZroKvWggcplGkJhH+ze9aC54Qr92fjobXuY5w27VfIKQlivnTvyB12BJ?=
 =?us-ascii?Q?AQP687l6GpzNfKskrM1WASMdZpvXLijSZfx+pCHE/YKHQV0ydbAte77Xooxi?=
 =?us-ascii?Q?Hi+hYuOHhxe0iYF4udUgnkR9iXpZspF0LB1VyKQofyv10jPWnqYVT641A7so?=
 =?us-ascii?Q?O1uh/uJ9A+XnLqJ8PkG3qwI+Uj95ojAHs548rAf8S2FawR3u8ZFOalgPbE4W?=
 =?us-ascii?Q?HAWw44yatV6+59b5CDjIM02HDL0YUvhgitX5utKH3HhHVFoeKTckCW1w1GyT?=
 =?us-ascii?Q?XpvrSuw/nKSqKZ+MoaQJOMMH6N115phFkoRiCKjsgH6OwhdRm+HwtjdJC3IL?=
 =?us-ascii?Q?DP0XJV8dIwwvQjvVJpL68x9q6pwmS7hY/3rWLSgmZ+rdt6O4tt4jIL1jYudh?=
 =?us-ascii?Q?CC0rW3+7d8N10kBnRt5eBEsPOgV3qHi6CjJEzyW2YFmTkKI9DL10LlWuFU6H?=
 =?us-ascii?Q?UdUmK4PHR8KdVMZTrmCUN+a9OrZV+geQwTvM7BgXXl3HumG+x5D6OFUIp92l?=
 =?us-ascii?Q?A4UFdRvq06Q4loW9FeHJ1zqUiLOnvMiuicU9/t/WG1MjJItSswbs/VaD/OmM?=
 =?us-ascii?Q?0xsp5CrFo97U1OYGC64g99/6g8fH99JHSgi8qJcoBLFnNjQWtFM3fd4JYvcF?=
 =?us-ascii?Q?Kk2+sVj2QygYdfGf9mdyF/PBhVmsTNZoEcWUX6YmY2YbA7hUM0Rw4GUj/qw9?=
 =?us-ascii?Q?+H3qTmVQbJJb7cW2WoZAWPHk3YQzLiWTypgW2N6/n57tspF2x7OlmZtiACBq?=
 =?us-ascii?Q?PldZbZLsb+sDeJGhx5CJlFxQZyUnlHUXd3CJq+g70dAJQhthYLY1aACm63K2?=
 =?us-ascii?Q?S9bswZVCSbnxwM37uwQbunNV+ius3vRiv1nkSCAjTaX7QK2/mUnKLTQFKmFR?=
 =?us-ascii?Q?r38F9UE0d29fGZkT0Uv+FtNFp7cyrSge2/370pAcPcVh4p15SpYJzz4DW04E?=
 =?us-ascii?Q?btvB3Fr13Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afd9276-3f73-4655-b5d6-08da541630de
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:12:31.5710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/wT+5tBuGo5IT11YxZ8tSSHfF9mhK5sYgdaD5J8VwoYY792A7yfHBL1uwPYDF7pzijSCf5EnXRS+o+YHXvKow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7986
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP iomux pad BIT3 and BIT0 are reserved bits. Writing 1 to the
reserved bit will be ignored and reading will still return 0. Although
function not broken with reserved bits set, we should not set reserved
bits.

Peng Fan (13):
  arm64: dts: imx8mp-evk: correct mmc pad settings
  arm64: dts: imx8mp-evk: correct gpio-led pad settings
  arm64: dts: imx8mp-evk: correct vbus pad settings
  arm64: dts: imx8mp-evk: correct eqos pad settings
  arm64: dts: imx8mp-evk: correct vbus pad settings
  arm64: dts: imx8mp-evk: correct I2C5 pad settings
  arm64: dts: imx8mp-evk: correct I2C1 pad settings
  arm64: dts: imx8mp-evk: correct I2C3 pad settings
  arm64: dts: imx8mp-venice-gw74xx: correct pad settings
  arm64: dts: imx8mp-phyboard-pollux-rdk: correct uart pad settings
  arm64: dts: imx8mp-phyboard-pollux-rdk: correct eqos pad settings
  arm64: dts: imx8mp-phyboard-pollux-rdk: correct i2c2 & mmc settings
  arm64: dts: imx8mp-icore-mx8mp-edim2.2: correct pad settings

Sherry Sun (1):
  arm64: dts: imx8mp-evk: correct the uart2 pinctl value

 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |  88 ++++++-------
 .../freescale/imx8mp-icore-mx8mp-edimm2.2.dts |  40 +++---
 .../freescale/imx8mp-phyboard-pollux-rdk.dts  |  48 ++++----
 .../dts/freescale/imx8mp-venice-gw74xx.dts    | 116 +++++++++---------
 4 files changed, 146 insertions(+), 146 deletions(-)

-- 
2.25.1

