Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5725AFAFD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIGENF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIGENC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:13:02 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2066.outbound.protection.outlook.com [40.107.113.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B6E27157
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 21:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wff+bSs6pdfTjPWJZJrr5oEvW4IY4DWhMFGHoPjVWwhI0KxFdMJ9xTx9YMSJH7EWbbYyqAyrIlTLfJH1ZmdgxXK4WHFc5nKoPKfEPPDnqrx6ldWRJgX2tEqzbIcR6YreUznFu9TmfumCQf8jAZPOa71bAyo14WfYWVRlwnVSBjeVB+g+pFNnGlo5/oICaKBd0qmHiDYOZpW2dVERBzq5ZE29a96L9i+xiIkFIlLOovjY8erQ/3LFB+1W5qLu22b2KQyNrZPUtNoujOaHxIdM9+DDePNCMMUjIjPobqVix090DjfjgcoI5yNEuFycZa37lchdWJJJdWJdt2Sw9IgJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA7YqRZD2/kYQ9PNM0flpTK0jew/cIL6jnYeQQBjeCI=;
 b=ZQYrEt+s0H/g3zOMlcCDoseH/5IzVF/TAMGCwdbxcV4xVX34WPSGiJdpy1idsTfP+oeME08jsLzzTLWe+ME/B4rcSjc8h0z0QBSGnWHirrp67OuI1x70KUEtQy7A1TCUK9fA4MX52kgdio/SRgRxn6kMmwaGfq+W9IuZBg7Xf3f1IAtLWAvl+7qrylPvNIf22DQFy+SLSX6yW/9kKGbmhSwrUsi5AGHRolZq+HM482ggbhG0W4BeFZjKBvmDA3s9SmNSmBQpma+lnAgg6CkrWpmTmOERu/qpk7jnkOGIEEKN5t4vs5h+W64B4UgXnyU43FQi7r0r5OlGzJm/CsvjZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xA7YqRZD2/kYQ9PNM0flpTK0jew/cIL6jnYeQQBjeCI=;
 b=cp24/I3qBq3iKEZ0bf4zwuT/GgYyCgcq7Jxt6vxlwddytYWqdc2Hbrrj/2giVZUXWh974oprAu59sRNRitgPI5vTCnCcwZRbB+ZAAyQpB/GeeRA+KvcipQPfzYc4jzqxMuhqkIpegCod9RZUXKwZuHrB78WUOEjLUX7Ax5fGCXc=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB7726.jpnprd01.prod.outlook.com (2603:1096:400:17b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 04:12:58 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5588.011; Wed, 7 Sep 2022
 04:12:58 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove
 memory section with hwpoisoned hugepage
Thread-Topic: [PATCH v2 1/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove
 memory section with hwpoisoned hugepage
Thread-Index: AQHYwO/cKEdKHklTv0a9v9Lcn1gcJK3Rt58AgAA2SoCAACGjAIABTrUA
Date:   Wed, 7 Sep 2022 04:12:57 +0000
Message-ID: <20220907041238.GA1445815@hori.linux.bs1.fc.nec.co.jp>
References: <20220905062137.1455537-1-naoya.horiguchi@linux.dev>
 <20220905062137.1455537-2-naoya.horiguchi@linux.dev>
 <3e302aa5-d63d-097e-2cb7-831b7c99e736@huawei.com>
 <20220906061417.GA1406504@hori.linux.bs1.fc.nec.co.jp>
 <0edc3912-475e-0366-666c-9be516af1df1@huawei.com>
In-Reply-To: <0edc3912-475e-0366-666c-9be516af1df1@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4c7ab3d-c2b5-4d05-4da6-08da90873f20
x-ms-traffictypediagnostic: TYCPR01MB7726:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OSKrp6uQBMYM6j7YyjrbS1qG4eKya9Xhd1HlHGbiUMjn/SMAgmeQyRm0Ri8vhyxk0k8rmnilQzzRZdpu83MLj48JeoAm3VnigLS3nSJURXXcIZJedX1o1V4QLj5gaJ6rs1g1/YCP6E/cXDGSxU18VasaFf1zcL680WJe+bz5Vu/rjQFWy7MbVRrE9VeCrb9t+lQ2ShdAIPQBGFHyFr1AnDXsCm10AnMsv3xs/M6zJ6oS0p8jLPuRKCYsjeT+zWM8GYmqWmI8sY3/EKefrN3s6fzDbbpnUYNo7IP3jD39jiEL8vSfDvE/JTqd8MI8+9dBF4vI2/a6it4fM7WVoDEz8rC5RNGLurz35GV9dwLQsSuOYTVR76cZ8eDU1lmuj60BB6S8itCpHuI957FuTTB97xuagWeGFvNxKOqBNGeTfFdg6o41C6j52y3xSbA3FnwMtzQACpbcFdo1OMzP0W++50KyYsPXmoxIm4sgZ122uzaOXFzBYxc58TLHG+13D7LsLn7+fjMOPMN1eXOURy/37mFXhtkN0FugIjiiuel1h93ahT9ZN8N7HSG8qU/3lx1oAPyBbFXFzaxJMWPodU2Sllk+fVBXnLxU9Vw9n24DkQmA4mjNuZJHkNyD7cEeTJwYpxcf6Agx6YpPm9Z/PiiJf2lRHoz3VO/EBT+jqqtLCKgbKF4SKHkh4ZpMRVI9MyYlFCplcK2jclv+YMPifBnWViHMXxJqOnMkdJl++bP8eR0T4SlFQBYCw7ezB7Jrr2xTPd+wiZC7ELuUWeK0ob4VopW/cdV7Z6oJ0kEHztyMYjs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(478600001)(53546011)(2906002)(83380400001)(71200400001)(6506007)(6486002)(966005)(85182001)(86362001)(5660300002)(122000001)(66476007)(66556008)(66446008)(6916009)(54906003)(38070700005)(8676002)(38100700002)(64756008)(76116006)(66946007)(4326008)(41300700001)(26005)(6512007)(1076003)(9686003)(8936002)(7416002)(82960400001)(186003)(316002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFJaM2ZNNlRST0duY01OdmJieDU2dDFIOHVBS2cvQ25IWTlpUUNwam9KcFBx?=
 =?utf-8?B?MVVteSt4UXI4SVpYeXp1am5vWDNBVUtaRWdLQkQ3NDR3NmYzSUVDN3hzRGxY?=
 =?utf-8?B?OThsaUJtVURzVGlkclROVVBtdU8xUVdobDNCS1Y0RXZwNXdtZUZ5WlRIRFJZ?=
 =?utf-8?B?MWNCT1liRU00TkJEY3p2SXVjNEZOYytFY1NsME51bEt4bGpiS1NlWWxpZ0x4?=
 =?utf-8?B?VFZMTnFuY1B4ZmRIbVRxc1NKYW0yM1lIRVJIWmJrOVJ1c0ltOXhuUlc0czhn?=
 =?utf-8?B?ZVV1bklGR20rUFFBQ2tnd1BwcnludnZMR3dnUTRYTDI5ZVdkK25PelNOOFNS?=
 =?utf-8?B?Q3JhUlBweHVBRjJNaXk3MkQzdWEvdUVlZVhoanN6ZFUwTEx4SHo3YnN6K2xO?=
 =?utf-8?B?OXNLUStTZWptaXNON3loV1JkbVBiWWlNUmlQcC9uUnFzNFJweVdXMi81SGE0?=
 =?utf-8?B?alNQOEdZR1M3R09MdTlpSEJ1V2RnNzV0T2liL0d1UWtEem1JcTVtOHF5eGJr?=
 =?utf-8?B?amxHOVRyVTMwM1Zpb3ZxWGxMK0c0SjQ0RzVMRDhuTG5aSzdyOEFQd2xnc08x?=
 =?utf-8?B?ck1CRWM0Y3hTdDZ0akdENUcrVlhrcVd1QUdob1JZK0V3UTB4b05rVWdlOEQ3?=
 =?utf-8?B?dDBpbDFkOVBpcDd2eG1XS3o0TDlLdERlbWFHTGZVbWpKWVpiVTJTanFuTzND?=
 =?utf-8?B?TWpFeHFuRWF6aktYZ2I1ZTUzTU9uZ0phSHJxcnZFSm1FQk1xd0dQd2tBcWhW?=
 =?utf-8?B?QVRJdXAwclZHQ1VSOEhub1V5YXBaZkphckYreURCWmwwSFVmMnNkOWEvRWc3?=
 =?utf-8?B?RHZqOFBOR2x5Wk4yVXo1cCtQWWJTYmd1bnpwQ1A3SlYzSUFOOG04QVVHcnZX?=
 =?utf-8?B?b2dKbDdkOXpWZ3pjaFR2N3VQZmxoYlYyZHN4N2NUTDhPMmgyUlZCcUVBOFdu?=
 =?utf-8?B?dFNwOXhqZGQwYW0zejUwd0VDMFdqV1ZZQkRGcUt6UVZwbDlZSmVlTUJSZWto?=
 =?utf-8?B?b0JHMENDZHl5dkQrL2NZL01jd0pXNVNtUE1LNjIwWWlxVE4zSjlPNFlDcDQ4?=
 =?utf-8?B?Q0dXRW1WMGVqenp5WjVXNnMzZVZWaXE4eE1qbFdhU1JPbkZ6aVlkL05ZL2Nz?=
 =?utf-8?B?TVRyU0JmRWwxMEZuT1J1WFhrVytuclFyODVSMXp0U2I1MWRIdDZPWGs3NWZs?=
 =?utf-8?B?RzdvanB1dzgyRyt3NU1LZXU5UTdTd3d3aGdDd3o0cnZVMm5EN0Q3OFhsM1hP?=
 =?utf-8?B?OWxHcXo1QzhEVlBDbDZxSi9pNlgyRXZzdCtwK3lMejIyL2xuazQwMkFuYThs?=
 =?utf-8?B?VllJbEUvK0xMZTd6Z1dMUFluTjVtTkgyM2k3dUxyM1ZZN2xwNXdlTiswVzVk?=
 =?utf-8?B?cmRDY3dEaDU2OUY5cEdiY1lOblkxaklFcmVMcFBET1VuL01iRzFVbjIwV0dL?=
 =?utf-8?B?ekhoSi9NWmNMUTVmYStCOGF2RVJhTlpNYnR6TFJQenUxb3QxQWozZnVkeThC?=
 =?utf-8?B?MEl5WDNiV3c5cGtPbnA3SUNrWU1FVUhXTjUwbmcxazNwL29JbVVmNnpPa0xi?=
 =?utf-8?B?RFNsOWpFeWU2cy9XM1gvNkg2d2VWSE1YTkZaUDU5cXdXYWFxbVRnUUZXcC81?=
 =?utf-8?B?TFFGZVJDZys2THZCU0hQOU5wY21yL3dzdlcwaVVPT2dDdzRldlFTMzdpREcv?=
 =?utf-8?B?MmxBTC9GZkxSemp4L3pZaURVaWs4NFZoL296cERTcXN5dDN5aC9HTFdkcDdG?=
 =?utf-8?B?QXhwZ0tMWjFheTZPK3U3a2FiVEVDTnlhWUg3Mm9qajdJM2JtbXlhdUFJR3Ja?=
 =?utf-8?B?RDBVMGhxTnFPT1NwYzliYWxBeWYzNGExVEVkVkI2c28vaDJ2bnQwTCt2Sndt?=
 =?utf-8?B?ZUl2bjNTOEZybDdEUjFuOFdqOVpBVDBKQk5LQkMyY0t6aFdpTE51UFhWTnFv?=
 =?utf-8?B?Sk5nZnVoYlkrOElQVkZCdm1rWDNLN0tFOENXaFlRKzkxd1pTOGovQys1ZnFu?=
 =?utf-8?B?cWttbVdFalZqYjJ2TlZ4RUVJc1lGMWhEVHJobVc5eEptcWxxOUdMK1dGSS96?=
 =?utf-8?B?T3J1OFhBNU85UWhobFpyaTNSeUdmYm5SQzUwQ3UxN3RxVkdJYSsxRkZMd2Y0?=
 =?utf-8?B?bTBVMFh2cW9iOVhFV0RFeFZtMzl3MUVWaUErc0puTXNtL1YyT0FzTkVjbnh2?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <778FCBBF6DF31F438E71B25456720FC7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c7ab3d-c2b5-4d05-4da6-08da90873f20
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 04:12:58.0100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7fQoFUjlfrJh185ZeDPAfDnoxNVjiGdJwOuaC1zYnnclZtZ2jpyJbUul1F3m/atz2lAPN5Tm57Z54KFTRuWIGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7726
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgMDYsIDIwMjIgYXQgMDQ6MTQ6NDBQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi85LzYgMTQ6MTQsIEhPUklHVUNISSBOQU9ZQSjloIDlj6Mg55u05LmfKSB3
cm90ZToNCj4gPiBPbiBUdWUsIFNlcCAwNiwgMjAyMiBhdCAxMDo1OTo1OEFNICswODAwLCBNaWFv
aGUgTGluIHdyb3RlOg0KPiA+PiBPbiAyMDIyLzkvNSAxNDoyMSwgTmFveWEgSG9yaWd1Y2hpIHdy
b3RlOg0KPiA+Pj4gRnJvbTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNv
bT4NCj4gPj4+DQo+ID4+PiBIV1BvaXNvbmVkIHBhZ2UgaXMgbm90IHN1cHBvc2VkIHRvIGJlIGFj
Y2Vzc2VkIG9uY2UgbWFya2VkLCBidXQgY3VycmVudGx5DQo+ID4+PiBzdWNoIGFjY2Vzc2VzIGNh
biBoYXBwZW4gZHVyaW5nIG1lbW9yeSBob3RyZW1vdmUgYmVjYXVzZSBkb19taWdyYXRlX3Jhbmdl
KCkNCj4gPj4+IGNhbiBiZSBjYWxsZWQgYmVmb3JlIGRpc3NvbHZlX2ZyZWVfaHVnZV9wYWdlcygp
IGlzIGNhbGxlZC4NCj4gPj4+DQo+ID4+PiBNb3ZlIGRpc3NvbHZlX2ZyZWVfaHVnZV9wYWdlcygp
IGJlZm9yZSBzY2FuX21vdmFibGVfcGFnZXMoKS4gUmVjZW50bHkNCj4gPj4+IGRlbGF5ZWQgZGlz
c29sdmUgaGFzIGJlZW4gaW1wbGVtZW50ZWQsIHNvIHRoZSBkaXNzb2x2aW5nIGNhbiB0dXJuDQo+
ID4+PiBhIGh3cG9pc29uZWQgaHVnZXBhZ2UgaW50byA0a0IgaHdwb2lzb24gcGFnZSwgd2hpY2gg
bWVtb3J5IGhvdHBsdWcgY2FuDQo+ID4+PiBoYW5kbGUgc2FmZWx5Lg0KPiA+Pg0KPiA+PiBZZXMs
IHRoYW5rcyBmb3IgeW91ciB3b3JrLCBOYW95YS4gOykNCj4gPj4NCj4gPj4+DQo+ID4+PiBSZXBv
cnRlZC1ieTogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+DQo+ID4+PiBTaWduZWQt
b2ZmLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+Pj4g
LS0tDQo+ID4+PiAgbW0vbWVtb3J5X2hvdHBsdWcuYyB8IDIyICsrKysrKysrKysrLS0tLS0tLS0t
LS0NCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25z
KC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL21tL21lbW9yeV9ob3RwbHVnLmMgYi9tbS9t
ZW1vcnlfaG90cGx1Zy5jDQo+ID4+PiBpbmRleCBmYWQ2ZDFmMjI2MmEuLmMyNDczNWQ2M2IyNSAx
MDA2NDQNCj4gPj4+IC0tLSBhL21tL21lbW9yeV9ob3RwbHVnLmMNCj4gPj4+ICsrKyBiL21tL21l
bW9yeV9ob3RwbHVnLmMNCj4gPj4+IEBAIC0xODgwLDYgKzE4ODAsMTcgQEAgaW50IF9fcmVmIG9m
ZmxpbmVfcGFnZXModW5zaWduZWQgbG9uZyBzdGFydF9wZm4sIHVuc2lnbmVkIGxvbmcgbnJfcGFn
ZXMsDQo+ID4+PiAgDQo+ID4+PiAgCQkJY29uZF9yZXNjaGVkKCk7DQo+ID4+PiAgDQo+ID4+PiAr
CQkJLyoNCj4gPj4+ICsJCQkgKiBEaXNzb2x2ZSBmcmVlIGh1Z2VwYWdlcyBpbiB0aGUgbWVtb3J5
IGJsb2NrIGJlZm9yZSBkb2luZw0KPiA+Pj4gKwkJCSAqIG9mZmxpbmluZyBhY3R1YWxseSBpbiBv
cmRlciB0byBtYWtlIGh1Z2V0bGJmcydzIG9iamVjdA0KPiA+Pj4gKwkJCSAqIGNvdW50aW5nIGNv
bnNpc3RlbnQuDQo+ID4+PiArCQkJICovDQo+ID4+PiArCQkJcmV0ID0gZGlzc29sdmVfZnJlZV9o
dWdlX3BhZ2VzKHN0YXJ0X3BmbiwgZW5kX3Bmbik7DQo+ID4+PiArCQkJaWYgKHJldCkgew0KPiA+
Pj4gKwkJCQlyZWFzb24gPSAiZmFpbHVyZSB0byBkaXNzb2x2ZSBodWdlIHBhZ2VzIjsNCj4gPj4+
ICsJCQkJZ290byBmYWlsZWRfcmVtb3ZhbF9pc29sYXRlZDsNCj4gPj4+ICsJCQl9DQo+ID4+DQo+
ID4+IFRoaXMgY2hhbmdlIGhhcyBhIHNpZGUtZWZmZWN0LiBJZiBodWdldGxiIHBhZ2VzIGFyZSBp
bi11c2UsIGRpc3NvbHZlX2ZyZWVfaHVnZV9wYWdlcygpIHdpbGwgYWx3YXlzIHJldHVybiAtRUJV
U1kNCj4gPj4gZXZlbiBpZiB0aG9zZSBwYWdlcyBjYW4gYmUgbWlncmF0ZWQuIFNvIHdlIGZhaWwg
dG8gaG90cmVtb3ZlIHRoZSBtZW1vcnkgZXZlbiBpZiB0aGV5IGNvdWxkIGJlIG9mZmxpbmVkLg0K
PiA+PiBPciBhbSBJIG1pc3Mgc29tZXRoaW5nPw0KPiA+IA0KPiA+IFRoYW5rIHlvdSBmb3IgdGhl
IGNvbW1lbnQsIHlvdSdyZSByaWdodC4gIChUYWtpbmcgYSBsb29rIG92ZXIgbXkgdGVzdCByZXN1
bHQNCj4gPiBjYXJlZnVsbHksIGl0IHNob3dlZCBmYWlsdXJlcyBmb3IgdGhlIHJlbGF0ZWQgY2Fz
ZXMsIEkgc29tZWhvdyBvdmVybG9va2VkDQo+ID4gdGhlbSwgcmVhbGx5IHNvcnJ5LikgIFNvIG15
IHNlY29uZCB0aG91Z2h0IGlzIHRoYXQgd2Uga2VlcCBvZmZsaW5lX3BhZ2VzKCkNCj4gPiBhcyBp
cywgYW5kIGluc2VydCBhIGZldyBsaW5lIGluIGRvX21pZ3JhdGVfcmFuZ2UoKSB0byBoYW5kbGUg
dGhlIGNhc2Ugb2YNCj4gPiBod3BvaXNvbmVkIGh1Z2VwYWdlIGxpa2UgYmVsb3c6DQo+ID4gDQo+
ID4gQEAgLTE2NDIsNiArMTY0Miw4IEBAIGRvX21pZ3JhdGVfcmFuZ2UodW5zaWduZWQgbG9uZyBz
dGFydF9wZm4sIHVuc2lnbmVkIGxvbmcgZW5kX3BmbikNCj4gPiANCj4gPiAgICAgICAgICAgICAg
ICAgaWYgKFBhZ2VIdWdlKHBhZ2UpKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcGZu
ID0gcGFnZV90b19wZm4oaGVhZCkgKyBjb21wb3VuZF9ucihoZWFkKSAtIDE7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKFBhZ2VIV1BvaXNvbihoZWFkKSkNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHVw
ZGF0ZS4gQnV0IGl0IHNlZW1zIHRoaXMgaXMgbm90IGVub3VnaC4gV2l0aCB0aGUgYWJvdmUgY29k
ZSBjaGFuZ2UsIEhXUG9pc29uZWQNCj4gaHVnZXRsYiBwYWdlcyB3aWxsIGFsd2F5cyBiZSBpZ25v
cmVkIGluIGRvX21pZ3JhdGVfcmFuZ2UoKS4gQW5kIGlmIHRoZXNlIHBhZ2VzIGFyZSBIUGFnZU1p
Z3JhdGFibGUsDQo+IHRoZXkgd2lsbCBiZSByZXR1cm5lZCBpbiBzY2FuX21vdmFibGVfcGFnZXMo
KSB0aGVuIHBhc3NlZCBpbnRvIHRoZSBkb19taWdyYXRlX3JhbmdlKCkgYWdhaW4uIFRodXMNCj4g
YSBwb3NzaWJsZSBkZWFkbG9vcCB3aWxsIG9jY3VyIHVudGlsIHRoZXNlIHBhZ2VzIGJlY29tZSB1
bi1tb3ZhYmxlPw0KDQpZZWFoLCBzbyBzY2FuX21vdmFibGVfcGFnZXMoKSBjYW4gaGF2ZSBhbiBh
ZGRpdGlvbmFsIGNoZWNrIGZvciBod3BvaXNvbmVkIGh1Z2VwYWdlcywgb3INCm1ha2luZyBod3Bv
aXNvbmVkIGh1Z2VwYWdlIHRvIGJlICFIUGFnZU1pZ3JhdGFibGUgKHNvbWVob3cpIG1pZ2h0IGJl
IGFub3RoZXIgb3B0aW9uLg0KSSBsaWtlIHRoZSBsYXR0ZXIgb25lIGZvciBub3csIGJ1dCBJIG5l
ZWQgbG9vayBpbnRvIGhvdyBJIGNhbiB1cGRhdGUgdGhlIHBhdGNoIG1vcmUuDQoNCj4gDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgaXNvbGF0ZV9odWdldGxiKGhlYWQsICZzb3VyY2UpOw0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+ICAgICAgICAgICAgICAg
ICB9IGVsc2UgaWYgKFBhZ2VUcmFuc0h1Z2UocGFnZSkpDQo+ID4gDQo+ID4gVGhpcyBpcyBzbGln
aHRseSBkaWZmZXJlbnQgZnJvbSB5b3VyIG9yaWdpbmFsIHN1Z2dlc3Rpb24NCj4gPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1tbS8yMDIyMDQyMTEzNTEyOS4xOTc2Ny0xLWxpbm1pYW9o
ZUBodWF3ZWkuY29tL1QNCj4gPiAsIGFzIGRpc2N1c3NlZCBpbiB0aGUgdGhyZWFkIGV4aXN0aW5n
ICJpZiAoUGFnZUhXUG9pc29uKHBhZ2UpKSIgYnJhbmNoIGluDQo+ID4gdGhpcyBmdW5jdGlvbiBj
YW4ndCBiZSB1c2VkIGZvciBodWdldGxiLiAgV2UgY291bGQgYWRqdXN0IHRoZW0gdG8gaGFuZGxl
DQo+ID4gaHVnZXRsYiwgYnV0IG1heWJlIHNlcGFyYXRpbmcgY29kZSBmb3IgaHVnZXRsYiBmaXJz
dCBmcm9tIHRoZSBvdGhlcnMgbG9va3MNCj4gPiBsZXNzIGNvbXBpY2F0ZWQgdG8gbWUuDQo+IA0K
PiBJdCBtaWdodCBiZSBiZXR0ZXIgdG8gZG8gc29tZXRoaW5nLCBlLmcuIHVubWFwIHRoZSBodWdl
dGxiIHBhZ2VzIHRvIHByZXZlbnQgYWNjZXNzaW5nIGZyb20gcHJvY2VzcyBpZiBtYXBwZWQsDQo+
IGV2ZW4gdHJ5IHRydW5jYXRpbmcgdGhlIGVycm9yIHBhZ2UgZnJvbSBwYWdlY2FjaGUuIEJ1dCBJ
IGhhdmUgbm8gc3Ryb25nIG9waW5pb24gYXMgaGFuZGxpbmcgbWVtb3J5IGZhaWx1cmUNCj4gd291
bGQgYWx3YXlzIGJlIGEgYmVzdCB0cnkuIDspDQoNClRoaXMgY291bGQgYmUgaGVscGZ1bCwgSSds
bCB0cnkgc29tZS4NClRoYW5rIHlvdSBmb3IgdmFsdWFibGUgY29tbWVudHMuDQoNCi0gTmFveWEg
SG9yaWd1Y2hpDQoNCj4gDQo+IFRoYW5rcywNCj4gTWlhb2hlIExpbg0KPiANCj4gDQo+ID4gDQo+
ID4gSWYgeW91IGhhdmUgYW55IHN1Z2dlc3Rpb24gb24gdGhpcywgcGxlYXNlIGxldCBtZSBrbm93
Lg0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBOYW95YSBIb3JpZ3VjaGkNCj4gPiA=
