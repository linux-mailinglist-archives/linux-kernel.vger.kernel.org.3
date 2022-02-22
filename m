Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9968F4BF978
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiBVNdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiBVNdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:33:03 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90071.outbound.protection.outlook.com [40.107.9.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37BE3123E;
        Tue, 22 Feb 2022 05:32:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oti5OH0eNzI6QIhQfaDbq9HFYrvdmw6NtEYthc2he1EXn2IXUVFVd+odv89xNOzM0ISoxPcHiFlVNgqKrOZAoWNqnItuGRkm057jF/A00spreFo7AeD0YY18WLhGcEXcsRkPaZGm9XxGYqgqDwvQMRVu2V+SbMIxm7kUnU8NPs0kjkNH8cANZsSLyoRMOHoWFn4PTFIIYBQhFBU9VTt8lkcwiwYStuKu6E/FpROC8hZ/Kavky6aiegdLtVM0H97NrpBvEyI4E8UafqMGwuVI3HelOhVQfiYvjptiH1jwkKAPmJ7S/j4cYbQ61jEWPvwTHuqo598JSjWRza9Hpzg1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5l+C4J1YD1FryEuua9HspDnwhpt9VMr17ITOIT1aCs=;
 b=X5TAQbhLhzXevsn6Ozp4qex6EmJovkGJTt9pT/6uIelU4maG4KWhgfqrusc1bf+l6GhsUL4jz+qIGwq7hPxQ0GDkp/e45ydvXephTxRv7SGITr5koLiF3TRppJkbvvRtpAa4vsEcvdMsKf0JIqisVCeTTtf51YrEX7BDva7mtvs6IAI6SeThD53ux6lxwRHwlnvTvXywrmSrw7pdjteoAidwSikNSehcM9ZmDbJJKD8H8tvrQR66uO/DxHmoEDDLDaLNfDMW77iYvTelrnHzRCO+5nbM8WMkSvEtdJmGBksFaffGyXofFb/kmLOme9A3ismFWLgAguMd3m1qjFBZ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR2P264MB0466.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 13:32:35 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%5]) with mapi id 15.20.5017.021; Tue, 22 Feb 2022
 13:32:35 +0000
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
Subject: Re: [PATCH v7 05/13] module: Move latched RB-tree support to a
 separate file
Thread-Topic: [PATCH v7 05/13] module: Move latched RB-tree support to a
 separate file
Thread-Index: AQHYJ+1rBFuVz8Qcf0aIdvhgWlVb0ayfkXEA
Date:   Tue, 22 Feb 2022 13:32:35 +0000
Message-ID: <8ed19f41-625a-154f-096c-ae7ea19a9649@csgroup.eu>
References: <20220222130911.1348513-1-atomlin@redhat.com>
 <20220222130911.1348513-6-atomlin@redhat.com>
In-Reply-To: <20220222130911.1348513-6-atomlin@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d42ae3e-932a-41cf-ca43-08d9f607c960
x-ms-traffictypediagnostic: MR2P264MB0466:EE_
x-microsoft-antispam-prvs: <MR2P264MB046608AC556C84E9950F3840ED3B9@MR2P264MB0466.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YhUDDh+Il3FQp+wWOw+fO6pvtPAQux5+sY3yvWIjWULvJmkc1uinwAMYeYLq1X0+id15krwfXolSQqSi9bcT0lD+0/zNqh8SgGujwox1FtNFXznnsOqsIKU9axQOs5If6cmmMHUOi91pTKV0slabaWCfSG2D6M5ixn11HMFxhgMy0LGfRbyBJhP6VZHnigpNurY7o/Hl3PGxbCuSmI5g67hiX9qk5DClBcGsltrVcBDCUiE0bTO9kMxKADErlL2RzmFAWbvTFPyCLtUBC/kumm6sy5C6G7ER8mkaUX4py/TmJWMmCjHjHz67W+6MZDQBU/o5Phh0P1i4y9jnHQQ+rfPW+INn48TodkVOsXfnAD2yE7Bt4KWSmrfKDOEAHNBBxkkxyuDojsD9oKQUAdm2Pf60CcID3wBFlDUOrIHYUu9MRjzqHgr18islVGcMMBxTJ/XGKgoRj6wbIwNx3/1brwafNoGisA5I1kTzen4sfZNZMDcIL7TOM4jDib/0wLMVn0QJq+lFowO/+WaWuJ6w7dCJrrNhmaCxzKzYivi8TsIB2y+Tc1p/x00vO/YkfdJ2L/HFpSFCFf/xrRzojAQqyG94uJnl88E1b0w6BXcIl5MQNS0uT6HyGjnIIBr4wa510gLVoza80V3xvPHddE15adrA+0wURH2iVdj6QbfrTJoChTE1lEmhwSIgE6MIPcqqpz43JBPQEMplZq3rw7ZRpN46qxecM5CfiL8d+7RcLfcYPjbqgaph+wz9Ql6T7BzyRCu2MVyyKejSx+6dM+Y2aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(86362001)(6506007)(186003)(26005)(38100700002)(2906002)(122000001)(38070700005)(31686004)(71200400001)(44832011)(8676002)(66446008)(91956017)(66476007)(6486002)(66946007)(66556008)(316002)(508600001)(54906003)(4326008)(64756008)(76116006)(31696002)(8936002)(6512007)(7416002)(2616005)(5660300002)(110136005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NldqanVLMUQrNXJ4MlVuazY5Sjk1dGFFZ3pydFYwRXJJa0pOUGtBZjdXZEdY?=
 =?utf-8?B?VWhzclpXb1lmUElqeCtWUERSWDlCUUZnU20wN0JiVjJGdnJrU1FKdHg1SFlo?=
 =?utf-8?B?cThyZ3NCVlY5emlHamd3TXJneXlZTGVVNkRzbFFabXp2bUY0NFJ2MHZSZito?=
 =?utf-8?B?emg2MVpYQnM1UWZTOFdtR1FaemVFbDhtL3J3OEhIRGU3RFIrcTY5T3NPL0J6?=
 =?utf-8?B?eklJamdSUlkxZSthRFMwaWZESXNjWW5FZHJ4bytUbGhxR0JhUnRnN1N1dHl2?=
 =?utf-8?B?eWtEZ0JoRjNlazNFNk1oNTZmY2ZRTzNyTjlHSDUyVkRidE1IZ3pVZzdtVEF5?=
 =?utf-8?B?Wkk0bHppUDdJejZ2a25OUWNrQmxTSUtnLzh2bmlSR1p3RE4yQ2ZJbjl5N3BW?=
 =?utf-8?B?eVBMWGw2K1duSEhwOEFYNVJ3MUw2M3Fvb0N3RGJJVy92ZW8xY2xINzVmNlNF?=
 =?utf-8?B?WDluRVEybHMxOVRvV3ZpMG5YK2lQNExEZGdSTFVJMUFKQmVjVHNIS3hkNUVC?=
 =?utf-8?B?SXNuZjJ0QXdvZ3hiQUtRbXBrTmxUNGNoMmNYV3ljNExwZElzVUFUZXJITzdp?=
 =?utf-8?B?VW0xOUZlUC9PUmJqWGF5U1R2S2VCL0xqdXhlcUZlRnFBdENIMEhaOFM4cnNk?=
 =?utf-8?B?UjBYaVJHZW5Hem45TkVxejJnaGNON0FSSU93MDBTZjZveVk4M3VPc1pJcVRK?=
 =?utf-8?B?ejdlTGVLRHVRUUZ0T3lYZDB0dG5KNUdjRHM4SzVEbzNONXdYNWFlN3ZpM2RS?=
 =?utf-8?B?eDlESmpnMGxRUmQzeERWK3FIOUxQWXdjSzNucDlrWHA1OTB5Y2tCbGp1ZGE4?=
 =?utf-8?B?ZVdQV1lmeVdnVHJaTlVrczNCRW42YWp3R1kwazhWakF2RjdCY0YzRWcvem0y?=
 =?utf-8?B?b0lYUzJaY3ovMmhvRzFIZ0c4V1BSSjMzQnFvdGJRdzFoY1hPSXpOY3d4elpF?=
 =?utf-8?B?WGxreER4U2xjS1dFTTVETTd2SzFPM2xPcW1Tbk80R0x2OG5SMktaNjdrUERC?=
 =?utf-8?B?dUF1dTZIUXB1dXl5UEk2MUdDTitOWktHOVpXQ2JVbEhOYWFaYjl2NU5ZbFRP?=
 =?utf-8?B?TU1aY0c2SDMzQTV3YWJ5NmQxUCtCdVhzTHRvVmJmTEtvQnoyYWRUUE0rMWNj?=
 =?utf-8?B?dDl2b3VGazNxNmk3aWxla1ZsYTlMK292MWIxbGlLZm02U3RUMmdPb0F5Vnkz?=
 =?utf-8?B?OU1rUWFWbDBreUg1Y01XY0kwUmx2TVlRZkdtVkd5VzdsdUZEek1zTmM0Zmdw?=
 =?utf-8?B?OHZzTWRLcGJ1QXRXSCtMUGpKL25QQkJHcTZnbUdsOXgxUDh2VTc1UnQ1bEU5?=
 =?utf-8?B?ZWpHcE5OYVdKc2RNM3YzSUpic0U4L2FMRGpSakFqWGQ5aU5qNzlkMGdHaThG?=
 =?utf-8?B?TWpnS21SM3lqZk5VYzJKQkVRVzByTDVaVGJSUHNUUkVlMmI5cHVNZFQxdVVz?=
 =?utf-8?B?dFFrOVZGQTBlUTRjSEw4cEczVE4vODFXY0dxY1FnMmRhTndXWFJIUlA3bEtP?=
 =?utf-8?B?ZzRtQmNFcTBvdWRPdU8yOWEzRlJXZlBnelUxSXZCeTFza3ExOGxkcjFlSmFP?=
 =?utf-8?B?Q0phWUJyLzkzZ3hndmRuTlJYZ0taUDBha0ZIT2UrblduK3hlL0xnUW9RT3BL?=
 =?utf-8?B?SThiNE9zZE9CckNzQ0tZUDlPeHJMZVN2QTM4RHk4Y3dvTzVUM1RoYk5LdHl2?=
 =?utf-8?B?RTRPRHBLNWNlMTFEeVRNaWJpcUYwZVdRZVFBZW1aMUN4WUlPQmV6OGNZSkV3?=
 =?utf-8?B?ZVVuQmVaL0Y3cnZrT0txSHlKUUo5R2hZZi9RaEgxUFo1WTFlNTRlSDdGMGxF?=
 =?utf-8?B?WlZFUjk0ZVNETTB6dlkxUkljdGNqdUk1d2ZiY3NzcWFHWUtrVDJ2RGYzZWdl?=
 =?utf-8?B?OU95U2RnMzd2WHNFU1hqQjNyUFZjU0hNOGlSMWp6MjVPUW5MUGZYdmJDUCsw?=
 =?utf-8?B?cEFxeVIxSkRISW9hSDhrNUFGWHdReHJPb1huN3cyUW0xemNzN1dJajhZZEpO?=
 =?utf-8?B?M3lDWFl6NUpUK1BHZUgvUE0rbW5rcVQ3ZXUwaFN0TzljalBGRFBRdkUwQm9n?=
 =?utf-8?B?U3JnbGk2c0puaEhpdnp0UmYrZFExSVJZUCtzM3hWSEMvb2RMZml6d1ZxWVRn?=
 =?utf-8?B?UWpCZXVLa0wyOEV2WkN4SnVpYmhJcTRSSktxWk1sY0gweklHNXJLVDIrMXJP?=
 =?utf-8?B?TnorVldRVm54M1R0NjdaZDFHOU90TWV0ZUt1Qnd1ODVBOTI3UzhnTUh0dlhh?=
 =?utf-8?Q?QOfjOt32L8Bi052Iz8YXCVj3UIuEDl1JmI/balKwaQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <231FCEE3CA02B04B8A8FCA5389912A7D@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d42ae3e-932a-41cf-ca43-08d9f607c960
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 13:32:35.2778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PiFRpmk1+pAF+nJ24OHF7wtA7PbPcq6O31JYMEotv/Z8yio58KVcxs1kE/E/6bPbSmWWy3Tae5XTM8fDbB79+/DIsf2SBGUmtyVv39Jkaso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR2P264MB0466
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIyLzAyLzIwMjIgw6AgMTQ6MDksIEFhcm9uIFRvbWxpbiBhIMOpY3JpdMKgOg0KPiBO
byBmdW5jdGlvbmFsIGNoYW5nZS4NCj4gDQo+IFRoaXMgcGF0Y2ggbWlncmF0ZXMgbW9kdWxlIGxh
dGNoZWQgUkItdHJlZSBzdXBwb3J0DQo+IChlLmcuIHNlZSBfX21vZHVsZV9hZGRyZXNzKCkpIGZy
b20gY29yZSBtb2R1bGUgY29kZQ0KPiBpbnRvIGtlcm5lbC9tb2R1bGUvdHJlZV9sb29rdXAuYy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFhcm9uIFRvbWxpbiA8YXRvbWxpbkByZWRoYXQuY29tPg0K
PiAtLS0NCj4gICBrZXJuZWwvbW9kdWxlL01ha2VmaWxlICAgICAgfCAgIDMgKw0KPiAgIGtlcm5l
bC9tb2R1bGUvaW50ZXJuYWwuaCAgICB8ICAzMyArKysrKysrKysNCj4gICBrZXJuZWwvbW9kdWxl
L21haW4uYyAgICAgICAgfCAxMzAgKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ICAga2VybmVsL21vZHVsZS90cmVlX2xvb2t1cC5jIHwgMTA5ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTQ5IGluc2VydGlvbnMoKyksIDEy
NiBkZWxldGlvbnMoLSkNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQga2VybmVsL21vZHVsZS90cmVl
X2xvb2t1cC5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL21vZHVsZS9NYWtlZmlsZSBiL2tl
cm5lbC9tb2R1bGUvTWFrZWZpbGUNCj4gaW5kZXggZWQzYWFjYjA0ZjE3Li5lODQxMzk3NWJmMWQg
MTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9tb2R1bGUvTWFrZWZpbGUNCj4gKysrIGIva2VybmVsL21v
ZHVsZS9NYWtlZmlsZQ0KPiBAQCAtMTEsMyArMTEsNiBAQCBvYmoteSArPSBtYWluLm8NCj4gICBv
YmotJChDT05GSUdfTU9EVUxFX0RFQ09NUFJFU1MpICs9IGRlY29tcHJlc3Mubw0KPiAgIG9iai0k
KENPTkZJR19NT0RVTEVfU0lHKSArPSBzaWduaW5nLm8NCj4gICBvYmotJChDT05GSUdfTElWRVBB
VENIKSArPSBsaXZlcGF0Y2gubw0KPiAraWZkZWYgQ09ORklHX01PRFVMRVMNCg0KVGhpcyBpZmRl
ZiBpcyBub3QgbmVlZGVkIGFueW1vcmUuDQoNCj4gK29iai0kKENPTkZJR19NT0RVTEVTX1RSRUVf
TE9PS1VQKSArPSB0cmVlX2xvb2t1cC5vDQo+ICtlbmRpZg0KDQoNCkNocmlzdG9waGU=
