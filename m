Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7284564B76
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 04:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiGDCFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 22:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGDCE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:04:59 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2056.outbound.protection.outlook.com [40.107.114.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F1D559C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 19:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcn6uJ955FcWI4V9riag1JnQR7xYw+0cKtA8x5rpmMEhDqRDKvAXQxSjYnuGIwvz4H43syo74fFEc2uQ7d/F1KpL7+WVMgD2tQzPo6uW4KURRi0z+ImuqEq+Uo2eFYkwopnHoLjSA+f7rBvs/koKPYXdqtKhbzP2y5VEm/eXOzaikuYkaWHcUVVg+Dd3F3IwoEujRk4fnqrogmcmvJFRY6mS6DKH+K/tSyLeT2fwrphi+90W8Wd6gMXL4JJBwbq9CzFakuGHd4noI4qveiXDLdnw0F+a8IhSjf6b45s33fG9i2HJfWEVWQjDaZkvmfPzb2sFtchBXjdHyDJb0Y+j9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SR1zVNRbJ5P2YSET/8dQVmSgbviVni2cOdd75+mQBs=;
 b=JC9DBdziLl9zTX8/M3ZhEgVzlNd/RkmLWy++GHnkaximgrhf4Q6HIbX/VF4pAMxjUGs9V5SWEAhuZO0Tjts5D+Fe1AF0wcgv7MViV0RHaRessxaH0PTg2667mYMaBLSBNsviDQFXDVJkJfYtEfhxPHAjAQeyDUkVBvsNiIbbF7y53pzJX0mFmfISSmHNiG3/yBERrDgMcHvEjjoPmB5F61DXwru9d8ewWQMvkG1v+QFxzHMTG2uDfVSPh67xR3D9BgijjXuUxpmKEu/RYLLQX61L6YDY+/0LtS76G+EhEQ121PK0uKtCXvTUCjj1vRH0bFqkoeufh4MgMgsaVbwzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SR1zVNRbJ5P2YSET/8dQVmSgbviVni2cOdd75+mQBs=;
 b=Zv3xHr66z8rqhkSTq7RJnwA/p6Y1nNY3WRIELiovlhLiKvfK3M31kmFwDmh710rDCVmmBrruhDi35hUFARUy2Ice2TZxiPcj7zICMpOcl1QGYSAvbxc1ixaTtOO/PmsmT6i92n7J71I7AuRqcU793hjtDB2v04J+TCXS+sFhC48=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYAPR01MB2768.jpnprd01.prod.outlook.com (2603:1096:404:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Mon, 4 Jul
 2022 02:04:50 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%6]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 02:04:50 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [mm-unstable PATCH v4 2/9] mm/hugetlb: separate path for hwpoison
 entry in copy_hugetlb_page_range()
Thread-Topic: [mm-unstable PATCH v4 2/9] mm/hugetlb: separate path for
 hwpoison entry in copy_hugetlb_page_range()
Thread-Index: AQHYj0d4bQ22ef3NDUqXA9oSZ7HD1q1tdjkA
Date:   Mon, 4 Jul 2022 02:04:50 +0000
Message-ID: <20220704020428.GA2466683@hori.linux.bs1.fc.nec.co.jp>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
 <20220704013312.2415700-3-naoya.horiguchi@linux.dev>
 <20220703184259.99a37313037000bd2e9ace9a@linux-foundation.org>
In-Reply-To: <20220703184259.99a37313037000bd2e9ace9a@linux-foundation.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b13a8be-3725-4fc4-e6b8-08da5d619438
x-ms-traffictypediagnostic: TYAPR01MB2768:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ddYezhCKXOwlGoQZTtLk5wQ9gF2PmL9ryHi1V8cSNVf+SFK0Bu/664dTE88A/SNz0+qxKOZzciGXnNduRRPyohnL3V+kfIYPlrBr3AnPjDXsL+e4rYZT/TZdQANY3C68bivtuf5G6BbJJ1rY+dnHErrNE9IBuiuCIb4bs04ATwZQ25oaa/5VmhpOt6IkMb8yqpYuwIXA0dMCGTsPseegjjUJrKWvAaus4Wu9gJ1oBltxQJUBv8alfBPtzsicv9TirRYa8TQAHIRnUkzCqB7J5/P0tXPmszn3q/2cWD+oEyrtbw/5hyW/Ij7sj8hQMPSbmBqyL3DWB5IeVFxBkWI9JqGMtL3opGNn3KVj+sUnrYDT5gbIhzxGF66X0jLDS6DyHThkP0GAKUjNlhUmZn+RGte1hSMAjVb0O7S3iAriu0lZ8WhJC9I1FoD1flg38Dbe4n7huOt55qk6KnviUl3FYfPtdaWV7NJbDZFH3jl4wRDVO041kbtU9LfxbAI95rl5aABt++Q2JVm7L5uJPZX/HZztayBSm1oP54WfPcZa/veTkwxFVp7MvUdH7s7MqTCeR0MWT+7xSqFq1pWUCcEMtf/j6r/YxrLuXgkN8qh3NLcKxHHkuxyU4xlyQ2o3fWXmlCRAMZZRhEw0Lqu82TtqUZNSjYSfP/fH7uPTPiL9X56PuwWfNfVCUpvdNdxYSuzEpHROzkEXgHIfBzm7OizMp14FaZ4XIfS/3mvRV5mCtd1MeGn0ZDzYcha2U3hAJlX3T7PIgoSHfYEXwHFrQ6TRX/kXw5v4J6KU25UWxk9MOC0L9ixbQ7CSWPKlAcWpaTQj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(38100700002)(76116006)(33656002)(66946007)(66556008)(66446008)(64756008)(8676002)(4326008)(54906003)(66476007)(6916009)(86362001)(316002)(82960400001)(122000001)(71200400001)(38070700005)(5660300002)(7416002)(26005)(9686003)(6512007)(85182001)(1076003)(6486002)(2906002)(41300700001)(8936002)(478600001)(6506007)(55236004)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2kvZnZSeFlBaXc2aWxlRlc2U2kzUFljUEU3eVpmZUdwcE5MWHNjM013dUJR?=
 =?utf-8?B?YnRIVVExT2JQUzNtaTl1Y0xHMVNvRVNtRmtkeHVITVdsQnU1ekd0cExaYit2?=
 =?utf-8?B?NUtSMEYyZmJ2dmNXa0VCRFM4ZmdsWjJ4NnBmOWY3QTF2OTdJbHBSNjZnbjUx?=
 =?utf-8?B?RW9pdVBjYkt4SUY1Z24xcnJlR2tnTXZYdElxK2JUVUd4VG1oRGZYTkR2ZnFT?=
 =?utf-8?B?YTBVT2VuRXkxZGFvV2xrRDV5T1BhZFQxaXJmZ1hOaTNTN0V4NEVYemdMdDVH?=
 =?utf-8?B?bXUzdnA4UHhjOSt3T0NSdHFySW1aN3c0NmpLRk8xajFnanVWM2xkNVJGSjFR?=
 =?utf-8?B?Z1ZmbmtSa2lBU1FsQURkeEszSkVVb1ZyUzdHdFFreDlsSGtzdlIzZ0hqSWlX?=
 =?utf-8?B?TU1ZSk1zYnJaZll1K0h0Rk9nWVI5WHN1dFVtVVpJMk1tRTNINE5LQUNuWXBv?=
 =?utf-8?B?UnJDNHc3UUZBUlphNzZyejYveFpab1pzcVpUZlJpSjYzY1Z0NGFJTzVmdkI1?=
 =?utf-8?B?TGdOK0h6WjZ6ekdDSFZTa0FLdWM0eUp6QkVNTDcrdDY3UnJicnlJNXJpZk1p?=
 =?utf-8?B?VUgyNFlZVkhjVlRUaUdpLzFqTkR1NWRJS3d1V2puazNtTG5rY3ZFVU1nUjBa?=
 =?utf-8?B?SlFVc1ByaENrNlR2Mlp6UVNldmhqeXhBSHR5Smd3UnM3cEVWaUtzSWZWYVZU?=
 =?utf-8?B?Tkt1ZDAyU21SNVNVb3pHdGh0M29PTHVFcE5WdCtlcGdDNklha2FORU9wOTRS?=
 =?utf-8?B?ZWxMdGJHZFV4M0dXK1k2dGFOcnZyTFlsNG5qWk9FY3VSa1ovOEt1dGdKdkgw?=
 =?utf-8?B?RUpXNWFhWTJvRGtCT2M5Z2dMNGxJTjdJSWlKWlhYR0lpUng1eUROZXp3VmRD?=
 =?utf-8?B?OGZaNFlzeVJ3VWUrdy9ialQ2NUJ3eWlHUUgwaTFMME8zVk9JTmtLRTluR2Rh?=
 =?utf-8?B?QVJHUklXWHcyMzI5UTYza2tzbkd5dEhPZXFibjVPbE9iOGMrdC9sN3M1NFRJ?=
 =?utf-8?B?Z3ZFK211K2JWUHFSNWFqOUxDVUQrTlE4NGFnR0JvWnQ4NnlQdFNwNTdUL1Jn?=
 =?utf-8?B?ZDlXRkNGenMvTXR2c0pzbVk5VkdBME5qUXU2U1ZDZHc1bjh2MTh0UjdjMWlu?=
 =?utf-8?B?T2l4RUtrdUVpbUFWazZIVzl4dEtZc1lVN2wwUmQra2RjUUwwOGRTZlRROUNl?=
 =?utf-8?B?QThoYk9SYVY0VTRreGkzOFFvWEQ2M0hseVIzSmpRcTZMN1Y4eEJmSnZXNDh6?=
 =?utf-8?B?VHVBc2l2bjYvMWw1MG42QW8xckZRRjdiQU04SDljbWtHc0E3aFQrdFVTYjJa?=
 =?utf-8?B?cEJHRTNIb3BibUU5eUhCYUZWazBudS9OQVhPVmExcFNhK0ZpZTlnZ1JNczYx?=
 =?utf-8?B?YTlEYXNkSVhKQ3dPeHZDL2RHc3kzTTlsTUUwMEdQT0ZHZEJ4aGJCazNwblJt?=
 =?utf-8?B?UDZEbWpwSkJHQ0NDK2NBYmQ2YWJUUU9JQnR4d3B3TTYwVE5Ja0lsOEovRm4z?=
 =?utf-8?B?cmR3TUtGMlI1bFZmaklZbDVoWTZiaU9BNmFsVHVkUnJwV00zNkd2MytWK3Ji?=
 =?utf-8?B?aENBbVFnalhOcXRvdnRGcElVSnJEaUpEMWthaWo4UmxMcXp4a2xjRzlNRm0y?=
 =?utf-8?B?c1VVTkd3Q3lpLzBaSXZ5OEFscCtGVG1Sbm4xbDltZkJwbVNwQW9DUUEwdjYr?=
 =?utf-8?B?SkdWUDNTMEVyclVRdVFQVmZlWkFXeWdOYnlqaXY4QW41RjFrOUFqMEdmN1VG?=
 =?utf-8?B?cGhFbDY4T3BkSzBWKzc3VGlBbUtlMXlNZlh4cVF3UjdkRXczOEZvTTgrRDAw?=
 =?utf-8?B?MkYza3Q5RXNjdjVwczlyQ3B5NmNMcHJJMlc0U291N25tQVR5YXlEeWxiWVJp?=
 =?utf-8?B?aEJEampaY1dSQ0Nzdkg0Z1ZsRHpXNElXdWpTSDFhOTdVQi9mTEQ2YXdmL2FF?=
 =?utf-8?B?WThWR01kOGdYRk9BOElLQWwzMGxLK0pNSzNOc1ozby81RWlsQ0Q2TjBuV2FU?=
 =?utf-8?B?Q1NTZjRBVUlaUU42LzgzOTdwR0c3OElPWGZXR1ZHVnEyYWY4QlFRcys2aW55?=
 =?utf-8?B?Z2dYS3lHNDVoUnNMNWp1cXJQUjJYY1VXZmM5N3ZZRm5lQmp0bWFiQzRMSlJw?=
 =?utf-8?B?K0Q0NVUwQW02RkJGR1NWbFdsbFdrTi9oMlovS2tTclFwOXBxYSs4d0Ixc1Yx?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A08F73BEFA96974DBFB432BF3B1E64F7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b13a8be-3725-4fc4-e6b8-08da5d619438
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 02:04:50.5115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1s4KMqHtqlFfr8LtwUdkyKpUbzCzvnkGkhd1Yg/zAkyM8mtZenOuifKWlU1rqFVRzK/soQaAhMrJrtdPBL0Rig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2768
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBKdWwgMDMsIDIwMjIgYXQgMDY6NDI6NTlQTSAtMDcwMCwgQW5kcmV3IE1vcnRvbiB3
cm90ZToNCj4gT24gTW9uLCAgNCBKdWwgMjAyMiAxMDozMzowNSArMDkwMCBOYW95YSBIb3JpZ3Vj
aGkgPG5hb3lhLmhvcmlndWNoaUBsaW51eC5kZXY+IHdyb3RlOg0KPiANCj4gPiBPcmlnaW5hbGx5
IGNvcHlfaHVnZXRsYl9wYWdlX3JhbmdlKCkgaGFuZGxlcyBtaWdyYXRpb24gZW50cmllcyBhbmQg
aHdwb2lzb25lZA0KPiA+IGVudHJpZXMgaW4gc2ltaWxhciBtYW5uZXIuICBCdXQgcmVjZW50bHkg
dGhlIHJlbGF0ZWQgY29kZSBwYXRoIGhhcyBtb3JlIGNvZGUNCj4gPiBmb3IgbWlncmF0aW9uIGVu
dHJpZXMsIGFuZCB3aGVuIGlzX3dyaXRhYmxlX21pZ3JhdGlvbl9lbnRyeSgpIHdhcyBjb252ZXJ0
ZWQNCj4gPiB0byAhaXNfcmVhZGFibGVfbWlncmF0aW9uX2VudHJ5KCksIGh3cG9pc29uIGVudHJp
ZXMgb24gc291cmNlIHByb2Nlc3NlcyBnb3QNCj4gPiB0byBiZSB1bmV4cGVjdGVkbHkgdXBkYXRl
ZCAod2hpY2ggaXMgbGVnaXRpbWF0ZSBmb3IgbWlncmF0aW9uIGVudHJpZXMsIGJ1dA0KPiA+IG5v
dCBmb3IgaHdwb2lzb24gZW50cmllcykuICBUaGlzIHJlc3VsdHMgaW4gdW5leHBlY3RlZCBzZXJp
b3VzIGlzc3VlcyBsaWtlDQo+ID4ga2VybmVsIHBhbmljIHdoZW4gZm9ya2luZyBwcm9jZXNzZXMg
d2l0aCBod3BvaXNvbiBlbnRyaWVzIGluIHBtZC4NCj4gPiANCj4gPiBTZXBhcmF0ZSB0aGUgaWYg
YnJhbmNoIGludG8gb25lIGZvciBod3BvaXNvbiBlbnRyaWVzIGFuZCBvbmUgZm9yIG1pZ3JhdGlv
bg0KPiA+IGVudHJpZXMuDQo+ID4gDQo+ID4gLi4uDQo+ID4NCj4gPiBDYzogPHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmc+ICMgNS4xOA0KPiANCj4gSXQncyB1bnVzdWFsIHRvIGhhdmUgYSBjYzpzdGFi
bGUgcGF0Y2ggaW4gdGhlIG1pZGRsZSBvZiBhIHNlcmllcyBsaWtlDQo+IHRoaXMuICBPbmUgd291
bGQgZXhwZWN0IHRoZSBmaXggdG8gYmUgYSBzdGFuZGFsb25lIHRoaW5nIGFnYWluc3QNCj4gY3Vy
cmVudCAtbGludXMuDQoNCkFoLCBPSywgSSBzaG91bGQndmUgc3VibWl0IHRoaXMgc2VwZXJhdGVs
eS4NCg0KPiANCj4gQXMgcHJlc2VudGVkLCB0aGlzIHBhdGNoIHdvbid0IGdldCBpbnRvIG1haW5s
aW5lIHVudGlsIGFmdGVyIDUuMjAtcmMxLiANCj4gSWYgdGhhdCdzIE9LIHRoZW4gT0suICBPdGhl
cndpc2UgSSBjYW4gc2h1ZmZsZSB0aGluZ3MgYXJvdW5kIGFuZCBzdGFnZQ0KPiB0aGlzIHBhdGNo
IGluIG1tLWhvdGZpeGVzPw0KDQpZZXMsIEknZCBsaWtlIHRvIGFzayB5b3UgdG8gZG8gaXQuIFRo
YW5rIHlvdSBmb3IgdGhlIGFycmFuZ2VtZW50Lg0KDQotIE5hb3lhIEhvcmlndWNoaQ==
