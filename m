Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B855329FB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbiEXMHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiEXMHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:07:09 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84C749263;
        Tue, 24 May 2022 05:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNEh+xGxVDsDNTY18tUmJ0epVb1++t9M7DZQs7vemoqaR3i9k+NYy35su0tYyVun5TKU+LtHDc/7hk522mE5ve4DfHmNlAqHqZYzgemJOSYeUgPLYaSphD+/1zy64UCmgPDqn9JpT9ES/ka6IQyJwkdKYvIagBLe0wzVUGcZFQZMd6cH5RMvN4kFcEWhL2p1kxHBvTAMudNrUnHyeut+swZUsSJMl73mW9KS0P2crpyhaW/h2qOUowC08C8e1aZuHQ2z/qp457TlHHpXapsN1tuqy4Tj4hCPxl4R0oSS8uzLHkTAVkE3u9/DOIR0yoBh2WoCdazLBG8/054LIhJ95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tepz4Pu3Mvwuu2pLAU2BeKaamlJWEZmWIRy57oNLdJU=;
 b=asJ0+QJaHHaHbEcfJrWXjzyuFTXeLWFPLKflcPwwHsYUZS0LpcO2xPjVYp7U+eo5YS8UiuCmVMjYJGcPHFt4tDUUYRr9l80LddZEnvVwQAQk5Oxx63HCZctnGZpvTiFpr1kfcmkcFOb2VAeRuK4Y4+RrQy4IVhvqSS6vnTaLNsCA2g10Ks0fhwz/D/Ki4mGinSxDpFLGUI0eZr3miPxnz8l+X/RtCt63ZKbxFp6FN13+b+i+oELVHIxG6dS3N4ixdKb4/7qqmkKUcHxF54RFo5IIYi1LxihiX95OTw8MzgUH8z3H7KUNKERZpC5kx13PYFoMhHrJqJFhN6XD0TiCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tepz4Pu3Mvwuu2pLAU2BeKaamlJWEZmWIRy57oNLdJU=;
 b=AUh26ZyNYg25kCCnCvbzIP9LhwXMBtt9Uwr+ChieHidOaVOJKiBSLjm37Z8z802xeoVZhDmuuDEgcDgI1Hfbs6knuj8YW/AYsqhz0xiaqFzF4AZYT5CmEusZubQBby0NT0We9WEWmUtA9mQODREkxRfU7jhAVKioEtgp0kKqKoI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8821.eurprd04.prod.outlook.com (2603:10a6:10:2e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 12:07:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5273.020; Tue, 24 May 2022
 12:07:05 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Subject: RE: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93 SRC
Thread-Topic: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93 SRC
Thread-Index: AQHYbphE4hPgB8NWEUiwdYEo5yj0ra0tzvwAgAAFlVCAABKegIAACHAA
Date:   Tue, 24 May 2022 12:07:05 +0000
Message-ID: <DU0PR04MB941718AEF4D3DF64F3E551B888D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220523113029.842753-1-peng.fan@oss.nxp.com>
 <20220523113029.842753-2-peng.fan@oss.nxp.com>
 <c2882212-aa1e-4614-c982-43e6c793b34a@linaro.org>
 <DU0PR04MB9417F22B607C95BDAB84C01488D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <f42f4b45-f8cb-8855-8814-5dfaaf446d4a@linaro.org>
In-Reply-To: <f42f4b45-f8cb-8855-8814-5dfaaf446d4a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98538b28-1487-4fe1-c90f-08da3d7deb22
x-ms-traffictypediagnostic: DU2PR04MB8821:EE_
x-microsoft-antispam-prvs: <DU2PR04MB882180E2E275EF0C67AFB2E288D79@DU2PR04MB8821.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SC9VAiFlVHqcQw72aTLWBJ6VtrzSUk+8VShU9wWa35Jv28DToojIZ0/h/VTtNlAMHDWmemc3qSqqEGVK6cczqM/a3aH2iCXYbDeC7Y8iDke1vbV99/3yrnvPrrpQamJpMTAuXzGz++FpdkFbaDOYT6tRHtIWjXCnwbP6fXPcv+V3U2Y775OQOfHZ6TVxW+S9CFPbb8kkpSk57Hoi3RytOdPjINeBW4GK3K20il0JJ8yme04pBUa3gSEmxc348pi6QyPuZd3179IY5zx+FPm9v1tIp3srXRl0gFJzRGzCmGc1efOHHU7VLjzKmmJIxFhT8p42X4iZ29WzGo43scBKuyPdo/kg4C1h5U9A6Y0pMDi+92nfZWdnHQzHQPzPWdRY7k+csPsqSlNGLmXvrabx3M52vJmD9BnaYT936r1dMWnf8r3jfzxLFOxYK2GDA4DQYKMeuuVCTyrbeew+Jma26atS2JsbFVH8mYj8RSzAuxglD3RE1fdnkHpxjCM7yUogqmuClYHqaM49+cP9kt8GByAdc8N3zHCNtQR8lqoFXkEYEbAqU4u7ExYcXyLOFwPEsG8HF6jhPSckL3IW3l/lnDDt0J/teWydFeLU/OYXVYns17L4Ufdfo+Exe1OBb7y8QDcK7G2hiL+7Soe4o4w08Z5vJ0E+UPtAesyVrUW73z+KjpN+zs4D9xWsXHMx4wie/TdV2M+4Tm3+zneDmcIFig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(186003)(122000001)(38070700005)(5660300002)(508600001)(7416002)(71200400001)(66476007)(83380400001)(316002)(66946007)(7696005)(66556008)(76116006)(52536014)(4326008)(8676002)(110136005)(66446008)(86362001)(8936002)(33656002)(64756008)(44832011)(26005)(6506007)(9686003)(38100700002)(53546011)(54906003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHlCb1pLZFZQMFg1ZUs3bXFXRHhRcSttR2kybFQ0alR1WEVCYU9uV3RyYkM4?=
 =?utf-8?B?SU56bzNEeFFOaXQveE9rcElMWFlKQ3Y4MVIxRElMNmVHWWVscnl2VyswVk0x?=
 =?utf-8?B?bEFGZkxESkYzN0ZlZ2hpOEhRVjBzT29OVGtydUoyKzhBVmpnTExVTTQxZCtU?=
 =?utf-8?B?ZlRreWZITXBSaXA2UUloQkQ4U3B0L3Q1ckduemg4dElJTVRIbENSRzhsSjBk?=
 =?utf-8?B?UktUK1JadlQ0MGFrTjUzUFg4eG1xYkZNQ3ZBeU11ZzgrUUJzZUFielpDOU1E?=
 =?utf-8?B?TkpWMFdIdEJSSzhpTkNIQXZCUkxoVXVuRFF6aHZHWVJacFZCVmw2M2ZpME10?=
 =?utf-8?B?SUtHMnhtTnhScnRHVHRkWkcycmhXVGR2NkJXU1pjcTRiWmVwUitlUVRGc0xT?=
 =?utf-8?B?WExoRHBDZFlNSzJCUENjNXFTbU41T3VVOUM4SVN0bUE2ZEdlU0hVaWhVNWNG?=
 =?utf-8?B?cW5DbFNGbmRxVXlMYVhoV2Q5M2ZHUkNLdElCdTE4N2VQakpvZDJrRGh0WlN6?=
 =?utf-8?B?bU14eWFxbzJiemtFbWZlZGx1N0t3aUlNUCtjdDRTdndvcGs3cFcvNVorSzBt?=
 =?utf-8?B?eHlyT09TVkttZm1EZGljcGRFY2hENnIwTGpLd0swTC9uMHRnb0duT25zbDZ5?=
 =?utf-8?B?OWVqS00vaEY1ako0RUpuQndzckphWHh3QWJkMEl1YTE0ZXpaL0JDdTdXOVhn?=
 =?utf-8?B?WnJyM0J5eVRxTHpLTjZKMFhhU0R5MERXQk9xaWVqZlhYYVBNem13TVpqMkRx?=
 =?utf-8?B?aHIzR3YwVC9OTDYrSVhJQXk2TXdOVm5HMWtKWm9JUitUWU1LNkViT3gvaVRa?=
 =?utf-8?B?bno1dk02bWRQOEl4ZFdUN01NWFJTaVVqMnVGMTAxWENHUU15dkp0c1R6d01j?=
 =?utf-8?B?VzE3eGJnVDg5VUdkVktqTFBpTFA4ZjY2RmZkZ0g3d1VrMVJNY3NZbWZmWmxh?=
 =?utf-8?B?ckxKVks0NDVudnBmdCt0eVlCZjRsQlRlZGZOb3h0M2hrZFBYVk5zNWVNOXY4?=
 =?utf-8?B?Q1BwbC9Fek1NVHQxTURWMGhMbkVHUnJhVWRFWDhSMG8reTV2Ri9YdGlzMTFl?=
 =?utf-8?B?aVhpZ0Vnd0JJRndrV0RpdktOMmxkNGZIbmY5bnlRdzV2dC8zWnpIbytTdXJq?=
 =?utf-8?B?UFFzRUcrL09VVTB5VWJUaDJmdEpLVS8yUkhjWUtLMzhMelUxL0ltNUZoSCtT?=
 =?utf-8?B?bzczZlp3dy9nd1BXaUgyWlZaN0E0NUdpWmFXQXJtblhBNTZneldqdHBVM1hU?=
 =?utf-8?B?VE5oaXJoaGdzMlNwZEU2cUhXS3NoT2RpT01DZ1JFVkpXUlpPWC9YRzllRm1G?=
 =?utf-8?B?SUxRQlFYVEM2VFM1bFNaQVQ4QWM3ckJqZXNWNXl1czNsR25BRHpUZUtxZDdt?=
 =?utf-8?B?QXprYW0wN0FNNWhJbm9LQ3BWK0hlRTc5S2tyY3N5V2QvdWZnYlo3Ynd4SmNY?=
 =?utf-8?B?VXF4NXdUQkxhTFhpS09aQ29rajYyeE1TTUh2bytBckZ1bXF0dmN4NVluRzJ4?=
 =?utf-8?B?eWJrcVdhdXRUS1ZUQmFoaFJna0UwbFBrU2RCYkFFMnBreW5lODdOOURQRjJQ?=
 =?utf-8?B?cWFJalNSWGRRRGN5bkVDVkY1eE11U1Y1K2IyMW5uVisxWldDVXZRYzBROGtR?=
 =?utf-8?B?RmFGSmNRczdzNWhhYk9xN2dTT2RtclE5RmFET2QxdnVRdTJLRWxwY2xucGhM?=
 =?utf-8?B?RHRDYmRpUFFOYlJwUFpwb1NkL0JWbEMzUUxXRUJkb2QyNlJyQnhkK0JTdENh?=
 =?utf-8?B?RkRlWTQrRXl6QUtlY0pYNENxL0xFKzdxby9vTHpldTVPYmtRUHdyd0VlU1FR?=
 =?utf-8?B?M2pjUkdOaTUwOG9DdXdZMS9UOE13MUtITkhMS0VtYjFiRGpLYVhoWHNJWklz?=
 =?utf-8?B?UkZ0OGVmbS9LTGJFLzhUQlJsdDZaVHpZcEdFN3FBMmx1d1NCU2ZFUGpvYmx0?=
 =?utf-8?B?MGIzZHJFem9UQXFuL2xpZ3p2Mm5aTnl2U214eUI1eVVJZURyWDhFY3h4UUYw?=
 =?utf-8?B?SVdGT2pBYVV0R0VCdGNsdndiTUhTU2h1YVE3ckZXTzRxMjhlREpXOHZQMUVM?=
 =?utf-8?B?dGk5MzR4NFRNWXVjaUt1WnpjUDVMcUVHQ1YwdHg0a0NtSGI0UEtyaHY0T2Jl?=
 =?utf-8?B?VjVRMklyTVZvZWRia3VzYy8yeVVBYVorMVFGTjNxN08wRmVuWXJtY25na2RB?=
 =?utf-8?B?UVQ1aDBFK21pRnZzK05paTVtdWJwRXVmRWV6SWZGUERlQ0RsMEJFOXB0YmxW?=
 =?utf-8?B?dU9FVnZRTi9hNUZEc0JZSmplalVGOGZ2dWFuYVU2dHdoYkpoYVJka2ZzOFBa?=
 =?utf-8?B?dW03WUdobU8xYmthYTdRSTU3ejF1cDVha2loby8xWnRzTnpObk5jdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98538b28-1487-4fe1-c90f-08da3d7deb22
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 12:07:05.0853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJo5QYd/iXDl/X2qtRWRXXgbjdeApnJbA3hIBfRg3XnsI7FHgnIxsmNMg8hUTgjc+21vud4YCiRFAd87hvnLhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8821
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvN10gZHQtYmluZGluZ3M6IHNvYzogYWRkIGJpbmRpbmdz
IGZvciBpLk1YOTMgU1JDDQo+IA0KPiBPbiAyNC8wNS8yMDIyIDEyOjM3LCBQZW5nIEZhbiB3cm90
ZToNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzddIGR0LWJpbmRpbmdzOiBzb2M6IGFkZCBi
aW5kaW5ncyBmb3IgaS5NWDkzDQo+ID4+IFNSQw0KPiA+Pg0KPiA+PiBPbiAyMy8wNS8yMDIyIDEz
OjMwLCBQZW5nIEZhbiAoT1NTKSB3cm90ZToNCj4gPj4+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZh
bkBueHAuY29tPg0KPiA+Pj4NCj4gPj4+IEFkZCBiaW5kaW5ncyBmb3IgaS5NWDkzIFN5c3RlbSBS
ZXNldCBDb250cm9sbGVyKFNSQykuIFNSQyBzdXBwb3J0cw0KPiA+Pj4gcmVzZXRzIGFuZCBwb3dl
ciBnYXRpbmcgZm9yIG1peGVzLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgLi4uL2JpbmRpbmdzL3NvYy9p
bXgvZnNsLGlteDkzLXNyYy55YW1sICAgICAgIHwgODgNCj4gPj4gKysrKysrKysrKysrKysrKysr
Kw0KPiA+Pj4gIGluY2x1ZGUvZHQtYmluZGluZ3MvcG93ZXIvaW14OTMtcG93ZXIuaCAgICAgICB8
IDExICsrKw0KPiA+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgOTkgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+Pj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NvYy9pbXgvZnNsLGlteDkzLXNyYy55YW1sDQo+ID4+DQo+ID4+IEZpbGUgc2hvdWxkIGJl
IGluIHJlc3BlY3RpdmUgc3Vic3lzdGVtLCBzbyBwcm9iYWJseSBwb3dlci9yZXNldD8NCj4gPg0K
PiA+IG9rLCB3aWxsIHB1dCB1bmRlciBwb3dlci4NCj4gPg0KPiA+Pg0KPiA+Pj4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL2lteDkzLXBvd2VyLmgNCj4gPj4+
DQo+ID4+PiBkaWZmIC0tZ2l0DQo+ID4+PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9zb2MvaW14L2ZzbCxpbXg5My1zcmMueWFtbA0KPiA+Pj4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc29jL2lteC9mc2wsaW14OTMtc3JjLnlhbWwNCj4gPj4+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+ID4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmQ0NWMxNDU4YjljMQ0K
PiA+Pj4gLS0tIC9kZXYvbnVsbA0KPiA+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NvYy9pbXgvZnNsLGlteDkzLXNyYy55YW1sDQo+ID4+PiBAQCAtMCwwICsxLDg4
IEBADQo+ID4+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBC
U0QtMi1DbGF1c2UpICVZQU1MIDEuMg0KPiA+Pj4gKy0tLQ0KPiA+Pj4gKyRpZDoNCj4gPj4+ICs+
ID4gK3RpdGxlOiBOWFAgaS5NWDkgU3lzdGVtIFJlc2V0IENvbnRyb2xsZXINCj4gPj4+ICsNCj4g
Pj4+ICttYWludGFpbmVyczoNCj4gPj4+ICsgIC0gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+
DQo+ID4+PiArDQo+ID4+PiArZGVzY3JpcHRpb246IHwNCj4gPj4+ICsgIFRoZSBTeXN0ZW0gUmVz
ZXQgQ29udHJvbGxlciAoU1JDKSBpcyByZXNwb25zaWJsZSBmb3IgdGhlDQo+ID4+PiArZ2VuZXJh
dGlvbiBvZg0KPiA+Pj4gKyAgYWxsIHRoZSBzeXN0ZW0gcmVzZXQgc2lnbmFscyBhbmQgYm9vdCBh
cmd1bWVudCBsYXRjaGluZy4NCj4gPj4+ICsNCj4gPj4+ICsgIEl0cyBtYWluIGZ1bmN0aW9ucyBh
cmUgYXMgZm9sbG93cywNCj4gPj4+ICsgIC0gRGVhbHMgd2l0aCBhbGwgZ2xvYmFsIHN5c3RlbSBy
ZXNldCBzb3VyY2VzIGZyb20gb3RoZXIgbW9kdWxlcywNCj4gPj4+ICsgICAgYW5kIGdlbmVyYXRl
cyBnbG9iYWwgc3lzdGVtIHJlc2V0Lg0KPiA+Pj4gKyAgLSBSZXNwb25zaWJsZSBmb3IgcG93ZXIg
Z2F0aW5nIG9mIE1JWHMgKFNsaWNlcykgYW5kIHRoZWlyIG1lbW9yeQ0KPiA+Pj4gKyAgICBsb3cg
cG93ZXIgY29udHJvbC4NCj4gPj4+ICsNCj4gPj4+ICtwcm9wZXJ0aWVzOg0KPiA+Pj4gKyAgY29t
cGF0aWJsZToNCj4gPj4+ICsgICAgaXRlbXM6DQo+ID4+PiArICAgICAgLSBjb25zdDogZnNsLGlt
eDkzLXNyYw0KPiA+Pj4gKyAgICAgIC0gY29uc3Q6IHN5c2Nvbg0KPiA+Pj4gKw0KPiA+Pj4gKyAg
cmVnOg0KPiA+Pj4gKyAgICBtYXhJdGVtczogMQ0KPiA+Pj4gKw0KPiA+Pj4gKyAgc2xpY2U6DQo+
ID4+DQo+ID4+IFdoeSBkbyB5b3UgbmVlZCB0aGlzIHN1Ym5vZGUsIGluc3RlYWQgb2YgbGlzdGlu
ZyBkb21haW5zIGhlcmU/DQo+ID4NCj4gPiBJIGZvbGxvdw0KPiA+IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wb3dlci9mc2wsaW14LWdwY3YyLnlhbWwNCj4gPg0KPiA+IFRoZXJl
IGFyZSBzZXZlcmFsIHNsaWNlcyBpbiBTUkMsIGp1c3QgbGlrZSB0aGVyZSBhcmUgbWFueSBwZ2Nz
IGluIGdwY3YyLg0KPiANCj4gV2FpdCwgYnV0IHlvdSBoYXZlIG9ubHkgb25lIHNsaWNlIGFuZCB5
b3UgZG8gbm8gYWxsb3cgbW9yZSBvZiB0aGVtLiANCg0KU2xpY2UgaXMganVzdCBhIGdyb3VwIG5v
ZGUgdGhhdCBjb3VsZCBpbmNsdWRlIG1hbnkgY2hpbGQgbm9kZXMsDQpzdWNoIGFzIA0Kc2xpY2Ug
ew0KICBtZWRpYW1peCB7DQogIH07DQogIG1sbWl4IHsNCiAgfTsNCn0NCg0KVGhlIHNhbWUNCj4g
YXMgZm9yIGdwY3YyIC0gdGhlcmUgaXMgb25seSBvbmUgcGdjLiBXaGF0J3MgdGhlIHBvaW50IG9m
IHRoYXQgbm9kZT8NCg0KVGhlcmUgYXJlIG1hbnkgcGdjcywgcGdjIGlzIGp1c3QgYSBncm91cCBu
b2RlIHRoZXJlLA0KU2VlIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNp
Lg0KDQo+IA0KPiA+DQo+ID4NCj4gPj4NCj4gPj4+ICsgICAgdHlwZTogb2JqZWN0DQo+ID4+PiAr
ICAgIGRlc2NyaXB0aW9uOiBsaXN0IG9mIHBvd2VyIGRvbWFpbnMgcHJvdmlkZWQgYnkgdGhpcyBj
b250cm9sbGVyLg0KPiA+Pj4gKw0KPiA+Pg0KPiA+PiBIbSwgd2hhdCBhYm91dCBhZGRyZXNzL3Np
emUgY2VsbHM/IElzIHN5c2NvbiBzY2hlbWEgYnJpbmdpbmcgdGhlc2U/DQo+ID4NCj4gPiBUaGUg
c2xpY2Ugc3VibW9kZSBzaG91bGQgaGF2ZSBhZGRyZXNzL3NpemUgY2VsbHMsIGJ1dCBJIG5vdCBt
ZWV0DQo+ID4geWFtbC9kdGJzIGNoZWNrIGVycm9yLiBXaWxsIGFkZCBpdC4NCj4gPg0KPiA+IE5v
dCBzdXJlIHN5c2NvbiBicmluZ2luZyBvciBub3QuDQo+ID4NCj4gPj4NCj4gPj4+ICsgICAgcGF0
dGVyblByb3BlcnRpZXM6DQo+ID4+PiArICAgICAgInBvd2VyLWRvbWFpbkBbMC05XSQiOg0KPiA+
Pj4gKyAgICAgICAgdHlwZTogb2JqZWN0DQo+ID4+DQo+ID4+IE1pc3NpbmcgcmVmIHRvIHBvd2Vy
LWRvbWFpbi55YW1sDQo+ID4NCj4gPiBPay4NCj4gPg0KPiA+Pg0KPiA+Pj4gKyAgICAgICAgcHJv
cGVydGllczoNCj4gPj4+ICsNCj4gPj4+ICsgICAgICAgICAgJyNwb3dlci1kb21haW4tY2VsbHMn
Og0KPiA+Pj4gKyAgICAgICAgICAgIGNvbnN0OiAwDQo+ID4+PiArDQo+ID4+PiArICAgICAgICAg
IHJlZzoNCj4gPj4+ICsgICAgICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiA+Pj4gKyAgICAgICAg
ICAgICAgUG93ZXIgZG9tYWluIGluZGV4LiBWYWxpZCB2YWx1ZXMgYXJlIGRlZmluZWQgaW4NCj4g
Pj4+ICsgICAgICAgICAgICAgIGluY2x1ZGUvZHQtYmluZGluZ3MvcG93ZXIvaW14OTMtcG93ZXIu
aCBmb3INCj4gZnNsLGlteDkzLXNyYw0KPiA+Pj4gKyAgICAgICAgICAgIG1heEl0ZW1zOiAxDQo+
ID4+PiArDQo+ID4+PiArICAgICAgICAgIGNsb2NrczoNCj4gPj4+ICsgICAgICAgICAgICBkZXNj
cmlwdGlvbjogfA0KPiA+Pj4gKyAgICAgICAgICAgICAgQSBudW1iZXIgb2YgcGhhbmRsZXMgdG8g
Y2xvY2tzIHRoYXQgbmVlZCB0byBiZSBlbmFibGVkDQo+ID4+PiArICAgICAgICAgICAgICBkdXJp
bmcgZG9tYWluIHBvd2VyLXVwIHNlcXVlbmNpbmcgdG8gZW5zdXJlIHJlc2V0DQo+ID4+PiArICAg
ICAgICAgICAgICBwcm9wYWdhdGlvbiBpbnRvIGRldmljZXMgbG9jYXRlZCBpbnNpZGUgdGhpcyBw
b3dlcg0KPiBkb21haW4uDQo+ID4+PiArICAgICAgICAgICAgbWluSXRlbXM6IDENCj4gPj4+ICsg
ICAgICAgICAgICBtYXhJdGVtczogNQ0KPiA+Pj4gKw0KPiA+Pj4gKyAgICAgICAgcmVxdWlyZWQ6
DQo+ID4+PiArICAgICAgICAgIC0gJyNwb3dlci1kb21haW4tY2VsbHMnDQo+ID4+PiArICAgICAg
ICAgIC0gcmVnDQo+ID4+PiArDQo+ID4+PiArcmVxdWlyZWQ6DQo+ID4+PiArICAtIGNvbXBhdGli
bGUNCj4gPj4+ICsgIC0gcmVnDQo+ID4+PiArICAtIHNsaWNlDQo+ID4+PiArDQo+ID4+PiArYWRk
aXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4+PiArDQo+ID4+PiArZXhhbXBsZXM6DQo+ID4+
PiArICAtIHwNCj4gPj4+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL2lteDkzLWNs
b2NrLmg+DQo+ID4+PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9wb3dlci9pbXg5My1wb3dl
ci5oPg0KPiA+Pj4gKw0KPiA+Pj4gKyAgICBzcmNANDQ0NjAwMDAgew0KPiA+Pg0KPiA+PiByZXNl
dC1jb250cm9sbGVyDQo+ID4+IG9yIHNvbWUgb3RoZXIgZ2VuZXJpYyBub2RlIG5hbWUuDQo+ID4N
Cj4gPiBJdCBpcyBub3QgYSBzaW5nbGUgcmVzZXQgb3IgcG93ZXIgZG9tYWluIGNvbnRyb2xsZXIs
IEN1cnJlbnRseSBsaW51eA0KPiA+IGRyaXZlciBqdXN0IHVzZSBpdCBhcyBhIHBvd2VyIGRvbWFp
biBjb250cm9sbGVyLg0KPiANCj4gVGhlbiBtYXliZSBzeXN0ZW0tY29udHJvbGxlci4NCg0KT2su
DQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gUGVuZy4NCj4g
Pg0KPiA+Pg0KPiA+Pj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14OTMtc3JjIiwgInN5
c2NvbiI7DQo+ID4+PiArICAgICAgICByZWcgPSA8MHg0NDQ2MDAwMCAweDEwMDAwPjsNCj4gPj4+
ICsNCj4gPj4+ICsgICAgICAgIHNsaWNlIHsNCj4gPj4+ICsgICAgICAgICAgICAgICAgI2FkZHJl
c3MtY2VsbHMgPSA8MT47DQo+ID4+PiArICAgICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+
Ow0KPiA+Pj4gKw0KPiA+Pj4gKyAgICAgICAgICAgICAgICBtZWRpYW1peDogcG93ZXItZG9tYWlu
QDAgew0KPiA+Pg0KPiA+PiBCZXN0IHJlZ2FyZHMsDQo+ID4+IEtyenlzenRvZg0KPiANCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=
