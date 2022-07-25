Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497B757F8EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 07:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiGYFEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 01:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGYFED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 01:04:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2040.outbound.protection.outlook.com [40.92.41.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1AFDFA0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 22:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e16pdDLIBWq0B4tu0uXZVFFNkf1DkOezHFn7Zw8V2q/ADyLADo+0N6trU/vEggFCS7ZjvWNkpcuGUJh+1lGiygnC3ohDa6tdCHwuz0OR/AG92w3VM9uLHfxaPclmo8sPhyqrC/pGJHqgPrgyDd4yX17qhiMicGD6obVAtz9LpfKXXaFbj0RQnurBq53LCC98AVu9j6gJ0LAnzShLlJkNXZEOQHEYkDy5DskYGikHFTtCIJMKuEYEuYkuf/qx9qikri0jkvipBRb0X+Ml19jCHXXWXuJCk1/gC8QfVwArbFql0mO70hYx2O6tPukEG5v/xhMhwkQsqb1RAXLs/G7ENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yake0/C6C0sH+skPjJ/+yCcMQskjOO8JxwNs0UFQ7v8=;
 b=eGHYv0gJUjQZ1n+NVcLrJdSr3BjBFPnxrzFMsUc74NvYOtUUTxsGjvUbZCqEfhsLppdL/SfCm0x3/RIHnd8uCPIPI3WnxyjQauA22UpZPaEFwFiVxSVBROlqG51xR8Svypxeq7RkGEI9khxviAA4mdx4gOZ5t8YE2k4fmNY4/MYJeffv4pc4mvcAei5kjTpf/scjOeCgz3xg1/9PuWl9OLkou1Mf8qchSgVp1OLcUVx4JpNAoLTIVMWuP9IYt1WC8y1vZdRlOd3uiNJXB4Oo8hxJHvvjz9o0sEXwK9LNqU+h/OT4lmPodGq7gpuGaRLXnMIIf7tYryF6FCmCtYrtHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yake0/C6C0sH+skPjJ/+yCcMQskjOO8JxwNs0UFQ7v8=;
 b=YrzIh3ktc+GbV2T+ccvtN8mt4BOC32C70BChGs67le5s3/y2qqdPQHBm9dzFQ1v2ChPNFJazsg+3+LJBWhk+ytFOruow1dmE5b+CIWR+KbFrAlV9zRO7rtHHtsUQJ1MoLmf7/cAwdQQ/3QVQ+L7QfG5/U6k5qdDJoPBYZiQm3ZXdsCTJ5DwcmuoXCwHqdb4rPwg1XRn0pIcsFBdw+Uqjwu8Dpy4s9HSe4TbMffTfHoeiMfKMT2N/VHZDFMWrC/oOOq9/DsxwC+bX1pKUhoENLHY1Fo25A7nbm8HrSnQbeBeH8hHzRV5A5TKU5vim5IgAlSCwYEPm1GOcfnp3LVOVAw==
Received: from MN2PR17MB3375.namprd17.prod.outlook.com (2603:10b6:208:13c::25)
 by DM6PR17MB3001.namprd17.prod.outlook.com (2603:10b6:5:72::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 05:03:59 +0000
Received: from MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba]) by MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba%3]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 05:03:59 +0000
From:   Vanessa Page <Vebpe@outlook.com>
To:     Yifei Liu <yifeliu@cs.stonybrook.edu>
CC:     "ezk@cs.stonybrook.edu" <ezk@cs.stonybrook.edu>,
        "madkar@cs.stonybrook.edu" <madkar@cs.stonybrook.edu>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kyeong Yoo <kyeong.yoo@alliedtelesis.co.nz>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] jffs2: correct logic when creating a hole in
 jffs2_write_begin
Thread-Topic: [PATCH] jffs2: correct logic when creating a hole in
 jffs2_write_begin
Thread-Index: AQHYn+OlL8EDeVsAXEe8Sw4ix6TwWa2OiB5V
Date:   Mon, 25 Jul 2022 05:03:59 +0000
Message-ID: <MN2PR17MB337506A10F6AF87BBC514F97B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
References: <20220725045830.11502-1-yifeliu@cs.stonybrook.edu>
In-Reply-To: <20220725045830.11502-1-yifeliu@cs.stonybrook.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [M/SmvOPbuwZiiKpylo/fpOfAr45G9r5JSXU087TE4t1VqBxUjhRJ8jqVWT1tiILA]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de93b07c-3f00-4770-4eb1-08da6dfb15af
x-ms-traffictypediagnostic: DM6PR17MB3001:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vNYWT7ahahYL1FdZ1j6Hxbadt9kTRoqIFplRdrP+RkeVqv0GGiEX9tkDY40pzNbGBnOWU1MTpI2wNaGv76yjJdvtueX8XtpujuCpAWNUE7J+l1+8AXkW4mbOLcpeh7vTcDTj8JzYAlV1mSGx3f6C70TUvm418tFYhlYf62QM9G5EgqrJPMdwrwUVwjUyFZBz7NnnVS8qVE1quHEI4PRODtGGEeLnskEK5zzW1O9ye6zU3pgLF6WYqqbUnzeBe8y8c0zmoMlz8WRssCklP9i93PURSciEk0O0DvgO8i9ZSfzzSAYswWTiDtbfDcwQ8uivO+7Vl7PFsDVASRMqNL4U2pz6FV9Lh5BOI82A1MlBAB96NM1sCdqPxOOqXIjaCVLjJ/BCS3GfEX9lwtwyH3jY2aVjRmqAsRYF3dpea7xbux3d5bbPAHOtTwBJGD9wj/l3Hrf8VC2ijTHu3ODCaxWElkwqTg4EihbzY/CFZl5+oL92GHfCtl7/SNeNtHFflVMXJnlYdOSh8eJ8d/PO/B3PCI0f7xOqf+45vCw9OU1mC8p/KDX0PitRL9SUrVf3/xlVpWPTWWlZtgKAjMl4iXCt4VbQkXtE9pYZsSfNdRlPUy1wIOhIRJfnmUrlq7uqI5rBMlwd7L78WUVAzddR4/wLZ+v56xYrptcTjJYcVrXwHBs72ohCDSx5mSscyzS195nO
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUNjaHBuYXVWY3VCUEp6ZGdvbEQrR2ppdE1oN0FSejlpM3pENEtWUUQremJ1?=
 =?utf-8?B?SE4zcXg5Y3pSaW9paGhTeFdDL3VHbHgxbzJ3MDNqdHA3cTRlVVpmWHJ2elJB?=
 =?utf-8?B?Q2phbm00bFJIRE55VFFFWjlvQ0pzcmw2VmVwUHVIdXNLQXVrcmJYUzc1WjhX?=
 =?utf-8?B?WEZHSFhORVRhaHdFaC9QZGxZU2lZSm5wdjNkdHgraVMrZ0hpU2diZ2xrWTN5?=
 =?utf-8?B?SjRtekpLelI5cGk5WVA2NUtMeUI0WHA1OHplbUtEWks0elpjOVZqLzJzanFV?=
 =?utf-8?B?WmVRdjZZcTNuVy9TVWlKdFdqaDNkK09tMm5JL3pDZzkxbGUxbTJTVU9BRzgy?=
 =?utf-8?B?NlhnYW9IeWZDNUV3SlErL3JiM1dyRCtpQXAzTUpEZ010ZWw0VGxQekpnZE1q?=
 =?utf-8?B?TnFBNnJzVjcrTjBsU3NieDhySHdOV0wxa1Bta0thVHdZeFNuN1piMy9kb25h?=
 =?utf-8?B?Uk4zOUFiV0M1cDZrV1RkTE9vWHJ1U2tXVzNxUkc3bWNkbUVWNDNFZlFoZldl?=
 =?utf-8?B?eWh2cHAzcWNJZVVMMTBmaXhQWlBBSFNFaUJZdm1Ob0Q4NHdwNTNzamN1SDRj?=
 =?utf-8?B?QkJ4Y1FNejJhYnhpdFdpTTNhejUxYnRUQktwd2Jid1BsTlFXeEgwWWYwSnJh?=
 =?utf-8?B?WjhZM2ZyTjc2a2RYalg1VTkwdFRXMHc1L2tteEd6UjE3anVXeitRam1XY09X?=
 =?utf-8?B?eDhqN3MrQ0xjcmYxOVoxMVJlem8wVUVMNUVDWXNWQ2hoNk41UWYyRG4xWXpI?=
 =?utf-8?B?T1VnMTFkYWtybUxTTjlzb1VRVy9Pd0xZQkZLeDVBQXpxRHZEMnkxVEJ3V2hU?=
 =?utf-8?B?cFo0TlV6THZuRDNQcmR6Mjl0Sm02UzJEazZLU3A5ek9aQW01eDdmK3NSMk9j?=
 =?utf-8?B?c2E5allMclJJbnhwZnhiWDE1ZVVCdVFiaFJpaUptNlBKZlFyd1JoK09IM3I1?=
 =?utf-8?B?Vy9GWU02NUt0b2t0MzJGcVBhK0I1RzY2VXBhNWRlL3B2K2ljaUpBbmZIRlVU?=
 =?utf-8?B?YkFYRFh4UFFrTFFnL3o0K1JOMUNxTjhsRjhlMnp5cXJXN0RNVlJFN1FuRGt5?=
 =?utf-8?B?TXpqd3BMdEM0b2FwVnM3R1NDZTNwNDZZR25zL3VKSEdQSXZTSGV4YmM1Z093?=
 =?utf-8?B?WTlJRnhveStOclZQamdtS0xlOG1FSFBUSjlLTUdBd0lzQzdTNVRsWW5oNmc1?=
 =?utf-8?B?N0RCT3Bkc0Z0eGtVN21CNkFLcTdWNzNCM1lYSTVyRExiQlRwNHR2NytZMkJI?=
 =?utf-8?B?UXl1aVdDSlVRODByNk9xc1N5ZkhMRHVTZjZqRnJ0K3pUY1NYbU9TRlVhYWpK?=
 =?utf-8?B?U0xLbnFyUTZKM1NzS0hmRnNXNFVjUlA5WU93ejFrRTJ3WmNLS3VxRkM4RW5P?=
 =?utf-8?B?VENKV3NpU1BhQnk3Z0dpQmgra0xPUEdKRzUrYThoV2RqRERVM0R3NWFMdVdS?=
 =?utf-8?B?OHNxRTdyNzhEVHBkWWh2dG5wT1hVS0EyYUZZZWVJVk5wY2V2ZkFXM1N5U25p?=
 =?utf-8?B?d3N3QUk4dnlXTW5oT0hHdEtURm5sZ09ZNzBLYzJSZkcrTDlKTXdQL3VGZFo5?=
 =?utf-8?B?MmQvV0ZScE9RRElobytVcXF4R3czZE9YNmtlbk1vY21mU0dxNHU3WG92RGE3?=
 =?utf-8?B?UXcxeUNPWFFGTDlvK2NMalZuNGJEV01aYjRrNW1veFAwZDZoWTUxdlBtVlBz?=
 =?utf-8?B?RUNjNTNFWEJncERmbHdvODFmcVZURXB2ZmErYmw1VVhuSVArM1dWTWczT2c4?=
 =?utf-8?Q?s5iNYMjYqmUK9zgKdtRoWG9q9IPaNNfOqIF+CQp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR17MB3375.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: de93b07c-3f00-4770-4eb1-08da6dfb15af
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 05:03:59.4063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB3001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8J+lsPCfpbDwn6Ww8J+lsPCfpbDwn6Ww8J+lsPCfpbDwn6Ww8J+YjfCfkYzwn5iN8J+RjPCfmI3w
n5iN8J+YjfCfmI3wn5iN4pi677iP4pi677iP4pi677iP4pi677iP4pi677iP8J+SlfCfkpXwn5ia
8J+YmvCfmJrwn5ia8J+lsPCfmJrwn5iN8J+YjfCfmI3wn5ia8J+YmvCfmI3imLrvuI/imLrvuI/i
mLrvuI/wn5iN8J+SlfCfmJrwn6Ww8J+lsPCfmI3imLrvuI/imLrvuI/wn5ia8J+lsPCfmI3imLrv
uI/wn5iN8J+lsPCfmI3imLrvuI/imLrvuI/wn5KV8J+lsPCfpbDwn5iN4pi677iP4pi677iP8J+Y
ig0KDQpTZW50IGZyb20gbXkgaVBob27inIzvuI8NCg0KPiBPbiBKdWwgMjUsIDIwMjIsIGF0IDE6
MDEgQU0sIFlpZmVpIExpdSA8eWlmZWxpdUBjcy5zdG9ueWJyb29rLmVkdT4gd3JvdGU6DQo+IA0K
PiDvu79CdWcgZGVzY3JpcHRpb24gYW5kIGZpeDoNCj4gDQo+IDEuIFdyaXRlIGRhdGEgdG8gYSBm
aWxlLCBzYXkgYWxsIDFzIGZyb20gb2Zmc2V0IDAgdG8gMTYuDQo+IA0KPiAyLiBUcnVuY2F0ZSB0
aGUgZmlsZSB0byBhIHNtYWxsZXIgc2l6ZSwgc2F5IDggYnl0ZXMuDQo+IA0KPiAzLiBXcml0ZSBu
ZXcgYnl0ZXMgKHNheSAycykgZnJvbSBhbiBvZmZzZXQgcGFzdCB0aGUgb3JpZ2luYWwgc2l6ZSBv
ZiB0aGUNCj4gZmlsZSwgc2F5IGF0IG9mZnNldCAyMCwgZm9yIDQgYnl0ZXMuICBUaGlzIGlzIHN1
cHBvc2VkIHRvIGNyZWF0ZSBhICJob2xlIg0KPiBpbiB0aGUgZmlsZSwgbWVhbmluZyB0aGF0IHRo
ZSBieXRlcyBmcm9tIG9mZnNldCA4ICh3aGVyZSBpdCB3YXMgdHJ1bmNhdGVkDQo+IGFib3ZlKSB1
cCB0byB0aGUgbmV3IHdyaXRlIGF0IG9mZnNldCAyMCwgc2hvdWxkIGFsbCBiZSAwcyAoemVyb3Mp
Lg0KPiANCj4gNC4gZmx1c2ggYWxsIGNhY2hlcyB1c2luZyAiZWNobyAzID4gL3Byb2Mvc3lzL3Zt
L2Ryb3BfY2FjaGVzIiAob3IgdW5tb3VudA0KPiBhbmQgcmVtb3VudCkgdGhlIGYvcy4NCj4gDQo+
IDUuIENoZWNrIHRoZSBjb250ZW50IG9mIHRoZSBmaWxlLiAgSXQgaXMgd3JvbmcuICBUaGUgMXMg
dGhhdCB1c2VkIHRvIGJlDQo+IGJldHdlZW4gYnl0ZXMgOSBhbmQgMTYsIGJlZm9yZSB0aGUgdHJ1
bmNhdGlvbiwgaGF2ZSBSRUFQUEVBUkVEICh0aGV5IHNob3VsZA0KPiBiZSAwcykuDQo+IA0KPiBX
ZSB3cm90ZSBhIHNjcmlwdCBhbmQgaGVscGVyIEMgcHJvZ3JhbSB0byByZXByb2R1Y2UgdGhlIGJ1
Zw0KPiAocmVwcm9kdWNlX2pmZnMyX3dyaXRlX2JlZ2luX2lzc3VlLnNoLCB3cml0ZV9maWxlLmMs
IGFuZCBNYWtlZmlsZSkuICBXZSBjYW4NCj4gbWFrZSB0aGVtIGF2YWlsYWJsZSB0byBhbnlvbmUu
DQo+IA0KPiBUaGUgYWJvdmUgZXhhbXBsZSBpcyBzaG93biB3aGVuIHdyaXRpbmcgYSBzbWFsbCBm
aWxlIHdpdGhpbiB0aGUgc2FtZSBmaXJzdA0KPiBwYWdlLiAgQnV0IHRoZSBidWcgaGFwcGVucyBm
b3IgbGFyZ2VyIGZpbGVzLCBhcyBsb25nIGFzIHN0ZXBzIDEsIDIsIGFuZCAzDQo+IGFib3ZlIGFs
bCBoYXBwZW4gd2l0aGluIHRoZSBzYW1lIHBhZ2UuDQo+IA0KPiBUaGUgcHJvYmxlbSB3YXMgdHJh
Y2VkIHRvIHRoZSBqZmZzMl93cml0ZV9iZWdpbiBjb2RlLCB3aGVyZSBpdCBnb2VzIGludG8gYW4N
Cj4gJ2lmJyBzdGF0ZW1lbnQgaW50ZW5kZWQgdG8gaGFuZGxlIHdyaXRlcyBwYXN0IHRoZSBjdXJy
ZW50IEVPRiAoaS5lLiwgd3JpdGVzDQo+IHRoYXQgbWF5IGNyZWF0ZSBhIGhvbGUpLiAgVGhlIGNv
ZGUgY29tcHV0ZXMgYSAncGFnZW9mcycgdGhhdCBpcyB0aGUgZmxvb3INCj4gb2YgdGhlIHdyaXRl
IHBvc2l0aW9uIChwb3MpLCBhbGlnbmVkIHRvIHRoZSBwYWdlIHNpemUgYm91bmRhcnkuICBJbiBv
dGhlcg0KPiB3b3JkcywgJ3BhZ2VvZnMnIHdpbGwgbmV2ZXIgYmUgbGFyZ2VyIHRoYW4gJ3Bvcycu
ICBUaGUgY29kZSB0aGVuIHNldHMgdGhlDQo+IGludGVybmFsIGpmZnMyX3Jhd19pbm9kZS0+aXNp
emUgdG8gdGhlIHNpemUgb2YgbWF4KGN1cnJlbnQgaW5vZGUgc2l6ZSwNCj4gcGFnZW9mcykgYnV0
IHRoYXQgaXMgd3Jvbmc6IHRoZSBuZXcgZmlsZSBzaXplIHNob3VsZCBiZSB0aGUgJ3BvcycsIHdo
aWNoIGlzDQo+IGxhcmdlciB0aGFuIGJvdGggdGhlIGN1cnJlbnQgaW5vZGUgc2l6ZSBhbmQgcGFn
ZW9mcy4NCj4gDQo+IFNpbWlsYXJseSwgdGhlIGNvZGUgaW5jb3JyZWN0bHkgc2V0cyB0aGUgaW50
ZXJuYWwgamZmczJfcmF3X2lub2RlLT5kc2l6ZSB0bw0KPiB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVu
IHRoZSBwYWdlb2ZzIG1pbnVzIGN1cnJlbnQgaW5vZGUgc2l6ZTsgaW5zdGVhZCBpdA0KPiBzaG91
bGQgYmUgdGhlIGN1cnJlbnQgcG9zIG1pbnVzIHRoZSBjdXJyZW50IGlub2RlIHNpemUuICBGaW5h
bGx5LA0KPiBpbm9kZS0+aV9zaXplIHdhcyBhbHNvIHNldCBpbmNvcnJlY3RseS4NCj4gDQo+IFRo
ZSBwYXRjaCBiZWxvdyBmaXhlcyB0aGlzIGJ1Zy4gIFRoZSBidWcgd2FzIGRpc2NvdmVyZWQgdXNp
bmcgYSBuZXcgdG9vbA0KPiBmb3IgZmluZGluZyBmL3MgYnVncyB1c2luZyBtb2RlbCBjaGVja2lu
ZywgY2FsbGVkIE1DRlMgKE1vZGVsIENoZWNraW5nIEZpbGUNCj4gU3lzdGVtcykuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBZaWZlaSBMaXUgPHlpZmVsaXVAY3Muc3Rvbnlicm9vay5lZHU+DQo+IFNp
Z25lZC1vZmYtYnk6IEVyZXogWmFkb2sgPGV6a0Bjcy5zdG9ueWJyb29rLmVkdT4NCj4gU2lnbmVk
LW9mZi1ieTogTWFuaXNoIEFka2FyIDxtYWRrYXJAY3Muc3Rvbnlicm9vay5lZHU+DQo+IC0tLQ0K
PiBmcy9qZmZzMi9maWxlLmMgfCAxNSArKysrKysrLS0tLS0tLS0NCj4gMSBmaWxlIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9q
ZmZzMi9maWxlLmMgYi9mcy9qZmZzMi9maWxlLmMNCj4gaW5kZXggYmE4NmFjYmUxMmQzLi4wNDc5
MDk2Yjk2ZTQgMTAwNjQ0DQo+IC0tLSBhL2ZzL2pmZnMyL2ZpbGUuYw0KPiArKysgYi9mcy9qZmZz
Mi9maWxlLmMNCj4gQEAgLTEzNywxOSArMTM3LDE4IEBAIHN0YXRpYyBpbnQgamZmczJfd3JpdGVf
YmVnaW4oc3RydWN0IGZpbGUgKmZpbHAsIHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLA0K
PiAgICBzdHJ1Y3QgamZmczJfaW5vZGVfaW5mbyAqZiA9IEpGRlMyX0lOT0RFX0lORk8oaW5vZGUp
Ow0KPiAgICBzdHJ1Y3QgamZmczJfc2JfaW5mbyAqYyA9IEpGRlMyX1NCX0lORk8oaW5vZGUtPmlf
c2IpOw0KPiAgICBwZ29mZl90IGluZGV4ID0gcG9zID4+IFBBR0VfU0hJRlQ7DQo+IC0gICAgdWlu
dDMyX3QgcGFnZW9mcyA9IGluZGV4IDw8IFBBR0VfU0hJRlQ7DQo+ICAgIGludCByZXQgPSAwOw0K
PiANCj4gICAgamZmczJfZGJnKDEsICIlcygpXG4iLCBfX2Z1bmNfXyk7DQo+IA0KPiAtICAgIGlm
IChwYWdlb2ZzID4gaW5vZGUtPmlfc2l6ZSkgew0KPiAtICAgICAgICAvKiBNYWtlIG5ldyBob2xl
IGZyYWcgZnJvbSBvbGQgRU9GIHRvIG5ldyBwYWdlICovDQo+ICsgICAgaWYgKHBvcyA+IGlub2Rl
LT5pX3NpemUpIHsNCj4gKyAgICAgICAgLyogTWFrZSBuZXcgaG9sZSBmcmFnIGZyb20gb2xkIEVP
RiB0byBuZXcgcG9zaXRpb24gKi8NCj4gICAgICAgIHN0cnVjdCBqZmZzMl9yYXdfaW5vZGUgcmk7
DQo+ICAgICAgICBzdHJ1Y3QgamZmczJfZnVsbF9kbm9kZSAqZm47DQo+ICAgICAgICB1aW50MzJf
dCBhbGxvY19sZW47DQo+IA0KPiAtICAgICAgICBqZmZzMl9kYmcoMSwgIldyaXRpbmcgbmV3IGhv
bGUgZnJhZyAweCV4LTB4JXggYmV0d2VlbiBjdXJyZW50IEVPRiBhbmQgbmV3IHBhZ2VcbiIsDQo+
IC0gICAgICAgICAgICAgICh1bnNpZ25lZCBpbnQpaW5vZGUtPmlfc2l6ZSwgcGFnZW9mcyk7DQo+
ICsgICAgICAgIGpmZnMyX2RiZygxLCAiV3JpdGluZyBuZXcgaG9sZSBmcmFnIDB4JXgtMHgleCBi
ZXR3ZWVuIGN1cnJlbnQgRU9GIGFuZCBuZXcgcG9zaXRpb25cbiIsDQo+ICsgICAgICAgICAgICAg
ICh1bnNpZ25lZCBpbnQpaW5vZGUtPmlfc2l6ZSwgKHVpbnQzMl90KXBvcyk7DQo+IA0KPiAgICAg
ICAgcmV0ID0gamZmczJfcmVzZXJ2ZV9zcGFjZShjLCBzaXplb2YocmkpLCAmYWxsb2NfbGVuLA0K
PiAgICAgICAgICAgICAgICAgICAgICBBTExPQ19OT1JNQUwsIEpGRlMyX1NVTU1BUllfSU5PREVf
U0laRSk7DQo+IEBAIC0xNjksMTAgKzE2OCwxMCBAQCBzdGF0aWMgaW50IGpmZnMyX3dyaXRlX2Jl
Z2luKHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywNCj4g
ICAgICAgIHJpLm1vZGUgPSBjcHVfdG9famVtb2RlKGlub2RlLT5pX21vZGUpOw0KPiAgICAgICAg
cmkudWlkID0gY3B1X3RvX2plMTYoaV91aWRfcmVhZChpbm9kZSkpOw0KPiAgICAgICAgcmkuZ2lk
ID0gY3B1X3RvX2plMTYoaV9naWRfcmVhZChpbm9kZSkpOw0KPiAtICAgICAgICByaS5pc2l6ZSA9
IGNwdV90b19qZTMyKG1heCgodWludDMyX3QpaW5vZGUtPmlfc2l6ZSwgcGFnZW9mcykpOw0KPiAr
ICAgICAgICByaS5pc2l6ZSA9IGNwdV90b19qZTMyKCh1aW50MzJfdClwb3MpOw0KPiAgICAgICAg
cmkuYXRpbWUgPSByaS5jdGltZSA9IHJpLm10aW1lID0gY3B1X3RvX2plMzIoSkZGUzJfTk9XKCkp
Ow0KPiAgICAgICAgcmkub2Zmc2V0ID0gY3B1X3RvX2plMzIoaW5vZGUtPmlfc2l6ZSk7DQo+IC0g
ICAgICAgIHJpLmRzaXplID0gY3B1X3RvX2plMzIocGFnZW9mcyAtIGlub2RlLT5pX3NpemUpOw0K
PiArICAgICAgICByaS5kc2l6ZSA9IGNwdV90b19qZTMyKCh1aW50MzJfdClwb3MgLSBpbm9kZS0+
aV9zaXplKTsNCj4gICAgICAgIHJpLmNzaXplID0gY3B1X3RvX2plMzIoMCk7DQo+ICAgICAgICBy
aS5jb21wciA9IEpGRlMyX0NPTVBSX1pFUk87DQo+ICAgICAgICByaS5ub2RlX2NyYyA9IGNwdV90
b19qZTMyKGNyYzMyKDAsICZyaSwgc2l6ZW9mKHJpKS04KSk7DQo+IEBAIC0yMDIsNyArMjAxLDcg
QEAgc3RhdGljIGludCBqZmZzMl93cml0ZV9iZWdpbihzdHJ1Y3QgZmlsZSAqZmlscCwgc3RydWN0
IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsDQo+ICAgICAgICAgICAgZ290byBvdXRfZXJyOw0KPiAg
ICAgICAgfQ0KPiAgICAgICAgamZmczJfY29tcGxldGVfcmVzZXJ2YXRpb24oYyk7DQo+IC0gICAg
ICAgIGlub2RlLT5pX3NpemUgPSBwYWdlb2ZzOw0KPiArICAgICAgICBpbm9kZS0+aV9zaXplID0g
cG9zOw0KPiAgICAgICAgbXV0ZXhfdW5sb2NrKCZmLT5zZW0pOw0KPiAgICB9DQo+IA0KPiAtLSAN
Cj4gMi4yNS4xDQo+IA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQo+IExpbnV4IE1URCBkaXNjdXNzaW9uIG1haWxpbmcgbGlzdA0K
PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW10ZC8N
Cg==
