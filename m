Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EE4466119
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345723AbhLBKHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:07:41 -0500
Received: from mail-eopbgr20063.outbound.protection.outlook.com ([40.107.2.63]:8563
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241191AbhLBKHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:07:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1mDHCk7Z1xah8C5EmQRs+ByfrK/f5ow3ZV2l1jYWiUuzNYuFzmJ2w5Cz41VFlzpf2odWSMtY+Ir8tPYj8StvfvTa1SnjpwQXgkOjErXwyPzf9Yo4ewKJh+hC9HMTZo7297/D8qTXO0/DzCWni2V8G0izjkI9101h2NEPI2gjCo0ztEx4WTGUBHZJiDeAxdw4Xri11e7X1Yw0dGCF4PhFFrFtN1XEyWiBsw7TX7ZJ6wwZfnfN2vSXT9eJDBq8Po/O0Mp0zhBtUT4iCGiIvdQSzHibGuGrMKgAaKVXvanq755JZ31y8/qLPibQqN32WMWM1pM/UpTWyY1zuNejg9BbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZJcjd5/jdKkaxcMoMeslNW/zlEXOJVr2+NCvxLAJmE=;
 b=VC7WVnw+61bvmfFGuosfNmgiQJWqrqbSYS7ZHsTaB3+F+753ypyFPSuieD/TZjOX+9jGSxqyS8xmsoFXZTQXaW+6pZv15vMvDhDk+JLIwFdZPys+N/xBNEq98RSbY81galQ7dRmH8VXvVefJKBprDjvlWZlOYD61M2TL6N28S8qfnQI7zNNLmeulzRrkEqK4ZsIcVXT1JKQ/OElfMFDQlnvYF+ZjPy+EniEqgz6xX1BtWzfwTlNa1aaQ8IM+4x/5u0Yv02TBEaRjJXPcKAiBDEw4aia+GvVnmS1VP+HfUtWiaCqahUeNzmCWei15m5DrNOHe4K4gSbpD/SIxhmJ7NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZJcjd5/jdKkaxcMoMeslNW/zlEXOJVr2+NCvxLAJmE=;
 b=Rcn8mALMdw26nNTgYyriupzBUiYvPUmiAK/UArGvNJ8pfJFmJ2VMl0yMwPvJylRjuBZVIzrQp/wqfV5O1KP13mr3v/oKHz7f7mlgByY0yAFPtH5r8JqYRQVXZ4fqdr/x4K94q7EMaPGV7JDGElRgWvr1gg7ece2KFsT8sEc1PYA=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS8PR04MB8387.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 2 Dec
 2021 10:03:43 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886%5]) with mapi id 15.20.4734.028; Thu, 2 Dec 2021
 10:03:43 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v13 03/13] media: amphion: add amphion vpu
 device driver
Thread-Topic: [EXT] Re: [PATCH v13 03/13] media: amphion: add amphion vpu
 device driver
Thread-Index: AQHX5c0HM1d4fqB1X0+Ozb3CqDuDbqwe9t2AgAAFHwA=
Date:   Thu, 2 Dec 2021 10:03:43 +0000
Message-ID: <AM6PR04MB63416A6B077EC70744EBCAADE7699@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1638263914.git.ming.qian@nxp.com>
 <b2219ccda94dd3149c6fa5bd9d5eb77084666ce4.1638263914.git.ming.qian@nxp.com>
 <ea6ed8cc-7f45-d7a6-8169-2b0c726ea3a3@xs4all.nl>
In-Reply-To: <ea6ed8cc-7f45-d7a6-8169-2b0c726ea3a3@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30f1642f-36f0-420e-c07b-08d9b57b0631
x-ms-traffictypediagnostic: AS8PR04MB8387:
x-microsoft-antispam-prvs: <AS8PR04MB838744DB35339BC4B93F5025E7699@AS8PR04MB8387.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rIdCRICldqC2+uH1I30jSHD6Qw7hd2Gr3fcOaJ1nRzeYo6NQmtiamVSf4QSxTDSliV0Wk21yTgdectBQzsO/36IKCRjJV8x0iUxDgtHfhHLm/y5Fil4jU4ktuUVp396nWYnH8LmDYlx71+bricfvkv9I89aSUjAW1nS5HspG7B1IZdpkzWCYPFeSkKQXP6ILp94tef+6/jlGc7zKuRA8K1WQQNaF9GTLkufLCoBE2QXna2R8FUK0l5fCgjRSsR10GEDG5PWOyP8pFG2varsMOvH1uFi4itsZ417PbmsSQstW6iMPP8U6EPQl12bUhPdeZPIzq9ARoDys+pK9JoChlBiFl97VPFVM3O+Dw2iEEYvhCoqFc+7gOQQv5XJzS+x8foaTf4dUUtCzbWic/uC4u8tQWlAh6eiv55YZPJtbWye+rLabyTMggsdF1Tr0j03NGsDtSatNxP+baLe7ZCpK2kW/xNFLekBfrIP9BKIxHrmR/o2ZljWP1Mw4P7iGAHp92eq7xnmAH1lG6N/rhoE3yySFRfI1QVAC3gfOHzPAA972L3qyOU8XukT5iC8IR3z3hlcMWrsQYAkPg8/wHj9v1OSBlNN2TNCFOQFLdEAHxG9Q+DxfxLoTmXQiS8jsDDWrjSk5umEsvnPl4t25WB1Z4cyhF9DTK7nKkMPqHohAA5Zzy4tvGV9pNoIJaoO6FL6nZkNBAzHGYgyJ9Nf9QollVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(26005)(86362001)(33656002)(186003)(6506007)(316002)(54906003)(71200400001)(5660300002)(53546011)(52536014)(110136005)(7696005)(38070700005)(122000001)(38100700002)(66446008)(44832011)(66556008)(66476007)(66946007)(64756008)(9686003)(2906002)(508600001)(4326008)(55016003)(7416002)(8676002)(8936002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2hEK212MC9haDZ2U3RXa1g0cG5WNms2S3lVSS9yTVlZYlJvcVNFWTlBN0sv?=
 =?utf-8?B?dTAzTmI1Q0VWb1FBNWxJb0xOQWVkbHpCalA3SVVRbUdZeklUMzBkZ0tPOUtz?=
 =?utf-8?B?bFhjWEw1UTE3c1dKN0NyRVN1cnN1MGlnbldoL0xheXp6UC9udEVnNUNuTzNh?=
 =?utf-8?B?R0hZMjg3ckJEMnJHWkRNdS9ZMXlQQTlteDRaMjA5aFU2SjFCWjNnZGdhTC90?=
 =?utf-8?B?djRZY0VucktHWllweWxLeG1wcDVXVGNyUFRpdWNFbmxQSWdCVVhmeUgrOFdM?=
 =?utf-8?B?RG1yaDlSN3k0TDc0cjFhUFRFMTBrL2FSNTdzRElEL3Nxc1N3d3hrRTQrS21J?=
 =?utf-8?B?QzBTZjJwaURaODdOVlhJZERtUkVvYkhjenNWVXV5bTUxTHI1TWt6Qm94dktW?=
 =?utf-8?B?VjNaK1Z0c2ZZS2Q0MXZYTUc3N3BlcE05TU0xRGgwYmVNTndHK2lkUTF4OUJz?=
 =?utf-8?B?d0pJb2VFYUt1TjZGOGxrWk5jUDFpVVRGT0JzWU55Y0tIMU02alFzNmV2SlNZ?=
 =?utf-8?B?MnZHQ3FQalMwUTRLcWpYVmR4Q25kaHliNW1EY1B1WmFqRXVtTWhUWDV5cDJw?=
 =?utf-8?B?dzQvayt0V2NIN2x5YkhaSkc4STdNd1VudWM3NlQ3eStXMHZ6aWxjQWtIVDlk?=
 =?utf-8?B?UU9ncHdiMldPQlVZeXkvekR3QUxsQ3Z5UVhWRlV5VURZWUdxdHhKeDc0d1ht?=
 =?utf-8?B?aHlzNUw5cndIcHBXcDJVRStQSk9kTENCZTBuaU1YSjE1Wkx0dks0SEJmYWtn?=
 =?utf-8?B?ZUk5N2lMZWRheXhQSTB3b3pnT0ZORHNRNm1sMCsrUE1FWlVDVlo3UHBNdWVy?=
 =?utf-8?B?eXkwaTNxbzl2Vy84SDR0ZHpkSVMxN0srZUtVZGRwV3ZyNVJQNlFiSXhZQmd5?=
 =?utf-8?B?OU1RTTJDSlhKNVBWQmUySi9TU1psb1Zrc0YzR1RxNFFtRkhUWE9oclpoNWRW?=
 =?utf-8?B?ZTZvbytaOHJEQkJ4SDMrMUxsTElxeDlZTTdhOWRWLzVYazRTcytTNVhSejhC?=
 =?utf-8?B?UFh6NTBIM01vT1Mwam5tWUp3QU02dTR6VTUwT2ZRdjg5MGd3d3JkbG5XSjZk?=
 =?utf-8?B?KzN1WUI2SVUxVmtsUEE0bVlVN2RJbStMSWVvK2JZMVA4YllubTYwcVNKWXpL?=
 =?utf-8?B?MWg3VkZURjBnMVg5TUVOdEIwQzJpRjN4TjhzQmFlZCtDYUlieXM4YlE3OGIz?=
 =?utf-8?B?OURLc1BzemVoVXNVSGMyTWJwOGQ0dFN2MWh1N00wM2ZRajEzNitLV1pPVE10?=
 =?utf-8?B?K2ZMcTJtamhURG0vcVFNWG5NcW5qajZlZlVvbWdxTUcvSVhtbHpTNVVtdnVy?=
 =?utf-8?B?RjVibUo0aC95ZHd2dTVmRURubTZFTHJkUUE2Z0c0ektkZnV3RFhNRkJxMnNK?=
 =?utf-8?B?S3VRUldBRHdNSHd5TFE1RS8vcVQrZUVLYlpyeklKTGQ2UFdGSXdFUVlEMzMw?=
 =?utf-8?B?OGdHOEpJTHJzdWRObEoyTkZ2aW44RGx0dFNFdFpuR2pSY1UzUVd1ZHZ3T09n?=
 =?utf-8?B?TXpSY2JJRGs5eDFMQ3AyZGEyMlJXcWhrVDZhMnVxUFNRRVNndk95NEEvQWo2?=
 =?utf-8?B?LzIyTUp3Nlo0c3FUK3RZb2hhM0Uvblh4bXFndko2Y29sWWZZYmJGOE9mUHpD?=
 =?utf-8?B?MkpNOHpqeERXQUdIbmJ0eXpuMVVpd3RXRFFaNVRuVXcxeTdPUWZvejdWcldG?=
 =?utf-8?B?ZDlnY3UyNWNlR2NsOFVYSExsSGJrRUdxcUY3QjFxTWtxTmh6TEw0eit2SkFu?=
 =?utf-8?B?VjN0YjhUTXBtSEptU3hhQ0Jvd25NTEUvVEhtSkZsbnJ2V2RnNTd4cWd1WU9t?=
 =?utf-8?B?bm1HYjAxT2ZzbEdoUUhsdnJCOWc5bzNwbU91UkxpUWF5QlluNFRXQ25ub2Nv?=
 =?utf-8?B?eUg5VENvVzlheTZNQW1XRDJOb3pxbnkxb3hmZ2Jma0NIbnBDZGMrczMzV1dt?=
 =?utf-8?B?MUJKbWtWZTE0MFhMSUJlOStHMlhxdzlCYy9RMzRLSTBGV0U1ZWcydkNuN3Zv?=
 =?utf-8?B?eHl4bExOaWJrNGV4c0RpVTB0SmtZbGx1cDYwbnYyUnVUdDY4d1BZcmJYU3dH?=
 =?utf-8?B?RzNlWTBiMzZGU1VzSm5kNW9rZUxSNXU2U0VldFY1UGxiVFkzc1pRVjJZalMy?=
 =?utf-8?B?OE1vQWJPNE4ybG1adnNUSDkvNU55YVFIK3hUTzFkaHAyM0xoZTBTbjZqSytq?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f1642f-36f0-420e-c07b-08d9b57b0631
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 10:03:43.7775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Lp7Ri1DsMmfIi6EAkr+4ClDSsqIAhzruOGV78hlkKjajeWAsTIZSTHbJeR7hPazkiwXvnB6EhWozHu7rV2SHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8387
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5zIFZlcmt1aWwgW21haWx0
bzpodmVya3VpbC1jaXNjb0B4czRhbGwubmxdDQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAy
LCAyMDIxIDU6NDUgUE0NCj4gVG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+OyBtY2hl
aGFiQGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9y
Zzsgcy5oYXVlckBwZW5ndXRyb25peC5kZQ0KPiBDYzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBm
ZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBB
aXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsNCj4gbGludXgtbWVkaWFAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1
YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjEzIDAzLzEzXSBtZWRpYTogYW1waGlvbjogYWRkIGFt
cGhpb24gdnB1DQo+IGRldmljZSBkcml2ZXINCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiAN
Cj4gT24gMzAvMTEvMjAyMSAxMDo0OCwgTWluZyBRaWFuIHdyb3RlOg0KPiA+IFRoZSBhbXBoaW9u
IHZwdSBjb2RlYyBpcCBjb250YWlucyBlbmNvZGVyIGFuZCBkZWNvZGVyLg0KPiA+IFdpbmRzb3Ig
aXMgdGhlIGVuY29kZXIsIGl0IHN1cHBvcnRzIHRvIGVuY29kZSBILjI2NC4NCj4gPiBNYWxvbmUg
aXMgdGhlIGRlY29kZXIsIGl0IGZlYXR1cmVzIGEgcG93ZXJmdWwgdmlkZW8gcHJvY2Vzc2luZyB1
bml0DQo+ID4gYWJsZSB0byBkZWNvZGUgbWFueSBmb3JhbXRzLA0KPiANCj4gZm9yYW10cyAtPiBm
b3JtYXRzDQo+IA0KPiA+IHN1Y2ggYXMgSC4yNjQsIEhFVkMsIGFuZCBvdGhlciBmb3JhbXRzLg0K
PiANCj4gZGl0dG8NCj4gDQoNCkdvdCBpdCwgSSdsbCBmaXggaXQNCg0KPiA+DQo+ID4gVGhpcyBE
cml2ZXIgaXMgZm9yIHRoaXMgSVAgdGhhdCBpcyBiYXNlZCBvbiB0aGUgdjRsMiBtZW0ybWVtIGZy
YW1ld29yay4NCj4gPg0KPiA+IFN1cHBvcnRlZCBTb0NzIGFyZTogSU1YOFFYUCwgSU1YOFFNDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFNoaWppZSBRaW4gPHNoaWppZS5xaW5AbnhwLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBaaG91IFBlbmcgPGVhZ2xlLnpob3VAbnhwLmNvbT4NCj4gPiBSZXBvcnRlZC1i
eToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gv
YXJtNjQvY29uZmlncy9kZWZjb25maWcgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vS2NvbmZpZyAgICAgICAgICAgICB8ICAxOSArKw0KPiA+ICBkcml2
ZXJzL21lZGlhL3BsYXRmb3JtL01ha2VmaWxlICAgICAgICAgICAgfCAgIDIgKw0KPiA+ICBkcml2
ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vTWFrZWZpbGUgICAgfCAgMjAgKysNCj4gPiAgZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdS5oICAgICAgIHwgMzU3DQo+ICsrKysrKysr
KysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X2Rl
ZnMuaCAgfCAxODYgKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBo
aW9uL3ZwdV9kcnYuYyAgIHwgMjY1ICsrKysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL21lZGlh
L3BsYXRmb3JtL2FtcGhpb24vdnB1X2lteDhxLmMgfCAyNzEgKysrKysrKysrKysrKysrKw0KPiA+
IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfaW14OHEuaCB8IDExNiArKysrKysr
DQo+ID4gIDkgZmlsZXMgY2hhbmdlZCwgMTIzNyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vTWFrZWZpbGUNCj4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHUuaA0K
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3Zw
dV9kZWZzLmgNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0v
YW1waGlvbi92cHVfZHJ2LmMNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vYW1waGlvbi92cHVfaW14OHEuYw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9pbXg4cS5oDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZw0KPiA+IGIvYXJjaC9hcm02NC9jb25m
aWdzL2RlZmNvbmZpZyBpbmRleCBmMmUyYjliZGQ3MDIuLmNjMzYzMzExMmYzZiAxMDA2NDQNCj4g
PiAtLS0gYS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQo+ID4gKysrIGIvYXJjaC9hcm02
NC9jb25maWdzL2RlZmNvbmZpZw0KPiA+IEBAIC02NTcsNiArNjU3LDcgQEAgQ09ORklHX1Y0TF9Q
TEFURk9STV9EUklWRVJTPXkNCj4gPiBDT05GSUdfVklERU9fUkNBUl9DU0kyPW0gIENPTkZJR19W
SURFT19SQ0FSX1ZJTj1tDQo+ID4gQ09ORklHX1ZJREVPX1NVTjZJX0NTST1tDQo+ID4gK0NPTkZJ
R19WSURFT19BTVBISU9OX1ZQVT1tDQo+ID4gIENPTkZJR19WNExfTUVNMk1FTV9EUklWRVJTPXkN
Cj4gPiAgQ09ORklHX1ZJREVPX1NBTVNVTkdfUzVQX0pQRUc9bQ0KPiA+ICBDT05GSUdfVklERU9f
U0FNU1VOR19TNVBfTUZDPW0NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9LY29uZmlnDQo+ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL0tjb25maWcgaW5kZXggOWZi
ZGJhMGZkMWU3Li43ZDRhOGNkNTJhOWUNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL0tj
b25maWcNCj4gPiBAQCAtMjE2LDYgKzIxNiwyNSBAQCBjb25maWcgVklERU9fUkNBUl9JU1ANCj4g
PiAgICAgICAgIFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhl
cmU6IHRoZQ0KPiA+ICAgICAgICAgbW9kdWxlIHdpbGwgYmUgY2FsbGVkIHJjYXItaXNwLg0KPiA+
DQo+ID4gK2NvbmZpZyBWSURFT19BTVBISU9OX1ZQVQ0KPiA+ICsgICAgIHRyaXN0YXRlICJBbXBo
aW9uIFZQVShWaWRlbyBQcm9jZXNzaW5nIFVuaXQpIENvZGVjIElQIg0KPiANCj4gQWRkIHNwYWNl
IGJlZm9yZSAoDQo+IA0KPiA+ICsgICAgIGRlcGVuZHMgb24gQVJDSF9NWEMNCj4gDQo+IEFkZDog
fHwgQ09NUElMRV9URVNUDQo+IA0KPiBJdCBzaG91bGQgYWx3YXlzIGJlIHBvc3NpYmxlIHRvIGNv
bXBpbGUgdGVzdCBkcml2ZXJzLCBldmVuIG9uIG90aGVyDQo+IGFyY2hpdGVjdHVyZXMuDQo+IA0K
PiA+ICsgICAgIGRlcGVuZHMgb24gTUVESUFfU1VQUE9SVA0KPiA+ICsgICAgIGRlcGVuZHMgb24g
VklERU9fREVWDQo+ID4gKyAgICAgZGVwZW5kcyBvbiBWSURFT19WNEwyDQo+ID4gKyAgICAgc2Vs
ZWN0IE1FRElBX0NPTlRST0xMRVINCj4gPiArICAgICBzZWxlY3QgVjRMMl9NRU0yTUVNX0RFVg0K
PiA+ICsgICAgIHNlbGVjdCBWSURFT0JVRjJfRE1BX0NPTlRJRw0KPiA+ICsgICAgIHNlbGVjdCBW
SURFT0JVRjJfVk1BTExPQw0KPiA+ICsgICAgIGhlbHANCj4gPiArICAgICAgIEFtcGhpb24gVlBV
IENvZGVjIElQIGNvbnRhaW5zIHR3byBwYXJ0czogV2luZHNvciBhbmQgTWFsb25lLg0KPiA+ICsg
ICAgICAgV2luZHNvciBpcyBlbmNvZGVyIHRoYXQgc3VwcG9ydHMgSC4yNjQsIGFuZCBNYWxvbmUg
aXMgZGVjb2Rlcg0KPiA+ICsgICAgICAgdGhhdCBzdXBwb3J0cyBILjI2NCwgSEVWQywgYW5kIG90
aGVyIHZpZGVvIGZvcm1hdHMuDQo+ID4gKyAgICAgICBUaGlzIGlzIGEgVjRMMiBkcml2ZXIgZm9y
IE5YUCBNWEMgOFEgdmlkZW8gYWNjZWxlcmF0b3IgaGFyZHdhcmUuDQo+ID4gKyAgICAgICBJdCBh
Y2NlbGVyYXRlcyBlbmNvZGluZyBhbmQgZGVjb2Rpbmcgb3BlcmF0aW9ucyBvbg0KPiA+ICsgICAg
ICAgdmFyaW91cyBOWFAgU29Dcy4NCj4gPiArICAgICAgIFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIg
YXMgYSBtb2R1bGUgY2hvb3NlIG0gaGVyZS4NCj4gPiArDQo+ID4gIGVuZGlmICMgVjRMX1BMQVRG
T1JNX0RSSVZFUlMNCj4gPg0KPiA+ICBtZW51Y29uZmlnIFY0TF9NRU0yTUVNX0RSSVZFUlMNCj4g
DQo+IFJlZ2FyZHMsDQo+IA0KPiAgICAgICAgIEhhbnMNCg==
