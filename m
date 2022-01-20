Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4109494715
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 07:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358643AbiATGD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 01:03:57 -0500
Received: from mail-sgaapc01on2111.outbound.protection.outlook.com ([40.107.215.111]:1729
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230385AbiATGD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 01:03:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Riuw8SA1IBkJ8btlu52YoiqZGXk+XuWTclUeFUeN/3GoIFPd/jQriRbwCdf2la9w4Wyro6Krl7SCD4zIPZgnYcX2sn2GKT4h79a3UWXB7dcytDct86BRKUWLy/isJZ4uiC5uemYhdbyElI2KNKjK3Asi7l6sxhwGCb/qXJgynUWcirDQpbAPwA8dEim+l6if4YwCIYRNEb3GMlpNCFFR/8+NyCVcnt2EPZFi8cSFxuYBRtsxnDa6ioEIUnF0/LNdMEuv0fJh7iw4jwTCYvhKmMsD+j+zmjTEKSgZZMiXHD//w78qbOcKUTE9EKskxaMwFnOUkCGZMh0vGV+gZAfhJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4K4rE9YDQYPscv0eKea4uAdu2Vtmctj+dZOdkNdjs8=;
 b=Igq3W6pWV7CBzDnf9K4WaQ2OutfHmpxxgwRdQMQvmBYmnmGNJsLHtPVdn69k0tUxqRcLDVEhxDRmOdnOVoWiabQLxefRtSLwMNqRR3eCMM3gVtnEOTD2bRAwRKluB9bj48coqad3NlfhBMZ15r2OJn1WXUJj1Pb9lfH9wCHsua6ok2vDpMnPOMLvoZFyh02E9LQPsEW5j0kQvQ0T0LQda3w2kMzY0v/pjYYDt+XPSCIL7KIXx1DvHCyvY2l59Jd9GOAMQ2Zk+hs6Bqc4CFspmgm37Gwv/slJMQG1g8BZG0C/yPFKovHe5IQx6DdNnuobpkGpWj54r9vmc/rugJNxsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4K4rE9YDQYPscv0eKea4uAdu2Vtmctj+dZOdkNdjs8=;
 b=XJPpyZw0/kiImcCIC85Kg7FOchwXKUcWpBfBNC1blAy/FyAnKCKa7x3ZIrD2h1Bj1vj2dgq45zUt1KFDb28P23JlI6sEOyC3mWR3+EUHbajWsjU/MOqvyiGdSI28+UYBwMOp89+TlnOwJSo1ay6cW50shBrZ5/ka3IAVuRiry/4FpA1VHl56VP/+g72p6Qh8ouHqIz+ffXeyX/QufmpRJr0OEKCV/iP/SDx9OJs0IKZwz8QsQCKYf+mvp+B+IraIKyGh/XQ6ZUKMyD+eVK4UhLDF0pAtPDZY9pjiDieekyGC0iVadoFSqrh69yNxT5+sSjs0SDq5sCfpy7ahqARMfA==
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com (2603:1096:203:b8::10)
 by HK0PR06MB2180.apcprd06.prod.outlook.com (2603:1096:203:4e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 06:03:52 +0000
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::c963:5e43:78ba:f666]) by HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::c963:5e43:78ba:f666%6]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 06:03:52 +0000
From:   ChiaWei Wang <chiawei_wang@aspeedtech.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Joel Stanley <joel@jms.id.au>
CC:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Oskar Senft <osk@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: build warning after merge of the arm-soc tree
Thread-Topic: linux-next: build warning after merge of the arm-soc tree
Thread-Index: AQHYDaz3Zlb9Dh2vtk+CyrpVJiCrJ6xraSFA
Date:   Thu, 20 Jan 2022 06:03:51 +0000
Message-ID: <HK0PR06MB37791E63C4F75BF22B6AB715915A9@HK0PR06MB3779.apcprd06.prod.outlook.com>
References: <20211026103939.136dc73b@canb.auug.org.au>
        <CACPK8XfS+Gy1dhL-_uWKhW1D4++6LdWM-SdXtnsEV15OUhiK1w@mail.gmail.com>
 <20220120142220.1717e755@canb.auug.org.au>
In-Reply-To: <20220120142220.1717e755@canb.auug.org.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 191e39c8-42f9-4719-977c-08d9dbdaa24e
x-ms-traffictypediagnostic: HK0PR06MB2180:EE_
x-microsoft-antispam-prvs: <HK0PR06MB2180E2D448E831F15F19AB8D915A9@HK0PR06MB2180.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:288;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gaa8HHn9CNGyD/HStfKakkVA/FPcO61iVzrLM2YK6mCtMmguOuhRwGmHN9i+71SXrM6MA+1gO1h6n3XOH4wb1yxGnOGquX1hjoO5tgUMapEHC4LhYJPDwIB6d8LVjizW08/kmNaH1QJDUg6OHlDhtrfG3VRXokMj9RNnn6XU8QGNNtPaatTBjEc+aF7tcdLXFUgY+O15ZmW1d62L/Q11WNwfsOnvnQGgeZ5eMvQTQC5LouBie7t3YfEzS4C5NJHyw77YYxR6HmFnpqsUPMwewCaHOMRL7PSUbAwgWf9sFOg6bHU7UaWPVE5pO8Al7R6Y8/sJy+De/P+K04qYRQ2twasgi/qolJXb4Tu4BrrSQONNdtFgv/XfMjxM+Xu0n4Nc3eOb7xV9zeWItkPTF9cdHyQ+nhbbXlXJJnbEwQcNyqeupSjrDFR8S6UTiRZM0roazVHrdlrnbT+IfaS9rx1mXPcR/QM6inaPUGzlusdG/8y132N926gE1dRva4opoLLm1N7yeg9vWZmK+gFc6XM649xrEXMuZItk86D1xIeisXhyYGY8FnsxY1RIoj+Y/TN6TWELsbtyuEd7ZenzPXF9R33txaeguWZOstLx6t/Z8KsRu3H2S6FET/vLK8LRw7JqTpiQZVi6A8shse878vOd8jfDoFuR/BAI8nPxqS7+pmk+IALmMoEYmA3OloG0x9lP48ZszVewRZf2dfzUAZEX7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3779.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(396003)(39840400004)(38070700005)(52536014)(4744005)(9686003)(64756008)(66446008)(5660300002)(508600001)(8936002)(4326008)(66946007)(26005)(186003)(8676002)(33656002)(66476007)(55016003)(66556008)(7696005)(71200400001)(76116006)(2906002)(122000001)(54906003)(316002)(86362001)(110136005)(38100700002)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVRRNjEwWm14ZXY0OG1xWk9FZEthTlF3QnluZmNxUGdNM0hkTEpWRUxOMVBi?=
 =?utf-8?B?dG5BL0QwMEtDelR6Q2oycXZ1UGorSXhDelE5WVpLamtYUkFUM05BVEFkVjlW?=
 =?utf-8?B?OHF1ek04U21HM094bk1wUk05dEJKNHVIK2x6RG8rVHVmNWdBOUY2Rkp6Qmw4?=
 =?utf-8?B?OUQrZTkya1h0UWNjdWorTUFjZmVLbWwzYVJvWE4wWi91Y2xxRHh1MFl0VzVv?=
 =?utf-8?B?MzQxOHlyYXlyL0w5UjVGNUNXeGF1aENCSEVBYmdGQnNSWTRoZzhXN1h1ZG5H?=
 =?utf-8?B?Tll1Q3JscTBlL1RYL1dOZytMUUJNejI3SWR0am1lNUJmMk1tLzVaQUJOU0Rr?=
 =?utf-8?B?N0hHdHhNMmEwSDEwcDZvOHA5YWZiOTlsTWtlTlRKSG9rTlpnZTZ0azd0YWYr?=
 =?utf-8?B?ZlNKMmExUm1KWTNuVngrWkhsaUV0YTJsUHBwVFAwbnFleE1SYkkzS3N3Mml2?=
 =?utf-8?B?UUlsdkw2OVhBWVN0M0FOQnIrempnOFlEOUsxUmlrbXFCUHU0S3VDSDRXU1Iv?=
 =?utf-8?B?WmhnMVZqVXkwQ2grVjJwZ1RNTWI4UmVSVzNMaUJDakdIS2h5NnRwZzdLR09i?=
 =?utf-8?B?cTFnWk4wSjN5OWN0SFNNUjlBVnJ4QjNhS2ZZTThhUnprNGhKOXN4ZUlpaVlo?=
 =?utf-8?B?NlBlV3YyNXdoaUhlcXlkNjNGL0dqZ1d1UGtieUxmTmppMWZHa0dRZVF5TU4v?=
 =?utf-8?B?SmpqWUh0VTV5YkxLZ3MyREo3MTB1amdhcGFCWUs3dnd6ZlNLZER6OEs1V29C?=
 =?utf-8?B?NTVYOENqVEQ0WE93bjBTcWJyT3JsT2cvbHVOTGsxM0lsM08vcjdWYXVobUJl?=
 =?utf-8?B?RVlQWVJWZlBYNFQxQ1F5SXN6ekwxRFViNEdlYUl0d1FVdjg1TEZad0ZUbDhG?=
 =?utf-8?B?aFN1SFd5ZXc3dXpHdWJFMHlPczJMbG9XSHI2WWt2aVBsenhXRVJGdFdPc3lt?=
 =?utf-8?B?WG91cnp5TnNsSmxYaXB1YUpnTmxxTDBwaFhxWG9jNTRhbS80eEtZNEFONlFq?=
 =?utf-8?B?SkdKUGFHeDRkSU9PRXkrenpBYmYwcUhoWGhtd0tyUExKYzlwQXQwOWpQdUt2?=
 =?utf-8?B?bG10eFUrRHhKSVF5cUtqd25vTzlIcTB5VExYL3lMMXpFMEZacHgwR1pla1dF?=
 =?utf-8?B?Y0JsdXIrcDBwOWdPQlVYVERVOVF1ZnBsYkNyTS9vbFlaRFJ2bmZVUktEMmJ1?=
 =?utf-8?B?SE5mQkg0REF1WU9xM3gvMmVvS0FTclJFVzZlNGRQaW1tS0tzeG82VVBpMCsv?=
 =?utf-8?B?azd4cVppNkt2cGpxYnF3bWx1ZnB2K0c2MUpzNnhqb3h3bU5hWk82cDBPV0JP?=
 =?utf-8?B?bkpyZXhIU2RzVFBGSWNsd0VNQys3ZXI4QWY5V3JmWUlPWXdlT25RWithT0Zl?=
 =?utf-8?B?M2IrNzJRTzZ4OGNRYWt3Unc1WVd5SFZGSUdqMzhSckNSQjdQWmJ2Vk9VOHNa?=
 =?utf-8?B?Y3hGdFJ3U2pxMGRHRlNaU3o0b3dOalhseUZlSm5GQ21tdW5TL2Q5dzRSZG93?=
 =?utf-8?B?ekx1NkdsS1MzV2tEVDl5dVR4QUVEaS80RFpHQ21iaTBIWVcrRWZwRHhhUmZ0?=
 =?utf-8?B?WU5hQTJwZkNBWkcvWDAyVXZwcm9nMDJDNjJWbU9QT0MvRCtRTElNd3UwUXRR?=
 =?utf-8?B?OEVrWWpUY3Jsd2RyL1hTUTZ6NmNwVGw4anV6U0Q2ODAxNnlrTlZYQlgrRTlL?=
 =?utf-8?B?ckJkVGxCSlpZQ1F6Z0hNaEhudG43RVJmeUFMeDdRLytqTzVQbUNsYlV0eGJN?=
 =?utf-8?B?ckozaVA1V3N6WFlSOVZCd1Nqdk1qVkhZUEEzYnNURk5rOWt4T1pndXliR0hY?=
 =?utf-8?B?bGk4MS9vU0c4cE9mb3JsRGM4ZkdlajBXbnAwajVmOUlVWTRyU1pyWXZhdEdr?=
 =?utf-8?B?UURySm9tSEFhYzRGNVdzVmRtWFJuSFlrODBZVkx1ZCtscG1UTXJtTFM1N21R?=
 =?utf-8?B?UTE0ODk5YVd5NUZ4TGpMQ3RxK3cyUU5BUnNUTlBjdFU2S3dOTUdDSzJZRXVq?=
 =?utf-8?B?eGd1Uk9ET09PU1lwWTFGMkJ5R3EvTmtCaS9XZkxXMzBuTEE4eUVkdk82R0hm?=
 =?utf-8?B?MHRZZUsyaGp6S25HcG85K1B4bUR4eEg2K25NNHpoRVRIOVVncWU0ZFhDNTIw?=
 =?utf-8?B?TGVqTWdGN0pxeTMxaDBaY3NYTFBzQkdIVzhOYms5UzlOU2NYaGdCc2VOU2xF?=
 =?utf-8?B?OG1zMU1ZdkVvNjBsaWtwTGlsREF3dFY0QjJqOHBza0FVbVBoc2gzaW5yUVNE?=
 =?utf-8?B?K3pyUUZ2SjhNa2VqN1QrbmdTdG5RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3779.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191e39c8-42f9-4719-977c-08d9dbdaa24e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 06:03:52.0017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hRm3ENAppN5/xsQA44nOwPrqnwNu49pSMzEntCsyY+8sor/ZWwWDcmesIHNNREamirvgXz4MvE9njIKvvuA3pFA/b4eJW7LewHIriUNCvoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiAmIEpvZWwsDQoNCkkgYW0gc29ycnkgZm9yIG1pc3NpbmcgdGhpcyBlbWFpbC4N
CldpbGwgZml4IHRoaXMgQVNBUCBhbmQgc3VibWl0IGEgcGF0Y2ggZm9yIHlvdXIgcmV2aWV3Lg0K
DQpUaGFua3MsDQpDaGlhd2VpDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogU3RlcGhlbiBSb3Rod2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBKYW51YXJ5IDIwLCAyMDIyIDExOjIyIEFNDQo+IA0KPiBIaSBhbGwsDQo+IA0KPiBPbiBU
dWUsIDI2IE9jdCAyMDIxIDA2OjE1OjI5ICswMDAwIEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQu
YXU+IHdyb3RlOg0KPiA+DQo+ID4gT24gTW9uLCAyNSBPY3QgMjAyMSBhdCAyMzozOSwgU3RlcGhl
biBSb3Rod2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+DQo+IHdyb3RlOg0KPiA+ID4NCj4gPiA+
IEFmdGVyIG1lcmdpbmcgdGhlIGFybS1zb2MgdHJlZSwgdG9kYXkncyBsaW51eC1uZXh0IGJ1aWxk
IChodG1sZG9jcykNCj4gPiA+IHByb2R1Y2VkIHRoaXMgd2FybmluZzoNCj4gPiA+DQo+ID4gPiBE
b2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWRyaXZlci1hc3BlZWQtdWFydC1yb3V0aW5n
OjI6IFdBUk5JTkc6DQo+IElubGluZSBlbXBoYXNpcyBzdGFydC1zdHJpbmcgd2l0aG91dCBlbmQt
c3RyaW5nLg0KPiA+ID4NCj4gPiA+IEludHJvZHVjZWQgYnkgY29tbWl0DQo+ID4gPg0KPiA+ID4g
ICBjNjgwNzk3MGMzYmMgKCJzb2M6IGFzcGVlZDogQWRkIFVBUlQgcm91dGluZyBzdXBwb3J0IikN
Cj4gPiA+DQo+ID4gPiBUaGUgcHJvYmxlbSBpcyAocHJvYmFibHkpIHRoZSAnKidzIG9uIHRoZSBw
cmV2aW91cyBsaW5lLg0KPiA+DQo+ID4gQ2hhaS1XZWksIGFyZSB5b3UgYWJsZSB0byBzZW5kIGEg
Zml4IGZvciB0aGlzIGlzc3VlPw0KPiANCj4gSSBhbSBzdGlsbCBnZXR0aW5nIHRoaXMgd2Fybmlu
Zy4NCj4gDQo+IC0tDQo+IENoZWVycywNCj4gU3RlcGhlbiBSb3Rod2VsbA0K
