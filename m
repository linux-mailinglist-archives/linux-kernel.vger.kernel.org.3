Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E438359ECEC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiHWT4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiHWTzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:55:25 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120042.outbound.protection.outlook.com [40.107.12.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1509213F8E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:03:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8BkQKDtSmZXLP6qZ1lcNcliBiUFnds4rgKKIg8gu4Edruq9oobPhcrs+OQo7p4DVyU9DQX/OZhc9fn6mkLs7FEnNCgT4N3frABrsIWk+eQNm2t0z6MF92b1878A7Z6NPH3ANAbfvQgZk9EM6oExqd2r7ftS6+u0jB6JpRD6d7gooAT3JgGU96+a8gIvjrjpkpq/RzIee2yGiDhRBpeSwAHgPss5QI0l4NGIsFFQAQPHVT9btPQyN4gi8vGnvvSQwXqOOWfDwgqFCA4/qaD02+WZ4dGbSNn5mgINBtUG4GAoYfKcSi6iXd27b+MgMvJVHX7214IorQpDGjjZlW9pNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJNBQccvH/REq3SaZTwuI0VCBPQoefkVFJWZfRU4h7w=;
 b=dtE8pVpt/S5SLPXMw32FbvvvmsG8b+SZPuNmUhBiCY1ppGA1jzXDCFXDM2fYdAMTn3vsMNgozkfT3t8ZXoJ4aC+0nLBbX/QJRjY3Da78ae9iAjKLPa5K1lVC/ZpD475kfXgGexKOyZbG3jNIuS7hMQJpZJfL0+IemkEs4XU+k5UAc9xuHvo+gExG3p0vTztpc3eJG8DqXH1b9krGTu+nRTUNQuKzvaLAiGxrykRCFvzDrrDm5CU9O2tSc7pBXDSnxPINhU2JBLi4OzpTBiZFUQLZ8wdISHCUYUt0CYkALeWos99L1/KTHKuO0U9ncms3AQlBMBN1Ti0K3C6xfuAtRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJNBQccvH/REq3SaZTwuI0VCBPQoefkVFJWZfRU4h7w=;
 b=rIdpf5OGx4xRFe8JDOlSCFYFBhoI/VaVCn5swIdh8in9oqitBBWoD2HEDpZKOtDgOJ15PQ/XoQABxpYvOOw3lL+4zHRvgJe7xA09g7FLYnmgs9qvPvzjX1OD5Qcb46fe894T6pCpi2h1NnVzAsiFo6HuNITKd/4eGDUt+Fc094ouc13zN9FlZe5fP2WHEldjhegzMampxE5qTMuzgEvBIre1uBigcbf/pQR/ZiCz7VOU/oj6TSS/MxlPU9KS9MgffOs3dla+PLJ8QFyKDV7TYhR6FbzFExHov2vKD12ifdz2fXi2Sdj+rB3Rz4Qfc9XOwPvVDvFVghRO62Swfvic7Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB3006.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Tue, 23 Aug
 2022 19:03:12 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e%5]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 19:03:12 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baoquan He <bhe@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 02/11] mm: ioremap: fixup the physical address and page
 prot
Thread-Topic: [PATCH v2 02/11] mm: ioremap: fixup the physical address and
 page prot
Thread-Index: AQHYtCx+rO/zUftR00aLhjCOF9ttT626eSKAgAE7M4CAAEcjAIAAdQ8AgABtGoA=
Date:   Tue, 23 Aug 2022 19:03:12 +0000
Message-ID: <8df89136-a7f2-9b66-d522-a4fb9860bf22@csgroup.eu>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-3-bhe@redhat.com>
 <e7f8798a-43ac-8083-93ac-4581bd2a5647@csgroup.eu>
 <YwQrC3X3PHa0pNDy@MiWiFi-R3L-srv>
 <54b7afcc-056d-7f33-6858-d451a3222c70@csgroup.eu>
 <YwTI6jAjY68QK5h6@MiWiFi-R3L-srv>
In-Reply-To: <YwTI6jAjY68QK5h6@MiWiFi-R3L-srv>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94b393e8-a12f-4f3f-571f-08da853a2086
x-ms-traffictypediagnostic: PAZP264MB3006:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZL9eD/HnVUDxQ9LuZ8JQaN29fJnbp9wvunfiAmWrKcvKqwbaR3Wc91LluOjBE8ddWgb/VSHl28ttOgIfJeAkGd5lK9Xht9Z9dAXqL9RBkQvmuMmS5sGtZ876HY12HzsrCZ+SJvjbKrExEi3FqwpTitVgo3icuBspFlucH1WN0KH9t7skKRABaAU574lA2PE+IFPr23/GSVp87D9oepwu9jvS3/LpKxZgKgmF3juXV8IJ4jtDbgEVyFsrXE/DMtedNmE9c/ymFBm4Z6mEzU1jumWnqbwnAnN3zUKW4C/7Ujm7eQfyJsUT2u4IpgO16BsmgB2zeq+EdmhQbOJujOL0+5nG8htSnq7+OjyRaktjneBLM/9Rd0WlWmtNoviunAYlnD6iZcapPK6BBYjC/bk4LctXMbzaGqTZSTLPgfFbDit2usDD4SD3GnRneJ8LIKD3mpszkTUjwmcA+b0aRkMUtwvSTlM5oXuPWPhSCnxm1/mvlSahmaUlfAviPMh5qoqhD3B3/s8Nr5ZTh6+LFGvcHYOPNj7Bo3/Jc8KfaHJwXcDidyuKWCHdJXyIEZCBPxUrWlrqQXxwj5MgZMVCa0UJvppYSauDEOPEu4vbizbrFPGoxDuQWTneP+kgrXASIbFyayqMeHGB1cMGcqZidnzdEbrN8/GrF1qlnsQ6JnyMjDzLZbxzmjRux1Gt2MSXdOgA7eLE7yirmh1R3Ky1fDoSfoR2QRTfLlZGPPyqP6ny0FydLyZzHRa2IvpPe4h2aKGbf2QOJ4esDDZMm5oRXbZL2nSRrGbrXZvkLydzC7U/ktKx1e4hHYYuGEEJWAZxe1wuP6oA5C+G7g/k1MlAUPn3cezf2pS3svZ8dLJmRXD0c3A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(376002)(366004)(396003)(136003)(346002)(38070700005)(26005)(31696002)(86362001)(38100700002)(36756003)(5660300002)(41300700001)(31686004)(44832011)(6916009)(8936002)(54906003)(66476007)(122000001)(66946007)(76116006)(6486002)(71200400001)(66556008)(316002)(66446008)(64756008)(8676002)(966005)(91956017)(2906002)(2616005)(6506007)(186003)(4326008)(66574015)(478600001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QklHZkpwZkt6ejFYdEYzc1dDeVFQYWV2RjB4elN5MHNDQ0hOOXNuYzJ6Znl3?=
 =?utf-8?B?d0FIeDZIbTdMSFNsdDFkWXNkNUszK1NteUFtc1k2eTJXTjFoWFJPYmxzZzlx?=
 =?utf-8?B?Skd3OW9rYW1jV2JmRUlzMnVmZkxHcGxPZUpUN1lreG5XN2NFdERHTUFENC9V?=
 =?utf-8?B?UDJHZGRjNzNySFNuSmgvTWdDaVZsZmZqKzdPMFZyTEg5SXZtL1ZKamgyV2Nt?=
 =?utf-8?B?MExVVm9Ba1pxdmtiVHRVTnJZcVZNbmh3QmQ3Nk1OWWcwQnNibmhFS3pzVzFi?=
 =?utf-8?B?Q0Qxa1NRNHVzMmdha1dxa2Y2aGF6eWU0RG1RVWswYUdxdkFlQmppUzlWR3Uv?=
 =?utf-8?B?Mm42OWViVW8vMEpYU000OGk4MVNnc2h5T3piNVBvM2NtRzVuZUVtTHJrYmxx?=
 =?utf-8?B?WHU2QWJFZkhPc01ZMW1HaFV4TGphNlVoc25Hek9aTXAvV2RJNnVmUnVxanlz?=
 =?utf-8?B?aEFlc3UwUEk1Tmg3MzJ2YXZ5Rng3YVIybDNLOWRHRVFCTlBlalhYMHZ1dWlu?=
 =?utf-8?B?UW1mWVdDK1NKM1FJQlpvcFZYOWNtVzNRUkZyd3RqMnhKSXRpRi9aZ2FKVHh3?=
 =?utf-8?B?d2tBaUc0TnNSN3QwVEdPOWJ6NjJxWEljenk4OWNjNzc0eWpKbTVhd1ZUSU0z?=
 =?utf-8?B?aVl0ZWJlWTh6NjRpbExCVXFRc2tRN2pKMmI4dFpnTHUzcHlxTk9OUFJXcjl0?=
 =?utf-8?B?U2l3QjlTMU9kRGdKWERGWjV1NDVrWUxxQmR1UXBUT202L1JsMGlTWDFBYTZE?=
 =?utf-8?B?dEJ5STIvWU1ZRE1yZTlZKzNYU0h2bm0xV3FsQzJ3OGRKZzBJaHZBTjdvcEFC?=
 =?utf-8?B?TEQ2Nlg0REZYY2wyT2hKTnBtckVaakZOT3JRNDhzNHhGLytmT21lQ3p0SEo4?=
 =?utf-8?B?WlY4Mk5aOGhiaEs1R0dDT21KRkIwdERUN1I4RUdGWnQ0ZHdaT2t0Y3RUc0Jn?=
 =?utf-8?B?VjdFTjFyUkMzRGJjdDlOWWxic1lFV1JGRjlkbFdJOStPcjdHYS81cHRPcVZt?=
 =?utf-8?B?SWpnRHNvcU0rbHVZdFdoWEl4Z0FTb05zelM0SjNmV3BlRFlXaTB1a0FmV3Zt?=
 =?utf-8?B?TWI4RVdlSGRnL1dQTkJBWVhtbCtaUlZ6TEFNTHpHOVlTbHM1cUo5bjZpWElv?=
 =?utf-8?B?R3pvT1RmNEp3ak1XL2JPaGEzeGxYeEpQem1rd1NmU3BRKy80SjJQWWpqd1Nr?=
 =?utf-8?B?My9OQnp5dklKaDVreExVRlZtbmhwZ3BBcVFOeHZxMUJkNVN0eGNhOUZ1UzlC?=
 =?utf-8?B?OHhpcjlVRGFCODdabW4ybGphbC9rNjBvSFNhZnd3NU1senB0QzlqL3BYYzZM?=
 =?utf-8?B?cEFOQ2JjQk5TSkhXV1I2RzBmSWVKdWpNbnpUZlViS1p5cDVyU0FyaUdMb09P?=
 =?utf-8?B?bk04WUdVck5oWVMrMmRvV2lJSUwxZEV4MFlDNFFvYzg5dEtJelNiSHBhMThr?=
 =?utf-8?B?SHRGYzhhVWJ2QWtIMHZqVVNZWWpNQjBQckRNU29uTElwQkNkK1Fzd2c5cmVD?=
 =?utf-8?B?VldkVkR2N2YyellGUFVndEFNVDdhNllxVE5aUVZ3NFZjU0UwY21hM1B2NDNC?=
 =?utf-8?B?ZTczT2grQnZ4WGRyR1RDQ3UrZjZodEM2S1RVei9hcHhkeWRZTkF5QmplVnla?=
 =?utf-8?B?NEdTRFkvZG5acDVPdkpSdzAvZ2ZBNklxcm9wTm1RTUM2ZDZDSmgzQVAwQU5X?=
 =?utf-8?B?MWhTblNqOXIxbWI4bVRTQU85Uk9QVHZhbkhBbEFYU3dvRW1KZ1lRTS9NMGRu?=
 =?utf-8?B?VUU0V2Y3TVhtUzhDODhtRUFQRTdONmNCTENrVHkyNDJocTM3dDBlb1JYTVJY?=
 =?utf-8?B?QXJCL2M3K0cxTyt2UTNud2Z2YVZ0UHVHaUVqakJkd3MrMGtxcXIxMExoaGYy?=
 =?utf-8?B?WFh3ckpKL3RQUGV3MTNZL2hyVjZXUFpCQk1yajkrb0svbzE2TUlTek4xQ09K?=
 =?utf-8?B?VEdnaGxPeVhEb2lFZlQ4anJGR25heUJFOXh5aWlEMm5rYklXYXpkeGJNZE93?=
 =?utf-8?B?SHdCVGFwb1c5WVArdW53VWliY3hXcXE0T0lEYVJqbUJQcFpkdEF1d2pzVTZw?=
 =?utf-8?B?clZlVnpjMHBsZE9xNEp4U3JDNkswWkNOQ1lQNUxVdjJvK2NORVVycGFVenBP?=
 =?utf-8?B?ZjAyWjNRWm1uaDZtbWNEWlBEMGtZMmVQSWxJZGIvZ3VIcmF4S2JKWkFhZHRt?=
 =?utf-8?Q?KVEoGqGKw9Cn/sGg7p1pZhE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DCF43EFC9A7A94D929C4876F231C5F1@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b393e8-a12f-4f3f-571f-08da853a2086
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 19:03:12.5994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3zt6SNPCYn1az24jEl4nFw535aHIL8FriDFusyEFpSIMp6FoM5c2F6bQdF853K0nR4N13AtbLwr2ZIwVZRGVtwVVadR9cYImc90EQbBVUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIzLzA4LzIwMjIgw6AgMTQ6MzIsIEJhb3F1YW4gSGUgYSDDqWNyaXTCoDoNCj4gT24g
MDgvMjMvMjIgYXQgMDU6MzNhbSwgQ2hyaXN0b3BoZSBMZXJveSB3cm90ZToNCj4+DQo+Pg0KPj4g
TGUgMjMvMDgvMjAyMiDDoCAwMzoxOSwgQmFvcXVhbiBIZSBhIMOpY3JpdMKgOg0KPj4+IE9uIDA4
LzIyLzIyIGF0IDA2OjMwYW0sIENocmlzdG9waGUgTGVyb3kgd3JvdGU6DQo+Pj4+DQo+Pj4+DQo+
Pj4+IExlIDIwLzA4LzIwMjIgw6AgMDI6MzEsIEJhb3F1YW4gSGUgYSDDqWNyaXTCoDoNCj4+Pj4+
IE9uIHNvbWUgYXJjaGl0ZWN0dXJlcywgdGhlIHBoeXNpY2FsIGFkZHJlc3MgbmVlZCBiZSBmaXhl
ZCB1cCBiZWZvcmUNCj4+Pj4+IGRvaW5nIG1hcHBpbmcsIGUuZywgcGFyaXNjLiBBbmQgb24gYXJj
aGl0ZWN0dXJlcywgZS5nIGFyYywgdGhlDQo+Pj4+PiBwYXJhbWV0ZXIgJ3Byb3QnIHBhc3NlZCBp
bnRvIGlvcmVtYXBfcHJvdCgpIG5lZWQgYmUgYWRqdXN0ZWQgdG9vLg0KPj4+Pj4NCj4+Pj4+IElu
IG9kZXIgdG8gY29udmVydCB0aGVtIHRvIHRha2UgR0VORVJJQ19JT1JFTUFQIG1ldGhvZCwgd2Ug
bmVlZCB3cmFwDQo+Pj4+PiB0aGUgYWRkcmVzcyBmaXhpbmcgdXAgY29kZSBhbmQgcGFnZSBwcm90
IGFkanVzdGluZyBjb2RlIGludG8gYXJjaF9pb3JlbWFwKCkNCj4+Pj4+IGFuZCBwYXNzIHRoZSBu
ZXcgYWRkcmVzcyBhbmQgJ3Byb3QnIG91dCBmb3IgaW9yZW1hcF9wcm90KCkgaGFuZGxpbmcuDQo+
Pj4+DQo+Pj4+IElzIGl0IHJlYWxseSB0aGUgYmVzdCBhcHByb2FjaCA/IFdvdWxkbid0IGl0IGJl
IGJldHRlciB0byBoYXZlIGhlbHBlcnMNCj4+Pj4gdG8gZG8gdGhhdCwgdGhvc2UgaGVscGVycyBi
ZWluZyBjYWxsZWQgYnkgdGhlIGlvcmVtYXBfcHJvdCgpLCBpbnN0ZWFkIG9mDQo+Pj4+IGRvaW5n
IGl0IGluc2lkZSB0aGUgYXJjaF9pb3JlbWFwKCkgZnVuY3Rpb24gPw0KPj4+DQo+Pj4gVGhpcyBp
cyBzdWdnZXN0ZWQgdG9vIGJ5IEFsZXhhbmRlciBkdXJpbmcgaGlzIHYxIHJldmlld2luZy4gSSB0
cmllZCwgYnV0DQo+Pj4gZmVlbCB0aGUgY3VycmVudCB3YXkgdGFrZW4gaW4gdGhpcyBwYXRjaHNl
dCBpcyBiZXR0ZXIuIEJlY2F1c2Ugbm90IGFsbA0KPj4+IGFyY2hpdGVjdXRyZXMgbmVlZCB0aGUg
YWRkcmVzcyBmaXggdXAsIG9ubHkgcGFyaXNjLCBhbmQgb25seSBmZXcgbmVlZA0KPj4+IGFkanVz
dCB0aGUgJ3Byb3QnLiBJbnRyb2R1Y2luZyBvdGhlciBoZWxwZXJzIHNlZW1zIHRvbyBtdWNoLCB0
aGF0IG9ubHkNCj4+PiBpbmNyZWFzZXMgdGhlIGNvbXBsZXhpdHkgb2Ygb2YgaW9yZW1hcCgpIGFu
ZCB0aGUgZ2VuZXJpYyBHRU5FUklDX0lPUkVNQVANCj4+PiBtZXRob2QgZm9yIHBlb3BsZSB0byB1
bmRlcnN0YW5kIGFuZCB0YWtlLg0KPj4NCj4+IEkgY2FuJ3QgdW5kZXJzdGFuZC4gV2h5IGlzIGl0
IGRpZmZpY3VsdCB0byBkbyBzb21ldGhpbmcgbGlrZToNCj4+DQo+PiAjaWZuZGVmIGlvcmVtYXBf
YWRqdXN0X3Byb3QNCj4+IHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBpb3JlbWFwX2FkanVz
dF9wcm90KHVuc2lnbmVkIGxvbmcgZmxhZ3MpDQo+PiB7DQo+PiAJcmV0dXJuIGZsYWdzOw0KPj4g
fQ0KPj4gI2VuZGlmDQo+Pg0KPj4gVGhlbiBmb3IgYXJjIHlvdSBkbw0KPj4NCj4+IHN0YXRpYyBp
bmxpbmUgdW5zaWduZWQgbG9uZyBpb3JlbWFwX2FkanVzdF9wcm90KHVuc2lnbmVkIGxvbmcgZmxh
Z3MpDQo+PiB7DQo+PiAJcmV0dXJuIHBncHJvdF92YWwocGdwcm90X25vbmNhY2hlZChfX3BncHJv
dChmbGFncykpKTsNCj4+IH0NCj4+ICNkZWZpbmUgaW9yZW1hcF9hZGp1c3RfcHJvdCBpb3JlbWFw
X2FkanVzdF9wcm90DQo+IA0KPiBNeSB0aGlua2luZyBpcyB3ZSBoYXZlIGZvdXIgdGhpbmdzIHRv
IGRvIGluIHRoZSBhZGRlZCBob29rZXJzLg0KPiAxKSBjaGVjayBpZiB3ZSBzaG91bGQgZG8gaW9y
ZW1hcCBvbiBBUkNIZXMuIElmIG5vdCwgcmV0dXJuIE5VTEwgZnJvbQ0KPiBpb3JlbWFwX3Byb3Qo
KTsNCj4gMikgaGFuZGxpbmcgdGhlIG1hcHBpbmcgaW8gYWRkcmVzcyBzcGVjaWZpY2FsbHkgb24g
QVJDSGVzLCBlLmcgYXJjLA0KPiBpYTY0LCBzMzkwOw0KPiAzKSB0aGUgb3JpZ2luYWwgcGh5c2lj
YWwgYWRkcmVzcyBwYXNzZWQgaW50byBpb3JlbWFwX3Byb3QoKSBuZWVkIGJlDQo+IGZpeGVkIHVw
LCBlLmcgYXJjOw0KPiA0KSB0aGUgJ3Byb3QnIHBhc3NlZCBpbnRvIGlvcmVtYXBfcHJvdCgpIG5l
ZWQgYmUgYWRqdXN0ZWQsIGUuZyBvbiBhcmMNCj4gYW5kIHh0ZW5zYS4NCj4gDQo+IFdpdGggS2Vm
ZW5nJ3MgcGF0Y2hlcywgdGhlIGNhc2UgMSkgaXMgaGFuZGxlZCB3aXRoIGludHJvZHVjZWQNCj4g
aW9yZW1hcF9hbGxvd2VkKCkvaW91bm1hcF9hbGxvd2VkKCkuIEluIHRoaXMgcGF0Y2hzZXQsIHdo
YXQgSSBkbyBpcw0KPiByZW5hbWUgdGhlIGhvb2tzIGFzIGFyY2hfaW9yZW1hcCgpIGFuZCBhcmNo
X2lvdW5tYXAoKSwgdGhlbiBwdXQgY2FzZSAxKSwNCj4gMiksIDMpLCA0KSBoYW5kbGluZyBpbnRv
IGFyY2hfaW9yZW1hcCgpLiBBZGRpbmcgaGVscGVycyB0byBjb3ZlciBlYWNoDQo+IGNhc2UgaXMg
bm90IGRpZmZpY3VsdCBmcm9tIG15IHNpZGUuIEkgd29ycnkgdGhhdCBhcyB0aW1lIGdvZXMgYnks
IHRob3NlDQo+IHNldmVyYWwgaG9va3MgbXkgY2F1c2UgaXNzdWUsIGUuZyBpZiBhIG5ldyBhZGp1
c3RtZW50IG5lZWQgYmUgZG9uZSwNCj4gc2hvdWxkIHdlIGludHJvZHVjZSBhIG5ldyBoZWxwZXIg
b3IgbWFrZSBkbyB3aXRoIHRoZSBleGlzdGVkIGhvb2s7IGhvdw0KPiANCj4gV2hlbiBJIGludmVz
dGlnYXRlZCB0aGlzLCBvbmUgYXJjaF9pb3JlbWFwKCkgbG9va3Mgbm90IGNvbXBsaWNhdGVkDQo+
IHNpbmNlIG5vdCBhbGwgQVJDSGVzIG5lZWQgY292ZXIgYWxsIGFib3ZlIDQgY2FzZXMuIFRoYXQn
cyB3aHkgSSBmaW5hbGx5DQo+IGNob29zZSBvbmUgaG9vay4gSSBhbSBvcGVuIHRvIG5ldyBpZGVh
LCBwbGVhc2UgbGV0IG1lIGtub3cgaWYgd2Ugc2hvdWxkDQo+IGNoYW5nZSBpdCB0byBpbnRyb2R1
Y2Ugc2V2ZXJhbCBkaWZmZXJlbnQgaGVscGVycy4NCj4gDQoNCkEgbmV3IGlkZWEgdGhhdCB3b3Vs
ZCBoYXZlIG15IHByZWZlcmVuY2Ugd291bGQgYmUgdG8gZG8ganVzdCBsaWtlIHdlIGRpZCANCndp
dGggYXJjaF9nZXRfdW5tYXBwZWRfYXJlYSgpLiBMb29rIGF0IA0KaHR0cHM6Ly9lbGl4aXIuYm9v
dGxpbi5jb20vbGludXgvdjYuMC1yYzEvc291cmNlL2FyY2gvcG93ZXJwYy9tbS9ib29rM3M2NC9z
bGljZS5jI0w2MzggDQphbmQgaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMC1y
YzEvc291cmNlL21tL21tYXAuYyNMMjEzMQ0KDQpJbnN0ZWFkIG9mIGhhdmluZyB0aGUgZ2VuZXJp
YyB0aGF0IGNhbGxzIHRoZSBhcmNoIHNwZWNpZmljLCBtYWtlIGl0IHRoZSANCm90aGVyIHdheSBy
b3VuZCwgaGF2ZSB0aGUgYXJjaCBzcGVjaWZpYyBjYWxsIHRoZSBnZW5lcmljIGFmdGVyIGRvaW5n
IGl0cyANCnNwZWNpYWx0aWVzLg0KDQo+Pg0KPj4NCj4+IEJ5IHRoZSB3YXksIGNvdWxkIGJlIGEg
Z29vZCBvcHBvcnR1bml0eSB0byBjaGFuZ2UgaW9yZW1hcF9wcm90KCkgZmxhZ3MNCj4+IHR5cGUg
ZnJvbSB1bnNpZ25lZCBsb25nIHRvIHBncHJvdF90DQo+IA0KPiBUZW5kIHRvIGFncmVlLCBJIHdp
bGwgZ2l2ZSBpdCBhIHNob3QuDQo+IA==
