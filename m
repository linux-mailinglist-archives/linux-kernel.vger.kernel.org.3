Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D874FEB25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiDLXpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiDLXp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:45:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EC82600
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649806335; x=1681342335;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=maHAIuNa2hxus6GAsaYzYDgj1HxvQjaza6a6BCRrmXU=;
  b=XUl0VHo9ALTnhObTzw1q4PCHvWXkytO/F6Bg5K0vRxDKKBsG9QY84M6v
   KRenL3p+6jwbolLDErmfK90n540E77XbhKu2u4CPyOr0b+YWX7r9i95+u
   D/dAIVQVd09vtZwVtynOUHAxc7EDq03BCOBBS21tVPLI+85ayFLF1fe3l
   Q/nwEzK2LdW4M64+nX0kN9kHoMvFZ8UP0ZZ1zjt/3nepzkFPwkHcFeE88
   y5fB39iZXYWtNH8TJR0XU+w9CODSUZaOykCsVMXDof3e6z4t7BoxsmskJ
   06t5/1uXUTJ0dEH9jxyQKVl46TNCFaK8wKcGIZEhRi1ppGmbACuCMD86J
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="287553423"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="287553423"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 16:32:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="660706494"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 12 Apr 2022 16:32:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Apr 2022 16:32:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 12 Apr 2022 16:32:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 12 Apr 2022 16:32:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxRF+cFfiUWOjp54w+rZ8c4edtl0azOU6Ls8VPpwqc15apwp9Fdw3ZzJBOtozskQklUXBqreouecIErjoAZETMvStkF6n3fwFN/U5BTx/o7VvzqivPcqgMUeZAwrEjeO5L9IxuS7bGzLn0alrNBpa/+HhBuqIAoppq0+ljYc/6Wok05lucU1f25w+60ez8baqNBo95yv12/q/p4nq0jPz4qADdUf68APS/H5hcqVXctqdJSDRIF9N0uEgTWOU1+S+ZegiyBjf7Yx3ij/+L8Ol+z5FPbKSCpE/lq6NLrA2m0PmjZyoT+xVBpu6CemlW98CqGIrUQc7fke2X4HEnpuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maHAIuNa2hxus6GAsaYzYDgj1HxvQjaza6a6BCRrmXU=;
 b=VAclUnO4dkcDDpcfkvBmO/y/bS53YEM8Lv2oQU7QD80TdKWncoMVif2HzQ36gdZYK9moLpX/PYLa4iBnS10GpTyEIwrZVAYevHOD8hLdVV6y4hdhjDR2tIXr0aO5/TJeA2cA/2Pmg7E5QTnpVxaxyhUffiyK1FUnKUVYcrq2FecyL8hLpQ0qrfnf/G7lkSZAUKz5n5/nxU70eA5q1xvZm0ufRScbMm0X88zKBqSShfk7FAzwHH6uCPqDyDw5dFKwhIJ82zFG+HoBH4aWTVCI+TfGPf2ZfpLC8okEYniz91Nzimx8SaXnQMD2HwgzmpLu5uNJyyO1uZ4wCtcHDT7fAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5482.namprd11.prod.outlook.com (2603:10b6:408:103::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 23:32:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%8]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 23:32:13 +0000
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
Thread-Index: AQHYTMWQdMRj1LtW7ESP7xJUKRpqwqzrmnCQgAAi0gCAACVF0IAAXxIAgACvRyA=
Date:   Tue, 12 Apr 2022 23:32:12 +0000
Message-ID: <BN9PR11MB52762F5C339737F6E75755CB8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527679E5CE0516B2786F57518CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7c70a136-6871-b48c-8e46-852bb1b62958@linux.intel.com>
 <BN9PR11MB5276246A53447854DDA8920D8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6e9bac88-e544-aebe-81ec-d1171239fec3@linux.intel.com>
In-Reply-To: <6e9bac88-e544-aebe-81ec-d1171239fec3@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16db2bbc-b431-408a-90c5-08da1cdcabff
x-ms-traffictypediagnostic: BN9PR11MB5482:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN9PR11MB54824FAD05D35EA7919EAEC08CED9@BN9PR11MB5482.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WZcOLpafCXvEjXSEqZNuaTrB6sjp1VfsZa1q9C5EdOBV+nz6s2GWZV6ncQ7qS5lkdeBEu7XFNioXQG9lfdFBDAqfZ1uNUXn1uUl1A2Zjb/Zr8YVQciaeScXod/SW0lyBsvX1WxhOWqQndjL5d0uPIO31JU0MjwC1Fkhn8hgeN4YIIaanSCag3eM6Hr9IUsWQwk5vXx0XuGVNuWXtGR+vOf1kbsJ1TFRPVcXwatflWJJsYM7oRxi9OT2C+o+in/OkEjfBMS/ZO3N/MEq4Tv8Iy3t8Iejl8uxzxJqYciHhQR3UFH7ZL7tIvab6MYNeIzYL8gCY5hksnhNS2GsjNiLoaAIJOwPdufwECEgtinanqBWIJMJ4EN2IAVukrBk8nHBsPvCiBQoTCIa3apldEBcofHEHptmGbLJ3ufwTlRbRuIBgpb/FcANYdje8K2jMj7ifa3eN/fGHBMxo1HHpa/b3guyJekHuh4o3pUl1zZWO0DuJpg8MzvT6k+OdYjv6+5/td6Tpfl/RXBK2P/TKaGL98zU9qEk39yjQdiZ5c353mZSJz13hVuo8uMPzpKmRVa84/vcvzHXR6JcoU+DwnYFW/Hp05ghVuY8XjN+zg4zBNyYky9SYe7JEGYYcXLdVdLLADkvpCxASfawogGZnPXnU7eyo0jfNrkM+XFK6zLCal7XLavAW7PXTcr+dgx7AIE2DFt9XxSLGccTsy4+awFzshA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(55016003)(64756008)(8676002)(66476007)(66446008)(76116006)(66946007)(66556008)(33656002)(186003)(9686003)(53546011)(7696005)(8936002)(508600001)(2906002)(122000001)(82960400001)(86362001)(5660300002)(110136005)(6506007)(316002)(38100700002)(38070700005)(26005)(7416002)(54906003)(52536014)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U29HOGY0NkRFL0pLY1o5YmxmdlhLQ0pNSW4vdjN3eDg5Tmthdm9GMjRudVFY?=
 =?utf-8?B?dzRJZUJ0NXhZZERjTGpVQW5rTWxyWFRsdklGSkRkK21lY1pyREJIK2ZnejJ2?=
 =?utf-8?B?TWUzUWpwR1dRUjVKU2Njd3JuYm1zZlZRaXpiZk53VHNBVUxwNDR0dzN2ODNY?=
 =?utf-8?B?S2tUc1E0ckYvemFneWEzcEI1YTQ5UWMxblY0TElqQStQUzlhSzlhWktyYjJp?=
 =?utf-8?B?UDM4V3ZsRklleE9ROVNUSTNFOERmS3U1L0JkdGkxODZVQXFRT0s5VWRwM2Fw?=
 =?utf-8?B?aWR0UURTN1c5MTJvRFkzcDB2RmdPMlNTVU1CM1Z3NnVKeE5SK2tnRmxRS3R4?=
 =?utf-8?B?VUw0bEZkcE40cXgvOHBiclp1dStXVVVWS1lON0dFdmlJM0VieDNST1owTmxV?=
 =?utf-8?B?ZWZUbmt5b3QxNzRHVkIrTFhwbkl3bHA0VFplTDROT2VneGRFeDFUMjVhaE5U?=
 =?utf-8?B?d0JHd09lMXlhenJGYTdzSHlVOFpzQ2lSUWQ0Ujh6MTRtSDJYOThwRXlsTUZp?=
 =?utf-8?B?N0NKbU9xMStXWkw4MXRMZG1FNVlkZTBBQnF0UC9Zd1VCTkxaNmkrQTV3U0tR?=
 =?utf-8?B?Mi9tRm1QRFBXWk9qaUF5a2FrelhvZ3RNczQwLzZGZXdJM01OMncrWlJ2ZDF5?=
 =?utf-8?B?RlcvdElTOVFNdERpb3RUMjBSUVNSZmdoYkJLbDMxQW9LbHFtdy85UGJZVVJB?=
 =?utf-8?B?NVg4UGVweUdld3ZubGFEUnZpY3RLRTFDaUhnTU12dVV2YktGNEdOWlU1M2JM?=
 =?utf-8?B?Sjl3THNtV3llam1mS2J2eWdGWEYrakl6MFB0UzNXSkxrNnJhZHl3N05wOE96?=
 =?utf-8?B?MVdmeXRyaUZzZVZXZmQ5L1FMSndYd1RVY3E1VFllZU05VDcvSEdkR2xjenlJ?=
 =?utf-8?B?TlVPVE56UnJHOXZPT0FVdDQ1aW9BaEowZCsrY2huT1VEK1lRSWRvSVcvZWND?=
 =?utf-8?B?cUZyWmlXYlhVdmp4WVhieTBDOXRGWlQyWUhqa3RNcWlTR3pTUVVUK3E0SUdP?=
 =?utf-8?B?Qlh5Q1ZQN1V3amtGanFwcjVsalJPWWNBNEVJdGRBclNCK01sRzJ5TlpQOXNX?=
 =?utf-8?B?dE9CSGZNT0RpdzEzb2tWaUdkd0FDa09MVlZIYyttWlE1T05iRGQ2UzNIOWhL?=
 =?utf-8?B?cUhWUUFJc3BjV1ZYRElhT01HSTd5WGZGaFZaTTRlVlMxdk5teXlhdTV3VVlX?=
 =?utf-8?B?aE5ld2VRT09BcHl5bml3SEZ4KzE5ZjBodEd6N3ZTTWtEOUIxZ0ZweS9Ca0FB?=
 =?utf-8?B?Y1FscXdGdjRDMTYwbTlyYlF4RlRIdHNjd3FhZ0FSRHBzNFdYSkNVcG9jK1hX?=
 =?utf-8?B?eVhNQ2wvcFd2MTZuTUptVTNDaGpKRU9zNG13TStUdUwzRlFWZFNtYlE2OXJP?=
 =?utf-8?B?dEdKNko1ZGh2MkRrZW1XSmtTdU5FU1ZGWEo2QVgrTU5SZ1FWS3RoK0wvVE1L?=
 =?utf-8?B?ell5U21OQ0FMbHBsRHFFWVVoQmc2R2t6R1J1ay93UHowaEZFMDQ1UE5LWGJL?=
 =?utf-8?B?M1YzWU9jVFVjSmpMaHhUNlBPb0NGRTBVVFZVK0Z2WWRLRGxSRXcrd09sLzR3?=
 =?utf-8?B?TkxPRHUva2wwcXdVK1V4ZG1qVWVGazFycXBDekdWaVZFNkh4YzRNZ0N5Nkcz?=
 =?utf-8?B?QWcvRnFoK0h0bVZDemhOQkJrRXB0RXJwcWVkamhKWDYyMFdEeUlHdkg0Qndj?=
 =?utf-8?B?aWRxV0g1K3BZbzJBNmVZQnZqMHJrald1c1E1NUZTc3djK3RFMnlCNUdRT24y?=
 =?utf-8?B?andyYStLTXZKSlB1b1h6NEhFUVdaWEczMG4vTytLcjZER3J0VVRwM2xLdkE1?=
 =?utf-8?B?NVRqU0doeE5nQ0o0cDQrOXhtU05pYkxHNFptWEx1WFlUVzA5LzAzYmtBOWRF?=
 =?utf-8?B?RUJ2ZGEyMTJJU2lLTFcxcTQ4bG5aSWJha2ROeE5TMW5TSVp5ampYOTdRbjBF?=
 =?utf-8?B?TjRMRkRVdThBY1JUdVM5akxoa1pTdUpCMWp4NlV4SHpydjZKU2pNb1JOcnBX?=
 =?utf-8?B?TUJLclIvemRZaUZuK2doMm43dlZxQldFK25jcm94RVZ4UjdNZTk3MVFlY0I5?=
 =?utf-8?B?WnlJdGZOMXcybm9pMHp3cVFDZ2dTYTVYZHF1aWVYTXF6UjduK2hLbjZOQVlM?=
 =?utf-8?B?ak9na0JVelQxUVlwZFRsc2srTU1IUWp1VXhDT3pSZmJqeUpuemdQT3l4Nmgw?=
 =?utf-8?B?TFc2Vm5BTTlNY0lMcWwzYkpka0pjQWFiQ0tmVHF2MXZBZGFOMmJNRitRV2Jy?=
 =?utf-8?B?QnpVSlJHYlBMcTBGdGc1UWplU2RtOFUvTXdnaG04NmhuV3c2a2ppeVFRd0dE?=
 =?utf-8?B?SlhieWs1VXNVazkvTWUxdkxxRVYvTHhyMjh5YW45QWdTODhoNi9LUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16db2bbc-b431-408a-90c5-08da1cdcabff
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 23:32:12.9132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZ4ZTvxnGnd6yVTf0KaC4Wbk6NzeSSkhOMqYnAMPcGfVJq6U8VHOskXfXb8doLckuu6NUNJi4u+zNRDNQ9/ujA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5482
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBBcHJpbCAxMiwgMjAyMiA5OjAzIFBNDQo+IA0KPiBPbiAyMDIyLzQvMTIgMTU6MzcsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50
ZWwuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBBcHJpbCAxMiwgMjAyMiAxOjA5IFBNDQo+ID4+
IE9uIDIwMjIvNC8xMiAxMToxNSwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+Pj4gRnJvbTogTHUg
QmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gPj4+PiBTZW50OiBTdW5kYXksIEFw
cmlsIDEwLCAyMDIyIDY6MjUgUE0NCj4gPj4+DQo+ID4+Pj4NCj4gPj4+PiBUaGlzIGFkZHMgYSBm
bGFnIGluIHRoZSBpb21tdV9ncm91cCBzdHJ1Y3QgdG8gaW5kaWNhdGUgYW4gaW1tdXRhYmxlDQo+
ID4+Pj4gc2luZ2xldG9uIGdyb3VwLCBhbmQgdXNlcyBzdGFuZGFyZCBQQ0kgYnVzIHRvcG9sb2d5
LCBpc29sYXRpb24gZmVhdHVyZXMsDQo+ID4+Pj4gYW5kIERNQSBhbGlhcyBxdWlya3MgdG8gc2V0
IHRoZSBmbGFnLiBJZiB0aGUgZGV2aWNlIGNhbWUgZnJvbSBEVCwNCj4gYXNzdW1lDQo+ID4+Pj4g
aXQgaXMgc3RhdGljIGFuZCB0aGVuIHRoZSBzaW5nbGV0b24gYXR0cmlidXRlIGNhbiBrbm93IGZy
b20gdGhlIGRldmljZQ0KPiA+Pj4+IGNvdW50IGluIHRoZSBncm91cC4NCj4gPj4+DQo+ID4+PiB3
aGVyZSBkb2VzIHRoZSBhc3N1bXB0aW9uIGNvbWUgZnJvbT8NCj4gPj4NCj4gPj4gSG90cGx1ZyBp
cyB0aGUgb25seSBmYWN0b3IgdGhhdCBjYW4gZHluYW1pY2FsbHkgYWZmZWN0IHRoZQ0KPiA+PiBj
aGFyYWN0ZXJpc3RpY3Mgb2YgSU9NTVUgZ3JvdXAgc2luZ2xldG9uIGFzIGZhciBhcyBJIGNhbiBz
ZWUuIElmIGENCj4gPj4gZGV2aWNlIG5vZGUgd2FzIGNyZWF0ZWQgZnJvbSB0aGUgRFQsIGl0IGNv
dWxkIGJlIHRyZWF0ZWQgYXMgc3RhdGljLA0KPiA+PiBoZW5jZSB3ZSBjYW4ganVkZ2UgdGhlIHNp
bmdsZXRvbiBpbiBpb21tdSBwcm9iZSBwaGFzZSBkdXJpbmcgYm9vdC4NCj4gPg0KPiA+IEkgZGlk
bid0IGdldCB0aGlzLiBMZXQncyBsb29rIGF0IHlvdXIgY29kZSBpbiBpb21tdV9ncm91cF9hZGRf
ZGV2aWNlKCk6DQo+ID4NCj4gPiAgICsJZWxzZSBpZiAoaXNfb2Zfbm9kZShkZXZfZndub2RlKGRl
dikpKQ0KPiA+ICAgKwkJZ3JvdXAtPmltbXV0YWJsZV9zaW5nbGV0b24gPQ0KPiA+ICAgKwkJCQko
aW9tbXVfZ3JvdXBfZGV2aWNlX2NvdW50KGdyb3VwKSA9PSAxKTsNCj4gPg0KPiA+IEV2ZW4gaWYg
dGhlcmUgaXMgYSBtdWx0aS1kZXZpY2VzIGdyb3VwIGFib3ZlIGxvZ2ljIHdpbGwgc2V0IHRoZSBm
bGFnIHdoZW4NCj4gPiB0aGUgZmlyc3QgZGV2aWNlIGluIHRoZSBncm91cCBpcyBhZGRlZCBzaW5j
ZSBhdCB0aGF0IHRpbWUgdGhlcmUgaXMgb25seQ0KPiA+IG9uZSBkZXZpY2UgaW4gdGhlIGdyb3Vw
LiBXZSBuZWVkIG90aGVyIGNvbmNyZXRlIGluZm9ybWF0aW9uICB0byB0ZWxsDQo+ID4gaXQgc2lt
aWxhciB0byBob3cgeW91IHdhbGsgUENJIGhpZXJhcmNoeSB0byBmaW5kIG91dCB0aGUgZmFjdC4u
Lg0KPiANCj4gVGhpcyBpcyBhIHNtYWxsIHRyaWNrIHRvIG1ha2UgdGhpbmdzIHNpbXBsZXIuIE9u
Y2UgbW9yZSBkZXZpY2VzIGFyZQ0KPiBhZGRlZCB0byB0aGUgZ3JvdXAsIHRoZSBmbGFnIHdpbGwg
YmUgZmxpcHBlZC4gQWxsIGlvbW11X2dyb3VwJ3Mgc2hvdWxkDQo+IGJlIHNldHRsZWQgZG93biBi
ZWZvcmUgYW55IGRyaXZlcnMgc3RhcnQgdG8gY29uc3VtZSB0aGlzIGZsYWcuDQo+IA0KDQpBcyBh
biBpbW11dGFibGUgZmxhZyBpdCBjYW5ub3QgYmUgZmxpcHBlZC4gV2hhdCBhYm91dCBTVkEgaGFz
IGJlZW4NCmVuYWJsZWQgb24gdGhlIDFzdCBkZXZpY2UgYmVmb3JlIHRoZSAybmQgb25lIGlzIGFk
ZGVkIHRvIHRoZSBncm91cD8NCg==
