Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856E05AD941
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 20:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiIESvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 14:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiIESuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 14:50:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D555FAE8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 11:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662403851; x=1693939851;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fgz2TOsyH0i5Lh/2aeYgDDT0lwFufGC2PBHD7mlFPdo=;
  b=LMG1IAsOh//Mc2qxztHLuuxyLTjW/j79jRQmo7ppnjK6cMQBL9z9jYL3
   cdLSFE640Jc/+biWKuapLBUcPYHh0wT4kFaaudIt0/NB8+ROMrWZhumfp
   k0anWFpYRcEQuXaaUxoo5+Z00V0pC41chVQPsfGBOfe5YlwaJ5KxCzF/n
   tdtRm9P1Vop26vcpBneFSuf86gSwWsTHzqwYs5+xaZELCtqfBU2sTmlZf
   lrfgRU6ZYkBzeTIkIhX0o/hqReJ+oCVEPA0c8A30Wpt1FhI56RlyGdv8s
   Y/k8AcIHDym9vxVmXT0jwaE3bYtaEHkwK2vSBfWOXfJnonoS3yR+xkFde
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="358155428"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="358155428"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 11:50:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="564847385"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 05 Sep 2022 11:50:51 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 11:50:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 5 Sep 2022 11:50:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 5 Sep 2022 11:50:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGV5/825Tol6DqVsUVcMfPQ1Sox37pQQy6BJHRgjL9bJuWFrDKv/Ne0S27Tpy54DN3Xan1NUz/NEkv7JgwCWVfi3Vx1MZ5kK0FXBFJLEhaKcCJFYqYJlPsD/JP5E4P0rnmmjBn+dwSqs5ZUi+Du9zcQ8lHjDvgikfpz+aRddx/Kyx25eVcDzV6/BAvyJVAVszEJL1zHElWMBpiwa192nSVTx+7PVA49S9+jTfsT5TMpLsNkBtOA0uPFxhLKqw7wu9uXzyRg/zZJYzgQX9qcc2FfIMM06jW0q4nFHaveI3WSDBlxRfwI45RPLtGMuJBNzY8CxckAv1XJbB1BJYspX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgz2TOsyH0i5Lh/2aeYgDDT0lwFufGC2PBHD7mlFPdo=;
 b=EHlIVTiuVq5Ba8Qs88YKzkopJTt8fs5MrmU20VZ1SFBzc1hJdo6jy/+qBGsZTK1SXrN9V7hQ2Ae6eSTIftZXDhdqA5u+HKfEwCIZHLhs22HWnsr9L+0uPGmLHtwkhXYU94WCRpWj9qC5gAgLzyp8aYSZAenITQnXG+5x9jQDd53MBtdgi7AQUk8yEv2edqvy2PvFA0q33T/hi2S+lP4HZGJeELHGOuJkP3tx/KcHYXpGYzTZyP+q06La2DXUvOlAjU0q4y3XlCs4amQ56vWtpJfoY4x4TwKOucQVDpjoVBgg/DOf4SfUucLHvVVTvmdwCR2Is8xOOKZEW2evEJLJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BN6PR11MB1761.namprd11.prod.outlook.com (2603:10b6:404:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 18:50:49 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::48b7:53bf:e2d3:b61]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::48b7:53bf:e2d3:b61%5]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 18:50:49 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Huang, Shaoqin" <shaoqin.huang@intel.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: Check writable zero page in page table check
Thread-Topic: [PATCH] mm: Check writable zero page in page table check
Thread-Index: AQHYvyQZLcFou4NI1EGJsJ/5FmITGK3M9yUAgAQ7ZQA=
Date:   Mon, 5 Sep 2022 18:50:48 +0000
Message-ID: <467b0cdb4f876b87b50d1cd7229a8e6e02a19a41.camel@intel.com>
References: <20220902232732.12358-1-rick.p.edgecombe@intel.com>
         <3d82deb6-357d-0b54-ffd1-dce157674aad@intel.com>
In-Reply-To: <3d82deb6-357d-0b54-ffd1-dce157674aad@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89e62554-7ff7-4ea9-5255-08da8f6f8c95
x-ms-traffictypediagnostic: BN6PR11MB1761:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R3nifsHpL+Q13FWply/FONdJ08V/VbPb3WiPpV7rZ3ebOzAgwvbk12STlk4Rdo5ihx6BoLmWOfhl1GllViFlnWum3vnwwMnJejsIAY30gHZtF4Bo6/+lAGxprkP4MEAgm7jcGnzzIufz4n5mGR1lvyxucanpFRCv6ycZoGgVcYlBmHEKkZJSu02xz8TkOwU6qXrGHAeFQwCMweaQWPBShMu4ySakve1m1voAAoCk2GIf/N7LHnjhoFuHt0QNfpiwGylxUrMgw+U0aAOJnSFFR8lHahajPYrfXpt69FHtPY05rQlsvos++CedRhHzfVk6PUn/IxLqr72zlwOtVdQ/G2fvfcLuR0kdkfwx8v/kWQiJv0sEWkw+Sfah68gO+WsfCDF7Poc6S8Mjufni6cF7Po9NIRFedIiUZ9WdcqwIHv3/KSP0ri30bIJhSL3ZjIvE8P9A0oDZjqoVDVVl7+2a4QBHySi/X8DC0Y0ec7APCrsvJBtH4Pey0Zp+wclPfn6MAlHn7NQhlaS1kpLyDg1w1cmXSQqmTJVEqJPZK8NKlOCRRe0zyGsetje9m/cK9FOHcN2AQPhNNLG4VCLGmY5CCxU08XGxUi6HBAtkd8wUzKekRPAf7E+uK3kmJ5CsNMYA60DHOvbp/plholltar+d28jdOglTRMXosWvq23aQCy3hs9HZ/GFFAJSSMFWtfSCjkl3ddCum2ZB0ZuJDEwHhQPqhSOt1t1Pf7gSTCOyj0VBh70XWB4DmbMauvU4oEXf/I+f8XLccku646+6bcGv2le67R39uM3t7TWHqN0iFIREBjbxVaF/kEy4LAJmbq0k/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(39860400002)(136003)(366004)(26005)(6512007)(2616005)(5660300002)(2906002)(8936002)(4744005)(6506007)(41300700001)(36756003)(86362001)(71200400001)(186003)(966005)(6486002)(478600001)(38070700005)(82960400001)(66446008)(8676002)(91956017)(66556008)(66946007)(76116006)(66476007)(316002)(110136005)(64756008)(38100700002)(4326008)(122000001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDNrUXN3a2ZqNkdNUTRpdmFTTTZUQjlXWnUyYzBnbE5FT01tSlhNR3YrK2VS?=
 =?utf-8?B?NVJnZXl1ajV4ZWYxZVE0NmlHc0txeEo0UktiNTUvckt4VTVwR01lcXpUNjRP?=
 =?utf-8?B?R1NsMjY0OTF6a2RiUWtoWE1pTUJ1YzBuV2VDNEkvSVhhSGZJdFFwYUlibnBM?=
 =?utf-8?B?TS9KRVNRVkxFOVczbFV3TUs2YUhlNndCU3k0Nlp1Y2RKSzZBbnVnQVhvV29S?=
 =?utf-8?B?cW9TQXBTeTRyTDByTy9PNTBXY3lmTWVpS2U1cS96NnFjVGlEdm1HWXRuNWZU?=
 =?utf-8?B?MWxpaW82K05SZjl3Nlk5M0cwSm1ncGE4aDRMcUlLUmp0UUZOdVFuTHdoNUs0?=
 =?utf-8?B?amh4b2hGYVZDUzQ0RGdzYlhHOVpNejNFY1VNU1R3MzJ6RWdZNCtZZU1MNmFa?=
 =?utf-8?B?dmdJMEdIZUFMeU1Na2JwTDlOd2RIbFZWdXJCRU5ld2o0Qm8xeC83M0FPN083?=
 =?utf-8?B?M2Y1RS9tRllNL1R1c3ZsRXNNTzVLWUVOeWlOUFU2dExLc0NSREpzWUV4REc3?=
 =?utf-8?B?RVBqUXFsUVJNWUwxeTRoVHZlYlpyOFpBQXBDdmh1KzVQVEI4ei9NcWdyZ0tG?=
 =?utf-8?B?ZlhTYkZGblBCSHlrZUFoeTVzUDN0cTFLTjVVV0JUYzhXelFLWExDUVlIZGg1?=
 =?utf-8?B?cTB2SUdXNXF3MWZrYzQ0QXBZc1J6WjVwQ3Q0NTd0TTVPVzRNUEdkSW8wOFhG?=
 =?utf-8?B?NVV1YzR4M2RDWklsRVdoLzZZN2F5VlhoZzI2Y1NmU0Z4djJMVWtaL1l1c3VK?=
 =?utf-8?B?V3BKdHpGUnlWWmdHZC9oNWZkNnJhbkdKb09MbTYzamcybkliQWxUQ0RMa3Qz?=
 =?utf-8?B?Y29mdGF3S2daQ29TdU1WbDkycnR5TTI2Qm0xQ0JJNWxQcVZocUtvNURBMHFJ?=
 =?utf-8?B?enNheVA1RmFucGtWOXJQNm1nMGdqRUg0eTRDVmRYRG03ZWhXS2k5eXFzcTky?=
 =?utf-8?B?MzFSRi9UR2c0eXJ1a00vSm81YlRpQnVDMWVHQ2lCOHI3aDl4OWhoZmx2cjBn?=
 =?utf-8?B?OG1YK0hyTGpXNThUMkRvTlJLVkpmdDN1ZTdLY0ZwL3Zabmx5b1JHZHJST0M0?=
 =?utf-8?B?SjQwSnB1UE1EdG9GY1hROWc1TWI4anhRSDZyTnpyaEg5MTJIQTBvK1BYOXZx?=
 =?utf-8?B?aExJbWhRRkYrMXc0ZjRkTWN1SkV1VXNnYzdyZGEzK2RmQVFGNS9MV2xBbWpn?=
 =?utf-8?B?YW5pL1BheXZKbVBrc20wVnlqS29KZ2tsbk5sQnNYQ0krZzJEUW1QT25iZ2Vn?=
 =?utf-8?B?OGV1Vm5TSWUvalRsL2ZVZmRyY1kxRHFtUExZblRkaFZZY0dGOHRaOTh6RkRl?=
 =?utf-8?B?WGRxMEd4OFBEQ3lGRHJEaWpZcU81SGc3eDVKdmZhd2N2akl0MmJoL3dkd1Q3?=
 =?utf-8?B?U0VVV2hQMlRyQlVYWTBQLy9iNktmbjZNWVFjVXVvTXBJazVQZUF5dk9KZVdX?=
 =?utf-8?B?ZURpQW0xbkI3R0liNlRGaXlkU1kxVGVEdS82OHZvY1JCa3dyRkd0T09Wd2Qv?=
 =?utf-8?B?azBzd05RR3VvWWxISWFLdW9NWjUvU0E0eXo1WEtuemcwUEhiekJhSks2Sk10?=
 =?utf-8?B?SFh4TXl1REM0VThrb3lzUW9DMHVDK3U1eUtlSnZQL1NxNE1uY2hwMnFZTHF4?=
 =?utf-8?B?ZEI1c2o5VTFPYTByZTJkQ0RRQUQ2c25DaFFmNWUyWGtIR3k2ZDdQNXB2TTN0?=
 =?utf-8?B?QnlQWHlBSjJJRDNRa1NibjNaZ3h0T0FxajlZRU52OFg3RzIxdmRJK3d2ZGg4?=
 =?utf-8?B?UFI0UEZBZllsYlM4YUxrYjIrWWd0QTRSdXkraUp6RmpIcU1FN05nOEJSSXFB?=
 =?utf-8?B?dXNycGV2WUV4TjE2UDlrN082MmtkeXJCTU5RbnNlRzhJTmgyVWdnSmNQVFFN?=
 =?utf-8?B?eCtpbDcyYmtSazNLWWU2dG1DYmhPME5YTlgrOHYrQWczeCtzcENvRFlRQVk1?=
 =?utf-8?B?MVUzd25GSHJCT0E0UkpaZGFDWmhSQzNGbmJVRHFCNzlXTVJMT3JTTU1pSlFN?=
 =?utf-8?B?OEJ0eVprTVlHNTVNaERRUVl4SWpTNlZVa2VTcXFuc2kxa0dsUVBKWEdoMW9G?=
 =?utf-8?B?T29YOW96TWU0cWswZjk0aTB1MHgvV3YyRjczT3lEUW1xV3U4VlpoejlGSDFm?=
 =?utf-8?B?MHNkSzNOc25oSkc5YjhENzJwTG1RU25mODYzZ2VjMjhkaXRMOTFQVXFlL3J1?=
 =?utf-8?Q?WEAu/xH0aXBQXlusnDNFeUY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A872F7305D7891408B3EFB35343116E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e62554-7ff7-4ea9-5255-08da8f6f8c95
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 18:50:48.8615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gbV+ThepfaN9Zm0lxD80pgIOEcxpMANLPxh2a/4ulLDkvVgo9/hwMXCJ5QL2o0clSs8UQX1Ie4mkCT9D5vbGxp0AlUudhKP3ncxSQQ/J0PI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1761
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

T24gU2F0LCAyMDIyLTA5LTAzIGF0IDEwOjEzICswODAwLCBIdWFuZywgU2hhb3FpbiB3cm90ZToN
Cj4gPiArICAgICBCVUdfT04oaXNfemVyb19wZm4ocGZuKSAmJiBydyk7DQo+ID4gKw0KPiANCj4g
V2h5IHdlIG5lZWQgdXNlIEJVR19PTigpIGhlcmU/IEJhc2VkIG9uIFsxXSwgd2Ugc2hvdWxkIGF2
b2lkIHRvIHVzZQ0KPiB0aGUgDQo+IEJVR19PTigpIGR1ZSB0byBpdCB3aWxsIHBhbmljIHRoZSBt
YWNoaW5lLg0KPiANCj4gWzFdOiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIy
MDgyNDE2MzEwMC4yMjQ0NDktMS1kYXZpZEByZWRoYXQuY29tLw0KDQpZZWEsIHlvdSBhcmUgcHJv
YmFibHkgcmlnaHQuIEFsbCB0aGUgcmVzdCBvZiB0aGlzIGNoZWNrZXIgdXNlcyBCVUdfT04oKQ0K
dGhvdWdoLiBNYXliZSB0aGV5IHNob3VsZCBhbGwgYmUgc29tZXRoaW5nIGVsc2U/IEp1c3QgZmVs
dCB3ZWlyZCB0bw0KaGF2ZSB0aGlzIGJlIHRoZSBvbmx5IGNoZWNrIHRoYXQgaXMgZGlmZmVyZW50
Lg0KDQpJIGRvbid0IGhhdmUgYW55IG9iamVjdGlvbnMgdG8gY2hhbmdpbmcgaXQgdG8gV0FSTl9P
TigpLiBTaG91bGQgSQ0Kc3dpdGNoIHRoZSByZXN0IG9mIHRoZSBjaGVja3MgaGVyZSB3aGlsZSBJ
J20gYXQgaXQ/DQo=
