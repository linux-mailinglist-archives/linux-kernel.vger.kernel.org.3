Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A6B4C6B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbiB1LrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiB1LrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:47:15 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90041.outbound.protection.outlook.com [40.107.9.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCA247542;
        Mon, 28 Feb 2022 03:46:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GefUT6E8g4nm6npVEBWM6OVeSdjlTM2ZRkVXm6gxATHjcHtauG5e+3uQl5RYfs5HXHxrEA6mGjzYPDlVYNx08emPFFgDaE9sr9qYQyulv9+YYk1Squ/5oKSLCzrTlWmb70q/o6WuJ7070z8v5pX8DCwB9KXezi0JHBQjCOJEf1YLebtfvYuIjakbFlK6vR4ifRowq8Fqc2eWw/5g7YpXOpnPk9NHt9qcrZYELG58J25LATSGivmihulTVs542Aw48VMfFwtcU1g+Qz5JZaU0EFuOHGSJjVM8OIxTjP7+iihMFxc7ha501cuSCXqaOsNpMtwEbkRg9n4E8lsqMgnuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEcIHjxDXhhEKpl4pBnY/jgiStFEw05i/GJeLkI3cMg=;
 b=PIR1pBOCrN20U3uiljNxp6NTiNAQoKe+vdrvXTaL6KlKaMWJdE4xg+LgKTFV5Ch2j5/5mxnHwNTePaPuzhp+dflmvHIuGEX/3E24s800H4VPL9JdatTJQTuuUFvuN0QQtIxqm7x4oPmC3tgD1uSoLLfUbAfhkMyYqzfxyiKnoJ2ynpkxlowfPQi6e7Lv2k6NSMiM/S7BgKGgBFw9VDHPfC3E3sbgcUl3ckCp1+Nc59EdjkHJTMApgFtLYlQ+us1DOsJtcP2GxQ6WbimtkFxCU0XGjxSo66nJwynsJhxcyWf4bafDHrSsZjU3HsyBHFQ7AVQANaMgBEZEDBIaYI8Aow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR2P264MB0785.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 11:46:33 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%5]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 11:46:33 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Petr Mladek <pmladek@suse.com>
CC:     Aaron Tomlin <atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
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
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: Re: [PATCH v8 04/13] module: Move livepatch support to a separate
 file
Thread-Topic: [PATCH v8 04/13] module: Move livepatch support to a separate
 file
Thread-Index: AQHYJ/ZUpQQJAACNXky5zyXRhDIam6ykBcOAgAB5oACABFRqAIAADe8A
Date:   Mon, 28 Feb 2022 11:46:33 +0000
Message-ID: <ed8bb968-0a88-39cf-f388-032e8c205df7@csgroup.eu>
References: <20220222141303.1392190-1-atomlin@redhat.com>
 <20220222141303.1392190-5-atomlin@redhat.com> <Yhiik2ledqAfGuN2@alley>
 <fb1bb248-bd3f-0990-cdfd-d186b7579411@csgroup.eu> <YhyqaGO+vbGOifpR@alley>
In-Reply-To: <YhyqaGO+vbGOifpR@alley>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db99f0d3-ab40-49e3-2762-08d9faaff7d2
x-ms-traffictypediagnostic: MR2P264MB0785:EE_
x-microsoft-antispam-prvs: <MR2P264MB0785C0DCD70F6F0C9FEB3BA7ED019@MR2P264MB0785.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0YpE8fHNg8A2zCjzD+X1ACNRXuEBr0H1SrSGSkylseYoAhI5IGza6+DbidovDQixa94ehnZHABCocQe0KzYfFo5gBH1pOcNu621sJJeohSU6sNzBM6jOwHcvihpY5qUmHykXO0wMID9xYPn5nz+CTl6SCIEtWMCgmGYoeQ2bBhfpYJCrb9JekYz1/7OeAzEcMBhdbWcfehSyTBmHYj3So49zAukervPN98FBU4QmBYDwxIP/KYL8M0PTRwThcPPpYl6Bqxqny6FCD3e4rMBIHRuadJ69JTr6LppnN3LSBS/rBBSW6jkiDQ1XrN6av4BeZYAnXTQwCyDKVLvJRCxgW76V63uI0GWaNBY0OC8W5KM13LQviPLJX8iqbP4jUlYQdtsDtUfSgGe7yZdmw39EeEjJmxC9rCx7oFa7EVhioFIArEDe9fkrp6i1TetpRF38UtiNHMNRfIqD3aNrSlcUGxnCewMrGikjo2t0ZceF1hWFbk8iQBWkfDECdmtgD9lGabgzTsFwelLOV03JldjmxVZtOLDvQZvT3w6GjuiLfBY3MwnzAoNEUM5WPHps/Eu/X8+7Z0P/nGEsYBvx39vJ6Fxw4mwLS4UF/PPYoroBhc8raQYix1CyI3wy0ZT5yeTgwJqGyHqaUwPWXk+O8eMAfYoRHnJ2LvzU+/IiBLwStKTIqb+HJeqQ3jTNWuBI5FVgsbPM1IX10ZIMH42ySzV7CgvsZYlS1dzMi50lfOAyLxREOdRSUDkSaDNEVr7nrj90xwHSz6t0fn/ztcS0kx8w+uKGni45kAV1ga7jnjdg+b8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(83380400001)(5660300002)(7416002)(8936002)(2616005)(66574015)(44832011)(36756003)(66556008)(26005)(186003)(66946007)(38070700005)(31686004)(122000001)(508600001)(31696002)(76116006)(86362001)(8676002)(64756008)(66476007)(71200400001)(38100700002)(4326008)(66446008)(91956017)(6916009)(316002)(6506007)(6512007)(6486002)(54906003)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVFlM2RzZVJJVWxsT1lRbkIvOVpuR3BpOEpXTEwvUnRiOXJ5cVJEaFBRZmdx?=
 =?utf-8?B?QkZWMjBidWQ3dlJtdldIa2lhRTlVWVF2enMyeDlsRGUweE8vUFo2ZUdrWUEr?=
 =?utf-8?B?SWhUaGZoZU9VNlQwVEZKVWlBTTRSczh6WElza2FQekpOUmNucWxDYk5TN1Vt?=
 =?utf-8?B?U1FOT1E1SlUxODJ3N1NNc0JHNFp2OXdpbkpZRW9qbHpiQ2VUMmV4TUY3ZzFw?=
 =?utf-8?B?S1BQR2FocExLYjVFN3phaFpta01VanRGV29JbXA3cjMwUTMraEpSc0RFbUd2?=
 =?utf-8?B?MW1HTTU5aU5TbmFEc05DWG1oOEdtQVdNWitQUUtjcEpNV0h5MDFHbE9OOEw0?=
 =?utf-8?B?Qk5aaUtIcVdra3dobTdpWm50azVkMHNYOS9lU3hTMDhoOFEwL3NtdHFNaHc3?=
 =?utf-8?B?dS80cEFsR2lLSnZkUWtQVVZ1L0hjYk5OV09xMm5vWis1ZkQ3bkJid2xOUldk?=
 =?utf-8?B?cGtpZHZPL1NPRUc1VERuTUUxaEd1SlBoVVloQ3IrVjNTcldqQmxyVC9VQ2g0?=
 =?utf-8?B?cWFzTEdtcFdMYTRSdERzUTIzT3pMQ1luZDMzY1ZQUDUvSU9NaGJHUUkzNkhX?=
 =?utf-8?B?Z3RiaWUxRkJpdWllbjNGNmpHTTN3Tms1YVdSSktkUWNwL3hDZHJwNVR3Tm9Z?=
 =?utf-8?B?WTIzcW9WSm03MENEV0xpSTRBUUVQekdPQ2U4T0ltQ1RqelRiVldGRkhBNmhX?=
 =?utf-8?B?d1JzbGhYVjZ2ZTJ3bCtvVlIrS0NmZFI0N3N2eTk3eGlwR3ZWTjBEckVIUTZD?=
 =?utf-8?B?cnZTeUxnWThVeTRaR2VDRllxK2ZiNjNEVTZtL1RHUjlXSUUxOUo1L2pWSGRi?=
 =?utf-8?B?VXo5aDlqTGNFT2M1YUd5ZWNoMXpiYUVjVzVHNUZOTkk3eGMxNElXbnFsT1Rr?=
 =?utf-8?B?azhwelRjaWovR1Jha01ONEpuMzdIM2JIV29Kc0xWWjRybEoyczBBaUVoc1Uv?=
 =?utf-8?B?RHdEVmxMZXFIWG5DV0xRYzJvRjdCaDlab29nQjBnUnF3UER1cS9meXZTUGVW?=
 =?utf-8?B?YkVYNjZqcmJlNlg4cHF2UXkvMURjd0d2Wm5uMTFvOVZNODdxUHZnVllCZFBt?=
 =?utf-8?B?TnkwMWMwZmRHVGtxVnRGaHRJdEdFYU53ZmhkMWZ3eUM5SG94b3ljL2RYOWtZ?=
 =?utf-8?B?UEJnWUpEWW9hb3A0UUNYUnBvV1ZZTlk4dWN5amFOT3l0SStoYjg2VE9jRGtw?=
 =?utf-8?B?bU9pZytqV3NPRlRQSll4T2UvVG5rSThHeXAvamx0RVhHSkVaNW12N2lMTHVE?=
 =?utf-8?B?aTY0dzBLa1ZtdVRWYWhQQytKVEJqZEtKWlhDL0J1ZW9LOWtrT1dBVjhoZGhL?=
 =?utf-8?B?dmNVeDNiYnF6d052Uzg0eTBVVFVsYVU1emoyajVYSGhUdDk3bHlNNVF6a0hF?=
 =?utf-8?B?UENFdFphSEVwZW1hOUFWcjZyWDVsTHlLaS9PZzJrSVlTZnN2K1pzWUN1c0V0?=
 =?utf-8?B?U1B1T1VtOVpNTWxHSURBZEovY1FSSGRaZFp0RkJHWTFiV0wvOGs2di8vNGcx?=
 =?utf-8?B?M1FOSG9DYTJ0WEdJQzFZQmZvY1JWbnhyVXJsekdpcVVoQ0NWTTAvSjE4aHIx?=
 =?utf-8?B?dUpXakx1UWtYU3RqTTdnVE1TcUw3UVh4dlNyNll5SGRhVWphNzJsdjZ4NGtU?=
 =?utf-8?B?b0Jhc2dJdHEraGIyVUE4dk9PdXFlTDBnMFkyRUM5RWJkekwrZ1NEM2R4WVVR?=
 =?utf-8?B?ZlVsY0o5Y1dpTXJLbWtrZFc1aGVmQ3dMZXg0aDlvem5tVVgrYUlzTlZLMFQ0?=
 =?utf-8?B?elFLTCtCNkRpUHZFaWdkQmxKWHJFSmZBUDlDc3ZxT1dKeXpHTmtYSW9ua1Qx?=
 =?utf-8?B?Sk9uZ1Z5ajBrMWJkQXVSeFFRTHlLendhekdFRTZaRGhLaVQxSHpFZjA4eU9U?=
 =?utf-8?B?ZnFmOVJ6cnA3RGJMZisycWpWTlVqS1JScGw5MERjUjJJZ09lRkE1WlcrMUJp?=
 =?utf-8?B?V2tSeGlvZW5lNXJvd21mUHloWlZmRmgxdFZhb01LbTA0cHVqR0hWdHgrcGVn?=
 =?utf-8?B?TjEvYnZKcVFVSk0wVW5ZOGx3NUw2YzU0eTRFR2FCVGlhY0JMSGhsWWQ1WHhD?=
 =?utf-8?B?Vndqem9QUWRkTzAveFkrcHBOM1pXWHZGU3FNMmpzSWdFNHArWGxWR3k2WEdQ?=
 =?utf-8?B?KzhieWZRc0xraG8yZWk2Sk9OZDZTR2xtb2w1Nk5DWWYvOUVmZ1FjNlA0WlNK?=
 =?utf-8?B?NlYwOEZFVUNkVlRJeUd5NGlkZWdab1ZWdkUrRXRWR1BrS0ttTXdRWm1mOHhJ?=
 =?utf-8?Q?vUcythoA56j5vIGl1N3fAtCDNKTC6uzUHn1073WA5c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0984CCD79DBDC4588FF2ECB9226B7BF@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: db99f0d3-ab40-49e3-2762-08d9faaff7d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 11:46:33.2507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wra9By+UH9BcWZT3pgwSrNlKT0viOwH9FcignGpLDtCjRkkPBXCkBfoMwLIJSdHBAP7vzqOp2UgKwsuT6whPny5g4FIcRaoFeen8qNAPr/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR2P264MB0785
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI4LzAyLzIwMjIgw6AgMTE6NTYsIFBldHIgTWxhZGVrIGEgw6ljcml0wqA6DQo+IE9u
IEZyaSAyMDIyLTAyLTI1IDE2OjQ5OjMxLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOg0KPj4NCj4+
DQo+PiBMZSAyNS8wMi8yMDIyIMOgIDEwOjM0LCBQZXRyIE1sYWRlayBhIMOpY3JpdMKgOg0KPj4+
DQo+Pj4gUGxlYXNlIGRvIG5vdCBkbyB0aGVzZSBzbWFsbCBjb2Rpbmcgc3R5bGUgY2hhbmdlcy4g
SXQgY29tcGxpY2F0ZXMgdGhlDQo+Pj4gcmV2aWV3IGFuZCBpbmNyZWFzZXMgdGhlIHJpc2sgb2Yg
cmVncmVzc2lvbnMuIERpZmZlcmVudCBwZW9wbGUNCj4+PiBoYXZlIGRpZmZlcmVudCBwcmVmZXJl
bmNlcy4gSnVzdCBpbWFnaW5lIHRoYXQgZXZlcnkgaGFsZiBhIHllYXINCj4+PiBzb21lb25lIHVw
ZGF0ZSBzdHlsZSBvZiBhIGNvZGUgYnkgaGlzIHBlcnNvbmFsIHByZWZlcmVuY2VzLiBUaGUNCj4+
PiByZWFsIGNoYW5nZXMgd2lsbCB0aGVuIGdldCBsb3N0IGluIGEgbG90IG9mIG5vaXNlLg0KPj4N
Cj4+IEkgZGlzYWdyZWUgaGVyZS4gV2UgYXJlIG5vdCB0YWxraW5nIGFib3V0IHBlb3BsZSdzIHBy
ZWZlcmVuY2UgaGVyZSBidXQNCj4+IGNvbXBsaWFuY2Ugd2l0aCBkb2N1bWVudGVkIExpbnV4IGtl
cm5lbCBDb2R5aW5nIFN0eWxlIGFuZCBoYW5kbGluZyBvZg0KPj4gb2ZmaWNpYWwgY2hlY2twYXRj
aC5wbCBzY3JpcHQgcmVwb3J0cy4NCj4gDQo+IFJlYWxseT8NCj4gDQo+IDEuIEkgcmVzdG9yZWQN
Cj4gDQo+IAkrCWlmIChtb2QtPmtscF9pbmZvLT5zZWNzdHJpbmdzID09IE5VTEwpIHsNCj4gDQo+
ICAgICBhbmQgY2hlY2twYXRjaC5wbCBpcyBoYXBweS4NCg0KT24gbWFpbmxpbmUncyBrZXJuZWwv
bW9kdWxlLmMgY2hlY2twYXRjaC5wbCB0ZWxscyBtZToNCg0KQ0hFQ0s6IENvbXBhcmlzb24gdG8g
TlVMTCBjb3VsZCBiZSB3cml0dGVuICIhbW9kLT5rbHBfaW5mby0+c2Vjc3RyaW5ncyINCiMyMDky
OiBGSUxFOiBrZXJuZWwvbW9kdWxlLmM6MjA5MjoNCisJaWYgKG1vZC0+a2xwX2luZm8tPnNlY3N0
cmluZ3MgPT0gTlVMTCkgew0KDQoNCg0KPiANCj4gDQo+IDIuIEkgZG8gbm90IHNlZSBhbnl0aGlu
a2cgYWJvdXQgaWYgKHh4eCA9PSBOVUxMKSBjaGVja3MgaW4NCj4gICAgIERvY3VtZW50YXRpb24v
cHJvY2Vzcy9jb2Rpbmctc3R5bGUucnN0DQo+IA0KPiAzLiAkPiBnaXQgZ3JlcCAiaWYgKC4qID09
IE5VTEwiIHwgd2MgLWwNCj4gICAgIDE1MDQxDQoNCkNvbW1pdCBiNzVhYzYxOGRmNzUgKCJjaGVj
a3BhdGNoOiBhZGQgLS1zdHJpY3QgInBvaW50ZXIgY29tcGFyaXNvbiB0byANCk5VTEwiIHRlc3Qi
KQ0KDQo+IA0KPiA0LiBUaGUgcmVzdWx0IG9mDQo+IAktCW1vZC0+a2xwX2luZm8tPnNlY2hkcnNb
c3ltbmR4XS5zaF9hZGRyID0gXA0KPiAJLQkJKHVuc2lnbmVkIGxvbmcpIG1vZC0+Y29yZV9rYWxs
c3ltcy5zeW10YWI7DQo+IAkrCW1vZC0+a2xwX2luZm8tPnNlY2hkcnNbc3ltbmR4XS5zaF9hZGRy
ID0gKHVuc2lnbmVkIGxvbmcpbW9kLT5jb3JlX2thbGxzeW1zLnN5bXRhYjsNCj4gDQo+ICAgICBp
cyA5MCBjaGFyYWNldGVycyBsb25nIGFuZCBEb2N1bWVudGF0aW9uL3Byb2Nlc3MvY29kaW5nLXN0
eWxlLnJzdCBzYXlzOg0KDQpQcm9iYWJseSBhIG1pc2ludGVycHJldGF0aW9uIG9mOg0KDQpXQVJO
SU5HOiBBdm9pZCB1bm5lY2Vzc2FyeSBsaW5lIGNvbnRpbnVhdGlvbnMNCiMyMTA3OiBGSUxFOiBr
ZXJuZWwvbW9kdWxlLmM6MjEwNzoNCisJbW9kLT5rbHBfaW5mby0+c2VjaGRyc1tzeW1uZHhdLnNo
X2FkZHIgPSBcDQoNCj4gDQo+IAkyKSBCcmVha2luZyBsb25nIGxpbmVzIGFuZCBzdHJpbmdzDQo+
IAktLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IA0KPiAJQ29kaW5nIHN0eWxl
IGlzIGFsbCBhYm91dCByZWFkYWJpbGl0eSBhbmQgbWFpbnRhaW5hYmlsaXR5IHVzaW5nIGNvbW1v
bmx5DQo+IAlhdmFpbGFibGUgdG9vbHMuDQo+IA0KPiAJVGhlIHByZWZlcnJlZCBsaW1pdCBvbiB0
aGUgbGVuZ3RoIG9mIGEgc2luZ2xlIGxpbmUgaXMgODAgY29sdW1ucy4NCj4gDQo+IAlTdGF0ZW1l
bnRzIGxvbmdlciB0aGFuIDgwIGNvbHVtbnMgc2hvdWxkIGJlIGJyb2tlbiBpbnRvIHNlbnNpYmxl
IGNodW5rcywNCj4gCXVubGVzcyBleGNlZWRpbmcgODAgY29sdW1ucyBzaWduaWZpY2FudGx5IGlu
Y3JlYXNlcyByZWFkYWJpbGl0eSBhbmQgZG9lcw0KPiAJbm90IGhpZGUgaW5mb3JtYXRpb24uDQo+
IA0KPiAgICAgY2hlY2twYXRjaC5wbCBhY2NlcHRzIGxpbmVzIHVwIHRvIDEwMCBjb2x1bW5zIGJ1
dCA4MCBhcmUgc3RpbGwNCj4gICAgIHByZWZlcnJlZC4NCj4gDQo+IA0KPj4gWW91IGFyZSByaWdo
dCB0aGF0IHJhbmRvbWx5IHVwZGF0aW5nIHRoZSBzdHlsZSBldmVyeSBoYWxmIGEgeWVhciB3b3Vs
ZA0KPj4gYmUgYSBuaWdodG1hcmUgYW5kIHdvdWxkIGtpbGwgYmxhbWFiaWxpdHkgb2YgY2hhbmdl
cy4NCj4+DQo+PiBIb3dldmVyIHdoZW4gbW92aW5nIGJpZyBwZWFjZXMgb2YgY29kZSBsaWtlIHRo
aXMsIGJsYW1hYmlsaXR5IGlzIGJyb2tlbg0KPj4gYW55d2F5IGFuZCB0aGlzIGlzIGEgdmVyeSBn
b29kIG9wcG9ydHVuaXR5IHRvIGluY3JlYXNlIGNvbXBsaWFuY2Ugb2YNCj4+IGtlcm5lbCBjb2Rl
IHRvIGl0cyBvd24gY29keWluZyBzdHlsZS4gQnV0IGRvaW5nIGl0IGluIHNldmVyYWwgc3RlcHMN
Cj4+IGluY3JlYXNlcyBjb2RlIGNodXJuIGFuZCBoYXMgbm8gcmVhbCBhZGRlZCB2YWx1ZS4NCj4g
DQo+ICBGcm9tIERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0Og0K
PiANCj4gCU9uZSBzaWduaWZpY2FudCBleGNlcHRpb24gaXMgd2hlbiBtb3ZpbmcgY29kZSBmcm9t
IG9uZSBmaWxlIHRvDQo+IAlhbm90aGVyIC0tIGluIHRoaXMgY2FzZSB5b3Ugc2hvdWxkIG5vdCBt
b2RpZnkgdGhlIG1vdmVkIGNvZGUgYXQgYWxsIGluDQo+IAl0aGUgc2FtZSBwYXRjaCB3aGljaCBt
b3ZlcyBpdC4gIFRoaXMgY2xlYXJseSBkZWxpbmVhdGVzIHRoZSBhY3Qgb2YNCj4gCW1vdmluZyB0
aGUgY29kZSBhbmQgeW91ciBjaGFuZ2VzLiAgVGhpcyBncmVhdGx5IGFpZHMgcmV2aWV3IG9mIHRo
ZQ0KPiAJYWN0dWFsIGRpZmZlcmVuY2VzIGFuZCBhbGxvd3MgdG9vbHMgdG8gYmV0dGVyIHRyYWNr
IHRoZSBoaXN0b3J5IG9mDQo+IAl0aGUgY29kZSBpdHNlbGYuDQo+IA0KPiANCj4+Pg0KPj4+IENv
ZGluZyBzdHlsZSBjaGFuZ2VzIG1pZ2h0IGJlIGFjY2VwdGFibGUgb25seSB3aGVuIHRoZSBjb2Rl
IGlzDQo+Pj4gcmV3b3JrZWQgb3Igd2hlbiBpdCBzaWduaWZpY2FudGx5IGltcHJvdmVzIHJlYWRh
YmlsaXR5Lg0KPj4NCj4+IFdoZW4gY29kZSBpcyBtb3ZlZCBhcm91bmQgaXQgaXMgYWxzbyBhIGdv
b2Qgb3Bwb3J0dW5pdHkuDQo+IA0KPiBObyENCg0KDQpCeSB0aGUgd2F5IHNvbWUgbWFpbnRhaW5l
cnMgcmVxdWlyZSBjaGVja3BhdGNoJyBjbGVhbiBwYXRjaGVzIGV2ZW4gd2hlbiANCnRoaXMgaXMg
b25seSBjb2RlIG1vdmUuIEkgcmVtZW1iZXIgYmVpbmcgcmVxdWVzdGVkIHRvIGRvIHRoYXQgaW4g
dGhlIA0KcGFzdCwgc28gbm93IEkgYWxtb3N0IGFsd2F5cyBkbyBpdCB3aXRoIG15IG93biBwYXRj
aGVzLg0KDQo+IA0KPiBJIHdvdWxkIG5vdCBoYXZlIGNvbXBsYWluZWQgaWYgaXQgZGlkIG5vdCBj
b21wbGljYXRlIG15IHJldmlldy4NCj4gQnV0IGl0IGRpZCENCj4gDQoNClJldmlld2luZyBwYXJ0
aWFsIGNvZGUgbW92ZSBpcyBub3QgZWFzeSBhbnl3YXksIGdpdCBpcyBub3QgdmVyeSANCnVzZXJm
cmllbmRseSB3aXRoIHRoYXQuDQoNCkNocmlzdG9waGU=
