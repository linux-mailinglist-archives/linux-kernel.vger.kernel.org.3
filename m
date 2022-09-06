Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A3B5ADD3F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiIFCVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiIFCV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:21:29 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2134.outbound.protection.outlook.com [40.107.117.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0C121828;
        Mon,  5 Sep 2022 19:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjDADAY+OblWW0yex//6D8jmCkeaIubk8/PDyQ+f0IH1Sdpe10n32dtQsAyRAPuljuWcYk/BEoWpfO8RnNk9pGBANf0yZOTJq9eMmgder1/484Fq4kWv+wEhiH+ONOylUTb4P59vBsXr04oSi76EQHga01fxqbnGO5RPQCUXF7OfeEzWQX28fculn1K32eVpAOaeNruKIM0CXq2vMatx70mt0YpsLiinwingV8P1yU89P0IrAZaHWh2Nlmpj0AgaLLPTLGbOnw6z5QkZGW5tFjEcgCgnKK9cNIXqd5TNyFd+MUrJPlIA7G9xChWQzZg9AEQnN6Ehib5WOhD5Mo/fWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrS9hoqoMdUTFOq2CIuBksDIPMod1IOZHqz7DavmP90=;
 b=j18/4zElD3a4WDhUO7jx1SsHIW5QAmTAap+2KhEWhrw5g/xf07tRK+wBH8+fqokPmVyPJtKVs7rn/YnFKmx8EUinTeElPSMRzDBzqf5Aw5PjS5PoEeAfQIyJrvSSudo7wmAcF5+rqo9/I9dyZzZS1CbCa5F8lm4YZX5gTEA3YUXUI/RnD9u+Q/jp2NMncLJ+zJORa6TTHtNir1To9P53XjzlqSIX3GDgICh6NDvuVp0ki4odvmWK9Gd/jpMkm5ieM4NRqkyQp17UssaGQGqnlUc5Ie3xpeHC+I6yGAq1C5AC7+IAsor2x4mjrsFKFC/mFdTpqdB5/ljMzJLX9itETA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrS9hoqoMdUTFOq2CIuBksDIPMod1IOZHqz7DavmP90=;
 b=qNYbjFk5+4jvHfbLa8nbRDNKh96eSg3wK8EjHLOXky6DJBSHQfrFgiUKsl5CxqpEvkYMijMbraq2UpJdkzOXA5SSICn+OGen41aWCkkH4hdNAv0ycr6W1EUM4cfNr73Rjrllt27PZHS9LqrUz/87FQLmnNyBAUKn9KeIA6Qm5rYwFERp0CDYnMmaU2F978SqaXkw2jkEqFetR1C6ckxBtrUPMdCpjfhlsFNLPU3wBUHBzcfovEYxEk/lsCSWgqjCpfSaUvowTn+hx6X8PUZovNNLeSMFj/oYuCF/M0ZlapA7/u9H4Rcl7wMjG/WeEG4lwIAAVb/0qWDNj/HKvXZN2A==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TYZPR06MB4142.apcprd06.prod.outlook.com (2603:1096:400:2c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 02:21:21 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c44:6fe1:af1:7b42]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c44:6fe1:af1:7b42%5]) with mapi id 15.20.5588.016; Tue, 6 Sep 2022
 02:21:21 +0000
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
        BMC-SW <BMC-SW@aspeedtech.com>,
        kernel test robot <lkp@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: RE: [PATCH v2] crypto: aspeed: fix build module error
Thread-Topic: [PATCH v2] crypto: aspeed: fix build module error
Thread-Index: AQHYwNLZ1RAhZZLKJEu2oAdtSs6t4K3QrOGAgAD9dgA=
Date:   Tue, 6 Sep 2022 02:21:20 +0000
Message-ID: <HK0PR06MB3202F47019416BA40859C7D4807E9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220905025433.1610696-1-neal_liu@aspeedtech.com>
 <YxXXuyNrQIcMZBLI@gondor.apana.org.au>
In-Reply-To: <YxXXuyNrQIcMZBLI@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 185605d1-19a3-4af8-1aef-08da8fae7ced
x-ms-traffictypediagnostic: TYZPR06MB4142:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5jBnepLeeC5CuA3Fy0gB/ogpwNOAtg0N1jgSHmHKauRtY6PJ36v0ygZCHyPkl1V0T67Pf0Fqy7kNg9J6HaG4nvLHo29foMRF5VkTW1WezAyObjVIvayDDvEKTbNfVX1Y7x7oB2WPnIQoAZZkUUBpJXVwqI4OqTGgT5HjhyF3UeMoV6NxvCryfskzExF41livhhjvhIGQCEUcktJQO1lmZ0oEskJcOIIQUPO9WlJYPvWoQvruMDTqAkmHPj4lHttlSN3jD3eoF8DjYftuaQJpECBWEbxH+r3VjurcSm/G8eY0Q8t6LwdwqRgzQwW6Iub5MIs7OobF/clfRXLUZzqfH30ZRdJvQLiYjPbCG/b1oHMiYHEmKwReJXDbpF/xl9ZiGl3j5qpaClYer2Txn3rLJQs+lKljXlNcsyr/v34OvZ0cAoy04UegrEWdflRyJC2ZdmV85R3wkbQHWpIax628dTCfMPL/JMZ+I5ZwL12OwH7jMTKQ9bOQT76UPgEkB//eQqRoqp5k1qeLRTVAUoWbVJEmDnBULQHTwgZRm270ER3gLKwUH0KSGUhu+tjPEGJtcRMuaCnq/99McvKkZEgd1fH5uHbOM+i9ozk/nitkD6TOUrcerbVv04BK50qONmVYmzLHN6dm2Txb9cMn6BHaUiMXLv/KylmfgF4gcKiPyySok8qJWihS/OWqmzIML7j4pvfVkSNmF+RXq15iQ+sMeCBTlWWus2d0siYQIJoGGcm80XIwvZQ/uUUviQCnznuNcZnqu4aZJNTTGR2ISMflIuVinhjPGFa6pNBsKr5xwYU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(136003)(39840400004)(396003)(71200400001)(6916009)(86362001)(53546011)(122000001)(55016003)(38100700002)(54906003)(316002)(966005)(76116006)(4326008)(66946007)(66556008)(66476007)(66446008)(8676002)(478600001)(64756008)(38070700005)(33656002)(83380400001)(2906002)(6506007)(186003)(5660300002)(41300700001)(52536014)(7696005)(8936002)(9686003)(7416002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/TTPjkqLar9UUFuM9Vlwmxvhd82mSfDtasKV5/iPnDeKGYAqNDvcX38dXkm9?=
 =?us-ascii?Q?UFM5yChfvIZzDEd4ojGQQCNCfDDEjGZHCYmDymFDtih/J7WriRYz4QJXmrLR?=
 =?us-ascii?Q?YCtdSX7StAlRDQ+YIHCrjvS7i9YFezzy1rRvIX8L7L3r93UPq5gTmm43eWzR?=
 =?us-ascii?Q?n/aT+zBe9oHSvBrtjcFyZ8prc8w+B5XUxKYfuWeSgUwmUPTnRlrQ/rpwzD8a?=
 =?us-ascii?Q?kgd28PLmhh+r7plQnbqgxfbPwWagCdG46v7tlw1+A+wCyYENrzq3KB8/1dIX?=
 =?us-ascii?Q?z381g4oC1JmK/JQ1U3gz/V6acTtefYzJr6M3vNdy0sv8NPWlEEzFjWzC4yZa?=
 =?us-ascii?Q?RQ8Av8CpfYHUCUfbj2/uw+T7JmTkg3bluwfO8AIFFeeVYACdBdQ0F3CwBO5i?=
 =?us-ascii?Q?+791QriyxuwFxiv1BUiwQgsceNse0FKej9/cildw6YzJj0awtIlnh0IQTHd0?=
 =?us-ascii?Q?uORdjO2oeUjv5MqO5EeaTeqc+ILufx8kxyg13/gOJgveULBbvJRy+L47/vSv?=
 =?us-ascii?Q?2uNDMVNVdNsvVSJl6nZJpVxEsImN13EutbFwSxGr/gwwD2wfEKhu7WWzGY9Q?=
 =?us-ascii?Q?VtAILOAZdu8XRMYNtHh7RE8J+lx45naakGPMkuCUcH8oRgKHMfXxU9mHhks4?=
 =?us-ascii?Q?D8+8Ou5/IYa2Aq8xHKe69hs6c3nUvZObz/eabTqhbgEK/WAYT9wSsoYUiQWX?=
 =?us-ascii?Q?6lBTK0v5fg3cnJc8EU8kmfLdfweS13A7w87SxeJ7efcdNDXURcr8ZHYPPSD1?=
 =?us-ascii?Q?iy++QIblu0X32m53ia4//P8XULJCcUJwE8CdHjeiM1vhr14YVdC7u/BgDIQF?=
 =?us-ascii?Q?b5wdCuo28qIoyLR0iSboWVGkAp5zv2vXSd4Tq/ebAu3fGJ7NaylKEaAbQz+R?=
 =?us-ascii?Q?yHSA3h0AF14zIIv/uzqamSdyetqPA3S1xxdKmMxt5gTZ8Cd9Ty1SMLNZEbEd?=
 =?us-ascii?Q?I9sgIsh+bd9ID+lwGUszx2GPPkggoRtP5uy7/C8pdwy9p+3zm1qpVQP/zRc6?=
 =?us-ascii?Q?0CosujglIbgw+4dCEQJ2pLE1KM7aU/1ceY/HFe61rGoZu2qlnu8sJhrykmdl?=
 =?us-ascii?Q?qs7bjj52cSwIE/Ee1KJ6SxSC7fwh2lYrWokWFedD619JeVRrfN8IJsJ6mubC?=
 =?us-ascii?Q?lYTxfdc+7E5fk7c+n4IlXqDyD9aBvJrl7LEvqBc7kckTIeLCDt2Csqod/B5k?=
 =?us-ascii?Q?aLzEZQjNZb0mG8CqAKLFZuL27Dl0KWU6LBf29zz6hftCAbcvwIY+Jixdigab?=
 =?us-ascii?Q?8ehA7iLkczCkrHuVtOvJvlYDCqXwtYMCzIhbVj4sJgOdOpuASoVlWE4UeuO0?=
 =?us-ascii?Q?aWgFyB8s1PBW0B829EkEG39kvgUYpAqfa5PRJ4XDKXYE3c2any69ya59FcUE?=
 =?us-ascii?Q?2vsfxmmQijQQrwyMThwK2tAEVO4qS9FltM6XNFX9HGou2qnif6hmm+k7dwVJ?=
 =?us-ascii?Q?ny8OKWMDNFBBKY6vEK8GouzZSQNIgHlnq8UsjC/GRpFwDSwPpWS0pdF1trft?=
 =?us-ascii?Q?JdCbW5aPPLqUOYU4+/RlaGp65kqS50rXjdEXPCOn2+1TQvlkGqgM86nBu6PY?=
 =?us-ascii?Q?V5T+4KP1SdilPnzD18w2uhffuFlKL1zL0QcS+BGy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185605d1-19a3-4af8-1aef-08da8fae7ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 02:21:20.9185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHuNx1eRkeLuemTSohbdStpaZO/sW3BKMrgju87q2cTCBfYUatiqHvGb8Ru2sDsp4NU3JnY5a8lLU79JwG3YPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4142
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
> Sent: Monday, September 5, 2022 7:04 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: David S . Miller <davem@davemloft.net>; Joel Stanley <joel@jms.id.au>=
;
> Andrew Jeffery <andrew@aj.id.au>; linux-aspeed@lists.ozlabs.org;
> linux-crypto@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>; kernel
> test robot <lkp@intel.com>; Sudip Mukherjee
> <sudipm.mukherjee@gmail.com>
> Subject: Re: [PATCH v2] crypto: aspeed: fix build module error
>=20
> On Mon, Sep 05, 2022 at 10:54:33AM +0800, Neal Liu wrote:
> >
> > diff --git a/drivers/crypto/aspeed/Makefile
> > b/drivers/crypto/aspeed/Makefile index 421e2ca9c53e..3be78cec0ecb
> > 100644
> > --- a/drivers/crypto/aspeed/Makefile
> > +++ b/drivers/crypto/aspeed/Makefile
> > @@ -1,9 +1,6 @@
> > +hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) :=3D aspeed-hace.o
> > +aspeed-hace-hash.o
> > +hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) :=3D
> aspeed-hace.o
> > +aspeed-hace-crypto.o
> > +
> >  obj-$(CONFIG_CRYPTO_DEV_ASPEED) +=3D aspeed_crypto.o
> > -aspeed_crypto-objs :=3D aspeed-hace.o	\
> > -		      $(hace-hash-y)	\
> > +aspeed_crypto-objs :=3D $(hace-hash-y)	\
> >  		      $(hace-crypto-y)
>=20
> Does this still build if both HASH and CRYPTO are off?
>=20
> I think this it's best if you do:
>=20
> hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) :=3D
> aspeed-hace-hash.o
> hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) :=3D
> aspeed-hace-crypto.o
>=20
> obj-$(CONFIG_CRYPTO_DEV_ASPEED) +=3D aspeed_crypto.o
> aspeed_crypto-objs :=3D aspeed-hace.o	\
> 		      $(hace-hash-y)	\
> 		      $(hace-crypto-y)
>=20

aspeed-hace.o effects only if either hace-hash-y or hace-crypto-y.
If we put aspeed-hace.o in aspeed_crypto-objs, but hace-hash-y and hace-cry=
pto-y are empty, apseed-hace.o is just an useless driver which might still =
occupy system resources.

For this patch, you're right it would still build if both HASH & CRYPTO are=
 off. But no driver would be run up.
That's why I revise it from your suggestion to this patch.
Thanks.

> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
