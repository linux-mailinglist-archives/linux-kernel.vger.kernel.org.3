Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C761528053
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbiEPJDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiEPJDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:03:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B5D20F5D
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652691810; x=1684227810;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dlt9sqKruUUHaA4FtsVgFMcZXgtnQvptBRI1bk9ancI=;
  b=rYrPaCLVARi8m3HdWaJ3s6Hi4RGLtyyoVhLMGz+r2q4r3AE/dB8c7JCu
   L+WvgU+4zb8grx/C6NOEh6sF9mtKD0N6K//NdetQ/xDZPRCaKNke37AfJ
   p0jeiwZ5JdMi8ytzzwATp9/MVAYqcE26FBU+TAgsQSsPWYSDjxP1xCRYz
   gpIbT0ko1EzP+a5Wlv07fAkGO0bEf21gDFdatuH0L3+avR1fOeOu7mvBW
   UfG7bW+J4mKwI7Zkd0qF8qxtjt5uT3lUAbjaMRT22kk0X932YUMS0ixNI
   Ao8Z4pKnHhJRPLV2ANyUi+PeGu7Ouaufjb27d/WzctvXtjhZPAB59vhHa
   g==;
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="163819140"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 May 2022 02:03:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 16 May 2022 02:03:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 16 May 2022 02:03:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZ/37+/mVk48+2/qCTWkadozLv6gc/Sg88R418BaOs5pWXK65DGFr4MvxtTKgX/X5u+l6Ow3EgWyQgmYU4GaemhlELGfEBy70KtMpNgLwWwbkiHIq6PY9JdGB6ERRKqXVrSWqEsH0+9IjSZuKcm59+EYqWlHfkgrPbEUYWUOzTP6jVqAARMrKrEPYkATVOYVFVQBK9/9OH/1WQmHHHINdXUCX46UKSslygn/lkCn8zScKAzibAahvsB3mV4z3EdSspZ6OKDBZeNzl+xGOqEE8qFoSqdibAtZuWeyQruuwdnPd3uqtKWK7i3ys5+7jM/bgpuhEfvG/zNdBkvr6DwV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlt9sqKruUUHaA4FtsVgFMcZXgtnQvptBRI1bk9ancI=;
 b=LAcBb+u5T8JNKS4NxXCrJuq78N393DT4tF1/pewusE9uL+Qz+ENsopxlE9m0FSZRUw+y3PkOSETSkOK6p+IYWXrUxntGzy/sKZSyI0fKR9ZUCu3Vpr1TAVoWE1fcRoefGUUjLvuOA4X9BPf7ihQg9wXhtSbZKZYKzXKYeKsko9n76jaPZSFDAGeUbwerDUS75dyQx6GBWdmuZIDrJiu9aF2mwvdTRUSReTBsg472XDAAna/T2vVuyNGNTq43OctrGq0TBF9iv0ZQobzma82lOLFGLPmg8JJwSraCgPsurDHDXEVUHU7c5ZBct8DLL38jpeSgRTBuWHaBNnaKqTobDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlt9sqKruUUHaA4FtsVgFMcZXgtnQvptBRI1bk9ancI=;
 b=qZuT+cY+qWa3rDU6Jk179Zc0SBpWixTtQf0WJJvrgpp4N/hKTBZ6I5TMgnt4n5/KKQh/YPCppANn+VFGdR1sOPXpk3bL8BAkHSyH04JieZBpcVaeukIf36g9oITbkVHjoLdjnAJEE79CtjD9ll4KrnDGGhFNL73ceI3U9lWyAf4=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by BY5PR11MB4210.namprd11.prod.outlook.com (2603:10b6:a03:1bd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16; Mon, 16 May
 2022 09:03:26 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d10f:cc33:cfd8:365e]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d10f:cc33:cfd8:365e%8]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 09:03:26 +0000
From:   <Conor.Dooley@microchip.com>
To:     <xianting.tian@linux.alibaba.com>, <mick@ics.forth.gr>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <anup@brainfault.org>,
        <akpm@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
        <rppt@kernel.org>, <david@redhat.com>, <wangborong@cdjrlc.com>,
        <twd2.me@gmail.com>, <seanjc@google.com>, <alex@ghiti.fr>,
        <petr.pavlu@suse.com>, <atishp@rivosinc.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <jianghuaming.jhm@alibaba-inc.com>, <guoren@kernel.org>,
        <stable@kernel.org>
Subject: Re: [PATCH v2] RISC-V: Mark IORESOURCE_EXCLUSIVE for reserved mem
 instead of IORESOURCE_BUSY
Thread-Topic: [PATCH v2] RISC-V: Mark IORESOURCE_EXCLUSIVE for reserved mem
 instead of IORESOURCE_BUSY
Thread-Index: AQHYZcbodUeP2/4vq0GQmc8+LLOXDK0hOFuAgAADR4A=
Date:   Mon, 16 May 2022 09:03:26 +0000
Message-ID: <2e62621a-1fb8-5de7-8d0e-e6c4019931a1@microchip.com>
References: <20220512060910.601832-1-xianting.tian@linux.alibaba.com>
 <e32a2228-2e2f-0da2-87e8-e364c0450dcd@linux.alibaba.com>
In-Reply-To: <e32a2228-2e2f-0da2-87e8-e364c0450dcd@linux.alibaba.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93278352-9c50-46ba-3efc-08da371af048
x-ms-traffictypediagnostic: BY5PR11MB4210:EE_
x-microsoft-antispam-prvs: <BY5PR11MB4210594A5325EF4A73CADF3A98CF9@BY5PR11MB4210.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J1uWk8zHLcPvhXeMlSx/DfpALevE0W73Nidcfs4ZS9fRD9r0/WfYP926N4uMumOMgKn6KMEJbCUFbafsHGxAJCWWEtq0f42jXl3fkxI75irhPCuPYZpGWBBp0HAECw6ibsFRBiVBPnU+Bkcp6OiJ1m5SB9KQHMhpqG8EBzfxJLzd8b7SSrm5M37Q2eDdEmLKUhoCOJ3VTZuzzHvhH6aTAdeffwLIQd3Jx2plGmttpazpP558PASOFcOwomrZ9kzlTuHR4qKlwdErfZWkrkPibO0KdjpMpvEiRreXNaZL3kBwxyNHeQCpwi5JvDZ05rjvX621yFaNZBIH50CVhBaOaeYCv3Yv/rZ9Fx3eQEty4APHdcQgCEmoAAfpkk4tZ9YeNDgl+RcDUhwM2Jvd44rJu9vjxerE82MtvRFqJQl02NVNNYB84r3xXU3DEMZH+r+Gito5hcFlCEcq+NlroRK4H2Bbn+kNVPxHfg3I5ZpqkR3MtLshQKu7+7QwMy2F8bP88FkI33cOf6QVMoqFLgJxekshvzOH90sC9Q55ZkYxMMXe8sMh4Pl1oojK/dsLNzosqwI2Q7NXjeJ/6cYHCjg5s5iv0+RvT2G6TPAG0czn3/P93LHW+EiDBkze4pKqY+Lc0sqhOIg3q6RQ6Jlk/t2gjw2EBjj3lMQNzZscKH9+WJt0yAyJc4YbiapUflIxNYTrJtyHgeqrcX6UB2n/cUiySSFUDsTJBFIvO+2m4B71yb/n/G4rBuOYWSkKWb2lNcjceau9PaCovlZ4XIMZirum7sTbgJnhHVjNRHKGMXO4dAtEF1Do2fFPncbdu53cuehFY74RkTs7QdfLB6Z8vxK70WiSUl7k7ZWOEfMxd4x+0v8QvNQ68XsKHRwpYMMXyVO6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(66446008)(66476007)(66556008)(83380400001)(66946007)(76116006)(53546011)(8676002)(5660300002)(4326008)(64756008)(26005)(186003)(8936002)(6512007)(6486002)(966005)(71200400001)(7416002)(2906002)(54906003)(38100700002)(36756003)(122000001)(316002)(110136005)(6506007)(86362001)(921005)(31686004)(38070700005)(508600001)(31696002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0pGcXZZc3VHeFhPamNPTEJJME16UHJHQnJuTVUrbHZqdHdHcm9GNWN2N1dG?=
 =?utf-8?B?aDQ1SkdMeEhTbXhMQjhBZ2ViQlV4WkZ0MS9kZGtyUGFQbTNycGlMSkJlcnJ1?=
 =?utf-8?B?eUJDQVdzTG4vYlRIS3o1d01LVjFONTJwWXVQUGxoSllMWnduNDAxN2NnQ1Q4?=
 =?utf-8?B?Q1lTSDhmYW1XdTQrbkJ5S3NZWDBJQWptYTM0T3RmNnJkY0Rjd1lUejBsbUVi?=
 =?utf-8?B?aGxHL21kc0thYmFDWjNiQStENk9EalhEeERyajdTMTQrb0h3RTVhaUU0cWd0?=
 =?utf-8?B?Qk94NUdWbFBnVUluY2tpVklEMGY0am9lakg2MjArY3JSc3R5NldpVklCNjdw?=
 =?utf-8?B?OTVqVEVBbHlOS2FNZURETk45bVIxRUZKZ3BybnovalNlWHdISHNpUjc0TVNo?=
 =?utf-8?B?eEdyM2xoS0s0TVI2QTYvZ3VyWkpKeCsxY1RXYWVUUnJySk5QRElJaklNcXNZ?=
 =?utf-8?B?K3RsZUs1UkxpZEJUSVduZHRPZUdEMTNTZ2tzZ0NNMXArK3Q2Rm50UFFJYVpF?=
 =?utf-8?B?TFYvanpjakZoclBtZFRFU2RIL2c2dmppYXlnZkFTT2JmeXowS0JyY3c2SGNV?=
 =?utf-8?B?Y1hlTXAxOGtFckp6ZnNJOEtIUHNuY1dOT1ZiR2VVNzVVM1hpenRXMVpDV0xR?=
 =?utf-8?B?Y0NiQTBDMlMzYW8vSGNxdWU3NEdBMlgrV0p1cEhSNjNDcUswc2Y3L3Q5dmxJ?=
 =?utf-8?B?VmQxNjNGelN5WWxtbmpzSU9KZWhhRnNxQ1pmTjNiWmZsTTNOZTQ0REF3aStI?=
 =?utf-8?B?dHFyaE9hWTJ0NkIzUXFLSEFURHJxbm44b2FrYUhRU2R6SUx2eEtJNzdMUThj?=
 =?utf-8?B?L1dYdlFOa3pUOGh6U1RyZStWU2VZQTJtQnh2RDJMRnJUSUNqSCszeVJ3RDV6?=
 =?utf-8?B?VDZ3VkRZQkRmdmM0ZVJxcWdwS0Q5K1V2ZVF4MHpQeHNza2tIZHhFeloyckpC?=
 =?utf-8?B?UC8vRDhFTWtIa2RjMVNZQ1czMnZ3dW9XajJOS1FSSjNWL1JPOUlkL1VxSmFn?=
 =?utf-8?B?T3dyeXNiV2doT1RmbVl6ZEI5NGJlWlZoQWtpbTlPUDIzWGNBTzkwVjI4eHN1?=
 =?utf-8?B?c3V6MEpoc3FKemRUejdxUk01aTJRbTM5VUhiTU1SU2NobDMranVDTGZHZVBz?=
 =?utf-8?B?YVlsQlp3SzZzS3Q4aTNNZm5hbi8zL1czcUFFVmhoV3MyckxLdW9sb0VPcWxH?=
 =?utf-8?B?cWM3L01LQW8wRWIwcDhaZEV0a3N6Zi9aVVVyVFdxYVdRdU5JNzJHU0dXMGI4?=
 =?utf-8?B?UXpmTGlRRzVibDZieVA0b2RGTy9ZQVdKaVd6QzF3MTRPcHpjbE96dmx2YmNt?=
 =?utf-8?B?OXEwci9ISy8yWTdzNHNIbXkzQTF3bXFQV3k3ckxoTDdITDVXNXNLK1orSXF0?=
 =?utf-8?B?S0ZaNzlHaUMwMU9SeFFhaXNVeGNsQ1RKNVFVUU9kQzkwWTRHUndZVTFNbE1I?=
 =?utf-8?B?Y3BVUlJ6MFdKem1tWHV1TFIrc0ZSUGE0UC9wZkRkcGlVUk4yeHRGZVZMb3lT?=
 =?utf-8?B?bzh0QTIvaU9qVk96ZjNHa0d0ekYwTVk0L1h1S3licGpkSWZBaW9nQkl6YnU4?=
 =?utf-8?B?djVmdlVjVkxlMWUxbUUwS1dMZTUxRWRyK1R1YVJhTU8rNDNXT0JVQXIxdDVQ?=
 =?utf-8?B?UGh4N3YvVW1ORXFXSEZJdGsyZHUrcVI4bmlNMnUxcGdFN1FuRktPN1NOQ0RH?=
 =?utf-8?B?ZXluZW8yenV1aHZkZTdTT3ZXd0hkQ0NSUm1naTF2UW5NRzRBcmZhaVQyVUZz?=
 =?utf-8?B?TkdZcDU4cHdxZy9vQlBjYnpJOU5PWnVnNWJQVit5bzYrTnpDbmN4TFBVRFJJ?=
 =?utf-8?B?N0hPM1dSanRVM21UOThqcUtVUGV4aWxVZkoxMW5ETjloM3NRL0lYSGZVVFly?=
 =?utf-8?B?V051R0hCd3FkZTlURll0WnZuQnFKMG40eUhIc1AvZ3RCMkczMGhxb3JKWXVw?=
 =?utf-8?B?UnBPUXhRVytpWk9iT042UEpXMmRZSnVPeG5vMk16STI1MHdkcWM0TG90UndQ?=
 =?utf-8?B?YUpIUklNaVJzVEdLYlBnblgxVTNtcnBrWWxvM0FUZWpYTytaaUFxS2pEM3Ns?=
 =?utf-8?B?ZXhHN0JTd3NwQWRUcytFMGloZm9HNEhxSDFLTks1K25URzd0Ylk5bHY2azJu?=
 =?utf-8?B?YzY1L3EwaVgwUWJtN3JNZE16MitlaG1pZm5zNU11T1VlVVhmK1JOZUo2RjJK?=
 =?utf-8?B?ZUcwRGhzSGZMSDl6M2VtMzhjZzl1eE1ndWZRYVdGL05LL2RwakEyMXE2Sjd4?=
 =?utf-8?B?RWl5dERjMTJmcEJLQ011dlBXckNQSG15VzZWMzFGR1VRNi91eHRBaWNTdm1G?=
 =?utf-8?B?MnVxVlp1WDlteGZ6d2RzUHVDQXJCdDJHMnY4elV5K2Q4UW5ZbkZXUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0BE799A86AB9B4AB0362A6818407A35@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93278352-9c50-46ba-3efc-08da371af048
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 09:03:26.6134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PweK12EQm/dp5n+UpFX3DMXCWS/4EZTskvF+G8bohp34Ef5fM+TZHjoxPG7t6parDdJth3IjxL28NFKPJhUTpxdhnOCRyDAG8rB3d2cQtVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4210
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDUvMjAyMiAwOTo1MCwgWGlhbnRpbmcgVGlhbiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaQ0KPiANCj4gQ291bGQgSSBnZXQgYW55IGNv
bW1lbnRzIGZvciB0aGUgdjIgcGF0Y2gsIHRoYW5rcw0KDQpMb29rcyBsaWtlIHlvdSBoYXZlIDMg
UmV2aWV3ZWQtYnlzIGFscmVhZHkgJiB0aGVyZSdzIG9ubHkgYmVlbiBvbmUgZnVsbA0Kd29ya2lu
ZyBkYXkgc2luY2UgeW91IHNlbnQgdGhlIHBhdGNoLCBwcm9iYWJseSBqdXN0IHdvcnRoIHdhaXRp
bmcgYSBsaXR0bGUNCmZvciBQYWxtZXIgdG8gZ2V0IGFyb3VuZCB0byBwaWNraW5nIGl0IHVwIDop
DQpUaGFua3MsDQpDb25vci4NCg0KPiANCj4g5ZyoIDIwMjIvNS8xMiDkuIvljYgyOjA5LCBYaWFu
dGluZyBUaWFuIOWGmemBkzoNCj4+IENvbW1pdCAwMGFiMDI3YTNiODIgKCJSSVNDLVY6IEFkZCBr
ZXJuZWwgaW1hZ2Ugc2VjdGlvbnMgdG8gdGhlIHJlc291cmNlIHRyZWUiKQ0KPj4gbWFya2VkIElP
UkVTT1VSQ0VfQlVTWSBmb3IgcmVzZXJ2ZWQgbWVtb3J5LCB3aGljaCBjYXN1ZWQgcmVzb3VyY2Ug
bWFwDQo+PiBmYWlsZWQgaW4gc3Vic2VxdWVudCBvcGVyYXRpb25zIG9mIHJlbGF0ZWQgZHJpdmVy
LCBzbyByZW1vdmUgdGhlDQo+PiBJT1JFU09VUkNFX0JVU1kgZmxhZy4gSW4gb3JkZXIgdG8gcHJv
aGliaXQgdXNlcmxhbmQgbWFwcGluZyByZXNlcnZlZA0KPj4gbWVtb3J5LCBtYXJrIElPUkVTT1VS
Q0VfRVhDTFVTSVZFIGZvciBpdC4NCj4+DQo+PiBUaGUgY29kZSB0byByZXByb2R1Y2UgdGhlIGlz
c3VlLA0KPj4gZHRzOg0KPj4gwqDCoMKgwqDCoMKgwqDCoCBtZW0wOiBtZW1vcnlAYTAwMDAwMDAg
ew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnID0gPDB4MCAweGEwMDAw
MDAwIDAgMHgxMDAwMDAwPjsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5v
LW1hcDsNCj4+IMKgwqDCoMKgwqDCoMKgwqAgfTsNCj4+DQo+PiDCoMKgwqDCoMKgwqDCoMKgICZ0
ZXN0IHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXR1cyA9ICJva2F5
IjsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbW9yeS1yZWdpb24gPSA8
Jm1lbTA+Ow0KPj4gwqDCoMKgwqDCoMKgwqDCoCB9Ow0KPj4NCj4+IGNvZGU6DQo+PiDCoMKgwqDC
oMKgwqDCoMKgIG5wID0gb2ZfcGFyc2VfcGhhbmRsZShwZGV2LT5kZXYub2Zfbm9kZSwgIm1lbW9y
eS1yZWdpb24iLCAwKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gb2ZfYWRkcmVzc190b19y
ZXNvdXJjZShucCwgMCwgJnIpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoCBiYXNlID0gZGV2bV9pb3Jl
bWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsICZyKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqAgLy8gYmFz
ZSA9IC1FQlVTWQ0KPj4NCj4+IEZpeGVzOiAwMGFiMDI3YTNiODIgKCJSSVNDLVY6IEFkZCBrZXJu
ZWwgaW1hZ2Ugc2VjdGlvbnMgdG8gdGhlIHJlc291cmNlIHRyZWUiKQ0KPj4gUmVwb3J0ZWQtYnk6
IEh1YW1pbmcgSmlhbmcgPGppYW5naHVhbWluZy5qaG1AYWxpYmFiYS1pbmMuY29tPg0KPj4gUmV2
aWV3ZWQtYnk6IEd1byBSZW4gPGd1b3JlbkBrZXJuZWwub3JnPg0KPj4gUmV2aWV3ZWQtYnk6IE5p
Y2sgS29zc2lmaWRpcyA8bWlja0BpY3MuZm9ydGguZ3I+DQo+PiBTaWduZWQtb2ZmLWJ5OiBYaWFu
dGluZyBUaWFuIDx4aWFudGluZy50aWFuQGxpbnV4LmFsaWJhYmEuY29tPg0KPj4gLS0tDQo+PiDC
oCBhcmNoL3Jpc2N2L2tlcm5lbC9zZXR1cC5jIHwgNCArKy0tDQo+PiDCoCAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9h
cmNoL3Jpc2N2L2tlcm5lbC9zZXR1cC5jIGIvYXJjaC9yaXNjdi9rZXJuZWwvc2V0dXAuYw0KPj4g
aW5kZXggODM0ZWI2NTJhN2I5Li5lMGEwMDczOWJkMTMgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3Jp
c2N2L2tlcm5lbC9zZXR1cC5jDQo+PiArKysgYi9hcmNoL3Jpc2N2L2tlcm5lbC9zZXR1cC5jDQo+
PiBAQCAtMTg5LDcgKzE4OSw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBpbml0X3Jlc291cmNlcyh2
b2lkKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzID0gJm1lbV9yZXNbcmVzX2lk
eC0tXTsNCj4+DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXMtPm5hbWUgPSAiUmVz
ZXJ2ZWQiOw0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXMtPmZsYWdzID0gSU9SRVNP
VVJDRV9NRU0gfCBJT1JFU09VUkNFX0JVU1k7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJlcy0+ZmxhZ3MgPSBJT1JFU09VUkNFX01FTSB8IElPUkVTT1VSQ0VfRVhDTFVTSVZFOw0KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzLT5zdGFydCA9IF9fcGZuX3RvX3BoeXMobWVt
YmxvY2tfcmVnaW9uX3Jlc2VydmVkX2Jhc2VfcGZuKHJlZ2lvbikpOw0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmVzLT5lbmQgPSBfX3Bmbl90b19waHlzKG1lbWJsb2NrX3JlZ2lvbl9y
ZXNlcnZlZF9lbmRfcGZuKHJlZ2lvbikpIC0gMTsNCj4+DQo+PiBAQCAtMjE0LDcgKzIxNCw3IEBA
IHN0YXRpYyB2b2lkIF9faW5pdCBpbml0X3Jlc291cmNlcyh2b2lkKQ0KPj4NCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmICh1bmxpa2VseShtZW1ibG9ja19pc19ub21hcChyZWdpb24p
KSkgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcy0+
bmFtZSA9ICJSZXNlcnZlZCI7DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXMtPmZsYWdzID0gSU9SRVNPVVJDRV9NRU0gfCBJT1JFU09VUkNFX0JVU1k7DQo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXMtPmZsYWdzID0g
SU9SRVNPVVJDRV9NRU0gfCBJT1JFU09VUkNFX0VYQ0xVU0lWRTsNCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIH0gZWxzZSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmVzLT5uYW1lID0gIlN5c3RlbSBSQU0iOw0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcy0+ZmxhZ3MgPSBJT1JFU09VUkNFX1NZU1RF
TV9SQU0gfCBJT1JFU09VUkNFX0JVU1k7DQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QNCj4gbGlu
dXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2DQoNCg==
