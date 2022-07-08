Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860AB56B2D8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbiGHGg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbiGHGgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:36:51 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D522A438;
        Thu,  7 Jul 2022 23:36:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIoDdHMeckPN+taWpVQno0krpjFGrG3Mg+gODkpsPbKW+lH5PO8JGfWv8VmCjNLIEutVg6v553rmn/OunIUeyLj4lJsDExHJ4Y+QcmntAUQlSP3+bVUiRicFry18h1aC6QyMqL6ugkZO2811k+/LJ1oijae7OHLAgibdc0Is9yYv4T1vauaymUQCprLU/etbd5GYzXa7nyQjBBrR3x/RYrGUXysP6Yg7fcyx2X5mpvtaJLzs4Emu7QDQf2Ta3W7ruQlkUbdrzn+1Pw0IxzfjmtmfOlenL+nYWuTTnK2rFMDUZ41iv0EmNqwL9nL0Qgq/tlhM9bgxkv4UzJKS8bT+XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvi6l/9R5r70qOaSbqpFzolrkvLqiqj6/B9WS7ibLe0=;
 b=kzqtcVe7BEllw/09UoI2tGX4n5jfxKu78QgkTKDOAIVXcZ8UYdbPtXXDxyiiZ5sa5mBiZd/U8hHjxU035MBHr3wiPxusY5meBo1pszQomB+b2MfOTVJ5crTv0J0xP2MwO34j6vCDIqgzQqzPOAHjKIiGrdwSYBLHY028QGJncCIkcj5RfLqE4BQ7cT+oBDaodIEnRUN7hA7WbphMhjj1F8zh3wxpMkQ/7hrvA/SnheavT63CN6K+v40wpS23MZr6/sEHDduMAilSVPO3YtSsj4/dsAKLIODUDYbYy+j7+xwWLInmHkPNmHyJgcxaL6AonC7doBBQzTB2y966+nErjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvi6l/9R5r70qOaSbqpFzolrkvLqiqj6/B9WS7ibLe0=;
 b=ZF1UtBiEaXKzl9cbVY6hIcCg1wC1gi9Vt0o/BXWHAX7az1CTcdzkiiIpJ1XwAK/RjEfjAdbfpf9nOeCqX0+weKiNxKu4ZVd6EZcdkHoYerRN/WQc639+fRNEKsmTkjDntVPROTZMZyrEroE3p9WPzcPvK5b/lMYAaGMymk9VGlc=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM5PR0501MB3800.namprd05.prod.outlook.com (2603:10b6:4:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.13; Fri, 8 Jul
 2022 06:36:48 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%6]) with mapi id 15.20.5417.021; Fri, 8 Jul 2022
 06:36:47 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Barry Song <21cnbao@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
        "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
        "huzhanyuan@oppo.com" <huzhanyuan@oppo.com>,
        "lipeifeng@oppo.com" <lipeifeng@oppo.com>,
        "zhangshiming@oppo.com" <zhangshiming@oppo.com>,
        "guojian@oppo.com" <guojian@oppo.com>,
        "realmz6@gmail.com" <realmz6@gmail.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 2/4] mm: rmap: Allow platforms without mm_cpumask to defer
 TLB flush
Thread-Topic: [PATCH 2/4] mm: rmap: Allow platforms without mm_cpumask to
 defer TLB flush
Thread-Index: AQHYkgCLdJdNZ9epGk2/QG4z7TdV4610BjCA
Date:   Fri, 8 Jul 2022 06:36:47 +0000
Message-ID: <67943544-6DAA-4C8A-A04D-029D2D36C318@vmware.com>
References: <20220707125242.425242-1-21cnbao@gmail.com>
 <20220707125242.425242-3-21cnbao@gmail.com>
In-Reply-To: <20220707125242.425242-3-21cnbao@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 167bc43a-196a-43f9-08ff-08da60ac3bab
x-ms-traffictypediagnostic: DM5PR0501MB3800:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nImBQJ7bqyuSBFGrS6UUp7Ej/m+DqnJQOFadPTqe07ICsgFgEObJySYv/yrA7zhJ/34ocom0YwuQ6DUtD0AVwohudC65O3o+LUm7Zlz+hkZXqgAwH8jkwhFjNuH9QzVjgyrSR/0InkWr2IpInT+7N2hz1Rfk5/PSrviHHIao8WpkihBEdIrzuQMKkHd1PPU28Q4UMTuEBf0YGx8G0aGF7PWwhPdwRcenEmoIrN1ClBM5ea2axQnejffs8jxytbN7nwA6xsUEh7WH0VgRlmW9hVjT4V//ZyuyP6jjM3C3otgmXaGCGtye9SJMebeYEtuix3kB6o+gBkkAzQPlrBWmJU16WLaoZndbXAn/W6NxAqJLbTogB7RfF0hJPTm4ZGA9CUQwb6o4qExitolKNAwzoJf86+KAw/x7WcstVntl4wYE8M6lEoOSf/m9lWDwgvQynWNwX1gSIyRlYN7GzFhF14BjMW33r6nCgTMdi4UCcrkmMk//gbcZX2bwGX1dCP6jJMztoUPIDn7kMMQCZ4mfHG4WN1mO4nbz7A4tTzXRQmNMbZ93D5EtQYDj/JbvgYopbEqx3505BUl+jaP6SEoHe5RV81BmuRuTlvWclAerr0quMM/NOKJ82odzGHgiC318OuT0/zYnPpzxv6XyQH5Mk/B22R2v4CVL8p8H5fS6g6zr1b9MwqBez8xJDFW1ILtvtLI6bFreMFduQx1reJQcfsNWHmVul+m3Fp0PKqloynQwt/ZNPCH4DpsgkVsQadPMh72qY7IQx1h1KpscGKYNttzYqb6KNgdkUIU7MeKndlXUjSL+pvw6oU++i2ixOeb9fKHA0sWkZ8dlEQNIK3gBWE5Z1SpwTlLCaw4+G5NbO3I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(2906002)(71200400001)(6512007)(122000001)(478600001)(6486002)(53546011)(86362001)(2616005)(4326008)(41300700001)(33656002)(6506007)(26005)(36756003)(38070700005)(54906003)(64756008)(186003)(5660300002)(6916009)(316002)(66556008)(66446008)(8936002)(83380400001)(7416002)(38100700002)(66946007)(8676002)(76116006)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aC9jbkcxaUlWSTd6OXh3SUtwYmRMZlErLzlMMXhTckpiWEdUSUc2SXc1cDVE?=
 =?utf-8?B?RkQwVUVDVmRCOW1ZbHhRQ3owWXJLS3grR2J3S0VFM1B0UnVWaXVMZWtPbHZQ?=
 =?utf-8?B?LzAwaFdOZk1BUnhKTzdlVHhTTW9LZkVYNThSTndoNU5xdExjeG1DM21QZ1pv?=
 =?utf-8?B?bE5UWmVGMEdFQXlsNXVZNFc0ZXM3UmFDYU5jS2cxNndicmNCN1FVUTRKSStp?=
 =?utf-8?B?dE5KVWQyd0NKN0k0QTJ2Q1F6d1QwTjlDbWJPcDd4NUFPMExLbEZvTlZUWlZu?=
 =?utf-8?B?TDFwODZoQjBGSUhaSUV2VUM4ajVRR2p2cytid2xrV3l6cUtkQTBZRG1qeWJB?=
 =?utf-8?B?b0tCV0JPV29kelQzVTRxendYR0swRzdjNE50aGxaU1pZeHEyWVROUnVLQ1BV?=
 =?utf-8?B?Si94eUlacG93SUNhSTNwSEljZVl0QkMvcVloSTNxemoxNXBFbE1JY3p4SEFR?=
 =?utf-8?B?SkkwVlZXODRIcU50UjI2SFhTSGpJd2pnbnhsZjVXcnVWbEdCUm52SlpnSzFX?=
 =?utf-8?B?Ym9GODlXZ1J3ME0rZ3BGR2FUanlPU3lSOUhZZmNRekxWbHE0TmxTMG92MHNp?=
 =?utf-8?B?THFUOUF6UEhyb2s0c01JcmUrcUFTT1lPTGtwN3ZtYXJTTUcrVGlXZUw2U21W?=
 =?utf-8?B?NTYzblNlWkNwVjBKTjZTNzd5L3Qvclh3S1cyN29pVUNZblNacDczbEhJRStI?=
 =?utf-8?B?bzE5Yjl2emJiVnZSQVpIV0pDZ2ovbUhTVkNSVEZqUmkyZENIOHdCVS9CTjY0?=
 =?utf-8?B?OXNkQ2VpYTFvZUxDd24ySERGVVZXYnQvcDVBaDhOd0dPQXgzYnQ1WXRQS1NH?=
 =?utf-8?B?RWM5R1Zja0JLRmIxWVVJVXZ4S3VWVUQwWHdyMmNzZEhWdGVBTDQ3SFVobE9N?=
 =?utf-8?B?UWE2VEd2WmpLTmFvL2dMVmcxazc3VDZheUVuRjlKQTd5K1lYNnpNQXlCQ1NE?=
 =?utf-8?B?elByQStzVHpFWm1ZNFh2ZEN5S3hlYktKT21OVEFoS3lHaHVjV1djSHdEUWo5?=
 =?utf-8?B?QU9oSlJKejdYdHZYNVdCN3NGdnJpZUR3Sk5IdjUrNkV0UGxIT2h4bzcyVTJX?=
 =?utf-8?B?TzUvQWhDdHgzUHBXWTFtaFBEajF3OUJnVG43WFR0YktXZFJOZkVEOHJKQkdp?=
 =?utf-8?B?OXBSQ25NcnpmQ3lmbi9ObkxONWNmdDg5TWN3cEE2dC9JUy8vSTFybms5TmRN?=
 =?utf-8?B?UkNxVjVMZFE4Qkxrb1lxMVg4OWJHRzAyd0toWVVwQTFZVkx3OUlNUjd2bFV1?=
 =?utf-8?B?VXVBZ0ltZEFRRzUwRHVHcENiZ2lMV2RibytBMTF5UVh2ajhCWGhPclNka1hP?=
 =?utf-8?B?cDlmazREYjNhSi9melJic2J4TmpxVzd3WnY0U1ZScU9lNnh2UWU1OEFYdVBv?=
 =?utf-8?B?dG00NXFwTk9tUTJDSWR2K0VYQ1pKZnY3cmkrNzIvZXFIeG5SWERKd1RKTVBj?=
 =?utf-8?B?ZUpEQ2Jta1h3WDFKdzBlc3YvY2F3cGNJemhSdEwwMUJpMDZjTTQveXdYMk5V?=
 =?utf-8?B?NHZRNk9XSmtqbGRuUUlhL1JLRlNMSSsybUpMOU9UZG1PR1Q5VTlsVnVSdW1h?=
 =?utf-8?B?ejExSHFCRzcrUVcvQVplTFlzVjN3dlJqRWxoM3NUemIxb3pxWGo2eGthVHU5?=
 =?utf-8?B?cytkZlhMNnZjaFNxN1hnZEpDK0Q5T0tGckFpT0tBUzlCbVpRMkU5b2JqNFRG?=
 =?utf-8?B?NHJDaVhkbjIzNk5ueFdCNGlDR0JTVkhVNzBtVnJucG9SNGJzUVRoWXl3bHJD?=
 =?utf-8?B?ZWhhTm1zTGlnSHBzWDFrM0VWZkYvWjVrT1cySDE3ckN2eWd6amNIOTJJNGdr?=
 =?utf-8?B?VlhjSGdSTmJkQlVKNko1eHJpZGVzY1dvV0J1RWhZbG1oOW1zczNxbGZhYUpB?=
 =?utf-8?B?NnFlUHd3MFBucEhzNjM2ZytqSlRBN1lMZzV0OU43VUwyelp0c2pWL2xvZzAv?=
 =?utf-8?B?S09ZMGt0K25ub1FrTzVOOS9DWTVLMEpoZXBMcFpQTzNObllrdDNCcFB0U1hU?=
 =?utf-8?B?bzRLcEVLa3dYN1YxM0sxcEdrNGtoejI3akc5Q0pnT2xOZG43ZDFNc2hPa0dq?=
 =?utf-8?B?c3ZoY0FFSE1XOGhwOTNhRWxOWmhSQTIwbG94TE5MUExwZ3JoYWFXNnZvdmQ0?=
 =?utf-8?Q?GewgOFCQhz3ZLKCCCJyYV0Jpq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CE9C16A6040A04F92BD8D4AD8F4AE79@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167bc43a-196a-43f9-08ff-08da60ac3bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 06:36:47.7896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bAO7pqF1zEp6J+d+OwGsYcUGSUOO/jAaDRwqTLK/hX3Ue9i+iAa+FClG3DQX1HBx5+Q0PDznov2lvHDNkdQ9Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0501MB3800
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSnVsIDcsIDIwMjIsIGF0IDU6NTIgQU0sIEJhcnJ5IFNvbmcgPDIxY25iYW9AZ21haWwuY29t
PiB3cm90ZToNCg0KPiBGcm9tOiBCYXJyeSBTb25nIDx2LXNvbmdiYW9odWFAb3Bwby5jb20+DQo+
IA0KPiBQbGF0Zm9ybXMgbGlrZSBBUk02NCBoYXZlIGhhcmV3YXJlIFRMQiBzaG9vdGRvd24gYnJv
YWRjYXN0LiBUaGV5DQo+IGRvbid0IG1haW50YWluIG1tX2NwdW1hc2sgYW5kIHRoZXkganVzdCBz
ZW5kIHRsYmkgYW5kIHJlbGF0ZWQNCj4gc3luYyBpbnN0cnVjdGlvbnMgZm9yIFRMQiBmbHVzaC4N
Cj4gU28gaWYgbW1fY3B1bWFzayBpcyBlbXB0eSwgd2UgYWxzbyBhbGxvdyBkZWZlcnJlZCBUTEIg
Zmx1c2gNCj4gDQo+IENjOiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KPiBDYzogTWVs
IEdvcm1hbiA8bWdvcm1hbkBzdXNlLmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBCYXJyeSBTb25nIDx2
LXNvbmdiYW9odWFAb3Bwby5jb20+Pg0KPiAtLS0NCj4gbW0vcm1hcC5jIHwgOSArKysrKysrLS0N
Cj4gMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9tbS9ybWFwLmMgYi9tbS9ybWFwLmMNCj4gaW5kZXggNWJjYjMzNGNkNmYy
Li5kMzIwYzI5YTRhZDggMTAwNjQ0DQo+IC0tLSBhL21tL3JtYXAuYw0KPiArKysgYi9tbS9ybWFw
LmMNCj4gQEAgLTY5Miw4ICs2OTIsMTMgQEAgc3RhdGljIGJvb2wgc2hvdWxkX2RlZmVyX2ZsdXNo
KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCBlbnVtIHR0dV9mbGFncyBmbGFncykNCj4gCWlmICghKGZs
YWdzICYgVFRVX0JBVENIX0ZMVVNIKSkNCj4gCQlyZXR1cm4gZmFsc2U7DQo+IA0KPiAtCS8qIElm
IHJlbW90ZSBDUFVzIG5lZWQgdG8gYmUgZmx1c2hlZCB0aGVuIGRlZmVyIGJhdGNoIHRoZSBmbHVz
aCAqLw0KPiAtCWlmIChjcHVtYXNrX2FueV9idXQobW1fY3B1bWFzayhtbSksIGdldF9jcHUoKSkg
PCBucl9jcHVfaWRzKQ0KPiArCS8qDQo+ICsJICogSWYgcmVtb3RlIENQVXMgbmVlZCB0byBiZSBm
bHVzaGVkIHRoZW4gZGVmZXIgYmF0Y2ggdGhlIGZsdXNoOw0KPiArCSAqIElmIEFSQ0hzIGxpa2Ug
QVJNNjQgaGF2ZSBoYXJkd2FyZSBUTEIgZmx1c2ggYnJvYWRjYXN0LCB0aHVzDQo+ICsJICogdGhl
eSBkb24ndCBtYWludGFpbiBtbV9jcHVtYXNrKCkgYXQgYWxsLCBkZWZlciBiYXRjaCBhcyB3ZWxs
Lg0KPiArCSAqLw0KPiArCWlmIChjcHVtYXNrX2FueV9idXQobW1fY3B1bWFzayhtbSksIGdldF9j
cHUoKSkgPCBucl9jcHVfaWRzIHx8DQo+ICsJICAgIGNwdW1hc2tfZW1wdHkobW1fY3B1bWFzayht
bSkpKQ0KDQpUaGUgY3B1bWFza19lbXB0eSgpIGlzIGluZGVlZCBqdXN0IGFub3RoZXIgbWVtb3J5
IGFjY2Vzcywgd2hpY2ggaXMgbW9zdA0KbGlrZWx5IG9rLiBCdXQgd291bGRu4oCZdCBhZGRpbmcg
c29tZXRoaW5nIGxpa2UgQ09ORklHX0FSQ0hfSEFTX01NX0NQVU1BU0sNCm1ha2UgdGhlIGNvZGUg
c2ltcGxlciBhbmQgKHNsaWdodGx5LCBjZXJ0YWlubHkgc2xpZ2h0bHkpIG1vcmUgcGVyZm9ybWFu
dD8NCg0K
