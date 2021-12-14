Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B96474074
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhLNKa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:30:29 -0500
Received: from mail-am6eur05on2054.outbound.protection.outlook.com ([40.107.22.54]:24289
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231273AbhLNKa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:30:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyyPYa0yqAcMtRwP+PAglwBhdpj7pkGRtbSqbpkVxGg8MGhM0ZJ8nioOMOHHlpxTR0Zr+Cr2Lk+wzaKHS/QC9VMyR3OORndQPFEkrzBXU/3sdiBHOtY+9Jm8n/rqqsfokGQwAnU6QEjLdrKwGp/ciOm1R20dOAiknVs80mefbwqhMs7TjzqvHVnD5apW2yQS6rkMQ1HzE12b3fKes7grInGY7213vL5sy/67uPDMmV4KeekYSxY3Q0TZW2/Ny2rfp0DMKLlRmt2LDkjasksbivMA4jslm0XgReOj0T9A3gJHfS2kEyx/P4iFawb4oXaj6kAfSgCeVvHFMtRYRNqx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/64Uy3juV+qnk6LeWEansb+2rFQk+/1mdbp6lylSgkA=;
 b=YXjXaBhvHj6T8VSHgMnbv6sZPAUbGAyBIUO/XwSlNaiBc7V/dBV9kXWfeDG3ZzBADXqRCV+2qMOl1noSRUMzK16aPrO3DvuaalFxKBqSeb1lzuzsOecjmTZE93aXbGVzTQF1lRDnzcPYnIT6qizJQlDGFdfzDzYkbq9k3r38RyKWZw3u/y8iJ6Q1hjDudakouEADgWHnHCfVUKqYrgzCNYtaEII99lM7mhsrhE+9t/eZOkJmrfxJmCBcPTfJvCPDhCxcXqS2FJLY7bUanWmc4rokbkxlBhbPlB4HaU7yfTTKXlywh2MeZcRsrVmKQD2SnqSt9Yjt8O6q50PfPcpOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/64Uy3juV+qnk6LeWEansb+2rFQk+/1mdbp6lylSgkA=;
 b=hFOFF/KqiXwsF7/e75bAuKG+YhIVwPAuYYkoGVYqKPwcgfjenXkrPwbtmjBpJNu4CzgspTAwnWYaXhWlOIe/eLUgXmQZKk4poOBU+Ls3u8sAPZdd41ZJyRx4qmY88h4kGLyEdGoA+ZpdfIKfakKyjWzlgBwAhzTm/gR5wBvzOAQ=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR0401MB2685.eurprd04.prod.outlook.com (2603:10a6:800:58::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 10:30:26 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226%3]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 10:30:26 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>, "Z.Q. Hou" <zhiqiang.hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RFC PATCH devicetree 00/10] Do something about ls-extirq
 interrupt-map breakage
Thread-Topic: [RFC PATCH devicetree 00/10] Do something about ls-extirq
 interrupt-map breakage
Thread-Index: AQHX8ItO3xtQxxPJV0yONti9mp5846wxrpCAgAASv4CAAAYSAIAAAr6A
Date:   Tue, 14 Dec 2021 10:30:26 +0000
Message-ID: <20211214103025.wnzkfxr5xxeuhpln@skbuf>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
 <87ilvrk1r0.wl-maz@kernel.org> <20211214095853.4emzycaxkuqr4tun@skbuf>
 <87czlzjxmz.wl-maz@kernel.org>
In-Reply-To: <87czlzjxmz.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9199fa3-80b5-4850-3971-08d9beecbe37
x-ms-traffictypediagnostic: VI1PR0401MB2685:EE_
x-microsoft-antispam-prvs: <VI1PR0401MB2685D1F259080723B603B488E0759@VI1PR0401MB2685.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ynD42gWak2ZltHWMOWwlR4Cra556vl07C4IYA33MMKaBI+/V9jgwrm5cvMHgnt4B4ai7dTTIpiYs5Wu9keRqz8CjC0uSg1m/c97DZtpCfIb7pZ+qJwvdMQPqHc8perPruJbg4ZkJ15gqOWEsmdwE+sHfZnEh7MiEJVhwYMnq+/CAy2LQcnhEoBOwt3643cEyx5Qh/VGDcv55b0HpDY+FfCm1U2pDVH0jyn5HJULDYZswx8BzAZfL28kZ/yWOVRabMUF1SarINmK4qE0ZIGR1yoGZTBzplGOqfdvQHYIrQMB+HQ2uGs+mmA5t1ETrPR6m6kIXgGJ5ktOvKmdjXlOkuPSyWZryJJ3DvW20mHW70HhtM01skwprTste5MGk85WAdr/KEJ4wWUZWbk2uR8e2mct1JyPmoaZgqGGaP0+mhgfiLazfNhu+po/Wmbs3HOHqH1hleJkZBX+REEvSYneE54S7A8IlV0XcsIQRYvrDyx+4VS6aSag6mxQ2ywIK39zQVqYXlBebYDw3N0s+mIZ9xd5SpRc/RoJzmTFPdTEzUbnKFgb+Odq5R1gXjgiNcZ2a3IZi9EPTPoXowg+2yrE7P302s+ZqDv5tWt4ESCTbF4eOy73kGjG6KaYBPN49GSRT5gHe+/jZOpPVuYgnaDkjFRuOg2gMHgGonUA8t+lG3yZfYAp6j7NyZcMZ8e8IJci0Ki+OPGYxwqg3RmU46DzdI7V5BnNYm/poEPden1vYcF5Bh4wzPoNp6KYdwYi8GiI5hP/uzaEHlRLJkj0a4Ycrmh6NVPwcM52l0sTry/OM0s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(6512007)(9686003)(8676002)(33716001)(6506007)(38070700005)(316002)(71200400001)(44832011)(186003)(6486002)(26005)(54906003)(38100700002)(122000001)(2906002)(508600001)(966005)(5660300002)(86362001)(83380400001)(1076003)(91956017)(66946007)(76116006)(66476007)(66556008)(64756008)(66446008)(8936002)(4326008)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3+58Nr/o9brmUNh4kGL5xf7U2U1WqJLZXHi4tcM6PQycl/nt6zcsQjNvcjwe?=
 =?us-ascii?Q?EZugGqZssGTtP5bu3xXTlQ1yJp0kWmwUMnz6+l2eH5pHDYDjtPTaLh+IWQ3w?=
 =?us-ascii?Q?jNK/jNyPCv5ljhOlEMQNt7Hr0X77uLQdVLKXwVP8491UeziEBAImWxdk0kUb?=
 =?us-ascii?Q?PnE3wCxfrKaRfNxWPvF8GKl82lMGOz2u16R41QAry+Nt9k4WRPfW77mqAXhA?=
 =?us-ascii?Q?sDwoyfR480nvhJsO5iPgHLO3mvVHuZn/nPU9H105N0HxIT+JOUWbwaKKK+0k?=
 =?us-ascii?Q?0nB2W0uO4YoWyz3otQGya4+8dR0eVWJtemkItBppezHDenBL0FKWdJp3lkR3?=
 =?us-ascii?Q?knPlxLj5Z4ipyv4G98uV/HJZxqzQqDmXjl7FSQqXtH+LN2qTv8qJcFKl2hW8?=
 =?us-ascii?Q?DBo16HkaT1VAxTRPzaO87prnLcmZfEf68mrFEI8Tbv93RtyZdM13ridrD8I/?=
 =?us-ascii?Q?BtPAA0H6ppmeaC5/gCezMUY8sd/r+zfRNSgPF6dw8Kbf2OdRvuSikHhIj9iW?=
 =?us-ascii?Q?UJFdiXfhZHLY9RI3ladxMJHntjdJaiNZmmZ6sms0TdQKobyAhGwsl3th34vw?=
 =?us-ascii?Q?+mXOtNDHZazgi5bJ8eGDuAVeY6O8AXV4Z+6ZS5rl2UepjfDdBFUH2VYD3/wL?=
 =?us-ascii?Q?OBAWCr+E0p0WGH+2sDB48M6hYVHgVI974ainnzwLwEaI+MYfUWOX306bRjEb?=
 =?us-ascii?Q?vpda0XqeoRyc8xU/q4K12tUQBRXXFRjrzweobvsouJ1qBMIXlpncJr4BvPJe?=
 =?us-ascii?Q?cKP/usM04ZCpktubE85GieMUdaCF/luZwshA2gcDkkKazxgfDmvWVETksMDO?=
 =?us-ascii?Q?IbiA7yZtchYg/2c2fUXnVpFVcCn1GL0glU1U/vzjl5JABqQ1mvZf/EIpMAB4?=
 =?us-ascii?Q?YUQEi+Zy++5qRBe15BgTWWhpvwfP1pT+SlMJ8FseWCzT3IcWKOWMd4Izym9C?=
 =?us-ascii?Q?VIMP8hkxIl2qS/dbroAFm5wdLGyqrYnAyyn0uk3a7hTVClHVyacC3vYfqzxv?=
 =?us-ascii?Q?FO/a5a3w03jW+QifcR1jvz2In03z8Vg60pWNfPg4FiquDskTooL5JNGBqoQw?=
 =?us-ascii?Q?C3zXW8s/0XAmKZnzODnupXX108Qq768CLqZvfYqIOOTD5qB5qmbXSSBu1LyW?=
 =?us-ascii?Q?aI94Wk1j/s2IDtcyQz1IaccnRgOeGwI+hiWv5gkAQp/wLP34MtAU8xuMeOyh?=
 =?us-ascii?Q?u3S2hUhAqNE2vEbqUFf1dH3y2uNN5BVyhbd3CHXv4yZhPQJd6Jf15cwqDTHP?=
 =?us-ascii?Q?h0boG2LWaYzisN7vMdj3lvoTF7VxDOy1wOPeEwmLaww+MvtdcWxr2jvldYxu?=
 =?us-ascii?Q?vqiD1hgtl/oxoyigHIYR3tWpR6pxvSeed2h5xICIp320jn3Jxq58frHjfCLn?=
 =?us-ascii?Q?vFM7ijoF9bFNe11XXTECsFE8A+HpTKPbdWg+MGcXM/wiP2Q+tE947/lXlFYU?=
 =?us-ascii?Q?/xhHzxccEG2CJDLXonLW5LXrPGpckwAcuK3Ka4XjxWWwA9RmvxnfDMtJVCEn?=
 =?us-ascii?Q?fldWv1GeqJ3kIHXREhSl28FSR66drmsTEad5QrnQv76DjB9l79xAFMsNz2XS?=
 =?us-ascii?Q?ozzOvT2107NB1Ye63S97/+QHpOXX2EINm8oV9DjeptKsMIucdv6HTryZobSI?=
 =?us-ascii?Q?vzDmMkdTdJxuF0chSnRR43E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CE4DE0E467A08D4A991DF94FF2F52B2A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9199fa3-80b5-4850-3971-08d9beecbe37
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 10:30:26.1860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZTIrXRmx7PkYNrvrnntRUzFKzA3Z0Bls7uPa+MnlPIDFMZK8990DEbJtcGzeF9Uno2OQLY2TpWtCvxDmKZCqRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2685
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 10:20:36AM +0000, Marc Zyngier wrote:
> On Tue, 14 Dec 2021 09:58:54 +0000,
> Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> >=20
> > Hi Marc (with a c),
> >=20
> > I wish the firmware for these SoCs was smart enough to be compatible
> > with the bindings that are in the kernel and provide a blob that the
> > kernel could actually use. Some work has been started there and this is
> > work in progress. True, I don't know what other OF-based firmware some
> > other customers may use, but I trust it isn't a lot more advanced than
> > what U-Boot currently has :)
> >=20
> > Also, the machines may have been in the wild for years, but the
> > ls-extirq driver was added in November 2019. So not with the
> > introduction of the SoC device trees themselves. That isn't so long ago=
.
> >=20
> > As for compatibility between old kernel and new DT: I guess you'll hear
> > various opinions on this one.
> > https://www.spinics.net/lists/linux-mips/msg07778.html
> >=20
> > | > Are we okay with the new device tree blobs breaking the old kernel?
> > |
> > | From my point of view, newer device trees are not required to work on
> > | older kernel, this would impose an unreasonable limitation and the us=
e
> > | case is very limited.
>=20
> My views are on the opposite side. DT is an ABI, full stop. If you
> change something, you *must* guarantee forward *and* backward
> compatibility. That's because:
>=20
> - you don't control how updatable the firmware is
>=20
> - people may need to revert to other versions of the kernel because
>   the new one is broken
>=20
> - there are plenty of DT users beyond Linux, and we are not creating
>   bindings for Linux only.
>=20
> You may disagree with this, but for the subsystems I maintain, this is
> the rule I intent to stick to.

That's an honorable set of guiding principles, but how do you apply them
here? Reverting Rob's change won't fix the past, and updating the code
to account for one format will break the other. As for trying one
format, and if there's an error try the other, there may be situations
in which you accept invalid input as valid.=
