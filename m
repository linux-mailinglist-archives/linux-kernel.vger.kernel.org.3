Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B024AC018
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388775AbiBGNuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387480AbiBGNbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:31:12 -0500
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 05:31:11 PST
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781D0C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1644240669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SRzcbmFkT4wnl3d1E68QG7HVaQIfiXWN14bsAxmY1Pc=;
        b=aDvEjQovwYPen9gRG4P+VyYEPE8pJL9ySGcDjhUaPYCDOlPC0w5BXdi26yeYVw9/TXCD6h
        6h8Z+0YxhbV15qXj/8556CD4VsmONnGY4UCzVtO50DP04maiHZZb6k+k2t2cTx8trF7w0C
        NUsFTJ3mNhnrY/1riyJP2jagxcRyitg=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2057.outbound.protection.outlook.com [104.47.10.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-XSlHAMTcMGKNDwk3czQ7Pg-2; Mon, 07 Feb 2022 14:24:58 +0100
X-MC-Unique: XSlHAMTcMGKNDwk3czQ7Pg-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8SkB1jCSWGban1wslcWH859Ed2pQy7cjojmCloZesWi7SwGE2nTe8/Dmxnq4qrXxYKgDXxyLndQfpC9DTtwvg7A3d/kU2qJkq9mVe0GVqt5Yg0DurtzOWLhpj81gqwHqCucUtBSJHvN6znZWJ4qbDc7bRdiyB7j8nviYGUSrbAs8DUd+9roqxE9xeYmuAIkeAmM3gOHnfyleXNUo3u47RLOtJjd+TAgWD2pTU71oPbqpJ4O8WJaRnQGoXVyIscvMjcTKSDgyk/0Yw1Pb0LuRk5n59CrZj/tkBO+cFAQZpG/GAdx8lFh1rO295LrL6n7eCySZoE7OMN+kv90/q6Blg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rlz5d+5ddS9Wrq8U8rnnjewZndAV20knA68BBH0Tajc=;
 b=KUtb9cMBjFVyg4pJ73NalIVZRybBrDoLr7gGCsRrpP9vJ1qME/v0npg+OG+6ETYvyuSzl3Iulf5PbyArH0inQeq/G6e/y4b7F4PvjAjDk9d/pmyz7eR90xNuW9PFr5C2QIOIIhFb2oexwIuQjmzL6vTRzHeh+F9N2dRvIu068C0H8jrzw7wp+MozSJfTMxi2nJJN0IsHlxGtn4UpB1PvWphHBWo5GSg9s99506XW9GktOJ/B2/prZ5jml89mfGwhlWeCn4mhHwvDphlEyqPgduwNTNBJYthwpr+xBiPKQlElonMEZYvw3BD/eWL5KOa3F7vDuaDb4ENPxVGBjbmziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 13:24:57 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::e14a:7928:ecd6:f233]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::e14a:7928:ecd6:f233%4]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 13:24:56 +0000
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>, s32@nxp.com
CC:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>
Subject: [RFC PATCH 0/3] Add SCMI clk support for NXP S32G2
Date:   Mon,  7 Feb 2022 21:24:41 +0800
Message-ID: <20220207132444.3653-1-clin@suse.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM6PR01CA0070.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::47) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 414d6f17-81f0-44c7-f1fe-08d9ea3d3b9b
X-MS-TrafficTypeDiagnostic: PA4PR04MB9248:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB9248656CF2232F5F5AB1DAC2AD2C9@PA4PR04MB9248.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYtjZc8ej1u1DzPqUZHNfLio8/aC6teMcF5buH03VwCiGy5i7iph4bNTZUiUQG0zDZDav1STgZ1kTdxs2fjiYSImk8Bkfh8NSUFCvhUOpYL46bBuHBF+aqEwuOI94OG+CADy5vA2udrzttAzVuBCYacKAqCwmduGhtOq3w91rxoB9kyaWwfyJTEOQ9hG9g3NWiSUh6y1tDVheYI8BFw1VP4KXOKS/0DdR+G9X6aXU1usrbZ8Ha7qCViHWYNGzNEc+Y8MK5y/fyP3+c2X8hDgZeA7uyuBC026REYvYIygEQuf9byVAmpMvBnKoEYr6O0hJGNPQtZwIMTMoJuOG0rRc+rbqipJ8ZF8SFJbdq30tRxFflLgty/SOy25utssiSNNL1AF094WOYBjIfpK6EgN3ObSMEFRmR/PvUi/s8GnqeI0rIgkdTIVq+JGFOrH2Q9AiNydqvVPUsXZnrRTtVmLjywsMv2DW2o6F++29gfDMANhLdvgsMwx6GVTxZaA5DwOc3hQZwe89BlN9r4cxY557u9gI0DN12QV63EsWvbFzGRIMoqj3LoO9zRb4+H0FcGv0JDngkvXOF5VGGCpHWv9EHOLbmQ3qgH9+AQOXly05JCtQgAYGh34bbIHBeWb6BMVF2bRVjv7toDqMRIevGEMgesUEFB4G/oN9JnVnCFIeS1Aldu1V0tvKgp584/4RCowz4F/2ROFFv9y7tS/o8q2udUAwnuvGgBlKrklPxeQJ5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(66556008)(8936002)(66946007)(5660300002)(6512007)(66476007)(4326008)(6506007)(8676002)(966005)(83380400001)(6486002)(36756003)(2616005)(1076003)(26005)(86362001)(110136005)(2906002)(54906003)(508600001)(38100700002)(107886003)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3d2Y2CaxHu+3u5HrwjujXoipgMZEO93Uxh0jGAxS4Ksj7MuGJm0NMp+cW/13?=
 =?us-ascii?Q?/jl8ROqmbQ9MY7CqgVfWCxeYGp7X/4UT8eJSQlWRrCPXlbK0oK9CTPRSP4Ma?=
 =?us-ascii?Q?r9Kz4lzlBYQzgwtD/R4Eqx+Yh8yivsU4qhGO2V2viTS/2ErnrWTLBPqyIW4g?=
 =?us-ascii?Q?T43tMQzXH90Brf8lllHOSu3VqJ3aJlW+MBBCl1e7Xpc3asXlldOMSc+76cec?=
 =?us-ascii?Q?rpisYhTuMwhgn1OO22r6fNPdWvjCbkwQjLqkDkgAw2z+62VjZjaAFnCKaAeG?=
 =?us-ascii?Q?X+lBIH7xPnNzvtnKYjHvnry1Jk3Cy3TcJYHl/4i3IKZ9wMFA2YgHpiQjH5CE?=
 =?us-ascii?Q?ZXuIJmgB59OAkHv1u1zkxfqPscfRBtXglPP6qkG+nVPMfWVPhZf/xDNjYOwQ?=
 =?us-ascii?Q?jCJ65mzq+aN4bSpvwgEunVSqwiH/xe20tu1DNVnvxoZk8Fj+TDVa7XFzdzwQ?=
 =?us-ascii?Q?Z3qJ2PI6yDKoGrsHJtnro9fIO4bHwpIKa/HGls53sH3XQUwO1gmyfHDwBDym?=
 =?us-ascii?Q?LWZVOTktpNjFj2iEA9kzHze1+Wz3Mr8nhaOsLRqdBNGLRdAZM9kCE6lMh72U?=
 =?us-ascii?Q?Z+KyxKWSCPY82qnWhbeO8x4xbms6bhUX1l/cj3MnCfeqEmW2+CmKMlQdkNWM?=
 =?us-ascii?Q?9G4w0Y0DEbZwTNFTgsCe1gjlq0MMAMn2WhaaNEJgFd5M9N+bJScXdUyvjtOB?=
 =?us-ascii?Q?SFzPOJFxJ6Dzr4+WeQilmiDPKTwcwimg2Y5bRCqiHzf+GqyzRoasz9vHVtn5?=
 =?us-ascii?Q?Jv1UcVL2X1FYBewcywCQhyIeDUb4AeyYP3EAnn8j8duFhrMWT6Z9XJWX35+8?=
 =?us-ascii?Q?96hAGRH+lgMHi1ZL3nGsqIe+9AJXvcgUQmiy7fT5OEVBRZH9/4w2YU8sN/Bx?=
 =?us-ascii?Q?SJttWvKvLdOF3V1Aj8vhpIU1SiiMnRgy6KEzZAfhBFJr9Ki1YKxDwYB45pJc?=
 =?us-ascii?Q?ox+befcTR+Z7UGwDsZSLzlV4zyNiSsbvy3nMKctukFweuV6GPOCq3UZH2ufa?=
 =?us-ascii?Q?ZwNFDgctc5lszY+TA/VppKaIEXTLFEUCl6pZtNuGvIleEyjHZgFXZiu2rMe8?=
 =?us-ascii?Q?zOT4DhE3yJaJtWGsKcRyoLvUhYuQRnyKOrz1XQiqnXlivugFrLe9DDneTSgL?=
 =?us-ascii?Q?3WFmxhngaDGeynmm2NyrPKpl3jIDZnMLqpY1zQ/8nyh7Say5De0moPGZF/5j?=
 =?us-ascii?Q?H9Ns/+t5gZ3GboOJbRhDrIQcYbXoCvwqZDmwM9NtbGRRWot5PyeZkmA7QjOk?=
 =?us-ascii?Q?bsnCL0HGjEZwjG++Pjyx7eBVAllzERvyZVw/rK9GSIA/8cYOWsF9MZ6lhKC2?=
 =?us-ascii?Q?PVmU69MIeQdE7Sg2Q6dad0auxju+iIZ/jjwalwbD/QRZyPvCPYQg6wzm085M?=
 =?us-ascii?Q?H3m4TVQBnUXM09e0UrG4PnynHZjpubIerfvHN+wS8CbbfK5EO0LHKrM9u/+m?=
 =?us-ascii?Q?4wims6UeQ3aTn2yp7UVCfgksWcXzF1OsqLEGzHH29K7A9APW+AIkQa+w8DLl?=
 =?us-ascii?Q?vdIjpMi+PRNhE8vNpThmUnZTHwxG1mFhZ2/pIpMzEvb11FNAaM60hxhxv1nX?=
 =?us-ascii?Q?cIZNIyb1OHSISPdpwVE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414d6f17-81f0-44c7-f1fe-08d9ea3d3b9b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 13:24:56.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvzxCJaI+5Jc24iMKdHeHws90mociie9EcwsKczA+jEwbwQz6zfebYeME1F++rD3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Here I'd like to propose an upstream patchset to support clock management o=
f
NXP S32G2 platforms based on ARM-SCMI's clock protocol (0x14). The goal is =
to
have simple clock settings for enabling limited functions, such as MMC and
GMAC0. Most of codes are mainly refined/refactored/redistributed from NXP's
downstream codebase on CodeAurora[1] under the original license announcemen=
ts
and all SCMI clock IDs still match the implementations of NXP's downstream
TF-A[2].

For those downstream authors who implement the main/original ideas, please
forgive me that I only leave my name as "Signed-off-by" because I'm not sur=
e
if you might agree with these changes. Please feel free to let me know if y=
ou
don't mind to be added into the list.

I roughly verified this patchset with NXP downstream firmware blobs [major =
ver:
bsp30 & bsp31], such as TF-A[2] and U-Boot[3] (BL33) on CodeAurora.

Thanks for your patience.

Chester

[1]: https://source.codeaurora.org/external/autobsps32/linux/
[2]: https://source.codeaurora.org/external/autobsps32/arm-trusted-firmware=
/
[3]: https://source.codeaurora.org/external/autobsps32/u-boot/

Chester Lin (3):
  dt-bindings: clock: Add s32g2 clock binding
  arm64: dts: s32g2: add SCMI support
  arm64: dts: s32g2: add USDHC support

 arch/arm64/boot/dts/freescale/s32g2.dtsi      | 40 +++++++++++++++++++
 .../arm64/boot/dts/freescale/s32g274a-evb.dts |  4 ++
 .../boot/dts/freescale/s32g274a-rdb2.dts      |  4 ++
 include/dt-bindings/clock/s32g2-clock.h       | 28 +++++++++++++
 4 files changed, 76 insertions(+)
 create mode 100644 include/dt-bindings/clock/s32g2-clock.h

--=20
2.33.1

