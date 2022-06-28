Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7865455E1D9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244183AbiF1ISl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244154AbiF1ISN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:18:13 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120051.outbound.protection.outlook.com [40.107.12.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394D02ED4C;
        Tue, 28 Jun 2022 01:16:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhEP9Emu8dAOQrBwx8TDooqxBqe3+f+lauh9qCrNmErGq/XrjUl5QzJltYZtnAeQRC92zhVtAlThQSgFGBRfk9ck8WJfv8Hzap/+oizYCkYs2iT3wegfnp8lCaWc5VoXioDX7kwpMz90GHej7OPBg6kMV4rL5HsvWeaoc1DTvMf4UeOL8SkT2z3JsIKB/fPMg0nDsDdunqXz4vMDY5s/jBq8sU0Qy1elRjY9Spgjxugj8jVq8agreiLg7X2QdoUHiappAfJAXvpHYI88ECzfNUda+3K9rhAhLZYv1VNwD4rBQRJUe+508iim2daMAgSsVjEtOan9iR+eXePCvbw0Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/KoQXqzSvXLUUiDYTuAg/FqCmWv8II+1Y6OEjjcnVg=;
 b=AxTzd0qg8YWg+ri1Rycj1aqBifAkjZSdJL1lhHc8Sb6n29+NsDEbQ6zqhmwSem0e/X4vivyuUkcIFG3mW0xel+FpOFipj/rWo6iGvdW1vEUfIlMTI6RmslJDM2MO/vWRLfkZYKKj4dai63O3ZFwWsBrGo+g+kteCda+GhF/7mMcfwk2uODEB8TGIc+xFzjBYGmNuWr0m+oK+Ism0Jyv8YoetwMadp/rm+dbQMMfVThat7UbKI8Xur9t9Z0NJat1aW1BZqCVjSxtvSTXduVnkP1uC/Ppa+0Od6LIhW5horoU36O3yOSlEFhcGZk6KpFwye7YyGXwm2ZhgbktLfq63Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/KoQXqzSvXLUUiDYTuAg/FqCmWv8II+1Y6OEjjcnVg=;
 b=enxMx2t+l+npQ3TX6fA2Zg33O/L8gOCT+GxbkwNtFonHH3P4fTOgEnj2+fKxX4ZOzo07jIgYWfTfdhf/lNnr1DnmGJxSp/5tDr8baO25PKlwKC3+/tCI3iJNzXLQsonfbFnJgq2ptUpPDuBOIZ1oTkw7CMF9DcHHMxN003iKSVZzquVPrHtrMhZfcoAs6UKXkpFBq3uu4ogXQJmVPT06IUiw9cMnhlJHxqfN8tcyPPW7Qn/1nhyvR2Iuh0UqH0DfQpBCL43N9Yt9Dv+YQxuQHjz+bX5vg6OCJ5aT9Dw2CtMniEuqD2v+kyd2RTWZYgJFs6+8qCZ55bCWPnAktZPWng==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3091.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 08:16:23 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e10e:bd98:2143:4d44]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e10e:bd98:2143:4d44%3]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 08:16:23 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>
CC:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] module: Show the last unloaded module's taint flag(s)
Thread-Topic: [PATCH 2/2] module: Show the last unloaded module's taint
 flag(s)
Thread-Index: AQHYikTbUdkHh6fPnEGMFwf8xJyI+a1kUoOAgAAffACAAAgqgA==
Date:   Tue, 28 Jun 2022 08:16:23 +0000
Message-ID: <b44b2b4a-20e2-2d42-22b1-c1e44c6f999d@csgroup.eu>
References: <20220627164052.2416485-1-atomlin@redhat.com>
 <20220627164052.2416485-2-atomlin@redhat.com>
 <4ddb64da-58f0-a4af-cf57-a870015a0077@csgroup.eu>
 <20220628074708.fg3ocx3vu7affkxl@ava.usersys.com>
In-Reply-To: <20220628074708.fg3ocx3vu7affkxl@ava.usersys.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f928162-cb96-4b0e-be28-08da58de7d57
x-ms-traffictypediagnostic: MR1P264MB3091:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JU6+fBGhwNn9tVCLvQs7MsDp4HaSOTR4dmHPz8wkw7G8YzUjvFSwDOLh9QoCjoRyOzoH8rseYT85jtbHNz+5KpynDVpCVy7A6LRPHFEBb0lvpSPUP0OK0bGuA/82byBJlgChtQSYPqH8zLbZuQMwVrcVFmK7HLu65sfnO9bE0chEozx1vq0aAUICkvpFmud3GLyCTvOjMfGVvvenoHj/6h56mUCBEEAS3sHFT1LUZ86SntHAPynTIw93XljDpb8z+q9UaxSmr02OckaDBGQccoUTmmbQIpoOdaqPAR33/MhzNRROHWxAuqaSdprfGDD4DMa2qI8lQ1Xf2wREt7kTsT1L6Yaju1vqlUf+MJ+GytRCrUjVmC3X6SpB+as0oHmdGk3mMD1ndU0jwBaXTljnijOYC7MxOh5ip7sZ2mhI2cgom+8PzihcCoOXwc96hs1NnBPXqmAuj+H1YCUJuL5WNKTvW4r+mzq6KDCYz/5DsJ08sou7i9X7ndPyfJCGJ4u5vpt2RDdHsxJiSR4CTRMniwDQQDjSMPafyLqC6ncP6JTsMr87LfLN06+qPXpJ6/XtiTl1g1aL0qoWDw7+frpXXOoRFek+uWXs9p2Uz67Z1QM1jfBkATAz85mpZzJv2aCdMtk6YaBIoldCV6J+Pm+kz+arfCXlBhLa8suggdHVsP8M0mNPM7s6QRVYOgGix4t4RzX+H49cMdzL/IYY7nYVsOyAe670nObSOg6gtbBR9O68QdnsVaQgp0oTIZRmWQYwdWMBQyNn1drbwjgvdq9xWAc5Sf8neh9QApoPEUUEwE0XskK83lDiH1eqUKcuNa9d1PXj/DU8DNEk4/qE9AKXcBFOHToZDrZn9tW+lhijX+A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(36756003)(478600001)(31686004)(64756008)(66446008)(76116006)(41300700001)(186003)(122000001)(2906002)(5660300002)(66556008)(4744005)(38070700005)(66946007)(31696002)(38100700002)(6486002)(66476007)(4326008)(316002)(54906003)(71200400001)(6916009)(6512007)(2616005)(86362001)(44832011)(8676002)(91956017)(26005)(8936002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEhZZEVPZ0Z5Z1REMkNZWkFvZWd4WnhyN0orUWNmOFFzMmZEQUY2S0gwNVY1?=
 =?utf-8?B?VUFiY2RkaCs3YlV6M1gzYWEwYjNMR2t3QXBycXY0WHN5TFV6UThNc0ZnVVpX?=
 =?utf-8?B?K2VhVmZIbW1FYjU5TEFCcVgyNlhqelJxNXlzL3ZWT3BwSTNoTDdnUFFYWGcw?=
 =?utf-8?B?QnFFeVNIejZpdVIvcEFuekdyd1hyVlp0MEdLa3VXcHlrOUZtMHVPU3JEUjJU?=
 =?utf-8?B?eHdTb3NBMzFBQzV2ZkEwajVMa29sR05UK3ZJZ0xMVnkvdTc3U0NBcTBseE81?=
 =?utf-8?B?Y2NuZ2pOck5VTktwVDl3Ky80ZkFEM3FKYzRLb25scEhpM0lwS3lKOEUyYmRv?=
 =?utf-8?B?V1UwN1RlaTNWYzZYbnA3VGlaUHdLWk5PK1lRcUt5VXRHTXNyelZ2QzFkcE1I?=
 =?utf-8?B?OWRhUnduRCtFWWVNcXBzSUFBekEraWJKSVBnMG9TT1JCTW4zOEVZTUYvVFRZ?=
 =?utf-8?B?QmgreGh1bFYxQmhyeEtmQnErRDhyK2NuTzNvYUVWN1V4RFAyRmlFMHArUWpW?=
 =?utf-8?B?cTl5Y2VNbG1IMmduOE1yNmdYNDRSVDFIclJIbE1QdDZOdGlOZ1ZSdmJ2cjU3?=
 =?utf-8?B?VlV6Vi9tVDdyYWx0cmo2c0R3VldTMDVhSmF6My8rektiMnB0TzArNk9JT0d1?=
 =?utf-8?B?QWl2YUEzU3ZVaTBhc01oR0tSWlJXb3o0MFFOTEt4VlZrcThON2JrOWl5RGpr?=
 =?utf-8?B?TmZoUVZTZFBvMXEzVDZWMC9TdmFnZXRmTk1hY3U2Qldjc2YvSG8yRXB0dE5i?=
 =?utf-8?B?YXAyWjUzOWkvTHpnc1Z1VDVqd2l3Vzl4M0hOeGFEak82RXBqb0xsdHAzWjYv?=
 =?utf-8?B?WThxREQyRXYyKzdxL1BaQjc2YkxybHVxbm9vemFDVk1LZ1FJdE9NbFVnRlhH?=
 =?utf-8?B?dFk2Z0FhNm4xYlpCSmVyZXUzY3pMeE5LS0VVRHJ3ZXVRWkl0SUJIMjM5MFc4?=
 =?utf-8?B?QjZtL2RwUGJNSlhwWFArRGxzZzA3b1JreXJuaWpjMit0bjdoM1Z2U2gvZzg0?=
 =?utf-8?B?MzZyMUNXc2RZZGlJNm4rS1UyRDJIL0NDSExaNzNFbzNZUjhDcmkwSmdLalM3?=
 =?utf-8?B?OEZibjBmWXdTVUhHOFdFcFh3c3ZRRGdNTlVSL2NTb0FUUkJaMXJyOEVnSith?=
 =?utf-8?B?OUsxS2dJYlpUVkJhSU5sQkZKSDRVd1VKdkM0eEVtWWxoQWtIZWp1K1RGTVBs?=
 =?utf-8?B?dUNIMmo0ejBEa3Q5UHlvTHh2bld3aW1UVTdLSWNRQmJLamFNTTIvU3NmT2Rx?=
 =?utf-8?B?dGZmeFhLa3labzR4Mno0N1Qzc09pNDdvVU1Pa2FES0dxaWwyQ256ZFBsWVN5?=
 =?utf-8?B?NUdRVWI0ai95RTd6OFhwUFdaWXJhRjdkVU9idkJhc3lTUGltMGtMMG1CbkVQ?=
 =?utf-8?B?TWJrbVhqeWFKbG53ckhOTCtvOEluZTBxd1VPUHpQMG91MGR0R3liSjJETktR?=
 =?utf-8?B?Skc3T0Z4T2tzdWJtYmtlbE9hai9RUWJHUTE3cXpaSFRUdmlCb2swMXc1MVps?=
 =?utf-8?B?M1JpMWluK3ovOWlZNUpvalhPV3BHbmJhZzdDWWxucldVVGRkVTJpVUxKZnFC?=
 =?utf-8?B?REY2Wm1IK1dWaHE2U3lITkhISTBvTC9rTnZIdGhyQm1IMk1QZ2Q5SVk0UWpp?=
 =?utf-8?B?QVdaVWFQNkFOUjNXUTVKRytWbFU3SEk4eHlUTmdzdUtxOVM2Uld0L1FaZThM?=
 =?utf-8?B?dm43UkhVR21MZEorbkZ0blA2L1kyeEJ1S0xLV01XejM1T2pmRFR6d29QZk9O?=
 =?utf-8?B?WSs5d3FoNHlieHlPSDlKa1VMd1JQWkRtZllkVDdyRzlvWnZPdlR0M1NDRnlH?=
 =?utf-8?B?Y1BPNUdQUExwOE1wWlRHS1Z0VjcrQkpYUndlejlYVkcyeVBzeVcyQUhkbjcz?=
 =?utf-8?B?SHhnYWdoY3piVFNDdG1Ua0tBR0ZwaWNIbTh1MlBuT0Jpak5ubGJvbkZLYWpK?=
 =?utf-8?B?OGp3SWhHai8zT0lqSHpzZ21HTDN0UHRMYUFoMHNnSE1qWlNkZlpsc2JPQXkz?=
 =?utf-8?B?a1BmSFBtUHZoaFlNOHZKWmc4ZVVJZnlQQTJlMlFNcGVwaEYzcnlGNUczQjhX?=
 =?utf-8?B?NW5mSlUraXdYR2t3MFhIUkEwS3NuUGxjWWphNXBrVFZaVkVuZFg1aWJVVE0v?=
 =?utf-8?B?MndCYWFNRm5wNHFBR0cwa1RWT1VrVkFKN09xVHRrcStwaDBpRVQxYitGSVdK?=
 =?utf-8?Q?CvKUNOMQGPstQIu8WUi3Gdk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0945038670317149ADCF14964248D383@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f928162-cb96-4b0e-be28-08da58de7d57
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 08:16:23.4920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nwl2XF+E6vk3SUTZwb6MuJO7JVQj5hgfMl6iXRluGczHjaQqnla07JxhApEfo+lE6h2SUIKSdaeR5p/ql55dbvFY98iNGscOHeXJfFqUSXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI4LzA2LzIwMjIgw6AgMDk6NDcsIEFhcm9uIFRvbWxpbiBhIMOpY3JpdMKgOg0KPiBP
biBUdWUgMjAyMi0wNi0yOCAwNTo1NCArMDAwMCwgQ2hyaXN0b3BoZSBMZXJveSB3cm90ZToNCj4+
PiAtCS8qIFN0b3JlIHRoZSBuYW1lIG9mIHRoZSBsYXN0IHVubG9hZGVkIG1vZHVsZSBmb3IgZGlh
Z25vc3RpYyBwdXJwb3NlcyAqLw0KPj4+ICAgIAlzdHJsY3B5KGxhc3RfdW5sb2FkZWRfbW9kdWxl
LCBtb2QtPm5hbWUsIHNpemVvZihsYXN0X3VubG9hZGVkX21vZHVsZSkpOw0KPj4+ICsJc3RyY2F0
KGxhc3RfdW5sb2FkZWRfbW9kdWxlLCBtb2R1bGVfZmxhZ3MobW9kLCBidWYsIGZhbHNlKSk7DQo+
Pg0KPj4gWW91IHJlcGxhY2UgYSBib3VuZGVkIHN0cmluZyBjb3B5IGJ5IGFuIHVuYm91bmRlZCBz
dHJpY3QgY29udGF0Lg0KPj4NCj4+IFNob3VsZCB5b3UgdXNlIHN0cmxjYXQoKSBpbnN0ZWFkID8N
Cj4gDQo+IEhpIENocmlzdG9waGUsDQo+IA0KPiBXaHk/IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0
bHksIGJvdGggdGhlIGRlc3RpbmF0aW9uIGFuZCBzb3VyY2Ugc3RyaW5nIGFyZQ0KPiBOVUxMLXRl
cm1pbmF0ZWQgKHNlZSBtb2R1bGVfZmxhZ3MoKSkuIFNvLCBzdHJjYXQoKSBzaG91bGQgYmUgc3Vm
ZmljaWVudC4NCj4gDQoNCkFyZSB5b3Ugc3VyZSB5b3Ugd2lsbCBuZXZlciBldmVyIGVuZCB1cCB3
aXRoIGEgc3RyaW5nIGxvbmdlciB0aGFuIHRoZSANCmxlbmd0aCBvZiBsYXN0X3VubG9hZGVkX21v
ZHVsZSA/
