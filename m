Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F129C47E0AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 10:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347372AbhLWJGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 04:06:48 -0500
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com ([40.107.94.53]:45825
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242904AbhLWJGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 04:06:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfoOf5/s1KayXezJYaPr9dk52xlrrrcJATwtis+d/xrsK2ftn3o+xjAneh3ZfKOMEuYPG3T0z7Db04qYN8yaup+YyOnLq+YWzSjt15pMtWsy5TsXVK6tTsI84uCTL0L9CO5Y6m0n3bAlrrw6nURuns9Um6ciwiXtQaT0MynW/29jPFUzpPkeIZrzftJpsL4yaNxSjBhsiURsdOF42sMP1H1wBBRtzo3W5ZoRmIUkB6sKdG7pUmxkiJ6N5jh6cumYeDRkR6W/xZ4EhPxfHpJE9E2TN+GsYdgsv4t47axqr8gXq6+aTtU0yYgMSRaS/lkqEZ3pLlONarNjsy9pTOebJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl3MVasqVOped6y34FMc1P+3TeNxKWCFJsf50vFxTuI=;
 b=T6WNX5yuR8a3zuDJ/Gs+rFxvxiufAZrrQvPLqDKgjweFU6eCI41xZaf5Xei8qQoO4Ecxv/JmuPiTBDU/N6CVBnM1oq1F0cks/LVjMY52msaH6ExoYwS+QH39j/RXtQEk1Yc8ly5ocik5ztsldo486t3h/VgGOzR7bB4332tRZukX1+6l1ckJqxS1fi69pCa9Fal9ELEdMMPJ8sT10hvGCyzMLWEor6DwvSrmi0BKT3T9d7JD4iUGk1RbcPe+Dxsy5/ipZzHMKRrHdS6m/mk4ZSE6fBdPuDNihcVcAJKE3c33l4gkIDZyYvW+Ezdamufxgjr4VEJsUvZtgrEpKaFBxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl3MVasqVOped6y34FMc1P+3TeNxKWCFJsf50vFxTuI=;
 b=fi2tvArtlRlLRa17VWCu+3kpQgrHCpa6ZmOCWvRd7L+j3DDA6s1CDLMpsvaKs+VAmxowHBTSoP8r0RV0eUZaclJT5732rWme3JV79wNIZFxJeLsp3WH2+rp31jUUcuB0Ln8mqRPXNdMMU4NwBmHZUtTyW9kteIkqAIhIrrTcfCI=
Received: from BYAPR02MB4488.namprd02.prod.outlook.com (2603:10b6:a03:57::28)
 by SJ0PR02MB7808.namprd02.prod.outlook.com (2603:10b6:a03:326::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 09:06:45 +0000
Received: from BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::9c0e:d3a6:f34a:d10b]) by BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::9c0e:d3a6:f34a:d10b%6]) with mapi id 15.20.4801.022; Thu, 23 Dec 2021
 09:06:45 +0000
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
Thread-Index: AQHX6pNjJb1VaA7qnU6jh0swad/LO6w8whiAgAAEj4CAAxxxgIAAAFdQ
Date:   Thu, 23 Dec 2021 09:06:45 +0000
Message-ID: <BYAPR02MB4488866296A74FFE44C12C58A47E9@BYAPR02MB4488.namprd02.prod.outlook.com>
References: <20211206112101.24955-1-ronak.jain@xilinx.com>
 <20211206112101.24955-2-ronak.jain@xilinx.com> <YcGbvXzvLtgBo+sq@kroah.com>
 <BYAPR02MB448806DCF28EA41AFE4B3D0EA47E9@BYAPR02MB4488.namprd02.prod.outlook.com>
 <YcQ7qynk9vk336b+@kroah.com>
In-Reply-To: <YcQ7qynk9vk336b+@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16ec6f88-5355-4877-e1f5-08d9c5f38b45
x-ms-traffictypediagnostic: SJ0PR02MB7808:EE_
x-microsoft-antispam-prvs: <SJ0PR02MB7808BDD0B8017FB32A12264BA47E9@SJ0PR02MB7808.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:326;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EhKQPiWztDK9izXmOXCHuV0s3UgIGFlqd4dOOdRhYrp+JbOhdeNbOjSPWrWR4iIP7e12nxbFP9vmeGfWA6uGunXrDOHwuE/102Y0ZZZsIw3xqUGwQjK3+UDg80ETT0dQfWiejPt1m3nsE/um/waNoiuzhtHyWJCaVbQsm0MqCyv8vbsN8ezNWWGw0FrFG+E1Orxre8u0zUquZLbCTnATjc2kiwB47Ms1X7XvY2aEGT9hjIQ7VJyl1af6XeS7a8fR3nhCQpoub/8acIxuerc8AzvjNpOjy1w7HlbvV85sGhpdDwAcLNrO6USE51LF1/qRIbnDM3VsAv5amdEqt3Zk0Vr0WeQDuZubcpD6QwJZoHpSIX56/ade/fnVW0ZduuU4sQA07qYPKRo2Zn7lyJoaxnIi1ba0m7j9BR7x9bswMmUbGVWLpaSbGImnxtHZ0Mt5o2KcUS8XdnK931QOZdQBfmaDaYswSdagyS5fnkswVVrJc8sPC9MUH9ctyXHtCQkryuoI1xdcm4pBXfXCU6+A2I5l1/brCvdjnrnATGM4Xr4IUxFUgzo92LPExbeEJxObBta2wl/I3c1ulSjpTzD2JshvzrYjOBBKtBLVmZfvuAZ+w4MGg1yoc3K2ZYis8ioHaXZREkTxzmtF6b0IAFd/qs+qaVR2yPsX2IGZdfAoNAEmDM7/YlasmkbO7T3NoD/jsiFfvawC+xpcSYo9bgdNAoOQjUIFfZFYf10svrdDTAgqiNZ/Cwx9FKYYhenKgEO6g29Gmpy+2rRkuvZC5yAhS2V+jqhHkyay1NMLMOfrRpI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4488.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(53546011)(6506007)(2906002)(83380400001)(7696005)(508600001)(6916009)(26005)(186003)(107886003)(52536014)(66476007)(76116006)(316002)(9686003)(5660300002)(38100700002)(66946007)(33656002)(64756008)(66446008)(8676002)(66556008)(54906003)(8936002)(122000001)(4326008)(38070700005)(86362001)(55016003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OHT2SZRA22ZQoMemHla2qeH6uOttm7Sc5ld2YZKw6Awk2Nmt6SbUrUh4YeJQ?=
 =?us-ascii?Q?rlsWM+cX+unP9ZtYhAtfqu7ekcbPhZ6AbeYxCJcD2fvuWk6Ll729+ZoiWbJ4?=
 =?us-ascii?Q?HF+qOj+RQ+fCyL5evdyhfYzLc695+0EZlIOQlJ5JKzBZNWOVxJ1vGi/AhNL9?=
 =?us-ascii?Q?fh+v9AVhf5K538Tea7EoGs29Su4kMFb3anWADCfQ1lkNphqZsa6rghJPAdGB?=
 =?us-ascii?Q?YFJpA45t/ZyyMAtdsjnP9NGCYDt5jyk2BxPg+tukt4V30h3ahDl+xaGL4iQP?=
 =?us-ascii?Q?WTnXTTKHjbXiHtHYbUqcneru/rGpliPFPnh8stmVqZr8AysKCdwiiWlVi3/1?=
 =?us-ascii?Q?+q76W9/AxF1Ujm8FHyXXPwp7zoVY5kk5Hl04WQlKnV85ARGpEcukDDeywMtr?=
 =?us-ascii?Q?NNkkl2GcEsSPRpNAtMZygHnDDFXkulkeosSSTPsxuGrLoHOJtahHoIfjX6mQ?=
 =?us-ascii?Q?tOYXJgl7qQCkhqRQNuEIMoWP/BIjEaDHEap2hQTzQmUdA1eDlzwVZRUIoFPZ?=
 =?us-ascii?Q?T5WYqtj+wl37xJ1DB8UqlWO+1E3bMDxVlog7sVONWpF/EkyIPoT8mJJwruxd?=
 =?us-ascii?Q?FYpm0QgVO9d7IoTWgW6JqUjMO4zFK8uenhI78EbSCLQR9PWfuKSK6RIQ0ng2?=
 =?us-ascii?Q?Bn6CGTIIxqQTKqCXzvIdO0KdSQPYK/2GIQkx3xcYQdr/10mTJjZpqo89yug7?=
 =?us-ascii?Q?XyLq2wBack/H4CQX6O2KdH8anonPmQfBteh/UrNMXc+c9tDqx1JFN1xir/po?=
 =?us-ascii?Q?Ovo4K02axe0rzLBxuBmCznwBe0HiFYQOCc6k2bLFxp60nir6u9/EABG/L2Cd?=
 =?us-ascii?Q?l1ftY0RHaNmSGlYYPBQQVyFCfY11cotgpuuUcaGBFxWCu/TKomjpWEh8wQwD?=
 =?us-ascii?Q?I0+WHWcuCX3k9y4E0bStF/6pX3KMh/IG3GNWccdHtCjc0YW33fiH+w0j7Hr1?=
 =?us-ascii?Q?JCIiynZwFud+PhfZpDAIedH4JJ2O0cBCQSOTOEWBMj9yRX6BX1TMhkeAMw+L?=
 =?us-ascii?Q?xnpdsakvtfObaq7r1JFM7zwFzEifIPm+eiVzZsaJfLIVuRsm5wLB9iASjrZF?=
 =?us-ascii?Q?KKSvbAJKWkexFU4ed5RdadNch3yPTx2djPJLjYprKQxvNg2Z5JQfZIB4WCnz?=
 =?us-ascii?Q?rruejgY1Om9MY5IX9eR17dLUN7D2XBqbSzOCqt6xUlvPO61h3isYLbdgaT2D?=
 =?us-ascii?Q?dT4bhmW+f6L+/Js5gojESpL/5ei7DUHJxw64Nbzoa7KAp57EJclHeSvcyAGd?=
 =?us-ascii?Q?xzQX4tYaQOS1iGagUzQ6qJs2wD5kLkXRi39TkIg9YdPp1KnvL+BPVLnsKUXc?=
 =?us-ascii?Q?T5eaGTlPDsSVKFZ7w0kgL1MLeHilcM2+LPKDkkFNTdrAAVux909IxH2L/5pF?=
 =?us-ascii?Q?QlLslGreUhX9qEGRd9fR51lwAKKzQ42UuZfRWKVRD3HQP8UlukW1NyLd/184?=
 =?us-ascii?Q?A9G9ajcgNrZQZUjYpJXooxTeVJJyIoDY31iU36dLxYuEpIKgZc4p6e4hvUaP?=
 =?us-ascii?Q?7zsJx1ybbB1s6Hvp2+Phz1FO6ljTBwgRrxAegPyRO56A3fCgLovmNB2VyRtR?=
 =?us-ascii?Q?IibrANSigp42fHhgHWYXGBELuq6Hzj9JWPgw598RFKiWX49YIYRiUhIJjMMh?=
 =?us-ascii?Q?GNe881EESamSlpUpBQtfHvg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4488.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ec6f88-5355-4877-e1f5-08d9c5f38b45
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 09:06:45.2879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: inTavDSyeQQSdEEu5h8EXrhJnJAu+f4ofii/7jIqZjkmN/gLrvUTSZ+SGMphnv9cLrYpOZARN3dPpoBKmqEfdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7808
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, December 23, 2021 2:35 PM
> To: Ronak Jain <ronakj@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; linux-kernel@vger.kernel.org; Raja=
n
> Vaja <RAJANV@xilinx.com>; corbet@lwn.net; linux-arm-
> kernel@lists.infradead.org; arnd@arndb.de; Sai Krishna Potthuri
> <lakshmis@xilinx.com>
> Subject: Re: [PATCH v4 1/3] firmware: xilinx: Add support for runtime fea=
tures
>=20
> On Thu, Dec 23, 2021 at 08:55:09AM +0000, Ronak Jain wrote:
> > Hi Greg,
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Tuesday, December 21, 2021 2:48 PM
> > > To: Ronak Jain <ronakj@xilinx.com>
> > > Cc: Michal Simek <michals@xilinx.com>; linux-kernel@vger.kernel.org;
> > > Rajan Vaja <RAJANV@xilinx.com>; corbet@lwn.net; linux-arm-
> > > kernel@lists.infradead.org; arnd@arndb.de; Sai Krishna Potthuri
> > > <lakshmis@xilinx.com>
> > > Subject: Re: [PATCH v4 1/3] firmware: xilinx: Add support for
> > > runtime features
> > >
> > > On Mon, Dec 06, 2021 at 03:20:59AM -0800, Ronak Jain wrote:
> > > > Add support for runtime features by using an IOCTL call. The
> > > > features can be enabled or disabled from the firmware as well as
> > > > the features can be configured at runtime by querying
> IOCTL_SET_FEATURE_CONFIG id.
> > > >  Similarly, the user can get the configured values of features by
> > > > querying IOCTL_GET_FEATURE_CONFIG id.
> > > >
> > > > Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> > > > ---
> > > > Changes in v4:
> > > > - Update commit message
> > > >
> > > > Changes in v3:
> > > > - Resolved merged conflict
> > > >
> > > > Changes in v2:
> > > > - Resolved merged conflict
> > > > - Update commit message
> > > > ---
> > > >  drivers/firmware/xilinx/zynqmp.c     | 27
> +++++++++++++++++++++++++++
> > > >  include/linux/firmware/xlnx-zynqmp.h | 25
> > > > +++++++++++++++++++++++++
> > > >  2 files changed, 52 insertions(+)
> > >
> > > I still get merge conflicts with this change:
> > >
> > > checking file drivers/firmware/xilinx/zynqmp.c Hunk #1 succeeded at
> > > 1156 (offset 27 lines).
> > > checking file include/linux/firmware/xlnx-zynqmp.h
> > > Hunk #1 FAILED at 126.
> > > Hunk #2 succeeded at 376 (offset 17 lines).
> > > Hunk #3 FAILED at 435.
> > > Hunk #4 succeeded at 697 (offset 31 lines).
> > > 2 out of 4 hunks FAILED
> > >
> > >
> > > What branch/tree are you making it against?
> > >
> > I have created patches on the master branch of
> https://github.com/torvalds/linux.
>=20
> Please work against linux-next, it has the combined work of everyone else=
 as
> well.
Sure.

Thanks,
Ronak
>=20
> thanks,
>=20
> greg k-h
