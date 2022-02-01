Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BC94A54BC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 02:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiBABh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 20:37:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:5333 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231946AbiBABh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643679446; x=1675215446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rJ8WCMwYF+8Eoi7/9EGqrVeIwdTMUpCUFwQsNF8T6pQ=;
  b=g1mwyG3rQj00urcG/yZd43YGGV7YiEP6S9PDYj4cDZr1lr29KOBGNYKE
   YUnM0uAeSBRqKoLnLM6FnmOLBw9a49eY93/UODI/2SZWM0s4FH1dWZVuZ
   NZKMg1m8/a+hX+uABdr1/cdE1nGMDd68Vla2Yb0u59ba9NgP6QuPYl1AJ
   nHlMEv0Q3kJsYLhxWFQC9lPUX9wL2dVHess92cvW60OcHrszCm7gyEDO7
   MY/Xie/M8CTvfv1VnnmKwIC3bmbFaufvJ03I40JwlbilRW6qMDpXe1z2u
   MhM/mTHpWIHp1liT6E+wKvYLCj02oHNC8Y2EjfHsojDdn/Tgw1Tir5T2H
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="310909945"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="310909945"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 17:37:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="675934659"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2022 17:37:25 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 17:37:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 31 Jan 2022 17:37:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 31 Jan 2022 17:37:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H216rgpPkbyDwU12RsRx27ddlygSTP4wlc0Y2AU2vTxaQN6kQOfqK5nl7AmspBbZYvkv1roertvab/0lI1wV5IPp8lpBI+/jyNmEO1CJV5MuET4co4mmTRLqfmqcbCtjQHFdnWYbU3bUnLrBj5+QqkGignUcqrSW1joqfuoa9+yop3JkwCOtSx976KKl6IGOvh83/mFKSlHlyLqR55T72Ef0BA66eg3Iap+DjWFfpZPiVjlx+K+AVKkJ51I931f4YUzASnBMfjTtwRbpwxfqYMrY5AQoF5sOA5HY2+yymeMYOjIPzHeM5fQXjtzrxh+hnr+CG0G1FYkaHTukGPvlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJ8WCMwYF+8Eoi7/9EGqrVeIwdTMUpCUFwQsNF8T6pQ=;
 b=YPV94hRVuphDaBioDQDDq6o2vYZjEzr54gwkM4XQQsq0PivhwiAZybVUD3UcE7K3v6QRVYzM3xofkiDSDGAdHZycUr/bl8oLGXU1V1uznS1NNdgOHrdHFyGz8QlW943EqPaSJQRAppO/OellzbEDlTgQj+rOY6ju0LsJ0cyoMm33G1JMaf/hHfWN/sTi9KC+zUvVa5mzJNi+D6L9YoTbcfLwvsODkxKAkNe5OaXBL9rLR9h0W3kcf6zQDd0uQ1rmHI8jweZINn0/snN+dSwOIy38sVJLZuj9MVNBelYg/D2CMl8Slr2xb3uhNsDOIv7x442PeUeaSoZf8ZCTxVcp3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MWHPR11MB1327.namprd11.prod.outlook.com (2603:10b6:300:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Tue, 1 Feb
 2022 01:37:18 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f%7]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 01:37:18 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 40/44] memremap_pages: Add
 pgmap_protection_flag_invalid()
Thread-Topic: [PATCH V8 40/44] memremap_pages: Add
 pgmap_protection_flag_invalid()
Thread-Index: AQHYE6cSnuwdnrlTC06thDpgfNFv3Kx98S+A
Date:   Tue, 1 Feb 2022 01:37:17 +0000
Message-ID: <73ee87100ef10af35c99e6b407eac6362c4540da.camel@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
         <20220127175505.851391-41-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-41-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dab28035-88fe-4efe-ac0f-08d9e52361fd
x-ms-traffictypediagnostic: MWHPR11MB1327:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <MWHPR11MB132714D31A11FF608D3918E5C9269@MWHPR11MB1327.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7yQXqKieFVbsvua6kD7y+RxZsWoj3dUbt/SeSdJFcG7uMTxZjpT7obDF0bEr/jixCfZe8T3D6bx3SRH0cJgYhT0+dOEtSyiSAKIxjQvc4itpzY4dR4UX0k7uW3MT3gNyba7eJE8sgYHwgPv1tvO1lBM+YubaW1ZW3f1cQcIZIuONO+kPMkxZpM2qS76CzdZxobw6kZR4mI7R0E1pv2npzGbwu+HAlFA7sXANx26Ep4SPkxmGqWRZEdxIt1TL7yjAh3e1CewlkaxRm6wwhcR6TRlGqvEgScuqjrUBNB0mafEAzLjKauMzpTja81Nv8WIufMjNpPWQYIikYYeROROFH5TyIJHkW5Qne4MouSnxMWlPb0IIq+tW+Er76WP0dp3vgrZyghuGaR17qmMYrpV30x40NsTPqva81uD4cKiJjVloFvX3Qdm8hRW/K7XexMOMnkn64dywTALDdzJCGMgzu8M3qXE3mq+Pr0QMq70Blwm+xZhHe8MFu9tytI4gVf/PM05+uvVh3QG4ErCEiy5dvR0/vNlYqdumpVY1n64TZt/TUlIvs57YsW2huGi8j/XL9B3ag2u8py+VtoD6wRCfEB+Rf/ZQ+GEldOiRlgaoA69yFwk/kaCrsOW+NzCvDyKpN2hBE7uq8eQjPU8Ic2N3Dpv0cG4YyA0V/8djlxN58uLrlvJ7Y8O8B7fF2SmKxkeCX4P96ks0Jd53T7BoCQyEjNMhW6Ud/19OTuaLG9e81Sg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(83380400001)(6512007)(5660300002)(122000001)(2906002)(38070700005)(71200400001)(2616005)(26005)(186003)(36756003)(110136005)(316002)(38100700002)(54906003)(6486002)(82960400001)(8936002)(4326008)(8676002)(86362001)(508600001)(66476007)(66556008)(76116006)(66446008)(66946007)(64756008)(99106002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVlOekhpQyt6THI5MGZtRmkrUVpZT3QxVDN0RE5JbkRwQUdrcmFUQmQzSTFG?=
 =?utf-8?B?R3orVVhQQ1dkdUpIVnFrYldRS3hXTnBBY3JyeTA0VHU5MXZkNmZpVFpjTnZJ?=
 =?utf-8?B?UkZEeDRtdWRKZzBHU2lCOW43OGp2RlZrSVFpbnNjVXdRNzgzY2hIQ0wxdFZL?=
 =?utf-8?B?b1BXVDZGMzJpL0wzQVZQbDA1TEczaTVCbC9TUG1OZG9oMVdPcmZwanYwTzZu?=
 =?utf-8?B?eGlwalJteEM2YUVGa1lvME9MbmsvWktqQzVEYjdmTER5RmtPbDVrUGRhVld0?=
 =?utf-8?B?OWxLaHpCYjJvWE9ZNGVzZmo5MGJaUmlmMkk1QVFTSmRqbG8rZ3pIMVhXSDNi?=
 =?utf-8?B?ME5LZWVUR21JcnlJVi9VUjNvOCsxWWNnY0NtL1VXZWlqTUkrMTJuSy9IQ2pN?=
 =?utf-8?B?R3BwdVZNbVNRWjRPMTdaaVJYTW1qYVF1NU1haTYvT3BkL20xNGhRcjUvUG5r?=
 =?utf-8?B?dHF1azBFZHgvTDFGZjFuQldScXdCWWRUTi81WU5RbDZMQVFDMWxmNlgySHNx?=
 =?utf-8?B?THJWRWxIRHBYbGIzd3RVMHVxaitSdGJIRnRmTWFYcnUzSXhkdzhKU0hPZHFm?=
 =?utf-8?B?U2pCdEZKenVORlBQSDJvNUtIUTVmT0NzUm5xQmFNbW93MTNSN09LMVc0OFlw?=
 =?utf-8?B?TVAyWnpWYmwzaWRxR2hyUGhia2UzUnRVMVhFOUYxNTMvOFl6ODliRVJYYjZV?=
 =?utf-8?B?cDBrU3dwazAwSzhXYlBiUHcyeGM0T200NEdPWHh4UGUyOStqSm5sUEorUEV4?=
 =?utf-8?B?TWY4ZnlZUk16N0l0bEpyZnQ3dit4VDg1WStTRkx4ZjVRcEhkVnRHQTV0RVU4?=
 =?utf-8?B?WXYwRkVicUhwcnBnU1A0RkRHNk96b0FZQ0huRjZSUkNCTXI5UzBvZm80VmJB?=
 =?utf-8?B?cmNXUUE3T0hCbTYwajRLT1ZwNDZZQWNjN0xWUVBzMDZ2RTg0TFZsa2tzMERU?=
 =?utf-8?B?R1E5aHIwMHJDYWNHZFcxZ29SejN4VHV0ZUJzL3I4YlRZVUlocUR4K3Nabldq?=
 =?utf-8?B?b3picC94NmlrYUxjb0pndXFTd0NOVGtUZmliWHJLNnhSRmVtekhRaGl4d3k3?=
 =?utf-8?B?Mko0eXhNb0d0TW5MSTNZNTE5SS8xV1ZVUXBxamtJZWNQd1UxUnlDcFh2ZXhq?=
 =?utf-8?B?eDQxQy9Dc1YvQUpVTmVDMllPL0dzYUN6UjRPMkM2cDdMQjBmdk12TStCWDFS?=
 =?utf-8?B?MUVHWDh4MkU0eno2dHBYSm12b0wvYUNtejh3dUNCM3QyT2NTV2tnV2FsZWFN?=
 =?utf-8?B?bXZGK3UvTzFNR29OL3BVakZmVERQa01mdG5NRXVib0tpLzJLcGFmZGdGeTIr?=
 =?utf-8?B?ZTZaSGZxcTVrY3N2Y25IRm1IL1B1dmJ4aDZ2Rk9uQkR6RUczYzE0VUtyeG9B?=
 =?utf-8?B?bW04Z2lsd21xRnBhbmRxN2cvR1VzcU40SlBUWFZwS0pJTmg4S3pMRWtpaVJV?=
 =?utf-8?B?WDl5TWtZSVdiTWtWY2piT0x3M2xaRlA4OUhYcTY4Z0g4SDFGWlo3WW5CUElV?=
 =?utf-8?B?OHJ3RmdKcjBZSERCT3NENlFaOW0ra2JvRmNEYnloY3lla3BMTlB4Vi96OUNF?=
 =?utf-8?B?emVBN0RpTlZqVndCN1gyUW1jVU1mbkp5QnlPeEU5VTJOOWQxSHM4WUV5RXZB?=
 =?utf-8?B?RUduSjBHTHpNcmhneTFRRlhwcDVXK0FoM1hxdG80Qy82bFNOOWZUc2JEbXVk?=
 =?utf-8?B?V253VldUcDRuTHhTa252RTBYbmlDZi9SV3ptdzJTOXBTZGx0clU4THV3Kytp?=
 =?utf-8?B?Q3djTHExY00rOHgrTXF6WWJSQ2tYeE1kdlQ2NE90alNkdEdBelIrTVdEaU9P?=
 =?utf-8?B?Smxhc3YzbWRscExqb1ZlQ2Y3TUNzTmhDNU5TWWdjUEtkZXdmbWFtZE1OcTg4?=
 =?utf-8?B?K1piczlQeGhRMmozcUZjUjNaOEhWVHZmckprNEk3Y01oZHhUZmhra2w3ZFov?=
 =?utf-8?B?aXF2bzUvM0N3VXV0YVFPSVFJTWxDOTJ2MlZHRlV1TDNsRGhJVWE1QndobDI2?=
 =?utf-8?B?S3FYN2IxeForRGxnNkpVN3RiQTlJTDdmZW1UV0tOa0pCU1g1VW04b0tqT3E1?=
 =?utf-8?B?Q3lsemJZWG9abktiWUFudVdpVy9xVmlTRC9jTjk0eWRIeUxBZVRacVRqNHJm?=
 =?utf-8?B?SXh0TmZOYmdhWTdwZkJQdWNQQThJMkdXRTI5KzVPdkRXYmJrWW40a2puVlc1?=
 =?utf-8?B?WXBxc0piSUsyblNGVVBHb3Y4VERSV0dORlE4UDhoZ0R2YzlzZjNFOS9BU0Rr?=
 =?utf-8?Q?p02q90OS1PRubUgcaQYNUIeCew+8dfPsHIloTCEssw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EB6385AA0C0104CACCE33A1814AB771@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab28035-88fe-4efe-ac0f-08d9e52361fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 01:37:17.9329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: myWf1P1dG4n3/twVyev9E722qZL92MQBi2yXrZfYC8XvQ4UDMGGHJh0nvX0+Ij4BJIpuft7RIWSSRXca1wc2aO52Zln3xssRWg+ejh+lYUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1327
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTI3IGF0IDA5OjU1IC0wODAwLCBpcmEud2VpbnlAaW50ZWwuY29tIHdy
b3RlOg0KPiArLyoNCj4gKyAqIHBnbWFwX3Byb3RlY3Rpb25fZmxhZ19pbnZhbGlkIC0gQ2hlY2sg
YW5kIGZsYWcgYW4gaW52YWxpZCB1c2Ugb2YNCj4gYSBwZ21hcA0KPiArICogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBwcm90ZWN0ZWQgcGFnZQ0KPiArICoNCj4gKyAqIFRoZXJlIGFy
ZSBjb2RlIHBhdGhzIHdoaWNoIGFyZSBrbm93biB0byBub3QgYmUgY29tcGF0aWJsZSB3aXRoDQo+
IHBnbWFwDQo+ICsgKiBwcm90ZWN0aW9ucy4gIA0KDQpUaGlzIGNvdWxkIGdldCBob3BlZnVsbHkg
Z2V0IHN0YWxlLiBNYXliZSB0aGUgY29tbWVudCBzaG91bGQganVzdA0KZGVzY3JpYmUgd2hhdCB0
aGUgZnVuY3Rpb24gZG9lcyBhbmQgbGVhdmUgdGhpcyByZWFzb25pbmcgdG8gdGhlIGNvbW1pdA0K
bG9nPw0KDQo+IHBnbWFwX3Byb3RlY3Rpb25fZmxhZ19pbnZhbGlkKCkgaXMgcHJvdmlkZWQgYXMg
YSAncmVsaWVmDQo+ICsgKiB2YWx2ZScgdG8gYmUgdXNlZCBpbiB0aG9zZSBmdW5jdGlvbnMgd2hp
Y2ggYXJlIGtub3duIHRvIGJlDQo+IGluY29tcGF0aWJsZS4NCj4gKyAqDQo+ICsgKiBUaHVzIGFu
IGludmFsaWQgdXNlIGNhc2UgY2FuIGJlIGZsYWdlZCB3aXRoIG1vcmUgcHJlY2lzZSBkYXRhDQo+
IHJhdGhlciB0aGFuDQo+ICsgKiBqdXN0IGZsYWdnaW5nIGEgZmF1bHQuICBMaWtlIHRoZSBmYXVs
dCBoYW5kbGVyIGNvZGUgdGhpcyBhYmFuZG9ucw0KDQpJbiB0aGUgY29tbWl0IGxvZyB5b3UgY2Fs
bGVkIHRoaXMgInRoZSBpbnZhbGlkIGFjY2VzcyBvbiBmYXVsdCIgYW5kIGl0DQpzZWVtZWQgYSBs
aXR0bGUgY2xlYXJlciB0byBtZSB0aGVuICJqdXN0IGZsYWdnaW5nIGEgZmF1bHQiLg0KDQo+IHRo
ZSB1c2Ugb2YNCj4gKyAqIHRoZSBQS1Mga2V5IGFuZCBvcHRpb25hbGx5IGFsbG93cyB0aGUgY2Fs
bGluZyBjb2RlIHBhdGggdG8NCj4gY29udGludWUgYmFzZWQgb24NCj4gKyAqIHRoZSBjb25maWd1
cmF0aW9uIG9mIHRoZSBtZW1yZW1hcC5wa3NfZmF1bHRfbW9kZSBjb21tYW5kIGxpbmUNCj4gKyAq
IChhbmQvb3Igc3lzZnMpIG9wdGlvbi4NCg0KSXQgbGV0cyB0aGUgY2FsbGluZyBjb2RlIGNvbnRp
bnVlIHJlZ2FyZGxlc3MgcmlnaHQ/IEl0IGp1c3Qgd2FybnMgaWYNCiFQS1NfTU9ERV9TVFJJQ1Qu
IFdoeSBub3Qgd2FybiBpbiB0aGUgY2FzZSBvZiBQS1NfTU9ERV9TVFJJQ1QgdG9vPw0KDQpTZWVt
cyBzdXJwcmlzaW5nIHRoYXQgdGhlIHN0cmljdGVyIHNldHRpbmcgd291bGQgaGF2ZSBsZXNzIGNo
ZWNrcy4NCg0KPiArICovDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgcGdtYXBfcHJvdGVjdGlvbl9m
bGFnX2ludmFsaWQoc3RydWN0IHBhZ2UgKnBhZ2UpDQo+ICt7DQo+ICsgICAgICAgaWYgKCFwZ21h
cF9jaGVja19wZ21hcF9wcm90KHBhZ2UpKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiAr
ICAgICAgIF9fcGdtYXBfcHJvdGVjdGlvbl9mbGFnX2ludmFsaWQocGFnZS0+cGdtYXApOw0KPiAr
fQ0K
