Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FA8560FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 05:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiF3DmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 23:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiF3DmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 23:42:02 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2100.outbound.protection.outlook.com [40.107.215.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DB21E3D0;
        Wed, 29 Jun 2022 20:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUJUhDCl8rai0W5w+gGPvLmEC5EHsUdWxrkAPD2acB9SqGOtF7di2KXFmC3CKv+OY3kfbaco7Sno7+xxqnnmT5hzX1qwGUPGEVlSY4tX/wB9eOxXD6LrsxTa9FvHE/w4VxCI5hRqmPHl04aCww4pKdkMZ9uU5iKdF8c7H/21cT7hxVX2bK/0Zk3bmy2YiZJS3vc0AlphjDf7Fwdiyb9ecbEmXHDyFjlK8C5yhWBV1Q+az3TRw3zJ4tu5IjREYfX0AkP4UpCo343/NbOhWFsX8D6GQNI6o62UIpLPPlS8jjDvw8dLIDJGijla4CrSdjEOEp3Oow6/1BsYj9ZacJyrgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYbz24zNXymM/92xBJSvZDm00omWxHA5DIbQVHCmkCA=;
 b=ZFGZ5gK7Zm8MwWGG7xFy3EQGMa5XUXcLX9bw2h4d2v2zhJOf4V2tajAw6aWBuQN4gjy9axdXs/Z6UYOTGb1UO/5t52vduSk0b0nZ23jEJOvBuFEp5bZvJV1oqQ9kT5bOCwz9XDi6usBa4AHkT2NXvRL76nifKQF7jwVr0buaJxBFuiH58xmsZcj3LIpvvlLE0bCt0kt8UkJOdZx8EjZVvnNTl3elu3qVfXn5W7FSOjhoK2WGqsgd6Sn5xO8cf6f+upNSYYGQuoMpFyBHNfofJdMEAvFZ6jsmgtF24azH37TjFgfMHsolE0LMKs4U4IHAQmfb71HzpyMyan091UM6lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYbz24zNXymM/92xBJSvZDm00omWxHA5DIbQVHCmkCA=;
 b=TyE/twKKqRmEvZK2Mv3kcFpGeS8ZMJRPg0xIAaWaTz+1WdDwQZ8uW2/VaQzUCfC4t3/OXjrTrbD/rDpHhmpjgp1Fpvzseh6iE2LT/RVXtX6yu3hl60TOieTo4X2OTdKnmfsNv+G8OgHulevr4boqEUI8EXhBlQB2qMuRTysp3ICZAxnID8XpP7RLiRHBKQyrmY7dxItnjZRnkjNJgxmSOnrLpOGilbVB43qJoDl//cHLFpuBTcTlTzf6Vb+WEC6nnHnGAtaeCTCLAHoWbQrPuMtMPTf4ta3iYHI3EjuKr4FERHbYQSxID5BnzWSNIt+ul1AomX7B1J99iAmsSOc4lw==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by PS2PR06MB3480.apcprd06.prod.outlook.com (2603:1096:300:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 03:41:52 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf%5]) with mapi id 15.20.5373.018; Thu, 30 Jun 2022
 03:41:52 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
CC:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v6 1/5] crypto: aspeed: Add HACE hash driver
Thread-Topic: [PATCH v6 1/5] crypto: aspeed: Add HACE hash driver
Thread-Index: AQHYi5zYXJWayYu9tEOgJTXDveSSAa1mUnEAgAD7PSA=
Date:   Thu, 30 Jun 2022 03:41:52 +0000
Message-ID: <HK0PR06MB320233EB0554D930CBFED3CC80BA9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220629094426.1930589-1-neal_liu@aspeedtech.com>
 <20220629094426.1930589-2-neal_liu@aspeedtech.com> <YrxHRMoMYW+QDSnd@Red>
In-Reply-To: <YrxHRMoMYW+QDSnd@Red>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e52e0802-4509-4c59-c346-08da5a4a78d0
x-ms-traffictypediagnostic: PS2PR06MB3480:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i0AfZFUXG1DhuQU6KI3gn5fv000bqYWNK5QtZ01W/57JjhsrZyaQNObPmz3EE0oR8gwTUUuB8qWxL1+/n+4jDjP8eYdCL1JU6Blj5AUo4I1zNMVuSXN4ASSwrqTgZnWVPhatyMRDm8IGZ7UIQc9DhNK+mdviz+8dWrKMP+qbs/GqmvVL0aMtp+xq/2ByzVgBE/O7HRvLnRb4jW+5rRCIzqVzqTTrb1GN/0r4aDY6wD3vxdIGnTI4DOJXaJBKzje+Z4R3M3f1gM4woOGIrcgWtsFFx+Nloze1b23IovNchsW0++byKuuoD0mJizwceQ96CdyumJpvq8JNoKEdCg/rTKCi8dfIy4paTzz+UJGGc++OORUDx2Rlaz5JJ/cA0+ZtOFwBFIEdImUal84g4PyP1ZlrTJjUUCz3QKpDSxRzhoPqrLAiFq9x8vRNmQ9oomfYXTgA/sWaf0+QubiX0zLvkwOmOzfzkkjHWhL3t/YFxoalreHkK6lwYO6oHWZfed7dbs2wc23A08vWtYM/VKxJ0WQbSw0iWwtIikmX0JUHHu19ZXFxrc/cS39/fsN3iGffBsOOfQ90WQJX3edWOGChjxFJoUbRrg97632a8pITluqjoOjp83DyrOauvRneYnTFvzp53SQY2xZZkXCgFd4bOdU42e1nKeXHQo714DVsBFXgy5Le5BmvvRAbDpxiSiAVV34L7AHC8nm4YRyz3fRCloobwegwJU9oSm9Gxx1t0FLfnZx5sXXmja19BmABd3EyPQ0sJWV5+404Nwsv9qce0wf1zU78Niw+n9Gw8+efTfocMT8f58sD5tNRC6SVC6fV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(346002)(366004)(136003)(396003)(376002)(66446008)(186003)(71200400001)(8676002)(4326008)(41300700001)(66574015)(64756008)(66556008)(66946007)(9686003)(76116006)(107886003)(66476007)(26005)(6916009)(54906003)(7416002)(38100700002)(5660300002)(83380400001)(478600001)(33656002)(53546011)(86362001)(6506007)(55016003)(316002)(122000001)(7696005)(2906002)(38070700005)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iG6ID0hiH2y87Bg/tFX1Afgn9gv1s2zU38z+5kndrXoaQHxgdRB5PhAisd?=
 =?iso-8859-1?Q?YUG/ANHurhgfiCy430fG5YIduq1KKk35IJ7x2lOHo+2sKNcbHW3tOtb64y?=
 =?iso-8859-1?Q?9/sCmoOM3Rw7qNYTVP4/UyYd18RrLOOwlUpCvCrymh5AxNWLvARfmjKn3Y?=
 =?iso-8859-1?Q?w5orWiJrnCSQxFR5kiUEmjVe60W5Y9ROuZsU7JNuiyySDQFRZ2Wa/oeuIx?=
 =?iso-8859-1?Q?UG8Hmy0Dgn8aeTg3l7jW7eg3pWynaBGtXibYdTrRmPpzv460QBw3TLzgv2?=
 =?iso-8859-1?Q?8/CAUzIUOB7pNjVppJj1YC5iinmCTwIYvdxWBo/YOHh9I9nSdPBCuE+7YB?=
 =?iso-8859-1?Q?7X+wnKfiJ+hSklrFx16h4lSwN0m9Ql67h8OQqtZlUvFruYRlRK7XyfpciC?=
 =?iso-8859-1?Q?L9ayRLdoA2HaKe8M6LLREMEF+xYl9QuTeaw3XLT2AVxVlq/jAKGh+CHD1E?=
 =?iso-8859-1?Q?Fr4ZZMbx1hlPMxct+zHfWpJd0e1DptKOE4JZNuhHuAwpyM70HtPqCCm7FK?=
 =?iso-8859-1?Q?8MqOZZVKpXJ5IBneFSPPubiOD7qReBgWW6PcqU89Gp/Eh7dmVJOYoZ3rd7?=
 =?iso-8859-1?Q?vVDez/8rj6ysB4T2rGFRRJDuMNHC98Tb6YNL+J5BlfEfb4vrwC6fAIZySq?=
 =?iso-8859-1?Q?ztX9WJflWbVFAhfFOyV09ylBenrdMECjdC6wOwLPd+D76kZRijCWNPgHsR?=
 =?iso-8859-1?Q?Yt5zNqUyFq/GgsX8WfqzRUH1ryxfJiDEFOu1/9FRaEFhLrDGyHRNy0Nds+?=
 =?iso-8859-1?Q?a1BXf9R1h3DW+m+Xd30Nw6qv9/nnFefBGXSpK736MvSK6TkAxL9BNCh/LY?=
 =?iso-8859-1?Q?rt1WLYZf/RmKG2vwPWjkkirxuWx4yEaAjGaL06Oy0U98+n6ZSypvKzpT2D?=
 =?iso-8859-1?Q?gkRYMrfq5V92TWIlwNeAlPoYomqu6nSTT0baxoiHgC972c0P2RxQ08fv3/?=
 =?iso-8859-1?Q?XeR77H9hSCO87YgRZNYh2JrfnmSppxbfPOkLIIc8ZttzkPVIz+Rkgk81/o?=
 =?iso-8859-1?Q?5nJEpN1+0xnYsZahAv1t0W+pKZwtaCRIne2KPBabPcdAUtf0bwZk5i6kgT?=
 =?iso-8859-1?Q?Cck2NJmaKfvFRZj5DKQ7lT+Rj+y34wPAWpV9cgWMujaCgZnTSI2LldBkCA?=
 =?iso-8859-1?Q?ISRF+V9itHZ9tFrbSxau7iEPhaSKjUTfvvpvVGLvluAJntkLyHxwv4QMsG?=
 =?iso-8859-1?Q?0ay7wV5gYv7jxrIpjkTTzPPpRo9kWpI67XpKMuUuuiL6qJXTeNOtyoctge?=
 =?iso-8859-1?Q?2fS3+38DUk6I725VWGPm3RHl8ut4SFIhIUcNSe/SgW6QgAevmU7K+UyPrw?=
 =?iso-8859-1?Q?bgYZ62JO0DCB3dvej5uXdFQYZMmpYiBx+Zf1rJ+VEeok4L/HxdXYS+e6sp?=
 =?iso-8859-1?Q?evGA3vArQDh0SbEsAMF2VXVFCgLTCMNTusTM9uRJxnJCdDcFC4YMsaESjI?=
 =?iso-8859-1?Q?Ju88n3aMyMc2Ms8j3adGddKFcL/avo6cX6NXXmF7bAE7RfGLgSzgNxHwDg?=
 =?iso-8859-1?Q?7qrnvxPJfChXhuwgQsu6Hh9fAfiMz/ymwZNnJmntUsvku0mISzzQh/hxKp?=
 =?iso-8859-1?Q?tvTCANyNccJAlU4Z+OSmRf5Vj/GrhHUalVB3zfez3bBEjdc1HWlQ1Lz9uZ?=
 =?iso-8859-1?Q?pzGXPAgE72IesNS5tVD3i6ZxT3GK8h5OlN?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52e0802-4509-4c59-c346-08da5a4a78d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 03:41:52.6748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3i3GcsxSrbtOKNqvgB1U556vdbOvW60EfVtFkL7DkqsBZtu7lKI8/+7f2IxcNUuP9e6ghArqbN2dknaowpYtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3480
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
> From: Corentin Labbe <clabbe.montjoie@gmail.com>
> Sent: Wednesday, June 29, 2022 8:36 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>; Randy Dunlap
> <rdunlap@infradead.org>; Herbert Xu <herbert@gondor.apana.org.au>; David
> S . Miller <davem@davemloft.net>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley
> <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Dhananjay Phadke
> <dhphadke@microsoft.com>; Johnny Huang
> <johnny_huang@aspeedtech.com>; linux-aspeed@lists.ozlabs.org;
> linux-crypto@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; BMC-S=
W
> <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v6 1/5] crypto: aspeed: Add HACE hash driver
>=20
> Le Wed, Jun 29, 2022 at 05:44:22PM +0800, Neal Liu a =E9crit :
> > Hash and Crypto Engine (HACE) is designed to accelerate the throughput
> > of hash data digest, encryption, and decryption.
> >
> > Basically, HACE can be divided into two independently engines
> > - Hash Engine and Crypto Engine. This patch aims to add HACE hash
> > engine driver for hash accelerator.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> > ---
>=20
> Hello
>=20
> I have some minor comments below.
>=20
> > +++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
> > @@ -0,0 +1,1428 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2021 Aspeed Technology Inc.
> > + */
> > +
> > +#include "aspeed-hace.h"
> > +
> > +#ifdef ASPEED_AHASH_DEBUG
> > +#define AHASH_DBG(h, fmt, ...)	\
> > +	dev_dbg((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__) #else
> > +#define AHASH_DBG(h, fmt, ...)	\
> > +	((void)(h))
> > +#endif
>=20
> Hello why not direclty use dev_dbg ?
> You will still need something to do to enable dev_dbg, so why force to ad=
d the
> need to re-compile it with ASPEED_AHASH_DEBUG ?

My purpose is to control its own debug logs independently.
Maybe below define is more reasonable.

#ifdef ASPEED_AHASH_DEBUG
#define AHASH_DBG dev_info()...
#else
#define AHASH_DBG dev_dbg()...
#endif

Do you agree with this?

>=20
>=20
> [...]
>=20
> > +	if (dma_mapping_error(hace_dev->dev, rctx->digest_dma_addr)) {
> > +		dev_warn(hace_dev->dev, "dma_map() rctx digest error\n");
> > +		return -ENOMEM;
> > +	}
>=20
> An error displayed as warning.
>=20
> [...]
> > +	if (!sg_len) {
> > +		dev_warn(hace_dev->dev, "dma_map_sg() src error\n");
>=20
> Same here. In fact you have lot of error displayed as warning in the driv=
er.

I think both of them are fine. Would you prefer dev_err() instead?

>=20
> [...]
> > +/* Weak function for HACE hash */
> > +void __weak aspeed_register_hace_hash_algs(struct aspeed_hace_dev
> > +*hace_dev) {
> > +	pr_warn("%s: Not supported yet\n", __func__); }
> > +
> > +void __weak aspeed_unregister_hace_hash_algs(struct aspeed_hace_dev
> > +*hace_dev) {
> > +	pr_warn("%s: Not supported yet\n", __func__); }
>=20
> Why not use dev_warn ?

dev_warn() is better, I'll revise it in next patch.

>=20
>=20
> [...]
>=20
> > +struct aspeed_sg_list {
> > +	u32 len;
> > +	u32 phy_addr;
> > +};
>=20
> Since it is a descriptor where all member are written with cpu_to_le32(),=
 it
> should be __le32.

Sure! I'll revise it in next patch.
Thanks.

