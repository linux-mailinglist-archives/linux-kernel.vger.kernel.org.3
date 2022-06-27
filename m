Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB16655C87E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiF0GDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiF0GDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:03:00 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2079.outbound.protection.outlook.com [40.107.113.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7392AC0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG6dXLR8DbjoUhIPFWRNVMxW2NoS3Au4l66xDEHgH0ySCURT9sF34bUdWUZAn9g3CwZPhSq5IzvaG9dq5jGqy+ez7J9xERtaHQdZttuGMM1zLWzJLzt45vvj1EEEPsijlgvWUYQ6lL5LrMyuChM5fbeZtKesXrygPWM3Bgx1LyGHUEULh3FHdkt8ZlCQjvQTNiKnqD+Sw2zTp7AqeUevF4MPhiBQOLp+1akg6kPoJbFN1vPgOxqXRJmL+2+63a2OrKNM6CTLJCdc0GKHfwRriq+WdeI4oTB2+iWJ9OdZP9bU0ZL+Wo4djCxQ8ztAWPd9/cWI+ACwQhFQpCUMEjGCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIqWmj2oh6xub4o8bsyHnmDHI34sRzvSD1pq7xU4PiI=;
 b=dLQMk01kwoBmUE7pUjHoZqAgRxC8LAzZq2Kuyef95/ImMchaYaJGna12gCu5hZBu0xfm2sryJJGYYLaQtqntkz+de5NQDUlAITuwiuPIHh4I1l8qS7a/u3jGe4bPPaK6Dzntz3TA3MSvlEEk5JrnBg6jy6S0VHwMKSA5tfWE5W4JyKzK29aZQk3fmjyht1CjKIKCGZ+pw8NKSbaOnkKh8fm2U0n2qwMHtfeEcguVh12+H7gr6UyHPglntBF3wkX3pWaa/RDoNf9/vd1Xl+HWAF7ncrgiLBK7K5h4TLPkwiAXswASY6Sqc3yw8ZsMb2PhULCVp5tGoMYRiGfhzyRRbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIqWmj2oh6xub4o8bsyHnmDHI34sRzvSD1pq7xU4PiI=;
 b=NpNO17abCEplVG7QvOujYGeHY0llHsT4Jrsz97fy9gqlRFCQJho7TUqcNgHiOirIKFReTq2e3xpRz0eQBdXoZV9e6Dow1+2Xe1SykTww8Ju3uE2VTJmKGoWa5Et9/LpDPW11wFXVON6V/cC7/tLfd++0jrhd2tsxnyrLEDgfInU=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB7431.jpnprd01.prod.outlook.com (2603:1096:604:14a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 06:02:57 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 06:02:57 +0000
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
Thread-Index: AQHYh1xSoNvgTy1mRUSP6G7yMyIF8K1d1LUAgABeaQCAAAM+gIAABVoAgACx4YCAA9qpgA==
Date:   Mon, 27 Jun 2022 06:02:56 +0000
Message-ID: <20220627060231.GA2159330@hori.linux.bs1.fc.nec.co.jp>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-2-naoya.horiguchi@linux.dev>
 <0b69e3ef-0123-4575-b68d-4d9b2067aa0e@huawei.com>
 <YrVv3gKMxbu/dwCs@FVFYT0MHHV2J.usts.net>
 <e9a22524-d9f6-1018-a712-00adb90d432a@huawei.com>
 <20220624083428.GA2070418@hori.linux.bs1.fc.nec.co.jp>
 <YrYMS5sATPzEgUxb@monkey>
In-Reply-To: <YrYMS5sATPzEgUxb@monkey>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 111ee237-8abd-400d-ac31-08da5802aead
x-ms-traffictypediagnostic: OS3PR01MB7431:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IFLkUijAzDfNq5lCREIHqjbd0OAu45hmdKkiQoarzTB2pa3qrMIiXMiLDFHQHUA6+9Kr+nke8bFmw6awSZFqTZeElkS2eFXd10CGq/8OuEL8wi6myMeHw2SMQwK7tYRDCm1IjGeSl1fAq/gsu1PbinMRW49NpcaZCQV3mpNS8yq+RAysxZFBafazz1ZxHUYqJ1LJKL1AaDTlfZm5Z1oKVgqRZwsyN+46FO9iMxuYYv6Lt31sbQsN7Je5mOf7j7F7c1LpfsCQ3xIQVrllQKhpkrR8AjL4mDiOwmhzWS9o6ew6QPP4HLc1uWCa/scfphWtEmlTiNVB5fDwUgxvU+QGQleM8NuNNLeiShxAxEw0MN/elHIbU/l038PQk74W27lbyDtL7pwKh49ho8JgI4tOwlpduj3cUOyYLTmm2aoeYCbOq/Am/qYZoCrwHaWkid6dXKzejpvGnYeXjnXiaW7YtylsCgCwcaLoEzaIF/3XNtA/uu/A1O4u6rnfNivIJBN476zk+WEM5hIu0x3WW6g5bE8hueZBm1/T5j5dP0z0W96k1Q35Ug7STJMC7yaYuwCOfDfbF6sof8P5Xjam/ACfeQ1MlQ/ZH20Pkt0v6rYXuYmwfNrvQ3pYMmxfqorXpKsQa+EeI7ut6lkdKb0x8Pkni0VhFyuPJYcda5a/NbTy5UTrTxrTB/QTy0778YKbQN8wPDsaoyOUL0iLGCVlFp6NKQikY3R9YbPYhKfLaih0JpDmVQ9NGmnbYQWiIpJleYk7rjEfcjDXefITd7Olsi5bWUJCoHKiarQMpN6SuBMOY9A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(55236004)(82960400001)(4326008)(38100700002)(86362001)(122000001)(71200400001)(7416002)(6506007)(41300700001)(478600001)(53546011)(8936002)(2906002)(85182001)(83380400001)(5660300002)(6916009)(54906003)(26005)(6512007)(9686003)(6486002)(1076003)(76116006)(38070700005)(66946007)(316002)(64756008)(66556008)(186003)(8676002)(33656002)(66476007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXpXdzdSaEVZbzEwUTdtbTdMbllVVnB1VW96M3B5dnM2eW1RRUZOcWZHV09p?=
 =?utf-8?B?ZFRrOTl6blNsdTJCVUpGZmU2Q0J6V2pEUWlUNEJ1QWM0bmpmS1lLTC9icXov?=
 =?utf-8?B?Ny9Ua3dZRWd2SDNYdHdDdGIvTmlDcWwyTEVudjl0U1NySjQ0anplVnNLbE9O?=
 =?utf-8?B?UDcrdkpnaWkxa1BqbkhKNjhMVzNDa3kzbEQrRlhnYjRJOVdWc2pXaUdsbUxI?=
 =?utf-8?B?M0dFSDF1SVJLTlR3UlhpS3ZsclJMVTAvWDUxR053c0xIYmVsdHRkMDdybXJF?=
 =?utf-8?B?Q0tRRFpXVHpEczFNazY0TVNkTC9iNE9XRHNma2dXbEUzeGZxUGcwVWR3UWtz?=
 =?utf-8?B?eFZHL1BpakFJTHBHQ3h6cmo0SDJjbVFJak1wcWJsWEVCQk1YMUdNeFBKckk0?=
 =?utf-8?B?RDZoMnBGUEU3ZmdjRGpHa0ZrSjBnSy8zWThnT29tM3JKcWh5dHYzaG5MUVNM?=
 =?utf-8?B?cFlKNWV4T1ZRSzBIUW5ZMHVBNjMxN1g2Tm5tOGxNQnE1QXdlSU5obVdZNEh3?=
 =?utf-8?B?b0ZRTVhpQS81RzB5R1ArNDN3VmIxK01FRGptd1FDWU9DYkhoejNmWm5nVnZJ?=
 =?utf-8?B?RXRXRkVaMjQxU09IdXdIL1ErZWt4ZU9YKzJkVURoU1BobmdIWEZaMmpUYUpj?=
 =?utf-8?B?UTMvY0Qwb1RzMXlaVktoSmNxVE9VeXlDNXpsK1ZkQTFQSG54WG1Mb3JPNlNB?=
 =?utf-8?B?aWFWSHZVTUMrUS9QTjg5dEd3R1pHY1RKN3B4V2Y0Z0VybFQrUVB3VTRORHQw?=
 =?utf-8?B?TDFLaW5TMFRuWjMyaEt2QmI2ZHUvbzh1SzNPL1JKeHBuQlZGRVpib29aU2xV?=
 =?utf-8?B?aWxYRStoUGVHTU1teDRBNS9pUHcyRlNkdjdGaU5oRXEvVkRQSHhXRjhtTHds?=
 =?utf-8?B?aTYwazJTaCsybzcxSEJIOG5YdXNPTDljcWIySEVscTl0QkJoRG9xUzBQWTlS?=
 =?utf-8?B?K3BOam9CVHVYL3piL2trUW1QZnFRSGkzdmpTMmVHNmpSamxnYUhQQmo3aVJx?=
 =?utf-8?B?SjlQMVhla041cnQ0bVVVSkl5NDVMdVJuSlV1WVZYbjdMZjdzOWdRSk5NYkxN?=
 =?utf-8?B?YWtIUzdDTkw3M2g0aFYwWW94a1FZbFVpeFYrYThIMTVBSjltak5GVFE0cWdI?=
 =?utf-8?B?NDlKdUpLRUg1alAvNHZYR1ZvMEhqNlROdm1vMXl1cHVJbktpbHFjYVJuYTRq?=
 =?utf-8?B?Slh6Ym9zRzFYYk1RcTlzakcrdkRyUDZpclQ4L2RVK1lnQmtCUjNqbXhDM0Rm?=
 =?utf-8?B?dXJQZVd5K1R0RzEvbzk1VW14c1JQVUQwWm9jWTNZOW5JanpHbUQ2TkFBS2hF?=
 =?utf-8?B?WndqZ2MrUnhmNFdsTjhVOUR1NnlWUkZDQWRURFlQOE45d3VkdndhelBudEZ3?=
 =?utf-8?B?QVFsWEppMHlLRld4QTVFTTJIT3EvRkZmbngvNzRzbWo1ZmRSRUlPb25Gd2d5?=
 =?utf-8?B?R2NFZE1kSEI4UEJyVHRad3ZqckdpSjRtWjhIWW5NSzMvNU03Y1RhTnozWTFN?=
 =?utf-8?B?OFV0OFBEY0NJc2VCVDVMb1hRUE9DK1pLUXY1VVJpbFJPdkluM0R2RTJDZDlV?=
 =?utf-8?B?OG0zWk03aXJId3RrZ1pKK3NnTmN4Q1hlM2VrMG05V1B0ZEVIMFlNZ0xMMVk2?=
 =?utf-8?B?UWRzb0J1T3BPdndaUWZONlJ3S0psZ0UwOGtPNUZONDdZNzB5cnplMC9wOWZU?=
 =?utf-8?B?T2p6VlQwZUdlN0tCVlowU21hMURWMFJMZkZXc0I1ZWRJRnJPYkk3ZkxsRFJS?=
 =?utf-8?B?cXkvb0Y0bWI2aW1MVHpMQldONE1uUWRaaHBzZVpicmZ6ZHErbUQyYnJQMzBG?=
 =?utf-8?B?UWJhOWYxcmhlN2ZmTlBZVlFIQ2U4MVRxZkZzd1R1NjdZZFBLeGVDL3BxQ2NX?=
 =?utf-8?B?aWJrSUFyUkozVXJYWlhrbWtIczNhSWtQOXI2b0lGMmJQMk1ZM002Tnh2M0Nu?=
 =?utf-8?B?Zm9xNjFsM243R1hPQVh3Z2FKVmxza1RwK0h0Y1FmUjl1RGNwVnNQWmMrSTY3?=
 =?utf-8?B?TnlCVGhSRHFGQlhVQUNucGF1TDBsdVdPYnE1Nm5Xc1VkWXhvQ3ZWRlhtV3pi?=
 =?utf-8?B?R3h6TmdUNGpORk12bDNISm1BQkw1a3MwcXJ3Q2oyRXZoRGFCRFU1OVYrMldi?=
 =?utf-8?B?UmE2bXRTZjNNZHhjU0oyUS84N25LTW5ObjFTbms0ODVvZ3VnaVY1RnNDejMr?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3175DA0912D5D842B4ADFB1812224244@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111ee237-8abd-400d-ac31-08da5802aead
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 06:02:56.9830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvn3HC5dvmT8HUfGAqR69aCPyznZ4W0g4Gnl3pyelbiivoczdMf37nZOel31NZ15vz6cHivDcG3FOpJ1fTGFzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKdW4gMjQsIDIwMjIgYXQgMTI6MTE6MDdQTSAtMDcwMCwgTWlrZSBLcmF2ZXR6IHdy
b3RlOg0KPiBPbiAwNi8yNC8yMiAwODozNCwgSE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p
IHdyb3RlOg0KPiA+IE9uIEZyaSwgSnVuIDI0LCAyMDIyIGF0IDA0OjE1OjE5UE0gKzA4MDAsIE1p
YW9oZSBMaW4gd3JvdGU6DQo+ID4gPiBPbiAyMDIyLzYvMjQgMTY6MDMsIE11Y2h1biBTb25nIHdy
b3RlOg0KPiA+ID4gPiBPbiBGcmksIEp1biAyNCwgMjAyMiBhdCAxMDoyNTo0OEFNICswODAwLCBN
aWFvaGUgTGluIHdyb3RlOg0KPiA+ID4gPj4gT24gMjAyMi82LzI0IDc6NTEsIE5hb3lhIEhvcmln
dWNoaSB3cm90ZToNCj4gPiA+ID4+PiBGcm9tOiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmln
dWNoaUBuZWMuY29tPg0KPiA+ID4gPj4+DQo+ID4gPiA+Pj4gSSBmb3VuZCBhIHdlaXJkIHN0YXRl
IG9mIDFHQiBodWdlcGFnZSBwb29sLCBjYXVzZWQgYnkgdGhlIGZvbGxvd2luZw0KPiA+ID4gPj4+
IHByb2NlZHVyZToNCj4gPiA+ID4+Pg0KPiA+ID4gPj4+ICAgLSBydW4gYSBwcm9jZXNzIHJlc2Vy
dmluZyBhbGwgZnJlZSAxR0IgaHVnZXBhZ2VzLA0KPiA+ID4gPj4+ICAgLSBzaHJpbmsgZnJlZSAx
R0IgaHVnZXBhZ2UgcG9vbCB0byB6ZXJvIChpLmUuIHdyaXRpbmcgMCB0bw0KPiA+ID4gPj4+ICAg
ICAvc3lzL2tlcm5lbC9tbS9odWdlcGFnZXMvaHVnZXBhZ2VzLTEwNDg1NzZrQi9ucl9odWdlcGFn
ZXMpLCB0aGVuDQo+ID4gPiA+Pj4gICAtIGtpbGwgdGhlIHJlc2VydmluZyBwcm9jZXNzLg0KPiA+
ID4gPj4+DQo+ID4gPiA+Pj4gLCB0aGVuIGFsbCB0aGUgaHVnZXBhZ2VzIGFyZSBmcmVlICphbmQq
IHN1cnBsdXMgYXQgdGhlIHNhbWUgdGltZS4NCj4gPiA+ID4+Pg0KPiA+ID4gPj4+ICAgJCBjYXQg
L3N5cy9rZXJuZWwvbW0vaHVnZXBhZ2VzL2h1Z2VwYWdlcy0xMDQ4NTc2a0IvbnJfaHVnZXBhZ2Vz
DQo+ID4gPiA+Pj4gICAzDQo+ID4gPiA+Pj4gICAkIGNhdCAvc3lzL2tlcm5lbC9tbS9odWdlcGFn
ZXMvaHVnZXBhZ2VzLTEwNDg1NzZrQi9mcmVlX2h1Z2VwYWdlcw0KPiA+ID4gPj4+ICAgMw0KPiA+
ID4gPj4+ICAgJCBjYXQgL3N5cy9rZXJuZWwvbW0vaHVnZXBhZ2VzL2h1Z2VwYWdlcy0xMDQ4NTc2
a0IvcmVzdl9odWdlcGFnZXMNCj4gPiA+ID4+PiAgIDANCj4gPiA+ID4+PiAgICQgY2F0IC9zeXMv
a2VybmVsL21tL2h1Z2VwYWdlcy9odWdlcGFnZXMtMTA0ODU3NmtCL3N1cnBsdXNfaHVnZXBhZ2Vz
DQo+ID4gPiA+Pj4gICAzDQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiBUaGlzIHN0YXRlIGlzIHJlc29s
dmVkIGJ5IHJlc2VydmluZyBhbmQgYWxsb2NhdGluZyB0aGUgcGFnZXMgdGhlbg0KPiA+ID4gPj4+
IGZyZWVpbmcgdGhlbSBhZ2Fpbiwgc28gdGhpcyBzZWVtcyBub3QgdG8gcmVzdWx0IGluIHNlcmlv
dXMgcHJvYmxlbS4NCj4gPiA+ID4+PiBCdXQgaXQncyBhIGxpdHRsZSBzdXJwcml6aW5nIChzaHJp
bmtpbmcgcG9vbCBzdWRkZW5seSBmYWlscykuDQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiBUaGlzIGJl
aGF2aW9yIGlzIGNhdXNlZCBieSBoc3RhdGVfaXNfZ2lnYW50aWMoKSBjaGVjayBpbg0KPiA+ID4g
Pj4+IHJldHVybl91bnVzZWRfc3VycGx1c19wYWdlcygpLiBUaGlzIHdhcyBpbnRyb2R1Y2VkIHNv
IGxvbmcgYWdvIGluIDIwMDgNCj4gPiA+ID4+PiBieSBjb21taXQgYWE4ODhhNzQ5NzdhICgiaHVn
ZXRsYjogc3VwcG9ydCBsYXJnZXIgdGhhbiBNQVhfT1JERVIiKSwgYW5kDQo+ID4gPiA+Pj4gaXQg
c2VlbXMgdG8gbWUgdGhhdCB0aGlzIGNoZWNrIGlzIG5vIGxvbmdlciB1bm5lY2Vzc2FyeS4gTGV0
J3MgcmVtb3ZlIGl0Lg0KPiANCj4gVGhhbmsgeW91IGZvciBmaW5kaW5nIHRoaXMhISENCj4gDQo+
ID4gPiA+Pj4gKysrIGIvbW0vaHVnZXRsYi5jDQo+ID4gPiA+Pj4gQEAgLTI0MzIsMTAgKzI0MzIs
NiBAQCBzdGF0aWMgdm9pZCByZXR1cm5fdW51c2VkX3N1cnBsdXNfcGFnZXMoc3RydWN0IGhzdGF0
ZSAqaCwNCj4gPiA+ID4+PiAgCS8qIFVuY29tbWl0IHRoZSByZXNlcnZhdGlvbiAqLw0KPiA+ID4g
Pj4+ICAJaC0+cmVzdl9odWdlX3BhZ2VzIC09IHVudXNlZF9yZXN2X3BhZ2VzOw0KPiA+ID4gPj4+
ICANCj4gPiA+ID4+PiAtCS8qIENhbm5vdCByZXR1cm4gZ2lnYW50aWMgcGFnZXMgY3VycmVudGx5
ICovDQo+ID4gPiA+Pj4gLQlpZiAoaHN0YXRlX2lzX2dpZ2FudGljKGgpKQ0KPiA+ID4gPj4+IC0J
CWdvdG8gb3V0Ow0KPiA+ID4gPj4+IC0NCj4gPiA+ID4+DQo+ID4gPiA+PiBJSVVDIGl0IG1pZ2h0
IGJlIGJldHRlciB0byBkbyB0aGUgYmVsb3cgY2hlY2s6DQo+ID4gPiA+PiAJLyoNCj4gPiA+ID4+
IAkgKiBDYW5ub3QgcmV0dXJuIGdpZ2FudGljIHBhZ2VzIGN1cnJlbnRseSBpZiBydW50aW1lIGdp
Z2FudGljIHBhZ2UNCj4gPiA+ID4+IAkgKiBhbGxvY2F0aW9uIGlzIG5vdCBzdXBwb3J0ZWQuDQo+
ID4gPiA+PiAJICovDQo+ID4gPiA+PiAJaWYgKGhzdGF0ZV9pc19naWdhbnRpYyhoKSAmJiAhZ2ln
YW50aWNfcGFnZV9ydW50aW1lX3N1cHBvcnRlZCgpKQ0KPiA+ID4gPj4gCQlnb3RvIG91dDsNCj4g
PiA+ID4+DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgY2hhbmdlIGxvb2tzIGdvb2QgdG8gbWUuIEhv
d2V2ZXIsIHRoZSBjb21tZW50cyBhYm92ZSBpcyB1bm5lY2Vzc2FyeQ0KPiA+ID4gPiBzaW5jZSBn
aWdhbnRpY19wYWdlX3J1bnRpbWVfc3VwcG9ydGVkKCkgaXMgc3RyYWlnaHRmb3J3YXJkLg0KPiA+
ID4gDQo+ID4gPiBBZ3JlZS4gVGhlIGNvbW1lbnRzIGNhbiBiZSByZW1vdmVkLg0KPiA+IA0KPiA+
IFRoYW5rIHlvdSwgYm90aC4gQWRkaW5nICFnaWdhbnRpY19wYWdlX3J1bnRpbWVfc3VwcG9ydGVk
IHdpdGhvdXQgY29tbWVudA0KPiA+IG1ha2VzIHNlbnNlIHRvIG1lLg0KPiANCj4gVGhlIGNoYW5n
ZSBhYm92ZSBtYWtlcyBzZW5zZSB0byBtZS4gIEhvd2V2ZXIsIC4uLg0KPiANCj4gSWYgd2UgbWFr
ZSB0aGUgY2hhbmdlIGFib3ZlLCB3aWxsIHdlIGhhdmUgdGhlIHNhbWUgc3RyYW5nZSBzaXR1YXRp
b24gZGVzY3JpYmVkDQo+IGluIHRoZSBjb21taXQgbWVzc2FnZSB3aGVuICFnaWdhbnRpY19wYWdl
X3J1bnRpbWVfc3VwcG9ydGVkKCkgaXMgdHJ1ZT8NCj4gDQo+IElJVUMsICFnaWdhbnRpY19wYWdl
X3J1bnRpbWVfc3VwcG9ydGVkIGltcGxpZXMgdGhhdCBnaWdhbnRpYyBodWdldGxiDQo+IHBhZ2Vz
IGNhbiBub3QgYmUgYWxsb2NhdGVkIG9yIGZyZWVkIGF0IHJ1biB0aW1lLiAgVGhleSBjYW4gb25s
eSBiZQ0KPiBhbGxvY2F0ZWQgYXQgYm9vdCB0aW1lLiAgU28sIHRoZXJlIHNob3VsZCBORVZFUiBi
ZSBzdXJwbHVzIGdpZ2FudGljDQo+IHBhZ2VzIGlmICFnaWdhbnRpY19wYWdlX3J1bnRpbWVfc3Vw
cG9ydGVkKCkuDQoNCkkgaGF2ZSB0aGUgc2FtZSB1bmRlcnN0YW5kaW5nIGFzIHRoZSBhYm92ZS4N
Cg0KPiAgVG8gYXZvaWQgdGhpcyBzaXR1YXRpb24sDQo+IHBlcmhhcHMgd2Ugc2hvdWxkIGNoYW5n
ZSBzZXRfbWF4X2h1Z2VfcGFnZXMgYXMgZm9sbG93cyAobm90IHRlc3RlZCk/DQoNClRoZSBzdWdn
ZXN0ZWQgZGlmZiBsb29rcyBjbGVhcmVyIGFib3V0IHdoYXQgaXQgZG9lcywgc28gSSdkIGxpa2Ug
dG8gdGFrZSBpdA0KaW4gdGhlIG5leHQgdmVyc2lvbi4gIFRoZW4sIHdoYXQgZG8gd2UgZG8gb24g
dGhlICJpZiAoaHN0YXRlX2lmX2dpZ2FudGljKCkpIg0KY2hlY2sgaW4gcmV0dXJuX3VudXNlZF9z
dXJwbHVzX3BhZ2VzIGluIHRoZSBvcmlnaW5hbCBzdWdnZXN0aW9uPyAgU2hvdWxkIGl0DQpiZSBr
ZXB0IGFzIGlzLCBvciByZW1vdmVkLCBvciBjaGVja2VkIHdpdGggIWdpZ2FudGljX3BhZ2VfcnVu
dGltZV9zdXBwb3J0ZWQoKT8NCkkgZ3Vlc3MgdGhhdCB0aGUgbmV3IGNoZWNrcyBwcmV2ZW50IGNh
bGxpbmcgcmV0dXJuX3VudXNlZF9zdXJwbHVzX3BhZ2VzKCkNCmR1cmluZyBwb29sIHNocmlua2lu
Zywgc28gdGhlIGNoZWNrIHNlZW1zIG5vdCBuZWNlc3NhcnkgYW55IG1vcmUuDQoNClRoYW5rcywN
Ck5hb3lhIEhvcmlndWNoaQ0KDQo+IA0KPiAtLSANCj4gTWlrZSBLcmF2ZXR6DQo+IA0KPiANCj4g
ZGlmZiAtLWdpdCBhL21tL2h1Z2V0bGIuYyBiL21tL2h1Z2V0bGIuYw0KPiBpbmRleCA1ZWFiYjgw
MDlkOGEuLmM3OGQ2YzIwZTZiMCAxMDA2NDQNCj4gLS0tIGEvbW0vaHVnZXRsYi5jDQo+ICsrKyBi
L21tL2h1Z2V0bGIuYw0KPiBAQCAtMzQxNiw3ICszNDE2LDggQEAgc3RhdGljIGludCBzZXRfbWF4
X2h1Z2VfcGFnZXMoc3RydWN0IGhzdGF0ZSAqaCwgdW5zaWduZWQgbG9uZyBjb3VudCwgaW50IG5p
ZCwNCj4gIAkgKiB0aGUgdXNlciB0cmllcyB0byBhbGxvY2F0ZSBnaWdhbnRpYyBwYWdlcyBidXQg
bGV0IHRoZSB1c2VyIGZyZWUgdGhlDQo+ICAJICogYm9vdHRpbWUgYWxsb2NhdGVkIGdpZ2FudGlj
IHBhZ2VzLg0KPiAgCSAqLw0KPiAtCWlmIChoc3RhdGVfaXNfZ2lnYW50aWMoaCkgJiYgIUlTX0VO
QUJMRUQoQ09ORklHX0NPTlRJR19BTExPQykpIHsNCj4gKwlpZiAoaHN0YXRlX2lzX2dpZ2FudGlj
KGgpICYmICghSVNfRU5BQkxFRChDT05GSUdfQ09OVElHX0FMTE9DKSB8fA0KPiArCQkJCQkhZ2ln
YW50aWNfcGFnZV9ydW50aW1lX3N1cHBvcnRlZCgpKSkgew0KPiAgCQlpZiAoY291bnQgPiBwZXJz
aXN0ZW50X2h1Z2VfcGFnZXMoaCkpIHsNCj4gIAkJCXNwaW5fdW5sb2NrX2lycSgmaHVnZXRsYl9s
b2NrKTsNCj4gIAkJCW11dGV4X3VubG9jaygmaC0+cmVzaXplX2xvY2spOw0KPiBAQCAtMzQ2NCw2
ICszNDY1LDE5IEBAIHN0YXRpYyBpbnQgc2V0X21heF9odWdlX3BhZ2VzKHN0cnVjdCBoc3RhdGUg
KmgsIHVuc2lnbmVkIGxvbmcgY291bnQsIGludCBuaWQsDQo+ICAJCQlnb3RvIG91dDsNCj4gIAl9
DQo+ICANCj4gKwkvKg0KPiArCSAqIFdlIGNhbiBub3QgZGVjcmVhc2UgZ2lnYW50aWMgcG9vbCBz
aXplIGlmIHJ1bnRpbWUgbW9kaWZpY2F0aW9uDQo+ICsJICogaXMgbm90IHN1cHBvcnRlZC4NCj4g
KwkgKi8NCj4gKwlpZiAoaHN0YXRlX2lzX2dpZ2FudGljKGgpICYmICFnaWdhbnRpY19wYWdlX3J1
bnRpbWVfc3VwcG9ydGVkKCkpIHsNCj4gKwkJaWYgKGNvdW50IDwgcGVyc2lzdGVudF9odWdlX3Bh
Z2VzKGgpKSB7DQo+ICsJCQlzcGluX3VubG9ja19pcnEoJmh1Z2V0bGJfbG9jayk7DQo+ICsJCQlt
dXRleF91bmxvY2soJmgtPnJlc2l6ZV9sb2NrKTsNCj4gKwkJCU5PREVNQVNLX0ZSRUUobm9kZV9h
bGxvY19ub3JldHJ5KTsNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiArCQl9DQo+ICsJfQ0KPiAr
DQo+ICAJLyoNCj4gIAkgKiBEZWNyZWFzZSB0aGUgcG9vbCBzaXplDQo+ICAJICogRmlyc3QgcmV0
dXJuIGZyZWUgcGFnZXMgdG8gdGhlIGJ1ZGR5IGFsbG9jYXRvciAoYmVpbmcgY2FyZWZ1bA==
