Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5911F47A361
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 02:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbhLTByY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 20:54:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:17573 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237009AbhLTByW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 20:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639965262; x=1671501262;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wFQ3oGfAp70QTvZmkKjNxzG43mIt7ucpXRAD3b1pb0k=;
  b=OC/KJoxtprK+/MV0WZ67bt01012aZigzuniC4oFlmbT35J7hSJ142a0+
   d0ifRdkQKDfmPTeTeH9tvZSmoCo6+kOKf71Uocdr/b0SzgyS/thpy/QYz
   nSS1xJd6xch99Qql8BeUj0+2VzaJw34PBHiPjMB5AUXb9bCKimWhkrJTD
   hqSgp7QAtO5ZM5/koDBcDfGy1eHonPGjgT/QEIUqfTI7qfqJ2fxTfV3g/
   A7H+aHW90cXsoV8P5SmIQP2ULtact4OjBH2JqP2qYCr+hoDbOBJG7C/kq
   GyNbhnYE1lRibBOb17hz8R4BFtAuzRHM/+vlDTOCi92Y3aw3NFcuGWUWU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="238821453"
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; 
   d="scan'208";a="238821453"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 17:54:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; 
   d="scan'208";a="521247870"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga007.fm.intel.com with ESMTP; 19 Dec 2021 17:54:22 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 19 Dec 2021 17:54:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sun, 19 Dec 2021 17:54:22 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sun, 19 Dec 2021 17:54:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=me4ptSIRm6iyJiaRZEhIuWbjPbstoMNknqMSu2hoRfLUZxb+50JyVeEQYLwd4lP4aAUEEUuAwpe89P+yCVNX+2OrToqhmM3dZzu3a8lJotYV1+e04KRUEt1QnTKPSVUPbCcTIhDV59DhfR2bXgndCd2xnWLP/aMtD0f2jaS1k7lIC1nrPT3a8+KMC1L2nuop8f4gHZMGxUV5YcRkHS9yGR+KtH5arDkhX4c6xY/vNLsuV8fwTK3sp5bh/scNJNYV5GL6wQQZ5XQzWSwuIQ9N12k7psKodD723mUbaaKc05024Q60B+YIOakUV9fpiDLkn/j1/oSAXSfgaf5B2q4TWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFQ3oGfAp70QTvZmkKjNxzG43mIt7ucpXRAD3b1pb0k=;
 b=c2TlAxSX67akzst/jthe243knIQQiV1UwlRyPBpFwdCQ0oDKFjTSkyIILOQvMXRhOxUQo2mdHloH2Bog3bksCuDA2KYPqggyMTivuAlgbeqTQGBwHw+os462vEY2pagSL9I70UhSq5tLJyqzM4Jjei0Vq7GyTrIi0WFvTuV9qr+Tr1bHYLgDtVqgiqhb8W+ejzVPQ7gJ2BzzMO9ereYvEUD2BLVanTun6a+wVcXzpvMgJsgB4ON9alwkb6CLE6XViiV48aqL3UkrqUi8oulK4J6jQkwG26q9jyNkyCBdhpB6Opf4Fa6rJgQeM5q4KUdg8Q3nncaLY0gw29qFoek4dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH0PR11MB5000.namprd11.prod.outlook.com (2603:10b6:510:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Mon, 20 Dec
 2021 01:54:20 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b821:aef0:2208:7d1f]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b821:aef0:2208:7d1f%3]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 01:54:20 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Waiman Long <longman@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] locking/rtmutex: Fix incorrect spinning condition
Thread-Topic: [PATCH v2] locking/rtmutex: Fix incorrect spinning condition
Thread-Index: AQHX8xmfto9cD4Z770uMSCbPYAz7oKw6Uy0AgABOn4A=
Date:   Mon, 20 Dec 2021 01:54:19 +0000
Message-ID: <PH0PR11MB58807AA009DFAAC1789ACDEBDA7B9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20211217074207.77425-1-qiang1.zhang@intel.com>
 <71c5ca50-1bf9-4ef7-eea0-634f66838d4a@redhat.com>
In-Reply-To: <71c5ca50-1bf9-4ef7-eea0-634f66838d4a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52b9659a-48a4-489d-131b-08d9c35ba364
x-ms-traffictypediagnostic: PH0PR11MB5000:EE_
x-microsoft-antispam-prvs: <PH0PR11MB50001E88B001604758055667DA7B9@PH0PR11MB5000.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M60uVdjQWzI3Gdw2+jkJFruEgDMsIm/4pT3/hyd3qk/opSonKj+sza8IQFTQ5kMT3iVQQ3ZLhmSiDwgWSNpB8IpDFuFw41SJBC8vBmwz32NIOdBJpfus+HcuY0ZTd44Big3ITtH9Mm6bLzA+GKPTxXFRwT3AWTO2q40JygZGrAh3Y+74edMA2Tm80F9rqO8+w/KYYhk//xGeFxijugSHFfqKs5EFiDq4FfYWlUMAsZrlB+7jgy6j00y58mlH9gH3do1igAYAr88uvOsd7yLlGUal+ElbbI3wuwoBRBuhzSUw7ye26I9M1CCI3GisF1YJkql6g6bzNGy0EiLimVI2BHx6V0T1Wb47WXqxU+KbQDNWblhNNlbWwcUFPoD1d8JtX3nq01hgDJ+u6+jS7fuB64a+oRSEg4txpaIDLQVDA63H8OH6Bqhi8482RbMQ7JxHToLU1sh3BVqbhC6E5vQ2cfwWAiMf0cQgUQb87xWeBjpEJInkD5k09tk508jmq6p8Afx+3Ls2PJr5BVD5Km0CuroZCHX1vOHeTqb/PjpldMoaNL7pSIrhCW/VCoyLyxX5QyGqaEzGl7KvCM1DB9i1yEX8eoe5U8//Vls7+kM9O0yXQOS1Wguybich9xDOFpvnJxJCK76mmk9H2DuPnDzYWuirPP0zbXsbohqaJ5q3djLIVwx7zj4I9kibxcem5YowBtdGWUy7EBJAqok5qnPMvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(186003)(66446008)(33656002)(9686003)(6506007)(26005)(8936002)(7696005)(66946007)(52536014)(8676002)(66556008)(64756008)(55016003)(76116006)(66476007)(2906002)(82960400001)(508600001)(110136005)(71200400001)(38100700002)(122000001)(316002)(38070700005)(4326008)(5660300002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHdBSG9ReTg4RUUreGt4TUZoSzR6aURlbnFyaHdDbzBhc0JMcHh1YTE3UERJ?=
 =?utf-8?B?UGZLL3doZUVHQk5OaU1rYWhYSnpHMFR0OHFnRTkyVlRZZE14SERTTXRiZUJi?=
 =?utf-8?B?cTJ0YUt3TTM4ZDV0MTZxU3BJRU1QanBWVHBuWGsvVWNZRGhDeGpuRkNZakNJ?=
 =?utf-8?B?QU5WZVRkZ2MxUWs3Z3Q2RVpQckovZi9ESjRVZ3ZiamFtc0t3RkhucFJpSXN3?=
 =?utf-8?B?ZHdwOEkyN1lZcnZvbm5WdC93dERyRVhzM0gzYjhHNDNCSzRuYkFYeDRadnJC?=
 =?utf-8?B?eHZGRGtaR0J6c3owQWhmcmNKaDk0Q3NabStjcmxEZUE0QlVpdDFLWEloSWZJ?=
 =?utf-8?B?bUlzZ2wwMjJ5RDBQYVRlclJrYTJiYW5YektNeXZiUDdwOG1zc3diaFJ5U3Rk?=
 =?utf-8?B?NkdLRXowZzJoYnRMWXhEN0hpN1A4VWs0YnJsVzk5cGpyUEViWlorWVNKbFp2?=
 =?utf-8?B?VkllOGl2N0NNMW00U1RONEFXamJBOUJFaW9NZmY1d3JlY0NwQWFoYkZKcXZF?=
 =?utf-8?B?OXZWYS9tMXJaWjgxMkZFaGNZTUVFVEhYOHFTSkpGa2V6bkR0cU5Ma01HcElT?=
 =?utf-8?B?MDgvbjhRTnNNUmxza3JYVHJ6WTBjbjdleGFmWGZ1U3B2SWk2Z3dvTHEzandu?=
 =?utf-8?B?SHJqeTJYNUhYdnRtZjR5Nm9peTFDbHk5cWYyaXhNd2pkY09sdU9tRUJWczZC?=
 =?utf-8?B?T2V2SWRMczcwUWFFazJ2MEp4SGhpVHFLWXQ1WTlEM2xXTG1wVUFIdkNITlF6?=
 =?utf-8?B?NEp5YnMybDB0VGd2cUFPQWJiSm94NUt1clVsZCt2MGV4aGRNK2V1R1B4QlZi?=
 =?utf-8?B?L3IwTHVYTnBiejhnTW83ZFE2azFFRVJDN2xhYWNlZmJ0bE9ua0ovbSt0QnJi?=
 =?utf-8?B?dnY5VU1lOVBkTFhlQWQyTXU3aEdqczg4QjlERnBNN1pwU2V4VW5wNmVmNTNk?=
 =?utf-8?B?alpKemtkNWU4cnA1VHJoVTZvdk55d2VLd0lDYjc3dndFWGt2WUZJYXFUcENi?=
 =?utf-8?B?SWNiTVNqcTVFTG9tb2dUVVpQeVN0NldxS1NKajJxcWdxcUxCNzRhc216cnFz?=
 =?utf-8?B?TVJFRHUya05UaXNtNXo3Zno5QkUzNjl6UXYwbXhlQ3lpYnVvTzV0SkZaVjR2?=
 =?utf-8?B?TXZGaHNONk5tZElNdm1OT3pTL2I3dkJ4VWRRbHRrQWRxd0x5VDVnczRRcXdV?=
 =?utf-8?B?T0xFNytzcG5NOEduUGxIblEyZnplSEN2OTBhekNUZksvbzdQNVRTTzBlTjY4?=
 =?utf-8?B?cGNiVEJ2a09aMDBkSjJrNitzV003ckVtRW9SWU1GRUtFbHNiOGl6ajZ6VHRY?=
 =?utf-8?B?QzBndUIwaXJmQXVldGJtYU5nRW1PQWtiQ2IzalRBdktGVFc4cWg4K2hDOU9n?=
 =?utf-8?B?TEpJN2czVUJvSmUwZnZFeGRyVkJrSmtDbFVXenlLZmp2ekR0a1dBTFhtWGZj?=
 =?utf-8?B?ZTdMMWxXdDVSYUxrbUQ0ZytvUVRRcjNEd2hFWEhOWXpZelhVbGZ0UmtKOUZM?=
 =?utf-8?B?Lzl2ay9pM1hCeGZnMU5Ha2xEQVhPYUZHb21jd2xmNVc1Nm5PRmVHaWVFaHFF?=
 =?utf-8?B?bVYrblM4Q21HWHE5TzRzSFZuNldVaGZlbTFVOWNCemtEekJRZG1qdTJNMFpF?=
 =?utf-8?B?dlozc3M4REZCSk9sUGt1Vk9kRUxOK1lQMnVjNmNWUm1KcVR5UjRhZm9zdmdZ?=
 =?utf-8?B?eEZzZ0pjMkljMWlFdC9ERnU1MGpHazFhekNaTzkzdHlaaXFJelI5QUpRSXhl?=
 =?utf-8?B?Uml0YWVHRnZITEtpL2RFWTAwZ09vZ2c5T25mRFhRTkl2ZmxVZXowTWxnbkox?=
 =?utf-8?B?YUUvZEpnUWpLRHorN0hkcW9TKy9pTWUzZ1ZZRnB4ZTNLOGhDcXlZWXEybDFQ?=
 =?utf-8?B?V1NVbXNZdDg2SXNSVnEybkVDNGptQUVtQmd6Um9xem96bU5tNlZROUtkblZi?=
 =?utf-8?B?UGVnUnlLeE96cW1Uc2R3dGZZWE92NnozSktEY0tTR3l1MUJRRHcvODlSYUU1?=
 =?utf-8?B?NFpsZHBHWkh3Z2RSWGlWRVMyTWxqakNyMFpURXp4NDV1REVxeUxBN0IwWXlj?=
 =?utf-8?B?eGhDa3VSU1Y1S1B0MEFjL0EyY2E3OGxMd2FJNkJpVmJvbThjaDU4YVd0SHE4?=
 =?utf-8?B?K3A4VnlNeW9LQjU3cFhad3hlTjhCQ1poVEtBNUtLQ3BhdHJrdGZQaTB1a2RE?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b9659a-48a4-489d-131b-08d9c35ba364
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 01:54:19.9383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iptE5AmrMoHkaJHOBP/V0DInYQ63dBto8HasPpQN1/Tf+wSjHkWi/a9PGLcMwzQtKtLeXuxScQQYCCjnFhxGsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5000
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gV2hlbiB0aGUgbG9jayBvd25lciBpcyBvbiBDUFUgYW5kIG5vdCBuZWVkIHJlc2NoZWQs
IHRoZSBjdXJyZW50IHdhaXRlciANCj4gbmVlZCB0byBiZSBjaGVja2VkLCBpZiBpdCBub3QgbG9u
Z2VyIHRvcCB0aGUgd2FpdGVyLCBzdG9wIHNwaW5uaW5nLg0KPg0KPkluY29ycmVjdCBncmFtbWFy
LCBzaG91bGQgYmUgImlmIGl0IGlzIG5vIGxvbmdlciB0aGUgdG9wIHdhaXRlciIuIFRoZXJlIGlz
IGEgc2ltaWxhciB0eXBvIGluIHRoZSBleGlzdGluZyBjb2RlIGNvbW1lbnQgdG9vLg0KPg0KPllv
dSBjYW4gbW9kaWZ5IHRoZSBzdWJqZWN0IGxpbmUgdG8gW1BBVENILXRpcCAuLi5dIHRvIGluZGlj
YXRlIHRoYXQgaXQgaXMgc3VwcG9zZWQgdG8gYmUgYXBwbHkgb24gdG9wIG9mIHRoZSB0aXAgdHJl
ZS4gT3RoZXIgdGhhbiB0aGF0LCB0aGUgcGF0Y2ggbG9va3MgZ29vZC4NCg0KVGhhbmtzLCBMb25n
bWFuLiBJIHdpbGwgIG1vZGlmeSBpdCBhbmQgcmVzZW5kLg0KDQpUaGFua3MsDQoNClpxaWFuZw0K
Pg0KPkNoZWVycywNCj5Mb25nbWFuDQoNCj4NCj4gRml4ZXM6IGMzMTIzYzQzMTQ0NyAoImxvY2tp
bmcvcnRtdXRleDogRG9udCBkZXJlZmVyZW5jZSB3YWl0ZXIgDQo+IGxvY2tsZXNzIikNCj4gU2ln
bmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPiAtLS0NCj4gICB2
MS0+djI6DQo+ICAgTW9kaWZ5IGRlc2NyaXB0aW9uIGluZm9ybWF0aW9uLg0KPg0KPiAgIGtlcm5l
bC9sb2NraW5nL3J0bXV0ZXguYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9sb2NraW5nL3J0
bXV0ZXguYyBiL2tlcm5lbC9sb2NraW5nL3J0bXV0ZXguYyBpbmRleCANCj4gMGMxZjJlM2YwMTlh
Li44NTU1YzRlZmU5N2MgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9sb2NraW5nL3J0bXV0ZXguYw0K
PiArKysgYi9rZXJuZWwvbG9ja2luZy9ydG11dGV4LmMNCj4gQEAgLTEzODMsNyArMTM4Myw3IEBA
IHN0YXRpYyBib29sIHJ0bXV0ZXhfc3Bpbl9vbl9vd25lcihzdHJ1Y3QgcnRfbXV0ZXhfYmFzZSAq
bG9jaywNCj4gICAJCSAqICAtIHRoZSBWQ1BVIG9uIHdoaWNoIG93bmVyIHJ1bnMgaXMgcHJlZW1w
dGVkDQo+ICAgCQkgKi8NCj4gICAJCWlmICghb3duZXJfb25fY3B1KG93bmVyKSB8fCBuZWVkX3Jl
c2NoZWQoKSB8fA0KPiAtCQkgICAgcnRfbXV0ZXhfd2FpdGVyX2lzX3RvcF93YWl0ZXIobG9jaywg
d2FpdGVyKSkgew0KPiArCQkgICAgIXJ0X211dGV4X3dhaXRlcl9pc190b3Bfd2FpdGVyKGxvY2ss
IHdhaXRlcikpIHsNCj4gICAJCQlyZXMgPSBmYWxzZTsNCj4gICAJCQlicmVhazsNCj4gICAJCX0N
Cg0K
