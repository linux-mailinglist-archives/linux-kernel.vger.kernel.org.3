Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678FB589D8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbiHDOfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239732AbiHDOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:35:34 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80080.outbound.protection.outlook.com [40.107.8.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07C3237E2;
        Thu,  4 Aug 2022 07:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmqRRZSeRvIkxJsxKFeBuFQR80+zYUG7PDJriBOWDb4kffhl1WlmdDfk6AShurFER1yIbHANKAE6dsn9do0/RVAHKXfx/SUPIWx8AIWKjJ1VwwNnCYWy31Odp5DHIImzhXiD0i4DA7gbtfVHh4JamwCEthgYU/fco8IfQjQA7P30eAMGPn2cuQbkFFRUB143PME+RoR/KfDuoXjG0m6HnjB8g25UNTgUgjd8tgMITxQQTQlCCeMvXMrRiF7ChJuoSRPH2uPwb6R8lvVwjyjm8wHilGQA+glWj72OhK9Q9VKeLuPWP0oym59QUZLOTbZqgCJOXNc8w8vleuiqQoUrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KltiRCezZHGZlMwQuG/2GSAdR+eYyfMp/X1VJZdEcM=;
 b=BQauT7FUqk7jfJrhok7DOsDETUG2NzyjIiSzNsP6t95E/LCtfuwbUVD2Os0ot5ojAIrtRSMTumQlmEOz20JHlTVfoTOvlo+GQTMqE0HwRI9TJ5nLmV4+Z7ew0AKnQgHZE+VxRWcmQG+p+uTWt1qH6mhtS1ZQLkF3ALqWHoLBu0ulkWB+BwYR00bD77g9CxbzXckrOwF0NGRwFZo1OO+AZdUdNBna4hfK7W38cVTHCvDcMOmmVolr/1kCbSuF0EEjM7690UnQf5hjn4n6TwkxI4KHkejockRow5Wjyw9vcoKW/WbUGqB/U6edmPgQ5sKvkuXPfkIrvoSZdplMWqogTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KltiRCezZHGZlMwQuG/2GSAdR+eYyfMp/X1VJZdEcM=;
 b=oGK2qnFf+yFoldzwG0rIx5KP2eHyDypo9OsWYhS+djBmXOlllf9bqIhv/7BpVjpqyvUJM31mvZpib6oDNS1xOvTdmXu2U7XVNYXz+T02yRA7LU6bXIZ4G+XRi+0zNeuerbwDlnl5xQ0X0eFCMYVQ1x0W2kVDH2rizn7XR0sf7ZA=
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by VI1PR04MB4877.eurprd04.prod.outlook.com (2603:10a6:803:61::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 14:35:27 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 14:35:26 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Nicolas Diaz <nicolas.diaz@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/1] serial: fsl_lpuart: RS485 RTS polariy is
 inverse
Thread-Topic: [EXT] Re: [PATCH 1/1] serial: fsl_lpuart: RS485 RTS polariy is
 inverse
Thread-Index: AQHYpo5pJVK3dzxjQ0K9gD514lUxq62eUAsAgACBP/A=
Date:   Thu, 4 Aug 2022 14:35:26 +0000
Message-ID: <AM9PR04MB8274F4B0895FF2BA4467DA90899F9@AM9PR04MB8274.eurprd04.prod.outlook.com>
References: <20220802163854.1055323-1-shenwei.wang@nxp.com>
 <c63877d8-4df2-778e-7e3d-2fdd0e14d4e1@kernel.org>
In-Reply-To: <c63877d8-4df2-778e-7e3d-2fdd0e14d4e1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 954199e4-98fd-44e4-9d6e-08da762692c3
x-ms-traffictypediagnostic: VI1PR04MB4877:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i7bAp2K8z9xpUiS8WKYGy+Jc9WfyQDKSpaOHSd9Kd+VSwHZRGJDwJfc1NIdN4Ufj0UJxgu8Pl9V7qLXrIoUoHFWygpFyezqWyj/jaEzenKRdMgxbpxVVCUb/SebZE5H9k2YfF+mSW/L4vZT98pJ52Ki/imKj3Kbmc3JxiF+eKI6c9YdLS2uDrHCLnsCdqlLSqZ//YCYUX2zZ9QjM7gxRHcZ3Xn8zISXGfuUcUyXFGLVOYZIldoxGyfxR0iVQrAQVO3whIT0XhjnDC2qvqzUBbLfdd9vi5nZ6vATVJaTmpLKWkabfBuFXHDw6vIBkWx0DvUaNvEsS7dJ+J1zIUHaKzhqIDoabRd/uBQm2ws6wmxitS6euCVh7O11t6OI09pUTTsbnkuPmzxcqyA2PS+L6vuu2ROGUy3RAiFUiS+mSJNKe0T6MaDPkspKwFxbh/dnE8Cov5A1IRTigK0YNtO5Bw8yZcvsmyue9IfQmO13hah41qvji7oFH/+JPzSmslHIBEtGHmCFfrf2cwqkLqZAUNU0z/2QGMrx/UyGpr2L4cdILGeKWriwqXx8jBKN1uFXzSjaCHcAv3mj8mCs8t91BU9q1b5mg21ZLbMXNXJk2VkIvyc68+fpcG0OX6/974HZjkq6iWxXWU5WA0TfTLx8Vn8iakXmaGx0U7zm2QcFlYdVvPSr3VC7irKB+/+5Faq+CNf2bfFh4exH0B1d5JtqnGbaxy+pW2Nqxbnt2MVVesJD1nY27oGGywyqN+YhgVXTm/CxqjRDNzNoRWo4ra46TASKP6+M6f9tQrqfYQRLdjN0bwSDlcJXxRfYdU7RODwAO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(38070700005)(110136005)(54906003)(66946007)(478600001)(66476007)(66446008)(4326008)(71200400001)(76116006)(8676002)(66556008)(83380400001)(316002)(64756008)(186003)(26005)(122000001)(9686003)(38100700002)(41300700001)(6506007)(7696005)(55236004)(53546011)(5660300002)(2906002)(55016003)(44832011)(33656002)(86362001)(52536014)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFhrdFMrc1dVazlzd2VsazcxZ2V5Q3lMU083cmx3N01BMXNiV2w3SlZWWGVm?=
 =?utf-8?B?dHhHaWdGWWxKQkNhR2ZEOG9wMkpDSTYvSG95ZndFVnJkWUI4dmhsNC9iQ2cz?=
 =?utf-8?B?Uk1icklzS3BSUXJWTEJQTTJXd21IVFdodUhZL081WlRHT3llWHhPMGdFbW9z?=
 =?utf-8?B?bnpLeEUvZVZQUW04S2pCZGo5eGhvNkpuNmVsNXJVcWZYa0RadlhtUlZwM1k4?=
 =?utf-8?B?QWtmUU45SXMxNTlkVU8zVFNmaGlYOW5yUlk4Q2dSSDJTMDRoV1VBTFlyTEpa?=
 =?utf-8?B?N01TUCtIRXBsa1pwWllxOFhoREtlSmV1S3FlQTZsWWZrVkRVNGVuMWJwQ3N1?=
 =?utf-8?B?QldHUXVZenZRMUZIR0Fsc3pmck8rczlzZDZaNzhBTFg0WUI5dCtEaER5QnU0?=
 =?utf-8?B?UUZsVEFYZGE3ejVlanJVakcvTUdFa3AzM2VwQ0cyNVFsTVlPNVBvZTRUbG5r?=
 =?utf-8?B?QlBmd3crYkpJaTIzRUxUOGtVQnYrK2IydVVWeGRlOHVsQXpsUGJsbUlwMmZq?=
 =?utf-8?B?Ni8vUFBKS1NKMm4wbjREdHZJS2ljeDRoS2wydUZNMVY5RDNZVWdhUm5JTzFB?=
 =?utf-8?B?bExYdWFNV1VzdWx5K2M0RjZSb3lkT2lyNnZBWGd6cGNQYjJPMWJZMUhaUlpu?=
 =?utf-8?B?OHROaTdjRDlMUldJYjkxaU5yRVByZVpuS2psTEVzZFBpNkErWDRrUzExN0Y4?=
 =?utf-8?B?azlRbXk3NnI0Z3RFaG5XZUtDL2xXaDUwUENrVVlLSU9Hcms3Tm9nZTR3SDRp?=
 =?utf-8?B?dDgrVnZqRktrYmN0OUdtdzU4RmxCKzZoVGxUUlFwYlQwTDI5ZDVvRVVEWU1P?=
 =?utf-8?B?NXRyTUtlN0VrUnlRTlZ6VTdvOXRHZWswWXFmcjMrWVJsN01JSGdiSVJ5KzJQ?=
 =?utf-8?B?T0hhUHJid1YvaE9tMnVHbXNTK2RNQkhDUFJVMzhyZFpSTmRnamR1c2QvZHdZ?=
 =?utf-8?B?WXhZM3JqYk0yWFdsVlBDRlViSUc3RUM4K1doWDdKWW54WGJ0YndmcENFcTBZ?=
 =?utf-8?B?Kzhib25qY3JzNmNYUTlRWDM5RTNqaXlybnJwaE51L1MvdnRhaXljSHVqaWVo?=
 =?utf-8?B?SmdVajJZZm4ydVJqc1ZmWlVHcFRjRTRWVmt1Q2FQMHVZQld1STB4WFJJQTVy?=
 =?utf-8?B?bFRuRzhkaVlzTUZtZEt1YWp5ZnZPZ0tuajNSZDhYWlBYMkgvZ2UybkVRWHFn?=
 =?utf-8?B?WGxEVDVQSnArTzBBenV1cUxneUhieS81RS9VeXcvODkrUk53MG5TbVV6QUQw?=
 =?utf-8?B?MlFkNm90WWhVOTJudjdHU1A1REd6Z01rY240enM5OVdXMkxyM05VS2lLdnFO?=
 =?utf-8?B?cG1WS1BaWHRvdlN6M0JNeWZUTnR1RitLU294ZFR1K1ZXNkRSQzhIeXNILzVw?=
 =?utf-8?B?VVlVRnhqNEVIMlQ4eDJDZ0k4N29Tc1NkVTJpZHhuMkZ2ZXBwbnBUOS9PMkgx?=
 =?utf-8?B?dHI2N1ExVFNESHdyZ3FoS2R1Qk1LU1lXdzZMMUdBbXd2MzEraGZjNVZtQXha?=
 =?utf-8?B?WitzNlZXL2ZoVFNlQno4amltcVJPdFA4VmhaaHhtMXlBamRWaXV6cHIyYnF3?=
 =?utf-8?B?YUJpVCt1SWRob2taRmc2SjZJbFhXNDEreEV2bHlFSlVrOVl6dEw0SzA5L3lO?=
 =?utf-8?B?ZGxZNFB5SjhsNnpoZ0FxQkJTZFhtN2l4ekMrMG1EaVk1NkMyWFVvZGhCTG9M?=
 =?utf-8?B?OHc5MGQ2bzl0OEROMHNMbHZDd2hNbXNFbU9yaFcvcm5UYXlDN1hLZWpHSTVs?=
 =?utf-8?B?RjFQRDFNS0dGTmJucDhtSUNmYW1rS3ZtbzZWZ01kWCtHeUp0ZXdpV00yMEo0?=
 =?utf-8?B?U1RsQllNbEYwM2FwTG14eUZKbUNrNWlYaDlyM2Y4WFMxUFNYTFN6TjlhWGtG?=
 =?utf-8?B?UTFGbVJ0S0d0ckhpRUY1aktWYTRnc08rV1luZFlEdm41NDJtSTJYQ2orNGRD?=
 =?utf-8?B?NVkxVnR1WHRUNjJBOEJod2VRUGwvWnhxZDZuL3FvTUR3ekFyZmJ5SzRLWnli?=
 =?utf-8?B?TGRXRzN3amlxVEFKYjh5bUNMYjZJRG42ZytpMVRHUlVoeU5aYjY1eFduUVVh?=
 =?utf-8?B?MEVkbnZ6OG5jeWRjNExzc2ZlNTZNQ21ucDFsNzRpN08vek9iMWNrajlhMTVN?=
 =?utf-8?Q?FyrGYtc+kem3F0PggvCwjkAI4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954199e4-98fd-44e4-9d6e-08da762692c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 14:35:26.9006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gi4KbSeeYYlUjOSk28rFnqHb/M1YluZBLI/dHD6MTnoBOcQthDsJ5ti5w9OLQ86hF37iA2ojfv96/pscCkrAnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4877
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmlyaSBTbGFieSA8amly
aXNsYWJ5QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgNCwgMjAyMiAxOjUx
IEFNDQo+IFRvOiBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2FuZ0BueHAuY29tPjsgZ3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmcNCj4gQ2M6IGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54
cC5jb20+OyBOaWNvbGFzIERpYXogPG5pY29sYXMuZGlhekBueHAuY29tPg0KPiBTdWJqZWN0OiBb
RVhUXSBSZTogW1BBVENIIDEvMV0gc2VyaWFsOiBmc2xfbHB1YXJ0OiBSUzQ4NSBSVFMgcG9sYXJp
eSBpcyBpbnZlcnNlDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIDAyLiAwOC4g
MjIsIDE4OjM4LCBTaGVud2VpIFdhbmcgd3JvdGU6DQo+ID4gVGhlIHNldHRpbmcgb2YgUlM0ODUg
UlRTIHBvbGFyaXR5IGlzIGludmVyc2UgaW4gdGhlIGN1cnJlbnQgZHJpdmVyLg0KPiA+DQo+ID4g
V2hlbiB0aGUgcHJvcGVydHkgb2YgJ3JzNDg1LXJ0cy1hY3RpdmUtbG93JyBpcyBlbmFibGVkIGlu
IHRoZSBkdHMNCj4gPiBub2RlLCB0aGUgUlRTIHNpZ25hbCBzaG91bGQgYmUgTE9XIGR1cmluZyBz
ZW5kaW5nLiBPdGhlcndpc2UsIGlmIHRoZXJlDQo+ID4gaXMgbm8gc3VjaCBhIHByb3BlcnR5LCB0
aGUgUlRTIHNob3VsZCBiZSBISUdIIGR1cmluZyBzZW5kaW5nLg0KPiANCj4gV2hhdCBjb21taXQg
dGhpcyBmaXhlcz8gSS5lLiBJIGFtIG1pc3NpbmcgYSBGaXhlcyB0YWcgYmVsb3cuDQoNCkl0IGlz
IGEgZml4IGZvciB0aGUgZm9sbG93aW5nIGNvbW1pdDoNCkZpeGVzOiAwMzg5NWNmNDFkMTggKCJ0
dHk6IHNlcmlhbDogZnNsX2xwdWFydDogQWRkIHN1cHBvcnQgZm9yIFJTLTQ4NSIpDQoNClNob3Vs
ZCBJIHNlbmQgb3V0IGEgbmV3IHZlcnNpb24gdG8gdXBkYXRlIGl0Pw0KDQpUaGFua3MsDQpTaGVu
d2VpDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTmljb2xhcyBEaWF6IDxuaWNvbGFzLmRpYXpA
bnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2FuZ0Bu
eHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyB8
IDQgKystLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFy
dC5jDQo+ID4gYi9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jIGluZGV4IGFmYTBmOTQx
Yzg2MmYuLmFiYzNhMzY3NGJjMzkNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3R0eS9z
ZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVh
cnQuYw0KPiA+IEBAIC0xMzk0LDkgKzEzOTQsOSBAQCBzdGF0aWMgaW50IGxwdWFydF9jb25maWdf
cnM0ODUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwNCj4gc3RydWN0IGt0ZXJtaW9zICp0ZXJtaW9z
LA0KPiA+ICAgICAgICAgICAgICAgICogTm90ZTogVUFSVCBpcyBhc3N1bWVkIHRvIGJlIGFjdGl2
ZSBoaWdoLg0KPiA+ICAgICAgICAgICAgICAgICovDQo+ID4gICAgICAgICAgICAgICBpZiAocnM0
ODUtPmZsYWdzICYgU0VSX1JTNDg1X1JUU19PTl9TRU5EKQ0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICBtb2RlbSAmPSB+VUFSVE1PREVNX1RYUlRTUE9MOw0KPiA+IC0gICAgICAgICAgICAgZWxz
ZSBpZiAocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EKQ0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICBtb2RlbSB8PSBVQVJUTU9ERU1fVFhSVFNQT0w7DQo+ID4gKyAgICAg
ICAgICAgICBlbHNlIGlmIChyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQp
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIG1vZGVtICY9IH5VQVJUTU9ERU1fVFhSVFNQT0w7
DQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gICAgICAgd3JpdGViKG1vZGVtLCBzcG9ydC0+cG9ydC5t
ZW1iYXNlICsgVUFSVE1PREVNKTsNCj4gDQo+IHRoYW5rcywNCj4gLS0NCj4ganMNCj4gc3VzZSBs
YWJzDQo=
