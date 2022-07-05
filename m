Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E35566348
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiGEGj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiGEGjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:39:25 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2081.outbound.protection.outlook.com [40.107.114.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F0A248
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 23:39:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cv0ngJyOdw9cEa7nVde3iuXOWUlStkbH7x7Cj6Wmvo4s5lwN+xxBaA7YiOWzmWNnefkXFdDf/ahyqHeAXiqrwrWH/HeEjdcYnjNS4CiawgoNUEdJZIO445AGUloCh89lnq62oo0vnaY9RU/kszy1X1JZXjgXdwVAYpWXaWogDlHanwbg4dc0UdYNX3kYs09PrujethGh1bziT1JDDA/GK9uuchstZb5JsJT/v/bgRqPo23EkS718n0e6GpkcyhgSEs7LdcVRAmoMZsqJkYIbaaxGKQ/7kXn/dr5BQ1dTjECoXD5qZA07fqS4a81yIhuTn26tqadn9UsxXHaND9xZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDiMWsPBfw2JDb8UzfjTYQX8+X1g5OD+Hq8uY4gjvcM=;
 b=HjBn/MNXBbsBBIcGr9DZpYzI/qz1ObR9DoEEzLEAyatDr4U4Wd1MkHsbTGZbAlEpK/Y1yo13wefwC7EB3ebUtBBXRY3ae866k9Ghzx3nGap4ZusPLiVHQH+3Fihc193m8SDSzFzO8TbsLBnAaji1LTh3mLzh3GifaRW55BmgEoUSBS42xiPsNdnCb5spiUmF80S6kKZb6jEa96Fs2i+wEWgWBYJj1NPYMNGnWXCh2vOqF9GYTxQFep72PNDtk6GgGfWmvOsUHPJdZOB74JymoMO7dRkEMG1sDeWEo5e6qV7/D4rHjDDCo0GLn2HjwiTI1IbwoWxnbv+l27O71cvxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDiMWsPBfw2JDb8UzfjTYQX8+X1g5OD+Hq8uY4gjvcM=;
 b=OQlaPRutwacPvz7NqtsCtvR16qialZQ1XCrJIxtN/sGNcVC0W3nnyvXe97AwS//D7HcObLYB/KPAkoYXaJNk0+Cc5F3GOQv+c8DIlH+PrgEXcRJa+UdUJfZwoJWgxvOzpy4dYG9F6lEzWyHTlcJrOZaUucCGyQfzQ96fq+kikI0=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB6286.jpnprd01.prod.outlook.com (2603:1096:400:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 06:39:20 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%6]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 06:39:20 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [mm-unstable PATCH v4 1/9] mm/hugetlb: check
 gigantic_page_runtime_supported() in return_unused_surplus_pages()
Thread-Topic: [mm-unstable PATCH v4 1/9] mm/hugetlb: check
 gigantic_page_runtime_supported() in return_unused_surplus_pages()
Thread-Index: AQHYkBVmsaw1fOUNYUuWE/DbNGRYha1vU7wA
Date:   Tue, 5 Jul 2022 06:39:20 +0000
Message-ID: <20220705063918.GA2508809@hori.linux.bs1.fc.nec.co.jp>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
 <20220704013312.2415700-2-naoya.horiguchi@linux.dev>
 <865207df-b272-c7c9-e90c-5748262d3d87@huawei.com>
In-Reply-To: <865207df-b272-c7c9-e90c-5748262d3d87@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dec603e-3400-4e2d-76c6-08da5e51175c
x-ms-traffictypediagnostic: TYCPR01MB6286:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pif0eAyObAK09gelripKvK/v1wUMZPBeZDT1xgRcfRQIotiKA+NWnhyOAXTpa3dv+ZP+wv/oJIgxuaPd0qBAcIsEuyzkUven7NEBTdSXVBGRjxiewYwgBSe+p6H9K06Psb4nWTHI/0tQL87SNOECpgybhEphJitnI6IMWRRZaFbgKB1SO2jCYvW19l/VSb1kbL0wfJEMOXE+DKTRw8unxIw5hNT+gBQv1asELwRTuXY08nw1TQQUrWptISvLNNpUAoHYbtngEIVx/U6Yz7fE39YvZ1UEFt39CyvLY159FwSgVZ4wjE6ATUa3GKs7nTXiHYOhkQuUUQxZh9b+tW/fhWqhIuAKZFy1Pwy7AcBTLsyIhLHQnwFjIrvXzX75bHbA2cVrnBcmpFrVXROC/HFNOq5CuWEzbJ1Uqy+G9eObOuPmy4jgYsoe6mCVmD5B0xiCHPuJ7eGt0WLxGBB4dH72E+2ufkvEremiE/2y7a+fggsk/jqFphG9XtyrKXN80jbVafluw95UEBLJRBef8WacrJsT3p8AYYpPbe5jCv/CJ9CgMc9K6X6PNnIlIeMHcPlN9YFJTzZX9/2gDBfkcftdVyPfkuTbV0ibgA/EGGxQAmpH3x+PGUoPnnVRbhynHrWGrhHK84t9hXad+sznGBq2ngcWzvtSKOKdILvRUpLnbtJ8PfxPTpPM4jgpJ72vSJT0r2vXlwt4IpqV1KmTDL08zBn2L9OrHcpf2nvYwWwX4UyFrm1Z9NsFmkUx2Iyz0bqaftMTeo2p/tM2zf9Uynli9jznzwDVSK5hR5xazLQUC1UKG4RA8LVfhVIS1Z0Arm2M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(7416002)(478600001)(53546011)(8936002)(9686003)(33656002)(41300700001)(6512007)(6486002)(5660300002)(6506007)(2906002)(86362001)(122000001)(26005)(82960400001)(64756008)(66446008)(38100700002)(55236004)(186003)(38070700005)(1076003)(85182001)(83380400001)(66556008)(76116006)(6916009)(316002)(54906003)(66476007)(71200400001)(8676002)(4326008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0VSbldTcDhaS1F6Q1doSDc2TzN6UjlodTZNTEpMUTZuamtBWHRmc1I4NXVK?=
 =?utf-8?B?bTg3TW5ma2NYMGgyNldLUlBIR2UwR3AwcS8zWXdoOUhrVFU3R1V1QXBGcUFO?=
 =?utf-8?B?UDN5Y1kxNkt3VkQ2cW1xSTJoYUx6N3VIVWhMSmRmK0Z6aVpBRk9XS3hYVnB1?=
 =?utf-8?B?bk9Va0dpaWNVSnZBcWtic2oyZ2N5T1M5OW1mTFpMK2QrRzcya0pKQjdwaGR2?=
 =?utf-8?B?VHdzSFFvWS9rZTlKaWNVRFVoTGxWcmFITDc0SXZ2czU5NjJnejYrcU1GdlZy?=
 =?utf-8?B?b1E0MXVFdnlLcmhPVCt3OEp5eFZEYXZLa0V1d0pNZWJjT1lCcEs0Z3B6ZVJE?=
 =?utf-8?B?QnF3WkZwSEFvWUxOQmZEaFNIVlBESS9RaGxHbDNBVE8za0tqTDIrQmJMT3hD?=
 =?utf-8?B?dEtNRUtWSlB5aDc0M09hYUM1aVErbk5OZlBOMjZmenlQYkhvamV6MjlxOEpr?=
 =?utf-8?B?eDZQWlJNa2M5RER0TGEreVd4aThmYnlGUU5Eb2VXbXIyc2hFaEQ1S3ZxeXhL?=
 =?utf-8?B?UHlnZXdMZDhWSkFDQWpRdkYzeWtyaTdCNU9jVys3b3hNUlpiUkVhZFp5MDlq?=
 =?utf-8?B?NzJGN3BQMFRndVBOUlZkNWRaM0lxbzJRREZXbW5uUlE4THBaRDFGWVVxN2V1?=
 =?utf-8?B?cENKenZ6dTg5WGxrUDlIZWFXZXIrUzRmM0VnS2FJbjc3RUFMRHhsazBQUU1s?=
 =?utf-8?B?RGJsUEcyeW8ybjR6bWJmUThUZk5rTXBjcENGbS9sdlB4VzRjcG1DRUJrN3Fv?=
 =?utf-8?B?bHN5SGlUTGNoUnZROXFkMWZEMmFEd1N2SnBZUWp2K0NWVWh0YkdCYkNmWnk3?=
 =?utf-8?B?S1ltNU94ekZyaHpuak42bUV1QytTYUhBY2NQRnRGYzZ2MmNSaHJON3JkWnBI?=
 =?utf-8?B?R0w2OHVQOGZYVDhDUzZGZU5oQVRTcE94ZENpenNUOSthVzRtbi92cHNhVGUw?=
 =?utf-8?B?b1hlR01YYWhVRE9BTGYvU1hMcTArUG5UT0ViL3h1ekt4dVEweFd2a3N0eDF0?=
 =?utf-8?B?YXU1RnBWMU9Gd2RXR2dacE9nRkd6VnhOZjhiZUpJRFYxcGNqSEFxRStLeGpk?=
 =?utf-8?B?c08ra2xSZW1zSjNyK0FwNjNVQVk3dCtPUEhoWUdFbWUxbkRwZUxvdjgvYzI0?=
 =?utf-8?B?b1h3L0tNeGd5SFBndXNmRklGWXpaYmNnZVRwWTlqRjdxcngwL3ZqakI3L1Z1?=
 =?utf-8?B?Rm5RS2N4R2RnR2xCTnZXQUZ2djkza1k2R2hIZmZPVG5EM2NGeWM0NzZ2M0ls?=
 =?utf-8?B?S29oKzlXZjFKQWVOUTlmSmFEMnA3REVyYWFFeW1ZMEY0YnZlTHVYSHpPMGI2?=
 =?utf-8?B?bytpNC80eTZJNzV0Y0c1bzNPTnFtTjJEVUtQRUdHNVJqazNxT3pWUVZlY2My?=
 =?utf-8?B?RmlyL1ZjelRyN25GaVp5YjNSZjhpRjZaMHNLblBGSzluRTJ0d2haUVVNNzg2?=
 =?utf-8?B?a0N5alJtdXVKMDlZaG1HaUFJZUFpbGpoZTlVQVBvNFhOdXRwZjJHYWhjTDkx?=
 =?utf-8?B?d01tczJHaE82azBxN2hDeS93VHBOUFFTaFV2blcrNi9ROVlhcnMwOHdDNGtB?=
 =?utf-8?B?ZHFHUlNkQnJ3N3Jod0JaS0E2NldNOWFPT09JNjFCL01rU2x6dDloZFpQYmRw?=
 =?utf-8?B?S2FTUVgxK2xJK0RMSm9Rd2taa0RLWldxQ0szdmxHd212bFZyaFVRU3NIeWMr?=
 =?utf-8?B?OGdSVlhwQ1JNREtUdnBEVFpoZCtMZXpjY1p6WXRMRUtJRC9WWEhBdi8wNTNZ?=
 =?utf-8?B?dWZZZFZML2ZtYUFMQXhEbWpjU24xcGpkM2srdXdUT1lzWnZWVU9XeHluVFhB?=
 =?utf-8?B?Z3dQTGZZMVlzZENPRmpuZWk2YWRIM0VJVFdVMXROeVFNeEFtUWxTblpSRHRw?=
 =?utf-8?B?aC9Ub09GTUg5ODFTK2dBcnJSNkFnZGxuclhvaG1XNzNvTXlMaGV4QXN5Q3NB?=
 =?utf-8?B?c3owRmtwWHpMeEZ6MWpnakhNUWJoa2VqcGxISjlvaHZ2VWk2R3d3eWFtMWlt?=
 =?utf-8?B?S0IwRWkxeWp5NmlrVUhnSUlERHJNQ3pnYWIrRjhkeXFvNGZraVJBZ2VFdjda?=
 =?utf-8?B?QXFxdi96eU03RENWYVBCbk5kN3d6N3R1clJ1ZzVINnFXVWpnYndBekxJRFJI?=
 =?utf-8?B?ZVgzeDQxSmU4L1QzY2JITUdsS1llRXB3MkdJYVpXRGw0Yk1rcmlxNjN3UnA1?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDDE01E291FB6044B05DC467A9C51193@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dec603e-3400-4e2d-76c6-08da5e51175c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 06:39:20.3019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UbYL4qe0asjeAzP7fLjfS+5K6cc9dWy9DOrbXP4ow/YG4pgZ/hOWLK4XZ4rL7thE2anFbFTLdRqmGVJPH3697g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6286
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdWwgMDUsIDIwMjIgYXQgMTA6MTY6MzlBTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi83LzQgOTozMywgTmFveWEgSG9yaWd1Y2hpIHdyb3RlOg0KPiA+IEZyb206
IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQo+ID4gDQo+ID4gSSBm
b3VuZCBhIHdlaXJkIHN0YXRlIG9mIDFHQiBodWdlcGFnZSBwb29sLCBjYXVzZWQgYnkgdGhlIGZv
bGxvd2luZw0KPiA+IHByb2NlZHVyZToNCj4gPiANCj4gPiAgIC0gcnVuIGEgcHJvY2VzcyByZXNl
cnZpbmcgYWxsIGZyZWUgMUdCIGh1Z2VwYWdlcywNCj4gPiAgIC0gc2hyaW5rIGZyZWUgMUdCIGh1
Z2VwYWdlIHBvb2wgdG8gemVybyAoaS5lLiB3cml0aW5nIDAgdG8NCj4gPiAgICAgL3N5cy9rZXJu
ZWwvbW0vaHVnZXBhZ2VzL2h1Z2VwYWdlcy0xMDQ4NTc2a0IvbnJfaHVnZXBhZ2VzKSwgdGhlbg0K
PiA+ICAgLSBraWxsIHRoZSByZXNlcnZpbmcgcHJvY2Vzcy4NCj4gPiANCj4gPiAsIHRoZW4gYWxs
IHRoZSBodWdlcGFnZXMgYXJlIGZyZWUgKmFuZCogc3VycGx1cyBhdCB0aGUgc2FtZSB0aW1lLg0K
PiA+IA0KPiA+ICAgJCBjYXQgL3N5cy9rZXJuZWwvbW0vaHVnZXBhZ2VzL2h1Z2VwYWdlcy0xMDQ4
NTc2a0IvbnJfaHVnZXBhZ2VzDQo+ID4gICAzDQo+ID4gICAkIGNhdCAvc3lzL2tlcm5lbC9tbS9o
dWdlcGFnZXMvaHVnZXBhZ2VzLTEwNDg1NzZrQi9mcmVlX2h1Z2VwYWdlcw0KPiA+ICAgMw0KPiA+
ICAgJCBjYXQgL3N5cy9rZXJuZWwvbW0vaHVnZXBhZ2VzL2h1Z2VwYWdlcy0xMDQ4NTc2a0IvcmVz
dl9odWdlcGFnZXMNCj4gPiAgIDANCj4gPiAgICQgY2F0IC9zeXMva2VybmVsL21tL2h1Z2VwYWdl
cy9odWdlcGFnZXMtMTA0ODU3NmtCL3N1cnBsdXNfaHVnZXBhZ2VzDQo+ID4gICAzDQo+ID4gDQo+
ID4gVGhpcyBzdGF0ZSBpcyByZXNvbHZlZCBieSByZXNlcnZpbmcgYW5kIGFsbG9jYXRpbmcgdGhl
IHBhZ2VzIHRoZW4NCj4gPiBmcmVlaW5nIHRoZW0gYWdhaW4sIHNvIHRoaXMgc2VlbXMgbm90IHRv
IHJlc3VsdCBpbiBzZXJpb3VzIHByb2JsZW0uDQo+ID4gQnV0IGl0J3MgYSBsaXR0bGUgc3VycHJp
c2luZyAoc2hyaW5raW5nIHBvb2wgc3VkZGVubHkgZmFpbHMpLg0KPiA+IA0KPiA+IFRoaXMgYmVo
YXZpb3IgaXMgY2F1c2VkIGJ5IGhzdGF0ZV9pc19naWdhbnRpYygpIGNoZWNrIGluDQo+ID4gcmV0
dXJuX3VudXNlZF9zdXJwbHVzX3BhZ2VzKCkuIFRoaXMgd2FzIGludHJvZHVjZWQgc28gbG9uZyBh
Z28gaW4gMjAwOA0KPiA+IGJ5IGNvbW1pdCBhYTg4OGE3NDk3N2EgKCJodWdldGxiOiBzdXBwb3J0
IGxhcmdlciB0aGFuIE1BWF9PUkRFUiIpLCBhbmQNCj4gPiBhdCB0aGF0IHRpbWUgdGhlIGdpZ2Fu
dGljIHBhZ2VzIHdlcmUgbm90IHN1cHBvc2VkIHRvIGJlIGFsbG9jYXRlZC9mcmVlZA0KPiA+IGF0
IHJ1bi10aW1lLiAgTm93IGtlcm5lbCBjYW4gc3VwcG9ydCBydW50aW1lIGFsbG9jYXRpb24vZnJl
ZSwgc28gbGV0J3MNCj4gPiBjaGVjayBnaWdhbnRpY19wYWdlX3J1bnRpbWVfc3VwcG9ydGVkKCkg
dG9nZXRoZXIuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95
YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gDQo+IFRoaXMgcGF0Y2ggbG9va3MgZ29vZCB0byBtZSB3
aXRoIGEgZmV3IHF1ZXN0aW9uIGJlbG93Lg0KDQpUaGFuayB5b3UgZm9yIHJldmlld2luZy4NCg0K
PiANCj4gPiAtLS0NCj4gPiB2MiAtPiB2MzoNCj4gPiAtIEZpeGVkIHR5cG8gaW4gcGF0Y2ggZGVz
Y3JpcHRpb24sDQo+ID4gLSBhZGQgIWdpZ2FudGljX3BhZ2VfcnVudGltZV9zdXBwb3J0ZWQoKSBj
aGVjayBpbnN0ZWFkIG9mIHJlbW92aW5nDQo+ID4gICBoc3RhdGVfaXNfZ2lnYW50aWMoKSBjaGVj
ayAoc3VnZ2VzdGVkIGJ5IE1pYW9oZSBhbmQgTXVjaHVuKQ0KPiA+IC0gYWRkIGEgZmV3IG1vcmUg
IWdpZ2FudGljX3BhZ2VfcnVudGltZV9zdXBwb3J0ZWQoKSBjaGVjayBpbg0KPiA+ICAgc2V0X21h
eF9odWdlX3BhZ2VzKCkgKGJ5IE1pa2UpLg0KPiA+IC0tLQ0KPiA+ICBtbS9odWdldGxiLmMgfCAx
OSArKysrKysrKysrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9tbS9odWdldGxiLmMg
Yi9tbS9odWdldGxiLmMNCj4gPiBpbmRleCAyYTU1NGYwMDYyNTUuLmJkYzQ0OTlmMzI0YiAxMDA2
NDQNCj4gPiAtLS0gYS9tbS9odWdldGxiLmMNCj4gPiArKysgYi9tbS9odWdldGxiLmMNCj4gPiBA
QCAtMjQzMiw4ICsyNDMyLDcgQEAgc3RhdGljIHZvaWQgcmV0dXJuX3VudXNlZF9zdXJwbHVzX3Bh
Z2VzKHN0cnVjdCBoc3RhdGUgKmgsDQo+ID4gIAkvKiBVbmNvbW1pdCB0aGUgcmVzZXJ2YXRpb24g
Ki8NCj4gPiAgCWgtPnJlc3ZfaHVnZV9wYWdlcyAtPSB1bnVzZWRfcmVzdl9wYWdlczsNCj4gPiAg
DQo+ID4gLQkvKiBDYW5ub3QgcmV0dXJuIGdpZ2FudGljIHBhZ2VzIGN1cnJlbnRseSAqLw0KPiA+
IC0JaWYgKGhzdGF0ZV9pc19naWdhbnRpYyhoKSkNCj4gPiArCWlmIChoc3RhdGVfaXNfZ2lnYW50
aWMoaCkgJiYgIWdpZ2FudGljX3BhZ2VfcnVudGltZV9zdXBwb3J0ZWQoKSkNCj4gPiAgCQlnb3Rv
IG91dDsNCj4gPiAgDQo+ID4gIAkvKg0KPiA+IEBAIC0zMzE1LDcgKzMzMTQsOCBAQCBzdGF0aWMg
aW50IHNldF9tYXhfaHVnZV9wYWdlcyhzdHJ1Y3QgaHN0YXRlICpoLCB1bnNpZ25lZCBsb25nIGNv
dW50LCBpbnQgbmlkLA0KPiA+ICAJICogdGhlIHVzZXIgdHJpZXMgdG8gYWxsb2NhdGUgZ2lnYW50
aWMgcGFnZXMgYnV0IGxldCB0aGUgdXNlciBmcmVlIHRoZQ0KPiA+ICAJICogYm9vdHRpbWUgYWxs
b2NhdGVkIGdpZ2FudGljIHBhZ2VzLg0KPiA+ICAJICovDQo+ID4gLQlpZiAoaHN0YXRlX2lzX2dp
Z2FudGljKGgpICYmICFJU19FTkFCTEVEKENPTkZJR19DT05USUdfQUxMT0MpKSB7DQo+ID4gKwlp
ZiAoaHN0YXRlX2lzX2dpZ2FudGljKGgpICYmICghSVNfRU5BQkxFRChDT05GSUdfQ09OVElHX0FM
TE9DKSB8fA0KPiA+ICsJCQkJICAgICAgIWdpZ2FudGljX3BhZ2VfcnVudGltZV9zdXBwb3J0ZWQo
KSkpIHsNCj4gPiAgCQlpZiAoY291bnQgPiBwZXJzaXN0ZW50X2h1Z2VfcGFnZXMoaCkpIHsNCj4g
PiAgCQkJc3Bpbl91bmxvY2tfaXJxKCZodWdldGxiX2xvY2spOw0KPiA+ICAJCQltdXRleF91bmxv
Y2soJmgtPnJlc2l6ZV9sb2NrKTsNCj4gPiBAQCAtMzM2Myw2ICszMzYzLDE5IEBAIHN0YXRpYyBp
bnQgc2V0X21heF9odWdlX3BhZ2VzKHN0cnVjdCBoc3RhdGUgKmgsIHVuc2lnbmVkIGxvbmcgY291
bnQsIGludCBuaWQsDQo+ID4gIAkJCWdvdG8gb3V0Ow0KPiA+ICAJfQ0KPiA+ICANCj4gPiArCS8q
DQo+ID4gKwkgKiBXZSBjYW4gbm90IGRlY3JlYXNlIGdpZ2FudGljIHBvb2wgc2l6ZSBpZiBydW50
aW1lIG1vZGlmaWNhdGlvbg0KPiA+ICsJICogaXMgbm90IHN1cHBvcnRlZC4NCj4gPiArCSAqLw0K
PiA+ICsJaWYgKGhzdGF0ZV9pc19naWdhbnRpYyhoKSAmJiAhZ2lnYW50aWNfcGFnZV9ydW50aW1l
X3N1cHBvcnRlZCgpKSB7DQo+ID4gKwkJaWYgKGNvdW50IDwgcGVyc2lzdGVudF9odWdlX3BhZ2Vz
KGgpKSB7DQo+ID4gKwkJCXNwaW5fdW5sb2NrX2lycSgmaHVnZXRsYl9sb2NrKTsNCj4gPiArCQkJ
bXV0ZXhfdW5sb2NrKCZoLT5yZXNpemVfbG9jayk7DQo+ID4gKwkJCU5PREVNQVNLX0ZSRUUobm9k
ZV9hbGxvY19ub3JldHJ5KTsNCj4gPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwkJfQ0KPiA+
ICsJfQ0KPiANCj4gV2l0aCBhYm92ZSBjaGFuZ2UsIHdlJ3JlIG5vdCBhbGxvd2VkIHRvIGRlY3Jl
YXNlIHRoZSBwb29sIHNpemUgbm93LiBCdXQgaXQgd2FzIGFsbG93ZWQgcHJldmlvdXNseQ0KPiBl
dmVuIGlmICFnaWdhbnRpY19wYWdlX3J1bnRpbWVfc3VwcG9ydGVkLiBEb2VzIHRoaXMgd2lsbCBi
cmVhayB1c2VyPw0KDQpZZXMsIGl0IGRvZXMuIEkgbWlnaHQgZ2V0IHRoZSB3cm9uZyBpZGVhIGFi
b3V0IHRoZSBkZWZpbml0aW9uIG9mDQpnaWdhbnRpY19wYWdlX3J1bnRpbWVfc3VwcG9ydGVkKCks
IHdoaWNoIHNob3dzIHRoYXQgcnVudGltZSBwb29sICpleHRlbnNpb24qDQppcyBzdXBwb3J0ZWQg
b3Igbm90IChpbXBseWluZyB0aGF0IHBvb2wgc2hyaW5raW5nIGlzIGFsd2F5cyBwb3NzaWJsZSku
DQpJZiB0aGlzIGlzIHJpZ2h0LCB0aGlzIG5ldyBpZi1ibG9jayBpcyBub3QgbmVjZXNzYXJ5Lg0K
DQo+IA0KPiBBbmQgaXQgc2VlbXMgaXQncyBub3QgYWxsb3dlZCB0byBhZGp1c3QgdGhlIG1heF9o
dWdlX3BhZ2VzIG5vdyBpZiAhZ2lnYW50aWNfcGFnZV9ydW50aW1lX3N1cHBvcnRlZA0KPiBmb3Ig
Z2lnYW50aWMgaHVnZSBwYWdlLiBTaG91bGQgd2UganVzdCByZXR1cm4gZm9yIHN1Y2ggY2FzZSBh
cyB0aGVyZSBzaG91bGQgYmUgbm90aGluZyB0byBkbyBub3c/DQo+IE9yIGFtIEkgbWlzcyBzb21l
dGhpbmc/DQoNCklmIHBvb2wgc2hyaW5raW5nIGlzIGFsd2F5cyBhbGxvd2VkLCB3ZSBuZWVkIHVw
dGRhdGUgbWF4X2h1Z2VfcGFnZXMgc28sDQp0aGUgYWJvdmUgaWYtYmxvY2sgc2hvdWxkIGhhdmUg
ImdvdG8gb3V0OyIsIGJ1dCBpdCB3aWxsIGJlIHJlbW92ZWQgYW55d2F5DQpzbyB3ZSBkb24ndCBo
YXZlIHRvIGNhcmUgZm9yIGl0Lg0KDQpUaGFuayB5b3UgZm9yIHRoZSB2YWx1YWJsZSBjb21tZW50
Lg0KDQotIE5hb3lhIEhvcmlndWNoaQ==
