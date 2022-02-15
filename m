Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15794B667B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbiBOIs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:48:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbiBOIsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:48:25 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2044.outbound.protection.outlook.com [40.107.113.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF701133F5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:48:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZto2zmbw6hJ3rwLPL/zfYfrXUjQNYfV+I4hRCebOKsnkUwaJ/elWmtKt87Lax7UlEzetawtzACx85eJIKti7FFWiQOUK53W8eX51jU35j1+h4aytlM7bM3IOQjIimjsV29Tp3fmAJfY39NJzeZOz79dXE+A880uHrfp1D7F59YbY8vjsBGYPZHGlZ2+37IJJEgYg4QqJuIrxjWyj4R2Zx1ZbNdZEi+94JUnVSMfTaYaSu96uaraGEcw82n7GR76Qj+90+xJneWbJecdTMQT7An90p3hWMuF/Y28/OlkaC9sdzcRpEOYA62JAFrivk041sn81n75dLi5CE1IjbvNjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFXuo05ix6FXkz37LMx+KJrWDo08Y3wXQWOTGyZDMBo=;
 b=fjxn2WlL8F6N6SEEMA5VlSAOZgy7iZW9N7b3kzPLW4tismWCrWVC/IM/cL9opIo2A6w7/MSwQAxcx0fmQsVuZMb55uWDnqZRf90B8oFq8IMd8uuGBoo4sXGMCcrqRlOZWDC8jiHRtyCnhu38DzS60dx0/q+uupNQ22wT6DZkM70MDghFsvcI/OQJp1sdTM2fnAsR9ksv2iFAjbFAcvKQDBXV1v7f1A7XSuv4QL82pK3rFak12i0s0Kyi2h/I7Dt43NuW4zqRdXXNAqlNcm5fQOCLCT+PI6HYCrmASCq2vbFHN9i41LU/rk/X10iMsHw7KHgQtr/YrBDXXhz7j0VJWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFXuo05ix6FXkz37LMx+KJrWDo08Y3wXQWOTGyZDMBo=;
 b=W/03YaHyR27xvdOsyLSFDLcNihW8xhW5EeRfvjs61qbSmFKOzoxMhaI016H3UE9jDdJIZJ95n9/pQbcWShZEy5Vrz3pAdjkYcVfPaZtHo0HEQAR2Tw3N6/px64QYG5Idcs0q1a7jw/Y9OwbParkvf3Or6Rz5ATL9CPUCTlLDP0g=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB7214.jpnprd01.prod.outlook.com (2603:1096:604:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 08:48:14 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 08:48:14 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] mm/memory-failure.c: remove unneeded orig_head
Thread-Topic: [PATCH 4/8] mm/memory-failure.c: remove unneeded orig_head
Thread-Index: AQHYIhohyeb4fxHsiEao4j/TwNsxeKyUTVOA
Date:   Tue, 15 Feb 2022 08:48:14 +0000
Message-ID: <20220215084813.GA1971011@hori.linux.bs1.fc.nec.co.jp>
References: <20220210141733.1908-1-linmiaohe@huawei.com>
 <20220210141733.1908-5-linmiaohe@huawei.com> <20220214145019.GD2624914@u2004>
 <f19c8477-c352-c1e1-74a4-3298511f10cf@huawei.com>
In-Reply-To: <f19c8477-c352-c1e1-74a4-3298511f10cf@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3da24974-9e03-439a-e287-08d9f05fe750
x-ms-traffictypediagnostic: OS3PR01MB7214:EE_
x-microsoft-antispam-prvs: <OS3PR01MB7214B3123BE82DC1892035F5E7349@OS3PR01MB7214.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YFwErFpjTCQ0cfaX2yo2e3PaiEoLx/CvLIElR97zCPsevS0qp1XU57DFKVff65Wfm8GPsIzaJqxRXbmVXqtBPtOQj40uRS3dQFOXc9iliXDL3Qz/KgbSMlcRJxSMQ8ZWby3a0VakxAWdnduNlxKrOHLqu6aIfsxc8lPHxFoBCZaZH8SlSQixGLpzF6ZAKJB9t7mi7SIBpznpovegv99nWXlE51E6Po1vaHLelKOXZGwsZDmXb3Vtaxt1PPNg+ldqQ0Qku2phumsI1xFYgJSj1EzH5o6IAG9sVPmQ0Ru/uAB5CFE+WvIevEOABNtIIOGtPa+0IlpXw5XHYkP96TJumi3NAlWCv0TcOXFOn7rEnz+N6l0SFbhYKHooauapZc1JKdMIUxbvL4vTaAMBinRS2CKhvRmXMCPxDdUNnBSHMycUlxywRkLcknjvfZnrALGSesOTGiFw5gppzqp38jpW20JQCYvcfBIPazsRNPsQtmT06opAYUCtAuDSsfpUS9Bgt8Cg+4idCp5gdeiYbzJRQ/kePkkP68F+CqiOYyBH/uaUzHSxVwFVsDkzj/xP9Zzm51d2PUFmxUIT58U0HmNh+lGymMEgNCFOr2HsWV4YrQ9Qvd+xZAtF3UMr+vU4sPo/Tc2ljTsG+emBVbtM9fF5TFWguWJPIexdofKR6LNPbWV20AdkwnaN7K/TnxVQvF2CCF8+G+5I3NF8zrVCkYbpDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(4326008)(8676002)(86362001)(66556008)(76116006)(66946007)(64756008)(66476007)(26005)(38070700005)(1076003)(66446008)(186003)(8936002)(122000001)(6916009)(38100700002)(316002)(5660300002)(33656002)(2906002)(85182001)(6486002)(82960400001)(55236004)(83380400001)(9686003)(53546011)(508600001)(6506007)(71200400001)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2FZRS91Rk1pdE5jYU9xQ2RXQVZHcmRuWnd2cS8zTXA5OENpL25xNUsybE5r?=
 =?utf-8?B?YktkVWg0SlJKaENOWDN3TEQvWHY4a1g5ZU11L0s3SkpjN0hiL0NpRjVUdUI4?=
 =?utf-8?B?NXR5MlB6TC9hazl4MjJiQ0RoMXBwdDlYOEJGQ3FCNEpKZFBiM0RvTWNIYTM0?=
 =?utf-8?B?ejRKMVRIeHZUazVvaENCYXQ5QmpnTCtxdG0xWTJqS1dVWm45RkVNOVdXdFpE?=
 =?utf-8?B?OVQrZTJJQ0tGRjQ1aVpSbHYwclBBbWlVdmhPclFXTktRZks4V1FhSkc1UC9M?=
 =?utf-8?B?NmRRdVVyZWE1UnJ1aUZKOHJSb3Nuc0pTQmhheVQvSm5IMmZkVjhRYVU5d01x?=
 =?utf-8?B?L1lsOWdDcHhlN2ZOQTJFUmtTTkVEemlkSitEckRpYzlzM25XRWt4NldPbE5O?=
 =?utf-8?B?WFJuckZnVUMzMERZVlJxcStwTzVOa3U4OEs1eVRIQy9DTkNiRExUU3Q2d3gv?=
 =?utf-8?B?TzR4eERqRVdWQkVsQ0VzZVE2WUl2TERPWWV1aTFnMEwxTG9vVUJwd0NkYkYx?=
 =?utf-8?B?bG1hdkxyQWthMjhKNWNRNFMrL1dVc0lQM2F2UTZoK1JQT1c4WUFnTkx6MDlR?=
 =?utf-8?B?U0R3NEZaeTlWckRTZ2U3NmUrak1zUlNIOEZOenVTWVJldFNSN09ncVNBa2pE?=
 =?utf-8?B?RElqYnhIUU0wU3JQMzN3RUdiMFVVM2xhbkxSMTVTUThNdnp6bzBTeHkzczBw?=
 =?utf-8?B?Z0hVUzFiWExPbEI2S2JqTkdHZ1c3RnlPN2RSY0kvNm9iOHg1bXVDbXNBQXRZ?=
 =?utf-8?B?SFF0NW13WWZ3aWxXaUJPZ2pLLy9PUE54RUNCVldsYmlTaWxGRVRZbTJUMVl5?=
 =?utf-8?B?YkpZZnRId1ZUaWpkK1Jod0tidTZSemxRT0ptTXV4NllJOGcwQ1NWWFBUQUhu?=
 =?utf-8?B?V085dUp4ZzVkeVNNY0NXSTNnZllGZldGN3lvSnBDMEYvQlJ0L3VyNHNySUlZ?=
 =?utf-8?B?VmxURCtuRFpPaWRXSlFHNmxCV1I1RkhwVSszekgrYnNVTjJCNmU0QmlYQ2Z0?=
 =?utf-8?B?QlVJS0ZEWDN6TmN6c3MrTHNyQU5XdFVFRkVrZ3pGY3J1M2dRcG5KMkNPSDUv?=
 =?utf-8?B?a3JzMlRETnU2MzNFQ2FvRFZMR1R2UGJlbGg2ekxySDk3aXEyREJPRmwreU1r?=
 =?utf-8?B?NHpYQnI4cEVUK3p6RXhQS0h1VXRhemFtS3NXQmVsRzl3aDl0S1FqSGIrWUJF?=
 =?utf-8?B?YzN5UFhpNnJDbTJwK0FmaGFZSUNlUklSWjR1ek9xWFNoSG92aTdiSEhCS2Rt?=
 =?utf-8?B?cGNaMzZyUmRMbjd6MFpnQjlUZkhhYjRob2dHbkQ1UkhxWkJlc3kybWZCTXAz?=
 =?utf-8?B?cjU3VU5lVjlYUVJlTUwzWmZTcERzSXhqbDNzZXhpODBsS1VHeENJRENXMjdy?=
 =?utf-8?B?aDhDREtIZUxmOVRuMkYrQkE1QkdnR1VZYnAvODljaGJFVTNuWXI5eXdKZUlZ?=
 =?utf-8?B?WW9wTytGOXB2VXpLRndlTHE1WDhwYWk0UEtNd0hGdGNEUkUrMWszcmliL01C?=
 =?utf-8?B?d3VITW0yUnBuRzFpb1VqdkM3ZlJ1eUgraXd5MjFGNHhpLy9JMmRHUmtDN2VM?=
 =?utf-8?B?Y3o4L2YvSUdJNEhWbk5rWHVQUjlPVmhFRGM5djZRbFc2YktKbVN3cHdDTWJG?=
 =?utf-8?B?YWtsOW52RWIraWx5NkpTQ1cyVFJXR2N1dVMzY3BnNFYzZXpzZXpHdkxDU1Yy?=
 =?utf-8?B?WFM2Y2treGU0UTVwNldqTzVxNFdoeFFqcXdaM0pvbmwzRjBrQVVlaHZVK1RO?=
 =?utf-8?B?Q0dCTXh5OU1UUG5KeGFMV2IrSWFKL1VRL08xRjZkakg5T2hLcDlMKzdJYmc5?=
 =?utf-8?B?bStqRWpveTdxUDJIMmJGbTdPRy9Tb2MwS25CS1lkZEtuNm9jL2RncEhyT2pl?=
 =?utf-8?B?WmFjQ3BwY040UHc4RkZMbWZxc3l2aEJteXRJQXd4VlZHTHF6ZVplRkFNd2cy?=
 =?utf-8?B?eVo0dm51OGVQMklUWVB6cG9wSUZZNmNTT3lGcThPSGs4WkxaZUY1NWptVHVY?=
 =?utf-8?B?cTAyNm1LU09jd01URjV5TjVoeXlwdzlIeTZTQXlsdmJFV01zT3ZTWWYyemJx?=
 =?utf-8?B?WWlMS1dVamJZSkV2bmsyKzdsZjF2aEtQMW1FbTcvQ2kzcHRoeXhRNTlLVU1M?=
 =?utf-8?B?NDFqVGhxOXNybFRxaHA3Q1ltMjVaWTkraWpWOGNvSUlKdVNkeWRpakk1R3lm?=
 =?utf-8?Q?KPt1hpffMk4KrLY4h6x6S1Al2YW56j0/k9fpU014hdI6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41AE76457CFA014A99046B2AAE9B58D5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da24974-9e03-439a-e287-08d9f05fe750
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 08:48:14.2720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NxMO1i1HYoVd5FunrffAuf+2YtoL7zhp2qcdkmabuX2Qi9zaTc0C0PrGbV+cM5wxEepsnLj1elY2RIrPKFCU6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7214
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBGZWIgMTUsIDIwMjIgYXQgMTE6MTQ6MDdBTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi8yLzE0IDIyOjUwLCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gT24g
VGh1LCBGZWIgMTAsIDIwMjIgYXQgMTA6MTc6MjlQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90ZToN
Cj4gPj4gb3JpZ19oZWFkIGlzIHVzZWQgdG8gY2hlY2sgd2hldGhlciB0aGUgcGFnZSBoYXZlIGNo
YW5nZWQgY29tcG91bmQgcGFnZXMNCj4gPj4gZHVyaW5nIHRoZSBsb2NraW5nLiBCdXQgaXQncyBh
bHdheXMgZXF1YWwgdG8gaHBhZ2UuIFNvIHdlIGNhbiB1c2UgaHBhZ2UNCj4gPj4gZGlyZWN0bHkg
YW5kIHJlbW92ZSB0aGlzIHJlZHVuZGFudCBvbmUuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6
IE1pYW9oZSBMaW4gPGxpbm1pYW9oZUBodWF3ZWkuY29tPg0KPiA+PiAtLS0NCj4gPj4gIG1tL21l
bW9yeS1mYWlsdXJlLmMgfCA1ICsrLS0tDQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5
LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gPj4gaW5kZXggMmRkN2YzNWVlNjVh
Li40MzcwYzJmNDA3YzUgMTAwNjQ0DQo+ID4+IC0tLSBhL21tL21lbW9yeS1mYWlsdXJlLmMNCj4g
Pj4gKysrIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+PiBAQCAtMTY5MSw3ICsxNjkxLDYgQEAg
aW50IG1lbW9yeV9mYWlsdXJlKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3MpDQo+ID4+ICB7
DQo+ID4+ICAJc3RydWN0IHBhZ2UgKnA7DQo+ID4+ICAJc3RydWN0IHBhZ2UgKmhwYWdlOw0KPiA+
PiAtCXN0cnVjdCBwYWdlICpvcmlnX2hlYWQ7DQo+ID4+ICAJc3RydWN0IGRldl9wYWdlbWFwICpw
Z21hcDsNCj4gPj4gIAlpbnQgcmVzID0gMDsNCj4gPj4gIAl1bnNpZ25lZCBsb25nIHBhZ2VfZmxh
Z3M7DQo+ID4+IEBAIC0xNzM3LDcgKzE3MzYsNyBAQCBpbnQgbWVtb3J5X2ZhaWx1cmUodW5zaWdu
ZWQgbG9uZyBwZm4sIGludCBmbGFncykNCj4gPj4gIAkJZ290byB1bmxvY2tfbXV0ZXg7DQo+ID4+
ICAJfQ0KPiA+Pg0KPiA+PiAtCW9yaWdfaGVhZCA9IGhwYWdlID0gY29tcG91bmRfaGVhZChwKTsN
Cj4gPj4gKwlocGFnZSA9IGNvbXBvdW5kX2hlYWQocCk7DQo+ID4+ICAJbnVtX3BvaXNvbmVkX3Bh
Z2VzX2luYygpOw0KPiA+Pg0KPiA+PiAgCS8qDQo+ID4+IEBAIC0xODIxLDcgKzE4MjAsNyBAQCBp
bnQgbWVtb3J5X2ZhaWx1cmUodW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncykNCj4gPj4gIAkg
KiBUaGUgcGFnZSBjb3VsZCBoYXZlIGNoYW5nZWQgY29tcG91bmQgcGFnZXMgZHVyaW5nIHRoZSBs
b2NraW5nLg0KPiA+PiAgCSAqIElmIHRoaXMgaGFwcGVucyBqdXN0IGJhaWwgb3V0Lg0KPiA+PiAg
CSAqLw0KPiA+PiAtCWlmIChQYWdlQ29tcG91bmQocCkgJiYgY29tcG91bmRfaGVhZChwKSAhPSBv
cmlnX2hlYWQpIHsNCj4gPj4gKwlpZiAoUGFnZUNvbXBvdW5kKHApICYmIGNvbXBvdW5kX2hlYWQo
cCkgIT0gaHBhZ2UpIHsNCj4gPiANCj4gPiBJIHRoaW5rIHRoYXQgdGhpcyBpZi1jaGVjayB3YXMg
aW50ZW5kZWQgdG8gZGV0ZWN0IHRoZSBjYXNlIHRoYXQgcGFnZSBwDQo+ID4gYmVsb25ncyB0byBh
IHRocCB3aGVuIG1lbW9yeV9mYWlsdXJlKCkgaXMgY2FsbGVkIGFuZCBiZWxvbmdzIHRvIGEgY29t
cG91bmQNCj4gPiBwYWdlIGluIGRpZmZlcmVudCBzaXplIChsaWtlIHNsYWIgb3Igc29tZSBkcml2
ZXIgcGFnZSkgYWZ0ZXIgdGhlIHRocCBpcw0KPiA+IHNwbGl0LiAgQnV0IHlvdXIgc3VnZ2VzdGlv
biBtYWtlcyBtZSBhd2FyZSB0aGF0IHRoZSBwYWdlIHAgY291bGQgYmUgZW1iZWRkZWQNCj4gPiBv
biBhIHRocCBhZ2FpbiBhZnRlciB0aHAgc3BsaXQuICBJIHRoaW5rIHRoaXMgbWlnaHQgYmUgcmFy
ZSwgYnV0IGlmIGl0DQo+IA0KPiBJSVVDLCB0aGlzIHBhZ2UgY2FuJ3QgYmUgZW1iZWRkZWQgb24g
YSB0aHAgYWdhaW4gYWZ0ZXIgdGhwIHNwbGl0IGJlY2F1c2UgbWVtb3J5X2ZhaWx1cmUgaG9sZA0K
PiBhbiBfX2V4dHJhX18gcGFnZSByZWZjbnQuIEkgdGhpbmsgdGhlcmUgZXhpc3QgYmVsb3cgcmFj
ZSB3aW5kb3dzOg0KPiANCj4gbWVtb3J5X2ZhaWx1cmUNCj4gICBvcmlnX2hlYWQgPSBocGFnZSA9
IGNvbXBvdW5kX2hlYWQocCk7IC0tIHBhZ2UgaXMgTm9uLWNvbXBvdW5kIHlldA0KPiAgIDwgLS0g
UGFnZSBiZWNvbWVzIGNvbXBvdW5kIHBhZ2UsIGxpa2UgdGhwLCBzbGFiLCBzb21lIGRyaXZlciBw
YWdlIGFuZCBldmVuIGh1Z2V0bGIgcGFnZSAtLSA+DQo+ICAgZ2V0X2h3cG9pc29uX3BhZ2UNCj4g
ICBmYWlsZWQgdG8gc3BsaXQgdGhwIHBhZ2UsIGFzIGhwYWdlIGlzIE5vbi1jb21wb3VuZCAuLi4N
Cj4gICBsb2NrX3BhZ2UNCj4gDQo+ID4gaGFwcGVucyB0aGUgY3VycmVudCBpZi1jaGVjayAob3Ig
c3VnZ2VzdGVkIG9uZSkgY2Fubm90IGRldGVjdCBpdC4NCj4gPiBTbyBJIGZlZWwgdGhhdCBzaW1w
bHkgZHJvcHBpbmcgY29tcG91bmRfaGVhZCgpIGNoZWNrIG1pZ2h0IGJlIGJldHRlcj8NCj4gPiAN
Cj4gPiAtCWlmIChQYWdlQ29tcG91bmQocCkgJiYgY29tcG91bmRfaGVhZChwKSAhPSBvcmlnX2hl
YWQpIHsNCj4gPiArCWlmIChQYWdlQ29tcG91bmQocCkpIHsNCj4gDQo+IEhvd2V2ZXIgdGhpcyBj
aGFuZ2UgY291bGQgYWxzbyBjYXRjaCB0aGUgYWJvdmUgcmFjZSBjb3JyZWN0bHkuIEluIGZhY3Qs
IHdlIGNhbid0IGhhbmRsZQ0KPiBjb21wb3VuZCBwYWdlIGhlcmUuIEJ1dCBpcyBpdCBlbm91Z2gg
dG8ganVzdCByZXR1cm4gLUVCVVNZIGhlcmUgYXMgaXQncyByZWFsbHkgcmFyZSBvcg0KPiB3ZSBz
aG91bGQgZG8gbW9yZSB0aGluZ3MgKGxpa2Ugc3BsaXQgdGhwLCByZXRyeSBpZiBpbiBQYWdlSHVn
ZSBjYXNlKT8NCg0KSG1tLCBib3RoIGNvdWxkIG1ha2Ugc2Vuc2UgYW5kIGhhcmQgdG8ganVkZ2Ug
dG8gbWUsIHNvIGl0J3MgdXB0byB5b3UuDQpXZSBhbHJlYWR5IGhhdmUgZ290byBsYWJlbCAidHJ5
X2FnYWluIiBzbyByZXRyeWluZyBtaWdodCBub3QgYmUgc28gc3VycHJpc2luZy4NCg0KVGhhbmtz
LA0KTmFveWEgSG9yaWd1Y2hp
