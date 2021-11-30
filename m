Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FE1463023
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbhK3Jws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:52:48 -0500
Received: from mail-eopbgr1300130.outbound.protection.outlook.com ([40.107.130.130]:10575
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240504AbhK3Jwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:52:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQCN6lz0P1VIUrfEuNqSYDotJ19LV7BRnwx/y7FVdRkt3B6zeidfEJ9zeD4zegY47w+Uq/3b7eVwfpklA1rFlsw1fxxoAdEHiEY/NDP0c9JARZPe5vzi4ZYkBzJkf6r1si79+r/GgMKoaOnfTE2uJNiRKLYSGzG1XY7uzb8iZ8o5dYvIfSkUPTAwjIcBee6+iFObI1/808A7mpXWQabh7Uritp7hD/uCeEQui3EsgnwYdsMAJhG8ceZdi7JhKfqVpt4TLAUSV32El3PPojQZNrrHgApB82Wtly9/vwDrZkfhkB5dKtelVT6bVrgIZJdkLAdrR0FNEmmLCsioK2zaXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehZA4zojWFKsmC1+uxU5dPeRDu9Nznub4fcubq7RrYk=;
 b=NnmviyGPqOwkmoHF7omIyNJ2XidNHdGn5/evRaYo7NZf/d92eTucWRdPWn6KmPPT9Ek3OXRVIOLXoSLFe+UbowvGZzsxPih7z0YiMt7MDUTlZ6hQwQI4tsweHwWM8Vc4/mC1u4DvXDxlMj7UlPuD9lXacIWLjkimgbYIZ0KBD7+iVsEQtPPx4urQo4ErD1LVn4T+RmnpT/9QqSasD/mLj959iwJ4LMUOZ7CSdp0W8o/TvzlWVvQ+//vL9PopvExi5RArgGmkv8q9RKBqGC8DFLnxLnSYVJppCQR13sCKYTT0VoUlKfNl3VQtDUIfI1JhFxYUgnZU/bGITzByp6oBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehZA4zojWFKsmC1+uxU5dPeRDu9Nznub4fcubq7RrYk=;
 b=0jyjlblDEqYtPAkP4Gk6ZyEw1EJELg7kx29QcBenvudN+hjgZoPtFH+9VaTCpPBHhoFEWgMKYy//zMEbX6QBx0X10jDaoWBOZKm4dDiwa7vutADjdQzw0Wtn2RXBTlmjby+a5xSSrwjrq0JyIzQK4oCzZSsZNc8qNg64+KBclZIxj/qiQhUzn5JBh2omBwlGQBXOHit5GaTKmuV4xo9zEd2WAL8VmsFUFjoW6Lf6kD4Zta4SMXUJ41l5ZHDmyD9cbObH0rElHZx5EGJxjLy5cpYX9HZMlicLyZo35exdbNAgzGW5n6e6NfKcGB7B65g8m1HNaGq6O4Bz+njb6JA7PA==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK0PR06MB2705.apcprd06.prod.outlook.com (2603:1096:203:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 09:49:15 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:49:15 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH 3/3] usb: aspeed-vhub: fix ep0 OUT ack received wrong
 length issue
Thread-Topic: [PATCH 3/3] usb: aspeed-vhub: fix ep0 OUT ack received wrong
 length issue
Thread-Index: AQHX4rYvUSg03mFZRkmBL375Gh+MWKwbMeIAgACnqYA=
Date:   Tue, 30 Nov 2021 09:49:15 +0000
Message-ID: <HK0PR06MB3202AAE5C89029C64399DD3680679@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
         <20211126110954.2677627-4-neal_liu@aspeedtech.com>
 <12cf11dc4326922ceb67ede7b63a53fe1840b6fd.camel@kernel.crashing.org>
In-Reply-To: <12cf11dc4326922ceb67ede7b63a53fe1840b6fd.camel@kernel.crashing.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1694259-b4af-4280-745c-08d9b3e6abc1
x-ms-traffictypediagnostic: HK0PR06MB2705:
x-microsoft-antispam-prvs: <HK0PR06MB2705223A294CF0F67115BBF180679@HK0PR06MB2705.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IK4FnALrCCGXZkLvZvzw4ToEI/mGn22hNiRpRJIjtnq3h9TKj4FZI8aWc6B+HprkJqDtge29izIndxEXQ4L6kzmehK5x27eVjeYIXLCskMvPG/j1LA1GA0m8z16Xi6WnxHby0rWzAyeuF7JZaUvbMtt7n0QK2Wn+6PUgPTh8u8ajJ5JtYYjE6IJF0rbTT3oocwGS+NO7nJbDAMFaHxU0Xmy+iEfg7ja/2yaVm4yF+HOe5/5sRXjeWMQ7KhE9kugvonxyUhPP7qWY1YSKCmCfddeu8+zIBPnNBqur7hrJjEWeBhV5uAEB0tMN9K5XX9k6IFhK4CvRjyWPKoCT2IyQRj3frLvufW0vixEx9W5o+MYGVfU9j46XRa3vsW+IZuCotoV9rYYMyecAYnYV8GwY9At88g6GMrU7TqxD8tJSrDsVj4SDGLPGDG2dtIRNjab1wj9COYDsnyZrG8F373BHUiOSsJqATVH1Mhq450Vd3GRBEKrOvXA9MuFSnYjtp5E9KzthhsEF6hPlg6tNHSo64PndCvdmErLWjAHN0bqkSMH+LJ/Educ8tk/6vZSyeqEV4lNDskF9rVrZOrlaroWcXNvsN2Tts27OgItVK1S0YezCc4wiR+AUU3xWFK8HvpF2Fh1t1YD6cT2WfEt4yBt7LIXOpW+UxW3n/Z2HB+468v5UuzNbIyZxMk73+pTijO3txWpCsASYeBYveHlr00YbsDgIXbZQVdq6Hmzhb+jVC+k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(396003)(136003)(39850400004)(6506007)(38100700002)(921005)(55016003)(33656002)(5660300002)(7416002)(7696005)(52536014)(66446008)(8936002)(53546011)(122000001)(64756008)(2906002)(83380400001)(76116006)(508600001)(9686003)(71200400001)(4001150100001)(66476007)(110136005)(186003)(38070700005)(26005)(316002)(66556008)(8676002)(66946007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUk4dTZVQ216RlRlZ0J0WFJPY0FMU0hvMTJ6MjRaL1NFTU0rOEQ4Rk03ei85?=
 =?utf-8?B?bE01cXA4bXBWN3EzWVZqay9xUWZYZjlTUFcxRG0xTmtPSXB1TnNiTDU2cWxK?=
 =?utf-8?B?ejJDZmVxUm5Tc1diVlBMd2VldS9WcVZ1Rit0TEFZczFIWG1wcWwrTVBndEE0?=
 =?utf-8?B?RjNjTmFQLzBiNWlvSFd3ZnEzQ3BsVnUwYzNlRHV4dUJTNHdINkdjb1BQbmVX?=
 =?utf-8?B?N3lZVWlST3ZaWDBxcHU4SlNnTy9vQ2l3eW1tMFdZVnJReHNDSGR4UjlqbGpD?=
 =?utf-8?B?WkFSQVZvckE1TzJ6VlpCU3MzbTZ4cXgrdXA2NDNMdUlWaEkvY2xSeE55cUdh?=
 =?utf-8?B?UlNRMEI0V0NETmpvTExkdnNDdFcrVnR4djlQRmlwMkNOUk0zV1JRZWswMW5P?=
 =?utf-8?B?SjhCU0U3aENNeFNFdTExQURqZ1R6bHRJZjNlSC9pYVUvOHlYdXFwVzB5Witm?=
 =?utf-8?B?SlB6aVJVUjRqL0N4eUl0TE5uc1pLSzc0L2hQVTBRVGFJcjhyMDhmRGdsSXpP?=
 =?utf-8?B?QW1pZ1daTWJ3Z2N0SVhJcVhwM2dIK041Y215R0h2aUp4MXlJUHVxL29SSW1U?=
 =?utf-8?B?NHRCM2FldDBzNGlWa2oyMncrdStYRTlIRFpaVVVtdzJHb254TXlMZWJvRHBo?=
 =?utf-8?B?NnB2MlJJUUZzZ0dHT3BEQXZIOW9Jc0hNUFUzTUdGZ2o1NmZlRnQrbFpES3N2?=
 =?utf-8?B?VU1EcFlveEIrRXllVmxkNm9MNWw3eHNLOXVRZGUxWXJJekdEY2poTHhRemhP?=
 =?utf-8?B?SEQxWWpQNjFWRkhlUmlhUyttOVFkK0tLdW9mbTZIOEhMaENjY21Cb09PRFJJ?=
 =?utf-8?B?RkR2OFI1aGxEaHByVnZFbTYvTnFML1h5TEk1NzZBdTRUc1Q0S2FKTWNuNU90?=
 =?utf-8?B?S0tvcVRPVlRGeEhBaTRPb2Q2Y3V4VHd4UCtSYngzYVFuNDQ3SEw1MDNvd2JE?=
 =?utf-8?B?TTNyZjJFSWdrVUNVazZpc1JNQUlrb3hOWTdZeHVCSEdMbUFYSlNHZ0pDYnNZ?=
 =?utf-8?B?d3Nhb1BhZTRGRFNTOEFjMkJndU9EUnorcFBTMldsNlkrZ0FBNmFOQmtsY0lB?=
 =?utf-8?B?VjJtKzZhSlNCL1VwUTlzMUs1eHFUK1VnRktYOUtrTG5vcGxJZDFpZWljYnd6?=
 =?utf-8?B?QXFHSTZzTkNMazZnc1lZYzNGd0RYZ3BQYnpTOWFNUnRvR2hWNE5mbDRzbStw?=
 =?utf-8?B?MFIyamJWQ0VWRzkyTEM2c3lDUU9Zb0MrSTdKMURNdW00T1BTQzRTQ2pkalpQ?=
 =?utf-8?B?aWJxa1c0a041RTJQbnZLbXRmMGtLaDdpOUNwZDZDT0dUVnRvclI4b0F6MXkv?=
 =?utf-8?B?bDBHaElNaDZDVEgwditoUTdqZjd0TllpdXlBK1FIeXJ5QW1naU9TMWtxb3RJ?=
 =?utf-8?B?WE00T1crWjNlb1lEZ25QaHhVd0QvbFluVk1HbXVUakpIdHRGK2hRRFdWSENp?=
 =?utf-8?B?cVp1QlNuMXhWRTZQWGxiTFlhdi96U2xjYWJXRFJweDBKUVYyWEg4Vm5WNGZG?=
 =?utf-8?B?Qng3ZVhzUVVPT2ovYk1KTllDRDNubE84aTMrbEhzQ1pybkhla1IzcWNJd0NU?=
 =?utf-8?B?YUd6NGpNdmxXc0NzL1BuSy9WQXZKTE85a1NQTmN1ZGNPU0tvVmhubklXUkRs?=
 =?utf-8?B?ekJ3QXo5VTRhenVmUmoxSk85TzFXOWVFTldaVXJMOXBYN3RxRFZNaERNdnJM?=
 =?utf-8?B?OElrOFZzekRhWWtjMmZmdXJkVjJNVDZ6d09USFRwS1d5MXJGcjJpbzl0dFhT?=
 =?utf-8?B?djJSZCtwUzRWOXlrLzRSSUoxdDVNN09tbmtEOFdQQjlEUWNucEtsMXJLa3VH?=
 =?utf-8?B?ZENLRkV6ZTROeENTTnJmK3Y5OEQ5emNIQ0V2dTVHNHZaTjR2a0hNUWxiOFNJ?=
 =?utf-8?B?WjB4cjBpRzdQU3JqQzZNUGlOMi9idDVvT1BUZXk1cXlueFpmL3N5QU40R0VK?=
 =?utf-8?B?WUJVVFZBelVDQlg0SWtlWU1tNlBNN1ZRcDhXQWpvZld1OStLV3pXWFRDRnBj?=
 =?utf-8?B?MFRLcHBETWRWR3N6bm9maVBzc0tCZmVMaGxaeEhxNUFTUjkvN05KczlBYUds?=
 =?utf-8?B?MVJYYUdhTzNUSk5aODljOFBDNkl0L2xYalVQVy8yd245M2pNTlFTR0NOMWFU?=
 =?utf-8?B?ZlhMWTJYeUJTUTVpOW8vcjduamwzMmxYRHJ0ekZ3ZDZBL3Z6cnBEQTZRdTVI?=
 =?utf-8?Q?/Q5LqJV8+X4zprBP14Ki2xA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1694259-b4af-4280-745c-08d9b3e6abc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 09:49:15.3818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vWNBlOUQPDkgbKk2anK3/vnLvQ3aYI/1Jl4VAV0fCbsMgaNVpaO2j+vM4inr4VGgvh5XgkGGcHk07at5aYkMog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2705
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCZW5qYW1pbiBIZXJyZW5zY2ht
aWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVy
IDMwLCAyMDIxIDc6NDkgQU0NCj4gVG86IE5lYWwgTGl1IDxuZWFsX2xpdUBhc3BlZWR0ZWNoLmNv
bT47IEZlbGlwZSBCYWxiaSA8YmFsYmlAa2VybmVsLm9yZz47DQo+IEdyZWcgS3JvYWgtSGFydG1h
biA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBKb2VsIFN0YW5sZXkNCj4gPGpvZWxAam1z
LmlkLmF1PjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bhai5pZC5hdT47IENhaSBIdW9xaW5nDQo+
IDxjYWlodW9xaW5nQGJhaWR1LmNvbT47IFRhbyBSZW4gPHJlbnRhby5idXB0QGdtYWlsLmNvbT47
IEp1bGlhIExhd2FsbA0KPiA8anVsaWEubGF3YWxsQGlucmlhLmZyPjsga2VybmVsIHRlc3Qgcm9i
b3QgPGxrcEBpbnRlbC5jb20+OyBTYXNoYSBMZXZpbg0KPiA8c2FzaGFsQGtlcm5lbC5vcmc+OyBs
aW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWFzcGVlZEBsaXN0
cy5vemxhYnMub3JnDQo+IENjOiBCTUMtU1cgPEJNQy1TV0Bhc3BlZWR0ZWNoLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAzLzNdIHVzYjogYXNwZWVkLXZodWI6IGZpeCBlcDAgT1VUIGFjayBy
ZWNlaXZlZCB3cm9uZw0KPiBsZW5ndGggaXNzdWUNCj4gDQo+IE9uIEZyaSwgMjAyMS0xMS0yNiBh
dCAxOTowOSArMDgwMCwgTmVhbCBMaXUgd3JvdGU6DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZ2FkZ2V0L3VkYy9hc3BlZWQtdmh1Yi9lcDAuYw0KPiA+IGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L3VkYy9hc3BlZWQtdmh1Yi9lcDAuYw0KPiA+IGluZGV4IDc0ZWEzNmMxOWIxZS4uYmVh
OWNiYjE5MWEyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXNwZWVk
LXZodWIvZXAwLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2FzcGVlZC12aHVi
L2VwMC5jDQo+ID4gQEAgLTI1MSw2ICsyNTEsMTMgQEAgc3RhdGljIHZvaWQgYXN0X3ZodWJfZXAw
X2RvX3JlY2VpdmUoc3RydWN0DQo+ID4gYXN0X3ZodWJfZXAgKmVwLCBzdHJ1Y3QgYXN0X3ZodWJf
cmVxDQo+ID4gIAkJbGVuID0gcmVtYWluOw0KPiA+ICAJCXJjID0gLUVPVkVSRkxPVzsNCj4gPiAg
CX0NCj4gPiArDQo+ID4gKwkvKiBIVyByZXR1cm4gd3JvbmcgZGF0YSBsZW4gKi8NCj4gPiArCWlm
IChsZW4gPCBlcC0+ZXAubWF4cGFja2V0ICYmIGxlbiAhPSByZW1haW4pIHsNCj4gPiArCQlFUERC
RyhlcCwgInVzaW5nIGV4cGVjdGVkIGRhdGEgbGVuIGluc3RlYWRcbiIpOw0KPiA+ICsJCWxlbiA9
IHJlbWFpbjsNCj4gPiArCX0NCj4gPiArDQo+IA0KPiBXb3csIHRoYXQgaXMgYSBuYXN0eSBodyBi
dWcgISBQYXRjaCBsb29rcyBnb29kLCBJIGhhZCB0byBzd2FwIHNvbWUgb2YgdGhhdA0KPiBsb2dp
YyBiYWNrIGludG8gbXkgYnJhaW4gYnV0IGl0IGxvb2tzIGxpa2UgaXQgd29uJ3QgYnJlYWsgYW55
IG5vcm1hbCBjYXNlIDotKQ0KPiANCj4gQWNrZWQtYnk6IEJlbmphbWluIEhlcnJlbnNjaG1pZHQg
PGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZz4NCj4gDQo+IENoZWVycywNCj4gQmVuLg0KDQpUaGFu
a3MgZm9yIHlvdXIgcmV2aWV3Lg0KLU5lYWwNCg==
