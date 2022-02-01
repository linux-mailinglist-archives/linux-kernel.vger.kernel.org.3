Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C204A6358
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbiBASPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:15:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:40952 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232360AbiBASNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643739224; x=1675275224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HmFE2tfJfZMa4Zn1plClua20lbYdYFG1talSHkRXP1c=;
  b=am22Z5lPcuV1Aiy39lyEW7oLdqA8Y1CbIHIl2Z9pIcVBqFKc21jInftW
   sDxOdA3bWVZnUbp5K25ODjFq+4UEvQsIi8N8TMZD+MQgxH3+wnanMTDop
   oXucmD0enp0ZCU+wkzIkbm+3+Og1DEpdg82k8LVOYHhHtI877QdPX/5pz
   IvjLIPeYJJjuCf8P4jYTPCi6yFgolqA/fCdDLCiXUKOEAAe6EWhFy7Y7F
   Yvgpz/DBhmBWcrocEg71Q7amYTRjENwgkBofDT5JUqgeqNYs+pEMnZUxZ
   8p5I0gzsdt+oD80LMnF3hEjei9eAx/CH4K9w7I+g2/G3yeqWTUU4id4/j
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="228412366"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="228412366"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 10:13:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="482478111"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 01 Feb 2022 10:13:44 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 1 Feb 2022 10:13:43 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 1 Feb 2022 10:13:43 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Feb 2022 10:13:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clGaXG5HbmsnLDrsbjLWBp82nI+tyEhSJ2VJc4xrpVWgWmDryXivCCa92Bqg3isosc9JMfHsAd/8cXhvmJHez+a58VspAdPtzS80almGjwuICCG7djeID0G7VCF0kHWEKWoFRyZc+UwKAQb8VnAdg8KwOvGR0UYRQF2XFTQ+vx1rFpIiTWFpe8BZlxomByvBmDT7evIydA87s9w+MDnL8sZ1HIQYeASqghgAiHVBD1qMM6x0V4u9YhIKFB/wV5umtPNoECuzDEx1CJ93R4jDCXXBGinjtt7vFmFmztUP06GDXSY546GQJckzDGBjB2MDGgUk/YDYKhayybkx1/i0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmFE2tfJfZMa4Zn1plClua20lbYdYFG1talSHkRXP1c=;
 b=mcfzyQi0OnRw+oiCzsg04IR7j0WIkRlaKt63mw2SFOPNrQ9MG2mVYmUq/xd9L0gls8GqFcYxFHSnuhjCPqnVNbo8vu3KCu4AEtD9mTXHl+JCNRUiiyLhTKrQsndGbGrCnOGwBtf+i741oy/jrW+ds4YYd0d1d8/H5YtG3sK9ah/l+wMeeLIYNQQ9sMjhlm6GhKVbcchGTa1t9fta4B4ZoktWZ59X9ISCYPi6/kPsjobQ/dszp8pAWueAiXAXoeIIW3KUHjoEuWnzouKIjrFQAMOWOSZRZdPIznHwkowIz4iT7Mmfy7FTBEJJbF/oyhYwFQfoQn6pPZyM5XA29p30qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB3951.namprd11.prod.outlook.com (2603:10b6:208:13b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 1 Feb
 2022 18:13:40 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f%7]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 18:13:40 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 26/44] x86/fault: Print PKS MSR on fault
Thread-Topic: [PATCH V8 26/44] x86/fault: Print PKS MSR on fault
Thread-Index: AQHYE6cSvAinJ1PkIkSVk8TPjaDgIqx/B5GA
Date:   Tue, 1 Feb 2022 18:13:40 +0000
Message-ID: <2a919d9ed8ed874f8b89014c0b42cbadb44d837b.camel@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
         <20220127175505.851391-27-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-27-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 104d3312-8bdf-432e-5dd0-08d9e5ae932f
x-ms-traffictypediagnostic: MN2PR11MB3951:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <MN2PR11MB3951DEE1ABBB72A37F5C9396C9269@MN2PR11MB3951.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6KABP8Ppl7UgrAAg05f93oS9NLZmVlthgMmnJFqtptz3lUt/351VKWOblfx7jsem3GxZbDSnDhM7X/7e/J2vhKdPObAOxE4WcQwouUaNJst8N+dWNqfJl/H81kLJDd4ZV0ixHNrFG5Zw02MFzrP1i2S8jUeFAP4Kuc63mwieeG5jhbVHxfoXLN51wBnW/2wAp1O1JD+nuJz670VKniRZNSY3QSTLp/AFp92M+1Jns9n+QS3IjTZfAemDqv28/NnB5evyYsnRBhDVwvqI+lAHarK5swqJxf36cysi7RoVzymjetijTT+YHXaxCb5+1bu7MkuCUh1uR8w4WI5okNy3HZyDaagAYlphiJ8W5hyfM4EDG+hDGzxeVaj8O+GRRcaVhNEvrWDphaSwGpgPxPNLIhFAC4W0MD5NoxHy2K/o22EmVKQVuc6uS2GdOUV81eozb4pbG10MRimj+040vWXXGCe2GBBgcY7xJR9kAQB52VbE0/2FSw6HWy6ApS4139bL9f6nMPA6VTXWV+HC9OefdLg3Zpy9ojHbqCnI3ZdAUqYg8akgmDHS8HRhUfaqlOXMTyiOVkawy1rISXajTq4M6Jb+Qu/JDjcwuYT4N4GrfAy0xlv/6LedEIam37FPsHuXnWXKuKG6LnQeznnApl7YjAQKV0KvCby9SlKdLwczIDv9Y+vnaFVWqyucqiFrfqdXQrat23YHnRhUSB6mnUjnf21/B/jl5YPLMtg9xAIyS0M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2616005)(36756003)(38100700002)(186003)(54906003)(26005)(66446008)(66476007)(110136005)(66556008)(71200400001)(76116006)(83380400001)(66946007)(64756008)(82960400001)(2906002)(6512007)(38070700005)(508600001)(4744005)(86362001)(8676002)(8936002)(122000001)(6486002)(5660300002)(6506007)(4326008)(99106002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elRjZkhhR1NSUU1SS1QzUXBueHBXWHJ4VjZFN2dOWEwrZ0lMRURsV0NOMDYw?=
 =?utf-8?B?d3RWUmJZZklFT3oxQk1WZUtMbzl1a0p4dFNKcm1IQVNFay90Q1R1MWUzdFdz?=
 =?utf-8?B?U1EzaTUzTnVTbjBOR01WTVhOajBNeThzV3NqcUg4NHM1eEJ2M0NrRE5MRFRL?=
 =?utf-8?B?YzBQL3pldHZvemx4c0VBK2w0RER0QlNCNVB2NVR3MklsNnVFa0RyY3d1Mnp5?=
 =?utf-8?B?WS9waXBhckV5UjBFK08rQVljajZmeHNaOHNJU0VUZFQrZ29qUkdwNUdaa3B2?=
 =?utf-8?B?QUIxbzJYZk5zL0NhemtrMUlQZlV3bEpNdjJ3MjA3NUR1T1BMcUVjWHI5Uk1v?=
 =?utf-8?B?ZjJaYjBTaGp6YkR0cWFTbTQvWVA4K1RwWFpQV3NqVHVPVTFhb1BXd0dUSmNI?=
 =?utf-8?B?eGlTTFJWTGxTeDVOem9reTM3Q3ZEcmZFYnZ3bUNqbjR1am5ybTRoNVBrOC9Z?=
 =?utf-8?B?ZnQ4R2FFWG9heXQvbyt6eWJWV294bUE3cXU1aXlGY0lHd0RkdjRwc3duRUx3?=
 =?utf-8?B?UUxLdnQ3MFg5eThvZ2ZoU1kwcExXSHVnUHlQcS8zUjlUMkRFVE8rdUs1cDgx?=
 =?utf-8?B?TEMyajkraWkyWVBTSkN1UVg1VjU1WGpVSUJ5eFBlaXNtaXp6bGF0MVBCUE1t?=
 =?utf-8?B?cCtMMEJDTWJ4UjhqRHhUSVY1NTlJUzlmNG5TMlJqTnJxN3d6WTVIckpVRUJr?=
 =?utf-8?B?cUdVTTg4SVJUMUZzelAzNDdaVU5rdUJDQmFML3NvenNaQTFaWkovNnZramhJ?=
 =?utf-8?B?bDNDZGllTWZ2NlI3enduMGhkNWdwdG15SndES1AwK0xDWEpxcGVTRU5kSERR?=
 =?utf-8?B?UnloN0hEK3A5Yi81ZDUxYm5oRHpPUEdqUVpha2pOZ0UzQko1WEN2eWk1YUp1?=
 =?utf-8?B?UUQrWFJKUlpLRm5UTmVtRWVkVUthVWIrblAyK3VmZVJiTkVaMlNyNW9DSnZE?=
 =?utf-8?B?ZFN0NnM2dEZhdU1YS1ZYYkFsTEFxZDAyQnV6VnZBUW1weENDc0dweC9mVEt0?=
 =?utf-8?B?eUg4V2g3NjJSWFVxZkdOK0o0V1M2RzlnM0RHaENabEpSSmR5Rzk0bjFUVEZt?=
 =?utf-8?B?ZDg3RnZiNHltMXYyWWVqaUk3ZnJLQ2lkYnd6MHUwSTdYelp5MytMQmNTRzhr?=
 =?utf-8?B?OWQzNU9SSVFadzdreXV4UVNObVU5UGx5eEFTRFhzMnUvZkFzcm83L0RQWFlG?=
 =?utf-8?B?bFo0YVF2S3EyRjA5YTMxK3VzRVpxVThtT2J3NXkxRnkzMGNRL1pkVTFsWEdt?=
 =?utf-8?B?UHdQdUxId0hQdzA1aTFIR3ppd2NIdmJTVS80bEZvZnhBNDZuVy9XVFpOWnM2?=
 =?utf-8?B?ai81WURmTjRKdnVIZnQwWXBGd1hjQUtnVmtiY3VzTXNDc2FydDVmWm9aSkc4?=
 =?utf-8?B?TE9oaVhENFhScHFTbzhBMy9ES0NZdFV4SnBHaXRndlRkVkh0b0hYU3gzTUpK?=
 =?utf-8?B?d1lRWU85TDFySFUzcVRuSG9zdHpQbHZzbVI4akN6ZWY1N3ljc0lqblZwM2xk?=
 =?utf-8?B?aXZESHpZZFhjN2srWXQ0cEx1ODU2RFRtSDFFUWhJVDNHWWJibmcwczI2QkRJ?=
 =?utf-8?B?NWthdXhkdHROYzlXL1ZCZ1NXeHZDU1VQNW1yTllPMm1MWUllQWs4R05naUph?=
 =?utf-8?B?c3dTem10K3hIWDRPL1hKUkVEeWpaK0lWaUhxUnJicURXYkRsaUlkeGhkZStr?=
 =?utf-8?B?TE1seDgrNDMza0E2cU9IcndoenhCdTdBK0cwc1I1SGUxRVBmVG1yNjZuTnkr?=
 =?utf-8?B?dEdkc3dWeGhLdEZiZDBXMENhd0NMZkphMy9jSXFzUFl0WUpHazkrQ1pFb25Q?=
 =?utf-8?B?bHdLemlvMmVYcFF2S2dwYlhZTHZiOFFhTEQ2OUsvM2hVL3lRNC9neFR6ZFNt?=
 =?utf-8?B?R2xEdmVYbExLd3N4b0FaNmtwNWVIYnk5T0hjM0pqLzIvT1pBZXhvQlE1Y1Zi?=
 =?utf-8?B?MFhSa1lhaEp0MDFiRkFlOHk4bFNOdUI2UGptcTZVMVhDTmV5MjJzc3hUL3JY?=
 =?utf-8?B?S2JjTGNhcE1pZW9QcE1idTIwODNwaW9wU1VJNDhBdDR3bFlZcy9wa0d1SVVV?=
 =?utf-8?B?aFNsYmd4Z25JZkhRU2FUaDNTZENlTENmQ3FXVm9OdVZIR2pXdW9yb3BpelU1?=
 =?utf-8?B?aEJkakhNdEFxdy9FOU5JSlQvc2pqQ0E2d0tEbFBxMkpQcWhyT0JYSnVZODZ0?=
 =?utf-8?B?QnIyN0JCUWdDS3hMRjJoa3dhV3paYzNsaWJkNDF1ZGtWYWltV01meHp3bGNk?=
 =?utf-8?Q?k1tQTWCwZZ/FBZuCc3L+cHze9hMzgql+6NbDZC/5QA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA66FF4DF158D448B9B7DBF4D96F9449@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104d3312-8bdf-432e-5dd0-08d9e5ae932f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 18:13:40.3248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5dJIGrde5Ozvq6a3eUitgOkHWjFOgvxqVZEUWKqhIdzFRSZ1l7F+iOfJMg1R7gekdgf1UyzeH03dTOMX/Zm5kPqpCH2rgNuPs3/7n8DiTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3951
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTI3IGF0IDA5OjU0IC0wODAwLCBpcmEud2VpbnlAaW50ZWwuY29tIHdy
b3RlOg0KPiArICAgICAgIGlmIChlcnJvcl9jb2RlICYgWDg2X1BGX1BLKQ0KPiArICAgICAgICAg
ICAgICAgcGtzX2R1bXBfZmF1bHRfaW5mbyhyZWdzKTsNCj4gKw0KDQpJZiB0aGUga2VybmVsIG1h
a2VzIGFuIGVycmFudCBhY2Nlc3NlcyB0byBhIHVzZXJzcGFjZSBhZGRyZXNzIHdpdGggUEtVDQpl
bmFibGVkIGFuZCB0aGUgdXNlcnNhcGNlIHBhZ2UgbWFya2VkIEFELCBpdCBzaG91bGQgb29wcyBh
bmQgZ2V0IGhlcmUsDQpidXQgd2lsbCB0aGUgWDg2X1BGX1BLIGJpdCBiZSBzZXQgZXZlbiBpZiBz
bWFwIGlzIHRoZSByZWFsIGNhdXNlPyBQZXINCnRoZSBTRE0sIGl0IHNvdW5kcyBsaWtlIGl0IHdv
dWxkOg0KIg0KRm9yIGFjY2Vzc2VzIHRvIHVzZXItbW9kZSBhZGRyZXNzZXMsIHRoZSBmbGFnIGlz
IHNldCBpZg0KKDEpIENSNC5QS0UgPSAxOw0KKDIpIHRoZSBsaW5lYXIgYWRkcmVzcyBoYXMgcHJv
dGVjdGlvbiBrZXkgaTsgYW5kDQooMykgdGhlIFBLUlUgcmVnaXN0ZXIgKHNlZSBTZWN0aW9uIDQu
Ni4yKSBpcyBzdWNoIHRoYXQgZWl0aGVyDQoJKGEpIEFEaSA9IDE7IG9yDQoJKGIpIHRoZSBmb2xs
b3dpbmcgYWxsIGhvbGQ6IA0KCQkoaSkgV0RpID0gMTsNCgkJKGlpKSB0aGUgYWNjZXNzIGlzIGEg
d3JpdGUgYWNjZXNzOyBhbmQgDQoJCShpaWkpIGVpdGhlciBDUjAuV1AgPSAxIG9yIHRoZSBhY2Nl
c3MgY2F1c2luZyB0aGUNCiAgICAgICAgICAgICAgICAgICAgICBwYWdlLWZhdWx0IGV4Y2VwdGlv
biB3YXMgYSB1c2VyLW1vZGUgYWNjZXNzLg0KIg0KDQouLi5hbmQgdGhlbiB0aGlzIHNvbWV3aGF0
IGNvbmZ1c2luZ2x5IGR1bXBzIHRoZSBwa3MgcmVnaXN0ZXIuIElzIHRoYXQNCnRoZSByZWFsIGJl
aGF2aW9yPw0K
