Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6E44712E9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhLKIjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:39:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:34555 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230046AbhLKIjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639211957; x=1670747957;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JQYY3tZx5j034biYdsppYkpqNnp9+Yx70wc/mm2EX6c=;
  b=ZzVcybCC2UTaez3qux2ZsMA8ak18Nhi1h5nGA5Pizv3ax5vQMKkX9t8n
   WKW59XT90nuDxXkI5/2CGtBa2mcOEL4qfvmQy8GLP0NMyV5MzAQt+bkjy
   8jAjU6Rypa8LgEs6VA6M2C+I01ZelJ+wVdkj5oDoX0e/eMofct7daiMjc
   RObQIKMdomh7TdR+VFBL0cSHYHD87R/eWwCnwHT1kQmzY0wMrmNC/UAQc
   EaQoT6Yk+PLjnoQZPsRf2lVMsfUdP8uW0tbC0+0pyhjqvvkY5fR5NimIr
   w6dQ51hjl2Pw2EUJJhIs8O40NuKcjrQbsuaxHtrQG2j/2Frhe4rB1qoWT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="218540194"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="218540194"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 00:39:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="681030313"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 11 Dec 2021 00:39:16 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 00:39:15 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sat, 11 Dec 2021 00:39:15 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sat, 11 Dec 2021 00:39:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOWRa+cjwckxUpCUgZQXmCt+wl/IrkhNyqsMaZch35uHoEJ1BLsHHKdD3RH6SwW+54O1xWpioRprFnQCjIwquYRVyFNJzA9L4gpy9lPtEMD0YbxHXvHdCYdgD4Dx3G+6VpKEjsaXzSTtUqUsm08gZug2gtDcn7IfjBIWS9S4Wr2IGLd8F6mkzijIU52Fcd6uCl0vpRAN7i6+TEqkEVEVJxQaWdhWsfvsEqV8epd6ESvrFlQEbuU36WNidLj8JeKgs2sviBHDJQcjLHQp0cBXG96hbvD50pM6yrENrJOzpWg9rtjLpNuriayaM4Vc//z6/J2yWvXv3dY0VlCPDsEslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQYY3tZx5j034biYdsppYkpqNnp9+Yx70wc/mm2EX6c=;
 b=IemI1GTBp4RHIzIjSe2lMJDu9FbnLt5vskSscHll4YD8ZicHWzxAkbD5FdvcMVbHSUeAwzwvrOTBr765clkmzo/Tmm+Db+wJbokQRSvYCAcfF9RlyNN10NvVmz/kpDUQG8VI+s/ibLCvKfGLSPULeG6M1WbyqqB989jCQve4jRqhWmGjM1MCGegKkeFp335npnbJvoxIxpmqliqAM+3TwHVgv7XZVunK76/tGirryQfKhZTqvWAvkY6PQ0wISvlg4nDTXS4KajyTXpESwZWvNOE8dV1/I25tveAr5neJLC40nMybaX8o5KlOPWhIIaSZRINCWCKdQeeRyORcBdUf/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQYY3tZx5j034biYdsppYkpqNnp9+Yx70wc/mm2EX6c=;
 b=F3VS0+J4WBECzbggjAv1BT3bJ3IrPGh4/7jUmyao5E8AVKJ+5h73MTBYNSl4IBYCgpLkYzB86RRx3MI9hbj05/P+LR7x3VRt14aaOP6aoo3eAlM12B2NtesM/qPVMB2bzBl5/AIwDaxCZ9NClLIP4omUxTDUdOhfnDl4Ho7o/Ko=
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Sat, 11 Dec
 2021 08:39:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4755.016; Sat, 11 Dec 2021
 08:39:13 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Barry Song" <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH 1/4] ioasid: Reserve a global PASID for in-kernel DMA
Thread-Topic: [PATCH 1/4] ioasid: Reserve a global PASID for in-kernel DMA
Thread-Index: AQHX67qzj7epRHVbnkm9fM285sFVK6wqAU6AgAB4VQCAAPlQAIAAOTWAgABdfYCAAOvBgA==
Date:   Sat, 11 Dec 2021 08:39:12 +0000
Message-ID: <BN9PR11MB5276CDA4303C18369178DECF8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1638884834-83028-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <YbHie/Z4bIXwTInx@myrica>       <20211209101404.6aefbe1c@jacob-builder>
        <YbMYkKZBktlrB2CR@myrica>       <20211210123109.GE6385@nvidia.com>
 <20211210100545.373c30d1@jacob-builder>
In-Reply-To: <20211210100545.373c30d1@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f02edc39-0ce0-4d6f-11e3-08d9bc81b57f
x-ms-traffictypediagnostic: BN9PR11MB5227:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <BN9PR11MB5227F75A97FEB1DBE3AE74D58C729@BN9PR11MB5227.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wJsely1KCHRlSg0iLeTiq/uTSPDTl1UC5e2IK9yDwPSUh7mK1I2mOhZwXiQ6WBdNAJ+uSM6EhYBK2bruoP2DQxN2ZlYA1CqmDlkDCawEuvOM27dYtnz9V1dlnHbbHSO6jxabVkvnXPauhZOnj0bwGiXYc/8EclR3y/BA6t+j2m7uD87YJkB0EDNLupe+ASQFANC6I+580JQLREO57+LrKW3g/QdqsZ+9K3GQLr2QEz5VwCXIUqJj11h7iVJjtu9zn8ZvpN/gkQ8/v/fFrjvxxn3c45uSEfht1lOae/dVhUJN26oHUjBOLpR39gfCDeiwuhdHgPrhxJ/OgPYZOsGNDeqzShELCopiFoFI3QIbtQQ+XwDfn+THzGwNwhLXym3F4KWAG+eAy76qL3knhwK2lwOmgQXL08brO0evWaoXAFtYfwuz2gJWxG8V3OiLYW7cvl5lpmstUNmEjDEVRFfhoTT55rZ5eoHvKopmN/+WPd1DPzklfRuLRzJAOLyeGP7aNRfS5iRqChMuFpy/szCD6JqK2z7nGBwCt0YTOsWQYFilqkeSJUkuga+Vw34wuFbURcMo37R/Zv1yEiGr55O20iHAZVrp2JGuXhyWKTDYWSf1OKgcWKGnEuV9+K9cMobCWWcUTpQcV+EYJN39VMxaSZTK/HhKJEjW3Kd0jHG1ifFxp3rSBiYh3W4cRsbK89Z4DRT1IMcQKPBPPHk9GbIm9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(7416002)(9686003)(54906003)(8676002)(316002)(76116006)(66556008)(5660300002)(66446008)(4326008)(110136005)(508600001)(71200400001)(7696005)(6506007)(26005)(122000001)(86362001)(38100700002)(83380400001)(55016003)(8936002)(2906002)(38070700005)(186003)(82960400001)(33656002)(66946007)(66476007)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amlkbjh1WU13QzMxSjQvaW9kdU5BRnVtTktWTTErcmY5eFBZSmE1cXJweEo0?=
 =?utf-8?B?dDFITDg3cERGZGNuZkw1RXl0THdDb1RoSDhOOWgxZjd1ejNhNnl2MUxIay9R?=
 =?utf-8?B?cWFCbFQyNXIzMk4wSVVVUDd1bDg1MmdDLzd0TFJpNGZrN3dPKzNycG9jZVV4?=
 =?utf-8?B?UkFKVjM2ZllsRkxiMk01L2kyNG5jNm5CTGt1cytxc1V3d29scVEvckY1TlE1?=
 =?utf-8?B?dUswQm5XU3FCWGFpVlFsazlmY2sxc2grNE1QQzNhRzgydkdyNTNPYjdzck5j?=
 =?utf-8?B?aXczYVJyRGkzZ0lnNitXTm9vZGlSM09Kck9NaThPS3RMT09wL01GNlRjYkpW?=
 =?utf-8?B?UHZFZkFrZ3FSNGhHbVNyVUJ0cDN3VnRZaGk2STZSVTBWVDBHbVNSQXJ0a2E4?=
 =?utf-8?B?R2dtQ24zY25yaXZUdFNrcXhGUm1nZXZMVTVSV2dVK2ZrZllkL1BvRExZZVZT?=
 =?utf-8?B?aVRaQ2szN1hueUtmTzhGRlhrdGdsRHRNODRkazByalZxS0ZzdTBER2JRN2Yw?=
 =?utf-8?B?bmtkSUk4bFNjYjUzOTVxMTdrRVlzWCtlaW5McWE3a2N2YTN1Qkw3MmFKWDVL?=
 =?utf-8?B?NVUzQnVvenRHRXFWY2Z6MlQ0SUtzTC9HRW1iR0RVSmsrdG9aUk5QSnlWTzZJ?=
 =?utf-8?B?NDFUS3pxTU9rSDcwRUdad0ovcHlvL3p4Y1BMSUx2Q1ZRVmM2UHRFN1ZkMUdE?=
 =?utf-8?B?Qm1BNjNRcUwyS2RhRXZRNGxFcTZDRm5BMTBBV2laV1BOcXAxVXdOTGVTYWpx?=
 =?utf-8?B?N2MxZ1VxTURxbFRDUlcrUk5WdHBnUjlnSkJsdzBIeGlNSTYrbFVoeGtBZDlj?=
 =?utf-8?B?NnhVZjljY245VzIzMnQ1aTAzMVNCOXZsMGJKdGFzeFdmbEdNNS85TmJaVERz?=
 =?utf-8?B?bHBHVjhsa0FoTnFoUDNDSy9BalR3bFNqMkZCZ0gwNXhMeDJBNTJTeXFHVFpN?=
 =?utf-8?B?V2Yydm9WUUVTdmdPQUhhRnF4QUxyelFES1BIWTFId2orQi83bnpRUWFBQkky?=
 =?utf-8?B?dkY0Z0MyT0RHMndhNnhvKzlzRkExRElSV3lZT0ltOHM5dDBQcndnVXA2U2hG?=
 =?utf-8?B?NWdzOERwc3Z5d2lYUzBLb0lHQTkrcXU2TVJJMytoZGs5OFFoc0M4ZTB2Mmgr?=
 =?utf-8?B?aEdQRElRQ3FMTmZwbnBMa0ovbWw4UnRWRHM1WW1sUnNJS0ZYV2MzK1VBa282?=
 =?utf-8?B?ZlRoZEQ4bCttOW5HRUpWY2hWb3NtbElFUDhhd0RzVnRHdldpeGplM3JKZmpP?=
 =?utf-8?B?b3ZHVHdPbXZNemo5QWdsTityc05ndGF5d0h2TmNIZnc5ZXA4aWJWWkFpNFRm?=
 =?utf-8?B?cGNYMzBuSmpiMzROYUYzS2Q5dE0ycDNBZ2VpYUhzbkxXeTNJSE9WcVY3Um44?=
 =?utf-8?B?U096VWdaNG05THRmM2JDK05yVTlKNHBDSXBGQlAvOEtMRTg1OHRTQWQ0Znk1?=
 =?utf-8?B?Wlg2UVdpbkpoVW9oT3RHNXBtVzdoZDZaVEJMQi9nVmtINDBuNExvZkREa3Jh?=
 =?utf-8?B?LzRqMTlUY1JZZzZ5a2FOZlpGZFVDTDRQZXUxUC8ySzJWK1B2RXU5alF1QlRn?=
 =?utf-8?B?RS9aRkR3TnhZa3pIRGVBaTJVYWFEeG8rSGxkVWpFVkNTc0ZvL2IyOHlMeEFO?=
 =?utf-8?B?L0JhcUJ3RXRLMzRjdGFIanlXVnFUK20zTS9zVjluSE5nS2xmRHNXTUtOTzlX?=
 =?utf-8?B?L0pqMEs1V29DWmJJUFFvc3JWN2QxMDVnTUhDN2pRb2wrNi9rdzRSRkdXY2lq?=
 =?utf-8?B?dEhiWU9NSmRHSURqNjhYeEZFZ2VCYTArUmthc3dJQ2lNaGczT3RwQ0VZTFZy?=
 =?utf-8?B?ZW1qY0hxN3ljWW5RbE5tcXZ5bXU5TG9wYmVwalVvSEJQTkI1UXdiZVF6OHlk?=
 =?utf-8?B?TUd2VnJDVTFDQmdVZHYyaksyQmhOV2orVVhhNHdiSXplNDBicTVzdllxK3Nv?=
 =?utf-8?B?MmxPcTNQekVDbFhqU0MvdmllemM4WUREbTVtWnkzckh6Qkt5a2JRS0tFRGpi?=
 =?utf-8?B?N3ZzMWZFYjVVKzBtak5acy9CdTBseWFYZy9YcERaV3pnSzYwMmxmbFZYQkJk?=
 =?utf-8?B?ZGxjVDAwaUxiM0N1ZmZGQWhld245MitjZ1UrY2JVQ1E0RnI5VGpFYnZiVlh6?=
 =?utf-8?B?RHFiYVR5dXFDMkk0YW9xY0R4MkNYZ1VDWmJGVmdVSUlkT2IrR1VJa1JZb2tj?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02edc39-0ce0-4d6f-11e3-08d9bc81b57f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2021 08:39:12.9033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EBvzXMgGC1ayu3pJksznMwohPovNNRi3U9gYOQz+2WIZUKWtrFCA+2nzGBTDpTSmVzwWbwHZ4m1L0gFDpI/SMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50
OiBTYXR1cmRheSwgRGVjZW1iZXIgMTEsIDIwMjEgMjowNiBBTQ0KPiANCj4gSGkgSmFzb24sDQo+
IA0KPiBPbiBGcmksIDEwIERlYyAyMDIxIDA4OjMxOjA5IC0wNDAwLCBKYXNvbiBHdW50aG9ycGUg
PGpnZ0BudmlkaWEuY29tPg0KPiB3cm90ZToNCj4gDQo+ID4gT24gRnJpLCBEZWMgMTAsIDIwMjEg
YXQgMDk6MDY6MjRBTSArMDAwMCwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOg0KPiA+ID4g
T24gVGh1LCBEZWMgMDksIDIwMjEgYXQgMTA6MTQ6MDRBTSAtMDgwMCwgSmFjb2IgUGFuIHdyb3Rl
Og0KPiA+ID4gPiA+IFRoaXMgbG9va3MgbGlrZSB3ZSdyZSBqdXN0IG9uZSBzdGVwIGF3YXkgZnJv
bSBkZXZpY2UgZHJpdmVycyBuZWVkaW5nDQo+ID4gPiA+ID4gbXVsdGlwbGUgUEFTSURzIGZvciBr
ZXJuZWwgRE1BIHNvIEknbSB0cnlpbmcgdG8gZmlndXJlIG91dCBob3cgdG8NCj4gPiA+ID4gPiBl
dm9sdmUgdGhlIEFQSSB0b3dhcmRzIHRoYXQuIEl0J3MgcHJvYmFibHkgYXMgc2ltcGxlIGFzIGtl
ZXBpbmcgYQ0KPiA+ID4gPiA+IGtlcm5lbCBJT0FTSUQgc2V0IGF0IGZpcnN0LCBidXQgdGhlbiB3
ZSdsbCBwcm9iYWJseSB3YW50IHRvDQo+ID4gPiA+ID4gb3B0aW1pemUgYnkgaGF2aW5nIG11bHRp
cGxlIG92ZXJsYXBwaW5nIHNldHMgZm9yIGVhY2ggZGV2aWNlIGRyaXZlcg0KPiA+ID4gPiA+IChh
bGwgc2VwYXJhdGUgZnJvbSB0aGUgU1ZBIHNldCkuDQo+ID4gPiA+IFNvdW5kcyByZWFzb25hYmxl
IHRvIHN0YXJ0IHdpdGggYSBrZXJuZWwgc2V0IGZvciBpbi1rZXJuZWwgRE1BIG9uY2UNCj4gPiA+
ID4gd2UgbmVlZCBtdWx0aXBsZSBvbmVzLiBCdXQgSSBhbSBub3Qgc3VyZSB3aGF0ICpvdmVybGFw
cGluZyogc2V0cw0KPiBtZWFuDQo+ID4gPiA+IGhlcmUsIGNvdWxkIHlvdSBleHBsYWluPw0KPiA+
ID4NCj4gPiA+IEdpdmVuIHRoYXQgZWFjaCBkZXZpY2UgdXNlcyBhIHNlcGFyYXRlIFBBU0lEIHRh
YmxlLCB3ZSBjb3VsZCBhbGxvY2F0ZQ0KPiA+ID4gdGhlIHNhbWUgc2V0IG9mIFBBU0lEIHZhbHVl
cyBmb3IgZGlmZmVyZW50IGRldmljZSBkcml2ZXJzLiBXZSBqdXN0IG5lZWQNCj4gPiA+IHRvIG1h
a2Ugc3VyZSB0aGF0IHRob3NlIHZhbHVlcyBhcmUgZGlmZmVyZW50IGZyb20gUEFTSURzIGFsbG9j
YXRlZCBmb3INCj4gPiA+IHVzZXIgU1ZBLg0KPiA+DQo+ID4gV2h5IGRvZXMgdXNlciBTVkEgbmVl
ZCBnbG9iYWwgdmFsdWVzIGFueWhvdz8NCj4gPg0KPiBDdXJyZW50bHksIHdlIGhhdmUgbW0ucGFz
aWQgZm9yIHVzZXIgU1ZBLiBtbSBpcyBnbG9iYWwuIFdlIGNvdWxkIGhhdmUgcGVyDQo+IGRldmlj
ZSBQQVNJRCBmb3IgZGVkaWNhdGVkIGRldmljZXMgKG5vdCBzaGFyZWQgYWNyb3NzIG1tJ3MpLCBi
dXQgdGhhdCB3b3VsZA0KPiBtYWtlIHRoaW5ncyBhIGxvdCBtb3JlIGNvbXBsZXguIEkgYW0gdGhp
bmtpbmcgbXVsdGlwbGUgUEFTSURzIHBlciBtbSBpcw0KPiBuZWVkZWQsIHJpZ2h0Pw0KPiANCj4g
Rm9yIFZULWQsIHRoZSBzaGFyZWQgd29ya3F1ZXVlIChTV1EpIHJlcXVpcmVzIGdsb2JhbCBQQVNJ
RHMgaW4gdGhhdCB3ZQ0KPiBjYW5ub3QgaGF2ZSB0d28gcHJvY2Vzc2VzIHVzZSB0aGUgc2FtZSBQ
QVNJRCB0byBzdWJtaXQgd29yayBvbiBhDQo+IHdvcmtxdWV1ZQ0KPiBzaGFyZWQgYnkgdGhlIHR3
byBwcm9jZXNzZXMuIEVhY2ggcHJvY2VzcydzIFBBU0lEIG11c3QgYmUgdW5pcXVlIHRvIHRoZQ0K
PiBTV1EncyBQQVNJRCB0YWJsZS4NCj4gDQoNClVuaXF1ZW5lc3MgaXMgbm90IHRoZSBtYWluIGFy
Z3VtZW50IG9mIHVzaW5nIGdsb2JhbCBQQVNJRHMgZm9yDQpTV1EsIHNpbmNlIGl0IGNhbiBiZSBk
ZWZpbmVkIGVpdGhlciBpbiBwZXItUklEIG9yIGluIGdsb2JhbCBQQVNJRA0Kc3BhY2UuIE5vIFNW
QSBhcmNoaXRlY3R1cmUgY2FuIGFsbG93IHR3byBwcm9jZXNzZXMgdG8gdXNlIHRoZQ0Kc2FtZSBQ
QVNJRCB0byBzdWJtaXQgd29yayB1bmxlc3MgdGhleSBzaGFyZSBtbSEg8J+Yig0KDQpJTU8gdGhl
IHJlYWwgcmVhc29uIGlzIHRoYXQgU1dRIGZvciB1c2VyIFNWQSBtdXN0IGJlIGFjY2Vzc2VkIA0K
dmlhIEVOUUNNRCBpbnN0cnVjdGlvbiB3aGljaCBmZXRjaGVzIHRoZSBQQVNJRCBmcm9tIGEgQ1BV
IE1TUiANCihtYW5hZ2VkIGFzIHBhcnQgb2YgWFNBVkUgc3RhdGUpLiBUaGlzIGFzc3VtZXMgYSBz
aW5nbGUgUEFTSUQgDQpyZXByZXNlbnRpbmcgdGhlIGFkZHJlc3Mgc3BhY2UgZm9yIHRoZSB1c2Vy
IHRhc2sgcmVnYXJkbGVzcyANCmhvdyBtYW55IGRldmljZXMgYXJlIGF0dGFjaGVkIHRvIHRoaXMg
dGFzay4gT3RoZXJ3aXNlIHRoZSBrZXJuZWwNCmRvZXNuJ3Qga25vdyB3aGVuIHRvIHNldCB3aGlj
aCBQQVNJRCBpZiBtdWx0aXBsZSBQQVNJRHMgcGVyIG1tLg0KDQpUaGVuIHRoaXMgc2luZ2xlIFBB
U0lEIGhhcyB0byBiZSBnbG9iYWwgY3Jvc3MgYWxsIGF0dGFjaGVkIGRldmljZXMNCnRvIGVuc3Vy
ZSB1bmlxdWVuZXNzLg0KDQpPZiBjb3Vyc2UgU1dRIGlzIG9ubHkgb25lIGNvbmZpZ3VyYXRpb24g
Zm9yIHVzZXIgU1ZBLiBJbiB0aGVvcnkNCm11bHRpcGxlIHBlci1kZXZpY2UgUEFTSURzIGFyZSBz
dGlsbCBmZWFzaWJsZSBmb3Igbm9uLVNXUSBjYXNlcy4NCkJ1dCBnaXZlbiBtbSBpcyBnbG9iYWwg
YW5kIHRoZSBTV1EgcmVzdHJpY3Rpb24sIGl0J3Mgbm90IHdvcnRod2hpbGUNCm9mIGFkZGluZyB0
aGF0IGNvbXBsZXhpdHkuLi4NCg0KVGhhbmtzDQpLZXZpbg0K
