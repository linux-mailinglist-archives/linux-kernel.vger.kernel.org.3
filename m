Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFBA4E2091
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344570AbiCUGTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244484AbiCUGTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:19:50 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498EE24091;
        Sun, 20 Mar 2022 23:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRiib9VEqZoLe587doCX5bdEjgynsU6ja9jLTPppwXPvKWR6hErKy2dszMnWE+90j+7s1V70BTRKvZCEDoKgxoBggfGTJBgabXVESjk/NDQKspcMFIWhbeakBiz1E4cYCnVNjM4nrwK4ej+wXrRidf/Jm6fA4lU0vmnmc4WFkLrPMjs3bsZz4qPNDgsN6hKruy11M2RfqT+BaebAYjHXrAJVu/hkSWfaJZu/gHeEv7Rp+cUvrTTbHzD25kdaRj8/cHy4De8dZBmDsAIDdK5aylbin1aoKjutJmK5q6RADvVRG8CjUdkgIOeEcByAUt9s8/9fdrsgb+L+db7zfMq0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPaJCZj/vW6FulTRW/4kar/QuYbnqG1GD18maRbLHQI=;
 b=K9OnL+rKEScVKM4pbuDPC0Us8lA8I6j3FG6vr1teFxU04a7BRBEVnjMS1hKo7Cx6JIx4FWrbF8tB3/s/MRn9PTzi3UxPPLQVb+12xmx2+k13H1jivi0qqREVKt+PDP/maw0PN9cp6g2bL2nK1o4EFBKCI0Cu3A2yvA/BxdsOnkuID1pcQi5zEowyiskDc7/ecJ+cg4FL++yt9UIOv6+PZg3EY7DmmiQuPCkmQumbBI1CkR53kpIGxYbGq9ZfbSI5pB92H7NGOZvxe/inxRXRiEGv7OFecCLZDKeKYNWt3frPz8UANHXqcguZ21/gK437EqwxsZCItESInzh6+ARzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPaJCZj/vW6FulTRW/4kar/QuYbnqG1GD18maRbLHQI=;
 b=DXBIj/wSzEjFDSYyRiu8+qaEJFk6p5dKWM0Z7a+jPq5dXG9XlcBffcA65kP7cMPJV26og+YrXHdBwCZM1ZJ6XM/Bw2wz0w/G8fm9GgfG1MQDIDRBaZFeOxNfJf9ecT067qipU2fhNpFq2ULn0NcW0PfqS0Meee6YAgLB1FCmKCM=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8293.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Mon, 21 Mar
 2022 06:18:22 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557%5]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 06:18:22 +0000
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
        dl-linux-imx <linux-imx@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: RE: [PATCH] arm64: dts: imx8mp: add ddr controller node to support
 EDAC on imx8mp
Thread-Topic: [PATCH] arm64: dts: imx8mp: add ddr controller node to support
 EDAC on imx8mp
Thread-Index: AQHYOryzxNFxs/LqK0CcYowyV5hw8qzFCMyAgARXItA=
Date:   Mon, 21 Mar 2022 06:18:21 +0000
Message-ID: <AS8PR04MB84044B0FCB085198585CC54492169@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220318113526.15986-1-sherry.sun@nxp.com>
 <df985bc1-bb99-9623-ad78-b77329b8eba7@kernel.org>
In-Reply-To: <df985bc1-bb99-9623-ad78-b77329b8eba7@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 239db5da-4711-43b2-ad33-08da0b029997
x-ms-traffictypediagnostic: AS8PR04MB8293:EE_
x-microsoft-antispam-prvs: <AS8PR04MB82939161F5FB6954C96C506D92169@AS8PR04MB8293.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VVWfiDan9/HAithyoj/n+CpQRUpJHlL1uLx2VW43epYlpzf45caAP0Hk9voC0khulKe7ME6HLQ7WCUXu75UJzXXPu8c5ZQKVlpVC0fu7OludC3DAlZJjDLl4lu9sz+7PPJ/Wnq5DZxC3L0qkyzGhq9Of3RNIqJ26AeIzWYtKMWPORAZrQkmKYNl+fngUXTnkLM8GdGRQjFwg+rAY72CB9cs7Y1y8Q8GXLcTkVLFPWexKAdn2kunzonhlg1uVGt4kI9T7gsGSs5gupO++5sqGN2R893AEO2hiF+RIc4r2oOmsRVUO4ZtQl0CSdyDuTgO62y0VhRQWLYEvnxB9fKeukAjlLeOJuvyG7UOJJHINwXNjQ01eXZue/iN8zsr2l/7OcBYgnAsT99HKcOIhGYN0CYl18GVb6i/kojRREh7P99UkxbKbNj54r8iu5NRnk2SoIQMuetsksMDdm7JA0As4Rnw1lIcVPIFQqo8n/uJ8l3CgpfPTeyl//syEXFhAmlSSZdEr0aeqxK7bFe+i5138t10e8cnJeqrX038qIhEzQljYGW0INIgq4TEZVjuiF2JhjLisGdEOVWQUz8LWiduJaCdu6LgSgfgxLBqmTF2Cg4th8XVjTe6s8JYPp/62wyt8z/aT7yUrB3SWf72gc288bywBIzU6/7tKJAjgAqQL7muguA9XWMosGVC4oiFU9fV9szKM3VR1xnHC1PBwu/e1uxCNkp7g32XCfMm2QBEijWE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66946007)(64756008)(66446008)(76116006)(26005)(2906002)(508600001)(66476007)(122000001)(186003)(5660300002)(71200400001)(53546011)(44832011)(316002)(8936002)(7696005)(9686003)(110136005)(55016003)(33656002)(54906003)(38100700002)(6506007)(86362001)(52536014)(83380400001)(4326008)(38070700005)(8676002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGFhQnJnMDNSZlFuTDNCZGE5SGFQaERGV3J2OVFncjE5ak16TGZlNktKUEhm?=
 =?utf-8?B?UGp2My9FQnE1eGxUZkpOdHJzWDVSMG9KWVNUNWp1RXcvc1E5UjBXc2UxcWJD?=
 =?utf-8?B?M3FmbVN2dm9RWmtSdlBXZXArd09JRk5IN3QvWit3aE1JNnpza0ZYMDRncSti?=
 =?utf-8?B?bDIrd1ZuQXF1WU1jRUNuZ2Fwd3ZERHVSWjgvVE5IQ0grcnovZnUrRDhRLzJ4?=
 =?utf-8?B?SGtxck4vWDFaL0NueGh6TVNnLzhydWNuSE5yeVRGRm1MTk9kUjdKd0xGT2ZJ?=
 =?utf-8?B?dkJmeWdzeEJvTW1kRGswSVpNVDJ1WEg2aFZ3d2F0UGVLYVV6bVRWYTgrbWs2?=
 =?utf-8?B?YUcvOGRTV3ZwdTl5ZEI0RkNwNEVlTWNkTS9JNVJYc0NVdWZVb3hNaTZlUmc2?=
 =?utf-8?B?bTYybTRTQnhvcGM3RkVpOUV5MEl4L2EyQ1R0YzdKT01JOXZabUxMRjR5MjUw?=
 =?utf-8?B?dW1Cc2ZYWU14TnRXb2xWeU5RYmRTVmFDUHQ0U0xleXNIcW9IRUdDaVJMWk9z?=
 =?utf-8?B?N0NSVUNWYjAwQ0dGUzNkKyt4U1p0K3ZLczZ2MFFNYXR5QTVmdmJ2S2hyKzBL?=
 =?utf-8?B?ejJBTlhXbklkT0t2TzB0elZvc3laWDVKeG9kNVdkQk4zVE96cVJ4Q0wveldl?=
 =?utf-8?B?T0hRRWRmczlORjMwc1dhRWtkQUhvb0ZhZGtCb0hiVkhPL3VRb3BLOGpZZXRv?=
 =?utf-8?B?K3NRd3VVbGdGU09JUUFENTVZdnFnYy9Db3ZYTjBDVi9vY1NrUStiWWE2d3Rj?=
 =?utf-8?B?bVFhRFBQVlpEWTFsT2xLSldGdWpxeHNpYXE4TWZ6NTF4bVJ6LzFvU0poSEZm?=
 =?utf-8?B?d1ZwZ0s3TkxRTW5CS3gxSG41emVTNVBjcm5XS1lpeDMrUm9zT21NSkFzZDBH?=
 =?utf-8?B?aFhtZkpFWlhPVmVqZzArakxWWU9VZDl3UmRkUWxsREJWcW93NEhBVDFpTmUv?=
 =?utf-8?B?NlpFWlJMWnRFWHlQaTUxUTR6VUN3eDgwdTh3MmdLeWVGRFY4K09Jc1BDamQ5?=
 =?utf-8?B?T0kxNEowWWJoaFErL1NwM2pmNW83RFhwSmNVVFd4TWpBRXdFSVJoYnRvVEp3?=
 =?utf-8?B?a3JNcmlJUEVleWtyQ283cW44dGNwS0tsNm9IWlEvSGVXc056eHJUUmFNYms2?=
 =?utf-8?B?d2JjSElYMGRPQmlOaHZmZjJmN2ltZGU4c1JodXBsN2NQNGF5a2xGZ1k2eGZh?=
 =?utf-8?B?a1Z5SXhEcXZ5TW90QjMwZFE0SHU2VW5DNTRjWmtqRERQaXlqMEY1b2tmbC91?=
 =?utf-8?B?L2V2cGk0SEVodFk2VnJCdEplc2dQdW1hcWhqczdZaUJQekZCS2l5Tkl6MHZW?=
 =?utf-8?B?MGczRTEvRkxOakNzaFdROXFBdkd6Y1o3L1E1eXJCYkprS2c4Q2lGUXM3UTZz?=
 =?utf-8?B?RWU2N0l4eDJrL1ZDWWc0ZXNuclFDQk0yNkdqMEIrTitFMStENGIrMEdiSTNP?=
 =?utf-8?B?TU1YVk9waHY3RjlTRDZPM1cxcDF4RzdRcmdlUGlNbDk2RlV3YW05SHRXRXRy?=
 =?utf-8?B?SVltNWJUTVlJcWNURENjZEJ3aEtuSlBhVVF1K05vU2VodkY2TnNXUDFBVGZH?=
 =?utf-8?B?NFJCY2trMDdtOGhzaEpxSUhBTjJ5Zkkwd1FGRVF0dXFPdlFrbGdpNEtmcHlt?=
 =?utf-8?B?N2RiTjh0TTh3UmQyd0MrRWRPT1M1aFMzdXBPVU5nVXhtbDFTc3RvYkZlTmV0?=
 =?utf-8?B?ck5NWCtOdGU5MjJ6aWRhQXAwNlZXbDA1aSsvRXJvUGNCSWdMV2d2SXBya0Er?=
 =?utf-8?B?YXViMUJXaTRlbzE2d1VkWjk5ejUvOFY2Y2ZCd1N4clVIS2N2STU5Vlp6bE5H?=
 =?utf-8?B?WGVyQW5XV2ZPcnJSd2dER2NZTlFWUXRFTUlWQ3hYMnZYRlpNY0d0TFpUZDdW?=
 =?utf-8?B?ZUhMeTd5czFaT1AwSkROaDB1eWdlZ1AwWDAwdkJYTGw2a3lpdmRGakdhaDVX?=
 =?utf-8?Q?uv42fww2KSI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239db5da-4711-43b2-ad33-08da0b029997
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 06:18:22.0416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NPR04Peqh8eMu9HroxgWBguqI5eq0x/6uWOcevXeA7ygIKzFohr1NL+cuDg1MR16kU8pU+iTMB31HxFZ0jGL5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8293
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
ZGFjIGRyaXZlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBTdW4gPHNoZXJyeS5z
dW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1wLmR0c2kgfCA2ICsrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1wLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5k
dHNpDQo+ID4gaW5kZXggNzk0ZDc1MTczY2Y1Li5hNjEyNGExMWQ2ZWUgMTAwNjQ0DQo+ID4gLS0t
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kNCj4gPiArKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+IEBAIC05MDIsNiAr
OTAyLDEyIEBADQo+ID4gIAkJCWludGVycnVwdC1wYXJlbnQgPSA8JmdpYz47DQo+ID4gIAkJfTsN
Cj4gPg0KPiA+ICsJCWVkYWNtYzogbWVtb3J5LWNvbnRyb2xsZXJAM2Q0MDAwMDAgew0KPiA+ICsJ
CQljb21wYXRpYmxlID0gInNucHMsZGRyYy0zLjgwYSI7DQo+ID4gKwkJCXJlZyA9IDwweDNkNDAw
MDAwIDB4NDAwMDAwPjsNCj4gPiArCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE0NyBJUlFfVFlQ
RV9MRVZFTF9ISUdIPjsNCj4gDQo+IFRoaXMgaXMgbm90IGNvcnJlY3QgYWNjb3JkaW5nIHRvIHRo
ZSBiaW5kaW5ncy4gRGluaCdzIGNvbW1pdCBhZGRpbmcgdGhlDQo+IGNvbXBhdGlibGUgbWlnaHQg
bm90IGJlIGNvcnJlY3QsIHNvIHBsZWFzZSBmaXJzdCBmaXggYmluZGluZ3MuDQo+IA0KPiBXaGls
ZSBmaXhpbmcgYmluZGluZ3MsIG9yZGVyIHRoZSBjb21wYXRpYmxlcyBieSBuYW1lIChzIGdvZXMg
YmVmb3JlIHgpLg0KDQpJIG1ldCBzb21lIGlzc3VlcyB3aGVuIHJ1biBkdF9iaW5kaW5nX2NoZWNr
IGFuZCBkdGJzX2NoZWNrIGZvciB0aGUgZHQgYmluZGluZ3MuDQpTbyBub3cgSSBjYW5ub3Qgb2Jz
ZXJ2ZSB0aGUgZXJyb3JzIHdoYXQgeW91IHNhaWQgaW4gdGhlIGJpbmRpbmdzLCBidXQgZnJvbSB0
aGUgbG9naWMsIEkgZ3Vlc3MgSSBtYXkgbmVlZCB0byBhZGQgYmVsb3cgZml4IHBhdGNoLCByaWdo
dD8gUGxlYXNlIGNvcnJlY3QgbWUgaWYgSSBtaXNzIHNvbWV0aGluZyBoZXJlLg0KDQotLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL3N5bm9w
c3lzLGRkcmMtZWNjLnlhbWwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tZW1vcnktY29udHJvbGxlcnMvc3lub3BzeXMsZGRyYy1lY2MueWFtbA0KQEAgLTI0LDkgKzI0
LDkgQEAgZGVzY3JpcHRpb246IHwNCiBwcm9wZXJ0aWVzOg0KICAgY29tcGF0aWJsZToNCiAgICAg
ZW51bToNCisgICAgICAtIHNucHMsZGRyYy0zLjgwYQ0KICAgICAgIC0geGxueCx6eW5xLWRkcmMt
YTA1DQogICAgICAgLSB4bG54LHp5bnFtcC1kZHJjLTIuNDBhDQotICAgICAgLSBzbnBzLGRkcmMt
My44MGENCg0KICAgaW50ZXJydXB0czoNCiAgICAgbWF4SXRlbXM6IDENCkBAIC00Myw3ICs0Myw5
IEBAIGFsbE9mOg0KICAgICAgIHByb3BlcnRpZXM6DQogICAgICAgICBjb21wYXRpYmxlOg0KICAg
ICAgICAgICBjb250YWluczoNCi0gICAgICAgICAgICBjb25zdDogeGxueCx6eW5xbXAtZGRyYy0y
LjQwYQ0KKyAgICAgICAgICAgIGVudW06DQorICAgICAgICAgICAgICAtIHNucHMsZGRyYy0zLjgw
YQ0KKyAgICAgICAgICAgICAgLSB4bG54LHp5bnFtcC1kZHJjLTIuNDBhDQogICAgIHRoZW46DQog
ICAgICAgcmVxdWlyZWQ6DQogICAgICAgICAtIGludGVycnVwdHMNCg0KQmVzdCByZWdhcmRzDQpT
aGVycnkNCg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=
