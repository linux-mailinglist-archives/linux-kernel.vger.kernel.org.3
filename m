Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE70246CBD7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 05:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbhLHEGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 23:06:02 -0500
Received: from mail-sgaapc01on2108.outbound.protection.outlook.com ([40.107.215.108]:53248
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229958AbhLHEF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:05:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2WwJu81KoRTQXMgDdKXDPgoypRDVqo38bvQXAo2wttl97sAg8TxG0fl7ZvyykZpXXVOO+tWMM8nVNGvlAPj3xyhsbXswvyAzQJmOLKVgY5hDJY4vG6rdjf5sLa1QQ0thCHxO1nZoEfXv1YeacV4v8KOF9sakkAz93zvH400ExIcPuCJI/AnpKpIxXLgAAG0o/cm8HMPWlGD3HWS8LMG9THWrq/5uzC0glMaE9q2VJduIt148qUySVp2vk64y/36OOaq03tWAB5dMaKY2VpxnzyVkKbtAQHtYWycUoBNOxw6smBJApFYnulapMP2IGLEMtREFDOKhQyC1qtSit0LYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnlGjkZRKNEqTFv7Yl3j0GxPTq+9fwbRPErd+nnv8yk=;
 b=nPZksUWrw+wS3xeWyCsfgAjWHvNcOh3MCrAHd8uYyuzij5e97byiwZqbHhqr5T/bYFyxbjbz+3Vgc5EShnuVK25ZbDd77In+7HSvL0Kwa5I4cntZeC19k6gAhMNo6NDFyVWE9ZbGGU5biuszhniDBDFhrsju6WB9p4hKrNONwDbzkjgbgiDSi1nl0LPQXds+rue7aQWR42+5I8qZF/aLqSR2kg2AuOGZ0g0Kd/qiF+Co+XVOhEY6ALgE76bTCcRCDRcoK6RlW0WZ7elnw4wHwE32KteU8lGb2ASPGb/LbKQ/9kuWPk2MyYJ9i7RyoRyXfgHfNqGz30QJJIbUEBbZtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnlGjkZRKNEqTFv7Yl3j0GxPTq+9fwbRPErd+nnv8yk=;
 b=ytFvPPO/FcZIy5e5V9JogO8HzgVVf+aZF35mOiJuttbc2z7SR/ptwoh3gyjdIOAMh/r5W2Z01CGHsg2NdvdCBp/7KDfU3gJ8EnDu+DfO4LBbQl7P2I+mttUUth3xHtC6KdwqYgb7cKgCSbkN/hqs34HHx28eY5+mlt7KbjZMVs0WOyv2RCSa7mAKAaC9D+kir0Y9ZNfLtxpiE+qMZb+Q+ZgIjcv6QPTWGzEXvGA7me5ON9yfCeQVEgmEDp4BcWOk9yo2Mp5HHDveYWf6ZDyHBM18aEcfcYyTCl+k8Az+oZM9j5TWSZ9cWbqqiTwzKCSo1Lo3EEKIgtccKOlcqcaM1A==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB2676.apcprd06.prod.outlook.com (2603:1096:203:34::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 8 Dec
 2021 04:02:22 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::7941:2fad:3c82:52eb]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::7941:2fad:3c82:52eb%3]) with mapi id 15.20.4778.012; Wed, 8 Dec 2021
 04:02:22 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>, Joel Stanley <joel@jms.id.au>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v14 0/2] Support pwm driver for aspeed ast26xx
Thread-Topic: [v14 0/2] Support pwm driver for aspeed ast26xx
Thread-Index: AQHX5a8/rr+kKZrUpEWMlmurbajygawmoMKAgAD0O4CAAPaNgA==
Date:   Wed, 8 Dec 2021 04:02:22 +0000
Message-ID: <ADD1E8B8-60F0-442A-BEF1-1AA304454963@aspeedtech.com>
References: <20211130055933.32708-1-billy_tsai@aspeedtech.com>
 <CACPK8XfM4C7v3keXaxMs9SkqNzb8XWbZ6QvcZXWcy3ZKJCrvWQ@mail.gmail.com>
 <Ya/P+4CNTnUUqlG9@robh.at.kernel.org>
In-Reply-To: <Ya/P+4CNTnUUqlG9@robh.at.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 278bac1f-67fc-4c53-1abf-08d9b9ff8993
x-ms-traffictypediagnostic: HK0PR06MB2676:EE_
x-microsoft-antispam-prvs: <HK0PR06MB26767FC331AD5952AD08735E8B6F9@HK0PR06MB2676.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v47cT4gbYc8PxTs3OIPdDOqOzePZ20A7V1RjA3+HFVcXh1gDXkzJmwrMW71ZuG1F8CVq6UpoCjMe6Ssj0CVz+t20i4JHt9J3u693fqb5aD1ZjUt1LuJnMoAn5cFZlh5zbXB0i0noki8G/wZkHTfIo0Wotq/biScVZq9SR6wpxBAKt7QDS730PPtlJzob3NIpZqqYNgYth4XAVS+GaNFPPWx86Vrbk6jFcXOIsKhUl0KaNcSAp0xIDTmt0BL4OfBqbeOHP2a5IVtY8y0d1QHaJJtKbYs0C2yTQ3GyBghAQAPQ3mUU9bbvJHwxrOyBgm/vnviotYaGtzSAqMFbX3gMHEYc6tpsCfGTy9AywsDeyASDiLGK2ZYFMgegty7E63cBrBmaRKZawzAJneQoDOXVzGVJl+6gPT2Q7LlwPRmGYfn7EfGuwlJqYv56ATqcV6GVIaLyQ1BXoQsklWxHA6Mo68F7v+9Nc17b0TCegJZfxXHcZs9/ezVtS8O3jAwtEkAj31SXRS+nCAsXShIDPAS21aeWeRCW9u7jS0G0q3Se7gATKQV0x6AqaDk7ikMP9Es2CPr8DUNVRub4dLmVHmEvyBwrIyAfR2NKAcaYxkS46LEtqkkHbziqkuQbdtwMQaz9ap+9bB2M6Wzvgow2kJsPZ8UU8Tr56jkQwhz1b1bELfF5gYc3doFApcF32m3dOxrhyh5Mw8Rm+EHnTP5NRDcIZv9xUPqAWO4ZBvQDYnKsOoS/BJGmOF1n4fTosN69PGUahnZ2RGsk0NJxZc05OphxQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(396003)(366004)(136003)(346002)(376002)(5660300002)(2906002)(508600001)(54906003)(110136005)(71200400001)(316002)(38100700002)(38070700005)(8936002)(6506007)(186003)(33656002)(122000001)(26005)(53546011)(8676002)(64756008)(66446008)(2616005)(6512007)(66556008)(66476007)(7416002)(76116006)(66946007)(86362001)(83380400001)(4326008)(107886003)(36756003)(6486002)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDZzNjJDeXhJeWVVTElzSVdyaHNhVEh2Z1JtcjFXd3UvM0dDamtZVi9HVW5L?=
 =?utf-8?B?UTdhZ2h6L3psRU13UTBRZWVwN0x4WFVQNEhTWkdabklnNUFUQzVBRm93dExy?=
 =?utf-8?B?SHU0LzhKMEVieFI0T1EvZ1haTklOTFJGWDIwSU9HQ0x5YkNQYTllZ2x0QWdW?=
 =?utf-8?B?ajA5QjE2eTNLUnIveHF2ckZEUVFOOFQzczkvVUFvdW9TMUlRUWdhYmNFSVpU?=
 =?utf-8?B?Z3pVdU5iUnphb1BwN2dNdjVKWk40bmJYWG45TllaOXdDcFgrdk5VNFJuVGR5?=
 =?utf-8?B?K21zZnIzYXpRREpsem1UcFF1Mk9odllIc0tQblN1RWFySFoyTEVIZk9ad253?=
 =?utf-8?B?TGU2d0c2VXZra05URmFwZGNXNklSS0srb1Z5aFFsdHFmVmVBZXA3NytJcmFr?=
 =?utf-8?B?WGNJTXhGODJPTTdLVWVtZVpSZ0ZjSStTcHdjc1AzRDl1NnVRVFVqQ1JyUEg2?=
 =?utf-8?B?eEJxV0lndnRkWlZoMXd4ZndNMXVMdVNJbFFRdk5sa1BuNjVBbWtYMjg0Lzdj?=
 =?utf-8?B?Y0tGd1JWM3djQ01JY2NkSFFkVDFhb2R6QTAyNy9lSTQ1MHlIKzhhRHRUZHpY?=
 =?utf-8?B?YVdLcjJ0MThtMUpEWWpGaDVDYWgzNlNRYmlpcldjakhhZ0ZKRk9Yc0d4d1l3?=
 =?utf-8?B?eGhjK0g1QmZwbFFLRFdOTUhVT3JPQ0l2RHBOWk5aL0JFTFVXTmZueG1DTXJ0?=
 =?utf-8?B?QVA2bkFsT0pxd2VuRXI3R0VnejNnc3RSTUNLUnIzTUxXbjNLRm52bE1KMis1?=
 =?utf-8?B?dGtEZ0lqeFpYcXBCR0VTS2hCZTFNZkRhSG9JOVBYSW5qOG5IeisyVFpycWRr?=
 =?utf-8?B?N2xzMk5qY3lVaDRIKy9CNEZCZ3pqdi93bWpwQjNKa09aQTB5Mk9pcExUZ3FP?=
 =?utf-8?B?ZjlnamgwVDJUcVBzNmdnTFpZU3I5NXRkb2hxVjlGdGswMzYwZk0rVjZRQXEy?=
 =?utf-8?B?Z2orSkdQb1c4dDVLYWM0dStBYWZseEtDTmYwYS9sNGVlMWJFY1dZWTJudlh0?=
 =?utf-8?B?RXR1RkhEOXJJYUhEREJneThjaXdCNXBSZVkrYkNkRklJejZUTjF6L1RYTWd0?=
 =?utf-8?B?NTFiQW9BRHhpYWoyK09VSXpNME1OSTB3bXBCTWJQVjBDc2JROFhORUt6S29S?=
 =?utf-8?B?c1JaK29LdklKdUtqcXY1bEhEU0lBZU9nN2cxNGZ0V3NpRTBGdUdWRVFYdVVk?=
 =?utf-8?B?TFdxZlB6RnFpZmRpOUxLNmVzamttdmJ4dDVGemZhcWg4MTZLVkpIOEQ0M2FK?=
 =?utf-8?B?dzJ3Ui9FdnpLV20yaS8wYllQL1Q4d0UvZVRoSDc4Y1RsVC92aE9POWdIYnRX?=
 =?utf-8?B?dnJXZU1wQjNuc0hVbk5CdXpReHZ4a0JlanhiSDJiZFpvc2ZQdmU4emhEZWVS?=
 =?utf-8?B?SThGTnN4NFBmRlJZamYraDc0aDFvd3ZOancrVUo0YStaWVVIWW91TDhwSFE3?=
 =?utf-8?B?M1lIck5xbWo5bFFzVHVYWUREaGdhajlmQkZkYzRJSTlpM1hNMHlSMDUyRjIy?=
 =?utf-8?B?MHIxU08zdENCSnpoMjYybzdud0hUSXpSRERyT3paOTg2b3BhK2tiY3FhK290?=
 =?utf-8?B?Z2JZWDUzcHpDSlRSNzdsTDZZaldrMzZZVXczMXlHYjEwN0wxc2o3elZrcWQ2?=
 =?utf-8?B?cEtRN3hvMnhqNTlVamQvajE4cnRkSkVIL21SaWRuVnNWNk45TWpwalkrRWZO?=
 =?utf-8?B?NDhyK0xmN0VrT3RwVnFFSFg5OUdYVUd0MDFrN1d1K0Znby9VcDc0eGlDZ0c1?=
 =?utf-8?B?L21NUVllT0MrRkRtSUcvR0dVOWlLay94R2p2akZkTG9nQWpLRVo2R0EwK3FQ?=
 =?utf-8?B?b0t2a0pBSHdOczI3WjlTZzVSTEdZZUdreWwwMFpWZVFUdlc1QXYzUjE5b0tn?=
 =?utf-8?B?cXhqb3l4UHp4QS9VdXZYazR3SFNlenFPN0VSLzdmbFN3QTgyMHZVRGlXdnRW?=
 =?utf-8?B?UWlQTmN1N29lV3hUdlBQM2hhMHZSTnR3T3VBZ2RZM2VoMWc1aTVta0lTRGxJ?=
 =?utf-8?B?dUI2c1l1ZWdkdVlXODBXTXM3N3VwbEZRbkZlQ2l6bFVyb3pSNUp4cFczVE1u?=
 =?utf-8?B?L2lTek10OGY5a1JaaHFuUEwxWTBkSmpieWhydmU0R0pOWTF5bWEzVWF6ZkJ5?=
 =?utf-8?B?ZE9Kcm1seGZQMDZYaTdjTXA3UklQRTdNME9mNWEwVkJ0czBLL1J6c1NNZHQy?=
 =?utf-8?B?VXFyTkkwK2xqclg4SXNwTk5ISk8xdUdTWTIyQmJOZFBDTTNSUHpLNGJiejhN?=
 =?utf-8?Q?npS1NIgnhORWwYe/4bZ7Dx8Bn2d5FQpuLKEgAphhwU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4E9BC4209E7EB489C9EC7A8918E3944@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278bac1f-67fc-4c53-1abf-08d9b9ff8993
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 04:02:22.3445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xPDJM6buOTuw2E9M2y0H+WVahbbdj2wIBgG8W9ZZoYznRN3q4JwKdRKpxMn4MbpLei+rzeVoVfC/eOHEgN09V1a0/PFphmUKVpmBMRUoDV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2676
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpPbiAyMDIxLzEyLzgsIDU6MjAgQU0sICJSb2IgSGVycmluZyIgPHJvYmhAa2Vy
bmVsLm9yZz4gd3JvdGU6DQoNCiAgICBPbiBUdWUsIERlYyAwNywgMjAyMSBhdCAwNjo0NTo0N0FN
ICswMDAwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQogICAgPiAgID4gSGkgQmlsbHksDQogICAgPiAg
ID4gDQogICAgPiAgID4gT24gVHVlLCAzMCBOb3YgMjAyMSBhdCAwNTo1OCwgQmlsbHkgVHNhaSA8
YmlsbHlfdHNhaUBhc3BlZWR0ZWNoLmNvbT4gd3JvdGU6DQogICAgPiAgID4gPg0KICAgID4gICA+
ID4gVGhlIGxlZ2FjeSBkcml2ZXIgb2YgYXNwZWVkIHB3bSBpcyBiaW5kaW5nIHdpdGggdGFjaCBj
b250cm9sbGVyIGFuZCBpdA0KICAgID4gICA+ID4gZG9lc24ndCBmb2xsb3cgdGhlIHB3bSBmcmFt
d29ya3MgdXNhZ2UuIEluIGFkZGl0aW9uLCB0aGUgcHdtIHJlZ2lzdGVyDQogICAgPiAgID4gPiB1
c2FnZSBvZiB0aGUgNnRoIGdlbmVyYXRpb24gb2YgYXN0MjZ4eCBoYXMgZHJhc3RpYyBjaGFuZ2Uu
IFNvIHRoZXNlDQogICAgPiAgID4gPiBwYXRjaCBzZXJpYWxzIGFkZCB0aGUgbmV3IGFzcGVlZCBw
d20gZHJpdmVyIHRvIGZpeCB1cCB0aGUgcHJvYmxlbSBhYm92ZS4NCiAgICA+ICAgPiANCiAgICA+
ICAgPiBTb3JyeSBmb3Igbm90IHRha2luZyBhIGxvb2sgZWFybGllci4gV2VsbCBkb25lIG9uIG1h
a2luZyBpdCB0aGlzIGZhci4NCiAgICA+ICAgPiANCiAgICA+ICAgPiBUaGVyZSdzIGEgZmV3IHRo
aW5ncyB0aGF0IG5lZWQgdG8gYmUgYWRkcmVzc2VkIGJlZm9yZSBtZXJnaW5nIHRoaXMuDQogICAg
PiAgID4gDQogICAgPiAgID4gRmlyc3RseSwgdGhlIGJpbmRpbmdzIG5lZWQgZml4aW5nIHVwLiBJ
IHRoaW5rIHRoZXNlIHNob3VsZCBiZSB0aGUgb25lDQogICAgPiAgID4gZmlsZS4gVGhlIGRldmlj
ZSB0cmVlIGJpbmRpbmdzIGFyZSBzdXBwb3NlZCB0byBkZXNjcmliZSB0aGUgaGFyZHdhcmUsDQog
ICAgPiAgID4gYW5kIGl0IGRvZXNuJ3QgbWFrZSBzZW5zZSB0byBzZXBhcmF0ZSB0aGVtIG91dCBq
dXN0IGJlY2F1c2Ugd2UgcGxhbiBvbg0KICAgID4gICA+IHVzaW5nIHR3byBzdWJzeXN0ZW1zIHRv
IGltcGxlbWVudCB0aGUgZnVuY3Rpb25hbGl0eS4NCiAgICA+ICAgPiANCiAgICA+ICAgPiBSb2Is
IHBsZWFzZSBjaGltZSBpbiBpZiB5b3Ugd291bGQgcHJlZmVyIHNvbWV0aGluZyBkaWZmZXJlbnQu
DQoNCiAgICA+ICAgSSBwcmVmZXIgdG8gc2VlIGEgY29tbW9uIGJpbmRpbmcgZm9yIGZhbnMgd2hp
Y2ggSSBzYWlkIG11bHRpcGxlIHRpbWVzIA0KICAgID4gICBvbiB0aGlzIHNlcmllcy4gQXMgdGhl
IHNhbWUgdGhpbmcga2VlcHMgZ2V0dGluZyBwb3N0ZWQsIEkndmUgc3RvcHBlZCANCiAgICA+ICAg
bG9va2luZyBhdCB0aGlzIG9uZS4NCg0KU29ycnkgdG8gaGF2ZSBib3RoZXJlZCB5b3Ugc28gbWFu
eSB0aW1lcy4NCkFzIEkgbWVudGlvbiBpbiB2OToNCiJUaGlzIHBhdGNoIGRvZXNuJ3QgdXNlIHRv
IGJpbmRpbmcgdGhlIGZhbiBjb250cm9sIGgvdy4gSXQgaXMgdXNlZCB0byBiaW5kaW5nIHRoZSB0
d28gaW5kZXBlbmRlbnQgaC93IGJsb2Nrcy4NCk9uZSBpcyB1c2VkIHRvIHByb3ZpZGUgcHdtIG91
dHB1dCBhbmQgYW5vdGhlciBpcyB1c2VkIHRvIG1vbml0b3IgdGhlIHNwZWVkIG9mIHRoZSBpbnB1
dC4NCkl0IGlzIGRpZmZlcmVudCBmcm9tICJhc3BlZWQtcHdtLXRhY2hvLnR4dCIgYW5kICJucGNt
NzUwLXB3bS1mYW4udHh0IiB3aGljaCBvbmx5IGZvY3VzIG9uIGZhbiB1c2FnZS4NCkl0IGlzIG1v
cmUgbGlrZSB0aGUgImtvbnRyb24sc2wyOGNwbGQueWFtbCIgdGhlIGRldmljZSBpbmNsdWRlcyBh
IGZhbiBtb25pdG9yIGFuZCBQV00gb3V0cHV0IGRldmljZXMuIg0KTXkgcHVycG9zZSBpcyB0byBn
aXZlIG1vcmUgZmxleGliaWxpdHkgdG8gb3VyIGRyaXZlcnMgYW5kIGNhbiB1c2UgdGhlIGV4aXN0
aW5nIGRyaXZlciAicHdtLWZhbiIgdG8gY29udHJvbA0KdGhlIGZhbiBpbnN0ZWFkIG9mIGNyZWF0
aW5nIHRoZSBjb2RlIGxpa2UgWFhYLXB3bS1mYW4gdG8gZG8gdGhlIHNhbWUgdGhpbmcuDQoNClRo
YW5rcw0KDQpCZXN0IFJlZ2FyZHMsDQpCaWxseSBUc2FpDQoNCg0K
