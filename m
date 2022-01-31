Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2404A3C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 03:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357360AbiAaCRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 21:17:11 -0500
Received: from mail-tycjpn01on2122.outbound.protection.outlook.com ([40.107.114.122]:53121
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233994AbiAaCRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 21:17:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFiGu0RO9sIhf1ep/n+PZHpuU1inP4P5mslTSh5/9+GxjkA0toXFs+931WVVK8Iec6u/gTHrw5/Llop2Ii6tPTTLxOEyxWzTHLJy5qjjJSGinU6241qdk3GOQ+mT8G7+d8EylY+aURTzQYbnlFyQ5cag3u4+g5GE/wNNFocaAuyFFp3J19vEpdcPfE4W4XZsiDMNg8rhdEK4nm0dLId/gqs835Qy5oF+MQUKdcejGDMFlJyxb0gekyidwZUmm8lc8PMD1lhbkgjw3LkobMEwgXaoUl/bk6JNm/uVY4w6X6asq7BDD2u6bsjGh5uak4jGSH9CttcM4sVBMGqgPtCJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VY+/N7A9F5g601ZtbmGxHCWsEnXHgECjZ9cgJQlDfso=;
 b=H0JK0DRWE4bQWVYnSmtceXFKhltdbZzTuNdwKF6eCgiwkpC/qwYgsyTwC7c+qfJZjMSMpXf+vZTrfeIKfVwMb/jtRxv4FJwm6OfLIxhPpuwKRsFtuovL6PMOmlOyReDMdab73glvwo+5ecd+FrywnoEB8+VO1CO+8TmMk7RDt3gYhkww+U9Y/ch726jvcS9zvWQtvmC3EaD/D9OIn5AtIYz1WfQYqONa0jIE4t7+EiouRzBvnIRG6oABbI1brvqlVaX9oiItENty1KbX3B8dkK9ibPtyQ6IWJBxRp3M2QWA+OY3o/I7Ck9QBVuxUlgNtBJz9K6E9p45it5Pt56+ULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VY+/N7A9F5g601ZtbmGxHCWsEnXHgECjZ9cgJQlDfso=;
 b=NuZE3p4hcnko+IrfgtVgWOp8Pz3XQJ/01qss/gDkkjxZEIhSBbVvSVVsVjR9Kpj1pzeIUeGHR2CLUj4dmiwMDorywDx36/K/SMQrPZbngiakfunR4VC00ZECZMfn7850777QG/gEWMVryyOOKYviCtICNY7T3lBXL72luKyeZQM=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY2PR01MB3450.jpnprd01.prod.outlook.com
 (2603:1096:404:d7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Mon, 31 Jan
 2022 02:17:06 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b8a7:7600:2af0:eea7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b8a7:7600:2af0:eea7%4]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 02:17:06 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Adam Ford <aford173@gmail.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "cstevens@beaconembedded.com" <cstevens@beaconembedded.com>,
        "aford@beaconembedded.com" <aford@beaconembedded.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: udc: renesas_usb3: Fix host to USB_ROLE_NONE
 transition
Thread-Topic: [PATCH] usb: gadget: udc: renesas_usb3: Fix host to
 USB_ROLE_NONE transition
Thread-Index: AQHYFJd9+7LdO0NmmU+VXClGrRksuqx8RUaQgAANowCAABQ/kA==
Date:   Mon, 31 Jan 2022 02:17:06 +0000
Message-ID: <TYBPR01MB534137D6807C750DEDCEE867D8259@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220128223603.2362621-1-aford173@gmail.com>
 <TYBPR01MB53418BE9FC9E11B901DF561DD8259@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <CAHCN7xJ491qfvkZCY6iSSXFNXbFdKnN6RUhb5df2x3P8oeQ0qQ@mail.gmail.com>
In-Reply-To: <CAHCN7xJ491qfvkZCY6iSSXFNXbFdKnN6RUhb5df2x3P8oeQ0qQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 132b116f-c59b-4904-b184-08d9e45fc728
x-ms-traffictypediagnostic: TY2PR01MB3450:EE_
x-microsoft-antispam-prvs: <TY2PR01MB3450C774F045B1479B912606D8259@TY2PR01MB3450.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4gMVISFagyBKhdDHhfhoD29pc/vXKTJcWBRnImiJfTbKGG1YbOOycb0rR1BHmWqjKXsZKw2+KrtKHfbosKHNtTTeawzZvTddetenHYw/WFIOuHiSewekjrgh9oBhXZLdpNLD+pUw9c7H6OeuFPg3O4QMslWjtKEIvuZB/5yG8Lg1qEhr/ae3XQ5qvZiAi+MhaZuzgx0YwByxFP8gEkKr6xwG9GrMc7zs1enjMgpyMVzKzeQLIXEVeqV8+5hLYI+MmicHhxUJaZplvQn/7EQcqM5xoFNPnwNOs896F5hEbklPX0WZwesQwXgepbxXco6juTNhFDz4G6IC/4ylwydmMDO6S2TIUaANyvVuqt6KzbN7cUXvwy8FA8Ur1jJbVE5FeA/YNP2HQ6UqR+Nv0o+FdggTUVALXXoc4yzP21JMrNiyeRrelBvC0MhZdYR72TeqIHBepT5i+J2T9r3duHWWJ6/6L2/KaBckOg5xeYzN9ZBjxLpu5sxBY8+qHO3lWrckgM4JWLZOC9g47pVkSE9awXI9KmOoHQAMCxo9hTVeI8qE5Q4wGj/Uw5sZMdZG2bkhcUUUCLif3RGOLRnlgeFbgxetDKzKoealqVXLlDzdzbVOyMRj8dM0ZnvV/DPt+rIBB2SguvUobnMZiMVJSuqAUVNTYguflYn0YlfikJcFOs6resm+DDm+nfkg9M0AKmgZ7GzQguO5BIeX2Dy6TYxHRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66946007)(66556008)(66476007)(66446008)(71200400001)(64756008)(76116006)(5660300002)(8936002)(8676002)(54906003)(2906002)(122000001)(316002)(6916009)(38100700002)(52536014)(38070700005)(186003)(9686003)(55016003)(33656002)(508600001)(6506007)(7696005)(53546011)(86362001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXIwUk4rOXoxb2llTlB0dzkxQXprQ2VVTld1K0pjM0ZQc1Q0RGpaVm5tY1VX?=
 =?utf-8?B?eVBZL3Y5eEJ4aDRrbUpjOXNRaGFVUG9OY1lVWS9CSk9lSGNEaHFOeHgwTXV4?=
 =?utf-8?B?R00yeWVKUERkdkprUGgyLzZsZGprWW9kSHhtdlZFOURCcXpuMTRIUHhPQXVq?=
 =?utf-8?B?SXVhOFhLWjVBVUVCbkJiSE9Ya2JPdmY4Wk9ZeURwV2pQY1pGSmtyWHl5a0dX?=
 =?utf-8?B?MkZYaWtCU3M0SzEwbTJScEhNTUozaU9QU1JMMUx1R2pLL2VvNklQZnpCbitk?=
 =?utf-8?B?WVgrdzh1SDZsK2w3SjlmTGgzaDZYOTIvZWd0aGNhR0RvRjBGSFRTdnc4Tm5u?=
 =?utf-8?B?cFRSdCtWVWFVd3dTY1NBenBiL3hTVUpxUkt4aFpNVDk5MWF6RiszTWFKa3ht?=
 =?utf-8?B?alBXU212UlFVa1JHbkN0ODQ3NkhkcUJIM1dSVWllbFZXeHJMZGg1Tjl4OU5E?=
 =?utf-8?B?REozOVBjQlJ5M1lnaklJdnJLSi9MNVNhKytRMU9ZME40WW9lcjVDYVZ3cUZq?=
 =?utf-8?B?UzNxcHB0TU9WOXlkZWQ5R2dNK0taaWhINytSQjk1bmhRR291Q3BueGlSdEpO?=
 =?utf-8?B?WUMxWEtzNU1HVGs3amROaEZuMkZkM0ZUUWw5WXUxN00xbnBrLzQzL2dUNTg4?=
 =?utf-8?B?RTdzVnp3NDNISUR1RDVvd2NlZ1hsYzB4cUc3WEFwQldjVGlNNDBWL081UVZL?=
 =?utf-8?B?QmZmTzM2U25TZnJiNjByMkkrVDZlWVBxRVJJTktkbFFkVHpuQzhFNVkxN2dV?=
 =?utf-8?B?ZG1WYjhxczVNeXRaYWh0UmRUWGZ4c2d2c2JiMU9ETFRtQzMrMThmelNGMG5a?=
 =?utf-8?B?SEtHM0RTd05aeGtITlNCV2pOQ2FlZ2RoTy96V0Jhb0lmZVZteWg1NEFRUmUx?=
 =?utf-8?B?MjI0OG54VmFUYXZJNHh6RjZic3Q4eGQ1cHVtRDFpckpuWEhNNW5nd1BJekhO?=
 =?utf-8?B?NEZaOE5FUmpBb2VmM3BoUmxGUG5rUkVoYVZ3Z0FwSDBITXY4R0Y1d0NueTY3?=
 =?utf-8?B?TlBxK2xzY09LSlAvMHdWNk5XTGtkYTUxNVljVllvOHFsK0pxMzg3OGxvQlVl?=
 =?utf-8?B?cWJYMzNjMVB0azdrTnZkSGphZEtQQlNjUGYzQkU3aDM2amN6NElyUS9pNVZI?=
 =?utf-8?B?VUt1eThJTVc1SzNUQVovVnNnZVJBSmNqcjdEOUJsY3NwZy9jcmg0R3p3c2Fk?=
 =?utf-8?B?Q0t6Qk5rMFJsL201STVBKzR2YXpIZVMyYVF2bkt6QUJWYTJrclJpWElkSXlY?=
 =?utf-8?B?T1R2eENZNCtDa3ByZWRGOUVURTJaeFFTNHl0ZU15MjFjU0VOZzR0aDBpc29z?=
 =?utf-8?B?c283K2ZVekw5UGlMTThWSHY5SDZsaC92eGhxNUlUZzF0R1NNMFNXazdDbVF4?=
 =?utf-8?B?S3h6M0RHWXNIa3VJNU5aTFNORE84S09RQ1pVUGRzNzBvV1pkN2pCS0FjME1z?=
 =?utf-8?B?MmpkRDlIWUN0bGtrRk5oUUtuTmZCNWRxdXVxQ1psb2luTDBDeUhuMFRheHRL?=
 =?utf-8?B?TlFhYlg4U0RXRzhkMnJZY3A2Q0dQUlpPeDl4anFmQVI2TVRUejkrSzQrdWVp?=
 =?utf-8?B?eFd1SWJlQnBUeUZUMWQwS2FaTmMrZ2lEUzN3c25mL0VsMzhndy96Zk1oaE82?=
 =?utf-8?B?Ym9DVW1ETFcvcitzWVVNb0ZqRFFuQlpGc1RzSVZSRG5yR0JKR1B3VVZoaDF3?=
 =?utf-8?B?S2p4TXVqK0Fac2pQcGVNQnBoODZHY0xRUENoNU9tWHlyeWJiTWpwNjFad09v?=
 =?utf-8?B?S2hKZTQwUWZtQi9RRDZsd3FmWmxTbGVVNzgyR2p3WTIxZWIwVmlHVjVyMWl0?=
 =?utf-8?B?dzd0cWR2cFVRMFUzUHMyMTFZc1F0OEVSVFpNMWNhcVJvRlp4czh1ZHVWdlgw?=
 =?utf-8?B?TlVJQzNKR1NVZjF6VU9sR2cvL0VRZ1lqSUc0SmpYWFdXNVRKNGZscjFlczFj?=
 =?utf-8?B?bjZHV1dSSlhqejlVQ00vTGpIcXdlYS9yMWhrcURIdS9mTDlPaFlGdmd0S0xz?=
 =?utf-8?B?ZkUzSDBIejFWUWZjbUZoYldpcUMwQ1VqVjcvV3EvbW9LaFY5dGhoWnFGNXA0?=
 =?utf-8?B?Y3c3NzhjQm9jWFYwV01WRnZDd1pTcnJRNmRXdXNLcFVJUHM3YnREUHUwMlln?=
 =?utf-8?B?dDZ6cDJFRmQ1SmlXWS9GWXY5alZJS2MxeUl5TktiRHp4Y29NeTBaUktkeXBE?=
 =?utf-8?B?ZjFEajZpNG1QNlNqOVk1ZmNLZnUwcVVwemdkYkhqM253ZU9qUklBUkNWeGRB?=
 =?utf-8?B?dkRHZllXZlJXMnlWMGxYeU5QRjJnN0VvMHFhNi9UWTdhRVo5bU5mYlVXSGNM?=
 =?utf-8?B?L09pcXdJZHhwR1ROeStiSlZEZW4ybjdHcDZPQVBqOWVvVWJoVUdYbnVPZWw3?=
 =?utf-8?Q?MRozF88ZkMYoZzjoZAzf8QaLK5oBBwEnapW4q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132b116f-c59b-4904-b184-08d9e45fc728
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 02:17:06.3213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZYjD9TZ5Jz0bQxazNASsbEQS8GoUBGqtTANFucAUaEgrmzqrK2D0A1jSioWNCPe7yo4XA361brKQSsvNVzY1jPQDhCuHKffk6S0pQcPDJoptkKJFKLqmfCb9vdKPyi7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3450
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWRhbS1zYW4sDQoNCj4gRnJvbTogQWRhbSBGb3JkLCBTZW50OiBNb25kYXksIEphbnVhcnkg
MzEsIDIwMjIgMTA6MDEgQU0NCj4gDQo+IE9uIFN1biwgSmFuIDMwLCAyMDIyIGF0IDY6MjMgUE0g
WW9zaGloaXJvIFNoaW1vZGENCj4gPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPiB3
cm90ZToNCjxzbmlwPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMv
cmVuZXNhc191c2IzLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL3JlbmVzYXNfdXNiMy5jDQo+
ID4gPiBpbmRleCA1N2Q0MTdhN2MzZTAuLjYwMTgyOWE2YjRiYSAxMDA2NDQNCj4gPiA+IC0tLSBh
L2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvcmVuZXNhc191c2IzLmMNCj4gPiA+ICsrKyBiL2RyaXZl
cnMvdXNiL2dhZGdldC91ZGMvcmVuZXNhc191c2IzLmMNCj4gPiA+IEBAIC0yMzc4LDYgKzIzNzgs
OCBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfZXh0X3JvbGVfc3dpdGNoX3N0YXRlcyhzdHJ1Y3QgZGV2
aWNlICpkZXYsDQo+ID4gPiAgICAgICBzd2l0Y2ggKHJvbGUpIHsNCj4gPiA+ICAgICAgIGNhc2Ug
VVNCX1JPTEVfTk9ORToNCj4gPiA+ICAgICAgICAgICAgICAgdXNiMy0+Y29ubmVjdGlvbl9zdGF0
ZSA9IFVTQl9ST0xFX05PTkU7DQo+ID4gPiArICAgICAgICAgICAgIGlmIChjdXJfcm9sZSA9PSBV
U0JfUk9MRV9IT1NUKQ0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGRldmljZV9yZWxlYXNl
X2RyaXZlcihob3N0KTsNCj4gPg0KPiA+IFRoZSBoYW5kbGVfZXh0X3JvbGVfc3dpdGNoX3N0YXRl
cygpIHdpdGggcm9sZSA9IFVTQl9ST0xFX05PTkUgc2VlbXMNCj4gPiB0byBiZSBjYWxsZWQgbXVs
dGlwbGUgdGltZXMuIFNvLCB3ZSBoYXZlIHRvIGF2b2lkIG11bHRpcGxlIGNhbGxpbmcgb2YNCj4g
PiBkZXZpY2VfcmVsZWFzZV9kcml2ZXIoKSBzb21laG93Lg0KPiANCj4gRnJvbSB3aGF0IEkgY2Fu
IHRlbGwsIGl0IGFwcGVhcnMgdGhhdCBkZXZpY2VfcmVsZWFzZV9kcml2ZXIgdWx0aW1hdGVseQ0K
PiBjYWxscyBfX2RldmljZV9yZWxlYXNlX2RyaXZlciB3aGljaCBjaGVja3MgZm9yIGEgTlVMTCwg
YW5kIGR1cmluZyB0aGUNCj4gcmVsZWFzZSBzZXRzIGl0IHRvIE5VTEwsIHNvIHN1YnNlcXVlbnQg
cmVsZWFzZXMgc2hvdWxkIGp1c3QgZ2V0DQo+IGlnbm9yZWQuICBNYXliZSBJIGFtIG1pc3Npbmcg
c29tZXRoaW5nLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudC4gWW91J3JlIGNvcnJlY3Qu
IEknbSBzb3JyeSwgSSBkaWRuJ3QgY2hlY2sNCnRoZSBfX2RldmljZV9yZWxlYXNlX2RyaXZlcigp
IGJlaGF2aW9yLiBUaGlzIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuIFNvLA0KDQpSZXZpZXdlZC1i
eTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0K
DQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo=
