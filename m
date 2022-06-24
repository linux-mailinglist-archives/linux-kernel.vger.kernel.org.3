Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E33F559590
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiFXIks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiFXIkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:40:46 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2042.outbound.protection.outlook.com [40.107.114.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD186B8C4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ks4bI93N+9lIR4fa9SuviXY4/4jGlZItEv4Np20m8uo111CVuIGqaQcWPAVYVV3ijL6v2W0T9Rn/c6c6oSkma3ng8zlOQsA6YxVIKIhJJdPVg9npJd3EuaU4b/B+XqTdYobEu0SFOO7e4d21NXWmBLe6A0fRsU7R4x4WQdnwJZH468M5JhapdNSoN3BajlpkT2plc0s6OhjnAyl6S4ggjMuj++VbLSN22vMg0wxj3R7QyzTZbWDx+wsDL7jI3e7oBBcfxcaOhCmlKlCA8IwAcH5+MwEErTsupMs6MJX56gghsGPxMgawSvV2uSucU6aA9euO1p/CmpOEwQiWQIAQ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XprwBEaVxwvQaXpyWVlMTIZJY/J6iEZibWn0VC+C6rM=;
 b=WPCdJ5/paU/JydODSRtDy7uLWjy0J8kRlxu3SMYvMf2HSuuIm8Lq6VBl3sq3T0yIsNsqxwHN0h7BoUjKFOZqlKMrR9Ei/s3z3Mit6cA7RY4jCnEHgoYiFdIpWX/2FhSea5mHu0Tffa77q+MkKZalGBPARP54VgnACFWPJtl+DP602itLk5OqsGKWcZz247wrKT1zuXoLRCr/K0FOP4ltwSLzf+sNAYWzwn3LlzdbvH1hhk2cFgaWfaJe3rnGXOnFKH5To5DtsJ8TcrloJlRahtQZTk9WAnLAbr1dnrFCBpxhMQpvVl3EFLsFJV2fmTEUHpu0j/zAwlFeNOFVLUJ+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XprwBEaVxwvQaXpyWVlMTIZJY/J6iEZibWn0VC+C6rM=;
 b=I1GazTTbQyPDOlsR1BkeDylo3mj/8Dg7JkLGnkX4LHXYEWQQX6Px/O7nlDpcRPT/a9+TUHdUq19Pf8AQDwVShcIT0GcyBbN/+A3bCtlbFzBhyDYkw/dTdbWQcOSYs0UBGVmcN6aqh97H3GTfF5cpD8z7qjwc4elnsqkzRiDE+EM=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYAPR01MB3007.jpnprd01.prod.outlook.com (2603:1096:404:7f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 08:40:43 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%6]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 08:40:43 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/9] mm/hugetlb: make pud_huge() and huge_pud() aware
 of non-present pud entry
Thread-Topic: [PATCH v2 3/9] mm/hugetlb: make pud_huge() and huge_pud() aware
 of non-present pud entry
Thread-Index: AQHYh1xVdMLvq+UuwkSi6Bx3h6yk0q1ePXQA
Date:   Fri, 24 Jun 2022 08:40:43 +0000
Message-ID: <20220624084042.GB2070418@hori.linux.bs1.fc.nec.co.jp>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-4-naoya.horiguchi@linux.dev>
In-Reply-To: <20220623235153.2623702-4-naoya.horiguchi@linux.dev>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61b64845-16f0-4dc0-15a1-08da55bd39bf
x-ms-traffictypediagnostic: TYAPR01MB3007:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N3tSwhxxIV5HueeoWPTWiE/Ex6Z7OYMURVQdC021KPWHpn5VaLkg7lyJCyD+793WJPxB3d4qP74Jsj67hCacg0cPyMlmwV/iDsEHJkPB238QP/Dszafv4x2n8HQ7VlUd9unvx0YHqKycDfSed4cz6YyVckLt7525eCZdhGhsYMvBh2Ak5KMV30cQcfM1Xj8VTXDrlueTSpcq8TyHjqyIreW7l5xpTxjOT71qGxKs2s6Q1hHdkeRuo4IUklVsf3XUjEiDJYOhABQL1XXhe/5/kEZyWtGj/ZZKF5hamSUM48vLyl2oNxUqbgpm4x98hogZVmcWVXKjtpMRfPxQ0t7zbXM50rxdfZOCtZhg04RaoavMtDxlYf4ON9CZDv+nC1OzzFe5+AecEBuzUTDHC+cUCotkudIk/U76UlGySKgjYVeaBVexgPlLw7Ly8pJTLZ3COPMN20y48hSPq6Fgo9L0F8oexCBZvBw5HxWhbUzencVpBBKlszv1GuK7WrxJznUA7wjBhXc6BheALwLdxE2Reo8dw30uifzpErdGEufGDLXSEAAv2dMFGnitcF0D/Ma2CR6PHHH5e7pTYDU4VcdLiovsTDH8+UhgQlaZtWvIFowf3KtELVC6rT4+W3S5ISqwy3SS8n+kgzRQlf0O3EM1lJFvbVmN6/kjroE6+5Nzt/S2la+UJDlEvr6K2m8CuqGDjt/vNd4dl2nJdTLW7ZhbZQAeV6IeO3RJDzEbGz48Cs7FKOHrpICZ3SNKU29C3oc6Us5oTYnPYrZPdb18HoSMaP6c6wp41uiDcM24pBmbcHKnx6Qqfg9R+Rj1DRFtnvYI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(64756008)(316002)(4744005)(478600001)(8936002)(33656002)(38100700002)(71200400001)(83380400001)(54906003)(4326008)(6486002)(6916009)(8676002)(5660300002)(66946007)(85182001)(2906002)(66446008)(9686003)(26005)(122000001)(6512007)(82960400001)(6506007)(41300700001)(55236004)(76116006)(186003)(66476007)(86362001)(38070700005)(7416002)(66556008)(1076003)(14583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGhPYyszY0QwcVorTjJtanhMNmpYKzZEaUhYU3hFY01wem1DcTRwZmtaSzdz?=
 =?utf-8?B?bzdSaG1EQmg3VnVIdGppNTdiYXJyR0cwOHdlS0ducGxQYmpBeXN3Um1GMWlD?=
 =?utf-8?B?U2J1WVBrVjg3cW14eVl1MW5MaFozd2dFZno5TnBZMUp3Y2lmbFdoRm1namFG?=
 =?utf-8?B?QjlkYlRqQXNMUG5OMDJTRzdMWEZsZHpUbGJCQStScVBtcTNmNkpvT2U5VnY2?=
 =?utf-8?B?cSszTC9OMzdSYVovQnlOWHN3dy9ZeXlvNVhkN3R0VGphZUJaK1FzZUFTbmZL?=
 =?utf-8?B?ZnhaTjhkZHA5TFZKM084bmZ0Y0dqeVpDMEFhZmtjby9EZFVLRFdUeUFHRS9L?=
 =?utf-8?B?bXVPTXVQNlk1bUt5SHVGZVdnMytUWmY2L1VYUnh3ZXhKdmxEd0tnUUJyM21H?=
 =?utf-8?B?b2s0VFE4NmEvcXljMEJsUVNkRmNUb0N3eWFmZEltSUh6cEx5amx1clhpYXJi?=
 =?utf-8?B?ZnpZcVl6WmlWU052YWRTdkE2bTV5Vm9qdmNmc05MTkFTMG9weWlLTW1COG10?=
 =?utf-8?B?cnllODZnYklyOHpWaGFwaWU4cXdwL1NIaUxLdUhBejZ6aFlsUUVLVjVRZkpx?=
 =?utf-8?B?NllEbFR4L3U2RHM2bkNoZHNkWGh0T0NOSkd4RmRsZnBZeEcrTEJSYVh3c2VZ?=
 =?utf-8?B?Nnh4RlduRGh5M0tlUVJLbjU2dUZ0TWlMcHdoK3gzaGFISmNVOFFCbVRpVFBs?=
 =?utf-8?B?MkxVUDhRWXRlRFJhM1paUTFjSTBnb3Q2bDZzTjVXM245RG1ZWlMwbEpIQ2tH?=
 =?utf-8?B?c1dIdnBEcmx5QlB0UkphSHZIck9oVVRrSU9GMDhJQXIvMVlGNW1zbGxPMEFQ?=
 =?utf-8?B?SjZiQ21EclIrbzJ1V0piRU12VWsraXZCNTg0cFljd0J5dTk2Wm9SRno5YVFO?=
 =?utf-8?B?cUExVW5vblh5MldiY2V6NTQ1UTRGcmtZV3N5aVNnK2t5U2UwL2pSV3hxbWov?=
 =?utf-8?B?U3ZGTnhHa0lrL3YvMVJSZVJ3OVl6d0drS1JiR281Tm9zTVFzOEFwSGw5OVJM?=
 =?utf-8?B?bTVkeXluSUN5M0N0UmljcElFMXdhOEsxaVdoQ0R2QnVMMGdQTUwrTFFPMzdn?=
 =?utf-8?B?alFkc2lUSkR0cUJEa0lKTTJxRlhQeU9iTEgvTVd1aWFSMytTTHBKcmJsSFBW?=
 =?utf-8?B?R2E5VW9vamdOSlJqUlhFVGhETFgyU0NscjVtVWtuN2lkakFxeS8zZUVZcFNx?=
 =?utf-8?B?RG5CNEx6ZytOLzZ3cFpNcUNodEJ6ZTdxRUpSYkhUTmRJNWNxcXROajBhbUFk?=
 =?utf-8?B?cEdoRy80NGhCOU1ieThRWHJKbCtCejV3d21WMndmSGlyeDdYV1UwUU0xc3FI?=
 =?utf-8?B?L0Mrb0ZlLzVRcUxKNVMrdURWVGNYa2M3UVp5NzkwNHpJUGo2TjQzZ3Y5MEgy?=
 =?utf-8?B?bFFoOEZjK0xpTE9XNjZ4OVNhWlEzazc3Z3lJbE82ci9URjlOYnlrM1g4Z3NL?=
 =?utf-8?B?QjNwQlE0TldTbFVNcXJwR01sTjROWGptRVBYRDJDbE4wOU9VRm5UQUM5MjEw?=
 =?utf-8?B?YUlYQ3U4WEdXV1NWK0lNT29PbmViVmxPcXFhZ3dqZjgvMmR3ZDBFK0pPZEwv?=
 =?utf-8?B?WitxamZoRjF4SHVWSlBUR256bUUyRkxiWFh0cjVFUUpublZ2ckhtcmlOdmND?=
 =?utf-8?B?QUh5bzJ1MUZpbnVZdTVhR3NLWGp3bkgvM3UveXlMZHczWGJqMWF0eWlMdWtN?=
 =?utf-8?B?MVlueXZnQWhoT3BuUGN1eEVEdk1KMUFSUE9BVEVQb2ZnRFpSa0JNNE5Ha0hz?=
 =?utf-8?B?ZmVkM0I3enlDaHJrSndRQms5ZXYwelVhTE1uZkFCTW1aVGtNUlVBdTdWUDNi?=
 =?utf-8?B?NFNNSWFTckhBRmVhZzlaR0RUNVFvZ0Z3c2JralZLeEhHYzFhTUg2dTZLUFRK?=
 =?utf-8?B?R1VUang0MmIyQWtWaGUvYncxYWRlTWRqS2NkSzdXVHJrcU81a2xVUGw3QVdL?=
 =?utf-8?B?ZXg2MVRjRlhyZ0dLWlVGSXJRRExEdmxQSVBnMGNEcEdiQ3NHdXV6eXZmUXd4?=
 =?utf-8?B?K3EzeXVHZHpKVE5zZTVpc2xkdDhhaWplV2NGdG9SNllDUy9SbW9YTTdxZlFk?=
 =?utf-8?B?M0l5TUY1ZGFMSUpiUlRwSGxHb0w1dWZoNmFvbTN1S2FaZTBKTEpIaVdvV05P?=
 =?utf-8?B?SnpPMXhMYXNiUWJjWXNGZ0Q4ZDYwa3cxbW5kN3FXdS80N0xZTXRiTXZ6WXgx?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B3C0E26FD484E43BC01C9484E82DAA8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b64845-16f0-4dc0-15a1-08da55bd39bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 08:40:43.2038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fn7NTolkILIPEtkDX8O9IHmBOMhb6HZym0zBaMJdhpr62wWBOb9cE93zJECjOLNRUzdIxDyOEtbec9FWxrYaxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3007
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnksIEkgZm91bmQgdGhhdCAkU1VCSkVDVCBtZW50aW9ucyB3cm9uZyBmdW5jdGlvbiBuYW1l
IChJIG1lYW50DQpmb2xsb3dfaHVnZV9wdWQoKSwgbm90IGh1Z2VfcHVkKCkpLCB0aGlzIHdpbGwg
YmUgZml4ZWQgaW4gdGhlIGxhdGVyIHZlcnNpb24uDQoNCk9uIEZyaSwgSnVuIDI0LCAyMDIyIGF0
IDA4OjUxOjQ3QU0gKzA5MDAsIE5hb3lhIEhvcmlndWNoaSB3cm90ZToNCj4gRnJvbTogTmFveWEg
SG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gDQo+IGZvbGxvd19wdWRfbWFz
aygpIGRvZXMgbm90IHN1cHBvcnQgbm9uLXByZXNlbnQgcHVkIGVudHJ5IG5vdy4gIEFzIGxvbmcg
YXMNCj4gSSB0ZXN0ZWQgb24geDg2XzY0IHNlcnZlciwgZm9sbG93X3B1ZF9tYXNrKCkgc3RpbGwg
c2ltcGx5IHJldHVybnMNCj4gbm9fcGFnZV90YWJsZSgpIGZvciBub24tcHJlc2VudF9wdWRfZW50
cnkoKSBkdWUgdG8gcHVkX2JhZCgpLCBzbyBubyBzZXZlcmUNCj4gdXNlci12aXNpYmxlIGVmZmVj
dCBzaG91bGQgaGFwcGVuLiAgQnV0IGdlbmVyYWxseSB3ZSBzaG91bGQgY2FsbA0KPiBmb2xsb3df
aHVnZV9wdWQoKSBmb3Igbm9uLXByZXNlbnQgcHVkIGVudHJ5IGZvciAxR0IgaHVnZXRsYiBwYWdl
Lg0KPiANCj4gVXBkYXRlIHB1ZF9odWdlKCkgYW5kIGh1Z2VfcHVkKCkgdG8gaGFuZGxlIG5vbi1w
cmVzZW50IHB1ZCBlbnRyaWVzLiAgVGhlDQoNCmhlcmUgdGhlIHNhbWUgdHlwbywgdG9vLg0KDQot
IE5hb3lhIEhvcmlndWNoaQ0KDQo+IGNoYW5nZXMgYXJlIHNpbWlsYXIgdG8gcHJldmlvdXMgd29y
a3MgZm9yIHB1ZCBlbnRyaWVzIGNvbW1pdCBlNjZmMTdmZjcxNzcNCj4gKCJtbS9odWdldGxiOiB0
YWtlIHBhZ2UgdGFibGUgbG9jayBpbiBmb2xsb3dfaHVnZV9wbWQoKSIpIGFuZCBjb21taXQNCj4g
Y2JlZjg0NzhiZWU1ICgibW0vaHVnZXRsYjogcG1kX2h1Z2UoKSByZXR1cm5zIHRydWUgZm9yIG5v
bi1wcmVzZW50IGh1Z2VwYWdlIikuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBOYW95YSBIb3JpZ3Vj
aGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiAtLS0=
