Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D8C53B2E4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 07:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiFBFNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 01:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiFBFNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 01:13:40 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2046.outbound.protection.outlook.com [40.107.114.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD3B41626
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 22:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1TGrwO3dNpvHut89psm4AAfB/uLOP+0/EGUu9S8DB5qohLaRdYdeAbUgLsKeD/HMXgwjV+RD0UsI8P7JipTMtD4oYE0halcfWCn/ymxqH+CDkWbBS+gO0HafLskhgN1B5Z6LmZD8Im7dRhS/SmairQCVUcyvHyY1AvvWkmuKkjlGvLK9HGYgOI8F8dZ1/efXEWjzhi8rNF48KK3KPIkZABl3gyss37lhTXenW9kbhawN9inO1k0ZvLifUprTDTw1xPxb/RQ+TPqC0KXOc/d/+sZDS1TJQeiiRxBgMY2jpxKIHFpVCGu+tRxnB+n6485O4J10sULKtt35tE+h7mXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UhHJGXSlNEy4IPUUk9Tujk31QcOEbj0vg2QcSgJVgA=;
 b=C0jA2LRJmwRH86z77yW0PWvP/Xpi+IpFQRj+DmwMI4xnz4/6kFpLrlkZbvSp1hkY+LMeLt9Y2NOjBPT5gZGBwHmVJjYK+D13zm+L/tP1knvMw+c/5GOg7viYgWLsxvSAAUOhseTqIo8Tk1ECqkP/SksDLStvBFJZaBB69Ez5oRWoFgFwWjQW54/XZFXC/ZVRk2K0AM4dMoyQyssRlCfy5OzBob6XJ0bhk9h12pkiGswHVhsTshRYFJxutvS/kdlXGV6sIH3Mu7awYQjvIqpc1NpPoLJtPSU2hbqqhQExP/M2tqmpVgzWE4dOSJPziHVnK+qX/3MbilMyHXwqH7E6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UhHJGXSlNEy4IPUUk9Tujk31QcOEbj0vg2QcSgJVgA=;
 b=ejdfpSCJt2BNiFbsoW6DaqcdJoYGaKJhmpYjsV7x925BvXPBgT0M8X35WG1ISM3SkEtzaboVJCNoKtEfCKjg52WPus7eeiG/IAoNlOAZosiX5LJSfxKYXinxePzIf6CA1mqgSnfax80nkSbKHFolwpq9lkw0H7JPIBA2pF9C+6A=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB3205.jpnprd01.prod.outlook.com (2603:1096:604:1f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 05:13:33 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995%2]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 05:13:33 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Liu Shixin <liushixin2@huawei.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question about hwpoison handling of 1GB hugepage
Thread-Topic: Question about hwpoison handling of 1GB hugepage
Thread-Index: AQHYRO39spkM6Er2D0SYmGhvNd4geaze3zIAgERjEICAAoEwgIAWMbMA
Date:   Thu, 2 Jun 2022 05:13:33 +0000
Message-ID: <20220602051332.GA1172281@hori.linux.bs1.fc.nec.co.jp>
References: <0af88a11-4dfe-9a4e-7b94-08f12caafcf3@huawei.com>
 <20220403234250.GA2217943@hori.linux.bs1.fc.nec.co.jp>
 <eae3ec5d-51ce-db2d-cc0b-f8e1d4310679@huawei.com>
 <20220519021757.GA520829@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20220519021757.GA520829@hori.linux.bs1.fc.nec.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5f68675-ac7c-4dce-10f0-08da4456a3bd
x-ms-traffictypediagnostic: OSBPR01MB3205:EE_
x-microsoft-antispam-prvs: <OSBPR01MB3205844F76E95A218CF7B7DEE7DE9@OSBPR01MB3205.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HUrb3PQiaO3qV/XPJasLqHqo3acfUGx6H1amca2Vv7/BNhMJtlsWGaihXA7kMNk2VQZDGECHYHepuAF15qYcySRDBRzlLjycBk1brpBzRNbCR2J6kbNS3DHBVuf2SBQUqudvYaIutDLiLKdhHKxj1mAh7iMl7FNPZuTzzAEPHViX91dT8RPNW+oQ+8pDq2oyENAMzTUAT76vvV5PDOe6qtVVy8znF2asxPkk/26ZFB3BN4NMWzT1xwWlEJWGRY8WIiHemHpc2yMOsrCTlJzLwkAgX4x1lyQGwexvrugxlPutcqCWnNpCs+K5BUvi+YiZpZpPnKNUEqseY94FNVFEfsPeBFzyPYZ5ZcayOWwHYFNSPe3UIIdpDIJjAEHbIkX7TVHlkoBcsYl9xX0bpsekxfXt1ZWfU1jv0R9pTi5SXh/2TxI1ro3vcaOGBnhOsfwxXyHRfloFKqVyujTlenU1VUCIsn43uYCr1W0RzbnMOpPX6eRp6e5c5UreDCw/OFtV8ZVBZUf8kSTYElI3IQCia0b4dUfblBzmcarayhEZXMOmsXfJESTj4+g2zqWb4DBNxy//3EfYtGGiG3FE4vmbJojcEGfZ0vk54dfrwnCYFyPEnru/bfihEJlPAjWR2CRf1esbiS5V9MMaJeLr6ve4/HBPX47OMfrcB/ChYi4Si86bosaSsSq0WgXdxweH4+ya6dPfMFOv7L8Kl34mkBbf6onoPLrQep0fn0KgvPMnSIT4eimoYSrXxTPXSS6qC0KmKckYtcshwrbcP0o5sfvHc/zHVHMwv9uuH9tAUTG57PA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(38070700005)(66476007)(66946007)(76116006)(66556008)(64756008)(66446008)(4326008)(8676002)(508600001)(83380400001)(26005)(6916009)(316002)(9686003)(55236004)(53546011)(54906003)(6512007)(86362001)(1076003)(6506007)(186003)(6486002)(71200400001)(2906002)(122000001)(82960400001)(85182001)(38100700002)(5660300002)(8936002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXhvRjJCWUxoaVNocUF2cFJNM2U3Vi9PK0NuY1JTYTc3dURReU16czdjKzhz?=
 =?utf-8?B?Uk1nWldHY2xpOVp2V3Q0Y2JhaVRzYkFQUHBJYVNjcVJuTUw1Vno4QU9QMzFa?=
 =?utf-8?B?QlBXM2VHaXdaZkhmMTRMR3Jvc2cwUUsxSktNdHJjMzRsRkgrSEltTys2Zyt2?=
 =?utf-8?B?N3JvZm1obnFZT2dOZTlhSkRUWDc5czZRR0FvQTFZVkVQZHZRRWtGZGNvMEVV?=
 =?utf-8?B?SmJRSmpBTkVUa2pRZ2ZoWGlSRmcvc1BxSzlmL2MwVDc0QzgrWWo0Y0I0RnA0?=
 =?utf-8?B?MG0xNUtPSU9IYmw1dVY1VndzQy9mQ01ZOHdHaDZaN1VsMXRETkhEUUQ2ekM4?=
 =?utf-8?B?K1paTGpMWmpLMzRKUVNmMUpsQnBiWWtzd2cwYXM4dmFFNlJpdWZsRTFzbG5j?=
 =?utf-8?B?L3p3ekZxUGh0aXJKazl1VU5ObG9PNmUxTmR1QkR6SjJzMldYeEFvVTVwK0ZF?=
 =?utf-8?B?YTk2R3p0blJLejFtakxVUmp6N2pNaDkxMVU0WEtRczBnbXl4aXhUdlB5dVll?=
 =?utf-8?B?UVZyc3B0czY3ZCtUQ3kwNXdQcm5KYnFRdlhQQUxncEJLZUJsN1lUY2EzcjdW?=
 =?utf-8?B?NitVZlE2VnBVQ1FCVDRuc1lneXAzanRXLzFDSnlWZ1JaMnB1NWlaZklHUUdI?=
 =?utf-8?B?YVlCZVkwV1oyRUZVcGhxU245MzBJWHMxdWNvanFkN3djUnBTakdJNFNCd2o5?=
 =?utf-8?B?UHFDeWIxSitLbkhjbWp1TzNMSFdtS1FEMHRpdTRFV1NQbGVQNk9vank2VVdZ?=
 =?utf-8?B?ZEkxOHNkNFpTazJrRGcxVmR2Q1RDRmhhUzZBWWEyMWEvT2h6Z0tPQ3ZsL0ZD?=
 =?utf-8?B?bXd3RFRUK3V6cnEvZ2k0UUdoNzFiSzVKa2pHOFZCUWNzQlJnd08va2szK2Rl?=
 =?utf-8?B?elVCTCtON2xzQWFTOU1zR25sTTFmRFhBYmNKY2RCWjIydSs0S2xnS0ZhTTFv?=
 =?utf-8?B?eGJhRXc3ZXk4MmVYaDUyZ1J6ekxxTkNtSk05TVRpSmM1MEpLT3hidDBSTVdF?=
 =?utf-8?B?T3F2REtaQnc4S01UdFMzTFplRkxuYnpvaWJCNVZiU3MvUjZ5dkxUN0NmaWZP?=
 =?utf-8?B?SEJiT29Ubjd5UGN6UWNUeXhyZmpZQkRMaWlMb2ZyWmxnOVUrVEk4WC83ejhj?=
 =?utf-8?B?R09Md20ydzg3dHZ6NUxXR0M3YW1DUlVXcWZjb09IcExPeC9mRVdMY1RsdldE?=
 =?utf-8?B?VVcxREVWcVlra3dRSFBaSmdEMkhULzd2Ni82WXp4YzVnbGVrOVA1MXd0Ully?=
 =?utf-8?B?M3dKOXNhWTdUay9pNkpoMWRiT09oc3ZueVlhdDAxUTMxcGduV0JWV3FMeFNH?=
 =?utf-8?B?bVZrNmRMVldYUk5MVDZrOXZXTTdpcXUyNWQ2Zmx4dEtsT29IbVRSbXpjUmQy?=
 =?utf-8?B?NUJwYVE5Q2tFRDBIL1VGZHc3YVFWNTFRcVdDa2lGR1NPcERqVXVScGNvelFQ?=
 =?utf-8?B?aFc3Y1M2MFNKbmNJNzlld2tUbFRtREQ5Uk54WUs3NTdJQmRkb2thQk1VbSth?=
 =?utf-8?B?amlCMVU4RFd4VWRLbm56aXgwWitURWtpZE1jZENqektWdTdEb3FLZTczWkd0?=
 =?utf-8?B?SkFTQjgwTWNaT2pLSUZPdDViVEk3U2VxeGd0ZlkwcDM5Si9mUmU4bS9pRU1J?=
 =?utf-8?B?OTA5Z2VuNHdrcXFMUjZBSlZ0dWMyRkFweHpOanBkS2Y1YUFvWHZERG9BblpJ?=
 =?utf-8?B?dnpFVUZxaXpsblFFVVRFcGYvdUI1ZnNhNEZPZWRWMkZzbnJhRHBhN3ZYNWdj?=
 =?utf-8?B?Wldtall3WFVpWnZDRGNsejVXc21WSkNKSEVVME5uTWl6QnpORlNtU001MzZx?=
 =?utf-8?B?cDZxQnV0a08ySkYxaTlYQkdZSitJcUxiZ3QvNmRiOW9VVFZCcWZCZml1cHk5?=
 =?utf-8?B?K3N3RVdwTGlFTDV5U1U0dFBJK3liOVlvbjcvTnF6TUxud1BuWnh0UUdnUVdq?=
 =?utf-8?B?b2lRYjU3RjhnenZYWml0b2M0UG5ya0JZUEhuWGFPZ1ZKUXYyQ1I5VW9BeFJC?=
 =?utf-8?B?aXYyeFVzSGlSdjI0UzRaL3F2NVpJS2kxT0haUlF4QTF0V2J5VksxWHkrTUli?=
 =?utf-8?B?ZW5oaWx4ZExxckFDcFU0UGZlV3kwTE9FZDFmc2wxODg1WDBiQ1FtREdFZGEw?=
 =?utf-8?B?RjZoclBuaHU3N0hZck5OTmhVUndRUTVXWHN1Z0hoZUc1NStvS0czZnVkeTRP?=
 =?utf-8?B?T2hrQk0zdkllMVF4OTdIYTVWSzlxZjNDNnpYWFoxYS9uZ3VQK2MxU2E3K0hM?=
 =?utf-8?B?ajBWRzBpS1lET0cxVUlNK2d0ZDZ3RTR3WU1mL3FrZzZ1emNCRDhDaWliOUla?=
 =?utf-8?B?OG5wQ25WWmVrODdFL2ZoK2gwUGZ2dEpnZVgvUDVUMnMyU2tJN0Y5YklwdEVF?=
 =?utf-8?Q?lsQs/rL1BtdZpFCk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1FBABE61972AD44A6E8D78B5539D4EC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f68675-ac7c-4dce-10f0-08da4456a3bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 05:13:33.0830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V1ZlIHKeHh+P3ypXVf3GNGjT3/vPJWjS0EA0pZS75a/RQ5SsXWJvHokrJOAK4M+K3yLzdzwPBaCst9HdN+oT2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXkgMTksIDIwMjIgYXQgMDI6MTc6NThBTSArMDAwMCwgSE9SSUdVQ0hJIE5BT1lB
KOWggOWPoyDnm7TkuZ8pIHdyb3RlOg0KPiBPbiBUdWUsIE1heSAxNywgMjAyMiBhdCAwODowMzow
M1BNICswODAwLCBMaXUgU2hpeGluIHdyb3RlOg0KPiA+IEhlbGxvIE5hb3lhLA0KPiA+IA0KPiA+
IElzIHRoZXJlIGFueSBwcm9ncmVzcyBvbiBtZW1vcnkgZXJyb3IgaGFuZGxpbmcgb24gMUdCIGh1
Z2VwYWdlIDogKQ0KPiANCj4gSGkgU2hpeGluLA0KPiANCj4gSSBoYXZlIGEgbGl0dGxlIC4uLiwg
SSBmb3VuZCB0aGF0IGVycm9yIGhhbmRsaW5nIGZhaWxzIGZvciBhbm9ueW1vdXMgMUdCDQo+IGh1
Z2VwYWdlIGJlY2F1c2UgX19wYWdlX2hhbmRsZV9wb2lzb24oKSBmYWlscy4gIEkgZG9uJ3QgcGlu
cG9pbnQgdGhlIGlzc3VlDQo+IHByZWNpc2VseSB5ZXQsIGJ1dCBJIGZlZWwgdGhhdCB0aGVyZSdz
IHNvbWUgaXNzdWUgaW4gZnJlZV9naWdhbnRpY19wYWdlKCkNCj4gdGhhdCBmYWlscyB0byBzZW5k
IHRoZSB2aWN0aW0gcmF3IHBhZ2UgdG8gYnVkZHkuICBJIGRvbid0IHRoaW5rIHRoYXQgdGhpcyBp
cw0KPiBhbiBjcml0aWNhbCBpc3N1ZSBiZWNhdXNlIHRoZSBlcnJvciBwYWdlIHNob3VsZCBub3Qg
YmUgcmV1c2VkIChpdCdzIGlzb2xhdGVkDQo+IGJ1dCBub3QgaW4gY29udHJvbGxlZCBtYW5uZXIp
LiAgVGhpcyBwcmV2ZW50cyB1bnBvaXNvbmluZyBhbmQgbWFrZSB0ZXN0aW5nDQo+IGluZWZmaWNp
ZW50LCBzbyBJJ2QgbGlrZSB0byBmaXguDQoNCkkgcG9zdGVkIGEgcGF0Y2hzZXQgZW5hYmxpbmcg
MUdCIGh1Z2VwYWdlIHN1cHBvcnQsDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbS8y
MDIyMDYwMjA1MDYzMS43NzE0MTQtMS1uYW95YS5ob3JpZ3VjaGlAbGludXguZGV2L1QvI3UNCg0K
SXQgcGFzc2VkIG15IHRlc3RpbmcgYnV0IEkgYXBwcmVjaWF0ZSBpdCBpZiB5b3UgdHJ5IHRlc3Rp
bmcgaXQNCmluIHlvdXIgd29ya2xvYWQuDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ0KDQo+
IA0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBMaXUgU2hpeGluDQo+ID4gDQo+ID4gT24gMjAyMi80
LzQgNzo0MiwgSE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nykgd3JvdGU6DQo+ID4gPiBP
biBUaHUsIE1hciAzMSwgMjAyMiBhdCAwNjo1NjoyNVBNICswODAwLCBMaXUgU2hpeGluIHdyb3Rl
Og0KPiA+ID4+IEhpLA0KPiA+ID4+DQo+ID4gPj4gUmVjZW50bHksIEkgZm91bmQgYSBwcm9ibGVt
IHdpdGggaHdwb2lzb24gMUdCIGh1Z2VwYWdlLg0KPiA+ID4+IEkgY3JlYXRlZCBhIHByb2Nlc3Mg
YW5kIG1hcHBlZCAxR0IgaHVnZXBhZ2UuIFRoaXMgcHJvY2VzcyB3aWxsIHRoZW4gZm9yayBhDQo+
ID4gPj4gY2hpbGQgcHJvY2VzcyBhbmQgd3JpdGUvcmVhZCB0aGlzIDFHQiBodWdlcGFnZS4gVGhl
biBJIGluamVjdCBod3BvaXNvbiBpbnRvDQo+ID4gPj4gdGhpcyAxR0IgaHVnZXBhZ2UuIFRoZSBj
aGlsZCBwcm9jZXNzIHRyaWdnZXJzIHRoZSBtZW1vcnkgZmFpbHVyZSBhbmQgaXMNCj4gPiA+PiBi
ZWluZyBraWxsZWQgYXMgZXhwZWN0ZWQuIEFmdGVyIHRoaXMsIHRoZSBwYXJlbnQgcHJvY2VzcyB3
aWxsIHRyeSB0byBmb3JrIGENCj4gPiA+PiBuZXcgY2hpbGQgcHJvY2VzcyBhbmQgZG8gdGhlIHNh
bWUgdGhpbmcuIEl0IGlzIGtpbGxlZCBhZ2FpbiBhbmQgZmluYWxseSBpdA0KPiA+ID4+IGdvZXMg
aW50byBzdWNoIGFuIGluZmluaXRlIGxvb3AuIEkgZm91bmQgdGhpcyB3YXMgY2F1c2VkIGJ5DQo+
ID4gPj4gY29tbWl0IDMxMjg2YTg0ODRhOCAoIm1tOiBod3BvaXNvbjogZGlzYWJsZSBtZW1vcnkg
ZXJyb3IgaGFuZGxpbmcgb24gMUdCIGh1Z2VwYWdlIikNCj4gPiA+IEhlbGxvIFNoaXhpbiwNCj4g
PiA+DQo+ID4gPiBJdCdzIGxpdHRsZSB1bmNsZWFyIHRvIG1lIGFib3V0IHdoYXQgYmVoYXZpb3Ig
eW91IGFyZSBleHBlY3RpbmcgYW5kDQo+ID4gPiB3aGF0IHRoZSBpbmZpbml0ZSBsb29wIHJlcGVh
dHMsIGNvdWxkIHlvdSBleHBsYWluIGxpdHRsZSBtb3JlIGFib3V0IHRoZW0/DQo+ID4gPiAoSSBi
cmllZmx5IHRyaWVkIHRvIHJlcHJvZHVjZSBpdCwgYnV0IGRpZG4ndCBtYWtlIGl0Li4uKQ0KPiA+
ID4NCj4gPiA+PiBJdCBsb29rcyBsaWtlIHRoZXJlIGlzIGEgYnVnIGZvciBod3BvaXNvbiAxR0Ig
aHVnZXBhZ2Ugc28gSSB0cnkgdG8gcmVwcm9kdWNlDQo+ID4gPj4gdGhlIGJ1ZyBkZXNjcmliZWQu
IEFmdGVyIHRyeWluZyB0byByZXZlcnQgdGhlIHBhdGNoIGluIGFuIGVhcmxpZXIgdmVyc2lvbiBv
Zg0KPiA+ID4+IHRoZSBrZXJuZWwsIEkgcmVwcm9kdWNlIHRoZSBidWcgZGVzY3JpYmVkLiBUaGVu
IEkgdHJ5IHRvIHJldmVydCB0aGUgcGF0Y2ggaW4NCj4gPiA+PiBsYXRlc3QgdmVyc2lvbiwgYW5k
IGZpbmQgdGhlIGJ1ZyBpcyBubyBsb25nZXIgcmVwcm9kdWNlZC4NCj4gPiA+Pg0KPiA+ID4+IEkg
Y29tcGFyZSB0aGUgY29kZSBwYXRocyBvZiAxIEdCIGh1Z2VwYWdlIGFuZCAyIE1CIGh1Z2VwYWdl
IGZvciBzZWNvbmQgbWFkdmlzZShNQURWX0hXUE9JU09OKSwNCj4gPiA+PiBhbmQgZmluZCB0aGF0
IHRoZSBwcm9ibGVtIGlzIGNhdXNlZCBiZWNhdXNlIGluIGd1cF9wdWRfcmFuZ2UoKSwgcHVkX25v
bmUoKSBhbmQNCj4gPiA+PiBwdWRfaHVnZSgpIGJvdGggcmV0dXJuIGZhbHNlIGFuZCB0aGVuIHRy
aWdnZXIgdGhlIGJ1Zy4gQnV0IGluIGd1cF9wbWRfcmFuZ2UoKSwNCj4gPiA+PiB0aGUgcG1kX25v
bmUoKSBpcyBtb2RpZmllZCB0byBwbWRfcHJlc2VudCgpIHdoaWNoIHdpbGwgbWFrZSBjb2RlIHJl
dHVybiBkaXJlY3RseS4NCj4gPiA+PiBUaGUgSSBmaW5kIHRoYXQgaXQgaXMgY29tbWl0IDE1NDk0
NTIwYjc3NiAoIm1tOiBmaXggZ3VwX3B1ZF9yYW5nZSIpIHdoaWNoDQo+ID4gPj4gY2F1c2UgbGF0
ZXN0IHZlcnNpb24gbm90IHJlcHJvZHVjZWQuIEkgYmFja3BvcnQgY29tbWl0IDE1NDk0NTIwYjc3
NiBpbg0KPiA+ID4+IGVhcmxpZXIgdmVyc2lvbiBhbmQgZmluZCB0aGUgYnVnIGlzIG5vIGxvbmdl
ciByZXByb2R1Y2VkIGVpdGhlci4NCj4gPiA+IFRoYW5rIHlvdSBmb3IgdGhlIGFuYWx5c2lzLg0K
PiA+ID4gU28gdGhpcyBwYXRjaCBtaWdodCBtYWtlIDMxMjg2YTg0ODRhOCB1bm5lY2Vzc2FyeSwg
dGhhdCdzIGEgZ29vZCBuZXdzLg0KPiA+ID4NCj4gPiA+PiBTbyBJJ2QgbGlrZSB0byBjb25zdWx0
IHRoYXQgaXMgaXQgdGhlIHRpbWUgdG8gcmV2ZXJ0IGNvbW1pdCAzMTI4NmE4NDg0YTg/DQo+ID4g
Pj4gT3IgaWYgd2UgbW9kaWZ5IHB1ZF9odWdlIHRvIGJlIHNpbWlsYXIgd2l0aCBwbWRfaHVnZSwg
aXMgaXQgc3VmZmljaWVudD8NCj4gPiA+Pg0KPiA+ID4+IEkgYWxzbyBub3RpY2VkIHRoZXJlIGlz
IGEgVE9ETyBjb21tZW50IGluIG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGIoKToNCj4gPiA+PiAgICAg
LSBjb252ZXJzaW9uIG9mIGEgcHVkIHRoYXQgbWFwcyBhbiBlcnJvciBodWdldGxiIGludG8gaHdw
b2lzb24NCj4gPiA+PiAgICAgICBlbnRyeSBwcm9wZXJseSB3b3JrcywgYW5kDQo+ID4gPj4gICAg
IC0gb3RoZXIgbW0gY29kZSB3YWxraW5nIG92ZXIgcGFnZSB0YWJsZSBpcyBhd2FyZSBvZiBwdWQt
YWxpZ25lZA0KPiA+ID4+ICAgICAgIGh3cG9pc29uIGVudHJpZXMuIA0KPiA+ID4gVGhlc2UgYXJl
IHNpbXBseSBtaW5pbXVtIHJlcXVpcmVtZW50cywgYnV0IG1pZ2h0IG5vdCBiZSBzdWZmaWNpZW50
Lg0KPiA+ID4gV2UgbmVlZCB0ZXN0aW5nICh3aXRoIHJlbW92aW5nIDMxMjg2YTg0ODRhOCkgdG8g
bWFrZSBzdXJlIHRoYXQNCj4gPiA+IHRoZXJlJ3Mgbm8gaXNzdWVzIG9uIHNvbWUgY29ybmVyIGNh
c2VzLg0KPiA+ID4gKEkgc3RhcnQgdG8gZXh0ZW5kIGV4aXN0aW5nIGh1Z2V0bGItcmVsYXRlZCB0
ZXN0Y2FzZXMgdG8gMUdCIG9uZXMuKQ0KPiA+ID4NCj4gPiA+IFRoYW5rcywNCj4gPiA+IE5hb3lh
IEhvcmlndWNoaQ0KPiA+ID4NCj4gPiA+PiBJJ20gbm90IHN1cmUgd2hldGhlciB0aGUgYWJvdmUg
Zml4IGFyZSBzdWZmaWNpZW50LCBzbyBpcyB0aGVyZSBhbnl0aGluZyBlbHNlIG5lZWQNCj4gPiA+
PiB0byBhbmFseXNpcyB0aGF0IEkgaGF2ZW4ndCBjb25zaWRlcmVkPw==
