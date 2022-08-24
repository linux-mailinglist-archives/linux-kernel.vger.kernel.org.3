Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5424B59F3C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiHXGuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiHXGt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:49:59 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90082.outbound.protection.outlook.com [40.107.9.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D32DF3D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqbzCj6euG+DpNP3A8MyxWR9FNgBOUbkMIYYkw8Ec1qIMwHF2Eh6pH/hjPNV3GRvaoGHUOUxqXQS6WtJursCCDJJUQYAAszSOw6ADOEbtFe/nEg93HWe4ZqSzDyqHp0PZ+0t2GOMhypUzvw9D6E2ST1NRjfo0w189kLum74jiB3nhLBQsFCsx4If8PM47FTpEjBSU5f2LRh1QvToiD24GPOVvDLSccmJh0AMDNCmUGkPL2EswAAms0IgzLyUgtMI46l8FdWroeFNBLCYXWEW/7I3CNmaqTnHKEsd3SrgFiI8GplBo+t+pm6xZ8iZh4h+PAM2f4scufJPe+ufAALQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e75pZiOLIPVoIstiuf4/ktwSVe9tlydrCmdvTkT5seI=;
 b=ROC0txQfwWdtm7fwo7JaqE9FrkN4wk9LfT/d65z7tVD9xlLgaOJMx7Ef4ZCnadE4Rhn/6QM/isnhYLYbXLnmp3QR99hTJO5WMJdEXf5pGegpqnupKPDlanshELBlKHLrjzsAblqyAgkjTmHul87+6brkdK5D0Xz7KHC5A1wzigEAUzAFo7brGTQ0BC9jSQ6YFp2IZqq6DpZ7FrAUy8kaD3nze1CEf1skCOq8bfbd5g6KR25uREYcsLaQXfT2nj+vubKbO9WfvznhWzp2tkzqOeHb4OS43wS2RwAsdRXyKvzd1LzfdM9YQjoq604R1fgsgrYk/WJZsf4OevYmKOrOfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e75pZiOLIPVoIstiuf4/ktwSVe9tlydrCmdvTkT5seI=;
 b=tG6a638YijH1tmZ7F+oQO0B9b9rFbZ1oRV5kFmgKK843YeFJrqew6Z9TZUiAYmUiTCnN3dbAYJ4egJeyZLsCQa3hyBtlFy8CTK+j8p1DnU5x+UXhr3hBd/sQl8UgmjschCCMIYVGYfGX+zuXqGRYY+8rdd+s/j0B1FD9nPc1vnpT7JTZaumIi0onpqdnfeUvPkVHk60VRml3WDaS/5xxCIjgQhI6Cv8+XBzptzfcAt+F4aT+4W6tHPLtwRnu6NuFdmqRE2qKyI8RxiCs9Sft/8YLkHiYKLs8CMONHJX32K12qwu9PNyCStei5qSV521fbKuVJ83Zo8Zlu7j1LvmhEA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAYP264MB3397.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 06:49:53 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 06:49:53 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH linux-next] mm: fix used but uninitialized variable
Thread-Topic: [PATCH linux-next] mm: fix used but uninitialized variable
Thread-Index: AQHYt35XzsFKpFb3eUu3rI9AKkOHmq29kW8AgAAIjwCAAAJxAA==
Date:   Wed, 24 Aug 2022 06:49:52 +0000
Message-ID: <66f0770d-83ee-34cb-2dea-b8d957613c7f@csgroup.eu>
References: <20220824055637.10676-1-zhouzhouyi@gmail.com>
 <8d8bfc81-b584-20f4-65ae-d626f019cdf4@csgroup.eu>
 <CAABZP2w7jw4OHXPDANNabaD1L1BbUG8ymu9zLGEt5xA8YgZ3ow@mail.gmail.com>
In-Reply-To: <CAABZP2w7jw4OHXPDANNabaD1L1BbUG8ymu9zLGEt5xA8YgZ3ow@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8977bc6-301a-4c8d-1378-08da859cd91a
x-ms-traffictypediagnostic: PAYP264MB3397:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M+DqFQ/6COmqElhL0lcZLq4ElPF+BJmBA7TBs5vj3bKAX2GjdnZZLaKQbb8JbGs2Y95O3iPb185dno/fyNCpRc9lsbKTh7/Vxenx4/2H8L144e749gN68QM7RUxrUtYUhfng7+S2+yulUsuM2BzTMDInAScGboxxZx6vXiItdYAetyFBzX0r8b0h9ELX0MAo37TUZK4aKRvQKGcXKxv/SjnNRQZDJjwfC+iSJqEMannXQq0feWbhoDiSim6SF0Usg5vvcm0Uo9Vi6rvsicdj1Ri6nSVera4YjMtpaszLG6Vd6pPQTLbGHqx7gs7HNb7MgghkbFJ5MzIxeeyrJm6OF3el+FB/ZREdeh1VaXTrafs6i7WElZRWpj6oPXGnBYnd/bR/VB7omGESZWhVEIAGbtHguRgLXtP9qzTQkqZZYMS764lxzQz13uluUraZ9sEYlBNDml7okJCphchDSK1SaCGGJm9uEbGvPjX+E778pGePqlxAcJXTTnHro2H8w1oQqH6a6OvgV21XMJq+G6NHsF+jYYwfQdeI80EkfDnUnOLg5mTpBMBp9A4G+kz7S0syd0ItWFGyaZRtjCx+iVepAlnmP/ICqUHTozzSx4GGPi04771Og+R3JLTpPC4XgN1GQjpVESFGNrOdEkBUActF+ZVNQ2UvIzbPeu8r3gwKijHbGM02+CTIdQp713gYxxRFgG2QmZHBKOBVbmmR0FJTJ4HJUyi5uYL/Da8LcOlmCZVxNFtoCGosXDNMF2iZR8fJCkBX9EMEhnFpcQCcMY4+2Maa6aSFdGLS8DFbf2V7UZJl/dgLDRJNm8EZ+WIavUVaLZTYdqwCyppb0wM3fygW1CNvbpMhQcL/ExMwxjgt8G4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(366004)(136003)(346002)(39850400004)(966005)(6486002)(38070700005)(31696002)(83380400001)(86362001)(4326008)(8676002)(91956017)(76116006)(8936002)(66556008)(66446008)(66476007)(66946007)(64756008)(66574015)(478600001)(2616005)(44832011)(5660300002)(41300700001)(186003)(316002)(6506007)(36756003)(54906003)(53546011)(38100700002)(31686004)(6916009)(6512007)(122000001)(71200400001)(26005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlBRSFUwSzBDak5TK1pYT3libEtZeCt5LzBsS3ZObXlKc0owSVgxRDNvcWdk?=
 =?utf-8?B?ZnhrcTJjb3U2b21wN0tLTjcyM3VLd2lydUJad0JqOEpUT2lVUDk3cWpGcXNG?=
 =?utf-8?B?SlAxZXVpZm45TEtKRWxyTkJLbFFZV3hKRTlhZnhveGNYbUwzTUdUN0J0TWov?=
 =?utf-8?B?MFgrcmUwZjh3dXpTUEVNQnlWR2RsSHRpcldHZk5XNnhwY0d4SmQvQ3ExUjI3?=
 =?utf-8?B?bTlwRnRMNzFzMHcvcVhXTmZYZ3lJcWNuV3lrdkxnTHZSQWMzeU9sTWlURUpR?=
 =?utf-8?B?c0ZzYmZkSTQzb3FQR3VUenRnckRGUU1SVWYwY3R5UVhYZnBGUkxNc1ZzSUZu?=
 =?utf-8?B?NGtlRDZzM3hRcjA4TWZqNTJrb0QwOHBDZkx5d2hHeklQN2pMVGF0cVA3VmZh?=
 =?utf-8?B?b3JIeEhmL3ZSUmRoMXpaOEtTSEQ4cDNUa3RqQU01OUVoYlRLTnZPQ3pIMHpK?=
 =?utf-8?B?TmcrdW1IVU0zSnFkcUVObUNwSmlRdDdGYStmU0VRdEdXWjg4K2x5aDdGaXNL?=
 =?utf-8?B?c1FnSTNFcklGS3EwK2dEUkNGYzRqdi8yZ01zQUlFUERKaFVBUjlYSWhpRDQx?=
 =?utf-8?B?OUZTemxIRWpXV3RMZ1VUYm5RVHZKZlhCQU12NVd0WWFWeXlVamhPakNqcTNx?=
 =?utf-8?B?dTVUQWh3cDkxSXpkcUNYdVNhNDFIbUVUZGt1Q2tMZ1ZON2dTVmppTjgzdTdI?=
 =?utf-8?B?SjNZUnVCNzVmb3dBM2JCcXBuaDVOUFFuTzlJYllUb0hrSVFVYWJFNUdTTzRD?=
 =?utf-8?B?WHNSV3MrUVE1QzZQTG5SZTRKWDZtNWpyRmRZaklCbEJncWttVHdYelFwZ053?=
 =?utf-8?B?T2Z4bG1GV0djeFlSb3V6OS9HZUE0dUdDU1kzYzAwaHVkS2dKN21DcWJFZTRH?=
 =?utf-8?B?ZFhrM05Gc2FNWll0VUtTaWY0YllLbVFyZTJibldDOU9RRkdOeVhSUktOSUdD?=
 =?utf-8?B?WFRRUGVOTWRTL1JqYUZaMjdOU29seFJzSmhRa3oyclhRcC8yQUdZcC9JVTVJ?=
 =?utf-8?B?TmNHc3lrMVZoOG1vc2lTZ2NZU0kvK0VUbGZWNFhDVDlISnU5SGo4SGZLL3VI?=
 =?utf-8?B?anhzZmdrYi9QVmdudkxTbDROU1hlWkt6Q1hkYnoybG96YTk5RmkveFZkN082?=
 =?utf-8?B?R0RrOE9FZ3FuREZjc2JGV2JVK2NzdWRvR2k5ZWJYVzk5RktZU0s3Smk5bnVj?=
 =?utf-8?B?Y25weURpWDJkVWgyb0U0L2J1ckpSOW1NOU9GYVJZNUNTZG9McnJhOVFXVjNz?=
 =?utf-8?B?RkMzMDdVVmo3cVc0MW0yMldHZzhEWWpPOXFrS0swVUFScnRNRmxXOVUwY1dx?=
 =?utf-8?B?NEJpZ1lrUC95M0t0TmdXdGZWSm0zamNJZ01Yd3FJNHQvcHc2dnBLL1lucTE3?=
 =?utf-8?B?QklINnJWczlPVUFPM2FmeEhCVWpsK1ZoVEZRYi92NkpYQm03WU9FZlo3bFZQ?=
 =?utf-8?B?YmE4M29GU3FrTUp6NHZ1NVZSVU1sTWRmRUxpL3B4d2d6KzIvZ2NHQWcrL1Z4?=
 =?utf-8?B?S1R6Z1VIL2ppTDk0ZDlQeHpBM3ovVVRvL0ZJS3dQMElOR0d1elNWSUdsbDFF?=
 =?utf-8?B?UjVPOXY3RWdHMzFzY0dyWjhwTHBYSHg4SkllbzF6WWU3YTZQcU5KTFNzb2hC?=
 =?utf-8?B?UHY3YStsTGIyU21kR2tYeDAyMGxXQ0oyeWhWbTlPTWxYcStSNzd6cUx3dmhP?=
 =?utf-8?B?VFFoUFFDZ2hxL1Fyamd5d1dEcDlXYWRDc1plY1pKbzZNamhoRDVscVBsU2ZI?=
 =?utf-8?B?SS9ISElHaVJOMjJlTVUyR25kaDZnUmdKajJVd1JHMmRWL3RTV2NBbS9ZT3dy?=
 =?utf-8?B?dnpPa0RrL21GempYWkxGUk50TVhzbXNWWk01R3AzeWx2SkVDdFo5dU4wMzFV?=
 =?utf-8?B?S2hRYThlWU5acVh2emtxalVNZkJiZW1qZXZZUzRTK1dPNlhpbWxySzlMcXdk?=
 =?utf-8?B?dXJGSVR3M1ZHaklWNjYxa1dMd082RXJ6by9NL1QvZHJnZVAzN2pKK0s0bHZD?=
 =?utf-8?B?R1hWN0lFRzl4ZE5Sejh3VXc2dWVOMW9zdHNua2tBL3VHYXNWODRZdjVjU2VS?=
 =?utf-8?B?L3d2dUFUT054dFFUaG9Qb0pScEErakVEOUF1Ykh0V2k5MmlubUZBRzladkRJ?=
 =?utf-8?B?WFRDd3pxTDRHMlB0RUpJbWVCajVJaVdvTTB3cjVybXhkVzcrM085ektWVk1x?=
 =?utf-8?Q?Bp1FFL3jfmUxBTkV3PvdDO8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86AB203DBAC82C409A6875740F523666@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f8977bc6-301a-4c8d-1378-08da859cd91a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 06:49:52.9635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jKsL6ykDmU51lhKJDfYqKxeuXwbKvPuq30ht2esTo8MZaEFKpoweEVCcH23dSByZBSWs13K+ZmlSXN4I+7hUPZhAvrQKJKRm98NPfBNs37E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB3397
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI0LzA4LzIwMjIgw6AgMDg6NDEsIFpob3V5aSBaaG91IGEgw6ljcml0wqA6DQo+IFRo
YW5rIENocmlzdG9waGUgZm9yIHJldmlld2luZyBteSBwYXRjaA0KPiANCj4gT24gV2VkLCBBdWcg
MjQsIDIwMjIgYXQgMjoxMCBQTSBDaHJpc3RvcGhlIExlcm95DQo+IDxjaHJpc3RvcGhlLmxlcm95
QGNzZ3JvdXAuZXU+IHdyb3RlOg0KPj4NCj4+DQo+Pg0KPj4gTGUgMjQvMDgvMjAyMiDDoCAwNzo1
NiwgWmhvdXlpIFpob3UgYSDDqWNyaXQgOg0KPj4+IEluIGZ1bmN0aW9uIHdhbGtfaHVnZXRsYl9y
YW5nZSwgdGhlIGxvY2FsIHZhcmlhYmxlIGVyciBtYXkNCj4+PiBiZSB1c2VkIHVuaW5pdGlhbHpl
ZCB3aGVuOg0KPj4+IG9wcy0+cHRlX2hvbGUgaW4gc2lkZSBvZiAiZWxzZSBpZiAob3BzLT5wdGVf
aG9sZSkiIGlzIGZhbHNlLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogWmhvdXlpIFpob3UgPHpo
b3V6aG91eWlAZ21haWwuY29tPg0KPj4+IC0tLQ0KPj4+IERlYXIgbW0gRGV2ZWxvcGVyczoNCj4+
Pg0KPj4+IFdoZW4gSSBidWlsZCBrZXJuZWwgdXNpbmcgIm1ha2UgQ0M9Y2xhbmctMTQiDQo+Pj4g
dGhlIGNvbXBpbGVyIGNvbXBsYWlucyBmb2xsb3dpbmc6DQo+Pj4NCj4+PiBDQyAgICAgIG1tL3Bh
Z2V3YWxrLm8NCj4+PiBtbS9wYWdld2Fsay5jOjMxODoxMjogZXJyb3I6IHZhcmlhYmxlICdlcnIn
IGlzIHVzZWQgdW5pbml0aWFsaXplZCB3aGVuZXZlciAnaWYnIGNvbmRpdGlvbiBpcyBmYWxzZSBb
LVdlcnJvciwtV3NvbWV0aW1lcy11bmluaXRpYWxpemVkXQ0KPj4+ICAgICAgICAgICAgICAgICAg
IGVsc2UgaWYgKG9wcy0+cHRlX2hvbGUpDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
Xn5+fn5+fn5+fn5+fg0KPj4+IG1tL3BhZ2V3YWxrLmM6MzIxOjc6IG5vdGU6IHVuaW5pdGlhbGl6
ZWQgdXNlIG9jY3VycyBoZXJlDQo+Pj4gICAgICAgICAgICAgICAgICAgaWYgKGVycikNCj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgXn5+DQo+Pj4gbW0vcGFnZXdhbGsuYzozMTg6ODogbm90ZTog
cmVtb3ZlIHRoZSAnaWYnIGlmIGl0cyBjb25kaXRpb24gaXMgYWx3YXlzIHRydWUNCj4+PiAgICAg
ICAgICAgICAgICAgICBlbHNlIGlmIChvcHMtPnB0ZV9ob2xlKQ0KPj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+DQo+Pj4gbW0vcGFnZXdhbGsuYzozMTE6MTA6IG5v
dGU6IGluaXRpYWxpemUgdGhlIHZhcmlhYmxlICdlcnInIHRvIHNpbGVuY2UgdGhpcyB3YXJuaW5n
DQo+Pj4gICAgICAgICAgICAgICAgICAgaW50IGVycjsNCj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgXg0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwDQo+Pj4gMSBlcnJvciBn
ZW5lcmF0ZWQuDQo+Pj4gbWFrZVsxXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI1MDog
bW0vcGFnZXdhbGsub10gRXJyb3IgMQ0KPj4+IG1ha2U6ICoqKiBbTWFrZWZpbGU6MjAwNjogbW1d
IEVycm9yIDINCj4+Pg0KPj4+IEkgaW5pdGlhbGl6ZSB0aGF0IHZhcmlhYmxlIG91dHNpZGUgb2Yg
dGhlIGZvciBsb29wIGJlY2F1c2Ugd2UgY2FuIGFzc2lnbiAwIHRvIGVycg0KPj4+IG9ubHkgb25j
ZSBpbiB0aGlzIGZ1bmN0aW9uLg0KPj4+DQo+Pj4gQWZ0ZXIgbXkgZml4LCBJIGNhbiBjb21waWxl
IHRoZSBrZXJuZWwuDQo+Pj4NCj4+PiBNYW55IFRoYW5rcw0KPj4+IFpob3V5aQ0KPj4+IC0tDQo+
Pj4gICAgbW0vcGFnZXdhbGsuYyB8IDIgKy0NCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9tbS9wYWdld2Fs
ay5jIGIvbW0vcGFnZXdhbGsuYw0KPj4+IGluZGV4IDU0YjJhMWJlZWViMy4uYjZlYjMzMGU4ZWNk
IDEwMDY0NA0KPj4+IC0tLSBhL21tL3BhZ2V3YWxrLmMNCj4+PiArKysgYi9tbS9wYWdld2Fsay5j
DQo+Pj4gQEAgLTMwNiw5ICszMDYsOSBAQCBzdGF0aWMgaW50IHdhbGtfaHVnZXRsYl9yYW5nZSh1
bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgZW5kLA0KPj4+ICAgICAgICB1bnNpZ25l
ZCBsb25nIGhtYXNrID0gaHVnZV9wYWdlX21hc2soaCk7DQo+Pj4gICAgICAgIHVuc2lnbmVkIGxv
bmcgc3ogPSBodWdlX3BhZ2Vfc2l6ZShoKTsNCj4+PiAgICAgICAgY29uc3Qgc3RydWN0IG1tX3dh
bGtfb3BzICpvcHMgPSB3YWxrLT5vcHM7DQo+Pj4gKyAgICAgaW50IGVyciA9IDA7DQo+Pg0KPj4g
V2h5IGRvIHlvdSBtb3ZlIGl0IGJhY2sgb3V0c2lkZSBvZiB0aGUgZm9yIGxvb3AgYWxsdGhvdWdo
IGl0IGlzDQo+PiBleGNsdXNpdmVseSB1c2VkIGluc2lkZSB0aGUgbG9vcCA/DQo+IEkgbW92ZSBp
dCBvdXRzaWRlIG9mIHRoZSBmb3IgbG9vcCBmb3IgcGVyZm9ybWFuY2UgY29uc2lkZXJhdGlvbi4g
QmVjYXVzZQ0KPiBpZiB3ZSBpbml0aWFsaXplIGVyciBpbnNpZGUsIHRoZXJlIHdpbGwgYmUgYW4g
YXNzaWdubWVudCBzdGF0ZW1lbnQNCj4gZXZlcnkgaXRlcmF0aW9uLg0KDQpJIHRoaW5rIEdDQyBp
cyBzbWFydCBlbm91Z2ggdG8gZG8gdGhlIGFzc2lnbm1lbnQgb25seSB3aGVuIG5lY2Vzc2FyeSwg
DQptYXliZSBoYXZlIGEgbG9vayBhdCB0aGUgZ2VuZXJhdGVkIGFzc2VtYmx5IGluIG9yZGVyIHRv
IGNvbmZpcm0uDQoNCj4+DQo+Pj4NCj4+PiAgICAgICAgZm9yICg7IGFkZHIgPCBlbmQ7IGFkZHIg
PSBuZXh0KSB7DQo+Pj4gLSAgICAgICAgICAgICBpbnQgZXJyOw0KPj4NCj4+IEFub3RoZXIgc29s
dXRpb24gd291bGQgYmUgdG8gYWRkIGFuIGV4cGxpY2l0IGVsc2UsIHNldHRpbmcgZXJyID0gMCBp
bg0KPj4gdGhlIGlmL2Vsc2UgaWYgc2VxdWVuY2UuDQo+IFRoYW5rIENocmlzdG9waGUgZm9yIHlv
dXIgdmFsdWFibGUgYWR2aWNlLCBJIGFtIGdvaW5nIHRvIHByZXBhcmUgYSAybmQgdmVyc2lvbg0K
DQpEb24ndCBzcGVuZCB0b28gbXVjaCB0aW1lIG9uIHRoYXQsIHRoZXJlIGFyZSBhbHJlYWR5IG90
aGVyIHBlb3BsZSANCmxvb2tpbmcgYXQgaXQsIHNlZSANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LW1tLzIwMjIwODIzMTUzMDU1LjI1MTc3NjQtMS1uYXRoYW5Aa2VybmVsLm9yZy9ULw0K
DQo+IA0KPiBUaGFua3MNCj4gWmhvdXlpDQo+Pg0KPj4+ICAgICAgICAgICAgICAgIHB0ZV90ICpw
dGUgPSBodWdlX3B0ZV9vZmZzZXQod2Fsay0+bW0sIGFkZHIgJiBobWFzaywgc3opOw0KPj4+DQo+
Pj4gICAgICAgICAgICAgICAgbmV4dCA9IGh1Z2V0bGJfZW50cnlfZW5kKGgsIGFkZHIsIGVuZCk7
