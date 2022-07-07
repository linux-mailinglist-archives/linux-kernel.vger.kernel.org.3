Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC70056ABCD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbiGGTZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbiGGTZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:25:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5312717AB6;
        Thu,  7 Jul 2022 12:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657221903; x=1688757903;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0dgxODwxyaQfuzHBDFLgAcvFl1H3kv6fNxfM+5/xsX0=;
  b=U+klRY4bTQX8c9aq/jlolYBj3kPJ3/gcnMrhMMvGFXIfdNYvfwklzfIH
   ELxHvTdmENiCQkExcXcX8R5OR3atLrBF134FRO7HE2knZLmDUC6AgYuf4
   Y5ZcmHnNufVPrx0nU07QiJddADyOqiDdWxigg3AfAIxBP0gTTk4tPW2UL
   jvzmTYd+1sznsbT+6d6cSObljtTaU8vdjZjHkTIxbwgYViIQY7Wsw0dr4
   PMP6NdlDka4wIXBxdlEsHc2JcGnnnjpL7eQGWIH3h1eHn7mzKvQBloLPu
   IMtNOtrxAKAWF8hxZqAz/fCig+LSFaIkAiEXwTQ3nP4qeCz4hjQfJ0C0C
   w==;
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="166891501"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jul 2022 12:25:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Jul 2022 12:25:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 7 Jul 2022 12:25:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmD7WjBRLMwnbWymPmtqJXXSFhcFLqBV7JnuZjL/v2Qo3d/B5kN1yn9hnuQGe1mwbyyz+v0smDu04AS+UFwpYyXMp+hikeCVHG/fUt7TuHED5D6BIDrlZeBWyVYt1K9UuRv6OSqL6Jn7OyHazQotCg7va8fmlx3yM4pIcbx9QwkGbOrYENhm1IT7cdlH9XwsZCfOpVInqx8J5lqyfXf97Am1Z542KTsrs74Pp5mdLJCliyKmn73qcIh3sqRFiDN136Fv34Z+wsdxjuv6vcRS14PHxPTuZns49K6tMhbsHOFonK5Xui2zSHITth9pD1WN2UjAbqLxcgakYG7SmD770g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dgxODwxyaQfuzHBDFLgAcvFl1H3kv6fNxfM+5/xsX0=;
 b=lqKviVi3dVcCmbl3h52Fi1xYWBF9shSWoCFoIhaXgg3RymtWGyN8jar4vS9+7rKMQ+ys3kSFiGjfks6Yx5d+7CtVsUGtDjh3kx9LBMx1bf/7y141RqPCdwLfwwmZg6mx4SoDxiP9qJAiCEpWwW5t4ZxM5M5fYiFXGzKrs+1qYXbL97a6w3ycEJAXThm7Ucm8/DLweYpffOcCTGoZM5FxZhUvUeCw6IC5eHkRbfNMOudY4AFWcpduzMWAU4gOTk6HDN+nPmV0nisX7SHXEsvNEpohh6SlsKdGQXUIrvVR1HNQDWL3oos8iYQN0hXCIc53ihIQAu9BmRqKeUlIerQzyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dgxODwxyaQfuzHBDFLgAcvFl1H3kv6fNxfM+5/xsX0=;
 b=cy+5jZcnbT9TiyOO89bde8O8evhkyascYZEGF2QlDtNTAqbJ8190LlzCgDIdhMcskj+KcaISkvS2w+M3sNtKbkYd0E4Rh08xjDCYGgcnAWhwLobBqw02lFHboOx8dPYOLYqTzn5QaVrCIbs+Cy2m0v04iniJ5aymkwcZUOTwX24=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB2794.namprd11.prod.outlook.com (2603:10b6:5:c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 19:24:52 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 19:24:51 +0000
From:   <Conor.Dooley@microchip.com>
To:     <kettenis@openbsd.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <kernel@esmil.dk>
CC:     <palmer@rivosinc.com>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] riscv: dts: starfive: correct number of external
 interrupts
Thread-Topic: [PATCH v2] riscv: dts: starfive: correct number of external
 interrupts
Thread-Index: AQHYkjNVXPGYSaRh4Uqt8flC17YMhK1zSg6A
Date:   Thu, 7 Jul 2022 19:24:51 +0000
Message-ID: <27617ba6-addf-6f29-e1a8-2cb813dc303a@microchip.com>
References: <20220707185529.19509-1-kettenis@openbsd.org>
In-Reply-To: <20220707185529.19509-1-kettenis@openbsd.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e33fc0d6-b9a2-4348-f432-08da604e5d79
x-ms-traffictypediagnostic: DM6PR11MB2794:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JDT2ODSXhEy8hVa6L8Zjk4+m7X2pxZB1Cuvs4/BG2/FluC/3V4iEEdWdpMjlxyhKv0AR2xeSMjyhbCt5pskyvZG+dVrnrL1gIhQoSWy/kihHBQKZ1iP6WxEDQ0bpfDQcLphSnNnGOxtjZr+dRrQMFi9p5oJZtYlSAARiNhndkgXVvu99w6J2h8prjUzGfUT8OZTRbP59ObigbQcQejxtFCv2waT0vhgtEmPaKdJZgVkuAzh2YtOxjIJhA0GeSTS3LY3gP1nBrP3LXPnSiFGiVgQ6uZXZbaW8haRGGbM+WKasItLz3zV8YN80oaxfQGNkn86oDuY++CuAxMuVF+IqX148yJrT1i9/zE06Xtcg9qSyLJIcTWRarkBsDtZl0ZV9SwOC31Kaus3bZniUxdZdL0MlVFTqr1xAWs7FFAQAWrAah/YLS5RE8khe4vliwktZ/bpFp0Tl9tsGFvxV5OS6Ht5FShXxeuupxBXc74Bo7j5fIeK+ZQLcerKruqCNB4sL483/P4y+JyMiVY3JGEiz7cEaxQLR5e8FhETBFBvFhqZsQVdBwSpA7WsvuugFToL4jTu0ypBvihc1R2tX8CdxqMtmos9vDo06OPrsgsOXxN7BevZOyBqUSmZN222qbF+NTvI/ec9VwLTJPd3OCAzrP0eL4BPKjLhpSBm8ISSAawfhiFGfGOzk33IltNDxC5LdHgaKhGO42J4wusirYu+asLzoG9nrz2kD9KMhu0FdyER/lpewtH9Hpl2dlLGgiKLo7fZJrwGjq2BERZlaCR7/MuJcYtSXkxPFCExVWKRNJzRmCrlIc8aYTN/cUff13R4VDd8Yk4YVzAiPHwn6Gwd4ae2CVCtA1N/ShV6O8Izrt3zMoVqSm2W1j9T+nFE2Rv2tet/VimmcZ4aCYu7XYeU9g3v1L/CCV2rg01jbD7dYQHc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(366004)(39860400002)(136003)(376002)(316002)(26005)(54906003)(83380400001)(110136005)(122000001)(36756003)(31686004)(186003)(6512007)(66476007)(86362001)(2616005)(5660300002)(66446008)(7416002)(8676002)(6506007)(2906002)(4326008)(91956017)(76116006)(38070700005)(64756008)(66946007)(38100700002)(66556008)(71200400001)(478600001)(41300700001)(6486002)(966005)(53546011)(31696002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnRXb2hhNFFjNUlsYXNZRi90a0NzMEcyU284VjJYS3Q0UDhveGl4NDg2QWFK?=
 =?utf-8?B?VDJWcEZzN0IwdWY3T2RYOVAwM3pQZTI5ZlRvdGFoc1Q1NWE1MU14OFA1anFj?=
 =?utf-8?B?UTdMbm9LeFlTSzhJall4T2pFWmZoc1NoT21uVXdDUE1yL1JkSWJRSElyakRz?=
 =?utf-8?B?ZDZIVHdGNGJhZTBqZHl6ckk0ako0cUFLaXpsZk5nWTBNNlZnYm0rMHlzYk1i?=
 =?utf-8?B?SVNsNVBaR3BNMlFtZk1qOEFaaTVOTm50UkF2a2tWQU1MdjhjOEFvS2ovRTBX?=
 =?utf-8?B?dXp3ZmR5WUJjZFYzMXFKdmd2VW5EQk5pcWo1RFhkNU03bE12aHlIQ3ZmZG9G?=
 =?utf-8?B?cXhQTlNyYy9Od0ZOTTRjUDc4SUE3TzkzRlBNT25vbnYzc0tUdXR1TFMwckZS?=
 =?utf-8?B?V3UyNnFnM2Q4M0p4OWJSbFdVQTlLNWd6V1k0N0pwbUNyZzYzUWdMS0RBTjMx?=
 =?utf-8?B?WDVRN0VqbmJhb0luNnFjN25kUzY3U2psZGpWYVFqY2tLY0F4d1pIejA1Qnls?=
 =?utf-8?B?RU4xZTF5dnI2TnpkWENZdXFvZWh2OHVGMFFLaWpNcmJGRld2WWhDdDRiSXBh?=
 =?utf-8?B?SnIzWGprVEtlWTBXakpNNDZqKy9aQTlBV1J5THhMc2FsbXRzZ21kWFp1bEMv?=
 =?utf-8?B?N3ViVURaWlZGdlVLME1nbnhvOHdMaTdnVEU1dm1yQnY2RGhuQVgwY2ViODJV?=
 =?utf-8?B?TkJMbXYwdFJkM3Vucks2QmM1eUwyYzlXTXREdHBDdlZUSHZPMjFJeHRrSG41?=
 =?utf-8?B?SmNpWDBHR29JOVNhRHRpNnVXdkxqTU1vZWxJaWhSQ1NQeWhvaHBRYVNSUFFi?=
 =?utf-8?B?UnlHSmVvc2FkQVp0RlR6ZmdQU01VNm43UXhTUkhxUzBla1hQSkFEYjlqbXZ1?=
 =?utf-8?B?VDJoWHFtNC8yVVplSlFhcW9IbFVlZEZkd21xZXIvejJMdTh2L1l6YWx5aDA3?=
 =?utf-8?B?aUx5ZmozdDFOdkZ4M081QVJPSlhWSkI1WWZZeTN6dzVXY09wVUZaQVptV0pH?=
 =?utf-8?B?OE50Qy8rNDcxNlp3dVZKUkc4OTBndEg4MCtMWU5WWXF0bk9uTHJLZkRrdGFp?=
 =?utf-8?B?TlhjMHErRktyUTlwT3FUdk1PMHdpQVFvdWtNOWgrd052aDVuNXVxcjdGbjEz?=
 =?utf-8?B?aXJRMWY2NVJiOWZQNzBkT21iUlJoTElGQ0tlV3U4VW1zNFh6cWdmMzUyRzVG?=
 =?utf-8?B?ZnpESUxZR0M4bndwRitmUHlQWXdrT2ZWOUJ0aE5kZ1dXU2pkQjZVdlYralFt?=
 =?utf-8?B?WkJvcEhKbTFRSXg3aGs2ODl2cjcrM2tLVGhhS2hSVGlUMnZvYXpXdFd5V3NJ?=
 =?utf-8?B?b3lDSXJId0JJNUs4OGxNSjI5dGgzMkVyYTJoOSt3MVc2cEpiVDg2MU1KQVJj?=
 =?utf-8?B?SG8zcTRibkpjNk5NeDNSRllHWHJjcm42dkpETkZPc2dBbytwM0VqcURLeW1j?=
 =?utf-8?B?SllWRTNZb2hpV08zcWdtb2l1cU0rb0I3MnVqTEhzSHppS2ZkNWZyRUx4Y1Nx?=
 =?utf-8?B?alpNK1VIdnpRcjIzLzhFWmhWaUFaS0M0TTJWcUNIY21IeTR0aDNlQzJDaGVL?=
 =?utf-8?B?dG1PL2Z2SUdHdDdJQlh6WVlMeW1WUW5lQlJHdEZtZmdxKzNiZjBMbWVRdHlH?=
 =?utf-8?B?ZlB0TXJaL1ZkSGNtOHBBa2VDVXN0NGpQaTJKeFY3M2N5aHhLTytEYUozYUU0?=
 =?utf-8?B?THVEazNpZ2dXaHQ3US9iSSs4RzI2c1ZyK2EvNUNQcGxlMWtidnp4clhLNlcw?=
 =?utf-8?B?RU9JREJnS25FTVJ2blVqZGJNRHp0MHcrODI0bUFvNm5MWDR0NmhYaDBKb01w?=
 =?utf-8?B?NmNQWjUrQUlnemJlUmJ4OVBidDFwQjlWMDhyc3lzaGc1TFVmOC9NZ1NzSkw5?=
 =?utf-8?B?SFlRZ3dnMEdrT2R0L09VR1J2ZFFJeTd4NUg3ZjNITldQTC9UdlBscUU2RXVx?=
 =?utf-8?B?bkswU3lza3hBbklPZEY4Y2JpK0plODcvbCtrbXlndVIwUmtzTTZ2K1Njd1dw?=
 =?utf-8?B?Sm9YTjQwQklXVzhEMjBaUUhXUjVjeWV1M3FsNmlhN0hhdXRqYWY4VTU4QlVz?=
 =?utf-8?B?RjQwRDc5L1VrQ3hacWlnYTBsOHNSZVNVcllNblVSbzhkTm0wL0tDTkxMSm5o?=
 =?utf-8?B?U21wR2dzcjF5NCtzR3FITXFUOXVyT1B3VkNnMTJuaU1XNGFMZW82bk9ZWFZ3?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B21DC5700E8ACB439618C4E5D5163E10@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33fc0d6-b9a2-4348-f432-08da604e5d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 19:24:51.8023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hy1fjpGmL8Nr2gGJVfLVsnGV4Kq2d7+7XDQAiCLJEU3coXeE320rkRvOmYurHqomUgyDr99F/RGbHi9QTw+jcQCn3qvoZtFXd6uav2jnBec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2794
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMDcvMjAyMiAxOTo1NSwgTWFyayBLZXR0ZW5pcyB3cm90ZToNCj4gVGhlIFBMSUMgaW50
ZWdyYXRlZCBvbiB0aGUgVmljX1U3X0NvcmUgaW50ZWdyYXRlZCBvbiB0aGUgU3RhckZpdmUNCj4g
Skg3MTAwIFNvQyBhY3R1YWxseSBzdXBwb3J0cyAxMzMgZXh0ZXJuYWwgaW50ZXJydXB0cy4gIDEy
NyBvZiB0aGVzZQ0KPiBhcmUgZXhwb3NlZCB0byB0aGUgb3V0c2lkZSB3b3JsZDsgdGhlIHJlbWFp
bmRlciBhcmUgdXNlZCBieSBvdGhlcg0KPiBkZXZpY2VzIHRoYXQgYXJlIHBhcnQgb2YgdGhlIGNv
cmUtY29tcGxleCBzdWNoIGFzIHRoZSBMMiBjYWNoZQ0KPiBjb250cm9sbGVyLiAgQnV0IGFsbCAx
MzMgaW50ZXJydXB0cyBhcmUgZXh0ZXJuYWwgaW50ZXJydXB0cyBhcyBmYXINCj4gYXMgdGhlIFBM
SUMgaXMgY29uY2VybmVkLiAgRml4IHRoZSBwcm9wZXJ0eSBzbyB0aGF0IHRoZSBkcml2ZXIgY2Fu
DQo+IG1hbmFnZSB0aGVzZSBhZGRpdGlvbmFsIGludGVycnVwdHMsIHdoaWNoIGlzIGltcG9ydGFu
dCBzaW5jZSB0aGUNCj4gaW50ZXJydXB0cyBmb3IgdGhlIEwyIGNhY2hlIGNvbnRyb2xsZXIgYXJl
IGVuYWJsZWQgYnkgZGVmYXVsdC4NCg0KVGhlIG1pc3NpbmcgNCBmb3IgdGhlIGwyY2FjaGUgY29u
dHJvbGxlciBjZXJ0YWlubHkgbWFrZSBzZW5zZSAmDQp0aGUgZG9jdW1lbnRhdGlvbiBkb2VzIG1l
bnRpb24gdGhlcmUgYmVpbmcgaW50ZXJydXB0cyBhcyBmYXIgdXANCmFzIDEzMSBpbiBUYWJsZSAy
OC4NClRhYmxlIDMzIGRpc2FncmVlcyBhbmQgaGFzIGFuIGludGVycnVwdCAxMzMuDQpHb2Qga25v
d3Mgd2hhdCB0aG9zZSB0d28gYXJlIHVzZWQgZm9yLCBidXQgdGhlIGRvY3VtZW50YXRpb24NCmNl
cnRhaW5seSBtYWtlcyBpdCBsb29rIGxpa2UgdGhleSBkbyBleGlzdC4NCg0KTGluazogaHR0cHM6
Ly9naXRodWIuY29tL3N0YXJmaXZlLXRlY2gvSkg3MTAwX0RvY3MvYmxvYi9tYWluL3ZpY191N19t
YW51YWxfd2l0aF9jcmVhdGl2ZWNvbW1vbnMucGRmICMgUGFnZSA0NCAmIDQ1DQpSZXZpZXdlZC1i
eTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCg0KPiANCj4gRml4
ZXM6IGVjODUzNjJmYjEyMSAoIlJJU0MtVjogQWRkIGluaXRpYWwgU3RhckZpdmUgSkg3MTAwIGRl
dmljZSB0cmVlIikNCj4gU2lnbmVkLW9mZi1ieTogTWFyayBLZXR0ZW5pcyA8a2V0dGVuaXNAb3Bl
bmJzZC5vcmc+DQo+IC0tLQ0KPiANCj4gQ2hhbmdlTG9nOg0KPiANCj4gdjI6IC0gRml4IGNvbW1p
dCBtZXNzYWdlDQo+IA0KPiANCj4gIGFyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTAw
LmR0c2kgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2po
NzEwMC5kdHNpIGIvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMDAuZHRzaQ0KPiBp
bmRleCA2OWYyMmY5YWFkOWQuLmY0OGUyMzJhNzJhNyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNj
di9ib290L2R0cy9zdGFyZml2ZS9qaDcxMDAuZHRzaQ0KPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3Qv
ZHRzL3N0YXJmaXZlL2poNzEwMC5kdHNpDQo+IEBAIC0xMTgsNyArMTE4LDcgQEAgcGxpYzogaW50
ZXJydXB0LWNvbnRyb2xsZXJAYzAwMDAwMCB7DQo+ICAJCQlpbnRlcnJ1cHQtY29udHJvbGxlcjsN
Cj4gIAkJCSNhZGRyZXNzLWNlbGxzID0gPDA+Ow0KPiAgCQkJI2ludGVycnVwdC1jZWxscyA9IDwx
PjsNCj4gLQkJCXJpc2N2LG5kZXYgPSA8MTI3PjsNCj4gKwkJCXJpc2N2LG5kZXYgPSA8MTMzPjsN
Cj4gIAkJfTsNCj4gIA0KPiAgCQljbGtnZW46IGNsb2NrLWNvbnRyb2xsZXJAMTE4MDAwMDAgew0K
