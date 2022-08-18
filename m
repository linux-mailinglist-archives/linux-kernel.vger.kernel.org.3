Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BE4597E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 08:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243634AbiHRGY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 02:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243610AbiHRGYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:24:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00C3A062E;
        Wed, 17 Aug 2022 23:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660803862; x=1692339862;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nJAEEZsSElK15N2slgWUJ6QqtwL65kB1RA07yR2WQ1g=;
  b=Wi5IJ/G2ozJdrHi55msCXGfhAgKvjeu//4rW18kKnAwJFMm+u8Mjw6pL
   +wOFvYue1oRbsBSSsH4rGKWOkvyV58+AJz+TxC73sZHF9Iv1CFvYhMPU4
   6hZ7P7nddftLeagm6IKk3Qj1KZHkVeRh2SRMdfBd8fFq8VVg9OmqpKhbX
   uJO4S5yq5oroRcfd+w0lj6Xt0YGiPau9tFhtdvPNXYqrnGYu6yi+FM9BY
   bPAjabeQ9+jKm9jlwYdIzHw/+EE5WiFLqGNYs9Pd77lu9ygwgf33sORJ9
   QR/fGgShCfzKBva73dJbd1A7Yw6f804Bw3I5ZuqAfK0VR6C3xQW0ZMgmq
   g==;
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="172975790"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Aug 2022 23:24:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 17 Aug 2022 23:24:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 17 Aug 2022 23:24:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQoFSaUO6/s5JC/yW+5zM0I3qS44Ek1IC5Jf5fRfrylxksoI/8GGKqccgWM10AKjklNJYeTC4UY6md/OvVUAb7y9MiUmBIEAvp2ekabtHtpAzR2wKznXPOqqWGsDwLbmTYvm81gzs69/NZ+Uh5qk42BbFaEfZxLTHhFNBRcGduGjpYdORcBIRpTgNwdUO60agOu/n3wdHcaEQijgdwxS6qXqvfletZO6aRjiRAn2mDevHQYtd3XEPmqOKKyVFCym1d2GmTl8MS/EO6/XL5a3aFvDoMkn5hNB9r82oBhzUfedFU4/15FHZbaTUCjWFCR2C1gSmQoDj6uN/9xop+Bmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJAEEZsSElK15N2slgWUJ6QqtwL65kB1RA07yR2WQ1g=;
 b=oSMtVUdnOfZocZxuvccLxlKuOSRUTT1/+d1xDBw+ZoAbLt6g6YvsgazkeXkcfYNFqAVEoVqkaBEEjmCpFvuKC3LsWJn88/nHSYFdJO5UWZMNBs3ohJL5KoahEXX8O5ARwBs5Pqpv4iEJlGuaQp6IDdr38mQ38blgWpGKaOF+Km8cgSCYPpUczauDvvIuc11Fj2cj8r/ybNuguAS9wlDohDcUusA76uhEDfhKhmouNRn0XtO+bG9IrEbVBhEhTS2mYqhCON7ppdlLld17AvZRF7cz9pUurQpKrma0Zz1EAf39M6F0e6pS46wrYE7tnKckL1u9mkYn5P6tEC/nPsi9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJAEEZsSElK15N2slgWUJ6QqtwL65kB1RA07yR2WQ1g=;
 b=IKReGLWaGJ51kL1Y4vWx4pO8BSGGoQQqVtajn2lcz7LHgw2YI+6x+jTeS559YoG8VRbRAaSm8A8+YmeJynkI16CE22l1S7St6tSAVILdxkOK4y1chSFqFcpc2o6yXNSOkdZfYIjCq2XH9q9EKO2K/5joKmqiuA03uf8kVj1jq0I=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR1101MB2354.namprd11.prod.outlook.com (2603:10b6:404:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 06:24:17 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 06:24:17 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ajones@ventanamicro.com>, <mail@conchuod.ie>
CC:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <daniel.lezcano@linaro.org>, <anup@brainfault.org>,
        <guoren@kernel.org>, <sagar.kadam@sifive.com>, <jrtc27@jrtc27.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <qemu-riscv@nongnu.org>,
        <robh@kernel.org>
Subject: Re: [PATCH v3 3/4] dt-bindings: riscv: add new riscv,isa strings for
 emulators
Thread-Topic: [PATCH v3 3/4] dt-bindings: riscv: add new riscv,isa strings for
 emulators
Thread-Index: AQHYsnXJCuqPnPdbO0SYHDj1BIYcZa20JQ4AgAACa4CAAAnQAA==
Date:   Thu, 18 Aug 2022 06:24:17 +0000
Message-ID: <f88d52d6-9cc3-951f-cdd7-c50c405540d0@microchip.com>
References: <20220817201212.990712-1-mail@conchuod.ie>
 <20220817201212.990712-4-mail@conchuod.ie>
 <20220818054014.wad7uqqnmoc2wrbp@kamzik>
 <20220818054853.7rivuc4qyojzeu3s@kamzik>
In-Reply-To: <20220818054853.7rivuc4qyojzeu3s@kamzik>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c6a0e7e-64ce-472f-f352-08da80e2472c
x-ms-traffictypediagnostic: BN6PR1101MB2354:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3dNwmYCNlgqT8RmtFRHXx1pFfkSywTMhQce4ORBhsZP+CHPPHz3IWvf2HKwgK8R+JJajrBxclk/rJP5S9C5Ph1RimyzML0GWwyy776D+vQhhENhNBoWVYEP6wcVLZLFCS89Ctf+8hH580S68QJaKF5Kxk/zdvlZxEWeaC27b/zR0Td/s2z/1i0N2rninq3j+6ZBEjM5QNf20wJGA7B5xutqeiOpJrFIq4WPvOs7ogUMcMPQbkJ8xf4AuCyi/fnBwBe3e9VD2i0tPcMWNERebmO3l/bPafefVIgzsj+JJkILvJzI2q79sqUoSfptf2+Ep65z57ZqV/gdWx8ZIEFm1pWCCnV8pvMPaGJzPBqzDKk9Sat+JBr0RcJyQMnFxKPm+0P2H6t3lbAp4piKrSJEnH7qcb2fvi5kJ2Rq/8WTx8fcrLCcpmU0EbFRKHLZuzcffOSoKSVmjhXhlcasXtzTeURQaHb3cj7LPKAzjCOoalEh5QC92DUodWSQyGEb0A2a4Gvi4jnn9omW5xLqlDB3Sw1EXUxWeIR2xXgqPpvJpjUC83AqqaT9HjCD1XJa4f248IJEo2FxdTe7Z9SYaq2rIs0dXH9xlAupvbhTFkgG360d7ADGQzNiZaon6pUBAIaGa/B4pN0n2I2xVi8aPopkej3Yy+wbz4/n6DpljLUOm3kjXy7+sFk3GhkA6L0mVrU4cJ46WlPtQNC9AhHwcoy3pPkr2rzs09eQpuyDDludHUZiL+5CPVONKuIeT3suiQ22nUblqBe9y/sS1ntu9hOSUt9LHEZ/huAUzh4O3dLNKVCJnrUj/urT3t8y3xVQ+aD7YzftITVn4OclG8FHjNL/9m8PRfC5T3XTvfELAwHSPsCO+Ey7OZYzeJUxWk4IksdWUMOY+pVI7iJ4FgJrcW5EwLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(39860400002)(376002)(186003)(966005)(31696002)(2616005)(2906002)(6506007)(86362001)(5660300002)(41300700001)(7416002)(122000001)(478600001)(6512007)(26005)(38070700005)(53546011)(38100700002)(110136005)(83380400001)(66446008)(8676002)(8936002)(6486002)(54906003)(36756003)(66556008)(91956017)(66476007)(316002)(71200400001)(4326008)(66946007)(64756008)(31686004)(76116006)(45980500001)(43740500002)(569394003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3dyOUZnWU5jWmM5OHVERS9RU21yL1VsWSs2Z0wvNnVrUDJhVmNPcTgzU0oz?=
 =?utf-8?B?cEVBYjR4Uk83cmcxN3U1R2dDUlJqaDVidWpmcGYxdC9vR2x3MmJ5cUQvL2xt?=
 =?utf-8?B?NHE4eG9HODVUQVByWW1Ya2tpWkkvdUZNcHdmUDNvdnF3YnduMituWWJxdkZy?=
 =?utf-8?B?cDFWLzFTNERCNWhGamVuRkdDK0NPUE1VL2JHaHZuKzVQZVhWc1Z1ZVdrNDZS?=
 =?utf-8?B?aDJiWnk0dmxsYkQ4dmZsRll1RFVBRG1oMk0wWVpaT1pMR09ldUprRWhqNEh5?=
 =?utf-8?B?NnJ0U0hQeXVIUVBRajNQRU8wbXc2UCtMNHZ4TjFSU1N0NnNzNE90dGoyRXV3?=
 =?utf-8?B?Sk1FcGQ5UWNtbU9DRDd1cC9KMWs5OUNPZ3RUUEVLNWExdzIvblRJQXd0d3c1?=
 =?utf-8?B?OW1OUzhoZUNUZHVrdENkTEVibVRVbk50NVpuQnZYMkVHaG9ob3czT20yM1Q0?=
 =?utf-8?B?SFByR29jMVAvWncxVWpGWnJrV0U3TVJXc0E3ZStvWWNwMlV6L0xWNDNmdG5i?=
 =?utf-8?B?UlBFS0Jxa2U3ODNLT3Vuckxud3VTa1ZibVB1Nk4xRmhxWWJCZU1kdVVXT2dp?=
 =?utf-8?B?aTZnMlBmcjhoeG1KK1hZRWovTWdKV2dKVmdXTk9mVGQyTFYwQ0ZZQmg1cGVS?=
 =?utf-8?B?WlcrSFB2TmJPa05QY29tbHk2WlNHVFhhTEZ0S0NvMHpVUEdoeFFHdmVPaCtU?=
 =?utf-8?B?ei8rVWI3ZFZiZmNzT1ZSZVpITTd1S1V0NW9PQUtvUEhsS1FxRERtS2tPRVh0?=
 =?utf-8?B?dk1WaC9Fa285ZVJOZEJ0THhuNFlxSzhQMU5WUkJXYUJBMGZqYm12bEVMZVBF?=
 =?utf-8?B?MzVmY0wvQnpJN1U0WWtzMnJPL2xRSWRoR2NlWit1ZDQ4d1gwQXMySUcrZ3Fs?=
 =?utf-8?B?RTdMUFJZdTEwVkcvMUdkWEpIQTJydDN4SlhSSDJKamxTNG5KaUNlQVd6eFBx?=
 =?utf-8?B?VVdxcUVHRXFvRUJrNytiK1JrNFQwUndoUVMzZFQ0L3AwNUh6b3lwakdQWElp?=
 =?utf-8?B?OHU1NnBBTmNMdHRLS2RqYkRZZlYva1R5Ui9IQklzVkYydmRPMnNyeHU1c3Rz?=
 =?utf-8?B?dVZWeGR0VlhBbXR6SlVRWjFmVE43S0ZlcEpMSEhYRm1oemNPajI1a29mMFNC?=
 =?utf-8?B?Nm11YjhEZ3BGekljUnp0MVlRbDJTZGtTeHc3K2RqM3M1VVRuSTMwcng3dUNZ?=
 =?utf-8?B?QVNFZVhTWGxwcW03SVhUZ29yNW50VkRTZTliNWNVUEJhWHIyQUk5eTFONmVZ?=
 =?utf-8?B?dGR3cnEweExPOXRPMVZmY2Yxc0xISXN1cnQrWkRLWVV5dm1tbGlOUEloYStq?=
 =?utf-8?B?YVg4SjdteFpqcmV2Zzd1NlFtUVZFRi9Kb1hxbmtwTFVhU0hldlIwSE9hdEp4?=
 =?utf-8?B?UUt2OFRYK2x0Q3lFM0syT0ZIZ3F3dTdVTHBzY3B4a2lJUjFkSFhVaEVIZXZx?=
 =?utf-8?B?Y0prODhzUkRUYng1M2pkNHRTcm5ZY2I4U1h3QWFBMHh6U0d3Zkx6MmpiTTln?=
 =?utf-8?B?ODluZnFSSTNJY1o4Vlg5Q1R2eTc2bjJDMHBiSG9Ga1BaTzZWVmQ2bWpnaWEy?=
 =?utf-8?B?QSs5SldKTDloVmhjMEd1VVAweUFpNnpvUU1GL2dTcDdjS0VLT3IvbjJmYk1q?=
 =?utf-8?B?SWxlMXVGSndqMnVJV24xS3VsS203cGtGYjJPWGx5bkhGS29zY0ZPeGtEL25j?=
 =?utf-8?B?amZwQnRYakZ6QkUxNUZEb28vTWdvZW4zSUU2STlaYmFUS2tDZnphRXdhWk8z?=
 =?utf-8?B?ZE5Ec3lCeWFLZEtZdllYRkMrWlRIMGhZdEVlanhVa2c0UEJFMXdYQ3hSdzM3?=
 =?utf-8?B?eEdFR24rSXRpVzdIZWxXL2hOcGFHYlNabGx6Y1RxS1REWkkxaVQvVXRkVGpO?=
 =?utf-8?B?TFBGclEwTmtKYTJtbFk1cUl1TStQdTljeHk2ZEdxQWdNdENlNVhROGJrUlk1?=
 =?utf-8?B?WHlBQm5LdFNWREVtZ1d6VktrSzVsTzhrWFlEcWkxRHNrdUJPNzk4UnVUNHJs?=
 =?utf-8?B?RWxXaHJUMXo1aWNUL3dFRm40T2lLTUlORnpEWFJya0dqSlNZdmlLcnpVNk5s?=
 =?utf-8?B?cE5PRXVnVW1YVHhYRHlrWVc1ZDRYNmNNdmNhMXV6OXJuNEhHM0RqUmJsUWRt?=
 =?utf-8?Q?+NBfQwd8JoOHRhIc4F8cEhhba?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA7A6259C025A34CA14B6130FD573797@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6a0e7e-64ce-472f-f352-08da80e2472c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 06:24:17.0814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pr5MdIUrmHIJcBAj2csczwZA6xkJojRznE/E+heboRK8jNKL+4Uz5CzWQk9xGANxWpqYMgjLs9VQnVgMcSQbFJwPgTwvzFD6vhsY+/mAD2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2354
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDgvMjAyMiAwNjo0OCwgQW5kcmV3IEpvbmVzIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFRodSwgQXVnIDE4LCAyMDIyIGF0IDA3OjQw
OjE0QU0gKzAyMDAsIEFuZHJldyBKb25lcyB3cm90ZToNCj4+IE9uIFdlZCwgQXVnIDE3LCAyMDIy
IGF0IDA5OjEyOjEyUE0gKzAxMDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4+PiBGcm9tOiBDb25v
ciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4+DQo+Pj4gVGhlIFFFTVUg
dmlydCBhbmQgc3Bpa2UgbWFjaGluZXMgY3VycmVudGx5IGV4cG9ydCBhIHJpc2N2LGlzYSBzdHJp
bmcgb2YNCj4+PiAicnY2NGltYWZkY3N1aCIsDQo+Pj4NCj4+PiBXaGlsZSB0aGUgUklTQy1WIGZv
dW5kYXRpb24gaGFzIGJlZW4gcmF0aWZ5aW5nIGEgYnVuY2ggb2YgZXh0ZW5zdGlvbnMNCj4+PiBl
dGMsIHRoZSBrZXJuZWwgaGFzIHJlbWFpbmVkIHJlbGF0aXZlbHkgc3RhdGljIHdpdGggd2hhdCBo
YXJkd2FyZSBpcw0KPj4+IHN1cHBvcnRlZCAtIGJ1dCB0aGUgc2FtZSBpcyBub3QgdHJ1ZSBvZiBR
RU1VLiBVc2luZyB0aGUgdmlydCBtYWNoaW5lDQo+Pj4gYW5kIHJ1bm5pbmcgZHQtdmFsaWRhdGUg
b24gdGhlIGR1bXBlZCBkdGIgZmFpbHMsIHBhcnRseSBkdWUgdG8gdGhlDQo+Pj4gdW5leHBlY3Rl
ZCBpc2Egc3RyaW5nLg0KPj4+DQo+Pj4gUmF0aGVyIHRoYW4gZW51bWVyYXRlIHRoZSBtYW55IG1h
bnkgcG9zc2JpbGl0aWVzLCBjaGFuZ2UgdGhlIHBhdHRlcm4NCj4+PiB0byBhIHJlZ2V4LCB3aXRo
IHRoZSBmb2xsb3dpbmcgYXNzdW1wdGlvbnM6DQo+Pj4gLSB0aGUgc2luZ2xlIGxldHRlciBvcmRl
ciBpcyBmaXhlZCAmIHdlIGRvbid0IGNhcmUgYWJvdXQgdGhpbmdzIHRoYXQNCj4+PiAgICBjYW4n
dCBldmVuIGRvICJpbWEiDQo+Pj4gLSB0aGUgc3RhbmRhcmQgbXVsdGkgbGV0dGVyIGV4dGVuc2lv
bnMgYXJlIGFsbCBpbiBhICJfejxmb28+IiBmb3JtYXQNCj4+PiAgICB3aGVyZSB0aGUgZmlyc3Qg
bGV0dGVyIG9mIDxmb28+IGlzIGEgdmFsaWQgc2luZ2xlIGxldHRlciBleHRlbnNpb24NCj4+PiAt
IF9zICYgX2ggYXJlIHVzZWQgZm9yIHN1cGVydmlzb3IgYW5kIGh5cGVyIHZpc29yIGV4dGVuc2lv
bnMuDQo+Pj4gLSBhZnRlciB0aGUgZmlyc3QgdHdvIGNoYXJzLCBhIHN0YW5kYXJkIG11bHRpIGxl
dHRlciBleHRlbnNpb24gbmFtZQ0KPj4+ICAgIGNvdWxkIGJlIGFuIGVuZ2xpc2ggICB3b3JkIChp
ZmVuY2VpIGFueW9uZT8pIHNvIGl0J3Mgbm90IHdvcnRoDQo+Pj4gICAgcmVzdHJpY3RpbmcgdGhl
IGNoYXJzZXQNCj4+PiAtIHZlbmRvciBJU0EgZXh0ZW5zaW9ucyBiZWdpbmQgd2l0aCBfeCBhbmQg
aGF2ZSBubyBjaGFyc2V0IHJlc3RyaWN0aW9ucw0KPj4+IC0gd2UgZG9uJ3QgY2FyZSBhYm91dCBh
biBlIGV4dGVuc2lvbiBmcm9tIGFuIE9TIHBvdg0KPj4+IC0gdGhhdCBhdHRlbXB0aW5nIHRvIHZh
bGlkYXRlIHRoZSBjb250ZW50cyBvZiB0aGUgbXVsdGlsZXR0ZXIgZXh0ZW5zaW9ucw0KPj4+ICAg
IHdpdGggZHQtdmFsaWRhdGUgYmV5b25kIHRoZSBmb3JtYXR0aW5nIGlzIGEgZnV0aWxlLCBtYXNz
aXZlbHkgdmVyYm9zZQ0KPj4+ICAgIG9yIHVud2llbGR5IGV4ZXJjaXNlIGF0IGJlc3QuDQo+Pj4g
LSBpbWEgYXJlIHJlcXVpcmVkDQo+Pj4NCj4+PiBUaGUgZm9sbG93aW5nIGxpbWl0YXRpb25zIGFs
c28gYXBwbHk6DQo+Pj4gLSBtdWx0aSBsZXR0ZXIgZXh0ZW5zaW9uIG9yZGVyaW5nIGlzIG5vdCBl
bmZvcmNlZC4gZHQtc2NoZW1hIGRvZXMgbm90DQo+Pj4gICAgYXBwZWFyIHRvIGFsbG93IGZvciBu
YW1lZCBtYXRjaCBncm91cHMsIHNvIHRoZSByZXN1bHRpbmcgcmVnZXggd291bGQNCj4+PiAgICBi
ZSBldmVuIG1vcmUgb2YgYSBoZWFkYWNoZS4NCj4+PiAtIGRpdHRvIGZvciB0aGUgbnVtYmVyZWQg
ZXh0ZW5zaW9ucy4NCj4+Pg0KPj4+IEZpbmFsbHksIGFkZCBtZSBhcyBhIG1haW50YWluZXIgb2Yg
dGhlIGJpbmRpbmcgc28gdGhhdCB3aGVuIGl0IGJyZWFrcw0KPj4+IGluIHRoZSBmdXR1cmUsIEkg
Y2FuIGJlIGhlbGQgcmVzcG9uc2libGUhDQo+Pj4NCj4+PiBSZXBvcnRlZC1ieTogUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz4NCj4+PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1yaXNjdi8yMDIyMDgwMzE3MDU1Mi5HQTIyNTAyNjYtcm9iaEBrZXJuZWwub3JnLw0KPj4+
IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+
DQo+Pj4gLS0tDQo+Pj4gUGFsbWVyLCBmZWVsIGZyZWUgdG8gZHJvcCB0aGUgbWFpbnRhaW5lciBh
ZGRpdGlvbi4gSSBqdXN0IG1vc3RseSB3YW50DQo+Pj4gdG8gY2xlYW4gdXAgbXkgb3duIG1lc3Mg
b24gdGhpcyB3aGVuIHRoZXkgZGVjaWRlIHRvIHJhdGlmeSBtb3JlDQo+Pj4gZXh0ZW5zaW9ucyAm
IHRoaXMgY29tZXMgYmFjayB1cCBhZ2Fpbi4NCj4+PiAtLS0NCj4+PiAgIERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9jcHVzLnlhbWwgfCA1ICsrLS0tDQo+Pj4gICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9jcHVzLnlh
bWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmlzY3YvY3B1cy55YW1sDQo+
Pj4gaW5kZXggODczZGQxMmY2ZTg5Li5jMGUwYmM1ZGNlMDQgMTAwNjQ0DQo+Pj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jpc2N2L2NwdXMueWFtbA0KPj4+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9jcHVzLnlhbWwNCj4+PiBA
QCAtOSw2ICs5LDcgQEAgdGl0bGU6IFJJU0MtViBiaW5kaW5ncyBmb3IgJ2NwdXMnIERUIG5vZGVz
DQo+Pj4gICBtYWludGFpbmVyczoNCj4+PiAgICAgLSBQYXVsIFdhbG1zbGV5IDxwYXVsLndhbG1z
bGV5QHNpZml2ZS5jb20+DQo+Pj4gICAgIC0gUGFsbWVyIERhYmJlbHQgPHBhbG1lckBzaWZpdmUu
Y29tPg0KPj4+ICsgIC0gQ29ub3IgRG9vbGV5IDxjb25vckBrZXJuZWwub3JnPg0KPj4+DQo+Pj4g
ICBkZXNjcmlwdGlvbjogfA0KPj4+ICAgICBUaGlzIGRvY3VtZW50IHVzZXMgc29tZSB0ZXJtaW5v
bG9neSBjb21tb24gdG8gdGhlIFJJU0MtViBjb21tdW5pdHkNCj4+PiBAQCAtNzksOSArODAsNyBA
QCBwcm9wZXJ0aWVzOg0KPj4+ICAgICAgICAgaW5zZW5zaXRpdmUsIGxldHRlcnMgaW4gdGhlIHJp
c2N2LGlzYSBzdHJpbmcgbXVzdCBiZSBhbGwNCj4+PiAgICAgICAgIGxvd2VyY2FzZSB0byBzaW1w
bGlmeSBwYXJzaW5nLg0KPj4+ICAgICAgICRyZWY6ICIvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZp
bml0aW9ucy9zdHJpbmciDQo+Pj4gLSAgICBlbnVtOg0KPj4+IC0gICAgICAtIHJ2NjRpbWFjDQo+
Pj4gLSAgICAgIC0gcnY2NGltYWZkYw0KPj4+ICsgICAgcGF0dGVybjogXnJ2KD86NjR8MzIpaW1h
Zj9kP3E/Yz9iP3Y/az9oPyg/Oig/Ol9benNoXVtpbWFmZHFjYnZrc2hdfF94KSg/OlthLXpdKSsp
KiQNCj4gDQo+IEFjdHVhbGx5IHdlIGRvbid0IHdhbnQgUyBhbmQgSCBleHRlbnNpb25zIHRvIGJl
IHRyZWF0ZWQgbGlrZSBaLCBidXQgcmF0aGVyDQo+IGxpa2UgWC4gT25seSBaIGV4dGVuc2lvbnMg
aGF2ZSB0aGUgY2F0ZWdvcnkgY2hhcmFjdGVyIGNvbnZlbnRpb24uIChBbmQgSSdtDQo+IHN0aWxs
IHRlbXB0ZWQgdG8ganVzdCBkcm9wIHRoZSBlbmZvcmNlbWVudCBmcm9tIFogdG9vLCBzaW5jZSBp
dCBhZGRzDQo+IGFkZGl0aW9uYWwgbWFpbnRlbmFuY2UgYW5kIHdlJ3ZlIGFscmVhZHkgc2V0dGxl
ZCBmb3Igc29tZXRoaW5nIGxlc3MgdGhhbg0KPiBjb21wbGV0ZS4pDQoNClllYWgsIEkgdGhpbmsg
eW91IGFyZSBwcm9iYWJseSByaWdodCB0aGVyZS4gSSdsbCBsZXQgdGhpcyBvbmUgc2l0IGZvcg0K
YSBmZXcgZGF5cyAmIGlmIG5vdGhpbmcgZWxzZSBjb21lcyBpbiBJJ2xsIHNlbmQgYSB2NCB3aXRo
IHRoZSBjaGFyc2V0DQpyZXN0cmljdGlvbiBkcm9wcGVkLg0KDQpUaGFua3MgRHJldywNCkNvbm9y
Lg0KDQo+IA0KPiBUaGFua3MsDQo+IGRyZXcNCj4gDQo+Pj4NCj4+PiAgICAgIyBSSVNDLVYgcmVx
dWlyZXMgJ3RpbWViYXNlLWZyZXF1ZW5jeScgaW4gL2NwdXMsIHNvIGRpc2FsbG93IGl0IGhlcmUN
Cj4+PiAgICAgdGltZWJhc2UtZnJlcXVlbmN5OiBmYWxzZQ0KPj4+IC0tDQo+Pj4gMi4zNy4xDQo+
Pj4NCj4+DQo+PiBSZXZpZXdlZC1ieTogQW5kcmV3IEpvbmVzIDxham9uZXNAdmVudGFuYW1pY3Jv
LmNvbT4NCg0K
