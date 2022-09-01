Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5272F5A8B4A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiIACNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbiIACNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:13:52 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AA8ED020;
        Wed, 31 Aug 2022 19:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdhdIaw4DyDI3woQK3pjVICGLo2fH1KDOzyO6SsbYSTJmGbhecVKhoJkm1lm+fJ34dj9ffi00QB/qwf63bv9Mn+CKh5tXQDhkSdzDRg+yImmy8lCM74TTqb7euwVeCE4v3wOQamWUhhFBDdfQPrRtPYX95vBDqX2PPBKOm8gTgHE1cH22bbeeNlB0h5kzORp2Li928/YwAAAdvHzHhBVAzXNPTIJMYzek5wZOEEwlaGVfsitxHZZuqA7tBy7W5Xyth3bjGMCJdAtv/8ottatEVeE+BtdV6Zv0wGHuslfwwQt++3WKEGlFLlA43LBfjxWZbhLKoAFY8lEJEK3l2IBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U09gKG+tWmDa29yV3CbZzoHf7Rfc2PjtUhqplFG4nHU=;
 b=YZDEavZmNwdBhaHEUthlfbvrmooZ91/bEsAi5wjN5M11orp+oKUi5BuE+tMHXNG9hk7UQIrF62NKR4JeZIRIvsoKIKltr1h37P1o3uXGceIYlZYna8cYztf+v6RuiUYH5HUc3E6s2UE5tg1J9rViLKWj+Gb5WlYZ+Ucltpcs6ZOFr37paTU8TkQlz6PODa9sWvaVRA+fDB3eaRbGjaEbjj80cQPsVrtNpxVBANq0j/sSkfRGPGaPkW+hihd3QJ4uZZwGOn+UypzlRSSFVCW2o8GASoSYTiWKo9eJ5ntkL9XghPGpKQ3bC0lcBfvvb++VYe0eKcXkJAPfopPQHbgdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U09gKG+tWmDa29yV3CbZzoHf7Rfc2PjtUhqplFG4nHU=;
 b=MPiUSrlzIhQGjlmehF2y8AkxrREp13MdP7CG6Bx+zMrFvgj3VsDqfxZTMAsUlIkhbvyaj0gY3rd1pdPTEOHuEGJ+B4o9QqQZ+XONgby1aGCE5m2GpSxJc5OV5axvKuAPCCrvxN1I/c0Spbda9FgZOWNp+4r4flddUJKxwfa2fkA=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by DB9PR04MB8494.eurprd04.prod.outlook.com (2603:10a6:10:2c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 02:13:49 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 02:13:48 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH V4 3/4] ARM: dts: imx: update sdma node name
 format
Thread-Topic: [EXT] Re: [PATCH V4 3/4] ARM: dts: imx: update sdma node name
 format
Thread-Index: AQHYvabkZWdTG9NyGUOnn0RVxnsLH63J1HeAgAAAmkA=
Date:   Thu, 1 Sep 2022 02:13:48 +0000
Message-ID: <AM6PR04MB592524A767005B56F255B7FCE17B9@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20220901020402.50206-1-joy.zou@nxp.com>
 <CAOMZO5BEwrmBTqtWoaNRQiG9dxx=T=TAf11f2ce=hBb1_mAjSw@mail.gmail.com>
In-Reply-To: <CAOMZO5BEwrmBTqtWoaNRQiG9dxx=T=TAf11f2ce=hBb1_mAjSw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66f7f13a-b7e8-40ba-22be-08da8bbf9b6c
x-ms-traffictypediagnostic: DB9PR04MB8494:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JmvZ+0XPxXrJ6K+4DaKAYF0MC9BXDjroehMvj2kkXdgd0SW9AdooIoZYHHbbOP5L1LmpXUNetyBFU4QRmMtFJ7bcn2ldSeo+eHjHcvq8M2SPi/8rDxXkdvwvgEXGz2iye+D3Q2QBJ/5GMT8mN7+YaSNTq5g4KiEi1FrH6/QohufOXmoNZnOVex6+QYHtGRkfU6WaZMoi6dncWffZ6SqxouduXgITjBscWqRdSzBgYFq6dW4hZysbU6UoHBZhkKW3G0h4nhiGffLMRR4+E2sOBJLze8FGjx7YTuajJ5/LObM3EUiT/KqKOvGmIglR8kBvJnzENMg+yQX+lav+vMzYNCrFQ3xjIHb7Mdlt5I29xVxFa1a02EqDb/7ZOld9XPJYoCs7cdrju6heyUW2Lch5Pr7Vbv/+e6pJzwnW2nxzJM3uN0mvTkBpZFugr7sT9Y0/V+EwfqcuO9S4bogks8Ue4vnBXR0Q5WSUPtI/MNqcJKoH+XBvF/o5mqOmb7Gj+/Kf/ZqlUJ4btmLoXSkL8Kkk7H2uXHqnV/N5QID2+O1OSu64zbJeXqvnIhESUwSJBaELdydy874BcnD5QJeJL6etdnH3wDx7PVSZmIt6BJljN22fXRCrM8973c9uurt1KzhRNtIyuGanUq630VBGPzSFW2Z7fh0dPmZH+Z/3q3RRHSEvdwKN1d/CiZoZwmLCY+AYYHpmPohhrVU/8blrqjVHMc4AlXPmKmGuPYNxJAa2nP1mV7TUVVhUbf5fCueg4718Yod89DYQt1tSWinDqFtzQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(122000001)(4326008)(4744005)(8676002)(66556008)(66476007)(66446008)(64756008)(44832011)(186003)(76116006)(9686003)(5660300002)(6506007)(53546011)(41300700001)(38100700002)(66946007)(7696005)(316002)(26005)(15650500001)(86362001)(2906002)(478600001)(54906003)(6916009)(55016003)(8936002)(33656002)(83380400001)(52536014)(71200400001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UCtpdVdNcGJWWVFFTm0yYStkTXdkUG0rd3FpcjkwSENBRU1qU3ZITUozcmJN?=
 =?utf-8?B?ME9lRy9VU1RDbWFNemQ3ZW82VExaN2VZbkRWSDBhRWl4eHJjOXBSdFVKNjJ0?=
 =?utf-8?B?czUyZXh0OGZMdkRDL1pxVEJwcVBQY01MTkl6QVZPbmRSOGN3QU84SlJzM2hk?=
 =?utf-8?B?K0dGTTZWVElLQ25rRjRPNzlzbnJOZDRuTEcxeVdZYzhxclNISHkyaGhaM2VJ?=
 =?utf-8?B?WkJIQ0Q2aDNaL05NSE11OHVQY2kwV2hRY0N3SlkrV3BqZXBid1FYc0dUU01E?=
 =?utf-8?B?WUZoem9naHBUZUtXOHpVZUJ0QkJnTE41S2R6ZXM4bTR5NzQxZHlRSm1sT2hn?=
 =?utf-8?B?N0d6dDlsMUw1aXF3YXl6L1Izb3loQUxuSVY4QkovS0ozaStVQWJFV2xsMXhV?=
 =?utf-8?B?QUZ5YTBGSHJXcVJLVTMxN1VPQmE0aEE0QS9hZUdjNG1LV3pyelcrZVJjS0VZ?=
 =?utf-8?B?bVM1TEEzOG5FT1FKTzBjcFZGd2o4dEJXcGc2c2ZjK200S3o2K0E5N05yWElG?=
 =?utf-8?B?TFVoUGlRbFV0VzQ0b2pZcUFDNE9CZTROTzRrRkhnWTVWV3p2ZDZKTVV0ajI1?=
 =?utf-8?B?OEpDeTdoU3dJdUJQdDk5REpiQTY1YWQ3OXRrOWVIbW5hRDQveitPdFh0SjBS?=
 =?utf-8?B?ODV3YmxDRHNQVnY2bWt5M1MwWlJGTHREWk9aa256dm5uQlJqdTFkVXdOaXl2?=
 =?utf-8?B?ZmFyeVlvMlh4d09HdDB5MHpxZXFyYWlqWmdGWEFlRVcvNW5QYVpZUS9TQWVw?=
 =?utf-8?B?bU0vMTdmdmxvQk5INUZvQVYzMEtQaXBUaU81amlqOGR2VDVTMjRkRUgzWnNE?=
 =?utf-8?B?L3dEcnh1V0VWTUdTdGVpK2txbEZPYkJncEFRaUlQc0d4Q3ZxZ2ZyQ1pob2hy?=
 =?utf-8?B?cFJYSTlmT2NzeXVtVCtSd3hHdFZyeXo1cERsMGVTSmF0b0lweGVHMGRjRGFX?=
 =?utf-8?B?REp0RFB1ZHZYMjZTcjE0R052MENkK3dWUzlTNmkrL3F2dTVyL0ovYkd1RnQ5?=
 =?utf-8?B?SzBTcHVCMG5BVmpzeWwrdmN6NjRYcGZ2enhxSlZ5ZFN6L1h0STZLNHR4WjNa?=
 =?utf-8?B?MG5aNFRXSkZ2VFVHT2IrVGF0UnRFZHVuMXlJbG1SNlVuL014RVBJdjd0aXNK?=
 =?utf-8?B?RWpyUXNFVVpOOWx0c2MrWHlJNFV6VE9FaGZueEhLUGZRdGJKS2VveXMra1Ay?=
 =?utf-8?B?MWhaT2hvYVlXcWNYb0hMZjNtQTREVWxKN2k4V3dnRkNXUmp5MVJ5clRYODdm?=
 =?utf-8?B?QkFvNHVUbjg5TlJ5L2wxZWd6Tmd1M3p0Wml4VzEvZUo1Vkx4RjFsdVROQktn?=
 =?utf-8?B?dStScGZGNHp4NHlqbTNHSWRsOExMVTJkTmEvWjFHd3BXNzRiS2UyRDY1c3Mw?=
 =?utf-8?B?U2lqbW9sVE9WSDhsQXdxcW1rYUQ3dk0xdkN2M2Q5NGtRb2lUaXRaLzAwUk81?=
 =?utf-8?B?K1g4L2poaEZza3JwN0NhMlRKeTN2d2JQSUwxa2lGMHorV1k1VjRSMlZ4Y0hT?=
 =?utf-8?B?RithZWRTUGRRV0pqSVNYcDIxWU9uUlZYRmhTRzlOWHQrZU1ZVUdFRTFWaHRI?=
 =?utf-8?B?WERVaUwrZmNYQ1BpUDJxR1RkUWV4bitRMWVhQ0RlRE8xdzFJMmpzZXpUbmgr?=
 =?utf-8?B?TFRvZnJhS0VjdzBiSTJiVzUwaVdZaDNuSWNhVXRWVldRUHMwdzdIbkNHTE5P?=
 =?utf-8?B?VjhabyszZW95WHJLT3JiQmtmQ0ExMStQOXE1NWtrcGM2WEVKemlnSExyYzNl?=
 =?utf-8?B?VHZYZERyVHZoTTBQcFk5dlVIbnpyR2FyMXBJeVl4VEg2UmQxVXpqaGFlRGFU?=
 =?utf-8?B?Tm9tQUczaWxqZzE3dXJwY09wNFByTlFaQjR5VXlBT2xHUGtGTENKbXQ2NlFY?=
 =?utf-8?B?ODZaYVNIV3BMYWZaNFVLOVArSlVQMVlNc3FhMXRaWFJiODEzZjBnaktsMUQw?=
 =?utf-8?B?eXJva2FFQkgyTkxOWW5MSjNLV0ZUY3JMdHYyZWdoK2xrV2l4SDI4YjFUT2x4?=
 =?utf-8?B?RnhWYnlnMSt1blQ5QUxJbWlZajJ2Z3lUVDFpZDBMWDFhUkRDY2U0RFZaNTRn?=
 =?utf-8?B?NXEraElEbm5rNXlqd3Bxakd6akVtRVRBbDFKRERLUllHd1RoSkV2cW9JQ3JK?=
 =?utf-8?Q?Y+UI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f7f13a-b7e8-40ba-22be-08da8bbf9b6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 02:13:48.8291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BP7LF8aatnaus/oTEIc2Np+B68eZPdItXnpK7vldS1a19YmOmQAt18V2dcj8YOxT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8494
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZhYmlvIEVzdGV2YW0gPGZl
c3RldmFtQGdtYWlsLmNvbT4NCj4gU2VudDogMjAyMuW5tDnmnIgx5pelIDEwOjEwDQo+IFRvOiBK
b3kgWm91IDxqb3kuem91QG54cC5jb20+DQo+IENjOiByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlz
enRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5o
YXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBkbC1saW51eC1p
bXggPGxpbnV4LWlteEBueHAuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIFY0IDMvNF0gQVJNOiBkdHM6IGlt
eDogdXBkYXRlIHNkbWEgbm9kZSBuYW1lDQo+IGZvcm1hdA0KPiANCj4gQ2F1dGlvbjogRVhUIEVt
YWlsDQo+IA0KPiBIaSBKb3kuDQo+IA0KPiBPbiBXZWQsIEF1ZyAzMSwgMjAyMiBhdCAxMTowMiBQ
TSBKb3kgWm91IDxqb3kuem91QG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gY2hhbmdlIHRoZSBz
ZG1hIG5vZGUgbmFtZSBmb3JtYXQgJ3NkbWEnIGludG8gJ2RtYS1jb250cm9sbGVyJy4NCj4gDQo+
IFRoZSBjaGFuZ2VzIGxvb2tzIGdvb2QsIGJ1dCB0aGUgY29tbWl0IGxvZyBuZWVkcyB0byBiZSBp
bXByb3ZlZC4NCj4gDQo+IFBsZWFzZSBleHBsYWluIHRoZSByYXRpb25hbGUgZm9yIGNoYW5naW5n
IHRoZSBuYW1lLiBTb21ldGhpbmcgbGlrZSB0aGlzOg0KPiANCj4gTm9kZSBuYW1lcyBzaG91bGQg
YmUgZ2VuZXJpYywgc28gY2hhbmdlIHRoZSBub2RlIG5hbWUgZnJvbSAnc2RtYScgdG8NCj4gJ2Rt
YS1jb250cm9sbGVyJy4NCj4gDQpPaywgSSB3aWxsIG1vZGlmeSB0aGUgY29tbWl0IGxvZyBpbiBw
YXRjaCB2NS4NClRoYW5rIHlvdSB2ZXJ5IG11Y2ghDQpCUg0KSm95IFpvdQ0KPiBUaGFua3MNCg==
