Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C340C4C00C9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbiBVSAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiBVR76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:59:58 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90072.outbound.protection.outlook.com [40.107.9.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C688172240;
        Tue, 22 Feb 2022 09:59:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpf0uzI+umrdZ0vaIcpXYzQ6096V1QOvuCkJ87E4rMMHeFoyTT+uNEkQ2LT/HjbcGc7NGTLULur/+evgK+Ppj5Hz4A0i8QxuzbBFAGfeaEZ6AslxwwiFOP7z7DUCLF3uy03x9izwc/LtzutZMAMIhrE7i9ZUPIUn4WUFaWpvSVh6Hi8fP54jW7fuZeuiRDgPe/9VwYs78PG3aQZZq10GeGNxNKZPiLyx9beaLTJMMCHiG7ZXlkrHoODCVH02E828AP2RmqigleE+YKqmGY+i9iQXl6AYJbhKKQ+zh+Oe4sfduKNj+0gYCYTviaeFQ2AXzC/BNtQqYWKonLKERGZLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PMU/38sYig1RPvEkODuxyM88aoZcrc349zzBGN2K0Q=;
 b=I57HJCRwbbzt9hw+oLFEpcpe48P99Bam3vdluQxV7ieHLTDP/+GL0q8Ay2PrdbvM5hsg9mw4mOOuLRc+yOP3YBiCKmBXPcXBTCPx7I7kbm8AZn3sawXz2XyniyykZegP4+HQoJTEwrwVpZ1GDjX9KqnqAh3zygtRu0rMRcuVzxiZD58ajZcRiGyuSJa0p4R6Z2SglJReGX93CKRMYc9m7eh+34PSSC3LKRE5qFzqwdBW0MZPhARrj+4wvqBiZz55yD1+Ip9YFThBoCHai7b2BycC19KX8rDqp2iwIJEoDVmE5ultldZG/whn2xFuJb3TUGhz27SORHjnaltYMOPp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3442.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:26::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 17:59:24 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%5]) with mapi id 15.20.5017.021; Tue, 22 Feb 2022
 17:59:24 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
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
Subject: Re: [PATCH v8 08/13] module: Move kmemleak support to a separate file
Thread-Topic: [PATCH v8 08/13] module: Move kmemleak support to a separate
 file
Thread-Index: AQHYJ/ZWbqlkvHgvpEi4JSXUrayUHayf2+uA
Date:   Tue, 22 Feb 2022 17:59:24 +0000
Message-ID: <2d6f48d5-231e-ae59-7c92-a0e977f900a0@csgroup.eu>
References: <20220222141303.1392190-1-atomlin@redhat.com>
 <20220222141303.1392190-9-atomlin@redhat.com>
In-Reply-To: <20220222141303.1392190-9-atomlin@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6788d614-8879-47aa-1cac-08d9f62d0f82
x-ms-traffictypediagnostic: MR1P264MB3442:EE_
x-microsoft-antispam-prvs: <MR1P264MB34426378FD5D4593396B9F64ED3B9@MR1P264MB3442.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uaStg9ETa1aJZBFy4XWXsGvze7UAxqabsLvOmq/v9al1SRvIbHZgZ7MAHKJbI5wMlRmgwH3KK6qGiH0rWlsKNOElZLkUB3bNE9/3YScaQlxEM070I5xG0C97h+aZYI9IuiyyR23ERk2yCbrfwy44fK2kbB8sLZo3Ox111cYY3ORvJBw3kw6BnbrimBoiRe+36eI+DH0+NwRi17xaWQT74sOzLMklxxHrxfbo8dT2LIRlUILyg2KAmQai4HCt5Ai3AmfrxMtFaSnyex8yRZ3g8UMv3Ycgxq4Yc+XCDDHZyKuKKpgFto7DUqILuZsbVjdMVF1Tp4jkXXi1p5JWsEDdEEM9VFx9YfRg6uE75+qegrTctUMCFxeqLLDVkKM9B5MEhF8PiMWM3tY+6p+lQkSHzQuRlPo26f+kdBMnrSEy+Tc2jGR/XD5lMJSwhveQmjDdvjLFX/eRZPrbyR+j0X/AjwSlXNPVmRRBcIFe/hljYDs+7M/jiBPFLpPA3Kn3U+Az+C/eNu3Rra8ZT4ntciPeJSBJymeUaEuDIR6wVK8CcP7DsHgsVFWbbt0Yiow4kIgdTlr9/1dUqCpnugPmug5OujS7M51HQ1zc+1YA/D7aZpeGJa2BI2QUP0+ZwQKuFY4MGsHnuW4jpiNbBse1RO6/yQQjWzlOIVbAcl5BeGOpkUAQrShNXezdoeBwXShDMGAuUq0gWTSgxkITwQDD2tWwZXYWGmnhjkkbYwUXY764iLcTIX4FjxVqj8vdQBPjy0oajkHCTxXdwM4FBEmNT9ETzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(7416002)(508600001)(6486002)(91956017)(66574015)(66946007)(76116006)(86362001)(66556008)(4326008)(64756008)(31696002)(8676002)(66446008)(316002)(8936002)(71200400001)(44832011)(66476007)(186003)(26005)(38100700002)(36756003)(122000001)(38070700005)(2906002)(2616005)(31686004)(110136005)(6512007)(54906003)(6506007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEJDdnZmQzRqUE1YUlNYemEveGxJVm5PWWJYRG1YYWZpdVJXMzY4eWgzdlkz?=
 =?utf-8?B?aTh0bTFwUXpLRVJlUDJuYWNma1pvZDFPSFM0Rk1yV0x1NjBXZVBUYzBVNEF3?=
 =?utf-8?B?UjE3dTNDSVZzL1EvNE84TTNLN1I1bFZrSEI5OUxReGR2R2JwZjZtSUhvSGdw?=
 =?utf-8?B?NUxzL091SVIyMUFpRnV6Ykc3dVhFMmZ6WlNDR1B4WStVN25wUmxHOEZWMkJx?=
 =?utf-8?B?dlF0ZWoyZ0V0aG13ZlVOeXloTmtrK2xWT1V4aDV4MCtxUWpNTENRQW54K2d1?=
 =?utf-8?B?c2N0RE80Q1VpaVNXVEhxL0VTZVNsTEFvcWVXSDBJU0RJUTVZMmpPejRVeW1a?=
 =?utf-8?B?SFJWSFpUajJTcllHNWlKL1Z1MEI0Y3JVUlRvZGxrWFBKYjljTUJHWTdBN1lO?=
 =?utf-8?B?VEY5Y1p1RUIycURFZVZ4UkFCMFprMjZuOHBTVzhRYWgvanAwRTZidk14a0tT?=
 =?utf-8?B?OVQ1ZkxMb3NwYUtLNGw3Z2ZWZktzMmV4UnRkSXNGaVlwZUEydzBqUEtKZldG?=
 =?utf-8?B?T1RLUG9RYU5hejBMNkFZUEltRTBsS2o4VndjVWVyUG9rRTc5QmZNT21hcmo5?=
 =?utf-8?B?TE5SOWF5Z1ZUS083WHFadVpLNTUyYm5GaEszY2hrSUxPeGNESHhnbmtvVXN4?=
 =?utf-8?B?bGFYRXNTenVVbnNBWjd5VjNDSXVTZVJFcDMyQmhQWXNIQWtOYWlKY2lyYW42?=
 =?utf-8?B?MzV1UUNaaFpDZ1h4aFRYV2xwZTFGLzRBNCtnY2k1ZFZkSEVyaWlOMkJaNXFV?=
 =?utf-8?B?VG1vQUJiSGtrN1VaT3g0cGxFbnpvVy9xUll1V0kzNnFjY2RYdzQ4OHRHZDBM?=
 =?utf-8?B?bDFmVnhSTzJpdjRLTjJpRUs3Y0dVbEJrZE5IeFJxc2Ezc2ZZMk5teFBGbTIw?=
 =?utf-8?B?SkU5eXlMM1poRDM1Tk1MaTZrZjhjbHBrUEU5VUdvclU4L1NJanVXTk5vYzhr?=
 =?utf-8?B?QWRoOEp6eUh3NEkzNWV3NUVnbkJwV2JvdU1CYjM4clhqbnExUUlVRGFZMWtk?=
 =?utf-8?B?UlZJQnM0bU5LV0RmT0owOUE2N3FPeGVkZW9vUnRDNWJhQk5iL09kMkM1YXpt?=
 =?utf-8?B?SnhQc0M2ZVRueHdEem82Yk1qa3VuVEJOVHdpRU15M0I3cWF0LzdpZWU0Q2dS?=
 =?utf-8?B?bnlIU3VlZ1pxM2Y4UlJrQndmSjJOY1dpOVFQMjI1M1lxd0ZrZHhIRGpCRXNH?=
 =?utf-8?B?c0paMXdQSnRrY2FydGx6WXAvdmEwM3J2RmhMMlBBQ29SR3YwbU14dXg1SVQx?=
 =?utf-8?B?UXZzNGJtWnhvTFJZeSs1N2xXcFByOVpJRTJ3Mnh1TTlPa1BHcDNiMkZkNkdB?=
 =?utf-8?B?c3hMektyYzh5Q3l5KzNrWm5WWlBNKy9TM2RWbzVrWjZHa1hrYk9sTCtYYjFR?=
 =?utf-8?B?TkNrUDJvcEl5Nms3eXJOSjF0cG42NnY4T2pCVGFhbTVHU1diRDNlYTh0OEpn?=
 =?utf-8?B?SmlZR2pvZTVuVXpBNGJXbG55ci9SRVNxOU8xUmoyVXBjV1hzbngyaWI0Y2lX?=
 =?utf-8?B?cXNsb1ZJK3ZWVXJla3owTm1EcU1LNUp0dWxGL1Q4aG83bThUM0Y3TFJ1cjVp?=
 =?utf-8?B?YlpWWGRMclhQY01iczZDcnZndWk3K1lMQThabTlMWFhtSnh5M1pXc1lVNEJv?=
 =?utf-8?B?cjlDQ2JjSGVyU2NIcDBGbzl5YTcyeG9iK2lnTGU1T05nWjd4OC96UlR1NFJZ?=
 =?utf-8?B?SjhFbUtSWG1uaWxPemZqV0tBQUk2L2Jud056ZjdSM0lackxiQU5ORGtzeEsz?=
 =?utf-8?B?Z1pGTmdsZlozM3BTbTZWdyttQmpjNGZuMDFlaEo4WlFUcG4zL3c5TExxMndG?=
 =?utf-8?B?OVJhQjJOWEdUT0t3YXNxblpOZmdKZ1B0OVIzZjErMUFkZHlqeFpJUS9kUjYv?=
 =?utf-8?B?QnRKWFdtcjVPcVFtakliRCtoUmFOQ3pGMkk4dGVSVTU4NkJXd3hLakxzdHF3?=
 =?utf-8?B?K3Q3MUVPVjVjcTJNVjBuNXZ2dnJXZ2ttaGRZL1dmbm0wbkFLZVN1Yzk3WGZz?=
 =?utf-8?B?dkRaSjR1R0ZlRjNPT0dha1lhSDFaU2xKdVFwdzh4dXU4ZkVXQjBxWGlxWlVs?=
 =?utf-8?B?cWNiNmJLUHIycnhWcGJOUk5maWthNTgwb24ydW4vcE4rMmJXOTRMVW9vaHZG?=
 =?utf-8?B?WC84czNXZnBnZzI5bmVSTWFJUWhiSE5PdmZDOGYzL3lMUER3SkVQQnArcVNI?=
 =?utf-8?B?M09rSWJwZDNrU0JnSEJoSTB5ZlZrQ1BZQ0pON09TT3Y5dmxmemxiUnRVdkI5?=
 =?utf-8?Q?pMUqlG+jgJ0oHNZruukkHt51Zi473vVqonZaPetJ8s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DEB4CB45E78AF4B9C540DD3689B60F4@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6788d614-8879-47aa-1cac-08d9f62d0f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 17:59:24.2832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ljCsaUpdLPin5A5Mp3MLu8AegIR6f5JPgA2Ts4QdpTzrHkcBk/gliy1CZgjbcpRI5Qk0uUHTZOM4GdWMle4KXTFk7imsqM23uiGVhQ8p8TA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3442
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIyLzAyLzIwMjIgw6AgMTU6MTIsIEFhcm9uIFRvbWxpbiBhIMOpY3JpdMKgOg0KPiBO
byBmdW5jdGlvbmFsIGNoYW5nZS4NCj4gDQo+IFRoaXMgcGF0Y2ggbWlncmF0ZXMga21lbWxlYWsg
Y29kZSBvdXQgb2YgY29yZSBtb2R1bGUNCj4gY29kZSBpbnRvIGtlcm5lbC9tb2R1bGUvZGVidWdf
a21lbWxlYWsuYw0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWFyb24gVG9tbGluIDxhdG9tbGluQHJl
ZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxl
cm95QGNzZ3JvdXAuZXU+DQoNCj4gLS0tDQo+ICAga2VybmVsL21vZHVsZS9NYWtlZmlsZSAgICAg
ICAgIHwgIDEgKw0KPiAgIGtlcm5lbC9tb2R1bGUvZGVidWdfa21lbWxlYWsuYyB8IDMwICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGtlcm5lbC9tb2R1bGUvaW50ZXJuYWwuaCAg
ICAgICB8ICA3ICsrKysrKysNCj4gICBrZXJuZWwvbW9kdWxlL21haW4uYyAgICAgICAgICAgfCAy
NyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICA0IGZpbGVzIGNoYW5nZWQsIDM4IGlu
c2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBrZXJu
ZWwvbW9kdWxlL2RlYnVnX2ttZW1sZWFrLmMNCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvbW9k
dWxlL01ha2VmaWxlIGIva2VybmVsL21vZHVsZS9NYWtlZmlsZQ0KPiBpbmRleCBkMzEzYzg0NzJj
YjMuLjEyMzg4NjI3NzI1YyAxMDA2NDQNCj4gLS0tIGEva2VybmVsL21vZHVsZS9NYWtlZmlsZQ0K
PiArKysgYi9rZXJuZWwvbW9kdWxlL01ha2VmaWxlDQo+IEBAIC0xMywzICsxMyw0IEBAIG9iai0k
KENPTkZJR19NT0RVTEVfU0lHKSArPSBzaWduaW5nLm8NCj4gICBvYmotJChDT05GSUdfTElWRVBB
VENIKSArPSBsaXZlcGF0Y2gubw0KPiAgIG9iai0kKENPTkZJR19NT0RVTEVTX1RSRUVfTE9PS1VQ
KSArPSB0cmVlX2xvb2t1cC5vDQo+ICAgb2JqLSQoQ09ORklHX1NUUklDVF9NT0RVTEVfUldYKSAr
PSBzdHJpY3Rfcnd4Lm8NCj4gK29iai0kKENPTkZJR19ERUJVR19LTUVNTEVBSykgKz0gZGVidWdf
a21lbWxlYWsubw0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL21vZHVsZS9kZWJ1Z19rbWVtbGVhay5j
IGIva2VybmVsL21vZHVsZS9kZWJ1Z19rbWVtbGVhay5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uMTJhNTY5ZDM2MWU4DQo+IC0tLSAvZGV2L251bGwNCj4g
KysrIGIva2VybmVsL21vZHVsZS9kZWJ1Z19rbWVtbGVhay5jDQo+IEBAIC0wLDAgKzEsMzAgQEAN
Cj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+ICsvKg0K
PiArICogTW9kdWxlIGttZW1sZWFrIHN1cHBvcnQNCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgKEMp
IDIwMDkgQ2F0YWxpbiBNYXJpbmFzDQo+ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgPGxpbnV4L21v
ZHVsZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2ttZW1sZWFrLmg+DQo+ICsjaW5jbHVkZSAiaW50
ZXJuYWwuaCINCj4gKw0KPiArdm9pZCBrbWVtbGVha19sb2FkX21vZHVsZShjb25zdCBzdHJ1Y3Qg
bW9kdWxlICptb2QsDQo+ICsJCQkgIGNvbnN0IHN0cnVjdCBsb2FkX2luZm8gKmluZm8pDQo+ICt7
DQo+ICsJdW5zaWduZWQgaW50IGk7DQo+ICsNCj4gKwkvKiBvbmx5IHNjYW4gdGhlIHNlY3Rpb25z
IGNvbnRhaW5pbmcgZGF0YSAqLw0KPiArCWttZW1sZWFrX3NjYW5fYXJlYShtb2QsIHNpemVvZihz
dHJ1Y3QgbW9kdWxlKSwgR0ZQX0tFUk5FTCk7DQo+ICsNCj4gKwlmb3IgKGkgPSAxOyBpIDwgaW5m
by0+aGRyLT5lX3NobnVtOyBpKyspIHsNCj4gKwkJLyogU2NhbiBhbGwgd3JpdGFibGUgc2VjdGlv
bnMgdGhhdCdzIG5vdCBleGVjdXRhYmxlICovDQo+ICsJCWlmICghKGluZm8tPnNlY2hkcnNbaV0u
c2hfZmxhZ3MgJiBTSEZfQUxMT0MpIHx8DQo+ICsJCSAgICAhKGluZm8tPnNlY2hkcnNbaV0uc2hf
ZmxhZ3MgJiBTSEZfV1JJVEUpIHx8DQo+ICsJCSAgICAoaW5mby0+c2VjaGRyc1tpXS5zaF9mbGFn
cyAmIFNIRl9FWEVDSU5TVFIpKQ0KPiArCQkJY29udGludWU7DQo+ICsNCj4gKwkJa21lbWxlYWtf
c2Nhbl9hcmVhKCh2b2lkICopaW5mby0+c2VjaGRyc1tpXS5zaF9hZGRyLA0KPiArCQkJCSAgIGlu
Zm8tPnNlY2hkcnNbaV0uc2hfc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ICsJfQ0KPiArfQ0KPiBkaWZm
IC0tZ2l0IGEva2VybmVsL21vZHVsZS9pbnRlcm5hbC5oIGIva2VybmVsL21vZHVsZS9pbnRlcm5h
bC5oDQo+IGluZGV4IGQ2ZjY0NmE1ZGE0MS4uYjBjMzYwODM5ZjYzIDEwMDY0NA0KPiAtLS0gYS9r
ZXJuZWwvbW9kdWxlL2ludGVybmFsLmgNCj4gKysrIGIva2VybmVsL21vZHVsZS9pbnRlcm5hbC5o
DQo+IEBAIC0xNjcsMyArMTY3LDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50IG1vZHVsZV9zaWdfY2hl
Y2soc3RydWN0IGxvYWRfaW5mbyAqaW5mbywgaW50IGZsYWdzKQ0KPiAgIAlyZXR1cm4gMDsNCj4g
ICB9DQo+ICAgI2VuZGlmIC8qICFDT05GSUdfTU9EVUxFX1NJRyAqLw0KPiArDQo+ICsjaWZkZWYg
Q09ORklHX0RFQlVHX0tNRU1MRUFLDQo+ICt2b2lkIGttZW1sZWFrX2xvYWRfbW9kdWxlKGNvbnN0
IHN0cnVjdCBtb2R1bGUgKm1vZCwgY29uc3Qgc3RydWN0IGxvYWRfaW5mbyAqaW5mbyk7DQo+ICsj
ZWxzZSAvKiAhQ09ORklHX0RFQlVHX0tNRU1MRUFLICovDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQg
a21lbWxlYWtfbG9hZF9tb2R1bGUoY29uc3Qgc3RydWN0IG1vZHVsZSAqbW9kLA0KPiArCQkJCQlj
b25zdCBzdHJ1Y3QgbG9hZF9pbmZvICppbmZvKSB7IH0NCj4gKyNlbmRpZiAvKiBDT05GSUdfREVC
VUdfS01FTUxFQUsgKi8NCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9tb2R1bGUvbWFpbi5jIGIva2Vy
bmVsL21vZHVsZS9tYWluLmMNCj4gaW5kZXggYzYzZTEwYzYxNjk0Li43ZGQyODM5NTljNWMgMTAw
NjQ0DQo+IC0tLSBhL2tlcm5lbC9tb2R1bGUvbWFpbi5jDQo+ICsrKyBiL2tlcm5lbC9tb2R1bGUv
bWFpbi5jDQo+IEBAIC0yNTE5LDMzICsyNTE5LDYgQEAgYm9vbCBfX3dlYWsgbW9kdWxlX2V4aXRf
c2VjdGlvbihjb25zdCBjaGFyICpuYW1lKQ0KPiAgIAlyZXR1cm4gc3Ryc3RhcnRzKG5hbWUsICIu
ZXhpdCIpOw0KPiAgIH0NCj4gICANCj4gLSNpZmRlZiBDT05GSUdfREVCVUdfS01FTUxFQUsNCj4g
LXN0YXRpYyB2b2lkIGttZW1sZWFrX2xvYWRfbW9kdWxlKGNvbnN0IHN0cnVjdCBtb2R1bGUgKm1v
ZCwNCj4gLQkJCQkgY29uc3Qgc3RydWN0IGxvYWRfaW5mbyAqaW5mbykNCj4gLXsNCj4gLQl1bnNp
Z25lZCBpbnQgaTsNCj4gLQ0KPiAtCS8qIG9ubHkgc2NhbiB0aGUgc2VjdGlvbnMgY29udGFpbmlu
ZyBkYXRhICovDQo+IC0Ja21lbWxlYWtfc2Nhbl9hcmVhKG1vZCwgc2l6ZW9mKHN0cnVjdCBtb2R1
bGUpLCBHRlBfS0VSTkVMKTsNCj4gLQ0KPiAtCWZvciAoaSA9IDE7IGkgPCBpbmZvLT5oZHItPmVf
c2hudW07IGkrKykgew0KPiAtCQkvKiBTY2FuIGFsbCB3cml0YWJsZSBzZWN0aW9ucyB0aGF0J3Mg
bm90IGV4ZWN1dGFibGUgKi8NCj4gLQkJaWYgKCEoaW5mby0+c2VjaGRyc1tpXS5zaF9mbGFncyAm
IFNIRl9BTExPQykgfHwNCj4gLQkJICAgICEoaW5mby0+c2VjaGRyc1tpXS5zaF9mbGFncyAmIFNI
Rl9XUklURSkgfHwNCj4gLQkJICAgIChpbmZvLT5zZWNoZHJzW2ldLnNoX2ZsYWdzICYgU0hGX0VY
RUNJTlNUUikpDQo+IC0JCQljb250aW51ZTsNCj4gLQ0KPiAtCQlrbWVtbGVha19zY2FuX2FyZWEo
KHZvaWQgKilpbmZvLT5zZWNoZHJzW2ldLnNoX2FkZHIsDQo+IC0JCQkJICAgaW5mby0+c2VjaGRy
c1tpXS5zaF9zaXplLCBHRlBfS0VSTkVMKTsNCj4gLQl9DQo+IC19DQo+IC0jZWxzZQ0KPiAtc3Rh
dGljIGlubGluZSB2b2lkIGttZW1sZWFrX2xvYWRfbW9kdWxlKGNvbnN0IHN0cnVjdCBtb2R1bGUg
Km1vZCwNCj4gLQkJCQkJY29uc3Qgc3RydWN0IGxvYWRfaW5mbyAqaW5mbykNCj4gLXsNCj4gLX0N
Cj4gLSNlbmRpZg0KPiAtDQo+ICAgc3RhdGljIGludCB2YWxpZGF0ZV9zZWN0aW9uX29mZnNldChz
dHJ1Y3QgbG9hZF9pbmZvICppbmZvLCBFbGZfU2hkciAqc2hkcikNCj4gICB7DQo+ICAgI2lmIGRl
ZmluZWQoQ09ORklHXzY0QklUKQ==
