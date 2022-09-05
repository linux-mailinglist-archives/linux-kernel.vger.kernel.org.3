Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C165AC8DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 04:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiIECkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 22:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIECkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 22:40:07 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2138.outbound.protection.outlook.com [40.107.255.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC5E17A97;
        Sun,  4 Sep 2022 19:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVzme+8finkK9X7yN7TmGNizXa2UQzwFrYOrnESVHoqme5Y7SMUqkkIW39JgBxwUXV1e4zH+6VqJreZVPPSXvc96hjndEoznDk1aAazmWVYOwF8hadVBNMpVswwewlEIHmWCxFKUwt/mgnEhDTClU0NGSBsqlL0YPo7wECLO87A9e8UZuyY3yMyqeFNn2kiyuQCqlT4MeGdenyu4iJwDmYJsfM/BLfVBrTg8odP1e48XMDKDYR/CJmS5N+6qLp2jjXayz5Q7OaqRzohBdd3876WHuKQod5oEuoRLHwPbnGkiQJRalrhP20UqGqnzbQhLmkj2b9PsluYxLoU2FQVUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElDfs+tRBKkT9ZDnMeGftBD7OlZEVoWCaARq/MvEstU=;
 b=CvQE9KLoG5X569Ta0hKjD74vaoxmLMpK3sWfD9fhALp7DVZ6Qd7i76duA3juHKVgzN1/nSBohDAfo9I/+Xb0yBoay//bV9x2BhblDE+ubm//OgGXFyDO/EvXc2izXXkdLwkHmFH/iyKBnQy+VZSDJJYVl7viwiOPVwgHrFOuycW0yextGlzdeBcfK2vemyGoXmRVoW1Z18JNn41V3uLCUjVy4Gl/hdbWDCcmQOI9c5OSSySOMhy0p9RExU4tsKwDacsXLhtLW7qIwL5CSI8VNy/vleDQaHOb4UM38v6WlDYiiGe+7F7xOk/hSp9I8qrqbA12Fw84uP4UTLa9lzV05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElDfs+tRBKkT9ZDnMeGftBD7OlZEVoWCaARq/MvEstU=;
 b=FqsxVr6jvVTJAlop2rseIOJGJHJ96cXI+N6OdCsh9Akks052IibwKtFmExnEeQz+gnU0E6Q/1qlafUeO8LGJ2NKI+zHgKDFH0R2Yf38JkskICjEyYoThRwojlz7IZio8RYG6nO6mjwDOCrDnp/wh10Qk74I6fAZfMmWw9vZba3fEiCY/jX6ainF/oiHMCGKl9CCN35/3b2fGhyv0owzAS4QIRone5JZHxynyKgXgjrzgt8hRDAxdczTlGl9gaPzMQZZ/TmM6Ccy1jBlenaUORph2gO6gd9nJrR+62msflzTzZ+qkZV1EPObI8L0IXq6Yh/QJIGk0TRBEUPKKEjGYLw==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TY0PR06MB5128.apcprd06.prod.outlook.com (2603:1096:400:1b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Mon, 5 Sep
 2022 02:39:59 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c44:6fe1:af1:7b42]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c44:6fe1:af1:7b42%5]) with mapi id 15.20.5588.016; Mon, 5 Sep 2022
 02:39:59 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] crypto: aspeed: fix build module error
Thread-Topic: [PATCH] crypto: aspeed: fix build module error
Thread-Index: AQHYu3ffQDbZCh8pe06yGLhDWaOWKq3L9sIAgAQzO8A=
Date:   Mon, 5 Sep 2022 02:39:58 +0000
Message-ID: <HK0PR06MB3202D1EED4767DFFF085C849807F9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220829072035.1539399-1-neal_liu@aspeedtech.com>
 <YxHa+g256XL/vz8q@gondor.apana.org.au>
In-Reply-To: <YxHa+g256XL/vz8q@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f076d47-990c-41c5-c1f5-08da8ee7ecf2
x-ms-traffictypediagnostic: TY0PR06MB5128:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g/BqoH2B/NXqvvcJjSxe4FngmjW9by0HnRbzjFjkSimJ2wmPFqIn8LhYOtdzcNyGwOohFv02xCGQiblRFwPvlV3ygHwbWpv+qXaYvrrYrfss/yVyFu/rQFtiau9nDoObRJScyteJHDTjC1/FsJVO90x3cj2zWZra/Nvl2BiRwZcJMEviP3B7nf0lc3lBwotk1bt2V0MBgnHv4jtGs1j+yPnosrBD4kMSe3FHoSGlzHE3P6E3Ia37on3vlpznbboa3wOeyXIEitVd5Vhq7llB5zbm4w9jPntOkkDgizpqjebT7TVIJAj30o2ceUGlFbUChSG8L24y3oyV1HeNSohIufAAOcD/Z3s3p1PLU+bWeJ9mAowopLIb4+sUwNstTRxgQwzwrkAC/YtyHOKfLIp2rzuNyVTBFq0kLjOtxOBzOU62A6h8S71khbUsn92V1i+DVzVyDgSSJRXXn86sbqfAT/QS7S07VMzeHEUbEVzSm/mzbpkWQ9iQpkv+TsoEAVc2oWjIzY+9bisXiHxrK5tMnbz2KHlng3NdttOjqfNrSVFz1yZ/VE8S5KkRMqFVBYoBR+Ul+LGplxDiB5uvoScwosKKrz11rvX3zEO4u6oVd9EVkbDKI9lo2R+vwQQYKdTELhAxzWrwAvbSUU4Xxfg9TwhZFyfxt2TO/UDvEektWoOEN9taqoXAOUov0ZXPrHz4n43pKuEKjBY+86xS2BNPc608rCCBytDT44frIjkB1uGk9QNzXQty6r8rcZwfWDDyhnFfVbBweVpOJXFSZNwwRRM4tW9lEHqLj9wLyJqsviM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(39840400004)(366004)(136003)(122000001)(38070700005)(55016003)(83380400001)(38100700002)(316002)(66946007)(71200400001)(64756008)(66446008)(8676002)(966005)(4326008)(66476007)(66556008)(478600001)(54906003)(6916009)(76116006)(5660300002)(52536014)(41300700001)(86362001)(33656002)(8936002)(186003)(26005)(7696005)(6506007)(2906002)(9686003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pY7FRaUM7o1VXC/mTA+o7wKYqIFIgm4jxmKwk3RpV7nppQDzEaWH7xbDiHMv?=
 =?us-ascii?Q?3lSMqzjc/bX/RbHu6A0yYofug55gZ4wAuNUYibah2HzZenrK5exHU8ec/4GI?=
 =?us-ascii?Q?oGVHMcLW3bUWd8T+OopOxntolOR6Ma7F4vHEo3TxrSUUsecpmw2Cx84opRaN?=
 =?us-ascii?Q?hpXwrxsK2NgTKGIQ2vEyAKrwPCeoFmHfWc5SsH1UWDlZtL9zraY0bKRzSRXd?=
 =?us-ascii?Q?7uGwP9PjpXxg2Gp0aYk4Y9izkuEIkmquPNexCCbYSNLknAOpC1VmCIFVo5mJ?=
 =?us-ascii?Q?Sf4nB/bqrdliXeV17LrYMdzvfv0Sb0vKiyKEgc2ETsmSeMuLGlNRnyX45Iym?=
 =?us-ascii?Q?Wlpvjc+kdS3WQXUDHK7/Gj97KKmKLHA5laQJapZzQcovzLY5GHO0Es3rWRS2?=
 =?us-ascii?Q?/rbKcj5zSLjpJjs1XusAdANL9nDIrKgNJPd3/TMu66CrbkKLLMpm2Z3kYSJA?=
 =?us-ascii?Q?w9GP1KiM7pm8zzaqyFVCGMjKVe5EqWqNuVtXJ18XPTSObEgvRkdImLM7BR69?=
 =?us-ascii?Q?jC353NruLIPwuSS+cb7fas8C88JyyJtGkhc3x4ICu1c7t7nqR3COut6ReGCv?=
 =?us-ascii?Q?g6Le/L+vM4aTu4vT7wPyg9bD2YZSrevbcO8pXphNMsWwwm3MioyQh8cOvKvd?=
 =?us-ascii?Q?WJ4CPMVnv/T5W3c8AeLDb/pWxQM80xePFaTac+QM0Dfdok5SUZgXdf0wBUWk?=
 =?us-ascii?Q?dBV2onHqhEQlzFogcMpfnwpfUZqp8DLnBX8NiVJ5ObkLqthRd4pfHxzu3Jzv?=
 =?us-ascii?Q?RmsVFYiApGYtvthlZon12NuzWvOCFhjbzXHamRo/+0m2uKOUWFMwCmWC0FT2?=
 =?us-ascii?Q?ora+CzGfYaI9aiPHj9t5e8sE2AqwZQc+LZBeZo7K/akPGvGm8yHbUqd1v6+r?=
 =?us-ascii?Q?KMnYt9kWRKv5IQmzHXxkgCMgx+xOVa03bEB/5jZeQGwb6092o7ps43heCAAI?=
 =?us-ascii?Q?7o/kmHYamDt7Uzr6QRwB1cEGkwATUUnmElKAfj3C3OqAlXQzlRo9tfi4YXe7?=
 =?us-ascii?Q?+eHVXfxv214bkhIoNLlVT1xWqGW0lHRNY1+8Fh2mbvMA27Q6DYdHcVW/tQhw?=
 =?us-ascii?Q?t0oGiNNnV6ed06DyuCgQAgtpM/Pn4mfeiJZGnf6qFateutmiSbOu3OtielHr?=
 =?us-ascii?Q?CI9sL0/GYWT5/L641UAAVfBQ2bB+bnVUImTy7L/EIntKOyWKaraUHpe/hqfX?=
 =?us-ascii?Q?6HYwOW29OOxoRHapPDD75aqJB+5Qv687tY3vFPUzSksfQ4ZW7ntcRGeUgOd5?=
 =?us-ascii?Q?D/MFtk9FwP5omgv5ZQxGa5K6sQzSeNySlTNxqOXtrCBzGjkKM+fvu0EMDY3p?=
 =?us-ascii?Q?PyTCb4QJ2aL8/4pvLN1ob8axdUkpwV56ecm/9IODzmIr/OlaaLoZfDqDoR9w?=
 =?us-ascii?Q?Vyg+pmi9SOtjgdz2SYR1vmw/6eOxMhonFjrghn8v4WCNgNQWWMbRto5lAyhs?=
 =?us-ascii?Q?uOGTY5HDaoOB6gHnZMQ9t760wCsFA97rWbxn1jZ+Z3oYhBP9R8LVbTdjypVM?=
 =?us-ascii?Q?4PRsoL/RHKvKiVncQmezMsVw8vauOI1srTGLg5c4upEqSnfW056a7XSW0x0d?=
 =?us-ascii?Q?NL2J4XWkJ+4C6Fo/OjdJkEQ8AUCITJE0wUf0fpl6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f076d47-990c-41c5-c1f5-08da8ee7ecf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 02:39:58.9643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nh+fr1LAaZ4p6UNvEgjOK6WTR8pyAajNURztQMEovR/FsIvANlt5MkYBevmy2QUk9KLPPyWB4wO6TcwzMsNmRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5128
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
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Friday, September 2, 2022 6:29 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: David S . Miller <davem@davemloft.net>; Joel Stanley <joel@jms.id.au>=
;
> Andrew Jeffery <andrew@aj.id.au>; linux-aspeed@lists.ozlabs.org;
> linux-crypto@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>; kernel
> test robot <lkp@intel.com>
> Subject: Re: [PATCH] crypto: aspeed: fix build module error
>=20
> On Mon, Aug 29, 2022 at 03:20:35PM +0800, Neal Liu wrote:
> >
> >  obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) +=3D aspeed-hace-hash.o
> >  hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) :=3D
> aspeed-hace-hash.o
> >  obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) +=3D
> aspeed-hace-crypto.o
> >  hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) :=3D
> > aspeed-hace-crypto.o
>=20
> Why are these two files being included twice? I think the obj- lines shou=
ld be
> deleted.
>=20
> Thanks,

I'll send new patch within removing the redundant obj- lines.
Thanks.

> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
