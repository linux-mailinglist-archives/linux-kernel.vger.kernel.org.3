Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F654463007
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbhK3Juu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:50:50 -0500
Received: from mail-eopbgr1300115.outbound.protection.outlook.com ([40.107.130.115]:10496
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235693AbhK3Jut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:50:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBPJNJEp7dukBbbfeXKcTmZakCHZUmoJvFrhU+47Z4PxjAqN7F+iyptXkFUA8xc+pKGIq7S8V9ScrKOgAaeZvaeNpDBieupp4mTnUzqglxTM7DY20978dU5oHbSHxH/okP7f1Z6KbR2tuGQZ62ZLTxlAgSdC/igxJLCLxXKmh8I4ldzB7hoXJcPEErsEMu8bT7i7rmePl7p0HJVjR7NIvEBeHB7ddYEGDeBsKW92E9iGPyYppvS3054Ye0PYuI2RY/zCpOTuUa8mldxTubkAUAGsWZaIWFm0EtIIMtKKGFSDl/VVJ9EISMPmfVR1K+RON4T/p+6KGriwIICWlM1k4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6MKaV0jz8m1uRon+rf0+6+FUy+QfwnwckBWpT/HaGM=;
 b=dvJ/flAa2F+Y8zi4xSlZBEGJHpdjPIbyJrVlltmUn+Rb/Gtu64EloLgyXpd+nItDt+KBiEVMcdjTS9tUfJx0kl3Tk/2KV51ZzJCERah6azzUiCzY/oVhDVyiVgrTeW1LeqKqnCQ1Wgba4oaV4ipVHSJh7dccuhZvqvsFktsYXnr5VLQyUZbzBtA9/piVgM/f5ALNFdRm5w8wClNQbZUv7Tz/Nr/0EOgYnv6B5Pf2oJmruL/osQxYLV8ZmDEHefMrkuLUaIWJsVTW2/Luivlte1doCrSpzU5Boq/ICgx1/WBan1dP0CIc3PgjQFTCyIzv8PL3RDw9T3HEIechUO1Lhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6MKaV0jz8m1uRon+rf0+6+FUy+QfwnwckBWpT/HaGM=;
 b=N5fd+wvwu9XMB/R7itPVGJnWocqAYmbapeC/aQkvnTMJdPLbvWtso1/+w3vy1p2C+u5W3yi0C1CUFqUtcMxNiVavDLQ559w+gib5MxX2/OVhDOqQ7l0q+cabQrt4tds3fz8CMMeoamInubIrixKiwLCyM6ofj7J6cwa5jnx68r62ErkL0ep5+fQI/J7UFtTwpKXWAbdKXWqAGZukhIp/4jk5YCnE1KFFnVkB84Or1YeJDHgjSJWLPUf3vjszgXklOJHb1waF4Ska2qprDbVFPR23+5tgrjCwl1TcrC589uyW2uxoTg0PczYZZbZ2dmZI24ARb68nX61UvcDkOFV35Q==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK0PR06MB2705.apcprd06.prod.outlook.com (2603:1096:203:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 09:47:26 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:47:26 +0000
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
Subject: RE: [PATCH 2/3] usb: aspeed-vhub: support remote wakeup feature
Thread-Topic: [PATCH 2/3] usb: aspeed-vhub: support remote wakeup feature
Thread-Index: AQHX4rYwtTnSWbEdCEahHL8/1MfMn6wbMQYAgACjh+A=
Date:   Tue, 30 Nov 2021 09:47:26 +0000
Message-ID: <HK0PR06MB3202A1F0710655B3E8EA709580679@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
         <20211126110954.2677627-3-neal_liu@aspeedtech.com>
 <279c42970790787e928ed017149e300835085235.camel@kernel.crashing.org>
In-Reply-To: <279c42970790787e928ed017149e300835085235.camel@kernel.crashing.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff88e1ae-ebf0-4c28-d3e3-08d9b3e66aee
x-ms-traffictypediagnostic: HK0PR06MB2705:
x-microsoft-antispam-prvs: <HK0PR06MB27055FBFAFF23DE7F146B7E080679@HK0PR06MB2705.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oJ/JNlWMFcuYrBVn85NasMmNxuklFs9t5jKfp+TEoL+DAnmimDdMJonHENun8YzU2Vkv40h+8oZjTsyy2/IALWEeTw1yuy0G3Xd8e3NofKExvXbKgsCJOKxE88JnsQNyP/s1tBFQoHFvkW6PVwDeId9Mo+1rARaIW+cusfgxA8AH3qxqFnIS9MpBXE2+okMHaKbJP+MapnEp9mkjduGNIqpS/UVUqKZScqucRYZYLdNGWPIbO5x7dHuYiVbTYcZ+Q1ZtRaqAjXAb5mcoHsO8csQK8qHJmVSFCCftmlW4jIrqLp0hxq7uw+c7rKRZZgnVkfOkj0cZu4v9/uyF9/33ZmD8hZhcoUy1v+/FH7/ElYnYMm8Dr6i1HVKOd8fpBi64spSamprHyfCAyjk7JdB9IxcF7M7QHqo/I/bj3O7hO6iDjHAz9oQwzJkdc0EhvCZmX6Oqt8P4zuOfPfoDqN3K//1G/H6fj0I+3Trh4hJQ7v22nkZgXJTFVuNMaM8Ltf/7tgCSWDQhgSdz4rn2DVr4XQoj8n53codv0jSM9wPP5ocu4GisRJ0+ViyEG6v+VujsxBrq6TXuQlFVQjdoqT8DizXxMf18hkcequ4/KmpQXhwdXUa2woqD+08gk82D9lnJDjJcrzS3zGM/O/NHQjgXeeWN6as06a3NC59Upm7bXSS8EBE8UkB9Cl9YFJam+ejJvmw6NbjAdGMKsdyBj9F/CJGeQ1yClK0pbu8H2gShMBM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(396003)(136003)(39850400004)(6506007)(38100700002)(921005)(55016003)(33656002)(5660300002)(7416002)(7696005)(52536014)(66446008)(8936002)(53546011)(122000001)(64756008)(2906002)(83380400001)(76116006)(508600001)(9686003)(71200400001)(4001150100001)(66476007)(110136005)(186003)(38070700005)(26005)(316002)(66556008)(8676002)(66946007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnhiU1NMY2lUNGFtVE9LN0J4VGk0UGgxdWtuUG4zYmhCSGJYb1ZFd0IxbWc3?=
 =?utf-8?B?N0pxTDR6Y3NtdEYwMXRncjFFNlV1M0Z2VkNHWUtyRnlyeFlJQk9zNVl3UVQ4?=
 =?utf-8?B?K2w3UVVrWlQ5aTRFc2NBbDlaRm1QSUE2djRLNXVoRVMzM0tLdXc1d1pZNTJO?=
 =?utf-8?B?REVhRXlPTW9mdHZ2UFJQSGRJaUtGeEE3cDh5ME1zQWRROHUxZkNlbjRONHNQ?=
 =?utf-8?B?OXBjOHFrOVR1eWVjQ2tjcDZSNENBcXkxakNMVHZPdEk5MTNvVW1GQURIcFFM?=
 =?utf-8?B?WjBITXBBK1FBWU1ob2RJSUU1WWZ4VUtZTERXZ0x1M1pjMVgvQkNjTXkva1Nl?=
 =?utf-8?B?VXZ4SGhwV3E0UG02WFp0ckx5Z2x6dFNab1JXTUZwZFU5WnMvWlJseFkxeWJX?=
 =?utf-8?B?d3YxT0FuOW16WjhBd20vSUZJTVU3eHlXR0xZT1hLdW9vSUdoSXB1REcyNVJv?=
 =?utf-8?B?ZVdKVXBwWU14TGk4T2FkVlVjYy9keXZ1Q1cyS1l5RGZUZmpsV3J2b1FERFNv?=
 =?utf-8?B?aE9yelpudHhtQXBORWs2d3JxRFl6OEFDUGRLb3ZNNk12MDFxUzVmQVFTWkZw?=
 =?utf-8?B?cFQ1YmJTcndHdEFkQkFxL1RQSGFRRjlTY2wweDhHUkcrR24rdUtJOUJkZDU4?=
 =?utf-8?B?ZWt6clVGc3V5N2Y1YlZKZmxSbXpaaGlNanVlUUlCeFNhZnlMcDljblJrR1l3?=
 =?utf-8?B?Z0NvRjl1UkZTTkoyc2RHVEJlYk1kQ3ExS29ZbVBMQTRRNHl4b0t5a2VSN0lI?=
 =?utf-8?B?QzFuZVErWVMySVY4SW5OcGRoT2FDVC96NG9pRDNmVDNMc3hHSmFyUHNzQWpJ?=
 =?utf-8?B?S2dwQlFXUk5YR1JrUlRxZjVidkFoRUJPdWtGUzkvOFpXazQ4em83WXh3R1Ir?=
 =?utf-8?B?c2NUeEtCRmFTZFFOQnU0K1VYRGRFWUxZbytCc1Q0UXVxRDJwTW8wSzFDVUVu?=
 =?utf-8?B?Mm5McHBmRlM3d1lFUHM2QmtraVdlS1g1NnZxODJ2WThQQ3NIbFVEWVpSWCtr?=
 =?utf-8?B?TzJEZ1JPc2VKbVFNT2xzNi9EK29lai8yenVFcHNTMS91TUp1V0hkWEQ4SUV4?=
 =?utf-8?B?dG5jT2VKa1JaMmV3TUFLNzJHa0ZKbk9vQnRSU3hrYThZdzNkR3VYNGZpckRt?=
 =?utf-8?B?c3d3V3JNMGs3ckgxM1BlUy9rTzVEem4zMkVMblBMZGVZWDZ5NmRGSXYzTXEz?=
 =?utf-8?B?dkFBVUR4bmozU0xtZUFOWkJoTnZaYUdMbDZ5QzN6Tm0zaXQ4bitlNS9jc3c4?=
 =?utf-8?B?aWRpQXgxWlFOZVNlaXpNWk1GTDhTM3k2dU9DUTQ5YVc4eHJnRklrTDJ5L0Rh?=
 =?utf-8?B?a0J2YXlkRUhrWUhpdTc5VXBYc1ppRHVaUndNbHFqamQ2aTBKYys1YW9PMUNn?=
 =?utf-8?B?cjRFK3hTcm1tK1FPV0JqUXhjOHZnUXlXeExEYWgvc3JaQXBQOCsvczBVa2xC?=
 =?utf-8?B?QVlWeTlhbTVNMFlJWEdkQVJ0enc1a0l2Zk12NkgzT0JBbEthUmhFNU1IUEN6?=
 =?utf-8?B?RUlYRlNHdE1nMS9lakVTM2Y5c21WYmdTdk4ybEVDRjZjRGw4L01JU29WL0hS?=
 =?utf-8?B?dzRuNnNFWDZNcmFMY3V5a3ZMWWx5RzdySzJ6OEh4N1h3QkhMNW5wQ1daZXVl?=
 =?utf-8?B?TFhmbnlUaS8xcHQvaFdReUtrVG1LSEJXQVlaWkwvWUFWeml4cGR2d3RTWFdN?=
 =?utf-8?B?WDZuK3NkLzB2SEU2YW5TTFlvaTFrcDI5cEJBeHdsaVdwRFJFVHBxQytHaHNP?=
 =?utf-8?B?MHV5bHZ5VkJ0dXBZb3Y1STcvWVVtcVhFTE1iWVhQSUJVVWRMQlF0LzNnYk8w?=
 =?utf-8?B?ekZqRWlVTEVvaXFYZkZkaDRTU2hJMEJGYTI2L3dFNlF3Y2tXaGNpbHBCQ2Q2?=
 =?utf-8?B?eE1DR3F3SndVUVNBaUp2UTRNR1Y1Mnp2blRrK0tUWW9xVVl1S0ltM3lNbitL?=
 =?utf-8?B?WjYzS1hlSENqaUs4QVA5M1lrc1JOUjdDbWNURW0wYmtlRWtYWXZMK24rU29j?=
 =?utf-8?B?aHJWbWFKNmJKL1YvaFBPM3JPU3QrWDNzZmt1SzQzdkZqSy8vS0NWcmlCYXl1?=
 =?utf-8?B?T2xpU1UvZlZGMlRaZ2RNZTBCWWs2UmxRY2pJdEFLYWRBWFRwSzZ6ZGZDTU9Y?=
 =?utf-8?B?UjVlN09wWGtIcExHdDY2ZHl6ZjhHN1JSRHIvbU1UVkZtWTRVdm81a3Qxb20v?=
 =?utf-8?Q?q7UQJ/Bikbexr2gs4DLNu1g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff88e1ae-ebf0-4c28-d3e3-08d9b3e66aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 09:47:26.7062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A4tHJoKYuNymy8v3f6SQfCUJzIG5DTOf0ZUV0YwaQVwVBO3PtU5/NX5WlGuPdMDP4eUx5rRRok0QtbldFs56nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2705
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCZW5qYW1pbiBIZXJyZW5zY2ht
aWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVy
IDMwLCAyMDIxIDc6NDYgQU0NCj4gVG86IE5lYWwgTGl1IDxuZWFsX2xpdUBhc3BlZWR0ZWNoLmNv
bT47IEZlbGlwZSBCYWxiaSA8YmFsYmlAa2VybmVsLm9yZz47DQo+IEdyZWcgS3JvYWgtSGFydG1h
biA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBKb2VsIFN0YW5sZXkNCj4gPGpvZWxAam1z
LmlkLmF1PjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bhai5pZC5hdT47IENhaSBIdW9xaW5nDQo+
IDxjYWlodW9xaW5nQGJhaWR1LmNvbT47IFRhbyBSZW4gPHJlbnRhby5idXB0QGdtYWlsLmNvbT47
IEp1bGlhIExhd2FsbA0KPiA8anVsaWEubGF3YWxsQGlucmlhLmZyPjsga2VybmVsIHRlc3Qgcm9i
b3QgPGxrcEBpbnRlbC5jb20+OyBTYXNoYSBMZXZpbg0KPiA8c2FzaGFsQGtlcm5lbC5vcmc+OyBs
aW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWFzcGVlZEBsaXN0
cy5vemxhYnMub3JnDQo+IENjOiBCTUMtU1cgPEJNQy1TV0Bhc3BlZWR0ZWNoLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAyLzNdIHVzYjogYXNwZWVkLXZodWI6IHN1cHBvcnQgcmVtb3RlIHdh
a2V1cCBmZWF0dXJlDQo+IA0KPiBPbiBGcmksIDIwMjEtMTEtMjYgYXQgMTk6MDkgKzA4MDAsIE5l
YWwgTGl1IHdyb3RlOg0KPiA+IFJlbW90ZSB3YWtldXAgc2lnbmFsaW5nIHdpbGwgYmUgYXV0b21h
dGljYWxseSBpc3N1ZWQgd2hlbmV2ZXIgYW55DQo+ID4gd3JpdGUgY29tbWFuZHMgaGFzIGJlZW4g
cmVjZWl2ZWQgaW4gc3VzcGVuZCBzdGF0ZS4NCj4gDQo+ID4gLS0tIGEvZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy9hc3BlZWQtdmh1Yi9jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL2FzcGVlZC12aHViL2NvcmUuYw0KPiA+IEBAIC0yNDAsNiArMjQwLDkgQEAgdm9pZCBhc3Rf
dmh1Yl9pbml0X2h3KHN0cnVjdCBhc3Rfdmh1YiAqdmh1YikNCj4gPiAgCWlmICh2aHViLT5mb3Jj
ZV91c2IxKQ0KPiA+ICAJCWN0cmwgfD0gVkhVQl9DVFJMX0ZVTExfU1BFRURfT05MWTsNCj4gPg0K
PiA+ICsJLyogRW5hYmxlIGF1dG8gcmVtb3RlIHdha2V1cCAqLw0KPiA+ICsJY3RybCB8PSBWSFVC
X0NUUkxfQVVUT19SRU1PVEVfV0FLRVVQOw0KPiA+ICsNCj4gPiAgCWN0cmwgfD0gVkhVQl9DVFJM
X1VQU1RSRUFNX0NPTk5FQ1Q7DQo+ID4gIAl3cml0ZWwoY3RybCwgdmh1Yi0+cmVncyArIEFTVF9W
SFVCX0NUUkwpOw0KPiANCj4gU2hvdWxkIHRoaXMgIGJlIGNvbnRyb2xsZWQgYnkgZC0+d2FrZXVw
X2VuID8gSUUsIHdlIGhhdmUgYSBmZWF0dXJlIGZvciB0aGUNCj4gaG9zdCB0byBlbmFibGUvZGlz
YWJsZSByZW1vdGUgd2FrZXVwLCBzaG91bGQgd2UgaG9ub3IgaXQgPw0KPiANCkZvciBLVk0gdXNh
Z2UsIHJlbW90ZSBrZXlib2FyZCBwYWNrZXQgd291bGQgYmUgc2VudCBpZiB1c2VyIHdhbnRzIHRv
IGRvIHJlbW90ZSB3YWtldXAuDQpJbiB0aGlzIGNhc2UsIGQtPndha2V1cF9lbiBpcyBub3QgdXNl
ZC4NClNldCBWSFVCX0NUUkxfQVVUT19SRU1PVEVfV0FLRVVQIHRvIGVuYWJsZSBIVyBhdXRvbWF0
aWNhbGx5IHNpZ25hbGluZyB3YWtldXAgaWYNCmFueSBwYWNrZXQgd291bGQgYmUgdHJhbnNmZXJy
ZWQuDQoNCj4gPiArCX0gZWxzZSBpZiAod1ZhbHVlID09IFVTQl9ERVZJQ0VfVEVTVF9NT0RFKSB7
DQo+ID4gKwkJdmFsID0gcmVhZGwoZC0+dmh1Yi0+cmVncyArIEFTVF9WSFVCX0NUUkwpOw0KPiA+
ICsJCXZhbCAmPSB+R0VOTUFTSygxMCwgOCk7DQo+ID4gKwkJdmFsIHw9IFZIVUJfQ1RSTF9TRVRf
VEVTVF9NT0RFKCh3SW5kZXggPj4gOCkgJiAweDcpOw0KPiA+ICsJCXdyaXRlbCh2YWwsIGQtPnZo
dWItPnJlZ3MgKyBBU1RfVkhVQl9DVFJMKTsNCj4gDQo+IFRoaXMgaXMgdW5yZWxhdGVkIHRvIHJl
bW90ZSB3YWtldXAgaXMgaXQgPyBJbiB3aGljaCBjYXNlIGl0IHNob3VsZCBwcm9iYWJseSBiZSBh
DQo+IHNlcGFyYXRlIHBhdGNoLg0KPiANCj4gQ2hlZXJzLA0KPiBCZW4uDQo+IA0KWWVzLCBJJ2xs
IHNlcGFyYXRlIHRoaXMgcGF0Y2guDQpUaGFua3MNCg0KLU5lYWwNCg==
