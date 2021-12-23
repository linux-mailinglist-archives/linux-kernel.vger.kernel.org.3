Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478EC47E0A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347329AbhLWIzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:55:14 -0500
Received: from mail-mw2nam12on2080.outbound.protection.outlook.com ([40.107.244.80]:51425
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232514AbhLWIzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:55:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=km9buSp97dM4CdcyhDfcMR/qiMhEEtXd5KF3TvI4gv95nvqushODJeaoQr3r8YyVMBEWISYYEBqw94tXMsKC3lOu1/jdQaw7py3pNa5XKCcCNuz1wGsiBCO3rMHmRlBJpNPm7bRo+WHAPi0q6UfNEPCsnbKYSRpRQMlfPugTLfkhEEiLAINFglYMN6mhKIkbXYfIvXfSrm5Qs9eV+oGRosnV1T2SYVgEdAwV7gc8pTT8bNZF0tSkadgFIGs352+hLGdP32zNJ8FNoVpchhqLYsKGFywS19rK5mZS/4QaJTc4lgGwO+zawL1N4ooxWcWHTc83IrJ/aBB/smfOTSRF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+kiJbxdR6XDftsufgqTTrxhdnaIa1inz5fqoV126Ro=;
 b=YS93r3S277giuB7mW3SAiMwTSrCWcXdeiWawODRp3tWUd8B/OI2rDgpGKwqS1HiBKvlD7MnpB4C4qbZaDXHQKAown/9EPCxxQf+SO9QtMKUR2nz+5hgPU3eY6RTcd3IuZx/3wojWBxgpHMCk5iEYw3WaAfkrRB3tlINB+PBjlAH5KXB4s4fJgwKnPbIjbhyPRbPadovZiIHgaV5492WASZN3nk6vY1JjlkBYlPyKcuQSoMvZlnww7beZLxpUoQmzcBnByVgJRBF8/s95WJVaLIf/40lkmVgA9lIqZ8pYYpucpBGviLsDUTQq/c81x8Lt3bGEb8NXls8Mwp/nawO5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+kiJbxdR6XDftsufgqTTrxhdnaIa1inz5fqoV126Ro=;
 b=Pf8tqqL1tyD0H9MeGb6E0ZT89abpCGTzCoL6dIJNZaptHD7ASbr6MyoGcDz5KEDD+N+l0w551JNPyRvImg8fJSEZ/futzXXdfE4fZ/ehhXAgFIJLakYwZ+GNaNnp2q/jZF9K28rQSltyXeHbWg58qEPeT7bPpivtzbpA5cSaIc8=
Received: from BYAPR02MB4488.namprd02.prod.outlook.com (2603:10b6:a03:57::28)
 by BYAPR02MB4837.namprd02.prod.outlook.com (2603:10b6:a03:46::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17; Thu, 23 Dec
 2021 08:55:10 +0000
Received: from BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::9c0e:d3a6:f34a:d10b]) by BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::9c0e:d3a6:f34a:d10b%6]) with mapi id 15.20.4801.022; Thu, 23 Dec 2021
 08:55:09 +0000
From:   Ronak Jain <ronakj@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>
Subject: RE: [PATCH v4 1/3] firmware: xilinx: Add support for runtime features
Thread-Topic: [PATCH v4 1/3] firmware: xilinx: Add support for runtime
 features
Thread-Index: AQHX6pNjJb1VaA7qnU6jh0swad/LO6w8whiAgAAEj4A=
Date:   Thu, 23 Dec 2021 08:55:09 +0000
Message-ID: <BYAPR02MB448806DCF28EA41AFE4B3D0EA47E9@BYAPR02MB4488.namprd02.prod.outlook.com>
References: <20211206112101.24955-1-ronak.jain@xilinx.com>
 <20211206112101.24955-2-ronak.jain@xilinx.com> <YcGbvXzvLtgBo+sq@kroah.com>
In-Reply-To: <YcGbvXzvLtgBo+sq@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c8ddbdf-82ea-4537-46fe-08d9c5f1ecb1
x-ms-traffictypediagnostic: BYAPR02MB4837:EE_
x-microsoft-antispam-prvs: <BYAPR02MB48375ABB5E9FA5A7EE95A3BDA47E9@BYAPR02MB4837.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:326;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d+s0jH277BRn2ivOhdgZ9jkioXJw5OmpSF3RL+kBS24RfY95Lxnd1YVxPCRsA5FiofcGEdw8L2BK1DDOcvafIjzzZJfdc2ZlzNiojcu2ZFOn1fjmSVaLvMF6nmiBIViq+YCwiTK7rlOuzukg6opJviXGPoIvMx4dZcVggWYzgPO5j3EIezZFLr2+fcsWfc63xiSRkrPhqnUqRv/bKv0K89lcbWojleeW4klZkVeWrYIMEG2UBzA3FqtAol97PIltbYEs0xB0ibSFgp9vtZYwdl+oj+lc96MGdWFblgFnW20pWK36LxYu0aFCzHxzid0TFhZGjc7X7y++sV01hvrBMr5K0kLd7BdwGDPu2qrDnDf+qZnrgJfYT/awazA7T15uRxp/TefygumkDzHy0x2yZ313cqrM7vmNoqnl9LRuqvs8ZkYDaJ51bM+QtRmCtRwqFZEjzg5xwyiAq0Oi1cfZAK5HGkvwOjuzOGo7J+F07vfxurFFn6zkZqY0hsKHRT//bejhHsLrAcoj+h0WYftoqthEEuL1gskZm+zS2CLIBz6/VwjBzLBtc7zQs2e8p+bHVmdV7cecHom8dF0eNrYjn7HnWVNn2LjdvsxVZAYJn/+knrebg/mw4Gu52NvFnSfnjTOILxJ6FJK6bdD1w7tSkoauZEqhkKArL5GnzAbd3T1dIGIal+nI1ai4ItDS1g5qukG1z7KzIVi19E5wVvr2aaBrDv8TKfyXmdgJQLc0dk9T5zV9XLcrRbu0x07ADp4vZFm0HdEUHnlpyjOrSLyRUWcujDOQgSW9siTd9dyetlg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4488.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(26005)(9686003)(66476007)(66556008)(5660300002)(966005)(107886003)(8936002)(38070700005)(54906003)(186003)(53546011)(122000001)(33656002)(38100700002)(83380400001)(2906002)(7696005)(316002)(4326008)(55016003)(71200400001)(6916009)(86362001)(52536014)(508600001)(76116006)(8676002)(64756008)(66446008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+03Ur+N1IYBELX6zkMHprEHG3TSc7mLXpXgNREI3+A/ydm6lJRKMoW4l//Ih?=
 =?us-ascii?Q?/xkPWKul59qT/KCnTtL9I0GvJm2dvXSsdC/tKbMShK3+DhjQCIQkSjjJBJGj?=
 =?us-ascii?Q?H3cRmC9u7FEkb69y3KuCA2GN2+7WPvCtd0B/91or1z4ignr3Xc7EtVuy0Ea2?=
 =?us-ascii?Q?EjJfaSooqKwGQ/EFD1yzy9dXz9AogSRDYVWOC9ZM0uQc+z8ehoufaNbPwn4n?=
 =?us-ascii?Q?8Zal6KQD7GrUlEcnokSZDoO01yCDYBnOssjzJjmvkLXlPicw+GMxOts/Bw3e?=
 =?us-ascii?Q?YexUeR/Qgp6BOQUtHyiY2vvcLJpH9Ff2KN4UNfU1IOiJIwqviab8z9PvheVb?=
 =?us-ascii?Q?40PTR/Yv8KcPnBLPsrBfgkZK5y5Zc1AUweHoRIAyEEBGFVEa2ZjA7cjLYFic?=
 =?us-ascii?Q?lzYBjmsHA8Rb6Bd0DOXBGB7+5vp0GRQfWpKQx5aJnMsckrQvpIrbo5dvLQlE?=
 =?us-ascii?Q?ztdbH3vXPc3/miPvzify+kBWOXLXzC+mimExKIrFgYEIoQahEDkoPjVseFZS?=
 =?us-ascii?Q?ZdHrtGWqZ/6zQStoD/wVyetd5M2Dq0LRVysG031bdcVbNdiHRk+qfMmzcjnb?=
 =?us-ascii?Q?3mV4RtD+MHF0FZAJTGLzx8QVTeUOQ7L1/Ni7H10icwQAZolP7Jsb+MS35Pmm?=
 =?us-ascii?Q?SmvtJDLr8Uxf/rupoAilI9tl920bNyKpSWwa2KYmI0fRHY2BgKuuHxxE23Pu?=
 =?us-ascii?Q?Cbuuhjxcc/+XqXZAFOBVpwCn/HwvlGTOTE/KT8P5v7bPpmRi5IieSlgy8JfC?=
 =?us-ascii?Q?PK1xFO8mP1zywqhLm4L3C6boDQhHIq53TXSYt5ITbb107pSVi6j5/tSSgiF3?=
 =?us-ascii?Q?1ozzQME/Lt4MwwmnIKj2W45odxgwuXDKN0nLxc6ADfY0CIELWw5NpyQDoEdH?=
 =?us-ascii?Q?xOxTJzkFgErpGjci54a72KyZHPpEuD5EH7lM24k6gS+JPoq3v2lLRP7uR1gP?=
 =?us-ascii?Q?iVYtyjzjzjVaG10fV74t9h2qrK4byqM4VCqGYO5clHVSxxx51LY1NSNZxreZ?=
 =?us-ascii?Q?jM8sUSbtAnxnamD0x4prZRbH/5xT7PEVWiEcfkE4xDPkfU7OxduazAW/K080?=
 =?us-ascii?Q?upG1Q2SGOrWB7VJ56CAgxzKie5y70vvwTLuraJBlhiIrxaPlQwpRXzEfJ+5o?=
 =?us-ascii?Q?IoKXSrsybyTso/Uhp6koaIV3otSWVSZIbxKFwq568uXEVdcaz3z+Z/RO2sm8?=
 =?us-ascii?Q?M7NbS4jQ9CSMymwcZ+i+MxPbF/lrejsfA9fAqt9o7YHp89MXbaiDybNlxvvc?=
 =?us-ascii?Q?qZHjS519ftkgcwEoeFPDuRD+N77CQSsHMujxjGAo9wzaE7WgxHjI210fIVsC?=
 =?us-ascii?Q?ZPB3+T1+2r0q8CHffJ32uJ5RumRSNqawp1Boo4NJWUHvItk46yVvO4RSqn90?=
 =?us-ascii?Q?6U74GXgyC0jTRJkFB2THIa7vlswW6wi7TRAEO3J5ZrnOpWnUiQbKryrPFbHh?=
 =?us-ascii?Q?xIdmfleKym7MLM/X2+UzlTQv4Yw9eUAZ/kPPnniiCex/KcZ1sNcRe00J5ZqJ?=
 =?us-ascii?Q?53rnKbFE0uruB21643f7LbdtZlFldNv6QolTitGpAFHaruUpWfX0y5U1vvCu?=
 =?us-ascii?Q?Sv/uUZy2rbXG60ZE7OyQB9yG+8l710Nu6ItBArk8EOqQ0MAGxoATBdCo4H0n?=
 =?us-ascii?Q?pf8cWP5HNoF5U4XHaoGaSTQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4488.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8ddbdf-82ea-4537-46fe-08d9c5f1ecb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 08:55:09.7373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U2ET+H+lKoaTCm2jhI5yTH6XcUV7kO2Lad0vFda6+JJZ+hcin0B2SETecYFh7iu0d8AXNrSR2rJNsBwWVKa2Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4837
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, December 21, 2021 2:48 PM
> To: Ronak Jain <ronakj@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; linux-kernel@vger.kernel.org; Raja=
n
> Vaja <RAJANV@xilinx.com>; corbet@lwn.net; linux-arm-
> kernel@lists.infradead.org; arnd@arndb.de; Sai Krishna Potthuri
> <lakshmis@xilinx.com>
> Subject: Re: [PATCH v4 1/3] firmware: xilinx: Add support for runtime fea=
tures
>=20
> On Mon, Dec 06, 2021 at 03:20:59AM -0800, Ronak Jain wrote:
> > Add support for runtime features by using an IOCTL call. The features
> > can be enabled or disabled from the firmware as well as the features
> > can be configured at runtime by querying IOCTL_SET_FEATURE_CONFIG id.
> >  Similarly, the user can get the configured values of features by
> > querying IOCTL_GET_FEATURE_CONFIG id.
> >
> > Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> > ---
> > Changes in v4:
> > - Update commit message
> >
> > Changes in v3:
> > - Resolved merged conflict
> >
> > Changes in v2:
> > - Resolved merged conflict
> > - Update commit message
> > ---
> >  drivers/firmware/xilinx/zynqmp.c     | 27 +++++++++++++++++++++++++++
> >  include/linux/firmware/xlnx-zynqmp.h | 25 +++++++++++++++++++++++++
> >  2 files changed, 52 insertions(+)
>=20
> I still get merge conflicts with this change:
>=20
> checking file drivers/firmware/xilinx/zynqmp.c Hunk #1 succeeded at 1156
> (offset 27 lines).
> checking file include/linux/firmware/xlnx-zynqmp.h
> Hunk #1 FAILED at 126.
> Hunk #2 succeeded at 376 (offset 17 lines).
> Hunk #3 FAILED at 435.
> Hunk #4 succeeded at 697 (offset 31 lines).
> 2 out of 4 hunks FAILED
>=20
>=20
> What branch/tree are you making it against?
>=20
I have created patches on the master branch of https://github.com/torvalds/=
linux.

Thanks,
Ronak

> thanks,
>=20
> greg k-h
