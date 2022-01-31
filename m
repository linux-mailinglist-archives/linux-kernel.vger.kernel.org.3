Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4094A52EB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiAaXKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:10:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:60963 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237115AbiAaXKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643670644; x=1675206644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PaqIcr/U46OG0g14aZZ54rrQ1Q5zPYR2K2/0Uceam0M=;
  b=UfJCgLHhwtUeY3CpgVqyeVsyVsRUISCkTTEqVTTgHvD4ud8IaxpXM6BP
   FES4z/OpBsjQxuPWsDTM8ViCfz4u8ojPnCxi/h9m/W2NYxlXRNJ7+V4FO
   5h5LCMghD0nMQYOTnahWE7HziVci2J0h2YYSTVAYAuU92wzj/s8JC8Dmq
   8R1OtHOz4J/0wab4QS0LymNagILw72HUdeDtq/A1oZuY68DYZIzXBzQP0
   Izq6/1Rqnqd7rqxy3kmv75h2YbvDZfGVaAKMyjrgAav+H+CRzJS60T/eM
   6PAoK72N2pp+Upm8xs7g3BkMGhfMjOtnYqTVTX3ERg6qvT06wgZ51bIio
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="246404587"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="246404587"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:10:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="522834866"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 31 Jan 2022 15:10:43 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 15:10:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 31 Jan 2022 15:10:43 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 31 Jan 2022 15:10:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lau75Y8+okMPdM/fpYkVWo+zMbQnJWTh0+zWqPhL7uIQL0Mb9aoZ8WgqT9d87sC9Cj+TmbSkkBPfBoeiHlE89oM86dgNYrCJvpiYCkaz3XSrBo+h/0UvLR+phyaRePk69P+LZP/Xwe2TqqMfMNMsD92Y/UfLPr4K1dL9dbO+R6HVr11+m8iWwmJG3dmSkrC6koY0IVDFn7aoxiwrcFVLH674m4nsAvumDvuDX+ypc+bykz0rzL0vuHRMPSjq2GCExc6MXg4x8oLMf5QI80t6zFCDXzwWl+5K/OnGRhvigl52TDWixV6LcKPrl6u4FpSxWtE2X/sRjjtHw6FUvEwgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaqIcr/U46OG0g14aZZ54rrQ1Q5zPYR2K2/0Uceam0M=;
 b=ixgP/mEXPiAH2RIw7qCtr+MFV6+XzGOA9vfpOFWXq5+olGVMqvGbFRdSyXcrL6svH7GketjmV2XzTN0EEe6qAjhzGcH96osVhBPl3YSe9omt1EwWamie7Y+IKcVAsv+9a6pXb49Micc9vtQc8FfgxeMQKXROwzYaV4efhMcJ7F5n+rkqPCy3haxfekPZ/pO7TMluV3IFX+5SFTTrrU+rPJLH5tL/LzaP5mVUJXwbgf+QDwpIu2Iy5kBz2qaBaUf9e+ofHXlnuTNzUVhlbQPoZXyHAFx4LCr34+Kb1qcyb5+NtJP7B9CyJRbvQCzqEMjDUhLBg45IsQx+RM6/eSiDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BY5PR11MB4466.namprd11.prod.outlook.com (2603:10b6:a03:1c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 23:10:40 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f%7]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 23:10:39 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 16/44] mm/pkeys: Introduce pks_mk_readwrite()
Thread-Topic: [PATCH V8 16/44] mm/pkeys: Introduce pks_mk_readwrite()
Thread-Index: AQHYE6cP9VjBFybY502oRGhU2iIkPax9yDeA
Date:   Mon, 31 Jan 2022 23:10:39 +0000
Message-ID: <a1f74401512ee19176397633aa823f9b6e375973.camel@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
         <20220127175505.851391-17-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-17-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d31d57a-e3e0-4e26-cefc-08d9e50ee5de
x-ms-traffictypediagnostic: BY5PR11MB4466:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BY5PR11MB4466E26A4D3A229E80E9DA65C9259@BY5PR11MB4466.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VZT/O/YRv29PXY/2raBxqmIAN0EoEr4r4+W3CNj+ERZ6ImSK/i7hr18S0AF6ByTV41kqHf+2OvfjsnU+53fd46NKMbrcXR1bRdxCP2K25QFWTGrELKd0mpNbK18tx9iheF4MbivPYXVH3YZ3szu3cE3iY8//ZNDEXl1FtIfq8OJG5K+XhlpfY15fLBGOsOKXcCUSUPLiRXJD2xnMcpJRVgDpGaD+XkgoVU9VgUOOS8PNxc4uphPqXcNjzedJF4rgcMn9PUa3Q4E8Jjh4mt095KvoVzDrL+LXFTeEZ4QomYjnqAB50csOxqgd0hpmZx9EmIK023HGorfILt/w2+/CG+Z0K6PNdcjX/ZYCbQemu2abNWbPYkq8w7XlInwDKo4xG1KdP2j59Wt7SpIlgCxmRbZqWIjIDiO8gKd4hAuOIl1Yb9sg5CxopeBPRZb2Tg8v7vUbjItZlbSqAmY8txS3+yBhdoS5rTotLJvT2ldcBBO7zC2iA1oZ4hGIIHiFcbJy/fSMLctWWIhKeiV4eEgewYkD/V3ps4tXQ12yKat9K1q0msFj9aBUgnmGT0I2CIvokIEmzLkrniJUTX9tg6LRmrTicJwnn42IGZ5uoQpW2388gqnqAOVCNZw39U91/gQWVfIyahhKg4LxmMFe6TBfPg92yEEp8K816hWNIWkyZC0Pzw3pdr94MAsob5IxvwpDaKoDhTAwp9HG93Tpu/GIy4dtGgFtK3bzCFFUAL9qEB4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8936002)(83380400001)(26005)(110136005)(8676002)(64756008)(508600001)(6486002)(54906003)(86362001)(36756003)(2616005)(186003)(66476007)(66946007)(66556008)(66446008)(76116006)(38070700005)(82960400001)(38100700002)(5660300002)(6512007)(6506007)(316002)(2906002)(71200400001)(4744005)(122000001)(99106002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekI0amVvT0xES045N1puSVBMM2xDYXUwdG52cXF3dFRSczR2bnp3a04vOHhH?=
 =?utf-8?B?dm53dEpTaE54ODdRc0ZkbmZPbHFSSjdOZnoxWmtBc05jbVZEaU9UeDFKTEpn?=
 =?utf-8?B?TndvWXNBa1R4RC94cXcvWlBOcnZnRmlnTEJKTnBEcFFLL3UvVFNNT3ZUdk1u?=
 =?utf-8?B?eU1EWTJoYklPTTFMUWthTzVRMERhM1FIOEZhSVFnemhWazNWeG5ZTk0xZkg2?=
 =?utf-8?B?aDFCZ0VLMndWS095TzlQRDR2WUg2bW5ERktrRTZFNVFYUW9Od2xhMTczUFNa?=
 =?utf-8?B?ZXhzcC9hWEJraW1XZFhEL1lDWmJodHpJRE1OeG4veGtIeTBWcGxlRkNidDhv?=
 =?utf-8?B?QVp1Z05kZmY5R1paUjM3UHU5Qmk5VXllcFJVaDdyQnBrNjhQaEV5RkovU2hG?=
 =?utf-8?B?YjBvOStMRkNVWE9lRmZ1VGlISE9ZNTltc3BIOS90YUJoWGUrL3pPZC9IZVJI?=
 =?utf-8?B?a1kwOGdhaGNLd3JqV2Z3clZOcjBNMGZvMGhPbHJjd1l6S2lkeXVTOWV0aTRu?=
 =?utf-8?B?NXFpTno3SHoxYU1Yc3JiYWtYbXh0ZXZHbjJRY0ZLUmdKVTJNZ0RLSndMT1V5?=
 =?utf-8?B?OE42WDd1Yk8zV1Y2T01mWlZmemcwTjRFQW90aGMyakFxWmt2S1p3dklOTGh6?=
 =?utf-8?B?Q0JQNTFtcE1PU1JXdy8rQ21sRjFYOVpHZXZRdzJxcGUzelJOOFJyUFNWWWwx?=
 =?utf-8?B?MUhnOS9mSGlPak1icUo5dy9EL0JKRnRGYmgwbEcvZU9kaWpvTUx3akNsTHpF?=
 =?utf-8?B?dGNjUVJ1SkVTMjEwZ0xzZXozcC9uYmJkTUx4ZlNGcEZkSDBSRG5BMTdzODho?=
 =?utf-8?B?SGJSNVdBVTZWS0N0QlVCazZIZXJUSmtvOFQwZlhkZ1ljOVBQMERNSlJaY2U0?=
 =?utf-8?B?Sk5nSE5JbnJ2NEpTOGVWcUg5VmJlQzVRN3RiZ0RtMGZsTk1XU2EzVHZ5M3BP?=
 =?utf-8?B?d0xvNGdHUUNtYmhGTUhWcExFcmxXS2FodVhmRTBYZ1hlbEhnckFZeUVnYTJP?=
 =?utf-8?B?TXFSMlN3OXJlcXJObVFZTktWbW1SdjBTbnNkVzY1N0ZGU1VlNDlhdzFVdEtL?=
 =?utf-8?B?NFdva3dIS2lxYlM0ME84VFBYOWlHaGJUaHh5MTRaaVowKzMrOWxrQzlyVzM5?=
 =?utf-8?B?ZGMwVnQ3ZWlIUm1KZnFEcTVQbE1WOEE3ZGNqTjBibnJCb0JBWURJZGxIQmhn?=
 =?utf-8?B?SmxGWG1kM20vZlJTK3lVaERoRWxSZG1IaG04UDBkSktQekxEczQ3Q1kvU2w3?=
 =?utf-8?B?bmRzbHV5NFFvSENNT1JaNkFlZXR0dlE3NVFacUpJcHp3UVBhTHJFakVpc2RJ?=
 =?utf-8?B?dFJ5d2QrK3kyaGs4N3d6Q0N3Mi9vRFRLeHIxeU93MmltQytMQnhhOFBOSzVz?=
 =?utf-8?B?dDdQeU1YUDBOWVJKSWpvTlcxT3plQXc3Q3R3L0lLQ3VndExJTzRKOGhxb3g4?=
 =?utf-8?B?OU0vOFU0MWE0SGRXY3ZjQ2ZFWXFyNkRjUDlmRDl1TDJIeUNDRCt3OUF5NHNa?=
 =?utf-8?B?Y1QvK3VpdFZvNGpkbWgwSXFDWDB3VTdOaEE4TlZmZnB0UWUyOXlMNWI3bUs4?=
 =?utf-8?B?ZHMxMFdMcWY2MmcwRHZLT3MyWGdKbTNCd1lTUklhTyt3MVRhbll6dklmd0ho?=
 =?utf-8?B?dWp1c1A5LzNiamRnQWxXdnU2aVFPSUlaVXZZci8ybnBwOWNRdU05NlJuSm55?=
 =?utf-8?B?c1VGblBITzRwQkJmVTdHaElzc3ZLMCtkeTBZd2haZHROOFA4cjVVbnprMzhy?=
 =?utf-8?B?YUhlbEwyZ2J6VURMZWdlOXM0bjdYa2pOVTMrZVJPYk5yRnJiWjFDVTU5dUtV?=
 =?utf-8?B?OUlXMjF5Mk5OOEdGN2l6K2hOb3NaMkI4bTlhZ09uVklHT3VQaElSRThQSWxQ?=
 =?utf-8?B?SWFtK01yT0dHNzViQjNsU3JKVllDRmg3Ynp1ZkNmSHN4Qzh3SnQvY0k5cXAr?=
 =?utf-8?B?dWk0YVg3RW9McU05UU16Z2VJZVNvZ3llVkg0NjBCaG9rQTd4QTFpZWFoWitY?=
 =?utf-8?B?NUcvM2F1UlhINXBXZk4xc1NndGl5WVR5NFNTTUNIbFhGTnpGdk5hSGhEWXVU?=
 =?utf-8?B?SWFkOEJuL2dBQkVHZndBSjdZRXQreFB6Z2lkVDBObks1RE51cVV0NHBkQkhx?=
 =?utf-8?B?KzRIaUtlalFlRkRpc1JGN0k3TUJhOWN5WEFaR0dJYXV1V2VnUWIwQXdzMGxo?=
 =?utf-8?B?SGVjOTNCT3VPRXYzRGswVzB2aEJJeklNY0ZVL2t5Kzh4cUdYTUtUSTZTdk12?=
 =?utf-8?Q?G+4iDz0xjZS8SGX9Rp53oAkeHqZyvQstti/VgHYPW8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFFDAC942B872D4E86F2B46081372967@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d31d57a-e3e0-4e26-cefc-08d9e50ee5de
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 23:10:39.7898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q5RzhisXxjFUjPWacYKcaBgEuN70wKzkMOdX3OJFzkSfROy7HJRMSfPRJVf4gkL4SBrR7q0gJe0i2PhLdVtgCQAMf+xmNNIAf/x+SH6VMOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4466
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTI3IGF0IDA5OjU0IC0wODAwLCBpcmEud2VpbnlAaW50ZWwuY29tIHdy
b3RlOg0KPiArdm9pZCBwa3NfdXBkYXRlX3Byb3RlY3Rpb24oaW50IHBrZXksIHUzMiBwcm90ZWN0
aW9uKQ0KPiArew0KDQpJIGRvbid0IGtub3cgaWYgdGhpcyBtYXR0ZXJzIHRvbyBtdWNoLCBidXQg
dGhlIHR5cGUgb2YgYSBwa2V5IGlzIGVpdGhlcg0KaW50IG9yIHUxNiBhY3Jvc3MgdGhpcyBzZXJp
ZXMgYW5kIFBLVS4gQnV0IGl0J3Mgb25seSBwb3NzaWJseSBhIDQgYml0DQp2YWx1ZS4gU2VlbXMg
dGhlIHNtYWxsZXN0IHRoYXQgd291bGQgZml0IGlzIGNoYXIuIFdoeSB1c2Ugb25lIG92ZXIgdGhl
DQpvdGhlcj8NCg0KQWxzbywgd2h5IHUzMiBmb3IgcHJvdGVjdGlvbiBoZXJlPyBUaGUgd2hvbGUg
cGtycyB2YWx1ZSBjb250YWluaW5nIHRoZQ0KYml0cyBmb3IgYWxsIGtleXMgaXMgMzIgYml0cywg
YnV0IHBlciBrZXkgdGhlcmUgaXMgb25seSByb29tIGV2ZXIgZm9yIDINCmJpdHMsIHJpZ2h0Pw0K
DQpJdCB3b3VsZCBiZSBuaWNlIHRvIGJlIGNvbnNpc3RlbnQgYW5kIGhhdmUgYSByZWFzb24sIGJ1
dCBhZ2FpbiwgSSBkb24ndA0Ka25vdyBpZiBtYWtlcyBhbnkgcmVhbCBkaWZmZXJlbmNlLg0K
