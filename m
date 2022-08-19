Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915CD599486
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346006AbiHSFYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbiHSFYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:24:35 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2089.outbound.protection.outlook.com [40.107.113.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B390D5985
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpxwR2TLT75i+gf3qaCKW7gDZwECE/EnqG3GA6jZN9wBqiTTosE9+4wKfNp97X1GccXYBweIAKzKeGOlRJQEYlhQ/S3N4CYyOyXlLbNn6umYXAWW1LdGGHIlGGjLVTB9cZDdPlF9O8zmbGfK5Qd0Jq9R/cNQBzwverRp96QTTcNIPwXIgbt+p/sqkxNSCCq0kg1/T87qBK8P0qf0xBhNipI/Xil7PkTq6NL9Jo0BkbbtyP1Px/EgzCZBLX87kEFUY0WLvjPNGcKZMdTM2F7U7WXh2JBDd7xGz5jxlpMGBWJRnd9G6AielW1RzhqQXxLlQjFWFYqwy7ERdxioANqZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZC67OiiLvdRUuRu3VDWKTln/x9hejo6YmF4m/M3A/4=;
 b=U1di9ZyMtjZn6QkEInnycwgP3x7HHtFYoQzWsJfKte0hyqvfhwd7zc+JE0a7yd/f70TB4o5SUGmTiitPoGs/sHfSzE2WH5vxOxR0DMcJUqhW5qIgLtxMAAPT1Yk+Z+WgpfOMtb9BIk7qeKPbpLEmgmKT4H02yseWvqaolhNsmOA1pzFXRIHt0pO49InfT6idyMv6sqdUpKvthsZmcPMoWEfL5HV+NmCkrcAs8E0yHK79MuMXcNWjFK3GHb4iXnKoRGsB0SbUgYP9tKIgYkdQkH/9yyhk6eWCgLcFbuujNeenjiPG9d9eMLPTMeHFJFHtG65eETyC3tzPrHOFzmLzqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZC67OiiLvdRUuRu3VDWKTln/x9hejo6YmF4m/M3A/4=;
 b=ief6tav6FEORfKFqJn2219RfN8SCbdmJoAU9TV+69mJD25lwyKNxeckPqYQAxrEm7jh57T4rhwKXlEWUgYnQIAZa+tZcjr6waup18yGxAuOAEE/UYfo1UCiR5lmzWFyhSGmc+3LY+NLqf3jgNvumWcErKmd1EhmyKqN0VdxgBaA=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB3460.jpnprd01.prod.outlook.com (2603:1096:604:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.17; Fri, 19 Aug
 2022 05:24:32 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 05:24:32 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] mm, hwpoison: kill procs if unmap fails
Thread-Topic: [PATCH 5/6] mm, hwpoison: kill procs if unmap fails
Thread-Index: AQHYswKLX9pNyTGWmEG6DHLl/hkSv621seaA
Date:   Fri, 19 Aug 2022 05:24:31 +0000
Message-ID: <20220819052431.GE613144@hori.linux.bs1.fc.nec.co.jp>
References: <20220818130016.45313-1-linmiaohe@huawei.com>
 <20220818130016.45313-6-linmiaohe@huawei.com>
In-Reply-To: <20220818130016.45313-6-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc785280-5d77-4bec-7a42-08da81a318b2
x-ms-traffictypediagnostic: OSAPR01MB3460:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zw6ZYgWU6bIQNhguW870bdjeXrImbj07ne/P0h844RO/Y9iOz8OjczyUrQB6Z7cbyUDxwvvVozoct4do+bvcVul0CmZuY+DkhEyF0VT7Wk7ra4DvSfkDGH3X+Q/JqKl5nV97c1Hri30fXHsDolEa5NSPAisqCRnUTzGCiN4s2H/QhTufsKe768vFlZxk6/WTaJdHN5OZ3GGcXpZEEElDn992fwxtv4WHJN0ORR4gMxjqXhlWt1A28cOtYbKYYU0VEr45fYGrCsB0mTFe3tZHOJGjS78Mz2h7+C9tymHCmwffio4JL1MBhtisnatK2PPeJruSojzmuoC/6ODrmArU29zWjAi0pREbbtsFNSN/Gf0391I45BWdFUztZmp0GnGHkazOiZ3arlI7D8z0AlKXSoA23XRq4bJHieuPezyboP+c2XbUxA5276FmQy88M4fRmX+/PwodSR2YDQRyEt3CRaJz8prvmYtRLUIfADnO5taTdw8b0RG0CHpE+YdoAjhBPyDs2sIxidinrk/U0+wYlvVrOMox4qPNvHXyUgT5l49McetByfMEph4AWrcAUzq5qR/i4wjroHa/8lhvPCrf7eX/thwJZr8G9hc5sQ2KFU9KcuRAl/Sd3jzxZ8tyJZG4DcDtXi/okDk1SW09RXtY6QwufXvoau9n1wik56wBaRIJ/BGWtN3YcMtnQi6OyCOuTKvqbS8HRa/pQczHoex5Ss/R0yHVZ6UOxvXAYd1Kem7vG9ekxGFbEmj1hc7CypjqN1IS800MwDOQr34XZ+yNjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(85182001)(33656002)(86362001)(38100700002)(55236004)(83380400001)(9686003)(6512007)(186003)(6506007)(26005)(1076003)(82960400001)(38070700005)(54906003)(41300700001)(6486002)(478600001)(71200400001)(4326008)(6916009)(76116006)(66446008)(64756008)(66946007)(8676002)(66476007)(66556008)(5660300002)(2906002)(122000001)(8936002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qy9HTWpLRTV4R1lQalFKcG5UNGFWNnl3QzVoL21NK2h3OXRoM29VbjNmaWZk?=
 =?utf-8?B?UWlMckR5azFDUkhUdU1mY25FaFNMM0lWdENFbERRK3gyRUlwMVVqRCtZWTJP?=
 =?utf-8?B?YXhEMFMvMHVscFgvanRvTWc0K2R2VXdKR1JuTXNuT0ppMGRnTjFrRWhzaSti?=
 =?utf-8?B?ZUI2RjliTUVYMWJHNUdCZVBEVWVxU0k2bU84VzlGd1A1UVo3L0p4SWRrTXBS?=
 =?utf-8?B?cDBiMWJmVkJETHlnQ2NuZ09oRFV5aXVvanE4V05MRE8zVzR4NS9XUG1mN3NT?=
 =?utf-8?B?VERUUHp1WUZqTW5pM3pUQU1vTG84SUwwRDcwYWZCWktqZHVqempNQy8reDNE?=
 =?utf-8?B?bVJkTzJRbEIxMXFmN1JqT0JJcm1YWlgwSU9FdHNyYjA2WTlGTTBUZVdiV01Z?=
 =?utf-8?B?elNWS3JERnBuYTZyWHgrYlBwbUtTR3lFZjM3RGFQRWpXclIwRVdlUDF1SEE2?=
 =?utf-8?B?UTl1Rnh2amxSWnhBN0JKb3I5UmplU1dpYlF6MHRLZjRQeE5idElHMnJMWWVo?=
 =?utf-8?B?YjlzVXBuNDNGamRBTzlsdExHNEpZdnBjU3NQMGplbS96N0lXMWR5WjFlc0Z6?=
 =?utf-8?B?TXdtUEo0K24rV25EM3JZUkpveEcwS25LZi92bVBsaGhkaFNKS0p0ejFLU0RL?=
 =?utf-8?B?ZVBEbUh1ajJMYnV5SXBJaTkvOUFLNk02NStLUk9VR3o1TnplWjlOQ3B2aFpL?=
 =?utf-8?B?cGNnREtNY3RiYTh0VzAxUVBlUndyRWV4ZCs3OXdIVy9FM053VE51MGJRdjJK?=
 =?utf-8?B?NmtzZzhWMFdTNllBVHBwTkQyTStJMW5uSklUU2VwWGtaemhMcHdtSzRUbUtM?=
 =?utf-8?B?dHZpanlIRXZqWnRCUEpadkc5YlU5Zm5SeFJBejhMdmN2TEh0Qi93WnBnZEZK?=
 =?utf-8?B?ZStGR2lkbnZ0WDc0NzFRdENkc3RRL2xQL0h6cGhFS0hyY3lMQ1luemFTYVJv?=
 =?utf-8?B?MkdrS0EyRCszNVBqTTQyeWU4NURqTG5YdlZtc1d3K08xMGcyUE9iRU13OW9w?=
 =?utf-8?B?VEpEaHlxWFFOTU1kTDdQMlNSdEdIY1g3TW5KT2dhUFVKNTRseUQ1Wjl1WUlF?=
 =?utf-8?B?SHJuUWlHSkNsZzVOanMwakVGZzlrdHdqaUxnMkoyOHJKWGsrOFd4ZHR1eHkr?=
 =?utf-8?B?bjFRenR2dEhCd3VvblkxK1VkN0pzTFovdGM4aE5kUkJ2NmQ4YnNFMFJOMlUr?=
 =?utf-8?B?ZUpnVFA5bC9LRGY5ZThkRWFIaDhpR3Z1RFJQNldSVk9MbThsVENTb21KbTRG?=
 =?utf-8?B?YWI0UXVEQVpVbFJGRExUZGpaTEV1U05GNGRnaGhPY1JoSDdzTStyYk5DV0NS?=
 =?utf-8?B?RTlRMVBvRUswaHJUeWJveDVORVg2RnRkdGNMcC94VlBCdFZyQ2xQaGMxdndn?=
 =?utf-8?B?NnN3TGh0NUVNZmZnb1d2MmpCRjVQRGEzMHJnM0F5Tm5tNmJCNWFTakVnNXQ5?=
 =?utf-8?B?dVBrT3dITGRkam5WQ1dxdzdKd2x4SWN4VjN2UXFKQTM2L29IeVJ1V0RUN1Zh?=
 =?utf-8?B?YXdBZkxJNGRVL1QwakNoemVMbG82MVFiOHBuRnRMQ3BON1RIRllmSW1QOTRq?=
 =?utf-8?B?emNzYmdRK0FmaWhwMFF4V2k3Q3VQckFjUG9ObHhuak1TNG9xbEM4bXZDalM4?=
 =?utf-8?B?djU0RURBdUJqTzNzeTFwMW03OFpYTlVNWHJtY1dJR2RPKy8xbVpKZzBocjd2?=
 =?utf-8?B?bFV0VWJPNHdPZ3ljRFdQNkNtOEhIclFhSlVmUTRqdjJiTFhzeEYzZjlwNkFB?=
 =?utf-8?B?c1pPbmNMd2t6MTZXYWQ3VXRwUUUycFloTGZZNlZoZjZOc0U2aFVEdFZYTFcz?=
 =?utf-8?B?ZWE3ZmtKUGYzVzZ3a1NtejNMTVVhbnpNYW1UMG9wdll6bXZUR0pCTExJbnRr?=
 =?utf-8?B?NWJZVkI5ODVlcENvOWgrMXVhNC9qanh5ZExNbEcxRHk0MExpd3A5ZzZrM0Jx?=
 =?utf-8?B?UFFrUStKYzI1Rm1EdTlORFZxL3RLbjc0MlEzSGZVRWdxc0pDK2FZbkRjaGtw?=
 =?utf-8?B?VXg4aE43THdkQUdvaHI4ZnVUd2x1SUZYdVZkS2NDdzZpSGM3aWZIMk42cklm?=
 =?utf-8?B?MnhIaHNIV04veEJxNGNCWEwwR3JCS280S0FuMmc1dUVRc20rOU9rdzhXUlhP?=
 =?utf-8?B?V1REdGg0aWhlT21yTk1ST2Q4Z1p2NjlrMEpkWGlDVkxpY203eXJjcFc1dlFz?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F361751AE4ABE4795D162D506CE63EE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc785280-5d77-4bec-7a42-08da81a318b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 05:24:31.9880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sO2jOxDRWna/D57S/SvnwC2g4qE9V22LuK37XJyLowvZOZ7cjpSzjNq4FLtQ/Vl71ZY+8Y8Qy0GUHuR7LwAsHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3460
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBdWcgMTgsIDIwMjIgYXQgMDk6MDA6MTVQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gSWYgdHJ5X3RvX3VubWFwKCkgZmFpbHMsIHRoZSBod3BvaXNvbmVkIHBhZ2Ugc3RpbGwg
cmVzaWRlcyBpbiB0aGUgYWRkcmVzcw0KPiBzcGFjZSBvZiBzb21lIHByb2Nlc3Nlcy4gV2Ugc2hv
dWxkIGtpbGwgdGhlc2UgcHJvY2Vzc2VzIG9yIHRoZSBod3BvaXNvbmVkDQo+IHBhZ2UgbWlnaHQg
YmUgY29uc3VtZWQgbGF0ZXIuIGNvbGxlY3RfcHJvY3MoKSBpcyBhbHdheXMgY2FsbGVkIHRvIGNv
bGxlY3QNCj4gcmVsZXZhbnQgcHJvY2Vzc2VzIG5vdyBzbyB0aGV5IGNhbiBiZSBraWxsZWQgbGF0
ZXIgaWYgdW5tYXAgZmFpbHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWFvaGUgTGluIDxsaW5t
aWFvaGVAaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICBtbS9tZW1vcnktZmFpbHVyZS5jIHwgOSArKysr
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWls
dXJlLmMNCj4gaW5kZXggYTJmNGU4YjAwYTI2Li41Zjk2MTVhODYyOTYgMTAwNjQ0DQo+IC0tLSBh
L21tL21lbW9yeS1mYWlsdXJlLmMNCj4gKysrIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiBAQCAt
MTM5Niw3ICsxMzk2LDcgQEAgc3RhdGljIGJvb2wgaHdwb2lzb25fdXNlcl9tYXBwaW5ncyhzdHJ1
Y3QgcGFnZSAqcCwgdW5zaWduZWQgbG9uZyBwZm4sDQo+ICAJc3RydWN0IGFkZHJlc3Nfc3BhY2Ug
Km1hcHBpbmc7DQo+ICAJTElTVF9IRUFEKHRva2lsbCk7DQo+ICAJYm9vbCB1bm1hcF9zdWNjZXNz
Ow0KPiAtCWludCBraWxsID0gMSwgZm9yY2VraWxsOw0KPiArCWludCBmb3JjZWtpbGw7DQo+ICAJ
Ym9vbCBtbG9ja2VkID0gUGFnZU1sb2NrZWQoaHBhZ2UpOw0KPiAgDQo+ICAJLyoNCj4gQEAgLTE0
MzcsNyArMTQzNyw2IEBAIHN0YXRpYyBib29sIGh3cG9pc29uX3VzZXJfbWFwcGluZ3Moc3RydWN0
IHBhZ2UgKnAsIHVuc2lnbmVkIGxvbmcgcGZuLA0KPiAgCQlpZiAocGFnZV9ta2NsZWFuKGhwYWdl
KSkgew0KPiAgCQkJU2V0UGFnZURpcnR5KGhwYWdlKTsNCj4gIAkJfSBlbHNlIHsNCj4gLQkJCWtp
bGwgPSAwOw0KPiAgCQkJdHR1IHw9IFRUVV9JR05PUkVfSFdQT0lTT047DQo+ICAJCQlwcl9pbmZv
KCIlI2x4OiBjb3JydXB0ZWQgcGFnZSB3YXMgY2xlYW46IGRyb3BwZWQgd2l0aG91dCBzaWRlIGVm
ZmVjdHNcbiIsDQo+ICAJCQkJcGZuKTsNCj4gQEAgLTE0NTIsOCArMTQ1MSw3IEBAIHN0YXRpYyBi
b29sIGh3cG9pc29uX3VzZXJfbWFwcGluZ3Moc3RydWN0IHBhZ2UgKnAsIHVuc2lnbmVkIGxvbmcg
cGZuLA0KPiAgCSAqIEVycm9yIGhhbmRsaW5nOiBXZSBpZ25vcmUgZXJyb3JzIGhlcmUgYmVjYXVz
ZQ0KPiAgCSAqIHRoZXJlJ3Mgbm90aGluZyB0aGF0IGNhbiBiZSBkb25lLg0KDQpUaGlzIGFib3Zl
IGNvbW1lbnQgbWlnaHQgYmUgZGVwcmVjYXRlZCBub3cgKEknbSBub3Qgc3VyZSB3aGF0IHRoaXMg
cmVhbGx5IG1lYW4pLA0Kc28gY291bGQgeW91IGRyb3Agb3IgdXBkYXRlIHRoaXM/DQoNCkFueXdh
eSwgdGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuDQoNCkFja2VkLWJ5OiBOYW95YSBIb3JpZ3Vj
aGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KDQo+ICAJICovDQo+IC0JaWYgKGtpbGwpDQo+
IC0JCWNvbGxlY3RfcHJvY3MoaHBhZ2UsICZ0b2tpbGwsIGZsYWdzICYgTUZfQUNUSU9OX1JFUVVJ
UkVEKTsNCj4gKwljb2xsZWN0X3Byb2NzKGhwYWdlLCAmdG9raWxsLCBmbGFncyAmIE1GX0FDVElP
Tl9SRVFVSVJFRCk7DQo+ICANCj4gIAlpZiAoUGFnZUh1Z2UoaHBhZ2UpICYmICFQYWdlQW5vbiho
cGFnZSkpIHsNCj4gIAkJLyoNCj4gQEAgLTE0OTUsNyArMTQ5Myw4IEBAIHN0YXRpYyBib29sIGh3
cG9pc29uX3VzZXJfbWFwcGluZ3Moc3RydWN0IHBhZ2UgKnAsIHVuc2lnbmVkIGxvbmcgcGZuLA0K
PiAgCSAqIHVzZSBhIG1vcmUgZm9yY2UtZnVsbCB1bmNhdGNoYWJsZSBraWxsIHRvIHByZXZlbnQN
Cj4gIAkgKiBhbnkgYWNjZXNzZXMgdG8gdGhlIHBvaXNvbmVkIG1lbW9yeS4NCj4gIAkgKi8NCj4g
LQlmb3JjZWtpbGwgPSBQYWdlRGlydHkoaHBhZ2UpIHx8IChmbGFncyAmIE1GX01VU1RfS0lMTCk7
DQo+ICsJZm9yY2VraWxsID0gUGFnZURpcnR5KGhwYWdlKSB8fCAoZmxhZ3MgJiBNRl9NVVNUX0tJ
TEwpIHx8DQo+ICsJCSAgICAhdW5tYXBfc3VjY2VzczsNCj4gIAlraWxsX3Byb2NzKCZ0b2tpbGws
IGZvcmNla2lsbCwgIXVubWFwX3N1Y2Nlc3MsIHBmbiwgZmxhZ3MpOw0KPiAgDQo+ICAJcmV0dXJu
IHVubWFwX3N1Y2Nlc3M7DQo+IC0tIA0KPiAyLjIzLjA=
