Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E607485B2A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244672AbiAEVzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:55:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:34178 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244693AbiAEVzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641419720; x=1672955720;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H2bG+GBK3wnONJQZTTol3xg3NQf/KDOT2qM85nBtrWU=;
  b=O8QaBegmyseCVmfFffL7n1NkxvQGowVIfGoiRAzsTFdk4InJl2mfacLo
   SXVvEBQbevQHLD63W9FcgGeKvCCTyLNPhs1maktw2Sw2xbEao5ahtzZrT
   z5sNjsRnA/Ft9HY8ftShjFh8SS3OFIbpb0fgZgF2IQLJzdwQxvtDCxwKW
   s0Zi4/e6251DwmGTCFVf+ET1v0flxkMPEk+wDpRaDEu2FVGKHdG/7bxA7
   SwxeqN4kE614MGKWvNCDV/GqQR0IMBvwwbRsCqkx2BKCt0hd2kTft6guM
   buCh3bmiu48G6fnUjwxe6T558uZNopNmQ9qX3rY1VwkhbduTUQhWNeABL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="240088196"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="240088196"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 13:55:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="618110417"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jan 2022 13:55:19 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 13:55:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 5 Jan 2022 13:55:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 5 Jan 2022 13:55:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPddmNrN3sGdRq5rtGyS/7PFT4Z3MSMVg7NriTnj0yFVeoAxecXZJaRzvTmjmIfW/Mx/tpj/GrdE2BhOI0bGprFGALI1usMGW6FmE2yZwCva9QO113EchTbRintyc8UueAr0khQbXpYji9jIprQ5g1O4Ri2l+TpxITdZmngxaYwoxbMDqkcZlEqXr6Gj89a70+01QfADOqlDSxDF759X2o1pDwG8jULocw4DMQtSN5UsyIIJd0BNzrz/fKcsol8c8Ekc4ghUqv2mxLlE4u3/9ZwSbdVuA6AJB28nfGc5yEgWJLZRSnsGctjdiR31gsLaHIW8E/doOsXFfFdxxOMO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2bG+GBK3wnONJQZTTol3xg3NQf/KDOT2qM85nBtrWU=;
 b=P6x/dwS9jYriMqWdX2a3kIMGSFf/zsHvCy6dF5UpMW3H24CfcsCYrzmis8B/hFegAwjKaHd0r0SteKCD9YUyrPSInGOKYieHNYXdU1eqFqo1KsANwmSakSRcNrwt3ptwWZ5FJdy099Z87s3SO7EfKLGXnqnP+ycZvYSBqR3/+6gVeFLskuhKk93IFv8XVcfdUQZxUu+wZm3B7zCAxxc4IRFndg3QsOhSEjqehbcx3dnDeMPyVWVnLE2m/kCJqPFq2MBKxYhY1TdE3xNq8+z5k1nORm6iifcytFq9CaELidyIb+wFFgWPJW0a5t0G6E2iSLZMY62O6XB70sG6XNBAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 21:55:17 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7%9]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 21:55:17 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Gairuboyina, Charishma1" <charishma1.gairuboyina@intel.com>,
        "Dwarakanath, Kumar N" <kumar.n.dwarakanath@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v4 00/13] x86: Support Key Locker
Thread-Topic: [PATCH v4 00/13] x86: Support Key Locker
Thread-Index: AQHX8IXgPtLMRzOkzUOX4xWFKhqGg6w0Uf6AgCDKzgA=
Date:   Wed, 5 Jan 2022 21:55:17 +0000
Message-ID: <4101B942-6327-49A9-BE8B-9E51F0427F50@intel.com>
References: <20211214005212.20588-1-chang.seok.bae@intel.com>
 <YbqRseO+TtuGQk5x@sol.localdomain>
In-Reply-To: <YbqRseO+TtuGQk5x@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c960268-86f1-4ae0-ab1d-08d9d0960fd8
x-ms-traffictypediagnostic: PH0PR11MB5808:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <PH0PR11MB58083747BFC77D0C77711A9AD84B9@PH0PR11MB5808.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zMlOl7SHv60/Am7lPgx3B4fcgN1k7+WIFZo1+EfSvBy6A4t00oPGlwnAyS1wWbbP96ueK+1YbVASDCeQUwozwMiS0MRDCxiXhV61ejYcIAjP+n07JkYgM6Xma73nYcGDUs1JQg5k3ngZ3MX7MLYxJw3AdSuaC6Gwh9zaZVuc/PGOoey6kx2ge9xFgLrY4nFci8QjvAYE1ZdaTW3TfC0JHFR5jbAMCBSqqjmoHZZCQI7KAu51L01SOQcN5DwUmVtyR2jORy+MgdtXVjqffWP/8hW57IDGr83TKFuCRd0CjGb5zdUGxJZF/+1/N3p34YamEbcgmui9wwOt+yxi04rQ7y3AvrCSO6yLUgYKWasguLsklb67EcSugQEY2dmJ2ehDfa5G8kohZ+8QgstFfS03BG5WnfQn2xtX8okOwxCDxKtd0u5rB2wwx5YKq4Cg8BBY0NUumKACeoBfcFDxkYwImWW2DboNGM7SJZu98sk1RazGXC0UGC77jP0qiiCk2QEwYSlcCKkllX3wOkO664Rrvo61OTZksIy9sI6oCLBjHMpB2cNpfNr29g+vnPfhQNm7S84F1MPy8O0yErwA3E9YnqWS49uY5pS41l3U55Hvi+UUte/UCliLni0BnBiEPpp476Lr2+3Kk6b7FgP3Wp3007VNsAaXKlEP8zX5vfHmFLWD1WI5QxQUJW94F4M0hEIcBGi0VaS3teBPykfYSFrsk5lTsy6ET/oKs+12ignujmecsJQaYGFuAaLWbp8WNmaHOUHsiASVjGEEowpXX8pS/Tya0RwcsDUexF4HvkMomUQidQWXtxPNyjNT6WtKGUsO4ZHyV7xuY4IG9686A/+OyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(110136005)(6512007)(8676002)(122000001)(26005)(38070700005)(83380400001)(186003)(8936002)(5660300002)(71200400001)(76116006)(54906003)(6506007)(66946007)(66446008)(66476007)(7416002)(33656002)(36756003)(82960400001)(316002)(2616005)(64756008)(4326008)(966005)(86362001)(508600001)(38100700002)(66556008)(2906002)(53546011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3VFazRBRTg3ZUQ3cW9HNUp6TFJPTmdpZmM5bDQ5RFU3c05vMkd5Y1VITUxx?=
 =?utf-8?B?MmRXTnRha2FoeStBK2dKT3oyeTU4NVdlRmE0dkplcXdtTlNnUG5CL2h2MkJp?=
 =?utf-8?B?RmVUODJjZlFaejcvZkZXOHl4bXZKK1FvaTZmZVNtL2lya25BVHRKU1QzMmc2?=
 =?utf-8?B?b0lHZVFPQ0Z6OEwxdVgxSEJOdlFmOVRjZ2VZdUNNazMrSURVR1BuQXlUM1RQ?=
 =?utf-8?B?aDZ1T2lIa2NaS2N6Sk5NdnFDRDRsVWJnWEJQQWQ3WmRlRzE5bGZDZGMzVWFK?=
 =?utf-8?B?Q2VXcUV1a3pEeThFclN4ZC8vbDI4Y3BpdnBXS1FGcG1GdWdhQjRsTk5acHNr?=
 =?utf-8?B?dzR0czVVNmtXRGpDMGRqUXFKdHBUTjllTm1DWXlOY25xMjgzYzBsRXhEeUZD?=
 =?utf-8?B?cFh1UzhPTGhxcUNhMDh5d3grdFliMHNVbG13YlF0c2FaWDhPVzRnNUNVbHE2?=
 =?utf-8?B?YnhMZnBCUzY3T3BZaXNFeXo1cnNZQmJHQlcwZ3FuRG5BRGpmWGIvY3ZKVTdR?=
 =?utf-8?B?Z1RQNERJZzc2amZ2bmdJRWw1VUlQYWdSQmdNem1YL1c0YVUrSkR0cW9pejBG?=
 =?utf-8?B?VmxIblZqMEkwVmI2TlpNR1VTcFd0OVNSK2Y3T1hSK3E0alpqR1c1MHdycE5W?=
 =?utf-8?B?dzIrYm5xS1prWWlvQzFiby9LK01qbHM2Nlhjb1hrcmJJUVpJd2ZvcVA4cGQr?=
 =?utf-8?B?K1o3SEhqWEpzTkIzUFJUYVhySWF4TzFHVmpOck5uUm8rK2hXcGdTdUJOL2Yx?=
 =?utf-8?B?eG92elhVRXdTaGkvazJDRVVFS3B6eWsvVFBXdWFSNWpQdlBaa09Ja3BtbjhY?=
 =?utf-8?B?d1dGWG9vV3ZVVWRrNHhqTThUakROamtRcVRhMnNVMTBYdVpJaFp1UXBOWnpM?=
 =?utf-8?B?UnFLbGYwRVZnK2UwUEdOQndRd0I0bno4TnJFWUhWN2pVcFVwS2NMUzJ1UmNC?=
 =?utf-8?B?Zk56b1ZGaUtvdTh0U21jOFppMmVGY0Q3T1pXczIxVG9ZazdSYWprcVg1VXdn?=
 =?utf-8?B?amt0TTQ3QkxFSlNYUEFKNXFEMEpFVTd6WWU1a2dGeldCODZKUmZMUkVjWEwr?=
 =?utf-8?B?ZlZ5d2dWOTVlNFZQdW1hOG1ON2JKaXR3SEY4Sy9lc0pXeVRZNWk2Y2gwelZy?=
 =?utf-8?B?SjF2ci9oemlrbEhIRU84cWJXenBJV0FQZkQvaElSVkYwZ0FLYWlBOVVOc2J4?=
 =?utf-8?B?amJIUzhkMHI0bTE0aC9YM2tCS0o2ZWIyL3ZONjdLZlh2dDVrTVRTOGdBWFhX?=
 =?utf-8?B?V1NRR01oR1kycG9KV0F2aFQ4Wk8zc1NQUVBBLzI0NUdsd0VCL1QwQkhyalRX?=
 =?utf-8?B?MmJ2ZzZtMFV1UVErS0hFUFBVVmhjVE1LN2hmOEpuM3ZicGRhMy9jcXlJQkg4?=
 =?utf-8?B?WGw3djcvN0pKYXdPdW9obGU4TE5wc0JuMm1FWno5RjJVYkhDVGl0YzNhZjRx?=
 =?utf-8?B?VlZUV0puUU5lSFZIRzhpNjBlcVl5MjE1eDRYVE9ncGtURkVEVnRKQW81TlR1?=
 =?utf-8?B?L0xDSGlzVkFzNFl4QzZwOEZJcFV5VlpzelVURlhSYnZKNi8vejIrSEJMVGpC?=
 =?utf-8?B?dy9vZ3VlVGJtZ1V2ZnhzU2VzR2VVRXBWakVYZnNwVG5rdzBmQ25IV3JyYjBF?=
 =?utf-8?B?VGc4UVJHZ0h5aFhlWDlNNXVKS1lVREZDcDB1TlF1cTlja2oyVHFTVFdad1Jk?=
 =?utf-8?B?c3l0c2ZuTFljbHF5TFZtb0I1QytGdm5vYTk4d0dxU1p1QmlZUlZNUnlpTVh6?=
 =?utf-8?B?a3VsOEZGUWtUYklQeXkxb05hZE5pRXdnYXVCRW5HczM3Wk8vUzl1T3d4TlIr?=
 =?utf-8?B?R3FrWTY4VGY3QUZDMHZnT2h5aC9qTHFXL0ZCamx5cXIrYysySjIvSGZiVnhs?=
 =?utf-8?B?dGllZGQrbytBV2xNZEdrYUEwT1Y0MXpaeDhVMCtKUDNhNXRmY0NQcmwyWjBk?=
 =?utf-8?B?T0o1WWlFb1oyTloyNEZQVTQ4Z1cyWXdWRk9vdWluUGhqdnpZL1YyZXd4MnU4?=
 =?utf-8?B?NGdEMXZMbVd6K3ZReUlJcHF5eC9mZ2tvYlRtTkhPSzdjQVpqUE9rY0ZubDBn?=
 =?utf-8?B?OVFmZjJ4MEYybW94RW8ySjJoem5kcWdDTXd6M2ZLWG5VMzBiTGFtc2tBdkdB?=
 =?utf-8?B?cnB3TWJyZldySjlTK1pNa0RLb01oMDRzNWVxRTBHVTFLWmZtOE90TDhTZ2lL?=
 =?utf-8?B?cGZxUHNSMWlHaHE5amxWYmMrbEl5ZHdBa1BzUEF0VFd6d29oRG1uOExhc21a?=
 =?utf-8?Q?x1RZhb4OViKwRxWSk1rAXhzUrINPsFdT5vvW6S/XXg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <345CA196D9EA76419281CD0D66F5200C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c960268-86f1-4ae0-ab1d-08d9d0960fd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 21:55:17.8071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pkjJkT5hoD4iJOn1gFaYE012dq0Rf3tKbOpZv/on8ZRPKlY0a7jQXeoEja69UWGQmt3LD5672nCsV1tyA+9zeehSTGe9UPcnxNUrD5w0xnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRGVjIDE1LCAyMDIxLCBhdCAxNzowOSwgRXJpYyBCaWdnZXJzIDxlYmlnZ2Vyc0BrZXJuZWwu
b3JnPiB3cm90ZToNCj4gT24gTW9uLCBEZWMgMTMsIDIwMjEgYXQgMDQ6NTE6NTlQTSAtMDgwMCwg
Q2hhbmcgUy4gQmFlIHdyb3RlOg0KPj4gPT0gRGlzayBFbmNyeXB0aW9uIFVzZSBDYXNlID09DQo8
c25pcD4NCj4+ICAgJCBjcnlwdHNldHVwIGx1a3NGb3JtYXQgLS1jaXBoZXI9ImNhcGk6eHRzLWFl
cy1hZXNrbC1wbGFpbiIgPGRldmljZT4NCj4gDQo+IHBsYWluNjQgaXMgc3VwcG9zZWQgdG8gYmUg
dXNlZCB0aGVzZSBkYXlzLCBub3QgcGxhaW4uDQoNCkkgc2VlLg0KDQo+PiA9PSBOb24gVXNlIENh
c2VzID09DQo+PiANCj4+IEJhcmUgbWV0YWwgZGlzayBlbmNyeXB0aW9uIGlzIHRoZSBvbmx5IHVz
ZSBjYXNlIGludGVuZGVkIGJ5IHRoZXNlIHBhdGNoZXMuDQo+IA0KPiBTaW5jZSBkbS1jcnlwdCBp
cyB0aGUgdXNlIGNhc2UgZm9yIHRoZXNlIHBhdGNoZXMsIHlvdSBwcm9iYWJseSBzaG91bGQgQ0Mg
dGhpcw0KPiBwYXRjaHNldCB0byBkbS1kZXZlbEByZWRoYXQuY29tIHNvIHRoYXQgdGhlIGRtLWNy
eXB0IGRldmVsb3BlcnMgYXJlIGF3YXJlIG9mIGl0Lg0KDQpPaCwgSSBzaG91bGQgaGF2ZSBpbmNs
dWRlZCB0aGVtLiBJIHdhcyBub3QgYXdhcmUgb2YgdGhpcyBtYWlsaW5nIGFkZHJlc3MuDQoNCkhp
IERNLWNyeXB0IGZvbGtzLA0KDQpIZXJlIGlzIHRoZSBwYXRjaCBzZXJpZXM6DQogICAgaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIxMTIxNDAwNTIxMi4yMDU4OC0xLWNoYW5nLnNlb2su
YmFlQGludGVsLmNvbS90Lw0KDQpJIHdvdWxkIGFwcHJlY2lhdGUgaWYgeW91IGdpdmUgYW55IGZl
ZWRiYWNrIG9uIHRoaXMgZmVhdHVyZeKAmXMgdXNlIGNhc2Ugd2l0aCB5b3Vycy4NCg0KPj4gKy0t
LS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0rDQo+PiB8IENpcGhlciAg
ICB8ICAgRW5jcnlwdGlvbiAgfCBEZWNyeXB0aW9uICAgIHwNCj4+IHwgKEFFUy1LTCkgIHwgICAg
KE1pQi9zKSAgICB8IChNaUIvcykgICAgICAgfA0KPj4gKy0tLS0tLS0tLS0tKy0tLS0tLS0tLS0t
LS0tLSstLS0tLS0tLS0tLS0tLS0rDQo+PiB8IEFFUy1DQkMgICB8ICAgICA1MDUuMyAgICAgfCAg
IDIwOTcuOCAgICAgIHwNCj4+IHwgQUVTLVhUUyAgIHwgICAgIDExMzAgICAgICB8ICAgNjk2LjQg
ICAgICAgfA0KPj4gKy0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0r
DQo+IA0KPiBXaHkgaXMgQUVTLVhUUyBkZWNyeXB0aW9uIHNvIG11Y2ggc2xvd2VyIHRoYW4gQUVT
LVhUUyBlbmNyeXB0aW9uPyAgVGhleSBzaG91bGQNCj4gYmUgYWJvdXQgdGhlIHNhbWUuDQoNCkFu
YWx5emluZyBhbmQgdW5kZXJzdGFuZGluZyB0aGlzIHdpdGggc3BlY2lmaWMgaGFyZHdhcmUgaW1w
bGVtZW50YXRpb24gdGFrZXMNCnRpbWUgZm9yIHVzLiBXaWxsIGNvbWUgYmFjayBhbmQgdXBkYXRl
IHlvdSB3aGVuIHdlIGhhdmUgYW55dGhpbmcgdG8gc2hhcmUgaGVyZS4NCg0KPiBBbHNvLCBpcyB0
aGUgQUVTLUNCQyBzdXBwb3J0IHJlYWxseSB1c2VmdWwsIGdpdmVuIHRoYXQgZm9yIGRpc2sgZW5j
cnlwdGlvbiwNCj4gQUVTLVhUUyBpcyByZWNvbW1lbmRlZCBvdmVyIEFFUy1DQkMgdGhlc2UgZGF5
cz8NCg0KWWVzLCB3ZSB1bmRlcnN0YW5kIHRoYXQgQUVTLVhUUyBpcyB0aGUgcHJpbWFyeSBvcHRp
b24gZm9yIGRpc2sgZW5jcnlwdGlvbi4NCg0KQnV0IGl0IHNlZW1zIHRoYXQgQUVTLUNCQyBoYWQg
YmVlbiB1c2VkIGZvciBkaXNrIGVuY3J5cHRpb24sIFsxXToNCg0KICAgIENvbXBhcmluZyBYVFMg
dG8gQ0JDIGZvciBoYXJkIGRpc2sgZW5jcnlwdGlvbg0KICAgICAgICBJZiBhIHN0b3JhZ2UgZGV2
aWNlIHZlbmRvciBpcyBzZWVraW5nIEZJUFMgMTQwLTIgY2VydGlmaWNhdGlvbiB0b2RheSwNCiAg
ICAgICAgdGhleSB3aWxsIHR5cGljYWxseSB1c2UgQ0JDIGVuY3J5cHRpb24sIG9yIGV2ZW4gRUNC
LiBDQkMgaXMgYSBnb29kDQogICAgICAgIG1vZGUsIC4uLg0KDQpBcyBsb25nIGFzIGl0IGlzIGZh
Y3R1YWwgdGhhdCB0aGUgbW9kZSB3YXMgb25jZSBwb3B1bGFyLCBpdCBjYW4gaGVscCBzb21lYm9k
eQ0Kd2hvIHdhbnRzIHRvIHVzZSBLZXkgTG9ja2VyIGZvciBhbiBvbGQgZGlzayBpbWFnZSBJIHRo
aW5rLg0KDQpUaGFua3MsDQpDaGFuZw0KDQpbMV0gaHR0cHM6Ly9jc3JjLm5pc3QuZ292L0NTUkMv
bWVkaWEvUHJvamVjdHMvQmxvY2stQ2lwaGVyLVRlY2huaXF1ZXMvZG9jdW1lbnRzL0JDTS9Db21t
ZW50cy9YVFMvWFRTX2NvbW1lbnRzLUJhbGwucGRmDQoNCg0K
