Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BC157C259
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 04:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiGUChS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 22:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiGUChQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 22:37:16 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70055.outbound.protection.outlook.com [40.107.7.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBBA74783;
        Wed, 20 Jul 2022 19:37:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8dIjhhhqTOWH5lj+1T50J5lcKPlHs7lHrI7XvVEkWNHqdN7NQDS02SaffYUKOERGNjVchUSVXqQ6IOJkI6GEa27n9rC5vH3BW3S+Md+hVVjT3Dxgg8baWXgAj2Kwa+lIANv226yj9dG96VGXFfLDP0eo3gR85/SzPsduK0MsVwT+V0fHYY5QmHdoZyeu1RSDWzdIa591gJANbnLaUOabrDFFmBblDM/VVLz4FMNdPyASJSWbtWVMkegdjMmdhWAJZfycYAiJQuaIiuklxZ2x9/VVChsDd3THOX8z5kK0bswCZmHlKSKHDycFTMmYcHmf3UNrcRbm2urEQnFOLOfNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3HdvcIVanqFn1P94+VpmJFobHcOh/h1enGw6q2Fq2M=;
 b=NDLL6egMsmbY1ulkbq/UdmwEh/soodUmzovYNDxoGmpUGSOX9sPOwStYqHciQfDDTlLsgMjQ/dGMqdFTX1UWcusKd+wewnkD+UPDT4dq16Xy/dDiv8OsKW7DT499I/Pn2JmgufRoB5FaINYh3grv7gl7HbgOsKwi2lvKX1iTKsJRmWYWtuw4rf+stcvrVziUpFj0bN6LsULhgwPEz6OGgEeUBYs18WOnIS9w8MEq2pZLZa+KkRr6hV4qE09vne0o+od9W0Aqlr/NgIb47XhKsMKYpF5i4AqaYp2TBk01BBXztp+zAxSXpF+FxfEj3C8mOnMqcQ+EhEIq8dq9kC+SfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3HdvcIVanqFn1P94+VpmJFobHcOh/h1enGw6q2Fq2M=;
 b=gNKHCd+2IvuSzoo2n4vJkcUIVRyGgXWzQVzQuU5KQ6stKpC2WHXZ3wpCpJdNhDLnKvfErpivteVURrGUkD9idNmQYFETJ1IqHl8RqL0N5YzycV3rPqDiUX+SaOiz6P/UH21HolX/HB7Hr/OKsugbaEbJOn9TNHwRZ957U30gQNg=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM8PR04MB7476.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 02:37:13 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f%8]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 02:37:13 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v2 1/3] dt-bindings: PCI: imx6: convert the imx pcie
 controller to dtschema
Thread-Topic: [PATCH v2 1/3] dt-bindings: PCI: imx6: convert the imx pcie
 controller to dtschema
Thread-Index: AQHXmxHjjWw2/K3ZFEmbAw0FMtAtxK2H/LSAgAB4S8CAAU0mgIAAXOfQ
Date:   Thu, 21 Jul 2022 02:37:13 +0000
Message-ID: <AS8PR04MB8676084A32CAD423BAD6EEEF8C919@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <AS8PR04MB8676C863CEDCCE1C0D1B04578C8E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20220720210321.GA1656074@bhelgaas>
In-Reply-To: <20220720210321.GA1656074@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 888c042a-ac21-4b7a-2eec-08da6ac1eb48
x-ms-traffictypediagnostic: AM8PR04MB7476:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XfCefKBIchwuAjPu2vfyfMiC1KRVICcgr6j317xJZfWxQ0n/YL9X0AhlEMU015rDiY9KgI2ssDp6TRoIFYxtyCbxNpk334Bt4G9BDTkWvrK5FKaxdugHO71b+eHvL8mdni7ZciT0O+dv/V4mXBProb3MAi3y3kW+NOAXMGrxknk/Q5zzbQ1sQKn4bdLG+nGUrtVAiR3hSkERHYFitZmC2F3bgUrDbA4EGaEUqv/fKLYrcFEFIuhHiCBQpi8L2MYoQ7GP4yeG0que1B7qgeOnvkkXWRP0kxGuz/KV1lJMpbt1P3TzwskonhWF7lZTFyg7eDf8rUw8trtM5PVmBZddMwfyViutvwskDkq4zvJyGKOrUnmfMqy9a8SRUqcwcy77RQ6UOIH6QB64SSbDZ2JVz66lb6tqTZBe60K04pT2tDTxZzu1A/zC7e08k9q2OZ4d98nlxdQQLJiYO/4wiGg1V83a0NfBNSbJY7A4Le4PgX5YzKRyWmOGXQKZWDU4z78p1aPSG0qDGBemYzGlaq/JMFsYO5ZNAGUVgS8s4jn5zw9n2sAEfotpak+JNinxgA2sNx31XkT0xs2Sf3spOYBQZ3C9PRVYlLbEGqKiaJeW2tMff6deZuEKXLSS3xmq3gl0kFiQVQgC205xAODqENPQ3rHaT5StG4ed9tQ/P9s0g+p2kKIjxwPxvq9mfBf6pqLj7dchVhxgJ3ujMPKKW47WHK1BnQXhVJ0X8QWgtWp2kESveOo6KyjyRSsw07hzfDa0xBApn9y/7lm8tTKDyt/eEEzOpmxN2cR1lJg1l2VcKkwtfhT8EzSkQzJ7I0GOcZR3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(8936002)(83380400001)(66476007)(186003)(8676002)(2906002)(52536014)(41300700001)(26005)(33656002)(66446008)(55016003)(478600001)(71200400001)(53546011)(9686003)(7696005)(6506007)(38070700005)(86362001)(54906003)(6916009)(316002)(44832011)(5660300002)(122000001)(4326008)(64756008)(66946007)(38100700002)(76116006)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1o3WXJtOEVwMWhpWjIvMWg3d29IeFhSS1F1Z2s4ZXk1VzRWcU1SZTZCbHo3?=
 =?utf-8?B?Z1RjQTgwaUZNTlI3a0dYT2REb0FXNi9aVVpMODRuUmZ5VzZPakZnOXVaclZu?=
 =?utf-8?B?N2NmQzlkR3FBbSsrMWQ2MXQ0SzlTMVJvSnhLU3BudzUzd3E1SlBRV2pvTG1T?=
 =?utf-8?B?bmVmOWprVzB0MU5XTXNXY28wQXZWek0xM3BqQ0YzVVd1Y1ZxYzg2eDMzNWdS?=
 =?utf-8?B?c0NBNjJ5VnpkTU5kWjlJSFVyK0Rhek1wdUVBSXJteFlmNFh4d2FRa2haUmlp?=
 =?utf-8?B?aUhpdzcrbzYwZGkxT29ZeDJYY05xN3N1d21wN2hJVStidTRSMHRuMThqeXhJ?=
 =?utf-8?B?WWdSN1NmN0xtc1JkeC9BdHVmaThRd0FKY2lGMGJITWRpeEU2SktUWFhsMWJV?=
 =?utf-8?B?a2kwbVBrVHZWM29Lc1hTUWRPMGFOOWVNWEJBVzQwMzFFUDhTMmMxMjNhaHA5?=
 =?utf-8?B?TmIxQjJ0Wk5aRDVEZWEwY3h5REhySU82MDJRZ0Y1VEExNlY2N3A2R1ZhYnZk?=
 =?utf-8?B?V3FqdEdRYjdEdmZKV1Rqb1V4SFN3cXlYczNJbDNYTTZUNlJyN0Q5VjByNHdx?=
 =?utf-8?B?cmxJb2JVOFhFQnJwNzNLK1h1ZWNJT2Frek1wdEJja2JyZDFOVzZtc09kNldh?=
 =?utf-8?B?QS9BbFFZdnU0VEJWT0RqNWtBa0JJRnZVWG9qQ1AxNHhZM2l2UjM4NnN6d2xr?=
 =?utf-8?B?ZUJGcEUzdW1HamsvaFJ6eVBDazdjWi93QkI2Rk80clZtYllvZXJXbGk2NXVm?=
 =?utf-8?B?amdVWm9vTDVRR2ZMbG8yblJod0pVQW56dTRnRktpOXpTVHNuUXVsckVhb05P?=
 =?utf-8?B?aGRPQ0N0eC9ZRXRIcmREV1BTYXRFRnZGTENuSzc1clo0T21COFM5MHIwbW5T?=
 =?utf-8?B?K3VqRkgxQXhqWHZxZnoycUwwNDMyQU1hcjZWWmV5UjVsSzhXaTlZL0Roc0pW?=
 =?utf-8?B?L292dXh6R0JGV25UNHU0NHZ1NkhTa1U3MGNhbWFPMTRnR0xja0dydGVsaFcv?=
 =?utf-8?B?ZDFHVk9INDJHaVdRZUowNjduUXVZZ0lRbVJTRm9yRnNkaFNldHlyUUZLbE54?=
 =?utf-8?B?UkdzTEpMbkZkTkVjMThrSExCWWRxVjZaeXRndWhzRXpBMnVpdUV3WXBJUWto?=
 =?utf-8?B?VEZyTlNiS3FqVDU2dzBJWEFrdXA1Zlh2d1QvQklpOVhwTDlTditlT3hzSS9h?=
 =?utf-8?B?THBNRktaNXVPMkJlQXJzMVZUMUVEQU1QV3dyVjdZODNPaVJUNUh2MGlUYXR1?=
 =?utf-8?B?TGFJVXpVZEJKT2laamE3VnFRZFQyUldFZ0VzQzlqVFIxTXVyS24zWmxMSkdZ?=
 =?utf-8?B?UmNLczRtSC9qSnB1Ymh4KzBxeThZSkFCSmJDZmY5MFNIcVNRU2M0UWhlMnky?=
 =?utf-8?B?SFVhYzRHdFFzSUVlRDBuYmtSV3dQWG41R3M0aFpSRExxQjc2dFdhRnRXZEVt?=
 =?utf-8?B?Mm1kQkczWWtXb09jRWVXUDBEL0w4amcvd1V4M3M2NmpaQ1p6VmpPdnc1T3N4?=
 =?utf-8?B?V3ZyYTY2RGFoaDFMR2I4TVM3ZFF2aGR5SkF0OXNRNmRmZ1laSy9ETXhzNDlL?=
 =?utf-8?B?cVpIMTdScDZGZ2tRVXZyekhnUjNJblBoUHUzenhPQ29XRFViSFR5WUdtUUNW?=
 =?utf-8?B?Ry9SNE1qbjhTcU4wRWJDM1AxWUJZb1NIckhXc3ZGaE1kbmphV3NaVVFRQzkw?=
 =?utf-8?B?OVJNRHZkS1daSWVZY2RhSDcwZENXMzJ2U0luRGVTRXNCNSs5aktpSmg4S1U0?=
 =?utf-8?B?d3NNM2RjVnFJY052ZWZTMWkrUk9xNkVxMXFYS1hzSVpwR1Vjd0lHQ09WSlV3?=
 =?utf-8?B?VklrVGQvbXR2eTlOQVB3Nld5TU5neUFhcENMNTV5c0xpWjNjMTR4bXNoWTVm?=
 =?utf-8?B?ZzhWV2dJakF5WlBwOFExTzJZVXRxM3p5NjVLcHQzRUUxS3JpK3ViNXJMN2t6?=
 =?utf-8?B?ZERjdE1ZSDF4WWpyejl6WTRPVURGM1Z3TWdiUGJFY3VJZWJibE0rUGhaYm5C?=
 =?utf-8?B?SEFwZmE3WGE1UUdEV0ZNeGh0NW0vVGkwOTJxcmw0YjQxTk9nblUzN3hYdmlm?=
 =?utf-8?B?eEZSUkdXSmt2YmZsYVZNQXZHVmtWcUtvK0kwMDBHamsvTzhDUW9vQXBSQ25j?=
 =?utf-8?Q?H+sjn7wNQdStWnPWQ+aL5n6Ye?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888c042a-ac21-4b7a-2eec-08da6ac1eb48
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 02:37:13.4487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UY6UArYAKcneF7jzKK403hykle+dcxkq4SRPxtdqWPPKvx+CkZPFtMvIJRLY3u84nQ9XwbCz5oZxopi0BbG2Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7476
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLlubQ35pyIMjHml6UgNTowMw0KPiBUbzogSG9u
Z3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IHJvYmhAa2VybmVsLm9yZzsg
bC5zdGFjaEBwZW5ndXRyb25peC5kZTsgZ2FsYWtAa2VybmVsLmNyYXNoaW5nLm9yZzsNCj4gc2hh
d25ndW9Aa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGtlcm5lbEBwZW5ndXRyb25p
eC5kZQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvM10gZHQtYmluZGluZ3M6IFBDSTogaW14
NjogY29udmVydCB0aGUgaW14IHBjaWUNCj4gY29udHJvbGxlciB0byBkdHNjaGVtYQ0KPiANCj4g
T24gV2VkLCBKdWwgMjAsIDIwMjIgYXQgMDE6MTY6NDVBTSArMDAwMCwgSG9uZ3hpbmcgWmh1IHdy
b3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEJqb3Ju
IEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IDIwMjLlubQ35pyIMjDm
l6UgMjowMA0KPiA+ID4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+
ID4gPiBDYzogcm9iaEBrZXJuZWwub3JnOyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0KPiA+ID4g
Z2FsYWtAa2VybmVsLmNyYXNoaW5nLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gPiA+IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgg
PGxpbnV4LWlteEBueHAuY29tPjsNCj4gPiA+IGtlcm5lbEBwZW5ndXRyb25peC5kZQ0KPiA+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzNdIGR0LWJpbmRpbmdzOiBQQ0k6IGlteDY6IGNvbnZl
cnQgdGhlIGlteA0KPiA+ID4gcGNpZSBjb250cm9sbGVyIHRvIGR0c2NoZW1hDQo+ID4gPg0KPiA+
ID4gT24gRnJpLCBBdWcgMjcsIDIwMjEgYXQgMDI6NDI6NThQTSArMDgwMCwgUmljaGFyZCBaaHUg
d3JvdGU6DQo+ID4gPiA+IENvbnZlcnQgdGhlIGZzbCxpbXg2cS1wY2llLnR4dCBpbnRvIGEgc2No
ZW1hLg0KPiA+ID4gPiAtIHJhbmdlcyBwcm9wZXJ0eSBzaG91bGQgYmUgZ3JvdXBlZCBieSByZWdp
b24sIHdpdGggbm8gZnVuY3Rpb25hbA0KPiA+ID4gPiAgIGNoYW5nZXMuDQo+ID4gPiA+IC0gb25s
eSBvbmUgcHJvcGVydCBpcyBhbGxvd2VkIGluIHRoZSBjb21wYXRpYmxlIHN0cmluZywgcmVtb3Zl
DQo+ID4gPiA+ICAgInNucHMsZHctcGNpZSIuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4g
PiA+ICAuLi4vYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnR4dCAgICAgICAgICAgfCAxMDAg
LS0tLS0tLS0tDQo+ID4gPiA+ICAuLi4vYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnlhbWwg
ICAgICAgICAgfCAyMDINCj4gPiA+ICsrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgTUFJTlRB
SU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstDQo+ID4gPiA+
ICAzIGZpbGVzIGNoYW5nZWQsIDIwMyBpbnNlcnRpb25zKCspLCAxMDEgZGVsZXRpb25zKC0pICBk
ZWxldGUgbW9kZQ0KPiA+ID4gPiAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BjaS9mc2wsaW14NnEtcGNpZS50eHQNCj4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0K
PiA+ID4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1w
Y2llLnlhbWwNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gPiBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUudHh0DQo+ID4gPiA+
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS50
eHQNCj4gPiA+DQo+ID4gPiA+IC1PcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ID4gPiAtLSBmc2ws
dHgtZGVlbXBoLWdlbjE6IEdlbjEgRGUtZW1waGFzaXMgdmFsdWUuIERlZmF1bHQ6IDANCj4gPiA+
ID4gLS0gZnNsLHR4LWRlZW1waC1nZW4yLTNwNWRiOiBHZW4yICgzLjVkYikgRGUtZW1waGFzaXMg
dmFsdWUuIERlZmF1bHQ6DQo+ID4gPiA+IDANCj4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQNCj4g
PiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1w
Y2llLnlhbWwNCj4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNp
L2ZzbCxpbXg2cS1wY2llLnlhbWwNCj4gPiA+DQo+ID4gPiA+ICsgIGZzbCx0eC1kZWVtcGgtZ2Vu
MToNCj4gPiA+ID4gKyAgICBkZXNjcmlwdGlvbjogR2VuMSBEZS1lbXBoYXNpcyB2YWx1ZSAob3B0
aW9uYWwgcmVxdWlyZWQpLg0KPiA+ID4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwj
L2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ID4gPiArICAgIGRlZmF1bHQ6IDANCj4gPiA+ID4gKw0K
PiA+ID4gPiArICBmc2wsdHgtZGVlbXBoLWdlbjItM3A1ZGI6DQo+ID4gPiA+ICsgICAgZGVzY3Jp
cHRpb246IEdlbjIgKDMuNWRiKSBEZS1lbXBoYXNpcyB2YWx1ZSAob3B0aW9uYWwgcmVxdWlyZWQp
Lg0KPiA+ID4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3Vp
bnQzMg0KPiA+ID4gPiArICAgIGRlZmF1bHQ6IDANCj4gPiA+DQo+ID4gPiBXaGF0IGRvZXMgIm9w
dGlvbmFsIHJlcXVpcmVkIiBtZWFuIGluIGFsbCB0aGVzZSBwcm9wZXJ0aWVzPw0KPiA+ID4gIk9w
dGlvbmFsIiBpcyB0aGUgb3Bwb3NpdGUgb2YgInJlcXVpcmVkLiINCj4gPg0KPiA+IFJlZ2FyZGlu
ZyBteSB1bmRlcnN0YW5kcywgdGhlICJvcHRpb25hbCByZXF1aXJlZCIgbWVhbnMgdGhhdCB0aGVz
ZQ0KPiA+IHByb3BlcnRpZXMgIGFyZSBub3QgbWFuZGF0b3J5IHJlcXVpcmVkLiBUaGUgZGVmYXVs
dCB2YWx1ZXMgYXJlIHVzZWQgaWYNCj4gPiB0aGVyZSBhcmUgbm8gc3VjaCAga2luZCBvZiBwcm9w
ZXJ0aWVzLiBJZiBIVyBib2FyZCBkZXNpZ25lcnMgd2FudCB0bw0KPiA+IHNoYXBlIHRoZWlyIFBD
SWUgc2lnbmFscyAgKEUuWCBleWUgZGlhZ3JhbSksIHRoZXkgc2hvdWxkIGRlZmluZSB0aGVzZQ0K
PiBwcm9wZXJ0aWVzLg0KPiANCj4gVGhhdCBzb3VuZHMgbGlrZSAib3B0aW9uYWwiIHRvIG1lLg0K
PiANCj4gIk9wdGlvbmFsIHJlcXVpcmVkIiBpcyBtZWFuaW5nbGVzcy4gIEEgcHJvcGVydHkgY2Fu
IGJlIGVpdGhlciBvcHRpb25hbCBPUg0KPiByZXF1aXJlZCwgYnV0IG5vdCBib3RoIGF0IHRoZSBz
YW1lIHRpbWUuDQo+IA0KPiBJZiB0aGUgZHJpdmVyIGNhbiBmdW5jdGlvbiB3aXRob3V0IHRoZXNl
IHByb3BlcnRpZXMsIHRoZXkgYXJlIG9wdGlvbmFsLiAgSWYNCj4gZGVzaWduZXJzIGNhbiB1c2Ug
dGhlc2UgcHJvcGVydGllcyB0byBvcHRpbWl6ZSBzaWduYWwgY2hhcmFjdGVyaXN0aWNzLCB0aGUN
Cj4gcHJvcGVydGllcyBhcmUgc3RpbGwgb3B0aW9uYWwuDQo+IA0KPiBUaGUgcHJvcGVydGllcyB5
b3UgZGVzY3JpYmUgYXMgIm9wdGlvbmFsIHJlcXVpcmVkIiBhcmU6DQo+IA0KPiAgIGZzbCx0eC1k
ZWVtcGgtZ2VuMQ0KPiAgIGZzbCx0eC1kZWVtcGgtZ2VuMi0zcDVkYg0KPiAgIGZzbCx0eC1kZWVt
cGgtZ2VuMi02ZGINCj4gICBmc2wsdHgtc3dpbmctZnVsbA0KPiAgIGZzbCx0eC1zd2luZy1sb3cN
Cj4gICBmc2wsbWF4LWxpbmstc3BlZWQNCj4gICByZXNldC1ncGlvDQo+ICAgcmVzZXQtZ3Bpby1h
Y3RpdmUtaGlnaA0KPiAgIHZwY2llLXN1cHBseQ0KPiAgIHZwaC1zdXBwbHkNCj4gDQo+IEZyb20g
cmVhZGluZyB0aGUgY29kZSwgdGhlIGRyaXZlciB1c2VzIGRlZmF1bHQgdmFsdWVzIGZvciBhbGwg
dGhlICJmc2wsIg0KPiBwcm9wZXJ0aWVzIGlmIHRoZXkgZG9uJ3QgZXhpc3QuICBBbmQgdGhlIGRy
aXZlciBhbHdheXMgY2hlY2tzIHdoZXRoZXIgdGhlDQo+IG90aGVycyBleGlzdCBiZWZvcmUgdXNp
bmcgdGhlbS4NCj4gDQo+IFNvIEkgdGhpbmsgeW91IHNob3VsZCBkZXNjcmliZSBhbGwgdGhlc2Ug
YXMgIm9wdGlvbmFsIi4NCj4gDQpZZXMgaXQgaXMuDQpJIHdvdWxkIGNsZWFuIHRoZW0sIGFuZCBz
ZXQgdGhlbSBhbGwgIm9wdGlvbmFsIiBsYXRlci4NClRoYW5rcyBmb3IgeW91ciByZW1pbmRlci4N
Cg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IEJqb3JuDQo=
