Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBB349A89E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319746AbiAYDJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:09:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:8134 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1313557AbiAYCss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643078928; x=1674614928;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RlIHPQblSRMIm/qEhevvKs2d8oRC+B4B9WXOOtdq2gA=;
  b=FB9IhNUHdT+Erl5xviUUoJq1oI8+jQGHeMM2wzeOFmxhMlLQ6KQyJ9Xu
   iKEcZws/HAad6iohk0X7wyLQouc3mYtgbxwuRp23l522uGcNc9IfVhlDe
   G0m/It81xA9taPxiVi3RY2YuTeW3pNvXkd3j5BztiNIn2FTp4vk8RfJnZ
   +VSsRNtd8XGx7Rr5Xt/ThZclbaxwnjCX5SPKGVaLkgODSZrhUZckzZk5V
   Nnv73Joro2YxN7DclcdoG9oZr+B2T4CPLOgUrNcno1hW7dCjfnyd4o90o
   go/n0T5rCHwuEUZhBWJ7P3eYys38jeI7eQ9vh9vf4uA1QumSFMn89nlKq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="243796244"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="243796244"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 18:08:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="520189519"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 24 Jan 2022 18:08:07 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 24 Jan 2022 18:08:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 24 Jan 2022 18:08:07 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 24 Jan 2022 18:08:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eG4h/zZhpo8euCOav1wxIZk7rWpWnJ8CIlc8Du/1JEqy4K2aHRj/xou8iahVwyEkzvyt1IdjbNgYCmcS3X0wkZlrGhiF0JQonoNrF5Hpg1HpeWz0/Z7pT5MzdiBdRlCoyHERwF95dGT81VP8x7CwttfGUI/+MazHF15DGc/gFWiGb1yDX3cRE0w9QIhIUt+scHPDchuIw9iyaaccablq1cryc84/yCXxT1y+z9wSGquInK62t74jX1Pd5dZ6FE3W63tTe6WPYIHm2Kg4Q0JbQYTR3Ig5ZmB0FZqs8xLqdSKmJyt3WZxpUTc7vrDwrLYyAUyCWmJRDIiqxUGZMdp9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlIHPQblSRMIm/qEhevvKs2d8oRC+B4B9WXOOtdq2gA=;
 b=J4b0AlLCon21lFX2990maW+pkL1Y9BOVjto6Xjla4TBlsHt3/L1IfLi96NaUP5Xm7RWfZXpLdQCw1BBvE6MogNohFQAiRrTB3uvgvWh8V8rzU7jNvP2Ps47pu4XXgQZlbangWoRCktIVh256ywF0OvhccfNQEaWASqw4OAVRhe18o8M+VpqSfnn0Ot+qnfi7ZGOK/FY5FQaYLOMsdEEMwfLzag76/tcoQy5hIZ8qx8z3R4d1kTyq6JVyGfXzz32aDc6UXmgbPgiquMcThPFt4RU8OKDLd8tFKj/mNBvW9ELXsNJ+j7C7DZQCC2lJO8AeSM7caYSKvjkCYYJH26XryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA0PR11MB4704.namprd11.prod.outlook.com (2603:10b6:806:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 25 Jan
 2022 02:08:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e46b:a312:2f85:76dc]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e46b:a312:2f85:76dc%5]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 02:08:03 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        David Airlie <airlied@linux.ie>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Daniel Vetter" <daniel@ffwll.ch>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: RE: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
Thread-Topic: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
Thread-Index: AQHYEPHSpa6rqOl4/k+RfGCHsL5bBqxycAsAgAB8WRCAAA4egIAAAUFg
Date:   Tue, 25 Jan 2022 02:08:03 +0000
Message-ID: <BN9PR11MB5276004DA74B04B95D6A3CBB8C5F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-7-baolu.lu@linux.intel.com>
 <20220124173650.GF966497@nvidia.com>
 <BN9PR11MB5276232DDAFC8041D5E795DE8C5F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <bafad6f5-43bb-d016-035a-34c8daed059d@arm.com>
In-Reply-To: <bafad6f5-43bb-d016-035a-34c8daed059d@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6142e27c-e42d-489c-26ca-08d9dfa784f6
x-ms-traffictypediagnostic: SA0PR11MB4704:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SA0PR11MB4704C3A7678FAC1CD4D6676F8C5F9@SA0PR11MB4704.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AWb3+5O0MScbdkzztuOwpXC50eSBOEwlG7LGeWY+SW43r35nxK5O54TkhMHILUCqduFsQAdK8tXHfq5zsfjKJuFPT8nIE3D7a+HtKyWhet4jvTzC4Gce0rdUPozfPkH5/oUwTFpnWR2rW84W2L70mIfpU0knHYjZROBWqklRbEU6ww28mQH2/W2I2on5eiz652PtC6J9EIdi2ROKIYHbyfspCt3Bjy1CuWOjnrTHOqT/QVa1Z8eGpdACQDE1fOmIoZm7N/0TaXhvIxrRnln2lUN6pWYX4OKET2QzhuL3LTozVRhb3U17RNZg7bZmca645Nz/i3Y86/WfQN14fmzb406q1qTAs3Y5LZTtjgNIQP9ym9gk5VpRM6gChz27N7me2JVxDBjGlaAmMgU4xjXwI4eEwBRMvYKcDxEZX+hOb999ej5mTJdsH3yB/T0wmF0vu8TuFvJwjbFUvgZ1phyfKIVh5QI0lNOziV5VGcjDsGYLiIjgiA89BR60+a3HliOk2EtQGgW36mSzLYs1jp0NUymvjBeWRyfHBxNwOwFKdfJ2pGCJncMhMdHEXrSzH4Zs6Oi7UrjIoh2/LC93/PGuxmTjYK8eZ434l4ELc6ytU/R5wPUc9AuUeMurrhfRagLSJB8IlsP3ToVkOt0J2FHHic/DaWciEUyD2UOAlmVLKFcwsBabRouirvaKuYQ5NplNMZrGOaRvPb/wJ9OmtF4NPp+mfLRSmTn5JGbyKgH1p3o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(316002)(83380400001)(186003)(508600001)(8936002)(7696005)(4326008)(122000001)(38100700002)(8676002)(2906002)(54906003)(110136005)(38070700005)(66476007)(33656002)(82960400001)(66556008)(52536014)(55016003)(66946007)(26005)(86362001)(53546011)(5660300002)(76116006)(7416002)(9686003)(64756008)(66446008)(6506007)(43043002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHhCVWhqMVpPaU1mcHpTeHdhYXk4bXZqeUhGOU9QYXJNVkZsSFQ4N2ovV1Ji?=
 =?utf-8?B?NzJTRmF1QkpnSnZjTnVUSk9zZDN5RnlTYzlrWFVmcWFVamFJTG1oS3EvZk5O?=
 =?utf-8?B?eUZhQkJGOWRlbWlrV3I3NmNvVFdrMjdWRk9jSFZFTURWWXplUC9uamhOWEpX?=
 =?utf-8?B?STZKam9ValJLVVg1RnZXWnpPUXc3N3hBY0hYdSs3d1dEZEtueStON0NHSXFw?=
 =?utf-8?B?NjNidHczY1F0ZnJ4Q0ZlbXlMRkVFNnNxNndMM285dm5wUmw1bVZhcitTdWdu?=
 =?utf-8?B?QVl6WlhvNVpEclg5bkxGeks4ZFF2anZTdmNQVzYzUktYSXdPdGRYWkdrUG0z?=
 =?utf-8?B?bVdNWFl4RnkvMkVEZ2JJWXM4V0lWNGljcEJmcGQ0aEpsMGFIb0xoZnFxUXRj?=
 =?utf-8?B?UnA2YjF6NVFPUFRmc0JqRFRVSjR3aUlGU1VGYy83cWZaSHloZXR6YjFkanV2?=
 =?utf-8?B?MjBHME0wTTI1dzVTdVg5cVBPSnhGWlJxRDNXWTRQeS83MTk1Nk5oQkVZQnlk?=
 =?utf-8?B?amp5Q09oWGJQeVBySlJwWThjWGZjdndFVmNNb1hXakVWRTd4cXdJTFVGd0VH?=
 =?utf-8?B?cFJvakMxclNxTlJsalRGaUR3UjZSOHFWTzRjOUtqNHFUenNZOTNoMGpncHNW?=
 =?utf-8?B?MmE1N2xHTCs3OWpXZFNmaGd6eFFNM3A5Z05CQ1hSSGF5V0o3K3lrcllwaDl4?=
 =?utf-8?B?UXVCVm04ZjJwcFFZaUdBNkhFdnhDbllzZG5wbUppVjUyOHkrUUV2VGxBQi96?=
 =?utf-8?B?TXVvNHk5YWl0UHhvNm9GMDd4MXRsdEdtUStjV3Fubk1manMzWWxGYnBvWWVX?=
 =?utf-8?B?eXhaS05jbGVjUFg0aXROTGNtNW9QN25aL281aVU2dndPYTR5Q2VGZTZtbnRp?=
 =?utf-8?B?cDJNb3pnQWxLVkpLeTduQllhNVFzUEdXSzZweWMwMGdLNktTV05jbWJzMHZj?=
 =?utf-8?B?eis3TVJpMzdCS25wMm9ESnk5VW93OUw2WjEyN2F6ZmRxaU9adDNHOVJFQ3Ax?=
 =?utf-8?B?dEVPOVB6ZFo5WUdkaGM3aDR1K0p2SytCbWFuRG10Kyt6dmJjNEtjeEplSmMw?=
 =?utf-8?B?NHRYUzBnZ0xCTU5lOFh4VGRLdWRVTnlIN0VBZTlCZ3NhSTQ1RHJDT2V0d2E5?=
 =?utf-8?B?dUI2cHQ3ajJUY3Y1TzkzR2F2Z2hGQ1FCcmFyRHFxRDZXSnBUZHdQTW1uWEw2?=
 =?utf-8?B?MjJjdUNjbTlsb2FTdGMvREtDNDE0YllQTGwzWU92Y3VOaFIyemV3ankvSzB4?=
 =?utf-8?B?SWhWNE5xSlA4SXc0Q2xvakdtT0N3M3JsZFBQOEpXeVNDSGtYZmZyWUlUdHlp?=
 =?utf-8?B?Mm43RXJ3aTlSZWJqeXVlODRBZ1FNdVlybmhPN0M4eitGN0UrbkIvckJDSU00?=
 =?utf-8?B?RmYybkJReEp6dDM2c1FnYzgycjdqckZmRzdaT3dqWmM4bGo5VWJPaUk3Z3Ja?=
 =?utf-8?B?OHNFRkZWaVBIREdlKzJ5ZS9VeXg4ZVZzV2l2b0VIVnEycGdqUE9LbkpmMXlz?=
 =?utf-8?B?UVRuSDFuK2IyUCtHS09hWHZnVmt2K1JhNmlpNzBOdnFNSlpIbGVET3lLcHBv?=
 =?utf-8?B?NmpxRmNYS05FcVJrMmU5bHl2ZTE1Q3o5L1RzR1dhNjI5a0c3dUg3MC81NWtO?=
 =?utf-8?B?OWtlamZCWndaeElmVkFCdHFaZ29YOXNQb2ZtSUYxa0RCU0d2QzlZdnpyRWVx?=
 =?utf-8?B?ZFV2d1IyLzhWYXlqRDNtdkFjVWN3dkNzemRBVlZ2dStkdDRQRU1EeDhldkNw?=
 =?utf-8?B?eTBQeFlpMWVUSC84NUFGdXdMeldJSWNrRDUxVWZMM05nSGx4cWsxVHQ0bU5G?=
 =?utf-8?B?VjBuWlFGRFJJQU4xUHdOendHeHV2YlQwdGcyWS83b0NLa1Jsb2c0SGhhSEFQ?=
 =?utf-8?B?cElNRzVnUkNHZVBhMUlWMjlESVNROHBaMnRQdkJFdGFpL3VnM1A5akFIblg0?=
 =?utf-8?B?aE10eDJkYWdLZ3dycEhQb2t5YkRtcWI2S3RTQTJMdGVUZHYzenlBeHk0bWZs?=
 =?utf-8?B?L0phaTRpRXVXY2NaZDNvMmZubUVDK3JHTmxZV1Z6bGlLTEJiOEp4NVB5R0FC?=
 =?utf-8?B?YUt5T1BrcEs1ZmtaNG1FSkJwaFo2aTZWSlVFRVc3ejdpUThGTytzRTZ1bEkr?=
 =?utf-8?B?QXhmOGM1MzFxSGIxcVRvdXgxeW9STmtKMEVDTFRnTlhyVkNXSXVwelhPczhn?=
 =?utf-8?Q?ta7aRJ/pOheqyG2uTsyQPlw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6142e27c-e42d-489c-26ca-08d9dfa784f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 02:08:03.2267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i853XN7V2L3O9UbZfyVoF2NQX3v5gJd7ibYLYUmiPA+yWv1/xM1eVgB4+VBEpHDzecpz1TlaPLWl0mdxcHBpNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4704
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBKYW51YXJ5IDI1LCAyMDIyIDk6NTIgQU0NCj4gDQo+IE9uIDIwMjItMDEtMjUgMDE6MTEs
IFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgdmlhIGlvbW11
DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMjUsIDIwMjIgMTozNyBBTQ0KPiA+Pj4gQEAg
LTEyOTUsNyArMTI5OCw3IEBAIGludCBpb21tdV9wYWdlX3Jlc3BvbnNlKHN0cnVjdCBkZXZpY2Ug
KmRldiwNCj4gPj4+ICAgCQkJbXNnLT5wYXNpZCA9IDA7DQo+ID4+PiAgIAkJfQ0KPiA+Pj4NCj4g
Pj4+IC0JCXJldCA9IGRvbWFpbi0+b3BzLT5wYWdlX3Jlc3BvbnNlKGRldiwgZXZ0LCBtc2cpOw0K
PiA+Pj4gKwkJcmV0ID0gb3BzLT5wYWdlX3Jlc3BvbnNlKGRldiwgZXZ0LCBtc2cpOw0KPiA+Pj4g
ICAJCWxpc3RfZGVsKCZldnQtPmxpc3QpOw0KPiA+Pj4gICAJCWtmcmVlKGV2dCk7DQo+ID4+PiAg
IAkJYnJlYWs7DQo+ID4+DQo+ID4+IEZlZWxzIHdlaXJkIHRoYXQgcGFnZV9yZXNwb25zZSBpcyBu
b3QgY29ubmVjdGVkIHRvIGEgZG9tYWluLCB0aGUgZmF1bHQNCj4gPj4gb3JpZ2luYXRlZCBmcm9t
IGEgZG9tYWluIGFmdGVyIGFsbC4gSSB3b3VsZCBzYXkgdGhpcyBvcCBzaG91bGQgYmUNCj4gPj4g
bW92ZWQgdG8gdGhlIGRvbWFpbiBhbmQgdGhlIGNhbGxlciBzaG91bGQgcHJvdmlkZSB0aGUgYSBw
b2ludGVyIHRvIHRoZQ0KPiA+PiBkb21haW4gdGhhdCBvcmlnaW5hdGVkIHRoZSBmYXVsdC4NCj4g
Pj4NCj4gPg0KPiA+IEluIGNvbmNlcHQgeWVzLg0KPiANCj4gTm90IGV2ZW4gdGhhdCwgcmVhbGx5
LiBJdCdzIHRydWUgdGhhdCB0aGUgImZhdWx0IiBpdHNlbGYgaXMgbG9naWNhbGx5DQo+IGFzc29j
aWF0ZWQgd2l0aCB0aGUgZG9tYWluLCBidXQgd2UgbmV2ZXIgc2VlIHRoYXQgLSB0aGUgQVRTIHJl
cXVlc3QgYW5kDQo+IHJlc3BvbnNlIHdoaWNoIGVuY2Fwc3VsYXRlIGl0IGFsbCBoYXBwZW4gYXV0
b21hdGljYWxseSBvbiB0aGUgUENJIHNpZGUuDQo+IEl0J3MgdGhlIGVuZHBvaW50IHRoYXQgdGhl
biBkZWNpZGVzIHRvIGhhbmRsZSBBVFMgdHJhbnNsYXRpb24gZmFpbHVyZQ0KPiB2aWEgUFJJLCBz
byBhbGwgd2UgYWN0dWFsbHkgZ2V0IGlzIGEgcGFnZSByZXF1ZXN0IG1lc3NhZ2UgZnJvbSBhDQo+
IFJJRC9QQVNJRCwgd2hpY2ggbW9zdCBkZWZpbml0ZWx5IHJlcHJlc2VudHMgdGhlICJkZXZpY2Ui
IChhbmQgaW4gZmFjdA0KPiBoYXZpbmcgdG8gd29yayBiYWNrd2FyZHMgZnJvbSB0aGVyZSB0byBm
aWd1cmUgb3V0IHdoaWNoIGRvbWFpbi9jb250ZXh0DQo+IGl0IGlzIGN1cnJlbnRseSBhdHRhY2hl
ZCB0byBjYW4gYmUgYSBiaXQgb2YgYSBwYWluKS4gU2ltaWxhcmx5IHRoZQ0KPiByZXNwb25zZSBp
cyBhIG1lc3NhZ2UgZGlyZWN0bHkgYmFjayB0byB0aGUgZGV2aWNlIGl0c2VsZiAtIGFuIG9wZXJh
dGlvbg0KPiBvbiBhIGRvbWFpbiBtYXkgKG9yIG1heSBub3QpIGhhdmUgaGFwcGVuZWQgb2ZmIHRo
ZSBiYWNrIG9mIHJlY2VpdmluZyB0aGUNCj4gaW5pdGlhbCByZXF1ZXN0LCBidXQgZXZlbiBpZiB0
aGUgY29udGVudCBvZiB0aGUgcmVzcG9uc2UgaXMgdG8gcmVmbGVjdA0KPiB0aGF0LCB0aGUgb3Bl
cmF0aW9uIG9mIHJlc3BvbmRpbmcgaXMgY2xlYXJseSBmb2N1c2VkIG9uIHRoZSBkZXZpY2UuDQo+
IA0KPiBJIGZ1bGx5IGFncmVlIHRoYXQgaXQncyBhIHdlaXJkLWxvb2tpbmcgbW9kZWwsIGJ1dCB0
aGF0J3MgaG93IFBDSSBTSUcNCj4gbWFkZSBpdCAtIGFuZCBubyBJT01NVSBhcmNoaXRlY3R1cmUg
c2VlbXMgdG8gaGF2ZSB0cmllZCB0byB3cmFwIGl0IHVwIGluDQo+IGFueXRoaW5nIG5pY2VyIGVp
dGhlciAtIHNvIEkgZG9uJ3Qgc2VlIHRoYXQgd2UnZCBnYWluIG11Y2ggZnJvbSB0cnlpbmcNCj4g
dG8gcHJldGVuZCBvdGhlcndpc2UgOikNCj4gDQoNCkkgdGhpbmsgdGhlIHBvaW50IGhlcmUgaXMg
dGhhdCBhbHRob3VnaCBwYWdlIHJlcXVlc3RzIGFyZSByZWNlaXZlZA0KcGVyIGRldmljZSBmcm9t
IHRoZSB3aXJlIHRoZSBsb3cgbGV2ZWwgaW9tbXUgZHJpdmVyIHNob3VsZCBjb252ZXJ0DQp0aG9z
ZSByZXF1ZXN0cyBpbnRvIGRvbWFpbi13aWRlIHJlcXVlc3RzICh3aXRoIFJJRC9QQVNJRCByZWNv
cmRlZA0KYXMgcHJpdmF0ZSBkYXRhIGluIHRoZSByZXF1ZXN0KSB3aGljaCB0aGVuIGNhbiBiZSBo
YW5kbGVkIGJ5IGRvbWFpbiANCm9wcyBpbiBpb21tdSBjb3JlLiBPbmNlIGEgZG9tYWluLXdpZGUg
cmVxdWVzdCBpcyBjb21wbGV0ZWQgYnkgDQp0aGUgaW9tbXUgY29yZSwgdGhlIGxvdyBsZXZlbCBp
b21tdSBkcml2ZXIgdGhlbiByZXRyaWV2ZXMgUklEL1BBU0lEIA0KaW5mb3JtYXRpb24gZnJvbSBw
cml2YXRlIGRhdGEgb2YgdGhlIGNvbXBsZXRlZCByZXF1ZXN0IGFuZCB0cmlnZ2VycyANCnBhZ2Ug
cmVzcG9uc2UgcGVyIFJJRC9QQVNJRCBpbiBidXMgc3BlY2lmaWMgd2F5Lg0KDQpEb2VzIGl0IHNv
dW5kIHJlYXNvbmFibGU/DQoNClRoYW5rcw0KS2V2aW4NCg0K
