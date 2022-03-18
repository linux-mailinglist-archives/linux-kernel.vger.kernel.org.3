Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8584DD46E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 06:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiCRFiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 01:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiCRFiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 01:38:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A638820168E;
        Thu, 17 Mar 2022 22:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647581810; x=1679117810;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r4p5K6aUoPXVByvtD3kp63xSuthNnj8Wi+Z/FW0fYvg=;
  b=Id5JeCVL4LBdojf9/VCNfkj02sHamT/q4mv7Q3FeRBlJy25syU60CY5v
   k98/xNBXUxvshMEocE9bpzeCN9s10pNpHPT5YVcXq8Nj9hZKztRDyt+q8
   txDbKcEWQGOZh5zQOy88+SYEsWhGCdVXxU+JA0LH73IwMvifhHow93+NV
   8fEXq/SQMv9jydSPiNUVAGdKLvqWTskb+IRZo12exp6b2CYSjhpbKC4Ap
   OwIZpEzkS/kRVmZoP10sT33KeH6p/JTzHdOjafrU4OlY3mfGFS2Uv63vY
   NYuKWwHQ9OK0frXzWQG+69521mi974vitz9hycj0mlUfQ1wTdlxaPV2aH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="281860200"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="281860200"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 22:36:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="517051469"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2022 22:36:49 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 22:36:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 22:36:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 22:36:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZfyHHXWKrLCUrBljcS2zz0W4w9frJopLjsdxM9E6tOJicJtn2wMw3aGY8FRRqgpB334znC1zztt9jIwq0eWT/bV3+TeVZYZkBUJm0E51HJ+Hwu5bOFM1Q0BmMYA4Y7Vpo8T3xOUvioWoZsjQWvx/wEKR77lhlnT3G0DbdSrG6tvZ/EIRrev5JnLkjBEYiaOnwiu9SFmD/HAFz/fZsv9y2p8KVdnJ7Mqi5l26sg67mLhICHModb1+5auAFq05SDIScc9mPDG208h38DgY+QYOamSORsylmtq6SyqShpMsdcz7LyKPBEy4/DbA1v786mp4yCVhQxODFOXr3CasPGRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNaTq5FsIdFdzTK9y+8JxVgQ1/HJSmkEe0F0AC9VqzE=;
 b=c6KYKRZnlbefIp/0b8/RtwNHrgAkWbLmw2VkF8AhMMO7e1YJBqJK+VEzg/EuwDKzPzWhvWY9ss4UsMaMhTGrahhhthJQhb7+AKLVel0MYkBqveM8FUar2aW8gMlMzuU6bWluC0lh08ISw/fNdpYufDocDpAr9u9IktmLV5H+Kfd8Mq2BWU78r2QCc2u49Sby5v8O31YmzBAXGnXv63tX4J8l/s7REfE3Uj8icha/lcaCwTkav5e6gM+0JeSxAfObPlNSbA2JIM1vR4aHDFk4pRPdfcMhX0EcYXoDTCaazUKdMQ4w1vViA25blfgAbwCI++XsYyvXReTf/UkEmD+GFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5545.namprd11.prod.outlook.com (2603:10b6:408:102::19)
 by MW5PR11MB5859.namprd11.prod.outlook.com (2603:10b6:303:19e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 05:36:46 +0000
Received: from BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::8548:a26:d677:6e0e]) by BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::8548:a26:d677:6e0e%9]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 05:36:45 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Topic: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Index: AQHYJ9KPmrr71unh3EaZNB9EpLdxlqygNAOAgADN5wCAE5UmgIAAw7QAgA6SSIA=
Date:   Fri, 18 Mar 2022 05:36:45 +0000
Message-ID: <BN9PR11MB55453D8B1B97D5EFC096A237F1139@BN9PR11MB5545.namprd11.prod.outlook.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-2-shruthi.sanil@intel.com>
 <YhVuJaf3AJ1c6TpT@robh.at.kernel.org> <YhYa3tlTEcLct2xu@smile.fi.intel.com>
 <CAL_JsqK_k49eKZ+Z+uw29GdY9KFVJL9o5xkzg=1=yF-oEt+JRg@mail.gmail.com>
 <YicsXm9JboW2b+5f@smile.fi.intel.com>
In-Reply-To: <YicsXm9JboW2b+5f@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 160a9b34-2a44-4bb9-6623-08da08a14a83
x-ms-traffictypediagnostic: MW5PR11MB5859:EE_
x-microsoft-antispam-prvs: <MW5PR11MB5859BFB954299B5F216836D6F1139@MW5PR11MB5859.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rQ6unvdoNqKz3bQiILA74WR4EiqZhzA8QaVZzAl2sg2aLUSVcEif93Ia/yW4SgxFHgmJIuGWo9iHmZqGmySUyYuzUj5PmB4cV2xowzNg/iVgy5efrzRM8qAimZGkUQiocIYi+OJ+8EcbbAZEorBdOPioNMWvmuAJW6njpN6UMohS2SBscILjzMmj57rybHF2sVYeakNJPx4/tT4/tuDWRC6Qsba1Sh9ICznnLGjJZongmE0qA4o633SyCwrjjnKbAr5m+m8mMKFwHSF+vf1PBKj6TpHSAwQJBFchHrVNnJ0iZ2KRBjOhOmLOQJQNeIHCb4wL16cnjgW4gdiDJrnTsm8+RVCl/dUnGS7C0OYXNRRK1schicpv0iKL2lOjPH5aIIsg38KydIyFw/b24NRsKsojeBvcY30UvE1NxWYnC1vdMWAl+QmPArQGUS9FbDuzzd2SiC+EqaWV10D1eFQO9u5kwu5waYY2CQrOpD0TryA1bV7DJnPCckKOl3j/RdpT5SSmzEe0Gq0ROvfhz4ko6n4XQRNhZbyGBTwQD21t9iWSpKI+SZSDCaLHcxeyN63zhbXJMVsvdVQvy8phhOhKcMN9GSmwuq8o4M2h4i2/rcQ3VbMg6+Y02xq26EWbhnvtGJmHdcvARXwM702WsIhXfoVW4fRZ5gZkxs8oCFJricUlF745F2zQpAUv5CZ4FAJ14VBi5Rshi6Wxa+t27UJ2vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(26005)(9686003)(53546011)(508600001)(186003)(7696005)(6506007)(71200400001)(54906003)(110136005)(316002)(8676002)(55016003)(66476007)(66446008)(64756008)(4326008)(76116006)(52536014)(66946007)(66556008)(8936002)(5660300002)(2906002)(82960400001)(38100700002)(122000001)(38070700005)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+gbCt6b1Not+0Wwsce/1xyAkoyklMHrNgFlkETRFELmPQfhSBPgA8GKlMfOP?=
 =?us-ascii?Q?ijs5vj4Vc7ad8E31ctCEeXcFrs99k3mO3CVmNY9qCqb3whgAXVR1kDTCqM2w?=
 =?us-ascii?Q?/OUYAtAoE2aQ5LH++ZMB2jXKG3zwpkVAY494XzBLkU/gADA031ieCfpMi+O8?=
 =?us-ascii?Q?mF+mlQYCn7bkdH08z0brUCk9B9Z4DjDeZicAypsEw/XT23KnaZ1Rb7gGs3jI?=
 =?us-ascii?Q?/ul0bCdF1VMTU4wzpa4c4VCU31NW6xvn3btp8m+Uan1ogi6GEihDjg9UMllG?=
 =?us-ascii?Q?jcBBuUcIVDi9mlH5uDtJuXaRuLyZpO7P3X5DseS2rb+Fd5Ncz+tyD6ZKpd46?=
 =?us-ascii?Q?XqTdqdllLz4IbOuJcMvCjorChA7gKBPwH7Z4gy911SD2ZaNMt/ulzYYH8oB0?=
 =?us-ascii?Q?TIGG2IYib3SCYHSwEK0nMbHhPSmFm7CUPkfuK4VFTBEtutcckbO3sWlex2bo?=
 =?us-ascii?Q?SlLW4y99cPg9wVJ8etpA54/8sTZCEUe+0TsVT1TjC7PpDKlvZth0E4uKrIIq?=
 =?us-ascii?Q?6U3z4BbZjg9xMASfHrufnj9ibEk/PMwL5FsEpNZPuY4pYWO9+bkIu1afueDa?=
 =?us-ascii?Q?2hUwDb9rM5JcQBNPCabkk/P0xDyN8NTJJV1yjMxYL6eUhK0k2uOGouL90TfF?=
 =?us-ascii?Q?8pKnw64/6tkVE4DIfWybzLKHso9P464buI8YetNzFCIpn9elPXA7mTt8Y4Lm?=
 =?us-ascii?Q?TWa9/0DpmLnH4G85IdQRLlyjKRCAAIj57DIAcUdoTuhYwp7inXRl1iYjp7rU?=
 =?us-ascii?Q?Q5nT2g+37rb4Ww1sPI1bLDuEM+GTtsYGjR8bvxCyLG8VU2JoZmdCNvoyczpU?=
 =?us-ascii?Q?GHMOUIzcVbNOB5RFXpKNDSMUqKGWnrUJ06k8RW7YXewKmL0ixBpEFr+M3sns?=
 =?us-ascii?Q?ZrCf9tz/VpemThuMz7W1ya1tgjbaSuNrMJQt1t6TYhb7WAaI3t/OGPcmNMO3?=
 =?us-ascii?Q?hX8rEyrjdPNb7UKsrPemtrUs9dO2S7qwfHzR3hvGDj+8R/cFB/NAb5aP5KON?=
 =?us-ascii?Q?P18nFHyPat+7X+MSNLC7EbIYbeCTGgnu+vnMBExnQiemdZA1n5yaJESBVkiI?=
 =?us-ascii?Q?nrwwciqKOZxwmks+gkxx6ojIMcal53tDteR2yYjknSaF1SMaC58hbKPfHkkY?=
 =?us-ascii?Q?186+Eg36YlG8JQq1IerY6KJYpuAyhAEw250tZj4CFkxHr+pd0dJS4y/O/09s?=
 =?us-ascii?Q?1dq4g/VqnhimoI66BbdMPIgqjciWRIbVEdSIcheD9gvVmTOnAmep3M53dQu8?=
 =?us-ascii?Q?yTNPKpcZy49cipNe1HysIEuHAnr8GIocY+g1NrsfIYcHGab1+NYumP2MmGSy?=
 =?us-ascii?Q?RUw/YrnbchlOFZ4KYW/JBebnr/gwdo61g3FPsmHeJCYc2fYlnaVyukIcadeP?=
 =?us-ascii?Q?8+OhnsA2kUsMWZotmsaFXHIEWID3V2JabNT+S1hoCh1YZoEqCiBIAYtAMIUT?=
 =?us-ascii?Q?UP2IuqZcBkveIbx3S6lIiUFHlw80i0Ts?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160a9b34-2a44-4bb9-6623-08da08a14a83
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 05:36:45.7510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ShEPYhmuNn+ast3Awbjci96E4imZQpx8BZh3sGSGZv6+gS/OQ++VtwIL/nXX8SS7zeJmpHQ4YwL30rBOH3+hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5859
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Tuesday, March 8, 2022 3:44 PM
> To: Rob Herring <robh@kernel.org>
> Cc: Sanil, Shruthi <shruthi.sanil@intel.com>; Daniel Lezcano
> <daniel.lezcano@linaro.org>; Thomas Gleixner <tglx@linutronix.de>; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; Mark Gross
> <mgross@linux.intel.com>; Thokala, Srikanth <srikanth.thokala@intel.com>;
> Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
> Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> Subject: Re: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel Ke=
em
> Bay SoC Timer
>=20
> On Mon, Mar 07, 2022 at 04:33:23PM -0600, Rob Herring wrote:
> > On Wed, Feb 23, 2022 at 5:31 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Tue, Feb 22, 2022 at 05:13:41PM -0600, Rob Herring wrote:
> > > > On Tue, Feb 22, 2022 at 03:26:53PM +0530, shruthi.sanil@intel.com
> wrote:
> > > > > From: Shruthi Sanil <shruthi.sanil@intel.com>
> > > > >
> > > > > Add Device Tree bindings for the Timer IP, which can be used as
> > > > > clocksource and clockevent device in the Intel Keem Bay SoC.
> > >
> > > ...
> > >
> > > > > +    soc {
> > > > > +        #address-cells =3D <0x2>;
> > > > > +        #size-cells =3D <0x2>;
> > > > > +
> > > > > +        gpt@20331000 {
> > > > > +            compatible =3D "intel,keembay-gpt-creg",
> > > > > + "simple-mfd";
> > > >
> > > > It looks like you are splitting things based on Linux
> > > > implementation details. Does this h/w block have different
> > > > combinations of timers and counters? If not, then you don't need
> > > > the child nodes at all. There's plenty of h/w blocks that get used =
as both
> a clocksource and clockevent.
> > > >
> > > > Maybe I already raised this, but assume I don't remember and this
> > > > patch needs to address any questions I already asked.
> > >
> > > I dunno if I mentioned that hardware seems to have 5 or so devices
> > > behind the block, so ideally it should be one device node that
> > > represents the global register spaces and several children nodes.
> >
> > Is it 5 devices or 9 devices?
>=20
> 5 devices, one of which is a timer block out of 8 timers.
> You may count them as 12 altogether.
>=20
> > > However, I am not familiar with the established practices in DT
> > > world, but above seems to me the right thing to do since it
> > > describes the hardware as is (without any linuxisms).
> >
> > The Linuxism in these cases defining 1 node per driver because that's
> > what is convenient for automatic probing. That appears to be exactly
> > the case here. The red flag is nodes with a compatible and nothing
> > else. The next question is whether the sub-devices are blocks that
> > will be assembled in varying combinations and quantities. If not, then
> > not much point subdividing the h/w blocks.
>=20
> AFAIU the hardware architecture the amount of timers is dependent on the
> IP synthesis configuration. On this platform it's 8, but it may be
> 1 or 2, for example.

Yes, the number of timers can vary between platforms.
For eg., Intel Keem Bay SoC has 8 timers where as in Intel Thunder Bay SoC =
has 6 timers.

>=20
> > There's also many cases of having multiple 'identical' timers and
> > wanting to encode which timer gets assigned to clocksource vs.
> > clockevent. But those 'identical' timers aren't if you care about
> > which timer gets assigned where. I *think* that's not the case here
> > unless you are trying to pick the timer for the clockevent by not
> > defining the other timers.
> >
> > Without having a complete picture of what's in 'gpt-creg', I can't
> > give better advice.
>=20
> I guess they need to share TRM, if possible, to show what this block is.
>=20

I would like to explain briefly about the Timer IP in the Keem Bay Soc.
The Timers block contains 8 general purpose timers, a free running counter.=
 Each general purpose timer can generate an individual interrupt to the int=
errupt controller.
The timer block consists of secure and non-secure timers. Hence there are s=
ecure and non-secure registers in separate address banks.
The secure register bank consists of the common control register where the =
timers and counters need to be enabled.
From the driver we try to check if these bits are enabled to continue with =
the initialization of the driver.
Hence we need to pass the base address of both the address banks to the dri=
ver from the DTB.
The control register is common for both timer and counter. Hence we went fo=
r parent child module in DTB. 'gpt-creg' represents this control register.

> --
> With Best Regards,
> Andy Shevchenko
>=20

