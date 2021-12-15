Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864A6475D66
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244800AbhLOQ3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:29:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:38550 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244775AbhLOQ3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639585760; x=1671121760;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QlJSTN/fK1aVVlK2s4KsgfrLJx5Z+k8rXS4KkAQ/ltc=;
  b=buRN8oLFLUXwNR9lAEDJ85su/GK46KxtHGTbM+o+PYTnCIFJw6VWljOy
   wsVCeD24XRhCjZ33/Mz5J5e4r6pvDfMB1w4TXzcPTRFVgo6GU2848Bx2Q
   u2DNC6QWaWCF0OgkNWl9muMDXjDpz1WSuidOA82t6HeRTCK+YOGt5M3rD
   5NznfaDk27r1+1K7SMvdL7cMR3wFO8nnyRxxJCMbt8HVQVvm/LV4wkLkd
   WlVdYEgyD9egkhIMPQ1EEMHuMhR1OFAVWJfbp1LPqt/fh82b/XGGqr4Rq
   tA1nTPbdtaEvtW77zvQHOY/zgTw5DmhNDVEQeLISWAF0YWwKc+lBmwXGg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="236802117"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="236802117"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 08:23:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="567975355"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 15 Dec 2021 08:23:23 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 08:23:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 15 Dec 2021 08:23:22 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 15 Dec 2021 08:23:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEPO3viTbmZTJuaNITmFJ2D13iRs/DvAltwBNRklzT3GiMJBDiweYR/YNFMOBzqlFfZxh+wQ8yx4cFKH2DY+Hm5O79vawjE7NB4Ze2ukdpwgk3zVa6AmH65vBPrMQasz4ITkAMf6U0+T+aPGRjamh8eG9B4uaXN+rAQV/WjDNOu7FWPCGemlQ/bVB16pmS9PfLHt7msYT9fcwtfXvFfcXz7V3i/TDYwpRDGEYD65ssC6uW0YGCmgmySErk0wDNHrSirp538WIAE1+v98LpTiijGwjtDchpkZ3X1W7i9+GkImWQ+dKFWPu1Z9HQYykBzKdp94MyrrZQNfs+Mq+Eb/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwnzxw8sZnywAUJYZK2eVQ/GtCp1bqLmlocDsmQM3fM=;
 b=hVaZ7fL8tDwMRsVKbfL2QVZvWH7aeoQcsG/4EvhVEmKJgT6EQm+7gpdMXvVOe0bA3JegwCnLkcj0bkY+quAPtazcjN8JUFVVSAg5aKI65W5UQphOhTHePKXLXqZYiv9Lpqq28DJMguj1iKo+zf52K3Ytio7ouO3XgatDClzze2POzNSHHlP7m4dkDPwZrDjLxtvRuuFtGBdAZ3Ga3emN/HKLItLTUUNBZfXRQeu0j2rcuMcoPzH9yhGVRCmOvGzim42sH5LaFU7nSjwmN3vPVUfVE1VdGDODZB4IWquuCsHpOnGWfzD8TD59t1Q3v3M6UmovN5T8+XqLyTR3CiMLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5545.namprd11.prod.outlook.com (2603:10b6:408:102::19)
 by BN9PR11MB5369.namprd11.prod.outlook.com (2603:10b6:408:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 16:23:21 +0000
Received: from BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::6533:7d95:6f60:aafd]) by BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::6533:7d95:6f60:aafd%9]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 16:23:20 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v6 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Topic: [PATCH v6 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Index: AQHXo04llJrmCe8xQUyA5dZSwoZB/Ku29+AAgEeN80CAFncjYIAfW6MA
Date:   Wed, 15 Dec 2021 16:23:20 +0000
Message-ID: <BN9PR11MB55455788985FD73EDE77E7A1F1769@BN9PR11MB5545.namprd11.prod.outlook.com>
References: <20210906183621.21075-1-shruthi.sanil@intel.com>
 <20210906183621.21075-3-shruthi.sanil@intel.com> <87lf3jaubj.ffs@tglx>  
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c2c932f-9ba4-4435-745e-08d9bfe735be
x-ms-traffictypediagnostic: BN9PR11MB5369:EE_
x-microsoft-antispam-prvs: <BN9PR11MB53698A433FC868F46CA95C18F1769@BN9PR11MB5369.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iJ8Bp7dl3hYpjJFX3S2cfrwGuhZZgnXcg5Q65vLNBAWomk/LXNf13NKrW3aLlrPsspvfNWlDYI06E0oLE3b+qftGaPiIMhFOw4U1EUjh5bBMFRr3az1Pi69awKYLmzKrMJF/i9+2j2Hfx+EM81eY2XPx7AJi7VMLRW/JHxN38J4g5SAF3pD9DSEFaDut8RLyHPIoO6iiVCUbsYK6UDuHvkxewmImiEm7/tV2zJ29XBNPSF5Jj2qtgSqjY1xq6ByaYwLtCxKKdPd07RhuahXVJfWNA+O/Wvys1iqAyqZAGqY1lsKCBDFY4TCzRrbDOGAjUcemtWpec41t0klaztVaBcYMpwknAYI0MdeaC0z9RTFaa9HaIwUt+lF0bn6nvbh+eBP/0o9MsO02Ee4x7L7YpSPVwaD8xuKgaOqF+huLwN+ZfbKytQihMZGQbxlxhAa9KOjYqHx2IXI6GMn2yFNicqpumJ68bFGt1/dv7bh5CQyxaOQXL2Pz4tjVyl6mB8Va6JpQ0MNQTT1QcNtmpvlE1Fzmz8dcHarofoCstlqWvjo+Wry+WCJjgwCrteCehCtaA9iM6Re5oiIwz5PKXnml7q06XyzFIx6CeLwkruXz2rrNkty1umWK9al7ldSfCLX/UCvLMYs9nfH+M4q9YxcBL782mKcYueUbCmnMNheRzqlFdoHwsTWp9gMq3TtvyX9ARpaYCNPhhQ5cl7XAzSS3sQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(66476007)(33656002)(66556008)(8676002)(2906002)(53546011)(66946007)(82960400001)(64756008)(4326008)(7696005)(66446008)(38100700002)(83380400001)(9686003)(122000001)(38070700005)(76116006)(86362001)(8936002)(26005)(508600001)(54906003)(316002)(71200400001)(110136005)(186003)(52536014)(55016003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?my+u8gkKBq3jfuAT7n95XQv/RY6ss3urTtMXurlyHgNjvah04nShphfXD7w5?=
 =?us-ascii?Q?o6yJpJ0d4TUR4asnc+s01dYLdV1k1D+mxSZJR5bG3Ced3/m4uSgalr/Z//W3?=
 =?us-ascii?Q?NOgxUltetSDyKceO/qVfoiHOgxSsXKgCPUwmTFos8rdyADH+N4NHrOnACmkT?=
 =?us-ascii?Q?34zqrG0hgDrAS16nUsqUH9QTHOZ9UFw9JjrCr2HHELY8aONaPVZ+VbED045Z?=
 =?us-ascii?Q?LI+AkHNPv2OKXsOS1SkHDWcMWWbR/8snPl+UHcOOAcnJ0pRQmr0qyU1X6qsg?=
 =?us-ascii?Q?+hciPJHF8wENr3io2Sk0REYGbgecB7DxYwYaCvMyes+ClLl9zexr7NAtMch8?=
 =?us-ascii?Q?0bLcq4tdrR64nzuIkhCFTKUVyqcn360AHzcR0S5+IOltzHl2OuNdEQMvQvVM?=
 =?us-ascii?Q?SMV7nxnntN17OXlNcdmAKEG0vhT5Bt8WS0V4AfKkhqOLnDER/ItC0hh8LiZ8?=
 =?us-ascii?Q?VjPxtRVtY0+Ihv+n2WuhAaTu5/A7R+w1+h+qOM7dMswhb0kErZY+Q6FToT/X?=
 =?us-ascii?Q?1JZwG+WXnBYcGOiRjaVC5zhBG3PWGD4Hrb50VFgaURkl2HB13XDIRTXummx8?=
 =?us-ascii?Q?uQknEqlo0PjcVGMshO4dN8v1t+E8ZrndFHErgp2MQdD81gHGD0GTS9cQmuQV?=
 =?us-ascii?Q?/Iose6lzsEfCWUEYWFK2KPMN+PwX7EgKjpzm6upJrO0aTZAURmiIx2uA2Zvm?=
 =?us-ascii?Q?ODLHUcqV2Ovd6wp7CFs3NqdGpbo/lA+8OFpT+iMSawm8FDahg/OfwoiDt6Zr?=
 =?us-ascii?Q?ieyzbq0e576ER5Lw1XKEPJuxwI8n0dFt0FaipqMrmb5fKRcMbgtvu1PgAtK5?=
 =?us-ascii?Q?KMmDyks/SfaZWyqcq0PmHdktjJGVC8lzwH4iMbuGgtvyNIRbQaSerMYFXq6W?=
 =?us-ascii?Q?xMezh5ZdyqLweTfrsoMx/bHhhnr/petq2RI8QY0+JzvjVeFOvU/bzMzA4p9l?=
 =?us-ascii?Q?pkaDSduNCLwCwhMfXc2Elc5WpK5sIQSN3Gc0UtBG2Y91eASO72KfFrzKMPm9?=
 =?us-ascii?Q?lO58tUlotbki6tDKcRJG/xXNjLRofApt9zJdsYiVYYKZ49gwkk5FZYqbsPmj?=
 =?us-ascii?Q?ZbVMZCrL06cf3YnALl8qD/QZ1kWnzrKx+f3VE4lENk1uMbCBuZXyUNqyXH+y?=
 =?us-ascii?Q?MYxwjLej4AqixuW/QYIiJXA8ITiWUThkFAAOxxeHbXI87MIwOP1Y6BA+Rp0f?=
 =?us-ascii?Q?L1NhdooGMKj61q7LAAYjNckK2RvCqY9vbOQYAv32i1vLnHabQSgeiEGA5Dlm?=
 =?us-ascii?Q?vwpWSxXTlm1PWS5HWCF0mfAZ2CLKkM6Ym27bT381MMde3dTOfyFVCJDL86Zt?=
 =?us-ascii?Q?HNrSV4e5rpUyAwvR1JHQvv3Eoa+vLwm25Y9u0XCSdsv1i2XbSkEiJDW1evlR?=
 =?us-ascii?Q?d0h677pzNy3Gp718SYVWCOkKECHc+mfZH8OM1Ud7niqS9s/35JKF2tuvksP/?=
 =?us-ascii?Q?scRaOI9FH5won6HHQjLz69o8tC8sVwyHjERZnFDkkbCTBSYKQDrsDC1jboqE?=
 =?us-ascii?Q?gCQukU+95+OmgyjR+uFCJiUMTho5VbSvFGJTgxm8nhUjyCu9nkEJsnKlXmOx?=
 =?us-ascii?Q?Y3+M0+tGNMEPSG4WuC3YuCKBnVwxM56YrM4X4hGA3E7Q2aEVCdCBx4CICJx1?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2c932f-9ba4-4435-745e-08d9bfe735be
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 16:23:20.7938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57Bfjyi2aQpv3/2Pu2AtqISADfA7a7ylKwbkbcDK+od9iOYs2u/wwWqqEAlw1Z0ccRzeGW2mbOzwRxdDEBpIZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5369
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,
Could you please help with the query addressed below regarding multiple tim=
ers?


> -----Original Message-----
> From: Sanil, Shruthi
> Sent: Thursday, November 25, 2021 10:59 PM
> To: Thomas Gleixner <tglx@linutronix.de>; daniel.lezcano@linaro.org;
> robh+dt@kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Cc: andriy.shevchenko@linux.intel.com; kris.pan@linux.intel.com;
> mgross@linux.intel.com; Thokala, Srikanth <srikanth.thokala@intel.com>;
> Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
> Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> Subject: RE: [PATCH v6 2/2] clocksource: Add Intel Keem Bay timer support
>=20
> Hi Thomas
>=20
> > -----Original Message-----
> > From: Sanil, Shruthi
> > Sent: Thursday, November 11, 2021 4:12 PM
> > To: Thomas Gleixner <tglx@linutronix.de>; daniel.lezcano@linaro.org;
> > robh+dt@kernel.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org
> > Cc: andriy.shevchenko@linux.intel.com; kris.pan@linux.intel.com;
> > mgross@linux.intel.com; Thokala, Srikanth
> > <srikanth.thokala@intel.com>; Raja Subramanian, Lakshmi Bai
> > <lakshmi.bai.raja.subramanian@intel.com>;
> > Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> > Subject: RE: [PATCH v6 2/2] clocksource: Add Intel Keem Bay timer
> > support
> >
> > > -----Original Message-----
> > > From: Thomas Gleixner <tglx@linutronix.de>
> > > Sent: Monday, September 27, 2021 3:11 AM
> > > To: Sanil, Shruthi <shruthi.sanil@intel.com>;
> > > daniel.lezcano@linaro.org;
> > > robh+dt@kernel.org; linux-kernel@vger.kernel.org;
> > > devicetree@vger.kernel.org
> > > Cc: andriy.shevchenko@linux.intel.com; kris.pan@linux.intel.com;
> > > mgross@linux.intel.com; Thokala, Srikanth
> > > <srikanth.thokala@intel.com>; Raja Subramanian, Lakshmi Bai
> > > <lakshmi.bai.raja.subramanian@intel.com>;
> > > Sangannavar, Mallikarjunappa
> > > <mallikarjunappa.sangannavar@intel.com>;
> > > Sanil, Shruthi <shruthi.sanil@intel.com>
> > > Subject: Re: [PATCH v6 2/2] clocksource: Add Intel Keem Bay timer
> > > support
> > >
> > > On Tue, Sep 07 2021 at 00:06, shruthi sanil wrote:
> > > > +
> > > > +/* Provides a unique ID for each timer */ static
> > > > +DEFINE_IDA(keembay_timer_ida);
> > >
> > > > +
> > > > +	timer_id =3D ida_alloc(&keembay_timer_ida, GFP_KERNEL);
> > > > +	if (timer_id < 0) {
> > > > +		ret =3D timer_id;
> > > > +		goto err_keembay_ce_to_free;
> > > > +	}
> > >
> > > May I ask what the purpose of the IDA, which is backed by a full
> > > blown xarray, is here?
> > >
> > > AFAICT all you want is a unique number for the timer name for up to
> > > 8 timers.
> > >
> > > > +	timer_name =3D kasprintf(GFP_KERNEL, "keembay_timer%d",
> > > timer_id);
> > >
> > > So what's wrong about:
> > >
> > > static unsigned int keembay_timer_id;
> > >
> > > 	timer_name =3D kasprintf(GFP_KERNEL, "keembay_timer%d",
> > > keembay_timer_id++);
> > >
> > > Hmm?
> >
> > Yes, we had initially implemented it in the similar way, but in the
> > course of review it got changed to use IDA.
> >
> > >
> > > > +
> > > > +	clockevents_config_and_register(&keembay_ce_to->clkevt,
> > > > +					timer_of_rate(keembay_ce_to),
> > > > +					1,
> > > > +					U32_MAX);
> > >
> > > Aside of that what's the point of registering more than one of those
> > > timers as clock event? The core will only use one and the rest is
> > > just going to use memory for no value.
> >
> > Instead of
> > keembay_ce_to->clkevt.cpumask =3D cpumask_of(0); can I update it as
> > keembay_ce_to->clkevt.cpumask =3D cpu_possible_mask; so that each timer
> > would be associated with different cores?
> >
>=20
> Could you please help me with the above query?
>=20
> Thanks,
> Shruthi
>=20
> > Thanks,
> > Shruthi
> >
> > >
> > > Thanks,
> > >
> > >         tglx
