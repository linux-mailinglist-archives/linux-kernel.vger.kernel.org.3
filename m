Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B2D5AE95D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbiIFNUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240402AbiIFNUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:20:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8070C27FD0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662470400; x=1694006400;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dgSdvKUd2xI7ltzXPoPX+D23AeEf6J2PjVRDQTTi2gQ=;
  b=yuhFxAfXrUxYG//e0sV91jykb3HpInuOS1fhrH6et5mGK0HQ/Dq+LHQl
   Jp5OE/FaoN2GhJArCTDV8+lrBTpQPk/C2X5XQDZ4loUUmOdHWb6LTX1j1
   wp3g6sOpLMTD+E+DHk5uQAXLLSLEWhExj0wV14nLDUBFfGW1iUj3c4+7a
   xqD3iamrfhjPvazER1ZcXNYJwN7rdox4wOThveZujTGONObFHQrcoHq8m
   uPOCZPXIwwmQ4jWVk2mgqovog22FALHNE6LmWAb4vf9OcH7FT/c7svE2z
   zExenmvXPYpMUHefNXMcE8QbGyc2DKEloEpmfQ69p36Lj1LRstEMyLklb
   w==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="175825723"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 06:19:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 06:19:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 06:19:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dG1Vt7Y7LP6OMSx986VWgJBD68dF4926KlzEyITpw8NbEyAUk9ETRXOqkEFEbClczNP3YFE2GrxDBajPcaWa6i7GvLEdf66Iwf2KyAjQd/HhyOteU0lHemJB44iAe5F2j6514BOwNppYQ7apLYMte0fLwBXSKHQ3FsI+Wndzrw5c0BWMRKDwDQF82A97jwUaL2Oq6QTFCG75nwQqj61c328bnc5T8u6GMn2Gx+icyh+p8WmhTPWudUCMjd6n+MkW0uys8a+odvAZ3s5kDf9hgNvFISORqwS8sUh3pDEeU4I0vQFsiRLKCp31m/Rih+E8nn9D3I+UHr3C5Iqb9a3Tgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0zhycaJvjFSWcb44lSvQmEBhgqBsmEdOkiacM/wal4=;
 b=FEbENvRAE8uXBR8TWy1E0h+xr6UG3kflOV8FMrohXONox3bY/j3Nwkn1RLDTkZieZDOftuVe3i0WTl/VJ0G5Y5WOxDaB4NIgP2PVSJW15xF3iwkfaKJaLO3PiKLDs67LEpRb7eDTNGXBiyJ/TZVA04ksUobT4bnj0iP4N+RR7h9Mv9MAYGSXNkAO2k11ZZF9Pt57RTgT7GlcfuaALM/cfgqvf1+WB4A6iRott1SaZUEdht0iVWF9/hiJAV5v6Xdy1roVGv8MZjR0Bz3d93met6rMDPvQNVhSOTHDAIsM2SjrO+MVi4WCjcEazjFmvbhxa2MF6xhIZ4PNbF8BQur1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0zhycaJvjFSWcb44lSvQmEBhgqBsmEdOkiacM/wal4=;
 b=d2mZ6pPZkegiuRj4h42ewWqXjfbFZHzn0Dnl8KdtrAbD3LtaiBFVi+QY3dPRG+UIGfryWw7gk3SW/VwBdxsgoC5XPn5ldpRrXkMloTQ4AZZbqQem8YcxmM3hmxF4OkDpvX8c/nktB+/hbi9VqP8Uie9/MJZEzQ1o3cT+Bd+sKFw=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by MWHPR1101MB2208.namprd11.prod.outlook.com (2603:10b6:301:4d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 13:19:52 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5588.014; Tue, 6 Sep 2022
 13:19:52 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <kbuild-all@lists.01.org>,
        <lkp@intel.com>
Subject: RE: [PATCH v2 char-misc-next] misc: microchip: pci1xxxx: fix
 dependency issues in building the pci1xxxx's aux bus driver.
Thread-Topic: [PATCH v2 char-misc-next] misc: microchip: pci1xxxx: fix
 dependency issues in building the pci1xxxx's aux bus driver.
Thread-Index: AQHYwdyP5Z5hleTulUeePCmdBFjqz63SPWWAgAAkbyA=
Date:   Tue, 6 Sep 2022 13:19:52 +0000
Message-ID: <BN8PR11MB3668254ADC4D638874DE0D4CE97E9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220906103658.681751-1-kumaravel.thiagarajan@microchip.com>
 <Yxcpc7ao10kytxbV@kroah.com>
In-Reply-To: <Yxcpc7ao10kytxbV@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6979506-40c5-442a-8e19-08da900a7bb4
x-ms-traffictypediagnostic: MWHPR1101MB2208:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pBrn0QOw4SDazp4DtftmEz12KINLqsE2D5v/KhU5L7vP6nFyucSeTjfZ491lSGwgdZy7R/V/gPGy1Pu+I8Ksnn5drWhfHJX/4pX89EldKgKP4UGZ3mkbcp6j4gslH6AKOCuh35cxjn32HZZ33Gz3sNTol/5EEJvsO8pWNNecD9pZ4jfwm4O/NJD65gXrVHlpRffavpuCJlyojiU32nznPb7UIxOk1o2cJpGvWti1RJTEpTp/le2Xb5Go9HuGZdzNd+zNf5AIkotOBCGi8+DWcTxv1noOhmj4CGVaPWIX84Z/L30lkKIzMaMZq3hC/PsgeP+d+lBJVHRWMLhKtfllBQfIuWGvETVIL0qKhdvQ9NTC1NOcxZrnYDTrWP5mKOody4McFWveiYuimveSk2A3HubIhN1efwYxRxOC7prJCnShBVa7SAQpDt7R341kYQeCUNe/FpMaIDhod2i02cfOy6XiCV3h3DIUmN4CKydYuHYPtS6rq7e0UY13dckXWksLQ1BLWmFXj5vBetQgzCii/iZru3uDwKhZpB56Pk/5MLIRnYXR6lFSXQFRvya8KNyDFrHxppnPyX/JHONdHgfzRTvx6cM45Z6cbTKLnjPb4yD5bfKmpHgi/2E7YxCkfh+tPF7kr6DjCWm+5oILCp5v9ah2EHQd658ap0lJrTQIjrnGtjzGPwmY+OijsHl0xKDmsbsW48Hmrvhj2EkaqtbhC9B7DYjio5CDKf/+IqrYvu8NYQIjMRRNZF+opeOG0xnTcg2VFKLc0Xkzq2axXTzOaYtf6YtQxLmEz7vtEkwmXwnCj3a7AuDQg2YijZ7qBt5EFEEauXSsP1sxB0Rbh+RDY+Saia4dQkwJh/scc/HDjYI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(366004)(396003)(346002)(136003)(66446008)(8676002)(4326008)(66946007)(83380400001)(64756008)(316002)(41300700001)(76116006)(66556008)(6916009)(54906003)(186003)(66476007)(9686003)(86362001)(33656002)(26005)(8936002)(52536014)(55016003)(2906002)(5660300002)(38070700005)(53546011)(38100700002)(478600001)(6506007)(7696005)(122000001)(71200400001)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pmylbbu543zs0LHsjJkyZkTnbfPC8pRCOa3qKqPKYv2vA+jSRGJZu/ZjSB1N?=
 =?us-ascii?Q?DboLsB4A8xdtExvCBfz0E7mrPPvR+/bX8maYz9ZgM3ykg0dNOGQiqsnXJvnL?=
 =?us-ascii?Q?0MnzDCmP2/+T81dlllwduH8sVELuyGutqqmyrlteYZc9mIoQ3M5rY+1NHHoZ?=
 =?us-ascii?Q?UNzCh3AYP0sQWvfpU2K5TNZCk1+PeV0Dr2YzQv2+ZlN5MLx8q3pvGogef/XH?=
 =?us-ascii?Q?ISgA38/POVAS4oVyDAfYcz2p7vMoLYCZnMAGTNfj0SMOpczoHS017edtMelX?=
 =?us-ascii?Q?P4AvgwSC+5Hu1nhbR1GjETSELdNHwgoxJ3XW7QE0QoHwKCUVcSp5hQkmZ5FZ?=
 =?us-ascii?Q?lItibS55V2hMCXB7zAiyhkMPFpd0UmUToartOL04EiK8oQOXDDrxJ0yMDN3j?=
 =?us-ascii?Q?veKBhcdnGmT1/9bpEEqTxGOlCvVXsBOSLRJxnq2sQSFnhAT3K73EQ/QB8CKY?=
 =?us-ascii?Q?HXZpuQrwekKm4LIqajdQxAdmR3hNEklO80TirLvgkW2fGoPXr4uvU4LMU5RK?=
 =?us-ascii?Q?cI8peOMcOrR/ycYe/aPzO+cubvDQkbQ3IjwRSIBjomMIhMh/oqkwcmDx4U4S?=
 =?us-ascii?Q?TZBjt2Ci871xaBkpWRJ0P9TlTuzvmpC/5So1nf4dcijRN8Il7uIvZ+JQgDbx?=
 =?us-ascii?Q?C2oW4/fCVVZlrugJbm1EwwpmlIxIZxRiVrpVG5vMo/Ws163JEbT+nVAmc7IT?=
 =?us-ascii?Q?mQ3+9TZkWwQ0FgDzzNW6dK61p4IjgcoOUab/B/7XvJdBHiGKOeo09cWDI2Pm?=
 =?us-ascii?Q?MH4nhBSPZ1r+pyXFOmitSdDQcLOyPsM6msAGPLcXuina8XzeDWb1thywdo0w?=
 =?us-ascii?Q?Idx+oC7sZiYqCn0f4OrtaR+Zv+zC1m45rUFh/m2SDzytg1qlo4tfTSq5iu8L?=
 =?us-ascii?Q?G+hvRhwXuJXOpJWPbKIvSZigd59DO4HTVKQga8M/ByuXfv1p0olHgCB0cssv?=
 =?us-ascii?Q?vqW6sVLRPUSSQ4X3BoqdSoga6OlHIyvAsWzs8pvgWZyH275o9YkOYeXTs3uQ?=
 =?us-ascii?Q?X9viuo41jpgcjijBFPmqKCrTfezUPBaNYeFmmpMnndf9JW/30cTzf8hrTENV?=
 =?us-ascii?Q?PTf4fDimtvL1d54ItKan7akv5s0/iyv7rDnUCAplp8hAhvkhELNQezmtxozl?=
 =?us-ascii?Q?PGHg7CxSji/oYNOWXGAJVT+d7JG1Z98kb2Hf26ryC59S/6SqKlwPP0xmzvyu?=
 =?us-ascii?Q?cv4eDWpoAQzkwgA6yba2NVFPpEWsMfzQyhMetSkVjnOYVOWsKmGC+zhZYWmr?=
 =?us-ascii?Q?9KuFeGwrxn8ZvawDArM7nfPY278uPiHPC57u4jbDiKmdpNZjS/slJQ52+8Mx?=
 =?us-ascii?Q?THYZgXL2yx4Hnt/1QlkddOrklrNp52oJ8Upmrb/XjHKIsk4ZWNwfKsqX3i86?=
 =?us-ascii?Q?v8yWx68V1ASeGmuUv3ixthRxun3uSEjVG9b2I7JvXd30uBSndqwRbxE/V7zY?=
 =?us-ascii?Q?JzaxCL1xpaum6jIsy+UvaAztUxyirIrDLPG/JWMr6bqJYaLGS7AXJ84A4YHU?=
 =?us-ascii?Q?aApROhIfPT4cSGBijUmb2ToDNrj31zobzJHmRGuj725h+jVbVxR0Bho3ltVR?=
 =?us-ascii?Q?1ZfuUhOtJTJhyCTJsRsWOVmBZCVjLyDZaTJK4+sc5Ytm0/RjpVz4Uy51N3cg?=
 =?us-ascii?Q?DigxlkJ/sP89NAsFzsjtTwc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6979506-40c5-442a-8e19-08da900a7bb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 13:19:52.5537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xl/+3YOaWj7ToEu1QGi8BPWYpRuJqzN1eVumoMhaoI+MhjrIm6fy/R37Q8+w0pC2yQVRFyR8FzXuPvmaB/hWilUjSEtkZJhr3E/ojggh6+P32SY5YaXXm+HE75lgDIED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2208
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, September 6, 2022 4:35 PM
> To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> Cc: linux-kernel@vger.kernel.org; kbuild-all@lists.01.org; lkp@intel.com
> Subject: Re: [PATCH v2 char-misc-next] misc: microchip: pci1xxxx: fix
> dependency issues in building the pci1xxxx's aux bus driver.
>=20
>=20
> On Tue, Sep 06, 2022 at 04:06:58PM +0530, Kumaravel Thiagarajan wrote:
> > build errors and warnings listed below and reported by kernel test
> > robot <lkp@intel.com> on the char-misc-next branch are fixed in this
> > add-on patch.
> >
> > errors:
> > ERROR: modpost: "auxiliary_device_init"
> >  [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.ko] undefined!
>=20
> These lines should now be wrapped, it's ok to have long lines that show t=
he
> error messages.
You meant should not be wrapped? I have corrected this.

>=20
> > ERROR: modpost: "__auxiliary_device_add"
> >  [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.ko] undefined!
> > ERROR: modpost: "auxiliary_driver_unregister"
> >  [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.ko] undefined!
> > ERROR: modpost: "__auxiliary_driver_register"
> >  [drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.ko] undefined!
> > ia64-linux-ld: drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.o:
> >  in function `gp_aux_bus_probe.part.0':
> > mchp_pci1xxxx_gp.c:(.text+0x342): undefined reference to
> > `auxiliary_device_init'
> > ia64-linux-ld: mchp_pci1xxxx_gp.c:(.text+0x392):
> >  undefined reference to `__auxiliary_device_add'
> > ia64-linux-ld: mchp_pci1xxxx_gp.c:(.text+0x5c2):
> >  undefined reference to `auxiliary_device_init'
> > ia64-linux-ld: mchp_pci1xxxx_gp.c:(.text+0x612):
> >  undefined reference to `__auxiliary_device_add'
> > ia64-linux-ld: drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.o:
> >  in function `pci1xxxx_gpio_driver_init':
> >  mchp_pci1xxxx_gpio.c:(.init.text+0x42): undefined reference to
> > `__auxiliary_driver_register'
> >
> > warnings:
> > unmet direct dependencies detected for GPIOLIB_IRQCHIP when selected
> > by  GP_PCI1XXXX
>=20
> Same here.
Corrected this too.

>=20
> >
> > Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus
> > driver  for the PIO function in the multi-function endpoint of
> > pci1xxxx device.")
>=20
> That all needs to be on one line.
Corrected this too.

>=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Kumaravel Thiagarajan
> > <kumaravel.thiagarajan@microchip.com>
> > ---
> >  drivers/misc/mchp_pci1xxxx/Kconfig | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> And as you said, no v2 information :(
>=20
> v3 please?
Yes. I have sent v3.

Thank You.

Regards,
Kumaravel
