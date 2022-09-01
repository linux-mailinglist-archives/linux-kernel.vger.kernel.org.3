Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1874B5A95BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiIALbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIALbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:31:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC405E42D0;
        Thu,  1 Sep 2022 04:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662031869; x=1693567869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=577d3eBFf329KevDvz9nlRewIUtUuwuq+GS7cytYkOY=;
  b=MR30qyMFlb4/we0pH+4swaHPC77xaTnOO/WV4YGjEUqI9h1PpnsXXO82
   bzEvCcM1mVAw1Aa4KjrIfSzxNXGRz/LyeP+05I/wkNlEj4NMv+CefGvL4
   D5BxaNGJJI2G9V297d2aZhjum3hrsQb1APCatu9vZFPx57M5Ok9waF9EZ
   /8IBDy07ZVVybS3CJ2GcOQaEI70S3NBylVyOD92SvkhyjUXV936cM4bbF
   VSb8KnqZhS0Juyk0diD+J6zsNXWRYUrf+qTSohWSP+l5Hto8a6XFEptIi
   cidyKU5DWkCnpcenzCBsDYJn2xvKnaXtWx7/RzbFkyk050pJRu86+02JU
   A==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="111729602"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 04:31:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 04:31:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 1 Sep 2022 04:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2cy17NcYs9F1deRHsfw766b6TxH76QW9Zhsg6JoOOQeYRIg7VE3aayW60L0fGsJymJ8JzVWFL0XtT/PYfqTWRAzP1UuOINK+GqlsjjIFTryLX12g9yu0bR1ImRPD0pD6heLTcLLfndFgo0sbwIdk/+pdSios8zvIAOLDD1VRKNoWqDfroZAj3g93XNTMIrrd8ehO4OiIkMB/1EkrIbCoccSqKj4dmmWSYBaxguaV7HCBsFmbf9I/705dR6sS0g6aC0w2aODjVbFTvFLWSnJlKpow5mE4QwRNRvC//Uhlg4F9exi4KH1da9qXAuv1m6/DpK6zrP5b/okF/VfiCC9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=577d3eBFf329KevDvz9nlRewIUtUuwuq+GS7cytYkOY=;
 b=H0QxHsluGK+8ZScqQIE8jd0LSC71vXpTDwZBGr75dWxqsTQeSopwX4ztVmlSunWVyMd7X+c/r1OzI259cSHYmSlB7KStdn5U6TQ7A8yHg6hkGbpPgsh+vTjOgbr+cOrCkUky6fMcOFgkE4mXDFeH2A58y58/FZm8IQ5mU/RQAQ9vfY7GwUV9jrLx1YmzYxrLaZyJEvCzHwtzL+cEn4np61auP55fJQy4ZOkNXjszudFeIWHdj6MCq22KLeQ1j/MQzDMq0wCaa7xKqD8tXzUTF8sFLKVrOumsBLYfIuoHG3SEa6rkyizxAZQWBf0P/JkaHi+s4NTKcfWYhTbVDEMIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=577d3eBFf329KevDvz9nlRewIUtUuwuq+GS7cytYkOY=;
 b=nM66aZilaSpW4UkeeGELAhFXPWGLYqN9H8nYqiidWV0rd3YaiuciDnFtkSgMvo9dEdbjwemSyFsn2u69w2eMWzxgoQq3sDFA2/fDd+9c6f0kMI2OzzqIhTE19/6mqvxuwzYvpDH6QfPEfLmOqAvx+vZWsdh+NbXLYUHx+9nk/6Y=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by SA1PR11MB6757.namprd11.prod.outlook.com (2603:10b6:806:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Thu, 1 Sep
 2022 11:31:03 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::157:bd28:ee31:c6ab]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::157:bd28:ee31:c6ab%6]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 11:31:03 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <Sergiu.Moga@microchip.com>,
        <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <admin@hifiphile.com>, <Kavyasree.Kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Thread-Topic: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Thread-Index: AQHYshAIm2HQUST33kmommbXuaTdQK20V98AgAGSFwCAAAKPgIAABQQAgBSW+AA=
Date:   Thu, 1 Sep 2022 11:31:03 +0000
Message-ID: <f2fdaf34-ad66-9e6d-2f11-34171fb7aaa9@microchip.com>
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-3-sergiu.moga@microchip.com>
 <942accc5-70aa-3bb2-63dd-306a39ee5ea4@linaro.org>
 <d1aad8ea-3852-f36b-366b-7aa67d2dd9d5@microchip.com>
 <ec86420c-a210-facd-ab3a-5baf84a736f3@linaro.org>
 <0aba8906-ed30-786e-cff4-6cb70d6e73c5@linaro.org>
In-Reply-To: <0aba8906-ed30-786e-cff4-6cb70d6e73c5@linaro.org>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 663a6c08-7443-4d45-d86c-08da8c0d73fd
x-ms-traffictypediagnostic: SA1PR11MB6757:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UN7d96q9KFK0EN5MBG98C9hPQ2DGNHfbzm76QSK2GGKdSPQzOQ4/TQTYXtEUAWupYKCPVI7YphxDHyB3NGmYxmaF+AO+6a9QL5lOm3oVv637WI0y9NwFg3s8BiNy7+65OCNJLXBBBftq92wUqxltiffoCdAcLhQm9LMmCIg1BRhy9G2+71cJfNCUfXOC3Ha9RJZpCudNmK9IkQ6UBFjlVzySEli+qJQ8bjspc8Z/lQIQkEB0aHed996e7S1vJmmh12OPTX/TrF8t1/b4T6mv6YYzGafBUaz7H0BmxeyXZp5Tt13uo8R5Qk2CF820cx0HNv3o5Vi9Ydf1JDWodlVeAUBS18V8rW6t9+t918SguCh0rcr8xDB0d9rKc9nBQKVQCmIXwUU2LmXtdOJTu7OwYk0/Czt04st6AXGWX1B4FhG+8JM2XE8hcmn82s1wVy3RLwgXUJRr2n1AL/XAoWZi0IlUC1uTQfojabuustlVu0Ia3LASedzLp+ImdLl2XqgaGEsBITSH5Ujb0iKOrzHm4Vdgv56kM0mts2XXppj4fgRCo6VM/lZmpYmi+zbXssZGBlf9ZLkmOVsAEkGFoLZVfMlP+rR7CGBk7aQsLQYzUo/I0kSKCbhCvloHYrGlL0tm5L1zITIyVLACEiSJwwX4C3u2cLdWfb9xwRJ9E5DP+m3SZxxsJ4666VfIPqCBqrQ7omq/3hnUDRXVWfIvSrCuLo2gLrI81hfJflnR5CgPkUmuPSptjiroR0516/8nX6AbZxp7uSTNKqtCV/YkICPh6JTNIcEppjUmUwX3BwJrWhrnyLZC5L1uypN3Zy93VnHlSVkF1ueSwWA8fuz8/PQDJbrq4xjzz8lM3iWtZsA9Wn6y0Q58LRCcpdM8yQE2a3bp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(396003)(39860400002)(366004)(2616005)(91956017)(2906002)(71200400001)(6636002)(316002)(186003)(31686004)(53546011)(36756003)(6506007)(83380400001)(26005)(6512007)(921005)(38070700005)(86362001)(66556008)(66946007)(8936002)(6486002)(66476007)(478600001)(122000001)(7416002)(38100700002)(41300700001)(54906003)(966005)(5660300002)(64756008)(31696002)(110136005)(4326008)(66446008)(76116006)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVNOZFAzVkp6cDd4MytISlFETlJGTkZHSHg3VGNuQTM1NHFjY2xidXVkcHRZ?=
 =?utf-8?B?Q1VCZTAxa3J0RzFSRnZQTitWNXQ0S2VKeXhTQ29RZm5XSWcvSkludEZJd21S?=
 =?utf-8?B?ZEFXa1ZNRk9XQUVOZUpucURNUjdtWEJOQW4wN0Y3TUJJUHF3bXExRy84eVpl?=
 =?utf-8?B?cCt3dEtSWjYzVldLVlltMGJ0N0lSdTBSelk5bThFSFE2eWdiZW1WcW5mRnFL?=
 =?utf-8?B?eThsS25iQWxCMDlzdndYc1VRSTVnMVRIK2J2OUZYaTF0ZjN0QkdYVzNXQ1Iw?=
 =?utf-8?B?c08rK3VRVlJEZXdlY0N5N3gzc0NIL3ppZ0RuUXAzOVQxSFZVTlpzdllLbHUw?=
 =?utf-8?B?VU9ERWtHZFMrWHk4L0VFL3p0U2E0bjVBWnNLcVZJbTFhRGI4bFlmYUg0REov?=
 =?utf-8?B?dEt5bDlDdlVPN2l3UUpNZG5KeDdBZkhNNHgvQlR4YlhvV1plbmdxMkJMTCtR?=
 =?utf-8?B?SXYya1l2QTFkRkNhaDdVWUk2VVBKaVFKWUZyYUFhTDJiaVV3bW0yN0d4M0Ns?=
 =?utf-8?B?SmpwNzUyL2JkQkNUMjExb0JBVjhVQlZPSmwzVlRoYlpWS29ZR2IwWGlUM200?=
 =?utf-8?B?WHFJd2Iva1BCU0tKVVZTZSsrdGZKaEFUTVRRREYvWDROR0g4ZG0wTnBac2Fj?=
 =?utf-8?B?QUx5QS9id1RxNW1uMW53WXg5NWx6TnllbXJUUGpLMmJXRVN0QmVQaVBsUDJx?=
 =?utf-8?B?RXEzY2txc0dna2dVTC9aYWk5Um1oSC9XTmFXTUN2enErRmR2Y2RGVDFDZGxu?=
 =?utf-8?B?NEtPWkpySTJ1TitFZWR4bFNreWREbWd2VlBWOUFtNkd2bndsK0VuRkRPakM2?=
 =?utf-8?B?UkZTZVlJekszN2NER3JaYWduZTJQcmcvYkJ1Qkt5QU00Vnowcjl1S29uOW51?=
 =?utf-8?B?RUxrMEhEalFJeGs3YkorWk84NzlISDJqKzNpK0FKSHN2aExJQUJRMXVzNTZ4?=
 =?utf-8?B?SnJhYzRjeStZekZRWGNpRGZjeDZ3ZGsvRlZyQWpqM01pb2F6dGhnY0ErUGQ1?=
 =?utf-8?B?b1pmbDBVTHhnRmQvRFpVNkNQMEpJTm02Y2JNdVlPb3l5NFRGQWNoODA3cGxR?=
 =?utf-8?B?ZmxwY0ZHZ3lQandRazJMQUI2cUtaZEFOYXd6czZUMnZkV1FvUEsrcWNPRnFw?=
 =?utf-8?B?OUxNUkpWWWlMeEhHalNTQ2t0aE9rbGE2Q0cyRU02Zmxla3g0Y1lGNTJyR0lQ?=
 =?utf-8?B?T2ZkdjdBWlZRWmltUm5OaVNiMkZ5MXJkS0NlYTV5V2c3d2NNbTRkdzUySWtv?=
 =?utf-8?B?c2xmT1M5bHFkaHF1NWhqdEU4UWFoeWhTT3g0ajVVek9vUmg4bDl5czIxU0Np?=
 =?utf-8?B?dlpMUGNKeU9ZK214Q0hyV2ZudUxMSWllL3RFZ2dLajRZSjdFSVJsN0dmcXFh?=
 =?utf-8?B?VitIanJmVTMwSXowZ0VyVjVvdHNOTE9vZXhMK0xVQUQwZmUySWFlb0s2NFJi?=
 =?utf-8?B?K3dqbkZNWW9NZVh0aC95SmVKdXdvNXV1ajk5OThXSlA0dEx1OWNVekFxSlNi?=
 =?utf-8?B?MjB1c1pPZWh1QlZXMnp1eDZMZ2tORG5XdjZ5UkwvdkVXUVZoTk9NV0psSU92?=
 =?utf-8?B?NTlZNE1kVGtBTGNtTDhiR2FJWEdYMDMzWUo0dWhWbmxEVHQ3dEJRRm1UVzc1?=
 =?utf-8?B?dHloNXZTRFBNQkNMTENENlkxbTFJVXp0b2Y1RitwNVpmWXNHZmU4YUR1Mk1I?=
 =?utf-8?B?QTBnNjR1bnlrNitRYWtNYXh1d1NQdWV2YjFPOVpLbDZyZWVxdHlWc2VnSmhs?=
 =?utf-8?B?VFVtdVN0VkdUenpwUzk3bDdabUZXb0hjWkcwSUF2Qi8vQU5VL2VZaWdhTnFT?=
 =?utf-8?B?eDhLUEQ2YnNVNlMrYytYQitneXFYVVdBOVhuUm1HWllSNFlMaUVpWERPZSsr?=
 =?utf-8?B?QXJVaCtrRzVoNnpaYVg5QW9qUVUzQ3NKeVo5QmQrYzR0ZEhxbWZWYmk3TDh6?=
 =?utf-8?B?Q2ZKQThvdWtyMk1qanZIamdWWDRPampqQ2NmcG15NmwyeGpLeW5hV3hGR2tI?=
 =?utf-8?B?L3ZIWjBIRzd6MTZld1BvMTdFcE10cnNtejhUZkpFUSs5VUVyRm5LVjRJTmVW?=
 =?utf-8?B?OXFEU1dIT2QxWnZDYVBNdlJ5VlcrQzNkQ1VNa2NvM0tzY0NFNWZoTnVqSXFV?=
 =?utf-8?Q?bqFSxMBpCN8TcQUJPuZcItfRT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E31C11B6AA9CC488F57D6371D8FAFA7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663a6c08-7443-4d45-d86c-08da8c0d73fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 11:31:03.4670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dcb/t7lvre3aHfwsWnZn0SDDqcmx8/i5TVZGjr8nykwtEjvUACapn87SxjGjgtIMgRNpmmq/4WTBdKLjeTtxn4aClbXPJKHdJBgx+9dYN00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6757
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xOS8yMiAxMjowNSBQTSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMTkv
MDgvMjAyMiAxMTo0NywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+IE9uIDE5LzA4LzIw
MjIgMTE6MzgsIFNlcmdpdS5Nb2dhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4gT24gMTguMDgu
MjAyMiAxMTozOSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+Pj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4+DQo+Pj4+IE9uIDE3LzA4LzIwMjIgMTA6NTUsIFNl
cmdpdSBNb2dhIHdyb3RlOg0KPj4+Pj4gQ29udmVydCBhdDkxIFVTQVJUIERUIEJpbmRpbmcgZm9y
IEF0bWVsL01pY3JvY2hpcCBTb0NzIHRvDQo+Pj4+PiBqc29uLXNjaGVtYSBmb3JtYXQuDQo+Pj4+
Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogU2VyZ2l1IE1vZ2EgPHNlcmdpdS5tb2dhQG1pY3JvY2hp
cC5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+ICAgIC4uLi9iaW5kaW5ncy9tZmQvYXRtZWwsYXQ5MS11
c2FydC55YW1sICAgICAgICB8IDE5MCArKysrKysrKysrKysrKysrKysNCj4+Pj4+ICAgIC4uLi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbC11c2FydC50eHQgICB8ICA5OCAtLS0tLS0tLS0N
Cj4+Pj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgMTkwIGluc2VydGlvbnMoKyksIDk4IGRlbGV0aW9u
cygtKQ0KPj4+Pj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZmQvYXRtZWwsYXQ5MS11c2FydC55YW1sDQo+Pj4+PiAgICBkZWxldGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbC11c2Fy
dC50eHQNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21mZC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLGF0OTEtdXNhcnQueWFtbA0KPj4+Pj4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4+Pj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uY2YxNWQ3M2ZhMWU4DQo+Pj4+
PiAtLS0gL2Rldi9udWxsDQo+Pj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWZkL2F0bWVsLGF0OTEtdXNhcnQueWFtbA0KPj4+PiBPbmUgbW9yZSB0aGluZyAtIEkg
dGhpbmsgdGhpcyBzaG91bGQgYmUgaW4gc2VyaWFsIGRpcmVjdG9yeSwgbm90IG1mZCwNCj4+Pj4g
ZXZlbiB0aG91Z2ggaXQgaW5jbHVkZXMgU1BJLiBNRkQgaXMganVzdCBhIExpbnV4IG5hbWluZy93
cmFwcGVyIGRldmljZS4NCj4+Pj4NCj4+Pj4gQmVzdCByZWdhcmRzLA0KPj4+PiBLcnp5c3p0b2YN
Cj4+Pg0KPj4+IEkgd291bGQgcmF0aGVyIGtlZXAgaXQgaW4gdGhpcyBkaXJlY3RvcnksIHNpbmNl
IGl0cyBjb3JyZXNwb25kaW5nIGRyaXZlcg0KPj4+IGlzIGFsc28gaW4gdGhlIG1mZCBkaXJlY3Rv
cnkuDQo+Pg0KPj4gU29ycnksIGJ1dCB0aGF0J3MgcG9vciBhcmd1bWVudC4gRHJpdmVyIHN1YnN5
c3RlbXMgbWF0Y2ggTGludXgNCj4+IGNvbnZlbnRpb24sIG5vdCBuZWNlc3NhcmlseSBoYXJkd2Fy
ZSB0eXBlL25hbWluZy4gQmluZGluZ3MgZGlyZWN0b3JpZXMNCj4+IG1hdGNoIGhhcmR3YXJlLiBN
RkQgYmluZGluZ3MgYXJlIG9ubHkgZm9yIE1GRCB3cmFwcGVyIGRyaXZlcnMgYW5kIHRoaXMNCj4+
IGlzIGEgc2VyaWFsIGludGVyZmFjZS4gTm90IGEgTUZELiBZb3UgZXZlbiBkbyBub3QgYWRkIE1G
RCBkZXZpY2VzIGluIHRoZQ0KPj4gZHJpdmVyIGJ1dCBhZGQgKmFsd2F5cyBvbmUqIGRldmljZSBk
ZXBlbmRpbmcgb24gc2VyaWFsIGZlYXR1cmUgeW91IHdhbnQuDQo+PiBUaGlzIGlzIG5vdCBldmVu
IE1GRCBkZXZpY2UgYnV0IHJlZ3VsYXIgcGxhdGZvcm0gZGV2aWNlIHdpdGggY2hpbGRyZW4uDQo+
Pg0KPj4gWW91IHB1dCBpdCBpbiBTb0MsIHRob3VnaCwgYmVjYXVzZSBhbGwgb3RoZXIgU29DcyBz
dG9yZSBpdCB0aGVyZS4uLg0KPiANCj4gVGhlIGxhc3Qgb25lIHNob3VsZCBiZToNCj4gDQo+IFlv
dSBjb3VsZCBwdXQgaXQgaW4gU29DLCB0aG91Z2gsIGJlY2F1c2UgYWxsIG90aGVyIFNvQ3Mgc3Rv
cmUgaXQgdGhlcmUuLi4NCg0KSGksDQoNCklmIGl0IHRoaXMgaXMgb25seSBhIGNvbnZlcnNpb24g
dG8geWFtbCwgd2h5IGRvIHlvdSB3YW50IGl0IG1vdmVkIHRvIA0KYW5vdGhlciBkaXIgPw0KUGVy
aGFwcyBpZiB5b3UgY29uc2lkZXIgU29DIG9yIHNlcmlhbCBhcyBhIGJldHRlciBwbGFjZSwgaXQg
c2hvdWxkIGJlIA0KZG9uZSB0aHJvdWdoIGEgZGlmZmVyZW50IHBhdGNoLg0KDQpBbHNvLCBkaXNw
dXRpbmcgd2hldGhlciB0aGlzIGlzIHJlYWxseSBhIE1GRCBvciBub3QsIGlzIG5vdCBpbiB0aGUg
c2NvcGUgDQpvZiB0aGlzIHBhdGNoLg0KDQpFdWdlbg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IEtyenlzenRvZg0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0KPiANCg0K
