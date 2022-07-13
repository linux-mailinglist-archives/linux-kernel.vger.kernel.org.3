Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC424572EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiGMHBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiGMHBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:01:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA016E0240;
        Wed, 13 Jul 2022 00:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657695658; x=1689231658;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+hzHNWrnR0Jjy8P0pXw/VLHXiRuNXVZ/FR0ik7TqPdE=;
  b=dET0W0Rhpd2q2ybbsqUhLFfXHnP/tToKytOvva8S11EEwIbtOCd25wYu
   ALFgY0q9hIV6Q7L/54EU4u+H2Rac+MpN+iIuK7JKZiSt3qarNE2Ot7/AL
   rOrXX1EMCBhhuyIR6qk+OLB+zxOa7pBd7zHS85zlXQZXzWY4tXtEq1Voc
   6JHYIG2jQV4BfoGkUvHldTOYz+FMH2J9YQbfTOz/piSsAfbnqsdUzpl3x
   OWXDq3d0O8ANM3cdSeHUEuW3w9NPW+MhQlh7kQCg8iLlQ5W9fXIPDuNPW
   nj+PIMbaZxN/TYmlTqzr3c0HpI8APYJpmvIkmx3njE78YC3m3ms4fhQX4
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="172162565"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 00:00:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 00:00:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 13 Jul 2022 00:00:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeAmPBcGa1+hqjzmlWvIxDBgZFQ3HTrU9pU8/DQos0Ft9tijHGgjC1lwB46zT9m16LFrqjKInbVwrulK4gTE/6FHlnimR2g5IsoDhAItQryqlfeViR2Jytka92Q5xezyUSGarecAdlfSyYeBFtGuocfXpiW8TWlZyOtotIq59xIXOnmwkZmoAtpICTrR0A9HsNtStSWh9OWnvzH49juZezai4czx7Z+j15Ph26MOk/HOftdavaYzAvFgW9GLhReoGy9uvZIVuq/P92gl/8kxHfU1MQR6if52orxEEB4eQp9jy1alslaSxh+Xlw9IMaLTLL6Ue0YmeNbP8RVC7nE0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hzHNWrnR0Jjy8P0pXw/VLHXiRuNXVZ/FR0ik7TqPdE=;
 b=RIZbcJFXZmAWbehdEwh1eY/PBRYrtHT06vMkKhIW6HQxilsheK0oycSrLH3M6lzDMSjUauXlLjm8DDEyaNXnHLtBJAIcZ/ivY0r5ZxvYyaB20cdvuna1fA7LDrA60DCMC0Y/NIHC1wkJAjUZESumh+cA3Zdxu/9eYtjnmjcj891lHjxEva8QJdMnUXQB14cYHwuY1ifPmtpvIxhUeaJr2DEDH6ss0zYUXxwqGSKtlpRE1Iu3ZTwjN9xh6iuTSqrUQc8UFdKUcdywe1dkmxjY3rSaWRfguzbfgVaMM8mm8TErr2rc3emIxtwdiMQBfPL8600k5Tt53t3IoVO1paTizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hzHNWrnR0Jjy8P0pXw/VLHXiRuNXVZ/FR0ik7TqPdE=;
 b=so2vVWZTmUj/LjiATom5Q1ZoWJIDRIuCAvFJv81FuZrVyPCV3H4+5rornHPn20kML3hvGD8EtuUiWdmVhL1QiDkeyTpy8hRJWdl56Mht5IGZKs7fD1jzCWL99fdTg/2tn80V9DhkNGPU/P5ldDpvFqyHm6I/gO6t1qTPaefJCBk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BL0PR11MB3204.namprd11.prod.outlook.com (2603:10b6:208:60::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 07:00:49 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 07:00:49 +0000
From:   <Conor.Dooley@microchip.com>
To:     <palmer@dabbelt.com>, <maz@kernel.org>, <davidlt@rivosinc.com>
CC:     <samuel@sholland.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <prabhakar.csengg@gmail.com>, <sagar.kadam@sifive.com>,
        <paul.walmsley@sifive.com>, <guoren@kernel.org>,
        <tglx@linutronix.de>, <geert+renesas@glider.be>,
        <linux-renesas-soc@vger.kernel.org>, <biju.das.jz@bp.renesas.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 0/4] Add PLIC support for Renesas RZ/Five SoC / Fix
 T-HEAD PLIC edge flow
Thread-Topic: [PATCH v3 0/4] Add PLIC support for Renesas RZ/Five SoC / Fix
 T-HEAD PLIC edge flow
Thread-Index: AQHYjGi29+Dq88ry8kS6295iTovrpK1plO8AgBIg4ACAAD39AA==
Date:   Wed, 13 Jul 2022 07:00:49 +0000
Message-ID: <6807a6ea-9b3e-cb9f-cb6d-1e9c5590aff1@microchip.com>
References: <mhng-60d46fe7-e88d-43b0-9cea-a4ae865baeb4@palmer-mbp2014>
In-Reply-To: <mhng-60d46fe7-e88d-43b0-9cea-a4ae865baeb4@palmer-mbp2014>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4eb1850-d8bd-4e5b-d2d1-08da649d6b1c
x-ms-traffictypediagnostic: BL0PR11MB3204:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FOArFYvqha6EzK/jQHtDdpAXWaFSJ0RED1Nz7JUlG5awPQot6O350HClnk07yjZtC/ciHS4Sv2VwDhK9fDlOCCW1U8QrmHoRjTBXk03CHLASMOwPfNlJqp52YWCUx5YXiS3ETeq9oQJ19If2NlWwmzub9TzURS9j09VERp9BaOWXLo3u6Hi7MZAu21/yYaqlPaG35YNgIjWk/8ezOUkcL60GMaPb2mMo1Kvso4lDGgBawbWTY+SKTWrKhOLfbDfCL3NbvxMphDGVZ6Tu9v5rSCogE2L3CgJogNYBxg3sjnbG0w8Hd6LMdgNa8qwrKOpoYRJZkX8Pwc/xtpRR2teuoI8FIXCtDELOYzIqvcdoe86CWEH9x0q3sV8H7D+JBqUSv8ZXbPW4Xf4+bG38bfNz5ARIlRLDoRtVkJQvhvaiUw5SBvSuAlnAF/VwVeIS7AgL+3iaU0JSL7MT1hqXkCeV/KrsLB4Zv0lJaZ06CGkKheW699J3DS8/VDfJ1vKiz8egYFpt2Axzt2E6stmFKCGX6gWHazrbu29Dfxslet/GlthfMogQJVGS/FaHJdF5D/U3qobw8JLdduNEAgv4lch7SY2wiQbgkWDyAynHXW+gCPOoY1YiCVtwnZ+mgPNF8b5gc2GTED4pE0BwzO8+qVlmE+nRFXN8mEaklmgTNSgfroHJhH2UVm0lNffszo6wwlzaX6wLpUvX/OXUKRmnQPnHjiJhebzM2sUEfAkOKfG2wzeo1DxFjOMM3G4kanLF3zBhMcNioIQgrxm2pcJCvo8HfsSt4w15IP65jkUdBbVE9mt3Qw8p4QqP4lSOxK1SeoogjMHqUPwRhlYOjETgs/HB0pW1WIHXpRduagsMw9dEVtranM02pM/n0xI/iucake4Py4MQRgaHexVDMi0crSb1t7SF+GdYPqwc7OGST1XG8xDf+AxYYenFYsKQj5+igva1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(366004)(396003)(346002)(39860400002)(41300700001)(38070700005)(53546011)(6506007)(2906002)(316002)(122000001)(83380400001)(26005)(38100700002)(31686004)(91956017)(7416002)(186003)(110136005)(66946007)(64756008)(5660300002)(66476007)(8676002)(76116006)(6512007)(36756003)(66446008)(478600001)(6486002)(31696002)(86362001)(966005)(71200400001)(4326008)(54906003)(8936002)(2616005)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUJsbmJWRzY1Z29MQVB3bzZCUks2eHBnSzgxSitac1BCMXgvcHdBSXU5dWxE?=
 =?utf-8?B?VStLbUVDWVpJWVlFQmlFaFlIeDJyKzZXb3FjbnJJZmk1eXRDS2dUd2V3MzZ3?=
 =?utf-8?B?dWUyeHRiNExtM21uekVWNWZrQW1QbmlUcEFoTmU2emFkRXdSUTEwanU0bC9K?=
 =?utf-8?B?ajNENm0rbm5Xd0I3TDl6MnpqWGViVEFCNThMTFpuV2pJUlQyanF5V2RVL3JJ?=
 =?utf-8?B?Ym5BbWJJM0NFdGoySXBHa08ySHpyWDhIelJXQU5UUHdnQjB0STFWc1c3WU9C?=
 =?utf-8?B?QkF5UDdXYWNRSEtQYUM1K0I1SFN0dEhxU3ZRUk5iaUV5dzhmaW51dmcrZ0tJ?=
 =?utf-8?B?em0yanNCNHVWQ0Y2cFp6Q1ZBTDdWSkc0UENpVFYyUldtZEdsU25FWSszbWdG?=
 =?utf-8?B?U2VUOWpOWCt5YzdzVjhIdE93MS84eWlMMXJLWkVsSE0rRjYvMnRsWWFyK2Qx?=
 =?utf-8?B?cVE0WjI4YWtsdnBhcVdnZisrNnZrUkdNYVdzNnZtWld2Q3JIZUZWZVAraC9O?=
 =?utf-8?B?UWlWNnN6eStVVC8xRFNoMW5jdCtFbVp2Q3pqOHFlcVJnUnRPMVkxb2NMQ0NC?=
 =?utf-8?B?LzU0QzBFYTNwSVFNelAxcDNEaG5rNjFhT21pZlVTdGprdFhURDFZZVNzMGVk?=
 =?utf-8?B?WnN4T3NEV2JyQlpsbElSOWtKbTBGU0VqcXZNSW9RY25jWGZGNmp4Z0lWVXlq?=
 =?utf-8?B?SmsxQmVsaS91TUVWZXVjaVk4S2Q3dkliTEwxZld4bkZSNitJZHp5dHd6aVNs?=
 =?utf-8?B?UGNRMGpXUDhwWlIzV0xqdTJJbFNHV29WMG0rcFpxUURWb1hYLzdVMG1vcm5j?=
 =?utf-8?B?bERVSVpLVWp6RFJzSlhIWUE4WjZONXVncTZuRjYyRzRYNHdVY2UwVWRVVW9v?=
 =?utf-8?B?L0E5U3NKTDhOaU1vc0l2dlF3c3VBM1pFQUpLb1k3T0NTSnA3Sm02bnJMMjhY?=
 =?utf-8?B?WWMyZklMU0w1NkxaMXdhV09KcWxRNDJyRnRtcHJDT0FpbzQ1LzVwUzVLM0l5?=
 =?utf-8?B?emQxNm41Tm9iU2dGLzNwSHRnRkxHZDVnZzQ1KzRjYXVJWjQvRE9jemVpUkxI?=
 =?utf-8?B?d0w1QXRpVGtlbGlTZFZWOGpubkw0Y3ZYZEZTRWVtUlZTa1hjTkhQR294dkQx?=
 =?utf-8?B?RVNjR2ZJaDlRcWVCbkpQY1VER3JiQWc5Q3JFNzZGRFRXTGo5MVVrN2I0YnZO?=
 =?utf-8?B?Vm1aL0w1anN6eXBqbFp2MkNaaEJPQXI2dkFxalY5ZTBKWGVQNk9HWU5sNURs?=
 =?utf-8?B?M0NZYkdXY3daWFJnODJkZnh4T1RSdjkveGRyd0NSL0NZWTZhaGhXUFVyU3NS?=
 =?utf-8?B?RDhpbExJSFVUWHJ3OUxWWWtmN3dMSGRZRlM5anVnbmxscWxOWnJCKyt2WnNl?=
 =?utf-8?B?eXhzOVNqK0VRdEJrbysyTlgwaVNkdUpLVHl5bWVrUVhOZnRzQ3laU2VxMkdJ?=
 =?utf-8?B?ZW9EZmtyOWNELzB1VCtFNm9pTUpzeGhZOUs2NUNZWEZKcHJvODZOOFg2UFBJ?=
 =?utf-8?B?VGE2OFJzOWpFVVA1R3UvNGNCODNoRExhQ0FIV2NDcUJ5L05PQmRIM2RIZnd4?=
 =?utf-8?B?UFNCVW81UEFSdkxmVHRuRmRUSmdvSExkMGl5NVh5QlVXc1R1a1JNSURvOEdP?=
 =?utf-8?B?UEpHVW1wRUFUWXA1WUZWSFlCV1ZYaUpUbU8rRy8rcVpJU3E2V1g1RTY0RzhY?=
 =?utf-8?B?SDlyV0ErbzduWVByZVRoRDg1MXBycmlFblhzZVd0eWtyT2FucTYzcGgxb1ly?=
 =?utf-8?B?ckN5NjMvUHlUbVJMNys2TmYxb0dUQjFpaVluYWR0Z3hETDdVK1czcUtVbTFK?=
 =?utf-8?B?aGxFMGFWYTIvcXZ4Q3ZPUjZHRC9wTE9UZGhiR0tyZnBHNkhVSGJiU2Q4ZXN3?=
 =?utf-8?B?KzNBckxlK3U2alhVZkw3WE5RbVRSK1pQZVhMdnh3T0hjNFJ6bU9CQ2FFa3Ew?=
 =?utf-8?B?cldLK3pZSk5SUEZQL0ZteTJKQ2Q0bm1KTEpKOEs3WFJJTENKbCtPVldGWmpp?=
 =?utf-8?B?NTU4MDc3Lyt5dFovZ01VdGNIU29xenNvUHduSUZkN1Z2LzM2UnR0V2ozc3Zz?=
 =?utf-8?B?WThWQURGL3lsNGdtOWFuT2daMnpnM3hiQVpGZ1JsTmdJOC9JdW5aRlV6VzdJ?=
 =?utf-8?Q?cjFBiYHyVw8YoOB29yebqwa55?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42A3B2DD0DE3644B8123F4CBD1A16798@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4eb1850-d8bd-4e5b-d2d1-08da649d6b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 07:00:49.5884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SwE1mpTT9GZqgpx76EjQ2lI895rnggd5NR10whrLzoTDPEGs9luQQdev1zVl5xfMQ8p+J3LtfDtO66cIlFdye0TCFR3gNoqwVtgTvXzMb/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3204
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMvMDcvMjAyMiAwNDoxOSwgUGFsbWVyIERhYmJlbHQgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gRnJpLCAwMSBKdWwgMjAyMiAwNzoyODo0
OCBQRFQgKC0wNzAwKSwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPj4gT24gMjAyMi0wNi0zMCAxMTow
MiwgU2FtdWVsIEhvbGxhbmQgd3JvdGU6DQo+Pj4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBQTElD
IHN1cHBvcnQgZm9yIFJlbmVzYXMgUlovRml2ZSBTb0MuDQo+Pj4NCj4+PiBTaW5jZSB0aGUgVC1I
RUFEIEM5MDAgUExJQyBoYXMgdGhlIHNhbWUgYmVoYXZpb3IsIGl0IGFsc28gYXBwbGllcyB0aGUN
Cj4+PiBmaXggZm9yIHRoYXQgdmFyaWFudC4NCj4+Pg0KPj4+IFRoaXMgc2VyaWVzIGlzIGFuIHVw
ZGF0ZSBvZiB2MiBvZiB0aGUgUlovRml2ZSBzZXJpZXNbMF0sIGFuZCByZXBsYWNlcw0KPj4+IHRo
ZSBzZXBhcmF0ZSBULUhFQUQgc2VyaWVzWzFdLg0KPj4+DQo+Pj4gWzBdOg0KPj4+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LXJpc2N2LzIwMjIwNjI2MDA0MzI2Ljg1NDgtMS1wcmFiaGFr
YXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20vDQo+Pj4gWzFdOg0KPj4+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LXJpc2N2LzIwMjIwNjI3MDUxMjU3LjM4NTQzLTEtc2FtdWVs
QHNob2xsYW5kLm9yZy8NCj4+Pg0KPj4+IENoYW5nZXMgaW4gdjM6DQo+Pj4gwqAtIEFkZCBhIG1v
cmUgZGV0YWlsZWQgZXhwbGFuYXRpb24gZm9yIHdoeSAjaW50ZXJydXB0LWNlbGxzIGRpZmZlcnMN
Cj4+PiDCoC0gQWRkIGFuZGVzdGVjaCxuY2VwbGljMTAwIGFzIGEgZmFsbGJhY2sgY29tcGF0aWJs
ZQ0KPj4+IMKgLSBTZXBhcmF0ZSB0aGUgY29uZGl0aW9uYWwgcGFydCBvZiB0aGUgYmluZGluZyBp
bnRvIHR3byBibG9ja3MgKG9uZQ0KPj4+IGZvcg0KPj4+IMKgwqAgdGhlIFBMSUMgaW1wbGVtZW50
YXRpb24gYW5kIHRoZSBvdGhlciBmb3IgdGhlIFNvQyBpbnRlZ3JhdGlvbikNCj4+PiDCoC0gVXNl
IGEgcXVpcmsgYml0IGZvciBzZWxlY3RpbmcgdGhlIGZsb3cgaW5zdGVhZCBvZiBhIHZhcmlhbnQg
SUQNCj4+PiDCoC0gVXNlIHRoZSBhbmRlc3RlY2gsbmNlcGxpYzEwMCBjb21wYXRpYmxlIHRvIHNl
bGVjdCB0aGUgbmV3IGJlaGF2aW9yDQo+Pj4gwqAtIFVzZSBoYW5kbGVfZWRnZV9pcnEgaW5zdGVh
ZCBvZiBoYW5kbGVfZmFzdGVvaV9hY2tfaXJxIHNvIC5pcnFfYWNrDQo+Pj4gwqDCoCBhbHdheXMg
Z2V0cyBjYWxsZWQNCj4+PiDCoC0gRG8gbm90IHNldCB0aGUgaGFuZGxlciBuYW1lLCBhcyBSSVND
LVYgc2VsZWN0cw0KPj4+IEdFTkVSSUNfSVJRX1NIT1dfTEVWRUwNCj4+PiDCoC0gVXNlIHRoZSBz
YW1lIG5hbWUgZm9yIHBsaWNfZWRnZV9jaGlwIGFzIHBsaWNfY2hpcA0KPj4+DQo+Pj4gQ2hhbmdl
cyBpbiB2MjoNCj4+PiDCoC0gRml4ZWQgcmV2aWV3IGNvbW1lbnRzIHBvaW50ZWQgYnkgTWFyYyBh
bmQgS3J6eXN6dG9mLg0KPj4+DQo+Pj4gQ2hhbmdlcyBpbiB2MToNCj4+PiDCoC0gRml4ZWQgcmV2
aWV3IGNvbW1lbnRzIHBvaW50ZWQgYnkgUm9iIGFuZCBHZWVydC4NCj4+PiDCoC0gQ2hhbmdlZCBp
bXBsZW1lbnRhdGlvbiBmb3IgRURHRSBpbnRlcnJ1cHQgaGFuZGxpbmcgb24gUmVuZXNhcw0KPj4+
IFJaL0ZpdmUNCj4+PiDCoMKgIFNvQy4NCj4+Pg0KPj4+IExhZCBQcmFiaGFrYXIgKDIpOg0KPj4+
IMKgIGR0LWJpbmRpbmdzOiBpbnRlcnJ1cHQtY29udHJvbGxlcjogc2lmaXZlLHBsaWM6IERvY3Vt
ZW50IFJlbmVzYXMNCj4+PiDCoMKgwqAgUlovRml2ZSBTb0MNCj4+PiDCoCBpcnFjaGlwL3NpZml2
ZS1wbGljOiBBZGQgc3VwcG9ydCBmb3IgUmVuZXNhcyBSWi9GaXZlIFNvQw0KPj4+DQo+Pj4gU2Ft
dWVsIEhvbGxhbmQgKDIpOg0KPj4+IMKgIGR0LWJpbmRpbmdzOiBpbnRlcnJ1cHQtY29udHJvbGxl
cjogUmVxdWlyZSB0cmlnZ2VyIHR5cGUgZm9yIFQtSEVBRA0KPj4+IMKgwqDCoCBQTElDDQo+Pj4g
wqAgaXJxY2hpcC9zaWZpdmUtcGxpYzogRml4IFQtSEVBRCBQTElDIGVkZ2UgdHJpZ2dlciBoYW5k
bGluZw0KPj4+DQo+Pj4gwqAuLi4vc2lmaXZlLHBsaWMtMS4wLjAueWFtbMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNjUgKysrKysrKysrKysrKy0tDQo+Pj4gwqBkcml2
ZXJzL2lycWNoaXAvaXJxLXNpZml2ZS1wbGljLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA4
MCArKysrKysrKysrKysrKysrKy0tDQo+Pj4gwqAyIGZpbGVzIGNoYW5nZWQsIDEzNSBpbnNlcnRp
b25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+DQo+PiBJJ20gZ29pbmcgdG8gcHJvdmlzaW9uYWxs
eSBxdWV1ZSB0aGlzIGludG8gLW5leHQgc28gdGhhdCBpdA0KPj4gY2FuIGdldCBzb21lIHRlc3Rp
bmcuIEknZCBzdGlsbCB3YW50IHRoZSBEVCBjaGFuZ2VzIHRvIGJlDQo+PiBBY2snZWQgYmVmb3Jl
IHRoZSBuZXh0IG1lcmdlIHdpbmRvdyB0aG91Z2guDQo+IA0KPiArRGF2aWQsIGFzIElJUkMgaGUg
c3RpbGwgdGVzdHMgb24gU2lGaXZlIGhhcmR3YXJlLg0KDQpOb3QgRGF2aWQsIGJ1dCBGV0lXOg0K
SSBoYXZlIG5vdCBkb25lIGFueSBzcGVjaWZpYyB0ZXN0aW5nLCBidXQgSSd2ZSBiZWVuIHJ1bm5p
bmcgdmFyaW91cw0KLW5leHQgcmV2aXNpb25zIHNpbmNlIHRoaXMgd2FzIHB1dCBpbiB0aGVyZSAo
b24gUG9sYXJGaXJlICYgdTU0MCkNCmFuZCBoYXZlIG5vdCBub3RpY2VkIGFueXRoaW5nIG9idmlv
dXNseSB3cm9uZy4NClRoYW5rcywNCkNvbm9yLg0KDQo+IA0KPiBBY2tlZC1ieTogUGFsbWVyIERh
YmJlbHQgPHBhbG1lckByaXZvc2luYy5jb20+DQo+IA0KPiBUaG91Z2ggSSBhbHNvIHdhaXQgZm9y
IFJvYiBvbiBEVCBzdHVmZiAoSSBzYXcgdGhlIG90aGVyIHRocmVhZCksIHNvIG5vdA0KPiBzdXJl
IHRoYXQgaGVscHMgYW55Lg0KPiANCj4gVGhhbmtzIQ0KPiANCj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0
DQo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdg0KDQo=
