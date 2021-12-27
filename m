Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A3F48017E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 17:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhL0QRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 11:17:01 -0500
Received: from mail-centralusazon11021025.outbound.protection.outlook.com ([52.101.62.25]:14924
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231254AbhL0QRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 11:17:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbU8YlE27uzvxq5s53PkLYhGc+3QT5SJPs9EKljjnysQw5BpTrB+ZHfAMbMtc+eF76yjYh0aSp89MfXLQP4ashT4cS7N11KQcj9/rVBlBM4ed+sKDB5qsfZgxYLfFBy62yyGr6Eshb8yaNCI8SYexHTIVBM+HOQya0km4TX4AjEX0Y7959BX17JySFpIATPc9bxF4cMZ1GSaDPceiMBUYCRxJnf6G4pDKcOzuXI7N3ML1utX4rYQw3IMpzizyKqUvG1bFuygoBE31JnuRdohm3VldZjph7HrlyYP2pE8eNsAZMaQjbU4IC4Cl+5L0Pqv67rfr7EAQAI32ohMLCRaog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jPyoPpkFWYN7PfZKplJ+JQl3crbL40EeOfq/XoNCg8=;
 b=oIWJ7y3zMC/Ue3Zkbg2LvCMUyenABXGCcYVQT4RxbBtKXyloupYh8bC+Id8OIxtTD4mzuExJVY2WO+9qYfsGu8XLGUTbX7wXLYA4yf4wtJIyYN+S0L8pP6STtZufIRih39YN4nR16wVDZR5bVtDB5lG4OdwOGPcRwvqz0sGNn1Z6RcIYng3DHKAWpTbygUXEHzI8o4tlMTFmKRAYAIaotO0G+w/6rYAZLqkehFC8CUKx6YULz0rsTn/1otx8uFMsjp4R3fRw9UhhlWYxtCHjCMn8M/kkqYHDqjQIQQeJzRXKtaDXhkZvz0BeSvuRvnRn0yKwLwOzwk/HjOPw5HXHeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jPyoPpkFWYN7PfZKplJ+JQl3crbL40EeOfq/XoNCg8=;
 b=WzhHCNub0Z7PyeikPKlUM1nIBVECUyKIfFVBSgk/iTWEBlRbSgsuTYicV+VT+kP+nAnF9+OKOp/HAymPj1ktjwj2OrpRY2RFmOFR56BLz4EQ3auEVFAmGIUOdI03knTlrQ7YREhutjR3zxLBN4aVREbb1wCU0wgMsh95wMWQsVk=
Received: from DM6PR21MB1323.namprd21.prod.outlook.com (2603:10b6:5:175::10)
 by SN6PR2101MB1824.namprd21.prod.outlook.com (2603:10b6:805:5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.3; Mon, 27 Dec
 2021 16:16:56 +0000
Received: from DM6PR21MB1323.namprd21.prod.outlook.com
 ([fe80::4985:6c6f:d7e8:22c5]) by DM6PR21MB1323.namprd21.prod.outlook.com
 ([fe80::4985:6c6f:d7e8:22c5%4]) with mapi id 15.20.4844.006; Mon, 27 Dec 2021
 16:16:56 +0000
From:   Jarrett Schultz <jaschultz@microsoft.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jarrett Schultz <jaschultzms@gmail.com>,
        Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH RESEND v4 1/4] dt-bindings: platform:
 microsoft: Document surface xbl
Thread-Topic: [EXTERNAL] Re: [PATCH RESEND v4 1/4] dt-bindings: platform:
 microsoft: Document surface xbl
Thread-Index: AQHX9sHUjE/wr4iCGUqf1MzIH7Mjp6w+vVPwgAfGz4CAAAYScA==
Date:   Mon, 27 Dec 2021 16:16:55 +0000
Message-ID: <DM6PR21MB1323319815EFD885339C8F9BA5429@DM6PR21MB1323.namprd21.prod.outlook.com>
References: <20211221182826.2141789-1-jaschultzMS@gmail.com>
 <20211221182826.2141789-2-jaschultzMS@gmail.com>
 <YcJiBk5f071eJ5+n@robh.at.kernel.org>
 <DM6PR21MB13230483733ECB77304EC416A5429@DM6PR21MB1323.namprd21.prod.outlook.com>
 <CAL_JsqLuwvxkxeOmZQVOpMX_aA83LzEc4Tg+bkcFp3mUZYiTKw@mail.gmail.com>
In-Reply-To: <CAL_JsqLuwvxkxeOmZQVOpMX_aA83LzEc4Tg+bkcFp3mUZYiTKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2810bdd6-e72f-4b41-8261-9e8cbe0cbc75;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-27T16:07:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6148b2f5-3e23-4bb5-db66-08d9c9544d4a
x-ms-traffictypediagnostic: SN6PR2101MB1824:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <SN6PR2101MB1824801CFDB560F3635D0AD6A5429@SN6PR2101MB1824.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N7yRYeyC1a6RwcfuEc2ffM6zjyRuSWdgdprCZk/bek91FUUoo6wyXLXUcvhrvgDkBKpmK3zCbxT2HQUhygInRQHyEC9sBuhyWwy8xzVLJH3Av8fMUFD3oy9cLGV6xfo36GWa4GRZBSML7HlYUXJ48gVyAQ8GBrRZvKE7e6QMBvakw4pFmHUIQTPvUV72dmxv5H/OSl0sbV/hLVqOvSdyHQV4ct3AL8+6kNj8Cn0GBdplTGzvSQhZTx2bmy5j8QUw4p55ji0aRvtIXUDsRqRO3cT3VewEur97QrMQ5jbTsSLDd89LnOEGVLDppB/8Jiyaboiafj/SuSnxitzwnzOdKNV6lGjdeLL4S3/8PJ2RwPWkecXup7+qZKiuUTwWicfj3ra+GX/FD5h5GZknxRetOEqC+LvqU09HStxOAjXlYo9bpTzhH/ckqer2zFfo54OPJX7XcUkPFXKqbpzchqza2CefbSAt+ZMak8x3YGAOZqX7yK9nENtONJpOVp3Gs9uoTSFbUn+idht8lQfB9pktqca4eg2yan81PLjkQ2VRlq5c2DVuhbrZZEGkBOqbY6rjjbmRvNIz5MFxZI7/ZHEuiadM8eysRtf7qErfR7TnO40040BK7L/2awGqCD8y3Qym0j4hIwFsHVZULopmwbIlCNCJLEWXHwJsbrJhobx37sXtVpEBb8t6HJH4OWYw+Cl80PEgyfxaA+8hi3DfUGTHLRJ5gZ5ySwnJjEsrS8A6f6dKGZ0rKrVAsO3U3giPqZjbUpJ4dizCb4df2zqtjyq4ZB6lLDDMmM5VujH5W/vMAk7vxfaUnR1WVriBnDOZyJli2DYX5XToi425n2UiWna6vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1323.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(47530400004)(52536014)(38070700005)(186003)(55016003)(64756008)(53546011)(6506007)(76116006)(6916009)(9686003)(316002)(8676002)(66476007)(66556008)(8936002)(54906003)(4326008)(508600001)(86362001)(10290500003)(71200400001)(66946007)(66446008)(82950400001)(7696005)(8990500004)(82960400001)(2906002)(7416002)(38100700002)(33656002)(83380400001)(5660300002)(122000001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?enFRa+DpjAJpCGcSOfVGOyDOLlyqDri8AJD/qTCTH8Vb2e+CUgVF1IYpNBsr?=
 =?us-ascii?Q?zV6rTVrrtAJHNavqHM/J38syPVrGtsB1peAiatATWhN3BdNmXSO4N9RllEPZ?=
 =?us-ascii?Q?X+qNDMd6ddXHPLD8d3E+SPSW1GhCBfymd6TRoaNJuNjbpfwfd1OR0NDm33vA?=
 =?us-ascii?Q?Y34kTValebOdevBvEvzOme6nrlQFTjryeFR3hU0jsEbBmG7IRATQ/ynfEZZq?=
 =?us-ascii?Q?82SU/dShQwJfarzOOqXifzhjQSqX/drcv3s0CuU/l7M4IqAMHUMiCVyPGEEP?=
 =?us-ascii?Q?TsTFfs4gAbWW450bUjsm711Uiky5t+eXGaDtV7PJMC2jfgcAn709DO1t/1ZG?=
 =?us-ascii?Q?eye+evNh8nGc78RmILYPL6ryb+FBV89V4kqSJfuVp69AEkhXfndjM+Lduud4?=
 =?us-ascii?Q?PXpxOeQ7owXk7dN2O1pKPXqBOH0X+YklyB9HGvi8CjsnZiELIFuKJ2+rMvcD?=
 =?us-ascii?Q?bAxNDy+dBl4Gwp8RSc6AWApLY6e6NxLuKl8fT7Bzje478tjDeNK+dlee/4YU?=
 =?us-ascii?Q?mSe6VX+bePRMj5OTHOLTVjeBAUotDa/iE58h/dHV2X8w+F4pHkng+7aZLHh6?=
 =?us-ascii?Q?AhaeFG5CUoOtfe+J/5tZFaefUSeCsOhNHex8Oj1Z+YWtgql0jANAFh1AKOmW?=
 =?us-ascii?Q?0y8bxRW4ws4a8TirSC1Hx9qqGYP1xG9+TCnD7nsB5VmYdhFVkRnejxc8h5Jd?=
 =?us-ascii?Q?JW1GtxDLfj5qn7EMI9+WBLQHWL9KZ3kypgq4ygHKNFcBSK+4jSWWXSbFNTiF?=
 =?us-ascii?Q?FFkEbIkknL6fhhOJl8sjhx7AdB5sgjxfyL2HjDWT1YOSBQsa7fhTUOo1svE7?=
 =?us-ascii?Q?CB6yPwRKFONf8EA+NGKY+6n/UMtuJ7/KCYVJp5376WGhCUDIYrk3oB6PmPd9?=
 =?us-ascii?Q?SswUoPfrilZtc9LTfRj78bozub+w+wvxlUHXaSsKXtObe6oWXt4YB6o/6Nm5?=
 =?us-ascii?Q?7oba+xlytohhDvL7l0J1SMr9x0s3MVmJhvgnjMg+vTWjRKNFmMsCos9uReVI?=
 =?us-ascii?Q?ZFPHQ237vkzs2ugiteMd0vH16El07j2IYE89M/Kbgfwu1Kf1ZyG+UOtk4Uqt?=
 =?us-ascii?Q?Pq7Z0UqlwLBriupDTo9AzcKvyXARVo3ZAMiO66pkISPHA5tqYzKcctAysjXv?=
 =?us-ascii?Q?9cP60BdqCFCcc3/KtmpiCM/ME2+PaFGgmt1bRJhYwAHCJuBhvLfS7G6rr3pP?=
 =?us-ascii?Q?5U32bmgq7NH2JY5Eikwz1a5MOu5OtGQJa63d3Cyz6b6wzbvxm+yRcUB2A105?=
 =?us-ascii?Q?ilVAc8wtnjNPzyZIdbIMcyKYY+z/M3R1QlPxUtuES56Rmfj7KYm/kzCRic3m?=
 =?us-ascii?Q?D+cGQQ4OBx+SivKkHRge/4fRfRMuJi5JXqF1YbcQqOiSztcYISkprla0IQhi?=
 =?us-ascii?Q?CJG3rU4y6si3YCkb7FiWLq3iFzQPKl81SfEhvSLcS2e9p6FHFBRLFT6xQ8ca?=
 =?us-ascii?Q?cGOWMt31p07ioqh7A1LKL6SyyOSLVG/klmnuJE0GDPL27u5GNZRfalcLaRK+?=
 =?us-ascii?Q?mfgkR0Hi8BZ2IKvnANAVFXOgsB4q22FLrZlIOZ+04gqYruy30dD7Aq/sZB73?=
 =?us-ascii?Q?yEaN7Ekp52KiwCZ8te5wU2wP5rbzr7UPJgHd3SDxnmXPTtvIvs2ges8e6h8E?=
 =?us-ascii?Q?ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1323.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6148b2f5-3e23-4bb5-db66-08d9c9544d4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2021 16:16:55.9323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IKzAcuJPsW90WB1/Zd71g9Cy7+B+0adpL9oRj1pavCE6Pfdoh11SS3jHaJIE19Gib8elBj4piZ4/Q/irhX4FoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1824
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, December 27, 2021 9:46 AM
> To: Jarrett Schultz <jaschultz@microsoft.com>
> Cc: Jarrett Schultz <jaschultzms@gmail.com>; Andy Gross
> <agross@kernel.org>; bjorn.andersson@linaro.org; Hans de Goede
> <hdegoede@redhat.com>; Mark Gross <markgross@kernel.org>; Maximilian
> Luz <luzmaximilian@gmail.com>; Felipe Balbi <balbi@kernel.org>; linux-arm=
-
> msm@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [EXTERNAL] Re: [PATCH RESEND v4 1/4] dt-bindings: platform:
> microsoft: Document surface xbl
>=20
> On Mon, Dec 27, 2021 at 10:54 AM Jarrett Schultz
> <jaschultz@microsoft.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Rob Herring <robh@kernel.org>
> > > Sent: Tuesday, December 21, 2021 5:24 PM
> > > To: Jarrett Schultz <jaschultzms@gmail.com>
> > > Cc: Andy Gross <agross@kernel.org>; bjorn.andersson@linaro.org; Hans
> > > de Goede <hdegoede@redhat.com>; Mark Gross
> <markgross@kernel.org>;
> > > Maximilian Luz <luzmaximilian@gmail.com>; Felipe Balbi
> > > <balbi@kernel.org>; linux-arm-msm@vger.kernel.org; platform-driver-
> > > x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > devicetree@vger.kernel.org; Jarrett Schultz
> > > <jaschultz@microsoft.com>
> > > Subject: [EXTERNAL] Re: [PATCH RESEND v4 1/4] dt-bindings: platform:
> > > microsoft: Document surface xbl
> > >
> > > On Tue, Dec 21, 2021 at 10:28:23AM -0800, Jarrett Schultz wrote:
> > > > From: Jarrett Schultz <jaschultz@microsoft.com>
> > > >
> > > > Introduce yaml for surface xbl driver.
> > > >
> > > > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> > > >
> > > > ---
> > > >
> > > > Changes in v4:
> > > >  - Addressed small formatting changes
> > > >  - Removed unnecessary lines
> > > >
> > > > ---
> > > >
> > > > Changes in v3:
> > > >  - Updated description to only pertain to the hardware
> > > >  - Updated the required field to properly reflect the binding
> > > >  - Removed the first example
> > > >  - Fixed the size of the reg field in the second example
> > > >
> > > > ---
> > > >
> > > > Changes in v2:
> > > >  - Removed json-schema dependence
> > > >  - Elaborated on description of driver
> > > >  - Updated example
> > > > ---
> > > >  .../platform/microsoft/surface-xbl.yaml       | 64 +++++++++++++++=
++++
> > > >  MAINTAINERS                                   |  7 ++
> > > >  2 files changed, 71 insertions(+)  create mode 100644
> > > > Documentation/devicetree/bindings/platform/microsoft/surface-xbl.y
> > > > aml
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/platform/microsoft/surface-
> > > xbl.yam
> > > > l
> > > > b/Documentation/devicetree/bindings/platform/microsoft/surface-
> > > xbl.yam
> > > > l
> > > > new file mode 100644
> > > > index 000000000000..df5a87a016f4
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/platform/microsoft/surface
> > > > +++ -xbl
> > > > +++ .yaml
> > > > @@ -0,0 +1,64 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
> > > > +1.2
> > > > +---
> > > > +$id:
> > > >
> > >
> +https://nam06.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fde
> > > +vi
> > > > +cetree.org%2Fschemas%2Fplatform%2Fmicrosoft%2Fsurface-
> > > xbl.yaml%23&amp
> > > >
> > >
> +;data=3D04%7C01%7Cjaschultz%40microsoft.com%7C77abe729b69a40624472
> > > 08d9c
> > > >
> > >
> +4d8f44e%7C72f988bf86f141af91ab2d7cd011db47%7C0%7C0%7C637757258
> > > 3887312
> > > >
> > >
> +05%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> > > zIiLCJBTi
> > > >
> > >
> +I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DjG0qubz122GG2s8%2B
> > > 1ZuMCcPIa
> > > > +33KWwPoO2VNlDySmvs%3D&amp;reserved=3D0
> > > > +$schema:
> > > >
> > >
> +https://nam06.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fde
> > > +vi
> > > > +cetree.org%2Fmeta-
> > > schemas%2Fcore.yaml%23&amp;data=3D04%7C01%7Cjaschultz
> > > >
> > >
> +%40microsoft.com%7C77abe729b69a4062447208d9c4d8f44e%7C72f988bf8
> > > 6f141a
> > > >
> > >
> +f91ab2d7cd011db47%7C0%7C0%7C637757258388731205%7CUnknown%7C
> > > TWFpbGZsb3
> > > >
> > >
> +d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> > > %3D%
> > > >
> > >
> +7C3000&amp;sdata=3DFxKNLPok9eW%2FBPmuGzU6x7dPwpnev0Ngr8epO4NA
> > > UzA%3D&amp
> > > > +;reserved=3D0
> > > > +
> > > > +title: Surface Extensible Bootloader for Microsoft Surface Duo
> > > > +
> > > > +maintainers:
> > > > +  - Jarrett Schultz <jaschultz@microsoft.com>
> > > > +
> > > > +description: |
> > > > +  Defined to expose information that is used during production
> > > > +when
> > > > +  device is in manufacturing mode. Some of the information
> > > > +included
> > > > +  in this imem section is -
> > >
> > > If this is onchip sram, we have a binding for that. That's not an MFD=
.
> > >
> > > > +    * board_id
> > > > +    * battery_present
> > > > +    * hw_init_retries
> > > > +    * is_customer_mode
> > > > +    * is_act_mode
> > > > +    * pmic_reset_reason
> > > > +    * touch_fw_version
> > > > +    * ocp_error_location
> > >
> > > nvmem binding doesn't work for describing these fields?
> > >
> > > > +  See sysfs documentation for more information.
> > >
> > > sysfs? Not relevant to the binding.
> > >
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: simple-mfd
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - ranges
> > > > +  - address-cells
> > > > +  - size-cells
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    / {
> > > > +        compatible =3D "foo";
> > > > +        model =3D "foo";
> > >
> > > No need to make this the root node with a fake compatible.
> >
> > I included this root node in order to make #address-cells =3D
> > #size-cells =3D 2, since this example raises errors otherwise.
>=20
> Why does your example require 2 cells? You only have 4KB of address space=
.

The soc node that imem sits under in sm8150.dtsi defines it that way so for
continuity I figured that it would make sense for the example to mirror tha=
t.

Also, should imem and xbl be documented in separate files?

>=20
> Though you can do:
>=20
> bus {
>   #address-cells =3D <2>;
>   #size-cells =3D <2>;
>   ...
> };
>=20
> Rob
