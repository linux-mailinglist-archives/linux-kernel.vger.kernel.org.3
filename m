Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43572463BF6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244046AbhK3QmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:42:08 -0500
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com ([40.107.223.77]:39264
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230154AbhK3QmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:42:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jfzu7jP5B06JIwD8EWUsfRC6kfmlFOxcFN8wVYEcB+RkSAzQ8NNSA9sU4uLDFSqzrSKPvi96lno0kGIFsw13lKe483nJn4DmeQ370fW7v5L//SvPNxC/qpm+8QYWEoi4ykuh1+VZq+QZwQds3UFYvi7DLjcCT+tNfKdEUZUS2u5/lhbaj/eykQhYCz7DRldvJ0rE+HBBS7rxueAOOlfa7kvyixWHOJbOo9JDuhmc8mc4GI7K8xqDGt6noENvlk/EbZ1Rk3zBRH5Ug2UAXtX6u3esyYt+d4TV48xZ+kpFzh0Y8vzSeFbcy9PniaDfXJVBbhD9xWAub8aZ4dlLxDfT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jyc/TYbkhGEq5fih8ZSZ9jawSbE1dJp0dhpQbfwJ5wQ=;
 b=YgiWcXshk2WbXTSCuUBhw+JIb1nsk2+EMVCVqCCz2l+jwKU6Kmcwp5HjRKLxDIHPTbbjquswVnFfF8S9T6GO3v9awtr/v+vh0FGkSqMIxrX4GOjrkhZSffAIAev5NGxSfusdJp4hOzohk8EjbihPVPT9TBsbXcVp6+G6Jl1MTeFJwy4O6QclLukpSgI5lRw/v24c1HlFeFCrAqgj42xS7QnJWO/jlGZhFaLmK5zyFWbtkKwwHvd204Zk3ZHUFd7c6ZHfVZMKimxZ1HjnmFFgWiMvqINKItnm4ThjiGg3gF8s8KRdbAjKojR/7p8CicjE9m5zJ032y2yx7SPBf2EsIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jyc/TYbkhGEq5fih8ZSZ9jawSbE1dJp0dhpQbfwJ5wQ=;
 b=dXsoqBwOPijGA4vJWa7tclLt6kFpVbj2A0U7GYGhsw1kG1LZfYQcs01eDYzuGYxCTMflMl/nCTWk6/HAOwSI0Jrt9+YZWz2vWpzk/1Ki1o7pD1H9V97z1r/LvbuB2/BCtPYcTsSf5VjbEi5fCAaOQCFE1s++NFG9igO4PUGLACc=
Received: from SJ0PR02MB7279.namprd02.prod.outlook.com (2603:10b6:a03:2a1::9)
 by BYAPR02MB4519.namprd02.prod.outlook.com (2603:10b6:a03:59::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Tue, 30 Nov
 2021 16:38:38 +0000
Received: from SJ0PR02MB7279.namprd02.prod.outlook.com
 ([fe80::dc7:5777:fa1b:ad83]) by SJ0PR02MB7279.namprd02.prod.outlook.com
 ([fe80::dc7:5777:fa1b:ad83%9]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 16:38:38 +0000
From:   Harsha Harsha <harshah@xilinx.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Sarat Chand Savitala <saratcha@xilinx.com>,
        Harsh Jain <harshj@xilinx.com>
Subject: RE: [RFC PATCH 5/6] crypto: xilinx: Add Xilinx SHA3 driver
Thread-Topic: [RFC PATCH 5/6] crypto: xilinx: Add Xilinx SHA3 driver
Thread-Index: AQHX5cfv/Gtkq75oe0GYT8ahmwjfo6wcHY6AgAAm3pA=
Date:   Tue, 30 Nov 2021 16:38:38 +0000
Message-ID: <SJ0PR02MB7279ADF2CBC68F753B43288FDE679@SJ0PR02MB7279.namprd02.prod.outlook.com>
References: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
 <1638262465-10790-6-git-send-email-harsha.harsha@xilinx.com>
 <f6c47b8c-6c88-f64f-fdaf-3bb240d4dab0@infradead.org>
In-Reply-To: <f6c47b8c-6c88-f64f-fdaf-3bb240d4dab0@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55f222cf-5ecb-4a48-e2c8-08d9b41fdc84
x-ms-traffictypediagnostic: BYAPR02MB4519:
x-microsoft-antispam-prvs: <BYAPR02MB4519B26D253A9AD1A722B625DE679@BYAPR02MB4519.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 40CvOGVU9Yo6O4qtXtENjRcuPP3coZufl/D6zEA7X7RSc/9CwVcU3ZyppFy9NCGGIs2m3Bmy140Q6TW+gVjFd1vxR6lhRFTBG5ucs0PfF5Qur4xt300Dr6SsqM4NUwyI9nDQvoUOLqKptQURpiKZaomXlxMhsZIqXVrvCZR8nK3meH0DS9bIPtPJxP3l7Rnjgc2naT3M+5nkYmvZsRIuOMsBjbJrThTCQTdp3NGihYVpmtoX80K8xA2eCTF7kIpxwd5I4rkXtSWqpn74E2NKtaUhwDFWtbRB3WLMsHEGgr8hkWgpBGxpG8le8xXiklnuBLlj8Wu9oGbiewKuwvbywbe/pW2Kq+iudCxYYwJUeTEqTlYDqF52iNhWbvRbdMRCdy7yBRxgYH1VK4sbIazymlCQKElb559T3i3HWRkTfleVYVfzLtiGNH7tCah5wq0vjHQIbDaP0J6ojnnESnD1JbHySCXNUQ3OI0gqvUd0s6PUIbUE31ZVzJY8uUHi+TT3SkToDSvf4w6RHV19kZFEFwOCnaTVJVyaHF5bphpQ537cxznBOeXzfm0UtgwR0tiec6uACfwmPF9Few1SlUJ5Zq8xsMTCdLl7AbOfFA/pV5EjOFW4K1pzRFGJOURcm7L2mzgKo+eysSWJiDeeB7GSqjiQY2NzwkMI1HkTqk0w0kJFaugUi13W0qtxs+jzv5kQw2mgAOmjzrkKWnKgvlJT5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB7279.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(33656002)(64756008)(107886003)(4326008)(186003)(52536014)(8936002)(508600001)(55016003)(38070700005)(6506007)(66446008)(2906002)(66476007)(66556008)(54906003)(86362001)(83380400001)(316002)(53546011)(122000001)(5660300002)(7696005)(76116006)(9686003)(8676002)(66946007)(110136005)(71200400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFI4bEYyZjl6eXNkQnphMERsRnA1SG5PWGlId3Q3R1JXSGtaU25La3VtRWpv?=
 =?utf-8?B?OWZobGtsL3d6TURwcm54RGZ4TWJLRVFzOU9wQm1NVFNLVkRBdVFWbW9QMkdp?=
 =?utf-8?B?akNjNEZXKzVXVnI2MUl1TTd1L2xOckJISWxpelQyczhONEFpckVVbm95UkxH?=
 =?utf-8?B?MEZpaWVmd1NtVzFudWxQRmU1Y1VZSlE0T3J6YWxqT0g4dk5MUW9aem1lQUps?=
 =?utf-8?B?a1FrblY3N2ZReWhBNG5sM3UxKys2aVBnSkdOaEd1M3pid0tsL1ZUcExwamNL?=
 =?utf-8?B?Njl3WUR0aXZoS1dvT2NoV21HZUFuU21qSWpOajJEdlA4eFlZT3Q3bVJ4ZmV1?=
 =?utf-8?B?eG5NcWNaeWY1bkYwa08rU3Z0SUJORWFCRWpqY2E0M3JyS2h3bDVlTkp2VS91?=
 =?utf-8?B?eDZ4RVIzcUZaVi9wZml3RjhSdmJtUTJIeFJLS1ZMYjUybEtvSWc0VGE4cVBr?=
 =?utf-8?B?SURmSmVRMHkydTZ3MC9mbmN0Y204UUpxTGpjSS83aHZmd2w1U3RmMUppNkhG?=
 =?utf-8?B?bHVlMmxyUnB4bDM0UUlKWitmNlRGWElqN3d4OUZibVJHOHRJYzNoZHVUanZr?=
 =?utf-8?B?Ui9xaGVMZ2tsUXZ1THhYbnhXVmhtVWFPZ3NSeE1tUGVvUXVXRk9OVE1lK0lR?=
 =?utf-8?B?SDBrN1psaWNHNjVvbDE2dVUrOW8wdVdRcm9GY09MOWo2R2t4c0ZmTDZtYTZl?=
 =?utf-8?B?V3NDa2w2UmFKQTB6b281SnF1cHlmVWRCQzFsUGFIUmJNRW5pMzhJMFR0Qzdz?=
 =?utf-8?B?NUJxZlNwWEtrbk1WR2toU21xU2pKc2ZhVjBueVU1Szc4NThIVG5UR21BWVlx?=
 =?utf-8?B?SkYwMW1rRjM0ZzZHT2k0eml3SkExTXFmSm9BRVppRGowTDBlc0FtMXdmSmdO?=
 =?utf-8?B?cE1lc2xJNXNYWEJMaU9idldlRTdyMlcybVJyVjZDWlJTTGVtc1JBVnlrYjdS?=
 =?utf-8?B?Tnd6UGZuV2podDFPM1RWWkhFWU8yQkV3SXRpR2dpejhMam5BeUtDVjFweStW?=
 =?utf-8?B?WUNpcWUwV0I0d2p1U3JHdGdWdzJHZmJuMHlGODdiS2VSMUFSQTB5Z3RSbVMz?=
 =?utf-8?B?dUNuVStZL2pTNkxUQWlyRjZTR2VsNDF5eE5WcGl4Vmg0Q214S1VJM1Z6dGdU?=
 =?utf-8?B?ZmZabysvamV4c3NQTitzbEV0Q3J6TDUwQkZ6amdLK1FuRHNoQUNwSWJTRGQ5?=
 =?utf-8?B?M0JwWEJtQUs4VFZFalFhZmM4dUpSc0R6TzRLT2x0WlBGODFHa28vSTd2RUNq?=
 =?utf-8?B?RTZGUkhPSE5KLy9QenVvTXJwNkxLaEVjYjh0Nk4waHZzMWRlZ2RBMEhUY1N6?=
 =?utf-8?B?Q3BTVEZEM2pWU1pmNVFzVXFaczlYUzVVSzQrYTVqbEtReVdNY2RCR2NNYW5N?=
 =?utf-8?B?ZWlPMnkvVXNKTkhJcUdIdGlLYkQyVThYcHJMZVIzSzdkNnNENmxjVUwrcU9N?=
 =?utf-8?B?cXZWZUpoZ0MwclAvZjZaRWpVV1pMQ2syQ1hnK200cWRGUWtZSnB4MDh1UWxP?=
 =?utf-8?B?NVphMUlDbnJCRWU4VGVoYldCOS9Fc3pJYStKNURUNTJjYUllSXpXN0J6a3pO?=
 =?utf-8?B?NEdGY2pCSWNtT0tueDhrbkhNVWxQT29hZXlSS0Q3NFVkOS9SbnRENHBxd0c0?=
 =?utf-8?B?SmFYeUF1dHd2ejhRRmNlbXFNU3RBSmRSQ05oRWx5VnJGYksxY1VOMzEvRkF3?=
 =?utf-8?B?Q0F0ZXZUNGpWTU1xM2hRaFJWTWovRVd2U2hTYW9FR0ludUFhNUVpaVRpVzNE?=
 =?utf-8?B?bkV3bDU3OXBraXkyVVVxOE9uNEVhcXduemdoNFN6T01sOUV4RVJRTmZwdDBG?=
 =?utf-8?B?SWRkRllBeVprSzNaTEo0eDN0am1Gd0dJOVByYzJ5OUc3M2s3WWdRWEVUSXV4?=
 =?utf-8?B?MDRQeHFJTlJWaXg0S3hybEpEWS9SRzdJODdTRUg2RFlBbzlqVjFZaXQvL2hL?=
 =?utf-8?B?RUJ1Rnp5VXdmSmVoUzhEOFZiOFM5eU1qM3licFYzWi9SWWZyQkZiQlZNUjRx?=
 =?utf-8?B?UHVmL1hvZEZnemhNdVc5TkZCY0E1ODJvbXpGRVBFaHloZzBQZFJienZJWS84?=
 =?utf-8?B?NGJOSFBoNVY1SjZkNExkRjNmY1hGZDdSQ3pUQU8zVWd3azZBcUZ3VEhzMU9k?=
 =?utf-8?B?SXYxalpibkdYcG55ZWo5d2x4RTlJQ2NaOEFJcElteVg4dnFCTE9vZVJqZmdM?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB7279.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f222cf-5ecb-4a48-e2c8-08d9b41fdc84
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 16:38:38.4306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kawHVPWv6NqlhCIoLS1AkKpDuzv18iSG+k9MXrGxOrPmpTsQOrPX64NSwUDnlX5ECzE8ekqIG7xxV9fd6P9qlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4519
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFuZHksDQoNClRoYW5rcyBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaC4gSSB3aWxsIG1ha2Ug
dGhlIGZvbGxvd2luZyBjaGFuZ2VzOg0KLSAgWnlucU1QIFNIQTMgaHcgYWNjZWxlcmF0b3IgLT4g
WnlucU1QIFNIQTMgaGFyZHdhcmUgYWNjZWxlcmF0b3INCi0gIFNIQTMgaHcgZW5naW5lIC0+IFNI
QTMgaGFyZHdhcmUgZW5naW5lDQoNClJlZ2FyZHMsDQpIYXJzaGENCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9y
Zz4NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMzAsIDIwMjEgNzo0NCBQTQ0KPiBUbzogSGFy
c2hhIEhhcnNoYSA8aGFyc2hhaEB4aWxpbnguY29tPjsgaGVyYmVydEBnb25kb3IuYXBhbmEub3Jn
LmF1OyBkYXZlbUBkYXZlbWxvZnQubmV0OyBsaW51eC1jcnlwdG9Admdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGls
aW54LmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgcm9iaCtkdEBr
ZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDYzogU2FyYXQgQ2hh
bmQgU2F2aXRhbGEgPHNhcmF0Y2hhQHhpbGlueC5jb20+OyBIYXJzaCBKYWluIDxoYXJzaGpAeGls
aW54LmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggNS82XSBjcnlwdG86IHhpbGlueDog
QWRkIFhpbGlueCBTSEEzIGRyaXZlcg0KPiANCj4gSGktLQ0KPiANCj4gT24gMTEvMzAvMjEgMDA6
NTQsIEhhcnNoYSB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8vS2NvbmZp
ZyBiL2RyaXZlcnMvY3J5cHRvL0tjb25maWcNCj4gPiBpbmRleCA1MTY5MGU3Li41ZGYyNTJlIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3J5cHRvL0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJz
L2NyeXB0by9LY29uZmlnDQo+ID4gQEAgLTc5Niw2ICs3OTYsMTYgQEAgY29uZmlnIENSWVBUT19E
RVZfWllOUU1QX0FFUw0KPiA+ICAJICBhY2NlbGVyYXRvci4gU2VsZWN0IHRoaXMgaWYgeW91IHdh
bnQgdG8gdXNlIHRoZSBaeW5xTVAgbW9kdWxlDQo+ID4gIAkgIGZvciBBRVMgYWxnb3JpdGhtcy4N
Cj4gPg0KPiA+ICtjb25maWcgQ1JZUFRPX0RFVl9aWU5RTVBfU0hBMw0KPiA+ICsJYm9vbCAiU3Vw
cG9ydCBmb3IgWGlsaW54IFp5bnFNUCBTSEEzIGh3IGFjY2VsZXJhdG9yIg0KPiANCj4gcy9ody9o
YXJkd2FyZS8NCj4gDQo+ID4gKwlkZXBlbmRzIG9uIEFSQ0hfWllOUU1QIHx8IENPTVBJTEVfVEVT
VA0KPiA+ICsJc2VsZWN0IENSWVBUT19TSEEzDQo+ID4gKwloZWxwDQo+ID4gKwkgIFhpbGlueCBa
eW5xTVAgaGFzIFNIQTMgZW5naW5lIHVzZWQgZm9yIHNlY3VyZSBoYXNoIGNhbGN1bGF0aW9uLg0K
PiA+ICsJICBUaGlzIGRyaXZlciBpbnRlcmZhY2VzIHdpdGggU0hBMyBodyBlbmdpbmUuDQo+IA0K
PiBzL2h3L2hhcmR3YXJlLw0KPiANCj4gPiArCSAgU2VsZWN0IHRoaXMgaWYgeW91IHdhbnQgdG8g
dXNlIHRoZSBaeW5xTVAgbW9kdWxlDQo+ID4gKwkgIGZvciBTSEEzIGhhc2ggY29tcHV0YXRpb24u
DQo+IA0KPiB0aGFua3MuDQo+IC0tDQo+IH5SYW5keQ0K
