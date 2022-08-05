Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB50658AB06
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbiHEMtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiHEMtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:49:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783011ADAB;
        Fri,  5 Aug 2022 05:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrDp6Ak5h9etV42BwEBWV84FgdlfTRjQoTYtxzoWVeNw9swRmZqH20OwLcZzywm2ZJFHkcpsFDwHaLRgZU8BphrigecZP0h+O9T2fe1nJoAJEqZdG9EwR1qVqmBCk0N5ax8wjrhXSqvbahO5Kn/CCX7fFaiMkDh/x/OAE/Fz9K3TmoCrHr7Dv+0B0Lumjjiw/PFW9lwE1v19H61zOiAcEJHsvzxM9P0Kcq4lGDlHL/9hiCyN9lECTsDDvCf8qGrzbfXANbRBHdQR8rumHkMQWMNkUuhKrov5haSLVfzrD2OhkCZvJjFTltTQOE171IcquFUeoquzNPmnWnVfvjJzuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKNjEjMxMy//0sMaVv77sW0Tgf2w/mNrQTe96oCJRAg=;
 b=la8ICws8z5Zu4OJ/cO3maaaipkjpv1H8SOWpPVTVrB7/qvLWMdWqc2/dwdcM0hQyWXDs2i63tgi6p3lBs5L9W1D0veWo7/XEX7f18unUbZGNrH4aWIWzGpOH0/nC4kKOMW4ZlhZ6La3T6KUfbywkckhan6jwfZ4unXxpx+llfFODWo+dc5qzz132ni3nQQsqWLCsAb8FsBcQpnWYvDTs6U2kGT5rnqiLN1s6+h3ATU94FfcV81YW4RVaiH0t3kgQea2Khh/9+O+dtGAPCzFnCLP96jSqlxzIxJHVS7snA9aPt0zea0XJLFCbnJ1M5CRU9YGI/NacYcxy3jynbdDnJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKNjEjMxMy//0sMaVv77sW0Tgf2w/mNrQTe96oCJRAg=;
 b=jgGB2qdb48rbQ8D/gP0gcX4unJBFDZB/K8OsXtjnJ9CYqE4WPhlH3rpfD+528tgiZ+lMWEJ/Iw6Rwr5+glp53SYEoxotTsVKobIchO0H+wbqXWU6Qe1kSWy9Cz3z2oU8pZmKyzYawQQOKheslyJ6XZAsGyUzUh935ShrCJ+kDCE=
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 12:49:42 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5504.015; Fri, 5 Aug 2022
 12:49:42 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v1 2/3] dt-bindings: firmware: imx: Add imx-scu
 gpio node
Thread-Topic: [EXT] Re: [PATCH v1 2/3] dt-bindings: firmware: imx: Add imx-scu
 gpio node
Thread-Index: AQHYqDMKjKKUMsI6PU+rGoy4LyEUHK2f4JOAgABiV0A=
Date:   Fri, 5 Aug 2022 12:49:42 +0000
Message-ID: <AM9PR04MB8274CE6735619BD6B8FB0143899E9@AM9PR04MB8274.eurprd04.prod.outlook.com>
References: <20220804184908.470216-1-shenwei.wang@nxp.com>
 <20220804184908.470216-3-shenwei.wang@nxp.com>
 <8e1ffa95-686b-ca4b-1a2b-b7115dc41c98@linaro.org>
In-Reply-To: <8e1ffa95-686b-ca4b-1a2b-b7115dc41c98@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9624d62-9183-4cce-1c0d-08da76e0f79a
x-ms-traffictypediagnostic: AM0PR04MB6452:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zXBrHw5au6kOgbbscPkAvSB2FqJ3xtMnhIpYxDhmFHtQUZ+7NmoxfPdh8i69ck7E1kG5+UhsF6NSagwGCdALhk0ZZ23PEZlZX89ZiOmBbXmYfQ3PCrTKn7Xt67iopJuzAoNkPb0hrmy8vY08ETBSXLuHCnZjs3MUTpYS7jUR6BcN24UziP/LsMhpFmeaJ2tq6ZDQNUx7UKCB6pKBRcbxLiSkBTs0/QDy05nsMMqs3Of4plRwPsxNMH4631zL1d6hueKn8Az/YYuR8iOlDlEx9WRxMSlJstGXhFDGYDyWxTGFytvREtxWZWXjqQ0MeSDpBEsbrvbYUPdDZ2NEQkWUx2xce+rQeNgTL1cHwL4d4pYXfFpH2lGwywcGixhiyOM4PQPNYlpUubf2cEtdlAiak7wUFc1BpfSFl5bW38y+LoOgXCKGJ4wnwPnNalaqQKORsgmCs4oDSbD70a45gX4bRcvFvC3gKDIKby0fnAB9XnSj3RotrdxA1D7rPBznw1xXVFSzTZlPO888eD+AWQaHdnElzbTaWlHsa12Z1R7kgEViis9otZ9hih0brw4POiYTA3hnn7OkPAHkNGcTgA3Za98TtcPEssWZrKcLRLEcmB6WH6MckFTK3iX34wOiNChEyQR0jaOCGe7LhP9To5C+m8f+CZNoe1nh/w6w8HiVqhXhB9bz4Vzku9Q/CtNNBAbcGQvK8Srj+XO7Gn2TMNaiKA+k4yke14QCjgVFvmwwqarsazr5ZyDVW5mw3IvUZ67O3Q68hs8iRmovxN+YOgGo5ullYKWkjmTtdHNapWuE4smwEUaew03wR3Y8y2yHzEgZe31hPAVyTpmPtByNGtgfsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(110136005)(6636002)(54906003)(316002)(71200400001)(478600001)(41300700001)(2906002)(55016003)(76116006)(66946007)(5660300002)(4326008)(64756008)(66446008)(66476007)(66556008)(8676002)(7416002)(44832011)(8936002)(52536014)(38100700002)(122000001)(921005)(38070700005)(86362001)(33656002)(7696005)(53546011)(55236004)(186003)(26005)(6506007)(9686003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2JwTU5QVGdEYmMzdlB0REhtcVpndDMvaXFNcjNTSWZvS0YzUnJCU0tYMGpo?=
 =?utf-8?B?RlZWTU9SQWdJaXdpSUJTMmxUSnkyZGo0ZVhITit0UEpNNjY1TVRPMHJENS9B?=
 =?utf-8?B?S0JacDhnblF3SkJLRU9TakMvcE5aNU5PTndyVkF3d25kV2tyTnkvcGM4ZGtN?=
 =?utf-8?B?SEtwR3FyWVp2UUIreGlOZHpVRXVxL3F3Nm9pTC9PWHBUUVJsdnMzOTRZTEU5?=
 =?utf-8?B?WDRiSTBNQlFCYmZmY1dLVVNKYlF3Vm9SbXpnTHVjN3JVMTY1MDM4OUlrV1RQ?=
 =?utf-8?B?a0lQWG8ycWUxSmhENm40QVNKV0ZNUFVobTZpaTlzNzEvd0xkbTllZHBXUGhR?=
 =?utf-8?B?cVpqb0lWRk5DUjFsd1pQZ0Z3eWlyZDBOZ2loTVJxYnhnZDdJaThoZ0FaUGVi?=
 =?utf-8?B?TnlRdGVpU20zN3dDTjJrZ21icW1zVUxVNExjbHlXL240UUtiMGpwVjBBK3o3?=
 =?utf-8?B?MnVUY1YwVEI5V2tldy9nN0RyanExTzhRRHNxMk1hYVZwZERvblJoR0lCUitD?=
 =?utf-8?B?QjFvWTdxSFRRakJ0Zm82SXVndXovTk14TjR0cmVMTUJOcU1ZS0thTW0raGFC?=
 =?utf-8?B?R2Z3TDh5dWVBc29KekdnamViUGpwWi9odmVOZVVDWklSOGZGcGFkU2ZYWmdP?=
 =?utf-8?B?WWlPeUtweEJvc24zR0NtdmFQM3B3Ni9Rb1ZWTmF3RUhmTXNsMEQzVVpuSGoz?=
 =?utf-8?B?am9tVytYMW5LdGFhTDdNOU1SSFVRR3ZYcjZwMlM5WHUzeUVzZGFHNlFYVmo2?=
 =?utf-8?B?NEYrR3oyUm4zVHhpcVpJQmtYS0Q0eU1tOWZFdHM4QzhQNE5XSzZKeExUMElO?=
 =?utf-8?B?L2gvWlgveXh5Y3NmOFAzY2dpTWlCemorR1ZwUXhwL093TUNBWkRrR09NQzZ5?=
 =?utf-8?B?NFFoVmx3UGpLTWlLek1YVEVJRFRndTJUdjJ3SGhzV21vbWxWSEJ2K1BEUmZz?=
 =?utf-8?B?QnFaSUIzRXJ3UkxZNzZsR0ovajhWUGhyb2oyZHFiVjlRNHExOEZkQlE2Mzdo?=
 =?utf-8?B?aW9GSEZXSThjZStPVGgxVVdtanVNRUV2eFN2dUEyMndTOUoxcGNaazFBVjJO?=
 =?utf-8?B?c2RJZ21ieW5kQkE2alNDSS9QS2J0NnEveDFTS1RVUkhJMThQdDJsQ3VwQ2h3?=
 =?utf-8?B?QUZhcmx3YVo4eWExZXB5bHdncXpCMk1iVmdXa3B4QnAzM3dzUzBMT283NjB1?=
 =?utf-8?B?aWxyWlRHajRHdndjRXYxdHk3TWZJVnRXdUVndHRKNloveWFDTDZrcGRGWDFY?=
 =?utf-8?B?R3ZxTzFVY0tUTml1NEVNR0xFclBybm9pb0F4cWNGcDhMYWZuRlhDUWJsOWp3?=
 =?utf-8?B?bGZkYzcrb3dtUkVHWE9xWVBTSXJjUmVrWHpKVEVMWU1VdlI0UDZuMjU5aTl3?=
 =?utf-8?B?dmcwd29CNm55YlB0dnVTSS9ZMVo2cDYvUUxqQXhCVTdCSzBSVVU5SWRLMHRX?=
 =?utf-8?B?SFYyR2JESFlrLzU5NVZKU0R1MUhMQk02NitKWm03YzA1bUlwYXEvTC9kNWQ4?=
 =?utf-8?B?ZDh4UXhmRTg0eE9HVWc0YjRqWlBUSnpLTFAzWDNZNzNoK2Z5Tm5Kb2dCR0E2?=
 =?utf-8?B?SmVHTG5mQ09wd2ZqZEFwTXhOQUVIMXBSSzFqSXBaMXBMRTZDQ1A0WXc1R0NX?=
 =?utf-8?B?N1BNLzlrenNqWmRRNWU2Q2pETG11QUx4ZmdxdVZQdlNoRVpUbnBXMytBSnpC?=
 =?utf-8?B?RGxjY1QrMnkvNFlIRkhZajd4VjJxbXQ5OEFEU1hhMUNtMFUwK1cvQkgvR3lK?=
 =?utf-8?B?WmJGdDB2dk1FcWNxNXpnYmZPZXoveXZjOHlnTFhzektWWEZuU1pGcHVOblNG?=
 =?utf-8?B?WkpxUGYwQ3pJbjRRUUM4UFlzMUc5M2JzbCtGR28rZml4S3VKdUlnSlMxWmYy?=
 =?utf-8?B?bjNzQjhlWUVNV3VsQlU3eHllT0xVVlowMlNJeGhMNFpWOVZFNzdGcWJZZENz?=
 =?utf-8?B?NWZqTXlBYWphSHg0eTBPK0orcDBJOG12dE5pSUg0bFVKVStVVGxzSThKTkdG?=
 =?utf-8?B?WWMrY1hMcE1YOXdYcWNlTWRXOGxoaFFmTGQ3ZVdBT0tTKzNpWE8xNEZwNVdp?=
 =?utf-8?B?Q0JVL0p1VGNxS1dUZG5EbDcrMFhqRXRrbGhkSFh3MW1ISlB4TVZ1cUpQZXY0?=
 =?utf-8?Q?DeZzae+2npF6vwnWTQsCVX38o?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9624d62-9183-4cce-1c0d-08da76e0f79a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 12:49:42.4858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xhaHwXKZAZv5UQWq80uINPISCaYSR9G5k0Rwe2vKs1FcsIknObDbcCZsUUEvQVwlfu8L2Z63cEaGOtsAv6x0NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6452
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIEF1
Z3VzdCA1LCAyMDIyIDE6NTYgQU0NCj4gVG86IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5nQG54
cC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGlu
YXJvLm9yZzsgbGludXMud2FsbGVpakBsaW5hcm8ub3JnOyBicmdsQGJnZGV2LnBsOw0KPiBzaGF3
bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9u
aXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhw
LmNvbT4NCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYx
IDIvM10gZHQtYmluZGluZ3M6IGZpcm13YXJlOiBpbXg6IEFkZCBpbXgtc2N1IGdwaW8NCj4gbm9k
ZQ0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiAwNC8wOC8yMDIyIDIwOjQ5LCBT
aGVud2VpIFdhbmcgd3JvdGU6DQo+ID4gQWRkIHRoZSBkZXNjcmlwdGlvbiBmb3IgaW14LXNjdSBn
cGlvIHN1Ym5vZGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVud2VpIFdhbmcgPHNoZW53
ZWkud2FuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvZmlybXdhcmUvZnNsLHNjdS55YW1sIHwgNSArKysrKw0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Zpcm13YXJlL2ZzbCxzY3UueWFtbA0KPiBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9maXJtd2FyZS9mc2wsc2N1LnlhbWwNCj4gPiBpbmRl
eCBiNDBiMGVmNTY5NzguLjA4MDk1NWI2ZWRkOCAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZmlybXdhcmUvZnNsLHNjdS55YW1sDQo+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Zpcm13YXJlL2ZzbCxzY3UueWFtbA0K
PiA+IEBAIC0zMCw2ICszMCwxMSBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICBDbG9jayBjb250
cm9sbGVyIG5vZGUgdGhhdCBwcm92aWRlcyB0aGUgY2xvY2tzIGNvbnRyb2xsZWQgYnkgdGhlIFND
VQ0KPiA+ICAgICAgJHJlZjogL3NjaGVtYXMvY2xvY2svZnNsLHNjdS1jbGsueWFtbA0KPiA+DQo+
ID4gKyAgZ3BpbzoNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBHUElPIGNvbnRy
b2wgb3ZlciB0aGUgU0NVIGZpcm13YXJlIEFQSXMNCj4gDQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCB0
aGlzIGRlc2NyaXB0aW9uLiBIb3cgR1BJTyBjYW4gY29udHJvbCBzb21lIEFQST8NCg0KSG93IGFi
b3V0IGNoYW5nZSB0byAiQ29udHJvbCB0aGUgR1BJTyBQSU5zIG9uIFNDVSBkb21haW4gb3ZlciB0
aGUgZmlybXdhcmUgQVBJcyI/DQoNClRoYW5rcywNClNoZW53ZWkNCg0KPiANCj4gQmVzdCByZWdh
cmRzLA0KPiBLcnp5c3p0b2YNCg==
