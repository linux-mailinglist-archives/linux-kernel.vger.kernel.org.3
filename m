Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B86D50DBED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbiDYJFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiDYJFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:05:17 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2106.outbound.protection.outlook.com [40.107.117.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0012ED48;
        Mon, 25 Apr 2022 02:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDiMwC0ZVPM3zHg3zOLk5vj2+r+9+x86nogFiSVKi8I9A3sMqZPTh3480llAD9tfywkP6lKkEJIZl71mbCzZJl9rQA0HBZHVXUJ3z8im6HNsHd5J2dmhs/Z6GavulR5xKrmk4HQTY0T7V0a7raT3kzPb4+VZ43QivJGJ4cFlMEzjyIdCrZn6Msitl8GeuIOeGPDqef4AWORz2wUrsopdIkBmgqs1jE0Ma5Zhn62zDQKkxfQwEyKMKyboaIb9UlnhqUSpEuQ1i6K2dYNy43NC1FBz1cjuPXgz4L4zA5aOrv01a9p11g/J0M2Ok3wvKIP3wuwhnc+TKnqXYvy1da8ZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXJ2R+1S+CN6vbXltkxrj9WTORoeDUsCwjecuF8id+U=;
 b=Y90ZKJsJcjwUyixyL0ExHYJOn6kxNmtShuSFbkvOWyjMyspg6yRS6tNG5lXD56ZIikpffQD7XbJVTOXymiZr3I31Ly446WUnWCHnS3eL64iZq8BwSOW4Hi7bMzfUzG3pGME1NTVIU9yxvbT1AGEsmnH+EV9HM5rayPp+8NV0P9xHcpprDxO97tPR1DeAQyGQn13gBjnzpi6R4oc9zQDn/pwtwO0VmJyPif844HGXfnZc2I9kXfYODFYADUG3z3Ea5ajF1lqEBua0qnKIiPNHxZrODLIMrU3HVz3hgRSzs0LBQKhSi24Nft8WiX7IcO7QQSubORMxwjQ2Jhx+/EhkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXJ2R+1S+CN6vbXltkxrj9WTORoeDUsCwjecuF8id+U=;
 b=lxjAzWnzjqJ8F+83drm/K/P4tt89ipJ/i8C/+BkAc2Y5rHQxO07rNTIR8iNIzKVAHhmQg5JWf21IjieInOnJh8Fai/M9uLyDxokqp5fslxxyWZwmARuEUKzfJgTbmYzeiNwIzrp9qZ/4OvmEEhdsVa0fyNQut6g1djHOrUvYzSyiuQca+Mc6SKII98KTYAKls+vWsN9Qnv0MWpSx/kfs3CGYK17QjZ6MZBaB5luglEZJheDgKJ+tdlnFFDO0yvGjSFupTBvb83Vs4GkLo602yqREX2SHVNBRVqMIwCvLSnhvRn0lebaUQuNC2yGBb/fsUCssUsDJYyaUTGNTHt6sZQ==
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by TY2PR06MB3358.apcprd06.prod.outlook.com (2603:1096:404:fc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.19; Mon, 25 Apr
 2022 09:00:56 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::e13d:9bd4:cce0:9da2]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::e13d:9bd4:cce0:9da2%7]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 09:00:56 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v2 0/3] Add ASPEED AST2600 I2C new controller driver
Thread-Topic: [PATCH v2 0/3] Add ASPEED AST2600 I2C new controller driver
Thread-Index: AQHYTx+2HQAjy2eiv02nfnq/JNwUxKz4DOzQ
Date:   Mon, 25 Apr 2022 09:00:38 +0000
Deferred-Delivery: Mon, 25 Apr 2022 09:00:00 +0000
Message-ID: <HK0PR06MB33809183FDC48BAC994CB20FF2F89@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20220413101735.27678-1-ryan_chen@aspeedtech.com>
In-Reply-To: <20220413101735.27678-1-ryan_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09262a30-0524-445b-7542-08da269a1bfd
x-ms-traffictypediagnostic: TY2PR06MB3358:EE_
x-microsoft-antispam-prvs: <TY2PR06MB3358010408AFBC25832A25CAF2F89@TY2PR06MB3358.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dMAOBFR+Ee0+YgVL89Id7AjKOITwxfYAnczevrDQGsjsbdrNPu3xVOby6qiDZQiH1GJPw0lC/atDRyYjlVo0sMFfa6bcNrJORxN3nMEAjqjBdTA3J75AwEeBQJSrIXC3HowWsMqZrRlG29PHTDmnSs2IOJ/a7sgYqvxqglfxH4jlgfE+DnYD8RI28OxwU/OX+Q+5hjkUlxYyZTVuvZXqn4Dk8+OeJbsRa7SZBzsYLP1w7qeQhP5WNaSF7szQX3K5JRtsw1GiSgWxyVcZJ/kSe3A++Uje7wH1bFKHLk9UumMMGpUC82HHlpYjgOeNkZATJQYJ6/WSIHqVFLBGf2z/Jyo7nCt9RtBGqZGqf8cMmUBKu+Vw3cSU1+blFtpgLcsysMBmwTZsIV+Rp2VJTJ14a70xS2Gci+zhPTNYA+HVtwcwDoGot4UmZIw+ZYLJEh9nwhJCq4LP/JxdAPvPW4aGXPVmqb3LGiRMPQZ0XM98bgkWpDXX2kzLIV0NXI3IbkazjtEZRHAWa/BIu7cgewtYwjwnGn/0ZtAb+OR8h2i4GdIAeVv/H8n35QrhuP5d9rmvIv8Pa8mi5P3XZMb6sZlBtdCSogXZn9hlzWIFT7FvR9VBhLBEGUYSGXQOLXjgmq6VWouSRxViVxmkrOgNnr5hFfwnMOelW11EIXvYCRd3CPiHBOfqY8Afl7dpMq9bvYfmnUE8VR2WqCuM1fNoLNktXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39840400004)(366004)(376002)(396003)(346002)(136003)(52536014)(4326008)(8936002)(5660300002)(66946007)(8676002)(86362001)(122000001)(508600001)(2906002)(38070700005)(38100700002)(110136005)(66476007)(83380400001)(66556008)(64756008)(66446008)(107886003)(316002)(186003)(76116006)(71200400001)(26005)(53546011)(6506007)(33656002)(7696005)(6666004)(9686003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g0sV3/hvnAmuEOHGrywJlh0Icz4iK7kLiI8u/QoaHdMOU9VVPmZ59bgzRl+I?=
 =?us-ascii?Q?5yM7fbj/iQCBBiiA6S/YbZJZem3CLS8fW9yfSJ2Ppe21OLaEbVA+5ViLBI1x?=
 =?us-ascii?Q?8x4Ss4bw4+2qvEtqtiObhnINNs2L6BOEpHt09hC/IM/vgKeFcgRkxHdEKwOa?=
 =?us-ascii?Q?yzyhUA5B/ogCMWWCsW+qK3GJGHYP0U8SpuNQNDyMRhKDmsPXxVTinkU36P9E?=
 =?us-ascii?Q?d/ZNOIP0R73sNP+FvFmSSwCyGQz9U2pPcV8b/w4kUc1BX+Mz1e55hcqFiqBO?=
 =?us-ascii?Q?hiA1VKUP0Rg0xQGwbmL0W+Vt0F6FlQZT3UlZuA0DsoNyePLCr4UscNhElJfg?=
 =?us-ascii?Q?969JOybAck3XxQfKFB2XkBNggMzgyWdQayw5n5pQjcfiHBFL2nZ5UCLvs0Hd?=
 =?us-ascii?Q?V1o0nHXycwiGP3xJ0h2UFDcky6gq5au0X1SI6kDLp64+GD7XraxfpjB5P0nV?=
 =?us-ascii?Q?gZDlLmmlOEg5vzNKPp/+A9+s0UXJcZkFCV/mKVr9lW4h+OyGRzum98EY8chN?=
 =?us-ascii?Q?nFLgV6qqJFndCL35FMLn2hDMf5leB02PrdLJVefJq8Oze4zIf1I7+Rm6/NpG?=
 =?us-ascii?Q?wEJQjn94b0jcxMRK6iOiurpxmkFzIZgMPVgssPeYwq6V/UlpTl14+Vp7RlHB?=
 =?us-ascii?Q?ObzjRyqzXu1CwjPJTgDJHIVtzVhQ9mPP8/FRBiqgVpxTMaVOSzuf8ooydNEf?=
 =?us-ascii?Q?vYhHJHXhTZRC8Uo1vQmkPnAvAMeMbH9cGlXqCedYiqIRuAghHx3mv8q/aTUW?=
 =?us-ascii?Q?zVoPHV0MA2pl2cplVgzVReCYtoISM+87f300p6RM0jfyJBHAfoqm3cutwLLk?=
 =?us-ascii?Q?1W4ffmySgN58eagY6oGMebuGbN3X+e8uyxsY9XmFqnjWf6atsGHapg8f//w9?=
 =?us-ascii?Q?lV5vtii1ZCAEz4ZVwNm/OgB93TJQvNR2zFYArOs8Zs4BQG1gdR3wMRwHqIAK?=
 =?us-ascii?Q?VnpQaRmk1/EN4Pf6vW7Ysc+c5rTZZ0nC+vAiC90ZbUUUi59/lQT4gCwn2Kqf?=
 =?us-ascii?Q?MFLImtMqjfkK53yqrvY6g/IvagQxj6XTvWqr1onabWQR9kaTh06a2/dx1cMS?=
 =?us-ascii?Q?T6L4XttN+OoDGfcWvLSii6pC5kBPQwXh6Re+fIaaX5m6qkwXQkOp7XFc4wvN?=
 =?us-ascii?Q?zq4mKLYH0DHJR6wU0pEzyJipWRenceRJAyXcacZN7ufGf/IHG7apzQVbOcmv?=
 =?us-ascii?Q?odzODUt0yCGnZWhmqsBvYx0ZEZwFgOPiXENJc5fp+uMv9h0sDYIxKBcuG/hC?=
 =?us-ascii?Q?0doJ7UlOf4vibSnbr3t1Qn4nLvMbwIADjwZGII6b5XsW25fJUylRnKcJGfSs?=
 =?us-ascii?Q?IznqNjO+LowBKZAdFoQ+pG4wHyWPdXMqlRYRbXNrvQzXrBasueQCYWJmhYQq?=
 =?us-ascii?Q?x3kIu9EX59pQFHGS+LdpOpL/OhtJrnONQ9NqdDnNlay4IhoSB/cTu8ySEtUI?=
 =?us-ascii?Q?04Zrsc3HKn3mnZBJfnh3zwdtCJ3UmBjIKwySTXXeDg5nd4ZG+38QYXCoqOQZ?=
 =?us-ascii?Q?K13j/uVRnzr2xO8pxKMv7+fQ7HDO/7eJ1nRx5tbkqHtqSQ3AL7MvgeSjVfJw?=
 =?us-ascii?Q?bWM+ZJPMm72pY8ml7MStZLrZqWXwW+cneOOa67QI9AtgwrZ9PM9LwnUg4GtN?=
 =?us-ascii?Q?iOb/bLgRIe3DW2rkGdKL3nsu6XYbm2Eh4agdQP0JxOydhDnoXFnO1cuTBATy?=
 =?us-ascii?Q?E1lUx6QvuQ606wliZP9LckKt7ZjbIBPBDoIBl0HRHfYL+fQV7K1mLT5+wQIb?=
 =?us-ascii?Q?W+ndez063vDm7ztqJzzP5JqVD5jq6Xw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09262a30-0524-445b-7542-08da269a1bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 09:00:56.2136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jA677BsNs13TbdzmtLDJJgRRuC4H1r0xET5UiaHCOinDpA7r2T7YMMNJiM5UsOYFkqRCCK7qrFwwmEbf6GjSRZNwlZMVOK0UDASdYXSKp2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB3358
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joel, Andrew,
	Will you have available review this patch series?

Ryan

> -----Original Message-----
> From: Ryan Chen <ryan_chen@aspeedtech.com>
> Sent: Wednesday, April 13, 2022 6:18 PM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; Michael Turquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; Joel Stanley
> <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>;
> linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: BMC-SW <BMC-SW@aspeedtech.com>
> Subject: [PATCH v2 0/3] Add ASPEED AST2600 I2C new controller driver
>=20
> This series add AST2600 i2c new register set driver. The i2c new register=
 set
> have new clock divider option for more flexiable generation.
> And also have separate i2c master and slave register set for control.
>=20
> v2:
> -add i2c global ymal file commit
> -rename file name from new to ast2600.
>  aspeed-i2c-new-global.c -> i2c-ast2600-global.c  aspeed-i2c-new-global.h=
 ->
> i2c-ast2600-global.h  i2c-new-aspeed.c -> i2c-ast2600.c -rename all drive=
r
> function name to ast2600
>=20
> ryan_chen (3):
>   dt-bindings: i2c-ast2600: Add bindings for AST2600 i2C global register
>     controller
>   dt-bindings: i2c-ast2600: Add bindings for AST2600 i2C driver
>   i2c:aspeed:support ast2600 i2c new register mode driver
>=20
>  .../i2c/aspeed,i2c-ast2600-global.ymal        |   44 +
>  .../bindings/i2c/aspeed,i2c-ast2600.ymal      |   78 +
>  drivers/i2c/busses/Kconfig                    |   11 +
>  drivers/i2c/busses/Makefile                   |    1 +
>  drivers/i2c/busses/i2c-ast2600-global.c       |   94 +
>  drivers/i2c/busses/i2c-ast2600-global.h       |   19 +
>  drivers/i2c/busses/i2c-ast2600.c              | 1706 +++++++++++++++++
>  7 files changed, 1953 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.ymal
>  create mode 100644
> Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.ymal
>  create mode 100644 drivers/i2c/busses/i2c-ast2600-global.c
>  create mode 100644 drivers/i2c/busses/i2c-ast2600-global.h
>  create mode 100644 drivers/i2c/busses/i2c-ast2600.c
>=20
> --
> 2.17.1

