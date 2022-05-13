Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DC9525DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378633AbiEMIxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355557AbiEMIxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:53:30 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2176.outbound.protection.outlook.com [40.92.62.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645C3233A51;
        Fri, 13 May 2022 01:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWMrRdFcFtmK3ZVtMPEIh+MNmUPuMVEdri5PT/llnVGbx08ML3XBcirY/GI9dQuzSXFZuhM1fGhtlQvWx5rsfTFlH9GgQmC516o0eUzocx9/MC3lFeMbY4uVeX/oS5lKm7iKX07a6qcn6uK/uLuM2SeesJX78OUys6RfOkFNRfxE88cfVtNbAXRHb9+Bc/8mE8uoBU5U338klhptRePE/gYl7CK5+wupUPnQrr8Y4Duwn2A2nUSGj7s9yA/Z88TPvlqnAI/0CyakaJ14NjC9lAOTSDK5TeYjBdnGC0cd9okD5a6/Nu+2Ou/kUYbuR1UWafr6WhIcRNQQELz288x3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7z6nkxlTP679R2fzYzZtQf9N+XHVhoTOFyLl1TOpoY=;
 b=lrEoFbkvEUHp2MKXdW2ndljkY+JS5ox3ehEsvtGNNJkN+87IhbQ7mHnvLl55gMOVUjcQoTudvIXoyHwBGRQqTXzWkiZAt+JWFtEw7DPe01RnVtVrc23bSxPOUsd3DXK/oFAbnTmF0a+B/j0vSgjD0R5FcGViFMvcQfKXDGRUUWH+dm41Ln5xTBif8NhOlEuIznW0sDNaFxOi/zFhHXFEtEt1YSKcGHTiCwQYMerPlOUV2k+6mGVJr/SsgCA3XF9oZkbyaX9pvO9OZjFgl9yi/X1XK6349brIuhaR2LEndSPrXlVXHfcRNkOCYQY0Ean9x8WNwxanzxJH9pCdEX4lvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7z6nkxlTP679R2fzYzZtQf9N+XHVhoTOFyLl1TOpoY=;
 b=qquim5UOTEEX7PGCX5WsAfFItkP96F3mSiFX6TJQYt8F2UncY3U9V16RtMxOYYV1C7t7icO4Yekyauf2joONP0LjJ6GFQFBS2Rv22dLKvTw96qpMSQJHHpNP4sgcbnHuYtkDIUmFGkgNOgFonH15deOeAgPxgGC3X8Ksn6KWoo3N7eN4wLxVOK9wc4+77sNopPpTa56qp6Mw0VK6hjXuHj5encg5E0MY9/2/m6P3/pETBVlORoZ29/w/fvXoPVmxIxvZEZLv3UXwkGvqP22X9XqFneuY3SkrH4oEj1QxEeX8LIPscfSY7ZAOCASeiWs77UYgEpfntlx/oYiPyUmc4Q==
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
 by MEYP282MB2535.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 08:53:25 +0000
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00]) by MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00%8]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 08:53:25 +0000
From:   =?utf-8?B?6LCtIOawuOaelw==?= <yonglin.tan@outlook.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "quic_hemantk@quicinc.com" <quic_hemantk@quicinc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "loic.poulain@linaro.org" <loic.poulain@linaro.org>,
        "mhi@lists.linux.dev" <mhi@lists.linux.dev>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdICAgICBidXM6IG1oaTogaG9zdDogQWRkIHN1cHBv?=
 =?utf-8?Q?rt_for_Quectel_EM120_FCCL_project.?=
Thread-Topic: [PATCH]     bus: mhi: host: Add support for Quectel EM120 FCCL
 project.
Thread-Index: AQHYZpclpumYq2kRt0qDu6cacy5cWK0cfcWAgAACeMA=
Date:   Fri, 13 May 2022 08:53:25 +0000
Message-ID: <MEYP282MB2374E5218EC13705FB2835EBFDCA9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
References: <MEYP282MB23742A3646D681AF27BED85EFDCA9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
 <20220513084311.GA7659@thinkpad>
In-Reply-To: <20220513084311.GA7659@thinkpad>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [u96Shg2mvXS3FFfhaV0RKphvSNb0W6ma]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbee75d8-05ff-4be9-1432-08da34be0acd
x-ms-traffictypediagnostic: MEYP282MB2535:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uAgzi6gMaq2/5BWZUOQ2C2woHQ7RvsU0xT2prPaAcHHOTLEEURrQoZtLfxUpvTDUHlspR1ew64wzeD2BBB5wYTm0txWXA/2RcWdz9T69p5+cgR5HmoHILvh8iMB9xtcLDXnvHgcEsazDJ+oLulRLLf39cmv5TLFXdIVpHL4qFPeh9tksSeVGABKL2CvC9fXcgjvFKm+PCB3Uain0wp8RgZpJrCv1/RqurRBfJIHUsCWCorJ5/6vw+dUc+E2BU/HPSCqgmQbK+z8biDMpjnyKYKG0ECCPPehT+dipe/vqUslq69irBhgZVmFfKEJWWNvWCQRkTVpXZHTSe/ex76gnAEIb9UwffjMcFWMCQVkdN3OBYvhOoMxyLBONzTh/JGbooMMDws6TBlDGxzv2ybSCbZMyMb7zxoaWme+EseAHdrNOhqa2OGLdjFRI+NNXbkuwSN20OrCvu7LIR28+IR2JVhysIRMSGPR2xzIFjnbzIDoikS2IR/sM0miU9SyG77rIWYIkyiXwfaGz9+5W9S5PrtnUSk5byfP571y0p16jdi7pEYtBvHQzg4EmdRl1xS7ZfE5vKRRZV/OlVBFEd0uyNg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWZkQW9QS00yYWcrcDlmSktmNTdLUjVJcUFUTXhSVzk0eTJOQ2gzYWduWlhZ?=
 =?utf-8?B?Q3J2WjVzellQUlAxcHFFaFJYMlV1aURsTm1waGo5UG5pZVdjakRxblU1R0F2?=
 =?utf-8?B?Y0wwL1laSDRlbGRFejdWWmtrN2IxSXBGN0hUTmxwck41MVZ2V0ZQM0l1cXBT?=
 =?utf-8?B?Wm1ESWg3d2UxY2dKeEMzTU5HTWFKZ0JxVlVQVXBVOGNIbE4vL3NlOU5qVHMx?=
 =?utf-8?B?OU4ydjZmVlVwSDBxL1lzVE9TbWh4dHRXdk9tWXR0MjhHdnFKTE9TWFF6RG9p?=
 =?utf-8?B?RTRkbnkxTkdneWpsZkFnS0ZUeHlQQTVWVyt0YkRYclVOMElqRDNVcjNlR0dM?=
 =?utf-8?B?dFFSTHlvZW02aFhUdzFKS1VETGdSYkIzZ1M1TGVOQkZKVWgrQ1NOQlptZEM2?=
 =?utf-8?B?ck9ndnZCOG4yOXpUWW1ubXFhUWNUMGQybjFNeUJ0L1QyQk1RcnREZDhmcFBY?=
 =?utf-8?B?T3NwMlBrUEVMTis1dnpNMWZ0eU0rOU5KMEdDT1JYbUV5T25JSVYzbmJtbDY3?=
 =?utf-8?B?dGhYRXBFOGhhY000d2RSSW5obHVPWk94NDFMTEh4VnJ3aWcxbS9vbEh5UjZQ?=
 =?utf-8?B?WGQ2OGF6elVtRmV3YWhyaWIzbnUrdDRSNm9CRGM4SlZCTDJaTzF5dHFBRy9W?=
 =?utf-8?B?YlZSQVp2LzM5RUhQejkyUjdWMkhyU3I0U1VUeS9PNjNaaFBURU9VbHpXdk4z?=
 =?utf-8?B?NkVISkUzM1BVUHpQTmF5K0VtbUZ2bUVzeVYzbFlOVWtlbVhwd1ZLNng5WDNU?=
 =?utf-8?B?c0xBRWwvWmZqSWcvN29NbmFldEJEMnNLT0tiMEF5K2VicU1NNWU3dEJhY1I0?=
 =?utf-8?B?ZlFCc0kxTWs1VmN1VkxKelN0bFROM0MzZC9NM004Z0hjQ0VibEUvcVB1eHZY?=
 =?utf-8?B?a25hMFNPdjFac203Q3dyci9aSWFUYjg5Ykl1TnRVOGhPSW9adS83dEpWTEVI?=
 =?utf-8?B?WkNnY1FxczU0cE1hSzJoTWpEbFgyRmRrTG5iTFBkYVI4VzRJdmVtd3ZmRXNk?=
 =?utf-8?B?Y1JscTArMUd2RFdMRWY0WW9NSjZ1alVncndFZ1JhYlBjT0srdGJnOVJMOVZx?=
 =?utf-8?B?NXNSMEs0eFJHdXN1d0wySGRFOWJnQU52U0c4cnJFUjZpRFV1TkpOeHVGU1dN?=
 =?utf-8?B?TkZ5SkhWT3ovRzNhNzI4WW1yZXhqTGNNUFF5dUg1alcrNUdjeDZqTDlFdDJQ?=
 =?utf-8?B?Tk0zVXdGeVczdDRtb3p1OXRSTCsxckFWUFRYRllCUlliaFpjU1M2amJiaitz?=
 =?utf-8?B?Z2pvbnM1eXh5ME03RkdCTEh4NXoydmNKcVdwSWpyRzdpaHBVRmR2M2RxSXly?=
 =?utf-8?B?QTgvMzFmMFdNaXNiM3h5ZFNVV1hjRmZWNDRraVFlRittZU5KdlBsR28xUkRE?=
 =?utf-8?B?UFcrc3hmVlFFc1U0QXJIZEZxOERDa2NZYTVBUVk2M2Z6MkZueTNRdVZrRXZX?=
 =?utf-8?B?SURwMXo5Nlc5MEpxTFFJOFRNcHpxQloxcFRSYUFVWFlLeGMwejhpSHg0d3A4?=
 =?utf-8?B?akxNSGJWOFgvVkRUQldyMk1XQnBQQWIyVFpEU0NBNEx6bUgyT1JWZ0kva0V0?=
 =?utf-8?B?cytORzNtckNFNmlOMWszSlppWmY5QnZ5bnEvMW9uemVkRUYydEZoVXRleklu?=
 =?utf-8?B?SkQ3My9DbzVhTFp3QkREdi9FR3VRQU9BODZPeis5TEl3MnFhOTcyc1R2TUNz?=
 =?utf-8?B?bi9ySlArWWMwUlBmTlQ1TXhlVXlWanVoSGFSa2xZRExzNm1QNUZDL2F5VFdK?=
 =?utf-8?B?L0cxaEZGUFlwMmkva1pObTNpTE1DV3VvY05vd0VZejg0YWRIZ0VqbDNaQ1lN?=
 =?utf-8?B?dTk2K1JwNnI3aVNjOEM4a0ZKakJ2UnRZc1dPYW91c0JreDk2bEp1N2tKWXpJ?=
 =?utf-8?B?VEFOaWFiL1EvNktGYUVUT3JDS1BjNGhpcHdtRVVjalRrTnA5czhwRVROSFlh?=
 =?utf-8?Q?2PO/AU6qy5c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bbee75d8-05ff-4be9-1432-08da34be0acd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 08:53:25.5833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB2535
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBNYW5pLA0KDQpHb3QgaXQsIHRoYW5rIHlvdSB2ZXJ5IG11Y2guIA0KDQpCZXN0IHJlZ2Fy
ZHMuDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIDxtYW5pQGtlcm5lbC5vcmc+IA0K5Y+R6YCB5pe26Ze0OiAyMDIy5bm0NeaciDEz5pel
IDE2OjQzDQrmlLbku7bkuro6IFlvbmdsaW4gVGFuIDx5b25nbGluLnRhbkBvdXRsb29rLmNvbT4N
CuaKhOmAgTogbWFuaUBrZXJuZWwub3JnOyBxdWljX2hlbWFudGtAcXVpY2luYy5jb207IGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnOyBsb2ljLnBvdWxhaW5AbGluYXJvLm9yZzsgbWhpQGxpc3Rz
LmxpbnV4LmRldjsgbGludXgtYXJtLW1zbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCuS4u+mimDogUmU6IFtQQVRDSF0gYnVzOiBtaGk6IGhvc3Q6IEFkZCBz
dXBwb3J0IGZvciBRdWVjdGVsIEVNMTIwIEZDQ0wgcHJvamVjdC4NCg0KT24gRnJpLCBNYXkgMTMs
IDIwMjIgYXQgMDM6MDA6MjVQTSArMDgwMCwgWW9uZ2xpbiBUYW4gd3JvdGU6DQo+IEZyb206IHls
aW50YW4gPHlvbmdsaW4udGFuQG91dGxvb2suY29tPg0KPiANCj4gICAgIFRoaXMgcGF0Y2ggYWRk
IFZlbmRvcklEL0RldmljZUlEIGRlZmluaXRpb25zIGZvciBFTTEyMCBGQ0NMIHByb2plY3QuDQo+
ICAgICBJdCBoYXMgdGhlIHNhbWUgY29uZmlncmF0aW9uIGFzIFF1ZWN0ZWwgRU0xNjBSLUdMIGFu
ZCBFTTEyMFItR0wuDQo+IA0KPiAgICAgUmV2aWV3ZWQtYnk6IEdyZWcgS3JvYWgtSGFydG1hbiA8
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ICAgICBSZXZpZXdlZC1ieTogSGVtYW50IEt1
bWFyIDxoZW1hbnRrQGNvZGVhdXJvcmEub3JnPg0KPiAgICAgUmV2aWV3ZWQtYnk6IE1hbml2YW5u
YW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+ICAgICBT
aWduZWQtb2ZmLWJ5OiBZb25nbGluIFRhbiA8eW9uZ2xpbi50YW5Ab3V0bG9vay5jb20+DQoNCk9u
IHRvcCBvZiB3aGF0IEdyZWcgc2FpZCwgeW91IGRvbid0IG5lZWQgdG8gQ0MgR3JlZyBmb3IgTUhJ
IHBhdGNoZXMuIEkgd2lsbCByZXZpZXcgYW5kIGFwcGx5IHRoZSBwYXRjaGVzIHRvIE1ISSB0cmVl
IGFuZCBzdWJtaXQgYSBjdW11bGF0aXZlIFBSIHRvIEdyZWcuDQoNCkxldCdzIGdpdmUgc29tZSBh
aXIgdG8gaGltIDspDQoNClRoYW5rcywNCk1hbmkNCg0KPiAtLS0NCj4gIGRyaXZlcnMvYnVzL21o
aS9ob3N0L3BjaV9nZW5lcmljLmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9idXMvbWhpL2hvc3QvcGNpX2dlbmVy
aWMuYyANCj4gYi9kcml2ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jDQo+IGluZGV4IDg0
MTYyNjcuLjBhNjQ2OWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYnVzL21oaS9ob3N0L3BjaV9n
ZW5lcmljLmMNCj4gKysrIGIvZHJpdmVycy9idXMvbWhpL2hvc3QvcGNpX2dlbmVyaWMuYw0KPiBA
QCAtNTU3LDYgKzU1Nyw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBtaGlf
cGNpX2lkX3RhYmxlW10gPSB7DQo+ICAJCS5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkg
Jm1oaV9xdWVjdGVsX2VtMXh4X2luZm8gfSwNCj4gIAl7IFBDSV9ERVZJQ0UoMHgxZWFjLCAweDEw
MDIpLCAvKiBFTTE2MFItR0wgKHNkeDI0KSAqLw0KPiAgCQkuZHJpdmVyX2RhdGEgPSAoa2VybmVs
X3Vsb25nX3QpICZtaGlfcXVlY3RlbF9lbTF4eF9pbmZvIH0sDQo+ICsJeyBQQ0lfREVWSUNFKDB4
MWVhYywgMHgyMDAxKSwgLyogRU0xMjBSLUdMIGZvciBGQ0NMIChzZHgyNCkgKi8NCj4gKwkJLmRy
aXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSAmbWhpX3F1ZWN0ZWxfZW0xeHhfaW5mbyB9LA0K
PiAgCS8qIFQ5OVcxNzUgKHNkeDU1KSwgQm90aCBmb3IgZVNJTSBhbmQgTm9uLWVTSU0gKi8NCj4g
IAl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9GT1hDT05OLCAweGUwYWIpLA0KPiAgCQkuZHJp
dmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpICZtaGlfZm94Y29ubl9zZHg1NV9pbmZvIH0sDQo+
IC0tDQo+IDIuNy40DQo+IA0KPiANCg0KLS0NCuCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDg
rprgrqTgrr7grprgrr/grrXgrq7gr40NCg==
