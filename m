Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AC24B6253
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiBOFPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:15:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiBOFP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:15:29 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2068.outbound.protection.outlook.com [40.107.113.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA021D04B2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:15:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YL4uEzElsu2+kdAZGNy3/s3Zohvg24IzjROBlMNhVFT+o5lpKqlcYiaM2QoqRHROB85g/CHcqttGqNib/LlR06VTkfO5hiJ+V6oGI3QI9V4rU4HUY+ePlF+7apwZTEIamTB8UN4piLBfZfD7toksPKbbLkVoSlgp+c+PyB6SLqZqbKWxhf2cK9QVLIUN1LsBMFUOwpYoWfe2zUBrbfFVS3nBX3FGVB3bs4EH1BmUbkoNgMzrznTd1AyIZAaIX5uPbwNyrjH6ZjeXeG35y/gQNiJASin/C4+gs4rJ7WJ9AkDPfT3eBNOazUg0s01AqieLQgXjWP4VbNnP8hcKsPgvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0844HE2Mvd/t1MRGYidCWvJDxCegfbl1UVg+rE2Bufc=;
 b=e0lwzQGakN5iRlXM8YJaeYYSJO5B/uuiyORsM3dplaGyU5VEwLfg2W232j97McCq/Lu8eNe5F75cHkaicJSBFW2SEwlL+7IN+HfCB0kArUmSxea438I+9KuOjZcZtxby/HRmb7uE8Oinmz1FmlJnZ0HEUNNoVqSL2yvLEZGi/tUDpuSkIRkCDkFnIHQlkSwBHp80CwWDxmcofaRbB3yMR7LwKOcmOoF4410pv3+P1qltX6QIA/8JLJKcDOox640RGiJoq3Y4Ymn6bmN8XidU7oudZxd+k5nsTFbKCILBmotPTH1xbsJnjRDJcPPINXT+/J/7yyQuxBgL8hMRwwtA0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0844HE2Mvd/t1MRGYidCWvJDxCegfbl1UVg+rE2Bufc=;
 b=htYRd/IgYi3yQrZsofAoNbYmZAjLPVOdPNPM0luqy4qIK32sm62gguTtYwIH4BjXkA56t1rW4Z1vmhaKt6ICVbspednONcsq2fx1IUHJ/dMOS14EF22vplV0SUG3XsQcEYoZP5pn7DflQkr0YV2d64XMZl3YeitatY+SxORslDk=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB5727.jpnprd01.prod.outlook.com (2603:1096:400:47::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 05:15:17 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 05:15:17 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Rik van Riel <riel@surriel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH v2] mm: clean up hwpoison page cache page in fault path
Thread-Topic: [PATCH v2] mm: clean up hwpoison page cache page in fault path
Thread-Index: AQHYIfn/AL9DAriJu0uasOu12MLroayT1TgAgAA824A=
Date:   Tue, 15 Feb 2022 05:15:17 +0000
Message-ID: <20220215051515.GA1918865@hori.linux.bs1.fc.nec.co.jp>
References: <20220212213740.423efcea@imladris.surriel.com>
 <20220214152407.67e0d7dd1a532252c9dd203e@linux-foundation.org>
 <6f70cc26ccc92d099f1080e4c57ab44709bafd68.camel@surriel.com>
In-Reply-To: <6f70cc26ccc92d099f1080e4c57ab44709bafd68.camel@surriel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fdb9c8f-c6c2-4687-0ad9-08d9f04227ec
x-ms-traffictypediagnostic: TYCPR01MB5727:EE_
x-microsoft-antispam-prvs: <TYCPR01MB5727508B3D5F1878E835943DE7349@TYCPR01MB5727.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3kCbtE85OzYIJSNDis1BsdzCux9A2son6UH9wwV7qVI2ZnamTFdCxo7ebjqfZgv63uezPX8pnvQaCAEUjspX3823KAqLSLGXe50hIGTSRPC3O8YcncaZ4SaCcMbIPN8wqPHv7SqMHJvndQI0K+Wg18s8df1vpVMFS/eeYSSnsfH9NNx/zohMX+2kr8h6NT8HwOFpsjyTV1gQtM5T7Y1UXeZ0nvlm/SR6366b+n9JH7/DoV1sJj3GVsI/LXwlYuOPqjPcJBzDqUmA8uoGb0f5d2fnHW6aYZHcQpRLTvYyTKUyoDsfYxNed6LEWBBdk994ISn+B5R8lUgfnUOh8fpvwJH+Dp9HVuaxZdaJkfYV51FG2PfKOhK9UzQjMJSwhcYlRAxe0atfTE4WqK48Y4slR+h0Ok0dgg7yFsI11UeozqbifdVFwEzzhjL87A6RL9dE9ZWlqILmvq1LpV9eRgJlpWonD+DqD5LdoPW/6dARBJrTbwUVd9ioNBpuUBxrKCbtR53uqAvHNv8aSl7KS2OzKpk2+pW4JKjZZb/3QMefp+EjUL/8c8mnNzeALBdcgvDvqxRJV424e8gQtYYRrbuzJxV4fUzyM7DJhTvkyTbQyrVIzvOx9u8KgCsL0cWgJa84jUcQoGlCLvfe5pjv0WBoPBsvsuQM6lr3Za9ODc545tDqCr8CkJwVH/jiiy+gHG58w5JjZsEomgFov4RFgr+bKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(82960400001)(122000001)(38100700002)(38070700005)(71200400001)(55236004)(8936002)(66446008)(66556008)(66946007)(26005)(76116006)(6486002)(33656002)(8676002)(508600001)(4326008)(66476007)(6506007)(186003)(64756008)(83380400001)(1076003)(85182001)(54906003)(5660300002)(2906002)(6916009)(7416002)(6512007)(9686003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlRFZnJmYWZnenZ3M3RoWnUxYXdkV1hqaVh3Si9LZ2s2M3BHdmdXR3R2bmpx?=
 =?utf-8?B?cW1wOGlremt3d3ZOZGJoNmZJQmhLMWdtSzQzSzZWSXRjVUVKVEtJSUdQOXBG?=
 =?utf-8?B?UmhQWWhjby94MGd3WFVHYUNzWStsMjlpTWdPalFRaFpjQ2dsVSsvY2VyZm82?=
 =?utf-8?B?bXBTN0JKbEZDcUhkUjlydU41UmFTS1gyTmF4WmkzaktqRGFuYTFrVGd4cURt?=
 =?utf-8?B?cTR1a2RMZkJDeEszc2kvTGxZTlovdkRPRDExRHdoN2RlMXFKY0xCZExTQk1D?=
 =?utf-8?B?ekt0L2oyNXZqZHlUNUpTTG9EdktUZnEyTU80blYrMmt3azZ4LzJUN0txQ3Zn?=
 =?utf-8?B?aUQ3ekhJUExrRWFkMnJRWlRBcm52RkZDYThGcHR3SmJFc1poU3plcCtKSWRZ?=
 =?utf-8?B?VUZlVkZpNTVYaXUwREx2ampWNVBJcnAxM0lSREJVVFJzME9rTE9UcGoyT0Qw?=
 =?utf-8?B?Tjdjdk9BWWp4YVdGa0lFNm41c1ZQSnpUdnd5R0ZPcWhGZnhSbzRCR082RS82?=
 =?utf-8?B?Q3FWZ1c5aGIxY1U2cDN0M3B1UFJBZUMwOHl4Rm52OEU4LzJFWWt6RW92UVRE?=
 =?utf-8?B?RHV2b2I3VUc4Z3M0UDRSYVNpTmVGa0pqMmhTUWVOTVNCdGVjNDVmMmNZVktU?=
 =?utf-8?B?OVRKR1VOSjBJbll2T2FZbHJIQWVlYlozN01VUTUzNGVOZ0ovNmJCaVVjOHNU?=
 =?utf-8?B?QjNmdlpKakQ0KzFDMFB4eVZkZndHWWk2OCtpWXlQeENDcEwrTEo1aHE5OWJQ?=
 =?utf-8?B?bWJHRWNzUHlyVWJTU0dnNUh0VHd3c09NVWNTeEtPdVlhMjBYOC95TU4vZC84?=
 =?utf-8?B?dEhyV00ydUxmK3U2ME1PR0h3M3JuUTMrTE1zakp5ekVBQ3JKYkVsSE1IQ04w?=
 =?utf-8?B?Rk83WUNPU01YQm1PZmsyU1ptV2NIdkdIU0h1bS9DMnJ3cExNUTJlZDc3elA3?=
 =?utf-8?B?eElscThyWkpva1NvaEZQcVMwdyt6TVFwMFBDNUhYeXp0SHNXU09uNU0zZEpm?=
 =?utf-8?B?R29FejB4QWc5ZTBNMUN3RHk3QlJpa0tKSVRKK0hTN1Y1V3JXR0h3SjF1T0Zs?=
 =?utf-8?B?MzhSb2E1NWg0bi9xRjlYcmJhOGVpQld3QklJRlZwYWhRUjcvV2xIZUZNR28r?=
 =?utf-8?B?eXptUTNYaVpyMUdIR3U3am9uWDhyc040c0NwUjhod21lYm9IOS9tS3RDdEJ1?=
 =?utf-8?B?Qlh4M0tWejJqOHZodlBDdk5lUjNjNXRPTHVXcDFvdi9rdDhtZUtXcEw1ZVkx?=
 =?utf-8?B?djJOVnJrUWM2NEtvQjRwcFI0UGVqVG9uNStkSURsSzlKdHdWNFFxb0xPY3Nq?=
 =?utf-8?B?UnY2LzhHZlduMWtaWE1mQXFNRXVlanFQMTZkSzFic0R2eWFJR1ZyTUJ1WkVI?=
 =?utf-8?B?cHpJSGhoZlBjQzdaT0R0b0dFcXBoZHpHUGdWOFUxQjZwOTltbmVYTVFLY3k0?=
 =?utf-8?B?VnNSUERkcDE5KzlBcWZtOGlrUFI1cm9nUUJyaTlGQnRIQWJGcmRiMDBlQ0xT?=
 =?utf-8?B?M2orTndtaFY1am0rV3dkbm1HRXM1WmN2a3JOZHo5cWJESWJua3JteXZsUjlz?=
 =?utf-8?B?dCtFU2prUDFpcFB1a1NoQjBHRlRuSkRoNWhEZHFUZ3BjNHVrVG5KQitLdGt0?=
 =?utf-8?B?MkdhSG9QdlhRZjFuK0hESDFIengvQkdSa004VnZRM0tpSDJHM01kcHROUjNp?=
 =?utf-8?B?Vm0vOFZJWEZEVVYyMW1heFViWVllS29sbE1FQzBwK2RXMXFNN25QVEdHUnRO?=
 =?utf-8?B?TjEvT0FqVnJCWVZvcnRZUFZvUE55SmJ1MWlWYnA4QXBGbnVOcXVVZ0NjRktE?=
 =?utf-8?B?QXJGQ1I0T202UnFwT2ludlhia0MxVG91SkFzdW1iNDg1QVZYSU8zZnhCa29x?=
 =?utf-8?B?RU1PZmZ4QW1KMmgzV0pEd3NGeCtKTlBSSGxxZ1h1UnpyVUVKWG82ZkgwbE12?=
 =?utf-8?B?MFIyTTNXbFRNQWtwWllWUHBwTTNwdzhYUjBEUTQ0ZW0rek1laGdIUkx4OE0y?=
 =?utf-8?B?cXp5VTJUbFN0OGFSSUF3UElaaUhGT2FScHpXeE9aMDhveE9USWhxT3ZNeXpp?=
 =?utf-8?B?WU9tTnh2S1Zjd2Z0TmJwdFhaWjJmTXg4c1hjaFRsRlk5dWtaYlRQcWZjUG5W?=
 =?utf-8?B?SDVxeFhJem9zWC93YW9tQzU4eE5URjBjdlh0Q3RocTB6SkVQVzRCSk0ydzhj?=
 =?utf-8?Q?0mYKpRewBirEMfmTVw7ip6eubmoTPHavAqCUmpB55D51?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <036279BFA9731A41B0736017BD6B557C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdb9c8f-c6c2-4687-0ad9-08d9f04227ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 05:15:17.6986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lzt0H41C91eEyO/arqid7M/BhjXOoWt664vXAY2vyhPjSxlM5ICS8Dimzh6AxT38w4Z858cieDD6K8iG3+B0gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5727
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBGZWIgMTQsIDIwMjIgYXQgMDg6Mzc6MjZQTSAtMDUwMCwgUmlrIHZhbiBSaWVsIHdy
b3RlOg0KPiBPbiBNb24sIDIwMjItMDItMTQgYXQgMTU6MjQgLTA4MDAsIEFuZHJldyBNb3J0b24g
d3JvdGU6DQo+ID4gDQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggdjJdIG1tOiBjbGVhbiB1cCBod3Bv
aXNvbiBwYWdlIGNhY2hlIHBhZ2UgaW4gZmF1bHQNCj4gPiA+IHBhdGgNCj4gPiANCj4gPiBBdCBm
aXJzdCBzY2FuIEkgdGhvdWdodCB0aGlzIHdhcyBhIGNvZGUgY2xlYW51cC4NCj4gPiANCj4gPiBJ
IHRoaW5rIEknbGwgZG8gcy9jbGVhbiB1cC9pbnZhbGlkYXRlLy4NCj4gPiANCj4gT0ssIHRoYXQg
c291bmRzIGdvb2QuDQo+IA0KPiA+IE9uIFNhdCwgMTIgRmViIDIwMjIgMjE6Mzc6NDAgLTA1MDAg
UmlrIHZhbiBSaWVsIDxyaWVsQHN1cnJpZWwuY29tPg0KPiA+IHdyb3RlOg0KPiA+IA0KPiA+ID4g
U29tZXRpbWVzIHRoZSBwYWdlIG9mZmxpbmluZyBjb2RlIGNhbiBsZWF2ZSBiZWhpbmQgYSBod3Bv
aXNvbmVkDQo+ID4gPiBjbGVhbg0KPiA+ID4gcGFnZSBjYWNoZSBwYWdlLg0KPiA+IA0KPiA+IElz
IHRoaXMgY29ycmVjdCBiZWhhdmlvdXI/DQo+IA0KPiBJdCBpcyBub3QgZGVzaXJhYmxlLCBhbmQg
dGhlIHNvZnQgcGFnZSBvZmZsaW5pbmcgY29kZQ0KPiB0cmllcyB0byBpbnZhbGlkYXRlIHRoZSBw
YWdlLCBidXQgSSBkb24ndCB0aGluayBvdmVyaGF1bGluZw0KPiB0aGUgd2F5IHdlIGxvY2sgYW5k
IHJlZmNvdW50IHBhZ2UgY2FjaGUgcGFnZXMganVzdCB0byBtYWtlDQo+IG9mZmxpbmluZyB0aGVt
IG1vcmUgcmVsaWFibGUgd291bGQgYmUgd29ydGh3aGlsZSwgd2hlbiB3ZQ0KPiBhbHJlYWR5IGhh
dmUgYSBicmFuY2ggaW4gdGhlIHBhZ2UgZmF1bHQgaGFuZGxlciB0byBkZWFsIHdpdGgNCj4gdGhl
c2UgcGFnZXMsIGFueXdheS4NCg0KSSBkb24ndCBoYXZlIGFueSBpZGVhIGFib3V0IGhvdyB0aGlz
IGtpbmQgb2YgcGFnZSBpcyBsZWZ0IG9uIHBhZ2UNCmNhY2hlIGFmdGVyIHBhZ2Ugb2ZmbGluaW5n
LiAgQnV0IEkgYWdyZWUgd2l0aCB0aGUgc3VnZ2VzdGVkIGNoYW5nZS4NCg0KPiANCj4gPiA+IFRo
aXMgY2FuIGxlYWQgdG8gcHJvZ3JhbXMgYmVpbmcga2lsbGVkIG92ZXIgYW5kIG92ZXINCj4gPiA+
IGFuZCBvdmVyIGFnYWluIGFzIHRoZXkgZmF1bHQgaW4gdGhlIGh3cG9pc29uZWQgcGFnZSwgZ2V0
IGtpbGxlZCwNCj4gPiA+IGFuZA0KPiA+ID4gdGhlbiBnZXQgcmUtc3Bhd25lZCBieSB3aGF0ZXZl
ciB3YW50ZWQgdG8gcnVuIHRoZW0uDQo+ID4gPiANCj4gPiA+IFRoaXMgaXMgcGFydGljdWxhcmx5
IGVtYmFycmFzc2luZyB3aGVuIHRoZSBwYWdlIHdhcyBvZmZsaW5lZCBkdWUgdG8NCj4gPiA+IGhh
dmluZyB0b28gbWFueSBjb3JyZWN0ZWQgbWVtb3J5IGVycm9ycy4gTm93IHdlIGFyZSBraWxsaW5n
IHRhc2tzDQo+ID4gPiBkdWUgdG8gdGhlbSB0cnlpbmcgdG8gYWNjZXNzIG1lbW9yeSB0aGF0IHBy
b2JhYmx5IGlzbid0IGV2ZW4NCj4gPiA+IGNvcnJ1cHRlZC4NCj4gPiA+IA0KPiA+ID4gVGhpcyBw
cm9ibGVtIGNhbiBiZSBhdm9pZGVkIGJ5IGludmFsaWRhdGluZyB0aGUgcGFnZSBmcm9tIHRoZSBw
YWdlDQo+ID4gPiBmYXVsdCBoYW5kbGVyLCB3aGljaCBhbHJlYWR5IGhhcyBhIGJyYW5jaCBmb3Ig
ZGVhbGluZyB3aXRoIHRoZXNlDQo+ID4gPiBraW5kcyBvZiBwYWdlcy4gV2l0aCB0aGlzIHBhdGNo
IHdlIHNpbXBseSBwcmV0ZW5kIHRoZSBwYWdlIGZhdWx0DQo+ID4gPiB3YXMgc3VjY2Vzc2Z1bCBp
ZiB0aGUgcGFnZSB3YXMgaW52YWxpZGF0ZWQsIHJldHVybiB0byB1c2Vyc3BhY2UsDQo+ID4gPiBp
bmN1ciBhbm90aGVyIHBhZ2UgZmF1bHQsIHJlYWQgaW4gdGhlIGZpbGUgZnJvbSBkaXNrICh0byBh
IG5ldw0KPiA+ID4gbWVtb3J5IHBhZ2UpLCBhbmQgdGhlbiBldmVyeXRoaW5nIHdvcmtzIGFnYWlu
Lg0KPiA+IA0KPiA+IElzIHRoaXMgd29ydGggYSBjYzpzdGFibGU/DQo+IA0KPiBNYXliZS4gSSBk
b24ndCBrbm93IGhvdyBmYXIgYmFjayB0aGlzIGlzc3VlIGdvZXMuLi4NCg0KVGhpcyBpc3N1ZSBz
aG91bGQgYmUgb3J0aG9nb25hbCB3aXRoIHJlY2VudCBjaGFuZ2VzIG9uIGh3cG9pc29uLCBhbmQN
CnRoZSBiYXNlIGNvZGUgdGFyZ2V0dGVkIGJ5IHRoaXMgcGF0Y2ggaXMgdW5jaGFuZ2VkIHNpbmNl
IDIwMTYgKDQuMTAtcmMxKSwNCnNvIHRoaXMgcGF0Y2ggaXMgc2ltcGx5IGFwcGxpY2FibGUgdG8g
bW9zdCBvZiB0aGUgbWFpbnRhaW5lZCBzdGFibGUgdHJlZXMNCihtYXliZSBleGNlcHQgNC45Lnop
Lg0KDQpBY2tlZC1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4N
Cg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
