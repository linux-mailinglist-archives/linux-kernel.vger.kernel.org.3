Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA45735D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbiGMLy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiGMLyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:54:51 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2075.outbound.protection.outlook.com [40.107.113.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0C0ADEB3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJ0/ajIleh9ekuJgoydR1snF7kwUGe5szUbHkAM6s9LBbWr8zYvXtzQ2nkuoAffTSgwshSaMcbm8GkDmqfqzLtc/O8E83YaMrWLYyiD7ibaGqc/Z1t+NHGcNnnlWy5DsyKtaWm68PrZvsAcI/sja15s0XdemrTFpmHXxh05SUdFj5pa2aw3N6uo9c7Fvt8VAzr5qfvULDzO6KN1TG8YPLGFDMPm+rS721cHR4dG57V/JBhpKVuLA+TI9tqEJaD06pd9pX8Yf8aWdVnkL0tuDLgKbVUUpvSQbJLb8kUxrMxdrYxkdVkMl2ED6eEzHVM+QSW4pJ1wHPQOPej3voNYQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4h/VHIf5XRKi9tPA9tbdQdgCfB3heqALF6banGRcgQA=;
 b=PfaKUj8J+8bs6x8QzEpGavpULYftZmBkxVf+pyHbM332cMejNH78aVz+vBXsT72v8ZdcxUw2rts13PRdxIGq4ZYFGoc69vsvP8X2v54HvCuERjXoUMcjNLhaPhg7S6XV4TX0zOdQXsUnt3unFbri7NFGe43MdXhlyz3OWXVFZR+h+Dzd0txbYzpft3KqSUqXeXnFt0F3rwknOctMHLpu2+WV9ZP3nsOXnrdCj3/R7aC13JEwUbLm0CM/eWqRaYpxwvOcRy7X5TFrbQ+PtKVxKzw60t3aMkuMgQ1iz0qkcQFFO9VnwPOPOpmR9aNwWpLMe+2we8nOY7HZQrlUpS2BaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4h/VHIf5XRKi9tPA9tbdQdgCfB3heqALF6banGRcgQA=;
 b=kGl9jPChHAtACE1zpS0HJtIHAm4RXWJrnFtkvaXKByiKR04Jvly+SGDvBnQtocLFYbChkP+B/k7CLaQm6DpZohNC15JZJVejzd8Az3SMq/fl3c/TIOm/jqjrR3L8guOJtI8jec4del1BVUcDr/GPN2IfDriHbuVpOjN54ZHIw5M=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS0PR01MB6354.jpnprd01.prod.outlook.com (2603:1096:604:104::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 11:54:48 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 11:54:48 +0000
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
Subject: Re: [mm-unstable PATCH v6 3/8] mm, hwpoison, hugetlb: support saving
 mechanism of raw error pages
Thread-Topic: [mm-unstable PATCH v6 3/8] mm, hwpoison, hugetlb: support saving
 mechanism of raw error pages
Thread-Index: AQHYlnRCuelC0lVFHEGh94AYI0k2oK18McqA
Date:   Wed, 13 Jul 2022 11:54:48 +0000
Message-ID: <20220713115447.GB2824071@hori.linux.bs1.fc.nec.co.jp>
References: <20220712032858.170414-1-naoya.horiguchi@linux.dev>
 <20220712032858.170414-4-naoya.horiguchi@linux.dev>
 <0ba226e6-c297-d87d-f74e-9036a6121072@huawei.com>
In-Reply-To: <0ba226e6-c297-d87d-f74e-9036a6121072@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c8067c9-274d-4694-c1d2-08da64c67c7a
x-ms-traffictypediagnostic: OS0PR01MB6354:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gAE+OBiI9M65SENu2QMg380hy8hp65XVeMSlucY/nqZ6vtnBZMSM4dMWtv9HqkorNOhFJcvJfyZXFCP62QKcjgIAV/6jmU6JA+NC6/3UG/Vz/tWBpwd/Ug7wqvqJzrVqjZ0Gq0mQgWuA2uvnf6aw5PK3YPpcDLEunmICcZ+IvUHOfbtaJoJJAcE+bRZRRiQlEhxhF+AQjL9+O5NNOXqnATHPmkx7iv8yyc3/44wPhLdguo9zB1+V8LnK8Zgi/2FzwGeN+MaVcvcxXcCGIIEpUyPYwBQnTHwO+ZR5zlHrupqQzFgb7le9NyAC+A0RC7/rqRLADu3RR6jHACCCfwXZaBxTi84E53WwHt7hzqQMPbHptVyWl/wjEW+z7m3qO9DixtqTDMwrYjzDyJTsp/6eH4xI7crINlR0fompxajo/Ut25WyiOtEAwJdOzKIYVxdPdcyZ9EVZmQEUtjN6Pj7VRH30MWbDSZGwBE1Mf5HO9XIqZocobz5p9x/cAQmYBpazXuSe47T9u1yDOhllHy5SvSX41mAn/PBFGS7x7v0kRVo7Lu6XrrLHmWR50oRhFEtRP/K8DnZdoL8gmk7zPk78CQ0rOwarqzSuqAPuypoS3nY2z9BAWWiLhw0Kg+0rWZRtDrcorT3kcMarofm/QK90H7R2a5u/pHustC8JkD/4clUNt6pPw3DhSgtIIvOOjsIYh506XUrX8Eyj58tP4sWnI6hE2JH0bZyeDoXWxuHfdJuWcTaoc1hliStKTuXNRRuWe+75lY7NYx0GK2mj1UZDeb4RYp2sKZlXs3E0jfBpVOrcJXNGw9OvuXeYvGZkLIcU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(6486002)(55236004)(71200400001)(2906002)(41300700001)(6506007)(53546011)(26005)(83380400001)(54906003)(76116006)(1076003)(186003)(6916009)(85182001)(38100700002)(316002)(38070700005)(86362001)(66446008)(9686003)(122000001)(66556008)(33656002)(8676002)(478600001)(64756008)(66476007)(8936002)(66946007)(7416002)(82960400001)(6512007)(4326008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXlYL3BSZmtBV2Z3UWV0T2xINkh1M0trMWVTMjhvWEcxeWFvWFoycnN5anIr?=
 =?utf-8?B?cGtHNDhiMDE3SitTd2FJcFBzYmtBakFvR1krRmNVRlRQUHpObXRaTWMydmZn?=
 =?utf-8?B?WkIyVlFxTWtpLzhZZWJ6YkplakdaQjdndGJtUTl5Nno5d0lmajR5cjF2NkpU?=
 =?utf-8?B?N3J6YUtrTkNDUlRKbC9nVFdKeno5ZUVqTVB2bXk0L3oxZGpaN3FWNzd4YldF?=
 =?utf-8?B?WS96dnV0Q3pRaXcrSkFpN2duMGJHY3VoKzV6eC9VakhNTk9mL3ZIZ0dXb3U4?=
 =?utf-8?B?dExaV1BPMDBGdEM4R0k5ZEFtWWowRU1LN05jRG16bWl3amFxMit0UVV1NytY?=
 =?utf-8?B?NTdPNEt5cjhYK3NPcCtvZnNEU25OZDl0WGRmenBxd0RnUWNzMlYvRXh6ZkVt?=
 =?utf-8?B?R1VGWml0VzRMYmVqblFtZWdNRnh5Z0QreS9EZlJid0ovZnUva2pKeDJ4NWU3?=
 =?utf-8?B?aldGcktIYWdmZW5FTHJUbjUvVy85cmZFblZOMTRiRi9udXdiTUJpaUZmWFJl?=
 =?utf-8?B?QXovdUo4Yys5dUxNYzl6b0VFWE9kR3ZhaWVZa2hCWWsvVWFHbStCYnp5SmxP?=
 =?utf-8?B?S3VXZ1R4NU1uZWlDbUswRzY4TWc4N05DTTJPU2VoSmVYNVJJV3BjcXNhVmhO?=
 =?utf-8?B?a3R0YVNQWGNBeEpKRUtvZTRIbVRMY2kyaFEvam5UdjhzcUdMdkloMEFtOHY3?=
 =?utf-8?B?SlFoejMwdmdZODlUTFZYY2N6UVZRaTRXMkh6eS9vY0hQT25EOW0wR25yYzhD?=
 =?utf-8?B?TlhpVlp6Z0EvWDhRR3k3UVdpNFEvdFQrU01MTUNJSzhseG1GeEJRbDZMUjA3?=
 =?utf-8?B?Sk55VVlGcktnVUhOQzR6WW9jSnl2aTR0T3M5dVUzODYwUzhFUWlOS0sxQ2M5?=
 =?utf-8?B?SUVXTk5HbW9UczFYdEVOUms4Zkd1S0JXZjIwLzN2TGluQ2NHMkJRdmVEUmZ5?=
 =?utf-8?B?K2swK2xtUm50bGNMY0tSM1Z1c3FzUXIraEdhZzJ2MzZMczREV2Y4SkQveitE?=
 =?utf-8?B?bEx0QjFtM25TY3d5QVRvdVV5ZHJoVFBueDdFZE03NUtDMXNlVWtGVnU5TGVY?=
 =?utf-8?B?Vk5yZXJZTlJCRjVpWTZhbDgzaUlhK2w2V3JPZkw3WW8rVHpiQlRmTFpId1BY?=
 =?utf-8?B?M3oyTmx1TkVFMWFDOTFNdFJ2SWpYWExpUytjTmxHczAwNkNMaXZrcTFrWmdK?=
 =?utf-8?B?czZUdGJqdm9Tc3ZIWXhTQVVVOElMVG9Sb2VoR052RElyck16UlhPVmsyZDkx?=
 =?utf-8?B?N3JyTDlYVVBBZ0V6NGJkeFY0eGxua3JEcmh4NlZxd3F6Z1Fzb3hidU9CemI0?=
 =?utf-8?B?bTNESnBxdWRmSndIeHkxMjZ3allpUUZSTVIwOTFlYkFFRnJ5dyszVVk4YXVP?=
 =?utf-8?B?bXBOcGowajJWSUNWbUpZTUc2NmVvZVo3aEEvR3F0WGI5RXEyUmV3UHVxMVFP?=
 =?utf-8?B?SjhvWk1MTjR3NGdYaEgwdkR0MWlDSGZuQmllYlBnRk04bndFWk5JRmlZbGRh?=
 =?utf-8?B?MFp6bkRQWG8yT0VMckQ1TlE4L3hqdkR6RWpBS1VwMnV0cUxydkhiZ1R1bGIx?=
 =?utf-8?B?OFUvcTdqaVpUQkNpcFdCckFWejhFQ3o0R0h4ekNUTGNYL2JGMlJLL2RUK3BU?=
 =?utf-8?B?VkpEUE5vVmx4Y2llWE5vTVFXVS8zRUVqMFVUL1NETFN3a0h5OUpnQjFNc1RZ?=
 =?utf-8?B?ZFhpQVNCMDVrVEoyek9yU0VsNEU3SjZSWVVFdkk0V1puSkZEL0Jsbjg1T0Vw?=
 =?utf-8?B?VjIrQ1R1d240V09QdGNqSkduTWdMOVByMWFZVlgwdzBUK3hVTjhoM1A2cHJY?=
 =?utf-8?B?MG1GR1ZQWE5kdVd4T1lWUDlLQS95UW9lN2NyZ0YzU0JBZ1gxdEFxWExVQ1Nm?=
 =?utf-8?B?WjdlVmFBUEhBMGM3T25JS29ucC9BNDBacVhIV004MnN3T1lMMzV2RDBmRWZK?=
 =?utf-8?B?MVlaSEUrcnpKdGF0QnJMeVFNYUtzZVZWUUp1dHR5TzR6WVV5RHE0blhYVFg3?=
 =?utf-8?B?SUNvY2FxUFpOUWt4OCtkK01SNFZXd01BYlBIMkk2eVhtamNxTXEvcmk3UEx3?=
 =?utf-8?B?eXZNTG5KV1M5ME5BUHYwZmlFeDVWcndBY2ZSQjUzSTFOaFVvemI3eVUrZkhy?=
 =?utf-8?B?M1htWFBCVm16YWdZb2NTeVZVUE5KcnIzSG9OU1dFQytacG04ZUdxd1BRcVd5?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72CC2EA4E090F64D83195A2A076A4F2D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8067c9-274d-4694-c1d2-08da64c67c7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 11:54:48.0599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B19KMhg8T9ySsQv75iRlQxcYl7vBPRIVl4eMPXqeaNeAQgFLtELR1ccAotgleQRgaZyKG8TMQbkydiDLLhoBUg==
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

T24gV2VkLCBKdWwgMTMsIDIwMjIgYXQgMTI6NTE6MzBQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi83LzEyIDExOjI4LCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gRnJv
bTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiANCj4gPiBX
aGVuIGhhbmRsaW5nIG1lbW9yeSBlcnJvciBvbiBhIGh1Z2V0bGIgcGFnZSwgdGhlIGVycm9yIGhh
bmRsZXIgdHJpZXMgdG8NCj4gPiBkaXNzb2x2ZSBhbmQgdHVybiBpdCBpbnRvIDRrQiBwYWdlcy4g
IElmIGl0J3Mgc3VjY2Vzc2Z1bGx5IGRpc3NvbHZlZCwNCj4gPiBQYWdlSFdQb2lzb24gZmxhZyBp
cyBtb3ZlZCB0byB0aGUgcmF3IGVycm9yIHBhZ2UsIHNvIHRoYXQncyBhbGwgcmlnaHQuDQo+ID4g
SG93ZXZlciwgZGlzc29sdmUgc29tZXRpbWVzIGZhaWxzLCB0aGVuIHRoZSBlcnJvciBwYWdlIGlz
IGxlZnQgYXMNCj4gPiBod3BvaXNvbmVkIGh1Z2VwYWdlLiBJdCdzIHVzZWZ1bCBpZiB3ZSBjYW4g
cmV0cnkgdG8gZGlzc29sdmUgaXQgdG8gc2F2ZQ0KPiA+IGhlYWx0aHkgcGFnZXMsIGJ1dCB0aGF0
J3Mgbm90IHBvc3NpYmxlIG5vdyBiZWNhdXNlIHRoZSBpbmZvcm1hdGlvbiBhYm91dA0KPiA+IHdo
ZXJlIHRoZSByYXcgZXJyb3IgcGFnZXMgaXMgbG9zdC4NCj4gPiANCj4gPiBVc2UgdGhlIHByaXZh
dGUgZmllbGQgb2YgYSBmZXcgdGFpbCBwYWdlcyB0byBrZWVwIHRoYXQgaW5mb3JtYXRpb24uICBU
aGUNCj4gPiBjb2RlIHBhdGggb2Ygc2hyaW5raW5nIGh1Z2VwYWdlIHBvb2wgdXNlcyB0aGlzIGlu
Zm8gdG8gdHJ5IGRlbGF5ZWQgZGlzc29sdmUuDQo+ID4gSW4gb3JkZXIgdG8gcmVtZW1iZXIgbXVs
dGlwbGUgZXJyb3JzIGluIGEgaHVnZXBhZ2UsIGEgc2luZ2x5LWxpbmtlZCBsaXN0DQo+ID4gb3Jp
Z2luYXRlZCBmcm9tIFNVQlBBR0VfSU5ERVhfSFdQT0lTT04tdGggdGFpbCBwYWdlIGlzIGNvbnN0
cnVjdGVkLiAgT25seQ0KPiA+IHNpbXBsZSBvcGVyYXRpb25zIChhZGRpbmcgYW4gZW50cnkgb3Ig
Y2xlYXJpbmcgYWxsKSBhcmUgcmVxdWlyZWQgYW5kIHRoZQ0KPiA+IGxpc3QgaXMgYXNzdW1lZCBu
b3QgdG8gYmUgdmVyeSBsb25nLCBzbyB0aGlzIHNpbXBsZSBkYXRhIHN0cnVjdHVyZSBzaG91bGQN
Cj4gPiBiZSBlbm91Z2guDQo+ID4gDQo+ID4gSWYgd2UgZmFpbGVkIHRvIHNhdmUgcmF3IGVycm9y
IGluZm8sIHRoZSBod3BvaXNvbiBodWdlcGFnZSBoYXMgZXJyb3JzIG9uDQo+ID4gdW5rbm93biBz
dWJwYWdlLCB0aGVuIHRoaXMgbmV3IHNhdmluZyBtZWNoYW5pc20gZG9lcyBub3Qgd29yayBhbnkg
bW9yZSwNCj4gPiBzbyBkaXNhYmxlIHNhdmluZyBuZXcgcmF3IGVycm9yIGluZm8gYW5kIGZyZWVp
bmcgaHdwb2lzb24gaHVnZXBhZ2VzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE5hb3lhIEhv
cmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQo+ID4gUmVwb3J0ZWQtYnk6IGtlcm5l
bCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiANCj4gVGhpcyBwYXRjaCBsb29rcyBnb29k
IHRvIG1lIHdpdGggc29tZSBuaXRzIGJlbG93Lg0KPiANCj4gPiAtLS0NCj4gLi4uDQo+ID4gK3N0
YXRpYyBpbnQgaHVnZXRsYl9zZXRfcGFnZV9od3BvaXNvbihzdHJ1Y3QgcGFnZSAqaHBhZ2UsIHN0
cnVjdCBwYWdlICpwYWdlKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgbGxpc3RfaGVhZCAqaGVhZDsN
Cj4gPiArCXN0cnVjdCByYXdfaHdwX3BhZ2UgKnJhd19od3A7DQo+ID4gKwlzdHJ1Y3QgbGxpc3Rf
bm9kZSAqdCwgKnRub2RlOw0KPiA+ICsJaW50IHJldCA9IFRlc3RTZXRQYWdlSFdQb2lzb24oaHBh
Z2UpID8gLUVIV1BPSVNPTiA6IDA7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAqIE9uY2UgdGhl
IGh3cG9pc29uIGh1Z2VwYWdlIGhhcyBsb3N0IHJlbGlhYmxlIHJhdyBlcnJvciBpbmZvLA0KPiA+
ICsJICogdGhlcmUgaXMgbGl0dGxlIG1lYW5pbmcgdG8ga2VlcCBhZGRpdGlvbmFsIGVycm9yIGlu
Zm8gcHJlY2lzZWx5LA0KPiA+ICsJICogc28gc2tpcCB0byBhZGQgYWRkaXRpb25hbCByYXcgZXJy
b3IgaW5mby4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKEhQYWdlUmF3SHdwVW5yZWxpYWJsZShocGFn
ZSkpDQo+ID4gKwkJcmV0dXJuIC1FSFdQT0lTT047DQo+ID4gKwloZWFkID0gcmF3X2h3cF9saXN0
X2hlYWQoaHBhZ2UpOw0KPiA+ICsJbGxpc3RfZm9yX2VhY2hfc2FmZSh0bm9kZSwgdCwgaGVhZC0+
Zmlyc3QpIHsNCj4gPiArCQlzdHJ1Y3QgcmF3X2h3cF9wYWdlICpwID0gY29udGFpbmVyX29mKHRu
b2RlLCBzdHJ1Y3QgcmF3X2h3cF9wYWdlLCBub2RlKTsNCj4gPiArDQo+ID4gKwkJaWYgKHAtPnBh
Z2UgPT0gcGFnZSkNCj4gPiArCQkJcmV0dXJuIC1FSFdQT0lTT047DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJcmF3X2h3cCA9IGttYWxsb2Moc2l6ZW9mKHN0cnVjdCByYXdfaHdwX3BhZ2UpLCBHRlBf
QVRPTUlDKTsNCj4gPiArCWlmIChyYXdfaHdwKSB7DQo+ID4gKwkJcmF3X2h3cC0+cGFnZSA9IHBh
Z2U7DQo+ID4gKwkJbGxpc3RfYWRkKCZyYXdfaHdwLT5ub2RlLCBoZWFkKTsNCj4gPiArCQkvKiB0
aGUgZmlyc3QgZXJyb3IgZXZlbnQgd2lsbCBiZSBjb3VudGVkIGluIGFjdGlvbl9yZXN1bHQoKS4g
Ki8NCj4gPiArCQlpZiAocmV0KQ0KPiA+ICsJCQludW1fcG9pc29uZWRfcGFnZXNfaW5jKCk7DQo+
ID4gKwl9IGVsc2Ugew0KPiA+ICsJCS8qDQo+ID4gKwkJICogRmFpbGVkIHRvIHNhdmUgcmF3IGVy
cm9yIGluZm8uICBXZSBubyBsb25nZXIgdHJhY2UgYWxsDQo+ID4gKwkJICogaHdwb2lzb25lZCBz
dWJwYWdlcywgYW5kIHdlIG5lZWQgcmVmdXNlIHRvIGZyZWUvZGlzc29sdmUNCj4gPiArCQkgKiB0
aGlzIGh3cG9pc29uZWQgaHVnZXBhZ2UuDQo+ID4gKwkJICovDQo+ID4gKwkJU2V0SFBhZ2VSYXdI
d3BVbnJlbGlhYmxlKGhwYWdlKTsNCj4gDQo+IElNSE8sIHdoZW4gSFBhZ2VSYXdId3BVbnJlbGlh
YmxlIGlzIHNldCwgd2UgY2FuIHNpbXBseSBmcmVlIHRoZSByYXdfaHdwX2xpc3QgaGVyZQ0KPiB0
byBzYXZlIHNvbWUgbWVtb3J5IGFzIHRoZXkncmUgbm90IHVzZWQgYW55bW9yZS4NCg0KWWVzLCB0
aGF0J3MgcG9zc2libGUuIExldCdzIGRvIHRoaXMuDQoNCj4gDQo+ID4gKwl9DQo+ID4gKwlyZXR1
cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICt2b2lkIGh1Z2V0bGJfY2xlYXJfcGFnZV9od3Bv
aXNvbihzdHJ1Y3QgcGFnZSAqaHBhZ2UpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBsbGlzdF9oZWFk
ICpoZWFkOw0KPiA+ICsJc3RydWN0IGxsaXN0X25vZGUgKnQsICp0bm9kZTsNCj4gPiArDQo+ID4g
KwlpZiAoIUhQYWdlUmF3SHdwVW5yZWxpYWJsZShocGFnZSkpDQo+ID4gKwkJQ2xlYXJQYWdlSFdQ
b2lzb24oaHBhZ2UpOw0KPiA+ICsJaGVhZCA9IHJhd19od3BfbGlzdF9oZWFkKGhwYWdlKTsNCj4g
PiArCWxsaXN0X2Zvcl9lYWNoX3NhZmUodG5vZGUsIHQsIGhlYWQtPmZpcnN0KSB7DQo+ID4gKwkJ
c3RydWN0IHJhd19od3BfcGFnZSAqcCA9IGNvbnRhaW5lcl9vZih0bm9kZSwgc3RydWN0IHJhd19o
d3BfcGFnZSwgbm9kZSk7DQo+ID4gKw0KPiA+ICsJCVNldFBhZ2VIV1BvaXNvbihwLT5wYWdlKTsN
Cj4gPiArCQlrZnJlZShwKTsNCj4gPiArCX0NCj4gPiArCWxsaXN0X2RlbF9hbGwoaGVhZCk7DQo+
ID4gK30NCj4gPiArDQo+ID4gIC8qDQo+ID4gICAqIENhbGxlZCBmcm9tIGh1Z2V0bGIgY29kZSB3
aXRoIGh1Z2V0bGJfbG9jayBoZWxkLg0KPiA+ICAgKg0KPiA+IEBAIC0xNjk4LDcgKzE3NzEsNyBA
QCBpbnQgX19nZXRfaHVnZV9wYWdlX2Zvcl9od3BvaXNvbih1bnNpZ25lZCBsb25nIHBmbiwgaW50
IGZsYWdzKQ0KPiA+ICAJCWdvdG8gb3V0Ow0KPiA+ICAJfQ0KPiA+ICANCj4gPiAtCWlmIChUZXN0
U2V0UGFnZUhXUG9pc29uKGhlYWQpKSB7DQo+ID4gKwlpZiAoaHVnZXRsYl9zZXRfcGFnZV9od3Bv
aXNvbihoZWFkLCBwYWdlKSkgew0KPiA+ICAJCXJldCA9IC1FSFdQT0lTT047DQo+ID4gIAkJZ290
byBvdXQ7DQo+ID4gIAl9DQo+ID4gQEAgLTE3MTAsNyArMTc4Myw2IEBAIGludCBfX2dldF9odWdl
X3BhZ2VfZm9yX2h3cG9pc29uKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3MpDQo+ID4gIAly
ZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gIA0KPiA+IC0jaWZkZWYgQ09ORklHX0hVR0VUTEJfUEFH
RQ0KPiA+ICAvKg0KPiA+ICAgKiBUYWtpbmcgcmVmY291bnQgb2YgaHVnZXRsYiBwYWdlcyBuZWVk
cyBleHRyYSBjYXJlIGFib3V0IHJhY2UgY29uZGl0aW9ucw0KPiA+ICAgKiB3aXRoIGJhc2ljIG9w
ZXJhdGlvbnMgbGlrZSBodWdlcGFnZSBhbGxvY2F0aW9uL2ZyZWUvZGVtb3Rpb24uDQo+ID4gQEAg
LTE3NTEsNyArMTgyMyw3IEBAIHN0YXRpYyBpbnQgdHJ5X21lbW9yeV9mYWlsdXJlX2h1Z2V0bGIo
dW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncywgaW50ICpodWdldGxiDQo+ID4gIAlsb2NrX3Bh
Z2UoaGVhZCk7DQo+ID4gIA0KPiA+ICAJaWYgKGh3cG9pc29uX2ZpbHRlcihwKSkgew0KPiA+IC0J
CUNsZWFyUGFnZUhXUG9pc29uKGhlYWQpOw0KPiA+ICsJCWh1Z2V0bGJfY2xlYXJfcGFnZV9od3Bv
aXNvbihoZWFkKTsNCj4gDQo+IElmIHRoZSBjb2RlIHJlYWNoIGhlcmUsIHRoZSBodWdldGxiIHBh
Z2Ugc2hvdWxkIGJlIHBvaXNvbmVkIGZpcnN0IHRpbWUgb3IgaXQgd2lsbCByZXR1cm4NCj4gaW4g
YWJvdmUgInJlcyA9PSAtRUhXUE9JU09OIiBjYXNlLiBTbyBDbGVhclBhZ2VIV1BvaXNvbiBzaG91
bGQgYmUgZmluZSBoZXJlLiBCdXQgdGhpcyBjaGFuZ2UNCj4gd2lsbCBkbyB0aGUgc2FtZSB0aGlu
ZyB3aGlsZSBtYWtpbmcgdGhlIGNvZGUgbW9yZSBjb25zaXN0ZW50LiBTbyBpdCBzaG91bGQgYmUg
ZmluZS4gOikNCg0KUmlnaHQsIHRoaXMgY2hhbmdlIGlzIGZvciBjb25zaXN0ZW5jeS4NCg0KPiAN
Cj4gPiAgCQlyZXMgPSAtRU9QTk9UU1VQUDsNCj4gPiAgCQlnb3RvIG91dDsNCj4gPiAgCX0NCj4g
PiANCj4gDQo+IEFueXdheSwgZm9yIHdoYXQgaXQgd29ydGgsDQo+IA0KPiBSZXZpZXdlZC1ieTog
TWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+DQo+IA0KPiBUaGFua3MhDQoNClRoYW5r
IHlvdS4NCi0gTmFveWEgSG9yaWd1Y2hp
