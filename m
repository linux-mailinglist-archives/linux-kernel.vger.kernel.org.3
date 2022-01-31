Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EB64A52DD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbiAaXFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:05:08 -0500
Received: from mail-tycjpn01on2086.outbound.protection.outlook.com ([40.107.114.86]:15795
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231213AbiAaXFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:05:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP5vHBLqh3xnHU0U7O0cexy+o5nCcF8aKYBvpFqxJMrKHzHtSBVhLzvKOyjTxxxWMhq6RVtreyl0s3sQkI6BvT7AkLxmzosEGkRt0wehd2tUM2LJyNf3tKK7xfgjXIuS6WvOBWmvHBw2UejGFVuVoMqkqThDBNQ/6F0Buf7rPzbQlS1jn00qKAK3bEyP3JMkI/o+EZlYp0xz7TMOunM6/ay2XrhU+1psHtEZVs2eI5scUUfNXaFgIbjoSkEuvtr3nvQvl+LUvQm+XyOCaN3U/iIEZB9LqMC3da+CemjF0xy49/xvkUkiBuKtAUKAku4/pz243EPERcR0i68SJBSIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3h9G+0AmhE9XZ+c1lV0fLONTFfc82ExNQbhmx1AXzo=;
 b=aUe52RTLCGk86Mip4Z/dlBVuZPwC262FGLA/Ji0KWsxA3FzZdEtNFmjgzqdIFQ5x1dfZ1Ha2aoIBQWBKi4Glqu6FkMbftkgU7qFojDpUboog7jOB0T9Kn7WCd077gx2AoJ8k7Uc83BwBtbbOYR56YjRFED9UJww96H6Hwaih/zBA/X8uFK2P++EqLS/hWN/vFaWEQK77rrii5YioPhm+0bThY84h0EBkN9urTv9qm4Ies+jPDjxDtahA2D9RxwwaY68J8610BxFUdXOU/n3oJp+J1w4V+5/4l+tvjvqUMTEFr8noA1P6k4wYr0vTo8XdJlNSz3h4Vqf7J+UvLe/Diw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3h9G+0AmhE9XZ+c1lV0fLONTFfc82ExNQbhmx1AXzo=;
 b=HiDs87EEyJ1DHEBZK2o/2CXXV7uRtd9McOF5s/MdVffiUxlIV6CyT0Q5YqR2n5Da/uYSBDnlSVOgs3yoh9aAOD8FTbUBo1XQpMULR03ck+Pmbe1EiOELSoDx+iDE5LD2c1nzOmsU1ZHSfB0u7N5HwxM0Qy9VjOmynX+7/aUc8L4=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYBPR01MB5423.jpnprd01.prod.outlook.com (2603:1096:404:802f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Mon, 31 Jan
 2022 23:04:57 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b%3]) with mapi id 15.20.4930.019; Mon, 31 Jan 2022
 23:04:56 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hwpoison: Check the subpage, not the head page
Thread-Topic: [PATCH] mm/hwpoison: Check the subpage, not the head page
Thread-Index: AQHYFXkOJ10HyUvEFEaIagy3eAzxlqx8DUOAgAAEfYCAAI6LAIAAgICAgABkq4CAAD2EAA==
Date:   Mon, 31 Jan 2022 23:04:56 +0000
Message-ID: <20220131230456.GA1124278@hori.linux.bs1.fc.nec.co.jp>
References: <20220130013042.1906881-1-willy@infradead.org>
 <dcfa1ee5-1512-5e49-92c2-4a33ab59080@google.com>
 <Yfb/rVg1HYHkKBgO@casper.infradead.org>
 <20220131054432.GA856839@hori.linux.bs1.fc.nec.co.jp>
 <YffjC9+JsrZB5ekr@casper.infradead.org>
 <c1b13519-88c4-3e43-eedf-9b848877ade4@oracle.com>
In-Reply-To: <c1b13519-88c4-3e43-eedf-9b848877ade4@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e860e326-edae-4f3f-bc29-08d9e50e197e
x-ms-traffictypediagnostic: TYBPR01MB5423:EE_
x-microsoft-antispam-prvs: <TYBPR01MB5423F13E37776166BB8F97E3E7259@TYBPR01MB5423.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mXdy45j41/ExXrbns+9vyA3YpIdOlVVCCnEPW/SuZeriONsZO5HSBTQ9oNWwLb2tpzWLnrnLulx8rNMg+HwerymJcew5MOs6K67LAVLqyNvymACuwywZ+ZhXbRUdDzr2MhuysUlikB6Vp345wIK9Cc67drm/AiUO43IyYFn1P2FOS/XqlpG9ITohyY0N/PteeMuQ2L5pjlSDaaPNU0NBMlGYHIcD/fyEFK+1rh7qbDWIPjeQ8Dnhl4HYag4BedZ7Sv5K0/qsWr7qtskpqgTY9bH/lqYux4e6OQ3PswF+pvD+F6sI+4oS6j4PCn3RXhmZxBZg1q1W4Fsm6dugqjPwu1WH3WEIc+AQqTY6payNkU8zXd5KUrtM6OtIjREn+l47AioTeMy5y67/jajDaLMP1u/e0Lke/hwiyy413Ufo/JGq0iFoX9dK4RsJvzvpeOnaU9eGm6rAhZmuZs246wiKoUl7/3q/yXKxU9ZZt1buIzAFzsmppIyNqBLeJ9DGRfl3ZS3VcjmjoHMx4noFNuPw/bhNMocJZJmS2KSaoDSnVkrX9VtnlqIIZNq7/I4NPt0eatC8YUlgALOOJHEWfJ+QKRGxOa1iHrRXYuL+7T3frdWsLCEJjHonwSmlyZA6x+47rt9F26rlxMGZqNi54oEMxk73AeXMvk8p7BZBY1DOaAuEmVOvqJjtOtHqQvfPtqBVQjzEGouGjZUDjcF37foY0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(71200400001)(5660300002)(38070700005)(54906003)(110136005)(2906002)(6486002)(316002)(122000001)(85182001)(1076003)(8936002)(66476007)(38100700002)(86362001)(82960400001)(26005)(186003)(4326008)(53546011)(6512007)(55236004)(9686003)(6506007)(508600001)(83380400001)(66946007)(66446008)(66556008)(64756008)(76116006)(8676002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDFvMkM3Y1h3aXpwWUM5UWFPZ2pkV0YydGdoRzJkTGswd2twMnUrMGFhTFQy?=
 =?utf-8?B?ZUxUZkNQY2xZN3M5Q3NTYU1RT2ZwUlcxZWVIQldta1hnQnluYUJSRERocXRP?=
 =?utf-8?B?MEZYWmR4bDV3M3F3a0psRlRBdGFqV1BFWEdLejMyTGlsQmd6cGQvOVlRYVl4?=
 =?utf-8?B?SkU2MGpTNFV2SGV1QWRMS3BpWXlXWTZEMjBpcTFvWHNOeDJ6K3d0VHQ0WSt5?=
 =?utf-8?B?M2owSExoK3hjNzJLN3FXcndxczNvYnA4akxGUFo0ZVB4ZVAyR251RWx0Qmp1?=
 =?utf-8?B?YkMyZUpobDd3T0hvV3phR1hKVHJKY2FVek1WR1IrTXJqYWdLWGxZbnZOQnI4?=
 =?utf-8?B?Ri9jbEJwaE1ndXVYdDU2czNnU1ZyK3djM1RDVDBiNGJvOFJoRDRvVlY4USts?=
 =?utf-8?B?blhaeGZWMlN1M3RZRGhRQllwMnRldFZRekV1S0tBU09mSEg2UmN2SC9ramU5?=
 =?utf-8?B?QzVzalVxN0JCbVNPQVdGUGR5YU1lOGdwdTBZZGl2THh5Y01FRWRtQXlWbkw0?=
 =?utf-8?B?TW9VcjRnTitwbXRlK0d2dFMvSVhldUNoL1JQYmt0TW85azUzbDMxZVhpYjJz?=
 =?utf-8?B?UHFlOEZqWWNVSEZ2V3M0L1dJSGdYN0ppelB4VXlaK05wOGRjRjNiRDFVdU14?=
 =?utf-8?B?NzZ4OVg3OXZRZ2o1dzBDckRwSWpEUlFxWHRDYUd0ZkFmVFVTd002V3hlYWNG?=
 =?utf-8?B?R3lReGVIN01iMnI0UmpIc0RvWkxyRFgrbE8rMkNrZmlSdEpnYytlMnpKZmpL?=
 =?utf-8?B?QXg1WGRkYkxzdjZWL05Oa0c3QTZRWTJBTUdGc0V4cTdiRlk3YVFScWkrQy9Q?=
 =?utf-8?B?dlVMbTZQVFR0ZWt5T054N1NBcnV5dmt0UHZTWk1ObmlrdFhSRXJiSDk0UnB1?=
 =?utf-8?B?b1FNM1dxQUZLUWh2dWZYRk0yYTBURzIrOFo0ZjB2U0pVdTFPMm1xV1FjaUdP?=
 =?utf-8?B?cXlXU1R0Q3d5V2duelloNWE0M1lVdDBKbFZmOU9GWWFpRWUrcnNXZlQxUDJq?=
 =?utf-8?B?d2tINDd1QWRidk41OFFQaDdzeVFFdW1jT0FZdjJIVnk3enJXYnQvenRqT3c5?=
 =?utf-8?B?QzdKaTk1alM3MGY4OVNMMnh4ek9IQW1WZld0SDM0dENvZHpTK1JqcUd3VVZD?=
 =?utf-8?B?ZHAzajhQTkIwUWpqR2w3SVVzaVVXdXdlbmQwekNBR2F6RnFBSURaTHFidGNS?=
 =?utf-8?B?aHdzRjNDd1NaaTljV2ZzbmdEZHUrNlRKbFVaV2JNYzdlRjdXY0JtUFlaL01N?=
 =?utf-8?B?Qm9zVkZXTWlWZzVEUC9hTEpIUFdPOFRBNjJzSFNZZVN3WUl4VzZrWXBMS0pT?=
 =?utf-8?B?K0RZQTcxK1hMcXFORWdhR0VFSzgwbjIzMHVpVHpIZlp4SHJQNEFpZEFEWXo5?=
 =?utf-8?B?bXZTQy9UVDIrcFQrSkk3d21YSW1ZUjZQNngreWQyaXRxcXp6RURPMXErNUVv?=
 =?utf-8?B?bFpKZUFBZDJxSWpQZ3Z2NCs4T1JaUC82RHVsZkMzeEdXd0V5R1BmRGh3d2hD?=
 =?utf-8?B?ckJIbmNWcDNZaUVadkNiTWlMbUVvVHlobkFxemNQbEtSODQ5T1Z3ekdlUlFJ?=
 =?utf-8?B?aFQ1c3MzRFRoa1VYcW1YTFU1azFYbWdmTXVOa1lCbWRpdUZ2NUVxNXBkaUlL?=
 =?utf-8?B?NGxYMGw1dHUrSlRwZGdsbXM1WUFJRFY1S0VhMmVZUnRCTnF2amUzOXpLeVBE?=
 =?utf-8?B?UVhrUnlhbjQ2MHR3cG9DZHp1NTdiVkJnaVN4WlY1dis4eVduekZKb0MyaS9y?=
 =?utf-8?B?cW90WUlWOC9haW1ySFdXNUt2dkNrd0gwc1dNOUhHTWdjWDJTRjZnMERac3Er?=
 =?utf-8?B?UEZSWUxYY2tsVlg5RTF5WkRyMTdTKzhYM1pieWlVbEJzdDZVTEIydUFObE5T?=
 =?utf-8?B?QUcrNmZkZFBhNUpkNVFnNzNPTXhQOFZKYnVOVVliblhWWkplenRaR3QrVUxB?=
 =?utf-8?B?YS9JS3Q3LzZCSUxDS1JMVzNDVW45N09UQndEWlVZV0h1YkJKakJnYS9NeHRr?=
 =?utf-8?B?UkZDWnQwOUpnbkowNzlOckMxSm41ZkR6WkUxOFh4VlU1bVlrdVhaUzJsVEc0?=
 =?utf-8?B?RVRVNUZvTi9ubUNUUjM3VmNHNXVYbkZhZ1hLaHVCbXp1MDRGT3FzeGhpb0dq?=
 =?utf-8?B?MzlWak9JSHIxRGdsVzNjQTI3d1MyQUJlY2tBTldadmhOQmtZait0RmNWT3hl?=
 =?utf-8?Q?5d6ZYIdl4p5UICJN+jBiUZIkNWxiLmLqBrCcyTYuuv+x?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <315A6DA008F992448F84B4A3AC73FC4E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e860e326-edae-4f3f-bc29-08d9e50e197e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 23:04:56.8893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57iEDd5IcIOGYxeFaxL5nFjdWzmXvyNuC4RcKem2jVzFkytdx2oNL0Gb1CuD8JSl4XZ612hioNdGEJnXgASPtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5423
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKYW4gMzEsIDIwMjIgYXQgMTE6MjQ6NDVBTSAtMDgwMCwgTWlrZSBLcmF2ZXR6IHdy
b3RlOg0KPiBPbiAxLzMxLzIyIDA1OjI0LCBNYXR0aGV3IFdpbGNveCB3cm90ZToNCj4gPiBPbiBN
b24sIEphbiAzMSwgMjAyMiBhdCAwNTo0NDozNUFNICswMDAwLCBIT1JJR1VDSEkgTkFPWUEo5aCA
5Y+jIOebtOS5nykgd3JvdGU6DQo+ID4+IE9uIFN1biwgSmFuIDMwLCAyMDIyIGF0IDA5OjE0OjIx
UE0gKzAwMDAsIE1hdHRoZXcgV2lsY294IHdyb3RlOg0KPiA+Pj4gT24gU3VuLCBKYW4gMzAsIDIw
MjIgYXQgMTI6NTg6MTdQTSAtMDgwMCwgRGF2aWQgUmllbnRqZXMgd3JvdGU6DQo+ID4+Pj4gT24g
U3VuLCAzMCBKYW4gMjAyMiwgTWF0dGhldyBXaWxjb3ggKE9yYWNsZSkgd3JvdGU6DQo+ID4+Pj4N
Cj4gPj4+Pj4gSGFyZHdhcmUgcG9pc29uIGlzIHRyYWNrZWQgb24gYSBwZXItcGFnZSBiYXNpcywg
bm90IG9uIHRoZSBoZWFkIHBhZ2UuDQo+ID4+Pj4+DQo+ID4+Pj4+IFNpZ25lZC1vZmYtYnk6IE1h
dHRoZXcgV2lsY294IChPcmFjbGUpIDx3aWxseUBpbmZyYWRlYWQub3JnPg0KPiA+Pj4+PiAtLS0N
Cj4gPj4+Pj4gIG1tL3JtYXAuYyB8IDQgKystLQ0KPiA+Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPj4+Pj4NCj4gPj4+Pj4gZGlmZiAtLWdp
dCBhL21tL3JtYXAuYyBiL21tL3JtYXAuYw0KPiA+Pj4+PiBpbmRleCA2YTFlOGM3ZjYyMTMuLjA5
YjA4ODg4MTIwZSAxMDA2NDQNCj4gPj4+Pj4gLS0tIGEvbW0vcm1hcC5jDQo+ID4+Pj4+ICsrKyBi
L21tL3JtYXAuYw0KPiA+Pj4+PiBAQCAtMTU1Myw3ICsxNTUzLDcgQEAgc3RhdGljIGJvb2wgdHJ5
X3RvX3VubWFwX29uZShzdHJ1Y3QgcGFnZSAqcGFnZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2
bWEsDQo+ID4+Pj4+ICAJCS8qIFVwZGF0ZSBoaWdoIHdhdGVybWFyayBiZWZvcmUgd2UgbG93ZXIg
cnNzICovDQo+ID4+Pj4+ICAJCXVwZGF0ZV9oaXdhdGVyX3JzcyhtbSk7DQo+ID4+Pj4+ICANCj4g
Pj4+Pj4gLQkJaWYgKFBhZ2VIV1BvaXNvbihwYWdlKSAmJiAhKGZsYWdzICYgVFRVX0lHTk9SRV9I
V1BPSVNPTikpIHsNCj4gPj4+Pj4gKwkJaWYgKFBhZ2VIV1BvaXNvbihzdWJwYWdlKSAmJiAhKGZs
YWdzICYgVFRVX0lHTk9SRV9IV1BPSVNPTikpIHsNCj4gPj4+Pj4gIAkJCXB0ZXZhbCA9IHN3cF9l
bnRyeV90b19wdGUobWFrZV9od3BvaXNvbl9lbnRyeShzdWJwYWdlKSk7DQo+ID4+Pj4+ICAJCQlp
ZiAoUGFnZUh1Z2UocGFnZSkpIHsNCj4gPj4+Pj4gIAkJCQlodWdldGxiX2NvdW50X3N1Yihjb21w
b3VuZF9ucihwYWdlKSwgbW0pOw0KPiA+Pj4+PiBAQCAtMTg3Myw3ICsxODczLDcgQEAgc3RhdGlj
IGJvb2wgdHJ5X3RvX21pZ3JhdGVfb25lKHN0cnVjdCBwYWdlICpwYWdlLCBzdHJ1Y3Qgdm1fYXJl
YV9zdHJ1Y3QgKnZtYSwNCj4gPj4+Pj4gIAkJCSAqIG1lbW9yeSBhcmUgc3VwcG9ydGVkLg0KPiA+
Pj4+PiAgCQkJICovDQo+ID4+Pj4+ICAJCQlzdWJwYWdlID0gcGFnZTsNCj4gPj4+Pj4gLQkJfSBl
bHNlIGlmIChQYWdlSFdQb2lzb24ocGFnZSkpIHsNCj4gPj4+Pj4gKwkJfSBlbHNlIGlmIChQYWdl
SFdQb2lzb24oc3VicGFnZSkpIHsNCj4gPj4+Pj4gIAkJCXB0ZXZhbCA9IHN3cF9lbnRyeV90b19w
dGUobWFrZV9od3BvaXNvbl9lbnRyeShzdWJwYWdlKSk7DQo+ID4+Pj4+ICAJCQlpZiAoUGFnZUh1
Z2UocGFnZSkpIHsNCj4gPj4+Pj4gIAkJCQlodWdldGxiX2NvdW50X3N1Yihjb21wb3VuZF9ucihw
YWdlKSwgbW0pOw0KPiA+Pj4+DQo+ID4+Pj4gVGhpcyBsb29rcyBjb3JyZWN0LiAgQ29ycmVjdCBt
ZSBpZiBJJ20gd3JvbmcgdGhhdCB0aGlzIGlzIGZvciBjb25zaXN0ZW5jeSANCj4gPj4+PiBhbmQg
Y2xlYW51cCBhbmQgdGhhdCB0aGVyZSBpcyBubyBidWcgYmVpbmcgZml4ZWQgYnkgdGhpcywgaG93
ZXZlci4NCj4gPj4+DQo+ID4+PiBPaCwgbm8sIEkgdGhpbmsgdGhlcmUncyBhIHJlYWwgYnVnIGhl
cmUuICBJdCdzIGp1c3QgdGhhdCB3ZSdyZSBsb29raW5nDQo+ID4+PiBhdCBhbiB1bmNvbW1vbiAm
IGhlbmNlIHJhcmVseS10ZXN0ZWQgc2NlbmFyaW8gLS0gYSBtZW1vcnkgZmF1bHQgaW4gdGhlDQo+
ID4+PiBtaWRkbGUgb2YgYSBUSFAgKGluIG1haW5saW5lOyBvYnZpb3VzbHkgaXQnbGwgYmUgYSBs
aXR0bGUgbW9yZSBjb21tb24NCj4gPj4+IHdpdGggYXJiaXRyYXJ5IHNpemVkIGZvbGlvcykuICBJ
IGRvbid0IGRvIEhXUG9pc29uIHRlc3RpbmcgbXlzZWxmLCBzbw0KPiA+Pj4gdGhpcyB3YXMgYnkg
aW5zcGVjdGlvbiBhbmQgbm90IGZyb20gdGVzdGluZy4gIEEgc2NlbmFyaW8gd2hlcmUgdGhpbmdz
DQo+ID4+PiB3b3VsZCBnbyB3cm9uZyBpcyBhIG1lbW9yeSBlcnJvciBvbiBhIG5vbi1oZWFkLXBh
Z2Ugd291bGQgZ28gdW5ub3RpY2VkDQo+ID4+PiB3aGVuIG1pZ3JhdGluZyBvciB1bm1hcHBpbmcu
ICBDb250cmFyaXdpc2UsIGlmIHRoZXJlJ3MgYSBoYXJkd2FyZSBlcnJvcg0KPiA+Pj4gb24gYSBo
ZWFkIHBhZ2UsIGFsbCB0aGUgc3VicGFnZXMgZ2V0IHRyZWF0ZWQgYXMgcG9pc29uZWQsIGV2ZW4g
dGhvdWdoDQo+ID4+PiB0aGV5IHNob3VsZG4ndCBiZS4NCj4gPj4NCj4gPj4gVGhhbmsgeW91IGZv
ciByZXBvcnRpbmcuICBBcyB5b3UgcG9pbnQgb3V0LCB0aGUgY3VycmVudCBjaGVjayBkb2VzIG5v
dA0KPiA+PiBoYW5kbGUgdGhwIHByb3Blcmx5LiAgVGhlIHJlYXNvbiBvZiBjaGVja2luZyBoZWFk
IHBhZ2UgaGVyZSBpcyB0byBoYW5kbGUNCj4gPj4gaHdwb2lzb25lZCBodWdldGxiICh3aGljaCBo
YXMgUEdfaHdwb2lzb24gb24gdGhlIGhlYWQgcGFnZSBldmVuIGlmIHRoZSBlcnJvcg0KPiA+PiBp
cyBvbiBhbnkgb2YgdGFpbCBwYWdlKS4gIFNvIEkgdGhpbmsgdGhhdCB0aGUgcHJvcGVyIGZpeCBp
cyB0byBhZGQgYSBoZWxwZXINCj4gPj4gZnVuY3Rpb24gdG8gY2hlY2sgcGFnZSB0eXBlIChub3Jt
YWwsIHRocCwgb3IgaHVnZXRsYikgYXMgd2VsbCBhcyBQYWdlSFdQb2lzb24uDQo+ID4gDQo+ID4g
SSB0aGluayB0aGlzIGhhbmRsZXMgSHVnZVRMQiBwYWdlcyBjb3JyZWN0bHk6DQo+ID4gDQo+ID4g
ICAgICAgICAgICAgICAgIHN1YnBhZ2UgPSBwYWdlIC0gcGFnZV90b19wZm4ocGFnZSkgKyBwdGVf
cGZuKCpwdm13LnB0ZSk7DQo+ID4gDQo+ID4gQXMgSSB1bmRlcnN0YW5kIHRoZSBIdWdlVExCIGNv
ZGUsIHB2bXcucHRlIHJlZmVycyB0byB0aGUgaGVhZCBwYWdlLCBub3QNCj4gPiB0aGUgc3VicGFn
ZSAodW5saWtlIGEgUFRFLW1hcHBlZCBUSFAgcGFnZSwgd2hlcmUgaXQgd291bGQgcmVmZXIgdG8g
dGhlDQo+ID4gcHJlY2lzZSBwYWdlKS4gIEJ1dCBJIGNoZWVyZnVsbHkgYWRtaXQgdGhhdCB0aGUg
aW50cmljYWNpZXMgb2YgdGhlDQo+ID4gSHVnZVRMQiBjb2RlIGFyZSBub3Qgc29tZXRoaW5nIEkn
bSBhbiBleHBlcnQgb24uDQoNClNvcnJ5LCB5b3UncmUgcmlnaHQuDQoNCj4gDQo+IFlvdXIgdW5k
ZXJzdGFuZGluZyBpcyBjb3JyZWN0LiAgSGVyZSBpcyB0aGUgY29tbWVudCBmb3IgdGhlIHJvdXRp
bmUgd2hpY2gNCj4gc2V0cyBwdm13LnB0ZS4NCj4gDQo+ICAqIEZvciBIdWdlVExCIHBhZ2VzLCBA
cHZtdy0+cHRlIGlzIHNldCB0byB0aGUgcmVsZXZhbnQgcGFnZSB0YWJsZSBlbnRyeQ0KPiAgKiBy
ZWdhcmRsZXNzIG9mIHdoaWNoIHBhZ2UgdGFibGUgbGV2ZWwgdGhlIHBhZ2UgaXMgbWFwcGVkIGF0
LiBAcHZtdy0+cG1kIGlzDQo+ICAqIE5VTEwuDQoNClRoYW5rIHlvdSBmb3IgdGhlIGNsYXJpZmlj
YXRpb24uDQoNCj4gDQo+IEp1c3QgYW5vdGhlciB0aG91Z2h0LiAgV2l0aCBuZXcgaHVnZXRsYiB2
bW1lbW1hcCBvcHRpbWl6YXRpb25zLCBpdCBpcyBub3QNCj4gcG9zc2libGUgdG8gc2V0IHBvaXNv
biBvbiBodWdldGxiIHRhaWwgcGFnZXMgdW50aWwgYWZ0ZXIgYWxsb2NhdGluZyBzdHJ1Y3QNCj4g
cGFnZXMuDQoNClNvIHRoZSBwcm9wb3NlZCBwYXRjaCBpcyBmaW5lIHRvIG1lLg0KDQpBY2tlZC1i
eTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCg==
