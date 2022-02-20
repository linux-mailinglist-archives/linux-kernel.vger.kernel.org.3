Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530BC4BD2B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 00:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241750AbiBTXoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 18:44:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiBTXn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 18:43:57 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2067.outbound.protection.outlook.com [40.107.114.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F2037026
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 15:43:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xr6cyMM4ovlxWfPhk1ARRVYI3epSGqWZwC0hojmuDk+r8drVgnXV/lvTwPi/xY9tuuIygHZBEzfs0mOBfhUYC82igws1fl9Sm+XYSQPPVMtP7ce8rWpRg7KxdFzwW8dz9KXzIkfE/ovtmy8+EoHQBZRNsBKdJ3KXDtEGhbQWDhC6CFQNDWrmhSyomOTV4uFuB8WxhDgwy1Iqs5qlpDaInNCmEqT59xeg03f43/YgXoebfpxpoR1obQV9U/H+PjaUHuh2f6d48iGnbA8TNR0GW3szpqMKJt6ae5nFiMUhzq9rq0yWW0lact9lcCrLzZeiqnUOUDqWWK9g5Y/BkjSprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKVY27XCM9VT6nbNaNAApkc3x/KBbnJby6+Lxu/qPtE=;
 b=bUticlI4YHPRNI+K+47mCEhnhOXJ0yaT78HVdcYkaIQ5o5Ia7Tt+Cy3F07Nacrno/aW2ePfrKVuN57kH6k5Q4Qagif9uULWegKgmWhmgHaxGbVKi6EOt+4tW26szRScWNXvSJ+W3ykxKVc+T7r11spZNzFvIoiVvKfSqyJOzgGtYTmIbUwbHysRD91iEewX+VjPKlHu7Nq/aAmx1NJ8UpJVg/zpTyt7ecLPqphH1lQsvlHavxtAOypvYoxnAqalEVaBqgSqJzrGXCIoO3Lrx2sqRooFhritNqK1ufzFaVc4gsIx9eT4pHRIc4v5guCgMZSkdocPsdpyEmGiewVYSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKVY27XCM9VT6nbNaNAApkc3x/KBbnJby6+Lxu/qPtE=;
 b=NKdqEx93NIWChBJ7Lw4uJxnL8K2yFHX3l5YL4vVIgpu75Bp485LBk5Tkdd4qPrxqwc73s9wAjQhrw3ekml0EJKk0U+D7SLuTTx90bfT1w9LICM0+ghNyMmg6tzxk4W4T25mInUnUhOazMAr/ILq+3hHhWcJua4QsTIWsd1Z34tQ=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB3153.jpnprd01.prod.outlook.com (2603:1096:604:5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Sun, 20 Feb
 2022 23:43:18 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b%4]) with mapi id 15.20.4995.027; Sun, 20 Feb 2022
 23:43:18 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/8] mm/memory-failure.c: fix race with changing page
 more robustly
Thread-Topic: [PATCH v3 4/8] mm/memory-failure.c: fix race with changing page
 more robustly
Thread-Index: AQHYJKY6rFF4MvV3lUab4Q2dRrm3xaydHfYA
Date:   Sun, 20 Feb 2022 23:43:18 +0000
Message-ID: <20220220234316.GA3968455@hori.linux.bs1.fc.nec.co.jp>
References: <20220218090118.1105-1-linmiaohe@huawei.com>
 <20220218090118.1105-5-linmiaohe@huawei.com>
In-Reply-To: <20220218090118.1105-5-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 921f41b0-df7a-4437-b0e8-08d9f4cac57d
x-ms-traffictypediagnostic: OSAPR01MB3153:EE_
x-microsoft-antispam-prvs: <OSAPR01MB3153420C8C1FAB8D9678B03FE7399@OSAPR01MB3153.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gQXrKCaq6sRoBJ7eoo6qJiDcQMfY1/WOIw+1E8SveotgkwNvhImeosgksARGXzvvqjm7aD4kzAH7vKBkdTae97slE60ICtWVktmrU87PEnvwpBsH4LrI1ur17bZwc+l4LLbJdt6EQnRoIvQYQhQab9rSfGaTNkz33RDHn0qmvUb/KcWb6j7v9XzlHq/BiOWCVLNQWGeNb2PsoFYkqwqAChdPNvMagWIVFMnwotzpTDPA0E0DT2pU7iuXkWCua1UjySQ9ovJEerHtfKf80oUaNjjAO8GLmHRZaGQFlF11RcXHX5rEuC8DqRYj32kLDkJh7Uj1okbtn7/lnfOSE3AG0t/3GzyaPpfqzMre/gGkFI4f6F9ac7sVyt4Ex46cz81CLBIniBtmRPnSOmyhFTNkYrvMxkuWRrkrdLqHrDQcfsCcwl5xFiZdn0Qz1aVjr3QTsx4mTLqhqlFeDbsLwZfx2oVFmDXlaPwGtsMLpfJnie+zVLNtJMpfVAn3zRjyCp8HqmyEcupcwPX508PSLRMM/jG+40UZrA+J1pbXYLNBEH3xAa2FAyNt7dSSkPW9+IP11m7Ais/Vx0Bkcj+aPkd/pZPmvOAIdoCUr8bVk6OMNfhWHjWbxC0ow27Ytqayl75aWZL20i6iMDZ8ixkxneXnawrI81/T2TaItfggYgc8IgL9gi4VnsPBNjNt82QLMWKki7xppvvi0xP/o1C65TXUtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55236004)(9686003)(6512007)(6506007)(508600001)(5660300002)(8936002)(38070700005)(38100700002)(82960400001)(2906002)(86362001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(8676002)(54906003)(6486002)(71200400001)(85182001)(83380400001)(122000001)(316002)(33656002)(6916009)(186003)(26005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlZnNEJNVHlWeTBLYkV5M3N4ajM1cm9JcFJkK0VrK0tzbE9OcHZETTRBSEVk?=
 =?utf-8?B?UEFYK1NDNEFQbG5oQWNBNmY4RzBnWE9EbGZwTzViZ1l4UkFUWExhbUJRcThW?=
 =?utf-8?B?WXVJL1ZkWmhyakRFMjZuM0Z3TVdaeitkZEgwSDVHcVJ2YW9JK0cwMkwxM0NG?=
 =?utf-8?B?TUNyWU15TG9sb2RnTDRjT2tIOGYxRzdVWm1zbE1zcWRpREpucld0Um11cnR6?=
 =?utf-8?B?UFh5d21VSFhjbHU0MnZuTmx1NFd3ZEsvM0NlVDd1dGVWeDUwSy9YMlk4MWJC?=
 =?utf-8?B?aENvc1VzZVBuZ3Vkc0FTM3RUSUpyMGVNTGtmUFgxblgxN2Q2TTJqbjhIYXpN?=
 =?utf-8?B?U2ZjRXhCLzZKL1picDBnOW9uQ2ZwNkF2bWMxY2NzK3labldZbzN3YkUvZ1FS?=
 =?utf-8?B?czRPQXZFZk5zWC9LWUNBaTIvdHp6bzdJUmhHbTV0bVJ5djM5MDRyODZvc2pH?=
 =?utf-8?B?akF1QTY4aEtrN1dNQ3dTT0pVUmZvWm5LWVlCTmc5aitxV2Z5NEZiRndJTFhs?=
 =?utf-8?B?YmsxU2ZHNHFlMFNXczlSZS9UOU10REdIVE0rZG4wczdZL0t0V0dFT0pQdHZM?=
 =?utf-8?B?dW9yYXc2R3pBZG5OVEllN3c1dkN3SzJOMElPelZaM1lYSlZBa0JaaDBSdkpj?=
 =?utf-8?B?Q3dXU01wTTBGYXFtb1l4bW5EVmFpWndiZnoyVXJaUitXOXZXRnlqZnl2Zzhq?=
 =?utf-8?B?SDlCL3ZmY3FGQi9BNWxjbXMyN3ZaMGdmT2lwaFV0RVNpd3liVlVBZUVhemJx?=
 =?utf-8?B?Z0I4b1MxdElWSC9FQTNtL1FnbGp4dVA3aTgyTHRkRlpSYzZhZzBGb2xDUTZ6?=
 =?utf-8?B?bEV3dUFUVVBvRUdyNlRpZnVHeTFSSmRmL1JBdWpXeHRxaXNXUFRFZXorUk43?=
 =?utf-8?B?Y2J5dll4emV0ODdtMCtjbHdLL0pBZENnZ1phZWpFZm54S2ljTWdmOTY0aTRL?=
 =?utf-8?B?cjU4NEE1NE1pSHVuL3VRYVE0RnlvdjBZdXgxN1I3WVFXT0FIa3BNcVFacDBO?=
 =?utf-8?B?MkhDYU8zWC92ZEVHV2FxYXdXNTg2Q2N2YWRrVGRZZnZCNUpweHpqVWMzanNV?=
 =?utf-8?B?S2FEcUxTU0NockFtL0M4NnRSR0lzWVRmZHRLdmhmOGZtdVBhTUd0ZkRnT1dk?=
 =?utf-8?B?VWNPZ2xkbElaNmg3V2pGV2tGbE5aTzhpRy9RZnJqeS9JY29hVklDRlR5a2h3?=
 =?utf-8?B?N2JtTXFzZ092SHBzNTZtTHFwVzJGekRJRTNvSG10V2xBUHRjNEZqSUUrRjU3?=
 =?utf-8?B?RDF2UUd6MVc0cis3NU5OZTZUSGlnWGpzS09iMXNuVlJiL29ZNjJxK2puNU5i?=
 =?utf-8?B?OU02amFOK2MrOElWTWZkT29uNnhVdTB5UlA5aUdJbDJFVDUrUzJ5a0hxb0FL?=
 =?utf-8?B?UFBnMlVRRGFSNG1TcnJMSDJtaTVQbENkbjh6YktBYTJZTmR1aHM2L0FGKzJp?=
 =?utf-8?B?Rnk3S0Q5L0JTQWt3WkNTeWxxekY3ZzQyS3NJTGhsOVFVNk82MlRwbCsyMzBM?=
 =?utf-8?B?S3JMRnpyMUt2K205MTZGODgyTEl4c1dnay9FMXJTT3JvM3ladTliYmpaWTdF?=
 =?utf-8?B?NlB6dkx3S3pRNkVvb25VdUhBM0VFQUpUa3BLcjQxRU1vc203WGRzSk1JeWdV?=
 =?utf-8?B?cVdidjlVeG90WjlvRlU2QjY5RzZYMHpUVWlQSmxlWlY3MTN4MWRvOXVrVHdI?=
 =?utf-8?B?S2R4eHBEd1d2QlZCYlJOYVdrNTVFaTM2MlpPdkMyb1llS2ZUN3RIY0FhVUxW?=
 =?utf-8?B?QlQxeFFXQ1M2REtpNmM2YkVIb1FEcnpvRUxiL3M5TUJHZExkeWRWZmI2R1pN?=
 =?utf-8?B?SjVtR1Vzd05OSXplV2lDczNsNlliMm8zVGp4aXJtUjVmRHIzc2VEVVRLRGdE?=
 =?utf-8?B?NE5LUldQdlBEd3JRZHNab05vekNTdFFTMGx6ZXFyOWFLcUZjdjZnZjRFT0RE?=
 =?utf-8?B?bXpZekVhYlVWRGYxOTlEOWI3bUR0SlhKb0VpVlg3Mm9CUzhtRGdsQWlNb0I0?=
 =?utf-8?B?dDdSaFZlWGJNTkphUjF4TzJ2d1hPNVhYTUZ3RktSY3ZTV01LN2pXQlBka29E?=
 =?utf-8?B?VEhzMVMzZEtnYURtUFV6S2FRcE5oRldjenF5V2N5bHFSQ05YU3k4WjVDYVRM?=
 =?utf-8?B?bjBIZ0FwdFFSN05XQ0d5cmdpSzF2M1hzZE1sUjlzZ0lFVm5kSlBGTzBaUkk1?=
 =?utf-8?Q?552wkidf3lGx9m6AkhN2eoZAu/g7aS8S+WZVjzRN81oq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D294411B1A99247924BF2ED22109582@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921f41b0-df7a-4437-b0e8-08d9f4cac57d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2022 23:43:18.2774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h1rSRhgCeABLYJs+DhtsmdexFRKBE6za7OzQHKRU+XMNgCxdmTjVo7PKzX6S/3rIgp64bLXzCHOJ4Gr++OiRTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBGZWIgMTgsIDIwMjIgYXQgMDU6MDE6MTRQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gV2UncmUgb25seSBpbnRlbmRlZCB0byBkZWFsIHdpdGggdGhlIG5vbi1Db21wb3VuZCBw
YWdlIGFmdGVyIHdlIHNwbGl0IHRocA0KPiBpbiBtZW1vcnlfZmFpbHVyZS4gSG93ZXZlciwgdGhl
IHBhZ2UgY291bGQgaGF2ZSBjaGFuZ2VkIGNvbXBvdW5kIHBhZ2VzIGR1ZQ0KPiB0byByYWNlIHdp
bmRvdy4gSWYgdGhpcyBoYXBwZW5zLCB3ZSBjb3VsZCByZXRyeSBvbmNlIHRvIGhvcGVmdWxseSBo
YW5kbGUNCj4gdGhlIHBhZ2UgbmV4dCByb3VuZC4gQWxzbyByZW1vdmUgdW5uZWVkZWQgb3JpZ19o
ZWFkLiBJdCdzIGFsd2F5cyBlcXVhbCB0bw0KPiB0aGUgaHBhZ2UuIFNvIHdlIGNhbiB1c2UgaHBh
Z2UgZGlyZWN0bHkgYW5kIHJlbW92ZSB0aGlzIHJlZHVuZGFudCBvbmUuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCg0KQWNrZWQtYnk6IE5h
b3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQoNCj4gLS0tDQo+ICBtbS9t
ZW1vcnktZmFpbHVyZS5jIHwgMjAgKysrKysrKysrKysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L21tL21lbW9yeS1mYWlsdXJlLmMgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+IGluZGV4IDdlMjA1
ZDkxYjJkNy4uMmNhNTBjZmE2MDFmIDEwMDY0NA0KPiAtLS0gYS9tbS9tZW1vcnktZmFpbHVyZS5j
DQo+ICsrKyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gQEAgLTE2OTAsNyArMTY5MCw2IEBAIGlu
dCBtZW1vcnlfZmFpbHVyZSh1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzKQ0KPiAgew0KPiAg
CXN0cnVjdCBwYWdlICpwOw0KPiAgCXN0cnVjdCBwYWdlICpocGFnZTsNCj4gLQlzdHJ1Y3QgcGFn
ZSAqb3JpZ19oZWFkOw0KPiAgCXN0cnVjdCBkZXZfcGFnZW1hcCAqcGdtYXA7DQo+ICAJaW50IHJl
cyA9IDA7DQo+ICAJdW5zaWduZWQgbG9uZyBwYWdlX2ZsYWdzOw0KPiBAQCAtMTczNiw3ICsxNzM1
LDcgQEAgaW50IG1lbW9yeV9mYWlsdXJlKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3MpDQo+
ICAJCWdvdG8gdW5sb2NrX211dGV4Ow0KPiAgCX0NCj4gIA0KPiAtCW9yaWdfaGVhZCA9IGhwYWdl
ID0gY29tcG91bmRfaGVhZChwKTsNCj4gKwlocGFnZSA9IGNvbXBvdW5kX2hlYWQocCk7DQo+ICAJ
bnVtX3BvaXNvbmVkX3BhZ2VzX2luYygpOw0KPiAgDQo+ICAJLyoNCj4gQEAgLTE4MTcsMTAgKzE4
MTYsMjEgQEAgaW50IG1lbW9yeV9mYWlsdXJlKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3Mp
DQo+ICAJbG9ja19wYWdlKHApOw0KPiAgDQo+ICAJLyoNCj4gLQkgKiBUaGUgcGFnZSBjb3VsZCBo
YXZlIGNoYW5nZWQgY29tcG91bmQgcGFnZXMgZHVyaW5nIHRoZSBsb2NraW5nLg0KPiAtCSAqIElm
IHRoaXMgaGFwcGVucyBqdXN0IGJhaWwgb3V0Lg0KPiArCSAqIFdlJ3JlIG9ubHkgaW50ZW5kZWQg
dG8gZGVhbCB3aXRoIHRoZSBub24tQ29tcG91bmQgcGFnZSBoZXJlLg0KPiArCSAqIEhvd2V2ZXIs
IHRoZSBwYWdlIGNvdWxkIGhhdmUgY2hhbmdlZCBjb21wb3VuZCBwYWdlcyBkdWUgdG8NCj4gKwkg
KiByYWNlIHdpbmRvdy4gSWYgdGhpcyBoYXBwZW5zLCB3ZSBjb3VsZCB0cnkgYWdhaW4gdG8gaG9w
ZWZ1bGx5DQo+ICsJICogaGFuZGxlIHRoZSBwYWdlIG5leHQgcm91bmQuDQo+ICAJICovDQo+IC0J
aWYgKFBhZ2VDb21wb3VuZChwKSAmJiBjb21wb3VuZF9oZWFkKHApICE9IG9yaWdfaGVhZCkgew0K
PiArCWlmIChQYWdlQ29tcG91bmQocCkpIHsNCj4gKwkJaWYgKHJldHJ5KSB7DQo+ICsJCQlpZiAo
VGVzdENsZWFyUGFnZUhXUG9pc29uKHApKQ0KPiArCQkJCW51bV9wb2lzb25lZF9wYWdlc19kZWMo
KTsNCj4gKwkJCXVubG9ja19wYWdlKHApOw0KPiArCQkJcHV0X3BhZ2UocCk7DQo+ICsJCQlmbGFn
cyAmPSB+TUZfQ09VTlRfSU5DUkVBU0VEOw0KPiArCQkJcmV0cnkgPSBmYWxzZTsNCj4gKwkJCWdv
dG8gdHJ5X2FnYWluOw0KPiArCQl9DQo+ICAJCWFjdGlvbl9yZXN1bHQocGZuLCBNRl9NU0dfRElG
RkVSRU5UX0NPTVBPVU5ELCBNRl9JR05PUkVEKTsNCj4gIAkJcmVzID0gLUVCVVNZOw0KPiAgCQln
b3RvIHVubG9ja19wYWdlOw0KPiAtLSANCj4gMi4yMy4w
