Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D136D49F3E8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346595AbiA1G7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:59:21 -0500
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:12770
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232306AbiA1G7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:59:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+IDsq3wJrzZsKNAOKn0rpm6tF+gdNBlMCV83sTwZwIrIhdee/Z8vtnrQwnLtIyJEfxkvptNrELAiFVqs6LWSqXunOcdBs8/7RBilBHylsxcteKSg5NUP9c2MwlmiTK+5k7gevllWbp3P78ax5H9sJMZ5mCtTPIX80ilMrEpW/3JsrVhvyDnf93iqUgnjyDh33C9SrzlTUJffytiegO0VlVSLtUfTEO1HVy6jnv4Zh7TKRJxWaQZe5BWx1KIrmq4q0JxiJC3BMcQJFvfPNCRo+SBj2wIDhfj/FV/Y0OZZMIhxQMu8OFdlhTh/IPO0bxlzpLg1jIl663SGBnsqsCVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaZdq/SEMwAUz6aVu25Q/WOaQCnLequdSbeamqq4fDY=;
 b=GjSkmXT/1NvHPBKDmP0ooJgKr5n52XNUHcq3IsemsQTLwgvs31HReeCDQKK93kTkRvRDsCQUmueV7AAjgDYm7rUuA5ijYGfh1xjZFw9pmm+SnCQ/whjhnD2hE51iW0owEF5b02ATEg8DDrMmqiT+Tu7u+Kl2O8XStfDp074SWFgw3jPdvOF37qpr4MPPAorVm3x3DXkYJE8rH8TDMLqOEihSaPkASCa7ov4FpWoYWq8F224z74jcpLpK/L52+87gWxLOR89OvK2wvrh4ZNBJ35343cqHHmvL4MJ6/yEjUIOc68Jg5pkJ8Q5/nhp2m+I+LnlnPQaVWcOSTyNz5HOlSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaZdq/SEMwAUz6aVu25Q/WOaQCnLequdSbeamqq4fDY=;
 b=J6qEJMkHpdRE+XqGuG4v1qUV7t3eOxYXDUtcQjAZbSvOhsxuYFOTQiF7XQwsPGtoj5dj0r0DrCgvg5d/kdj6yiVTPtJ7Mvrts+KrbBtYZfYA2eysn1CglYConM9++MdGmQTSYLGwOwuOWekdoPMqD5pGu2vGiTjtFqcFpKAyMqo=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 VE1PR03MB6014.eurprd03.prod.outlook.com (2603:10a6:803:10c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 06:59:14 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::833:be72:6b04:dca9]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::833:be72:6b04:dca9%7]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 06:59:14 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexey Klimov <aklimov@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 27/54] lib/bitmap: add bitmap_weight_{cmp, eq, gt, ge, lt,
 le} functions
Thread-Topic: [PATCH 27/54] lib/bitmap: add bitmap_weight_{cmp, eq, gt, ge,
 lt, le} functions
Thread-Index: AQHYEIjPo9nXWMzm2kuiFGM12Wjfm6x4CAuA
Date:   Fri, 28 Jan 2022 06:59:14 +0000
Message-ID: <e3409b9f-a671-9500-982d-38fe31b8eaab@fi.rohmeurope.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-28-yury.norov@gmail.com>
In-Reply-To: <20220123183925.1052919-28-yury.norov@gmail.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 690ccada-4e22-4b4c-9ce2-08d9e22bb1b5
x-ms-traffictypediagnostic: VE1PR03MB6014:EE_
x-microsoft-antispam-prvs: <VE1PR03MB60149523A26FCE7BE9327461AD229@VE1PR03MB6014.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0asUgvFmkQ9K6O/Ct9UPjLYj0UrYMZwReCgA8jbX0GiwRRRJxshnOD7eS9fpaLDXmok0/JYU6HFv4XiXLIVsHbv9K+WuL7kFcRTC5r3tITqkNVnvvZAgDN+joAk3gcGT/9ArImxHaSwSAYsRTGoR8+5lI05wVMa5dGZY1v85Y15qaSML0plRh5QA32WgGcl7xcpg+fcRLXFHNS5msVco3D7KaLq017kyafdlqVFX5mD0DaqFfkeBmplN3G41KtBkMAhC4aqtAcvUJvgmcGkH0JKmDya0GVV7KMP9X76hZmqg7PlYBxTwdy0gnVyH7fOVWKx0LDegMiStUnd4KakFSAT6QcOOwqf0f5V5Re3gwVGuww8W7AQqBsjykuW+W2C/6+7s5/9DPqKswFOpZcRMuoKFRNxFStKrxflpQBLUuqTh/1OAygHEf6zNPCsqoomFVmUodH4YhWX/6YOAp+yG5E7kSJgMB5M3HJeb1Pm6cIrnWREcIFzFC6DZ/CXYA2CrmugxBxLCLKpnxcqjAA3f7raOMyBQelUlOxou8lm90VTjk/JAFWWjyq8JksdcAZVIFYyv+Va6YBKVzPeULGcBdkvkgc8VkcFe0beCf4HPeBr58wxZSZy0tAgq7N5maXmjzBb0O8rTpguVqZo6gTZd74tTYVS3gwLMVi8486fLSFC2WyquHWjLdboGZt1YwnFX1YT5vFrepOEGTWOenokKRLFJ4m4FvfzYh222emD8sRb+9b/V8+vZQ1YcoUnPTiJ9zRzPL/9GMhr+fXNhSNR/4cZJFqaoXnyED/xrPudw9VVlFc8YYSP0EprgJ/MiIHK8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(26005)(71200400001)(31686004)(6512007)(6506007)(53546011)(186003)(83380400001)(2616005)(66476007)(6486002)(921005)(122000001)(2906002)(86362001)(110136005)(31696002)(7416002)(38070700005)(38100700002)(8936002)(8676002)(5660300002)(508600001)(76116006)(64756008)(66946007)(66556008)(66446008)(16393002)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXZOdEhyWllCRmNYcitDeCtITlFBcHYzZHVHZzl1Y3A1V1NMWHh5N3RsQi9D?=
 =?utf-8?B?SFRYcko3U2lPLzluQ2Y5UmhDb0d6MzdkVndSSmZtM2dQQllRaVUyY1o2VTha?=
 =?utf-8?B?Q1ZiOGtTOVNVL1E2bmQ1ZXRzdzA0N2JwaUloR01mbXhmWS9QbitPM1VzUStH?=
 =?utf-8?B?MUlXdFdMVWRSS2lqaHEybmJIbjlrMUVJK3ZZYkwxMVRSdUY5aldRSFlGU2dF?=
 =?utf-8?B?Q2UwTUkrdyt6TW05R2I4WG93eGdXQXpCeFZwZUtHT3ZMOTM4Q0FmNlM3SVJy?=
 =?utf-8?B?RzhDY2tJd2Y0OXc0ZlRtZEs3N09yWDkyenRTS3ZwZkNON1JOUXdzbVkwRmFx?=
 =?utf-8?B?MHRuNE13aFhzUU5wUGdaTUVnZUI4REZYSERjd2hBU0REWkJwN0RXdk9pdENr?=
 =?utf-8?B?QWY4ektQbFk4ci9ZRXBKd25Lb1dvbmMyakpHRHAyblZweFNSQmdoNEV0MzNI?=
 =?utf-8?B?VmxwVUxxbDZtQmlaWHRHUWZCbkZVZkRyek02dHVURTVvZ3ZLMWFhRUNDYjAw?=
 =?utf-8?B?a1Bzei9jU1o1WXBWSldlRG1tNEo1akdFNDNpa05FbGROMjVBRUFlYVBQTkE4?=
 =?utf-8?B?d1gxdG9ZRUxOYmxyaStEdUVjbGtNSEZzV3VERmw0ckZwenRod1lxeTV1Q0s0?=
 =?utf-8?B?YS9IaWJ4TlB2WTdCMGdHZVNaQm1YMmpyaXlHZmRIQkhESlhDdXZvNVhlZ1N3?=
 =?utf-8?B?a2ZrWXpjSmJLWlBUdVp3Sm43K2RhTmZUYjdQY2FhZkxuTXpwNGQ0ZjhjUFI1?=
 =?utf-8?B?c20wQzMwTGRUUEJZVVlETDFySlQrZEJyNDVSRjZKcUVjQlRTdk5sREtXTGtL?=
 =?utf-8?B?bk9oU2tFTkkxUndyb2l4bUlYeVdpc3dhRXhYNlc1bjk1VWpUV1c2MHh1azZH?=
 =?utf-8?B?UmdOSkxtMlRDTFdIVlVjZDBLa3RyV1B4S3BWdEoxS1VjalpmcFdaMVFXZTJF?=
 =?utf-8?B?RVN4SHpzYTVnTW9OMGFWdmVmUlVFMjhqS0J1RDlubFZDVWFBaytnaS9lNElp?=
 =?utf-8?B?OFNXaHFCb0dFUFh2QnRKN3FlaXdQbTllbFVaQThremN0RFdOZ0FUMUs1eVZZ?=
 =?utf-8?B?MEVIQjVMbkMxWXNLeWN5dzgwd0VEbUR0cEdmM1hiT3J3amk0M2tpbEVDOGZu?=
 =?utf-8?B?Ym9OZXdlMG1xSlNXQWR3RDk1NWpRWFJLMjUyTGprS0M5eDM1MWNWTkNvSjJB?=
 =?utf-8?B?RnRmS04vbmpWWWY3US9RL0JhZ3lPSmJqQ0k5NlJwWHc2ZDNtWUtyazBzRytE?=
 =?utf-8?B?ZmRkV1FOWGNiMkh4YjMzN0ViUU12U3drUmJyS0VIUXdHMGVkYW9IUW9MRkZw?=
 =?utf-8?B?dG9SakRzVnhKT2QxYnpiSHN6aUNXY3h4L05wcGxRb3o5a1d4ZXplUm1EZlRD?=
 =?utf-8?B?MlNNWkkxeVArcDNNbnBpQTBSVlJoNmMzenphMEVUTlM5RG41ZVppdGlGMktT?=
 =?utf-8?B?M2hXNS9TNkxkSkYxeWNidGdsZzUvZTROb0JEdVF2REV0b3hUOEp2NnpmeGgx?=
 =?utf-8?B?RjBvbHNXVjJNVlJUVlNlY05JdENqQXlaK0I3WDVqMkhyQllQTDVqVTlkOGd5?=
 =?utf-8?B?UGdEcTIzT3FhVlQ1RWEvamNRTUxIeXpITXdnYUxBTWlvVHZwMWpuNUtmc0JB?=
 =?utf-8?B?b0lJZzUzbHFZOFJzcWZ0L3J1L0FGTVJ5UnQ3QVhTbFpWWG9ReFlPMlBLOWN2?=
 =?utf-8?B?Y3k1ajFaTkZMQzhINXVKMDkwTDRzT243aTQ4VTR3UlhQc1lpN0VxSFhBeG9q?=
 =?utf-8?B?emtvaktBNzFaOURnZnkwSkdSaVFBUDc0TzUyYnhiRmJUbXN3VnpHSzZPTVJH?=
 =?utf-8?B?V3g3V2VNOFBsRUhldDFUQzdnVFU5UFB1MENkK1lpZ2hSTDZjRG9jZ3JMTXhS?=
 =?utf-8?B?VVZDTnhSUjhaVXRxMHU4b3VCZzVzOFJjcU11Q0pJeGdiQy9TMVhrMlRFaXNk?=
 =?utf-8?B?YkplZG1pcUw1SDdFc296Y3F6cG5wTHFXSTIyUDZHenhoVmVzaGhaODRuZloz?=
 =?utf-8?B?WHRJQnJ1OU1yUnFnZzZuY1ZHd0pUa3hRKzFHWlJScWtIZFdGWFZyNURwcDhO?=
 =?utf-8?B?elhVTDN4a3lNQU9iNTBxMjViblJBa1J1MkNoWElsOVBIOHVuNkIxMmt0bzdI?=
 =?utf-8?B?OFdjVCtqYWZBclZWZXBDS2dtek0xaXB2bFdFRU9wWkxIREI3Q21SREJWS2Fi?=
 =?utf-8?B?RkNkRlY3dytZbjdLdHJnMVBUTGwyeXNudkY4WDJIVXByRnZENjVQM0hxQmhW?=
 =?utf-8?B?S3h6ZE1DTTdaT25idkx6TGx5YjJUcDhyUllQUVUzWHJGblpMSTBmditVVDdL?=
 =?utf-8?Q?h7+RRboxSOWgH1WhG8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CA7E0C25293464A9F7A1B87E22A1DA5@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690ccada-4e22-4b4c-9ce2-08d9e22bb1b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 06:59:14.1795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2wH2d6VYGlOwYc3yPw1lO8iKvfqYGjbvqEP/13FhEcoWweE3jgQvUXysi5v1VMDjMjYIZrVHzXi5q2KceRYH0itKzOmmw2/fSmG5vhoRApBRC+xhQ3nLGOs+bnkcOiVD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB6014
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yMy8yMiAyMDozOCwgWXVyeSBOb3JvdiB3cm90ZToNCj4gTWFueSBrZXJuZWwgdXNlcnMg
dXNlIGJpdG1hcF93ZWlnaHQoKSB0byBjb21wYXJlIHRoZSByZXN1bHQgYWdhaW5zdA0KPiBzb21l
IG51bWJlciBvciBleHByZXNzaW9uOg0KPiANCj4gCWlmIChiaXRtYXBfd2VpZ2h0KC4uLikgPiAx
KQ0KPiAJCWRvX3NvbWV0aGluZygpOw0KPiANCj4gSXQgd29ya3MgT0ssIGJ1dCBtYXkgYmUgc2ln
bmlmaWNhbnRseSBpbXByb3ZlZCBmb3IgbGFyZ2UgYml0bWFwczogaWYNCj4gZmlyc3QgZmV3IHdv
cmRzIGNvdW50IHNldCBiaXRzIHRvIGEgbnVtYmVyIGdyZWF0ZXIgdGhhbiBnaXZlbiwgd2UgY2Fu
DQo+IHN0b3AgY291bnRpbmcgYW5kIGltbWVkaWF0ZWx5IHJldHVybi4NCj4gDQo+IFRoZSBzYW1l
IGlkZWEgd291bGQgd29yayBpbiBvdGhlciBkaXJlY3Rpb246IGlmIHdlIGtub3cgdGhhdCB0aGUg
bnVtYmVyDQo+IG9mIHNldCBiaXRzIHRoYXQgd2UgY291bnRlZCBzbyBmYXIgaXMgc21hbGwgZW5v
dWdoLCBzbyB0aGF0IGl0IHdvdWxkIGJlDQo+IHNtYWxsZXIgdGhhbiByZXF1aXJlZCBudW1iZXIg
ZXZlbiBpZiBhbGwgYml0cyBvZiB0aGUgcmVzdCBvZiB0aGUgYml0bWFwDQo+IGFyZSBzZXQsIHdl
IGNhbiBzdG9wIGNvdW50aW5nIGVhcmxpZXIuDQo+IA0KPiBUaGlzIHBhdGNoIGFkZHMgbmV3IGJp
dG1hcF93ZWlnaHRfY21wKCkgYXMgc3VnZ2VzdGVkIGJ5IE1pY2hhxYIgTWlyb3PFgmF3DQo+IGFu
ZCBhIGZhbWlseSBvZiBlcSwgZ3QsIGdlLCBsdCBhbmQgbGUgd3JhcHBlcnMgdG8gYWxsb3cgdGhp
cyBvcHRpbWl6YXRpb24uDQo+IFRoZSBmb2xsb3dpbmcgcGF0Y2hlcyBhcHBseSBuZXcgZnVuY3Rp
b25zIHdoZXJlIGFwcHJvcHJpYXRlLg0KPiANCg0KVGhhbmtzIGZvciBwdXNoaW5nIHRoaXMgaW1w
cm92ZW1lbnQgWXVyeS4gU2VlaW5nIGhvdyBtdWNoIHRoaXMgaGFzIA0KZXZvbHZlZCBmcm9tIHRo
ZSBzaW5nbGVfYml0X3NldCgpIHN1Z2dlc3Rpb24gLSBpdCdkIGJlIGEgYml0IHRoaWNrIGZyb20g
DQptZSB0byBhZGQgYSBzdWdnZXN0ZWQtYnkgOykgSSBkaWQgcmV2aWV3IGl0IHRob3VnaCBhbmQg
aXQgbG9va3MgZ29vZCB0byBtZSENCg0KUmV2aWV3ZWQtYnk6IE1hdHRpIFZhaXR0aW5lbiA8bWF0
dGkudmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0KDQo+IFN1Z2dlc3RlZC1ieTogIk1pY2hh
xYIgTWlyb3PFgmF3IiA8bWlycS1saW51eEByZXJlLnFtcW0ucGw+IChmb3IgYml0bWFwX3dlaWdo
dF9jbXApDQo+IFNpZ25lZC1vZmYtYnk6IFl1cnkgTm9yb3YgPHl1cnkubm9yb3ZAZ21haWwuY29t
Pg0KPiAtLS0NCj4gICBpbmNsdWRlL2xpbnV4L2JpdG1hcC5oIHwgODAgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgbGliL2JpdG1hcC5jICAgICAgICAgICB8
IDIxICsrKysrKysrKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMDEgaW5zZXJ0aW9ucygrKQ0K
DQoNCi0tIA0KVGhlIExpbnV4IEtlcm5lbCBndXkgYXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KDQpN
YXR0aSBWYWl0dGluZW4sIExpbnV4IGRldmljZSBkcml2ZXJzDQpST0hNIFNlbWljb25kdWN0b3Jz
LCBGaW5sYW5kIFNXREMNCktpdmloYXJqdW5sZW5ra2kgMUUNCjkwMjIwIE9VTFUNCkZJTkxBTkQN
Cg0Kfn4gdGhpcyB5ZWFyIGlzIHRoZSB5ZWFyIG9mIGEgc2lnbmF0dXJlIHdyaXRlcnMgYmxvY2sg
fn4NCg==
