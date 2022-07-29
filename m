Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB09584A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 06:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiG2EWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 00:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiG2EWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 00:22:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0BE77579
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 21:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659068525; x=1690604525;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=++zxNDRnIg4osriquG1Fve4qqhmM0FFgvSN+wso+9os=;
  b=R5bTvmGceF9KJVRdsSFIPrnF/kfkvepbzfrtPZjpt2S28Rm1Dbc8ot+0
   590tP7K0exYNTeC+/LQoZTOROWI3ZlJu72IoIRhew01w1cbr7YRdBOmM5
   5hi3Waz6ivA3NgrJ+qH2tCTjZYkSjHQkFmF9fWk+QEjqySaQptvh5rKEA
   M8ve2o00eHEKDe3uWCl1hYQsXJZZnayr/cKCwdFzgUxj+gLFEjhKf4Qy0
   YyRK8kRnGjNiXvIkDRfoFFh07dhp73r8hqz+zmKoT8sYSniYxJrBrjB7v
   WGp19EILNBehUc3MM02R4V3jz9fYhJMeECMA8NpYtCIqe/k2yxsicoscf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="289884274"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="289884274"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 21:22:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="551605908"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2022 21:22:04 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 21:22:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 21:22:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 28 Jul 2022 21:22:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 28 Jul 2022 21:22:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wy0GcPwRMGcjUgrKq3La2mrY1dOuQ7pRNf6C7WanPZCEXfKGXZxTdSoKs4LbrIZMrGn1DyLc39kqWdqt0bRPtrtOIfd3Qbi7LU+W38KUwFjFn/+C1etddjuwHw2DmXSY+H8CM8rzdx7dbz7eLaO2TrCCZJLr7zW2CwhOhGAoFL3XuPeX2tcHTbusY/cb4uLVGY65HYrkEgdpXP0xp9zn0mC8kzLgGIeWowYKoCm7zMkt15MZ6KELxMgqUT+YYkxS6JpSnNfGEI6F6WBp+GatwdcpLOUqwf9h422yiGSWGsTMGYife0PLeG9RxWg9CQt9ymaL31FyiUHvV39Fj8P/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++zxNDRnIg4osriquG1Fve4qqhmM0FFgvSN+wso+9os=;
 b=Pl/r2Xxb9RdtJrtQw626AcAZ+qPQ47eCglMw7Nkg4mGjyWL/kFHmKL8iOJg+2YWn6lQUU4iyM6DKf1IC/rIhf91knFfjQMMhMHd8r2V21COnFdZdCjz5xTLLQczZAsyjwHdW36T7+vrmd/egsqzAbpi7ZeQNlhePVuZ8jw6a/hPGfftuUXiafwlBdkWY2PUcxq0rBOOw8mRKbSWptu5CWmr9rSca/e/f1O48Golie4qb427xQBzmg5+L1GIs8GQFt2xDzIq3q6GNkcK7HzB/g2bEkYQmKKDtyXuCqrCdG2bVUIfaevgtFIOAfJ+hEzG7mHtJe211OjFrlkHY6atDOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB4066.namprd11.prod.outlook.com (2603:10b6:405:82::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 04:22:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 04:22:02 +0000
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
Thread-Index: AQHYkC3GvF//WyZOvUaTLdl04LC2Cq2MG8sAgAEavgCAAhH3gIABB5EAgAB+1ACAANqooIAAlRyAgAD5zPCAAJo9gIAA+HkAgAAA+GCAAAfngIAADc6A
Date:   Fri, 29 Jul 2022 04:22:01 +0000
Message-ID: <BN9PR11MB5276ED7CE0C8CE192B4EACB68C999@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
 <BN9PR11MB5276974ABA5981A7361953708C979@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220727115339.GM4438@nvidia.com>
 <BN9PR11MB52766C3D37FA985DEBDC30C78C969@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YuJ6MXoNTj0RKCb8@nvidia.com>
 <78376ca4-9b55-7609-abf1-27a1a376a8e0@linux.intel.com>
 <BN9PR11MB52761058CFCB9397F6A73A958C999@BN9PR11MB5276.namprd11.prod.outlook.com>
 <64667345-7f7f-74ec-215a-f2d36be0f9ce@linux.intel.com>
In-Reply-To: <64667345-7f7f-74ec-215a-f2d36be0f9ce@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bb6160e-d95c-4d5a-ff04-08da7119e2c4
x-ms-traffictypediagnostic: BN6PR11MB4066:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2CGKVUZDE8DMchSuMfiTSTX5lGw/3G8LUE+t/L8i454UY75iAoh66yoQwX8sxwmyA5ddPoMO9VV99hABSwrGDQThuVMl1MgmlMm9BodXNsUYZfiICls9fpIVzbz5QeNmRhxEefaoAvJ+B55VniJ1TqBDeusXcOyQTm3ThRb7GzcyB6BzkcU3ann3BDGU0/AqNxH7d3S+tRvKHF13lkg+AcnlZlQDh5lArvRRpeUA5cAByIyRFgLB3WdQc91aEHR3v9R3XM1hEC8rOSWOIHXysnBwMJiTk5uQ7TVx5MmGjCA+BamAtkXKPMSnS6i8/1NHu9m34fxaeqOQFcTtnvHwlHnWAcmwpdBnERJyRAi0LOvzq7pEHeNwe7PYaCG9t2r/9EPJh6TAZ7Ju0dAvZbCO3Z4SDyru5e+V2k9+6fhp2D4/bg91AisY/bOScC0iReibuLLtEivGpEqkxL2DY6GP9Q4/0//guUlPGhSr0WtWRyz/5rHggs4d6gQfKbycOFkmbrtLvy93HaLWLWwt8DkWeIiScdmFUK4puNoq7JqmwDu1lhOwS9CAliTMulRNAftue9PdMDasHDTUDuyXOkKkfslmEEMpAyao5MUa+hph3RO71+w3nWEX6devPXLkBfGiEs8C0uB80DPGsp261A1cYpTLZCNdJ8wHKShxhDj834p407j7gNI+L1fi3itYAvvSJjET1XEWE4J3QFSPyWXa06sFzPN09tDaxSo1tczfIcUQC+yh0HTRSRGMT1Cv4h2ON2LeIwUSsPHvQGHKHZDYNhSlUfV16W1JCY8/WwWooQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39860400002)(366004)(346002)(376002)(66476007)(64756008)(66446008)(71200400001)(55016003)(41300700001)(2906002)(316002)(54906003)(33656002)(86362001)(478600001)(66946007)(110136005)(76116006)(66556008)(6506007)(7696005)(53546011)(186003)(38070700005)(26005)(82960400001)(9686003)(8936002)(52536014)(4326008)(8676002)(5660300002)(7416002)(38100700002)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk40cVBLbXNzSUdaTUJKR0hIVEpVVUZMbGFzRFVmbWFMalZjUFB2Zm05RXB3?=
 =?utf-8?B?YngwMjdnZGRRZ2tYT1I4L29INjNIUG9abG5maVZkeTFSbkVaWkwxbk11RVNR?=
 =?utf-8?B?ZmdwZ3FuNk1UckZrTTJ3d3dzRUMzUVA2dHVQRmh3MXN3ejFFWWwzUmxLcWl4?=
 =?utf-8?B?RDZENG1YaUZzOGd3U2VXYnJ0OFNRQm5FVEJvM2lxakFhV2lpakQ1anRmcGJm?=
 =?utf-8?B?aFRuVW1iTjE0VmxSVmR4MldveVdvTkhYZFlHRWs5TWJDSmtmY2JDNkJ5S2RV?=
 =?utf-8?B?Z21wdmY4MHZQWEd3UXcvWEt4VWFYOTRzUVpzajcrbnFiNXBYRFBWSlZsL0g4?=
 =?utf-8?B?cVFwVnY3RVMzRnJqN2tPdmp6cEZJTnJqZjRNZWJmaTBHOFdMQm4rNm15Y3Fr?=
 =?utf-8?B?WnQzYVpJNllBZ09wVE14NHMySW1rY2hURFNaUXI1WWJZZndKOE9jWnh1Nlp0?=
 =?utf-8?B?WVZWQmw5RnUrMkVmRS81Zzg1WnV0OVppWS9KUWlSRUx3WUhsaHFBZG54bUdP?=
 =?utf-8?B?cHNDMzRtaTNyZEdLWmVscmM0ejkrVHdPblBZdzVpeFFicVlUakNpSnRvamtQ?=
 =?utf-8?B?MDJFQTE1bHhNclpnYVJUblRWR0JneHBYYTB6Kzk1THMzbm5GempVSlRacmxL?=
 =?utf-8?B?Q0NidFpBQnJSc3hETTc5SjVEaXNzVVJNeGVKLytib0RJOE1qUEdHVnRiMnJ1?=
 =?utf-8?B?c1BOTUlzUWFxNXRzYTl5VDNZUWxGNVYxbGI2dENNVTN1aDQvd2diSWlhUEhx?=
 =?utf-8?B?aFJIc09GMENDTUFlQXFjelNKWXQ0cjV4cmYrK29lMWY2K01pRVNWTXJmcEZY?=
 =?utf-8?B?aGdVY214UGdqUnlqTFhnMWdyaHNQeXBiSUs1Z0F6V0VpUUpzZUlWemFveXNM?=
 =?utf-8?B?dnJwZGZsbGRuWXFrN0JLNFNaeXZzZ0Z6RndPdjBTdUxZcXJqWFhiQTVteDhV?=
 =?utf-8?B?dkJGUkdGUFNxdTNidVVML2w2ejA3aGVzZlU2UVFhTTdRdHVRVWlSRys3UTYv?=
 =?utf-8?B?Uk9sUlhNY3BBR3dWcHEyVTZsbGIxVkxyTG1kOTl4ejVrWHUrR1Y2WG12UTFt?=
 =?utf-8?B?eWh5dDA0d1pCZHJBVC9YSGtUVHNZS2pFLzhpb2JHdWtoUk04aGtQOEtKUWNW?=
 =?utf-8?B?azZEaDF3bGhCTExHd1VSWC93REg3ZWRTUU5pemtDOHJvekdndVlYaUJnZXB6?=
 =?utf-8?B?OG04TkgxQ0xwSjIreW1EVnY0YzhVc1JQdldwYkgxTk9QdEVhNnoxbWNzTXRo?=
 =?utf-8?B?NDhWOGVaaUtFMlJ5N05iL2NLYVBHVEM1VzExcUxkT25uc2poNUo0Uzdiekl2?=
 =?utf-8?B?Sm1jV3F0eTRuQ1VhMnpEUnNRT0k3eWdZdW9BVW1HaFMxSlpEVENLQ25iZ0FU?=
 =?utf-8?B?QXE5VnNyc3dkTDFYQ05jMVZVa0x6SFBqNDVaeTJNeU9tWUZuVnJJUkpHSTBx?=
 =?utf-8?B?U1dJYlkzUkt1b2lYWEFtb1EwSElGOHE1bWQ1ZW0xZGNhS0pZcW1zZ2o1d3gr?=
 =?utf-8?B?SXN4ODM0alNrbVlVQ3Y3a1Eyc05kcmdod3lXclg4U1crOGpGa3cyL093Y3BJ?=
 =?utf-8?B?b1lSYnU3ZE0wVXoxU1V6TjdmTzRON3Q3Yzk5dlJaTUhNK0dOMVZoTXlDdGlz?=
 =?utf-8?B?bGxWcjBFajdJRjhOaWgrLzU0L2FrelZnTjV5dnVhQTkwTDJlSE04SzRpUVQ0?=
 =?utf-8?B?UVNZdFd3ZXJ1ZGczUjFKUlB5N0MwZXFnKzdCWlZ5L1ZETjJwakRjbXVXZm9a?=
 =?utf-8?B?Qm1Pcy9Ld0FUTStkaEFvUWRXME93MEFCcGgyQ0lDQjVFaTBzdG9OeTdOdHZM?=
 =?utf-8?B?UXozZ2UrSnV3MWMyczN0LzIvdTN4UC8wSU1yU3NPL3JkblhMNGcrcG1qZTRu?=
 =?utf-8?B?YjNFMDJKRzc1VU5lS0w1SG0zTURheUd4b3FTdmN0SEdQR2taNGpadHBNbEZk?=
 =?utf-8?B?S08xUDhObzBwLzk0RDdVbGdPRDRJZHZaZEZicS9TYTNCZDNVeDdETGZobjRD?=
 =?utf-8?B?azlyOXljaGJpeUFQUVgvK0ltNkY1NnhtS2tOYTc3S2MwZExDbk9selQwai9H?=
 =?utf-8?B?RnFnbWl3c2RlcCtjMjFmUWUzVUxaRDRWdWE0YnVpeXBGbUIrRmZ3VmVMekxv?=
 =?utf-8?Q?lYIcVJezr6tB37rvFiTHlHnVp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb6160e-d95c-4d5a-ff04-08da7119e2c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 04:22:01.8715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vYQNoYAjLhZkp4yhTMEnONQbtaoVep/hm++89T0LcgKUyJ8qfj87599+Kr3UkR2YJg3Q/h9Iw66Cv5v1oJ/BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4066
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bHkgMjksIDIwMjIgMTE6MjEgQU0NCj4gDQo+IE9uIDIwMjIvNy8yOSAxMDo1NiwgVGlh
biwgS2V2aW4gd3JvdGU6DQo+ID4+ICtzdGF0aWMgYm9vbCBpb21tdV9ncm91cF9kZXZpY2VfcGFz
aWRfdmlhYmxlKHN0cnVjdCBpb21tdV9ncm91cA0KPiAqZ3JvdXAsDQo+ID4+ICsJCQkJCSAgICBz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4+ICt7DQo+ID4+ICsJaW50IGNvdW50Ow0KPiA+PiArDQo+
ID4+ICsJY291bnQgPSBpb21tdV9ncm91cF9kZXZpY2VfY291bnQoZ3JvdXApOw0KPiA+PiArCWlm
IChjb3VudCAhPSAxKQ0KPiA+PiArCQlyZXR1cm4gZmFsc2U7DQo+ID4+ICsNCj4gPj4gKwkvKg0K
PiA+PiArCSAqIEJsb2NrIFBBU0lEIGF0dGFjaG1lbnQgaW4gY2FzZXMgd2hlcmUgdGhlIFBDSSBm
YWJyaWMgaXMNCj4gPj4gKwkgKiByb3V0aW5nIGJhc2VkIG9uIGFkZHJlc3MuIFBDSS9BQ1MgZGlz
YWJsZXMgdGhhdC4NCj4gPj4gKwkgKi8NCj4gPj4gKwlpZiAoZGV2X2lzX3BjaShkZXYpKQ0KPiA+
PiArCQlyZXR1cm4gcGNpX2Fjc19wYXRoX2VuYWJsZWQodG9fcGNpX2RldihkZXYpLCBOVUxMLA0K
PiA+PiArCQkJCQkgICAgUkVRX0FDU19GTEFHUyk7DQo+ID4gSSB0aGluayB3ZSBhcmUgbGVhbmlu
ZyB0b3dhcmQgZG9pbmcgYWJvdmUgY2hlY2sgaW4gcGNpX2VuYWJsZV9wYXNpZCgpLg0KPiA+IFRo
ZW4gbm8gc2luZ2xldG9uIGNoZWNrIGluc2lkZSBpb21tdSBjb3JlLg0KPiANCj4gVGhlIGlvbW11
IGdyb3VwaW5nIGFsc28gY29uc2lkZXJzIG90aGVyIHRoaW5ncywgbGlrZSBQQ0kgYWxpYXMuIFRo
ZXJlDQo+IGFyZSBtYW55IGNhbGxzIG9mIHBjaV9hZGRfZG1hX2FsaWFzKCkgaW4gZHJpdmVycy9w
Y2kvcXVpcmtzLmMuDQo+IFRoZXJlZm9yZSwgSSBiZWxpZXZlIHRoYXQgcGNpX2Fjc19wYXRoX2Vu
YWJsZWQoKSByZXR1cm5pbmcgdHJ1ZSBkb2Vzbid0DQo+IGd1YXJhbnRlZXMgYSBzaW5nbGV0b24g
Z3JvdXAuDQoNCklzIHRoZXJlIGFuIGFjdHVhbCBwcm9ibGVtIG9mIHNoYXJpbmcgUEFTSUQgdGFi
bGUgYmV0d2VlbiBhbGlhc2luZyBSSURzPw0KQXMgbG9uZyBhcyBBQ1MgaXMgZW5hYmxlZCB0aGUg
ZGV2aWNlIGlzIGlzb2xhdGVkIGZyb20gb3RoZXIgZGV2aWNlcw0KaW4gdGhlIGZhYnJpYy4gRE1B
IGFsaWFzZXMgZG9uJ3QgY2hhbmdlIHRoYXQgZmFjdCBhbmQgdGhlcmUgaXMgbm8gcDJwDQpiZXR3
ZWVuIGFsaWFzaW5nIFJJRHMuDQoNCj4gDQo+ID4NCj4gPiBQcmVzdW1hYmx5IHNpbWlsYXIgY2hl
Y2sgY2FuIGJlIGRvbmUgaW4gRFQvQUNQSSBwYXRoIG9mIGVuYWJsaW5nIHBhc2lkPw0KPiA+DQo+
IA0KPiBJIGNhbid0IGZpbmQgdGhlIHBhc2lkIChvciBhbnl0aGluZyBzaW1pbGFyKSBlbmFibGlu
ZyBpbnRlcmZhY2VzIGZvcg0KPiBEVCBvciBBQ1BJLiBUaGV5IGFyZSBkZXZpY2Ugc3BlY2lmaWM/
DQo+IA0KDQpMb29rcyBvbmx5IFBDSSBQQVNJRCBpcyBzdXBwb3J0ZWQgc28gZmFyLiBib3RoIGlu
IEludGVsL0FSTS9BTUQNCmRyaXZlcnMuIElmIG90aGVyIGJ1c2VzIHdpbGwgc3VwcG9ydCBQQVNJ
RCBvbmUgZGF5LCB0aGVuIEFDUy1lcXVpdmFsZW50DQpjYW4gYmUgYWxzbyBjaGVja2VkIGluIHRo
ZWlyIFBBU0lEIGVuYWJsaW5nIEFQSXMuDQo=
