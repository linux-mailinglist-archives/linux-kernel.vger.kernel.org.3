Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8655996DF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347686AbiHSISY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347555AbiHSIRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:17:35 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2080.outbound.protection.outlook.com [40.107.114.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F67C12FE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbpfEHD418uphbYowGaiqkLeLFFKURjpQG0gwdKiK5xT7gV7kFxYDjKt70TD5NDGhJ9N4jgDIyiWqy3mi1vVfmggYox+Wp3Wjgy/C4Zh7ouzkOTI+/sWuazod1D8Pxgl9PsHRzR7/zjtMcyZ4+Bel7Jpf/alTvyd6AExgO7aGR3JAh6FtvKQYTZeMokgyxa6l4SXKKasCrmjdezLh2sBML2IdQsRt8p0QLpL0Vwh6acrdZji4FGPv8LaoEZlJUjn/wSslo4P8PU6PdBBqoMvOMIOReAClZUW9jpvodY3McVuK2pRAeo/SPa+T6H7eJD19JG26hZsGW6aMVbkeoSZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqvGHbY8PnDVHahtfaNFWMGGc7WA3BG8/z/Rrb3DykQ=;
 b=PnquNxn7gdY6+8bavSJTy1WmyW9EA9YV8xYz9UK3E3QUH0z4zMapD7tU/vG8OxkDRa+nXLUePmSWGIiosgTmoXrOPQD2xxpmsYFNctgkr8NFhp0AGGwMhSkeLdHAbi/0rEIjtMtmSP1PSTLC+Rh7kQogr61jLx0yjx8QxKnq99xYCvmUjgPr2oNi85G+CkjY/enePzKKTXVqUOsl2u24kLo1PYyHCIP6Vrazvg6GaNqoY2ZGNJTzxSwSW8aiuRqFQmu+sHbjUGlAlUFtr01RxFhd0odJNhP5xjGTT5MOk+oLE0iAAtSFZI79PxRoJr8AjWvmxSDAeErKzx2INu1yCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqvGHbY8PnDVHahtfaNFWMGGc7WA3BG8/z/Rrb3DykQ=;
 b=ex/H25LXavqRQ5ouH7wWtM6pme7p1MSnR++WdvdHDpvW5QjN92SdwNgk3OISfuOmEmB6Fr19jZG9WQfC05iRa9NETypqhaKtqYsAD8fp9KVrJ11DHzK+FqThnUxiDvGCqWR4zo0GME/EMX4fr96qKoRRhh9Nyi7hzR4DbpAi2TQ=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB3813.jpnprd01.prod.outlook.com (2603:1096:604:43::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 19 Aug
 2022 08:17:32 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 08:17:32 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] mm, hwpoison: fix possible use-after-free in
 mf_dax_kill_procs()
Thread-Topic: [PATCH 4/6] mm, hwpoison: fix possible use-after-free in
 mf_dax_kill_procs()
Thread-Index: AQHYswKMj+K5+fERuUCXeznMVtIiRq21sZYAgAAkDoCAAAyZAA==
Date:   Fri, 19 Aug 2022 08:17:32 +0000
Message-ID: <20220819081732.GA622828@hori.linux.bs1.fc.nec.co.jp>
References: <20220818130016.45313-1-linmiaohe@huawei.com>
 <20220818130016.45313-5-linmiaohe@huawei.com>
 <20220819052324.GD613144@hori.linux.bs1.fc.nec.co.jp>
 <6dff6aec-833c-a3db-1180-09e395f6265a@huawei.com>
In-Reply-To: <6dff6aec-833c-a3db-1180-09e395f6265a@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5f6afa5-c95e-4e6a-9afe-08da81bb43ec
x-ms-traffictypediagnostic: OSBPR01MB3813:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xNw0gGIIjLhW84HbD7dQNJY9RlZw44Tw55fBOOvKKUK/1cOb9D3MQxp4ZUXU64FcbIvzumLsR5i/crtoPxDG0xaXrUUtBcHOb5P8LZDbnQJAJ3f0C/jTpjs/AsCBtcbcRXlC1KaQnHrcyeIMKOQzWMk+e6+nL9gQ46ruhfcg7zpeRLOq8THtl/wXTYVk6yhvAdCtHzV/cSJkLY/eg4rjVW++mmSxjd1EAOoga80TJkw1/mCZJoPas+abop9Dd26/qwRh1AHHRyJmj+6YS8nkX3e0GjfBEoV+thiplrUiuEupcAW7/6M9daZAZg0rPZIHR1GVtUodY6GdSA12NDy9L9hTw9rdUbVParQd+jarmkDfsZfM0b2uwRtjhG0LNh4K4aeMqk/xJxTXhVTivcXbHEdQBMTEct+GBess2ccZFQG/4NKcVJnBigDO0KPTcWD/xXfHJANaEnIeeFN/5dXPmNtB+zkqF7kiuhNDHOG4Qe6mWU/fMQq8jYmykPXDlsyNQnr2/aNA/REXu8y6NqdzlWBu/L0ueY9M2K+M0JsoBCC2JxLNOUnLn2zKwiy37rswhZ5/K964Kgzn+L0y9rTmUii8BehGLffX0NuvtUXy8vpsUeqEKgol0N67w9N4nw50N+wHkAygU0+bwuBaqjqRU/1kFyv2Qo2aCJEllKXBfyePLgoppijTIStK/uB1s3zlKmrwIQ17pkM/uXkaAfk1fhzzHWr8QR1iqMGuPK+2yNF1DGbcOaFAs8XJsQxykZJQNV6C7uUYef/gNNRjveXYAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(478600001)(1076003)(53546011)(6512007)(86362001)(33656002)(38070700005)(85182001)(26005)(9686003)(41300700001)(6506007)(71200400001)(6486002)(83380400001)(66446008)(8676002)(5660300002)(64756008)(76116006)(54906003)(186003)(6916009)(66556008)(66476007)(316002)(2906002)(82960400001)(66946007)(4326008)(38100700002)(8936002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWQwVnFIcHRqMjFyb0RUZjNCK3FQd0J2SDJDdS9QYlZZOTJVaGI2MUVma2F1?=
 =?utf-8?B?MUlkU21wY29Ycm1qVElvemdJOWFzL0h1cUhTZWJ0MEdVdExrWEY3ZjMyOEc5?=
 =?utf-8?B?czRQYUxJWTV0SlJSbFhwVUdFOVZSZkhpeUZTOWJSL2tOUUI3NHVxcnh6ZXpk?=
 =?utf-8?B?Mngzc0Q4TGZCcCtRMnRqM3dUcWhhVGJzY3pRTW94TEl4SllVdXNQN24xSUNX?=
 =?utf-8?B?SWNBcllJNHQvTG54Wk9OU0E2ZEZHZzVqbldFR1BIQ3k0bnVGVS90L2pYZmtI?=
 =?utf-8?B?dW15LzhtVHg2L2dsbzdrbmhsOTJjTTliZ3psdjJBdEg4VUNBeEc3NC9GYzhV?=
 =?utf-8?B?Sm94VkxFR3lVV0tJc1o5NGw5ZzJteGgxRnJwd1V6SFBuMGdSRXNYMmttMkxB?=
 =?utf-8?B?N3RTRVh1VDlJaUFhTkxjSVk5RDFBTS9RY05DWVYzL3FkdTFITHF2QWRhOVh1?=
 =?utf-8?B?RU9zM3p0c0h2emhzUTl1ZWRPMW1rd0pLd2NpclJBWEdvMko2a2M3bm56YWll?=
 =?utf-8?B?c2I4YU0vaGJYYVVjZmZWVGoxeEE1YnFmWmZ2c1Jtc1plVllvVHVFYW81bDVT?=
 =?utf-8?B?OVFMV0lxd0hVVlJqYmpCaGUvYkdyelBYUUNqSkRxUHVwTFd6Z2FicVlvMHdJ?=
 =?utf-8?B?NHNUM1RoNENkeldydUhSMkdtS2Q5VTVQMmEwbW1kWUtnZGVtbWRzeC9zY2ZK?=
 =?utf-8?B?TWFJcnRKbkVFZkVqSDJ2Q29SUFhjMXdXWGRwT0J2WktLYXBnNnNvNW1YUWEx?=
 =?utf-8?B?VXRjODM3UlJvTTY0bzRYSEh5UENldmhzTjc4RjJheXpaNGJ4NEJiS2dkNi95?=
 =?utf-8?B?Z2cyVnlaQVRXQjZRbXBZWXBwOTg4RExEM3I5VDRMdUlpZU9oYjVYZERYNFE2?=
 =?utf-8?B?T0V3ZW5kSnc3OFNXNjhvWS84TzlLSzZQZ0tSZUFsYllLZ2toVWtyK3c1Z0NV?=
 =?utf-8?B?bnFDd3FnSWpiQ09EUUdKaitCdGJ4S25yemNmUmdsL3dqcWRiZWtUajRiSWkx?=
 =?utf-8?B?NVZZQjNKeHFwSHFYRUF0UWJzQnZNS1E1bGNyYWVKZG5nNk5GeEQ1WXN0VlVD?=
 =?utf-8?B?aDhLZC9MTnhtTmtuOE04SENPb21rRWY3bmpXQ3lYSkFCcmdCdUxBMU8xLzd2?=
 =?utf-8?B?dStYTnEzd3UzV1RqWkRjc0xyc0pmMEVTRUkxRTlKdFd1bzBid0ZJK0MrUnF0?=
 =?utf-8?B?cUhBK3MwUmY5VllKa1pyUmxheEdSekFZeldBeTdSZkg3Y3JUZE1WODg4enJV?=
 =?utf-8?B?QTlBenlnNjBiTlE5NmJWVHlrcXFkWWxsczQ3VytiTnZDQmJqZnBJRHpXbjFU?=
 =?utf-8?B?QWJKam9TYmFQSk1SelZaUEsrNGhuNkJtYUN0T2lWaXpBSEdIVVZZL1VxU3Qr?=
 =?utf-8?B?cFVDWUJSWFBDRnh2S011dnpoSjhIZVhqdnh6b2I2L1JnZjJ5NEFUVG5FVVly?=
 =?utf-8?B?ZzI4WG1CYzhUNVNFUXJqV01oRlFUc1Y1TW9VdGFUakNHUjhZS0hUYUVOaFdl?=
 =?utf-8?B?VHJRYkVwU0FzbVQrbEZsL1hSRnJKOTFlcWlDRnhQKzRsRUd3Zlc5aWF0WGRQ?=
 =?utf-8?B?c0xxWlRVQStIZWR4ZVd4YVFqWTZyUVJpQll0MUREZUhhV0FqRDZ3MCtMcjQw?=
 =?utf-8?B?bEtwUXhqWlhjMDgzWGV5S0lVRVVmZEcxWVRZZ2w0K3Mxa0hNbHByQTRiNWtk?=
 =?utf-8?B?RGhPVXFDdjVmRzdOdXAyT2FWWE5SQmk5d3AydmpGZktERVJwcWhDUUs0MXZW?=
 =?utf-8?B?UXRjbTRYQUpEZGI1cC9aY3VxNkpHWGpQZFNmbjhYNUNIM1pncmtheGphMHZS?=
 =?utf-8?B?NUhWZVJ3NFJpNlRYREJkOHpLd0VZOXloNzhlbWc2MVdubFJnc3hkNTdINHM4?=
 =?utf-8?B?dXg5WWFQWmlhOVI3Z1lJSWJOUWs1dTRmdEZGaWh6ZCtSMFU5WS9uQWVzcnFF?=
 =?utf-8?B?ZlZxeVd5K3JYdSs0emt3cGp4WTJJTFBSbVoxazlpYmk4cXpOZUhYam5JTE1U?=
 =?utf-8?B?Y0lENW43eTduUFZSM1RBUU5YNTlBdUlGbFBLcGE2bjY4dTBqdlRnc1hTM3hq?=
 =?utf-8?B?VGU5MlU4bHFHQVhITXBraVpJUFdaczNqOUovODNiWTROUS9IZmRaSTZXK0Yx?=
 =?utf-8?B?QkZwL3lvU2wwZEpNNTdHRFlLWUNXYXNlTjlwMFJXYVRRdXFxMm9odEdoM2Jv?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F702B479D0883D46B99E91A72FEF8A9E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f6afa5-c95e-4e6a-9afe-08da81bb43ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 08:17:32.4481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StJiGrK/wI59R0avIcJUVU/eKxLpu8TzgghQqPHpK2jwyhNUxgNMv/V6E9YWyCNB3BeRLVk2qDwcUZMSNTaYRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3813
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMTksIDIwMjIgYXQgMDM6MzI6MjdQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi84LzE5IDEzOjIzLCBIT1JJR1VDSEkgTkFPWUEo5aCA5Y+jIOebtOS5nykg
d3JvdGU6DQo+ID4gT24gVGh1LCBBdWcgMTgsIDIwMjIgYXQgMDk6MDA6MTRQTSArMDgwMCwgTWlh
b2hlIExpbiB3cm90ZToNCj4gPj4gQWZ0ZXIga2lsbF9wcm9jcygpLCB0ayB3aWxsIGJlIGZyZWVk
IHdpdGhvdXQgYmVpbmcgcmVtb3ZlZCBmcm9tIHRoZSB0b19raWxsDQo+ID4+IGxpc3QuIEluIHRo
ZSBuZXh0IGl0ZXJhdGlvbiwgdGhlIGZyZWVkIGxpc3QgZW50cnkgaW4gdGhlIHRvX2tpbGwgbGlz
dCB3aWxsDQo+ID4+IGJlIGFjY2Vzc2VkLCB0aHVzIGxlYWRpbmcgdG8gdXNlLWFmdGVyLWZyZWUg
aXNzdWUuDQo+ID4gDQo+ID4ga2lsbF9wcm9jcygpIHJ1bnMgb3ZlciB0aGUgdG9fa2lsbCBsaXN0
IGFuZCBmcmVlcyBhbGwgbGlzdGVkIGl0ZW1zIGluIGVhY2gNCj4gPiBpdGVyYXRpb24uICBTbyBq
dXN0IGFmdGVyIHJldHVybmluZyBmcm9tIHVubWFwX2FuZF9raWxsKCksIHRvX2tpbGwtPm5leHQg
YW5kDQo+ID4gdG9fa2lsbC0+cHJldiBzdGlsbCBwb2ludCB0byB0aGUgYWRkcmVzc2VzIG9mIHN0
cnVjdCB0b19raWxsIHdoaWNoIHdhcyB0aGUNCj4gPiBmaXJzdCBvciBsYXN0IGl0ZW0gKGFscmVh
ZHkgZnJlZWQhKS4gIFRoaXMgaXMgYmFkLW1hbmVyZWQsIGJ1dA0KPiA+IGNvbGxlY3RfcHJvY3Nf
ZnNkYXgoKSBpbiB0aGUgbmV4dCBpdGVyYXRpb24gY2FsbHMgbGlzdF9hZGRfdGFpbCgpIGFuZA0K
PiA+IG92ZXJ3cml0ZXMgdGhlIGRhbmdsaW5nIHBvaW50ZXJzIHdpdGggbmV3bHkgYWxsb2NhdGVk
IGl0ZW0uICBTbyB0aGlzIHByb2JsZW0NCj4gDQo+IGxpc3RfYWRkX3RhaWwgd2lsbCBkbyBXUklU
RV9PTkNFKHByZXYtPm5leHQsIG5ldykgd2hlcmUgcHJldiBpcyBhbHJlYWR5IGZyZWVkIQ0KPiBP
ciBhbSBJIG1pc3Mgc29tZXRoaW5nPw0KDQpObywgeW91J3JlIHJpZ2h0LiBUaGFuayB5b3UgZm9y
IGV4cGxhbmF0aW9uLg0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
