Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203335AFE2F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiIGHy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiIGHyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:54:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79875A027A;
        Wed,  7 Sep 2022 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662537252; x=1694073252;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=87YBbu1op5hhfWmNSVCk7I506JwHeRwdRvMLzUnbh78=;
  b=RtmQ9uzWOUEEbfm1gN6Fp6xDu3pUCGx1SdCdMXGgGeZKuPnnO3AujdDN
   f1hQGIZSJNAiiv2Oce7WYwIWB6aIvgD3Vqn/t2EuvPly5j15IIWYNQ3jK
   gP3E4Y1GyHsKnBMWIr2Od1S/eC1VavHbudknqEHtfu/wXn204P/2o1zps
   qYJHFY5xksqZYBaUhbf85v1lj+wU5kPjbRsIBAGwEjz7jUhiC9kgwmyN7
   ffKtZTELGr4tNEWE0ifSiA77w41eAbYqEt8kNs5QNw4aKc37QbtuI365Z
   jYDqHiVj2mQEF2unA2UsAB2Qmik/niRFc1POWAzqQdU7KhYk12oMP81Ai
   g==;
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="179483124"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 00:54:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 00:54:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 00:54:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cejnwl6RAa85sA4NKRYaGoXCMSf4iXC362IHQ9SDdpmAoWkTSWXNlNrRmJL1a+BPCHa5njy1gqwp0aFl3GZm5ERpZWSY5A6w4TB39ZT3IAtM7bvzGOgXJ9pq2/fHDNKGP8GpuoOOecAQzLSm4Fz7BH+Njh9lF/PIqwsHtsbWWf0SUG1/5wPAzyRlhvcxXG6K0MqVgRxIrJTR/C3YLe06luN6yXxnmCevgg51rZl7wF1HIspRvs6UjHBfNxNwqS5V4GaXPsB6u2h+INA/z9C0hua61y7bfBeuvGjGf12pIJttn+S9IF9d44+8E6ZeCJBjDKPHi92N8cDEwu2nwVtsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87YBbu1op5hhfWmNSVCk7I506JwHeRwdRvMLzUnbh78=;
 b=oJh6f3BQZ6I9UJh2VqkUjDjEDPcxPfQYsfzg+DxEBEbr37+duABJwep1nV6DpqUadi45kisTQj7QBVe5kpbw0zd960b0gHKmFRrzeV4cn0DGBy5i3s9Y7II6jqYmi5k/uInqUGdXqZY+eJChcFforkiUVqre2JuH5hfIIYIwtY9YYkxvTtREnKamJAt66BhN0HRxb4pvb+dX9SuNKw6uGuQQZGTmdiMynaHqXtn/4nI1Q/RfPwgd6xO0pQqZMDuU2dBrtqNhwKxlIPsJXal0KAorlAH2kFnmlshqNDmOwaCSUUBO8KIBcvQfJBXHN+T9F8Brf3T1NE21+U4sSdfEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87YBbu1op5hhfWmNSVCk7I506JwHeRwdRvMLzUnbh78=;
 b=lFgGhfD5Zebx7vwlGmZFTIfu803c7pPaD2OHHdOFyJIYfeMJHsdtCcbCJTI2qwEN8hWWDY96qA1yacDjRsu4FqhKJWpD2pio2jG5KRlsAjPGGFlwNLAeV0qRmThBEFKqkZBnMZTdiwXyqXzvEGDTKMJ592MtFhhbQzkWKF42fuo=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 07:54:07 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4%7]) with mapi id 15.20.5588.014; Wed, 7 Sep 2022
 07:54:07 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <robh@kernel.org>
CC:     <mturquette@baylibre.com>, <jirislaby@kernel.org>,
        <richard.genoud@gmail.com>, <Claudiu.Beznea@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <radu_nicolae.pirea@upb.ro>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <broonie@kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>, <linux-spi@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <Tudor.Ambarus@microchip.com>,
        <gregkh@linuxfoundation.org>, <admin@hifiphile.com>,
        <linux-serial@vger.kernel.org>, <lee@kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v2 01/13] spi: dt-bindings: atmel,at91rm9200-spi: Add DMA
 related properties
Thread-Topic: [PATCH v2 01/13] spi: dt-bindings: atmel,at91rm9200-spi: Add DMA
 related properties
Thread-Index: AQHYwfihVgiVqqq9j0S1uPP+f55xp63S7sQAgACrUoA=
Date:   Wed, 7 Sep 2022 07:54:07 +0000
Message-ID: <b52a5f41-f6a4-8e24-983b-9a6b53bf96c9@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-2-sergiu.moga@microchip.com>
 <1662500460.128889.1224960.nullmailer@robh.at.kernel.org>
In-Reply-To: <1662500460.128889.1224960.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 156c4ab0-4f3d-4594-4b26-08da90a6244d
x-ms-traffictypediagnostic: DM6PR11MB4692:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bN4b43II/yTAnF5OzXxa2rZZfAVX6HlkSwkkvblp55xu4vKWK548YA3X9EKmtP09URCD6KOpFsXzRfpzO0LlUcK1gu1i+U+UlwAhptwclOYY2jJk0fh2k0eFJehLuqRxZYx32LYs3bBFYM335hnN3d9ZDXZh/Rkgl/gvmO7gMvdHadKE64iL/ECNo8RcBlj17UNjDQKf3ko7n/BAaa1MVQPBXruVqykDRnycKF6OeiyFx6QoYBCwYzb00jiJeZ4l9mO+K6Sb1EfPokFWcs8436lr9V3PJHBzYcQyQafYHYhwpuv6s48Ji10QaJUdoG5vtkI1CVzen+3trl1u4MmVx7puRjq/CwxFgcm3e/Czws9HdApqIvTbb9yms03V65b0OgTjLfT7s3swNu0RzpeYxvo/CkKV48TnHIh57l711NtKHhNItGUMhSgyIR7aH9vvMoWy+Oz75sHykxOzuUcGvg/A6tZcxkhbG5qh4Kanhn0vk1x4BREivzQdZxr35Zo+UfZjC/HnIpvFuCPJtX4xq42OfeFsNGWSs6vjm/xhr4f5Fl7rhLUSVhzswUjsY7H9RTX7n79Ee3lVhISzMF2Z//gm22mIuqNU9so+O9M8Krt1KoxSRqBJxmC+FLaCuGuQP2ywEHxqI73cR/wSGfr8h80QYkuUcq3j2hP1ydb0xlASeSs9PLjBat8OMtLlmKlD32Pi7neOM+UNu9Chd8g19joGRGSSQHdl22XCsiN6wmsC15ia7x4ucam4P/dTCqHeCcrF5c5WA525YeLsNoWHYhKuZukSlFjlNQ0hXFNlOZYdTRtW4VYwKKkRE1wacJ1sevUof3T3OGdGF/Nj3GFMwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(366004)(136003)(346002)(396003)(107886003)(41300700001)(26005)(53546011)(6506007)(478600001)(6486002)(966005)(71200400001)(83380400001)(2616005)(8936002)(186003)(2906002)(5660300002)(7416002)(6916009)(6512007)(54906003)(4326008)(316002)(66946007)(66556008)(64756008)(8676002)(66476007)(76116006)(66446008)(91956017)(122000001)(36756003)(38070700005)(31686004)(86362001)(31696002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a201K2EvVWl3VGJQaDlqV09rZUpjNXU2TkJ2SytNTXE1eWlMdDkxUmQxZTJO?=
 =?utf-8?B?SlB3T25rZDg3czh6NkgweGZwSWtkRFEweXdhTEdtZC94TWQvK3NKbGwrYlZs?=
 =?utf-8?B?Q29NLy9YRU0zYkthL3ZGNTNCWHRLN2h6S3lveHo2WjA4ZFpJUW4rTzFES1hL?=
 =?utf-8?B?S2NObHFPbFJpK3o2Z1YyNk4rMjZxcWhqbFVhYVZOaG5RNkdyS0h1YmgxVU5I?=
 =?utf-8?B?OE9jNjRpRTFOYjM5RzM1Q1l5T21rNUpWSzhGV3hOc3NkMUx0Y29rcmdwcVdI?=
 =?utf-8?B?YnBjcW9kaVlYVkJnUVJDeHF4OVZ6WThia25GOVA2ZjhLN2pXMldtT2ZuV3RJ?=
 =?utf-8?B?UVBTVDkwQVFpWGNWaW5KMXlVQW8rU2JaU1Z5bzFyRitUVVFrM29BajNmQ0tu?=
 =?utf-8?B?MEJZY0xsREFCVWsvdTNvOWdhRmV0dUVmNkxzeklXVGNYNUVJekFEelBqM2pE?=
 =?utf-8?B?a0FUMU8zNVYyK2wyNCtBWmtudzlwL2cza3dPYmdrcCtIdWRDeXIzSnhFMWhp?=
 =?utf-8?B?QWZyb2Z6VVB2WVVHaEp0YS9ZQ0NZT1hRZGY1cFB0SXZiMnVwQU1qSTRIRzlr?=
 =?utf-8?B?dFVFSk9rRVhSSUFPSVkxc04zcUd1RzA5U2s5YVNsa0FCOXdyUmp2T3lsNHp1?=
 =?utf-8?B?NHJNTE1PQWw3N1NOSFl3UXAwWjZ1Y05mQlMzUHpKSWF0dmVzSTVYS0NVdisy?=
 =?utf-8?B?djhDc3BPbGZrZHdhNnNvR2pRNi9iRER6a0N2d2paUmFhdG1hY0pOZHd2MHRD?=
 =?utf-8?B?d240L2NNMXIvRXFOc0EwNi9qRmtEYjUrOUI5cCtwNFkyZG9UNHFxUUlEN3hz?=
 =?utf-8?B?b0xJL282SDZWRkd1b0Z6MGxiUnc1dmY4SFBCUml5OVVEOStXSVI3QzkveWd6?=
 =?utf-8?B?c294RGxVd1lBY1cya09jOU1xWVV4YW1vMmZiSGVBMi9KUGhPZEpxK3NsZG9y?=
 =?utf-8?B?aG1LSitTVyt3MVJzUGdrb1lVRG8wc3JFUmNVQ1I2RDVoUkNwTjFYMmRMRUM1?=
 =?utf-8?B?RVNweXgraTJIQ1V5TlNQZWhQYzZ6K0ljbGFFeU50VUl1UnRFa1N3MFpGSHl1?=
 =?utf-8?B?ZVpOcEFmS3R3bDE5TjFrZ0dHQXA4cW5GdVhteHJST00vdGRkME01ZExXTU92?=
 =?utf-8?B?WjQrL3B4OXRnMjV2dWdVVXFWWjlxMG1hdlpRYllPVXhFQ0hYV2FPYWtKQW8r?=
 =?utf-8?B?Mzd5Smc5NUM0Q2pRQXp5RSt4RFVhSzVSajdtbm04UVJqamoyOVpRaGlqWlZi?=
 =?utf-8?B?U3ZWK0F0ZVY0OXJsNmNqRFl4TWhQS2ZVS3lFQnExazhYbUZVWUg0T2tWVHJL?=
 =?utf-8?B?Mm1qUHluVkJEMGIzOG9TVXNtNG11ekZFUS91Y1VFazh4NUQ2b1BDOUR3MVNW?=
 =?utf-8?B?MC9vZG1DeHFGMVdZVFRCVzBWbTJGVWR1UlVta3o5UU8xa1dOTEd1a2JUSGlv?=
 =?utf-8?B?bzBtYlFxV1JGSHdrQVJlL29tVWJWU05yamVsL2NBWkN1eVRPR3RoM2JwTzhT?=
 =?utf-8?B?VjVJaVJWZ0QxMWZFRHMrZm9wcDdWTm8rWUlaQ3QrSjNhcHkzK1h3ckxCOU1U?=
 =?utf-8?B?ak9SY3F2dGpDK0dUdHFNaWV3bmh1VW54OUNMSEoycEFhd2VDS2tNZVphT1ZC?=
 =?utf-8?B?a1JsY0ZYVVV2V2VQZk5wU0R4Zm42TGdGdFFDM3Y3MnhzQlMzRmNRZzhtRFNn?=
 =?utf-8?B?bFpNaXd6dXFGbXIrZjdYaXV0emVRMjVjYmhoZDVNelNqTUpETFROSjhTVm5Z?=
 =?utf-8?B?eFBiUGJzdWVHaExFVktpZXh3dHdsak93cm9QS28rMEZpQW16a3Z4bkowSkRl?=
 =?utf-8?B?L1Z0akJhQ1o4WjI4RU9kays1NjZ3c1JiTmp6QXdNZ0tHQVIzMnJOc1BMUHVT?=
 =?utf-8?B?ZWJmOUR2YTdrbGYwYmZDbmtBeW9KRDBVTXNEYkFmZWJCTXVWOWtDMitTeG1n?=
 =?utf-8?B?UmxOWStOQnN3aWNtYTJSMXNkTnhqbG5qd2tXNGpIcW9JVVQydU1nUlJ0TktN?=
 =?utf-8?B?d1h5T2pwbVhjWFN1RmNpdGdESVBFdDNRYU02ZDErRDBJUlhGYVdBaS9ubFFV?=
 =?utf-8?B?NCswTmlrVzNvQ0FvSmFrdGtDNWJtNmVFc1pJU0IwS3J5dGF4Wk53LytZY0R4?=
 =?utf-8?Q?9R9D66bJC/9nWG883vV8TKSfh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17A74718D4BFB447BCF01ABF35EBA054@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156c4ab0-4f3d-4594-4b26-08da90a6244d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 07:54:07.3893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzemuzlTRdK62mSkCNrD2GhsuUE/DfepLolEWJ/6Q86yt4EhOuc9Pj5zK8nPGjhxidco6nPfRbL3HP7QE5ZdBRkn0+xYJKERD4Tbmjme0Lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4692
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDkuMjAyMiAwMDo0MSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IA0KPiBPbiBUdWUsIDA2
IFNlcCAyMDIyIDE2OjU1OjAwICswMzAwLCBTZXJnaXUgTW9nYSB3cm90ZToNCj4+IFRoZSBEVCBu
b2RlcyBvZiB0aGUgU1BJIElQJ3MgbWF5IGNvbnRhaW4gRE1BIHJlbGF0ZWQgcHJvcGVydGllcyBz
bw0KPj4gbWFrZSBzdXJlIHRoYXQgdGhlIGJpbmRpbmcgaXMgYWJsZSB0byBwcm9wZXJseSB2YWxp
ZGF0ZSB0aG9zZSBhcw0KPj4gd2VsbCBieSBtYWtpbmcgaXQgYXdhcmUgb2YgdGhlc2Ugb3B0aW9u
YWwgcHJvcGVydGllcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTZXJnaXUgTW9nYSA8c2VyZ2l1
Lm1vZ2FAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4NCj4+DQo+PiB2MSAtPiB2MjoNCj4+IC0g
Tm90aGluZywgdGhpcyBwYXRjaCB3YXMgbm90IGhlcmUgYmVmb3JlDQo+Pg0KPj4NCj4+ICAgLi4u
L2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2F0bWVsLGF0OTFybTkyMDAtc3BpLnlhbWwgIHwgMTAg
KysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPj4NCj4g
DQo+IFJ1bm5pbmcgJ21ha2UgZHRic19jaGVjaycgd2l0aCB0aGUgc2NoZW1hIGluIHRoaXMgcGF0
Y2ggZ2l2ZXMgdGhlDQo+IGZvbGxvd2luZyB3YXJuaW5ncy4gQ29uc2lkZXIgaWYgdGhleSBhcmUg
ZXhwZWN0ZWQgb3IgdGhlIHNjaGVtYSBpcw0KPiBpbmNvcnJlY3QuIFRoZXNlIG1heSBub3QgYmUg
bmV3IHdhcm5pbmdzLg0KPiANCj4gTm90ZSB0aGF0IGl0IGlzIG5vdCB5ZXQgYSByZXF1aXJlbWVu
dCB0byBoYXZlIDAgd2FybmluZ3MgZm9yIGR0YnNfY2hlY2suDQo+IFRoaXMgd2lsbCBjaGFuZ2Ug
aW4gdGhlIGZ1dHVyZS4NCj4gDQo+IEZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBoZXJlOiBodHRwczov
L3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLw0KPiANCj4gDQo+IHNwaUA0MDA6IGRtYS1uYW1l
czowOiAndHgnIHdhcyBleHBlY3RlZA0KPiAgICAgICAgICBhcmNoL2FybS9ib290L2R0cy9hdDkx
LXNhbWE3ZzVlay5kdGINCj4gDQo+IHNwaUA0MDA6IGRtYS1uYW1lczoxOiAncngnIHdhcyBleHBl
Y3RlZA0KPiAgICAgICAgICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE3ZzVlay5kdGINCj4g
DQo+IHNwaUA0MDA6IFVuZXZhbHVhdGVkIHByb3BlcnRpZXMgYXJlIG5vdCBhbGxvd2VkICgnZG1h
LW5hbWVzJyB3YXMgdW5leHBlY3RlZCkNCj4gICAgICAgICAgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5
MS1zYW1hN2c1ZWsuZHRiDQo+IA0KDQpIaSwNCg0KVGhpcyBzaG91bGQgYmUgc29sdmVkIGJ5IHRo
ZSBuZXh0IHBhdGNoIG9mIHRoaXMgc2VyaWVzLiBJIGd1ZXNzIHRoaXMgDQp5YW1sIHByb3BlcnR5
IGFkZGl0aW9uIHNob3VsZCBoYXZlIGNvbWUgYWZ0ZXIgdGhlIERUUyBmaXggcGF0Y2guDQo=
