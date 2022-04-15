Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30652502052
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348586AbiDOCPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiDOCPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:15:03 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2069.outbound.protection.outlook.com [40.107.114.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1614D1A393
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZNtigG29Megepk71uNF3EbzEPUtdHn66JbZUmHSySXXfmhCbAfTXVAHdWgFJfDyhWg3snzye/BvPscC53X+oMEFGhulmmqjZmHla0zf1WRYAnHt9TqpsNdJfGR7j513DCaNQFKCGIoC0okgfYomBvKux1BXX6RnwJnbijtkHzJmTsyxQprduwEty2/Iyg2KL5+5az01lVucVifHQ3ohdLoWuZxi6s0NO51q/X4db0ChEGEM4dSrJr4A7xUqowKZMUMlkQApRmq0FT4MNu040WiRhWqQqk7eAO+NNDVvB6w0NWFudgUCap/qI9yu+vtSc8egMKJjIRtulWynM0S9Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hauuSOjuPWVbh3G6lnkLLj+BNbuYwZNWy2YJxlw4xL4=;
 b=il4uyIP52CMph9GIGkKvOdFRFt4rq1b55s06fxeka82SuScs8RMYEiYRhIWMV0BQnWA1ZuIi0kQqYUSA1jtYQRGGkmyQRV9JjKxBN+a5pOKdSR33aKe7eekvo30nkhbEChdtox+uJ3JESY/uwRiKydFGJRaKepj5sTBb+qTMuTGQU9bEZalir/4lRO792GTXnjH2ODmX1rE+nue/3wWLJyt/6reIb0cokIoldTxz8JSa4vG4Lad/Nviy4Co7Wj0gS1aL8cGSJvlWy1+Ea7c9SMeTUwkzH7a35toNXPAw4LG/x6+6/V+5Mq8bzJ+bOQsrkSbKRkfZaG1Thp0nc2MDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hauuSOjuPWVbh3G6lnkLLj+BNbuYwZNWy2YJxlw4xL4=;
 b=i/XZBTH9ZtloEYtPLKZHZVeAMA04EValwMTVDLZjQHwJL+o+vaCD9jmKwGM65Dw3XJrZcJ1E7oH9eeRm4e7/5ZFXEDkThJDOLuBZZPHpQ593HKj1ALEVDRYMZyHelS+Ms1b1a0oOWenorGlKCEDXgw1XZV/rg9mN7G43QJDna/c=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB2999.jpnprd01.prod.outlook.com (2603:1096:604:14::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.19; Fri, 15 Apr
 2022 02:12:34 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232%8]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 02:12:34 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/3] mm/hwpoison: fix race between hugetlb
 free/demotion and memory_failure_hugetlb()
Thread-Topic: [PATCH v8 1/3] mm/hwpoison: fix race between hugetlb
 free/demotion and memory_failure_hugetlb()
Thread-Index: AQHYS1APap+CaWci6kuFChnJ9jYdaqzvu1+AgACFsgCAAATXgA==
Date:   Fri, 15 Apr 2022 02:12:34 +0000
Message-ID: <20220415021233.GA3357039@hori.linux.bs1.fc.nec.co.jp>
References: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
 <20220408135323.1559401-2-naoya.horiguchi@linux.dev>
 <5b665bcd-57f8-85ae-b0c4-c055875dbfff@oracle.com>
 <20e677e5-01aa-f8c0-0ce1-bf33da58b7ec@huawei.com>
In-Reply-To: <20e677e5-01aa-f8c0-0ce1-bf33da58b7ec@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ef97646-83d8-4823-2ac5-08da1e85677c
x-ms-traffictypediagnostic: OSBPR01MB2999:EE_
x-microsoft-antispam-prvs: <OSBPR01MB2999B41D15E53C117CF59560E7EE9@OSBPR01MB2999.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jhG8KLq7sG48Ppt2hJTgWTaSp1i5terR8TH6eO06SXB6tzYBINRRHP/D87dJGa+lrZ8Y3a2meFZB/HkJEj+8EOGHt8lnTXOczdr+Mv1Jz4tBZYGQoRVVtg9E6Ac8DG2GRpYZFaIX8nQFPmRwMzgciAibnhlcUNa9PAoIdMzpBwOW7oXxGgvckQ0+DEr+ZDPTkTE26wTiHblbtWUH+3ZODrTITGLz0Z13onspEY1fIrdJaxGRPeV4+tRV6bJsKLCTemMppvgK/FCAhbEdDcjK6tol7ut5O8bVURcC//b1uDDZfkSQfASFmZ1tmYfUagLo2qEkC+3tsQiHdZUq1ddFuBcLiWmEdHLFJAh002VbVjxxfzzfN2fA35f3BtXbVt+0VhMI2iCFnVt0Y2ipmT4GiLdu/27Lvu2ICFhiiLWFfpg333boRPy81Lr617kwt7p1vWw5S8fy5YDaSx1Z7L3jFfq+E/u3hn2/7ZAfE6dUqxSUIO5Bd+B3n6sDI8a2vux3TL58vzAUUZmDqIqdI0dG7HMOTvlYdVDXLZdOBJ3lqmad21K9zyG9HSSrJVITiTKDkZ7PntnMC3/KpX/7uuKjNcXGeH07hOIccepDZvgf5/dN7QcqOSYffma87mBkR2oBLGQJ2SZEZ5fM2gg00pbZHUUU4Vn/4BUJnaFm4TyOPdTahgeaSl2UVq9ZDVMh1oHtQPmpj8V939fzZ+i43EJ3wA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(4326008)(66946007)(76116006)(122000001)(38100700002)(53546011)(66556008)(8676002)(64756008)(86362001)(71200400001)(6486002)(82960400001)(66476007)(38070700005)(110136005)(54906003)(508600001)(26005)(186003)(316002)(83380400001)(9686003)(55236004)(6506007)(1076003)(2906002)(5660300002)(8936002)(85182001)(33656002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE00U2RiN3EwU2dMT2JqRktpaTVaUEsxWHI4R0JkSUtxR3Fsa2tHYXUvdHZX?=
 =?utf-8?B?ekI4cm9sTWRwVEEvK3dOV0pzalNldUpmaS9YV2hTN3QrTHRPcVJUbUovRGNo?=
 =?utf-8?B?cXRYNU52UUFqMWRrUVZnYlVzNlkzRStCZ0MyRVhpQWlVSWNDb01yZm9hM0RS?=
 =?utf-8?B?ZjBWaldUM3ZZb0xPb28vZ0pCOUpqSGx5Y2MrYlFLODZ4ZC95NjhzNUEzNWVz?=
 =?utf-8?B?Vm9LTzl0L2p5c3VEREhBbzhheEJxYU45S0svZTFYT2dWV29VczljdWFYTngx?=
 =?utf-8?B?WS9hNHhVc21xdTRRZGNtN2hZMVlCLzlWa3NNWW9KSmhZN29PVVpKSVZrK2w5?=
 =?utf-8?B?amdWMlJyV3VVVWdZeTJnT0Z2ZWNaWXBaQmFqOGF3RlVpTTh5em0xclprblV1?=
 =?utf-8?B?b2x1NlBMUXJwUDh3SCtxV1pIa3luNHpvdXFTQjBQWFBsSzNCWlRLUEp0TlNR?=
 =?utf-8?B?NHFZT0R1QitOeFpXNkNOdHBMcnFjN1dDS3pRZUlHRjV2WlhmdU9xL1M1OHVZ?=
 =?utf-8?B?OUJVSllzbTkwU1ZiM1pZZ3hESVRYYWF4MStHRlFObmtDM3gzbUh3Y01talYv?=
 =?utf-8?B?amJwN084N3BEZkIyRENGQ2xiNkFSN3NpTXNYcVpPMFlCMmFTNzBvNkpqYmtQ?=
 =?utf-8?B?akZ3K2JvUSs5ZDdtMlFrWms2YmFPNmMxUlZLZWVDMCtLNVJCS0xYdDNZWU5w?=
 =?utf-8?B?VTRGK2tIaDBUVWh2Y09nUGtJc1YxSVpDUW84WW5ROGR5WHNSWVFpaEZlV2Ry?=
 =?utf-8?B?VUNlcktpMElqbnI5NVl1dlAyQlkxL2pwSS90OGFWOStRdmhuNnB5c0hrRHBY?=
 =?utf-8?B?ektDdXBlMTNOdGRBbkkxNmdMNnAvNGZ4Q05ndEtYUERla3JOSGZuSVVzSHI5?=
 =?utf-8?B?Q3YwSkF6WDRYVFEyUEtpYUFLeE1KeGlkRDlUeHdvK1JWRGUvbVNZMmZUSlZE?=
 =?utf-8?B?dkhScnV1TGpwZEFZM1kzQ0VGUk9tTjVHTkhHR3V2NDNEQ041TzMwSHNxRE1D?=
 =?utf-8?B?SkJpODhYK0VZMmlUL29ZOEc3ZnpSUUdkbXFDOWNjenR0MjlBZk5nNW1MY3BB?=
 =?utf-8?B?eXFodittQjZhdFlhOS9uVTc1eHlSdk1TU1dzSjEyM1hXM2hzUDZ6RUpCY3NZ?=
 =?utf-8?B?MmNvNXlHL1k5S3VheW1ibjFsKzZ4KzFuOXhMWDYzUTZLNTR1MVZaZTBXbUdl?=
 =?utf-8?B?M3RRdDlLV3BRbnovakI5S1pKaXdqVXlXdXJ5Q3dlVFlrN1FSNEpWSUdmcmxo?=
 =?utf-8?B?b0d4MGdMM28raUU5ZzBOVFoyL05Ua0lNT3J1c0VOZVhCOGk1VmZhcU94bEhX?=
 =?utf-8?B?MHNUK1NQS0FuNFl2T3VySGF6WFMvQ3dPd1prMDZac1ZnMndSWnJ3LzJZc2RV?=
 =?utf-8?B?cDhjeTE5YUViRVl1dHZWTW1ZL0Nnc2RHVUN2cWc2b2pjWnBFc3ZORUlNWm1Y?=
 =?utf-8?B?aEpqS21sOEpDZnNGYk15RVV3Z1BZN052SzZKV0FuTFlNYmNzWXc3WFM3Qzh0?=
 =?utf-8?B?b3VXUXRpbDVQMEovWDhvTGJaTmlTaFYreHdmYjIwTlM1QU1Tdk5EMUU5VFpt?=
 =?utf-8?B?NTRENGdDTUthSWErd2p6K04zcHJ0OExxOEdXODJnUzduTkFwUHF3N3VpNFZQ?=
 =?utf-8?B?N3FpdHEvbzZ0Zk1WM2xRSC9JZ1RwWW5FZ3Y2YUlVcStoRTJHMzdRQlJtc1Uy?=
 =?utf-8?B?dkk0THp0NWFjbVVzTHJZdmcvby9LdDI4L0F6R2xGS0o2MHV6Z25CZGtKaEZw?=
 =?utf-8?B?Ti82cms5YmdHNU9jRUt1d1U3bEhNek83djJ1SE15VVhiOTRGRDMrRnV6clVv?=
 =?utf-8?B?QSszT0JqUWliRjZqc29aY0hBZXZhdlR1cGxyS1NRY0NkdmcxWldZYUhqNlJa?=
 =?utf-8?B?ZEN4QVZXSENaV3M3S29NTWlQMVJaV1UzZDA5OUxLWk9mN2FzVVBuOEZmWDBn?=
 =?utf-8?B?b0M2YjlNTS9aemNDekU4Q0VGbmI5OVMzQ2crMXhybzIyNGQydG9TTUFPMzV3?=
 =?utf-8?B?NVJ4c3VmSitlY292S1E4NnhyZnRERXQwTHR2M2ZnM1UyYWc5TnZKZUhvMDM4?=
 =?utf-8?B?Qit4c1prRTR2RUF5b0tqZVBQTG9qRWF0TkNnVUtzemx5V2pjUG93UUZ5Slhl?=
 =?utf-8?B?bXR6ZU9pQmVKNWFWL0dXUTUvcUtHY0QxS1dzMjRpZTViQlNGNlNNZTJxeVdJ?=
 =?utf-8?B?Q29KL3d4V1VRL21makFNbEtjUno2QVVLRklkaEVwQUVZRTBlcENBRk5mTTIw?=
 =?utf-8?B?YUZvVFpTbkNsOTl2RGVMY05ORUlXYlh1UHp2SDY3NlRGNnVFZEF1WjA4MDVq?=
 =?utf-8?B?Vk5ZTWlQbW84NjBqTXhhckpVamUxTHZ0QTVFcFFEeGlZMFU3dXVONjdIT2Ri?=
 =?utf-8?Q?Gkr4MaApKfm893Zw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F88EF3A568E194A9718ADEB45141124@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef97646-83d8-4823-2ac5-08da1e85677c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 02:12:34.1239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4nAxwtGKUWEkaSMEndY1A2tILBhw1mtRqAN/50kVHB904QSc5HVSsXzzt7tcHwmjc+RaDbcFNbSUOuLtXeAFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2999
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBcHIgMTUsIDIwMjIgYXQgMDk6NTU6MTRBTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi80LzE1IDE6NTYsIE1pa2UgS3JhdmV0eiB3cm90ZToNCj4gPiBPbiA0Lzgv
MjIgMDY6NTMsIE5hb3lhIEhvcmlndWNoaSB3cm90ZToNCj4gPj4gRnJvbTogTmFveWEgSG9yaWd1
Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPj4NCj4gPj4gVGhlcmUgaXMgYSByYWNl
IGNvbmRpdGlvbiBiZXR3ZWVuIG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGIoKSBhbmQgaHVnZXRsYg0K
PiA+PiBmcmVlL2RlbW90aW9uLCB3aGljaCBjYXVzZXMgc2V0dGluZyBQYWdlSFdQb2lzb24gZmxh
ZyBvbiB0aGUgd3JvbmcgcGFnZS4NCj4gPj4gVGhlIG9uZSBzaW1wbGUgcmVzdWx0IGlzIHRoYXQg
d3JvbmcgcHJvY2Vzc2VzIGNhbiBiZSBraWxsZWQsIGJ1dCBhbm90aGVyDQo+ID4+IChtb3JlIHNl
cmlvdXMpIG9uZSBpcyB0aGF0IHRoZSBhY3R1YWwgZXJyb3IgaXMgbGVmdCB1bmhhbmRsZWQsIHNv
IG5vIG9uZQ0KPiA+PiBwcmV2ZW50cyBsYXRlciBhY2Nlc3MgdG8gaXQsIGFuZCB0aGF0IG1pZ2h0
IGxlYWQgdG8gbW9yZSBzZXJpb3VzIHJlc3VsdHMNCj4gPj4gbGlrZSBjb25zdW1pbmcgY29ycnVw
dGVkIGRhdGEuDQo+ID4+DQo+ID4+IFRoaW5rIGFib3V0IHRoZSBiZWxvdyByYWNlIHdpbmRvdzoN
Cj4gPj4NCj4gPj4gICBDUFUgMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1BV
IDINCj4gPj4gICBtZW1vcnlfZmFpbHVyZV9odWdldGxiDQo+ID4+ICAgc3RydWN0IHBhZ2UgKmhl
YWQgPSBjb21wb3VuZF9oZWFkKHApOw0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBodWdldGxiIHBhZ2UgbWlnaHQgYmUgZnJlZWQgdG8NCj4gPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnVkZHksIG9yIGV2ZW4gY2hhbmdl
ZCB0byBhbm90aGVyDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbXBvdW5kIHBhZ2UuDQo+ID4+DQo+ID4+ICAgZ2V0X2h3cG9pc29uX3BhZ2UgLS0gcGFn
ZSBpcyBub3Qgd2hhdCB3ZSB3YW50IG5vdy4uLg0KPiA+Pg0KPiA+PiBUaGUgY3VycmVudCBjb2Rl
IGZpcnN0IGRvZXMgcHJlY2hlY2tzIHJvdWdobHkgYW5kIHRoZW4gcmVjb25maXJtcw0KPiA+PiBh
ZnRlciB0YWtpbmcgcmVmY291bnQsIGJ1dCBpdCdzIGZvdW5kIHRoYXQgaXQgbWFrZXMgY29kZSBv
dmVybHkNCj4gPj4gY29tcGxpY2F0ZWQsIHNvIG1vdmUgdGhlIHByZWNoZWNrcyBpbiBhIHNpbmds
ZSBodWdldGxiX2xvY2sgcmFuZ2UuDQo+ID4+DQo+ID4+IEEgbmV3bHkgaW50cm9kdWNlZCBmdW5j
dGlvbiwgdHJ5X21lbW9yeV9mYWlsdXJlX2h1Z2V0bGIoKSwgYWx3YXlzDQo+ID4+IHRha2VzIGh1
Z2V0bGJfbG9jayAoZXZlbiBmb3Igbm9uLWh1Z2V0bGIgcGFnZXMpLiAgVGhhdCBjYW4gYmUNCj4g
Pj4gaW1wcm92ZWQsIGJ1dCBtZW1vcnlfZmFpbHVyZSgpIGlzIHJhcmUgaW4gcHJpbmNpcGxlLCBz
byBzaG91bGQNCj4gPj4gbm90IGJlIGEgYmlnIHByb2JsZW0uDQo+IC4uLg0KPiA+IA0KPiA+IFRo
ZSBhYm92ZSBjb2RlIHdvcmtzIGFzIGRlc2lnbmVkLCBidXQgbWF5IGJlIGEgYml0IGNvbmZ1c2lu
Zy4gIElmIEhQYWdlRnJlZWQoKQ0KPiA+IHdlIEtOT1cgcmVmIGNvdW50IGlzIHplcm8sIHNvIG5v
IG5lZWQgdG8gZXZlbiBjYWxsIGdldF9wYWdlX3VubGVzc196ZXJvKCkgYXMNCj4gPiBpdCB3aWxs
IGFsd2F5cyByZXR1cm4gZmFsc2UgaW4gdGhpcyBjYXNlLiAgSXQgbWlnaHQgYmUgbW9yZSBjbGVh
ciBpZiB3cml0dGVuDQo+ID4gYXMgc2VwYXJhdGUgZWxzZSBpZiBzdGF0ZW1lbnRzIHN1Y2ggYXM6
DQo+ID4gDQo+ID4gCX0gZWxzZSBpZiAoSFBhZ2VGcmVlZChoZWFkKSkgew0KPiA+IAkJcmV0ID0g
MDsNCj4gPiAJfSBlbHNlIGlmIChIUGFnZU1pZ3JhdGFibGUoaGVhZCkpIHsNCj4gPiAJCXJldCA9
IGdldF9wYWdlX3VubGVzc196ZXJvKGhlYWQpOw0KPiA+IAkJaWYgKHJldCkNCj4gPiAJCQljb3Vu
dF9pbmNyZWFzZWQgPSB0cnVlOw0KPiA+IA0KPiANCj4gVGhpcyBjb2RlIGhlcmUgaXMgY29uc2lz
dGVudCB3aXRoIHRoZSBsb2dpYyBpbiBnZXRfaHdwb2lzb25faHVnZV9wYWdlLiBJZiBjaGFuZ2Ug
aXMgcmVxdWlyZWQsDQo+IHRoZXkgbWlnaHQgbmVlZCB0byBiZSBjaGFuZ2VkIHRvZ2V0aGVyLg0K
PiANCj4gQlRXOiBUaGV5IGxvb2sgYSBiaXQgY29uZnVzaW5nIGZvciBtZSBhdCBmaXJzdCBidXQg
SSBnZXQgdXNlZCB0byBpdCBsYXRlci4gOykNCg0KVGhhbmsgeW91IGZvciBjb21tZW50cywgTWlr
ZSwgTWlhb2hlLg0KUGF0Y2ggMS8zIGlzIHRvIHN0YWJsZSwgc28gSSdsbCBzdWJtaXQgYSBzZXBh
cmF0ZSBjbGVhbnVwIHBhdGNoIGZvciB0aGVzZSBjaGFuZ2VzLg0KDQo+IA0KPiBUaGFua3MhDQo+
IA0KPiA+IE5vdCBpbnNpc3RpbmcgdGhpcyBiZSBjaGFuZ2VkLiAgSnVzdCBlYXNpZXIgdG8gdW5k
ZXJzdGFuZCBJTU8uDQo+ID4gDQo+ID4gQWdhaW4sIHRoYW5rcyBmb3IgeW91ciB3b3JrIG9uIHRo
aXMhDQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IE1pa2UgS3JhdmV0eiA8bWlrZS5rcmF2ZXR6QG9y
YWNsZS5jb20+DQoNClRoYW5rIHlvdSENCg0KLSBOYW95YSBIb3JpZ3VjaGk=
