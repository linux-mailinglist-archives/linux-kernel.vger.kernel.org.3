Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0525701B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiGKMJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiGKMI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:08:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401FB10F6;
        Mon, 11 Jul 2022 05:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657541337; x=1689077337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SV3nWVBraAZVDN1I/4dkM8IxPJ6bhAEvBWxLnLbRiu8=;
  b=Zoe4dYzUaHCy+RHn5NS5loyibcu6iCPUBfTPYD95xnPnfyroSwzxElnb
   1nihbipA/M1Wdaw2rAuP9Tmk/kcvTkmrz31i/J3nM9s6LRtXdkb1C9rRq
   cCzR0otbLm7ktFcITH+8s5MrKibvjR+qjtGbxG3hRmwpxjiJPE8PtbOWy
   Ru9YGH/iuBkEcZL+FmR9yYDWlVytQrWxREpfHmnDgE088mZbsAJY7uXoR
   AxSinwXcqjX+k7f9KlN6PLyyLhk1AvRCB7oM9zUfru2rfimeCD+yCBzeK
   Im4syELw5z620wn6s036c58WPJ1N3Cplaq0Gxq0xGKEAnB1MhRbe8fxea
   A==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="181599406"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 05:08:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 05:08:56 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 11 Jul 2022 05:08:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn0gQhDAP6QsGYON1HWcHeK+eq/EX4I2rlIh2cdTdAIJS65WeCYiV5PeBlxdZOTa5sOTI2Vy1fztdsKHOAo14OU0Msg081UeIGyV6eIkwBqpEYStDtgWMt1QD994k/ihVdlbCdSts/I3lhGbDe0kX2UCu+/9PcoW3r2Tm2fLLPaRn597+HzoiXvIalbBla/kd0pIEd9ftz2p6zo3D0Hc8NyQJM/qoSBEI+3AUj8S6Ak2ZKBtXt2sCMpdlkcAI8vF+E70wR+2+Ev6zs9a05EQj9O7kPRN/iNZAOhqOnegH6G0+nf5vdmPqYPisMrq5cIiDsAdgeXyCnBgkIOCHeNPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SV3nWVBraAZVDN1I/4dkM8IxPJ6bhAEvBWxLnLbRiu8=;
 b=MJovbCEQw5AOTtJa3IC6BsowSTQWmzqTkTGNsy81iEqtLU2T6DX4UJhVbrdsmThAEwN1TKqtnGIqHzkSwdkFibrxRFmNSVdHQuUNHFLsPXHqlohI9V/Qhr85WoSsv+OzV+n2+E6se0A2GeC+DbdeAT55VV4d+BULEMtClJe8qEFv+f8se6vH2ptoAUtPSsGPvSpuLyeFwCBNTqeLj6Dfh/KW4WBenTpM9laYzAgdf7jo4c2izOCl8rS55lDkLJQZNGICNBo6IgnOe+mK0DUYmhZJQohmHqOw6/LGlUo0pxJEAqU0kmG6OTKT34sUgJMb72RdkVTsqj1idKLFCTQ3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV3nWVBraAZVDN1I/4dkM8IxPJ6bhAEvBWxLnLbRiu8=;
 b=Cr4MK63/kYGzRGjyiW3odTfemixoxpsnTNPGsM+O1k8qWvoBkL1YhjnZfFWdlLMCRiALuUSlUWzBrTMNEusZpLnR4Y0jXO2MnwoTv6EEV6OUyxx+7vo4btR5Ij3d6uIgV24LsUDfcLp1k8dRjwXa/RDT2Y5fJ5mfy7yheJO/jOU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB3557.namprd11.prod.outlook.com (2603:10b6:a03:b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Mon, 11 Jul
 2022 12:08:53 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 12:08:53 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <geert+renesas@glider.be>,
        <Ludovic.Desroches@microchip.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <Horatiu.Vultur@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>
CC:     <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio: GPIO_SAMA5D2_PIOBU should depend on ARCH_AT91
Thread-Topic: [PATCH] gpio: GPIO_SAMA5D2_PIOBU should depend on ARCH_AT91
Thread-Index: AQHYlR5CFYyr2oUbWEG7dPrAYJ6cTq15E8cA
Date:   Mon, 11 Jul 2022 12:08:53 +0000
Message-ID: <f9cfabe3-fbec-05b1-a49b-9e31da043ce7@microchip.com>
References: <9996cb86818d2e935494d6b414d549432f91797a.1657528504.git.geert+renesas@glider.be>
 <8dbed370-c6d6-496c-eb41-efce2ee78286@microchip.com>
In-Reply-To: <8dbed370-c6d6-496c-eb41-efce2ee78286@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 340c4e5c-097c-44f5-3f58-08da63361f9d
x-ms-traffictypediagnostic: BYAPR11MB3557:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 70NmLE4lNdffrstDqmcWwUyC3NSpx315lnXPAG/KcSYku8oEQ78D4UJTse/FIVtreJvpqhTTitGIjwqaVspSMSVFui+D0+8/earfJGmh7HxrG4MvOX6H3qBcMmXB84kJCImXGIWx2hoc8roOxshm7x5xLgXiblzVsKzceXDyfMdiZIDMf9K+uvXtFdDL4k6p2N7v4NQ0seOn/+Gm3WhjsKcY3lAZpLG03oNvwAeu7fA0HmiOoGF8k8AHVO3sucm/jgRqLhJdS5zFDP1+AoJfHLCXvKNSbz4NbUhj+UA+lmpXiiJNq8vaqGSsm14eHW0qBKDTCcmA9oVFGCWYKmYoBNJCSv1YQn19oSzOtZOQbQU2cUd+b7tKhuDzggwXxsS7eYOeFsjneZchWkzdCKVZO6xkuiDd1JZ6MLZlvkTwlCmFe5wBcB8XDEIcpCXS5F3ELp4PmLThJS270PFj2x9OUznkvY9oEjdQnYpV4KhHYomn+4QtteJgSLw6bMxstnS0m49i6rZmFX6V6MZuiUC8scUarT6Bv3aJX07Ym2Fi2JIMiVpRi9K9vn9uUNtBs2YBybjvJ4n/OJDNbMlR30k92Pz7CHqUs4w5+5wGIHlCrWtqyvOH2gwcbH1V2FZ6wF0l0ZX1Eu+SshGyD3GUpFwEe4gtrlJeR+RwtHJLW4lOTKSf8MjxJzahj5Fd7kPdBNTO4DddDYal21muMv99BA+A0nZhbM4TDwu/w6Dk655Jvv2Hw5SHZROeMnsTmI4rw/G5rEimBfK7SrPJm++PpDrSyn7sgBf+8R4+DkcZTQna81JDhXuk5/DFj9WsSCqtsLzJFKz4wJMiJUGii+o+bSXG1gQF21+kSiH+V6JxWtFFDbwCb6oSom8F8ONK1VrlmmtY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(366004)(376002)(136003)(2906002)(38070700005)(6486002)(122000001)(478600001)(186003)(36756003)(31686004)(31696002)(91956017)(4744005)(86362001)(316002)(2616005)(5660300002)(110136005)(6636002)(54906003)(4326008)(8676002)(64756008)(66446008)(66556008)(66476007)(66946007)(8936002)(76116006)(53546011)(71200400001)(6506007)(38100700002)(41300700001)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3VxUVd5R3FuYVd0TWpydFFMNWxKS1lLdnJxaHA5WUNxMHlzdHMvb3hlcVhO?=
 =?utf-8?B?U3ByRFhuRW1hR1Fxd3MzRUVveUR0TXVKOTdNRDRkUDNMNlJDbk95ZlU0eHdC?=
 =?utf-8?B?KzBXamVUcW9vUzR4MkE2SkY1SSszRzlyQk4wV0VZbHRXTlZkenFJeEUwcFlY?=
 =?utf-8?B?b1pSMVJpQTFYeXRodHZUWlR4TmlpRTJIOXVlRTIwTGdVUVYrMWVzbzRocEp1?=
 =?utf-8?B?ZVlmRnpRakVJNXRkQzU3MVg3SkxRUkcybnFycFhJcmdhTjdjWm9CTU5ILzFB?=
 =?utf-8?B?c1Z0dXYzc3ZjSG5qbjJHdzFyVmMrMXgwWUZsdUt3Z1A2cFE3bEhkMjJHbUtW?=
 =?utf-8?B?YlduVUxMOE8wWjRwZzdHUGJMYk5RbkdmNjRpWkFkWVN0RmZuWDFQam5Vcys5?=
 =?utf-8?B?TlRPcnZBTHozL2ZoY2xGNVB1amdBNCtTYXBaODM5RExyUVhpUVdqeUhyMzNP?=
 =?utf-8?B?THZSYzBoOHhYL1RoN3ZuWWV2NVd1Q2F6Y21nbmNrRDJUNERWWkp1M2t2MlZo?=
 =?utf-8?B?aGNzZmNhVlZnd1dQTTIrckhRWCs5a3lYNkVUQnRhZzJkZXlwcGN0bTRSTUN2?=
 =?utf-8?B?WWEwMVFFWmVxVzIrWVRHREpmbjVVNXB3RUFHNGdrMTArNjc5Zkl4YXdaUlNp?=
 =?utf-8?B?cGlQK3FBb1dSamdQWmI0eFlJYThKOWpoUVZQcVFlSGYrb09OSXI0eWJ6OFJE?=
 =?utf-8?B?WUY5QXdCU0M3ZzRSelNRQlMzd0ltWFdSd2pwSlZrenVnOFFLRTB1ZWhrR2Zh?=
 =?utf-8?B?Qi9hQzE3T2poK0VQUHI5VEEraGlpcTdsV2FwV3p6WVkyb010ZjN3QTZXVWhG?=
 =?utf-8?B?ZWxPM3lMY2JYclBrRWlkdGRReFJ4YnVoRTdGY05wMjNnYXRsSWtDMUYvQjFm?=
 =?utf-8?B?Tysxbk5sak00MGRYbmxQQlZxTjNVN2Z1a0ZrTWlnNHdpT2tRV3JVdHBlQTIz?=
 =?utf-8?B?WVR0b1k5WHJkVmlUVGxJSWJYY3JvYWNCQ2R1RWl2d0d5amYzTU9KUWJqUjFC?=
 =?utf-8?B?WHVPeW5FaWxKQ2tWY2xqeHlBMkkrMjNaSTZrUUxSNWo5SGVaMDVPL1VZYnJz?=
 =?utf-8?B?ZXo0TUZRRGJKUW9ZODJaSkxpc3BoTFBDNnhFVERDVEZaR0lEcHhidm1mcXVD?=
 =?utf-8?B?MUZWZGRaM2cycUx4YnowdVVSV2JFSGJvMlVyQVZiVnkvTVFqSitjSTVCbC9o?=
 =?utf-8?B?WjQvOXlHZUtQZUJRWXdUOGIzMlRlaUg2UHdqY01FWERjazJTNVAvYWpxc2ov?=
 =?utf-8?B?bFU4eUFMNUlUTzQzQXprYzJoSUN5Z0QzQS9LK3R1VTl2aVl1ajZWc1lNenpJ?=
 =?utf-8?B?VHpmT0UvdWc3V1hSRG82WTZETFBCSTNqUmFiMnM1d3ZwR3ZYektzUC9RSjBh?=
 =?utf-8?B?RnJZWEJlYzVlTmxiWURkTmpzNTZSV3JZUjIvNjB6ODdVWFZxMUhxbXdtUHdP?=
 =?utf-8?B?b0t4NUEvdEZFRDQ1Z254VWhrRngwVVh5WUc3Snc0Nm1UcHBnQWFBaWgxczNr?=
 =?utf-8?B?eWlvT2plNFFRUFNpczVGRVNxc0h5dW1WNFg2aWFyYm01VGtGdzVla00vanFk?=
 =?utf-8?B?NmJ6ZkowKzZ6M3pIbkhXMG5PVlIrb2U5UEViUE1PRDdFTWU2VzVRSkgyb21K?=
 =?utf-8?B?Njk3Z2NFaEFrK2t4MnRTb2RrTUFQVXBoZkVLWEp5ZjBrZXNFR01Wb3Rvbk9j?=
 =?utf-8?B?T3FkSmRKNUlSZlZ2dnRmTEs1WCtwSGNSVzc2aHBQSEt2Skh2ZWY1UUZ1ZmJm?=
 =?utf-8?B?MUJlU0dJQUtSRGk4MW5NRVUrQXVjd092b1AyMFlJS0sxTTB6dnI2bmlITVBV?=
 =?utf-8?B?MTZNNVUzcUpLYUFib0M4dmZGU1JtU1hiZmJRUm1kS3RGeS82dUJ1YnRabmp1?=
 =?utf-8?B?a3UxcjNTRVkzQmN1YUNEbkp5RE81K2krY1diMGtuMTF5UXVWR3VKdkZhYXRx?=
 =?utf-8?B?TVpibVVrVlBqdC95TmJHMUFyODNxblFKd0piM3VhRTU3M0w3d0F3eHROWlBE?=
 =?utf-8?B?SGwrWTl0dWhFK0FQZ0VWaXIrRUZSUlpZT2pjTDZieVJkbnl6enBBYWFKZnJr?=
 =?utf-8?B?YS9hVEIzUEZPdEFsTy9FTll3cHVBYm9Fc3pSdDlOcFVMcWhYc2xvTlh5K2I1?=
 =?utf-8?Q?iolilnFhzew7mU+rcdxl3Kfjs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E27426C3B56755408E95FF7B84870C3C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340c4e5c-097c-44f5-3f58-08da63361f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 12:08:53.5660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PvHdNwZj54VWrdBGUAzMcf2KDPLUyKKqtA8S4IoFZ2tFMs2OZKafXY5hylQ9FHQ4NwrwZEki+OaXQDh5cc5KI1jPAGwireOhzBX4oUwE1lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3557
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDcvMjAyMiAxMzowMywgTmljb2xhcyBGZXJyZSB3cm90ZToNCj4gT24gMTEvMDcvMjAy
MiBhdCAxMDozNiwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+Pg0KPj4gVGhlIFNBTUE1RDIgUElPQlUgaXMgb25seSBwcmVz
ZW50IG9uIHNvbWUgQVQ5MS9NaWNyb2NoaXAgU29Dcy7CoCBIZW5jZQ0KPj4gYWRkIGEgZGVwZW5k
ZW5jeSBvbiBBUkNIX0FUOTEsIHRvIHByZXZlbnQgYXNraW5nIHRoZSB1c2VyIGFib3V0IHRoaXMN
Cj4+IGRyaXZlciB3aGVuIGNvbmZpZ3VyaW5nIGEga2VybmVsIHdpdGhvdXQgQVQ5MS9NaWNyb2No
aXAgU29DIHN1cHBvcnQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogR2VlcnQgVXl0dGVyaG9ldmVu
IDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gDQo+IExvb2tzIGdvb2QgdG8gbWU6DQo+IEFj
a2VkLWJ5OiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+IA0K
PiBJJ20gYWRkaW5nIHRvIHRoZSB0aHJlYWQgbXkgY29sbGVhZ3VlcyBmcm9tIGxhbjk2NiBhbmQg
bXBmcyBpZiBpdA0KPiBoYXBwZW5zIHRoYXQgdGhleSB1c2UgdGhpcyBzYW1lIElQIG9uIHRoZWly
IFNvQy4gQW55d2F5LCB3ZSBjYW4NCj4gYWRkIHRoZW0gYWZ0ZXJ3YXJkcy4NCg0KTm90IG9uIEZQ
R0FzLCBzbyB5b3UncmUgc2FmZSB0aGVyZSENCg==
