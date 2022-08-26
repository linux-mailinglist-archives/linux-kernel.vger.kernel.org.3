Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A8C5A2166
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245157AbiHZHDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiHZHDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:03:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B954ABA9EB;
        Fri, 26 Aug 2022 00:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661497411; x=1693033411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V1hRO1+5GiGq00fWZ50lv/UqfzbQf1iTqEkPCvjJrjw=;
  b=xJ8hJVzJ6klxR2QZrIiyfO/t6T5UzL4xeJrF4TaSsWEqTRFehnQfesHP
   +Gz9tfsbhdzD7MaaO1JDUI3pkY2VskKSAIWW1S9s+GTCQL1oJQKl+oB3i
   dp+8lrz3/neRhs/V2JkhG+Y6i5pZZP4NlCCT4aZ2O2f1yjdbiHs3QExgZ
   IcEucjA65ac3vaZgoKewL6JMA648sNLaPz1nG4SiO1d5FyrVKO/GKh+lC
   poqm+HlxuT64do4t46gDpcIStbq73u3rhbSNRtiNUKseEVkVMUhBQ/f5R
   5CFnXcxU5mxPsCOnCioMzsCFaYYKpTRcW9iLR7Lm3P6KzTZB0byX/8Chx
   A==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="177969375"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 00:03:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 00:03:27 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 26 Aug 2022 00:03:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThMmVHDSLqTYIkh7G7jAAEqlvNrdncAbMkfcgL25Fk/zCj3ExeJJsvuhinBWTKuV7BcDGE9UrVgT4WdSDjn2yR1YeGCR9Uq1V7CJ9V1Lf+xvV9f7qlBCzRy9cGNmUepLakMmGzKE71PWIGZ+qCjykVZ1fsqPq3lsjI9i+UM83yHdcOi5xMOpKLHnBvyQYp65YEquiUQMnPtc6riXjaYm7fz64tZn78o/FqGpzQlMSUOS6vS0pAD1rO2tDPF5kpPlP7jiOhr65LO2qk3SQ+CfYJ0knkTWyx71ZPWURWF9c1YStDFbOaNQqHl4aU75TcXTvqXtbp21hb0o9HtpKh7LMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1hRO1+5GiGq00fWZ50lv/UqfzbQf1iTqEkPCvjJrjw=;
 b=m6zUs0831qaqLWX6zoKAVHCzZsjK3MYlM5fswDzB6Y0QI59YdIe7pIqDAXpB3AJfqPxDsfM/cWDpAewSkctzuvueVP4s6ApPTGx0wBEt3aiDxkaaxAjPpYpupiR19SsHzk9iqZAvR/iZVP8KqG68Y1RXWe4yLLgRlbl3bf382ZpJC1ULSjwnNfCkVI1iIa+VbseAdXj4sk2Bi/xdIN5hExlGNpjussLOkK4xEff8hq66wPJq4JtOi/czMfzjXC3tMlaNOFzL1rhKdS3nqqVjyCQZ2oSJuC5HUvfUF9qazT1OWMO8jRTVw5DbrvFFVn8yBnW6nJ22lm/wQEz49Sm1xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1hRO1+5GiGq00fWZ50lv/UqfzbQf1iTqEkPCvjJrjw=;
 b=Oc3M4UoPMs+kLo04xIE9ameDq3rTBeIErbNBzLxCVWFvwrwp60Ga/v2KoFVQ2cSUNaQc3l2M57g9hM4b4j55GvimwPQvbq36l3OnzAk/OBzhS/19OX8wBFqvX8j4pvl+gcQ2ZR9otWq2E0+ltTbJzij4tvG2Zx/lAeMsM7FlI+M=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BL3PR11MB6434.namprd11.prod.outlook.com (2603:10b6:208:3ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 07:03:22 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%10]) with mapi id 15.20.5566.015; Fri, 26 Aug
 2022 07:03:22 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Sergiu.Moga@microchip.com>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <admin@hifiphile.com>, <Kavyasree.Kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 4/5] clk: at91: sama5d2: Add Generic Clocks for UART/USART
Thread-Topic: [PATCH 4/5] clk: at91: sama5d2: Add Generic Clocks for
 UART/USART
Thread-Index: AQHYuRntRBygRngUz0eRmHWaLEAKGQ==
Date:   Fri, 26 Aug 2022 07:03:22 +0000
Message-ID: <11d8b176-6489-21e9-42c1-dd81ff241129@microchip.com>
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-5-sergiu.moga@microchip.com>
In-Reply-To: <20220817075517.49575-5-sergiu.moga@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53a03ffd-c226-4965-8128-08da8731102d
x-ms-traffictypediagnostic: BL3PR11MB6434:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i5NTOjtUViCwYY0+sfWFgPgcH+NYzi1a7OLshV3NugPjITAtlGv8DQGpIgBs4cmLIrZS85Ps3YzIcLgBdLoUbl2KCKkXc7YKzX9mAodPememlCu13CKugSJlEbgeYMYxdJz897U+I6UimQrmGpDpSemikT4EXfRoZM1sbVdFbwVorKgczA4o0YVChz6zcdnxvTjG18+hkIo2eknxmxwYuEaA50LFklVUVfVBbfcP/r8frQ/jbh2qPikG19ZRknWXlN01v22TPQbEMlVx/n0tco2QPCE3mBc2R6o98iFXEOQpY1BCM4FpsfSRcabRcG+rpwkcYUW7OEhGs69DlNQ1m0MTGBQRYHYXH1h/iyuUTil/yq4ivYSGgQBa8Ih7fj8WX44Ub9El881a/ghWIZLLPduVZmh/kTrfT2ZQ906gj42Qn5nnglISM2E8LrldAJY5H6OSwlyM3siR6eCoUvo0XIzcH9WABsdNhBd9OWOh0WJdrJ6dB1ic0r2+QnoIIM+PKl8FpPiIwxY+3rJ1g2ssRTa+C3p0XjyO0GIpUqryc0laEYckKpnzNW60n3lsZ0VYUhmyaxkae/UZw8EdYn+K2bjzWUCJh8OOF3YHFgSpQdGn7XJimxUJGSRWgJZZTiRjVkAbfXGu/TkeB/7i7DtTmiT11X/XYIxjM6co8HQmA3UEYF2g6ZM+YJUpT4hs8Xp7ONmNnI8FoyXOI3CH/sYRPSKgslH7AsTev87Q10DXXvXHUCKzLmEdfKaWoz2rj0t3oCUNsgSUtgNoKjxj1tFCc6h6DYrAp6iENwDIWsZveH3mVdOq7wy5F88lxgnG9+rrQ4MQ3/oIpS8/xGJSIh6NIB36IAfWCBR8w3gviuOCnpySpaKjXlrbJuw8XACjTP5/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(366004)(136003)(39860400002)(83380400001)(2906002)(6512007)(53546011)(2616005)(186003)(6506007)(921005)(31696002)(38070700005)(86362001)(36756003)(38100700002)(122000001)(54906003)(6636002)(8936002)(7416002)(110136005)(76116006)(5660300002)(91956017)(41300700001)(478600001)(66946007)(66556008)(26005)(31686004)(64756008)(66446008)(71200400001)(4326008)(8676002)(316002)(66476007)(6486002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0JTdWY1L1lXUlhmQWdadjN4OGludlBmRmlkeUkvWGJtZlpHc2lIR3FWYnVK?=
 =?utf-8?B?RFNIRFVxdlNuYTBudTFpbm53OHIzK2xKZDU5cStYRWY0WXNkRkdpOWwxYWFo?=
 =?utf-8?B?c0VRR211UlVkc2ptSXBsSUFjNUJPTnRaelVzazZoZjQ5RVlYdVRMWW45cFpL?=
 =?utf-8?B?YXh3Q1k4b1pkb2V2QXlBby9iZjFWNHJCS1dOT2Q2QUFET3BkQXByN0RSS2xo?=
 =?utf-8?B?eExtdGQ1VzllbW5jbXBPTzJjRHZEUUN1T3h0VVdOSEUzSnY3UXZlYi9PYk5R?=
 =?utf-8?B?UDhvWDUxdExSTFAySU02YTVXdGhpM01iNVR1OHQyOFZJSDFYQlFlaXdaYXFz?=
 =?utf-8?B?V3YwajArR0tIdm1vWnRxaEhsVFNRN2Y1Ykp4TEdYb1VYZkt6SS9xQnlGdlFI?=
 =?utf-8?B?TWtPTlZ5U3h6Q1dKU1RKb2J4RkhFcWxyN3ZrTXFuTmFrc2MvSVd0Z0JJZ0w1?=
 =?utf-8?B?U2lPcUlYSmU4SE5KK1BRQ3YycUJKTXdUQzc5NHI5NzVJSnVKUzhkNGtCdzVX?=
 =?utf-8?B?YUluUUNIYkR3OU05U3Q4K1ZKVG96UHVZamdqVFZyUHRBR1NXNkJLSzNiaEoz?=
 =?utf-8?B?ZXdxVTVHczRlbktKSFk5eXg4WWJndU1DTU8vM3FYVEJwUm9QNVJxaWF3eVVt?=
 =?utf-8?B?Sm01SGR1NzZDUGJTWENTanZ1aXU0am1GZ2xaelVOa0lrdGY2NWtXd3VXdTAv?=
 =?utf-8?B?bW5GWk11UVRhMWJLbXFtZlI4U05VcnZYN01XdFZmOFJUbXBIUUZ4bjVBc2lO?=
 =?utf-8?B?cFM4ZTkxd0lTK3ltSjl4ZlhjeHViY1paSWUxTnVNbzVKcTZtY0twc2ZoOEIr?=
 =?utf-8?B?NFF2K2J6RTRWSE9Halg3Zjg4UklWRFVHcnBiZndsQkN0bzZmdHh4SXVhMGUz?=
 =?utf-8?B?M2wzNXpTbzJsV1A0Qnlqc1ZpY1B5aXF4NEtqc3Bhc1loUlpEb3BWd3RFK1d4?=
 =?utf-8?B?bEtMMSt4cm1NSGRtZXZxeHEvRTZ0dVZjUlJwQndhOUpzc1A2VXlERVZpeVFs?=
 =?utf-8?B?Z3Zrc2U3R1R1SWN2bnVWTmdNUUhoUnF2QjlwQ05pRTlTWVpnREdTM2hQSlBo?=
 =?utf-8?B?K2hFRytZVTYyVGlMTzlHOUhyVjBxRCtpREFRSmkxNW1uV1ZJa0JJd2RwSVJn?=
 =?utf-8?B?VnhSTGtUVHBiaUo4dmJQaUp2SGI3T3RmTENZd2ZEYkNRaHFYaFIyVCsxV0Mr?=
 =?utf-8?B?aTVxTllXZUk4aXJzY1lkMURmRS9QL1VtNSs2cjVyQzZFbUJwdUlIQkRxa0tX?=
 =?utf-8?B?OHFLbHMwbnkybWlSTkRVV0phSFo5RHFDMHl4MkQxdmFBOGdENWNpR0hBRVNz?=
 =?utf-8?B?YlRkRndKTE56Q1h1VU51Y3EvN0t4Zm5hU1l4YkZmWlBzNWpPbW5lWUNOR2dn?=
 =?utf-8?B?YjNlbzlORDNMVzNVSzlKcFRLZlMrUGxZemJhWjJmc1MzWUJmVm9pTjZBOW41?=
 =?utf-8?B?bFNLNlhONmc2MmJYUlB6NU9mdE1lZjRyNmh0eHNtazRnbFBDS0ZvaWpHNUZM?=
 =?utf-8?B?dDdTM3NuSmFKZVJDajg3ZXZUdE5KMjhHMWJmUlJDeTZrZXBDWEowL3dGYnBp?=
 =?utf-8?B?UkMvUXZiRFh0N3AwdEFLUDRzcUIwZWhUdTJOeGphSmtta2ptN3pFODduMU5m?=
 =?utf-8?B?RUJtSXVGWFAzZ29zb0tWWmhzNUJUb1Mza1JQWHRGUGJ3elYvVXlHUWdVYUJr?=
 =?utf-8?B?UHlGcmFLWW44OE9KNmZNZm9QdE1Uby85U292aldrVG1JNWQ5YnBaaWxiQXRR?=
 =?utf-8?B?N1k4MklwNDJPWjIvOVJJVVVqME85bHFFVldxOTUybFpEaFBmdDFKR2hUYTBs?=
 =?utf-8?B?NXFwYUhvV3BHRTltMWhHaEtZWm1qUDZXV0RCeng4VU5aek42eG9OSjcrL2Rz?=
 =?utf-8?B?L0Myd3MvNlBrWW9LRXZmQmM0YUI2YkpmNFREdGUrN3dmVStIbmY2ZU44alRr?=
 =?utf-8?B?bjkrZVh6RXdxY1B0ZjArd054bUgwTWljY0d0MzJqSmxqWEJ3S2lWSVkxd3dW?=
 =?utf-8?B?dEZpM2s1dTVLa050ZGFzTjhzZXBSZVBsOE5iWkhRdWlkelg2Rm5uL0dGYjg5?=
 =?utf-8?B?T05aWncwSDl4RERGUnVOd2VHZFhTazZsWUxROEVDSWVqbzZoR2ZIZWMvYzZ1?=
 =?utf-8?B?YktvMWFYUDBwbmtqVFF2MkNXa0Z1b2ZqQUJWOWRyVmRtOEQva1BxLzNEend2?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59C92365CAB0174493B78A6BA27D0C0F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a03ffd-c226-4965-8128-08da8731102d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 07:03:22.0286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1G4aV+0mJPJ2rzFJZV/FOXP1f0xx5bvK8ye6VLeqRAD0zSzr1u942/iHd6V7vIagvmCQLmZe4Q8ktwqu5WCAfUNHXlF8tzPLOTlWz8st5QQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6434
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcuMDguMjAyMiAxMDo1NSwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+IEFkZCB0aGUgZ2VuZXJp
YyBjbG9ja3MgZm9yIFVBUlQvVVNBUlQgaW4gdGhlIHNhbWE1ZDIgZHJpdmVyIHRvIGFsbG93IHRo
ZW0NCj4gdG8gYmUgcmVnaXN0ZXJlZCBpbiB0aGUgQ29tbW9uIENsb2NrIEZyYW1ld29yay4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFNlcmdpdSBNb2dhIDxzZXJnaXUubW9nYUBtaWNyb2NoaXAuY29t
Pg0KDQpSZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hp
cC5jb20+DQoNCg0KPiAtLS0NCj4gIGRyaXZlcnMvY2xrL2F0OTEvc2FtYTVkMi5jIHwgMTAgKysr
KysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL3NhbWE1ZDIuYyBiL2RyaXZlcnMvY2xrL2F0OTEvc2Ft
YTVkMi5jDQo+IGluZGV4IGNmZDBmNWUyM2I5OS4uODQxNTZkYzUyYmZmIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2Nsay9hdDkxL3NhbWE1ZDIuYw0KPiArKysgYi9kcml2ZXJzL2Nsay9hdDkxL3Nh
bWE1ZDIuYw0KPiBAQCAtMTIwLDYgKzEyMCwxNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHsNCj4g
IAlzdHJ1Y3QgY2xrX3JhbmdlIHI7DQo+ICAJaW50IGNoZ19waWQ7DQo+ICB9IHNhbWE1ZDJfZ2Nr
W10gPSB7DQo+ICsJeyAubiA9ICJmbHgwX2djbGsiLCAgIC5pZCA9IDE5LCAuY2hnX3BpZCA9IElO
VF9NSU4sIC5yID0geyAubWluID0gMCwgLm1heCA9IDI3NjY2NjY2IH0sIH0sDQo+ICsJeyAubiA9
ICJmbHgxX2djbGsiLCAgIC5pZCA9IDIwLCAuY2hnX3BpZCA9IElOVF9NSU4sIC5yID0geyAubWlu
ID0gMCwgLm1heCA9IDI3NjY2NjY2IH0sIH0sDQo+ICsJeyAubiA9ICJmbHgyX2djbGsiLCAgIC5p
ZCA9IDIxLCAuY2hnX3BpZCA9IElOVF9NSU4sIC5yID0geyAubWluID0gMCwgLm1heCA9IDI3NjY2
NjY2IH0sIH0sDQo+ICsJeyAubiA9ICJmbHgzX2djbGsiLCAgIC5pZCA9IDIyLCAuY2hnX3BpZCA9
IElOVF9NSU4sIC5yID0geyAubWluID0gMCwgLm1heCA9IDI3NjY2NjY2IH0sIH0sDQo+ICsJeyAu
biA9ICJmbHg0X2djbGsiLCAgIC5pZCA9IDIzLCAuY2hnX3BpZCA9IElOVF9NSU4sIC5yID0geyAu
bWluID0gMCwgLm1heCA9IDI3NjY2NjY2IH0sIH0sDQo+ICsJeyAubiA9ICJ1YXJ0MF9nY2xrIiwg
IC5pZCA9IDI0LCAuY2hnX3BpZCA9IElOVF9NSU4sIC5yID0geyAubWluID0gMCwgLm1heCA9IDI3
NjY2NjY2IH0sIH0sDQo+ICsJeyAubiA9ICJ1YXJ0MV9nY2xrIiwgIC5pZCA9IDI1LCAuY2hnX3Bp
ZCA9IElOVF9NSU4sIC5yID0geyAubWluID0gMCwgLm1heCA9IDI3NjY2NjY2IH0sIH0sDQo+ICsJ
eyAubiA9ICJ1YXJ0Ml9nY2xrIiwgIC5pZCA9IDI2LCAuY2hnX3BpZCA9IElOVF9NSU4sIC5yID0g
eyAubWluID0gMCwgLm1heCA9IDI3NjY2NjY2IH0sIH0sDQo+ICsJeyAubiA9ICJ1YXJ0M19nY2xr
IiwgIC5pZCA9IDI3LCAuY2hnX3BpZCA9IElOVF9NSU4sIC5yID0geyAubWluID0gMCwgLm1heCA9
IDI3NjY2NjY2IH0sIH0sDQo+ICsJeyAubiA9ICJ1YXJ0NF9nY2xrIiwgIC5pZCA9IDI4LCAuY2hn
X3BpZCA9IElOVF9NSU4sIC5yID0geyAubWluID0gMCwgLm1heCA9IDI3NjY2NjY2IH0sIH0sDQo+
ICAJeyAubiA9ICJzZG1tYzBfZ2NsayIsIC5pZCA9IDMxLCAuY2hnX3BpZCA9IElOVF9NSU4sIH0s
DQo+ICAJeyAubiA9ICJzZG1tYzFfZ2NsayIsIC5pZCA9IDMyLCAuY2hnX3BpZCA9IElOVF9NSU4s
IH0sDQo+ICAJeyAubiA9ICJ0Y2IwX2djbGsiLCAgIC5pZCA9IDM1LCAuY2hnX3BpZCA9IElOVF9N
SU4sIC5yID0geyAubWluID0gMCwgLm1heCA9IDgzMDAwMDAwIH0sIH0sDQoNCg==
