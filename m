Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7245A5A5046
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiH2Ph2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2Ph0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:37:26 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2072.outbound.protection.outlook.com [40.92.98.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F6C8275A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMJrIhTUPB+FUb4OMe95W1EC3YoJfA7z8nWoRRMpEYoXzjKlN76zTREB4MeX4UDKsN1LI/IL6t+aDuYgqItq+bpOCU6gb9qjtNo1dCTD67TqmBR3hHW9qe5QIVpo5tTcaI77d5g/e9q22k5G35wnrZfpJJ3LPKustgv9UxaI2w0Td7eOCVviqHOc8UB5RIdcBabpb26w+nPPICzo3yqFTdW47Ljog3Y2IXTlBg++mKcwdRgBoIPLNuf7nkGnmNmDrthiLvGnjWjTPub6cCo7z0o1o6xxhl7xQi9kzWeNB4EAM2S9jAiLGlHYBDfJzo5y0+T/8iTKQ2hPPgRi315igw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjI40YErhFTJ1d0wTaeoMcMSo3NTSf6zlWnqgexhMsg=;
 b=G+/ETCzDRnv9j3XJTnLS54GH/x+OFglMsdMgZelm/CsALcOxJZ70ZogF9qlVFDhQ1f1huEWQbyM/BBfxDlNBKbCkHXrryijyk6WR4Rr7mrso7UDgviu8vQy9O/LxxQmiHjWj+tEa1HK9+TYvp/QQlLQrrIn0bv+5uoJgXG7I3g8AVG4zO5Moa9uV6bLNZqw42akFKiy1/w5hYDr3fPV/gd0HqfrRlZ+M1Xb1sg61k0uzpO8NfyXgOtI6C8ZuXbHzYEJzXp0Qt7xEPmqct9TFRVwUslrU852ZAsX2qvVwCuFsbjzC3bRMcEQHt3mHJU/2JK1g+wRXUxn3KfwK+4kTzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjI40YErhFTJ1d0wTaeoMcMSo3NTSf6zlWnqgexhMsg=;
 b=JhGsKpGscqD0hpbipfMYMX345D7rHil7UI/xX4pAn7Ufpg/2KhEi6BKWMu+84lWqcW9YbAC30YXHdaxWo4V+63bz9DwUsMnIQ+Vt8Te8mcityVfFquHLPk5B34WvHnDYYmlWd5JS5migpNmC84VVFy83fRYuXQas1879FSuXBcvetHHyLDtr9ZDtf7tCSgvzHXkqSimwBVZ9MbGv7gy6zdOQQ5hexuwtRjf1bxDjbfBxwkrkEcqWgm19P6X0r2GacanVKU1r4IYggx7OXXAO19zQ+A1aXXIusbYjKgnhKO2aMBVe1y+B0lymVIl3FGssdhMjgknCi5VFwYMjyxFqYg==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OSYP286MB0151.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 15:37:22 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::44fe:ca4a:1afb:e2b6]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::44fe:ca4a:1afb:e2b6%7]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 15:37:22 +0000
From:   pgd pte <set_pte_at@outlook.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBtbTogc2ltcGxpZnkgc2l6ZTJpbmRleCBjb252ZXJz?=
 =?gb2312?B?aW9uIG9mIF9fa21hbGxvY19pbmRleA==?=
Thread-Topic: [PATCH] mm: simplify size2index conversion of __kmalloc_index
Thread-Index: AQHYuvDy9Jr2rsnB4EWhz4xW9p9Kaq3FNBAAgAAHEICAALQmgIAAEtul
Date:   Mon, 29 Aug 2022 15:37:22 +0000
Message-ID: <TYCP286MB2323CF51B2084FB49BEA203ECA769@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB2323E622C54B765F087C073ECA779@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <YwwuSBAreqUk/jFq@casper.infradead.org> <Yww0NV54DXTzPG+R@hyeyoo>
 <1188aeeb-3949-b561-bec0-512ed763d857@suse.cz>
In-Reply-To: <1188aeeb-3949-b561-bec0-512ed763d857@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [zZbJay7ytyVjNXrnRS4RuFRPUjkPTfYR]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0396089-2588-434f-cffa-08da89d45dd8
x-ms-traffictypediagnostic: OSYP286MB0151:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a1JqSbcTU2j0SmCjjMb750qaAF8uJgapQ8PLVzVj4x2EAJOhOADDTktmyx6cTNxu9O+7XFYlBU4KjR6WP0+drQueabjB/Het4EuxJgRFOBdd1CWz85Y9Fj54dj7t6FBG4Jb7qSV0RlLLABfd2IR/Xpbiq2vDjj2TVclp22WlttrYEECyeNnsPRRjrWdCvgw2hPFuT5yVuQcMqlkaae7vhxnFDvDTp+X0vY3DBgDj2Q+mKBBgPv+lMqnM/3qTBcDvRY+HI+hla8b52LBSgr1+xTG6+ocS0WJdsRbsCXv8b9JNGI+W7gMlGgHVT80jiyfRTh1rvgDG2J5xCzODwj4FV6GND3fi/BXuVkn7o0haS7A8GryBDZeT+5exM4iAo2T5Sh35V4CAxzouDjvDPvsec6u8rCsTbNqRWjEmyA0n/6FFNjmSrGdtgFhkJiKigWptYF3h3KOJeCNz/xJr2q5N+DsZXh+Mb1XOokpbi7niaVREScPG4FRCwxhbKMR+mmwwF9AT61Xf60Wlp7cZllfv4246jFvegmiqUqX8wFNA359Qox++uzPK3RB6ypgpb5vpcx5YttG3su3SpcHxEnBBi1P3lYS/eSXEHe4B069uLpKzhx2tqqpb52ZPBxdS7Om5
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?L2Z6cUQ4eSsrcE8wellyelhVQ1NhZXZCMUtXanJNcUFHU1lqbVJFVUtaZEM4?=
 =?gb2312?B?TlFYS2d4c2VsWkpwS1pvNjVDNHdIMnh5RnBlNEZhTisyN2hXZDBrRTVEcXM3?=
 =?gb2312?B?WTJvZ004UHFDTHdPSFNSZDBnd2MrcE0vUzNrbSsvaFIzOW5YRGk1Uk1UTUVD?=
 =?gb2312?B?eG5ualpON3Z2VFoxcHMxMWNROHlEN0kyYUF5dU56YTBmc3M4Z3NTbnpQZGJ5?=
 =?gb2312?B?M3U5cUdQYnF2UGZaVFZsRE9xVjZobjVCQnhlWjNsREJFb05Fbk1QdWY4dCt2?=
 =?gb2312?B?VjkydE41Z3hXTDhwL2pUTGFFbytXSzZwSkZVQnpxZUN0d3puMURRQTBQSi9m?=
 =?gb2312?B?WmhNN2J0ZTRQSVB3bFBHSzJZN0RqZFA5OG01N1FTZGZsRnZvcW85M3daOWF3?=
 =?gb2312?B?dlRnSENPVG53SHhRMTZ2VWNldmVLbHdKeXpkQllJVDRneFlHOExXdHdaK1NZ?=
 =?gb2312?B?a3hyMloySTN1RG5oeXNXa2lDWWhmY1Z4aWcrRWd6dkk3b0o2ZXRlVVpaUHZ6?=
 =?gb2312?B?T3ZRenQxWG11QkdJZHd2eWY4alBjSDMvMVJ5VE9IN0tkTHcrbW1ZRC9CQVRO?=
 =?gb2312?B?b2JtSWRjeWlERmtZU094VC9iNCtrdnBvclVHL3ZFWU9ORG1WVHJERG9RVTBn?=
 =?gb2312?B?NFduSjBoa3RmVGN4Mmx4ZDd6UnAzUzhwQUlNRGttOUpvd1BnKzVuRkdOaFlV?=
 =?gb2312?B?SW9KV1dkc1JUdkh4SFV0Q2xteDlwcGFhVUdZR3NXM3d3dEpFbzE4a3MzSTdG?=
 =?gb2312?B?U3ZIbHdiWnpyS29nZjhCVlE3VHgrbXlOclErRk8zaEVwVVZGRCtpbk5hOHRj?=
 =?gb2312?B?MTREdGp2NGprYk1uRHZVTnVlQU15ZnJMZnJWYi9YN2x0VHZ3OFJaanBBSUUz?=
 =?gb2312?B?V1RHN3phMlRhbjNDbHUvK3NiMm4vdGN0T1JhN1ArMmpXNldTdTZkU1orMzVy?=
 =?gb2312?B?U3NSbitGTXhtcEk2MDMxQ3ZzTnBibCszd3VPWUNLK0VCbEZLeWc0RXhWNTlt?=
 =?gb2312?B?LzB4V0FkckplRGs5VExMK05jc2VnZGFQNzdMMURVUGg4c0FZek5BdHB5bnMv?=
 =?gb2312?B?enNRb2xjV0dBaC9kb2p1UTlydVl4ejZHUnJyalpFVGFJVWRqaEdCWGVySGRG?=
 =?gb2312?B?aHNnWEY2VDFRY0lsTzBNYXlXUHRsaXVlNVF3bmM2TVk5YnZhRjN6UDB5Mkp3?=
 =?gb2312?B?eG1kNmlOTmVMMGdDQS96emZGcm5DVkFoWnZQcjdERlNYTHljcm54SUQxMTZ6?=
 =?gb2312?B?ZTQ1QWhOaGtnWngxVmlQOXNqUjFGQ1lQeVdZYzk3MEM0YmxqQkhBRGVCWXBk?=
 =?gb2312?B?WmpVcWxnb01kYWlGRXU2ZnNTU25vWFAwZFhxNVBTRlRsS1R5eUI3aFZHTzlR?=
 =?gb2312?B?SWdnK2tBLzdaRzVnV2ZyOGtvclhuNXhNcW9ORDlLcEJNTmowUktoUDFkdzk4?=
 =?gb2312?B?UzJVUjAxMVUyd3Q5VGdhSU9uem4zdXBadkcrUkVjWGo4UTEycmJobGNVREFO?=
 =?gb2312?B?Q25xekdQd1p0a1NCRzZtUWhmYmxKc09BWS9GYUdqVG41SzRremNrY0s5MzVZ?=
 =?gb2312?B?SnNZYllFOW5SaTlnR016WC80clFjYTNPUm1UVWJCVzJlWVJPYVdWSFdFUlN3?=
 =?gb2312?B?QVZZL21KeEE3NS9DTjNVOEljYXFiSExFVFhseTkzTTJHV3pFUlJmMnRzSTBh?=
 =?gb2312?Q?7HMQ1x+nqQZm5HhXSmCB?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d0396089-2588-434f-cffa-08da89d45dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 15:37:22.6440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYP286MB0151
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URI_DOTEDU autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW50ZXJlc3RpbmcsIEkgd2lsbCBzZWUgd2hhdCBJIGNhbiBkbyBhYm91dCBpdC4NCkp1c3QgY3Vy
aW91cywgY291bGQgZm9yLW5leHQgdGVzdGluZyBjb3ZlciBhbGwgYXJjaGl0ZWN0dXJlcyBhbmQg
Y29tcGlsZXJzPw0KVGhhbmtzIGZvciBhbGwgdGhlIGluc2lnaHRmdWwgY29tbWVudHMgZnJvbSB5
b3UgZ3V5cywgdGhhdCdzIHZlcnkgaGVscGZ1bC4NCg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBWbGFzdGltaWwgQmFia2EgPHZiYWJrYUBzdXNlLmN6
Pg0Kt6LLzcqxvOQ6IDIwMjLE6jjUwjI5yNUgMjI6MjENCsrVvP7IyzogSHllb25nZ29uIFlvbzsg
TWF0dGhldyBXaWxjb3gNCrOty806IERhd2VpIExpOyBjbEBsaW51eC5jb207IHBlbmJlcmdAa2Vy
bmVsLm9yZzsgcmllbnRqZXNAZ29vZ2xlLmNvbTsgaWFtam9vbnNvby5raW1AbGdlLmNvbTsgYWtw
bUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgcm9tYW4uZ3VzaGNoaW5AbGludXguZGV2OyBsaW51eC1t
bUBrdmFjay5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCtb3zOI6IFJlOiBbUEFU
Q0hdIG1tOiBzaW1wbGlmeSBzaXplMmluZGV4IGNvbnZlcnNpb24gb2YgX19rbWFsbG9jX2luZGV4
DQoNCk9uIDgvMjkvMjIgMDU6MzYsIEh5ZW9uZ2dvbiBZb28gd3JvdGU6DQo+IE9uIE1vbiwgQXVn
IDI5LCAyMDIyIGF0IDA0OjExOjA0QU0gKzAxMDAsIE1hdHRoZXcgV2lsY294IHdyb3RlOg0KPj4g
T24gU3VuLCBBdWcgMjgsIDIwMjIgYXQgMTE6MTQ6NDhQTSArMDgwMCwgRGF3ZWkgTGkgd3JvdGU6
DQo+PiA+IEN1cnJlbnQgc2l6ZTJpbmRleCBpcyBpbXBsZW1lbnRlZCBieSBvbmUgdG8gb25lIGhh
cmRjb2RlIG1hcHBpbmcsDQo+PiA+IHdoaWNoIGNhbiBiZSBpbXByb3ZlZCBieSBvcmRlcl9iYXNl
XzIoKS4NCj4+ID4gTXVzdCBiZSBjYXJlZnVsIHRvIG5vdCB2aW9sYXRlIGNvbXBpbGUtdGltZSBv
cHRpbWl6YXRpb24gcnVsZS4NCj4+DQo+PiBUaGlzIHBhdGNoIGhhcyBiZWVuIE5BQ0tlZCBiZWZv
cmUgKHdoZW4gc3VibWl0dGVkIGJ5IG90aGVyIHBlb3BsZSkuDQo+DQo+DQo+IEhtbSByaWdodC4N
Cj4gaHR0cHM6Ly9sa21sLml1LmVkdS9oeXBlcm1haWwvbGludXgva2VybmVsLzE2MDYuMi8wNTQw
Mi5odG1sDQo+DQo+IENocmlzdG9waCBMYW1ldGVyIHdyb3RlOg0KPj4gT24gV2VkLCAyMiBKdW4g
MjAxNiwgWXVyeSBOb3JvdiB3cm90ZToNCj4+ID4gVGhlcmUgd2lsbCBiZSBubyBmbHMoKSBmb3Ig
Y29uc3RhbnQgYXQgcnVudGltZSBiZWNhdXNlIGlsb2cyKCkgY2FsY3VsYXRlcw0KPj4gPiBjb25z
dGFudCB2YWx1ZXMgYXQgY29tcGlsZS10aW1lIGFzIHdlbGwuIEZyb20gdGhpcyBwb2ludCBvZiB2
aWV3LA0KPj4gPiB0aGlzIHBhdGNoIHJlbW92ZXMgY29kZSBkdXBsaWNhdGlvbiwgYXMgd2UgYWxy
ZWFkeSBoYXZlIGNvbXBpbGUtdGltZQ0KPj4gPiBsb2coKSBjYWxjdWxhdGlvbiBpbiBrZXJuZWws
IGFuZCBzaG91bGQgcmUtdXNlIGl0IHdoZW5ldmVyIHBvc3NpYmxlLlwNCj4NCj4+IFRoZSByZWFz
b24gbm90IHRvIHVzZSBpbG9nIHRoZXJlIHdhcyB0aGF0IHRoZSBjb25zdGFudCBmb2xkaW5nIGRp
ZCBub3QNCj4+IHdvcmsgY29ycmVjdGx5IHdpdGggb25lIG9yIHRoZSBvdGhlciBhcmNoaXRlY3R1
cmVzL2NvbXBpbGVycy4gSWYgeW91IHdhbnQNCj4+IHRvIGRvIHRoaXMgdGhlbiBwbGVhc2UgdmVy
aWZ5IHRoYXQgYWxsIGFyY2hlcyByZWxpYWJseSBkbyBwcm9kdWNlIGENCj4+IGNvbnN0YW50IHRo
ZXJlLg0KPg0KPiBDYW4gd2UgcmUtZXZhbHVhdGUgdGhpcz8NCg0KSXMgdGhlcmUgYSB3YXkgdG8g
dHVybiBpbmFiaWxpdHkgb2YgY29tcGlsZS10aW1lIGNhbGN1bGF0aW9uIHRvIGENCmNvbXBpbGUt
dGltZSBlcnJvcj8gKHdoZW4gc2l6ZV9pc19jb25zdGFudD10cnVlIGV0YykuIFRoZW4gd2UgY291
bGQgdHJ5IGFuZA0Kc2VlIGlmIGFueXRoaW5nIGJyZWFrcyBpbiAtbmV4dC4NCg0K
