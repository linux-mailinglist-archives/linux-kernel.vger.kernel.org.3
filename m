Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816B24B8633
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiBPKyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:54:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiBPKyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:54:37 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4272C29C129;
        Wed, 16 Feb 2022 02:54:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zmxu+zE8ohF00sU/ZbR901KOslo7YrFuTdsgerv+GYSuFcD7QiCXrgLkI+CTs3RKM+jYOZ+Hvrku6xjsKvEFPjt3QEGmBK2K/utGgZ5Np3z9VwSUTZ6N8jYfZ8pvXziymvFfkKISLwek9baPIKsfubWGEoFekfuUM3KOJ/Zayzp/zSLGlQy278LSU7/AXd0HhR4la6/wHUkuufqRks+QvgSkBFUvhgh8d91GMwDgc2Pd8cbWrf2cf+ZJCnixmm90OksE8uhRV7F0ELhmjxKo/FAl1VT5SGw5uSxlzmNe383xuaeK8HcrPPcW/PCp/UM7FxK3jOJhnOaT5zNoltHHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0yTrO+NAtgPSv+nKwwpFLn6jyYRrd+eaNTRgRhNcmE=;
 b=H/CSy1G8JctM49Zq7EyeoVmYY+0Bup4qUKhFzwP0hJZSiyX5NTJwNUIAYD21r0482n4pPWI6+KF993QHU2gUl7PR3GK/W9ahYwv9xQNjaUVWwDxqymdfZWM7YNQNL8zC+CIhdWs/ZqWAhQ8dK8n91zgBLgz50IkaqlcttrDiepRNyc/kxIm8yYvg5235A7xqGnYXb18tliC8xJYHDjq8Aal9xOeXtTle2CwFoSZB95xgQYmnRomX/G98hxuy351O668goQVoHLLQNAhxfzn7MFMSV0maZME7hs8oxJnKHwLLj98yuUhOB5XnInpof5Kf0pCO2Uh8j2PRgqplju/TxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0yTrO+NAtgPSv+nKwwpFLn6jyYRrd+eaNTRgRhNcmE=;
 b=SoThXAEflFDDbVKaqjiUMLl0RJ6qIrA5oylZuI02zR6WVpUNYnpuEgetRmWu1AIm8cPO1jWwKViGRWrRQvtMUTHNQ2aDTYYuvq00Q4uBYZLs7Zi9vOfQapzdQo1d+m0b9HdAgov60d9r9mSxaIUmqkLElAzLNgyOxBZB/RuPxxIyfALGL2ijRW9ktLbhoNWVjCMFaKEulq1JBFcqtxjhntvIL/TL6+j6Yepb+UZ8tTE+wyelw0xjnNunJzD+BRfs4mTwa1WwESm3CU/Grlq3qhENtFbaoxEaWeY4E8vGe8IZB2cRPmMfD+og2/UQK4ryckhwBh/6sn2FNVvbDhOnxA==
Received: from DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Wed, 16 Feb
 2022 10:54:22 +0000
Received: from DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::83b:60bf:1e58:de83]) by DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::83b:60bf:1e58:de83%7]) with mapi id 15.20.4995.015; Wed, 16 Feb 2022
 10:54:22 +0000
From:   Mohan Kumar D <mkumard@nvidia.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 5/6] dt-bindings: Document Tegra234 HDA support
Thread-Topic: [PATCH v3 5/6] dt-bindings: Document Tegra234 HDA support
Thread-Index: AQHYIxbVqVzdstgNL0mQn0BEminaCqyV+g4AgAAGRKA=
Date:   Wed, 16 Feb 2022 10:54:21 +0000
Message-ID: <DM6PR12MB4435ABC8098A6C3EB2357B47C1359@DM6PR12MB4435.namprd12.prod.outlook.com>
References: <20220216092240.26464-1-mkumard@nvidia.com>
 <20220216092240.26464-6-mkumard@nvidia.com>
 <2249cf46-5c54-2e59-f247-5a22f2e6e5b9@canonical.com>
In-Reply-To: <2249cf46-5c54-2e59-f247-5a22f2e6e5b9@canonical.com>
Accept-Language: en-US, ta-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a2fa744-ac2d-4690-5c40-08d9f13ab06e
x-ms-traffictypediagnostic: SA0PR12MB4479:EE_
x-microsoft-antispam-prvs: <SA0PR12MB4479239CB57D88EFAF21D01DC1359@SA0PR12MB4479.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K2jm1Flk+TISG0MnuTetoP3dw5uG9DqfciZQPr7tYWsR3F0nuc+7jybKBZMHocniObGCqi7hu9xVJcoMk4AWvzczkKoYZwrgURuNLAYV1Q5kPf9f4ym51M448MCpB58Tc6pyWWNEiFMgra0XaOjazzQax63c7tB1IV1/XA6qAAsoF62X2VASKNyT7uFEQ+mHiA7tpwMMb1vh8B019y1mnfII1HptlB8Dw/WpQaTa3bD0QQCVugAKA/rIzO53SuiVW9skd4fq0dDVe4dX5ColLLbWqysARiILCn7OHycuH+tTWG73ao+j8+cTWzoT9G8SrTHK6dwk0xopzJO0bNTrILGwjeiXSHLFV4gCouf9HOhU4sBWWcf+3HnHUAzC2iHYcwNePtTyPe6Fqiq/q2yu0iVH8di1PlH2x0NkiZDjDOB3E1TdWKlK/2xPPNU53Y+wMGvK0pwCqqfkeMpOXpZqZyE0ZpMleG3HsSThT06nD12WKcaytAGuzox6Rn8rBlm28XV4UT0y29fY3NHVFRa7oxh1HFTjVkxcb7H4QvViQRXO85jFO+iIzV4DuC4fuSVp92tHhKEfJAwTKji5sEzd/nVFCzkFoXh6mDaHo/qeIJXa7DIwK5ORGKQfjJ5QzcugRsDoShlrmCnv3TmID1a6/EgChcjUMpDdrizkmXSTRl58oQGqJkDweLfDKkns7Z4lL+mESGic2thflHvX4UUMbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(9686003)(186003)(66946007)(122000001)(6506007)(55016003)(508600001)(2906002)(110136005)(5660300002)(54906003)(6636002)(71200400001)(38100700002)(33656002)(52536014)(7696005)(66476007)(76116006)(38070700005)(64756008)(316002)(53546011)(4326008)(83380400001)(86362001)(8676002)(66446008)(66556008)(8936002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzBjZ0VnbzlIZmxFbHVyYmpHTEZVdllrdXJva3RsOWVDV1pmMkZvdG1QTkh4?=
 =?utf-8?B?RjZVSi9ySGw2cWI1QW9UY2c0VHAvQ3BWS3FjbC9CbFFra3VGY3doU2t0Zjhl?=
 =?utf-8?B?MzZyV2F3YXNNT1JGQmR1RS9kQlMrVTFESG5sUG90VWVydUhoMWpmd04vM3Fw?=
 =?utf-8?B?WlVTUXFZK2Rab0twRzhtKzFjdDZoeTlZMjhVL1h0U2JYZ3ZvRGJLZmVBSzdX?=
 =?utf-8?B?bHdJQUVhRnVCdXRzblNsZ2NKa0E5Y284S0lSWHRnT0w5ZW1zYzdKS3paTmlq?=
 =?utf-8?B?dDE0Vk9HZWpOMitLOE90RFBYZElTTjRUaEJNTWdvOThEMXhqSWdNcUxmVWFK?=
 =?utf-8?B?cmlxZkFxdXpBODRnaWF1c2FkcW1RSjkzam9SWC8raGhFdUkzS09FZVNPWGc3?=
 =?utf-8?B?RVN2RHBBdUd6eUZ2V2Fzb3hocDZDcTlLQzJkTXBUajNNK3VZd0F4RXVmODhx?=
 =?utf-8?B?anBkOEUwb2U5Wml2bURFS2tCV3JpUUw1S2NpZXdrd0pRR1dQZThXaEdsc3RU?=
 =?utf-8?B?WU4raWVCV2RwYk1IQ0ZiUFdCL1VZUURNbUxWcHhaL2ZsY1NoOGtUZDM3dW5D?=
 =?utf-8?B?WE1qb2ZWZE5obU00Y2YvZXBWYWt2b3ZZSWIrcjB5eUwwa0F1WHNobnFkVm9x?=
 =?utf-8?B?SUx1U1FPVWdqUi9nbzBHeXQzcmcrb2lxZkZvU1diUlZkZUgrMUljZlJvK05x?=
 =?utf-8?B?YWdTTFBueWhIKzNWckRPdVlaU0R5eTA1aVVoSmhpUS9OaC9Rd2thVnlYcUNB?=
 =?utf-8?B?bS9zeFBJaEllUXF4NEhJQ1JreE9NVHpyeW5MUm1kWXN6dHBnSnVvdWVpdi94?=
 =?utf-8?B?bkRuTjJyYi9iWUg3WnhxUi94cmlBZGsvN1djc3lCRk0zU3NvTVB2c0s1RkNW?=
 =?utf-8?B?Rm90ekx1OGRQd3hlNitYcjdDZjJmcmV5elVuZTZDY3ZQVVVEdkRKS091U0lo?=
 =?utf-8?B?bWlIWHBIakJMbENSU3hZL05zUTUxM2I1MUdJZHcxQys3bFlkRFBtRi8zbGZE?=
 =?utf-8?B?aTN1NVlMSnR1NW1DeTVIUHZEWkxtY2xPVjdsNVVyYjlJZTBmbGwrbEk3R3px?=
 =?utf-8?B?UjNIZ0FhVFFVV2puejdzYTQwRFJFNldHMUJiTzFKTVVlOVFHSTl1czVKUWpI?=
 =?utf-8?B?SmVPZU9TeGpFRlMya1VTTU1lMHI0cFRWTVBDTVdRbFFzaW5HVGtReXNvcEhG?=
 =?utf-8?B?ZzkraHZGUmdhNXNZOEVySTRsT3BuTEh3dmttZmFkU1JuVG9tOHFHM1ppLzJT?=
 =?utf-8?B?Y2dTUTYrMWZERUtKZ2pITTVZbnJpSlVCUEpjaFl1VzM3MmJsdzlzbEx0VDZH?=
 =?utf-8?B?YVM4Y0tkcFpYYU1paHc4NUxhWVdNNnExM0tHU2YwMDc3NHl1OWZwc1VFNjhr?=
 =?utf-8?B?Q0xSQWFVUFNNb3BsZjlDWkpVZkdyUUNaWmM5Z0tpemNleiswR0VUc3Nqd3pC?=
 =?utf-8?B?MlNwVDNwWktlUi9jb3BtS0VnYy9MTHU0ZjhVa28ybjRFRWU3MmkvYUdCcGpv?=
 =?utf-8?B?a1IzMlhMcTh2ei94Q3lrWGxZcUR4UWlNU2pvV3UrVENkMDhSUXBUNXRNWDY5?=
 =?utf-8?B?dU42bHNzQkc5eVZXSW5wR3JsOS90bXdyaWZERW1jYlNCMGR5OG9DTUkvWWtZ?=
 =?utf-8?B?cE5IcHhrT0lWWW1OZlV2SVNYb0M4VUtUTk1Rc2M1bnFTWnRlbCtpWFJqVjF0?=
 =?utf-8?B?WHFoWVdKMUJTS0NWVTVrUEFYekYxZ1ovSkpJbWgyQ2xVamVkbUY3YkYxV3pI?=
 =?utf-8?B?QnVtU1dOS29WamdhbjZDUThOejhJa2dZQjNxUnpWTzRha0YyaStQNEd3RjF0?=
 =?utf-8?B?UkRhVlo1OW8zb2JSM3Awa2x0VS9hQkJZTkZpNjBSaTAxNW95SWVkWThWOHZZ?=
 =?utf-8?B?QjlEOUZWUzVEa3M4MnFqYzhHdHYwUSt6bXpJckcrTDVkVFpEUFNOTDgzcXNv?=
 =?utf-8?B?anRHRjZuRDhJRktwN3RDOHorelMwbUZiY2ErZ0pIdVRNbVBjSFJ1TXcwRDFP?=
 =?utf-8?B?WXRzeVMyc3d5ZDV5Z201T1dOWm5ZSGM1dzNzKzc1UEtRL3hUd0h3OG4wQ1NO?=
 =?utf-8?B?UXZta0gxN3AvaDhuQnpQYnh4WVVaS2VSci93QktVUXRWNVhuOEpXYU9LU2d3?=
 =?utf-8?B?UXdnSzl3cFFIc21xc25HSWVDcFQzUkl0eTlXbnExYXpzTExpdzNlM3pkcHE0?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2fa744-ac2d-4690-5c40-08d9f13ab06e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 10:54:21.9430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZA0FzPUsf/jwjNtAUATcL95C5rjWR682F0rHVYzWzcg/1yFwJv4p9YdXfX1zSdF1YzcdF4j625FTS74njYjclQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwgDQpUaGUgY3VycmVudCBvcmRlciBpcyBpbnRlbnRpb25h
bCB0byByZWZsZWN0IHRoZSBuZXctPm9sZCBjaGlwLCB0aGUgdG9wIGVudHJ5IGlzIG5ld2VyIGNo
aXAuIElmIG5lZWRlZCB3ZSBjYW4gYWRkIGNvbW1lbnQgdG8gcmVmbGVjdCB0aGlzIGluZm8uDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxr
cnp5c3p0b2Yua296bG93c2tpQGNhbm9uaWNhbC5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBGZWJy
dWFyeSAxNiwgMjAyMiA0OjAwIFBNDQpUbzogTW9oYW4gS3VtYXIgRCA8bWt1bWFyZEBudmlkaWEu
Y29tPjsgYnJvb25pZUBrZXJuZWwub3JnOyBsZ2lyZHdvb2RAZ21haWwuY29tOyByb2JoK2R0QGtl
cm5lbC5vcmc7IHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbTsgdGl3YWlAc3VzZS5jb207IEpvbmF0
aGFuIEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5jb20+OyBTYW1lZXIgUHVqYXIgPHNwdWphckBu
dmlkaWEuY29tPg0KQ2M6IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXRlZ3JhQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCB2MyA1LzZdIGR0LWJpbmRpbmdz
OiBEb2N1bWVudCBUZWdyYTIzNCBIREEgc3VwcG9ydA0KDQpFeHRlcm5hbCBlbWFpbDogVXNlIGNh
dXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KDQoNCk9uIDE2LzAyLzIwMjIgMTA6
MjIsIE1vaGFuIEt1bWFyIHdyb3RlOg0KPiBVcGRhdGUgYmluZGluZyBkb2N1bWVudCBmb3IgSERB
IHN1cHBvcnQgb24gVGVncmEyMzQgY2hpcC4NCj4NCj4gVGVncmEyMzQgaGFzIG1heCBvZiAyIGNs
b2NrcyBhbmQgMiByZXNldHMgd2hpY2ggcmVxdWlyZXMgdG8gYWRkIA0KPiBtaW5JdGVtcyBhbmQg
bWF4SXRlbXMgZm9yIGNsb2NrcyBhbmQgcmVzZXRzIGFzIFRlZ3JhIGNoaXBzIGNhbiBub3cgDQo+
IGhhdmUgbWluaW11bSBvZiAyIGFuZCBtYXhpbXVtIG9mIDMgY2xvY2tzIGFuZCByZXNldCBzdXBw
b3J0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBNb2hhbiBLdW1hciA8bWt1bWFyZEBudmlkaWEuY29t
Pg0KPiAtLS0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL252aWRpYSx0ZWdyYTMw
LWhkYS55YW1sICAgICAgICAgIHwgMyArKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKykNCj4NCj4gZGlmZiAtLWdpdCANCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc291bmQvbnZpZGlhLHRlZ3JhMzAtaGRhLnlhbWwgDQo+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL252aWRpYSx0ZWdyYTMwLWhkYS55YW1sDQo+IGluZGV4
IDJjOTEzYWE0NGZlZS4uMTJjMzFiNGI5OWUxIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbnZpZGlhLHRlZ3JhMzAtaGRhLnlhbWwNCj4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL252aWRpYSx0ZWdyYTMw
LWhkYS55YW1sDQo+IEBAIC0yMyw2ICsyMyw3IEBAIHByb3BlcnRpZXM6DQo+ICAgICAgICAtIGNv
bnN0OiBudmlkaWEsdGVncmEzMC1oZGENCj4gICAgICAgIC0gaXRlbXM6DQo+ICAgICAgICAgICAg
LSBlbnVtOg0KPiArICAgICAgICAgICAgICAtIG52aWRpYSx0ZWdyYTIzNC1oZGENCg0KV2h5IHB1
dHRpbmcgaXQgaW4gbm9uLWFscGhhYmV0aWNhbCBvcmRlcj8gQWx0aG91Z2ggc29tZW9uZSBwdXQg
bnZpZGlhLHRlZ3JhMTI0LWhkYSBhbHJlYWR5IGF0IHRoZSBlbmQgb2YgbGlzdC4uLiBoYXZpbmcg
dGhpbmdzIG9yZGVyZWQgaXMgaGVscGZ1bCB0byBhdm9pZCBjb25mbGljdHMgYW5kIG1ha2VzIGNv
ZGUgZWFzaWVyIHRvIHJlYWQuDQoNCg0KQmVzdCByZWdhcmRzLA0KS3J6eXN6dG9mDQo=
