Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F8547FDF4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 15:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbhL0Oy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 09:54:59 -0500
Received: from mail-mw2nam10on2125.outbound.protection.outlook.com ([40.107.94.125]:29249
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234171AbhL0Oy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 09:54:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dlgd/p7tY6IpvpY+Dmqup0uViFQjvKIL9vfWu0C1n3VCg1XHXZt6yUVRbRKZ5HjbGDgGjHxxnr83OC1Hha79QTlKpddkgXj+EfCcYoT0qnqf6uNxWufcoiP39mpJ21uIq1qipSpauahZZd23oNq6f5nprsy2hTCQynEFQydTKIDxlRm4NYO+Ke92jFsmCGHiYuqNkeKAAtVPMkdzfNv1APrnM2Ii0f2l89zPTQE7f0JbC/5tWuR4aFcxg+2k9+cyV4/2iePvvUIUpM2WWAtEJm/1Prbn8+09v6ta58XkJ6JLOS39K4AItBIQ0eIlU0h03yci+PEPhZw41/J3cKoSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xf7KW0V3DooqsPuEc4qnredkBVfni0TcWD/IORfFEVY=;
 b=SAntj3+4onwLaJlOWfZWlPu6M0/7a4kYO7qnQK+A4ingJDomLJOmkUFqiNQGspCCeuLzQuvoq6xv26qcgMPDZmpD2MxNPVBcrL05Ul41C2wJ1299ZWM7bEsl4ltqpo/pmemzIsrklcVhOY4yFR5Oki5RtH+k8u992rwmG68W7YGLJQM2XmLsR2EjoUToZ8Qwg2Wu9GX5K9Uy3ydDHfjPpRUH4TAmaYzy8WLpd1bbH8HkW3KOGGBli2d5LUyhq1yHMwwXbT18dcoz81ae+h5x9cp0IApCEDU+RkINJtUoeLXBw5LyZI1TeIusSPwKgWeRIw/KT7jDPCN09GY/q9HZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xf7KW0V3DooqsPuEc4qnredkBVfni0TcWD/IORfFEVY=;
 b=g9xXJRAJ8+hGJdcRQg+fDFjM3XbWDsmL7Ex/4wnhA/q+M20pOD/UmK8vjhRT2aMHBQnxV36UmNv1n2mkct99kzshpjldif62bLk+hiLBMthK+JMsvP6DjtZJVaNGeSkIjURLgSElQY08FAfgoH6uUN6kpNBrtJdsXXK48/y2iQQ=
Received: from DM6PR21MB1323.namprd21.prod.outlook.com (2603:10b6:5:175::10)
 by BL0PR2101MB1347.namprd21.prod.outlook.com (2603:10b6:208:92::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.7; Mon, 27 Dec
 2021 14:54:52 +0000
Received: from DM6PR21MB1323.namprd21.prod.outlook.com
 ([fe80::4985:6c6f:d7e8:22c5]) by DM6PR21MB1323.namprd21.prod.outlook.com
 ([fe80::4985:6c6f:d7e8:22c5%4]) with mapi id 15.20.4844.006; Mon, 27 Dec 2021
 14:54:52 +0000
From:   Jarrett Schultz <jaschultz@microsoft.com>
To:     Rob Herring <robh@kernel.org>,
        Jarrett Schultz <jaschultzms@gmail.com>
CC:     Andy Gross <agross@kernel.org>,
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
Thread-Index: AQHX9sHUjE/wr4iCGUqf1MzIH7Mjp6w+vVPw
Date:   Mon, 27 Dec 2021 14:54:52 +0000
Message-ID: <DM6PR21MB13230483733ECB77304EC416A5429@DM6PR21MB1323.namprd21.prod.outlook.com>
References: <20211221182826.2141789-1-jaschultzMS@gmail.com>
 <20211221182826.2141789-2-jaschultzMS@gmail.com>
 <YcJiBk5f071eJ5+n@robh.at.kernel.org>
In-Reply-To: <YcJiBk5f071eJ5+n@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=224e3027-e95c-4bb8-8db0-1206eb6e9a25;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-22T17:00:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ec28a47-db9e-4a28-fea6-08d9c948d672
x-ms-traffictypediagnostic: BL0PR2101MB1347:EE_
x-microsoft-antispam-prvs: <BL0PR2101MB13474479EBA96ED0F0CDC423A5429@BL0PR2101MB1347.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ytKkvpvKMcctvOVwTTZMoYitiaZ/cR/hZuk7JGiN4m9MYIWuUe3zNuRNRVpJAv2VA8UtCt0SsW/K2INea6DBxWJujCbsA2FS9GjRS+gHUun/6KA21xDR3VHqOklUWnfhtfxCftWYCuWd6aso4WgeRuJfy1N3YGW66Tlzw6Wfv523axnNNF0sxwxXzgjdtc7JnV0G+5SlU9gCwP6xLXwpujahu9UwIeSbKbu8gePSp670j054Vlbyma9NoZlKGTT8gd9b38iq+8JJrJ/KEXq7AQbiCed4rDQpuj/aghcnE45lepF3H8c3aaACLuWvVboC3JuOAb3yRL7Wc0IOYw1gVNPwcrV2byMoT/LIWm189lTFcoQ9DNeWzsJ2hciqr/CFpOazjhZ8qXqzodYrU97JtDdOUAaXWAbLy3A7Hb/2CLjhyRhLIRZbg7q604WikVTb/HFJ+xmd+PJ5zLP4HzMMN0XWNwkMimwMcsaHjOka1DbwhEhyziSom+j41x1JNel8Z1ILQ6qlSHOlUcfTvuBL918OOqtPdYFsG5VZ54b942kffH9lCPSIgjXbd9r3skzmU0P8IP0ZMJjLvcT74aQPsI4LHexOJ619EKko+7cm+L6igb8Pipt55EXZ7A7tcExRLCipO8y0Xkp/+xK5Wp/nzgc0y84R//EVgcF6X9l+6p1Cg9bsXyWsPPpYBmaPPhzf1edsdnDsLozJ6/x7oqjv+lTz9BLgUPhfZwpEtUqQoLA+zvBkOC5km+sQfSyA52ldf3SiimwqXx+9/8D8wN3Mt8+DA5N5zqZxktBfiGDmbZY0A6bYKX3Iiv6OWjz8I3qaU990kDQ2PgYbn3+pQo3lQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1323.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(47530400004)(83380400001)(9686003)(53546011)(33656002)(5660300002)(55016003)(186003)(8990500004)(2906002)(7416002)(316002)(110136005)(66556008)(66476007)(82950400001)(52536014)(82960400001)(8936002)(54906003)(4326008)(7696005)(86362001)(8676002)(66446008)(64756008)(122000001)(38070700005)(10290500003)(71200400001)(66946007)(508600001)(76116006)(6506007)(38100700002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HBD+gvN7y0s7YhROXcxB0ZILhEIB+cNlpXr4VQbBN79+QcUjLaxpIhPrG7pA?=
 =?us-ascii?Q?KfexltsnaGcB2T/RgLilfuXHGDnezS+yS+mP6yZMXXFnFXvp8iIsbvJ7SwpL?=
 =?us-ascii?Q?fyP22tCn5zk1PRAqJ6RRjMTD5TpqOdI7MD93uooq2S+7CzQXw2e3J9E2YNx8?=
 =?us-ascii?Q?qdPoLldBF640ac8dRYNSVKAqrFsrvXz/SXJMuuEE94VD+JpBHjXUpXje973S?=
 =?us-ascii?Q?VxkE7XqrtRFzNZmM2SXWbq5h6J8TZSfZ/zWeqEV5LgzWNerz3YEtje0TB/fp?=
 =?us-ascii?Q?7kuz9ADEgaYtEA4vmGCPyPuo/qYkjbgKyMqjN3hJNvfsgl5k7xUEZJlV0m8d?=
 =?us-ascii?Q?UWDcyxC+Y0fQ9bdG7rGtIb5WUIKMo6LIVxEFIH2hxxejonb/I+AGArkSDLPx?=
 =?us-ascii?Q?/MWhB0xK/7mEu1zx9fiu0UvVvvQOx8hgIiuURcsBeTX0JKOQOEAO3n27O6xs?=
 =?us-ascii?Q?G/qrTbn8vlLI7JyJ2o1ezCw0bSdnyDlQoAhS2nDte5NnQkveW0tUVTxvghmI?=
 =?us-ascii?Q?zUOsu8m6uJIeRpAkAqumHnDlhG2bnGmc/mRUMGxk+SB3KimHciFhBduggIms?=
 =?us-ascii?Q?5Wsjz3MYQaJvHvSAsF0Q/UHmsefokfgTGobMcy/g1b2nU3O77GGDaWkPi8xP?=
 =?us-ascii?Q?+9A0288G/RJw+n7t1S3fgxhxyWqW8quku3BGLc9jyuu5lhdqib+5K6Ms02gG?=
 =?us-ascii?Q?uFooGLcKtzoP786t1/TQdRCMAg3cHHphF/srUHqSTxUhpa3PotAZTb7EzJMc?=
 =?us-ascii?Q?dcbsDHy/h/A+WdnKST+icMAkf+k1UZ2rjQe8n/tdM01FDERyOusiVPeIAg0G?=
 =?us-ascii?Q?TrwwAkwhImc0kCfBK+18NuqfWYh20KU8xjtuYwq/jwsdS5AKG+hMr7pE7dVv?=
 =?us-ascii?Q?Ku5q+dWDnHcNKQfNCiEFAxknRiIArJCNgzoxlrE1CZvRSmDfCACzi6OqjTqO?=
 =?us-ascii?Q?w33aVSMyvgzqUEm01ZWnVVKuny99Yr9L6Scee0FvFzfJJT8s1uPaCvO5OlOc?=
 =?us-ascii?Q?xLCCIROxNwvtbT40ttxx7LjwZN9llImTf0FmNAv5FJZOQ1T4VXkB1MdDGGMl?=
 =?us-ascii?Q?YmgxSg0dKe5WUr3YckBwbKxtnVmRfq2p2nquXgeV9jDDLCytLWIYQ67b9FaQ?=
 =?us-ascii?Q?rL6TrXKfzQb4AnsmMoiKxBRnLr70g04FKZGgh7nVB7AzQPHQugJ78VXrQN5P?=
 =?us-ascii?Q?t54nI93TZzn8XZUlM4n7vhGqqPOrnt+IHLH6442Lawm2VbS1EvXrFbrYXnJy?=
 =?us-ascii?Q?1pkynfSaDsBoIWvHPgpM7T9bwwG//3SiB54sgbOM+rwtfZxPvXo0jO4B2uVu?=
 =?us-ascii?Q?2abLHsGfsFqkCj7rFHEFXo3lgM9gey13tqry2s+UzLh0QgeL+jdF8JKG9LOG?=
 =?us-ascii?Q?Qpm4C5ly94cL91hZEAjOgAD72mATlyR+I2f715BlowxRPRVPHgv6kNmTp28F?=
 =?us-ascii?Q?XJdsGHkRg+fXsRR6KLfl1iYNYJOX4pmP8DmK+2ZrFrrsR6otFQsQNfE5uVtN?=
 =?us-ascii?Q?YH/NtsEN6R7frTzJIQf8G/Pw5oEZFjUalZkYWDxHcn2y4HSPBN6lw8x8tI32?=
 =?us-ascii?Q?GM4mNDyahU+fM3Ce1GGB2rkLXzJh7WpSGtYbRpdtb0jLnlgsqV/M/EdShNss?=
 =?us-ascii?Q?BQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1323.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec28a47-db9e-4a28-fea6-08d9c948d672
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2021 14:54:52.0874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lxE0pu2CNNps703UJUx8h7oToaH66rdQB+/NZg6gH9MdOW/JqXc90iOw7FhdSH8+uL1WZlh9Fqa0UvlbC+q7xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1347
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, December 21, 2021 5:24 PM
> To: Jarrett Schultz <jaschultzms@gmail.com>
> Cc: Andy Gross <agross@kernel.org>; bjorn.andersson@linaro.org; Hans de
> Goede <hdegoede@redhat.com>; Mark Gross <markgross@kernel.org>;
> Maximilian Luz <luzmaximilian@gmail.com>; Felipe Balbi
> <balbi@kernel.org>; linux-arm-msm@vger.kernel.org; platform-driver-
> x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Jarrett Schultz <jaschultz@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH RESEND v4 1/4] dt-bindings: platform:
> microsoft: Document surface xbl
>=20
> On Tue, Dec 21, 2021 at 10:28:23AM -0800, Jarrett Schultz wrote:
> > From: Jarrett Schultz <jaschultz@microsoft.com>
> >
> > Introduce yaml for surface xbl driver.
> >
> > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> >
> > ---
> >
> > Changes in v4:
> >  - Addressed small formatting changes
> >  - Removed unnecessary lines
> >
> > ---
> >
> > Changes in v3:
> >  - Updated description to only pertain to the hardware
> >  - Updated the required field to properly reflect the binding
> >  - Removed the first example
> >  - Fixed the size of the reg field in the second example
> >
> > ---
> >
> > Changes in v2:
> >  - Removed json-schema dependence
> >  - Elaborated on description of driver
> >  - Updated example
> > ---
> >  .../platform/microsoft/surface-xbl.yaml       | 64 +++++++++++++++++++
> >  MAINTAINERS                                   |  7 ++
> >  2 files changed, 71 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/platform/microsoft/surface-
> xbl.yam
> > l
> > b/Documentation/devicetree/bindings/platform/microsoft/surface-
> xbl.yam
> > l
> > new file mode 100644
> > index 000000000000..df5a87a016f4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/platform/microsoft/surface-xbl
> > +++ .yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> +https://nam06.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fschemas%2Fplatform%2Fmicrosoft%2Fsurface-
> xbl.yaml%23&amp
> >
> +;data=3D04%7C01%7Cjaschultz%40microsoft.com%7C77abe729b69a40624472
> 08d9c
> >
> +4d8f44e%7C72f988bf86f141af91ab2d7cd011db47%7C0%7C0%7C637757258
> 3887312
> >
> +05%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> zIiLCJBTi
> >
> +I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DjG0qubz122GG2s8%2B
> 1ZuMCcPIa
> > +33KWwPoO2VNlDySmvs%3D&amp;reserved=3D0
> > +$schema:
> >
> +https://nam06.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D04%7C01%7Cjaschultz
> >
> +%40microsoft.com%7C77abe729b69a4062447208d9c4d8f44e%7C72f988bf8
> 6f141a
> >
> +f91ab2d7cd011db47%7C0%7C0%7C637757258388731205%7CUnknown%7C
> TWFpbGZsb3
> >
> +d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%
> >
> +7C3000&amp;sdata=3DFxKNLPok9eW%2FBPmuGzU6x7dPwpnev0Ngr8epO4NA
> UzA%3D&amp
> > +;reserved=3D0
> > +
> > +title: Surface Extensible Bootloader for Microsoft Surface Duo
> > +
> > +maintainers:
> > +  - Jarrett Schultz <jaschultz@microsoft.com>
> > +
> > +description: |
> > +  Defined to expose information that is used during production when
> > +  device is in manufacturing mode. Some of the information included
> > +  in this imem section is -
>=20
> If this is onchip sram, we have a binding for that. That's not an MFD.
>=20
> > +    * board_id
> > +    * battery_present
> > +    * hw_init_retries
> > +    * is_customer_mode
> > +    * is_act_mode
> > +    * pmic_reset_reason
> > +    * touch_fw_version
> > +    * ocp_error_location
>=20
> nvmem binding doesn't work for describing these fields?
>=20
> > +  See sysfs documentation for more information.
>=20
> sysfs? Not relevant to the binding.
>=20
> > +
> > +properties:
> > +  compatible:
> > +    const: simple-mfd
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - ranges
> > +  - address-cells
> > +  - size-cells
> > +
> > +examples:
> > +  - |
> > +    / {
> > +        compatible =3D "foo";
> > +        model =3D "foo";
>=20
> No need to make this the root node with a fake compatible.

I included this root node in order to make #address-cells =3D #size-cells =
=3D 2,
since this example raises errors otherwise.

>=20
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        imem@146bf000 {
> > +          compatible =3D "simple-mfd";
> > +          reg =3D <0x0 0x146bf000 0x0 0x1000>;
> > +          ranges =3D <0x0 0x0 0x146bf000 0x1000>;
> > +          #address-cells =3D <1>;
> > +          #size-cells =3D <1>;
> > +          status =3D "okay";
>=20
> Don't show status in examples.
>=20
> > +
> > +          xbl@a94 {
> > +            compatible =3D "microsoft,sm8150-surface-duo-xbl";
> > +            reg =3D <0xa94 0x100>;
> > +            status =3D "okay";
> > +          };
> > +        };
> > +      };
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > 13f9a84a617e..5d0ca2a98b57 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12649,6 +12649,13 @@ F:	Documentation/driver-
> api/surface_aggregator/clients/dtx.rst
> >  F:	drivers/platform/surface/surface_dtx.c
> >  F:	include/uapi/linux/surface_aggregator/dtx.h
> >
> > +MICROSOFT SURFACE DUO XBL DRIVER
> > +M:	Jarrett Schultz <jaschultz@microsoft.com>
> > +L:	linux-arm-msm@vger.kernel.org
> > +L:	platform-driver-x86@vger.kernel.org
> > +S:	Supported
> > +F:	Documentation/devicetree/bindings/platform/microsoft/surface-
> xbl.yaml
> > +
> >  MICROSOFT SURFACE GPE LID SUPPORT DRIVER
> >  M:	Maximilian Luz <luzmaximilian@gmail.com>
> >  L:	platform-driver-x86@vger.kernel.org
> > --
> > 2.25.1
> >
> >
