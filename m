Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7949C485E88
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344669AbiAFCTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:19:37 -0500
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:12896
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344673AbiAFCT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:19:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/DYsAHRUI//G+wW4dVG6+qQBiZN/cTqheA9z419tS7LTBZMQozGl0vdNbeCMlUapCwBHoGtF4Hu6p83qAQZob92a22/s3+eZmhNMjCSURqqkWo1NkU4rQsZk2JrtWwuvjZyXQhPRHjfKXPpiFLn0yajoyLg6N556XKr1t2JNM46i8cnos7hGCvGNan8j3+RYZTt/TLJ0Y/IQUGnWDX/1rY84tArmnVjBLBwyFp+ZiSHmtiAKG7f77yIzvq0RxYPZLWDMFlVhbzia9oFsRRPvfqU8MKSmLyXMFWtuAd3D8zpGgIbZG8trKiZ09gFfL1eSgzglQb3EAG+t7VCMLXOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8s9q2NUUcDqoyect10ywmfsq4I4TgFLm+tQLlsnNQU0=;
 b=ikcz4aM9vqAiMdKzrNI9izekFV5zL5g3mg9QOJk/wNMIb8b4iOu/jjuZ27A1S/+8pj8uJnTEd06KHifAhQPkSQuBs4cn/O0Y35K/L+I1iv4obbJ91PAyVBd0P09DDcpK4z9/TnriWyd3N8um4qYwQDGSL8ovUbdgXJJOojQn5NgVhAwo8LrxITSqfao+bJb4pOwwOUtNf954x32I8xQvWBH7w6+60/BKtQkKf0OFLmxuJ/9WIcCqZ8LN14+WQ+qHEyLx/XJmfS1EK+dy6WbM2yMdZaJo5Q3Lhmsu0j64F7O6RMjcUTanSxBi6y7gPkime5VwmExJTqsCgHyWPEkU7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8s9q2NUUcDqoyect10ywmfsq4I4TgFLm+tQLlsnNQU0=;
 b=ohuTbOtKgjRHkrKR5z3KOaJFEMTFdDxsWcFPN3ttWEA+aQGaERhyo4vQTQT8exo6lE9lFUKnrL+St0ojUqXIEx+G5ZHiKLKI+twMbP6/vKRrhjFk+pOIcS5vtGfDparkX+oNEmhoBIT+xoDOUDieO+qWhlr0x8Xihg4xGTZfqZE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8448.eurprd04.prod.outlook.com (2603:10a6:10:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 02:19:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4844.015; Thu, 6 Jan 2022
 02:19:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH] clk: bulk: export of_clk_bulk_get_all
Thread-Topic: [PATCH] clk: bulk: export of_clk_bulk_get_all
Thread-Index: AQHX9hlLGq7mfLFGr0Wx+V0fpTJ58qxVShYAgAARAAA=
Date:   Thu, 6 Jan 2022 02:19:26 +0000
Message-ID: <DU0PR04MB94178D129447A487FB6AB3D3884C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20211221031638.3499920-1-peng.fan@oss.nxp.com>
 <20220106011718.28688C36AE3@smtp.kernel.org>
In-Reply-To: <20220106011718.28688C36AE3@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1eba70a1-4cb1-4b36-a1b3-08d9d0baf67c
x-ms-traffictypediagnostic: DB9PR04MB8448:EE_
x-microsoft-antispam-prvs: <DB9PR04MB8448D19973EE66A3CC40F299884C9@DB9PR04MB8448.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8OOLSZsmvQgoGW3dcUSrqbC0fupUhdSg2I0y+n7Sb7+LHU4EYpZ3PsdDlHj+MnbHaMONH+7fyHlBlce95qYRtlFUTVP5yQ3aPLyQiuChNXF+IKzkIuQ0PHpYMakVp/2Ld6kjFJ382d2Ugjnkucv03d5EsLUFJNUs6bv1dQ1yk3GqnwKJ+CrE4sK1ssJnDYgrrbTqWd1pXV1yXK2BDkD5TnSFRCFTL29kxWENM6/VE6975J8PhQ2PeJdhRCK8uhgI2DmDLu8hXl+NoSEEN97XxmUd7++WB+gfFLLjc3MTKMgl9jez7jeFN3FKgh7/Rx3D2EB1U+U8pGNUn9SIAibVC3O3kog/gw1ghyXbdcUkcMMROk1K6itJzveSOvyCCUgXF7LzCkgrhnhXEKRs6BVAxWCOQLJKGLCKgP/uz7xpXfPsuxk9XbIQPcvtMMc37dOh5YK7VzB5czARUCIRqMuHJKuU0rXD7298nwNzKvgH7wt0wdA+H0DXbyySKk0XHw0t1tWQAghJZIoL0lcCZQunLax0hOFHodAUctnlYKQ1DDHDdvo6Nm79vuQm67/wZtyShbXspt05g5bVI7nYiAZyp3fpPwy7qogP8VBvFB7oiv5fdSFG2FtO7ul3P7FKxxPexJOl8g5L+cHLTmlH2czVrRHXo6uaEfoknM2v9M3NguXy9GdyceMLXtr8f3IHX9y3Vy57Q+OlnT1ETMLOb/3bOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66476007)(66946007)(52536014)(66446008)(64756008)(66556008)(44832011)(55016003)(83380400001)(316002)(122000001)(38100700002)(9686003)(4744005)(8936002)(7696005)(71200400001)(4001150100001)(186003)(33656002)(26005)(6506007)(508600001)(8676002)(38070700005)(4326008)(5660300002)(2906002)(86362001)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmI2L1NwUyt2SUtjdnlKNlhsWGdLMmMvR0lHSzR0eXVnU1FOeVFGL2ZzeEY0?=
 =?utf-8?B?ODFtcDZVdXZRTzZVUWpaK25mcWZpQmFabUx1cHBiTDFCL2VhdFpodGRkeklQ?=
 =?utf-8?B?aFZ1bW9Rb0UyVjQvY2tJR0V1TW9BR3pycmJMYkJUNzdTMkFuQmkvMmZOZmR6?=
 =?utf-8?B?MU52OW1uVisyVnlCMnYwYk5zMlRLYkx5dkJqOHg4c0pVVkhWQzN3WVFsZkVq?=
 =?utf-8?B?Z2pGdTBmK1pUYndvVVhKZE41T0dFbitlcEVyaUpYZnYweHRwR1pFRm1oTEFw?=
 =?utf-8?B?MGNpd3VrT3p1Ry83N0UzM3VXaU12UzV6ZXhwd0xaNld2MmVuSDM0UFBSKysv?=
 =?utf-8?B?MWhNNFMvSVUwK202YmVCVEFvdXRrL2ZUc3NCSldOL0lNVkZ6d29VUk83Q1BY?=
 =?utf-8?B?NUE5c2JNWlU5clAzWjQ4ckJ3aGNnOEtuWi9pUzlxWERWS29Jd2lWblgzZlNQ?=
 =?utf-8?B?TUFYc1BIRFE1Nzc3dGlDaDk3V0pjYzdDVEVTOFdyUEtDKzAwSHVRZ25LbGV3?=
 =?utf-8?B?Rm1LSUpITlFPeERyMEg4UVVkVlNaZWRWMXNMQ3JESTJJRmIvOFJFbEw0YjJM?=
 =?utf-8?B?NCtycWtNWWhIL0lmSFc1QjltVFNRTVBDaVRWSE1ILy95Z1FqdDF4QlJHWjkz?=
 =?utf-8?B?alh6dmNwaC9tWjNGeXErdlBsOURIWHB2c0lDeWJ0clhqV1p2WUYrS0pqYVRG?=
 =?utf-8?B?VzFIUnhaczRxeDBJQkJhckxJYXhyVWYwRS9sMGR3ZkFnaFRPb2ZvUmtiZnBQ?=
 =?utf-8?B?TkozSnZ2RUdmaXlIb2ZBQTJ2OEZCTVlnVmpzUlBQK3BFWEVldmJKMS9DZWNr?=
 =?utf-8?B?ZnIzMjd5SWNwelB1eUF0VzVTVXFrZ1ZRV0ozbjJxRGhUZ2Z2TWF4dkhZWjUv?=
 =?utf-8?B?eFl6aXJoSW9UNmYwT2xpYmRiKzQ2TThlN3VMRzFTVy9qcFVrTmFONjNZc2RF?=
 =?utf-8?B?RFV4OE81eWFTaEJGU0cyT0dEUTQxOEY2K2xVdjdUOEYxQVRBK1ZZa3lBM3Qz?=
 =?utf-8?B?WHVsUzBiYW1wSStuOCtPajNIbm5ITy9PU29NTEFXNXVyd00vSEdXanZQK2lS?=
 =?utf-8?B?WVZ4dDJhbWtyaE10RTNtQlFYVWNHUFNUOFVNS29nY2g2K2R2N0ZSL3dZcG41?=
 =?utf-8?B?U2lxYWR1TEVCb2dFcStqZ09xUGlYVmtKelR6K2ljVlR1OHVZd05oNjAxYWx0?=
 =?utf-8?B?SS9lMTA1MHA0Zy84VFlHZFNoRWVyQ1NsaWtLMTdjaUdvWDBjQ2dJOG9vZjdq?=
 =?utf-8?B?Tm5UWVFtdjF0ditOQUtEQkU0RzNuRHpzN3BjelJiTUhLc3RzNTdYaWpZMlB4?=
 =?utf-8?B?VUdIWE8yRFZQVk5IckRSN3ZHTEgzdUY2WS9KUGx1N0RGSTVTc1NTeU9Ec2Q4?=
 =?utf-8?B?VDFVMnZuVlNjQkVjSHkyQjJ2aEI1UHBYenNHUi8yV2o4TU9IRExsTmhsUFZR?=
 =?utf-8?B?c1JvK0I1NWNMb2txVVZKZTJ1blJCaXM5UW5YZjdETFYrNm1IZDNvT1dITkR0?=
 =?utf-8?B?aTZIOVJZWjhMOVJtY00vNHNqdVBFQzNhOVZnYVZqd0wxd3BZQ3FZcnNxb3gw?=
 =?utf-8?B?L0dJWExQQ3pXd0xQcnNYeHhzZjdmdEtPRDhiUDhCR0pLcUF5ZTgrOTlvL3Rp?=
 =?utf-8?B?dDFDMXM3TTVjV0RVSXZkdmZ6ZHozcWVBZy9MdFlZN0g3RUF3dytmZ0xXTkNN?=
 =?utf-8?B?MXhHTVdBR2p3bU5HVmVzbFdiMDZvcWQxbVphaUFtSHJscWR2WHhTaS9vZ0Vl?=
 =?utf-8?B?WlFSM0FoL29xblJmZDFzcWVHRk9oUnlSdVBSdDJxbHNpWForUmZwQXQrakJr?=
 =?utf-8?B?eDcrYmM1RlJ0QllmcEtKTlhYSzlIc0p4NU1aRDJKeU1KTVBXOXNXMDhHRExB?=
 =?utf-8?B?eG55aVVmeU96WkdEU0xzZXFhdzd3dFZQL1pITitFYjQ5cjBSK2xPZFhod0dh?=
 =?utf-8?B?b0F3MDZwSkJQQlh3dnNHNk9hVHFmdG9RMWR6Q2Zrb2ZZU3V2NmU3RFowSnlO?=
 =?utf-8?B?amw4SkN3VUh0UVp6REIyUXoyNTVlendQQjYxQzQ2Yyt1ekhrNzlPNytsdWN5?=
 =?utf-8?B?czhvaVNSaDArdFZmcGVKNGtZMlNvOEpoM2YrSmJHMEpkS3ZkU1U1MEsyaHU5?=
 =?utf-8?B?Mnp2Rkc5TUJCa0d0bVpCdldUWCsrNnJJMzM3eGlsSHBvOFV3a0pFa0pHRVZo?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eba70a1-4cb1-4b36-a1b3-08d9d0baf67c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 02:19:26.6544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zpgGnqqLiprFHk7pKAwP6h0E8DEDx8GD9+fMdBiqs2HS0O9txKHZFUQf4r/5mRc59UkQNiHkAxatrjccdvubCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8448
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbGs6IGJ1bGs6IGV4cG9ydCBvZl9jbGtfYnVsa19nZXRf
YWxsDQo+IA0KPiBRdW90aW5nIFBlbmcgRmFuIChPU1MpICgyMDIxLTEyLTIwIDE5OjE2OjM4KQ0K
PiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gVGhlcmUgYXJl
IGNhc2VzIHRoYXQgbmVlZCB0byBnZXQgdGhlIGJ1bGsgY2xrcyBvZiBhIGRldmljZV9ub2RlIHdo
aWNoDQo+ID4gbm90IGhhcyBkZXZpY2UgY3JlYXRlZCwgc28gZXhwb3J0IG9mX2Nsa19idWxrX2dl
dF9hbGwgdG8gbGV0IGNvbnN1bWVycw0KPiA+IGNvdWxkIHVzZSBpdC4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+DQo+ID4g
VjE6DQo+ID4gICAgICBBbiBleGFtcGxlIGhlcmUsIG1lZGlhbWl4IG5vZGUgaGFzIGNsb2NrcyBw
cm9wZXJ0eSwgYnV0IGl0IHdpbGwNCj4gPiBub3QNCj4gDQo+IFNvcnJ5IEkgZG9uJ3QgZ2V0IHRo
ZSBleGFtcGxlLiBXaGF0IGRvZXMgYSBEVCBzbmlwcGV0IGhhdmUgdG8gZG8gd2l0aA0KPiBtb2R1
bGFyIGtlcm5lbCBjb2RlPyBXaGF0IHNwZWNpZmljIGtlcm5lbCBtb2R1bGUgaXMgY2FsbGluZyB0
aGlzIEFQST8NCj4gDQo+ID4gICAgICBoYXZlIGRldmljZSBvZiBpdCwgc28gd2UgbmVlZCBvZl9Y
IGFwaSB0byBnZXQgdGhlIGNsa3MuDQo+ID4gICAgICBzcmM6IHNyY0AweDMwMzkwMDAwIHsNCj4g
PiAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14W1hdLXNyYyI7DQo+ID4gICAgICAgICAg
IHJlZyA9IDwweDMwMzkwMDAwIDB4MTAwMDA+Ow0KPiA+DQo+ID4gICAgICAgICAgIHNsaWNlIHsN
Cj4gDQo+IElzIHRoaXMgdXBzdHJlYW0/DQoNCk5vdCBwb3N0ZWQgdG8gY29tbXVuaXR5IHlldC4g
SSdsbCBwb3N0IHRoYXQgcGF0Y2ggdG8gc2hvdyB0aGUgdXNhZ2UuDQoNClRoYW5rcywNClBlbmcu
DQoNCj4gDQo+ID4gICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICAg
ICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPg0KPiA+ICAgICAgICAgICAgICAg
ICBtZWRpYW1peDogc2xpY2VAMjQwMCB7DQo+ID4gICAgICAgICAgICAgICAgICAgIHJlZyA9IDxJ
TVg5M19QT1dFUl9ET01BSU5fTUVESUFNSVg+Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAjcG93
ZXItZG9tYWluLWNlbGxzID0gPDA+Ow0K
