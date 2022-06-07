Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C21353F45D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbiFGDME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbiFGDMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:12:02 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2130.outbound.protection.outlook.com [40.107.117.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F157B0D2B;
        Mon,  6 Jun 2022 20:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUchBt9Q83vnx82xOIW8111VwUS38CmXqiSzhPKew6nc+9pD/ZjDwPkUhZuB1r3C1bnF+e4VGza8tQlGMrESaLfxRxIhynkDoAtioaeJLYuM7RKO5gP9TNd9qsSN2C9JvT5h6wUsyGcr8Yp7t5Zok1x+rvu2O9zOQ3k1BduvQLV6uI3fnj0blx62vX+kByFtz2euFY+P4kNyDVheJL4TuSyme3gRa8nI6F/X48HfhUOMPK9Je6R+uT3upeJadxUK43HU76gXcdTPesJIoOjj2EpfLF2sPI3iEjlZqgbOx2TRFd2947qJ1SyJhwp8+dDCbAhtsfSuCjnQ4jQLv21gbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdFgg64C2zeayKRAoXTHd3GwopyLi/E1cZNltopRvAc=;
 b=NyqNFHaGfgV3ayFXeB/DHJegp+s/CTqyROMt87scVCf9s4bJ259GTdaY9s3L0m/fRAr1HZ4GmYOELUI60q7acA75OwPoIZWHsTsPE1IDcIWD8YNE+Bg//MNBExnpaN/CXfsyGr2BRD4tL9Fa5wE6SE3GDBDPzZayZmwXPEJX+8XWjxpXz/L05d7UEGE1Fx5AcdBdotGHmvV9uDRqRsMigp1ZsVHs08BNFMCqPHdmPaQ8c3R18wbFzOtLOiVLzQnh/996BMo5nhnlzZsgKva/XXtkrZwwxKct4iB6u6uJmf0wwp3ae9Iv4tcc1oaA68I3O7QgcDqEXpaN/LEcXLyISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdFgg64C2zeayKRAoXTHd3GwopyLi/E1cZNltopRvAc=;
 b=CxShpyvVaWxxgUTx1Xjv/YSu3OPkty3VpGF2J74q/++brXm7M77QFiiA/r4omc/OmEL8VHVkYVu9gs0+ZqWnud75ovdljApOB14cWOrgNyIuqvqQstTYvsSBW32zV58q6Ei9XdSHACFZ1DrCXDfI1foGfPjYX/5Fp5jNLw28jQv/cQHZrrtq4hI1D0LDGmXbI5M9yy60UCgaWPc96A9B1bjd3A6+B5qWB3g76S9fsUZkZOc/ufSq38xbo1aWI82QJmCeNLf0tiUSzextQKnDio2ePn+VE2hWRb1Bq8DGd/cc37/LvtGkgzZ2znwFYH+JEr7T7zz2Qse6Ak44nY6/xQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by SG2PR06MB2217.apcprd06.prod.outlook.com (2603:1096:4:8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.16; Tue, 7 Jun 2022 03:11:51 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 03:11:51 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
Subject: RE: [PATCH v2 1/5] crypto: aspeed: Add HACE hash driver
Thread-Topic: [PATCH v2 1/5] crypto: aspeed: Add HACE hash driver
Thread-Index: AQHYeXGeSzQOPdHyakaer71NgsLgsa1Cr2KAgACV+JA=
Date:   Tue, 7 Jun 2022 03:11:51 +0000
Message-ID: <HK0PR06MB3202E53C7EA4626291AD785E80A59@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220606064935.1458903-1-neal_liu@aspeedtech.com>
 <20220606064935.1458903-2-neal_liu@aspeedtech.com>
 <349c0714-5ec8-4233-0f0d-669e4ad3bf59@wanadoo.fr>
In-Reply-To: <349c0714-5ec8-4233-0f0d-669e4ad3bf59@wanadoo.fr>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66cc8d60-125a-4303-4076-08da4833777b
x-ms-traffictypediagnostic: SG2PR06MB2217:EE_
x-microsoft-antispam-prvs: <SG2PR06MB2217F6276A12594BFC70CCC980A59@SG2PR06MB2217.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S4S1rdKAx/oasG4NMdooK0+OB8y70AAUas0vsxRY1IjBuByn69yC6MVa98t7BglI7Me5AUo7gn2Mt1w0TqbAtr7nyLqo0NMlhV8p4nYinyhEVdIn/Iwi8KaXISTXsKPwqBOXwN0ndm4Ru/4rde0DF3tsaxJ9nWKbK5aX7K4hj/mSEJCBTGCMoMwVU05bn4GARts0vzEEOqHaAiAJqTxJtkFb/8w4+hNoNI3tTCcDuLGjxGzyTSWm2e+suOYBHS3IzmjSkfmVulTrM+8RXZY/WqQIPd/x7QVCbmO8LhcnbXA7Kp+oMOfBArP/QGs9l67momey/t3sCszmJ4A1UyYuI20BK7LWIuSYcq6v6HlhQS4ZECjQiU2akZuVybNafx1DD4xL1P0TEQqizox+v1qzPziml5EqK421DPyNOL6qqxPogSI4AQ62T9AWPz2tdUOLb2hKrdv+RPGNDvF/vRwOcary9okMZvYASyrXZDeDgB5yXfyAGsq2Kj1yrr6mRK27DqiftkaQg7axJVyZR9xe4kpkCo7qxrMEu8v5EF7HSFv9vAI3BiUkPvQhtZ3wrxssdBDBVtpuAMutNsoxAAl8bGVunKDe6pLwqOt/EC01IcsH23LoyjnlepoOEQ9Uhvv27FcN8jo+goeF1DDv8+9XSKXjEnkTFaArF9MXxIiXA9GR0ZjCAsjLyR0k5mLwepaHN+Uikb8xGdWKH72/FgJoag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(316002)(83380400001)(186003)(66946007)(38100700002)(8936002)(508600001)(52536014)(71200400001)(33656002)(86362001)(6506007)(55016003)(122000001)(26005)(9686003)(38070700005)(64756008)(7696005)(66446008)(5660300002)(7416002)(2906002)(76116006)(8676002)(54906003)(4326008)(66476007)(66556008)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3cwaElacG5BYkdJdER3cXQvZ28rWEh2L0RnNkkzbnFuRnJicUNtYWdMMEtE?=
 =?utf-8?B?WlBtelQ4bzF3cTVod1laZ3MrS2RRMk9aZ0dyQUZHNVlndzFiaWpnYmtweGk5?=
 =?utf-8?B?c29nKzVxODFwdklyUGVrdVRUeG1nNFhaODVER3dpK3ozUEJVMGZGeWVjL0lP?=
 =?utf-8?B?TkNicVdOM1ZpczhqbUFmUU50Q1ZqUW5QazB6QkRXK1hEc1FwV25RVkZPMm9R?=
 =?utf-8?B?b2Jodmtna0FwRjE0SnZCQzlwM0lnMmhGOVFPUEVlUnFKOHZ6ekx2eWF4alU4?=
 =?utf-8?B?U3FFRk1ycFl3Q1gvTFBaTUh0TkE4UldTa1FEdmpOY20yZXNyWFBJZ1ZjdWcr?=
 =?utf-8?B?OU5sbHM0MmY2MmdWUG8rYnJCOVVLWTRrbzk4QWVqeE1PLzZoaXJ6WDQ1Kzl0?=
 =?utf-8?B?QzhiT2dDUTZGdzh6TTNPV1ZacVhsQkMvTm9Ic2lBSUhTek5VU0YwMDZyRHZa?=
 =?utf-8?B?eWhKOVJQY0hpMU04OVM4cmtpMDZKNFJkWmk0UzdLRWNYWTJ4N2FqdEkwYWlO?=
 =?utf-8?B?ck5zeUZJZWpEREZsRjlaRmZIODZ3bUZUOWNVdXNVdVZlazg3V3c5NmNRMUd3?=
 =?utf-8?B?UWdOQi83NWZGYUt6d2VGYUU3WXRRcGRrLyt0R3AxMVlFNlRDd3BkV3pmYVgv?=
 =?utf-8?B?ZUdBK3RpTmlMbmZtSWkzTkkwcHo0Sm5qak1nNGlMSEFJNitiVER5VjFadG0v?=
 =?utf-8?B?OXVnOTlMVFB0SkJhQ2FvemFwdHd6NEswcEdZRHFTek00V1QxMUd4OHNreXZE?=
 =?utf-8?B?T1QyOHpOWXorQ2dKRmQ0VUowU1hvb0luTmk0Vk93bkZBcm83cVhPNVBsck9i?=
 =?utf-8?B?V1kyUVBMOTc4bXl2VmZ6MlhMa2VCb09aQ3kyMTV6RjZUKzhDcmpGZWdwWWEr?=
 =?utf-8?B?YjlXV0s4ZWlwMWRrTzRDVGdEeUlmYXpZYkJOL21qRU84NjMwUUlpR0p4UDVL?=
 =?utf-8?B?QVBLdEdVNW5xTzRFcUxjYnRpcGpaYmQzZ2tOVG1jbThZUUFad1Zramx5WGRO?=
 =?utf-8?B?cmxqZkJTai94YmhqbkhnUFpkaXI3TnhZWkhaYzBEK3h6NlNXYm5DMkRWTFRi?=
 =?utf-8?B?R2hSdUtYdlNaUDFYN290OHlmOXFBMEdkRkJNZEpnRHhLMDN1ZHlvU09BczNX?=
 =?utf-8?B?TjdIQW5BMVVXeXNFU0lrUmpDK0lMY2x2QkphSlZLTFdQeGxCVkQwd2o1T2NK?=
 =?utf-8?B?UXpIVjZLaHVzOVNtaElnUCtlSEw3TWg2TU9UWnBHdVZSUlg1b2paSDFIeTVU?=
 =?utf-8?B?WjBJMjBzVUs4aEVocTFNb3lmZjJVRWlXMkVKd0J2MlYweklRbjJSdVNSMjBJ?=
 =?utf-8?B?c2o2L3VFWk1tdkUzOTVqa1cxallLVm9IMmp1bktEVHQyem1oMUtZZ0JGbVdW?=
 =?utf-8?B?c1hpSjJ5WlBLeEpqMDJaS25qVklmS2N4bmVLZndzcjJ6anV6aUpLYzBlQ21B?=
 =?utf-8?B?WmxKdFVTMFdhWGFYUTdoQmg3WU5KNTUvT1pJV1BxekdwZmx1N29vRHlxamF6?=
 =?utf-8?B?LzhHVkVMT0Q3TDlsNmhxVFhKN21QWDNWSkRyYXp6RUtwUVRzb1p5dDlLS0Nh?=
 =?utf-8?B?aFZQY2VDYTNDYmFZU1AxZ1c1YVZ1N1lndU15Z1Erb2FrdFppT2VEQzFsY1pF?=
 =?utf-8?B?OGF0MFk4Z0RXQnV2S0Y2T01qSVl1aXJTVHpuNUdJQ09iVHFBWjJqUUZtSlk4?=
 =?utf-8?B?QmlKYVVlSXgyaXNWN0xBN3RkdmVCdDcxK2R3V0JxUHV5ZlAwdHV1VjBLN1FG?=
 =?utf-8?B?cDAzQmpTR3BydkswK1U4SWJJZG5VM05vVXpWa2ZrdGhNSm9xSUI4dXpNSHNW?=
 =?utf-8?B?dFRaenNiSzc5NWU4MmJiS2tEOXdmUXprODRqWXdMQkw2cDNNREhNMDRNTFZL?=
 =?utf-8?B?Zk1LMzAwakgrQnRqM2xWWEVhVkQvUGVTa2cvc2tyRVFLVUMwYzdFYVNVWkxr?=
 =?utf-8?B?bEF4RWV1RGtrRHlNMDc2TVIrZ2ROUlZQaTgwcndyQUJXeU1KTUMyMk5LVHdp?=
 =?utf-8?B?aE9kNk9PR1EwM3NWSGZFZFVCWTE2ZHVKR1hkUllvRFBibjJaTmtRUndMRHhj?=
 =?utf-8?B?Vzk5WWxRRkcrUHZxQmVMT1ZJdkpVbmV2d3gzWmVJL05RbjhXMXlYY2xjVzhL?=
 =?utf-8?B?WFBmNGFnYUU1N3ZMNGQwZFBUQjI3N25hczg1dnJqbkFQdThBMXVkejBJQXRl?=
 =?utf-8?B?azZNaUpVMVV4QUdWeFl4VHUzaVdRTDFKMzNPRGtraW9yYUpvU1R4SnhMbWhL?=
 =?utf-8?B?OTlPL1VDcURha2s1WHVRbWRXWWRDYjI0c3E3Y2hta3p4elFNU0Q2emlOZmVq?=
 =?utf-8?B?Tlhaci96NUlFYUZXU3c5bXJEUEJNVzQ5TTdHbmtrOVhLWkFZbG9Rdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cc8d60-125a-4303-4076-08da4833777b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 03:11:51.1132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tS6e0h7mTuS7Tozaii3y+9mjWBI70aVxBklKZKlhqN9d3kP7jfOBezh3CZHb3ywqKLJJfw3/N+R1pHfQvb2NFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2217
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsNCj4gPiArLyoNCj4gPiArICogUHJlcGFyZSBETUEgYnVmZmVyIGFzIFNHIGxpc3QgYnVm
ZmVyIGJlZm9yZQ0KPiA+ICsgKiBoYXJkd2FyZSBlbmdpbmUgcHJvY2Vzc2luZy4NCj4gPiArICov
DQo+ID4gK3N0YXRpYyBpbnQgYXNwZWVkX2FoYXNoX2RtYV9wcmVwYXJlX3NnKHN0cnVjdCBhc3Bl
ZWRfaGFjZV9kZXYNCj4gPiArKmhhY2VfZGV2KSB7DQo+ID4gKwlzdHJ1Y3QgYXNwZWVkX2VuZ2lu
ZV9oYXNoICpoYXNoX2VuZ2luZSA9ICZoYWNlX2Rldi0+aGFzaF9lbmdpbmU7DQo+ID4gKwlzdHJ1
Y3QgYWhhc2hfcmVxdWVzdCAqcmVxID0gaGFzaF9lbmdpbmUtPmFoYXNoX3JlcTsNCj4gPiArCXN0
cnVjdCBhc3BlZWRfc2hhbV9yZXFjdHggKnJjdHggPSBhaGFzaF9yZXF1ZXN0X2N0eChyZXEpOw0K
PiA+ICsJc3RydWN0IGFzcGVlZF9zZ19saXN0ICpzcmNfbGlzdDsNCj4gPiArCXN0cnVjdCBzY2F0
dGVybGlzdCAqczsNCj4gPiArCWludCBsZW5ndGgsIHJlbWFpbiwgc2dfbGVuLCBpOw0KPiA+ICsJ
aW50IHJjID0gMDsNCj4gPiArDQo+ID4gKwlyZW1haW4gPSAocmN0eC0+dG90YWwgKyByY3R4LT5i
dWZjbnQpICUgcmN0eC0+YmxvY2tfc2l6ZTsNCj4gPiArCWxlbmd0aCA9IHJjdHgtPnRvdGFsICsg
cmN0eC0+YnVmY250IC0gcmVtYWluOw0KPiA+ICsNCj4gPiArCUFIQVNIX0RCRyhoYWNlX2Rldiwg
IiVzOjB4JXgsICVzOjB4JXgsICVzOjB4JXgsICVzOjB4JXhcbiIsDQo+ID4gKwkJICAicmN0eCB0
b3RhbCIsIHJjdHgtPnRvdGFsLCAiYnVmY250IiwgcmN0eC0+YnVmY250LA0KPiA+ICsJCSAgImxl
bmd0aCIsIGxlbmd0aCwgInJlbWFpbiIsIHJlbWFpbik7DQo+ID4gKw0KPiA+ICsJc2dfbGVuID0g
ZG1hX21hcF9zZyhoYWNlX2Rldi0+ZGV2LCByY3R4LT5zcmNfc2csIHJjdHgtPnNyY19uZW50cywN
Cj4gPiArCQkJICAgIERNQV9UT19ERVZJQ0UpOw0KPiA+ICsJaWYgKCFzZ19sZW4pIHsNCj4gPiAr
CQlkZXZfd2FybihoYWNlX2Rldi0+ZGV2LCAiZG1hX21hcF9zZygpIHNyYyBlcnJvclxuIik7DQo+
ID4gKwkJcmMgPSAtRU5PTUVNOw0KPiANCj4gRGlyZWN0IHJldHVybiwgYXMgZG9uZSBpbiB2MSwg
bG9va3MgZmluZSB0byBtZS4gQnV0IGl0IGlzIG1vc3RseSBhIG1hdHRlciBvZiB0ZXN0LCBJDQo+
IGd1ZXNzLg0KPiANCj4gPiArCQlnb3RvIGVuZDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlzcmNf
bGlzdCA9IChzdHJ1Y3QgYXNwZWVkX3NnX2xpc3QgKiloYXNoX2VuZ2luZS0+YWhhc2hfc3JjX2Fk
ZHI7DQo+ID4gKwlyY3R4LT5kaWdlc3RfZG1hX2FkZHIgPSBkbWFfbWFwX3NpbmdsZShoYWNlX2Rl
di0+ZGV2LCByY3R4LT5kaWdlc3QsDQo+ID4gKwkJCQkJICAgICAgIFNIQTUxMl9ESUdFU1RfU0la
RSwNCj4gPiArCQkJCQkgICAgICAgRE1BX0JJRElSRUNUSU9OQUwpOw0KPiA+ICsJaWYgKGRtYV9t
YXBwaW5nX2Vycm9yKGhhY2VfZGV2LT5kZXYsIHJjdHgtPmRpZ2VzdF9kbWFfYWRkcikpIHsNCj4g
PiArCQlkZXZfd2FybihoYWNlX2Rldi0+ZGV2LCAiZG1hX21hcCgpIHJjdHggZGlnZXN0IGVycm9y
XG4iKTsNCj4gPiArCQlyYyA9IC1FTk9NRU07DQo+ID4gKwkJZ290byBmcmVlX3NyY19zZzsNCj4g
PiArCX0NCj4gPiArDQo+ID4gKwlpZiAocmN0eC0+YnVmY250ICE9IDApIHsNCj4gPiArCQlyY3R4
LT5idWZmZXJfZG1hX2FkZHIgPSBkbWFfbWFwX3NpbmdsZShoYWNlX2Rldi0+ZGV2LA0KPiA+ICsJ
CQkJCQkgICAgICAgcmN0eC0+YnVmZmVyLA0KPiA+ICsJCQkJCQkgICAgICAgcmN0eC0+YmxvY2tf
c2l6ZSAqIDIsDQo+ID4gKwkJCQkJCSAgICAgICBETUFfVE9fREVWSUNFKTsNCj4gPiArCQlpZiAo
ZG1hX21hcHBpbmdfZXJyb3IoaGFjZV9kZXYtPmRldiwgcmN0eC0+YnVmZmVyX2RtYV9hZGRyKSkg
ew0KPiA+ICsJCQlkZXZfd2FybihoYWNlX2Rldi0+ZGV2LCAiZG1hX21hcCgpIHJjdHggYnVmZmVy
IGVycm9yXG4iKTsNCj4gPiArCQkJcmMgPSAtRU5PTUVNOw0KPiA+ICsJCQlnb3RvIGZyZWVfcmN0
eF9kaWdlc3Q7DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQlzcmNfbGlzdFswXS5waHlfYWRkciA9
IHJjdHgtPmJ1ZmZlcl9kbWFfYWRkcjsNCj4gPiArCQlzcmNfbGlzdFswXS5sZW4gPSByY3R4LT5i
dWZjbnQ7DQo+ID4gKwkJbGVuZ3RoIC09IHNyY19saXN0WzBdLmxlbjsNCj4gPiArDQo+ID4gKwkJ
LyogTGFzdCBzZyBsaXN0ICovDQo+ID4gKwkJaWYgKGxlbmd0aCA9PSAwKQ0KPiA+ICsJCQlzcmNf
bGlzdFswXS5sZW4gfD0gSEFTSF9TR19MQVNUX0xJU1Q7DQo+ID4gKwkJc3JjX2xpc3QrKzsNCj4g
PiArCX0NCj4gPiArDQo+ID4gKwlpZiAobGVuZ3RoICE9IDApIHsNCj4gPiArCQlmb3JfZWFjaF9z
ZyhyY3R4LT5zcmNfc2csIHMsIHNnX2xlbiwgaSkgew0KPiA+ICsJCQlzcmNfbGlzdFtpXS5waHlf
YWRkciA9IHNnX2RtYV9hZGRyZXNzKHMpOw0KPiA+ICsNCj4gPiArCQkJaWYgKGxlbmd0aCA+IHNn
X2RtYV9sZW4ocykpIHsNCj4gPiArCQkJCXNyY19saXN0W2ldLmxlbiA9IHNnX2RtYV9sZW4ocyk7
DQo+ID4gKwkJCQlsZW5ndGggLT0gc2dfZG1hX2xlbihzKTsNCj4gPiArDQo+ID4gKwkJCX0gZWxz
ZSB7DQo+ID4gKwkJCQkvKiBMYXN0IHNnIGxpc3QgKi8NCj4gPiArCQkJCXNyY19saXN0W2ldLmxl
biA9IGxlbmd0aDsNCj4gPiArCQkJCXNyY19saXN0W2ldLmxlbiB8PSBIQVNIX1NHX0xBU1RfTElT
VDsNCj4gPiArCQkJCWxlbmd0aCA9IDA7DQo+ID4gKwkJCQlicmVhazsNCj4gPiArCQkJfQ0KPiA+
ICsJCX0NCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAobGVuZ3RoICE9IDApIHsNCj4gPiArCQly
YyA9IC1FSU5WQUw7DQo+ID4gKwkJZ290byBmcmVlX3JjdHhfYnVmZmVyOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiArCXJjdHgtPm9mZnNldCA9IHJjdHgtPnRvdGFsIC0gcmVtYWluOw0KPiA+ICsJaGFz
aF9lbmdpbmUtPnNyY19sZW5ndGggPSByY3R4LT50b3RhbCArIHJjdHgtPmJ1ZmNudCAtIHJlbWFp
bjsNCj4gPiArCWhhc2hfZW5naW5lLT5zcmNfZG1hID0gaGFzaF9lbmdpbmUtPmFoYXNoX3NyY19k
bWFfYWRkcjsNCj4gPiArCWhhc2hfZW5naW5lLT5kaWdlc3RfZG1hID0gcmN0eC0+ZGlnZXN0X2Rt
YV9hZGRyOw0KPiA+ICsNCj4gPiArCWdvdG8gZW5kOw0KPiA+ICsNCj4gPiArZnJlZV9yY3R4X2J1
ZmZlcjoNCj4gPiArCWRtYV91bm1hcF9zaW5nbGUoaGFjZV9kZXYtPmRldiwgcmN0eC0+YnVmZmVy
X2RtYV9hZGRyLA0KPiA+ICsJCQkgcmN0eC0+YmxvY2tfc2l6ZSAqIDIsIERNQV9UT19ERVZJQ0Up
Ow0KPiANCj4gSWYgInJjdHgtPmJ1ZmNudCA9PSAwIiB0aGUgY29ycmVzcG9uZG5pbmcgZG1hX21h
cF9zaW5nbGUoKSBoYXMgbm90IGJlZW4NCj4gY2FsbGVkLiBJcyBpdCBhbiBpc3N1ZT8gKHRoZSB0
ZXN0IGV4aXN0cyBpbiBhc3BlZWRfYWhhc2hfdXBkYXRlX3Jlc3VtZV9zZygpLCBzbw0KPiBJIGd1
ZXNzIGl0IGlzIG5lZWRlZCkNCg0KWWVzLCBJIG1pc3MgdGhpcyBwYXJ0LiBJJ2xsIHJldmlzZSBp
dCBpbiBuZXh0IHBhdGNoLCB0aGFua3MuDQoNCj4gDQo+ID4gK2ZyZWVfcmN0eF9kaWdlc3Q6DQo+
ID4gKwlkbWFfdW5tYXBfc2luZ2xlKGhhY2VfZGV2LT5kZXYsIHJjdHgtPmRpZ2VzdF9kbWFfYWRk
ciwNCj4gPiArCQkJIFNIQTUxMl9ESUdFU1RfU0laRSwgRE1BX0JJRElSRUNUSU9OQUwpOw0KPiA+
ICtmcmVlX3NyY19zZzoNCj4gPiArCWRtYV91bm1hcF9zZyhoYWNlX2Rldi0+ZGV2LCByY3R4LT5z
cmNfc2csIHJjdHgtPnNyY19uZW50cywNCj4gPiArCQkgICAgIERNQV9UT19ERVZJQ0UpOw0KPiA+
ICtlbmQ6DQo+ID4gKwlyZXR1cm4gcmM7DQo+ID4gK30NCj4gPiArDQo+IA0KPiBbLi4uXQ0KDQo=
