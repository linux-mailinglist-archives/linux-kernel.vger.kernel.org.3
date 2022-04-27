Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8D15117DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbiD0MYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiD0MYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:24:09 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2088.outbound.protection.outlook.com [40.107.113.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729214924F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:20:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZAxZd9ltbIw1QRseF8cGI+dLMzXDO2jqqAbH72ejDBuAIO6at3oq7L0rk9ecAjvFo1h7gtOzIRBeKzntIdkdfashhSYf7PPyfiYpnVhhreNJfp9UV2+bGyimGykTTqwq+PGnvu4nA8oQmobN2UidlNHhN7RXWGr2Vr/qQhJoQG7+4rqpVdSnpmNlhfVgcYTJu3ogj1Ju/TGmtIMC1XvGMajs+AkkQpfgr3LdlTqvrYtsjxAGneEppB/ZLTi5sY6gluM8YHw2M4nTnvIh9wWKXs8nDFzXWIw1lsX1aHwouAWJgDn8TrUBTOTNJ3E4347UtdRQFcmEL4sSCsIakGmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL6u5xkrFwVWN0yGTRJDbDC6J8sXBQiK73XEZOBHNL4=;
 b=ab7aocT9ioF2dpXYNKMl/whCUJFU1ZejUl3SrYW6e46pqZEb1s6oCCX9xGE7vd7gtq5CLo3ypFc23pqOdgpGU9QdHHKk5ZpDzMyp4gYD4Km1hrQOTyMvvulZa++uQlMmo8yxmMCazLCaiEEb7HRXPYcoeh9quG8k12dfkMGZ45YeB9n8eWL94v8c62czCVuSvxkS63V5GlXKxzIYCjhosuWWkqWqSJ60vLUqOPSaKUSLTyCuZjLPBDkWwgS09gSnBxvY+moxvyrxA/IjGI2tf48VvJlrq10+h6dbe91ZVKP2cyRQ1p+q7MhURk76wYu2+v8L/ioI5oVMnPwFAZcthA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fL6u5xkrFwVWN0yGTRJDbDC6J8sXBQiK73XEZOBHNL4=;
 b=Cn4LEUMgKUGXBuESsw7AzgaTGa6aaLTFCiVpM0iyh/TAq9sKsG9JEXK5Zr9ju6z3gb94Ti5W4g8IQdSrNkRzEch86hb4W+ar75unBNEXD64c5GZn+gTfd/DAR7w6c8mkvPduG/jDKPQ2U59vDlsPwOnl5c3h/dFkuCM4A5bsZ4w=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY2PR01MB2857.jpnprd01.prod.outlook.com (2603:1096:404:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Wed, 27 Apr
 2022 12:20:50 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::e58f:5f3b:6d28:b245]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::e58f:5f3b:6d28:b245%4]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 12:20:50 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
Thread-Topic: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
Thread-Index: AQHYWe9WIfS7YLZ5REqhyMUPm2f3sK0DlLoAgAAZ3IA=
Date:   Wed, 27 Apr 2022 12:20:50 +0000
Message-ID: <20220427122049.GA3918978@hori.linux.bs1.fc.nec.co.jp>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
In-Reply-To: <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5a16769-2901-4f94-fd86-08da28485df2
x-ms-traffictypediagnostic: TY2PR01MB2857:EE_
x-microsoft-antispam-prvs: <TY2PR01MB2857CFBFEEF0D3507C236668E7FA9@TY2PR01MB2857.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +dwRl6I60c/Zk6B59ck65VM0qsBDzs2KLl4bgMSflcfTypV7mHxDV87G3w+zkFgY/hinVOYBYauEVaqD+nZPuSjFHRSf2Pw3OPZMjilIk9fosFzTy1IPtOEA2HNkyJtC9FBFlnu5gyVWV9MDlkXOxIA+PonRQMHa7zR/mj4Kc5ljhUMuDIdmNxA/yZ+EDuWM4I4Vnwktaud+jv4SWLktZoEYknulL2QP7ZEffMfsP9CkXcktoPiDlrjdJumeHI5op7oCaiciQiB207lBxHffJC60FHAv2+M9YhgunIor0yctQJb8b8JNr/lGCAHlcAffift+b5UEn8f4t0NApIxeH4a8wg40S8urA6MkuWfla8IxzmyukF/7EuJ88mHG6jyliX6F0czu4HJ5Fbp00gatCSgznMzND4wFfN0UY0Z/5MZ1Okr/d6tInh01t9sVnMH64FKvNX0/nhgExH3NLA/Smbgx6+1TYSbVSMbt60UAIj6So+5p/7AN7jDecFXZnXpLjyphhrRmRwO/aQY1PTe5x9rVdHBbZVjNJI5E9A+LoQ/vNIb38/nJ1orzJO0DxRqYcDCRTx4RF7mXUueHDRZUXiHxxMCRb3tw+Qx4YQiaZiUEdUjPXtGOWIGiQ0NGOhh2ffWJvhpUGAPOquxbqUqLxh1zjK6zU5y+zY1zOUbCOI1gz/iR/i3Uxc7+SKfd4xC+wKCCasaaB5nDR906xQ2IyMao/iP7k0/ptvO1dEhD3bb5+sAglipIRrFpwGN02E0LPt5OF6UuBe9LztDSSc+nhJ+78u5Hwd5yq8wdFOe3GbTzzbWFnG8vQSuVwnm8iW1D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66446008)(316002)(66476007)(82960400001)(122000001)(4326008)(76116006)(66556008)(64756008)(85182001)(8676002)(6916009)(38100700002)(38070700005)(8936002)(5660300002)(71200400001)(508600001)(966005)(6486002)(86362001)(6512007)(26005)(1076003)(9686003)(53546011)(33656002)(55236004)(6506007)(7416002)(186003)(2906002)(83380400001)(54906003)(25903002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFF4M1pzVDN6SEU0T1NMUU9vVTQzVDYwbmoyWThsM1M5cWw5NlcyMTJDTDRP?=
 =?utf-8?B?S1NqSmNKUXFUcE9aNkdUTURUVnJJc21aNlhEUkVXSUQrbzRHNGJJSEhxa1JF?=
 =?utf-8?B?NUJIVkZWeHlyUlhxY0w3WXpUd29nQW80QmxIamYxKzB6NlZCT2t1VUxLVk9m?=
 =?utf-8?B?Y2tnV0poSnNDdlhISXZ2K3JzdE1tSWZmVEUwNVFoc2xkR0JWelNzcmFscVdZ?=
 =?utf-8?B?R3ZHQytmTkVsbit1M1hxUWFwSmUvTWp0NlhRV21oVWlvVzNmeUFCditoM3Bm?=
 =?utf-8?B?Y3JkK3lzMjM4TWx0N09VUW5VRDVJaXp6aExJblFhUmVOdUM5NVd0cXN0a1hF?=
 =?utf-8?B?N21FdU1ldnh3QmZnbUZFZ2p3dUJFa29IZUhGOUEwbW5jK2txUkdQT2pDY0xB?=
 =?utf-8?B?alhuT2dtRVhYbVY4eCtwR0diK2F6aVhJa1Q3WTFreDNkelFvV1FFaVR2aFNK?=
 =?utf-8?B?T0plUlJXb0x4NE85U3lrbEJPYXJ4N3pEai9UNDZqc2VlL2pIb0NNT3lESmxE?=
 =?utf-8?B?YmRlNFpWOE53V1NXdzg0MFo1MkxTemhheEFSUHBOQ1Q3cnN2TG5OcExva0pU?=
 =?utf-8?B?N0lXUkdPL1UwdER0cVZpa1l5c3h1SXNHTENucy9EYTU3NjBmWmllalhFMGc3?=
 =?utf-8?B?Y1lVR0VmREtwUjhYSWZrZDZ3enRteXhSV3l5U3VJVlMyNVNqYVFHUGdFS0R2?=
 =?utf-8?B?UGhoWVc1cTNSL0FlMWZ2MHFIOWdvb1pRcU9CVzJ5aU1VaTVUWmptS1BpUU9Y?=
 =?utf-8?B?eWNNOSt2VGppUFYwNnh4Q2xzM1J3RE5hOWs5OVZQcGR5WlVnZ0FzMzg4MkYr?=
 =?utf-8?B?aG9Kbks0eG9wRlFmYmxJTWdpYzlNVlRHUSsvT1NnMDJyRUNrS08xdUJUYU1i?=
 =?utf-8?B?aHFnQmgxc0lzNnFBWjNicnR2UGNuU0s5eXVtTm51Z052R2pYaXhabWRESmNk?=
 =?utf-8?B?RUYxaUVRZGN5NVRxUjJFYU5VZ0NsVHZuRmp4R1F3SVE0VzQwZHR6TFR3bE42?=
 =?utf-8?B?UStvVEc3dTQ5UDFvNTh2dkFXNkw3YkdCV1UvVEwxTnp2cDg4d2Z6d3BTSEdT?=
 =?utf-8?B?WUFqZnlGMUZiek4rVlplNzZaV1lBaVFFVjJrd0lNbm1GWVhNRERyV2pmYzhQ?=
 =?utf-8?B?VzBHbzdyZkpuR1R1cmVTak5JRiswbTgrUlE3TzhHT1BVOE40TVNrWk5OaFcw?=
 =?utf-8?B?bEl1VGh4Z1dwYTdjU0hWemQ0dld1RTJNMFV6QzJDSkVHaWxqbCt5eWgyL1Z4?=
 =?utf-8?B?V2RqV1UyaGFWUDdhais2WklMbm5od1FEL2FnWmdWUyt2ZzF1WUZQV3FXOFJG?=
 =?utf-8?B?VkovREs0T25Hb1ZRQnFJRE83UmlwdURxZWtoUWJucFJtZjd0dGYrZ21WWlcv?=
 =?utf-8?B?MUl6cll6Vi93ZW9sNnZUTUduSG10SEdqSWdkM0dUWjJWT0lYY2EzeWg1S0to?=
 =?utf-8?B?eHV6SmxqUE9RQjIyUmR2bXVRT3RaUDJrWVZqUHljWWkycEJrZ0JTNWVQUHlC?=
 =?utf-8?B?RlJMbFhhbThvSzh3S0xBcnBTNG0xcnRIcnJnNkJLaVpqVUR0Qm9BRC9XbjFx?=
 =?utf-8?B?Qk9MeE9RN1NXMTA2enMwZWpjQSszbncxMzJXNmJCaDdjdXlNejJzTVI5Y3Rp?=
 =?utf-8?B?UkNBYXpwWCthOEdmWmUzS0VDYytVd0FFR2pOT1Z0azk1K3lTckJJbFlxUHdL?=
 =?utf-8?B?UVhidlJ6YnlkS1FGNHlyRnlObWt6Y1duQWpnMGUwMHczL1ZpN0treDM3ZU5h?=
 =?utf-8?B?dFlxdXdidk5nUGtsOWt1dW9qczBDQ2wvVml0UTZMblZsV2xVOTZhY2lzZUNk?=
 =?utf-8?B?QWNGS0d2SysyeUZ6THp0cFE3cnhFdFNqaDdjeHl5dENtTWV2TmhMZGNJODdM?=
 =?utf-8?B?L0dwMzdyZHhvcWhHODYrSlNkZ2tmVEtrRnZSVjA4TlVsL3p4VEVJNlNRS1Nu?=
 =?utf-8?B?TmlJSjJYMVJjczJIVTYvNEJ6ZW9CQmg3Q0liT0xFYzR2dDBydlF3U0tkenVu?=
 =?utf-8?B?SnV5Q1hKTi92aDdJWm1qVXR4eFhTeUYzSmVIc2huUmhRaTdsY3BUYndPRWZK?=
 =?utf-8?B?SkRDdTdKd3pYVDJRNWJNL05aeDRweTVSVW4zQVhuaDNJV29NcjJxYXZHUUZh?=
 =?utf-8?B?dlFZSW5Jc0g4TGJPblFmb2xNdXVqOVB0a0I0YzkwWXhocGFjZGpRcFRYZ0c0?=
 =?utf-8?B?WW9CTy96L3FldkdBWEE5Y2VDTUZldWY4V28vRWZJSG0yaFVDZ0gvL2FPcGIv?=
 =?utf-8?B?bzFPVFA2Qzdpak1yYXNhUU9leUJLZmJYK0o5T0QwRVBINmFXL3dLd0t1VU9j?=
 =?utf-8?B?SVJNTzRzUU95TlRYSVAvYUgxMnNvWXorc2IxdkhSbjN5bG8zNVFnakF1bTNY?=
 =?utf-8?Q?qx3lTSzAwisezuSc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <322620417B7FF74EB8779711B6992E95@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a16769-2901-4f94-fd86-08da28485df2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 12:20:50.4839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4otn+O8mVnM7pk4lIZRpH8lsMB/Etqh8Ic+7RH4HFSEElRSI4oDe+BU/f1uzqVzZOLPCzDcefHT+XLINP5UYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2857
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBcHIgMjcsIDIwMjIgYXQgMTI6NDg6MTZQTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6DQo+IE9uIDI3LjA0LjIyIDA2OjI4LCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+
ID4gSGksDQo+ID4gDQo+ID4gVGhpcyBwYXRjaHNldCBhZGRyZXNzZXMgc29tZSBpc3N1ZXMgb24g
dGhlIHdvcmtsb2FkIHJlbGF0ZWQgdG8gaHdwb2lzb24sDQo+ID4gaHVnZXRsYiwgYW5kIG1lbW9y
eV9ob3RwbHVnLiAgVGhlIHByb2JsZW0gaW4gbWVtb3J5IGhvdHJlbW92ZSByZXBvcnRlZCBieQ0K
PiA+IE1pYW9oZSBMaW4gWzFdIGlzIG1lbnRpb25lZCBpbiAyLzQuICBUaGlzIHBhdGNoIGRlcGVu
ZHMgb24gInN0b3JpbmcgcmF3DQo+ID4gZXJyb3IgaW5mbyIgZnVuY3Rpb25hbGl0eSBwcm92aWRl
ZCBieSAxLzQuIFRoaXMgcGF0Y2ggYWxzbyBwcm92aWRlIGRlbGF5ZWQNCj4gPiBkaXNzb2x2ZSBm
dW5jdGlvbiB0b28uDQo+ID4gDQo+ID4gUGF0Y2ggMy80IGlzIHRvIGFkanVzdCB1bnBvaXNvbiB0
byBuZXcgc2VtYW50aWNzIG9mIEhQYWdlTWlncmF0YWJsZSBmb3INCj4gPiBod3BvaXNvbmVkIGh1
Z2VwYWdlLiBBbmQgNC80IGlzIHRoZSBmaXggZm9yIHRoZSBpbmNvbnNpc3RlbnQgY291bnRlciBp
c3N1ZS4NCj4gPiANCj4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vMjAy
MjA0MjExMzUxMjkuMTk3NjctMS1saW5taWFvaGVAaHVhd2VpLmNvbS8NCj4gPiANCj4gPiBQbGVh
c2UgbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIGFuZCBjb21tZW50cy4N
Cj4gPiANCj4gDQo+IEhpLA0KPiANCj4gSSByYWlzZWQgc29tZSB0aW1lIGFnbyBhbHJlYWR5IHRo
YXQgSSBkb24ndCBxdWl0ZSBzZWUgdGhlIHZhbHVlIG9mDQo+IGFsbG93aW5nIG1lbW9yeSBvZmZs
aW5pbmcgd2l0aCBwb2lzZW5lZCBwYWdlcy4NCj4gDQo+IDEpIEl0IG92ZXJjb21wbGljYXRlcyB0
aGUgb2ZmbGluaW5nIGNvZGUgYW5kIHNlZW1zIHRvIGJlIHBhcnRpYWxseQ0KPiAgICBicm9rZW4N
Cg0KWWVzLCB0aGUgY3VycmVudCBjb2RlIGhhcyByb29tcyBvZiBpbXByb3ZlbWVudC4gIE1heWJl
IHBhZ2UgcmVmY291bnQNCm9mIGh3cG9pc29uZWQgcGFnZXMgaXMgb25lIG9mIHRoZW0uDQoNCj4g
MikgSXQgaGFwcGVucyByYXJlbHkgKGV2ZXI/KSwgc28gZG8gd2UgZXZlbiBjYXJlPw0KDQpJJ20g
bm90IGNlcnRhaW4gb2YgdGhlIHJhcml0eS4gIFNvbWUgY2xvdWQgc2VydmljZSBwcm92aWRlcnMg
d2hvIG1haW50YWluDQpsb3RzIG9mIHNlcnZlcnMgbWF5IGNhcmU/DQoNCj4gMykgT25jZSB0aGUg
bWVtb3J5IGlzIG9mZmxpbmUsIHdlIGNhbiByZS1vbmxpbmUgaXQgYW5kIGxvc3QgSFdQb2lzb24u
DQo+ICAgIFRoZSBtZW1vcnkgY2FuIGJlIGhhcHBpbHkgdXNlZC4NCj4gDQo+IDMpIGNhbiBoYXBw
ZW4gZWFzaWx5IGlmIG91ciBESU1NIGNvbnNpc3RzIG9mIG11bHRpcGxlIG1lbW9yeSBibG9ja3Mg
YW5kDQo+IG9mZmxpbmluZyBvZiBzb21lIG1lbW9yeSBibG9jayBmYWlscyAtPiB3ZSdsbCByZS1v
bmxpbmUgYWxsIGFscmVhZHkNCj4gb2ZmbGluZWQgb25lcy4gV2UnbGwgaGFwcGlseSByZXVzZSBw
cmV2aW91c2x5IEhXUG9pc29uZWQgcGFnZXMsIHdoaWNoDQo+IGZlZWxzIG1vcmUgZGFuZ2Vyb3Vz
IHRvIG1lIHRoZW4ganVzdCBsZWF2aW5nIHRoZSBESU1NIGFyb3VuZCAoYW5kDQo+IGV2ZW50dWFs
bHkgaHdwb2lzb25pbmcgYWxsIHBhZ2VzIG9uIGl0IHN1Y2ggdGhhdCBpdCB3b24ndCBnZXQgdXNl
ZA0KPiBhbnltb3JlPykuDQoNCkkgc2VlLiBUaGlzIHNjZW5hcmlvIGNhbiBvZnRlbiBoYXBwZW4u
DQoNCj4gDQo+IFNvIG1heWJlIHdlIHNob3VsZCBqdXN0IGZhaWwgb2ZmbGluaW5nIG9uY2Ugd2Ug
c3R1bWJsZSBvdmVyIGEgaHdwb2lzb25lZA0KPiBwYWdlPw0KDQpUaGF0IGNvdWxkIGJlIG9uZSBj
aG9pY2UuDQoNCk1heWJlIGFub3RoZXIgaXMgbGlrZSB0aGlzOiBvZmZsaW5pbmcgY2FuIHN1Y2Nl
ZWQgYnV0IEhXUG9pc29uIGZsYWdzIGFyZQ0Ka2VwdCBvdmVyIG9mZmxpbmUtcmVvbmxpbmUgb3Bl
cmF0aW9ucy4gIElmIHRoZSBzeXN0ZW0gbm90aWNlZCB0aGF0IHRoZQ0KcmUtb25saW5lZCBibG9j
a3MgYXJlIGJhY2tlZCBieSB0aGUgb3JpZ2luYWwgRElNTXMgb3IgTlVNQSBub2RlcywgdGhlbiB0
aGUNCnNhdmVkIEhXUG9pc29uIGZsYWdzIGFyZSBzdGlsbCBlZmZlY3RpdmUsIHNvIGtlZXAgdXNp
bmcgdGhlbS4gIElmIHRoZQ0KcmUtb25saW5lZCBibG9ja3MgYXJlIGJhY2tlZCBieSByZXBsYWNl
ZCBESU1Ncy9OVU1BIG5vZGVzLCB0aGVuIHdlIGNhbiBjbGVhcg0KYWxsIEhXUG9pc29uIGZsYWdz
IGFzc29jaWF0ZWQgd2l0aCByZXBsYWNlZCBwaHlzaWNhbCBhZGRyZXNzIHJhbmdlLiAgVGhpcw0K
Y2FuIGJlIGRvbmUgYXV0b21hdGljYWxseSBpbiByZS1vbmxpbmluZyBpZiB0aGVyZSdzIGEgd2F5
IGZvciBrZXJuZWwgdG8ga25vdw0Kd2hldGhlciBESU1NL05VTUEgbm9kZXMgYXJlIHJlcGxhY2Vk
IHdpdGggbmV3IG9uZXMuICBCdXQgaWYgdGhlcmUgaXNuJ3QsDQpzeXN0ZW0gYXBwbGljYXRpb25z
IGhhdmUgdG8gY2hlY2sgdGhlIEhXIGFuZCBleHBsaWNpdGx5IHJlc2V0IHRoZSBIV1BvaXNvbg0K
ZmxhZ3MuDQoNCj4gDQo+IFllcywgd2Ugd291bGQgZGlzYWxsb3cgcmVtb3ZpbmcgYSBzZW1pLWJy
b2tlbiBESU1NIGZyb20gdGhlIHN5c3RlbSB0aGF0DQo+IHdhcyBvbmxpbmVkIE1PVkFCTEUuIEkg
d29uZGVyIGlmIHdlIHJlYWxseSBuZWVkIHRoYXQgYW5kIGhvdyBvZnRlbiBpdA0KPiBoYXBwZW5z
IGluIHJlYWwgbGlmZS4gTW9zdCBzeXN0ZW1zIEkgYW0gYXdhcmUgb2YgZG9uJ3QgYWxsb3cgZm9y
DQo+IHJlcGxhY2luZyBpbmRpdmlkdWFsIERJTU1zLCBidXQgb25seSBjb21wbGV0ZSBOVU1BIG5v
ZGVzLiBIbS4NCg0KWWVzLCBtYXliZSBtb3N0IHNlcnZlcnMgZG8gbm90IHByb3ZpZGUgZGlyZWN0
IHBoeXNpY2FsIGFjY2VzcyB0byBESU1Ncy4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
