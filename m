Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8825ABE71
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 12:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiICKVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 06:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiICKVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 06:21:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA665AC78
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 03:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662200495; x=1693736495;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=YePxXKZTVDf9TADvQHsOXXoVT4Nt2gT236/iuge6lnE=;
  b=eJw4uCrH2Vjzam5gGTQzl23zSIPTcO3uq8PNpUCDzGXNSVF25OJdyO/x
   2Q1jdbCuFBjdwwmqLnOZD9LS7yWJNk+LOSWMl7rM3VRzm9BOsDoN9aWH6
   nxvReRU9dZenvQXU8at1TS1/XTWyDR/oq4nS6SSFb7XZwD5JspmmA1AsZ
   RWAu57+NQ2b5uPT3Wz5MwDPJ7SXTMM0BX0OH8s1Wm2LFESSUsRBOkI3KN
   YGwugGO4x5PVn/9DW5bRfjrOU+2GMow0KTSJmQgv1XMfYLBX1tHXl9sWY
   DxGYtdxi1O5USB3vTr3MkV5mMD41XBsQ5LFByjs6kuySRzITOpE1Xkf/P
   A==;
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="179035672"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Sep 2022 03:21:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 3 Sep 2022 03:21:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Sat, 3 Sep 2022 03:21:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUIelPmUXOsMyyr9pwijT4MMsbG2pJQQkucQ9XmHceLsjLEFQCD2nKJp7G1HLLy64Ueb0Dp5iIa0wCqqj6DBMdEoE/t2qQMEM3gmfovuJ3Ao/cz9GsYQnW0MFGS4WHNPglW1lGvewdf0HPR0gUu8/qbUKmPDj+kBytTdQIMH+0S4S3sA0BOWOfEhkAM30EsqBE+IiE7IFfnV5acInwBT17RA5r5i6Lni8m14rN8K71oTHj5D/RtmCufhwC+YhxumvykJSCTgbYPFQM9fV0ulABdZlNiUwrE4Sk03lEWz4mq2WRfphxXUQVvWhSyVZrAOKLk6tzMjC68PmbbDAEycUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yH/DWY0xJ6ZpEV5QgaUUopTRfHa9uFlvWqnaimQ0iFI=;
 b=hkOT6mZzFjD6EUmQXvA1sV1Ks4EwaaIgx5iSPjPx4xZQj/6n2/CKspIRxfaUzdUegWkaE1+LAyibwqfjSS6J7BHyOoLlgsUpCneFkrZVUzq8iROROrdz3a9y0oz9o4aZ6EO3rIp4v5qGFFyY7NBS8z65Rspq2DjdYHI8LaomsxfvYMKACrVRODGYe+njBxEUJ7CKawRLLJ9ipTwWqYEHCe011QtCvkz6Ij6io6pyNrX0q7E8A5f1BHlsFaOxCJLDcE/48w9y2uJbG9R/N1x26pC5TQrueZMytHEY8l7CDFds7rfVgG1DdouJANB4nYG6zbvMkJZBNjbnuH6AJJCoXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yH/DWY0xJ6ZpEV5QgaUUopTRfHa9uFlvWqnaimQ0iFI=;
 b=Dr6mA9r0EGdvOlZw2eGP5m/7pRIApG6GtESIADwGwHF1/3XSacfu1WPX6Z4LMWGQTiHVPTTXhAdcgrea1rwPBAQBmr0u0QrKYnd32MOFIos3Z6txjphPV1rKfXZuiSUGxFzHeSt2caqwC4v7dI+aCb0nHcsAQGw6R8giZxFyvNk=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by SN6PR11MB3263.namprd11.prod.outlook.com (2603:10b6:805:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Sat, 3 Sep
 2022 10:21:32 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5588.014; Sat, 3 Sep 2022
 10:21:31 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>, <lkp@intel.com>, <paul@pgazz.com>,
        <fazilyildiran@gmail.com>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc:char-misc-testing 20/24] kismet: WARNING: unmet direct
 dependencies detected for GPIOLIB_IRQCHIP when selected by GP_PCI1XXXX
Thread-Topic: [char-misc:char-misc-testing 20/24] kismet: WARNING: unmet
 direct dependencies detected for GPIOLIB_IRQCHIP when selected by GP_PCI1XXXX
Thread-Index: AQHYv1xEihQ9dIyWXkymDyrNGEDRC63NSYAAgAAmIZA=
Date:   Sat, 3 Sep 2022 10:21:31 +0000
Message-ID: <BN8PR11MB3668BC26BC1B17B09A888271E97D9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <202209031414.Y8YCEjmI-lkp@intel.com> <YxL9qpQ2YcvC4sjh@kroah.com>
In-Reply-To: <YxL9qpQ2YcvC4sjh@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31ad2fb1-b257-43bb-af30-08da8d961240
x-ms-traffictypediagnostic: SN6PR11MB3263:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JNyPW5CJFOxRD1LTwY6r+L89mr8XuVhLVjSEtYxo2SvaGeYR5jvJ5H+32KYLAvAC1C80HCflbx6OYXDLeOBzUui2Y6CTWuUByOfHhm6Yz56wn/Z+Ih1qTVxZ/muLLC/GB82ohO3jX8hGMq5jUUZIsrZWJLVGzilYWT06afbybu1yMT6OBTNviGz8IKx0S0MISpZ+EBUURAskwUDpaODroDNtcl0ONrR1pPCdf1t6pP0rtLkgEVAcmZPG9E92kFEty4WxzddEbODMRoIAH/Y+95JfcGWEuG4E1XrQdaqe6f+AX9aIvQ3dhm0BqylgR0AcOkDEoLYp8pjGhvy/aup9uOk3AaYuOROIEu+BsdkaK3ijs/w2kfinLePDux7Xbbcd+liskTzDX0g7noDDHmtasrfVQS0f+X2Un2b9fS6Vj00QC4QlSfcsW7eAgQ3YXGi0YDsDSrh5zeU41Quxaao95f9fgVHEHj0LIsYvWf81859pUrruByQ5GbKm1I7dtq0VC2ZtI/PW4OkSHhnAu6P8GhRCVGu0u1b/FpeXsiWOmJ7hqlI6v4RD9hl/6JLI6Qj5Mt5gTMB79H9IVN4Xtc8JIsOLsdiEBHAz4W+VHZ3MPm1dSFVaxNnsIGfdLDN4G6sGD6WuB6wh1kES8p+WkItrCWAHkkwV9Hh6Wd8v1xkihEHSvqokMhH9PEd4xm0ex0SNeKj/eGQolRjxtEWGvio+vU0TqKqtjX/DpfqJlsCu5G8cNm2JldXUo36gYmVPYOZAPJ8+S1AfC7xstzW8+PjTJOnKbjxPfPEAZbM34VRo5f8Ng6kcRGfsqDV1UMbHI/MPKS6JdqN0MkpBjxyUuKgtaWQmjJUqBRiivpO+EPaCGKrNdlIsg07P/KWv4h+/uDjqGugtnzYy6+To3p1HOkuFTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(136003)(396003)(366004)(38070700005)(316002)(76116006)(38100700002)(66476007)(66446008)(66946007)(66556008)(64756008)(8676002)(84970400001)(86362001)(33656002)(122000001)(966005)(7696005)(83380400001)(2906002)(478600001)(41300700001)(6506007)(9686003)(26005)(53546011)(71200400001)(55016003)(110136005)(186003)(5660300002)(52536014)(8936002)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?USqxd2wwDq+W7RQ/MDL8l+ggEdaeq+d85ANndQJQWwt/KXxiiLZ61HxZI9X2?=
 =?us-ascii?Q?E3h9RJBVe1MzSvflDNLYJIu97JyO9mtTJe9JmdsKFDhw5buez2vHmAqNZqi8?=
 =?us-ascii?Q?haOwzCZU1tJsAzVDH2IB2foZ3gdffSCM1ugYcj216Ws89YEwZDg2VcDPmxIL?=
 =?us-ascii?Q?E/sdSuxH9YLLqltuVZFlfpPU/brNZ3liJek9zX1kYkEJL/FHdHi441Q/dP3o?=
 =?us-ascii?Q?9bYOeihTbCZcJZS3zhQsAW0v8FMxk0017NAEW5b1nG+QyXLuuvSI6tPEW30z?=
 =?us-ascii?Q?0iosgA57SOYcCx7QkKwUX+j8IW8mBbi4h+h9ARIPXg7aqB2njhw/l8TK/0Wa?=
 =?us-ascii?Q?hEv46fYZQgm6rKsOQxlykDqLIdhfavDuWufp6UgJ2LAUERahPQTRbrTnJV6w?=
 =?us-ascii?Q?YRxcOq2U9+kuUHAjUST8cC5fz7pmdZlfgHFXIZpZJrW64jrP2JtR0Z19Rkd1?=
 =?us-ascii?Q?mfYcveG0E2YvTmjbo1CF5CHL6eVts8zJZvYeF+9JLOJKsLLM9BlboPr02zkR?=
 =?us-ascii?Q?s9VQ5BAGXKKa6LnLSNvMpyhWE1rNwMJjLBylkB8ASARMqL8pJEpYGFgcb+dH?=
 =?us-ascii?Q?WlSW5ObpLSqUuthaaJijhsggnW9vb8eppv7Y97mTfz4Q6pQxl3M0oStYBXIx?=
 =?us-ascii?Q?e42UMuEMqUkFrZXSN9NQnAWpqev0OE7ojYIU4V39JY3gODCudMrF0aXRTa4X?=
 =?us-ascii?Q?vMLbdussCgMvyJjzV7MfsIUQjmSAD7xl69PKF0hhJJRZnWTpSWAaTAISKV7Y?=
 =?us-ascii?Q?qL8PygTQJ0auQM5wqrGRJu+dqhV9aej/sTHBYBPXGXyqQeGCIxDp9viucmqZ?=
 =?us-ascii?Q?wM4gcghB/kadlLsrkkU1FLui7HUkrJivjqIqXudMNDRRdPbYWMv4bi4Z571S?=
 =?us-ascii?Q?87abHpfg+J3mi8uwfOcwdndO7+mvS2M4+n12jio8Lw/FR7ZlohSF02UXuJHu?=
 =?us-ascii?Q?ZilW8+Vt0vKqzUkmCyR2BSJelEX979NkkjqiVYMxFlY89hBUcrEGDFqm7xhh?=
 =?us-ascii?Q?DUxCU62epsmEj635YWg4mkCChM1My0rX5j4De59ImSlr9ymw4DUd6xKyjqs1?=
 =?us-ascii?Q?FDipw3OjfKQBzGKcQzMolew+Gp5/wql4+/7LAj0m4noGZkQfq89lvH0qQ82+?=
 =?us-ascii?Q?krfKl4kUSQXxgC2PMtCajVM7DmFqs/0Bns4dU77H1lUqBlYkSr5KREXr0FvS?=
 =?us-ascii?Q?clEKTSJZ1Tz89c+cSjYmBfJdpnBC/Q61eu+g4YdNMW2YOjENbOuXfRzcoVqp?=
 =?us-ascii?Q?3PEFzlnoPxFcpPf26qGS3MtxN8tuVPQEfF6drnieuFSnmxA2q71A9rAeW+4h?=
 =?us-ascii?Q?1gQeN1vynBsOTJQe3oYfu19GAvgdAN1bLxS5F74PR8DWa6OUJdduLCmPssbZ?=
 =?us-ascii?Q?Rzzh7EQqxDluOS3jbNYkg6Wlg/fqIhv1O1DwYsZpshxaazWXRBiYU06Mzbpn?=
 =?us-ascii?Q?l0jyTBrZYHVyy+MvMQvZAuePw5YMq1DPXEChcH0R8BgcoYo3KHb8mZ/NFsap?=
 =?us-ascii?Q?fvSZRVnx8QvYy3bwP2+xdWnTRfTm1RA1rBLVUlK3AA6yjkaBLWluZo+PXiAR?=
 =?us-ascii?Q?d6hPx91U7DC9dnvUd6Mct2IS6qj1kLwAmWFgqwrq3Pou9DRtYYMVs+hw/48U?=
 =?us-ascii?Q?dJ+GrXix22SvZYRWyk/gAEs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ad2fb1-b257-43bb-af30-08da8d961240
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2022 10:21:31.6561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IN8la1omMiVTR+NoZlFftWzS/rqYFbwmJ94RMmWQhYnNVCRwOW7Gyc/qsS7QzjuAnXQunUubW+o84ncR803TCphGPObSsQ/tbEffokYrQ0vA00ZgobRGh0a7Jiw4LxrO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3263
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
> Sent: Saturday, September 3, 2022 12:40 PM
> To: kernel test robot <lkp@intel.com>; Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>; Paul Gazzillo <paul@pgazz.com>;
> Necip Fazil Yildiran <fazilyildiran@gmail.com>; kbuild-all@lists.01.org; =
linux-
> kernel@vger.kernel.org
> Subject: Re: [char-misc:char-misc-testing 20/24] kismet: WARNING: unmet
> direct dependencies detected for GPIOLIB_IRQCHIP when selected by
> GP_PCI1XXXX
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Sat, Sep 03, 2022 at 02:12:13PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-
> misc.git char-misc-testing
> > head:   4ec7ac90ff399b7d9af81cc8afd430a22786c61b
> > commit: 393fc2f5948fd340d016a9557eea6e1ac2f6c60c [20/24] misc:
> microchip: pci1xxxx: load auxiliary bus driver for the PIO function in th=
e multi-
> function endpoint of pci1xxxx device.
> > config: x86_64-kismet-CONFIG_GPIOLIB_IRQCHIP-CONFIG_GP_PCI1XXXX-
> 0-0
> > (https://download.01.org/0day-
> ci/archive/20220903/202209031414.Y8YCEjm
> > I-lkp@intel.com/config)
> > reproduce:
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-
> misc.git/commit/?id=3D393fc2f5948fd340d016a9557eea6e1ac2f6c60c
> >         git remote add char-misc
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> >         git fetch --no-tags char-misc char-misc-testing
> >         git checkout 393fc2f5948fd340d016a9557eea6e1ac2f6c60c
> >         # 1. reproduce by kismet
> >            # install kmax per
> https://github.com/paulgazz/kmax/blob/master/README.md
> >            kismet --linux-ksrc=3Dlinux --selectees CONFIG_GPIOLIB_IRQCH=
IP --
> selectors CONFIG_GP_PCI1XXXX -a=3Dx86_64
> >         # 2. reproduce by make
> >            # save the config file to linux source tree
> >            cd linux
> >            make ARCH=3Dx86_64 olddefconfig
> >
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > kismet warnings: (new ones prefixed by >>)
> > >> kismet: WARNING: unmet direct dependencies detected for
> > >> GPIOLIB_IRQCHIP when selected by GP_PCI1XXXX
> >
> >    WARNING: unmet direct dependencies detected for GPIOLIB_IRQCHIP
> >      Depends on [n]: GPIOLIB [=3Dn]
> >      Selected by [y]:
> >      - GP_PCI1XXXX [=3Dy] && PCI [=3Dy]
>=20
> Ick, I missed this before in review.  Kumaravel, any chance you can make =
this
> a "depends" issue instead of a select one?

Greg, can I select both GPIOLIB & GPIOLIB_IRQCHIP like below?

config GP_PCI1XXXX
       tristate "Microchip PCI1XXXX PCIe to GPIO Expander + OTP/EEPROM mana=
ger"
       depends on PCI=09
       select GPIOLIB
       select GPIOLIB_IRQCHIP
       help
         PCI1XXXX is a PCIe GEN 3 switch with one of the endpoints having
         multiple functions and one of the functions is a GPIO controller
         which also has registers to interface with the OTP and EEPROM.
         Select yes, no or module here to include or exclude the driver
         for the GPIO function.

or replace "select GPIOLIB_IRQCHIP" with "depends on GPIOLIB_IRQCHIP" like =
you mentioned?

Please advise.

I am not able to experiment with these options as my Linux development mach=
ine is not accessible
due to some maintenance activities in office during the weekend.

Thank You.

Regards,
Kumaravel
