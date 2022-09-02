Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FBE5AA9FC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiIBIae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiIBIaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:30:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7E131201
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662107429; x=1693643429;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=SPMzVZuvJN7KHxgdh7Az0HjwP/u60NqGgIhESLG/DIo=;
  b=PimgBD7h2EWZa7axR2SDr2OYOsFEWKQnrasProSQ/up09p1kaeKhggqr
   xzlUbiEZHy5eAD4Uza5EtR9HP2HV8UJPKGJ/Two0nenWplaIgJYRtOLa1
   q8eL/bDf39SrI4sLVhLhPju4/gvAYjsAEAuaBFCu4ufzn6T3TAPk4Guo7
   mApV1GK81T9ioKCDbGnrbyOdfgxr7YPucw4H3dnep+JkWh3ws5/HQVTW0
   0lqoR2U9jxj73v1phA36b0AvdOiqQLvbFTGW3yEfmCeHsmXWFpUyN0NCc
   jYyqrC27idLvXcn7cdB92we0P5b+2FpGfLtAvxWZaENZAOG1+b85Ue37I
   A==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="178894125"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 01:30:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 01:30:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 2 Sep 2022 01:30:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXX5ch+qWuOHjB06TLUPBL9sMDeGHSmBjLZPN+8/pTRO+NJ7edrWr7fzlzeSf6nIW5Q2+U7DFjelhg0yW1+PuGJ4ofNA8IFhEVmhH0IIE6ePUTm0TCCihN2aRt6i7Wlk4UCORb1jCXL/K2qlQP5oHBh7zReXXne07aoGM4oPwRdDfbP91l1w6lqDvgHj3UV8DF+X2UBFfT6tlf3fB50TQWzELHB60YRXYvMTQcGipfxuDptPgwuc+hN5QCE6Tw33gZfIMKrMGRwe0E06VxECmi59+7P1mHDJbvx+4QXiU7kGwUnFZEAOfvG+XhWnUbLee8p9LSwTszoxfH2ctM5tcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cirjS9HHpaBYZJ7VZ2BmDVfWb/XoMG/QnZwV2Ug95Y=;
 b=c9svl9mioxKYtVaR6kVu5CWTDr/5OMKt1UKBv1a/SgxBYogkN68jmUNk1m/w6gai63tzw42OPDZtkbd9FlywN0NTaMgFq5UERPNsm6fIvBnZU9AohqgRD8S3WO3sWuxLiIRlqcJior+YPhk06j3f+jDdATk60rVVc5orToPmfA+iBp00RsEuW1x3zwavtJdcDv07x3t1F0nU6Pm0iG1dxjoiOF8ygrt86JAgI2fS6dwfI2fs8dTk/QVAUtl8oh/ZN5olluFN116EblvWiIO5/x+41jo0JsOoZ6QWpirDpXeVwLUgSx1b8UBQe/Cx4Fl14zet+IGZHCdDnNVNbGJLlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cirjS9HHpaBYZJ7VZ2BmDVfWb/XoMG/QnZwV2Ug95Y=;
 b=NZsJ7Q9kYpymaHFzM1ffmHcj24Soay1Y1lgugOj+QPlO3a4zKaH56QZLbmrdQm7k9EhzntQ0g2HAubxIHfm1EU52aizn8eoDbT2RdPiE3nKCIBhI1mkwNeQsWgRDRldKz/DKi/AeVjBpYK8xR2MBe8fkgT4yDzAF2yS6SZTcDR8=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by DM6PR11MB2633.namprd11.prod.outlook.com (2603:10b6:5:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 2 Sep
 2022 08:30:22 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5588.014; Fri, 2 Sep 2022
 08:30:22 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>, <lkp@intel.com>,
        <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc:char-misc-testing 20/24]
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:87:52: error:
 'PCI_IRQ_ALL_TYPES' undeclared
Thread-Topic: [char-misc:char-misc-testing 20/24]
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:87:52: error:
 'PCI_IRQ_ALL_TYPES' undeclared
Thread-Index: AQHYvlA4FMupJOOnQUyiaRis4mwVTq3Lt1wAgAAW29A=
Date:   Fri, 2 Sep 2022 08:30:22 +0000
Message-ID: <BN8PR11MB3668E0B249AB3CFCE15A4D3BE97A9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <202209020641.mPiacQEP-lkp@intel.com> <YxGqkvNg0rXDXoew@kroah.com>
In-Reply-To: <YxGqkvNg0rXDXoew@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 385eadb1-a951-4435-586c-08da8cbd60bc
x-ms-traffictypediagnostic: DM6PR11MB2633:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3YAtlUXUVpD2WaBSCfySHPLB607biJDQ5reFOQl9lEiIIsHTIm3qA5Jq5RlKq+tAP8JnioSgvwapJegg0Nt2JZimiDbKYTftwBFIGljtnzM2fjQlEzxejYxK924Ow3qF1XVldJPGfmF+y/JnFWgnd7oKu9johd3KPm+Lxd6X/Z7xJA1ni7h8wvPUlz/AQMiQ27NGIupUhyjjUYfaC5n1xzTNuv2BJ4oRI1JA+SwVdYMPgFDNNYGgeaWgBCoCeg1wE+vyNTCkam6kETjEKOB792UWNOLFKrGfOM+yn3Mg43O95aHaNmMnmHIDj3ae/LnmC1WzmuK0B2uYLYqrmOFfUWbAfqBQgChjsrXHF1xXodcmbdydv9w9/N1XFpVSx/CDUDd90mJnEuQHHM6yWL+FCOuljiqrJK15YrtlVWCIsr4Zs0OMu4GnznNj37M17fJSaWjikM+oO9MnzT+HOiZ35thCGZAEXQPDID+wHS8mVTSZuFYyfbTPlVDqtixCJKPsbqEuOxu11bpIrHpFbxOBk7h1UVg9u81B7IALUcU3daWJAxBEbHpi+Zl7ECSCQBGdBYtwUMMnVBeeZOue7sjTukb2xL1hMyD4ieS6a1a8NudbUt/lH9yWfoGm8yxBqQ0f6BrpzzMa9AWp3HoMJV9FNcymoCvIL4a1geQK22ArbxQU5ZOZJoeW44I4Fp+L7v5nxA9W1H5JYLRyVOWhVLGq1X6UBXl+dZqVrUHk0F22sO0/x+gDeMeJtFFqpXKgq0SUJ/nUbDhumHxqBzmwqr0m4ddlSnklKLbmGWowpRgOLbWfnwawsR4hAbpY9v0zQomRdPho0Uzz1b7be4RPcMwUlBz/xoFT+9Qvntl1P465860IwFZxzHSmTjNbRTvd6ZlFalfw0VIuCyrGWRvaeUkwrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(366004)(39860400002)(396003)(346002)(8676002)(66946007)(76116006)(19627235002)(84970400001)(66556008)(64756008)(71200400001)(478600001)(966005)(110136005)(316002)(55016003)(66446008)(66476007)(8936002)(52536014)(2906002)(5660300002)(38100700002)(122000001)(86362001)(33656002)(38070700005)(26005)(41300700001)(186003)(9686003)(6506007)(53546011)(7696005)(83380400001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3s8PgLqVnRBxPHYOmSmsY+6hGCjlWmDmk5hF8QZZNDNZ4UC1bvbxlYAhGayZ?=
 =?us-ascii?Q?mECSqGM/9JT6BZ8xjpifFp3DVdph6RTAdR21nopjbUcwn+Vp9oVXAMOMeqsW?=
 =?us-ascii?Q?cDk225ah4GGPud1RXxvmX2zrRH+q85qZY6oIUsXVs5eDXKwEpyVCGEBdr2HJ?=
 =?us-ascii?Q?mPAJQOp4++f4A19GN3HTAvbasawN7/qN3cuGPYmOKdb5qHR9nTAlq+9ciPlM?=
 =?us-ascii?Q?GAQfgck2hPJAjsE/uMdg6cuzQ3mxWPCrC2NeN/Qc9W0aseKy0gKUnrdC7o8L?=
 =?us-ascii?Q?zSVR8rqDWHwAF9pt/7dHbM+sFAfOr7MDSMOXA34imc/fPbJKYNUq7LZgMAKW?=
 =?us-ascii?Q?cGDVapi67LqfqQTQTrIs46SxS5fGv+W+CKW54k3yQfXRhHGW4BPJ/Y2EhfY+?=
 =?us-ascii?Q?BAJejG9LNKhHwLLT94UU9LV9dsQwIZ+LrG8wFqmrPqjK6RlJUPUipeYNeYms?=
 =?us-ascii?Q?AUAytNCaTp2mmw1zx0WXe8SOAxNFDn9KD4DmikC2cFb+IR9kf4c59w5piN+8?=
 =?us-ascii?Q?iAJuQWCPI9hR5jCt5Y4mO/SLicv0eatDjillv5hwQ67o2ts3MvchcZvsnmVt?=
 =?us-ascii?Q?pGG15iQ/HZ49eoPaDUFVZ3g92tgoQaMvq7DMaZ0ZN2HX/U47QOn6nEaNBJty?=
 =?us-ascii?Q?CV0UphKxkWmo+n4Bz4EuVGMqKaCnrRTg9T5ahWVb2m1L2KcTnekdWnLPAtdG?=
 =?us-ascii?Q?fBT/WSOEpq5fcnuEFHOHTDYBh/gmHARq0leGB+94cETnR8wiXCQoRmDWZ4bi?=
 =?us-ascii?Q?BiCoNKBnssvjmOF4QbeI3HZhTpxyur2EDAp0VtAAuv4gRolwFz/vrzBAkp6P?=
 =?us-ascii?Q?nBQ+JnJymejE68wfiL4amaMGO8f6mq1BG27VeUf1mSEHtp7bNIyhcFrWkpk5?=
 =?us-ascii?Q?FNdkU3+fJwJBJw5THht8lgCA1mQxCUxY1u5O+HMoF57ejXFx8BgfmzSfp8ul?=
 =?us-ascii?Q?HIrf0JDpHUIUchR7w8aEL3LtOimN9GrZnKFxpsVGMNsZmGFIwJF/Pn8zDGeS?=
 =?us-ascii?Q?JiHCALVicA9o93OPiHRVOzC9TH1aqDaT9cJ0jglyLvm3wddkbUJXICsZjyAc?=
 =?us-ascii?Q?B/FfKUrf6xqXZnUvWkq6hfap1x4fK9SrdzZnsHtFbAXx5UgmlQDCHi5CJS5U?=
 =?us-ascii?Q?xdguWXNO0aeukKS+ZYKMxxmqBUoCZY2BrONWwKd+Cm07mGhwu2qJ4ceOJpwk?=
 =?us-ascii?Q?JvaD+RzLX4KLrQv/Acs3KggBqYEn4J97/RGTXk9FjGWt+AHdMMVW6prhp7xR?=
 =?us-ascii?Q?8aeLqMJtatR9Qdc1f2nuHJQlslH4Nc8jWwdQPjPOAjrxcm8nDB/Qr9nU+W3Y?=
 =?us-ascii?Q?xL2V5grlbzqjFOvNHSRdB88Rfx6WXHWIDUezDWUfF4Sx4v3FhlIp+BoiAa9C?=
 =?us-ascii?Q?rIIkuuQABeFvZ98GrGtTZ8jplt2cTdh5YKx6RWPsYu8CtebjQhZycSVYN7bD?=
 =?us-ascii?Q?/vvQt1+rveO5+cINSmoM9/OhB74sjln0fwDGYw/r9aK+I6dLOSrNx1QEyP+9?=
 =?us-ascii?Q?HlcZWeybeGg3tSsrGhyxI5MOuyvUQBbNn+mewDI02W4Ami8VnEqj2c6BA7iY?=
 =?us-ascii?Q?DEf87MRoE1tsrjuxID+bByVtF1A00WOt5UEKkCFh5pgn8n+DrnG4AattPWQZ?=
 =?us-ascii?Q?yA+4dokx/Km/QAbQhrpJ+vA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385eadb1-a951-4435-586c-08da8cbd60bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 08:30:22.5385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i2Zh9l+oh0a1U4thnQCokScyVpmD6tgxUteBmmlOuBBAcSC/mTbqhEnnXg/YiCrZnKEEQ9JxUQInNRRCjZPnEE6pcSx1lPcQTKyNTSNEyfHUw7oU+fB2nILsNJY1SjHq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2633
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
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Friday, September 2, 2022 12:33 PM
> To: kernel test robot <lkp@intel.com>; Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>; kbuild-all@lists.01.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [char-misc:char-misc-testing 20/24]
> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:87:52: error:
> 'PCI_IRQ_ALL_TYPES' undeclared
>=20
>=20
> On Fri, Sep 02, 2022 at 06:13:10AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-
> misc.git char-misc-testing
> > head:   51ea3f9e9017b47c15b37a200d8e81e36a169b70
> > commit: 3f359bf61b6f65be474fbcdf557cd412f19d0f1d [20/24] misc:
> microchip: pci1xxxx: load auxiliary bus driver for the PIO function in th=
e multi-
> function endpoint of pci1xxxx device.
> > config: sh-allmodconfig
> > (https://download.01.org/0day-
> ci/archive/20220902/202209020641.mPiacQE
> > P-lkp@intel.com/config)
> > compiler: sh4-linux-gcc (GCC) 12.1.0
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-
> misc.git/commit/?id=3D3f359bf61b6f65be474fbcdf557cd412f19d0f1d
> >         git remote add char-misc
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> >         git fetch --no-tags char-misc char-misc-testing
> >         git checkout 3f359bf61b6f65be474fbcdf557cd412f19d0f1d
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0
> > make.cross W=3D1 O=3Dbuild_dir ARCH=3Dsh SHELL=3D/bin/bash
> > drivers/misc/mchp_pci1xxxx/
> >
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All error/warnings (new ones prefixed by >>):
> >
> >    drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c: In function
> 'gp_aux_bus_probe':
> > >> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:87:52: error:
> > >> 'PCI_IRQ_ALL_TYPES' undeclared (first use in this function)
> >       87 |         retval =3D pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ=
_ALL_TYPES);
> >          |                                                    ^~~~~~~~~=
~~~~~~~~
>=20
> Odd.
>=20
> Ah, the driver needs to have a "depends on PCI" for the Kconfig file.
>=20
> Kumaravel, can you send an add-on patch for this issue with the proper
> "Reported-by:" line as asked for above?
Greg, for the add-on patch, can I modify only the KConfig file which you ca=
n apply to
commit id: 3f359bf61b6f65be474fbcdf557cd412f19d0f1d of char-misc-testing?

Thank You.

Regards,
Kumar
