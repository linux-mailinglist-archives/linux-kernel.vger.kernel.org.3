Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1862A46602C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346014AbhLBJN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:13:28 -0500
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:61153
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240990AbhLBJN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:13:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoOVTihw6++h/vjlhyD6zXFzDVS8MluD3N0bLlM5YU/FLra9PKyvaWinwCC4Q8AxOOuU7z/Thrf9AtoyHmsfDyY3dFHJ9wPXsF7Xdv9h24ASWqMToRbb6xd/ifjbMzv6SkKCrIGBALJp2v+vmGJ+QHP90crxqRCHQk4bkq726S30zrPCELiMFceboYaNrBiVXY7yHhOMTKmwdeLZnO73tXcQxYG0kkAsE0kA+idIOadmo0KJd0Rq0tni3yJ9Mam1pkVFgzSGvcNTo/7wXJBozaX/de4UcVvUQXgIQiUmRI9uZtJ5nKuTCknZJLqIOEGhPxkc5XJaLSKKCO3eTU9CHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AEWuV9OqALxtKGafvvmuWBT694n074L5gTembkazGU=;
 b=KhwUqQCHFYp7i3De3Z+BQi9nN3XqBwHAnrLbVmDERVQI9DDd/olsPCmZF9vc9f6QoK9XM87qXQi3QAcAe6jS0CrJvH+UgTCYxwWAKIc0TC+r7FwQqAKTNtI2Pt4y+VLp2gM7kUX6RGzJLOLjRqCTdo9enbhDmHkjnaLWSTqTuqKINIw9gCQdcJQEytZFBWTTRfYY6QPYLgAsVzxS4HGg4TVlPFXAiVNB+G1XCBZKksjDveJXjGwF3ylFutDrpm4Ak4SFeC/cDhUMqSP6NHxU773sh5cnltzoNuYoHi7n3ksLbU4GzYXosY2C7+KN+MTw99nvHZZaiJXoQb/esK9+/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AEWuV9OqALxtKGafvvmuWBT694n074L5gTembkazGU=;
 b=LD3zD0PUlla2BdVXWiU4lS1m9GZXqo5iSUwEMTqFdacQohs48njvK6VrhQ+MzuiPowlRCV3bX1FjzJ98GFylkiFTPM5c+cWPypF1FSGmi8E1XrBoUl/nSK7bmX4QQPXjbAHh8P2k5D8NY7GTGl+q/Y6YvkShqN2g9JGi48VMYSA=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by BYAPR02MB4632.namprd02.prod.outlook.com (2603:10b6:a03:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 2 Dec
 2021 09:10:02 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::8151:8728:8d6b:c3dc]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::8151:8728:8d6b:c3dc%5]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 09:10:02 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
Subject: RE: [PATCH v11 1/5] device property: Add fwnode_iomap()
Thread-Topic: [PATCH v11 1/5] device property: Add fwnode_iomap()
Thread-Index: AQHX4YZBUvFrfnFzmkK2bRDvVWcrV6wUH/KAgAgekICAArbIYA==
Date:   Thu, 2 Dec 2021 09:10:02 +0000
Message-ID: <BY5PR02MB6916F7BC6ACE5326DB92DB2BA9699@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211124225407.17793-1-anand.ashok.dumbre@xilinx.com>
 <20211124225407.17793-2-anand.ashok.dumbre@xilinx.com>
 <YZ92mTURrFWZPUXp@smile.fi.intel.com>
 <DM6PR02MB69236DAEBED675DB929BB8ACA9679@DM6PR02MB6923.namprd02.prod.outlook.com>
In-Reply-To: <DM6PR02MB69236DAEBED675DB929BB8ACA9679@DM6PR02MB6923.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d6e5f26-b8a1-45c7-5e73-08d9b5738625
x-ms-traffictypediagnostic: BYAPR02MB4632:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB4632CF5EDE3C66C374B0530BA9699@BYAPR02MB4632.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PEZrSwlk3ZWMs5EV3YJXxAEvLFsV/jazpF5YJYhbJuYBd6xkXL0kU/fh9e/5f0bcm70rEcDZ88BD05dxnjJOMc64evchEpzSGrqll/Zn5yo9PzZe0Fvg03MmgTWvGYh7rlmqyS/3oVIiH9F3/X4JSi32D5vmCylSDaRPtXtlPubt9nvy16YP4AFlsLLWbhDFZXTldCRfenm6x5SDO7ck7G9iwdXKS1cdsRbsJUiHtUI4ybO3kUvsRnWGL3UL4jenx59xTyo/1jaL2QXlggqJjrxKIryKUsUO1PkTHWf9Mxe8f4gxMTnvHZpg++tss70HfKLCtTvR8UknvvERP6ryHTImjd81nFW6lQDw6NNDPSk6TtxKQprTj2VtLK81kbArEGeF5g7TJZHHhVm0bBv3ZBbfDMLkdFU9Xx5AbJVsBqkQc4ir6A/aqMwK1Joc3Uhd7m9oYJg5r4LiNoAtliAFe6RAGezCwozC1ZPd91dn4DhkpiO75MfbHWSXAILyaBBliEWNqVnAuDAG7OiPeF0nYPMgWXJdTaH7knxavKm0jOhpwVWK5kmQ/56XowPlHOaxuU+JZDDJfGzdTxh7FnXlDhlCsSwym+Ax1CvuEWjLz7stmyDgYyDUME6gu0z6T6cYCQfqxe4RBOXFh0pBrtgq+ZhQGCos1XEBySWWPpzQ/lhbRJNfGlK8WiYGDsHTfG8uWtEGYmXiUuPNlaZvyP1Jpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(38070700005)(66446008)(38100700002)(122000001)(33656002)(316002)(8676002)(6916009)(66946007)(66476007)(64756008)(8936002)(66556008)(7696005)(2906002)(54906003)(76116006)(55016003)(53546011)(26005)(186003)(9686003)(86362001)(71200400001)(4326008)(7416002)(52536014)(6506007)(508600001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p3WYWkl301AWsNNZ1kZi6+660gNPx+Q4pJeWcatJZwixMYsvHPWDtiI8m/Z/?=
 =?us-ascii?Q?5MAZDhuQraGts82AGUeF65QkId2v0yGIhFp5tgOQ3vFm897fg0wHvTtJWgPA?=
 =?us-ascii?Q?nsoBWm6w+gDv/5QirxAjKt3zcC8E2xC7U32DMpbcHohT13GEHEFzC0M7NjcJ?=
 =?us-ascii?Q?AeUqoOJSFnH4wFFsEDDKaLCZlPNDq2y4VH6Blg0RheU9SbtXM3R0RpcNb5xV?=
 =?us-ascii?Q?5/8I26KmIKMl0Lkzri46JkBDZOKVDvW/tYMcAHSUkOfuDZZ122d2KApybb1E?=
 =?us-ascii?Q?0k4QvzOJiTJBVFJKJ47XCFEpSHjbSO+WW5GLe8s7sY1pHCRNp0kFfukNQ33z?=
 =?us-ascii?Q?0AOOFQXIkNcFvHR8gx5o6IQlbPFvaitQlsEHK1sEdvQtWjQ6qOYjBQI0OU/7?=
 =?us-ascii?Q?p0G2KsuZLwkkQdPEiBfvlNvCnQ/w01kzdxmKOdeAhFD93CNxnFxdjCizMYpi?=
 =?us-ascii?Q?oC0EsSrA9jpxdaGha7w4Sw9l8DiRQNh8tJjSXPihNUUV4deleP3ZZ5wwPx2v?=
 =?us-ascii?Q?ssqJzj0jj3LSv3lvbwf0OC9Xpimd+I9gkWN8nb+PnbL/Zbz3DQCPtoRUwPRU?=
 =?us-ascii?Q?IqLdq+bVrNIIDcLpuAOJOBVT2JhFprylq23kMP4HQrZQo3JKEkeCnOad+hpG?=
 =?us-ascii?Q?dXcrh0GG0IVi/izq++wxEsoaAEZV20ukVQGQwyxaTxxUtr3806C8cbE3xF8x?=
 =?us-ascii?Q?o8QMJHSMJ0nyc9l9sk88bahHFap5Kkcyocr4dMpGnzyvHLzzDE58siLWRa7Q?=
 =?us-ascii?Q?igNYf4Mxjj1ma1clz7dwzPOkt/chNgxr3ntVIiVx60TKDbbeFgkDOTv05nkN?=
 =?us-ascii?Q?/Kn3GpcW2qjAxUL8NU4+RPhrbLZOlusyBoEc1MEkrn2uzZVfZjXZYP9GD5nN?=
 =?us-ascii?Q?S2S6mS8ZqQAiKe0B4baKB7oMhwHyAxiOfYOBBcZ36QB6BsWuwbIuu6fTJwcT?=
 =?us-ascii?Q?mmhzUUYZf2UszjpoG3FN098tJ6SH76Gb/YRx3STnQiq/xurhQKDfXhVplMga?=
 =?us-ascii?Q?RtVBQJW91qHbmPi3mLvQzWcvNglyGvT1edCAZ59Chp8lGtG2wtOzO2gGUzji?=
 =?us-ascii?Q?BFg/4mwmX2QFT1eDnvRSTCGQfOBUp4Rp5b0zUPi1KatTzLsimQ39tE/i5dDh?=
 =?us-ascii?Q?LBkboY6KYAOYuHjNZZuutCn3tS7Y0+o3Ls2qnIoxNuDyoZJ9fFMZcL3jMCq8?=
 =?us-ascii?Q?8oE2N4NZoMYgBYLM+xA4vYJAL24FZzQ4Hnvczw+bZKdxjr8aYT+lfeWGTg50?=
 =?us-ascii?Q?40+IEgYLMDtzuAWftjaCSVGJA2nUI9e4ttj1qGUac6pxykQPupjBG9htCDQq?=
 =?us-ascii?Q?BePeVh/Y0rnfzSrtVa1kOf4iChkuB3gkCIJjPvMrJ5X6JSl6acZY8irBE6U2?=
 =?us-ascii?Q?8zSPKZSsnzLaoJdEvvC4x8TAO999mNMqfx+bOtAihaYKUQzv76uEclBQSqSj?=
 =?us-ascii?Q?hYTlD3gLeirI/95ACMAdH/1dmNTh+JMcoM1PvAnAwi4fX8op+CMyUKS4663n?=
 =?us-ascii?Q?SNsmpBpWavwVkeyNVb9nEgt0hVGb9LoPcKMC7W+D63yJfZOkH2wUuzfiQEsz?=
 =?us-ascii?Q?dMJxmJOFwcpLoo+ZWyBcSTj+Sd2lSASTwtvM0iSqwPSni+KBI64FQzLigtGD?=
 =?us-ascii?Q?8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6e5f26-b8a1-45c7-5e73-08d9b5738625
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 09:10:02.5004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i0+efaiNs8JJvRNgy/wuq78UsNsiVaSLQjr/GNw97USRErjj16fuxQSzbQUOdaGYHOPAkQpLjz2KG0qosIjiTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4632
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

> -----Original Message-----
> From: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> Sent: Tuesday 30 November 2021 9:58 PM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-kernel@vger.kernel.org; jic23@kernel.org; lars@metafoo.de; linu=
x-
> iio@vger.kernel.org; git <git@xilinx.com>; Michal Simek
> <michals@xilinx.com>; gregkh@linuxfoundation.org; rafael@kernel.org;
> linux-acpi@vger.kernel.org; heikki.krogerus@linux.intel.com
> Subject: RE: [PATCH v11 1/5] device property: Add fwnode_iomap()
>=20
> Hi Andy,
>=20
> Thanks for the review.
>=20
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Thursday 25 November 2021 11:42 AM
> > To: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> > Cc: linux-kernel@vger.kernel.org; jic23@kernel.org; lars@metafoo.de;
> > linux- iio@vger.kernel.org; git <git@xilinx.com>; Michal Simek
> > <michals@xilinx.com>; gregkh@linuxfoundation.org; rafael@kernel.org;
> > linux-acpi@vger.kernel.org; heikki.krogerus@linux.intel.com
> > Subject: Re: [PATCH v11 1/5] device property: Add fwnode_iomap()
> >
> > On Wed, Nov 24, 2021 at 10:54:03PM +0000, Anand Ashok Dumbre wrote:
> > > This patch introduces a new helper routine - fwnode_iomap(), which
> > > allows to map the memory mapped IO for a given device node.
> > >
> > > This implementation does not cover the ACPI case and may be expanded
> > > in the future. The main purpose here is to be able to develop
> > > resource provider agnostic drivers.
> >
> > ...
> >
> > > +void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int
> > index) {
> >
> > > +	if (is_of_node(fwnode))
> > > +		return of_iomap(to_of_node(fwnode), index);
> >
> > It seems this part should be wrapped in some ifdeffery according to
> > kbuild bot report.
>=20
> I see that of_iomap is wrapped in #ifdef I will fix that and send a new p=
atch.

I am unable to reproduce the conditions for the error shown by the kernel b=
ot.
Not sure if I am doing something wrong. Any help/suggestion would be apprec=
iated to fix this issue.

>=20
> >
> > > +	return NULL;
> > > +}
> > > +EXPORT_SYMBOL(fwnode_iomap);
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
>=20
> Thanks,
> Anand

Thanks and Regards,
Anand
