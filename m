Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B6C4CECAA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbiCFRr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiCFRrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:47:55 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90042.outbound.protection.outlook.com [40.107.9.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325D925E8F;
        Sun,  6 Mar 2022 09:47:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCS5BwQjWZwul6ul7h8nCiudnwuN4VprbNbIc0NQUaDluPn0Qu53aAU2POcqef8HG54qTXmQ9P4eVEv18FUFINtbdkrnA6bqjaTpFC530h3ticzxmYX0YTEImHsXMdwEIqIAOOLfRzw+FRFtwYbDdEsBO9ngT35f4NFmJqyklV1vr7mheLddjCrQEG93aVdFfsL2kCI3StPqX5audBRIzCZb5f/U9HIDPLtswMz1bjVlGhsONsbggSn/Dlu2700qbK/uqKBGBccexWxJg+vi07ZQkglsHmvXFvqqnK2Vfw+iTRdgym5JLFQEG8khQY6RufizfmRz+oy9DTc8KPAgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dwci1x/xSG7ea2IlRWasDqYDuLvLDyCEybJS1NqCgCE=;
 b=iUrac8l84IDppzx1Z/TvgACvmPbiiplFuS3r7ju1vhfb+/xv4cW4xKxCo/KgwP0li7mAgH2GouCoQRGVQRikepcta2FaDntr2GAWhQeEysdKgucFru/dpZ2+t6E+q2Cw9FDva9NI9vhV0SzpVXmRgvh2qQuA1//a2cxkJ7Mcf/3/Xkw1QN/WRpmZaIFSXjP9qHXKr51eKCwAGIGp+By5h97EAwLOtFP8ANmflC+TsdzsFS6MlrDAcmnfwmIHoRQMT28nt6/FawxY0Lsebo5p0ziL4zLQfGntqt1GZOechHhRTWI3Vapv0+iiPhl2wKcCnKB1tjaFyeOAvMZcWIL8hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB1942.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Sun, 6 Mar
 2022 17:46:58 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d%4]) with mapi id 15.20.5038.026; Sun, 6 Mar 2022
 17:46:58 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>
CC:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "pmladek@suse.com" <pmladek@suse.com>
Subject: Re: [PATCH v9 07/14] module: Move extra signature support out of core
 code
Thread-Topic: [PATCH v9 07/14] module: Move extra signature support out of
 core code
Thread-Index: AQHYLP0GFLJD3Dg8pkOmoPnkw1nPZqyrv2OAgAWIbACAAWKRAA==
Date:   Sun, 6 Mar 2022 17:46:58 +0000
Message-ID: <4b00cc1c-0fc9-7348-28ee-b06de0fef3c7@csgroup.eu>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-8-atomlin@redhat.com>
 <c03fa2bb-1b0e-62c7-53fe-33e44d20b564@csgroup.eu>
 <20220305203756.jc5ayzboea6ixm4a@ava.usersys.com>
In-Reply-To: <20220305203756.jc5ayzboea6ixm4a@ava.usersys.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2eb9f6fe-46a4-465c-a51f-08d9ff995010
x-ms-traffictypediagnostic: MRZP264MB1942:EE_
x-microsoft-antispam-prvs: <MRZP264MB19426C94E6BA7F66BD309908ED079@MRZP264MB1942.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tsDZ/XbvPPs1Q9akEMVGjHhvf8B9KKmPRJmb++2dDJo6PPJJGUSuIq9mcIZU2E6gf5lxSsjJOcXu9S4zML4dCJNiIAeEaNGCXEU91PSzLwi/R9hTV2YoD8NeFI/N9UygVGlOG7QiFEHcO9nAWDDyWzmgJnNOA6VlyrvYIiHVpjgLnafpUZzRMPgOLx/SKxaUXChCFE4nzJILxP15J5z10wJegNqjC6shjYZDVShpN8PoOw93kIZ58RrQ3523C0rkxlLqJUjexEr3F1RezKM03YznSODlaXtOyLIsrxt9ItJlvqFt458VC7zAtMWlC+/gnOjk8ilEi4+/xGEM2bVUANKg0pEvpq0i6JR5OmXj8oVhCoB2UWl+p9gE+trsKTueGf1RYI0/iAG+A+oMJPEckTDMCxFFcR/L/JTyihYg0si/xsHKlcEjdDBjDrT5lkab9bt2tDhAssgaSPZxqEibl1Xmr4McAEZwkTUiqPeFZKcx943cpCTOFxh+cKisQz/XEjVFYV47cJe3U0HalodSBuYg39lrPEKAyyj2MSpSUax7XVhW7EmEt05zoG2rhILtbqIiM+dIrRY9fTV/6bOmTQNfWJ8SmM6awvFHaJCYMLWLWErw9fJ6PabnUmV3sjEUMHsRKAGI+RYjNJlyBfaQ91JD68fCUPtQSLoptO5V3P6tShuBPW83dtasbkk9i9ePYLA68RPrsTUoqk6NgYVqQxTnA11aqoonjYPTnmHM1n2/JNuBGPU1q+Bjs6thwpwyqlreLLr22+WkU3iP9ytRdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(122000001)(508600001)(31696002)(186003)(66476007)(66556008)(8676002)(64756008)(66446008)(26005)(8936002)(66946007)(91956017)(76116006)(71200400001)(86362001)(4326008)(6512007)(44832011)(38070700005)(83380400001)(5660300002)(6506007)(36756003)(31686004)(6916009)(54906003)(7416002)(316002)(38100700002)(2906002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2lXcmQrckdRTnlJNU9lWW1pVlpyZ2FxclF0MWFxZ1RHUjU2cXVQZllrODlV?=
 =?utf-8?B?OWFocU5STlBzSFM0alBuSHIvS2VQWEZSL3hIZ1NOQW9QYW1WeFZ2L05CVnBn?=
 =?utf-8?B?cTV5eG9qRE05LzY3Q0dSSm8vYS9COGJMenJXVTJDUG9uaFhqcDk3MEliRW96?=
 =?utf-8?B?Q0lCZ2FwQ0dEZU1Fejcxa2lxOWoxYUxhSGQrRXpkaWdSaVJHM2x4MGRSTE5G?=
 =?utf-8?B?SFBJSk5uSWcrd25OOGJ2dEZEWWJzZjVRb0VKa1hQM0xibWhNcytaU29ONVJi?=
 =?utf-8?B?NGFVaWFxTDFsaVVheFBGNUhYNDh5cStvclZ2WDNpQzdkYzVTdExYeklzbzdq?=
 =?utf-8?B?SkFTa2NiMkc0c2psSWM4QW5ncER1MTcwNVN5c3BLaDNDSmpvWFM0dmZWaDZ6?=
 =?utf-8?B?RjZ2SUZtNHN6Ukg3VlZjMGdscnRNNHY1ZXNxa2lMVlEzSzRUWFhhWSs3VVZT?=
 =?utf-8?B?bkJ4MlN5QTVrUWtrSDhBUVdkeTlpeTE5eTJVaTJZNjVFMkJNVmZJeGlZL3g2?=
 =?utf-8?B?MWtxcnNiRG1aSzNnTVpoSVJSSDFDdFdDWWVLUmc2eHh3aUZVRnNKeHJ1UVlr?=
 =?utf-8?B?aDl5SStLMEJqdTVrcmZuMUNQT2lkOTVuYko1QlE4T0JTY2l0c3l6N09SbVY3?=
 =?utf-8?B?M1Q2WmhJcDArdHNmR1owY1VwUXdGVmlHelErRWxmWWc5MnZGT2d4OHFNU2Rw?=
 =?utf-8?B?ZEdOYkkzK2ZPOGxRNVBFWEp0OWR1bGJlVlJXaFN6dVE2b1RKNUVlM2RyTjZn?=
 =?utf-8?B?NjFGbE9mWTJWUFQ5cWVXOFo1QjViTWY1SmRRM05rd0JqTFRKRlhaY3lRejdU?=
 =?utf-8?B?VU1jSzh4SG81cUczc1JGclMreWE5bk1TSFFub1RNQTM3Mjc2OVIzWEF2dUwv?=
 =?utf-8?B?R2JBQ2oycnkyM2pJRElWUnp6TU85a3NJMjd3Yy9uNUpyOTV4UnJXdFlidEoz?=
 =?utf-8?B?MjBiRFI5YU9kTnc3ZGE5MGNSQXd0THI4RzZYeVlnc0Y3QTRFTjF4Um8yWUdN?=
 =?utf-8?B?WTBMenJCclVoRTFNREZQZGNYOWlaRFZwalRIVmhwM0F0M1FRWmU2VDNXeXFy?=
 =?utf-8?B?RjFTanl5RG1yRUp1WUhQR1RvVFROMlpORWtqUTM5V2EyY0tuNm1zcTNjQkh5?=
 =?utf-8?B?bG9jKzJtQS9WT0Y5UHlZVVlXeHFWVVhsck5obWhoN2RMdDIwSGtRTlg1SmZ1?=
 =?utf-8?B?Q0l1KzlZa1k5bnF0RC9Sd2l0MEE5WnZXeG5GSE5leXRMaFpESVQ1a0dFSFRO?=
 =?utf-8?B?Wm1Oc1d0R1JzcUhWQzlTRW9hTWVYMllEdSsrMFUxMkhUVml3UDhkZVdFREg0?=
 =?utf-8?B?ZnBKZXluV1dYZzI3VCt1aW41S3NlUXVIc2haWU9HdWMwaWVQMmZmWXp1aElY?=
 =?utf-8?B?Y0NJYWFmQmNQNXhDb1hBWUQwM3drVlZkZ1h1VjlBc2hXKytwdk84UzV5U2Ft?=
 =?utf-8?B?bXpBbzdFOWN0VFVVVGRhZ1dFVDJiaW9FQXdLK0JsN0RHK2FBUzdkcWxDVkE3?=
 =?utf-8?B?TnFONVVGSHZRalh2czNQZ0JUbTA5ZldmTG5xN1hPWnZZMjRkVjFHWldRVXZE?=
 =?utf-8?B?ekRqdFJLMko2WnkvZ2RRS1NkZ0JhSXFBeEtCczVISXVTM0ZkOTZtRHc4N3Fl?=
 =?utf-8?B?NzB3MG91eVpvZFRudWpnWnRad0R6WUtDSm5VbFUvZUFYd0NRN2N6dks0K1l1?=
 =?utf-8?B?MEJIUWlxY2ppQkdTL0k0TG9QNGFwb01LQnZHUkk1WndCQndEbjIySUFzNDJI?=
 =?utf-8?B?SS9aYmc5cG5jc3piRXNIVmR2QXdYUWtWN1RKOHU4TVE3alJDVS9OQmZveDQ2?=
 =?utf-8?B?eUVxaEg3Rml6bURkTW1GL3JWaWVrcmt5UU10YUx5NzRRZ0RNbWNETzRSOW1i?=
 =?utf-8?B?WjhyTHZDNWVDZmpOWTQxckEyK3E5azltVWF2S2ZuRTBhZzlrMDRaL3ZhREYz?=
 =?utf-8?B?YXo2eFFjRVNHaWF1TzNCYU1jV3U0SDZhY243OWRFRUpKV3hFYlVzU0dEMUZR?=
 =?utf-8?B?K3R4eHVqZGJlcGxZazMrY0lFaWI4aVZKeDhPUWs5REQ3S2hJT3lCSGtxWVhy?=
 =?utf-8?B?aWJoUlF0a3BCVEFQYnM3UjZNeHFvTFVoakF6dno5QlZlVlJNV3BHUFJWMjhr?=
 =?utf-8?B?ZGF6MFlrYkFwVFIvSWo3bWxjUno5cnRleWNMeStlQ1lkNkdSSklRSmR2eXFL?=
 =?utf-8?B?VU1TQW1WTVJpaE00ZlJELzU2b0NZUStJSUlrVWp3K3A3OVNZM1g4cUJHVUtV?=
 =?utf-8?Q?8KFeMEmF+RZXGZc/C7S2u4JB7D0T80YyLu+lrO+xII=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <597676A06AE54C4DA721179F265AB607@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb9f6fe-46a4-465c-a51f-08d9ff995010
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2022 17:46:58.6406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1fdTZCKRtDdEMaSt8psA9ofYW40oBGPl6TIj39DVBYGf+i5sMxKFZlM0R0WNPeNPDVP4ReEvG6GUfW2a0dzVtb5HiErF0N1++fXE5844QY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1942
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA1LzAzLzIwMjIgw6AgMjE6MzcsIEFhcm9uIFRvbWxpbiBhIMOpY3JpdMKgOg0KPiBP
biBXZWQgMjAyMi0wMy0wMiAwODowOCArMDAwMCwgQ2hyaXN0b3BoZSBMZXJveSB3cm90ZToNCj4+
IFdoZW4gaXQgd2FzIGluIG1haW4uYywgaXNfbW9kdWxlX3NpZ19lbmZvcmNlZCgpIHdhcyBidWls
ZCBhcyBzb29uIGFzDQo+PiBDT05GSUdfTU9EVUxFUyB3YXMgc2V0Lg0KPj4NCj4+IE5vdyBpdCBp
cyBvbmx5IGJ1aWx0IHdoZW4gQ09ORklHX01PRFVMRV9TSUcgaXMgc2VsZWN0ZWQsIHNvIHlvdSBo
YXZlIHRvDQo+PiBtb2RpZnkgaW5jbHVkZS9saW51eC9tb2R1bGVzLmggYW5kIGhhdmUgdGhlIHN0
dWINCj4+IGlzX21vZHVsZV9zaWdfZW5mb3JjZWQoKSB3aGVuIENPTkZJR19NT0RVTEVfU0lHIGlz
IG5vdCBzZWxlY3RlZCBhbmQgbm90DQo+PiBvbmx5IHdoZW4gQ09ORklHX01PRFVMRVMgaXMgbm90
IHNlbGVjdGVkLg0KPiANCj4gSGkgQ2hyaXN0b3BoZSwNCj4gDQo+IExvb2tpbmcgYXQgdGhpcyBh
Z2FpbiwgcGVyaGFwcyBJJ20gbWlzc2luZyBzb21ldGhpbmcuIElmIEkgdW5kZXJzdGFuZA0KPiBj
b3JyZWN0bHksIEtjb25maWcgQ09ORklHX01PRFVMRV9TSUcgY2Fubm90IGJlIHNlbGVjdGVkIHdp
dGhvdXQNCj4gQ09ORklHX01PRFVMRVM7IGFsc28gQ09ORklHX01PRFVMRV9TSUcgZGVwZW5kcyBv
biBDT05GSUdfTU9EVUxFUywgbm8/DQo+IFNvLCB3aGF0IGlzIHByZXNlbnQgaXMgZW5vdWdoIHJp
Z2h0IGkuZS4gdGhlIHN0dWIgd2hlbiBDT05GSUdfTU9EVUxFUyBpcw0KPiBub3QgZW5hYmxlZD8N
Cj4gDQoNClRoZXJlIGFyZSB0aHJlZSBwb3NzaWJpbGl0aWVzOg0KMS8gQ09ORklHX01PRFVMRVM9
biwgQ09ORklHX01PRFVMRV9TSUc9bg0KMi8gQ09ORklHX01PRFVMRVM9eSwgQ09ORklHX01PRFVM
RV9TSUc9bg0KMy8gQ09ORklHX01PRFVMRVM9eSwgQ09ORklHX01PRFVMRV9TSUc9eQ0KDQpDYXNl
IDEvLCBpc19tb2R1bGVfc2lnX2VuZm9yY2VkKCkgaXMgYSBzdGF0aWMgaW5saW5lIHN0dWIgaW4g
DQpsaW51eC9tb2R1bGVzLmggcmV0dXJuaW5nIGFsd2F5cyBmYWxzZQ0KDQpDYXNlIDMvLCBpc19t
b2R1bGVfc2lnX2VuZm9yY2VkKCkgaXMgaW4ga2VybmVsL21vZHVsZS9zaWduaW5nLmMNCg0KQ2Fz
ZSAyLywgaXNfbW9kdWxlX3NpZ19lbmZvcmNlZCgpIGlzIG5vd2hlcmUuDQoNCkluIGxpbnV4L21v
ZHVsZXMuaCwgeW91IGhhdmU6DQoNCiNpZmRlZiBDT05GSUdfTU9EVUxFUw0KLi4uLg0KYSBsb3Qg
b2Ygc3R1ZmYNCi4uLg0KYm9vbCBpc19tb2R1bGVfc2lnX2VuZm9yY2VkKHZvaWQpOw0Kdm9pZCBz
ZXRfbW9kdWxlX3NpZ19lbmZvcmNlZCh2b2lkKTsNCg0KI2Vsc2UNCi4uLi4NCmEgbG90IG9mIHN0
dWZmDQouLi4NCnN0YXRpYyBpbmxpbmUgYm9vbCBpc19tb2R1bGVfc2lnX2VuZm9yY2VkKHZvaWQp
DQp7DQoJcmV0dXJuIGZhbHNlOw0KfQ0KDQpzdGF0aWMgaW5saW5lIHZvaWQgc2V0X21vZHVsZV9z
aWdfZW5mb3JjZWQodm9pZCkNCnsNCn0NCi4uLg0Kc29tZSBtb3JlIHN0dWZmDQojZW5kaWYNCg0K
DQoNCllvdSBtdXN0IHRha2UgaXNfbW9kdWxlX3NpZ19lbmZvcmNlZCgpIG91dCBvZiB0aGF0ICNp
ZmRlZiBDT05GSUdfTU9EVUxFUyANCi8gI2Vsc2UgLyAjZW5kaWYgYW5kIGFkZCBhZnRlciB0aGUg
I2VuZGlmIC8qIENPTkZJR19NT0RVTEVTICovOg0KDQojaWZkZWYgQ09ORklHX01PRFVMRV9TSUcN
CmJvb2wgaXNfbW9kdWxlX3NpZ19lbmZvcmNlZCh2b2lkKTsNCiNlbHNlDQpzdGF0aWMgaW5saW5l
IGJvb2wgaXNfbW9kdWxlX3NpZ19lbmZvcmNlZCh2b2lkKQ0Kew0KCXJldHVybiBmYWxzZTsNCn0N
CiNlbmRpZg0KDQpDaHJpc3RvcGhl
