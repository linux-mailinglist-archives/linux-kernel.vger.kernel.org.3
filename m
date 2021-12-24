Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8DF47EDEB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343985AbhLXJlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:41:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:13377 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241700AbhLXJlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640338864; x=1671874864;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EFv/pZo7lr4Osj43dfD8RFRkMp8Q77CDOfoxZMHUSj8=;
  b=KAXbY21wGEdlNG7He3ZGTOA6Ekcv52aI/ElNnKqHqF2HkwDN0r8tHHxO
   w3G7lZ7B7KJSVe9lfXw6GVJRYmOBPK0Rd5/Dhhp6NMNBR24uXBPR8y6aU
   yP/eZA13fSQVTKgp4fypaqAbgAN1aLyGHCNBlwj6zDs2/67Kkz1tKI8dg
   dK3KuJ/8iYxaQ2AbIHEAdUaiOefpmw6pQU3LCzsJ5QMy87FtiZE+eEQFh
   LkrDSD8bK3GPZD8CU0joCai7aXURY5pMkcegQ0efSIT5bFb5JTwmmNTQ/
   vn31rlEJXdW3F+QtDbYBPewlITtMqMxEmPs+8QNYF/YkJhFYlnElAkdmy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="265173214"
X-IronPort-AV: E=Sophos;i="5.88,232,1635231600"; 
   d="scan'208";a="265173214"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 01:41:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,232,1635231600"; 
   d="scan'208";a="617745365"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 24 Dec 2021 01:41:03 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 24 Dec 2021 01:41:03 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 24 Dec 2021 01:41:03 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 24 Dec 2021 01:41:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5kyPJgaB6dT93SbW13auNiqGdRrT8IMri3sRUA3KAonQAeVYB4BBj6uyXChN8LD6towsXWGcGymQ2Wmwz/1HaAErLS2fQTWdlgfyesBplzQB+7opTd/62YRpzEFh1xnlVq0uGiet2L+pZH8Jp0LlCXkcRQl7+EpLXmoo8A6lvk2Wu+0BVWu75LCKRkAFa1PzJ61frkMZuvNM881eobTGNVHq6WcYyW/qiha6CvDhyEhwr1s3Cm7FZPKgv0cfcIJFCMmMKnjxhURo2ZkXw+elnrQxj5CrQGd1UElI6WX8iZX4kuB8agQf4A1GiuJsK6GtqjqWwrENr7MQPtMi2rSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFv/pZo7lr4Osj43dfD8RFRkMp8Q77CDOfoxZMHUSj8=;
 b=kmJuHSX9IDH+/SOOIPN3A6j4ahu9iTCSS+NYb9lBWldqB70feAEmo2CJXzoCIfUd/SUCZR6xcxP4d+PEQ1zNSsqE2rYE4wAwZ3n7J9/tbBO55bZ+NBskg8Zf6DdrJecTwwEQOzNj7Y2F3CrshnJh238CDRPeKheBDKu0V/MOK2NGaKiIaGZAtgMqODDNzsTbMQ1u6+mnZGR4+IycwTsIJ478BFZTwMSDKBap9uktd0DzO0IvUfP7BfUt4e5e4wqNa/B2IR6ZbAnPbqgNgAIrph5JsCR62aqY9/P44OzDr+JY5JpxnxSRN+cijejLsNNwQViXGsWPFo/JYqkoPDDKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5545.namprd11.prod.outlook.com (2603:10b6:408:102::19)
 by BN8PR11MB3714.namprd11.prod.outlook.com (2603:10b6:408:90::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Fri, 24 Dec
 2021 09:40:53 +0000
Received: from BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::c1e0:2a43:d723:e9af]) by BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::c1e0:2a43:d723:e9af%9]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 09:40:53 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v6 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Topic: [PATCH v6 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Index: AQHXo04llJrmCe8xQUyA5dZSwoZB/Ku29+AAgEeN80CAQkLJAIABQ6sQ
Date:   Fri, 24 Dec 2021 09:40:53 +0000
Message-ID: <BN9PR11MB554543CAACA5FD468B6692F9F17F9@BN9PR11MB5545.namprd11.prod.outlook.com>
References: <20210906183621.21075-1-shruthi.sanil@intel.com>
 <20210906183621.21075-3-shruthi.sanil@intel.com> <87lf3jaubj.ffs@tglx>
 <BN9PR11MB5545F024ADB86394FED085BCF1949@BN9PR11MB5545.namprd11.prod.outlook.com>
 <f8af5711-4cc4-7513-5ad3-0f17ce04b346@linaro.org>
In-Reply-To: <f8af5711-4cc4-7513-5ad3-0f17ce04b346@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca791863-3639-4a44-3714-08d9c6c17a8f
x-ms-traffictypediagnostic: BN8PR11MB3714:EE_
x-microsoft-antispam-prvs: <BN8PR11MB3714C58D959BC4A05F159FE5F17F9@BN8PR11MB3714.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1bfJMnJZ0IAFmo+wRevsFbcNVR9NzzRdDCg9CNPJ5lG5P8ycpxXaA6vsksGn3btnxcSTBt8lTv2UH2UREdwfryVoOs/AXufl5/IQAioB0AD8cGLeCCLvXdUZJvReEaat+DGihFl4n5YGPLhcdqCNsAKPJhiXZuXKwwPOhJ3y61XF72rIlZhCsQaqnNBM2foOdVwuzd42VBnn8tF6q16ilhOzPCrEcpxZnqrnGT0WGK96kq6M5lv2GU+EN94WFRSkICnTLK7KN5TRvKyM0cetEKzmYDEF+Te3EbW/pWCW5P+ZSz3iMReJoeRaBc7KIkVGfm7tRlFees6L42GoqstCrBRaxI2RVhMdkqybqDwPx9KixYEOkZ+fv6R/d81LV0/4rTOh68HRq4Un48X2ZQglCcMlVS/cNeRuYjnBTBbUsuungtWC8Wiar8V6Qeh6s7fmUEe1nOCpEk6+aN7918O6TpO82QHKqfNzsOmQELI0A9CFQIoERg7aL8tRKEPOapMloaHGpFWICTYbQvpjaroM87XdIhr9e1kq8P4tyiIo5cfWGUOwfl65FBer1PMDTkNhXv4c0dzUzfatYYvz3XDZZzhf3x3n+pDsEj/M36LRiJAkVa5GZMXNoRqSCxT2HBFvcLpHBiFSxSiF2hXjTs7nLCmlIKmAb0OlaLdg6XhTxPnCzV7cvILv7awfUq5iG5h8lVSEOwpd9AWFsDaz0NxFvvvVgLpw3JSIQOW8I/F6J2c22g9fsk36qOXk36FFNXnFrkueV32e5AQdPxHgIQ+33Lpv2kN9RPb9z8gWq9eJ/0uqHkgj/mYel+Ws4nrGMR68jF4KusZqViwiSDKQ2JvGmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(82960400001)(55016003)(8936002)(33656002)(52536014)(8676002)(66476007)(76116006)(2906002)(508600001)(66446008)(64756008)(122000001)(66556008)(38100700002)(83380400001)(38070700005)(66946007)(71200400001)(53546011)(6506007)(5660300002)(316002)(4326008)(86362001)(26005)(186003)(9686003)(7696005)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVZaMWFHQzRHSWNWQWV3YUJ5aXd1QUdETE9wWXNJZ1NWWkVTcVRMajJ5bVZ6?=
 =?utf-8?B?a2FkdWxTajdSVDZQUEQ1WDdyUDI4VEt2anhsYVhpRzJsMXZEeHJ4YnJ1enEv?=
 =?utf-8?B?enFYUEF3dzI4QmNpNWtJci90UlZLVE1nNzcrQncxRjFZVkFxMDlaK2dPbEFz?=
 =?utf-8?B?ek5vTVhYTWpJcU83SU9YSldMbDJRQzZLTFhKOW5wUnhoYUdjcVFlbXBiRlJu?=
 =?utf-8?B?cHJzbjJ3WDIrK08wc3luWWJSK2F2SmhxMzFZS0JlbC9oK1U4MHhzZ1FyVEU0?=
 =?utf-8?B?RzdJN0RtdUZSWVp6RzlveWUwMGRpbnM4QmM5c0ZNbFNOTnBadTE4dFd4ajQr?=
 =?utf-8?B?OGc2Rkp5d0tkamlhZG4rZldBZlcrZm1ZT0h1eFNTRjZOSW8xYmo5RndqM1BU?=
 =?utf-8?B?d0t3bEtTVTNPY0Myd2Vyb21QbW1NSmZ3SFUzZWZkNzVGcTFsaUk4Q2ZlTXdx?=
 =?utf-8?B?NEJYdjJnWFlOOFk0c3RWOHFPUkNZM080ZTZ5YmR6bWU3dG5HOHFVbkNWbEl0?=
 =?utf-8?B?dEcxVmdXK1FOeTVTRjNpL2FpTUJodXAzVHhKM0JlRXJaQ3kzSVZVeUd5TS9L?=
 =?utf-8?B?VFFNaFZNOHhsTVNlb0JaL3hIVHJOSmVPOEhWS0NiN0VaMk50RGw1cW1kby9W?=
 =?utf-8?B?cU8xNkJ2aUYyMk0yZzJwVTUxeUkzcno4Z0lzL3B6SDBEUUlOME1USVZaWXVx?=
 =?utf-8?B?U2dpYUxwWjBoZVZCbGtvS0x3cytHMHNBWUpWdkZMaEE2UnZGZDdUTHZFQWpq?=
 =?utf-8?B?cmhtd0dMaTRHaFJYZjlpYnp0VUtkMW9NRlNCUnRwRG1FaGdIRTJFMnJ0ZTFX?=
 =?utf-8?B?TnBqTUhjZjZmQXpNSkZoWmJsTFhRcmV5MFUwMEM1Sk00cytDcEFCU3ZjeGZO?=
 =?utf-8?B?cElYQysyYmg3YW1uR1ppazdGTjJoT0xoaFBHSmtjU2JiZGJQL1BwMzQzTWhk?=
 =?utf-8?B?aUQreWJCNUV0MktyUzVMQjlCZlNOU3hSbWIrSVNKNFZ1aGpRWWJkRjRqNE53?=
 =?utf-8?B?eURrOHErNVh1bTNDWDZRWmRxaTlLVkl4OXRuTDkyTjhEbWRVQ2pVdEJBN3VL?=
 =?utf-8?B?d1hqdlVmeURKdTlBYUxORVFtanNuMXZyYXFxM3F1Umt6ZHVYSGVqRVNVbHZ4?=
 =?utf-8?B?QSthUHdSZ1VRK3pyOUZERFhoRnI1T3RNalIyNXYrVmxranJiamZQNEMxYWwv?=
 =?utf-8?B?OHVoOXozTGdVNXVsSkU2UFFIaE4vNlNRVVhiamxWVEZnaGJuWVdIVkRTZUt6?=
 =?utf-8?B?dWZycUhRUncwZVlEcFcxK21WejJWYzJEcVo5RmtsVkRsY254TGpENHZSdlQr?=
 =?utf-8?B?d3A2Z0h2RWsrV0F4OFJoTTdNSFdRdzZ4ZThLVFYwb3kzejZvRmxLWGtHUmpl?=
 =?utf-8?B?NGs5VTl2ZnZ0cWpqZGZ6L2xoQ09QMXgxaVRsWGdUOUZla1A3Sk1hbngvVFNv?=
 =?utf-8?B?MVhhMTZWT3MvRnBScTM1OHdyaHFlU3EwTFdqWDRUQyt6Q1plRVZJV25STVdv?=
 =?utf-8?B?VC9MbVJXRzRZWGx5amJyeEh3SnZ4dTFFb0RYRUVEeVpKS0ZpV1ZSR3RwNlF6?=
 =?utf-8?B?KzRlQUo4QzNQZ3NWemY0dmprK0pjbncvajc2TDlyd1hUczBJQVFDSldGNFRF?=
 =?utf-8?B?ZmRRKzNNalZqdm9NN3VnOThQQUFERWNTOXZONEV2YktNNng1UUVSN2IvNDJJ?=
 =?utf-8?B?Q2Q2dzZPMXZONXAyOE5JNFhyMm8xVVBXaUpGTFRoNWdqeW9PQkNZMmViWCtr?=
 =?utf-8?B?eWZ0amlzY2JmN3FUN04wMzVNejFxdXhaVnhQY0V2bVlSMysrVDZ5QWdNOTU1?=
 =?utf-8?B?aVpiU2RzdXU4R0FTSTJXeE01RWsyQlBUYVp5WFVteUs4RElqdHVSYnh5Qmwx?=
 =?utf-8?B?V29uQnVQM0ZhSlV4UlNrUVVrek1tY2VHelB5TE0vZjhBSGszUTBJSC9zeU9i?=
 =?utf-8?B?YTdrZG5ONDluUWJDemdtSVpTS1FMeHRCclJYN3o1R3lRMjRYY0NnbG1LTWNl?=
 =?utf-8?B?aHh6bVJ6Z0pkOVJHeFliL0VnOVMrbWlMdGNPQzJTaWlJMGs2TDBHamNFN0xz?=
 =?utf-8?B?NmtXQWttNmhHOVYzc2dZVUk1WEt0SlNBNHBzUEFvVExzLyt1Si9yTGNnV3hk?=
 =?utf-8?B?K2VhYVdGYUQ2emYwakErcWh4VVIvYTVrMHlJdjg2S2lrUDNUamF5dUE0QlVa?=
 =?utf-8?Q?3tUm2UCaie943NiYDXKPhPA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca791863-3639-4a44-3714-08d9c6c17a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2021 09:40:53.1361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b1Pu/fGThClXIwVuRqbLOA/u+RK8Uy+FtJuPL9NhMLSSqe4P5crxIGnL8fbiBIdx+/nyU2ZpopGfiuhWl1IffQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3714
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgTGV6Y2FubyA8ZGFu
aWVsLmxlemNhbm9AbGluYXJvLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDIzLCAy
MDIxIDc6NDYgUE0NCj4gVG86IFNhbmlsLCBTaHJ1dGhpIDxzaHJ1dGhpLnNhbmlsQGludGVsLmNv
bT47IFRob21hcyBHbGVpeG5lcg0KPiA8dGdseEBsaW51dHJvbml4LmRlPjsgcm9iaCtkdEBrZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tOyBrcmlz
LnBhbkBsaW51eC5pbnRlbC5jb207DQo+IG1ncm9zc0BsaW51eC5pbnRlbC5jb207IFRob2thbGEs
IFNyaWthbnRoIDxzcmlrYW50aC50aG9rYWxhQGludGVsLmNvbT47DQo+IFJhamEgU3VicmFtYW5p
YW4sIExha3NobWkgQmFpIDxsYWtzaG1pLmJhaS5yYWphLnN1YnJhbWFuaWFuQGludGVsLmNvbT47
DQo+IFNhbmdhbm5hdmFyLCBNYWxsaWthcmp1bmFwcGEgPG1hbGxpa2FyanVuYXBwYS5zYW5nYW5u
YXZhckBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMi8yXSBjbG9ja3NvdXJj
ZTogQWRkIEludGVsIEtlZW0gQmF5IHRpbWVyIHN1cHBvcnQNCj4gDQo+IE9uIDExLzExLzIwMjEg
MTE6NDIsIFNhbmlsLCBTaHJ1dGhpIHdyb3RlOg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4g
Pj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMjcsIDIwMjEgMzoxMSBBTQ0KPiA+PiBUbzogU2Fu
aWwsIFNocnV0aGkgPHNocnV0aGkuc2FuaWxAaW50ZWwuY29tPjsNCj4gPj4gZGFuaWVsLmxlemNh
bm9AbGluYXJvLm9yZzsNCj4gPj4gcm9iaCtkdEBrZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOw0KPiA+PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiA+PiBDYzog
YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tOyBrcmlzLnBhbkBsaW51eC5pbnRlbC5j
b207DQo+ID4+IG1ncm9zc0BsaW51eC5pbnRlbC5jb207IFRob2thbGEsIFNyaWthbnRoDQo+ID4+
IDxzcmlrYW50aC50aG9rYWxhQGludGVsLmNvbT47IFJhamEgU3VicmFtYW5pYW4sIExha3NobWkg
QmFpDQo+ID4+IDxsYWtzaG1pLmJhaS5yYWphLnN1YnJhbWFuaWFuQGludGVsLmNvbT47DQo+ID4+
IFNhbmdhbm5hdmFyLCBNYWxsaWthcmp1bmFwcGENCj4gPG1hbGxpa2FyanVuYXBwYS5zYW5nYW5u
YXZhckBpbnRlbC5jb20+Ow0KPiA+PiBTYW5pbCwgU2hydXRoaSA8c2hydXRoaS5zYW5pbEBpbnRl
bC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMi8yXSBjbG9ja3NvdXJjZTogQWRk
IEludGVsIEtlZW0gQmF5IHRpbWVyDQo+ID4+IHN1cHBvcnQNCj4gPj4NCj4gPj4gT24gVHVlLCBT
ZXAgMDcgMjAyMSBhdCAwMDowNiwgc2hydXRoaSBzYW5pbCB3cm90ZToNCj4gPj4+ICsNCj4gPj4+
ICsvKiBQcm92aWRlcyBhIHVuaXF1ZSBJRCBmb3IgZWFjaCB0aW1lciAqLyBzdGF0aWMNCj4gPj4+
ICtERUZJTkVfSURBKGtlZW1iYXlfdGltZXJfaWRhKTsNCj4gPj4NCj4gPj4+ICsNCj4gPj4+ICsJ
dGltZXJfaWQgPSBpZGFfYWxsb2MoJmtlZW1iYXlfdGltZXJfaWRhLCBHRlBfS0VSTkVMKTsNCj4g
Pj4+ICsJaWYgKHRpbWVyX2lkIDwgMCkgew0KPiA+Pj4gKwkJcmV0ID0gdGltZXJfaWQ7DQo+ID4+
PiArCQlnb3RvIGVycl9rZWVtYmF5X2NlX3RvX2ZyZWU7DQo+ID4+PiArCX0NCj4gPj4NCj4gPj4g
TWF5IEkgYXNrIHdoYXQgdGhlIHB1cnBvc2Ugb2YgdGhlIElEQSwgd2hpY2ggaXMgYmFja2VkIGJ5
IGEgZnVsbA0KPiA+PiBibG93biB4YXJyYXksIGlzIGhlcmU/DQo+ID4+DQo+ID4+IEFGQUlDVCBh
bGwgeW91IHdhbnQgaXMgYSB1bmlxdWUgbnVtYmVyIGZvciB0aGUgdGltZXIgbmFtZSBmb3IgdXAg
dG8gOA0KPiA+PiB0aW1lcnMuDQo+ID4+DQo+ID4+PiArCXRpbWVyX25hbWUgPSBrYXNwcmludGYo
R0ZQX0tFUk5FTCwgImtlZW1iYXlfdGltZXIlZCIsDQo+ID4+IHRpbWVyX2lkKTsNCj4gPj4NCj4g
Pj4gU28gd2hhdCdzIHdyb25nIGFib3V0Og0KPiA+Pg0KPiA+PiBzdGF0aWMgdW5zaWduZWQgaW50
IGtlZW1iYXlfdGltZXJfaWQ7DQo+ID4+DQo+ID4+IAl0aW1lcl9uYW1lID0ga2FzcHJpbnRmKEdG
UF9LRVJORUwsICJrZWVtYmF5X3RpbWVyJWQiLA0KPiA+PiBrZWVtYmF5X3RpbWVyX2lkKyspOw0K
PiA+Pg0KPiA+PiBIbW0/DQo+ID4NCj4gPiBZZXMsIHdlIGhhZCBpbml0aWFsbHkgaW1wbGVtZW50
ZWQgaXQgaW4gdGhlIHNpbWlsYXIgd2F5LCBidXQgaW4gdGhlDQo+ID4gY291cnNlIG9mIHJldmll
dyBpdCBnb3QgY2hhbmdlZCB0byB1c2UgSURBLg0KPiA+DQo+ID4+DQo+ID4+PiArDQo+ID4+PiAr
CWNsb2NrZXZlbnRzX2NvbmZpZ19hbmRfcmVnaXN0ZXIoJmtlZW1iYXlfY2VfdG8tPmNsa2V2dCwN
Cj4gPj4+ICsJCQkJCXRpbWVyX29mX3JhdGUoa2VlbWJheV9jZV90byksDQo+ID4+PiArCQkJCQkx
LA0KPiA+Pj4gKwkJCQkJVTMyX01BWCk7DQo+ID4+DQo+ID4+IEFzaWRlIG9mIHRoYXQgd2hhdCdz
IHRoZSBwb2ludCBvZiByZWdpc3RlcmluZyBtb3JlIHRoYW4gb25lIG9mIHRob3NlDQo+ID4+IHRp
bWVycyBhcyBjbG9jayBldmVudD8gVGhlIGNvcmUgd2lsbCBvbmx5IHVzZSBvbmUgYW5kIHRoZSBy
ZXN0IGlzDQo+ID4+IGp1c3QgZ29pbmcgdG8gdXNlIG1lbW9yeSBmb3Igbm8gdmFsdWUuDQo+ID4N
Cj4gPiBJbnN0ZWFkIG9mDQo+ID4ga2VlbWJheV9jZV90by0+Y2xrZXZ0LmNwdW1hc2sgPSBjcHVt
YXNrX29mKDApOyBjYW4gSSB1cGRhdGUgaXQgYXMNCj4gPiBrZWVtYmF5X2NlX3RvLT5jbGtldnQu
Y3B1bWFzayA9IGNwdV9wb3NzaWJsZV9tYXNrOyBzbyB0aGF0IGVhY2ggdGltZXINCj4gPiB3b3Vs
ZCBiZSBhc3NvY2lhdGVkIHdpdGggZGlmZmVyZW50IGNvcmVzPw0KPiANCj4gTGV0IG1lIHRyeSB0
byBjbGFyaWZ5Og0KPiANCj4gVGhlIEludGVsIEtlZW0gYmF5IFNvYyBpcyBhIDQgeCBDb3J0ZXgt
QTUzDQo+IA0KPiBUaGUgYXJjaCBBUk0gdGltZXIgaXMgcGVyIENQVSBvbiB0aGlzIHBsYXRmb3Jt
Lg0KPiANCj4gQ2FzZSAxOg0KPiAtLS0tLS0tDQo+ICAtIHRoZSBhcmNoaXRlY3RlZCB0aW1lciBp
cyBub3QgZGVzaXJlZCBhbmQgdGhpcyB0aW1lciBpcyB3YW50ZWQgdG8gYmUgdXNlZA0KPiBpbnN0
ZWFkIChidXQgcmF0aW5nIHRlbGxzIHRoZSBvcHBvc2l0ZSkgPT4gcmV3cml0ZSBwZXIgY3B1IGNv
ZGUNCj4gDQo+IENhc2UgMjoNCj4gLS0tLS0tLQ0KPiAgLSB0aGUgYXJjaGl0ZWN0ZWQgdGltZXIg
YXJlIGRlc2lyZWQgYW5kIHRoaXMgdGltZXIgaXMgdXNlZCBhcyBhIGJyb2FkY2FzdA0KPiB0aW1l
ciB3aGVuIGEgY29yZSBpcyBnb2luZyBkb25lIHdpdGggY3B1aWRsZS4gT25lIHRpbWVyIGlzIG5l
ZWRlZC4NCj4gDQo+ICAtIEluIG9yZGVyIHRvIHByZXZlbnQgdXNlbGVzcyB3YWtldXAsIHRoZSB0
aW1lciB1c2VzIHRoZSBmbGFnIERZTklSUS4NCj4gSG93ZXZlciwgY3B1bWFza19vZigwKSBpcyBz
ZXQgYW5kIG1ha2VzIGlub3BlcmF0aXZlIHRoaXMgZmxhZy4gSW4gb3JkZXIgdG8NCj4gbWFrZSBm
dWxsIHVzZSBvZiBpdCwgY2xrZXZ0LmNwdW1hc2sgbXVzdCBiZSBjcHVfcG9zc2libGVfbWFzaw0K
PiANCj4gSG9wZSB0aGF0IGhlbHBzDQo+IA0KPiAgIC0tIERhbmllbA0KPiANCg0KVGhhbmsgWW91
IERhbmllbCBmb3IgdGhlIGV4cGxhbmF0aW9uLg0KSW4gY2FzZSBvZiBLTUIsIHdlIGFyZSB1c2lu
ZyB0aGUgQVJNIGFyY2hpdGVjdHVyZSB0aW1lci4NCldlIHdvdWxkIGJlIHVzaW5nIHRoZSB0aW1l
ciBmb3IgY2FzZTIuIFNvIEkgbmVlZCB0byByZWdpc3RlciBKdXN0IDEgdGltZXIuDQpJJ2xsIGNo
ZWNrIGFuZCBtYWtlIHRoZSBjaGFuZ2VzIGFjY29yZGluZ2x5IGFuZCBzdWJtaXQgdGhlIG5leHQg
cGF0Y2guDQoNClRoYW5rIFlvdSENClJlZ2FyZHMsDQpTaHJ1dGhpDQoNCj4gDQo+IA0KPiANCj4g
DQo+IA0KPiANCj4gDQo+IC0tDQo+IDxodHRwOi8vd3d3LmxpbmFyby5vcmcvPiBMaW5hcm8ub3Jn
IOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MNCj4gDQo+IEZvbGxvdyBMaW5h
cm86ICA8aHR0cDovL3d3dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNlYm9vayB8DQo+
IDxodHRwOi8vdHdpdHRlci5jb20vIyEvbGluYXJvb3JnPiBUd2l0dGVyIHwgPGh0dHA6Ly93d3cu
bGluYXJvLm9yZy9saW5hcm8tDQo+IGJsb2cvPiBCbG9nDQo=
