Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B704CD51C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiCDN05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiCDN04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:26:56 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB5F5BE7C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 05:26:04 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22475FO0002077;
        Fri, 4 Mar 2022 05:25:48 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ek4j63kv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 05:25:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5TuAfdd2Rnzo6Lj4S10c19s23tSvhUe6CBcWBDH8qDS1D2dMaDz9ZeO2SUY0SZMkafCcyUEnaWOtPq1A8DaHatP/vNHc/SjkHW4gl3nSB/dI+ll2rLuO62Em+5W+v9cOx7/oi5Ct7Pu/zj9HcwBaSb0R8S69OmVotEV6JDzqXcTXq2oOgM6YjdYiLzDvQY/EZ2z6FddRff7wZ+fxzSaDkGFTqxt1MA6TvYX3Ai7iNW/yqRSC/hLV4VI9zYVB2LKOw13GZm9EyAGJCR7BNhrtLwT7obLHoC/+HlXq1ERU1dwHx5YxBtJzVToRukGRs9ndvHQE//4YW4T79BJ/Rabyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xudAO6ybTBjIiM2R3RYcPgihFTnutYjftOndViI8QjM=;
 b=YkxA9BmtcvjkU8M0p9ljoixRWNmoPIt1Z52K1g1hBaXcrYGmZGLck4392lEp9QO7gvhSqKQWArBcRd0mbYPZrE61EdyHX2x5rg2FbbAL9CEUQXEE1I47RaKQxjQSophTn2EvdIIxDC3L+Y0ZmaKHO9Cqn10T9dERRFcyIzgUqZG4emuRQq2vTbplMmgN9GPuiw/3E74HXXbN+vgLjkN58rctVxTqX1VZl2o/VPAeJT5PLjx9QTYjaOI1EkXAzzdwMzqgqJ54FzZ3klxHZB4FgV9Euuqg5Y8/lGi9VCCxp29ZJUmK/FG80Heuf8uQNZfRMGhYaheDfFYsFZqCMNDGwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xudAO6ybTBjIiM2R3RYcPgihFTnutYjftOndViI8QjM=;
 b=DAcvmb0n6/B/a2AVoceVi7CrLVq1ffup96eocBLN4wRnHH79eG1lTF0ehHfiVIkagjhnwu65gu7dEtwQ4L9zCz3jJn2ie1m3BwgcmV24kF5c9JKODhCzGXWBH2320F0AAUqUJSHjBMpEjurkEy+yXDu2tiEKUdoeYtBMtgHgA4c=
Received: from PH0PR18MB5002.namprd18.prod.outlook.com (2603:10b6:510:11d::12)
 by MWHPR18MB1373.namprd18.prod.outlook.com (2603:10b6:300:d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Fri, 4 Mar
 2022 13:25:43 +0000
Received: from PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::493d:175f:17e6:8e8d]) by PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::493d:175f:17e6:8e8d%3]) with mapi id 15.20.5038.019; Fri, 4 Mar 2022
 13:25:43 +0000
From:   Linu Cherian <lcherian@marvell.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuc.decode@gmail.com" <linuc.decode@gmail.com>
Subject: RE: [EXT] Re: [PATCH V2] irqchip/gic-v3: Workaround Marvell erratum
 38545 when reading IAR
Thread-Topic: [EXT] Re: [PATCH V2] irqchip/gic-v3: Workaround Marvell erratum
 38545 when reading IAR
Thread-Index: AQHYL2k2E2FeFsn0dkSwz7SJzm5coayu2DWAgAA5DIA=
Date:   Fri, 4 Mar 2022 13:25:42 +0000
Message-ID: <PH0PR18MB50021922303A495B997648FACE059@PH0PR18MB5002.namprd18.prod.outlook.com>
References: <20220304014301.2515-1-lcherian@marvell.com>
 <87ilsutb6w.wl-maz@kernel.org>
In-Reply-To: <87ilsutb6w.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 409e1317-7236-42bd-fb2f-08d9fde27bd3
x-ms-traffictypediagnostic: MWHPR18MB1373:EE_
x-microsoft-antispam-prvs: <MWHPR18MB1373D2F22D2F760C8ECC2A0FCE059@MWHPR18MB1373.namprd18.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hmCBqpqK3hghOCQPz9pQAc6yBfJfWkvpclpecMqxiLRa/DTRq45sTaPI0Eeii7EOIs1bAA2bQLJnpa8ry6kEp3vzJKk3qKAlhU66uLtvnHY7ts6bDsM6RSimX7ZbV5xaBQ+KeGb+xoPrdfPRJ9VSRaMqVm+BnA2Hy6SadJlGqQ6/ahYGwcAz8R5DMgznVcQ1KsDBnL+/se7e4L//JuBMScO1jq3AIEziEOamxuOP+x5pPK6wbw7Pg0ZrmaY8dFBaeKfcAlX/natDmTZZHykP3B5hEegqkmfRULiwIqKlD6d/XrAbSCmRohKhxVI0x79wVCIge3fwoH/p/4/0UYRcWwVMk/yIENdkSL/VHtYLrKtwULs57Slh2atAQ+iY76nVibExZ2yUaOGZMcPjejg5QlHdKBQd3cTdbW9G/HqV68g4Iwrxu0B3tjvCb7uvy9L8bHYBXxkCNwmPghAE0MTiu6t1xwNtvx7hQ5dfRynflQYiJcarpVjz+51jxdklErOW65Ex45l7b5EEAnIwghc73/AUzwgqkUrXto/BvrWUKgsTNuXPjCy/kVpSAO0gob7lJy+wlNtCJX1s6y+TVlWsO7d8jlcuO1B+Q3ZzJ0d7lwURdU6DphkfgJ3UWPZjJt6jbVKZOvXXS8iVwSRLNwoRTbdf+M771OqaBEU1thUnDRoX/5jmWT3JgkJslChXmV5SBe6WgshuDYIki9qF0uTnwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB5002.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38070700005)(122000001)(38100700002)(508600001)(64756008)(8676002)(4326008)(6506007)(7696005)(71200400001)(76116006)(316002)(54906003)(66446008)(66476007)(66946007)(6916009)(66556008)(5660300002)(26005)(83380400001)(55236004)(53546011)(9686003)(52536014)(8936002)(186003)(33656002)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5ky01EzKSR7oB3ad5J/Y0a0XygEWAHvhCHt3qoe//nKzG7xr/RKWRQL3cbZN?=
 =?us-ascii?Q?BBnjo5whC2gdleYkhyaV2qeVOtOzo7gBxI/DFyu+hsJ0iFU9E6a8YVeohLBq?=
 =?us-ascii?Q?jMEro6yXSDPIo3ZDV1AkydZ1ESHhpRW/UiRAlGCk6NI3CsCldhD0XT01UiiY?=
 =?us-ascii?Q?lMKywOB7QVDgLAGEd5cylMMM4LuzYcawFueBsucS7OZB/gtaeqszgXaG5K5P?=
 =?us-ascii?Q?Kt94Y60N5oK7H5wGbAdgd2LXElQlS4Lj5qkoqDGWkcpc/lNaIMgyp+BSbup0?=
 =?us-ascii?Q?pUSbIMxzUdZ7tATORpVuEJZODPTv7+LJoOB7xWa/W3PBCvZEUrFG2vN+ZDGd?=
 =?us-ascii?Q?BMvXWSbQP7Fl+xdse37Ed9bYd/iv3AhbI2zz/qhsBX6ku96U8F0u5V3FMYV6?=
 =?us-ascii?Q?HtuJPTZgMP1nYRRGV7rrb7bYfJHG8bJKXvtp7fyvD8lN0RXwB7MfK2rkWgxb?=
 =?us-ascii?Q?cU0Iep09R0MNkeZ99d+sPEPJ9w+rmi29Nt7jWSDlnt4a1JUQmDtK7tpaUUyY?=
 =?us-ascii?Q?zcxju9KUGvLF8M93D3SpicldLLBeJE7ayYMdHgHZw74rO/neG2DcbjBd3YPx?=
 =?us-ascii?Q?2eNVdHqh7qRw3sOfz3ktsqHfXQCEZ6noh+IwWrSvg6KcT925yqYuRpkFGFYJ?=
 =?us-ascii?Q?ZOBk76oa+0EpgbEQ2iybF+Du57qgMuSbCaBD0uuq4PY4IM3+11fW9oAuPlOB?=
 =?us-ascii?Q?DBnkC5FrYKpU+WenGG9OZRXjIBtMOVhNOqYTMZ6iYVqGChayP2zmcMim0t23?=
 =?us-ascii?Q?4DN6Fk9+vsZBMaLLkCQo5cVmyCR9APaSre7VkVTa0D9ZQJnN6HXHogf5FVxG?=
 =?us-ascii?Q?tBHJ1mq5Lo2AKKoF6ZRnpg0PYGOJTd+CWkWHgMTQiLgi8ppDWWSs2qVIdVVq?=
 =?us-ascii?Q?bAnGPicE7atTZAWDgveZN0Rp4o4zqNfoM6zuuDLDD3k8iqsuA1AcKeoNesEh?=
 =?us-ascii?Q?Va6FYQVAuKvaQf/mEjp6F2QJfykpFajXBYDc5L744a+fyq26VwdyEwR0d31d?=
 =?us-ascii?Q?S9np991a2JIGs1jCyRzGdtRg3ssyEm3VSQ5JaHqESr8HtucIlt2Kw7jp/ork?=
 =?us-ascii?Q?nI/X2EA3Dg+ijXnZAtXr4MLiTT4uFgx4vDvWp8JFGdUTOOVFA/Bj0fOEWHpN?=
 =?us-ascii?Q?9CG+nnxALkll9DhWW3k07zYUM4Ut3ZjqApnm2YhGSbVZcl/fI+XAG5hMJVMK?=
 =?us-ascii?Q?DABTKKo9jHcyjVsubSv7w+fv8H1d2NYtKCT3Z2eh77Z7jCjF8WeD4WfJCLiX?=
 =?us-ascii?Q?COcpt/UDafERwfQNseJgxiWDSJtrRi6BNXCAimrkbsrrMMQnFoYiVt2wg9BV?=
 =?us-ascii?Q?QsEiihUkQDuzXH1Tfg1GHMJAlWNoMgtw5juzHUlZO1WrpB5k8gHFzFznyN4v?=
 =?us-ascii?Q?9cZ0M73iVfxGYxF4mYWq0U8UlXoVacTpHismb1aVpMoukZ4gzpOOmgWD8C58?=
 =?us-ascii?Q?MyVeinb++sp13BJHlvjsPNFztZMfZHLxM3i0HjNAPDXOO3xd48xgn5ARs4s9?=
 =?us-ascii?Q?2q4GuYNvHStW0bYB0gfjhNBEFJAAwEAvSsdp4VXAXrHKZ/vf2gGTSkbf2Aum?=
 =?us-ascii?Q?cJPxHxlfxXwjvbJ+u5UZTkC80lL0gu0ruVCOfq1rS2W2+9nwBgyV+2/gm1Hw?=
 =?us-ascii?Q?NJOMSygPWz+Vk5n0ORKImzg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5002.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409e1317-7236-42bd-fb2f-08d9fde27bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 13:25:42.8905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQpUqy9sgta/HDjfFSg7M0QLejuouE1QSzbXgAMvTMHYc0XpPtc469d+7Dd9CR44A1x4LXEkTSSkWHEk8o4lgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR18MB1373
X-Proofpoint-GUID: mQkgPGdmqZDVtkI48VZ72jG6nw9evSHv
X-Proofpoint-ORIG-GUID: mQkgPGdmqZDVtkI48VZ72jG6nw9evSHv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_06,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Friday, March 4, 2022 1:13 PM
> To: Linu Cherian <lcherian@marvell.com>
> Cc: tglx@linutronix.de; catalin.marinas@arm.com; will@kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linuc.decode@gmail.com
> Subject: [EXT] Re: [PATCH V2] irqchip/gic-v3: Workaround Marvell erratum
> 38545 when reading IAR
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Fri, 04 Mar 2022 01:43:01 +0000,
> Linu Cherian <lcherian@marvell.com> wrote:
> >
> > When a IAR register read races with a GIC interrupt RELEASE event,
> > GIC-CPU interface could wrongly return a valid INTID to the CPU for an
> > interrupt that is already released(non activated) instead of 0x3ff.
> >
> > As a side effect, an interrupt handler could run twice, once with
> > interrupt priority and then with idle priority.
> >
> > As a workaround, gic_read_iar is updated so that it will return a
> > valid interrupt ID only if there is a change in the active priority
> > list after the IAR read on all the affected Silicons.
> >
> > Since there are silicon variants where both 23154 and 38545 are
> > applicable, workaround for erratum 23154 has been extended to address
> both of them.
> >
> > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > ---
> > Changes since V2:
> > - IIDR based quirk management done for 23154 has been reverted
> > - Extended existing 23154 errata to address 38545 as well,
> >   so that existing static keys are reused.
> > - Added MIDR based support macros to cover all the affected parts
> > - Changed the unlikely construct to likely construct in the workaround
> >   function.
> >
> >
> >
> >  Documentation/arm64/silicon-errata.rst |  2 +-
> >  arch/arm64/Kconfig                     |  8 ++++++--
> >  arch/arm64/include/asm/arch_gicv3.h    | 22 ++++++++++++++++++++--
> >  arch/arm64/include/asm/cputype.h       |  2 ++
> >  arch/arm64/kernel/cpu_errata.c         | 25 ++++++++++++++++++++++---
> >  5 files changed, 51 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/arm64/silicon-errata.rst
> > b/Documentation/arm64/silicon-errata.rst
> > index ea281dd75517..466cb9e89047 100644
> > --- a/Documentation/arm64/silicon-errata.rst
> > +++ b/Documentation/arm64/silicon-errata.rst
> > @@ -136,7 +136,7 @@ stable kernels.
> >  +----------------+-----------------+-----------------+----------------=
-------------+
> >  | Cavium         | ThunderX ITS    | #23144          | CAVIUM_ERRATUM_=
23144
> |
> >
> > +----------------+-----------------+-----------------+----------------
> > -------------+
> > -| Cavium         | ThunderX GICv3  | #23154          |
> CAVIUM_ERRATUM_23154        |
> > +| Cavium         | ThunderX GICv3  | #23154,38545    |
> CAVIUM_ERRATUM_23154        |
> >  +----------------+-----------------+-----------------+----------------=
-------------+
> >  | Cavium         | ThunderX GICv3  | #38539          | N/A            =
             |
> >
> > +----------------+-----------------+-----------------+----------------
> > -------------+ diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 09b885cc4db5..778cc2e22c21 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -891,13 +891,17 @@ config CAVIUM_ERRATUM_23144
> >  	  If unsure, say Y.
> >
> >  config CAVIUM_ERRATUM_23154
> > -	bool "Cavium erratum 23154: Access to ICC_IAR1_EL1 is not sync'ed"
> > +	bool "Cavium errata 23154 and 38545: GICv3 lacks HW
> synchronisation"
> >  	default y
> >  	help
> > -	  The gicv3 of ThunderX requires a modified version for
> > +	  The ThunderX GICv3 implementation requires a modified version for
> >  	  reading the IAR status to ensure data synchronization
> >  	  (access to icc_iar1_el1 is not sync'ed before and after).
> >
> > +	  It also suffers from erratum 38545 (also present on Marvell's
> > +	  OcteonTX and OcteonTX2), resulting in deactivated interrupts being
> > +	  spuriously presented to the CPU interface.
> > +
> >  	  If unsure, say Y.
> >
> >  config CAVIUM_ERRATUM_27456
> > diff --git a/arch/arm64/include/asm/arch_gicv3.h
> > b/arch/arm64/include/asm/arch_gicv3.h
> > index 4ad22c3135db..b8fd7b1f9944 100644
> > --- a/arch/arm64/include/asm/arch_gicv3.h
> > +++ b/arch/arm64/include/asm/arch_gicv3.h
> > @@ -53,17 +53,35 @@ static inline u64 gic_read_iar_common(void)
> >   * The gicv3 of ThunderX requires a modified version for reading the
> >   * IAR status to ensure data synchronization (access to icc_iar1_el1
> >   * is not sync'ed before and after).
> > + *
> > + * Erratum 38545
> > + *
> > + * When a IAR register read races with a GIC interrupt RELEASE event,
> > + * GIC-CPU interface could wrongly return a valid INTID to the CPU
> > + * for an interrupt that is already released(non activated) instead of=
 0x3ff.
> > + *
> > + * To workaround this, return a valid interrupt ID only if there is a
> > + change
> > + * in the active priority list after the IAR read.
> > + *
> > + * Common function used for both the workarounds since,
> > + * 1. On Thunderx 88xx 1.x both erratas are applicable.
> > + * 2. Having extra nops doesn't add any side effects for Silicons wher=
e
> > + *    erratum 23154 is not applicable.
> >   */
> >  static inline u64 gic_read_iar_cavium_thunderx(void)
> >  {
> > -	u64 irqstat;
> > +	u64 irqstat, apr;
> >
> > +	apr =3D read_sysreg_s(SYS_ICC_AP1R0_EL1);
>=20
> Why only AP1R0? Does the HW only support 5 bits of priority? If it suppor=
ts
> more, you need to check all the registers that may contain an active prio=
rity
> (0xa0 for a standard interrupt, 0x20 for a pNMI).
>=20

Yes correct. HW supports only 5 bits of priority groups.
Will note this in the comment.

> >  	nops(8);
> >  	irqstat =3D read_sysreg_s(SYS_ICC_IAR1_EL1);
> >  	nops(4);
> >  	mb();
> >
> > -	return irqstat;
> > +	if (likely(apr !=3D read_sysreg_s(SYS_ICC_AP1R0_EL1)))
> > +		return irqstat;
> > +
> > +	return 0x3ff;
>=20
> This should be ICC_IAR1_EL1_SPURIOUS.

Looks like we need fixes like below in couple of files to make use of this =
macro.

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm=
_host.h
index 5bc01e62c08a..d02b7339d21a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -18,7 +18,7 @@
 #include <linux/kvm_types.h>
 #include <linux/percpu.h>
 #include <linux/psci.h>
-#include <asm/arch_gicv3.h>
+#include <linux/irqchip/arm-gic-v3.h>

Should I consider fixing these ?=20
At least  its builds fine for me with similar header fixes.

>=20
> >  }
> >
> >  static inline void gic_write_ctlr(u32 val) diff --git
> > a/arch/arm64/include/asm/cputype.h
> b/arch/arm64/include/asm/cputype.h
> > index 999b9149f856..9407c5074a4f 100644
> > --- a/arch/arm64/include/asm/cputype.h
> > +++ b/arch/arm64/include/asm/cputype.h
> > @@ -80,6 +80,7 @@
> >
> >  #define APM_CPU_PART_POTENZA		0x000
> >
> > +#define CAVIUM_CPU_PART_THUNDERX_OTX_GEN 0x0A0
>=20
> Is this an actual part number? What does 'GEN' stand for?
>=20

No, this is not an actual part number. GEN was meant to be generic
to cover a group of part numbers.

> >  #define CAVIUM_CPU_PART_THUNDERX	0x0A1
> >  #define CAVIUM_CPU_PART_THUNDERX_81XX	0x0A2
> >  #define CAVIUM_CPU_PART_THUNDERX_83XX	0x0A3
> > @@ -121,6 +122,7 @@
> >  #define MIDR_CORTEX_A710 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM,
> > ARM_CPU_PART_CORTEX_A710)  #define MIDR_CORTEX_X2
> > MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
> #define
> > MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM,
> > ARM_CPU_PART_NEOVERSE_N2)
> > +#define MIDR_THUNDERX_OTX_GEN
> MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM,
> > +CAVIUM_CPU_PART_THUNDERX_OTX_GEN)
> >  #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM,
> CAVIUM_CPU_PART_THUNDERX)
> >  #define MIDR_THUNDERX_81XX
> MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM,
> > CAVIUM_CPU_PART_THUNDERX_81XX)  #define MIDR_THUNDERX_83XX
> > MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM,
> CAVIUM_CPU_PART_THUNDERX_83XX) diff
> > --git a/arch/arm64/kernel/cpu_errata.c
> > b/arch/arm64/kernel/cpu_errata.c index b217941713a8..82ed09b363d6
> > 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
> > @@ -41,6 +41,25 @@ is_affected_midr_range_list(const struct
> arm64_cpu_capabilities *entry,
> >  	return is_midr_in_range_list(read_cpuid_id(),
> > entry->midr_range_list);  }
> >
> > +static bool __maybe_unused
> > +is_marvell_thunderx_otx_family(const struct arm64_cpu_capabilities
> *entry,
> > +			       int scope)
> > +{
> > +	u32 model;
> > +
> > +	WARN_ON(scope !=3D SCOPE_LOCAL_CPU || preemptible());
> > +
> > +	model =3D read_cpuid_id();
> > +	/* 0xe8 mask will cover  0xA1 - 0xA3 and 0xB1 - 0xB6 series with
> > +	 * 0xAF and 0xB8 as exceptions
> > +	 */
> > +	model &=3D MIDR_IMPLEMENTOR_MASK | (0x0e8 <<
> MIDR_PARTNUM_SHIFT) |
> > +		 MIDR_ARCHITECTURE_MASK;
> > +
> > +	/* This includes Thunderx, OcteonTx, OcteonTx2 family of processors
> */
> > +	return model =3D=3D MIDR_THUNDERX_OTX_GEN; }
> > +
>=20
> No, please.  This is a version of the Kryo hack, only worse. We
> *really* want to see an actual list of models and revisions, not an obfus=
cated
> mask that covers HW that may or may not exist. All the infrastructure is =
there
> to describe these constraints as data, just make use of it.
>=20

Ack. Will change this to actual part numbers.=20


> >  static bool __maybe_unused
> >  is_kryo_midr(const struct arm64_cpu_capabilities *entry, int scope)
> > { @@ -425,10 +444,10 @@ const struct arm64_cpu_capabilities
> > arm64_errata[] =3D {  #endif  #ifdef CONFIG_CAVIUM_ERRATUM_23154
> >  	{
> > -	/* Cavium ThunderX, pass 1.x */
> > -		.desc =3D "Cavium erratum 23154",
> > +		.desc =3D "Cavium errata 23154 and 38545",
> >  		.capability =3D ARM64_WORKAROUND_CAVIUM_23154,
> > -		ERRATA_MIDR_REV_RANGE(MIDR_THUNDERX, 0, 0, 1),
> > +		.type =3D ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
> > +		.matches =3D is_marvell_thunderx_otx_family,
> >  	},
> >  #endif
> >  #ifdef CONFIG_CAVIUM_ERRATUM_27456
>=20
> Thanks,
>=20
> 	M.
>=20
> --
> Without deviation from the norm, progress is not possible.
