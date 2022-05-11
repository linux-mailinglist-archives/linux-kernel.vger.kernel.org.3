Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0C6523839
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344395AbiEKQK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344393AbiEKQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:10:17 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30123.outbound.protection.outlook.com [40.107.3.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AED2375EA;
        Wed, 11 May 2022 09:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQUvvo/tKRxtVrb9m9yiBnjpQrln4x/3EGXt3/BYP+bR4H9sH2guvTtTByoWGQQ6RjqQfehh3+oXvVegQl71IMeRPWXqAHDTLW4PLF5chumZ4IasbOyPaTtWw3RCjKJLOpPLi5xrFaVZcVuJ0fkJad8CgsGbw9bj1FnF293y+MP5bTrJ92HcClabgyE8k683b25cfzZOCe3SHxyH0tBWcDFfkTl3LWgjwwZbXKjz3mqRtnRDMo8mPDjmGfO4YIoQWONmA9y8Dn4wE23KH3PGcEVX9AHa1G/pkYseHgv4H3LoRZtOQrnjn9cN/czmOhHM5A8pDr3gn5qT2ZvUzskJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZkX9psjr8lbrk1WkOwbmhnFKxrKrooGhqbQwJGUExM=;
 b=nMyDX5X4Vze8ypaviw09MePvGaQg6BVzL/7oRsZKR7L6Zodou0W4UeOBut2PLaoz9b8tyzxtAOhhvD4qlJWwxseAXTvQw9FHE/jTybtLgHCFa/EQZYwgyKf+JNDYN+33rfsOvkKqdofaOV2tAKjPsKRSHujccHWePN4N3WLbekvgYhoPuCEYlMbUcdYfBDyN4GCAKw1mNAG7XH5Gs9be9xRtst3fz3XheWLu0SRxUAxZSshC9o5Ud7qcPsoSKbtvc0Gwb5El+n4QGwMZeazqxnRFMr4pFWxoizWJEI9TEq89Wcps/EuSczOTwD/nnVilxwfKlRz74FZftGQYt0Ma7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZkX9psjr8lbrk1WkOwbmhnFKxrKrooGhqbQwJGUExM=;
 b=H2k0ju5e+VZn/aBh5FFGuMtzxbpnukLjMmvahPv+UXT4bEx+D55L+sdSxomKmrIpgCtY0uRwS0Uo9RoZ7aAuiROVW65sizyQBlEzbzUmoi3JQYTO+i5lN9JTMA8tMgXIxpN+GJgWjC/eQzC+Rk0iW9WbtmaeB8y54OwVaYcm/dU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by VI1P190MB0510.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:30::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 16:10:06 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::8023:4d78:c3d3:424b]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::8023:4d78:c3d3:424b%7]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 16:10:06 +0000
Date:   Wed, 11 May 2022 19:10:03 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     catalin.marinas@arm.com, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v5 1/2] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Message-ID: <20220511161003.GE10145@plvision.eu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504044624.951841-1-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BE0P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::10) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f4211a7-d98c-43cc-b333-08da3368b6ad
X-MS-TrafficTypeDiagnostic: VI1P190MB0510:EE_
X-Microsoft-Antispam-PRVS: <VI1P190MB0510A4FB55FE57D3964D4A3095C89@VI1P190MB0510.EURP190.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ehPG7R1gR7n/JSt07bCsqIa/W2owQzTBjenEugUsbc3COfBj9ScPwmiK4W13cojXXmOr/PJy3IVV99la+omzncjGVVnvoMAHXkBJwBxGT4L7ZCzfv1Y7AtDmXDmNuTvo57CPd+yltv1B+NOfO4WLZxVj8c4edbaR66gg7FUeq7esWKhHKihyn/wUulsZeOD8BZB6FQyIgtMLb3haNijMFfk6pWGbmikWEHnz+8QBFSazMapsWfA6piz2llfpdOgzkKl1u7AabXz8KGCuxU8Lei4unRkjG07QWf0c2irOai3IF+CcJtLCtRx9l2D108UuZFduQO6OQ/oP57psCGetMnLtZsJNo9xutBeuX2RBkv4dCgVwtKLpGr3j0oA3mMKhDaQYRh21UObtsGu1k+rgHta0Qcav3rulYSOIhRFYW2948VnJw2ARmnZmLZm0VyFlAXeJ0ztXqbGYgnyGwdnSuqSE1ATZhoW8JQS5QaV4JRttZFijbtJZVkhB8BdNeazwsKgXrQmRXirjuP+d1b2CAo2uFH2Ya31fl0FwCkTjuP6bSfft2OVhLas/FXWUomY6aeDLSr5sFf2SemXiLEmZcqCQeKHICPD66EKvHHNtIz0DrmG2V07uCYhdjmekK+lPIlg2JqcVhRzyp655xliZv22jJTX256CrEy97ic+lfhj6bE0ZKBAn99fxTDMdnlOtSThQUn4OJCQOyT3dri4DYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(366004)(136003)(376002)(39830400003)(396003)(2906002)(508600001)(7416002)(5660300002)(6506007)(4744005)(186003)(86362001)(8936002)(52116002)(2616005)(1076003)(6486002)(36756003)(44832011)(66476007)(4326008)(26005)(33656002)(38100700002)(66946007)(54906003)(8676002)(66556008)(38350700002)(316002)(6512007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wzNBJOUtZG7qHm8fKYzXz0I4+s72jkkurnZzY4SglCOKZdLMy9io3oYNwgvT?=
 =?us-ascii?Q?Ex7BoHvU7ds96IyIE2rfk/XXglf+TR0/tCDW6agXIdTWRbQHH6nMoAyDDSwC?=
 =?us-ascii?Q?RTkxEOWeXqJOZhElLoVxDnzqiPtpFrxhM/+3WmDrXt8gCOuoOPJmIqdKSxb8?=
 =?us-ascii?Q?SiquOK3MW9kuqS55ctCAaXev3L6AWDkG1KkU2N/99p0U+DLl79uZOvNScVYh?=
 =?us-ascii?Q?J+ZmAY7leUd5jrKAx0OhWFyc477yEo8pIpWoznX7VXUmLJ7da3SiWgA22Ccw?=
 =?us-ascii?Q?zDXSWgZ1TRxySmObLGbkz1G6GUy81voXNpDWO2/lSK0HwipcPoJ6Lh4Rm1Xs?=
 =?us-ascii?Q?Wi2giEUDI1tTGhKppsU0hunY8PgxsldYRO0WMzD2M2gu5LOoye69Jg9OshE3?=
 =?us-ascii?Q?Y2x2/zAc6nmczGgrEl2+u4/7AdyHKltbogyvhVgx8ge+Zgb3QqDku+A1u0AB?=
 =?us-ascii?Q?N6+rCm0kFNG7k6gGG3+evdzBiN6H7YO6F2cvW8+XoKBDV7N9UBtGYBHRbQoF?=
 =?us-ascii?Q?I1p2VSM4pgN/dARkttdiUCthtJMJzzAlpIp3Wex6du/BdflKtTLxJR4iZAMO?=
 =?us-ascii?Q?XISlvS5Aio8lS2V7h4oweSMjDmCUbd6v7DZrCw+jwoHAoMO9b5Mj55iyxClH?=
 =?us-ascii?Q?PFYdEc8Qbd48du17SbEzTguo08sOEEsV+S/zUXMStmUjjR+8Xn1tgmauzg+O?=
 =?us-ascii?Q?xouOP3zgBcAGRYV50KyH2YdpqPNGzEcG8cpZCu9pK3IZ8pDePEgKOexVMUNx?=
 =?us-ascii?Q?syhwHmSjZdkyOY13C5zEssOvg+dRFQ79dYvtjxhqDXuL4gywZxIqSRgQyFbS?=
 =?us-ascii?Q?R3wWg8MMKQnh4LuRgsJQwxypt8uqiWLZATonYCj7dEO+3PWB4mcs7fv1ACAp?=
 =?us-ascii?Q?rM797/SGrwdKMDeTPu46tKGkU40T/BLnsCSluMCCCJ7oT6ui29y4V1uRuOoS?=
 =?us-ascii?Q?XuWc+bXHKCL9gSk37umT3ij0utENJS8m1XrsQYK5ywK7dy464lZse80KpoeK?=
 =?us-ascii?Q?06Sa6WK5iy6YNl2f7ICs/lREVZG3TuCaFuZXm2pX6En8AM/cxbR+A5wP8V32?=
 =?us-ascii?Q?Gz7b/9CZhUNAQxYdiK4HcllgaMxLUSVxARFgyFIR0XqiiatLA4Rl9CS0Dllc?=
 =?us-ascii?Q?Lvmpx/cTkqv2o1IQEioyrhoYxb7dcTXisD7tpnAwz3S+FX770YSPtu1FhN10?=
 =?us-ascii?Q?M52Vh4zdochqh14alBNkjlkoDjwd6Adj2tzp9B0XwcDb8WdD1XFhftLWKR6w?=
 =?us-ascii?Q?vrROEbxQ977KhvR4+iCeVw3n1yYp/6eL+LuGXkzAvgQmqtFBKSuavWZzYWn0?=
 =?us-ascii?Q?p6p1IzBbaP8/ak0s9VXP8e9dlZ1SjRe4IRpSl65pzFLTIZYC4hzYQ5ycOozt?=
 =?us-ascii?Q?Au/gRU/NV65uwtIcKVwgsp84Q69pBtHWdnxPHz1FJ6xtGHm/aMc1bmju8MXB?=
 =?us-ascii?Q?SAmK2Ljurvji/MzljMLmW3IWujz6w9Hcfb+HMSvEq6iKsqm+CeRoRcSW3rS6?=
 =?us-ascii?Q?JLFuE132nbAoZbte35vgNCaO4uK8ksoNZauhlK9NLHw2nJAvxkqUb3UkR03w?=
 =?us-ascii?Q?JJZmc/QUKGRRl2LCUlNL5hzbyPx7FgHosXCS4/BIN+mG73sUeFFzBM3ZmmxN?=
 =?us-ascii?Q?+PqKTb5Y+Gqvy3KIujI/o8pYz62pe/3gmOZoPU5Tom54m8sac/OlxGNnjR2g?=
 =?us-ascii?Q?2o2stV2ym1j/20zuURkLmoH3O571MztXh4Fsqno8y6ana2ypTPoZg++cSYYC?=
 =?us-ascii?Q?PhVtsklRlBBH4BYH+kPZ1m1ntLETrqs=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4211a7-d98c-43cc-b333-08da3368b6ad
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 16:10:06.2361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phnwrVsSVja53PPpU+wOv8laBtOOVbo/jEKtctkwHT8UeCDaHAgoN8H9jlGDYAcbxEQ38+bL8jQJl60iviNx7L+FHMl4z3bzSCwLsIb7WiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0510
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

> arch/arm64/boot/dts/marvell/Makefile          |   1 +
> .../boot/dts/marvell/armada-98dx2530.dtsi     | 310 ++++++++++++++++++
> arch/arm64/boot/dts/marvell/rd-ac5x.dts       |  90 +++++
> 3 files changed, 401 insertions(+)

Marvell is going to start the upstreaming of AC5X boards support, we have also patches with similar .dts(i) files
but with different naming:

    ac5.dtsi
    ac5_rd.dts
    ac5_db.dts
    ac5x_db.dts

What do you think about to use these naming scheme ?

Regards,
Vadym Kochan
