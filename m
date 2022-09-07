Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76135B0290
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiIGLL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiIGLLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:11:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245766451;
        Wed,  7 Sep 2022 04:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662549111; x=1694085111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=usfGbZEU0GOk+i4e+WdHJV5BzX2KfyYWNaZKIhsHj88=;
  b=ndOqf0Y6bJwi+639i42m1+TYS8Cu5BNl5DnH5ch6aR80CijnsuccetpM
   LlLfiC1XjulrFyGvdh0SC2VN1YXX9dxGTMmrtVxCCg/uPq1AWLsQ+UHbh
   PBjdBOxlPHYB6gGJDAImgxLLhAv+qmq1sXNPk56POkaBAum5n7p7fY+EM
   DkbtNudcCEVeVSm6I4kaWyQ3B8xn7DQnPVk8mkUiyA7uxCykc9hNHoESI
   p8AwarWlRD7mrvb50qCKY8DXDXYfo9aNxXoB/exP9s4OsVPpnnnIcIylv
   J/OwfT+DY4OiyKjgOq1G+46qsRnA8i+Rblzuk13x+ItMa+TU0Kqhqk3NA
   w==;
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="172743956"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 04:11:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 04:11:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 7 Sep 2022 04:11:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjKLb3WI/GPngJ4O6TE9gQ1lTJL8PoGr1I1b72aOQO3cdzlxW45o2RizzriuCR/XKB76HcsWPaLk+QJ5N3vlIdDOOnFE9Ags1hYvbjOmqDXjfMO2+e32fHlfy197jbkMY5cw74z9bT0Tu4gBJwg8MKGkKOK7lgAtlEnMbUEGLXvfIWtAirCq+QLAz9xBYgM2/wtRYchsF+CHCTlJ3Xz5DUXLdS2ajcCnbxop5KzMMA8JfswEqi3C+x3HcIJ0aKCvA4qZIYzIZcKv/jFqpuNJZ013rnp9Z/lwgcqKkoywxtWv22dh8Cic0T18coR8drd8fPzfBy5cx1GnAVOaMXIe/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usfGbZEU0GOk+i4e+WdHJV5BzX2KfyYWNaZKIhsHj88=;
 b=XqfeGKKScakLU5ag3FQq7wtaL8DCO6/zWjLCXXs7HeUiritX2swjgIo83Z6pRwqcj2IClfOatsaoGwFSBbtwmQ2oMfgbPwN/aoPhz703NJuqUJJoCIMQRSjFlZtAmoqp0//t64/AjzcU/hDu97/T2DBWV1y+InRbg90jcUClkYyAp1yNfWzcL2qzHjm0oOpOexV9lsOCS2+/K9x1+3nOyYGchSsXwUOZD/F4tGwDvQfvW8HP85gwaUz8o0F+sEQpbD65xeKJOzdxitd0Cw+p++0xQjHTlmMUwh9eSXHb27dMN8bPeWE6JmDoyW6SsyufVqD3e1U8JwwqIN9qNQR+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usfGbZEU0GOk+i4e+WdHJV5BzX2KfyYWNaZKIhsHj88=;
 b=twyhoOrSDE2Ctw2HtBoXYvrR670Rt/WSvTxqJp5wsqihhojk7RnYc2Qd4UXRyLf+A8lLB9VBISNxLWAXYXblwDCBGnwDAW+5oyPVFZAFk2TBZietXe6NIvNoY7qu0hQ3RcimmsIAJ1xCsrZMUyvPNRw1EFTOjg5Ki4ESX1umV8w=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by MW4PR11MB7055.namprd11.prod.outlook.com (2603:10b6:303:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 11:11:43 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4%7]) with mapi id 15.20.5588.014; Wed, 7 Sep 2022
 11:11:43 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <ilpo.jarvinen@linux.intel.com>
CC:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <richard.genoud@gmail.com>, <radu_nicolae.pirea@upb.ro>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Tudor.Ambarus@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 12/13] tty: serial: atmel: Make the driver aware of the
 existence of GCLK
Thread-Topic: [PATCH v2 12/13] tty: serial: atmel: Make the driver aware of
 the existence of GCLK
Thread-Index: AQHYwfilYklHG7CAIEy/Vao1N5SW/63TtqMAgAAaqYA=
Date:   Wed, 7 Sep 2022 11:11:43 +0000
Message-ID: <f3e87d18-41aa-f1e2-e0fb-8944c9fb4910@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-13-sergiu.moga@microchip.com>
 <3f98d634-789-a0bd-84e-cfc2a1de70af@linux.intel.com>
In-Reply-To: <3f98d634-789-a0bd-84e-cfc2a1de70af@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05fe1222-bd0b-4c7e-b293-08da90c1bf03
x-ms-traffictypediagnostic: MW4PR11MB7055:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dpdAfu2oQoz4wPYG65rS7avmqm+nEVp6o5W7GXZC8on1+x9peChxqqXHAgF1jSGVjEWf/HAWMtsssyWf3fU39ZuyOweyvVQMqQ6wRnAYaglTgTxzKpqYEA61RPJDJuCroRZAGQcoPOt3lot1jOobN4EArXsO8ehNAq3Q7S2TsiSRhubuNwpYBH0I73ICFend6kAaWo0/CqQHbxUBz/Bzn+zJzkJ8qH8kBjgnKRVuQ/LQ+uLTHK8UVDWZtIx7sc6sxg3I9rLgLJQCE0/jsbOs7FMgNCiaF/O38UOwZyqi5aSIN5T9kvNWVHaZmLYV8gA1mpn5+M4oPbFdRJ2w6VMN8ltyiQnJJzFOgMV5pq2WWmbwgpzrB2kI9YxA6CyNdXIKkLHDFI3UnVeXnKSJGk+/O3QNSUDt3lUiZQMKenpFVhIIk5Hp969kXjDGE8byT/yF4jVl+ek1Vv2u1AfqzuOQZFAK96cyzBHGCCVz6Lexr7wuYrNLqUg4fBcV/XF2b4vWosw/nUakuO+cTUWW2YeszD2WHz6L89xD2CwkWIzRnbvkS/Z3x9tQJgZcjIqjsrYbUtR0S1tz3MAWmO5yAtb/+gpfXcjHm4A6UrjhtDdkc3r7SXQP8OWdauqphyltTrZQsSrbPHmwdnJFg5EPZwfCUEvwvV71N68bU1Axbvl5/9Rz+rHg7VP9ygMwo4Hxn4SipkMOinFItweLN/9LsGXDvO7FcNGGSOUK7wVf0WFO3oMle3CMmlYLZeBuZcUg15KgFnFixYMwePW1DEeFyU7Do/T/e6t3FcinhV0vlEFeiCE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(136003)(396003)(39860400002)(8936002)(6512007)(76116006)(83380400001)(4326008)(6916009)(91956017)(6486002)(8676002)(316002)(478600001)(66556008)(71200400001)(66476007)(54906003)(64756008)(5660300002)(7416002)(2906002)(66446008)(38070700005)(66946007)(122000001)(31686004)(53546011)(86362001)(38100700002)(36756003)(31696002)(2616005)(186003)(26005)(6506007)(66574015)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUJCY25CYm83bERsSjBVTDNUNWRhTXJDbmpQU0tvU2hzZmZZd1VBbTVnMmdr?=
 =?utf-8?B?STBuUTJ2Mlhid3JKZkNGb3UxbnBlOTZGM3VBUkRsWUtUVjRhU3FKYk5IZE9o?=
 =?utf-8?B?VlpWaHV1ekNOS0VJeDNOcEJhQkhhVlZ4R29TMkRuK25GWnpoNU9lQk5zVnY5?=
 =?utf-8?B?eVVMdjJEMElXc1pOVXdQMGdOemJyakJQU0dlUllmUUQrazJKT3hWZHZkbG5V?=
 =?utf-8?B?RTREbVFRQ2RNOU9xSFFvYjJidHd6WVNJRW5jbVA3b3gyWWV5eFNLcFA4K0FK?=
 =?utf-8?B?ODNZWHVTUHhvMmZmQjR3bUJucWJPYWZxelhnWEF1dDF6N1lrbkVXc2RlYXl4?=
 =?utf-8?B?RHlLNXRxRFN1TU9Ld00rUExyQTRkZHBVbEhpSXRHc0FXb0tTWGtaL05IK2lV?=
 =?utf-8?B?WEpwbC85MFpuL2VXYmd4RFJyWDk2bGZYQ0NpdzVYanR0cEx5MUVIUHQ3VDZP?=
 =?utf-8?B?U3lzU0hIK1hSMXp1aU94d0FXV1p2bmR4K2ttUFBsQWJoUlpWZDhmNy9EcERQ?=
 =?utf-8?B?TjFTNnlVTmcweHJ1MHRrZHR4NlRoTU9RNTVSQU82d0llOExZeEFVMVI1eXFu?=
 =?utf-8?B?RnJFdXk1SWZiV0RKNDZhRDRFY0Zya0NxcUwrWGQ0ekd4Y2lMUFBrZ0UzZGxm?=
 =?utf-8?B?R01zSU10bHVySVpyZjZYbkVWS0ZGdkd1aGdzWUl1ckxNRWJ0MTVsS2FNWEh3?=
 =?utf-8?B?ekRadHFLWXRwSStkNkJsRVNqVkZxdGZMdFhHWHJycUc0a0lQemdyTWQ5bkRW?=
 =?utf-8?B?aEFRa3RBd2ttKzl6NHUzQkJsSVhpdHBqbUVyZlR5NzVrZ0EzV0t4OHNlYlhu?=
 =?utf-8?B?ZlZIdjZXVUNveHF2b3JSWGFKQXN2TjZURDhmQmluU3EvVkxRUDdIUm9HZXAx?=
 =?utf-8?B?cVZldDNJeGlHU0wxM1IyMDdKU3lrZzFyZW03d0xlWlFkWERNUm5lV2xkajBB?=
 =?utf-8?B?Z0ZIaFNUbk9UbHRxSEtUSnczYURxQWpvMHF4aGY1MlVkNlplTkxUWGhXa3RE?=
 =?utf-8?B?UlB0elB3Tk1sQ3lFS0ZWaUNRdE5qdko3dTRFSHhFZDk3NlhLaUFCSDlBeTJz?=
 =?utf-8?B?UWlOdmpLYVJDN2gxR0xMOSt6NHQ5RDBTSEI4R0NaS0RQdDFFNUlFYXBDeHlV?=
 =?utf-8?B?OVU5eENlTFVSZFQ3LzRDZkZ1ZlluLzlFaXIydVkvNldOb1gwL1dXMG9RbHFY?=
 =?utf-8?B?TTlFVFdjRHpHSzlyd2kwdE5aZk5DZk1NQVcybHRuYVp2S3U0b2x6VjUzbXhP?=
 =?utf-8?B?dzcxNWpHNi9KdFRWV0ZwUTJOc1ozaFZWNnAySjVIS0YySDJBNTlheHY1RW9p?=
 =?utf-8?B?NElVWlY3NDZwS1JyZGdYQlFYUTRSTEloSWJKdHZWd3Q5UVpZdG9GdWVpck5C?=
 =?utf-8?B?aTY1c0NITnhPT1l5WldycXBGRmR5VzJubmMyRTFWZjcveGdxUVdkWXZPRENu?=
 =?utf-8?B?U0lDaEpIYkM4OGRQSjA3c25GWkxJTGIwUUtjdEltc3hSckpsb2tlOEh2N2Mw?=
 =?utf-8?B?a2NaVjExNlNCQUE0WGZWVWJ1ZVhZS2FydjZKVEgyMGVqaTFTSGxvb1g5L3Fa?=
 =?utf-8?B?MHcySkZoVTdoZHZPTlBaai90OURORjlBelJKWnpKZzd2USsyOEw0UDg4R29Q?=
 =?utf-8?B?TDNqdlBkdCsrdjdnSjhkLzhuczNUckR0SjkxYmlORThBQUwwcDRXTFF1eFQ4?=
 =?utf-8?B?NU9lVXQyd2RXWEh6a1dNZDlFWXV3aFd0dHJWdEdrT2VRcUFMTXcrbjBtTGhU?=
 =?utf-8?B?WHVrVXZCQXpwSktLaHMyYWY4anUvOGdaNUtuS25PQS92ZXRFbHJ2L2N5WW14?=
 =?utf-8?B?K3hEMXprRmwwRVhwaDF6a3l4Q01DbnM0VUNjeGZHTFA4Qk95dDZzeDVyNUJY?=
 =?utf-8?B?N2RIM05HV2dPenFaRkFKMm5nbHlueXdraThxak9SOXA5bzlzR0dJQmxIbkNp?=
 =?utf-8?B?by9FcUdLVisrRWdsbm9la3hlUEFwTUJLRHR4by9wZ21oUmRPeHNFcXRyK0pt?=
 =?utf-8?B?cXIwV3RCSHc4YkduWTBxR0trZ1FqczZncXovb3pFL2FwOU5jK2VmcVlDTGY0?=
 =?utf-8?B?c1NFR0tLZ08xMkwzQ0llTCtocG04a3lidFhEei8vTm9UekIvZ3ZIT0hZQXVU?=
 =?utf-8?Q?Zo51AqAqyyfJVOSxwQnBvWLvn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A10F3E8448CC6444B1E04B56FC5D6869@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fe1222-bd0b-4c7e-b293-08da90c1bf03
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 11:11:43.3812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ce+COLW/pHvtgY0z2kxYYLKVqM3DbsDvu4M1cZDfHIeRAYkqBRcGBP7CWTTd0O92e+7KvSuDB+FmtpqY8Yd0WoPYSWVkSgeVnBV1zD/M6Mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7055
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDkuMjAyMiAxMjozNiwgSWxwbyBKw6RydmluZW4gd3JvdGU6DQo+IE9uIFR1ZSwgNiBT
ZXAgMjAyMiwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+IA0KPj4gUHJldmlvdXNseSwgdGhlIGF0bWVs
IHNlcmlhbCBkcml2ZXIgZGlkIG5vdCB0YWtlIGludG8gYWNjb3VudCB0aGUNCj4+IHBvc3NpYmls
aXR5IG9mIHVzaW5nIHRoZSBtb3JlIGN1c3RvbWl6YWJsZSBnZW5lcmljIGNsb2NrIGFzIGl0cw0K
Pj4gYmF1ZHJhdGUgZ2VuZXJhdG9yLiBVbmxlc3MgdGhlcmUgaXMgYSBGcmFjdGlvbmFsIFBhcnQg
YXZhaWxhYmxlIHRvDQo+PiBpbmNyZWFzZSBhY2N1cmFjeSwgdGhlcmUgaXMgYSBoaWdoIGNoYW5j
ZSB0aGF0IHdlIG1heSBiZSBhYmxlIHRvDQo+PiBnZW5lcmF0ZSBhIGJhdWRyYXRlIGNsb3NlciB0
byB0aGUgZGVzaXJlZCBvbmUgYnkgdXNpbmcgdGhlIEdDTEsgYXMgdGhlDQo+PiBjbG9jayBzb3Vy
Y2UuIE5vdywgZGVwZW5kaW5nIG9uIHRoZSBlcnJvciByYXRlIGJldHdlZW4NCj4+IHRoZSBkZXNp
cmVkIGJhdWRyYXRlIGFuZCB0aGUgYWN0dWFsIGJhdWRyYXRlLCB0aGUgc2VyaWFsIGRyaXZlciB3
aWxsDQo+PiBmYWxsYmFjayBvbiB0aGUgZ2VuZXJpYyBjbG9jay4gVGhlIGdlbmVyaWMgY2xvY2sg
bXVzdCBiZSBwcm92aWRlZA0KPj4gaW4gdGhlIERUIG5vZGUgb2YgdGhlIHNlcmlhbCB0aGF0IG1h
eSBuZWVkIGEgbW9yZSBmbGV4aWJsZSBjbG9jayBzb3VyY2UuDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogU2VyZ2l1IE1vZ2EgPHNlcmdpdS5tb2dhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+DQo+
Pg0KPj4NCj4+IHYxIC0+IHYyOg0KPj4gLSB0YWtlIGludG8gYWNjb3VudCB0aGUgZGlmZmVyZW50
IHBsYWNlbWVudCBvZiB0aGUgYmF1ZHJhdGUgY2xvY2sgc291cmNlDQo+PiBpbnRvIHRoZSBJUCdz
IE1vZGUgUmVnaXN0ZXIgKFVTQVJUIHZzIFVBUlQpDQo+PiAtIGRvbid0IGNoZWNrIGZvciBhdG1l
bF9wb3J0LT5nY2xrICE9IE5VTEwNCj4+IC0gdXNlIGNsa19yb3VuZF9yYXRlIGluc3RlYWQgb2Yg
Y2xrX3NldF9yYXRlICsgY2xrX2dldF9yYXRlDQo+PiAtIHJlbW92ZSBjbGtfZGlzYWJsZV91bnBy
ZXBhcmUgZnJvbSB0aGUgZW5kIG9mIHRoZSBwcm9iZSBtZXRob2QNCj4+DQo+Pg0KPj4NCj4+ICAg
ZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jIHwgNTIgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxf
c2VyaWFsLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4+IGluZGV4IDZh
YTAxY2E1NDg5Yy4uYjJiNmZkNmVhMmE1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy90dHkvc2Vy
aWFsL2F0bWVsX3NlcmlhbC5jDQo+PiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2Vy
aWFsLmMNCj4+IEBAIC0xNSw2ICsxNSw3IEBADQo+PiAgICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+
DQo+PiAgICNpbmNsdWRlIDxsaW51eC9zZXJpYWwuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L2Ns
ay5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9jbGstcHJvdmlkZXIuaD4NCj4+ICAgI2luY2x1ZGUg
PGxpbnV4L2NvbnNvbGUuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L3N5c3JxLmg+DQo+PiAgICNp
bmNsdWRlIDxsaW51eC90dHlfZmxpcC5oPg0KPj4gQEAgLTc3LDYgKzc4LDggQEAgc3RhdGljIHZv
aWQgYXRtZWxfc3RvcF9yeChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KTsNCj4+ICAgI2VuZGlmDQo+
Pg0KPj4gICAjZGVmaW5lIEFUTUVMX0lTUl9QQVNTX0xJTUlUIDI1Ng0KPj4gKyNkZWZpbmUgRVJS
T1JfUkFURShkZXNpcmVkX3ZhbHVlLCBhY3R1YWxfdmFsdWUpIFwNCj4+ICsgICAgICgoaW50KSgx
MDAgLSAoKGRlc2lyZWRfdmFsdWUpICogMTAwKSAvIChhY3R1YWxfdmFsdWUpKSkNCj4gDQo+IE1h
a2UgYSBmdW5jdGlvbiBpbnN0ZWFkLg0KPiANCg0KDQpBbHJpZ2h0LCBJIHNlZSB0aGUgcG9pbnQg
b2YgbWFraW5nIGl0IGFuIGlubGluZSBmdW5jdGlvbiBpbnN0ZWFkLg0KDQoNCj4gSXMgcGVyY2Vu
dCBhY2N1cmF0ZSBlbm91Z2ggb3Igd291bGQgeW91IHBlcmhhcHMgd2FudCBzb21ldGhpbmcgc2xp
Z2h0bHkNCj4gbW9yZSBhY2N1cmF0ZT8NCj4gDQoNCg0KSXQgaXMgYWNjdXJhdGUgZW5vdWdoIGZv
ciB0aGUgYWxsIHRoZSBiYXVkcmF0ZXMgSSBoYXZlIHRlc3RlZC4gSXQgDQp1c3VhbGx5IHRhcHMg
aW50byB0aGUgR0NMSyB3aGVuZXZlciBoaWdoIGJhdWRyYXRlcyBzdWNoIGFzIDkyMTYwMCBhcmUg
DQp1c2VkLiBGb3IgMTE1MjAwIGZvciBleGFtcGxlLCB0aGUgZXJyb3IgcmF0ZSB3YXMgc2xpZ2h0
bHkgYmV0dGVyIGluIHRoZSANCmNhc2Ugb2YgdGhlIHBlcmlwaGVyYWwgY2xvY2sgYW5kIGl0IGFj
dGVkIGFjY29yZGluZ2x5LCBjaG9vc2luZyB0aGUgDQpsYXR0ZXIgYXMgaXRzIGJhdWRyYXRlIHNv
dXJjZSBjbG9jay4gSSBkbyBub3QgdGhpbmsgdGhhdCBhIGhpZ2hlciANCmFjY3VyYWN5IHRoYW4g
dGhpcyB3b3VsZCBiZSBuZWVkZWQgdGhvdWdoLiBTYXkgdGhhdCB1c2luZyBwZXJjZW50IA0KYWNj
dXJhY3kgeWllbGRzIHRoYXQgdGhlIGVycm9yIHJhdGVzIGFyZSBlcXVhbCwgYnV0IHRoZSBnY2xr
IHdvdWxkIGhhdmUgDQpiZWVuIGJldHRlciBpbiB0aGlzIGNhc2UgYnksIHNheSwgYSBmZXcgMTAg
XiAtNCwgYnV0IHRoZSBjb2RlIGxvZ2ljIGRvZXMgDQpub3Qgc2VlIGl0IHNvIGl0IHByb2NlZWRz
IHVzaW5nIHRoZSBwZXJpcGhlcmFsIGNsb2NrLiBJbiB0aGF0IGNhc2UsIHRoZSANCmVycm9yIHJh
dGUgb2YgdGhlIHBlcmlwaGVyYWwgY2xvY2sgd291bGQgc3RpbGwgYmUgbG93IGVub3VnaCByZWxh
dGl2ZSB0byANCnRoZSBkZXNpcmVkIGJhdWRyYXRlIGZvciB0aGUgY29tbXVuaWNhdGlvbiB0byBm
dW5jdGlvbiBwcm9wZXJseS4NCg0KVGhlIGhpZ2hlciB0aGUgYmF1ZHJhdGUsIHRoZSBsb3dlciB0
aGUgZXJyb3IgcmF0ZSBtdXN0IGJlIGluIG9yZGVyIGZvciANCnRoaW5ncyB0byBnbyBzbW9vdGhs
eS4gRm9yIGV4YW1wbGUsIGZvciBhIGJhdWRyYXRlIG9mIDU3NjAwIEkgbm90aWNlZCANCnRoYXQg
ZXZlbiBhbiBlcnJvciByYXRlIGFzIGJpZyBhcyA2JSBpcyBzdGlsbCBlbm91Z2ggZm9yIHRoZSAN
CmNvbW11bmljYXRpb24gdG8gd29yayBwcm9wZXJseSwgd2hpbGUgaW4gdGhlIGNhc2Ugb2YgOTIx
NjAwIGFueXRoaW5nIA0KYmlnZ2VyIHRoYW4gMiUgYW5kIHRoaW5ncyBkbyBub3QgZ28gc21vb3Ro
bHkgYW55bW9yZS4gU28gSSBndWVzcyB0aGF0IGl0IA0Kd291bGQgYmUgc2FmZSB0byBzYXkgdGhh
dCwgdW5sZXNzIHlvdSBnbyBmb3IgYmF1ZHJhdGVzIGFzIGhpZ2ggYXMgdGVucyANCm9mIG1pbGxp
b25zLCB0aGluZ3Mgc2hvdWxkIHdvcmsgd2VsbCB3aXRoIGp1c3QgcGVyY2VudCBhY2N1cmFjeS4g
QSANCmhpZ2hlciBhY2N1cmFjeSBhbHdheXMgZGVmaW5ldGVseSBoZWxwcywgYnV0IEkgYmVsaWV2
ZSBpdCBpcyBub3QgbmVlZGVkIA0KaW4gdGhpcyBjYXNlLg0KDQoNCj4gR2l2ZW4geW91J3ZlIGFi
cygpIGF0IHRoZSBjYWxsZXIgc2lkZSwgdGhlIGVycm9yIHJhdGUgY291bGQgYmUNCj4gdW5kZXJl
c3RpbWF0ZWQsIGlzIHVuZGVyZXN0aW1hdGluZyBPSz8NCj4gDQoNCg0KWWVzLCB0aGlzIHNob3Vs
ZCBiZSBmaW5lLiBXaGlsZSAoYm90aCBlbXBpcmljYWxseSBhbmQgYWZ0ZXIgbG9va2luZyANCnN0
dWZmIHVwKSBJIG5vdGljZWQgdGhhdCBpbiB0aGUgY2FzZSBvZiBuZWdhdGl2ZSBlcnJvciByYXRl
cywgdGhlaXIgDQphYnNvbHV0ZSB2YWx1ZSBuZWVkcyB0byBiZSBzbWFsbGVyIHRoYW4gdGhlIG9u
ZSBvZiBwb3NpdGl2ZSBlcnJvciByYXRlcywgDQppdCBtdXN0IGJlIHNvIGJ5IGEgdmVyeSBzbWFs
bCBtYXJnaW4gdGhhdCBpcyBuZWdsaWdpYmxlIHdoZW4gZXN0aW1hdGluZyANCnRocm91Z2ggcGVy
Y2VudCBhY2N1cmFjeS4NCg0KDQo+IC0tDQo+ICAgaS4NCj4gDQo+PiAgIHN0cnVjdCBhdG1lbF9k
bWFfYnVmZmVyIHsNCj4+ICAgICAgICB1bnNpZ25lZCBjaGFyICAgKmJ1ZjsNCj4+IEBAIC0xMTAs
NiArMTEzLDcgQEAgc3RydWN0IGF0bWVsX3VhcnRfY2hhciB7DQo+PiAgIHN0cnVjdCBhdG1lbF91
YXJ0X3BvcnQgew0KPj4gICAgICAgIHN0cnVjdCB1YXJ0X3BvcnQgICAgICAgIHVhcnQ7ICAgICAg
ICAgICAvKiB1YXJ0ICovDQo+PiAgICAgICAgc3RydWN0IGNsayAgICAgICAgICAgICAgKmNsazsg
ICAgICAgICAgIC8qIHVhcnQgY2xvY2sgKi8NCj4+ICsgICAgIHN0cnVjdCBjbGsgICAgICAgICAg
ICAgICpnY2xrOyAgICAgICAgICAvKiB1YXJ0IGdlbmVyaWMgY2xvY2sgKi8NCj4+ICAgICAgICBp
bnQgICAgICAgICAgICAgICAgICAgICBtYXlfd2FrZXVwOyAgICAgLyogY2FjaGVkIHZhbHVlIG9m
IGRldmljZV9tYXlfd2FrZXVwIGZvciB0aW1lcyB3ZSBuZWVkIHRvIGRpc2FibGUgaXQgKi8NCj4+
ICAgICAgICB1MzIgICAgICAgICAgICAgICAgICAgICBiYWNrdXBfaW1yOyAgICAgLyogSU1SIHNh
dmVkIGR1cmluZyBzdXNwZW5kICovDQo+PiAgICAgICAgaW50ICAgICAgICAgICAgICAgICAgICAg
YnJlYWtfYWN0aXZlOyAgIC8qIGJyZWFrIGJlaW5nIHJlY2VpdmVkICovDQo+PiBAQCAtMjExNyw2
ICsyMTIxLDggQEAgc3RhdGljIHZvaWQgYXRtZWxfc2VyaWFsX3BtKHN0cnVjdCB1YXJ0X3BvcnQg
KnBvcnQsIHVuc2lnbmVkIGludCBzdGF0ZSwNCj4+ICAgICAgICAgICAgICAgICAqIFRoaXMgaXMg
Y2FsbGVkIG9uIHVhcnRfY2xvc2UoKSBvciBhIHN1c3BlbmQgZXZlbnQuDQo+PiAgICAgICAgICAg
ICAgICAgKi8NCj4+ICAgICAgICAgICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShhdG1lbF9w
b3J0LT5jbGspOw0KPj4gKyAgICAgICAgICAgICBpZiAoX19jbGtfaXNfZW5hYmxlZChhdG1lbF9w
b3J0LT5nY2xrKSkNCj4+ICsgICAgICAgICAgICAgICAgICAgICBjbGtfZGlzYWJsZV91bnByZXBh
cmUoYXRtZWxfcG9ydC0+Z2Nsayk7DQo+PiAgICAgICAgICAgICAgICBicmVhazsNCj4+ICAgICAg
ICBkZWZhdWx0Og0KPj4gICAgICAgICAgICAgICAgZGV2X2Vycihwb3J0LT5kZXYsICJhdG1lbF9z
ZXJpYWw6IHVua25vd24gcG0gJWRcbiIsIHN0YXRlKTsNCj4+IEBAIC0yMTMxLDcgKzIxMzcsOCBA
QCBzdGF0aWMgdm9pZCBhdG1lbF9zZXRfdGVybWlvcyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBz
dHJ1Y3Qga3Rlcm1pb3MgKnRlcm1pb3MsDQo+PiAgIHsNCj4+ICAgICAgICBzdHJ1Y3QgYXRtZWxf
dWFydF9wb3J0ICphdG1lbF9wb3J0ID0gdG9fYXRtZWxfdWFydF9wb3J0KHBvcnQpOw0KPj4gICAg
ICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+PiAtICAgICB1bnNpZ25lZCBpbnQgb2xkX21vZGUs
IG1vZGUsIGltciwgcXVvdCwgYmF1ZCwgZGl2LCBjZCwgZnAgPSAwOw0KPj4gKyAgICAgdW5zaWdu
ZWQgaW50IG9sZF9tb2RlLCBtb2RlLCBpbXIsIHF1b3QsIGRpdiwgY2QsIGZwID0gMDsNCj4+ICsg
ICAgIHVuc2lnbmVkIGludCBiYXVkLCBhY3R1YWxfYmF1ZCwgZ2Nsa19yYXRlOw0KPj4NCj4+ICAg
ICAgICAvKiBzYXZlIHRoZSBjdXJyZW50IG1vZGUgcmVnaXN0ZXIgKi8NCj4+ICAgICAgICBtb2Rl
ID0gb2xkX21vZGUgPSBhdG1lbF91YXJ0X3JlYWRsKHBvcnQsIEFUTUVMX1VTX01SKTsNCj4+IEBA
IC0yMjk3LDYgKzIzMDQsNDMgQEAgc3RhdGljIHZvaWQgYXRtZWxfc2V0X3Rlcm1pb3Moc3RydWN0
IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0ZXJtaW9zICp0ZXJtaW9zLA0KPj4gICAgICAgICAg
ICAgICAgY2QgJj0gNjU1MzU7DQo+PiAgICAgICAgfQ0KPj4NCj4+ICsgICAgIC8qDQo+PiArICAg
ICAgKiBJZiB0aGVyZSBpcyBubyBGcmFjdGlvbmFsIFBhcnQsIHRoZXJlIGlzIGEgaGlnaCBjaGFu
Y2UgdGhhdA0KPj4gKyAgICAgICogd2UgbWF5IGJlIGFibGUgdG8gZ2VuZXJhdGUgYSBiYXVkcmF0
ZSBjbG9zZXIgdG8gdGhlIGRlc2lyZWQgb25lDQo+PiArICAgICAgKiBpZiB3ZSB1c2UgdGhlIEdD
TEsgYXMgdGhlIGNsb2NrIHNvdXJjZSBkcml2aW5nIHRoZSBiYXVkcmF0ZQ0KPj4gKyAgICAgICog
Z2VuZXJhdG9yLg0KPj4gKyAgICAgICovDQo+PiArICAgICBpZiAoIWF0bWVsX3BvcnQtPmhhc19m
cmFjX2JhdWRyYXRlKSB7DQo+PiArICAgICAgICAgICAgIGlmIChfX2Nsa19pc19lbmFibGVkKGF0
bWVsX3BvcnQtPmdjbGspKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGNsa19kaXNhYmxlX3Vu
cHJlcGFyZShhdG1lbF9wb3J0LT5nY2xrKTsNCj4+ICsgICAgICAgICAgICAgZ2Nsa19yYXRlID0g
Y2xrX3JvdW5kX3JhdGUoYXRtZWxfcG9ydC0+Z2NsaywgMTYgKiBiYXVkKTsNCj4+ICsgICAgICAg
ICAgICAgYWN0dWFsX2JhdWQgPSBjbGtfZ2V0X3JhdGUoYXRtZWxfcG9ydC0+Y2xrKSAvICgxNiAq
IGNkKTsNCj4+ICsgICAgICAgICAgICAgaWYgKGdjbGtfcmF0ZSAmJiBhYnMoRVJST1JfUkFURShi
YXVkLCBhY3R1YWxfYmF1ZCkpID4NCj4+ICsgICAgICAgICAgICAgICAgIGFicyhFUlJPUl9SQVRF
KGJhdWQsIGdjbGtfcmF0ZSAvIDE2KSkpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBjbGtf
c2V0X3JhdGUoYXRtZWxfcG9ydC0+Z2NsaywgMTYgKiBiYXVkKTsNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICBpZiAoIWNsa19wcmVwYXJlX2VuYWJsZShhdG1lbF9wb3J0LT5nY2xrKSkgew0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGF0bWVsX3BvcnQtPmlzX3VzYXJ0KSB7
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1vZGUgJj0gfkFUTUVM
X1VTX1VTQ0xLUzsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbW9k
ZSB8PSBBVE1FTF9VU19VU0NMS1NfR0NMSzsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIH0gZWxzZSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1v
ZGUgJj0gfkFUTUVMX1VBX0JSU1JDQ0s7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG1vZGUgfD0gQVRNRUxfVUFfQlJTUkNDS19HQ0xLOw0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLyoNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIFNldCB0aGUgQ2xvY2sg
RGl2aXNvciBmb3IgR0NMSyB0byAxLg0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICogU2luY2Ugd2Ugd2VyZSBhYmxlIHRvIGdlbmVyYXRlIHRoZSBzbWFsbGVzdA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICogbXVsdGlwbGUgb2YgdGhlIGRlc2lyZWQgYmF1ZHJh
dGUgdGltZXMgMTYsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiB0aGVuIHdl
IHN1cmVseSBjYW4gZ2VuZXJhdGUgYSBiaWdnZXIgbXVsdGlwbGUNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAqIHdpdGggdGhlIGV4YWN0IGVycm9yIHJhdGUgZm9yIGFuIGVxdWFs
bHkgaW5jcmVhc2VkDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBDRC4gVGh1
cyBubyBuZWVkIHRvIHRha2UgaW50byBhY2NvdW50DQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKiBhIGhpZ2hlciB2YWx1ZSBmb3IgQ0QuDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKi8NCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNkID0gMTsN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICB9DQo+PiArICAgICAgICAgICAgIH0NCj4+ICsgICAg
IH0NCj4+ICsNCj4+ICAgICAgICBxdW90ID0gY2QgfCBmcCA8PCBBVE1FTF9VU19GUF9PRkZTRVQ7
DQo+Pg0KPj4gICAgICAgIGlmICghKHBvcnQtPmlzbzc4MTYuZmxhZ3MgJiBTRVJfSVNPNzgxNl9F
TkFCTEVEKSkNCj4+IEBAIC0yODkyLDYgKzI5MzYsMTIgQEAgc3RhdGljIGludCBhdG1lbF9zZXJp
YWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICAgICAgICBpZiAocmV0
KQ0KPj4gICAgICAgICAgICAgICAgZ290byBlcnI7DQo+Pg0KPj4gKyAgICAgYXRtZWxfcG9ydC0+
Z2NsayA9IGRldm1fY2xrX2dldF9vcHRpb25hbCgmcGRldi0+ZGV2LCAiZ2NsayIpOw0KPj4gKyAg
ICAgaWYgKElTX0VSUihhdG1lbF9wb3J0LT5nY2xrKSkgew0KPj4gKyAgICAgICAgICAgICByZXQg
PSBQVFJfRVJSKGF0bWVsX3BvcnQtPmdjbGspOw0KPj4gKyAgICAgICAgICAgICBnb3RvIGVycjsN
Cj4+ICsgICAgIH0NCj4+ICsNCj4+ICAgICAgICByZXQgPSBhdG1lbF9pbml0X3BvcnQoYXRtZWxf
cG9ydCwgcGRldik7DQo+PiAgICAgICAgaWYgKHJldCkNCj4+ICAgICAgICAgICAgICAgIGdvdG8g
ZXJyX2Nsa19kaXNhYmxlX3VucHJlcGFyZTsNCj4+DQoNCg==
