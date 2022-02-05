Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A16E4AA7CE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 10:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbiBEJMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 04:12:32 -0500
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com ([40.107.94.70]:29889
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236403AbiBEJMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 04:12:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ax6Z4IBFMZeKhchpE115uMILWF1bvKFpvzWJXND7h/ONNQ7Na/vpu62gVA6RkTVGv/dyn2RZnIVfv49JdWKDQNFJDugfJMdzxcxAA+iGHn0ihh6xJU8FwL7PBHp29SOfCoo7wsFWUacA1VlachkTvELChCeshXSkTV9teb+Y2dmanfE8h3U7X8m5AIq5U1HnAmBa1yVUviEGNczpinhn7gWVj1Lk9w5TGsUwSgOZ7iQTQoVTbJOnwrqAqi64Lf9ExzcFK51fgpYcwfNjT+aYDsrAmj911nKb/7dUXDXrVjzmT+EqivA3w5YU9ChjhtoN2iqADjJsnZvBZ7QQeZ7Gtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvqiwFdr7jKRArtm9PykPJaZFn7YtxKfOsv48/eQcWQ=;
 b=LCrt9PrKw/6meiYbBIlPaPfsi6ecSXpVJU/Zb6nBEkAKh3RUcNV9+nwxZtrGJTkNt+HicVqW109Lmo13LVXtRPiDvCCLgRDKAP5N7HwgIgPBOM5ZUyFGHhERvvExPyTvKeeOcTLZnNJvCi9LNqqaCMbepebEfTUAEUgD7kIPZYF0Bg7hEYPxVZsjJMCfw3xC5vfxB0g3iIJGCvTMVhdZbbAUoqKQX54q3Y6ZSqN2842zQVbdU3LESb2fazoInsQeSixr2OUOHO4WEEArWdNmKYUxyKBj8YtlKPezPabszspseTb87HYgYUyLmKr3qT1Jz+XUWvLg1EWVzjzZi9tNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvqiwFdr7jKRArtm9PykPJaZFn7YtxKfOsv48/eQcWQ=;
 b=JJRmbYvyJp4lioDHA7BBOexGrXkH0IqME0pET5kDqwpunqzwCwt8Ei9WmLl9LOLpYXD1VpWBidvkmQ5kVDrJgVkE1OmkuQH9j00l+c3S6mFQ73bczya9Z2p8Q1AZR20qsCvXdIHqVHzFNKlTuUTEYM/h/PPkWY5z5QM3n/inW+GXbQagbwmXGVdmbV94r07DH4Cou+kZkYYaDKDDD3T/3LpMnxZAL5l0xq+pZtfEdDlRa4w6v5PgWoTSzLNeezzvOK5E7zysBytS4XAAZMW6Zifx3Ob2rjNQB/3kGn9r2OLUFM2E7SIP8Jljre9Frme00L78zW1qhTbZCMD9vsdnKg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1760.namprd12.prod.outlook.com (2603:10b6:300:112::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Sat, 5 Feb
 2022 09:12:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.014; Sat, 5 Feb 2022
 09:12:29 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [v6 PATCH] block: introduce block_rq_error tracepoint
Thread-Topic: [v6 PATCH] block: introduce block_rq_error tracepoint
Thread-Index: AQHYGTpVkG8xOIk86U2gPDuEJ97j3qyCsFwAgAEBvYCAAPxxgA==
Date:   Sat, 5 Feb 2022 09:12:29 +0000
Message-ID: <5eac186c-918a-87d6-8cc7-85d4d24c4837@nvidia.com>
References: <20220203201207.1075933-1-shy828301@gmail.com>
 <302fa562-612b-0853-31de-a11399e5aa08@nvidia.com>
 <CAHbLzko1izwBERS6auEna+eAGzQVA7zkDihMjT=tt_EBdhfmaA@mail.gmail.com>
In-Reply-To: <CAHbLzko1izwBERS6auEna+eAGzQVA7zkDihMjT=tt_EBdhfmaA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e8dd13b-c333-44dd-1316-08d9e887a2cf
x-ms-traffictypediagnostic: MWHPR12MB1760:EE_
x-microsoft-antispam-prvs: <MWHPR12MB176042A4DE5EEE21256C4D93A32A9@MWHPR12MB1760.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eVDuYasnjtiHkL/KqlFAosNK++EWmOqSW3HGUs1d+DrEKcZbf+p5AJRuo2oYkTrTBd7I5JHmO4P9TFN7qf8UslciweeMnyrGIQTKkI4HTfvWgns+v0em0cQPStFRK98KwVS55c13vGpbr7+bigmcPXxXTpBITtNJmSXHGcLUqfEsyBCPgEq0PZgklV6p0ID+aPjrD96UEh1ch2kKilZv6IlqjxJ6kiNfN+F3nW16k30nTMvqSPTQqSCPSlL5hZarUdpex3QAadUIqmMI8xpqweq2OIWb4zonSPatUjCgYoWWlWL7UhIYRC0fIaXI8mG7qNOhAaqUX2Aat6Q011gjQtFqzh3943/9gHMUSrodNCTD8dnxT8LzIwtf0j9jM/KaTPw1PHEV+rZM5H0XOFvft6V9L1qhzwjnxA/zTyfEReAL/1t5+dmluQcH8ktz9aM1o2di6T9u+L10w1s/KWtFnq0JbNfjWwNzoFBfQv4kq+dSHez87k7ZgGXcsReHGvKpPHVMKy5Dht2OyExcqhdB8l24afyndKSc2+UT6e1fmBhyv7Oe78Mfq8XKUl/BvO8GKs9fUTfe8iA1eRZ1aVI2ZX8yzn05eO/1gdTFSSygMyQ7g3ie4DY43EWzaEuGIMASa/jGfT19v11EFLIdlQbsUFYdGnjaraaEcxaVZstpy/ssDzUYo7BApQjtLnV2pMFQsqvnLcOOXQ/MZLB37seMiHdk0RM3xcBcVKQHeNSQh2/0AvV4Vg74HXqPxZBhG/ymC31ZH1MWf8sT3VWLRO83DQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6486002)(2906002)(316002)(66556008)(6512007)(66476007)(4744005)(71200400001)(508600001)(36756003)(31696002)(6916009)(66946007)(5660300002)(122000001)(31686004)(8676002)(38070700005)(66446008)(8936002)(2616005)(26005)(4326008)(76116006)(38100700002)(91956017)(64756008)(86362001)(6506007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d01nZmtPeG1hRkVVTFUzLytOdUtvbm85dFV5QmUxM3BNb0dpdDRsei9ydnVZ?=
 =?utf-8?B?N05aNk5jUmlLK1ZjMHlwMThnbzlXTUlYa1A1MTlVUTVjTGdBYWRLV3JleU96?=
 =?utf-8?B?Uy80Z0l4dFg0bUxsZjh2bGxEcDY0MlRzWU1UOU0rbU9Ybno5OURNWWw5SHRj?=
 =?utf-8?B?enk3YkowSVB2ZlUyYVAwVlJlVUNySXJIeG5BVVdzZHBrem5GSzZhZUkwTVRF?=
 =?utf-8?B?UVdMajBoQ21YWmQ5KzZpSzFYdmhpdTFRcGhUZGlYTXB1VUhTWTRPb1Jsd2w0?=
 =?utf-8?B?cGF4QzVabGZJSTRoZE1MekRYSkNQMGRsU29nVnl4Ty9uemNhUzVwNEdiOW1W?=
 =?utf-8?B?S0dVQWswM0hHeVR0YXdYRnVRVVZlWTJHd1VGbStvZ2RsOW81eXpxR2FuOFBn?=
 =?utf-8?B?Y0FsL1lXQ0xzT0M0ckdBWGpBSTRScndObkJwRHJZcFRob21STGRuV3VxZ05N?=
 =?utf-8?B?TVZlcjZVQ3NNVm9ud0hLc0IycWlSdUppMVlBclh6ZnRCNThGTVRBZEsxQjhQ?=
 =?utf-8?B?dVFzWTJVMzVoNEFGb3Z5Z0tBN0luSzBhY2FHM2FuOVBBY3NKK3R1RFZnR0JR?=
 =?utf-8?B?WHNsMUk2U1N1dW9uNjF6bURmMHJCc3hzeDZvczZEWFd4RVM1d3VESlZpRUNZ?=
 =?utf-8?B?bUtSWGZmZ3pFbmZrZTlHaEozZHJESjFSMWRCK0hJbHVwS2lpc1dXcW1NZ1RH?=
 =?utf-8?B?bjZGV0ZCaHlPU3hIWDVMMDRlQVZuVkpTQytBMU5WbVVsbG11NkZpaTQ0YXB5?=
 =?utf-8?B?MitmOU1pTjFpVTRmdjdpakZBL1QrYTQvM0ZEYWNIUlpWZzdneHd6S3BjSGdQ?=
 =?utf-8?B?K08vcll6NklNeHpUTzlrT3RGREI5eG5aRDA2ckhpcFMvVlRPVWFYS3I1emZa?=
 =?utf-8?B?RXZFTjZ5NmlORThTQ0NBY2ZGdTJYTmJHY0V0blZrb1Q1dDZ3RnI1bHRmOTg0?=
 =?utf-8?B?QzZLb0tLRlk1bGw0bEo3d290WFFoSjZhc3NNWFN6ZStoTm1VV1ZTMncvaEla?=
 =?utf-8?B?VndJSTdMa2N1Z2NxR0kwaTJmZUFPQ2NJbGlRTE92RGFNaXU0YWRKYmg4VVRu?=
 =?utf-8?B?M2dZUGkxUHo2V1pRTFJYRUpYM0hXVWpucTJiVUNvZHhiSkx1TWhZOE93NnND?=
 =?utf-8?B?WTIrRnVrRlMwUk8rV1RGWDY1Qkl6REdPTUQ2c2JNZzdKek9jYURyaFptazFX?=
 =?utf-8?B?dnpLN2I2c1Y5aUdteGdKMW5ZenFrLzdVQjNrbU1DaGZJeEZtaTZxVjZKb3l5?=
 =?utf-8?B?WHBibTZWTUNKQVFtaVBIMlp6SU5lbjJGRjhJRVhQQ3FzUFpUODF3NkNqalpP?=
 =?utf-8?B?U1pkVlhNbDhJekkza05IOEhQbVluamk1b0Z3d2FuRjZuS2U2UDdFNWowL2Nt?=
 =?utf-8?B?by9US1hLSU1udVlGRnNMTjJ4ZzNlVFBNUVM0eW1XMTlpNjhwcUdNT1hMOEdV?=
 =?utf-8?B?NUZQUXo3ZnkwaTJialc5QVJoeTdISXRxOVFtUXVtYzBOQy92cWo1RnE0WUpC?=
 =?utf-8?B?SlNGSEZNVmIreUc4YUhpTk9vc0UwK0s2RzlTUVp1SGZYN2NIZ2FQVVJ0ZGQ3?=
 =?utf-8?B?Mko0QmhHeURxRnV4MGdCR3psaFNteEhOU2hTTkVsRnEwWVQ0WlpVLzJCeVpM?=
 =?utf-8?B?bkNtQWpJc3QvODhXMnNQc21SbTlMK1FMaVQyOC90b2lJcUJUdTZVdVpsYUVC?=
 =?utf-8?B?NXNpakdoOTJoYjJMTTZhaFpCR3NlbEEvcHlqNXR4ZldtbnV1bmp1YWhmODhM?=
 =?utf-8?B?ZnN0K1lsMmYxWWJqbC9pTUVLRmhDWkYvTVhSL25Tei9TMGhQWDgxdGlaaytK?=
 =?utf-8?B?bDk1ZDd6WWJjdlZGTHFlK3lRb0lDTzNBYUlYejAyQjkzM2ZQQ2YzLzBWVkZ2?=
 =?utf-8?B?OUVodXBMU01vbUlNcERYWTViWHluQld3K3lUMWN5WkZ5M0todndJT21JK1Bp?=
 =?utf-8?B?azVqWURITmVtY211aDdjL2sxUGNOK3pmZUpmWk5TWTFKL3EvTDUwTXFpUFFo?=
 =?utf-8?B?T0I4eUt2eXNYSSt1d0tLM0c1NzFlTU00RThCSHhBRVVHUHo0T3Q0ZlF6WlpP?=
 =?utf-8?B?dE5XeHZFTWpXZm00M1NlL1ZHVVVTWUFJTkFaYi9FajE4L2RyZjNuSkplWit1?=
 =?utf-8?B?R0hEY1JTeWw4cmtIL2dSRTlDT1NlMXZlZ2g0bHU1bmNSSzEvcUt5OWYyaDVm?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BC96074CE8AE64189DD53ABC63E7E2B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8dd13b-c333-44dd-1316-08d9e887a2cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2022 09:12:29.8563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +KG89RCtE/Iltbfpt/dBcZwOaep9BVp5MEXC+VfjWTyj2kOhpdmt7xzw28N6DERHFfcBOHLqIQ5RIWlWvRlMUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1760
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+PiBzaW5jZSBpZiBJIHJlbWVtYmVyIGNvcnJlY3RseSB3ZSBuZWVkIHRvIGRlZmluZSBhIGV2
ZW50IGNsYXNzDQo+PiBpbnN0ZWFkIG9mIGR1cGxpY2F0aW5nIGEgdHJhY2Vwb2ludCB3aXRoIHNp
bWlsYXIgcmVwb3J0aW5nLg0KPiANCj4gVmVyeSBnb29kIHBvaW50LiBJIGRpZCBvdmVybG9vayBp
dC4gVGhlIG9yaWdpbmFsIHBvc3QgZGlkIGhhdmUgZGlzaw0KPiBuYW1lIGFuZCBkaWRuJ3QgaGF2
ZSBjbWQsIG5vdyB0aGUgdHdvIHRyYWNlcG9pbnRzIGxvb2sgbXVjaCBtb3JlDQo+IHNpbWlsYXIg
dGhhbiB0aGUgb3JpZ2luYWwgcG9zdCwgc28gSSBhZ3JlZSB0aGUgZHVwbGljYXRlIGNvdWxkIGJl
DQo+IGNvbWJpbmVkIGludG8gYW4gZXZlbnQgY2xhc3MuDQo+IA0KDQpJIHNlbnQgb3V0IGEgVjcg
d2l0aCBhIHByZXAgcGF0Y2ggYW5kIHRlc3Rsb2cga2VlcGluZyB5b3VyDQpvcmlnaW5hbCBhdXRo
b3JzaGlwIGZyb20gdGhpcyBwYXRjaC4NCg0KSWYgeW91IGZpbmQgYW55dGhpbmcgd3Jvbmcgd2l0
aCB0aGF0IHBsZWFzZSBzZW5kIG91dCBWOCBvbiB0aGUNCnRvcCBvZiBWNy4NCg0KPj4NCj4+IC1j
aw0KPj4NCj4+DQoNCg==
