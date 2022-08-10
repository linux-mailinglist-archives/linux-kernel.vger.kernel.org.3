Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C033958EA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 12:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiHJKRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 06:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHJKRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:17:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC4E6F563;
        Wed, 10 Aug 2022 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660126656; x=1691662656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0FSfp9pR/ryQL1qKV3++zTY8/byKiEskfvX+Dm0+mz4=;
  b=SJ4xoHV0NFW2ZrmR59ID7Nml4EGsGuCCJwrrajV6ggUjjBb+UsRJVYsZ
   KeBuA5FY9x2BWrrY0WQmFSfWmTa3X5m1D72RvMbY4E4OVX53iBS/BiUwE
   kEErg1R9MlSkFxzuZMyUMW01Vs9kwipLd9imS8AFthp/i4NeY3eM93N0B
   WGdfV/Ue6g0fwMzpTAxHUbaA0+5szYXDHRKA2XLBMqx6Tdx5RvvEmJRrv
   Q7XZ2gOzHM8NgpFowQwpwQqTxLAOr0HP8+20GZi4oP/JC9SKsXKKtk5BA
   /3pMJKCrI6LRj8ymdVGdCyEV7IO02ik9xA1U2sEERFaWhzy2NUIcSeqAc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="355050208"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="355050208"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 03:17:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="708175397"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 10 Aug 2022 03:17:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 03:17:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 10 Aug 2022 03:17:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 10 Aug 2022 03:17:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGZj+1tIbVhCmTTxiFxEwW+Af3C05xWnA3NsmwVbHsuKT+MioJ4h5NVKiKGdKrCFRdjqHmhTVedvFfEa7y298DR5L/cpUY/PjXFzt86YW9TqhhFIemg4Jbkv+gRcTbaOLNvegnLikH4tsSuHLflR9j80NIEMrb/W5G+EPDY05g2ETOW1ltrHV4lu2SFqF8jsYaCAdjODknGbMjIMPXhbCP7uaKcroaoA8kD0Zc7fFjAswtudjzUvalWMVNHAOzO7KdeIOGtx0HJ0CqskF3qYof7tOkusE0Tq5OTYPu4OxXSSA2BUHYqVN/fPI5rz/Dj2MYXda0h/tPdYny3LJOku1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FSfp9pR/ryQL1qKV3++zTY8/byKiEskfvX+Dm0+mz4=;
 b=P1Y9Th7RSfxnf/R+brQpX8RrWUiZNVvOduGcSH0IrfirofRRjZx4aO4gKTeeV7TwZtg2BUjkFYYhp66sgJ62LNnpqRvtSpRApzmaiMASZkIp+VvsIIrRXXfYFM5TgCzdD+hcrA0AaD5Tb2NWrr1YPcM4/fO1p5U8KxqS5t3fPpV7MdGXk4VzDbGBoCx4L+NkH3WQgPQKaxnmiS6MCLUBqBlcUekgpIQFqSwkne7fduV+B3oGn3OtPxVZPxbskxqKtBUpa9/G2aHWkN/s04+ysVRudzcZPpBcj3mtM/P/gRV2xNyLOBXpiafUMSd0rEODd0K2ezl3fpE4hAJuMfJa+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BYAPR11MB2808.namprd11.prod.outlook.com (2603:10b6:a02:c8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Wed, 10 Aug
 2022 10:17:31 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::1d3c:4dc0:6155:2aee]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::1d3c:4dc0:6155:2aee%4]) with mapi id 15.20.5525.010; Wed, 10 Aug 2022
 10:17:31 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "dave@sr71.net" <dave@sr71.net>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Lutomirski, Andy" <luto@kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>
Subject: Re: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
Thread-Topic: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
Thread-Index: AQHYnGzh1nwOjOji802J3mkwYJ5zAa2V2ruAgAZYAICAC9k2AA==
Date:   Wed, 10 Aug 2022 10:17:31 +0000
Message-ID: <f16af3f7887d26cde9073d443c1b796c945bc042.camel@intel.com>
References: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
         <op.1p2k13ibwjvjmi@hhuan26-mobl1.mshome.net>
         <35d7254cafde24b722b167c6a3566592d903acd2.camel@intel.com>
In-Reply-To: <35d7254cafde24b722b167c6a3566592d903acd2.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.3 (3.44.3-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f85711b-a9fb-4327-2de2-08da7ab98934
x-ms-traffictypediagnostic: BYAPR11MB2808:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xqw99pepRaUqkOXb8E/NspAunQXU7YcKtueaeRpdVFsnOXjQdxqi4doLcsRza6W7WePoLmHIITcYA3v+raA1DR/tKt84od19qdrk+b3ph6U/uUeM+5Ipju+cJidIf/+P4JBXHwCDXXoDTx1XVI53VQGIHRpPChIwBfV3I+HXzsHevHNzbwlxDJllLmiJkdq2f5FjTqUcZxFDis+DskLihko2QitQKiAcaPGAuRxTVuZ9pdjhf7uAWcR8rF5WgUeV6jOvXFiARQxkTUrrN619m3RwW6s5EnSL/9UzBgmBDecQrBYEzoJZYrBi+bcPu0I+c3jjFLx8y9IvD9DBzvzeKJMrD/I3gHDQeE9Sx+0tTNtvpvblmPZnPeS+Hpp0zXPzihJXC4pj5nrxd5Kt+rOSUGsXZYE1QpnYiBAFg7qFeDklC/4u7ThxGrlWLHASzyUnJ7jzUIwHVvtn9WlVPvjwShugXOYKOV/O/UTMjsmd1ItZ8RQMLFfYd4VcvYpqwPKyeeniOFmXNebHU2jpdl+GtDdRLA4l8rBLMZZU+AV4pDnCRDu/DFIy/OG2Xz+dSG/T2Ay8NVeOZMiD79vQhbx5AVWAF4DSzhEq8cY4dd+67KQQxIX0RVIzhcgkE58UlJtC+nX+L8tvDZIKfTz0ouZKcsnmwToChUU3ma15/P31wVEVCbJ9x2DwwyQk1wpdlJ8h6hJGObaaFDlAI6u7WgVW6qhjtf+z3nCUxTvItQO1aMedtLRq0RISSdBTuf5YodLbSRUo6GbvK3+2AS7AIxP/Ht/9A3epBuQK0GU5kxSX8PGLdCYd49PVVIRAS9JRnlUnQ4NswNf3QNIy4Ee5EYYi+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(136003)(376002)(346002)(66476007)(66556008)(66946007)(4326008)(316002)(64756008)(8676002)(36756003)(5660300002)(110136005)(66446008)(91956017)(86362001)(54906003)(7416002)(4744005)(122000001)(76116006)(83380400001)(2906002)(38070700005)(8936002)(82960400001)(6512007)(71200400001)(186003)(41300700001)(15650500001)(6486002)(26005)(38100700002)(966005)(478600001)(2616005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE9VSk1rSk9kYkQ2alBVeW1nSUlpQy8yaWRLUGY3SXZVcHRhdS9OZzNKWldw?=
 =?utf-8?B?ek0xSE5ITWxRSzE3MmhwaEhXYjN3S0pvSmU1azc5VHJQQWFuL1VqSnoyK2lD?=
 =?utf-8?B?SmhsVmF6cjRvUXR4WjNZODlnMWRROUFHOHBKc3ZmOFlReFBCd09Jc3RlM2NH?=
 =?utf-8?B?Y3pFbXJCUUNORi9QNVFzbEpPS3Z4QnE4clRtZ2QyQ1JpdWtMSWZJL296WmNu?=
 =?utf-8?B?Qnc4VDRMMXkwK0oxc3FLRDd6amRpMHN1K09HTGpXd1AxaU5JWmhlWE03YjI4?=
 =?utf-8?B?SklMME8xZEZRdi91N2pyZWYzL0J6MHdyckxOcGV6K2YvSzlFV0Y3VDVLYzYz?=
 =?utf-8?B?L3hBNnNCWjIrald3dVRxRlVaSXoxQ0FMcko0bk1ia0hxN1hMR0tod2VPUUY5?=
 =?utf-8?B?dWJmM1R1WXE4RE9xMzNrZkhWWlpxcWsyZ21xN0dIRnV5THpHRW9iOHpyTGNi?=
 =?utf-8?B?WjZVUWY2TTFRN2M4ZlpTTjlybStwZ0QxMXhDcWdUWlg5c1BMNUZjeHcyKzUy?=
 =?utf-8?B?WThUTlp2dFY4cEg2ZXBHZWJQMmNvbSthVmRkWDZKczJOcDVreDV1TkJ4TVZ0?=
 =?utf-8?B?ZUpGdXNaTWV1aFJFbUNyMU9UaVNBSkp5M3hrMmRoTlNUOVJiYnhrSG5VNXV1?=
 =?utf-8?B?Qlg4d3loT04yK0FCR2JzTERZbWFlTFlGYW5zUDc0ZHNWYk8yWHoxRTREVkpi?=
 =?utf-8?B?SGJ3V2JTRGkrbEtxcFZXNmxLQkNHRDUvcDM1QjVwWW1nNTEwZitYdUVlMnEx?=
 =?utf-8?B?YUtmR3owVEpmdmlseGU2QkJmQ0QybjNHTEFzNDBrak5ibC90c0ZJNTQrZllV?=
 =?utf-8?B?RDhmSERVcC9NeVArSVowRlRaNHA5NmVPNDRBOHdncFZnU1FGUUMvbC9NTmxa?=
 =?utf-8?B?ajlZZy8xejJpOTg5TWdjbjFybVpYZklrQVBtT21YeDlvcDRUWDVIcmhuQ2pR?=
 =?utf-8?B?Q2k1cTV4YTdpaExDVDNTUEN2OVVka2Z1RDFZT2FCZS8vcHYzVFV5cndGZ1dN?=
 =?utf-8?B?SkR5eHVweGIrbzZRRmkwRDNKaHdqdWc2V1ZFYXZBMUJPSjdkakhzeHdqMUl3?=
 =?utf-8?B?UjJkSlBQRk5QdWp4elpiT0FyemJ3SjJ6b3AwZmozZ3lkTVJ0eEM2cmdudFhT?=
 =?utf-8?B?SUNSR2hCbjZaZG9SbnBXT0g1aDZhOXMzendaWjFIOHgwREZRck9YUjlOZVhD?=
 =?utf-8?B?aTFPUGNDZCthZnhPYno5aEZ2L1ZlbTFSWHJ3bWpXdDdnazcwRC9NVysvYk5J?=
 =?utf-8?B?T201cXJvTWtKOERBQXQ0K2FJTEtWeTAwakRBSEZZMmZ5eEs0U2l3T0E2RHdH?=
 =?utf-8?B?MUs4Mm52eHlBanZoREdFVm8zSTE3NzNFS29WN2doNnRSS0l5akZqQTJCcFl3?=
 =?utf-8?B?WXdpUTQvVW45c1RJSUdoODhkZEc0S0tXZlhja0xvTHJVdWhCTGM2UTcwMWg1?=
 =?utf-8?B?d0dndWhDaVlPazhtYkhLMFJXend6WGJpUjdsdURqNkhadWEwdzVNd2l4aTJM?=
 =?utf-8?B?SEdzN2pMVGNGVjdGQ3Fpc0hEbTE5TkgxbkhmK0tPdWRFNnk4YjYwSE1ReUNa?=
 =?utf-8?B?RzB1NGVJelJGUmVoQzAvSFpxNFdEeEFKUm5Wa0dYeXdEUjFhM2dERWRnRVhr?=
 =?utf-8?B?NWtuQW5GdmIxRjZSWFdSSTJ4N1dzQkV1cHZNMEJzaDBNLzlyWTlNYlRUQTcx?=
 =?utf-8?B?SjArako0eXZPM2FMOXJJZjU2SHViOVJKUitCdGJVOXRJNXlPZVNSOTYzRFlt?=
 =?utf-8?B?TjRuUlFmS09HZlhhQVVqUCsxblorSnFTd28rY3UyZFpqTS9uSHEyNUtEdlFO?=
 =?utf-8?B?b20yc0hJTC9pSnQ5cldvWHdTcUxBUzFBN0dSMjdFVmRXOUNiOTdKVlNNd2p1?=
 =?utf-8?B?a2RDZEhyOXZDOHQ0eUFoMmFrMmNBSkgvZ0xCdGNDOHQ0NC85dlpKYkRaMHBj?=
 =?utf-8?B?d3FISlphaDBXQzlNR3VXd0RTZ2wvbDhSeHI0eTl1NDJnS2xFRkhFNjE0N1BW?=
 =?utf-8?B?SW1hYmNDcUdVd0JWNFFKQXIzV25ucHhLQWhOL2NkZGNIUkhhUWRaaHEvMjZj?=
 =?utf-8?B?T29CTDZsR29sVlVpQ01LYkx6NGVaL3ZXekoySWdOOFlwYlFCbWkwdHBEZGsr?=
 =?utf-8?Q?LJ2X4bv3qS8+VT2+4p0JpiCMl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <682D6AED2E0F174AAF085D241EF7D850@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f85711b-a9fb-4327-2de2-08da7ab98934
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 10:17:31.5313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TVzdWXiLf2XvO9eLiJv/2PAVvR49cW4WiTT8Y4AYfrIXQjVBDwv3VVZmmhjxxuuacGpAg8RPAS5icaovdm93IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2808
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTAyIGF0IDE0OjIxICsxMjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4g
DQo+ID4gVGVzdGVkLWJ5OiBIYWl0YW8gSHVhbmcgPGhhaXRhby5odWFuZ0BpbnRlbC5jb20+DQo+
ID4gDQo+ID4gVGhhbmtzDQo+ID4gSGFpdGFvDQo+IA0KPiBIaSBIYWl0YW8sDQo+IA0KPiBDb3Vs
ZCB5b3UgYWxzbyBoZWxwIHRvIHRlc3QgaW4gYSBWTT8NCj4gDQo+IFlvdSB3aWxsIGFsc28gbmVl
ZCBiZWxvdyBwYXRjaCBpbiBvcmRlciB0byB1c2UgRURFQ0NTU0EgaW4gdGhlIGd1ZXN0Og0KPiAN
Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDcyNzExNTQ0Mi40NjQzODAtMS1r
YWkuaHVhbmdAaW50ZWwuY29tLw0KPiANCj4gV2hlbiB5b3UgY3JlYXRlIHRoZSBWTSwgcGxlYXNl
IHVzZSAtY3B1IGhvc3QuDQo+IA0KDQpIaSBIYWl0YW8sDQoNCkRvIHlvdSBoYXZlIGFueSB1cGRh
dGU/DQoNCklmIGl0J3Mgbm90IGVhc3kgZm9yIHlvdSB0byB2ZXJpZnkgaW4gVk0sIGNvdWxkIHlv
dSBsZXQgbWUga25vdyBob3cgdG8gc2V0IHVwDQp0aGUgdGVzdGluZyBtYWNoaW5lIHNvIEkgY2Fu
IGhhdmUgYSB0cnk/DQoNCi0tIA0KVGhhbmtzLA0KLUthaQ0KDQoNCg==
