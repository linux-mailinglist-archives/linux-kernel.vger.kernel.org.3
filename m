Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE65A9D29
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiIAQb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiIAQbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:31:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAE4647C4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662049882; x=1693585882;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VoX4f+W3LKsSrhqeoOi1FPxE5bUs/328OZ1ffHBwkGw=;
  b=Jpu4mHWQbkLQZHJzmeByoXB5FLSyuG70IfqtqBeABIl14rMrerQUA03o
   +QjHZzJQtglvU+NEciy1+I3rxh1fMg8Z6bgUc0E4CUPDjvk0YduJMcEAf
   buCg/EdQJ2NE9WmvIcDJlosspt0y7tT2h21aXE4ph7UEZdtNniPsz1me9
   xvJosTzpPYAl91HCYdATDdamQH2mGB3mzWXOXHGgzaiBsADda64KmvBfo
   Jir2c+R3VOFd97RpWF3gcJhQbdh356kTydgG6h3D65GdllPXZloKkIc1k
   75OLPh+5ZnXJcKZra1kPZbaEDSdqoHGQyRxN5FaFIO17n1BaaIUnk9ApG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="321915197"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="321915197"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 09:31:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="754893224"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 01 Sep 2022 09:31:09 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 09:31:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 09:31:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 09:31:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 09:31:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/FmoxOMNPo9HV1gsctxMft4u3ONkqSHZJIVbR++Vbp4FPDx1xZuGNUuEnHVCxQiqsU5Tjw0EFBbygPX/fgwnFGoqRD57rlBrwSV+iyxkMbqVeBrUIkCS+AZvLVWw9b+lGooVnDH4w4vDrbUASdP/e4KenE2UToWpDy3brbZoiHJ81lCPu9Zp2Xa0Hp7HqDN41bpSdLMoaTzr4jFGAEzp7adwE0tuGan7/NZmpi9CziUZIwt2nPyQluY2k+MFvOzHFCtuhFd4+plgHU65wEo5EirOJZmYyj0vyG5tvF9XciX8AzdkhNx1v4mevTMALeHVbscxekWYVU/QkLgSD9kBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoX4f+W3LKsSrhqeoOi1FPxE5bUs/328OZ1ffHBwkGw=;
 b=AbfBO2r9PqRjTZsrsOKMDuXtalvFIiebJj3OaBuzQb9mGl+983Xpa5RtzfYlfb3uCHyyzPngn4EGiSDkHMqEYfOcwwde6SVH8TIJBPvfYXJeSneyHHgr1oKqxZQJ3U4yoITzlNRapDAIymSZ9WsJNIwubTwKOqnnqIQ81lxTjY4SLqEzifbjLM7dvGGXFe8SyiFnedUWftsTxTptHQ7jfwaQ/+rrcYlarcML2T5SdAiUbqvo/l+XZQxwUufH/c0+tYc+BYV4GWIlv05s5l9MCnbfFVGrguRIZBO64KdOmWAi4GO9CDrTTxdlZCM7s3tqDgCj0UwJH25H9+6Q/2imgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 MWHPR11MB2064.namprd11.prod.outlook.com (2603:10b6:300:27::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.11; Thu, 1 Sep 2022 16:31:07 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::fdd1:18b1:3e9c:b03e]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::fdd1:18b1:3e9c:b03e%6]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 16:31:06 +0000
From:   "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "airlied@linux.ie" <airlied@linux.ie>
CC:     "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v7 14/15] drm/i915/gsc: allocate extended operational
 memory in LMEM
Thread-Topic: [PATCH v7 14/15] drm/i915/gsc: allocate extended operational
 memory in LMEM
Thread-Index: AQHYqY/95whfaay9skuup4pBrG3vgK3K7ccA
Date:   Thu, 1 Sep 2022 16:31:06 +0000
Message-ID: <cb7cef1bb0bbd5aa07f2023ed3c4e4003f810819.camel@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
         <20220806122636.43068-15-tomas.winkler@intel.com>
In-Reply-To: <20220806122636.43068-15-tomas.winkler@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 292c538f-221c-4dbc-4a91-08da8c375ed2
x-ms-traffictypediagnostic: MWHPR11MB2064:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 462/QhOgMo2Y1ozSvdbhIkOqo2HHkuIQDYqzbhwjQ5mEeeHGNoQYBZpJex26YVmA1fddplnq7NwcqK0GkpuNw3w/x3hOQpLWN9T7a0OUWCOosdCeWmIzHwGC5dE3XPu1S+lMyLhC809qdoyyNxT4x4+rigu74NkkTbOW0UeV3pQ7ama7MXAu3Uy68GbWW61z/CXGpuT/oaMBWFnaK0gcpHOy9WI04EldRIZYc7UDFOx3CXKBUNjuuryeCNKDreMP1LCVjA1BU0qZPiIc34xw4eAmFzcSFqfAmRGkwqsa64a7Dg2Rlqb9l+H4oixodg/FIyQom7daHXHT/waC7LWCenFa4J3T06FBTMNJaSLM79tgwOOEG2ZbK1jKpewp+FebV8kPPg9gVtlLbbVzTOBSM4vs9uFe8SnfKpoTTYCNO3gLi3T6nu7TV3VMfSjOtfCQu9Q/LV+6qy40Cw2swd88Q0tm5vpkumj4qJYBUIeH6g6lPZSmiDvpQ5BTA3NMk0txxd2gkeuhKr14aAZONgkWPMmoK8Ev17LdN4jz0MCs+zTLrmjLnfFT8+6zPazUqp6G33oXuLii6E8iBivk8b5UcEiOOENvp2iUpxgKM2J1IG7x1zTSF7RGoWX/9x+pd+Kv7IdUaAhHRNSs1w79dntrcdoySgKU9pYGv47p1LNLpcVNlNSi1Y5HkC8LIzg17pdRDwHNGuXBkSopG5cWESG8LVt33NqY9x7q7SkmFOygIWYZZWadHUQEULotKfPfY3DVU1BxMHVYGbnFttoLIbwLNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(39860400002)(366004)(136003)(122000001)(83380400001)(38070700005)(38100700002)(66556008)(110136005)(64756008)(316002)(71200400001)(66476007)(8676002)(66446008)(4326008)(91956017)(76116006)(478600001)(82960400001)(54906003)(36756003)(6486002)(66946007)(8936002)(41300700001)(5660300002)(86362001)(2616005)(186003)(26005)(6506007)(2906002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnROMXFmWk81WHoyNmk4TUppT2I0V0UwZzNIamV6ZzVQMG9xb051VDhQV1hJ?=
 =?utf-8?B?eTdoYkVQZCtzeDRMdzBoQVVVY3d6Z0g4aisxYjFYdjVvbVhVclRoT3dMa0Nx?=
 =?utf-8?B?bUkxN0xUa0ZQTEhkWXFEbDNUbXZXbEZRZ3FUUmpzdnBlZDZ1TjZuUXM2a0Mr?=
 =?utf-8?B?allJajNDQU52djFNOS81U3doNDluWWhqQTZOckdkRmFrdENPakMySk44M2Rz?=
 =?utf-8?B?emkrVGZ4R1JGTmtKTmNoSEI0R3ljVFZ3anhyakc5TnhTU1BpckVVVlFMeEhv?=
 =?utf-8?B?U2hmdGxSK1R2RjgrZGpzOGNpWGVtMmhmR0RoZjFIOTUxdFY3RGFPZmlzZlBi?=
 =?utf-8?B?VmtjQTlRYnNqM0hjTE1CVEg5RGl0YnhNUzNzVCt0dk9TdUxkb2pWaGxVa1JL?=
 =?utf-8?B?SVluUGtiVnFma0NwOWRoUkh3cXBSN3lMV1VyS0JiSWNkSWt6RS9UbERtSndL?=
 =?utf-8?B?RW01dis1dmp4M3N3dFlESWFmeXZieXhvQjZsWDRGVWtYMmxnVWloMUhxdktY?=
 =?utf-8?B?QmpHb0d1VE9xL3dvUkNQUGhRT3BSNW5yK1J3NzYvODV6YWYxdzE3bXliajRS?=
 =?utf-8?B?Mm9tQ3RBbXAvMm9xY3dOb0Z2SnROclBwQXBPRGM1VFNRcytBRHZQSlNaVHF2?=
 =?utf-8?B?VXhOSWwwYVpVQjk0RVJUYjBlczlhOXpia3NvZXhheUY0aUZDekV3Z1krYUN0?=
 =?utf-8?B?Zi93MzNkc0tXYlBoU2hRMjZvVDZvK3FhYWd4WWdJMGJxOVRnK1ljNktZK3dQ?=
 =?utf-8?B?eHBkcml1ZGtPSTJHMEsydTlMY3VVcmpoWVlvdFhET2JkNTQ5Tm43S3dqdDNj?=
 =?utf-8?B?Uk9zTGZaZVBRYTVnQnNMRnhZOUtvV3hMc0hYMDQ1cXJmaENKTHJMZ1RwSmFR?=
 =?utf-8?B?RW8zam9oeEE1eE4vbmxXT0t4NnhlNmNjQ1RHejBEM1pkY05PYUdYSDFXNHhh?=
 =?utf-8?B?OWFJTEhHdjRLelp2YkVZb2VrOWtIVHU0bzNqT3J1WjlxeitYRHRTb3M2Vk92?=
 =?utf-8?B?YSt6MFBJM0ZhUlhXR05ZbG9EaHNhVlNCazZ0YzV3NFo2RjRaaXZXb1I3YlRU?=
 =?utf-8?B?cEFjSkphOWpTSzREY2VrdFQ1UnVHcmFoVWxoaWRSWndBVkxFRGluNjBaeSs4?=
 =?utf-8?B?OUdhVytCRkJXblI1TmtzeUhwQ3BSYU1GR0owSVIrOHZRK3E2ZmZwWFEvMytT?=
 =?utf-8?B?OWNoMk5Odk55alZVMndGZ2RPMTZMOC8vbTZsaFJxRm9oT1AxUHpDd201K3hP?=
 =?utf-8?B?cUxRWlZvaXk3MjBzd0V2aG14Y1dQcWVoZExIRGJ6YkYwNWdCNnJma0xOZHdS?=
 =?utf-8?B?d1plL0c2bmwyVy80Nnp5L1RQcURTYVNVeEN1OTV1VXhEaDYrN3FMZEpKVWhH?=
 =?utf-8?B?ZEVMRzYvMXpldURhUnNJV1pJTTRUZzljV2d0LzZZZ1g3TEFHaW1OMGtsOEZj?=
 =?utf-8?B?K3MyQ3FHWWFYZmlHcXUxQjBqeHFhVTZIWExnZnBlOWtmYWQ1bVZNMUs1ajZZ?=
 =?utf-8?B?MWtqeERmRVhrSUI3ZGpicTdpRXJ4c1RQT1ZJSHVhcmY2eC9HVzhmOXg4TXVC?=
 =?utf-8?B?ZC9KTEQzUWZtMk9zL1hERWx4ditBRGhyalRDUWN3K0V1V3pqb0xSa0Z1T0Vl?=
 =?utf-8?B?bzRlWndLaGRQUVFhTjRTeEltVEtLQjNYM2NEeFFGeU1qM1lsMDYxdDBFa0pt?=
 =?utf-8?B?QVF0OXM2U21mV1A0b080M0pwOUtHQUk4MkhLQ0JHUUdTYjZHUGNrRGpwdkFa?=
 =?utf-8?B?dnhrQXRPaTNhUFhyN2F1bjlvZmgrdFErQjErWFlMVFdVbWtyZUlRU3oxTWRE?=
 =?utf-8?B?WDV6eXRtcHVwYWJ6YzJ2T0F0YXNhUktDdjM3czFiUFE2SEQ5bG5sWFR2ZU9M?=
 =?utf-8?B?QVFHK0dCcW15V2tjMVBIdXp3NVI0RXRsaHNwZ3VRRlovV2hyeGNkQkpySnFi?=
 =?utf-8?B?a200R3lESlVPY3BzNkE5aytRTXRGTEhQVlB1MGZmSzBpZXo0eUJpZWhXNXZL?=
 =?utf-8?B?MlM4Yy8yZ2ZjNkhNTHhEcmFnNDVyOFlUZHN6ZnJrRHlMNkNkVEl1dEs4aFc3?=
 =?utf-8?B?Vm83UU5mZFNQSTdRdGRxU3Y0TXBSR3lCdnQyd2U2VVNZelhDamk1cUt5VzFn?=
 =?utf-8?B?Q25UbzNvemdOcXkyT01EQ2dpK0ZnWXRlbWVtMm5ibWtvSGpSZ0lOQ1V4MTdT?=
 =?utf-8?Q?NXtrNRMkLxJ/Z4C8Ww5YF9TQmNC/RsvfobuCF4bxcQLb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <467F3FD08450F0478FA34C92D230EB0F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292c538f-221c-4dbc-4a91-08da8c375ed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 16:31:06.8120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DsD09ME4wkWvY4sMFtHlL775OMRX8H6sqWzBhU432bnW8YvEAU63YVeU8EEy61HfECwuqtEiSpjlh4c4adgJUWyJW9hFdnQOpXssiIgJzUilnWNlLLjqEvfWYo/SSAcl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2064
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBoYXNudCBjaGFuZ2VkIHNpbmNlIHY1IGFuZCBpIGFscmVhZHkgcHJvdmlkZWQg
dGhlIFItYiB0aGVuIHNvIHJlLXBvc3RpbmcgcmIgc28gcGF0Y2h3b3JrcyBjYW4gcGljayBpdCB1
cDoNCg0KUmV2aWV3ZWQtYnk6IEFsYW4gUHJldmluIDxhbGFuLnByZXZpbi50ZXJlcy5hbGV4aXNA
aW50ZWwuY29tPg0KDQoNCk9uIFNhdCwgMjAyMi0wOC0wNiBhdCAxNToyNiArMDMwMCwgV2lua2xl
ciwgVG9tYXMgd3JvdGU6DQo+IEdTQyByZXF1aXJlcyBtb3JlIG9wZXJhdGlvbmFsIG1lbW9yeSB0
aGFuIGF2YWlsYWJsZSBvbiBjaGlwLg0KPiBSZXNlcnZlIDRNIG9mIExNRU0gZm9yIEdTQyBvcGVy
YXRpb24uIFRoZSBtZW1vcnkgaXMgcHJvdmlkZWQgdG8gdGhlDQo+IEdTQyBhcyBzdHJ1Y3QgcmVz
b3VyY2UgdG8gdGhlIGF1eGlsaWFyeSBkYXRhIG9mIHRoZSBjaGlsZCBkZXZpY2UuDQo+IA0KPiBD
YzogQWxhbiBQcmV2aW4gPGFsYW4ucHJldmluLnRlcmVzLmFsZXhpc0BpbnRlbC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IFRvbWFzIFdpbmtsZXIgPHRvbWFzLndpbmtsZXJAaW50ZWwuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBEYW5pZWxlIENlcmFvbG8gU3B1cmlvIDxkYW5pZWxlLmNlcmFvbG9zcHVy
aW9AaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgVXN5c2tpbiA8YWxleGFu
ZGVyLnVzeXNraW5AaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2d0
L2ludGVsX2dzYy5jIHwgOTEgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9pOTE1L2d0L2ludGVsX2dzYy5oIHwgIDMgKw0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCA4NyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9pOTE1L2d0L2ludGVsX2dzYy5jIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUv
Z3QvaW50ZWxfZ3NjLmMNCj4gaW5kZXggZTEwNDBjOGYyZmQzLi4xNjJiZWE1N2ZiYjUgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2d0L2ludGVsX2dzYy5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9pOTE1L2d0L2ludGVsX2dzYy5jDQo+IEBAIC03LDYgKzcsNyBAQA0KPiAg
I2luY2x1ZGUgPGxpbnV4L21laV9hdXguaD4NCj4gICNpbmNsdWRlICJpOTE1X2Rydi5oIg0KPiAg
I2luY2x1ZGUgImk5MTVfcmVnLmgiDQo+ICsjaW5jbHVkZSAiZ2VtL2k5MTVfZ2VtX3JlZ2lvbi5o
Ig0KPiAgI2luY2x1ZGUgImd0L2ludGVsX2dzYy5oIg0KPiAgI2luY2x1ZGUgImd0L2ludGVsX2d0
LmgiDQo+ICANCj4gQEAgLTM2LDEyICszNyw2OCBAQCBzdGF0aWMgaW50IGdzY19pcnFfaW5pdChp
bnQgaXJxKQ0KPiAgCXJldHVybiBpcnFfc2V0X2NoaXBfZGF0YShpcnEsIE5VTEwpOw0KPiAgfQ0K
PiAgDQo+ICtzdGF0aWMgaW50DQo+ICtnc2NfZXh0X29tX2FsbG9jKHN0cnVjdCBpbnRlbF9nc2Mg
KmdzYywgc3RydWN0IGludGVsX2dzY19pbnRmICppbnRmLCBzaXplX3Qgc2l6ZSkNCj4gK3sNCj4g
KwlzdHJ1Y3QgaW50ZWxfZ3QgKmd0ID0gZ3NjX3RvX2d0KGdzYyk7DQo+ICsJc3RydWN0IGRybV9p
OTE1X2dlbV9vYmplY3QgKm9iajsNCj4gKwl2b2lkICp2YWRkcjsNCj4gKwlpbnQgZXJyOw0KPiAr
DQo+ICsJb2JqID0gaTkxNV9nZW1fb2JqZWN0X2NyZWF0ZV9sbWVtKGd0LT5pOTE1LCBzaXplLCBJ
OTE1X0JPX0FMTE9DX0NPTlRJR1VPVVMpOw0KPiArCWlmIChJU19FUlIob2JqKSkgew0KPiArCQlk
cm1fZXJyKCZndC0+aTkxNS0+ZHJtLCAiRmFpbGVkIHRvIGFsbG9jYXRlIGdzYyBtZW1vcnlcbiIp
Ow0KPiArCQlyZXR1cm4gUFRSX0VSUihvYmopOw0KPiArCX0NCj4gKw0KPiArCWVyciA9IGk5MTVf
Z2VtX29iamVjdF9waW5fcGFnZXNfdW5sb2NrZWQob2JqKTsNCj4gKwlpZiAoZXJyKSB7DQo+ICsJ
CWRybV9lcnIoJmd0LT5pOTE1LT5kcm0sICJGYWlsZWQgdG8gcGluIHBhZ2VzIGZvciBnc2MgbWVt
b3J5XG4iKTsNCj4gKwkJZ290byBvdXRfcHV0Ow0KPiArCX0NCj4gKw0KPiArCXZhZGRyID0gaTkx
NV9nZW1fb2JqZWN0X3Bpbl9tYXBfdW5sb2NrZWQob2JqLCBpOTE1X2NvaGVyZW50X21hcF90eXBl
KGd0LT5pOTE1LCBvYmosIHRydWUpKTsNCj4gKwlpZiAoSVNfRVJSKHZhZGRyKSkgew0KPiArCQll
cnIgPSBQVFJfRVJSKHZhZGRyKTsNCj4gKwkJZHJtX2VycigmZ3QtPmk5MTUtPmRybSwgIkZhaWxl
ZCB0byBtYXAgZ3NjIG1lbW9yeVxuIik7DQo+ICsJCWdvdG8gb3V0X3VucGluOw0KPiArCX0NCj4g
Kw0KPiArCW1lbXNldCh2YWRkciwgMCwgb2JqLT5iYXNlLnNpemUpOw0KPiArDQo+ICsJaTkxNV9n
ZW1fb2JqZWN0X3VucGluX21hcChvYmopOw0KPiArDQo+ICsJaW50Zi0+Z2VtX29iaiA9IG9iajsN
Cj4gKw0KPiArCXJldHVybiAwOw0KPiArDQo+ICtvdXRfdW5waW46DQo+ICsJaTkxNV9nZW1fb2Jq
ZWN0X3VucGluX3BhZ2VzKG9iaik7DQo+ICtvdXRfcHV0Og0KPiArCWk5MTVfZ2VtX29iamVjdF9w
dXQob2JqKTsNCj4gKwlyZXR1cm4gZXJyOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBnc2Nf
ZXh0X29tX2Rlc3Ryb3koc3RydWN0IGludGVsX2dzY19pbnRmICppbnRmKQ0KPiArew0KPiArCXN0
cnVjdCBkcm1faTkxNV9nZW1fb2JqZWN0ICpvYmogPSBmZXRjaF9hbmRfemVybygmaW50Zi0+Z2Vt
X29iaik7DQo+ICsNCj4gKwlpZiAoIW9iaikNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJaWYgKGk5
MTVfZ2VtX29iamVjdF9oYXNfcGlubmVkX3BhZ2VzKG9iaikpDQo+ICsJCWk5MTVfZ2VtX29iamVj
dF91bnBpbl9wYWdlcyhvYmopOw0KPiArDQo+ICsJaTkxNV9nZW1fb2JqZWN0X3B1dChvYmopOw0K
PiArfQ0KPiArDQo+ICBzdHJ1Y3QgZ3NjX2RlZiB7DQo+ICAJY29uc3QgY2hhciAqbmFtZTsNCj4g
IAl1bnNpZ25lZCBsb25nIGJhcjsNCj4gIAlzaXplX3QgYmFyX3NpemU7DQo+ICAJYm9vbCB1c2Vf
cG9sbGluZzsNCj4gIAlib29sIHNsb3dfZmlybXdhcmU7DQo+ICsJc2l6ZV90IGxtZW1fc2l6ZTsN
Cj4gIH07DQo+ICANCj4gIC8qIGdzYyByZXNvdXJjZXMgYW5kIGRlZmluaXRpb25zIChIRUNJMSBh
bmQgSEVDSTIpICovDQo+IEBAIC03NCw2ICsxMzEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGdz
Y19kZWYgZ3NjX2RlZl9kZzJbXSA9IHsNCj4gIAkJLm5hbWUgPSAibWVpLWdzYyIsDQo+ICAJCS5i
YXIgPSBERzJfR1NDX0hFQ0kxX0JBU0UsDQo+ICAJCS5iYXJfc2l6ZSA9IEdTQ19CQVJfTEVOR1RI
LA0KPiArCQkubG1lbV9zaXplID0gU1pfNE0sDQo+ICAJfSwNCj4gIAl7DQo+ICAJCS5uYW1lID0g
Im1laS1nc2NmaSIsDQo+IEBAIC05MCwyNiArMTQ4LDMyIEBAIHN0YXRpYyB2b2lkIGdzY19yZWxl
YXNlX2RldihzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJa2ZyZWUoYWRldik7DQo+ICB9DQo+ICAN
Cj4gLXN0YXRpYyB2b2lkIGdzY19kZXN0cm95X29uZShzdHJ1Y3QgaW50ZWxfZ3NjX2ludGYgKmlu
dGYpDQo+ICtzdGF0aWMgdm9pZCBnc2NfZGVzdHJveV9vbmUoc3RydWN0IGRybV9pOTE1X3ByaXZh
dGUgKmk5MTUsDQo+ICsJCQkgICAgc3RydWN0IGludGVsX2dzYyAqZ3NjLCB1bnNpZ25lZCBpbnQg
aW50Zl9pZCkNCj4gIHsNCj4gKwlzdHJ1Y3QgaW50ZWxfZ3NjX2ludGYgKmludGYgPSAmZ3NjLT5p
bnRmW2ludGZfaWRdOw0KPiArDQo+ICAJaWYgKGludGYtPmFkZXYpIHsNCj4gIAkJYXV4aWxpYXJ5
X2RldmljZV9kZWxldGUoJmludGYtPmFkZXYtPmF1eF9kZXYpOw0KPiAgCQlhdXhpbGlhcnlfZGV2
aWNlX3VuaW5pdCgmaW50Zi0+YWRldi0+YXV4X2Rldik7DQo+ICAJCWludGYtPmFkZXYgPSBOVUxM
Ow0KPiAgCX0NCj4gKw0KPiAgCWlmIChpbnRmLT5pcnEgPj0gMCkNCj4gIAkJaXJxX2ZyZWVfZGVz
YyhpbnRmLT5pcnEpOw0KPiAgCWludGYtPmlycSA9IC0xOw0KPiArDQo+ICsJZ3NjX2V4dF9vbV9k
ZXN0cm95KGludGYpOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgdm9pZCBnc2NfaW5pdF9vbmUoc3Ry
dWN0IGRybV9pOTE1X3ByaXZhdGUgKmk5MTUsDQo+IC0JCQkgc3RydWN0IGludGVsX2dzY19pbnRm
ICppbnRmLA0KPiArc3RhdGljIHZvaWQgZ3NjX2luaXRfb25lKHN0cnVjdCBkcm1faTkxNV9wcml2
YXRlICppOTE1LCBzdHJ1Y3QgaW50ZWxfZ3NjICpnc2MsDQo+ICAJCQkgdW5zaWduZWQgaW50IGlu
dGZfaWQpDQo+ICB7DQo+ICAJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGk5MTUt
PmRybS5kZXYpOw0KPiAgCXN0cnVjdCBtZWlfYXV4X2RldmljZSAqYWRldjsNCj4gIAlzdHJ1Y3Qg
YXV4aWxpYXJ5X2RldmljZSAqYXV4X2RldjsNCj4gIAljb25zdCBzdHJ1Y3QgZ3NjX2RlZiAqZGVm
Ow0KPiArCXN0cnVjdCBpbnRlbF9nc2NfaW50ZiAqaW50ZiA9ICZnc2MtPmludGZbaW50Zl9pZF07
DQo+ICAJaW50IHJldDsNCj4gIA0KPiAgCWludGYtPmlycSA9IC0xOw0KPiBAQCAtMTQxLDcgKzIw
NSw3IEBAIHN0YXRpYyB2b2lkIGdzY19pbml0X29uZShzdHJ1Y3QgZHJtX2k5MTVfcHJpdmF0ZSAq
aTkxNSwNCj4gIAlpbnRmLT5pcnEgPSBpcnFfYWxsb2NfZGVzYygwKTsNCj4gIAlpZiAoaW50Zi0+
aXJxIDwgMCkgew0KPiAgCQlkcm1fZXJyKCZpOTE1LT5kcm0sICJnc2MgaXJxIGVycm9yICVkXG4i
LCBpbnRmLT5pcnEpOw0KPiAtCQlyZXR1cm47DQo+ICsJCWdvdG8gZmFpbDsNCj4gIAl9DQo+ICAN
Cj4gIAlyZXQgPSBnc2NfaXJxX2luaXQoaW50Zi0+aXJxKTsNCj4gQEAgLTE1NSw2ICsyMTksMTkg
QEAgc3RhdGljIHZvaWQgZ3NjX2luaXRfb25lKHN0cnVjdCBkcm1faTkxNV9wcml2YXRlICppOTE1
LA0KPiAgCWlmICghYWRldikNCj4gIAkJZ290byBmYWlsOw0KPiAgDQo+ICsJaWYgKGRlZi0+bG1l
bV9zaXplKSB7DQo+ICsJCWRybV9kYmcoJmk5MTUtPmRybSwgInNldHRpbmcgdXAgR1NDIGxtZW1c
biIpOw0KPiArDQo+ICsJCWlmIChnc2NfZXh0X29tX2FsbG9jKGdzYywgaW50ZiwgZGVmLT5sbWVt
X3NpemUpKSB7DQo+ICsJCQlkcm1fZXJyKCZpOTE1LT5kcm0sICJzZXR0aW5nIHVwIGdzYyBleHRl
bmRlZCBvcGVyYXRpb25hbCBtZW1vcnkgZmFpbGVkXG4iKTsNCj4gKwkJCWtmcmVlKGFkZXYpOw0K
PiArCQkJZ290byBmYWlsOw0KPiArCQl9DQo+ICsNCj4gKwkJYWRldi0+ZXh0X29wX21lbS5zdGFy
dCA9IGk5MTVfZ2VtX29iamVjdF9nZXRfZG1hX2FkZHJlc3MoaW50Zi0+Z2VtX29iaiwgMCk7DQo+
ICsJCWFkZXYtPmV4dF9vcF9tZW0uZW5kID0gYWRldi0+ZXh0X29wX21lbS5zdGFydCArIGRlZi0+
bG1lbV9zaXplOw0KPiArCX0NCj4gKw0KPiAgCWFkZXYtPmlycSA9IGludGYtPmlycTsNCj4gIAlh
ZGV2LT5iYXIucGFyZW50ID0gJnBkZXYtPnJlc291cmNlWzBdOw0KPiAgCWFkZXYtPmJhci5zdGFy
dCA9IGRlZi0+YmFyICsgcGRldi0+cmVzb3VyY2VbMF0uc3RhcnQ7DQo+IEBAIC0xODgsNyArMjY1
LDcgQEAgc3RhdGljIHZvaWQgZ3NjX2luaXRfb25lKHN0cnVjdCBkcm1faTkxNV9wcml2YXRlICpp
OTE1LA0KPiAgDQo+ICAJcmV0dXJuOw0KPiAgZmFpbDoNCj4gLQlnc2NfZGVzdHJveV9vbmUoaW50
Zik7DQo+ICsJZ3NjX2Rlc3Ryb3lfb25lKGk5MTUsIGdzYywgaW50Zi0+aWQpOw0KPiAgfQ0KPiAg
DQo+ICBzdGF0aWMgdm9pZCBnc2NfaXJxX2hhbmRsZXIoc3RydWN0IGludGVsX2d0ICpndCwgdW5z
aWduZWQgaW50IGludGZfaWQpDQo+IEBAIC0yMjksNyArMzA2LDcgQEAgdm9pZCBpbnRlbF9nc2Nf
aW5pdChzdHJ1Y3QgaW50ZWxfZ3NjICpnc2MsIHN0cnVjdCBkcm1faTkxNV9wcml2YXRlICppOTE1
KQ0KPiAgCQlyZXR1cm47DQo+ICANCj4gIAlmb3IgKGkgPSAwOyBpIDwgSU5URUxfR1NDX05VTV9J
TlRFUkZBQ0VTOyBpKyspDQo+IC0JCWdzY19pbml0X29uZShpOTE1LCAmZ3NjLT5pbnRmW2ldLCBp
KTsNCj4gKwkJZ3NjX2luaXRfb25lKGk5MTUsIGdzYywgaSk7DQo+ICB9DQo+ICANCj4gIHZvaWQg
aW50ZWxfZ3NjX2Zpbmkoc3RydWN0IGludGVsX2dzYyAqZ3NjKQ0KPiBAQCAtMjQxLDUgKzMxOCw1
IEBAIHZvaWQgaW50ZWxfZ3NjX2Zpbmkoc3RydWN0IGludGVsX2dzYyAqZ3NjKQ0KPiAgCQlyZXR1
cm47DQo+ICANCj4gIAlmb3IgKGkgPSAwOyBpIDwgSU5URUxfR1NDX05VTV9JTlRFUkZBQ0VTOyBp
KyspDQo+IC0JCWdzY19kZXN0cm95X29uZSgmZ3NjLT5pbnRmW2ldKTsNCj4gKwkJZ3NjX2Rlc3Ry
b3lfb25lKGd0LT5pOTE1LCBnc2MsIGkpOw0KPiAgfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2k5MTUvZ3QvaW50ZWxfZ3NjLmggYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9ndC9pbnRl
bF9nc2MuaA0KPiBpbmRleCA2ODU4MmY5MTJiMjEuLmZjYWMxNzc1ZTljMyAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3QvaW50ZWxfZ3NjLmgNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2k5MTUvZ3QvaW50ZWxfZ3NjLmgNCj4gQEAgLTIwLDExICsyMCwxNCBAQCBzdHJ1Y3Qg
bWVpX2F1eF9kZXZpY2U7DQo+ICANCj4gIC8qKg0KPiAgICogc3RydWN0IGludGVsX2dzYyAtIGdy
YXBoaWNzIHNlY3VyaXR5IGNvbnRyb2xsZXINCj4gKyAqDQo+ICsgKiBAZ2VtX29iajogc2NyYXRj
aCBtZW1vcnkgR1NDIG9wZXJhdGlvbnMNCj4gICAqIEBpbnRmIDogZ3NjIGludGVyZmFjZQ0KPiAg
ICovDQo+ICBzdHJ1Y3QgaW50ZWxfZ3NjIHsNCj4gIAlzdHJ1Y3QgaW50ZWxfZ3NjX2ludGYgew0K
PiAgCQlzdHJ1Y3QgbWVpX2F1eF9kZXZpY2UgKmFkZXY7DQo+ICsJCXN0cnVjdCBkcm1faTkxNV9n
ZW1fb2JqZWN0ICpnZW1fb2JqOw0KPiAgCQlpbnQgaXJxOw0KPiAgCQl1bnNpZ25lZCBpbnQgaWQ7
DQo+ICAJfSBpbnRmW0lOVEVMX0dTQ19OVU1fSU5URVJGQUNFU107DQo+IC0tIA0KPiAyLjM3LjEN
Cj4gDQoNCg==
