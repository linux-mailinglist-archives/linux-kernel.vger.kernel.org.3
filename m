Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990904FD6BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389940AbiDLJYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355531AbiDLIIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:08:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2547326C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649749091; x=1681285091;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C8LO8vYVLUon+ONyychkpKMpSrIqU1G8Lust1Omohy8=;
  b=AhFNovyujTGBURSSd98RaK6AMfYVbwPM/0v+YTXa+UcSzr+Boe4eou40
   g04zdPsfNq77kpPejMuCJnYr7IOqendPpDw1rsE0agkdh3W7ifdLNCMy5
   YQa94cfQQgO7kfcd+0qZmsuxY/lfj5cNps6+hr91Z6hoV3JcZl6PE2JTi
   e9+KmiZww1Zjo/PFaFqM4E0MOhw8mY3Y07EtvLgukbSvlpRK6/A+Bw/mY
   RZ03khxeMBkaY++6eHcysYvcyiLUFaoEt3Cwf1KL61UsgUwpDp8l9hxbx
   Sf4W/6jJft0YP1YUJZVavSyGdrzsBAudBpeOmthuey490gNlJmAQz0Rlf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242889122"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="242889122"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 00:37:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="660379149"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 12 Apr 2022 00:37:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Apr 2022 00:37:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 12 Apr 2022 00:37:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 12 Apr 2022 00:37:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyvSeWDQqNXNChq6XjvFYgFI4P9XI24nbddVU2IaoTMGQqhWHVNCxEnTCT6gIdFMdyH/AZW+K9NF/HkmK4mn83t7jsEZXnlpihpREWregezZWCQYM9bDvNUihc5EFFDoeIYQg4F+i7stSVaGOZ/dF1muMMrcfLXBBIgMPewSPUVClu+KbQKdJS7bTh9Fb8hgsWFxQLKRucxf07YSsJMtEGSrv1fDn/PjYO2uOj0QRUiowlITxxWGq536MDpGEjxxKmGrAvAoV+v+Ez8T+lqWU1blcs/uvaC4EeB/fwF0m9nJ1JuLtV4ExRjCO6fCVrdCsZ6EB/XwVyssvxtcwA6Ztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8LO8vYVLUon+ONyychkpKMpSrIqU1G8Lust1Omohy8=;
 b=BygPwC40zVgScNLa0Z52YlIOcN+ywYiqzA53296Ts7oPMBQFtodwD86F6vvBmeIXL76QvCJW5W6Y838Ss4q+pfLmzhAFvLu58nUhXpzU+OfjWdp0tirjB8hASFQ2T+KK6DA4D50dn/tP6A2sx9fB0HmG3Jfq5aie+izrq/+Z59XM94VgD7WmpEiUEo9xFHHe1s5tRE1f2t0uI2Zh2HFsxJRXgk4A+YKVxiEKuzgryyFYJQOp6Q8ZuXR0Fz2P2OrXrIvor1IAn6PoFPqA0pp59r2OAxV3h7k8JT/YEWx+91AVCiHqO8nig8bkkQqj/0ody4k6sfHHhHFFX+BDSngdyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY4PR11MB1462.namprd11.prod.outlook.com (2603:10b6:910:b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 07:37:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%8]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 07:37:41 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
Thread-Topic: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
Thread-Index: AQHYTMWQdMRj1LtW7ESP7xJUKRpqwqzrmnCQgAAi0gCAACVF0A==
Date:   Tue, 12 Apr 2022 07:37:41 +0000
Message-ID: <BN9PR11MB5276246A53447854DDA8920D8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527679E5CE0516B2786F57518CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7c70a136-6871-b48c-8e46-852bb1b62958@linux.intel.com>
In-Reply-To: <7c70a136-6871-b48c-8e46-852bb1b62958@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bddad8f-8316-4001-6775-08da1c57537d
x-ms-traffictypediagnostic: CY4PR11MB1462:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB1462FB67FB48F832D61D829F8CED9@CY4PR11MB1462.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SwM0jI2j5YQoaJ5dGnte3c1a+2o7aWFCCnbjDgjr/m5ojEzfNewMiEGbvqA4kMT6keDgBUlhUabLpfs9WEbYzSuzK5hd9/Sn5VN0v1A/8d88NcUzXJwQ8njNG0sXgRjLx54pUnRpELgpIbb6NDLS7LG74nv/+85FzQdpOLht5Mijaj01bhJ0R6HXYVv93M0Xq0bjSCvp9eMlcDQpH9NZqOexVBQ0WcuC2buBWpAToCZoFMI/GQ/7CIwwy0WEitDEzJrN+Tj7Xp1RBePjzAHqJSy14StINEeogrMuTcnkxxnnm2/BdRdEk10HEEpYOfXe8LtjGxDcz8iZazOrfxAIe3hdqqufnlKLLZb4pEDmvL+3+5BEbjEbYs7j47fN+tPAB9GmuPxtTaX4CNgLuXkJQW1K1SWmZzLPqcuPd48ZSsb4k0Bh6Z0RroSoNRM2tdX32m9gGiMp59oUoVv+JWP2k0t/3XQlO90cRqdlF86y7tUMCv8SWdmsFykgvU2XNuO5cnSzAeZgK1kcZIiZObUf7XdYckSnD1tE0qFkVEAJM+QJC0atpXmaqHVc48h4WM1HiXsIBAbWqDPE8GwcIui5Jix4Gf297IaSKStT56TwZrbDmMR+64lGobeTYc3uXUZIDJGEMNYrGlfJdnhmAP7nb0rHzGJDie+z4oPXe6l3qua72jdei1KD3HVsynSCZQEWZ4XYVob/+F7y5OS9MhmV3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(122000001)(8676002)(4326008)(7416002)(54906003)(110136005)(5660300002)(186003)(2906002)(55016003)(316002)(71200400001)(52536014)(8936002)(86362001)(82960400001)(26005)(6506007)(53546011)(7696005)(66476007)(9686003)(66446008)(66556008)(38070700005)(76116006)(38100700002)(64756008)(33656002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SStkdWdUc1NHVWpkdGtXczlSR29MVzZ0M0lpakNJTFBNb2RiYlR5bmlNTnJh?=
 =?utf-8?B?WWFBVEs5TlpoUVIzMUFyc2JjVDNsYWpGR2gySDdJMUNFejR3OU5VUTBoc2xi?=
 =?utf-8?B?UUJjUTdUQXdFSFRIMElKOVN2S1BFY2pMeEpmN0p4NDRnclBZWUxKaWNxSGNW?=
 =?utf-8?B?bERjM29rWTNpS3NIMDhvcmpySy92R3VHeGQ1bHJ4Y2ZuV00zb1JVcXlUZEI0?=
 =?utf-8?B?a1dRa0F0dkNmdXpOY3NLVE5pbnNQODlUNWJ2M2JxdU1BUkZwSkFYZmpydkRa?=
 =?utf-8?B?cy8zWXBQSVJEMXFQNDRESDVtK0JRNkl4RzQySW1raUdGbFZBN1lOK2pUSEUr?=
 =?utf-8?B?ajVsQ1p0SHlFOENCMFhlU3ZIS1VTaDBBYmpzSi91R2lFUjBqQWlyQzQ2VWo1?=
 =?utf-8?B?ZkVvanZZVkdxQUY0WTJFRmhYSXBXMnkyVysvMzM5d3oyano0bktsYXNuVW9x?=
 =?utf-8?B?bm1DOXBKc1lwdk1yREFuNjcxV3I5UDlIeVRwZUxueFpBYStjTkVjSm0wZFFE?=
 =?utf-8?B?VUo4ZU1lOVRia0lvYlFlNU80SVhNWTR4Qjd6ZVBUcHo1QS8vRHdlMHJSOXR6?=
 =?utf-8?B?QlZpRkFCK3BjeHVTMEZQU1JMME94SDA4Zm04ZWVkTjlwYmJXOEdacHMxckRk?=
 =?utf-8?B?ZlJ0OFZFTE0xQVJqWmVmN0RJRVNUSjdjVjVJaytoOTk0SFRYemhwZXQ4dTJu?=
 =?utf-8?B?Q2IxU3J1OUZvcURTSUJIOFk3NHRrb21jbWV3eFZrNi9UeFQyQVRKVXJDMFh6?=
 =?utf-8?B?eHc5VDlYSFk1UmltTy9vUStOdUI0ZVh4SDV5N1FzUC9MSWVHb2J0TWtnbGdO?=
 =?utf-8?B?cTg1THEyTzl1enVMdnJTa1RWcXJUYnloZWtjMzVFZmpVOXk5aENwclZIQno0?=
 =?utf-8?B?L0xUSlpWLzN6bDhnQ0lIWCt6MmVlWEJkNTI0KzM2UiszeFdCaXpWbCtrWVN6?=
 =?utf-8?B?R0tlOVJ1MmdXb3pMQmluT2ZtQ2o3bGlQc0MrVWNTMjlxaVN1RmNEMGc2ZHUy?=
 =?utf-8?B?NmdsU25CVE1sclppOGc3ZlZRZ2tGVCt1VFFwcXVGTW5zUGhIb0ZCTmNNbmZU?=
 =?utf-8?B?ZDZHQ3ZnR0REdG91ZFM1WEs3UkRaQjdsYnpmUDVHeERNb2w5TGU1WFpZZ2w0?=
 =?utf-8?B?TTJxUGx4K3dvSUFjYkM4Y2NqdHpCamFrWFIzYVM0WlVybHNTeUFINVAydDJN?=
 =?utf-8?B?LzJleUlMTkF6UFlkM2x2cjBaRDZRT25xSU94cDI4OEpKNEEzUks5YmpvV0ZU?=
 =?utf-8?B?elppaGtjY1k1Y2VsS1VsOXF5a2RCY3haQ3VudDFDbFZPYVZFR2k5Y0JhUEQ0?=
 =?utf-8?B?V3FDUVJJN09tMFVCMjdRQW9FSytLRnhnaUE3V3ArMlBxYytCMHh2aEQra1dV?=
 =?utf-8?B?NlJ6cVp0c3Z3cXdaMTZWaklLQ2ZTS1B0NmtYTEZJZGNuYkhVdU43YTl1S2JZ?=
 =?utf-8?B?MkgwbnhneCsxek9DNkNWbjg5dEovTFVwa1ZuNXhsZzNKakdCOU14WkJqUXd2?=
 =?utf-8?B?V1AxZW5CVFhUOGVmUmcyaVBpR1JmMDNNdHFhdDc2NWFNOU9HZ2V0T0l4TTI0?=
 =?utf-8?B?ZUIyeHdTMDBmZ3JzK0c2NVQvcG9xTkc3Rlo4OW1LRzNIbjA0WkE0K0cwQ0oy?=
 =?utf-8?B?c2RVRjFPanArZnAzNnM4ck9WdkRKTlhSK1Q1YVBUd2ZjQlBrZTlJbE4xNHBY?=
 =?utf-8?B?Y0VITjh0V3RrRExYNGlFaEJ2ajcrc0NRYnlHcFhYbnF6bjhIbHM3TzEvZDc4?=
 =?utf-8?B?T2RGNEtGem1zRlpkSEFhUEpxQjEvQzdkS0pFaUJSTEdNUThkRFFoN3krUThs?=
 =?utf-8?B?QzIxVGEzOTJ1Ny9aVFNDNnR4amhIdzV6c0ZGa1R0S1NTZWJFQVJRVlEwMmhU?=
 =?utf-8?B?UHJiREhNc2xLb0prNkxza05HR2lub25IOGhLL0VxbHU1YjhCR0FwRFRTTGV1?=
 =?utf-8?B?S1RaMFo3aGpwMW9Ka0svLzlqVmZOa0s5WnZpUm8wNHFSdnJkSjZjM0JWbFFn?=
 =?utf-8?B?V3BhZ3R3RWMwS0Jva2ZyMStRL09QRGdRaXZkakhLbk1rWDc5eUswaXlVcTlj?=
 =?utf-8?B?R3BGSkZ0Y3JSWGE5ZERCdmZlWjB2UFFQbUUzR2xkL0RiOXRpYjlVd2N1d0NE?=
 =?utf-8?B?SXJLUWVuS0hSY2x4b3U3MFdINnI0VitIaWdOTm1zN0ZnZ1JxTGk5cUpWMmxZ?=
 =?utf-8?B?VkUzZnF5SXBxMFJsdUw1TnY5R3A3MGlyTnB6T2hZU0hnYUsyOStNeXRJUWQ0?=
 =?utf-8?B?dEJ4eDBDR3ZDYWVCc0FEYkxCNitIYlVvL0cyS2hnQ2NZeWd2S0ZWRTJBMFdz?=
 =?utf-8?B?Um5rcXo3b20xVFNyZ2Jqb2F2RytnNEJuczZ5MXpoSVdxTkNRNGVxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bddad8f-8316-4001-6775-08da1c57537d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 07:37:41.3869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dVaYC0YWqqyDQJHsE55TLmuOiNTXvqcx1jL21qE3iN2g5gHUOsZMsuLMLZ9u8iXEyGbdUEhV8woF3SbiL7w+5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1462
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBBcHJpbCAxMiwgMjAyMiAxOjA5IFBNDQo+IE9uIDIwMjIvNC8xMiAxMToxNSwgVGlhbiwg
S2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5j
b20+DQo+ID4+IFNlbnQ6IFN1bmRheSwgQXByaWwgMTAsIDIwMjIgNjoyNSBQTQ0KPiA+DQo+ID4+
DQo+ID4+IFRoaXMgYWRkcyBhIGZsYWcgaW4gdGhlIGlvbW11X2dyb3VwIHN0cnVjdCB0byBpbmRp
Y2F0ZSBhbiBpbW11dGFibGUNCj4gPj4gc2luZ2xldG9uIGdyb3VwLCBhbmQgdXNlcyBzdGFuZGFy
ZCBQQ0kgYnVzIHRvcG9sb2d5LCBpc29sYXRpb24gZmVhdHVyZXMsDQo+ID4+IGFuZCBETUEgYWxp
YXMgcXVpcmtzIHRvIHNldCB0aGUgZmxhZy4gSWYgdGhlIGRldmljZSBjYW1lIGZyb20gRFQsIGFz
c3VtZQ0KPiA+PiBpdCBpcyBzdGF0aWMgYW5kIHRoZW4gdGhlIHNpbmdsZXRvbiBhdHRyaWJ1dGUg
Y2FuIGtub3cgZnJvbSB0aGUgZGV2aWNlDQo+ID4+IGNvdW50IGluIHRoZSBncm91cC4NCj4gPg0K
PiA+IHdoZXJlIGRvZXMgdGhlIGFzc3VtcHRpb24gY29tZSBmcm9tPw0KPiANCj4gSG90cGx1ZyBp
cyB0aGUgb25seSBmYWN0b3IgdGhhdCBjYW4gZHluYW1pY2FsbHkgYWZmZWN0IHRoZQ0KPiBjaGFy
YWN0ZXJpc3RpY3Mgb2YgSU9NTVUgZ3JvdXAgc2luZ2xldG9uIGFzIGZhciBhcyBJIGNhbiBzZWUu
IElmIGENCj4gZGV2aWNlIG5vZGUgd2FzIGNyZWF0ZWQgZnJvbSB0aGUgRFQsIGl0IGNvdWxkIGJl
IHRyZWF0ZWQgYXMgc3RhdGljLA0KPiBoZW5jZSB3ZSBjYW4ganVkZ2UgdGhlIHNpbmdsZXRvbiBp
biBpb21tdSBwcm9iZSBwaGFzZSBkdXJpbmcgYm9vdC4NCg0KSSBkaWRuJ3QgZ2V0IHRoaXMuIExl
dCdzIGxvb2sgYXQgeW91ciBjb2RlIGluIGlvbW11X2dyb3VwX2FkZF9kZXZpY2UoKToNCg0KICsJ
ZWxzZSBpZiAoaXNfb2Zfbm9kZShkZXZfZndub2RlKGRldikpKQ0KICsJCWdyb3VwLT5pbW11dGFi
bGVfc2luZ2xldG9uID0NCiArCQkJCShpb21tdV9ncm91cF9kZXZpY2VfY291bnQoZ3JvdXApID09
IDEpOw0KDQpFdmVuIGlmIHRoZXJlIGlzIGEgbXVsdGktZGV2aWNlcyBncm91cCBhYm92ZSBsb2dp
YyB3aWxsIHNldCB0aGUgZmxhZyB3aGVuDQp0aGUgZmlyc3QgZGV2aWNlIGluIHRoZSBncm91cCBp
cyBhZGRlZCBzaW5jZSBhdCB0aGF0IHRpbWUgdGhlcmUgaXMgb25seQ0Kb25lIGRldmljZSBpbiB0
aGUgZ3JvdXAuIFdlIG5lZWQgb3RoZXIgY29uY3JldGUgaW5mb3JtYXRpb24gIHRvIHRlbGwNCml0
IHNpbWlsYXIgdG8gaG93IHlvdSB3YWxrIFBDSSBoaWVyYXJjaHkgdG8gZmluZCBvdXQgdGhlIGZh
Y3QuLi4gDQoNCj4gPj4gKwkvKg0KPiA+PiArCSAqIFRoZSBkZXZpY2UgY291bGQgYmUgY29uc2lk
ZXJlZCB0byBiZSBmdWxseSBpc29sYXRlZCBpZg0KPiA+PiArCSAqIGFsbCBkZXZpY2VzIG9uIHRo
ZSBwYXRoIGZyb20gdGhlIHBhcmVudCB0byB0aGUgaG9zdC1QQ0kNCj4gPj4gKwkgKiBicmlkZ2Ug
YXJlIHByb3RlY3RlZCBmcm9tIHBlZXItdG8tcGVlciBETUEgYnkgQUNTLg0KPiA+PiArCSAqLw0K
PiA+PiArCWlmICghcGNpX2lzX3Jvb3RfYnVzKHBkZXYtPmJ1cykgJiYNCj4gPj4gKwkgICAgIXBj
aV9hY3NfcGF0aF9lbmFibGVkKHBkZXYtPmJ1cy0+c2VsZiwgTlVMTCwgUkVRX0FDU19GTEFHUykp
DQo+ID4+ICsJCXJldHVybiBmYWxzZTsNCj4gPj4gKw0KPiA+PiArCS8qIE11bHRpLWZ1bmN0aW9u
IGRldmljZXMgc2hvdWxkIGhhdmUgQUNTIGVuYWJsZWQuICovDQo+ID4+ICsJaWYgKHBkZXYtPm11
bHRpZnVuY3Rpb24gJiYgIXBjaV9hY3NfZW5hYmxlZChwZGV2LCBSRVFfQUNTX0ZMQUdTKSkNCj4g
Pj4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+DQo+ID4gTG9va3MgbXkgZWFybGllciBjb21tZW50IHdh
cyBsb3N0LCBpLmUuIHlvdSBjYW4ganVzdCB1c2UNCj4gPiBwY2lfYWNzX3BhdGhfZW5hYmxlZChw
ZGV2KSB0byBjb3ZlciBhYm92ZSB0d28gY2hlY2tzLg0KPiANCj4gSWYgYSBkZXZpY2UgaXMgZGly
ZWN0bHkgY29ubmVjdGVkIHRvIHRoZSByb290IGJyaWRnZSBhbmQgaXQgaXMgbm90IGFuDQo+IE1G
RCwgZG8gd2Ugc3RpbGwgbmVlZCBBQ1Mgb24gaXQ/IFRoZSBJbnRlbCBpZHhkIGRldmljZSBzZWVt
cyB0byBiZSBzdWNoDQo+IGEgZGV2aWNlLiBJIGhhZCBhIHF1aWNrIGNoZWNrIHdpdGggbHNwY2ks
IGl0IGhhcyBubyBBQ1Mgc3VwcG9ydC4NCj4gDQo+IEkgcHJvYmFibHkgbWlzc2VkIGFueXRoaW5n
Lg0KPiANCg0Kc2luZ2xlLWZ1bmN0aW9uIFJDaUVQIGRvZXNuJ3QgbmVlZCB0byBpbXBsZW1lbnQg
QUNTIGJ1dCB0aGlzIGhhcw0KYmVlbiBjb3ZlcmVkIGJ5IHBjaV9hY3NfZW5hYmxlZCgpIGFuZCBw
Y2lfYWNzX3BhdGhfZW5hYmxlZCgpLg0K
