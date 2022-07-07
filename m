Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1774569791
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiGGBfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiGGBfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:35:06 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2083.outbound.protection.outlook.com [40.107.114.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDE02ED5F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 18:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjJYUOrdynTVIiVeNIg+bXDbdSGUn0FhF//bYIkIJfIWmRZusp9LXUZ9nU1lYgx2lk4xxbZJ7KWgNDoZJnGrW87Wg/Sh/5exMr5CFY0HRnUutKPclQjhWctH/cqPJTKMOOyj8XI4C2c7/CbJB8PCJUInjUJSERnk9gLEVlVUMRVvQPd05L7d2K8AZGV0yjHrDXxxeXHf9QMSnxWOwzxg1hFRHq2gB8n4k2l4v41/88sqoBAzc1dn3MjXHQALHg7RiAf308++rxR/blKEINGlSrqYjfx2S4zKX9KL7/w4+H+KDC/eBT+8aH6irSdlWBK4NpPSh6JNBEcs9EcbZIN1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dig0OLpFZGybwgg40ar0bZbvF7N7/m6k2DOaLjWiqvw=;
 b=PkZ2p8qxVJxfbrvGtIClLuWsDPVD5kcaIhqYM4EoYR7Em+eRPsUAYwmSIN0bWQ3x+vKWr5sxDr0uCK4KKcfKrCYNyA7ICRhM832INPAp631Ji1nXA/LiO14PTMPCK/bspOyyZ6xqXj0Ji7Qtw61fE/y2t93/9VDYnkgHDvtX/yD2MqbTHY2ooCf9MSy0iEDRQ/kJSFKe3elCMCfIfNw4GAfrzNveNo7lIROAV9L6ZT60vroYfQ4xMkf77Ij9zH+Lw4RwiqD6GC77YvCPffqOHG50I7RHlZMcJfeJEZkYXL4QmVG9+dOnIEK0P1bicEvFvd16cx44l1YiQs12JHOs8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dig0OLpFZGybwgg40ar0bZbvF7N7/m6k2DOaLjWiqvw=;
 b=Ut0K7npZoS45r/W0F1Kt+qrhUFvYHWBiirFoO0nlUygFVD84VGBWKEoiRMulDlLyFnWil+RV61upSulnw12rmrC9bHv22TL0vOvi47pgbmigbzxernaX/rDSpGqwJTgNlMKDeRjZ30bUE8L7LAPLOg7HxxAzeDU1yvcVGoDIRDQ=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSZPR01MB9486.jpnprd01.prod.outlook.com (2603:1096:604:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 01:35:01 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%6]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 01:35:01 +0000
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
Subject: Re: [mm-unstable PATCH v4 5/9] mm, hwpoison: make unpoison aware of
 raw error info in hwpoisoned hugepage
Thread-Topic: [mm-unstable PATCH v4 5/9] mm, hwpoison: make unpoison aware of
 raw error info in hwpoisoned hugepage
Thread-Index: AQHYkOR4nIqzf3Z5RkmHICXrERFsHa1x+EGAgAApgQA=
Date:   Thu, 7 Jul 2022 01:35:01 +0000
Message-ID: <20220707013500.GA2578896@hori.linux.bs1.fc.nec.co.jp>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
 <20220704013312.2415700-6-naoya.horiguchi@linux.dev>
 <9aba706c-b38f-f887-486e-b60c0025d9d8@huawei.com>
 <20220706230627.GB2560241@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20220706230627.GB2560241@hori.linux.bs1.fc.nec.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6be633e-be66-42b7-f5bb-08da5fb8e929
x-ms-traffictypediagnostic: OSZPR01MB9486:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGmktYI5sQG+gUVOtA6sw0Hm7+OERN5Fg8eILtKq6hKgKx2fUk3Rtt5WyF7RSDbtIg9ibbzA1MdF8pSMPxMMJ+kOLzN24+zs20DKA7eh8def96AjCFIaTkixe4D7zks5Ljdfs32Lyzy4/4816jVGZgoKlJ9+uTK5ae+X5yIhzFxH+4WOImkKWAilZTDeegVu8m0/XeMBiibprKLckk7u23E8WxxvJcHdUj2SF8T75M9TgY4Dx2vBuZ/LTkOnWBggeY8sz9i14Ksi4bIULCn5S46PMNz5WdbnKy/YCZqj5LPgJjpXHgc28+R5Wn8Lz1kr3HpJLg83Yo4wpw3SOJV5q2thwnTti7YSN3s3lat6+LgvgsZo+/+XDHlrqV/XBALd2t38w2ID5zny63nvIOXw4tMcwVFWPAuzfR+sc5Rf7QJjaqwZLRCvlr0x50G2HQcfOEzEfU1xe9EGMWy7omiiht6O/kDz5Np+ytc73n9u4CrWY99vkiTyDKBc4vjEAdQSbbZScAvfdIoz/g6k8xOL1dLDSHla13aNRTGi5y5npM5moObORnBlWaUnHgA5kMVdcEDs1dD/NZXYwqQ7aW7zxZn0UDN9Qcp8jXv6cZg0mosTPAMDm9vF/0qw0PGQ8MoKSJ8IXzQ0uUVo4QqWLhKAKX0ixurCI+NvPoryNFttOr5LpwGc103AUs9PePu9d9sA9aBUGn8hRfYS9+5Z1rfYqDuxjflsT47zdvSSE/JYpKLs9d8goRxADFqE7+Cgb34nmUI46r6hm2YIGEQvYI0wJrmE3WgnXl94+MGyCi2nIgiaPjuRCsoDpq9YD9lCVSOu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(66946007)(76116006)(478600001)(4326008)(66446008)(41300700001)(6486002)(71200400001)(86362001)(85182001)(33656002)(54906003)(316002)(66476007)(64756008)(8676002)(66556008)(82960400001)(122000001)(38070700005)(5660300002)(53546011)(8936002)(2906002)(6506007)(6512007)(26005)(1076003)(9686003)(186003)(6916009)(55236004)(38100700002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1ZXaloybGt5Njl3RmFqOHVhT1FTZ3pWTncxUTV6cnNLaDBRaHFqOWVMd0Z5?=
 =?utf-8?B?U0ovQUNZRlNRTnY5dStHRWE4dHdOK09ldUhhaVk4em1qN1hISGYxdEY4NnFE?=
 =?utf-8?B?Ri9HUUh3L21LcWFHckVQNE9Vc1hBTkptVVF3Z0phaDRDWTFGZHRBNDcxMGtw?=
 =?utf-8?B?eFhReFUyelNRWXB0QlBrNmQ5Z2dRajdROUp6djM0SVBUUTY2bm0xN1dqNkk3?=
 =?utf-8?B?UnRjcENXMy90NU1TN1dHc05rcnFKU0ZtL3BmemtGZlVQbWJvVGl1R1ZOdUVs?=
 =?utf-8?B?S0RyNTBWU0J0M3BzTUdoQ2Z5ZE9xMFhkMG9Zem5aeCtQdE9tVjZlNm1YVFhj?=
 =?utf-8?B?TzJNM2RhbXphV2dENzVXeDBKdHB6cG5pTnVraVc1NDFIbkdQK3NkTlI1ZkFq?=
 =?utf-8?B?ait5V3VPekp3c1RIbXRabXIwQ3dJMFJiaTlXV093aFpNeWo1SThMZnFqT0d2?=
 =?utf-8?B?N2NSYjdaQ2dxVnlUTGNlRFZHM3pCTjdoZkVGN3pOc3A1MjE1SXNJcGQxZjUy?=
 =?utf-8?B?OWN4Z0ZORzFac3NUQnlhaTZhaHpMNlJhbktaSmRXdVBBVGVhWmV6VGdxMTBM?=
 =?utf-8?B?T0lxdWVMcEdPM25DalhyS3R4dzZMcm4zNjM3ZlhtMy8xSTZROFI0bEhnOGtw?=
 =?utf-8?B?bGhPVnIxaEV4aEVqV0prNDdWb2NvSUtTc1FVUUJ3bWhva0c1U2hSd21nQmlS?=
 =?utf-8?B?bW5yWXVHclpGZm81UEZhUVBzRy9pQzkxSWlzNGhRcWtjSitlSDRpcW9zOVZF?=
 =?utf-8?B?bmprNjdtb1FaVUNXNkNRTCt6Y09ySUxMSlhBeTdjT2RhS09hdHBSVG80aDZV?=
 =?utf-8?B?VWREZTNXaFgrMGM4Q1JkMThnTlptK0pBb0dtNUM2b0tnYUlEQ0VLa0xsb0JJ?=
 =?utf-8?B?cC9LQnlCVmhmY3dJUVBra1FTa2xTSHExUllTNVNBSTN1bURqTVpWZ2dSLzRU?=
 =?utf-8?B?SStUY09QR1ltMm1UZk51dEtOWkdkWTJQNi9uUVFXTWZkQm0veVluYnJBMVM4?=
 =?utf-8?B?K0xPanFrWGFJcVNDOGVuUWhvWUZNMVFadUhObHdKbXF2K09iaElLN3lsa2Jq?=
 =?utf-8?B?RndidW1KN2tPb0F3c2hvRCtTYWlUeDhMYzdad3lHM2hzam16cG5yc3RtQlZr?=
 =?utf-8?B?MFQzSE9id24rOG1KMzNCM0Vrb0c3bzhjdnFWWU1GRy9OTE5GeGRYQzhEVjBH?=
 =?utf-8?B?YWRad0s2alg4Q2xPelY0aittMFV1UFJsY0k5NTVXZUNNcHJNVlVCakdIVkxD?=
 =?utf-8?B?MnBGRS93a09nZ2E4UnhiRVU3bUJMTUN0TmQ0VVBkWlNQU29zTVlxSnNtYk1S?=
 =?utf-8?B?Z2RpSW56emYxOTNzTEpHSk9TUEFHQ0lDbjdYQm5KQ0dUYTIvTnZRajNQamo3?=
 =?utf-8?B?ZU9LaDc2MUVCRE5VWXg4KytvdlE5eU5wZHowZy9HMTVOTjZvUVBmazR1dkJq?=
 =?utf-8?B?Q2ZDYUNiYVhzMzJ0Yk9aSHYxT0t0dVR0NUNFZFdnNEVDdHVnQk9JcW1MVUU2?=
 =?utf-8?B?Z1FoQ0xKUUwwdDFsY3gwQWU0bzZUaUpLT2IvMGVpNERjMnF0ZUlOQ1pqVXFK?=
 =?utf-8?B?MlphY3Nyc2ZvRUtDaFNXYndMeFlFM0tmNkw3WU9YRUhyKzRHYUdHWlAzblMr?=
 =?utf-8?B?Mnorb0xDRnJSLzA1SHZ1NVRCd1pUUFZOWGNzYzFUelhqZVlXY3d2QW02MGVO?=
 =?utf-8?B?TVJCK09EN0pkUkZlNXNwS0xFL1ZPT2ZteTREbkhvQk84dDdIZTdTTXluWW53?=
 =?utf-8?B?TVVnZ1h4WGpSUVd0cU5Od3AzK1VIUlowQ2pxdHlJSXVRTGtBUVcwS2I2c3E0?=
 =?utf-8?B?R05lb3JDbmc2SHNNRTV4Q1hkbXpCUmk3L3N6UExzVndVSUJ6QkIzMEMwS004?=
 =?utf-8?B?UlF0bXZXY3BOeHVBaFRCVktmbnhiRUdBcmdxMzFNVUFZVXY3THJSa0pKNlVE?=
 =?utf-8?B?QnNZY2Zja1cyQjVYenlOOXJQQ0oyN1BGNFBaSHVVM3dDakluc3lzNXVGd1Qz?=
 =?utf-8?B?VXFkZjlLOVRSaGsyZ1pHT3JEbVdLVEN6VktmaGZGTFNNd2tNSUx1c1dibURE?=
 =?utf-8?B?RXljR0ZhaVA1eTNaUU1rWEczMHhHRWlsV2lkcWV2RVluZm9RdjNXRkNxaFA2?=
 =?utf-8?B?bjRKeG4zVkt2MW13YTFKalFlelV0S3liSjJ3STNwaG4rem5XR1lWWFBLaWRj?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87E0E28CD0003D408B17270E4EC60A30@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6be633e-be66-42b7-f5bb-08da5fb8e929
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 01:35:01.6340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GBwiswoJZ+JUy0ktozFiS3/khxc3eQlyfHwbenCvsVWL7Dl7wIBo1kS6idolXCMrVwiB3HD8eFm8MA8NejhcZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9486
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdWwgMDYsIDIwMjIgYXQgMTE6MDY6MjhQTSArMDAwMCwgSE9SSUdVQ0hJIE5BT1lB
KOWggOWPoyDnm7TkuZ8pIHdyb3RlOg0KPiBPbiBXZWQsIEp1bCAwNiwgMjAyMiBhdCAxMDo1ODo1
M0FNICswODAwLCBNaWFvaGUgTGluIHdyb3RlOg0KPiA+IE9uIDIwMjIvNy80IDk6MzMsIE5hb3lh
IEhvcmlndWNoaSB3cm90ZToNCj4gPiA+IEZyb206IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9y
aWd1Y2hpQG5lYy5jb20+DQo+ID4gPiANCj4gPiA+IFJhdyBlcnJvciBpbmZvIGxpc3QgbmVlZHMg
dG8gYmUgcmVtb3ZlZCB3aGVuIGh3cG9pc29uZWQgaHVnZXRsYiBpcw0KPiA+ID4gdW5wb2lzb25l
ZC4gIEFuZCB1bnBvaXNvbiBoYW5kbGVyIG5lZWRzIHRvIGtub3cgaG93IG1hbnkgZXJyb3JzIHRo
ZXJlDQo+ID4gPiBhcmUgaW4gdGhlIHRhcmdldCBodWdlcGFnZS4gU28gYWRkIHRoZW0uDQo+ID4g
PiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hp
QG5lYy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IEBAIC0yMjg3LDYgKzIzMDEsNyBAQCBpbnQgdW5w
b2lzb25fbWVtb3J5KHVuc2lnbmVkIGxvbmcgcGZuKQ0KPiA+IA0KPiA+IElzIGl0IHNhZmUgdG8g
dW5wb2lzb24gaHVnZXBhZ2Ugd2hlbiBIUGFnZVJhd0h3cFVucmVsaWFibGU/IEknbSBhZnJhaWQg
YmVjYXVzZQ0KPiA+IHNvbWUgcmF3IGVycm9yIGluZm8gaXMgbWlzc2luZy4uDQo+IA0KPiBBaCwg
cmlnaHQuIFdlIG5lZWQgcHJldmVudCBpdC4gIEknbGwgZml4IGl0IGJ5IGluc2VydGluZyB0aGUg
Y2hlY2suDQo+IA0KPiAgc3RhdGljIGlubGluZSBsb25nIGZyZWVfcmF3X2h3cF9wYWdlcyhzdHJ1
Y3QgcGFnZSAqaHBhZ2UsIGJvb2wgbW92ZV9mbGFnKQ0KPiAgew0KPiAgICAgICAgICBzdHJ1Y3Qg
bGxpc3RfaGVhZCAqaGVhZDsNCj4gICAgICAgICAgc3RydWN0IGxsaXN0X25vZGUgKnQsICp0bm9k
ZTsNCj4gICAgICAgICAgbG9uZyBjb3VudCA9IDA7DQo+ICANCj4gKyAgICAgICAgaWYgKCFIUGFn
ZVJhd0h3cFVucmVsaWFibGUoaHBhZ2UpKQ0KPiArICAgICAgICAgICAgICAgIHJldHVybiAwOw0K
DQpObywgSSBtZWFudCAiaWYgKEhQYWdlUmF3SHdwVW5yZWxpYWJsZShocGFnZSkpIiwgc29ycnkg
Zm9yIHRoZSBub2lzZSA6KA0KDQotIE5hb3lhIEhvcmlndWNoaQ==
