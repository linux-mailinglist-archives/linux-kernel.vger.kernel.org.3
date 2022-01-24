Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E652497A71
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbiAXIl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:41:57 -0500
Received: from mail-zr0che01on2117.outbound.protection.outlook.com ([40.107.24.117]:6113
        "EHLO CHE01-ZR0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236237AbiAXIlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:41:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/iR+6MNYd9qeJ/bgfz9AiTMS6cl/VTVCkXkk6AwQyJfMZmE58llwqo6/Mx5jceSqAHAX98zVv8DPbovRl3Bstn1uXAjN/yIf//++uBYFUXPNNR/VvamKY+BEW3OPVYAToyH4lSvNHyBTqKN95bQoy19nJvUKz1iMor1IupvVdIXKDLAmRvsHm1JDk59JlFpaDszIrG5sQmB0pXG3phmJh4Kok2u0T9jREr7gsRz5qBzia6WxA7inOvTAe5S/vcDAPiBrEtf3a8jMo66Isl6wwekfXSTcy6EtF5iBSo1cy8sAixZ0ddZ8XkO8mf0rTD52fDvlXBOYmzkHLywQ3FjRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+brnyShBsbzunr1LWcbuvHz434XJg7ypU5tTZTbFNy4=;
 b=I9X5rjLtl2NQgrkNU249a+kvN+Df0YpNEDcC99RJ3C1Sh04HIXGzp7wqYDriR9RAvoikFIz68i0z+ChMAPT0n8oFGwj1MCFIteVi9oqRWk4deHEyG9ZwppkrVdgRCBLDx+fk7PhXqk20nb5IpBibv3ZqOv2LNpDcaXpT8UDFiBOalcYCoVC1Ho0yWtQXqqffB7gXMmhcEi3TNHKxr9GuozwFEebooA0daGvw0jJr3zg6c+SV3aq8pl6zOLy9ZT8UTsXF/leQBxtF11hXE7zVhp6xeyMog31/hqopZodbhS1s0i0FVw2HjKo/K6yQ1dDKDcPWO9G7J6mvEMYcmUxPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+brnyShBsbzunr1LWcbuvHz434XJg7ypU5tTZTbFNy4=;
 b=rOSLKyNwWIb2GDrL1dapbFhhK+See4RmNetd2n3EYoxL5wPID9IdcZoohmuPLeRAqvEadQV4Ggo4Hi2AIh2pNvg9u+cOhg8oypgJDrAtIMs9Q/NAw3HtI/6RwknDQBOhhv3/rCB5beXp2hCL3LBh8yBbcDasYOmIIx1vWy2M/ww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by GV0P278MB0735.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:52::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 08:41:52 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d837:7398:e400:25f0]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d837:7398:e400:25f0%2]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 08:41:52 +0000
Date:   Mon, 24 Jan 2022 09:41:51 +0100
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Dong Aisheng <dongas86@gmail.com>,
        Chen Wandun <chenwandun@huawei.com>, akpm@linux-foundation.org,
        guillaume.tucker@collabora.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mm/page_isolation: unset migratetype directly
 for non Buddy page"
Message-ID: <20220124084151.GA95197@francesco-nb.int.toradex.com>
References: <20220117142712.3967624-1-chenwandun@huawei.com>
 <CAA+hA=Rg=uRb_sVvSr4P=rbfbp5MTBmkGJ4pdsd-6wMRPeK39g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+hA=Rg=uRb_sVvSr4P=rbfbp5MTBmkGJ4pdsd-6wMRPeK39g@mail.gmail.com>
X-ClientProxiedBy: GV0P278CA0062.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::13) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faeb0768-56e6-46b3-b5b9-08d9df155eb9
X-MS-TrafficTypeDiagnostic: GV0P278MB0735:EE_
X-Microsoft-Antispam-PRVS: <GV0P278MB0735B416A6402876AD33618DE25E9@GV0P278MB0735.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oi4uevvbYuXnIoTUMnA7jJIQrgn9xSB+ndd8vnXD2HfTnZYTH6TFLv5sMhsUPVwgwxjP/cPsSEx6DVUWLQoyFXjrinHTdP6XuU8bU+01wrXWE8kf6/Pw51ZXIFPHUrIRzgQX8imfF2HtI4lgKaMHRgyEGlwuPd/dNSA4dHSYGCBrVsWoYt7f+d5WEW7FyCiV4H4SPmnIqDMBnTN6nQBZ7L5sGJwAh6jFh280dHuoOTQlvvaUnjixdADSZo+moeGpzK6oqEFjH45XZVFfgFRNJU8yaieT562gh5vfNROoIpDkBrB+wMbVMY9dlVBl98n2d7zaS9AGa/CJW/DdvpmwC3YSWIkD3vE1AFdE0to5ezx/NNWaoOgPmxMCNpsqCum0mZmAqAv7NI0X8wLdPLb6pYSljI/1IJZbDzSbWqupRFmrdrRM+z+dQ60gCOD82KPxaasMUJMSB53li/R/l9wnLfWe1yIqlGXebYdO8afLIqZZ6t4UeJfI7MgSnK4vNg9VkrlMuOeYxXLhMz4k34K+tYQRTpA6VrFdEZkFjmF4lqPPvoErGbj0qF5CcMFmCULeIZFMsteVH0EmcbNxxOvWwRNqgOYmGG4AthGEOl3zdgdlW7rLwRrg6+30+PBU2q3ZSaWl+qTKDMXp4OX2ZWLIOJiePncTRyGwgFJ+mbbgq8AQqNtiEZuS9pMUuveb+hCuHIuAc9gqN2FdYatxZ1E88g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39840400004)(66556008)(8676002)(66946007)(316002)(110136005)(6512007)(83380400001)(4326008)(33656002)(53546011)(6506007)(2906002)(8936002)(1076003)(4744005)(66476007)(52116002)(508600001)(44832011)(6486002)(5660300002)(38100700002)(26005)(38350700002)(186003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?twzTSbqdJqI8i3otBtCCLRaAbAvcww38SNXy1XJEr/bZIaYa5Ow+kmn3FhP6?=
 =?us-ascii?Q?iRfOxIUDRl6OVrzcJQcqByCde44a88dnFBTRskSzQd39w/C+AZHVzZlOL0eq?=
 =?us-ascii?Q?i2zZxen3OWkjczZL0RnS3EfFa93sSdFbizub5T8zddvucYoDSl0tlsO2qCuJ?=
 =?us-ascii?Q?OOOJEr26cF9TBjTo58ny4U568D0ASfdX5MblYXmd/RBJbI5J6QOxazEt4BQp?=
 =?us-ascii?Q?1q49vl2qhN1kW85oMm7I9e9A2qU+ltL/VauH1VXy2jbuBr3AvRsP1GrTR7gi?=
 =?us-ascii?Q?+AX4sTDbkYDq+idCMTp+0GezafHL9gRPgaVtwXVs/FgufET4VQdBaDMOtzeA?=
 =?us-ascii?Q?f3IBh9+UKJGC/HlXPMhiuO97Ugx58Umed4E4po0V8xX+Vbkb5Rjp8kWcfCTz?=
 =?us-ascii?Q?6ADjFbzLxuQwbfw8O89c+2CpZj+3JH+ddLvKHhihGVUP9fvpuWspphj3rHTz?=
 =?us-ascii?Q?JQe32xoR3M8kJh5G+QuSw0I4Q5ypAELu3RIRtCACh05CYwPUgf0Ne1QkX6Ep?=
 =?us-ascii?Q?LqXVvUQ410sqWn5RMe4gnby2JMjHPGzZ5VjqQrjAuTmerfc4+LUDX8xeCi5g?=
 =?us-ascii?Q?3XXnA/ZjPhYeM7OE8BLk5GdMpze4mKUQW+tm+smuCVrjZfbKZqQ+f6pCp4oT?=
 =?us-ascii?Q?owHwFA/qXYOWkASm7Lm/KaNXm8sd+ArrUkG9/d5jEU57K0MfLg3Y95I7xUcy?=
 =?us-ascii?Q?q0xD5RfhXOq5DUuduVt820i2A2YEPIFjmAKitwW4p8lqA+Wz2k22VXgOMyoX?=
 =?us-ascii?Q?dhphwPXUJN8H7+uQuYv956M7AemnkY+lMzXvinMl732GXvNUYGY1U4D8KI3Y?=
 =?us-ascii?Q?Hl8L+GmJy8cR2LZ99DS6q1cgxR9g0sAuvtKgZivaH1P2QjrmZWTod02r62G7?=
 =?us-ascii?Q?8QQ0LQAN+QyxOCNgg81Ys0qtXy9OobBaR8ImElhmH4zfSFOrTlzPhDZw7SvW?=
 =?us-ascii?Q?BuW+Ua7OZWA8VGOMCMFt7ZWIn8EnaiOUhEKsS+PjBzBNWRK9jF3yfOicgrvP?=
 =?us-ascii?Q?WBYKNPvjv8kW9M9l2c4cr6RKetXhfBN+KGDjzNZjQ1EXhA9M2DaUj9psQyJa?=
 =?us-ascii?Q?kIxTukSelDeokDUSHPv8MuCa23KSrODeWZHIe/0H1sgrjAJQxhoqsPu/rMvz?=
 =?us-ascii?Q?NNK7kuZQTcd2TqXGdbS+FmVOh8mWiuG2uk8DFnYs6ZwEix9IUi0r3ck3AasR?=
 =?us-ascii?Q?8t0dkRvd+tASFWJwnvzTXr9eSRfW3XlFfqmxRYEgfcxJFruNh4q7TwZXSiex?=
 =?us-ascii?Q?aZjeR748MVJhy0bsu38xH6xee8zWRXds5JeNgp1lfqyP7X/MRqK+0cpksknx?=
 =?us-ascii?Q?Tr8mluXVkwnf7AgkK2t0Ba0/gXB27VcSjVgc9lROPd92+jXCDfQbzc2+0ynX?=
 =?us-ascii?Q?dPk7x0AP1Vwmrby/YCuMh8JGFZtBgKi2xz3B7h4ko/wBUIjsurmnkH3sM2Q8?=
 =?us-ascii?Q?eMLmxC1wU8DeF9p4/a+FSAySEtcE7KHb8ogBFGxERu5vmqTBHEjZi2DWmO6c?=
 =?us-ascii?Q?9rCbXPD8BVoSLSEmEmokS2U7X97Az5kiA0hVENCltwkSey6+scz4go2gmumk?=
 =?us-ascii?Q?FDSbe4RqYzcM0lPiHOPWDIbtblr/D71RecChgv5G5KNsj5cPExbzw68jS6e4?=
 =?us-ascii?Q?5UGQ9FWCuR83F48eFLW9OSMHqqTzcA1dg958+n8qvYuUO6gzwz2Mj75KjafV?=
 =?us-ascii?Q?LpnZig=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faeb0768-56e6-46b3-b5b9-08d9df155eb9
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 08:41:52.7237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9qW2pvKYaDnsWPLvSByuGU3l8EeiNAU/l/8Dqc3T/V3DT6CSJlJLgX3aEo5xsVfNPzBzpmdqrhw+owrw9GQ6+Brf6XsqzgGkweRrJFGMik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0735
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 09:50:42PM +0800, Dong Aisheng wrote:
> On Mon, Jan 17, 2022 at 10:12 PM Chen Wandun <chenwandun@huawei.com> wrote:
> >
> > This reverts commit 075782149abff45ee22f27315eced44d02b96779.
> >
> > commit 075782149abf ("mm/page_isolation: unset migratetype directly for
> > non Buddy page") will result memory that should in buddy disappear by
> > mistake. move_freepages_block move all pages in pageblock instead of
> > pages indicated by input parameter, so if input pages is not in buddy
> > but other pages in pageblock is in buddy, it will result in page out of
> > control.
> >
> > Reported-by: "kernelci.org bot" <bot@kernelci.org>
> > Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> 
> The original patch broke imx6ul evk booting up.
> Tested-by: Dong Aisheng <aisheng.dong@nxp.com>

Same issue present on imx7.
Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>

