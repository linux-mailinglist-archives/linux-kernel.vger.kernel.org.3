Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CE855F9DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiF2H71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiF2H70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:59:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2106.outbound.protection.outlook.com [40.107.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6950B38DAB;
        Wed, 29 Jun 2022 00:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIoApYUnoSSQAxFJlOU7RGezQCc3z+nu9aWcHIKpw3d/th3lEhRbLmNM7cMvMohMfyfEYlVEQWkEksgj7bEwyvPBX/M7WU3rc73zbaXIE5YNu3sJDNZH1sVgirkk45/3Fcwu8zRsGURiOe7XGsxBSpu+tdGMU3kS3Ud8qEjecDBgOe4DvI0pUoHzjcSD8i0i1LXM+NwceBITxyD/dvOtYEjbxTqRdpENraHLnrtJJ1hdJig5NlpI25NtgFEdfHM/KdDSCVpDrkZ5x2mMTYsLPKFtv5sxFQcSzlplcU/Ltsv5XaE0arIlGoVfw2aHH19wbD2wZChRhXXPJrD3YV82iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkbCBIEr404ewC5MA1e/VHWgpyTzsrxk9lPmVuP7DGs=;
 b=ZE2z3DJLoyzVjf9GrPuu6V2NiXc64EVBOpja+9R7s7YWwd2HwrOnyMx4aEIrGs1xF0/veTpfFCu8f3sNve9cy81dUWawqlRrRWx2/rA5eJh3ffDzxpIZ9x0Pc1VsLbZxqOb9k0dqPlaXpQAbLQmmpuFFIwshPG2Tt7HYMSLIXNzHaoHYuybmksS+b879Rqpk7zhOzQMbEX91A7kwhpNy2DWnAmsVi0JPOEbt5ENtukH8C92PMLIzTPzy/49JqFiNPcMqzeTUbowc5MieIZOytzcmfE7sq/uFEAJdvl6NAT3LN+6Hev1eUIgTOX098Q3M12xPwdI8HkVELeyvLCTWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkbCBIEr404ewC5MA1e/VHWgpyTzsrxk9lPmVuP7DGs=;
 b=xPPAX4MfBBWENYoFHQp7Viq0L4HJnNNogJk+A8KgmO3dOlUbggwZJ0MY06vS/1RETXW13p2Gk8XuKT840sfpb6iq/5wnoumDp+vY7MetnidtwFBrVqcN3uOQSHJQ0q5Uj6hfNop1FsUHKsuq1lwKtvUq2sRfUiLQzYwpIptUlR/H9e7weu/GgBIF6W7VGqMQS3ewYOAcF8WNqydTxMr53oUXCbLL2PxTHulmk6Ne7pNOQKVGuYCE1UL09LmDQLw31vTqQflXb2bz9jyA+8HQ5HGjh7pGo8DqT3pbWjU6aHOn7jZbn1ogl5gSCDmxhrBi9NPGXZw84uCARB/vxQzNCg==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TY0PR06MB5356.apcprd06.prod.outlook.com (2603:1096:400:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 07:59:16 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 07:59:15 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v5 2/5] dt-bindings: clock: Add AST2500/AST2600 HACE reset
 definition
Thread-Topic: [PATCH v5 2/5] dt-bindings: clock: Add AST2500/AST2600 HACE
 reset definition
Thread-Index: AQHYi2cqlkV0h2M2LEWiJm1FKKQpMa1l43kAgAAgOSA=
Date:   Wed, 29 Jun 2022 07:59:15 +0000
Message-ID: <HK0PR06MB32025ACEE605D1016DD3B99D80BB9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220629032008.1579899-1-neal_liu@aspeedtech.com>
 <20220629032008.1579899-3-neal_liu@aspeedtech.com>
 <b70e06e7-81fc-dfc1-f9c5-f83cb4a18293@linaro.org>
In-Reply-To: <b70e06e7-81fc-dfc1-f9c5-f83cb4a18293@linaro.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94a8f68e-3508-4649-a520-08da59a5431b
x-ms-traffictypediagnostic: TY0PR06MB5356:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cdePnGreTMMxw8iNlYt15E1ZNny5nmmZO6Q1Z7GAuQqDOiy7AGNciChBwR7PxUSvpSXnGR6mzLpl/MtItHR3a1PtWgdlpux8zJmt8fUbFAnjnBuQ4BDN4W4YEU3d92mtX8BUmXKadGcI/Qggn6WwR557ynDe5rjsykq72skBia9RuLm527Xa9w2djyRPKZVbvmbhQMJqCBC9xDdEJCnzRAEcbPXQCFL6u6UZKp+EZzQYshW8Vs2xA3zY1MWBzTrz+vdlRvA5RrY06Dx+1TU+/JsjXjM8fsPYdKagelXh3AyC4bc4kzaE6cmWZCTBF8SyBLXJIIV6O+sjeRtCUIe22nZf3jGYslo9rsZXHti/Lb5GwOfLFRldYJ1oEJnnM3lRGzCRK4erSZK5IsfwFy+i0hv5fA/wxAH/oMCkmTVjKRk1ea6mK8FhOji5fIQ1ymycDea+UDHLdXqXPDlG1emOC1WuyNnmwWoc/9OHieFAfP8XKdKBS0HVsQtn6SoNtj9692MaNY9xHR80LE6ExKmEilmHjVd07aKPKiK6pyCLsxMS6qJ6nMmHPFN5E7kkccs6k52MI4KygDXMQHx5fTBBqwoao6oi0QfwAI3rJgR5meYWLsZBBrtx2cvXNcUdd8uIEaed4qRVNLct83IzqLaDvxmb01oa3inlPnQImABejDDhlfsw5kYATWtaVuJVRbLTlZMpq3Pj8U0DpR9/r8NhIOoXKsbfBI9Pu4LDPMD3F82CQYYeSSnce2GxV1ZpJs34qy8bqBiG1cIPzXxz5noyNr4PenAp3NWHKXyp4ZjxyGSXygpdp9riMi+d351/0+EN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(346002)(39850400004)(376002)(33656002)(5660300002)(4326008)(6636002)(64756008)(7416002)(52536014)(8936002)(83380400001)(122000001)(38100700002)(478600001)(2906002)(110136005)(66446008)(55016003)(66476007)(71200400001)(316002)(86362001)(8676002)(7696005)(54906003)(66946007)(26005)(186003)(6506007)(107886003)(76116006)(9686003)(53546011)(921005)(66556008)(38070700005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnIrVGRiZmdEMGRSc0JjQVZzdFh1enljNWVFcCs5VnAxNVNlbFFOenlpU2ov?=
 =?utf-8?B?RnllcXhyNVJNV1o1THNLalA3OWR1VWZ3b3hBd21qbEJEYzUvQU5NNkRNQVEr?=
 =?utf-8?B?dWd6T3Y2cGlNN3N5aXNXcERzWDdRYWVRMHM4b2x1emhKT3ZVQ1RTbFJ1djY4?=
 =?utf-8?B?Ukdqa2FwSVN4UkovTFJjMzJseU5meVYxSVhxTVJXaEdxdXNyVFdaaVMvakgy?=
 =?utf-8?B?eTQ0TXRIajRNN1RGUmR6ZmErd2RWZUF3NjJDL1JEc2RzZnNjdmxzdU5yTUx4?=
 =?utf-8?B?RHJaOWl0K3M5U2t0ZnNGZm9BZFhsSHNJNWdZaE1yQmdjMU1ZUFpob0VoRmcx?=
 =?utf-8?B?STQ0NmRaclhqYnRhbENaSkI0R3RzZzd5REZDM001ZVgya0tmTkw0NGhZczBQ?=
 =?utf-8?B?L1piQnZUVlJJQStiNVM4bUU4K1QvQm81SllEVFF0aTdBZUttbU9wWnVsWXR1?=
 =?utf-8?B?cnhWeVlCekJUaVFZWm5sUEhrd053dXpkN2dnbG5SYmJrSXdrRjVacGVMdERy?=
 =?utf-8?B?Z2ZZN2g0aWNJQ2ZSdGpzSEpaTlFzRGFXVzU3R3FJbCt0UTJnZ0hXVmNydzA1?=
 =?utf-8?B?aWNzRlV2aWhSTXZ0bjhVVFo2Q01wQ0pIU2NKWmpQYUtMdDFnYWo1ZkpmanQ4?=
 =?utf-8?B?M1V1YS8rZ1FYb2YzaFNiejlGVXpzeGVweUk5OHhmd0pqeVhPOFNrMTNsS0ky?=
 =?utf-8?B?M1JXb1RlQU5WMDVyamlvRDBjcmxjSDdxNC9hTGRxVjc4NWtidURweEYxU0xM?=
 =?utf-8?B?alpZcktMdTRyZkllN20wNjU1QXh3cm5lUUhCQXNaVHRmTzR5Zk5TR3B2TFQr?=
 =?utf-8?B?RVRxMTBkRWlqTE1LWUhvenp4QTVrMDQvbGhXbE1POFVyL2VKOFZzMVBPVDc4?=
 =?utf-8?B?M2JDK0hFL1VGRGZaOVVFUzRNVlY2REQrT0dhYVB2YUdMUDliTjNzM3pGWW9o?=
 =?utf-8?B?YUVjSUlEV2x2OElOU1FpYzVtcTJCQm9mUnJLVzdCQW9DUEdCeDYvR3haeG9q?=
 =?utf-8?B?MVJTK2djRnFBbzUwZk1maFUwakpkMnRjaDdIVHpQaDhyOTVkVU4wbEJxczlm?=
 =?utf-8?B?bWVTc1ovT2h4OUExeTBGa3RaSjlqajVRR1ZIVEo3OTV5dGdhZGJOUlMraUhO?=
 =?utf-8?B?VzVTaTBBU08zdkFDZEw5OW05RWwwbEJzMWRZMjlxeVQ3akF6RFVORHJNOGJC?=
 =?utf-8?B?Wll6OWIwZTE2UXM0WTV2SGluOXNad0xDcExabGIzQ29qd0NJTm5RbHo4WTdI?=
 =?utf-8?B?R0FjR0NpemlwYnp5d2Q1UjN0cnZZMndVWVA2QnhOT3NwM0pBYlJINVd1MEdp?=
 =?utf-8?B?QndqakFEVGZLSG5abXdhQ3NOVUFqUTVvVWdDYmlMZnRIb0JXb3EzWm1Vby82?=
 =?utf-8?B?Q2hwSFQ5ZlAxOGlpdFRxaUNPTkpsTmhOSTVnbzV2TmJrZmlkbW1iYVlQWTU5?=
 =?utf-8?B?VnRUT2FDaGVKb2luVTl2T0h2WG1wd0dUVzRrOHRScS9RSXlCVUlIRkZBb0dU?=
 =?utf-8?B?elowT1JEOVZuVDUrbTFFVC84WUNMR0NUK3g5MFg4N215TlBzS1dFNVA5VWh3?=
 =?utf-8?B?N21CZ09uUlJlcCtMUDVOY051Y2N2amNFZkNvOUgvY21Zb3M3Tm9kSDhTV0I5?=
 =?utf-8?B?YUltOFAvMEtreEVTbHBrM2dsYVhiZHFVVWR1MHhFUlJidU40bVdOR2Q4UE04?=
 =?utf-8?B?bVVqKzVrLzFyR1drV092a2ZNN1BUcHVmNVFZK2MxbEY3YUxaTjlUYTJpMHJN?=
 =?utf-8?B?ZUovREFuZjMyMXVlU2Z6U3FhRTh4M3ZJc3BSVjQvNXJOdmtwam43b2JPUWJh?=
 =?utf-8?B?dWNwQ1lwMDM3T3NZNFJqOXBwREp2S2JWWjVWMnlMYWhyR2tZa0pQVUJCNUk0?=
 =?utf-8?B?bG1QQjFLYkJpMEZzNHlyMENndFlPcVk3NjNLbSt5cmhyUTJqeWhOYTNhVytH?=
 =?utf-8?B?dW54MHIyZGNhdWtJd0w1YWFNVEk2S2V0UGtYOS9Wbm9PRTFRZzMrYi9KTDNY?=
 =?utf-8?B?SVR1VHBCU1ZSZHFVcmN6VDFOWURoT1BWYTFjdExTNFJXQkdDOXFkMzdXNkNZ?=
 =?utf-8?B?b01MSjEwRituMWZGNS80YXhPTmRxUlg5c1p4SE1ud09CQjNaczdLU2dvRDNa?=
 =?utf-8?Q?0NopqsCNQSxiqWrhRAYPizci7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a8f68e-3508-4649-a520-08da59a5431b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 07:59:15.6395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYQWUlOoWXgAvFyjMO0fV8VgeZ5rQRxDsvSfYIvcCs4XoAMr569Q0HT+mgOKI8bnO7ioaMEFoZHEpxMWziNSiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5356
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVu
ZSAyOSwgMjAyMiAxOjU4IFBNDQo+IFRvOiBOZWFsIExpdSA8bmVhbF9saXVAYXNwZWVkdGVjaC5j
b20+OyBDb3JlbnRpbiBMYWJiZQ0KPiA8Y2xhYmJlLm1vbnRqb2llQGdtYWlsLmNvbT47IENocmlz
dG9waGUgSkFJTExFVA0KPiA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+OyBSYW5keSBE
dW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz47DQo+IEhlcmJlcnQgWHUgPGhlcmJlcnRAZ29u
ZG9yLmFwYW5hLm9yZy5hdT47IERhdmlkIFMgLiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5u
ZXQ+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+IEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgSm9lbCBTdGFubGV5IDxq
b2VsQGptcy5pZC5hdT47DQo+IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAYWouaWQuYXU+OyBEaGFu
YW5qYXkgUGhhZGtlDQo+IDxkaHBoYWRrZUBtaWNyb3NvZnQuY29tPjsgSm9obm55IEh1YW5nDQo+
IDxqb2hubnlfaHVhbmdAYXNwZWVkdGVjaC5jb20+DQo+IENjOiBsaW51eC1hc3BlZWRAbGlzdHMu
b3psYWJzLm9yZzsgbGludXgtY3J5cHRvQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQk1DLVNXIDxCTUMtU1dAYXNwZWVkdGVjaC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMi81XSBkdC1iaW5kaW5nczogY2xvY2s6IEFk
ZCBBU1QyNTAwL0FTVDI2MDAgSEFDRQ0KPiByZXNldCBkZWZpbml0aW9uDQo+IA0KPiBPbiAyOS8w
Ni8yMDIyIDA1OjIwLCBOZWFsIExpdSB3cm90ZToNCj4gPiBBZGQgSEFDRSByZXNldCBiaXQgZGVm
aW5pdGlvbiBmb3IgQVNUMjUwMC9BU1QyNjAwLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmVh
bCBMaXUgPG5lYWxfbGl1QGFzcGVlZHRlY2guY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvaG5u
eSBIdWFuZyA8am9obm55X2h1YW5nQGFzcGVlZHRlY2guY29tPg0KPiA+IEFja2VkLWJ5OiBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+ID4gLS0t
DQo+ID4gIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLWNsb2NrLmggIHwgMyArKy0N
Cj4gPiBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2FzdDI2MDAtY2xvY2suaCB8IDEgKw0KPiA+
ICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLWNsb2NrLmgN
Cj4gPiBiL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLWNsb2NrLmgNCj4gPiBpbmRl
eCA5ZmY0ZjZlNDU1OGMuLjZlMDQwZjdjMzQyNiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2R0
LWJpbmRpbmdzL2Nsb2NrL2FzcGVlZC1jbG9jay5oDQo+ID4gKysrIGIvaW5jbHVkZS9kdC1iaW5k
aW5ncy9jbG9jay9hc3BlZWQtY2xvY2suaA0KPiA+IEBAIC00NiwxMSArNDYsMTIgQEANCj4gPiAg
I2RlZmluZSBBU1BFRURfUkVTRVRfTUNUUAkJMQ0KPiA+ICAjZGVmaW5lIEFTUEVFRF9SRVNFVF9B
REMJCTINCj4gPiAgI2RlZmluZSBBU1BFRURfUkVTRVRfSlRBR19NQVNURVIJMw0KPiA+IC0jZGVm
aW5lIEFTUEVFRF9SRVNFVF9NSUMJCTQNCj4gPiArI2RlZmluZSBBU1BFRURfUkVTRVRfSEFDRQkJ
NA0KPiANCj4gSSBkaWQgbm90IGFjayBzdWNoIGNoYW5nZS4gVGhpcyBpcyBhIHNpZ25pZmljYW50
IGNoYW5nZSBmcm9tIHByZXZpb3VzIHZlcnNpb24sDQo+IGludmFsaWRhdGluZyBteSBwcmV2aW91
cyBhY2suDQo+IA0KPiBUaGlzIGJyZWFrcyB0aGUgQUJJLCBzbyBOQUsgd2l0aG91dCBwcm9wZXIg
ZXhwbGFuYXRpb24gd2h5IEFCSSBicmVhayBpcw0KPiBhY2NlcHRlZC4NCg0KSSBjaGFuZ2VkIHRo
ZSBvcmlnaW5hbCBkZWZpbmUgKE1JQykgaW50byBkaWZmZXJlbnQgdmFsdWUgKHNlZSBiZWxvdyBk
aWZmKSwgYW5kIGFkZCBhIG5ldyBkZWZpbmUgZm9yIEhBQ0UuDQpIb3cgZG9lcyB0aGF0IGJyZWFr
IHRoZSBBQkk/IEknbGwgYmUgYXBwcmVjaWF0ZWQgaWYgeW91IGNhbiBleHBsYWluIGl0IG1vcmUg
ZGV0YWlscy4NCkFuZCBzb3JyeSBmb3Igbm90IHJlbW92ZSBhY2sgd2l0aCBuZXcgY2hhbmdlLg0K
DQo+IA0KPiA+ICAjZGVmaW5lIEFTUEVFRF9SRVNFVF9QV00JCTUNCj4gPiAgI2RlZmluZSBBU1BF
RURfUkVTRVRfUEVDSQkJNg0KPiA+ICAjZGVmaW5lIEFTUEVFRF9SRVNFVF9JMkMJCTcNCj4gPiAg
I2RlZmluZSBBU1BFRURfUkVTRVRfQUhCCQk4DQo+ID4gICNkZWZpbmUgQVNQRUVEX1JFU0VUX0NS
VDEJCTkNCj4gPiArI2RlZmluZSBBU1BFRURfUkVTRVRfTUlDCQkxOA0KPiA+DQo+ID4gICNlbmRp
Zg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2FzdDI2MDAtY2xv
Y2suaA0KPiA+IGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hc3QyNjAwLWNsb2NrLmgNCj4g
PiBpbmRleCA2MmI5NTIwYTAwZmQuLmQ4YjBkYjJmN2E3ZCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNs
dWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2FzdDI2MDAtY2xvY2suaA0KPiA+ICsrKyBiL2luY2x1ZGUv
ZHQtYmluZGluZ3MvY2xvY2svYXN0MjYwMC1jbG9jay5oDQo+ID4gQEAgLTExMSw2ICsxMTEsNyBA
QA0KPiA+ICAjZGVmaW5lIEFTUEVFRF9SRVNFVF9QQ0lFX1JDX08JCTE5DQo+ID4gICNkZWZpbmUg
QVNQRUVEX1JFU0VUX1BDSUVfUkNfT0VOCTE4DQo+ID4gICNkZWZpbmUgQVNQRUVEX1JFU0VUX1BD
SV9EUAkJNQ0KPiA+ICsjZGVmaW5lIEFTUEVFRF9SRVNFVF9IQUNFCQk0DQo+ID4gICNkZWZpbmUg
QVNQRUVEX1JFU0VUX0FIQgkJMQ0KPiA+ICAjZGVmaW5lIEFTUEVFRF9SRVNFVF9TRFJBTQkJMA0K
PiA+DQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
