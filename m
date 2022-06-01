Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F1E53A486
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351780AbiFAMDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiFAMDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:03:35 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7110C4C781;
        Wed,  1 Jun 2022 05:03:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WraWOxcj5IZHqRDlvyLq+U3Yb7gfxLSH0tJ9XAoeANKdRqvQkrnQTqswR2QGBF7zs3RkGFSGLuh2uNyPuZPfjxH448VBKkeg/dKdsIH7UfzbXN2ESoA6F5kjWhMJmWUxvVqMm9yJbJW3XG5NRj/Z3+To/RcK6VERM8Jku9ltM/nQ2/2VK/zP/cNKIxfBe9C/oQ60AYUXGW7X8zOVKc3mmSWix8YWGHGRbMLYBolAdsdxmdwHiSKcvFtvVciFNDV09Bjtkgw8O5EDy7flEi4aa3JrNLz7q02VIhfK7dsNe7Bxa0o1gTJCuoLwVTteyaJHyG0vdVuOXWuv61IXb4nD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/UKxylHy9Gy6UGVegHBVvYlAWqbov8ljIjyN7euGRI=;
 b=Fsrf+6qgVZERIzrTgor8vW9SqMnAAVG1IyksRrS25lMbAReRAvxgmZHKR42n5VIsH0MwdnHCt5MqYA+TjyTV4QI874qLOWfGhzZbG/arRf/8jlhKh0iMCUe/D/r5b00lotf+kxEMNc3JwYKwfM+fD5ybbfEUVdnraVgyKlQRQx3ZuqVevoIi88Rppfnp1NUX392yqnlAPrMCMQlbQfEANV/Awvegovi759FUACrrYAv9GgtkPddIkRb726TphSsesA4hz6+SDM98DmtaTTHveJ4pOqSyY54eMfc3zxkHUQJc4xzweCYC9cJer6ivCwjolWKHDVOJUlWIZXFsQKWFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/UKxylHy9Gy6UGVegHBVvYlAWqbov8ljIjyN7euGRI=;
 b=S7LFgyiOkJeK0jcIByEWeHoS4jtvWNKcvf1hIijUQZkWqS0mw5qiQ0XhRi0k+Oj83UhtRDTqibmgn++XUK3/MUZtJn26gAAAZdKxJN8jhfHf2A/cElZ2u7wDKxFhNbnTc1k+lFsX1XXWV4UDaiCHRhCqBcHt/8msdfyIsx+zQcE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7052.eurprd04.prod.outlook.com (2603:10a6:10:12d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 12:03:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 12:03:32 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "djakov@kernel.org" <djakov@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, Abel Vesa <abel.vesa@nxp.com>,
        "abailon@baylibre.com" <abailon@baylibre.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
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
Subject: RE: [PATCH 8/8] interconnect: imx: Add platform driver for imx8mp
Thread-Topic: [PATCH 8/8] interconnect: imx: Add platform driver for imx8mp
Thread-Index: AQHYdZu1Vu4+e6Y49EWG6imLPX/3DK06chGAgAABnIA=
Date:   Wed, 1 Jun 2022 12:03:31 +0000
Message-ID: <DU0PR04MB941749B53C5A3B8EBE01B84D88DF9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
 <20220601094156.3388454-9-peng.fan@oss.nxp.com>
 <06f13727-adf6-6a33-1648-f85a7941e1e4@linaro.org>
In-Reply-To: <06f13727-adf6-6a33-1648-f85a7941e1e4@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44c95ee8-016b-48cb-b450-08da43c6bf6d
x-ms-traffictypediagnostic: DB8PR04MB7052:EE_
x-microsoft-antispam-prvs: <DB8PR04MB705220972F42FC8DC3F1D66588DF9@DB8PR04MB7052.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8wCb0tapK4p1gf4L9pvm2fsx/y0nNwK0D4TK2aDocDUJkJaAWw73Rq+vqFjxjo73Xl4op2Wior59ZEQ5EV3sv5sseiM/rjIM4v8Hna8HzrBXdT/4qY1i6J23bWy+3z9ToPTQOR74gM7Dkhk8Frbz9TxqpI8tgylQCR6KL2ssEOQy25BuV74cHjjMQcUwJDvFajoCrtdFyYwG+7CySnB8lIDYeTcN0oXPiNYP5mMUdmbJAh5eQMAT4wBHNtRFnua7vBhKUReBqcca/Rh70OQXRVcpvmb/3ouoJvT36QPhXjbf9J4l0EbZdL7mHwUZM1BTOH6tlOJInlzPDzfRDpClNqycbdiA1TXfRcZu8olLLKDFUq0FA/kB2Tg/kDnrNBSTApau6p2tRlhyOhPOC98tRf19JfnjFEl8Dz08Dvti5dL9xiGRt8CVhvvfZdcmVmBxafddhBHmPkg8stMzXDDBD1lfvxY4bp0nXA0OH46mxVOlKtP27pmvpjo9YJ8It2a0oidTxOxfDPf2ba+70S810BkmJhiAUcJHZL/WvHSg0dSbuqAbDnQX0uxI2/ptjosTH2i1QjYBlKMJS6qkpKrdUFAZOeOfrSLh4tnRRe+xs+dymg007fw91W69tea7kI/1wB8dvwrWM5lV4VbJlhD1OGL7KhjnYXLgFf3kyCt1kWrM3OLdbjQlDWaWpmCxuB8TdT/ptxokVtXzntbWGxVA/5deBe1G/IPilVvCyoPAD/g4vsZTd0+fXPBoOCaDO54V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(921005)(86362001)(71200400001)(7696005)(38100700002)(6506007)(186003)(53546011)(110136005)(54906003)(316002)(8676002)(33656002)(38070700005)(508600001)(4326008)(2906002)(26005)(66946007)(66476007)(5660300002)(66446008)(7416002)(64756008)(52536014)(76116006)(66556008)(9686003)(8936002)(44832011)(122000001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHpySC9JQjRJdnQ2SjFxbU5JZ1VKUG5LdXM4MVYvczRKRmErK3BsdXd6Zit1?=
 =?utf-8?B?QjY5VXV1R2ZPaW9EK3A5dGJmdnBWVnJSWDlTOG9WTTd6ZWQvWVlqUmpycVBp?=
 =?utf-8?B?emJnc3hPVmk0SkFxWjhrczFjZG8vM0Y0Nk9waVZkUHRqQklFUzlpNVdIT1Zz?=
 =?utf-8?B?VWhoVFB1MGdYQk1TOTlQVGNLNGZYdHRqY0gzdmR0K2dmVW04VUtzZlVJejZY?=
 =?utf-8?B?b21wSGpzOTNOWmdoOHVCbm40ZytPY0haRHg5aU9YWldwU2tOM2NTYmk5bzRZ?=
 =?utf-8?B?aUhrLzdMSjFkbnVTOUpPTXI4Y2NhTTNKclAvSkx3VWpKT00yUUc2NjJaeUxs?=
 =?utf-8?B?bnZzZkdvYXNqZFNkUjlObjg0M0VTR0FsZHh6QktSeUhzL282ZEtUNFJuWlNQ?=
 =?utf-8?B?MUdDbkpzNnVKU2Q4Z2h0dFlxbHIvc2pFK3hneVBnVEVUMmZmWWlaS0ROMDZp?=
 =?utf-8?B?eVRvaHFMTk92d2RIQzkranFhOUVHUDRzSWJZUnJpNXRQMHRsL2pxVjdxY3B3?=
 =?utf-8?B?Z0NleFJ3OUFYOHBXSFFITlVua3FIT3B1S0J4OEpQZzNlQmpZWlZTOVpHQ1dD?=
 =?utf-8?B?WkRvcmpBRjlsM3JDK1Rua044NngxcU9idHQ0MXJwL1VFeWtESE9SUzM5Z0FX?=
 =?utf-8?B?Y294S2pVNnJ2UlJDUWt3U0k4RUUyZ3N1cFA0dndmdkxFNERCSWJ0SXNuTjF3?=
 =?utf-8?B?TFlJRzNVMDNnTHV3K1h1SUtucWs1em9xcE9FUklQYUdSU2JaVS9DaHJ0cmJz?=
 =?utf-8?B?eXJqU3Y0dlROb293WXhadTFPOFczRnpSU1dHdzhsU2JyVGIwRk14aWdxKzVu?=
 =?utf-8?B?Zi9hQTQwQjNMVm1MOE8yMnMrK2ttUEtCRWhmbHZ0Ly8wUG1pN21YdHNtREw1?=
 =?utf-8?B?UkhhR1lUcGE5d3JveUFmcm1Na1E1bHVoSzdqVjQzWGdTYWMxeWt1cmk3RTFr?=
 =?utf-8?B?emgxdk1TM3Zza1FtRmpGMVJlN1JZemVrYXMxbjlZVEZrQ3NkamdHc3NaUldj?=
 =?utf-8?B?N2ZYc3Evamc1SE40WTBoYzhack8yZWNBLzVTV2MvS1R4OWREV0NKaDFOK0U2?=
 =?utf-8?B?cVlJcjAvYnZ0ZHBWckNZM2VBNkNPU2dwTy9YK3U2NE1aUWJxRkhxby9ZNkFJ?=
 =?utf-8?B?UmQ2Z1pHMmdyeWExSGgzVkE1RGdYY1BVQldHTmJXSDdJdkxRUVdscWE0T2dk?=
 =?utf-8?B?OTNsbmYzQ3NhL2x6akNja0hBUmp6elN1M1JyS0xCQzJ2a1F5Qmw5bEZCMHc4?=
 =?utf-8?B?aEJJUmtlSlplc20zNnMxL00vbStFUUFqdzBRK0lEY0ZReEk2NmpJV2pwVjRq?=
 =?utf-8?B?TU9lMC8xazB3Yk9xTE1NOW9MT09RVmxIVHZZWU9XdlVWb0NNcTA3QlRySmNP?=
 =?utf-8?B?L255bTNIb0hYQlh0V2pJNERRTzRXcjN0MnJySERhR3NVcHkraklaemNJalc5?=
 =?utf-8?B?cjYycVhmMU9yWHEyd2FKZURsQkdIVm94Y3VlaG1nZ21NTmpmdXhYRXlUQzlp?=
 =?utf-8?B?anFEVms0aFlXOVNrQnZyVGR3R3ZlS3dYUVpGcW44QklzM3JyVTl0M083MnhR?=
 =?utf-8?B?bkx5WGYvREJHanhpZ01mSEp5dWtGSHVJaXkxVlFxSUYxN1VSOFRtYjBLc0U5?=
 =?utf-8?B?MlNLcUNDM3ZGaERGeHRzT1Z0c1FYVSs3cElTWlNzSGtQamxNeEpJbEtQUWZt?=
 =?utf-8?B?MHpmYjBHKzJrNWlZTlQwNTdrVFJseXBrTmRTczh2NWowdzFORVJDQTJCc1Jo?=
 =?utf-8?B?S1lSbGQ4eXR1NlJNbS9KSTFUY3hWazBiMStVbGxCNzI1YXNnamkzMTM5aDAy?=
 =?utf-8?B?WDZWVVo2RmZ0T1lyMVkvQkxLNUVoQkMrVzllWnlpaDFJVkYyVFMxTml4RE5H?=
 =?utf-8?B?bEFvQy96NFVESU5PMHJXWXhWSWJqTGlSemp4SXFlYVlySDExa25TMW41N2Fs?=
 =?utf-8?B?SVhJNmVsNlc3ZlZic1pWcFFHWHFsZ3lwTDRiMFBTNDdFMm1jSThlc3dFVlow?=
 =?utf-8?B?VDhhUW92Q3VGUmZWZU9uWERoWlZ6d29WeitzSlFSdTRtWDQyQ2krdVpVNm9T?=
 =?utf-8?B?WHhyZ21pMnpzUDMxZFdtSFBvTE5GWEEzVW5BUm14bjFXZHZzUjdyMlN3UkM2?=
 =?utf-8?B?bTdhOXhJTVg0MWdLVytmbXhlTGV1WXdRaFR1V3k4Yi9tU0lURlc4ejVnbGZP?=
 =?utf-8?B?czQya0EvR2ZNZWhoYnZUY1FzWmFicWlSZm9za1ZGNE5Zb1JvOWl2UjNCWUov?=
 =?utf-8?B?WTg4dGZ5Um9TbEdrQnFKN0lYb2l5aGVuS3c1KytqWEdvUjVGM2JxbGh3N1lK?=
 =?utf-8?B?QnlqK09mK09xVXd0dUI3cU92TTExdnZwRTRFSFR6bkpxM21tODZsZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c95ee8-016b-48cb-b450-08da43c6bf6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 12:03:32.0101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SV1qN8mUkCMf4HbANwpZQaZ+/6aCK2K7EaTQsgMOePx/afk92f/qkdi91uJWkZoG4/9z/pclqVcee41xa6Jhzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDgvOF0gaW50ZXJjb25uZWN0OiBpbXg6IEFkZCBwbGF0Zm9y
bSBkcml2ZXIgZm9yIGlteDhtcA0KPiANCj4gT24gMDEvMDYvMjAyMiAxMTo0MSwgUGVuZyBGYW4g
KE9TUykgd3JvdGU6DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4N
Cj4gPiBBZGQgYSBwbGF0Zm9ybSBkcml2ZXIgZm9yIHRoZSBpLk1YOE1QIFNvQyBkZXNjcmliaW5n
IGJ1cyB0b3BvbG9neSwNCj4gPiBiYXNlZCBvbiBpbnRlcm5hbCBkb2N1bWVudGF0aW9uLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IA0KPiA+
ICsNCj4gPiArc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgaW14OG1wX2ljY19kcml2ZXIg
PSB7DQo+ID4gKwkucHJvYmUgPSBpbXg4bXBfaWNjX3Byb2JlLA0KPiA+ICsJLnJlbW92ZSA9IGlt
eDhtcF9pY2NfcmVtb3ZlLA0KPiA+ICsJLmRyaXZlciA9IHsNCj4gPiArCQkubmFtZSA9ICJpbXg4
bXAtaW50ZXJjb25uZWN0IiwNCj4gDQo+IEhvdyBkbyB5b3UgbWF0Y2gvYmluZCB0aGUgZHJpdmVy
Pw0KDQpkcml2ZXJzL2RldmZyZXEvaW14LWJ1cy5jIHdpbGwgY3JlYXRlIGEgcGxhdGZvcm0gZGV2
aWNlDQp0aGF0IG1hdGNoIHRoaXMgZHJpdmVyLiBJIGhhdmUgbm90IHBvc3RlZCB0aGUgcGF0Y2gg
dG8gYWRkDQppbXg4bXAgc3VwcG9ydCBpbiBkZXZmcmVxIGRyaXZlci4NCg0KVGhhbmtzLA0KUGVu
Zy4NCg0KPiANCj4gPiArCX0sDQo+ID4gK307DQo+ID4gKw0KPiA+ICttb2R1bGVfcGxhdGZvcm1f
ZHJpdmVyKGlteDhtcF9pY2NfZHJpdmVyKTsNCj4gPiArTU9EVUxFX0FVVEhPUigiUGVuZyBGYW4g
PHBlbmcuZmFuQG54cC5jb20+Iik7DQo+IE1PRFVMRV9MSUNFTlNFKCJHUEwNCj4gPiArdjIiKTsg
TU9EVUxFX0FMSUFTKCJwbGF0Zm9ybTppbXg4bXAtaW50ZXJjb25uZWN0Iik7DQo+ID4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvaW50ZXJjb25uZWN0L2ZzbCxpbXg4bXAuaA0KPiA+
IGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9pbnRlcmNvbm5lY3QvZnNsLGlteDhtcC5oDQo+ID4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gDQo+IEJpbmRpbmdzIGFyZSBzZXBhcmF0ZSBwYXRjaC4NCj4g
DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi43MzI1NDc1NzdjNzYNCj4gPiAtLS0gL2Rldi9udWxs
DQo+ID4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9pbnRlcmNvbm5lY3QvZnNsLGlteDhtcC5o
DQo+ID4gQEAgLTAsMCArMSw1OSBAQA0KPiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMCAqLw0KPiANCj4gRHVhbCBsaWNlbnNlLg0KPiANCj4gPiArLyoNCj4gPiArICogSW50
ZXJjb25uZWN0IGZyYW1ld29yayBkcml2ZXIgZm9yIGkuTVggU29DDQo+ID4gKyAqDQo+ID4gKyAq
IENvcHlyaWdodCAyMDIyIE5YUA0KPiA+ICsgKiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4N
Cj4gPiArICovDQo+ID4gKw0KPiANCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRv
Zg0K
