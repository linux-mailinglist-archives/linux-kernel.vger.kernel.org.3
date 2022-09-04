Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E555F5AC48E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiIDNtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 09:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiIDNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 09:49:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BDC12776
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 06:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662299379; x=1693835379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ew4CboirgueGJHBF+Budl880uqcyJRG7HCe07KL9FNY=;
  b=cHnYdpYP5NpUnWo/vUGDh25gHHpXDjdzpMcrYPZLDvvwhphkZ5zLrqpJ
   rQSpts3c6dHeS1QOzZDCa3VYR630TgmVMbHXt6mCA5OuGPS96vBa2e0af
   RKHGnKGE92KJnfNLol27GcqZregR3q88j6x7HxBQdiWPajhAvLicbNDnv
   pr3n5Il/TVVZ5qDa5fm81ptsTQUVltzEYY21/31TAWnFZOAEoNd0G+BWG
   sIMTmJA6OWsNcjfpueGDNscwRiSLhU3M+erzBzUzbRB8fVuCQ/suPaOM9
   Sezguv6/3zpvAzGqd0Gi8B2hhopxmvzJPMykDuT6XgRdy7qF2/tzzkr4E
   A==;
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="178987176"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Sep 2022 06:49:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 4 Sep 2022 06:49:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Sun, 4 Sep 2022 06:49:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddlSnYE8e7ZXQMwiKp1a639NQu/UPQj9mheOhWk6zR+/rLVfqbXwMqzY5V5y63jEoVjQyuJi8/R0fllSsAau3oTiW3lDhHVeBX4U1GmWVj2OQOY4DBX4E/N9VR5YOTmB9vxMGs0MHNR77J7y2vp7OPQ9yOjh1o5vACe42mxZSuXocrCNIZKG/qo/rObug9wDcBclpSY4AfNAFKQMXohPNV2g4gOzZHKqunyQj0osmDv58pBjvTAAAC7BsECYgPOdr0B1JSMaLhu+fwNsU1fZ4DHL937DSzOZdQKamD3jyUcAbndbShIbxo6XtGqgoA+cyHWx/4c/xvkRVryiBP57GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ew4CboirgueGJHBF+Budl880uqcyJRG7HCe07KL9FNY=;
 b=SM6bUDEVbwPcXHkjYU5vI4NhWNblVjf3Xlq6SXM2h5zB0yKQIVIsmKOVmDv0yAZphtUbrpAoDvVwBqwVgeK2eY9yq++OUuUKoDbzIw3KSF85Yrta94l9l4yM5hfnHOzyEygWYR6Ok2/0u3S0Lxxg+FxADPT+Adu+yBs1LVlVVFYqQXd53iaTlLHutE8V5SFQ79yOrVs0OF0EKMrGfixkd0eSnI6zQ2AQR0n8LT7D2AJrgfZpAgpuuvP+QsrC3rYPmB72YzrL5K9Vm4KbaPpP+t4ocnNf8ChE9xc8ImiUTVQlxU3RjUQgHCPeKEENDrJXBTJeUKeCDXN3QODWSC9+QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew4CboirgueGJHBF+Budl880uqcyJRG7HCe07KL9FNY=;
 b=s+ttDLAYdnCAy+HSwzey+64BRXJikT+/WCQAXdSxUA0SALVlP4APHEyv/U6QyzY3fzOcEMdp15tT4cRH3LAc1sGiyEtmr6IiFURaXMuFPFz1+zKaMgJ7PvW2g22R5hhPPn7pzBnCYpk5gkj3avDR0SC0Ru5fVBLomrA0ceXf8U8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Sun, 4 Sep
 2022 13:49:32 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.018; Sun, 4 Sep 2022
 13:49:32 +0000
From:   <Conor.Dooley@microchip.com>
To:     <tjytimi@163.com>, <anup@brainfault.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <alexandre.ghiti@canonical.com>,
        <guoren@kernel.org>, <heiko@sntech.de>,
        <akpm@linux-foundation.org>, <panqinglin2020@iscas.ac.cn>,
        <tongtiangen@huawei.com>, <sunnanyong@huawei.com>,
        <anshuman.khandual@arm.com>, <atishp@rivosinc.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <falcon@tinylab.org>
Subject: Re: [PATCH v2] riscv: make update_mmu_cache to support asid
Thread-Topic: [PATCH v2] riscv: make update_mmu_cache to support asid
Thread-Index: AQHYwGPrK5mEUolM90m5Gg8OY7SJ1a3PSYmA
Date:   Sun, 4 Sep 2022 13:49:31 +0000
Message-ID: <7e17ceaf-6648-e099-d526-8b698eaa5a04@microchip.com>
References: <20220904133710.117263-1-tjytimi@163.com>
In-Reply-To: <20220904133710.117263-1-tjytimi@163.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb0a6b91-0e66-4c19-fb6c-08da8e7c4b75
x-ms-traffictypediagnostic: DM5PR11MB1899:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G7HwX72RqGJQooz5vqQ5BdhSHNQWCMq8llF0DYwEd2PYzsBReGgYvagcXV3UwTEOhNj5rjECEUNbUPBopt4ctt8gsIFsVbawoO1Z8VxnBZ6v+S/c8b5B3sPXy9yplONvmvb7Xxp7ExiAa1eluLAKYaR1MeB5FduYRhqr15MVD7cfU7YnFk8zIfCfVOeUG9S74q3hl/6LHTniUV70gdPpSDcri3G+E37OrbiCZVLEZSodsAVb8mrZNZrKBslQKqX8zKRTjiMnr4UojU3i5hBgf/4LiSgofCHp99u+rFzL7THXlZ2oEpfKkbYTsndEMbtbwTfNsY3C1gu+Mi4HWB5j/8UYA17GVN2YdUJKzSpz8wsLw5WZeD/FRiKW0MVd8+H2m1CiLmBbb7BySVKgG4XeR40q2Lvwt+EOSPNaiEIeHkXEuKxuSCwvcec7bjM9QylbyZj9ZrMpioO8dAQviS2GWzBD9dsnqq0iY9jYJKHNLyiTcy5i+DsJMOinEt8FdlxOQT+F15XiA3vrejQUi+dwKandVa1ydxNzPVTlXs8KozFsImZNAHHnWoubMpxTLb68XgeWGxh1JlGu2gO+E0z597g0AqvibiBrUw7q3SS+qOAgnpLwiLg+hXNsAMndk0sbGGmo4S0HpMpNO9+71bBfJHbO/yiqsQocQd3IH+ZT02HUoU3d1i4LWtvZ0yV0Cvwo1CyIwmu0qUamOwfHeWbYhqTfIxKmQS+9J0O0+yfrc4YxAGhA+zOdUB3TyWzTZXY17nDpHkuuFw8myzU8fpucjDv+sx1vmQMbfHctGAsH1SAvm61a3XMvP8iPzyQInObvyfBqpDNP0kkfqkAsehS74YKWqiqCkzYjrAIqb93eYcw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(366004)(376002)(396003)(39850400004)(41300700001)(478600001)(71200400001)(6506007)(6512007)(26005)(91956017)(66476007)(64756008)(4326008)(66556008)(66946007)(2906002)(15650500001)(76116006)(66446008)(86362001)(38070700005)(31696002)(36756003)(921005)(31686004)(316002)(110136005)(54906003)(6486002)(53546011)(122000001)(38100700002)(2616005)(186003)(5660300002)(8676002)(7416002)(8936002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTcvZ1F4elRRKzgzTHVPKy9CQzhFc2lsZ0Y5VEQyeURoMFVRdGFqRjZzeEw2?=
 =?utf-8?B?Q010OU9OQUI4bnBlcXc4aTk1SnZvSVVlZ1dCSXpOYzhUTG12M0RITmpZWThS?=
 =?utf-8?B?dktCMXRyaHVkSDBha3hCS0RmSVpoVzhiSDhBTVV6NnNPVjFzTSs0bkhzQ2t6?=
 =?utf-8?B?WTBnSTl4MDRUeVVQMjlEM0tMd2JrRWc3cmoxbEg1Snl0NjJveEorZGpkVXBS?=
 =?utf-8?B?S2R0Wis0UkVpUHV6T1hOT2lMMEJzQWFMaHMzNTlFSUZOczdIa0kvNGt0d3Ri?=
 =?utf-8?B?THBuVk93Sm1IOE1TMXF3MVk1bFpERmd2M1gybWlDSXNyVTl6VHN3VGdoMzBq?=
 =?utf-8?B?S2RQVGNzOS9rRjk5aXdnQm93NTU3SmFCVzE3NWIzSXlkOEpSV3V5WXVIbE5l?=
 =?utf-8?B?OGRseDFrSGU2bEdHRENndWkwOG5xQ0lMSHNFUjhNWllTWkMwcGloUmR3RmNY?=
 =?utf-8?B?NWpoZFZDeUJtYmF6STlnSzNVSUxCcGVCdHdhekVnYXRqL1E5OVhFZXpjanBB?=
 =?utf-8?B?eVR4QmhwTXZ6YTBWbzJEdUE5NjRUb1dGcnQraXhxVkhPRXQzTEJhMDdDNVZM?=
 =?utf-8?B?UVVEdkplek50ZUlqVHBmK2ZQRlFOdnVJUXd5Q2ZsbHJnaHNCd2FhcWdMTWdD?=
 =?utf-8?B?QStleVFNK2ZIMjZvWHl2RzErTS95NUJscCtKeStlUWxEaXBYWWhwZjRIOC83?=
 =?utf-8?B?WjZ2U2JlZjVQQnVYZFVWMXFjUERRNzB4d0FVQmRDNVVwa3FzdnUwU0lscW0y?=
 =?utf-8?B?YXgxeEczUXlqZGZJSUJZbzBoSU1SQWlZdEpoL0d3SVpwa2xWMm41a2thUVJq?=
 =?utf-8?B?MHo1bmJkWE1pVUJSUnhWeEI4UWtUNkRKaUN0WGVRVGJqS2l4d2ZLUU9rdmIx?=
 =?utf-8?B?ejREeU9sWHVXdXlIYnRaWmdPZzRUemlETlVRM01BcHhuVjFEVkJpYXRnZ0Vq?=
 =?utf-8?B?TGg1RUszT1I5clNTWGRUWmh4a2NJaU1kZS9hSmhwbEs5bTZSSDlLMXNURDRS?=
 =?utf-8?B?LzdaWVR1SjdZbFpkUWJBaWU3UzRTUGhwWFFEZDJBQUxLVDE5NjdPc3lKbE5r?=
 =?utf-8?B?RmdrSkswYnNmT0VGV1MzS21pOEZxM0ZqTzM5UHMvSUlBb0ZzazZzcXRwNzdm?=
 =?utf-8?B?Z3BLWWlPRmhFVTBYelluMWRWcXhhd3BwWXE5cW5kZ0lNT0hPWEpybngxYWRz?=
 =?utf-8?B?ZkxBVEVhR3JpTVlCYU1VdU9lV3hjdlptTXc5SDg1cWhOQkJMdEcvUkFOd2c3?=
 =?utf-8?B?OFhOS0VyUDcwb1RIZkMyYnpTTlg0bnhRS1M5c1pZRzRqK2dObU0vTEZoM2RI?=
 =?utf-8?B?U2gzWEwyY3dvYm1IQ1BSeGkyWDdFaVhGbXBQVVhUVEtHTTVWT1RLS1FzcWhr?=
 =?utf-8?B?QVVzL3JzWWdELzRqWmo4WGg0OFJ6c3pvQlZETFdxbE5kQys2eDE2QkQwKzQx?=
 =?utf-8?B?a2t5U2xsaS9uY3U3WVBRdGdrYUFtNEZYMlZqVThPcEtPa1dwbTkzWS9waFg3?=
 =?utf-8?B?WkdnVE1EQXNMamlKNFg4ZjY1VVQydzV0TEY0a1l6VVNDNkl0TUdxVlUwNzk5?=
 =?utf-8?B?UEVrMkl3YWovNlFoQVBGRFgzNEtNM1FzeXY5aXlaVjl2bnpmTk1DTS9kajFt?=
 =?utf-8?B?cE1TdTgxamVZYnRiMnMyWjdGb3FLaldVV1VqRVZlTnA4TmZLYzJhVnhwdUh2?=
 =?utf-8?B?bitONUJ4dUxYK1hZZXYvZllGM1d3aDkzU3YreFFaSHc1NEF5d21pNTg2ckxC?=
 =?utf-8?B?aHZvdVdsV1JCWlNXbW9OdkVSSnEwZ0ttT214Ky85Qi9JcG4rdkpPdGM1eEtB?=
 =?utf-8?B?ZlAwSlhXKzUxKzQ2ZzF1UEZMbDZrZG9JbXBSbjlLdUZ5NHpQN28rVWdoVk1O?=
 =?utf-8?B?Yjdvc1BPcHF3Q2pDYVVubHNYSy9SU1RSMTE1U2NDMTNMWHNzY2lTdW9PVUp0?=
 =?utf-8?B?N2lyeWJzWWZRQXNZN1VuQ2dlcDhGbS9BYTBnRE56Qko3UjFhTW4yeWhSZ3o0?=
 =?utf-8?B?bktpcVoxL213TnpDRUVGS0FncXFHdHVxMG1NU3dDS3ZvaHV3NUlmRExnakdh?=
 =?utf-8?B?VEUxZEZyaFJjeFFXUnpUYytKQVIyaEJRZWI3Y3hIWXhzWXo3ZmhVZFlraGhq?=
 =?utf-8?Q?m9R4oYhqMN+SWzSB9v/fxcvOU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38AE679CFC243643B069B1621BD2EB03@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0a6b91-0e66-4c19-fb6c-08da8e7c4b75
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2022 13:49:31.9302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQ+6IVnsRfDDlLUeW4Khi4D0sWsxdeF+eLO2MuaV1aY3+TH5S9Mva06C6Q590xIoFpSih613xVxalgpj/FsQJpoH0gObDWIMoZQzy2kE2f0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1899
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQvMDkvMjAyMiAxNDozNywgSmlueXUgVGFuZyB3cm90ZToNCj4gVGhlIGB1cGRhdGVfbW11
X2NhY2hlYCBmdW5jdGlvbiBpbiByaXNjdiBmbHVzaCB0bGIgY2FjaGUgd2l0aG91dCBhc2lkDQoN
CkZXSVcsIHdoZW4gcmVmZXJyaW5nIHRvIGZ1bmN0aW9ucyBwbGVhc2UgcHV0IHRoZSAoKSBhdCB0
aGUgZW5kLg0KTWFrZXMgdGhlIGNoYW5nZWxvZyBtb3JlIG5hdHVyYWwgdG8gcmVhZC4gWW91IGRv
IG5vdCBuZWVkIHRvIG1ha2UNCmEgdjMgZm9yIHRoYXQgdGhvdWdoLg0KDQpUaGFua3MsDQpDb25v
ci4NCg0KPiBpbmZvcm1hdGlvbiBub3csIHdoaWNoIHdpbGwgZmx1c2ggdGxicyBpbiBvdGhlciB0
YXNrcycgYWRkcmVzcyBzcGFjZQ0KPiBldmVuIGlmIHByb2Nlc3NvciBzdXBwb3J0cyBhc2lkLiBT
byBhZGQgYSBuZXcgZnVuY3Rpb24NCj4gYGZsdXNoX3RsYl9sb2NhbF9vbmVfcGFnZWAgdG8gZmx1
c2ggbG9jYWwgb25lIHBhZ2Ugd2hldGhlciBwcm9jZXNzb3INCj4gc3VwcG9ydHMgYXNpZCBvciBu
b3QsZm9yIGNhc2VzIHRoYXQgbmVlZCB0byBmbHVzaCBsb2NhbCBvbmUgcGFnZSBsaWtlDQo+IGZ1
bmN0aW9uIGB1cGRhdGVfbW11X2NhY2hlYC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEppbnl1IFRh
bmcgPHRqeXRpbWlAMTYzLmNvbT4NCj4gLS0tDQo+IFJGQyBWMSAtPiBWMiA6IA0KPiAxLlJlYmFz
ZWQgb24gUEFUQ0g5IG9mIElQSSBpbXBvcnZlbWVudCBzZXJpZXMgYXMgQW51cCBQYXRlbA0KPiBz
dWdnZXN0aW9uLiANCj4gMi5NYWtlIGNvbW1pdCBsb2cgbW9yZSBjbGVhci4NCj4gDQo+ICBhcmNo
L3Jpc2N2L2luY2x1ZGUvYXNtL3BndGFibGUuaCAgfCAgMiArLQ0KPiAgYXJjaC9yaXNjdi9pbmNs
dWRlL2FzbS90bGJmbHVzaC5oIHwgIDIgKysNCj4gIGFyY2gvcmlzY3YvbW0vdGxiZmx1c2guYyAg
ICAgICAgICB8IDExICsrKysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1
ZGUvYXNtL3BndGFibGUuaCBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vcGd0YWJsZS5oDQo+IGlu
ZGV4IDdlYzkzNjkxMGE5Ni4uMDljY2VmYTZiNmM3IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2
L2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3Bn
dGFibGUuaA0KPiBAQCAtNDE1LDcgKzQxNSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB1cGRhdGVf
bW11X2NhY2hlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLA0KPiAgCSAqIFJlbHlpbmcgb24g
Zmx1c2hfdGxiX2ZpeF9zcHVyaW91c19mYXVsdCB3b3VsZCBzdWZmaWNlLCBidXQNCj4gIAkgKiB0
aGUgZXh0cmEgdHJhcHMgcmVkdWNlIHBlcmZvcm1hbmNlLiAgU28sIGVhZ2VybHkgU0ZFTkNFLlZN
QS4NCj4gIAkgKi8NCj4gLQlsb2NhbF9mbHVzaF90bGJfcGFnZShhZGRyZXNzKTsNCj4gKwlmbHVz
aF90bGJfbG9jYWxfb25lX3BhZ2Uodm1hLCBhZGRyZXNzKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGlj
IGlubGluZSB2b2lkIHVwZGF0ZV9tbXVfY2FjaGVfcG1kKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
dm1hLA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90bGJmbHVzaC5oIGIv
YXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90bGJmbHVzaC5oDQo+IGluZGV4IDgwMTAxOTM4MWRlYS4u
MTIwYWViMWM2ZWNmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3RsYmZs
dXNoLmgNCj4gKysrIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90bGJmbHVzaC5oDQo+IEBAIC0z
MCw2ICszMCw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBsb2NhbF9mbHVzaF90bGJfcGFnZSh1bnNp
Z25lZCBsb25nIGFkZHIpDQo+ICAjaWYgZGVmaW5lZChDT05GSUdfU01QKSAmJiBkZWZpbmVkKENP
TkZJR19NTVUpDQo+ICB2b2lkIGZsdXNoX3RsYl9hbGwodm9pZCk7DQo+ICB2b2lkIGZsdXNoX3Rs
Yl9tbShzdHJ1Y3QgbW1fc3RydWN0ICptbSk7DQo+ICt2b2lkIGZsdXNoX3RsYl9sb2NhbF9vbmVf
cGFnZShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdW5zaWduZWQgbG9uZyBhZGRyKTsNCj4g
IHZvaWQgZmx1c2hfdGxiX3BhZ2Uoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVk
IGxvbmcgYWRkcik7DQo+ICB2b2lkIGZsdXNoX3RsYl9yYW5nZShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1
Y3QgKnZtYSwgdW5zaWduZWQgbG9uZyBzdGFydCwNCj4gIAkJICAgICB1bnNpZ25lZCBsb25nIGVu
ZCk7DQo+IEBAIC00Miw2ICs0Myw3IEBAIHZvaWQgZmx1c2hfcG1kX3RsYl9yYW5nZShzdHJ1Y3Qg
dm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdW5zaWduZWQgbG9uZyBzdGFydCwNCj4gIA0KPiAgI2RlZmlu
ZSBmbHVzaF90bGJfYWxsKCkgbG9jYWxfZmx1c2hfdGxiX2FsbCgpDQo+ICAjZGVmaW5lIGZsdXNo
X3RsYl9wYWdlKHZtYSwgYWRkcikgbG9jYWxfZmx1c2hfdGxiX3BhZ2UoYWRkcikNCj4gKyNkZWZp
bmUgZmx1c2hfdGxiX2xvY2FsX29uZV9wYWdlKHZtYSwgYWRkcikgbG9jYWxfZmx1c2hfdGxiX3Bh
Z2UoYWRkcikNCj4gIA0KPiAgc3RhdGljIGlubGluZSB2b2lkIGZsdXNoX3RsYl9yYW5nZShzdHJ1
Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4gIAkJdW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWdu
ZWQgbG9uZyBlbmQpDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L21tL3RsYmZsdXNoLmMgYi9h
cmNoL3Jpc2N2L21tL3RsYmZsdXNoLmMNCj4gaW5kZXggMjdhN2RiOGViMmM0Li4wODQzZTFiYWFm
MzQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvbW0vdGxiZmx1c2guYw0KPiArKysgYi9hcmNo
L3Jpc2N2L21tL3RsYmZsdXNoLmMNCj4gQEAgLTQxLDYgKzQxLDE3IEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBsb2NhbF9mbHVzaF90bGJfcmFuZ2VfYXNpZCh1bnNpZ25lZCBsb25nIHN0YXJ0LA0KPiAg
CQlsb2NhbF9mbHVzaF90bGJfYWxsX2FzaWQoYXNpZCk7DQo+ICB9DQo+ICANCj4gK3ZvaWQgZmx1
c2hfdGxiX2xvY2FsX29uZV9wYWdlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25l
ZCBsb25nIGFkZHIpDQo+ICt7DQo+ICsJaWYgKHN0YXRpY19icmFuY2hfdW5saWtlbHkoJnVzZV9h
c2lkX2FsbG9jYXRvcikpIHsNCj4gKwkJdW5zaWduZWQgbG9uZyBhc2lkID0gYXRvbWljX2xvbmdf
cmVhZCgmdm1hLT52bV9tbS0+Y29udGV4dC5pZCk7DQo+ICsNCj4gKwkJbG9jYWxfZmx1c2hfdGxi
X3BhZ2VfYXNpZChhZGRyLCBhc2lkKTsNCj4gKwl9IGVsc2Ugew0KPiArCQlsb2NhbF9mbHVzaF90
bGJfcGFnZShhZGRyKTsNCj4gKwl9DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIF9faXBpX2Zs
dXNoX3RsYl9hbGwodm9pZCAqaW5mbykNCj4gIHsNCj4gIAlsb2NhbF9mbHVzaF90bGJfYWxsKCk7
DQo=
