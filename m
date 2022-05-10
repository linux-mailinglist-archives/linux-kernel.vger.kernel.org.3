Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D1F521F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346087AbiEJPnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346079AbiEJPmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:42:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F0625BA74
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652197114; x=1683733114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V6oSx2JQIxl+6EIRhVU7jBMum/ZbDVX5As05Jl5V0ck=;
  b=cpXCNmFDk9oxM6FOL6t0D9pfhY1o59bm4pp8wdk68Mb0TTdp9U36xcMQ
   bEB+Z+OQzcpeJp0So2kkpMZJuILclKMvOCnEFB6qOEgKsoe5rbu0pyloZ
   cMPvDPnSHCD3hui1lJfhJvS6+34kferW5FfkN+jfz/VDSmFHTnHQUg8P+
   KlWox4cV3/1njFSQRIClj6qL+ZoePPLPMy/P3tK6BQoHnKhNSpJfk42Ot
   FIV8dmHPJNYvVKEQEmxvYG5XeS4u1dCy+o5d24QXMsmUQ1pCNvoYk6RVm
   a8RTZoDaZhzLhzj10i+c/7Szta6ZOVHf/zpO4iH51nAVZydzWn3bz4P2v
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="268252676"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="268252676"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 08:38:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="602522369"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2022 08:38:33 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 10 May 2022 08:38:33 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 10 May 2022 08:38:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 10 May 2022 08:38:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 10 May 2022 08:38:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4/1s5Xf12DMZmWIa+CtV6/wWSHCqvcXETd3fIITwgKVo02QGbK4efCGye9vWX4GjU9mwYGNGJb9DaQkSFcY6wrMXFA+ToauZ31xCTHaXGEDK/pRxFoczGrl+wH72OZuPByTnqFCj4cxz6jabQknQ4rwDP7NcuXRQApoksIm4Ms5FYFfmftyIWr99xSRAt3QYZvzFOzPJwf5jCUv/xazF/02JhQJOKlLDCUMfUJA2nx7UDnz0EQs75gnHpOPI3zvaJMB1lpfZxnRvVepXoAAuNt6vA9VjKxxf8NzuGWElV0QQPLVdIYa11NsGSVDsZb0MWQi11t1Yf/BL5Mhlecdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6oSx2JQIxl+6EIRhVU7jBMum/ZbDVX5As05Jl5V0ck=;
 b=I3kRJkk+VKu0hFzsMdxqYn1BohuVKaz+saa3F9V4v1YvA7FX351zchBb5K1l0+KCuQ0URpHD2VCwPAAgqv5hbL7D3TCn6AjyxwuRWsnhRTy72AeDUqGDj/Ao3J3QqxBUzo/SuZysHDttCcicw9JWnND4aVKBr0EH99GpXMl7zeq884AVqy77Zj/Ff55qInSG0f84lBbPLl49aR5fgHB3E/g7pOOwLZK9Fy9BlWjDO+/R8/OXJ2Y1UVCq9AKCXjNAuawm2snv1oF8u2yr1lcJM/IPFS5cVZoh0PQ4iEQMAXmNI3URD17nEj+zsbZEdGW9sg5YK88y1ku2nY8hULFQYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB3632.namprd11.prod.outlook.com (2603:10b6:208:ec::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 15:38:31 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5227.023; Tue, 10 May
 2022 15:38:30 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/mm/cpa: set PAGE_KERNEL in __set_pages_p()
Thread-Topic: [PATCH] x86/mm/cpa: set PAGE_KERNEL in __set_pages_p()
Thread-Index: AQHYYQlUbv+/dni+y0+PmXXltVqJaq0XTOMAgAC5VICAAD+1AA==
Date:   Tue, 10 May 2022 15:38:30 +0000
Message-ID: <e93470ca9c969246b68338fe04e64fb32262b266.camel@intel.com>
References: <20220506051940.156952-1-42.hyeyoo@gmail.com>
         <2cd129af8d66fc4bffcb124a3675bffbf1becd85.camel@intel.com>
         <YnpRhT68kwaMBEHF@hyeyoo>
In-Reply-To: <YnpRhT68kwaMBEHF@hyeyoo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57854727-3365-40a2-4aef-08da329b2290
x-ms-traffictypediagnostic: MN2PR11MB3632:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB3632095C596B3BE8B995AB7BC9C99@MN2PR11MB3632.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QPAkv6rMLwUBcHHfKGlgGpOwKeV6suF7RY4WQpmfXWqEh7G0HmccV7OLGt3ShooueAcAKFXk4S/jZos7ORjStRhnG7dI+UewqWTldoI6hwWmIzZuiNe063aoixjXU0+W41eu64UHsSAaGFGTDLGa5JPAX+oe/+wRMAlwnnVJWJ5K9+RHFKR+K9SgaFpCw9NzQNcA1Xso1V5wtXPRKwabPhxpyRXbYNkJpTVdh1lfwhCyGbwhHGGR5LX1C9t9tTptDu/QK9k7AyJwnx3egxPF9K/zVv6BoMDZmzMAQaHsOJofanw58IPT0IP2mjFIQhGB7Y0ZvYV4f60moDXRioQBanCEpx/d3KlN9+dVU0xbcuLCinpMVQKPSxZ9+GLdq29XQOIcI1k2NXzhbef0Uj14KenvATuQAOUSmjfpICBoahv3jm5yGv6x73BGqKtcoCF1iTh4yJfQwdSSGGJbmQwlYNpp0PCIrgTSYAMqHkjP+4OjNVXFZX4GILJm/Dy7kVuudUo10xlqoOWEy3kEmWjXIoTRBjdMgVbsnCA/p532NKIvOidLPNrfwqkO45t3SNEH7i2yCur5tVYCbajifH7RDYWG6DZZEYZtUne9fOW0+kSMqZMDqMwhNZUSewsnJqtY1UEPEwmtosWvAXpne2QUjlza6M9L1ZpRcOIMHwiU9np1DZho5hSyVcgDviRRylinM8keXqlazpA9o0Po09g+bCvR7Ybfohq9YDtY2R1vH0I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(91956017)(71200400001)(8936002)(508600001)(8676002)(76116006)(2906002)(66556008)(66476007)(66946007)(66446008)(64756008)(82960400001)(6916009)(83380400001)(122000001)(6506007)(186003)(2616005)(26005)(5660300002)(38070700005)(6486002)(7416002)(316002)(38100700002)(86362001)(54906003)(4326008)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUZvVGpHdDdlZ0ZKT3NOYVE0SGp6NzYzU3RQY2xmTnZmMDJNcnZrMlBCdldp?=
 =?utf-8?B?bm5Ea0JZUmFNdDNEaUZNMEVBNlJVMnN1TU1USi9vUGhpRzVVT2pWLzh6bXVI?=
 =?utf-8?B?NlZ2Z01YMlhGVWV2S21XYWtxcHZ2TEdGc2FtTlM3cmFzTDhoWlpuQ2xWZzhp?=
 =?utf-8?B?MEJRdWxabXZTT1FyS3h1bm1qN2tQRjFHZU85NXJ6THl5czY1eC82VFQyY1Ux?=
 =?utf-8?B?akhuRUhYcTk4c2J2N3dxVGJjVlphTDZpSHZDWGo4ZHYxTjY3Ymtpc2xWcGlH?=
 =?utf-8?B?c1FCZC9neVNEb2ZCTnQ5NnZMYXBlNjFtK1Rza0RFS0N0N1J0M1kyNXM5dDJR?=
 =?utf-8?B?NWxaVWRzNDQ4NmdKRjF3amEvVFhsNkJOVDUwTjdGa1Q5TGlRK3pPVkZnQSt1?=
 =?utf-8?B?RGNDZ2J4TzA4ZWNnNXg3Z0d1WS9XTXdRTVROSkFGYW5zTUpRa0VodEhFS2Yr?=
 =?utf-8?B?LzlkSEN5K0tha2pVUjhnQVhwQzJUcG1Ra05HSWR5VFg5YnRoekRhUXdKbWtP?=
 =?utf-8?B?Wmo3ZWt4WVprVEFHNzZpTFBydm1ISmRDRHhkcWpWL1dpNVVEYUhJTGZoeUpJ?=
 =?utf-8?B?OGNxVGhnUmtxdUVtc2NkZE5abzcxWnBxK2J4N3N0UUlWdEEzeFBEU3lVenBs?=
 =?utf-8?B?d3BlTmtmRWl4L05XSkdwa1VrK1JQOU9tb3VUS0Y3RXVJZ01ISnVISlVRK1hB?=
 =?utf-8?B?TjFtZmlyN0ZZdVhPbDFUa3hpTEwxTEN4Q1d6QjJOWHRzVnNPT25MZlFaTVRj?=
 =?utf-8?B?ZFE4SDdrZGF6UWRRa3lxVDJZTHNvUlhiU3k0TEVtUGZOZlBsdGw0VlhMOTdO?=
 =?utf-8?B?RG1sM2NZS1dzb3RMWXRDZE1reWpiZVB0ZGNkR3Zwa0psWXNodEtwaWU1TFkr?=
 =?utf-8?B?QWJROHBpK3JJa1c5eXR6RmRtSkVnbEUySm51dVdoV0kwZVQydnZXRVRIQzNt?=
 =?utf-8?B?MVNKQ3o3WGYxV0VKdnJDM2xEUlB0ZGhtSlVacTBCRlhmRk9VTWFDOTdoUVlV?=
 =?utf-8?B?aUkwQU9WajVUemExcUF3VUtYQXBoamdqUmJvaWJaZ04zQ1IrLzB3VXZCK09a?=
 =?utf-8?B?K1hsOWVra0wxREx6K0owdk54R25VUktwSERqdWZkVVRNREMzQW5KL1FTQlBy?=
 =?utf-8?B?aG5KVXJ2bXpqT0hRNDAySlo2KzhYY3JzZ1U1NUdQODdFS0FSM1V4UkpqRFNK?=
 =?utf-8?B?K2NsMTRTVlFTRDdaZkZ1Y2JDdW56T2RoYXpXK3F2MTNaaFNJQnVyMnJNS3RX?=
 =?utf-8?B?ako5ZkN1Q2VpR1BGTk9ZZFh2bVVWRkFCc0VkeVVHRXd6V0NTU2dpVERnTG81?=
 =?utf-8?B?Z2tZMm5rLzJZYzlSS3laazVRem52VWRxZmdsTDMyUW0ybHJHZHRxMFZiTlEw?=
 =?utf-8?B?eFVRMkIyUXpIVTVPR09pOW85aFRoWkY1MXo0d2UzNmp5UjNnNHVKLy84SjVu?=
 =?utf-8?B?ZHBGS0d0clNIckMrRElHdGtpVmE4VW1kVWNzVUx2UGxSTUxXZjVoSlJOTDZR?=
 =?utf-8?B?NGFzMDRqYmd0QzYyNUVTQnVaZDNBQ1BKaENQS0Fmc3R5VHdsV0FzS21WV1dn?=
 =?utf-8?B?NUMvRGNURVhUQ0ZsY3FHMGlhUjI2UnkvYjFweW1NQlVCRng2WkJKRHVRNmJ0?=
 =?utf-8?B?cDR6Mk9jVUcvejVDeXE0cUorcENRMGJGZ0tsb1ZIbUFFYTRjTnVlOVpKOU9k?=
 =?utf-8?B?ZGxwR2VUU3JnaWxlanBiSEZnNDgwaWdDNjZ3eS9UWU1TYlpzU2VtQzh2Qy9J?=
 =?utf-8?B?SDFVeElWWWJRaFVpMG5rR0o1SWVlMmozK0RkeVhoWkd1Z2pmQTV0cjdRWjlJ?=
 =?utf-8?B?ck91L2U3WVpkZUUrRXNWRlpDaDczWmdUY1FFK3ZCYWdPTG8wblQxWlFoYXcv?=
 =?utf-8?B?c0xDa05BZEJLMXdTU0pWVysvK2htRVp6dUVSZjZpcjZlR3grSmxnSFluanhW?=
 =?utf-8?B?NDUvbklVTXNLU0t1cHBiOG9tOWtheW9tTFBwMjR5Yms2WW4vS3VuRXNBVGhS?=
 =?utf-8?B?bldCdUEwZnJ6SDNURndXelRObTVudFRHOTlpekJvTWhXSnhWNmx1SmZ5cytX?=
 =?utf-8?B?Qk9BTWJVRkg3VHBDQ1pSQjZBc2lNVU84ZHZudHhSQVlMejJtVnZmVE0wYjk1?=
 =?utf-8?B?cFZwcjhFZkxLR21abGUzVGw3MkgvcFhaUXNOc21XZUpRaXlRUzZvZm1CRWZ3?=
 =?utf-8?B?VGNja0JuNFdxRlpnMWcvbW9IaDJPd3FEQU43THkvRkNmMEhQZ1l3bXpqT0xJ?=
 =?utf-8?B?ZW9jWXpaOGk1eEtKUW5tVDBCbWh0ckJwM09zcjhmWUpSVlYvb3NrdWlIQ090?=
 =?utf-8?B?a3pzeDE4WkJSS2k1L2lidWVoSXVHTFBqcWJlNXR5OTREa21VYlhRV3JVSjlw?=
 =?utf-8?Q?8TGFuuzMQdOaXzL876pRsbwIIrpe0565uiZs5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C2D41A013D19940995D1F03CEF80505@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57854727-3365-40a2-4aef-08da329b2290
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 15:38:30.7235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOs3tRy9EfrMlIMAXIxcARvZzA/WWY6mK7NuGhlkH1dAEwD2h/fpKUuHUGcY2u5c6wU1zG+g1JBGQnxqWytbD1+7A2PcCW9CvTP/0yKUg6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3632
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTA1LTEwIGF0IDIwOjUwICswOTAwLCBIeWVvbmdnb24gWW9vIHdyb3RlOg0K
PiBUaGFua3MgZm9yIHJldmlldyENCj4gDQo+IElJVUMgX19wZ3Byb3RfbWFzaygpIGFscmVhZHkg
Y2xlYXJzIF9QQUdFX0dMT0JBTCBmcm9tIFBBR0VfS0VSTkVMDQo+IHdoZW4gUFRJIGlzIHVzZWQu
DQo+IA0KPiAjZGVmaW5lIF9fcGdwcm90X21hc2soeCkgICAgICAgIF9fcGdwcm90KCh4KSAmDQo+
IF9fZGVmYXVsdF9rZXJuZWxfcHRlX21hc2spDQo+ICNkZWZpbmUgUEFHRV9LRVJORUwgICAgICAg
ICAgICAgX19wZ3Byb3RfbWFzayhfX1BBR0VfS0VSTkVMIHwgX0VOQykNCj4gDQo+IEJ1dCB5ZWFo
LCBpdCBzZWVtcyBQQUdFX0tFUk5FTCBpcyB0b28gbXVjaCBmb3IgdGhpcy4NCg0KT2gsIHllcCwg
eW91J3JlIHJpZ2h0Lg0KDQo+IA0KPiA+IE1heWJlIHNvbWV0aGluZyBsaWtlIHRoaXM/DQo+ID4g
KF9QQUdFX1BSRVNFTlQgfCBfUEFHRV9SVyB8IF9QQUdFX0dMT0JBTCkgJg0KPiA+IF9fZGVmYXVs
dF9rZXJuZWxfcHRlX21hc2sNCj4gPiANCj4gDQo+IFdoYXQgYWJvdXQgX19wZ3Byb3RfbWFzayhf
UEFHRV9QUkVTRU5UIHwgX1BBR0VfUlcgfCBfUEFHRV9HTE9CQUwpPw0KPiANCj4gPiBUaGF0IHdv
dWxkIGFkZCBiYWNrIGluIGEgbGl0dGxlIG9mIHRoZSAiZGVmYXVsdCBnbG9iYWwiIGJlaGF2aW9y
DQo+ID4gdGhhdA0KPiA+IHdhcyByZW1vdmVkIGluIGQxNDQwYjIsIGJ1dCBJIHRoaW5rIGl0IHNo
b3VsZCBiZSBvayBiZWNhdXNlIGl0IGlzDQo+ID4gbGltaXRlZCB0byB0aGUgZGlyZWN0IG1hcC4g
DQo+ID4gT3RoZXJ3aXNlLCBJIHdvbmRlciBpZiB0aGUgZXhpc3RpbmcgZ2xvYmFsDQo+ID4gY2xl
YXJpbmcgbG9naWMgaXMgcmVhbGx5IG5lZWRlZC4NCj4gDQo+IEkgdGhpbmsgaXQncyBzdGlsbCBu
ZWVkZWQuIHB0ZV9wcmVzZW50KCkgcmV0dXJuaW5nIHRydWUgZHVlIHRvDQo+IF9QQUdFX1BST1RO
T05FDQo+IGFmdGVyIF9fc2V0X3BhZ2VzX25wKCkgc2ltcGx5IGRvZXNuJ3QgbWFrZSBzZW5zZS4g
Tm8/DQoNClllYSwgSSBqdXN0IG1lYW50IHdlIGRvbid0IG5lZWQgUFJPVE5PTkUgaW4gdGhlIGtl
cm5lbCBQVEVzIChJIHRoaW5rKSwNCnNvIHRoZSBrZXJuZWwgaXMgZm9yY2VkIHRvIGRvIHdlaXJk
IHN0dWZmIGluIENQQSBzbyB0aGF0IGl0IGNhbiBzaGFyZQ0KdGhlIHB0ZSBoZWxwZXJzIHdpdGgg
dXNlcnNwYWNlLg0KDQpJIGhhdmUgbm90IHRob3VnaHQgdGhpcyBhbGwgdGhlIHdheSB0aHJvdWdo
LCBidXQgc2F5IHdlIGRlY2xhcmVkIHRoYXQNClBST1RfTk9ORSBkb2Vzbid0IGV4aXN0IGluIGtl
cm5lbCBwdGUncywgdGhlbiBwdGVfcHJlc2VudCgpIGNvdWxkIGJlDQpsaWtlOg0KDQpzdGF0aWMg
aW5saW5lIGludCBwdGVfcHJlc2VudChwdGVfdCBhKQ0Kew0KCXB0ZXZhbF90IHZhbCA9IHB0ZV9m
bGFncyhhKQ0KCWJvb2wga2VybmVsX3AgPSB2YWwgJiAoX1BBR0VfVVNFUiB8IF9QQUdFX1BSRVNF
TlQpID09DQoJCQlfUEFHRV9QUkVTRU5UOw0KCWJvb2wgdXNlcl9wID0gKHZhbCAmIF9QQUdFX1VT
RVIpICYmDQoJCSAgICAgICh2YWwgJiAoX1BBR0VfUFJFU0VOVCB8IF9QQUdFX1BST1ROT05FKSk7
DQoNCgkvKg0KCSAqIFBST1RfTk9ORSBkb2VzIG5vdCBleGlzdCBmb3Iga2VybmVsIFBURXMsIGJ1
dCBnbG9iYWwgYW5kDQoJICogbm90IHByZXNlbnQgY2FuIGFwcGVhciBpbiBvdGhlciBjYXNlcy4g
Q2hlY2sgZWFjaA0KCSAqIGRpZmZlcmVudGx5IGRlcGVuZGluZyBvbiB0aGUgdXNlciBiaXQuDQoJ
ICovDQoJcmV0dXJuIGtlcm5lbF9wIHx8IHVzZXJfcDsNCn0NCg0KTm90IHN1cmUgd2hlcmUgZWxz
ZSBpdCB0aWVzIGluLiBJIHRoaW5rIHRoYXQgaXMgd2hhdCBEYXZlIHdhcyBnZXR0aW5nDQphdCBp
biB0aGUgb3RoZXIgdGhyZWFkIC0gdG8gZmlndXJlIG91dCBhbGwgdGhlIHBsYWNlcyB0aGF0IG5l
ZWQgdG8NCmNoYW5nZSB0byByZW1vdmUgdGhlIG1lYW5pbmcgZnJvbSBrZXJuZWwgUFRFcy4NCg0K
UmUtc2V0dGluZyBnbG9iYWwgc2VlbXMgdmFsaWQgdG9vLg0KDQo=
