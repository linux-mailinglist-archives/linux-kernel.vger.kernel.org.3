Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC3B56402A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 14:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiGBM5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 08:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGBM5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 08:57:03 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8317DE082;
        Sat,  2 Jul 2022 05:57:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ma8kBTt10tshGk9RSFE7MtwDbhEH9IOUksvl8QT2upUmzsvyFsvoNOl0RDK95jdS3Rx347zUWxeHWuhhE7FDU0HoPkjOtG3wMh1dCElVtHEya7kKaBo7vYTzUOwKqfBpOsiL1a4zYzwuGCKIPv4j21yL8z5JA2V3+HmotfLApIQFusQpEjWFNaBMElfep4knfYp3YrgO5eL6k8IpPY6lcG/B5+Nm0Izsj2+LrZlzmKIBtWav6aHn2lUHh7rp9tXV9oBVmQs9pyDjxgoQabAjCCseC/HtQoq4Fs3XBrHlYrc/V+7bM3820xeE7i2lb86CgwpSyJQ639WQFMBTTlA55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9GwjYw/kLeOHhQuBdFjeF32QitrxwxyVRBqYdIPzYA=;
 b=Y8kvlXi8xv4pfi2sCEPvzEuNABwJ2BLbcBArV/GsOAowgyEimPwuST9uNCZAUtFNtjsdnh+DS0zsx7Kt8gAD9k+NV5Yh3Ub1pHqyeLMMe/Klnjul6X4wdtntxJvlclSxjnWxXp8VCVS0aT9NzntIG0TYjZgPk3birBGXhagakJd6oPlQFEOewVtCWhDhhreEen6R3knZcJ1AOCOLF0gYwcYjNSwJzBHM8U4PGD4g497f7UrmVMdxbXCuVWDBAHBIYnZ4Vy7w6UW9+MOVK/bJi4m5ACb2qNwB7ieGzwiZH2uaascQWZA0VCpSu6ywNccbWYCTrROhBRfy19T5bDxSVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9GwjYw/kLeOHhQuBdFjeF32QitrxwxyVRBqYdIPzYA=;
 b=ikYI2ySVhT/7G6QLWiTN2g1OOJPKAhjt7Umd5ggzg6Qkp/72TKAmZ07oifAJNFWBB76kihB9sm2EI5xpb8oDOz6jbWqit+XqtBE15dprQEHdt6u8fZguqGmMi43C3cNE1LAFE+V5+kiLUnsYw7api1zBXpO4PWsLdIaSHWp7fcc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB3038.eurprd04.prod.outlook.com (2603:10a6:802:d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Sat, 2 Jul
 2022 12:56:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5395.015; Sat, 2 Jul 2022
 12:56:59 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "djakov@kernel.org" <djakov@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, Abel Vesa <abel.vesa@nxp.com>,
        "abailon@baylibre.com" <abailon@baylibre.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "aford173@gmail.com" <aford173@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 4/8] soc: imx: add icc paths for i.MX8MP media blk ctrl
Thread-Topic: [PATCH 4/8] soc: imx: add icc paths for i.MX8MP media blk ctrl
Thread-Index: AQHYdZwqPuj5ainDSECqAReSIBF/xa1mseIAgASIWGA=
Date:   Sat, 2 Jul 2022 12:56:59 +0000
Message-ID: <DU0PR04MB941700B61A125B1729F81F8188BC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
         <20220601094537.3390127-5-peng.fan@oss.nxp.com>
 <bf8289b9223a135c26363c27c2f5e35baa448032.camel@pengutronix.de>
In-Reply-To: <bf8289b9223a135c26363c27c2f5e35baa448032.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ca1346e-206d-47f3-8c3d-08da5c2a5a26
x-ms-traffictypediagnostic: VI1PR04MB3038:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1PaXfK2+LLWHKTLi/svlIbl8NaEPenxMGNQM99FeY008CR+7IC2VfAj0YY+SUe6pgJYRy6aBmDTBS5GfX9cvJKrHPu66vVQqcLNSaTkTtHKY8uZgYc46R34TW8VL+Bvk1fxDqKzNml1qf62IUqdcXMheyp3BRxOR0LDmph/q0yVGqiXNAC/gXMVRxNRau2Esr+gS9cid2xtXHNy0Xmz+pINq0/XpI2CCRgMuzj8ly21sfk7EPDCdIGEUlkURHwqkGAfeJR2+hVw/iggfGr/j1gA9nU2mnBVbs1gtQrG6+DdkBlWS1WA5b/eyhvEKx3i8ohjwOmsU8jfr9Ny6iWmcWXf1HSgeALbsRODV207EyXef9DyZb7HwyCFlg4GEnNGJ05MuE/Kd6VykcABtABPpAeQNpTKIuOzA1bpRDR27zY8yz6q9z8IjCdp00FckTfxZWDRWxnQnMIkXVLa82BsGiYuDLYsgbJ91SSyVOTsYsS7pjswWlhH9IH3PJbQ2XpZlRdqmOOmmI0erJm954al+i72dzQXzlkGLyQIv9lSgPpJ7FN5vC7bmSjK/0xDZbfOwhlUHFtYwCJSo9siBNkfYL2+e2TycNT5Ge1Chhe8M0q4PS9hPEhPBrXV5N/59YHIZIFiUuulP1pu1k6dFgB0iKxh++Bs/Y5yXw4eyUXcpCk3m5hFBACqqjTTt20xp25bnWBaS2WD7k7+08rqfLuxbq5w7f+qL0Ao0ku4WIDJhye7OGFP7Jq/Qx0FYoy27mLkugXXYBeo2hjIqlDI19pQflP4w5wWaL28vsDJIv35yxK5WKguBi2e9HMngjHQYTIntQTnU5oR9edIVYX9wf9jF3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(44832011)(5660300002)(52536014)(66476007)(64756008)(66556008)(7416002)(33656002)(8936002)(4326008)(76116006)(86362001)(55016003)(8676002)(66946007)(2906002)(66446008)(122000001)(38100700002)(921005)(38070700005)(41300700001)(9686003)(316002)(478600001)(7696005)(26005)(186003)(71200400001)(110136005)(83380400001)(54906003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHJvODBuUFhBeU1raEFkY21KL29KSjNmSExSbm1rVVBLLzJjTlBUcWdwc1hV?=
 =?utf-8?B?T1VKcHZGM2Fncm5iaGNTNk5yNUhyaGh1eDArL0lFUFpIMEdqa0hUWUtKRjJV?=
 =?utf-8?B?c0NKeDZXQngrUUJkZE9ZNWtVeWtZbWJzT2NDbGt6aTJVdzgvekxaWnFHQ3o0?=
 =?utf-8?B?TWVJblZDVkRqNE5HTTdUTWV5U0doNy83V0xhOXVRc2pVL0J1WGdTckJkUVZy?=
 =?utf-8?B?aG8zZk1jbi9ybjcrclA2ZGNLR0RrWjZMUzJGSVZiNVJEVmgwNGJmUlUwN1NE?=
 =?utf-8?B?dHhWVG1NTFdVUHV5VEJzYlNhb3JoSFRIS3g3Qk1IblcvOHUyQlZBM2kwcDV3?=
 =?utf-8?B?dXA3VVFuOGN2S1BpbVRtQm1meW9KSERCN0gzYVE5aitHRnVpK0tJS0pGMHFu?=
 =?utf-8?B?djMyeFNnUUJtSDNreWRCVWRXYXE3TVhyTCtBTzdXQU5qWEErSGs2SG9UV090?=
 =?utf-8?B?WWNUNUNpb2FEN3pPZysreGdLTXQvQXFKMzhnWElIdi9BS1R3WGZGcTg2Ti8y?=
 =?utf-8?B?Q29UdjRubWFmRS83TGNhOWl3dDFOaHJnL2dWTFRJWnl6dTcxeENGRkkzVWdH?=
 =?utf-8?B?bW81N1pZdVFOYnBKTzljYmlCWmV4anQzQyt4QzBVcFhYVXh1T1dOQnM3TDlw?=
 =?utf-8?B?d3F1ZnRwQnR2YUVFN0RnNnVhUzFkajN5UkdGRWNwV3VoRnpZN1FQL0dzRmRj?=
 =?utf-8?B?QWVvSFhrdzBRb3JPSnhzMTVEVWFlMnRIYTU0cGVKRCs4Tm5zUDBTTnI5RmVQ?=
 =?utf-8?B?bDdOUkJGTmNVVSthOUJZU3VRTUhTNjREY3ZrZWx4c3lDY0FaS2FZWHNWV1Bz?=
 =?utf-8?B?Q0taWk9SK29pSTVRZnBJbTFwNnZuRlgzYmVkTUhVazlScmFUeC9EaG5VTU9y?=
 =?utf-8?B?U0NvSXFuTWJndi93bnZnRU42UVNWTHg1NFh1L2dlaTdYd2kyeWJjdHg3TzQ2?=
 =?utf-8?B?SEpKZnJrREk3cHhZSWJHYzRQSkVFa1ZERU9wcWJqZS91Zm5LekxOaWh6aWpS?=
 =?utf-8?B?cFNVSTUza2ZVMmdzL1hqeFAxa01IRjJMV0Y3VXc0RStBNjhXRWNkd0NraVNO?=
 =?utf-8?B?dDh0UWEyRklLbHowUGFMeDlzU1RNL0lRak95akd2ZVR2TlZUaFI5Y3B3V3Jk?=
 =?utf-8?B?U1dIT3hmWFRXMDFDNTgyRFRTdW53R2ZtL29WWXNCTlBsUXJEZHN5cWdWL2Yw?=
 =?utf-8?B?b1l1K2RCTlJvWXkrRS9CNDJKOFdrc1Zvbm9UMy9Udi80QmYwZHpEQTBwNzd6?=
 =?utf-8?B?bDhpcU5rLzhsTkJ5YVJia2pYeEZOcmd4VzlweW5vc2xDeHM2SG1FWHpWcy9I?=
 =?utf-8?B?SllyVCtTckFlajRlNTJCakd3NlMyRE9LNTNxNGVBdFNQM2pLRjY1b3Exc0w4?=
 =?utf-8?B?SS9TaFdOZm5hODZqbmdySlp2QTZXeXZ1aVduMXhpaGxabVRtMkN2RGZDdm90?=
 =?utf-8?B?WSt5YTJlcVU5eHpmVGNRU3kxMnZIMnpRTDNxTEpxdTBLdmFteHd1c2VnRnJZ?=
 =?utf-8?B?Q0FwckVjTzFiTXFPbzFqcitna0s5bjExM0xONThsUnBBL0U0NXhvMTZHdVRl?=
 =?utf-8?B?U1ZOSGRXRStXN0hMNGF2NFovdTY5OXpBTXd3YVNuYjNOdWxKMkt5ejV0TWEx?=
 =?utf-8?B?RVltZ0FNTWJ4WUdVQW9tUXg4NUw5MnV6UTR4TFVqT3NXVzRBMVEza3pNb1Jy?=
 =?utf-8?B?dkJXU0l0SzFEVlgwb0huOW12U25BTTVWNUp0ZjhqeEhrTVBXZkc5RGdtYVN6?=
 =?utf-8?B?OW5YNWlmd01IK25ZajVNMHJubURPRHJZeU5lRGJmZHBDL2VycFM3cis5QzZK?=
 =?utf-8?B?R1hHS3BDQ3VxZG4rQ1M4SFQydU1FZEJTdmV0aDdUc29JdHplcUZoTkpiY2g2?=
 =?utf-8?B?aVdFRHlEeTVWZjFJZlBBQjVjT0kwVzNpWW05VTU2Y1dPYWx0eFlEbFo2VHdP?=
 =?utf-8?B?eDM1K2xwcXVkUHBjWWdiaXJQNE9YYm5vMjRoQzUxM09PUnhGOXZpRlo1eVAr?=
 =?utf-8?B?cElnZ3VwRkg0RHhscGhYZVBlR2tmY2J3dmIzK0lUZGFoVmtlZVZBd3JZdm0r?=
 =?utf-8?B?MzVwWU9EYW1RZU5VckJ5QWlrYjFrcUZqRlp2QXAyTXpWZGN0QS9veFNGYXhs?=
 =?utf-8?Q?yadQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca1346e-206d-47f3-8c3d-08da5c2a5a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2022 12:56:59.7047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yu7MHYqKurcUsMgfi/uVzHMHm960sMzgGrA1lAt4hzGve0xGhQq8qF9vLyLd/lBOZpZp8x88Kgv5899kqwrwNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDQvOF0gc29jOiBpbXg6IGFkZCBpY2MgcGF0aHMgZm9yIGku
TVg4TVAgbWVkaWEgYmxrIGN0cmwNCj4gDQo+IEFtIE1pdHR3b2NoLCBkZW0gMDEuMDYuMjAyMiB1
bSAxNzo0NSArMDgwMCBzY2hyaWViIFBlbmcgRmFuIChPU1MpOg0KPiA+IEZyb206IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gQWRkIGludGVyY29ubmVjdCBwYXRocyBmb3Ig
aS5NWDhNUCBtZWRpYSBibGsgY3RybA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4g
PHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtcC5kdHNpIHwgIDEgKw0KPiA+ICBkcml2ZXJzL3NvYy9pbXgvaW14OG0tYmxr
LWN0cmwuYyAgICAgICAgICB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmls
ZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+IGluZGV4IGQ5NTQyZGZmZjgzZi4uMmEx
YzZmZjM3ZTAzIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtcC5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1wLmR0c2kNCj4gPiBAQCAtNCw2ICs0LDcgQEANCj4gPiAgICovDQo+ID4NCj4gPiAgI2luY2x1
ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL2lteDhtcC1jbG9jay5oPg0KPiA+ICsjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvaW50ZXJjb25uZWN0L2ZzbCxpbXg4bXAuaD4NCj4gPiAgI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL3Bvd2VyL2lteDhtcC1wb3dlci5oPg0KPiA+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
Z3Bpby9ncGlvLmg+DQo+ID4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnB1dC9pbnB1dC5oPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9pbXgvaW14OG0tYmxrLWN0cmwuYw0KPiA+IGIv
ZHJpdmVycy9zb2MvaW14L2lteDhtLWJsay1jdHJsLmMNCj4gPiBpbmRleCA3ZjQ5Mzg1ZWQyZjgu
LjQyM2NhYzBjOWNiNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9pbXgvaW14OG0tYmxr
LWN0cmwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL2lteC9pbXg4bS1ibGstY3RybC5jDQo+ID4g
QEAgLTUsNiArNSw3IEBADQo+ID4gICAqLw0KPiA+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9kZXZp
Y2UuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2ludGVyY29ubmVjdC5oPg0KPiA+ICAjaW5jbHVk
ZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4g
PiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+IEBAIC0zNyw2ICszOCw4
IEBAIHN0cnVjdCBpbXg4bV9ibGtfY3RybF9kb21haW5fZGF0YSB7DQo+ID4gIAljb25zdCBjaGFy
ICpuYW1lOw0KPiA+ICAJY29uc3QgY2hhciAqIGNvbnN0ICpjbGtfbmFtZXM7DQo+ID4gIAlpbnQg
bnVtX2Nsa3M7DQo+ID4gKwljb25zdCBjaGFyICogY29uc3QgKnBhdGhfbmFtZXM7DQo+ID4gKwlp
bnQgbnVtX3BhdGhzOw0KPiA+ICAJY29uc3QgY2hhciAqZ3BjX25hbWU7DQo+ID4gIAl1MzIgcnN0
X21hc2s7DQo+ID4gIAl1MzIgY2xrX21hc2s7DQo+ID4gQEAgLTUyLDExICs1NSwxMyBAQCBzdHJ1
Y3QgaW14OG1fYmxrX2N0cmxfZG9tYWluX2RhdGEgeyAgfTsNCj4gPg0KPiA+ICAjZGVmaW5lIERP
TUFJTl9NQVhfQ0xLUyA0DQo+ID4gKyNkZWZpbmUgRE9NQUlOX01BWF9QQVRIUyA0DQo+ID4NCj4g
PiAgc3RydWN0IGlteDhtX2Jsa19jdHJsX2RvbWFpbiB7DQo+ID4gIAlzdHJ1Y3QgZ2VuZXJpY19w
bV9kb21haW4gZ2VucGQ7DQo+ID4gIAljb25zdCBzdHJ1Y3QgaW14OG1fYmxrX2N0cmxfZG9tYWlu
X2RhdGEgKmRhdGE7DQo+ID4gIAlzdHJ1Y3QgY2xrX2J1bGtfZGF0YSBjbGtzW0RPTUFJTl9NQVhf
Q0xLU107DQo+ID4gKwlzdHJ1Y3QgaWNjX2J1bGtfZGF0YSBwYXRoc1tET01BSU5fTUFYX1BBVEhT
XTsNCj4gPiAgCXN0cnVjdCBkZXZpY2UgKnBvd2VyX2RldjsNCj4gPiAgCXN0cnVjdCBpbXg4bV9i
bGtfY3RybCAqYmM7DQo+ID4gIH07DQo+ID4gQEAgLTExNyw2ICsxMjIsMTAgQEAgc3RhdGljIGlu
dCBpbXg4bV9ibGtfY3RybF9wb3dlcl9vbihzdHJ1Y3QNCj4gZ2VuZXJpY19wbV9kb21haW4gKmdl
bnBkKQ0KPiA+ICAJaWYgKGRhdGEtPm1pcGlfcGh5X3JzdF9tYXNrKQ0KPiA+ICAJCXJlZ21hcF9z
ZXRfYml0cyhiYy0+cmVnbWFwLCBCTEtfTUlQSV9SRVNFVF9ESVYsDQo+ID4gZGF0YS0+bWlwaV9w
aHlfcnN0X21hc2spOw0KPiA+DQo+ID4gKwlyZXQgPSBpY2NfYnVsa19zZXRfYncoZGF0YS0+bnVt
X3BhdGhzLCBkb21haW4tPnBhdGhzKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJZGV2X2Vycihi
Yy0+ZGV2LCAiZmFpbGVkIHRvIHNldCBpY2MgYndcbiIpOw0KPiA+ICsNCj4gPiAgCS8qIGRpc2Fi
bGUgdXBzdHJlYW0gY2xvY2tzICovDQo+ID4gIAljbGtfYnVsa19kaXNhYmxlX3VucHJlcGFyZShk
YXRhLT5udW1fY2xrcywgZG9tYWluLT5jbGtzKTsNCj4gPg0KPiA+IEBAIC0yMjgsNiArMjM3LDE4
IEBAIHN0YXRpYyBpbnQgaW14OG1fYmxrX2N0cmxfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gPiAgCQlmb3IgKGogPSAwOyBqIDwgZGF0YS0+bnVtX2Nsa3M7IGorKykN
Cj4gPiAgCQkJZG9tYWluLT5jbGtzW2pdLmlkID0gZGF0YS0+Y2xrX25hbWVzW2pdOw0KPiA+DQo+
ID4gKwkJZm9yIChqID0gMDsgaiA8IGRhdGEtPm51bV9wYXRoczsgaisrKSB7DQo+ID4gKwkJCWRv
bWFpbi0+cGF0aHNbal0ubmFtZSA9IGRhdGEtPnBhdGhfbmFtZXNbal07DQo+ID4gKwkJCWRvbWFp
bi0+cGF0aHNbal0uYXZnX2J3ID0gSU5UX01BWDsNCj4gPiArCQkJZG9tYWluLT5wYXRoc1tqXS5w
ZWFrX2J3ID0gSU5UX01BWDsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCXJldCA9IGRldm1fb2Zf
aWNjX2J1bGtfZ2V0KGRldiwgZGF0YS0+bnVtX3BhdGhzLA0KPiBkb21haW4tPnBhdGhzKTsNCj4g
PiArCQlpZiAocmV0KSB7DQo+ID4gKwkJCWRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJmYWlsZWQg
dG8gZ2V0IG5vYw0KPiBlbnRyaWVzXG4iKTsNCj4gDQo+IEkgZG9uJ3QgbGlrZSB0aGF0IHRoaXMg
aW50cm9kdWNlcyBhIG5ldyByZXF1aXJlbWVudCB0byB0aGUga2VybmVsIGNvbmZpZyBhbmQNCj4g
RFQsIHdoaWNoIGlzIGEgYmFja3dhcmRzIGNvbXBhdCBicmVha2luZyBjaGFuZ2UuIE5vdyBvbmUg
Y291bGQgYXJndWUNCj4gdGhhdCB0aGUgTm9DIGNvbmZpZ3VyYXRpb24gaXMgcHJldHR5IGNyaXRp
Y2FsIGFuZCBzaG91bGQgbm90IGJlIHNraXBwZWQsIGJ1dCBpdA0KPiBoYXMgdGhlIHBvdGVudGlh
bCB0byBicmVhayBjdXJyZW50bHkgd29ya2luZyBzeXN0ZW1zLg0KPiANCj4gSSB0aGluayBpdCB3
b3VsZCBiZSBiZXR0ZXIgZG8gYQ0KPiBpZiAocmV0ICE9IC1FUFJPQkVfREVGRVIpDQo+IAlkZXZf
d2Fybl9vbmNlKGRldiwgIkNvdWxkIG5vdCBnZXQgaW50ZXJjb25uZWN0IHBhdGhzLCBOb0Mgd2ls
bA0KPiBzdGF5IHVuY29uZmlndXJlZCFcbiIpOw0KPiANCj4gaGVyZSBhbmQgaWdub3JlIHRoZSBl
cnJvciB0byBhbGxvdyB0aGUgYmxrLWN0cmwgdG8gcHJvYmUgZXZlbiBpZiB0aGUNCj4gaW50ZXJj
b25uZWN0IHBhdGhzIGNvdWxkbid0IGJlIGZvdW5kIGR1ZSB0byBsYWNraW5nIGtlcm5lbCBjb25m
aWcgb3IgRFQuDQpbUGVuZyBGYW5dIA0KDQpHb29kIHBvaW50LiBTbw0KDQpJZiAocmV0ICYmIHJl
dCAhPSAtRVBST0JFX0RFRkVSKQ0KCWRldl93YXJuX29uY2UoZGV2LCAiQ291bGQgbm90IGdldCBp
bnRlcmNvbm5lY3QgcGF0aHMsIE5vQyB3aWxsIHN0YXkNCnVuY29uZmlndXJlZCFcbiIpOw0KDQpU
aGFua3MsDQpQZW5nLg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBMdWNhcw0KPiANCj4gPiArCQkJZ290
byBjbGVhbnVwX3BkczsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICAJCXJldCA9IGRldm1fY2xrX2J1
bGtfZ2V0KGRldiwgZGF0YS0+bnVtX2Nsa3MsIGRvbWFpbi0NCj4gPmNsa3MpOw0KPiA+ICAJCWlm
IChyZXQpIHsNCj4gPiAgCQkJZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgImZhaWxlZCB0byBnZXQg
Y2xvY2tcbiIpOyBAQA0KPiAtNjQ3LDYgKzY2OCw4DQo+ID4gQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBpbXg4bV9ibGtfY3RybF9kb21haW5fZGF0YQ0KPiBpbXg4bXBfbWVkaWFfYmxrX2N0bF9kb21h
aW5fZGF0YVsNCj4gPiAgCQkuZ3BjX25hbWUgPSAibGNkaWYxIiwNCj4gPiAgCQkucnN0X21hc2sg
PSBCSVQoNCkgfCBCSVQoNSkgfCBCSVQoMjMpLA0KPiA+ICAJCS5jbGtfbWFzayA9IEJJVCg0KSB8
IEJJVCg1KSB8IEJJVCgyMyksDQo+ID4gKwkJLnBhdGhfbmFtZXMgPSAoY29uc3QgY2hhciAqW10p
eyJsY2RpZi1yZCIsICJsY2RpZi13ciJ9LA0KPiA+ICsJCS5udW1fcGF0aHMgPSAyLA0KPiA+ICAJ
fSwNCj4gPiAgCVtJTVg4TVBfTUVESUFCTEtfUERfSVNJXSA9IHsNCj4gPiAgCQkubmFtZSA9ICJt
ZWRpYWJsay1pc2kiLA0KPiA+IEBAIC02NTUsNiArNjc4LDggQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBpbXg4bV9ibGtfY3RybF9kb21haW5fZGF0YQ0KPiBpbXg4bXBfbWVkaWFfYmxrX2N0bF9kb21h
aW5fZGF0YVsNCj4gPiAgCQkuZ3BjX25hbWUgPSAiaXNpIiwNCj4gPiAgCQkucnN0X21hc2sgPSBC
SVQoNikgfCBCSVQoNyksDQo+ID4gIAkJLmNsa19tYXNrID0gQklUKDYpIHwgQklUKDcpLA0KPiA+
ICsJCS5wYXRoX25hbWVzID0gKGNvbnN0IGNoYXIgKltdKXsiaXNpMCIsICJpc2kxIiwgImlzaTIi
fSwNCj4gPiArCQkubnVtX3BhdGhzID0gMywNCj4gPiAgCX0sDQo+ID4gIAlbSU1YOE1QX01FRElB
QkxLX1BEX01JUElfQ1NJMl8yXSA9IHsNCj4gPiAgCQkubmFtZSA9ICJtZWRpYWJsay1taXBpLWNz
aTItMiIsDQo+ID4gQEAgLTY3Miw2ICs2OTcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteDht
X2Jsa19jdHJsX2RvbWFpbl9kYXRhDQo+IGlteDhtcF9tZWRpYV9ibGtfY3RsX2RvbWFpbl9kYXRh
Ww0KPiA+ICAJCS5ncGNfbmFtZSA9ICJsY2RpZjIiLA0KPiA+ICAJCS5yc3RfbWFzayA9IEJJVCgx
MSkgfCBCSVQoMTIpIHwgQklUKDI0KSwNCj4gPiAgCQkuY2xrX21hc2sgPSBCSVQoMTEpIHwgQklU
KDEyKSB8IEJJVCgyNCksDQo+ID4gKwkJLnBhdGhfbmFtZXMgPSAoY29uc3QgY2hhciAqW10peyJs
Y2RpZi1yZCIsICJsY2RpZi13ciJ9LA0KPiA+ICsJCS5udW1fcGF0aHMgPSAyLA0KPiA+ICAJfSwN
Cj4gPiAgCVtJTVg4TVBfTUVESUFCTEtfUERfSVNQXSA9IHsNCj4gPiAgCQkubmFtZSA9ICJtZWRp
YWJsay1pc3AiLA0KPiA+IEBAIC02ODAsNiArNzA3LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBp
bXg4bV9ibGtfY3RybF9kb21haW5fZGF0YQ0KPiBpbXg4bXBfbWVkaWFfYmxrX2N0bF9kb21haW5f
ZGF0YVsNCj4gPiAgCQkuZ3BjX25hbWUgPSAiaXNwIiwNCj4gPiAgCQkucnN0X21hc2sgPSBCSVQo
MTYpIHwgQklUKDE3KSB8IEJJVCgxOCksDQo+ID4gIAkJLmNsa19tYXNrID0gQklUKDE2KSB8IEJJ
VCgxNykgfCBCSVQoMTgpLA0KPiA+ICsJCS5wYXRoX25hbWVzID0gKGNvbnN0IGNoYXIgKltdKXsi
aXNwMCIsICJpc3AxIn0sDQo+ID4gKwkJLm51bV9wYXRocyA9IDIsDQo+ID4gIAl9LA0KPiA+ICAJ
W0lNWDhNUF9NRURJQUJMS19QRF9EV0VdID0gew0KPiA+ICAJCS5uYW1lID0gIm1lZGlhYmxrLWR3
ZSIsDQo+ID4gQEAgLTY4OCw2ICs3MTcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteDhtX2Js
a19jdHJsX2RvbWFpbl9kYXRhDQo+IGlteDhtcF9tZWRpYV9ibGtfY3RsX2RvbWFpbl9kYXRhWw0K
PiA+ICAJCS5ncGNfbmFtZSA9ICJkd2UiLA0KPiA+ICAJCS5yc3RfbWFzayA9IEJJVCgxOSkgfCBC
SVQoMjApIHwgQklUKDIxKSwNCj4gPiAgCQkuY2xrX21hc2sgPSBCSVQoMTkpIHwgQklUKDIwKSB8
IEJJVCgyMSksDQo+ID4gKwkJLnBhdGhfbmFtZXMgPSAoY29uc3QgY2hhciAqW10peyJkd2UifSwN
Cj4gPiArCQkubnVtX3BhdGhzID0gMSwNCj4gPiAgCX0sDQo+ID4gIAlbSU1YOE1QX01FRElBQkxL
X1BEX01JUElfRFNJXzJdID0gew0KPiA+ICAJCS5uYW1lID0gIm1lZGlhYmxrLW1pcGktZHNpLTIi
LA0KPiANCg0K
