Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9D853B390
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiFBG3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiFBG3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:29:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AE321482B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654151385; x=1685687385;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CACt+NqSvTuS5kcLawOZGr1REKwBP421MpXryJmzQl4=;
  b=Yklfe4qWeOwCO3u7RrWBIsMsy8CV6hegtTsietf2ZIx+ZeCiydarQQqi
   6uQsaKXvO6hUZGE+YMdcsLsqnZ56NdvETukDPLw3MRXrHHiBa0QH+C5Vs
   cRvonQ2hcSGi6ykUonWgiihrBLjj2z3MWeR2XtpTM3vsE0z1dqUqP3sYW
   gsOdBLogRMJAKOEJVWNfnjkMUbAgBkSfuru7/nMjxk+OInsKyiCUjirVz
   5PSD6omnSv3qqFtnwLpMy7YyX7quA//03eGjNk3TX6gZtsH3s0v/XlAkP
   aDIX59mf3gdksmtRlOhdoxnalTv3m3c4L5fgHv1XftfkTOp+OtJmkN9Dk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="273407307"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="273407307"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 23:29:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="581938095"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jun 2022 23:29:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 23:29:44 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 23:29:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 1 Jun 2022 23:29:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 1 Jun 2022 23:29:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbnfGKlAXQZf9rJRs1RcXhDbjOAa/TW2oqy0+S5uiWq0thNVFOH2XXSjfmH0KMtwT2HI5OhmMRvN1aj9Cto8wkiXgnyAtfHnLQStlKPzXJpPFEkqgaTk3govDLEc+A6sg95Y2GulWj2OeIcp7/hv3aEhdGLU+6vJVO2zPjXq+yPwp2u4xmT9m53y+aNwzcwChlI6UfXncgHt80pLvsVbZwTLPRCqB0nyUu5WcAA0BpgghUcbtihyV1HPzyaTRfcOofU5fsNXGdiRnem4VWPmgeq4PCPR7syO+NWxFAONqOMPp8qywoFpXOtiGIJHXdZm/1CVbaW8mpuEgcGGYgC90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CACt+NqSvTuS5kcLawOZGr1REKwBP421MpXryJmzQl4=;
 b=b+rMJ+x5+UXwXZW0hs4s5oF1dzct5Jm9GF3wDAG550cT2gBVyQfcpgq/Jk3QZ8pymDzajtxyyjrZWp1zMyTSmfR+MjtbLLGfoo+p6cfEBtaUES80Q+34uHoizysMLpc0OrJHKpKQS+an+h8bpQutN/s5KufvwOE8r3c7Q3UF+4Klaxy2hlYEUphuEKWp2JKr8n4nDEmjxsw+SR0Dkqhyk7LzhiyhXxAizsawwZkqXsQbA378KbrGYlgsYLwlDyx/BjtkpVsecCJhBNchQ15MhVeCyDqQTkoQ1q69zsepl9/9PXFONRzWSXNKOVp8il2QqUcz8mK5qfA/87DOFQR7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MWHPR11MB1341.namprd11.prod.outlook.com (2603:10b6:300:2b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 06:29:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8%7]) with mapi id 15.20.5314.012; Thu, 2 Jun 2022
 06:29:42 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 09/12] iommu/vt-d: Check device list of domain in domain
 free path
Thread-Topic: [PATCH 09/12] iommu/vt-d: Check device list of domain in domain
 free path
Thread-Index: AQHYcZPVYxDxhgtiEEikhmCfUbpnPa06TxHggAAb8QCAAT3ngA==
Date:   Thu, 2 Jun 2022 06:29:42 +0000
Message-ID: <BN9PR11MB527652AF527A66551934CD4F8CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-10-baolu.lu@linux.intel.com>
 <BN9PR11MB5276C3D7134CCE64D88F6F048CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <0b0d9e4e-f3bb-e47d-20e5-bf380c79f7b4@linux.intel.com>
In-Reply-To: <0b0d9e4e-f3bb-e47d-20e5-bf380c79f7b4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf53e4c4-d937-41f9-aa99-08da44614738
x-ms-traffictypediagnostic: MWHPR11MB1341:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB134155E18CF8E6297ED7D55A8CDE9@MWHPR11MB1341.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1JAzDvkba6HdRnGDqblKxd/I/Ova29WdJ2+XVKe8Xz7h3xIVo5hBw6VMh9fHqWc2ouaq5BncAsXhXpm3dhmCokHhCS1wOjNxWlcAV1KOXl4Pynzvb1BcHN8yI6cAWKs71Td4O4QeAmRyE/uOtFwP/mVkqPXBj3PwzN4z5QmbSRSeaODFVY5qIzxUJtuhoXbfnGrxyA1J4NY7SSWs86tcIXzAy0cmjlDiyWeU1cto72ZdWI43tbTT8HFaT2c2y34pdgUGdnvosd+0JtMd+bGk/LGBnf6YsRfT7B03d61DcR3lRHLYOwOnRYSXv8gXHgDEaJ45r6+E1b6r+tPhZHyAd0IWOK5qDT++L6RXyOW6/tay7VENUEYXRE7H78eWCpAn5px/rBi3jUacXMbRq85Oazj2r/UPtX6xo7uHu2LAyEdrZ5otrdmBeF3qN/aoXK6OYo+Vtiv3W6JymPrSNK+eBTS7RCQAV5iGrL2yXATUDNRwje9pVjiW+cOy/VS9I3HPc/nl5Y2mqWL6OxpB6LDUVcde90qHR8LPHAogUyjNWfl8jywau1ZomqKf/98ZOxA3i5I3gQ5LWbmzptU+IIaDBeXsDN7UXorgWmNHPNf0ICkRNmHMkakJoc99bJA5E6MNl7pkE9jzeuPc8J22+wpESmU0PfrJuD+Y3VYUXkCFUWgB/DrZMNLa5bPHYw99tbyHOiQqgV7FbhKKwkK7XJgMzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(9686003)(38070700005)(76116006)(53546011)(82960400001)(54906003)(38100700002)(33656002)(66476007)(110136005)(6506007)(186003)(122000001)(316002)(64756008)(66556008)(4326008)(66446008)(8676002)(7696005)(5660300002)(2906002)(86362001)(66946007)(83380400001)(508600001)(52536014)(55016003)(26005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlNRWUt3SGI2YW8yeGd6cTZ1bWgraTJVcGFQY0sveXEveURBd3UvcHAwRFdm?=
 =?utf-8?B?bzRkRkZCVGFqYXROdS9wdzduMkQxU3cyZGU5Ukp6ay91NTlkQVBGS3ZYRm0x?=
 =?utf-8?B?OFU0ZkMwV3dFd21mZFR1anhNQTNJamEwOE1iL2VtM2N0d1lLZWRha21kK1FW?=
 =?utf-8?B?bXpXczdOUGFyZGhDTDIwdzEzS25pbmgvSjRCNnVkVGdsT3ZsdUdXVUZFdk1I?=
 =?utf-8?B?VDNFaG5HdEt2cENuTU5jSjhLM0NlWHo5STRGcFRNalVZSXVwVXhnZm5uM0ZE?=
 =?utf-8?B?ZjBMR3RONnU2QUR2M3F3L3ZzQ3V1ajRQd3VWSzl5cjFKNXZxYkdZYkFJRDcv?=
 =?utf-8?B?RS9BSmxTd0twYnNOdVJ6L002MUY2MkhLWTJyM1VINHNudXd4am1NV1h2Vit6?=
 =?utf-8?B?eHR5S2dDVjJSTUtnWnExcXlPR3RDb2hXMGR2bXZPU1R0RVBBbnppcEs2dW03?=
 =?utf-8?B?QjE5anBhOFJ0WnRUYW1YYzJHbFFKOEQ5VW5TSjhkVlM3cUhDTWNEdHpSV1JL?=
 =?utf-8?B?REt1ZzQwaCtoWksyYUpSQ2lSZUxBUk5lTW1IMkZuRHBqZ2ZqSldLWmE4aWNa?=
 =?utf-8?B?dEdKR014VEVtcFMrL05xZVdnbUJBMmNlUWhTL3J4UkhFTWlhUlZ4U090cFhJ?=
 =?utf-8?B?UnN6UFFlNCt4VzBjR3BVV1VxSW5KOGo1NEwxVkg4N1dyV1liVnhVZzdIL3hp?=
 =?utf-8?B?ajU1UlRzN0tQajRHcWJZODlzcjMweWFvWkVaYWtXT0RReVNTVmx2TGRCRXFu?=
 =?utf-8?B?QzE5UmtILzE0ZDRGMHAzay9CQlQwL2NjWG5jWVkzYVhnZlZ2Qk1rTk92RS9K?=
 =?utf-8?B?K21uODBpUDdadGM0MmhlbnNIWDNiWDkzWGEvd0N3MjVtOHkzYzlvS0taa2RF?=
 =?utf-8?B?enYzejNJZks0RjFxeTBDV2xKYXVhbExUMk1IR2pEMisxK1hsY01MYkpWcnNB?=
 =?utf-8?B?UFhuNDYzSzVrbmZaWC96S0tIdExlSTlUTWdmSGVVNXliaTVHNzdRMmlWR3Ra?=
 =?utf-8?B?RkZ2Z0FaSWxpcWlISlNnMzRINHhhSkRjbmxwb0JMbmd0bjBKVmNkRHpHUGtO?=
 =?utf-8?B?aE5kS0tLanYrT1lidjVkWm90bVFpbjNCc0duVG40dXBwLzQwem5ENWhYV0xw?=
 =?utf-8?B?V0dzVEQ1VkR3NkZNc3pXYURMcUJkN2ZFM3ZTamxCaUlnSUpiMHNmSVVFajZD?=
 =?utf-8?B?ZkdnKytPY2llMVNFVmhyaDJFNGkyME55NDNBa2tzbVlhU2xTSDh0OTlsNkhh?=
 =?utf-8?B?akNnUUVnNklyT21ybk8rd3F0QS9kTlNhWHZXQUdpdmowTDByZXExNXBpVTg5?=
 =?utf-8?B?SjNFbHN2bTVuVXg2RjFyR0tiVjdPK0twcy96aHd0eHErclFsaldTSVN3VHhx?=
 =?utf-8?B?L0VqVGxGZkx5SHdNTjRUQ0Y4b09XQ2taamF6Uk4ybjJsMUtLcHVObmF4Q2VU?=
 =?utf-8?B?UHdMaXpNWXVEUzRNS2h2RlMwRk9SQlBkRXRaK3drZFVpdmczS0M3V2h6Tmww?=
 =?utf-8?B?ck8yZENQaHVKamEwcTZtR3BsUWpyWTJGR1NhMCtZNkx1Rkt5MXB2NjZ6V0JX?=
 =?utf-8?B?cGo2YnZvMDJoMmZIQUE1YU8zMU1zYTNwVnJpazhNZFdOa255OTdROEJzUk1X?=
 =?utf-8?B?M2lGL05Yc1BhK2FvN1ZwWFp4WVd1c255a2pJSVBjc2k4OENyWWxPYlFxQUl4?=
 =?utf-8?B?ZXpQbzVwTGphV01seUxxdWpwNEJxb1NUSW9ycFlvSEN0dU9XTXRlREJobkla?=
 =?utf-8?B?UTFCRUxFVEZtUVBvSm94WDU0S0tjbGpnNCtyZld3aGMrb0hpYXNZcWNjYXJv?=
 =?utf-8?B?YklEbmIrS0RxbHUyWlZaK0xuUnFTQ2xPSzZLOG8yaE9JZkY4WEtzN0hUYmtl?=
 =?utf-8?B?VG5VMjltUGdHNitob3cxVkFRc3dqZDdmV1krVDNXZzJFcW5EVk9ZZG9Ebis4?=
 =?utf-8?B?UE1lSFJXZmVNWStFVlJ4YldHZ2JCMkV5YlAyeEtJOUF6MzI4STAwUWswQ3dY?=
 =?utf-8?B?bmhIOXh2M2R6dkZYcW9scXBUYk84Z1p6NjBHVDljY2I4SzdZbVNzamkvTmVS?=
 =?utf-8?B?VzQreTJFdzQ2VHhnbEsrcHpkZk9oYm5rK0dQVktoUFhvRVRiR2pTRHlkbWFR?=
 =?utf-8?B?eFR2YkZjSENlTnVJUVpyVFVlQi9BUkRNckpxMG9TejJ6WmdYN0pHY25XbmhM?=
 =?utf-8?B?SkxiQzZ1dkVJRjNEVnQyTTcybVNzejVhQVBUdnpQaTRuQ1R5VU8rU0tZR1Iy?=
 =?utf-8?B?L2VVM2JCSmprY3JmTGF3TXlzNldnR3J2cVBKTWZRdmlSQlErcDcySHQwT0t1?=
 =?utf-8?B?Y2lESDU1WHRMSmNmeVFHN1kybGtXdGVQR21tWTJZVU5EekF2YjFJQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf53e4c4-d937-41f9-aa99-08da44614738
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 06:29:42.3446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: suGbWwQbIWcJRdNhdFUB1JHz/wZGqJyCJNsjfa/H5HiWm5X6oRPxdJ8TONSWuHR0V7F8DJxR+vAHF8YvIcs3Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1341
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEp1bmUgMSwgMjAyMiA3OjAyIFBNDQo+IA0KPiBPbiAyMDIyLzYvMSAxNzoyOCwgVGlh
biwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb20+DQo+ID4+IFNlbnQ6IEZyaWRheSwgTWF5IDI3LCAyMDIyIDI6MzAgUE0NCj4gPj4NCj4g
Pj4gV2hlbiB0aGUgSU9NTVUgZG9tYWluIGlzIGFib3V0IHRvIGJlIGZyZWVkLCBpdCBzaG91bGQg
bm90IGJlIHNldCBvbg0KPiBhbnkNCj4gPj4gZGV2aWNlLiBJbnN0ZWFkIG9mIHNpbGVudGx5IGRl
YWxpbmcgd2l0aCBzb21lIGJ1ZyBjYXNlcywgaXQncyBiZXR0ZXIgdG8NCj4gPj4gdHJpZ2dlciBh
IHdhcm5pbmcgdG8gcmVwb3J0IGFuZCBmaXggYW55IHBvdGVudGlhbCBidWdzIGF0IHRoZSBmaXJz
dCB0aW1lLg0KPiA+Pg0KPiA+DQo+ID4NCj4gPj4gICBzdGF0aWMgdm9pZCBkb21haW5fZXhpdChz
dHJ1Y3QgZG1hcl9kb21haW4gKmRvbWFpbikNCj4gPj4gICB7DQo+ID4+IC0NCj4gPj4gLQkvKiBS
ZW1vdmUgYXNzb2NpYXRlZCBkZXZpY2VzIGFuZCBjbGVhciBhdHRhY2hlZCBvciBjYWNoZWQgZG9t
YWlucw0KPiA+PiAqLw0KPiA+PiAtCWRvbWFpbl9yZW1vdmVfZGV2X2luZm8oZG9tYWluKTsNCj4g
Pj4gKwlpZiAoV0FSTl9PTighbGlzdF9lbXB0eSgmZG9tYWluLT5kZXZpY2VzKSkpDQo+ID4+ICsJ
CXJldHVybjsNCj4gPj4NCj4gPg0KPiA+IHdhcm5pbmcgaXMgZ29vZCBidXQgaXQgZG9lc24ndCBt
ZWFuIHRoZSBkcml2ZXIgc2hvdWxkbid0IGRlYWwgd2l0aA0KPiA+IHRoYXQgc2l0dWF0aW9uIHRv
IG1ha2UgaXQgc2FmZXIgZS5nLiBibG9ja2luZyBETUEgZnJvbSBhbGwgYXR0YWNoZWQNCj4gPiBk
ZXZpY2UuLi4NCj4gDQo+IEkgaGF2ZSBldmVyIHRob3VnaHQgdGhlIHNhbWUgdGhpbmcuIDotKQ0K
PiANCj4gQmxvY2tpbmcgRE1BIGZyb20gYXR0YWNoZWQgZGV2aWNlIHNob3VsZCBiZSBkb25lIHdo
ZW4gc2V0dGluZyBibG9ja2luZw0KPiBkb21haW4gdG8gdGhlIGRldmljZS4gSXQgc2hvdWxkIG5v
dCBiZSBwYXJ0IG9mIGZyZWVpbmcgYSBkb21haW4uDQoNCnllcyBidXQgaGVyZSB3ZSBhcmUgdGFs
a2luZyBhYm91dCBzb21lIGJ1ZyBzY2VuYXJpby4NCg0KPiANCj4gSGVyZSwgdGhlIGNhbGxlciBh
c2tzIHRoZSBkcml2ZXIgdG8gZnJlZSB0aGUgZG9tYWluLCBidXQgdGhlIGRyaXZlcg0KPiBmaW5k
cyB0aGF0IHNvbWV0aGluZyBpcyB3cm9uZy4gVGhlcmVmb3JlLCBpdCB3YXJucyBhbmQgcmV0dXJu
cyBkaXJlY3RseS4NCj4gVGhlIGRvbWFpbiB3aWxsIHN0aWxsIGJlIHRoZXJlIGluIHVzZSB1bnRp
bCB0aGUgbmV4dCBzZXRfZG9tYWluKCkuDQo+IA0KDQphdCBsZWFzdCBpdCdkIGxvb2sgc2FmZXIg
aWYgd2UgYWx3YXlzIHRyeSB0byB1bm1hcCB0aGUgZW50aXJlIGRvbWFpbiBpLmUuOg0KDQpzdGF0
aWMgdm9pZCBkb21haW5fZXhpdChzdHJ1Y3QgZG1hcl9kb21haW4gKmRvbWFpbikNCnsNCi0NCi0J
LyogUmVtb3ZlIGFzc29jaWF0ZWQgZGV2aWNlcyBhbmQgY2xlYXIgYXR0YWNoZWQgb3IgY2FjaGVk
IGRvbWFpbnMgKi8NCi0JZG9tYWluX3JlbW92ZV9kZXZfaW5mbyhkb21haW4pOw0KDQoJaWYgKGRv
bWFpbi0+cGdkKSB7DQoJCUxJU1RfSEVBRChmcmVlbGlzdCk7DQoNCgkJZG9tYWluX3VubWFwKGRv
bWFpbiwgMCwgRE9NQUlOX01BWF9QRk4oZG9tYWluLT5nYXcpLCAmZnJlZWxpc3QpOw0KCQlwdXRf
cGFnZXNfbGlzdCgmZnJlZWxpc3QpOw0KCX0NCg0KKwlpZiAoV0FSTl9PTighbGlzdF9lbXB0eSgm
ZG9tYWluLT5kZXZpY2VzKSkpDQorCQlyZXR1cm47DQoNCglrZnJlZShkb21haW4pOw0KfQ0KDQpU
aGFua3MNCktldmluDQo=
