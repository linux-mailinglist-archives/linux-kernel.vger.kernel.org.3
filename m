Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AC259946D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345901AbiHSFXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242329AbiHSFX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:23:28 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2051.outbound.protection.outlook.com [40.107.114.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8FC75486
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTI9a2ttaiLmMUPT5AyN1dUuY6XPOlxDPEmTzMKqy/Avie6ORhU+pcHiUiDv36gJ9+VOEeo1ZZ7QDh4+pai+A5VYe34zTSK/zivhMVxVeV4cqrt1VRJ+wJl63Y6tqOP0YeVMiffTL4Vwhp0JT319Ku4emVDwTC7HXYEDAxFf8VMXTwgyZhEfnv6+M4SPX0UmQNrh+VOskk00bfYnFSZjdWVdDOq5eOK2+yamVpzovv0YBTiaG2gqD++pte3kJdUWR5V/xm6oOYBX7A29VtghZXPgJ9AfrnyuWD625CCPENvf4L2ImE9ZXWlwROZW3aB0I4gHvgX1+WUQQldoKE58lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vp7GZsumMXic1P4LvYt3opdc2Gqb4EX7Czd4fYGmJ4g=;
 b=KKEV0idx/wx9fT1ECWu6FEuG1lnfclEzjlCr7pmsHUHL8CBA9eRGbcHSJUc1UT+T02cN9ciTXkU0M84ysLwcdHjtuOKKBbf+MXAsniILkITg+cX/Iu9s1Vz81PZj9J7x2SBkcJcY+JUGBLoYxINR+N63rqjZ47FugaodPBUh0p5qRlXyASAO/cgwZ8uQNxcb0/A+QWs8iCq+kDYlWdBIAoKC55k4wJfgdUTGGR7WEIoRzg2elyLhNnHjnvFpr/+eVZXOi5OkdxAQi0vvbESireBCVnY0VCCPWt6PkSdIKEBnZGQHgDpqrELj+pboaUmoqxfsqOKr7w62wYCLz39B/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vp7GZsumMXic1P4LvYt3opdc2Gqb4EX7Czd4fYGmJ4g=;
 b=c9wuZp3284vaHV8suPG9AJBPfUa3kHaUQZBhcGU9MHYU0pqY7XNYKjJ2XCjLW//cDmb6gMZiHAQu/3x909EYOfjpouhQCIQCofivmt5S+g/huFwTyfYj0+PpdGhLqGqkxfQ923pkCy4TutyHA/kd/Br6nm1PLsI2xgZPuM7mRh0=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB3460.jpnprd01.prod.outlook.com (2603:1096:604:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.17; Fri, 19 Aug
 2022 05:23:25 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 05:23:25 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] mm, hwpoison: fix possible use-after-free in
 mf_dax_kill_procs()
Thread-Topic: [PATCH 4/6] mm, hwpoison: fix possible use-after-free in
 mf_dax_kill_procs()
Thread-Index: AQHYswKMj+K5+fERuUCXeznMVtIiRq21sZYA
Date:   Fri, 19 Aug 2022 05:23:25 +0000
Message-ID: <20220819052324.GD613144@hori.linux.bs1.fc.nec.co.jp>
References: <20220818130016.45313-1-linmiaohe@huawei.com>
 <20220818130016.45313-5-linmiaohe@huawei.com>
In-Reply-To: <20220818130016.45313-5-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ad4b8fc-8665-4eaf-dca0-08da81a2f0e1
x-ms-traffictypediagnostic: OSAPR01MB3460:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xjKbk9aBPrEGFsfFBwnzdfnSVMYCS+LjCjsxqKliTJ9/0kuIxuH1OAVP3uIhTkHBoc1yzZ9lIDtHKd8n2e6It0zO1vfDqmb5C9XZdfcvSk8ZNCzwsbG8Hai+dDndI/2fnkAFek1i+6XLRUPsvZ5FTQKEvHV8I/gy4UW4ZDFY3c02eTClMAbZ5Bcn36ydsTIz+1MVQw7Cn1wfi68z6z6VXK9cRHQw+Kxhh94Fy/LSPf3j9A5QmKNUuGbQwAim0VBoP9gpWurfYPYTBXR96223MwX3vmvXxP2B0AO0CAks7w69hdHQ/3BLrNe92kq1lPrMml91KjNmGCJx0fQ84QfIhEVJucajZx4+MFLptisG2Yoo4aF3C2koY5tGX+s4fwkQJDBqlw1nQVteAy7gXj6lkM6JsawzUnfXMt4AOcJCtxDJtY/JT2a959StvueZ/f3yYiPBwh+HxFZlimNiRwz3KTkjLnMP+hmSMMo2A6EVTllsfMuGtAODtq6hgloksoa73jBm+wjrUfh0Wrf1Z3OUZvik1+3pFfTjL/6koPtb2BNyB6Llb2Y9P6wzKb/2sIAxWJ3iKSsoab/ORgOyXpoEPkuTfd5eCWJOCAAesr277+qD1uHFW6PlIDkGOXRrrXXj5PlkG4amzlfjGTn8z4ke4sRnrgCo+8MGCOwhg9ndVxgeh38xONgzkB1Almzu2RZB6QNVBNhQ2GfQou8XKUQLTDIbHAVL4lfCG/dW6XOcqEdWZ0udxMKkLpsPYo+jX65Iz/a7YhBd3FWOW0oubNPWWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(85182001)(33656002)(86362001)(38100700002)(55236004)(83380400001)(9686003)(6512007)(186003)(6506007)(26005)(1076003)(82960400001)(38070700005)(54906003)(41300700001)(6486002)(478600001)(71200400001)(4326008)(6916009)(76116006)(66446008)(64756008)(66946007)(8676002)(66476007)(66556008)(5660300002)(2906002)(122000001)(8936002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlIzZGR6RGZvYjJvSWtBSG1pSGRFUjdaUHBRME1MQXVDTDRlUkloRzk5THJE?=
 =?utf-8?B?VXQyZTczaCtDUzNaRWYzdWd4VHlEcldsT21UOXVsWmVNalI3NHJmb0UweDRp?=
 =?utf-8?B?cCtXT1JraThyRXJERnhsMDRBZHdIRTVmNkh0NUs1SlBXSy9tb245YjJ5VW9y?=
 =?utf-8?B?RFRZdE40OUFOWnNTcWIrNmQwc0UxVFNQaU1LWGtNck5XTVJFakw0ekthUUZC?=
 =?utf-8?B?OWlkOUVkZ2NmOHpyVzhRaUp1SXZaL3B4M0NwVFFCaHVPSHNwUnpjWmFoR0ZB?=
 =?utf-8?B?ZnJZQUNZdXBzTmNJYnZYS3hCYmJUVjB6T2FXVFhuTWhVUWdWRzgwYit1c0Z6?=
 =?utf-8?B?VzJTVmhEQ0RpVExsRjBadGMrVWFLcE02MWpHRDhVWEtjU2lsNHhyVDU5RDgx?=
 =?utf-8?B?V2hsT2plUzVWckpTaWhGNWJ2KzRmUk53UXVad2tBWVVrL2RSN3dWSitSQysr?=
 =?utf-8?B?SkZ3M3ZaTnQvZWt4RUVSSitoZ1ZSVVhvR25QMXYxdnM3ZUxTL3c1MkE2QXpI?=
 =?utf-8?B?S2xTc3U5N3NVQVpZQ3A3Zi9TZ0RTYmVZaDV1L2lyN1ZhKy9ZeEdSMXJ5ZWZN?=
 =?utf-8?B?dWFyaUJnLy9JZ0RLQW1RQlFxbndUNlU2NkpQRkhPK2NxSmZwclF4cGFRS3V3?=
 =?utf-8?B?WDkydm9veGIvMXFCRityUlZxbkpaZy9JMml6OFprT2dSLzJuYXR3T3ZKZUF5?=
 =?utf-8?B?ME1vMno0QkphTEVnOTNhV29nMTFPVTZnRmgrYzhnS2krVlBPVWRISWt4eHd1?=
 =?utf-8?B?WFdCbnl4alJMY1Z3QmFQUm1VUVZvMGRxdkhaV0Y1Q2lzMFNaRWhteDFrWU43?=
 =?utf-8?B?Zk5ZeXVLdnhDODFpcnByVXpndVRMRU96RjBUU0ludlJ1VzcvSThxYUZEcXVD?=
 =?utf-8?B?YU1MUDFkOGlJR2habHJpWUtSWDI2cHdUOGlzTllDK1RJMWV4ZnFqV1dlNUkx?=
 =?utf-8?B?bk9HUjl6Y29TdzU5ZXk0M2k4QkRYajJsWEo5bFhwUkVUV3U4SDVrMEoyUzY4?=
 =?utf-8?B?Yk04K0I5NnV3UnVMOFlpNTRnNkg5TzhEWC9WeEJKWEsrU08rZHJLZGFLVzF5?=
 =?utf-8?B?RkUrVVZjR2k1aWRHTk8vU0I2TlhtbWFqMS9EcFR2RTdsQzZwTHZ3RHg1QnBi?=
 =?utf-8?B?cXpkOGlhb1I2dG1BaDF6K2tweDhUcjVWQ3dzM3hLZXA1SURnTG1peEpPdExG?=
 =?utf-8?B?c0FGZzBPOHF1c0FIUThxaFc2NjZwL0xpZTZnZXFTR1hFdWNrSzRuSXk2azFY?=
 =?utf-8?B?R09QbnYreWxoMkFNOVhLT3Y1Y204MlNaRFF1RE9pVHNUdGFSci9NbnlvYmJ1?=
 =?utf-8?B?NVQ0S05yTjJlRnBiWXlhdW1lS3ZLY3JGUTJHZ2dXNmRtS09SN3V2UWJtRDJp?=
 =?utf-8?B?NWNkbTYwQTNTemZOSmZ1RlFyRUpUV3VvSU8zSExPWjU4SU1kbGVnVVB2MVZm?=
 =?utf-8?B?Wk54M3pDMVlFdWlOVmVOSmdtK0x0T1dNVlBIYm1ZVWZMZ3UzSWlOUkZ0QnJT?=
 =?utf-8?B?T3dpTG5ZTXRwdUVsUjg5RnhQQWsvM3k1MVBlZU9XM1hNVDVDUWlqWDZ1czQz?=
 =?utf-8?B?VHF4R1pObkpNWmEzVHlvYXJ1cW15c0hGVFFqcHNnaEQ1TElyUTFEWEd2ZWF6?=
 =?utf-8?B?VXcwaTZSRmU1aThPL2hEYVZGU3BqTUhjQisxRXNkaVZUSFhybDZwdG4vTWU4?=
 =?utf-8?B?Q1ByS29SQTBiS28rNis3bVQ3MGFVLzh0RnlDU3djMmppckdPK1JlUmVCVlJF?=
 =?utf-8?B?dllOd2hPY0dlWDVJTkVodWFqYXZVMUFXVlFMYlp6WE95dzVWejVZNDVDNklt?=
 =?utf-8?B?UUd5cVNOc01uU2JoOUtxWXpBc1hVK2FuV204dXZYbEkzbU14STdoY0UxVUFT?=
 =?utf-8?B?VFl6cnBOUUpSazJ0NiszNjVEaDBmYjQyamx1RUFpaGdud0k4bEJGQ0IvdXdp?=
 =?utf-8?B?RTFlMi8vd1FCd2RQZzQ4SzQ5NW9IeWZTY25NYkhSay9NejRoVHk4blpmMTc3?=
 =?utf-8?B?aDZXSkxiL1FyRmlMZWI3T3ROL1NhcFlGTkpXOUlqcHhNRlc5WkdzcUNxSmZW?=
 =?utf-8?B?RkVIemxKM1VQTi9zRkhoS2JjbGdxaFBJNEc4eE5VSDNON0JyeGc4T1h3YlUv?=
 =?utf-8?B?ZU1OSHRremZBaDV6MnFzTWpydllJd0RaK1I5RlRWdFFaMWZqY0FFQm9MZGg0?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC7319C44551B04A861888BE0C05C266@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad4b8fc-8665-4eaf-dca0-08da81a2f0e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 05:23:25.1740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3nb5yxi5KZNlQVDyeNGV53ZbeCpCRVVpxK3arFz/BIMHdnjjwmAiH9Y2zvYdQkQvUWMacyaEhAguR8nVze3ag==
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

T24gVGh1LCBBdWcgMTgsIDIwMjIgYXQgMDk6MDA6MTRQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gQWZ0ZXIga2lsbF9wcm9jcygpLCB0ayB3aWxsIGJlIGZyZWVkIHdpdGhvdXQgYmVpbmcg
cmVtb3ZlZCBmcm9tIHRoZSB0b19raWxsDQo+IGxpc3QuIEluIHRoZSBuZXh0IGl0ZXJhdGlvbiwg
dGhlIGZyZWVkIGxpc3QgZW50cnkgaW4gdGhlIHRvX2tpbGwgbGlzdCB3aWxsDQo+IGJlIGFjY2Vz
c2VkLCB0aHVzIGxlYWRpbmcgdG8gdXNlLWFmdGVyLWZyZWUgaXNzdWUuDQoNCmtpbGxfcHJvY3Mo
KSBydW5zIG92ZXIgdGhlIHRvX2tpbGwgbGlzdCBhbmQgZnJlZXMgYWxsIGxpc3RlZCBpdGVtcyBp
biBlYWNoDQppdGVyYXRpb24uICBTbyBqdXN0IGFmdGVyIHJldHVybmluZyBmcm9tIHVubWFwX2Fu
ZF9raWxsKCksIHRvX2tpbGwtPm5leHQgYW5kDQp0b19raWxsLT5wcmV2IHN0aWxsIHBvaW50IHRv
IHRoZSBhZGRyZXNzZXMgb2Ygc3RydWN0IHRvX2tpbGwgd2hpY2ggd2FzIHRoZQ0KZmlyc3Qgb3Ig
bGFzdCBpdGVtIChhbHJlYWR5IGZyZWVkISkuICBUaGlzIGlzIGJhZC1tYW5lcmVkLCBidXQNCmNv
bGxlY3RfcHJvY3NfZnNkYXgoKSBpbiB0aGUgbmV4dCBpdGVyYXRpb24gY2FsbHMgbGlzdF9hZGRf
dGFpbCgpIGFuZA0Kb3ZlcndyaXRlcyB0aGUgZGFuZ2xpbmcgcG9pbnRlcnMgd2l0aCBuZXdseSBh
bGxvY2F0ZWQgaXRlbS4gIFNvIHRoaXMgcHJvYmxlbQ0Kc2hvdWxkIG5vdCBiZSBzbyBjcml0aWNh
bD8gIEFueXdheSwgSSBhZ3JlZSB3aXRoIGZpeGluZyB0aGlzIGZyYWdpbGUgY29kZS4NCg0KPiBG
aXggaXQgYnkgcmVpbml0aWFsaXppbmcNCj4gdGhlIHRvX2tpbGwgbGlzdCBhZnRlciB1bm1hcF9h
bmRfa2lsbCgpLg0KPiANCj4gRml4ZXM6IGMzNmUyMDI0OTU3MSAoIm1tOiBpbnRyb2R1Y2UgbWZf
ZGF4X2tpbGxfcHJvY3MoKSBmb3IgZnNkYXggY2FzZSIpDQo+IFNpZ25lZC1vZmYtYnk6IE1pYW9o
ZSBMaW4gPGxpbm1pYW9oZUBodWF3ZWkuY29tPg0KDQo+IC0tLQ0KPiAgbW0vbWVtb3J5LWZhaWx1
cmUuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9tbS9tZW1vcnktZmFpbHVyZS5jIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiBp
bmRleCA3MDIzYzNkODEyNzMuLmEyZjRlOGIwMGEyNiAxMDA2NDQNCj4gLS0tIGEvbW0vbWVtb3J5
LWZhaWx1cmUuYw0KPiArKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+IEBAIC0xNjU4LDYgKzE2
NTgsOCBAQCBpbnQgbWZfZGF4X2tpbGxfcHJvY3Moc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBp
bmcsIHBnb2ZmX3QgaW5kZXgsDQo+ICAJCWNvbGxlY3RfcHJvY3NfZnNkYXgocGFnZSwgbWFwcGlu
ZywgaW5kZXgsICZ0b19raWxsKTsNCj4gIAkJdW5tYXBfYW5kX2tpbGwoJnRvX2tpbGwsIHBhZ2Vf
dG9fcGZuKHBhZ2UpLCBtYXBwaW5nLA0KPiAgCQkJCWluZGV4LCBtZl9mbGFncyk7DQo+ICsJCS8q
IFJlaW5pdGlhbGl6ZSB0b19raWxsIGxpc3QgZm9yIGxhdGVyIHJlc3VpbmcuICovDQoNCnMvcmVz
dWluZy9yZXVzaW5nLyA/DQoNCj4gKwkJSU5JVF9MSVNUX0hFQUQoJnRvX2tpbGwpOw0KDQpIb3cg
YWJvdXQgYWRkaW5nIGxpc3RfZGVsKCkgaW4ga2lsbF9wcm9jcygpPyAgT3RoZXIgY2FsbGVycyBu
b3cgdXNlDQp0b19raWxsIG9ubHkgb25jZSwgYnV0IGZpeGluZyBnZW5lcmFsbHkgbG9va3MgdGlk
aWVyIHRvIG1lLg0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
