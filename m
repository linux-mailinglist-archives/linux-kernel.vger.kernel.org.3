Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2C659945D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345602AbiHSFVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbiHSFVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:21:49 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2086.outbound.protection.outlook.com [40.107.114.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC835D4775
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:21:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWpfVh1IWmsElImBV+ygGeb7sO5iL8oPYkezPb8k+eYKNljAEn9Hu3hbYnc0rEz9k93ms4vQwyhIpDt06c/RB1ptaPnIqRJUlhlYI9A+s/3mKKlu/yMwsY8bW8HkJLqCeKl21jwcaJX2unj72PYV8ROYdXaQi9Ax6GCA5XvwDu8ezPZwDbtVxUeVsPP00fWMfQ0csZgamXZYZcMYyPukLf2x56Y5d6Xios9JAD1+HEJC6yybgqIe36NEUsYB4REp8Tu0vbMEJ5AG8HYNYpksGlPiK7FRXMEbsVpV3VXnq4R4tggbGWnG1csFjA4BIjKF9S69Ivp/6QibR8eCPYPlHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3LrrdRBq8OictYhsqsTdXuTLh8IqgGVcEBFeg94uvk=;
 b=TJTBVHBnMoWATHUl2PKpdmW6F522wUtrwj1l7q4otnpX7hCxp29hs5eo3OI5Qon7B8GY54uqE2QqpMil9bbpzUB4VF//pwjJ7Vv8Fyo9rEpqtWierw//3Fd2xWjGBQNqEibKNw4PZcm4nqD8yQY9WJ2I4tvIQxf34cK/ehS0Hu3ZqNWo0UjQst9gDQmANIVkK0sAiaZ1vjcmhFES+X5COART2o/MFX4GDyZVhG+cEW1/RMSatOGT2u2zU3FPviMSe2ZvHp01dr54yBJQk2UBIbdLXYQ4OdjbciJGAaXSxn/3vJQyi+FBh46Gl/JztdwP6kcSK5qS/V9odb3XeWLI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3LrrdRBq8OictYhsqsTdXuTLh8IqgGVcEBFeg94uvk=;
 b=GOOirmWDhOrNbsHc2A32dYiFQRctrTV2b+lGu93WKmaqPWin+SY5ZDWMhf05ABG8mVgu6ZH3hZLq8qpXbUFTtJjTz/qtFt5kSGZ+xvZ5Bvk6cmra4Ev4w1QJ0mur4xfDBOrEHKaRUAbe2L1r8JVeHjMcbT3J2NOvP6rsSlEPDIA=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYYPR01MB7880.jpnprd01.prod.outlook.com (2603:1096:400:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 05:21:46 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 05:21:46 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] mm, hwpoison: fix extra put_page() in
 soft_offline_page()
Thread-Topic: [PATCH 3/6] mm, hwpoison: fix extra put_page() in
 soft_offline_page()
Thread-Index: AQHYswKKotaEmLJG9Eixqt6vMVvLO621sSEA
Date:   Fri, 19 Aug 2022 05:21:46 +0000
Message-ID: <20220819052146.GC613144@hori.linux.bs1.fc.nec.co.jp>
References: <20220818130016.45313-1-linmiaohe@huawei.com>
 <20220818130016.45313-4-linmiaohe@huawei.com>
In-Reply-To: <20220818130016.45313-4-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04efb227-d4c5-42d3-2805-08da81a2b622
x-ms-traffictypediagnostic: TYYPR01MB7880:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DMZQ95lKqnHl/P+mVtQoTyAYVHY1QjYI94kJ/Xc7RHahVSO9gWmSH933ub4IlIAmQ5Q3/FQ6Pl4U+dd6nAB3+V+8OdOd64bbLRhr7A5JDETuPQQwOv74HisPJxPmmq/asM3ca0NeD3PAwa4w4aCaXsKH8t/8MHVxiyrAwFvFlNDXAZKnmzVG7UIKXzOXnNuIQRJEXlCVdg3qF4ZcFzXZxT0WvJgb4nM+0MqxMyijOsnpyox4Pu+MmdEo07e5bEsVgmLEI8WpvNqFfn0J1pSzDBU//vc7CHRBx5lkBvkJLWETykPH105jQqu1HTrTn6Nwt2taiyZA82MM70WVRnfuc2LgUOVuVOhu2Zr2t0co/j3SO7auegqmNn81zGNr58lJxqzk59qNiQqnlyO8XTGZvhEA8gfTyCPMr1QSzzgdpI2dDLLfzx+AdC1jZ0IiJMDHzq+m5BUs5NrV2OGl6g36hVHh+AKjgLQG6TKAK12XU2lZT/srFShWCSCf+O147QkgKv1+TXyJ3dTlh1JdhEJe0crXsxxU1vEAn5gQm5G4jU2m0aym3yJZtO782CXiq5BsXRqTmfWel6iYmEsASn5MWqaNQYvMeyVC4FPAAtoGCWH1I94V26nWN0kv5PtAb/Hzl5UrVBP/8FKoAW4e79LaHN5CGKnOA/2Fhd/7qbrcL8DJGTvE8zOFScW/F7W2SCKpwd2LtKFPTltDJ8wGtW5fbozJTYoEYcO4TMzhhy0WvQZDprC6udHURjqllmXeIG+R5ihDRTdJCcCR6rL/SQRyZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(4326008)(83380400001)(38070700005)(186003)(38100700002)(4744005)(8936002)(82960400001)(1076003)(2906002)(86362001)(122000001)(64756008)(76116006)(66476007)(66946007)(66446008)(66556008)(5660300002)(8676002)(54906003)(55236004)(316002)(71200400001)(6486002)(6916009)(33656002)(41300700001)(9686003)(478600001)(6512007)(6506007)(26005)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cExCSTZPL2NINnFUcktZSERkRituTmhHVUU2YUtvaHVPZlVxSzQ0ZXFBZjlt?=
 =?utf-8?B?SGwvaThudmxyV1h4ZnkwS2Y1WWlOdmtEaGFtdkROWGRVdWhLd3Y5UkU1M3ZP?=
 =?utf-8?B?bmhWRWhhcE1oRVF2M1RYTk9zOW9STXk3ZGQxZ3dkemJMK05yTVNGSzdrUXNX?=
 =?utf-8?B?dFEwLzg5MUZIZFJHR1FIeVNXekZoQ1VyaEQ0TGxNdXRNc0ZRbjVEbHNWMG4v?=
 =?utf-8?B?WTRrdGJML1hjOFhxcytCVGZuemVXMEV1NkZsZHFKb01TU0NrbmNrb2N4QjhE?=
 =?utf-8?B?dUhqOTJBVFpBN1pIQTZtMkZudWVqOFZaakxJK0J5NEc0RTYyWDQrTmQ5bEI2?=
 =?utf-8?B?YVg0Y2c3Y3RHd3U0cXZQZUNoblBZNHRKS0prTHdxZTJVTTZMSUpGQnZqSnJM?=
 =?utf-8?B?L1drOUJWalpxTGkraUxpc3FJNnZyTHllWFIzV1M0dk5lSmgwOUZyNmRQZTZl?=
 =?utf-8?B?MDFXajZoVFRqK1JLV1NyZnRTamdiQU8za0NOeEx5UzFtZ0IzSDZKaThYKzhW?=
 =?utf-8?B?aHlNaW53OUNWQVM4dUxQRGdYSmxsY1B2akE1Q1NTTTI2bWRKc1d4TmtiTDdi?=
 =?utf-8?B?ZUxqQmJveUlhQ0NVa1luQlV6Mk02YjJnS3F1WHlqRXpwNDMrOGxib1hHaTM2?=
 =?utf-8?B?eVdtVHBWRUcxWUdPbnlRQlY4bzNwdGp4QStQUkFPWDdSdlpRS3MzVjFtQW1X?=
 =?utf-8?B?YVdiTDNsZTBhYUh2WTVZcEdhSFdYSjRJMC94UlFXb1d3UzdvQnJDWlhKNHZw?=
 =?utf-8?B?Q2M3ZEs0MmlqQVRVN3pRalBMMU1TNzZ2bFJ0c3A0eVBRMFk5YlNkWTBjQjdC?=
 =?utf-8?B?RFJMRzdUbXNyNklRU0xtMUl1UDIrTXdVbFNLUFA4V1hPdkxjZjdMbUVPdmJ1?=
 =?utf-8?B?em84QTN0RWVZa1ErQ1U3MnVPMjlsTloxS3lkS1RmWW1idUNkb1Y2WEVkcGdM?=
 =?utf-8?B?c2RDWnZYcnd1OG1UcUNlU1QzNlYrdkFabTlPLy9UbnlYb3B6cC85UUgzVHNB?=
 =?utf-8?B?akN3Y0M2S2Vld3psMFdGWFRGeklDb0J0YStwYTRBaEs1VThRekVBenFqL1BP?=
 =?utf-8?B?blFzalBGckhtVTExK3RWSUNiWkdYYXE0aktYMnJzTVI5eW10N2k0SVFXL3ZC?=
 =?utf-8?B?ZHJjaHY3VEdRWnNGUnk2ZWI0ZGNHSWxGcnJIVFZkRkl4Y0V0RXhBUFhXRSts?=
 =?utf-8?B?QUtMK0k1ZXp2YlNjbmEwOWMyWEdoYnNoS1duN1ZBSUloOTNWOFhKczdXUndB?=
 =?utf-8?B?U1UwR3hZZW9ZWWhSblRDRkY4YUhsZGVtWVhpV0hiZWFWaVMwaDN6L2lCckF4?=
 =?utf-8?B?Z3N2RjBONVpkbUhiRmluYUNCM1FrL2o4eDBsNVh3V3FjdzU0MkNNd1BUckQw?=
 =?utf-8?B?RGloYXdkd2UrK05VdnAzUS9rajNkSWdHS1Q2SXpKNDdyTUMxdnZFSk1vOFpn?=
 =?utf-8?B?OS9mSUs4djhVeFBSd0t3eFcrVkMydEI1YVNSSDNwT25KVHpnd25LaHF0dGZX?=
 =?utf-8?B?cEEwMmxsdE5SQy9DemNwT0JTK2dpeGs4ZHNJUzY5RWJXL0FnaGVvekhOd0xW?=
 =?utf-8?B?NENGUFBhOEhlN2xVRElzRGxGMm05Z0tKVDZCTU8xUi9weUdhZ3hvOXVMamFW?=
 =?utf-8?B?dVN0MjVIcTB2UkdkVUhzejVDekt5d1ZTdkFTREFTWXV0VXJ1ZW9ncFBCdy9r?=
 =?utf-8?B?cUd4TGJNU1JNRlR6cWNMc3QxdndwYkxNTW1LRUJSNW5PN2p2RFdiQytma0lH?=
 =?utf-8?B?dEhxV0RhMEpuSytTaitYL1BJWVFDQVNwd3J6MXJGNHp2a3k2bXhjK25DMnRN?=
 =?utf-8?B?Q1ZXUUxwSEtFVGhhbTFyb2k1aFd2d0RFTmN3QytuZWMzNWs4Qm5GbGpkc3hK?=
 =?utf-8?B?Zm0yMFkzZWdCSEFVaDNMMFAyLzB2cTdPMUVkNkE0OGJ1Nkd0Zkl3US9iNUV2?=
 =?utf-8?B?UGpWeUhkZzBIRWhaUllJL1h2bkVZNlZjdCtNVmZNamwvYW45TXZrYkJXY292?=
 =?utf-8?B?ZCtyb1d1NUlTVFVacjBrTDJmNVpTR2ZJLzVQWGVBVEliUDR5cWxKTWthMnpD?=
 =?utf-8?B?bzA4U0V3aXhpYXFPWFl3a1RZZzhwWGhReGkyQzJWckpkQ1lxSERWWTJwcU5u?=
 =?utf-8?B?cGh5a2FrSUVFSVptdW4wY2UwMUhGZ1A4UVpKVU1ERkoyRXJtV3VZN2huL3hM?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CA43A38B30FBA41BF36157C3CF4E468@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04efb227-d4c5-42d3-2805-08da81a2b622
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 05:21:46.6410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/Yb6kvj5Nco9V+G8wCX4nEUIk058bRTYHx7SPjdZ5geTW6qvoGUgCoOSrJ/pr04p9PWZk77tkM9G43CagdzBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7880
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBdWcgMTgsIDIwMjIgYXQgMDk6MDA6MTNQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gV2hlbiBod3BvaXNvbl9maWx0ZXIoKSByZWZ1c2VzIHRvIHNvZnQgb2ZmbGluZSBhIHBh
Z2UsIHRoZSBwYWdlIHJlZmNudA0KPiBpbmNyZW1lbnRlZCBwcmV2aW91c2x5IGJ5IE1GX0NPVU5U
X0lOQ1JFQVNFRCB3b3VsZCBoYXZlIGJlZW4gY29uc3VtZWQNCj4gdmlhIGdldF9od3BvaXNvbl9w
YWdlKCkgaWYgcmV0IDw9IDAuIFNvIHRoZSBwdXRfcmVmX3BhZ2UoKSBoZXJlIHdpbGwNCj4gcHV0
IHRoZSBleHRyYSBvbmUuIFJlbW92ZSBpdCB0byBmaXggdGhlIGlzc3VlLg0KPiANCj4gRml4ZXM6
IDkxMTNlYWYzMzFiZiAoIm1tL21lbW9yeS1mYWlsdXJlLmM6IGFkZCBod3BvaXNvbl9maWx0ZXIg
Zm9yIHNvZnQgb2ZmbGluZSIpDQo+IFNpZ25lZC1vZmYtYnk6IE1pYW9oZSBMaW4gPGxpbm1pYW9o
ZUBodWF3ZWkuY29tPg0KDQpBY2tlZC1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3Vj
aGlAbmVjLmNvbT4NCg0KPiAtLS0NCj4gIG1tL21lbW9yeS1mYWlsdXJlLmMgfCAyIC0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tbS9tZW1v
cnktZmFpbHVyZS5jIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiBpbmRleCAwYzVhZDc1MDViOTku
LjcwMjNjM2Q4MTI3MyAxMDA2NDQNCj4gLS0tIGEvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiArKysg
Yi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+IEBAIC0yNTkxLDggKzI1OTEsNiBAQCBpbnQgc29mdF9v
ZmZsaW5lX3BhZ2UodW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncykNCj4gIAlpZiAoaHdwb2lz
b25fZmlsdGVyKHBhZ2UpKSB7DQo+ICAJCWlmIChyZXQgPiAwKQ0KPiAgCQkJcHV0X3BhZ2UocGFn
ZSk7DQo+IC0JCWVsc2UNCj4gLQkJCXB1dF9yZWZfcGFnZShyZWZfcGFnZSk7DQo+ICANCj4gIAkJ
bXV0ZXhfdW5sb2NrKCZtZl9tdXRleCk7DQo+ICAJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gLS0g
DQo+IDIuMjMuMA==
