Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B964C4169
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbiBYJ2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237494AbiBYJ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:28:10 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90085.outbound.protection.outlook.com [40.107.9.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A294E12B74B;
        Fri, 25 Feb 2022 01:27:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CM0QiXirstGxrx6eE43s9U8buSCiWbQqB9Jv/mMopn8k5ch0b02zQENaFlpabyNkwQS2X1mYZjRpPQkGD26zcxR4gjWJHHN9gb2W3HpyWG7qXLdrqg0DsbXBSJCDqSAgb4F8o2INp6P1wnlbrlbF+spt7wMQ3Uzu4+HgRO5067W6EN0/I6HqSDeU1sk7mHS5SHAn1t4VW5DYSLMk9HhFn0s9yD0Pc4PzoEEhkBADROOLB/FnToroxdtBZA13amK8lczNQz+h64AJTUhK7P8VQD9MA5yAScbt0+NmXcV7447QBEaqQ6tXQ5s9uXatIf8RLyQmsFwQy3D/y4zwPpxbWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78X+6J0SzEd2MCkUyI8R5WsctE/Jc1YLl2OQMTTOnNg=;
 b=R2+xl21BDq6hb77PgHOU5xVzaMWO9IegukvzYF8EohymylVgSF7RKGk1UDVj6DyKxY9t1Ra78+wzvGJZG82b0JmaVDmyg4lcS0EOE858otGMJ04OuD7YzxjzkjxEq0+4DvANy/kMkWrfMbfqv+zZtuSJYf3ehcicTtQPh5Cs2FNEj4C6wBlvHjufLFrF8AiBWXhqDRNOQ1shZizQp9fb+Kw+1UG5wbZVa6Zkepd02AVGgdNTA1EtrRrWd9k69QsXyDrvWz4hOR0wbUGb5nvRQeWdi8w896dCqGrGsKy1sSti6Y9wck95bg7JG6CXjdvOpOae6kRDklE/Ju4CkVhqRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB3210.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 09:27:33 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%5]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 09:27:33 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Petr Mladek <pmladek@suse.com>, Aaron Tomlin <atomlin@redhat.com>
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
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: Re: [PATCH v8 09/13] module: Move kallsyms support into a separate
 file
Thread-Topic: [PATCH v8 09/13] module: Move kallsyms support into a separate
 file
Thread-Index: AQHYJ/ZZRfC599+XvUO2sDt7Xl3WR6ykAICAgAADaYA=
Date:   Fri, 25 Feb 2022 09:27:33 +0000
Message-ID: <f9449aa6-be9d-9021-66e7-fb0272909ee7@csgroup.eu>
References: <20220222141303.1392190-1-atomlin@redhat.com>
 <20220222141303.1392190-10-atomlin@redhat.com> <YhieKf9EcS3GQSXG@alley>
In-Reply-To: <YhieKf9EcS3GQSXG@alley>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6a87c1d-b7f1-4b98-56fd-08d9f8410db2
x-ms-traffictypediagnostic: MRZP264MB3210:EE_
x-microsoft-antispam-prvs: <MRZP264MB321091072F5CB772948D9BB6ED3E9@MRZP264MB3210.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1hx3JxtbSeO9bUy3k4Gb44GnClJmwzaxJvBirdRPVfsQJNEQpVGn873PKYil+L6Kjz7QjS7LRm5OUtfDOjeacXM8v5oxTkPdhys1i3qYmq9gQBHc1nXYk9zgwyYALbKKWzt/JRQ8/miuG7N7TNq4Yo5WEqLqCnA596Rulrc6nvvfNa2JcdmL4DkFe60zbI+CiJkv7OUs998whUKnq3N97hOa9Lm3tHa7M7yhC+h9419VzbSfQG+toEh7GhsepJodYurB1LvXfJhZt+qptShgXbheinBHadcyOmIkWY1ZC2JNHe2OH6pjtesqCgFinUGmURpBRgksHJMnmzB48N+A5gi9Z/4y3sZ5DqFydXPfyVLxOfPCD9Owldio2j01JfL8qzjUari9LkX0nVUokQyTVsUwaghECT6TDyM+OMm8VRoTNjj4f+UPNVJ4y6rXTjneyBCligVbn5LesOeWkvbDgeboYz3voXV17RZga020D1XMoppie87elCOERS1dqjoevOqu7f8l2bgAlpvXr5KpXHJZEH8qOB0BS8NAUedKV3KNz4k+vrk/R/EPp8jm8TBzMHGIGAtnOWDcM1lyR0TqoB/kNqzHAlydoU2HnhGNAmh3VUUZO3MByanwxxHa/77gNY7lqjRSEWebeK9AvSfcccpCvU7HedbpUmTRMuMYo93FJHSAc/cPB+6jg/uhZRLhGNxkKSWsay0a0ScIz9LIsW2hqN4qse5b4CIMHq7uDBFZpRYpvgmr3BbusTkPkgw/+224wG81yug2G/3d95Eafw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66574015)(122000001)(6486002)(36756003)(83380400001)(5660300002)(71200400001)(44832011)(26005)(38100700002)(2616005)(31686004)(8936002)(7416002)(186003)(508600001)(110136005)(38070700005)(31696002)(8676002)(86362001)(2906002)(4326008)(66556008)(66476007)(66446008)(91956017)(6506007)(76116006)(64756008)(66946007)(54906003)(6512007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWtZeHZMRkJXMytRNTlBZ0l1ZUVweHBEcndCOExQb3ppK0Nxdkd2M20wbUtz?=
 =?utf-8?B?WncveXVLbHovS2tZOGRtSzFoVncxZWpoNzd6R24rSEpPN1Y4SVJ5ek5aZTVS?=
 =?utf-8?B?Rjk3ajV0ZUN6TnFxbG9CTWdWN1VCRHJIUTFVTXBnQWFOMTM3eG9uWkhnUHg0?=
 =?utf-8?B?L1IwT1hkVTNDV3JWazdrUDBjaTN0a01SdVhzVEtGTnc5VlVkc1k0b3FCYy9i?=
 =?utf-8?B?eHdscUwyVkxxRmhFcVcrOWhveVhOMUx5azJ3SEFsNFdNdlZxcGRVMnAxYkVs?=
 =?utf-8?B?RWo0UmgzZlFSMXE1RzFBSENmcnhFUXo4QUcyNVZPNGtoMjErd1h0emJHK2Fh?=
 =?utf-8?B?cVZCR2hWbm9JSHIzYnF2VlhxWVZKeWxmTWtFL2V2S0M0N3AvTkhNSloxeXBC?=
 =?utf-8?B?QVViMkFYMDQvQXcwVi82UVlYUGlUaHVvRW1JSG4xK2ljeVFFemNSWWM4MFI2?=
 =?utf-8?B?VVhhcHdwUTdXRm92Z2FnTGZGcE5MUjNWTkVkVHllOHBGMzlVOUlLNzNmalZM?=
 =?utf-8?B?THo0dHRFVTZTcmxzRk0xT0hjR0dpeldrWFlBQUVWdFhXbUdIUnlXaWl6YjFO?=
 =?utf-8?B?U2tybTF2MzBzQStVZ1VUYWFsNnZ6NG5scWlaK0ZWL1FnazJwSDdPNGdEWUZS?=
 =?utf-8?B?U1BWUlRuVWhYOS9ibjQweTA2eUlnNlRnWm9kUHNONnBhbHAveXV4YWxrNzlY?=
 =?utf-8?B?Rk9OSnRtcFF0ZHhZRWMxN2I5emhHdlExUHhBbGhPSlRpRFJzV1Y0bTV6L3k2?=
 =?utf-8?B?aGo5N2ZBL3BVVmZZNVZqQ0l5c2FuS3lyVVVQdVp1cEpQWnpYWk9PQlRQSUZl?=
 =?utf-8?B?WTdiS1BRKzQ5YmJGdkhzejkwWDlML3E5MHpiQjZiUVE3OEpEOGJ3MEJSRFBD?=
 =?utf-8?B?TEVlLzdjYXJhbGc2M0I0a2FGM1FIZVFWbTltVUR2dVBUMktZWlk2WmhETnJR?=
 =?utf-8?B?dzdSY2lSSXZ6blBkdUh5YVQ0UnFQSUlka2JFSkJ6NGlmK092SUNWYUl5V3RW?=
 =?utf-8?B?cldiOU5pWVpYa2JNMnNaS01RNzRhYno1dUZLK1dlM0FiL05XQkI0bll1cUxr?=
 =?utf-8?B?R1djNmNiczNKcW4yYUtSS0xyMkpJSTdSL2hIeTNQTk9uMHZoY0g0TFNMNDd3?=
 =?utf-8?B?a2gzaUVrc1FNWkFRZWxJUTVqM3RmOEFoNmNkMXZKUjZnN0l3UTlMY0V5V0VC?=
 =?utf-8?B?bFk2WTlpVzJGTGZvQ0RXZ2I1Uk05NENMa2szaExVejJ4d3ZsUHVpSWxRT25H?=
 =?utf-8?B?WWJmelRxM1RGNnlOVEJ4THJjZzZQSEFBb3FQbVVHZXJucGNBZ3owNG11N3ZB?=
 =?utf-8?B?ZjlUVEpyU0RMeEZua1Qzd3NPZmhxeFhtd1NlTHVSdktFWEtiZTRnTXNrbG13?=
 =?utf-8?B?a3BZTFk1N1NNNlZHRkZPZWI0VC8vdzJjUWNTYm1ZcE1teWV6cVowNVhLRXlG?=
 =?utf-8?B?elhPRW1jOVVSRHhKT3QrVnJCWTNTYmw1dmdwb2R1OFFUK1ZrQnNOTlVOYVR1?=
 =?utf-8?B?ZHdRUVhkbnRJb0dmV0d6K2VHOFRCYXRSWEJQK1hGZXJrQnliMFNsSExxYU0z?=
 =?utf-8?B?d0w3UTh4dDVOZ244aVp4TktXd3BlREszZVVWQnVsMlpscytlNkd0dHVEUzl6?=
 =?utf-8?B?Yk1uazFmbU9wQVY1RlFqRGRVdEcvMHJ1UHM5T1cwZUttTHVtQTVlNHBlVnZP?=
 =?utf-8?B?OUQ0b2Y1dXlmUUNseEU1dFNGM1BSM3pRalZFNzcyaTJXYkNTTDdEamFRYk5q?=
 =?utf-8?B?dC9rWEFMNEhSSkk4ZEVDZmRkeXRKSFEzblRZTGRiZkVEcUhTTWljZHIvMkpR?=
 =?utf-8?B?MDRIZUNXL0xWc3REMk9JSGFsZWZJeFNqK0VRcUpSZEcra3V1RmE2a3VnQU1L?=
 =?utf-8?B?VUVCbkF0ODVYYTRxR1hSKytmbEo4RHZ2QjRoM2JhQmZ0QktRM3p2NnBFV3lL?=
 =?utf-8?B?SUFhQ3RNS3UvQ0daOFJLT292aG5SUVNRZHV6TnA2VHFhaXgrM3c3Z0ZPKzI5?=
 =?utf-8?B?VU1oejEzZHhLME5pL2tuemFJTFRsQi9rMDRTemZCeFo5eHlwbHRhVEdGazJR?=
 =?utf-8?B?cHhub3J5djlDKzMrcXhwU1hkMjMrbDFUeWdhNmtxNEx4UWJQYURySndnbFlC?=
 =?utf-8?B?WHVUQ1pSTDYyVW9oR01icGZGYnNIeExPNjRnR2g4a3FkZUs0ZkpRYjBDUWIv?=
 =?utf-8?B?UlgyVENzUFJQeVE3SE56NU8weklqaDFOM3ZiQnpBT1hTUFBWdHloNS8xWjJl?=
 =?utf-8?Q?D1VtBV7KIrAT5Tp/SOhgFtHQXHC1K9F/iffwuabSbA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4B415B6F3179E47A17642BB3563C5B7@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a87c1d-b7f1-4b98-56fd-08d9f8410db2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 09:27:33.5052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNlNZtBQf0yK/QzBQ3Lyb4xi08t/60/8nupsJ52eUSGVOgitP6xxPOJtrLa8AnnIGubEb88+Mtt25PTenYv+ma/4dTrD3JoPXfKC2zEuviY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3210
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI1LzAyLzIwMjIgw6AgMTA6MTUsIFBldHIgTWxhZGVrIGEgw6ljcml0wqA6DQo+IE9u
IFR1ZSAyMDIyLTAyLTIyIDE0OjEyOjU5LCBBYXJvbiBUb21saW4gd3JvdGU6DQo+PiBObyBmdW5j
dGlvbmFsIGNoYW5nZS4NCj4gDQo+IFRoZSBwYXRjaCBhZGRzIHJjdV9kZXJlZmVyZW5jZV9zY2hl
ZCgpIGludG8gc2V2ZXJhbCBsb2NhdGlvbnMuDQo+IEl0IHRyaWdnZXJzIGxvY2tkZXAgd2Fybmlu
Z3MsIHNlZSBiZWxvdy4NCj4gDQo+IEl0IGlzIGdvb2QgZXhhbXBsZSB3aHkgYXZvaWQgYW55IGhp
ZGRlbiBjaGFuZ2VzIHdoZW4gc2h1ZmZsaW5nDQo+IGNvZGUuIFRoZSBjaGFuZ2VzIGluIHRoZSBj
b2RlIHNob3VsZCBiZSBkb25lIGluIGEgcHJlcGFyYXRvcnkNCj4gcGF0Y2ggb3Igbm90IGF0IGFs
bC4NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgZXZlbiB3b3JzZSBiZWNhdXNlIHRoZXNlIGNoYW5nZXMg
d2VyZSBub3QNCj4gbWVudGlvbmVkIGluIHRoZSBjb21taXQgbWVzc2FnZS4gSXQgc2hvdWxkIGRl
c2NyaWJlIHdoYXQNCj4gaXMgZG9uZSBhbmQgd2h5Lg0KPiANCj4gSSB3b25kZXIgaG93IG1hbnkg
b3RoZXIgY2hhbmdlcyBhcmUgaGlkZGVuIGluIHRoaXMgcGF0Y2hzZXQNCj4gYW5kIGlmIGFueW9u
ZSByZWFsbHkgY2hlY2tlZCB0aGVtLg0KDQpUaGF0J3MgcHJvYmFibHkgbXkgZmF1bHQsIHdoZW4g
SSByZXZpZXdlZCB2ZXJzaW9uIHY1IG9mIHRoZSBzZXJpZXMgSSANCm1lbnRpb25uZWQgYWxsIGNo
ZWNrcGF0Y2ggYW5kIHNwYXJzZSByZXBvcnRzIGFza2luZyBBYXJvbiB0byBtYWtlIGhpcyANCnNl
cmllcyBleGVtcHQgb2Ygc3VjaCB3YXJuaW5ncy4gTW9zdCB3YXJuaW5ncyB3aGVyZSByZWxhdGVk
IHRvIHN0eWxlIA0KKHBhcmVudGhlc2lzIGFsaWdubWVudCwgYmxhbmsgbGluZXMsIHNwYWNlcywg
ZXRjIC4uLikgb3IgZXJyb25lb3VzIA0KY2FzdGluZyBldGMuLi4uDQoNCkJ1dCBmb3IgdGhhdCBw
YXJ0aWN1bGFyIHBhdGNoIHdlIGhhZDoNCg0Ka2VybmVsL21vZHVsZS9rYWxsc3ltcy5jOjE3NDoy
Mzogd2FybmluZzogaW5jb3JyZWN0IHR5cGUgaW4gYXNzaWdubWVudCANCihkaWZmZXJlbnQgYWRk
cmVzcyBzcGFjZXMpDQprZXJuZWwvbW9kdWxlL2thbGxzeW1zLmM6MTc0OjIzOiAgICBleHBlY3Rl
ZCBzdHJ1Y3QgbW9kX2thbGxzeW1zIA0KW25vZGVyZWZdIF9fcmN1ICprYWxsc3ltcw0Ka2VybmVs
L21vZHVsZS9rYWxsc3ltcy5jOjE3NDoyMzogICAgZ290IHZvaWQgKg0Ka2VybmVsL21vZHVsZS9r
YWxsc3ltcy5jOjE3NjoxMjogd2FybmluZzogZGVyZWZlcmVuY2Ugb2Ygbm9kZXJlZiBleHByZXNz
aW9uDQprZXJuZWwvbW9kdWxlL2thbGxzeW1zLmM6MTc3OjEyOiB3YXJuaW5nOiBkZXJlZmVyZW5j
ZSBvZiBub2RlcmVmIGV4cHJlc3Npb24NCmtlcm5lbC9tb2R1bGUva2FsbHN5bXMuYzoxNzk6MTI6
IHdhcm5pbmc6IGRlcmVmZXJlbmNlIG9mIG5vZGVyZWYgZXhwcmVzc2lvbg0Ka2VybmVsL21vZHVs
ZS9rYWxsc3ltcy5jOjE4MDoxMjogd2FybmluZzogZGVyZWZlcmVuY2Ugb2Ygbm9kZXJlZiBleHBy
ZXNzaW9uDQprZXJuZWwvbW9kdWxlL2thbGxzeW1zLmM6MTg5OjE4OiB3YXJuaW5nOiBkZXJlZmVy
ZW5jZSBvZiBub2RlcmVmIGV4cHJlc3Npb24NCmtlcm5lbC9tb2R1bGUva2FsbHN5bXMuYzoxOTA6
MzU6IHdhcm5pbmc6IGRlcmVmZXJlbmNlIG9mIG5vZGVyZWYgZXhwcmVzc2lvbg0Ka2VybmVsL21v
ZHVsZS9rYWxsc3ltcy5jOjE5MToyMDogd2FybmluZzogZGVyZWZlcmVuY2Ugb2Ygbm9kZXJlZiBl
eHByZXNzaW9uDQprZXJuZWwvbW9kdWxlL2thbGxzeW1zLmM6MTk2OjMyOiB3YXJuaW5nOiBkZXJl
ZmVyZW5jZSBvZiBub2RlcmVmIGV4cHJlc3Npb24NCmtlcm5lbC9tb2R1bGUva2FsbHN5bXMuYzox
OTk6NDU6IHdhcm5pbmc6IGRlcmVmZXJlbmNlIG9mIG5vZGVyZWYgZXhwcmVzc2lvbg0KDQpBYXJv
biB1c2VkIHJjdV9kZXJlZmVyZW5jZV9zY2hlZCgpIGluIG9yZGVyIHRvIGZpeCB0aGF0Lg0KDQpI
b3cgc2hvdWxkIHRoaXMgYmUgZml4ZWQgaWYgdXNpbmcgcmN1X2RlcmVmZXJlbmNlX3NjaGVkKCkg
aXMgbm90IGNvcnJlY3QgPw0KDQpUaGFua3MNCkNocmlzdG9waGUNCg==
