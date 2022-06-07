Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F10653F428
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 04:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbiFGCyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 22:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236121AbiFGCyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 22:54:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2113.outbound.protection.outlook.com [40.107.215.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D5869CF0;
        Mon,  6 Jun 2022 19:54:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1ySGHFqLYENy0XqdsWLfMVfl4lA06M4BhYZhIAtKcin/MjNaK0gxyP6DyPLpYwrBb9zHF64Vr+uF6lSIamoogilfPj/Nfqk/tmwv5ThPV53AOiyR6kSkaIzGj/BjJDryqN0xBXIJMmhf4dRP/Kb08BMGJRgLnVer1XNepqqeuVEbeOW65S5X8IImCvw2+8/lf+UtfqhavFssw0tNhivZS2N3CpBNUfSDzPLRA4NTZyay5uKXwka7pByATL9+hw2uomWr3OLN8y38dIb0+vuyK4boaDPNoJB4omHJOCpXTUOL6079d3uiHWKG65ydXNCZPgyodBn0XSuKxFsiaDLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZGJ+ljrpCuvzuuIF7UmE+ORF0WJW1tLtjyG9rOl4qU=;
 b=inH3Vz2trc8rHiGE1J+qmnOCo/y6FN4I1Vi6WvwcwxN3QrT85Wt0Gx1RQOWcCo0x0noymvbNiL+PP/RD8kG9elkpXxid91QB3K6hbrkzQnCUyTX3vE6kG9K02Q+8bwfZQSYpVfRmEpoatIqCVcfUILMtOfEbU2HdqSqu89fWcUWBCCcdraSI+6xVsThFakIUokLmzKeK9ByFc2AS8Bl8UvFUUiQugStvDArAKd/QUDlC3JJpYFQxwWbfPi9ND7Y/UrqQAFyO2kBIkFGv6cD1YNZ6jifMgEz3KzFxq/xko5s5xjxhtoLYZERp/wBndqDHgmh126hLuT85FQrT0xLvoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZGJ+ljrpCuvzuuIF7UmE+ORF0WJW1tLtjyG9rOl4qU=;
 b=zGNrPyOf5KKa1h4WnIZ7gR4y/Gm8aflBTgYy3PTsSQsb8t9otbV9niwJ1uj5IdH2+PE73aZyDRz7WsppdArrZZIglzjPPn+nBTOF30qHcnydm+5XLm88jPD1FGUB3k95z3NDs0Y7cfziQEfzpXbWSZQaTqNeMtWIVzYAoY/1m1HlRupF+BwwJ/l/F4R5CFeAaRRwXfqvSmIzH5RKjpfatGkh/mDtu0C6VVh+m2pHuq5611HGAE9UYkCvEInDuNnCUrPJLVCIIct/UP3FOINJJ2HXHm6iV9rS+1BmunKofHpss0vITjFiReexxZ/lLC8fN9tI36z5QvUA9r5KGneTeg==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK0PR06MB2755.apcprd06.prod.outlook.com (2603:1096:203:5b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 02:54:30 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 02:54:30 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v2 1/5] crypto: aspeed: Add HACE hash driver
Thread-Topic: [PATCH v2 1/5] crypto: aspeed: Add HACE hash driver
Thread-Index: AQHYeXGeSzQOPdHyakaer71NgsLgsa1CeN2AgADH69A=
Date:   Tue, 7 Jun 2022 02:54:30 +0000
Message-ID: <HK0PR06MB32024E97321424748A5532A380A59@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220606064935.1458903-1-neal_liu@aspeedtech.com>
 <20220606064935.1458903-2-neal_liu@aspeedtech.com>
 <d0366136-428f-3af2-996e-a3d168b570e3@infradead.org>
In-Reply-To: <d0366136-428f-3af2-996e-a3d168b570e3@infradead.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cce81a39-2e57-42e6-466d-08da48310afa
x-ms-traffictypediagnostic: HK0PR06MB2755:EE_
x-microsoft-antispam-prvs: <HK0PR06MB2755D7E3D61B312711DDA27880A59@HK0PR06MB2755.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dt4epmeJlrBVmnADidwk5eCrELtL49G5bUPd+gl5v+CLPwWaCEQzZBYjwqy0b3MffbsWo3o4UNUUj0JE3K7BnI8DyIlMTDT9uiT5z3uzgc7+zMSfl6Q+EIqW0vTk2qGmwlQnCsdObcZtxcohfCmCWsgr4+UD1fdgxfbtlT4972LGIX5LwUUut0yS11jfzquU6Trac7qu9uAMyxQioBBW8bDbJMpLFQwDhk/hCPlTAdFuphXLS2hONIYXc1cJCAIGxxX2VSZQfBmxwWlRykKjqRu5j5feaZqh05zaHMSJ2JMqvvjCjz0olGwbSZY85AZ1+p36G3PW//kHnpb/Ua0IuuAMUdHZAux66yvCFcilWpaN7SVjADdupfuxOzwy8GVXNb0aMB5wG60QDCaZxjrX3cfn8+StpuMgznboT6A9atMcCjIxTz5bfhHlZFx0qHw0uuE8ZhIY7QzyYKZMHRhqoCJt7VAWyvGYu2tVGaqIr5JEhy27i47RQvGfsqb2AelhC/cY+FCBgVm7HMeB/gHiK1FaSOGtFk+EyGMlkP0td5AI48sWvdNUOySnrPI6gnzzpe7gQ38lI76ZiKbQ+F8ve8JLvlq4vANehK0S4d4g+d3jM2sdOWGm3a9392/A925ZTVy8lEZOh7lmhocez7c5OBpJOxLhJQVr1NJwjHheWRORoJBvcX7Y39ZGKZ3rSFp5pTX01EjJ/N+s5s09cPJ2EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(52536014)(55016003)(508600001)(107886003)(7416002)(8676002)(8936002)(186003)(316002)(26005)(38070700005)(122000001)(83380400001)(9686003)(54906003)(110136005)(6636002)(66556008)(66446008)(66476007)(71200400001)(5660300002)(2906002)(66946007)(33656002)(38100700002)(53546011)(6506007)(7696005)(4326008)(86362001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW9mcTFwZ3l6SDBqSkJmcEFKbjhyZ2l3VjlvUjQ4Q0lJbys1ajFVZlZwQnJY?=
 =?utf-8?B?OEl6V21XczQ3ZGZkZUIzRCtNNllVcitzbFJUTlJpR3Rjck0vMkNEeE1hbHNj?=
 =?utf-8?B?dEw4M3VnL3pBQnZsSi9YbVJENkFRUFN1bFlFTmhxdjg1M2ZZRjVqYUJVWEdl?=
 =?utf-8?B?cThNSzRNYVNIclRWM0x0bGVUb3RnTDFqL2FoVlBiWUI4eGFvUys0a0xRZXA4?=
 =?utf-8?B?VXVLWldJN2VCbXQ0NkZsb0VXdittVkE2enp4WWE3N1F1aVpQWG8wZGh6aXli?=
 =?utf-8?B?TDN5RTBqZUlFMC9JUFRQaUZGQk1rOFNqU1Z3ZDBhNFR5djF1aG9HVjl3YW5n?=
 =?utf-8?B?Z0Zsa1ZHOFdSK0wvSGdERm5PK2o0VWxBNDhGZHZHbHdqd0h3ZEVPWGdHTFlZ?=
 =?utf-8?B?SnB2bHN0T3dLeDNqeENidWFrdVFna0l3cjgzNXlkWUdDMVdRelphVmpoT3Ur?=
 =?utf-8?B?UTB1a0JMb3IwZ2UxUUswYi9FdC81SVRJOWQwNjc0a0FYSmFSYmkxZFpkZ1hB?=
 =?utf-8?B?cERqYlRoNWZYeUwvRDNMaWNaK2lzZUxicG4vRlBlRlErUFUyNlRxTzdXNnBK?=
 =?utf-8?B?RjU2aUNRVXdWRHlXdEpMNVFNM3NndXhQY0ZnY0JmS2xaRUtlZ2dGZnAyb25r?=
 =?utf-8?B?bCtPdUZwa21vaURwN1B5NmZoZW9IK1N4QWRvVTJxSUFZWTQ5a1ZuMVRuYWR3?=
 =?utf-8?B?OXhHQlFhQ2tiTmtkZzJLOUVIV1U2VjJ6VXVBVlljLzIzeHVBR0VpMjlHa3RI?=
 =?utf-8?B?NWRGZE9ZNDJZVjhUYUpzdnl1QXlQaDZDaVpiVzh5d3JHcWVXbWlScFRVditn?=
 =?utf-8?B?eExISGZrVjZselc0MFRvU2ErWDVqRUY2Um9zbmFIUC84alhDM05tSWFuUVB5?=
 =?utf-8?B?MEdtK3FvdmNEZjNyTFY2bGp2UEc1SENlNWM0WDlGWERBdnoxTWJ6MTU4ZUNV?=
 =?utf-8?B?U1QwRDRsZExndGRhUmVKT1k2aDZ6blZoM2gvNFM2UEV3NkhRRC9lUTdiVXFw?=
 =?utf-8?B?RERxL1B4SFNDclhTQ3FrQXZtRys4RXUrVDBzYzlxMVoycWhoMHlmVGIvQmpM?=
 =?utf-8?B?NkI0UkVBSGxaMEdhNTd2NWhBelJVWnprM2dKRGlaWHdJR0ZLTU9zOXdSZ1dr?=
 =?utf-8?B?eUV6Qk1ORlk0a2VGVXJCMngwODU2dURFT3JJZVFkTzBsV2lXbkNlSnhnMUhE?=
 =?utf-8?B?N1VHeDVXUml4Mng2RFR6L1JFcmhrZFd6WHdyUnhsQUhxSUtNUVJzSTUrUEls?=
 =?utf-8?B?RzFVNU1kUTZnNjUvUFNTc0oxNVZRdW14bDVOcFlLbG9KRnNQamppekR6bkN3?=
 =?utf-8?B?WWJMV1hjMjBublBHaGdQRDZnT2tQQ0MvckZMNHp3WHlOd1dlSVZKYXNncGRP?=
 =?utf-8?B?OUJUdFFRc25JNHZyVnNsNTl1VldDV2QyeThaRFBPcE5YdHUwQ0pVcms1aDlQ?=
 =?utf-8?B?K01lMGs2RGdwM2sxNEtDeXNlOHliRFNQSTZzMmJFOUFVeFloZC9ZYTVLRGZ2?=
 =?utf-8?B?RnRNd1c5WFd4QVZYek5xWXM4YnJNcWl5U0xEVXdMZEN2R3R0Smk2elh1NVBs?=
 =?utf-8?B?S3F5SmRkRE9JTE5vNUlaN3diT3JoWHpZS2RUMG5Qai9ZMVRJamd3UDNMcTA2?=
 =?utf-8?B?NWlGcDhMM3ZuSlRTN3pTM2NFZlFhaFFWMnNyYXoveDI0SXc3bkxtWkg3Uzkr?=
 =?utf-8?B?bjRBODNaOXAxZFNLZnVlS2x2V2NZQ2NJNjdqVE1PN3h3aHBPM1dhMG9HSlVS?=
 =?utf-8?B?R0NIVWRHQWFIRHV6SnZaVitDOHJIWmROVVk5SExFd2lSSEpCSmtuTjR4NnVp?=
 =?utf-8?B?SkNHTmhuclhiSmxhU3Nkc3F6LzMxQ3JBVkhXS0pxTnZ1WE5OVS9FSlBjTHNB?=
 =?utf-8?B?WkdNdURjNGpSTmNrUTQ1K1Q4eGpQQmRyUEtDNnk2TVZxc3NJRnNHTjFYTGpI?=
 =?utf-8?B?WUFQTkZLMStOcU0xaUdwdDg0bHpiRmt6d1J2bWoreWFibG5ZUDI1cmRPODhL?=
 =?utf-8?B?ZjRBOUZKZmNwb1l0SyszaEVFeXJUY1ZKMEtGWjlRbWN5ZUdrNHZ0N3k1cWZT?=
 =?utf-8?B?TXhGaSsxLzBoQWhiREVMVDdXQTRDaVBmSjVPL29yWVFycnpyb2pncnY0Ympz?=
 =?utf-8?B?TGg5QWJTMERvNG4yVHBTYUhrYjJQL0dEV2lmdHVDRnNpSWJQTG5lbmZOZk5T?=
 =?utf-8?B?a0pXMjd4NVM4UE1uaXB1VzJ0c3h3b1Y0aEw4L0JvZk15UUZBdDhsemZHSmRp?=
 =?utf-8?B?OHlZUkpzSWVrREEzRmtoSmlOelRweGYwck0vMllYc24zT3FXcFZRM0FhS1la?=
 =?utf-8?B?WWo0cWhCM3lVTEJwYTQzNnZDNzdPTVVBeEF5bUxLdHdwQUxjVlFoUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce81a39-2e57-42e6-466d-08da48310afa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 02:54:30.0805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6WRNdqCWGQ9E5i/dQXDoz/Ik+X9plxqP46uFDup1wZ6YseiomzQTJh/fI8VjU42z5oxTaaEyvZ154Sv+5ilgzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2755
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSwNCj4gDQo+IE9uIDYvNS8yMiAyMzo0OSwgTmVhbCBMaXUgd3JvdGU6DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY3J5cHRvL2FzcGVlZC9LY29uZmlnDQo+ID4gYi9kcml2ZXJzL2NyeXB0
by9hc3BlZWQvS2NvbmZpZyBuZXcgZmlsZSBtb2RlIDEwMDY0NCBpbmRleA0KPiA+IDAwMDAwMDAw
MDAwMC4uMTdiODAwMjg2YTUxDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMv
Y3J5cHRvL2FzcGVlZC9LY29uZmlnDQo+ID4gQEAgLTAsMCArMSwyMiBAQA0KPiA+ICtjb25maWcg
Q1JZUFRPX0RFVl9BU1BFRUQNCj4gPiArCXRyaXN0YXRlICJTdXBwb3J0IGZvciBBc3BlZWQgY3J5
cHRvZ3JhcGhpYyBlbmdpbmUgZHJpdmVyIg0KPiA+ICsJZGVwZW5kcyBvbiBBUkNIX0FTUEVFRA0K
PiA+ICsJaGVscA0KPiA+ICsJSGFzaCBhbmQgQ3J5cHRvIEVuZ2luZSAoSEFDRSkgaXMgZGVzaWdu
ZWQgdG8gYWNjZWxlcmF0ZSB0aGUNCj4gPiArCXRocm91Z2hwdXQgb2YgaGFzaCBkYXRhIGRpZ2Vz
dCwgZW5jcnlwdGlvbiBhbmQgZGVjcnlwdGlvbi4NCj4gPiArDQo+ID4gKwlTZWxlY3QgeSBoZXJl
IHRvIGhhdmUgc3VwcG9ydCBmb3IgdGhlIGNyeXB0b2dyYXBoaWMgZHJpdmVyDQo+ID4gKwlhdmFp
bGFibGUgb24gQXNwZWVkIFNvQy4NCj4gDQo+IEFsbCBvZiB0aGUgaGVscCB0ZXh0IGFib3ZlIChm
b2xsb3dpbmcgdGhlICdoZWxwJyBsaW5lKSBzaG91bGQgYmUgaW5kZW50ZWQgd2l0aA0KPiBvbmUg
dGFiICsgMiBzcGFjZXMsIGFzIGlzIGRvbmUgaW4gdGhlIGhlbHAgdGV4dCBiZWxvdyBoZXJlLg0K
PiANCj4gPiArDQo+ID4gK2NvbmZpZyBDUllQVE9fREVWX0FTUEVFRF9IQUNFX0hBU0gNCj4gPiAr
ICAgICAgICBib29sICJFbmFibGUgQVNQRUVEIEhhc2ggJiBDcnlwdG8gRW5naW5lIChIQUNFKSBo
YXNoIg0KPiA+ICsgICAgICAgIGRlcGVuZHMgb24gQ1JZUFRPX0RFVl9BU1BFRUQNCj4gDQo+IFRo
ZSAyIGxpbmVzIGFib3ZlIHNob3VsZCBiZSBpbmRlbnRlZCB3aXRoIG9uZSB0YWIgaW5zdGVhZCBv
ZiBtdWx0aXBsZSBzcGFjZXMuDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBub3RpY2UuIEknbGwgcmV2
aXNlIGl0IGluIG5leHQgcGF0Y2guDQoNCj4gPiArCXNlbGVjdCBDUllQVE9fU0hBMQ0KPiA+ICsJ
c2VsZWN0IENSWVBUT19TSEEyNTYNCj4gPiArCXNlbGVjdCBDUllQVE9fU0hBNTEyDQo+ID4gKwlz
ZWxlY3QgQ1JZUFRPX0hNQUMNCj4gPiArCWhlbHANCj4gPiArCSAgU2VsZWN0IGhlcmUgdG8gZW5h
YmxlIEFTUEVFRCBIYXNoICYgQ3J5cHRvIEVuZ2luZSAoSEFDRSkNCj4gPiArCSAgaGFzaCBkcml2
ZXIuDQo+ID4gKwkgIFN1cHBvcnRzIG11bHRpcGxlIG1lc3NhZ2UgZGlnZXN0IHN0YW5kYXJkcywg
aW5jbHVkaW5nDQo+ID4gKwkgIFNIQS0xLCBTSEEtMjI0LCBTSEEtMjU2LCBTSEEtMzg0LCBTSEEt
NTEyLCBhbmQgc28gb24uDQo+IA0KPiAtLQ0KPiB+UmFuZHkNCg==
