Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C832756B269
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbiGHFuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 01:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiGHFuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:50:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC922F01D;
        Thu,  7 Jul 2022 22:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657259414; x=1688795414;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/4rAYSQmiQD4naSfWHjNSbIbs57ysF2aYOgDWDdM5j0=;
  b=XFG5EYesPTkXpuWib+KUQHnBeX+Du2s6+0K4blwi7cPzr063MIekn0od
   +y3jKiBCzp0HriWckAd6aRzraIs/Vfr8W7CUF7z2ptvuZjvW8n7HkjweL
   jS1SfH4uN3eg5lmq/6juzKU3fqkYUZBVpPzra0hIweJOw0Qu1rx0liMNI
   xRq06rAXYvzNvtkCOi59C3i5K5aulDc66IuM6Jrntdii+CiOjKk6G6+tF
   kbkJDZ/4Q8FFjxxNlntKkEEnp3xhu6IOa1fL5mmeRfxGQ1B8zeYg0m4wb
   ihBTVZRaw3sKdSkkFNBBNtJ8qxIQ6aeUt9Z12XqbuIMxs1nwqcqB5+dep
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="263977382"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="263977382"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 22:50:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="720772354"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga004.jf.intel.com with ESMTP; 07 Jul 2022 22:50:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Jul 2022 22:50:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 7 Jul 2022 22:50:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 7 Jul 2022 22:50:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDovdIqcvdgJNaFlDGYkuxJKLMOaJPy0zkEA6Medip8bFDTW5HFwxI8dpyE5m4BjQz3A04SlgsaSut6nBo5fmbdmTa8xR2Wrq62u1esOESgaz9TjjIOdhNlFC2mCHjayXbYG9wtXaS8ACPDxE0XgcfNtx63a0YsmabNFmHaWeDYWBLhaySBS/Gw7A5ZAxWosVwPICEdnWAzTaYWtQm710XRm7qfHiB5s+inuD52YY5sckolPgNh4AMq9fiFT0vVnkL9REBxmABAoyzQ0dqoBpr8AVs3nQtzp09c6+/xqTQWEdWyZsXw8eW8hLnKjvHjcqPqeWA+TXp1oaa6uI9SntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4rAYSQmiQD4naSfWHjNSbIbs57ysF2aYOgDWDdM5j0=;
 b=GvOe7xeNAINBoHzpFMudnfgVNncZbQrULtM+BxgD1rgvxS3H5d1pvs2aKwzq5ZOCOwHUeWP8cubWZv238e+09nnTDSgE1m1JcjxOhP7D7AJNWvkUgHqTt4cSREE/O0km3BstAg7ackdriWg2oIy2Bu2WknoG9Yg8LTu9/YYAZlSrv/N/CL9YCAEcpyXtSD44YpbFjHQlJyq2MeDkEGeuKOs00URihM5taHPDR3wCQsLnDUN6jgePTlNOJny5wGfSympx/o+JDhCqN9JpX8X9AhrnJa9spqNq4IXbyDxVb6FpYe5TNJfPZBdDvOetj9A7YQLvq3OfSVEieOM9PfCdxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1474.namprd11.prod.outlook.com (2603:10b6:405:c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Fri, 8 Jul
 2022 05:50:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.021; Fri, 8 Jul 2022
 05:50:12 +0000
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
Subject: RE: [PATCH v3 03/15] iommu: Always register bus notifiers
Thread-Topic: [PATCH v3 03/15] iommu: Always register bus notifiers
Thread-Index: AQHYkJHsAUneNaK+AUyHBuGFcsQDbq1ycmEwgAA80gCAASrFUA==
Date:   Fri, 8 Jul 2022 05:50:12 +0000
Message-ID: <BN9PR11MB5276B29475369F0868E4ABCE8C829@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
 <8c380309f264cd0dfc73ba2ec060adc9515af2f2.1657034828.git.robin.murphy@arm.com>
 <BN9PR11MB5276B6689D88D3D5D57915908C839@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f3a7143c-5e89-817a-a33d-7353d51a987d@arm.com>
In-Reply-To: <f3a7143c-5e89-817a-a33d-7353d51a987d@arm.com>
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
x-ms-office365-filtering-correlation-id: 9dda7be9-da32-4d0f-5f23-08da60a5b953
x-ms-traffictypediagnostic: BN6PR11MB1474:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /cDlg9HnTLRsZnvjB670oXpIRwNCc4w/+qNRHTnXGVr4ONfetG30r/9dp2aPhptSOyROJjt8SBZAwUgD5Y7g4FP7eFiYPfbrS/oeMfj1ICXAFLRa8+xvvUDZajSA5Oko+z4GwC49rMr6jZfc5stCvT8ASKlFV8uA/IXn4RHnlMVLsndIYyaheLVuK/1airudV8P1W6KNLkykclaBaDXzC/z/CJfAkpj0w7nVapXEI9NuqCR5+H3Zakn8siChDe4R+wVt14YT1IpBpsqecEsSB3IWjwyYj8jC6EuGWBn0U3Xy+sG3ElZYPfShFngop3V3mnomhcfnADIpnc5k2uh6tW1660sspW1bANKLe83cVmAHWZaWi7wyGwq/P93r5WYwnCUU9dwz0HeAkiqc4IWMyt2B7NqpDi0wOKMRoEZ4IUQj/y1Yey1bElYH013GDCEfsXuK60RpSp1C0JmYLdGnUDuzLI0NkMgyxFORneI+QkideqN7/O6WvD3iIUxFMy7GnXBYYbO02rVBHWyPohz+n+ghyQ905vS8clW5aAsv1j2Eh/+oazQoOBoGLtWy5xPHMlZ0N/IbFGy207vSPimqApOJcPkS0+7V7Av1xK5SyxFBzSRwo92hsz5DTgdbvgIV30YocmbVQ5wkmae+NxIRkU5vcUZtIrkSdTPaU8pHiiWz9cG5IpNboGOpvf/pOIe1s73Oxjt8ss1S/4vXshcWKNigZnF0JQF4u36TArqDjFqGvLkvm6R0be9xdgOmv+VWlLg20c/i1OEZQ8/yrVJ2JvFoEMLaGH6Gq+Bqxr7yDoNIM6wpZLGIcjEJcF89BsYX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(376002)(366004)(136003)(86362001)(83380400001)(38070700005)(8676002)(71200400001)(4326008)(53546011)(26005)(52536014)(66556008)(2906002)(41300700001)(478600001)(66946007)(8936002)(66446008)(66476007)(82960400001)(76116006)(64756008)(33656002)(122000001)(5660300002)(6506007)(9686003)(186003)(7696005)(55016003)(7416002)(316002)(54906003)(110136005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0xkUkFVVTc3QWpJRGRudWxYcTJkdk9sUGg1TEtDaE9Tc2JEa3RDeGVMY1pu?=
 =?utf-8?B?U0VNbERMZ2pzYXZtZE01QVR1Y0ZKY3dsZFhlQUJnRlRmZDExTDVBSGpmNUF5?=
 =?utf-8?B?aWoyTUlJT1RpejdiQkpQSlBBSDlRd1dUOTVIRHlpTk9EeWhnVDM5T0dwZytF?=
 =?utf-8?B?Lzg1NlBHK3ZqNVVBMjFpNyswTGZsUk01Kzd1SVpkZDM0Q3hmUEhzaVVKcUpp?=
 =?utf-8?B?WjFBM1ZJN0tpNElTaEZyOGxwWlByNUJSUnMydXdBTFY0K0NYZmtiTTJHNzB3?=
 =?utf-8?B?Qkp3cTQ0UkFXUW92MTN2S1ptOENBbWxpTkpZdTNBbGR1bVU4Q041aVFndU1k?=
 =?utf-8?B?VzBYZkFtMElZTmM5ZHJkMWlKOU84V2RTS2ZFOXROYjV6V3ZXZ3drMlROQ1Yy?=
 =?utf-8?B?clYvR3lOSm92QzZLTWJyYVJUNklmNld4THNSMFp2M3BQRXdicWpmSnplOTh1?=
 =?utf-8?B?YkRLcjVjeE53Ty9KR0JnWTdIOHVkdnE3bUdBUlE2WW9vTWlabjhlVENyaS9I?=
 =?utf-8?B?RjAwK284WVFDY2xwY3dYTzFzQklybEV3bGpDUFBHYjdsaVlIV1hTbW1FUEFy?=
 =?utf-8?B?emp2NkxyZ3BhZm9FYzVlQ0kxU2xiUWZheTRZV0VPcGVwdElHbUNDdUd2K0ZR?=
 =?utf-8?B?c3YrR29oQUxkb1NsNEVYNlZQSFdldXBjZXpScS9uTFZBVTJCRkppR3BXVFdZ?=
 =?utf-8?B?MjVDL2s2Vk9tY1hXZUV5ZjVMUzZlaThCdkNWQUU2c2tVVk92dUZVNm5jT0I5?=
 =?utf-8?B?VGRscW00MkZUcXhFL3NnazNjc3dPSnRob1F5c2hiTENUNFozN0dmMWp5dVpj?=
 =?utf-8?B?UzVmSEVtdVBXR3g2Qi90RXpUeXN5SFRjeU96UzlBWEFnN1BDb1Q3YWpWdFU4?=
 =?utf-8?B?L2RWN0pGUnUzWG4zbVg1cFZ2d3BjamZsS09MbTVoWHY3bjFUNWdvSFZ1Rzg1?=
 =?utf-8?B?T1dFZGhoL1lRLzl4RkNaUTBSZThTdmZWNklzdGNDRXQ1RVdZSHJpOTNueGho?=
 =?utf-8?B?RGRlNEtOMHBpbDEvNnh1ZEdERTBQaEtvVGZld2diRUI2WitRVWZsOEVWYUNQ?=
 =?utf-8?B?UmlxajR4R3dOdWxKSCt1N0JodldxMTZyc1VvY2xmNzBqUDU3OWdmbnMwZW5a?=
 =?utf-8?B?aXRJbXR0amFlcDRQY0FGRitPWHBYMVhOVnZKT0YxMTBFLzd3ekVhYmlqZ3Qx?=
 =?utf-8?B?NStKT2RvMWNObTFjZW01RkErQXBoYlNKMGdzdWdPVGRJWFlkVjVTYzZPbGYw?=
 =?utf-8?B?R1BqL2lHeU9tTEIreDhldjVtK2FqSVdmN1Z1bXkyYzR3cmtnVndyZ2llZnRr?=
 =?utf-8?B?TDlUZTJpaEdyeVVydlZ6dWF3ZUZBalFmL1cvV1lHQ2gxbGtrOElUQlZybG54?=
 =?utf-8?B?K3JlR0VBVFF1ZHNPMU9sMVBCL3NTWTlzekdpY2YwbU11Z1h6UGpFM3Urck9T?=
 =?utf-8?B?RmY1WDlEaTU2RldySktxRitCVFBzVGhBQTVNcjM3dWREMFl2Nk92bmJIc0xO?=
 =?utf-8?B?R0FVTGUxSEhiL0l4ZXhabDExSldmMWJKYjJ3dXFtZG9Wa28rSkZ5cjFpOTRv?=
 =?utf-8?B?QU13RENaUHlMMEJqcEdYRGhMKzdLUzdIdXlEV0Z5Qjc0aGNveS92RnNraHpS?=
 =?utf-8?B?dElXNEJrSVBVYi9ZaTdJbzlxcmVSZ1NFRGxhZFFSMUZ2M2h3Slg3OHFPMVBW?=
 =?utf-8?B?ZTY0RkJ4a0w1bkRtYklnRlRHRW92M1Q2OXRGOVFQTFRISVJ0NmtUWXpISHFx?=
 =?utf-8?B?MlcxVE4rcjVxR2xQV1ExcG1HZUw2Z2R3SFdnaEhtYTVGV210T09rSjRLT1NR?=
 =?utf-8?B?Vk1xVVZXVmkzUG5tbTgwRlp1SmUzN2RTUjNLQXFOMlpRZ1ZhTEFaZEdkQlVD?=
 =?utf-8?B?MlVJQW1FaEdZdGFWanVWb2VBa2xvZk42WUQ1S0U1UXFVMWNOTzRBWWg1OUpS?=
 =?utf-8?B?a01qSCtiU2ppbjBtS2kvOFVMZGpRVXNzMXNQYklrQ2R3WVk1OU9EdktMajhV?=
 =?utf-8?B?cHVadUlZK25valFkY01CN1ZId01USTRwODhBUlN0OXozazdBNnRsRVR6OU95?=
 =?utf-8?B?Vm12Zll3emtsck40enRTeHhhUG01NCtPMmhSb1pVZHN0NlU2S2VMa2M1YmdD?=
 =?utf-8?Q?vF9uSQgSqnHJk1M3cwvkf6H84?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dda7be9-da32-4d0f-5f23-08da60a5b953
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 05:50:12.0996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAzpDr4L/a/yQxUaAZpwKjv60JW1/sbMIWpeG1Pged4LDzy9TnolIMv/t+MvD5sUnCnumyRdDv+nLN97Mq+VpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1474
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgSnVseSA3LCAyMDIyIDU6NTkgUE0NCj4gDQo+IE9uIDIwMjItMDctMDcgMDc6MzEsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBh
cm0uY29tPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIEp1bHkgNiwgMjAyMiAxOjA4IEFNDQo+ID4+
DQo+ID4+IFRoZSBudW1iZXIgb2YgYnVzIHR5cGVzIHRoYXQgdGhlIElPTU1VIHN1YnN5c3RlbSBk
ZWFscyB3aXRoIGlzIHNtYWxsDQo+IGFuZA0KPiA+PiBtYW5hZ2VhYmxlLCBzbyBwdWxsIHRoYXQg
bGlzdCBpbnRvIGNvcmUgY29kZSBhcyBhIGZpcnN0IHN0ZXAgdG93YXJkcw0KPiA+PiBjbGVhbmlu
ZyB1cCBhbGwgdGhlIGJvaWxlcnBsYXRlIGJ1cy1hd2FyZW5lc3MgZnJvbSBkcml2ZXJzLiBDYWxs
aW5nDQo+ID4+IGlvbW11X3Byb2JlX2RldmljZSgpIGJlZm9yZSBidXMtPmlvbW11X29wcyBpcyBz
ZXQgd2lsbCBzaW1wbHkgcmV0dXJuDQo+ID4+IC1FTk9ERVYgYW5kIG5vdCBicmVhayB0aGUgbm90
aWZpZXIgY2FsbCBjaGFpbiwgc28gdGhlcmUgc2hvdWxkIGJlIG5vDQo+ID4+IGhhcm0gaW4gcHJv
YWN0aXZlbHkgcmVnaXN0ZXJpbmcgYWxsIG91ciBidXMgbm90aWZpZXJzIGF0IGluaXQgdGltZS4N
Cj4gPj4NCj4gPg0KPiA+IFN1cHBvc2Ugd2UgbWlzcyBhIGNoZWNrIG9uIGlvbW11IG9wcyBpbiBp
b21tdV9yZWxlYXNlX2RldmljZSgpOg0KPiA+DQo+ID4gCWlmICghZGV2LT5pb21tdSkgPDw8PDw8
PA0KPiA+IAkJcmV0dXJuOw0KPiA+DQo+ID4gCWlvbW11X2RldmljZV91bmxpbmsoZGV2LT5pb21t
dS0+aW9tbXVfZGV2LCBkZXYpOw0KPiA+DQo+ID4gCW9wcyA9IGRldl9pb21tdV9vcHMoZGV2KTsN
Cj4gPiAJb3BzLT5yZWxlYXNlX2RldmljZShkZXYpOw0KPiA+DQo+ID4gZm9sbG93aW5nIHRoZSBy
YXRpb25hbGUgaW4gcGF0Y2gwMSBhIGRldmljZSBjb3VsZCBiZSByZW1vdmVkIHdoZW4NCj4gPiBp
dCdzIGFzc29jaWF0ZWQgd2l0aCBhIGtub3duIGJ1dCBub3QgcmVnaXN0ZXJlZCBpbnN0YW5jZS4N
Cj4gDQo+IE5vLCBiZWNhdXNlIGF0IHRoYXQgcG9pbnQgdGhlIGluc3RhbmNlIGlzIG9ubHkga25v
d24gaW50ZXJuYWxseSB0byB0aGUNCj4gZHJpdmVyLiBBcyBsb25nIGFzIGl0IGlzbid0IGVycm9u
ZW91c2x5IHJldHVybmVkIGZyb20NCj4gLT5wcm9iZV9kZXZpY2UoZGV2KSwgZGV2LT5pb21tdSB3
aWxsIHJlbWFpbiBOVUxMIGFuZCB0aGUgcmVzdCBvZiB0aGUNCj4gY29yZSBjb2RlIHdvcmtzIGFz
IGV4cGVjdGVkLg0KPiANCg0KWW91IGFyZSBjb3JyZWN0LiBJIG92ZXJsb29rZWQgZGV2LT5pb21t
dSBhcyBkZXZpY2VfdG9faW9tbXUoKSBpbg0KcGF0Y2gwMS4gQXMgbG9uZyBhcyB0aGUgZGV2aWNl
IGhhc24ndCBiZWVuIHByb2JlZCBvciAtPnByb2JlX2RldmljZQ0KZG9lc24ndCBkbyBiYWQgdGhp
bmcgdGhlbiBkZXYtPmlvbW11IHNob3VsZCBiZSBOVUxMIGluIHRoaXMgY2FzZS4NCg==
