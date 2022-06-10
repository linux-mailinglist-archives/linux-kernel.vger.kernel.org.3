Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9B95459FC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 04:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346014AbiFJCMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 22:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiFJCMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 22:12:08 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10050.outbound.protection.outlook.com [40.107.1.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C513781B8;
        Thu,  9 Jun 2022 19:12:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eh28p3xpmngOlhASZAJl4z3zLZ4+qhu2LbZ5UOXkV9omFKRs9dVDDPOcMNbaFMQnJFbQ/JUfI6mx12mxSsiBwbD/No6txZ6YvRi+Mvo9pG2toAtu8XmyRdMHZH+/S4OCRAGp6hNFxu7zOVqdiOuBY1NCtCBTT7Rqf7EQc5fL9qh/OWhuNmdb6yDofI5a/Aje7gDbQL5ePCIt60mzSX3Mw5YwyTd8x+9KWBKH/ysdFzUtHH+bokEEsm9eaTPHHIjgeMc7L1U2+n6b0ws8F4tDyRBQ0GhSQ0xLine7o4BAO8H12xi0q8Iwjf3m35zF3HUwrJW64uLLzd1kqjsLJaZXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLY7GXTDemg1YiZSWbw/MHakkozs1Q5umh4bWlfUyU8=;
 b=WWsyFfUTxCek/MWeJOJ6Py2I8VnIcWO/9Nh4XRu+ljKtUsvnxMJcZ8UK6gjH69PyrijfbNksalt+P6MKZDSQXdtGPqN9jLvt4V9SSpaRdIFBuI/U+NygFsGVCc/tO2os6zGNwp3pZjqgMdk3xPwGz/UQxI1BMK5NibWBVBA3IEqpivRbeW8/tLHEh1rCpiB2dHzvjDyat3boEKk52LoDPCkYuY7MggW1ST0kT8dI5p9y3J2AQR1nkMvnSU2R4ZCEJosLHdKZpKAJQQr+aMXryiozFPJvyJevrSMKFVajXcB2V/RxvvYHz4s7N97mKQFun3FJofrkSYw9ISA/p5OoHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLY7GXTDemg1YiZSWbw/MHakkozs1Q5umh4bWlfUyU8=;
 b=brK4+21pH6ixfPRzOhsA1qCXnWRrSthmuCQtADMR3QgjT29Yn0kAUpn4feb7dQp00QZjeCg0ttUhO1iD1t/EQd4EEKdC/nEJd0V45F6UAcpIeyhldjuRZXusSv63xWtTNafI5+v4TYg5l1fyQnKtA7pz4hWOph3S18boJQbXI2Y=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8092.eurprd04.prod.outlook.com (2603:10a6:10:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 10 Jun
 2022 02:11:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.012; Fri, 10 Jun 2022
 02:11:57 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V4 4/7] soc: imx: add i.MX93 SRC power domain driver
Thread-Topic: [PATCH V4 4/7] soc: imx: add i.MX93 SRC power domain driver
Thread-Index: AQHYe/9f3ab23N1anUCiA+hsfbeUTK1HHCcAgADKfiA=
Date:   Fri, 10 Jun 2022 02:11:57 +0000
Message-ID: <DU0PR04MB9417CC0CF7F3C72374BFD9FE88A69@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
 <20220609125100.3496633-5-peng.fan@oss.nxp.com>
 <098e206c-8c52-747c-6261-e7ef96df2652@infradead.org>
In-Reply-To: <098e206c-8c52-747c-6261-e7ef96df2652@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81c688af-1f7c-4a7a-f0ee-08da4a8698b7
x-ms-traffictypediagnostic: DB9PR04MB8092:EE_
x-microsoft-antispam-prvs: <DB9PR04MB80927CE72881C66617361A4C88A69@DB9PR04MB8092.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sWxcjG0Po+iGjD9bxidWRymM4cT/t0vHGvH4QS2ClGMwHaIJNsspc7+9zst3CpcOHKt8I6TWLJ5X877/q60p4Ei5Cej7Sds4cdimpiTu1vnQrtIPBpa/Sy/QIN1g69372Loj+MLJqrAoiv07AQeg6Jcc+lCooGFydm/Widx5VLCl25FJEp+pvRZrAiZClIil4Shj8ax4cjjze+UphWtMg7EYJBXsQznH4St4beqM80tdfan7G8lSooTxyvPlZwypLAKAqH3iZO4IZ8jkGv3cAuEoEa5qHPTLAFuRCA42JaE5mW8BXTqyf4SwA5elr0L4UVg4sXMtC9LCpEq5mKz8NRHEEeYBGN6z8a9QPPIw5YLpKOyOpUo11eGD1nTR0F9Ea86ELTe2UYOkpNV3bgWlp7M6Mec3qsKTeuqM9+4IHW/EEq93AsoyyD7FWwdOuiNeWbBZSxUtZVjZ2r+AUhE4Q8quYQo3rc7JNAPrJSQh+QzQVeoJmMKbOn/lwdlq/6tKhTBd/BTiWXxW9YlELLdgmQ2jwRNcDtRubKG2JKdGqPklFWnEQUWAG6cwRTUAX17w8t3g6iTrvwmAZA+tNxO1DOLFE9FWMAdck9tVAvFaeLer/MSheHnBlWD5r3dLkz35ob8sYw9khHzUK1gJ3JifA0NYSmtd3o9Ce5L0or4DUgbOvRLgQTVbHhwevgSSDoB+nxiVSNxkRqVEm9H97Kf3SQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(53546011)(498600001)(86362001)(8936002)(64756008)(54906003)(66476007)(66556008)(66946007)(66446008)(76116006)(6506007)(38100700002)(83380400001)(110136005)(33656002)(7696005)(8676002)(52536014)(4326008)(38070700005)(55016003)(4744005)(71200400001)(186003)(122000001)(7416002)(44832011)(5660300002)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0FsM0dldEVNMDYwMk4xOUZ3Y2RIOTZDRTB5alVsekY1Zk8yMzBVcXdkSU9p?=
 =?utf-8?B?elhuNlkzdktVTWVjN2tsMllSR2xMZnRlVXBCQjM0aTQ4Szk0a211TXNpSk5z?=
 =?utf-8?B?RXVvSlliTFFSMUFVL2Y4NnhTUnI1TWowaUxxRG8wbUZhaWwrZWpBYThaZktR?=
 =?utf-8?B?VlVrRjgzczV2cGltaTk3ZXpyenVEV3hxMjFsRFJjcTBCTjRIVjFDUFJldXhP?=
 =?utf-8?B?R3phTXg2bWt3QmU3NG9QYXFTWUxvdWVNaFlzbnhkanU1VGpQQXNYblJ2NVR0?=
 =?utf-8?B?bytkMFFsZGFFMXRtTm1yQnJLOEtsWVVvTTgzQmU3Ym56S3JFYUJOUTFLdDI4?=
 =?utf-8?B?dFNsRXA1aGFMbEhJbXRjNHNzOHBlWUw5NzQzZU1zWFVxanNxZkVLSS9oOUtR?=
 =?utf-8?B?UFdwZ1ZOcXI4TE5vMDV2QlZaUC8zQjhjdCtUUGZCeXBQelFzKytDdmdNN0Zv?=
 =?utf-8?B?cTQwM1RhUE45TVo1NVk3Skk1RXlreUh2M0FrVldMOE40WFZMeFE3a1NOeWJ4?=
 =?utf-8?B?TlpVSnZDN1gxWjQzUTVEcnp4UUpuTk9veHl5RlVwWnR3Q21UaFNnb0daaFFG?=
 =?utf-8?B?SXlWTCtEL3dHZS9PQzBUZTZqN1ZUUndOZFBnSlN3a0NCSzJWeUQzblBvci9v?=
 =?utf-8?B?RDV0eWhmcTluRXlQS3JVUmM4VVpHdHd6bk85WDg2T3VMS1ZRc2d0VHpLaU44?=
 =?utf-8?B?RmswQ3ZETHBFaVB5dzhLbnlXS1FZdUF5Y2JoMElqOFUyVk9LSFZRSjR4bmFw?=
 =?utf-8?B?K2FxSmh4eGFESVN1YXAybHZNTE5aMTlRSVVQNFBtL21lOWpMUTgwSUV0K0Fk?=
 =?utf-8?B?RTh4UW56eHJDc0VLc3FVVEd2MGVERGk2L3U4bUJqNmx3a0U5Y0FtTWlRVjNn?=
 =?utf-8?B?eHhWNnVmV3crY040elNRL0dqUm80YUU1QzR0UUZUM0dlTjdIRXkzNEdjVWt6?=
 =?utf-8?B?RFExM3dBajRpcGU4UGF1Z05Dc0k1NjR0alF1bzFCa2dyYXNvNDAyNUVjWXJZ?=
 =?utf-8?B?NFI2TmR5NURobFo2Q3NjVGJjS21TOXR6S2FteFQ3M1graEplQXVTVzZ5REJi?=
 =?utf-8?B?QVpaREpCK0lWaWJtSVFUNGlIT25vQ3ZRSUVBblE0aTVnZU5LL2J2NG91OU9O?=
 =?utf-8?B?QjNGUnhoQXRHSGxQdEFaRFJoNXNTSmNGU0dLN3lMUmNhbW9PeW9IU1ZhVFFo?=
 =?utf-8?B?VHlqeHJHQVZiSDRwRCswbTJmWk8xM2hCNGZuRzNBanB4L0hYaXRxSE5VVm5Y?=
 =?utf-8?B?cWVjeFIzUlp6YldpdnpaYS84N0c3cjBDMXp3ZlljcVFtbERVQjF0d00wNjlR?=
 =?utf-8?B?cXlQWG1CT254cUR1VVowb2NneHcwWHQ5RE1VRThmdHE0V29ybElmd0JKQURm?=
 =?utf-8?B?N3BEaVFSRHVBbXN3LzFORlVxTFhoUDFEMFRxSWwycU1qRzI0UzI3Z2ZIOGdk?=
 =?utf-8?B?RkEvdUFtcXNZZThhWll6NWdwZnJXdXVWZHBJNllrYUFuREozWFBQODR5ZUV5?=
 =?utf-8?B?N3VXZlB6b3U2RXE4d1ZtbzR6YVBWei9TaVBzTjI4a3JhbUZUbmFabDdVc2g5?=
 =?utf-8?B?QTUyYldZNk96dnBTMkxxNVppOS9wdkxOc0dmT3pVdGczTHRsSGVTN3VtWUdw?=
 =?utf-8?B?bldQemE0dzNwOUt3UFArbWJFK0k0SVlLWVhoVkNBUWN5QzN6aWhRdU41TlB6?=
 =?utf-8?B?bm1GYTEvcVArWFpkeTZqeDEvMHFsSE95ZnR6R2U4UzRJTUtVUmkwck1LS3Zn?=
 =?utf-8?B?RHhoc1hNQko0Z3NaclU0eTZnVjdUR0FteGN5cWd4YWUwbkVmU1JOMjluc2Iw?=
 =?utf-8?B?QVNxRm0xMm5kdDNkakFab1QxOGhzYVlJUEwrNVZudWRCRWJ5VExKMzRld0JR?=
 =?utf-8?B?RkYvbFZRMUZDUHBiWnpEMUxURk9xc05tTVhscGxCWkNlY2tPaW5wMm5xS2tm?=
 =?utf-8?B?R3dmKzRuaEdIS1I2YW8vZ1IxZm5QMTQxVEYzU1Aza2xrUGZBaW9oTmw3WTdX?=
 =?utf-8?B?VFVNM0dpTldZMFA2SUh4QmNRSkhQWHFIQ0JZaGUxNXF2dnFyeUJLRUkySnpJ?=
 =?utf-8?B?RFkyTiszK0U5TjlmY0lNbDZPR0pqSG1BdVpETHJMcU1kT2k5OVVFZ1MvcDVj?=
 =?utf-8?B?MlhvUWhpNERrSUMzUWRYYXZ2cWMwZmtKK2dUeHlUejVxQnVFRmI2NXg2WTF2?=
 =?utf-8?B?d0RoYXplbGRFMlRZdjRMbXI0R0EwMmZJaVN1QmVQcHNYQ1dyeVdoUktxQWFO?=
 =?utf-8?B?T3hacUhqTkRxKzBsVTB6UlYyN3pPOVBjV3lJaTJlZHhkdjljbm5DMDVBNEpt?=
 =?utf-8?B?WHQxbFQwWkRBMXAxVWt5cUMxQ0xFalJTNXIxWmh6d0RDUm0xZFBYdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c688af-1f7c-4a7a-f0ee-08da4a8698b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 02:11:57.4298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPgapXs681DAwsEI88yVrdGtjuonVitCDZKHVs5Cv+Sg1SSclhWb3JPobWjshkc7KA2lLungxuPq1/FlWrAaDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8092
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDQvN10gc29jOiBpbXg6IGFkZCBpLk1YOTMgU1JDIHBv
d2VyIGRvbWFpbiBkcml2ZXINCj4gDQo+IA0KPiANCj4gT24gNi85LzIyIDA1OjUwLCBQZW5nIEZh
biAoT1NTKSB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvaW14L0tjb25maWcg
Yi9kcml2ZXJzL3NvYy9pbXgvS2NvbmZpZyBpbmRleA0KPiA+IGE4NDA0OTRlODQ5YS4uNWJmYzFk
ZmVhMjhiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL2lteC9LY29uZmlnDQo+ID4gKysr
IGIvZHJpdmVycy9zb2MvaW14L0tjb25maWcNCj4gPiBAQCAtMjAsNCArMjAsMTQgQEAgY29uZmln
IFNPQ19JTVg4TQ0KPiA+ICAJICBzdXBwb3J0LCBpdCB3aWxsIHByb3ZpZGUgdGhlIFNvQyBpbmZv
IGxpa2UgU29DIGZhbWlseSwNCj4gPiAgCSAgSUQgYW5kIHJldmlzaW9uIGV0Yy4NCj4gPg0KPiA+
ICtjb25maWcgU09DX0lNWDkNCj4gPiArCXRyaXN0YXRlICJpLk1YOSBTb0MgZmFtaWx5IHN1cHBv
cnQiDQo+ID4gKwlkZXBlbmRzIG9uIEFSQ0hfTVhDIHx8IENPTVBJTEVfVEVTVA0KPiA+ICsJZGVm
YXVsdCBBUkNIX01YQyAmJiBBUk02NA0KPiA+ICsJc2VsZWN0IFNPQ19CVVMNCj4gPiArCXNlbGVj
dCBQTV9HRU5FUklDX0RPTUFJTlMNCj4gPiArCWhlbHANCj4gPiArCSAgSWYgeW91IHNheSB5ZXMg
aGVyZSB5b3UgZ2V0IHN1cHBvcnQgZm9yIHRoZSBOWFAgaS5NWDkgZmFtaWx5DQo+ID4gKwkgIHN1
cHBvcnQuDQo+IA0KPiBPbmUgdG9vIG1hbnkgInN1cHBvcnQiLiBNYXliZToNCj4gDQo+ID4gKwlo
ZWxwDQo+ID4gKwkgIElmIHlvdSBzYXkgeWVzIGhlcmUgeW91IGdldCBzdXBwb3J0IGZvciB0aGUg
TlhQIGkuTVg5IFNvQyBmYW1pbHkuDQoNClN1cmUsIHVwZGF0ZSBpbiBWNSBhZnRlciBjb2xsZWN0
IG1vcmUgY29tbWVudHMgb24gdGhpcyBwYXRjaHNldC4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiAN
Cj4gDQo+IA0KPiAtLQ0KPiB+UmFuZHkNCg==
