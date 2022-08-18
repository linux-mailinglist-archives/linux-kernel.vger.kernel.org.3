Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F347597B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242827AbiHRCnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiHRCnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:43:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E179F9F74D;
        Wed, 17 Aug 2022 19:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660790611; x=1692326611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=apK/n0MKDiB+AUH4XvdkGqNjh3Uo0U5rQ6NzjbeKLEc=;
  b=SKzL12MpPIoDgXkB4idtNzNIddrZcjM9+r76fGFhPxFdaoASG70BHWBo
   DCz46Apy2kpHdqldDzS3zbUKc6uUmDadymvtTUmZMrUbxjqkcktNmVg2/
   dbIpMbZc4cbV8xD7zJturuNBUQn8YzG1atO3neL2AJHCIuw0vFWNjr0Rn
   qgBWHiy6k6c1KYPYImPekdZtS8yvGIDeVAWkCgaJ7M7EASJ4szvrRyVKv
   Tld93Dn2kjNamwnNiKLQGLkr/gIP1OtqzB6PkCcUPPYK9bo3yu0vEBKsI
   PiQ0zQh5RlAGf0HtwJBrMRjgi8w18skWUeadoiCJahgzeaW3+eZRwjgPJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="293926155"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="293926155"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 19:43:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="610849694"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 17 Aug 2022 19:43:31 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 19:43:30 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 19:43:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 19:43:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 19:43:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFfHIg2jzKm2Yttxp1m2x48gHuPrsKJnzSRRtzNBTtwDrNpjEyAliN0lGvUincYijI5pbET6xfmH0Mri9NQEAtGLbNJe4/1aea57NNjrsiPGWDV7BywTDrE5/YSvaXRQz0EDvVIh/V8w3XGP4IjF7d9PLAXHb6YXUDFk5rQb6R3ok7isbXXrncKqv7lv1EesCWwZ3hi++0RlYizj9gKs83HoB+pG7TiX0ziYbfksJ7S6R9/pIhmzJfloSQDbiR6Pb6DCbZ8MT2BFpd47ED6769FhGZ/Yrs+hm2x8b0GJbYGYw2gC5eTeUw6TGCV5rAnQivgzxBUALDWs8aJ0iecASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apK/n0MKDiB+AUH4XvdkGqNjh3Uo0U5rQ6NzjbeKLEc=;
 b=TRBr3FIXxe0w1zEM6tnVSmgmh5gayLcF/wvrpy9DX+MEp0AHXF0mfgPjbAEqHsY52wUMDP9A1bmjFUe/LZoiO7Xdpt97seb939XKr7lg7zU9gA/vZjqmBsZeNdNq/610jn8xZ9ntFPuMWGGQvhFXb16Mv+JTybyoDKjzyENxCLC+HV7fdJj17pLuf331LJTdqgL3CW4Nd0SN/wHsTA3sYeqm7yETh+UwN2sjwO8TTcX0y4HyO7jQHswWj/1jB6hpuiXlGP1yITEFnphs1EDvY4OngD7BWea1yYnP3cz7Rk4EqqOzT2Hv1GBjU5A+nhRuokWtLjo6xUUIxOQ2MX45Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY8PR11MB7035.namprd11.prod.outlook.com (2603:10b6:930:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 18 Aug
 2022 02:43:27 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::1d3c:4dc0:6155:2aee]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::1d3c:4dc0:6155:2aee%4]) with mapi id 15.20.5525.010; Thu, 18 Aug 2022
 02:43:26 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "jarkko@kernel.org" <jarkko@kernel.org>
CC:     "Lutomirski, Andy" <luto@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "dave@sr71.net" <dave@sr71.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
Thread-Topic: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
Thread-Index: AQHYnGzh1nwOjOji802J3mkwYJ5zAa2V2ruAgAZYAICAC9k2AIAA95CAgAAOJ+CACw4RgA==
Date:   Thu, 18 Aug 2022 02:43:26 +0000
Message-ID: <997120b6df7d88512dff60cf8e4e05d512c7b89b.camel@intel.com>
References: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
         <op.1p2k13ibwjvjmi@hhuan26-mobl1.mshome.net>
         <35d7254cafde24b722b167c6a3566592d903acd2.camel@intel.com>
         <f16af3f7887d26cde9073d443c1b796c945bc042.camel@intel.com>
         <YvRVZQKklqnbf9oQ@kernel.org>
         <BL1PR11MB59782DF6E7F3CD950FCA4319F7649@BL1PR11MB5978.namprd11.prod.outlook.com>
In-Reply-To: <BL1PR11MB59782DF6E7F3CD950FCA4319F7649@BL1PR11MB5978.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73eede9a-5054-48fe-c1f4-08da80c36d69
x-ms-traffictypediagnostic: CY8PR11MB7035:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SY5xun9WfRBJdzE9tRn+0AVcGy9gU6N/mGpEBT+sggogDBH1sVXYsjMuCL214SagPVVAildtbNj8/8qUQ62QaDC1/fK6KyQWWubmr1DW9rW6fE70hZPy1GUpBG0Hq2Xa5grtKNmDZ2rjiTwry/XNUiFhcXzNU1HnT4kKDSdDjL/etqhOqxjTnK+dod5yttI5CQMeY7ONVGTZ9RN5ooH6DrYLPYIXuG7j2NiIZC715TSWwmHK1nW8tmLjYc+l87XOrJJshQMV/fRHpWpOodGaWuvaQqBdzZAFfuQu86D4xuSrzn/y1JZIlpNdlI27zsfwp7S+MFIl8QwBlzyH0zGfZD263F/0Wk0klmfEMgtq0y9XqOq9sOMcEpKwPM5hAAu9W3QkDvZ2mXXeJAaiZd6dc4V4pXVNwpO9NqUXDtOA08lDKCf2A+eanbzhJCEgCpyXnY7HcKsfSpTkiZqakUwmz+H/d/ebMCspo+lTsNbYunH1TFml6zSFnGecjcmAZ4oxNzY/4i+YuIXfvPPsUmm1z/1qYBvbh64f95kfu1tdpAiwAmdEI/RI9xGk2Kaxll38cH/10Jh3wH1qP82sSgnXmjrteHfxLT5884T/irOvmiZEPHjHfzEWRWj+wwQGOX9OqasYe0w5LtV2TecbVsc12GRfF6g/QHv3xu+g+lMCa6luv+OVMgN7SEpz6Kj71vM78pRuctlnWKJ4LmdYY57AGQD5XSehrylEjCEcBqToLdITZPORgrxFbmLVeYs7WYLIZ19WgkXtCemcFp0+Sd23Wh2W7Rj7jU8hWz/voAV4YHSt4yQd+wFO6Fxxum3DBKrK4OmYqt+a/Bq0whayy4c0jA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(136003)(396003)(366004)(6506007)(186003)(478600001)(86362001)(36756003)(38070700005)(41300700001)(2616005)(26005)(6512007)(6486002)(966005)(83380400001)(71200400001)(15650500001)(91956017)(66446008)(6916009)(5660300002)(54906003)(66556008)(66476007)(316002)(4326008)(64756008)(76116006)(2906002)(8676002)(66946007)(38100700002)(122000001)(7416002)(8936002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ymw3L0s1NGhMN2MwUitEdGpZRVlRTUdnV0djOEprK0gyOWZGMWlPVi84MXFi?=
 =?utf-8?B?cHBNU0VFaXZDWnBydUsrZGFUWDBHbmNjekphRFp2YnA1VEVkbm9HTHVUcGtr?=
 =?utf-8?B?dkljR0Zlc1ZoemdFWDM3VGNub0kzK0k2NVdhTlUwRHBKb3JBS3AranBCREFQ?=
 =?utf-8?B?SFQ0WUdObEhBU0FMd0U2b2tSclZkZ25lTjZCSUE2TXZvRm1Ya0ZZVndUbnVB?=
 =?utf-8?B?SmNmYW4yQmNBcGZZekpERFlsRTE5Q0ZmVjVENzVnSm9mUVE0dEFTVmowd3g5?=
 =?utf-8?B?bENGdjZrK0dTQXVvSktoK0ZwMnpvQzhDWGcwQ3U0cXR5aVJXNWdTNkdmOXZP?=
 =?utf-8?B?MlY2eTNNR0IzTGVJVnhUdkJudjlYUmpNMGRsU0JPOERZUmVxaVIrbVZWc1pB?=
 =?utf-8?B?alhlcEh5d0F4eUlUbVYwRTc5RkZQUHM3ajdxc0RjK3NLMWZhUFYrcDlHeE04?=
 =?utf-8?B?Z09VcFJncVBLdXpRNmtRU2dUV3JOTlRzQ2V1VzI1OURzYXNtRHBOdHlvSW5w?=
 =?utf-8?B?QVR0aW1ZTUs0aDhkZkpwTDh2cjI1cHNTaTdDUEsrZkN5TmVockwzWm9ua1pS?=
 =?utf-8?B?ZGZjTGNLWTAzb2hDY3JBenZIdzNWNXYzMXdXL1ZiSzE4bk1wYjc3R2V1LzhR?=
 =?utf-8?B?eEVHdnRHWXRHUEtPaUpISElDQ0oxa3RtWkRkejRwYjBDUGdGbWxKMTFUeStu?=
 =?utf-8?B?MmtjRzczQVBlMGlET0VHZWxBQVU4WmlFYk5PT05IRi9NN255WHk0aGlxUGZ3?=
 =?utf-8?B?MXN6WnBYeWJ0Vk1GVG93OGpBOHFGTFdzU2VRalZtQ1BRNlJTMG83aU5hK3Js?=
 =?utf-8?B?bFlTeUdjN1R0ZE9OY0xBNVl5ZUlnQkQzNXV0Y2k0NTNYRWhVMkI0b3hXTUlz?=
 =?utf-8?B?am00VGV5MjNMVjBUZkQ1TDR1eklGZ2Mzb0pRdWV2amtOVjlIeW9BU1lvZmUx?=
 =?utf-8?B?ZG9JOUhHbkNJU0F5MmhUU0k1MnJ1bXlkZlFSWnp6RnJnMWxkdmNiRG1zOEFx?=
 =?utf-8?B?MS9DN1E3M3I1Rk5kbG9weHh5OEJDcG13VjlXcUtibkZzN09TWC9BRjM5M1R5?=
 =?utf-8?B?ZDM3aVB1dUd6V1IrNEpRRHNPRVJROEl1TVBROUtRb09aS1QwWDl3bTBYVUtJ?=
 =?utf-8?B?NHRvNWxTb3FLdlhEODFBUTNiOE5LNElPcEhVQjJDcWhOUmZNZnRHdFV5SUhX?=
 =?utf-8?B?b0dmQnAyQTc3LzdYUnBBa3g1bklsM204TW5rL2U0NEUxaUZHTW5nY1FTSCt3?=
 =?utf-8?B?QlIxZkNBQVcxUFJIR21EZjA2cStsL3R1cGJGaUxLazE1Qlc4dEZGOVpLMWMr?=
 =?utf-8?B?cVdrRlBHb0taUlVvUTRIdk91eWlQOTdCc3FLOVJHaHFQZ3haSDhxbjE5WUY0?=
 =?utf-8?B?ZVFVSG5haGY0ZUx2YnFKcHFCSjNZQ0RrZ0taRWRqK21URHJRTVdLNjU5cUoz?=
 =?utf-8?B?OFFhT3h1MitLYjZnc0ZjcU9ja3pZRmdqVWRYQWY1SlZvQmtOaHBVcU8rNnVi?=
 =?utf-8?B?U0dGSHN0QmR1VDNxRXUwN0JQNkRybGIyUjIzeDZldTY0S2VHR2FHdjRiV3Rt?=
 =?utf-8?B?VFVYa2hIR0U5aVF2ajdrNkRtRW9GRXJpeVYvckhHc2gxZnNydG5jVkpaZGRG?=
 =?utf-8?B?YWx6akU4cnl4Wm5PTmk3OWhuNHEzaGJlSGlZRVFEUkJNazVsc09LZDhVK0xp?=
 =?utf-8?B?c0M1VWFaNUJ5akVNKzFoOXBXT205aHV3Q3BYcDN0TUVqVEVGYmp0Nm96M0Jm?=
 =?utf-8?B?d0RoWlhobUJYWC9IOHA1bVZKcWloSUR4b0d2VytGdGtFKyt0eUQzdHI0Z2xn?=
 =?utf-8?B?dytmZkxBU3FmeTBvVXhURFF5TkwrRHVvKzJkeTZZQ1RnTGV5VjFLekV4MGxP?=
 =?utf-8?B?alpqZG02NHFOTzJybjNFUWtVUkJSRHZIZm1MMkt4UXRWWGxrakJQTTJPTzBw?=
 =?utf-8?B?YllCVUF2UmhmN0RMbkd2SGdyblNQd0s2aXZZQUlvRzRkbEdQMCszV1JzQkhm?=
 =?utf-8?B?SGgvdjlsd3d5T2RoTXdHWFAwNDNDWk5ZU1JWdjhLYm5HVjU4WTdyRVVScVFL?=
 =?utf-8?B?Ty9ubVUzajF3ZWQxLzExWFIydVducmZnOFFhN25XajlBZG5JSXNaYXRIVVYv?=
 =?utf-8?B?Q3FBcm1yWjhrMDZCSGZlOTRpVEtTYWN3U3kxYzllZWxPcFNJeEFmYkdUNGtL?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A8E9F4B36AC1E40AC30F0792672C522@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73eede9a-5054-48fe-c1f4-08da80c36d69
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 02:43:26.8815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S5WjRcAnuBl0gNqSy0HU2pmIC4Nqud7ai1EF4zYeuAGlMj/6wY0bKlgYoDf5LoesFIaMuZpyNtpNHdRpcwckpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7035
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTA4LTExIGF0IDAxOjU3ICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+
IE9uIFdlZCwgQXVnIDEwLCAyMDIyIGF0IDEwOjE3OjMxQU0gKzAwMDAsIEh1YW5nLCBLYWkgd3Jv
dGU6DQo+ID4gPiBPbiBUdWUsIDIwMjItMDgtMDIgYXQgMTQ6MjEgKzEyMDAsIEthaSBIdWFuZyB3
cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUZXN0ZWQtYnk6IEhhaXRhbyBIdWFuZyA8aGFp
dGFvLmh1YW5nQGludGVsLmNvbT4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGFua3MNCj4gPiA+
ID4gPiBIYWl0YW8NCj4gPiA+ID4gDQo+ID4gPiA+IEhpIEhhaXRhbywNCj4gPiA+ID4gDQo+ID4g
PiA+IENvdWxkIHlvdSBhbHNvIGhlbHAgdG8gdGVzdCBpbiBhIFZNPw0KPiA+ID4gPiANCj4gPiA+
ID4gWW91IHdpbGwgYWxzbyBuZWVkIGJlbG93IHBhdGNoIGluIG9yZGVyIHRvIHVzZSBFREVDQ1NT
QSBpbiB0aGUgZ3Vlc3Q6DQo+ID4gPiA+IA0KPiA+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sLzIwMjIwNzI3MTE1NDQyLjQ2NDM4MC0xLWthaS5odWFuZ0BpbnRlbA0KPiA+ID4gPiAu
Y29tLw0KPiA+ID4gPiANCj4gPiA+ID4gV2hlbiB5b3UgY3JlYXRlIHRoZSBWTSwgcGxlYXNlIHVz
ZSAtY3B1IGhvc3QuDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBIaSBIYWl0YW8sDQo+ID4gPiAN
Cj4gPiA+IERvIHlvdSBoYXZlIGFueSB1cGRhdGU/DQo+ID4gPiANCj4gPiA+IElmIGl0J3Mgbm90
IGVhc3kgZm9yIHlvdSB0byB2ZXJpZnkgaW4gVk0sIGNvdWxkIHlvdSBsZXQgbWUga25vdyBob3cg
dG8NCj4gPiA+IHNldCB1cCB0aGUgdGVzdGluZyBtYWNoaW5lIHNvIEkgY2FuIGhhdmUgYSB0cnk/
DQo+ID4gDQo+ID4gSSBjYW4gZ2l2ZSBhY2sgZm9yIHRoaXMsIGdpdmVuIHRoYXQgaXQgaXMgc28g
b2J2aW91czoNCj4gPiANCj4gPiBBY2tlZC1ieTogSmFya2tvIFNha2tpbmVuIDxqYXJra29Aa2Vy
bmVsLm9yZz4NCj4gPiANCj4gPiBXb3VsZCBnaXZlIHJldmlld2VkLWJ5IGlmIHRoZXJlIHdhcyB1
Y29kZSB1cGRhdGUgYXZhaWxhYmxlLCBhbmQgSSBjb3VsZCB0ZXN0DQo+ID4gdGhpcy4NCj4gPiAN
Cj4gDQo+IEkgZG9uJ3Qga25vdyB3aGV0aGVyIHRoZXJlJ3MgdWNvZGUgdXBkYXRlIGF2YWlsYWJs
ZS4gIE1heWJlIEhhaXRhbyBoYXMgbW9yZQ0KPiBpbmZvcm1hdGlvbi4NCj4gDQo+IEkgdGFsa2Vk
IHRvIEhhaXRhbyBhbmQgSSdsbCB0cnkgdG8gdmVyaWZ5IHRoaXMgaW4gYSBWTS4NCj4gDQoNClRv
Z2V0aGVyIHdpdGggdGhlIHBhdGNoIHRvIGV4cG9zZSBFREVDQ1NTQSB0byBndWVzdDoNCg0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtc2d4LzIwMjIwODE4MDIzODI5LjEyNTAwODAtMS1r
YWkuaHVhbmdAaW50ZWwuY29tL1QvI3UNCg0KSSBoYXZlIHRlc3RlZCBib3RoIEFFWC1ub3RpZnkg
YW5kIEVERUNDU1NBIHdvcmsgaW4gS1ZNIGd1ZXN0LiAgU286DQoNClRlc3RlZC1ieTogS2FpIEh1
YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KDQotLSANClRoYW5rcywNCi1LYWkNCg0KDQo=
