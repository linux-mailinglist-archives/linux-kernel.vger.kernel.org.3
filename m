Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253E146CC4B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 05:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhLHEUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 23:20:53 -0500
Received: from mail-bn8nam12on2074.outbound.protection.outlook.com ([40.107.237.74]:22113
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230048AbhLHEUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:20:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhBeywGd6dskDPVjqmqe0IEO+G7B5XdlGWJ0Ryun2+LNAz86l2WobOmu3XussjZ3VhfKFSCMlSukP2L13At0qGiFOdzxl95VxVQJQI9LenChwnpXOYUfNopVaOS+5plltSZq+ibUatEsRu3Bpvz8bxuQ5kgxEI/Wm01Gjk9QsMNSLyekycU1LiiWrIkjzidF18B+4j4fv3flqdpVa7WYnRkjb2X+Kd7uunYPXfFIZQvKgso9pUTWb1fv/ocr5/SGLtt6B8sjUt8AMIWVJe1rRCoiQE5cw3cTjVCYYPZF45rBT183oLI4s271iiDtbU94zVzSu2RP6lw9Xq9WsYwGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AHZUZjHw7UgimpMBvBavZykeUOQCkueL6X0NfrHpfs=;
 b=nb9kLFCI1zgH3DNvumZABEpRYGbq5MwnyOyvCbgUYjwk0/u8rfLw0sKSMwNGvXaKvIpJvN+n8NqSAdtGaL+QpHahUVmmfZ0ySsOrhubtuCzBAp36GYedsuvO8BE7rKmsNq6XBZBYoz/deVAYoJtiqhukI6urkGMoIkAqFVARKK69DNY7mDj7mpWUCWo+2ZiG76yfXsV/JRun2LMppGAcWxawJNec0j+isXtzJ7fHpK143AFpXJhnEmltfE7MaplPG91UmBeiiIskm7r0A8K4pr8s+fBf3Oh3XbgYs2MitOpsP658HgjmZVGZdqba6GPAy0cht0mXE2J7IDg9yrtIRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AHZUZjHw7UgimpMBvBavZykeUOQCkueL6X0NfrHpfs=;
 b=eeWfnrwoBcvQJQ22wSWGHipSFYVjT9NT5KPk1DvAFyraDR2eyyM2vyexZFGIwb7IsJzO/Vkwwj0TMCOPB5Br8bRYP5P2UHMK/FvnNWoxbDT5sceaZCrqa56xgtkU/YyhWfZV0u2Cl9oegMS/1Gd6axzknX6cIvrltbMXQv73hKo=
Received: from PH0PR02MB7271.namprd02.prod.outlook.com (2603:10b6:510:1c::9)
 by PH0PR02MB7685.namprd02.prod.outlook.com (2603:10b6:510:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 8 Dec
 2021 04:17:16 +0000
Received: from PH0PR02MB7271.namprd02.prod.outlook.com
 ([fe80::7538:dabf:645b:1b6d]) by PH0PR02MB7271.namprd02.prod.outlook.com
 ([fe80::7538:dabf:645b:1b6d%6]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 04:17:16 +0000
From:   Harsha Harsha <harshah@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Harsh Jain <harshj@xilinx.com>
Subject: RE: [RFC PATCH 3/6] dt-bindings: crypto: Add bindings for ZynqMP SHA3
 driver
Thread-Topic: [RFC PATCH 3/6] dt-bindings: crypto: Add bindings for ZynqMP
 SHA3 driver
Thread-Index: AQHX5cfr6to0KPQfhEexxeTWGhF7m6wnl6kAgABwLGA=
Date:   Wed, 8 Dec 2021 04:17:15 +0000
Message-ID: <PH0PR02MB7271C9F92C667D80AB0A5CA8DE6F9@PH0PR02MB7271.namprd02.prod.outlook.com>
References: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
 <1638262465-10790-4-git-send-email-harsha.harsha@xilinx.com>
 <Ya/SYqbVTPRdch5x@robh.at.kernel.org>
In-Reply-To: <Ya/SYqbVTPRdch5x@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4349f9ca-91ea-4dc3-d696-08d9ba019e25
x-ms-traffictypediagnostic: PH0PR02MB7685:EE_
x-microsoft-antispam-prvs: <PH0PR02MB76857B70A50E65901FDCC771DE6F9@PH0PR02MB7685.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WvlqfZiq9DDEscT33OZyL+8YhdeLxVC43pmmBjk/kax3OA4ZXh4QrrCZnjf4v9LrK0I/Zu0l82S5XgkCl76eNbg7XE8ct2DZYWyO23H9gJq8oboMdK5Ounq5a3iW5nlEseK8Z3nO/AY+NxiwiyunTX1gxR+HiCYjmJ03vL/Qb1VwQI6pSHAW2vvNFX7OObEzUhmQ0S6OKyB5h3Ry/PBGPG1ycx6y0Ytz6ToCtvEnL8hSAxGWYK5TawnXRHL4s5/PDFNDDwouFE1kMUcEtRYjfsLURlCQyHHDSrDz/GIPOYoa5v9ZXyxTYnAcOfi0MmfQp9WJJDae6kEy3S5gBubelt/naQtDAY0QyPLYhoVaPPf6z1BTqE8CNx30bEMd6+7UiJzCuQJB6JHKtzPVfCAcKGEwd+cFf2lpEENZst/j3jaKWL9KTC8OvWkDgdjhSmRRijQjEeJ4cj8Sv1yoZjtS6q/iEVQHM9kWI67rNemXLr6G/7AJCeOFcOFn2vgtU8eEqrd8TRvnO55LrNGtLQ/2Xm5jdf0UBb3EDYkBEJ9zj9sJ+rjCuHRfF7X1uGWImoIni/dEP1ij0Z3gmYDs+Cr0z/6pMLSvQ5Y2LnYrJ7Qcv0aeg+S8oDMUKUUODTtX5hSC1ftarLHo/qvEwKu6HgdsgLdI5i3tX+kpmZjk18frsk+C2xzfwHuygCoPvlNZ4m/f4XGtn6XpeIEzJ4kT6j5IvIqmO5Zia5MgpsuXI8hAoDrVxthQzsspjaqrbnt9oIT9EhNhARZwjeI8VpzUmEt+mh+2D5muN/GjFWurpcA0zkC8qaN9nuJkpMyOJTLrG0usVnSMtJSg9yOTlljLQnO2YA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7271.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(5660300002)(7696005)(8936002)(54906003)(83380400001)(4326008)(64756008)(66946007)(53546011)(66556008)(66476007)(38070700005)(122000001)(66446008)(33656002)(966005)(6506007)(2906002)(71200400001)(86362001)(107886003)(186003)(316002)(9686003)(6916009)(52536014)(26005)(8676002)(508600001)(76116006)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cr/qdHO7yG8MXbxGZYS1B1+6Qtumgj8vjdLCUUG5d9uxlFOGXuBgXQH/U0Tc?=
 =?us-ascii?Q?gFaHkfygwO+AaU3xPoKKpduS7hyXHuENWkURABFSCl3ta3oudGQaw1NOcadH?=
 =?us-ascii?Q?vFbDV3CX8xqxzywASkn+WL0MFZKwlkPqFgyrmnZ3eP5gxUWD2M4KFVZ+23uH?=
 =?us-ascii?Q?btS1mpUJncaFFwbwSsSGDDHUMu8OIZAldiITUfv2Rc1+du4E5xWEy8qYg/SF?=
 =?us-ascii?Q?/6MVnC9nxmztat3YGyWcr6qzC/YLzaLW0tagQTLd3GapQtP5UmrnyPfwmBeQ?=
 =?us-ascii?Q?Xq4NgW0K4q6tHn7TH/jrMB6H0wxh/sNM0OWjgOz9Fa9t60pTFD7UXItL4L33?=
 =?us-ascii?Q?53RRXALc5pbtjQfdMsuoTPAbyhEyqQauXX9Z+XuaOhjs6PcWrfxYWBpKvCzo?=
 =?us-ascii?Q?fcSGoAdSe2Oe285RHxVsMNtbIz4xMaDqmpjeKVH9HrdBU5Vy0faFTuNaGAMB?=
 =?us-ascii?Q?vQWh0s0zDqW2Y4s8rhrpY9tbsgWZ5rVR4cqDMz8J4RfwGv+2vnhwFtZe6Va8?=
 =?us-ascii?Q?V91cIaWHOAIbXFJHu/K8TgJwZkMv2VD7OZzmhVofSEve4X7F+m17jriw3I5K?=
 =?us-ascii?Q?lU53ljrZn/NdyAN5tDph+c01S1hbE+JJu8LBKvwLU9IBraAZBggNn40qTMHc?=
 =?us-ascii?Q?2kzkokXTzxf5d635Xp6i/L1Wd0ASzY+V2YotDdakVOQvpKrRSG6+eI8PAotD?=
 =?us-ascii?Q?c/+BDJrKyKzxutUXVIa3JMdvALFowKLb8V47R/AhZEbsIkwuPKnvAtg2UPZ4?=
 =?us-ascii?Q?7Euxr4esf7vcn4HRr+rIZTXc492QaKYZk0QrRIgJqOk78SWKDsXcI1DblO8X?=
 =?us-ascii?Q?vAmpfYl1x+cD0IvgARcs3zL5DLBHGLzk6U9We/InSWo8z3kdnSgDfG42O37P?=
 =?us-ascii?Q?Wh9RDCO2ycWe520GJd6M+TdJq50PF/1Ajro3dQ2VBbMAoOsWUf7CBCLxqIJC?=
 =?us-ascii?Q?Y2NW27Ls//q+r/0SQPZycXZIuFDwJNcWqSTpimyuKUAPjl9l/V85o4gWf3DF?=
 =?us-ascii?Q?ZJE2Xme8+jui6MX53YJFTke6hP09PI+FMk3J01HdyVafLwfGP38UCouJ2dHW?=
 =?us-ascii?Q?0ipJ7k4+TSJH9bynUIDsH8i1waqbJ9UAFIdYTx3biEaNpF7422BSudYW1Ah/?=
 =?us-ascii?Q?K7RNtmza6w6qw9cmnOOvr7MZpqF2aSVfvKIToVires3j7jeh5dg/n4rIfT+D?=
 =?us-ascii?Q?fmJjYDqQTh9A30rajyFB5vA5XfEsoR4t2Xcn7OJbLWDcDfZkYmHwgCdGLOgR?=
 =?us-ascii?Q?JixJb0E9lae+Elh9DAbPedZrDn7yijnSY2OASoxuVaIJL/xZBBdasJF0Njja?=
 =?us-ascii?Q?2yTWiOsUF6T2DRA61mqtn/9P+3zQTLCc5cdPfuEJ1knZhd0a0nf3p2Ice3Na?=
 =?us-ascii?Q?ZKvjUUJuSQLGjaSn+07qom7o4PDJ2PVzJnUBGeFSSt10w7dxj4P3Pb3hkNFf?=
 =?us-ascii?Q?Id8W0D0bNAcGXSqJxc+IQJJtvWgtXGxGenB4NWo0lrsl/+lexS1SmSFJcN+F?=
 =?us-ascii?Q?5sHGXR2tXh1exHh45B7pyjCO6wXTlPBWszHQU8DJmsE/uWLnxgyVEEku0Tjx?=
 =?us-ascii?Q?Nh+gkgYaogSWXVPhPSY+abzwvR/zb0rCieP3i/x4DXMDbbe0a8wHxChkIZDl?=
 =?us-ascii?Q?LA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7271.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4349f9ca-91ea-4dc3-d696-08d9ba019e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 04:17:15.9087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: og6SERDF886VQsjaNkshcNa8PVnKbEV/rg93UTSXQ2hROLvIcUuY9aP3vqCoWtIVUBhUPLR9JnNXGHJXvpSXug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7685
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for your review.


> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, December 8, 2021 3:00 AM
> To: Harsha Harsha <harshah@xilinx.com>
> Cc: herbert@gondor.apana.org.au; davem@davemloft.net; linux-crypto@vger.k=
ernel.org; linux-kernel@vger.kernel.org; Michal
> Simek <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org; devicet=
ree@vger.kernel.org; Sarat Chand Savitala
> <saratcha@xilinx.com>; Harsh Jain <harshj@xilinx.com>
> Subject: Re: [RFC PATCH 3/6] dt-bindings: crypto: Add bindings for ZynqMP=
 SHA3 driver
>=20
> On Tue, Nov 30, 2021 at 02:24:22PM +0530, Harsha wrote:
> > This patch adds documentation to describe Xilinx ZynqMP SHA3 driver
> > bindings.
> >
> > Signed-off-by: Harsha <harsha.harsha@xilinx.com>
> > ---
> >  .../bindings/crypto/xlnx,zynqmp-sha3.yaml          | 30 ++++++++++++++=
++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/crypto/xlnx,zynqm=
p-sha3.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-sha3.=
yaml
> b/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-sha3.yaml
> > new file mode 100644
> > index 0000000..45a8022
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-sha3.yaml
> > @@ -0,0 +1,30 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/crypto/xlnx,zynqmp-sha3.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Xilinx ZynqMP SHA3 Hardware Accelerator Device Tree Bindings
> > +
> > +maintainers:
> > +  - Harsha Harsha<harsha.harsha@xilinx.com>
>=20
> space               ^

Accepted. Will remove space in next version of patch series.

>=20
> > +
> > +description: |
>=20
> Don't need '|' if no formatting to preserve.

Accepted. Will remove | in next version of patch series.

>=20
> > +  The ZynqMP SHA3 hardened cryptographic accelerator is used to
> > +  calculate the SHA3 hash for the given user data.
> > +
> > +properties:
> > +  compatible:
> > +    const: xlnx,zynqmp-sha3-384
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    xlnx_sha3_384: sha3-384 {
>=20
> crypto {
>=20
> > +      compatible =3D "xlnx,zynqmp-sha3-384";
>=20
> You need some way to access this h/w.

Accepted. Will add required details similar to https://git.kernel.org/pub/s=
cm/linux/kernel/git/herbert/cryptodev-2.6.git/tree/Documentation/devicetree=
/bindings/crypto/xlnx,zynqmp-aes.yaml=20

>=20
> > +    };
> > +...
> > --
> > 1.8.2.1
> >
> >

Regards,
Harsha
