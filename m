Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0E357AE38
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbiGTDA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbiGTDAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:00:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0682618354;
        Tue, 19 Jul 2022 20:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658286029; x=1689822029;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SuTOxC3xeWkHKB3LV9t5asIdmh0S7DWkrxwjc1WTWNc=;
  b=UqrkeUodrtwVlCQFZnZub16XPXHy+HaTIfDa/VykP7iXKR0Un2kb7zr5
   hlfxmnDL/iqbs2+uYvV2pXPYaMO1Ksh0cCI09khN3ri/+VnYX1ksb6NBa
   Fx8hsSz+3f5CfXfpaOvWm0n0ErM0Wkhl/NPvqyr0DEU/nyTXCZyOA7pje
   xqXVf29Y9ig9kFHB3bMaVJPxkqRSL1p0HNmm8LT0ntI2jkLl2aV0HW8Y0
   RcsWGJj9w3ep0xd8RsDUSz3++NWMU0Vklf06zl/wSNd5osezMiTpW09i6
   ctaC3B43UcPMkDUoxmVTd1qj+FkGV8T9sC0+YSOV6R8w8bEMlpNv7ah4Z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="350656481"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="350656481"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 20:00:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="740121383"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jul 2022 20:00:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 19 Jul 2022 20:00:27 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Jul 2022 20:00:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 19 Jul 2022 20:00:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Jul 2022 20:00:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TosVLSqN35ZBGm2t1ok0EiliGNE9wwfsZ9IJnVryh37KhXpV87TERlBVS9rYcSsfiQdpPrYSRVDFUuUwi9jzYJCALBbJjmjXWad72+n7miHHxhMXV4ZnefQgwS/IwdlLdppweiOpBzYGEVeU1PPzja/RY/kHBeHShrr7STtx880MgI35xXcM+hOXfxyGg9jyFfZFBGxhzpqdfMGxD2b8hCQAJ5M64U/GiB2+3exniMcW2NTdiNxzgkQCVuZysue+vrusZNg+YrO+EKkIQL4u1w6kWgIQ1a+wmfAC7itY5gT3zmWjoLo5lB6IP9RNQSskwqQXpqvM/fUIzbdAG/nB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuTOxC3xeWkHKB3LV9t5asIdmh0S7DWkrxwjc1WTWNc=;
 b=g8Q9UUDQRdQn+IRPdiIk0CLQl/u8otNj4DUEzwr//GqtyBshvbGWTRDCK0QdOR6UrKu2KW4DHcG/AIzRgsJ7ysH00V3n/YAF9KzB05s/C5Ys5GbHau2BnyLYpnZ4ePAO4XTPTPWeEb7tU/nFcqlMTvAm7uqR0iF2Gpx9n1Gq/yVlmJYFasTpZgX7Ktpi93HY21maRngid3CCt3+IrHQtTy9GIUwD+/zjTNEXR8LnsufCijYFyqdvveHigsuyXeBukIZRW0Bc/HcenhbKQSGU//1O40DhQlN1td21PjXVgvqMBtiRWZmW3pF2O059C4+8l0McQMpk30tl3dueqPuPGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13)
 by SA2PR11MB4873.namprd11.prod.outlook.com (2603:10b6:806:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Wed, 20 Jul
 2022 03:00:25 +0000
Received: from PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::6569:5ac:5138:1bc6]) by PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::6569:5ac:5138:1bc6%8]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 03:00:25 +0000
From:   "Mi, Dapeng1" <dapeng1.mi@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhenyu Wang" <zhenyuw@linux.intel.com>
Subject: RE: [PATCH] cpuidle: Move cpuidle driver forward before acpi driver
 in Makefile
Thread-Topic: [PATCH] cpuidle: Move cpuidle driver forward before acpi driver
 in Makefile
Thread-Index: AQHYlpGUKmAjRm9DBkW5CrmRNbrVmq18lbSAgACLrhCACXorMA==
Date:   Wed, 20 Jul 2022 03:00:25 +0000
Message-ID: <PH0PR11MB482497A0CC93F430DA208EDDCD8E9@PH0PR11MB4824.namprd11.prod.outlook.com>
References: <20220713082426.850911-1-dapeng1.mi@intel.com>
 <CAJZ5v0gsHPav5Ax6+9OMmeApqn7qdJPQmo5MMh=ba6Rtj5NnQA@mail.gmail.com>
 <PH0PR11MB4824DAE06FE50711C3252D93CD889@PH0PR11MB4824.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB4824DAE06FE50711C3252D93CD889@PH0PR11MB4824.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a69ac3d1-e463-40fd-cbb0-08da69fbfe91
x-ms-traffictypediagnostic: SA2PR11MB4873:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NSEp/AfGShYz6Hjo4mcXcX8F347uh7S5N51Uad/1zX/UsJ/ApPLiKN+JbdgODRmlI/qWVR1vSqI2OcIIM/315jbuM7paGI4D4R2927hcwqF0bCzSlXjrs84e5JCiom9BHYaXNHMjImfE0P5SsK+MYK9gvDz3eWQrJtbArq9qotd5dHKmrjX7aWL9Il5vrRz7amKynO3GqZW6XHT7d7yKlpDMMmkFSUA/+IUzdrP/7KgWyINb/YR8xc+kK+geqMQdtjN7thXWRhgaJ1JYZFfO5pTJodtUSVIMGQf8t6q4brMD1UBuL80yMck7vsCQujagEVrKbuijdQolZY8b4Vq2z9tVWWcXajR90b8wluWtbgqVkrmMNqDt+Qh0lNV9gqbvVSdqZljPvXZAQgCVge1cbMWmQiHM92yOr5infHj2S0QkExpFpzPQb+u/b1gKBsLhARi4GXEbq6lRUm4Y/4h18nLWnRQpEJ7OOEpWyfENPNjVr7hlSpWwClopIZHKHnI1GRnXxYevYDYzR/VY9F+9onWV2whYwULNNOehDQva3J38ruwJAu5k6cZS7qtIM1PHCVA2z76J7N84ARX93abmATr35ax2M/Ygil6d8yAwnVNjdTdSlF8pMCmLfkej44sCKYbKfbgRRzuzFATYu5UKX9V+5ej3XFv/HiZp6vfAEzqYmPtBYKXeyUgz/NPeGkLumKowhjE55uMW5ocoZi5bSvqKOGZozf2+oPrK0MC1rnQDr/2xh02Uhb9vURYnFj8NS2hUSXPdwr4tyzxcGZzz1tNwNHO2mIX5O222EaZlQUXwAaBP9w2ZO+nHCtLo7XlK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(346002)(39860400002)(366004)(52536014)(4326008)(2906002)(86362001)(8936002)(38070700005)(8676002)(5660300002)(186003)(66446008)(76116006)(64756008)(66476007)(66556008)(9686003)(316002)(41300700001)(55016003)(71200400001)(33656002)(6916009)(53546011)(26005)(7696005)(478600001)(6506007)(83380400001)(66946007)(82960400001)(38100700002)(122000001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkhadGRkVFJLMGY3NHBCbFd6SlI1aXBwSXJEYUdRbU5hcjVuRTVINTRZTmpB?=
 =?utf-8?B?T3l4MVdKbVRjRXVSaGY4ZnVSdUlUUXNqVGdTQ2ltNm5XeWd2N2dOK2RidE9H?=
 =?utf-8?B?a3JYM3pwdktuRUtpVCsvVjRrQThyVGR3SktoZzZmNmNtQ2hQVE5rT1RIaUl4?=
 =?utf-8?B?eU01UlhKRGhOc0ZScHo0b0tHSjFVcmJNZVZUS0FKeGlvS2pKcjZNaTV3QVlp?=
 =?utf-8?B?YUcvYXZLRGhqUVdXL3pZOEZHUWUvNSswcTJTZVY4T0FKeUxTd0NOVXRKZzdT?=
 =?utf-8?B?d08rZi9Vd2RFME52RHAzRXI2VkliZkoxNFJBZlJBdVFEeVdSaUtla0FoQnA4?=
 =?utf-8?B?T2ZaaVJZUTg4RlQ2OEFscnFKRHh2WjZ5NkpET1M3TXJHMk5nZE5IT3pjM2ZT?=
 =?utf-8?B?c2hseW1nQm84RHMxVjNyZFVjK0N6a1c0bjFpUVVZT3J1SDNIVmZkdEV6TDlo?=
 =?utf-8?B?T0Q3dmdrVUJ0bUlpa0lDRWJHN2NWMFZqTjBoL1BpNEdQSFNFbEI0eFEzSnlw?=
 =?utf-8?B?NmRVdGVjYlNpUzhIZjNlVTBTbHBiNkgzR2ZNUnd2S1ByTTVDY1h1ZUZqazVn?=
 =?utf-8?B?eGRRZy9VdFpYSitMRUZLRCtjTG1VNmU4REtuZTFjWGU4VlhFeHYwREJEcmVj?=
 =?utf-8?B?eGVtMkxROHhlTzVvWlFSZE1sWFJDQVpQdFI5VmxKZjVBZ3RUSWloR2JBY0xu?=
 =?utf-8?B?QW13bWxRT2VtelJRM2NnaE9YMHhISnZnUVNtZGNudDlyVTFjUjR6QUdQVDkv?=
 =?utf-8?B?Z1d0TGFCemNNRFN3VlhVK3I2RG1UY0ZlRmNobzNGU2RxdFY0dFZuYUxDWkhm?=
 =?utf-8?B?Y0RzcDBVK1BYVWU4enFmaURDOHZvSlNPMDhQemJpa0xhOFovUDUzSmgvOTVT?=
 =?utf-8?B?ZG9RdXQvV1ZCTkNnd3F4MlltTUxjWmJOVzI4elo5bWFmQmlldm5UVUVWRmhQ?=
 =?utf-8?B?dDhBTGFEU1E3UkdZTVpOKzdrMU5vMnpONWcrSkZWVWdXSlpMN0ZDejFRNmJ0?=
 =?utf-8?B?ZGJKY0NKUWh1RjllNVlxVWM1aHlrYzRsNlM1Y01ERmh3Q0RMY2MzSWlNMndk?=
 =?utf-8?B?WXhMbHNnSElodklWRGZOZGNPMXJSbURPR2RyN21ETlJhbmFzUjY1czJHRTdi?=
 =?utf-8?B?ZG5xeHF4S0ZyNFN2ektJTWFJZk1uRFRkQmZWSXZJNWRzRXBVcGZranpWZkZm?=
 =?utf-8?B?aXpwUlM4MnNkaXBSTXRXQ2tWYys3VVVkYm9RNzYvSk00SEcxcjE1c09lVXY2?=
 =?utf-8?B?WVB6SFhHcUYyeG9sZUs4aEFERnQzdHNKQlJGUE42V3J3S2x2RXd4MXhObzVQ?=
 =?utf-8?B?dk1hRWllWldFUXhrYWR2bDh0VjRpWEQzQmZGUjBZS1hLc015b2FEZ2xDbTBj?=
 =?utf-8?B?VE8xeExqUy9QZnBNTCt0N0lBSHp0Y3JVdWoyVkRNYjkycGJzMzd5dDdZMVMr?=
 =?utf-8?B?dnBLM0JIRDZ3dlpXNklwQlJyTWVkQ1g0b3cvaktPZHlXWEVZVndGWFBJUVJO?=
 =?utf-8?B?Z3VQbEM0SDA4ZTNVL1ZPMWVZQWozWDRlRzlWWkd1M1ZXWk9OeExHMEgxY3Jz?=
 =?utf-8?B?UjB3aGxqTEdGSnE3SXpickRWRStRNkR6R1JZUE11YWJUK3RXeEN1U3BmK0la?=
 =?utf-8?B?SlJ5a1ZWdTF5VUxUMHVLYjNCdThmSWRBbnZ5VWVJcE9idlRjcFBPK1hXMlV2?=
 =?utf-8?B?dFdSRGhZUHpXWDhwZEtQV1VYajFWdC9hUXcvd3NoZVJDcC84eWpxeWcvUUZ4?=
 =?utf-8?B?WitMMlhsL0FjM1NWbE8wZjFCdGhKSFBoYXI4VVhTbk1SS09yOTZuelJ6WDJa?=
 =?utf-8?B?WUh3cEoyd2tKdk9qOG9KWE5VMUVZbUxRckJjb3FIM3ZaWHVTakdlcUx5MVZt?=
 =?utf-8?B?dUlTYWo4dGxTZFdOVXVjRFZDRUtEVGQzNkJKZ0tNOHpWbU9YbU96ZEErS2dV?=
 =?utf-8?B?dk8zbDFOZDVRdkRLRlpXRnAxYTBVRHFTdW9NcXBGaFNGeWl6QVErdkl2ZEVZ?=
 =?utf-8?B?UlkxQU9OVndEQ3JXYVJMUkFnOFR0TXJBeFg4Ni9jZXIrY21PVEtyZFRhTUZi?=
 =?utf-8?B?cG5XTlZUdXNWcWYzVFJCaHQxQ2MzSjNON1YveXcvOExac2w3NGFjOGRCWjFn?=
 =?utf-8?Q?L20NLMzQQHzYHwtOH0NRTFhQr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69ac3d1-e463-40fd-cbb0-08da69fbfe91
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 03:00:25.4865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUhPDc5YZB7s0Lve5A5vQDTRAQnkhS3VKPqahRJYYBNKedffzUVqTx4Ou+Jn7aC/9wuUt+bMJCXN9DYeZg18iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEZyb206IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4NCj4gPiBTZW50
OiBUaHVyc2RheSwgSnVseSAxNCwgMjAyMiAxOjUzIEFNDQo+ID4gVG86IE1pLCBEYXBlbmcxIDxk
YXBlbmcxLm1pQGludGVsLmNvbT4NCj4gPiBDYzogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBr
ZXJuZWwub3JnPjsgTWljaGFlbCBTLiBUc2lya2luDQo+ID4gPG1zdEByZWRoYXQuY29tPjsgQXJu
ZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT47IEJhcnQgVmFuIEFzc2NoZQ0KPiA+IDxidmFuYXNz
Y2hlQGFjbS5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4gPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnPjsgTGludXggUE0gPGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4N
Cj4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjcHVpZGxlOiBNb3ZlIGNwdWlkbGUgZHJpdmVyIGZv
cndhcmQgYmVmb3JlIGFjcGkNCj4gPiBkcml2ZXIgaW4gTWFrZWZpbGUNCj4gPg0KPiA+IE9uIFdl
ZCwgSnVsIDEzLCAyMDIyIGF0IDEwOjIxIEFNIERhcGVuZyBNaSA8ZGFwZW5nMS5taUBpbnRlbC5j
b20+DQo+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEFzIGxvbmcgYXMgS2NvbmZpZyBBQ1BJX1BST0NF
U1NPUiBpcyBlbmFibGVkLCBBQ1BJX1BST0NFU1NPUiB3b3VsZA0KPiA+ID4gc2VsZWN0IEFDUElf
UFJPQ0VTU09SX0lETEUgYW5kIGFjcGlfaWRsZSBkcml2ZXIgaXMgZW5hYmxlZC4gQnV0IGluDQo+
ID4gPiBjdXJyZW50IGRyaXZlciBsb2FkaW5nIG9yZGVyIGFjcGlfaWRsZSBkcml2ZXIgaXMgYWx3
YXlzIGxvYWRlZA0KPiA+ID4gYmVmb3JlIGNwdWlkbGVfaGFsdHBvbGwgZHJpdmVyLiBUaGlzIGxl
YWRzIHRvIGNwdWlkbGVfaGF0cG9sbCBkcml2ZXINCj4gPiA+IGhhcyBubyBjaGFuY2UgdG8gYmUg
bG9hZGVkIHdoZW4gaXQncyBlbmFibGVkLg0KPiA+ID4NCj4gPiA+IFRodXMsIG1vdmUgY3B1aWRs
ZSBkcml2ZXIgZm9yd2FyZCBiZWZvcmUgYWNwaSBkcml2ZXIgYW5kIG1ha2UNCj4gPiA+IGNwdWlk
bGUtaGF0cG9sbCBkcml2ZXIgaGFzIGEgY2hhbmNlIHRvIGJlIHJ1biB3aGVuIGl0J3MgZW5hYmxl
ZC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEYXBlbmcgTWkgPGRhcGVuZzEubWlAaW50
ZWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9NYWtlZmlsZSB8IDIgKy0NCj4gPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9NYWtlZmlsZSBiL2RyaXZlcnMvTWFrZWZpbGUgaW5k
ZXgNCj4gPiA+IDlhMzA4NDJiMjJjNS4uOTIxZWQ0ODFiNTIwIDEwMDY0NA0KPiA+ID4gLS0tIGEv
ZHJpdmVycy9NYWtlZmlsZQ0KPiA+ID4gKysrIGIvZHJpdmVycy9NYWtlZmlsZQ0KPiA+ID4gQEAg
LTI2LDYgKzI2LDcgQEAgb2JqLXkgICAgICAgICAgICAgICAgICAgICAgICAgKz0gaWRsZS8NCj4g
PiA+ICAjIElQTUkgbXVzdCBjb21lIGJlZm9yZSBBQ1BJIGluIG9yZGVyIHRvIHByb3ZpZGUgSVBN
SSBvcHJlZ2lvbg0KPiBzdXBwb3J0DQo+ID4gPiAgb2JqLXkgICAgICAgICAgICAgICAgICAgICAg
ICAgICs9IGNoYXIvaXBtaS8NCj4gPiA+DQo+ID4gPiArb2JqLSQoQ09ORklHX0NQVV9JRExFKSAg
ICAgICAgICs9IGNwdWlkbGUvDQo+ID4gPiAgb2JqLSQoQ09ORklHX0FDUEkpICAgICAgICAgICAg
ICs9IGFjcGkvDQo+ID4gPg0KPiA+ID4gICMgUG5QIG11c3QgY29tZSBhZnRlciBBQ1BJIHNpbmNl
IGl0IHdpbGwgZXZlbnR1YWxseSBuZWVkIHRvIGNoZWNrIGlmIGFjcGkNCj4gPiA+IEBAIC0xMjYs
NyArMTI3LDYgQEAgb2JqLSQoQ09ORklHX0VEQUMpICAgICAgICAgICs9IGVkYWMvDQo+ID4gPiAg
b2JqLSQoQ09ORklHX0VJU0EpICAgICAgICAgICAgICs9IGVpc2EvDQo+ID4gPiAgb2JqLSQoQ09O
RklHX1BNX09QUCkgICAgICAgICAgICs9IG9wcC8NCj4gPiA+ICBvYmotJChDT05GSUdfQ1BVX0ZS
RVEpICAgICAgICAgKz0gY3B1ZnJlcS8NCj4gPiA+IC1vYmotJChDT05GSUdfQ1BVX0lETEUpICAg
ICAgICAgKz0gY3B1aWRsZS8NCj4gPiA+ICBvYmoteSAgICAgICAgICAgICAgICAgICAgICAgICAg
Kz0gbW1jLw0KPiA+ID4gIG9iai15ICAgICAgICAgICAgICAgICAgICAgICAgICArPSB1ZnMvDQo+
ID4gPiAgb2JqLSQoQ09ORklHX01FTVNUSUNLKSAgICAgICAgICs9IG1lbXN0aWNrLw0KPiA+ID4g
LS0NCj4gPg0KPiA+IFdlbGwsIHRoaXMgY2hhbmdlIGRvZXNuJ3QgZ3VhcmFudGVlIGxvYWRpbmcg
aGFsdHBvbGwgYmVmb3JlIEFDUEkgaWRsZS4NCj4gPg0KPiA+IEFsc28gd2hhdCBpZiBoYWx0cG9s
bCBpcyBlbmFibGVkLCBidXQgdGhlIHVzZXIgd2FudHMgQUNQSSBpZGxlPw0KPiANCj4gVGhhbmtz
IFJhZmFlbCBmb3IgcmV2aWV3aW5nIHRoaXMgcGF0Y2guDQo+IA0KPiBhY3BpX2lkbGUgZHJpdmVy
IGFuZCBjcHVpZGxlX2hhbHRwb2xsIGRyaXZlciBoYXZlIHNhbWUgaW5pdGlhbGl6YXRpb24gbGV2
ZWwgYW5kDQo+IGJvdGggYXJlIGluaXRpYWxpemVkIG9uIHRoZSBsZXZlbCBkZXZpY2VfaW5pdGNh
bGwuIFNvIHRoZSBidWlsZGluZyBvcmRlciB3b3VsZA0KPiBkZWNpZGUgdGhlIGxvYWRpbmcgc2Vx
dWVuY2UuIEp1c3QgbGlrZSB0aGUgaW50ZWxfaWRsZSBkcml2ZXIgd2hpY2ggYWxzbyBoYXMNCj4g
c2FtZSBpbml0aWFsaXphdGlvbiBsZXZlbCAoZGV2aWNlX2luaXRjYWxsKSwgYnV0IGFzIGl0J3Mg
YnVpbHQgYmVmb3JlIGFjcGlfaWRsZQ0KPiBkcml2ZXIsIGl0IHdvdWxkIGJlIGxvYWRlZCBmaXJz
dCBiZWZvcmUgYWNwaV9kcml2ZXIgaWYgaW50ZWxfaWRsZSBkcml2ZXIgaXMNCj4gZW5hYmxlZC4N
Cj4gDQo+IFRoZXJlIGlzIGFub3RoZXIgbWV0aG9kIHRvIG1ha2UgY3B1aWRsZV9oYWx0cG9sbCBk
cml2ZXIgbG9hZGVkIGZpcnN0IGJlZm9yZQ0KPiBhY3BpX2RyaXZlciwgaXQncyBjaGFuZ2UgdGhl
IGluaXRpYWxpemF0aW9uIGxldmVsIHRvIHBvc3Rjb3JlX2luaXRjYWxsLiBJJ20gbm90IHN1cmUN
Cj4gd2hpY2ggb25lIGlzIGJldHRlciwgYnV0IGl0IHNlZW1zIGN1cnJlbnQgcGF0Y2ggaXMgbW9y
ZSByZWFzb25hYmxlLg0KPiANCj4gVGhlcmUgaXMgYW4gcGFyYW1ldGVyICJmb3JjZSIgdG8gbWFu
YWdlIHRoZSBoYWx0cG9sbCBlbmFibGluZy4gSWYgdXNlciB3YW50DQo+IHRvIHVzZSBBQ1BJIGlk
bGUsIGl0IGNhbiBjaGFuZ2UgdGhpcyBwYXJhbWV0ZXIgdG8gZGlzYWJsZSBoYWx0cG9sbGwgZHJp
dmVyLg0KDQpBbnkgZmVlZGJhY2sgb24gdGhpcz8gVGhhbmtzLg0K
