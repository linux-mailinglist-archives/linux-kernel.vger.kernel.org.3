Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEDD5ADF9C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 08:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbiIFGPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 02:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbiIFGOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:14:36 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2078.outbound.protection.outlook.com [40.107.113.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F00A6F577
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 23:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8HtBYnHWz1qi1eVCZFA6qd5Ytc7U5JWqfXRmLNXig1+6xs5Jlvvoj+1q/AXTEbs/lGfJcTuH/5NvfBWVc/PEMBoCSdU6OYpwuEOzV3aCdPaZJikGbw1bd+A3bgRFA5o88Ws0L8PJHZKCSRbvu5nbgcRkbZxT7xtEawOsrV5nCR+dt3mokb1y41G7LeXghFr5BlVY6h4ucTR1WCgCGAEQjS8X9kaS60SsGx8fcrpgNDERM4kH6E1wcF6GrtLXVQ9NBirsxmsoAIc69+wsj3nhj3nwc5IZDel1HBU2ZgQ15wcsl1vI2xXAfuj+sM9jaHs8Qi5GmizrfJQND2CaThn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9Yn2dAJ2/oVcyiuJphpShHT3aoXmEe8uy2o3x/WawI=;
 b=EnTzkRzDjzYIwH+g348BxObNenFSS5lXtpZInzXtMGOKNaU3mkDV7ZzUktupro/DtwmQ8pNYetTE2G7Hd672UFW0vn62lc/Tlb36qjqsmh3XUtFEiDquprxtmvI02H+xrgH6KOzrc7lPIE73KrXs8qoJLihRkLkcCQELAbHpGxUQx5kqneV2+LRazvYkJQpIb6ILW9utcBvWdYZR9PQ+K/gNzXBz7b3J9NGEYHegHNWbhX3O5u9Du7oKA6VNhrTGVZQNIIQLmk3GvlcxGbPwwUNAwPFS4NYwd5G//ubiSy0ga6th5c463Ermhd8WKoGn8YGzWAm5JRTv99cGrcNKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9Yn2dAJ2/oVcyiuJphpShHT3aoXmEe8uy2o3x/WawI=;
 b=YPv6lWfTBhnIRcx4FN+aumNrPNgVdibo99eoFOJ0LqoiVZLgAvZvPbVOA7Sv9J0KeBxoGwiomVnPeW/GBgvdFrozL0atjnEUjXe0WN21Vq7EQ8GsJekYH/nW5k4G6EbVqc/xdJy8d4n9IHCcQkfORaXIUfoIUXoSU332Pkrzyww=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB10510.jpnprd01.prod.outlook.com (2603:1096:400:307::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 06:14:18 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5588.011; Tue, 6 Sep 2022
 06:14:18 +0000
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
Thread-Index: AQHYwO/cKEdKHklTv0a9v9Lcn1gcJK3Rt58AgAA2SoA=
Date:   Tue, 6 Sep 2022 06:14:18 +0000
Message-ID: <20220906061417.GA1406504@hori.linux.bs1.fc.nec.co.jp>
References: <20220905062137.1455537-1-naoya.horiguchi@linux.dev>
 <20220905062137.1455537-2-naoya.horiguchi@linux.dev>
 <3e302aa5-d63d-097e-2cb7-831b7c99e736@huawei.com>
In-Reply-To: <3e302aa5-d63d-097e-2cb7-831b7c99e736@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6d37287-1532-4443-a565-08da8fcf0824
x-ms-traffictypediagnostic: TYCPR01MB10510:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /mr6WATWEHV0l+InJ7LfwbGpWQKW6DlOLP+JkPmlGxIY2vvxHG74UZTlGKye2IiSf2X3Yri9q/BrzjKCMDkF+aSTRmX6au+3p5fkshEsrOZTRNWc+eWF2Mi8uwml6eoVv9LR1+YLBmccrToYsHzSKR5XbxbtHsuUDRf6E0q2xd/z+dncslTzKmw4MEUx7zI1r0vDraBMfeHYSyGYQszjyyG3R+X3YwVqpNsoVRz+H3quFoxP7PxkKGVNMe7cVV582jwKnG9nMyUM57Y+H7KBp8+7ePKfD7Hiwzr0tDncWUthccbHbbObIPHpF1uDB6MtvI8GVVB9EZb43hXBx56SUqQIRZedzhXHSW3IOh8r66jK4P/Ymwze8CTDxPnvG8YsGqoV2TGKvpTdflBq8W4+L8nuAbEFbo0GGzNaC0lZ79z2I/aA9V9Y7yuJpmSHMrCrtSYb1cu2cJ7r3Wi6BKOZOuJOrIQljiDX/DiKN8S8TcL/UNH2h3KaWKKsmrLvahWbmOMIMPxEhelXz8Ke1fZcHByVy81PO2+O9DhyHCMeMU4ORjjmgJp6JxTkKq0NxcxOVlZpcWayFtF1nguiZVBvP62Y5Bzck6j8iXaWBeXeSb3XYCrHCbtqs1cxNpwmkZZI+xcIk6m5192kT/6FWxLV8RR71s7ukapNocYsJ27MmvHWrN+b1o+/TnXlWVQUkhyggJIVFN9tIzJaLyD0kUaH9YDZAnpwS9Eswv6mPhH4mbI4Fn7vvDvfvfP/qWwOAX6C79PnSWrD7GaaDFb4z2tnrqkEzKpfYNtZob8R7qHwbGU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(38070700005)(316002)(966005)(6916009)(54906003)(2906002)(71200400001)(82960400001)(53546011)(41300700001)(38100700002)(64756008)(6506007)(66476007)(33656002)(6486002)(66556008)(8676002)(66446008)(4326008)(478600001)(86362001)(8936002)(5660300002)(7416002)(76116006)(1076003)(186003)(85182001)(66946007)(83380400001)(122000001)(26005)(9686003)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUZtWVpOcGtFNVMxeEx6c0w2RlVKblBiMmpKVm8xZVB1Z3NPK3pjelFEc3lv?=
 =?utf-8?B?YU9XZjk2WEsvU0t6ZUJiNTIwaU8xUlA3ZmRUN0c3MEJORGFVZG81UGxJNTlC?=
 =?utf-8?B?RFVLejNaTkt5UWloYjhzSFdqVCtSM2RKc1pJL2xpODRoSnliWnVnbGlDU285?=
 =?utf-8?B?dElxN3BXd21vbG9nQ0VETkl2MUtFUEhNRjRoSmhpbkgySm1hK0puWHBVTVBy?=
 =?utf-8?B?UDBST1hDeWZYb2dsYStpMGFtL0ljUkd3QTZmWlpLcytUVkR0R0NTOVZlL2hi?=
 =?utf-8?B?T0cxZWc5aDRjMEZhSGpQeTNzYTM4Z0lGUUcvOE1iMHFhWDNoaThvMXlKc2FX?=
 =?utf-8?B?Wk5zT2JYaWZ0clNwOXlGbzFDTEpvNW9lWVEvYWZRQmRkc0toRUtpSGVDRm5r?=
 =?utf-8?B?V0c2UkNzZnlHbHlxRHRjd0xrUnJwa3o0MjVnSGdEdThSZHRLRllBaC9QRFQ1?=
 =?utf-8?B?VDFvY1dtVWt3M3huM2dQR2I5cml5SzNGSlNWSUZlYS9tSE01V0EzNzQyek9F?=
 =?utf-8?B?dW04UWJicHlwZzZnWVN5QWpFcGhsRlZIREVLVlN0WDc3TWt4R2czL2FScjFq?=
 =?utf-8?B?ZlRxVWtoOVBDYzMyNi9wTEpIRW9nbk04TjVIMzF1MWE1eFpIYitRS0U1R09t?=
 =?utf-8?B?NTMrenRGUVhJbkNDVVM3UUZrdnlHbUdrSlBKT20yNGpOYmJURFYzeWMwdENL?=
 =?utf-8?B?cTZIcjZONkd5aFZVYnoyZURURGJ0a3R1VGo1SHg0UDNvWFdRTERwUWlRcWU5?=
 =?utf-8?B?aWFwaFhnWndmN28ydjNWRWRzbi9LZmVYdXBqMjRjMG5PZ3RZa1NJVzF3U3Uv?=
 =?utf-8?B?ZTFNK1pvOW5tdk1Lb205cG1RWGpvaytvNXcvSFBZTnUrZFFNUGdDYVM2S3ZC?=
 =?utf-8?B?MmNSeFoyQUxwK1RPVUpJY3d1bU0wU2JWWUQrTkZ1L0NzclZIUk5ENHdmbXFy?=
 =?utf-8?B?M2lGcXd3NklnWjZnVTBvSTdndlUxUXl0Y3JmTDlCQXBmVDRiZVpzRjRIaEVY?=
 =?utf-8?B?ajhOakRObzFKcmJYcytLWU4wM00yM0ZZbGlaR3R6Sk8ycGpyeWU0RTVqRjZx?=
 =?utf-8?B?bjRXTjFGMlpFTGJ2cE1EckJLakFDdms2RU1qYnBJQ3UvZFREcDNNSS9sSS9n?=
 =?utf-8?B?dmxmeUc5bllFdXdQUkh3TVh1QUliMFdZTHZaTjh4SHprNTNSZXJ6ZGNZbGdT?=
 =?utf-8?B?UXloM0pDQ29kdjNqclNKMmNVQTFqNUdUR29hck90Qnh5eXZFQ0lwMG9qaFdv?=
 =?utf-8?B?OGRxajA0MFFMR2tMYWYzSXk4ZTVoQ0JXbExuUXVIOTZldFpMMDNzcE1vRXMw?=
 =?utf-8?B?QVdvNVk5UWYyWUdxWjB1K2tybTZidjJRZ1VRKzNiTW1EaE95Q2wrUW9NRGk4?=
 =?utf-8?B?SVZJdGpLVFZ0Q0w0SHpxSGwzeGJDRFpJNjVZLzM4KzUvcm4xWDhWS2VUdFlu?=
 =?utf-8?B?QTVqSVN0c2dWUzFFVXkrdnc0NlFjM2hiSTlpeEY1NHhjdFl2MDFiUlRQR0xH?=
 =?utf-8?B?bmo4OVU3VnBhaHNsZlQyUGdnUis2YUk4THVrSU1MYzlEbTAxcWtnK09DbkpY?=
 =?utf-8?B?MXNwajc4aFhHQTRhVndqMCtjRVlBS0djc0syOE14cFEzUHRCd3ZzSmR0MHlD?=
 =?utf-8?B?d2JmUHRuU2l2VkhVMVdUNHBENkMzYllkL0E4Y2ZHMFp5RFMvVHFRZ0JiLzJz?=
 =?utf-8?B?ZHdwTmpVc0pEYXFXMXVGMG52cHdkVmhQdjVyZGtCd2lPbTRFeUo2OEg4MnVl?=
 =?utf-8?B?YTV3aW1DZzFvYnU4NzNOUVVXZldaNEFjUk5IY1FGb0lKNUlTYkhOQXVjazdB?=
 =?utf-8?B?VGJ3Um9BSVRha2Jpb0RmVHJ2RjFPcHZocGxoVVV6RHQrcnp1YjVubkRrTmNF?=
 =?utf-8?B?OVl2d1J0QytzZ2FtZXBnSHp4bXF1bEsxNnNDRE0zZUk2d05Cb1pqcEx0blgw?=
 =?utf-8?B?SDZlNnR2TlQ5VUI0UVhVR01KUmRUeGZTZCtDNHIxd2NLNE9UdVpheHF6bnpY?=
 =?utf-8?B?V3FjblYrYk9vdm00VXRLQnd5RU8yVlNnd0pVVEVzTjJvSEwrNDJuVy9jenp1?=
 =?utf-8?B?R0VLTS9HNXg1ZkorOWw1dTJISVRwa01kMHJCcFVCZzA2NVpMWXh2Yk9LaTNi?=
 =?utf-8?B?cnpwVHpiTlJKK0RrNDYxQldOMVkzY2VmSEJwbmo5ZURNZTlrRnZqZ1cybTRN?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <773C39DA1D31C747A8A74CCDCC7BCFA3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d37287-1532-4443-a565-08da8fcf0824
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 06:14:18.3575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nk1Le/BddJ08Msly1E1pW/rH2KsDJEtb72qW7sy96sxOrMt2UeAvQk8IPuKoDdq+c9sizPzqpdv8/3m6C/Gw9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10510
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgMDYsIDIwMjIgYXQgMTA6NTk6NThBTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi85LzUgMTQ6MjEsIE5hb3lhIEhvcmlndWNoaSB3cm90ZToNCj4gPiBGcm9t
OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+IA0KPiA+IEhX
UG9pc29uZWQgcGFnZSBpcyBub3Qgc3VwcG9zZWQgdG8gYmUgYWNjZXNzZWQgb25jZSBtYXJrZWQs
IGJ1dCBjdXJyZW50bHkNCj4gPiBzdWNoIGFjY2Vzc2VzIGNhbiBoYXBwZW4gZHVyaW5nIG1lbW9y
eSBob3RyZW1vdmUgYmVjYXVzZSBkb19taWdyYXRlX3JhbmdlKCkNCj4gPiBjYW4gYmUgY2FsbGVk
IGJlZm9yZSBkaXNzb2x2ZV9mcmVlX2h1Z2VfcGFnZXMoKSBpcyBjYWxsZWQuDQo+ID4gDQo+ID4g
TW92ZSBkaXNzb2x2ZV9mcmVlX2h1Z2VfcGFnZXMoKSBiZWZvcmUgc2Nhbl9tb3ZhYmxlX3BhZ2Vz
KCkuIFJlY2VudGx5DQo+ID4gZGVsYXllZCBkaXNzb2x2ZSBoYXMgYmVlbiBpbXBsZW1lbnRlZCwg
c28gdGhlIGRpc3NvbHZpbmcgY2FuIHR1cm4NCj4gPiBhIGh3cG9pc29uZWQgaHVnZXBhZ2UgaW50
byA0a0IgaHdwb2lzb24gcGFnZSwgd2hpY2ggbWVtb3J5IGhvdHBsdWcgY2FuDQo+ID4gaGFuZGxl
IHNhZmVseS4NCj4gDQo+IFllcywgdGhhbmtzIGZvciB5b3VyIHdvcmssIE5hb3lhLiA7KQ0KPiAN
Cj4gPiANCj4gPiBSZXBvcnRlZC1ieTogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVj
LmNvbT4NCj4gPiAtLS0NCj4gPiAgbW0vbWVtb3J5X2hvdHBsdWcuYyB8IDIyICsrKysrKysrKysr
LS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDExIGRl
bGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9tbS9tZW1vcnlfaG90cGx1Zy5jIGIv
bW0vbWVtb3J5X2hvdHBsdWcuYw0KPiA+IGluZGV4IGZhZDZkMWYyMjYyYS4uYzI0NzM1ZDYzYjI1
IDEwMDY0NA0KPiA+IC0tLSBhL21tL21lbW9yeV9ob3RwbHVnLmMNCj4gPiArKysgYi9tbS9tZW1v
cnlfaG90cGx1Zy5jDQo+ID4gQEAgLTE4ODAsNiArMTg4MCwxNyBAQCBpbnQgX19yZWYgb2ZmbGlu
ZV9wYWdlcyh1bnNpZ25lZCBsb25nIHN0YXJ0X3BmbiwgdW5zaWduZWQgbG9uZyBucl9wYWdlcywN
Cj4gPiAgDQo+ID4gIAkJCWNvbmRfcmVzY2hlZCgpOw0KPiA+ICANCj4gPiArCQkJLyoNCj4gPiAr
CQkJICogRGlzc29sdmUgZnJlZSBodWdlcGFnZXMgaW4gdGhlIG1lbW9yeSBibG9jayBiZWZvcmUg
ZG9pbmcNCj4gPiArCQkJICogb2ZmbGluaW5nIGFjdHVhbGx5IGluIG9yZGVyIHRvIG1ha2UgaHVn
ZXRsYmZzJ3Mgb2JqZWN0DQo+ID4gKwkJCSAqIGNvdW50aW5nIGNvbnNpc3RlbnQuDQo+ID4gKwkJ
CSAqLw0KPiA+ICsJCQlyZXQgPSBkaXNzb2x2ZV9mcmVlX2h1Z2VfcGFnZXMoc3RhcnRfcGZuLCBl
bmRfcGZuKTsNCj4gPiArCQkJaWYgKHJldCkgew0KPiA+ICsJCQkJcmVhc29uID0gImZhaWx1cmUg
dG8gZGlzc29sdmUgaHVnZSBwYWdlcyI7DQo+ID4gKwkJCQlnb3RvIGZhaWxlZF9yZW1vdmFsX2lz
b2xhdGVkOw0KPiA+ICsJCQl9DQo+IA0KPiBUaGlzIGNoYW5nZSBoYXMgYSBzaWRlLWVmZmVjdC4g
SWYgaHVnZXRsYiBwYWdlcyBhcmUgaW4tdXNlLCBkaXNzb2x2ZV9mcmVlX2h1Z2VfcGFnZXMoKSB3
aWxsIGFsd2F5cyByZXR1cm4gLUVCVVNZDQo+IGV2ZW4gaWYgdGhvc2UgcGFnZXMgY2FuIGJlIG1p
Z3JhdGVkLiBTbyB3ZSBmYWlsIHRvIGhvdHJlbW92ZSB0aGUgbWVtb3J5IGV2ZW4gaWYgdGhleSBj
b3VsZCBiZSBvZmZsaW5lZC4NCj4gT3IgYW0gSSBtaXNzIHNvbWV0aGluZz8NCg0KVGhhbmsgeW91
IGZvciB0aGUgY29tbWVudCwgeW91J3JlIHJpZ2h0LiAgKFRha2luZyBhIGxvb2sgb3ZlciBteSB0
ZXN0IHJlc3VsdA0KY2FyZWZ1bGx5LCBpdCBzaG93ZWQgZmFpbHVyZXMgZm9yIHRoZSByZWxhdGVk
IGNhc2VzLCBJIHNvbWVob3cgb3Zlcmxvb2tlZA0KdGhlbSwgcmVhbGx5IHNvcnJ5LikgIFNvIG15
IHNlY29uZCB0aG91Z2h0IGlzIHRoYXQgd2Uga2VlcCBvZmZsaW5lX3BhZ2VzKCkNCmFzIGlzLCBh
bmQgaW5zZXJ0IGEgZmV3IGxpbmUgaW4gZG9fbWlncmF0ZV9yYW5nZSgpIHRvIGhhbmRsZSB0aGUg
Y2FzZSBvZg0KaHdwb2lzb25lZCBodWdlcGFnZSBsaWtlIGJlbG93Og0KDQpAQCAtMTY0Miw2ICsx
NjQyLDggQEAgZG9fbWlncmF0ZV9yYW5nZSh1bnNpZ25lZCBsb25nIHN0YXJ0X3BmbiwgdW5zaWdu
ZWQgbG9uZyBlbmRfcGZuKQ0KDQogICAgICAgICAgICAgICAgaWYgKFBhZ2VIdWdlKHBhZ2UpKSB7
DQogICAgICAgICAgICAgICAgICAgICAgICBwZm4gPSBwYWdlX3RvX3BmbihoZWFkKSArIGNvbXBv
dW5kX25yKGhlYWQpIC0gMTsNCisgICAgICAgICAgICAgICAgICAgICAgIGlmIChQYWdlSFdQb2lz
b24oaGVhZCkpDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KICAg
ICAgICAgICAgICAgICAgICAgICAgaXNvbGF0ZV9odWdldGxiKGhlYWQsICZzb3VyY2UpOw0KICAg
ICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQogICAgICAgICAgICAgICAgfSBlbHNlIGlm
IChQYWdlVHJhbnNIdWdlKHBhZ2UpKQ0KDQpUaGlzIGlzIHNsaWdodGx5IGRpZmZlcmVudCBmcm9t
IHlvdXIgb3JpZ2luYWwgc3VnZ2VzdGlvbg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
bW0vMjAyMjA0MjExMzUxMjkuMTk3NjctMS1saW5taWFvaGVAaHVhd2VpLmNvbS9UDQosIGFzIGRp
c2N1c3NlZCBpbiB0aGUgdGhyZWFkIGV4aXN0aW5nICJpZiAoUGFnZUhXUG9pc29uKHBhZ2UpKSIg
YnJhbmNoIGluDQp0aGlzIGZ1bmN0aW9uIGNhbid0IGJlIHVzZWQgZm9yIGh1Z2V0bGIuICBXZSBj
b3VsZCBhZGp1c3QgdGhlbSB0byBoYW5kbGUNCmh1Z2V0bGIsIGJ1dCBtYXliZSBzZXBhcmF0aW5n
IGNvZGUgZm9yIGh1Z2V0bGIgZmlyc3QgZnJvbSB0aGUgb3RoZXJzIGxvb2tzDQpsZXNzIGNvbXBp
Y2F0ZWQgdG8gbWUuDQoNCklmIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9uIG9uIHRoaXMsIHBsZWFz
ZSBsZXQgbWUga25vdy4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
