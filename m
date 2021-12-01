Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4296C46472F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 07:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346945AbhLAGep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 01:34:45 -0500
Received: from mail-eopbgr1300120.outbound.protection.outlook.com ([40.107.130.120]:10932
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231871AbhLAGen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 01:34:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7t7hC7itr5QqSt7E0+aPqMtEt232QhjdGmqrQomUgJJSDfvzCsDvNBDSYLqg5/Ivu09tFfDjb+2OLERx9tuvFzTdJ6xEltEFRWonbDNEwCmZ9XXi8m9Pkdd5vUF1CkmWDj72YSyA3nwhu9IdQ7zwRLfSN67HFZgMPXZ03oxLGboI//3cKi+ks9k5Cf1W9L1F44ESMyGsDTQ3BFBkJ01cmb+KlpDFBxWLzPLrvjwp6H7Lo+CPCf3r2tdWrQ5tY+lDv3ztc+9HG2ObSEDmDS2YrCjqfe/RwW/M4N08jP927iqfJh7fXbwiwQHVmxPUSGSMzJQBYQIKIUuy6p/kNRFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VN2ZaU4W4pt/Pt+2EbW8bAoxJ2c2FY9iWp8OS6IIbH0=;
 b=mk0o0gQzcLviKmnO87bb+HpCIK04reNWVo8YTKLNJ5gKh5HNh/zw8e4pk/nHp5wLNHuAe0/d8ncRrYYmI108Nzwrhd6WWjUG9HI7/GXG16+9+bnW5GIrKY5XOkPNqb001ZElF1BePHFbuXfV1bJkOohXBmCEyIMjqsnRvEeOIosB30nlOAfMriFoKlL1WqEtGkKyCa6NG86ysnxPk+wRcb3MMtigu6Hk+IB2urj/h63lSwXL/7KEBUWp1xfYu/DSFKqebtqCBwPkt/zhJmRJE0v5mMbYiLzCIv8xrBwShoRKcNwj0bYVbRFe8GWAPlEUq0xSE4CynAJESwTDEc+1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VN2ZaU4W4pt/Pt+2EbW8bAoxJ2c2FY9iWp8OS6IIbH0=;
 b=K2shk0sNGYONCG3Z3zJ/ies6Amg4ZxLO35hL/wkMuLgm7th8XYUI/ZBzFtGzYfAWKJ2dmvamS1f9nYoUkPkJQK/0oMfgntEs1RSsUdVUEFMvFSWbfthxTJ3YYi9y4b5syslD8jimuCa4lPubCIiUV771sSZACuZ8Fyku12ntRQdqVUPVAT7XOpv0PwSYSALTzFc0sAMBSYPVy13lzesFmkcf+dDYXBHMTPglsxzIF48+Cbobu5VxrBSlU1E+857lVDpHlaKB2+CnkSH7NqTLNHoyZqE3uLca3FgODRYU8uUGa4EPUoHUzdYreW82+JDpjzWrvQ+uHep7kolw1rfpaQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK2PR06MB3313.apcprd06.prod.outlook.com (2603:1096:202:3c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 06:31:21 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209%6]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 06:31:21 +0000
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
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
Thread-Topic: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
Thread-Index: AQHX5dcPGG2zpqcQlU+Dys+5o778UKwb870AgAEqPKCAAAzIAIAAA5FA
Date:   Wed, 1 Dec 2021 06:31:21 +0000
Message-ID: <HK0PR06MB3202BD13E356FA86B1A5CAEE80689@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211130104256.3106797-1-neal_liu@aspeedtech.com>
 <20211130104256.3106797-2-neal_liu@aspeedtech.com>
 <YaYOvgCaO4FJ8r+z@kroah.com>
 <HK0PR06MB3202436CA49363FD3F60212380689@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <YacTpI7k5gTDQ4Ki@kroah.com>
In-Reply-To: <YacTpI7k5gTDQ4Ki@kroah.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a123f79-14d0-48db-063e-08d9b49430ab
x-ms-traffictypediagnostic: HK2PR06MB3313:
x-microsoft-antispam-prvs: <HK2PR06MB3313C132F16B63561A6579E980689@HK2PR06MB3313.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f1BWw0JkvNFUy769l6NUruHRvi/f+bZTENIU8R6Hxl7wxL9acRTlRj8CeOYy3KT5o7w7UTDz0hTzUStPIkm0RLxslxRttqx94TorDih8YzwBGQTuRdN7VHeNjUtmTGb48o8MPob57Q2T99v2LcJ/+1InL+JGuCyC6Bnk9wg5n4lSrbYaH9WHI3ySHpmIQuJOZYZrGeLWzlLgTl+5UH8MZTzsjoQwL5aT+A43HsxFLn3H4QuyRoTAXVZXxEoncxsvxbyroeJo547z/FiLW7zfiPy86/8FWMuWO4qoNJeE/2vwfyI2JEh++KSTzDsrVDx/Mrwe9GBS3dGp3Tm1dLldCRU4GqcunGDAcC7aRqDdfbMeXnr8ggwg+S/oe3RE0WuNSyxtB6za7OzFGl+09AolZ+PY+umXE6AzD3Adxn7CpEiBYuhoPc3z2H0UG44nFkHAgGXEVLW/ZmXiO5P2WHx3WCr4CLFZfexd8PsAzbjKfOMWesCV0W2RGY+k80aEo0SYbDaf8OIeRWcQDxXTtnWQu1Gev9u15Q3zrgQG9K8i18kRMHatWgDPlBSOUiwGbPK7QK2+QsA/fFK46iloMYpDZF7C4pCi8aLvYokmhEO0wb3Z1BXR96iyX/vjL+Qzck2bxOMDIoYly9ie46LAUhEIhmH9LSSlZks5YFOtFVcagpvVRf8xaPM6ohmsA74quzhr5m/1pyAj5heHkjacuusRkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(136003)(39840400004)(396003)(83380400001)(186003)(508600001)(33656002)(53546011)(38100700002)(26005)(8676002)(6506007)(4326008)(7696005)(66556008)(122000001)(107886003)(64756008)(5660300002)(52536014)(55016003)(316002)(8936002)(66476007)(38070700005)(6916009)(66446008)(54906003)(66946007)(76116006)(9686003)(71200400001)(86362001)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EALA97irrT8yS+JKoH8s1rkl+3C/Mp6eMi2srlqbUNyRARBiht4/QMCXeDmn?=
 =?us-ascii?Q?6eIRRiFyFrx2E4GsS/ER2JZGy/bzMNPv/kd832/JL6KpRj5VE1EyJEW/ioDI?=
 =?us-ascii?Q?l4ZNr1L10rtDkSSoksaVxxB4xQbaHHfVs6RaYJn3c1/yYKpL2Go9TfokcAeB?=
 =?us-ascii?Q?/NHvmoEMUdwUdfgYuEZ6Yb6e0jZtoHUaTLU+VZEjh7Nv1qLwtw5g+ZMgHf2f?=
 =?us-ascii?Q?mr794tTr0sFOjoZ7qfKHbWKhJX5Boo2BZ1KqMkuvexvCzdLeIi908YNRcpEP?=
 =?us-ascii?Q?rxZkt8+GNvDYMk7/4yr2DAA6Ez3TKnz/MFszCxM3ZSN/2yWCwTohnF6FgX9a?=
 =?us-ascii?Q?2j6YUL2RMqmMFngYFZcSp3vSnpqoqrQK1ha1Q3IGccCzMeBS9KOquNZmdF6V?=
 =?us-ascii?Q?G8sxFkC7eXdqGuBfy6YDQuySrd2l+7Ro3OCRYjfQ/rnveDTdMJbHP3pTqYDE?=
 =?us-ascii?Q?CWufXEd0XS9ZGv2BzcqUpJjd5M2FVckyMqlgDoGWU/WEBNRL8dy0WLT/Cq6X?=
 =?us-ascii?Q?HpJbT0nSSPHlQfTzQ6/YAYwg4S62jFEU+uBDwjTmSVo76A7ykFELUjkX1VHj?=
 =?us-ascii?Q?T03lhDlybz3EKtddxH93sZZ2PuKUx8pWVup+wWXJdV9v/TwZ59HLXbA/zDqG?=
 =?us-ascii?Q?OojRNYBTATLCkHgEo/biavWW5oSLt41Lf+ftjKdrnl9Fn1xRbxAlqS7TcxZg?=
 =?us-ascii?Q?U8ip8iiQLE/mjprGHD/nBs1/XdQWIXl+AWkHNLPBbAY/kA9uevL/tWPnkeyU?=
 =?us-ascii?Q?mbm+H5a4evBfp+EfH4HjLiwb/Y9X+CQpsCbV7tqrDM6UOf/1MaGlVW3/tm2f?=
 =?us-ascii?Q?07TjR9ImFEOEsW8kF+4DhljYgA28EuFXN+yV920MdnRXowARM7hX+8lBzwY3?=
 =?us-ascii?Q?0EloEu0+4N9YbAx85yU9cGCEXkCcrGs875KtpG9Exi7Wc5jfP2L9FfI401cE?=
 =?us-ascii?Q?jkX4coOnzyDhFb2wULjfFiB9zrlA6sUiW5rXHOuIKFZsaKFRZLNsN8uMvdlf?=
 =?us-ascii?Q?aerg6KYMvJAElVmxiQHQyRrp/c2iUtr8nTnkFjqdZEdssaSkwpWIWOphD3pF?=
 =?us-ascii?Q?N58utXs8LsqDDlz3xk7/6ATNfMjodBEH1rGuEX8teBLlkcpG9bksY7EOILO8?=
 =?us-ascii?Q?L13uK2NA0T5iyysZ+C0r/6pywxqi76jv+NAVlBGjEl2ZPE0oP78gvjbnxZH3?=
 =?us-ascii?Q?i7J66ePGMatQNTrnGDrJXEEJx7ngLafBos+c505Q2/i2fQBmzUfdvZPoXGBB?=
 =?us-ascii?Q?hLDfRUDKEbTW0KEzGRbFh1zWBfRvgu1FdH7cm2oTkvMQSDAnDZjPzBu2tNU9?=
 =?us-ascii?Q?WQeMt/n0chDkNX2zU/qHQrLYKzmfwYj1+rxWomtOosnbiFtIlmf4xXyual/n?=
 =?us-ascii?Q?xPPHe/I/7pZPdmhm9VbOfbHewreW13eTrpLj/lEZumBLR7PxGtI1124xQRmJ?=
 =?us-ascii?Q?3nxyzCKD8G4gyPDjKbahjQvy4nRskdc/wYSclsGHnYl6sw7FmyG/2TnPir2/?=
 =?us-ascii?Q?jbjdMnB3UZBE/xq6BgFSgNe0I8bZ+odCrHp0CcBWaTkEMn7OgjMM/dygkWmJ?=
 =?us-ascii?Q?PAwp2a/c0sgZXpV3SOZf1Ul0ILMTOhBRuTcpYNJ2XDPm49NI9eltdf/fskGt?=
 =?us-ascii?Q?MCifwCIX4TLmb0lF+sdZsCk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a123f79-14d0-48db-063e-08d9b49430ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 06:31:21.2540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 20ki/bk3XifStUVxMVfI6ly9YzRWpmmSGzhIYsKz923K0nW+2oIV7MR06RaJbUkmP9fNiTN/BxVSqvBtPuliBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR06MB3313
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Wednesday, December 1, 2021 2:18 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Felipe Balbi <balbi@kernel.org>; Joel Stanley <joel@jms.id.au>; Andre=
w
> Jeffery <andrew@aj.id.au>; Cai Huoqing <caihuoqing@baidu.com>; Tao Ren
> <rentao.bupt@gmail.com>; Julia Lawall <julia.lawall@inria.fr>; kernel tes=
t
> robot <lkp@intel.com>; Sasha Levin <sashal@kernel.org>;
> linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org; BMC-=
SW
> <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
>=20
> On Wed, Dec 01, 2021 at 05:43:16AM +0000, Neal Liu wrote:
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: Tuesday, November 30, 2021 7:45 PM
> > > To: Neal Liu <neal_liu@aspeedtech.com>
> > > Cc: Felipe Balbi <balbi@kernel.org>; Joel Stanley <joel@jms.id.au>;
> > > Andrew Jeffery <andrew@aj.id.au>; Cai Huoqing
> > > <caihuoqing@baidu.com>; Tao Ren <rentao.bupt@gmail.com>; Julia
> > > Lawall <julia.lawall@inria.fr>; kernel test robot <lkp@intel.com>;
> > > Sasha Levin <sashal@kernel.org>; linux-usb@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > linux-aspeed@lists.ozlabs.org; BMC-SW <BMC-SW@aspeedtech.com>
> > > Subject: Re: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier
> > > descriptor
> > >
> > > On Tue, Nov 30, 2021 at 06:42:53PM +0800, Neal Liu wrote:
> > > > Support qualifier descriptor to pass USB30CV compliance test.
> > >
> > > Please provide more information here in this description.  This does
> > > not explain what is happening here very well.
> > >
> > > Also, what is "USB30CV"?
> > >
> >
> > USB 3 Command Verifier (USB3CV) is the official tool for USB 3 Hub and
> Device Framework testing.
> > The USB3CV tool includes the xHCI Compliance Drivers for use with the
> USB3CV.
>=20
> Please put that information in the changelog text.
>=20
> > We would like to pass USB3CV - Chapter 9 Test [USB 2 devices] - Device
> Qualifier Tests.
> > A high-speed capable device that has different device information for
> > full-speed and high-speed must have a Device Qualifier Descriptor.
> > This patch is to support device qualifier, and the host will retrieve i=
t through
> Get Descriptor request.
>=20
> Again, this type of information needs to go into the changelog text.
>=20
> thanks,
>=20
> greg k-h

Okay, I'll put it in next patch. Thanks

-Neal
