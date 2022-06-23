Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B3A557876
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiFWLJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiFWLJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:09:46 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50083.outbound.protection.outlook.com [40.107.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB014B856;
        Thu, 23 Jun 2022 04:09:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyxDvDcffclcBfIRVTBuSWK2+Ma8FEiVI55RmnftUsaqb9c5eSQXEGmSrzg+stSegluTi94R7XqMXhB4jZ+YesvKcam6HhBzIEYw4LJJZ51rbON1jcBWt9l6dKTPvvfg4brbe637DvnWIxHN0hX2Np5rItuIJOi0i+p57I8HWGg9BHzZi2jrSnCLedZjIYjT5TBJoAvBm1JelotlIakzMz0dR136/qvxQynzbMmk4cPeYp2e44hCUsL5XanKdFUZspnIfXJK0m9WV4SZ4e7m7Nqc4or3vOf1f0GgYGOI57nemGxWEfg5dftR0K6LgyEOonWvvi9aaS1jMphPD3RLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1np0z7Za5smEbYnBxWT2AMtjAk5wxtm8Qhms7AUqUo=;
 b=dmZpYEWC9A9d6y4Phj85i8xF9mgJhfVlvj+FHM1aKEOR3squW7+8n4ztcIH4qY0LCZAFJ1a47B2x8j7dI8d2wPYdjB30fzh0A0odrBEF2Sd+kxlVknpTqXMF5Zdgd2cU/xFka4VTQ+iTA5f9jJ1J2wSXmKYBfiEzRM6ua9gURx3GAFjgHRquay+anNUn3rLReecLiQRE/2Qa73UWB0pVKyIfQV0XAKxPeFQCzQ4P3lbCvU6A5B/PTVpthvOCAZpcgSBIk50XWmdG0ftzCXOo7KeSY8tFYE7MqmWEkG+S7ARL2sQ5w+GeDtTEsdpc4j+fdHA4Ay/xbRFCT2Y2/kfMZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1np0z7Za5smEbYnBxWT2AMtjAk5wxtm8Qhms7AUqUo=;
 b=N8E81QWf4UI/zfjIrCeazU/CggYyjZarEP9LKHkt+MvUAtmhGS1TJ6IpztR1vGGjl7gABstm+TgwL+zYgS0aYa8g1IyQa17BU5fZOIfMJ1pfxqMmZ+//gzw4MCVhzlqLCep+5RnidojvA8JafoUmXpAMnE/8Ms+g+KxPiNn7lEM=
Received: from AM6PR04MB5334.eurprd04.prod.outlook.com (2603:10a6:209:50::28)
 by VI1PR04MB5744.eurprd04.prod.outlook.com (2603:10a6:803:e4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 11:09:43 +0000
Received: from AM6PR04MB5334.eurprd04.prod.outlook.com
 ([fe80::99e:6ee:d17:e114]) by AM6PR04MB5334.eurprd04.prod.outlook.com
 ([fe80::99e:6ee:d17:e114%5]) with mapi id 15.20.5373.015; Thu, 23 Jun 2022
 11:09:43 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] crypto: caam - drop unexpected word 'a' in comments
Thread-Topic: [EXT] [PATCH] crypto: caam - drop unexpected word 'a' in
 comments
Thread-Index: AQHYhtB+o2ueF9uQqk6MJtqThgvv261c1bBg
Date:   Thu, 23 Jun 2022 11:09:43 +0000
Message-ID: <AM6PR04MB533467A651C6443982B60A2CE7B59@AM6PR04MB5334.eurprd04.prod.outlook.com>
References: <20220623071123.12885-1-jiangjian@cdjrlc.com>
In-Reply-To: <20220623071123.12885-1-jiangjian@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2ba5e5c-bc9f-49b4-7e3c-08da5508e013
x-ms-traffictypediagnostic: VI1PR04MB5744:EE_
x-microsoft-antispam-prvs: <VI1PR04MB5744441673651F90DA0774BEE7B59@VI1PR04MB5744.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zqUFv0eFdiEW/QZa3yCQSTy8rJzfJZY9Kc0VMzFY20u1POhSogg/w41CEd2FC05epZm8x9gHXZQWSbEme0tWskUndWya03kKRELj6VUpbZSw8mvuDcC3ivyASBtALCiXNaMmEZSopNHO6JP4S4IVyCkrL/m1DDwSxoeGNMdgLOuObnMUvzgqwgwVmIRwKwQ9HV1dqyEW5D5I0hHix0q157GKUclGOyBKJbquSCJ3BIOMrlsoHZGrqHeTREhCQDC3bjmh/06RcLRwUqxnAv0GD8YJDaHT3WOb3W3gfi2Y/pyprB3VgZuJSXrMXDZhWcHaK3JQZcHEbQNdd2EN0dJd72OQeqlTr9BaXRlEL4/Cq9zdTjOlU6HavN5Zi/L1P9DqyikpkUd4+o27Bk1xnMCMSHTeCmPxSULtOXXQPVkRxmEkJ5I2yPp1mBZEWzxF8j62+SD+RwNTyhsB7H7AFJqnVFmbZUccNdvuuev3s+QnADtLO6qaRcyDsLiIt8JQuADATWX5BLpsLtp3Hj3cFdx9efQnlBe3FmN1xi6DGGxB16vst1uk1WIUeUYXlgxmOG2eA9px6C0RS/rYo1bjT7HksMlLaZJ6/uSuMhmQUm9fl3bEPyrYvxhQLsYf7//n/Ygrsl5N++HqAX5kp8yisR991XVnXmTog8fgZrCRNKeaqBwxuDj07YDSlJgUdZbXy4wO1KYtwCgN1/1wtBv0xl0MdFVBEvmV/BWsGU3hsEbd6G6NMc0AHqVNMMK+mSV/Mn5T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5334.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(86362001)(186003)(71200400001)(38100700002)(33656002)(66946007)(66556008)(76116006)(66476007)(4326008)(66446008)(64756008)(316002)(54906003)(8676002)(6636002)(110136005)(6506007)(478600001)(38070700005)(52536014)(41300700001)(122000001)(55236004)(53546011)(8936002)(26005)(7696005)(44832011)(55016003)(83380400001)(5660300002)(2906002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EZqkmZWIBKVCgEJS3BkoKGxUtsLLWzhVf9N1Qm2GnCFRDq81N6W3x7a51V16?=
 =?us-ascii?Q?2BcSUADUsqfpy3R/AyLhRSo3/FJYqfwuuLpkTNMUYqDdTld+AkuhhakCfuF+?=
 =?us-ascii?Q?9SNrW3dZKMulLYV/Tchv8umH1PtJL+CCOR71mMB6J77q+Cq5DIWcq5RcApln?=
 =?us-ascii?Q?szkEgGJKo6ylvASF+ZDLc15z680/DLecMNXikoPiNtfrZTOtwuvBHcdPlRnA?=
 =?us-ascii?Q?9ZCNuBcJH2ZTH7AaBGI2I1TtlYdYXb7K87xJV1aoJudnNbQFtRx0spiOYuws?=
 =?us-ascii?Q?6IfP31yuzpMMRitDYhqg1uTcswa45rczlw027CXlQjaWlK49oKHKpLpVDeYL?=
 =?us-ascii?Q?00P1b3G/0UaJ0DQIcr7Fu+kwNS7/2nFY3WeN6637dylzCFIc8DGUjKz3toL6?=
 =?us-ascii?Q?1LojO63Os/03NBx4SBzpbXqWyYlyhtHmOZA+wrTYslUiapah5uym6Kv2KODe?=
 =?us-ascii?Q?K1cVHW6NaKnhVcXSDIs8+8N3aqLiiwYO7XOyoCREXLH1JAXGh8EHrPxyFxCR?=
 =?us-ascii?Q?Rcvj885ciMdSTgptL+YCw6uVmbQbcYMqc+jOrgncEBEuxEvvUXk8gruyQpPi?=
 =?us-ascii?Q?y2zCDdNHPYilRDEe/Z5DYtKIOyQn5Ti/fniK/RlhlzUiJTtyjuN4jKXI4+0c?=
 =?us-ascii?Q?2z4QPvwZZNa8wwn6BFHAUd8SNOCZda0JWinLhAVc+3QClnu+1nt36qiUYCTT?=
 =?us-ascii?Q?mmRG1CJKXCFljFAIoS6ZwbrHWSTMvgCHiwUlQyoaij8yfVBZ3fltomWMd6JM?=
 =?us-ascii?Q?70lniiBu4ICl1RFvLpy1IdMywIUvDO/b59H50mSQNEDE7XIZI9mioo4of+XB?=
 =?us-ascii?Q?90gbn53wHkNu63+3Nnk2m7c3ZeQubdketf2OHugjRPxteHlyHHc5dPcPTZTy?=
 =?us-ascii?Q?v597iKN5UVX2JsOMldsxHud0pNv5/jo0+RDr79QJnESiBsNqFWctor77tn35?=
 =?us-ascii?Q?n3NLM99aSDKRPXnSsfO38ELjpIMTxld3PtZcxfTtE/nXSQkah7Fa0Bo68Chg?=
 =?us-ascii?Q?/pd7hHFIuaFkzGAYWzVlh6v/uatlL8R0z2xsNuaRMg1h1Q9kwDn9Ea9cKqlU?=
 =?us-ascii?Q?D9VTm+UpKKMh8faUt2dhQh5k6Abs9GETQCVa0/nE+5t1mosMQxKOFI83cuYR?=
 =?us-ascii?Q?51axSzssnjUw+iX55W/ZsR0AVQywiu4NkVVJlbyOZ6hZaV9O8fVwb0ncW2/p?=
 =?us-ascii?Q?zkQmMjJY3dGGh7mdXrZH8aiyYhDcLwswuIjzkxFfvBmJsqFfi6cjHtB/4RO8?=
 =?us-ascii?Q?/UOVAayO0qE9r2EOkocSHJoips4ijwMHQgWHTTsaOr9zwzNrf+ViAp97M0sA?=
 =?us-ascii?Q?43Gpb0r0uGYJjZVI/ALetkcJKtPVkbDom/jj4HkBBMkJ0IIjA4hoS22l9SEL?=
 =?us-ascii?Q?wyL7oYvOuyJjvXivky6soNTBMJ7DkZoqzTGAtFLpeAl7s6ZRqfNJzgWosOK6?=
 =?us-ascii?Q?yLem0m4O+hu3u5IebdlR4jzX6HfGM6sUUWNS5evRTxy2hXE1CsBVngiDIJws?=
 =?us-ascii?Q?q2epQF0+ZJuzltLxdF8OZKGHwHxjzJpJ1fbxnI166BFoR/WhdH5I/OiTjsNe?=
 =?us-ascii?Q?CW/l9wCdG68uyVUXUFrmsYii5iudsvD5EuNkL1DZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5334.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ba5e5c-bc9f-49b4-7e3c-08da5508e013
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 11:09:43.3663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xkn+tpOGqCIm4Fk1aars56kIUrdI/kD+5/1M1btZkmHrcMAO64kG0Vc2vYk1HpIPgTHfbG/EDGqu6JAMHYTO+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5744
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>

> -----Original Message-----
> From: Jiang Jian <jiangjian@cdjrlc.com>
> Sent: Thursday, June 23, 2022 12:41 PM
> To: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>
> Cc: herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Jiang Jian
> <jiangjian@cdjrlc.com>
> Subject: [EXT] [PATCH] crypto: caam - drop unexpected word 'a' in comment=
s
>=20
> Caution: EXT Email
>=20
> Drop the unexpected word 'a' in the comments that need to be dropped
>=20
> * This is a a cache of buffers, from which the users of CAAM QI driver
> -->
> * This is a cache of buffers, from which the users of CAAM QI driver
>=20
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/crypto/caam/caamalg_qi2.c | 2 +-
>  drivers/crypto/caam/qi.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/crypto/caam/caamalg_qi2.c
> b/drivers/crypto/caam/caamalg_qi2.c
> index 6753f0e6e55d..4b81fb33f199 100644
> --- a/drivers/crypto/caam/caamalg_qi2.c
> +++ b/drivers/crypto/caam/caamalg_qi2.c
> @@ -29,7 +29,7 @@
>                                  SHA512_DIGEST_SIZE * 2)
>=20
>  /*
> - * This is a a cache of buffers, from which the users of CAAM QI driver
> + * This is a cache of buffers, from which the users of CAAM QI driver
>   * can allocate short buffers. It's speedier than doing kmalloc on the h=
otpath.
>   * NOTE: A more elegant solution would be to have some headroom in the
> frames
>   *       being processed. This can be added by the dpaa2-eth driver. Thi=
s would
> diff --git a/drivers/crypto/caam/qi.c b/drivers/crypto/caam/qi.c index
> 8163f5df8ebf..49439d0d1b3c 100644
> --- a/drivers/crypto/caam/qi.c
> +++ b/drivers/crypto/caam/qi.c
> @@ -75,7 +75,7 @@ bool caam_congested __read_mostly;
> EXPORT_SYMBOL(caam_congested);
>=20
>  /*
> - * This is a a cache of buffers, from which the users of CAAM QI driver
> + * This is a cache of buffers, from which the users of CAAM QI driver
>   * can allocate short (CAAM_QI_MEMCACHE_SIZE) buffers. It's faster than
>   * doing malloc on the hotpath.
>   * NOTE: A more elegant solution would be to have some headroom in the
> frames
> --
> 2.17.1

