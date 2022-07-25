Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915B457FC43
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbiGYJVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbiGYJU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:20:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AECA14092
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658740855; x=1690276855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Kxz81uhofzUGKB3FXh/I4/2dc4Haf9XqtUMtDmcsJ+A=;
  b=A5XCE0Hx026N+Gq7fJyCx8tA2OLOP9vSioUtC/XeYVvZfniTa1cchYMn
   u/Wmdv9SlVg6P1YlcIR4QkxLDy1hl7qvdefqNIS7UAnMeJj8BNxcmMTdg
   Mw6Vk4+Mxlt7XR+3eVPn/wok2MEeu4t2bMsLMDWqrQjSYiMxAq/VJMcaV
   ytHgwdUEk9DAhv+PI1EggW52zAyuk9uUvzCXFpSGgW5+8Nmkm36UsTijm
   WD1wBCQ0E/etI5XzS7eCSYcDVvAO03vR7sOqc80G2JsSvF9+ed6Ep5k4D
   c6o/QTHoqKkT6o7jnYpShKfmYmk1Cn74bOzlqh2qyvffhDpOwlLADZSXg
   w==;
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="105968012"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2022 02:20:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 02:20:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 25 Jul 2022 02:20:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nasmPMCAemzMn0ED5cnmkEyMm5IkYBSOASZc7UATdcqmrx1Bz/QpjGbSHIWpCX3OOQPfGcX0SzgkaZlS7fBYjYAX5+0B/mKN5DUreKxK/leaVVy4gO5BPSHodVbpEkhyOQBjMlpuUdDrQqL9SqMsrMKmJ/AEOAOxptM9xxfDIbxcHBJ3ql7BKesmP0nRcHw8NBdYFbIp12umUXar92pbFLPTgsNYr8O299oResBw60nnlhh/wbPzG38L5nhfonTDhhOAQ8BhqLpHE0Vk7vrtA2pQDvtMpKnUdzx+BrgGFIE2EUol9X03Av/KG7U0Ay2Umv+QgcdjOxdV/CPmClCXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kxz81uhofzUGKB3FXh/I4/2dc4Haf9XqtUMtDmcsJ+A=;
 b=OxBDthTKtSomdQAZYkcVpmQM8x2P5uKIyGjUUlcBX2XrJLzK2JfpsU5NLJkItPOM6Dof7pCJoWMtDbvCmyyI8HvoPyuJi/EuLLAfAG+cW8HFgIdgkzX+yMItYXQwQuUHQA/V//C0Y3siMWAqqAHvSY94Lar9X8M7l00hZ+nROuhHA4xCFs3SO+FfYv/etf1LsD71R2+AT7EOtnznpv+f5o1FlECRtD6uqnE7dn988D3g8yv+yE4GSP35c/OnLluNtXvuTiDpoGqHpX/pMHUW4f92/9CrErSxnOPOHmDEhu47nrwrbQjd94ty2Le6XcBdznMQKDmmneZjnAgYO9aXDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kxz81uhofzUGKB3FXh/I4/2dc4Haf9XqtUMtDmcsJ+A=;
 b=K85yGxAGMGQPupcbQ9v+84QqtMKXkD3Fbnt6R5h2QWuP3/KjuHBGgygXaMZoXohhjGE8M1Qg1afMmm1J9lteywC+oz9zAEGjjIjnIuHShj+znmwSe1eJbmTMR6T/B7Y0E8a4s7gn03mBkUmcg0pxkxi+QirFt3CGnT3r4/Ymnl8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH0PR11MB4951.namprd11.prod.outlook.com (2603:10b6:510:43::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 09:20:05 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%7]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 09:20:05 +0000
From:   <Conor.Dooley@microchip.com>
To:     <will@kernel.org>, <Conor.Dooley@microchip.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <palmer@rivosinc.com>, <aou@eecs.berkeley.edu>,
        <sudeep.holla@arm.com>, <catalin.marinas@arm.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <Daire.McNamara@microchip.com>, <niklas.cassel@wdc.com>,
        <damien.lemoal@opensource.wdc.com>, <geert@linux-m68k.org>,
        <zong.li@sifive.com>, <kernel@esmil.dk>, <hahnjo@hahnjo.de>,
        <guoren@kernel.org>, <anup@brainfault.org>,
        <atishp@atishpatra.org>, <heiko@sntech.de>,
        <philipp.tomsich@vrull.eu>, <robh@kernel.org>, <maz@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <Brice.Goglin@inria.fr>
Subject: Re: [PATCH v4 0/2] Fix RISC-V's arch-topology reporting
Thread-Topic: [PATCH v4 0/2] Fix RISC-V's arch-topology reporting
Thread-Index: AQHYmHPj95q5mWrtS0GGLuvs3DXs0a2L2/OAgAMA1QCAAAHggA==
Date:   Mon, 25 Jul 2022 09:20:05 +0000
Message-ID: <28e38506-8fce-9000-c211-199a7aa69910@microchip.com>
References: <20220715175155.3567243-1-mail@conchuod.ie>
 <96972ad8-d146-3bc2-0e49-ffe88580bbee@microchip.com>
 <20220725091346.GA20370@willie-the-truck>
In-Reply-To: <20220725091346.GA20370@willie-the-truck>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b42b583-5f9f-4993-8a3f-08da6e1edc5a
x-ms-traffictypediagnostic: PH0PR11MB4951:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZQE7bI9FqzLvAdX576YgT4+wFM9sHsVZ6U3bwmVsN3gGzIiIT9743qOglRwqlcZx7ERhlvBrgL28QXsFC53Xt3r9Yi2nrYd8HDmoAFDlj2dygLgmHiBNfW4MjxU90T8pbapUJJzfdynqoE9ci5g4SA2IIBDzr2y6lvxOTlNHzCqAck44T8CY9zkt9lQKeOGD/ia8utixx/2xh3mfnqjkgm6d+WKdFdSlBmR/DuveamI03Q9cWLj74cU9WRND12WxGWWYj22XEArK/jDnlbJPBMR1RLLL9LGi6KXNh//7CFZJPrsUpLj7vxDvf9w9snyNYe0fHcoMf1GuCY5XHgKEiLq+x9t9D6MVaiN9fRiPGjhHyTHE0h7eg0wEOxVYP0NLTVi9h1vTQEqzOQACTppmQRC/4d8gQRYoX+DLylmP03pO3jnA5SKa4zj0JbkRIdLuvtNjJ70O/gCeLwwyhDypz1qJ/T4l4kwG3wOROhcE7s2uuFKRSw3ySDC0ytlD4yfxarDAbp1VFmKWPlI+WsMdk4z+5C8aBtTytd03Rc1QaEl27yzTgHJO/vEI8F93igjooXDfmNPQWYVgNAouppuMSIXYPczEi1fNg4aOugx40Fkmll4jy2Ttgzt2z77JdMzjveZU8bV0OJy2zwYEKwx2Wvo9JjsT7HtSqmXiOnjNhy+btM485N2mDc0lSl/7yx4S7176ZeCdo9gRHzbV9luctPTfcdQ5FU7LqM6IGEnnhEUGiYIGmYQN3c+bNQkMSR97gstWDck/DdBFQq2Dz07DyowOEHOdL493835CvBzqHD/bGPHOJwHPhX2RNvMUs7sIVfcDlKWtC4PyP7v+ska15e5grvY7n7J0/qYEhUFltFCIIY7G2++pgpwuuIRufYAE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(39860400002)(376002)(31696002)(6486002)(478600001)(5660300002)(7416002)(8936002)(41300700001)(53546011)(6512007)(26005)(91956017)(2906002)(71200400001)(6506007)(86362001)(76116006)(66556008)(64756008)(66946007)(66446008)(8676002)(66476007)(4326008)(36756003)(316002)(110136005)(54906003)(122000001)(2616005)(38100700002)(83380400001)(31686004)(38070700005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzhlcCs2RzlwRzdkUlFROWw3LzFGa3lmbHFFT1NVYWlhSXR4SnNhdHdsS0RZ?=
 =?utf-8?B?bjcvOTN1UnhUbkxnL2lWNmdYbTFDcGQwd1RCd2UyMjA4MWdteDdqTUtEMHl0?=
 =?utf-8?B?Y2xCZVhKcWpIS2tLRmlNaFU1YWltR2xJZEt0b0ZqNmNzNEw3Vk1pY09yM3ll?=
 =?utf-8?B?Wk5DWjYyNVZCN213UDlkQ1NnZDFBQ0w4MFFydkxOamJ6ZWxINUsyOE1DSE42?=
 =?utf-8?B?TVlkaVZ2VnhpaE9uWENOTnY5dWNDaWVYUDhpZm9UYnpSNDNkSHRZMVZJcnNT?=
 =?utf-8?B?UGVwMjkyMzNiclk0MjJ5YnFkN1U4K2dQSVNyYTNCcUg1N1ArK1J2K01sM0k4?=
 =?utf-8?B?WHRER0F2MS82SkwzT0NzUGhWVnhZWWJhaDVCcXZhbzNyOERwY2I0dGwwak53?=
 =?utf-8?B?eUVrMnIyRGZJSW5zK0FtUkFSQkRKZ2p5SUlZR3lFbDdudXZxTGZIbVpRemFT?=
 =?utf-8?B?K1NyUE9mdjBTUE8xY2FpK2E3S3VMbHRKVTJlNDlCOHEvZmNQbHR6WENvRjlK?=
 =?utf-8?B?aTAxLzBKZVd5RVlJb0J0bmdUUzgwU3FpL2RWckh0M09OR3ZqWXNDUkoyNEx4?=
 =?utf-8?B?aGdGZHNPQ0xmM21iUnFpZ2xhZ29zb3FNV1RIU0ptNGRPeUNkbjhiZStQNUc0?=
 =?utf-8?B?Qk9xb2xKVC9rdnE3Qlpkc2VrOW9vc2NxS0tRR05rRGg0NDR3VjloV2lYeCtp?=
 =?utf-8?B?UnFHZml3QUw4UmQra2RiREluZ3hPR0NmamRKSnRPTzRueXoxWEY0OFZCbUsy?=
 =?utf-8?B?SllXdWxYdEVlQXgzL0w1TFVTbUFYTXdiMnpaUFRGT215SXZtekU5S08wN1hJ?=
 =?utf-8?B?clc0cysybDJ1NUh4QXI2c25pNkNuR3ZOWHBDMmxoNkV4a250QkVTNkU0blBp?=
 =?utf-8?B?TGRFSWtSQ1lhU1VUS1MxYVovWnI5Tzl4azg3UE55R01uU21pL1Q4TjUzMjlX?=
 =?utf-8?B?SDZyVktHY09YMnlKSjZkV3Z2aVN0ZG91bFJWVmx3dk1HNWYxR1RBbnI1ZUFV?=
 =?utf-8?B?ZnpTcERGTDFwWW1SbENjMGovNkhDYks1bmRJd1FjZ0tDMzJrNS9TUE0yTFZm?=
 =?utf-8?B?QU0rK1lnMnVFYStUWGF0S2pRS2ZwMUhiZStxTzk3dHY2a3pNVFVvbitPZTBw?=
 =?utf-8?B?aGJ0VEVWNTlNSnNZblFyRnJRVlpYM2ZhRHJmWGRHOGFBTXZnTkUwQk1wNlAw?=
 =?utf-8?B?aks1YmRKZGN5U3lnd0FkTDRQeXc2YnR4emRXbm93N3BmalpIRVJtd3BtS2h4?=
 =?utf-8?B?OHM1bkVnamdJZ3ZHVkFuVUp5NFZaeW1KYkJrYUNuWTM5dk9WZUszMXFNaDdI?=
 =?utf-8?B?dzNmWk0ybytBMUVVMzRHM29STnRDKzFEZVlGQi9na2pySUdBQTNkbXJiN0Mx?=
 =?utf-8?B?WXhnVk5QQ24xMUJJdkg2aituclBkWitSM2dzZnh5dE5iYWpXMlhOb0ZOYXlM?=
 =?utf-8?B?SmJyYlEvOGRxY3dtcDBERXV1eUViQS9YUXdPSmd5dWJoL2MxLzVOWENNUGNr?=
 =?utf-8?B?bUo1K1VkMlVUVzJWN0JRUkdja09qUDBMeWFjWVJpVGQrellsYXZoZmxrZnY5?=
 =?utf-8?B?eXhKRmw4ZGp1QnQ1dHI2YXFKNCtyTEdGbG0vVG81Z0lGNm5CYy9SRVRhdFgx?=
 =?utf-8?B?dVN3THdNV0RxT3dNOEIyOUdyV2lsZHl5dmdsY0VpYThKbHRoTmNJSXJZRTdr?=
 =?utf-8?B?MmtJK2pSell6Y2pGVEVRZ3Z5RjlwYkFIbWxLVSt4ZHlOMk9wdHUwZi8yM2VN?=
 =?utf-8?B?NGZlUjl3WWxEV0s1Snhia0JHR0hhMldUSTg2Mk5CY3hCSkl5RjVCa1dYMUh6?=
 =?utf-8?B?WWEzREF6VzdoK01pclAycjY4YTY3WWZyeThGK0hjc01zZ0Iza0paeEhSU2tS?=
 =?utf-8?B?K1BMdURUSkgxUEU4SHZON3p0V2dTK0hHa0ZmeFRvakdFVDRlc2dVeWtKcE5F?=
 =?utf-8?B?TWdzRmprRDRzNWRDQlRNRFRJRmNmSFJQdXJOVWEyaHpEK1NxTHZYb3J2OXBi?=
 =?utf-8?B?V0pvWjRBME9vSS9kV1ZwL1p4eUhIWnp0ZmJRSWEvWGVQTC9IR3VLTjIyZ3p0?=
 =?utf-8?B?UVArYnRhMGcyb3ZNY0RKZWxGNXEwWGFBd1ZlN2ZEak5mSG9CblI0aVpPd1NJ?=
 =?utf-8?Q?jLvqWVlHuUEAarmT/9V+GaOjs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B813E19B9D64442BEF666C7C154AE07@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b42b583-5f9f-4993-8a3f-08da6e1edc5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 09:20:05.1186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WtANs8vJV8cMVROvyBXNqhd+6ru3q5P9R+DEvDIgm//VVyzFFmgzTcK2Han2ZwyeXa65Y7v0hYrnMhuj3aWc+0O4v2fNvZJt1DGN8lNRPh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4951
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUvMDcvMjAyMiAxMDoxMywgV2lsbCBEZWFjb24gd3JvdGU6DQo+IE9uIFNhdCwgSnVsIDIz
LCAyMDIyIGF0IDExOjIyOjAxQU0gKzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdy
b3RlOg0KPj4gT24gMTUvMDcvMjAyMiAxODo1MSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPj4NCj4+
IEhleSwNCj4+DQo+PiBOb3QgZ290IGFueSBmZWVkYmFjayBvbiB0aGUgc21wYm9vdCBjaGFuZ2Vz
IGZyb20gdGhlIFJJU0MtViBzaWRlLg0KPj4gSSB0ZXN0ZWQgaXQgb24gcG9sYXJmaXJlLCB0aGUg
ZDEgKHdpdGggYm90aCBTTVAgJiAhU01QIHNldCBpaXJjKQ0KPj4gJiBvbiB0aGUgdTU0MC4gSXQg
YWxsIGxvb2tlZCBnb29kIHRvIG1lLg0KPj4NCj4+IEknZCBsaWtlIHRvIGhhdmUgdGhpcyBmaXhl
ZCBmb3IgdjUuMjAsIGJ1dCB0aGVyZSBpc24ndCB0b28gbXVjaA0KPj4gdGltZSBsZWZ0IGJlZm9y
ZSB0aGUgbXcuIE5vdCB0b28gc3VyZSBhYm91dCB0aGUgY3Jvc3MtdHJlZSBjaGFuZ2VzLA0KPj4g
ZG9lcyBpdCBuZWVkIGFuIGltbXV0YWJsZSBicmFuY2ggb3IgY291bGQgaXQgZ28gdGhyb3VnaCBk
cml2ZXItY29yZT8NCj4+IENhdGFsaW4gc3VnZ2VzdGVkIHJlbW92aW5nIHRoZSBDQyBzdGFibGUg
ZnJvbSBwYXRjaCAxLzIgJiBhZGRpbmcgaXQNCj4+IGFzIGEgZGVwZW5kZW5jeSBmb3IgdGhlIDIv
MiBwYXRjaCAtIGJ1dCBvYnZpb3VzbHkgdGhhdCdzIHVwIHRvIHRoZQ0KPj4gY29tbWl0dGVyIHRv
IHNvcnQgb3V0Lg0KPiANCj4gSSdtIGZpbmFsaXNpbmcgdGhlIGFybTY0IHF1ZXVlIHRvZGF5LCBz
byBJIGRvbid0IHJlYWxseSB3YW50IHRvIHB1bGwgaW4NCj4gYWRkaXRpb25hbCBjaGFuZ2VzIGJl
eW9uZCBjcml0aWNhbCBmaXhlcyBhdCB0aGlzIHBvaW50LCBJJ20gYWZyYWlkLiBJIHdhcw0KPiBo
YWxmLWV4cGVjdGluZyBhIHB1bGwgcmVxdWVzdCBmcm9tIHRoZSByaXNjdiBzaWRlIGxhc3Qgd2Vl
ayBidXQgSSBkaWRuJ3QNCj4gc2VlIGFueXRoaW5nLg0KDQpZZWFoLCB0aGF0J3MgZmFpci4gSXQn
cyBsYXRlIGluIHRoZSBnYW1lIGZvciBjcm9zcy10cmVlIG1lc3NpbmcuDQpJIGtub3cgUGFsbWVy
IGhhcyBiZWVuIHAgYnVzeSByZWNlbnRseS4NCg0KPiBGV0lXLCBpZiB0aGVyZSdzIHN0aWxsIG5v
IG1vdmVtZW50IGJ5IC1yYzEsIHRoZW4gSSdtIGhhcHB5IHRvIHF1ZXVlIGFsbA0KPiBvZiB0aGlz
IG9uIGl0cyBvd24gYnJhbmNoIGluIHRoZSBhcm02NCB0cmVlIGZvciA1LjIxLg0KDQpIb3BlZnVs
bHkgc29tZW9uZSBvbiB0aGUgcmlzY3Ygc2lkZSB3aWxsIGhhdmUgY29uZmlybWVkIHdoYXQgSSBh
bSBkb2luZw0KaXMgc2FuZSBieSB0aGVuLg0KDQo+IA0KPiBMZXQgbWUga25vdy4NCg0KSSB3aWxs
LCB0aGFua3MhDQo=
