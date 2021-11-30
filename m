Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B2D462CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbhK3Gjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:39:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:31330 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232616AbhK3Gjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:39:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="223037143"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="223037143"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 22:36:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="676709789"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga005.jf.intel.com with ESMTP; 29 Nov 2021 22:36:18 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 22:36:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 29 Nov 2021 22:36:17 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 29 Nov 2021 22:36:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdEzOpJG5ZFlFNLjMijn8XBp8Y5x8d7jr/aOSJJHwSb2vW5/gPQXA9YurU5zMQ2mebBUMcubAWdWOz28Z6790ar+OUwRfKVhSsFY6ahml3WQJzbXxWRDf8O9vP5vqL5Ccco/Gj6SOTCq4OztquDAbdKrLjZFsJbNmzSTduyau8aGIcXI+bMPN4F199dYMiemklxgd4Z4EWoQTQqsVoBzr8ZbRRhcJXZfnAVP2zQo7fSQ1y7AKZ7S1Tza61Q4KeknFGrJBFru6Chd/uQ6cR/Df/C4rVf7m7AnCQwcX2N+3RmW7Nl+QKQZWpyKV2e1JzeYlEf21931AsvSzq6b7WBbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPP0zBPJ4uE2hGNcAjYvQwE2bs1qge76KZ3Cz0fH3cc=;
 b=Vxfk/ejDdp/8lZKeJL4z0Opk8gVQ8U/4iCkDTdnMI0c/FxurC0y/AeD/hqV3awaxqr3pCwspctHkElhQqnDrjYIjIjZiQYpRnBytskaWaH3xegZUXwZyAQIVxEcoyU1eeMEbxUkZX0ejtEP4X9z2zZ/WdX0GdjW8mXvtpzRD7OQ+EMKC7rr9q+tsYC4A2HJIhUf4EBGL2zOQV8OVLgTy+MYy8aAqmXrRRv+WnasXVJHEPIwuu1F7zYCdyIeWmeVkDfJyniPoymZm0N8p2T9l7lA0bmfhr9fpaiLa6+c1ybGIwGfW/zDh1ei5nBb+wWxOzh1Lf/Qzo9okO39+2NIKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPP0zBPJ4uE2hGNcAjYvQwE2bs1qge76KZ3Cz0fH3cc=;
 b=D8baK65l4ApAPLq116XmyJ5n5iVsyeRAfcxiCGi8qaloCGCIZE73GmxOD4cNB7wqG8J2vJ5M2/1J5fItk5y0Fm1lgFrHkMe596Vn97tiCjVpv+8gAcPDjBMViBxSimro2D6sZd3xilhi9WDwbs1wnQ1viaopPIj3YeJRJmJ9iNA=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 30 Nov
 2021 06:36:16 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 06:36:16 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Gairuboyina, Charishma1" <charishma1.gairuboyina@intel.com>,
        "Dwarakanath, Kumar N" <kumar.n.dwarakanath@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v3 00/15] x86: Support Key Locker
Thread-Topic: [PATCH v3 00/15] x86: Support Key Locker
Thread-Index: AQHX4XADlpP+POfLMEuHw61BIi8bPawbcX6AgAA0x4A=
Date:   Tue, 30 Nov 2021 06:36:15 +0000
Message-ID: <6A743265-A298-435A-9D59-E3BDCFDCFD1D@intel.com>
References: <20211124200700.15888-1-chang.seok.bae@intel.com>
 <YaWaGfwjLLbrBzHk@sol.localdomain>
In-Reply-To: <YaWaGfwjLLbrBzHk@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3953e00a-c6e5-431c-7bbc-08d9b3cbb5e9
x-ms-traffictypediagnostic: PH0PR11MB5782:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <PH0PR11MB57823E23C1D0725C10AD589CD8679@PH0PR11MB5782.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p/dCDdWqFPs6BF88AzcJcQsJoiucSQNCtoQ3PN7SOKJqvNr1AXJkCkf5HN+DxtKMcU0wgpMzfkpsanDVey2vmQcyp7+2FuOQ4ve8qra0HJSTTbWbgImglJpgVCVEo0OXY92xaswvMUpImzc3AUUBrkE9FWdaG0YtMw+P/w8925/MuVR5iUEQ7gEPQqD0kw+RIVAaJSQ53p6IMoHRYh9CrS6aQ2E91CutznIs5VqF55M/BcrfSBfGwPuJPxia5kAovvcpVWwjyZa064C7jLP97UBT0ODuSJ4l5DZyYV0xRJw7zV+WizedmsLAAWdjdCNEDzEOdiP3FDIoD3J8VTwadUMK7qZjz8pFboma7rKM8uwXncxyh8KtfvJNyWj+K5SRirQRFuLJ7HopsmIL7aj1AMdEVUvUgiXTE/H+GHkLMA1Yd8M6mBUySrxwa33ghxevJhVIgKBYshXUOghpOGV7uShUlCv9c6wI8oX15eYR7EiU3KInSUa9KV6lW0bW14cIN5No2xKDGTWD5fpDKU1HxczFPYn9xGoqD5tVC+JY+m9ckZOFw+PYRVjGA9yCR4LH8CzatRJlDpsQ8dE52yjUTp36Axn7GbRNjxi7q53S/itE0cER9uBgXsdcQOcnQfkhbPsYtAFNoIVB4xSYTRtIjoj1DwAnJWBDT1qVvPB0MIm8oeIV+lrFUbB1UqQAJK/CkFgYkk4yTkDAswfTp+w5T0ST0ODpQz/MI3e4sSacb7cNBqgXls5HZmvBqGZLc8TbcymoecwkVKHdmcgpHLuFoeY8hSVZ1HpdlHyUnCvPDuXk9+ntqF5OC3Gddf9TyUat
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(54906003)(4326008)(66946007)(26005)(66556008)(7416002)(2616005)(38100700002)(86362001)(6916009)(6486002)(76116006)(66476007)(66446008)(4744005)(64756008)(6512007)(966005)(53546011)(8676002)(316002)(36756003)(38070700005)(82960400001)(33656002)(71200400001)(122000001)(6506007)(508600001)(8936002)(186003)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEh4WlkvdjJ1djlaMXpjdVM4Y0w3Q1JWZU8wbXNicmRPNzJhTFFaSGRmRk9s?=
 =?utf-8?B?bjQzdk5yM0kzM0FhUE1rTTJMOFQzZ2sxVTFsd2hnWW40OFFqQ3hnOFJzcVk5?=
 =?utf-8?B?TjM3dzRrTExFQnQ2OUFJOFlOa1JrNXB4dXloajhZTEpZNFZYZDhKUWljb2U0?=
 =?utf-8?B?YzdnTXAxQnJKOVR1Q00yY0lMWFhYdTBwclVPcWwzZXYxajMxUDR6ZlhpWEJB?=
 =?utf-8?B?VkcraXE5QVl4cC94OHhoend3N01GcFVZd2pwWC9VTEF6L3l0eURWWjRoanVG?=
 =?utf-8?B?dWtaTm96aFdySVNhMXdwNWppaE40OXErVzlEcmVHTFNaaEJ6M3lHZ3RPZzdl?=
 =?utf-8?B?Q1czaGJxaG1yNnVDeUFZUk9ZYWFyZENGSkpGM3JaWHNGb253UTZVMzIzR2Nt?=
 =?utf-8?B?Qnk3M3ZLWEV2L2hsS3RzWXRLdHE3VHlGM1FmdHgyQ1hFU09PNnVqS3BDdW5T?=
 =?utf-8?B?S2tzdEZ6SG5FSzltd1l4eHpqNzk0TjlvTGpSVXRrS1FxYUtxUFZUUGRsRnhB?=
 =?utf-8?B?d1BZY3Z1ZEZIdHN6eC9ESUlabDNiSXNadVVHMllnR3VaamJMYWpHSHUvMlNr?=
 =?utf-8?B?Nk1vRTdyeU1RZm5QSzYxYzdMWUx3WFpnNFlPUjU2dEVKTTNOcHloWTJnTkYr?=
 =?utf-8?B?cm5rellLUndPUy94c2JML204VEtPVkhJSElsSXd6eXh0RWlZdlV3aFlNRWNY?=
 =?utf-8?B?dC9KVlNucVJzUnlKQXZ0cXBlWWtKTGxBRU1wcnRkbWdjd0JIOTdFcHlmRlJn?=
 =?utf-8?B?MVQ2ZnJGL3ZPdkM5ck1tZVkrU3NLM3FxMFZpcHlnL1ZYUlUyK0hQd3duSThU?=
 =?utf-8?B?QURBZ3BlbzdLWVZOQjN4d3BUYzdBSjVUZnNZSythRi9oMHU5NUR0V2hkL3Z3?=
 =?utf-8?B?Y1Jzc3dOQ3hVYVJmVmRBejdUNHdpRWI1b0h6M0JVTHhzdTFFeG9RQlBYMTUw?=
 =?utf-8?B?elZmd0Q5eWJkcitjd1plK1JKV292empqMzZVK2kxWWQybnRJZUNnbHpyL0My?=
 =?utf-8?B?bUNqYXlMaHp6YXQ1aWkzbWNDbjdkcGM0REw5aTYzNzlDSklpc2FPeE4vZlRO?=
 =?utf-8?B?YjNhY0hZRWt3NDc1ZVNtUzhjYS9iM1YrVnVEb2M3Y0I3bG9hUFFoZERFMmJG?=
 =?utf-8?B?MlZHd0tvMlJYZXJoWWhPNlVwMGwwWW9RVHg1VjZYbDNPcVQxejlkamt1SlVy?=
 =?utf-8?B?c3h2NEd6ZjlhRG1VWGxwUDFScUlYUllJUHdrSWpBaDZRaWFxdC9WZFBuRUUw?=
 =?utf-8?B?Wi85eW0zMmlmS0NCSDBVOHlxcUwvcm1abDVtTFgrV2xvNmJUQytvenlpSWpo?=
 =?utf-8?B?SVV2cllFbTArVEk0SnNkUDduRzNlOGVCc0M0akRpRFlxSGpPOHN2VmYzQW92?=
 =?utf-8?B?MHR3NmtzdkZnd2VpbkMwdS9XY0pWK1J0Zy9QaVVVaFFNMlh1a1JyWUpKdU1O?=
 =?utf-8?B?UjNhZWxobTJBKy9RdU5Pd3pYMnVoSE05aGZqM3d0Umo2ZEJySnNDY2dseVI5?=
 =?utf-8?B?OGVURFlBaUprYW5BbmRIcUVteWJUVFJ6UFBCN3p3eW9VUUFKalh5SGU0VStr?=
 =?utf-8?B?cURNTS9RRDgrcTNNN0hUU3p5ZXNXWG4wUmVTdnJGMzFNTnVlR2E5SGdsSUgx?=
 =?utf-8?B?WVp1dVNpbWxnNk5uT3RzaS9zaUtIc3VacXV1bUFabm9BZkh5ejFlclJzbVNE?=
 =?utf-8?B?T0VIQncrTG1uUkFoa1hZdXE4TUdJVkRha3Z4WWVpekE3dVlTNmJEZm5HSWpw?=
 =?utf-8?B?UDVWR3pIV1UrSmhINjFwTlNaMHJpQkl5T29PYlhjL29DNUxyeEVWdUFTamJG?=
 =?utf-8?B?OVBycVY5ZEJDaFZpQ2prdjJyNVVIMUg2SUFnRitzMkM4NXQ1ZjdOamtNUjYw?=
 =?utf-8?B?U1NZQnZEV1N0S1J6aXNzME9UOWJ3U3hXM2xDZElmV1pqRGNrb0h1MGFsVXl1?=
 =?utf-8?B?b3hvMnY3UlpWRVhNZVI2SStmTDFVRUR4b1hDdEYwWVhYY2NNeXRSSnlaTWpz?=
 =?utf-8?B?a3FZMis3WnFwdE9lbmpvVDJEb1grYVNxaitiYnllSHFKaHVNaFZqYk5kY3Nl?=
 =?utf-8?B?YXNYZWZkYXV2V0w2eDhubStrRnpxSnJYY1Z5dFFqTnd1akFVRUdoY01FS0gz?=
 =?utf-8?B?T1FoeHcwK2FkQzRwL2RCN1pnZ1d0ek5va2tLVG4ySWRMNHdrdHRWMXdJVDI1?=
 =?utf-8?B?eHI0T1BDcFAzNmpkTitCeHdRQnd5NVBRRWd5WHBlVFllM0M2TWVoT3draXB3?=
 =?utf-8?Q?d2kLG9UIuh+Y3IQAnsG0WSLuZSP3+uVgWyuL5gNH/c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <109AC508D4934C468AC3B250413276DD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3953e00a-c6e5-431c-7bbc-08d9b3cbb5e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 06:36:15.9624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/zRud7m9jiqkrbfAVs7wwqU2t2Hq1SAvafyEew47pyX9gvNrpM88sf0UdMXQBVUUF2xrDpmNj1gPZOcgx2vWa9aqdX5Zefjfu4SkuKarvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5782
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTm92IDI5LCAyMDIxLCBhdCAxOToyNywgRXJpYyBCaWdnZXJzIDxlYmlnZ2Vyc0BrZXJuZWwu
b3JnPiB3cm90ZToNCj4gT24gV2VkLCBOb3YgMjQsIDIwMjEgYXQgMTI6MDY6NDVQTSAtMDgwMCwg
Q2hhbmcgUy4gQmFlIHdyb3RlOg0KPj4gDQo+PiA9PSBOb24gVXNlIENhc2VzID09DQo+PiANCj4+
IEJhcmUgbWV0YWwgZGlzayBlbmNyeXB0aW9uIGlzIHRoZSBvbmx5IHVzZSBjYXNlIGludGVuZGVk
IGJ5IHRoZXNlIHBhdGNoZXMuDQo+IA0KPiBJZiB0aGF0J3MgdGhlIGNhc2UsIHdoeSBhcmUgc28g
bWFueSBlbmNyeXB0aW9uIG1vZGVzIGJlaW5nIGFkZGVkIChFQ0IsIENUUiwgQ0JDLA0KPiBhbmQg
WFRTKT8gIFdvdWxkbid0IGp1c3QgWFRTIGJlIHN1ZmZpY2llbnQ/DQoNClJpZ2h0LCBpdCB3b3Vs
ZCByZWR1Y2UgdGhlIGNyeXB0IGxpYnJhcnkgY2hhbmdlcyBzaWduaWZpY2FudGx5LiBCdXQgaXQg
aXMNCmNsdWVsZXNzIHdoZXRoZXIgWFRTIGlzIHN1ZmZpY2llbnQgdG8gc3VwcG9ydCBETS1jcnlw
dCwgYmVjYXVzZSBhIHVzZXIgbWF5DQpzZWxlY3QgdGhlIGtlcm5lbOKAmXMgY3J5cHRvIEFQSSB2
aWEg4oCYY2FwaTonLCBbMV0uDQoNCj4+ICogUEFUQ0gxMC0xNTogRm9yIHRoZSB4ODYgY3J5cHRv
IGxpYnJhcnksIGl0IGZpcnN0IHByZXBhcmVzIHRoZSBBRVMtTkkgY29kZQ0KPj4gIHRvIGFjY29t
bW9kYXRlIHRoZSBuZXcgQUVTIGltcGxlbWVudGF0aW9uLiBUaGVuIGluY3JlbWVudGFsbHkgYWRk
IGJhc2UNCj4+ICBmdW5jdGlvbnMgYW5kIHZhcmlvdXMgbW9kZXMgc3VwcG9ydCAtLSBFQ0IsIENC
QywgQ1RSLCBhbmQgWFRTLiBUaGUgY29kZQ0KPj4gIHdhcyBmb3VuZCB0byBwYXNzIHRoZSBjcnlw
dG8gdGVzdC4NCj4gDQo+IERpZCB5b3UgdGVzdCB3aXRoIENPTkZJR19DUllQVE9fTUFOQUdFUl9F
WFRSQV9URVNUUz15Pw0KDQpZZXMuDQoNClRoYW5rcywNCkNoYW5nDQoNClsxXSBodHRwczovL2dp
dGxhYi5jb20vY3J5cHRzZXR1cC9jcnlwdHNldHVwLy0vd2lraXMvRE1DcnlwdA==
