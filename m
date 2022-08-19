Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA7E59956F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346437AbiHSGrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHSGrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:47:21 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2066.outbound.protection.outlook.com [40.107.114.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D90DC5EB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8akuCBzdLQt29tOrn9nFJcZ9rkDBL6NdEqGcUYz8VECGfPQDt6wxOq1TiRgXXAfCGmHze9eJuq31q18JdOFIt4LGgChESGU9UVPfD0ks2LdXuMPMgqZnAM+bJUEllCeX4vYBQzihf5UoH9E809odEXSz4fnUXKrFIvN6FvO7MWrjXJkG4MwQxoL1CeaN1SfXPps1nTZyT4vFNVrRv0JsjdRUT3DMuJSbN0X0qbzfg9jP2jecOCexW9Brnvz5+DGE1/+uiPOp85J6osbIF01A1SGbJch8f6hnV4b69/F8Oa8xQkrVp4ibuZTpo7Eg3S590QgvYl16EUiVg9QuZwpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2wVTJh3CKgrSIKwFZQBWvKoUn93aNjifsyR3HfqQaY=;
 b=a56DxDg8Pp70qgdAV/2oOaoe2R7EnOKc9rB9ltepjT+2dN3I484Eet7cAubihjU6J8HMeA5wQRqXWq17bUmPw38DEW7jYqKO1q9mc1m7AWPqazgFpou3VihhjLYY9iH4Wq3h0Eub5ECgf5BR70I+VIDCMZZS/BI0XhVVOPAjxM5OS3hfEZqMC3kj7HRH6WWuzGrNFp5bjldfQghtcO5LY6r9EXf6yLo6Zgx38fpi4Ip8P4Vuo8s6I0apXyCr68w9Yb1r3DwfAp/JQx6GhsyK9f/rxzkmsW74KgHyynjZmRexJJ62fUh3SeihGmpmmk9raLIhG7ueLuJ9s+woj5lr9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2wVTJh3CKgrSIKwFZQBWvKoUn93aNjifsyR3HfqQaY=;
 b=V2C6UcWouFY4WC0CDbf1xY9mDXwU/JF1aGwSE3/32rwBltB5q379tAkSRbQj3VzfEI4Gv9MCa6Zou6gtU3nk7Kan8+b0+PmbwSf9j2CrExM/c/PRuj2Weij+sNMYUEyMyK5ZmKJFoUZpRF5SMIyALZNNqAkYKfiADw81zyJ3jlI=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB4932.jpnprd01.prod.outlook.com (2603:1096:604:69::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 06:47:17 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 06:47:17 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: memory-failure: kill soft_offline_free_page()
Thread-Topic: [PATCH 1/2] mm: memory-failure: kill soft_offline_free_page()
Thread-Index: AQHYs3vIj8fXIJXOH028oQcJchY2Wa21yBIA
Date:   Fri, 19 Aug 2022 06:47:16 +0000
Message-ID: <20220819064716.GG613144@hori.linux.bs1.fc.nec.co.jp>
References: <20220819033402.156519-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20220819033402.156519-1-wangkefeng.wang@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2279e1e-6785-42e4-fa4c-08da81aea809
x-ms-traffictypediagnostic: OSAPR01MB4932:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1IIHd/zs/HB0gm2HZJl+4HPcB/dqcdXwVT74+2NS6oNKRXVdt4VGTjp884Xu4Iw3W8WCTXVvLfDAN45cSoHDcy4SkAQeUNkqDofnKJbXVhBbTP6QGce1gBUhkJbtEHylWBVlSSuc8+idfgA0RcvG5s8n3eeRolIXo6Iu13iOy4m7hOAD9wetZ234/vwlb92rFABDRPBm8MxvItDXcehnggQsLpmEe5ZK17l8YrZdUf05d/9dGHdy6HaLA3oToru7ACh54Vt8O1+/3bC4t4tOAJBvGwubyUoN1w72/K41ADzqZcjTUHIzlpWjFU/E0Fd1vGBFUE6dQn2OG94BqkbXbU779+XGj0yaYoUBEPyCykvevs6rYOSSG87Q+7I1EVbrDYOS0mO6SQ7DLEijvjlKIewd7DpvvoYBN7wnSxBKauHX5B+mSzRoQntpckbbRYgLGKwUgToit3wtr43DcMKWOtuRWoTRAhKbvVve9EjcSoZgGQegcCxkKVFmwn981Yki0HdSmA7KcOsVY93J1TEI5omW4Om0tw293flBNdCSoOudLW56RPuVJxY55E6bAIKZMLztp+6QLK1astF0jP7yrc4LO9beUQLPORUfLhlUzAKSu7UXhpRBIop3nhK5eAUaHBahWDc+Fdp2fH6IwjwDLfHWw+YsAkoDiQPdQlI2q7SRYg53aZywPKx/GTNGCG7Gto/lzNDn6sm+fj2grgu9y4wOgazZsgkQwsssjpdrKvDX/2pXaUI0TZ83DDwyOLm7p9Twl3LrrrXKwIYf8u5M1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(8676002)(9686003)(478600001)(6486002)(64756008)(66446008)(66946007)(66476007)(86362001)(71200400001)(6512007)(76116006)(66556008)(26005)(33656002)(1076003)(83380400001)(82960400001)(55236004)(6506007)(122000001)(4326008)(41300700001)(38070700005)(316002)(8936002)(2906002)(186003)(54906003)(5660300002)(6916009)(38100700002)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUZid1VjYk9ZMXNPTFFzY0tnWS9xWGpiZ2xjb3RNRUM2TnVKTHFoa3hJaHpW?=
 =?utf-8?B?eU9PMkVhSVRkWGwzamJXdHVoa0NvSjEyWE1wWnJlem94eUo3VERuZEFwWFVT?=
 =?utf-8?B?T25nNWxBeUlHQk9DbmFvV2RwNmhWL2VxVHFvbmFhbUtTWG1NbVN4eFV4dU9i?=
 =?utf-8?B?cjUzMWwvd1Ezdmg2eTFKT0s3dEJ5ZzRRUDBrb043VHpXQm85WXY5K1BlaDVK?=
 =?utf-8?B?b1NRdFVUY3dNVDliK0Z0OG1Vc3hWVVBxWXhBdEVaOVBOQkhoZTg4aVJoOXpi?=
 =?utf-8?B?THN6ZHlLbHBMLzlna3ZnRzFGTmZXcUZZVjFuZWpNL2Z4d2VEL2F2blBuSUky?=
 =?utf-8?B?MC9HUmZwTll1b05hOUViRG5VSmN5dG0wYThVK3FiT2xFSlVuYmNoU3dGc0ZW?=
 =?utf-8?B?M1BoYkpBY0J3L082QW9mRWdFWS9YVytHYmY2dHl4UVFweEZkMVhkWnp1R0o0?=
 =?utf-8?B?VlpXdUF3ZEl2eng4VGE4NVVRUEcySS9WWGpRNW5jbmcxUXVYdmZ4bDJmcFpi?=
 =?utf-8?B?TzJ0NjNsUEMzUmh0T3ZnV3JZeU1iMzhNVzdnbFNkK1dvVTF1Z0xpT3BuWFJT?=
 =?utf-8?B?RmUxajRDUkZZSjQyckc5TjYvTlV2VTVQOCtEV01YaDlNc1NtdG9QYThZVytH?=
 =?utf-8?B?WjhVQzJBdUt3SnNaZmY3dW5wdEJWQjc4QnJmNEdjT0JYZnNzNG1hcjdscVVy?=
 =?utf-8?B?UG9mT0NBTDZIOCtZbnJWVXo4RVNPaXFTWlc3NmtEbVEyTk9NbVU2aXZERlJz?=
 =?utf-8?B?T1MwYkJ6KzdLZVRRNHpuNUFwYWFnWHFjOGpZS2o4cHNhMlZBNjJpWkNZaDdt?=
 =?utf-8?B?cUhsam5IUE5DN3FqZ2RjVFNXRktBVW9GUjFrL2FhcFgxdjZ4NHM5ZnIzOTAx?=
 =?utf-8?B?V243SmtaN3BWdGFEdmF6Yjd5R2hoWWNGdDU2cnhsUTFYb3lFMkNxN0c2b1RT?=
 =?utf-8?B?eUhsdlpKSFkyNHZVb3FLMmtmQU41VkYySkNJb3JqMG9FcEJZU1lRMDJaRUR6?=
 =?utf-8?B?b0hlOW1MS0lVWlgrWGc3a1RYUGtzZENNdldnV2M2NjRIdG53Sk5KMmtUT1Qz?=
 =?utf-8?B?clZObDVTNlAyN2hSanpGN241dWM5cGxKc29CMklCMStIME40cFJML1h1VThr?=
 =?utf-8?B?Nys2Z0cvNzZhbzNMSmNSYnBmR2loSlF2K09IakkwaTN6NFl5Q0F4eXZHL3JO?=
 =?utf-8?B?S0VnWUhsZVphZGNJeGNTb1p3U2UwdVpuYWY5R0drZlpnaFBsaExIQ0VyODcz?=
 =?utf-8?B?b0pwWU5oY3FCYm9vSVNRbVlzRVFDTXpaRmNBS2d2OFBZVlR1TCsyRUlncVB3?=
 =?utf-8?B?cExSSW1xbHI5cTBxNDdjRmZmWEFCanpIQWZBeEo0MmlnTXg0NUpzNVNrT2VC?=
 =?utf-8?B?NXpEYTdORW5xYWhhME5tSmI0WTl3cUd1Sm5CQmlNRmF2RmpiWFFFTDFYOHh2?=
 =?utf-8?B?SWhKcldtRFVRL2o2SVJGeCtMTU1ZSTI0ZURzYmF4YksxQVNySmF5ekkvWnkw?=
 =?utf-8?B?Wng5cGx6WmJzT0g0RUEyWXNTWlV6UTBueG43UWgxcVU1ekhwbUcrS25CUFB5?=
 =?utf-8?B?UEVkVFZJMThzV3VyL3BGTVU1c0V6blQrVjlrV0ZNSyt6cmhtajdWK2RWd25P?=
 =?utf-8?B?RFpJZFVUYU5WVG9zMFRNMnhqSXM3eFRFdmFZTEx0NDJzSzdkbjRzWmg0YVAx?=
 =?utf-8?B?VndaYVpZOGU0Wng0Y0ZhMHJMdEpVaE5mS0t2UnNCaS9xTlpmaFlURUE4VkUx?=
 =?utf-8?B?YXJZUlh4RGlBV0IwNVVva1IrRkFDRW9sQzE3d3VjMXJiMUhjcEtqOWViUi9P?=
 =?utf-8?B?VmJkd2V0MFV0ejl1YzNxZUNaak1XanNjcWdBWlJOZzlMdDVUM1dUa1lPeWl1?=
 =?utf-8?B?bHdVbnREeG9aRldydVlNOGRSRm9TZzRjNHN6QWtwTGFQaHdPMGdXaHVrNDl2?=
 =?utf-8?B?RGNhak1ISmF4T0JEbFpRVXhqanRLZnhDMktRUkpwMTZCdjQxU2Q1NXFDamVJ?=
 =?utf-8?B?Y0srMVBhb2VpQXBxNHNoM1lFeXA3UXRsYnVmKzArM0JTM0Y2aUV1WHd1MDZy?=
 =?utf-8?B?TmhxMTNxUERWa3h6Q3ZLTlZENTZoSytkWTRoUjI0OHZ5WDcyNmJvWG9TWUhM?=
 =?utf-8?B?MWYwRU56YXlnTFpOR2h6U2VhdWdrR1VvUzJYWFFqZ0Ewc3hZYklZRlFGMjlp?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79E59A0A171F2740B9D84FA26205056E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2279e1e-6785-42e4-fa4c-08da81aea809
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 06:47:16.9709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z4V4z390phqouXJP2z2q2dPXD+2TCadZvokdN7FzwB/TET2SiWOP4XxOl57mf4iOXX2HTl7FeyvfiqcAzsPU6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4932
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMTksIDIwMjIgYXQgMTE6MzQ6MDFBTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IE9wZW4tY29kZSB0aGUgcGFnZV9oYW5kbGVfcG9pc29uKCkgaW50byBzb2Z0X29mZmxp
bmVfcGFnZSgpIGFuZA0KPiBraWxsIHVubmVlZGVkIHNvZnRfb2ZmbGluZV9mcmVlX3BhZ2UoKS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtlZmVuZyBXYW5nIDx3YW5na2VmZW5nLndhbmdAaHVhd2Vp
LmNvbT4NCg0KVGhhbmsgeW91IGZvciBzZW5kaW5nIGNsZWFudXAgcGF0Y2hlcy4NClRoaXMgcGF0
Y2ggbG9va3MgZ29vZCB0byBtZSwNCg0KQWNrZWQtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEu
aG9yaWd1Y2hpQG5lYy5jb20+DQoNCj4gLS0tDQo+ICBtbS9tZW1vcnktZmFpbHVyZS5jIHwgMTIg
Ky0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDExIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS1mYWlsdXJlLmMgYi9tbS9tZW1v
cnktZmFpbHVyZS5jDQo+IGluZGV4IGU0OGY2ZjZhMjU5ZC4uMWE3ZDY1NDhjY2IyIDEwMDY0NA0K
PiAtLS0gYS9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ICsrKyBiL21tL21lbW9yeS1mYWlsdXJlLmMN
Cj4gQEAgLTI1MTEsMTYgKzI1MTEsNiBAQCBzdGF0aWMgaW50IHNvZnRfb2ZmbGluZV9pbl91c2Vf
cGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSkNCj4gIAlyZXR1cm4gX19zb2Z0X29mZmxpbmVfcGFnZShw
YWdlKTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBzb2Z0X29mZmxpbmVfZnJlZV9wYWdlKHN0
cnVjdCBwYWdlICpwYWdlKQ0KPiAtew0KPiAtCWludCByYyA9IDA7DQo+IC0NCj4gLQlpZiAoIXBh
Z2VfaGFuZGxlX3BvaXNvbihwYWdlLCB0cnVlLCBmYWxzZSkpDQo+IC0JCXJjID0gLUVCVVNZOw0K
PiAtDQo+IC0JcmV0dXJuIHJjOw0KPiAtfQ0KPiAtDQo+ICBzdGF0aWMgdm9pZCBwdXRfcmVmX3Bh
Z2Uoc3RydWN0IHBhZ2UgKnBhZ2UpDQo+ICB7DQo+ICAJaWYgKHBhZ2UpDQo+IEBAIC0yNTk4LDcg
KzI1ODgsNyBAQCBpbnQgc29mdF9vZmZsaW5lX3BhZ2UodW5zaWduZWQgbG9uZyBwZm4sIGludCBm
bGFncykNCj4gIAlpZiAocmV0ID4gMCkgew0KPiAgCQlyZXQgPSBzb2Z0X29mZmxpbmVfaW5fdXNl
X3BhZ2UocGFnZSk7DQo+ICAJfSBlbHNlIGlmIChyZXQgPT0gMCkgew0KPiAtCQlpZiAoc29mdF9v
ZmZsaW5lX2ZyZWVfcGFnZShwYWdlKSAmJiB0cnlfYWdhaW4pIHsNCj4gKwkJaWYgKCFwYWdlX2hh
bmRsZV9wb2lzb24ocGFnZSwgdHJ1ZSwgZmFsc2UpICYmIHRyeV9hZ2Fpbikgew0KPiAgCQkJdHJ5
X2FnYWluID0gZmFsc2U7DQo+ICAJCQlmbGFncyAmPSB+TUZfQ09VTlRfSU5DUkVBU0VEOw0KPiAg
CQkJZ290byByZXRyeTsNCj4gLS0gDQo+IDIuMzUuMw==
