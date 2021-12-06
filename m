Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB9F46AAEC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350385AbhLFVvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:51:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:4369 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236959AbhLFVvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:51:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="300798087"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="300798087"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:48:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="479277261"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 06 Dec 2021 13:48:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:48:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 13:48:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 13:48:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9Dzq8BuA1fzX+sz2fOtngd3WQne08gOrbC5KNJMrBn9VGiAaZNa2XUIArQEOVm45d1iOiN4r1cuRwvgt5FspeRM5jsSyaTHDYnY3qRkzI7p2i6rnub2fovgLqSt/gl/r9YceBz5oSC1ZVPP6FRm2jRoeE7QULhiuK2o/dt2gq8l4jaTZd3v6AhzfBLN8y5e56rvHB5kWZPDg8R5VIZk/xpyH4MQgi//gqsFBTqGzVCleeZLw3i5AIRG1Azmr9ES9s2Cpy+D+Dnsc69zi6TzkJsG28igohrTSWeOKqdTP4bqJpADo+LBaCTnwiAljzlykZqgBVL8fr3WylsAYmJeww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJ689OvwH489r5VLZqc7kv5hlum8oae1qzCHsSD1K2g=;
 b=m6FdpwhBawfJgw7jrJ8fxbnHv9tbYqopttuVWsfvCq7kuSMMHGMaog1bTupfp98CGrEy6whsUxOa2yeqQpmRJ9HwHuh0KoxzAr18PKGr9IOaznlsUZ2qtmnADtfu3S00OzHllw5zjmpoBTnYriF7TCUrCjPp+SOfVMW2OPbGk6lax5gGSINTEduYdSS1ijnZiRDIc33leG+45dfwgzf5VR7xJFhmlUyBfdECAVQqZGAncoBriXvEPz8zue2wMQ54DRwZqQEdcy81A+nNm1btkK6nVKqt8owB9hfl/squtrUPDFpdXoqmI/sa7Ju9w+bQb4Nq+hjkFctaf9I6QBZhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJ689OvwH489r5VLZqc7kv5hlum8oae1qzCHsSD1K2g=;
 b=EiGhxg5Lnwowz6/xkb3Bv6+FuKPYmKQ/vaIMAx6I5sH/UqoXfu8uKQhu9+/NKGOAg367T5irowUJSg2sariyqrw8FFi3O/mdiKKGVQ2L3wTGIOeCRhmTiurqJVut3iP4wcZB3vLbImmtp0OSDyQDRZYAqsWCp0GRdPjRlOTzdvo=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 21:48:18 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7%6]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 21:48:18 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/11] x86: Support Intel Key Locker
Thread-Topic: [RFC PATCH v2 00/11] x86: Support Intel Key Locker
Thread-Index: AQHXSP6hgf4aXmFhiUuqBU4d/omVPQ==
Date:   Mon, 6 Dec 2021 21:48:18 +0000
Message-ID: <C011ADB3-3B49-4865-B988-9F682F462F32@intel.com>
References: <20210514201508.27967-1-chang.seok.bae@intel.com>
 <9f556d3b-49d3-5b0b-0d92-126294ea082d@kernel.org>
 <C08CCADB-864B-48E0-89E0-4BF6841771E8@intel.com>
 <247d9a25-f32f-d01b-61ff-b1966e382907@kernel.org>
In-Reply-To: <247d9a25-f32f-d01b-61ff-b1966e382907@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ede25012-aaed-4d8e-84a9-08d9b9021d51
x-ms-traffictypediagnostic: PH0PR11MB5160:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <PH0PR11MB516037AB0E7F4972171C6118D86D9@PH0PR11MB5160.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wbrHLbUBnGhVN8901ch93I/19m9sECji3khHhflWQOHFw62vkfj43rosaLJP3bkMi52yuhLHvO8r6Cel5/QehsB4Rq5OHR5UNuj9O9BTr2U33+plbqsQOSsmIKSUUXWbIOxeQszX3xu+mSxLcHX06NNoWYgRRahExPKlHKFmWk68Z9W2HRDQGBCOGZs2GC8Wu8awyYI+/qLkC+56INYYYgiVyn5/ymy80Y6o/PTStFT9w3Ru0K6TMqZOFVTKphDmLRoQomaTNLZt5cH9PeEFJ5UTG2CUMhNeIq5bL0SEG2sL4tV3Y7uZXzVfCi5kV/BBLRqSY87YET8M4y471LZPc7S6hYVoryv/MCMMULKsUCaePeaWMK4Mox68poWc2IVJSoPw54uaEr5T65iOQPyZuwTLLIk23tGwqhYneys/4oRxOJJXf+Vby3ZSJ9a6aojtQLuKzDZVBIBh9tkSXuZGqEae+JNvV43T+croMtVKSopIXY0QT8Yl/RV3JfMS1DOV20ixlrUfT+hfdISBoyPa/JvsZbw8zumcV3ohfBucy4XwPzuMYT7OThP9fD4DTkWNYZJudcUBNf/KCL8QtQs5sztMOyf5dvF9psQT0NZcRsQ5BSNlSb2JLC+xDkMoeNQVRijiB90yqhedBWgHSMmk/I3ef2cjMHVTtyY+s9iljqNw3P0KLl3kD9KrD6hP0et9igf9t8yPNNMvvpDwSXW+v9tMCL38l7ghKRHthIuLSa/oE2Ak0K0sgLyDX2vhsLzFiWa9QB8glC7lqi9RnrusBZOShywx2M7onPqARQJV7LuLIgO70YXdNntLUUl0nX+u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6512007)(36756003)(38070700005)(508600001)(966005)(122000001)(186003)(38100700002)(86362001)(6916009)(26005)(2906002)(6506007)(4744005)(53546011)(5660300002)(54906003)(8936002)(33656002)(66446008)(64756008)(2616005)(316002)(82960400001)(66946007)(71200400001)(76116006)(6486002)(8676002)(66556008)(66476007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3NteDdDOFVRUDR4SDdGZFVaRFNvN2NXRlFXREd0MXlJc0ZuRHNSdy96dHBM?=
 =?utf-8?B?T3JndC82U2d2eHV2SncrZFFidVloZ2RuVW04Ui9RWnVkTXFZZjlra09CUXI3?=
 =?utf-8?B?WThrOU1oRUlpbkVNRG1VaXVmdElDaGM2OTZmWEc2dzFjazd6NFBpZm81ZmtU?=
 =?utf-8?B?Z3hIaEEzVThNVHd0TjAvbnpLTmIwekJxTndaZHBONmJXT0R4a3FCOENYeS9o?=
 =?utf-8?B?SXhZR3NvSWNxRXdibzVXUDJId2dvWWM4Z2NRQThtYUc0RVhxRk5NREZsckdX?=
 =?utf-8?B?VkkwVXVkVGQ4U3g4TGkzVEd5NUR6cDdQSXg3STNpVEY5bGVXSk9QY2VFYnJH?=
 =?utf-8?B?cGJGMm5CL1hkRWtHSy91R1VtQWdoUkpiSzcvVUN4ZjBKa1Z4Y3diUm9wNkRq?=
 =?utf-8?B?Vk9tVmFFbzZzTEc0dlpxUCtkU3hjdisrdU03WXZ3NG53UlMvMmVoSko5Nlg5?=
 =?utf-8?B?eW1adHJPVitWcHNyNXIvZXBQNXM5aUVuOElmS242M2lOVzh6UUk5YklsbTI3?=
 =?utf-8?B?U3NGUlNOVjIrK1J1blJscXRZQ2VkRThTUkx1OUJHcHhDV1dRWVFpYWhkQmJ0?=
 =?utf-8?B?Q3ltZkp2SXAvdmRHVTFtNWdZSkptVWFxbmlneHUxWDl3UUtBWDJZeSsvNXND?=
 =?utf-8?B?RUZRemhiZnlySjNQNGJIQS9EVjJCYWFaR0IyY0l5TFdjVmhWZ3kxNUJJQ2hX?=
 =?utf-8?B?OCs2RTNjTEszZUZneWRFL0hUM05HZjk0L3NqZDZKSHp2QThlWHlmRndXVWRJ?=
 =?utf-8?B?T3JzR20xQnpnMGRZdlhNbkNpVzAwcXhySVN4eU1WbVQyN0JnS1ZSZjJERGlX?=
 =?utf-8?B?OHgzaHJoTUxEYVBXRFpDWHhZaG80bno2SFBLdkkreHEzZG9Oa0VXMGFUKzNm?=
 =?utf-8?B?WTZ5WmhTT1I0bUVQMXU3VVhhOFFkcXp1R0cyM000MU5FT3ppZ3ErUFZTZXJY?=
 =?utf-8?B?T0pPWlhpbGxyNzdwdnNFVE80d2QrOGh4emdnTHI3cEc5alhrVVZlRU5kZmdU?=
 =?utf-8?B?TVhBVjIramtPYWJ6RG1RaExNaHo0dWw1bElWRCtyTWs0TURkdGtCbHNOT210?=
 =?utf-8?B?cDkyaSs5cG1acUZGek13ZnFhbnFVZ29jcy9nMkFaL2ZDdm8zR3RKc3V1VGhj?=
 =?utf-8?B?RGl6eVNrTkJhM2ZtbE9DU1JLZnptQlRkZ3F1b1JHUUFMa3lxZEczOUd0VkpR?=
 =?utf-8?B?czhvc1VUbEE0WjhMbXByLzVyN1l1VlVyeDgyMGwvUGs2cXRHbVYxZlFSN0Fx?=
 =?utf-8?B?YWlmRzVLQlFjaElsRFJTaWlwdWdXK3N4bUVtdGp0dGJjYzR0SGkzQUxzaDgv?=
 =?utf-8?B?czdyeUloS25CL01NQ1NjcUZzSWhJQVhGMFZ3dURDMUtJYmNQODBFWGlYV01v?=
 =?utf-8?B?cm14ODVTK0JEQ0Nia1Urcm1HV0Njdmw1Qkh3NHl6aTN0dzh6ZXRBVWFCM2JK?=
 =?utf-8?B?MnhXaitBTTdkR0dYdWt4eVgvcnpvWEFGOCt6Titibng3U3BFNElDZmtzdW83?=
 =?utf-8?B?UUJ6N1h3NmdHenJKbTVrWTVuNHk4U1ZFN1A3RklOaExHR1NaaXpRbG04Y0xS?=
 =?utf-8?B?bHFSZmtWb2liS1ArUmJHdi95SDNKallvK3BCQkE4STZBa3lKUWlhU2phYkRn?=
 =?utf-8?B?YUpaUmhGMlVwVHNiOEEyVVJXYVQ1TEM5SHo4akFoL1BSVkI3VURqOXZwQ3dQ?=
 =?utf-8?B?eFo2dERZUkhmc0NuVEhTWG5mcE0wTWMzekI4WHl3OWVLbHkrSWZQUUw4UFhu?=
 =?utf-8?B?V1ZEM3pzVXlZV2RaL3F0a1pVVUFYTThzeFBUbWRoZDh0OU9hTENBbUpvL1A1?=
 =?utf-8?B?d0pPS0NyM0tQQ0tLREtzcGgwYWwyYlhMcGZ2MjFsNDI4MXEwSHMyL2JPMkZ5?=
 =?utf-8?B?ZmorQzFkVHMwRXEwMmplS1hvMVNoVnE3SXpBR3ZTM2NrMWJPbU4vWHM1SnJj?=
 =?utf-8?B?NG84SE9LWWZRVXo5TXNOWWMrL1Y0T2YvR0x5RnVnRU5kdWJ5LzVqM0cyM3Uz?=
 =?utf-8?B?MktFK3RIMnhxUTVHZEU0RVI0UERtTkIrR2xaZ2ZKcmFLMmhibXZjUHM1TTBD?=
 =?utf-8?B?OFdZYnRMcDhJS1dNQ28zMHNvVG1lQ0c1TFRLVVBPSGc1UDRZV1JIZDRYcm1V?=
 =?utf-8?B?NVgzYmVLL2RNM1hOZG45WUpNWkZRd3pJWWZveWJxZ0dNaVcwbDBXN1ovcWl0?=
 =?utf-8?B?Y3AxMnd4NVJyRW96SHJDak9NNWdZUWRCWEJqTFZVM3FLRmF5UHdubEF4ZmpG?=
 =?utf-8?Q?cCntnZEDhVz6bEkfoHtEVk7nzrd0nXtSC9cMMJui4M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C72BA0AF3BCE24FB2906A6469322366@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede25012-aaed-4d8e-84a9-08d9b9021d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 21:48:18.1341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICaqng6by8MgmVAbx1I2S7dKCT+6WP9vWMq8lIAWF8eOXtJUozQiCKNr5rX5qoNoSSC/MTYG3T8WQbpzraVUmjG2/d+0NEDdnTTkDCah4/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5160
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTWF5IDE4LCAyMDIxLCBhdCAxMDoxMCwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5v
cmc+IHdyb3RlOg0KPiBPbiA1LzE3LzIxIDExOjIxIEFNLCBCYWUsIENoYW5nIFNlb2sgd3JvdGU6
DQo+PiBPbiBNYXkgMTUsIDIwMjEsIGF0IDExOjAxLCBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4gSSBoYXZlIGhpZ2gtbGV2ZWwgcXVlc3Rpb25zOg0K
Pj4+IA0KPj4+IFdoYXQgaXMgdGhlIGV4cGVjdGVkIHVzZSBjYXNlPw0KPj4gDQo+PiBUaGUgd3Jh
cHBpbmcga2V5IGhlcmUgaXMgb25seSB1c2VkIGZvciBuZXcgQUVTIGluc3RydWN0aW9ucy4NCj4+
IA0KPj4gSeKAmW0gYXdhcmUgb2YgdGhlaXIgcG90ZW50aWFsIHVzZSBjYXNlcyBmb3IgZW5jcnlw
dGluZyBmaWxlIHN5c3RlbSBvciBkaXNrcy4NCj4gDQo+IEkgd291bGQgbGlrZSB0byB1bmRlcnN0
YW5kIHdoYXQgcGVvcGxlIGFyZSBhY3R1YWxseSBnb2luZyB0byBkbyB3aXRoDQo+IHRoaXMuICBH
aXZlIG1lIGEgdXNlciBzdG9yeSBvciB0d28sIHBsZWFzZS4gIElmIGl0IHR1cm5zIG91dCB0byBi
ZQ0KPiB1c2VsZXNzLCBJIHdvdWxkIHJhdGhlciBub3QgbWVyZ2UgaXQuDQoNCkhpIEFuZHksDQoN
ClYzIHdhcyBwb3N0ZWQgaGVyZSB3aXRoIGJvdGggY292ZXIgbGV0dGVyIGFuZCBjb2RlIGNoYW5n
ZXMgdG8gYWRkcmVzcyB0aGlzOg0KICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAy
MTExMjQyMDA3MDAuMTU4ODgtMS1jaGFuZy5zZW9rLmJhZUBpbnRlbC5jb20vDQoNCkFwcHJlY2lh
dGUsIGlmIHlvdSBjYW4gY29tbWVudCBvbiB0aGUgdXNlIGNhc2UgYXQgbGVhc3QuDQoNClRoYW5r
cywNCkNoYW5n
