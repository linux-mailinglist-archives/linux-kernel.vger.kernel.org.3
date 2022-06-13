Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2895547D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 03:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiFMBRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 21:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiFMBRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 21:17:43 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D822F03A;
        Sun, 12 Jun 2022 18:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6PZHZXIP5aC6bmXGINUn8q1lummW+flWyA+K4rYI2z1s4LzYVrSTs7Vuy6DIM5s0jNfrFkAcUxqGWiwzPZYtrJTDkAtw+dGidtAiRR1zdHoTFQNDHJfYCVox5SIBpPs7NSZ/iZ+bVIQ/Il8UllIBH5sX8CXL8gEWumm+hPFs0ig/ohWW9Msw4AOYCPou0YLZb2SXnTsmPjqqb+dL3qCxtK7JL+JCAUrRo5qPfRvn8MYKe8jHIUknRc6b8rTe2uIyxFiFqIWnTQW2yJqSXv9xGhFSrlOKIQh6hQfD1fU/zfx04PfD3H4o4aNMFba8DhJ5cZpsjI6Aofyw/5M5r9nvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9MNzEn815pnZ4TponmJc2uA0DR5Vp7qkxzHLVJk+ms=;
 b=UhviSBFg077TP6fw8nFT4Lvbj9zMDyE4Gr5IwlmWLuR6yGMj3/PWN3Z+bMsVum1KW8QW8j0BPymq0W314OBqNJIE7/YJsI0NqxToEJp2VmEz70NRrlOj0beBpxDFpBeLcZbksLmmGzN0yjI5B1ooR4Y5Io1o2fHjDoZxDmmmmL4rYpRU38owmSV7//6CHgEGaClqTZesQKQ45HYPgcnv88wF800gvIzKVKfqRFnbk89p30ZO1nRCbHGlX4QYxXTlq9jMrYaSjZnD/xYIhb6vBV04Gyw8GUb11Frbtx2mKPTuQIQgHbmmWiFsjz3urDkYK8o6u1H0kZtPFSGIv9mHfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9MNzEn815pnZ4TponmJc2uA0DR5Vp7qkxzHLVJk+ms=;
 b=b49DStItsv3fZF/wFfl+2fiNGC7j+X/vbHKdL14+BLxjQ76wC2CxcmlSZ217erVw/4Xn92mEEkon7w01xaTGh+6XBjyfex0vTLNCMWXwejWFh52pHH0qWn+b8WrJkuoteHnGKDJtlhPOBZ5V2aGYiV/OVhAb5SYxIq6twqQQ8OY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8346.eurprd04.prod.outlook.com (2603:10a6:10:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Mon, 13 Jun
 2022 01:17:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.015; Mon, 13 Jun 2022
 01:17:38 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "djakov@kernel.org" <djakov@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, Abel Vesa <abel.vesa@nxp.com>,
        "abailon@baylibre.com" <abailon@baylibre.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 3/8] interconnect: imx: fix max_node_id
Thread-Topic: [PATCH 3/8] interconnect: imx: fix max_node_id
Thread-Index: AQHYdZuihaC0Os5qR0+3r4Y7gVOOwq0+ZNmAgA42kAA=
Date:   Mon, 13 Jun 2022 01:17:38 +0000
Message-ID: <DU0PR04MB9417F8685D772919F7277EC788AB9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
 <20220601094156.3388454-4-peng.fan@oss.nxp.com>
 <Ypqj278FfhmTKkNL@pendragon.ideasonboard.com>
In-Reply-To: <Ypqj278FfhmTKkNL@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 880ea3cc-ed49-4d78-436c-08da4cda816f
x-ms-traffictypediagnostic: DB9PR04MB8346:EE_
x-microsoft-antispam-prvs: <DB9PR04MB8346C8176CDB8D0F3028102F88AB9@DB9PR04MB8346.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9TK+HNAJe7yNF2VU06bJhrBCyvxckbAS18Xc9yid8LVYLGuzNnoaBGu2Un0ELbTCMp4tNiKUSBY7AecBwOf2DxRV4olpuCbQfzrigb+gchPJnaO/dDEn8lxncNsgNybh44+wQx0BII6MDLRL15cQtr3ED6xOEtgM4ONfkSHn1bcjh1gtVk01fJ4ACnDQNskZgktcHzZ1OZX7fEqoghZP0Ksh7m6FRBlmQqm/bjBXCOqORoqP1J1tkMB5nqeyzswq2X9iYnJpQaxhjIxvayVKl2xZgE/5loRZERW0LL+eVpniFch4slwtIUcgxUCveTXQb8rBe6vJz35zNX5/R3G5yKLIpc255cyiDj4+7qBUbupM08jb2OajNOBzVFn0Ye0Zbonhc/LikA4z38czy2eq25TcgnPtBeWRyIwJMxR+n2pvmvH43uoNuhRo4co3Kd7m/2K3wHpfIY/254SV1IR15XnMq5GKe4Oknilll/daFGR12T+oA8i/wlrStcVqDanplwCdOcZNYcJ3PM78XtL5z7c6dqcfS+JSh+3bo/CXjXknfPhqYUUVhv0Z1w/zHue0cQ3WWLZFOyBDCcKL9PWf1sVhbQYvwcaSRflwjeaPh6cgC9DAB1b9dK0aq/CDut5pMBQ6Wn5zC8lDeZdPxrqd/Nt8zj36UFp+5a7oJRpQK6XumCjbX53+dGRoh3zOWaRcSsejKrXZ5vz0XCtK01dIfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38070700005)(71200400001)(122000001)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(508600001)(76116006)(86362001)(4326008)(54906003)(110136005)(316002)(38100700002)(186003)(6506007)(7696005)(26005)(83380400001)(9686003)(44832011)(52536014)(5660300002)(33656002)(2906002)(7416002)(55016003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0xKUjNrNHJ4d1RNRUI5ZUlWb3dBSk5IQldqMlRzN05RUXVHZDlrSGhwMzUr?=
 =?utf-8?B?T1ZyclNYY3NydTFVWFErZ1R1NkF4OHduZGl5Y3VyT1BicUo4b3hSaUZhMnJD?=
 =?utf-8?B?b0grYnBaRmJwaXFINTkrd0dUMzRYNHlCZlFWOUxrMUIrRG9GaUtDOUFsSXN0?=
 =?utf-8?B?Y2hpTlpqazZ2dElnUk5tbFpxY3Y1VXZyR0hubTVNOWpWYTZFT2xjUWorbVVp?=
 =?utf-8?B?Q1NkOFFvaHMzakw4WjFRdEdtbS9ycDlVRUUxMEhjb0lNUXVGQmNrNWRRSUNF?=
 =?utf-8?B?Ukh1VGlZTlcyR20rRUNyWGM5a0M5WE5xdjFWNWY1SnRNc3V0NmFnU3J6YmtQ?=
 =?utf-8?B?T3ZuUWtaNkNNWko5THJMYXlnNGF4M3ljcjE5SGtqSnVIOG9tbVdndGFtb3Nr?=
 =?utf-8?B?MkJtWDE3SUdBSG0vNEVPWDg3a2tBNHN1UzBoaHMrNC9GNDNZQWNFeURGK2Ev?=
 =?utf-8?B?bkhpblpFSE5qSXBGZU44LzRrUmp1aXpLK0FGMnNCTExaZXVSUnR5ZDRiTkFr?=
 =?utf-8?B?SVZmMVBEamVEeW50TXZLNk1SaVQ0V3ZHdnZVMml3aUg2VmRPL2h2bnp5c0xk?=
 =?utf-8?B?bFJnYVNiM2JaVGI1czk2a2xLMUQvc3E1bjlLYzkrREp5Z2JQSFBtaDRJbVFs?=
 =?utf-8?B?ZWljUXN6SzRvRUtGbGEzSEJ4d0xqRU1SMXBIYWF4TXZlZ0h6NEhHNEdnQU9E?=
 =?utf-8?B?VnVqTlNSbkdkdUNNdGYrZTNBdUh1cXQ5djB3RXdqTFIvaVRCWC9CM1I5Wm5o?=
 =?utf-8?B?V0JMY29MSWpnRUhTeXZOZ3BRWlhSdUhGZE5KQ1FTR0lieGRrb3EzK3FOU1VP?=
 =?utf-8?B?VFBBbjhoSXljK2Y4TDV2K2hhWk16V2RlaThOdE1LR29WcmFXdU9ZWGQ0ZXhK?=
 =?utf-8?B?bXRrNm4vR0E5Y1hpWk5SWWJnNkxPdXE2bHFIejM2VTB0V0dxbjlSZWtPRXR1?=
 =?utf-8?B?RU5FUi9BNEVWV0hja09IQy9WMmZYWlVOMDRoOVRxOWNyMW95RGVFeG5LNzJx?=
 =?utf-8?B?ZmNoM09EeXFoOTdBcVZ2WmxsVU1BM29FYWthaUQ1NTNsRjc2dGVZd09KbFBk?=
 =?utf-8?B?WVlCbC9vSkozR1FXVURHY05rWVF0dzczdlZjbVRoZGxJZU9LUENnQ2Q4L0Z5?=
 =?utf-8?B?Sm1panBBOXp5cWc5MmpkdlBFdWhMYUJHdVU3WFEvVUZ1cTEzeUl0VWIwQWZ4?=
 =?utf-8?B?QlQ2NnpaNE5Gc09MTGl6S0drTVRhUXlXYmp5NGZ5T0VFTk53NGFLR0JMQXNZ?=
 =?utf-8?B?dUQrRlpZdTRBcDhUOWkxT1FGR0N5VmNnc2Vyb2toeG13eVQwd080VyszWVdE?=
 =?utf-8?B?emhxTzI2ZHRHTFZKNW8xTE02V1gxc1BVeDNiOGhhRUozRDFNYjlyUmp4c3RH?=
 =?utf-8?B?eGpkdUxGNkFxcnJ4dkRKYVNybUlnUGFLUHh1MjM5VzVQL2duMG9jV0szSndl?=
 =?utf-8?B?MzhWR0NTMU5sRjlqNllWUHh2dVk0dkhneVhsVzZBdXQzSGRkZ1M1NGZRcDlr?=
 =?utf-8?B?Tmw2TU96ZlZjc3dzUXU0ejhIOStLaHA3eXpHVTF2ZVhpdGdaaVI5MUU3ZmZu?=
 =?utf-8?B?STBkenRwTXpFdFZoSVNxMTFNK3JjYktZUXhBUThYaUphNis1Z2o5S1hXV3dq?=
 =?utf-8?B?RDhzanRaVHV5dmZtSlYxQjdkZFUveVF3MHVIOFByY2VhRUs3U3FNSllkeGM1?=
 =?utf-8?B?YmM4TS9aN0Nwb2pYRmpkTUJFME5XZUtkR2dzclNTNktiRkd3S1VhbG1WQnE5?=
 =?utf-8?B?UG1mMURCVVJ6RjlxK2k5TERHMHgvZC9jNlorSzRZRXpQTGtqbjBuSG1raXM3?=
 =?utf-8?B?NHBSYzdqV1VCTjkyMHRsTzVyTUdkWVBVVXk2NVg4WDdNRHJYQ255SVVrVmtK?=
 =?utf-8?B?ZnhNY2JNU3BiNkNIRkhrbzUvWktHVU95dDdTL25teGRtNkVSVXJkQU5PL1FD?=
 =?utf-8?B?ZUpiMW9jR0JDSy9RWTdIaC9Ca1FNYmFyTTF3VVVrdC9DRDh2U3A3dzlBUk5C?=
 =?utf-8?B?QjBWTGNCTnc3aDBtYmFaVGRkRFlPVXJyNEN4Q0RlZFZmUkU2dElqTCtjaGl2?=
 =?utf-8?B?bzZIOWtGbzFYQ3NIWjFFT3ExN1hCV0lYeDA0UHk3REo1SHBLcGtmYTY5anha?=
 =?utf-8?B?TWU1eHFWZTV4VHdmVWovU01LY3FuWmRXc2J0eUZxZHlHam1MOXRmQmZYcnY2?=
 =?utf-8?B?d3BZWkNZamVWcFJyOFkwczJ3VTh2UDB5S3J2aGFwdmd5MmFORG5uYzlIKzI3?=
 =?utf-8?B?UDE2Yjd2NWE2em90VFRxVUhWUk1pSDB3eDVWa25xOXcxSkxSRU1SdFljMVlR?=
 =?utf-8?Q?YDBObxfptgXT0rIIyk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880ea3cc-ed49-4d78-436c-08da4cda816f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 01:17:38.4011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bKPx0/7cdA53FQfYXw9lFepajVqkm+TQZNvNqZnvKYTalx8dFHU1DyBkNPEFDZd38HNggvkPgq1DOYhtHLncRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8346
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvOF0gaW50ZXJjb25uZWN0OiBpbXg6IGZpeCBtYXhfbm9k
ZV9pZA0KPiANCj4gSGkgUGVuZywNCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLg0KPiAN
Cj4gT24gV2VkLCBKdW4gMDEsIDIwMjIgYXQgMDU6NDE6NTFQTSArMDgwMCwgUGVuZyBGYW4gKE9T
Uykgd3JvdGU6DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4g
PiBtYXhfbm9kZV9pZCBub3QgZXF1YWwgdG8gdGhlIEFSUkFZX1NJWkUgb2Ygbm9kZSBhcnJheSwg
bmVlZCBpbmNyZWFzZQ0KPiA+IDEsIG90aGVyd2lzZSB4bGF0ZSB3aWxsIGZhaWwgZm9yIHRoZSBs
YXN0IGVudHJ5Lg0KPiA+DQo+ID4gRml4ZXM6IGYwZDgwNDg1MjVkN2QoImludGVyY29ubmVjdDog
QWRkIGlteCBjb3JlIGRyaXZlciIpDQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaW50ZXJjb25uZWN0L2lteC9pbXgu
YyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14L2lteC5j
DQo+ID4gYi9kcml2ZXJzL2ludGVyY29ubmVjdC9pbXgvaW14LmMgaW5kZXggMjQ5Y2EyNWQxZDU1
Li4zYzA3NDkzM2VkMGMNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2ludGVyY29ubmVj
dC9pbXgvaW14LmMNCj4gPiArKysgYi9kcml2ZXJzL2ludGVyY29ubmVjdC9pbXgvaW14LmMNCj4g
PiBAQCAtMjM4LDcgKzIzOCw3IEBAIGludCBpbXhfaWNjX3JlZ2lzdGVyKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYsDQo+ID4gIAlpbnQgcmV0Ow0KPiA+DQo+ID4gIAkvKiBpY2Nfb25lY2Vs
bF9kYXRhIGlzIGluZGV4ZWQgYnkgbm9kZV9pZCwgdW5saWtlIG5vZGVzIHBhcmFtICovDQo+ID4g
LQltYXhfbm9kZV9pZCA9IGdldF9tYXhfbm9kZV9pZChub2Rlcywgbm9kZXNfY291bnQpOw0KPiA+
ICsJbWF4X25vZGVfaWQgPSBnZXRfbWF4X25vZGVfaWQobm9kZXMsIG5vZGVzX2NvdW50KSArIDE7
DQo+IA0KPiBJJ2QgcmVuYW1lIHRoZSBtYXhfbm9kZV9pZCB2YXJpYWJsZSB0byBudW1fbm9kZXMs
IGFzIHdyaXRpbmcNCj4gDQo+IAltYXhfbm9kZV9pZCA9IGdldF9tYXhfbm9kZV9pZCguLi4pICsg
MTsNCj4gDQo+IGxvb2tzIHdlaXJkLg0KDQpUaGFua3MsIHdpbGwgZm9sbG93IHlvdXIgc3VnZ2Vz
dGlvbiBpbiBWMi4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gUmV2aWV3ZWQtYnk6IExhdXJl
bnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4gDQo+ID4g
IAlkYXRhID0gZGV2bV9remFsbG9jKGRldiwgc3RydWN0X3NpemUoZGF0YSwgbm9kZXMsIG1heF9u
b2RlX2lkKSwNCj4gPiAgCQkJICAgIEdGUF9LRVJORUwpOw0KPiA+ICAJaWYgKCFkYXRhKQ0KPiAN
Cj4gLS0NCj4gUmVnYXJkcywNCj4gDQo+IExhdXJlbnQgUGluY2hhcnQNCg==
