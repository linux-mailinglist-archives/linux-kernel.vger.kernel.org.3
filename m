Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A254BD839
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346589AbiBUH4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:56:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiBUH4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:56:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7CC1707D;
        Sun, 20 Feb 2022 23:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645430160; x=1676966160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ayCP4nKHfqBM/8lS4w219nfPSmnApA2itUcaZKGUjJ0=;
  b=VLGAaJjeQVmt9rJ6hW9egRMevE520WBiUHE3hSm44Z1ENP+PBStH2HPt
   YGdkjDSk9yprPc/oc4GPLn+Fc9Fm99Eu+UD6rK8+rAGdEe/4ykapt7q4N
   4Jx4xH8DxDEuxnqxhFl0jb9p/Cz3RZtCoOfFxTNw7Wod2rCoqG34CozTH
   3S4XEy9WYJVxF4bDW3cWWGG/Jd0RLnhfaMKg8QHsoYQRgZuFj8ivDKGP9
   oiAFH02ugzyJR1R0RHkFO+y/TfqRvkEqkpxLF7A1hmc/s6eL6o1ZHkPjS
   mAPyVE+AvCUKb80WyFCThtAm0mkn0204UV9/fKJ/hFS5YpYLTqDyEr/FQ
   A==;
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="146684503"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2022 00:55:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 21 Feb 2022 00:55:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 21 Feb 2022 00:55:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AB+livW5nQPdFHr0zVLcCicU3Rbr+fDn7egVUc5kMlNIUbzcCRGFYfh77t3nDrsiDZiKmEXaFvS7Kvcwzm0z9DIKPi/UCslZDVQpWqvxKrLipCWhfZ2OLoHyvRiGv78/IvM9ryZ+d61HzlmLzdnKkA9BCrznoOME1Pwv2VQOCp7Nonx1GbYgy8kSptfwzf2wyH4wDaZHYiToHayRiDBJkUPFCXU6SyLl7EXqy6tSriPof4WkJh5qw3+AQdshuNL2JWD6dsQeths2AWxAJYWSsa8n/+bdXYlhfGVzbHk1x4rX4/MVtNkSHddsoVI4JjGsT3LVpL48qKxV450t4N8ktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayCP4nKHfqBM/8lS4w219nfPSmnApA2itUcaZKGUjJ0=;
 b=FyI3clnkRSd/ogSbsOqbxR2Bm0l2wFH2EXpGkLAn8rGCWjFF2Tgo6EryK8gRC3c3ABmHVSybyu0bt5Ro4xR6mhtaFvx2VctLUsNRjMRKjJ6Usv4yR8BW1RzSvg5m5f04jTcm19His0Z9nPKYa46JBZ4225hmb3pm8kvHO3AYrpKl9JRE+TLl80BFZolYEbXG7Ty1//PwuKFYOUQRPY00m4vh4VopxNzy47UK+dFCGG7cQcxOc3AdTwsQ5opMwPLT+ZWqzQaLTW9UBEgircMSwfFOXcRJ4d8IYcRwA6vzVGWiKMP9zDgO4PH0Hry5QqzS4YKwmL4h56FYV7REV3WZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayCP4nKHfqBM/8lS4w219nfPSmnApA2itUcaZKGUjJ0=;
 b=QVKnKSnk6GduVKqH99m1eNTRj1vOix9IYVpdbE7CM8/ZKMUPuNqoaSteBPXaMn5W1BYiwPRsnve3UQshfkfcSm/vKqAcwFyThDYZB9Q8IiCNzwuXnouGFahcovr+KYyEBYlwu6cSvBKpwB16kcPHDEhE0T5iB8SSprePuU/aoI4=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by CY4PR11MB1400.namprd11.prod.outlook.com (2603:10b6:903:29::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Mon, 21 Feb
 2022 07:55:47 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d46c:fea3:ae31:aec]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d46c:fea3:ae31:aec%4]) with mapi id 15.20.4995.016; Mon, 21 Feb 2022
 07:55:47 +0000
From:   <Conor.Dooley@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>
CC:     <Lewis.Hanly@microchip.com>, <Daire.McNamara@microchip.com>,
        <Ivan.Griffin@microchip.com>, <atishp@rivosinc.com>,
        <robh@kernel.org>, <palmer@rivosinc.com>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <thierry.reding@gmail.com>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <geert@linux-m68k.org>, <krzysztof.kozlowski@canonical.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v7 05/11] dt-bindings: pwm: add microchip corepwm binding
Thread-Topic: [PATCH v7 05/11] dt-bindings: pwm: add microchip corepwm binding
Thread-Index: AQHYIaqu8FMtY4E09E+qARYRW8PzIqydrn6A
Date:   Mon, 21 Feb 2022 07:55:47 +0000
Message-ID: <4c470378-7aa0-deb8-e7b5-2aa4a86cac8e@microchip.com>
References: <20220214135840.168236-1-conor.dooley@microchip.com>
 <20220214135840.168236-6-conor.dooley@microchip.com>
In-Reply-To: <20220214135840.168236-6-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5af5343a-4956-416a-2074-08d9f50f923a
x-ms-traffictypediagnostic: CY4PR11MB1400:EE_
x-microsoft-antispam-prvs: <CY4PR11MB14000D59EC6DE95B60717A73983A9@CY4PR11MB1400.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cv2v2aYk+Co+OZB1LcEekUGu5uzhIkvzyWLJFNC5o3GdPWT8nh7y64P3mroa6mVuveEszKk3n+kuw9gbOJ+VE/9esrS2YzucACQhC81pmtHauBemqdfrk1Xc9iBZTv8NGknG1C8L4tJs70MUUWqtMeenHek0/MtwpL2ac6krO6Eo39NQEptd/q6zQ4SeIJZaEgV03+PXAMxVnMvatF0Cr/PrGTakTh0UjlVBhGj2vMAH6G1j6iV/fHD/i47ze7pxY0akWt817ByHhKDmvo4jRa706pKtnjIyLLWkkL0nXAkNvrHDOa53WKXZIDcOJFMXIZpCRjHW8EZ8phD7+w3afLYWPkGKlDpE4F70b9Q0ZCt/9IlkwsDywA/3ujGBG1OjhA51a/St8sPkix5BfdjYOt7qCy/dHD8nopnAiM+TuApdR5vn+GrPJnmX3uhbvS1SoGVjt2oSNo1LNJYKIbRqyIR1C+bMRKGlEQup2RQUYcwIee6LBv/1wgcgBAOdmChmooByBrItNO2P15ZOwdZFEB3A1KfxZwfd7Q2qHcxLXFl5k0H46hBJJydbwHoLRYXnXWWwE7LvzivHksv0v+bqLmwRAs6flmxy1GRUZ4UxvSUL5/24zjKW7oANiXuKTFR7ck94PhYhvPnG2/M0jYMatMYGycUh9me8HL/WIpti7tRWWuDxxwTt/4EZv4wzofnmXpz/ZEwXebuJULjz084uR0MitpSUbTq8ZXODFIfLTLFsgwH/I1SqQand7BaXSPF93ceci6JMZooNXUXzx8v3ynz/BK4mCkBsgpkn1Folv7o860qRiW1eRU7xnDR2vjvI3MgVqWn1zQPUpNRKRZmjI02CTQMl0eCxHmfjlCp6K1Qnkra4j+JQwoNZX3PsZM85y9l+ROgYjsjE9H+thkn9zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(2616005)(53546011)(6506007)(66556008)(76116006)(91956017)(66946007)(6512007)(966005)(8676002)(6916009)(54906003)(6486002)(71200400001)(66476007)(31696002)(86362001)(66446008)(316002)(508600001)(64756008)(122000001)(83380400001)(38070700005)(4326008)(38100700002)(5660300002)(8936002)(31686004)(2906002)(36756003)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkthZGRqaENKa0FRbGJNcE5XVjRvOXlSS05VdFhrQVRqY29hNmk1VWNYWmlQ?=
 =?utf-8?B?UG53RHdkYlVQL1JteEZqQ1JHOHlNU0tlMWtIUXhxckJ5RVZmMGplc2RKL1NM?=
 =?utf-8?B?MjgzdzlnSzFNM09pRWxnS2x4Nmt6dWtCeGo2bUZrZXpGdEJmMTlLemJvenY4?=
 =?utf-8?B?Nk5raXRVMHh1VHdOR2NkbWUxdEM3MUJCblZWZFZuUjBlRVY3L0ZjQzc5Skcw?=
 =?utf-8?B?T2JEbjc3NnZRUms4dXRrcExheHJnR3lPRWJQaS85cThjZTFLcVFCZzI1eWIr?=
 =?utf-8?B?T3pVNFYvZWJqVHluL2hRbDFlRGRXRTd3RWpkZHJ3OVhaeVVtWTlmbkczUnZr?=
 =?utf-8?B?SVdSQ0JCMVJEek9qeHMzcTdKZmNWeE1xSXNOU3dpdEhyOTZDcHNVbGg5VVJw?=
 =?utf-8?B?OVlyOUlFeDF0aFZVMXVvcWV4QmkxckYrUWRvNnFTQUtTNnRDSGVzelFLeVpK?=
 =?utf-8?B?amIxZlRGM1hWY3dmZ01jcmNKWUlOL2tYZHY0emhrSEwwK3grdXA4V2VhZUNv?=
 =?utf-8?B?ZEU0VTArWkE1djZFQmZBOG9zZE02T09ka0pGT1JsYmh3c0FpMHNFc0NKeVBw?=
 =?utf-8?B?SmJuQnl2UGFiTzJUL0JwcnZKbm9iUzRyeG4yRHBUbW9aS3JwbVlQc2N3VTZP?=
 =?utf-8?B?TmtPTm16dDIvN04rTUNrajFKUU91SE1tOFRUTVlPQllEQURSZDVaQ2dZQmd0?=
 =?utf-8?B?azFQeGpUZG1vSWdlaDd2eWd5WnMyWXJsclhWNW5IODJTTjczTitFUlVFdGty?=
 =?utf-8?B?VzlBckxwY3V6emFWeVpSMGNKdVp0UXdUOHVKQUp6emRYMzRYbnRXZThNRnVj?=
 =?utf-8?B?bmZpaDRrUEtFZkJ4NU9vRndlM0tGcTlGRDY3cTlVRE8vdlNEaTFRcGlnVmQ2?=
 =?utf-8?B?aldkblFheGhUK2tmTVp1NEtrRCszN0hZNFhyRU1IeU5Vd1lhRHRIamVuOHBZ?=
 =?utf-8?B?Qk5KS2k1NmFTaU1vNnJyQmRNczlyOVpzOG1QdGtZMGFHekhXbnZPb0NmK29L?=
 =?utf-8?B?Y0Z2eVZRVWV4MjF3bUd3UE1ud0Y3Tno2Y3Z2VEtBWXNMNkYzUVJ1NmZOMzFu?=
 =?utf-8?B?c2V1RS9nWENMWU9IS0FFUFBkWVlHZVk3Y1B4SFdJNUpnbWMyNGdiblZodGtn?=
 =?utf-8?B?WnJBbFBLbWE3STN6MWZDWmJ1YVB6NE5OY2tmNnhtdVNZWFlCWXpsZXg0d25u?=
 =?utf-8?B?ZDA4QXFSR3Nqam5kWGpHM2ZqTWRGOXdvM0F3MTVOc2thVU01MVdpVjVoQy9C?=
 =?utf-8?B?RWJZOWRwNk1Gc1FCVFJQY2grNVRRaGJJZ1lGeDlQR3Z2N3g2ek40RXZwcGJ4?=
 =?utf-8?B?Vk50OGJOZFBPNTVOSEhCYTR0aGlHaWVRNFlieVNTWjBGdmluenFJWFA1eGtG?=
 =?utf-8?B?ZWJJTklob25xMXFQZFB4azVQOC96QzNESDNXUERiQlFSRXZZQzBRYWp1V0sx?=
 =?utf-8?B?T1k3RXVXN0JZU3JaZVZBYWRWV3VlaTVPTjN0dVVDQjdaMHVWd01ycmhDMTdk?=
 =?utf-8?B?TmVEMnlTRk8vM0YvcGtlVUZ6dkVMcVBpdXVpa1dMOXlzZm43THQ4MHplLzg4?=
 =?utf-8?B?bzZpNFR2eWZHWEJzUGVNN09xSWVySkxhdURCWGNuR3NBeDZqRmp4R2NPZk5P?=
 =?utf-8?B?U3FHQUZ4ZzNoTnRGRXpIQTB1UE5QL045UmYwQkdYR1hVeXVqTStrTzR1cDdt?=
 =?utf-8?B?M1JvTzc0Q1dHcUU1NlpOTUxRNmc5WU5rcDF4Q3JaM3R0TXJIdXMwS1VadWRu?=
 =?utf-8?B?NTkyQmhCVlZHNzIybFV3aWQ5Qzd4QTd1T0JBZ050d2hGR3JRMWw0ZnQ2Wk1Y?=
 =?utf-8?B?Uzk3ZzlNSWU5cGJvTS9qcWNXUzRYRXJSYjVsTm1CR3JUS3J4VGltWGlORE5N?=
 =?utf-8?B?ZmdOaVR1SllyaHJmdm1wRHdxbG5EbHRPdld4YkJXYlhhRGpRWkhzZ1l3MXln?=
 =?utf-8?B?Njl3YjM3SEkxcWNqMnhyTUVBZU5CWG1sRHlJa2RDN3JRU2hnTUxueWR3K0tF?=
 =?utf-8?B?dDNubkxZaElRVmZLRkU0Y1MrUEtRRmQyU3BGZmRqVDJ0TC9sZ1lPN28rd3B0?=
 =?utf-8?B?anN6WkFFUnBKVEpoMUZlNzVsaFV4TjJuTllJTUVlVHNQYk5kUXJtNVFNR2Ja?=
 =?utf-8?B?K2xiekJlZ1pIRDUxUFVySndNYXJUWnhTODFmVVU1a29aSFNhYjVUaEFOUmI4?=
 =?utf-8?B?QmRyYWZoanZpUHQyMDZ5R3crbnROeUZZVEY2cmFjazhnOVc3V0RUMUt4bkVa?=
 =?utf-8?B?Z0tIdGJncEgwUTltbytwOHdWc25BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CA17A23C2508749A2921731274932DC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af5343a-4956-416a-2074-08d9f50f923a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 07:55:47.4514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcgGhIP1utv8VCqDgmilU4VPic9jevdu3pQGqwjeA4zdgVE0TqB2eXMy4W1F6ofCDHTyKrNDu4tRoDikXnXTL3GqTEda1UHc7BbJvSJ7t/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1400
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IFV3ZSwNCkNvdWxkIHlvdSB0YWtlIGEgbG9vayBhdCB0aGlzIHZlcnNpb24gJiBzZWUgaWYg
dGhlIGRlc2NyaXB0aW9ucyBhcmUgDQplYXNpZXIgdG8gdW5kZXJzdGFuZD8NClRoYW5rcywNCkNv
bm9yDQoNCk9uIDE0LzAyLzIwMjIgMTM6NTgsIGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tIHdy
b3RlOg0KPiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0K
PiANCj4gQWRkIGRldmljZSB0cmVlIGJpbmRpbmdzIGZvciB0aGUgTWljcm9jaGlwIGZwZ2EgZmFi
cmljIGJhc2VkICJjb3JlIiBQV00NCj4gY29udHJvbGxlci4NCj4gDQo+IFJldmlld2VkLWJ5OiBS
b2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29s
ZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiBBY2tlZC1ieTogUGFsbWVyIERhYmJl
bHQgPHBhbG1lckByaXZvc2luYy5jb20+DQo+IC0tLQ0KPiAgIC4uLi9iaW5kaW5ncy9wd20vbWlj
cm9jaGlwLGNvcmVwd20ueWFtbCAgICAgICB8IDgxICsrKysrKysrKysrKysrKysrKysNCj4gICAx
IGZpbGUgY2hhbmdlZCwgODEgaW5zZXJ0aW9ucygrKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL21pY3JvY2hpcCxjb3JlcHdtLnlh
bWwNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cHdtL21pY3JvY2hpcCxjb3JlcHdtLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcHdtL21pY3JvY2hpcCxjb3JlcHdtLnlhbWwNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gaW5kZXggMDAwMDAwMDAwMDAwLi5hN2ZhZTE3NzJhODENCj4gLS0tIC9kZXYvbnVsbA0KPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL21pY3JvY2hpcCxjb3Jl
cHdtLnlhbWwNCj4gQEAgLTAsMCArMSw4MSBAQA0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ICsNCj4gKyVZQU1MIDEuMg0KPiAr
LS0tDQo+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3B3bS9taWNyb2NoaXAs
Y29yZXB3bS55YW1sIw0KPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2No
ZW1hcy9jb3JlLnlhbWwjDQo+ICsNCj4gK3RpdGxlOiBNaWNyb2NoaXAgSVAgY29yZVBXTSBjb250
cm9sbGVyIGJpbmRpbmdzDQo+ICsNCj4gK21haW50YWluZXJzOg0KPiArICAtIENvbm9yIERvb2xl
eSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+ICsNCj4gK2Rlc2NyaXB0aW9uOiB8DQo+
ICsgIGNvcmVQV00gaXMgYW4gMTYgY2hhbm5lbCBwdWxzZSB3aWR0aCBtb2R1bGF0b3IgRlBHQSBJ
UA0KPiArDQo+ICsgIGh0dHBzOi8vd3d3Lm1pY3Jvc2VtaS5jb20vZXhpc3RpbmctcGFydHMvcGFy
dHMvMTUyMTE4DQo+ICsNCj4gK2FsbE9mOg0KPiArICAtICRyZWY6IHB3bS55YW1sIw0KPiArDQo+
ICtwcm9wZXJ0aWVzOg0KPiArICBjb21wYXRpYmxlOg0KPiArICAgIGl0ZW1zOg0KPiArICAgICAg
LSBjb25zdDogbWljcm9jaGlwLGNvcmVwd20tcnRsLXY0DQo+ICsNCj4gKyAgcmVnOg0KPiArICAg
IG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgY2xvY2tzOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+ICsN
Cj4gKyAgIiNwd20tY2VsbHMiOg0KPiArICAgIGNvbnN0OiAyDQo+ICsNCj4gKyAgbWljcm9jaGlw
LHN5bmMtdXBkYXRlLW1hc2s6DQo+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gKyAgICAgIERlcGVu
ZGluZyBvbiBob3cgdGhlIElQIGlzIGluc3RhbnRpYXRlZCwgdGhlcmUgYXJlIHR3byBtb2RlcyBv
ZiBvcGVyYXRpb24uDQo+ICsgICAgICBJbiBzeW5jaHJvbm91cyBtb2RlLCBhbGwgY2hhbm5lbHMg
YXJlIHVwZGF0ZWQgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgUFdNIHBlcmlvZCwNCj4gKyAgICAg
IGFuZCBpbiBhc3luY2hyb25vdXMgbW9kZSB1cGRhdGVzIGhhcHBlbiBhcyB0aGUgY29udHJvbCBy
ZWdpc3RlcnMgYXJlIHdyaXR0ZW4uDQo+ICsgICAgICBBIDE2IGJpdCB3aWRlICJTSEFET1dfUkVH
X0VOIiBwYXJhbWV0ZXIgb2YgdGhlIElQIGNvcmUgY29udHJvbHMgd2hldGhlciBzeW5jaHJvbm91
cw0KPiArICAgICAgbW9kZSBpcyBwb3NzaWJsZSBmb3IgZWFjaCBjaGFubmVsLCBhbmQgaXMgc2V0
IGJ5IHRoZSBiaXRzdHJlYW0gcHJvZ3JhbW1lZCB0byB0aGUNCj4gKyAgICAgIEZQR0EuIElmIHRo
ZSBJUCBjb3JlIGlzIGluc3RhbnRpYXRlZCB3aXRoIFNIQURPV19SRUdfRU54PTEsIGJvdGggcmVn
aXN0ZXJzIHRoYXQNCj4gKyAgICAgIGNvbnRyb2wgdGhlIGR1dHkgY3ljbGUgZm9yIGNoYW5uZWwg
eCBoYXZlIGEgc2Vjb25kICJzaGFkb3ciL2J1ZmZlciByZWcgc3ludGhlc2lzZWQuDQo+ICsgICAg
ICBBdCBydW50aW1lIGEgYml0IHdpZGUgcmVnaXN0ZXIgZXhwb3NlZCB0byBBUEIgY2FuIGJlIHVz
ZWQgdG8gdG9nZ2xlIG9uL29mZg0KPiArICAgICAgc3luY2hyb25pc2VkIG1vZGUgZm9yIGFsbCBj
aGFubmVscyBpdCBoYXMgYmVlbiBzeW50aGVzaXNlZCBmb3IuDQo+ICsgICAgICBFYWNoIGJpdCBv
ZiAibWljcm9jaGlwLHN5bmMtdXBkYXRlLW1hc2siIGNvcnJlc3BvbmRzIHRvIGEgUFdNIGNoYW5u
ZWwgJiByZXByZXNlbnRzDQo+ICsgICAgICB3aGV0aGVyIHN5bmNocm9ub3VzIG1vZGUgaXMgcG9z
c2libGUgZm9yIHRoZSBQV00gY2hhbm5lbC4NCj4gKw0KPiArICAgICRyZWY6IC9zY2hlbWFzL3R5
cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiArICAgIGRlZmF1bHQ6IDANCj4gKw0KPiAr
ICBtaWNyb2NoaXAsZGFjLW1vZGUtbWFzazoNCj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiArICAg
ICAgT3B0aW9uYWwsIHBlci1jaGFubmVsIExvdyBSaXBwbGUgREFDIG1vZGUgaXMgcG9zc2libGUg
b24gdGhpcyBJUCBjb3JlLiBJdCBjcmVhdGVzDQo+ICsgICAgICBhIG1pbmltdW0gcGVyaW9kIHB1
bHNlIHRyYWluIHdob3NlIEhpZ2gvTG93IGF2ZXJhZ2UgaXMgdGhhdCBvZiB0aGUgY2hvc2VuIGR1
dHkNCj4gKyAgICAgIGN5Y2xlLiBUaGlzICJEQUMiIHdpbGwgaGF2ZSBmYXIgYmV0dGVyIGJhbmR3
aWR0aCBhbmQgcmlwcGxlIHBlcmZvcm1hbmNlIHRoYW4gdGhlDQo+ICsgICAgICBzdGFuZGFyZCBQ
V00gYWxnb3JpdGhtIGNhbiBhY2hpZXZlLiBBIDE2IGJpdCBEQUNfTU9ERSBtb2R1bGUgcGFyYW1l
dGVyIG9mIHRoZSBJUA0KPiArICAgICAgY29yZSwgc2V0IGF0IGluc3RhbnRpYXRpb24gYW5kIGJ5
IHRoZSBiaXRzdHJlYW0gcHJvZ3JhbW1lZCB0byB0aGUgRlBHQSwgZGV0ZXJtaW5lcw0KPiArICAg
ICAgd2hldGhlciBhIGdpdmVuIGNoYW5uZWwgb3BlcmF0ZXMgaW4gcmVndWxhciBQV00gb3IgREFD
IG1vZGUuDQo+ICsgICAgICBFYWNoIGJpdCBjb3JyZXNwb25kcyB0byBhIFBXTSBjaGFubmVsICYg
cmVwcmVzZW50cyB3aGV0aGVyIERBQyBtb2RlIGlzIGVuYWJsZWQNCj4gKyAgICAgIGZvciB0aGF0
IGNoYW5uZWwuDQo+ICsNCj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy91aW50MzINCj4gKyAgICBkZWZhdWx0OiAwDQo+ICsNCj4gK3JlcXVpcmVkOg0KPiArICAt
IGNvbXBhdGlibGUNCj4gKyAgLSByZWcNCj4gKyAgLSBjbG9ja3MNCj4gKw0KPiArYWRkaXRpb25h
bFByb3BlcnRpZXM6IGZhbHNlDQo+ICsNCj4gK2V4YW1wbGVzOg0KPiArICAtIHwNCj4gKyAgICBw
d21ANDEwMDAwMDAgew0KPiArICAgICAgY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsY29yZXB3bS1y
dGwtdjQiOw0KPiArICAgICAgbWljcm9jaGlwLHN5bmMtdXBkYXRlLW1hc2sgPSAvYml0cy8gMzIg
PDA+Ow0KPiArICAgICAgY2xvY2tzID0gPCZjbGtjZmcgMzA+Ow0KPiArICAgICAgcmVnID0gPDB4
NDEwMDAwMDAgMHhGMD47DQo+ICsgICAgICAjcHdtLWNlbGxzID0gPDI+Ow0KPiArICAgIH07DQoN
Cg==
