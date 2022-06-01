Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACD653A48C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243290AbiFAMGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352721AbiFAMGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:06:11 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10062.outbound.protection.outlook.com [40.107.1.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752CE4C781;
        Wed,  1 Jun 2022 05:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGORUp3Po8d3Col2Nms6nvcg5uuaUJSqClU4oBA410zMjIGKuRk3Jqcg5nvufYCcyowWybVIv8bMQdM5PgTMc4R91dhv8Yldkom6LDLIrduSqEV+FNpSgifkKP5Yf2dc6GOp2inPrPFz5v13kZLe4tsLhgWenduLxlLZ84k9gHpRF/o8Am4O182j5LiKdr0awgBIzoiKE+TLn6YhOt3rm6GOQuovYdEf0hFQWjSbugb2q6mWgCucTdbjvy+6cE8NIy1OEKYWOKSks37pmVK/4slaQqV4Fc1XZDOCLhAf/RpVOAXaLY8quW91N3/WLo9Sk3dsz7AeXalZ0GfyOEobMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SarWNfPg+iaxJ4lDiugyPhPNYh8VxOb9B0Pep6ZqKRA=;
 b=Lj4/Mu9bNqvu0mqBbmrnixn1v+UmjogrwVswPXSqN8Fk/8cPLAZ6tzqwEZaOdZfnzMc0EbezvOA7hL4IqUl0HdrVjVuD/X2uQi9O0JTdOe73mPJXAgEcf1ERfucvGX0mpCXsjNbG6DzznMUANkZqrHnf7t0VGfw8DVUTYKsh8B5CgUv8lTi+b5Nxi7037myJm6DxO0NXcSQsNgsHWf/5nYcOisrio73sHR+7hOMtd6KiQB/ITrh5wHJ5rTuinv0dc7JXGjqG+LgdJU32+jWcdbWaPTI4MhqBT8x2r6Hbjo/I5bwPIYAdITcg8i3j57uW6er4rLgIU2h3dP1LvtBncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SarWNfPg+iaxJ4lDiugyPhPNYh8VxOb9B0Pep6ZqKRA=;
 b=eBHCw0pmuGj7/rKJAoYcGpczqQQCvV+MkPmdNaqoa/vRrcPont0DUklTIDlTHscpoZLLyIw2AC/zDnYrNIQOgCNgiifrO4tdXDEHzBfy0AcXY06yLZTNlIs7ljyyu4yydyhuXQdXOlWPMMKtwZ5vxR5g0mkGvUtMsHF/a8NnFI4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR0402MB3714.eurprd04.prod.outlook.com (2603:10a6:208:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Wed, 1 Jun
 2022 12:06:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 12:06:07 +0000
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
Subject: RE: [PATCH 1/8] dt-bindings: interconnect: imx8m: Add bindings for
 imx8mp noc
Thread-Topic: [PATCH 1/8] dt-bindings: interconnect: imx8m: Add bindings for
 imx8mp noc
Thread-Index: AQHYdZubIzBTNogb3kiyKDXDgoGxDa06cbUAgAACYWA=
Date:   Wed, 1 Jun 2022 12:06:07 +0000
Message-ID: <DU0PR04MB9417380EC27688B3DFB9326388DF9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
 <20220601094156.3388454-2-peng.fan@oss.nxp.com>
 <cf90d9aa-1ba9-9619-35b7-8c2de436fc12@linaro.org>
In-Reply-To: <cf90d9aa-1ba9-9619-35b7-8c2de436fc12@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc2b4293-0dac-4ff4-1a0a-08da43c71bf2
x-ms-traffictypediagnostic: AM0PR0402MB3714:EE_
x-microsoft-antispam-prvs: <AM0PR0402MB371421555FD45D77E7B0036B88DF9@AM0PR0402MB3714.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ru6bRjM2sXck4gpvu4xExNLKK4Kq7NsM6NrxGwHEg1tnv9phl2VNw1ZiBp3zzcKOk9F0nyZRCD6xJ2Ldz79hnreXRF1E6We4+oaxOPuPTv65Vcqt687w2g8mWVGEIe2zHBtEwie5hkDMPg683ZJlWIT64YFo7+EuNSWw5JHqyGgOCKNkoy4PHE2Cy+yT+ilMJsfljsQApvmBNl2INITE0CQ+8eqFUJN5CTHtFE42KGd6zoVVXXXJUl+5Xjvh/81IneHdLQsHMRWvQdc5nyrWvrw7lgK/RdBhVMBIlB12N6FQ6SMMh93ZSnOTnsiGAHXm0h0kfaAqK+mkAtJIT7CLwW7v2//swWKU/rjo7FK9UkXBPvbzJuP5SNRFSniVDCEStqcjJjn1P3LLOUBEJvd0qkqTlN9ooWpovLcX+GblyGLAgqzw7WlGNcq9q4sYXmDRBXPqWhsszlfAdu2qFHVM+CcZvA7tK3pRbIWoMhuBGiCZbHxcjPvMSSyyCSU7TiGLQZTsNpw7hEBetMjPfq/9WEBlyRjOUMBMwPDSuVPig/WN3Aouktmq5XXlR8iW+wyneFB+WsDfLhADZmRDiHQlriXlCxcs4RID3CF/PZHKXv1kiOZy7S9rK4I0Ft0ebcSqJrbJqm28yNIf6+kobUPGNtszajl3G7xy7Wwp2EK/tCBCYvWbk5h6EenKPbIqU0WGksUfKoBK3APt2XSzXNzhyQ/F8XXlBJwaCU8WQ9RjisGX1wtnhox399fW9484wIWZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(921005)(7416002)(7696005)(26005)(9686003)(52536014)(122000001)(33656002)(508600001)(8936002)(38070700005)(71200400001)(66946007)(64756008)(66446008)(76116006)(66556008)(66476007)(8676002)(83380400001)(4326008)(5660300002)(316002)(55016003)(44832011)(186003)(86362001)(110136005)(38100700002)(2906002)(54906003)(6506007)(53546011)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0t4dEx0T2lYSHJkZmZIY1FlKzhKWHRrN2hseUxqekV2WmwyNzRoekV1ZU9h?=
 =?utf-8?B?cWp2bm1HWTkxL3VDZ0hWS2NSM2FrUmRvNFZ3NCtrT2hJS2g3WndzMFpMUlBt?=
 =?utf-8?B?TmZQaGRiTnFpSUlBYmZnWm5rMThRM3JMWEFlYW9rKzRkRUlwbjBsdVVQeXNw?=
 =?utf-8?B?Rzk3a0I3dkovcHMzS2NoMXh4RmFOR1FSUktNRGhqLysvTnRZMGFGOCtyYnIw?=
 =?utf-8?B?Y1BVbjlkVGgrWXlHbFZISEEwaWZmQzlyZzB2WGxjdFgvc3R6Sm5VQnNBRFg0?=
 =?utf-8?B?MXlhN1ZTVlcyM2hEWVJkVno5SGpUdUtWb0VjZmFQZWUwdkdhUUJRcUxkWGph?=
 =?utf-8?B?WTBQT1ZyeGwreHZlK3NiOEdjUWNleFBQck9rd085WHFFdWN5UStWaFhMR0Jp?=
 =?utf-8?B?c3JEbSswcmFnSm1YajdtNUJ0bHZNeURjSlZoSHpFanJydkxIeWRpK01jWUFk?=
 =?utf-8?B?QnB5VFZucVhCeEZBMFgvZ3F6WkVqT0N1NzMzUnJHUFNlNTg3WE0zRExxRElj?=
 =?utf-8?B?dSsrdzRaVlBjbEZ1OVRxTzJmQnI2SUpCL0pYWWR3WmtYQzJMOVhQeHg5U0h5?=
 =?utf-8?B?K2dQNzlDOXpmUHRITk1WbkIvaGFuajhnWTg5K0lTRmtHVHlmMG0zdzNUSER5?=
 =?utf-8?B?T3p0OThUeXM2YlFxWExHL2IweUdGSTZuZkM5VWxVVEZOS2w1YVN1Ky9ZUkRi?=
 =?utf-8?B?SjRDNTgzMldPL2t2TFF5OEhLVmh1cGdSbXBSbDFjaEpIcWF1UFVsWEVMWEJB?=
 =?utf-8?B?WkxGREtFZ2lvUUlTMFllQ3F4MDc0NEdRNXhNM2RlOHc2d0d3TFRUaC9vWVFE?=
 =?utf-8?B?ME1wbGNPVjZyUFEvWmNHem5FNHZ0TW1TSXVhRzZWY0ZRc3QrZVErcUxaQjlt?=
 =?utf-8?B?SlFnc2crZHJPSXVnT2JXdEkyQkJkMFZVMVZoM3k5NmNPWFovUGhWUlUrdkRx?=
 =?utf-8?B?QlVsWEtTVDdGa01oNG8wOEhmb0hVMXZLTStwa3gyRGxsKzRVbjFnSGJlWVFu?=
 =?utf-8?B?TFk4Tk1SS2JaLzBscTZsdVB0enE4aFhrZkc2TFNwMWQ1SlRVY2V5L0h4OGMr?=
 =?utf-8?B?STRucDdLWXI2MHlzdkJmdE5aTTM3SHRRU0tWeld5Y1ZrNEZWRjZtdHBOdVJU?=
 =?utf-8?B?YWxMeVE4eFpZYmQ3VE8xL0NPcjQvM0lmWEtmS3R6NUloMHhCR0FwRDBsQ1JC?=
 =?utf-8?B?UTNKQ29OK2RpZjd5WHhsTFNEVGZJTzVQT3V6QWl6U2NmQXhMNTFRSUVhWndF?=
 =?utf-8?B?RjJ3Zm40NUFERUNGVnovRmplSzA1Yk1Tb04weE1pK2RBMmY0Um8rVDZpRys0?=
 =?utf-8?B?dlplbWFaeWliLyt4RmJhc1JZY2pqTEpJZjRzVkNPcFM2QmthRlRJZGgxejk5?=
 =?utf-8?B?KzhWZUR4QnZobEVDTjhBNklEVGh2S2NDMVhBR3RVcVBndnczYU43QnZSbWg4?=
 =?utf-8?B?bmI5Y0RYOWJWeGFXT0pHSFNoSkNOTko0T1dHbmVtRi9YVndBWDVhRGoyNlpr?=
 =?utf-8?B?RFZNYXZPZDBVU0Q0VEtRNEJuY05ZWVhpV253QmNZbmx5MExZbk5xM2JabFY0?=
 =?utf-8?B?SGwyM3JvYlI4Ny9SQ2NMR0tmenJDVlZVR0hrZmNIaDd6MmpRWmNIUmg2YmxS?=
 =?utf-8?B?V0Z3cVM0R0tiZDNYMDVNZXBxWGlDWmZDRDA3ZDMvYVpJUTdLRkZxTXQrckRu?=
 =?utf-8?B?N3ZPUVd5YVdORlE3aEFIbk9PaFh5TytXdTZxVGZNZzFmdGpPdWtEQXhZWEhs?=
 =?utf-8?B?R2tIK1F4blFmNlFSbDlWQi9XeEhVeFk0N2I4c08rL3Q5SDlLMVpiUzJhOWs3?=
 =?utf-8?B?WVlKaDIvNXRLckVWS3AxVllQWlBMOFh5ZEhGVXFkVk1iNDIzZityejE4b2gr?=
 =?utf-8?B?aTRBWkFsdXJncFl6cS9KRVU1MTEwR3JieTFoc2FaTFJ2WU9DT0JVMVdFalJm?=
 =?utf-8?B?a1JnQ3oraGIzek11eCtpVUcydGZMS0Ird0xEOStwVkFQWUduYk1FV3M5UTJs?=
 =?utf-8?B?TU5iMUd6UDhUS2pHVnN5OUh1bnJkbXNTS0ttbFRESEhxMXQ5NmVSNW5qYTZK?=
 =?utf-8?B?clo1QzRBb2dtVzRzVGh1ZmREenZqUDl1STkwNjhoTXBkb2htRGFwaExZekNF?=
 =?utf-8?B?ODhUVy8xR0l0bDlwQlhiSms2TXdSTkRWamw3K043UTUrSmJ0TWpjbjFlT1Fk?=
 =?utf-8?B?ekxSSVVPVWFjekVVdTlEeXNPZlNUeTlsSTlVdHlwL3lrbHhUWVZ5aFdjYlV6?=
 =?utf-8?B?TjJ1K0w5WU1yeEdnazJBYlZWeURpQUgzWkh3YkZ4SG5YU0VRMnNwL01YUjRN?=
 =?utf-8?B?bzlRUXdsUFYySmRzY1lJVmFIY085YXdFdDNSbWRZdkFDbVl1OHRGUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2b4293-0dac-4ff4-1a0a-08da43c71bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 12:06:07.2594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CW0MEPhcM5ATXASYd5WDZ5Cn0HWPovpnU/f6O46Mfg5GSgvXxYVvU+EqBVJCPVPCkQLdZFmFt62URxC3LuwIDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3714
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvOF0gZHQtYmluZGluZ3M6IGludGVyY29ubmVjdDogaW14
OG06IEFkZCBiaW5kaW5ncyBmb3INCj4gaW14OG1wIG5vYw0KPiANCj4gT24gMDEvMDYvMjAyMiAx
MTo0MSwgUGVuZyBGYW4gKE9TUykgd3JvdGU6DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFu
QG54cC5jb20+DQo+ID4NCj4gPiBpLk1YOE1QIGZlYXR1cmVzIHNhbWUgTm9DL05JQyBhcyBpLk1Y
OE1NL04vUSwgYW5kIHVzZSB0d28gY29tcGF0aWJsZQ0KPiA+IHN0cmluZ3MuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAg
Li4uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJjb25uZWN0L2ZzbCxpbXg4bS1ub2MueWFtbCAg
ICAgfCA2ICsrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aW50ZXJjb25uZWN0L2ZzbCxpbXg4bS1ub2MueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2ludGVyY29ubmVjdC9mc2wsaW14OG0tbm9jLnlhbWwNCj4gPiBpbmRl
eCBiODIwNGVkMjJkZDUuLjA5MjNjZDI4ZDZjNiAxMDA2NDQNCj4gPiAtLS0NCj4gPiBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcmNvbm5lY3QvZnNsLGlteDhtLW5vYy55
YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVyY29u
bmVjdC9mc2wsaW14OG0tbm9jLnlhbQ0KPiA+ICsrKyBsDQo+ID4gQEAgLTI2LDE2ICsyNiwyMiBA
QCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgb25lT2Y6DQo+ID4gICAgICAgIC0gaXRlbXM6DQo+ID4g
ICAgICAgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAgICAgICAgLSBmc2wsaW14OG1wLW5pYw0K
PiANCj4gUGxlYXNlIG9yZGVyIHRoZSBlbnRyaWVzIGFscGhhYmV0aWNhbGx5LCBzbyA4bXAgZ29l
cyBhZnRlciA4bW0uDQo+IA0KPiA+ICAgICAgICAgICAgICAgIC0gZnNsLGlteDhtbi1uaWMNCj4g
PiAgICAgICAgICAgICAgICAtIGZzbCxpbXg4bW0tbmljDQo+ID4gICAgICAgICAgICAgICAgLSBm
c2wsaW14OG1xLW5pYw0KPiA+ICAgICAgICAgICAgLSBjb25zdDogZnNsLGlteDhtLW5pYw0KPiA+
ICAgICAgICAtIGl0ZW1zOg0KPiA+ICAgICAgICAgICAgLSBlbnVtOg0KPiA+ICsgICAgICAgICAg
ICAgIC0gZnNsLGlteDhtcC1ub2MNCj4gDQo+IGRpdHRvDQo+IA0KPiA+ICAgICAgICAgICAgICAg
IC0gZnNsLGlteDhtbi1ub2MNCj4gPiAgICAgICAgICAgICAgICAtIGZzbCxpbXg4bW0tbm9jDQo+
ID4gICAgICAgICAgICAgICAgLSBmc2wsaW14OG1xLW5vYw0KPiA+ICAgICAgICAgICAgLSBjb25z
dDogZnNsLGlteDhtLW5vYw0KPiA+ICsgICAgICAtIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBj
b25zdDogZnNsLGlteDhtcC1ub2MNCj4gPiArICAgICAgICAgIC0gY29uc3Q6IGZzbCxpbXg4bS1u
b2MNCj4gPiArICAgICAgICAgIC0gY29uc3Q6IHN5c2Nvbg0KPiANCj4gVGhpcyBpcyBhIGJpdCBj
b25mdXNpbmcgLSB3aHkgdGhpcyBpcyBhbHNvIGZhbGxiYWNrZWQgYXMgc3lzY29uPw0KDQpJIHRo
b3VnaHQgdG8gZ2l2ZSBzb21lIGZsZXhpYmlsaXR5IGZvciBkcml2ZXJzIHRvIGFjY2VzcyB0aGUN
CmFkZHJlc3MgdGhyb3VnaCBzeXNjb24uIEJ1dCBpdCBjb3VsZCBiZSByZW1vdmVkLCBJIGNvdWxk
DQpmaXggaW4gVjIuDQoNClRoYW5rcywNClBlbmcuIA0KDQo+IA0KPiA+ICAgICAgICAtIGNvbnN0
OiBmc2wsaW14OG0tbmljDQo+ID4NCj4gPiAgICByZWc6DQo+IA0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiBLcnp5c3p0b2YNCg==
