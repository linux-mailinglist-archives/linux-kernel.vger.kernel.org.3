Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037375849F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbiG2CvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiG2CvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:51:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC7877A43
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659063070; x=1690599070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+xsrU/zeCPbf47AyHi6AgQeWd4CYHkRdtYe36vSDIU4=;
  b=kJNBgTC5HIaK1ZWtszcRIzBJe7X/NIIaCwGzUbIL28NzIm6CpSql6T5M
   hMfc+O6coaIfanLMhByp+JgbWqgJ9fVDXnuTwHMQPdywT4z1nbvrfsGYJ
   TLPrWyuPZhgFpNEHRQILp11lctCxJyXIAq9wXPL/lxbyox+IDnNC6iL4j
   WPV8H3mvFHpnO/AdJAvOitF9e697Ppq/uHlHrTz4EbRDpw/cTpTfFexZn
   qpddmer1/vDCAnoHZuFSNJcyn7wk7kXsRpePUlzyltOuzRfxMSE1WGlj2
   eaNC/BhuV4eWuV7/PnDZghnkxcgaAnSCTwJORo9bchzcFEdvLYUuH/wQT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="374978053"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="374978053"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 19:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="629196784"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga008.jf.intel.com with ESMTP; 28 Jul 2022 19:51:09 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 19:51:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 28 Jul 2022 19:51:08 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 28 Jul 2022 19:51:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw1MHGreO516i/J7w5hUUXUf3FDyXqEDVTrGuYhWMPSKtfbIYuNB4JEKhCPDaptPc4Red7gpAYbeG01yF/QWlA+kOpOf3b7Qb8yOpiZSP4lPXaAIq+WAqMGuBi5JWzIkkKqk1o3S4eN1a14CMi+X34GX4IPX+9rhf7IitKGBfHgh2VcxNfSrmOebXdb7Gkb2CKWg9PUjE6FE+gHC6CTsgsO9KMjgw/2Fr0UkYnGO+igjaTclFxfzl2tT5Cyba536GchgARojviYu2MhzP70z5OUUO2hUc5sZIWvpgurGo6tD3C+YhTnJ/TCK42ZMSE6v2qIo1bhUOLzIsjgiT5e3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xsrU/zeCPbf47AyHi6AgQeWd4CYHkRdtYe36vSDIU4=;
 b=HDvbd8PIpbgEaC7Yf3TeQ0NXonxJssaewB97pXKtQM3Uf2Nx7u6GFZmV4AvQMVlNVsA3zUyaeBkyz1Ujl1oHKdl41m5wZRGBqoCtfjYRlxNNfK7hIxeAmWOdy70e4TQjX8s17vQBktbYOBnfgJSb69+ANsdRDwOmNOu8DvcRYfaHJm48srqnKxxVveD9vIVBC1G5+U1cJ2Otdk3j7VbX7RnG/HXJdscN4hbz10E2NHxk/o/ENVyGjU/YHL8548G1fxOjE+Bnnpvw3b0Rz4jSpZGkzWHYA7zIygDEIB6KcTMHB7pUpThxEt76kniw1QZN9madIn9fDS2Cq3GnqypjAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB5550.namprd11.prod.outlook.com (2603:10b6:5:38b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10; Fri, 29 Jul
 2022 02:51:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 02:51:02 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: RE: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Thread-Topic: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Thread-Index: AQHYkC3GvF//WyZOvUaTLdl04LC2Cq2MG8sAgAEavgCAAhH3gIABB5EAgAB+1ACAANqooIAAlRyAgAD5zPCAAJo9gIAA9G2Q
Date:   Fri, 29 Jul 2022 02:51:02 +0000
Message-ID: <BN9PR11MB52764B2B1B429ECDA0410D558C999@BN9PR11MB5276.namprd11.prod.outlook.com>
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
In-Reply-To: <YuJ6MXoNTj0RKCb8@nvidia.com>
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
x-ms-office365-filtering-correlation-id: 9ed41b89-10ec-48fd-4318-08da710d2c8b
x-ms-traffictypediagnostic: DM4PR11MB5550:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q8uoYQn/DPtvAr1HVkRAPrw5TO/26zjDrkID/Gx11HudawUhEJC5hzRo6d79ll0u7YBYRTMk62hKFuuS8NLsSGS5D63ncZG8Ad+WoWvKkVLfv70b9xdb9CFmFPOAGAThjX51K8DGrXe/9IC+KXluOdjXZX+swC0GY5bKzPaudPE/ZHuyePWDguBZqP0CSE+7e7ryzpUQjsxW4QO289/PdpSynoxJ3osrzmPSWExQkK+q0dUtvi4lOtNRzVAf8XbrXCXMPfjYJlFqt7veThbjpcMZPiA60Ng3Npj60zMQf6w3fYxrQysiHd2RawMFJj104QvpDCOefUEtZqs4JiWl5O5J8aqglE/JHTM99nKAoOQhnhQCtkIed91Oa7X8w7+Dz1VvZtOlNfbdMIRPqf6kDOm7JrbAxn/Va22Jf12mGGTDZJajUKRe9GjvBUWtvWLl9yUL5izhpKgN422iPHTcL+Nu8D/HcMMz7maGcNTO73m5YN7a4Etj/Ve34qq/jXw0O5tF9n7KemhgWfBC7FWJDkhFmxuLlgHF3eob8QW1tNNLGhE+wbLTT6Q0Dmbnk+pFXa3N50BTBC5lA5NerLx4gpdnfn+vj1V3TNHEynKjA5c3pj6CM7ZK+qg2u1+CySappUirFj5fesx+vw+iCJDouhOkJc+/UYImlp6Yc5nwRr61stoU6rexUjpQvxcqZ75KBxFjWzqjySc4KZ8IwoPmi0Co/hZ7kC3xYLyapS2xq23gDOO5TMcJv1QTlbdv8+pV5lLahcHgHzjUYJ6dcNC081ob+2N3c3o8ZsCEafbsHToYE/rqlgVKrhS56jFJwz2k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(6506007)(7696005)(38070700005)(66476007)(66946007)(71200400001)(4326008)(66556008)(66446008)(7416002)(8676002)(9686003)(64756008)(26005)(76116006)(8936002)(478600001)(2906002)(5660300002)(52536014)(33656002)(186003)(122000001)(82960400001)(6916009)(86362001)(38100700002)(54906003)(55016003)(83380400001)(41300700001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEYyaE1WVTZoWU1uL1RUZUNOME4xeUhqY2R3VE9ZODRhMWVCL3hjWVB4U3FE?=
 =?utf-8?B?c2o0TlpMSDNxMFdpNGZVSWVGRGZtUi9oaEgwV21CRGsvVlNFSVRkaEJUMzN4?=
 =?utf-8?B?Sld0MXZ2Ni9PQk5nMjJrUVFsQ0t3NVc1R3IvdmhSMUFRLyszMWtFRkQrMm5p?=
 =?utf-8?B?R1NRM3l5TVFoRk5HVW1mMXhCNURnOWxSRjIxOFozUjhKRTR3eFp6MTBpV0o1?=
 =?utf-8?B?OXIwb3hPWmMxK21tMTh4VDVPbENFWm9xcGRzY1JPMjA1ZVhML0xLZ1pjeW1p?=
 =?utf-8?B?bmd5NHZXOFhVT05yOCtaVmtOcGVvTGpoL0t2MEZ3SnlsTkxHb1Qzd1c4N1ZI?=
 =?utf-8?B?Zmg1eDVJWGV1c1dIMlhuVzBwZk82NUlISVZUUFJEM2hwL0dwUndGWGNqTWhR?=
 =?utf-8?B?OUMreUJyMCtIZDNhZDBndnRvdVQxN2NCMTVEQjJ4NnNubHhlWTlTdXovVnE2?=
 =?utf-8?B?Q29hY29EMmV5REpKeVhqNzdmMEZpODB0MWk3TW9sNllkYnMwSmdrS2NHT2t4?=
 =?utf-8?B?YnM3VXNxekhGTUgxUUZ3ZmVlYjh4N3JSNC9jclpJRkRPWDY1R3k2TUJHcTNy?=
 =?utf-8?B?RUgxc3VQeHU4YjlUZlBZSmpnQkRObk5FamZJb2p3UTVIYTAwZWM5MGF3YzVE?=
 =?utf-8?B?VklTcnFlQ3oxN09FbWJGcjVGUzIzOE1wbnljRFlEUGpEY0l1VjFYRFVXZkJz?=
 =?utf-8?B?d0pZd0FXTFdiQk9IOGlBY2NvWEh6YW80czNSUUN2eENXNkg4cFN5dTN4Q0FB?=
 =?utf-8?B?K2F1YW1VbWhkdkVuYXhqcFhVZTNJVW9xaHVJNjU4SG1Ta3JBdHBlbDJmaEdE?=
 =?utf-8?B?cU5WTHJYK2VVZlFVM1E1aExORnNVbkZHcjJlcHdtZEhudkVmOS9WOWVGK1Ny?=
 =?utf-8?B?clFOV1FFeDNYczFQZzlaUFMvQ0Q2eDArL3NBVHZOdUpPMXNQRGMvYU5DU2Vs?=
 =?utf-8?B?QnBMSWlacERyUzJENnlISG5aS1kwbDVsSG1pemlKaCt0NGNVbzJPV05UQzZM?=
 =?utf-8?B?eWpWVDR5WDNvSTZ2dVZEQlUyNnM0bW9OQ1pxUE5wc2xsUy9DWnJDcUNPKzNx?=
 =?utf-8?B?c3k0c3JzeERXMko2a1VwS256NEJPNmlmd0Y2RVBwSUozSitEYjZFSkdBOTFK?=
 =?utf-8?B?amNFTXNIZXdKUENiZDBXWUZDUWJSVUVEUjRkbWdGU0RkOTlySTRSVFV2K3hr?=
 =?utf-8?B?ZHV5WXNuU2JsRnhmaVFhLzNaQlNXNHpVMVdsNGNmdGFBMVRIYnRQZHJ2TzI3?=
 =?utf-8?B?MUMvdk0rOFRES3JZcVhXTEVmQXErckNBMzdLMWtkSFR0bkVnVjViZVhuVnoz?=
 =?utf-8?B?bFpJaXltRVViUkdRS2RoQkI2bkpjOURKQzRXSU1lNzcyVWJhN09HU0JDKzBx?=
 =?utf-8?B?QXJkQlNtMEVwY0t5WVdjellVK1RVYnZpWndxTVF0MHZUMFpyNGRtRjh2S1FG?=
 =?utf-8?B?eEV0ekdYOTRacmZWelJ1c1dtazhjb0tUSDFuVHVHVERLS0ZpclVOUDR2K3Q2?=
 =?utf-8?B?dEhIYnNleEQ2eU0xTDk5SFArckRUU1luNit4dTRMS2dDdjFKalBtM0gySDNG?=
 =?utf-8?B?T1RkbFVMd3NOd1RzWEpsd25ISlN3Z3pnZmdVb0dobldxUkF2eUdKcFNqTmtP?=
 =?utf-8?B?QlZHMFJhNExFRjJ1NitQT0RxMVJZYlFmd2tTSVpXOEVON0VtbFRXdjcyQjY5?=
 =?utf-8?B?QzhVMnQvelJiR1kwN0RmdVVNMnRRdDRXV3haMmZDeGQ1aWNLcjlqZlJYV2E3?=
 =?utf-8?B?UzhJR205bUVEVmtPOEFWczNmRUxueTMzLzZtY0c0cC9yZGZ1QmduUk9zbGtq?=
 =?utf-8?B?VXFNWUo5cC9CdStyaldKVHhhbGQvb0hNNk4wdE5aV0t5T0IyZms5cEVtNnpk?=
 =?utf-8?B?OVRabE1WUW1XN0VYWEcrRC9EKzdCZ1F5VTJldGc5SmJQLytMVU9WcDJoWlBK?=
 =?utf-8?B?M202ekorWWV4Q0ZvV0s3bjV4UWlzMEltNVJTR2JaUDNITTVJMGFmM1g1eERK?=
 =?utf-8?B?Z0o3cFJHVFBaYWJCNzdIcjZ6eTFFdlFaNGxEQnBhOFM0QmJQbjRFU3FjSzNt?=
 =?utf-8?B?TU41Nk5EQkU0YnhqZ3JGZ0xwN0l6M0NiZExhU24xV2tvKzBHZ1pDRmtMcStx?=
 =?utf-8?Q?hmJNj8ZolIdZEQDheJGKZyNwT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed41b89-10ec-48fd-4318-08da710d2c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 02:51:02.1957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /UM4PJXjZUUyOZAqvIMvno1Pbr6Te8iJlJnQ5z2yrfR8Hb3MiSRpkqNsuGi5SMLSq9mY4NLs9k4rWmajr9JK6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5550
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgSnVseSAyOCwgMjAyMiA4OjAwIFBNDQo+IA0KPiBPbiBUaHUsIEp1bCAyOCwgMjAyMiBhdCAw
MzowNjo0N0FNICswMDAwLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gDQo+ID4gPiBUaGVuIHdlIGRv
bid0IG5lZWQgdGhpcyB3ZWlyZG8gY2hlY2sgaW4gdGhlIGNvcmUgaW9tbXUgY29kZSBhdCBhbGwu
DQo+ID4NCj4gPiBhbmQgdGhlbiB3ZSBjb3VsZCBhbHNvIG1vdmUgZ3JvdXAtPnBhc2lkX2FycmF5
IHRvIGRldmljZS0+cGFzaWRfYXJyYXkNCj4gPiB3aXRoIHRoaXMgYXBwcm9hY2guIFRob3VnaCB0
aGUgZW5kIHJlc3VsdCBkb2Vzbid0IGNoYW5nZSBpLmUuIHN0aWxsIG9ubHkNCj4gPiB0aGUgc2lu
Z2xldG9uIGdyb3VwIGNhbiBlbmFibGUgcGFzaWQgdGhlIGlvbW11IGNvcmUgY2FuIGp1c3Qgc3Rp
Y2sgdG8NCj4gPiB0aGUgZGV2aWNlIG1hbm5lciBub3cuDQo+IA0KPiBJIGRvbid0IHNlZSB3aHks
IHRoZSBncm91cCBpcyBzdGlsbCBsb2dpY2FsbHkgdGhlIHVuaXQgb2YgYXR0YWNobWVudA0KPiBp
biB0aGUgaW9tbXUgYXJlYSwgYW5kIGlmIHdlIGhhdmUgYSBtdWx0aS1kZXZpY2UgZ3JvdXAgaXQg
anVzdCBtZWFucw0KPiB3ZSBpdGVyYXRlIG92ZXIgYWxsIHRoZSBkZXZpY2VzIGluIHRoZSBncm91
cCB3aGVuIGRvaW5nIHBhc2lkIHNldCwgbm8NCj4gZGlmZmVyZW50IHRoYW4gYSBSSUQuDQoNClBy
b2JhYmx5IEkgb3ZlcnRob3VnaHQgYWJvdXQgdGhpcy4NCg0KVG8gZW5hYmxlIFBBU0lEIGluIGEg
bXVsdGktZGV2aWNlIGdyb3VwIG9uZSBwcmVyZXF1aXNpdGUgaXMgdG8gcmVzZXJ2ZQ0KUDJQIHJh
bmdlcyBvZiB0aGUgZ3JvdXAgaW4gdGhlIHJlbGF0ZWQgYWRkcmVzcyBzcGFjZSAobGV0J3MgYXNz
dW1lIA0KdGhlcmUgaXMgYSB3YXkgdG8gZG8gdGhhdCByZXNlcnZhdGlvbikuIEluIHRoaXMgY2Fz
ZSBldmVuIHcvbyBBQ1MgaW4gdGhlDQpzd2l0Y2ggcG9ydCBhbGwgRE1BIHJlcXVlc3RzIGZyb20g
dGhlIGdyb3VwIGNhbiBiZSBzdGlsbCByb3V0ZWQgdG8NCnVwc3RyZWFtLg0KDQpUaGVuIGZvciBh
IGdyb3VwIGNyZWF0ZWQgZHVlIHRvIGxhY2tpbmcgb2YgQUNTIGxvb2tzIHdlIGNhbiBzdGlsbCBo
YXZlDQpwZXItZGV2aWNlIFBBU0lEIHRhYmxlcyBpbiB0aGUgZ3JvdXAuDQoNCkJ1dCBmb3IgYSBn
cm91cCBjcmVhdGVkIGR1ZSB0byBSSUQgbWVzcyBlLmcuIFBDSSBicmlkZ2UgdGhlIFBBU0lEIHRh
YmxlDQpoYXMgdG8gYmUgc2hhcmVkIGJ5IHRoZSBlbnRpcmUgZ3JvdXAuIFNvIHllcywgZnJvbSB0
aGlzIGFuZ2xlIGxlYXZpbmcNCm9uZSB0YWJsZSBwZXIgZ3JvdXAgaXMgYSBzaW1wbGVyIHRoaW5n
IHRvIGRvLCBlc3BlY2lhbGx5IHdoZW4gaXQncw0KdW5jbGVhciB3aGV0aGVyIHRoZXJlIGlzIHJl
YWwgZGVtYW5kIHRvIGVuYWJsZSBQQVNJRCBmb3IgbXVsdGktZGV2aWNlDQpncm91cC4g8J+Yig0K
DQpUaGFua3MNCktldmluDQo=
