Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9109563206
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbiGAK5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGAK47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:56:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5967E006;
        Fri,  1 Jul 2022 03:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656673014; x=1688209014;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nVSL4VprPSoyv5s5hy71MC21U0s05m63WIrVy/ZmoeY=;
  b=YS/oynNK1hAS7lHswuNS5kAmzdq6pwG3i/GwfOzeQecFQ4XIYBnnQF/o
   O5BOPLM9sRw4RF0n/aLxoG3ouEE4BaY2UeAhjDsge++w9IMTycpWvPlhH
   5azAoyk6kC8EpYv+dHdnDp9rOKDKsLQDM5xNMMYnCYer4ep74+TF7kwma
   0SI3Yq+p+AAxpqzYh8nh7NaEvmuGhPrkusmdXu+pSoz1EqbhRQOxB5F5q
   eMFzhcRp2qE2dprAj+LMxowconvNwotH+koHsGREpZWuQVyQcGY2tPg0h
   ONGqh+u9CW9u0YgiYqR9siIJrfrETpnkPtbpr4eCX7xjdZ11Da9Gqz6Xz
   w==;
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="165990386"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jul 2022 03:56:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 1 Jul 2022 03:56:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 1 Jul 2022 03:56:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpQ+peJxLMcuX4b0DaZKI+TuS4OLPFS1R+RtK+QneFRVgWfYqWRv2yhly2/aKMqRSlyBIe4DCpKcnrT5HchJg2Ib65u6j8Zb5oubjVdQ1l8LDt3bQvEXyMt1H6Yk16g+oNRsFfDJPVE9RC9bWIZL4eQOXThuOazBLzIRStCmQvR8hDT65Q5RX4JFo8Npym09q+33xa3nV7mEpEqL5FmaMZQElyQVgYy2JTDkcTJDen+RRvTFrAgwpVE5qZssV3UMd+l8GhqUYllLlRIfQx6BVQWrw5XaCFqtRUzHaW8JXQOGmGZCIorpETXCE9EVgZPxYxK5HB02FpiQEQs+PUnD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVSL4VprPSoyv5s5hy71MC21U0s05m63WIrVy/ZmoeY=;
 b=WEsy48Mqw8nyaXb/tB7xyt5MNg/VduygB4hbPx77yLss29QBBaG6adH0shdLI/pMElexGqEHIdp6Fvryve1AfJYd1+c6mnlpxHab6lc3t0uiRO7r/Bd9hW00Mz/83Hujt/1u+IOZyorDVctJeayQmWSGyhikpP5CHmPGBrf2NPP+7bL5AUtlsg//VLUOHiVkEM1yk4zEiXiXSCKtAGFnv21znV7sc/F8rmVi8c2PGfpLpp3mg3+hWA0Y17kFMBwHNjzHltYD3kbqiYzeKlztCKIJHL+2ATiw4Kwqh3VqSzUlVprCNxjUyhVPAEsJInf52dBn5uvNao3CHCTaWWbP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVSL4VprPSoyv5s5hy71MC21U0s05m63WIrVy/ZmoeY=;
 b=GnucAMzhl56nQHHKjeCj2vqgtwpDLeH1S+qIxjwRU9mv0PmfXpdnORTVP/BKuAbJrvyZdJAK2rqXO2rD2/ZSQrCgx7RnGZY2prS32EeivkNgBlxwBx/wKxeZx8Q2CwX+VDcI5JfANIioBoUMcHVzLhwm2ni4BsB3IC7mf7hoV/U=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BY5PR11MB4465.namprd11.prod.outlook.com (2603:10b6:a03:1c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 10:56:46 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 10:56:46 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <herve.codina@bootlin.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Horatiu.Vultur@microchip.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 3/3] ARM: dts: lan966x: Add UDPHS support
Thread-Topic: [PATCH v4 3/3] ARM: dts: lan966x: Add UDPHS support
Thread-Index: AQHYjTlBIEn+M1GMrUWYK6sRmh+9Zg==
Date:   Fri, 1 Jul 2022 10:56:46 +0000
Message-ID: <72a1e572-45d7-de18-8f1f-9035d75b562b@microchip.com>
References: <20220701070928.459135-1-herve.codina@bootlin.com>
 <20220701070928.459135-4-herve.codina@bootlin.com>
In-Reply-To: <20220701070928.459135-4-herve.codina@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 958ca9eb-5176-43ed-71ed-08da5b506448
x-ms-traffictypediagnostic: BY5PR11MB4465:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C6/djqbwlRI2UNstqHJQm7lnPOlKxtY9zh95c9hOWGHMYb8aRoqjjqpYr72PlemazyO3HdoO/J1FtGLOVljgmL3nYs8J5iyw2iUbivwkLce+qSh20MDRmPHv2XN3z+dLC3b1lOZargOgcPOoixXv35hkIS5DuX/AQMM254+oWY06uUgWLm6gptS+WEpSEoZgYg9JAJ5PIBU7XzM67j74cdJnr/OKpUYVqdJjEwUz6SZ6AnpbdZ8uAATe+mTcSpRqkuq5VkvK70pz4Dr3AHMuy+qYxGiEb4cD0F0cb2Pq2AqXa6LDfzLk1WV8EFItFQl2XSEwn3HfRhEXEC3W57CF2m7JDhdXJ1gLSbPMhIXmMCuknzXvDGm75zreq58vBbslbIyIZ/FVHCQCdfoCy65Eie/cfbP7lTuWtv1/tqSS+yLbxEKbvXCY5e4bQ6kMeK55U9e/p8p93KHZv2qL133juO/pahtjViwfhW3IdCYrpMi26dSRcLFFNpd4f94N0cUb1bNpnWwzwj5YKl+eNPnnzTiR5au4SbarEo6RN+lmGDRa6l5GroeSWFP3ceruZS0xlB1CxIRYz9YIzWQOwJTAxTyt1VZ9D8LpzaKp6eiOtEvV2T2qWpqqRzTGOdXR08JMVzvqlzQEzl98ffZdfTM4jd9mlDCIlV14D2UbHezXMxk6JW8gBweLXCVEGjuHhDdExVt840yVY4/3uVcQMPNmKz6x/CeZ+2lCZbcr//gdolJb+NrbdC69Qh/rc8So0UQLLfeh8vTqmLwStjQS0RTl2iLhCTMzgUzU9sRAnN4cPoDK3VxBlAuXIRVhsZC21qF3onx9bKtDYwR5Kk5SRoJc04PKl9/ftAGqcJFGbewQ7roCarjq9z8iC+StuaVClmnT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(346002)(39860400002)(366004)(53546011)(186003)(6506007)(6512007)(26005)(71200400001)(2616005)(86362001)(31696002)(41300700001)(38100700002)(38070700005)(122000001)(2906002)(66476007)(66446008)(76116006)(66556008)(64756008)(4326008)(66946007)(36756003)(7416002)(478600001)(8676002)(8936002)(5660300002)(91956017)(54906003)(6486002)(83380400001)(316002)(6636002)(110136005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVY3VHhyWUFxbnVUaSszL2RQVDlsdkluWUZ4dG9SSVNlS2ZScS9ROXV3MUZV?=
 =?utf-8?B?K0tydXFuOS91N0JxTjdwWExzNDBxY2hyV2d4SXpGSWt5VFZYcDE2bTNjZkE0?=
 =?utf-8?B?aHNZQk1EMGJFVkExZ3EwTDVsQ2o1amRPVHhhRlpBZEtJM2N2V1ErU1JseTFS?=
 =?utf-8?B?Nk01S1BFSTUyZWVhTEVYdUpIR1lRSERhUDc2eEJrc0JhclNib290eEIxV0hq?=
 =?utf-8?B?Z3JVc2NyNlpMTkZKTDljSXBVYjFRb0luaDFwTlhpNVJ6RU45N2hRZ0Y3dmJv?=
 =?utf-8?B?WFk2MmMzZzRhZVEyQ3lEMG1PY2hlajNUYm1CTDJadU8xSUY2dlpERTV4bjFn?=
 =?utf-8?B?QjliaXBnNzdlYmZIT3orUGRhMEExWFlmcTE2VWI4U2dtMnZFMFZaSTVNNllR?=
 =?utf-8?B?VUdMV0cyVHNtYWU3Zk1WSHhXYkc3ME1RK2dYTkVYemNuanZZZHVqSG16UVFL?=
 =?utf-8?B?WE1vSU05cm1WaWZtOHF5QXpYUm44RG95a1dqRnRzTDhTbW5xLzgveFhKQVlQ?=
 =?utf-8?B?Y0hkSkpzN2h3THNpZUlUOXNMK3p3K0l5c29WWmJVY0gyd1pqTHFwMW81NzVw?=
 =?utf-8?B?MVI0TGNjeWVhY2RqanlDeEhqWUhScTFaSEF0Q1ZmTUt4WnRoY25jZUZoU0VU?=
 =?utf-8?B?VGtIdUw0cGJjY1VsODZnWUpYeXRpNmd3L2VZd21oN1p3U2JqTlBKbStDVkE4?=
 =?utf-8?B?bUFPTzJ3Vm5wQlJ5YjBNVzl3dFdVRlAxeVhpelJxMHFsSTNzYUEzalU1OFFy?=
 =?utf-8?B?QXFVMjRWZjNvS2ZKQk9JYkFCTzQvbFF5dFg3RC9jbXk4c2M2cHY2Q2xJV2VO?=
 =?utf-8?B?NU9UTSsrNnpZaXE4c2dBZ0JPbVdjZVAwOVh3OFVwN1dEMnBkbmJvc1MvbW5D?=
 =?utf-8?B?ekdjUWZBMzNmOURmUGVXcTByZzdOVGFjZHhha21RSGdsTFA1cE1oL0FINEtR?=
 =?utf-8?B?Mi9WTXFhT2hRYWk1d0h4TFhGVk5uS0RzL2VqdENmRFAyazlJVXYwQXUrMFly?=
 =?utf-8?B?NWV6VVJXZTAyb3pvUnREZFRxSUxveGRpZWhZU0V5M3RBRFFDcC9OTXQzTzhr?=
 =?utf-8?B?V0grcFBZU1c3OXdaenJHNjBBbzlVNUlsaXpveHl0YkU0c0dDNkFna3htWFM2?=
 =?utf-8?B?anZ5QkZESnJOVEEvclRXSWQrQi9QaFFXdXg3SW1CRTVWU3luMHZVZldTVmpJ?=
 =?utf-8?B?VGpCU0VWNTZzQjVUckRnOXhiK0Y5bk5CTll6ejBqaW5mWjluRVRJdFFHYzdq?=
 =?utf-8?B?aUZHR0hXSDBhVlpMU1VLRWt5S3FCZkxUbURuT0dINVlJK3VyZStKRlRXeFY2?=
 =?utf-8?B?VkFZUkNzUDQ1Yzk5bjk1b0RJdkp5M0tTTS9KbzdVMXduNkREbUtwdnJQNjND?=
 =?utf-8?B?dUtjcjlnajVWVUJUYVFEQVVwQm9qUXpuVytMRnJLUmFWRGZtYTVtR2FtRFVj?=
 =?utf-8?B?VGYxbWs2WHZ4ZkJPeEI5bEc0bzBlSjBxbUtrTDBuZmxILzhhNXRWM25IUkJZ?=
 =?utf-8?B?d2lscENDYmNXQy9UeE9OSXNhV1d6Y2ZXTVFvVmFxdlJwWG14SE4yZlBQMHJa?=
 =?utf-8?B?dElVUFhxNFFGM1ErNkJqUFp6c1pzTEg1am1rTys3QTNKbmZkaG0razBDdENU?=
 =?utf-8?B?QzdGcHJLY09oVllGNFBKaFhDYkN1bGN3b1BreHZrUisvM1lsTCtEcFlwdTFv?=
 =?utf-8?B?NDEwSWtRbGFjdE5tNEpKaURTb2k5ZDhUT3VIbEN1Qkk2VElHWndxbWZ5VU5t?=
 =?utf-8?B?L3IwVTYweGIwSmNUaTB3OUs5T3k2ZmQyejBFQnJzaFNwTHdKWHNoWDc3aHNS?=
 =?utf-8?B?Y2R5RU0ybTBoWGtrZldsZ2tJOS9QY3IwTVdUYllXY2todFpXYURHVHU0ZmJG?=
 =?utf-8?B?SU4xS29RT3NUaEdHRmd6SnZNVjR0MktXdk5rSTQwcStna2xJd0lZK3VWYzdv?=
 =?utf-8?B?dE83aU4wa1Avc1ZkSmdVV0h1bGNkLzJGVVh6ZWJFOVpDbWtVaHE0dEoxNnNt?=
 =?utf-8?B?aUc5N3pFQUhJK0ZnQ25MK0xYdUYwVm9VaXljaDlmbzFTaGp3NVlJTHFpdWw0?=
 =?utf-8?B?RCtsbkhmOUEvWGpkNk02UEtQUE1nREEzZVNDZlptYzlCR0MzOGs5dUFTaGd5?=
 =?utf-8?B?WnNSVWdUWS9PVGxuZm9iUVlqb3hCOXZpdnVvWk9UTUhVbUR5TkE2ZXpYRWgw?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFE642BD472AC542A9C893A8EF4B7C10@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958ca9eb-5176-43ed-71ed-08da5b506448
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 10:56:46.4014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMvtfXl0JDzah7ToT7CipAE6KDoeLtnVvZcwqBxzptXNJYuBk6xbHXw427bwCQMjH8LaDuIwVM+qsileurE0Y4NtDREdbNH79QNZKFVuZCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4465
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEuMDcuMjAyMiAxMDowOSwgSGVydmUgQ29kaW5hIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFkZCBVRFBIUyAodGhlIFVTQiBIaWdoIFNwZWVk
IERldmljZSBQb3J0IGNvbnRyb2xsZXIpIHN1cHBvcnQuDQo+IA0KPiBUaGUgYm90aCBsYW45NjZ4
IFNPQ3MgKExBTjk2NjIgYW5kIExBTjk2NjgpIGhhdmUgdGhlIHNhbWUgVURQSFMNCj4gSVAuIFRo
aXMgSVAgaXMgYWxzbyB0aGUgc2FtZSBhcyB0aGUgb25lIHByZXNlbnQgaW4gdGhlIFNBTUE1RDMN
Cj4gU09DLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGVydmUgQ29kaW5hIDxoZXJ2ZS5jb2RpbmFA
Ym9vdGxpbi5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpIHwg
MTEgKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+IGluZGV4IDNjYjAyZmZmZTcxNi4uYzk4ZTcwNzVjMmI0
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kNCj4gKysrIGIv
YXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+IEBAIC00NTgsNiArNDU4LDE3IEBAIGNw
dV9jdHJsOiBzeXNjb25AZTAwYzAwMDAgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZWcg
PSA8MHhlMDBjMDAwMCAweDM1MD47DQo+ICAgICAgICAgICAgICAgICB9Ow0KPiANCj4gKyAgICAg
ICAgICAgICAgIHVkYzogdXNiQGUwODA4MDAwIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
Y29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuOTY2Mi11ZGMiLA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgImF0bWVsLHNhbWE1ZDMtdWRjIjsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcmVnID0gPDB4MDAyMDAwMDAgMHg4MDAwMD4sDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDwweGUwODA4MDAwIDB4NDAwPjsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDc2IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmNsa3MgR0NLX0dBVEVfVURQSFM+LCA8
Jm5pY19jbGs+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICBjbG9jay1uYW1lcyA9ICJwY2xr
IiwgImhjbGsiOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQi
Ow0KPiArICAgICAgICAgICAgICAgfTsNCj4gKw0KDQpJIGhhdmUgdGhlc2UgY29tcGlsYXRpb24g
d2FybmluZ3M6DQoNCiAgRFRDICAgICBhcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgyOTEu
ZHRiDQphcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2k6NDYxLjIxLTQ3MC41OiBXYXJuaW5n
IChzaW1wbGVfYnVzX3JlZyk6DQovc29jL3VzYkBlMDgwODAwMDogc2ltcGxlLWJ1cyB1bml0IGFk
ZHJlc3MgZm9ybWF0IGVycm9yLCBleHBlY3RlZCAiMjAwMDAwIg0KICBEVEMgICAgIGFyY2gvYXJt
L2Jvb3QvZHRzL2xhbjk2Nngta29udHJvbi1rc3dpdGNoLWQxMC1tbXQtNmctMmdzLmR0Yg0KYXJj
aC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpOjQ2MS4yMS00NzAuNTogV2FybmluZyAoc2ltcGxl
X2J1c19yZWcpOg0KL3NvYy91c2JAZTA4MDgwMDA6IHNpbXBsZS1idXMgdW5pdCBhZGRyZXNzIGZv
cm1hdCBlcnJvciwgZXhwZWN0ZWQgIjIwMDAwMCINCiAgRFRDICAgICBhcmNoL2FybS9ib290L2R0
cy9sYW45NjZ4LWtvbnRyb24ta3N3aXRjaC1kMTAtbW10LThnLmR0Yg0KYXJjaC9hcm0vYm9vdC9k
dHMvbGFuOTY2eC5kdHNpOjQ2MS4yMS00NzAuNTogV2FybmluZyAoc2ltcGxlX2J1c19yZWcpOg0K
L3NvYy91c2JAZTA4MDgwMDA6IHNpbXBsZS1idXMgdW5pdCBhZGRyZXNzIGZvcm1hdCBlcnJvciwg
ZXhwZWN0ZWQgIjIwMDAwMCINCg0KPiAgICAgICAgICAgICAgICAgY2FuMDogY2FuQGUwODFjMDAw
IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJib3NjaCxtX2NhbiI7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweGUwODFjMDAwIDB4ZmM+LCA8MHgw
MDEwMDAwMCAweDQwMDA+Ow0KPiAtLQ0KPiAyLjM1LjMNCj4gDQoNCg==
