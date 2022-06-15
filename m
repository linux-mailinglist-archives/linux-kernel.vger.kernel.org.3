Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF5B54C3D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344207AbiFOIod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346856AbiFOInt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:43:49 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2072.outbound.protection.outlook.com [40.107.114.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E213443E6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzcSbD98KNJbtB0y1Z/AGKQHVDg7094Lvg5WKaYMcd0iWME2SgknwcQIDNJn1FkmgHP3TA7PvcCVWg2gl6LDhKrny3qsrVHhViZCxr6naPcMukwXEDVdFX8TN1F5/qGZNYUt97OJHq0lBLZJv5ZuOUYL4voNW111gsAAoXa4/3oLE666l9ueChNYkvGYazGfWCuCuiAb+nkLbYfj/jkeUosZubh7pXaAZMYVtrENktf9eCPI2u++61hMzvmiAFk0y5sOHEPCwR27hpit9v9GAuTgxcXDs76ZrzqbUg5bUBsZ3o27qNynZVc5SEaI33lR5c7t0X5qGWqMI/mc9/x/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANmrsr4cs9gk/q2pyaP/wuixRhzDLwkfqyWXOfgcKvE=;
 b=MdlGYTulRXYJzqKcUUYdtDg2pb9hKmVCvp2YeVK0RXy4VEoD2WdcL1YefdmPHA3k4c8MLwmj2s+Ps4Wq8nrmFfgYKZ2BAH2Gho1wIMzByybzMyM1pkOIq5VhWzJEq8VWQ4inTHVye9JHYsZP9C1guCVJfG/v0vZP1ZuVplxSEcx46Pcgw7fp0JVwEPeG/M3DEiMcCp33IR2J9OyiwzSTdWxbyeL2JwaCITpsqwmuovqVUv8XkeFtPEblooy5yvi2Fy7LtE4VX8F0zdwDhIcgclY/R+1gUiyrzEX/VtFlfZm5dQNtGT9/RhpFVzy/hXg5V+tzIvdLh+MltScOjlXY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANmrsr4cs9gk/q2pyaP/wuixRhzDLwkfqyWXOfgcKvE=;
 b=bCp1R2OkVztqchKgmYwB+dq1lyfAPE8+XfIQbKyoQl1JgJSWDtXbW76w/bbJMnBeyBlIcDCt3ESrV0fgA2ek2YJgP7x2BoInZqhVMmDR1rSagFclLynH3doZhytJlBfyc9FEQKRwNiXjUxC2ZMz8A6C9kLCTWnTi6LXWQ6+wTao=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB3847.jpnprd01.prod.outlook.com (2603:1096:604:48::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 15 Jun
 2022 08:43:46 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::b00f:b11:37c6:29d0]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::b00f:b11:37c6:29d0%4]) with mapi id 15.20.5332.023; Wed, 15 Jun 2022
 08:43:45 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     David Hildenbrand <david@redhat.com>
CC:     zhenwei pi <pizhenwei@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/1] mm/memory-failure: disable unpoison once hw error
 happens
Thread-Topic: [PATCH v5 1/1] mm/memory-failure: disable unpoison once hw error
 happens
Thread-Index: AQHYgFxZplLfJ1ijo0OLciOaJo4Kla1QH2OAgAABn4CAAAZRgA==
Date:   Wed, 15 Jun 2022 08:43:45 +0000
Message-ID: <20220615084345.GA1666389@hori.linux.bs1.fc.nec.co.jp>
References: <20220615020005.246295-1-pizhenwei@bytedance.com>
 <20220615020005.246295-2-pizhenwei@bytedance.com>
 <20220615081521.GB1663556@hori.linux.bs1.fc.nec.co.jp>
 <425e44e9-6ec3-9a87-3441-78881f561a06@redhat.com>
In-Reply-To: <425e44e9-6ec3-9a87-3441-78881f561a06@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df6419c9-f840-4c7c-af01-08da4eab28e2
x-ms-traffictypediagnostic: OSBPR01MB3847:EE_
x-microsoft-antispam-prvs: <OSBPR01MB384737E75657F0D3A1B4ED27E7AD9@OSBPR01MB3847.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QyzOLy1yRBi7BP5kgxV5qsGCAiw4OaB2J43I6ovPLhxhaFDh05BL34rz5URIJPeGpB0sva5/naaKkieSfWobtFazmJloY47z5gmjRaOV28/jVhx8VKAss7z+2awZ2dkQX7Yx12AVeWNpTD5RQnVnWe5sktXisXHICxAu98QJBdKBuxQ+gabq6uHbuHHP2XXcTZZnrC731qLpz5GxcZ8XVV6g2vkD2+xsZsHzPKwlojeNsyhbABsaYbdO6Aamfxd6A6xlKTbzVtk4HnbYNSYTVCS3542jc/ke2W0sqPGYMB4bilpUh48Z9I9OTYy58lCHDyhCsIRf7p61/E5VnZOOwbd5snKYnT176erzz2DECT8any+KB/GUE04BqlWRzaOVBDq18vhBDC+4rQebpw8f6kcOTWDq4V8/T+M8nl/X6S5lcR54CjIGNYv6oG0VHIcrpg5PB3hIsA/bAglzXrUK2BxcelO0rzZ7AODnRZVMvR3IqG9A4aGOFhXdh3or5sfvF0HSUiLmy2hfeX73DGD+2MNjYU6qQZWt6z/koxnyzaeqAPZKcsIiI/YW8pF0+oj7uH4MAZpblEQC0MYE1ag/P5tdiBCvDklHv7CW6Jpo/7HplBwHxEtE/NtqLjKCZKn4jDjTIjosUbEDppzqi2mJjn25SacT2KUn9xpkBpdYD2uihKfc67L3l8flLjGWb1zs24qsJaLwGbvgBme5ENYUXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(8936002)(316002)(186003)(66476007)(38070700005)(4326008)(33656002)(508600001)(1076003)(71200400001)(5660300002)(2906002)(85182001)(6506007)(86362001)(76116006)(54906003)(66946007)(83380400001)(55236004)(26005)(6486002)(82960400001)(122000001)(38100700002)(8676002)(9686003)(53546011)(66556008)(6512007)(64756008)(6916009)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGhWaERpUEFDMENVeEc3TFRiRklxWWRUOEtZa0hBZEROYUFQU3EyUzdsZENJ?=
 =?utf-8?B?YVk5Y01YWFRvS3VXMGo0RnlEVkNuVjc3VklhTEtuVXNFZ0JwVEVuNStaTllo?=
 =?utf-8?B?c2VHanVtTGpySkdwd212T1VUdnk1UHNURHNkckgrbkxUNVQ1a0RkUGpKbVZs?=
 =?utf-8?B?bFJ0dm5od3FrTjB3L2w1cW5vdTJJeERTTUNncGN6TWhqY0plTEdmS3RYdU9a?=
 =?utf-8?B?RWtrTFM0ZjVubjl0dUM0K29PYVUrYUtsazhPRFdFcUg3YnVZcjdmU3hjcDZ3?=
 =?utf-8?B?TEVoRDFNRkZvL3diSGpjdWIyNFZwTjlCWjAxU1RVRVNtUzZGQW5xUUE3Y3Zz?=
 =?utf-8?B?THJQUzBnMThwWWUyamROc28yNDBQeTRmWDRJMFU5ZDJVZ1NHN1A4MkNtY0tZ?=
 =?utf-8?B?aUlteTRuNDhTMXFBQW1WbmdpZDYvaFFQMld0NFVGUldkMWtmMTRsVTFvajJS?=
 =?utf-8?B?a1ZVTE9Bd09DeU92REE5RVJ3SXgzU1ZEQXFhYkM5TUk4K0M2dHRrZGh5N0Ja?=
 =?utf-8?B?UzllamdpWUROaGRadEpZWVNmZ0FYTDFEM2ZyRllURXBodmpXMFo5cTUrK2VO?=
 =?utf-8?B?aXhsakczL2pkVHI0anFQV3gyQ2dIMjNHcDBNN0RudTlXZGtjWUF1c1VVNkVB?=
 =?utf-8?B?VHZYMSt0SHQ1RXE3Q0tSVDVkVHZJc2dJdGpFNWptbUZ1NzQ0SzNOT3FvT254?=
 =?utf-8?B?eG9qQk5CbWpJMnBWdzJ2dFpSVE5PWlBmaUc4anZRMTRtVExidVVJeDVENnow?=
 =?utf-8?B?UGRKZVdXZmhwRHJZQW5rQytsclhTMG95SzJ5YnFxZi9vTTdHdFBQNWhxQlhS?=
 =?utf-8?B?bXh4aUpLOGNpUDdyQTBCZFlEOTZ6clNtbU5qWC83RFlGY2xwWnBuWDltcE53?=
 =?utf-8?B?V3N6V2ZTSXd4MDlibG1FTTR5a2U4VnN4ZndSNzNOYmZsVlBjYUI3VTNRSkdW?=
 =?utf-8?B?MzRvT1JEWm55RUNNL1dySGFMT0wzaWtoMmVPT1ViY2t1eld0R3R4VUVEckVq?=
 =?utf-8?B?SHovNzFmcCt3b2RVNWpUTlp0YXVOajJmamJoakozMWYwazV3WTFwbGRjRDlG?=
 =?utf-8?B?LzNscUc2QTF4NEZMTytRM0dGS09uNXBiRkpWUWNKUFlMT0t0eU12Ym5BaXdl?=
 =?utf-8?B?d3krek1xbWJRWklxWmRWNm42d0hXdlNNSzNzMzdqRCswWDBiT1BQM1VObWw5?=
 =?utf-8?B?d004bXh3eXp2ZTkwd1grV2RHZmdQZkFTTUFsb2FxaDJSZ1JUZndMYm1UcWhB?=
 =?utf-8?B?cnhrRm1DNEMwTXNiQWt0ZENpN2lhZS9PeUt5TGYvVllyT2NNTkhnMmJGMEt5?=
 =?utf-8?B?OVJxOUJsQ0RRUGxGSXBGcm8xT1pFTHNpdW1QVTN0UWs4RWhteUptMGlOSkln?=
 =?utf-8?B?NlpJOFlOWGppb2V4YmVyYkRRdDBKbFF5dUpzQzEvaFVQN3FWbnVZbWJENC84?=
 =?utf-8?B?OWpwMCtZSWlEOCtHazNpVkpGSFdRbG90S0lKT1BSVEd6YXhmMXlaZnAydExF?=
 =?utf-8?B?RHQyaEJNejBYbk04WnpEUjV0T3p6VHFERkJVTmF4dWFUUENsbTcveHV2Ti9V?=
 =?utf-8?B?NWRQTWhoS2RkU3hNZUIrUzBlZUZnOWxLYlMyRlZEOG15ck1oNzA1YmhnUG92?=
 =?utf-8?B?RTl0cVZieURnOXQyN1lYVjRxZDgzeXpQVmoycUdQb2IvMDNxdWdFdzFBamx3?=
 =?utf-8?B?Rk8rd0wwRlQzOC9PdHkyWTZ0YTMraVJReEN6eWtGSzRWdGVIS3JJSTdrcWFw?=
 =?utf-8?B?TnIzK29pZW1yT2x5bU9iL2ZNM3F4dmk1OWNQV3NGNWF0Vi9URGY0cWhPU1J1?=
 =?utf-8?B?YnJFT2lMVWNmQmQ0R3FTZHJKVmZtNll4Z1RYNmFXOVA3ZUF3aW9sc1hTUnVQ?=
 =?utf-8?B?TmdWNE5KYjhubzJIbjhTV3B0V1JsTTQ0Z0wzaHlINEpLMXdpaE1Na25HWlE0?=
 =?utf-8?B?MlFzQWhWdHhuVVkwd2d4cGhUbmlaWDhlV05MYlBtNXVsSkZOczd5WXZVWGxE?=
 =?utf-8?B?dk1tM1hDSXplQnRLeEJyekp3a2ZFWktmZlgwOWFaK2ZndiswclN5MzQ1T1pM?=
 =?utf-8?B?SE5PcU5pOE5pd056bzkvb3N0eVhIQ2J1bGg2VUhldEh1SFBxeFhkc1JtNCth?=
 =?utf-8?B?YThvaklNdFFTSFpMQzVuMVVUYzBIYkhTZ2FsaXVRNC90WGdMRTNCMWRGMG81?=
 =?utf-8?B?ODJ1RVY4TW41WXhpTWNYSUtVc3pNOWhsandiK3NkSzArY3J3MTVxYlVoR0kz?=
 =?utf-8?B?QkJjelJTb2Q3SXUzSzVjb1F5cURjam5Pd3hGMWkrb1ExMzQrdVcwZVZCZnp1?=
 =?utf-8?B?VXd0bk9EMzR6aGJxV1NkS1JRNGRBT2JKNm1rVDdyS3lkV0hlWkdOdEZvcE95?=
 =?utf-8?Q?8nyViTNBXegItE14=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <976DD23A5EDF034E8CC2045A4E5F87FD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6419c9-f840-4c7c-af01-08da4eab28e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 08:43:45.8175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yeaXBVPURtdZMlWeqxWPS0e9CpjWxpjY1xtp0vAZDGF/BrxMZdXAgZCbnbnx4dW/PqhJ9bLKfuyEIDt9LOK9LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3847
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdW4gMTUsIDIwMjIgYXQgMTA6MjE6MDlBTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6DQo+IE9uIDE1LjA2LjIyIDEwOjE1LCBIT1JJR1VDSEkgTkFPWUEo5aCA5Y+jIOeb
tOS5nykgd3JvdGU6DQo+ID4gT24gV2VkLCBKdW4gMTUsIDIwMjIgYXQgMTA6MDA6MDVBTSArMDgw
MCwgemhlbndlaSBwaSB3cm90ZToNCi4uLg0KPiA+IA0KPiA+IC4uLg0KPiA+IA0KPiA+PiBkaWZm
IC0tZ2l0IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gPj4g
aW5kZXggYjg1NjYxY2JkYzRhLi4zODViNWU5OWJmYzEgMTAwNjQ0DQo+ID4+IC0tLSBhL21tL21l
bW9yeS1mYWlsdXJlLmMNCj4gPj4gKysrIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+PiBAQCAt
NjksNiArNjksOCBAQCBpbnQgc3lzY3RsX21lbW9yeV9mYWlsdXJlX3JlY292ZXJ5IF9fcmVhZF9t
b3N0bHkgPSAxOw0KPiA+PiAgDQo+ID4+ICBhdG9taWNfbG9uZ190IG51bV9wb2lzb25lZF9wYWdl
cyBfX3JlYWRfbW9zdGx5ID0gQVRPTUlDX0xPTkdfSU5JVCgwKTsNCj4gPj4gIA0KPiA+PiArc3Rh
dGljIGJvb2wgaHdfbWVtb3J5X2ZhaWx1cmU7DQo+ID4gDQo+ID4gQ291bGQgeW91IHNldCB0aGUg
aW5pdGlhbCB2YWx1ZSBleHBsaWNpdGx5PyAgVXNpbmcgYSBkZWZhdWx0IHZhbHVlIGlzIGdvb2Qs
DQo+ID4gYnV0IGRvaW5nIGFzIHRoZSBzdXJyb3VuZGluZyBjb2RlIGRvIGlzIGJldHRlciBmb3Ig
Y29uc2lzdGVuY3kuICBBbmQgdGhpcw0KPiA+IHZhcmlhYmxlIGNhbiBiZSB1cGRhdGVkIG9ubHkg
b25jZSwgc28gYWRkaW5nIF9fcmVhZF9tb3N0bHkgbWFjcm8gaXMgYWxzbyBmaW5lLg0KPiANCj4g
Tm8gc3Ryb25nIG9waW5pb24uIF9fcmVhZF9tb3N0bHkgbWFrZXMgc2Vuc2UsIGJ1dCBJIGFzc3Vt
ZSB3ZSBkb24ndA0KPiByZWFsbHkgY2FyZSBhYm91dCBwZXJmb3JtYW5jZSB0aGF0IG11Y2ggd2hl
biBkZWFsaW5nIHdpdGggSFcgZXJyb3JzLg0KDQpUaGF0J3MgcmlnaHQsIG1tL21lbW9yeS1mYWls
dXJlLmMgc2hvdWxkIGJlIG1vc3RseSBwZXJmb3JtYW5jZSBpbnNlbnNpdGl2ZS4NCg0KLSBOYW95
YSBIb3JpZ3VjaGk=
