Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDA758FF9B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbiHKPbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbiHKPbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:31:05 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60074.outbound.protection.outlook.com [40.107.6.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B583AE4E;
        Thu, 11 Aug 2022 08:30:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt4U33WbrNQOpnu00gyrJ1/r+/ZWInNsGVh9rkXI2CYbWdME9aHTf7sZiS7BC1h+qxMECFI5kxFm9ysFWNGZD2q8TaK+SBQKGdfxkHNlvajY0PUH0vlt4gFqQucDmchi2c1fU+rVHgl/oEooroFEA51fbwOUWxNuX1HnuImn/nBnE0Bvs7UzZ2vzQrNe6RE6IOeGwMsB0cDJXTnH9+JkjdNyqutSTDPKP3CzU/w5aR5gHjeqooRZaLbuOc4FuHLuDLIQ0iyJa5gdWbqPfPK2mDHrY9d+YHN0xPeX/Jr8bhlXxfozH336PJXR+/9WauRluX5OvIC8IEsSW9UjZi1ZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCeJeO7N78hPS4XKpiFdZhgcbTZvjuAO4/uOAqE6Bww=;
 b=PzID/RlNbz5U3zVRsUpaxOr9LSW1sQZAa5PzkHTWntmNX8u9arzfZ5WoAEw+jklL1kRtqFzLWy41JqTXw/XNLxPxOf4vep877Gkd3y1PbbMeL+erxQ8rhnsu13hUkDNflIVWv2axFd4yEiacXbO69oB0flVOeIOQft4J020nETZ+w3Sr9f1DTMjkFvQHybKTMUTCApmxOt7hW8OIxFgsBMIUTpyzVCOXqH18mmr/UJ8nB0Eopl0MfZs6dWEl5CSqdFweRPTeyBufHettCiSrMY8W0h4WZqOWF+nvkSMfmd3SzaM6djmJH6vbtY9A2Kmc3A97YE6dzWVsLAb2Zsq0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCeJeO7N78hPS4XKpiFdZhgcbTZvjuAO4/uOAqE6Bww=;
 b=SJvMN0j1YNreBbjKUJ+KBr+yu6FGQsFiuxk1vZMn29BNq29dxM2j1OaNh+lRn4DkhInBvUoiuDO4iNzbX62s2Uj6rFdCC/scGCX5/C1hSu8W3tGBX5Uc4PiD4iCJWujJph2/4CILgF0HtM195PvJTT3Je/Y37mnKfBhWv7XVM/w=
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by AS8PR04MB8980.eurprd04.prod.outlook.com (2603:10a6:20b:42f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.23; Thu, 11 Aug
 2022 15:30:13 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 15:30:12 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v4 1/3] dt-bindings: gpio: Add imx scu gpio
 driver bindings
Thread-Topic: [EXT] Re: [PATCH v4 1/3] dt-bindings: gpio: Add imx scu gpio
 driver bindings
Thread-Index: AQHYrX/efnr9amG8xk2M44gwbstyBq2pxDyAgAADc/CAAAZVAIAABNxw
Date:   Thu, 11 Aug 2022 15:30:12 +0000
Message-ID: <AM9PR04MB82747D7D07C481CC6981993189649@AM9PR04MB8274.eurprd04.prod.outlook.com>
References: <20220811124135.95299-1-shenwei.wang@nxp.com>
 <20220811124135.95299-2-shenwei.wang@nxp.com>
 <db3020ef-7321-e171-b5bc-9c1795c2cced@linaro.org>
 <AM9PR04MB82741882E177387DB95AE3B589649@AM9PR04MB8274.eurprd04.prod.outlook.com>
 <01c832c4-6631-4865-30b3-7f060e27a7ff@linaro.org>
In-Reply-To: <01c832c4-6631-4865-30b3-7f060e27a7ff@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab585fe6-e2b3-4b1b-6b22-08da7bae623a
x-ms-traffictypediagnostic: AS8PR04MB8980:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tMHQLjCFUAVTy+jt9OfzJdSMOqZ5fGFSzV4GdGJ9VG6uulKlj53mus0jqmd7g+gPDTUJ7KKGUUIoA0Q+c1Q/V/Dvn228VVSCVQTAk2aX48+v2MqpwxDvqEeb0SJ2x7xt84HAKByMdgdrhzHudzswje5SNxm/Nb59K6nwE2syqCfAGnE9H2/+urDwPzmtZuevHiUoheD2lD5Vi3P8IsD8MyhzsezxvxuHD5DxnILxFIxbERYhCheATVd4tqDMQvS14hqd29Xd5e+JTHRPUsYb1fDg7hz1AY+gcLNJcEc4D+Odbdq0NfnjdcIdcGvTSqtG0XK2tTm0gKv9X3YBXi3L2Zkmg2kTYZ5j9Z/X18GkK75KjP/19mKRpGt+xTm5VEZGP6cMXVAGwne8MuoPPWASWONU0I1AgusVp0c4tN/dQlxvqN3cKQsFpu9HRSqiY21Xb7TE25/DPYTLgZxv5SSOidT63D6Z4NbsrHn9bh6VMiO3IxuYujLsYQM6fGhdr9Ip1RH5hvoBJD+zwtpYZV4B5B0rY0FJDe23Ho9xw3H5qtCVT+9vJkqfTTvHb8PhAQcVXEeHLlEfqMnuOTj4b/XGiwfkZZqygeP4UhBcnsTOeQYrV0BrZFezi6RNThJoIlOaFXwAWs9RLOmXhg6Fnq0+kvATseiYjjLOCVIYeOpImMnRY2OrvglqVmc7PPWJpeDm9do+UkS+kh/7pwesJyPHktseWwsVpAuzrFnzut2eI10ckF4saQqtZJfQrfGXxTqomVCkj8MX+pbXqzvneulAdO08f9o9+GolAeWiXrVo+TXOsONfgrEUSH60eI8JNIdjVC8SJET0BKpYV3RKXRos9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(316002)(8936002)(38100700002)(921005)(6636002)(54906003)(110136005)(52536014)(55016003)(7416002)(86362001)(5660300002)(38070700005)(66556008)(66446008)(64756008)(66476007)(4326008)(8676002)(76116006)(9686003)(55236004)(26005)(83380400001)(186003)(71200400001)(66946007)(478600001)(122000001)(7696005)(6506007)(44832011)(41300700001)(2906002)(33656002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmVUZWY5R2x2bUZoK3dOd3BPalZYMm5Pa3BaRStITDNGRU1LY09tZzZ1aEZB?=
 =?utf-8?B?MmtLaTNlVm85eVl5SE5xY1VKaE1EajhBSjR5bUk1SEZaamRydjZjNi84NE8y?=
 =?utf-8?B?NzVmR3c1Slg3cWs2MUU0QWJJMFA0ZjlqOHl3NVRkQkZuaU9KWnNxaC9qZWNL?=
 =?utf-8?B?SjZ6aXJYMmE3OG52dnFUUmhmUFBFd0xPZlVPN0pwd2tUckFFNmpxK3dXYzFu?=
 =?utf-8?B?ai90V0pjMzdwekVuakUvd1lGdVk1eWxxbGxvQUZEYmVpS1pDNzc4amYvdHQv?=
 =?utf-8?B?aEY5VndaNGttcUhZNjlwZVYya3crbGpTditqS0ZxV0M5TW8xKzc2blZ6Y2JW?=
 =?utf-8?B?NnFMU203OGhTbTMwMlYwYjJhNzNRd1N1SUFUa0xLT0hDOGtjb1ZORFdkMTJi?=
 =?utf-8?B?TnpMUWZMWmZoMlhub0tYL0M2RGdiUUViVG5VN2lwNlJzN1ZJRHNUVjhWbnh0?=
 =?utf-8?B?UmRQNGUzNFMxU3ZxSWY4b0hSSTUvT0k5dU4zNUxXK3BTeDZzRFVaQzhEOThO?=
 =?utf-8?B?N2RWMjVYemx1OXZPNXl0dnRHR1RLa000SUczQ3k1TUpuMmVSdmFuN1NhM2Yx?=
 =?utf-8?B?bnRwUHcxbStjRFFPejJQMlVsZm9JSG0rSkg2K3dZSXZjekVmQTZ2MjYrRWZS?=
 =?utf-8?B?VnZjejRQdzZPdUJmU0JvMDZBWW1iclY4MTBqUEZ4ejE3N0dyN3R1WWFaWWs2?=
 =?utf-8?B?aHplRThzMjc1REF6RVVWeEFsb0VUbGpORHRHeUJvR0Nvb3lIcStqSDVvWHZM?=
 =?utf-8?B?WHNmRXd1Y0IycitvOWI1dGhJM2IxZU9hbUVXVnBCd2pHMzNwc0hqUnd5VEEz?=
 =?utf-8?B?QnM1enQ1RHdHNktyRUJWZExiSzJPS2RRamhhVkVPVjdpcE1LY21jS0pKNWZw?=
 =?utf-8?B?VGx3R0d1UzdmVWd2VDFBNHVkaFF0OEljMXFjZ2FMY1dBM0kydENCMXR5WHNK?=
 =?utf-8?B?MFhQVkZMMUVvT3ZtbXBDdnd4Y0Z1NnNDMkdTKzVvdGxTUFJUTlc0Y1ozdzR0?=
 =?utf-8?B?bXU4RG1tTHdidDY5OHk0SFBPVTJrekhtK2pMcHhyRWk2QjNIdG5SOFhRdEpS?=
 =?utf-8?B?SjZMampEcEc3c1lIOFhvK1NISEFiazBERnZDU2xWTXgwTWk4TldGOURGUW1B?=
 =?utf-8?B?YVRBLzNaOHpUa21IRU9Xak9WZEhpUS92aWZpU2p5cjdNYnkwaDNoZzE4cERS?=
 =?utf-8?B?Z2FKVlRIWkFudHBHQUgxRW5Xekw5bC9IUFFUR0ZFek1saW9Vay9qSlhzYzJX?=
 =?utf-8?B?bnpDMnZRd2lPSzJ2Sk9ZR2d3MWUvMzZiaURLZGJSYWZYNG0zWFEyekhpbFRL?=
 =?utf-8?B?VE90U0NzVHJSd2FDcHV1dGtLV2Z0T1JBdjc4NWhTNUpNYkNsbGhSc2k3b2lB?=
 =?utf-8?B?VXJxV3BSOTVjaVZETjBlbXcvMm0zMkZvQ3doMG1yb1FaeXlrSzFseVhSNVVn?=
 =?utf-8?B?UDRNcFRKUG9Vei8xRUJTVHZjYjlteWltNlI3OUNXY082SDJHSWt0Qi9FNEpF?=
 =?utf-8?B?Njlhb0RIQzFTc25Ma2pyeFpqRG5aNmVTZ2hPUXF0VDBuWVpJQTJWaFdRN0hH?=
 =?utf-8?B?WWd0UHdtMHNXME80a2puRE9TVHQvV0xLWkFSeUtrWjhaN2tlbnRtRXRIaGpn?=
 =?utf-8?B?eWlCbzBzell2eFpOQVNVcmx5bDRzOVNtblJQOG9zVHdGeHBmY1R0aXFLeHky?=
 =?utf-8?B?cytuYmF6NHF4RXBWdllLM2FpK1BJNEVlLzdmUktpTzBxeWkxdWJhUzBmaERI?=
 =?utf-8?B?d2NWQnI5WjRkRlZpL0RQclJEN1JUWGVocldrc2YveFlRamorb3hjdWRJdkYz?=
 =?utf-8?B?dk1meGlPZFdjM0dnalN0RFpFcWJ2QTR6K3VBRUpwRnhyT2M0eUFjSVBPOVY0?=
 =?utf-8?B?YWZvT3pSK0owdmliREtXT0NDdGFRUHhWR1FSbVB1Rm56SnFkamhqVlZJK3Ni?=
 =?utf-8?B?RUxEV3ZSUXNuTUY0ZW9nU1B5NlJDQkRkc2ZSUlg3Y0w2ZG9TeE5PMm9yOEVv?=
 =?utf-8?B?WXBLeWc2d1gvSEN4NXh1YVBtbXFqTTN6STc1YTlvOTE3NWdXNGZHVk56SDBq?=
 =?utf-8?B?YSs4M2VZSHRHdGR5bytTbDlMNFF2b1ZPaDBZbHkrTGtOeDkrQkVWc2NCTDBL?=
 =?utf-8?Q?KlbQW4OlhlVv0bCRvUY1A6sHa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab585fe6-e2b3-4b1b-6b22-08da7bae623a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 15:30:12.8555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JWphqwcROiZESmLsRFMIC3TvbS+fLr7HG0EnrfV7jQYfue8YHgt1n79jTxoJGQjgS+gNkKkB1P77QHBY82fK2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8980
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwg
QXVndXN0IDExLCAyMDIyIDEwOjExIEFNDQo+IFRvOiBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2Fu
Z0BueHAuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0
QGxpbmFyby5vcmc7IGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZzsgYnJnbEBiZ2Rldi5wbDsNCj4g
c2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1
dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgtaW14
QG54cC5jb20+DQo+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGdwaW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3Vi
amVjdDogUmU6IFtFWFRdIFJlOiBbUEFUQ0ggdjQgMS8zXSBkdC1iaW5kaW5nczogZ3BpbzogQWRk
IGlteCBzY3UgZ3BpbyBkcml2ZXINCj4gYmluZGluZ3MNCj4gDQo+IENhdXRpb246IEVYVCBFbWFp
bA0KPiANCj4gT24gMTEvMDgvMjAyMiAxNzo1MiwgU2hlbndlaSBXYW5nIHdyb3RlOg0KPiA+DQo+
ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiA+PiBTZW50OiBU
aHVyc2RheSwgQXVndXN0IDExLCAyMDIyIDk6MzYgQU0NCj4gPj4gVG86IFNoZW53ZWkgV2FuZyA8
c2hlbndlaS53YW5nQG54cC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+ID4+IGtyenlzenRv
Zi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgbGludXMud2FsbGVpakBsaW5hcm8ub3JnOw0KPiA+
PiBicmdsQGJnZGV2LnBsOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4
LmRlOw0KPiA+PiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwt
bGludXgtaW14DQo+ID4+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPj4gQ2M6IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
Pj4gZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsNCj4gPj4gaW14QGxpc3RzLmxpbnV4LmRldg0KPiA+PiBTdWJqZWN0OiBbRVhUXSBSZTog
W1BBVENIIHY0IDEvM10gZHQtYmluZGluZ3M6IGdwaW86IEFkZCBpbXggc2N1IGdwaW8NCj4gPj4g
ZHJpdmVyIGJpbmRpbmdzDQo+ID4+PiBkaWZmIC0tZ2l0DQo+ID4+PiBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL2ZzbCxpbXgtc2MtZ3Bpby55YW1sDQo+ID4+PiBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL2ZzbCxpbXgtc2MtZ3Bpby55YW1s
DQo+ID4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi5h
MWIwMjRjZGRjOTcNCj4gPj4+IC0tLSAvZGV2L251bGwNCj4gPj4+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL2ZzbCxpbXgtc2MtZ3Bpby55YW1sDQo+ID4+PiAr
ZGVzY3JpcHRpb246IHwNCj4gPj4+ICsgIFRoaXMgbW9kdWxlIHByb3ZpZGVzIHRoZSBzdGFuZGFy
ZCBpbnRlcmZhY2UgdG8gY29udHJvbCB0aGUNCj4gPj4+ICsgIHJlc291cmNlIHBpbnMgaW4gU0NV
IGRvbWFpbiBvbiBpLk1YOCBwbGF0Zm9ybXMuDQo+ID4+PiArDQo+ID4+PiArcHJvcGVydGllczoN
Cj4gPj4+ICsgIGNvbXBhdGlibGU6DQo+ID4+PiArICAgIGVudW06DQo+ID4+PiArICAgICAgLSBm
c2wsaW14OHF4cC1zYy1ncGlvDQo+ID4+DQo+ID4+IE5vdyB0aGUgZmlsZW5hbWUgZG9lcyBub3Qg
bWF0Y2ggY29tcGF0aWJsZS4gVXNlIHRoZSBzYW1lIGNvbXBhdGlibGUNCj4gPj4gYXMgZmlsZW5h
bWUuDQo+ID4NCj4gPiBUaGUgc3Vibm9kZXMgdW5kZXIgZnNsLHNjdS55YW1sIGhhdmUgdGhlaXIg
b3duIG5hbWluZyBydWxlLiBGb3INCj4gPiBleGFtcGxlLCB0aGUgd2F0Y2hkb2cgY29tcGF0aWJs
ZSBpcyAiZnNsLGlteC1zYy13ZHQiLCBidXQgdGhlIGZpbGUgbmFtZSBpcw0KPiAiZnNsLHNjdS13
ZHQueWFtbCIuDQo+IA0KPiBUaGUgb3RoZXIgZmlsZXMgaGF2ZSBmb3IgZXhhbXBsZSBmc2wsaW14
LXNjLXdkdCwgc28gdGhleSBtYXRjaCBjb21wYXRpYmxlLg0KDQpJIGRvbid0IHNlZSB0aGUgZmls
ZSBmc2wsaW14LXNjLXdkdCB5b3UgbWVudGlvbmVkIHVuZGVyIHRoZSB3YXRjaGRvZyBkaXJlY3Rv
cnkuDQoNCiQgbHMgZnNsKg0KZnNsLWlteDd1bHAtd2R0LnlhbWwgIGZzbC1pbXgtd2R0LnlhbWwg
IGZzbCxzY3Utd2R0LnlhbWwNCg0KUmVnYXJkcywNClNoZW53ZWkNCg0KPiANCj4gPiBJcyB0aGUg
ZmlsZW5hbWUgcmVxdWlyZWQNCj4gPiB0byBtYXRjaCBpdHMgY29tcGF0aWJsZT8NCj4gDQo+IFll
cywgdGhhdCdzIHRoZSBjb252ZW50aW9uLiBPdGhlcndpc2UgcGVvcGxlIHRlbmQgdG8gbmFtZSB0
aGUgZmlsZXMgaW4gd2hhdGV2ZXINCj4gd2F5IHRoZXkgbGlrZS4uLg0KPiANCj4gQmVzdCByZWdh
cmRzLA0KPiBLcnp5c3p0b2YNCg==
