Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71E6560F24
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiF3C1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 22:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiF3C1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:27:37 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2074.outbound.protection.outlook.com [40.107.114.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCA1237EA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 19:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzirYDQxWmbT/E7oIfTFW8awcCOI48KpV7W5hzEH6hOYYrf20RbBggA6klxy/ZtcoCPGGQRK6U0F1NBG9abDEZl7r1CSLnAnNasGrYy3uZ4GUJeT4CxYcMi0/wKYo3c6kpW16dESgK29lExIKKmAh6cUfHr5vf4a4m/X2RivkNrfGaWNSiCVmMPOeh4ezTUHHZQE9ovKG5IYG8yKINpF9LGhkCb8lJSq4G8TFo7ARyN4VctKy5gVFuYh6o33iqREfmvcwFgbPG8kIYtnKk3hUz2sL7TV1f8LNca7HaafDuBqzbOv9nx8Ob6fIGFaJ8+yZvHLa7++1/9QPwGc5pjY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J53hdJ6RRNGHuPFUs1LQ8bZMwia40sOB7by4lC549cQ=;
 b=F2mMTOunG9R0lJKSgCgfVk6e9OFHilFf4wYQmJSHblwqg9k8SXZ0i6xslgPWWCGEpNyELT2Wt2lhbz2uQYBmcDYcM8XhMbJzs4lVBGGFT5yX6Uduw/xBbmhlxd7a3QOtZUJfExNstCdSqoqJv5bOT/jNyiKTHj6IqR4dAib46qJ/JWOtN5UtKNNYl0AExx3dbNuV8AFQTd0FLGGG2FXPaVc/qX1k84XjwO+3OCcC35E/8WBIAY4k9JsHkVJk6O81CrlJH+ox1hoVL/rHjZW6ZOaL1Fb+hHNc1DQSIcsR6lyqAZgvjjDi3Zc9wacFmuctdyTVwgloqchCjtj6LhRz6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J53hdJ6RRNGHuPFUs1LQ8bZMwia40sOB7by4lC549cQ=;
 b=YV0Ulw1msA26ZSiePPWnNCQd6l9CCxtnpwnuk0T5wfZDgtrDljARZRFoskTxy+lt0AyUABJOmICvMCcPdY7h/pDkxbAoSUGS+xLE6Ak+HHboJMuOrbL3yHuCZ3H08zaA2qSJC5eE6d4Cxzgkg/D8EKCkXkAfFhg5NndWzAn+AV0=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY2PR01MB2185.jpnprd01.prod.outlook.com (2603:1096:404:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 02:27:33 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%6]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 02:27:33 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/9] mm/hugetlb: remove checking hstate_is_gigantic()
 in return_unused_surplus_pages()
Thread-Topic: [PATCH v2 1/9] mm/hugetlb: remove checking hstate_is_gigantic()
 in return_unused_surplus_pages()
Thread-Index: AQHYh1xSoNvgTy1mRUSP6G7yMyIF8K1d1LUAgABeaQCAAAM+gIAABVoAgACx4YCAA9qpgIAAvr+AgAD/EQCAAr0eAA==
Date:   Thu, 30 Jun 2022 02:27:33 +0000
Message-ID: <20220630022732.GA2280505@hori.linux.bs1.fc.nec.co.jp>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-2-naoya.horiguchi@linux.dev>
 <0b69e3ef-0123-4575-b68d-4d9b2067aa0e@huawei.com>
 <YrVv3gKMxbu/dwCs@FVFYT0MHHV2J.usts.net>
 <e9a22524-d9f6-1018-a712-00adb90d432a@huawei.com>
 <20220624083428.GA2070418@hori.linux.bs1.fc.nec.co.jp>
 <YrYMS5sATPzEgUxb@monkey>
 <20220627060231.GA2159330@hori.linux.bs1.fc.nec.co.jp>
 <Yrnn+QS8JCMT/3JV@monkey>
 <20220628083808.GB2206088@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20220628083808.GB2206088@hori.linux.bs1.fc.nec.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aed01691-3277-4f65-8329-08da5a40170b
x-ms-traffictypediagnostic: TY2PR01MB2185:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iS3QHM6kUXD4OdcLjoyhr93kVqvf53FnLGThZa1t8mxnTyvq3frjL5MCbbYn7bK+VDO3yWgX1ep/iCVXyWZv1YA/XCH0+gNeEzyrPY1+cdVa/HLUgFDzhWg/DAA0UQKRfDsJ/5EhvYh4+qJxm/Bz4Lak8gOyrv3IOik+eiy++kNiTOzGGx8d+KjRvZk/n9/AkqcvU/XNirNsFpkySjGeWCXKeCHZilE5WP6tXp/1H98giAyq6o4eteQGyhRpUy4hmfPvt7nJbOb2nDsWbqUYfx48xmCSLdczQWRAGrTmTm9nlOlpruCdc7jjWhWlIPdUCHJ1zWlTv0Kky9VVbR24sqFDcF3DMMAOW95p/nTdNo9s1OOfz+Enj30ANv/8DYE0Ew4ASIh+vgClEyYXG2VybCQguGCydT9HXtU2Gf+VaBBBpCUBzGf2MhshUQUUH3YhBVjovs66ltBIMcrTl4bedYGMwXZCY/r6nwuG0BISWPOzF2znyA3sj5SdQ5LuYvgFndnQx7x0EKx/E4gGMFrXM60VokbjEI6Tjxcx4ZQC+fHDlmwuARnlvHbO6ylio/xXhakhS0E7/C0G5Nrj1xsc1qAsP8wA1oUhoPiZNXqkslDuySHV9RSJ22HZC3nfVePUtemlxb5GpI/D5ifvk6zmRisF327ipVoCzORGmo3peewqg5FsQRpcvP0xbKAEF9qdazhXn68XzSH3shcbSVJN+ky+mI2u1k5PIyVuePh2cHFXOoE7sS80peaH6IVUcrg/AacxcfOwWAQQ9ZIiwbKRGgW2XzWiLpCILYnr60YkOvOGskl3c22STA+jwEwLx1nR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(38100700002)(33656002)(6916009)(2906002)(122000001)(8936002)(5660300002)(85182001)(55236004)(186003)(316002)(54906003)(1076003)(83380400001)(9686003)(66476007)(64756008)(66446008)(7416002)(82960400001)(66556008)(8676002)(6486002)(4326008)(66946007)(71200400001)(38070700005)(6506007)(76116006)(478600001)(26005)(53546011)(6512007)(41300700001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVU2cENhS0FaQWNCeGlpVTFUdUc0ZzJnMTFTWmQ0WnRScFZCUFZQeWlPVjh3?=
 =?utf-8?B?eGl3dlNSNjNheHpaQ21lWC9IdlJIRWtBbXpnN2Q4RDFlWGc2REJIVGhGMk0v?=
 =?utf-8?B?dmZZeVJ0dkJaTDYrY2JXeFZISzZveHFFNEJGQW1BNXM2Qm9BRTVPeFB0bDA1?=
 =?utf-8?B?SFF6UGc4eHRQblZRVVhiRWdiZUduTnA1MFNuMDZkTG9wMFQyU1dLbTM2bHNN?=
 =?utf-8?B?a2wxNCtRR3k3a1o0bk9uY2pYME5ENXYvSUNzbCtLQjdvenpYMXU0L1QxUDNy?=
 =?utf-8?B?Vm56THREWEx1RHJhcjBPMUwrODZWSWJCV2c1TTd1RzdyWTlJUzVBbjY1Rjh4?=
 =?utf-8?B?VFhzcFYydkV5TjFMVWFSemRxREdDTGsxa1JKN2FxcWRGbm4xd09KTkNyelc1?=
 =?utf-8?B?anNYZWsvV2JXRjBYc0ZEN1d0clcreFl6aGhSYVFva1FEZGtaVFZlQ3gxejBS?=
 =?utf-8?B?OUhZREdZNWZMR04yZlE0V09HSzlVQjVIOUZDci9iUWhJQUhMbTlscGtxajVq?=
 =?utf-8?B?Q3N4UFVQVHJKa3gyR1hEQloxL1lTVXNzU2cyT2dTTHlxVFY1UHRHdzlEQkpY?=
 =?utf-8?B?UDEvVXM4d2dWNmMzOEl6eUNkbzdoRVRiQ2FYblB4Lzc4dkpBTGJxeDV1ckg4?=
 =?utf-8?B?VWt4NWpyTkoyMDZMTC9vanAzTGRLQWlaekhoTXAvZU0yQ29INUJ0NHVjNXFR?=
 =?utf-8?B?bXovZEtEVVBLTGNiSVFFTHhEenVkNlJtRmpaL2plZkpRK2x3WGZSVmY4THJC?=
 =?utf-8?B?SHNZbjBiL0dVcTBrU2tMWDFybENjc2p0RmFIb2ZoK2cwRGJPNEdxcXlTQTNK?=
 =?utf-8?B?ZVdRcTZZZkhYVkU3RVJCNzlUN053QjNMVEtLaDc1cjNBL1VXVDhJWTJpU29K?=
 =?utf-8?B?VDVIS3NreVRPNkVVUCs4RHlVTHBEcFZtd3g1S0pTMXNIeC9JVDhZZGlzQTJJ?=
 =?utf-8?B?Tm9KWVFidlp2eXdURGdpaTVSWUtSQWJ0KzBwVktkSDFGekN4emhxclI3eWVw?=
 =?utf-8?B?RW0xbi9aMTFUQWNoaXNVWDJGeE01dzBMOHp1ajdiOXZQWUFmdTBzbDM2ZE1D?=
 =?utf-8?B?dUEzdTFiMzljSUVEbXVqOThjeC9MNmhsRGFrNWw3M0k1c2lXVFo5em1CNmcv?=
 =?utf-8?B?OFBTbDVySjlPODBsb21uVC9BNUhFek8weUpoVW93TDRGb2F4SWZBTEpTMHhX?=
 =?utf-8?B?a1gyVjBvaUoyNm8rOUJnSnFhMjdGTGhUeXIvbHAyQ0o0QTY5VFM4NmpuVm9I?=
 =?utf-8?B?Yjk1M25rVmdyVWd3VmZBYWI2Uzh3M0Q2MEJobjNMeWZlY211TDZPdUxnWS92?=
 =?utf-8?B?a2ljY0F5T1FOdjFlOEVONDN4TGVRenJ3M1loRjQ0aTlQcnFlQjdpNy9BUlFv?=
 =?utf-8?B?S1B1Z1dOM2p1V2xkQUozL1Z1U3RIcnEwcUx6Rkg2YWFoTzdQVGZGak84T0tE?=
 =?utf-8?B?MU1PMWw5QTAwNHhTSjdLRnBNWFNyYnFWY0JodXV0QmJQNHgwclhRbWlTajh3?=
 =?utf-8?B?b3M2MnhFQzFXY2lJanFzY2Z3Y09pVEw0Q2ROa2lvWHRST05rQkhmMmdXUWpk?=
 =?utf-8?B?SE4yb2F2MFlIZFAyMmV6YytSTzY1RzZyUXBxZHhFbUNoQ0F4bzVQUEZzQmJJ?=
 =?utf-8?B?b1c2RElKR0VzVWh6cXpvSXRCTmQ3QU5rcWtsdUFtaDZrWllscWNCWVloWUVh?=
 =?utf-8?B?ZEZCOUg3Rk9hTERiK3dFNzZqLzc3TjZlejFneWoyTzY1cUFZWUtrVllsUmZn?=
 =?utf-8?B?REp0c3RaUkZyLzFFRit2aXBKVUNiYXloZGdXZ0VNV2x1RjZVYzN4anFOV1RS?=
 =?utf-8?B?RHpIZkVLeGJYMzg5MmRCdXc0VWZKQjVkZjNvQmxhaXZQNUFVTktIRHFhRDZX?=
 =?utf-8?B?Yk5lc20wVWQvcnJ2MHRJYW9VVjBFSGVBTVVjekNGSVZPdkdnU0tFTVNQclFz?=
 =?utf-8?B?dHFpNG5WWnMzWTBzUW9OTktXamZ1YkhSL0cxZGMwb2RJTS9BLzlCNTF1Z0I4?=
 =?utf-8?B?UHlTYlZZbE1nTUJwOVpjekZ1UFhBZm5SMWp5QkV5R3AzN25kNlFTb3VVTk9p?=
 =?utf-8?B?a2wrMTAxaVZWSFkxSCsvaS9rZXRacnFRSWhoQXowV0s2TDJQci9oTFJ4Z3BS?=
 =?utf-8?B?OHZ6UmEvRzMyMHpJZ2I1R0lYYy95eFpITjNmdHZnTXVXOVBzb045bUI0ZXNx?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA686861E11C2D418EEC6974C7F9CD3F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed01691-3277-4f65-8329-08da5a40170b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 02:27:33.6758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x418V+HHghswalqNQ2/wzovdAmyhHxgmtxm4QfX9DObG5xlS4vICChUVrJGqs+Rvt6HMzko05HIuN9LKgdXVdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMjgsIDIwMjIgYXQgMDg6Mzg6MDhBTSArMDAwMCwgSE9SSUdVQ0hJIE5BT1lB
KOWggOWPoyDnm7TkuZ8pIHdyb3RlOg0KPiBPbiBNb24sIEp1biAyNywgMjAyMiBhdCAxMDoyNTox
M0FNIC0wNzAwLCBNaWtlIEtyYXZldHogd3JvdGU6DQo+ID4gT24gMDYvMjcvMjIgMDY6MDIsIEhP
UklHVUNISSBOQU9ZQSjloIDlj6Mg55u05LmfKSB3cm90ZToNCj4gPiA+IE9uIEZyaSwgSnVuIDI0
LCAyMDIyIGF0IDEyOjExOjA3UE0gLTA3MDAsIE1pa2UgS3JhdmV0eiB3cm90ZToNCj4gPiA+ID4g
T24gMDYvMjQvMjIgMDg6MzQsIEhPUklHVUNISSBOQU9ZQSjloIDlj6Mg55u05LmfKSB3cm90ZToN
Cj4gPiA+ID4gPiBPbiBGcmksIEp1biAyNCwgMjAyMiBhdCAwNDoxNToxOVBNICswODAwLCBNaWFv
aGUgTGluIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gMjAyMi82LzI0IDE2OjAzLCBNdWNodW4gU29u
ZyB3cm90ZToNCj4gPiA+ID4gPiA+ID4gT24gRnJpLCBKdW4gMjQsIDIwMjIgYXQgMTA6MjU6NDhB
TSArMDgwMCwgTWlhb2hlIExpbiB3cm90ZToNCj4gPiA+ID4gPiA+ID4+IE9uIDIwMjIvNi8yNCA3
OjUxLCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gPiA+ID4gPiA+Pj4gRnJvbTogTmFveWEg
SG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiA+ID4gPiA+ID4+DQo+ID4g
PiA+ID4gPiA+PiBJSVVDIGl0IG1pZ2h0IGJlIGJldHRlciB0byBkbyB0aGUgYmVsb3cgY2hlY2s6
DQo+ID4gPiA+ID4gPiA+PiAJLyoNCj4gPiA+ID4gPiA+ID4+IAkgKiBDYW5ub3QgcmV0dXJuIGdp
Z2FudGljIHBhZ2VzIGN1cnJlbnRseSBpZiBydW50aW1lIGdpZ2FudGljIHBhZ2UNCj4gPiA+ID4g
PiA+ID4+IAkgKiBhbGxvY2F0aW9uIGlzIG5vdCBzdXBwb3J0ZWQuDQo+ID4gPiA+ID4gPiA+PiAJ
ICovDQo+ID4gPiA+ID4gPiA+PiAJaWYgKGhzdGF0ZV9pc19naWdhbnRpYyhoKSAmJiAhZ2lnYW50
aWNfcGFnZV9ydW50aW1lX3N1cHBvcnRlZCgpKQ0KPiA+ID4gPiA+ID4gPj4gCQlnb3RvIG91dDsN
Cj4gPiA+ID4gPiA+ID4+DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBUaGUgY2hhbmdl
IGxvb2tzIGdvb2QgdG8gbWUuIEhvd2V2ZXIsIHRoZSBjb21tZW50cyBhYm92ZSBpcyB1bm5lY2Vz
c2FyeQ0KPiA+ID4gPiA+ID4gPiBzaW5jZSBnaWdhbnRpY19wYWdlX3J1bnRpbWVfc3VwcG9ydGVk
KCkgaXMgc3RyYWlnaHRmb3J3YXJkLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBBZ3JlZS4g
VGhlIGNvbW1lbnRzIGNhbiBiZSByZW1vdmVkLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoYW5r
IHlvdSwgYm90aC4gQWRkaW5nICFnaWdhbnRpY19wYWdlX3J1bnRpbWVfc3VwcG9ydGVkIHdpdGhv
dXQgY29tbWVudA0KPiA+ID4gPiA+IG1ha2VzIHNlbnNlIHRvIG1lLg0KPiA+ID4gPiANCj4gPiA+
ID4gVGhlIGNoYW5nZSBhYm92ZSBtYWtlcyBzZW5zZSB0byBtZS4gIEhvd2V2ZXIsIC4uLg0KPiA+
ID4gPiANCj4gPiA+ID4gSWYgd2UgbWFrZSB0aGUgY2hhbmdlIGFib3ZlLCB3aWxsIHdlIGhhdmUg
dGhlIHNhbWUgc3RyYW5nZSBzaXR1YXRpb24gZGVzY3JpYmVkDQo+ID4gPiA+IGluIHRoZSBjb21t
aXQgbWVzc2FnZSB3aGVuICFnaWdhbnRpY19wYWdlX3J1bnRpbWVfc3VwcG9ydGVkKCkgaXMgdHJ1
ZT8NCj4gPiA+ID4gDQo+ID4gPiA+IElJVUMsICFnaWdhbnRpY19wYWdlX3J1bnRpbWVfc3VwcG9y
dGVkIGltcGxpZXMgdGhhdCBnaWdhbnRpYyBodWdldGxiDQo+ID4gPiA+IHBhZ2VzIGNhbiBub3Qg
YmUgYWxsb2NhdGVkIG9yIGZyZWVkIGF0IHJ1biB0aW1lLiAgVGhleSBjYW4gb25seSBiZQ0KPiA+
ID4gPiBhbGxvY2F0ZWQgYXQgYm9vdCB0aW1lLiAgU28sIHRoZXJlIHNob3VsZCBORVZFUiBiZSBz
dXJwbHVzIGdpZ2FudGljDQo+ID4gPiA+IHBhZ2VzIGlmICFnaWdhbnRpY19wYWdlX3J1bnRpbWVf
c3VwcG9ydGVkKCkuDQo+ID4gPiANCj4gPiA+IEkgaGF2ZSB0aGUgc2FtZSB1bmRlcnN0YW5kaW5n
IGFzIHRoZSBhYm92ZS4NCj4gPiA+IA0KPiA+ID4gPiAgVG8gYXZvaWQgdGhpcyBzaXR1YXRpb24s
DQo+ID4gPiA+IHBlcmhhcHMgd2Ugc2hvdWxkIGNoYW5nZSBzZXRfbWF4X2h1Z2VfcGFnZXMgYXMg
Zm9sbG93cyAobm90IHRlc3RlZCk/DQo+ID4gPiANCj4gPiA+IFRoZSBzdWdnZXN0ZWQgZGlmZiBs
b29rcyBjbGVhcmVyIGFib3V0IHdoYXQgaXQgZG9lcywgc28gSSdkIGxpa2UgdG8gdGFrZSBpdA0K
PiA+ID4gaW4gdGhlIG5leHQgdmVyc2lvbi4gIFRoZW4sIHdoYXQgZG8gd2UgZG8gb24gdGhlICJp
ZiAoaHN0YXRlX2lmX2dpZ2FudGljKCkpIg0KPiA+ID4gY2hlY2sgaW4gcmV0dXJuX3VudXNlZF9z
dXJwbHVzX3BhZ2VzIGluIHRoZSBvcmlnaW5hbCBzdWdnZXN0aW9uPyAgU2hvdWxkIGl0DQo+ID4g
PiBiZSBrZXB0IGFzIGlzLCBvciByZW1vdmVkLCBvciBjaGVja2VkIHdpdGggIWdpZ2FudGljX3Bh
Z2VfcnVudGltZV9zdXBwb3J0ZWQoKT8NCj4gPiA+IEkgZ3Vlc3MgdGhhdCB0aGUgbmV3IGNoZWNr
cyBwcmV2ZW50IGNhbGxpbmcgcmV0dXJuX3VudXNlZF9zdXJwbHVzX3BhZ2VzKCkNCj4gPiA+IGR1
cmluZyBwb29sIHNocmlua2luZywgc28gdGhlIGNoZWNrIHNlZW1zIG5vdCBuZWNlc3NhcnkgYW55
IG1vcmUuDQo+ID4gDQo+ID4gTXkgZmlyc3QgdGhvdWdodCB3YXMgdG8ga2VlcCB0aGUgY2hlY2sg
aW4gcmV0dXJuX3VudXNlZF9zdXJwbHVzX3BhZ2VzKCkgYXMgaXQNCj4gPiBpcyBjYWxsZWQgaW4g
b3RoZXIgY29kZSBwYXRocy4gIEhvd2V2ZXIsIGl0IFNIT1VMRCBvbmx5IHRyeSB0byBmcmVlIHN1
cnBsdXMNCj4gPiBodWdldGxiIHBhZ2VzLiAgV2l0aCB0aGUgbW9kaWZpY2F0aW9ucyB0byBzZXRf
bWF4X2h1Z2VfcGFnZXMgd2Ugd2lsbCBub3QNCj4gPiBoYXZlIGFueSBzdXJwbHVzIGdpZ2FudGlj
IHBhZ2VzIGlmICFnaWdhbnRpY19wYWdlX3J1bnRpbWVfc3VwcG9ydGVkLCBzbw0KPiA+IHRoZSBj
aGVjayBjYW4gYmUgcmVtb3ZlZC4NCj4gPiANCj4gPiBBbHNvIG5vdGUgdGhhdCB3ZSBuZXZlciB0
cnkgdG8gZHluYW1pY2FsbHkgYWxsb2NhdGUgc3VycGx1cyBnaWdhbnRpYyBwYWdlcy4NCj4gPiBU
aGlzIGFsc28gaXMgbGVmdCBvdmVyIGZyb20gdGhlIHRpbWUgd2hlbiB3ZSBjb3VsZCBub3QgZWFz
aWx5IGFsbG9jYXRlIGENCj4gPiBnaWdhbnRpYyBwYWdlIGF0IHJ1bnRpbWUuICBJdCB3b3VsZCBu
b3Qgc3VycHJpc2UgbWUgaWYgc29tZW9uZSBmb3VuZCBhIHVzZQ0KPiA+IGNhc2UgdG8gZWFzZSB0
aGlzIHJlc3RyaWN0aW9uIGluIHRoZSBmdXR1cmUuICBFc3BlY2lhbGx5IHNvIGlmIDFHIFRIUCBz
dXBwb3J0DQo+ID4gaXMgZXZlciBhZGRlZC4gIElmIHRoaXMgaGFwcGVucywgdGhlIGNoZWNrIHdv
dWxkIGJlIG5lY2Vzc2FyeSBhbmQgSSB3b3VsZA0KPiA+IGd1ZXNzIHRoYXQgaXQgd291bGQgbm90
IGJlIGFkZGVkLg0KPiA+IA0KPiA+IFNvcnJ5IGZvciB0aGlua2luZyBvdXIgbG91ZCEhISAgQWx0
aG91Z2ggbm90IG5lY2Vzc2FyeSwgaXQgJ21pZ2h0JyBiZSBhIGdvb2QNCj4gPiBpZGVhIHRvIGxl
YXZlIHRoZSBjaGVjayBiZWNhdXNlIGl0IHdvdWxkIGJlIG92ZXJsb29rZWQgaWYgZHluYW1pYyBh
bGxvY2F0aW9uDQo+ID4gb2YgZ2lnYW50aWMgc3VycGx1cyBwYWdlcyBpcyBldmVyIGFkZGVkLiAg
SSBkbyBub3QgaGF2ZSBhIHN0cm9uZyBvcGluaW9uLg0KPiANCj4gT0ssIHNvIGxldCdzIGtlZXAg
dGhlIGNoZWNrLg0KDQpTb3JyeSwgSSBmb3VuZCB0aGF0IGtlZXBpbmcgdGhlIGNoZWNrIGRvZXNu
J3QgZml4IHRoZSBwcm9ibGVtLg0KSSdsbCB1cGRhdGUgdGhlIGNoZWNrIHdpdGggIWdpZ2FudGlj
X3BhZ2VfcnVudGltZV9zdXBwb3J0ZWQoKS4NCg0KLSBOYW95YSBIb3JpZ3VjaGk=
