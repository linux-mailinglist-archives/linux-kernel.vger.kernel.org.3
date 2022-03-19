Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C014DE75D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 10:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbiCSJye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 05:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbiCSJyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 05:54:31 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F0510A;
        Sat, 19 Mar 2022 02:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsrtKrzu/elki0JFkqBc2dADsOEQ3W6u6eHGSV4PjMUCtOJjrfVXkBh1u6KTdL+yaOP1G5UemJKx7ZcYubM9v3DTk/g/H/THmgCPIC0s7kOKLnJcDX51ViRHthe2igUqmWd79N75XGliWS8TzNBhZXPyq3TSAToRHoLTHZPCA9g5LfN6xME6G/14Qr6yUNpFUN80np5JMhhf/HPfEwsPWO7QmbNkpJe8WrrnrL8/Ulci7STKEaz6rU9jL39DEb2RoEbaS2bWPggTdhqQJugPeEIwficpW/NliEXpFGtwr+iSR1sWqhpGh1ptcQr8QeX2hYw/Ye7ipvOAJqNNSLZHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwecwxlqC/BQZ9uBsctrNP2hwwBG6ogE//EzKf/ynQg=;
 b=LGZpRBytf932T3BKIMJ47s+KHf+LGR+1fzWxRwNcVAr9eGToX3eu7nvNdeJ7pNWGudzQ0Nj0o2SEnRCaDFAFvPFe5Owi08CQzBApLR5v8wMX5oiVbuTwn0KN4A+0bnlPL9OW7HQWvEVVM1+WLoxv4bsLd7eGeYg3NMsO64pkasrfGqFIFTUip17ycZFgI6Di70+7e9k60d4KPxCColmBDdf8XKjW5cJl2FW3Q5TDf+3n9xUI2HHGUZ0BEvpnBzbFTCBY19VDQ0eHnQGIPFX1ebKCm6E0fpzr8aSxRyxnx01BW8FrKmOPIb9l3iCQuseBYg305GZeCU5rOG3EIc6Mzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwecwxlqC/BQZ9uBsctrNP2hwwBG6ogE//EzKf/ynQg=;
 b=eB4LiDpGRVPy9zyasMPgeqwhj8Wj6rtdkjjSpevRjl9IYaUIajebA/6GrlpU8QvHZfPmqgTG8lD6bSejUS9MHr3WdK9bWUMNDOngz8EAX0EEl3ZnqfUMJplvVTJl+Cx/MW2PDrMPzAxwFxw4d2xnTbqFW7XC2Y8GjZQFiLimXw8=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VI1PR04MB6112.eurprd04.prod.outlook.com (2603:10a6:803:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Sat, 19 Mar
 2022 09:53:05 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557%5]) with mapi id 15.20.5081.019; Sat, 19 Mar 2022
 09:53:05 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] arm64: dts: imx8mp: add ddr controller node to support
 EDAC on imx8mp
Thread-Topic: [PATCH] arm64: dts: imx8mp: add ddr controller node to support
 EDAC on imx8mp
Thread-Index: AQHYOryzxNFxs/LqK0CcYowyV5hw8qzFDdcAgAFozCA=
Date:   Sat, 19 Mar 2022 09:53:05 +0000
Message-ID: <AS8PR04MB8404817B9ECE889A19A2186692149@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220318113526.15986-1-sherry.sun@nxp.com>
 <57e516d4-68aa-44a6-4ea2-a7fdd4d9ed95@kernel.org>
In-Reply-To: <57e516d4-68aa-44a6-4ea2-a7fdd4d9ed95@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7500792e-4633-41f3-bc66-08da098e43c8
x-ms-traffictypediagnostic: VI1PR04MB6112:EE_
x-microsoft-antispam-prvs: <VI1PR04MB6112FD95CA61E22D6CF809F692149@VI1PR04MB6112.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +qYouPC8OuKfX/mHcpDj4iYP/IbsZd93zmVAjrA/gSFMi75+5LwmxIe2bRYlhJGi2mW+fyubkyVJN1J79ziBVmk+75y0gTKs4e3zkpoUiTEpc2c29fDZ9ceFiwmRudAcRncb6rQEVlGqVBM8W3JbvDrzJhbAYZy7Aur6cyWsVtSc2Zw21Bs1KEaw8waRjnmGlr7Lta3Ea3PTSNY2quCPUJFH+3JGPyKfVpI5kJoGe1XhARojDhhPNMH+mFjABuysLhXNWfRHkbebmXyUQUrRgu4YlUy9hvfyzKg5oqkxE4XfNEzjvE9QavL6JT1mDE4+iEg6leVS/6heG5sZEtD+/t4L/xQiV1lqF2QQbVRiQ0ivyCX4aTYwEzRkyLzVWX6WigmNGi+IgCKbyOXiOpXUUwH8tAh2SiJQSSNgacT4TorL719MEYVcdh5NNX/QW+8YqbItm4hzhCoIMVUSoodX/dkO+PnRVe6TZ3P/oLelKyjjm3rRgo2pXWb8C5b1POKdiqpp0d1Wdws+63LlfiSWgUwflwlyuoi63JXBJ0eP3Fro3T0jwd3x03xJxyJw1cPigIwcjprz69ZVE4yzgM7jWthzFIiQGIBrQkL8OtHUGxBYq5fJwsZxR5Go+cZoDoVb5bg5wR0RFq71SSLk6Et6P7JfdIAWJAHHlx/Vrl6gz2EcDlKQ7nkKq2LulRcYM7SGNaRSn9QajwwN6MnXUXUK7n2SSspcdZQ/73y/8CrIGSM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(53546011)(4744005)(2906002)(6506007)(122000001)(7696005)(55016003)(110136005)(54906003)(8676002)(86362001)(4326008)(38070700005)(9686003)(76116006)(316002)(66556008)(66476007)(66446008)(64756008)(52536014)(5660300002)(44832011)(66946007)(71200400001)(508600001)(38100700002)(186003)(26005)(33656002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW1TOGxyc1ZtWnBWZjZtVTZhRmY1UFozTnRnaE52dWlFUlZxdG1aek4zVkh4?=
 =?utf-8?B?dW9sNG5lSnVkQUNQanJXSVZJajcwZzllZytKQW9xME9zTjVxYm5EUmZsTzIv?=
 =?utf-8?B?RDFmWUpKemJXeGhZTnlsbGVpbDg4WEpuZFFPZGFucVBpV2V1ZHVBNTJqR2Za?=
 =?utf-8?B?dzZkKzdsc1FKZitqNW5USExuRGgrU0lDNStPbTBoazhZNVFpQ0FZUkY3ckpn?=
 =?utf-8?B?aXZxTG1oSVNTWEUzUXNCc1dxaS9abWRCN0dsbXFhdFBKeWVOQ1BZZnh4Nlc0?=
 =?utf-8?B?OWh6cU1wbXovbFY2OTRGMDJEOW1aeVdsbTFNSi9VdHBpQy9yajAzZDUrdVd6?=
 =?utf-8?B?S2FWQ2dzclFkcUVwN3ROcEJRVnJqK2ZnUWtmMVBTRVI1SUU5SGlvaDBkQm9I?=
 =?utf-8?B?OWJTOGFpTjBzVGhnNDBOZEMxbit6dHlxVUtKNVR0Z2toeGVnQUpJcnpFdk4z?=
 =?utf-8?B?eWh3MW9DazNBL0tPYzB2L09Jbm1DMU11RDgyQ25oUCtlUTRLeE5CellrRGhS?=
 =?utf-8?B?RG5DMmlFYVZRdU5RdXVxZ2lLV280L2FjMlc0Z2FyS2l5SFNuT05MMG0wMFN0?=
 =?utf-8?B?WHdpb2JzTkJYZGpBNktkZXpRVzNKYWJNU20xK0diRW9YRmhxM0pYSm1wRnVU?=
 =?utf-8?B?bWk2K0hxSlQxbjZuMTg3bHFBRm9kOUFjUHI3REp5KzZYV0JjMXZZdkFoNSsx?=
 =?utf-8?B?L2FFVWtuYkRrMVpOMGVic0hsbGdFblQzRlJLaVkwdXVtMUVzdmtRNy9XNUxN?=
 =?utf-8?B?b0VXL2R4TFpydWZZUENrRk1OMWVEK0dWMFNselZ1dkdYT3RFTUdJN0RieHJa?=
 =?utf-8?B?SU4zbDRhRVVCVkZBVDNSZXJBQVAvZmYxYXFpQTFZMnpaOW5ZcGlLL012Z0dV?=
 =?utf-8?B?QXRkM0xEUDRadFQyaVN0d1JteStvMUxpcmgxeVVmdHA1YnpZVHJIOGQraUZR?=
 =?utf-8?B?eEp2Ry9TMTEyYzR1bWJlN0U0QnFvRXJqQnR6b2JmQWV2UE5idjBFOG5mR0FC?=
 =?utf-8?B?dnZab0JNcWVpVm9KYld4TDA3QVREUFhnZFQ5RDYvd0dsSHRvY2VsbHpsS2Yv?=
 =?utf-8?B?eWhVcStFdE5QRGl3N0JDUnFabDFnenhQaktLVjdUMUIzQ2RTU1k5dTZYektP?=
 =?utf-8?B?L2lSOVByMmNaNHpLVzlGVHAvT3NyRkE5ZzdNUmNRekozbUFoSE8zMHRSWnJl?=
 =?utf-8?B?b3AwQnFLTnR1NUNEVjdkMjkybjNFbTVXVEU2WVdhTm14TTBiNHB4NVZiMDFD?=
 =?utf-8?B?R2w4THlsVmxKOG1OY01RWktRQWcwTklFOTVpLy82b3AyUGJjM0trYlFVMjJu?=
 =?utf-8?B?KzI2VVBmWUUzYnFTSCtwdnFNeFkySUFneFcvQWlTOC9wYmwwOG1URzNuaGli?=
 =?utf-8?B?RVpBME5XY2VLbHNLaEFJb04waEdIUzNwUllVazJZcFAvUmVjNUZiMWlnRE5i?=
 =?utf-8?B?c3NSQktpNC8reUpRV09HK1k0ZGh0Wm1JT1daRE1xSkhrbDlteEhnb21FY2kz?=
 =?utf-8?B?Q2VHR0FnSWN3YjNuOWhwS3luSFNZWjE3TDBmUWhkU1c1ako3QTdaNThqeDkw?=
 =?utf-8?B?dGZ2d0g3UFptdWw3Tm5kaUVWanRRc2ZLdjlsbGRDSXRiR3Q1Y3BHN2diT2V3?=
 =?utf-8?B?WVdRMkNVQmNrUURUekgyMHNmYm9qUlpiUEtCeGpsZk51TG0xOTBPUGhXOTlX?=
 =?utf-8?B?OHZFcFJhTW9LK0RjZzl6ME92TmJHYXBNMllvMkVsdG9mN0FxZmEyblBNb2Vw?=
 =?utf-8?B?ejlXc2lHUXlLd1BkOXdsOWlnWEtiV0hCNnBUUG1ZMkd1ZHRzSWhybVhmOUpn?=
 =?utf-8?B?ZHBhMVh4RzN5TEFrOG1obXFTOFI4QnI3STZDeUhJQmhpdUtzRFVKRHVoRStS?=
 =?utf-8?B?ZEUyOU1FRllPdlhnaHNPOHpWM0QrMSttWFZBM25ZeXRCaVBta01mbVRwRmlC?=
 =?utf-8?Q?HFjp2RjAXQc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7500792e-4633-41f3-bc66-08da098e43c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2022 09:53:05.2956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b4RXO9tccTL19jMscs7NDsGPWQbMRTnRcxvat2Kc8PwUDTrDyWyrsMWHHJgzmeHdM/KXbI63nZrPiMKltfTyCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGFybTY0OiBkdHM6IGlteDht
cDogYWRkIGRkciBjb250cm9sbGVyIG5vZGUgdG8gc3VwcG9ydA0KPiBFREFDIG9uIGlteDhtcA0K
PiANCj4gT24gMTgvMDMvMjAyMiAxMjozNSwgU2hlcnJ5IFN1biB3cm90ZToNCj4gPiBpLk1YOE1Q
IHVzZSBzeW5vcHN5cyBWMy43MGEgZGRyIGNvbnRyb2xsZXIgSVAsIHNvIGFkZCBlZGFjIHN1cHBv
cnQgZm9yDQo+ID4gaS5NWDhNUCBiYXNlZCBvbiAic25wcyxkZHJjLTMuODBhIiBzeW5vcHN5cyBl
ZGFjIGRyaXZlci4NCj4gDQo+IE9uZSBtb3JlIHBvaW50IC0gSSB0aGluayBpdCBtaWdodCBiZSB3
b3J0aCB0byBhZGQgZGVkaWNhdGVkIGNvbXBhdGlibGUgZm9yDQo+IHYzLjcwLCBhcyBpdCBpcyBj
bGVhcmx5IGEgZGlmZmVyZW50IHZlcnNpb24gKHdpdGggZmFsbGJhY2sgdG8gdjMuODBhKS4NCg0K
VGhhbmtzIGZvciB0aGUgcmV2aWV3LCBJIGhhdmUgY2hlY2sgdGhlIFYzLjcwYSBhbmQgVjMuODBh
IFN5bm9wc3lzIGRkciBjb250cm9sbGVyIGRhdGFib29rLCB0aGVyZSBpcyBubyBkaWZmZXJlbmNl
IGZvciB0aGUgaW5saW5lIEVDQyBwYXJ0Lg0KU28gZG8geW91IHRoaW5rIHdlIHN0aWxsIG5lZWQg
dG8gYWRkIGEgbmV3IGNvbXBhdGlibGUgZm9yIFYzLjcwYSBldmVuIHRoZSBFREFDIGRyaXZlciBv
cGVyYXRpb24gaXMgdG90YWxseSBzYW1lIHdpdGggVjMuODBhPw0KDQpCZXN0IHJlZ2FyZHMNClNo
ZXJyeQ0KDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
