Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB9247427E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhLNM1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:27:31 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:32514 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231744AbhLNM13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:27:29 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BE8OCVW008750;
        Tue, 14 Dec 2021 04:27:10 -0800
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3cxqqsgwcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 04:27:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gK2euyZc9LIQwaN3uQBRlD4E6OuzJoq7POgnBAMPhP99Frbl4BHk8khQO72FsEv6sHsn1Y2WQUXh/oLtDdNSSs+S3cuoo6krY9F/FdRCy3GOqL0ZVvI+P2SHyGnzUWOwpcDZbbmOE9hECIWUYwWjUYvqYcR9Hrbwnw1+2qTbx8L5aBaY0PbHjMwEMckUYxAUb1B8h4xjtqe2HIpjy7h6hBTrf1vCXTJ0eSOPZdvIN0k77LMqoRX0BFtu7WZXSOKdCjb5EJN+KNtoOudqi0SOM1D+u0qdHdu/bHhMJH4TXadhYTiOKhCmC0vPF2YHNu5rT/ObYvl9wR8fx43utW1gZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn/jL7S/brt64xZ3ag/7z5SvbTCLcTLQV6WIIEp9mps=;
 b=LrjkybVAoh879RZQE/MKyQwykLOCnzyIlC1Dn3nzX23UMjiM48z6/No+rskblabZ4oztO7/cXp/CLpWQCbi3/b0bJjqXQwqcvkGq25YW5DtgLQmMNErb4C5XE9LS+OMBmTGnUOb4mYv0ss7HCRHWKbyEPLfAI8agvI/TCQn5Ai6eU3NgqiEmpxF8GmLqHWtPSLHw1buSnpRb+IYIqOUjXAc1GKgVerEEOrGVW8SP7HKYi1al0UnkiTWGYVCXnjmTedRtz2cUtrdhDYJO+okh2eH/f9RXKjW6PWXKdQnPU/1KzJfVTnktNeZcBYBi1rl08bG0MrHuzl2vMTmFqPlcZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn/jL7S/brt64xZ3ag/7z5SvbTCLcTLQV6WIIEp9mps=;
 b=ssnu1bR8wxblY0CxrzCa2k6vsHo5heHJGu2DAhDTNQUg6dXqTj7T8eDcAoXJHMYDX/93bidVxP049DSvsRx64D6JcQUVmNbZUStFW+KHcWEIjlZQ1OG0dQ/rlcGGhUPLfwr5RJsgyngYUNW8A1gzLKsrCHSe9Q2BUPwWuCY2lOk=
Received: from CO6PR18MB4465.namprd18.prod.outlook.com (2603:10b6:303:13b::10)
 by CO1PR18MB4762.namprd18.prod.outlook.com (2603:10b6:303:e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 12:27:08 +0000
Received: from CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::c9db:92b7:a285:d0d2]) by CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::c9db:92b7:a285:d0d2%6]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 12:27:08 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Will Deacon <will@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v6 4/4] perf/marvell: cn10k DDR perf event core
 ownership
Thread-Topic: [EXT] Re: [PATCH v6 4/4] perf/marvell: cn10k DDR perf event core
 ownership
Thread-Index: AQHXzLwcGXQkFkVJY0GLNfcVFE9U4awyMcoAgAAAYDA=
Date:   Tue, 14 Dec 2021 12:27:08 +0000
Message-ID: <CO6PR18MB4465F1A9FFB5C36E75A7749EE3759@CO6PR18MB4465.namprd18.prod.outlook.com>
References: <20211029115643.32351-1-bbhushan2@marvell.com>
 <20211029115643.32351-5-bbhushan2@marvell.com>
 <20211214122507.GC14247@willie-the-truck>
In-Reply-To: <20211214122507.GC14247@willie-the-truck>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64f44c5c-314b-414d-61b3-08d9befd0c08
x-ms-traffictypediagnostic: CO1PR18MB4762:EE_
x-microsoft-antispam-prvs: <CO1PR18MB476220B43F519FC06392ABB5E3759@CO1PR18MB4762.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yKcv4GXrjLvsD1MvuOm5R9RO6fNZkohMVqJAEEgwBDK2+UCUqEjw4FtUO/gH+eUIBOrCffj2R3xaVf1PplRUPa4frMQIVZ1Py+lOS4vL2UXVpp5xQRdG0QbjAObNElK7LCY8w8J7hDpHs98IDtZ8hY5y5Pzbls03WFP+5Ppof2pmuXGhOsPpWq8+YETSEImxkhQmezcJ1HBIe9G+SBaYBG/6OtMlSe7nihfn2LOXb+qblA/emff48bN9qgWeFAFUslRgXxhMbgeu1hug54AUNUh4V6AFEZ9zn543zaYn86lJfFPHs4TmnSA+ORyMz3IbXLTqkwv280OsXhxyVchoojqyHnxh85GW1N9AyKcdsi04S4nZYfaEwgqx7n95vwStf3NoKHAK4j6EKfCc+Gz0Jgkl3JA3xtgZNa9HjLL0cuK3hPMeIgrJv8qXq4RvME2OJ0gmtviB3C0zkLrpZN+msaVhya07JjxUw6yKdOB0zuRaOi0pdbGrC4vzXSnAK5ooG13DNp23SEEg3orTYEfR5BUVdL4xImdxo9LPUh+9g+vChWthy8jg+o5Zo9VGjAUykMQvTdE0TwfoTaHypNqPFhLUR8baIq8kD2q71wwCXdJfBNnpQ+KiqfPJN2Ejd+yI0PjYGDiXXJn65/uyWjRQCFTXORNNK32pYCNziSvjoNUa+kNLF4PMuc0Y1cDVWYN+bP3+8vr26c4hosR/vaoEog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4465.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(86362001)(8676002)(38100700002)(83380400001)(122000001)(316002)(4326008)(2906002)(9686003)(508600001)(8936002)(6916009)(52536014)(55016003)(6506007)(186003)(26005)(66556008)(76116006)(64756008)(5660300002)(53546011)(66946007)(38070700005)(66476007)(71200400001)(66446008)(33656002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z3KB5PuYizjlvwlMR7uF8eFnrx6wmIeL351QIUeNRE8zHWOaaMY5gvlnLBAN?=
 =?us-ascii?Q?cMVhg5y/I5GLdXCbLUA40+ARuG601Ikhxg9y4ml6gpxe2b04z3Gg2au0xb2U?=
 =?us-ascii?Q?52u7ESEpdt5dpDuVw/kFUcxd2FFabZ4D5pQUwYLi4SO8jFXXx5ubEbtwbjRA?=
 =?us-ascii?Q?sWNNGskiKGxFlAiGvmRz9GaNTCuKC9lBKtOFmqVbgkv6qWuiJGpoLG6Semfn?=
 =?us-ascii?Q?XJqgoK2A2k/SHEqb84JDXXyCYb7CkO32VsLEtbS6PRyPNCAiC6HKJ6+23Rqp?=
 =?us-ascii?Q?wDKmP9VD35d4YGGJey6aNte0kt1qXAE2l4YRa+vhHVy3Jcx607oI/PMNMZ2k?=
 =?us-ascii?Q?lwOw3sJJASx29fZc1XxaYZYxaqy8Swqp8mh/v+5VdNYeMVeaYVWw7MHXe0Cr?=
 =?us-ascii?Q?PRE4v5oVtdxWYQGtYsCymBIwTnTM4419iRk+dAWMcj8fW9o+T+/kIk+a16vh?=
 =?us-ascii?Q?pGOI9w6bUMx7gGLbNeCQsMpWPkMbEL9qka9CWdKjw4+HW3jpj+06E+0OOC/w?=
 =?us-ascii?Q?fOgHSP5zwiroO1POx6mLIPfRyXHs0r/sKidHcY/CZ6IGccmKmeXAZamWbvtD?=
 =?us-ascii?Q?Ld61MxnBFEJ+ISiXbWQNl9tgYMa9bGINsEVaheUU7bWEpcD+Ers1KMM6U5qs?=
 =?us-ascii?Q?VdDjXlrkpVz/1yfTOg74/X06lnXA8Jkwf1AD3LI1ONFoaH8y4BOsO2tZJqx8?=
 =?us-ascii?Q?Vxc4J3EH7Cfx8cfbPxCd7ednI6ip8fgAslnf7AjkwtgOcCxoc9fkk/Vkk+d2?=
 =?us-ascii?Q?nzzZ61l1wWohhnJ8I4FzoVTG1N70lSpQz/f1lLCsO2GT+8xHvt6UMvWWgOhH?=
 =?us-ascii?Q?MKDfEI7Ne3TDAfJEKM4fgLy4i7dUbW/BaDVIA4YzvtMlZ/bFLGNKpuKzYBMb?=
 =?us-ascii?Q?iANlkeVS3uwUXNcvKJ2l8HOTj5siF9IkOwmfAhJDwHOYrijsPaOvY7ly7LSd?=
 =?us-ascii?Q?dX1zpxW2s/XZtCD+xn6G0Aim6qm+0/mc0QcwO19Qz/+OfiYGtQSAsYHkDnNa?=
 =?us-ascii?Q?GUelfLsUbM28MVpJStQ/XRNVgrL1LilniUtVj9m8k7YryePtIVBk2j3WSTZp?=
 =?us-ascii?Q?nmzui1F2icL1SetgrzrWFHmh3PdxtCxuXUpwKiTB/oqLnMpiupJQDbADTzNa?=
 =?us-ascii?Q?AI3ISYhV/m3rYj1Qt7Z+GjqDNYIzgkrVJVBDLsz6v/l2jRufvW/Fdt/JfOBY?=
 =?us-ascii?Q?tJ5vI4wJIgwQEpLGA/7aWDZDs54rghkobXOn+7XVZuttKYPqjXapzSC6BAOG?=
 =?us-ascii?Q?MwLI1gge4GuaaJ9J1SjgFkasqpy9C5b7NCGm+Zr0Cb0bKJZ/JnRdQMN3uTrz?=
 =?us-ascii?Q?GiNGH/vdhwcIPps9HGOfpPVJruMVcRKLzOV3gMtK2b2pOuUBUur0qNnpxRZ/?=
 =?us-ascii?Q?ep8wQLF18sqKn7AFQ7Zomqr/QYF6JMUJDgRigf6ggcwDneUKbvuQb9Z2RvLl?=
 =?us-ascii?Q?nogQf7SC3xkwZgjC3L6xtA38mehBKAxuT86j8ecJ18dtnia0DG/ep5UduPbK?=
 =?us-ascii?Q?H4i0N6zKAu9ZHUWoh1LRgUm1Ewi72WIG06glQMUDIkc3q28yvYAu+gKz5sKy?=
 =?us-ascii?Q?EvkQ2/8EhXANjfx7rvYgcrRLm6yTLht2aII4wrTrtlMEkL3OhhD/9IaiYFSM?=
 =?us-ascii?Q?eaLIsNPxd1IzmM7/XWvFH78=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4465.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f44c5c-314b-414d-61b3-08d9befd0c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 12:27:08.5334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSxMEB+n9oSF9KKJyXndqEPKHrU0R2MxtLPy2COWno7NoHl/sGp54rg2xm69Q6dZnILTHLX9FiRz39SSAFsW8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4762
X-Proofpoint-GUID: To1R0IxsNKMkmfHX5ZbAkxiJ6s64aZDW
X-Proofpoint-ORIG-GUID: To1R0IxsNKMkmfHX5ZbAkxiJ6s64aZDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_06,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Will Deacon <will@kernel.org>
> Sent: Tuesday, December 14, 2021 5:55 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: mark.rutland@arm.com; robh+dt@kernel.org; Bhaskara Budiredla
> <bbudiredla@marvell.com>; Sunil Kovvuri Goutham <sgoutham@marvell.com>;
> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH v6 4/4] perf/marvell: cn10k DDR perf event core
> ownership
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Fri, Oct 29, 2021 at 05:26:43PM +0530, Bharat Bhushan wrote:
> > As DDR perf event counters are not per core, so they should be
> > accessed only by one core at a time. Select new core when previously
> > owning core is going offline.
> >
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> > v1->v6
> >  - No Change
> >
> >  drivers/perf/marvell_cn10k_ddr_pmu.c | 50 ++++++++++++++++++++++++++--
> >  include/linux/cpuhotplug.h           |  1 +
> >  2 files changed, 49 insertions(+), 2 deletions(-)
>=20
> I don't think the driver is much use without this patch, so please can yo=
u move
> the Kconfig stuff to a patch at the end so that the driver can't be enabl=
ed in a
> broken state half way through the series?

Okay, will change.

Thanks
-Bharat

>=20
> Will
