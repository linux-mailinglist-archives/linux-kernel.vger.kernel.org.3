Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB114C4B53
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242276AbiBYQuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiBYQuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:50:10 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120072.outbound.protection.outlook.com [40.107.12.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A05B1D6CB0;
        Fri, 25 Feb 2022 08:49:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU70jqg7JV5VOmgLR1Ars5NL6e0kmMojBEPZh46X/DoDG7Ht68TDAVdcxec+f2eoL+zNmvNs9dJfcT/DXocNloGAVilsWkyQjjwZqlru+2nMYF+rMa+RNF+e69CFcACqw/n83iWXbQSrmqA3CUYucrK7AAwD0YWX1hwuKM4aIDYpfL4CW0WS0F3cwJSYjUCi7SGRB5hVZPK0+TLMK+n6Qgt6p5O60CdiLTQrsUCx5jBnboXwfxK0nfcRIZO1jupMvr3x/Fy7Nj643xptKOQsyc6D66hb5XGz/BKMPuAkymFfqVPKbsT8IT6RE8P7Hrd2kFnAs6DZNxXtXy27z7VkKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhtMVeB1sY9O5S2eiHMe8qZoMD/okIZ9OgjfF7zEtZ4=;
 b=i1o4WOx5jc3XS75e21x6hc+kdyx2QjTwL/nQJAb1xMcLTmFA06xdl0cmvZU8y4H2+S8TD1cMF0ED2VUTEs2TV/jcStzt7YfbtAB+TsaoVwidtQW7WZGMQm4J4NosuSYOaI2SWrDEi4IAXQEeuTJwr/eiPqykCjmKcNF0xYiB9464T96npcANMFjSQ57jO+A1wPZavjdudISndXij9uuyTZfNgspADAKcWG8p/icRJvyMuuVtd5yMtoSBVvkVMv72rZyPWuhRpQNJabpIkFR7cJRV1vfXUr62/UG4Iek1iljc4XPREQDLjhizg3T7d9yEYnU7fHJAi4Jf0E62h5f/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3233.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 16:49:31 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%5]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 16:49:31 +0000
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
Subject: Re: [PATCH v8 04/13] module: Move livepatch support to a separate
 file
Thread-Topic: [PATCH v8 04/13] module: Move livepatch support to a separate
 file
Thread-Index: AQHYJ/ZUpQQJAACNXky5zyXRhDIam6ykBcOAgAB5oAA=
Date:   Fri, 25 Feb 2022 16:49:31 +0000
Message-ID: <fb1bb248-bd3f-0990-cdfd-d186b7579411@csgroup.eu>
References: <20220222141303.1392190-1-atomlin@redhat.com>
 <20220222141303.1392190-5-atomlin@redhat.com> <Yhiik2ledqAfGuN2@alley>
In-Reply-To: <Yhiik2ledqAfGuN2@alley>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0dcf39b7-3e3c-43c4-ca5c-08d9f87ecb6c
x-ms-traffictypediagnostic: MR1P264MB3233:EE_
x-microsoft-antispam-prvs: <MR1P264MB323369CFCD1984884F0F217EED3E9@MR1P264MB3233.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gza/Jpf+iLdXMyRObSicqMriM3lpB0ZqyZUuEWtCwRB7PBw+5sTnKycuEgt1xtbeAN8g3w49hsp4iLOVNLd5mPXgHfAraLzeejGx2tg0Lu5P1K7F7a6sVY/DNq/tL9gi6C+CM++lxs3RVEVx5r7JwlJCKl//vd7ZpWuwptyZkwoM8jt7nM9/WruWM+02IU1aEKYwKr4zKyEvGJtSlkOyIkZuvUZTubSetZx0+2fVGneVAAQvU4443pY5cGeEUdI1dEOksy0vw7sMNClob9fkA4hgifLJ+LIYOUBMKELpQbPYEUrdkqeRDVihkBpuHluNG2xuZ/c/WiYIYKlCWFsYl8UA+YnSFnCIzpB+6yNJLl9ac1VWVnEDI9Up2le5xGS1YtOgO8GdC6OJzRKWGzo4CNlZyj36Jhd5fH8ixFf1Y2nb7FGk7egg00yRxk1rdY1BjczNQXfBCLxqxdcU43jh+jWrYoDEtNAJWJCSpokvKjzpa3nYe5iELsbOyBj4xhK5UI4LhQ+aE9BBlbSc56Ok0arhmbyREC/L5f69rtahnPrOEe+sRW6Y9G2ChU+1hv9EHEUKIPiFSNwA+uG6HM2OWyMvlSem+HQMqj79N9W1JXd2RtNcA/5gZ9zFozGFGkRwcEdbSziUzcqp5B6933DAmAVrQ9ZL5pJlBK3+bZ2Z9TVnyKid6stR/mhJh+h0die6QCuWOAGShq7dE1DqpGYPDeJg1Mx+Dv3BJdPVD1aU0J+3Yc+50eUYsOXV6dab40LfAyJIhLaBHJj88YUCjLk5Cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(91956017)(71200400001)(66946007)(76116006)(31686004)(66446008)(66476007)(64756008)(8676002)(66556008)(4326008)(110136005)(54906003)(7416002)(36756003)(5660300002)(316002)(6486002)(6506007)(6512007)(508600001)(186003)(26005)(2616005)(31696002)(86362001)(2906002)(44832011)(83380400001)(38100700002)(66574015)(122000001)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjhTK21lNDVMZEd1M1JYWWNnZGYyVlNKd2tjR3ZWNkY3ak12MGNvSE5ZVGl5?=
 =?utf-8?B?WGszSnRGaVBKWCtUd01lQTl2OS9mdHRjRGpiRjZiZzF5VkZ3SHFIbzJhRG1Z?=
 =?utf-8?B?dXVVMDJlVTNsNzk3bEsyQUxlWG5mcVBtOGxGY2dLS3VTRlVTbDlvSnZrc2Vm?=
 =?utf-8?B?Ny8yMlMwWE5tYVBMY1FSdlB6ckZpUFFGTkFmaERYSkI2UVlFSXljN3JOZ2tM?=
 =?utf-8?B?VEdTRmhPZFYzMVAvQUJrZjBVNXVnQm95TndhRHdmSzV4VE5SUEtMcm9LOWth?=
 =?utf-8?B?U3phVmYvNm9PbmNLdzJwZkxEbmhsVk5rdy93WXVCTVVTU2JGUjJDNVp4eG44?=
 =?utf-8?B?K1BRWlJ4TnlCWWNibUJ2czc3d1V0T2ppNk1SSGdPUnhOZnBkcmp0RTRqWmxX?=
 =?utf-8?B?YkkwdWM1ckRJc1pXSU1sZDdiNlpUc2hCTlNRcHQzQm50TFZsOVpDMGtMMk9m?=
 =?utf-8?B?Y0FuUG1JSkZ0Q2pBd1krT3AwcWJ3OTZZTUFQRkJxci9EZ0ZxUHRtcjNEcnF3?=
 =?utf-8?B?a3pBSUh1dHFRZ2xUTHB3c0VUZkR3YWVsL3M2QlJsOWlOYmdyYUhVOTRic01q?=
 =?utf-8?B?ZzVJZGtkY05KeDY2NmdzK1g1U2lNaW1PUUtPL3hRd2lLNVpNQkpENGx0UnlN?=
 =?utf-8?B?RENoSUtMaFlHZmZ6dSs1c3BvOTlOc3V4WTU1SlhCK0k0bHVFSi9VaHdMZi9K?=
 =?utf-8?B?anByTTFuNnVOb2VPNVU3eFdocStVSFFkQ0IyWlRrQzhISkVvai9ETFQyVmdG?=
 =?utf-8?B?R1NXZVFFK0lvSldaeWF6YXVCSGI4cW44S0Q5d2VEOTI2ZWpidUc2Q21xa3hD?=
 =?utf-8?B?cy9EUzFEQnRMZXNkYjVSNk1SVWJjQjk1Tnl2SFF3UVdKbWhWYXhvTjZIQit4?=
 =?utf-8?B?bVFOcFFRdFRuUHpxUzJVUEFpTEVESDNBYjlkYXhLdXAzNHk4TzZnM3IyUnFP?=
 =?utf-8?B?bzk0RnNtQVRmRkpjT3hMNk1aeUdJWTIvYjV6YVBYTXYyUWxVZVJ0bVpSeUlk?=
 =?utf-8?B?RzhkRUZORXhaUERKSUJlaXc2cVk5WU1mcytkTEpRakFrdGhWQU5nY2pJVGI0?=
 =?utf-8?B?NXQ0cEYxMHRzS2JkTzNQKzYvMmtpVEtlR09wQ2JRTWtMZEg1QzgrbWRMOEFs?=
 =?utf-8?B?aFpXb1ZDRzBiSXo0YzUyTGFhRzVYWEZiNmg5NCtmWm5PaG0zdFgwbm8vaVIw?=
 =?utf-8?B?dHRnYitGdDgzWWppTWFzcFZqeTllWlVXMHYvRkw1MmMzY3JXVm91eHJMbmRt?=
 =?utf-8?B?M0R6YW5CUmdBanhyRFV2M1pXdGlIekFuVk9rSHBBOUJnVVlFemdtNGFzMDlz?=
 =?utf-8?B?ZVFLdnlxYkNwSFVEaUtBNDVaeWFSY0V3TkhCcGJiZVh6eFh6T2NrNHlQblZm?=
 =?utf-8?B?WElHL3hhTGdiVEtiMm5jRDNPbWNuV1ZldXhGcUN4MklWYXlsSFFhWk9jZzJK?=
 =?utf-8?B?VlE4YlRIc1hSRHhETWU0eStBNDIwZldpclF0TnJNT2J5bTZDbUtkQkp0ZER5?=
 =?utf-8?B?VXVqaW94TlpicEdSVHpVNXRhVFhZVTFBa2NBaURGWFg4VU43M3BDSTR2SWVO?=
 =?utf-8?B?WEVRMTZWd20yR2pwTEdLNktlOCs0eWZtYWhIYm5uYmNwMEh4KzNRRUR1ZlZG?=
 =?utf-8?B?WHQwOUtWa0M0ZzhQOFNBZlY2S0U5NENJRjRuRzFpdXVUUmhCLytkL3BvLzF0?=
 =?utf-8?B?TVdzUTEwTjZZU0lWZmlIUi9DVjZYZjlkcC90KytKTDZxTW9FN3g4aTNSRGo2?=
 =?utf-8?B?NWRNUkVkakxPNEc2SFVFLzAySnc1eTJXNHBlT0hyTUpxcHQ2ZTZZUnBWYmc1?=
 =?utf-8?B?eFJmY0drd2VjVlgzOGxiMHlqTmdvYmhDaFNlSnJLc3k4bDlFUUhjTHlxQ204?=
 =?utf-8?B?bmwyL0FES2tFc0U4cE91cnQ3MEVGbHdNVGhtelovTlFaTnBSelFvR2s0cThz?=
 =?utf-8?B?YThSaFpJaVF4aVJENkNHTDdWcmFiOEcvVEMrVjZwM2tMREtyN0tkOWFjNTJw?=
 =?utf-8?B?UlkvaU9YMENncEpWVUpGZEkvTG5PWGFSd1g1N2Urb3VQRG5yeEpmenkxL1dk?=
 =?utf-8?B?L3VIUDdMbHVCWW5DM295ajIxeHNIaGJpZlU1ZjA4bjFoT2paVnJqN3hROXhC?=
 =?utf-8?B?alBtbVFoTzVvVFZkeEp5MXpYNDFGNERHOUlFU3BQT3hCNzd2SjAwaHR3bEFr?=
 =?utf-8?B?a1B0dDdIRzUxTmZScTFUa0tQZ016SnRVRjA1MkJaZDg3M0ZGRDVjbUs3dnNs?=
 =?utf-8?Q?sOwY9l7lozdl4rfsmkSwXrN7ue8cwGGFkJAZu0ADO0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <604990BD52551945AE3E0DB41066CC7C@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcf39b7-3e3c-43c4-ca5c-08d9f87ecb6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 16:49:31.1327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: foQGylXORKTnQBFmQFCY68osHxgjOC4lo8yTsdl58M0islZVBtVML4pM6vZAaRfdhsMRtVXHilMcRQSVzA6Sj4TqdrAoxhJ3XS824THWDs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3233
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI1LzAyLzIwMjIgw6AgMTA6MzQsIFBldHIgTWxhZGVrIGEgw6ljcml0wqA6DQo+IE9u
IFR1ZSAyMDIyLTAyLTIyIDE0OjEyOjU0LCBBYXJvbiBUb21saW4gd3JvdGU6DQo+PiBObyBmdW5j
dGlvbmFsIGNoYW5nZS4NCj4+DQo+PiBUaGlzIHBhdGNoIG1pZ3JhdGVzIGxpdmVwYXRjaCBzdXBw
b3J0IChpLmUuIHVzZWQgZHVyaW5nIG1vZHVsZQ0KPj4gYWRkL29yIGxvYWQgYW5kIHJlbW92ZS9v
ciBkZWxldGlvbikgZnJvbSBjb3JlIG1vZHVsZSBjb2RlIGludG8NCj4+IGtlcm5lbC9tb2R1bGUv
bGl2ZXBhdGNoLmMuIEF0IHRoZSBtb21lbnQgaXQgY29udGFpbnMgY29kZSB0bw0KPj4gcGVyc2lz
dCBFbGYgaW5mb3JtYXRpb24gYWJvdXQgYSBnaXZlbiBsaXZlcGF0Y2ggbW9kdWxlLCBvbmx5Lg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFhcm9uIFRvbWxpbiA8YXRvbWxpbkByZWRoYXQuY29tPg0K
PiANCj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvbW9kdWxlL2xpdmVwYXRjaC5jIGIva2VybmVsL21v
ZHVsZS9saXZlcGF0Y2guYw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAw
MDAwMDAwMC4uNDg2ZDRmZjkyNzE5DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9rZXJuZWwv
bW9kdWxlL2xpdmVwYXRjaC5jDQo+PiBAQCAtMCwwICsxLDc0IEBADQo+PiArICogUGVyc2lzdCBF
bGYgaW5mb3JtYXRpb24gYWJvdXQgYSBtb2R1bGUuIENvcHkgdGhlIEVsZiBoZWFkZXIsDQo+PiAr
ICogc2VjdGlvbiBoZWFkZXIgdGFibGUsIHNlY3Rpb24gc3RyaW5nIHRhYmxlLCBhbmQgc3ltdGFi
IHNlY3Rpb24NCj4+ICsgKiBpbmRleCBmcm9tIGluZm8gdG8gbW9kLT5rbHBfaW5mby4NCj4+ICsg
Ki8NCj4+ICtpbnQgY29weV9tb2R1bGVfZWxmKHN0cnVjdCBtb2R1bGUgKm1vZCwgc3RydWN0IGxv
YWRfaW5mbyAqaW5mbykNCj4+ICt7DQo+PiArCXVuc2lnbmVkIGludCBzaXplLCBzeW1uZHg7DQo+
PiArCWludCByZXQ7DQo+PiArDQo+PiArCXNpemUgPSBzaXplb2YoKm1vZC0+a2xwX2luZm8pOw0K
Pj4gKwltb2QtPmtscF9pbmZvID0ga21hbGxvYyhzaXplLCBHRlBfS0VSTkVMKTsNCj4+ICsJaWYg
KCFtb2QtPmtscF9pbmZvKQ0KPj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+PiArDQo+PiArCS8qIEVs
ZiBoZWFkZXIgKi8NCj4+ICsJc2l6ZSA9IHNpemVvZihtb2QtPmtscF9pbmZvLT5oZHIpOw0KPj4g
KwltZW1jcHkoJm1vZC0+a2xwX2luZm8tPmhkciwgaW5mby0+aGRyLCBzaXplKTsNCj4+ICsNCj4+
ICsJLyogRWxmIHNlY3Rpb24gaGVhZGVyIHRhYmxlICovDQo+PiArCXNpemUgPSBzaXplb2YoKmlu
Zm8tPnNlY2hkcnMpICogaW5mby0+aGRyLT5lX3NobnVtOw0KPj4gKwltb2QtPmtscF9pbmZvLT5z
ZWNoZHJzID0ga21lbWR1cChpbmZvLT5zZWNoZHJzLCBzaXplLCBHRlBfS0VSTkVMKTsNCj4+ICsJ
aWYgKCFtb2QtPmtscF9pbmZvLT5zZWNoZHJzKSB7DQo+PiArCQlyZXQgPSAtRU5PTUVNOw0KPj4g
KwkJZ290byBmcmVlX2luZm87DQo+PiArCX0NCj4+ICsNCj4+ICsJLyogRWxmIHNlY3Rpb24gbmFt
ZSBzdHJpbmcgdGFibGUgKi8NCj4+ICsJc2l6ZSA9IGluZm8tPnNlY2hkcnNbaW5mby0+aGRyLT5l
X3Noc3RybmR4XS5zaF9zaXplOw0KPj4gKwltb2QtPmtscF9pbmZvLT5zZWNzdHJpbmdzID0ga21l
bWR1cChpbmZvLT5zZWNzdHJpbmdzLCBzaXplLCBHRlBfS0VSTkVMKTsNCj4+ICsJaWYgKCFtb2Qt
PmtscF9pbmZvLT5zZWNzdHJpbmdzKSB7DQo+PiArCQlyZXQgPSAtRU5PTUVNOw0KPj4gKwkJZ290
byBmcmVlX3NlY2hkcnM7DQo+PiArCX0NCj4+ICsNCj4+ICsJLyogRWxmIHN5bWJvbCBzZWN0aW9u
IGluZGV4ICovDQo+PiArCXN5bW5keCA9IGluZm8tPmluZGV4LnN5bTsNCj4+ICsJbW9kLT5rbHBf
aW5mby0+c3ltbmR4ID0gc3ltbmR4Ow0KPj4gKw0KPj4gKwkvKg0KPj4gKwkgKiBGb3IgbGl2ZXBh
dGNoIG1vZHVsZXMsIGNvcmVfa2FsbHN5bXMuc3ltdGFiIGlzIGEgY29tcGxldGUNCj4+ICsJICog
Y29weSBvZiB0aGUgb3JpZ2luYWwgc3ltYm9sIHRhYmxlLiBBZGp1c3Qgc2hfYWRkciB0byBwb2lu
dA0KPj4gKwkgKiB0byBjb3JlX2thbGxzeW1zLnN5bXRhYiBzaW5jZSB0aGUgY29weSBvZiB0aGUg
c3ltdGFiIGluIG1vZHVsZQ0KPj4gKwkgKiBpbml0IG1lbW9yeSBpcyBmcmVlZCBhdCB0aGUgZW5k
IG9mIGRvX2luaXRfbW9kdWxlKCkuDQo+PiArCSAqLw0KPj4gKwltb2QtPmtscF9pbmZvLT5zZWNo
ZHJzW3N5bW5keF0uc2hfYWRkciA9ICh1bnNpZ25lZCBsb25nKW1vZC0+Y29yZV9rYWxsc3ltcy5z
eW10YWI7DQo+PiArDQo+PiArCXJldHVybiAwOw0KPiANCj4gVGhpcyBjb2RlIGluY2x1ZGUgc2V2
ZXJhbCBvdGhlciB3ZWxsIGhpZGRlbiBjaGFuZ2VzOg0KPiANCj4gLS0tIGRlbC5wCTIwMjItMDIt
MjQgMTY6NTU6MjYuNTcwMDU0OTIyICswMTAwDQo+ICsrKyBhZGQucAkyMDIyLTAyLTI0IDE2OjU2
OjA0Ljc2Njc4MTM5NCArMDEwMA0KPiBAQCAtMywxNCArMywxNCBAQA0KPiAgICAqIHNlY3Rpb24g
aGVhZGVyIHRhYmxlLCBzZWN0aW9uIHN0cmluZyB0YWJsZSwgYW5kIHN5bXRhYiBzZWN0aW9uDQo+
ICAgICogaW5kZXggZnJvbSBpbmZvIHRvIG1vZC0+a2xwX2luZm8uDQo+ICAgICovDQo+IC1zdGF0
aWMgaW50IGNvcHlfbW9kdWxlX2VsZihzdHJ1Y3QgbW9kdWxlICptb2QsIHN0cnVjdCBsb2FkX2lu
Zm8gKmluZm8pDQo+ICtpbnQgY29weV9tb2R1bGVfZWxmKHN0cnVjdCBtb2R1bGUgKm1vZCwgc3Ry
dWN0IGxvYWRfaW5mbyAqaW5mbykNCg0KVGhhdCdzIG5vdCBhIGhpZGRlbiBjaGFuZ2UuIFRoYXQn
cyBwYXJ0IG9mIHRoZSBtb3ZlLCB0aGF0J3MgcmVxdWlyZWQuDQoNCj4gICB7DQo+ICAgCXVuc2ln
bmVkIGludCBzaXplLCBzeW1uZHg7DQo+ICAgCWludCByZXQ7DQo+ICAgDQo+ICAgCXNpemUgPSBz
aXplb2YoKm1vZC0+a2xwX2luZm8pOw0KPiAgIAltb2QtPmtscF9pbmZvID0ga21hbGxvYyhzaXpl
LCBHRlBfS0VSTkVMKTsNCj4gLQlpZiAobW9kLT5rbHBfaW5mbyA9PSBOVUxMKQ0KPiArCWlmICgh
bW9kLT5rbHBfaW5mbykNCj4gICAJCXJldHVybiAtRU5PTUVNOw0KPiAgIA0KPiAgIAkvKiBFbGYg
aGVhZGVyICovDQo+IEBAIC0yMCw3ICsyMCw3IEBAIHN0YXRpYyBpbnQgY29weV9tb2R1bGVfZWxm
KHN0cnVjdCBtb2R1bGUNCj4gICAJLyogRWxmIHNlY3Rpb24gaGVhZGVyIHRhYmxlICovDQo+ICAg
CXNpemUgPSBzaXplb2YoKmluZm8tPnNlY2hkcnMpICogaW5mby0+aGRyLT5lX3NobnVtOw0KPiAg
IAltb2QtPmtscF9pbmZvLT5zZWNoZHJzID0ga21lbWR1cChpbmZvLT5zZWNoZHJzLCBzaXplLCBH
RlBfS0VSTkVMKTsNCj4gLQlpZiAobW9kLT5rbHBfaW5mby0+c2VjaGRycyA9PSBOVUxMKSB7DQo+
ICsJaWYgKCFtb2QtPmtscF9pbmZvLT5zZWNoZHJzKSB7DQo+ICAgCQlyZXQgPSAtRU5PTUVNOw0K
PiAgIAkJZ290byBmcmVlX2luZm87DQo+ICAgCX0NCj4gQEAgLTI4LDcgKzI4LDcgQEAgc3RhdGlj
IGludCBjb3B5X21vZHVsZV9lbGYoc3RydWN0IG1vZHVsZQ0KPiAgIAkvKiBFbGYgc2VjdGlvbiBu
YW1lIHN0cmluZyB0YWJsZSAqLw0KPiAgIAlzaXplID0gaW5mby0+c2VjaGRyc1tpbmZvLT5oZHIt
PmVfc2hzdHJuZHhdLnNoX3NpemU7DQo+ICAgCW1vZC0+a2xwX2luZm8tPnNlY3N0cmluZ3MgPSBr
bWVtZHVwKGluZm8tPnNlY3N0cmluZ3MsIHNpemUsIEdGUF9LRVJORUwpOw0KPiAtCWlmIChtb2Qt
PmtscF9pbmZvLT5zZWNzdHJpbmdzID09IE5VTEwpIHsNCj4gKwlpZiAoIW1vZC0+a2xwX2luZm8t
PnNlY3N0cmluZ3MpIHsNCj4gICAJCXJldCA9IC1FTk9NRU07DQo+ICAgCQlnb3RvIGZyZWVfc2Vj
aGRyczsNCj4gICAJfQ0KPiBAQCAtNDMsOCArNDMsNyBAQCBzdGF0aWMgaW50IGNvcHlfbW9kdWxl
X2VsZihzdHJ1Y3QgbW9kdWxlDQo+ICAgCSAqIHRvIGNvcmVfa2FsbHN5bXMuc3ltdGFiIHNpbmNl
IHRoZSBjb3B5IG9mIHRoZSBzeW10YWIgaW4gbW9kdWxlDQo+ICAgCSAqIGluaXQgbWVtb3J5IGlz
IGZyZWVkIGF0IHRoZSBlbmQgb2YgZG9faW5pdF9tb2R1bGUoKS4NCj4gICAJICovDQo+IC0JbW9k
LT5rbHBfaW5mby0+c2VjaGRyc1tzeW1uZHhdLnNoX2FkZHIgPSBcDQo+IC0JCSh1bnNpZ25lZCBs
b25nKSBtb2QtPmNvcmVfa2FsbHN5bXMuc3ltdGFiOw0KPiArCW1vZC0+a2xwX2luZm8tPnNlY2hk
cnNbc3ltbmR4XS5zaF9hZGRyID0gKHVuc2lnbmVkIGxvbmcpbW9kLT5jb3JlX2thbGxzeW1zLnN5
bXRhYjsNCj4gICANCj4gICAJcmV0dXJuIDA7DQo+IA0KPiANCj4gUGxlYXNlIGRvIG5vdCBkbyB0
aGVzZSBzbWFsbCBjb2Rpbmcgc3R5bGUgY2hhbmdlcy4gSXQgY29tcGxpY2F0ZXMgdGhlDQo+IHJl
dmlldyBhbmQgaW5jcmVhc2VzIHRoZSByaXNrIG9mIHJlZ3Jlc3Npb25zLiBEaWZmZXJlbnQgcGVv
cGxlDQo+IGhhdmUgZGlmZmVyZW50IHByZWZlcmVuY2VzLiBKdXN0IGltYWdpbmUgdGhhdCBldmVy
eSBoYWxmIGEgeWVhcg0KPiBzb21lb25lIHVwZGF0ZSBzdHlsZSBvZiBhIGNvZGUgYnkgaGlzIHBl
cnNvbmFsIHByZWZlcmVuY2VzLiBUaGUNCj4gcmVhbCBjaGFuZ2VzIHdpbGwgdGhlbiBnZXQgbG9z
dCBpbiBhIGxvdCBvZiBub2lzZS4NCg0KSSBkaXNhZ3JlZSBoZXJlLiBXZSBhcmUgbm90IHRhbGtp
bmcgYWJvdXQgcGVvcGxlJ3MgcHJlZmVyZW5jZSBoZXJlIGJ1dCANCmNvbXBsaWFuY2Ugd2l0aCBk
b2N1bWVudGVkIExpbnV4IGtlcm5lbCBDb2R5aW5nIFN0eWxlIGFuZCBoYW5kbGluZyBvZiANCm9m
ZmljaWFsIGNoZWNrcGF0Y2gucGwgc2NyaXB0IHJlcG9ydHMuDQoNCllvdSBhcmUgcmlnaHQgdGhh
dCByYW5kb21seSB1cGRhdGluZyB0aGUgc3R5bGUgZXZlcnkgaGFsZiBhIHllYXIgd291bGQgDQpi
ZSBhIG5pZ2h0bWFyZSBhbmQgd291bGQga2lsbCBibGFtYWJpbGl0eSBvZiBjaGFuZ2VzLg0KDQpI
b3dldmVyIHdoZW4gbW92aW5nIGJpZyBwZWFjZXMgb2YgY29kZSBsaWtlIHRoaXMsIGJsYW1hYmls
aXR5IGlzIGJyb2tlbiANCmFueXdheSBhbmQgdGhpcyBpcyBhIHZlcnkgZ29vZCBvcHBvcnR1bml0
eSB0byBpbmNyZWFzZSBjb21wbGlhbmNlIG9mIA0Ka2VybmVsIGNvZGUgdG8gaXRzIG93biBjb2R5
aW5nIHN0eWxlLiBCdXQgZG9pbmcgaXQgaW4gc2V2ZXJhbCBzdGVwcyANCmluY3JlYXNlcyBjb2Rl
IGNodXJuIGFuZCBoYXMgbm8gcmVhbCBhZGRlZCB2YWx1ZS4NCg0KPiANCj4gQ29kaW5nIHN0eWxl
IGNoYW5nZXMgbWlnaHQgYmUgYWNjZXB0YWJsZSBvbmx5IHdoZW4gdGhlIGNvZGUgaXMNCj4gcmV3
b3JrZWQgb3Igd2hlbiBpdCBzaWduaWZpY2FudGx5IGltcHJvdmVzIHJlYWRhYmlsaXR5Lg0KDQpX
aGVuIGNvZGUgaXMgbW92ZWQgYXJvdW5kIGl0IGlzIGFsc28gYSBnb29kIG9wcG9ydHVuaXR5Lg0K
DQo+IA0KPiANCj4gVGhhdCBzYWlkLiBJIHJldmlld2VkIGFuZCB0ZXN0ZWQgdGhpcyBwYXRjaCBh
bmQgZGlkIG5vdCBmaW5kIGFueQ0KPiBwcm9ibGVtLiBGZWVsIGZyZWUgdG8gdXNlOg0KPiANCj4g
UmV2aWV3ZWQtYnk6IFBldHIgTWxhZGVrIDxwbWxhZGVrQHN1c2UuY29tPg0KPiBUZXN0ZWQtYnk6
IFBldHIgTWxhZGVrIDxwbWxhZGVrQHN1c2UuY29tPg0KPiANCj4gUGxlYXNlLCB0YWtlIHRoZSBh
Ym92ZSBhcyBhbiBhZHZpY2UgZm9yIHlvdXIgZnV0dXJlIHdvcmsuDQo+IA0KDQpUaGFua3MNCkNo
cmlzdG9waGU=
