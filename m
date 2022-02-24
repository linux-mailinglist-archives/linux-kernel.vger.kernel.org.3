Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90824C39D6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbiBXXnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiBXXnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:43:06 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020025.outbound.protection.outlook.com [52.101.61.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A738F94D9;
        Thu, 24 Feb 2022 15:42:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GD3QNTveBTaLED6WCjB9DOEcdcD5Iw5+o7bKK5WFu31VPlNiQQcvflWF2+ev8XAJaMy0I+IuHmiUbSWfyoo10KbZGdpgWaVQ8x6x63N9jCSZ274CdWMz+L6fnabgw9pm932byUOqs/W82BeNJYcs+Cu6ZX3gV4w8La2Zlndq4bLKUxagb1dFxPFC5pGAQDRzy0ILufxTYUGkMxlFHId7dFfgUjLUGx3UrPeaDYgoWGjYUNjT5dp9oqXhdm9deU8CBeb0RnUb5ZPQc8a0E5m1XDY7P5sxfUcKY08gayA7DC/7tdZz+kt7cW+7QgeZsL20hbapg6D4ULuu85FcMYciVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vkl4s6C5bTSIwJbaJ1nOSXZZYAEhBRSjaHdt7AwGVVo=;
 b=ZU7HTN+AYK60ZSPti5KM/5Tevf56SPwIUekY91mQJ4X0sq6EXkDHLRxJnCxbtxTk34vbQJ49FtfKk29OqoT7nrIiIk5D3Utltuc51Y1NxFNJF7TmITlpvgqSpkihirM56gmdMjKzlNAQ+lyDd+STJ1+LGDUrMlYvl1TCwd+iE//y/V5UcLvRI7kxNQbMNy8R4brl8G44lXL2HAiO8wyo6r7KGoc+Y2ktu4exCMMnz06lHwpJht/JWcvBE+YM1lFVjpMqSL/R1qCQ8HNeqDfWVui61cuFYf2B2LXgH5P/Q9UrG+cXSbg+MU8NIiskZlixMjkT0oB8fZw7gUTgLUjlDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vkl4s6C5bTSIwJbaJ1nOSXZZYAEhBRSjaHdt7AwGVVo=;
 b=YyNqw+NYQCsdEnDnLURNSxNU3qep89yXmCRtZHorbB00BssVL3nmSHmRJQ4/6XKddV/A76mrQ69oxYsanGzCVtp0H6HfPYde2USzZ1JF8UgSL2KgHhYVA6K7EO5S5Nx+D/+VWaY5jtyDuCkimI5hUrswg1aWxdmQgvCQKfyilDc=
Received: from DM6PR21MB1323.namprd21.prod.outlook.com (2603:10b6:5:175::10)
 by BYAPR21MB1336.namprd21.prod.outlook.com (2603:10b6:a03:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Thu, 24 Feb
 2022 23:42:32 +0000
Received: from DM6PR21MB1323.namprd21.prod.outlook.com
 ([fe80::413:b2fc:246a:8593]) by DM6PR21MB1323.namprd21.prod.outlook.com
 ([fe80::413:b2fc:246a:8593%6]) with mapi id 15.20.5038.009; Thu, 24 Feb 2022
 23:42:32 +0000
From:   Jarrett Schultz <jaschultz@microsoft.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Rob Herring <robh@kernel.org>,
        Jarrett Schultz <jaschultzms@gmail.com>,
        Andy Gross <agross@kernel.org>,
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
Thread-Index: AQHX9sHUjE/wr4iCGUqf1MzIH7Mjp6yCvHNAgBFlbeCAAOREgIAOvDhg
Date:   Thu, 24 Feb 2022 23:42:32 +0000
Message-ID: <DM6PR21MB13234F44F7CAC49B12F7767FA53D9@DM6PR21MB1323.namprd21.prod.outlook.com>
References: <20211221182826.2141789-1-jaschultzMS@gmail.com>
 <20211221182826.2141789-2-jaschultzMS@gmail.com>
 <YcJiBk5f071eJ5+n@robh.at.kernel.org>
 <DM6PR21MB13238271EE4163A0F8A52B19A5289@DM6PR21MB1323.namprd21.prod.outlook.com>
 <BYAPR21MB1320B5FD66C8FA8C066A716AA5349@BYAPR21MB1320.namprd21.prod.outlook.com>
 <Ygu7HdrLnzFj3BrV@yoga>
In-Reply-To: <Ygu7HdrLnzFj3BrV@yoga>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=62e22238-fbe3-43df-9072-16081c18e373;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-24T23:40:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4afb8563-902f-42fa-472f-08d9f7ef53dd
x-ms-traffictypediagnostic: BYAPR21MB1336:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BYAPR21MB13363DF520A24B806895140AA53D9@BYAPR21MB1336.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bJbRrtNO2nQgcqNPIbY8G2y+QRZ8UfwoFGZBcqDaWj4BHEWgP/J2i3r9JevQgjm0IeAMMLrp5C8HiW+2xV32mrXjoQYuj3EyWN5AI73aoBm2gYDye7jYnZUHF6caYlxU3GV/usN5pUV1Co3YWF22kIJ6sb15KC3CxdSo3r2m1/2mvMHTGQffu9OVBhP/0sOR7KbPciJl/ZXLXJjs6kykMzx2Y9sPaaPMXHF7zkm+8eFGbEGcwZ+gETRydOTfALKYi2NcdQLxQMpXwsg29iRNwPKrl6jaNjxyRXyMbMTYyDz4O4S/o/jwxcvFAbrQoeo1PD0OoxbxIgxAcK/EYUWN6+9sxbRqcrKz0F/K81A6RN2wL5urdsd4AImjPdly0uqAuHwOYod5ldETXPtuTboj70kr6rAd3geKJLxx6uRVe8ybV6JNLC/3myFU00W3FfK5w/8F7rVyAPxNSin83P+LSRF/0LMx8t/6jpZpycJrFwDmzpMQ+IkErmFdjh211jCZiEWWAcYKrUuuq9WxAcTGO7LvOsCFQZQ7jOSv4KbdscuiScQVuCae+1n+aTmztd3qzXhipAGqtOKFYiWKfiSVONBhEE6rVtpyDWFoO84pT4eobHvFNfCHBMypEA9kx2b96fK1wxLC+v4+z4O1QSi0cfddXru+XUQ7L3p2hWX7k4k6nUFbHqr+MgUsfcj46vEcGyQuRaaYuN9+TSTravg6RmNJ2te851v0r5aZ+BGnBhzmakndLO9SFVqt2aNjP1vv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1323.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(47530400004)(9686003)(66556008)(66946007)(64756008)(86362001)(26005)(186003)(2906002)(82950400001)(8990500004)(82960400001)(122000001)(4326008)(38070700005)(66446008)(38100700002)(55016003)(33656002)(7696005)(6506007)(6916009)(5660300002)(7416002)(54906003)(316002)(71200400001)(8936002)(52536014)(76116006)(66476007)(508600001)(8676002)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LnAmos81ZwXsXvLUVmYm6OeFY93EpnfrN7OYKdJR93jJcgsmz06mxcjkRWgV?=
 =?us-ascii?Q?WVfl8MDFghPnlnsUbuUG03U0XLfEi590uWsrsxI36FUQoN2XP/d6/Oz4e/4m?=
 =?us-ascii?Q?+irxAC9g2kzAIbbbcsxhBckLJpxrDbgGy8PgVWLYustoAxcp2N7pYb1HzBTj?=
 =?us-ascii?Q?KaCas+x7YNhQ28zbYalWDXvItpPksSjd5p3tIplt9PL4wiC6wkHJGq2MVHCR?=
 =?us-ascii?Q?sG3tO2/vKm9BEY3Lxz685pziGuS/MuU9lsb8crPk1GwCNdeJAOe84vGJbvuR?=
 =?us-ascii?Q?9AVqHuKOxZ0MKhcPV4HqIM91YnRaxmfomApNrblONXzsuu5m6NJ0rphr0rEA?=
 =?us-ascii?Q?MksbV99u+FOuQGKZX+OBMbTzGlBpkT7fYA/N0hAzQ1pUHOj7XpsT+pOpwyQe?=
 =?us-ascii?Q?+2C3ZvdPuQJ4VvsKjL5quT26kFTjKueS9UISSnLzxDPki8sWRzZkMWNjHg3n?=
 =?us-ascii?Q?9lVJxI/3tisIWEIqnTIP72w7NCOUNtcZh4wQrODy2PST17zHcI9vlGlQceo9?=
 =?us-ascii?Q?SVXD+wW6CwSHmV8vi8q4KzpgAVJmhnoXLgYuSDcv+STOed+KBdoNqD+4TwQr?=
 =?us-ascii?Q?ZJhbnEtgnXMThuI1aoJDYzHuQxmryuHXdaGvJlLiKw/9R0dF/LkDp0Z/BQ/b?=
 =?us-ascii?Q?5Ba6mxmbLN9vRODpRxPmLwc5U6p3hbg8snQpw2jt1q3J0ZNKLA8kNb2Im7yV?=
 =?us-ascii?Q?j4/Cha+mHOpSV59VXPHpUKU0IwHEPyl37bDqwMurgAjfYE78Vn9DBkOTBKX2?=
 =?us-ascii?Q?Xm5KqG5hv+Yu3XF6iWWZnojdET2zJXPXL570bmbnjMzRCmDGk4txeJ+wOv+a?=
 =?us-ascii?Q?Yk32PuzT8boJ5f6sIwYq7f6Uq1DlV0XiAVqQcK4OpTP/lCs/aonBKtVvawHx?=
 =?us-ascii?Q?jPgGn+lFpYOo/zT4OIUJ346VOqdgvqOZbERA8J7nlpU+6km5f/Ioo6CpYNUM?=
 =?us-ascii?Q?QHvJM4M6BCJqy240o7ldQYyHo6ZkR6kGm9n+5y0wnS5s3DeOnCfTzKyimOd2?=
 =?us-ascii?Q?RwozgEP70SlyBBnuPpVeq2J+UOnMJLMe5Gk2oqQDazY7Ca6k5fdLj2wwHDer?=
 =?us-ascii?Q?VVs25cyfSHX/2gb3iaD7hrYSFLJlD2ru3oCE9ziTul1uoBGV4pY96dR4FXMy?=
 =?us-ascii?Q?wQdSp+8mW2bgwLftSBIfEDjundPBgLcxs9hIj2ryl0hfs3cdQmQ+LK4th6uF?=
 =?us-ascii?Q?aHxBTPIqnXVVuk8OW/7Jj+oK7r4ZkgseAugl0VQidUbGPw93ZaAOBl4rjkri?=
 =?us-ascii?Q?hNJL6o9bFABZ8CWm+dbKXe/bd29iez3kIWANoBqR6BaHBNGZYRi+T7NuqNEg?=
 =?us-ascii?Q?qGpYhgkNoc+H+T4YOxosRcmJawaZrI0F1PVNbbuDUMdYmFKdpmyw9Y0EzzGl?=
 =?us-ascii?Q?j78rE0NIaCx6wYEhJOJE7Vv31UpY9eOE3Toeq3JFTCEwp2K/rLO/yv2B6ZDG?=
 =?us-ascii?Q?XSewdp6EeI5P0dHlWf49KI/t3aPXwRjy6OR2EcAv8T8MSYbkcTptDszg9e4B?=
 =?us-ascii?Q?Qtlq9wS0Ku33olbljmyqWCkUHUFOK17jlLM2KKkIgmTBt5Ul/IC6JkefgQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1323.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afb8563-902f-42fa-472f-08d9f7ef53dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 23:42:32.4591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xRX5WigPLLG/wdY4cL47C42fb2+GS2Hb/aduFnTzmSgeBylXyfiFRdznW9QZj916mXf5jBRnvvZw6arqAO1VcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1336
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 15, 2022 8:39 AM, Bjorn Andersson
>=20
> On Mon 14 Feb 19:04 CST 2022, Jarrett Schultz wrote:
>=20
> > Jarrett Schultz wrote:
> > > From: Jarrett Schultz
> > >
> > > Rob Herring wrote:
> > > > From: Rob Herring <robh@kernel.org>
> > > >
> > > > On Tue, Dec 21, 2021 at 10:28:23AM -0800, Jarrett Schultz wrote:
> > > > > From: Jarrett Schultz <jaschultz@microsoft.com>
> > > > >
> > > > > +title: Surface Extensible Bootloader for Microsoft Surface Duo
> > > > > +
> > > > > +maintainers:
> > > > > +  - Jarrett Schultz <jaschultz@microsoft.com>
> > > > > +
> > > > > +description: |
> > > > > +  Defined to expose information that is used during production
> > > > > +when
> > > > > +  device is in manufacturing mode. Some of the information
> > > > > +included
> > > > > +  in this imem section is -
> > > >
> > > > If this is onchip sram, we have a binding for that. That's not an M=
FD.
> > >
> > > I now have this driver working with nvmem, but I could not find the
> > > binding that you are talking about here. Could you point me to the
> binding?
> > >
> > > Thanks,
> > > Jarrett
> > >
> >
> > Rob,
> >
> > I followed up with my team members who have let me know that this lies
> > in DDR rather than SRAM. Could you please point me to the correct
> > binding to use?
> >
>=20
> It might be DDR, but it's on-chip and the memory region that you describe=
 is
> a region within "imem" - something used for various purposes by Qualcomm,
> presumably also in your device. Unfortunately we haven't specified a bind=
ing
> for "imem", only some of its regions.
>=20
> Perhaps it would be appropriate to express the entire imem as nvmem, in
> addition to the region-specific logic, if that suits you.
>=20
> Regards,
> Bjorn

Bjorn et al.,

This xbl driver was meant to be something simple and the intent was to merg=
e it into the tree with an existing structure. Your suggestion makes sense,=
 and I believe that it could be implemented as a separate patch after this =
patch with the initial xbl driver has been accepted and merged.

Please let me know what you think,
Jarrett Schultz

>=20
> > Thanks,
> > Jarrett
> >
> > > >
> > > > > +    * board_id
> > > > > +    * battery_present
> > > > > +    * hw_init_retries
> > > > > +    * is_customer_mode
> > > > > +    * is_act_mode
> > > > > +    * pmic_reset_reason
> > > > > +    * touch_fw_version
> > > > > +    * ocp_error_location
> > > >
> > > > nvmem binding doesn't work for describing these fields?
> > > >
> > > > > +  See sysfs documentation for more information.
> > > >
> > > > sysfs? Not relevant to the binding.
> > > >
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: simple-mfd
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +additionalProperties: false
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +  - ranges
> > > > > +  - address-cells
> > > > > +  - size-cells
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    / {
> > > > > +        compatible =3D "foo";
> > > > > +        model =3D "foo";
> > > >
> > > > No need to make this the root node with a fake compatible.
> > > >
> > > > > +        #address-cells =3D <2>;
> > > > > +        #size-cells =3D <2>;
> > > > > +
> > > > > +        imem@146bf000 {
> > > > > +          compatible =3D "simple-mfd";
> > > > > +          reg =3D <0x0 0x146bf000 0x0 0x1000>;
> > > > > +          ranges =3D <0x0 0x0 0x146bf000 0x1000>;
> > > > > +          #address-cells =3D <1>;
> > > > > +          #size-cells =3D <1>;
> > > > > +          status =3D "okay";
> > > >
> > > > Don't show status in examples.
> > > >
> > > > > +
> > > > > +          xbl@a94 {
> > > > > +            compatible =3D "microsoft,sm8150-surface-duo-xbl";
> > > > > +            reg =3D <0xa94 0x100>;
> > > > > +            status =3D "okay";
> > > > > +          };
> > > > > +        };
> > > > > +      };
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS index
> > > > > 13f9a84a617e..5d0ca2a98b57 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -12649,6 +12649,13 @@ F:	Documentation/driver-
> > > > api/surface_aggregator/clients/dtx.rst
> > > > >  F:	drivers/platform/surface/surface_dtx.c
> > > > >  F:	include/uapi/linux/surface_aggregator/dtx.h
> > > > >
> > > > > +MICROSOFT SURFACE DUO XBL DRIVER
> > > > > +M:	Jarrett Schultz <jaschultz@microsoft.com>
> > > > > +L:	linux-arm-msm@vger.kernel.org
> > > > > +L:	platform-driver-x86@vger.kernel.org
> > > > > +S:	Supported
> > > > > +F:
> 	Documentation/devicetree/bindings/platform/microsoft/surface-
> > > > xbl.yaml
> > > > > +
> > > > >  MICROSOFT SURFACE GPE LID SUPPORT DRIVER
> > > > >  M:	Maximilian Luz <luzmaximilian@gmail.com>
> > > > >  L:	platform-driver-x86@vger.kernel.org
> > > > > --
> > > > > 2.25.1
> > > > >
> > > > >
