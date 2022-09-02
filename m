Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7145AABEB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbiIBJz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiIBJzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:55:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62DBD63
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662112493; x=1693648493;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pPYXNb4Wt/qNUbWOZQ2mCo7s2txjRQ6tA19qntMVul0=;
  b=eTCIsSNJ5sFji2XUwjSv/rSrfPNEtxF8hVDX+Tm0AvuPxIdbylwFxAvL
   CY038kCbZRbsyADxcalb1fiOimCbtytAyivnaltBTJxLSY2nGFqRzVHHi
   utMfe8DZQJSxd55rYBTu4ouLgKqq96zVWq4LoSDDOMiYOe3wAAO07mmQI
   +JSDNLlM+Oh6qB0G8y+EVxJZVazV4KEM7PPmlUxkPBog+5pRlls7qLCap
   3ySWlwCFzUbheutt+NOfnsWxOlB6HJlqmwo+0rD4KKUYT4gqDbZonYlOY
   U1UDH17Q9ZFrzaFYtrOLrzR9o0sqWQQKN6O8iELO6gzplHSiGFxPOWCSE
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="111901901"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 02:54:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 02:54:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 2 Sep 2022 02:54:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNV0TQGqK2oBBbM8vXvaE5T2Ey/it1EDcKIAeq0NvTQNEporjp0gj2peAvJ61cD4lc1mNfxOW5rRVtW7IO6ivLvS4/3oHbptJKF1S+SUudtB+PiBpKcCWNOhwOA2Lt3PYEEfT1mEW4UX7fU2W+85l0ckDkfMvQhn7eDeKvg5WI+5i3nd+STX22P9kPuaaM2CmyHUke/qElrtZ8jR6IWT+4ZE6eGsTzNkYOwFUt3bI/EoSEJIECkYXQNcQCm9OmiNg5v5v95XyKqRMVA0QGCGgXp/H9FSQVCIyyIEbcAB0L2AlNuZu0jUbD0tA0iGOk9NJ7BfS3Ow0lGlqC7gAQ6kVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovaMuRahYDqVSin7Br5AaqiSPwFPRNWGZo3UdhmzTZM=;
 b=njCa34k3E943Ehwjiex5EO8dtFFSw5QMs14mtUYJVTxAjN98iA9ZtqtBmM6L+X7tcGR7xMjYDgw67zYqxdlbQCDGSqMMUpqQ3rp3BGDSitZy9MW1oBZfnCJaPiS3gRGscuWSjLwSAbpJ92c/6tdrL1ddLIWLHZk0DEhEt7FylmxSs8Wug/J03zJZwUXfY+9yhA7FI0gHHwLmozz2PxesiEPDB5VPifi7U0SKgoGROPC2qyD4i8mvtQ+hwRajIkT5u37SNKqAAUYsO5q3fQ3aq3pMwPNX2gQvtKZv2Ctj8lk2Sz0VZBc1nKhiyYd3TrYhrlUAdoW7nNUM2baCPVbxRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovaMuRahYDqVSin7Br5AaqiSPwFPRNWGZo3UdhmzTZM=;
 b=ak2M3RktA5q9fvsmr19b5CrnNS8YgzBuNeJuggWpouOELavuhSZsa5RfIzT7HbEhr3+3WC1wHbap+Rvdkof6Hf99UCMtLJULy/b8U0KYyWaVuU3jdM9RiQhG8fIz+621dLD6h6AcDKYm9Cy9xBNjBfAtrA+kH0qmpQzJ46agWIo=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by SA1PR11MB7111.namprd11.prod.outlook.com (2603:10b6:806:2b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Fri, 2 Sep
 2022 09:54:44 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5588.014; Fri, 2 Sep 2022
 09:54:44 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc:char-misc-testing 20/24]
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:87:52: error:
 'PCI_IRQ_ALL_TYPES' undeclared
Thread-Topic: [char-misc:char-misc-testing 20/24]
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:87:52: error:
 'PCI_IRQ_ALL_TYPES' undeclared
Thread-Index: AQHYvlA4FMupJOOnQUyiaRis4mwVTq3Lt1wAgAAW29CAAAeugIAAELqw
Date:   Fri, 2 Sep 2022 09:54:44 +0000
Message-ID: <BN8PR11MB3668A7660CC7810239885F21E97A9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <202209020641.mPiacQEP-lkp@intel.com> <YxGqkvNg0rXDXoew@kroah.com>
 <BN8PR11MB3668E0B249AB3CFCE15A4D3BE97A9@BN8PR11MB3668.namprd11.prod.outlook.com>
 <YxHEL6SscClLdkss@kroah.com>
In-Reply-To: <YxHEL6SscClLdkss@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2b042f6-4a3d-4910-cfbf-08da8cc929b9
x-ms-traffictypediagnostic: SA1PR11MB7111:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uLTOk3IZfJJYGc5X0CQphus0CD4SIWL0Uo0MpODdzQZuQDVSgLWgwVa4fpZGZ5nAgCy0lywb6zR/cHd8Ybufs8HCGXt1czQHTQ5/OstOaj4zhgGbMvMwHSETeUIlHNGclx1QM7RMtY7LPZEBWnXOxoYOxEyLskD85VOOj+UVCXZ7NBdbsFLz6LslQ35uvYbjBvUX8AodIwgCWcI+A39Wn1xFzLI4bAWwnBzcNWQ4ocPKqdH7VoYH8/v6Rx+7DSdNFdC4Cgc1VtGL2JVh6b7lj647khyO5SGne1ylK9rZESmgVoJQ9cH2xFg/ufurf5Fr88tKKKInxeUM8LPNCIDsuZBz2yw4WF4weK8z0b2RnCJge2H4F/ulv0e/hJOYanRxk7MdHxPKVMQajJy2pJmD5O9J62QShczz/dHcoGyrazBVkjsODJZ9mVc1s5KUzmsMmQsXgcMTkdLC5S0hGhnVkAtIIkKwtjtHECGMLS7qsrwuiWbGpLMT3UKUbYlq7dx5xBm0YyYBbXSOt9eprxTtYyqEC6jWBWVTFmKJubAeFNNx0GFmuPwWFmanelDs49AJjAMqETnGRPnkBencXryn8LASiFtgKZIfrAssDPl3sWJDkGXHe+KnV7ZQlKc02pSLHiTcJpvmcC+RKzI8DY6yn/eS2uwnOX8CEsLA62bO9Zzhad26OtSHOtN/vfrHkoHWKV3t5Q0pNC0gBgzf9vOLzcIFX7M9nac29XBjvkTL2aYIaw4EWCIIzRNVErsTo25eYBf78DSPcDwt64j3wJLK2I2WxMEAlp/JKWqL7j4/YmqWNjjhtDdJw5Kd7dYIKnPkBKuq+36uc5RZ+2sU48OQacTF3RdNmu4mKONdNxuwtkarbbSw0IMHHE2niBN6DFCL2mSyLNReaJtvD2AkWRB0CQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(366004)(136003)(346002)(86362001)(186003)(41300700001)(52536014)(8936002)(5660300002)(26005)(7696005)(33656002)(2906002)(53546011)(9686003)(6506007)(38100700002)(38070700005)(55016003)(83380400001)(122000001)(66556008)(54906003)(478600001)(76116006)(6916009)(19627235002)(66946007)(316002)(66476007)(966005)(4326008)(66446008)(8676002)(84970400001)(64756008)(71200400001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GzxP5Uu8ROKEN/tdNSRHL8O9HB81jOZBPx7qTjQ5PSzjGYKYs35Sco7Ox+b7?=
 =?us-ascii?Q?krTH2+0QAyj0ijyP/nbLiHVLR+x7q4nJbmVY+kPNCUg763+9/6ytyLdmdKw4?=
 =?us-ascii?Q?SNNjrknNcu6l5OFYv1tnv8wrcrREybYvEC7SoaCHh8S9hiJkzutj+hkpMtHC?=
 =?us-ascii?Q?rROkm5H5rzDFlxPNEGBPMpPn7W1C0wn7JayAdmrxgGxNEOABX30ZIabEBkfu?=
 =?us-ascii?Q?3InxGBySJI138wc2UoFvtybN6Vc+MC1CNzeKfpdIXXCOvuUVilumMKAUMvjX?=
 =?us-ascii?Q?Vw9eeozBFBDfnmt1EYKc+6MUHmjU6c0PyYpMBZ8Ud8gYtInd9Ko2Qc+iXHb+?=
 =?us-ascii?Q?+QYL6N3eDCawjZmeqUvR3MGKs0xeuM+BIv3Fhwvln9agCttq5TsjdRBZgEl8?=
 =?us-ascii?Q?E88HnfkRfwrTsIPptMYXCHcVPcOrN9qWXuvYGiIHBWXjpv3dLbvhG7BfZIRc?=
 =?us-ascii?Q?5naAsd5b7+wvtEjfhI/UJQqZn5H/D0gO58rrOOMr6ItTXUxQskaCDNANvE8B?=
 =?us-ascii?Q?zrcBigAT5YNMs0744CPwvOFjvq8QG58g3NsCPgcllYXV/YSNNoTSUNoDK1xo?=
 =?us-ascii?Q?FavdOV/Cel9PyTsVx2cnp71G1InGNzDFgDGROgLYk1kbbNI8ijkF3SO3nUFJ?=
 =?us-ascii?Q?KDatMmIsr1hUa+UP0qlj0vao3Kip2EBJ+nEETTSfDYzrRH6s46q3NWjvX3u3?=
 =?us-ascii?Q?OuaVl7bVWA4tdLicUyyhpK/v5Hay4JQaDsA7vgJsTTd3zIlEYMgD75fcY5f1?=
 =?us-ascii?Q?H1jke3Z8LqJX82dwk5KRog8uDJGT0MJ2X519jNq6GTQ7FfOYYsYzuyYEt78m?=
 =?us-ascii?Q?JXEfr5VRWkWx7ptA6xtjEzQP9zDh7BIGuvg8xcUjrK28YNftEs9h3FSxdChG?=
 =?us-ascii?Q?Bfe9TLEs2qMXzwLOeyFGD1Rk822k+25TBEK097Ce8XoG6b2McWnVDkty18Ww?=
 =?us-ascii?Q?eZxAFCYA0OasukTnYmKWe8hDL4UFI+c4R9lS7Qde+z6ci4/DvlfxtzhPA9Sj?=
 =?us-ascii?Q?HtDjtuzbto8kVTO9LRp5DReV/ewkqdPAXvwCEMY0j3Fcog/ZJ3MuEHpEAHkB?=
 =?us-ascii?Q?FUQY7I0a4avm9f93QtAp/PSeLFesEX9C5nLWVJLdi5a6J44xAEGzL9CSbtHf?=
 =?us-ascii?Q?P31JsjEMrwgPnBU7pzXWF0x6C49+N8VMl5hV7QpeGGuaTSyb0Wv8hFj2N722?=
 =?us-ascii?Q?n9Tf32gEh1/LHPo4+/3l4GXtLCto73+ah/8rfHxMCtuO+9bxSEst3pTWf+TW?=
 =?us-ascii?Q?OVw6FQZ3aaDUVtB4H3CtLswfRWXBBbTJ/U59ARN5zxxpOQuIpbc37XQJRvEK?=
 =?us-ascii?Q?2aVt3RVrjlEVSBDoq7LLX4xRB+pyN+jL03Gup9OvJj+nzMrV+ATeWOYy84K+?=
 =?us-ascii?Q?4wkUC2M0ELgcxK32FLmOKhqQPk8fLChxybt7pye749DmUUAktZSecjov/TnN?=
 =?us-ascii?Q?fq65H3saSKXEje8kN9iqjc+Dku7izQ9U1Crfz5BNVQXRWfDayJo0mSFnYGkK?=
 =?us-ascii?Q?SN2A5QqhphXb92vi5MSrZLHa+4Rb3lO641jERTBehE2ItOIScGtg/rw9Ifpo?=
 =?us-ascii?Q?8IC/ZlNZlZH9ZlKE5JQ20ZvxutYODgaFovu0uxfAI5iBu/cpdIkVfjTVYtHF?=
 =?us-ascii?Q?rRh86NMheoSedwJteJi4Gus=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b042f6-4a3d-4910-cfbf-08da8cc929b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 09:54:44.2236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xu5fjMr1KJ7omWo9a3MUr8KouEqoXQxqwBbVcTodz5CzwS82x3OtAT8JHqMqwV1vmp6NHfPij9SvuOLncoU+3tP4QDOoQ+IdaYhZkr/zeD8LrDUe/igutXxeo71FcVoO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7111
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
> Sent: Friday, September 2, 2022 2:22 PM
> To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> Cc: lkp@intel.com; kbuild-all@lists.01.org; linux-kernel@vger.kernel.org
> Subject: Re: [char-misc:char-misc-testing 20/24]
> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:87:52: error:
> 'PCI_IRQ_ALL_TYPES' undeclared
>=20
> On Fri, Sep 02, 2022 at 08:30:22AM +0000,
> Kumaravel.Thiagarajan@microchip.com wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: Friday, September 2, 2022 12:33 PM
> > > To: kernel test robot <lkp@intel.com>; Kumaravel Thiagarajan -
> > > I21417 <Kumaravel.Thiagarajan@microchip.com>;
> > > kbuild-all@lists.01.org; linux- kernel@vger.kernel.org
> > > Subject: Re: [char-misc:char-misc-testing 20/24]
> > > drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:87:52: error:
> > > 'PCI_IRQ_ALL_TYPES' undeclared
> > >
> > >
> > > On Fri, Sep 02, 2022 at 06:13:10AM +0800, kernel test robot wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char=
-
> > > misc.git char-misc-testing
> > > > head:   51ea3f9e9017b47c15b37a200d8e81e36a169b70
> > > > commit: 3f359bf61b6f65be474fbcdf557cd412f19d0f1d [20/24] misc:
> > > microchip: pci1xxxx: load auxiliary bus driver for the PIO function
> > > in the multi- function endpoint of pci1xxxx device.
> > > > config: sh-allmodconfig
> > > > (https://download.01.org/0day-
> > > ci/archive/20220902/202209020641.mPiacQE
> > > > P-lkp@intel.com/config)
> > > > compiler: sh4-linux-gcc (GCC) 12.1.0 reproduce (this is a W=3D1
> > > > build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-
> > > tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         #
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-
> > > misc.git/commit/?id=3D3f359bf61b6f65be474fbcdf557cd412f19d0f1d
> > > >         git remote add char-misc
> > > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> > > >         git fetch --no-tags char-misc char-misc-testing
> > > >         git checkout 3f359bf61b6f65be474fbcdf557cd412f19d0f1d
> > > >         # save the config file
> > > >         mkdir build_dir && cp config build_dir/.config
> > > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0
> > > > make.cross W=3D1 O=3Dbuild_dir ARCH=3Dsh SHELL=3D/bin/bash
> > > > drivers/misc/mchp_pci1xxxx/
> > > >
> > > > If you fix the issue, kindly add following tag where applicable
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > >
> > > > All error/warnings (new ones prefixed by >>):
> > > >
> > > >    drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c: In function
> > > 'gp_aux_bus_probe':
> > > > >> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:87:52: error:
> > > > >> 'PCI_IRQ_ALL_TYPES' undeclared (first use in this function)
> > > >       87 |         retval =3D pci_alloc_irq_vectors(pdev, 1, 1,
> PCI_IRQ_ALL_TYPES);
> > > >          |                                                    ^~~~~=
~~~~~~~~~~~~
> > >
> > > Odd.
> > >
> > > Ah, the driver needs to have a "depends on PCI" for the Kconfig file.
> > >
> > > Kumaravel, can you send an add-on patch for this issue with the
> > > proper "Reported-by:" line as asked for above?
> > Greg, for the add-on patch, can I modify only the KConfig file which
> > you can apply to commit id: 3f359bf61b6f65be474fbcdf557cd412f19d0f1d of
> char-misc-testing?
>=20
> Yes, I can merge them together.
Greg, I have sent the patch. Please apply and let me know.

Thank You.

Regards,
Kumaravel
