Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804F946E0F6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhLICnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:43:33 -0500
Received: from mail-psaapc01on2123.outbound.protection.outlook.com ([40.107.255.123]:20448
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230007AbhLICnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:43:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWNzBGH3VuOxkzZS5iZB65qFQevouAgcGLdKxNXx85E2HSLm4YFVkB6FPLn24yqkAWiaUQbYjCj5etpKUoDzKJfur5+QUL5sKFqdXjZtsSEh22+iBHf+cyrkylLd+YHkqe7/tDGdQWeYc+XUB2CBA4Ue75OdAAJHbzkW9iAEo/kobr6btHGxYD6nlOpzDAPjrEr6sqHbkHTA8Om3FBma4yVg+Fg/H793Lm/4Px+HEhnejhsR+37vCB0zjwOBLa07IxUOD85XpWI+GqRJWdwfwln8LSsJY0jaNIcQ1wYZjbAxrT4/bOHT0eNTBlilvpuQHEewcYHRL/g4g7VopopeDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2sa1Ke1+pqEKZXRsv0aURMvivCxznlmM9PV6JrdYhk=;
 b=QcJs7bi/w7qPhF8XW21ipBBPDyzuV5kf1rFzR3Cn5Qmgq31jfiWBhZw1XmhrLRakBojyL0LYCvbJHjpj6mQfiqKiXpKhmUMsJ5DfgoGCcmBxILhu0nwHKIH6BhFEtnnJX7GC7wsfG2bM9YtBYUNsF1FRYDgQpGWcrl6FuFhsmmIdEXtTfR0lGXm/+ccx2D2VbWR9w3myl2Kno9Fr+uchDFPOXXYIRS6IDem0DzXtM7yABEaW5HShVwJRXr3P9viVJzj8bKhW/Gwax8+c8aALa8Yoq1Gdd4RySXptVhJX+a6JW4QsNGoQhXRbPHTxEfI/OsnMbeGG09j9RwCNldHjbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2sa1Ke1+pqEKZXRsv0aURMvivCxznlmM9PV6JrdYhk=;
 b=H8ZN5MgmEvKhswEJF3aSUvVoGcHUehBBHPUyqNZ8phSMyleQv+dexl1Q8P1psGHvgiaqPhLeASN2oDk7yFtpr5ZaCGWiUWRLmZn2gr+wN/rNFmKYBALjGUpog2oze/V1s1cGc0RAEJa91lOv+I+kLvVSx30IHUIlTk+5Fce6bdrZ6sN23FptUE5PWfaUBRKzPVpK6gh2j35Nq8p/g8G2iPWwVXjEgaxSouGQkDcbBk29iAjLDntoE4Nlr06mEDUI/QZvNpTMBUTqXt02ie6rHKweB6THau2Ue1tekHrv8jHZ75fMkhv69F/3/n9HOswhfgTkmsrIz2/Gl1CEnHUylQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK0PR06MB3651.apcprd06.prod.outlook.com (2603:1096:203:b5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 9 Dec
 2021 02:39:46 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::6d89:70e9:fcfe:e126]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::6d89:70e9:fcfe:e126%4]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 02:39:46 +0000
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
Subject: RE: [PATCH v3 0/4] Refactor Aspeed USB vhub driver
Thread-Topic: [PATCH v3 0/4] Refactor Aspeed USB vhub driver
Thread-Index: AQHX7Bsxq+D0fA8gh0SvDC59T4yTsawohBoAgADvPhA=
Date:   Thu, 9 Dec 2021 02:39:46 +0000
Message-ID: <HK0PR06MB3202D7AB1492C2DD542FD75180709@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
 <YbCjVqAie/d84oBm@kroah.com>
In-Reply-To: <YbCjVqAie/d84oBm@kroah.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c24d31a-4be0-4d41-814f-08d9babd29d3
x-ms-traffictypediagnostic: HK0PR06MB3651:EE_
x-microsoft-antispam-prvs: <HK0PR06MB3651715C487FD06146F82CA980709@HK0PR06MB3651.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MR2pKH6bEDVgutTXNJDtzmxG4NUSNPPGNKwUrst12c/JVXpST1QkDYpPYBVjwCThubBsNcmi5rmkIEPyT4po+bF97XqLeYq5iRmud+yL/PEcWbvh2hghL40QXjUbd3eTNuS/ALfKYcIBU1p9AyTfMfvWnjSmB/w+xfenwWaL9M2baK5Msul1UlfcSUdr6BtRkuEtfOq+qfUjzxt53K+MocM0Fu2X07F7XKxbdIbtl9OC0Xba7KTxQJc36JLQdvj7iBNx/zVj0qiyeVI0gfgR2iL1xKbhjJYQShDQ/iI9TqYIQnGW9Ybc8od+KGD+gZWTy+GFZL8iE5qWpqx5xfYPacYW6VH9nczL92NHFuIw+QBzbj8XiabtxpiAnesY0VxT2YOA5lcfGNE4Aj6g4XX8socfcQvdrhivJ81cj9LZQbdKnMUGkD4BIBT0rpVblCa3ZMr3ZCV2R2RgJwAcjFomwPHv8AJdlhWQnsGAOk44mFO1W3OWZetZWJ48/0saYXROPAYLewO6O0MwLKZGUVhSyZiOiOkoRg1aw3ZRxErpTkCC0IHhlRH86zOlOn+t5KzklwKdvlEDu9bgSrZY2QGVwRBmSIiVRDBvGN4ZmZDbQQJ5ExtI4BBzqSlC9aKYzzDR66BpSNFGgunEtsK8AI9aI1xuvQ7lxk5aZ0KIC5heDZqTPoaesQCn32NS0qUSPgAuFIIXLDEsCdvLIy+zdv8Jgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(136003)(39850400004)(66556008)(71200400001)(6916009)(76116006)(316002)(5660300002)(55016003)(66946007)(83380400001)(66446008)(33656002)(7696005)(9686003)(66476007)(64756008)(7416002)(54906003)(86362001)(4326008)(2906002)(107886003)(53546011)(38070700005)(38100700002)(122000001)(508600001)(8676002)(26005)(8936002)(52536014)(6506007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Et82iycdc/+T3uT00BzZR+515JPq0JSysyzzandewR+Qp8adBdZjzI6DeYC3?=
 =?us-ascii?Q?XtoEmS/KsjB6FYY+x9lX9ZhJnmoxxRrJQ9Cp7uJtuSx/6ZS6R8sTQl5OwauJ?=
 =?us-ascii?Q?A8maeO+50+XXCGth2M+adabRZ5CLFxaOXnvqbH/oVQ179qvLBanryBJBylBt?=
 =?us-ascii?Q?04IeUtiTrc80X/p7yKmUT2btrDiYqGM5C+smvY3dnmcgOOO2ILSCL9nZhPuy?=
 =?us-ascii?Q?VkJ4EJojn3KFv1CGZ/Z1WuRMzBgwfQWKvGlT0In69ia5syBEoL9zP5Hc2JrW?=
 =?us-ascii?Q?RFqzeAEX7F/UybS8EFBIqik4Xg3mUMkd4z3+Bf0k1TvCuxugB0iG6Swezf7u?=
 =?us-ascii?Q?Y196Y743moBQHWkpYnI/buaAVtxnTwIkSZlNFus2381j6uHO291btG4Zfmdi?=
 =?us-ascii?Q?uAgF1VpmmN1K9PkOwcfj/tB+w7GhACSLUENm6Hqzre2Wvt+hBK0+sWweIzZR?=
 =?us-ascii?Q?5Jeek2zcQzd/TDQup5sjo/0UwzaRIq/ak7R6FFWezndBu9DxyCI9OCdlnWsm?=
 =?us-ascii?Q?o4JDI/ELwStXtsm0DVd6sSwMpnlXQkjHgyiMZc5jObCJIRQNFzXS/wPX9Zkk?=
 =?us-ascii?Q?3uCQAc/Uw+Q13repqwHky6IPkkDTDsjVrE33WKtSVKOUNaF6iypITXlM23d4?=
 =?us-ascii?Q?RWJGf+TVqZz62pBUJKLutB7cdxV3DbWSIyF2NuhGr/Iqv9yF23j2fIbJaRWf?=
 =?us-ascii?Q?z9fSBtnJqImwpwt2E2ouLBPRhXB4/hKhNunz/dhz6p+ZzSeS6+ZyoihRB3vo?=
 =?us-ascii?Q?c+NYv+5pGuH24ZOBx6F6JJTabFc4BH/fT+KP966OQ3EvcdG16e+ODBjkC6Oe?=
 =?us-ascii?Q?2rsxo3Qbm2yJYYpRhY6OllNvPFHk8JMTzbrnJeOHqhhfbWY3CoFDffMPpXWN?=
 =?us-ascii?Q?fRWPzNXrw0DtBn/OAktV1AnyuJC+WDZ/gS4L1zEdHtiWhll7z9AwjX8ufgRl?=
 =?us-ascii?Q?t2nTAzEkWFyu1/qQPjVxpCmYvNQKuaH4lYTgDeJH5gr8BYaD5kbPmhMw087G?=
 =?us-ascii?Q?fwNiL4PS4lJbdO9X/3BooA0PWYkBGHcu7gguGPKCkpHN2uLBnrtCIZzmhU7m?=
 =?us-ascii?Q?rAct3rPPoxhhR0WMMz9JM8axl96JBJJtsnqOR2L1nDEl5uZxCMW/8DZ/W5Uf?=
 =?us-ascii?Q?xjrzUkeUD2Nb7nvMpNzLlw7SUYfrEXdEi+P25/9KDkAVtpw9LCUy/q8oEBbo?=
 =?us-ascii?Q?xoKYhMLi/4pvnX5HvGM6ujyT0ilpBbhPQ8B6V3Z56QdesjDxAoRV14XY4CQT?=
 =?us-ascii?Q?wOqD7E4F0rtgbwnIMO0WINIua9lqpDE9u7UfEmBl26eM/SN3sdVAFvI0zX7q?=
 =?us-ascii?Q?GS0RNWT9RSFtIzuzkERjoWyEoAVnxNLnFpbVb+asMH8YK2G0JuZdrGezaugW?=
 =?us-ascii?Q?z2zIseys2VWw1bq+RMl7Yw6t8jZxMLWPDZ7c/r5SPlNTB6tU7Fd2pMC4GA0Y?=
 =?us-ascii?Q?ZRFMBVyO2Et0KUYVRKimAKYt7A5aifx8B3oWR6h2R11E91wZ2JpJX1N0JT57?=
 =?us-ascii?Q?u1fq1nL0a/Q8d4v6nBIaZj/cNhpQE3lqlqQmMsS1BH2D95uBn+sWFLJP39Yp?=
 =?us-ascii?Q?PUHLvjz1cMVlyNPDzZrNFuLkeNTsyYeH3e/+5buRcZFYDjjVGbaZDzgFGzy2?=
 =?us-ascii?Q?ZO7Nf8OilLkudRMHlJvekaM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c24d31a-4be0-4d41-814f-08d9babd29d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 02:39:46.1229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LK5kYtHvBut2dq4OFHQIrFBZS+oBSh8ST82/AWiQRxDsHP827HMzfzOWMIUaFHgUdSywFyMjRMsD/SS/ai+8ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3651
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Wednesday, December 8, 2021 8:22 PM
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
> Subject: Re: [PATCH v3 0/4] Refactor Aspeed USB vhub driver
>=20
> On Wed, Dec 08, 2021 at 06:05:41PM +0800, Neal Liu wrote:
> > These patch series include 2 parts. One is adding more features to
> > pass USB30CV compliance test, the other is fixing hw issues.
> > More detail descriptions are included below patchsets.
> >
> > Change since v2:
> > - Add more description in changelog.
> > - Fix remote wakeup issue patch and make it more configurable.
> >
> > Change since v1:
> > - Remove unnecessary configs for SET_CONFIGURATION.
> > - Separate supporting test mode to new patch.
> >
> > *** BLURB HERE ***
>=20
> Blurb is missing :(

I would remove this comment if new patch is necessary.
Thanks

-Neal
