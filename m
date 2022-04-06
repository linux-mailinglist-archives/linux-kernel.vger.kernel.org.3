Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A8C4F6226
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbiDFOtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbiDFOtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:49:08 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623F35E8644;
        Wed,  6 Apr 2022 04:21:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbGyKltUJN3qpNMSEZl6MDmPAdblzhbh/hFysnDxyzRrgTAsHDcYi41JG9LRd1VGxsc2BoYTBXNPBz5RnVUcw6YRdpehkoYhAUZZO4v3X0Y9/2Msjufy0knhYUA8/tNl8bLnicW5FAoOmt2+eYFIKO5y/+MGhYGmq6OTuvkUjal/td9mQI8e4ruEFX0qwMCUSEDDya4mgBeXCBH4I3QRyUJp27swN4hHXIZQ0D0ykaMtjeYOhbfdIs4Z4o40v6RatyhyzzNWw6c4Vxop9ESiAiIk3z5YbhWlo7ULzxubquJqaDItQmn84k7bRKL5WGOQhjcJBfpXg1xPIPwHeB/Jsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4xeXTRTsO3knKadzMWCO6MCDZeHFXgJU0B39DGYvow=;
 b=WuLiBusYNRUX86e/tOgMvCTc+fnoB4UhROFa5lNS1UO39gzxqc4iHPaOIe/3UfnD7xPlPZ1UwfzI7iYGT8SDOR3/PAib3zK/3N6NTcwqMnMZ3NCDDQkupe4rF1LC7wHC3t+I32EFIbbfjCk/5C3GFZu2Xo1d+Gta+q2C3iaw1Fjp7l8Ny1zzmitBjsG1wSAy9c37RTcfMnMj0lZVctjX7cgm24cswku+yQJh0CGNxAJwfZ38onWXtReoEgJRM8lUiVNzZTmpfd/FQK0DyYKg/VmrLMnlt5HJAnmHv/Q/r034NDz33Es6Gq2ODaUP0M5uItTmImMzfrEtKdyNlYtU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4xeXTRTsO3knKadzMWCO6MCDZeHFXgJU0B39DGYvow=;
 b=mEMf6Z2LEyc7LwhESg/sfvJHNrlka++TSOEw7qUB/P8RfJMip97lrL0toeZh7u/c+P5rtoqhlQDw33+S3UrxixMApaIOOsuj0t4QQ1b66YkFMyyosTHD9dgqM/dmNTrqvwRaBESvH8+HFuOGLjS8AMmr0lRoh1WpIIwoRc3c5Dc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6791.eurprd04.prod.outlook.com (2603:10a6:20b:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 11:21:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 11:21:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "djakov@kernel.org" <djakov@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/5] dt-bindings: interconnect: imx8m: Add bindings for
 imx8mp noc
Thread-Topic: [PATCH 1/5] dt-bindings: interconnect: imx8m: Add bindings for
 imx8mp noc
Thread-Index: AQHYSY9a3VAR7jPmMUi4yQ8zjr2M26zikNUAgAAqDrA=
Date:   Wed, 6 Apr 2022 11:21:46 +0000
Message-ID: <DU0PR04MB9417464CDE2160A23C82B0BF88E79@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
 <20220406082330.2681591-2-peng.fan@oss.nxp.com>
 <Yk1SALC2+5va4oZP@pendragon.ideasonboard.com>
In-Reply-To: <Yk1SALC2+5va4oZP@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a5c8c8f-f868-4439-bca2-08da17bfa2c3
x-ms-traffictypediagnostic: AM7PR04MB6791:EE_
x-microsoft-antispam-prvs: <AM7PR04MB679180992592EAE5EA49568888E79@AM7PR04MB6791.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QClUTptuTLcVX7t0bjGQ5oiioP/a6pqLS80Q45uZ3i4SddUewK/VCE1yuZuVBpGAEuuKBi938VwadrZV3xX7OjUHnSk0ciMiwqDnm5ChYb0kfhpJatQFp9yyMmTN2asatjBA3/+mTjHwScHzPm9uxsYNIcOvcUoMDCV8KZ/UbtsjJdNrrTBkB4/KBQW4DYY3q7sgyGrlBMmAFTI0QNZ5moxX0PwiKjxxYX9yoJe6cdmdqX8C0kuBjj+rzpsJJQW/OjwEis/m131h/53kPBHxyD4ruojb2jfenurFIKI8bSeUzkcnKWdsZCtdGMovt/9eUshbkQYSmnVRJwfXhou+hWOikt7r070ZFaN8HZHwiYWQig3EbsByX74DG+rFCvRuNb9eJ6D8uKfr5C1LXfvOsOpAwYSBFjN5Jvdxr8o0eQz1hq6NFUNVaVdo/WVgJbcQ4/40jtGTeF9D+h0vN0/lp4lQ+e+boZOgXGFRMAd8vIIG/lvqQJTCY0Owk3i05op/70IcE81GrFOqGFbrr7uu4+eyVcphloOsF7QpJsoC3BbtOk3/Fj2yydbiGxUXgh8qbwkNW9x9yaR61mWmkNeV7D3VbR4UTPFoeJ5RkDE15UZZjBDi+u1gL/uHLNE4ytpZ3hqqwzdNa/9OsYRp9qOn/g3lfO/wgnkr/GeBKs3YE0hGEfUx5W0297rGs8RwK3vdhyTKZPcUerMjolDaIZ0ePQB0uP8OIrlKjdslUMEGg9w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(66946007)(26005)(66446008)(316002)(66556008)(66476007)(122000001)(8676002)(186003)(64756008)(9686003)(4326008)(71200400001)(44832011)(7416002)(52536014)(86362001)(76116006)(38100700002)(508600001)(6506007)(83380400001)(5660300002)(110136005)(2906002)(8936002)(7696005)(54906003)(38070700005)(55016003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU9WdHhFRmM3NThxZ3NmWTltQVlTQmUvdENURSs0dnFNczVCYzRSM3RQRGxn?=
 =?utf-8?B?ZEZ2K09ZRG94NTNLRFlCbU5PN3VVeVJuTGdhMlFHYjRXdXplajlKNEpONUFO?=
 =?utf-8?B?MTM5QkkyQ3cvSnBmQy9qck1pd29ISkwyRGZjV2NwZFB1OGhiQ2dzQ2hrd3Y2?=
 =?utf-8?B?MlIwYVdMS0JwRHRqOU1GdWhTNXJiT1JuWVhlMWU4a1FOWjd1T0d5dFRjVmVl?=
 =?utf-8?B?UDBSUjNuZkF2N2pCTmFQN3pFL3dtZ0RHVitza0FDQWVWcTlCb2RUc242OWVF?=
 =?utf-8?B?UG5NS3dMOG91T20zTW04c2xsT0JMS3VQV21JZW1JeEVEZFYrSFJzajI5RWxl?=
 =?utf-8?B?WllrRzUzWHJOT2RCWjBPVlJxa1ZhK3MvOTlmakV2Q05kSlVUbnVnQ0REMmp5?=
 =?utf-8?B?YUFjRWsvOXJvRFB3SnE1aDF1TUNJN1p4RUVlQnM0OU4vZFluVWUrcjZ2c2U2?=
 =?utf-8?B?NjNNeG5OQXV1YmFKQmU2S053a3UzZldvR0pOMGcxQ2V4OUVIdFFRRGRHTzFa?=
 =?utf-8?B?VmVlT3VxT2dYT21HQWdjN0U5bnZaUXFMTnZ1MVBtSTM2eFlNdGl0eXhSTkNa?=
 =?utf-8?B?bmZwUkxiSGpFRkFycklOcUt2SWZ2L0JtVndvSElqZU92cWZKUTJFU1lPRzBn?=
 =?utf-8?B?eVpySWJaM2RPN0tGSXhGNmNaVXMxYTIzNERkVS8xMno5WU1OZGZoSnUwVU1R?=
 =?utf-8?B?V3VNeTMyb1dYM1Z2d1k2eW81MDFVU3RuRnlCWjZXS2R5K0FyK1JwRm1MaEtW?=
 =?utf-8?B?MmV6eTMyeXJLK2tvK0ZJL2RMSWI4cDFwOENody9TRVY5QTI1M2VoeFdPT2FT?=
 =?utf-8?B?a1ZjQW9oNjN4QitGSDRJTnVDUGZXU2V1b3VNRWplcXAzNkFBZUswcWRPZGFy?=
 =?utf-8?B?TEhLRGpSZTFMVk1hc3dTR3k1TnJuYzVDYkhyOG9hRmJCTWIrMnJBOXhxV29E?=
 =?utf-8?B?R1N1bmhhNkJYTStUckVTMWREWk91Vi91VjdTQUIyVWo5TWxJN3VUbUlBcUFz?=
 =?utf-8?B?TkY5cHZ4ZytTcnNtcmdsTUZNdFFORWpPS3Jub3IyM0ZCOVFxTFU1dlM0MnNu?=
 =?utf-8?B?enhYTEhLMXA5WnVzN05UVldRS1ZLckFNbGdBRzdBcm51OUpjMFNWV3QyZzhL?=
 =?utf-8?B?eHJSVFNkbGc0OUsvZ0dvY3UzOTN1cUFtcGJDUjdXRVdGR0lXMGVGRHJBL0tJ?=
 =?utf-8?B?MGgzSzQ5SUhoK240eTY0OWQ4QkFsSjFrN0JMUEtJdXRiVzRTRW14MkkxM3NC?=
 =?utf-8?B?ZjlhUUdOdFJ3NHhYL2tKNktrUVI0bjVQbHkyb0dmQnVVbHROU2Nnd0FRSDVN?=
 =?utf-8?B?N2ZnQjhQUlFOQ1g1NUVLMDFhdlAwU0xBYXpQa2RuYzlhYVNMQW1Eb1pKQ25h?=
 =?utf-8?B?NlhwYVBlTlBrY1JKTzZTN09mejkwQ0JSRnVJekVCY25uOVZPNFZXa1hoTERK?=
 =?utf-8?B?eTJrRGVBOVBCR2ttK05EN2R5UmRublYxRnB6dENJaUJPR1BIeWh2Ulc5RGJk?=
 =?utf-8?B?YXZIRlBQNE1JNUFLSUhnYXpFVDFrZVNnY1BlYjFKS2l4aW5jMFNucWlNQy9t?=
 =?utf-8?B?N0VERnVwS2ZINXhLbEcydnlJaGdZWkhGMS8zSGpDV21jRUNNV0NwVk5oSVVz?=
 =?utf-8?B?UGZTWTF4bWNTRE5vQmtMRGdVSEsrcFFNa2YvQ3l6OUg0VEpkNzFOd203aDNV?=
 =?utf-8?B?SzNFUXF2WTlSdlFMejhuUko0b1kvT1M0VnNJWUkvd1VLMXIrYXRTNGxkR096?=
 =?utf-8?B?VTc0TlFObnFaWkJrOHltc3NNUUROZTMrWWNXdWVJbzZYb0ZXTW1GelVvU1FU?=
 =?utf-8?B?c1I1ZVZMWUJCbS9Ia0FVM1BROTRKU1E5RTBBZjIzR24xZVRPcW4yS3E1cHVm?=
 =?utf-8?B?RCs3UCtIVUpxWkVEUzk0QUc0bXNGVGZja0dsN2FjcHpFaXBMMGY2bmpReUlx?=
 =?utf-8?B?NG9rZE1XclhHanFFTmtGWTdEU3Y5bk1oR2FWWmRLZVBRWktMYlNrYWY4ZWJY?=
 =?utf-8?B?RUhaS2lPNWc5NTh3Si8yRGdTcnRoZDYxbHZJQmNrOTlpM0NSMURDNDh2ZFpK?=
 =?utf-8?B?dTlicEorUXlyUExJQkpkSGw5dUEzN29YUkdEMFFBVWRiYXpiVXFVdkg5eXpu?=
 =?utf-8?B?L2E5QjlLYWJHN0F5YWl4WlBnVHMxK2pnOE9KcVFyY3A1WlM4L3ZTdEhhclYz?=
 =?utf-8?B?aGNsTFV6VEZxRHFMdmllUlRqM05iWm9KNEdyWjNYelh6bVpPK0YxMmkrRm1z?=
 =?utf-8?B?ZDdnVnlyRzlzZ2VSZjJNSURpUDFKM3daRUNkNXo0aFIzaVBpTVBER2Y4Sk5Q?=
 =?utf-8?B?L2d6d0htWHhnbXp6T1NIR2ZndGNYMFdTY0hGMlcxQWM3VDY2eUZsZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5c8c8f-f868-4439-bca2-08da17bfa2c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 11:21:46.2494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8o29+dPbr+iWlymojNOLAl+fh3w27bciOMhEJCTQD56gief6sO+d+l+oiwkRLl1UqxW0xQ24kjbQ8H0K70AhNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6791
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNV0gZHQtYmluZGluZ3M6IGludGVyY29ubmVjdDogaW14
OG06IEFkZCBiaW5kaW5ncyBmb3INCj4gaW14OG1wIG5vYw0KPiANCj4gSGkgUGVuZywNCj4gDQo+
IFRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLg0KPiANCj4gT24gV2VkLCBBcHIgMDYsIDIwMjIgYXQg
MDQ6MjM6MjZQTSArMDgwMCwgUGVuZyBGYW4gKE9TUykgd3JvdGU6DQo+ID4gRnJvbTogUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBpLk1YOE1QIGZlYXR1cmVzIHNhbWUgTm9D
L05JQyBhcyBpLk1YOE1NL04vUSwgYW5kIHVzZSB0d28NCj4gY29tcGF0aWJsZQ0KPiA+IHN0cmlu
Z3MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJjb25uZWN0L2ZzbCxp
bXg4bS1ub2MueWFtbCAgICAgfCA2ICsrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaW50ZXJjb25uZWN0L2ZzbCxpbXg4bS1ub2MueWFtbA0KPiA+IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVyY29ubmVjdC9mc2wsaW14OG0tbm9j
LnlhbWwNCj4gPiBpbmRleCBiODIwNGVkMjJkZDUuLjA5MjNjZDI4ZDZjNiAxMDA2NDQNCj4gPiAt
LS0NCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcmNvbm5lY3Qv
ZnNsLGlteDhtLW5vYy55YW1sDQo+ID4gKysrDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2ludGVyY29ubmVjdC9mc2wsaW14OG0tbm9jLnlhbQ0KPiA+ICsrKyBsDQo+ID4g
QEAgLTI2LDE2ICsyNiwyMiBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgb25lT2Y6DQo+ID4gICAg
ICAgIC0gaXRlbXM6DQo+ID4gICAgICAgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAgICAgICAg
LSBmc2wsaW14OG1wLW5pYw0KPiA+ICAgICAgICAgICAgICAgIC0gZnNsLGlteDhtbi1uaWMNCj4g
PiAgICAgICAgICAgICAgICAtIGZzbCxpbXg4bW0tbmljDQo+ID4gICAgICAgICAgICAgICAgLSBm
c2wsaW14OG1xLW5pYw0KPiANCj4gQWxwaGFiZXRpY2FsIG9yZGVyIHdvdWxkIGJlIG5pY2UgaGVy
ZSwgbWF5YmUgeW91IGNvdWxkIHNvcnQgdGhvc2UgZW50cmllcw0KPiB3aGlsZSBhdCBpdCA/DQoN
ClN1cmUuDQoNCj4gDQo+ID4gICAgICAgICAgICAtIGNvbnN0OiBmc2wsaW14OG0tbmljDQo+IA0K
PiBXaHkgZG8gd2UgbmVlZCBib3RoIC1uaWMgYW5kIC1ub2MgdmVyc2lvbnMgb2YgdGhlIGNvbXBh
dGlibGUgc3RyaW5nIGJ0dyA/DQo+IFRoZSBpbXgtYnVzIGRyaXZlciBtYXRjaGVzIG9uDQoNClRo
ZXJlIGlzIE5vQyBhbmQgUEwzMDEgTklDIGluIGkuTVg4TSouDQoNCj4gDQo+IAl7IC5jb21wYXRp
YmxlID0gImZzbCxpbXg4bXEtbm9jIiwgLmRhdGEgPSAiaW14OG1xLWludGVyY29ubmVjdCIsIH0s
DQo+IAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4bW0tbm9jIiwgLmRhdGEgPSAiaW14OG1tLWlu
dGVyY29ubmVjdCIsIH0sDQo+IAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4bW4tbm9jIiwgLmRh
dGEgPSAiaW14OG1uLWludGVyY29ubmVjdCIsIH0sDQo+IAl7IC5jb21wYXRpYmxlID0gImZzbCxp
bXg4bS1ub2MiLCB9LA0KPiAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14OG0tbmljIiwgfSwNCj4g
DQo+ID4gICAgICAgIC0gaXRlbXM6DQo+ID4gICAgICAgICAgICAtIGVudW06DQo+ID4gKyAgICAg
ICAgICAgICAgLSBmc2wsaW14OG1wLW5vYw0KPiA+ICAgICAgICAgICAgICAgIC0gZnNsLGlteDht
bi1ub2MNCj4gPiAgICAgICAgICAgICAgICAtIGZzbCxpbXg4bW0tbm9jDQo+ID4gICAgICAgICAg
ICAgICAgLSBmc2wsaW14OG1xLW5vYw0KPiANCj4gU2FtZSBoZXJlLg0KPiANCj4gPiAgICAgICAg
ICAgIC0gY29uc3Q6IGZzbCxpbXg4bS1ub2MNCj4gPiArICAgICAgLSBpdGVtczoNCj4gPiArICAg
ICAgICAgIC0gY29uc3Q6IGZzbCxpbXg4bXAtbm9jDQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiBm
c2wsaW14OG0tbm9jDQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiBzeXNjb24NCj4gDQo+IERvIHdl
IHdhbnQgdG8gc3VwcG9ydCBib3RoDQo+IA0KPiAJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1wLW5v
YyIsICJmc2wsaW14OG0tbm9jIjsNCj4gDQo+IGFuZA0KPiANCj4gCWNvbXBhdGlibGUgPSAiZnNs
LGlteDhtcC1ub2MiLCAiZnNsLGlteDhtLW5vYyIsICJzeXNjb24iOw0KPiANCj4gb3Igd2UgY2Fu
IHBpY2sgb25lIG9mIHRoZSB0d28gKHRoZSBsYXR0ZXIgb25lIGluIHRoYXQgY2FzZSBJIHN1cHBv
c2UpID8NCg0KTGF0dGVyIG9uZSBzaG91bGQgYmUgb2suDQoNClRoYW5rcw0KUGVuZy4NCg0KPiAN
Cj4gPiAgICAgICAgLSBjb25zdDogZnNsLGlteDhtLW5pYw0KPiA+DQo+ID4gICAgcmVnOg0KPiAN
Cj4gLS0NCj4gUmVnYXJkcywNCj4gDQo+IExhdXJlbnQgUGluY2hhcnQNCg==
