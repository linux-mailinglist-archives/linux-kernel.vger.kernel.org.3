Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0698522ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 06:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiEKEJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 00:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiEKEJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 00:09:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC4C5DA06
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 21:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652242158; x=1683778158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CYgAm8VkIEi2Noe7oD7fCsCagGNt/QQ50bZOriRVA6Y=;
  b=N5zxbcPqURl5clfcmnUz+sogt+oJk9t0hd/XORS3pr3LmvKsZFT+ke5P
   oE6PH6SAFRcRJ7tGDZM0lRPZbPmamm+t6dD7mC7ITNXRWC0GOUD31f1Kj
   8BVqHkeShxh4wTMkzYIHqJki8pTUJWgxGAkl3cMTu1CiwZ65awKXACz9+
   QY/T0KizEIwk12Tejy6cyU6MicJ76AVCGoohHgETgaG39tXV3dpwYg1H/
   iPK6zWS5jQjZ4z3mXCcVjQ95RnnbVkrV5OwOiseytHXoJIh3wO6OhXHsE
   +QZcjDMXCOugN5tF/zIjOkZI6OTFe161Md5vh+3nVJzOg7MH5+PsaPOJ4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269513134"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="269513134"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 21:09:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="565977800"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 10 May 2022 21:09:17 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 10 May 2022 21:09:17 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 10 May 2022 21:09:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 10 May 2022 21:09:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 10 May 2022 21:09:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPttDfyiKZOagg6602zEIBV4lp8AKvgGXIyTmvbKElp71cxoBifKo22/5ujdT2nCgt19u4K1WJwR5nvZGjDeFi4jKjdGEixTdw0NXFsOh5Yv9tuJb+OVU6WlTu8+L7NV+w5cA4o49gBjKjApsV562Z9EgWH9fdogd3sPpLw8k0VBZm5/HQdwIq/qtY4fgshG0Qb/EJoD5VqR3veOFDK60OzLmvMH9rQladXJTHYrkI8WU0D3DAtNT3B/e1GcAFQkmAeRG1bmtxqbsB5cQSfC78DCtKtVPwL53Ep0jeL/et5ZAHs4XCVThtRCb9coXqSGQFhGI3XMz4zMp0vulhvBHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYgAm8VkIEi2Noe7oD7fCsCagGNt/QQ50bZOriRVA6Y=;
 b=PZ1djHx1eUp4doIGGjo+4mOvDgQaoAgnvLg+jtsuyKcaIx8K41IkLpKRHFZbv0dW7My6wd1zerO3uC1w+ILyhga7iGfCiL4U67ZT0bNhZCxe0D2DPP27VaGW2CmMcWkwxZqOxnKphI/3pC4J5QfjJuZb3kf0oajyFmYc+LcgP7Zi+Ey8DmtcT/z2IJYcW03LEKBjkiNcCl2lG2iH0196R1LA9lBo2i1Q7cuztlNLkhJP0C4MHy6uNYsGmnz4y/tJAP0dQCgDqPPIyjI9wTHnu0TKsJvyI2sInhA+zsJo4Pdm/KIOROgr0wHYYDFdK4EyIQ39LcCFkVAVkUXfAenTXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1697.namprd11.prod.outlook.com (2603:10b6:404:41::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 04:09:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 04:09:14 +0000
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
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: RE: [PATCH v6 03/12] iommu: Add attach/detach_dev_pasid domain ops
Thread-Topic: [PATCH v6 03/12] iommu: Add attach/detach_dev_pasid domain ops
Thread-Index: AQHYZDYp0YNk67Vgl0egzm2/EdQR2K0YJMoAgADRbwCAABi8UA==
Date:   Wed, 11 May 2022 04:09:14 +0000
Message-ID: <BN9PR11MB5276100AC9BBB7DE5CB800CF8CC89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-4-baolu.lu@linux.intel.com>
 <20220510140238.GD49344@nvidia.com>
 <f56ea479-aa82-37ae-91c3-754816a4ed8b@linux.intel.com>
In-Reply-To: <f56ea479-aa82-37ae-91c3-754816a4ed8b@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c052ef86-335a-4611-5007-08da330402e7
x-ms-traffictypediagnostic: BN6PR11MB1697:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1697C1E088250A32298BBD678CC89@BN6PR11MB1697.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D2jqEUymicOtWZcKUMMzmZvSEWJSkwWGfCrMhIzxoG8Odyz2bnWsRPKXGM3oKJvoZ+K1sg5riAQhyNBCF9bFXyQOLiZkwhL3QOucmQfLVJUDSU6OB97400/yuGmRD7kUaflWnPsRjuhpTUiHJd+zl20hLCOBa6CGoby3WkWJKBWaYXzAbG0dHgfWLktU9xScKfMwWZJDFju7vv/3WjvpLN5ybMdkS82Is6AR2zge5sRb8DZMBpth6IaFH+VRsPcnIYJ/BmTNR/yjQ5U2Ok0kVGZQf1Pb3ObrK/339uFAi4+eASr0pvMWB2L25jdbaLC2firvgw0AooKXm30KBUu9GYn7bswoSid5QBVwoq5XA7X39bS8pgSiOwwTCrwSM2sgIihzCRvcIblnCu6aWi92NXt8nvtbKgwpW0u3LjiKZcnVir4olLmWqHhTmjslUaHZahry4UD52wEDaphbiLeVXdaOsbDCGLZUQ+W+vfyEuuXgl2PnHhyVb+ScSghcLNQHF9cI/8YXILSKAjzMMUzVNmZSa7phf2/J8RtR4VJg5WWaFZ2+DdSUILFFWBM4fZ3qNv/nQq1y2gf/kRWv5Sd2f+Ln7/Am3fCJB4Hl9eOWKUZfSl9JfS5UfT9TOSHD9LqzfZoTVuY9DxOHopyaQSHhKX8qLZPx2WVVOe8mNBtQlNdkkPi1mhLQzXjQJmZ9nN0gBZ5ZzUEslaU67YhPYC4GTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6506007)(122000001)(38070700005)(86362001)(186003)(9686003)(53546011)(5660300002)(38100700002)(26005)(7416002)(4326008)(8936002)(52536014)(71200400001)(55016003)(508600001)(66946007)(66556008)(66476007)(2906002)(64756008)(33656002)(66446008)(76116006)(83380400001)(7696005)(54906003)(82960400001)(110136005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXF6Q3hCTktWdDVpbGtaRHpmbFhKVC9kMjRTaEl5aWFSKzIvZ3NDb1UyaWlQ?=
 =?utf-8?B?aVZTQ2NNRWJSRS9JUDkvL0d2TExnSEZGVTBPbWhBeUJZajhnNmIyakFyaXFW?=
 =?utf-8?B?OHBmU3o5aU80WThXck81WEdXSEFFV01QNUdPRTczSFh3Z05RWFY0c00xSU1G?=
 =?utf-8?B?cTQ1L1c0aHE5dXBrRGJmd1VzMVg4dk9WZlVxZjZwL2JmQ3kzUDhSMnJqWG5B?=
 =?utf-8?B?L1Y2VmtmS1l3U29laFFrczlLekVXYmpqZWNyYlVEQzdUc2dTUXpWV3RGa1ZO?=
 =?utf-8?B?VU50Nk1iZVl6L3AxSmxaVlBySWZsOXgxMUpEQWVuTzhTb3h5aklCWXNRZkht?=
 =?utf-8?B?cHcxamxzQjVWVnJQRkdmSlBrRTM0VERZT1lCUENic2dVcTFSVy9HamxFamEy?=
 =?utf-8?B?UkZMNSsxMEtZSmNXNFlZREpteVNpb0x5ZFFRR0ZDdUpGeHBJOG1VWFFEVU1W?=
 =?utf-8?B?WlRLT1lsaGYvNnEwY2JscFBFczIwUTZiOC9xNFhXM3JhNWphbnc1d2tZOE96?=
 =?utf-8?B?MjJBTTJzd29vY2IreWhpaHpNVmc2QWo3MEw4K3JqWUsvRWg0Y2NnOXpCN0dy?=
 =?utf-8?B?NGNVeG9pZG9KUm11TndKMXcrMHd5b2oyK2pqRnhyeDFtTk15bENjV2lOVlI2?=
 =?utf-8?B?bVpnVUtkcUFHRGVpNXlFbUFXeDBTOFZjV3o0Wkhub0hPcFBTSGZWQlRreTIw?=
 =?utf-8?B?Umt6ZjVrZDZyU2hzRGdveFNYblpXTEhaOHZReE02MjVWeS9HWUlkdzFCYzM1?=
 =?utf-8?B?SkhjbGxCR3N2VWlPTFRXcjZWVlhQK3o3dGF4eHFLVyt6TlJkNUw0TFlPVGZW?=
 =?utf-8?B?TjNpWUk2NU5WVmtONTBhc0tWa0dxYkhxSjE2bHFKbUNXdG9Ybll4bzN4ZXJP?=
 =?utf-8?B?SnZmZ3NSYnhSVXczY2puaUlyazV5VDkwZHNSNWxzU3VKQnl4VkFOQmFjaFRr?=
 =?utf-8?B?eXJyNXcra3RTYm83b2paSDArTEJwYnc5Z3dmaFhrWUpCTUc4RDR5MU5LRTF6?=
 =?utf-8?B?Z3J1WHZnNWRxaVhwVEJyMXEvOEhXQVkxTGd3RDl3VThsMFpiY201dVh3blpS?=
 =?utf-8?B?N0tUTlF1ODdMSVZEZVpQbEphSytSUi9hbEMwdnJMM0RjcmN3K0ZIYkRWVFFE?=
 =?utf-8?B?NlA5d09La0JFWHFzZkduMWJ6dVhEcnBtY1Y1SXR2alZmNzByV1lNMitYbUEz?=
 =?utf-8?B?a3dReFo4SEhJOURZTkg1WkMyU1E5eFZCQkFRTE0ySDBqdXRTTjhOSWNlU0Zm?=
 =?utf-8?B?ZGluR3Rqa05rWmh6VlZaVjFTQjVVdThmbTE4S2FXOFl4eUpiMzFFY2h1TUVS?=
 =?utf-8?B?dk5mcjVZTXN0dmxaOHJDeWl0bjY0QmJQK2lFdnZOL1N6MGx5bzVPc3hYOExi?=
 =?utf-8?B?czVnREpsUnVxMUEzcGo1aGluc09lVlEyM2YzSVlmRDJaejM0TThkcVA0M1dQ?=
 =?utf-8?B?ay85Ym84LzhIYlBzYlBmMG8ycW9KZ3ZvelBYTHIzSkRpWFlIVitiN0ZBZ3RR?=
 =?utf-8?B?anhaZFRtWi9oTytMdEN4YVNJLzRSSnJITnFMQ1NPems3bmhMMkgrYmhGSmRk?=
 =?utf-8?B?cnhzZDMrTzNaMVoweGFNNmJxczh1MTBBaXMvYytIdENIMlNyY2cvQnZRMGw5?=
 =?utf-8?B?dm1BVVJhdkJUU1JpK0pvdmpMOS9EZnliYm1mY0FXdzU2NHdBcXJPUmxvcG9p?=
 =?utf-8?B?RFV1WjNsbE84THc2d05yTTQ2M0x3SzNCVFdhZkFKSStsbUxBTC9ZY096MDBr?=
 =?utf-8?B?blQyNy9BcTlhYmpuN1RMWWluQmovU2ZIYnM0enJpZ3ozY1VMTGJCeWRBK3A3?=
 =?utf-8?B?WVZsNDV5MmlOT0x3SDd4RVVEaGQ3S3ZNR2FHK1U2WWpJd0FPbkRDVXJpbTk0?=
 =?utf-8?B?OUxISXF0UXNiS0psNU1aQmNZMXBESXZzUkozY0RrRVR5c0xWV0RLazcxR25i?=
 =?utf-8?B?em9EWFdtZDF3bDNNVk1vNHNQeWZrZjhWWTlrandJU0I3UVNWeTNtR2g4cUVZ?=
 =?utf-8?B?R0gzUHhkcDltRUdtR3dCUkdHSWN4TUJoZEFEbTFxbC9Ub3ZVZENKRVJOa3I4?=
 =?utf-8?B?TWhDZjBHVGgwQWNLdHcxZ3NBK0JwclM1TDExc3ppelRyN2pmMXRlVmVSRis4?=
 =?utf-8?B?K0pNRUFESC9HN3QzN1JPNFZYWDd6V0xaQnNYUjJmWVhYQWFQTzQrR0I2TEVI?=
 =?utf-8?B?dUNyK3NEb3BnSkRybThCMEdKcmZGdndGd24wVWlTaHNLLzJpMWFMM2g1K25i?=
 =?utf-8?B?UUladTZ5ZHgyWFVDanlMY3hjVkh4MGduTjZ6TTB6aXgrZVh6bTE2R3RMK1BY?=
 =?utf-8?B?OG1sRmRmYkVrVHRIWDNJV1BWZHZ1K0Vhcll3RkR3TE02M2Z6REVudz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c052ef86-335a-4611-5007-08da330402e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 04:09:14.7321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqpyMsq2iXiI9By7t+VGofCx5NDqZNDivD+wMXeF7xXcHqtfYL1gHgeUNEee00C4z+MJ74eTmydx6IbE0pz8AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1697
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE1heSAxMSwgMjAyMiAxMDozMiBBTQ0KPiANCj4gT24gMjAyMi81LzEwIDIyOjAyLCBK
YXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gVHVlLCBNYXkgMTAsIDIwMjIgYXQgMDI6MTc6
MjlQTSArMDgwMCwgTHUgQmFvbHUgd3JvdGU6DQo+ID4NCj4gPj4gVGhpcyBhZGRzIGEgcGFpciBv
ZiBjb21tb24gZG9tYWluIG9wcyBmb3IgdGhpcyBwdXJwb3NlIGFuZCBhZGRzDQo+IGhlbHBlcnMN
Cj4gPj4gdG8gYXR0YWNoL2RldGFjaCBhIGRvbWFpbiB0by9mcm9tIGEge2RldmljZSwgUEFTSUR9
Lg0KPiA+DQo+ID4gSSB3b25kZXIgaWYgdGhpcyBzaG91bGQgbm90IGhhdmUgYSBkZXRhY2ggb3Ag
LSBhZnRlciBkaXNjdXNzaW5nIHdpdGgNCj4gPiBSb2JpbiB3ZSBjYW4gc2VlIHRoYXQgZGV0YWNo
X2RldiBpcyBub3QgdXNlZCBpbiB1cGRhdGVkDQo+ID4gZHJpdmVycy4gSW5zdGVhZCBhdHRhY2hf
ZGV2IGFjdHMgYXMgJ3NldF9kb21haW4nDQo+ID4NCj4gPiBTbywgaXQgd291bGQgYmUgbW9yZSBz
eW1tZXRyaWNhbCBpZiBhdHRhY2hpbmcgYSBibG9ja2luZ19kb21haW4gdG8gdGhlDQo+ID4gUEFT
SUQgd2FzIHRoZSB3YXkgdG8gJ2RldGFjaCcuDQo+ID4NCj4gPiBUaGlzIGNvdWxkIGJlIG1hZGUg
c3RyYWlnaHRmb3J3YXJkIGJ5IGZvbGxvd2luZyB0aGUgc2tldGNoIEkgc2hvd2VkIHRvDQo+ID4g
aGF2ZSBhIHN0YXRpYywgZ2xvYmFsIGJsb2NpbmdfZG9tYWluIGFuZCBwcm92aWRpbmcgYSBwb2lu
dGVyIHRvIGl0IGluDQo+ID4gc3RydWN0IGlvbW11X29wcw0KPiA+DQo+ID4gVGhlbiAnZGV0YWNo
IHBhc2lkJyBpczoNCj4gPg0KPiA+IGlvbW11X29wcy0+YmxvY2tpbmdfZG9tYWluLT5vcHMtPmF0
dGFjaF9kZXZfcGFzaWQoZG9tYWluLCBkZXYsDQo+IHBhc2lkKTsNCj4gPg0KPiA+IEFuZCB3ZSBt
b3ZlIGF3YXkgZnJvbSB0aGUgbm90aW9uIG9mICdkZXRhY2gnIGFuZCBpbiB0aGUgZGlyZWN0aW9u
IHRoYXQNCj4gPiBldmVyeXRoaW5nIGNvbnRpbnVvdXNseSBoYXMgYSBkb21haW4gc2V0LiBQQVNJ
RCB3b3VsZCBsb2dpY2FsbHkNCj4gPiBkZWZhdWx0IHRvIGJsb2NraW5nX2RvbWFpbiwgdGhvdWdo
IHdlIHdvdWxkbid0IHRyYWNrIHRoaXMgYW55d2hlcmUuDQo+IA0KPiBJIGFtIG5vdCBzdXJlIHdo
ZXRoZXIgd2Ugc3RpbGwgbmVlZCB0byBrZWVwIHRoZSBibG9ja2luZyBkb21haW4gY29uY2VwdA0K
PiB3aGVuIHdlIGFyZSBlbnRlcmluZyB0aGUgbmV3IFBBU0lEIHdvcmxkLiBQbGVhc2UgYWxsb3cg
bWUgdG8gd2FpdCBhbmQNCj4gbGlzdGVuIHRvIG1vcmUgb3BpbmlvbnMuDQo+IA0KDQpJJ20gd2l0
aCBKYXNvbiBvbiB0aGlzIGRpcmVjdGlvbi4gSW4gY29uY2VwdCBhZnRlciBhIFBBU0lEIGlzIGRl
dGFjaGVkIGl0J3MNCmVzc2VudGlhbGx5IGJsb2NrZWQuIEltcGxlbWVudGF0aW9uLXdpc2UgaXQg
ZG9lc24ndCBwcmV2ZW50IHRoZSBpb21tdQ0KZHJpdmVyIGZyb20gbWFya2luZyB0aGUgUEFTSUQg
ZW50cnkgYXMgbm9uLXByZXNlbnQgYXMgZG9pbmcgaW4gdGhpcw0Kc2VyaWVzIGluc3RlYWQgb2Yg
YWN0dWFsbHkgcG9pbnRpbmcgdG8gdGhlIGVtcHR5IHBhZ2UgdGFibGUgb2YgdGhlIGJsb2NrDQpk
b21haW4uIEJ1dCBhcGktd2lzZSBpdCBkb2VzIG1ha2UgdGhlIGVudGlyZSBzZW1hbnRpY3MgbW9y
ZSBjb25zaXN0ZW50Lg0KDQpUaGFua3MNCktldmluDQo=
