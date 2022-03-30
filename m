Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6C94EC596
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345978AbiC3N2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244947AbiC3N1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:27:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC687231907;
        Wed, 30 Mar 2022 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1648646767; x=1680182767;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o3ucxeYnzEqmQStj/FxpjZpdYDcYwEIJyOAFwTO+lt0=;
  b=M7Yonc7MZhqJyqkayJbS1wifYabED+rLbTgALFXlS6GulXPKKY6NfTDX
   hYJTOARyMMaC5Ki38wuMu5d1YBapmt9t7KbO5ud+TrixwcpojouEoYRYD
   eEW3HAO8UwshkopjXWSDuvBxKofaQiP9g/nZmyeR+TXmLbhyZCkD55dIa
   esRo60vdQBQQB2yg1MQvU9OAQpmk1PG74yxMLQwPPB04QAtlZ7ZkLy9vL
   0Ywady8h5aNiH211l8J7uaFYfQn4noIPvvnAamZH36Bbu5f/b+WMUstCM
   jvVmqHTFD3+tkU3ywPW5Vwi3ydkTMkeIkRZoPYuqdhdhlbXINPoy1eb/j
   w==;
X-IronPort-AV: E=Sophos;i="5.90,222,1643698800"; 
   d="scan'208";a="158233407"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Mar 2022 06:26:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 30 Mar 2022 06:26:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 30 Mar 2022 06:26:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKRBj3A545ebWRPwpw0DBokG5KvZOJsKr3ocDTYvAjYeSKXQhpWRCdTkESoYCGxF2jSBOk6IOkVXdQyQFNolM63jrYG1Lli6iSTfj6k5gm8segIoFsSrXbXG2pWmTCWat5UNcbflvhUojW9HaBMtqv0+EmT1Jmu97QYdj9OuGa5y+lmc4C/OXWUdUvuvfGgQyl/7QSWj6ShL8epmh+iw71c3ubBfmkjr/YNU7Ej89oPYm1TiM5OLE47prE8U3fiq1T49omxC6VKuPY8T282Sx64eA6vSRdIZO8E/VOOuLCDry63Puyg6nUQuHqM5uDH2pKqM0I+k+GOqW4t2vHiRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3ucxeYnzEqmQStj/FxpjZpdYDcYwEIJyOAFwTO+lt0=;
 b=AG3sanIrC21NxtSs1aGa1KQPpuPdWwCWNKfNmTutcWSBZRRWC3fbngyH8Q5FzhtWZjpQSXBupqANDx2feFsWD0OTqz/6mmB8hGKX+sWV7h7z9NI3mVsVc4pTesC5y8IGlNasSHHxs4MCx7A4Dw0rJvO9r8RzNeoFllP/b/PKTpHXTPwaIsEKOQWsFzGsHC3vbXkUNvPTnun891btimzG/w7en5MMdK4ZAetCHJtPh1o4nmAIVHKs6BPf04yVNu0YJjjsCbsYmRIcsoTeWCcXiV0njpTDCkIfBhUJqVcoZwqsZGkbxhnBxObNSzfIQy2/C1IYEvKeqUS5ncA38m3Elw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3ucxeYnzEqmQStj/FxpjZpdYDcYwEIJyOAFwTO+lt0=;
 b=TZX0mBBf6M+4vlHsbNUtBPAaovhuZVg01TGi55a6aoSWmZ+oRYzF5qYQeb9UmAzLkUNSJxiMrqmhuw5excN2tUn7kIS4KTQ+dkydgvn1unwuIPP4d+jTviPaGSpoqlSLWCqDsUF4paM/mjqpNJTMKG5FodLOnJGC0inI2r4HeyY=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by BN7PR11MB2531.namprd11.prod.outlook.com (2603:10b6:406:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Wed, 30 Mar
 2022 13:25:54 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%6]) with mapi id 15.20.5123.021; Wed, 30 Mar 2022
 13:25:54 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <Kavyasree.Kotagiri@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 4/7] ARM: dts: lan966x: add all flexcom usart nodes
Thread-Topic: [PATCH v2 4/7] ARM: dts: lan966x: add all flexcom usart nodes
Thread-Index: AQHYRDmuouA2jPMoIE2pYOPwjSnMeA==
Date:   Wed, 30 Mar 2022 13:25:54 +0000
Message-ID: <d78d3bde-cddb-6f0a-69ab-a51ded812f81@microchip.com>
References: <20220304153548.3364480-1-michael@walle.cc>
 <20220304153548.3364480-5-michael@walle.cc>
In-Reply-To: <20220304153548.3364480-5-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c964233-fb15-4344-b0eb-08da1250d12e
x-ms-traffictypediagnostic: BN7PR11MB2531:EE_
x-microsoft-antispam-prvs: <BN7PR11MB2531ADC2C803FD52D1B7D829871F9@BN7PR11MB2531.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tzZEOO00DURCdOh6oWoz2Vy5ODNA4AiqARAsND7wxjRy1Ih3cZR3zgwZ98Jl5KXXn4tjUC+FOgF/cGf/h3ls1aLoMahtNAG38gf2vkC8n9zhrI4V1r6O1VIgbh/oodMwm8x1KHbQ+b+YPhR1Wic0RzfU6lidpk+2OR5DGFjjMsaRbqUti+iNgIc+M+I2sSkJ5wiWoZyEQ9cY5SSBxhDGAcUDQ3u7J5cqINbgNXuuqDMy8JEfDMqtT7n0gwnD2GpJpZdVf0etFenvVlJ8VmmA+XRp23vKcpQop/+IOtfnc8fPMgIUVwx8awb891nX+M6N6AJ/6jPjIzwqgvGEzEOa4UhbSYy35G3Mg9XlJlo4ONwtz9MkNK9vfE9K6BjrB/ftiKDAIOKGEq8pEkRiocAkwP/Y54D6UenKpduxYuIDkR2EUDg/nyz2Ka+RfpXP9YmdM74wHb0ZtyGkdfuqfU0QyYLm084PlcO6NhrTBWt6X520ViYoY9kxQYkHid56SGOY0YMumkW6v/tF2BqgRGDrf5MTHm0H+a34dTUXCOPGJtpsr6HZB6uWqfWeZglyLpbkxoh6J2oFKs9IFIt9RZWkLOpdEC0jo2ovlA1mCAYfCq0VTtRuSG0crc9YqtP7zjawwHgEIBTBjfSZMquxMFc0Wa1P+Vjdznc36SjfL9U3x4YJrqnUodOPzc39gnHbgECf37E2UAOseg8xURt2uYoPf89ByyDcZ/kRGpMQFi882ZLhN0PJ8gmlLSpdSZMZGthOTXc3ZRhYlit5uU2rhjglrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(5660300002)(71200400001)(38100700002)(6486002)(8936002)(122000001)(186003)(110136005)(83380400001)(38070700005)(26005)(54906003)(508600001)(86362001)(31686004)(53546011)(2906002)(76116006)(6636002)(91956017)(31696002)(316002)(66446008)(36756003)(66946007)(66556008)(64756008)(66476007)(8676002)(2616005)(6512007)(4326008)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGdhYWtPaG1qUDJOZDZxSmhkM2I5K2cycWJjWFU0WEFvZGtidDlmbEdDWTdN?=
 =?utf-8?B?cUJTRG1PajYrcmZxU05mSDRwMHdFL1NreHZVbzg5YmdTd254MnFKbEhJUXBN?=
 =?utf-8?B?Y203NEJWeDVkNWlWbElCTjlFZEVKRkEzc3ZuTGx1WnVSblNNZ09jbUR3V2VG?=
 =?utf-8?B?aWZZTkNHRXVZQkE0dnN3Q2pHZkVGelQ0czVVN2RzWjJKSlNySGEzaEZNdTNo?=
 =?utf-8?B?S2xqcE9vKzZHTVBuTzAzamtTVVljQWtvY2xNV0p6VGZSdFVZMXBRa0tVWGRv?=
 =?utf-8?B?VlFFUHI2VjkzQmtHbWl4S2hod0l5L1lLWXZhYW4rd1czNkNVZ3pZWmo1K1BV?=
 =?utf-8?B?N29Vc2dISEh6Z3RNS1kzcHc0QWwxL3hIalVnL0lDVGVaaGNOREdpZ3pab3BI?=
 =?utf-8?B?MjZFT0FDT0pHbGZGU3FqTm5ZeVQ4ZGZEVDNMYzB6cjcvU0FCcTRtcDd3ZGlJ?=
 =?utf-8?B?Z2ttQ1M3LzZCVTZHNy9GN3EzOXdLMER0MEl6YTErbTRjanN1MVpaenRnZFBq?=
 =?utf-8?B?QjJ5WVJTMWE1RldmMk1VU1hJdkkreXE4ZXloa3VsYmNQUUd3OC9MaDl2NWx6?=
 =?utf-8?B?bXdFR1h4dWx6ajhDc0poOE1kbldGekdFOTFEVnBVenJCOElKRW5vYTFMTEFP?=
 =?utf-8?B?WUFURmZWbXgxQzZXOWxNcDZBSVA5bkVpb1hEOU9aVEE3ZXc5clYxdWYyV0JD?=
 =?utf-8?B?NzZKNCtnVWZwcE5acUdEa0xzSWtYbmpiUUw5elVDcUEwSnplSTlheEJPTFhF?=
 =?utf-8?B?YWt3OWV5eWxXOGRodThLbCtyNzl3cGtndG8ydzBEbWs5dnJDOVljN2hWcTN1?=
 =?utf-8?B?RjRMRmZZbUEwOGRWQ250ZUZLT2tBcThqREt6V1haSVp6bUppTFRXNmFvNFNh?=
 =?utf-8?B?TXNVZ2RWWmc1Z3RXMnR2dHpCNFQwRDBtWFlZL3E5bFl1TVNGVTM4VVlMbGV5?=
 =?utf-8?B?MXJkeE5GVmo4RlZLR0p3UHlPT1dNWXpiSXJnZFZwQWFlTTJvUjVzeFZWeUNy?=
 =?utf-8?B?VHU3RGlGZmFPQWRkN3UxWHFGb0RYSmlURWxISzEwMUlCZm5wTzNDcTZXWU0x?=
 =?utf-8?B?N09LSGs3YlNsaDJxY2piR2JacFFNSXlXb1BRTnlFQ3Bid1dRK00vbHpaVzZ1?=
 =?utf-8?B?RnZTVEw4bnVraEhYNWZzcDNhdGlFcWNlT3kvUkVLeGM5UEE3aGVQQzhQZ0pr?=
 =?utf-8?B?bllmVm9TZjk2VkpQcHJTL2l0SHkzMXJVUFpRU0txNlorWFNITFhjWm5NZEpH?=
 =?utf-8?B?Z0JNVTlGdHNFTUxJNWRNTnZjZTVsNFpqQ0VmeWlNcXlvV1ZMVjNmdFlDazQ3?=
 =?utf-8?B?bzQwd2hHOC9GWkUySVFtRTVpY05tbnhWNFQxdE5xelEzWHE3SzBoRmRSRS9w?=
 =?utf-8?B?a3IzcWNrSVk1Nmg0RFZtRW1FYStsQWdIMHRWWmdkcE1aR0tYb2ZFdkRVS0U2?=
 =?utf-8?B?d1laOW9qUDFONVNnWEtIT1BXMUNGbWtmWDVqTzlVcUJuV0ZISUxtWE1DblNj?=
 =?utf-8?B?S21kL0YxTDhVQ21xdnYrWUUxaUFnNldUV0Vnb3ZUWkJvT21vZGJrQkN4TzB2?=
 =?utf-8?B?TVhNbGZvS3N3bU5ZajJnbEdQalVUQ3U0MlFzWUI1ZVlwUUxyaWQ5UkkxQy9F?=
 =?utf-8?B?bklNc2pQVkVEU1YxMjQwSDVjWDJFdmc2LzFjYko1U0kwVmhLSXM1Vnh4WkdG?=
 =?utf-8?B?bmhsbHFJSVlSZjVKSHZQLzR3SVo1dE1CQ05aZDZET2d0TDljYXlZbUJ2dnRF?=
 =?utf-8?B?OTgydVJrdExRRW9uWUFMdlFBN0FmTVM4WXFOeHJxMTFBNTVSVVhETENEY2dN?=
 =?utf-8?B?QkFzYmRtQS9vTDlFSjA2c05MRjhpZnVMNmdURWJUK0JoYW9CaXlXYlNqV3Zi?=
 =?utf-8?B?K0hUY0F4SG1jakZMMFRRY3ZpOW80dHlwWVZrVE9KUnRJZGpjYXhGVmRNelZu?=
 =?utf-8?B?OGY1cVlRaGhXTTEyQVBPOGNDUjF0MmMvcEJsQU5FV000NXo3THFCMXgzU1dO?=
 =?utf-8?B?K1FTeWE5NTRXUFBsOUhUTWwzS0dVcTZzTnlhK0NuWFFxRkF5RDJiVm8wL1M2?=
 =?utf-8?B?RGdVdUQwYmNMaFBsdFVvakFQdE5pTS9CY0tRN3dTbUZxL3Zwbzg5aXBvZXcw?=
 =?utf-8?B?QmRxYkR3SzdhelY0UnJCWFN4NWZNbjFuSjZ5V3pXMWZGaG9EeWgrYklqcnBE?=
 =?utf-8?B?TllWanJwSTgxVmQyckp2WDlhbGV5V09TdXdPbkxmN3V2Qm53RFE2N1pKVUVE?=
 =?utf-8?B?ZmVBeDZPZStrdHQ4Z3RwVWRuRUI5dVRaZTh6cmM1eUh4dHliY3R5QnRnWUR6?=
 =?utf-8?B?b0RCYnFEa0s3Y3JkUHRNc1FRWCtsRk50ME9nblJqWEtQM09CM3prcHdHMEpL?=
 =?utf-8?Q?KfagC2jo0ZJNBTq4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9399140FC418CC4EA0984BB5075A44C9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c964233-fb15-4344-b0eb-08da1250d12e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 13:25:54.1434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: blm28F3EI9sKAtp342c/aMZBMDuasEt5iaKUpVEEjSbGz8mISpiQkb9L5vxCCQQEvYRiNIlncp6DS+UPVpYaEiIQN9t4uE3H63Bq/tMCdiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2531
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDMuMjAyMiAxNzozNSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgYWxsIHRoZSByZW1haW5pbmcgdXNhcnQg
bm9kZXMgZm9yIHRoZSBmbGV4Y29tIGJsb2NrLiBBbHRob3VnaCB0aGUNCj4gRE1BIGNoYW5uZWxz
IGFyZSBzcGVjaWZpZWQsIERNQSBpcyBub3QgZW5hYmxlZCBieSBkZWZhdWx0IGJlY2F1c2UgYnJl
YWsNCj4gZGV0ZWN0aW9uIGRvZXNuJ3Qgd29yayB3aXRoIERNQS4NCj4gDQo+IEtlZXAgdGhlIG5v
ZGVzIGRpc2FibGVkIGJ5IGRlZmF1bHQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdh
bGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KDQpSZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNs
YXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3Qv
ZHRzL2xhbjk2NnguZHRzaSB8IDUyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2
eC5kdHNpDQo+IGluZGV4IDIzMGRlM2JkZDVmMS4uZDdlYWNiMDE0NGY1IDEwMDY0NA0KPiAtLS0g
YS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9k
dHMvbGFuOTY2eC5kdHNpDQo+IEBAIC05Miw2ICs5MiwxOSBAQCBmbHgwOiBmbGV4Y29tQGUwMDQw
MDAwIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MT47DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIHJhbmdlcyA9IDwweDAgMHhlMDA0MDAwMCAweDgwMD47DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgdXNhcnQwOiBzZXJpYWxAMjAwIHsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImF0bWVsLGF0OTFzYW05MjYwLXVzYXJ0
IjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgyMDAgMHgyMDA+
Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQ
SSA0OCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBkbWFzID0gPCZkbWEwIEFUOTFfWERNQUNfRFRfUEVSSUQoMyk+LA0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JmRtYTAgQVQ5MV9YRE1BQ19EVF9QRVJJRCgy
KT47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1hLW5hbWVzID0gInR4Iiwg
InJ4IjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8Jm5pY19j
bGs+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gInVz
YXJ0IjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhdG1lbCxmaWZvLXNpemUg
PSA8MzI+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNh
YmxlZCI7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ICAgICAgICAgICAgICAgICB9
Ow0KPiANCj4gICAgICAgICAgICAgICAgIGZseDE6IGZsZXhjb21AZTAwNDQwMDAgew0KPiBAQCAt
MTAyLDYgKzExNSwxOSBAQCBmbHgxOiBmbGV4Y29tQGUwMDQ0MDAwIHsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MT47DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IHJhbmdlcyA9IDwweDAgMHhlMDA0NDAwMCAweDgwMD47DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
dXNhcnQxOiBzZXJpYWxAMjAwIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b21wYXRpYmxlID0gImF0bWVsLGF0OTFzYW05MjYwLXVzYXJ0IjsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICByZWcgPSA8MHgyMDAgMHgyMDA+Ow0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSA0OSBJUlFfVFlQRV9MRVZFTF9I
SUdIPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkbWFzID0gPCZkbWEwIEFU
OTFfWERNQUNfRFRfUEVSSUQoNSk+LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA8JmRtYTAgQVQ5MV9YRE1BQ19EVF9QRVJJRCg0KT47DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZG1hLW5hbWVzID0gInR4IiwgInJ4IjsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8Jm5pY19jbGs+Ow0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gInVzYXJ0IjsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBhdG1lbCxmaWZvLXNpemUgPSA8MzI+Ow0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIH07DQo+ICAgICAgICAgICAgICAgICB9Ow0KPiANCj4gICAgICAgICAgICAg
ICAgIHRybmc6IHJuZ0BlMDA0ODAwMCB7DQo+IEBAIC0xMjksNiArMTU1LDE5IEBAIGZseDI6IGZs
ZXhjb21AZTAwNjAwMDAgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9
IDwxPjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmFuZ2VzID0gPDB4MCAweGUwMDYwMDAw
IDB4ODAwPjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsN
Cj4gKw0KPiArICAgICAgICAgICAgICAgICAgICAgICB1c2FydDI6IHNlcmlhbEAyMDAgew0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNh
bTkyNjAtdXNhcnQiOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDww
eDIwMCAweDIwMD47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0
cyA9IDxHSUNfU1BJIDUwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGRtYXMgPSA8JmRtYTAgQVQ5MV9YRE1BQ19EVF9QRVJJRCg3KT4sDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmZG1hMCBBVDkxX1hETUFD
X0RUX1BFUklEKDYpPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkbWEtbmFt
ZXMgPSAidHgiLCAicngiOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2Nr
cyA9IDwmbmljX2Nsaz47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2xvY2st
bmFtZXMgPSAidXNhcnQiOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF0bWVs
LGZpZm8tc2l6ZSA9IDwzMj47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Rh
dHVzID0gImRpc2FibGVkIjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gICAgICAg
ICAgICAgICAgIH07DQo+IA0KPiAgICAgICAgICAgICAgICAgZmx4MzogZmxleGNvbUBlMDA2NDAw
MCB7DQo+IEBAIC0xODEsNiArMjIwLDE5IEBAIGZseDQ6IGZsZXhjb21AZTAwNzAwMDAgew0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwxPjsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgcmFuZ2VzID0gPDB4MCAweGUwMDcwMDAwIDB4ODAwPjsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKw0KPiArICAgICAgICAgICAg
ICAgICAgICAgICB1c2FydDQ6IHNlcmlhbEAyMDAgew0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTkyNjAtdXNhcnQiOw0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDIwMCAweDIwMD47DQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDUyIElSUV9U
WVBFX0xFVkVMX0hJR0g+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRtYXMg
PSA8JmRtYTAgQVQ5MV9YRE1BQ19EVF9QRVJJRCgxMSk+LA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA8JmRtYTAgQVQ5MV9YRE1BQ19EVF9QRVJJRCgxMCk+Ow0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRtYS1uYW1lcyA9ICJ0eCIsICJyeCI7DQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZuaWNfY2xrPjsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbG9jay1uYW1lcyA9ICJ1c2FydCI7DQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXRtZWwsZmlmby1zaXplID0gPDMyPjsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0K
PiArICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiAgICAgICAgICAgICAgICAgfTsNCj4gDQo+
ICAgICAgICAgICAgICAgICB0aW1lcjA6IHRpbWVyQGUwMDhjMDAwIHsNCj4gLS0NCj4gMi4zMC4y
DQo+IA0KDQo=
