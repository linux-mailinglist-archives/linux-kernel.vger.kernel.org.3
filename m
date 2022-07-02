Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FB0564027
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 14:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiGBMwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 08:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGBMwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 08:52:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EF4D120;
        Sat,  2 Jul 2022 05:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9v9Vh9kv0PvhBEgut7qrkpgheQmhowzaIFloMThQee9712yMMYNwHdXENrZv59k4xaY8tmxAtNEYAz5w20ND8nBUWiXtC3Cmtivf5oBh7iB4N6mDHGHG/+5hF3Hljaxyyp4Tn/Yck3Qz+/WUMoDqHdl1OtWeaMtyd+uYJ45oBrtbi+fDQKuZToqE2A5W6tbb5jgmQPshWb0/x5szzgs58rd1TYTUW+x45clkaO6h8jx0ISzFQRU3OBj8AMbkgSqYcK1Fy2Vj+qpg55i17SbzwqgUA4nIJTDSZX5RwY0hCDbx1GjDYbxjjA3ZIQWXiA5E2wApCu0D8UBUJwanNeghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fq3w91uK6WQ2Bv4RAZk8XZAovW2rgZ66nJkmQbLlsGw=;
 b=HYTM5wbgqxcF4WUhFMNZGsSC3BI4t6MOom6GHVIiGj+REierCu4gV6Dm1IT5CVJJbNaYVU+Gp3f5kb0arT89QgzBxdJUVDmxkdaaOHhZMNo4fIPJJGNVMTT8gTWpuCojIG9Z0zyRoLouaEoawSympw9ncTSS6rmAc3KVhY+0MVdP/awp0sO82gVARs7xMh/eqpgqx1J5PL0fczsHS7SoYsVJZ8VEf5UNJSS+cB9VddFSjroO8JzvmftOfmRhOhkNcqaX/6aVNv8R12CHrVIB/Izf7mm9nc91wY5iLa3vqeIDwpfLUVpqUoNu1aZDRcng7blrFMcdQlOPOGc0P4QzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq3w91uK6WQ2Bv4RAZk8XZAovW2rgZ66nJkmQbLlsGw=;
 b=oLENQlZFBWMurkC4D2ells1GvVC9iDiFZcq07ll1CcnJ8sKPUokXd94WSxlnI1w6gQDJ/p84a6F3jj3FWNxmxv/J6sUHsXLzNmCBM87sQhXCWlLxtBVocg/88E1Wp6zXjtd9k7tf9yioG781x1FZ1P5c6t8xHyzKDumoDhbu+OU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8421.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Sat, 2 Jul
 2022 12:52:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5395.015; Sat, 2 Jul 2022
 12:52:43 +0000
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
Subject: RE: [PATCH 6/8] arm64: dts: imx8mp: add NoC node
Thread-Topic: [PATCH 6/8] arm64: dts: imx8mp: add NoC node
Thread-Index: AQHYdZwxphjiVZgCMka25x/NWcSgjK1mrLiAgASNHVA=
Date:   Sat, 2 Jul 2022 12:52:43 +0000
Message-ID: <DU0PR04MB941746537FC4AFD9EB7B5CFA88BC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
         <20220601094537.3390127-7-peng.fan@oss.nxp.com>
 <245b25cc8f512e7a724a3b8cf4526d99708c8e83.camel@pengutronix.de>
In-Reply-To: <245b25cc8f512e7a724a3b8cf4526d99708c8e83.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c27abf4-f046-4167-98c0-08da5c29c199
x-ms-traffictypediagnostic: AM9PR04MB8421:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ME3vmU+GnS+v8t1ob5oApzBLnvO0iB2lsUDX/YQ15kQ4pKkM43pB7RYYR6N1qEhok48UxLHvXW1yqIdVnYmWu/FlIABEkQcdjsz8qgWvA1aHDGb5b0Be1kyeCuqzz4AiDoEvK04EYE189vYZqRsL64cqOu9UC9pN7KRvccpwPCpThPxdwvZ9WBRmUw43L0byLmPpbh7U9HSIxw8D8U+jGfqEQ3ynQZSdEMBCTg1v8w1pC/pv4p7TF9centoOqAFEmKbNv8I8UBrDSgx9O70BM+/u2U5rptudqlkv4SyZV7algZuZnSljbsldFtYZ+sbqgYX6xwx5X+xMudi46/sfxusG4s1OR6UmUWHPBmxs3WKoCvlKqIU3mmA1ljJxmg/mjeKmiPx6MREERIYC7UXKgx9AZDAkgb8MavNyfWl67Q14nRh2nnCBXhaMUskjK8X47gFE0I/e8WGYF7UAArvj6oYiF1crWT0fdEh4T6a/KcFl70FtVAjvUui7qvHveL+YgKtsiUQWNI10P3Znx7kdTVm+4kdMFTcw/zoidyg2pEHNGHBNtW9li87FQVCiSEjuT6pnSwFMyecmaSHqfArdBL1Y0XZ4izoIU23CHAWOVE/bInBo/zaE7g2idqTv3UIX8PmhfK4yLEevOTodNQMbxwdVUO23nkdLob9/9ss7+pE7qVuUECDGLwjY/SJRTNM6FcRdQPszy+3NCh3DVFygAHpCJQ0RVMMUuFYdpxGuoBLJNjEuzDr3MKahhzbn04TXrcbcYH3VnSoqRqr8FA2JA8XRjKs9VieVLXqDQscZJ9aOQey99sF5n8Iq9XOjZPohRxwKVBaifAfQ5HIuqY4rGVSt4wXnkQHhHDWr9x6KdNE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(4326008)(316002)(8676002)(64756008)(76116006)(66446008)(66476007)(66556008)(66946007)(478600001)(41300700001)(54906003)(110136005)(71200400001)(6506007)(55016003)(52536014)(8936002)(2906002)(5660300002)(7416002)(44832011)(7696005)(38100700002)(33656002)(86362001)(921005)(122000001)(38070700005)(186003)(9686003)(26005)(83380400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2o0SFhHbEFvNnJBTHpnM1NBVWI5OFRCcnc4NzMrQkxaekl4c2JWOCtNV1lj?=
 =?utf-8?B?d1JESlVWbWo3K0VRUUNEZnRGTnE5bE9NMlg5VS9SNXJsa3BTMnJoZmkvK2s2?=
 =?utf-8?B?LzNMV1hJTU5tOXN5OVdjODdjT1dRMXJDTEZJYlc5V3VUbHAyanlIQXpBNnVQ?=
 =?utf-8?B?ZjAzNzlyNWNldGVVOTNUbmRwM0Vjb0NIbjNRN1pGb3VKeDB2NHFWbXY5eU5E?=
 =?utf-8?B?elRDSEdvY1Y1czVpSmxyQldhYU9zbHY5cVlBU1NYM0FtYys5b2NIaW1HM3kw?=
 =?utf-8?B?akdzSkdodkZkdHRJaG8rQnVjNDNmY1o1K25MUmtPRUExandISWs3NWowWG1Q?=
 =?utf-8?B?Q2tvYzNHNUJ4dUh6ZlFVd1NBNzFlVEZmanpydXI5NFNCQytaeFB0endFSlVW?=
 =?utf-8?B?S3RhRkl5aENoTFNjc0sxNW1ZVnBxY3NrL2ltU2RBUUJtNitxclRsRExjRi9O?=
 =?utf-8?B?eXJ3NDBZY0prdHk1OWl0TkhZUXhKU1hCclpiN1pnN2xXS1RHc1RDQWZQcnJO?=
 =?utf-8?B?Q3NhS2Z4VTBkR1hnbGNIaSsxQktMSUJvd0E1UmkzNjBxUnJXOEJNZzk2U2ti?=
 =?utf-8?B?K2ZLNlNlR2NVakdIclJuWnhEZ0xFUWdLbVYyUWpzeWpVOXhxbFpvWVR2Ujh5?=
 =?utf-8?B?aFRtZ2hySWFlejZsSnVQRXFGNmgvUHRuUXI4UktOdXE5TEhkeGk2cTFiVjE2?=
 =?utf-8?B?MldhNkEzc1lsQ25hMmlDR1pwOWo4RmJ6SUc0M29jOENyUU5wejNNRWV5ZVZo?=
 =?utf-8?B?ampTR3FmeUZUZVhYZzNCeHJwbENJaVRyQ215SDZxMTNkVkNQUlNqSDBUSnRy?=
 =?utf-8?B?R3ozdXRjYUNuRFNrTmlOMHpqZWZVZk1jQ0MzYmU1THJFQ3JxdDU0dTBubk1q?=
 =?utf-8?B?c0duRC90bjIyQVJ4YVdCUmY0d09GRzVkYWg0MFJZaG9ZSzlkc1ZidFFTYTZM?=
 =?utf-8?B?Y3pia1oyYUorWUdqbHNuUGluT25qOGFTSWdRMHRFK1VJVllzcjdTbkFhd0Zl?=
 =?utf-8?B?Um9sTE55eWJuL1FDTU1BWWpsSWtRcmg0ZFV4UWNKQmJWNHkrckV6bW1kSUhR?=
 =?utf-8?B?d3BvTW1qNUwwTTNDQzNnZ24wd3Y0RkxLZU5XNjVkaUpLb1BXbVZweG5QVjl3?=
 =?utf-8?B?UExvVEZVaHpoS1o3M0MvVmw1OXRZYUsxSVd6cDBDWkZ4aHNKRUphZ0VlZE0x?=
 =?utf-8?B?QTY1K0UyZm5OZEJSeWpzbUl5Y0x4aG1yU1ZrQlQ4bUtLWDlzZWZnOEI1TUVv?=
 =?utf-8?B?VEoxdlNVdzZHVkRpL3VST0hPcmt5UmVYSjY2aGQrNzYyWGZLQk1jbENxSjB4?=
 =?utf-8?B?dmJ0T3ZuZzEwdTdJci80SzVZUUFZSHg1bVNvZ2hqNmtYdGY2S0VsSUs0dnpL?=
 =?utf-8?B?VmdhNW5VdjA3SlFYT3Rtb3c3Y09ScWJoYm9SS0ZLOWJaU3BlRno2VGRqMDlS?=
 =?utf-8?B?QnZFSkpXM3FWOUg4Y3p3RWFWM083dEdHeWwxT3l0eTliUzI0WEZWcmViL05s?=
 =?utf-8?B?Uk91aC9BTHpuTXMxTVdOZllkclJZakZzOHJnb1M5THk4UzVWdDlZTVhCUnBO?=
 =?utf-8?B?ckMxZDduaXRsVmh3a3l2OGhuZytuTkFmTkpCZ3AwcVJqUlJtaVQ1bVlHVGpK?=
 =?utf-8?B?Z3QvWVkzQUJSL25ZTkVhZnhNQldZOTA1bTRVTUxVTHhUVk9kNDF5ZFRjWlNa?=
 =?utf-8?B?c0pLTlhpdFduUkRqa2UvYXZ6NHlNSTFBNEtVb1NkWTlWWVl1eVJDNW5BTXNO?=
 =?utf-8?B?S2JPNVN0RjJ6RVRCREpSTHV3QSs0UUVBK0Z2SHJZRzA1NFRWemd0RlV5d1RM?=
 =?utf-8?B?eW1aNGhyeDNiZUJxRHlycDMxMzRzS2FkY2NobWpZZTM4M0d2WTdYRHJxL1M2?=
 =?utf-8?B?MGM1M3E5NCtoZEFtWVZmSXNCb3ZSUlYzSmlaYkhJUDUzenlQZ2d2aDc1Q3Ry?=
 =?utf-8?B?NzZmSnlQQjYyT3JjNDg2QjNIV05rbi9DVTdJMGtuRHJld3RuNHk1VmZCK1Ew?=
 =?utf-8?B?SzFTREVpVlAyZGtQbit0NmdtYnJkNmRNRHdkaTFRRGhOWDd5SWhIRWdtRGFU?=
 =?utf-8?B?MmtiQUlIRTBGa01MOFNtVUtraXJnOTVMbmJ6dHNCN2llRUF1YUtqd0xWWVAx?=
 =?utf-8?Q?fqCQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c27abf4-f046-4167-98c0-08da5c29c199
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2022 12:52:43.7204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UifN9iYgGN/mHhnyX321XXQxmwmRgs6rEIfJ32CDVQGSeVFD+w2v5zDqRPetPhr8FcXMtyAz+8wc9vX/l67DiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8421
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDYvOF0gYXJtNjQ6IGR0czogaW14OG1wOiBhZGQgTm9DIG5v
ZGUNCj4gDQo+IEFtIE1pdHR3b2NoLCBkZW0gMDEuMDYuMjAyMiB1bSAxNzo0NSArMDgwMCBzY2hy
aWViIFBlbmcgRmFuIChPU1MpOg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29t
Pg0KPiA+DQo+ID4gQWRkIGkuTVg4TVAgTm9DIG5vZGUNCj4gDQo+IFBsZWFzZSBtb3ZlIHRoaXMg
cGF0Y2ggaW50byB0aGUgImludGVyY29ubmVjdDogc3VwcG9ydCBpLk1YOE1QIiBzZXJpZXMgYW5k
DQo+IGFkZCBhIGJpdCBtb3JlIGluZm8gdG8gdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpZZXMuIFN1
cmUuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEx1Y2FzDQo+IA0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0t
DQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpIHwgMjENCj4g
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1wLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5k
dHNpDQo+ID4gaW5kZXggMmExYzZmZjM3ZTAzLi45ZTllOTQxYTg5MDYgMTAwNjQ0DQo+ID4gLS0t
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kNCj4gPiArKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+IEBAIC0xMDE5LDYg
KzEwMTksMjcgQEAgZXFvczogZXRoZXJuZXRAMzBiZjAwMDAgew0KPiA+ICAJCQl9Ow0KPiA+ICAJ
CX07DQo+ID4NCj4gPiArCQlub2M6IGludGVyY29ubmVjdEAzMjcwMDAwMCB7DQo+ID4gKwkJCWNv
bXBhdGlibGUgPSAiZnNsLGlteDhtcC1ub2MiLCAiZnNsLGlteDhtLW5vYyIsDQo+ICJzeXNjb24i
Ow0KPiA+ICsJCQlyZWcgPSA8MHgzMjcwMDAwMCAweDEwMDAwMD47DQo+ID4gKwkJCWNsb2NrcyA9
IDwmY2xrIElNWDhNUF9DTEtfTk9DPjsNCj4gPiArCQkJI2ludGVyY29ubmVjdC1jZWxscyA9IDwx
PjsNCj4gPiArDQo+ID4gKwkJCW9wZXJhdGluZy1wb2ludHMtdjIgPSA8Jm5vY19vcHBfdGFibGU+
Ow0KPiA+ICsNCj4gPiArCQkJbm9jX29wcF90YWJsZTogb3BwLXRhYmxlIHsNCj4gPiArCQkJCWNv
bXBhdGlibGUgPSAib3BlcmF0aW5nLXBvaW50cy12MiI7DQo+ID4gKw0KPiA+ICsJCQkJb3BwLTIw
ME0gew0KPiA+ICsJCQkJCW9wcC1oeiA9IC9iaXRzLyA2NCA8MjAwMDAwMDAwPjsNCj4gPiArCQkJ
CX07DQo+ID4gKw0KPiA+ICsJCQkJb3BwLTEwMDBNIHsNCj4gPiArCQkJCQlvcHAtaHogPSAvYml0
cy8gNjQgPDEwMDAwMDAwMDA+Ow0KPiA+ICsJCQkJfTsNCj4gPiArCQkJfTsNCj4gPiArCQl9Ow0K
PiA+ICsNCj4gPiAgCQlhaXBzNDogYnVzQDMyYzAwMDAwIHsNCj4gPiAgCQkJY29tcGF0aWJsZSA9
ICJmc2wsYWlwcy1idXMiLCAic2ltcGxlLWJ1cyI7DQo+ID4gIAkJCXJlZyA9IDwweDMyYzAwMDAw
IDB4NDAwMDAwPjsNCj4gDQoNCg==
