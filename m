Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A9F4FD08D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 08:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350843AbiDLGsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 02:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351126AbiDLGoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:44:04 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2071.outbound.protection.outlook.com [40.107.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107AD396A0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:37:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGztjE3pYn1/kJ1u+w0MHWKVcN9QNFiGGVL4S9auvkJyM7mMJE8yL5p3YqzU3vaB8fzm17sWlDc6JLCC0vlhu09HMi9qRLmt1HAjLrTURRgHII8ZqeKWX2S/VvOfVIeXLsbVBoICA0zujQ77saazm1i+GHeT23J7DeMLcJt+NJqVAGGE9BzSNqwK8x+X8tMxDgwmvgi7Wu1hUGf2hSAP2vTr8HpCnYXKTxkw+gqUu4JoiDPtj4m1C+cFpl9yQKXtdmkqrV4waixcwpTpIgMEaVk05loyl9nsMEZehyVUQhwbqujbCPr+oCrmQqoCm4ndkaxMjywsI+iROdxHbDjNgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDRxRHi1vArLp1nULs3GkzfSDUhL8Nh3v+UMvBmrF1I=;
 b=lUHHkafqU1P3mS0V1Vtfe1e1MFITXf8fCFExKS/qVJL5hbps+0cU1NqXGbMHVBi3MLzJZ6cFX6X9NZl0oO3fuIMPHt0FfktjSh276zmyc1wckXJU1fQwDOE1ikUiHzHjTqW2igbCF9XQVuQsJZ1W4OFFL9NelYGx8gbS5sQMGhQqbhV1pNiJG4M4Vzc6qWWBFdvnTf3N+rvv1uTsk8rL9xBVxyVxwacxHxqTdIUKxk6W4VJYDG2y3cw6HchOecXVScdcBRhjDWXMRuRUHFMiAEGg65y25fzs6xl80dzOfSws8alkr9uNeiZC3EpDwX4tN7JdY6SgrbiqyfB2I6WRoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDRxRHi1vArLp1nULs3GkzfSDUhL8Nh3v+UMvBmrF1I=;
 b=h14seYXoE8WTNV77YitdKMF6iQjhrHPR1vRHB/SNlf01WLQ59GKgfW87unMHUEEUIOCAFs2Cd63eRyYrMFIMH617HTgjNSF+1NDeoBfbV87xKtinbYCJNR/42iRwGD/wArM4nSPsEX8tQMnEI0ZlNFdC9SKlUd6A73P49iQS7F0=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB6509.jpnprd01.prod.outlook.com (2603:1096:400:93::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 06:37:25 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232%8]) with mapi id 15.20.5144.028; Tue, 12 Apr 2022
 06:37:25 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm/memory-failure.c: avoid false-postive
 PageSwapCache test
Thread-Topic: [PATCH 1/3] mm/memory-failure.c: avoid false-postive
 PageSwapCache test
Thread-Index: AQHYSn/2OvBludUMUkmdxXcQX3/j4azqR6EAgABw5wCAASIBAA==
Date:   Tue, 12 Apr 2022 06:37:25 +0000
Message-ID: <20220412063724.GB3227993@hori.linux.bs1.fc.nec.co.jp>
References: <20220407130352.15618-1-linmiaohe@huawei.com>
 <20220407130352.15618-2-linmiaohe@huawei.com>
 <20220411063520.GA3175313@hori.linux.bs1.fc.nec.co.jp>
 <792748d6-3b41-d118-27bd-75e79390ba1a@huawei.com>
In-Reply-To: <792748d6-3b41-d118-27bd-75e79390ba1a@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96aba4e6-04f1-4224-82d7-08da1c4ee852
x-ms-traffictypediagnostic: TYCPR01MB6509:EE_
x-microsoft-antispam-prvs: <TYCPR01MB65096A32BEF4A1F7EF1DF2D4E7ED9@TYCPR01MB6509.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vruw5XzlZwO+UV0bNgEPaLIl++M1Y//mYNOZajWKi3r6kUy14WEyrvSrDEjIigtzo5l38Bd0NOqHuQ3/46pqBmD2SVfUij88gg2y6RGSqSgk36k0DAfq8RlrmoqSzVywcMq4IryrTkaV52h6aBVbqD8XWYabI2ybUplXYABPVtKOm2U8c6Q07eoR0I+zW/RCAhWdvlmBIhmTp4Z1EbnKEEuqDCLDyP7rxzHFGBeL7lgzPHEK+F+I9m3qcGLv3SM17vQG1ukzpYNZiOCWasLjg44DaEEmoHg648520Y+JUppKgAPPkdzsdKB4Uj4/AD8Vt9K2KUtzBU4qI7kfBOYtC1bjL3hMZz6zOQsChBuZ38gXpcGH+9cC3dExLWM2RcGfzm0lttKTBLMErxupLm5xk+fvlV/3TntGAzuqaGEqWN4OyS3VWIgl2HxWnMfIrb+g5oSG+239KkPQCY2QTxjWCP+tC2YU6jkGQPS2XHr/LnRJVBPWVgXa3YbLdq7DF1yUo0R7HYlu66BrNDS01FSI7RwDc1dDKgoNg5CF0VSZewAYSOgQJUuzd1Jn3LqN62T8TtkCB/LH6D0y0IgBYA9YeZ9T4/NILZKKsuX/sM9aNgM1Gmy7Ak5RG4iBZHS7dsdhBAxq3xGI4Pdt7cFyx5iS7/2YeOQgi5FCXzZFM/Sng0AsV/QeVpv0VYdCNMQ3VnCjtbswjeUgSh7cC+RQsKqkZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(38100700002)(33656002)(5660300002)(186003)(26005)(85182001)(1076003)(86362001)(508600001)(64756008)(66476007)(122000001)(66556008)(66946007)(8676002)(66446008)(38070700005)(82960400001)(76116006)(6506007)(6916009)(83380400001)(53546011)(55236004)(9686003)(4326008)(8936002)(316002)(6486002)(2906002)(6512007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1dzUDAzV0RtaEo2aTg5VjZJSUI1cTJCSlBKUzYwS3FtMGZZc3huQXpidE0y?=
 =?utf-8?B?ZVF0ZmZubjVMZUFhazR4aVVRYUg5T2psdDB0TWx5c3djV3V5RXNsaU5ydW85?=
 =?utf-8?B?eWd1TDdyOEFERlpNL2dWblczNWtYS25RUmRCc3M2RlNLNVNFR0ljbnFvY043?=
 =?utf-8?B?THZmaFJjQzdsV2kzbzN2b1VmSmRsb0RnRXRja3o3T0tXSlYyUHFvMW1tRkpQ?=
 =?utf-8?B?VnIrU1Z6MFU1TDZCRURtTUtvS256TGMvZ1hxbW9rVzV4OEwrS09MbjhNTHQw?=
 =?utf-8?B?S0F3eTRwd2h4WkVmK0VHVlU3azk3Tm5BTjBqWEVYZ3BJQjRYNzZNQy9sc0JY?=
 =?utf-8?B?bEQvR3FVMEcrb0dqend0VVp5N3djclEzbnh0VW9seGI0QjRXZ1NVOWd4UGl4?=
 =?utf-8?B?Q3Z4bldKSVJ3dGlDODUrcnAvTnZTTkdldU9LNXNhOHJpMDNaNlFqNnFNbGpG?=
 =?utf-8?B?aFJPSFVjajNtOFFSZEpVWWdZbStyWXNoNjhNUEdHS1pxSi9mWGIrVXZwVmZE?=
 =?utf-8?B?ZkV6Nm1EcVhTVVU1TnhRTWs4RUtZMVdhZTJncFdKR0xOT1ZEQ2VkNDhuaVY5?=
 =?utf-8?B?WTlqWlhKNmNXcWs4ODQxSUxFQ2hLQVJXK1BBRGViWUtZaEQrYXp5YXlnODVF?=
 =?utf-8?B?TkhVTG14QzB5NGhoMUE4ZXNtbzJaTFFrcFlra1VUbzY1SUpNUnIzL28vaUJH?=
 =?utf-8?B?c0F2cm5XTUJhNVRxV0I5RWFPeXBFUlRDSytjdHVmUTIyNnU5NU1uQ0xMckZO?=
 =?utf-8?B?U3p4RUZTTFZkayt1VlJYTXZkdmMwenFkQVFKZkgxWjZVZ0JrYkMvbXM0bnFX?=
 =?utf-8?B?R1JHeGlGVW4rTXM0Q1RpaFczTG5VN25ndE9HMWhHQXBkVjRVUGN6THRIMis2?=
 =?utf-8?B?bmFYZnVFd1hvM1Z2VW4rSDJXanhmZWVWVlIrRTMzUDcvNHErVml3N2hRVVFz?=
 =?utf-8?B?WDZBRG9uRXF1Vkd2TnFCa2g1WHhVcEpYN3YycTRXWmFDVTBxb0NZY09SUWpB?=
 =?utf-8?B?UmZNdEJScDJtcXVpRHZSVXZKV1hjL2lqcEpNbFh4WnF1Sm5jakFReUpYNDBt?=
 =?utf-8?B?NmNJR1hUcFFFOFduOEYrclRPZUl5ZGx1bkhPZGc5eThlQ29lRDdHQk9lemFJ?=
 =?utf-8?B?cWRFY2dXU2wxbXdHRWw3ZE1FWHVYRkMvOWY3di9DWlZmWW1lWUNWR3NSRU5L?=
 =?utf-8?B?dzcwMXErZllweFRYeE9XT25BWElwZjAxaU10T3FkYng1WUpuNnV0ZHBjQkxD?=
 =?utf-8?B?ZWpWQjZPeDBlUExFQkhDaFVHcE9FTFlCRmR2TWsvOFcrV3BiS0MwcjdhVCtK?=
 =?utf-8?B?NTRqajk4L0N5ZGhWM2VnNS95T1gzQjRnYm1TdTBJYjN1c09DMk9oRkFucStr?=
 =?utf-8?B?ODFublgzSG0xOHNHT0h0RUNnWWhFanlsR3EvTUxoeFloQnJRWkxIeFlZdWRL?=
 =?utf-8?B?TkZVUHJ6eWk3TG92dDZXR2dJQ013QUNCeDhrMkNNR0Y5NlhaTWFVY0FxYVhj?=
 =?utf-8?B?MHVweFdzRGFnWDRXWW5TbXoyKzIzbllYTjJvVmlLVDJSMnhnaElvUkFlQll6?=
 =?utf-8?B?enVUclhoelp2ZDFKK09yamZtUVpWWkNTYklCSnhqU1poSG92RkpqZFBGQ2Jx?=
 =?utf-8?B?U0dITmdLVE13R0JZZnRPRTMvMGxOQlA5MldlRG0zRm9KeGdUV0IrOFBPZU54?=
 =?utf-8?B?TWU3TGJ4aEFOTVRndW1Qai9JTlJHenhSZFJmQ2JUVjhhaWltdUk0QkhBMzZt?=
 =?utf-8?B?NTV2Y3ArNmFRcEJ3QlJEUDlqR1gvR2QrQlhpNmhoQ3J4N0g0ZitvaTk5ZEpQ?=
 =?utf-8?B?QnFxWHFiR243VWloOC9HUkVOb0g0aWZZUGxnc2c3aXdoY1dBeTlsL3B3U0sv?=
 =?utf-8?B?eDNDd1Q5NDRCZHhheVkxVnBrZXVxazlmbS9MN0w5Yko0eVNJSnhhRVhsSXA5?=
 =?utf-8?B?aFBzTm9uWklIUUpZOXZKVDJaVVllcWZMT1A1c3hJcWpqYmlWMGsvNEVUQitn?=
 =?utf-8?B?b1NsK2VLd0J2aGpIUmp5UkdWTkhKem1FK3MvNHZybkdYL0JzV2FtWVd3S3pF?=
 =?utf-8?B?UmFWTTg1K3hwbDBBTHJDT25FaDFjNXJmMmIza01QNGlXQWs5eDYxZnV3cW4y?=
 =?utf-8?B?UzVpeGNVak5jbzk3M1lYRlRVYWxmaGtjMjJWNEpZZVpoVjVCUTJ1YlY4bFVy?=
 =?utf-8?B?UkF4NGsva0lGNFczTmk0UlBqM2t2TWh4ZGZxeWZHdG1Ca2pzcmk1UWlOT2hl?=
 =?utf-8?B?bmRjK3lkdHp1TkU3alQ4Y3VtTlFlbWx2TW5YclZNVERwZ3VOUlFwODVPa2I4?=
 =?utf-8?B?SjhxZFg2Qk9rdXBtdUx1NmNhQlRLVEhGdnpEcXRmUWsrYUIraTl0N2kyUGJG?=
 =?utf-8?Q?NtXCOB1e8Vx3JiIM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA09748BC63AF24A84BB18051F41700F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96aba4e6-04f1-4224-82d7-08da1c4ee852
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 06:37:25.6157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXBD95MO79TArzCr0/R67gS+zgLlkQpBxRxftyvDVbaMjm69R8iMOZ6wNU/bEu66OkinMygPopjgEYMBr+l4cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6509
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBcHIgMTEsIDIwMjIgYXQgMDk6MTk6MjZQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi80LzExIDE0OjM1LCBIT1JJR1VDSEkgTkFPWUEo5aCA5Y+jIOebtOS5nykg
d3JvdGU6DQo+ID4gT24gVGh1LCBBcHIgMDcsIDIwMjIgYXQgMDk6MDM6NTBQTSArMDgwMCwgTWlh
b2hlIExpbiB3cm90ZToNCj4gPj4gUGFnZVN3YXBDYWNoZSBpcyBvbmx5IHJlbGlhYmxlIHdoZW4g
UGFnZUFub24gaXMgdHJ1ZSBiZWNhdXNlIFBHX3N3YXBjYWNoZQ0KPiA+PiBzZXJ2ZXMgYXMgUEdf
b3duZXJfcHJpdl8xIHdoaWNoIGNhbiBiZSB1c2VkIGJ5IGZzIGlmIGl0J3MgcGFnZWNhY2hlIHBh
Z2UuDQo+ID4+IFNvIHdlIHNob3VsZCB0ZXN0IFBhZ2VBbm9uIHRvIGRpc3Rpbmd1aXNoIHBhZ2Vj
YWNoZSBwYWdlIGZyb20gc3dhcGNhY2hlDQo+ID4+IHBhZ2UgdG8gYXZvaWQgZmFsc2UtcG9zdGl2
ZSBQYWdlU3dhcENhY2hlIHRlc3QuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IE1pYW9oZSBM
aW4gPGxpbm1pYW9oZUBodWF3ZWkuY29tPg0KPiA+PiAtLS0NCj4gPj4gIG1tL21lbW9yeS1mYWls
dXJlLmMgfCAyICstDQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS1mYWlsdXJlLmMgYi9t
bS9tZW1vcnktZmFpbHVyZS5jDQo+ID4+IGluZGV4IGVmNDAyYjQ5MDY2My4uMmU5NzMwMmQ2MmU0
IDEwMDY0NA0KPiA+PiAtLS0gYS9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ID4+ICsrKyBiL21tL21l
bW9yeS1mYWlsdXJlLmMNCj4gPj4gQEAgLTIyNjIsNyArMjI2Miw3IEBAIHN0YXRpYyBpbnQgX19z
b2Z0X29mZmxpbmVfcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSkNCj4gPj4gIAkJcmV0dXJuIDA7DQo+
ID4+ICAJfQ0KPiA+PiAgDQo+ID4+IC0JaWYgKCFQYWdlSHVnZShwYWdlKSAmJiBQYWdlTFJVKHBh
Z2UpICYmICFQYWdlU3dhcENhY2hlKHBhZ2UpKQ0KPiA+PiArCWlmICghUGFnZUh1Z2UocGFnZSkg
JiYgUGFnZUxSVShwYWdlKSAmJiAhUGFnZUFub24ocGFnZSkpDQo+ID4+ICAJCS8qDQo+ID4+ICAJ
CSAqIFRyeSB0byBpbnZhbGlkYXRlIGZpcnN0LiBUaGlzIHNob3VsZCB3b3JrIGZvcg0KPiA+PiAg
CQkgKiBub24gZGlydHkgdW5tYXBwZWQgcGFnZSBjYWNoZSBwYWdlcy4NCj4gPj4gLS0gDQo+ID4g
DQo+ID4gSSBmb3VkbiB0aGF0IHdpdGggdGhpcyBjaGFuZ2UgdGhlIGZvbGxvd2luZyBWTV9CVUdf
T05fRk9MSU8oKSBpcyB0cmlnZ2VyZWQNCj4gPiB3aGVuIGNhbGxpbmcgc29mdC1vZmZsaW5lIGZv
ciBhIHN3YXBjYWNoZS4gIE1heWJlIHdlIG5lZWQgY2hlY2sgYm90aCBvZg0KPiA+IFBhZ2VBbm9u
IGFuZCBQYWdlU3dhcENhY2hlIGluc3RlYWQgb2YgZWl0aGVyPw0KPiA+IA0KPiANCj4gTWFueSB0
aGFua3MgZm9yIHlvdXIgdGVzdCEgVGhpcyBpcyBteSBvdmVybG9vay4gU29ycnkgYWJvdXQgaXQh
IDooIFRoZSByb290IGNhdXNlIGlzIHRoYXQgdGhlIHBhZ2UgaXMNCj4gYWRkZWQgaW50byBzd2Fw
Y2FjaGUgYW5kIGxydSggc28gdGhhdCBpdCBjYW4gcGFzcyB0aGUgSFdQb2lzb25IYW5kbGFibGUg
Y2hlY2spIGJ1dCBwYWdlIGFub24gaXMgbm90DQo+IHNldCB5ZXQgZHVlIHRvIHBhZ2UgbG9jayBp
cyBoZWxkIGJ5IF9fc29mdF9vZmZsaW5lX3BhZ2UuIFNvIHdlIGhhdmUgdGhlIGJlbG93IGNvcmUg
ZHVtcDoNCj4gDQo+IFsgICA0MS4yMzIxNzJdIHBhZ2U6MDAwMDAwMDAzM2Q4YTIwYyByZWZjb3Vu
dDowIG1hcGNvdW50OjAgbWFwcGluZzowMDAwMDAwMGJjMTAzZDg4IGluZGV4OjB4MzZkIHBmbjow
eDE0MzU5Yg0KPiAJCQkJCQkJCQkJXl5eIHBhZ2UgaXMgbm90IGFub24NCj4gDQo+IFsgICA0MS4y
MzY1NzZdIGZsYWdzOiAweDU3ZmZmZmMwMDgwNDE1KGxvY2tlZHx1cHRvZGF0ZXxscnV8b3duZXJf
cHJpdl8xfHN3YXBiYWNrZWR8bm9kZT0xfHpvbmU9MnxsYXN0Y3B1cGlkPTB4MWZmZmZmKQ0KPiAJ
CQkJCQkJCV5eXl5eXl5eXl5eXl5eXl5eXiBwYWdlIGlzIGluIHN3YXBjYWNoZQ0KPiANCj4gSXQg
c2VlbXMgd2UgY2FuIGNoZWNrICFQYWdlQW5vbihwYWdlKSAmJiAhUGFnZVN3YXBDYWNoZShwYWdl
KSwgYXMgeW91IHN1Z2dlc3RlZCwgdG8gZml4IHRoaXMgaXNzdWUuIEJ1dCBtYXliZSBJDQo+IHNo
b3VsZCBkcm9wIHRoaXMgcGF0Y2ggYmVjYXVzZSBpbnZhbGlkYXRlX2lub2RlX3BhZ2Ugd2lsbCBh
bHdheXMgcmV0dXJuIDAgZm9yIFBhZ2VBbm9uIGR1ZSB0byBmb2xpb19tYXBwaW5nID09IE5VTEwu
DQo+IFNvIG5vdGhpbmcgaXMgcmVhbGx5IGRvbmUgZm9yIGFub255bW91cyBwYWdlIGhlcmUuIEFu
ZCB0aGUgb3JpZ2luICFQYWdlU3dhcENhY2hlKHBhZ2UpIGNoZWNrIHNob3VsZCBkbyB0aGUgcmln
aHQgd29yay4NCg0KVGhhbmtzIGZvciBjbGFyaWZpY2F0aW9uLg0KDQo+IE9yIHdlIHNob3VsZG4n
dCBldmVuIHRyeSB0byBjYWxsIGludmFsaWRhdGVfaW5vZGVfcGFnZSB3aXRoIGFub255bW91cyBw
YWdlIGluIHByaW5jaXBsZT8NCg0KSSB0aGluayBqdXN0IGtlZXBpbmcgdGhlIGN1cnJlbnQgYmVo
YXZpb3IgaXMgZmluZSAoYmVjYXVzZSBhcyB5b3Ugc3RhdGVkDQphYm92ZSBpbnZhbGlkYXRlX2lu
b2RlX3BhZ2UoKSBzaW1wbGUgaWdub3JlcyBhbm9ueW1vdXMgcGFnZXMpLg0KDQpUaGFua3MsDQpO
YW95YSBIb3JpZ3VjaGkNCg0KPiBCVFc6IFBhZ2VTd2FwQ2FjaGUgc2hvdWxkIGJlIHJlbGlhYmxl
IGhlcmUgYXMgZm9saW9fdGVzdF9zd2FwYmFja2VkIGlzIGNoZWNrZWQgaW1wbGljaXRseSBpbnNp
ZGUgaXQuIEluIHN1Y2ggY2FzZSwgUEdfc3dhcGNhY2hlDQo+IGNhbid0IHNlcnZlIGFzIFBHX293
bmVyX3ByaXZfMSBhcyBwYWdlY2FjaGUgcGFnZSBzaG91bGRuJ3Qgc2V0IFBHX3N3YXBiYWNrZWQg
KHNobWVtIHdpbGwgc2V0IFBHX3N3YXBiYWNrZWQgYnV0IFBHX293bmVyX3ByaXZfMQ0KPiBpcyBu
b3QgdXNlZCBhbnl3YXkpLiBPciBhbSBJIG1pc3Mgc29tZXRoaW5nIGFnYWluPw==
