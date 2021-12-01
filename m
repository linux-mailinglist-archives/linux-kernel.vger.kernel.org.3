Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318D54644C7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 03:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345850AbhLACNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 21:13:18 -0500
Received: from mail-sgaapc01on2134.outbound.protection.outlook.com ([40.107.215.134]:46816
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345743AbhLACNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 21:13:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQ4iDr4f0jGOKE3CzUCb0Yht0flqWiQ8s65GD66fW38asGBI3+ChZ/RCVOmvHlMyvwD0Jkq4zU3zfKnnWqnj1GQihtng4YAIHuUnafdRrxEz3gsP+rl2/uzYthgbTCUB1Z1tmuUMmz9QyO6UnHfxWuYPxVzFOtyzcx8/Srjhv9S5prymwSAL8DxHyMJdD2hOYVtJGGtz2ooGZF/0OWzSNChBQCjikgRFatl2SeEWlql/L80iLBJfz/0bspzQEqsrc2uwUu3qow8iTACssqvJpdPheE+NoIjdqNfDAjG6Ao1iwIl8kusQp3tFRfmdFowKELpNbNzkgq0PZwFzooAsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5GDlw9Qtvtt8sYwCygnC7uuxsmrKPOXin5AjHuZ4so=;
 b=Zue2LCAAYyjN9Tboml1ERDuou0jCOs9GDD2ingPNhNiyzeGhnMfKCzhSoJogb/TDcf9f6vDinuAWiuFOea8BwgEM2X9/eRYGnqWu9S9EUirSiiM1vaxREw+QMxFgJZQfRvYtOey4l/2vMNVrhvp8YfsrgukxQiDj0gW3N55xvqLpm2xph+MYYRswaPBPh9FCQX0qflax8tcK5+u8ca+OFwr7nLIjPlwytSlky+fMidv1VJgn94yqNKBXOPJbuLyZ51CKw6bB2MqoSL1XSmqmFxkG0Hpl7I8wo0x04BO8AJTists36ZYlRxtPfbweUTp+K3WCNtnthcHVdJG6s35THw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5GDlw9Qtvtt8sYwCygnC7uuxsmrKPOXin5AjHuZ4so=;
 b=gW5L7gwa3O88gtYau6dWH4hWb5psPRCQL5bdUmVzfz0JKsPn5jUyoQsVwysHjQCPGQ2ie577FMiHfQqwHQtZyGorQ2Zcr9zSGhzoD5fXSK+k2EKFBWa670DnY1jXGApBWK3mTraZ5MpoWGbqOx9TfNUbOHrapgCrLX/9RnCM1MBWB4JOAYdGsSyXtEr1l6njc1Wo39jrcuLXbQVtQU5FlaZB5mstr6bXfPTGfXSMoRwh2WMPyC78hE9UceG+ylp59FkDWFWGRUFEpq+zxLLNtqJ5mGc4CTK51v8DXllkLLEflnV+y7CAwTGKNK0i26hZX5YE+NBFiWSdQtQRFuqQrQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK0PR06MB3203.apcprd06.prod.outlook.com (2603:1096:203:90::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 02:09:43 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209%6]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 02:09:43 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
Thread-Topic: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
Thread-Index: AQHX5d7cQ2+vsTwu+0+N7TayZq2xGqwb8xUAgADyF5A=
Date:   Wed, 1 Dec 2021 02:09:43 +0000
Message-ID: <HK0PR06MB3202E90BCA3BC31D6E4C752480689@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211130113847.1405873-1-neal_liu@aspeedtech.com>
 <20211130113847.1405873-2-neal_liu@aspeedtech.com>
 <YaYOPgzv6hGyXLYg@kroah.com>
In-Reply-To: <YaYOPgzv6hGyXLYg@kroah.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d4e8627-6d1a-4b41-f0dd-08d9b46fa41e
x-ms-traffictypediagnostic: HK0PR06MB3203:
x-microsoft-antispam-prvs: <HK0PR06MB320359230458179F78E3599580689@HK0PR06MB3203.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dCcht1B1OUvm6Qmms8fr9EoVgIqcZI+31oq3p+xuNGCZT+Nt+CyIEhj+2eP4j5IyHMiSav89zgsvUnJUpbgyNYI1PaovS1EI4nglTNKAJWZBc3BQFLRayfwdtbsMTkuKKzGi7GEGTgGcsfdq3gkuiEEYrHUEg5QNBlsSXhma5Nnn2Xzf+M0rxBUz14EYh1G9jJXz7rXjSXQ8tkTTWnyiIcy9oM1hFwGDqvevTPowLc1Eb8otnprfz9RGh9nIqJZRuubBfwR801voH3n7UUk/RtBVUOUTXUKHZyyHL1s+Xj0GVbgDy0V0LMHIHMoY9omIbzRsh53TvyWoFNOYBNnKJ0nJLsU5dFe9QXFp9TApjUdnPN7JFV1kmx5mSzYlAhrkmcojqNvEf19MkQxn48VvNHYpOvUyiEog3Gi1WtnTcj7THd3P88WMLwAM+HrOHYsO574GATugAUNIPwfUgwxsPn/oGue19OwR1JU3wfxRtvInIsJBGGXJzG/ZyXAxx41jJ1Bx/rik49EaxOd3gPOVLR3fNJJ6LjCDQy6RMJXZLnwqpcs+CZwHtroGgiCcc8jE/T1v9CAw2512ted1ApuDdh/A2ezy/0T1Dnx9BXoNudOcTQithw9CIV9XK06RSeIJIhtIay7OaHWMjC+mdz1oSFjI46+l9CO1tyiWeIti8ST5Mcbq6Xx5MMnFbQ9Br8LQXpH+Elp8/FELMOTAo6ivLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(376002)(346002)(136003)(366004)(6916009)(86362001)(122000001)(83380400001)(38070700005)(52536014)(2906002)(26005)(38100700002)(53546011)(55016003)(54906003)(4744005)(7696005)(71200400001)(316002)(76116006)(8676002)(66946007)(5660300002)(9686003)(7416002)(66556008)(107886003)(6506007)(4326008)(8936002)(186003)(64756008)(66446008)(33656002)(508600001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G9ezM6WQq6YeVMjkt8T3mc5t7gDrwoBm0hVi2XUJPR7ITGA760UoR7KlO7iK?=
 =?us-ascii?Q?15RAx63RQSs1ib9LlkUodrEOpRERwFLjTvyzaPnfOmZ70TflJEbSZ/TWXi4y?=
 =?us-ascii?Q?GbRLHBCyKLQOMOCKARvzeXWatt5Ozq6ti4IEZOceqveHx6vMn/VuvDiGFwFw?=
 =?us-ascii?Q?jvOObL6OTcytYBbfB1EOCxV1aJqY6A+dDGvgg9zkkj/lTBPMe1gM6ebAtBk+?=
 =?us-ascii?Q?2Qvqn9EcGUP82TF3CYH1dk9+7NLtBRgUs8MR3wPPSF0+vCqs+0ercVWQ8FSC?=
 =?us-ascii?Q?N7MI4k4/TgZ7zPdPG5ikjLUjgCDJ1cvAw9na2bsRlfAQse17eBxaS99SIbol?=
 =?us-ascii?Q?cAc4iJVf9t/fcTyFk4euGVAYSMUasejIoJitWa/n+hWmo1Mz/bWKZxPWCAH7?=
 =?us-ascii?Q?2IFVFH/RGF7lzfJXjuzQx4pgBA7u8rs0M5ZNE65yJIHK0H69NbVlH5Dl4JBn?=
 =?us-ascii?Q?UyHayvgmhIqa9YM/rhX0jSOTX9++DcXOKlUZqzTtvg2vcf6uFW1PTnQ8pPBF?=
 =?us-ascii?Q?vJSp8eJ1lTbb302N4/yhhj7QehUkFLvoac4Xs7uEnl73GsK9Yct18a5sHx6r?=
 =?us-ascii?Q?SpCSv2x6EOC7EQCBzDNnjGKSsKk8EN30RYkKxWl7wsZgemHy++8IM6lSsoHZ?=
 =?us-ascii?Q?neUTJjzSEuwVfQrta8nyuJgVyZH4mSQfRyyhu49MLcdfdhmbtOUBuZmrZOoI?=
 =?us-ascii?Q?J2Q/Vq0wH3TIs89pT60QgXExBZls2yhh4IMf1eEzK34awvrw9JD33gWHfEHr?=
 =?us-ascii?Q?ADuFe3TBD3orR6+LWZ1oQDLiDgXfmKOtS1i7NU4iTpAHb9hgghiO8CqAQUAS?=
 =?us-ascii?Q?jRWAl1a/rdQxS9LEUyff47pS+yzUuBn8unorZi9yFd3vMG33rlGTt5YWfmEv?=
 =?us-ascii?Q?kpREA12bM6tO32KWiUjJOMvclC8TIm5Zv4ueRi5WoMMM8EMIg7or3Ipzt4ge?=
 =?us-ascii?Q?JDo/JfvTw1sn0BudEtZLOZ74KbdJ7l2W3OHU7041kpyO3SNpgsL+7tA7wfUN?=
 =?us-ascii?Q?7w/xbqp+ZNKE0aFZMCVL1pirjAN3q0MfCbOEDtfZvHa/Z3y5rq5kqLus6h2n?=
 =?us-ascii?Q?mLc9zIJ2Awx2u2YQwl8B69Dkm0KQQF+uHtow5lCl8gZmes//bkcDa2WZ+Yk3?=
 =?us-ascii?Q?ava9VWWCLmXDLDnGfve7p6O8pm1YUM9qRptvvELw6qigFJ998v2CS5sfQuvI?=
 =?us-ascii?Q?2f1rh0OLHDe2PeJxNwZLQMMMHIezumf0Q4iOiE8N6aX5liyAuqcFWu94dHvP?=
 =?us-ascii?Q?am6thgDw+2bIsXrnlFqoplsh2xvtjGP3IlhLaGdIAK61DFwfpcWNsIY2pnFA?=
 =?us-ascii?Q?M2lZhJ66jTkFd+NmVfaCeiPKYfUUP2KK2tGW/yx5klPfFKxdeXckhvgBqOJx?=
 =?us-ascii?Q?P8l7tFaPmWs8afg2KA+ltxvL85+YeGreCLZ/jRwnsh73X+gS/3KHMtx+WnR1?=
 =?us-ascii?Q?Uhb9yF0HS3d07TVQfupZHQ5Kq1A/8ytx9Je/jMhlzuG3vufXuqXa7CVnppp8?=
 =?us-ascii?Q?qBUMHMKUbOdv+SJK/nD/8zcgOVYVJAJpxv7X3zCHEmnlc8Qv78M6ku0DUTB+?=
 =?us-ascii?Q?G1ylx4iu+RrIQOQFAvyNQHTW1AoDbcWKH85aryhqWMPOcRf3nOilax6NpK5K?=
 =?us-ascii?Q?NzhRxuXMQmtAvPHaGV4VgmI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4e8627-6d1a-4b41-f0dd-08d9b46fa41e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 02:09:43.5837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2cN299zZ8878M5pN29QXEeoXYO+ZR9nHLUeksenLWFEfVKNu6DFShBVAhcadINoe7uA9/e5+GG+mLwlwDeCgEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3203
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, November 30, 2021 7:43 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Felipe Balbi <balbi@kernel.org>; Joel Stanley <joel@jms.id.au>; Andre=
w
> Jeffery <andrew@aj.id.au>; Cai Huoqing <caihuoqing@baidu.com>; Tao Ren
> <rentao.bupt@gmail.com>; Julia Lawall <julia.lawall@inria.fr>; kernel tes=
t
> robot <lkp@intel.com>; Sasha Levin <sashal@kernel.org>;
> linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org;
> benh@kernel.crashing.org; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
>=20
> On Tue, Nov 30, 2021 at 07:38:44PM +0800, Neal Liu wrote:
> > +Ben.
> > ---
> >
> > Support qualifier descriptor to pass USB30CV compliance test.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > ---
>=20
> The way you wrote this means that everything below the first --- line wil=
l be cut
> off if it were to be applied.
>=20
> That is not what you want.
>=20
> Please fix.
>=20
> thanks,
>=20
> greg k-h

Yes, I'll fix it. Thanks

-Neal
