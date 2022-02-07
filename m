Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0B64AB2FB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 01:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243108AbiBGAqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 19:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiBGAqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 19:46:21 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2113.outbound.protection.outlook.com [40.107.215.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DCFC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 16:46:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZgmtEGT6yq9lkoysPch3RncZs9JVJ6BKIQ5M9Sizv1bkXVJp2fz1QnUC/VbrHWQkcnUTHo/dvj4jaFIfLIS3mRKkMh1r28qvPyVYFQjm7yO4TYCCUazxhXvS34eQSdKwc4jWZxBnK/BeUf5KM8uJvyd6i/bZs5gWjJhnYpXBE8DE8RiL8MLOVlClUnDxf4kxDo+ssa6dyoS69XUcr9Ebv9/mZTN13MUC3wuXQ+mtXC6E3BI2x/O1KLzeb7FMFkAZP730vMr/87XGuicOjg/4PEO3Na8iXxf36I76Rr7AUwZ4U0abmvFYsYOyKvSrgrgsna+j1hYGyenlwZWCnbB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0HiiY0NUT4y/jktiNCLsdc+CR0WM2rM2jCQzdLYYk8=;
 b=E33JHsO4yKBIxMxrXArmBUXuklLE48t5kbmpBJP7WYkFpMPElOioPK5QMKii9ci3uAVdxbaAZKHzndfNwe8riT2bwwOvhEXkIkF47dT5jSsWJF9D+2AcKy2GnTSq+7XglzCMQgwvb97LCQ5k+pR97NAfTJAViYKKWHPYroK52Ay50lBBIwc44ZHzfqCpMWffLqXZdX7BaNZ70W9XqaZO84ENH9m32WOlQrbSQ2K0vfQU1s12sGdOVIkMiQupwcJj6mVbA0FANrjKd2/Ahp5pY4HmFobLFOr0rIDGSn0DdDQiXKuObo0/SR8UnCs06CugR56NvldtOPMwvp2Qf031Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0HiiY0NUT4y/jktiNCLsdc+CR0WM2rM2jCQzdLYYk8=;
 b=FplHf3IvUsbetQgP36cTZkEl7wW1XGBwohtOhWpSTvasnKI7mz1j/vo1v2oOHMKV7lHLE58hdzylNpfWxI+JXgoPGf23zf1VkDC1w2kQpkbh8cjt9+qWtUYIAssXHg3llELHU9VCtHbk/mzqxEZx30Weryc/4HqaAL4aT8TtSvYu1g7E0g9WGwYM5yoApjHSt6C5xDvN9K68BNaFrce6YnfCgsabDmno05qmKO5UNmQs0BPY+wkEoKTu2EVF2h2uNnUoT32LzpVWogGmZ0/Dzs81NHJZM6jFJmmmo6rnKO9OfIdHEYzexxVdrda4/YUFxau3IGMTkpb6a3rwAlNt/A==
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com (2603:1096:203:b8::10)
 by TY2PR06MB2480.apcprd06.prod.outlook.com (2603:1096:404:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 00:46:10 +0000
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::c4c2:84ad:81d1:e3e7]) by HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::c4c2:84ad:81d1:e3e7%4]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 00:46:10 +0000
From:   ChiaWei Wang <chiawei_wang@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH next] docs/ABI: testing: aspeed-uart-routing: Escape
 asterisk
Thread-Topic: [PATCH next] docs/ABI: testing: aspeed-uart-routing: Escape
 asterisk
Thread-Index: AQHYEMP87vsoGh3skEy6owUrpWsDuqx+UZkAgAkE6CA=
Date:   Mon, 7 Feb 2022 00:46:10 +0000
Message-ID: <HK0PR06MB3779C4484FDA6DE0190A834E912C9@HK0PR06MB3779.apcprd06.prod.outlook.com>
References: <20220124014351.9121-1-chiawei_wang@aspeedtech.com>
 <CACPK8XfzBT3YiMYqH5cKX5jWSSYx45vNzubdUpXOTnE1xy2TXQ@mail.gmail.com>
In-Reply-To: <CACPK8XfzBT3YiMYqH5cKX5jWSSYx45vNzubdUpXOTnE1xy2TXQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a718e29b-f93c-4a17-42c6-08d9e9d33bd8
x-ms-traffictypediagnostic: TY2PR06MB2480:EE_
x-microsoft-antispam-prvs: <TY2PR06MB2480670AEBD8EFC7B1E560E9912C9@TY2PR06MB2480.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I/q4SfV57j+drmcxssEO720refgiKy1RuyRc51Eu3UbJSuA+mz6Vtdsd1m7W2uECkbYw6WG1Gjrmp8sBqzzx0Zgv6/V27GJycY2dsSshSbJIt/Wxwi6x7FUCKHLnI1dlOMXKwhqQ+CcvM7DSo697a6kIoES+gJFBCALXH8o9s0R+qts8laPzWNpAU+AOv6gTSBCZQG274UJzdO6C3Z0RNxGSU0XA/JkuH1kUsKzO1MVJXNjDcjEHkf8PQK1hGI8c7QCQic99QbOJzrYM84Mtk3pckpCnGBla3g4aih80i0YW6S+4P3Z2bDYMGfScwV+i0yHKNcL+N+1Vq3Oy9zt/TMJ3AD7OvC+O9tGfDVhYmI5diWFGM44SAC/nVdXB7bmRWoN63gk2mq7T9RwUH2AMmiCCAX/YGVl6lAoY8B35vVKWh+fjanPv99eukFMXhg2F7or9wq5fp6QM+U4caskjQYvwHE6LMcXsD/51QO0E6GGdGhId1J4KuRhg9iA6ckcwhInIuO+/+TbTIouNGXU9xpy6ZdZWOnPXCmZJ1ShkcL6LUBP3FxHSlfVKT8T5xJOd+Cnq2UVYe+byr5TJUr2rF7VK+jItxNuN+cm0DHzFAPhL0ghk9EpK/gNh8yaY7hLn74E6beSlzxkbvVGFOnhqcIcRFX4F/7tQ1st0dwUqFlI5k/xcormS01ScmLUAHH63+zNxv7bIQQyt4rn79JHr1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3779.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(346002)(396003)(136003)(376002)(366004)(55016003)(66476007)(66556008)(86362001)(508600001)(38070700005)(71200400001)(6506007)(7696005)(9686003)(83380400001)(33656002)(26005)(186003)(4326008)(54906003)(6916009)(5660300002)(316002)(76116006)(66946007)(66446008)(38100700002)(4744005)(122000001)(52536014)(64756008)(2906002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWRpSUMyVUpwVjhnMnVhL21ua2tQUHdidHh2TGdmL2w0UnBHY3RhUk5zV1Z6?=
 =?utf-8?B?U1UxSWJUQy92Vk9pZ0RRTVZFZDNVdHFFT0R3QXFlZDVjMUMxTVBDSldCenRG?=
 =?utf-8?B?cXpqVlhaNStwVXJyME1CR0NKTWdQbENzam5PRmJZM3UrcXEwaTgycVVrcE5z?=
 =?utf-8?B?c0pCNEJQRjU4WjEvQWxJYW00dFhrU01QNEJ4Y0JFVWdZckdPQTF0L0ZrN0xy?=
 =?utf-8?B?NE5FbThla2gvRVBWNUZHUWJ5YlBoTHJHdjRPV1MyUHdBcnE5LzlMdnRYdlBn?=
 =?utf-8?B?S2VyS1lkMkw0dWJyN2FKNjhJeUhWMk5uQWJrYXBBK0d1VHJXUWdKdGFKKzNv?=
 =?utf-8?B?OEpkMEFwcHRGbXhUZDRJd0UxcFdrL2dPaFI1Qk5BYUlkQkZZU0E2Q0ErSFVr?=
 =?utf-8?B?aWtuL1czdXBmYTNYczdIUWxhdkR1VFhOSnlGeDdjaW5tYmUvNWoySWl0SHYr?=
 =?utf-8?B?c1FRMC9zdGpNVTZNbzg4SGpSbld2clpYQWZlVDJqY2gzZUhxeVJNaEZPRExG?=
 =?utf-8?B?WGtJMUcxQjFhMld1anJiU0Z6R09xMUNXQUJEaU5ieE1MbitMRmJqSXF0ZnY2?=
 =?utf-8?B?ZmNiSklsaGVaTkk1cGxxQnBHNWk0VDVZMEdjWkpxZjlSNmFIblJuOEExc3Rv?=
 =?utf-8?B?alZpOTVzWWgzTExReUV2UmZnZE9kM2tQeGE1VGRULzVvVlBiY2VWQ0QrWjF2?=
 =?utf-8?B?eTR4UmEzYmExMjNyWnBtQXExK0FhOStNTDV2R0MyVkN1SDdRc3QrQ2lHK2RT?=
 =?utf-8?B?ZzVxbGtXc1pUbWlyalJVRVRvaXI4ZEhqNlJGdlJkd3o0WlY3dTAwL0c2ejc0?=
 =?utf-8?B?SjdtVzdQQkFMYUJUYXh5c05COGtXeC9MeGRQd29acGdwWmZoTnJSU0pyK1My?=
 =?utf-8?B?ZjRFS1A5Zkx3YnpBU3lRblFINVdGV1NHSksxeEJRL1Y1cU1aWGxtb3BmUGF6?=
 =?utf-8?B?VlNpampzQ25TQnVKTWJGREZ4akY3SGF4TnBuZUFHVDI1bU5UQzVKbWo3Nkhv?=
 =?utf-8?B?NUZvSEtpdDJCQXJ4cFpnY1ZvQ21XR2dkaVU3bjNQRVBpd1FnSjQ2VSthM05Z?=
 =?utf-8?B?c0R2cEVVYkwwMlRWZzloOERES2lOeEFYaW4zRG5yeTY3bExDang2eS9oUnl0?=
 =?utf-8?B?ZGlreXJNdDZFdFp3dWZlRVJwc0V3amcydld2bWRPVWd4L29laTRXUFltWjdF?=
 =?utf-8?B?S1ZNYkYrOFBGTy94RWJ2RFhla1llV1RSaDluemx1aW4xbEZHZi9Ia25rbC80?=
 =?utf-8?B?REh3T2xhSHRydG1ZNUJJY1R5blEvRVJTeEtaZmthVlFSeWNiMjdlMjhwQ0Vv?=
 =?utf-8?B?Wk1LazhVbnZ5ay9vZDlReGxhaWtFSHI1SVdad01uY2xXaEtVeW5xZ24vOEQv?=
 =?utf-8?B?WDRxK3Q1SkJQT0hNMkxDbWswTXpXVmdHc3BIM2FET25pcGxlVUNHN0JrUHo0?=
 =?utf-8?B?Vk9pcENISHJJV2ZiUHZqQ2VSa1VKQnNqT05mT2tlK2NNUVZlZ1FHRktjNW4r?=
 =?utf-8?B?VkJ4czlIdW5lUHZPOW1ENlBjbVhpYkR5UVNLbkNSQlh3ck83bGFPa1hXWjhB?=
 =?utf-8?B?eDJPTVJWVkFGdXM3QnVaRjRuY05BdmI5U1phcGFPZkV5WG9HQ2Y0VVFNb1l1?=
 =?utf-8?B?SnZxT3JiMXZTdkZXOHlQUGJXWCtlYVhuTmVQYncwWFhIaG96UCswSjk2a0xm?=
 =?utf-8?B?emNsekpDNm1yam9FL2IzOVV0TnZGY2hnWkJlVWFKOEd4RTNtalVRMDRLL05L?=
 =?utf-8?B?QzhGYjlpVmJ3NG1XalZaUTZWbjZUTUVSdUlvcDZJYThmTmNhbUJkbmRlRW5j?=
 =?utf-8?B?VllZSXIzenQ2N05vSENrb0dMNE9SRVZ5cXNieVJrYTcyemk3a1NzdW5MSmlD?=
 =?utf-8?B?VU1lR1MyQ0JSVmdOb2Q5QkEyK3JCcWlQWGVhRnFLNGNoL0RCS21CamlEY2Ez?=
 =?utf-8?B?VkdNcXIxQVM1b0E2QU1rSExNajBLaVNvbjIwTWZsVlY0c3p5NFRIdFYyT1ha?=
 =?utf-8?B?Z1FiU0FGdzJ2Q3YrZHJlTGdsRGZmOUh0aExMNkdWOHRYdVZvMjRRblp5YkFm?=
 =?utf-8?B?RmhOU0NoRDYzNjJ3NXp2MFNURFJkZHUzSTFtS1RlaFRKbU13Q1JER3RtdWsz?=
 =?utf-8?B?c0h3bTFPQXFwazJmSkk0S1ViL1FOTHo5R3VzckRNdENrNnMzQmhCKzQycWI2?=
 =?utf-8?B?RHNnUlBFK29KbjA4b2RydHRHYlRRWnpLM2t4a2lJRDR4WCtOSlFsRGE2N1Q4?=
 =?utf-8?B?N24ycGxIZ0VkbWFUOWZMR2ZpUXdBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3779.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a718e29b-f93c-4a17-42c6-08d9e9d33bd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 00:46:10.0410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+ZWZKvEv6n29r6Ht33TQfAZOSZJvL/2km96XnBXkDH1k2zM0l5I/mQHJIGN8LtjrvIiTsli98Q+o7yfMrkb10Tl5Gkg5VbMAvYiKVAXZns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2480
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KPiBTZW50OiBUdWVzZGF5LCBG
ZWJydWFyeSAxLCAyMDIyIDM6MDIgUE0NCj4gDQo+IE9uIE1vbiwgMjQgSmFuIDIwMjIgYXQgMDE6
NDQsIENoaWEtV2VpIFdhbmcNCj4gPGNoaWF3ZWlfd2FuZ0Bhc3BlZWR0ZWNoLmNvbT4gd3JvdGU6
DQo+ID4NCj4gPiBFc2NhcGUgYXN0ZXJpc2sgc3ltYm9scyB0byBmaXggdGhlIGZvbGxvd2luZyB3
YXJuaW5nOg0KPiA+DQo+ID4gIldBUk5JTkc6IElubGluZSBlbXBoYXNpcyBzdGFydC1zdHJpbmcg
d2l0aG91dCBlbmQtc3RyaW5nIg0KPiA+DQo+ID4gRml4ZXM6IGM2ODA3OTcwYzNiYyAoInNvYzog
YXNwZWVkOiBBZGQgVUFSVCByb3V0aW5nIHN1cHBvcnQiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IENo
aWEtV2VpIFdhbmcgPGNoaWF3ZWlfd2FuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gDQo+IFRoYW5rcyBD
aGFpLVdlaSwgSSd2ZSBzZW50IHRoaXMgdG8gdGhlIHNvYyBtYWludGFpbmVycyB0byBhcHBseSBh
cyBhIGZpeC4NCg0KVGhhbmtzIGZvciBoZWxwaW5nIG9uIHRoaXMhDQoNClJlZ2FyZHMsDQpDaGlh
d2VpDQo=
