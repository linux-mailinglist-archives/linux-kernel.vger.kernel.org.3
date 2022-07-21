Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B15157C986
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiGULGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbiGULGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:06:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4F313CD1;
        Thu, 21 Jul 2022 04:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658401561; x=1689937561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LbweySjnuigB0Bt43M9GVa+M4Rc/hzMLW9X+h7nmzc0=;
  b=m73s6K0bsXBV31wcrsqGVSm06UtqsC2IvaWLehNRaxEG0C4tUGRr0A4i
   riq8UQV280UYdSafb3TuR4FShEbwG92XWWmq8TSSNT119xD4/GFqqK0ee
   ITfBkxosDDAeiobVhhjhWgHp2cAiLl8+JcLJzR/iCYXhzwEGhl0aStMl1
   Cbn0jBu+0VB4hd9MKL9y3P5fLlqsCrJHQERa+WT+vZINsUsl5I96OfZIk
   ipYWzrQe4484LzZLNq7sHR6wWdkCM3jepnoYRjOzc7BpTMNkA3YQA7UpH
   5fZ4PV/+/O3TqCFB90MPuFBIWA6GB3T0E0jAfkXtq9xmy1g+7NxmU6AeZ
   w==;
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="183151154"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jul 2022 04:06:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 21 Jul 2022 04:06:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 21 Jul 2022 04:06:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS/fG5omRkpxO99AKpLL3IuJ2WqS+oGUDC7XxG61o36W59fF0fHCoy80MHqfEgmKdTYAkhoy5kCmBmISchFD9rbhovT77xLW8ImUUNXpoMybFsNZM6uVxR46n1I4dvBMHi+nDVM9N+RtQbgMaVbAn+sUugioSw7BZNPrZFDacBHS2hF31GmBmjPE5Q+5PBeHemdCNzdFBDRzmjSfgyl0pfrENBp7fYjxVPs4hHm1gU2lLmZhqLJLeR7Sm02hiiSfgPAe7FxZrmcmsNZ4NIb6wuuksc/LYIOvzwy8A2lXKtaooe9yp225nCCAsUHliFzeDzPqSxnfJ8h8ES1eEGFbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbweySjnuigB0Bt43M9GVa+M4Rc/hzMLW9X+h7nmzc0=;
 b=ijcKizBV9KG+8qejZZCdUv8vpLSH2PG0AaTDbMiwvUF0zmDiczC68xH8EqjOrxJgNZVzYJUkfkTqJaKMZhZwxOGbrRvMM3XgcVjkVMoAi32XniSGtRsScsIHbiKeq7hUjC9xHnHjTjT5bM0U2rHgwdCjnwjIKZqL6KqlHnIKojnwxHNVnUDdALQ1J76eMh/XaMMY+CPWgXh4BDCCin57rS07GEAhvL23shgVoJkYMjhEsyK6J5aehMQiFL+Yl8iw4s/vWaidxEQyK+8xNmLGcZu0giICH1nop4L2083JS8LJmk4M6eMvb3StsWOQjYiYHSX8fIhIa2EbLOrJ/2lvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbweySjnuigB0Bt43M9GVa+M4Rc/hzMLW9X+h7nmzc0=;
 b=FGSOQr3+bDjh7OwW/ZpQUCI1mobHrVmr9lBLSqMBQahw/U5XW/NWqie7SItqidvds5iKCclak9ctqJltcE5lqJEjnSQMcDUdAijniCzX0iXCd4z/FUR9TCM3I6WjcmqDpm2P+YVgHqNUgzq3bsmXfxGxDRz0/7tN5I56GDdzvxg=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1467.namprd11.prod.outlook.com (2603:10b6:4:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.20; Thu, 21 Jul 2022 11:05:54 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%7]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 11:05:54 +0000
From:   <Conor.Dooley@microchip.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <Daire.McNamara@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v6 3/4] pwm: add microchip soft ip corePWM driver
Thread-Topic: [PATCH v6 3/4] pwm: add microchip soft ip corePWM driver
Thread-Index: AQHYlftutkb03ZS7CE62xip0d2IE2a18AH4AgAy3VYA=
Date:   Thu, 21 Jul 2022 11:05:54 +0000
Message-ID: <ee05749f-c33f-3505-4309-f4d036de92a1@microchip.com>
References: <20220712142557.1773075-1-conor.dooley@microchip.com>
 <20220712142557.1773075-4-conor.dooley@microchip.com>
 <c49776c2-4807-91c1-010a-a33bd98b68b7@microchip.com>
In-Reply-To: <c49776c2-4807-91c1-010a-a33bd98b68b7@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5315ca32-fdd5-432b-c39c-08da6b08fb45
x-ms-traffictypediagnostic: DM5PR11MB1467:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vK3gZWBXhzSCTdufaE/IHB2NcNraKlzqAlAxqOppsqTsA7lyEQsKXXJU+Brmx3Teq6tKypRBCFR7JQuhjBFM6kHTWWv0us0leRmi4Gpr1fmcsYbUvvMxWVlPAjeMwrCkbtaIKwxH9nq5DHo5kirYL0zNuhj3QM3Mqy4zALFtOcUQjGaG5WQ4qgvQvocvEtQrKdmSJqMFSYSSYG8kveYEXSPegyRQSJfHTcjj2vWXbgZX5fikGGk0GIhNfPctl9OgWjMLbV3TqUOrBq+271GZ3gx8DICiWnDbM8GkwRb97iQ7swIX0wcyRkIiKmHjHoZf87MZsG0AtZ9ALIn1VJZ4nokDhdARTpLw6eDpr5S7otwXymWtbSzIir4t3IgV5C4m2K6PZNMM/U2iDDJhPpwhk62moUOOJ3cuIwjJrZo4veRWLn2OTC3Tg1PdAqOTY+huHIRd+t9KMCzmptp6/rwnEZq8MNZru1PmRQ3q8ZervP+lIuduuyJFp1ykXXGpOGNGLe6scLvPsQmkBuzXl5xWxeCSGcBpRQCh8IuzuuT6blx942jbIXm0PA30qCsHgeLRRM+O970kuif3QwcPS6bpuBjtzpLy5+Te5O8uWb+u7lGd9EU7diAldILw4FcVki9hkNN60OAh6F1ikRwFgkaTj0EPhTbcxTdjWadL+HGBrc/41LqALVUiGsfPRTGZyBq7vEV5EQ/XGcXZT0KEVveWBrKLAoe7qUpuNFYrwxsODRR9B62pxLo5MKwBtOcqNBsTpcIrxFBHqGjiO+6qlfr/dPMXpZfxsnrs7oD/AN/cdtOAX0dbWLWDff6dFelMvA9rSL5uWIxUk3n4GzAbAguKmoOR/6HkM+3MCtwKQXv8Qns=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(136003)(39860400002)(396003)(376002)(91956017)(4744005)(38070700005)(53546011)(2616005)(76116006)(4326008)(54906003)(478600001)(110136005)(41300700001)(2906002)(316002)(6506007)(26005)(6512007)(64756008)(8676002)(6486002)(66946007)(71200400001)(66476007)(86362001)(5660300002)(36756003)(83380400001)(66446008)(31696002)(31686004)(38100700002)(186003)(66556008)(8936002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2YxMWRka0kzT1NBS2tIU3R4ZW1nZjRsT2VBbmVPc3p1TWxQZmRxcFNGcEpD?=
 =?utf-8?B?OWhLamUyblE0bGdiRnUvc3dRTmFkd3VPYU84ellQTEJmMDRCOUp1Q1hXNGJ1?=
 =?utf-8?B?M0wxVnIzYzE1aS9qdDhCMmRkL043OWRDRlo5Q3JPbjE4Rk0wbng2aGpPNUxp?=
 =?utf-8?B?UU9WRnh0MGt6WCtMbjdRclM0VDlqZ3dwdHNoQ3VjY20xanJtZXVNcmFlMnRQ?=
 =?utf-8?B?cURISzIrZkh0NmZLOEtBejI2ZVlWa2VvY2crUFlKQUFQVlZlM3hqbUg4c0ZI?=
 =?utf-8?B?N3ZGbk5zUjVvdDZkckNFZ3dsS0ZJMXU2MWtqTmtneUY5RXdNbDJBdkkycmlU?=
 =?utf-8?B?Vzdha0F1TzJHU3hhZ3FCbHlGd3I4Z2FaVmZoMWM4NnUrUVFvbnhIb1hLd1Vp?=
 =?utf-8?B?Y09BZlZ4aUxBV20rc2lMT3dYMG4xcXByV0tqUlRDZHY3L2Z0aDFRaVVoM3lv?=
 =?utf-8?B?RU9SUUZYMVk4VHJEM3AyZ0VhMGJwMFZkOUhqMThlaWlkTXd3YzRQNXk5Q2pz?=
 =?utf-8?B?Q0ZPVDEvK0RJOWNKRm9qa2RzL2xBeEZRVjlhUFdaTnNwYWx6U1lRKzdkVFJi?=
 =?utf-8?B?OTcyMkY0QlZRSmhENnNHSDVYQXFuNEN5eU9KVHFhZ280dUVjVGt6SVAxc0pP?=
 =?utf-8?B?TzIxUGd1Y2ZJNy9nRFMxZ3IwZldFaGNlN004Q2FSQUZsT0VjRTltT0xvMzhq?=
 =?utf-8?B?VldrL0U3RFh2czJGYVlJMUtuUUFpMWw0b2tJOFVHeWFWUUFnWkh1RTNnUHdU?=
 =?utf-8?B?ZXpEZ3ZmOFlzbXlCQzFWMVQweVhoRmZSRFh0dzJRZWpPU2FsV2xEOVNOOTRt?=
 =?utf-8?B?amJGenNveUtVQTIrb2dPY2dkaVpBUHVEVUYrT3BSNS9XamQrWkhuNmpKMFpl?=
 =?utf-8?B?SC9TSW8zN3RMeVpXWE5lc0lEUi9RcFhqdmRIanRjVVM1WHNDM0ZucWRSN29Y?=
 =?utf-8?B?SGJSby93bXlyd0V1cjdHUy85MFYxV0tNMXc2UjY4VUZGbTdxS1VESXk3ZEZP?=
 =?utf-8?B?cnpwWEN2WEZ2LzBLOXRGSVZucVlTOVQ2akU5Z1loRXRLRWtOVXMrN0dkUlk3?=
 =?utf-8?B?TlRpeE4rUmtZQmgwRHNaWEN0Sk1vL09ZcFpyWnpHTHNvalZCTnRBb2hOWVYv?=
 =?utf-8?B?VUNRaGU2eDhqY1BnZmJqTnVrRkVkdzF3WTJ0MzZmazEwUnhrQ1o5V2YzaEF2?=
 =?utf-8?B?QWJtcU5ybFpwVUFNWGRRR0k2T2FiRlJEaGN6Q3g3K1pOZXRUVVExRWpXR1gz?=
 =?utf-8?B?SGYxUmlmKzNxenFtTXJiaU9TaG11M1VMNVM1RDNEVmZ1R0V2RkpNNmhVU3pR?=
 =?utf-8?B?NG1zODNUbkxsV1lKRUoxRm1KU255c1AwS096ZnlXRW5Oc1VSOUNYMXpqTE90?=
 =?utf-8?B?YUtTZWdrcytRVWE3bnp1VG1XOFE1K3pZbUc5dTJ1S0dQZE9ETmhNUGVzb3Y5?=
 =?utf-8?B?amZkNzN1eWVFSmRTSVUrOS9JNGttYkhlT3cvYlErellqTEV6eGpZd09hSTFQ?=
 =?utf-8?B?eTFaSGt6bWNYbDdkVEhYVTBjRTF0YkMrcWRjWUpPcUJSR2RqcTdkU0JXeFgv?=
 =?utf-8?B?OXJOMnpwMmxra21xSitWRWtPaUtXK2NPWlN0UWZtT3R0QTNrUDNZTUd0WUR6?=
 =?utf-8?B?VnNGWmhvcnpvSE5DdVE1Ujl1c0VyOXFTY1lveEVEV3lKNjdOMWJYRzdZeW5x?=
 =?utf-8?B?bzJuK3VSYXlZSXBjQzJQN0d6dzcvRnd3R2lCNzQ3Nk9pRS9sVkxqTk0wenpk?=
 =?utf-8?B?M2hDdXFTdTg2eXVmWTRoLzRPTGdtNmZmd1VsTm5hckdzblltazR4T3h2VEVj?=
 =?utf-8?B?NkhPRUQ3SkNYa2JGblJjT29YYldtSXZmd3BoN0RuN21EOW14MUVsYXR6ck0v?=
 =?utf-8?B?RCtlMVVoZUI4QzBMN2ZvOWFjZktmVndrZUhtR3h2SWV2emRiSXZRNWpGY2ZB?=
 =?utf-8?B?enlOcmtvanlsY3RIejlRYXNjSG44ckR3SGQzRWtsNjM3cUt5NXorelJlY2dZ?=
 =?utf-8?B?RkFCNlBWQlJQd2ROVitiRU9pN0xEMFE5S0RNSzY2WjYwMnQwakQwcEFvZmZM?=
 =?utf-8?B?MG9wL0JLNmZhSDUyL29pTTQ5cnRnN2RRWFhzWlR6bGhxN1RHNktpQ04rbXdl?=
 =?utf-8?Q?jxTAzI7gyU4d45BsGvR1ImEj5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C4FC3583BB6E245BDB1A1618611F5C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5315ca32-fdd5-432b-c39c-08da6b08fb45
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 11:05:54.5284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYMTvNNwnmkythaBp9Lexr8yOkonGpm1BJZShOp8BlBBhz8VIsFDZIC6KfmckWPpQldYnIoGnbmo6in5RV6o9PJ3Mlxz15tbN1GvWsNYqD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1467
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMvMDcvMjAyMiAwOTo1NCwgQ29ub3IgRG9vbGV5IC0gTTUyNjkxIHdyb3RlOg0KPiBPbiAx
Mi8wNy8yMDIyIDE1OjI1LCBDb25vciBEb29sZXkgd3JvdGU6DQo+PiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4+DQo+PiBBZGQgYSBkcml2ZXIgdGhhdCBzdXBwb3J0cyB0aGUg
TWljcm9jaGlwIEZQR0EgInNvZnQiIFBXTSBJUCBjb3JlLg0KPiANCj4gTG9va3MgbGlrZSB0aGVy
ZSdzIGEgY291cGxlIFc9MSB3YXJuaW5ncyBhYm91dCB0aGUgbXV0ZXggdXNlLCBJJ2xsIG5vdCBy
ZXNwaW4NCj4gdW50aWwgeW91J3ZlIGhhZCBhIGNoYW5jZSB0byBoYXZlIGEgbG9vayBhdCB0aGlz
IHZlcnNpb24uDQo+IFRoYW5rcywNCj4gQ29ub3IuDQoNCkhleSBVd2UsDQoNClNob3VsZCBJIHJl
c3VibWl0IG5vdyB3aXRoIHRoZSB3YXJuaW5ncyBmaXhlZD8NCkl0IGlzIGEgcGFpciBvZiB1bnVz
ZWQtcmVzdWx0IG9uIHRoZSBtdXRleGVzICYgYSB1bnVzZWQtdmFyaWFibGUgc28NCnRoZXkgc2hv
dWxkIG5vdCBoYXZlIG11Y2ggb2YgYW4gaW1wYWN0IG9uIGFueSByZXZpZXcgeW91IHdvdWxkIGdp
dmUNCmZvciB0aGlzIHZlcnNpb24uDQoNClRoYW5rcywNCkNvbm9yLg0KDQo=
