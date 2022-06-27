Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4424555E385
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiF0H4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiF0H4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:56:07 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2074.outbound.protection.outlook.com [40.107.113.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C528D60EE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbfYOLfq17Lciz22k0IPgd7JsumHGrSovesJ0z7rmKa2D1rPC6x1pYINmb9R/WAM1QLnb3DWxJXXHXQJDOpuTgSK+AwIrEGN4kxIVzwa1yCQ99O/AxEwH0XqzZoZt1MEki6WqCxf1sBurIeaw78BysxINglvMkjxUqEeHUd1nDuKZ4oVunxSh52FKr7nXFyjCn61fEeASuBLTPYigiw6tT56uWt3l8JaX+dSoZ8LRmks4yf6d7+sjIyk5mMhelOSSDz/u7DSKJroIB513rEziqr9bP00EjXj5cFDzOYHtV2nW448osU1BsCgAM8K+r6YmOiu2gi3Rh+UcCGJHwjdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+IiFRaA9Nn/p/TP0ftxPamUA6hVGkIV+ZgIYcXYjRE=;
 b=SgNcYjBInWcw40ih6NnEBmOSQdM/RnhU4v06kPmRgCrJO7n+HH1lSEGkePP87fvdBXWcSn9o9/v9q8lXZ8WobL4d1ZPL4hXc8OrZOJTfe+wrU7zxisDpQqM2JkUVYeCEK+OES8oZg6UMjyiKfR21EiXM+C4z63KmlHNiBD7J5cq0aX4gauCiqh1m4r1WFLdAHHFn/AksIfyiGiFgp+5zAPNXFiYMTh2N23FotALbfD2SHTbP0DjXegu8JSmUFaaUPn/3noxhGxAsCPlxqsOJ3QG6paP8/AH1kIqvnQZzKZRx8m/ZGb6qoO7cSKJvX7WjhML+/jbM1FHrbO6/CBGifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+IiFRaA9Nn/p/TP0ftxPamUA6hVGkIV+ZgIYcXYjRE=;
 b=U6NgIutAXf9QVfXzafLZOTGYEuh9WcIRXAXmth8V1WXaKkiM5MkO3//TqW28+C1TGrtXlm0DniYcHMqLeNDVb85IOQUwe9d26XPf1PEDsU993iQVt0gY+Pi2m7i6SIonZUDxY4qxKakCDotzd/q8nC3AUIEMrdB2EjAvzL5yEMI=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYYPR01MB6731.jpnprd01.prod.outlook.com (2603:1096:400:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 07:56:00 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 07:56:00 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 4/9] mm, hwpoison, hugetlb: support saving mechanism of
 raw error pages
Thread-Topic: [PATCH v2 4/9] mm, hwpoison, hugetlb: support saving mechanism
 of raw error pages
Thread-Index: AQHYh1xWx3aKvVOz4k2Yam/81HJ/PK1imcEAgABOM4A=
Date:   Mon, 27 Jun 2022 07:56:00 +0000
Message-ID: <20220627075559.GA2168289@hori.linux.bs1.fc.nec.co.jp>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-5-naoya.horiguchi@linux.dev>
 <3e15e325-ae82-8e29-128d-dd0425b8db4d@huawei.com>
In-Reply-To: <3e15e325-ae82-8e29-128d-dd0425b8db4d@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 586aacf9-321e-4773-abac-08da58127a2a
x-ms-traffictypediagnostic: TYYPR01MB6731:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cwfbJpSDLzNcb6h+32tjItri8TS/B6Qo4YzfaLZE1GqmBZj6Shyv9m2aeqEEPGQ3OObRTdIMEOyMloapq7zGwUC57NQMlgS/wmM4rsEjRA2BhXYuqCWNq225Mm4OSI6oGVxbFaR6EsHrBEq2eraHEOaO4s1q428RrwSSiMBqC2HFojXXQnzk4NYQxrAisl6Td3aaGiRuurhJPVJ1+aXE7VQNCb8tOeNLtJlIEuegS9fNp+6QvB4FdQ6mY0KBLuxv+qer4XqrafI0CQgJPoPapFTv+iAWd+K9A/7GK2bSwwKtoJLCH8MrPbv0tqWpiS7NjwRUBOr5r58GCggpTB4r66z5Omrmme7YYraOB1XoGJtnq5xjSWZ1kFllX3+bnh6u7dNUYPIeEFPmX84vlr5hwmRb7iL9QpKFY08+7cAoXx2c/X84Yf9zD84fxOwljZlyeMElyrWLE02KWiijn5BfqtbGWtcAopnoucOjo0ylNaJVtVA3J+ETn/5odWxbUNdRWRzN+ALjWVYY4mwOIrLmDlcgG3qucvPRQ/Gdx+XMPaCF59gM6SNM8jZCszQ3GIvG/cWYGx1NviLS3BWQm0e9aqtg1cjdm9rfra5diCR1SlP0Qovk+19myxN3n/FLNttnmIV54QxVVAYs9/5EOaMicjOQ9f1xI81DYjgFDY6OO76ZMLT0NnIGjVNLIw6UmY/Mg0rfjfsXOoq5Cj15d7v7qj4mZ3bDxo+3Gq/L1utc4SLICEgfNm39mHh9FWBWDOP0PRoIhaOySqMbA9y8kSr07tYORfcMS9SYdtwghZMiPuw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(82960400001)(38100700002)(1076003)(33656002)(83380400001)(186003)(2906002)(66556008)(316002)(86362001)(54906003)(6486002)(6916009)(66476007)(85182001)(76116006)(64756008)(71200400001)(66946007)(66446008)(8676002)(4326008)(7416002)(6512007)(478600001)(26005)(38070700005)(53546011)(55236004)(41300700001)(122000001)(5660300002)(6506007)(9686003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEIybUUxbjNRYlNKME5VN2xUSXcvdkphNGY3WTNCMVdUN29LaDN6dDBXMkZl?=
 =?utf-8?B?R2d1cWp3YmxVaUdobEpSYXR5WUU1MlJWaHRpb1JXc3hIRzZGSVIwOWhJcGZY?=
 =?utf-8?B?M1RmcHhOOHRsODdTSDhhWklLc3FyODg1Sy91R1dMTXRhVlNoWGNLUjRJYWk1?=
 =?utf-8?B?Yktobm5XNUY1dXhYOE1sYXVPTlcxbFN5K0YzZlpSc3RnYjFQRkhLV3VzSVI0?=
 =?utf-8?B?N2lJc0FidzlXNmtqUmVLdThISnpCS2ZRUitoZ2RUZ3QwQWl4aGR0RGU4cGN0?=
 =?utf-8?B?MWFMUjI5Q2lkc2p0NHp1TFBmOXhGYk9NemRCY1lTN3Qra2F6cHpGRnNYb0tP?=
 =?utf-8?B?MkRlQ1lGajZTVitoRFlNbjAxTWFzZ1l5RUFlSm9HcXpoZGw1VW1wQ09RbGJm?=
 =?utf-8?B?dzlBWTVaUUgwemtLZmR3R0xqR3B1dkgyY0N3MXBKQkZmQWhpNldoaks4RTY3?=
 =?utf-8?B?MlpEZnU3czdKbEltQmxwSHI3SmJqekNsbXpGM3J1aXhGcm5pNkpYQVo0ZFhS?=
 =?utf-8?B?M3d3bEVobWRwK1NaQjQ5eE96NUUrTjdqc3pIaHhhNlFlcFNhbHBpNHhIK2lo?=
 =?utf-8?B?UGwvcFVSQkFXWkx2Z0lJcWJ1bGxERlBGSkJ6WkNKZ1ppK0Z6dTJrSHYvWkVp?=
 =?utf-8?B?MVBBN1pydThpK3FMSThiayszSzJ5OHFtWi90WUhLbWc2WkJMajNCTVQreG9O?=
 =?utf-8?B?TG5XcEcvemp3amxVL2JZdExPZnlXYnkzQUc0VGxTclFQY3NnbEFwMm1TTTRn?=
 =?utf-8?B?a2lsdW56WHluKzhIN2VwdndrSjdGMmRKdFliUmxGbVVUK0dpYXZNUGRsZ21n?=
 =?utf-8?B?ekFPTC85K0d4U0gzVy95aXZwcGRtd1RpNVFWWnZudU1EZzJDNFNmUm56YTJs?=
 =?utf-8?B?ZkRnQ0lPSFNNdUhhNnN5L1B6QXd5WVlvNGNkTlA2RUpZeDRDUUZqNGJpSHJi?=
 =?utf-8?B?Y2dvU1NyazJpRWRMalo3WGxPUzZVdFR3ckpFck45a1IzOHpwT3lXVWNyY3lk?=
 =?utf-8?B?NGtoL2RONHpNTm9kcHpDaGQ5WFdKdW8zRWZQb0E2M1pGaEtmQUhpYlBLSnF4?=
 =?utf-8?B?RHFoQXFmbHBzbnBqOGVwM2lGMDYwVHh1Zmluempvd1dCek95YlovOWJwRnZu?=
 =?utf-8?B?dVZwaURDMjh0aFRNVGErKzFhTGQ3YVJPNkFZUmdPUCtlL3NwRHhOSmxsUFZ3?=
 =?utf-8?B?Zk11UkY1c2U4d253VjBvZkg5Y1ZseTVLU001aHZoNDlYZTBqdnE4MVV6Nkty?=
 =?utf-8?B?ZWEwQWVvcExRL1ZwSnY1YytvUXFOb3pPbnlNbG1jQjFBRFUrZEhESHVWZWtR?=
 =?utf-8?B?N2oxY2sxQjBDZTRtVm5XSGRFdVBQYVJCZVRGWldrT2JaWGRnOEZXU2VvNklj?=
 =?utf-8?B?SEs4Z0ZRTG1vTW9kVzdGaERpYzFibUF2UzlqQ0xGN1ZpL0wwYm1XZDAxVWRJ?=
 =?utf-8?B?WkR5UjN0d0daM1p3dVV6OWg4ekdFc1pMYllKdW9kMGZsN0IrNXAzNDc4ZDZn?=
 =?utf-8?B?d0thcHd3TnlUUkxObUp0cGdncEc0U3lQcHpiSklud0ZCMDhIS0FHdEpabGJ1?=
 =?utf-8?B?Yk51Z0N2T1RCRlg4NVE4ODBvQUpzWmdEQ2dISzdSdVc4d2FoRWVNRFh5ZlVt?=
 =?utf-8?B?YmNOb00vWnFTbERESVRoWlBiT0VQUzZGcUlMalpkdHZKdnBMLzRoekN3S1hn?=
 =?utf-8?B?QW5RVGVseTFkQmd6Z3I0SStWcVVLcTkwSlRzOUo1djk0U0JWcWdhRW5YN0R1?=
 =?utf-8?B?ak12WDRUQTYrRXUwZmZhS3VsSmpsNTRSTGpLa1JtR1M1MlNzMXE1KzJTcFBr?=
 =?utf-8?B?bTl2REYwaGlPNHoxd2huVUxIZW9UZ1h0YkxVMzF4UjMwUVNHbVdhSHR2WTg2?=
 =?utf-8?B?WEcwMXFNT29GRjFIaHQ3Tkl2bjl2cHo4bjl4aFlQNnZxMUN3L3EyRi9BbTFD?=
 =?utf-8?B?VEhGS05CenM4ak1DSXRydHZtQ2s0YWRIYXJ4VU5LTnFYMzNOZmEwb1FGUUtD?=
 =?utf-8?B?TU9wdkxFMEUwV3c1aEIyRkMvQkVMMHJGQ1BwTk9OYVpFSjBBNnlKWFhtTXZX?=
 =?utf-8?B?NmhxQjJTUkhpeFNQc1plVVhBQU1GaC92RFlnbFdpTjRLY1FOenc5Ri9UelFz?=
 =?utf-8?B?Zk56amRWU2xGUXBIc01tOEtta0dWUS90YTFIODFITW0zS1dUMVZtUFhka1Jo?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D15BD7B978ED7C429E510F518972CC4A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586aacf9-321e-4773-abac-08da58127a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 07:56:00.8150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HV1E8Hh5AWr4C0W+jDiQF2hQnYx2rxPH6hrOMP2aWoWM8Esr6mZnk3ieogRV3ZUANmlkvnTOekkrsU21w4bYFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6731
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKdW4gMjcsIDIwMjIgYXQgMTE6MTY6MDZBTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi82LzI0IDc6NTEsIE5hb3lhIEhvcmlndWNoaSB3cm90ZToNCj4gPiBGcm9t
OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+IA0KPiA+IFdo
ZW4gaGFuZGxpbmcgbWVtb3J5IGVycm9yIG9uIGEgaHVnZXRsYiBwYWdlLCB0aGUgZXJyb3IgaGFu
ZGxlciB0cmllcyB0bw0KPiA+IGRpc3NvbHZlIGFuZCB0dXJuIGl0IGludG8gNGtCIHBhZ2VzLiAg
SWYgaXQncyBzdWNjZXNzZnVsbHkgZGlzc29sdmVkLA0KPiA+IFBhZ2VIV1BvaXNvbiBmbGFnIGlz
IG1vdmVkIHRvIHRoZSByYXcgZXJyb3IgcGFnZSwgc28gdGhhdCdzIGFsbCByaWdodC4NCj4gPiBI
b3dldmVyLCBkaXNzb2x2ZSBzb21ldGltZXMgZmFpbHMsIHRoZW4gdGhlIGVycm9yIHBhZ2UgaXMg
bGVmdCBhcw0KPiA+IGh3cG9pc29uZWQgaHVnZXBhZ2UuIEl0J3MgdXNlZnVsIGlmIHdlIGNhbiBy
ZXRyeSB0byBkaXNzb2x2ZSBpdCB0byBzYXZlDQo+ID4gaGVhbHRoeSBwYWdlcywgYnV0IHRoYXQn
cyBub3QgcG9zc2libGUgbm93IGJlY2F1c2UgdGhlIGluZm9ybWF0aW9uIGFib3V0DQo+ID4gd2hl
cmUgdGhlIHJhdyBlcnJvciBwYWdlcyBpcyBsb3N0Lg0KPiA+IA0KPiA+IFVzZSB0aGUgcHJpdmF0
ZSBmaWVsZCBvZiBhIGZldyB0YWlsIHBhZ2VzIHRvIGtlZXAgdGhhdCBpbmZvcm1hdGlvbi4gIFRo
ZQ0KPiA+IGNvZGUgcGF0aCBvZiBzaHJpbmtpbmcgaHVnZXBhZ2UgcG9vbCB1c2VzIHRoaXMgaW5m
byB0byB0cnkgZGVsYXllZCBkaXNzb2x2ZS4NCj4gPiBJbiBvcmRlciB0byByZW1lbWJlciBtdWx0
aXBsZSBlcnJvcnMgaW4gYSBodWdlcGFnZSwgYSBzaW5nbHktbGlua2VkIGxpc3QNCj4gPiBvcmln
aW5hdGVkIGZyb20gU1VCUEFHRV9JTkRFWF9IV1BPSVNPTi10aCB0YWlsIHBhZ2UgaXMgY29uc3Ry
dWN0ZWQuICBPbmx5DQo+ID4gc2ltcGxlIG9wZXJhdGlvbnMgKGFkZGluZyBhbiBlbnRyeSBvciBj
bGVhcmluZyBhbGwpIGFyZSByZXF1aXJlZCBhbmQgdGhlDQo+ID4gbGlzdCBpcyBhc3N1bWVkIG5v
dCB0byBiZSB2ZXJ5IGxvbmcsIHNvIHRoaXMgc2ltcGxlIGRhdGEgc3RydWN0dXJlIHNob3VsZA0K
PiA+IGJlIGVub3VnaC4NCj4gPiANCj4gPiBJZiB3ZSBmYWlsZWQgdG8gc2F2ZSByYXcgZXJyb3Ig
aW5mbywgdGhlIGh3cG9pc29uIGh1Z2VwYWdlIGhhcyBlcnJvcnMgb24NCj4gPiB1bmtub3duIHN1
YnBhZ2UsIHRoZW4gdGhpcyBuZXcgc2F2aW5nIG1lY2hhbmlzbSBkb2VzIG5vdCB3b3JrIGFueSBt
b3JlLA0KPiA+IHNvIGRpc2FibGUgc2F2aW5nIG5ldyByYXcgZXJyb3IgaW5mbyBhbmQgZnJlZWlu
ZyBod3BvaXNvbiBodWdlcGFnZXMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTmFveWEgSG9y
aWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gDQo+IE1hbnkgdGhhbmtzIGZvciB5
b3VyIHBhdGNoLiBUaGlzIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuIFNvbWUgbml0cyBiZWxvdy4N
Cj4gDQo+ID4NCj4gPHNuaXA+DQo+ID4NCj4gPiArc3RhdGljIGlubGluZSBpbnQgaHVnZXRsYl9z
ZXRfcGFnZV9od3BvaXNvbihzdHJ1Y3QgcGFnZSAqaHBhZ2UsDQo+ID4gKwkJCQkJc3RydWN0IHBh
Z2UgKnBhZ2UpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBsbGlzdF9oZWFkICpoZWFkOw0KPiA+ICsJ
c3RydWN0IHJhd19od3BfcGFnZSAqcmF3X2h3cDsNCj4gPiArCXN0cnVjdCBsbGlzdF9ub2RlICp0
LCAqdG5vZGU7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCS8qDQo+ID4gKwkgKiBPbmNl
IHRoZSBod3BvaXNvbiBodWdlcGFnZSBoYXMgbG9zdCByZWxpYWJsZSByYXcgZXJyb3IgaW5mbywN
Cj4gPiArCSAqIHRoZXJlIGlzIGxpdHRsZSBtZWFuIHRvIGtlZXAgYWRkaXRpb25hbCBlcnJvciBp
bmZvIHByZWNpc2VseSwNCj4gDQo+IEl0IHNob3VsZCBiZSBzL21lYW4vbWVhbmluZy8gPw0KDQpS
aWdodCwgZml4ZWQuDQoNCj4gDQo+ID4gKwkgKiBzbyBza2lwIHRvIGFkZCBhZGRpdGlvbmFsIHJh
dyBlcnJvciBpbmZvLg0KPiA+ICsJICovDQo+ID4gKwlpZiAocmF3X2h3cF91bnJlbGlhYmxlKGhw
YWdlKSkNCj4gPiArCQlyZXR1cm4gLUVIV1BPSVNPTjsNCj4gPiArCWhlYWQgPSByYXdfaHdwX2xp
c3RfaGVhZChocGFnZSk7DQo+ID4gKwlsbGlzdF9mb3JfZWFjaF9zYWZlKHRub2RlLCB0LCBoZWFk
LT5maXJzdCkgew0KPiA+ICsJCXN0cnVjdCByYXdfaHdwX3BhZ2UgKnAgPSBjb250YWluZXJfb2Yo
dG5vZGUsIHN0cnVjdCByYXdfaHdwX3BhZ2UsIG5vZGUpOw0KPiA+ICsNCj4gPiArCQlpZiAocC0+
cGFnZSA9PSBwYWdlKQ0KPiA+ICsJCQlyZXR1cm4gLUVIV1BPSVNPTjsNCj4gPiArCX0NCj4gPiAr
DQo+ID4gKwlyZXQgPSBUZXN0U2V0UGFnZUhXUG9pc29uKGhwYWdlKSA/IC1FSFdQT0lTT04gOiAw
Ow0KPiA+ICsJLyogdGhlIGZpcnN0IGVycm9yIGV2ZW50IHdpbGwgYmUgY291bnRlZCBpbiBhY3Rp
b25fcmVzdWx0KCkuICovDQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCW51bV9wb2lzb25lZF9wYWdl
c19pbmMoKTsNCj4gPiArDQo+ID4gKwlyYXdfaHdwID0ga21hbGxvYyhzaXplb2Yoc3RydWN0IHJh
d19od3BfcGFnZSksIEdGUF9LRVJORUwpOw0KPiA+ICsJaWYgKHJhd19od3ApIHsNCj4gPiArCQly
YXdfaHdwLT5wYWdlID0gcGFnZTsNCj4gPiArCQlsbGlzdF9hZGQoJnJhd19od3AtPm5vZGUsIGhl
YWQpOw0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIEZhaWxlZCB0byBzYXZl
IHJhdyBlcnJvciBpbmZvLiAgV2Ugbm8gbG9uZ2VyIHRyYWNlIGFsbA0KPiA+ICsJCSAqIGh3cG9p
c29uZWQgc3VicGFnZXMsIGFuZCB3ZSBuZWVkIHJlZnVzZSB0byBmcmVlL2Rpc3NvbHZlDQo+ID4g
KwkJICogdGhpcyBod3BvaXNvbmVkIGh1Z2VwYWdlLg0KPiA+ICsJCSAqLw0KPiA+ICsJCXNldF9y
YXdfaHdwX3VucmVsaWFibGUoaHBhZ2UpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+IA0KPiBUaGlz
ICJyZXR1cm4gcmV0IiBjYW4gYmUgY29tYmluZWQgaW50byB0aGUgYmVsb3cgb25lPw0KPiANCg0K
UmlnaHQsIGZpeGVkLg0KDQo+ID4gKwl9DQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4g
Kw0KPiA+ICtpbmxpbmUgaW50IGh1Z2V0bGJfY2xlYXJfcGFnZV9od3BvaXNvbihzdHJ1Y3QgcGFn
ZSAqaHBhZ2UpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBsbGlzdF9oZWFkICpoZWFkOw0KPiA+ICsJ
c3RydWN0IGxsaXN0X25vZGUgKnQsICp0bm9kZTsNCj4gPiArDQo+ID4gKwlpZiAocmF3X2h3cF91
bnJlbGlhYmxlKGhwYWdlKSkNCj4gPiArCQlyZXR1cm4gLUVCVVNZOw0KPiANCj4gQ2FuIHdlIHRy
eSBmcmVlaW5nIHRoZSBtZW1vcnkgb2YgcmF3X2h3cF9saXN0IHRvIHNhdmUgcG9zc2libGUgbWVt
b3J5PyBJdCBzZWVtcw0KPiByYXdfaHdwX2xpc3QgYmVjb21lcyB1bm5lZWRlZCB3aGVuIHJhd19o
d3BfdW5yZWxpYWJsZS4NCg0KWWVzLCB3ZSBjYW4uIEkgdHJ5IHRvIGNoYW5nZSBsaWtlIHRoYXQu
DQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLg0KDQotIE5hb3lhIEhvcmlndWNoaQ==
