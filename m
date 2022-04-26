Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E4750F1B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343632AbiDZHIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbiDZHI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:08:27 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2125.outbound.protection.outlook.com [40.107.215.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315531AF0E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agW6tPYUMlGGH688hXkKSnlJbWw306WovIjlFqTg7BCVP+Uai/8Bw7vEUDxuSvOw3NbdNm6nT7XW32fZ7ayAXeggSKbZeYaVtv3rauVWyt0/MKryZzt9nEuT5Du15niBhfI0aXQRSXajhENlOx18IX06Zjaq8vAG7VXvSNgt0jyqoZ0xINu2rUBRYz9SvnznxDzRUmF/Ce/lj+ylZTsUEtk44KewqBmQmnl1tbl8wHzVYVKCyKXwD2BQRZdOScMLb99j7u0hpfj7zwIztcMutMjpC1y8HNvw99mcsXfm7WvA758y0vInAW1Rr8VszLpWNlYYVcZGzzqNse8JHmeXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ykc359i8eIfVhtgy8q3xG+QdXCEcxdVYejg5RX0ehs=;
 b=ZuVLn/9ikDjZE+RpNB/jdl7N7jvjaeHv0+kjSrxdBlU35BCYxLjHHd1vGdKu8mIxhXgqwLwjwGMSXKZU2/4mfcbpGRhNqYKNZ9QMOXIG9xHtwgCNxN3bo45jgkBxrl3dw/lxzoxkc+2rBGOcTkOHZA8ua4UYr2kQcfJ8NjGBvG8iQelQ4so17bAjUAIrLVSzPOshL3gq0ZRT1ApmOrR8WXqQCwenJeyUmrzodWqhH9QVELKuuJdn0Bc4ZaaEY54oQIivzzqq2+k0nMfmSXKOkvLV3QI02FY3a5/+xJBSccqTIIwdVvkryOI4jDs4DrToVXw4Y2SBqtMMS/cwhRRKhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ykc359i8eIfVhtgy8q3xG+QdXCEcxdVYejg5RX0ehs=;
 b=hRoOM8eJ+IoRX9wTNQjPGe6LxQwBVDF0dPPu7gUvX+6wtgyt/UKwLe7gD6NBbU3VxhZyu1qTNdCteI++/egeoSgpSaH1b0Fjxg48zpSt95WQV6fzeqZ6v8cymcGuoqDLoA9mS+bhpQ+l970Znop0znVZAuxNkB5BZtI1gekj5Kw=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SI2PR06MB5114.apcprd06.prod.outlook.com (2603:1096:4:1a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 07:05:15 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 07:05:15 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH V2 0/2] Add complex scheduler level for arm64
Thread-Topic: [PATCH V2 0/2] Add complex scheduler level for arm64
Thread-Index: AQHYVj9eoepewNo3DkqqNT3OlOoJ+60Aoa0AgADjxTGAAEP/AQ==
Date:   Tue, 26 Apr 2022 07:05:15 +0000
Message-ID: <SL2PR06MB30828131C046AB979BE75BD6BDFB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1650628289-67716-1-git-send-email-wangqing@vivo.com>
 <20220425141926.00004d2e@Huawei.com>
 <SL2PR06MB3082D393ADEC823426DEE7DFBDFB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
In-Reply-To: <SL2PR06MB3082D393ADEC823426DEE7DFBDFB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4af106d3-78c8-4725-d826-08da27531d68
x-ms-traffictypediagnostic: SI2PR06MB5114:EE_
x-microsoft-antispam-prvs: <SI2PR06MB5114F3CCA1AACD66904D281DBDFB9@SI2PR06MB5114.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZGZ2t7IsVIgfXhHxgZone0/FHS5Yk7qSq5XA4p7mN0knc6t7ehaBUEagcnlJsyqIrg3WC2XCgc1u9EcB4iigfvCB26O6TViqqnsfHiNBe1Txd4kXUWMfswcNivRk9DkKd43Qk/3C2M8MgSHicFp7XIoOy9WNQLbqh3Bl5sVGGQ6c2viuvFn5TMSe2pTdRpa5Qf3kHpNZD27T4p7ldxYvmWjlDBxooQJwnsbc1sFk1qSrYEa+D/cz5H3VdJA6MKrJlhjY6+Ddv09f6M5rABWwg0bbU5RFd89Nqidc0vR+IH0uxGAITllI2UDsZWb4zmWK2mGKfUh9/6K3oy2bmqTkYbLUp4s1SUVVzC1/SJXisCTKchtBeHI497EpQCo5WhNfqEBBjxtOj9FlYIkHdztlgmrifQsjdnU+4YRrKD0IEPR4/Hqe32T/yFveue/CcpDpnR24fN2RYDC9GucZBtaRyH9JzIfFKcpe07fB2HDnDts5GGK3Rn1rF/Aa2TOFWDP1cFKzUZWi8jwXQ1MIfgMh6SHmfJtPxLuBL02hswAbXu88GxNWE1aqY4XJsods8Llwy978RCUe3hd2rLYlquImLwERL+7VgZ1xX9R6VmKkPbyUrMu9Ah0xodA6UZa9+cTrLaAacr6Bs9f0+qs/r3Z0q0xaMWpvuKC3XseSNKCUmFWxWOxoGMTM3MtkmjROldkZrYVa3JK6eRIGaMVnjBPa/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(66946007)(66556008)(8936002)(52536014)(8676002)(91956017)(66476007)(66446008)(4326008)(33656002)(64756008)(83380400001)(508600001)(122000001)(6506007)(7696005)(86362001)(2906002)(9686003)(2940100002)(26005)(5660300002)(7416002)(54906003)(38100700002)(186003)(71200400001)(6916009)(55016003)(85182001)(316002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3NVOTBha3hFZTRPbXM0NWlNaEZicytJQTNHNFRYbHdUMmdabTF1ZDR6aXJZ?=
 =?utf-8?B?ZDNXV010RVRUSWZxa2VQSjZ4ODRmMnExdENqUkdqMC9ZLzFKbkQ5TnJxeWVm?=
 =?utf-8?B?eXRNOEdNTVUyV2hjeHZyMmd3NlZNT2pHdmhTU3d0SHh4am9xU1k2NjhqZ0Nx?=
 =?utf-8?B?cnhyWHNEMXo2Q2t6UzFpcUNRaU4rUkN1dlVKa0orNlBiR3FRVDRlZk1hcjk5?=
 =?utf-8?B?Rmdseko1cE50eUVUM3JtMkF0RkI1bThFZjFDc0x5Nmk0akh0dkNqOTNNY0V3?=
 =?utf-8?B?VE9Ydll1VTFaUDN5dWxLbkIzRjM5eG5RU2xHcXVwSzYzMURmcHN6SnU2NGpw?=
 =?utf-8?B?OVRQU1F0MkIvV3RWb0RnZTcxVG5MT2p6ZWF5cGpiWTEvdld5SlVEVmhwdUxi?=
 =?utf-8?B?VmJjYUh0emF6bTlwcTNwUjJ4RTZsK2NBYkllZGRNODd3dWRZWmtBOUROZTZk?=
 =?utf-8?B?WU1vcE5mTnArb21COFBSZHMxVEVQcXFkamE0d1pTSWpYTlFNU2diTE5VekVD?=
 =?utf-8?B?S1pkSlYvbmVMRitrN3piS09tUEFwTzBQdnRocWFUdk5yQ3RBUFdKV1JabXlu?=
 =?utf-8?B?ZmhkR3JWZUp6TERETit3OVBML1BCMTJrSXNjVU5XaUNZemRGaU14Q1dxK2tH?=
 =?utf-8?B?cHhnWWdzQ1BZZWVIbS8yOVQ0RWxSQml2THdhRzhxcEVrRERJYTRrOG1DZE50?=
 =?utf-8?B?NEdDSjFFSUVtdUpXL1lkOFhUa3dhdlpBVjkzaUtIb21ETjNWalZPZERnVzA0?=
 =?utf-8?B?SjdRRWlSVkRLenUrWkY5dmZXMEJQMTRSMDhkQW01VTBoNE1NZHNKS3lMSnli?=
 =?utf-8?B?aVVrWjdUSGxudG1UTkRtRTkwNm5HenhnSkl1eVJqQnpJVDFGdU9FTDR4TEFQ?=
 =?utf-8?B?eVA5eTlwMnduL3Vwa3Zmd2xFOExRdDdqZ2RHQmdaa2Rpdyt3dXJWZHgwVUJP?=
 =?utf-8?B?NE10YVdEVkNhRXJUb21ZMWZscUpnZEJnMDRmbjRXb1Uzb3VuTVRLU0Z0TjRk?=
 =?utf-8?B?aE1ZWERQa0Y1UFJhMi9mT0dRcSswdjZlQlBiWEZDYjlLTVUvT2N3eHE4YmxZ?=
 =?utf-8?B?WUVPa3NoSmY5aERtUGJUUm43NzZNcXl5OHhYdUl2Yk5BK1VHYnRpSmQ0Y216?=
 =?utf-8?B?WXVSeTc4Z2plL3RkMGhtRXFiblRndlM2QmpPaEwwcjVCNFZFeEVRUUVYZEl2?=
 =?utf-8?B?SUhqL0FGb1hPdFpqbG41czFoNUFhTzU3UjB0TXN0WDZnWE9GeU1HMDVKRUJP?=
 =?utf-8?B?bEE2M2d4bVRka00rb1d1N1RDY0lPem5XdUd3VWV2bWJFM3BQNGdNc29GUlRV?=
 =?utf-8?B?M0NxcGNXVmdDUmpiZ2ZVZWk0VmJuaXhyRnNLY1B2QU8zcmQxd2FDYUlEVlc2?=
 =?utf-8?B?MkxLeVhINktxMTRnYmFIVTc4UHlKeE5hNmZ1c2d4S2RYWXVOL09Ic3E1WU41?=
 =?utf-8?B?cWVna1RYNFBBaUtKVWV6WmNaWDZrTkZ2a2FDeHNuRngvOVA3anI1cCtVWkQv?=
 =?utf-8?B?ZmFrS3dzTCtwZ3NOdG14ZDQ0WnFGTFNTdWtra043WFUyY3A1aDlrSVhRZ1JS?=
 =?utf-8?B?dmlxTVNYeWtWL0ZYYmtVd0NLR0gxUDFUbUhBNmFpOEIzOGM1eGZqemFYYUt5?=
 =?utf-8?B?NEtlTzVvaE8ySFRyZ0Y4UENiOG45a0hYM012Yi9HOWlRQy9zKzJhdHlFMURI?=
 =?utf-8?B?MGJmZDF5OUJOb1JKQlpZd2oyMmJJaGREUzR1RTk1UDJLaTgyZnNRYjhIQXFT?=
 =?utf-8?B?MGZkRUZJYXBiNzhVeEhBMHBtYTc5c1NjaktvSUd4WTNOVDFJRXpNNVU4NTVv?=
 =?utf-8?B?RzFwQjYwRU9DaDVNK1ByRkprZ3IyQVJFMFRwMGxCY0pWU29yQmp1QWpvS2tT?=
 =?utf-8?B?RnRIT2RkQytIeW5xbTh3K1pwNkdHSWM2SUxwS1ZNQU9SQXhNMWNvNllPdUhn?=
 =?utf-8?B?SmZ3eHlnVnVFL0Q0L0FQM1UxWlZRdHZUYjQxK0ozaVk2Tytla050dTRBV0Ni?=
 =?utf-8?B?TW5iNnZMK0JGdThuYS82LzJwUXFoL1B0VWl5elpVLzVZSmc2SHBseFN1bjh1?=
 =?utf-8?B?bTlGa1crcmFiREM2czZJU1ozdXV6UDJTcHF5dkVKcm5mUWwyUjJxMVZpOWMx?=
 =?utf-8?B?aFJKRmNScFg2YUlBSGFDZ2dUeHd6WmxPYzdHVWhKd3JSemJMUzhqb3ppbG9P?=
 =?utf-8?B?eEtjMGJpNWJWc25QSkF4TUt4T2FpeEcvTXZZdnViZGI4S1pWNmRUVTd4VjZO?=
 =?utf-8?B?TGZmM3pHYzQ1azlRUkNJSUZSbGZqWHJma1Rpdmxqa2I2VHp4bUdZOWFTeHgz?=
 =?utf-8?Q?1rqRfZtP/+D0fQKn5u?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af106d3-78c8-4725-d826-08da27531d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 07:05:15.4900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zsnFgQ5vd7PAh5P5g+g7C1EGPAEWOvr3SNQt5UQqttxGen/bECHZeENsC2t5/vpbahPjQB9gPulzWlHZLOlUfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5114
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkhpIFN1ZGVlcDoKCkkgYW0gdGhpbmtpbmcgaWYgaXQgaXMgcG9zc2libGUgdG8gYWRkIGEgY29t
cGxleCBsZXZlbCBjcHUgdG9wb2xvZ3kKYmV0d2VlbiBjbHVzdGVyIGFuZCBTTVQ/CgpXZSBjYW4g
ZGVzY3JpYmUgaXQgZGlyZWN0bHkgaW4g4oCcY3B1LW1hcOKAnSwgaW5zdGVhZCBvZiBwYXJzaW5n
IGl0IHRocm91Z2gKdGhlIGNhY2hlIGluZm8uCgpUaGFua3MsClFpbmcKCj4+PiBGcm9tOiBXYW5n
IFFpbmcgPHdhbmdxaW5nQHZpdm8uY29tPgo+Pj4gCj4+PiBUaGUgRFNVIGNsdXN0ZXIgc3VwcG9y
dHMgYmxvY2tzIHRoYXQgYXJlIGNhbGxlZCBjb21wbGV4ZXMKPj4+IHdoaWNoIGNvbnRhaW4gdXAg
dG8gdHdvIGNvcmVzIG9mIHRoZSBzYW1lIHR5cGUgYW5kIHNvbWUgc2hhcmVkIGxvZ2ljLAo+Pj4g
d2hpY2ggc2hhcmluZyBzb21lIGxvZ2ljIGJldHdlZW4gdGhlIGNvcmVzIGNhbiBtYWtlIGEgY29t
cGxleCBhcmVhIGVmZmljaWVudC4KPj4+Cj4+Cj4+R2l2ZW4gdGhlIGNvbXBsZXggc2hhcmVzIHRo
aW5ncyBsaWtlIHRoZSBTVkUgdW5pdHMgKGNvcnRleCBhNTEwKS4uLgo+Pgo+PldoeSBub3QgaGFu
ZGxlIHRoaXMgYXMgU01UPwo+Cj5TTVQgc2hvdWxkIHNoYXJlIGFsbCBjYWNoZSBsZXZlbHMuIGJ1
dCBjb21wbGV4cyBvbmx5IHNoYXJlIEwyKGFuZCBMMykKPmNhY2hlIGhlcmUuCj4KPj4KPj5TZWVt
cyBsaWtlIGEgYmx1cnJlZCBib3VuZGFyeSBiZXR3ZWVuIHNlcGFyYXRlIGNvcmVzIGFuZCBTTVQg
dGhyZWFkcy4KPj5JIHRoaW5rIHdlIG5lZWQgdG8gZXhwcmVzcyBhbmQgcG90ZW50aWFsbHkgdGFr
ZSBhZHZhbnRhZ2Ugb2Yga25vd2xlZGdlCj4+YWJvdXQgd2hhdCBsb2dpYyBpcyBiZWluZyBzaGFy
ZWQuCj4KPkxvZ2ljIHN1Y2ggYXMgYSBWZWN0b3IgUHJvY2Vzc2luZyBVbml0LCBMMiBUcmFuc2xh
dGlvbiBMb29rYXNpZGUgQnVmZmVyCj4oVExCKSAuLi4gYXJlIHNoYXJlZCwgSSBiZWxpZXZlIHRo
aXMgd2lsbCBpbXByb3ZlIGVmZmljaWVuY3kgZXZlbiBpZgo+b25seSBMMiBjYWNoZSBpcyBzaGFy
ZWQuCj4KPlRoYW5rcywKPlFpbmcKPgo+Pgo+PkpvbmF0aGFuCj4+Cj4+PiBDb21wbGV4IGFsc28g
Y2FuIGJlIGNvbnNpZGVyZWQgYXMgYSBzaGFyZWQgY2FjaGUgZ3JvdXAgc21hbGxlcgo+Pj4gdGhh
biBjbHVzdGVyLgo+Pj4gCj4+PiBUaGlzIHBhdGNoIGFkZHMgY29tcGxleCBsZXZlbCBmb3IgY29t
cGxleHMgYnkgcGFyc2luZyBjYWNoZSB0b3BvbG9neQo+Pj4gZm9ybSBEVC4gSXQgd2lsbCBkaXJl
Y3RseSBiZW5lZml0IGEgbG90IG9mIHdvcmtsb2FkIHdoaWNoIGxvdmVzIG1vcmUKPj4+IHJlc291
cmNlcyBzdWNoIGFzIG1lbW9yeSBiYW5kd2lkdGgsIGNhY2hlcy4KPj4+IAo+Pj4gTm90ZSB0aGlz
IHBhdGNoIG9ubHkgaGFuZGxlIHRoZSBEVCBjYXNlLgo+Pj4gCj4+PiBWMjoKPj4+IGZpeCBjb21t
aXQgbG9nIGFuZCBsb29wIG1vcmUKPj4+IAo+Pj4gd2FuZ3FpbmcgKDIpOgo+Pj7CoMKgIGFyY2hf
dG9wb2xvZ3k6IHN1cHBvcnQgZm9yIGRlc2NyaWJpbmcgY2FjaGUgdG9wb2xvZ3kgZnJvbSBEVAo+
Pj7CoMKgIGFybTY0OiBBZGQgY29tcGxleCBzY2hlZHVsZXIgbGV2ZWwgZm9yIGFybTY0Cj4+PiAK
Pj4+wqAgYXJjaC9hcm02NC9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEzICsrKysr
KysrKysKPj4+wqAgYXJjaC9hcm02NC9rZXJuZWwvc21wLmPCoMKgwqDCoMKgwqAgfCA0OCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+Pj7CoCBkcml2ZXJzL2Jhc2UvYXJjaF90
b3BvbG9neS5jwqAgfCA0NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4+PsKg
IGluY2x1ZGUvbGludXgvYXJjaF90b3BvbG9neS5oIHzCoCAzICsrKwo+Pj7CoCA0IGZpbGVzIGNo
YW5nZWQsIDEwOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4g
