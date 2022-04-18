Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97623505FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiDRW4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiDRWz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:55:59 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020018.outbound.protection.outlook.com [52.101.61.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FD52BB11;
        Mon, 18 Apr 2022 15:53:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aH3Ov6qeljFfuPEWeaqenowwFm1leJceEjLNGQ7VeoDZeHWiTvhOGnehOttXbLefjJ1l2/NHwUuPFBX88REsQ3yu5GE2GtJSw3BgDoCBAxGuQj3ZmZUWXwRv3DFEWoIRd21cEh7FDYnnNLlYIiIXCRttynR4SrZboTGsD3EisKwwhRB6tS8QZx2AuPn1qn30Tlz55kKBB1MNMMh3ut204o2q0z1ZKLN/EruQYbfMhSHaJNR2gD1NNH5GnpqvI+G1/cLI+uSXMQZVjG3g4+AwHFkY0mOjAsUSOYwMgcz55F+BZqo9RVaDSl2nBv/7KfTwyq14BH0XVD3NAaR7shGo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMut8XNp3VARCwwaSHa8Zv0AuTRVuXvGNN0HxBBp/to=;
 b=Diso1Ir7KWcCNw5gcLiKhTcSKG3bL4tbshUARQMs0YVwFUcxS0v9Qyw/oUExm2MTiJ8tEeWvSVgFWuIMSQR605NArxLIG84/jxROWcp22AGDJbNO/YcsRgspPgEqboMdKk64VM9yi3NchAeCITouw53OYq0opLO7IOa19neMHL/K8HT090MAzsU1sA0HybvyD6QM8Ywp04ehCss6gALMWy8V+Cbae9ug3KMoXh1fYgbKNKFRmd3K09cidW+bIX2FQxsRxb+nWmk/4IniLkpyebDeJDEB9loPULkmWpuyY0nwkfaP15APtujG3AYRCyLkR0sSHgUZXo5un6Cjzwz45A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMut8XNp3VARCwwaSHa8Zv0AuTRVuXvGNN0HxBBp/to=;
 b=BoQvnVYNglr7k+XTPXo+8V/wfJ3xl1t0l/DeUKUhWPiPcW8zcevdX7AHSrm54kK2bw4DanSv2Xp3vNiHf2ogO230zpzsmwSGyZebULnKqQJohL3dfcd/D21O6w9lJ3rN3GTMkqfgu7KzrfkXL06rSJUi+Ey863W4C26O4pR+uaA=
Received: from DM6PR21MB1323.namprd21.prod.outlook.com (2603:10b6:5:175::10)
 by CY4PR21MB0133.namprd21.prod.outlook.com (2603:10b6:903:b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.4; Mon, 18 Apr
 2022 22:53:16 +0000
Received: from DM6PR21MB1323.namprd21.prod.outlook.com
 ([fe80::921:87d4:16e8:128d]) by DM6PR21MB1323.namprd21.prod.outlook.com
 ([fe80::921:87d4:16e8:128d%6]) with mapi id 15.20.5206.003; Mon, 18 Apr 2022
 22:53:16 +0000
From:   Jarrett Schultz <jaschultz@microsoft.com>
To:     Rob Herring <robh@kernel.org>,
        Jarrett Schultz <jaschultzms@gmail.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v5 1/4] dt-bindings: platform: microsoft:
 Document surface xbl
Thread-Topic: [EXTERNAL] Re: [PATCH v5 1/4] dt-bindings: platform: microsoft:
 Document surface xbl
Thread-Index: AQHYT2Q+xTtCZGJgoESLP31oIY2B9qz2Thng
Date:   Mon, 18 Apr 2022 22:53:16 +0000
Message-ID: <DM6PR21MB1323C72F2B37419069407AC8A5F39@DM6PR21MB1323.namprd21.prod.outlook.com>
References: <20220405210750.619511-1-jaschultzMS@gmail.com>
 <20220405210750.619511-2-jaschultzMS@gmail.com>
 <YlcWD3dnqotAEnfA@robh.at.kernel.org>
In-Reply-To: <YlcWD3dnqotAEnfA@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e534c7fc-2671-40ff-858e-c7400d233291;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-18T22:48:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdb4fbb0-d4be-4a03-335b-08da218e39d6
x-ms-traffictypediagnostic: CY4PR21MB0133:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <CY4PR21MB0133F443DD970C0E65CC59D3A5F39@CY4PR21MB0133.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gagq+1ekFJQfNTRvC+t6j1z9k3PkYbAZI0voFsz6kcPWyOAsOss7gd6okfgwSKTT2ERWyIJlsCaPw7H4TWKDoB4S6rBpI7V4xPv4xB+p3y4Ti7v/OAMpGgQ59iHUadMbJqD/DgRFqFPGunuNs/MPxLHeLwAyqjnMibjPdva/EtRLx3rjdM/nVrnrIdLoDmBTnGjCdwvuyNrgTf2heR2gbBjuzeOQbGxLHzuU0H/3+o/FhxI0iIJgrORSLWAml9Kb98/OKgwl60YdxMtjY32mbNegnRLG3dh22e4PJbraQe5jTfzaGfg4InMdqligjfBKQ5BSpOIDri5UrSychHP6N5wOPa026Ya9b2pYMzxmB31wpSQg52NKC/xB1lKTHFi2OfRoMHDPtLhpHVVgmnqP/F2DzgSlepBiOkGmSfxR+SgJyAS06aoFS1asYfiIs40IMdjkt5+Of4vKZM61cWDvVTAMuara7rnCOVqrCR9TULibSCNfJzfQNw8SzpPIVDP8GRZVXbw/owCt7YXKl/sKZsultCA0z1VnFCPHqVfVG3hegBpA5scVumcP9bxWrGCcSiArvjnixpRWXkJhXNUfi9jQD8UhNDEuNTY19PCcIDYw1JfI/MdP7ct0MwE5MwPGgq3qBHV22+wsGDChMalc6Bja6O0lElC1EpomhOAn6FUw6C8SCn9zoDubzCP9nX2ym2xk55a5G8PLEqEghp4AC1sng9MBQyCY54o4p8G5IrjqXgR3Z0J0j30uZLd43jSm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1323.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(47530400004)(451199009)(55016003)(316002)(122000001)(6506007)(5660300002)(508600001)(76116006)(4744005)(7696005)(8990500004)(82950400001)(53546011)(82960400001)(54906003)(2906002)(10290500003)(110136005)(52536014)(186003)(86362001)(71200400001)(9686003)(8676002)(8936002)(26005)(66556008)(7416002)(33656002)(66946007)(66446008)(64756008)(66476007)(38100700002)(4326008)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Eu+dpeC22Rt13gsF/03laJhogbmKpZpvBrnC62DzlxXHFj6Vm8unbcF516T?=
 =?us-ascii?Q?PBxZvTBTvvSTvNlIg1JrROj1V14g/GZ2GkmWva2FwWxFp27opAkXQpFEp8ye?=
 =?us-ascii?Q?nrYzRwYdYZIlchSbrIQ0+mkmwHGGKNkrMwdw87hxR7c9vjlGSCbUZnvVILBP?=
 =?us-ascii?Q?4AjBW2WRnEhXrbmgKy9aSUyLsSjGK9mWkZA3lE+J1WSJGChNSi1tMbhojuns?=
 =?us-ascii?Q?ZIHtPOy9Vxr0rbU4jBlEZOg38UGKr3XUTszTgzHZYOucTPsVHHUOiYjFPKQi?=
 =?us-ascii?Q?GNGrzXW0/YF5i35XXoFF9Fm5rhp0nhcHwxQ2SF6C+Q7dLSnQXMejkB2M+xOk?=
 =?us-ascii?Q?KOej09geztLhZaMC4IAZjhWhxfWdUWOaxfrD9LmTeb+EqxRylGN5R6PiHLVj?=
 =?us-ascii?Q?585h0O0NRquijsrmrJTkLzDW7+NXwAv53ahrg0UMFGkkXXpmGKWwOrM69lau?=
 =?us-ascii?Q?bw8ez7Hz/H1qKFmoCDooRgnsLQUG0LwBmIs2Qivg1ScopE+9AXIQTmHNW/Qv?=
 =?us-ascii?Q?9wVp6+7QX72+4vQ7l8OO/nYUJR+q/+YrCY42FK6bdoIoaCboRs7ULQYJlaxH?=
 =?us-ascii?Q?C6PrUOFncbNeDhQst+dkJX7qEoquIHsgr8USW93D3gx9awZbMdzF3PqfEvFM?=
 =?us-ascii?Q?sHfmyx5ceI2S3pCUDKVJ3vm2TritfPg21dOV5D41DnCr4GImPgs/Ctlk+9sI?=
 =?us-ascii?Q?LNFJbB4zgwAFWe8gBtSmb8tW5ESs457JqXZjxXf7RkTjQtmfFoxxQPTireJ2?=
 =?us-ascii?Q?J1p4+UbnBwI1VBwfySIjGMa2vxmOGBPLSxvTW+m5zaQwbuekxUrtJzWpaLw+?=
 =?us-ascii?Q?fWEAIv9kAz+9Ntq15O3YjQ+TxKQxiOuZC8wi8dMZZgojxRn6bv/qXU5h7IcY?=
 =?us-ascii?Q?Yj74dulXdy6RMuz7ws0aKlozSOydoCaAd0Qp6e3id5TZldzJnBfdQYX2VnGM?=
 =?us-ascii?Q?7eX75SYJNDZlkS3F3qyzpNcVjMC8LcoKBdN3Wqbkwhbccw8vqmkdgJbZCv1P?=
 =?us-ascii?Q?RJGeOpXP1OlNMLA4/YmnkBf9l995K9qlwmZdg9ISXSrkxQSrELEtOnbsYW+P?=
 =?us-ascii?Q?/fSlO2Eu2cP5pL3EKuZA1Q5NtjIdz8IDLHZp4UEoFRgNSBx75Xlx31X/iuqg?=
 =?us-ascii?Q?zAzikU1ee7e8/4WMf5tlw/W/HFBcPjKZg1zHOMashqyPO3OyIJw2myjO6jyf?=
 =?us-ascii?Q?UM4S17soKbzklMDqrPTvGVX324EGkps631/weDAyH6oPGNcSUUaIW604Wc13?=
 =?us-ascii?Q?KdKcTJMuQ0isn6YBXAPTUpGWVPJAAkiRxt3FQ4AK7VNGPzK+LYBQzAN/orHk?=
 =?us-ascii?Q?athqZ8oC0lDzo48xvPqNIKxrUw+coLDk1OwwCOGMiR/b27dWVApjtDsT+MFI?=
 =?us-ascii?Q?3VoeWZhLSsOLu8PLxWKxNbbkskh46M26Uijd1XTAZbnbvesueNX1s93LGaay?=
 =?us-ascii?Q?acFrof1eJr405w24G9W4BrbagEBInJkhVWJv8h7YVYd6KrDNqs/AX3B1H3Bn?=
 =?us-ascii?Q?fSaCm/qxYVodbTQnqy4FRkjxXf+eCxnIGRQR29wJjcBpALyrYL/vGI0Yy6Ja?=
 =?us-ascii?Q?0fDHfR+WgAeI+dK3NMC53JJ7g7mIN8GjFgXvqtm+Bj3EMLenhIc2+EyDPTQ6?=
 =?us-ascii?Q?6+cUTQs4pti3S6NJcCamemyzXgOrc29LRJgnBaLok2MD/I+uXTJ1wd4Sb889?=
 =?us-ascii?Q?1rWkpg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1323.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb4fbb0-d4be-4a03-335b-08da218e39d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 22:53:16.5008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvbT2X0QMQLs6uQsekccshYbEgct4xpZr2MxUoCzGEjwfXxPeKop4Smj+c0Icqbre7sFU0n4IyT6fccC92J4HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Rob Herring <robh@kernel.org>
> On Wednesday, April 13, 2022 at 11:27 AM, Rob wrote:
>=20
> On Tue, Apr 05, 2022 at 02:07:47PM -0700, Jarrett Schultz wrote:
> > From: Jarrett Schultz <jaschultz@microsoft.com>
> >
> > Introduce yaml for surface xbl driver.
>=20
> From Bjorn's reply on v4, it sounds like the QCom folks need to work out =
how
> to describe 'imem' first. I'd think that would use 'mmio-sram'
> binding and then this could be a child of that. If it's DDR, then it belo=
ngs
> under /reserved-memory node. Either way, that's all kind of outside the
> scope of the binding unless there's something special about 'imem'.
>=20
> >
> > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> >

Hi Rajendra and Vinod,

I'm currently working with Felipe Balbi on submitting an XBL driver that re=
ads from imem.
Could you help me properly describe the 'imem' binding for sm8150?

Thank you,
Jarrett Schultz
