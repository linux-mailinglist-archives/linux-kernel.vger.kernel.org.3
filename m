Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F032357AC89
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 03:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241407AbiGTBWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 21:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241752AbiGTBWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:22:18 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80053.outbound.protection.outlook.com [40.107.8.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B496A9DD;
        Tue, 19 Jul 2022 18:16:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNcc3VOHT90XU80gD+9XZwynPcpXrGAgaW1WtWe6rY+UB8rvpI1JDZ/TRbxzr1SZ6/C11g6dcoAPNk0OkI09ayEPWcGPorwCwFc17HtvHOw9vO8Jj81j10T5Cv/IFaCGj+iUEg8hb7vv3bEPinohPZjcAUA2i1lk0vQldFVmct+UCdxaaLxDTgPEVpObKXzTuV3a9sPbZdCLKmpqNAZ1m7iDRGSn/QS97jEzMeT5wcxvZo/XRLlGO3EaCCjouLdgxXG1tx8iCCP3Oz8J+ngOPFHDq4cW8sVApje7lS76rubVBnY1amPuZsi1dHT5ADsolg1YIn3L9C3tzLhEuDTMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbgBK/+YhlknF7iIknRBuvT6BNlUg53gP3DZOvoqWc0=;
 b=ogASBfeO2uwLXq9lA2QTGDKQuUjHo3aRsfhFHYcWJApqMvj36DZzRiXEDg+WZz3lDXD4ypTQ0bTbBwgzQcjJFeb9+6pLLo1wNI9cQTDAvH8Ok4CJCag6izjXy4Ut8w7orZ3VVEOnKXtN0N4vZc3xIzWlKTy5Vw8WGGFieOsjlBUoFrjSCXXZ9lTBV4qQXCaOcmeZi2lnlsSpIpoAyzPPTrsPqIH/8XNYFzmSjKsEOQpjxz7Vlz2IxBzOKuASCyRJNxIZKJAn6gJ2treKVIV6hNTdFKalDrcCnyAS3GKLAOsmiV5x1EWwMa/jHnylG/2OD890B6/Q4dBVQRjxUhntzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbgBK/+YhlknF7iIknRBuvT6BNlUg53gP3DZOvoqWc0=;
 b=C1jHsWWNXcGbND+VjOWEEFc2SuMdLXm11C9JfuNXr/XKRy1UHm/Yg50YnR4MfGN8cMY/LvKNdNj4kvasEmvDppOAt+agD3tIMcen9ZJcvv+akEFQ0QY5EiHPL/sCi5gQMQK3U/M2uJh77UXdhV8ru0uSRsrTYf01e1WQ1FRFIkk=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS4PR04MB9388.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 01:16:46 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f%9]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 01:16:45 +0000
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
Thread-Index: AQHXmxHjjWw2/K3ZFEmbAw0FMtAtxK2H/LSAgAB4S8A=
Date:   Wed, 20 Jul 2022 01:16:45 +0000
Message-ID: <AS8PR04MB8676C863CEDCCE1C0D1B04578C8E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1630046580-19282-2-git-send-email-hongxing.zhu@nxp.com>
 <20220719180025.GA1549128@bhelgaas>
In-Reply-To: <20220719180025.GA1549128@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a81d32e5-9dc6-4ef2-561f-08da69ed8362
x-ms-traffictypediagnostic: AS4PR04MB9388:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LI8GKCp/k5FLAN1gGrLJsxUkP3PWRlmkm1jHzg5DIfL4QcFmRgO8f9mLnKsp6351AMDIO0oakHq4SEoedYlksEDjf8KutDKnr0tiIKL1ygW5T9yq1rfk01bFK+3CbUvjdaoSvFlIhzqr3nJscskpnVa1vPdnoXWvdBiNIprkUoUU4hrLf+ogjWb8MBHu+2CuEaAQUEDW83mez7Wy9SLJM8/W0lA7kC2yowOnZC5NS81WPqeXEl+MGzDIZgTl5DRnNtYBCUVUGA+8UzK1tLKRZgU/GImShww4LuZMUrndURx1RwHbhapcMjzi6X4Jp8y/CsY5yhuPMjvJfQLUMFYjqtJi76Mf00lXdicLoMuFuP2732B7UwF88KNfOVj7ld6n4Sie8h8z/vpwVVr0VrZE6r6jFaHxrMTGkN4AfofdKx/BD1AsrNMkmbynUxrLL2bk90dXRH7kQkfk8aOUjKZrcu1eoKk1XFIrpPuNOu8Lo+oYLebRMGuUSqi70dyyG10nlBd0Y7JD6NnfeLJsRMIOyjF0MjkRDlHHbOv+YYtpnVBTj8EFi37tMKsGM3nok4QT6E4KXfo4ZCDRG0v58bSmqmXZ2E7bfC67OV4GtkY1/kCjLrT7x/oKqMiXbao7WSz5wWXaIhNDSrBwbpcba+Ah0FHTAFAvt8JEWYDM+QkZ0vk54TRuYxuay9YTXQgCxYPCljdmTjncQbLiQgp8DG8AfaXOJUbRyqtarOsp3xWWPz+fKzbVkcGiC/zaYR39Qv5Rr+yLs3CEYaris271m++/EhcUJfVZ4nuWUxfFf7tkP6oh1mT2WDdYNP3NmsVyTs9d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(86362001)(7696005)(478600001)(122000001)(38070700005)(52536014)(44832011)(316002)(5660300002)(41300700001)(33656002)(38100700002)(8936002)(8676002)(66446008)(6916009)(64756008)(55016003)(71200400001)(4326008)(2906002)(54906003)(83380400001)(66476007)(66946007)(76116006)(186003)(9686003)(53546011)(6506007)(66556008)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QlNLNzVFc1hKUVlXSlFmNHZBaWF6enlFb2w4T3hCbnc2bTRHNENmWGMxSE4y?=
 =?gb2312?B?VEJVZVc1NCtMK2JIeWppcmxVTmpjcVZsc1BRWjBGMkRwK0J5RzUrRG14K1Jp?=
 =?gb2312?B?eE11QXNkWWF5bm51VUdjYVJxeDU2SXVpSnk5ZjljZkhTNEkxWFRTa2g5RnBM?=
 =?gb2312?B?NVBoVDROZWFVUXcwWjRFVUprcHpMV1VLSW1sT0k3dWlmUnNvVnlXV1h6WmRl?=
 =?gb2312?B?ZFk2dTEwOVFGc0w1UW5qWW1EZUhlVHNJWUdTNTJsSjJORnM3ZDFpSmhsRy9J?=
 =?gb2312?B?bXNlWmFGV3ZPdkNpcUdWcGE0QUhpOW5yRHNVRlFac1F3Nzc5K1pqS0NsUVBF?=
 =?gb2312?B?YzQzOTlrd3gwS3BoT3p2STJxRG1xTEU2MjRZUzBCcXdETnRWa1I1R2tTQUlR?=
 =?gb2312?B?M0dQaVoxOW1WMWNwWEpxZGlla1VuekVGOXBRdUljTElyS3FYT2U4NU9tcFB0?=
 =?gb2312?B?dkNwRW5BUHAzeWJibjZmUjY4REhmd2pFc010RlNlZDk2ejhHWU51T1I5K3Bn?=
 =?gb2312?B?WUphRjRROTNidHNqZ01NRmFYUnlTVzIzSERFdTFIOVBkSGs4MStZemg3amRH?=
 =?gb2312?B?TjRub2x0citaa0hMcG1pNFZITGQ4ZnRDT2hVdk5aRnMzUDF1bUtiMFdNdlZz?=
 =?gb2312?B?N2IwUURLSmRXZkVHUGhGSjlTUThlUDVCMGFQZjlubnRoaVpWNnlnZjlsVk0x?=
 =?gb2312?B?NUlsdXJKMmllMU5VWlJBbkhYRHlTZkptS250WWY2SHJuUXN2QlBXWjhRbnJO?=
 =?gb2312?B?S1M2d2x3bFJRaGJKbjY0N0VKb0FmMG5KM2sxRTY5K1pSY3hCelBwWjZJcm02?=
 =?gb2312?B?T0pvOVpubjBYdktKR1UrejFsVDRlTEtYMkJxK2NWZFFWUlljWFloWkVlMXc2?=
 =?gb2312?B?YkV3TXFBK3ZLNi9PcTVBNTN3eFdidzE0MksrTGpnWG5KcWpheG9HYVBPS3pa?=
 =?gb2312?B?VFVRTCsxaXNjSGNNaHJDRFpGUzZ2NjdPaldZSCtUNFpydVFqajJSVVk5aEhT?=
 =?gb2312?B?cVVaQmU4SHVoNHpObUM3V0pPa3FrVkRjUGlBOW9TQ1JoVnUvQVJJRm1oQ0J0?=
 =?gb2312?B?UWg3ZFdxRE8zcGxld1creUM4NmpxSWZnNjRYMFA2RjlaS0xINWFKeFZoWGNE?=
 =?gb2312?B?Ny9TRzYyZkQ2YnMvZ05FZEZlT2VFWnhEa2J2SHdWUGZYMW1tOFpkSklBTnZN?=
 =?gb2312?B?clZ3QWkxV2pya0NUVEV6N3hrUWlMTWdLVEtiMG5kNzBkKzIrVUxkZ256bm9K?=
 =?gb2312?B?amoyM3pzVmFiam96U3ZPODFxcDgyWWRqb0JCU25xb04vTE9KVkNlNHBnQ1NE?=
 =?gb2312?B?cS95cGxwNlpsR3FPUktGdk9xZmdxRmU5NUYyVm8vTTFYREdTT2p5L1JZaGFR?=
 =?gb2312?B?bHVnckxGa2hpNFlYcVV1amJSZjZoME1ORnNMVXRXWmV0UXJxWVlmSm1PWE9D?=
 =?gb2312?B?R0ZmQmJwejhuTnRLaFZtejRHc1RXems2TldpdFVmZXlzeGl5akpvc0lyWVJO?=
 =?gb2312?B?WkJtbDBzQVlpRnVXWENGTld3bTlVeWVSUm5Tak5XZXlzOCt1NktXR2hiZzdx?=
 =?gb2312?B?dTZyOVpRajBBak9RK3ZSQTcxMG5FNDJKRWR0b201TTdVU0cyTjJnWkx4Vk42?=
 =?gb2312?B?Q2g3azYrTTEzVk1Ec2pONnEzS1VlMVkxeXI4dHRBdi96aEVUcFEvTkdyTExy?=
 =?gb2312?B?b3drc1VHV0IwbTdmeFRDWVNLMW9mYUJmdlZQNnV5TXJud2IzNkhvcVlsbElN?=
 =?gb2312?B?Wng4U0JLMUFGTXFLTm9EcnlNdHBtSUpIOERrM0NrN1cveCsrcFhoNWZpcHYv?=
 =?gb2312?B?Mk10SVdnNlV3OTRDTCtEQlFpV05XRzlaMDA2dFdZWXlBWC9QT0o1MC9hMVo5?=
 =?gb2312?B?SHFLVy9ZVkM0VUdpaVBtTWJDaXpsVEpGNHYrV05rNDJzbHhqNURmQzFybllP?=
 =?gb2312?B?d1RtcTJkSTZTRUI5UTRHRmIrTWNJcDI2ci9EZXRkNXpYZXB1cFFEQjdzR3R4?=
 =?gb2312?B?bGF3MzdDZHFFd0svczJWeldHVGl6UlZCb1BYaUtuVmlEZmN1cHV6b1U1M3VJ?=
 =?gb2312?B?Q1M5NEF5S3JCM2xQWGcwN0tTU0E4bnZvK3ptZm5zT0N2ZFN3Wmg3SWlEWXZK?=
 =?gb2312?Q?exLBhseR+4EbD8yBCeDa5TeLS?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81d32e5-9dc6-4ef2-561f-08da69ed8362
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 01:16:45.8303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmu3Hh/EnrGe1xOzvbn/KdIko9scAfOSx5iAA0DQ2vsTT1KxALgdFM+9+xCDvdc81+JtfxLZ1uZN+jtvpeyZEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9388
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
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jfUwjIwyNUgMjowMA0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IHJvYmhAa2VybmVsLm9yZzsgbC5z
dGFjaEBwZW5ndXRyb25peC5kZTsgZ2FsYWtAa2VybmVsLmNyYXNoaW5nLm9yZzsNCj4gc2hhd25n
dW9Aa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGtlcm5lbEBwZW5ndXRyb25peC5k
ZQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvM10gZHQtYmluZGluZ3M6IFBDSTogaW14Njog
Y29udmVydCB0aGUgaW14IHBjaWUNCj4gY29udHJvbGxlciB0byBkdHNjaGVtYQ0KPiANCj4gT24g
RnJpLCBBdWcgMjcsIDIwMjEgYXQgMDI6NDI6NThQTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6
DQo+ID4gQ29udmVydCB0aGUgZnNsLGlteDZxLXBjaWUudHh0IGludG8gYSBzY2hlbWEuDQo+ID4g
LSByYW5nZXMgcHJvcGVydHkgc2hvdWxkIGJlIGdyb3VwZWQgYnkgcmVnaW9uLCB3aXRoIG5vIGZ1
bmN0aW9uYWwNCj4gPiAgIGNoYW5nZXMuDQo+ID4gLSBvbmx5IG9uZSBwcm9wZXJ0IGlzIGFsbG93
ZWQgaW4gdGhlIGNvbXBhdGlibGUgc3RyaW5nLCByZW1vdmUNCj4gPiAgICJzbnBzLGR3LXBjaWUi
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnR4dCAg
ICAgICAgICAgfCAxMDAgLS0tLS0tLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9wY2kvZnNsLGlteDZx
LXBjaWUueWFtbCAgICAgICAgICB8IDIwMg0KPiArKysrKysrKysrKysrKysrKysNCj4gPiAgTUFJ
TlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstDQo+ID4g
IDMgZmlsZXMgY2hhbmdlZCwgMjAzIGluc2VydGlvbnMoKyksIDEwMSBkZWxldGlvbnMoLSkgIGRl
bGV0ZSBtb2RlDQo+ID4gMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kvZnNsLGlteDZxLXBjaWUudHh0DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUueWFtbA0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
ZnNsLGlteDZxLXBjaWUudHh0DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcGNpL2ZzbCxpbXg2cS1wY2llLnR4dA0KPiANCj4gPiAtT3B0aW9uYWwgcHJvcGVydGllczoN
Cj4gPiAtLSBmc2wsdHgtZGVlbXBoLWdlbjE6IEdlbjEgRGUtZW1waGFzaXMgdmFsdWUuIERlZmF1
bHQ6IDANCj4gPiAtLSBmc2wsdHgtZGVlbXBoLWdlbjItM3A1ZGI6IEdlbjIgKDMuNWRiKSBEZS1l
bXBoYXNpcyB2YWx1ZS4gRGVmYXVsdDoNCj4gPiAwDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnlhbWwNCj4g
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUu
eWFtbA0KPiANCj4gPiArICBmc2wsdHgtZGVlbXBoLWdlbjE6DQo+ID4gKyAgICBkZXNjcmlwdGlv
bjogR2VuMSBEZS1lbXBoYXNpcyB2YWx1ZSAob3B0aW9uYWwgcmVxdWlyZWQpLg0KPiA+ICsgICAg
JHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gKyAgICBk
ZWZhdWx0OiAwDQo+ID4gKw0KPiA+ICsgIGZzbCx0eC1kZWVtcGgtZ2VuMi0zcDVkYjoNCj4gPiAr
ICAgIGRlc2NyaXB0aW9uOiBHZW4yICgzLjVkYikgRGUtZW1waGFzaXMgdmFsdWUgKG9wdGlvbmFs
IHJlcXVpcmVkKS4NCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRp
b25zL3VpbnQzMg0KPiA+ICsgICAgZGVmYXVsdDogMA0KPiANCj4gV2hhdCBkb2VzICJvcHRpb25h
bCByZXF1aXJlZCIgbWVhbiBpbiBhbGwgdGhlc2UgcHJvcGVydGllcz8NCj4gIk9wdGlvbmFsIiBp
cyB0aGUgb3Bwb3NpdGUgb2YgInJlcXVpcmVkLiINCkhpIEJqb3JuOg0KUmVnYXJkaW5nIG15IHVu
ZGVyc3RhbmRzLCB0aGUgIm9wdGlvbmFsIHJlcXVpcmVkIiBtZWFucyB0aGF0IHRoZXNlIHByb3Bl
cnRpZXMNCiBhcmUgbm90IG1hbmRhdG9yeSByZXF1aXJlZC4gVGhlIGRlZmF1bHQgdmFsdWVzIGFy
ZSB1c2VkIGlmIHRoZXJlIGFyZSBubyBzdWNoDQoga2luZCBvZiBwcm9wZXJ0aWVzLiBJZiBIVyBi
b2FyZCBkZXNpZ25lcnMgd2FudCB0byBzaGFwZSB0aGVpciBQQ0llIHNpZ25hbHMNCiAoRS5YIGV5
ZSBkaWFncmFtKSwgdGhleSBzaG91bGQgZGVmaW5lIHRoZXNlIHByb3BlcnRpZXMuDQoNCkJlc3Qg
UmVnYXJkcw0KUmljaGFyZCBaaHUNCg==
