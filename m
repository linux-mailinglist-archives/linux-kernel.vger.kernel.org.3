Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C354976D9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 02:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240699AbiAXBFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 20:05:41 -0500
Received: from mga07.intel.com ([134.134.136.100]:7381 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235226AbiAXBFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 20:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642986338; x=1674522338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nDiNvcfAZOgsa0UJdzm7LOzv/qMd/icDibiCdj+jC4A=;
  b=MpAitWQLheOyQCiiCR5oGv2B2UCJzlR6+QyIsYngEohd7KFg83PCo3zS
   jCSAqt78qQZEVKeKBKYvKERoVNv4lRamFQpQU5lGTqstG+XaHMYGFveQe
   pAOpf83yUOsb15aXvvcr1TghfkDQHELD4U3ThzsR1TLKrjgjBdtT1ODxZ
   gsX9UJ8ejtNMxyeWHNC6zM0fPDGct3AkQca0vLgBXerGGloRwYIuyXvEf
   agmCU6nWw5+EDtdZspKb9OWy80fJJW8u/lr2NyZFlO+getIAqCcjgWBfm
   ycIfvW/Hl2igCYLzpZXb8Un2cxUQdhST1XKTo3WEwQPAFcucRl6AfyawX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="309259346"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="309259346"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 17:05:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="478869396"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 23 Jan 2022 17:05:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 23 Jan 2022 17:05:38 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sun, 23 Jan 2022 17:05:38 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sun, 23 Jan 2022 17:05:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQlC0xAhL7MWqOGLoOvXjp1MjWRG3YiaNU/ssyfITVmHf7wbTyRmJPW0QMbIt/4F5HiNI+XmkFHE/XtzwNGo3qi+1kJLPwxcJxlVIzGxgA0Yxk0ycOcfwSjVgpyZqvLoQUSAV9bVtBwc7Aa90eR5PEmyQnL2M7VZsZ+2HdNfVLVI3R533ZXO6omb5s5kI3aHC+rZS983TL4KppY0IBUvMctHcgD0BZ9oXXVG5ZB/NSgFYOsTsWSfdVyelUgyAoUvmw/d3kdoWRvlG/p6u/YH7L0/EBYcj0FQEIYbfX2dBqrHoXq12AZ6S3YNfv1MJB4CRznL0UtZSJklpQlRIM5WPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDiNvcfAZOgsa0UJdzm7LOzv/qMd/icDibiCdj+jC4A=;
 b=mts+nZQ+JJbvJY+4EVFoKkJ+n0DJZtsYxzI683KaTJIMxrtOWhVQHtjju89lPS1BC8xUEqR9NRrG+ki6iv09nG2dI3Ej/YkYZO1ZdY76spNxKmEBQXvS+zVWLnPwRhCFhHitToB7jhn2dKztstM90mOS+BbqSEA+o8FHQ1qCTAsxjrX2732UkbQYk/x2K7011ncn+liFr5bx3ZYa0+ahxvANSmMwu0MC57h8WA6q0z7uNzM3Lzy9lV3x+7t7c2mNwtfcDGbF0baJW+bNogxcXqWeEevG9wiSz3Lh9hOtEK3LMBlAR91PUJNMkekWq+A6eKo3htfHIspB8L7LAS9TqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 MWHPR11MB1534.namprd11.prod.outlook.com (2603:10b6:301:c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.10; Mon, 24 Jan 2022 01:05:35 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::e40c:6c1b:d066:80ea]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::e40c:6c1b:d066:80ea%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 01:05:35 +0000
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "thara.gopinath@linaro.org" <thara.gopinath@linaro.org>,
        "mka@chromium.org" <mka@chromium.org>,
        "quic_manafm@quicinc.com" <quic_manafm@quicinc.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] thermal/core: Clear all mitigation when thermal zone
 is disabled
Thread-Topic: [PATCH v3] thermal/core: Clear all mitigation when thermal zone
 is disabled
Thread-Index: AQHYEL5+8Jwy3DIwMkOX+FnBo1zJUw==
Date:   Mon, 24 Jan 2022 01:05:35 +0000
Message-ID: <ab6134bd1ca7f7fd8cedad90c1bbb81f642ac647.camel@intel.com>
References: <1641581806-32550-1-git-send-email-quic_manafm@quicinc.com>
         <927aca29-fca7-bdf9-9ad6-2599125ca1b4@linaro.org>
In-Reply-To: <927aca29-fca7-bdf9-9ad6-2599125ca1b4@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.3 (3.42.3-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05bb044d-1c98-40a2-6d1d-08d9ded5a0c1
x-ms-traffictypediagnostic: MWHPR11MB1534:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB15341BBC9B1383263A0166E0E45E9@MWHPR11MB1534.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +CVXu9kgSZtHc97hSAJTjS0rbVTfESLqQ0IK8jCiyFwvKnivbDOcSdE5AezqOm6UAFy9J/bwmmCMGVPbvAJDGdjaRQz0PtWxaomr4OQfuFQQF9WZs4iZUDlyKH10uUbo3mT0zjVDEOYm4M8cod7Hl5Aj+tIWwqbgWEdulhqLjjMuN0Goo6nLDEjViW2EY2vbWiEJOLzhpIsWZ/WFLddYwKg1zLO2EpES7AUX1yDay1Z6KOjICKOGAbQaOWIq0NTNKJUeMlpwbqCuQ8bsuk/Br0++I/r085MNZvmDfWlbUzsgaXTTmQOoCU6bFVlJoW9sRHZAKBMGTUUCtaY86hIrfGZbQwuollZMl5wCgkpxpsuQC8TWLsMcvmJwMkAW8Dez5qnFCdmakSb/yDWXzWGZibo/meJd9ihsLGOaAivQiR9QW33RZ0K0EYO8u5nNY6wmARrQfbtCGDg5rQmuqEz9gH//6farl2HtFHd517jwwRUW0pS/+oGL+rK2awG2XTcPoJ8EARC5LR8NCSItN+wL7FqWAjPC9a+n1vhpoFUL/DCQ3pjXA0etos3Kn4nzMCsyc04Q0BH5bCLGYoqqNHeytYZXNLvr9NoG7FlxTxZb8+KReoRXTLgQt2tUP88B/YuquyQClIyx1RmED8teacyg5gXLn2FZTGhnY6++1lBKdUYKfgXnPyR0sqxJ6HCz82TfqTkLGb7Jc4SGeI3EKBBjmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(8676002)(186003)(38070700005)(6506007)(6486002)(2616005)(66946007)(316002)(91956017)(76116006)(508600001)(38100700002)(122000001)(6512007)(66446008)(64756008)(66556008)(66476007)(8936002)(83380400001)(5660300002)(82960400001)(71200400001)(4326008)(54906003)(2906002)(110136005)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFRhUE5VSm9BTmE5Snd3UVVLbUt6NWJTTmJNYnc5NThaQVZjZzV5bW9qejhy?=
 =?utf-8?B?Mlp5QjgxeW5ZK01SMWt5dGlyVmQ5K0hKYnZEQmsyZTRTQlVNbXQzdW9xR3NG?=
 =?utf-8?B?ZjZEeWU5VnJrb2xsRGJzbUNyR2hJTEp6T25QVzhMVUJOQ2NPcWFsbmduZ0VB?=
 =?utf-8?B?djh0bjl0UmpaQms1UDlMbUd6WlpyeUpXUndoRmUxbng4VDJ4ZWtyUEFQNjRW?=
 =?utf-8?B?dU5XZGJMNkxLRGxYVk5rS1JxTTVsM0IxbS9nWkE3SUNnMGlaU2tJOUJlcTVU?=
 =?utf-8?B?UmZySldnM0dib2JXS0NoaXp3NmtHRS82N3RSSWZqMVBoSjJURWU3T3dKdWNF?=
 =?utf-8?B?TDlZdnZIUWE4MFVJUG4xZ1JHcnEzbjN4NnM5QmZUTXpteitTRGgzNFEvbkZr?=
 =?utf-8?B?S3FhakcyMlVGZk83RHZzSGNFVDRJQXV2RW1aeTNPaFk2L09DYjRQY3lTOUNF?=
 =?utf-8?B?ODNjeWloVkl6emFlSDdjVm1lSWJpRE1FNlk3eHNKWGZGMFJ6NWdDKzR4a0ZI?=
 =?utf-8?B?Q1lDQVBmbzV3STVsUkRwRUsyNmFzV3VSQ1FnNmZMUXdOMzREU3kyUlhGZGFD?=
 =?utf-8?B?ODZDM211ZTdneUhidEpDWVRQL2x2Slh4L3lXN3hIVi9SeVlYZDNKS2FZZC9j?=
 =?utf-8?B?RWgrZnU5aXhIb2ttbzV4TFZQV2RLK1cvTW5DLzk5bU5ySFpyaGQvRWFWR2lp?=
 =?utf-8?B?WnVRNDBCWktoVGNydGovcStzNVlvaTlnN3hmWThnb3YrbnRQRkJVb3BYdGJ2?=
 =?utf-8?B?MTFQWHpxZzNIcGEvZ3NmS2xueTBPbU0zaFk2b1g4Y2dMVFUrOTY2dzNxaTNq?=
 =?utf-8?B?dXVScmI3K2ZSWUlMeitOY2NZbFo2aE96WFpBUGwrWVZyY1RNNEZZQS80aVBE?=
 =?utf-8?B?R2VDQlkwSE1PSWRzaDNWRVpwb3Fwd1JrTFFJZ3IrczgwUFRVQi9qcXg5UjI2?=
 =?utf-8?B?QkpWOTYrd0hLdUI5VkY3TENERG8zSjBUNGpDd3NqWWRlemRUNnpJZU1COWZJ?=
 =?utf-8?B?anBBNk00MGpWbjhwTGlnQkJublh5bTNCYU9GU3k3T2w2WGhUdzgvdGlTWm41?=
 =?utf-8?B?QWFJeTd4dmxBbmF4YlFCdnE5WjZJT0s5bDJVZitOamdMUjFUbU9QNzlDbzla?=
 =?utf-8?B?N0pwK2IwNkRqRzAyaERJc3IrL2pTaFNucitBajlPTWIzRFRTT09WVmtBNHBo?=
 =?utf-8?B?L3llbyt5d0xyOEVuOXNxQmt3MzJBaG1DajlZWVljd25KUDkzS3JTZE1aWXhC?=
 =?utf-8?B?czdIT1FSM3hraCt0cnFPNzhJWC9mTEkwVzJndXdWazVYV2Q4VGJFY3QvYVJB?=
 =?utf-8?B?SllJdWprQXVqZEJnY1BuL2tPZzFvc0VhcEtZNy9wSUxBc2FKeUZ1YTZFekw5?=
 =?utf-8?B?TmJEKzhCSnVGU1kvdVpwQjBoUFo1aGV4NVZRam9iZ2VhVWR2UVJCdFZqTDA3?=
 =?utf-8?B?eFcxaWZLQitoMlZibEk0cHdRMWZtQVJLQ3MrVVMvWklCTlBWV2tLR3NBS3Fu?=
 =?utf-8?B?WXhGMHdEQmJsdWhZWlBZZmlpaWU2TFJUYW54VEVRZmxuZ1dGSS9ndWlVQ3dw?=
 =?utf-8?B?SXkwaStiTFFsM0FrOUZtbWViUXlLS3hpOHV6WU1KVmR0RW9YVlhoaEQxZS9F?=
 =?utf-8?B?VWkwM0FDU1VSRlliWGJCL3pCZmR6Q3IyWjFLL29zSmdkTTJEeXJJcFM3V2Zk?=
 =?utf-8?B?MWFKaHpQMHVocVV6dERNUTN6bFA5THdxVnQzTXlNSkJ1NE5BTWFiY2Vsc3VL?=
 =?utf-8?B?QjY2Y2twZERjVXlTdEJ2djNTN1lhMGxIZmYvWGdleW9ZZ01qcGdMQ2N6ZFVk?=
 =?utf-8?B?dXQvVU5FSDdSSFBMUzFQVVJwY1RJTXN2UzRrYjhCZTQzL2EwL0JIQ1NERzMy?=
 =?utf-8?B?K3NvbmFMaEFIOEh1elU5R3VwWXkvWWx4ZDI4VlRuMFV1LzhlTENiUTFTUUJN?=
 =?utf-8?B?dXEzdmFiZlEvdFBtUDRrS0N0dHBoem1YL0hvSmxQMm5PTFdIWWphN01EL0RK?=
 =?utf-8?B?T2xhcFl4UlBUMTl6SEU0c05YOE1jZXNPdnhOVUtiMnFNck9PcWwxWitaWHRS?=
 =?utf-8?B?d2JTQWFHWlFxQ2lOSWlvQWVvbEZFejhUZTM5aThXMnNueHZSWEpyN25uNGY3?=
 =?utf-8?B?emxreGlneS95dmdrelRaTDBrb2p6OEN0OXZaNlhwMmVKcFB5UTl2VXpoZ2hv?=
 =?utf-8?B?bXFSbzl4UFhLT1lHZFZqNkhzNm5GWm9xVFJtWWZqc3JzRkViUzZXNEg5ejFX?=
 =?utf-8?B?cTI3SXgvQXlLVjZGcTg4TmhvZ1I2TzR5cnJPTGhWR3VCNTQvYVVRVkk5TkZH?=
 =?utf-8?B?NmR4c0gzRURWZnA1SmRVbUdUeWtJU1VDazN2c0JrZ0ZJRW5CQUovRG1jOWFC?=
 =?utf-8?Q?eZPBTKjL5tcAYl+I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8DB2F4C531BE24F84EA483F79E08A9F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bb044d-1c98-40a2-6d1d-08d9ded5a0c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 01:05:35.5441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mn7Kq87g7cyFs164PJOMf0mn0KUJG6PNfWHHft0Le+sYaqIaZWY7vwNs60OOtjiRk1qpcJa/XaVNL7cpVp1Dt+weFIYdLl9NfE7yxB2q4Xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1534
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIyLTAxLTIzIGF0IDIxOjUxICswMTAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gDQo+IEhpIE1hbmFmLA0KPiANCj4gc2VtYW50aWNhbGx5IHNwZWFraW5nIGRpc2FibGluZyBh
IHRoZXJtYWwgem9uZSB3b3VsZCBiZSB0byBkZXRhY2ggdGhlDQo+IHRoZXJtYWwgem9uZSBmcm9t
IGl0cyBnb3Zlcm5vciBhbmQgc3RvcCB0aGUgbW9uaXRvcmluZy4NCj4gDQo+IE1heSBiZSBhZGQg
dGhlIGZ1bmN0aW9ucw0KPiANCj4gwqAtIHRoZXJtYWxfZ292ZXJub3JfYXR0YWNoKHN0cnVjdCB0
aGVybWFsX3pvbmVfZGV2aWNlICp0emQpDQo+IMKgwqAgew0KPiDCoMKgwqDCoMKgwqDCoCAuLi4N
Cj4gwqDCoMKgwqDCoMKgwqAgaWYgKHR6LT5nb3Zlcm5vciAmJiB0ei0+Z292ZXJub3ItPmJpbmRf
dG9fdHopIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh0ei0+Z292ZXJu
b3ItPmJpbmRfdG9fdHoodHopKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqB9DQo+IMKgwqDCoMKgwqDC
oMKgIC4uLg0KPiDCoMKgIH0NCj4gDQo+IMKgLSB0aGVybWFsX2dvdmVybm9yX2RldGFjaChzdHJ1
Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHpkKQ0KPiDCoMKgIHsNCj4gwqDCoMKgwqDCoMKgwqAg
Li4uDQo+IMKgwqDCoMKgwqDCoMKgIGlmICh0ei0+Z292ZXJub3IgJiYgdHotPmdvdmVybm9yLT51
bmJpbmRfZnJvbV90eikNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHR6LT5nb3Zl
cm5vci0+dW5iaW5kX2Zyb21fdHoodHopOw0KPiDCoMKgwqDCoMKgwqDCoCAuLi4NCj4gwqDCoCB9
DQo+IA0KPiBBbmQgYWRkIGluIHRoZSBzdGVwX3dpc2UgYW5kIHBvd2VyX2FsbG9jYXRvciB0aGUg
cmVzZXQgb2YgdGhlDQo+IGdvdmVybm9yJ3MNCj4gZGF0YSBhcyB3ZWxsIGFzIHRoZSBjb29saW5n
IGRldmljZSBpbnN0YW5jZXMgaW4gdGhlIHVuYmluZF9mcm9tX3R6KCkNCj4gY2FsbGJhY2sNCj4g
DQo+IFRoZW4sIHRoZXJtYWxfem9uZV9kZXZpY2VfZW5hYmxlKCkgYXR0YWNoZXMgYW5kDQo+IHRo
ZXJtYWxfem9uZV9kZXZpY2VfZGlzYWJsZSgpIGRldGFjaGVzIHRoZSBnb3Zlcm5vci4NCj4gDQo+
IERvZXMgaXQgbWFrZSBzZW5zZSA/DQpUaGlzIGlzIGJldHRlci4NCg0KVGhhbmtzLA0KU3Jpbml2
YXMNCg0KPiANCj4gDQo+IE9uIDA3LzAxLzIwMjIgMTk6NTYsIE1hbmFmIE1lZXRoYWxhdmFsYXBw
dSBQYWxsaWt1bmhpIHdyb3RlOg0KPiA+IFdoZW5ldmVyIGEgdGhlcm1hbCB6b25lIGlzIGluIHRy
aXAgdmlvbGF0ZWQgc3RhdGUsIHRoZXJlIGlzIGENCj4gPiBjaGFuY2UNCj4gPiB0aGF0IHRoZSBz
YW1lIHRoZXJtYWwgem9uZSBtb2RlIGNhbiBiZSBkaXNhYmxlZCBlaXRoZXIgdmlhIHRoZXJtYWwN
Cj4gPiBjb3JlIEFQSSBvciB2aWEgdGhlcm1hbCB6b25lIHN5c2ZzLiBPbmNlIGl0IGlzIGRpc2Fi
bGVkLCB0aGUNCj4gPiBmcmFtZXdvcmsNCj4gPiBiYWlscyBvdXQgYW55IHJlLWV2YWx1YXRpb24g
b2YgdGhlcm1hbCB6b25lLiBJdCBsZWFkcyB0byBhIGNhc2UNCj4gPiB3aGVyZQ0KPiA+IGlmIGl0
IGlzIGFscmVhZHkgaW4gbWl0aWdhdGlvbiBzdGF0ZSwgaXQgd2lsbCBzdGF5IHRoZSBzYW1lIHN0
YXRlDQo+ID4gdW50aWwgaXQgaXMgcmUtZW5hYmxlZC4NCj4gPiANCj4gPiBUbyBhdm9pZCBhYm92
ZSBtZW50aW9uZWQgaXNzdWUsIG9uIHRoZXJtYWwgem9uZSBkaXNhYmxlIHJlcXVlc3QNCj4gPiBy
ZXNldCB0aGVybWFsIHpvbmUgYW5kIGNsZWFyIG1pdGlnYXRpb24gZm9yIGVhY2ggdHJpcCBleHBs
aWNpdGx5Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hbmFmIE1lZXRoYWxhdmFsYXBwdSBQ
YWxsaWt1bmhpDQo+ID4gPHF1aWNfbWFuYWZtQHF1aWNpbmMuY29tPg0KPiA+IC0tLQ0KPiA+IMKg
ZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jIHwgMTIgKysrKysrKysrKy0tDQo+ID4gwqAx
IGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+ID4gYi9kcml2
ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCj4gPiBpbmRleCA1MTM3NGY0Li5lMjg4YzgyIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0KPiA+IEBAIC00NDcsMTAgKzQ0NywxOCBA
QCBzdGF0aWMgaW50DQo+ID4gdGhlcm1hbF96b25lX2RldmljZV9zZXRfbW9kZShzdHJ1Y3QgdGhl
cm1hbF96b25lX2RldmljZSAqdHosDQo+ID4gwqANCj4gPiDCoMKgwqDCoMKgwqDCoMKgdGhlcm1h
bF96b25lX2RldmljZV91cGRhdGUodHosIFRIRVJNQUxfRVZFTlRfVU5TUEVDSUZJRUQpOw0KPiA+
IMKgDQo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKG1vZGUgPT0gVEhFUk1BTF9ERVZJQ0VfRU5BQkxF
RCkNCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAobW9kZSA9PSBUSEVSTUFMX0RFVklDRV9FTkFCTEVE
KSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0aGVybWFsX25vdGlmeV90
el9lbmFibGUodHotPmlkKTsNCj4gPiAtwqDCoMKgwqDCoMKgwqBlbHNlDQo+ID4gK8KgwqDCoMKg
wqDCoMKgfSBlbHNlIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50IHRy
aXA7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBtYWtlIHN1
cmUgYWxsIHByZXZpb3VzIHRocm90dGxpbmdzIGFyZSBjbGVhcmVkDQo+ID4gKi8NCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGhlcm1hbF96b25lX2RldmljZV9pbml0KHR6KTsN
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZm9yICh0cmlwID0gMDsgdHJpcCA8
IHR6LT50cmlwczsgdHJpcCsrKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaGFuZGxlX3RoZXJtYWxfdHJpcCh0eiwgdHJpcCk7DQo+ID4gKw0KPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGhlcm1hbF9ub3RpZnlfdHpfZGlzYWJs
ZSh0ei0+aWQpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoH0NCj4gPiDCoA0KPiA+IMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gcmV0Ow0KPiA+IMKgfQ0KPiA+IA0KPiANCj4gDQoNCg==
