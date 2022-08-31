Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE645A7F42
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiHaNvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiHaNvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:51:38 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB935CE4A4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:51:36 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2045.outbound.protection.outlook.com [104.47.22.45]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-3oeqpHEePuSCKQK7CJSOtQ-1; Wed, 31 Aug 2022 15:51:31 +0200
X-MC-Unique: 3oeqpHEePuSCKQK7CJSOtQ-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0364.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:31::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Wed, 31 Aug 2022 13:51:31 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cd78:5df6:612c:455f]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cd78:5df6:612c:455f%2]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 13:51:30 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "wenst@chromium.org" <wenst@chromium.org>
CC:     "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>
Subject: Re: [PATCH RESEND v2 1/2] clk: core: Honor CLK_OPS_PARENT_ENABLE for
 clk gate ops
Thread-Topic: [PATCH RESEND v2 1/2] clk: core: Honor CLK_OPS_PARENT_ENABLE for
 clk gate ops
Thread-Index: AQHYvUDGGvG/DF/yckGrUtVF0yV3bw==
Date:   Wed, 31 Aug 2022 13:51:30 +0000
Message-ID: <9f61678e008815ed011a61472cf909445448cb2b.camel@toradex.com>
References: <20220822081424.1310926-1-wenst@chromium.org>
         <2254919.ElGaqSPkdT@steina-w>
         <CAGXv+5Hf0n5jkqwuQmh0PG8ejxDND6BRVG47J9HTQrqz9OhLdQ@mail.gmail.com>
         <8113103.T7Z3S40VBb@steina-w>
In-Reply-To: <8113103.T7Z3S40VBb@steina-w>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f854f774-e525-4a45-c336-08da8b57e8bf
x-ms-traffictypediagnostic: ZR0P278MB0364:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: sLZbSk14RoxLbKefqayypQgfEUvSncXbsdMoV8d8ZWRFFYoRvRd9FfzM+DFNPpVwkYQTZCufDxH6Ax8GHUc0j1WePyRt0te6jpTRf89qKBpyytNrIs69AA8p7T6LggSpejqvsN5GLNIK5l/3AnxV01tUInchZoqDQ8xE6aMLLYImOuitXBSt+juN84vau+vU17crreKA3AYvWKN/1v9o9wLqya83FYsYrOz285DoEX8WGYy/0zYcJMgiTw2TP5S2sZrHqYtUKDBBCv387QimhkbM5KPLiPIgHzyjSlhGQdcG3QP1Dgc6S3zqIfmX7Jkj87wD9N+ob7qMOYRZbwaP44clg0H37cayaW1CttqtkkIn+QBKPdoe3bioj0z8iywjFvLO/VgCqbJdtOyzGdhVK49YOmO8ug/zuWSPmBl2z4X0SxuIMEsN3WYeRJvKHdhBS8WywHZS20F6146nDY7w0SGB//Hnd7wOT8uGH6cPIpA4DpNhvXC1ZAsR/lqciP2osxg7ZYLr4aA88i5r10Ycr5OaKOAXQ7ORa/K+UcoQthVm8YPGTdMWSlhgGvel0gVsZhThXFunUdj17z0PwT0G0Wsb5+n9FFmRH3eJCo1nYl5LCAQjAOEVKXGslZLEEAEM8db6u1jSqGK8JfXVk6hyvPtqYDMFMOy/z+I7b4DAw6+3l32vmt886rAYEWcSzPci3EPLy1tIuV4/QZEKJoTc8Gne/+COTAnfendpN2BGrNFqO7FjdxD7Xd0wF2vYAIIw+RSWn/b8cIxzgRzntdNEkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(396003)(39840400004)(376002)(38070700005)(44832011)(86362001)(2906002)(38100700002)(122000001)(8936002)(5660300002)(26005)(6512007)(6506007)(54906003)(316002)(110136005)(6486002)(478600001)(71200400001)(41300700001)(83380400001)(66946007)(64756008)(66476007)(66556008)(8676002)(66446008)(76116006)(4326008)(2616005)(186003)(36756003);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEJMNkUzV2VNdUdUbVliZDZ2ZUhlSC9IRlExY1lpTmwzN3JSTWc1bUlIMlpz?=
 =?utf-8?B?QWp0T2NLQkZhTFN6L1g5UzBWWHQrTlpoa2V5REs4YWRXK09DREExN3g4UGU4?=
 =?utf-8?B?Mm5jN3d2Z3FZOGh5NUlEYXhvRjNBeDlnbWcrVFhWdHUzSm9odjdoRm5BelA5?=
 =?utf-8?B?a05GT0k3cVVOR0ZXUFkxMFdJTzJuYkx6d2cvTUhDYXpRS1ZCbGFxWVh5ZFBv?=
 =?utf-8?B?UVpJT29pK1NuaVlkT3FQTjNJTHJpbEQveTR3Sm9XWE9BR1JDb25hc2hodG9R?=
 =?utf-8?B?QUowOXNjdUxPbTZhb3pEdVlMdUpxVjJETlpxdVkwY2R4VEQrN2dHU0tKU2kx?=
 =?utf-8?B?QmhMTVBhTnI3cExYemUyTVBLYnlKNEszMHJ2SXlha0NYbjdwV1dzcndua1Rp?=
 =?utf-8?B?RlJCQWViZGE0d1ZTNUJHdkluZ1o3ZncyaUFhRitOc1hQZ2pPY05CUStLVUFo?=
 =?utf-8?B?V2NrTDg4UWxEelhYL0ZYRW9neXZTb0k4NmVpVHRjbWttdVEvclEreS84U0dS?=
 =?utf-8?B?akt0UzVUbkxqbmtlTzlDeFZkeGdOWnJoVC96Z1ZnWTN3YzEvd29mR1puT1Zo?=
 =?utf-8?B?RDhRRXJUSkpHSGl6UWRaekhNR1A5TjV1ZVpkelp3VGJqeFl4ekJCVGN2Yjh5?=
 =?utf-8?B?MXpnUW1rcjNmTjRHNnpyU2djNkhPMW50NHVwUTBldDVBRXR2ZWtPMVR1cGtu?=
 =?utf-8?B?aXB2cktlT3Y4NWVXSkp6aWMxcUxieUJSUlNqV1F1MU5lRVBDLzMzdGxrbmlW?=
 =?utf-8?B?YlB3bTA1aW9YMkdqckVsMWhpL3lSQzBWK1lTbVE4WmhyTFErb3hBd2FKUHox?=
 =?utf-8?B?WWYwZnBrYmNWcmpock1lbzcrek1oRERvdElxVVFSd2JWYmhaRnZZK2JoTDRD?=
 =?utf-8?B?SGQ0ZEFLTmE3NGUrODBYQ2k5d3FPR3ZnMGlJaFkvY3lQTW5kSGc4OHpiYzF3?=
 =?utf-8?B?Nml4K2p4bmhRV2wzakY4cGtjVm5DTGRpZTFqR0lIUTBNUWNmR2liYTlZUzcz?=
 =?utf-8?B?U3dlMXNXS09iZDBRU0h2WWN3NmtmdlVIRlRMNXFrNEpwK0RQM2VVOS9meGpy?=
 =?utf-8?B?TXFuOXI5QjhjejRxMmU5WkZFTHozallQdHZIY0hsbUNBdU5pK0UzK25ablo4?=
 =?utf-8?B?aXRNcUJOSEIxUDJVdEdIWHVSTHhsVVJic0NOSFhCRVhJeUROZ3JBWVB3Vlgy?=
 =?utf-8?B?RG1TTTdMK2M3eEplZ1JxOWhmUmJadG5NTkdnazhxRGNFMHFrdDluM3dzMzFW?=
 =?utf-8?B?WmJCa2todVZWY09CK3YwVUtuMnpSWWlxMnZqaGZ5WE9PMWR5U0gvbVRkTlY3?=
 =?utf-8?B?ZEtPNnJ2c1RSamNVdUlhbWFyNE5rcVVURG9MMkhVbERJMXV1NVNJRmp4WWVl?=
 =?utf-8?B?dGVPMjIrakllcU9kZGZDY09vWE1PRzJ5UnZxTkpwbVVyYnZMYjEvMndPbDRV?=
 =?utf-8?B?N2YwSU1ZL3NzSndFTHI4VUdHMDluWmpYNXhaQ2hzeUMyOHUwY2hiMEJBOVdo?=
 =?utf-8?B?aVlBc05WM2VtYitJYS9obkNMOG1iM3laOElpK0syZWoxNFBsd2dyQW92eVox?=
 =?utf-8?B?MWE0cVk5cUpyL1JoN3diaTJjUVN3SGd5OUtndFNNSVBRMHVqeUF5bkdCdE9N?=
 =?utf-8?B?U3lEQ21WQVdISzNLVFV3S0JYS2o0M2tMSlQ1NXlVb1dhLzhYbWliYi9NUjcy?=
 =?utf-8?B?MHQ0cXNmdDc0UEUxTnc0NEhqOFRaQzJpYWkzWmdCSU9wdVNlSVNWSHMwRk1p?=
 =?utf-8?B?QjFwRzBXMFkrYlF1NUMzRTAzVkxzMkx1N1lMTjlSSjZMQlZlRzN5WVlBVnZa?=
 =?utf-8?B?MEF3TlB3cCtEbHVyc2xWL2p1TXFNT2poVlhFTGVmTXJlVkprL1pUM0M1K1d3?=
 =?utf-8?B?RmJwOHNMY1RiQytHUG5ITmxZL2JJNG9OUnBMZVN6MDBueHBuS2xKS1BWZC9j?=
 =?utf-8?B?NkxxTTMzcGc5QkU4S29FVDk2QVFsZXdyam9JSzJzVGUzZUJ5YzlWNGltM1pF?=
 =?utf-8?B?WHpSQnh4WmVwdjVaWXpFMDlXWFpsMFhleFZrVkloQzhCM3Naa1NhY2tJZlNU?=
 =?utf-8?B?NE5tK1NvNmVqcHVNaFdEQ1NWSlF1VjlqT1dYRDhxTEMxRWdUZjlLNFkzYWFK?=
 =?utf-8?B?bzJOMUpGUnFob1VySWUxTzFJTXRzRUxzcXFlaEdSanJJajRtNkRDRUN0R0h2?=
 =?utf-8?Q?TSjFp//nRPSnD3cJtq182Fs=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f854f774-e525-4a45-c336-08da8b57e8bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 13:51:30.9018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNDWEUUBI9Ux+M9N4s+zc4lqAQhlJpU8XWW6PkfrcZVIHdlWbKvh1Jon/qcz0i1pXaVoP/NfNd2n6Uwx2z3nY7/GeNxVSZmSm+EZLGoH+W4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0364
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <9D67C55B0DA53846B39844AFDF9561EE@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgdGhlcmUNCg0KT24gV2VkLCAyMDIyLTA4LTMxIGF0IDA5OjQwICswMjAwLCBBbGV4YW5kZXIg
U3RlaW4gd3JvdGU6DQo+IEFtIERpZW5zdGFnLCAzMC4gQXVndXN0IDIwMjIsIDE1OjQwOjUzIENF
U1Qgc2NocmllYiBDaGVuLVl1IFRzYWk6DQoNCltzbmlwXQ0KDQo+ID4gVGhhbmtzLiBTbyB0aGUg
cGFydCBvZiB0aGUgY2xvY2sgdHJlZSB0aGF0J3MgcHJvYmxlbWF0aWMgaXMgdGhpczoNCj4gPiAN
Cj4gPiDCoG9zY18yNG0gKGZpeGVkKQ0KPiA+IMKgwqDCoCBzeXNfcGxsMV9yZWZfc2VsIChtdXgp
DQo+ID4gwqDCoMKgwqDCoMKgIHN5c19wbGwxIChpbXggcGxsMTR4eCkNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqAgc3lzX3BsbDFfYnlwYXNzIChtdXgpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHN5c19wbGwxX291dCAoZ2F0ZSkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3lzX3BsbDFfODAwbSAoZml4ZWQgZmFjdG9yKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBtYWluX2F4aSAoY29tcG9zaXRlIENMS19JU19DUklUSUNBTCkNCj4g
PiANCj4gPiBXb3VsZCBpdCBiZSBwb3NzaWJsZSBmb3IgeW91IHRvIHByb2R1Y2UgYSBzdGFjayBk
dW1wIGFzIHdlbGw/IEFuZCBhbHNvDQo+ID4gZW5hYmxlIGxvY2sgZGVidWdnaW5nPyBUaGlzIGxp
a2VseSBzdGlsbCB3b24ndCBjYXRjaCBhbnl0aGluZyBpZiBpdCdzDQo+ID4gYSBzcGlubG9jayBk
ZWFkbG9jayB0aG91Z2guDQo+IA0KPiBTdXJlIHRoaW5nLCBJIGFkZGVkIGEgZHVtcF9zdGFjaygp
IGNhbGwgdG8gYWxsIG9mIHRoZSBhYm92ZSBkZWJ1ZyBvdXRwdXRzIGFzIA0KPiB3ZWxsIGFzIHRo
ZSBuYW1lIG9mIHRoZSBwYXJlbnQgY2xvY2ssIGp1c3QgdG8gYmUgc3VyZSwgYW5kIGhlcmUgaXMg
dGhlIHJlc3VsdCANCj4gb3V0cHV0Og0KPiBbwqDCoMKgIDEuMTQyMzg2XSBpbyBzY2hlZHVsZXIg
bXEtZGVhZGxpbmUgcmVnaXN0ZXJlZA0KPiBbwqDCoMKgIDEuMTQ2OTAyXSBpbyBzY2hlZHVsZXIg
a3liZXIgcmVnaXN0ZXJlZA0KPiBbwqDCoMKgIDEuMTc3MzQ1XSBjbGtfY29yZV9wcmVwYXJlOiBj
bGs6IG1haW5fYXhpIENMS19PUFNfUEFSRU5UX0VOQUJMRQ0KPiBbwqDCoMKgIDEuMTgwNzEzXSBj
bGtfY29yZV9wcmVwYXJlOiBjbGstPnBhcmVudDogc3lzX3BsbDFfODAwbQ0KPiBbwqDCoMKgIDEu
MTg2MDI1XSBDUFU6IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA2LjAuMC1y
YzMtDQo+IG5leHQtMjAyMjA4MzErICM2MTkgOWM4MmU1YjkwNzVkNzM1ZmEwN2UyYzU1ODYwM2Zm
YjcyMGQ3Mjk4Mw0KPiBbwqDCoMKgIDEuMTk3Mjc0XSBIYXJkd2FyZSBuYW1lOiBUUS1TeXN0ZW1z
IGkuTVg4TVBsdXMgVFFNYThNUHhMIG9uIE1CYThNUHhMIChEVCkNCj4gW8KgwqDCoCAxLjIwNDI3
NV0gQ2FsbCB0cmFjZToNCj4gW8KgwqDCoCAxLjIwNjcyM13CoCBkdW1wX2JhY2t0cmFjZSsweGQ4
LzB4MTIwDQo+IFvCoMKgwqAgMS4yMTA0ODVdwqAgc2hvd19zdGFjaysweDE0LzB4NTANCj4gW8Kg
wqDCoCAxLjIxMzgxMV3CoCBkdW1wX3N0YWNrX2x2bCsweDg4LzB4YjANCj4gW8KgwqDCoCAxLjIx
NzQ4Nl3CoCBkdW1wX3N0YWNrKzB4MTQvMHgyYw0KPiBbwqDCoMKgIDEuMjIwODExXcKgIGNsa19j
b3JlX3ByZXBhcmUrMHgxZmMvMHgyNDANCj4gW8KgwqDCoCAxLjIyNDgzNF3CoCBfX2Nsa19jb3Jl
X2luaXQrMHgyMDgvMHg0ZGMNCj4gW8KgwqDCoCAxLjIyODc3Ml3CoCBfX2Nsa19yZWdpc3Rlcisw
eDE2MC8weDI0MA0KPiBbwqDCoMKgIDEuMjMyNjIyXcKgIGNsa19od19yZWdpc3RlcisweDFjLzB4
NWMNCj4gW8KgwqDCoCAxLjIzNjM4NF3CoCBfX2Nsa19od19yZWdpc3Rlcl9jb21wb3NpdGUrMHgx
ZTgvMHgyZDANCj4gW8KgwqDCoCAxLjI0MTM3Ml3CoCBjbGtfaHdfcmVnaXN0ZXJfY29tcG9zaXRl
KzB4NDAvMHg1MA0KPiBbwqDCoMKgIDEuMjQ2MDA5XcKgIF9faW14OG1fY2xrX2h3X2NvbXBvc2l0
ZSsweDEzMC8weDIxMA0KPiBbwqDCoMKgIDEuMjUwNzM0XcKgIGlteDhtcF9jbG9ja3NfcHJvYmUr
MHgxM2FjLzB4Mzc1MA0KPiBbwqDCoMKgIDEuMjU1MTk5XcKgIHBsYXRmb3JtX3Byb2JlKzB4NjQv
MHgxMDANCj4gW8KgwqDCoCAxLjI1ODk1OV3CoCBjYWxsX2RyaXZlcl9wcm9iZSsweDI4LzB4MTQw
DQo+IFvCoMKgwqAgMS4yNjI5ODRdwqAgcmVhbGx5X3Byb2JlKzB4YzAvMHgzMzQNCj4gW8KgwqDC
oCAxLjI2NjU3Ml3CoCBfX2RyaXZlcl9wcm9iZV9kZXZpY2UrMHg4NC8weDE0NA0KPiBbwqDCoMKg
IDEuMjcwOTQ3XcKgIGRyaXZlcl9wcm9iZV9kZXZpY2UrMHgzOC8weDEzMA0KPiBbwqDCoMKgIDEu
Mjc1MTQ3XcKgIF9fZHJpdmVyX2F0dGFjaCsweGQ0LzB4MjQwDQo+IFvCoMKgwqAgMS4yNzg5OTdd
wqAgYnVzX2Zvcl9lYWNoX2RldisweDZjLzB4YmMNCj4gW8KgwqDCoCAxLjI4Mjg0N13CoCBkcml2
ZXJfYXR0YWNoKzB4MjAvMHgzMA0KPiBbwqDCoMKgIDEuMjg2NDM2XcKgIGJ1c19hZGRfZHJpdmVy
KzB4MTc4LzB4MjUwDQo+IFvCoMKgwqAgMS4yOTAyODRdwqAgZHJpdmVyX3JlZ2lzdGVyKzB4NzQv
MHgxMjANCj4gW8KgwqDCoCAxLjI5NDEzNF3CoCBfX3BsYXRmb3JtX2RyaXZlcl9yZWdpc3Rlcisw
eDI0LzB4MzANCj4gW8KgwqDCoCAxLjI5ODg1OV3CoCBpbXg4bXBfY2xrX2RyaXZlcl9pbml0KzB4
MTgvMHgyMA0KPiBbwqDCoMKgIDEuMzAzMjM0XcKgIGRvX29uZV9pbml0Y2FsbCsweDQ4LzB4MTgw
DQo+IFvCoMKgwqAgMS4zMDcwODRdwqAgZG9faW5pdGNhbGxzKzB4MTY0LzB4MTljDQo+IFvCoMKg
wqAgMS4zMTA3NTldwqAga2VybmVsX2luaXRfZnJlZWFibGUrMHhmNC8weDEzOA0KPiBbwqDCoMKg
IDEuMzE1MDQ3XcKgIGtlcm5lbF9pbml0KzB4MmMvMHgxNDANCj4gW8KgwqDCoCAxLjMxODU0OV3C
oCByZXRfZnJvbV9mb3JrKzB4MTAvMHgyMA0KPiANCj4gRW5hYmxpbmcgbG9jayBkZWJ1Z2dpbmcg
cmVzdWx0cyBpbiBubyBhZGRpdGlvbmFsIG91dHB1dC4NCg0KSSBhbHNvIGp1c3QgYmktc2VjdGVk
IHRoaXMgdG8gY2F1c2UgYSBzaW1pbGFyIGhhcmQgbG9jay11cCBvbiBWZXJkaW4gaU1YOE0gTWlu
aSBhbmQgVmVyZGluIGlNWDhNIFBsdXMgcnVubmluZw0KbmV4dC0yMDIyMDgzMS4gTGV0IG1lIGtu
b3cgaWYgeW91IG5lZWQgYW55IGZ1cnRoZXIgaW5mb3JtYXRpb24uDQoNClRoYW5rcyENCg0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IEFsZXhhbmRlcg0KDQpDaGVlcnMNCg0KTWFyY2VsDQo=

