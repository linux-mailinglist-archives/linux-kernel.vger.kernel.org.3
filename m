Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D213E4640D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhK3WBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:01:38 -0500
Received: from mail-co1nam11on2080.outbound.protection.outlook.com ([40.107.220.80]:28769
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232274AbhK3WBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:01:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5kjWpvk0uSyELEYUhJIBjY2ejh5pPSRd1uaqssjOXussXk6Vxs2zGqrmH9mKCfUWuTj4qvUJI4CxwPwx1yf0M4CObP/Qr69yLbEO/j5sGLk+F+ZfIvl5Z53OEr7ZPVeGgvgsfJHgNsIg49b1AuN4Ane8mJh8rFeGfaBebng29VWY5pmMjGdVw8Ortptsaplc0oPY6EjHC7zyeOHPeTUOHjYYOXr4z/3S0sRUjiFNlhs4UufyNBQ46ATd0vg10papVFWJNUmPH3bSfKPpvayYSxJetvKLuC98ECgzKZ7Z91CTrlp2OZPx6oi8xAkSCnJ35n6wEchkwIfd6xppbrq5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41L+oHJUI6EJyRhRStEUYbgsCHDhWu4KmpJIArfBKp4=;
 b=b2QM2Lx7u2Mld3JMfDhHGwAOKEOoSW8Q7v+BGVh4hR8PEpHv35sdI6a0ug+cjVNtvUBh6RF1zA/l5rbFN0k6jtqFeSWHcWjfumty0HpSm5D0DzojkH4iyrREk2BKPiaxUul9yJrkZbXwBAqjRjNRqTtUChP3gcinS72MFYYPEr/X/MuxB0qsqtrQQwuxsJZafW0Q/lBNG0vhnOL47zQR9jmRS7aUPYp2YqZBe8T82vYOZH6c+ofn+QxG4y23BhVod+52/wze4Vhw594H+UIjchbFtIfMKfeNcMrO5cAubD98d+aFAdUCbgG0Y70FI80Trm9+ymEDU8rJEAj0tLJ9sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41L+oHJUI6EJyRhRStEUYbgsCHDhWu4KmpJIArfBKp4=;
 b=OCNlzfBE0zqtKPbTbTA3szgvOHRwo2VoR/SwD/IZhVtElrd1Tp28mQkygseobd817rEMctFvJUca/K+qBnGBIdGNhq9w3tX9HBTdij/OlmtARqm6hAtdDLCfXr+jF2HX0zlUBlw6yOuXqHvN9ddOV755PfQ/qguR98Wkp3OcSJc=
Received: from DM6PR02MB6923.namprd02.prod.outlook.com (2603:10b6:5:25e::8) by
 DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Tue, 30 Nov 2021 21:58:12 +0000
Received: from DM6PR02MB6923.namprd02.prod.outlook.com
 ([fe80::88ca:b598:cc07:bd0c]) by DM6PR02MB6923.namprd02.prod.outlook.com
 ([fe80::88ca:b598:cc07:bd0c%3]) with mapi id 15.20.4755.011; Tue, 30 Nov 2021
 21:58:12 +0000
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
Thread-Index: AQHX4YZBUvFrfnFzmkK2bRDvVWcrV6wUH/KAgAgekIA=
Date:   Tue, 30 Nov 2021 21:58:12 +0000
Message-ID: <DM6PR02MB69236DAEBED675DB929BB8ACA9679@DM6PR02MB6923.namprd02.prod.outlook.com>
References: <20211124225407.17793-1-anand.ashok.dumbre@xilinx.com>
 <20211124225407.17793-2-anand.ashok.dumbre@xilinx.com>
 <YZ92mTURrFWZPUXp@smile.fi.intel.com>
In-Reply-To: <YZ92mTURrFWZPUXp@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d786d7b-0e26-491b-f72d-08d9b44c8124
x-ms-traffictypediagnostic: DM6PR02MB5578:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB55787BE940FB9A6CB03F0C7DA9679@DM6PR02MB5578.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lz0qGCk1x/c0j5Xdqlx4+BflVGyjwlswgteImsXM/r++vOCzAtE9WkjVg2q1Ne+F+4sQNda9/a2b4OFJuFFXJT02BFlTcFylpfFTMVdyFMHTIyH46tDvMErVKQa5QNpvSmzuDM8Rb66IK9lIlLEaiwMGaa2ipcaVS1XSaWyz5rdmHwz/mZyWApHJ5v89qPLTlr76ptV9oDWc81rA41m+U2ZZRZHZp5onppDfvQWIazkH4mZXYOqxH9l67Iohrlqj0fDTK1EyHnqpqscU1jq104PiM41KaMCcJkBspkmFSGRBuz6bWFM2MDolZiCHJo0gNPnBSx2lMEuHynw9QXnpYamMYKbWZVDrPi0jE69yKueM+TDe4Tm9uqy0D23Ar0ISzUuaVfrSn4akuVPtR0Himl1HnApl9331sm+g1nuWgIiQ91xp3RWglp5ToXeBfRE30js46KLGT7wJwEDVU2I5C1ZU9Q8ksTe0VOF8cZZxtBI2rorssdd91Fj+Gj/mduSS/Jm6tWP7Oalu5Q16usL3Mo4BM8qARefWFiBSq77LZ0H/bheNPVdOkFNCJ1zSkrO2cr521grpY6evWuXQEHjvzpWi8XdYsQBTxlvZhOoUUFp5D+mrbADCJwkA7uyA4d65zqScqfASaU1iY4Kf+CLXj2fBACk2Q4a0uDVbcsA7qWiSQDc6bW822kE3t+sDw8bupjGUmeV62zshM77F2b2KBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB6923.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(83380400001)(6916009)(33656002)(71200400001)(53546011)(8936002)(86362001)(38100700002)(54906003)(508600001)(2906002)(55016003)(7696005)(9686003)(6506007)(66946007)(52536014)(7416002)(76116006)(5660300002)(186003)(26005)(66476007)(64756008)(38070700005)(4326008)(66556008)(316002)(66446008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vvo9xN9u4lUhLijBgmIGA+0xJPy2nPr3jhC6Pp1L/ihWFztkLSAOUKtPGmT8?=
 =?us-ascii?Q?GG30gXJzF0z7zdu9LwqthC9ZLEkarbo+CQJJj5j8Dmf5eYXuDVo2NoTJqavP?=
 =?us-ascii?Q?0LxwGgHXlGTnzk867HdpBK9E9WSwlQCOcR59DoO5RHJfs698FbhxRhXT8YbS?=
 =?us-ascii?Q?4WIsUNntB6E4+pbW5omFytNogDnU4iP3GabkxrjG0zg5TZ9ibovRW+1D+rj5?=
 =?us-ascii?Q?Q5ajPKjrQYJKQmSWERbOM8yygFZb1iAJW4tfXWiFPmHEDv04Bw57b4VsAsgf?=
 =?us-ascii?Q?kguQGn3M7uJmi8DoKg9o74vm0NXA8Pq1nt1pPgwd/87OGNZyrouFAws+hzyb?=
 =?us-ascii?Q?p7zqxrS1aINTwH5jKtJcQDUkxA/5yHjjrq8CI5OD892yhV6aiQz31CvP1alV?=
 =?us-ascii?Q?8rRdxZKfFz2oIxH73ijG16JmcL2vJTAH2pBEpk8GdYjk77j31a3HxyI9pSh0?=
 =?us-ascii?Q?5lJRIjfx6q6MveJuagQMWCk+XYIbJK3Mo4cH9j0Hfi51mBCByhi0svCWHfo5?=
 =?us-ascii?Q?sCNhj87fJYLsBDsDqEvCBt2ytgp8T1/7GiOaOLoXoJphcDYVshO14+KVVhbQ?=
 =?us-ascii?Q?w9CJsBO9jA5GJh6uXPNGk/F2gvA9dt0jO2sA5pG2CL/Z++etulkIUqZeWtyQ?=
 =?us-ascii?Q?KRJBtZnnYdaHFXQc1pgEz9yFDoH1V6ccWLCb2UZGTvFcztefEDQiLext7wgX?=
 =?us-ascii?Q?RrrsMHpkjPxFYn0kOa7FaSqUw1GuqD7OCwh0IqxVlF9jG9HEO4tpEm53ugA3?=
 =?us-ascii?Q?YQ8TSQ+aQB1rSp4+8eagjye1O72I/P5r26qNzlq5mUi5P+XJ2qNvmFlQUipr?=
 =?us-ascii?Q?dKEDCbDtgWU1/wZ7yCRBv4xXiwg8FM5CjPSPgfC7AkHzPSZfxHGmHLJmrfOR?=
 =?us-ascii?Q?+1nHb5RzQm4jvoOBulp5Zxzhx9hM9ddBYK8DyN5lsWqVsSEHbugwF2wCCxxG?=
 =?us-ascii?Q?paZyB7b4UO5dztXW+qF+rVdoRS9SMeXqCdwI9PQC6l6KjyO35NMqe9vxCxuV?=
 =?us-ascii?Q?T5odBnr4+EOfill/8Dw8u9vvv4p+t8i1Cgg4zkROaZmmE9NYhd16fB5bfNDz?=
 =?us-ascii?Q?3/BhFDAhbV8cOiXss7nUTPDhWxLavj22NULR6+mT1vD491UFlmg6O4tfYQLt?=
 =?us-ascii?Q?dT636rLx9JEmYCO8UjB16+sWv91ZEW8V3gZJLETy37baTRUlbN0X2vSi2sVk?=
 =?us-ascii?Q?+GY9myJNXKokzvKSeD0nc4mZjxTAy/FsPz+WgGtsQEENm8r4Y0dvXy9GwjU/?=
 =?us-ascii?Q?yx+Jnc03k0rDUNyWsrHeF41ytowtnm28xzYwYF/pv+YZmY4H3jmp9o4peXn9?=
 =?us-ascii?Q?Zbrhv10TMJf2rMKqOS/7domm1PdVZ+ddV61Y/Vk4JLAuA8ePyikCxfj3+k8r?=
 =?us-ascii?Q?JSFqkv4ASQHEDM9pU7WWIhN+V/F8GYpFnlOo3rQYgPzj+V000ewFKuhmF0MR?=
 =?us-ascii?Q?KDvgZoCCJIueBHUnVkSbf3wnZkomdCi7Ds37IM4ShuXh1mCgCYODJnpYZ1uR?=
 =?us-ascii?Q?fivlM1p00Xd+fYbth19lAoi2s9CHBN5dJ2a0BE9L7vS3nxor0dzx4/vl0jfa?=
 =?us-ascii?Q?9htmmOBfajA+72dZJimuEKZ6/1VKg4ExZum6adm1F8Oa3VQmvpIlHBo2bwZs?=
 =?us-ascii?Q?MH/OO3DzFq/MhM1ospdudCg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6923.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d786d7b-0e26-491b-f72d-08d9b44c8124
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 21:58:12.5489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FC5PTcpwtsFrDTorOKCut8vzj0cU+egrMgpbpqWXwpvCHoV46HE+Col5zFeKFu/FTXgkrizjbutu8A6jmfDi+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5578
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for the review.

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday 25 November 2021 11:42 AM
> To: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> Cc: linux-kernel@vger.kernel.org; jic23@kernel.org; lars@metafoo.de; linu=
x-
> iio@vger.kernel.org; git <git@xilinx.com>; Michal Simek
> <michals@xilinx.com>; gregkh@linuxfoundation.org; rafael@kernel.org;
> linux-acpi@vger.kernel.org; heikki.krogerus@linux.intel.com
> Subject: Re: [PATCH v11 1/5] device property: Add fwnode_iomap()
>=20
> On Wed, Nov 24, 2021 at 10:54:03PM +0000, Anand Ashok Dumbre wrote:
> > This patch introduces a new helper routine - fwnode_iomap(), which
> > allows to map the memory mapped IO for a given device node.
> >
> > This implementation does not cover the ACPI case and may be expanded
> > in the future. The main purpose here is to be able to develop resource
> > provider agnostic drivers.
>=20
> ...
>=20
> > +void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int
> index) {
>=20
> > +	if (is_of_node(fwnode))
> > +		return of_iomap(to_of_node(fwnode), index);
>=20
> It seems this part should be wrapped in some ifdeffery according to kbuil=
d
> bot report.

I see that of_iomap is wrapped in #ifdef
I will fix that and send a new patch.

>=20
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL(fwnode_iomap);
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

Thanks,
Anand=20

