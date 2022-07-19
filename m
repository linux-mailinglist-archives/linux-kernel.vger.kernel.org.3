Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF365792E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbiGSF5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiGSF5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:57:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B3237FBB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658210266; x=1689746266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0VGomoM/3WQCFxNo9De9k4WWub5sYZpfCQcfKpFclxk=;
  b=HtG5yLe9Khtc/RjG/HPdvLyXRZXTNwa2+irRp2U0qj+oGYxvgm4b+vyN
   uglxo10U9RGQiDpfNd5i+f5y5dK21uuhQ5cFqqXuPRfgsEHtA4yWwgGpG
   0oNwH1K5tU1/jf6/RotdDI5Vam0KCq1npy94owgXpVy2cqkwDVDnvvD8+
   M3MCOJDG2/q+HCBUEqxS+zaSa+0d+9Pj9VeOC40MViiQdKbfWpKZtgAaG
   tTChG7jgbespF7YujZWpoqgtdj+KjlS2dHZr6jUj0cyeHRdL7GQNN/PBf
   MAaCMnv/B7GgMDmBT/tGp5Y8swXP+76P/+OF17ldlybcNk6Rsin06nNav
   A==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="172685115"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2022 22:57:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 18 Jul 2022 22:57:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 18 Jul 2022 22:57:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g10/3y5h+PKWeIt5bdsmzUyeHMsIhAU6qUHpzZGjKEQTmoniwHQM3nYC00KdQAIGm/ZJbpbMctW73o/7lJyUJiXd4IzpyI2HXfYRHpcNX1gyVK5/5IdqN9pHpQrXjpYo9Dyd/x6vlHzSlhntiV8pMigAx59G4qe0YAwQT441ryXAWHr7fF4iWMJwkZnjMcMb5Q3B61gYB6Zcr6W0YjSnEu0Q6P4gEuWuDnQjmN9LLLKmhqJe5+LtyK3zYRHr4cCupAmOZ6lEHl53GcAgXwGDp/6w6qI8q+Ct4mBzQUmoCKiGHPBZdGl4TpRVCISqx8q92CmN7gCmHFkAKEbqjz86TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VGomoM/3WQCFxNo9De9k4WWub5sYZpfCQcfKpFclxk=;
 b=JEPgh7z/I9GIGdRfJY51GGvy+1+MBCRCEoz6Q700NKzy5HwlbXiptCvmjCOn9/ayHauw0MbvHUF/N7k17VubtlmoNHcC5BNcMBeLSOMcbv4vDM++cdqlVHeXyX8fMJjTmf/JRo8IkVzR3zGrWJKJXBqiCKuPz7sGpfI0cFx6F1LL+sbkuKv3QwDWzFkguld61hH/wwqd7rElIbxhEoLobYVAYJO1OWz4Uy0aK9nSr1NP5CBEqMeJLRvvCCD0C4VgEDm1EqK4Lt91Fnn8jYh5EVqGMJ9auAsmEnX5SwU3w7mei0izrOXQf7O9s7bRhqpnB3OJ4dogEoyh9kUAcZdybQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VGomoM/3WQCFxNo9De9k4WWub5sYZpfCQcfKpFclxk=;
 b=KlezB3rmm7TNqIXoPmyoaxVk84AhqrgtvS18JF+0m32Cr/QM7+XKSqRnFLnoVgvajxOdZJyYtLSwFfo8+X2pFnD2btnrZzGGf/8NKA/61/TO1t0LXyCwgwA2r7Lie4Vhlx6WGP0k7VQaXnn/RDhOwxWyhsj6aKR5wVVyLUogO/0=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 DM6PR11MB2921.namprd11.prod.outlook.com (2603:10b6:5:70::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.21; Tue, 19 Jul 2022 05:57:35 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 05:57:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <quic_c_sbhanu@quicinc.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: introduce SNOR_ID3()
Thread-Topic: [PATCH 1/2] mtd: spi-nor: introduce SNOR_ID3()
Thread-Index: AQHYmzRwuAFPdIe45ECo1RhI0CKwAw==
Date:   Tue, 19 Jul 2022 05:57:35 +0000
Message-ID: <160ddac1-6d0a-c922-1380-09e7823a285e@microchip.com>
References: <20220510140232.3519184-1-michael@walle.cc>
 <20220510140232.3519184-2-michael@walle.cc>
In-Reply-To: <20220510140232.3519184-2-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 673a9f54-73dd-4437-45d1-08da694b93df
x-ms-traffictypediagnostic: DM6PR11MB2921:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1hVLqC8cijxV60lIPjvRcP95wNuMm8ij9phZxzg4SUd96kqpTg6Xh3YAWNG7K+OL9NxFn9UekCAhv2LC8VU+l3pOA+iQGCXB2aZoWS3kzaCa+BRKtplS4T4A/FXYJeRw8dhuFKSuKAd0zUqWZ/fvUVOqwvMrfTj7pOPBDJ5RQQ5WHZ2iAiVRgcqdN9Rht6Zwc7+0YZbEc1qQOxhinTc4z2oO2rbS0ABy2iNhAKDBf11a0zuHnHknIyHYQwZa+KvwC6iBu+f1jDTXijSt+oVpcLWNrs4958oRHs4IRlWDGGkRLu+36cSmgQ+ET+U0WA2bux/iNLJ5+raIJ5Es4orBjkSAxa9qAf2wJ0/RCI+l0GeGzH2QwaCE3xrrd+8beiyFXEzgZlA+YBILzR2k99i4CuCD0hYeqiHj7oBQLFbGzxjkueSn0IEsUOP3JMTkbneNP/2Il0s1wIaqPCCLmC2VvzLs4DFpV2/TsL/ytE9RBf2/dpZlSDWnzSDRgbSVWdRrRiFyjJW2DcA7ridp6H06/qaS2jbtp6OBAm1AHoH7KZl8oGPlKXy6DDx/2gNfArxFUJss7VuN31k/xM3HZPcc7wr2XR9BF3sMiYUD/Ih60MYnn408k/uRi24YizdDymhH+k9n3Wqekg+7IiGWZiGlBv5g/G8QBAr/V5ePCG/7ktpswxiE/JBVhKi2NA5DJObelV2YaOSCZSLVnJ128oN7anphABTRronb4ZWGeNbfkdn8xdaJVuZtyg6UAEBMyXK9P0PBAVlVxXbAH1E1F/nvQG2K9rQ0qKlLBMTe4j1ebA+aF6/CgLQSnwOGcf/K3TlW8/L1DtiUVf80b/KOxA+leMqDzs769pZbg2JLllhRtdI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(376002)(396003)(136003)(36756003)(76116006)(31686004)(2906002)(8936002)(91956017)(5660300002)(316002)(54906003)(66476007)(66556008)(66446008)(4326008)(66946007)(8676002)(110136005)(64756008)(53546011)(122000001)(6486002)(6506007)(478600001)(31696002)(41300700001)(71200400001)(2616005)(38070700005)(86362001)(186003)(83380400001)(6512007)(38100700002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU01eUw0QmlNTjFaQjdqQlZKbll4QnRHVDY5WUQ3WXpBYkJsTVVlaGtJOXhn?=
 =?utf-8?B?Tko5azVuNVl6Q3pXZWoyekZ2SnBkcTBrZ09FV3hRZ2NCY0owaFRXNHZOYXZQ?=
 =?utf-8?B?UkpUTW1nUzBKWlY3dVFTR2l0azBhMUZqZEV1R2NFSkc0V1Z6TGFYQ0owYngx?=
 =?utf-8?B?bC9rQ2wwc2dVd0kvaEtMOXhRR1grT1J3UmJ2dFRFSFo3YzBMd2tHd29UYzIy?=
 =?utf-8?B?aGFqcEh1VFZkYXZnbXViZTRzR1A3RmJSMTVPVmFtbnJVUE5jUmhzbFc1amlm?=
 =?utf-8?B?ZmxRYzNBZUdydisxWHJxcnNKOTVwV2V3b1NKWHpRWmxENlBUMWFieFRMVnY4?=
 =?utf-8?B?RTZ2M1NJYmxmZnp2a2wzZVdvL3luQnQvYlk3cUl6em42MVlQOXdEZi9NUVVi?=
 =?utf-8?B?bC9xNURaTHJaZ1IvRHFra3VrdEV0d09Xa0tKa0twYXlIUDZvSjdXRDVybTRj?=
 =?utf-8?B?cHNMcXR6VEZhK3A1c0FBVUxIOEwxNGRHSmVCMkJOYXlmS3FIdUZGV09uZ0k1?=
 =?utf-8?B?UHlETGdNNGZZUmpmSmVYK2hFQUlraXVsZGRTcGRudEpTM054UkpJc0pmQ203?=
 =?utf-8?B?aXlCMTNjY2lOUW1DSEJOaml0aHlzbjUvUHVJQWxhdGRKMFdPcXd0eFV3ZUNT?=
 =?utf-8?B?RTZ4T2MwSFdoaVA2YTZBZFJ1SG9YdTRqVU5iUEhZck5CcmRvNUJrMDBEcUJP?=
 =?utf-8?B?V2UycktKVVluTDRPdXhoZktOZDNjeGYxM2N3VmRYNGRoUUVYVGdFdTdnVldy?=
 =?utf-8?B?U1p6QzAyN3I2NkNmUUp3OGpiYTlxYkQ2VDVySjlrTHBWcm0xK0laOWo1Tlpx?=
 =?utf-8?B?a1lTNG5OUzFLbDRHelQvMVZJcE9hU043T3RxNGt3SDFHOWxWcXpMVDVlV2M1?=
 =?utf-8?B?QXBJTnZXT00zcVBGZmxoOEpQdWQvUmlsMVUxbDBZRjIzNHdqU2NXMGhhS3hN?=
 =?utf-8?B?N05rc2Rwd0l0bnJ1K1Y5RnNFV3BUakIwVHRYUytHaDRmNUlsZXpFaWRIU0x2?=
 =?utf-8?B?eVM2aW1GNUp4UktTNjk2TXErdjNoTHA2dHJvRktZKzdaNkVYVHY1NzVaTG5t?=
 =?utf-8?B?cnB1K3FlWTZIMkhkSUpwYkhIL2drVkpkTkZIL0RqbEg1UktlQVZtS3JiUGxG?=
 =?utf-8?B?aWZiU2ttVnJtbnYyMXVTaTNrVlNzaUVvTGRJM25NRlUyNG9zZXJvRHpqS1RX?=
 =?utf-8?B?Rm1FYnpEUGRwa29sNmxLQ1dHWHp6ZWZseXhmQWhlZklySGg5TmwzN2tBYTZz?=
 =?utf-8?B?S0hhSnBtck9HRDJLc2gvRXQ3bzljclJDRW5ibC95UExLWmV0cjF2VzAzbVAw?=
 =?utf-8?B?WFRSd1QyM1JlWE92Y2pmeG5mRmtyWEtOVGo2MmVzYlRITXVqNGlBMjI5SzI3?=
 =?utf-8?B?UUd5b3oxZjlCYk5nVmFzRFRMM0Q1Ukg3SDVmNlAxRTFzMDhERUVxYmZueXJM?=
 =?utf-8?B?cVI1V2ZFaDJCbFhrbjRaenpZd1g4a25CWURvbkNOdFMxdklmRUJyYUZ4U1FX?=
 =?utf-8?B?UW1GTDVlc3R3OXRYdEtBNEhvY3FiSmsvemZaS1NxekhJZUZHM0ZBbk9XZUl3?=
 =?utf-8?B?ajU4MFVtUndJTTZQcVM4K2hWUDlqWkFBOE5GV0h5aGpsU3EvcjlhcE9kdEY3?=
 =?utf-8?B?ZlNvNGcyUFl2Y0ZFQjFjQUgraytWTGl3TUZsak5xTEQ2ZlNNVmw0UHozeHhw?=
 =?utf-8?B?SWNKbWJzZFYvNy9zbnoydUx3M2JZelZ4RzJ2VFZ0b1grZWVsOTdRZVhwUWtI?=
 =?utf-8?B?Q2NObW5sZFpoTlBPcTZ6RmxBR1ZIT1pINytJdXBkakRWNy9kRnBHVmVQVkt1?=
 =?utf-8?B?ek1ham1YRkNheTMvRWtCcFlZUlo2dFVnM01YWm5NQTFPdzRER0RKczV0VzRi?=
 =?utf-8?B?RExWRzU2cUlJNmd2NkR6RHB0bEx6YmdwYW1zNXVmYnhKWlJoUVpnTTA3MGg4?=
 =?utf-8?B?SXF2bWVrR1kxSEZkMlk5azdaTlBmbSs5N0E5bFAzSkZjb0FsOWpnUmFodFRX?=
 =?utf-8?B?TE5XM1plZC9EejVya3V2UnppTTBQSHNEVkxEbHAwUGlBQ2FxSnRjbVlseG80?=
 =?utf-8?B?MWoxZW02cFU0bnYvSzlNVzkySlBUYnlQU0VsK1dLd01zSzRPRVBWUHU0bndo?=
 =?utf-8?B?L1RGVS9FMnhnMW5iYlcvdFZPTmJmMDNOS2dCMndFQXM3Z0o5dW5GTVNkQm5o?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D142982CAFDC124D9A073A7623E2F3CC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673a9f54-73dd-4437-45d1-08da694b93df
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 05:57:35.0537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJuYT0ApMO7NvV8jtw7HhpXIKyfl/OtM/VzVh6fmZXlBsZS2qvBqLpAhyYTMZ8MEkhAi12ZEN6yVz+/20TTm+XeTrkbUtJPZP2kv/HfhU3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2921
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8xMC8yMiAxNzowMiwgTWljaGFlbCBXYWxsZSB3cm90ZToNCg0KSGkhDQoNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBVcCB1bnRpbCBub3csIGZsYXNoZXMg
d2VyZSBkZWZpbmVkIGJ5IHNwZWNpZnlpbmcgdGhlIEpFREVDIElELCB0aGUNCj4gc2VjdG9yIHNp
emUgYW5kIHRoZSBudW1iZXIgb2Ygc2VjdG9ycy4gVGhpcyBjYW4gYmUgcmVhZCBieSBwYXJzaW5n
IHRoZQ0KPiBTRkRQLCB3ZSBkb24ndCBoYXZlIHRvIHNwZWNpZnkgaXQuIFRodXMgcHJvdmlkZSBh
IG5ldyBtYWNybyBTTk9SX0lEMygpDQo+IHdoaWNoIGp1c3QgdGFrZXMgdGhlIEpFREVDIElEIGFu
ZCBpbXBsaWNpdGx5IHNldCAucGFyc2Vfc2ZkcCA9IHRydWUuIEFsbA0KPiBuZXcgZmxhc2hlcyB3
aGljaCBoYXZlIFNGRFAgc2hvdWxkIHVzZSB0aGlzIG1hY3JvLg0KDQpJIGxpa2UgdGhlIGlkZWEs
IGJ1dCB5b3UgbmVlZCB0byByZWZpbmUgaXQgYSBiaXQuDQpZb3VyIGFzc3VtcHRpb25zIGFyZSB0
cnVlIG9ubHkgZm9yIGZsYXNoZXMgdGhhdCBhcmUgY29tcGxpYW50IHdpdGggU0ZEUCByZXZCIG9y
DQpsYXRlciBiZWNhdXNlIHBhcmFtcy0+cGFnZV9zaXplIGlzIGluaXRpYWxpemVkIGJ5IHF1ZXJ5
aW5nIEJGUFQgRFdPUkQgMTEuIEkgdGhpbmsNCml0IHdvdWxkIGJlIGdvb2QgdG8gc3BlY2lmeSB0
aGlzIGluIHRoZSBjb21tZW50IHNlY3Rpb24uIEFsc28sIEkgdGhpbmsgeW91IGludHJvZHVjZQ0K
YSBidWcgaW4gc3BpX25vcl9zZWxlY3RfZXJhc2UoKSB3aGVuIENPTkZJR19NVERfU1BJX05PUl9V
U0VfNEtfU0VDVE9SUyBpcyBub3QNCnNlbGVjdGVkLiB3YW50ZWRfc2l6ZSB3aWxsIGJlIHplcm8s
IHdpbGwgeW91IHNlbGVjdCBhbiBpbnZhbGlkIGVyYXNlIHR5cGU/DQpXb3VsZCB5b3UgcGxlYXNl
IHJlc3VibWl0Pw0KDQpUaGFua3MsDQp0YQ0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVs
IFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5jIHwgNyArKysrKy0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaCB8IDkgKysr
KysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgYi9kcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiBpbmRleCA0MDJiMzdjZGJjZWEuLjI5MzI5ZWQwYTkz
NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gKysrIGIvZHJp
dmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gQEAgLTIxMDQsOCArMjEwNCwxMSBAQCBzdGF0aWMg
aW50IHNwaV9ub3Jfc2VsZWN0X3BwKHN0cnVjdCBzcGlfbm9yICpub3IsDQo+ICAgKiBzcGlfbm9y
X3NlbGVjdF91bmlmb3JtX2VyYXNlKCkgLSBzZWxlY3Qgb3B0aW11bSB1bmlmb3JtIGVyYXNlIHR5
cGUNCj4gICAqIEBtYXA6ICAgICAgICAgICAgICAgdGhlIGVyYXNlIG1hcCBvZiB0aGUgU1BJIE5P
Ug0KPiAgICogQHdhbnRlZF9zaXplOiAgICAgICB0aGUgZXJhc2UgdHlwZSBzaXplIHRvIHNlYXJj
aCBmb3IuIENvbnRhaW5zIHRoZSB2YWx1ZSBvZg0KPiAtICogICAgICAgICAgICAgICAgICAgICBp
bmZvLT5zZWN0b3Jfc2l6ZSBvciBvZiB0aGUgInNtYWxsIHNlY3RvciIgc2l6ZSBpbiBjYXNlDQo+
IC0gKiAgICAgICAgICAgICAgICAgICAgIENPTkZJR19NVERfU1BJX05PUl9VU0VfNEtfU0VDVE9S
UyBpcyBkZWZpbmVkLg0KPiArICogICAgICAgICAgICAgICAgICAgICBpbmZvLT5zZWN0b3Jfc2l6
ZSwgdGhlICJzbWFsbCBzZWN0b3IiIHNpemUgaW4gY2FzZQ0KPiArICogICAgICAgICAgICAgICAg
ICAgICBDT05GSUdfTVREX1NQSV9OT1JfVVNFXzRLX1NFQ1RPUlMgaXMgZGVmaW5lZCBvciAwIGlm
DQo+ICsgKiAgICAgICAgICAgICAgICAgICAgIHRoZXJlIGlzIG5vIGluZm9ybWF0aW9uIGFib3V0
IHRoZSBzZWN0b3Igc2l6ZS4gVGhlDQo+ICsgKiAgICAgICAgICAgICAgICAgICAgIGxhdHRlciBp
cyB0aGUgY2FzZSBpZiB0aGUgZmxhc2ggcGFyYW1ldGVycyBhcmUgcGFyc2VkDQo+ICsgKiAgICAg
ICAgICAgICAgICAgICAgIHNvbGVseSBieSBTRkRQLg0KPiAgICoNCj4gICAqIE9uY2UgdGhlIG9w
dGltdW0gdW5pZm9ybSBzZWN0b3IgZXJhc2UgY29tbWFuZCBpcyBmb3VuZCwgZGlzYWJsZSBhbGwg
dGhlDQo+ICAgKiBvdGhlci4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29y
ZS5oIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmgNCj4gaW5kZXggNjE4ODY4NjhjZDAyLi5m
YWIzMDM4YzRmNGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+
ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+IEBAIC01NjMsNiArNTYzLDE1IEBA
IHN0cnVjdCBmbGFzaF9pbmZvIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgLm5fcmVnaW9u
cyA9IChfbl9yZWdpb25zKSwgICAgICAgICAgICAgICAgICAgICAgXA0KPiAgICAgICAgICAgICAg
ICAgfSwNCj4gDQo+ICsjZGVmaW5lIFNOT1JfSUQzKF9qZWRlY19pZCkgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gKyAgICAgICAgICAgICAgIC5pZCA9IHsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAoKF9qZWRlY19pZCkgPj4gMTYpICYgMHhmZiwgICAgICAgICAg
ICAgICAgICAgICBcDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICgoX2plZGVjX2lkKSA+PiA4
KSAmIDB4ZmYsICAgICAgICAgICAgICAgICAgICAgIFwNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgKF9qZWRlY19pZCkgJiAweGZmLCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICB9LCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcDQo+ICsgICAgICAgICAgICAgICAuaWRfbGVuID0gMywgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gKyAgICAgICAgICAgICAgIC5w
YXJzZV9zZmRwID0gdHJ1ZSwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0K
PiArDQo+ICAjZGVmaW5lIFBBUlNFX1NGRFAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwNCj4gICAgICAgICAucGFyc2Vfc2ZkcCA9IHRydWUsICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiANCj4gLS0NCj4g
Mi4zMC4yDQo+IA0KDQo=
