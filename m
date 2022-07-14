Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBCF5747B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiGNJGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGNJGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:06:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE3E10FEE;
        Thu, 14 Jul 2022 02:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657789607; x=1689325607;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=td6urJBkY1SWlXZDGjoCt4U9U82Yawi7uk6mcIupo0M=;
  b=OEa3VfJplISOqHdUaTmE1bYjJdzkDM/AKfgfd0ZH3XfB8fkwoApjvky4
   JWoAXkPiDId24sCN2oawYyadkatifmNzx4+kr7PwnO9Kp4UyMWxaBnH8i
   eCtqagdXbmIR+7jFmhGokpSvYw7vFA78EYUr1Xb50P8BFAuLv9RvTbO3+
   niLLGZvccRMMgj4l298/+Z4CgsPCKEzTXgPhMLBkhsgjYHcJ74dcSMM+5
   vRwEIUwTJE5ea3HQa0O1O0ZXCKBPHpd6P0Fqyvw/WB+gNCz1KHpF7OYWd
   e9Z/tmqWi3zfJSyuX4WPDCrAfXD2K9nfm5wlid+s4Ob2XmF8W6SaLhEX9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="265871199"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="265871199"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 02:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="570988185"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2022 02:06:46 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 02:06:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 02:06:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 02:06:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmxL7+ZPIGJ4MbKTllFhSy9S76bXggQXstXc2fa/bIz7SNe1KavkGUcxSFNKbaqJjXsKC7rlXp4v3iQE+h89nQqH8EjeqV6NLFW8v9GE0D4CjYctxUmgoLwlk74qq2hdK6B5Ut75G6ixb17aHkaB+unODhdGDBvb2V8+wKf0TEscUYpYnRN1rl4VqOrcPoSl4OLVKr3HU/AWgWy6/+AMw7W4eTt4i81pdZb0T/uK0vxhn53s2i3If/ELF7amiotebHCHaZu4QJ66XwnmM4Afk8iMzbwfoVpwzQDunjfg496p+nZittH1DkaU5XtNCt5PlwKWsXRfnpNxMDa/AxWckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtb3gXpkrbIRr/pRxuilPzELCR8TexQPz4WZTgXwCVw=;
 b=YBWF85qFZpQReAwwSUKgbkzOBXpGXOfA7NGLh2gldOsxjYl3jDT+ukvo4VHU2Qij3TyCT1vlIe6ez7FoSHZFsNvNjHHmLx3Jtv7GH29W/DuGhhIAf5AwKPjg6NVIimPjxEpa0bE1ZVKyjQ9wUTQ1/MQz5vnPD8eC31Uk9j0DqJbX2cF9FcpfNuy5xB0ORTkM4ejwigHC07amHeN2kJzbTJtopRB3ofxv9I1UEDSwFmYGM+c06ucNgmYcfUqHc+2CdGTFPtP/A4hIF804lGP2FTkY4cS8BDb7mNNABwheMO4f/gV9xIl/5Cg/PWsdGjg9G0fltKxzHweOwFzA7QsoUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN6PR11MB3293.namprd11.prod.outlook.com (2603:10b6:805:be::11)
 by DM5PR11MB1931.namprd11.prod.outlook.com (2603:10b6:3:10c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 09:06:44 +0000
Received: from SN6PR11MB3293.namprd11.prod.outlook.com
 ([fe80::7018:2f77:e0e0:40f2]) by SN6PR11MB3293.namprd11.prod.outlook.com
 ([fe80::7018:2f77:e0e0:40f2%7]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 09:06:44 +0000
From:   "Kao, Ben" <ben.kao@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "Nyman, Mathias" <mathias.nyman@intel.com>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] xhci-pci: Enable runtime PM on Alder Lake-N PCH xHCI
 controller
Thread-Topic: [PATCH] xhci-pci: Enable runtime PM on Alder Lake-N PCH xHCI
 controller
Thread-Index: AQHYlep6vaZ50mhoxUKHlbsi92rDL616roiAgALW96A=
Date:   Thu, 14 Jul 2022 09:06:44 +0000
Message-ID: <SN6PR11MB32930FD21F5C00DB8A8429A0ED889@SN6PR11MB3293.namprd11.prod.outlook.com>
References: <20220712122442.22504-1-ben.kao@intel.com>
 <Ys1sxRT0i/NXSui7@kroah.com>
In-Reply-To: <Ys1sxRT0i/NXSui7@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88416e0c-c7ca-4dc0-a7d3-08da65782c79
x-ms-traffictypediagnostic: DM5PR11MB1931:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0bOVgu4w2p7KozUM4s3Fwd83EiBhGgjq7Q7xqH4nzO7whzUDqRXWttPM17FpBp3nX6KZHeV91ufHzJ1Od2HbPxy3gO6lMgvfJrYDdhloiypzNkw4anNrgFeYsnygWCKPUqP/a3l70QhumVqnUhwZbP1IrEB7sr1d2LoS37Qe3WJFR4Kun122b2zt/mQwCrO/QeG9aXvvehHh1oX7uTHX9HXw6OrJh395z7oSncSfNNnCNsXts/mwp18dQwmxH0Xeu+vtVaHtyj4BWrE+NsNCqiRDiUBv4OduklOWUHaoVvgDrRnyOoaSBgMdDKsVXOLQEvWYaevln1JFb+Cle4wJH7t3yBOcqRQWnl15krhLu3SnV5f1aQ4fmiVHDZlLczYeB8UlUnZ1zn1++9Q1wH6NAT3KmT3klxUftsWg085IxX37NtF/kWSU4SYhJ5bS8BC7MY83XYtwBpsimtvHF8KyWEWfnGDWoGR8jrciWCzN8h1l4FaD5UsUR5CMK2msEtjhdnps2KoPZ8IOCKQLdtDoBGSJk+jbhaol/MZeaSYIn3PtPfH69QRt/ssAwEeo/owDvIIycrIeaolFfix+ZcZdugGJ4ORjG7rCiC77upwkwfH4PoIBMsQ3sfiOf3mwqGM6NA/5dc0FEZVJK/jF1nlq2xIni+DTnfmiWyr6eM8+7AcGyeAqomifL1YBJWsGBhOBtYxEUbK1hOWR2LYZO3NKC8bK7SV12fKVfxZrEPOjFKeDUE99OI/56WhESYo+CE8U1Lde/p0qibV5U5MPhZe3qvVhjClRMW71udvjhCgVlR2pvgBXSrPK7ZAFEx19pU+NKfsEt5XuO8TVdbKrpUjRyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3293.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(396003)(39860400002)(366004)(86362001)(82960400001)(33656002)(9686003)(38100700002)(122000001)(26005)(38070700005)(7696005)(53546011)(186003)(64756008)(41300700001)(5660300002)(71200400001)(4326008)(8676002)(66556008)(66946007)(6506007)(66476007)(8936002)(6916009)(2906002)(316002)(52536014)(55016003)(478600001)(54906003)(76116006)(66446008)(226253002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KS7agkhP6w3xypqVQ18jlDK/3jwE9QaHn2KjZy8hPJEUQ31laJ/UiZBDw4Vz?=
 =?us-ascii?Q?wsbUJPBOOZurrzIvEgpI0oGQFuwIAnOfPIX6kMFMHh6GYFlTMgZ/d+RrLAHu?=
 =?us-ascii?Q?ip3uuIJLkzHoCfIXaZxzNEYlA2aER7rdhv/2NNz4up4E+p1z6Dz4jNhSz/9G?=
 =?us-ascii?Q?+kTMbKIH7DVi4FNRiALXD8tQ8Hv2n5izbgrkh68sHy40fcH7bZ1EE821PZXd?=
 =?us-ascii?Q?LhsmNFqkP2MphO/+cmcYAShkfBiduYVRMvixvx0OT2jsmDsdt1ailHWtcTzw?=
 =?us-ascii?Q?MaK8v/I3Q4Er2kNbTdslk2mtpNm7KnjqQbcqUf+HCe9372ObUIkXl6FJLQty?=
 =?us-ascii?Q?qCMQXQueuysZOFsMumyndKc/EcuY9kXxe+Hv7bS10t0/2l7jVglE6wA+TjTs?=
 =?us-ascii?Q?mqoO4ZUrBp2DzC4IbwVui75u7ZyZksW9HuBEG8Zh6vr1D1D6rl663FYlPgfB?=
 =?us-ascii?Q?Hk2rHvd2gL958fOIeqFcQ0AMB26bZ/w1Ylude3xz7Gg+g5qYhXotiq1fmoD3?=
 =?us-ascii?Q?Mlimv3wjfhIIbeyYiIPxnjZPXOlzGnYu0dZWDinEoZj6EDM6uZesgkiV8srC?=
 =?us-ascii?Q?gjsTwM8+asjNOz32pRPpfwv9A/3IbL7GpYevjsd7+i27naPi1+k3Jgum95K5?=
 =?us-ascii?Q?AYGxd9sPdj9ZHSngvFDHPl/iCHEDNF2X9BBUnRDucN5Ywjy5lQEgaOtaIBYg?=
 =?us-ascii?Q?IeV61+H1CjIQnX0eRGhwVS5VKHZPygclThcDnLJnpnTXuc9qxAWOlxw9ZmMV?=
 =?us-ascii?Q?VAOJjWv43t4JDKn4U9OLXTauLlsFeH/VhRc+GwCXK3r3TmQvqqQU6HYoccMn?=
 =?us-ascii?Q?a7YqCyLDRhEAfZ8BrS/HEbYCxgZh/ZLAHnk5maCPo+z+Ox/WdD4dGIOoePEu?=
 =?us-ascii?Q?Gbb5iuGw+JgQsRyKw5FC584T942dO3cdAQoB4vTaI5juNcyzDoLntCC6EkQ9?=
 =?us-ascii?Q?nyLpkT05ifBi8xQgJn2jutakQHLlREAoHkKsxyg+Bmn2iy3oxK1vWdU1AIlw?=
 =?us-ascii?Q?FvFEG473sM9S4Uqw+dZKq0etm92yBQ48A1O1pq5a5kph0UDgt+iOdrizO7Ov?=
 =?us-ascii?Q?O/+O/TWu1pl6mz4ffzAenWts1QACMRPl2BYfuoOd+VUeVOSOokeLpnG5FohS?=
 =?us-ascii?Q?6GrMFBANWxvWlB1lrKzrgMjSPlPQKztkgiw3vXE9PiYs7M/BCelpHKP6bpAV?=
 =?us-ascii?Q?zbEmruStrKsV8cyqlDyFKTZrdd1EqifRZvGhZhLQhIX3VF8HCy6ai+FzIZ8Z?=
 =?us-ascii?Q?7vIjgZ3w0BkjwzbjDOmCMEVlRIHsPR57Hgoq8cvDZC0vPKK/FBhIx3HKk6a1?=
 =?us-ascii?Q?IYPHOvU17IwfZeHaXXUSLkJu9mWcPDVnbfCBKer5H+OMcrEK3P7E9zXBCVJQ?=
 =?us-ascii?Q?IuIX4veeuf27jNA55v3tnHhU3rZKjFUeKxR99wnY78rLGiDb34AeIDO7kcyR?=
 =?us-ascii?Q?ZJsb9zgsptMS+NLVIolQ7brsBQFtBhiNVxwMp6ZQ+O0kpl/Rt+ZppMveA6Rq?=
 =?us-ascii?Q?Yj/6k0BcPKFAbK0uzWE6SmfFHiiw6tHhz7n8m9hmo5kUHwmO6zSLt5iajs+8?=
 =?us-ascii?Q?lw4+VtalxHvcTkTBHIo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3293.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88416e0c-c7ca-4dc0-a7d3-08da65782c79
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 09:06:44.2841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/jvAkGPS8Vr+JY0P1WpTv3n0K4/jE7b5CfaiHMuWz9GqOejdvA8nH7vdHpIdp8Qd3GlDSwM+t/XlSGJsgQP0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1931
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, July 12, 2022 8:45 PM
> To: Kao, Ben <ben.kao@intel.com>
> Cc: Nyman, Mathias <mathias.nyman@intel.com>;
> mathias.nyman@linux.intel.com; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] xhci-pci: Enable runtime PM on Alder Lake-N PCH xHCI
> controller
>=20
> On Tue, Jul 12, 2022 at 08:24:42PM +0800, Ben Kao wrote:
> > There are two Alder Lake-N xHCI host controllers with PCI IDs 0x464e
> > and 0x54ed, now we add the quirk to default enable runtime PM for
> > 0x54ed.
> >
> > Signed-off-by: Ben Kao <ben.kao@intel.com>
> > ---
> >  drivers/usb/host/xhci-pci.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > index dce6c0ec8d34..44486156bd5d 100644
> > --- a/drivers/usb/host/xhci-pci.c
> > +++ b/drivers/usb/host/xhci-pci.c
> > @@ -61,6 +61,7 @@
> >  #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI		0x461e
> >  #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_XHCI
> 	0x464e
> >  #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI	0x51ed
> > +#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed
>=20
> I think we ask this every time, but why don't we enable this for all devi=
ces
> and then only disable it for the tiny number that don't need it?
Got it, I will provide another patch to enable runtime PM by default for al=
l
Intel devices if no one has concerns.

>=20
> Why do you all force us to add this for every new device created?
>=20
> thanks,
>=20
> greg k-h
