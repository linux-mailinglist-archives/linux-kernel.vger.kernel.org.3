Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B69599462
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344608AbiHSFVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbiHSFV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:21:28 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2046.outbound.protection.outlook.com [40.107.113.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A003DFB41
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:21:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRVo2nfb7XAEsIYxzNW6gfUm569fslNFN/WtwHhUg6tjFdNt776eLCXoDHlKKXq2D/81laK0Nrd3hXfVG+IG6HEaxFovhtnQJ6SYQ3oWa6sE9iof4mepV4fcAclP57ZLk4FPviYKGXhHKC4tk0kxspQ8vDLDG9rcNlZYp4+OfPe9TQjHs3AZrCtcVPIn+2uv+szw2Hmo+oD8p/PsU5q+avsxmgxqArR/gsYu8p6+DPcZ6fytk20i7jTTUQ3FvDWhBDcmG0q2QQP1pGsnslPFfbMD3x7o9JKJ8yledytEbFI5WheiUWOj0uPKt0rAfuEOvq8fIOH/oj1JJWEFFMkdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiJ1fRFgEIAyvvnOoTvr/AWy9/1Yc2m7YB7sOQMB9tI=;
 b=CDL3OlC3zu31C+vqNdE5fV+J+GjoY3bQW/f83PlA1Kqh8F5yvGnkVJmsHiFgsS/+fJQf+YY2j4Z+YyUH369jwfX1CvEfeQ23BOAFg0cR0vBoiT6m/XeWHZJse6qBcgtuAGURhT+HuF8Zw0tjnglz4+l0u1u3CVZd/vRYcz9eCY4hN44p1n/Bcd1va1hVBXYoCytgf92Q2IoTikoyKss4HX8YVaHsB9w3duhpOOz476Jd6UFJz2CLkjs8DfCY41wIW2NNvpRUkj4nFja2dD6H7ifs16Z2wmZyGLKspKQcicJXLE3hMF36pWbUB33VM8+/77BPDuCFg13eIakRKQxzcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiJ1fRFgEIAyvvnOoTvr/AWy9/1Yc2m7YB7sOQMB9tI=;
 b=SHl8nc/E9qMNtxDZVkGr2AHvor35lDNQVAzmPimkuGV7n7NL2MRf2k8e6GtMFKbcFRw3XnXgvf1OMLZUF56YCV9EgDlVpN9ujD2+rmDG+rQk0Cq7L/6vJREs4wlAx6OFEUNhu3gXG5UahwEQiUtOfk6n0ZAIc+Q6ITCWLsoMQrc=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYYPR01MB7880.jpnprd01.prod.outlook.com (2603:1096:400:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 05:21:25 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 05:21:25 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] mm, hwpoison: fix page refcnt leaking in
 unpoison_memory()
Thread-Topic: [PATCH 2/6] mm, hwpoison: fix page refcnt leaking in
 unpoison_memory()
Thread-Index: AQHYswKMbbOJAhObY0GqUZfsxUS7yK21sQiA
Date:   Fri, 19 Aug 2022 05:21:25 +0000
Message-ID: <20220819052125.GB613144@hori.linux.bs1.fc.nec.co.jp>
References: <20220818130016.45313-1-linmiaohe@huawei.com>
 <20220818130016.45313-3-linmiaohe@huawei.com>
In-Reply-To: <20220818130016.45313-3-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 744ad7f5-9ab9-4d82-0b1f-08da81a2a973
x-ms-traffictypediagnostic: TYYPR01MB7880:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Itwuvn1z8FXw7gShuOrTnj0Xz6x77kXfJArwyyFBt4yeCDah1PbS6dNa+1Lon6F0zygS1L10nJpVmL2j7o2VWZMA1bD4k3xDz0CIdv782uwgEaLFN7nwKenH/TD37W73rY3PnIfOoegotMY0w4eVaZ4hFWgvCG0hcWxwJ5OC+JVeBSwIlzF45LNSVg4eAkmoaVJxRH3ZVKodYPG/whWLXmdRUgxqFZXJxp87SCXpPdoY2XFqN+xNNG2sPzpTnxsaR5YkZKdH16bzjXv82+1mBGkl7hXZ0Ie3N+SVCXXM2TrtNCPtdo3ILFVMS4whTR768cg9GbdDGC91SFHC5E53i1NQk6h5XFvEuu95kOmIuoxpST//gf7N2oGDYWpOStxx1V0uwLXkusQYlCvvZ5RZniGLIMigCgtZdM0YQZzA9DunpRrtJDx16S0d9Cz5MU57zM89EvL41uMcW9xLdaLhmWJnc4Mruw6VYe32gosapga9mKpWKTgrlDdat0IL+njLX2E3qLcD+4EJnKCJo2E7aEX9fWBC2Jqj+lMEfDes994THxKfkzaWdiDAcLoWo/ZVuq6Ke5HiUZg3nwjq+H1eXG57vDf02mjKbl2NIiPIRTAyCUK/znQ9I9xQebS+cvr/7DRHo5BinFrWKYDaWPlDzjXjqNWoRYCZiShPXKl4RV5f6r/wwInnZ9jENURbi2JzEWfhieJ7qQeTbCOvQduCPJQWBC/+XKhWNOh6B5aUvs4FF6hJwqxrbXWJpl4j3NBLCfKN0khRn7we/kP3t1bcsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(4326008)(83380400001)(38070700005)(186003)(38100700002)(4744005)(8936002)(82960400001)(1076003)(2906002)(86362001)(122000001)(64756008)(76116006)(66476007)(66946007)(66446008)(66556008)(5660300002)(8676002)(54906003)(55236004)(316002)(71200400001)(6486002)(6916009)(33656002)(41300700001)(9686003)(478600001)(6512007)(6506007)(26005)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vmg4OVhrSlQ0NGNyeXZJemFjYW5lcmkxZk9iaFEvUUYzcEwvL0FSZHY4dThU?=
 =?utf-8?B?bHFrSEdKbWswSVFLNHNzQWtXVVFoSzhxdGduM1VxamRxQ09jRDQrLzM1cXF2?=
 =?utf-8?B?V0lzaEVxcUNPRC91bDlrNDlCUjhuMnFYNWNYY1grMC9uUmJ1c1dtNjBaaS81?=
 =?utf-8?B?UlFlam5TOVc1UlF2Um15R1FWNGZ0dHFmSDBOZUJ5eFMzY0llQkZISnBTNENs?=
 =?utf-8?B?aFBLTlY0NFBNSHFEeDVJSVU1alV3dEllT1dUY05CQjRGcFppbkN3aDlxeU9I?=
 =?utf-8?B?UjdkRHZDVEJhVnVQY29HNmhuMkdPc1p5clpSbzB3dkVURnI3cjczbnkyNGVp?=
 =?utf-8?B?ZjhBTHVXeFluVEF4WjFTMVVWdkZyeTZ4ODN1RTZOYUwyR3hPdXJiKy9ZajFT?=
 =?utf-8?B?NUV0L2FZcUtDOWZ0RThZTEZpTUFLd0FsbGU3ZC9rT1JONlVpYWhZZm0zVk5w?=
 =?utf-8?B?VkhmcEtXa3Nocjk1eWlEc2hWK0FRRWtzY2Z0bVJqa3UvRFBpQy9FSzBtSHhP?=
 =?utf-8?B?Z1VBRTRMRFV5S2kyV25BZE4rMldzYmlEdU1hRVFSL3dsVi9UMW5qemk5VG5P?=
 =?utf-8?B?c2h6QTh1cDVRY2ZaVEl0Yy9SYUVtKzJPNkFhYk8wUXoyL2ZURjFZZmQ2RTUr?=
 =?utf-8?B?bHltbEp1QVoycnZXb0NqY21lYnJHVnhuTHNzdGZwT2Y3M2VMZlZrV1JvdFZp?=
 =?utf-8?B?Z2hwVVA1djdLMm5lUUtqRlA0dDNjM0NLU0FrRjhpRExMbDIyRVNuUVR6M3Vl?=
 =?utf-8?B?M01manNGRTUrdXhZYks1L1JlVkgxTkcwSWZvd0JZV2J2TWxaL29ReDNOeHZ6?=
 =?utf-8?B?T2hFcHRuOFMzR0JtbVhNQXQ3Q3NHZ04rOVdWZ1lEM2sxVUFNYS9QTzJ6NVZh?=
 =?utf-8?B?SE5pZVozRjJTcmhNQ2xJeGJCeFNramtDYTQ1NU1Mb1dlTCt0dFBMbDd5bTJJ?=
 =?utf-8?B?RlFiK2lRS2dRWVh1NjA2RFFoMjdiR21YUUM2aXN5bmtsdTBKUEJzaUdUeXNX?=
 =?utf-8?B?NG9qVEpTam9MR0tsNEV6ZDVUSUpOY0pQWThndmRINGREMWpQMHo5ZGhrZXpu?=
 =?utf-8?B?a01UOTFTWXAvWW5iT2xsdFpzNFZ1bkJucERydnl4clprWlhEd0Q1TUkxSXg1?=
 =?utf-8?B?V0FZVjdVWU02UTJ5djJFL2RVRDcxY2NxTzJMVlVqUEpaL0NYdmpNY0M5cGZF?=
 =?utf-8?B?eVVhK1Q0ZnJSdnJDc1c0bldEMmNkd3A0a2lPNjZVLzlPWU5qWTNuZUIzM1R4?=
 =?utf-8?B?SWpaNzNRUHo3QVRHU3lKbGtoajlMS2xSZDdIV1VlOVRYSUhTYnplTSt3cXJE?=
 =?utf-8?B?eldVNGJUTURvMFZoVGxPd2lrbUM1U2ZVQm9ybU5QNmdoRXVPUzl1NkpRQUZj?=
 =?utf-8?B?NUJqd2cyYS82azBxdWxpcTRUSHNZUmJ4SGRFaktrRGRHdE85RFlnZDJqTVJM?=
 =?utf-8?B?clpJVDZSME1IMTFuZlM3ZGVxbm90Q1N6bVdwMi9KMEdzdk9CUzlmUUVZSTAz?=
 =?utf-8?B?ZS9VRzNGZmdWRzZqNThRWVNWL1E4QlBKT05ZWTNhU2g3U3JYd3lKbGJUZkY0?=
 =?utf-8?B?VlZmWEFpY0h6UmFYdCsrbE00VzlxcnppMlBwR3ZLcHdWYVRMbk5LbWUzSjNW?=
 =?utf-8?B?ZFNpaG1sT3drSnNDait1SDVFajFldU9aRWk1UVdTR0theTdBK0FMalArMjdM?=
 =?utf-8?B?R2xVM2c0N0JwUTZxallNYjgyNEN1Ulp3N3hTU3FaclQvbkp3L21zaVIxQ09m?=
 =?utf-8?B?YXRpdHVFdmZZdHpnQWRqdmZpNUljb1pyL0U1Kzk5SldTdU9OYWsveWdsMWJn?=
 =?utf-8?B?TGFocGt1MytzeXFxUkwwV2dRN2V3YmJucmdVazJjd1hUOWxQb284elZ4Q0o4?=
 =?utf-8?B?UnRWbUQrVE94K1ZrUTFZRGtNeCtNdkhmRnpWbUNwdWNraURRVGdWVUthWW9m?=
 =?utf-8?B?Nmx2ZEltOEhFMjNySXdReVNyMm8zeG9sWXdLdGJpWHBWSk5IeGYxVHdZc1Nh?=
 =?utf-8?B?aDVWazc3ZHZnc1l3ekFMUktJNWNaT0hzU0c0THFyd1JlUkpTUUNOK1J6cjcr?=
 =?utf-8?B?enN3eEFZR2NsdU1vSGhOZnVxOVdtWkIxSGh4VDJodDRnVlJJa2dsV3RJQXFt?=
 =?utf-8?B?dEZYTk4rNkJYK3ZGejF2b3pzcHpsam1yaWpxT1g4elhvek50eERVNURscU01?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12D09EFC75274649845F5313CCE88C94@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744ad7f5-9ab9-4d82-0b1f-08da81a2a973
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 05:21:25.3764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+L5qC29ClrQ+XRuKs4j86nqVvyi7+NKYaqHXKZyZPyAh/9QtzTDGiIhR5p1w8HjEvOuz5DrDoVXcHYrsgF3Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7880
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBdWcgMTgsIDIwMjIgYXQgMDk6MDA6MTJQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gV2hlbiBmcmVlX3Jhd19od3BfcGFnZXMoKSBmYWlscyBpdHMgd29yaywgdGhlIHJlZmNu
dCBvZiB0aGUgaHVnZXRsYiBwYWdlDQo+IHdvdWxkIGhhdmUgYmVlbiBpbmNyZW1lbnRlZCBpZiBy
ZXQgPiAwLiBVc2luZyBwdXRfcGFnZSgpIHRvIGZpeCByZWZjbnQNCj4gbGVha2luZyBpbiB0aGlz
IGNhc2UuDQo+IA0KPiBGaXhlczogZGViYjZiOWMzZmRkICgibW0sIGh3cG9pc29uOiBtYWtlIHVu
cG9pc29uIGF3YXJlIG9mIHJhdyBlcnJvciBpbmZvIGluIGh3cG9pc29uZWQgaHVnZXBhZ2UiKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCg0KQWNr
ZWQtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQoNCj4gLS0t
DQo+ICBtbS9tZW1vcnktZmFpbHVyZS5jIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9tbS9tZW1vcnktZmFpbHVyZS5jIGIvbW0vbWVt
b3J5LWZhaWx1cmUuYw0KPiBpbmRleCAyMjg0MGNkNWZlNTkuLjBjNWFkNzUwNWI5OSAxMDA2NDQN
Cj4gLS0tIGEvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiArKysgYi9tbS9tZW1vcnktZmFpbHVyZS5j
DQo+IEBAIC0yMzc4LDYgKzIzNzgsNyBAQCBpbnQgdW5wb2lzb25fbWVtb3J5KHVuc2lnbmVkIGxv
bmcgcGZuKQ0KPiAgCQkJY291bnQgPSBmcmVlX3Jhd19od3BfcGFnZXMocGFnZSwgZmFsc2UpOw0K
PiAgCQkJaWYgKGNvdW50ID09IDApIHsNCj4gIAkJCQlyZXQgPSAtRUJVU1k7DQo+ICsJCQkJcHV0
X3BhZ2UocGFnZSk7DQo+ICAJCQkJZ290byB1bmxvY2tfbXV0ZXg7DQo+ICAJCQl9DQo+ICAJCX0N
Cj4gLS0gDQo+IDIuMjMuMA==
