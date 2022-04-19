Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68C0506732
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350163AbiDSIyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiDSIyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:54:10 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00077.outbound.protection.outlook.com [40.107.0.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235B317AB5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAWLzPp4qeqL+latFsmYilMFTqZO9/f4RBVHGHkTOGiD2ET/HcFgjaUX9J2tudNBNF8q3Oqo3uz62F6C+Mue7PJa/lIaYTlSyXu2nJZOtyVR4YvKChmfZpbwKQWvba/i4g8ochPyDSAPAYi/rNifiu/Cu/g9VHJk+P2NmVjQHS5VED2ILtU++74MtOiBcKhipGLlcFmoAld6EDWOSMAoee4HbnCOBGux/y4LZOg821RDCAEV6zITPmaNwPZst+da1dkq+nOiGx0GFv4ScUDHIah4bWTZbUklkOUtbV18UsR3/nhJixfUnntbyxpwbEuvGBlASHe0IaTG2N4X7BmC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LzZrqom3qYaoyfMHR7cgGzS4eCdx+Ex7kL7VxkCRxQ=;
 b=FBOkcKqsgIM/BaeYBypfmMBe3BZCdc3NLJwvPCHZqs9AyV3rzyGcKx5SSeBs7z+4hbdYpTzyflQKqQw6nDgsCMTLrZF5ct356c46aq0jgWxk3Bfs5EIbTZId+1HrdXWoNHpv0EWSOQiAXy1qRsEX5UOqNuBTS9PSJXS1yvpC+hOTjweoWMLU9p8VLJsnaEYCMChslT7Q1rdfMlu1G7J31UwMUBP6BnEKMS7jnP0qJIHqkgZWZknCvu8Lib8wuRX6y6v/CHnh+sYraw2I9kJLGps1vpq2GIGWlk0wCrpBzlaqeWEbWYOAQ1fqLd5i/7eT651PkaZhc8joUGnWOsTyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LzZrqom3qYaoyfMHR7cgGzS4eCdx+Ex7kL7VxkCRxQ=;
 b=aSoMBcrH2jDpuA8X6qxl2BOCjaC5z98iQgPTNJCSD7LiI4D/N2zjfuUPQkmy2DyzP2ZS5jurRNTTE63WlTvaPMPiH/dYTqtCvqX1I0bGwAe/xZjaXNbGQrn8896WGneau3WvK6I5gHsG8oPSDY7UnRUu0DRnn14uYsuDZD4zdGk=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (2603:10a6:803:49::27)
 by VI1PR04MB6175.eurprd04.prod.outlook.com (2603:10a6:803:fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 08:51:25 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42%4]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 08:51:25 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Li <frank.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
Subject: RE: [PATCH] extcon: ptn5150: add usb role class support
Thread-Topic: [PATCH] extcon: ptn5150: add usb role class support
Thread-Index: AQHYSZwctDdaLIQeZ06BuvStsTM0tqziq1kAgAAXF/CAFC5VkIAAAhOAgAAAcZCAAAjMgIAAARTA
Date:   Tue, 19 Apr 2022 08:51:25 +0000
Message-ID: <VI1PR04MB433336414971E5EB6F4BAA8389F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <1649238142-27564-1-git-send-email-jun.li@nxp.com>
 <4ad9e733-7d8b-a73b-c59e-d9b6d5e58498@linaro.org>
 <VI1PR04MB4333FE5742667FBE8AAACD2789E79@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <VI1PR04MB4333585DED292C3AC920B21E89F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <CAGE=qro_cWtZe1xVz0MrKXaKnhN_RU+kVPwtLdVj1wsjpSDMjA@mail.gmail.com>
 <VI1PR04MB43330369E23F47E26248853989F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <3dafc432-849b-0a78-f3dd-954d88c74a61@linaro.org>
In-Reply-To: <3dafc432-849b-0a78-f3dd-954d88c74a61@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e2980c5-4491-4a7b-0108-08da21e1c951
x-ms-traffictypediagnostic: VI1PR04MB6175:EE_
x-microsoft-antispam-prvs: <VI1PR04MB61750A154EA9F668736D0E6489F29@VI1PR04MB6175.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7cz5Z8zLDwQYV8DxvJIjBnwMib59zS8SkBCdDFiPFt4wFes6S69CFO/0veNjZSlKVqoIzyiyBmNDuuU5cZdbumhrlJgVK0q7IwxU8wAq2wA7iPCsodNmJdHSGOkiEfForyxx1VFVxIZjtkZE4FVb4jVJ55+sHgBFD5kPPZAXFeO8LMksRT23HAt79k98liC//doD/xVYjiZHMNjWtDvj0SC20ZCHU0bnCORd37J16fd84cG/iUcBMLwYMKz4BrRevd1q/LY3S0T7zzkhzmcWpvilxg7+RpHMg90teSfXDZ1mtto65wkPrL/hVPrnwiTlJhzffpUxCVPMmH8xt99ypVXSwzNXAH26/mXCAaIWo/nxW3jHk9rO7ykALln3W007xXneyj8djPAHgevWCohREZ0vsceoSZxM6dJTB/ta5e3ugj0OmkZ+uzjkjlSyiMHJHcUK2Y3W/sGer1tSk21R2wT1vOJfDcIDUsLCzfRkccy5a6PH6s4UctQ0mM+i0exotbXwf4FMO31YA39gF3oHV/bzH/8QxGSqO18q7INrSMGNjgFDKB4cNMxRvyTswoGfLLmZTwxgpWt8CVDZt25yWwTUhQA6CQbmZwwDd4H83yi1rCYryhnXC8pVvmI93R1BYxa0UJdfmb97SmpQbm9jTZSJO/EMldljcwtKIDnHYU2ATYPq9eU4ltN8+63LbLCuw8L9pGKU3spHfcegvHID5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4333.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(316002)(64756008)(54906003)(38070700005)(53546011)(4326008)(8676002)(8936002)(33656002)(508600001)(52536014)(122000001)(71200400001)(5660300002)(86362001)(44832011)(66476007)(66446008)(76116006)(66946007)(26005)(55016003)(38100700002)(186003)(83380400001)(9686003)(7696005)(6506007)(2906002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDhjL1VBL29JeEYwRWRsYUh0dzdkVzEyNy9lUnFDY0ZacjhmeEJ5d2lvQ2tD?=
 =?utf-8?B?QU1pK2VYWitJREI0OXdOOWw2a043bTR1Ris1Y2JoK3pXZitjZXBrZ1FQTUtq?=
 =?utf-8?B?dUtYTW5rMjN4L1k3dFhmNVduNFhmTGwvK1h0elBEcmladVYrSkIvc3lQTjhK?=
 =?utf-8?B?cVNLUHpmcWRscHBRYUJKdHc3aWpFMGtXTWdIdHY2ZFVjRCtwL2l0NlRLeHBt?=
 =?utf-8?B?WVhOR3RDV3lsQ3JzVW9LblpIWFR6WUcwSTdCRCtla2g4WFRqUmE5ZWtTbFBh?=
 =?utf-8?B?N095ZWlFUjBDazdKc3hITzNjUmppL2lldzNPZUJYK2dpMmIyK0NFK0pqYVpI?=
 =?utf-8?B?SUV5aGt4bVRldDAyRkZkNnZRRHJ6djJQZVZnMFdLL212aGNWVnNOSDVjbnRB?=
 =?utf-8?B?RWdJZVJvSFV6aEQyMGhxUi9CS21EWUJwZ1JWZk1uSzF3SDFJSDV0RU1TdzN2?=
 =?utf-8?B?RjFLVzhWMWE4bEhRQUJkcGEwL0JOMHhvanpUOVpGNnRQYlpwNlhYeGpwbGkz?=
 =?utf-8?B?MXFkeEd5cmk5SGREWmhEYWdsS1ExeG10eXliZ1B3T0FXcjBKUGJFU3F1MEdI?=
 =?utf-8?B?UGtwVmJvQUpQb09lVkNYTkRsTklLY3Y3cWRyZjIzZ1U1MGFaM1doRE5kb2hk?=
 =?utf-8?B?cy9sRGZYNS9mbGpmY2xsQmt5a0txUnpFQWhJRFFZSk5RUDFCWVdDZ1hXTStD?=
 =?utf-8?B?R0xmUWJTYzNGNE5EZDlUK1pqUGhUb0JQSmtFTVgzT1ZzMThQMG9rZWhkNkd0?=
 =?utf-8?B?RWdEcHcvUzUzS0hNeS9vK1hrRDl4TTRUcTBWazNKM3hLM1pFNHJWS0dQOHJG?=
 =?utf-8?B?dE1mcUo3dUV6d2Flb3ZXNXFLVXFBTjlaSWQ1eHlJSk93MnNzcnFCNlY5ZUlk?=
 =?utf-8?B?bE1BWGRsNGNBN21JRVVaN3RhMzJINUhlbXN6dmV3NXNJcE83V1JCTzdGSHdI?=
 =?utf-8?B?cHhPOTlCR1VhTFlacXVRSTFnY0hYRUkvV1JaQ2xFOGVGcnlYMEQwcUYxNUxG?=
 =?utf-8?B?c01ZWTJvV0FmeWQ4bHJWREdhVTJ0OUlpNDRRaGxmRGZoV05GM0N3QWcxRGlI?=
 =?utf-8?B?S29VZEs3Q0xQOFJxeDN4UlpIVlN1Z1pHU1FWRzhWbG5XeVVIeGNuM0xpaHM5?=
 =?utf-8?B?bFgxckNVc0FlbVNNNHFnaUhKWUlqd3ZZMDV2cy9GNUFrNysweXF2bWowSllX?=
 =?utf-8?B?ODFPb1NwNFVHQ3YxTUVFRHUxc3BENnc1R1dualo1SU5RaVhKNGxDNkpIK1Qr?=
 =?utf-8?B?T0JmQUV4YnFYeFdkMUpiaEw4bWQzdTh2V3U0UHI5T3RsS1FZa0FpbGtuWC8y?=
 =?utf-8?B?dm9qRWpPeGhKbzBpSGN6S0Z4ZlFPQ2J3WEJmdUlwK2drYmUvV3lTdjNGVWFS?=
 =?utf-8?B?SlhyeTFEclpUd3V3T29YWDlQWTRrZHVHMjlseFpmS1dZYVNITjlYaWkwV2JP?=
 =?utf-8?B?RldrVG1jZS92TVJuby85Mmd1WHc2SWt1N2djMkk5U3llY1BJVTd5RFgyRnJk?=
 =?utf-8?B?OTRxZ2w0alJnR2h3b1FIeGpnOVRPc2F6ZmFzR2ZzQ3hRcWdPTWczazdZY1FX?=
 =?utf-8?B?T1VVcW51bnhVQWFnNEU1RXd1bHA3NVlrOWtXRmZSVmFYakIvcDZUaXhHc2g1?=
 =?utf-8?B?TTQ2aENYZzFYaWZSRkpHQ1JXWm5HUmxEc2ZWNExXRUtmQlNxZVJweWsvamVI?=
 =?utf-8?B?cnRNTWhMSjZjVTgxMHFYeVNwR0RzbzQrU1dqU2xZeHVNOTFUYmpLbHczUk9M?=
 =?utf-8?B?VHRTUUF2QzZqWE0rU0pkL0dESlBlY1ZOSVg0Tnl5dkVtc2ZSeEtaRVZjUHNl?=
 =?utf-8?B?L1I3c0pxeHhySmdTY29iVnZtNXFGYVVYZlRuamZJbHMyelpkVjdOeVBrN0xw?=
 =?utf-8?B?Z0xaK0RuT0hMcnJqc1Z3QmttbjFzSmlpSFVpNjd4TWJnblllU1IzL2VGV3Na?=
 =?utf-8?B?YXJkN1VNRDN2dVZ3WnpTSHdQN01WY3F1SUxhaExJc01KWDV6YTRVbGp0UVpw?=
 =?utf-8?B?RCt6T08yVzRHTmlJSmVhdG5CZm5ER3VDcHBMQ01obGFrMTQ4eThjaE83V0ts?=
 =?utf-8?B?M1IvOHN5SFhYb1hVa2JKUFNiMWpJaXlyNkl3Wm11Nm90THRuYlcvWDlMOUNr?=
 =?utf-8?B?a25NR0QyTnBuT1ZmeU4rMU93MGJyL1dMUUM5M2ZIWjhUaTlrZ0tINk5ZR3Yw?=
 =?utf-8?B?MFpaOHU3K0xmMG5OUGF0MFI4UGNwend1QlBRQkZZclYxc0hBZlByLzJNOVhx?=
 =?utf-8?B?TjBEZG1oc0RIVWZXQjZHMXQvdVBkb0FFTldlaW85WU80NWdPU0lCbzNSVzdT?=
 =?utf-8?Q?qLeF/G7HzgCNTp8reP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4333.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2980c5-4491-4a7b-0108-08da21e1c951
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 08:51:25.4765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1GlqkrgjAUZLWve/4jTiZGVUzkqjxpQ03k/PpF06w3vz/jMkqGr/EexoEMX7hkgc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6175
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
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBB
cHJpbCAxOSwgMjAyMiA0OjMwIFBNDQo+IFRvOiBKdW4gTGkgPGp1bi5saUBueHAuY29tPg0KPiBD
YzogbXl1bmdqb28uaGFtQHNhbXN1bmcuY29tOyBjdzAwLmNob2lAc2Ftc3VuZy5jb207DQo+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsg
WHUgWWFuZw0KPiA8eHUueWFuZ18yQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGV4
dGNvbjogcHRuNTE1MDogYWRkIHVzYiByb2xlIGNsYXNzIHN1cHBvcnQNCj4gDQo+IE9uIDE5LzA0
LzIwMjIgMTA6MjMsIEp1biBMaSB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5r
b3psb3dza2lAbGluYXJvLm9yZz4NCj4gPj4gU2VudDogVHVlc2RheSwgQXByaWwgMTksIDIwMjIg
Mzo1NyBQTQ0KPiA+PiBUbzogSnVuIExpIDxqdW4ubGlAbnhwLmNvbT4NCj4gPj4gQ2M6IG15dW5n
am9vLmhhbUBzYW1zdW5nLmNvbTsgY3cwMC5jaG9pQHNhbXN1bmcuY29tOw0KPiA+PiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IFh1IFlh
bmcNCj4gPj4gPHh1LnlhbmdfMkBueHAuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBl
eHRjb246IHB0bjUxNTA6IGFkZCB1c2Igcm9sZSBjbGFzcyBzdXBwb3J0DQo+ID4+DQo+ID4+IE9u
IFR1ZSwgMTkgQXByIDIwMjIgYXQgMDk6NTMsIEp1biBMaSA8anVuLmxpQG54cC5jb20+IHdyb3Rl
Og0KPiA+Pj4+Pj4gQEAgLTEzMiw2ICsxMzIsNyBAQCBjb25maWcgRVhUQ09OX1BUTjUxNTANCj4g
Pj4+Pj4+ICAgdHJpc3RhdGUgIk5YUCBQVE41MTUwIENDIExPR0lDIFVTQiBFWFRDT04gc3VwcG9y
dCINCj4gPj4+Pj4+ICAgZGVwZW5kcyBvbiBJMkMgJiYgKEdQSU9MSUIgfHwgQ09NUElMRV9URVNU
KQ0KPiA+Pj4+Pj4gICBzZWxlY3QgUkVHTUFQX0kyQw0KPiA+Pj4+Pj4gKyBzZWxlY3QgVVNCX1JP
TEVfU1dJVENIDQo+ID4+Pj4+DQo+ID4+Pj4+IFlvdSBkbyBub3QgbmVlZCB0byBzZWxlY3QgaXQu
IERyaXZlciB3aWxsIHdvcmsgd2l0aG91dCByb2xlDQo+ID4+Pj4+IHN3aXRjaCwgd29uJ3QgaXQ/
IElmIGl0IHdvcmtzLCB0aGVuIHByb2JhYmx5IGl0IHNob3VsZCBiZSBqdXN0IGltcGx5Lg0KPiA+
Pj4+DQo+ID4+Pj4gT2theSwgdXNiIHJvbGUgY2xhc3MgcHJvdmlkZXIgc2hvdWxkIGVuYWJsZSB0
aGlzIGZvciBtZSwgd2lsbCBkcm9wIGl0Lg0KPiA+Pj4NCj4gPj4+IEEgc2Vjb25kIGNoZWNrIG9u
IHRoaXMgYW5kIEkgdGhpbmsgSSBzdGlsbCBuZWVkIHRoaXMsIHRoZXJlIG1heWJlDQo+ID4+PiBz
b21lIHVzYiBjb250cm9sbGVyIGRyaXZlciB3aXRob3V0IHVzYiByb2xlIHN3aXRjaA0KPiA+Pj4g
KyBwdG41MTUwIHZpYSBleHRjb24sIHNvIG5vIG5lZWQgVVNCX1JPTEVfU1dJVENILCBJIG5lZWQN
Cj4gPj4+IHNlbGVjdCBpdCB0byBhdm9pZCBidWlsZCBicmVhay4NCj4gPj4NCj4gPj4gV2hhdCBi
dWlsZCBwcm9ibGVtIGV4YWN0bHk/IEFyZW4ndCB0aGVyZSBzdHVicyBmb3IgIVVTQl9ST0xFX1NX
SVRDSCBjYXNlPw0KPiA+DQo+ID4gTW9zdGx5IGNhc2VzIFVTQl9ST0xFX1NXSVRDSCBpcyBlbmFi
bGVkLCBidXQgSSBjYW5ub3QgMTAwJSBlbnN1cmUNCj4gPiB0aGF0LCBhdCBsZWFzdCBJIGNhbiB2
aWEgbWFrZSBtZW51Y29uZmlnIGNoYW5nZSBieSByZW1vdmluZyBzb21lDQo+ID4gY29udHJvbGxl
cnMgZHJpdmVycyB0byBjcmVhdGUgYSBjb25maWcgdG8gZ2VuZXJhdGUgYSBidWlsZCBicmVhazoN
Cj4gPg0KPiA+DQo+IC9vcHQvZnNsLWlteC1pbnRlcm5hbC14d2F5bGFuZC81LjE1LWhvbmlzdGVy
L3N5c3Jvb3RzL3g4Nl82NC1wb2t5c2RrLWxpDQo+IG51eC91c3IvYmluL2FhcmNoNjQtcG9reS1s
aW51eC9hYXJjaDY0LXBva3ktbGludXgtbGQ6DQo+IGRyaXZlcnMvZXh0Y29uL2V4dGNvbi1wdG41
MTUwLm86IGluIGZ1bmN0aW9uIGBwdG41MTUwX3dvcmtfc3luY19hbmRfcHV0JzoNCj4gPiBleHRj
b24tcHRuNTE1MC5jOigudGV4dCsweDIwKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgdXNi
X3JvbGVfc3dpdGNoX3B1dCcNCj4gDQo+IFRoaXMgaXMgc29tZSBvbGQga2VybmVsIC0gdjUuMTUu
IFBsZWFzZSB0ZXN0IHlvdXIgY2hhbmdlcyBvbiBtYWlubGluZS4gSQ0KPiBkb24ndCBzZWUgc3Vj
aCBpc3N1ZSBjYW4gaGFwcGVuIG9uIGEgcmVjZW50IGtlcm5lbCAtIHRoZXJlIGlzIGFuIEVYUE9S
VCBhbmQNCj4gYSBzdHViLiBNYXliZSB5b3VyIGRyaXZlciBtaXNzZXMgcHJvcGVyIGhlYWRlcnM/
DQoNCkkgYW0gd29ya2luZyBvbiBMaW51eC1uZXh0IDIwMjIwNDE0DQoNCmNvbW1pdCA0MDM1NDE0
OWY0ZDczOGRjMzQ5MmQ5OTk4ZTQ1YjNmMDI5NTAzNjlhICh0YWc6IG5leHQtMjAyMjA0MTQsIG9y
aWdpbi9tYXN0ZXIsIG9yaWdpbi9IRUFEKQ0KQXV0aG9yOiBTdGVwaGVuIFJvdGh3ZWxsIDxzZnJA
Y2FuYi5hdXVnLm9yZy5hdT4NCkRhdGU6ICAgVGh1IEFwciAxNCAxNToyMjozMSAyMDIyICsxMDAw
DQoNCiAgICBBZGQgbGludXgtbmV4dCBzcGVjaWZpYyBmaWxlcyBmb3IgMjAyMjA0MTQNCiAgICAN
CiAgICBTaWduZWQtb2ZmLWJ5OiBTdGVwaGVuIFJvdGh3ZWxsIDxzZnJAY2FuYi5hdXVnLm9yZy5h
dT4NCg0KTXkgdGVzdCBjb25maWcgaXMgbWFraW5nIFVTQl9ST0xFX1NXSVRDSD1tLCBidXQgUFRO
NTE1MD15DQoNClNvIHdpdGggYmVsb3cgaGVhZGVyIGZpbGU6IA0KDQojaWYgSVNfRU5BQkxFRChD
T05GSUdfVVNCX1JPTEVfU1dJVENIKQ0Kdm9pZCB1c2Jfcm9sZV9zd2l0Y2hfcHV0KHN0cnVjdCB1
c2Jfcm9sZV9zd2l0Y2ggKnN3KTsNCiNlbHNlDQpzdGF0aWMgaW5saW5lIHZvaWQgdXNiX3JvbGVf
c3dpdGNoX3B1dChzdHJ1Y3QgdXNiX3JvbGVfc3dpdGNoICpzdykgeyB9DQojZW5kaWYNCg0KV2ls
bCBoYXZlIGxpbmsgZXJyb3IuDQoNClRoYW5rcw0KTGkgSnVuDQo+IA0KPiBCZXN0IHJlZ2FyZHMs
DQo+IEtyenlzenRvZg0K
