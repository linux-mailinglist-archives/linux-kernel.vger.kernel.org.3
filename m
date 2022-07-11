Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF3A56D356
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 05:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiGKDXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 23:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGKDXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:23:10 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2094.outbound.protection.outlook.com [40.107.255.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AF613F16;
        Sun, 10 Jul 2022 20:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3lCjLvjpWiMSIBaryvWgghx2tj1HuH9RY+rbJvvnfO6frp/q93pfr1A/7SAnFQeYwUExPu4FDWRBqqSAIJdKDV53ZA9XXdXstYSn36OBD0RQ2J3tuZHIV6xudMk7ThPC9qz1W54BocRcRhNdF9maw7tPF0929/X3/TZyRbc7cW/J8ME5kVY6JkAD4vZXM03ybf1LXFP3Bm92lVCf/DoVuU/9Xyrw7/W0FcQK2H/FkAuc6Q0A4jZ95Cc8u/uds2EvsdL7AqZ5ESJHVMZcn9IcsXXNMIVbpz9p1WSlFEC7vCBcqZnaLKan5JrXhWOPnMowMBVDWLqGfBrroyLGyu5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TA4ubcna6smt7qEbxeV3Y7IjisRktuN0oVKdVg9fkkY=;
 b=gdv2kTv5IufilUVkavnw3yZnrQRM59VgGz76a6rEdFjH0e8Dm2PmLug8fYB1pBHd9O8cxZv8YnAaEbxvUdWEWdm0wk/ELcLGDvQyYKFCJekBnXIGdF0Fa+oR4LEWm1e/GZ3KJo7SuCHZD4YhlB/skSTQ2W+959TihHF3lWRL3OD8qYqveLpRYiZloGmsID1s98DwA8jHhsrM4MUeL1lyRWFQl0NNLbayaNfV8zTpkFjHpu8bO1EtV6/xMxcYS9AuKLcxYa1oohF82sGZk7w8zWyXonMmd83PchB6K2RXvUVBT+xNpHG+Nw7uOa6bcAa+0MGw2rLMdhMxQxWhupCwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TA4ubcna6smt7qEbxeV3Y7IjisRktuN0oVKdVg9fkkY=;
 b=CPKFqknpv4fQRpOdooaCBc1RnLrpLgeEI0wImPKLvdPNmYkF19SS3U3egez1RJjL+GQWZofbtVmBn2kLfWBQV33USWkWhs9VHsNZqLZEjWBm6ruMktMrR4NIUxPJ6qzm2gFg/kkKpt/VOoL+JDnb8CHHiSeIF81YUtwBqW2KT5wGJIX+AJ/iqlnUutlUNdKxqtysygGg6dh36R4JIGvC5NUj7kOxwiAWifxXeROWHxuoCshuxk5yikfKC0r2MHJRyJ07rd4V5Lnhu+gPgVD9lUx3gcjznHKO1+2V7yD1jszv6zbS+Wownvtn0E1iinjfpQgRKzfIQvQ/MnYshWjr6g==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by SG2PR06MB3465.apcprd06.prod.outlook.com (2603:1096:4:a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 03:23:00 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::a08a:1668:efef:3a91]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::a08a:1668:efef:3a91%5]) with mapi id 15.20.5417.021; Mon, 11 Jul 2022
 03:23:00 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 0/5] Add Aspeed crypto driver for hardware acceleration
Thread-Topic: [PATCH v7 0/5] Add Aspeed crypto driver for hardware
 acceleration
Thread-Index: AQHYkBRM0+h651cfXkudxQ7A8WKvvK14iqRg
Date:   Mon, 11 Jul 2022 03:23:00 +0000
Message-ID: <HK0PR06MB3202AE39EF5F43E62F19337880879@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220705020936.1751771-1-neal_liu@aspeedtech.com>
In-Reply-To: <20220705020936.1751771-1-neal_liu@aspeedtech.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53365ce3-ec64-4c7a-80a3-08da62eca8b2
x-ms-traffictypediagnostic: SG2PR06MB3465:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SztYBndbxhqY+/yKT8GtAKomb6vcLqSmSbxpcjhPaE8AWwZvy+8kzvI+VrPe3tzRwUMADO3OG0Lb6eTRlxskBhZhlwJJcUmBxM7H/2D4VuwneZFxCFF5kLN9z+ioCanU8Gr53yEHQB+i+0fdnVujPgLFzyYIEIWqdRUvuVdQaQUW1pVVk4FDF6R7tlnQSkdNeryAOJs2v0fstmwKI1V7uJOz81m8TQfx4MzdLgLASzWSO2Z6lMgNsvuOkZI3Z473qRLBjlTxtgxEe0JVaoomPtzhaRoeNM8dq6xUgsd9lnpoOp051gKZcZ/dJc1S75xWRDzR7iVsQszCiprPx9XjPk3+7b2ol7SraFRHWxguuNgmAVXqU38Hj33N8kfhyDMIb9ShiWUxZEuxfPq/zDG9E737Q2vz+y6N3UGE9FkMTUJJ23TS29Y82q5ZNmV1F4HEYGAq13enBtQN3lazm0Wx178Za1/1dBPspL5keUEvvGnFS0HyE7a6/5afXjlU6aD1MOPvEPlZoo+4ocfHG2eGsOWslKQb6DO4iCgidQa8MHMOsBlANwLjwS2XEZJHYp9d9hlwNdApAPblzkl8lzjKqXuKlL0L+WTTkFx1CKn4PMOGJ6R1QmhIVawrB8nFOXW974Rf9ptKqildp4W7862lEtoyw/Mwu5bQCUj5qKfuWVvKihJM/YgSGKe/NbcGfU6g91CWufHl1X7gsZwdPiEdgmGi8DRSYfP0zM0eIkdtnZcwBsjNvGF1Yrjg5h93KzT0LcyEPPahRomVlTdnJU5aHL94DehgeBCnf+trT7I45vpXkhEuuB8oxdQHx/VLd30lZhnNORFznxyUASRSWvBMXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(136003)(39840400004)(396003)(9686003)(4326008)(8676002)(64756008)(66476007)(66556008)(66446008)(7696005)(2906002)(26005)(316002)(186003)(38070700005)(76116006)(83380400001)(66946007)(921005)(86362001)(7416002)(5660300002)(53546011)(122000001)(478600001)(55016003)(8936002)(52536014)(33656002)(38100700002)(41300700001)(54906003)(71200400001)(6636002)(110136005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QZM0P3QhxfwDCcSlEoslW4OwsCYE5ztcwagm/au4dqtsH6PAEvNQ3JOajJ8A?=
 =?us-ascii?Q?QSqM3C2ZwpN+FFHy+1A5saAlQ3a24z7UVRX0ltGeaAgvucJi2ZQyQKrFWDkV?=
 =?us-ascii?Q?ddS/0GZdaKLEKXdRXpjJzZ64jUPJP1GGYnh8PvTHZXt3bq9bO6/e0abiuPBx?=
 =?us-ascii?Q?Og5INP3wXTX7tmdRQ0QSTtutr9oeY8YI/AZ4f/59P637blOi/PU2qHaz64U6?=
 =?us-ascii?Q?GBnDBr5xGWg/FX+9DHVvuxRn9Xo4xPsN8YJtTod+0a74LCjgeTpl3FcoLvJB?=
 =?us-ascii?Q?IuDH9MC+Fwi4ANRow8IXx8mTXhr09KMxjBceNVoJQ0qzuhCC45ZQODnT1uvx?=
 =?us-ascii?Q?58gf605upEXBlg334zYXIz90NlUevI4LphUkMrhw5F/4Mvd1BFJfH8ijltla?=
 =?us-ascii?Q?4YZXuMF3m1BzGhHFbfTWQ4ac2X+DA4f2hLDn+wNRNg70SHHcOUXOcKJ6kAsC?=
 =?us-ascii?Q?nThdv1jitnB8ARMLyPiy2hJtts/p8UwpRn4RDDuSl69KMCGEDXgzKC+iIWya?=
 =?us-ascii?Q?7119TIZNL7GP9PjEaawWp/a/yOkD3bezCbz4FKhN9nfztvj3iqSw7YY3AStQ?=
 =?us-ascii?Q?qF8PaaTVwscO336F+6Di6J9d3iftyR80/nCKFfFR4EpsaESLFHdInb215Usl?=
 =?us-ascii?Q?3oGozlEo2S3X6gdVYcrG4z/PikJJK1dev+vAkF0p5VThiHbnsw4VvgXpjnU7?=
 =?us-ascii?Q?9vdp2RDXgr3kb+8oPvbgqm01Lqt934vSme1Ak9EM4dsYqbG2XeRp+L8TtVXD?=
 =?us-ascii?Q?b54w+A6IkT9GNGBeXUPQsBXdAnBPT4PL46g4l+0KW5QPYIYi4DpogP/tjDri?=
 =?us-ascii?Q?10mTFznFd8wtW16nFsryCBkg8GRyRYfkeo0j2pmq9EsFRvki5RCsYzFDRzDx?=
 =?us-ascii?Q?NHq7HWStwko/essIsJ0ckRTb5SIQ/YZIz7J3YgFEyFRiBv66HkiLO1BCeMbN?=
 =?us-ascii?Q?EjRzgZRiU4Kz14EEdZ7LXBNwUE1X7ZssLU6xPRYcDJTWd1YngTCctlB6UAEQ?=
 =?us-ascii?Q?JeU+QWJkAShSubbZBIaUDqmNcSgtniHbmimJXwaeC5OOQIz4Wyup4hQtosHm?=
 =?us-ascii?Q?1aSH3BfdFH2HZMF+7190zv4NJsQ3nM4sV1XziuXWe0ZZ1cOf2OtJiSrLd9ve?=
 =?us-ascii?Q?DOxzMiZQhLTfbXySWPddoRAVhXJHmIHKdZa7Hmmjy5bezIRHddtHV+B4sd+M?=
 =?us-ascii?Q?QnD+PqprfixGYp5Jfk1m/UNnpuFarQyL5EFWsVDozhoxG5OHlnyIQIYEujXm?=
 =?us-ascii?Q?7hklDokMLlD2iHIDDoKLgnJwWEoHXVH3fvzOSklSD1E4A4KL08B1loXLPVH6?=
 =?us-ascii?Q?9Nwy3sox/4z+2fZk8S3GYnDQduppeCaPWnsUUgP2OZksGrdL2WY+OStkPVvr?=
 =?us-ascii?Q?TkzsjeRGqqDlF1+jUYG4XYYJeE7ZXyBO7l6KqscQgYizY9rkWuaGpIYwefRi?=
 =?us-ascii?Q?dbWKGgVHGLKWrr3vU1Mx803Z3X5zgiE/Ilr412lhVBybq0GqzftLEivHQEEO?=
 =?us-ascii?Q?OaTKNMa93ZjQ1E8xYSP2Px3Dkn5YnxQHqt7Lt5PJgESKl7/MO/Yz5wKiHY7x?=
 =?us-ascii?Q?MmJhU8NWtC0X/jVAUI2sjpMBzGGMYOSdpSnHSPHF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53365ce3-ec64-4c7a-80a3-08da62eca8b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 03:23:00.8108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIUVZXA0QRl1Oe7x2RRiaXylcerlqaVA9TidPG0oBCuP8hgIcPAC+zxNyRzY+dj/bc1XuLDgSQYF+XEL+uHgww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3465
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Neal Liu <neal_liu@aspeedtech.com>
> Sent: Tuesday, July 5, 2022 10:10 AM
> To: Corentin Labbe <clabbe.montjoie@gmail.com>; Christophe JAILLET
> <christophe.jaillet@wanadoo.fr>; Randy Dunlap <rdunlap@infradead.org>;
> Herbert Xu <herbert@gondor.apana.org.au>; David S . Miller
> <davem@davemloft.net>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.=
au>;
> Andrew Jeffery <andrew@aj.id.au>; Dhananjay Phadke
> <dhphadke@microsoft.com>; Johnny Huang
> <johnny_huang@aspeedtech.com>
> Cc: linux-aspeed@lists.ozlabs.org; linux-crypto@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: [PATCH v7 0/5] Add Aspeed crypto driver for hardware acceleratio=
n

Gentle ping on these patch series, thanks.

> Aspeed Hash and Crypto Engine (HACE) is designed to accelerate the
> throughput of hash data digest, encryption and decryption.
>=20
> These patches aim to add Aspeed hash & crypto driver support.
> The hash & crypto driver also pass the run-time self tests that take plac=
e at
> algorithm registration.
>=20
> The patch series are tested on both AST2500 & AST2600 evaluation boards.
>=20
> Tested-by below configs:
> - CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> - CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=3Dy
> - CONFIG_DMA_API_DEBUG=3Dy
> - CONFIG_DMA_API_DEBUG_SG=3Dy
> - CONFIG_CPU_BIG_ENDIAN=3Dy
>=20
> Change since v6:
> - Refine debug print.
> - Change aspeed_sg_list struct memeber's type to __le32.
>=20
> Change since v5:
> - Re-define HACE clock define to fix breaking ABI.
>=20
> Change since v4:
> - Add AST2500 clock definition & dts node.
> - Add software fallback for handling corner cases.
> - Fix copy wrong key length.
>=20
> Change since v3:
> - Use dmam_alloc_coherent() instead to manage dma_alloc_coherent().
> - Add more error handler of dma_prepare() & crypto_engine_start().
>=20
> Change since v2:
> - Fix endianness issue. Tested on both little endian & big endian
>   system.
> - Use common crypto hardware engine for enqueue & dequeue requests.
> - Use pre-defined IVs for SHA-family.
> - Revise error handler flow.
> - Fix sorts of coding style problems.
>=20
> Change since v1:
> - Add more error handlers, including DMA memory allocate/free, DMA
>   map/unmap, clock enable/disable, etc.
> - Fix check dma_map error for config DMA_API_DEBUG.
> - Fix dt-binding doc & dts node naming.
>=20
>=20
> Neal Liu (5):
>   crypto: aspeed: Add HACE hash driver
>   dt-bindings: clock: Add AST2500/AST2600 HACE reset definition
>   ARM: dts: aspeed: Add HACE device controller node
>   dt-bindings: crypto: add documentation for aspeed hace
>   crypto: aspeed: add HACE crypto driver
>=20
>  .../bindings/crypto/aspeed,ast2500-hace.yaml  |   53 +
>  MAINTAINERS                                   |    7 +
>  arch/arm/boot/dts/aspeed-g5.dtsi              |    8 +
>  arch/arm/boot/dts/aspeed-g6.dtsi              |    8 +
>  drivers/crypto/Kconfig                        |    1 +
>  drivers/crypto/Makefile                       |    1 +
>  drivers/crypto/aspeed/Kconfig                 |   40 +
>  drivers/crypto/aspeed/Makefile                |    9 +
>  drivers/crypto/aspeed/aspeed-hace-crypto.c    | 1121 +++++++++++++
>  drivers/crypto/aspeed/aspeed-hace-hash.c      | 1428
> +++++++++++++++++
>  drivers/crypto/aspeed/aspeed-hace.c           |  302 ++++
>  drivers/crypto/aspeed/aspeed-hace.h           |  293 ++++
>  include/dt-bindings/clock/aspeed-clock.h      |    1 +
>  include/dt-bindings/clock/ast2600-clock.h     |    1 +
>  14 files changed, 3273 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/crypto/aspeed,ast2500-hace.yaml
>  create mode 100644 drivers/crypto/aspeed/Kconfig  create mode 100644
> drivers/crypto/aspeed/Makefile  create mode 100644
> drivers/crypto/aspeed/aspeed-hace-crypto.c
>  create mode 100644 drivers/crypto/aspeed/aspeed-hace-hash.c
>  create mode 100644 drivers/crypto/aspeed/aspeed-hace.c
>  create mode 100644 drivers/crypto/aspeed/aspeed-hace.h
>=20
> --
> 2.25.1

