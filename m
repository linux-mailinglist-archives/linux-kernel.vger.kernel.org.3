Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2CE524445
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347224AbiELEdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346463AbiELEc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:32:58 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2049.outbound.protection.outlook.com [40.107.113.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC522173DC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEx2YghB7A3iRHRjvV4lKoaWCeBbQqrfZESIBPP/p5DpaBXakF6mMrh/R89NM1lRKWfZemVbeUTxasgRDlbJScJ3tgb+HoDE3L6PMuPN3RnFR22cjY2WI3wgLQahxRyjOVg3mSN3pwsJceuSCWURLvBD9vneVVlIQOPIDe7Jn60hDT+acPfS47X0QGlmdPfGmJQBosFJnhvIfZhQag6L/hPdN46Pikw8IjYkEXTZlMc7Iu/tWs9GCSVmmR4o+9I+A2awcwxuC8kELnTxOhe/sl+SOiwADeL1rHTKnSS4HoXwmiNgs3j2d+ypyIwti4hk8ZT4feEUQHkQKyIMNJhUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptbAZQlAsU3zUW2MrBBZS7CLh/Xv7NxbbjJAwIsqGKs=;
 b=eBSlOAI1d0VtpIfouxCyISShOt9cW474K2qNKU9OxZnhVWmPEjNWVb1bLYQqcIOD7Tz20H8aapYZlb8R1IFsmVD5smmFhSqrY3uqNQeRBOsWdxhjqNJ7ZAXoCt1iPLYoFAAkmOay92My0qCL0ncugH3oErZTZAPCuT/asn5Aaa/3HDpZtOJ7OiJ5HP86KilhIXJMvFnPbOSwJPogS90FFKW20wVI6mGb5SIbVX9fIurU1ZCG5hDKZknw83wx0FllpmNBM1CYcb1o0QisU5aErAv1SchZGMmgt7u+An9W6lyzpA9iDvghlN2e28Dbrn6LE8NPQ3ghneAL5hUqLGEFVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptbAZQlAsU3zUW2MrBBZS7CLh/Xv7NxbbjJAwIsqGKs=;
 b=DmeRLeScoDXNSCy5w0m7y6aZzuPLdpLVN0ykj3fDtdKM1aIpfH8TPPRfCDGmsHY4gxaNJ892Bgo1rnpbcmA6qOGOfOpRzDMPF6eXrzsk1klY/6dUaiBWYJvUawW1DbwuMQ60WO9M7OjaUBiheEPB5agcBCaOsE4fNQmtZjDmegM=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYWPR01MB9292.jpnprd01.prod.outlook.com (2603:1096:400:1a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 04:32:54 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8%7]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 04:32:54 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        zhenwei pi <pizhenwei@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mm,hwpoison: set PG_hwpoison for busy hugetlb pages
Thread-Topic: [PATCH v1] mm,hwpoison: set PG_hwpoison for busy hugetlb pages
Thread-Index: AQHYZUq6jUL1RAg6UkGx4+LoCthdFK0aAVCAgACmyoA=
Date:   Thu, 12 May 2022 04:32:54 +0000
Message-ID: <20220512043253.GA242760@hori.linux.bs1.fc.nec.co.jp>
References: <20220511151955.3951352-1-naoya.horiguchi@linux.dev>
 <f0da4fcf-a4af-ccaa-32ce-55d9fda72203@oracle.com>
In-Reply-To: <f0da4fcf-a4af-ccaa-32ce-55d9fda72203@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87f8a21c-988c-48d9-3e18-08da33d07b82
x-ms-traffictypediagnostic: TYWPR01MB9292:EE_
x-microsoft-antispam-prvs: <TYWPR01MB9292BC9C3930F21894C2579AE7CB9@TYWPR01MB9292.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ZBzILQHpbAp4JWkBl9UDmzkDcIe6EOUQr8QO1Z1Uvyge5JsDEQ1uEVvYbsXEtr2Aut2/lwv3Z6JsvYsORU8SOZ+elZ3zmykqpaa9cNrPnW7lcWUoeII0XMu7xdO+tH7Ca78H2lu1+DBFm+en84HO8ONk+8+oE2vq8JG6hcvCJoz0l6LnKbPwEdOmOzEos+SFE/7TZlNc8CGKVrFkq1z0p6RP4NOZhrvtOL+SuU4pSjaOhUSZMWHesgwRYs1C18pcPWhE5NO6hFqIbK1YCIMNJ4mNFFTGL5E6+sVnPTZCxBajl5gsYUwkmSiHvVY2wl8rZldN5X/bekbm8X4TI/1EWFU/i0O6lpORluNa6CZ534R8tl8hD19xE864knuj0DrjnrsUtWj2eLzZkuGGKYl76WOW6TeGuBJQ/g8WE3PzsHANmpw2BNxHjB6ed3vKqH2TpvyrhaFFOc1AoTaw45t7hJIsJXxvZBWVzZUJo/WnPZxdBC+nTglZIBTJ1dVtMv8TyZBSsOfMbDjJfTw2eYAljq2B8zBSBru6kf4B3gs8yRWQy0VWzbtHC/5oLBWr0MOpEn8RN1mgkro75yvITqqbkP2V7kKb5kzEgpaJoMkNwJkDO9F0smVpyqyIGL+1I8i7i4+cc/hQJmklVnvO7vpevf4z/R2dFuxwa/WCpr9FpfgUTIk4emNue5YIDRemRj53gODpNaCO/hHiTQH42ahsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(86362001)(8936002)(5660300002)(9686003)(6506007)(26005)(4326008)(71200400001)(6486002)(6916009)(55236004)(38100700002)(54906003)(38070700005)(66446008)(66946007)(82960400001)(66476007)(76116006)(64756008)(8676002)(66556008)(508600001)(122000001)(53546011)(83380400001)(316002)(85182001)(2906002)(1076003)(186003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWRqSFFQTWhEUEJCcEgwc3dhNTBYbHVxTTY4dENyU0lOVVJBYTIwS3BJYXdu?=
 =?utf-8?B?eTU4cklueHgxSTlvRHMvaFBpNjE1ZDRubkhCMnRXRkxMellLKzAyc2lxU01w?=
 =?utf-8?B?aUIvMVFuSHE4anlqTGxUL25zekF1eDBjaHRNd0FJNjkzMXJKZFBFdUx5VndN?=
 =?utf-8?B?bE9LaEF2WDRxVlFsY0dud1lET3N4andZUHJqMFhlZDdVT2RQd3FuM0VTRXRT?=
 =?utf-8?B?YWV5L2hZK1o4YlFCNG4rQ1h6bUtNa1gwb3NvMWdZV1BNWk04dWRyVG8yTXdl?=
 =?utf-8?B?V0lPaDhvVXM4VGdxWXcyODlnT1NIUmhCOE41QTJQZkZrV0xiZEMyUWV2Rm5C?=
 =?utf-8?B?Q1NFckF6bE5vZE16cW4yZnVzd3l4aGg2ODNIQ0lzQk1SVDVrdWQ0N3V1RG11?=
 =?utf-8?B?akt2ZURMYklwLzRKMVFYZzRLYi9md0xqUXluWnpOTTlPeFlrbkZoZ3F0aTZI?=
 =?utf-8?B?dnFJOTQyc09HWWVpQVh2bWhmL0wzYUkrM0RVeVhaMndRajNCZjJhNU9jb2ZO?=
 =?utf-8?B?Qk9LTk1mcmJXOHZFR1NvdHV1alJUUXRiREZ3eGMwSU9WMUxCWlpMbVlQK3RG?=
 =?utf-8?B?OXIrdnN6b3J4eUtsTXV0ZjZhSWc3aUFybk0rQzdFS2Z5Zm5SeFFlMVY5SGJN?=
 =?utf-8?B?OUs4d3Vub2hRTHU0TmRtYVloRTBpVFBOU2xnRHp1dHZPakVnMmZFa29NSm9U?=
 =?utf-8?B?eEUvc0RyTWFueE53TG1xalQ1TUYwWmpKRWhsZVNNd08vTHhCQ25Kd1FwWlBz?=
 =?utf-8?B?UUJrRHdrVHpFVktSQXpXNmFOL1FYbXZSa2lLVlRXcXdHY3ZmQUxJd3VaUVpJ?=
 =?utf-8?B?LzdLTnJQZDUzNkRvR3grVFhlNGFnS3VrMVcyK0c1V0VvWWp6MWxpaFBOR2lP?=
 =?utf-8?B?VWZsNCtCMnZzcm4wUm0zSlFnVS9NWVl6SWF5ZVdCRnNWbFdhOHBUb1BISERO?=
 =?utf-8?B?c3JvYVord3pzZXY3TUh5NEFISlpsQlloRVoybUhMWHZVZkd4TkdEZ0FPOE1E?=
 =?utf-8?B?MzlFdkZXa1MybjZOU2FJSnhoR0FyVTNlUjZzTVpiVVVOMmFKYWVXWEpDWmRG?=
 =?utf-8?B?a1BVN1JVY1hCaVFKQzM0WXZHYSt2M0VsM1pYUmoxbEFwR1hQc0JRNURxU1FK?=
 =?utf-8?B?RWdqYnZGUVIyU0tDQTZ3SGxJUk4rblVVaDh5SWd2WE53YXAvZWtlK0NzRDNs?=
 =?utf-8?B?QjYrdFphL0J6WXY4SmFPbEtuakt0NHM1bDV0dCtnSGtqWjZtamMxcVRDYkd2?=
 =?utf-8?B?aGJtNnFReGdlNXlmbmF4akplMmN4dGFzU3ZiRDU3YXpRREo4M1ZwcnVVUVBH?=
 =?utf-8?B?bUIybGo4eUZOd29yVWt5OFE4NzEvZzE1WGF5eXdUN3VNZzlJWmxBQW94SS9M?=
 =?utf-8?B?RU0xUmdqVHY0MHhFVFJtV0UveDNrL0hIVElUS0kycFlMSDMyUWJZMUtDcVJm?=
 =?utf-8?B?aVI3MEhFbDg0bHVNQ053aEYrSk1BRXVjVUUxNG11RVhJei85aWpDMHZzQTFW?=
 =?utf-8?B?bWpyL2tYK0x5bi9ibGk1UWZta3BCNTNDVm1qanByM3NscWFkQjBaTHpFbUtR?=
 =?utf-8?B?VVdpQWdoUFJ6ZWNhMXJUbk0zVkFiVExIZFYrTTJlYWkrNkdZbHJscW5ucWJk?=
 =?utf-8?B?UFRUZ2ozR01XVVpxUGxKalQ4ZlFKN08xWk9XZDRYdEl1ZXlZaGZBb1UwVDZC?=
 =?utf-8?B?d0YvR3hTRzRQUEx0SUZuRVJDRklDU2g2RGRVbm5XbmI0cWdveEN5enc4Y2Ex?=
 =?utf-8?B?dEVxa0NFQWEyNFE3YVA1TUVMMEF1MWdzWElQZEpCUjBSd1BYQVNra1VQc3l4?=
 =?utf-8?B?KzJTUXVxZmZadGxqNExEVVVXdXZRYmh4c0JJdlo0dTFBY2hMRllVOTlxTWw4?=
 =?utf-8?B?TTE1d0lKK25qejNKOGdObktKcnNwMklGTFAxVEhVaWlvd1FlKzh5a0dlT2c1?=
 =?utf-8?B?N1NpWEZQNVNkM1JndFg0elJ4UVRnOXRDVGNVOUtDdzNuV3FmT0phVWRrUjJT?=
 =?utf-8?B?K0pJL0cyWTQxQnYyYitoQ3A3Q1psUERhNFZHN283R2dxcHlnRUp1Q2MvQkcv?=
 =?utf-8?B?a1NZMm1waW5uRGd6eXN2d2x6TFRJenhSOW9tc2c2ZU5Ga21xMGhqdmh4VkJT?=
 =?utf-8?B?amxMb1o5MllUeTFhNHYrVGRWOVlmOFlvV2dOcVV6K0hNUXQxaDY3SUE4TjIv?=
 =?utf-8?B?R3VydFAwaWIyRnRVU1ZrYjFXY3ZlR21yaUNaME84dmFqZlJxSHZ1RWk0dnpG?=
 =?utf-8?B?OU5WLy9zVXVyUElGRWNRM0hOM016L1BmVDllb2oxWW84QVNUZFMvdXFGWklF?=
 =?utf-8?B?NjM2bUQ5R3JpTTN0bThlRTJTb2d4TERkSHNLVGJKeXlMbXVyOUx4dGxTaVZk?=
 =?utf-8?Q?Tqt7vaH7Mxv01Krk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9CF53CFFF06324487EA0398F2967CDD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f8a21c-988c-48d9-3e18-08da33d07b82
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 04:32:54.4225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C21XyfUMKzg2x+Wa67CpJBKMH17+9ZKlETKhWJ6MAto+74tyNLy52mhPDo7NA6/xn89c7RHmEwMR2AYdp+Xtzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9292
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMTEsIDIwMjIgYXQgMTE6MzU6NTVBTSAtMDcwMCwgTWlrZSBLcmF2ZXR6IHdy
b3RlOg0KPiBPbiA1LzExLzIyIDA4OjE5LCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gRnJv
bTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiANCj4gPiBJ
ZiBtZW1vcnlfZmFpbHVyZSgpIGZhaWxzIHRvIGdyYWIgcGFnZSByZWZjb3VudCBvbiBhIGh1Z2V0
bGIgcGFnZQ0KPiA+IGJlY2F1c2UgaXQncyBidXN5LCBpdCByZXR1cm5zIHdpdGhvdXQgc2V0dGlu
ZyBQR19od3BvaXNvbiBvbiBpdC4NCj4gPiBUaGlzIG5vdCBvbmx5IGxvc2VzIGEgY2hhbmNlIG9m
IGVycm9yIGNvbnRhaW5tZW50LCBidXQgYnJlYWtzIHRoZSBydWxlDQo+ID4gdGhhdCBhY3Rpb25f
cmVzdWx0KCkgc2hvdWxkIGJlIGNhbGxlZCBvbmx5IHdoZW4gbWVtb3J5X2ZhaWx1cmUoKSBkbw0K
PiA+IGFueSBvZiBoYW5kbGluZyB3b3JrIChldmVuIGlmIHRoYXQncyBqdXN0IHNldHRpbmcgUEdf
aHdwb2lzb24pLg0KPiA+IFRoaXMgaW5jb25zaXN0ZW5jeSBjb3VsZCBoYXJtIGNvZGUgbWFpbnRh
aW5hYmlsaXR5Lg0KPiA+IA0KPiA+IFNvIHNldCBQR19od3BvaXNvbiBhbmQgY2FsbCBodWdldGxi
X3NldF9wYWdlX2h3cG9pc29uKCkgZm9yIHN1Y2ggYSBjYXNlLg0KPiA+IA0KPiA+IEZpeGVzOiA0
MDVjZTA1MTIzNmMgKCJtbS9od3BvaXNvbjogZml4IHJhY2UgYmV0d2VlbiBodWdldGxiIGZyZWUv
ZGVtb3Rpb24gYW5kIG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGIoKSIpDQo+ID4gU2lnbmVkLW9mZi1i
eTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiAtLS0NCj4g
PiAgaW5jbHVkZS9saW51eC9tbS5oICB8IDEgKw0KPiA+ICBtbS9tZW1vcnktZmFpbHVyZS5jIHwg
OCArKysrLS0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbS5oIGIvaW5j
bHVkZS9saW51eC9tbS5oDQo+ID4gaW5kZXggZDQ0NmU4MzRhM2U1Li4wNGRlMGMzZTRmOWYgMTAw
NjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tbS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51
eC9tbS5oDQo+ID4gQEAgLTMxODcsNiArMzE4Nyw3IEBAIGVudW0gbWZfZmxhZ3Mgew0KPiA+ICAJ
TUZfTVVTVF9LSUxMID0gMSA8PCAyLA0KPiA+ICAJTUZfU09GVF9PRkZMSU5FID0gMSA8PCAzLA0K
PiA+ICAJTUZfVU5QT0lTT04gPSAxIDw8IDQsDQo+ID4gKwlNRl9OT19SRVRSWSA9IDEgPDwgNSwN
Cj4gPiAgfTsNCj4gPiAgZXh0ZXJuIGludCBtZW1vcnlfZmFpbHVyZSh1bnNpZ25lZCBsb25nIHBm
biwgaW50IGZsYWdzKTsNCj4gPiAgZXh0ZXJuIHZvaWQgbWVtb3J5X2ZhaWx1cmVfcXVldWUodW5z
aWduZWQgbG9uZyBwZm4sIGludCBmbGFncyk7DQo+ID4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS1m
YWlsdXJlLmMgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ID4gaW5kZXggNmEyOGQwMjBhNGRhLi5l
MzI2OWI5OTEwMTYgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+ICsr
KyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gPiBAQCAtMTUyNiw3ICsxNTI2LDggQEAgaW50IF9f
Z2V0X2h1Z2VfcGFnZV9mb3JfaHdwb2lzb24odW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncykN
Cj4gPiAgCQkJY291bnRfaW5jcmVhc2VkID0gdHJ1ZTsNCj4gPiAgCX0gZWxzZSB7DQo+ID4gIAkJ
cmV0ID0gLUVCVVNZOw0KPiA+IC0JCWdvdG8gb3V0Ow0KPiA+ICsJCWlmICghKGZsYWdzICYgTUZf
Tk9fUkVUUlkpKQ0KPiA+ICsJCQlnb3RvIG91dDsNCj4gPiAgCX0NCj4gDQo+IEhpIE5hb3lhLA0K
PiANCj4gV2UgYXJlIGluIHRoZSBlbHNlIGJsb2NrIGJlY2F1c2UgIUhQYWdlRnJlZWQoKSBhbmQg
IUhQYWdlTWlncmF0YWJsZSgpLg0KPiBJSVVDLCB0aGlzIGxpa2VseSBtZWFucyB0aGUgcGFnZSBp
cyBpc29sYXRlZC4gIE9uZSBjb21tb24gcmVhc29uIGZvciBpc29sYXRpb24NCj4gaXMgbWlncmF0
aW9uLiAgU28sIHRoZSBwYWdlIGNvdWxkIGJlIGlzb2xhdGVkIGFuZCBvbiBhIGxpc3QgZm9yIG1p
Z3JhdGlvbi4NCg0KWWVzLCBhbmQgSSBhbHNvIGRldGVjdGVkIHRoaXMgaXNzdWUgYnkgdGVzdGlu
ZyByYWNlIGJldHdlZW4gaHVnZXBhZ2UgYWxsb2NhdGlvbg0KYW5kIG1lbW9yeV9mYWlsdXJlKCku
IA0KDQo+IA0KPiBJIHRvb2sgYSBxdWljayBsb29rIGF0IHRoZSBodWdldGxiIG1pZ3JhdGlvbiBj
b2RlIGFuZCBkaWQgbm90IHNlZSBhbnkgY2hlY2tzDQo+IGZvciBQYWdlSFdQb2lzb24gYWZ0ZXIg
YSBodWdldGxiIHBhZ2UgaXMgaXNvbGF0ZWQuICBJIGNvdWxkIGhhdmUgbWlzc2VkDQo+IHNvbWV0
aGluZz8gIElmIHRoZXJlIGFyZSBubyBjaGVja3MsIHdlIHdpbGwgcmVhZCB0aGUgUGFnZUhXUG9p
c29uIHBhZ2UNCj4gaW4ga2VybmVsIG1vZGUgd2hpbGUgY29weWluZyB0byB0aGUgbWlncmF0aW9u
IHRhcmdldC4NCg0KWWVzLCB0aGF0IGNvdWxkIGhhcHBlbi4gIFRoaXMgcGF0Y2ggZG9lcyBub3Qg
YWZmZWN0IG9uZ29pbmcgaHVnZXBhZ2UgbWlncmF0aW9uLg0KQnV0IGFmdGVyIHRoZSBtaWdyYXRp
b24gc291cmNlIGh1Z2VwYWdlIGlzIGZyZWVkLCB0aGUgUEdfaHdwb2lzb24gc2hvdWxkIHdvcmsN
CnRvIHByZXZlbnQgcmV1c2luZy4NCg0KPiANCj4gSXMgdGhpcyBhbiBpc3N1ZT8gIElzIGlzIHNv
bWV0aGluZyB3ZSBuZWVkIHRvIGJlIGNvbmNlcm5lZCB3aXRoPyAgTWVtb3J5DQo+IGVycm9ycyBj
YW4gaGFwcGVuIGF0IGFueSB0aW1lLCBhbmQgZ3JhY2VmdWxseSBoYW5kbGluZyB0aGVtIGlzIGJl
c3QgZWZmb3J0Lg0KDQpSaWdodCwgc28gZG9pbmcgbm90aGluZyBmb3IgdGhpcyBjYXNlIGNvdWxk
IGJlIE9LIGlmIGRvaW5nIHNvbWV0aGluZyBjYXVzZXMNCnNvbWUgaXNzdWVzIG9yIG1ha2VzIGNv
ZGUgdG9vIGNvbXBsaWNhdGVkLiAgVGhlIG1vdGl2YXRpb24gb2YgdGhpcyBwYXRjaCBpcw0KdGhh
dCBub3cgSSB0aGluayBtZW1vcnlfZmFpbHVyZSgpIHNob3VsZCBkbyBzb21ldGhpbmcgKGF0IGxl
YXN0IHNldHRpbmcNClBHX2h3cG9pc29uKSB1bmxlc3MgdGhlIHBhZ2UgaXMgYWxyZWFkeSBod3Bv
aXNvbmVkIG9yIHJlamVjdGVkIGJ5DQpod3BvaXNvbl9maWx0ZXIoKSwgYmVjYXVzZSBvZiB0aGUg
ZWZmZWN0IGFmdGVyIGZyZWUgYXMgbWVudGlvbmVkIGFib3ZlLg0KDQpUaGlzIGlzIGFsc28gZXhw
ZWN0ZWQgaW4gb3RoZXIgY2FzZSB0b28uIEZvciBleGFtcGxlLCBzbGFiIGlzIGEgdW5oYW5kbGFi
bGUNCnR5cGUgb2YgcGFnZSwgYnV0IHdlIGRvIHNldCBQR19od3BvaXNvbi4gIFRoaXMgZmxhZyBz
aG91bGQgbm90IGFmZmVjdCBhbnkgb2YNCm9uZ29pbmcgc2xhYi1yZWxhdGVkIHByb2Nlc3MsIGJ1
dCB0aGF0J3MgT0sgYmVjYXVzZSBpdCBiZWNvbWVzIGVmZmVjdGl2ZQ0KYWZ0ZXIgdGhlIHNsYWIg
cGFnZSBpcyBmcmVlZC4NCg0KU28gdGhpcyBwYXRjaCBpcyBpbnRlbmRlZCB0byBhbGlnbiB0byB0
aGUgYmVoYXZpb3IuICBBbGxvd2luZyBodWdlcGFnZQ0KbWlncmF0aW9uIHRvIGRvIHNvbWV0aGlu
ZyBnb29kIHVzaW5nIFBHX2h3cG9pc29uIHNlZW1zIHRvIG1lIGFuIHVuc29sdmVkDQpzZXBhcmF0
ZSBpc3N1ZS4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
