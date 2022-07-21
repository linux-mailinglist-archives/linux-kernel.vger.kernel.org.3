Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC20357C523
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiGUHSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiGUHSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:18:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6907B797;
        Thu, 21 Jul 2022 00:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658387882; x=1689923882;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nqNMWFxXlmG+DPuJ4UJlZZEpuJiQ5uo3V2tLh8lbjJ0=;
  b=EgyTtWA5i/AAcxoCdpL6fTqH17xZ0kgqhxQOzeZu3qX7w8TGQ9+2ehLX
   VMs/oWgtokaIGItI3pebSU2Hjq5fqHqCruGEdd746WdVNRrei2SBpHbxA
   i+XEwRLyHplFRYn3QySlH0s1eWlfQcqJPUKzNipHM92H5Bemz5TjC3CzV
   tvNygrfFgzOcfHC8yRlCGmluRa6FJJUDYv/zTC+pEv4UzUeJe3JGFC5Vz
   lW/ZKQqA1vTnOquLjDTL9mDMb0YMNxy2NWg7mYWFdB3pydBRTmDICbKlX
   J5G/bIPDbmUCYaODwuh4xolETtjpZ6HaY2zoIPCmh/LdqCWaO8ybttoic
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="286981736"
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="286981736"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 00:18:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="687807941"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jul 2022 00:18:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 00:18:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 21 Jul 2022 00:18:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Jul 2022 00:18:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLy/ojKAzgplkSDe7t9urqc6qqwp8btQ4Oip0+NDDa1GLwRlYXL3JMCpN6x7md4FOajOIy6rS9iPYDwtaij71LWX/naw4w34X2YpH/QMadUPbqNqm3ovfu8Nf18THC3p0c1G2Zp6uBk1Z0nhboqCYDSjWISW49WY1fPusqxtmWkuI3L8lPrQAHKPXRw8Tp36c2eNpvKOPbIk0uwn4fyWWT3T3sJNtSRlaMgMCEo7LmtEw6EyDRb4FmzeyqNMGDveVv5g7Mnuqxlag3dlZOPKAhPn2s652bw9cQmnSXKA84Tqqpj9wZ8CQKsyTjJRJjukhEGi4YV95O6mJAQUzUhr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqNMWFxXlmG+DPuJ4UJlZZEpuJiQ5uo3V2tLh8lbjJ0=;
 b=M1NnLtHKi/bD7bR1EtAY4MLzGDqfpaExaz+6+i5FXsBH0KHgaSYLhM5OH/Zks80wUgIE8Y5vnsxAsHWWNgzjhkrA4AgaHnMlfVKN+nr6rv89rsnvJB84jpQQtveVlljnP8gS586oky9yeozoEcoRt5Jy3D+nmyscyQaH5t/qOdKIs6oTmbcay3BNaVhDkwj2Un65jRH1ZLdeprs3HtVZl0r4lYbQo0FVNTx+YGXfGQDwF2KVVP8Q4wdRQslMOo818sEmS/MgHmQ3CLANfCsqygjggiqKNht0vRppREJ59LCI2aKdko1lYk4BeZLgij07S2jQisTJH1Vj6DKDWH6HCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4918.namprd11.prod.outlook.com (2603:10b6:510:31::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 07:17:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 07:17:53 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>
CC:     "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 00/15] iommu: Retire bus_set_iommu()
Thread-Topic: [PATCH v3 00/15] iommu: Retire bus_set_iommu()
Thread-Index: AQHYkJHyZd+QwSLLdUeE2OO7F5m+B61/d/YAgAkKweA=
Date:   Thu, 21 Jul 2022 07:17:53 +0000
Message-ID: <BN9PR11MB5276BA4616A6F8DCF919CA728C919@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
 <f0374374-1f3b-6beb-b7e9-f8071d48bf4d@arm.com>
In-Reply-To: <f0374374-1f3b-6beb-b7e9-f8071d48bf4d@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33a80fb0-fd6a-4da5-7719-08da6ae9209c
x-ms-traffictypediagnostic: PH0PR11MB4918:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wGw8t/4CJnLu0zJfdGWhgOWwa/bv+dXi7w3+Y0NERrgPkzGYp6nmbIKBiO2xdRWiE+H6id1JTbxBPLWJb2SAnt2etN8s2IBxaDfCIcTVjJ7+iHSZQS8udpJRA5jK6vxdGspTG8p9cupdzLss6gKO/S/XGHfYT8rT60Rf2C540xy7Q8A8AZ+wkfR/bi6cLkL7LkXbhKOebnhetpAr1oO7d7lTTC45hQH4sbz/e7czwei0MYb8jHbAesyu4FXMBUIkdMVhHUR5r/HVADfRoy1ua/T3aehJHZoN+1Z5WTa4nHJt0pnVJ2CRSn7VXz56eC3GxLh7Dn64/qko9W03NE08dm68NHM/lUP8rTn08fb3/9VvOLDxK1zOkrzpu/PH8ze+BQxjvvZ6x24cx9/yHaDzPqUhCHaq3G/uerXnwrDWMnPutuQaFDyLuppllhUOEQNWsF5Q/nJbRtt14ym+BCMN2mRLKdj4iCkbs+NdcfBs3ggUc6ot8PqV/nznJ+7Bv9WUD1LOIbUJrfBBCVBAjuNoTJudggth9Z+HncvIcLDjlTyD4Z/DflHJnWA9TM3LZT7tgRNL3AJB23rIxU4xDbITgT8TBO+ilSAJ+m5mZQ0bzJBIMKSnQdZ27Kx4HPFfUbenFxupIgyagBMiC7vF05nZKf3CDTURfkZv+Dm8agSU4woK1zqnbzTG3/9fms7JFiJHZU4mxHv+CLgq518GH9Y0PfzR8y/cxrXK0cof/fBZyVnRFPBEBVTRfni5d2g0mUWTpgrLMy2ZaoHbR85kgUlDShuTSdIB68b7/scZtVig+d8uOieBc8xVtIbyi/4QMvQ/xpxoLdhYrcBMHXDRmc6kpHAKOZuVQKrU2z/FPoUsjLo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(346002)(366004)(39860400002)(26005)(7416002)(5660300002)(9686003)(110136005)(6506007)(52536014)(33656002)(41300700001)(53546011)(7696005)(2906002)(8936002)(478600001)(71200400001)(966005)(186003)(122000001)(38100700002)(86362001)(83380400001)(38070700005)(316002)(54906003)(55016003)(82960400001)(76116006)(4326008)(66476007)(8676002)(64756008)(66556008)(66946007)(66446008)(357404004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTF1cGJCaTRxVnIrTlV1b21YRWdsdDVUUm1SNGNsSkM2clhPajhkZEFaeEVH?=
 =?utf-8?B?b1pOQ2I3cUFDblFlSldBTjhXV04rRTJ0ak5WamNhMnJDMnlxUjh2cHNYRC8w?=
 =?utf-8?B?UFkrTTIzaHpKMStDWjM4SHEwZDdBS05BeWgzOFU0dUo5b0lPdXNuVUJTT2pR?=
 =?utf-8?B?TW05NkFWQ3ZuM2J6akFoQm1pZjlWWUF4eFdLdmlNMDliVmFtZVBSMThhMUhH?=
 =?utf-8?B?U2x1VmZSKy9LaUVONDVOaER4dHNJSFIrRUxodU4ycEtMcEJ4SXoyckpoUzYy?=
 =?utf-8?B?NTlxSGJOaENmMGpub1krOUE5aE1xTDJCMHFJd1o3WDBnK2xwQmZoSkoybkdR?=
 =?utf-8?B?MzJtc0VEdkJ6ODh6VS81VEs2NU95NzdmR1dyVlpMM1ZHWFZRSExxOFRkOW16?=
 =?utf-8?B?Z1VjQk1NQ0JDSU44V1JsL0dNY1hxQWlpemdWWXZzVE96NFdkWDNUbW9UL0FI?=
 =?utf-8?B?TXFNOE5BbHlkNlVqcFBpRXU1Z0VWbWsrOGgvZldTV3dhb0JqNnJRZjhVTlZJ?=
 =?utf-8?B?WXhoTTBHUXNXZmFNVklsbTY2WkdqMVNod2FyQ2Ixdkg2QXFjVGh4YzRhVE16?=
 =?utf-8?B?eDd4eHl1MHJRYm8ycVo0VlE3SmFSTm1hWWdCU2NWN2FuNThxbjRxRHFjczR0?=
 =?utf-8?B?WjBIbDFrTnBmcjhaeDN0dlN2TkNDemhucmxVRTc5RzYxN2ZTNWpVNVhualVa?=
 =?utf-8?B?cFFIT0xyRUYxaGRHK2o5ODZFN3VEeHlsc3U1VnIreWNlU25QOUZGLy9ITEVI?=
 =?utf-8?B?ekF5SDEwcVhWNFovZkFnTUxoVGoxSFVuYklzWCtHckdFUzBsRml5bFQ5Tmd1?=
 =?utf-8?B?eS9oUTNHZEs5UXVWS3RWM1pwK3lMeGc2ZVNRdkpYZWZlVmVncXozSHo0UFR5?=
 =?utf-8?B?UmpRbkVad29BNUxGMGxLVnE2bDBWcFJxdkxGQ3gyUXlJWXF6Y09NU25vRUFl?=
 =?utf-8?B?alFXQnBDUjR5RVRBMVFDREhUVXJqUlVIQjU0QlFFT2lsOExiYTE5RG1qOVpW?=
 =?utf-8?B?UVlOS052dUM1MHhYMWswVy9qdU14RElUVXN6emgySnhsVUpTZVI4STlsUE5Y?=
 =?utf-8?B?UUM5NUlyZXBrQ3FNQ01yaUlodUZ6bmx0LzhVcndYRnFtY3NUQlpRa1dzRjNN?=
 =?utf-8?B?c1U3c0l6eXNBMGtTNTJvbENlTU1vT0J1K3Ftb2NETmFKdlV5S1J2RkN4ZTh5?=
 =?utf-8?B?L0c4VnRTM255TFJ4SUpOYWlyVHBMbEV1NzRpUXZVM0ROaHQ5eWxPOHhWMEg0?=
 =?utf-8?B?b0NsMkoxVjJGUDFMdXJaSkU3bHNrZ1pnZ2RCd1J3bzQzelgwbjNVeEV3UWFm?=
 =?utf-8?B?VTU0bXZTL0hCV3ZET0tZNXJxd1RwV1dsZkI2Z29hb01WdXFIMjN4b1piTXdu?=
 =?utf-8?B?clErWjZGNVpYWDUvdGNVQnZNemJQcWlVM28vd3o3QzRtZm9aOTRPSWFWRWFZ?=
 =?utf-8?B?eDhSZWtsZ3JDcmU1TDMyNm54NHZJcTZJMnJ2M0xqNVV2VkZ4QisrR0tFQjNE?=
 =?utf-8?B?eGlkYlRSdmlpUTRjczNjVjMvdjVDYzlXWTUxZXN4VTR5cFJQa0pGUTE4ZlFa?=
 =?utf-8?B?V1Z2QlBSdXFXTzQvV2ZQaHZYSFk1aWUvUCtYZGFiWGRMVElRM2x6NHRBZDdu?=
 =?utf-8?B?RG8rZnB2R3g2c3k3WnVqRkJLWmsxQkYxdUJBVHJ0dExSTEZiMEp6UkJhNHd4?=
 =?utf-8?B?cWFoN2duSlJVR3hIUEI0eGt0TTdrOVlLMTFFNkthTjQyNTF1UVIxQ21aVEh5?=
 =?utf-8?B?RmVRd0p4SlE3QVZ1YURPYnl3N0sza002YUlHdmcyOS9mTnlTM1plVnU1dlZV?=
 =?utf-8?B?cjlkL3hYQ1I0cGtwT3o0anZkYjQveVd4d09zYmtiMlg5VWRuekJrdHhYWGVE?=
 =?utf-8?B?SS94eVd6R3F6VjdEd1EvWC9oUk05MnRuc0d6MEJjdkIzWXJzb0ZMeGJqZGxj?=
 =?utf-8?B?WVVTK3U1TEhSSzlWSERPR0o1b0dDazZPSGttNEpNTzZHSFJETUtrN2pkNUFI?=
 =?utf-8?B?aEFLcldueDBZMmhmRWhGOXVTaGNZYjBuVjRuNHc4U1laajFhWGhIbjNHclZz?=
 =?utf-8?B?TzRCbHNIM0xObG9RelVDRllsbWtFR2NJajY3S1VWOXNLdXZnTTBmeW1JM1l0?=
 =?utf-8?Q?i6PowrjiN/6k7Ngxcmm3r7HEB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a80fb0-fd6a-4da5-7719-08da6ae9209c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 07:17:53.3239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdGQnExufbhAuz8I3RONd6883RF18cFGKL7YVRn4kLUJltNlci+tRW552xWn4e3vGPA5Krd6t7MQsQhBWmsB7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4918
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bHkgMTUsIDIwMjIgOToxMyBQTQ0KPiANCj4gT24gMjAyMi0wNy0wNSAxODowOCwgUm9i
aW4gTXVycGh5IHdyb3RlOg0KPiA+IHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC0N
Cj4gaW9tbXUvY292ZXIuMTY1MDg5MDYzOC5naXQucm9iaW4ubXVycGh5QGFybS5jb20vDQo+ID4N
Cj4gPiBIaSBhbGwsDQo+ID4NCj4gPiBIZXJlJ3MgdjMsIG5vdyB3aXRoIHdvcmtpbmcgeDg2ISBI
YXZpbmcgZmluYWxseSBtYWRlIHNlbnNlIG9mIGhvdyBJDQo+ID4gYnJva2UgSW50ZWwsIEkndmUg
Z2l2ZW4gQU1EIHRoZSBzYW1lIGZpeCBieSBpbnNwZWN0aW9uLiBJJ20gc3RpbGwgbm90DQo+ID4g
MTAwJSBzdXJlIGFib3V0IHMzOTAsIGJ1dCBpdCBsb29rcyBsaWtlIGl0IHNob3VsZCBwcm9iYWJs
eSBiZSBPSyBzaW5jZQ0KPiA+IGl0IHNlZW1zIHRvIHJlZ2lzdGVyIGFuIElPTU1VIGluc3RhbmNl
IGZvciBlYWNoIFBDSSBkZXZpY2UgKD8hKSBiZWZvcmUNCj4gPiBkaXNhcHBlYXJpbmcgaW50byBQ
Q0kgaG90cGx1ZyBjb2RlLCB3aGVyZWluIEkgYXNzdW1lIHdlIHNob3VsZCBuZXZlciBzZWUNCj4g
PiBhIFBDSSBkZXZpY2UgYXBwZWFyIHdpdGhvdXQgaXRzIElPTU1VIGFscmVhZHkgcmVnaXN0ZXJl
ZC4NCj4gPg0KPiA+IE90aGVyd2lzZSwgdGhlIG9ubHkgb3RoZXIgdXBkYXRlcyBhcmUgaG9va2lu
ZyB1cCB0aGUgbmV3IGhvc3QxeCBjb250ZXh0DQo+ID4gYnVzIChub3RpbmcgdGhhdCBpdCBub3cg
dGFrZXMgYWxsIG9mIDQgbGluZXMgdG8gc3VwcG9ydCBhIHdob2xlIG5ldyBidXMsDQo+ID4geWF5
ISksIGFuZCBhIHNsaWdodCB0d2VhayB0byBtYWtlIHN1cmUgd2Uga2VlcCByZWplY3RpbmcgcmVn
aXN0cmF0aW9uIG9mDQo+ID4gY29uZmxpY3RpbmcgaW9tbXVfb3BzIHJhdGhlciB0aGFuIG5lZWRs
ZXNzbHkgY2hhbmdlIHRoYXQganVzdCB5ZXQuDQo+IA0KPiBGV0lXIEkndmUgcHJlcGFyZWQgdjQs
IGluY2x1ZGluZyBNYXR0J3MgczM5MCBwYXRjaCBhbmQgc29tZSBuaWNlIGV4dHJhDQo+IGNsZWFu
dXBzIHRoYW5rcyB0byBLZXZpbidzIHN1Z2dlc3Rpb25zLCBidXQgaGF2ZSBub3cgZGVjaWRlZCB0
byB3YWl0IHRvDQo+IHJlYmFzZSBhbmQgc2VuZCBpdCBhZnRlciB0aGUgdXBjb21pbmcgbWVyZ2Ug
d2luZG93LiBJZiBhbnlvbmUncw0KPiBpbnRlcmVzdGVkIGluIHRoZSBtZWFudGltZSwgdGhlcmUn
cyBhIHByZWxpbWluYXJ5IGJyYW5jaCBoZXJlOg0KPiANCj4gaHR0cHM6Ly9naXRsYWIuYXJtLmNv
bS9saW51eC1hcm0vbGludXgtcm0vLS9jb21taXRzL2J1cy1zZXQtaW9tbXUtdjQNCj4gDQo+ICh0
ZW1wb3JhcmlseSBpbmNsdWRpbmcgdGhlIGhvc3QxeCBwYXRjaCBmcm9tIC1uZXh0IHRvIGF2b2lk
IGJyZWFrYWdlIG9uDQo+IGFybTY0IGFzIHdlbGwpDQo+IA0KDQpUaGlzIGxvb2tzIGdvb2QgdG8g
bWUuDQo=
