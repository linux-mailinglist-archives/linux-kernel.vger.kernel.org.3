Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD25462D90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbhK3Hh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:37:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:47010 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232892AbhK3Hh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:37:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="223044364"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="223044364"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 23:34:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="459496591"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2021 23:34:09 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 23:34:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 29 Nov 2021 23:34:08 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 29 Nov 2021 23:34:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMgXX3O4YMxwxV/sU/mV80oAgBRox1ITCHd4rVK9s40w/ZAXSUE9kSgXbP573KajoLOO24cI+AwNBX4obWd6gdub/QwV3fQ5HlStPc0OQP7Wnh1+wThDLVSZuyaC/0o4xA+5degc5AzPNw/Di1DwDOx9F020oUXlKT51tgk7SMTtTKcTZH0UCOwv83rJYyc8zRneawOL1dDRZxdbsHUA33Ht9Eo8isJFIJsSfjyAOf6x8H6RH45YEBii+7fwBXwbZ8OaaVvOxNTGEOS276zDglCjCPOFKGrZoFvKsPB23CRGvDx0VhVZbV8mw+ypJfXeYqcX/WO5xBnlTI1WXRxnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BccJi855bgs2UmWf2gtBfDxo66KaYDlOofUW+lIfrq0=;
 b=gYPMgt4cdXX6PNLEJCrs6ToseCasyKnCbjaPXLAaa2hS0d61p32yiESVGv8BZjvcKvL4YFFHvsBH615yEfvk64cXrVcYZRaFwpW0+cZbND7XbAQa4AcYyTL/7zXBguEhk9WqEIhDgkqb5l7jE/vhyaHV98ejLcJZXWtDEnp7Luc/4h28XN8ixvdMjK+VOoetCV7bAaH/e/j9ZGEW52MNqYR3i4XrVtFqSdd4GyRlirH1XZDjT2j3JFEqMADilOY4Rv9cghZUBbu0S/dRLKBzw+04XafVfUKffwcX5pLWA3727ujGNH6YONg/Zuws3kRSPMkvIBmEykhEzFG1Whpyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BccJi855bgs2UmWf2gtBfDxo66KaYDlOofUW+lIfrq0=;
 b=rAO4jMbrGqaDb1uDbnWdyBMoxaprcS0M0N3199MrA3DuvFOWaSwNwZNtaiN0hyvZ6DDZxj0TQdnpzYWSrJqCPsPd0+z5FYJFIA1MARqiPmzBRE9rdUYGmKCgFBlFC4xB6L328KzYFM9u1fPDb1+q5bdVRqlBGTF6WjnygsOZvkY=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.22; Tue, 30 Nov
 2021 07:34:07 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 07:34:07 +0000
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
Thread-Index: AQHX4XADlpP+POfLMEuHw61BIi8bPawbcX6AgAA0x4CAAA1DgIAAAucA
Date:   Tue, 30 Nov 2021 07:34:07 +0000
Message-ID: <C16B6863-5D85-443B-A186-0632A6045E5E@intel.com>
References: <20211124200700.15888-1-chang.seok.bae@intel.com>
 <YaWaGfwjLLbrBzHk@sol.localdomain>
 <6A743265-A298-435A-9D59-E3BDCFDCFD1D@intel.com>
 <YaXRf2B+Gz6os3g5@sol.localdomain>
In-Reply-To: <YaXRf2B+Gz6os3g5@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb581e53-01db-426b-e683-08d9b3d3cb3e
x-ms-traffictypediagnostic: PH0PR11MB5808:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB58084D1CAA1FFF281603F311D8679@PH0PR11MB5808.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OwBzFAVnSBq12duSBW4AWOfwJEOPZxp4KHa4HLbxI6yLxv1bZxr4/EGarpKTjtLt4jFddO0aCvYNKeWjDOZWwNYM7l9kOmF7nErAUTE9kn8SydGfW8VDvRJQchfrLZGVNSjQcV1Mf004nTRUcKvVadgvu7dJgL77OzmKPCodrVwzAcpW4on//mWP9fq1fmQmEoQPUiI4vmm95MQdeoevjDBXf3EA+N+rOzWdsuG+hM/Y7YEdSBi2rJijZjsLOJcVVMHIZiDkkJfANJAPal7LlgSmpmFZKwPNVtNC4U9p51P58xkmaAq4W2fHLEc3yQoj9SNe9zYsDaBQ+CZMJwiUrQg/KFhEY+xFzY0OIlmUR2YwY3q6Q8/wNNUUA5f2306g4siwh6+d17gnp7OLXu8UzpKT0sOt4VOA6I5urHI1Cxjc5xXb9n8kJRuUZQaij2fQQDtDwAHfuQDnEDQ6QJIyoWIfyKQDPq6ej8y+PLC5g2qThGDXbuSj1S26xk8dgcK3W0FwfaeeBMzzazi++2b7bscanW1NgY0vRqHZ8sCI9vKAAaePAngiLvre4OJ1OSHBpGFI5TYy7NGBQtRRC2JIqakxJFvGh68wHDNTWc/lO9CLpLpoy0L/IQ7twXARYRLEbSn38n7qq2VrvVnQORZEW8OWJ6nEsfLe2DzlFbSI41n31l2+77BxaCQdTSrSfIe32XKYbuDxyshw9cjjPN12R3Ckmags7HEsdhTacxBGdFk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6916009)(33656002)(71200400001)(6486002)(7416002)(2616005)(8936002)(316002)(82960400001)(8676002)(26005)(64756008)(186003)(5660300002)(4744005)(66556008)(38100700002)(53546011)(66446008)(36756003)(6506007)(122000001)(508600001)(76116006)(2906002)(66946007)(54906003)(86362001)(6512007)(38070700005)(66476007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3NSMjVkSUpEdW1RdlIxd0RnWDR5QkVQOEsxekkrQ3dkU2NMVXgvcDVweDhJ?=
 =?utf-8?B?dFdGQ2ZNVXJwNVZYNmt3V0UxUGNxSm1MUFJoYlVzWWRnK1A1VjlWVXNnd1Z6?=
 =?utf-8?B?bkdDTVczbTFnRnJTdFB5ZHF0NVdjQ05HMUhaWm9WMFVybjVnYmdJZk9WVGtJ?=
 =?utf-8?B?aHJGWVlXRkZIb0NpaTJVQU9UbWhGTVRkWjIxU0FaQkdEOTUyUUd4UmErdHQ5?=
 =?utf-8?B?VkR2dzQzTWNDWXRYU0pFR3BNTEQ2eGRDU29JWHpxN0UzWHlYNWJLczlJWlg1?=
 =?utf-8?B?ZnZjRHRaS0ZnNkZBTWRzeGl1cmlvVXJNeDJ2c2NrSStxWERHaTh6Yk1VL3BQ?=
 =?utf-8?B?T1AzMllrMU9zSk4vMUx0Yzc3M1hTWHhlWVVBdklDZEcvandSQTlHaG4xZGgz?=
 =?utf-8?B?Q0JITlpMdFc4Z1JYL1FkWTdJeTJSM2d2T1RRcUhtWVc5cG5pbDdxQmF3bHVt?=
 =?utf-8?B?bFN1M2pLaHJXckx2Uk9oSHpJZUpwS3ZNTkMwelpGT2RrQzZzdHJSY3JqV0ta?=
 =?utf-8?B?ajQ0ZFhBc3haNFhZbWNIbE5WSDNpbUQ1V01aTUNMZjk3QWEvMkFidUN6T01T?=
 =?utf-8?B?Kytwc3NJdkkzNW5PWlBvSERhVnJmcFNOLzhlRlVNeXExZWZ0YzlTeVBpSVZt?=
 =?utf-8?B?cmpkaDJ4eGRtbEFBVHN6blJlOWNOOEtUZzgwcW1sREs3MjdmcHNkdmFmRWNt?=
 =?utf-8?B?WWFieGNubSs1aXphazZjejZOL1d0WjQ0a2VsQkh2eDBOMjN6SzlET3ZHbksx?=
 =?utf-8?B?VERKc1gvRXZDd1FnOFBDbzQ1bHdwUnp2UnMrQzVMUGlGMVA0Zkp3T3VoK3pO?=
 =?utf-8?B?NDkxVUJLREVzTXFweXMzYjdYckJYbDRFSFB0UkVRdDAzT21CNkI2VlpqZ2ZV?=
 =?utf-8?B?OXVjRVBXMnYxVUppcHZZZUpkMS9MbTI1WE9zUXpSMFNpM0NoUVM2dEN6dW1h?=
 =?utf-8?B?dzNOL3VUbG4yYUcwTU9FaDZjSXNEM3VTV2FZUFAwby9vT0cwT2dGOFU1Qnls?=
 =?utf-8?B?MFFzMWhMNW42VUl2MUZ2cHpBK1g5TGpWWXkvVFpoRFNlSE9ON05kUnRZdzhM?=
 =?utf-8?B?Z1UzaHd2UXBsOVdGYVI4YXJhS0ZHc1cxNkVZUll1MHR1QnRnc1dQQ2VWZ2NC?=
 =?utf-8?B?UnFEMExkdzRldzhmYkN0bEhFZjBXNDFoVE0xT3NPOWJmSXY1OVNjRERuTFY1?=
 =?utf-8?B?Zk1iUFFWUzM4MHh5VndpL3hDbGlJL3NaVUFrYk5HU0RXMjNSSUVlZHBoeHh0?=
 =?utf-8?B?dlJkRlNyRmY4UHhPcDhseXJHYWduS05FRUhMcTQzTjN6OGFZOHhldUFGcG5y?=
 =?utf-8?B?MGlRNWwxVDFLeUp1M2ZjUTZjN1hOeWI2Rkd4cHpIWnBtdEhjbnUrNERqNmtB?=
 =?utf-8?B?d1BEZ3MzS2R6ZlNmdW5sV3FSVFJzUEpPN2tKTlk3VVBEUFI5UHlJYjVTRHFn?=
 =?utf-8?B?eE52bm5OSXBxM20xWUJkS3dBd1NXUFFrTXBXU2hlTWVBbitTVzB6ejhvWUZt?=
 =?utf-8?B?MHNHTUUzNEJOUlY2dDlxd0tMRWlYcnhMVmI0Qll3Q2tsZWs0Ulh1M05IR0Rp?=
 =?utf-8?B?emhOcE44d2JuNjIrd0lVY0VSbnRhbXgzcWE0MmNsUDlOUTFIM1pSMnAzR0xM?=
 =?utf-8?B?bUFGOGZNQ0pnU21waHQreCtxakYvc3dYK0k4QzlVcHFrS3NnV2FNeFVQMDZm?=
 =?utf-8?B?eW41UTd5M2REQ3BNR1NITGp5MXlHQWM2OTBua3VvL1loczljd2dJZDJ0MlAr?=
 =?utf-8?Q?dckyxNnsSNF1nGGPOZGBCHZEST4ZYIeGPb1DHQC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D39092F9793CB043B508AF91E95D315A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb581e53-01db-426b-e683-08d9b3d3cb3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 07:34:07.7032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9l0JhDUACpUZ4YpKs5U1z2jhyWzZWKz5vuz48W7Lr2XGGGkiWd6rGSvZWCcyXMKueiE90pLZkdaYJbTnGC3u/dOPVxeTKS86B/LuJEsYQso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTm92IDI5LCAyMDIxLCBhdCAyMzoyMywgRXJpYyBCaWdnZXJzIDxlYmlnZ2Vyc0BrZXJuZWwu
b3JnPiB3cm90ZToNCj4gT24gVHVlLCBOb3YgMzAsIDIwMjEgYXQgMDY6MzY6MTVBTSArMDAwMCwg
QmFlLCBDaGFuZyBTZW9rIHdyb3RlOg0KPj4gT24gTm92IDI5LCAyMDIxLCBhdCAxOToyNywgRXJp
YyBCaWdnZXJzIDxlYmlnZ2Vyc0BrZXJuZWwub3JnPiB3cm90ZToNCj4+PiBPbiBXZWQsIE5vdiAy
NCwgMjAyMSBhdCAxMjowNjo0NVBNIC0wODAwLCBDaGFuZyBTLiBCYWUgd3JvdGU6DQo+Pj4+IA0K
Pj4+PiA9PSBOb24gVXNlIENhc2VzID09DQo+Pj4+IA0KPj4+PiBCYXJlIG1ldGFsIGRpc2sgZW5j
cnlwdGlvbiBpcyB0aGUgb25seSB1c2UgY2FzZSBpbnRlbmRlZCBieSB0aGVzZSBwYXRjaGVzLg0K
Pj4+IA0KPj4+IElmIHRoYXQncyB0aGUgY2FzZSwgd2h5IGFyZSBzbyBtYW55IGVuY3J5cHRpb24g
bW9kZXMgYmVpbmcgYWRkZWQgKEVDQiwgQ1RSLCBDQkMsDQo+Pj4gYW5kIFhUUyk/ICBXb3VsZG4n
dCBqdXN0IFhUUyBiZSBzdWZmaWNpZW50Pw0KPj4gDQo+PiBSaWdodCwgaXQgd291bGQgcmVkdWNl
IHRoZSBjcnlwdCBsaWJyYXJ5IGNoYW5nZXMgc2lnbmlmaWNhbnRseS4gQnV0IGl0IGlzDQo+PiBj
bHVlbGVzcyB3aGV0aGVyIFhUUyBpcyBzdWZmaWNpZW50IHRvIHN1cHBvcnQgRE0tY3J5cHQsIGJl
Y2F1c2UgYSB1c2VyIG1heQ0KPj4gc2VsZWN0IHRoZSBrZXJuZWzigJlzIGNyeXB0byBBUEkgdmlh
IOKAmGNhcGk6JywgWzFdLg0KPiANCj4gSnVzdCBiZWNhdXNlIGRtLWNyeXB0IGFsbG93cyB5b3Ug
dG8gY3JlYXRlIGEgRUNCIG9yIENUUiBlbmNyeXB0ZWQgZGlzayBkb2VzIG5vdA0KPiBtZWFuIHRo
YXQgaXQgaXMgYSBnb29kIGlkZWEuDQoNCk9rYXksIGl0IHNvdW5kcyBsaWtlIGF0IGxlYXN0IEVD
QiBhbmQgQ1RSIHN1cHBvcnRzIGFyZSBub3QgcHJhY3RpY2FsbHkgbmVlZGVkLg0KDQpJIGhhdmUg
bm8gcHJvYmxlbSB0cmltbWluZyBkb3duIHRvIGV4Y2x1ZGUgdGhlbS4NCg0KVGhhbmtzLA0KQ2hh
bmc=
