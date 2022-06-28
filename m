Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D03A55DA93
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbiF1IVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244169AbiF1ITE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:19:04 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2053.outbound.protection.outlook.com [40.107.114.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1E62DAB8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvWMsYHwIxlJyHg8g5kic72As8Pt2sPcTWU++lAenAIQhdXZLir1kRxqkUP5PCeGvLcyV2FApyRpe9SqxaC258ZGhxJiCeCP9RVqA0en1i1rWay135xww2/gQppxSFX0exaWWL6sGdgrMh0bG+lFsiMbxUUv8/RjktkJqDQFOOn8MXAEYHT89G7uiOMI/3kKd6YK6GRuegkARjSjePwl4W0YXJYFw9nO+L2AibjL5PjxhjLkfPdt3q0yhlViVh+Yd80pWRXAkhza+MF6w8uu1JArMWaISw8YHgkJxlkVK1q/o66Lbx88Bpne8dmlkX4Uv1Cxfg8ckfHuOMpOTmZWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EZxq6PfsAjR6Sdjh3Q+brJN0hlCLlZGmvXsUFlswAI=;
 b=FwZZE0P/i10QVwMaO235c2dspZDdQP5VgYXLW9ogz14Ss03LH+VzX7fFxwf2h2VlA/vRilRAKoC0th/B6WERq5j9/pJ8ceN8ocEn4eHmCxnqcGxzyhvrmeYKFWC5HThaXXkr+YlvBWHPIxVNuQBvGeI/s5C2TzxBjBXwr+4/HCgEo9b0Eolo14eJEYhZ/b2dRibN3Akg6Igo7qp1s/8kQnWA2I2YWG5aCZA9wz2ZyOhkt/NMCI5OAxhpA0bFashOqJamGiIh61fYVYYk7kRj+ApyF4gXzLJRYk2PjNwBjp3YxT/rZi0ITTEBKoZL/90P4xoja7R5bZHNHo/j5bd7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EZxq6PfsAjR6Sdjh3Q+brJN0hlCLlZGmvXsUFlswAI=;
 b=jIcuKqHTZKxiOm9Ca5SJrkNFWhQAnAzFUusvrTh8bDk44PxMqIG9c9iADcjUTjQ4HANP59/2OsOgUVFztFaW04scvQPRu9XpZQzrsh8AcST+3M/WZk0AL8O6fSPS1+RP9az1YNjzKsA2lXPxx9UzxwWYRJqysj329HGtynTm8IM=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSZPR01MB8530.jpnprd01.prod.outlook.com (2603:1096:604:18b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 08:17:55 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 08:17:55 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/9] mm, hwpoison, hugetlb: support saving mechanism of
 raw error pages
Thread-Topic: [PATCH v2 4/9] mm, hwpoison, hugetlb: support saving mechanism
 of raw error pages
Thread-Index: AQHYh1xWx3aKvVOz4k2Yam/81HJ/PK1jARyAgAEhRYCAAD78gIAAHwsA
Date:   Tue, 28 Jun 2022 08:17:55 +0000
Message-ID: <20220628081754.GA2206088@hori.linux.bs1.fc.nec.co.jp>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-5-naoya.horiguchi@linux.dev>
 <Yrl3qT3V6s9pLuvr@FVFYT0MHHV2J.usts.net>
 <20220628024121.GF2159330@hori.linux.bs1.fc.nec.co.jp>
 <YrqfJ5wHXIEdu4BM@FVFYT0MHHV2J.usts.net>
In-Reply-To: <YrqfJ5wHXIEdu4BM@FVFYT0MHHV2J.usts.net>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5caf88fe-53c9-43b1-966f-08da58deb435
x-ms-traffictypediagnostic: OSZPR01MB8530:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dNsOddjOx6w45xg9ibOz0L0rLYuMf752w3zwAcWYD4c9rU9Ft9ShO+6LZZsDeCcLoG+M5AHemhik0rzo+purB0x8hy4Zy81ngbFzvrHWxnF2mn4V3Gep405sftOWhJ/QcvauJ0++UEzoiy0BV9HIGm6DfFoGL6ych767VWcjUWtCLHpKbbMTse/pCRywUNO+4iSnlO3iH5/2BpX+sP6sO5kJFqOb4fFM4WLAsDyGKrZDDT//FJmCo28erLJV4mRHsglL++jCQc2wCX810qxgT4zeQBix4W+k2DpXFm7Cs9PTkPL8Kjy/HXoElOKZXvhfDMo5+CmVT7fBgnJ1/boEmdUvPo5shZblwzvuKipUanaKmSGa0ZU0+TVAvCMmCBX8Ie5Zo6LTYW0zyFNCBbXsvpX/Nj8qJ3gnt/eg9jDUND/22ZFs7txkovCYfco+UFGTzaGp1eZZ7XO8f3Ln/zD22ZvRANU87JAqR2Vb2URZbW2e8zjJ2u5F3XOnxNHmVl43KZ9K24cYAHb1q8Y2GhLiGdR0Dzoh6cw+hUZaKPxH7RKpT0mwicy/x4mTZCs2YUYvN6HQ78kqiMCI0xujotOhcpaCawxBwLgqYxISWmu1NypFS7zwbFo08/0O9Z40QStwBYs9AVT1dhW4jYF8BfdsMpXBAxYzJyVIDzxYgHnsDKkWt48tiej4Vn/xt7Kzv8CTVAP9ToEeYjrK4f3ckzh4FCZOIKoVGO2dSvayCVFg9kFV26l5WBtSlnLu6UGuWmvhWSiCnfdFNLwU8s08jgcnJ+fwpEpvsAhOfE5OYJKxx5I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(55236004)(83380400001)(186003)(41300700001)(6916009)(8676002)(6506007)(54906003)(1076003)(26005)(9686003)(38070700005)(6512007)(82960400001)(64756008)(66946007)(33656002)(4326008)(38100700002)(85182001)(7416002)(86362001)(2906002)(5660300002)(76116006)(478600001)(6486002)(8936002)(122000001)(66476007)(316002)(71200400001)(66446008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTlndmVoaGVXdFFUREFLL0hWRm5ManhtN1c4TmpDOVd3cTYwVXJMN2pzbVhQ?=
 =?utf-8?B?QnZTa0tCbEM4bks2MmZKY0dOSmFnVlJLZmJsakIyb3dXWkJzb0V4L2M4N0xi?=
 =?utf-8?B?R3ZFbmlCcnZxMW1KV2dPLzh1NG1haGtyckdDYXZzajU0L2Vwb2UxUHVRVVQ2?=
 =?utf-8?B?d29UNTJzYlljME9mZTFKK3Q0MTJlRHdybmxiTEIwcDBGcFlXUW1sU3lHM3o3?=
 =?utf-8?B?SEdWdXhzWXJHUlU2RjlBL1hSdkNpZU1qTVhzWVFjYlVUaS9aaDJhYkpiRFF4?=
 =?utf-8?B?UE44SDVhay96ZFJtUC8vUERrcTcrY3RrOUhBTzFGbmk0L2RjR21RUjBvTFha?=
 =?utf-8?B?NnpsbjAzNkN2aVZxelUwc25KVW1UU0R6TVVuSXZUUXVQMmh0clZYYk8zRDdt?=
 =?utf-8?B?MVBpbHFFcXRFOURUQUd5NzFHNzc2VGt2SkgvQnU1ZWRlYW1XRTFubzdiSWdC?=
 =?utf-8?B?bUVJdmZoR0lHSFN2eU5aanNodGRIVmwxdStKcWwycGNZSFRaUFpzZkdlYkFM?=
 =?utf-8?B?Y3ZuMmhsYndkbnl6cFEwaWhqWTNvWXhiNURVcmxGQ3hwUUJCQVNpa1N6cVRL?=
 =?utf-8?B?Z2lCZitlOVN4cEdYSlUyNVVFVlY4YUV6dm5iTGt4RDdoSm5VRC9FRlFETkxo?=
 =?utf-8?B?akt4a3hwMnp6OVkxa1pibitOR1NCK1VkUUxQU0J2bEw3UWJiUTdHdlhpNjYy?=
 =?utf-8?B?OUFEV2NFM21oblZCS3BGWHFLK1NsK2taczlabG5WNWFXdGR0S0ZVWStJWkh6?=
 =?utf-8?B?SVJmd29TMGFmeCtFK1ljRHN2WWJlaWlFOUdGWGg3b01OQkdiZXk2Wk00K2lI?=
 =?utf-8?B?KzNscCtpUU8rOUF3Q2dpWWNxbDJBNmtjeFhVV3VjZTYxNjkwelVTd250WHdN?=
 =?utf-8?B?MFZ1QnlZakRUWGZOSTZmM2lkd0UyRno1YjJobE8zTEdrZkZ4SzlWY0oralV0?=
 =?utf-8?B?THN6T3VUTVNOV3FFV0lNemhjc0c5Tjg2akhjeHNhOG12STc0dFpxbHFuNXVs?=
 =?utf-8?B?eEI5Wkkvb3NQT3hIRGhzUzNxQWRFZjg5bDd4ZWgrVmlGaHdlYVRsS1N6SnM1?=
 =?utf-8?B?TUJwNUNiR0tndnpBd0RTY0VGWEZOL29QLzhnZ3V1MlZqayt5NGNXdnd4Q2tF?=
 =?utf-8?B?Qkt1TGV2SXN0U091WWo3TGVUUGhJTUxxbUptWHdKNXAxZUl3bFZVa01zSlV3?=
 =?utf-8?B?dnJRcVRLNXptZ1lXb3dEU0NKbEJMUkxjY2VBNnJmckRZZmU0T0l5TGg4SC96?=
 =?utf-8?B?V3BoOFg2QTN4clU2cjRWMjQwMmRlMjJWb05OY0tKYUJweStXVXIxRjlUc00w?=
 =?utf-8?B?S3puTWgxNEQ0RHp6bmVOOW5CK2hLT1BlN0JlQ1R2bU55YndhOXVIS2NLRlFr?=
 =?utf-8?B?VXUyckc2V0JCcld0RHJGcEptdXVCUnZYa3M3dUZpVTN0UzIzY0p5WjFOZElF?=
 =?utf-8?B?NjZySzNhcmJlblRpRXF1Zkx6dXVLUkZYeWloVzFDV21KZDZWUzhuOWdKWnNT?=
 =?utf-8?B?QUFFU2h6ZnViN2xoWlA0WGE5M29UYkFYWUZLYlRaajkvckRnTDlOSy9NbkJl?=
 =?utf-8?B?VkU4c2NpQXR2RlFmWHU4MzJ2cE9CYjlPL1VoWGpPYmRZcW1JY2IwVDFhdWh4?=
 =?utf-8?B?RkdUTjJPWG92SUJyNHQxRkZiYnpnaUhybXMxNlZzVGhySzhheDV0WEEwU1Fi?=
 =?utf-8?B?V2tLNkdNWVhKZWE0Vzh6d1NrSjVNNVd5RmpHaGV4UjBPalhaSzlMVUR4WE4y?=
 =?utf-8?B?RGdPS3VGMmQxVFFFcE1oTTE3VlRJbktkNUtMVHpKVG1pQ2ttK3ZmKytLQUI4?=
 =?utf-8?B?SVVnZCtFSzQ5cXBTQ3dSTVFHWithWmY3RUtSemZPV1NpWEVoekc1R3dSbnZ2?=
 =?utf-8?B?MGFERTFZVU1jUUNLck1wWXFzNTB5ajFPanFpM0pFMFNDWTl2bmxjempEOVJC?=
 =?utf-8?B?NGM2UlRVOGY4aFVxLzJ0bVh5QUJIQ1NlYVZLNHorb1E3WEFaMVRjZ1Nhb1Np?=
 =?utf-8?B?Y3QzTEZhM1FNdS9KMlJrSnNOYVRvcVI1WW93QkdHeUVpUUxKMWRxb1dndENr?=
 =?utf-8?B?dGEzS2tTTlBvN0xiY1hteE1lbmVxQ3JEMEphTEk5aFZveS80bFk0empkb1Rx?=
 =?utf-8?B?VFBlRUNLZkZMTWQyYVFzbVNPSGlHb1MvbEJSa1lEZmx3bnJHSFc5QWNiaGFt?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1D4E4A63DD1DA478F1B5EE8742DCB54@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5caf88fe-53c9-43b1-966f-08da58deb435
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 08:17:55.5428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kMBXdg7m+Fo/fCgy0iwsW97r1u4KId6BPo/qHmytIyIx6PX6SF7f9JsVoxoBUwmb4HBr1ig20W1tusxmAdjt6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8530
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMjgsIDIwMjIgYXQgMDI6MjY6NDdQTSArMDgwMCwgTXVjaHVuIFNvbmcgd3Jv
dGU6DQo+IE9uIFR1ZSwgSnVuIDI4LCAyMDIyIGF0IDAyOjQxOjIyQU0gKzAwMDAsIEhPUklHVUNI
SSBOQU9ZQSjloIDlj6Mg55u05LmfKSB3cm90ZToNCj4gPiBPbiBNb24sIEp1biAyNywgMjAyMiBh
dCAwNToyNjowMVBNICswODAwLCBNdWNodW4gU29uZyB3cm90ZToNCj4gPiA+IE9uIEZyaSwgSnVu
IDI0LCAyMDIyIGF0IDA4OjUxOjQ4QU0gKzA5MDAsIE5hb3lhIEhvcmlndWNoaSB3cm90ZToNCj4g
PiA+ID4gRnJvbTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCi4u
Lg0KPiA+ID4gPiArCX0gZWxzZSB7DQo+ID4gPiA+ICsJCS8qDQo+ID4gPiA+ICsJCSAqIEZhaWxl
ZCB0byBzYXZlIHJhdyBlcnJvciBpbmZvLiAgV2Ugbm8gbG9uZ2VyIHRyYWNlIGFsbA0KPiA+ID4g
PiArCQkgKiBod3BvaXNvbmVkIHN1YnBhZ2VzLCBhbmQgd2UgbmVlZCByZWZ1c2UgdG8gZnJlZS9k
aXNzb2x2ZQ0KPiA+ID4gPiArCQkgKiB0aGlzIGh3cG9pc29uZWQgaHVnZXBhZ2UuDQo+ID4gPiA+
ICsJCSAqLw0KPiA+ID4gPiArCQlzZXRfcmF3X2h3cF91bnJlbGlhYmxlKGhwYWdlKTsNCj4gPiA+
ID4gKwkJcmV0dXJuIHJldDsNCj4gPiA+ID4gKwl9DQo+ID4gPiA+ICsJcmV0dXJuIHJldDsNCj4g
PiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+ID4gPiAraW5saW5lIGludCBodWdldGxiX2NsZWFyX3Bh
Z2VfaHdwb2lzb24oc3RydWN0IHBhZ2UgKmhwYWdlKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArCXN0
cnVjdCBsbGlzdF9oZWFkICpoZWFkOw0KPiA+ID4gPiArCXN0cnVjdCBsbGlzdF9ub2RlICp0LCAq
dG5vZGU7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlpZiAocmF3X2h3cF91bnJlbGlhYmxlKGhwYWdl
KSkNCj4gPiA+ID4gKwkJcmV0dXJuIC1FQlVTWTsNCj4gPiA+IA0KPiA+ID4gSUlVQywgd2UgdXNl
IGhlYWQgcGFnZSdzIFBhZ2VIV1BvaXNvbiB0byBzeW5jaHJvbml6ZSBodWdldGxiX2NsZWFyX3Bh
Z2VfaHdwb2lzb24oKQ0KPiA+ID4gYW5kIGh1Z2V0bGJfc2V0X3BhZ2VfaHdwb2lzb24oKSwgcmln
aHQ/IElmIHNvLCB3aG8gY2FuIHNldCBod3BfdW5yZWxpYWJsZSBoZXJlPw0KPiA+IA0KPiA+IFNv
cnJ5IGlmIEkgbWlnaHQgbWlzcyB5b3VyIHBvaW50LCBidXQgcmF3X2h3cF91bnJlbGlhYmxlIGlz
IHNldCB3aGVuDQo+ID4gYWxsb2NhdGluZyByYXdfaHdwX3BhZ2UgZmFpbGVkLiAgaHVnZXRsYl9z
ZXRfcGFnZV9od3BvaXNvbigpIGNhbiBiZSBjYWxsZWQNCj4gDQo+IFNvcnJ5LiBJIGhhdmUgbWlz
c2VkIHRoaXMuIFRoYW5rcyBmb3IgeW91ciBjbGFyaWZpY2F0aW9uLg0KPiANCj4gPiBtdWx0aXBs
ZSB0aW1lcyBvbiBhIGh1Z2VwYWdlIGFuZCBpZiBvbmUgb2YgdGhlIGNhbGxzIGZhaWxzLCB0aGUg
aHdwb2lzb25lZA0KPiA+IGh1Z2VwYWdlIGJlY29tZXMgdW5yZWxpYWJsZS4NCj4gPiANCj4gPiBC
VFcsIGFzIHlvdSBwb2ludGVkIG91dCBhYm92ZSwgaWYgd2Ugc3dpdGNoIHRvIHBhc3NpbmcgR0ZQ
X0FUT01JQyB0byBrbWFsbG9jKCksDQo+ID4gdGhlIGttYWxsb2MoKSBuZXZlciBmYWlscywgc28g
d2Ugbm8gbG9uZ2VyIGhhdmUgdG8gaW1wbGVtZW50IHRoaXMgdW5yZWxpYWJsZQ0KPiANCj4gTm8u
IGttYWxsb2MoKSB3aXRoIEdGUF9BVE9NSUMgY2FuIGZhaWwgdW5sZXNzIEkgbWlzcyBzb21ldGhp
bmcgaW1wb3J0YW50Lg0KDQpPSywgSSd2ZSBpbnRlcnByZXR0ZWQgdGhlIGNvbW1lbnQgYWJvdXQg
R0ZQX0FUT01JQyB3cm9uZ2x5Lg0KDQogKiAlR0ZQX0FUT01JQyB1c2VycyBjYW4gbm90IHNsZWVw
IGFuZCBuZWVkIHRoZSBhbGxvY2F0aW9uIHRvIHN1Y2NlZWQuIEEgbG93ZXINCiAqIHdhdGVybWFy
ayBpcyBhcHBsaWVkIHRvIGFsbG93IGFjY2VzcyB0byAiYXRvbWljIHJlc2VydmVzIi4NCiANCg0K
PiA+IGZsYWcsIHNvIHRoaW5ncyBnZXQgc2ltcGxlci4NCj4gPiANCj4gPiA+IA0KPiA+ID4gPiAr
CUNsZWFyUGFnZUhXUG9pc29uKGhwYWdlKTsNCj4gPiA+ID4gKwloZWFkID0gcmF3X2h3cF9saXN0
X2hlYWQoaHBhZ2UpOw0KPiA+ID4gPiArCWxsaXN0X2Zvcl9lYWNoX3NhZmUodG5vZGUsIHQsIGhl
YWQtPmZpcnN0KSB7DQo+ID4gPiANCj4gPiA+IElzIGl0IHBvc3NpYmxlIHRoYXQgYSBuZXcgaXRl
bSBpcyBhZGRlZCBodWdldGxiX3NldF9wYWdlX2h3cG9pc29uKCkgIGFuZCB3ZSBkbyBub3QNCj4g
PiA+IHRyYXZlcnNlIGl0ICh3ZSBoYXZlIGNsZWFyZWQgcGFnZSdzIFBhZ2VIV1BvaXNvbik/IFRo
ZW4gd2UgaWdub3JlZCBhIHJlYWwgaHdwb2lzb24NCj4gPiA+IHBhZ2UsIHJpZ2h0Pw0KPiA+IA0K
PiA+IE1heWJlIHlvdSBhcmUgbWVudGlvbmluZyB0aGUgcmFjZSBsaWtlIGJlbG93LiBZZXMsIHRo
YXQncyBwb3NzaWJsZS4NCj4gPg0KPiANCj4gU29ycnksIGlnbm9yZSBteSBwcmV2aW91cyBjb21t
ZW50cywgSSdtIHRoaW5raW5nIHNvbWV0aGluZyB3cm9uZy4NCj4gDQo+ID4gICBDUFUgMCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBDUFUgMQ0KPiA+IA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZnJlZV9odWdlX3BhZ2UNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbG9jayBodWdldGxiX2xvY2sNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgQ2xlYXJIUGFnZU1pZ3JhdGFibGUNCj4gCQkJCSAgICAgICBy
ZW1vdmVfaHVnZXRsYl9wYWdlKCkNCj4gCQkJCSAgICAgICAvLyB0aGUgcGFnZSBpcyBub24tSHVn
ZVRMQiBub3cNCg0KT2gsIEkgbWlzc2VkIHRoYXQuDQoNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdW5sb2NrIGh1Z2V0bGJfbG9jaw0KPiA+ICAgZ2V0X2h1Z2VfcGFn
ZV9mb3JfaHdwb2lzb24NCj4gPiAgICAgbG9jayBodWdldGxiX2xvY2sNCj4gPiAgICAgX19nZXRf
aHVnZV9wYWdlX2Zvcl9od3BvaXNvbg0KPiANCj4gCS8vIGNhbm5vdCByZWFjaCBoZXJlIHNpbmNl
IGl0IGlzIG5vdCBhIEh1Z2VUTEIgcGFnZSBub3cuDQo+IAkvLyBTbyB0aGlzIHJhY2UgaXMgaW1w
b3NzaWJsZS4gVGhlbiB3ZSBmYWxsYmFjayB0byBub3JtYWwNCj4gCS8vIHBhZ2UgaGFuZGxpbmcu
IFNlZW1zIHRoZXJlIGlzIGEgbmV3IGlzc3VlIGhlcmUuDQo+IAkvLw0KPiAJLy8gbWVtb3J5X2Zh
aWx1cmUoKQ0KPiAJLy8JdHJ5X21lbW9yeV9mYWlsdXJlX2h1Z2V0bGIoKQ0KPiAJLy8JaWYgKGh1
Z2V0bGIpDQo+IAkvLwkJZ290byB1bmxvY2tfbXV0ZXg7DQo+IAkvLwlpZiAoVGVzdFNldFBhZ2VI
V1BvaXNvbihwKSkgew0KPiAJLy8JLy8gVGhpcyBub24tSHVnZVRMQiBwYWdlJ3Mgdm1lbW1hcCBp
cyBzdGlsbCBvcHRpbWl6ZWQuDQo+IAkNCj4gU2V0dGluZyBDT01QT1VORF9QQUdFX0RUT1IgYWZ0
ZXIgaHVnZXRsYl92bWVtbWFwX3Jlc3RvcmUoKSBtaWdodCBmaXggdGhpcw0KPiBpc3N1ZSwgYnV0
IHdlIHdpbGwgZW5jb3VudGVyIHRoaXMgcmFjZSBhcyB5b3UgbWVudGlvbmVkIGJlbG93Lg0KDQpJ
IGRvbid0IGhhdmUgY2xlYXIgaWRlYXMgYWJvdXQgdGhpcyBub3cgKEkgZG9uJ3QgdGVzdCB2bWVt
bWFwLW9wdGltaXplZCBjYXNlDQp5ZXQpLCBzbyBJIHdpbGwgdGhpbmsgbW9yZSBhYm91dCB0aGlz
IGNhc2UuIE1heWJlIG1lbW9yeV9mYWlsdXJlKCkgbmVlZA0KZGV0ZWN0IGl0IGJlY2F1c2UgbWVt
b3J5X2ZhaWx1cmUoKSBoZWF2aWxpeSBkZXBlbmRzIG9uIHRoZSBzdGF0dXMgb2Ygc3RydWN0DQpw
YWdlLg0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGkNCg0KPiANCj4gVGhhbmtzLg0KPiAJDQo+
ID4gICAgICAgaHVnZXRsYl9zZXRfcGFnZV9od3BvaXNvbg0KPiA+ICAgICAgICAgYWxsb2NhdGUg
cmF3X2h3cF9wYWdlDQo+ID4gICAgICAgICBUZXN0U2V0UGFnZUhXUG9pc29uDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVwZGF0ZV9hbmRfZnJlZV9wYWdlDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX191cGRhdGVfYW5kX2ZyZWVf
cGFnZQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKFBh
Z2VIV1BvaXNvbikNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaHVnZXRsYl9jbGVhcl9wYWdlX2h3cG9pc29uDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgVGVzdENsZWFyUGFnZUhXUG9pc29uDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8gcmVtb3ZlIGFsbCBsaXN0
IGl0ZW1zDQo+ID4gICAgICAgICBsbGlzdF9hZGQNCj4gPiAgICAgdW5sb2NrIGh1Z2V0bGJfbG9j
aw0KPiA+IA0KPiA+IA0KPiA+IFRoZSBlbmQgcmVzdWx0IHNlZW1zIG5vdCBjcml0aWNhbCAobGVh
a2luZyByYWNlZCByYXdfaHdwX3BhZ2U/KSwgYnV0DQo+ID4gd2UgbmVlZCBmaXgu
