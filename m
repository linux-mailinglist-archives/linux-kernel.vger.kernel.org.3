Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CEB5244A0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348690AbiELFBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348062AbiELFBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:01:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DA06E8D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652331676; x=1683867676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9UmPzthUswKbZLlMLLZR9ev+K/RnGwFkuUVq8Nct4zk=;
  b=UPp5wultQ2vwSq+dI7j5QbWoeWU7Me+hBKGwnq0XLb9zlHQqL2uOYkPF
   mFFMVS8+UtdhRbsNHOcgACv1r4NXrYx51xoUgDF0g1LoD9QwjDT3SZRge
   gAfsK3AlCegvkdfHREIcs7DlxOaj+UccDcehy6VxldAREvPnmPRU66Nlp
   I9aLmJr8eSN4w1KvV0+Xipjrs2qn9eDF7yV0H9j+vCyoKdgavBGU3K0KT
   rTQp3Zx5LAokl1S4I5UNZUJx4A/hURW24Yl387NV4bj36xTUORvahHNMK
   a6cwknsRW9tAshH1Ord2vlBe7VcZt0Fkyd2DfxWxs7rZwR/Bz0z9EkAF7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="249785294"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="249785294"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 22:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="697874655"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga004.jf.intel.com with ESMTP; 11 May 2022 22:01:15 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 22:01:15 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 22:01:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 11 May 2022 22:01:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 11 May 2022 22:01:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fse2FDdTzZegNyJG/KE+ulp3L5JDVldx0iCyN1SntPxNVWWpXOAnBvvo3XMI+k1NSVIyPjQpcyArnAHgGHVeHt7vWhnMdoPkRqyrpKRwzeoxB53nvB7iNXjNrZZBedJJ6UWoEno/QWyTxxdW40vE/KrTmP2BvVklrPglvu4xbqh4gt0MsT7nhe/H+glz496mfN+l8f3qm6VzG+aQ4Elc4jFmEzT0u37S6Lgpb0zbgssrcG/j4EnjGQt7rGvyKkOGlCENrVhyoFdzk9lOQXMT+uzCo7nvarfa5XQjj2o4qNVGz16290CCUPOT/VpVdCSjSD7il6KIHmXV3LPyh7ExLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UmPzthUswKbZLlMLLZR9ev+K/RnGwFkuUVq8Nct4zk=;
 b=ZyZkY0GhN2p5n+cKVyypTGz6KJzWyulTdQ4n3A1z8fsXr5+fQyQbK3OhsCIG8xM0/6gZa3Wn3FYbJq1biOxQ/cS0UlP9D68jNnExu3vuyUr10owSjx7QI6DoxSLMm3pCC7pjqbCjYaMRfPlpmxInXNwnh+eNmcWhwcAo/CaTTBsKEAPN3+0bVKLFyQH2BsuwVNF7y7BPI6SXllIkCUXgBh2bX+pQqCD9EPpYP2KIo5y3xsdOjIIsoVLYHAY9VdEv6tn+le5tSGHr522UBJFoUZLQ1Y44WE/07b41+RnIdG7O4nNHOAq9dv2Sevwq94iMeIfbLCIqL7mRqMf4JEEbMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6034.namprd11.prod.outlook.com (2603:10b6:208:375::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 05:01:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 05:01:12 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Thread-Topic: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Thread-Index: AQHYZDYuY5mdau8gXkqO6XGUIK16Ua0YO2IAgAELqoCAAH48gIAAy8WAgAAf/TA=
Date:   Thu, 12 May 2022 05:01:12 +0000
Message-ID: <BN9PR11MB5276C03134A898CA9EFEE9258CCB9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
 <20220510152330.GG49344@nvidia.com>
 <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
 <20220511145319.GZ49344@nvidia.com>
 <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
In-Reply-To: <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7915fe28-29cf-4d68-4a20-08da33d46fc3
x-ms-traffictypediagnostic: MN0PR11MB6034:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN0PR11MB603496F3E6D06D0875D71C818CCB9@MN0PR11MB6034.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8KqPeFGIhT0mCmAzUbTG9UxT6mrgU0gkRj9J5gCibjewQ/v7sCv9JQT1GbasaDxUHE7KRaFh9M+hgjaUiAQkT0B853IpYVhX9rwFVk2RULJ4NAbF+AsT8YBTxf5hmMO0CjeRhvcz9vTi0HDAChV0elBC9rLk4qHMXyM2JlPbQXt96i/BpKfRVCbwp9FybusnXMsLL2PgJkR+Nt/goPcqTKsbT9CyXBWHVJILnyHZxYjNb9HGzBgShcSqdmesLjoLEOeQfEdcpCRkxIJ2OaS5czBfgEViMxGdJh9vM4HpaCSQf3CKr4BKcnaCMbEvdOuU6in9UrYVTalf/GDIAqH2hZYs89O/rVuWfnQnPIBHKZfK5mBTTZcTGk9ffJH4BJY8LxoKxw9HS0r2WVd4Hx5qSfPOO6eQ5oJDjrrZWRgtM5deCRhnNjpJV6Cnqc3I8rv6/+3Dc1EccPUhCp7d4dzuLfTCpLiv5eU3a86JXApUZdu3kAZYE2WGp6etVWpY81WAsWFW1GxaIALMWuOF8EO4n8l0A8o89p3Gp08D2vv4cm/8K17eKXTwnx5w/nQw0xitw4376bP9jGg7rpJDajLhI6DBch/86iimrHwnFZHtPhbuCkTOCHEuSKh7muxoWHPdB1RVu1XfeA7cPmUfaNKhduWVe8dl+2Hlin01XAphq1R8ZC2gVrFfKKmFPuwKuKog1ywV+mtzAKRr7pW/CCvg7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(7416002)(122000001)(7696005)(6506007)(9686003)(26005)(5660300002)(110136005)(54906003)(55016003)(186003)(71200400001)(8936002)(82960400001)(53546011)(316002)(4744005)(38100700002)(38070700005)(76116006)(33656002)(508600001)(64756008)(66946007)(66556008)(66446008)(66476007)(52536014)(4326008)(8676002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmVWTlFOZFRiRytUc0owbk9XV21jaTRtVnhNSkdNeWo0bFFkWWZNMXNlVjM1?=
 =?utf-8?B?V3I0dytITTJGdlZWMldGcUJqNllwSGFzT1JrRU5NS1VJSkd6Q3NIaDdhOHNY?=
 =?utf-8?B?dURlM1B1RnB6aGlhcjBoNGlMN3NWL0RERGFNRGJsY0hmd2tURk5UOXhtR1BT?=
 =?utf-8?B?bHhPdWtzWmxDWlZwYUVCY0pyejM5TXFhUmVnY1YzdGRqMnA3TXgwTTh3MGVO?=
 =?utf-8?B?S2krSEdzczE0V01WbTJRamhIRVE2K1F0VWVXelVEQVJ3ZlBkUWl2Z3JrcEtI?=
 =?utf-8?B?dmQ2VVNMUy8wemY1cklPSVo5ZGZNTUNqVXQva3FTOUZQeVBsMmcxZTduZXBr?=
 =?utf-8?B?SlRxQXVKOVVBWi93dDNwK2V3ZG1PVkZiUmc5b3c4U2tWZHdmTkdSNDFsdURN?=
 =?utf-8?B?NEJmUS85Y3V6d2czQ1ZBT0lmajZnajNIN0dmemVDeXozaTBqR0hpSXpBd2dv?=
 =?utf-8?B?a3p1ZHBiU0d3ZVFGNWg0NG1IV2kyVEEzb2k1Y056WkMzVUJobnA5Y1ZmWjJQ?=
 =?utf-8?B?YXFvbE1GeUhtaHlJZ3l5YXVsRzVJL0xCa0Z2a3ZrSDYyMlZwVENDRDZScEl0?=
 =?utf-8?B?MlNILzdUQ2g3dWJEdWo3RjlTM2xObEhQV2x4V2luOGNyeVFKZGhZR0VhSWNq?=
 =?utf-8?B?TzFMUlRmcjFPd1ZKK2RWd29BM3FDUG9BcjY1di8zUE5PUmFkK1Y4MmJEdHR0?=
 =?utf-8?B?Wmx3eURmL1VrWVRqM2hBQVBuamZ3dERCNHRHL2pBWUVrREZVZDNhQWIzcHoz?=
 =?utf-8?B?S0d6NFI5YWU4L0gybFJ2TThMMzlLS05Ba0ZSMndSZnFXRVVYVlpQei9nRkJO?=
 =?utf-8?B?VVhmWUJrWHdUajRGa3EvbXJNU1k3ZmlMMGQvOVQ5QzBwMVVkc05HVVRjOFBN?=
 =?utf-8?B?NXdxdWpBUTAyQXJ5ekdGYlYzYTFvMXZaaUFMNHFCZ2ZBTW9sTEVhNzRwcC80?=
 =?utf-8?B?RXVoV2VieU9ydnRpakRURnU5Y0hDTEJPbStmUTcvV0pOb1pDdVhMa3JRWjdz?=
 =?utf-8?B?c2svWTEwakVGbmc2bmI4bFlKYUdWYkd6UUJZL3M0NEVNN1VWMTZPYUF0Rk0w?=
 =?utf-8?B?bFU1S2RIUEl5N1RVN1FCRkRWZUxVY09QdFA2c1VKU1hkbmlDMVhJdG9NVmVB?=
 =?utf-8?B?QkcvaS9CZWFFcVVaeFdpQmxWb2ozMGNPRU50RmhnNGpwWnhVbHV6TGJ3bWtO?=
 =?utf-8?B?cDVjclluaFUvRHd5SVFTbkR4QUxWVk1sOURIZkF6NDhBK1JERVJJTnRmbStT?=
 =?utf-8?B?L3BSZUpoZHhjeU4xZmgwZEZ1V2Z1bzlvUFdlTjdiZ1BveDRMRlBYMGxPeHE0?=
 =?utf-8?B?dTd4bEpzVHFYbURhTnMwWi9mci9mbkNhaDVnSWJnd0o0dG5hbXhlWWtBMDFn?=
 =?utf-8?B?M2JoVTVMR1N0N1ZsR3duMXcvdU8vK1dNMzVXNnR2c0JWTjhvSFo1US9NNFNL?=
 =?utf-8?B?ODYrTkpzM0hyb0ZVeVRDU3NFOFN5ZE82ZEFGRlNEZkppc2FjQ2FhdzN0Y3Jy?=
 =?utf-8?B?RkFPODNjMWh4TFluRndWaGRhWlNiYW1QdWhSQldHUWdRdkdlRkFPMStGRmdB?=
 =?utf-8?B?UTlIS0F3WlM3WkRESzU5QU9aWmxuS2ZWY1FvelVMWlgyRHlNT2pmRlZYWlRK?=
 =?utf-8?B?VHZkUzY4RVR3Y3BtdjNjdUFBWjcxSTQvd2hVazhyQ0VXQzlTYTl3bEhXU04w?=
 =?utf-8?B?a3hyblA4Y0hyTW9Zd1dQblJyMkhkV0FVTXNhYVNRbGtQQWNicGQrK3JSVlh3?=
 =?utf-8?B?VXVESFZGZFAvSUttWUpnTTAzMTREYXNBcE05bEpldFJuVmU1Q05iOXIya3pB?=
 =?utf-8?B?cldoUm1mMkxNTFJhS2FBaTh0cTBiTUdsYmpLU3VDcW92UWxDaEJhNVM2dms5?=
 =?utf-8?B?NEhIV0h1cUtIZmNVZjZsdjZPQzR3dEltOVJZMTlBZ0NGTWN0Y3R4aUh0bHJD?=
 =?utf-8?B?ZTFGOVBKWUY1bzNLckV3L0NDWUs0bjZvNFhTL09rcGFBczg5cjhRaytWRThv?=
 =?utf-8?B?MjVDK1lERmFvVmpCMmc4SkJ2ekd3MThCa2FtbUNyaVhRTkIveWdXbEV3QVls?=
 =?utf-8?B?aEtKTW53QzBxQmcxQU5ERDc3MFp6dGorcVlsLzYyNlVEVEZYWHF1NTlSTVJa?=
 =?utf-8?B?Z1JuQ0RwSENTa0ZQZCsyUERvWjZrbzZFM1VyVlNkNXNQVG9sb2ptZGNHVE1W?=
 =?utf-8?B?VDd4dkJjeU5Jano1N25oczF5Ny82djNQMTcwVlBTQzBhNUJNWnUwVnhqT1FQ?=
 =?utf-8?B?ZzRWeG9OczRZUnF3eGJiT1NGd1VRVkNIcXgvb2NkUTRmSDlNaE5WY2tOTjMr?=
 =?utf-8?B?UUc2WUlqeUZTQW9QZXNNcWxoQitzWFVxUW8ybHIyUk1rMUxWVHFBZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7915fe28-29cf-4d68-4a20-08da33d46fc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 05:01:12.3907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ju834FY5TFeoD1D7N2LJzTRSiWNLmPQ85DNadJ8qBrelSnYKcz4A87Jo04dlnZKcIVEIuGQltqrgq7RQB0n24w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6034
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgTWF5IDEyLCAyMDIyIDExOjAzIEFNDQo+IA0KPiBPbiAyMDIyLzUvMTEgMjI6NTMsIEph
c29uIEd1bnRob3JwZSB3cm90ZToNCj4gPj4+IEFsc28sIGdpdmVuIHRoZSBjdXJyZW50IGFycmFu
Z2VtZW50IGl0IG1pZ2h0IG1ha2Ugc2Vuc2UgdG8gaGF2ZSBhDQo+ID4+PiBzdHJ1Y3QgaW9tbXVf
ZG9tYWluX3N2YSBnaXZlbiB0aGF0IG5vIGRyaXZlciBpcyB3cmFwcGVyaW5nIHRoaXMgaW4NCj4g
Pj4+IHNvbWV0aGluZyBlbHNlLg0KPiA+PiBGYWlyIGVub3VnaC4gSG93IGFib3V0IGJlbG93IHdy
YXBwZXI/DQo+ID4+DQo+ID4+ICtzdHJ1Y3QgaW9tbXVfc3ZhX2RvbWFpbiB7DQo+ID4+ICsgICAg
ICAgLyoNCj4gPj4gKyAgICAgICAgKiBDb21tb24gaW9tbXUgZG9tYWluIGhlYWRlciwqbXVzdCog
IGJlIHB1dCBhdCB0aGUgdG9wDQo+ID4+ICsgICAgICAgICogb2YgdGhlIHN0cnVjdHVyZS4NCj4g
Pj4gKyAgICAgICAgKi8NCj4gPj4gKyAgICAgICBzdHJ1Y3QgaW9tbXVfZG9tYWluIGRvbWFpbjsN
Cj4gPj4gKyAgICAgICBzdHJ1Y3QgbW1fc3RydWN0ICptbTsNCj4gPj4gKyAgICAgICBzdHJ1Y3Qg
aW9tbXVfc3ZhIGJvbmQ7DQo+ID4+ICt9DQo+ID4+DQo+ID4+IFRoZSByZWZjb3VudCBpcyB3cmFw
cGVkIGluIGJvbmQuDQo+ID4gSSdtIHN0aWxsIG5vdCBzdXJlIHRoYXQgYm9uZCBpcyBuZWNlc3Nh
cnkNCj4gDQo+ICJib25kIiBpcyB0aGUgc3ZhIGhhbmRsZSB0aGF0IHRoZSBkZXZpY2UgZHJpdmVy
cyBnZXQgdGhyb3VnaCBjYWxsaW5nDQo+IGlvbW11X3N2YV9iaW5kKCkuDQo+IA0KDQonYm9uZCcg
d2FzIHJlcXVpcmVkIGJlZm9yZSBiZWNhdXNlIHdlIGRpZG4ndCBoYXZlIGEgZG9tYWluIHRvIHdy
YXANCnRoZSBwYWdlIHRhYmxlIGF0IHRoYXQgdGltZS4NCg0KTm93IHdlIGhhdmUgYSBkb21haW4g
YW5kIGl0IGlzIDE6MSBhc3NvY2lhdGVkIHRvIGJvbmQuIFByb2JhYmx5DQptYWtlIHNlbnNlIG5v
dyBieSBqdXN0IHJldHVybmluZyB0aGUgZG9tYWluIGFzIHRoZSBzdmEgaGFuZGxlDQppbnN0ZWFk
Pw0K
