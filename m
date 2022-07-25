Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CEC57FA78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiGYHvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiGYHvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:51:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DB1A189
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658735459; x=1690271459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iqdgb+ARQCGTSwehZXhSQlACB+hT5NCpvC0jJfQi94g=;
  b=JI139GI69I2ZtOYr+9+LmhVHTWvTzxltOrtM5CEojczuDsVi/zyNZ5j5
   cO6cH4IKtx/LBOQ7rZIZD7jcmvzr0ZCC5knrfPMa2FrabUVHzCzN9D0P1
   of5ip1hMs/XLs9FFlxkbjH5RuFZ3+JR7IORYN3tMlRYgs9x8bsezaESgG
   OGeVWvuBzOe5iJCfowzqOs0QTIaQ3UIWXbkubUHyM8ZlVpSa7IVrzwUpe
   JFuy6ETyc9/MDncfjlBlenyLTWGIFY0ITLLyeI5Iisu6x1MrQMtLMT7jW
   TG/6zwW7/AyeJAJCoyPfcZCLuAvGkdnGJpEYj58vrHHjMc15VT9rPx8F/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="270672919"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="270672919"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 00:50:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="702396596"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jul 2022 00:50:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 00:50:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 25 Jul 2022 00:50:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 25 Jul 2022 00:50:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1n4eS3gvde5iqueelnezeI+OC7U2pqIMR8hCuTCJe625kTw1M4njQWC2S8p3jM5nIUytwV4RlIS6m5HWO5Js/IA3RdZzMAS1sdVopL80YMpSFyGAJI7sTbKjpbiCwf2cjpqKcmBLAff/Z94jZKzvtXAhEcAVp6HEU0y4d98ckr3AJgaGwDduYaXO449hJGwh4FLNMqy0gtTYBOppXgHMkOO9ffCRwsGtsn2w81Ug454MTGylZlS4wq/kRPib6+rcVe2zhd2LxwckE3otO/o3fgM3wkTg1DNYxMPyr+hlMN48YIoTYfhToJ5nl1W+SAN0XhYzilf+lNN5L9DssDKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqdgb+ARQCGTSwehZXhSQlACB+hT5NCpvC0jJfQi94g=;
 b=nJ5qJdpx9WP/fuBmu9tLDIWyp1x7e+OUj/A0JZNJSip2LJJRMJJYj/8kTbrbzoIDxF9mgAWoeGodz8ZB1WmwSe7TntfaSl71eOaPTJaWr/OfbkUtox/kHX0t4E6/T4sCxDcxoiNzD13JL1ZUV7bbfIerwFnB8xKDBl/IMvzLBXZACamweBiNQY5/AsUkLMmc9e3RpYovJ7wDTkIUiF1CZFmB6UgZm2i8Sa/BVl3E1LIw5oeLsKcsd8czSBaVbEh7Bd7MftvpVExtWO+C4NW+h/PUddnR0J98pQs9atOh28vfGOobdfvqU8vhWhjV8+yLdGKj+IyWEjNBauwL48fvSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4756.namprd11.prod.outlook.com (2603:10b6:5:2a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 07:50:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 07:50:53 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Zhangfei Gao" <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Topic: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Index: AQHYkC3RawHjE5fI4kOPQdVz+DQ3s62MICIAgAGHjYCAAS2QMA==
Date:   Mon, 25 Jul 2022 07:50:52 +0000
Message-ID: <BN9PR11MB52764D3E07E6755EF52DDC138C959@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
 <20220723142650.GH79279@nvidia.com>
 <bffb6e2d-d310-49b9-0725-37ab4263c22d@linux.intel.com>
In-Reply-To: <bffb6e2d-d310-49b9-0725-37ab4263c22d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41346817-fda4-4003-f659-08da6e126643
x-ms-traffictypediagnostic: DM6PR11MB4756:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QjgvkcAzz9ToaHZ7mXJfzJ/fULzPXT8ukPxkyzY1pn2fW3X86ICp7mI0p6V28dF7ZoGrpp3xpzSYBbomLCn8GGobV7waR1M6BHQR3q9v6kS6muJ5KSccXBvJUWkVKLdK0gMcckPccelGu9U03k1s760rvOIk+42gcS5gLj52cxZzKoSHQ0oZc6HU9h6rdlCwul+5hklno9SD/ShHJ6yVXHUmjyzR8cRsN5AevM0C9xP4tWVtNoAIlSsyz95xUi+eftFF5SPXn9EkrxsWboIKD8KVJKp2c9kQHhA4BOv//viIdgcGJ/Jfllrf0bN+OtYm9cU6gu/ZkB4TcHR7k0mExOlB+q4nDJrlAXIX9X/o8E2DOMjSvii5HEbZd/8UjNBEwlCdga6agqvpJSRNV+IVRuzVQ214ijSPsMXaDEKXtV8X9hB4oKXWtdrOfXrKEYUbOXz2Qfibc3C5wY3u9sGK/jHZaEbJWLjEAyQaxuYhsHmi0dCikqe4opOLIZg9mAcVGueJgf0oXJ2uzISVFeRxrzgm0McxYiZcm3wlvSYYQtGrWfkzGUTZaCXeKxu6lfPUPdUEcwycG373XBplYcFFF2SuwIk2d+MjxBkW9n/8M5uz+kbyzB5YECILD6nt6dbv6elo7+bSr0p+AOnmD7lJ+X14Oht/avpWTq0oqJk5DCbYtz0fMqQJe/JMpAcsQmWd6fW55002jwrzmfcr1K8VAt772FIJJ5vtcO8a8ccXqHEvczNAtXfE0r9dFLWOkT8Ty+A7GJZbD2NneP/3xJsgYcRwX35MjtS6L0LvY9nkwiU2m5GwZXYwLfLBbMNVkIvq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(376002)(39860400002)(396003)(136003)(64756008)(122000001)(82960400001)(38070700005)(38100700002)(110136005)(66946007)(66476007)(66556008)(76116006)(71200400001)(54906003)(8676002)(66446008)(4326008)(316002)(5660300002)(52536014)(55016003)(9686003)(478600001)(26005)(7416002)(8936002)(33656002)(2906002)(6506007)(7696005)(41300700001)(186003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHE1K2J0THBuU3FFTTBNUDJKWGt3azdlcFlkRjBRc1hoWlRyWCtwQ0hQQXFV?=
 =?utf-8?B?bnQvTEt6ckl0MHBFWVRRQVFkN0JGdHRVTFRVMlZWK0d6S3N6QW1OZlg4NGQx?=
 =?utf-8?B?bWJqZUlOb3REUFlKK3pNdFZrcDFJNHNoRkhSQTFqVTc1dmRwTU93K3VFWGVU?=
 =?utf-8?B?bGNLYytkTTFuV1RyZ0RkY1FYV0dLU2h2YmlNZDlaTWhKeGpmL2lOYkIyQWZC?=
 =?utf-8?B?NWcyUmVWbU5JM3VZYWR2NVNzVG5pTHdnOXdtWE4rTGdESDk4a2E0WWd0cjVu?=
 =?utf-8?B?U2puRmlWQm1uSnNORDdNemRYUHZRZEEyQXRVMnd3Zy9LazNSWE15RWZXQlVP?=
 =?utf-8?B?YWlXeVB5dGFLcno1VndLS2JUdjJYdEN4ZTZKeDYwSG9LaCtJZ0x1WU81TGFp?=
 =?utf-8?B?L05xak1sNUFlVTFxMTNUUlovaG1ya2ExODlIYXFNMjFzWWF2QzhhOUYxNHBv?=
 =?utf-8?B?aGt6Y3cwbCs2SzNwSXhjS3hXalZOYkk1NUhNUVhvU1VHU2lHNFM3TEZOOXdR?=
 =?utf-8?B?R1NpRzhLbmh0cTNnMkVDcWJuVmNMbDdMNno2Wm9KUFJsdmxoZXUrZm1ZZDRN?=
 =?utf-8?B?eExTT3orOWoyODA2b2Vnd0ppUmZDcDBmRTVOSmc4WUQ3S1h1ZWxGcXk0dUJ4?=
 =?utf-8?B?am95RkVVZUxoNC82dEcwNWdzTHB3V0k2VnU1WTl3aFkvbW9YTnlDNXJTMXVR?=
 =?utf-8?B?OXdnclhiMlJNekpldjB3YjVYa05wUEV3V0Nydy9ZYklxUk91Qlc4NFNQZHpy?=
 =?utf-8?B?SnhrdjlReXRSdXNKRjBCc0E2WnJVelVJWnhMRUhGOUlSMHhsUlNVTGZWTDBK?=
 =?utf-8?B?aGNFWWVzZDd0V3Z5aHhSRWk3R2NKTVhHV09nb2tjV2FvWGF0WkVDRWI4NE1J?=
 =?utf-8?B?RW1hWXJFODdHemI0UG1Bb0RGVnUxNHN6THIybmN2UlBYeStIYWNIeG5Ua1dG?=
 =?utf-8?B?aXgrU1RGU3V4Q1NES29zVU9LVTRJN2poa0JveFFQTzdrcUZ3Sis2VUF6dU50?=
 =?utf-8?B?U1JwcVQrZ3JLZFFUa1lIL3BWenVydGdGT05RR1BPOWVhNGEydFdEYmsyQXJz?=
 =?utf-8?B?T0l5WGg3NkNMZy9YNVJ5ZkM2NzF5TW8xalE5aUN5dTBzMFpXL1oycGFnNTFD?=
 =?utf-8?B?ak1yTVE3N3daWHpBVjU0bUlwNHlPT1VmSG9XRk5qOGRYTlFBZVlLZ2FhcWNE?=
 =?utf-8?B?RTZyaWFhdEJiRTJvOHFwY1ZpT08zbkswL3lQaGFIV045cXBQTzYvZExMUms1?=
 =?utf-8?B?cFlXZkFvNys0UW9NYTNWMVpGNWVuME5DRU52Q0pHWDlXazkzcFM4bFlFbEJ1?=
 =?utf-8?B?dEdiT3RoMk5RMEhZQkwrcUFFblVGc25mYWxhRHlZZWJIT2xsdGdoWCswbVR1?=
 =?utf-8?B?ZmoxQUdNQjdEdVVCRFRPbVVwWHNvNk9FTGNESHl4aEgxMFNGY1gyOW50c1dD?=
 =?utf-8?B?T2hOa0NNM053Y01mankrTVBJVEprSzg0M3NQRk43WWovRnhGYzRqYWhMNXFr?=
 =?utf-8?B?WmkzQzMwendvVkhGeEd1eW90ZkNCSWRnOFJNZTh0M0RRdG40V1RJNDQ1Ym5C?=
 =?utf-8?B?UzlGNGNKM1h2RkllUjB4ZmkxNzJoSkpVUC9FbVNwWWtXOXVQQ0NnVXZkVE1W?=
 =?utf-8?B?TTg4T1BvTmk0eUErd2RqNExTeUQza1dTS25aN2RRNDdOZ3BXem53U0dHNGFG?=
 =?utf-8?B?NXkyTjV4RXVGcnh5eElSa1MxNXlzcHRBajVXOE1IY2dzVTFRUERaSHJIZFRE?=
 =?utf-8?B?T2pkUUczOGlNQlgvS1UrV1MyWk1iakVlN2JTemNvQlcxZUpSZ3pXVGRxR1JL?=
 =?utf-8?B?WTNnSmpTTWhweHNSOENLZVVCOUVkWnVZelFOL1p2RHpwRURwajRsNFFKK2NL?=
 =?utf-8?B?WFgzdHNsKzZYSkkwNzNMWXdJOFBKSVMwaTgwS3Z4bXJ5d3pIc0UwbGpsR0VK?=
 =?utf-8?B?b2JCaTBzTG9DbmpRdlBrLzlFdERCZS9UV3B0aVpYUmRxRDNYY09hZWhNK3U5?=
 =?utf-8?B?T2VMOG5UZk5CMzFHOC9qeGdua2pLT2NnUWVZNk50eVk1S0QwNDFKYWZETlBX?=
 =?utf-8?B?MWo1dlM0TU5Vdi9pVlpRbVBMbkQwQWhoT0tpZ3YrRTF1ZVUvajhjUytkSVlN?=
 =?utf-8?Q?5Z8yZhw8IouI8owPvZkDlFDEC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41346817-fda4-4003-f659-08da6e126643
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 07:50:53.0074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mGNJ66lMtUd4gJui/YhAeT0pV/JR1Mh+pxEgR23yoYy4peess2ASpPV+1uNeNOfElEPRMof8HmSn5RQlLAbJIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4756
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIEp1bHkgMjQsIDIwMjIgOTo0OCBQTQ0KPiA+DQo+ID4gVGhlIEFQSSBpcyByZWFsbHkgcmVm
Y291bnRpbmcgdGhlIFBBU0lEOg0KPiA+DQo+ID4+ICtzdHJ1Y3QgaW9tbXVfc3ZhICppb21tdV9z
dmFfYmluZF9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+PiArCQkJCQlzdHJ1Y3QgbW1f
c3RydWN0ICptbSk7DQo+ID4+ICt2b2lkIGlvbW11X3N2YV91bmJpbmRfZGV2aWNlKHN0cnVjdCBp
b21tdV9zdmEgKmhhbmRsZSk7DQo+ID4NCj4gPiBTbyB3aGF0IHlvdSBuZWVkIHRvIGRvIGlzIHN0
b3JlIHRoYXQgJ2lvbW11X3N2YScgaW4gdGhlIGdyb3VwJ3MgUEFTSUQNCj4gPiB4YXJyYXkuDQo+
ID4NCj4gPiBUaGUgYmluZCBsb2dpYyB3b3VsZCBiZQ0KPiA+DQo+ID4gICAgc3ZhID0geGFfbG9h
ZChncm91cC0+cGFzaWQsIG1tLT5wYXNpZCkNCj4gPiAgICBpZiAoc3ZhKQ0KPiA+ICAgICAgIHJl
ZmNvdW50X2luYyhzdmEtPnVzZXJzKQ0KPiA+ICAgICAgIHJldHVybiBzdmENCj4gPiAgICBzdmEg
PSBrYWxsb2MNCj4gPiAgICBzdmEtPmRvbWFpbiA9IGRvbWFpbg0KPiA+ICAgIHhhX3N0b3JlKGdy
b3VwLT5wYXNpZCwgc3ZhKTsNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24uIEl0IG1h
a2VzIGEgbG90IG9mIHNlbnNlIHRvIG1lLg0KPiANCj4gRnVydGhlcm1vcmUsIEknZCBsaWtlIHRv
IHNlcGFyYXRlIHRoZSBnZW5lcmljIGRhdGEgZnJvbSB0aGUgY2FsbGVyLQ0KPiBzcGVjaWZpYyB0
aGluZ3MgYmVjYXVzZSB0aGUgZ3JvdXAtPnBhc2lkX2FycmF5IHNob3VsZCBhbHNvIGJlIGFibGUg
dG8NCj4gc2VydmUgb3RoZXIgdXNhZ2VzLiBIZW5jZSwgdGhlIGF0dGFjaC9kZXRhY2hfZGV2aWNl
X3Bhc2lkIGludGVyZmFjZXMNCj4gbWlnaHQgYmUgY2hhbmdlZCBsaWtlIGJlbG93Og0KPiANCj4g
LyogQ29sbGVjdGlvbiBvZiBwZXItcGFzaWQgSU9NTVUgZGF0YSAqLw0KPiBzdHJ1Y3QgZ3JvdXBf
cGFzaWQgew0KPiAJc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluOw0KPiAJdm9pZCAqcHJpdjsN
Cj4gfTsNCj4gDQoNCklzIHRoZXJlIGFueSByZWFzb24gd2h5IHBhc2lkIHJlZmNudCBpcyBzdmEg
c3BlY2lmaWMgYW5kIG5lZWRzIHRvIGJlDQppbiBhIHByaXYgZmllbGQ/DQo=
