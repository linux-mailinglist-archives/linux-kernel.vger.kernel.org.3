Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B04B58F915
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiHKIaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbiHKI35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:29:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8768A7D2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660206597; x=1691742597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XGMABk5Vfa3SQWtueJQHbj3KFmqnNJkapcZwhfLzbMI=;
  b=WJDd89+270ODHLpBBpDfm79IDb8W8e7mp+IWhNGi8w1t8w4iK5MKWN0M
   nposloVe0gC9ZokE8GgGg0N6uDBmzPvPmmpzX5Fm5AGftHeBsBh1ILqEU
   aZg3/9Ld9DBoGDz9YM48kIvlnxHV4Kzj9o7rXVdOHFE4rL4K68X3YInav
   U1iQhuPunCAvLDaf6geUoORaJKHnUwZpfq4B4KilYZbi+aHKixOqGfI51
   Uh49fWTEGRAVRJAmlrtlGWuRO08c9o4D2y51Wmugb2RVFGRCsvwnFwQ+w
   reXy0V6e5ZlahEyOzGTBdukIL41+Jr4B8clQ1aeh7F7a9s9ftQyk5dzak
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271678644"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="271678644"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 01:29:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="638424982"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 11 Aug 2022 01:29:40 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 01:29:40 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 01:29:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 01:29:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 11 Aug 2022 01:29:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5Xo24zTfZzTauNVHBKj2bkCk2m7uS+qHVUwzVBONZ7Qw5XLZtjfNdJ5MB52FFd6LgmiiFohgE3h7PftPjFHmAOSeTpzeAb3lDAbEEV7E2zTnELkrteisNhe968BQG5Xg4rMl4GEQJrtH4FSWHtYsZUOHRLsJk51kGM8U0XOovT33aB/55hgUJc/+87diXU2DGUcVGskQzVhIxUsAYULtqm0m+CSX159I+qcV/s3Y06rurD64EdNz0PfXfE190fl/vlgExqoDRydXlpyGdOFqaAdoRdV7osIP3vRNQRcQYlm7ib8YJnQAaWxRcUY8VfI/nx8AyJvLMFpK+UifqisZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGMABk5Vfa3SQWtueJQHbj3KFmqnNJkapcZwhfLzbMI=;
 b=QVoAth+VFdwb1vp0MJFzieWGJAExhwnwclDkb9mtY/uDVi62EbKMBZHLAKqXekCV01ZKPbaPAxia0uyngqfce5XT1GbIx+hLkFLMb9ctbBiwHcWsatl3yb8ApjzMbrvzAgHQJy1xyiL2C9k6ZWeZ+xg1WgewRVLSmCaE+a4No/0YdXyxm0mVHSYEd134hFQmZ/1KNfOGi5Xj6dXkgTkFiDzVW41qhVoC+89hA89JwSvJpIsq0lyAPCMqmNj5Sr6GJJpWgIN7hWAbGuT/SyH5XhBEjAMX1Q4hXx2YSb8hXiVmTpWKtCbeTNe4axPbEIjOpAeBGPHGzivRXd+lXefuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS7PR11MB6150.namprd11.prod.outlook.com (2603:10b6:8:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 08:29:37 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::1d3c:4dc0:6155:2aee]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::1d3c:4dc0:6155:2aee%4]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 08:29:37 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>
CC:     "hpa@zytor.com" <hpa@zytor.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gomez Iglesias, Antonio" <antonio.gomez.iglesias@intel.com>
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
Thread-Topic: [PATCH] x86/apic: Don't disable x2APIC if locked
Thread-Index: AQHYrElrtTvS9DTMZUu9twTFYg+jeq2obduAgAAIB4CAAAZPAIAADV2AgAAoqgCAABAYAIAAAXkAgACcngA=
Date:   Thu, 11 Aug 2022 08:29:37 +0000
Message-ID: <76b3c2703d13252d1dba1b7f32675951d6b27e28.camel@intel.com>
References: <20220809234000.783284-1-daniel.sneddon@linux.intel.com>
         <d6ffb489-7024-ff74-bd2f-d1e06573bb82@intel.com>
         <238ea612-5a25-9323-b31f-0a14493db2f7@linux.intel.com>
         <d4bcb22e-224c-d256-cb93-3ff6ed89a7d0@intel.com>
         <341ea6e9-d8f3-ee7a-6794-67408abbf047@linux.intel.com>
         <87r11nu52l.ffs@tglx>
         <83a0d220-1872-caba-4e7e-b6a366655cf2@linux.intel.com>
         <ba80b303-31bf-d44a-b05d-5c0f83038798@intel.com>
In-Reply-To: <ba80b303-31bf-d44a-b05d-5c0f83038798@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.3 (3.44.3-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3dd22a9-b075-4f34-9611-08da7b73a0da
x-ms-traffictypediagnostic: DS7PR11MB6150:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HXkDVSZMhEdx3PEo/hxg/+P08z0+t2Bp4KsKUoatVmEGPcTldBcmySpWJBbo319FUImBSjgJ+uxoQ8W18o1HgKc2nw2TEilIeOKCAqbOnapFFrVxc7ma403FE0O9Yat1rzG/6DSmH269BJ8HjVmawEukOT6RsRPhJdEBBH/vCynh3+2YHhtMeMoqU76aatEb/s9V6OZsufj3rKQaUht+S2V00VUEt0draa8iYGl0ts7zOzNUdnk3z4D3Bh+bqSLxo+2qQrZWlqoN7lB+0N34nFHmuGpnrbsPJKlgpU4dl8M3Dnu8MpiHu7fBu4sJIqTS4j5Xy/Lzb7Awb9U3OUrvKAkMdEqWYXe10LBP3TMWlrtLN/Bv0Sbe0TU5U4DLt/HR2wQWBZZaK8LHzVvXLuDL5Araa6bGYvDRQbfzXzk1iig/+Zhr7QS5QHDdFd9XRB6jOs9jMBD8Foeu64pC+IVBzTC36AK6Axf+JDYMIY0cDKWlCiWu6WXatZISe/T2HD0gBK3PrmVQB3Ookq+mN3VSY8JG/zb4VheVmGemU8e+Wb/+jJyqKJA6sMmxD5dTbNThrpUtqCYU9nUH/06iSTpll267f9oRctxLia+WkZlKAqSNccJBHJP+6IvnFhNCYoHajFkiYBzQJm+pQdsuoKSRgElFu1uRrpoRFV1dDj5JoTpH4d7k40o3laeSPV2FxRrxEx3ofb3v4DMIDdSZQ9UUPuWtgneVDGr6S1KRZlNTWRt7XK0BkTFGXWDbQaySNmTZnkUNyUw31pu+q3NzNfUxibwoPDNBNQ3Cd98Xr+dEYVVmZwQkRCwJumVMgAHcsMtsIKChS3jn9cARV7wof1iFJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(136003)(366004)(346002)(396003)(110136005)(54906003)(316002)(478600001)(6486002)(71200400001)(41300700001)(8676002)(2906002)(76116006)(4326008)(91956017)(66476007)(66556008)(66946007)(64756008)(66446008)(5660300002)(4744005)(8936002)(38100700002)(122000001)(82960400001)(36756003)(921005)(86362001)(38070700005)(186003)(2616005)(53546011)(6506007)(26005)(6512007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlBkejlKbU8rdURCQWltbUlUaFUweG1xK1AyNFJGUXRWcGljN1RnNVZlcFZs?=
 =?utf-8?B?TTlkWllPSkZmeDI4RjdUMk5WL09hcFhtSFZBRStpRlRzSHNkcThjOU9HaGJh?=
 =?utf-8?B?TmFJYTRwNXNlTFRUcXJMYXNEVUdMbEFZSGpkU25CTWozUXo1VXBzdW5BRVVL?=
 =?utf-8?B?Qm5sRE14bTVMYUxxR080WnpubWVpeFlzek83RDJBWVpuK2R1dXJqa0gvREpz?=
 =?utf-8?B?YW1BSnVpclNFbWhYMVFYNFFxMlV6NE9LVmk3R3d6U3dBTVZ2ZTRMOFR4b1V4?=
 =?utf-8?B?dEk2YU0rR2lFN0k2R0FNbXdBdVpseEdFOWZRazA4L05lRC85aG40TmFNR21o?=
 =?utf-8?B?am1ZU09PWS8zWnpUa1YvQWFsYVRwa3BFdEltWFpVUjVoZEF6YldzNm5yV3RZ?=
 =?utf-8?B?cGdGL0QwM0pVQ2xEY25rN2grZTdsK0MwV0ZpYXR3R1Fzbm9aMThjNFlBcmxq?=
 =?utf-8?B?T1VsRWIyeGNnTTh4bmhjL2lSczZ0bWtoYmdwSlRKeXc5bWEzSWVER3Byc1Nj?=
 =?utf-8?B?NlJPOEIrYkJ2bjFtb2UyQzk5L3Qzb1Y4QjZWb2xaL3pCd1dUckllZzBuYUtL?=
 =?utf-8?B?MW0zVncvQ0RlbWJOM3JxYTZpOS9pNTRjejErVDhLNUdMTS9mN1FrMndQTXBO?=
 =?utf-8?B?ak1LQ3o0dVl6a0VhMUUzYVJRZkN6MjBDL1NSMUt5M3dZMGZxRXNaSnBZcHFE?=
 =?utf-8?B?VGI1UEtuSEtPVnpUL2Jqc1VuWWpMcnNtWkhlQ3lIK2V2Vm5iYThsY29uTFRV?=
 =?utf-8?B?QzBjWkhNQ29hR3NLd0VGTlUzcnlXV0lTZ0ZzSFdRK2xyL1VPS2htOFhUbFY4?=
 =?utf-8?B?T1NzV0k0RjZ4T3RScTRldmw1U3JPNVZrNHVpZUdKV29UeDV3dkFKMUY0U1c0?=
 =?utf-8?B?emZ3bkVhZ2dZUWprTnhhVFZYeUlsQU1TK0l1a2tUZjgwZ09iczhUSHh2VzJo?=
 =?utf-8?B?eXpwNnI5NG5QTWNMT3FjaXVqaHE4M1FobWhKeUdpTnhIWDFsTlVVanVvVnEw?=
 =?utf-8?B?UVRVTTlTR0dTVDdIUUhLRVpHNlhqd09FcUpHL1Nnd2VrUWNDUU1qSGFTK0s3?=
 =?utf-8?B?UjhMRGFnQkgxM2tlcWc5Q2tqQm56Wi9uT2R3N2E0QjdYc3dIWmFROGFRbnh0?=
 =?utf-8?B?blIxdUs5aW9DVmNiaHMydU9SVmJiaHdIbmJtNW9NbFc3QzIzVUpnRXp1dzN6?=
 =?utf-8?B?VXlVUnBEcVBRMURVQ3VzcUd6TFJIbE10ZllTQk4vRDlFSUxnT1F0NnB5cDE4?=
 =?utf-8?B?Yll6clM3SWh5aU5vYnI1V09jZ2REV0FqRDZmR2M4YTFQb1pGalVzbUtJQjlX?=
 =?utf-8?B?eS9JTGxCcGYxOUZRQ2JNTjJCdmZoeFZveGlNRHQwdU84bmdtL3A0MlJsR3U3?=
 =?utf-8?B?a1dMTmdmcTNjOFVhWHNJV0lDbnIweHJyUWc0aCtTNjFmZUNsc09ka21JandI?=
 =?utf-8?B?VkxxYTNUYTlUUjNVckE5QThvV3Y0Z3hPclYxNkR5ekJlK01aUmtaaXNIYU1Q?=
 =?utf-8?B?Slo4OHRvbXR0R1k4elBhTlVObVpmWE5ad0EzZ2NxWk1DWnlDTWhEa1ZZRTkz?=
 =?utf-8?B?TjdQNzZjbFppZHZOMVdmcEpwLzcwMmJ6MVBSZm9uMXVwS0ZweVNwR3pOWXFn?=
 =?utf-8?B?QVc2WTJhS0htOWtncm5CUjM4VFN0Z1hWbXNJOGpHditWZmVueW5zdm8vNUhw?=
 =?utf-8?B?U2RKR0VsM2RXMzNmL1UvQzNqL3Q1NmZCb09mUkcvQXIyWU8yZi9VTjV4Z2di?=
 =?utf-8?B?YUJZaGtyaFhVYXhCbXJlL2pPMXUrbUQ5THdOdWFnRE5YZTVoUGhiU2h1Ky9x?=
 =?utf-8?B?c3FRYi9FTXJjdWNGZCtTeTdsU0NFYmhpUVdHY2RVVHkvdzNIVGVKb3M2S2Jj?=
 =?utf-8?B?ZnF0K2UweStQbTFmZ2ZkOUZDYkhFcEs2MHpZSWdONXYvcmtBdEM2ZE9UZmw0?=
 =?utf-8?B?bE5CNWFjS1EvdHc2S2tGQzc4WFRPeHZqSDhtREVqeHRpSmttVWpxTlJGK2hr?=
 =?utf-8?B?MWl2Z1d1R3lHcCtvV3RmVlQwR3hkeGl3MVkreTRuOTVPRWE1UHJGUit2Rkor?=
 =?utf-8?B?dXlyK2ltaWwxTWRXanI5V3h2MElvSktoQVYxNDczWHlnYWJPQit6dEJISWlH?=
 =?utf-8?B?VXFDa2JpZmhxV0doNlV1c1ZRbElyZ0pIWEdQandpYTBvVTRIYkViemlzLzl0?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D22845B051E8445954F76940C106F18@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3dd22a9-b075-4f34-9611-08da7b73a0da
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 08:29:37.5856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQBHWcI4LDUHMOwkwfrR8UCXF+qvDyugqX193umyExd77mJhY9fFBTuYEs7TvOn4V8uxfDEKls3VA3yqnH8oRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6150
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

T24gV2VkLCAyMDIyLTA4LTEwIGF0IDE2OjA5IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOC8xMC8yMiAxNjowMywgRGFuaWVsIFNuZWRkb24gd3JvdGU6DQo+ID4gT24gOC8xMC8yMiAx
NTowNiwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiA+ID4gU28gdGhpcyBhZmZlY3RzIGFscmVh
ZHkgZGVwbG95ZWQgc3lzdGVtcyBhbmQgd2UgaGF2ZSB0bw0KPiA+ID4gDQo+ID4gPiAgIC0gYmFj
a3BvcnQgdGhlIHgyYXBpYyBsb2NrIGNoYW5nZXMNCj4gPiA+IA0KPiA+ID4gICAtIHByb3ZpZGUg
cHJvcGVyIGRpYWdub3N0aWNzDQo+ID4gPiANCj4gPiA+ICAgLSBtYWtlIFNHWCBhbmQgVERYIGRl
cGVuZCBvbiBYMkFQSUMgc3VwcG9ydA0KPiA+IEknbGwgYWRkIHRoZSBjb21tZW50cyBEYXZlIG1l
bnRpb25lZCBlYXJsaWVyLCBhbmQgd2lsbCBtYWtlIFNHWCBhbmQgVERYIGRlcGVuZA0KPiA+IG9u
IFgyQVBJQyBzaW5jZSB0aGF0IG1ha2VzIHNlbnNlIHJlZ2FyZGxlc3Mgb2Ygd2hhdCBodyBlbmRz
IHVwIHdpdGggdGhpcyBjaGFuZ2UuDQo+ID4gIFVubGVzcyB3ZSB3YW50IHRvIGdldCByaWQgb2Yg
Q09ORklHX1g4Nl9YMkFQSUMgbGlrZSBEYXZlIG1lbnRpb25lZD8NCj4gDQo+IFRoZSBURFggZ3Vl
c3Qgc3VwcG9ydCBpbiB0aGUga2VybmVsIGlzbid0IF9hY3R1YWxseV8gcmVsYXRlZCB0byB0aGlz
Ki4NCj4gSXQncyB0aGUgaG9zdC1zaWRlIHN1cHBvcnQgdGhhdCBtYXR0ZXJzIGFuZCB0aGF0IGlz
bid0IG1lcmdlZCB5ZXQuICBJJ3ZlDQo+IGNjJ2QgS2FpIHNvIGhlIGRvZXNuJ3QgZm9yZ2V0IHRv
IGRvIHRoaXMuDQo+IA0KPiANCg0KSGkgRGF2ZSwNCg0KVGhhbmtzIGZvciB0aGUgaW5mby4gIEkn
bGwgYWRkcmVzcyB0aGlzIGJlZm9yZSBzZW5kaW5nIG91dCBuZXh0IHZlcnNpb24uDQoNCi0tIA0K
VGhhbmtzLA0KLUthaQ0KDQoNCg==
