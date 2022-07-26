Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1617580FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiGZJPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiGZJO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:14:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C7831398
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658826897; x=1690362897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FPoQLzZwsVvj94UHiV9Nls/k6wInhQqOUa2smvYbrYM=;
  b=Kml+TvIeCPCybzw0WjpApuqgiyj1edBtkWXs6CgqZhDdkIsMZr8dOZBT
   mvhk3Nd8yHLZ2ARvgFM0I8PEmJW4p2PhdnOY9lmKelNTg8vVgB9wndSbJ
   ILhvJWtb4bZc9+ZHznDhEAZr7MWfjc2m5mclsyU8bumfUTfVCkTxnop+Z
   BJkVYF2PZyUMGNGlqJFMxXSoFs305mCxJ7+0ESN3WxMdzsBjdTj+kFcjX
   pH2xjhWF07kQk2cUHJ04lVraXmDnsKwDV2SPKgjB/UUTOGkOL8JLVoJTv
   G7TjX8Qwq1+GZ0GOXJgBhvJS+jHx5I040qD9/J55r6DfdGi5brX911vZ8
   w==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="106144987"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2022 02:14:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 02:14:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 26 Jul 2022 02:14:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaH5rq9XGLarl9Hvcvav/h4FUHiNKN5HdttfCoQgFzk90wOWvUz2YINW0CmVAthPyVTVF54wLiQucifBhNqC9ibY3eK+JDC+27ogFhWOl/juuY7ZFMOg3JJ/c0LHui9Y+1XSk0WxmE/DV8t0+yO0WJLR9ineEbM9PZkQCOQpPeLK8OHE/GFa4O3U5EHIoaxWc6gRFbW8z7mYCNVP0xGRicjFBoqSzY9Y7ZxcRRnpDY3XQEGTidI75c3/GEVEUNvMQqtXF7iGLzw5LcRcljGQkSVWfAL86p85BpX4z27FqLvqg97JrLnD8a1OnkykQ1A3YrlmhNFTm77cGGuNro8OZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPoQLzZwsVvj94UHiV9Nls/k6wInhQqOUa2smvYbrYM=;
 b=Y4KboFh9ewIRe/HIv0g1ZGpIYO6iIKiZ7VW7nVIiQ5MLbMj9veEJQ2MG7M33BQ2r2SAiTqTdZNzHuYEWIJLjfACmG0ovDrpV/Ovdq9v+LK9dEA1qXvk5LPxtyyyUcOdIkmlePKI7f21eHG9VbBa02Pd+Y+excooYHUk/9z5kTC+ct45ffES6Ntw8qR9bfD2LomZGsC1K7S1oyKUqCAbd42u4UqA8t27M3CNu1WpBXJx0XZ9ZbMXJ09VUlTigAHHgqCcyrJT5h0qgW1dHiHaaqb6EM4/UuZ3dTzkLLq7KA/gQ7kcIlcSsE5tzwJ3PZdULS8i8Km0Oms/RFd254iP7/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPoQLzZwsVvj94UHiV9Nls/k6wInhQqOUa2smvYbrYM=;
 b=WyAQKfeGn5bJWy7Mqdb5/GbX68Nic522n1MXndQfbFBIRqpGRrSAv39EhcKmV5B7UrfECP/GrVTAu35eYtXsGu31E3LDcvUHDGkrcLmVKju6uDr6tb8xjhKfKgw8++BiD3kNxN2ocdLOMTkOYescBROSP3MZcYWFf9efiRYa93M=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Tue, 26 Jul
 2022 09:14:49 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%7]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 09:14:49 +0000
From:   <Conor.Dooley@microchip.com>
To:     <atishp@atishpatra.org>
CC:     <will@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <palmer@rivosinc.com>,
        <aou@eecs.berkeley.edu>, <sudeep.holla@arm.com>,
        <catalin.marinas@arm.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <Daire.McNamara@microchip.com>,
        <niklas.cassel@wdc.com>, <damien.lemoal@opensource.wdc.com>,
        <geert@linux-m68k.org>, <zong.li@sifive.com>, <kernel@esmil.dk>,
        <hahnjo@hahnjo.de>, <guoren@kernel.org>, <anup@brainfault.org>,
        <heiko@sntech.de>, <philipp.tomsich@vrull.eu>, <robh@kernel.org>,
        <maz@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <Brice.Goglin@inria.fr>
Subject: Re: [PATCH v4 0/2] Fix RISC-V's arch-topology reporting
Thread-Topic: [PATCH v4 0/2] Fix RISC-V's arch-topology reporting
Thread-Index: AQHYmHPj95q5mWrtS0GGLuvs3DXs0a2L2/OAgAMA1QCAAAHggIABf1QAgAARioA=
Date:   Tue, 26 Jul 2022 09:14:49 +0000
Message-ID: <5cca96f1-2f30-b0bf-394f-5ee0a29eaf3c@microchip.com>
References: <20220715175155.3567243-1-mail@conchuod.ie>
 <96972ad8-d146-3bc2-0e49-ffe88580bbee@microchip.com>
 <20220725091346.GA20370@willie-the-truck>
 <28e38506-8fce-9000-c211-199a7aa69910@microchip.com>
 <CAOnJCUJh0vU8-tK31-A44h+VNHZA2_R6GayNjFg-7Daa6efbag@mail.gmail.com>
In-Reply-To: <CAOnJCUJh0vU8-tK31-A44h+VNHZA2_R6GayNjFg-7Daa6efbag@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5147abe-2da2-4037-d106-08da6ee74aab
x-ms-traffictypediagnostic: IA1PR11MB6194:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kS828EImEGu5ATkQ15QkHPTvS4d38sa6FrTB19uUUtlBW/DUG361X3s61j+AJp+TBdu9GhRUiOGhKJGTNErtX8Yi9EKPt33v2ZkT8RzpFkiqiXIWaBA/Mj8xRyxuxMps6zp7+ZbHTYylcAz7CofLTmemlPiFQKjgwwB3omOjcWZvSeXbqpOpRj20FuLLSVH9PnODtQdvb5K4cBxG/TLsrEL7ZuPzO6aed3ZZ3366JyO0kcJSBVY5JLgmLfNwIru+oSMRJr6+b+4LfxB7ZbBhza6BgkKqkcd5jAOBNE5KM7hQ12cCsg3gKaKhwmGpGHS8pZJ7ke/S8dirYZsSGAoAeDCbtqHqL4wRb7LYTLrRgHCyoCFAXSD/bDhuGN3qCHZz63sqPUbgdou04v89ZiCRAz17c8Ondm84sk+CBqdAO3F5gcXhWcsl7BQmMR1d5pU94HCTHQ0PqTNYuND+hmmk0FZQgiTaOdAvy7d7/55skCW6D/ZyzORG1p0fFIs5OBM9pgYVlZfkMbeuqZlEr2UkFGGqmR6ZNAebbu+wcyXVaDx4rmswRmgPDcjvSB0CWZ8xZuMmbO7mCEa4oUE3HtA1hVsjqWphqReGv/+TClyJtMRj4Piu3qe3wZhjTg02heLYRlQtJRW1ATGvEWd2csfrtMIo9Qqeru+qZW+YAkh9Sv0xz7EeqWvwI7JDXyWVo0PFoHJnsB1f/imkMgegZvtJn4iD2+CeP837v74tV9A7kyfKLpS9bWl+37HVXCMKLlOzRC9N3OCpjsK4B+7Hq5yx7mSUR2pQCwfcnm9vkFUvtxJkmI3MuBY5nZlaImgX0JACcU74/ljFtItGqCtJeTR7jZYETd9t1yPazseF49wBeSxyV4aeoTm+2u2jaU4l3lwF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(346002)(136003)(396003)(31686004)(6486002)(6506007)(86362001)(6512007)(26005)(186003)(54906003)(71200400001)(53546011)(122000001)(6916009)(2616005)(316002)(38100700002)(91956017)(8676002)(64756008)(66476007)(5660300002)(66446008)(478600001)(66946007)(7416002)(8936002)(66556008)(4326008)(76116006)(41300700001)(31696002)(36756003)(38070700005)(2906002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk1YKzVnRk1hVjFXNkhzd0luUThRRXNTaG9lMmlVN1VtTzJpYXY0TDR3RGhs?=
 =?utf-8?B?blZkSG9Ra3F2cjFIMjkrYVdOd2kvK1ZZaU15SGNuVWVkUUcvVXVNRXJobEt2?=
 =?utf-8?B?UDRzSlExQ3BZTHpXQmwva1hGWGw4bkI4Q0JSQWF0dlpYSldocGd1c3RJWHVJ?=
 =?utf-8?B?Y1JTTm9GTFlLaW02NTZlZjgydW4wbUEwTDV6RFhhQnBPOEdOWDRhbFdoUmdX?=
 =?utf-8?B?dG83MTZtMkdMcVRnSDd4WFNaRGNYOHp5SlZnc3VHL1ZhWFhVanFsUnJQeXlV?=
 =?utf-8?B?ZWE3WUZkdTdla0JSTVo3dlZYNStKV095K1ErSmRQOWppaHhscTI3ZGVZbTdy?=
 =?utf-8?B?dVlVazlnQXJ4TXQyS3JlUWN5WkN3YXptRlJLbzRYaWhWQlVjbHNieFJldm1Y?=
 =?utf-8?B?bEJIbU42am9Zak5oeFRLaDFVVmkycmRNM0V1SklnR2djOHN2KzdIMVhNVW5x?=
 =?utf-8?B?K2NwSElqQVdQSjJ6VXFXa3pqM0k0S2tkZGN0TVNONzhnZkhyMlNPbnV2OHhE?=
 =?utf-8?B?REw2K3dqbFh4a0RDOFZDN092bC9GbFBKUWZGaEhXLy90eDUxbDZkaFJkeWJy?=
 =?utf-8?B?WVpaL1MrSWtrOVlrdGZ0YlBSZk1ralVnVThuUktlWUI2bXF3YVViMU55WGY2?=
 =?utf-8?B?ZFNJNFozblFsckFrRmdGUVJsN2JpQm5UWDNLbWw2RnllQ0xMdnVuZWplS1di?=
 =?utf-8?B?Zk5uY09yUXB5cFlzRXcvMEhjamMvTTRkR0VnRnFHakduYmE5M3ozQ0t1R1dT?=
 =?utf-8?B?RnRnTWUyZlBGckJ1Mmp6UHA4VkZxNW9ZelJRQmRTZXlySUhJazJGMnViK2Vk?=
 =?utf-8?B?L2JVbCt4MUdtdU5ocEhiS3NOckIwbS91OHdmeFNjcTNucUFlaU4yazNTc1g3?=
 =?utf-8?B?UGNybDU1ZitHa1h4eTFURHAxUnR5RThuc2pLY1JzdldmQnkwOGY5ZTNmSmQv?=
 =?utf-8?B?ak01MkRianRWNHcxaDdNZ253L3lmcU9SY0VJL0RGczl0ZnZ1QzZOaUdjUlRT?=
 =?utf-8?B?WjZJL3VFYUtZWGhrelErTE5xZXVrYm1pamxKZGJ5QzNlbVJ2QnpaVFUzMG5E?=
 =?utf-8?B?eWdFY01rTHZCVFdzalZ5SDBvbWh3cmxzSktwdDA1QWx3TGZIVGRjdmNGdVE3?=
 =?utf-8?B?WE53NnUyNXVCc3ZLTldiNGVkWkRNS1ZtSmQxZnpQMFFpS2ZNUmJ3TytGOUh4?=
 =?utf-8?B?SEhtUzBKNlI2RG1IS1A2MUtNbEQvU1I2VDgxTm9XRWRvcHcwMWRHb1d2alNh?=
 =?utf-8?B?akZSbjcyYUYvWWdqL0lLVlRja3FwODZTYi80clJjVWlaQWpiUjJzUHpjdlBt?=
 =?utf-8?B?SzFsajVGQXNMUVVEdFAzVFRwUEU0cG00bjRtM25DN2VEMVZ3cHhicVd6NW9q?=
 =?utf-8?B?VDcvVVhsOU81TlgxWTVoRGRtS2hNWlVndTVXaHZiY0lsY2crMXg2eUl4TTM1?=
 =?utf-8?B?Rmk4L3dJdmVWNDNoTE9Tbit4eVZ6ZS9seXJLdXZsaHJvQjl6UXBCbWgvVjZI?=
 =?utf-8?B?M25ianNTSHRLS3RwSDJGOU5yN0pDV0k2MThXUFdYWkVGc25IT3hJWHozRWRx?=
 =?utf-8?B?WWpFS1ZQOVYrWnl0NUN6d2hBbVYyQnJLcEVrZHhxNjQ0aTR4TlNtQ2dXRXZS?=
 =?utf-8?B?SGl2R3NJTlpkSVJJOGdMZnZLaGd6aFQrZGlnaE12ckJsSHVkZGlkbys4dDFv?=
 =?utf-8?B?WEg2YmJsMmNhM0FGeTYvTW5OYWNJbkFxcFBZOEpIY1ZUVzg2bGtOYVpvNVBL?=
 =?utf-8?B?aGZZdmY1YUw4ZG81WXRhcFVTYTY2azhBQ1B2Y1NJdUc2ZmRieVpyU0JTbVBo?=
 =?utf-8?B?SXV2VTRxRjl1MUp4eFdYL2gvK2lOdTJwcHB1TTJvdGdEckpydWJtbmdJMlR2?=
 =?utf-8?B?bWZBZjg1WmFNRzY3TzRaYWZhYWpPRFp1UkRHcCt6azVCMTlmWDdyOUcxMFBm?=
 =?utf-8?B?alRwbUNnSkowRS8rcDZtWXU0TjNhOTJnSGc2d1Q0TGZDZ2hUTGRqTkVvYVpv?=
 =?utf-8?B?QW9uSDR2VGxzMlpyYU9OUk1nZ1lvK2xGV0RaNXYyTXRuc3pDR2l0T2o2RkNU?=
 =?utf-8?B?M2krRGxIdlVocEFCL1l3U1RScHc5MTh5bHQvdTg4RC9sTjJsaGVTcjRIZkZO?=
 =?utf-8?Q?jks9iB5A6FlBjfwrbTCnZKWOO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2AEC7677E0F704086D026B624B5EDAF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5147abe-2da2-4037-d106-08da6ee74aab
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 09:14:49.5140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bKfJK2p+cyW3HJO1LCxKqMnoIuIDMRI4boucE4iuGLZFgSrEderONZVHhmmTEwVj7byff5f2dLQKHPKBSMQIfJTwmY3MpXEuup25YP3H5FU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6194
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYvMDcvMjAyMiAwOToxMiwgQXRpc2ggUGF0cmEgd3JvdGU6DQo+IA0KPiBTb3JyeSBmb3Ig
dGhlIGRlbGF5ZWQgcmVzcG9uc2UgaGVyZS4gSSB3YXMgcGxhbm5pbmcgdG8gdGVzdCB0aGUgc2Vy
aWVzDQo+IGxhc3Qgd2VlayBpdHNlbGYNCj4gYnV0IGdvdCBkcmFnZ2VkIGludG8gc29tZXRoaW5n
IGVsc2UgYW5kIGEgcWVtdSBidWcgZm9yIE5VTUEuDQoNCk5vIHdvcnJpZXMsIHRoYW5rcyBmb3Ig
dGVzdGluZy9yZXZpZXdpbmcgaXQuDQoNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIGZpeGVzLiBJIGhh
dmUgdGVzdGVkIHRoaXMgb24gUWVtdShyZW1vdmluZyB0aGUgdG9wb2xvZ3kNCj4gbm9kZSkgZm9y
IHRoZSBmb2xsb3dpbmcgY29uZmlndXJhdGlvbnMuDQo+IFNNUCwgIVNNUCwgTlVNQSAoMiBzb2Nr
ZXRzKQ0KDQpBIE5VTUEgdGVzdCwgZ3JlYXQhIEkgZG8gbmVlZCB0byBnZXQgcWVtdSBzZXQgdXAg
cHJvcGVybHkuLg0KDQo+IA0KPiBGV0lXLA0KPiBUZXN0ZWQtYnk6IEF0aXNoIFBhdHJhIDxhdGlz
aHBAcml2b3NpbmMuY29tPg0KDQpUaGFua3MsDQpDb25vci4NCg0KDQo=
