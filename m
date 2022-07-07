Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581FF56AE1B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbiGGWGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236775AbiGGWGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:06:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63AF2C67F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657231596; x=1688767596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GgbxaAYHgYQnCG4CPbfKErsb43aqX9uzMJnx71WFfWQ=;
  b=Vr2tgIi/xLHI8TP8Yi9w+p6/QzIb1vXDICuPv811NLNgTnke6UtF4wP2
   ToGVF+/dEkX+qfxtgqOfbkMey2tteoGZ3DqjFyHzm2RV4HuiB9HB0x9gi
   SfCGK9apbUWtTv+Vgy8+4GKRUNPIqwt0IaS84vJ8D9XM6QskPxukMPtr2
   g0bgq5MzfP6dbufP+e4+2le4xCktJoc3uwhHUWHBVdQGUn+pef4ON3EBN
   lsoFSSCJM/O7YtBqo+mEXRnxG/yb4WyiG/BhaT29TYeEw4XSthqC3p2dK
   4jupCZIpa+Xt8GmZksMfa5P6xLW8XxFl0MKcxjdKOGMn/oBsdrC7w2S+q
   A==;
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="171503086"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jul 2022 15:06:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Jul 2022 15:06:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 7 Jul 2022 15:06:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fs7Z3oDJBj9hU4SpxDgbLzOwrhdqBV6x1QzmIWT6EUg4DaFLLZ2iFcMW6us00R+veb9rh4qCTKYclOOmZEll4zAjqokSbIAGk6YuRJgifmbl0Sh3ko20voyt+Uv8pslNS62l1qdTb1PXeJf49P+CqSZPevup64C69rzg4GQ4dagxT3i/n6nBd6t7AhPVQ4ll9e2pL3/rFc+l3FOOazpIZ2UIcQOFnJ0Xn5eb9YDx+oIivIMLLUGwrHOJFICh3MkukUUcFFy5Fmklj4QQm51rKp34Tb7eVCtcDQ71CTnpCQPvp0flRhLMPieR9hG7w8c3DQrMrYPHbrpatQUgFIbJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgbxaAYHgYQnCG4CPbfKErsb43aqX9uzMJnx71WFfWQ=;
 b=CZjv7531+0JCHrVpDGrqpHxE6M7mdLa2Ea6Ty5Iy402KJhf0yUdjfK8LBLe7cjnde+NM0jZmq1ZWA8FSxYWJf9n5kxk+L6YgGzjHeCrhRF40rpXzX2usdpBAU8ewAjtP6JbYrmGLv+GeI5OcevmCYPubgygORShcf9jfg1iDou1yKKakaofTRiklQLMAeN2pcgiXkhZUtMYc2lZAX456qYLw6ySxXjMm6/QDtNRKVt2d4VKWxED6OmEZCPB1hkBX5gUK1r/T2waMyhgVyfIeFH0NtLKLbhkZCUx9Rpl7y+7bVhqVhcRucNegbAQNkygBDCF0eeaTuNFfdK5lscZ4rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgbxaAYHgYQnCG4CPbfKErsb43aqX9uzMJnx71WFfWQ=;
 b=CzNxn10BLp0xxFKxwzj2xTF0havxK8moc62SjuPpNSx3VpMI9WwvwOn/Q/wBGda6t32iHGa0jLaveX3SyvEPoAOwBSPSyJ1u6G7GELq9bUCLULjT9Zjw7l4wHMpcfboGsHFAug9H6lhyWITvuZ6U61L6zvLDO6l98t63aE1jVYo=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ0PR11MB4864.namprd11.prod.outlook.com (2603:10b6:a03:2d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 22:06:30 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 22:06:30 +0000
From:   <Conor.Dooley@microchip.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <palmer@rivosinc.com>, <aou@eecs.berkeley.edu>,
        <sudeep.holla@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
CC:     <Daire.McNamara@microchip.com>, <Conor.Dooley@microchip.com>,
        <niklas.cassel@wdc.com>, <damien.lemoal@opensource.wdc.com>,
        <geert@linux-m68k.org>, <zong.li@sifive.com>, <kernel@esmil.dk>,
        <hahnjo@hahnjo.de>, <guoren@kernel.org>, <anup@brainfault.org>,
        <atishp@atishpatra.org>, <changbin.du@intel.com>,
        <heiko@sntech.de>, <philipp.tomsich@vrull.eu>, <robh@kernel.org>,
        <maz@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <Brice.Goglin@inria.fr>
Subject: Re: [PATCH/RFC 0/4] Fix RISC-V's arch-topology reporting
Thread-Topic: [PATCH/RFC 0/4] Fix RISC-V's arch-topology reporting
Thread-Index: AQHYkk2rxq9THIvBtU+MMfrEPJ5m4K1zdwKA
Date:   Thu, 7 Jul 2022 22:06:30 +0000
Message-ID: <0ab1826e-69d5-8144-70ee-9df95d62df09@microchip.com>
References: <20220707220436.4105443-1-mail@conchuod.ie>
In-Reply-To: <20220707220436.4105443-1-mail@conchuod.ie>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a20670b-b4d5-4819-ea62-08da6064f21f
x-ms-traffictypediagnostic: SJ0PR11MB4864:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: om/gom38h2OA/YlxGt2wbUU6EXrXweHgEuOpr9q9BP9wEXYKoxdIsbkhwFh6ZMb1qjbrb7lzWOdwbyQqYaUz/hQQKzEzFogpteRvhYzCLO/HUscs7B60RoVjULxMTzEvrsr+RsJX84TPlVlXN0WveNLxfIow9+JCiIiMpeeQCAWYQo9T79pTNjazjA9XltSlWETGMiBbMBbHL/0gPaJ1vgVWaG3ysmZsuGK805+AQb58lc9YpTnuivG9xkbTr+BsgIj3WhdlLMf3boFPr3wEad8qtWvt6KWfGA9SXB7kMSx/VLFNbvyY/J7ik8SXyZ67QMd51if/FhSVcCEWXSxoGS29IhtcTq+jgQgnozOwJNCdZZAkYYCJuR8/jz5az4kIL9ibO+7ZnOzHFh5walOVYk3hG2IRIBnS6wYenMxfVFYXHDdGsPwzBbGNfTB26jDA8apiwWiILStDYrQsP28voydMSqG9RUnawkzRVZP/kc9GyUEEIBysrrqk/FM85feXM7pe1XqkJ2t5rHB5nXL0iZhxUiXCgeyZ6oXkMvuRKHR2CriR93Yn++nbMVBAmj2vYX1yeX0ksHg7GP/pD61LXz/7VnjEsyQOjprLAAGuVMFe6wUTHn+T7FcDdS59Z50hOSLgaEXHBNdsrVwQVMZP3+DpsnIShPlMgvQ2GXk3bfiX54iuCZsl2VSzkbRmrTW17/35cuiflGusU3XKsSt6yZUfX96xAMDQkcnET2I4s8e+2t4WMPljDencEHPoWI9RkejTp+gvmNCHYaCPWxEId/q44EnSQlUmJJk7ZEFrJleMGQ9FTjXaAQw2/Lc6fvSMz026Wn+z1wFBEAGDvbVhOVzEg2CuLcrh0VOJHXhHEt2gfQLoM2EytyUQGShtYLTOz+Rjhdu76kDot5FejUdlww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(396003)(366004)(39860400002)(54906003)(110136005)(966005)(66946007)(76116006)(91956017)(71200400001)(316002)(478600001)(2616005)(6486002)(86362001)(36756003)(31696002)(122000001)(6512007)(6506007)(26005)(66446008)(53546011)(41300700001)(66476007)(38100700002)(4326008)(8676002)(64756008)(66556008)(31686004)(186003)(5660300002)(8936002)(7416002)(38070700005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wis5OFhlRzI4MHNXQ1NUd3o2dXh6b1BDS3BCMHZhTk41anlKWG9LUXhwRmlp?=
 =?utf-8?B?YTRneTdkYWVUcCtVc3RWMlJiMVpPQXI0RitFK2x4ZkFiU2h0RVMyY1BEUjhX?=
 =?utf-8?B?OVp0dk9yQmoxdlU1eDE3VU1VOTJlMzBLTzRoeWhxY2doTXVYNldKTmZWUklv?=
 =?utf-8?B?WlJGUExlMUJWcUNBRmNycjZEbjQ4d2x0S09XaWtSblluRVRnVXh3K1VOVTMr?=
 =?utf-8?B?SmIvRFhCa1JlOTZ6VU1Ga0RJYlJpN3l3N0s2VDhwd0hTSHYyNVBaQ2tlRmRm?=
 =?utf-8?B?M1N6emlzUlI3UEowNVA2Q2dNTmVWQXNTV3B4SzBoZVkyWS9uNHlhNHJmNzR0?=
 =?utf-8?B?aWxtdjRtUHJkdmkyc0p0M1FXa3pzeXVYaWZOTmpRR3A1SkZsS3FEa1FMRGNz?=
 =?utf-8?B?aFlKUFZnUFZlUWVGN1JUbXJnMUFqWXBRZ0hYcUlFdHRtTVFPOHVPL29RUVow?=
 =?utf-8?B?b1p0OXVlT0xaQ2FuWXREZTlqUTc5cVk2ZUJQRnFqRWVweHZ2M0JHZC9GdjFN?=
 =?utf-8?B?WW53SUhJWDFTbUtVN2ExYmlVREpBcjlyMXVkOWt1aGRPUmdYUXFjY2V0SmRW?=
 =?utf-8?B?TXRBS25STEJxNExrU3RyMDJCSzBPZXc2VVZ1ZnVCSUE1REl1TWtJV0czeWRu?=
 =?utf-8?B?RHFTcDdSQm9lcUswdDJ1SHU0eG5UanUrSmt6dzVjRWhHdnUrd1NpaGVmRmty?=
 =?utf-8?B?VEgvcDgxVW1UbzBsdU1QcFhZSDhMWmp5NVI5akVRcDZ5amxvVXlvbmRWamo2?=
 =?utf-8?B?RkV0WXBzMk16WUh3WSsvcUdVUy9nc2VBUHU4b25CZDAvR3RSeFVRMkxaSTdx?=
 =?utf-8?B?TXBjTWFLcjJGb21ib3h3cjdQMGJyaUVXU21VZ3J3OFQ0b0pwMEVXWUtwNzcr?=
 =?utf-8?B?aCtrM1NKU0FoODVpbDB4STF1YTRQT2hueFFkQ0tsaFh2cWhKVDJyU1Q1OW1u?=
 =?utf-8?B?bThCV3FHUCsvelE1QzZVN1d1K1BtaTJaNVdHZlhMYWl3Q0dUTTJtazg0Mk5T?=
 =?utf-8?B?b2dEbkZFWUQrRC91UlE3WXl3WElXcVFpN1E0MlRLSkZlOXpCYlRrT2ZlYlJ3?=
 =?utf-8?B?ZGRCN2x2YVIxMEV6RVBPVnlFZmNTaE1oQzd6MDRyZFFzVHVNY2lGZHo2eEh1?=
 =?utf-8?B?OGlhamJjRzZsbGxIeEJGZUNVeFpyVExYeGwxeklSbUpZRk5Cb0VPaEtEL0tG?=
 =?utf-8?B?Qlh1VzdGVkdRSVFPNXM4OUt2ZjZMZHBJYjVscnNPaGRlcXVBUTlWNHh3YmQv?=
 =?utf-8?B?Wngwd2NWTmdSR1UvWUlRZ0V3NkhRUkRid0YyNnVmbUljYTNPZ05ZSnFqaGdq?=
 =?utf-8?B?eDYxY216bDNpdUcvSjhibk9LWjhFV0lSVnhGTXFacDA4U2N2T0FOZWorY3NR?=
 =?utf-8?B?WEpUNDBneGdZV051OVlNeGxVcm10Vmhsb0Q3VWMxdndYUlN3eElvdkFqUS9L?=
 =?utf-8?B?K3pKTjNNRHdEYnZ6UnJycXRxcFJMbUIzMGJTNDh4YWFQV2Y5U0dOeEdUYWhZ?=
 =?utf-8?B?Y3pZZkI0K29XL0pnQ2EwcmZyM0xMNmRYSTdTVkt5eEl4MWVSUW9sRllWa3pT?=
 =?utf-8?B?UzdwRkkxSmpSdmlrMFRrQU55STNsZ0hCUWpkaDg5Q1Y1eERBZkUrY0poTit6?=
 =?utf-8?B?MXN2aDZOUlNjQllzM3dVbGxXRGRkb3lkUlJIUWRnWXdmRTFiOVlKeWYzU1kx?=
 =?utf-8?B?L1lCS0Q2UUFwWlNobzYzV1NrMUdPK2hnVWxDRnhwMlBuQVh2b0ZibGI0cHRk?=
 =?utf-8?B?eEg4bDFpaUZEZlMrM2xKZ01tNDJNRkx4Njc1Tm40TS9ZaTR6MDhKTlJPR1Bq?=
 =?utf-8?B?aVZUMHp6b1hmN0N6YUZOb3JDV0FNU0RqaXhFaXlZVlplcjNGNzl1M2Q2Nnp3?=
 =?utf-8?B?QzM0NCtGemZEREROcnlTWmlTK2psTWFIb2JSeXVKOU9BMjFsOVBCcnJDL0tF?=
 =?utf-8?B?ZFVZL0tCOUphbmcwZEMvZGZPM2F0UGJaeU5naG5FVWdHc2hoYXN6WXFoaGt1?=
 =?utf-8?B?MjhMKzRIZDZBRDBWZWl6S3ZiZGJLQWlLOE45dUJ3QmVQeG1qRmZ5UERKVXVQ?=
 =?utf-8?B?dUYwa29STlRJVGFSeFc1RDNwSUlsUWRiZ1JvVzYwbGh1TFZPWW1TVWp1R0k0?=
 =?utf-8?B?L1ZrNGpabmZobDN6cnhJYW9JV3hZU3NTcjVxRVNXeWsvS1pDVXZ3SG41SWNH?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEF7606A565FB34195A851EBE03EC41F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a20670b-b4d5-4819-ea62-08da6064f21f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 22:06:30.1363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jzR1/atNI6S5YIMHhoeH6prE/UT6SrGXzUQkKyw7QdgVjy+GpNwYC5yI5CZ7F+2Yf91gflrobgE98+6/MUGbW8tpkasAq4O245dxe1dlTic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4864
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA3LzA3LzIwMjIgMjM6MDQsIENvbm9yIERvb2xleSB3cm90ZToNCj4gRnJvbTogQ29u
b3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gDQo+IEhleSBhbGwsDQo+
IEl0J3MgbXkgZmlyc3QgdGltZSBtZXNzaW5nIGFyb3VuZCB3aXRoIGFyY2gvIGNvZGUgYXQgYWxs
LCBsZXQgYWxvbmUNCj4gbW9yZSB0aGFuIG9uZSBhcmNoLCBzbyBmb3JnaXZlIG1lIGlmIEkgaGF2
ZSBzY3Jld2VkIHVwIGhvdyB0byBkbyBhDQo+IG1pZ3JhdGlvbiBsaWtlIHRoaXMuDQo+IA0KPiBU
aGUgZ29hbCBoZXJlIGlzIHRoZSBmaXggdGhlIGluY29ycmVjdGx5IHJlcG9ydGVkIGFyY2ggdG9w
b2xvZ3kgb24NCj4gUklTQy1WIHdoaWNoIHNlZW1zIHRvIGhhdmUgYmVlbiBicm9rZW4gc2luY2Ug
aXQgd2FzIGFkZGVkLg0KPiBjcHUsIHBhY2thZ2UgYW5kIHRocmVhZCBJRHMgYXJlIGFsbCBjdXJy
ZW50bHkgcmVwb3J0ZWQgYXMgLTEsIHNvIHRvb2xzDQo+IGxpa2UgbHN0b3BvIHRoaW5rIHN5c3Rl
bXMgaGF2ZSBtdWx0aXBsZSB0aHJlYWRzIG9uIHRoZSBzYW1lIGNvcmUgd2hlbg0KPiB0aGlzIGlz
IG5vdCB0cnVlOg0KPiBodHRwczovL2dpdGh1Yi5jb20vb3Blbi1tcGkvaHdsb2MvaXNzdWVzLzUz
Ng0KPiANCj4gQmVjYXVzZSBJIHdhbnQgdG8gYmFja3BvcnQgdGhhdCBmaXgsIEkgaW1wbGVtZW50
ZWQgc3RvcmVfY3B1X3RvcG9sb2d5DQo+IGZvciBSSVNDLVYgYmVmb3JlIG1pZ3JhdGluZyB0byB0
aGUgZ2VuZXJpYyB2ZXJzaW9uIHdoaWNoIHNlZW1zIHRvIGhhdmUNCj4ganVzdCBjb21wbGljYXRl
ZCB0aGluZ3MsIGJ1dCB3YXMgU3VkZWVwJ3MgcHJlZmVycmVkIHdheSBvZiBkb2luZyBpdC4NCj4g
DQo+IFBhbG1lciwgSSBoYXZlIG5vdCBtYXJrZWQgdGhlIGZpcnN0IHBhdGNoIGFzIFJGQyBiZWNh
dXNlIEkgd291bGQgbGlrZQ0KPiBpdCB0byBiZSB0YWtlbiBhcyBhIGZpeCBmb3IgNS4xOS1yYyhs
YXRlKSBpbmRlcGVuZGVudGx5IG9mIHRoZSByZXN0IGlmDQo+IHBvc3NpYmxlLg0KDQpBcHBhcmVu
dGx5IEkgZm9yZ290IHRvIHN3YXAgUkZDIGZvciBQQVRDSCBvbiBpdCwgYnV0IHBvaW50IHN0aWxs
IHN0YW5kcy4NCg==
