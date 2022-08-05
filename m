Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7C958AAE2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbiHEMbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHEMbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:31:14 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687D51D0E2;
        Fri,  5 Aug 2022 05:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQufrLFWhs9/QlCR8eSDvuFYtmasMU4/tilaqh/Ee5q4sJlAN5g1rE5+1HvdSUhGBPcykJTu6dENYHpBfAEzdH44fa8MmZ2ChCrp4m67s+tKfSd8YrQdl030KQ8c9hYG68YWxA8s6I6R4r+r6nN0sH6uCjKkgnGITNicbLNniol4W65l7OBRrrZhW6tSDEG+HC40OAZMma23IPEArN4/kQwASOBclgrl8EtXV4+tkbJSKIlI41xMRhenZLxm0XzslNBthZpycFXkR2OyjF/xbF5MIOSWAiyIQFZ8IrRQ+1dctU/RP/IiKB9hjpcTH0PoFbc1bDkl+RUoLQgz6edXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2O+Pmo75fY1bV7W5kx17oN8dRvcjNr0VyPLiZROotyE=;
 b=mKlAXxlz600zbTOGjqidlBL9Q6N6aDsOYZqfQbrFJ8t1BymFmcbOFSSyzCbltb4zYJHfmMpCo8XiNuY0x8RAJEXR2NKcn/a4p3KkaGd/eVwcw6ijVDX3OmdNTnqanxfCw32Nxam2jCZtONEgVBbQe0vnQCK1b4Knq5/JZdoK+wP30a2sq5mn7n7grPcnCp2JemoYMRfscpR8pbe/OBHnC6WeBTzWQ/y8d+NTevrUevuHWgyNe9quy5x/6eXP3MYtLLPAI7ZjQl3gEKjl4SMb/C1fmXqt/eqJaJLVLZK9mtIDein+P+mqfFm/KpptYbIMZt7dT3OXEviGQRZp1S0j7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2O+Pmo75fY1bV7W5kx17oN8dRvcjNr0VyPLiZROotyE=;
 b=UsVcAN+OcayxMM8j5JBSMqY3xGGI1yt+dTrdGLp3X2VBctg6vM30QBMI5LP8K6CI+CrJ57d5Xl/OGK/wQvx44nu6fjH4MRmSYoiX8aKq3xd5EKWIqy550y05S2Ro3ZmZKCbZezTeKt65HebLDXh/s+e/2pZahdCy7p0p9XfDZIo=
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by DBBPR04MB7897.eurprd04.prod.outlook.com (2603:10a6:10:1e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 12:31:09 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5504.015; Fri, 5 Aug 2022
 12:31:09 +0000
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
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v1 3/3] firmware: imx: add imx-scu GPIO driver
Thread-Topic: [EXT] Re: [PATCH v1 3/3] firmware: imx: add imx-scu GPIO driver
Thread-Index: AQHYqDMM46pLfHpU9kWYJJ0zxUsdK62f4NcAgABcfMA=
Date:   Fri, 5 Aug 2022 12:31:09 +0000
Message-ID: <AM9PR04MB82747C5078B14A22B98DB15D899E9@AM9PR04MB8274.eurprd04.prod.outlook.com>
References: <20220804184908.470216-1-shenwei.wang@nxp.com>
 <20220804184908.470216-4-shenwei.wang@nxp.com>
 <c3060197-ef5c-ad41-1c18-9d39641d1ad6@linaro.org>
In-Reply-To: <c3060197-ef5c-ad41-1c18-9d39641d1ad6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99714400-8d4c-490e-e3fc-08da76de6013
x-ms-traffictypediagnostic: DBBPR04MB7897:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1AuCwxRYFOlNF4ehH40OXJvu1Pq0qi/wNxftNu6Ejs52OTKungHhb0nYqSmyl7QNOSbFsP1H3zLj853qhQfYrxmgZO/uSJuczGHDhOidtZ5PdofTP9zI58iZMtNu2WsBBxFTaOJYvTbpqO5ETK74xbpUbHElehkyVvw2GsA6b0C6+jPC3E+WIYLhbi/b9Cb16FLf8tRbPRr5c3QmaNs1Edvy5CEytCNd3xb8VJofSrIgE1G9AD1oTl5w9dVeZ+Rw0nqyTHDK4v3Qmx1LWijuD5A7SqdmCnSiAKImTGlAjU+SO/6CF1uyGl7HCXOiX0bxqWvb3qctDaYTIVWmoe2vds+V5kOB0D5L9feuLo/yXpr4OLxvy4BAdyceQ6hYtQ+EWAMLNXIRHkHzbNIPk4LzLxrE2x8fobPuXoV+zEPv2YSiE8i1bGKKwEC/tUeMMSDZ1uVhKi1zwmOEtBsNIGX7JtlQ2YRIzyas7K3sMOkFM9OuotmTisiFvcDTVs+eQ6tknO4gybMQwDSXEyg8lM/xT75pdPU0zrwXZD8X25PSue5UZeplG0HbxDd8bYS6s0mE8K13q5xMUp8dK/TYdYuBNYlkswnc+BKNbmq5F1YY7kkxKLpGywaKSaBtUQ37cMWcwF61fbsXW82jALlgVN5GRBgH7G4ALCVG6518JeD16+9j5CSTibDfgbh4n+fditWptha6MAk/GaHzVyZWVX29y+wZ8vfaggynBIgb1sgGpjO2zR8NRAMovuxyTwwnjilVu7z7Tm31BnRm1mI47wJfLHFK+L9CWIZ9x5q9Wlk+GMITQsN8iv1t2js6TKK7vFfy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(122000001)(110136005)(4326008)(41300700001)(66556008)(66476007)(8936002)(66946007)(76116006)(64756008)(7416002)(66446008)(8676002)(44832011)(52536014)(478600001)(921005)(9686003)(5660300002)(55016003)(6506007)(7696005)(33656002)(86362001)(6636002)(71200400001)(316002)(26005)(83380400001)(186003)(38070700005)(54906003)(53546011)(55236004)(38100700002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZG0zVXBpc3pLa3hFM3VjV3lvME1hazhudlFqM2J4ODVJU3ZZdHhHeXNmblJV?=
 =?utf-8?B?dXMzVmxkRWd2YTQxdmlqOVhIUE9Ub2gyWHA2Kzc0a0FBcDZWaGY5UG9yLzdJ?=
 =?utf-8?B?bFJpeURYM0lzWjJIZEFCWTZ0K09IdHk2NTZwbVYvVHdIdXA4cGNtZkRZZ2FO?=
 =?utf-8?B?cjkxbHhqQnV0UDNDTVp1UUtHbHpqakFOeEVSWkFudHptalhSS1dJdHI3M29J?=
 =?utf-8?B?WTBFeDhXQzZHUC9qQkI3a0dTdUZtTE5WUnQxK0RTNUJwano3Z3A3ME9PSTBD?=
 =?utf-8?B?ajZ2NVg2cUc1R01GYjF6RGhMSFZPb0pNOXpJNU5aeThDQUxRci95Z0M3MmQr?=
 =?utf-8?B?WlBBNmFuNzBjeHgvWHNLNmQxdERwMzErTEZ3bDY4cHpucjc2dEhwMG5lRkVI?=
 =?utf-8?B?d3dJR2NqNmkvMUo0LzlSMkFDVVFjN0VGeklNeHc3dWk2ZitTUFkvNkdUY1Vm?=
 =?utf-8?B?a0JTNlZZZ05HOWNScFlHUXBtMWNuNm5xa1Arc05jM0gzYStEendQemhrVEl1?=
 =?utf-8?B?V3lzL2xKR0wvbmZybEVOa2R1bmRjSXlGZUNLVFRLNDlpbHBJUENuRnRWd0w4?=
 =?utf-8?B?WEFsSDV0QVdQM3ZsenE0NFliWUhTbHNCaU9qWGI5TWFqdjEwaDlXdzd1amlE?=
 =?utf-8?B?bTZ2RHdpK01xWmh5VlJzQlBvT1JSb2hqS0VzWCt0K2FrRThwTGtZWDJtZXRw?=
 =?utf-8?B?RlE0bDFJakRrZGRsT1NyTnptNWZxOHdieXZZZGVrdXhmelpxTFZ5MW5JM21N?=
 =?utf-8?B?OGNmbmVLWDNOTHNSckoyWHBDcGVjYTRtVGc1YkhsK3NSZS9DbUF1cDBqSHpS?=
 =?utf-8?B?bnY1LzA0aldHTWtrNDFJZUZmd3psclJVSDQ4SFBFTnRja3N0cUtwZ01EMS9L?=
 =?utf-8?B?cnFGRHB0dkR6bzRkdTlyVkRFalhmeUw5R3pORXpSdWtKVHNxZEVEcXg1VEtT?=
 =?utf-8?B?YzhNVFc2U0JuVit3RDFOS1RoMkN2Zk9jSUpRYzBjeE5Wb1FXWk5zZ0JYRnVY?=
 =?utf-8?B?OHlSSTlzVGhNbVBSbWJGemF1dzlXRWRzdXJYM0lPUE5hSHFOeUJMWEFEVXhQ?=
 =?utf-8?B?NUx6TVRZejlzdDJrZlJwS2I4eVF1UjdISGh5QjF1clEybXFlT2w1UnVDdjRq?=
 =?utf-8?B?bXY3cEovZFcwVU5nUzV6QUdmZHVmS3QySGFYazRlYVlJUEgzUG1UakFKUDNp?=
 =?utf-8?B?SmpETVNsUW1oa3pqb2R1VGtMb0RTWUtMNVJjS2twVng2cmpNNkFuK1d5bHVx?=
 =?utf-8?B?N0o5WXBpYXFMNGVTbW84ck8wRGZmRndJR2JtcElNRzB2OVNwTmFDUE44RjBW?=
 =?utf-8?B?TExMS1JEYUcwZ01FN0l4KzlvenNMZWVOQjNnQ1RMQjBPT2lLck5YZjBKRnpW?=
 =?utf-8?B?QXEwWldqVDZCcWhvU2hJMzlWcG9pZzlIdG5XcisrbGxodzhxQ2hsei9Udng3?=
 =?utf-8?B?REE0WkNNUkZHZ2pmRTFweGFQS3dZK2Q3UTg1ZmpGRnV3TFlIR2hMZWJaYW8z?=
 =?utf-8?B?RkFud3d2Q3BOZnVMUlNvemVLQzhhM053K0pmZnNEZldRUzFlMFVWQ21xdUNa?=
 =?utf-8?B?WC9mNmsyQ1hpZ1RXM0xPd1pvS05wOUNyRG4zNU9Fd1lhQzRSUTlRd2dlUTNl?=
 =?utf-8?B?aXdxUkpaeGkvbkhYbkJmN283dDJOS0haeEd4YTFsM2ZuN1Z0WnZ5ckJaUlhH?=
 =?utf-8?B?TnZyTkJWTVY0MDNmV2M4cUxiak1vSE9JdW5XUTlPdHJCQzI5Snp2V295M0xm?=
 =?utf-8?B?dC9IVThBYXJXOE91TGpQNi8yQU80WS9kVVI4Ui9PQ29tNVBlZkJ1dHZNVkx5?=
 =?utf-8?B?SjJKbUY4aWN5RkxXN2hvdDNyWkdRODA2MzJVK1ZmNGdJeW1oMTlEaVVodUJM?=
 =?utf-8?B?NCt5elZlOVc5OVd0Nzl0QTJoRWExRktnOUtSeU9RSU1kN2kwMkovVG1BeEZy?=
 =?utf-8?B?ajF1WVdrblBYN2o2MHhOWHdmNnhtZGk0aCtNYkRxNDRjWGJHR3hGaEplMUNO?=
 =?utf-8?B?VWhqajV4cXZQQmcwQVAxdXNNOHZYZjRWby9hNUswS3VEQmdHMWY1VlB0NCty?=
 =?utf-8?B?OHp6T2RIbk9sK3pWR05aaTNDS2RiOVV5NGJ4dkZ4VEcrb3BneWhHMFRhaDFF?=
 =?utf-8?Q?VpSF2u70cIY+mdP8wt6MMc8OO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99714400-8d4c-490e-e3fc-08da76de6013
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 12:31:09.2923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QsMy+wERKuqW8O8xjidunVm9FIINeMX97gtp/3jK3+yZCnKWra6Hgm3VivlNM5F8i0jcP0JQMXvg4Kl+By/xCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7897
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIEF1
Z3VzdCA1LCAyMDIyIDE6NTcgQU0NCj4gVG86IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5nQG54
cC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGlu
YXJvLm9yZzsgbGludXMud2FsbGVpakBsaW5hcm8ub3JnOyBicmdsQGJnZGV2LnBsOw0KPiBzaGF3
bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9u
aXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhw
LmNvbT4NCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYx
IDMvM10gZmlybXdhcmU6IGlteDogYWRkIGlteC1zY3UgR1BJTyBkcml2ZXINCj4gDQo+IENhdXRp
b246IEVYVCBFbWFpbA0KPiANCj4gT24gMDQvMDgvMjAyMiAyMDo0OSwgU2hlbndlaSBXYW5nIHdy
b3RlOg0KPiA+IFRoZSBTQ1UgZmlybXdhcmUgb24gaS5NWDggcGxhdGZvcm1zIHByb3ZpZGVzIGEg
c2V0IG9mIEFQSXMgdG8gY29udHJvbA0KPiA+IHRoZSBHUElPIFBJTnMgb24gdGhlIFNDVSBkb21h
aW4uIFRoaXMgcGF0Y2ggaW1wbGVtZW50cyB0aGUgc3RhbmRhcmQNCj4gPiBHUElPIGRyaXZlciBp
bnRlcmZhY2UgdG8gYWNjZXNzIHRob3NlIFBJTnMgb24gdGhlIFNDVSBkb21haW4gb3ZlciB0aGUN
Cj4gPiBTQ1UgQVBJcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoZW53ZWkgV2FuZyA8c2hl
bndlaS53YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZmlybXdhcmUvaW14L0tj
b25maWcgICAgICAgIHwgICA2ICsrDQo+ID4gIGRyaXZlcnMvZmlybXdhcmUvaW14L01ha2VmaWxl
ICAgICAgIHwgICAxICsNCj4gPiAgZHJpdmVycy9maXJtd2FyZS9pbXgvaW14LXNjdS1ncGlvLmMg
fCAxMzkNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hh
bmdlZCwgMTQ2IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
ZmlybXdhcmUvaW14L2lteC1zY3UtZ3Bpby5jDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9maXJtd2FyZS9pbXgvS2NvbmZpZw0KPiA+IGIvZHJpdmVycy9maXJtd2FyZS9pbXgvS2NvbmZp
ZyBpbmRleCBjMDI3ZDk5ZjJhNTkuLjQ4NGMxM2YzMTQ5YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2Zpcm13YXJlL2lteC9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9pbXgv
S2NvbmZpZw0KPiA+IEBAIC0yOCwzICsyOCw5IEBAIGNvbmZpZyBJTVhfU0NVX1BEDQo+ID4gICAg
ICAgZGVwZW5kcyBvbiBJTVhfU0NVDQo+ID4gICAgICAgaGVscA0KPiA+ICAgICAgICAgVGhlIFN5
c3RlbSBDb250cm9sbGVyIEZpcm13YXJlIChTQ0ZXKSBiYXNlZCBwb3dlciBkb21haW4gZHJpdmVy
Lg0KPiA+ICsNCj4gPiArY29uZmlnIElNWF9TQ1VfR1BJTw0KPiA+ICsgICAgICAgZGVmX2Jvb2wg
eQ0KPiA+ICsgICAgICAgZGVwZW5kcyBvbiBJTVhfU0NVDQo+ID4gKyAgICAgICBoZWxwDQo+ID4g
KyAgICAgICAgIFNheSBZIGhlcmUgdG8gZW5hYmxlIHRoZSBpbXg4IGdwaW8gb3ZlciBTQ0ZXIE1J
U0MgQVBJDQo+IA0KPiBncGlvIGRyaXZlciBnbyB0byBkcml2ZXJzL2dwaW8vDQoNCkkgd2FzIHRo
aW5raW5nIHRvIHB1dCB0aGUgZHJpdmVyIHVuZGVyIGRyaXZlcnMvZ3BpbyBhdCB0aGUgYmVnaW5u
aW5nIHRvby4gQXJlIHRoZXJlIGFueSByZXF1aXJlbWVudHMgdG8gcHV0IGEgZHJpdmVyIHVuZGVy
IGZpcm13YXJlIGRpcmVjdG9yeT8NCg0KVGhhbmtzLA0KU2hlbndlaQ0KDQo+IA0KPiBCZXN0IHJl
Z2FyZHMsDQo+IEtyenlzenRvZg0K
