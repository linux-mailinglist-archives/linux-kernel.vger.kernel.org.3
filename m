Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3384F515A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1845963AbiDFCCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443761AbiDEPkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A0049F2E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649167155; x=1680703155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y08GMHQqwVBusiq+69P83R7rS9BNMc4z6Y9q9rb1WOw=;
  b=hqvw7NamkaC+hajEIGP7oT56TTEa9u1H7bb5LzOMZtTGVmR/GW72tjBW
   X31RJLdyvyHq29A+KaZ/tOo0iCZX+N9yFnVptAqTgZx08HQwwdLLjxYmp
   8HLtB7OUCE5pxEDbfuoIDPsLWvj6mkK37HPbTAxW8NJfFZfuVmeRIY2Jg
   l2AP6q16XnUEhkXXtpqN9ZUX+0KsxB3V+wIraab+S2N9rHkD19Y24xka7
   Lq8dOORlyH43//lAxj+DgM6eCecnq321mqIuuWgA3t/ObnnNn3Uy6HxPa
   t9ANRjZehXX/1ciTZBeEe/QO7H2R4mWpcD0IsxaE+o2lQFfKGwyfs0UT/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323926826"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="323926826"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 06:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="657947211"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga004.jf.intel.com with ESMTP; 05 Apr 2022 06:59:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 06:59:13 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 06:59:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 06:59:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 06:59:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAGV3OpvGCH6tfEk7SCXnyjK6LpWlbdHwSbItFOgOF9Yuit8wNI7Fw/wrFboBIyLq5TGXb1Pd1m9GIKjdA5492BKE45qogVNK7xL9TGfn0YrYr1GkHsE+cDfViWGOW4NKZro8dMtKTaRSOKOzZ/PceYtpoBcgFvvHfie/BnBDtnHkSjabzWTfCreY5sdRLWVs735l2azuKXXhmVe+peifMxNKmieIQliQwOXIGjO3JQb/15DXJFK44wWbLWRcTwEfSISFNaV9PNx3gixP1f1KF+YjKoOnpaQkZSAKGB4Vwf/7J2OgBzHU0QMhExQKVgoJ/5uxarOwwBqOm2GGg4p0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y08GMHQqwVBusiq+69P83R7rS9BNMc4z6Y9q9rb1WOw=;
 b=Igt9GSlHZjIJXNBlhdpXFN/AwsVi/qwkRNGHs4aESf1tqYkSCtEpuRjM8T910MfJfLbez002ltIVqjqRh/Y7aJ+1bCZQPMq+HaAdIrgQthj5LXKHXgISFmoWXji8bZ6UZnwgYDPhqgDT5Z8WS5HKdIQwEVnOgz75QJ2U4TQSTO5vpVY9QCjr9LBWRK3ajfTtRJo1WapkwADfrqatlOGzPH1VxfpGFHlX82IjHlbeVLRRhzhZWYAHLCo5uUCNf/StzILYRjt5HUDj+Ew3pTyrzt02v/pfKNJnJqwU80jfMEQVT9aLhmxMr/Iqm/OZd6BbAMThFcjgptITlQuBtgyBDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4803.namprd11.prod.outlook.com (2603:10b6:303:90::8)
 by BL0PR11MB3345.namprd11.prod.outlook.com (2603:10b6:208:6f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 13:59:11 +0000
Received: from CO1PR11MB4803.namprd11.prod.outlook.com
 ([fe80::fd37:b20:2593:c55c]) by CO1PR11MB4803.namprd11.prod.outlook.com
 ([fe80::fd37:b20:2593:c55c%4]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 13:59:11 +0000
From:   "Liang, Kan" <kan.liang@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Xing, Zhengjun" <zhengjun.xing@intel.com>
Subject: RE: [PATCH] perf: Add missing newline at end of file
Thread-Topic: [PATCH] perf: Add missing newline at end of file
Thread-Index: AQHYSNJm7Z4avW62k0aP9bTRkGVdsqzhVwzA
Date:   Tue, 5 Apr 2022 13:59:11 +0000
Message-ID: <CO1PR11MB4803640A785DF199D0496017E8E49@CO1PR11MB4803.namprd11.prod.outlook.com>
References: <20190617144725.6415-1-geert+renesas@glider.be>
 <20190617160011.GB3927@kernel.org>
 <CAMuHMdWPDMhz9YdEs-=iCLa6w--iS-Ug9SMUa=UG0bW2mMYyxA@mail.gmail.com>
In-Reply-To: <CAMuHMdWPDMhz9YdEs-=iCLa6w--iS-Ug9SMUa=UG0bW2mMYyxA@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2052d57b-b5bb-48b3-5fab-08da170c7617
x-ms-traffictypediagnostic: BL0PR11MB3345:EE_
x-microsoft-antispam-prvs: <BL0PR11MB334507F96B65649F4928EA34E8E49@BL0PR11MB3345.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qlSZBvupnlddweQHBAd2klBxW/GtoqHYcyeGcP09QgBg281KCK+zYFuF5hrBXBuIdOBWcTtWhhzyXxf8q9oJC0/8ZA7g7thfN84ZAqP38vvvY3Rqkatg7dMHnZUNUzAA+P7fu6tzYDaXAn23Q6LnhN56VTQrOFMYsKnAGvLUKI6wj2fuwbXMW2w6m2jWq1SVmJaiiQaSPH6uOlWP2+h5NOb315ZupqzOppaLpR+KzyFxPI1DUBXyQ1HXZKhPtAzFMGt42YcEP6J7uinw+z1wJOC0a3426CCr6mjZ49eXgOrQfagGcklfFlkWg6dAq6EQTp06fDrFMrqz6zA42HW774vjgPtZf87qFynqgx1Pb9h1VlmnhpU4WZb1ivpVFaU1pNkyOz95jX8bUBmjAmPVM4XUfICvI/xG2QtBkkpjWtvk3/JzouLCSXlqmh4o8gJPIiYXmgjbQihrwgEq8u4fh9gbVRuoyBj20cGaNvaIHuPnsyHkho8CBKDBSTKH5z7OQ4+BBWbjndNfPSEWMtCV29ICPLk1kBV3XInbEQfjeljRLQa/4dU2QuWpEI/0ngjx4ws0N4t1eJyn7XmYlTmfljD05VnEk1qUNVaZt/EJjiz6mW/mJ5K3UOrrJ0Ty1yvfx5/BMhPmuWApM4oHcMmiRLnBhYxEu1035Si3BbkYPQKGW12EoSqpnmpwHpMR+3Tev5ozWddVXyCkOd8GvUmnHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4803.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(82960400001)(6506007)(66476007)(122000001)(9686003)(7696005)(4326008)(66556008)(8676002)(53546011)(33656002)(2906002)(508600001)(64756008)(4744005)(66946007)(86362001)(66446008)(8936002)(38100700002)(5660300002)(26005)(55016003)(76116006)(110136005)(54906003)(316002)(107886003)(186003)(38070700005)(83380400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVZEWjJwRHk1YWlHMnU4NFNocUFxQ3RQVFh4RHpYeFQ3ODdxODduL2ZNam9J?=
 =?utf-8?B?UE05RTJMWlFHQTdEY2hVbFhZT1hRdjN0VGYybDVZWjU2SVRVQ3B3bHd2RnBG?=
 =?utf-8?B?UFFzSEh2V1kwNDRkMVVPaDBLZnFHclVIVEdHUnFNbjVCdUlleG9SUUFzQXZD?=
 =?utf-8?B?Z3lXdEloZ2YxVktYV0xzMlhTNW9PN2tVWkFQN0g1QXNVcTc4dGZsY0NHNzg4?=
 =?utf-8?B?TlA5eS90SEs4c0wrYmFIWkM1Nk5KYlI4eDI3KzZ3cHl5WXhob0VyM0Y5N0FE?=
 =?utf-8?B?bzVvNllsT0pCbUU0WTFYU2d2blByU2hxdFZ6dXQvdzhYazFXSjJkT0xvWG1U?=
 =?utf-8?B?SGg5Sm0wVXZ5UGV3Z25IeTlSTGs4ZUJpY3ZvakRYeks5UE5nWU95Tjd4Wnhu?=
 =?utf-8?B?NmZ5enlHUkt2bVhZVDlhNzYrRENLL0ZLYi9tMmY5MHB5M3RUbElOang3QUxK?=
 =?utf-8?B?YzN4aHh0U0xXbkFzSTBkdjFUZmJMZmFqRVc3VG4xRHFwUVVNcGgxVnUwY3p4?=
 =?utf-8?B?REM4cGg0aEhoUVE4U1ExRkM4aWZESUx2MU9YZkJ1VlZXNlpuRTVORDN3eUZK?=
 =?utf-8?B?ZjhwZm02MjV6NDYzTld0SUdhemlRZnNveUhzUmdCN0ozWmxkdHZjMFhuMThP?=
 =?utf-8?B?WnRGeDZhbkFFT1JvYU1rbEhPRnhkbUQ2djhjSG9SQU05a3BSZmlBcUlGMWFm?=
 =?utf-8?B?aUFhNjVGUjlGaUdQZXFTK045c0F1VmVBaVYwNW5WTlc5d0FQRWRnZFlYOTRk?=
 =?utf-8?B?KzhRVlRsNlJCRjA3akVEZkxpL1JPL3hIOTJQUHdHb2pOcjF3SStMcW9BdVlP?=
 =?utf-8?B?bW9YTWdINWc0R0hrL0lmdjlieEdCQkwrTmtCa0NpcFR2UHZhNEplK1FXc1JY?=
 =?utf-8?B?SVVJKzZ0SE0xTnJyQWg1S0UyTlNFKytlMzIxMXV6aGxFRUp1NTYyOFVzWkJE?=
 =?utf-8?B?ei9qVFQ2cVdFYzBKWlViazluT3I1L2w2YWgrSkdTeXpIdWYwQnhLVWdyMlFK?=
 =?utf-8?B?V0ZUMkdPbEozUXNpVHhDMEpJNjQ1cEdRY3F6QldQYVlzak1RUE9WQnFQbGxX?=
 =?utf-8?B?Snh5OXBUbHVYNC9MRlZDelJRWjZSNFRHRGtHTlg0dUczS0NqTnlrVUppYTh5?=
 =?utf-8?B?V2pYRnVVYW1Rd1NlRTJ0VVlPMmRJT09yajZTS3J1enhKSEFPRisyMlNwR0NK?=
 =?utf-8?B?MTlOYlRzMURaNWFNd2dwSE5SRzZiMGV1U1I5VHBha2lvM0xocE9aVGpMZEZ0?=
 =?utf-8?B?S0ZWem9mRW5IK0h6VnRZQ0Zya2hWZTVhdmc1L1F5Tk9CR0luanI0cm41VGZZ?=
 =?utf-8?B?T3NGZlNKQ0JzS3JWYWtxL3oyY2xXcmd3UEdQZXRubzlWUHd1ekpnd2k1Z3J3?=
 =?utf-8?B?cUh5bjQ5K0xVQXZVODN2MDd4WFIrN01Pdm5qaXNOZzlnRnQ1V2hEZndnWHdm?=
 =?utf-8?B?Z0s4b2ZTZnJmSWxHSW5OQlJSNkExNW1sbGtEeFltVGUrMVBvaVFHQnRFU0Jr?=
 =?utf-8?B?ZnA5bG5jWlJZSHZORXV0VTd4LzVqMU8vSlFpQkp0SEFGS3IxeFU0NXJ0MVV1?=
 =?utf-8?B?dXp0OVlLazY5ZFVqa0t0NEEwMjNMcHdxTDZrNllOa0YvVElmRjZwVm5rQ1d2?=
 =?utf-8?B?Zi8xbkYrU01zWHNUaE1vN3FxRGc0bkFHS0Q5Y1lLRzBXdmg5WHdRUzk2aGda?=
 =?utf-8?B?NGwzVXU1Zm5zOWJHb1dISCthV0VtNHlmUVhkVzZJc0J1VnBxNGxQWU9jNFFv?=
 =?utf-8?B?YnVrVDAyZlI5QklzeFA4aDNldUh3WFBGcUhDd3orRVR4TG1vbU40TGFyTzEw?=
 =?utf-8?B?cVMxakFKSXRnbnNJTFplRnZsQk5Nc0VtK1p3RDk2N2RFMi9uSUdYazZ6dnF6?=
 =?utf-8?B?bHhieFNDTzhhZEN3Ulc0SmFVVkhxUk9pUUJ0RWcrWWhYc0JjU0JJSll1ZGFR?=
 =?utf-8?B?Q3lkZSsyOXdlakl4Qk1KY09LdTFvZTFSMUtRK2xzSVM5cXh5T3l3eGdyVXBa?=
 =?utf-8?B?UWNQWEgrbmFOandVZWZEM21GQlErMTVjc3Q5Um5nWlVZY2pyVCs5cGIwTjgr?=
 =?utf-8?B?WVpKUkFoaVdzVGJhMjFNMHI5eTZVN2Rmeit0VDE3a3BaUzE1Wi91b0pvUG05?=
 =?utf-8?B?K3JVOEo4Nkk2YzhVdWEzLzdydE1UdFkxU2RZRlY4eXRsdC9BTkplbkthZXVQ?=
 =?utf-8?B?SUNQaFhwM2I5ZmFmNGgrdEtGMkpiVlNicDd0THRQaGdwZ1d6bmtoanpYRHlF?=
 =?utf-8?B?S0xuNjB1OFVnNFZDZmpCa1EzYTc5MklBdmRXOXVWampyemt4bFhxSDJ1UXlY?=
 =?utf-8?B?SzEyaFRnMXlXTHlZayttMkdIZmVWdDJEYk5XVjI4YUl2TWRwWVdGZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4803.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2052d57b-b5bb-48b3-5fab-08da170c7617
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 13:59:11.4011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/4kQaMVpznl4yT2JQ5ZS/e0mKbe636gtzpjnCTWeSs5Top6CXNrA448Sx8bemS0H9JatvBidpnhC3Nr6LBFpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3345
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTW9uLCBKdW4gMTcsIDIwMTkgYXQgNjowMCBQTSBBcm5hbGRvIENhcnZhbGhvIGRl
IE1lbG8NCj4gPGFybmFsZG8ubWVsb0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+IEVtIE1vbiwgSnVu
IDE3LCAyMDE5IGF0IDA0OjQ3OjI1UE0gKzAyMDAsIEdlZXJ0IFV5dHRlcmhvZXZlbiBlc2NyZXZl
dToNCj4gPiA+ICJnaXQgZGlmZiIgc2F5czoNCj4gPiA+DQo+ID4gPiAgICAgXCBObyBuZXdsaW5l
IGF0IGVuZCBvZiBmaWxlDQo+ID4gPg0KPiA+ID4gYWZ0ZXIgbW9kaWZ5aW5nIHRoZSBmaWxlcy4N
Cj4gPg0KPiA+IEF1dG8gZ2VuZXJhdGVkIGZpbGVzLCBJSVJDLCBBbmRpLCBLYW4sIFN1a2FkZXY/
DQo+IA0KPiBUaGUgYXV0by1nZW5lcmF0ZWQgZmlsZXMgaGF2ZSBiZWVuIHVwZGF0ZWQsIHRoZSBp
c3N1ZSBzdGlsbCBleGlzdHMuDQo+IA0KDQpJdCBzZWVtcyBsaWtlIGEgY29udmVydGVyIHRvb2wg
aXNzdWUuDQoNCisgWmhlbmdqdW4NCg0KWmhlbmdqdW4sIGNvdWxkIHlvdSBwbGVhc2UgdGFrZSBh
IGxvb2s/DQoNClRoYW5rcywNCkthbg0K
