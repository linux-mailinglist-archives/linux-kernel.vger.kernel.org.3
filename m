Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEB55AC9BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 07:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiIEFZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiIEFZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:25:38 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2044.outbound.protection.outlook.com [40.107.113.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471532E9F9
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 22:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtxTNVPNT4qo3Z3nRLlnpNct1avFpD8z89ZNSuo8a/EqzJPMDyhKeV6ZOaFKaJvwTy3ozZCIrHIv883VrB86F/RoIRaNbw6/Tbf1WmoWJwIXC1gvDrdf+VHZe1xSoEMR5juQqMrnHKMHUv/M8fAtfXdMkh1dgaak3N2yei6C3D/tpg/6FPcUahwWYJySlDyo5jNMCzY8hkNXuUZ/TQNaBKxe6q1yLEg0PWSIMny/C/HFhm/wxnhC0nBdhXECYFoMTYfijLnJOBkZSqQrs2tcbd8I2jT6SEf0UoqfMwxiR1utPXjIu+Tww6uXeR6LT4TnpHg+lCR+5abgGvW8dBxsFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik/tUhwQfDOIKrjwx/ptJLOv1siXa3s0yXT6pw/z3Bc=;
 b=eaQhvwAPBm7Am4rjOsQsepTvo8hxmVm5yuCo9Urx4ETuA8YZLt1dg5miyojW7DoATdGlKxw+4tkc+zzioIgnKo8sSo0LxWTZFY4Spzm7gclHpfkqrB4jYg5qkDndsStSHImUTqLNxGNf9I7iZRLTssEzfhojUn4MzmzuNd3qHuMsns13z286Ref30APbTh3P1Lwz3SHS61IrXO2Ik3iBZ65ws49KPRGoNPUZcB3fPA32OJjkg2eB8565hvJ8tuspHNCE1ngW5lQSh2FkV/IfC+sFHozVWZ0RmFjr5473fSeYCJW70MfHbIpVb530WsD+vipU4uGG84Bdnz1G7lPeWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik/tUhwQfDOIKrjwx/ptJLOv1siXa3s0yXT6pw/z3Bc=;
 b=cRzJ55I6MgPXgOtW2zVYckr4Dl/ZuxzfiVVIgUgeDbIU7g6qwgiNFOnh1i12MVhuKVgYuAJCGjWk6R1+b+7LnCJg2q0TJT8LoHoH8FQpx/zfACm3kSguTulToXcz8gs9lqu/fcka2spF5/b9l8BywnNtG8bXFYuYiz70C+mV0hk=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB7775.jpnprd01.prod.outlook.com (2603:1096:400:180::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Mon, 5 Sep
 2022 05:25:34 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5588.011; Mon, 5 Sep 2022
 05:25:34 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] mm, hwpoison: cleanup some obsolete comments
Thread-Topic: [PATCH 6/6] mm, hwpoison: cleanup some obsolete comments
Thread-Index: AQHYvG0pyT6HNGjUbUOVBK+J8rFwUq3QVv4A
Date:   Mon, 5 Sep 2022 05:25:34 +0000
Message-ID: <20220905052534.GF1355682@hori.linux.bs1.fc.nec.co.jp>
References: <20220830123604.25763-1-linmiaohe@huawei.com>
 <20220830123604.25763-7-linmiaohe@huawei.com>
In-Reply-To: <20220830123604.25763-7-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f37d65e1-7e9d-47d6-fe81-08da8eff0f34
x-ms-traffictypediagnostic: TYCPR01MB7775:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /HWKNqZm3vrBWms9DNnqfNvdj8MfNh8nJTUuP/AGt2/+OGPh31hlWRvxJQnhnw/BGI9EzoHwWrEL0OLmzoLaaGL7oE4j54w9dcl7SV3iE9qlXxmsgxkC7hIYz+86eJcvEXFaXP/m5SiyVqnKogsAuLTRjYyzbtwuLoETt1a1OsmYsUtwxA0RVAoaZ9tTqUJ/ncQQkW15k3yYn4QqGAjq1JY7fYJYUiEWKI83DZjB3AVESaEZkHxVjMec3SIbMTa8MqliU1rQgItu6PqKOQQxcdabtiJJKr0tl9uxYYfXYF8yZjN5FueSf/tXN+6Oa06OTkCX1udkptn7HRA6x/zCAGU46ELt1PWVljWHAjd2l8mTTOG5pzwMgux8vkpBmjSIaef+3EFFEp9HGgL/knzunzXBmZgQwV3inXSozsH6TFLHMbaMA5mVJ9Nj5C0UxBOke79vJtVgzpOt/nGlbi9EaviwbJ2vNC6sqnqZcuKCdD9Tj8qHVothBbfA3aWYp++/uJswzQj/FAqZpfVKfH30aTm+dIF5X68r4azWG+sANJiUIT5M6pyLRzk4LejzcKROM8gLmKkGMnkSpTvMpMo/lE886qCaDWLR/TsWp19xg3V8IQe5HNOEQ1uDvdFNQGigOdYSdBRB0Zc4arYWzEIDPl81Hr37dhU8vkyr2jEKhGPkTjR6g+V3CgDwtaYDFqYrH32/CQ/kOrcxAwXJZg1VvGdJoE5ebvTqpqZUkUGtQRlrm5sEeKAtY7ShDDJaMn1LEcvps0Xcrf3ghadVW0j81w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(38100700002)(82960400001)(38070700005)(2906002)(86362001)(122000001)(6486002)(5660300002)(8936002)(4744005)(71200400001)(6512007)(478600001)(54906003)(6916009)(316002)(66556008)(4326008)(76116006)(8676002)(66946007)(66446008)(41300700001)(83380400001)(1076003)(186003)(66476007)(64756008)(33656002)(6506007)(55236004)(26005)(9686003)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NElUTndUUWJ3ZkJCMUpydE1MdVZQWjJiWFFibW00VXJYUWlzR0RET2JZaEMz?=
 =?utf-8?B?UGl4WDFrbjZka0JSRGVsUUFpcGdaeEdoUzc3d25Hd0xOakFPbjVLSTlSamRr?=
 =?utf-8?B?V3R1eEVXaVYwNllveU9xYm1vTjVJNVlwcHNTaVRmckRjTWphaU9DODg3SW5V?=
 =?utf-8?B?MnlQMTVQYWxiTGhCMWlyR0ErSExVSHJCYlVSMzZXWFZwbjVMcWlZMUVLVENm?=
 =?utf-8?B?VE03UndUUlF6ZmE0SjI0TXp1WnFmUXhzY1RYZElsMUl0MnB5WmI4Z1ZkeHVh?=
 =?utf-8?B?QnhXbnpVaXRFRFdUcG9HMTJZU1duR3hBdWkrVlFWU2Y5RTZFQzhuSm1EYldq?=
 =?utf-8?B?ZDE1d1dWZ3dTQ254TllFY1VXaGlIZWN4ZlVBdjh3MUJMY0l4cDV0RFRXQzZU?=
 =?utf-8?B?dUZFUkhqZFhJRHgyanljZ05FemR5SFVmMTgwdnVZT1VMdEJqT1lQblBFUkRK?=
 =?utf-8?B?bC9SQUFjQnQwQlJoaWZ2ZkhxYllMbzZDMlZHQ0xINzBvei9Va2l1ZTBTajhT?=
 =?utf-8?B?Y1AyM1ZlVzhFV3hObkU5VC93M0paUi8rL3FXRjF3TllmRHl2VHVCOEp2aWZI?=
 =?utf-8?B?UXY0M1R5Zjg1OFVhZU55Q2V4OEdZTS95UmF3bmRsZHpyOUQ2WERPQTlMS0xO?=
 =?utf-8?B?SnVyaGRvaWV6aG9ZSjJmaDZ4dkszM2YyNXhVVGk5ZDNudUJ1MnlSME9NR3pq?=
 =?utf-8?B?cGRxY0QwUndSU3dWK1EwSHpqVm1tWHZRd1l6ajVwaVJHMHdweU9meE1OVDB1?=
 =?utf-8?B?ZXdhL2xoL0x0anJOWXZtTzlaYW4yeVhiTTR0NzNOa2Z4eTFKUUc5LzJ4VENV?=
 =?utf-8?B?MjMyVVR2MGRuZmQ2c1RnSzFXaUZ0TC9UZ2hINEltQ2hRT2RrODMrcDM3aW5I?=
 =?utf-8?B?RGpxeXc0SWxGWXFWREEyMXFlOERmRDVqa09TUFI3SmZpMG4vZFVlZzhnUUhl?=
 =?utf-8?B?Y0R1K09XdEJvTUFHWmNlb3JwMXV5TnNtVVZPOFhScWNUMHk3Mjd1RmdveGVa?=
 =?utf-8?B?MlJ6YWNKOUxucXNnL3lrL1dPRis2amhCTjZqTVcvRmJxaW16Y05mNHliMld2?=
 =?utf-8?B?YmVXQkd3L1poUm54cy90Yk92MVpMUlZPWnpBTG5XUmN6dnU1MDluSFdUQWVo?=
 =?utf-8?B?b1NUK1BKSWV5aUNxMTJGeTlXTmxsZEE4czN4TFJBdDluY2lTaDRIK1k2Z2kw?=
 =?utf-8?B?cnNrUmJvM1p3VTY0b21Ld0hlcGxnclQ5S2w4dW9OYW1BOFRuemtuclBWVk9s?=
 =?utf-8?B?RlFIakdwbVNDdmJrN0F2S0dUQ0ZnRW9zZnZmT1pSQlo5ZFA5d0RFSEhpWERD?=
 =?utf-8?B?ZDVQaVcvbVpyRUVhN3JUa0tuNzFKRll4QVYybmpTMnpCNmFnRVZ0UUxRWDhP?=
 =?utf-8?B?OFg2TUJsOHRKWFFCMExhaUdRTGN5Tmk0d2owMGxSRk9YSGkwWmdBenpBRnNE?=
 =?utf-8?B?WHpNWXFOS3FhZnZvQlJEVTBvOWQ3OS9kRG5hdVdnWWVRNkpNUDdLTmNrRkRv?=
 =?utf-8?B?K2RxdFBEWmRuNm5FVVVkZUxVOFpPaG5OUGpJbjFGK216eUJwWW9WZUJsQm9C?=
 =?utf-8?B?UHBramdMLzEvVElKVFdETlk2VE1IUVJWTWFrcmZBRHBQU3pKQjJBd1Z2Vmk1?=
 =?utf-8?B?K1l1UWwydVNST0VwQkNuQmNoU0UxVllPcFdYZVM1RUZybFpNeUVWU0VRQ01u?=
 =?utf-8?B?VkNtS0ZPeXlnQXdkbGQ0TGl6WHZXTWNpV2xKMThtVFJyZ1JJbWxjL2d1dUFI?=
 =?utf-8?B?anR2NzVXUUVpbWJOK1hkNkJxWm1nVWk2S1Bma1ZLWm1VT09zdnZFbkdZdWxj?=
 =?utf-8?B?NGg1clVCdXQxbWNveGN2a1Z4ZHRldmFZTWI1WEtld1c1OWV6WnI1SmRFRWpJ?=
 =?utf-8?B?QjduRXE5SnE1UWNoMGhQZmkrN2ZtbzFTTmZSUy9qWm1pMzM5aGVMdnFWUUZ5?=
 =?utf-8?B?UGJHYi9nWkYzMWlDYnFudnA2MWY2MHRlRzNHNjBMdm9mZHZ4bDNyd0ttWDJN?=
 =?utf-8?B?c0RDdUZFa3UwZ2R5cUlJaWFmSmFwc3ZUbWhnUGFNR3A2QTVYN1Erc0F6VFY4?=
 =?utf-8?B?MHJvY3QxM3dVN0Y1VGRweXRvUnF0UGtyL3phVVA4aEV5dEEvMzZaWkR5SHpv?=
 =?utf-8?B?cGIxNkt1ZWMrS0Z3U0hXaXBmZXFDVmZudGpYV0pTeUdqYmlBeG9UOG5CQ2ps?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BCFAC2CAB268C42A495FC7CC09398B5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37d65e1-7e9d-47d6-fe81-08da8eff0f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 05:25:34.9126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5pZiz54a0mnn7TSeGqyed4458o3HLkc0KttYLpCaUTLOBD2c3x2bUiZEiC6J1oIM0h9kj4IQ8kmKdVQ2hDGgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7775
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMzAsIDIwMjIgYXQgMDg6MzY6MDRQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gMS5SZW1vdmUgbWVhbmluZ2xlc3MgY29tbWVudCBpbiBraWxsX3Byb2MoKS4gVGhhdCBk
b2Vzbid0IHRlbGwgYW55dGhpbmcuDQo+IDIuRml4IHRoZSB3cm9uZyBmdW5jdGlvbiBuYW1lIGdl
dF9od3BvaXNvbl91bmxlc3NfemVybygpLiBJdCBzaG91bGQgYmUNCj4gZ2V0X3BhZ2VfdW5sZXNz
X3plcm8oKS4NCj4gMy5UaGUgZ2F0ZSBrZWVwZXIgZm9yIGZyZWUgaHdwb2lzb24gcGFnZSBoYXMg
bW92ZWQgdG8gY2hlY2tfbmV3X3BhZ2UoKS4NCj4gVXBkYXRlIHRoZSBjb3JyZXNwb25kaW5nIGNv
bW1lbnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2Vp
LmNvbT4NCg0KQWNrZWQtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5j
b20+
