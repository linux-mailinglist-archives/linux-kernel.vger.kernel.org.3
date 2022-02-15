Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBE34B5FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiBOBEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:04:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiBOBEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:04:50 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020022.outbound.protection.outlook.com [52.101.56.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F93BF53A;
        Mon, 14 Feb 2022 17:04:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGPRwo8/3QGKTjl/bAy+WsAmeyPemuy0G1u7+mRELUP3vJ3GaiLG9BBic2vihSqDrecZ0J3fAzc5bmPcFcwAN6QcfdQYIcuPaMUAwReq8qgV6HHKnjSDVW9Z9mzQT/zY29Wwe8tt295pZUwmZ3zgXgETkyHGBdH5hADROm0n7nx8pxr+EwhZEdBOigrZ9TlwN7I4iXqsphv9cVNhvhBMeDGN1nB9r+ACsXcsQWijqmsJTMd3v+8iMR81Tissy7oL7vLCNm9k6oTkY+bK11fVdvzSGJjZnj0lj+Y7ClSz1gG/42TcBGv663gRQnsKfg6RCJNfceVqStFKc2Y/ZkqoyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPoFyQa1OvLyRiErX7lUM6UMwHMCRSgJ8oIFK/jtK4c=;
 b=MYK9uPl2mJqdqEmSA2mZEwYGJgPjQbKJkPkBXRHv4oy4VZVrx1Q9/K1zc6jzqfD2TNJlarQ9m6wYbaFjTzSix1F2nMxvIQKIC68Zhi0Ha3kGHpuvFu5wr7z7zKKRT52Zd0wLU5/md0FwJAvBQ0p3o1MgWj93D+yo+OjhswZvIzqywaBS+HvS8/ceRPEdafYvcCX/a8nDyhXR2PAAQey2xxUByvFVUzPyd47kDTn6WYrWOoL828r983JDitxUHqazaDwIS7BieX3vaaJ1e/yNcc1fpKlKD+wuuB0T7LoILsEW8O0wrwz8xj59EnL8ZeK5in4O1z3ZYhckmVjNfifMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPoFyQa1OvLyRiErX7lUM6UMwHMCRSgJ8oIFK/jtK4c=;
 b=Q6fmKZ0QNfOyoMHJTwGz83Qa7QrQHLdTaCwBu7yz4Dn5cBIY4g9tf2Ofjs0Hce59OiApoeyCJbO+bxlyrxtgtm+R9WAM2G4NpLpJJ2pcJmduU/JpalCJKAbnHG6MyNkSx2kliA5ZOLGsGX3PZOzM8Dqbx2z+tlJNUGDeDjNjCr8=
Received: from BYAPR21MB1320.namprd21.prod.outlook.com (2603:10b6:a03:115::10)
 by BL0PR2101MB1089.namprd21.prod.outlook.com (2603:10b6:207:37::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.6; Tue, 15 Feb
 2022 01:04:38 +0000
Received: from BYAPR21MB1320.namprd21.prod.outlook.com
 ([fe80::e157:749a:2472:a212]) by BYAPR21MB1320.namprd21.prod.outlook.com
 ([fe80::e157:749a:2472:a212%7]) with mapi id 15.20.5017.006; Tue, 15 Feb 2022
 01:04:38 +0000
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
Thread-Index: AQHX9sHUjE/wr4iCGUqf1MzIH7Mjp6yCvHNAgBFlbeA=
Date:   Tue, 15 Feb 2022 01:04:38 +0000
Message-ID: <BYAPR21MB1320B5FD66C8FA8C066A716AA5349@BYAPR21MB1320.namprd21.prod.outlook.com>
References: <20211221182826.2141789-1-jaschultzMS@gmail.com>
 <20211221182826.2141789-2-jaschultzMS@gmail.com>
 <YcJiBk5f071eJ5+n@robh.at.kernel.org>
 <DM6PR21MB13238271EE4163A0F8A52B19A5289@DM6PR21MB1323.namprd21.prod.outlook.com>
In-Reply-To: <DM6PR21MB13238271EE4163A0F8A52B19A5289@DM6PR21MB1323.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e2ca019c-3f71-4f61-a583-f3f35d64d920;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-03T23:22:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8e71107-f78d-43cf-e26e-08d9f01f23a3
x-ms-traffictypediagnostic: BL0PR2101MB1089:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BL0PR2101MB1089C4CDBD9E786392B213F8A5349@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nJmr2VYr2p60d90DSM5lBqWstSTwvd/wYSu+twk4r9At5pCnRBrm6/cvOz4gpm1QNh5Lwx1tXj5Ni5Z51YQa22bis//A1Mui0GDLmq4TK2/627jtFQ8ohXNVbm/rrqrytuLbSb67JtXmv0KxohosrkVgwvhwAT0ETvGfNRnKMESCdwPXJq91NjxjVqR8Q9cFDzUMQaoC6JTxzHq+N08R7aNVogc1hTMB76BJqGavWqfjLNZ936sSPPMNxwTkfBsxoJxT6B1L3zUhn7qYM62Qor3fvICH+/sHTc054Alov6+6qS2Ysk9tAuComzcYnMbvJ4Q7Bwch8r+fDeAFJy4wbL1tSrTNEVNOdAihjWTuYvUwKtkg9H17Ryr/7a0MkZwbLF2HPFxwobXq2/Ju2fxeUza1UDV+MwuFJYaAKJ4jI/YG3anUg7kq9m7HttqRRHrkouv0gOOvpe4wllF9jhfBVJ03whnKn4RztTERXq1mO1OWZ6vyF2ijaZ3pBEA72lGKN4n8O/qqPsissKteDCRv3jSWau2ULRhL7V0IAF5dghlPCqc71md/Sv7ambNMl2U3Ijzds+Z63IGC/zlzJWRhFkW1tw2XcHzjXt9m/5c9lkRoDjItLICzK1QO3mTHi6UdY9Dg31Td1kHzZ9rrFacCgeneBVplFIQwBZDE40sFaFInAiTXB180SB9FyXroSf8OH0NP/57SF/cbNYxIFWFym53nW+bAvNXAciK/O3Bktap5E/DwzGJnucMYjmAeYxm7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1320.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(47530400004)(7416002)(38070700005)(52536014)(8936002)(38100700002)(122000001)(2906002)(5660300002)(82950400001)(82960400001)(186003)(4326008)(7696005)(66946007)(316002)(33656002)(110136005)(54906003)(9686003)(86362001)(8990500004)(10290500003)(55016003)(66556008)(76116006)(508600001)(66446008)(64756008)(71200400001)(8676002)(66476007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YUIaEUHCs2+Izn3YUaXCDnI+1K0moA4RI7gTl3+8gxbupsuh6N7AH/EZqo6q?=
 =?us-ascii?Q?3KKoWm68p0SvkOXDV2U9D2LyNAE25Q9Vbd2IRcf4G+UEkOAg+CuWJ0nr0gPl?=
 =?us-ascii?Q?3Z3as3dxFWfdquuIQ/zozBfoY0+cV3gCK2kImhRVNPcjl8SI0OOKmdDQh7HO?=
 =?us-ascii?Q?/cZaogZmJ6C+toVQ145BKNwDm2SnyfYT+YmgYdCTwg1URfiY9m94mStM5a7b?=
 =?us-ascii?Q?lOGsdlh3RA5f3I4eqtX/dza1GjOei4EFu/nEdMNsIXnllm+mPTWZcYoKb4qY?=
 =?us-ascii?Q?mldL0D2lGiSPy3LArYRlDTWR49pp4WrV6pgkmF8J+aWs07LVL8AVOOxZeX2y?=
 =?us-ascii?Q?7k67OS4Ob2LwJ1kAjkk8oRx/hgTV2PNEQ/ivSz+GlJruihczlnKvDQ84+bni?=
 =?us-ascii?Q?kC4xiBjDHVfuKJbq7sBi2xQxQrGEUySb5HdVK56zeRTbPOm/vahpET8D/OiL?=
 =?us-ascii?Q?y4WGFIa6g6EBLdRoZG9qc5RqISraSnLxIoKkgmwM0cIyesjvPc3kefK/Q7hj?=
 =?us-ascii?Q?wMPEs76gv8tSnqjVUUGzRUFenGACGzpLcNk5u3ZUC23BZdrHqR7TdfFhNyv3?=
 =?us-ascii?Q?rW4AbkIkRrDf+dArt2irdEXR08nzPnk+N0KGD2oAUJ9m+H5qRHNGUY1Q47nc?=
 =?us-ascii?Q?Tbv+2kimNg0fpcbiJ8IVOZJhHlOUgyH5uMwSMRdXQDn+Im9rwW6cwy8cj1/7?=
 =?us-ascii?Q?gjcq+jFkioMFoV1PQZ7dox3rYS80gYPCwPsLVa4yM3pPxyGM4gCea9QYK/PJ?=
 =?us-ascii?Q?GQLCxLfhkKNlr93imLntNENBh/ZgSjuDOE7OYgA/ZSAHfBA7l2fKMy0GS1Eo?=
 =?us-ascii?Q?6aX44xgACEUYJBgfOKoHBMd0YwPYXFNkJsWqkP86cL8OpktH3mlrQ6hVDR1K?=
 =?us-ascii?Q?UPuFBKjOXCoUjG1P2HKXNCeKh/JkvBoKEKe2C9zkGhpbvtokHoJ8Ub0lIeE1?=
 =?us-ascii?Q?ZcMtnojaxTDYuRXamYJk81Z/W8DW4SpIaFPdtTRePa88gWk/brd8PZHdOWM0?=
 =?us-ascii?Q?M48ftZqKEsXi4yWZPOL+cIEzKmfawHv3MWslN0NmDjYfO7Z5lbHirGyJsSSm?=
 =?us-ascii?Q?aujMCPQl/6fjH6GGwzKjj8/fmjFB5ZW67RDEIu5AaXxsKnsZeU5IdnHLC6zq?=
 =?us-ascii?Q?ncsUMGnoyQyWGLBIgoX1mGCi342camRQiq2922vcswelJwtuZDzKhQ9exLWz?=
 =?us-ascii?Q?obn1eaKMD+WW60E7GX3gXY03L2KDE+EDD5TXyW9yctuqrgjc5YxlPDxIGrnC?=
 =?us-ascii?Q?NZWksWVOBOH9DeTsXhYcZ7+d6O7Gr0ht5qltOORl3+OqRaV5uyry2bYpuJgq?=
 =?us-ascii?Q?5++hh06UJwVDTR4dgn8EwlxMXTdmJSPqMCP4OkiooTnw10H2pvg0srDPGin0?=
 =?us-ascii?Q?3HxXa4tOy2T42lT0IRztloaB21imO/W6OkBFdfFsSWJmpt9uJjBSIFcQh3/E?=
 =?us-ascii?Q?/IwE95I1pRkH/EJKP+YxbqDI9iUJ+IEJZdMxkjL9SG21T0z0YZVY+m5W6SZE?=
 =?us-ascii?Q?f6vng6QYo5DQqV2MafphM/cEeRSa4NVw+MazNbBF/oXsU+d8QE8ffhcWoK2m?=
 =?us-ascii?Q?0DEA+ILo6peE1rkG7ExZWzHRvYyFXTpKrux3tTH5R/w9gu1t+5xVUD9j0/AC?=
 =?us-ascii?Q?cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1320.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e71107-f78d-43cf-e26e-08d9f01f23a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 01:04:38.0731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hhVSSDCkrJ3G8PGe3UpkcKF1vja62MkVzkILmmTYMDZWVpTPKHogCp9yTX6hsV88BxC1cPmcyxRGzHeBQtu9LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jarrett Schultz wrote:
> From: Jarrett Schultz
>=20
> Rob Herring wrote:
> > From: Rob Herring <robh@kernel.org>
> >
> > On Tue, Dec 21, 2021 at 10:28:23AM -0800, Jarrett Schultz wrote:
> > > From: Jarrett Schultz <jaschultz@microsoft.com>
> > >
> > > +title: Surface Extensible Bootloader for Microsoft Surface Duo
> > > +
> > > +maintainers:
> > > +  - Jarrett Schultz <jaschultz@microsoft.com>
> > > +
> > > +description: |
> > > +  Defined to expose information that is used during production when
> > > +  device is in manufacturing mode. Some of the information included
> > > +  in this imem section is -
> >
> > If this is onchip sram, we have a binding for that. That's not an MFD.
>=20
> I now have this driver working with nvmem, but I could not find the bindi=
ng
> that you are talking about here. Could you point me to the binding?
>=20
> Thanks,
> Jarrett
>=20

Rob,

I followed up with my team members who have let me know that this lies in D=
DR rather than SRAM. Could you please point me to the correct binding to us=
e?

Thanks,
Jarrett

> >
> > > +    * board_id
> > > +    * battery_present
> > > +    * hw_init_retries
> > > +    * is_customer_mode
> > > +    * is_act_mode
> > > +    * pmic_reset_reason
> > > +    * touch_fw_version
> > > +    * ocp_error_location
> >
> > nvmem binding doesn't work for describing these fields?
> >
> > > +  See sysfs documentation for more information.
> >
> > sysfs? Not relevant to the binding.
> >
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: simple-mfd
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +additionalProperties: false
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - ranges
> > > +  - address-cells
> > > +  - size-cells
> > > +
> > > +examples:
> > > +  - |
> > > +    / {
> > > +        compatible =3D "foo";
> > > +        model =3D "foo";
> >
> > No need to make this the root node with a fake compatible.
> >
> > > +        #address-cells =3D <2>;
> > > +        #size-cells =3D <2>;
> > > +
> > > +        imem@146bf000 {
> > > +          compatible =3D "simple-mfd";
> > > +          reg =3D <0x0 0x146bf000 0x0 0x1000>;
> > > +          ranges =3D <0x0 0x0 0x146bf000 0x1000>;
> > > +          #address-cells =3D <1>;
> > > +          #size-cells =3D <1>;
> > > +          status =3D "okay";
> >
> > Don't show status in examples.
> >
> > > +
> > > +          xbl@a94 {
> > > +            compatible =3D "microsoft,sm8150-surface-duo-xbl";
> > > +            reg =3D <0xa94 0x100>;
> > > +            status =3D "okay";
> > > +          };
> > > +        };
> > > +      };
> > > diff --git a/MAINTAINERS b/MAINTAINERS index
> > > 13f9a84a617e..5d0ca2a98b57 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -12649,6 +12649,13 @@ F:	Documentation/driver-
> > api/surface_aggregator/clients/dtx.rst
> > >  F:	drivers/platform/surface/surface_dtx.c
> > >  F:	include/uapi/linux/surface_aggregator/dtx.h
> > >
> > > +MICROSOFT SURFACE DUO XBL DRIVER
> > > +M:	Jarrett Schultz <jaschultz@microsoft.com>
> > > +L:	linux-arm-msm@vger.kernel.org
> > > +L:	platform-driver-x86@vger.kernel.org
> > > +S:	Supported
> > > +F:	Documentation/devicetree/bindings/platform/microsoft/surface-
> > xbl.yaml
> > > +
> > >  MICROSOFT SURFACE GPE LID SUPPORT DRIVER
> > >  M:	Maximilian Luz <luzmaximilian@gmail.com>
> > >  L:	platform-driver-x86@vger.kernel.org
> > > --
> > > 2.25.1
> > >
> > >
