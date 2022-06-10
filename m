Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C8F5460B7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348282AbiFJJBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244939AbiFJJBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:01:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5744E483BA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654851703; x=1686387703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=++MHfGeKtiOTf8SP6YyDfmR09y6LW9GTnJ7TuWSHr7o=;
  b=eIdg5Om4W4sFrOE5a29Td/XmTOCPiKsHNzLyvxAFAgxCFYhPJaTOahL/
   Sa/Kv4JvyZ+n6qpDWDHHu4mqVdy1MVliKHc0Eq9t4fTSEFDi3DFMqzOgV
   XGtfCFv6c1FZsg//pBr9p/HOVGV18Ym2DqMMV+cdZl0qhYXZ6PVnvTqED
   nDayzprmivPqDXxMJSb9YuIm98ospPtbb7D58KuwcDRaNotOFXHkFFUS2
   D42q5NhXQ4UHFhDHoPxvQweTvDTkOK93tLimXZrF1fFQipW2kFlh+QCeD
   BVQoiBelHDQnsn4OsuPh9Rrt/mieEaUETNhPygyDn/oygo0/Jc5Lv383s
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="257399361"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="257399361"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 02:01:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="580984948"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 10 Jun 2022 02:01:41 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 02:01:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 02:01:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 10 Jun 2022 02:01:40 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 10 Jun 2022 02:01:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xkg5FfeyDlGon+EdCgqsE9IbxIjF05Oet4iDvyl/ImUKYYDs8HDNZe3J7DGzv5P19Q666FAKbpGmH30ew+9mE2pbDVF02QcOEKTCEN08UQ36TLsxC2XGTvcdxOVOaT2nwAZbBaQtWgqbrq2K+UrmJZylYcP1x2CVS2jJehCEgPiU/gqBjHr7f14NIZHrUZl5a57YnlmpUx62W8bnn+5tUleJahyBSkMuyD8dvhbgBRUOp/1YyQSklgTbbT6OhtL7/9Igg830IHTpMxiB1++cPbsdrdSBRtsSItEeZD0t3sFoudJ+dp6ACdkDMbzNAN+xmlvpuxly/6iXoRgut5vLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++MHfGeKtiOTf8SP6YyDfmR09y6LW9GTnJ7TuWSHr7o=;
 b=PiefdxeTbRVsMsYvO5a7EcjlBKNbLGTiZW48hDQKsKuH31T+OhBrY7tLwWCHr5ioIfHQQ5UTvZagRWn7uI2bqzaBGXFs55tf+CXhXIBuae3JmrX3ZfHYnyrrr20zFpqqDqowPj2oWu/w3TPzyEkkIr3FJs/K4Wu1QyK7DaDt7HVLNVXRMFLK67Gd8nmSEUAJ9Jkee84zMeancYKXQ2U/lK/ikOivQaY6BeR4nI2GmbxtBwtXf7aNmRmbE9ThJ0L1Wx5uaFCCnPH370dw+wJSo50kk7GLPK8C5h1o0U3cwWXng3dAa28N+fZtvHh5ddNYJnPvSIbF0SXMtn4gp8Gtng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5877.namprd11.prod.outlook.com (2603:10b6:510:141::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Fri, 10 Jun
 2022 09:01:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8%4]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 09:01:38 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
CC:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 02/11] iommu: Add max_pasids field in struct dev_iommu
Thread-Topic: [PATCH v8 02/11] iommu: Add max_pasids field in struct dev_iommu
Thread-Index: AQHYehFqfLSA0C1VVkGHz+EI1qcA6a1HcmMAgADFNQCAACEyAA==
Date:   Fri, 10 Jun 2022 09:01:38 +0000
Message-ID: <BN9PR11MB5276C7B4FAC55C58A5466EFC8CA69@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-3-baolu.lu@linux.intel.com>
 <20220609190102.GC33363@araj-dh-work>
 <f92629ef-8c9a-b89a-ef0b-32e71617bd51@linux.intel.com>
In-Reply-To: <f92629ef-8c9a-b89a-ef0b-32e71617bd51@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7690696e-2f82-4373-527d-08da4abfd41e
x-ms-traffictypediagnostic: PH0PR11MB5877:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB587796169E374B05EDC5D4B98CA69@PH0PR11MB5877.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V93xCQUMmLlPBCkICOpF1uHclpbVj5xJScHF5pnIA5pvj4JN2+GH6gtbIpbU22ZCs+ZTXJ7w4DAE79IuWraY82El2ZWiuQzGfxTQz0N5hpZYJEjiIXnC7mKuC/f2VMysc3Uf8QFsQQNFbL4+CabkktQ0Lj1dqi0ZBMOhe34+eFrq6dEsdeBwJn+cCLWDB12bBpVxP9rm+ljIw6IgrV4O9z4CjMYUinHizlGu1zhrFTgBwBd5TeSGAYHmLatWtYErW3oAEmTU6QjepcRJ21sLic/YyCHyhW1lfnGpUPajodf8cahnxZmzfp99E5/XgJMsWKLULDaXjRGL6h9lG8hbrdR2gHr+3adM88tESe+WONPWOIAd31AtSzh1FlyoyKQG0w5J2VxQReeGO9AvpjP12KLwQKUhaUU/+oa9yxgruMffMLPW0BqPj7FIWDSe0g7/QVw/T5n5KLHNAUeUEOa+2SiFYX9jNuHoIMi//5XE/M8aK79kgu6DNRFB8Z2ovC+AQ3G1OfuJVtk9V5I+K4ywMgJGIOA2pKRxOWhaJ0wkbyxORGTBijCMWrOLuLXyqVa9vjOHkbgAT5y+1Wm1cX8ZU514dXaSGfLcLUGGGAJCSb3sq2gec3P8lqK+dBpCZaaETyB/b4t4EciQw3h6dhCJMB9EqH26nb2SGf/8DWmge3t5l4xqhw8Gm2bJ2b934MGyJv6WxVk0Dw41TJlPVFrp8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(316002)(6636002)(86362001)(186003)(53546011)(6506007)(26005)(9686003)(71200400001)(110136005)(33656002)(82960400001)(508600001)(2906002)(4326008)(38100700002)(7696005)(7416002)(66446008)(122000001)(38070700005)(55016003)(66946007)(66476007)(8676002)(66556008)(64756008)(8936002)(76116006)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wkd4MUs1NjdSMS94MW5PQ2R2MHBRdFpLNmR4OVlsUmI1WWxFUVpNZmtaWDdV?=
 =?utf-8?B?QVJTZmExemJadVQ5NTM5SW9oL2dsT21Xa1dlN1Z3L1NPTVRPY3N6bHJtL3JZ?=
 =?utf-8?B?OHBGaUZSY0ZZVk43MitxZjJiK2owNzhxeVVhQ2RQZTV1WXdSa0MvTlowQVlp?=
 =?utf-8?B?YVpidG44M0Y3aEJtUGRLd0hXa3Q5WVJsV1laYlVIS2dhVm5xK2NONE55cjlW?=
 =?utf-8?B?dVh0U1FGQnBlZjBNRFJDNWxPOTQyOEdiQWNVTEN2KzE5SGRuZGNlOG9JZ0VT?=
 =?utf-8?B?dzJ6L1kvdjI0dkhpS0FvdW4rTFNpMFB1MzFxQkpBS0l2VllhZHlWQkM0Zm94?=
 =?utf-8?B?a1MxRkZ0M2lqZ2V5Ulg3cWJsNVhRNklpQ05vNWYzVnB2dXVaUmhsWDRzMmZR?=
 =?utf-8?B?SXV2VXk1TmpTcWtXN1BDQ2xDQVlHQkZsVGh5NUZoWS9LeUJENFFTeXlzWFdr?=
 =?utf-8?B?T1RoamJqN0x1c2t1N1ZwRzZ3VFE1ODY5elkzRmtRT3FRaEVtcld4UG9FVWJO?=
 =?utf-8?B?UWh2UVAyQU5JbUxwcDM4cmYvTHhVV1ZDaGtQeUF2VTlZM1p5dFJ3ZFRvRzZU?=
 =?utf-8?B?OUpZclByWXJVWTRId0ZVT09Dek5ra2g2NDk0UlhvWUcwSEg5YmEvV2s5Z2dE?=
 =?utf-8?B?VnZ1djBiU1lyNTM0QWRWckZVUDNFa1pEVTZZY0ZaS0EwaVkxbXNRQ2VDYm9G?=
 =?utf-8?B?cC84L01nTDlQb1Nic2t1Z1pRUlJIc3FmektsNWVqMTN4Z1JEWTVGYjc1YnBn?=
 =?utf-8?B?TjJLZTA2V3laK0VKb01haHBRS3JKYU5zTTh0UUY4UXVUZWV6RytGazNXRmpJ?=
 =?utf-8?B?M25xTkQwdVVIeGFtVWdMalV6WkpiS3JXVVcrZlc1TTk4N1k0bmdYTHRRaHRl?=
 =?utf-8?B?UDRGNHBQVUdVcnFkcnNUY0RObWlnSWk2WktTMTc4U1Axc3l2TWVRdndJL0VN?=
 =?utf-8?B?UVRVWlRZVWVCZUV2ZGNuWG1HWVZwRWlhVVBXOFJoekphNVRWaDZ1bUJ4dlVV?=
 =?utf-8?B?UEVYKzRzNzFUaG55Yi92NXZRUXV2Mk9mTE00MVpYU1FmSVNadEJZaU5QejV4?=
 =?utf-8?B?d05mZG5MRjN5eFNBNlNlSGxFNUQ5VUdoTjZIQzlZcVFacmYyUDdqYjgyTEpQ?=
 =?utf-8?B?TzRDVEl0M0krTkY0bXQ4QUg0VStkUkhPcVRNTkpQZXJpS2dkSVdBUXhLam0v?=
 =?utf-8?B?TDFDOGFLQWhGVm9BZHZVbERZQUZHWVlRL1MwWXFETU5qQ0s2alUvNnBFclVU?=
 =?utf-8?B?OU1tYmZVcGw0MlZodGtlMFp4a3JEdmdpVXhLRHR3NjR3TjFNamw4TEJEL09N?=
 =?utf-8?B?UGhQNENtN0pXMGt0MUlDaElTU21rd2VMcFhZUG11L3I3d3orKzdPQzVLOWNx?=
 =?utf-8?B?dFcyY0pGMDZJaDVmQ1JKTnF3NnhYM0wrRlhuRWZhTUdmbkRtc2YxV2xHREE0?=
 =?utf-8?B?Mkt0b3U1bEQ4N2pSamNIRzlDUnRMUDNReU1mejdsU0h2K09tc3lJb2JTNkI2?=
 =?utf-8?B?WmhUVTYyL1JzdkNQLzdDbVZNVXpvaFIvVG1DaGlPbjdBUDBNbE1PUmZtUi9s?=
 =?utf-8?B?d2FIdXJiSXcyV09JbXhLbGhDNzdJWlFpMEIwVmducFlqVldiL09LVS85UmZT?=
 =?utf-8?B?dmtPdE1xemRKVWVGSW03U2EvWWtUSnNWNEJnRlR5QU1aT0lwKzgrM3FlUFpS?=
 =?utf-8?B?VjQ5bTRwUHVSTUJneVlDMDBDTTJNMHpvUVNWOTNLTnBVTmlLbGRDTVdwS09N?=
 =?utf-8?B?MGNWRzNLOFE3akYxL2lHcEt0bFYxR1ZBUkdxSkNvOGZLZGlzNlVTUlZLZjNy?=
 =?utf-8?B?aFBZVzFhSjVuUWlFbG1nYmduQXp3VWEveFdqNW1FWHlKQTdMcERCVnRRNmhL?=
 =?utf-8?B?OHhFdldOTWFPRzYzWG5Canp4ckRKM3RublFmM3hKRE8xMFVnWHEzQWU5Y2tv?=
 =?utf-8?B?MVNSSkY2dmM3MUUxaUlUeUcxR3N2cFVaVG9udUVaVmpPR3UzU1d2SVRScEZX?=
 =?utf-8?B?aUFnTTVEd3JLOXZTcTFiZUxOckJWWVYvaHpkOTlLSGpWRXhLczM0cU8xb1B1?=
 =?utf-8?B?OFlmK0xxdnA2VnRuRlR6V0Vzak5MNTZsdjZ2dWE4WVVXZlFOUjdGREhXT3ZY?=
 =?utf-8?B?WDZ1Qm1EYnVtc015QVVQcE5hdE9JSW5UdldwbTlwdFplSng3b2R1TE02eG5J?=
 =?utf-8?B?anZQYU9aMVBzZ3RZbldkQlNWK0dnRk9vRnBIY0o1ZFQ0WTFRSXJ1dkt4eUlW?=
 =?utf-8?B?bmZaTzg5WldYRGRjaXV0WXBxS1VpSTJDYXVYZGxRWWtXOW15MFlNMjZMd2xn?=
 =?utf-8?B?VmZkbGVhZEFKd3EzWWtraStEdEEvRW4vL01CaERmRGd0NE5JVFpsZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7690696e-2f82-4373-527d-08da4abfd41e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 09:01:38.3843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kfSofj2OHfpe8MQSUNvDHiUOqRfUudeV9dKlKc2IQ4FKY6r+zZEpvwifrO0yLDBVxsSGmkM0YasLFwChA1RxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5877
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bmUgMTAsIDIwMjIgMjo0NyBQTQ0KPiANCj4gT24gMjAyMi82LzEwIDAzOjAxLCBSYWos
IEFzaG9rIHdyb3RlOg0KPiA+IE9uIFR1ZSwgSnVuIDA3LCAyMDIyIGF0IDA5OjQ5OjMzQU0gKzA4
MDAsIEx1IEJhb2x1IHdyb3RlOg0KPiA+PiBAQCAtMjE4LDYgKzIxOSwzMCBAQCBzdGF0aWMgdm9p
ZCBkZXZfaW9tbXVfZnJlZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4+ICAgCWtmcmVlKHBhcmFt
KTsNCj4gPj4gICB9DQo+ID4+DQo+ID4+ICtzdGF0aWMgdTMyIGRldl9pb21tdV9nZXRfbWF4X3Bh
c2lkcyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4+ICt7DQo+ID4+ICsJdTMyIG1heF9wYXNpZHMg
PSBkZXYtPmlvbW11LT5pb21tdV9kZXYtPm1heF9wYXNpZHM7DQo+ID4+ICsJdTMyIG51bV9iaXRz
Ow0KPiA+PiArCWludCByZXQ7DQo+ID4+ICsNCj4gPj4gKwlpZiAoIW1heF9wYXNpZHMpDQo+ID4+
ICsJCXJldHVybiAwOw0KPiA+PiArDQo+ID4+ICsJaWYgKGRldl9pc19wY2koZGV2KSkgew0KPiA+
PiArCQlyZXQgPSBwY2lfbWF4X3Bhc2lkcyh0b19wY2lfZGV2KGRldikpOw0KPiA+PiArCQlpZiAo
cmV0IDwgMCkNCj4gPj4gKwkJCXJldHVybiAwOw0KPiA+PiArDQo+ID4+ICsJCXJldHVybiBtaW5f
dCh1MzIsIG1heF9wYXNpZHMsIHJldCk7DQo+ID4NCj4gPiBBaC4uIHRoYXQgYW5zd2VycyBteSBv
dGhlciBxdWVzdGlvbiB0byBjb25zaWRlciBkZXZpY2UgcGFzaWQtbWF4LiBJIGd1ZXNzDQo+ID4g
aWYgd2UgbmVlZCBhbnkgZW5mb3JjZW1lbnQgb2YgcmVzdHJpY3RpbmcgZGV2aWNlcyB0aGF0IGFy
ZW4ndCBzdXBwb3J0aW5nDQo+ID4gdGhlIGZ1bGwgUEFTSUQsIHRoYXQgd2lsbCBiZSBkb25lIGJ5
IHNvbWUgaGlnaGVyIGxheWVyPw0KPiANCj4gVGhlIG1tLT5wYXNpZCBzdHlsZSBvZiBTVkEgaXMg
ZXhwbGljaXRseSBlbmFibGVkIHRocm91Z2gNCj4gaW9tbXVfZGV2X2VuYWJsZV9mZWF0dXJlKElP
TU1VX0RFVl9GRUFUX1NWQSkuIFRoZSBJT01NVSBkcml2ZXINCj4gc3BlY2lmaWMNCj4gcmVzdHJp
Y3Rpb24gbWlnaHQgYmUgcHV0IHRoZXJlPw0KPiANCj4gPg0KPiA+IHRvbyBtYW55IHJldHVybnMg
aW4gdGhpcyBmdW5jdGlvbiwgbWF5YmUgc2V0dXAgYWxsIHJldHVybnMgdG8gdGhlIGVuZCBvZg0K
PiA+IHRoZSBmdW5jdGlvbiBtaWdodCBiZSBlbGVnYW50Pw0KPiANCj4gSSBkaWRuJ3QgZmluZCBj
bGVhbnVwIHJvb20gYWZ0ZXIgYSBxdWljayBzY2FuIG9mIHRoZSBjb2RlLiBCdXQgc3VyZSwgbGV0
DQo+IG1lIGdvIHRocm91Z2ggY29kZSBhZ2FpbiBvZmZsaW5lLg0KPg0KDQpJZiB3ZSBkbyBjYXJl
Og0KDQorc3RhdGljIHUzMiBkZXZfaW9tbXVfZ2V0X21heF9wYXNpZHMoc3RydWN0IGRldmljZSAq
ZGV2KQ0KK3sNCisJdTMyIG1heF9wYXNpZHMgPSAwLCANCisJdTMyIG51bV9iaXRzID0gMDsNCisJ
aW50IHJldDsNCisNCisJaWYgKGRldl9pc19wY2koZGV2KSkgew0KKwkJcmV0ID0gcGNpX21heF9w
YXNpZHModG9fcGNpX2RldihkZXYpKTsNCisJCWlmIChyZXQgPiAwKQ0KKwkJCW1heF9wYXNpZHMg
PSByZXQ7DQorCX0gZWxzZSB7DQorCQlyZXQgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoZGV2
LCAicGFzaWQtbnVtLWJpdHMiLCAmbnVtX2JpdHMpOw0KKwkJaWYgKCFyZXQpDQorCQkJbWF4X3Bh
c2lkcyA9IDFVTCA8PCBudW1fYml0czsNCisJfQ0KKw0KKwlyZXR1cm4gbWluX3QodTMyLCBtYXhf
cGFzaWRzLCBkZXYtPmlvbW11LT5pb21tdV9kZXYtPm1heF9wYXNpZHMpOw0KK30NCg0KIA0K
