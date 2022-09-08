Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13615B14FB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiIHGrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiIHGqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:46:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E68491EA;
        Wed,  7 Sep 2022 23:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662619601; x=1694155601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PgrCPsIXCyPLMJbOorLEuI7xUprtCBLgY4uocmanzxQ=;
  b=buvpSmTdzgqjMkXV3wFAxyIr+KTRowDBRMAOv6ZYTXk8K2gD9C+4kmaS
   Zqj4vNZbib7VjWY+m9wfxzwkq2rmW6dpo63/agu14g/FpL+7gd3YEIsAZ
   ULiQqjeX4NUeWXVHLFjapzeBOz0TN+o42apC17Hdpy0g4C5u5oJXm6Zra
   pLxJbudJ0E0YVnXjamGPaoqEq24BTmC0sOpMELgj0ntKF1jH8TIPzCgCz
   4Sp80eUZ5E9eddWq33hjZqNLpprePT2esXkiA6VJhcXP3cVqOhi/NcUyZ
   mi8XVjClEhu5R/LTpgp/LrwQBAibI+WaLtCro63iVYNOT6sMWlmQ96dYZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="172899142"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 23:46:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 23:46:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 23:46:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijzN5ZVPXSABnUz4GKYn1JDSpPxWhfLjdVGB6AnicQnjKNZ8ONCW+a1KRZPRLVDJ7IOwhfKQhMZ3i35PPb2s2AwDbz4fpIozXipZCxWzRISzyOb4EDgVZRWVSj/FrCjOqjnD1bEevavuILNeiwJeFfEafd3kTfSOMelYYYmLb6r7NG6e4NiLVYRWXRRHFQ2PYJ9WarclJosZzXgt+B0FHiUxBp5kWK3+6AbyFRT381lndkKev0EzxXp7hulWRMQ6XLpACxP9dVdVCuFOcr72Zqc/HxESKy74Z0Sf/gy3AmEe8kgyp+dezPYY8xMPR6kAm857ay1KNfIybhHneBRWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgrCPsIXCyPLMJbOorLEuI7xUprtCBLgY4uocmanzxQ=;
 b=GHnCekoEg61O4IHZmMVjzpNg9qXbEO8M6vg0ukvNtZcHKU8fp2Vyn9Gk7zkad73UAWhQYawzWeFgMl3m8hoXtT5wvLpu2z77xZCUIlTiIuelUqRwOjbv31dCT7fhTgETx6KdOJ0W3frjr6ax9DQYAyCRRBCbeh/4ObP6xg5I+m//VV38/ZtrZzzuff+vcveDqHaTYKUIOSJYMLblaYE3YWrebanmxqSfk0ktVllqRjfI2WI0UDPU64Vh60TSOCgf55V5yaQQabj4mk9S/UV+h1qSObfDpIqh40BmoZaJVHhOArdxiYSXNZSJsM7dmwuPvETYx4hagSFWloq6xsm3lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgrCPsIXCyPLMJbOorLEuI7xUprtCBLgY4uocmanzxQ=;
 b=lg/fpNmO4V/Z23z8NhPgWXP+k3zs+au2TycnIzUclYPudeqCkLqNfAcgg2QkUvzGX4gRELgs5+6yK7kK6qtSY9dKFgmysKE9BIibSee1SYZxWcEFbTv7/ioa9lFPu6wpI+grolLfYgSbc4VWAEA5uvTQp/QJvruDxN5HycxniHA=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH7PR11MB5766.namprd11.prod.outlook.com (2603:10b6:510:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Thu, 8 Sep
 2022 06:46:33 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 06:46:33 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Conor.Dooley@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <Daire.McNamara@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 08/13] clk: microchip: mpfs: move id & offset out of
 clock structs
Thread-Topic: [PATCH v4 08/13] clk: microchip: mpfs: move id & offset out of
 clock structs
Thread-Index: AQHYw06763ZHD8mV9EWJbRnhYDMd/g==
Date:   Thu, 8 Sep 2022 06:46:32 +0000
Message-ID: <4001027e-9fe1-4902-5b40-b2d582aecea7@microchip.com>
References: <20220830125110.2372514-1-conor.dooley@microchip.com>
 <20220830125249.2373416-8-conor.dooley@microchip.com>
In-Reply-To: <20220830125249.2373416-8-conor.dooley@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0831e62f-be4d-46c2-3c00-08da9165de15
x-ms-traffictypediagnostic: PH7PR11MB5766:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cLpgaBthfDlBKsbMjkNYiS82AlIwKn/S9XmJLDvr+amM0/Ljqdu6+XCLdIZq7C9B7RR6nQ6FQVmnrhYk5A01kWhaBjURBiNv6FTOhYXt+DGXnTsLOm50U7c+Yu00yzrhY4Ivsw12P5YDjnAHHHGLeiQwHy72eAbRK4bjHj5UQfPeuiZ1OWpGHImAS0oK8IopbggZOP58jBTbTrZiLXfURAk2+fiTbCo13sle1sq9ydP9CotUDB4/ZNNHP2TiTDWWzunI3qNcFQ7YhbN/1Ojrcv6f7hOV9Il82kkIGv0n7W2+qhfeQKmXH1kSdV5VBRisDknIiNSRpbUAAS2rQjMLOBrKIPjrzb7sytzCR6TzWA2mw0BiIyEV5YAO43nlHuAe0pvMODRkPsVWN0UzO8YS5SdUMOSJ/HEnX+8YNnkraPkPJFxXGWT/81+EwEST/B2iW63QKOAB6eB+FUYOV1vxMKxkrZKehMnk+/MouG44+4KgEByEw8f2WSDXXqnIUyzxpcJZnU2GmwNwmIyPQKSoQahRMBq2cKFZ8xvvwktq/QAUnMI4tXk6VRSzcUAGUMe4+fJOYRtOFZ912KnetS5FNN2Rq68fiWIbatYZO0eVOVJaRQaurbz30YyHtzleBI/UDmCL3CtdzIOWAHwzADjv8SpZ6Mhhjgqq2D/SAGbkiFsgdqVAG66EoXTovn+dvYrLE8QKkqwFKBmxyHjqmmeTTWT1DLmU1bdhzbOWRaDEVqFeF1jBglP5LyIhYRwALTK7kgpeMOWbGPIPx2I7to/IxNa3LD2EMwMhHJsb5+bgW5bStbjHqEroL2eoCg3sDf0LqDQsKnH0lcJC6cABj1WRBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(396003)(376002)(346002)(66556008)(110136005)(316002)(2906002)(6636002)(83380400001)(6512007)(53546011)(6506007)(478600001)(54906003)(26005)(7416002)(5660300002)(38070700005)(31696002)(36756003)(86362001)(8936002)(66476007)(91956017)(66446008)(66946007)(64756008)(8676002)(31686004)(122000001)(4326008)(186003)(71200400001)(41300700001)(38100700002)(76116006)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmdZemFXSndoT3lOWldTQmJYa0dhUEZPc2xzVnZMUWRVdWNINlFMZEo4QWRq?=
 =?utf-8?B?eTBkTUhYSHpmdVRTQmptMG9rd20xWnpSSWFYUlM1YmVGMittV2QybkZYWHFh?=
 =?utf-8?B?bW1UZjZ4OEI5dzlraW50bk9ESDlEbmVCMWdJRzNHVlg3UDZ2bVd0UXlKVWhY?=
 =?utf-8?B?STk4NENXdjhBMnNCdTU2RnBmZzdmdGVnemNzNFFLZ2Q0Z3lkMjd5L2kxdE5J?=
 =?utf-8?B?NjNaUnU0VUFKRTMycU1UV3NiSmU3Rm1oSmFPT1pkVXAyOFZPZDdLWCtSeng5?=
 =?utf-8?B?Lzl0UlFDQXFZVkJTdWlMTm9VTWRCZldvTXFVTXM0RUhVd1FWbE1yOHlpeEkz?=
 =?utf-8?B?UHRGNGMrNjErTVdNWUJqQzAzM1JrRFgwZFZsVmQ3MW00UkRGV0tGMC9KN3JC?=
 =?utf-8?B?NktjQ29aYW11WS94MDBzZ2JFSndBemRUTUJCZFQ2eFMwcDh0K3hyb3ZXQlU5?=
 =?utf-8?B?aG9XNGV2K0RJMVU5OVF0cTlpRzNHSFhBeGlaOHJqOUpHOFNJOFc2bk1vdVpz?=
 =?utf-8?B?d09lT2hUQ2VCMEJDZjBpeEFBejRDMGUwQTNHSmxGZFJuckNxMHNEbkRON1lC?=
 =?utf-8?B?dzJVUUppYy9ZMVBNdGpvYmlsQ2p6YVo0TWFsVFlIU3cvMFBDUi9Ma0lvZFBu?=
 =?utf-8?B?UU43SklGZ0ZIdHdmWlZwQ1JJOFBOZytFT1hOL082Sm1yOXkwSVBKcWhtOWNO?=
 =?utf-8?B?Zmk3U2NJby9JM0JwTmhJVmhFOTN4N3Nqa2hEVmNHVUNObW83KzRURFdFdkhD?=
 =?utf-8?B?bXp0MkxnSW4rbGdOTEE4OWhiRE1MVC9XTFJsMk1uWWd2YmFDeDY4VTNXY3Fs?=
 =?utf-8?B?dlNyTXNQSTg4Ymp2Uk84MEY2Z2Job0hQK3lhYytxTmM1SDU0MWVhOHdDQXFw?=
 =?utf-8?B?aTFHa0FxaS9QcDdML0dOTUs5aXk2OFN0Y3R0MUpEcm5XeGllbm5QWkRjOFQ3?=
 =?utf-8?B?d2pjRVhEcHV5bWdNTUwvVnFaRHpoc0NvUXVDb3pyS3IyZEwrZlA2YTBlTXNs?=
 =?utf-8?B?bS9KZCs0SzhMb1V4Q3pSLzF2L0s5RW5odmdEZVFEaTBYMC9VMkVjZHU5MWZC?=
 =?utf-8?B?S1U1TElpVTUyNmlqcCtFQ2IwR1BMMCtXTkpFMjdEQ25yZE5QQnZidUc3N3pT?=
 =?utf-8?B?bnU2OGZELzBmakswOWZRODd6ZXlvelNGNHhRU0xCZ2c4SFdhZU1JeXNwRGVa?=
 =?utf-8?B?TUliaXlLYTkrSW50OG1HLzdUanhOTzV1ZTM4RmJRWFJPcEVKV3ZhN1Vscmhq?=
 =?utf-8?B?Vks4MVRZQUhkVDA0dnVCQ3VYM2UzdElrb1ZobFRhcHRIQlJyWkZUeFgyS3Rx?=
 =?utf-8?B?ZjlZRUczNGg0alJVektTNDdkMUZYd1BFSFVZMkp1WExiWFEzaUxKdUNxdFVX?=
 =?utf-8?B?WGptZjF2Y3QxL2s3clFUQUhNRjVPUURQNnlCSno1ZzMwL2VGVGNQUEFaaStN?=
 =?utf-8?B?bXJ0MGE0LzFKeWl6dkxpQm5ZS2tEeFRCRjdoTjQrdldFVzQ4dllFTzZJUXY1?=
 =?utf-8?B?MWhJeXZTa2VGNHRubXhyYlNJVlFWNm0vd1JLRG03RDZHL0RkQXgyT3VLWGM0?=
 =?utf-8?B?Mkk4WnpJOFZWR2xQc0hOdVNHNjBLQng2aHpVRVpMT1FUMHhjSHlEbHFoei9L?=
 =?utf-8?B?R3draElaRUhST2NQdGpmY3lTNU11SGlXOGs2OWdvMnMrV0lzeEVuNWhFWGIz?=
 =?utf-8?B?RnRvTlNzdnJ5Ym1keUtHOE1yMnhSNkJPZVpaS0VpcklqOXRtZ0xZTURudlJV?=
 =?utf-8?B?enZtdmVUMVBSV1o2eEVIQThLZ2cxU3dUSnQxSW9TUk96WVBCSjV1ME9MaDE1?=
 =?utf-8?B?VEJ2RUFDUGhiNnNId3BxUXlIVUxOdUluVkZncmdGcnl0WEl6cXhWc3Zlb2hP?=
 =?utf-8?B?ZjZ2OWtxRThtVnRTS2RNQlNmMDA5QmN6TXR2WVNFbDBGQm5JMHhDS2E5anZL?=
 =?utf-8?B?bUtDdXpSZlFCamZxaksyZ2ZuOE5MK3dLdml2TlBuVHFmS1pDR2Zad0NmT1JP?=
 =?utf-8?B?K0ZVNkgvM003S1Z4ZFpaRC9sNmxaQWQzcG10SEM2M1R6VW1NSnIyZlBYY3RG?=
 =?utf-8?B?T3RCbUdWajh4S0lycGpTR2hqczV1d2FPbzRjc1YxbnBxYXZMRUROcGlZRmYr?=
 =?utf-8?B?OHBJRkNEVlFZU3lOc01HL3VIQ0M0MC80QjQ2SWpMVVI0UzNZaGtGZi84Q0Ez?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F4883493C83844A93FD9D19F0A39793@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0831e62f-be4d-46c2-3c00-08da9165de15
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 06:46:32.9848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSqPnEycZ+67N85ofBsu2ibuPg+yVdiA2AH5l2cUFjtePjlczDSOaZ15iOtTUmDuwV0rcqRmFX0H3nIi/yvpnjyC3YaCrHyr8FUWC8g/GME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5766
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAuMDguMjAyMiAxNTo1MiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBUaGUgaWQgYW5kIG9m
ZnNldCBhcmUgdGhlIG9ubHkgdGhpbmcgZGlmZmVyZW50aWF0aW5nIHRoZSBjbG9jayBzdHJ1Y3Rz
DQo+IGZyb20gInJlZ3VsYXIiIGNsb2NrIHN0cnVjdHVyZXMuIE9uIHRoZSBwcmV0ZXh0IG9mIGNv
bnZlcnRpbmcgdG8gbW9yZQ0KPiBub3JtYWwgc3RydWN0dXJlcywgbW92ZSB0aGUgaWQgYW5kIG9m
ZnNldCBvdXQgb2YgdGhlIGNsb2NrIHN0cnVjdHMgYW5kDQo+IGludG8gdGhlIGh3IHN0cnVjdHMg
aW5zdGVhZC4NCj4gDQo+IFJldmlld2VkLWJ5OiBEYWlyZSBNY05hbWFyYSA8ZGFpcmUubWNuYW1h
cmFAbWljcm9jaGlwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5k
b29sZXlAbWljcm9jaGlwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1
ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4gLS0tDQo+ICBkcml2ZXJzL2Nsay9taWNy
b2NoaXAvY2xrLW1wZnMuYyB8IDMwICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21pY3JvY2hpcC9jbGstbXBmcy5jIGIvZHJpdmVycy9j
bGsvbWljcm9jaGlwL2Nsay1tcGZzLmMNCj4gaW5kZXggMDA4Yjc2ZDgxNDg1Li44NDU2NTg3NTE2
OTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL21pY3JvY2hpcC9jbGstbXBmcy5jDQo+ICsr
KyBiL2RyaXZlcnMvY2xrL21pY3JvY2hpcC9jbGstbXBmcy5jDQo+IEBAIC01Myw4ICs1Myw2IEBA
IHN0cnVjdCBtcGZzX21zc3BsbF9od19jbG9jayB7DQo+ICANCj4gIHN0cnVjdCBtcGZzX2NmZ19j
bG9jayB7DQo+ICAJY29uc3Qgc3RydWN0IGNsa19kaXZfdGFibGUgKnRhYmxlOw0KPiAtCXVuc2ln
bmVkIGludCBpZDsNCj4gLQl1MzIgcmVnX29mZnNldDsNCj4gIAl1OCBzaGlmdDsNCj4gIAl1OCB3
aWR0aDsNCj4gIAl1OCBmbGFnczsNCj4gQEAgLTY1LDEyICs2MywxMyBAQCBzdHJ1Y3QgbXBmc19j
ZmdfaHdfY2xvY2sgew0KPiAgCXZvaWQgX19pb21lbSAqc3lzX2Jhc2U7DQo+ICAJc3RydWN0IGNs
a19odyBodzsNCj4gIAlzdHJ1Y3QgY2xrX2luaXRfZGF0YSBpbml0Ow0KPiArCXVuc2lnbmVkIGlu
dCBpZDsNCj4gKwl1MzIgcmVnX29mZnNldDsNCj4gIH07DQo+ICANCj4gICNkZWZpbmUgdG9fbXBm
c19jZmdfY2xrKF9odykgY29udGFpbmVyX29mKF9odywgc3RydWN0IG1wZnNfY2ZnX2h3X2Nsb2Nr
LCBodykNCj4gIA0KPiAgc3RydWN0IG1wZnNfcGVyaXBoX2Nsb2NrIHsNCj4gLQl1bnNpZ25lZCBp
bnQgaWQ7DQo+ICAJdTggc2hpZnQ7DQo+ICB9Ow0KPiAgDQo+IEBAIC03OCw2ICs3Nyw3IEBAIHN0
cnVjdCBtcGZzX3BlcmlwaF9od19jbG9jayB7DQo+ICAJc3RydWN0IG1wZnNfcGVyaXBoX2Nsb2Nr
IHBlcmlwaDsNCj4gIAl2b2lkIF9faW9tZW0gKnN5c19iYXNlOw0KPiAgCXN0cnVjdCBjbGtfaHcg
aHc7DQo+ICsJdW5zaWduZWQgaW50IGlkOw0KPiAgfTsNCj4gIA0KPiAgI2RlZmluZSB0b19tcGZz
X3BlcmlwaF9jbGsoX2h3KSBjb250YWluZXJfb2YoX2h3LCBzdHJ1Y3QgbXBmc19wZXJpcGhfaHdf
Y2xvY2ssIGh3KQ0KPiBAQCAtMjQzLDcgKzI0Myw3IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIG1w
ZnNfY2ZnX2Nsa19yZWNhbGNfcmF0ZShzdHJ1Y3QgY2xrX2h3ICpodywgdW5zaWduZWQgbG9uZyBw
DQo+ICAJdm9pZCBfX2lvbWVtICpiYXNlX2FkZHIgPSBjZmdfaHctPnN5c19iYXNlOw0KPiAgCXUz
MiB2YWw7DQo+ICANCj4gLQl2YWwgPSByZWFkbF9yZWxheGVkKGJhc2VfYWRkciArIGNmZy0+cmVn
X29mZnNldCkgPj4gY2ZnLT5zaGlmdDsNCj4gKwl2YWwgPSByZWFkbF9yZWxheGVkKGJhc2VfYWRk
ciArIGNmZ19ody0+cmVnX29mZnNldCkgPj4gY2ZnLT5zaGlmdDsNCj4gIAl2YWwgJj0gY2xrX2Rp
dl9tYXNrKGNmZy0+d2lkdGgpOw0KPiAgDQo+ICAJcmV0dXJuIGRpdmlkZXJfcmVjYWxjX3JhdGUo
aHcsIHByYXRlLCB2YWwsIGNmZy0+dGFibGUsIGNmZy0+ZmxhZ3MsIGNmZy0+d2lkdGgpOw0KPiBA
QCAtMjcyLDEwICsyNzIsMTAgQEAgc3RhdGljIGludCBtcGZzX2NmZ19jbGtfc2V0X3JhdGUoc3Ry
dWN0IGNsa19odyAqaHcsIHVuc2lnbmVkIGxvbmcgcmF0ZSwgdW5zaWduZWQNCj4gIAkJcmV0dXJu
IGRpdmlkZXJfc2V0dGluZzsNCj4gIA0KPiAgCXNwaW5fbG9ja19pcnFzYXZlKCZtcGZzX2Nsa19s
b2NrLCBmbGFncyk7DQo+IC0JdmFsID0gcmVhZGxfcmVsYXhlZChiYXNlX2FkZHIgKyBjZmctPnJl
Z19vZmZzZXQpOw0KPiArCXZhbCA9IHJlYWRsX3JlbGF4ZWQoYmFzZV9hZGRyICsgY2ZnX2h3LT5y
ZWdfb2Zmc2V0KTsNCj4gIAl2YWwgJj0gfihjbGtfZGl2X21hc2soY2ZnLT53aWR0aCkgPDwgY2Zn
X2h3LT5jZmcuc2hpZnQpOw0KPiAgCXZhbCB8PSBkaXZpZGVyX3NldHRpbmcgPDwgY2ZnLT5zaGlm
dDsNCj4gLQl3cml0ZWxfcmVsYXhlZCh2YWwsIGJhc2VfYWRkciArIGNmZy0+cmVnX29mZnNldCk7
DQo+ICsJd3JpdGVsX3JlbGF4ZWQodmFsLCBiYXNlX2FkZHIgKyBjZmdfaHctPnJlZ19vZmZzZXQp
Ow0KPiAgDQo+ICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbXBmc19jbGtfbG9jaywgZmxhZ3Mp
Ow0KPiAgDQo+IEBAIC0yODksMTEgKzI4OSwxMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19v
cHMgbXBmc19jbGtfY2ZnX29wcyA9IHsNCj4gIH07DQo+ICANCj4gICNkZWZpbmUgQ0xLX0NGRyhf
aWQsIF9uYW1lLCBfcGFyZW50LCBfc2hpZnQsIF93aWR0aCwgX3RhYmxlLCBfZmxhZ3MsIF9vZmZz
ZXQpIHsJCVwNCj4gLQkuY2ZnLmlkID0gX2lkLAkJCQkJCQkJCVwNCj4gKwkuaWQgPSBfaWQsCQkJ
CQkJCQkJXA0KPiAgCS5jZmcuc2hpZnQgPSBfc2hpZnQsCQkJCQkJCQlcDQo+ICAJLmNmZy53aWR0
aCA9IF93aWR0aCwJCQkJCQkJCVwNCj4gIAkuY2ZnLnRhYmxlID0gX3RhYmxlLAkJCQkJCQkJXA0K
PiAtCS5jZmcucmVnX29mZnNldCA9IF9vZmZzZXQsCQkJCQkJCVwNCj4gKwkucmVnX29mZnNldCA9
IF9vZmZzZXQsCQkJCQkJCQlcDQo+ICAJLmNmZy5mbGFncyA9IF9mbGFncywJCQkJCQkJCVwNCj4g
IAkuaHcuaW5pdCA9IENMS19IV19JTklUKF9uYW1lLCBfcGFyZW50LCAmbXBmc19jbGtfY2ZnX29w
cywgMCksCQkJXA0KPiAgfQ0KPiBAQCAtMzA2LDExICszMDYsMTEgQEAgc3RhdGljIHN0cnVjdCBt
cGZzX2NmZ19od19jbG9jayBtcGZzX2NmZ19jbGtzW10gPSB7DQo+ICAJQ0xLX0NGRyhDTEtfQUhC
LCAiY2xrX2FoYiIsICJjbGtfbXNzcGxsIiwgNCwgMiwgbXBmc19kaXZfYWhiX3RhYmxlLCAwLA0K
PiAgCQlSRUdfQ0xPQ0tfQ09ORklHX0NSKSwNCj4gIAl7DQo+IC0JCS5jZmcuaWQgPSBDTEtfUlRD
UkVGLA0KPiArCQkuaWQgPSBDTEtfUlRDUkVGLA0KPiAgCQkuY2ZnLnNoaWZ0ID0gMCwNCj4gIAkJ
LmNmZy53aWR0aCA9IDEyLA0KPiAgCQkuY2ZnLnRhYmxlID0gbXBmc19kaXZfcnRjcmVmX3RhYmxl
LA0KPiAtCQkuY2ZnLnJlZ19vZmZzZXQgPSBSRUdfUlRDX0NMT0NLX0NSLA0KPiArCQkucmVnX29m
ZnNldCA9IFJFR19SVENfQ0xPQ0tfQ1IsDQo+ICAJCS5jZmcuZmxhZ3MgPSBDTEtfRElWSURFUl9P
TkVfQkFTRUQsDQo+ICAJCS5ody5pbml0ID0NCj4gIAkJCUNMS19IV19JTklUX1BBUkVOVFNfREFU
QSgiY2xrX3J0Y3JlZiIsIG1wZnNfZXh0X3JlZiwgJm1wZnNfY2xrX2NmZ19vcHMsIDApLA0KPiBA
QCAtMzM4LDkgKzMzOCw5IEBAIHN0YXRpYyBpbnQgbXBmc19jbGtfcmVnaXN0ZXJfY2ZncyhzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBtcGZzX2NmZ19od19jbG9jayAqDQo+ICAJCXJldCA9IG1w
ZnNfY2xrX3JlZ2lzdGVyX2NmZyhkZXYsIGNmZ19odywgc3lzX2Jhc2UpOw0KPiAgCQlpZiAocmV0
KQ0KPiAgCQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJmYWlsZWQgdG8gcmVnaXN0
ZXIgY2xvY2sgaWQ6ICVkXG4iLA0KPiAtCQkJCQkgICAgIGNmZ19ody0+Y2ZnLmlkKTsNCj4gKwkJ
CQkJICAgICBjZmdfaHctPmlkKTsNCj4gIA0KPiAtCQlpZCA9IGNmZ19ody0+Y2ZnLmlkOw0KPiAr
CQlpZCA9IGNmZ19ody0+aWQ7DQo+ICAJCWRhdGEtPmh3X2RhdGEuaHdzW2lkXSA9ICZjZmdfaHct
Pmh3Ow0KPiAgCX0NCj4gIA0KPiBAQCAtNDA4LDcgKzQwOCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgY2xrX29wcyBtcGZzX3BlcmlwaF9jbGtfb3BzID0gew0KPiAgfTsNCj4gIA0KPiAgI2RlZmlu
ZSBDTEtfUEVSSVBIKF9pZCwgX25hbWUsIF9wYXJlbnQsIF9zaGlmdCwgX2ZsYWdzKSB7CQkJXA0K
PiAtCS5wZXJpcGguaWQgPSBfaWQsCQkJCQkJCVwNCj4gKwkuaWQgPSBfaWQsCQkJCQkJCQlcDQo+
ICAJLnBlcmlwaC5zaGlmdCA9IF9zaGlmdCwJCQkJCQkJXA0KPiAgCS5ody5pbml0ID0gQ0xLX0hX
X0lOSVRfSFcoX25hbWUsIF9wYXJlbnQsICZtcGZzX3BlcmlwaF9jbGtfb3BzLAkJXA0KPiAgCQkJ
CSAgX2ZsYWdzKSwJCQkJCVwNCj4gQEAgLTQ4Miw5ICs0ODIsOSBAQCBzdGF0aWMgaW50IG1wZnNf
Y2xrX3JlZ2lzdGVyX3BlcmlwaHMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbXBmc19wZXJp
cGhfaHdfYw0KPiAgCQlyZXQgPSBtcGZzX2Nsa19yZWdpc3Rlcl9wZXJpcGgoZGV2LCBwZXJpcGhf
aHcsIHN5c19iYXNlKTsNCj4gIAkJaWYgKHJldCkNCj4gIAkJCXJldHVybiBkZXZfZXJyX3Byb2Jl
KGRldiwgcmV0LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIGNsb2NrIGlkOiAlZFxuIiwNCj4gLQkJCQkJ
ICAgICBwZXJpcGhfaHctPnBlcmlwaC5pZCk7DQo+ICsJCQkJCSAgICAgcGVyaXBoX2h3LT5pZCk7
DQo+ICANCj4gLQkJaWQgPSBwZXJpcGhfaHdzW2ldLnBlcmlwaC5pZDsNCj4gKwkJaWQgPSBwZXJp
cGhfaHdzW2ldLmlkOw0KPiAgCQlkYXRhLT5od19kYXRhLmh3c1tpZF0gPSAmcGVyaXBoX2h3LT5o
dzsNCj4gIAl9DQo+ICANCg0K
