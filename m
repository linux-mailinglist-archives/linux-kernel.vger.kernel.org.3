Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5554A4880D2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 03:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiAHCJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 21:09:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:49036 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbiAHCI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 21:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641607739; x=1673143739;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=gXBykcHzu1SRCReq8cIBmuzlItSSN0l3dkiasGfZydk=;
  b=LCfm8k4P/TfLeAei03GlNULJ1fCVUe9kxS/EaFcwtmtIfeJxP3AiBmN6
   fcy+D/ywyGYAj67Jt8v3m5nCFMnOKyeHqGYpqhs3oWy5IPxO0uxMjA+8o
   ndIaKqFx/LQr+kuLucJa+UKSFoKgE3W6rTxQtFm1lWJHdaMUVJQvnppmA
   xpQnl2N0X/ip3au9rZ/BQleTpBRkM+6flluGowA4UjhoGorMOhuzC7CZk
   enQC4Tao38EplLGFpoHLXJzywm0urj2nwnQdwyZuzLMerXnocTems4AO+
   fujlc74Igz8aZkiIBD/lXXQq7yEL4ieaudVmzgXIwTCajDZXwHon8S09t
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="329317556"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="329317556"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 18:08:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="514005772"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga007.jf.intel.com with ESMTP; 07 Jan 2022 18:08:58 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 18:08:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 7 Jan 2022 18:08:58 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 7 Jan 2022 18:08:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MictKkqBuY+CTmlD4fcl+abTLJ/FV04S9ItEhj4s51n+XClot49W047yOte35Xnxjps9y0TV6dKCslTugaYuJgNzH8wZOqe4Fjw6CdoWWlfDjQ726mcxy5Hq+/jTSb+PRysZKYeguUHbkZ6oUSMxW9AqraU7BEBLVi60iXfwR0LI3WDXRVVVIL+g80xMVtH5mo8Ykt4t/M/1oRPiw+41cYkBvX6g1IWQJt3daizgC5jxgdIt6KE4HSZRzymPfmImWPisHs0O1nzX/NvDAvGTALK9+GcR2EgCADYDAgPCRkk7c/XeJPdVk3bhg68kndlJsauXrhFhC91yj+keY5venQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXBykcHzu1SRCReq8cIBmuzlItSSN0l3dkiasGfZydk=;
 b=e2R199NMmAgOsSFcFOdNcI8x0J4Qn+ffwTSAwTA4r5h5wvDuJcL2n38TcofGIMLo/7+Le9Fjx/DhWgsUCWi1cfSa8b7CvogtGISy8lteVQFXJlJypQY3ueJilCApth8Vn8fVGJlwApxUGFOpm/wpTGzvbUaRUr7DRZHlEDDJKYrr67PxbO54pfKBxWzoFWIGXcD1ESq3Suq8NqeRhODdW0ZRm5gTps/BGpyL0lIg4HlHE5ZZaGpz9hRu8HT/6CNgxjAUU280mB+esds1rnvCP6I4YhQeJQwnJ43n1Gi6PC6qjBqFQjS4bCc3FDUniQ61QP2BQsaQ51spoUrubdMF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by MWHPR11MB1389.namprd11.prod.outlook.com (2603:10b6:300:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Sat, 8 Jan
 2022 02:08:56 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::6486:e69c:2ba8:112e]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::6486:e69c:2ba8:112e%5]) with mapi id 15.20.4867.011; Sat, 8 Jan 2022
 02:08:55 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "ortwin.glueck@logobject.ch" <ortwin.glueck@logobject.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix 5.15 init regression for Intel Bluetooth
Thread-Topic: [PATCH] fix 5.15 init regression for Intel Bluetooth
Thread-Index: AQHYBDSwmaVnvTSJlke/6FY4hUNc8w==
Date:   Sat, 8 Jan 2022 02:08:55 +0000
Message-ID: <7b400964d7bcf052fb609bd1647936df03bdc667.camel@intel.com>
References: <856c5dc7-9fb4-8438-3451-7b369832056a@odi.ch>
         <b0f6f66b-28aa-9d43-0aab-e6887ee0fda8@logobject.ch>
In-Reply-To: <b0f6f66b-28aa-9d43-0aab-e6887ee0fda8@logobject.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-2.fc34) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63e9fb25-4fef-4ef6-8149-08d9d24bd342
x-ms-traffictypediagnostic: MWHPR11MB1389:EE_
x-microsoft-antispam-prvs: <MWHPR11MB13891583B8D58D3C544B353AFF4E9@MWHPR11MB1389.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QFdxp9It98cVOzYL0w4HROsEFB5BtAlJN09OE3NRUK8CclThBH3j9tq1tS7sZ4deZfmbD5Cn9ayF9fjYXMt26MBOOaNIjYnYIAr/olmQHq7JFRY37cKFR8OoUJRXf0CtClUIimp4bE8aMaqqIrfa+ZdQrBK4Jwg7CQW7tYKUE5TTy00c0p/6f+/oN2c7G0gevA7j9z0te2FZnWlpkmb2hkio9gHCh8zZZgCA7YgrPRj+ID/0WeuK69KE6wkJFbOJ1qaUNy2zIDQWKoFmM/BLYq4+J+Ds2lvuhdIckfUnEGMHDFX8Y2rtsbC+GMk/pe00zwCaUH3knBF+cuPHXkfDUPCTR6JN2R8XuuOjKRVsXA7bPwranh8/yQP1gIe7BDt0wkt4TE9iREooBM87YjtYzfQ1tNd5n3z3IyJzzn1rwuaoKyCasFe2TiDZhYGgAk9n5hTmz2eYrsAD2w3bzOwEeqVcroRew1KihTP06Bx/dLvF0G1335Xbj4uvYXqwX8iGr9i5qudJy4rG5dT92BElN0kO0tCYFDhnt3YKG81rOhZApUm2lG94CtbsBwI7pZXalAjwozhxsqZjkwKlmzPj+EzhCGrKrMEGVjrI359kEj4nxkyzcvJ15IjnjG1nOg7fhZ/+70WDSwf83b8tRAlTve+/98xyP6Y07dVJd7a9357sLdStRVbC+G84WWGZmfA+TP4+O1dZyfG1YUdtVanYgiTzCANKttJNIqHREni/VtA3navhUPhe/VE51nkOnl4zCqCT4FQcCDpe7adEIJY11Si9Etjg7CaSRiaJUrKrkNU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66946007)(2906002)(4744005)(122000001)(6506007)(66476007)(64756008)(186003)(5660300002)(66446008)(316002)(8676002)(6512007)(38100700002)(26005)(2616005)(8936002)(966005)(508600001)(71200400001)(38070700005)(110136005)(82960400001)(76116006)(6486002)(4001150100001)(66556008)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWhJOTc3OTBDWGZxN2FBN1FHbkxQc1JaZVNhZ0FJSUZDYjJNSWk2L3FncXU4?=
 =?utf-8?B?VHVYMVpwRS9LQllQaVp5aTUvUTJNcnZrVTBkUkR2azNyd0hxQlMzaTlSaUV0?=
 =?utf-8?B?VzdJSU1CZVY5Y1ZUaGZyemIxNmRkbG9pdHZxT2VZYkdHSlBQdDBrUzhSNURp?=
 =?utf-8?B?MzRmYVNuTGtJMnFhQ0ZWL2tRWlhnNU81U2xRc0lNNS9oSjhqWDByWS9hUEZR?=
 =?utf-8?B?SkxFK2RHQk9zRElyc1ZCS21kd1VkUFBGbXQxekVUakw0cW9Pb3l4SXZJOEto?=
 =?utf-8?B?cXdYaGRvOHpQWlkwN3hHaVZtQ1hWZE5XMTIycW5Db3pxZU54aVJxa1N0eVV2?=
 =?utf-8?B?OFNyeE1GalZDQnZYTUNDdmFRbG5pbzhmSnBkY0QrMlF0aDVoUmJlMGZpVkJQ?=
 =?utf-8?B?SkZPOGU3RzhGUjFLajZwRHBZQ285WXRadnFFNTNiQ1JQNTVJSDZIT2dKa3lV?=
 =?utf-8?B?K3VDSGRXMEZ5bG1RRW5EVUJtUHBXUjV0YnlRcVBheHg2eEtCbXdMWkV5d2Vt?=
 =?utf-8?B?WnEzN1JOaVVKWjZqVGc4a3haMmZRaTdlZUpFL0FmLzZ6Rm1kOVhMOXFsenp6?=
 =?utf-8?B?QVBkSlpWdUl1cSsxOXVSK1AySVFLU0sxQ1R3L1EybWNWaU1JNldmenBGdERV?=
 =?utf-8?B?UVhRUWtVMGsvcFdoRkc1QjFuOFpVVkk3Zk85ZmdXcE9ISC9uNW5RNHh0UFk4?=
 =?utf-8?B?Vnl1MFQwNjhNVXc5blc2YW1VTlh2ZVZTbnpKc01XNVBWSTRmQmtYR25TZEt6?=
 =?utf-8?B?bDRwd3VFTTNxOHpHcElxWm10Ymp4bXYyZVJ6dUVCWXh2cGZNNXFiTVRwMjdr?=
 =?utf-8?B?Z1lQV1B1bW91WmFYUGw2cWFWRmhaU0tEODhkYTFxSEJJci9sYmlEdEdHNkxy?=
 =?utf-8?B?SVRNZkRDZmZaTytDOXZiSTM0Tkh3RGdXV3c5U1h4NjRLQzJqUHhudnRobVVN?=
 =?utf-8?B?a1VhSWdMcmlnWlhVL2E2RDV0ZklGVklubGw4QkdNaktDaW4vVitkV21iRjdM?=
 =?utf-8?B?bkhPcGhTc0ZOeVlaeDRRa3RQa2dlbncyRXVVVXVyeTArMHZqUHlSV1JJeit4?=
 =?utf-8?B?RlNjakJKMVV6N2NOajk0L0NLMktQUmcvSkN4dlJrUDhQeGdsbEwwQk5VWWxo?=
 =?utf-8?B?VnNicHFWNml4V3dwZGRETWRORSs3NmJ1VFhRcWxlOWhUd04vVlp5TzdSWFEr?=
 =?utf-8?B?dk5PcGcwRmRYRUFaRXlCSG5sTDFDaE9XNVVIQ2lPWW5RMDVOeU9GQlozMzZn?=
 =?utf-8?B?THhJck1BMHN0NTR0UEo4UGY5ZnVzTHRHcUp5bktsMVpVNXd0K2Q0SVJrWXdW?=
 =?utf-8?B?cWx1Y0t1Q0lCaVliVzZ3K2hMWVg0S1J3ZnZxTldsUWlxNDVNVmV6VzhRdkNO?=
 =?utf-8?B?dFVNRHFMV2dSaG1adk5kVkVXVHNiMXZBRWFWcHhxZ3d0VHBadERXdjZwS0s2?=
 =?utf-8?B?RmtOVFE0bC8rWEpsb2lSSUVDQzdHbVZKL28zUXNoTG1lWG5vUVp5SDlKZk02?=
 =?utf-8?B?R1c5MS84NEhhWDA1Q2ZZMVVaVzZRbUd5dUM1NTRRdmh0SDlHQTUraFJTMGFr?=
 =?utf-8?B?L1RBb2VrVTgwVEREc25oaUoyQ1hmTDY2UzdGWW5CdStiM1ZJSjBJeEFzZWJM?=
 =?utf-8?B?TUYxWmQ5Rzh0NHRBRGpCMlcrYWZydDZTaEkwd2hVNkl3dWZJdUZ6RTAwYk80?=
 =?utf-8?B?U01YeUFXeTBHK0pESTM5Qks2dlN1RUdXQ2h6N0dTUDVLNXBka2ZzbHlvdzRi?=
 =?utf-8?B?UE40SnIrbVQ1VGd0SHluQktzdjNCakFJUDJhdXlRYnF5dmlyc29iSm10cFBS?=
 =?utf-8?B?YXZtK1Z4d0xjTEo5bEZ0VzU2Qmd4STY5cHE4ZFV0dUJBMk1RbDRhY3lUbWlH?=
 =?utf-8?B?UEt1ZWRSekhFMGxSNHJSbEM4WlNPeTN1MXI1QUlHODJMN1VUVFlNbXZzTzQ4?=
 =?utf-8?B?ODh1ejQzVDZ1WG15eVBqWjhzWWxSZU1ydkUwK2NZak9XSS8rQ3FDcTZMa2Zr?=
 =?utf-8?B?bmV4MWpZZFJyNFdoZTdJb1RRR0V2dFY2SkNlRkF5ZTlKeSsvM3dlTzhQVUJn?=
 =?utf-8?B?cmhiUWt2UlE3ZkIzSTFqS0svVStuNnJzTHpGTnZEQmN6VzlnajEvTHFEbVdN?=
 =?utf-8?B?Vy90Vm1HM3EwQ2UzR2h5QmRWRjArQUQ5K1hKWUpvbFp4MzlETUVYRkZvdEsr?=
 =?utf-8?Q?oWFFvumK4L4Rs2VvbvW15Jw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BD220C0CCBC1142BEF46211D541801A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e9fb25-4fef-4ef6-8149-08d9d24bd342
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2022 02:08:55.6957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fH0gSuILcP7GzXgrpDeOqiHJjFahE9Q+/4kbwaHQ8PVLVLBSqd5dxFY45JzJEvZGe5iXTS6x/9QR1aCHkQLKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1389
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT3J0d2luLA0KDQpPbiBNb24sIDIwMjEtMTItMjcgYXQgMTE6MjYgKzAxMDAsIE9ydHdpbiBH
bMO8Y2sgd3JvdGU6DQo+IA0KPiBIaQ0KPiANCj4gT24gYWxsIDUuMTUga2VybmVscyB0aGUgSW50
ZWwgQmx1ZXRvb3RoIG5vIGxvbmdlciB3b3Jrcy4gQWxsIHdhcyBmaW5lIGluIDUuMTQuDQo+IEFw
cGFyZW50bHkgdGhlIHF1aXJrIGlzIG5lZWRlZCBmb3IgdGhpcyBkZXZpY2UuDQo+IA0KPiB2YW5p
bGxhIDUuMTUuNToNCj4gwqDCoMKgIEJsdWV0b290aDogaGNpMDogUmVhZGluZyBJbnRlbCB2ZXJz
aW9uIGNvbW1hbmQgZmFpbGVkICgtMTEwKQ0KPiDCoMKgwqAgQmx1ZXRvb3RoOiBoY2kwOiBjb21t
YW5kIHR4IHRpbWVvdXQNCj4gDQo+IHdpdGggcGF0Y2g6DQo+IMKgwqDCoCBCbHVldG9vdGg6IGhj
aTA6IExlZ2FjeSBST00gMi41IHJldmlzaW9uIDEuMCBidWlsZCAzIHdlZWsgMTcgMjAxNA0KPiDC
oMKgwqAgQmx1ZXRvb3RoOiBoY2kwOiBJbnRlbCBkZXZpY2UgaXMgYWxyZWFkeSBwYXRjaGVkLiBw
YXRjaCBudW06IDMyDQo+IA0KPiBQbGVhc2UgYXBwbHkgdG8gc3RhYmxlIHRvby4NCj4gDQo+IFRo
YW5rcw0KPiANCj4gT3J0d2luDQoNClRoZSBmaXggZm9yIHRoaXMgaXNzdWUgaXMgaW4gYmx1ZXRv
b3RoLW5leHQgYW5kIHdpbGwgYmUgbWVyZ2VkIHRvIG1haW5saW5lIHNvb24uDQpodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9ibHVldG9vdGgvYmx1ZXRvb3Ro
LW5leHQuZ2l0L2NvbW1pdC8/aWQ9OTU2NTU0NTZlN2NlZTg1OGEyMzc5M2Y2NzAyNTc2NWI0YzRj
MjI3Yg0KDQpSZWdhcmRzLA0KVGVkZA0K
