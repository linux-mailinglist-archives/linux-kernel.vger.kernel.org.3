Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3784D9420
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345037AbiCOFuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbiCOFuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:50:52 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2073.outbound.protection.outlook.com [40.107.114.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E959411A32
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 22:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8OAAO5o6CLCvrUBnOVPqCn53HUTPIvPmjClS1wx4CgEHkxVFYxB5kE0yjYTV6xvDxsXd3+lX4PUJnthYAqsIvCQ1Upk8kmBqU9+k5n0DcybV58WxGaHjq13PpkthzW6yvtC0PG4A2TH6wfk0PCrVsS3QnBm9BqhXH2wNEipe0y89w/UdlV39GGl5c8CdjfFjmprHh2VhPw0Idit/9tuy2Fj3zI6EZowvd14LNKpDql+z+9yC82SxeVyZqyOrvMP3iQbEsMZnrEH3/jDB/p6Ock5Mmo/u2aOMJ6/YXxHK87Jk2qWkhz5ha80ZWYcrw1jJ1wIcM5ERQWhGVQeniWcOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjzC70xcl0j4aMcpXsLC7PPyOnK0l1xDvTp5buzP0T8=;
 b=A3RjBewcJ/kZsNmGnAacPAfwlC/wVtRqceUQP+jfH33lgVN8jysWw2VwLrRY5wmbayg78iMPhSqbo8FPPyLbE6gLIxWu5krB/X5421dwRzUn3GCB5xsKYPA14Cv8haf9e5FIRt8WnfePByldghv2i8bZaE4FLcJAFKzt2JOArBxE31d0KWl6tirU2nle9Kf//BfO6DCvth08Vr+vxmMV51UNfRCcqNkr0cvpe/vdr9cx+Kkvy7Z/vMxY4HGVrI2PWO1x/6x157bUsZiRME3SvO0PxyY6S0Nxy+XGXj64GrD3nYmYrUaq6MS+2VZz6WiPJnzV4H8PyiH7t6qsOR95wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjzC70xcl0j4aMcpXsLC7PPyOnK0l1xDvTp5buzP0T8=;
 b=AnMc+/XGvH602fQp9faMDOPKH686MA9rBMeZrGZWRdv/gbe+0/pFNRqJ2YIxvs6UHBDMpuatQrKBXa4rAVCTtOAYjxj3evyPaJ/jFTfApSAFsxgvb8XsvYB0dFIyPaZO+Ycw+60/HAVhOVXecBTrzOWIFDF8KRLMNLQP4RKvXtE=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY2PR01MB3163.jpnprd01.prod.outlook.com (2603:1096:404:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 05:49:36 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d%9]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 05:49:36 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
Thread-Topic: [PATCH v2] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
Thread-Index: AQHYN0kvr9WFFzF7cEKi9v9L2L7MeKy+dpSAgAF7wIA=
Date:   Tue, 15 Mar 2022 05:49:36 +0000
Message-ID: <20220315054935.GA3454497@hori.linux.bs1.fc.nec.co.jp>
References: <20220314021337.333781-1-naoya.horiguchi@linux.dev>
 <58732610-36a4-1f05-c09d-a5536013772d@huawei.com>
In-Reply-To: <58732610-36a4-1f05-c09d-a5536013772d@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dabaa188-6179-4b53-edcd-08da064796a9
x-ms-traffictypediagnostic: TY2PR01MB3163:EE_
x-microsoft-antispam-prvs: <TY2PR01MB316398947D19A2D1F201570EE7109@TY2PR01MB3163.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hdw3+b6hI4wOHQIxSEosMijt5lu5TLTa6GcAL4REU9gsZ55ZcoGgqZd1axAM6yuYYPOfCEkJvlt+Buv46h53gOtZCgruQunha9nchYCsq+R9eYBzMs2UhofoETlySs4GYtKwlgu9uPs1NKUP6wRgK/FjvJZCjE6Lc0QfHngVkriSNVsQuC4vEPt288+cagKuKxVfvOLz5YBoU78YkFLRIqF/GP5YljvRw1yxf8DrZlIdgT3zIN225viC/8kwm4gAz1cykJ9avZcveO9VcKEz+t0QWpAj8Mf3G7uTRGbxp9W/ENGcbHHgZMSGJhqsQUqtm8gtOB0+XXspbPHp9vFl59oH4n0zs4+KtyYzHAKlasT9CfZye7k+abbA6wAByGgMNX1DTzQuTgdvcQ+BDUApPKt5MLamFTODiJzUAEaEy/bm54vj8S34160EItVpn8b5tuDZFW+gEwQiXgN+ihFGzcN85q06Yh0L1DRDcVlB1pgB6l3xqKvnGmbMjQ5u/hxeEGoHRQMFM7Ae9Oqjbv4s0JNGsLVp5XNjaFrJxok0SyHDYCOxvvaajFuN8cG2MY5r0dwZTHGFmaDJm8eR8VRWBw25oFWwgWf+GP+7Ljwk9sB5D6vvq2hZXPoL7qF2nO+SSJdIwS1bD0sQodjhLUMXeJOlnkKPTJWjjdEsHs5DBLwLqWKzvyoI5StPao0M8AOxa7VhpzhNanffpKzSfZjiVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6916009)(508600001)(71200400001)(6486002)(316002)(9686003)(6512007)(85182001)(33656002)(4326008)(66556008)(66446008)(64756008)(66476007)(8676002)(8936002)(76116006)(66946007)(2906002)(5660300002)(1076003)(86362001)(38100700002)(122000001)(83380400001)(186003)(26005)(82960400001)(6506007)(55236004)(53546011)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUJuT0JpbmN2ejVhVm1MdmZsT0VVck95bng3aXhtVmxQM0FseHBzekYzMWxj?=
 =?utf-8?B?OG9rQzhKNGlmOFhwb3BIbmNGVVkwWmxXbXEvdm5iYWRuSTJYaWRCR1lyN2xl?=
 =?utf-8?B?QmRySHlVMCtBVGVRaFMxcHVrbUdIRjRZYWRWMUtzT3B1TldXN25hQjBFRm5S?=
 =?utf-8?B?b3pOY1RJNWZiMXFwcGRWcXdlRklwWGpDbWEyQVQvc01xVW0xcjNWQS8rYmpn?=
 =?utf-8?B?c2VnSDM3cFJydHN5dzY1NjhLbXcrZUlKZmVHR1o3TXlQYUFXYjhwYk02Vi9J?=
 =?utf-8?B?MEtwZFlBTWpDVDU4dkV5YUhEbTVwV1RxcStvWE1lZWZGQ3k0TXpZZ3lmdFpz?=
 =?utf-8?B?Y0FkV04zODZBQ25RQjVRVmJwd2pqYkdTTjJZdHBjUVR1NEVFVlRXYTVrWEZW?=
 =?utf-8?B?bnFkbDVFaVA2NytDSzJGcnZqS1hxWlRMVGp4MmI1QkNXN09KVW5ha1dqR3Fm?=
 =?utf-8?B?Y0RXT1lDQlM1bmNBOWFQYURjdzg2elVKYTFwSW16d2wrY2V1bWRYWGY5TnZh?=
 =?utf-8?B?Y3RxbmVJWGcrSm5kVzFuck4zTUxHWmhmU3lJVHRtaWptUGk1ejBDdURCdU01?=
 =?utf-8?B?MDU0aStnM2xKMjR5WDdyTG1wa0pkbnd0RUw0SFRlWjM0OVB1OWlEaGpCVGp1?=
 =?utf-8?B?NmEwMjErYzhHWFBONVBKdHN0THhSSjlKN3VZdjdTVkNWeUlidEdhb05mNmFp?=
 =?utf-8?B?NXYvWVp5WkhOa2c2TS9lVHYxVHE3bWt4dnNYY0tlYUJxWU5DZVNNU1NHZnFo?=
 =?utf-8?B?Q0JWMVBodlJpeDMwSVJ3alJrMkZFTnFxM09ZRDlka2pVZCtWT29ablg2SUNC?=
 =?utf-8?B?OVM5dGk2Wk1yU2hoNGluRlR3c3BnN01tM3FtNDZVMitKaXkxcGpVQ2lTL2J6?=
 =?utf-8?B?SjQ3OFlScWNYOUY0clVXTmxWOUJoVW5FOUlmY3NLZ1dyZHd2YWNGTStnYzhr?=
 =?utf-8?B?MTZ0RVMwYUtPa1VnS2JqWURDaURPOFREZ2M2eVlaQ2Q5YVNKSGpKbFpabElZ?=
 =?utf-8?B?b2NHc09aQUF3VEdIK3hOZTFtUWxwYjlQYnU4WUU0bjVLK0Q0SHZYQ2JRMlRO?=
 =?utf-8?B?cEFQc1dKWXplVHF4TUwxcDJ4WC9HNVNBWXMwSTJtYWFFQmJkVXdmdDRZRTRS?=
 =?utf-8?B?U3ZjMUp4cEJhR2lxZWkrcFFmQlNiVlBnZStnMytlVWhsUjM3bDFnWEpMT2pi?=
 =?utf-8?B?NjZjb0tUR29KUjkxSmUxam1qcFcwMFRlYTBGaVZUcUNSSys3V0ZUbFhhTlBi?=
 =?utf-8?B?djFPb0YzMk03QzlBQlVlLyt6OFNwRFM3SVlwWCs3cXlubENhUnpkaHgvVkpF?=
 =?utf-8?B?clBaMzlnREFCTGtlWHhTSzZsRHRnV2hYWmo4eWpMQ0RHYU5xMmpzUTd6UHVI?=
 =?utf-8?B?d0Zrd0ZUWmRYRVd3MzYyVGNrREJIV0tEOVVNbUI4Y1BNdEVlcUh1TThSUmtM?=
 =?utf-8?B?TjBTWjFpa3BpV1FLUmVlWC9SdkZ0aWhQNldja3UyUEIwZ1ViNW5ZQkdLQlNC?=
 =?utf-8?B?NDF4RWgvYUo5TU5lUjZjTjk0VTdoYWppQ0FaaThlTmozc1FoWkFoTlpuZ3d6?=
 =?utf-8?B?KzJmVXUzUEZjZHpIWVhkSlRmODZycmUwQlNpbjh4eUgyVUg1Qmc1WTRESEZP?=
 =?utf-8?B?MzBwTkZTMjlOMm9FZXF6VXJMb2pWR2hncDM3c0V2TFZKb3pEbm1udURhVkNo?=
 =?utf-8?B?SWZGcVgrNVdvYnEzckNhbFhwTnUwNzZlTHk0d09VZ3VXTWhRN2RRcVgxYW80?=
 =?utf-8?B?bjJsc2liVHZ6UW9icFFzRmh1bGQrQmVNNHllWW04ZEhwUkVBdlhKOE5oOCtG?=
 =?utf-8?B?cFgwYVgxQk10V2lyZzNkbC9mTUFMTGM1VUtIcjRJeksxWjBzQ0RGeWlWc1pl?=
 =?utf-8?B?V2xyYXRGajJXSTNzbzJhYUJUWmpPSXdLZkM5R1I1QUZGSW50N3p6UzFtNCtq?=
 =?utf-8?B?V0htYytFVFF5U3lJbnF2SnBqbzdJYnVDdE9VamxRU1IwK21WWDhFd2xTaGMw?=
 =?utf-8?B?bFY2Q3dvTFhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7315D6F98362194FA2A9D3F7B9366FFC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dabaa188-6179-4b53-edcd-08da064796a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 05:49:36.5885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fPYVLEhFnlXW+kolw0xWimxHZ/F+cZ+FvPPt716eI7NHUxMT/VhAIZk/4r1jiZQiG9DSakx/5qU/HPnRBbPjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXIgMTQsIDIwMjIgYXQgMDM6MTA6MjVQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi8zLzE0IDEwOjEzLCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gRnJv
bTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiANCj4gPiBU
aGVyZSBpcyBhIHJhY2UgY29uZGl0aW9uIGJldHdlZW4gbWVtb3J5X2ZhaWx1cmVfaHVnZXRsYigp
IGFuZCBodWdldGxiDQo+ID4gZnJlZS9kZW1vdGlvbiwgd2hpY2ggY2F1c2VzIHNldHRpbmcgUGFn
ZUhXUG9pc29uIGZsYWcgb24gdGhlIHdyb25nIHBhZ2UNCj4gPiAod2hpY2ggd2FzIGEgaHVnZXRs
YiB3aGVuIG1lbW9yeV9mYWlsdXJlKCkgd2FzIGNhbGxlZCwgYnV0IHdhcyByZW1vdmVkDQo+ID4g
b3IgZGVtb3RlZCB3aGVuIG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGIoKSBpcyBjYWxsZWQpLiAgVGhp
cyByZXN1bHRzIGluDQo+ID4ga2lsbGluZyB3cm9uZyBwcm9jZXNzZXMuICBTbyBzZXQgUGFnZUhX
UG9pc29uIGZsYWcgd2l0aCBob2xkaW5nIHBhZ2UgbG9jaywNCj4gDQo+IEl0IHNlZW1zIGhvbGQg
cGFnZSBsb2NrIGNvdWxkIG5vdCBoZWxwIHNvbHZlIHRoaXMgcmFjZSBjb25kaXRpb24gYXMgaHVn
ZXRsYg0KPiBwYWdlIGRlbW90aW9uIGlzIG5vdCByZXF1aXJlZCB0byBob2xkIHRoZSBwYWdlIGxv
Y2suIENvdWxkIHlvdSBwbGVhc2UgZXhwbGFpbg0KPiB0aGlzIGEgYml0IG1vcmU/DQoNClNvcnJ5
LCB0aGUgbGFzdCBsaW5lIGluIHRoZSBwYXJhZ3JhcGggbmVlZCBjaGFuZ2UuIFdoYXQgcHJldmVu
dHMgdGhlIGN1cnJlbnQNCnJhY2UgaXMgaHVnZXRsYl9sb2NrLCBub3QgcGFnZSBsb2NrLiAgVGhl
IHBhZ2UgbG9jayBpcyBoZXJlIHRvIHByZXZlbnQgdGhlDQpyYWNlIHdpdGggaHVnZXBhZ2UgYWxs
b2NhdGlvbiAobm90IGRpcmVjdGx5IHJlbGF0ZWQgdG8gdGhlIGN1cnJlbnQgaXNzdWUsDQpidXQg
aXQncyBzdGlsbCBuZWNlc3NhcnkpLg0KDQo+IA0KPiBCVFc6SXMgdGhlcmUgc29tZSB3b3JkcyBt
aXNzaW5nIG9yIGhlcmUgc2hvdWxkIGJlICdwYWdlIGxvY2suJyBpbnN0ZWFkIG9mICdwYWdlIGxv
Y2ssJyA/DQoNCkkgc2hvdWxkIHVzZSBhIHBlcmlvZCBoZXJlLCBJJ2xsIGZpeCBpdC4NCg0KWy4u
Ll0NCg0KPiA+IEBAIC0xNTAzLDI0ICsxNTAyLDExIEBAIHN0YXRpYyBpbnQgbWVtb3J5X2ZhaWx1
cmVfaHVnZXRsYih1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzKQ0KPiA+ICAJaW50IHJlczsN
Cj4gPiAgCXVuc2lnbmVkIGxvbmcgcGFnZV9mbGFnczsNCj4gPiAgDQo+ID4gLQlpZiAoVGVzdFNl
dFBhZ2VIV1BvaXNvbihoZWFkKSkgew0KPiA+IC0JCXByX2VycigiTWVtb3J5IGZhaWx1cmU6ICUj
bHg6IGFscmVhZHkgaGFyZHdhcmUgcG9pc29uZWRcbiIsDQo+ID4gLQkJICAgICAgIHBmbik7DQo+
ID4gLQkJcmVzID0gLUVIV1BPSVNPTjsNCj4gPiAtCQlpZiAoZmxhZ3MgJiBNRl9BQ1RJT05fUkVR
VUlSRUQpDQo+ID4gLQkJCXJlcyA9IGtpbGxfYWNjZXNzaW5nX3Byb2Nlc3MoY3VycmVudCwgcGFn
ZV90b19wZm4oaGVhZCksIGZsYWdzKTsNCj4gPiAtCQlyZXR1cm4gcmVzOw0KPiA+IC0JfQ0KPiA+
IC0NCj4gPiAtCW51bV9wb2lzb25lZF9wYWdlc19pbmMoKTsNCj4gPiAtDQo+ID4gIAlpZiAoIShm
bGFncyAmIE1GX0NPVU5UX0lOQ1JFQVNFRCkpIHsNCj4gPiAgCQlyZXMgPSBnZXRfaHdwb2lzb25f
cGFnZShwLCBmbGFncyk7DQo+ID4gIAkJaWYgKCFyZXMpIHsNCj4gDQo+IEluIHRoaXMgKHJlcyA9
PSAwKSBjYXNlLCBodWdldGxiIHBhZ2UgY291bGQgYmUgZGlzc29sdmVkIHZpYSBfX3BhZ2VfaGFu
ZGxlX3BvaXNvbi4NCj4gQnV0IHNpbmNlIFBhZ2VIV1BvaXNvbiBpcyBub3Qgc2V0IHlldCwgd2Ug
Y2FuJ3Qgc2V0IHRoZSBQYWdlSFdQb2lzb24gdG8gdGhlIGNvcnJlY3QNCj4gcGFnZS4gVGhpbmsg
YWJvdXQgdGhlIGJlbG93IGNvZGUgaW4gZGlzc29sdmVfZnJlZV9odWdlX3BhZ2U6DQo+IAkvKg0K
PiAJICogTW92ZSBQYWdlSFdQb2lzb24gZmxhZyBmcm9tIGhlYWQgcGFnZSB0byB0aGUgcmF3DQo+
IAkgKiBlcnJvciBwYWdlLCB3aGljaCBtYWtlcyBhbnkgc3VicGFnZXMgcmF0aGVyIHRoYW4NCj4g
CSAqIHRoZSBlcnJvciBwYWdlIHJldXNhYmxlLg0KPiAJICovDQo+IAlpZiAoUGFnZUhXUG9pc29u
KGhlYWQpICYmIHBhZ2UgIT0gaGVhZCkgew0KPiAJCVNldFBhZ2VIV1BvaXNvbihwYWdlKTsNCj4g
CQlDbGVhclBhZ2VIV1BvaXNvbihoZWFkKTsNCj4gCX0NCj4gDQo+IFNldFBhZ2VIV1BvaXNvbiB3
b24ndCBiZSBjYWxsZWQgZm9yIHRoZSBlcnJvciBwYWdlLiBPciBhbSBJIG1pc3Mgc29tZXRoaW5n
Pw0KDQpObywgeW91J3JlIHJpZ2h0LiAgV2UgbmVlZCBjYWxsIHBhZ2VfaGFuZGxlX3BvaXNvbigp
IGluc3RlYWQgb2YNCl9fcGFnZV9oYW5kbGVfcG9pc29uKCkuDQoNCkBAIC0xNTEyLDcgKzE1MTIs
NyBAQCBzdGF0aWMgaW50IG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGIodW5zaWduZWQgbG9uZyBwZm4s
IGludCBmbGFncykNCiAJCQl9DQogCQkJdW5sb2NrX3BhZ2UoaGVhZCk7DQogCQkJcmVzID0gTUZf
RkFJTEVEOw0KLQkJCWlmIChfX3BhZ2VfaGFuZGxlX3BvaXNvbihwKSkgew0KKwkJCWlmIChwYWdl
X2hhbmRsZV9wb2lzb24ocCwgdHJ1ZSwgZmFsc2UpKSB7DQogCQkJCXBhZ2VfcmVmX2luYyhwKTsN
CiAJCQkJcmVzID0gTUZfUkVDT1ZFUkVEOw0KIAkJCX0NCg0KDQoNCj4gDQo+ID4gIAkJCWxvY2tf
cGFnZShoZWFkKTsNCj4gPiAgCQkJaWYgKGh3cG9pc29uX2ZpbHRlcihwKSkgew0KPiA+IC0JCQkJ
aWYgKFRlc3RDbGVhclBhZ2VIV1BvaXNvbihoZWFkKSkNCj4gPiAtCQkJCQludW1fcG9pc29uZWRf
cGFnZXNfZGVjKCk7DQo+ID4gIAkJCQl1bmxvY2tfcGFnZShoZWFkKTsNCj4gPiAgCQkJCXJldHVy
biAtRU9QTk9UU1VQUDsNCj4gPiAgCQkJfQ0KPiA+IEBAIC0xNTUzLDEzICsxNTM5LDE2IEBAIHN0
YXRpYyBpbnQgbWVtb3J5X2ZhaWx1cmVfaHVnZXRsYih1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZs
YWdzKQ0KPiA+ICAJcGFnZV9mbGFncyA9IGhlYWQtPmZsYWdzOw0KPiA+ICANCj4gPiAgCWlmICho
d3BvaXNvbl9maWx0ZXIocCkpIHsNCj4gPiAtCQlpZiAoVGVzdENsZWFyUGFnZUhXUG9pc29uKGhl
YWQpKQ0KPiA+IC0JCQludW1fcG9pc29uZWRfcGFnZXNfZGVjKCk7DQo+ID4gIAkJcHV0X3BhZ2Uo
cCk7DQo+ID4gIAkJcmVzID0gLUVPUE5PVFNVUFA7DQo+ID4gIAkJZ290byBvdXQ7DQo+ID4gIAl9
DQo+ID4gIA0KPiA+ICsJaWYgKFRlc3RTZXRQYWdlSFdQb2lzb24oaGVhZCkpDQo+ID4gKwkJZ290
byBhbHJlYWR5X2h3cG9pc29uZWQ7DQo+ID4gKw0KPiA+ICsJbnVtX3BvaXNvbmVkX3BhZ2VzX2lu
YygpOw0KPiA+ICsNCj4gPiAgCS8qDQo+ID4gIAkgKiBUT0RPOiBod3BvaXNvbiBmb3IgcHVkLXNp
emVkIGh1Z2V0bGIgZG9lc24ndCB3b3JrIHJpZ2h0IG5vdywgc28NCj4gPiAgCSAqIHNpbXBseSBk
aXNhYmxlIGl0LiBJbiBvcmRlciB0byBtYWtlIGl0IHdvcmsgcHJvcGVybHksIHdlIG5lZWQNCj4g
PiBAQCAtMTU4NSw2ICsxNTc0LDE0IEBAIHN0YXRpYyBpbnQgbWVtb3J5X2ZhaWx1cmVfaHVnZXRs
Yih1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzKQ0KPiA+ICBvdXQ6DQo+ID4gIAl1bmxvY2tf
cGFnZShoZWFkKTsNCj4gPiAgCXJldHVybiByZXM7DQo+ID4gK2FscmVhZHlfaHdwb2lzb25lZDoN
Cj4gPiArCXB1dF9wYWdlKHApOw0KPiA+ICsJdW5sb2NrX3BhZ2UoaGVhZCk7DQo+IA0KPiBHZW5l
cmFsbHkgc3BlYWtpbmcsIHdlIHNob3VsZCBkbyB1bmxvY2tfcGFnZSBiZWZvcmUgcHV0X3BhZ2Ug
b3IgcGFnZSBtaWdodCBiZSBkaXNhcHBlYXJlZA0KPiBiZWZvcmUgd2UgdW5sb2NrIHRoZSBwYWdl
LiBUaGlzIHNob3VsZCBiZSBvayB3aGVuIG1lbW9yeV9mYWlsdXJlIHN1Y2NlZWRzIHRvIGhhbmRs
ZSB0aGUNCj4gcGFnZSBwcmV2aW91c2x5IGFzIGl0IGhvbGRzIG9uZSBleHRyYSBwYWdlIHJlZmNu
dC4gQnV0IGl0IG1pZ2h0IGJlIHByb2JsZW1hdGljIHdoZW4NCj4gbWVtb3J5X2ZhaWx1cmUgZmFp
bGVkIHRvIGhhbmRsZSB0aGUgcGFnZSBsYXN0IHRpbWUuIFdlIG1pZ2h0IGJlIHRoZSBsYXN0IHVz
ZXIgaGVyZS4NCg0KT0ssIHNvIGFub3RoZXIgY29kZSBwYXRoIGluICJpZiAoaHdwb2lzb25fZmls
dGVyKUAgYmxvY2sgc2VlbXMgdG8gbmVlZA0KdGhlIHNhbWUgY2hhbmdlIGluIHRoZSBvcmRlci4N
Cg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
