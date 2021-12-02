Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A527E4663BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347093AbhLBMhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:37:36 -0500
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:2306
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347032AbhLBMhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:37:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKT+ZG+73JQI8nB8AQ0DJM4b1YSobc9+S9wnBb8gPexReG1SUSpEOCFq4KzyYg9aWfcydDGcnketIMYnGr3Kj9B0O4u5/SMBdXLj5pJ4P1VEvDE32KinjJL6HJpCSE69dQFopYr1STFIT9B95iMnyvdTfk/tRoF3tvX4ZWp8115H6nWo4jp0IfCXK8baNefpHvEnwDarJoO6Wndv/in+/Q6ckrvzqv3wiYTy6DzZW2Jdf4IXLIsOUortJHuOzIhqXARDMamIRxTL2NNorZMgH3G5RgrEjuviVk3+LH9jhuS73QX4acn31pKe8QPstwj4AANhZwSRdbexlkgxMMIUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhaZ5jsrQ4u3I0svCiul5a5agD3k+wVz453yON9T81U=;
 b=S4qiyw2UwjklnoT7gUXYOtDrbd/l/PnXV9fvNbV7vt+Kz2W6PBi+UyGxQYrHXWYOAnFrJcsFXK5CCXkEbXzO4x2y1cGO27jFNwbSrOeZOgB4kqQh1ZW/cVb+NuE2R6rJP9JgsXo9ruRRZHvZn8wKEbZxZ+bXY7GrRT5EPWcCs+CPaw6oM93FlYnCItTTMFmUU+nB3yAuQVrOr1uPAsfwbaxqTCTjjolXTG3S5dc7ZEluaKOD2UhkdwreqG4n+GRT2JzRVw6PErpLxqGk1pBSf1lGzAjWz5Ov2x8Gf3hVN/0Yrg/LkSV4lsWxaJ/4wa7MW4TknIkS49G/L2I5XZE9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhaZ5jsrQ4u3I0svCiul5a5agD3k+wVz453yON9T81U=;
 b=LzeRPaQsFLF4w+VaSFFX+Pa/ALwSMCwBBTrWz/V/RVDSrbUwQHvpC9VVAaUJKyUbDDFm8P5TRxqIa1tcNPhIeh3RyIpjp0I/FbocfIleL4M9vtaRsd+W16HZxAd+YLeWs91AOI4T2mHh6SstPMkFCh12pnFYW8JQ+AWaOr0akzA=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by BY5PR02MB6819.namprd02.prod.outlook.com (2603:10b6:a03:202::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 2 Dec
 2021 12:34:10 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::8151:8728:8d6b:c3dc]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::8151:8728:8d6b:c3dc%5]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 12:34:10 +0000
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
Thread-Index: AQHX4YZBUvFrfnFzmkK2bRDvVWcrV6wUH/KAgAgekICAArbIYIAACAGAgAAjQwCAAA4IoA==
Date:   Thu, 2 Dec 2021 12:34:10 +0000
Message-ID: <BY5PR02MB691611E8D9DBC646847E3CE0A9699@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211124225407.17793-1-anand.ashok.dumbre@xilinx.com>
 <20211124225407.17793-2-anand.ashok.dumbre@xilinx.com>
 <YZ92mTURrFWZPUXp@smile.fi.intel.com>
 <DM6PR02MB69236DAEBED675DB929BB8ACA9679@DM6PR02MB6923.namprd02.prod.outlook.com>
 <BY5PR02MB6916F7BC6ACE5326DB92DB2BA9699@BY5PR02MB6916.namprd02.prod.outlook.com>
 <YaiTw1RVgxkOvFj8@smile.fi.intel.com>
 <BY5PR02MB6916174E242165D305192F2FA9699@BY5PR02MB6916.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB6916174E242165D305192F2FA9699@BY5PR02MB6916.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c00595fc-7e0c-4636-346e-08d9b5900a8e
x-ms-traffictypediagnostic: BY5PR02MB6819:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BY5PR02MB6819CD59D209701F509A8088A9699@BY5PR02MB6819.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tAW57PP2IaGTWa2JlmlOKGx08TgE90zXmKWOSkf7XhpsJX/oOcF4MlGgkyFNGQHNmQ9YKhAEBMvbzLHLdMme+ayBn4zYrKya6lrdZetDuoQQ3kuWPNPTRTh3/mP98gZzTrj6ljdQ1R3GFns6VtXRilbBTO+Hz3f1Cg7BuT5L+DMXzSNt25EZO0q8Ke9EaAHl6Rar9poNM2TftXuQ9a0qHW7LixpGSsZo+jlgd6cVTj7kgb6hW6HDO+zBVPvHg5X0qOTbU487DOvXeTM2m1LkA9I7IOp9FvOVY5PaPIgfX7/XPXDVdQzC15TuFBkSt/cXEdQBdza0meXVB3CiGMf7q8t7MeZYH3UMXl/2ulAhjCXzb3lkCOva/TxYQSNPX5W3TtkfNnVlJcIrQ+RfdFhOykFp4xHaoBxxyYALSYJj7RHERIeOOsRQ4Ql8oPaO6MTV+BBGmI1mNviCtIDhcfSO2pk0ROW6qh9qYSM7Oin0toYLryu3F2eD78pqHWRhGvRPP0rdG5QokGvfYulcgsp2mNTk7GRWNG0BU68TywyiR2YkmSSU2lDGpr89+7V4dc1/CFk8clHjVRAAVfanhoAmd8klNIgorOS4MQyYfnU7zyBeCHKxNloUTvLmmVfkEQ2R0hrUIR/z6BY1+XO1b4w8nx9gR2EXPtJS8s/lyUd2Y5Os1KovRoZQuPH4vX/bmYX3cN55LV2KatCCv2Sk+dWYjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(66556008)(53546011)(8676002)(6916009)(66446008)(186003)(122000001)(52536014)(38070700005)(55016003)(64756008)(26005)(6506007)(2906002)(71200400001)(4326008)(508600001)(9686003)(316002)(66476007)(8936002)(66946007)(7416002)(5660300002)(7696005)(83380400001)(86362001)(2940100002)(76116006)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Td9lDcKynZsRtdOF9B1KZWgWgSERNtV8QLnNiv68OMoHSbWxgtyq10V7JfPh?=
 =?us-ascii?Q?qldTt+h5zB9u47s7WL6PMeNyjziuPN8pU+cUAuxV2LCbsqI+90/1iAgqr7a/?=
 =?us-ascii?Q?mwYEl8zA5qFM697jVVvW2n2lEt82inxqu8OtHPGZSRbgsjqhFItFRdGEZCil?=
 =?us-ascii?Q?VS8Mnox7zYEmZVJv4mqUjo/7TeNeg1ZFvRV7M6pF1fwoWRP6mAjpuFYLRiTK?=
 =?us-ascii?Q?tdBrBPLrzL63nXBKsnxNuJf6juo5tTd52Ot+fp5snQH8VpoKbrCsz5dZ7twQ?=
 =?us-ascii?Q?n+0e97nCP3PbgqagTQ7i8sfW80s8ZIMKFh8Q4AVN2It8kn5GFqGnp1WHeSbk?=
 =?us-ascii?Q?95iHCS2RjWg6Nv0cX/eltxVuWE4tIojF979LC9gZnYqzo7YN2w/Hz2kvlYC1?=
 =?us-ascii?Q?6Hc6OYfg/9Zy2v/TfmGFAtB3Fe9F6F2KaZseFkmU0y84ZwhH6Ngppbr/r6Ul?=
 =?us-ascii?Q?v7R84y/Nktl+ftFT4+BdEJLw7XPv2j0C8DtE+WkwPacTInYpKAo5XTXBXqoe?=
 =?us-ascii?Q?XJkS7GLGM9QjUajauAZ3XT8pvp1HgFY2rXnHq7WBX4E6e1QI5lrquvQlYvBt?=
 =?us-ascii?Q?ChHoP7EZoKMhFxx8w0YvSgAMWUIlAVj6shUyaDIG98ZserjDmvtVq+PlQp0A?=
 =?us-ascii?Q?33eW1sFOI1uGxGcR8ZvYTM7p0uBrSQsqUMI3ky92hoHsvHQ7ELVwGkrwwpc1?=
 =?us-ascii?Q?gHDU40IZ+tMPkvCgg8wIY/Et9SkpJm1kkmi7syVwzam8HZGF7xFeKuRmVr50?=
 =?us-ascii?Q?igDJsGncJywIZ92nA3vRvL/VOu+juguA6YUCXAIIzKkgtddKfKJKvTMnTvYL?=
 =?us-ascii?Q?pwaQVsfDjcZCSWzCr4+sroTpgzsLyUiYEk6iwGgZ3aj6DvlkjUGf1K+c4uA5?=
 =?us-ascii?Q?QQeOTmUA2DmuiUTqKQHAk8cP3ceAWkOI3dJqScKzmK1g4z4oB/fl9MVrkR83?=
 =?us-ascii?Q?qyDfsXTDx3H2gdr3uR0DcPqba/twFDVyzKAMDTEWSFJBp4Z0xTEnXvD7MMg1?=
 =?us-ascii?Q?l68NNzCG32530MqKVYb+gLNwTeBtfzwf2hIklaEiA9NHYe9IvsM8ejzKHZqD?=
 =?us-ascii?Q?8CX0SWu6yaobR1ZqMwQ55BY+TkQLnb5rXzk8Sz2haR0HQt2T3C5HTdiZ6eKy?=
 =?us-ascii?Q?c58R7rBNbtEsMDydvRvlmEk2aZPhaTYjSBjh7zxoxcdYC6fOMvRmIyhvmIN5?=
 =?us-ascii?Q?ScL4iiAaNUO+MykVhueh1Q56Vy+VJioAwjOhB0yMJJMdL6sYF20nI5hj88t4?=
 =?us-ascii?Q?y9wmKfwPA2U8jjtbary7bq2avGuZTl085PGT5l5hpxIQAY9BXJ67HxsWlf3m?=
 =?us-ascii?Q?Lli1va3CruCFjQKXF9rb3azMaclZ8Fx5tErVMszsUUw9SfpJh1zwxjYyCZaZ?=
 =?us-ascii?Q?b68aFf7ANS1M1jUzLLKt4lr9mGEkTMh+G/av060+sz3PN9UitBSAAMT61lXl?=
 =?us-ascii?Q?d30tOUYgIUCybU7Ca1eOEiwipMVKFFOrpPVo4b6uC4mNYb9zTePs5Y2G9aZv?=
 =?us-ascii?Q?VqlQgmwxlwOLgUZW4OYKtczD7EUxPECxZtdiiGuFYmx8n0T7+Cg3ZDBEr4gj?=
 =?us-ascii?Q?DjlZ5ut9ixaxPO6Y/QMMzugYJdVi3ZAqmsmjX7nz9ZEY9bygGXjRBpWM3tOD?=
 =?us-ascii?Q?ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00595fc-7e0c-4636-346e-08d9b5900a8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 12:34:10.5864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8zw3W0umv5LGyikBRSo+l0oQpyI7pu1Sv+BZ6XRZTXCkflUYBYBHomB+dQB4IxmWUVgupNDyvv4hl/Rk2A2frg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6819
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> Sent: Thursday 2 December 2021 11:47 AM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-kernel@vger.kernel.org; jic23@kernel.org; lars@metafoo.de; linu=
x-
> iio@vger.kernel.org; git <git@xilinx.com>; Michal Simek
> <michals@xilinx.com>; gregkh@linuxfoundation.org; rafael@kernel.org;
> linux-acpi@vger.kernel.org; heikki.krogerus@linux.intel.com
> Subject: RE: [PATCH v11 1/5] device property: Add fwnode_iomap()
>=20
> > ...
> >
> > > > > > +void __iomem *fwnode_iomap(struct fwnode_handle *fwnode,
> int
> > > > > index) {
> > > > >
> > > > > > +	if (is_of_node(fwnode))
> > > > > > +		return of_iomap(to_of_node(fwnode), index);
> > > > >
> > > > > It seems this part should be wrapped in some ifdeffery according
> > > > > to kbuild bot report.
> > > >
> > > > I see that of_iomap is wrapped in #ifdef I will fix that and send
> > > > a new
> > patch.
> > >
> > > I am unable to reproduce the conditions for the error shown by the
> > > kernel
> > bot.
> > > Not sure if I am doing something wrong. Any help/suggestion would be
> > appreciated to fix this issue.
> >
> > Kbuild bot gives you a config file and command line with which it
> > tried to build. It's quite rare that it gives you false positives (and
> > here it's not the case, because you need to have ifdeffery like other
> > APIs in this category have).
> >
>=20
> The problem is at the config file itself. I am unable to point to compile=
r
> correctly while running, make ARCH=3Ds390 test_defconfig
> s390-linux-gcc: unknown compiler
> scripts/Kconfig.include:44: Sorry, this compiler is not supported.
> scripts/kconfig/Makefile:94: recipe for target 'test_defconfig' failed
> make[1]: *** [test_defconfig] Error 1
> Makefile:619: recipe for target 'test_defconfig' failed
> make: *** [test_defconfig] Error 2
>=20
> I have added the compiler binaries to the patch and set
> CROSS_COMPILE=3Ds390-linux-

I am able to build now, one of the build options was causing the problems.

>=20
> > > > > > +	return NULL;
> > > > > > +}
> >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
>=20
> Thanks,
> Anand

