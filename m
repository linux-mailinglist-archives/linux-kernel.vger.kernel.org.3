Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D699A566FC9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiGENt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiGENss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:48:48 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B7A20F41;
        Tue,  5 Jul 2022 06:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtslqcbqGHQglcejAiA59NSCcsroLSF5mZ+Zuex7NSnZRuiruKdW7NHu1yFe1YBEn2AM83VR09mdFkLREV+wLs5zNtzFO5/YCZIurH0UoT1R862kLqJY+eRfEE3cvs6wP1USfFtEmlbPgrC4m/TkgQ4wHA02y2YFnH09rT4oGpqjQsjYXA5DOFwPGFxXwNk5ol6kDSy+iiZbHtbVtucLo47e04h3otnBq+pAd+MQ5LswrkjiOs2Q8QTnS0P4/x5X2pW2eJxy7Qo2Qa7+2N/Uor9aopFyr4vTt7xWVjdwyCMJU+kBT01FnlFMxoKHfHeB614O58+Cfl96kdF+5fGIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djszGhgmEGTOjGiHwqjgYU0W3s5z2S/6KEqIalhNKOo=;
 b=bj6KYyg3meeS/m80Fz1Mg5K/pShIeCEcPKPeisVANgFypYR80d8AQtDXGoB1xAlNGmv63gj0lDNR8Zn7FI06D9vH925KVWFgpML/NoN1fKG1s+P2HbTfbCl45YOsakKTX+xYmD+llBIfS3rOSKWh0bN+QjOsCHe5ZYcibKWRHpMT+At8Wzzn/CqNDi1mPP1q3VwW0Nv17PuN8wUw5ZhNZUwW43YBHOMXMWTzBSxJA54UGPLWT0EUsCjPZkMt02tYO5iWnJLAw0eKvrwGkL1o5PdTBI8nouK61GEZjwkIWj+fTTM2aWQvLkFhkBRCDsxKfI+jFtf2cwWEqdhpnKAhpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djszGhgmEGTOjGiHwqjgYU0W3s5z2S/6KEqIalhNKOo=;
 b=hcu/kjVo8rJq9rC1uPtN4n66D5KDLza+jGLhYj9dH4mAtZPq2JHHbPgnkOX3TDRnkMoss60B/jZzdI+7U5fipXu8OUoULrTcxOdyx/EQ9f3S7bhnhSL+BAAUBSquomycJY02UNbKoHwxm10a1Gnbgm/u7PULEJ0f4GSgV6oBtYw=
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by VI1PR04MB7103.eurprd04.prod.outlook.com (2603:10a6:800:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 5 Jul
 2022 13:19:57 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::5c49:dd85:a8d0:2907]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::5c49:dd85:a8d0:2907%3]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 13:19:56 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bough Chen <haibo.chen@nxp.com>,
        "ashish.kumar@nxp.com" <ashish.kumar@nxp.com>,
        "yogeshgaur.83@gmail.com" <yogeshgaur.83@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "singh.kuldeep87k@gmail.com" <singh.kuldeep87k@gmail.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "zhengxunli@mxic.com.tw" <zhengxunli@mxic.com.tw>
Subject: RE: [PATCH 07/11] dt-bindings: spi: spi-nxp-fspi: add a new property
 nxp,fspi-dll-slvdly
Thread-Topic: [PATCH 07/11] dt-bindings: spi: spi-nxp-fspi: add a new property
 nxp,fspi-dll-slvdly
Thread-Index: AQHYkFF0qJujufsOTUOD0eIhHoBTUq1viBIAgAALOQCAAAJgAIAAKZ1g
Date:   Tue, 5 Jul 2022 13:19:56 +0000
Message-ID: <DU2PR04MB87747C9A8F18D8300461D6B197819@DU2PR04MB8774.eurprd04.prod.outlook.com>
References: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
 <1657012303-6464-7-git-send-email-haibo.chen@nxp.com>
 <ef676df1-77e0-b8ee-3950-97eade8ddd5b@linaro.org>
 <VI1PR04MB40167A70FBE772DF91047A4190819@VI1PR04MB4016.eurprd04.prod.outlook.com>
 <59d360ef-5374-c7a7-2995-854ab3715b25@linaro.org>
In-Reply-To: <59d360ef-5374-c7a7-2995-854ab3715b25@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6623e09c-720e-4804-7986-08da5e890e1f
x-ms-traffictypediagnostic: VI1PR04MB7103:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MmbikJxpBorj/zrXfLTmYbO3xhZPmsKk4BIQaN4uTA/5l2RNIJKq/oQxrZvNbxPCcsBJWD6i1jVMCAESsdDYKJqGCmGxEwNe0ZDtbkjmgGyoX4cZ8ozlkfbVkWpNK3fsOYFSBmtSmnwBi/amcSnST/YqAoisoQ8n5mije7GG2/g81l5ABjXdCPXqVu5A3E5QoQcos9ul7iZPBpVo98heTcdgtCn/1geYimt1viEwBGOH/ddqVe1TwRP1KIdBD96xdvU8N7H2at1RoCNwTWmSD/3RX77nsoRw84s1SeRxFnpDTvPvfbvjqTiIUHGRvgfl5rhJYMEyfjvu/a0YGbPw/rJGf6EGSex1xN0ROSkGflNcP3H3wIfMEJDkNOjEkn0eeIGMZ01CHkDaAy/Nu+WJm2wZyQMwtA/YAuV/rcxFuGjYNy3fPJ6V4LhBHS/mM0UmMd01f4LtmacsK+0kpWtVtcTvPQwskq/YC46JBUMrSQoaQ2QYANqJKqchzoF/0ZupJ3Wl7ckSqJ9JRODVAxxDvTu9lsKVFPQLuUNddGlaFjEHaHtP6ETABxIY7Au180x6y+Rk5s+e7C1B7FfgZHX1Q470GTmuaJ/zqOJQ+V8Y5eB8wDoCuAqQF4t9CtGDCRlrkI0OtZ2sxos8FUHfBYo7TgGNmhP0r93ePtU6qW6KxFhWJdCil3QQxYWtJ5+sqM6HgkSpee6CObU+UJdwBnvoYhmfRooZoEtmn9oxyjvTMbtqqS+sRUx2vFIGBXL+BZEKgaYlIj1JuJzqwaZrGh6PV6mHXgy7qN7JhGML/SsTqnlZWzSR/VoLjDpRvTAyAl5Tr0qvYJOeEO9zUKVya9TCDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(66476007)(64756008)(8676002)(4326008)(66556008)(66446008)(5660300002)(7416002)(52536014)(8936002)(76116006)(2906002)(66946007)(44832011)(55016003)(86362001)(33656002)(38100700002)(921005)(122000001)(38070700005)(71200400001)(83380400001)(41300700001)(478600001)(9686003)(54906003)(110136005)(316002)(186003)(55236004)(26005)(7696005)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bldoTGx2eWRFZG93MmFncnYzREIyWStDdDc0WHo3RmZEYUU4Rll0V0hHRUFM?=
 =?utf-8?B?dDlKcHdnNFluOTZVdlY5cUQvR0tKbEE0YzZaaWJPeG02QzBpUUgrdlBvR2sv?=
 =?utf-8?B?S1dKQ0lRYXVDWktOMjY5dDV1aVArK2hYV00zTm8rSTVJcGlVUERtWWx0aC9Z?=
 =?utf-8?B?NU56eDVseXpRa3MxZWxNcC81ZThyRU9ORTNBMjBxajdBVEF3aW5FWVZkQ0NO?=
 =?utf-8?B?Q2JxM2srTEFKY0pUUWN2c0FmSzI3Z292NFZOY0IyTmVjaEJSK2JLQllsNHdz?=
 =?utf-8?B?MjcyMFlLMFVrOHM0NVhmOFdYRHpJOWVieG5nNkJ0RFpjY3hLTUx0OHV1allp?=
 =?utf-8?B?b2IwZkt5OWExV2tEb1JCRWczUExocHlOTk14YnlDUFY4dFR2MzQrSy9nYkFW?=
 =?utf-8?B?OWFnMTlnY0UxYkZxRUZUZ2prTGVENEp5WGRDMnBnTHhvM2hYbUJKNll1U3A3?=
 =?utf-8?B?YXlRaVJRU293bm5DYmFPZVJRalRRT2FmdlZCNXE0WDErbTMwd2lKRnY3S1hW?=
 =?utf-8?B?alJTYVFIcGFDazVEeWNwcnBmZjF5bDJIZC9nWkxRWHBmUmNrQXl5TVZFQkRL?=
 =?utf-8?B?OWlVazVOc3Ayd0d5dWtNMDFqOGU5eXc5K2Fwem9oN0s5azBNQk9EL0R4VitH?=
 =?utf-8?B?dzgxMVNmMlRpQ2JkVHNqZktjcnJqdWVPZDZCT2EyU01CZG1odGpOQTVyYXpE?=
 =?utf-8?B?VlEyaHl3SU9qaTczTndrcVhQUlZ4RWRWT2VMRGI0UEFYSHdUdTJIWUlMUkI1?=
 =?utf-8?B?cVZrazVBZWxscnBGM3VxbDRBQU9GSlVsQjN4aW01M2IwcHRIMHVKaE95bjgy?=
 =?utf-8?B?MlVUWFF2RStlWjBvcytLbm43ZzBrMUZ2dUVWbjA4c1FiL2FYU3JKdXc4QWNX?=
 =?utf-8?B?bzE3NXpxSTRPWW5SVWhZOVpvUmVYeldicnJvdStUUHFsOXVFV1MrdzVabER0?=
 =?utf-8?B?bmQvUHJqOGgyMUFsNERiTjJSOXQyWkluTURybmlxT1FrN1c5U3V6d1JYVXlD?=
 =?utf-8?B?V0JtVWRCQTVwMEsvR084VDFqd09jRzdEWmNxREQwQVFKdWN5TlpZTTl5MlIz?=
 =?utf-8?B?SkM2bmRraG9LWEhEYVZpbDBZMnc0VEhLc25HbWJENzZQVTMweWNHQURaMFZO?=
 =?utf-8?B?YklUY0VpaW92RG9aa0ZtWGhEMUEwekNzdDJLQjV6aU5LQS9FRmtlNDlna1Rs?=
 =?utf-8?B?MC80OVVwVzdQZjdJYkZsaXROMWppM09MZjNVbks4Mk16QTNxc3VLZTBMbUVm?=
 =?utf-8?B?bFpNMkg0Q3V4a09sWkg4SzFvdldQTXNYQ1QzVlh1RUlEMmFiWjlIZnBhZWhM?=
 =?utf-8?B?cFVzTFpqQzExSDdzb2d5WnE2TTJUZ01UbFZhQ2VZckJYTHQ0UGQweFI1UGpL?=
 =?utf-8?B?V0ZiZlRyUlM4azA3MWtVbDdQK2xOWXRmbERPMExWUHdtSXRMOWQ4dFVtbDgr?=
 =?utf-8?B?cXBGZlVqMysyT1AyNW53K0lGaFo4SVAxQmh3Y1J1MjU3cVhWNW5UN1FBSWZq?=
 =?utf-8?B?UWhldWJZREczTmRmYXZmRXFmN3VDSmRPeEhKWnVUdS9ndHpmNS9QN3lzTElZ?=
 =?utf-8?B?VitJT2hTWWlrVGVaUFJhK1h0TU5lK1RlZHVDelhwdkk1NjBnNTVZaHY1T3pC?=
 =?utf-8?B?VFBuUStqbk5IYTRrWkFkcTNqRWNJdEdSTXh2SGZ6RWV3R0pTWGgxMkFBQmJh?=
 =?utf-8?B?OXlWKzFjTEZTTktkYzNQaWZmR2NTenF6VkM1ZnlkTzBIVlBiMjl6SEJUNXVO?=
 =?utf-8?B?b1NiejJNdjhHbnRDd1FmOGZ6YXlVTGZ2eGM4TkszSW9oUUlNOEpKSzFZOXp6?=
 =?utf-8?B?QjJ5UHZqUHlnMUZSNkJlZnpCQUxIc0RyZGRranl6ZXZiRmE5REptY1VvWSs2?=
 =?utf-8?B?alZTWFV2VWtwUllVdU9HTWdaMXU1UW42amNGVDNSN3A4RUV2Y2ZWOGtTb1JB?=
 =?utf-8?B?aUU0OXU5RGtIYWlYT3dLb3BVQjFRclBxS3dicENzYzY5QUcwN2VKbzFmU25z?=
 =?utf-8?B?OVRMWHB4STV6S1YrQ3ZLMnlrWUs4U2pIdVlpU1EvN1YxcmJ3RjVlaVlLUTlj?=
 =?utf-8?B?U2FlQTg3RXEvSlIzUGwzemxVK2tad1F3Vm5HOFpvNGRuZkxLakZFTUZMWFox?=
 =?utf-8?Q?sIbs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6623e09c-720e-4804-7986-08da5e890e1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 13:19:56.6507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IUIAx7jW4DSxWFI12A0N6V7//15VRHcqa82giLfS6nyb20XSd2KQLRT4YBd++N/o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj5TZW50OiBUdWVzZGF5LCBKdWx5
IDUsIDIwMjIgNTozNyBBTQ0KPlRvOiBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+OyBh
c2hpc2gua3VtYXJAbnhwLmNvbTsNCj55b2dlc2hnYXVyLjgzQGdtYWlsLmNvbTsgYnJvb25pZUBr
ZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+a3J6eXN6dG9mLmtvemxvd3NraStkdEBs
aW5hcm8ub3JnOyBIYW4gWHUgPGhhbi54dUBueHAuY29tPjsNCj5zaW5naC5rdWxkZWVwODdrQGdt
YWlsLmNvbTsgdHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tOyBwLnlhZGF2QHRpLmNvbTsNCj5t
aWNoYWVsQHdhbGxlLmNjOyBtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tOyByaWNoYXJkQG5vZC5h
dDsgdmlnbmVzaHJAdGkuY29tOw0KPnNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZQ0KPkNjOiBsaW51eC1zcGlAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPmRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZmVzdGV2YW1AZ21haWwu
Y29tOw0KPmRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+emhlbmd4dW5saUBteGljLmNvbS50dw0KPlN1YmplY3Q6
IFJlOiBbUEFUQ0ggMDcvMTFdIGR0LWJpbmRpbmdzOiBzcGk6IHNwaS1ueHAtZnNwaTogYWRkIGEg
bmV3IHByb3BlcnR5DQo+bnhwLGZzcGktZGxsLXNsdmRseQ0KPg0KPk9uIDA1LzA3LzIwMjIgMTI6
MjgsIEJvdWdoIENoZW4gd3JvdGU6DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+
PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5v
cmc+DQo+Pj4gU2VudDogMjAyMuW5tDfmnIg15pelIDE3OjQ4DQo+Pj4gVG86IEJvdWdoIENoZW4g
PGhhaWJvLmNoZW5AbnhwLmNvbT47IGFzaGlzaC5rdW1hckBueHAuY29tOw0KPj4+IHlvZ2VzaGdh
dXIuODNAZ21haWwuY29tOyBicm9vbmllQGtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsN
Cj4+PiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IEhhbiBYdSA8aGFuLnh1QG54
cC5jb20+Ow0KPj4+IHNpbmdoLmt1bGRlZXA4N2tAZ21haWwuY29tOyB0dWRvci5hbWJhcnVzQG1p
Y3JvY2hpcC5jb207DQo+Pj4gcC55YWRhdkB0aS5jb207IG1pY2hhZWxAd2FsbGUuY2M7IG1pcXVl
bC5yYXluYWxAYm9vdGxpbi5jb207DQo+Pj4gcmljaGFyZEBub2QuYXQ7IHZpZ25lc2hyQHRpLmNv
bTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4+PiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGUNCj4+PiBDYzogbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4+PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+Pj4gZmVzdGV2YW1AZ21haWwuY29t
OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4+PiBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IHpoZW5neHVubGlAbXhpYy5jb20udHcNCj4+PiBTdWJqZWN0
OiBSZTogW1BBVENIIDA3LzExXSBkdC1iaW5kaW5nczogc3BpOiBzcGktbnhwLWZzcGk6IGFkZCBh
IG5ldw0KPj4+IHByb3BlcnR5IG54cCxmc3BpLWRsbC1zbHZkbHkNCj4+Pg0KPj4+IE9uIDA1LzA3
LzIwMjIgMTE6MTEsIGhhaWJvLmNoZW5AbnhwLmNvbSB3cm90ZToNCj4+Pj4gRnJvbTogSGFpYm8g
Q2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPj4+Pg0KPj4+PiBBZGQgb25lIG9wdGlvbmFsIHBy
b3BlcnR5IG54cCxmc3BpLWRsbC1zbHZkbHkNCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogSGFp
Ym8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPj4+PiAtLS0NCj4+Pj4gIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLW54cC1mc3BpLnlhbWwgfCA2ICsrKysrKw0K
Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktbnhwLWZzcGku
eWFtbA0KPj4+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktbnhw
LWZzcGkueWFtbA0KPj4+PiBpbmRleCAxYjU1MmMyOTgyNzcuLjZiZDYxNTY1Njg2YSAxMDA2NDQN
Cj4+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktbnhw
LWZzcGkueWFtbA0KPj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c3BpL3NwaS1ueHAtZnNwaS55YW1sDQo+Pj4+IEBAIC00NSw2ICs0NSwxMiBAQCBwcm9wZXJ0aWVz
Og0KPj4+PiAgICAgICAgLSBjb25zdDogZnNwaV9lbg0KPj4+PiAgICAgICAgLSBjb25zdDogZnNw
aQ0KPj4+Pg0KPj4+PiArICBueHAsZnNwaS1kbGwtc2x2ZGx5Og0KPj4+PiArICAgICRyZWY6IC9z
Y2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPj4+PiArICAgIGRlc2NyaXB0
aW9uOiB8DQo+Pj4+ICsgICAgICBTcGVjaWZ5IHRoZSBETEwgc2xhdmUgbGluZSBkZWxheSB2YWx1
ZS4NCj4+Pg0KPj4+IFdoYXQgYXJlIHRoZSB1bml0cz8NCj4+DQo+PiBEbyB5b3UgbWVhbiBoZXJl
IG5lZWQgdG8gZ2l2ZSBtb3JlIGRldGFpbCBleHBsYWluIGFib3V0IHRoaXMgcHJvcGVyaXR5Pw0K
Pj4NCj4+IEhvdyBhYm91dCBjaGFuZ2UgbGlrZSB0aGlzPw0KPj4gICAgU3BlY2lmeSB0aGUgRExM
IHNsYXZlIGxpbmUgZGVsYXkgdmFsdWUuIFRoZSBkZWxheSB0YXJnZXQgZm9yIHNsYXZlIGRlbGF5
IGxpbmUgaXM6DQo+KChueHAsZnNwaS1kbGwtc2x2ZGx5KzEpICogMS8zMiAqIGNsb2NrIGN5Y2xl
IG9mIHJlZmVyZW5jZSBjbG9jayAoc2VyaWFsIHJvb3QgY2xvY2spLg0KPg0KPlRoaXMgd291bGQg
YmUgZ29vZC4NCj4NCj4+IFRoZSByYW5nZSBvZiB0aGlzIHZhbHVlIGlzIDB+MTYuDQo+DQo+VGhp
cyBuZWVkcyB0byBnbyB0byBzY2hlbWEgaW5zdGVhZCBhcyAibWF4aW11bTogMTYiLg0KPg0KPkJ1
dCBzdGlsbCB0aGUgcXVlc3Rpb24gaXMgLSB3aGF0IGFyZSB0aGUgdW5pdHMgdXNlZCBpbiB0aGlz
ICJkZWxheSI/IG1zPyB1cz8NCg0KSEkgS3J6eXN6dG9mLA0KDQpBY2NvcmRpbmcgdG8gdGhlIGZv
cm11bGEsIHRoZSByYW5nZSBzaG91bGQgYmUgMH4xNSwgMTYgc2hvdWxkIGRvIG5vdGhpbmcgb3Ig
bm8gZGVsYXkuDQoNClRoZSB1bml0IHNob3VsZCBiZSBjbG9jayBwaGFzZS4gSW4gb3RoZXIgd29y
ZHMsIHRoZSBkZWxheSBjYW4gYmUgaW4gcmFuZ2Ugb2YgMS8zMn4xLzIgY2xvY2sgY3ljbGUuDQoN
Cg0KPg0KPkJlc3QgcmVnYXJkcywNCj5Lcnp5c3p0b2YNCg==
