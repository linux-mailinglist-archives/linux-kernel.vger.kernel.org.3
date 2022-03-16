Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157684DACAF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354506AbiCPImq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiCPImp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:42:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3966764BC2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647420092; x=1678956092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N7dDTlk/VYWq9OLYQeavX7+qoTKYQji5BHPmQJkTz98=;
  b=RdwqNw9Bwio25S44Cs88P+SEIGfUp1fNScP2klJeb2EET/ZpWyoyLE+R
   BU9/t3S7L4G0QvCpR2a19/2u2S5NeVspA8HYjpGsqDtRDRwKLDSpnFFtm
   H8iglKu0OKlxY6MufXxK0jlXLzuho44Ot6RsqgleIsjQcZ1ZuEaxfCHQf
   /HXk/JBbxeuPa3bj2vFIskL2QPqMQb7iSmVOeSYbhwn5v29863avSSzRj
   fEp+xX7v62+gp2sx2iL0pbmi5tkVo+MIL90C/PSfZPlqsRVObykKPd5ad
   5ylUAvNk+lnqkKPlcObabaBzlGuNMYVN1FGPdkYg3nrEVUvpZB6YVCmtM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256250141"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="256250141"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 01:41:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="613561141"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2022 01:41:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 01:41:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 01:41:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 01:41:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 01:41:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgb8JYt0JjeM04fw8BRKv0ZtFk0FQEIYGHnvd/I2mmmOAwITr8/Kx2JrEEEgqisq/tJj/wYBC6HjpKUf/tdXnFq4Tbi+8Tg7Zga1ZaLNpbfS0ST0+91FKDaAyBpT9COk7QdBlQ7x07/J9TP3vPjgU8ke3VJmCinXM8WxSWBBOgGJN9faZXZS6j9fkW0FnSXbJsIixenujC4VNB+ngoM+UCZrhLUJV/SniCyEgyXaSA2g2ovv+bA6FiVeOZJSw7Z4UqCCcIeEoZWDt1jXUV5oaV4k9F5jtxN8UPkjlKObhHDDX6QRZOgYJt8j7ToTZrb0SEdb0u9bZ6DT22MCH9zm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7dDTlk/VYWq9OLYQeavX7+qoTKYQji5BHPmQJkTz98=;
 b=MI+SugPVlelIg0zfszeHYazRAy+Q6XoBwMDgemb94JPpX1rCYogM9FmZF3E44kf3gKCxuY7nELGoHy1oBTX7+SxuaujBoCDzBDD8xgK3sPKUKLdCp/aW2pfx8SnJEyqlFB0nmjftQC++etZaB4x73SBG8SwhPjmh0TOUOa08yFYtsKCJpWsrJBstXG1O/aBpG11wCmdshdyRlh243uaQ6IjOwB/NKWX84ONURdfXn82pvJIPp74lTE29sPswFjL5d2K+VMdpr3oivYRLmoujs/LwwNvxFah+sHJrDtWmAkTLcGP9kNmU9jyJ6SgmROhYjwhuY81eS7XWXYBN0GJoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4044.namprd11.prod.outlook.com (2603:10b6:5:6::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.22; Wed, 16 Mar 2022 08:41:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893%8]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 08:41:27 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API users
Thread-Topic: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API
 users
Thread-Index: AQHYOCoa8qozHAC5REKbTKib7rW4dazAS/aAgAAz2gCAASkYkA==
Date:   Wed, 16 Mar 2022 08:41:27 +0000
Message-ID: <BN9PR11MB527697CA21B1D28BBD0BE0DC8C119@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
 <00286dbb-fe73-3604-4dec-340eb91912c3@arm.com>
 <20220315142216.GV11336@nvidia.com>
In-Reply-To: <20220315142216.GV11336@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9b3a636-0780-4e7e-a862-08da0728c2c6
x-ms-traffictypediagnostic: DM6PR11MB4044:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <DM6PR11MB4044EF2A2DE155B2C9716F8E8C119@DM6PR11MB4044.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oySx9dJlQJN1x7AFrWbHvjiVmLl3YcsgjixLxZ6IBkdDtzBiUzhQvzPiE5OJQK+OmU58JT0Wto+gnN4qtFL2wpHUCvRqwH6qf9KAl6tdT8z6IRZoY9zJzBbdbFT1K+MdU6QZMysV4HXeM1JQiqJt7eg/OzrsFTxUQMXkGjio92/1ofn3VSoHmNeTkwD24KtaZXzYJCc5CTKEAs0qzFwI62d0TfSN58vbVv6ALtqTv3zgEz+CtrNzlm/PIsOWRgWfFtzsA/eS0pdsfLkzJbLSgXbXSPbZASVH9zf8owm7u9a9HKPM9mi8me5HOa2RoKWOQ63H/uQujpuWJSf6hEdl7Cn13rMZFFs0ZvHT6pIc9045ao8Mc46q+QiNGHKq4DQWWDm+QYZ6Ua/qk7w9GGeOelcoYXoZWBAf1PHHS0pI1z8K5zhUCMsViN0+4vkVcj/XZoqAmbqEialIFszdeNM+4KTN8t6URcnwwKwzoAOEKWrnMu2KtD/mPC3a8dhimEts45y2oQ3blOglDYwc4Xh/Ueej4sw16OD37vIrJCm7ky/NRNtwOkFxUpDzN/eopWmYoP7m9SBFWLHWKS7N6z64UyBo4p46UjCOyzhDR6+6ZIchUlHwbcJkY10CF92p/bTrDyGDlTVlrX4Ka3zD2yMjxMaPAESYp9SMY66ruKSXCutfXvTdMYr+6DWq1TKDRJNXqvj4K4njs8iiZztFr3N1E/htFr2lor1KbHbxYu3gASQRjqXLcwjW8uP9SFmnvzwZ9+/82lLs/1fBel/3RFiBow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(122000001)(38100700002)(9686003)(186003)(26005)(38070700005)(83380400001)(54906003)(110136005)(8936002)(316002)(86362001)(52536014)(7416002)(8676002)(5660300002)(4326008)(71200400001)(66476007)(64756008)(66446008)(66556008)(66946007)(76116006)(55016003)(2906002)(6506007)(508600001)(53546011)(7696005)(33656002)(26730200005)(19860200003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWtkTFhGSStiUmpkOTdna2lxdnhiNkdlaXNNZWlYTzNGc2d3ZVllQS9yN0Yy?=
 =?utf-8?B?cUN4Z1NsTFdOMzlxajNpUmhIcVpPa0Uvd2JYV3hBMU9WM09mcWxTUzFqN2NU?=
 =?utf-8?B?MlVEUkRvWkVxRmY4ODVHZExNVGkvM3pEZGx4NnpQSlo0STFnS1FBekZZdWRB?=
 =?utf-8?B?Z0ZZZEdUQUlmOFY5OXV5TnlLMm1qUE1HeWVxTlNiOGg2NVFuaTNKaExaa0lW?=
 =?utf-8?B?YnlxT2Vsak9reVBPYlBDYVFSdXYxTU9wQlVIYjU5M0l2TXNBYVRhYXdWSDNa?=
 =?utf-8?B?R3ArTk5Md2p6Z28vM1JRM3J0UTdWNVl2aDBJZkFKcTN2cDcyaDJIWTQ1RW53?=
 =?utf-8?B?eXlCQU5jWjFFY25zKzJWNVJ6U1R5MnNRVWErUEdJNHRVNDdjQUdnY3FiMGdt?=
 =?utf-8?B?bHQ1VXUzaXBLZThYTzBOOXpFOFBpcHZPc2VZVm51WWRSdWZwdDJ3TUVWanUw?=
 =?utf-8?B?ZWl4N3VFamFzaFRGdm1OazJ1bEJvTFZIVGlKaElobmt4S2tkanNrcmVWNTJO?=
 =?utf-8?B?aEk0QTNhWWh0clRjR01Lamhkb21QWWdCSFRaRFJYQ1JRblNCcU5CYytHWEtj?=
 =?utf-8?B?a1JkZ0RlK3dJTnhYc3JOZVFhR2dCWFM1ZzlZQWJER0U2WnJmRGU2ZHRMS1B2?=
 =?utf-8?B?V2Zsay9VREptd2wvejVHaGNBM2xPUEREdFB5clZRTFpwY1p4QVluMXBxbGZN?=
 =?utf-8?B?UCsxSmU2dXc2dTRBMTN5MkRFaHRBWjlBWFZYWHBxdEJpZ2RkWHl6Ym9YN2FK?=
 =?utf-8?B?OG1DRGpzMElTSVR6RndvZmlsZHRwTk9ZeC9sU1gydXhnRVQ4YW44V0NLWllF?=
 =?utf-8?B?Unl6c3lrR0lKV2FmTktWbDAwRGNHVXM5dHpxMTIvWDRlQjNmZGVRdVNBNGhQ?=
 =?utf-8?B?SXd2a1I5S3ZtTjU2di91SEN2L2paMzlUU21DR04vRHhxM0hDS3FsTXdPdzg3?=
 =?utf-8?B?R0RrOXVFMERWd1F1S2FJa2U5ZjJhbjlFa0R6U2lBeGJnSWl3Z0ViRHhjSVl1?=
 =?utf-8?B?VDBNSWtJMTQrWFp2QksrSE92ay9KemRpR1M1c3dvL1U1dytubUZaMFIzQWhu?=
 =?utf-8?B?ckNBcHp6K3dMWTduRVNFZVd1WUNUVk82R0lqa0FWOTRxQmE5TFFWbFE0dGxj?=
 =?utf-8?B?MTZ4enhzM1Erdnpvc1V1OVlIei9IVFhSZ1JzTkY1UmR1Z3l1czgycktIaGFx?=
 =?utf-8?B?bWJMQXpwOVV0bm8vSGlTZDJRekRiZ012dW5WeXVjQlh5LzNzaVppUy9CZzZZ?=
 =?utf-8?B?dzlLZUVRSGRoWllkMW1tMklwclVITE1DNEpZbUFxQWZFdHVXNFhpWFQyeFZ4?=
 =?utf-8?B?RlVWa29zZ3FFNi9IejZCVkZsSjVnbE1BTlh1NUorNG0vaHFuaDg1akVnb1B2?=
 =?utf-8?B?alpnNGk1Nkg0V08yRjFsU3ltMUlBU3FpbnVvNjJkRUl5S3NQaXZlZjlyd3V0?=
 =?utf-8?B?R1BhcklQTlBqalFoV1o3SCtYU0R1Z2U5ekQyRGZxSTRVcnhUd0ZQNDh5SlVS?=
 =?utf-8?B?My9OdGwvK2p1bkZuL3Q4dnFzNVBrS3NhOGhBNmNHVjZ3aFFwWThGV29yWCtN?=
 =?utf-8?B?by93RHFpb2JyTDk3NGY4TVpHeUY3TEt4U1l1cU9ySTk2ZU5lVDJTV2VMQ2pz?=
 =?utf-8?B?V3E0YVQ5QU9mdTJEcGdVZmVtN0plQmdPdUdaNlFqQTMzS2xpUnl2a0E0VTli?=
 =?utf-8?B?aXlHVG5rbStMdFNnTmMxOUxQR29sNmlrbFVmMmxaL1dGQnhxaXBWMEozNjdE?=
 =?utf-8?B?ZkZUNGxvZ0ZRc1g2dEluSnUrYTk1R0pHYUNralFkaXNPUUtlUWdGekFJRTNN?=
 =?utf-8?B?YWFNZUZOQklFY1h3QzBPNnpLWitob3hseU92WGJSS3lNeE9pYlVDVENsMU5p?=
 =?utf-8?B?TEFLTEMweEJUMkRMTWRvdFBQSG5LQTBxU3lWWXZzVmRoNE9QczBEUzBXUXY1?=
 =?utf-8?Q?k97pZcO1aLVL8Tp7Ljgm8Gt7yBRc4nDC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b3a636-0780-4e7e-a862-08da0728c2c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 08:41:27.2357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JNYb3hPf8dv1uXSEO5BslZcL6M7nm+bZFi6SgyZAVBvc50+kIi1iV996Bo89Yep4XFWdms89qMAVZg4QUgrgmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4044
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBNYXJjaCAxNSwgMjAyMiAxMDoyMiBQTQ0KPiANCj4gT24gVHVlLCBNYXIgMTUsIDIwMjIgYXQg
MTE6MTY6NDFBTSArMDAwMCwgUm9iaW4gTXVycGh5IHdyb3RlOg0KPiA+IE9uIDIwMjItMDMtMTUg
MDU6MDcsIEphY29iIFBhbiB3cm90ZToNCj4gPiA+IERNQSBtYXBwaW5nIEFQSSBpcyB0aGUgZGUg
ZmFjdG8gc3RhbmRhcmQgZm9yIGluLWtlcm5lbCBETUEuIEl0IG9wZXJhdGVzDQo+ID4gPiBvbiBh
IHBlciBkZXZpY2UvUklEIGJhc2lzIHdoaWNoIGlzIG5vdCBQQVNJRC1hd2FyZS4NCj4gPiA+DQo+
ID4gPiBTb21lIG1vZGVybiBkZXZpY2VzIHN1Y2ggYXMgSW50ZWwgRGF0YSBTdHJlYW1pbmcgQWNj
ZWxlcmF0b3IsIFBBU0lEIGlzDQo+ID4gPiByZXF1aXJlZCBmb3IgY2VydGFpbiB3b3JrIHN1Ym1p
c3Npb25zLiBUbyBhbGxvdyBzdWNoIGRldmljZXMgdXNlIERNQQ0KPiA+ID4gbWFwcGluZyBBUEks
IHdlIG5lZWQgdGhlIGZvbGxvd2luZyBmdW5jdGlvbmFsaXRpZXM6DQo+ID4gPiAxLiBQcm92aWRl
IGRldmljZSBhIHdheSB0byByZXRyaWV2ZSBhIFBBU0lEIGZvciB3b3JrIHN1Ym1pc3Npb24gd2l0
aGluDQo+ID4gPiB0aGUga2VybmVsDQo+ID4gPiAyLiBFbmFibGUgdGhlIGtlcm5lbCBQQVNJRCBv
biB0aGUgSU9NTVUgZm9yIHRoZSBkZXZpY2UNCj4gPiA+IDMuIEF0dGFjaCB0aGUga2VybmVsIFBB
U0lEIHRvIHRoZSBkZXZpY2UncyBkZWZhdWx0IERNQSBkb21haW4sIGxldCBpdA0KPiA+ID4gYmUg
SU9WQSBvciBwaHlzaWNhbCBhZGRyZXNzIGluIGNhc2Ugb2YgcGFzcy10aHJvdWdoLg0KPiA+ID4N
Cj4gPiA+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhIGRyaXZlciBmYWNpbmcgQVBJIHRoYXQgZW5h
YmxlcyBETUEgQVBJDQo+ID4gPiBQQVNJRCB1c2FnZS4gT25jZSBlbmFibGVkLCBkZXZpY2UgZHJp
dmVycyBjYW4gY29udGludWUgdG8gdXNlIERNQSBBUElzDQo+IGFzDQo+ID4gPiBpcy4gVGhlcmUg
aXMgbm8gZGlmZmVyZW5jZSBpbiBkbWFfaGFuZGxlIGJldHdlZW4gd2l0aG91dCBQQVNJRCBhbmQg
d2l0aA0KPiA+ID4gUEFTSUQuDQo+ID4NCj4gPiBTdXJlbHkgdGhlIG1haW4gcG9pbnQgb2YgUEFT
SURzIGlzIHRvIGJlIGFibGUgdG8gdXNlIG1vcmUgdGhhbiBvbmUNCj4gPiBvZiB0aGVtPw0KPiAN
Cj4gSU1ITywgbm90IGZvciB0aGUgRE1BIEFQSS4NCj4gDQo+IEkgY2FuJ3QgdGhpbmsgb2YgZ29v
ZCByZWFzb25zIHdoeSBhIHNpbmdsZSBpbi1rZXJuZWwgZGV2aWNlIHNob3VsZA0KPiByZXF1aXJl
IG1vcmUgdGhhbiBvbmUgaW9tbXVfZG9tYWluIGZvciB1c2UgYnkgdGhlIERNQSBBUEkuIEV2ZW4g
d2l0aA0KPiB0aGUgU0lPViBjYXNlcyB3ZSBoYXZlIGJlZW4gbG9va2luZyBhdCB3ZSBkb24ndCBy
ZWFsbHkgc2VlIGEgdXNlIGNhc2UNCj4gZm9yIG1vcmUgdGhhbiBvbmUgRE1BIEFQSSBpb21tdV9k
b21haW4gb24gYSBzaW5nbGUgcGh5c2ljYWwgZGV2aWNlLg0KDQpUaGlzIGlzIGNvcnJlY3QuDQoN
Cj4gRG8geW91IGtub3cgb2Ygc29tZXRoaW5nIG9uIHRoZSBob3Jpem9uPw0KPiANCj4gRnJvbSBt
eSB2aWV3IHRoZSBtYWluIHBvaW50IG9mIFBBU0lEcyBpcyB0byBhc3NpZ24gaW9tbXVfZG9tYWlu
cyB0aGF0DQo+IGFyZSBub3QgdXNlZCBieSB0aGUgRE1BIEFQSS4NCj4gDQo+IElNSE8gaXQgaXMg
YSBkZXZpY2UgbWlzLWRlc2lnbiBvZiBJRFhEIHRvIHJlcXVpcmUgYWxsIERNQSBiZSBQQVNJRA0K
PiB0YWdnZWQuIERldmljZXMgc2hvdWxkIGJlIGFibGUgdG8gZG8gRE1BIG9uIHRoZWlyIFJJRCB3
aGVuIHRoZSBQQ0kNCj4gZnVuY3Rpb24gaXMgY29udHJvbGxlZCBieSBhIGtlcm5lbCBkcml2ZXIu
IEkgc2VlIHRoaXMgZHJpdmVyIGZhY2luZw0KPiBBUEkgYXMgYWRkcmVzc2luZyBhIGRldmljZSBx
dWlyayBieSBhbGlhc2luZyB0aGUgRE1BIEFQSSBvZiB0aGUgUklEDQo+IGludG8gYSBQQVNJRCBh
bmQgdGhhdCBpcyByZWFsbHkgYWxsIGl0IGlzIGdvb2QgZm9yLg0KDQpPbmUgY2xhcmlmaWNhdGlv
biBhcyBJIGRvbid0IGFncmVlIGl0IGlzIGEgbWlzLWRlc2lnbi4NCg0KVGhlIElEWEQgZGV2aWNl
IGRvZXMgc3VwcG9ydCBSSUQtYmFzZWQgRE1BIGFzIHRoZSBiYXNlLiBQQVNJRC1iYXNlZA0KRE1B
IEFQSSBjb21lcyB0byBwbGF5IGluIHR3byBzY2VuYXJpb3M6DQoNCjEpIFdoZW4gdGhlIGtlcm5l
bCB3YW50cyBhIG1vcmUgc2NhbGFibGUgd2F5IG9mIHVzaW5nIElEWEQgZS5nLiBoYXZpbmcNCm11
bHRpcGxlIENQVXMgc2ltdWx0YW5lb3VzbHkgc3VibWl0dGluZyB3b3JrcyBpbiBhIGxvY2tsZXNz
IHdheSB0byBhIA0Kc2hhcmVkIHdvcmsgcXVldWUgdmlhIGEgbmV3IGluc3RydWN0aW9uIChFTlFD
TUQpIHdoaWNoIGNhcnJpZXMgUEFTSUQuDQpIYXZpbmcgUEFTSUQgaW4gdGhlIGluc3RydWN0aW9u
IGlzIHRvIGlkZW50aWZ5IG11bHRpcGxlIENQVSBhZGRyZXNzIHNwYWNlcyANCmF0dGFjaGVkIHRv
IHRoZSBzaGFyZWQgcXVldWUgKGFzIHJlcXVpcmVkIGJ5IHVzZXIgU1ZBKS4gRm9yIGtlcm5lbCB1
c2UgDQpvZiBJRFhEIChlLmcuIHBhZ2UgemVyb2luZykgaW4gdGhpcyBzZXJpZXMgYWxsIENQVXMg
YXJlIGFjY2Vzc2luZyB0aGUgc2FtZQ0KSU9WQSBzcGFjZSBhc3NvY2lhdGVkIHdpdGggRE1BIEFQ
SSB0aHVzIGp1c3QgcmVxdWlyZXMgb25lIFBBU0lEIGF0dGFjaGVkDQp0byBETUEgQVBJIHRvIHVz
ZSBFTlFDTUQgaW4gdGhpcyBvcHRpbWl6ZWQgbW9kZS4NCg0KMikgV2hlbiB0aGUgaG9zdCB3YW50
cyB0byBzaGFyZSBhIHdvcmtxdWV1ZSBiZXR3ZWVuIG11bHRpcGxlIFZNcy4NCkluIHRoYXQgY2Fz
ZSB0aGUgdmlydHVhbCBJRFhEIGRldmljZSBleHBvc2VkIHRvIGVhY2ggVk0gd2lsbCBvbmx5IHN1
cHBvcnQNCnRoZSBzaGFyZWQgd29ya3F1ZXVlIG1vZGUuIE9ubHkgaW4gdGhpcyBjYXNlIHRoZSBE
TUEgQVBJIGluIHRoZQ0KZ3Vlc3QgbXVzdCBiZSBhdHRhY2hlZCBieSBhIFBBU0lEIGFzIEVOUUNN
RCBpcyB0aGUgb25seSB3YXkgdG8gc3VibWl0DQp3b3Jrcy4NCg0KU28gaXQncyBqdXN0IGEgdHJp
Y2sgdG8gZW5hYmxlIGEgbW9yZSBzY2FsYWJsZSB1c2Ugb2YgdGhlIElEWEQgZGV2aWNlLiBPdGhl
cg0KdGhhbiB0aGF0IElEWEQgZG9lcyBzdXBwb3J0IG5vcm1hbCBSSUQtYmFzZWQgRE1BIEFQSSB3
aGVuIGl0cyB3b3JrDQpxdWV1ZXMgYXJlIGNvbmZpZ3VyZWQgaW4gZGVkaWNhdGVkIG1vZGUuIPCf
mIoNCg0KPiANCj4gSW4gYW55IGNhc2UgSSB0aGluayB3ZSBhcmUgYmV0dGVyIHRvIHdhaXQgZm9y
IGFuIGFjdHVhbCB1c2VyIGZvciBtdWx0aQ0KPiBETUEgQVBJIGlvbW11X2RvbWFpbnMgdG8gY29t
ZSBmb3J3YXJkIGJlZm9yZSB3ZSB0cnkgdG8gYnVpbGQgYW4gQVBJDQo+IGZvciBpdC4NCj4gDQo+
IEphc29uDQo=
