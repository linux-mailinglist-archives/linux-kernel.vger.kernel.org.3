Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4858257FA70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiGYHrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiGYHqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:46:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C03610547
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658735210; x=1690271210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j0PRbgzx1w574uJAAqkcai0JK1TAldiijG6taBv4yqI=;
  b=Dps8SFLKnGnaDeaqtD8CTxibsyPTVGVLKDbze7QybdfSSwPCI6elkr62
   YxRgXoHmwtotuei/FHbi9n4rw56w3CpxNH3UP/3BPNyHqAmzB7aOjaKNO
   UwfS6m0y9SsRhg/2LQAl00JdTGZDo0pMKagit0sm2y+IlzX3KJa7AFYJJ
   qdWLbZJM14z6XJ40uuFlX6cy5RzObkBvWNWqDjfKpMOuJ30VzX+NirQZF
   vCqon9EzEHjMAlTYMzOf5+mvl4lUQvqwtwvfiVlpqVkfJgO9Kh4jVT3sb
   cl0M2lFVBIp64kRMl8D4DTV1Ea/LIZt/r0embDJR9U+8sZwllbZfQgsaA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="373941127"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="373941127"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 00:46:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="658072445"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jul 2022 00:46:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 00:46:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 00:46:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 25 Jul 2022 00:46:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 25 Jul 2022 00:46:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBMtb0GA2cWEqHMCHKm9GeDsCU1RX+GpDgeBPN28B4lbSI0UjwX65xzslgDYwqy6Dqxg+GdKige5zV2dJWFKmJ/bXtRV2+B+YuMwQfCfgPf4/iCWSts0q5ePcJLE8OU2mLigPAJhCUpQ0o43P84zL6YPttZtpNovGXDysBrzPXsRcYxg0CEVovyKfN2YduMLwVFF1YX7E2itIqrjGfCObCHPMVifmq5Gfe19APkOdErRB+/YOnoKB0dVzRyC4+00RUAksgXS77y//pYtJA1yxI6cgkxYEkZIVJHg+rMB9+Jf7dyiVJBU6Vg7MeYojS69N/Y/FwRufYFEupprlHppMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0PRbgzx1w574uJAAqkcai0JK1TAldiijG6taBv4yqI=;
 b=kpi9cMMjXQlEu0RbFmElszF084rZ7BUb2QdTflMR8AUxmLUqN4RN/WJcWT5amX/tYVYmKmuoYLnSrfnpSffTbtWj+UybRneWZKHDcu7tG+xGVX3irDUOUZqrLDcjCsUJLkgW2M6iR1sOmzWpiPZkW3F0UghJZ8VSfws5VYMkObGGSFDF49G2gWacIVOojKlSKtnSBGscxz0MqHnKSA2KnSUZ4zBXeyKYUQHOIt6lxrSDpvIIc3nOpzNXZVOE6Sba+figZsOscXBctaHR04nv2KQM2SfZQNU4W/JfdX4+rRWQiwR8yf6XN5xq8dZ9wwX817KKPMlLFNc9YIKa8ggyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1459.namprd11.prod.outlook.com (2603:10b6:405:a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 07:46:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 07:46:44 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Zhangfei Gao" <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: RE: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Thread-Topic: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Thread-Index: AQHYkC3GvF//WyZOvUaTLdl04LC2Cq2MG8sAgAE/J4CAAXmUoA==
Date:   Mon, 25 Jul 2022 07:46:43 +0000
Message-ID: <BN9PR11MB527627410352E6DE921755898C959@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <5d353fe4-b642-992e-ef42-7d7f8b2edf7e@linux.intel.com>
In-Reply-To: <5d353fe4-b642-992e-ef42-7d7f8b2edf7e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 783b5848-1ce5-476c-ccfb-08da6e11d1c7
x-ms-traffictypediagnostic: BN6PR11MB1459:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pi9FOHKmeVbWSdcVbrRM5iOnEcj1pJIVsnLUWAkpzOtKEQbGvLw1gpXvLqJy83+mNB9P0PxMuG1zx2y/qGOzqhkSdi+bxEPd5+7XYy8aut264loYchO5AwSq105VrsZYuKxIBNWe/sd6rhV5q6SLudE86gZl9bvxmoNIfgQD6RoaOZd6FaGlVagkyZ9gwE16vyMLlzWvSmE0AiYJYm8D02HBw99X7Jr0yf/4Y5iAICCF/P1DJWJUmFoKCY+yKmfWrdcDNVwsxOCKL6Fg1Gq3zUpS/OXEJP31FGMYqgtYC55sYB7mfpKjmm/ZVAeMUYbPy4BhYryBBn3skftBGWxsJQTOZ4fRvZ90FK+P5sXm4qyxJWl0eAnrr89VylKwy7evUH/FIA8G4+xx8LdhXU5QzO9rpxFiqX/wXiTFaC4w2hpLlFf4STJedX4K3yf6CtcxvxMOp7ySEMN9Su63nQZHPRBkxwJCFJS4mivIDnA0MVcUvTWqwz4STYBt7eOScPRKIIJnWMAybTXGTlCZ4+skk40Jq2IvM7pvCFrBSXamtPhUzjwbaDiDURRwCAxIUxQYV6FkT6atMnEpVhc/cg2S2VORGIKe0jmAki5/YwwMQNUDS0r1EtS/KYDDqlC2Y87neWrpiRoKi2ukXwrjDFOrJV7y0QfYx+axWfaqMOoM9KLbR1b8phvAnXE0kL2yyhU9B0LsrWKnKJSs+LbkulJaFgSjMm1DvWWQVeOVK4xJcGBO/m1Y/uDS8f+qa5g+eoyxCEU6ZpAG8lvAPWRqrFN6DZO+qI7qbN0BdgwdI9oBIM1Zw0Upu9llwWKgKZeawmjI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(366004)(136003)(376002)(186003)(83380400001)(55016003)(71200400001)(4326008)(66946007)(76116006)(66476007)(66556008)(110136005)(8676002)(66446008)(54906003)(9686003)(7696005)(6506007)(64756008)(41300700001)(53546011)(26005)(2906002)(33656002)(38070700005)(86362001)(38100700002)(122000001)(8936002)(5660300002)(316002)(82960400001)(7416002)(52536014)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzJrb3RaWGpPLzA4ZVAzZmFxa1B5b21EcDBzaW12Rm44NkM3d0N2bElFcHc2?=
 =?utf-8?B?SG8rbndaZXd6WTFrQmd1RGJHMXhFN1pwWXBFTGpRN0tWQWZEVm5tQk9MSTRQ?=
 =?utf-8?B?dVdCSzMxb3NKcm52ZUFTbzIvOTNWbTQrKzF4alhiMXMyaDc1OEVlK1hLVEdJ?=
 =?utf-8?B?ckx5NmJ0SnowYzd0enV6M3J2ek5MRmlKemljdHdNajNON0VEbEFaYW55OVNM?=
 =?utf-8?B?MzVaWFU0cUpiMkZEYm1RZGJRMGx1bWJpbjFoTUt4TWlCK3dITHl6YlVSb0k5?=
 =?utf-8?B?ME9KNXl1KzNwRnNCRmN5MitJUTNvMTF3WEhNR0ZCc01kUGRQNVJ4NG5Ec2xH?=
 =?utf-8?B?Snd4SmJJbzJodUlsS0xQMmxGSVNpQjVTNU51bGVXOUR6NWhjVGdOQVgrNkRl?=
 =?utf-8?B?eTl0eDFoSEt6NE40a0Jmb0xHOHllQzFzYmNZNWVoaHV4QkYrRHIyUzdsZzE2?=
 =?utf-8?B?STRPcTYyNWNaVGRjZXlweXJiaWRzdTd0L1psN2JRRDNrSWszRUFLSlRwdDdY?=
 =?utf-8?B?bmZtdTZzV0ZLMmNQdUZ2NThxdVY3aXY3OWNTNmEvdXd6YXZhc2JJbDc4eEtV?=
 =?utf-8?B?TnlBc09qK0N5V1NDMlR4SEE5UWMrZEJaU3VIa1RyOGRTekg1SkZ4SXNtWWVj?=
 =?utf-8?B?MmZ1T3pYYUlNRjlzaVlRa2NadjFsbTdqR3lwY2h6RTNuYko2SlZMTSsvUnpL?=
 =?utf-8?B?MDgwSUtBV2U0QytCTnlYdXMvbTZyS2kvWFlnY3I2cjlDSkt3Uyt2ckhPelFk?=
 =?utf-8?B?dE5Wam12VENPL2poU3F0RFNYSERTUnpENW83dUQvSUtQQklOYkpsbFBXSmNI?=
 =?utf-8?B?V2t1L3h3MEFSN0d2RFJiUC8ya25vdWlvcEQ3RSttQTJaV3VndSt0NFpTYzlX?=
 =?utf-8?B?RDZGK2gyYUhCNHhaY3RHUWMvMUNYZXBVeE9tcWlJc3I1TE5vZXZ0WjN6RTE3?=
 =?utf-8?B?TnhYYXk0aXk0aGFYb254MmVETkY4ZXBnNDJmZEQ4OUJEMUd4SlhjMnk3bkNu?=
 =?utf-8?B?by82VmorUmZ0bUdqb29PM01vNVc0R2l1TktJN244VXFDbXA2WDg2cTBQeHBJ?=
 =?utf-8?B?ZVNudFpKOWtTZGdFVC9RUThuSWdvT3hRU05ROXRLWHJ3OHEyZER6SUcwRkpB?=
 =?utf-8?B?eDF1dlhRZ0N2VWVJYjg4QTB4RUxYQWhyTWFqRnlQbFhvSXV2OEZwQW1tbnBX?=
 =?utf-8?B?Vm5QbHc4SGorVnZoem9Ma1k4V1V5eXdTQWRNU255YS9mWUtVQ2ZCYWxZZkJF?=
 =?utf-8?B?ejU3WERyQ2tNSEJadzB4amlsTWFON0Nrd0h1WGwzK2k2ZHdTYUFYdTJpbk4w?=
 =?utf-8?B?UzFZcFA2aE5FREhRM0VEeGtZUkRINkJjVGdQd1UwaEJ0WUpSOFVzQ09IOXVZ?=
 =?utf-8?B?a0JTbzBTRDV2VjRjQVZneVNHODJ6dGc0RnlLcGU3NHJEZ0xwOTA4V2syWkJi?=
 =?utf-8?B?NU9rY0xSS0xObWNBUHBoL0gzK0J0REY4NDJMd0UvTk1xQVhKVXl1RUJwdExj?=
 =?utf-8?B?aUNkaHJ3ZHhoakc2SXZuQ3pFMFh5MEFZWndTTjFSV1JrYjUxSWpCa1U5aHB0?=
 =?utf-8?B?TDY5YmIyZVlEa1RsZXFHdEhzMlBoK3YwV3prNnVMK2E1VkR2MkxlQ1VMVWw1?=
 =?utf-8?B?WExsR05pQXcrVmUycE9mS2o2N1IxN2dQcU9HVC9OenpDSEduWkVTYzkxSUVh?=
 =?utf-8?B?ZW42MXBYK1NTUU0rZjFBbEFHcXNvZitpZVN5M2dvNW1BSi83Qy8rcjBDUElK?=
 =?utf-8?B?ZEtiblFBeTlGRFJDeDdrQ0hhQlVYNURKbFpqeXk1S1hFL3pWZlpNZ243bzYy?=
 =?utf-8?B?OVBBQlh6bEpOY0xTQVc3dmQvT2cwN1RLRkV5QjlyeDgyMzFJNkRsOGNnN25W?=
 =?utf-8?B?VkdzZk5UN1pwT2F3OGZGK3g0OUhuL05FZjlNdkIvQ1VBbHgzZmRFQm56WUNz?=
 =?utf-8?B?WUp6R3h1cEg3a0pzQlBKUjY1dkJoTjc5YjRVV2UxTGphSFBpR1NkUW9hTG5a?=
 =?utf-8?B?WWlheGQ1YUlpVmJ2N2wrMmNHamxncXZNbzZUR29JR1EvWmtYcUlGSjdpcGI3?=
 =?utf-8?B?T09ELzdDMFZJVzgwbS95UjZ4QWhlSlpoL1V6eUlPMThVVldJOXh5V2VRZ1d4?=
 =?utf-8?Q?b1U4neSImlK5BQ99Z3jtSPgM2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783b5848-1ce5-476c-ccfb-08da6e11d1c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 07:46:43.9066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3KkCPchgd/2JOSOvD4l6kIXcry+qFuBOW++pQAOBSTgIak/evyPuSwM//nakUHXJZXO/mn7qUjgMlFa0xuEjfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1459
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIEp1bHkgMjQsIDIwMjIgNToxNCBQTQ0KPiANCj4gT24gMjAyMi83LzIzIDIyOjExLCBKYXNv
biBHdW50aG9ycGUgd3JvdGU6DQo+ID4+ICt2b2lkIGlvbW11X2RldGFjaF9kZXZpY2VfcGFzaWQo
c3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLA0KPiBzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4+
ICsJCQkgICAgICAgaW9hc2lkX3QgcGFzaWQpDQo+ID4+ICt7DQo+ID4+ICsJc3RydWN0IGlvbW11
X2dyb3VwICpncm91cCA9IGlvbW11X2dyb3VwX2dldChkZXYpOw0KPiA+PiArDQo+ID4+ICsJbXV0
ZXhfbG9jaygmZ3JvdXAtPm11dGV4KTsNCj4gPj4gKwlkb21haW4tPm9wcy0+YmxvY2tfZGV2X3Bh
c2lkKGRvbWFpbiwgZGV2LCBwYXNpZCk7DQo+ID4gSSBzdGlsbCByZWFsbHkgdGhpcyBPUCwgaXQg
aXMgbm9uc2Vuc2UgdG8gaW52b2tlICdibG9ja19kZXZfcGFzaWQnIG9uDQo+ID4gYSBkb21haW4s
IGl0IHNob3VsZCBiZSBvbiB0aGUgaW9tbXUgb3BzIGFuZCBpdCBzaG91bGQgbm90IHRha2UgaW4g
YQ0KPiA+IGRvbWFpbiBwYXJhbWV0ZXIuIFRoaXMgaXMgd2h5IEkgcHJlZmVyIHdlIHdyaXRlIGl0
IGFzDQo+ID4NCj4gPiBkb21haW4tPm9wcy0+c2V0X2Rldl9wYXNpZChncm91cC0+YmxvY2tpbmdf
ZG9tYWluLCBkZXYsIHBhc2lkKTsNCj4gPg0KPiANCj4gSSBvcmlnaW5hbGx5IHBsYW4gdG8gcmVm
YWN0b3IgdGhpcyBhZnRlciBib3RoIEludGVsIGFuZCBBUk0gU01NVXYzDQo+IGRyaXZlcnMgaGF2
ZSByZWFsIGJsb2NraW5nIGRvbWFpbiBzdXBwb3J0cy4gQWZ0ZXIgcmV2aXNpdGluZyB0aGlzLCBp
dA0KPiBzZWVtcyB0aGF0IHRoZSBvbmx5IGRpZmZpY3VsdHkgaXMgaG93IHRvIGNoZWNrIHdoZXRo
ZXIgYSBkb21haW4gaXMgYQ0KPiBibG9ja2luZyBkb21haW4uIEkgYW0gZ29pbmcgdG8gdXNlIGJl
bG93IGNoZWNraW5nIGNvZGU6DQo+IA0KPiArCS8qDQo+ICsJICogRGV0YWNoIHRoZSBkb21haW4g
aWYgYSBibG9ja2luZyBkb21haW4gaXMgc2V0LiBDaGVjayB0aGUNCj4gKwkgKiByaWdodCBkb21h
aW4gdHlwZSBvbmNlIHRoZSBJT01NVSBkcml2ZXIgc3VwcG9ydHMgYSByZWFsDQo+ICsJICogYmxv
Y2tpbmcgZG9tYWluLg0KPiArCSAqLw0KPiArCWlmICghZG9tYWluIHx8IGRvbWFpbi0+dHlwZSA9
PSBJT01NVV9ET01BSU5fVU5NQU5BR0VEKSB7DQo+IA0KPiBEb2VzIHRoaXMgd29yayBmb3IgeW91
Pw0KPiANCg0KT3IgeW91IGNhbiBjYWxsIF9faW9tbXVfZ3JvdXBfYWxsb2NfYmxvY2tpbmdfZG9t
YWluKCkgaW4gdGhlIHN2YQ0KcGF0aCBhbmQgdGhlbiBqdXN0IGNoZWNrIHdoZXRoZXIgdGhlIGRv
bWFpbiBpcyBlcXVhbCB0bw0KZ3JvdXAtPmJsb2NraW5nX2RvbWFpbiBoZXJlLg0K
