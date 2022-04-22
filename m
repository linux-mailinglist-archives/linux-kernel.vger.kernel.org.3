Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EE550B463
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446237AbiDVJvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446226AbiDVJvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:51:32 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A703D48A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vxn8WCNMZ46zCs1vtrQHvMAJCxYpX4iCRa2q1BZjWrzFaFfjZhwbJCLIgx94wD4VNT3LF13uvS3PtC6THDcpJiVlp+iHXo27/RkDqc9M3q/EupancdM0cf0CfC8XBZmNOMqjwY7LDM5dS/cEMG4nPBT6t3YLE+95c0Msrsp6wdfnA3YZYtwChTRCJSujUNSTQTPSKs2sDatoaaUdEtDpfDNb1CB49IhGiuyvnX37kDNGfGH030O05HYkVS1NMK/n1I1p9bGvWy4UGPxGKQEUgcAVZ4Ss7KlE0RYnOaOnr/BKU/nhggv0f/o9EfKVyKLxGGBc4vBEWSAPyWR3AdSiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioUfIbzT/QfTJNkARhNkYZvbmIsMG81nESq1Q18V//Q=;
 b=ahsnL42xPMPGQMshS0w5nUyUNROdsJXi0fkZBzM/seFs1FRm+wv4QXtgP3UZexnGL+d6jLWarO1d4ozIGpe7gy5qgXLxShSeFVjGAtP2r3lUAsNeB/5afFcBUqvOaySvesTngF8QKULZwMTHDfVGUaewjj+WkEDDl04P8kKCIDFM2yxXzJz0EI31XD+puN6q7zrI13L16vnD63ieVGox+gvjPeqbwbl/UfnoTBoc1trfWlUVUb3SevHjssOz6q2rtGneCPPpGZT79QTRgyoMxD8Z8yk/eemWxIR63FHR3eYQJc/2B9bZ3caPwNjKM4zDRZKCIEeDn9IYswZnbL7oeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioUfIbzT/QfTJNkARhNkYZvbmIsMG81nESq1Q18V//Q=;
 b=VNw7LCAGdEvc0Bb2n5we9krgasdUq1LMB2SNXJdGy2nebEdgxHLKC8viKp4Q5Zqzlh01ojL8YuDYyZeidjfsR+e4zGsb0xNRpJl/NkgMT3t7AMi0+ZZNf5fkeulmFP/+itxIAqWskFyfDNa7YQNT0ga+PYBiu1mPlHhQaF56xuc=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by HK0PR06MB2884.apcprd06.prod.outlook.com (2603:1096:203:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Fri, 22 Apr
 2022 09:48:35 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 09:48:35 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] arch_topology: support for describing cache topology from
 DT
Thread-Topic: [PATCH 1/2] arch_topology: support for describing cache topology
 from DT
Thread-Index: AQHYVY/3mu3UZIAptEGl2hWuURgvFaz7qdSAgAAEIGo=
Date:   Fri, 22 Apr 2022 09:48:34 +0000
Message-ID: <SL2PR06MB308222752B34227A070D4C29BDF79@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1650552960-60165-1-git-send-email-wangqing@vivo.com>
 <1650552960-60165-2-git-send-email-wangqing@vivo.com>
 <20220422092225.ezmaqxloujdw5bqg@bogus>
In-Reply-To: <20220422092225.ezmaqxloujdw5bqg@bogus>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2632e28b-5c05-489c-fcc5-08da244544b2
x-ms-traffictypediagnostic: HK0PR06MB2884:EE_
x-microsoft-antispam-prvs: <HK0PR06MB2884CF99634F44923FDD9453BDF79@HK0PR06MB2884.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qYGjqds9KaTjQ0HxBLNlJaxMgKPQfwlbY5N0lOOlkY2/DWi8kFHbfRWjZEKoCSDEip98D2qWILCekK3kDurv1HEeFq3L9Tk+rSdGrqlI4CSjsClDvVmFUlaY/6KlxjiIe5ypGPnRv1Y/8OLNQI9+KLC8XqmCgkzA9GMOwD32ksmx76objWOhfw+HItWTqNOQsaFZ9arFGyz6gn/LVHRJDwLHrw4BjMyoxn0CoFvQS/r6yUCTV36XyANOdlsQ56AECfPTWFI6xP+Eg4cITj9rvHjJWshyVoUSupYvyw3P0i3VBqfGHedW54BVRkJ1V9f39C1nXQUghQ63ikXu55W+k2iUFj3Rk07L/aqnRojdns9Vy+LLAXVDE2ZG1gdzqMCo+RbU3duzDA7uLCR4kr/Pa4OwwMpGmSLpXS79gOG04420KMO3VcmzGYMSPccEZDLgd4n51XRA5CbPQfFlAL0wWD+ll7cyaEHpwFM7OqLvwW98dNPJpXwy3OeoAl+HuIviScY+SWcfZouO5fq/vOFQsx0rfvpHJp/FgajoRrMvCK/GSy9DxposQWM1ugNipYLOk3iV24UDJg7sfcxJAlpbaQ56rsZbD7slQ8g6nd2WQWTETSsc09SxnfLyD+LUUDtCwlZ2FSIZZG4Pocxbwes4jV3F3vlLw7Vt1qk+GYyTmSZ79sN2p8AIAO4jsAfz8ssgOYB65VKMSZIiHF0mdLu5KA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(186003)(66556008)(91956017)(64756008)(66476007)(8676002)(66946007)(5660300002)(76116006)(8936002)(6916009)(122000001)(54906003)(316002)(38100700002)(33656002)(55016003)(38070700005)(52536014)(86362001)(4326008)(6506007)(508600001)(26005)(66446008)(9686003)(7696005)(85182001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzE5ZWt5cXNIbmdDRUhGRVdicnVEaGl0Nm5Wcnl3NmNDSVFXTDRKdXcybEIw?=
 =?utf-8?B?SlRaUzNEcDAxYUF2UGZLQUFoNk8rRytwY2J0QWloSW80aFpCQVRtaEx5dFlv?=
 =?utf-8?B?aUQvcktVL1BoajNGWWtoZStDU1FxNUJrTVJoUTFaOVA0dzd5MEY0RkQydy8y?=
 =?utf-8?B?ZENHMzFvZzF6MHI5L2J3U3NKNWw4dCtCUGVHZzZPSHJiQmUwbmxja25QYTBt?=
 =?utf-8?B?UmxYU0FUa1h6OTVXalV6b2c1M0VmTVU4SWE3Qkp0RlNTSGlwdVFGaFhOQjho?=
 =?utf-8?B?M1YwU282YVFoY3JrZTZyL3JYZzA0a0llODZRT0txdUlYeWhjUWVCeVBHWEdL?=
 =?utf-8?B?d3VCQnhJcEVCZ25mRnhZNFZzcDRtWG1kRFU2VDBYTzRiTTZvNXdWbU1rUFdV?=
 =?utf-8?B?ekoxbEhhNG9RRDhmQ2h5clVkS05UbWxKYlV4UEQrdWZraUlvNzBrNkhiRUsx?=
 =?utf-8?B?eTZMaTIwK3JFOHlqNDVYc3BkazNMcjVDenJYSjJZYlJsV1J3Z0s0eExwTGpY?=
 =?utf-8?B?elhsdmhPTXNFZklVU0JIQ284RzFTQVBtVXlrcjZBbFllVTR0L09yZHhqanZM?=
 =?utf-8?B?TExub2hmdnBpVk9Rbk5lZ0ZmeUNpTGlVWXJYa1QyNllNSGFtRktjUE1uKzlO?=
 =?utf-8?B?YllRTUd6ZWhBWXppM3QxYVM4SWh6b0J6eW9rMldHOHp0dnB0Y2JwK2RiQzQ0?=
 =?utf-8?B?RkdxbXBNNW4wbmhlS3owYlFFNWNzRVFPeThBcjhFS2IweXhOWTFlVkExU2lL?=
 =?utf-8?B?UFN2a3dKckFEZ2owdndiRFlQV21rMkxKbG1iYkxCemVzZFptTm5wZ2tiT29C?=
 =?utf-8?B?L2lyN21oOTkwTEdpNDdCcHppank2alc3R2hKVjJybTVMTm9WYXRFUEgzVGdI?=
 =?utf-8?B?anE2VVJTeElRbzFDWmZVRVM2SENqbUFGYnY0aFo4WjVqWDdYVk9oNCtpblVQ?=
 =?utf-8?B?MVl4b005NS8zbEt5S3F1cGZzYkg5NGhFM1ZvODM1Y3hhSVJEZUh2K3l5dXVr?=
 =?utf-8?B?Zlk4RkE0WkwzMytNTENMMDdwWEJxQXhFTlpkdm5SOHA4ZkhDTXZ1TVhCQWp6?=
 =?utf-8?B?OTdLQWZpUjl0N3lqa2ZlMEtBejFtcTZwTlhLWnF2Q1ZzbTN5OUdvMWNWQkk3?=
 =?utf-8?B?V29ISnRWUkdVZzZld2c4c0Z2NlRIZ0hCL3VTTDU1RE5SMG5YcWN5dXVOVmxI?=
 =?utf-8?B?aTdiR0YwaFRNMno5eTNjMi9aN2h4WlJOSGxxY2VEVURCTHhEb3ZsR3BJWHhy?=
 =?utf-8?B?UXBhUG45SDNFNUZveUZRVHlQWmZTWkNNNHVlMVkwVTVZb3FuWG5QNmY2NmF0?=
 =?utf-8?B?TWNxQUlNZUtEdU1aZWFUUDFRb1lTOSs3cUQ1V0FqcHdST04yM2FMUUlTMmN1?=
 =?utf-8?B?cENtemswZm4yYWl1SmRtcDc5UjRXTngrWGxGUkJoUGc5cmpUYXRjS0toeVFt?=
 =?utf-8?B?MzRObGVPK0RUMDdaU0R3Z0x0aGNDdjZGNUZEeHBHM1JwSlBIbjliTmpORk9q?=
 =?utf-8?B?OEVOTU9RWXFvNE9LaGt1U2ZhTDZ1a2prVzhOODFrNlhPbHFjMTA3WUV4WVlE?=
 =?utf-8?B?NnNDYUNBVHFKWVVlOFVaSHgzeS9jUWt6blNoeXVxOWJWT1lMQUFDSDNlYm9n?=
 =?utf-8?B?UVFOZXhwWHU0NUNETE9Qd2xyclZNMVlWR3pFRHhqeWZ3R3hLT1VEem9ZT3ll?=
 =?utf-8?B?QzEyYm1ENFRYeGM1OE1GN0lKWlQvc3JabDBFcXpnMEpxeWxJZjViMjM1dWZp?=
 =?utf-8?B?SklnRnAvYkd3MW9BWVFSYTJBTk5SdmRRU0svdVk0RzBmNk1FNkFwWXRMV253?=
 =?utf-8?B?dHd3K3VTQlczTFZhTHA5Z201NGNhVXl6UmROWEhRL2t1a3pFQ0Nwb2V6aDNK?=
 =?utf-8?B?dnRxYVlOdHk1OVRialNjMlppYmxaZTNDcGxDekM0OXdTanVaSHRFNjlWdEhM?=
 =?utf-8?B?NFNUY00xbm5MUWRjM25mbURhMThoMEtsSEFsOEVZMWU3RDZVVVExV3dqSkFH?=
 =?utf-8?B?TUk5Rk1jVStuOU5nblJNS2ZBbm1KbXI3WW9EaFE4Z1pzOGgzc3FjZE5jZEE5?=
 =?utf-8?B?WjdHOGVPc2Y0YTVYRmg2MUhCUHlNZ0g3MEpENmpNOSt3SDkwWkJUSTdEbWVT?=
 =?utf-8?B?VUo4ckIzenQ5UG9kaTBUT0xMR3owZFU1ZDlhNk5kNUFBT08xRFpSeDl4WXB2?=
 =?utf-8?B?NXkzNlc4V3NUL25BdUNxQmVzOEYxSldMSFo3aFlxMnJHQ3BkZnh0V3lIcG1z?=
 =?utf-8?B?YXR1VGZudGFKbEFkbVUxR2REOW9Za1ZYa0NOU2NqT2l0SGo5d1I1TXhkOFJx?=
 =?utf-8?Q?xy1II6XauQEKz7EWeD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2632e28b-5c05-489c-fcc5-08da244544b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 09:48:34.9801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xppNDESiugLEezVyKjlxASzw3cJXUra85vFoQdmONG45ILo8gaOyQnukNIDPhJpD3sgsCsjwUj5ozBZnsDH/9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2884
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PsKgCj5PbiBUaHUsIEFwciAyMSwgMjAyMiBhdCAwNzo1NTo1N0FNIC0wNzAwLCBRaW5nIFdhbmcg
d3JvdGU6Cj4+IEZyb206IFdhbmcgUWluZyA8d2FuZ3FpbmdAdml2by5jb20+Cj4+IAo+PiBXaGVu
IEFDUEkgaXMgbm90IGVuYWJsZWQsIHdlIGNhbiBnZXQgY2FjaGUgdG9wb2xvcHkgZnJvbSBEVCBs
aWtlOgo+PiAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdTA6IGNwdUAwMDAgewo+PiAqwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXh0LWxldmVsLWNhY2hlID0g
PCZMMl8xPjsKPj4gKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTDJf
MTogbDItY2FjaGUgewo+PiAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gImNhY2hlIjsKPj4gKsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5leHQtbGV2ZWwt
Y2FjaGUgPSA8JkwzXzE+Owo+PiAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIH07Cj4+ICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEwz
XzE6IGwzLWNhY2hlIHsKPj4gKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJjYWNoZSI7Cj4+ICrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPj4gKsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9Owo+PiAqCj4+ICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1MTogY3B1QDAw
MSB7Cj4+ICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5leHQtbGV2
ZWwtY2FjaGUgPSA8JkwyXzE+Owo+PiAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4+ICrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLi4uCj4+ICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fTsKPj4gY2FjaGVfdG9wb2xvZ3kgaG9sZCB0aGUgcG9pbnRlciBkZXNjcmliaW5nICJuZXh0LWxl
dmVsLWNhY2hlIiwKPj4gaXQgY2FuIGRlc2NyaWJlIHRoZSBjYWNoZSB0b3BvbG9neSBvZiBldmVy
eSBsZXZlbC4KPgo+QXMgSSBtZW50aW9uZWQgYmVmb3JlLCBJIHdvdWxkIGxpa2UgdG8gYXZvaWQg
YW55IGR1cGxpY2F0aW9uIGFuZCBzZWUKPndoYXQgY2FuIGJlIHJldXNlZCBmcm9tIGRyaXZlcnMv
YmFzZS9jYWNoZWluZm8uYwoKSSB0cmllZCwgYnV0IGNhY2hlaW5mbyBpbml0aWFsaXphdGlvbiBp
cyB0b28gbGF0ZSwgCndlIGNhbiBkaXNjdXNzIHRoaXMgcGFydCBhZnRlciAyLzIgaXMgYXBwcm92
ZWQuCgo+Cj5XZSBjYW4gZGlzY3VzcyBhbmQgc2VlIGhvdyB0byBwcm9jZWVkIG9uIHRoYXQgb25j
ZSB3ZSBzZXR0bGUvYWdyZWUgb24KPjIvMi4gSSBkb24ndCB3YW50IHRvIHdhc3RlIHlvdXIgb3Ig
bXkgdGltZSBpZiB3ZSBkb24ndCBlbmQgdXAgdXNpbmcgdGhpcy4KPlNvIGxldCB1cyBsb29rIGF0
IHRoaXMgb25jZSB3ZSBhZ3JlZSB0byBwdXNoIHRoZSBzY2hlZCByZWxhdGVkIGNoYW5nZXMKPmFz
IHdlIGhhdmUgdXNlZCBnZW5lcmljIG9uZXMgc28gZmFyIGFuZCB5b3Ugd2FudCB0byBpbnRyb2R1
Y2UgYXJtNjQgc3BlY2lmaWMKPmxldmVscy4gVGhhdCByZXF1aXJlcyBzb21lIGRpc2N1c3Npb25z
IGFuZCB0aG91Z2h0cyBiZWZvcmUgd2UgY2FuIGZpbmFsaXNlLgo+Cj5BbHNvIEkgaGF2ZSBtZW50
aW9uZWQgeW91IHRvIGtlZXAgRGlldG1hciBhbmQgVmluY2VudCBpbiBjYyBmb3IgYWxsIHNjaGVk
Cj5yZWxhdGVkIGNoYW5nZXMgd2hpY2ggeW91IGZhaWxlZCB0byBkbyBhZ2Fpbi4gSSBleHBlY3Qg
eW91IGZpeCB0aGF0IG5leHQKPnRpbWUgaWYgeW91IHdhbnQgdGhlbSB0byBoZWxwIHlvdSBpbiBk
aXNjdXNzaW9ucyBhbmQgbWFrZSBhbnkgcHJvZ3Jlc3Mgb24KPnRoaXMuIE90aGVyd2lzZSBpdCBt
YXkgZ2V0IGlnbm9yZWQgYXMgeW91IGRvbid0IGhhdmUgYWxsIHRoZSByaWdodAo+cGVvcGxlIGlu
IGNjLgoKSSBmb3VuZCB0aGlzLCBhbmQgaGF2ZSBmb3J3YXJkZWQgaXQgdG8gRGlldG1hciBhbmQg
VmluY2VudCwgCkkgZGVmaW5pdGVseSB3aWxsIGZpeCB0aGF0IG5leHQgdGltZS4KClRoYW5rcywK
UWluZwo+Cj4tLQo+UmVnYXJkcywKPlN1ZGVlcA==
