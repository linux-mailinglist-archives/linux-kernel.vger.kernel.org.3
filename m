Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932855735D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiGMLyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiGMLyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:54:06 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2048.outbound.protection.outlook.com [40.107.113.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8401733A3E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:54:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9ebg5pYXdm8t+M84fhtMOwIidDAM4Ipr8L+WG5jxb1Z0AwDRHo49QLW7rKKbHiI9Df8QufKOFoTh+xtzkh0RrFqRQNkYhhdX6k81j48DUNApo0d2CQ7S0hfGTp+mk6wHOvJq2B9TNFtcUl6+ekACOA47NZqmJaI2V7k4X77MDpEhqlm0d58LM95wjfUNGI3CzIRX18VN5mNt9WzNwFajQLDhYHjHgJtBxM80SReLbn4PJYEDtTYib4l5UEQXCq6QsJBlJNjOYlIsIqP/tfphUpNpdE2XsYtyGgzYBZpnuAIAogo+ZsMZ4l6Z/Qd7aoW9Idz3Umd22o1GLJU5H0FuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3IxMLZxi3UZSeGZJNZG9VczfSYJnjicgMaRJ8wLgX4=;
 b=eCU0sRxaZCK9v+9BkXEqaRckc6awspazrdHEOTXSGl1nTuMMxLnEjU33rBd4Y46MRWgW+JPzpMriABbszbvubfzjlH87VBFHcww0Mh2MYffiOPAD3iYH2m/vbICpkikdHnAfuPf9w0M017W5DLzJqqYS4UONY5fogJNaTfyTMGzkxi1zAV6GzemeQBwTgbDlZYBqWETuMxP5RaAqB0vkKSuBeJR+yDLh+HGYLkSXbeqKLXWaMCmPmft/MKWWpgN5AZaKXKWHoyEM3VKWeA5o8DAoewBiqnXcvwoZ6BWFjfS+R+A1c3IiWrw76C7NdcrCQTbkqJTPYxXKFoD3syWzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3IxMLZxi3UZSeGZJNZG9VczfSYJnjicgMaRJ8wLgX4=;
 b=HHweh8gqe9INAFrsEAWG6I1GABUKPQ4I+qJFZS9Hbwo5oXtnhod+1wSxJZ8U1E7+DA8zl0T9wz3cuzLiOW6CB0DBzTnxSgshI9UE1IC3ATW3/mdI0ddAL6wRrLm9juJvA5AIUC/d1CKZ2tC/OHoyEWr3sNFKso62RalCDdHe/wY=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS0PR01MB6354.jpnprd01.prod.outlook.com (2603:1096:604:104::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 11:54:02 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 11:54:02 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [mm-unstable PATCH v6 4/8] mm, hwpoison: make unpoison aware of
 raw error info in hwpoisoned hugepage
Thread-Topic: [mm-unstable PATCH v6 4/8] mm, hwpoison: make unpoison aware of
 raw error info in hwpoisoned hugepage
Thread-Index: AQHYlnCEwJtH5HXu20S+4zzLy1rVCq18MZqA
Date:   Wed, 13 Jul 2022 11:54:02 +0000
Message-ID: <20220713115401.GA2824071@hori.linux.bs1.fc.nec.co.jp>
References: <20220712032858.170414-1-naoya.horiguchi@linux.dev>
 <20220712032858.170414-5-naoya.horiguchi@linux.dev>
 <1ebd5240-7298-5d1d-cc1d-d289d843472d@huawei.com>
In-Reply-To: <1ebd5240-7298-5d1d-cc1d-d289d843472d@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c234ffa-fa11-4cc3-acd5-08da64c6612a
x-ms-traffictypediagnostic: OS0PR01MB6354:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y7qxKpffVy6JrKEUauX6r1WEMzUGqzGbzHuLK6tQHubjO+7JyNGxCdMvcUgoP9F/qjpP6zvtVAbNV5qCTqMCh7d14Go1RB89n0j4OX9Sehvjv9tjSo/UNmnnj/T/JvEfoG182Y/493HFMN6nnF8h+C8A+mxJDCnagwHVbiT9q+ifAEVOaasEwDcQPbx2zRdPElTbxFeevppNBOzYjYgxjYloiSsTeus71UMZmgwv6QH/zlDA3nJB3hVEQUKqZ3R5PBVQQbsNuE+GgvKUNXT1uVJSotKiy7XmYmk0WBtV63LIS115zpaXVwAxt1BFlfbgEA3FTiR64uKoWS5gKa8aYgcKbEK7Blg/88Pw3WbMphuElkr+sWbGV2Hf/NKB4iRJMiee32jzWhFdrng3CtyMV30nEL09n3fjZWQgCrxlS4MtmCBIXPcVtxm+CHCptCWJtu+SzlDe7UY+fe9F7Mf/l//gzbDiXqsQnp2zqCKvPQOUl/BRYTvqKVY1zveFdYGzBzeclBvo4qol6uFscxST5WH0RgxXQDja7NHuEjtaNGCoRSCbv2rQQ+RXEL2dlzJHGhCHfZNiPocjVcBDY5dhWqkBQmKDf3sDIH+64MAEtdjMZjYxoNwyue/u6CH4nPY+dBJH5f6PtNvl4UjPmNUAbMQN5MHoC4O3PyaJtp59GVc25Ky1ozwkOQsZ8kz8ODA02dcsjfYmyd7+lUEWDIgO7z74y1bNvU4ExTRoodSlEbYrF3+UJ2Qkjqi5ejjKUta+UvYK3ZX2vvlXBGF/wAH3p37valQpvWUDsK2o4Rzg6CGZN9o9oYZn89Q+nl5P7PDV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(6486002)(55236004)(71200400001)(2906002)(41300700001)(6506007)(53546011)(26005)(83380400001)(54906003)(76116006)(1076003)(186003)(6916009)(85182001)(38100700002)(316002)(38070700005)(86362001)(66446008)(9686003)(122000001)(66556008)(33656002)(8676002)(478600001)(64756008)(66476007)(8936002)(66946007)(7416002)(82960400001)(6512007)(4326008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkFPcHA3WXNFYVhISm9ySzFjTTJpMzR3OGhyamp5amIybi9rTWJ4bXZCWHNa?=
 =?utf-8?B?dW9CMm1nRjJjYkIrdkRpQ1E4TUZhOWh2QW1nc1pHOXNPZ2JiY0VQWmpLRjFi?=
 =?utf-8?B?aEhONUhnUTNrVkttQm4xNWtxaEQvcXJBdHZxaWdObmhUQjNsOS83ay9DWHJw?=
 =?utf-8?B?RzJMT0NvK294TnBSam9IT01KbVd6TFgwUWZMbXdtelY2V3pwaXp6QUpXQkE2?=
 =?utf-8?B?N1BkNFFEU2J2bU1kK08zWC91RTdPMEdMbjZxREZPZWZPUkJQc2ZmaDR5TmJR?=
 =?utf-8?B?ZHE5TmZrNkdZZXZ4WVFrTTRjQktubjRLUmpVY3FUeWhnV1NoZ3VKY0duVkRD?=
 =?utf-8?B?Nmt1T2xPYXJ1YWthamVYUitvTGZBZDVnV1V0cUhRZThsb3ZkUlFuWndXc3Bu?=
 =?utf-8?B?NWo0RlNhcllxR0FmUkcxNlVqYlEzS3hpU2FpT0kvUzNzc1NSV0VDRWx0VlEy?=
 =?utf-8?B?ZmNXN2pyYzRHQnh4UGM3V0FrWU0vWWJaNWR4bktBdjVQdGdIcmU2SnNZZTZC?=
 =?utf-8?B?UjBVWlRxeDRra2JUdTJva2sxZWd2aDFPTEs0eWRiSEVqb3hYZGx4YUI0aEkv?=
 =?utf-8?B?SlZYeW02OEhPQzhsbjcvV1h3c1BNMVhZcnMzMVJiZW9valExaEREU1pLbG5i?=
 =?utf-8?B?RE4vY1dyRFcvZTNlaUFtaVpCSHVuUk9qSUtKYi9BZ0pwS2Q2TWpJdHAyOG5n?=
 =?utf-8?B?Y0Vmb25tYS9ZclR4dFgya1BpRitqV1pvOWROMThTZHQwZnJSaXNFbkk5UDlP?=
 =?utf-8?B?WlloZFc2LzJybCtTekdYYlhxWXFWc0thYXVTcVdHaGp2UUhKWkNlWnpVbnQz?=
 =?utf-8?B?MTZhdGt2NHRpc3dPVTMrUDE4T05NSXdCUmxJZlozaFZDSmVHVFhTaWRrNVho?=
 =?utf-8?B?eWUwZmhENnJzZEs1ZjhKTVRrOHRmZ0M5UVp3VDU2UUZ4eVdXeVVtd3luZFA1?=
 =?utf-8?B?WCtSR0JUZTlEcWh0eTVOTGt4Q2M4TnB2cERuTWJnL0VrcHpiLzBjdmZkWUwr?=
 =?utf-8?B?SmYrb3drbm93OE1aM0ZaVlJOUXNXVFBxTUR2ZUh6SkFwK1FPbVpieTBRUTB3?=
 =?utf-8?B?S3Z2SVVXck90Mm5YRDYwSDhEM1RQQldGZ3E2clczWGM2Tno4RVdETi93bXhk?=
 =?utf-8?B?bVlIZld2VU9XYWhuMmd2dVVkY0d5c2JaUG8wWHFyZzlGeWdBRlovZjh2RGpj?=
 =?utf-8?B?TVBDU1Rjb2pSVmVZUnR5UjNaVDg4MndxWmxoMG1sNzk3N2NpUEVoZnBlWHM1?=
 =?utf-8?B?SlZMY2dYSDZRcDRDNVRPL1E4V040QXdxeFd1UHdOUVBWM3lzNEluT280S2Jt?=
 =?utf-8?B?eldSMXMwYzdaTzlIcHRlUVc4dmJOMWV4KzBienhqb2NaeTFQWmxRekw1RExS?=
 =?utf-8?B?NW5wNldMbFNXTk1WWkxIMzFCQkwzTm5WTG0wNllkMU1zL29yTTV6NWFZd3Vu?=
 =?utf-8?B?Y1hjZGtQWnpiV2pTcHlMQmxXclZsUk5XZ2Mzckd4aExtcEdXVGxNbWdrRzRh?=
 =?utf-8?B?UVJVN29qK1RRY3Nldk9ZTi9BYm1jRXRQRXZuY3pDY2VGeUJhcERYWDVxS1N5?=
 =?utf-8?B?aGVUaExFRVY0VmxER2x4emc5SlJONHRRcEluUVp0NSt6a0h0YkRIaTUxa3Bn?=
 =?utf-8?B?bTZXemtzbjN1YzJaQW55NHRSLy94ODdreUdvSHltb3pCZmFOUGFqQUVOYkIr?=
 =?utf-8?B?RUZiY0w1eDlsWUQ4bUV0LzFMSXg3ck5QdWw3ZnBRWU1JMXlTQ3lxOUpxcUhS?=
 =?utf-8?B?enZjbUJFUlE4UDBHazFXWDZ3ZW1XK25SRDJDT1FQbXhyc2NWc1FVUU5OeHNM?=
 =?utf-8?B?OXB1TFAySGJ1U1J2YWppVDJ1UzU1b1p5VkliWThZS2RwbUhoaUlDbjdSNjVk?=
 =?utf-8?B?NG1RSENGcUNQWjlJa0xraHA5MDlBUHhuTDB2YWt4TFJ2a1JVbjlDeGZMdjJE?=
 =?utf-8?B?QnlaSzhYRW5wWlFtRHpJa3MwR05XdElHVGJIWXBpUnU0dmhFanRrRHRMYUdG?=
 =?utf-8?B?Z3NmcHRuMkhoaSttMExHdWtUQTZjUU5BaHZGVGErMVNValByaEV3cEVBay9v?=
 =?utf-8?B?NzhnV29HQjRHbnlPRnBlMmUvZ0Z2VG1xQUZhN3l1MGYxY1JNUCtKK1EySkFK?=
 =?utf-8?B?dmhIUDcxWFBGeWdGaHRyL0MvQkVBbDVmdGFuekRlL3pBRFFCOXJvMjRjZkxP?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89B354A280E1C546A142D1E30F6AAAC4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c234ffa-fa11-4cc3-acd5-08da64c6612a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 11:54:02.2211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCBNB3EpRtYRCWhn+RdQYqsPP0d24EIMPMRGSuNcYWJY1YnJKU/IWe2d5E7kW/IZgeeeGY9qQvr7jcIqDQYZSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6354
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdWwgMTMsIDIwMjIgYXQgMTI6MjQ6NDZQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi83LzEyIDExOjI4LCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gRnJv
bTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiANCj4gPiBS
YXcgZXJyb3IgaW5mbyBsaXN0IG5lZWRzIHRvIGJlIHJlbW92ZWQgd2hlbiBod3BvaXNvbmVkIGh1
Z2V0bGIgaXMNCj4gPiB1bnBvaXNvbmVkLiAgQW5kIHVucG9pc29uIGhhbmRsZXIgbmVlZHMgdG8g
a25vdyBob3cgbWFueSBlcnJvcnMgdGhlcmUNCj4gPiBhcmUgaW4gdGhlIHRhcmdldCBodWdlcGFn
ZS4gU28gYWRkIHRoZW0uDQo+ID4gDQo+ID4gSFBhZ2VWbWVtbWFwT3B0aW1pemVkKGhwYWdlKSBh
bmQgSFBhZ2VSYXdId3BVbnJlbGlhYmxlKGhwYWdlKSkgY2FuJ3QgYmUNCj4gPiB1bnBvaXNvbmVk
LCBzbyBsZXQncyBza2lwIHRoZW0uDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTmFveWEgSG9y
aWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiBSZXBvcnRlZC1ieToga2VybmVs
IHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IA0KPiBUaGlzIHBhdGNoIGxvb2tzIGdvb2Qg
dG8gbWUgd2l0aCBzb21lIG5pdHMgYmVsb3cuDQo+IA0KPiA+IC0tLQ0KPiAuLi4NCj4gPiAgDQo+
ID4gLXZvaWQgaHVnZXRsYl9jbGVhcl9wYWdlX2h3cG9pc29uKHN0cnVjdCBwYWdlICpocGFnZSkN
Cj4gPiArc3RhdGljIHVuc2lnbmVkIGxvbmcgZnJlZV9yYXdfaHdwX3BhZ2VzKHN0cnVjdCBwYWdl
ICpocGFnZSwgYm9vbCBtb3ZlX2ZsYWcpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBsbGlzdF9oZWFk
ICpoZWFkOw0KPiA+ICAJc3RydWN0IGxsaXN0X25vZGUgKnQsICp0bm9kZTsNCj4gPiArCXVuc2ln
bmVkIGxvbmcgY291bnQgPSAwOw0KPiA+ICANCj4gPiAtCWlmICghSFBhZ2VSYXdId3BVbnJlbGlh
YmxlKGhwYWdlKSkNCj4gPiAtCQlDbGVhclBhZ2VIV1BvaXNvbihocGFnZSk7DQo+ID4gKwkvKg0K
PiA+ICsJICogSFBhZ2VWbWVtbWFwT3B0aW1pemVkIGh1Z2VwYWdlcyBjYW4ndCBiZSB1bnBvaXNv
bmVkIGJlY2F1c2UNCj4gPiArCSAqIHN0cnVjdCBwYWdlcyBmb3IgdGFpbCBwYWdlcyBhcmUgcmVx
dWlyZWQgdG8gZnJlZSBod3BvaXNvbmVkDQo+ID4gKwkgKiBodWdlcGFnZXMuICBIUGFnZVJhd0h3
cFVucmVsaWFibGUgaHVnZXBhZ2VzIHNob3VsZG4ndCBiZQ0KPiA+ICsJICogdW5wb2lzb25lZCBi
eSBkZWZpbml0aW9uLg0KPiA+ICsJICovDQo+ID4gKwlpZiAoSFBhZ2VWbWVtbWFwT3B0aW1pemVk
KGhwYWdlKSB8fCBIUGFnZVJhd0h3cFVucmVsaWFibGUoaHBhZ2UpKQ0KPiANCj4gSWYgbW92ZV9m
bGFnID09IGZhbHNlLCBpLmUuIGluIHVucG9pc29uIGNhc2UsIHRhaWwgcGFnZXMgYXJlIG5vdCB0
b3VjaGVkLiBTbyBIUGFnZVZtZW1tYXBPcHRpbWl6ZWQNCj4gY2FuIGJlIGlnbm9yZWQgaW4gdGhp
cyBjYXNlPyBPciBsZWF2ZSBpdCBhcyBhYm92ZSB0byBrZWVwIHRoZSBjb2RlIHNpbXBsZT8NCg0K
T2gsIHJpZ2h0LiAgV2UgY2FuIG1ha2UgSFBhZ2VWbWVtbWFwT3B0aW1pemVkKCkgbW9yZSBjb25k
aXRpb25hbC4NCg0KPiANCj4gPiArCQlyZXR1cm4gMDsNCj4gPiAgCWhlYWQgPSByYXdfaHdwX2xp
c3RfaGVhZChocGFnZSk7DQo+ID4gIAlsbGlzdF9mb3JfZWFjaF9zYWZlKHRub2RlLCB0LCBoZWFk
LT5maXJzdCkgew0KPiA+ICAJCXN0cnVjdCByYXdfaHdwX3BhZ2UgKnAgPSBjb250YWluZXJfb2Yo
dG5vZGUsIHN0cnVjdCByYXdfaHdwX3BhZ2UsIG5vZGUpOw0KPiA+ICANCj4gPiAtCQlTZXRQYWdl
SFdQb2lzb24ocC0+cGFnZSk7DQo+ID4gKwkJaWYgKG1vdmVfZmxhZykNCj4gPiArCQkJU2V0UGFn
ZUhXUG9pc29uKHAtPnBhZ2UpOw0KPiA+ICAJCWtmcmVlKHApOw0KPiA+ICsJCWNvdW50Kys7DQo+
ID4gIAl9DQo+ID4gIAlsbGlzdF9kZWxfYWxsKGhlYWQpOw0KPiA+ICsJcmV0dXJuIGNvdW50Ow0K
PiA+ICt9DQo+ID4gKw0KPiA+ICt2b2lkIGh1Z2V0bGJfY2xlYXJfcGFnZV9od3BvaXNvbihzdHJ1
Y3QgcGFnZSAqaHBhZ2UpDQo+ID4gK3sNCj4gPiArCWlmICghSFBhZ2VSYXdId3BVbnJlbGlhYmxl
KGhwYWdlKSkNCj4gDQo+IEl0IHNlZW1zIHdlIGNhbiByZXR1cm4gaGVyZSBpZiBIUGFnZVJhd0h3
cFVucmVsaWFibGUgYXMgdGhlcmUncyBub3RoaW5nIHRvIGRvPw0KDQpPSywgSSdsbCB1cGRhdGUg
dGhpcywgdG9vLg0KDQo+IA0KPiBBbnl3YXksIGZvciB3aGF0IGl0IHdvcnRoLA0KPiANCj4gUmV2
aWV3ZWQtYnk6IE1pYW9oZSBMaW4gPGxpbm1pYW9oZUBodWF3ZWkuY29tPg0KDQpUaGFuayB5b3Uu
DQotIE5hb3lhIEhvcmlndWNoaQ0KDQo+IA0KPiBUaGFua3MuDQo+IA0KPiA+ICsJCUNsZWFyUGFn
ZUhXUG9pc29uKGhwYWdlKTsNCj4gPiArCWZyZWVfcmF3X2h3cF9wYWdlcyhocGFnZSwgdHJ1ZSk7
DQo+ID4gIH0NCj4gPiAgDQo+ID4gIC8q
