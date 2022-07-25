Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFCB5806D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiGYVed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbiGYVeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:34:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2099.outbound.protection.outlook.com [40.92.22.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD1B24970
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:32:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjASgTNOsZ/+1nwJ40dO3mNidIVJ0cCAFNt8gcdU3binbiCOgYmmnFMh0Hykr6PfKpdKiFkp3UrslW5/2P3Xafd05V5bjC2yLgkUYKAkLALzNpAZTaO9/KBdMM8rREKr4MSbug00iiUflJ8yLzvajog+gjFcBSpClkkwr2o7p8S01+qhWny/FInCLbiphzyxbvz3ey4u1DCwoJO7GJRSw+5CirPTz3jTtc6nZ8Mgo1KeHEEuu3E+JqY5i6CYFmtw11GahSyeWLOj1OSrAOJ3esid36rlurF3Test+DIzUuS9IHWihhlSRRAMZs+ZkBBroXoFlmFWRLveCVDDxOq9Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWvG++yO7Hw8F7wKvr8hSQVnPbJIkogJ6kNVpuaKTHE=;
 b=eFiWwdiLOlclC86aD1LhgpMXqpe0YCY42BBxA6kF8lukG/zWUgBiPfzsDAtKY6vX+OJLr48k1KNw9+iyWQlFKTJLa88m2gwkmUmDUVDgioOOxCb2U2t4b9SPQxG8BPSrtQ9KUzT0/ZljDaoRm0YfKt+Afu/ReENZj2T+1DWZu5gs67UqLXaKc5vjC8p6x8jxvL76bMpOKnzOWMs4kw5065P5ujYINyeJhiTW7Ub+wYQAwQzY3dtgep5j+TRl6P0WxIw0JZuHFQLiWoVsMnW3yyA8rD2KZdpbt7unoW8OjMaa/SD2PneKKuZx4CszpwJfPb2N1VWyqGuKVQfUO8NimQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWvG++yO7Hw8F7wKvr8hSQVnPbJIkogJ6kNVpuaKTHE=;
 b=PEoNOvGYgoo8ISUBVngJ91TzWjAg0jmG/Iq/GCAYZrkrg/C93k4eCAYQgvmBUEew62TNRAoCX6XLBujnXZeGHtZ/0DgvJuAHXR66kILFfQSrt9n7Cw5AYwQpy2B51YTRdTGvrTePH+c0ovjLQFo15ufwEnIEjpoKNjGjftYX3M25uyBmAeOTo6CB9lPjiwazIesnaWHa/EnyBZXHYW+QNkp3h0ixHH1dxxRq35U8N9bhBnLuJH5rfBVzWJ+hr1+vNLoZ8AuODUb+11MEJcn1cJCugzUzIIAFmfdpKS59YYv/8VdihGOpAF7ANVsywNx+BqbwbcKS8aelfUVrz0jwPQ==
Received: from MN2PR17MB3375.namprd17.prod.outlook.com (2603:10b6:208:13c::25)
 by DM8PR17MB4918.namprd17.prod.outlook.com (2603:10b6:8:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 21:32:33 +0000
Received: from MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba]) by MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba%3]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 21:32:33 +0000
From:   Vanessa Page <Vebpe@outlook.com>
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wang Weiyang <wangweiyang2@huawei.com>
Subject: Re: [PATCH] mtd: rawnand: arasan: stop using 0 as NULL pointer
Thread-Topic: [PATCH] mtd: rawnand: arasan: stop using 0 as NULL pointer
Thread-Index: AQHYoBjwrgb3QDZZqk2l3gKc/X6vea2Pm+f5
Date:   Mon, 25 Jul 2022 21:32:33 +0000
Message-ID: <MN2PR17MB3375A61331BC4E0E5BA6F9C4B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
References: <20220725112108.686347-1-gongruiqi1@huawei.com>
In-Reply-To: <20220725112108.686347-1-gongruiqi1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [6y6mxmzx+MJlshDnzi5nh0YVavVm1mOrqo1Dx3LtlWaTAo/jmJvm07qpKozg5D7P]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd807660-7c4a-45cc-6334-08da6e852f8f
x-ms-traffictypediagnostic: DM8PR17MB4918:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 82KJ7UQuJHvcxnSgyCY/Zon5lL1RZJkKkauZpXB/tvvBuu0pMUf+95wsX2lZsG6You7A966aBvp5zU69UxZiv9ErZbBuwoLv5ZaYB2NX0LWoQx+jstEHVHnbdhkcHeBroyHZ9hFsqG7nwrVqbISMedQoOIsBLYD3eBoPqVfT5rnQ5r6FVdwSrzQpPV8LmRpScLLvcKIMtkjpZKwvmK8Akc585YigiWgIWqTJmbKmLMOaynH/1SGQhJLklghocW+rcrGXsuFK0U2ncDflT/AeZiooNSv4QpeGkiNlTm0YJjQjnGr4uwmqsoAgLj0rwL501H6z+JsaVu40qmUv0k79xYFQQRN2vX8ADX2o00QLpwmgH0NLBUxCUKVL6rmtA6I2ReBdXa6ytd4uTTRdlbRiHwiOjgBb8+Xv3OkUbUZ/HviG6S+1pqlRGbnkF+LZ3JgP4AUa6kZpH+lqFU0zfCIvfd3n03LffMK95hMH+rhsoyscuYb+f/Tl6V6LSHrd+jbTUsa51I1VsWAFC1hCBJ7B5H9+HOhdz+NQ+rSUhPyPHfTTBPiUz6N0v+iE0bpUhluwC9GRQ4ZeRhDiH4EGKF41/rHwW2DuND4ZIqkcOyKyqEsIt4IynAEfTwzj5uwbkwnrvBkrBXZdWdRzPn2P5TS3AGKhttVtEK+D6hSrh+Bdx2uSKya8SbXfb0AmeX3mknuN
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG14WjZYYzIybFNPaUZIN29WTE54Vmtza3NDNTlSclNhbGpjZ1dWeUZvSm4w?=
 =?utf-8?B?aXh2VVJiU0QxTDV6Z1VSTmtLMmNNQURuR0NBOXp6ek1vMVhvUGxsWFJuRzB0?=
 =?utf-8?B?SzRyT2ZPd2NVTHFPazJORW9PVVplV21XQlVKSTdPejZmb2pYRXU5UkVYQXV5?=
 =?utf-8?B?cXdkVXpzTU1oU25RbW9GZ0V2UzN6cjlmVzFVclVvSDJ5c3g5dmQzRTVhT2x4?=
 =?utf-8?B?Z1dzMldGVG5Xc0ZKOUhKNkltdlVOUUc1T0lHcVJYMHlsSlhYZUJwT1NTZmlh?=
 =?utf-8?B?NlZqQnNYaXZLUzlwaXNVMVh0RGlXWDlRQ0RaUUFJR3UvNlJMTzY4K2RFTWIy?=
 =?utf-8?B?ZDNmamhvMmlPT3Q0OERRM0d1THVYT3VRajluZ1JXdi81SGtrS0FBZDhFQWpR?=
 =?utf-8?B?N0dYVEx6NEhMQnlRbi9lNFFxY2xreGRNYUJHSStQeThLM3M4b0pRV2xYbU1V?=
 =?utf-8?B?U3NKVytRR1Vybyt4dk9IWVMrV3BJdXU1RzlMVzdZdXdaUlhJVExidXVuTTdN?=
 =?utf-8?B?dVIxOW5BTDhOd2ZtWTQrb3ZxS2hPdWQ1TlJlSExDWGhsKzRITWhNN214Vk9E?=
 =?utf-8?B?eTBHMlp1UUJrbWo0YU15QkxhQUhuc2xxMWdvU1RrZml1WUlJRk8vcHNTNkVL?=
 =?utf-8?B?UFBidzBScTlQMEJuKzE2K1hvQkFkTE5qL1A3TllGZVQweFhNZU5tZytDMkpI?=
 =?utf-8?B?QU55eVFPRFgreFB6VjBSeGhBbmMxKzh2b0NkQ05NQVVvY3UvWHhOQSs0VTNi?=
 =?utf-8?B?WVRyU2RkY2dMNFFGbWo2ZEFUeEw3UmdNMHVWaVNmUllpNElPVmUvN0U3MGZU?=
 =?utf-8?B?eWVYMEl6VmYyV3Nyem1aQjVQak9JZXV6N2xVZTR1L09IWEtkTkl0NkxjcVhG?=
 =?utf-8?B?NE9lQTY3TE4vYnZtVkQwTG9HaGgrbUkyZzhQbWFuUkpkQ0NxaHRUV0U1R0xu?=
 =?utf-8?B?N3pxMmpvL1J5Z2VvY0d2Y0UvSlhUYmxXVy9TcThPMVNQN0ZvbmZLMVppRndy?=
 =?utf-8?B?eXdFMXd6SHNxbGJORTFaQ3IwcWZqSVV1RitKWUwyR1picnY0bVh6RHNpdC9N?=
 =?utf-8?B?OU5wMDdZUVd6UHU3RXlub2NMNkZ0a0U0b2pSRXMxSEJxZmVtTFpXUEVpRzJn?=
 =?utf-8?B?NmNab0MzdFRnb3pNVnJYR2htaEt4MUs4eExKSlUrbWNIZElGb2d6aE9yU053?=
 =?utf-8?B?TzRqd255dlRvWWlHdnVDQXZJSC9yV1UyeDZTWHpoM0RzaTdIeDM5dlE3dGNQ?=
 =?utf-8?B?SGVCbnFvejdFNTlCcW1RWTNES3cvSXZCYnlIa09aQ1BOZVU5WUlUMVJKY1gv?=
 =?utf-8?B?alhyeEVGWjVlVkRCZlpYQXQwbDcwZnVSNzhFVG9MYzFFMi9mSXViSGw1ZmZT?=
 =?utf-8?B?dDFSNGdLMUovOUF2SXpLdFphdzBpVTVKeDcvd0tNUno4V1IyLzBtSkV6RjVv?=
 =?utf-8?B?SDZ0akx3bElLa1cyU2hLS1AreTFwU0dsbWtxeWkrQytieGRVTTQ1RGhObWJU?=
 =?utf-8?B?dkkzSU5aSXU5YjdUc0JUNHY4UmxBcDU3cVIyV29XRlMrbGphOHI2a1lhTnpS?=
 =?utf-8?B?Z25lZDlTUi9oZFVKYjVBWThEM1hBNjNUNnVHSzFyMlFjNXJXVWdiRE52WEov?=
 =?utf-8?B?dzRhZFdBTVJaMmNBV0Q3MHpubllxekNtSTh4U1F6Z2FyUkpDOUMwMjZxM1NW?=
 =?utf-8?B?c1NCSW9QbzBheEN0Yk82WGVDUnAzazRyQmU5a2lBWUFkTTloeEpyaktCRUF5?=
 =?utf-8?Q?AcjLn/SQ5jEaDyy042+LmViJ175JshUOhFCRwoN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR17MB3375.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bd807660-7c4a-45cc-6334-08da6e852f8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 21:32:33.3665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR17MB4918
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3RvcCBmdWNraW5nIGVtYWlsaW5nIG1lIHlvdSBwYXRoZXRpYyBsb3Nlcg0KDQpTZW50IGZyb20g
bXkgaVBob25lDQoNCj4gT24gSnVsIDI1LCAyMDIyLCBhdCA3OjIzIEFNLCBHT05HLCBSdWlxaSA8
Z29uZ3J1aXFpMUBodWF3ZWkuY29tPiB3cm90ZToNCj4gDQo+IO+7v0ZpeCB0aGUgZm9sbG93aW5n
IHNwYXJzZSB3YXJuaW5nczoNCj4gDQo+IGRyaXZlcnMvbXRkL25hbmQvcmF3L2FyYXNhbi1uYW5k
LWNvbnRyb2xsZXIuYzo5MTg6NzA6IHdhcm5pbmc6IFVzaW5nIHBsYWluIGludGVnZXIgYXMgTlVM
TCBwb2ludGVyDQo+IGRyaXZlcnMvbXRkL25hbmQvcmF3L2FyYXNhbi1uYW5kLWNvbnRyb2xsZXIu
Yzo5MTg6NzM6IHdhcm5pbmc6IFVzaW5nIHBsYWluIGludGVnZXIgYXMgTlVMTCBwb2ludGVyDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBHT05HLCBSdWlxaSA8Z29uZ3J1aXFpMUBodWF3ZWkuY29tPg0K
PiAtLS0NCj4gZHJpdmVycy9tdGQvbmFuZC9yYXcvYXJhc2FuLW5hbmQtY29udHJvbGxlci5jIHwg
MiArLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9hcmFzYW4tbmFuZC1jb250cm9s
bGVyLmMgYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9hcmFzYW4tbmFuZC1jb250cm9sbGVyLmMNCj4g
aW5kZXggMjk2ZmIxNmM4ZGMzLi5lYzdlNmVlYWM1NWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bXRkL25hbmQvcmF3L2FyYXNhbi1uYW5kLWNvbnRyb2xsZXIuYw0KPiArKysgYi9kcml2ZXJzL210
ZC9uYW5kL3Jhdy9hcmFzYW4tbmFuZC1jb250cm9sbGVyLmMNCj4gQEAgLTkxNSw3ICs5MTUsNyBA
QCBzdGF0aWMgaW50IGFuZmNfY2hlY2tfb3Aoc3RydWN0IG5hbmRfY2hpcCAqY2hpcCwNCj4gICAg
ICAgICAgICBpZiAoaW5zdHItPmN0eC5kYXRhLmxlbiA+IEFORkNfTUFYX0NIVU5LX1NJWkUpDQo+
ICAgICAgICAgICAgICAgIHJldHVybiAtRU5PVFNVUFA7DQo+IA0KPiAtICAgICAgICAgICAgaWYg
KGFuZmNfcGt0X2xlbl9jb25maWcoaW5zdHItPmN0eC5kYXRhLmxlbiwgMCwgMCkpDQo+ICsgICAg
ICAgICAgICBpZiAoYW5mY19wa3RfbGVuX2NvbmZpZyhpbnN0ci0+Y3R4LmRhdGEubGVuLCBOVUxM
LCBOVUxMKSkNCj4gICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9UU1VQUDsNCj4gDQo+ICAgICAg
ICAgICAgYnJlYWs7DQo+IC0tIA0KPiAyLjI1LjENCj4gDQo+IA0KPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gTGludXggTVREIGRpc2N1
c3Npb24gbWFpbGluZyBsaXN0DQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbXRkLw0K
