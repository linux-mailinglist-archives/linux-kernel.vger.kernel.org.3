Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7CE58A09A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbiHDSia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238734AbiHDSi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:38:28 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020024.outbound.protection.outlook.com [52.101.61.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651B1606BF;
        Thu,  4 Aug 2022 11:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bpz3yapvZoSczNHRtcJxTnqRBW0kJjvkK3FJj1DYHzL3wGYrQg5+LQ4ZK54UX9R2/WlwA26hN+vgMXDgwRyGYXn6pcxSA2zFFs5AQyxWW9AnO5gWilPpJRYtGOjxmw8FjoY9yQxv6dglrAW2WPMeYamrqZGsFQL7ShbjdR/u4tApoJ0JENb+9/QslL3WirLD+YCXNFSkXgb+YyjiOhous7/Up8dsD5avENoiYRi2U9djKfqEIuBW5eSZgeLV2VgDNOFihhubjfJ4QuVte6guo+x70PbyOuhqZy/uJiGU7M6lQ+YkXDew6xc8/E6C4kcWu4rsmKAi2zx0WAaDOM9dVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6e+iAUEudKUPDs035F+o4SAu2VIyGnP1uW5yiBf9AU=;
 b=QOTGigqNJ5e9vnabVvD0RApTLfGLfQ52msBZhJ+CgbpI69Kj2QBBLL0VESxfmDeLpx7EoHsf1uUdRT1EitF0QOUxnUHnc59eY4GqKPlJnoyxrmcqNjBWkT0aKGBRZ6VsaVsDBxTQOq39pUGNK6LecKXEvZtbux+qwkXR0IC3LG0CNL7sV1BwuVDiDideXSEgssNtXJChLhRP8rR+4tuPVNuNylo/0rrn6Ug3L1YiagUA1WISTD0+dGK2ZxozOAsUqYAQXddfNdsT2wVQdZCqirh/G/4NHKFseje9jLnooIEfZZ+p4g/g5Skyo//Zl6SWL4JbF8aWfl+aYXtzg+T/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6e+iAUEudKUPDs035F+o4SAu2VIyGnP1uW5yiBf9AU=;
 b=ag41eyuFUelJefnH1BQYAP3cu/y5wRjpU0aehzSnJDQZ5NyzWCnDVtOVCqIODYX3KkWIHKc4ZbzvvIBkQ0fPMilRtolrPTOlzlG5WoVKQIQgF+uxlscZXZ/3BOn0tssml+FEzsCZcUpMHBS6w9LpdY2TiINfpmEIHManyHj2abA=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DS7PR21MB3221.namprd21.prod.outlook.com (2603:10b6:8:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 18:38:25 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::29af:3ad1:b654:63b8]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::29af:3ad1:b654:63b8%6]) with mapi id 15.20.5525.005; Thu, 4 Aug 2022
 18:38:25 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "song@kernel.org" <song@kernel.org>, "shli@fb.com" <shli@fb.com>,
        "neilb@suse.com" <neilb@suse.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH] md : Replace snprintf with scnprintf
Thread-Topic: [PATCH] md : Replace snprintf with scnprintf
Thread-Index: AQHYqCdHDWDt9Bp2wkWtl7Hg3K5n/K2fEjvw
Date:   Thu, 4 Aug 2022 18:38:24 +0000
Message-ID: <PH0PR21MB3025B7DD8FB6F44BF45334A7D79F9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1659633958-32756-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1659633958-32756-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=79346fa6-682c-4982-955e-7c0951afaf10;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-08-04T18:37:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e882e6a3-6224-4d79-de12-08da764883f6
x-ms-traffictypediagnostic: DS7PR21MB3221:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /PfygyawscBlhsxby7hq73Qbmly0rEOg3hBP+/6s0uxdI1hk/5mFQd9zLCAah6F1TRCHB68fQ/hqmzcKp1t72torslETMuHD1Kivh3nZrZjA4rhONDxIOh0D6B5uy5A5MTyfgFJZ9uU8QALLisNKAxGsQO/U1COn/lmiqo0vAFt8mYdkVZwk6ek0TW12WVmX7nxJlA5FRNaaOrz929dPohijnQmayrwFVouG+wMrNLm4KOMC8OSD/wBOBh46y9HTuXLaM3dyP6XYyUJhW/W6ibN2xXouJap2tyX/DAloS/2LOkYtzeZhbdI+SE8M5ggjsBFs8q/izP5ZAWB5s7ELXuF+nut2wXItnBTmqzCAOIEeoeC27zBWo76CDF2/1K62gIkrmDL3nCNmGwucXcFA3ta9wq/6HDO/6MfIsAD42L7eEY538kTyjNwueNU5JkDGMB1f4+HSFcTQcM1OTPFwSOfUwbw52mYgDsbl+bOiDN6iejoWGTfYIX5HtRAGWcg+40DQ+d/SzRMulfSkbuh/h2J3/z8TAISZ6aJ26jto4xmoxsEkcYGyI9DNE3y1W3goyg6Z2P0xWxNMVx1F1O6bCuEgyAUENFalPuUey3trq0Y1IwGyIs9f5oAoLDNNpq0UNVupwupQWhx0NfYlTfboRzqaXIeYFzz0W+gZc6+pEDoLNCY3tMEUrGiIpKS9hYs6rniHUequjprFqCRFmwlrSxMj/2TdI47/E/VsmoV/w1PssBwQFRzVHnoOQDwTSt7xQwhgQAdGEhz+TkI9fK9vl9RFt2d8XDD52J2FnrSLYvZmpZMoDHWAbFTQE1FqrOpGBwserTzxi+dB3fR7dLP5M3wERrVSDit8+9KIydIClZk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199009)(122000001)(186003)(38070700005)(38100700002)(7696005)(110136005)(8936002)(6506007)(6636002)(10290500003)(478600001)(2906002)(52536014)(5660300002)(316002)(66446008)(86362001)(82960400001)(82950400001)(26005)(8990500004)(66476007)(76116006)(66946007)(55016003)(41300700001)(66556008)(83380400001)(71200400001)(64756008)(9686003)(33656002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amdNMkFtT0RYamtTMi94MlFQeUtmV2IzNXFqcVhEUTZZOFV1NVRjeGpBemMv?=
 =?utf-8?B?VUZoM2xLZm0rU0NBZEF6eGxTVHY1SzRiUDZ0Mko2NzZyaUFrTFB1dFhwZVJ0?=
 =?utf-8?B?SmxGbk5KSWJnSWxDOUFLOTREaUJqY2ZtVzczbkZaRHpzamlUOG54R2Z4YzRP?=
 =?utf-8?B?cXJHRDRUb2xjY2tGWloweloyUG5aRFRyMTJ4ajNPZG8xSmNYVVlXUVdRMC9G?=
 =?utf-8?B?b2JPS2VFTUlXLzNvR2k1d1kvUkdUMndpVlNUbGNnaW5xM1Z2Nk1JM2lZWm1m?=
 =?utf-8?B?SDkrd3BXOFJWcTNia3o2TUt0VWMvbDdVMG54aVJYejVDamdDSkt1NkdxczFr?=
 =?utf-8?B?T2gxQWxmdldlWEFEQTM0ejRXd0NaR2tmZjlvcU1VY091Z08xY0djK3ZnQm9L?=
 =?utf-8?B?emZIZ1FEemhtaFJEampnY1hWMW1jMFlQbm82TTFtN1ZXcC9VTEkwNUtlUkE4?=
 =?utf-8?B?K3VuSEIzVmlQd3BRNGhjbnNMK0xmQ1BQR2tPc01uSjl1OTF0R3V3ZjBNeDd5?=
 =?utf-8?B?SmI0V21SaTN5NStUSmNWelFIOVR5YUN0SlB1bXRneEtPaG1KUWVxMkhyNTZ4?=
 =?utf-8?B?Nkt6TTN4YW1tMzFIR01Ddks5TGFEaXVlTTlMa2pET2ZiaHplNENIUmEwdkxB?=
 =?utf-8?B?VzA1Nzh5b2xhZmpXcGl6Ny93THJSamVWYkc0cGoyWXZ6aVRVSHB0bnZoTFVW?=
 =?utf-8?B?SzR6L0hCUWppTnBGY1BneHd3MmdBZldZZ0dtT2VzS0ZrR1pNN3g1UmNrRjBq?=
 =?utf-8?B?YlQwQlo5WTFURUxNL1lucEJDWGYrUkFzdnN2Z1JLYXh5bVVLb3BQaFhoZTZW?=
 =?utf-8?B?VFN4SFpYUzZwVXlJZzdBdlRyK0I2MDNZNk5obFNSdVdlY25GM1lVS2ZpUGxN?=
 =?utf-8?B?RjlSOUNDVGM2NC9XVjVIN3ZlU045TkpMdlNEWkREekFGRE90bzlxMGROT25a?=
 =?utf-8?B?Qk1uRTkrS3QvU2JQcUhwOHQwMUJYNzRnTUJwSXllV1lmdEh2Qk5qUHRScW1L?=
 =?utf-8?B?TVFnMVBUdURJRk03N013dUVUUXl2QWo0cVF1MlRuVFd0RGJPZWdzTUNyRDhp?=
 =?utf-8?B?SnhoQlBXdFBwY3NBNU41K1dYVVZtd0MrdmM1cEozRDFCNFp3aDZ3YW5iOFRo?=
 =?utf-8?B?SURmK21sVUkyNmZwN0VyV2lQQ0dLTzRpazI5Um1DUWovTVVuU05qY0NwUlB4?=
 =?utf-8?B?NU54V0pzVjBscGQ1YWUyN2loTFpHTVA3N3Fvek1oNWJka3FLWG03UWRycTB2?=
 =?utf-8?B?cDhXZ2ZET0ZuVkNyRkJvSXFwZ2t2Y2xRME15WlJ0eUZBa2Y3ajFTa1g0S0h2?=
 =?utf-8?B?aHNUZUdEREtPUEM0dm9VRk9sMlhxajA0a1AyazJYQTJ4aGVGSndxdUpwbUVm?=
 =?utf-8?B?OHJGUVI2Q1NwZk1SbHZmZGl5bDJXMHMzZHduSWhkRTZVUC9NTy80aHFCM01L?=
 =?utf-8?B?VUI2bzZ0RllTU2t6VFVsbVZHaExQOGlONjAyTmZGRUlvendPZ2hYWDk2Wkxj?=
 =?utf-8?B?VzU3YTNIbHd5NFJqMDdSOC9zSnB1d2RIV3Q1RHBYb3MwUnZDUGwwamRFOW9o?=
 =?utf-8?B?VzVobmFkSmQ1Vk4raVVtVWZRTWQ1T1hiY3pFalEvSmRDb3RKUGxaRVNFcFA3?=
 =?utf-8?B?OVFkV25raVlzVmU5ckZsajFlOUZvUXB0T2xxWGlURWNCSllmS3pzVVYwNWZr?=
 =?utf-8?B?cFZ1MHR3MG1hV2ZmblhoU2ZOUytxN3NlYnpSRndmNVRwaWMxSE5IS3NWdElX?=
 =?utf-8?B?c3lUQm5CSzJ3czZZWmxPOS95Q21xbVg0bVFyQ3U0aFY3MWpaTllJTFBtSHEy?=
 =?utf-8?B?blBwTzloY21lTm5pOFJpMm1CaGtmb091eXJvWlk1c0VMZ090OHBiU2djazdk?=
 =?utf-8?B?RlRWSTQ4VElhVzVwUGtURXFHR0EyWitTQXpkRXM4Y2F1R0hkb0hWd2R1Y2xQ?=
 =?utf-8?B?QVpOUWNDVUU0eFJiaDZJSXRXN2RDNHk2OHJITGk5L2gxMER0U1d2Tzdmb0xo?=
 =?utf-8?B?cFQ5dWU5dk1sYnVrR09jRXEyOVAwOGhPM0FFMzVZSFNFOFFsMUJOaE1ITitr?=
 =?utf-8?B?U0hnemtEMkdXY09iUGYyeXhvZ0tOV3dRUXJSU0Qwd2RnQnV1djVFdnU4a2tU?=
 =?utf-8?B?N0FwWWY0SFkrWnUrRHhrakUyKzNSN25neE96d2hkNy95dWVUN3o5aUY0Yld3?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3221
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2F1cmFiaCBTZW5nYXIgPHNzZW5nYXJAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDog
VGh1cnNkYXksIEF1Z3VzdCA0LCAyMDIyIDEwOjI2IEFNDQo+IA0KPiBDdXJyZW50IGNvZGUgcHJv
ZHVjZXMgYSB3YXJuaW5nIGFzIHNob3duIGJlbG93IHdoZW4gdG90YWwgY2hhcmFjdGVycw0KPiBp
biB0aGUgY29uc3RpdHVlbnQgYmxvY2sgZGV2aWNlIG5hbWVzIHBsdXMgdGhlIHNsYXNoZXMgZXhj
ZWVkcyAyMDAuDQo+IHNucHJpbnRmKCkgcmV0dXJucyB0aGUgbnVtYmVyIG9mIGNoYXJhY3RlcnMg
Z2VuZXJhdGVkIGZyb20gdGhlIGdpdmVuDQo+IGlucHV0LCB3aGljaCBjb3VsZCBjYXVzZSB0aGUg
ZXhwcmVzc2lvbiDigJwyMDAg4oCTIGxlbuKAnSB0byB3cmFwIGFyb3VuZA0KPiB0byBhIGxhcmdl
IHBvc2l0aXZlIG51bWJlci4gRml4IHRoaXMgYnkgdXNpbmcgc2NucHJpbnRmKCkgaW5zdGVhZCwN
Cj4gd2hpY2ggcmV0dXJucyB0aGUgYWN0dWFsIG51bWJlciBvZiBjaGFyYWN0ZXJzIHdyaXR0ZW4g
aW50byB0aGUgYnVmZmVyLg0KPiANCj4gWyAxNTEzLjI2NzkzOF0gLS0tLS0tLS0tLS0tWyBjdXQg
aGVyZSBdLS0tLS0tLS0tLS0tDQo+IFsgMTUxMy4yNjc5NDNdIFdBUk5JTkc6IENQVTogMTUgUElE
OiAzNzI0NyBhdCA8c25pcD4vbGliL3ZzcHJpbnRmLmM6MjUwOQ0KPiB2c25wcmludGYrMHgyYzgv
MHg1MTANCj4gWyAxNTEzLjI2Nzk0NF0gTW9kdWxlcyBsaW5rZWQgaW46ICA8c25pcD4NCj4gWyAx
NTEzLjI2Nzk2OV0gQ1BVOiAxNSBQSUQ6IDM3MjQ3IENvbW06IG1kYWRtIE5vdCB0YWludGVkIDUu
NC4wLTEwODUtYXp1cmUNCj4gIzkwfjE4LjA0LjEtVWJ1bnR1DQo+IFsgMTUxMy4yNjc5NjldIEhh
cmR3YXJlIG5hbWU6IE1pY3Jvc29mdCBDb3Jwb3JhdGlvbiBWaXJ0dWFsIE1hY2hpbmUvVmlydHVh
bA0KPiBNYWNoaW5lLCBCSU9TIEh5cGVyLVYgVUVGSSBSZWxlYXNlIHY0LjEgMDUvMDkvMjAyMg0K
PiBbIDE1MTMuMjY3OTcxXSBSSVA6IDAwMTA6dnNucHJpbnRmKzB4MmM4LzB4NTEwDQo+IDwtc25p
cC0+DQo+IFsgMTUxMy4yNjc5ODJdIENhbGwgVHJhY2U6DQo+IFsgMTUxMy4yNjc5ODZdICBzbnBy
aW50ZisweDQ1LzB4NzANCj4gWyAxNTEzLjI2Nzk5MF0gID8gZGlza19uYW1lKzB4NzEvMHhhMA0K
PiBbIDE1MTMuMjY3OTkzXSAgZHVtcF96b25lcysweDExNC8weDI0MCBbcmFpZDBdDQo+IFsgMTUx
My4yNjc5OTZdICA/IF9jb25kX3Jlc2NoZWQrMHgxOS8weDQwDQo+IFsgMTUxMy4yNjc5OThdICBy
YWlkMF9ydW4rMHgxOWUvMHgyNzAgW3JhaWQwXQ0KPiBbIDE1MTMuMjY4MDAwXSAgbWRfcnVuKzB4
NWUwLzB4YzUwDQo+IFsgMTUxMy4yNjgwMDNdICA/IHNlY3VyaXR5X2NhcGFibGUrMHgzZi8weDYw
DQo+IFsgMTUxMy4yNjgwMDVdICBkb19tZF9ydW4rMHgxOS8weDExMA0KPiBbIDE1MTMuMjY4MDA2
XSAgbWRfaW9jdGwrMHgxOTVlLzB4MWY5MA0KPiBbIDE1MTMuMjY4MDA3XSAgYmxrZGV2X2lvY3Rs
KzB4OTFmLzB4OWYwDQo+IFsgMTUxMy4yNjgwMTBdICBibG9ja19pb2N0bCsweDNkLzB4NTANCj4g
WyAxNTEzLjI2ODAxMl0gIGRvX3Zmc19pb2N0bCsweGE5LzB4NjQwDQo+IFsgMTUxMy4yNjgwMTRd
ICA/IF9fZnB1dCsweDE2Mi8weDI2MA0KPiBbIDE1MTMuMjY4MDE2XSAga3N5c19pb2N0bCsweDc1
LzB4ODANCj4gWyAxNTEzLjI2ODAxN10gIF9feDY0X3N5c19pb2N0bCsweDFhLzB4MjANCj4gWyAx
NTEzLjI2ODAxOV0gIGRvX3N5c2NhbGxfNjQrMHg1ZS8weDIwMA0KPiBbIDE1MTMuMjY4MDIxXSAg
ZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhOQ0KPiANCj4gRml4ZXM6IDc2
NjAzODg0NmU4NzUgKCJtZC9yYWlkMDogcmVwbGFjZSBwcmludGsoKSB3aXRoIHByXyooKSIpDQo+
IFNpZ25lZC1vZmYtYnk6IFNhdXJhYmggU2VuZ2FyIDxzc2VuZ2FyQGxpbnV4Lm1pY3Jvc29mdC5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tZC9yYWlkMC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tZC9yYWlkMC5jIGIvZHJpdmVycy9tZC9yYWlkMC5jDQo+IGluZGV4IGIyMWUxMDEuLmI2
ZjBmYzEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWQvcmFpZDAuYw0KPiArKysgYi9kcml2ZXJz
L21kL3JhaWQwLmMNCj4gQEAgLTQ4LDcgKzQ4LDcgQEAgc3RhdGljIHZvaWQgZHVtcF96b25lcyhz
dHJ1Y3QgbWRkZXYgKm1kZGV2KQ0KPiAgCQlpbnQgbGVuID0gMDsNCj4gDQo+ICAJCWZvciAoayA9
IDA7IGsgPCBjb25mLT5zdHJpcF96b25lW2pdLm5iX2RldjsgaysrKQ0KPiAtCQkJbGVuICs9IHNu
cHJpbnRmKGxpbmUrbGVuLCAyMDAtbGVuLCAiJXMlcyIsIGs/Ii8iOiIiLA0KPiArCQkJbGVuICs9
IHNjbnByaW50ZihsaW5lK2xlbiwgMjAwLWxlbiwgIiVzJXMiLCBrPyIvIjoiIiwNCj4gIAkJCQkJ
YmRldm5hbWUoY29uZi0+ZGV2bGlzdFtqKnJhaWRfZGlza3MNCj4gIAkJCQkJCQkgICAgICAgKyBr
XS0+YmRldiwgYikpOw0KPiAgCQlwcl9kZWJ1ZygibWQ6IHpvbmUlZD1bJXNdXG4iLCBqLCBsaW5l
KTsNCj4gLS0NCj4gMS44LjMuMQ0KDQpSZXZpZXdlZC1ieTogTWljaGFlbCBLZWxsZXkgPG1pa2Vs
bGV5QG1pY3Jvc29mdC5jb20+DQoNCg==
