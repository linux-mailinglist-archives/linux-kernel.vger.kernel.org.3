Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4F65591F7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 07:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiFXFZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 01:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiFXFZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 01:25:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B5669985;
        Thu, 23 Jun 2022 22:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdJNabo38YZ64aJ527GSlq1cQdCy1sYgNYVvVUSOQpX6TXuYTOEhrSZt7IdzXUaE2ygPkspwMG2ql2/17gfyxnp46v9PIx+Ehk3e8ayzlXnl9lWazeN/+xT3YiLbVVN6TQgckaODtg9P/sLDXrXUgM5tsP/DsHEXthfJ7fk1wBDLLZiPkGnyi0Ay9peUPItgT92m6LRO+ddQeOgF6Ni/aCxfMeMQG2zQ6qhiLJjk/kLeDUh+qiNWCjsU2rCmWeEbh69houu40tl5I8wV2n3UmIfy4LHUjlJszoQnc/HiuS+eLDPFwlw6dsJmb3zKW6T9CiPVyVYpVDmn0zIAzdWU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pslXYPQwburyiVtkQwWY8NzCjPJ/B4YNUJdTNUp8va4=;
 b=oL2yNWxrzZRSqkyN7xJQLGHz0zYr4kzqx4OJ5Vv5Ltlaj6NYIjqHwmFpz5rV7O/excHI6xSogjT5tLG7kUJ7+Y62UpIgqc0I+/IeBIJXiek6qVvNi3G0i1XS6DpO4bclm68YnjnOKO/a37+CY6TADFr3kz5e/BvGnMrX66SA8jReh853hWh4/HMiVdwZDHoiENUBriUkVwRTRNa1wAz5SMn0kHZlSVNyLI9HT6F9m9cEGbEObG5Mq9JJvbLOY0Q7mfQGcgKAEME+1TiSRKe6YyqbEegGC6Hq+CI4Rh9q5VS18sAM/sN9xHdxiGXKVcR/lS+ui84/YFyTEdrSq9ujKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pslXYPQwburyiVtkQwWY8NzCjPJ/B4YNUJdTNUp8va4=;
 b=xK2bYQMLdfQjsoWjzqQ7zCQAlcgv9PMbtIYT6JREixqaPT8aDfGM6JtxukY5S3w7QtHAomD1ckXlrVv9REfWHA5UG1P3dMsqiVS+wZH/T6MdsiAkii73gHtlqiyntgGd4EFEBPRvj+cyb92vk9BdNsXy8I1QP+kmcOuz7qWce8QiSb6wcPDyRVuh4ENV65eGOot2W5ccAY96VDrIYohtmM6U7WnXJL1LKypOSNnddIaxbnZLoRhY2pSNkIbnhjoKrrm/bJM4jDaaq6Rj7kRnGuv3EgAvh7wvo6+mBKIL78yOy6nu00rBg2H/mCosh+lyJN6BNHss//NS9LngLXWIag==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by PSAPR06MB4421.apcprd06.prod.outlook.com (2603:1096:301:8b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Fri, 24 Jun
 2022 05:25:16 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf%5]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 05:25:15 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     BMC-SW <BMC-SW@aspeedtech.com>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "clabbe.montjoie@gmail.com" <clabbe.montjoie@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dhphadke@microsoft.com" <dhphadke@microsoft.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "joel@jms.id.au" <joel@jms.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v3 1/5] crypto: aspeed: Add HACE hash driver
Thread-Topic: [PATCH v3 1/5] crypto: aspeed: Add HACE hash driver
Thread-Index: AQHYhTl7iqgBkkiFnUKt8dxseYK4Xq1clxOAgAFyBHA=
Date:   Fri, 24 Jun 2022 05:25:15 +0000
Message-ID: <HK0PR06MB32026FAA5D5F2852DD747A6480B49@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220621063752.1005781-1-neal_liu@aspeedtech.com>
 <20220621063752.1005781-2-neal_liu@aspeedtech.com>
 <21679090-7a89-865b-becf-d5552e8cedea@wanadoo.fr>
In-Reply-To: <21679090-7a89-865b-becf-d5552e8cedea@wanadoo.fr>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0cde6be-f114-4cbf-06a5-08da55a1ebaa
x-ms-traffictypediagnostic: PSAPR06MB4421:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QfAPyxzEBKQS/LQxXJMgShCoDRKc254AkFImdPzHZ5q+26nLnNsJopqF0s6rJld/CXozp7g0S2Y7mSPIZ49ibxpGaOv01snSkDUXboUg0kD4n+NJO3N9aGaofeskO7zqnPJyP3R0sgvBdJEXf5h/cascuq0oBhCfrKJG+CD3JF0h31+E7UfXmzH5kyxu7BHqc0Twlvrhvw09sJOCUrSuy9K90jXV6u3W8soIRNXQTYhTJEB6cstcAMqasCZBOkW/3QjK3CuawyQ7H0JKsZrfLrgy4JSIjQ6TWq4RXMqf1Ds7b/yEXMZ9wt0enkoO7dIXsvQOrDbtRZhZsQjzJZh/UH8QGHBWmo70v72ix3wnkXFT3lcsfVl+CSsHOEMzKj1T85jawTq389MtbTTyf/+Po4dihMnoYBSIipewd5izPSk/KP8iT6M8v6eBXtA2b/Y8BgEW8VreZ6YVUKt2vkeDGKZbXTzCFy4T2tunjtYl5hFZFHKZBRCCsU8jBsxYKdP/YN4QqGwbSjOewvNDIL/GgOUtAbRgJ37Dg7ugsG48eBT6JxsZ5BG0wfWFPSfZILekIQAPf1YFj5NL6JDAUN0D1b0VuagSut49dZg7wpGIArNMdSCySiOHm1cQejRqIDHq0rbTMfL5Fotm8jSZzeddorI4H19hA1DCi3YD4/Y5NXLvj3+l3yCMi7cN+LeuH+tdfDEcuaNegjtmDSupuaz++6E5QUtqqwAYaFo6QPHupgSPhUoKjm7NcByTwviFBW0dNxPfHeX491xJU0/++A7GBLW5FTcSI1P3FAvs5YjfZmQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(396003)(39840400004)(346002)(366004)(38100700002)(2906002)(186003)(41300700001)(83380400001)(55016003)(7696005)(6506007)(86362001)(26005)(66946007)(64756008)(7416002)(38070700005)(6916009)(122000001)(5660300002)(54906003)(52536014)(8676002)(76116006)(478600001)(66574015)(8936002)(33656002)(66556008)(66446008)(71200400001)(4326008)(66476007)(316002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SktpMWVCSDF0SGNteDFMcWJaM2JWdzdNaHpJWmRpdFpKQ2I4K2d2RlVmVTdD?=
 =?utf-8?B?d2VFWk9NaVR0NHNJTkx0MXo5QWpUTTRIMUZjdStkcGo5TzNid21nSzVoVVF0?=
 =?utf-8?B?Zzd5eW9YRXNsNGVKYmQ2MnM1MWNueVRyNGk4bytCbk0rNnpmdWh0YXZTY0pV?=
 =?utf-8?B?U1YzdmhuOUpTLzJ3YXdaSlJKbGY4VUYzdmlCSnZYTVhHcXFqdExaTWM0WTY4?=
 =?utf-8?B?UVV3V08vdzUrYWQrc052enJNOGdIcUNpbXBOdzR1WC9xSXBLaDRDWWhpSVps?=
 =?utf-8?B?LytaU2prUmxKY1FiTGE1MS9JMUNoOWdVa1NBN3UzbElpWENJV1hick4xV2sz?=
 =?utf-8?B?ZlBvWkJuWmN4M2VjZjhXZXJ4TkE0SSsyMEdGa2xtOEtEeDlrS0I4dkxLdXBw?=
 =?utf-8?B?ZXUrSU1mckNlakJpcVN6Q2w2RHpTMmcyTU1xOUdxRmlhMmNIWnN6OSt1V3I5?=
 =?utf-8?B?YlBrNkFoVXpvN2d4SmI4aUF2MC9aKzRNckpRQjNNODlhOUZSVEROS2xOQm5B?=
 =?utf-8?B?cFdsQm5iam43emd0THJTV2JMNWJIYlZ5Z29ZNnNsa0gwUVNpUjJOblo2aEdD?=
 =?utf-8?B?NGs1Z1FzVm8wMk1FVE9jdTRuOTRqQldwalczUWlzRS82VnRONmJxMnpOcTVy?=
 =?utf-8?B?TCtrSzF6T2JTMG5nRjkrM3RETWcvWjBIcHB0L0JVZHdxL2tGNG56TG5EWFlS?=
 =?utf-8?B?VzhSVUREL0NSeUZ1bUVmWldyb0RUM2N3bmU0eU5TdHIyNEladkxzUU9TYXpl?=
 =?utf-8?B?SzZEQlRqK0dKQlViWHFOVWs5RFIzRjlXbHIwMCtpKy9udGRrWXZQVnN0a0N5?=
 =?utf-8?B?aVRUWGdDV21ETHlEaHVvUXRpamtlUkRtaUlPNjZzaXFZOE0zN3AzRjRKRmxu?=
 =?utf-8?B?NmVnT2dURFFldDhvbHl3RjBZeGtyc0hOOU5vREdIcURsclNEVGhEdjNGZG5M?=
 =?utf-8?B?OThaQ1IxbktsdHBQZWZKWUNtZE9ZdGdoWVVRZEdpdzRtbllYckV6MmRObmsx?=
 =?utf-8?B?UnkzbkpkT0dwZFhTUTRzRElTWE5GcWhqanF3anpMWTZtUFRCVlM4Z20xRk5t?=
 =?utf-8?B?anY3eXZpekR4UmVBV3M3WWdGdFhyQXZQcEgwMzFHQi94VzJkR1o3ZUJKY2FX?=
 =?utf-8?B?Y0w4bTF5dHd3S1dDWmJNSDljckhpQlBrWldBSzRGbWtEQVBsYitweWtESWZz?=
 =?utf-8?B?dlZSZHBoZy9KWTBMaWJ0N0VWZzVPMWs0Mzl4NzRsZmhmRlM1dGpEM2ZKTmMx?=
 =?utf-8?B?OHNtYmdCOFJiaE8rQ0NVQUxNY0diQkNscVgvM0ZiU2RVODNWckRmZHM2UVhK?=
 =?utf-8?B?aUVBUG5hVWttMEM0THRpZ3duRlJNL0FFVlFEdGlCdEhFaXUvT09oS0ZkUjlT?=
 =?utf-8?B?ZHNPVTlrK3pnc1lVNk1uM2xXaWRsTkl5Q3Q2NlE5cWcxZ3dQaksrc3hCOW5y?=
 =?utf-8?B?MmlGL0l1TFF3UEQ1bFAxUHJoRXJBWFMrMGdWMUR1TFJIT1luYkk3anNQZnRY?=
 =?utf-8?B?M1NBMXRQVEh2SHJQekdlTU41TkNJQlVPNGxCZUI0TGU4UklIZjZGdGdTdmFT?=
 =?utf-8?B?NGg0ZkFLWWdlS2E0RVZibU9YcG84WS9CZkFWc1pDek8yUTdObExrWkx4aHZm?=
 =?utf-8?B?NmprOEUxTVZHWTZFT2VHSDhpNXVqSUVtODQ4Qkw4Wkx6UUdHWFZCYm5zT09W?=
 =?utf-8?B?OWJLbFFEa2pJK2Z0VjViZVFnNWpFSmJ6a2RwTFRjcXI1cytLclVsTzg0S3Qw?=
 =?utf-8?B?RVEvMEE2VkRybTY1dnhUcHl0L1NITlpQZjJFUFljb2dib01EOW5GTWxhYVJD?=
 =?utf-8?B?am4yelNPOVBHT0hsYkFUMzcrTTFaa0UzT3RRcXUvTTN5U3lsMmtHV2VBVWpJ?=
 =?utf-8?B?NElwTGpwUkNmNHd0d2JYTXFLZ0tVNlh1emlMNDkrK2N3MTFZVXdwWHdYKzJ0?=
 =?utf-8?B?NXQ1L0krcHhnd1pyOEJNSVZucGRxejJ1RkUwMXpRUEJQSW9leE5GQWtrSldN?=
 =?utf-8?B?c3BFLzB4WDBxb2hLYzVlRjlscFdoWFhyK1ZVQjhuNnY5WnlKc2dCRWp5RGpN?=
 =?utf-8?B?VUhaa24wcFlIRTBVOVJnRDBydGNoUURJdlZrYnE4ckEzNnR6bC9UUHRkUllh?=
 =?utf-8?Q?ZcV3kpKrUjNKXfKKeULJnKe1v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cde6be-f114-4cbf-06a5-08da55a1ebaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 05:25:15.8074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MDlwuae8fHcWr8RdmX/TwO9jKQt277IQAdfqfO86u+sxG6tyJ28XaZgYonlAIE9gNWgACAhRpH21adfQRYAweg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4421
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBMZSAyMS8wNi8yMDIyIMOgIDA4OjM3LCBOZWFsIExpdSBhIMOpY3JpdMKgOg0KPiA+IEhhc2gg
YW5kIENyeXB0byBFbmdpbmUgKEhBQ0UpIGlzIGRlc2lnbmVkIHRvIGFjY2VsZXJhdGUgdGhlIHRo
cm91Z2hwdXQNCj4gPiBvZiBoYXNoIGRhdGEgZGlnZXN0LCBlbmNyeXB0aW9uLCBhbmQgZGVjcnlw
dGlvbi4NCj4gPg0KPiA+IEJhc2ljYWxseSwgSEFDRSBjYW4gYmUgZGl2aWRlZCBpbnRvIHR3byBp
bmRlcGVuZGVudGx5IGVuZ2luZXMNCj4gPiAtIEhhc2ggRW5naW5lIGFuZCBDcnlwdG8gRW5naW5l
LiBUaGlzIHBhdGNoIGFpbXMgdG8gYWRkIEhBQ0UgaGFzaA0KPiA+IGVuZ2luZSBkcml2ZXIgZm9y
IGhhc2ggYWNjZWxlcmF0b3IuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOZWFsIExpdQ0KPiA+
IDxuZWFsX2xpdS1TQWxYRG1Bbm1PQXFESjZkbysvU2FRQHB1YmxpYy5nbWFuZS5vcmc+DQo+ID4g
U2lnbmVkLW9mZi1ieTogSm9obm55IEh1YW5nDQo+ID4gPGpvaG5ueV9odWFuZy1TQWxYRG1Bbm1P
QXFESjZkbysvU2FRQHB1YmxpYy5nbWFuZS5vcmc+DQo+ID4gLS0tDQo+IA0KPiBbLi4uXQ0KPiAN
Cj4gPiArKysgYi9kcml2ZXJzL2NyeXB0by9hc3BlZWQvS2NvbmZpZw0KPiA+IEBAIC0wLDAgKzEs
MjMgQEANCj4gPiArY29uZmlnIENSWVBUT19ERVZfQVNQRUVEDQo+ID4gKwl0cmlzdGF0ZSAiU3Vw
cG9ydCBmb3IgQXNwZWVkIGNyeXB0b2dyYXBoaWMgZW5naW5lIGRyaXZlciINCj4gPiArCWRlcGVu
ZHMgb24gQVJDSF9BU1BFRUQNCj4gPiArCWhlbHANCj4gPiArCSAgSGFzaCBhbmQgQ3J5cHRvIEVu
Z2luZSAoSEFDRSkgaXMgZGVzaWduZWQgdG8gYWNjZWxlcmF0ZSB0aGUNCj4gPiArCSAgdGhyb3Vn
aHB1dCBvZiBoYXNoIGRhdGEgZGlnZXN0LCBlbmNyeXB0aW9uIGFuZCBkZWNyeXB0aW9uLg0KPiA+
ICsNCj4gPiArCSAgU2VsZWN0IHkgaGVyZSB0byBoYXZlIHN1cHBvcnQgZm9yIHRoZSBjcnlwdG9n
cmFwaGljIGRyaXZlcg0KPiA+ICsJICBhdmFpbGFibGUgb24gQXNwZWVkIFNvQy4NCj4gPiArDQo+
ID4gK2NvbmZpZyBDUllQVE9fREVWX0FTUEVFRF9IQUNFX0hBU0gNCj4gPiArCWJvb2wgIkVuYWJs
ZSBBU1BFRUQgSGFzaCAmIENyeXB0byBFbmdpbmUgKEhBQ0UpIGhhc2giDQo+IA0KPiBOaXQ6IFNv
bWV0aW1lcyB5b3UgaGF2ZSBBU1BFRUQsIHNvbWV0aW1lcyB5b3UgaGF2ZSBBc3BlZWQuIChzZWUg
YSBmZXcgbGluZXMNCj4gYWJvdmUpDQo+IA0KDQpJJ2xsIGFsaWduIGl0IGZvciBuZXh0IHBhdGNo
Lg0KDQo+IFsuLi5dDQo+IA0KPiA+ICtzdGF0aWMgaW50IGFzcGVlZF9haGFzaF9yZXFfdXBkYXRl
KHN0cnVjdCBhc3BlZWRfaGFjZV9kZXYgKmhhY2VfZGV2KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3Qg
YXNwZWVkX2VuZ2luZV9oYXNoICpoYXNoX2VuZ2luZSA9ICZoYWNlX2Rldi0+aGFzaF9lbmdpbmU7
DQo+ID4gKwlzdHJ1Y3QgYWhhc2hfcmVxdWVzdCAqcmVxID0gaGFzaF9lbmdpbmUtPnJlcTsNCj4g
PiArCXN0cnVjdCBhc3BlZWRfc2hhbV9yZXFjdHggKnJjdHggPSBhaGFzaF9yZXF1ZXN0X2N0eChy
ZXEpOw0KPiA+ICsJYXNwZWVkX2hhY2VfZm5fdCByZXN1bWU7DQo+ID4gKw0KPiA+ICsJQUhBU0hf
REJHKGhhY2VfZGV2LCAiXG4iKTsNCj4gPiArDQo+ID4gKwlpZiAoaGFjZV9kZXYtPnZlcnNpb24g
PT0gQVNUMjYwMF9WRVJTSU9OKSB7DQo+ID4gKwkJcmN0eC0+Y21kIHw9IEhBU0hfQ01EX0hBU0hf
U1JDX1NHX0NUUkw7DQo+ID4gKwkJcmVzdW1lID0gYXNwZWVkX2FoYXNoX3VwZGF0ZV9yZXN1bWVf
c2c7DQo+ID4gKw0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQlyZXN1bWUgPSBhc3BlZWRfYWhhc2hf
dXBkYXRlX3Jlc3VtZTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwloYXNoX2VuZ2luZS0+ZG1hX3By
ZXBhcmUoaGFjZV9kZXYpOw0KPiANCj4gQXBwYXJlbnRseSBkbWFfcHJlcGFyZSgpIGNhbiBmYWls
LiBTaG91bGQgdGhlcmUgYmUgc29tZSBlcnJvciBoYW5kbGluZyBoZXJlPw0KDQpZZXMsIGl0IHNo
b3VsZC4gSSdsbCBhZGQgaXQgZm9yIG5leHQgcGF0Y2guDQoNCj4gDQo+ID4gKw0KPiA+ICsJcmV0
dXJuIGFzcGVlZF9oYWNlX2FoYXNoX3RyaWdnZXIoaGFjZV9kZXYsIHJlc3VtZSk7IH0NCj4gPiAr
DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiArc3RhdGljIGludCBhc3BlZWRfaGFjZV9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSB7DQo+ID4gKwljb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNl
X2lkICpoYWNlX2Rldl9pZDsNCj4gPiArCXN0cnVjdCBhc3BlZWRfZW5naW5lX2hhc2ggKmhhc2hf
ZW5naW5lOw0KPiA+ICsJc3RydWN0IGFzcGVlZF9oYWNlX2RldiAqaGFjZV9kZXY7DQo+ID4gKwlz
dHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gPiArCWludCByYzsNCj4gPiArDQo+ID4gKwloYWNlX2Rl
diA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2Yoc3RydWN0IGFzcGVlZF9oYWNlX2Rl
diksDQo+ID4gKwkJCQlHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghaGFjZV9kZXYpDQo+ID4gKwkJ
cmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsJaGFjZV9kZXZfaWQgPSBvZl9tYXRjaF9kZXZp
Y2UoYXNwZWVkX2hhY2Vfb2ZfbWF0Y2hlcywgJnBkZXYtPmRldik7DQo+ID4gKwlpZiAoIWhhY2Vf
ZGV2X2lkKSB7DQo+ID4gKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiRmFpbGVkIHRvIG1hdGNoIGhh
Y2UgZGV2IGlkXG4iKTsNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPiArDQo+
ID4gKwloYWNlX2Rldi0+ZGV2ID0gJnBkZXYtPmRldjsNCj4gPiArCWhhY2VfZGV2LT52ZXJzaW9u
ID0gKHVuc2lnbmVkIGxvbmcpaGFjZV9kZXZfaWQtPmRhdGE7DQo+ID4gKwloYXNoX2VuZ2luZSA9
ICZoYWNlX2Rldi0+aGFzaF9lbmdpbmU7DQo+ID4gKw0KPiA+ICsJcmVzID0gcGxhdGZvcm1fZ2V0
X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gPiArDQo+ID4gKwlwbGF0Zm9y
bV9zZXRfZHJ2ZGF0YShwZGV2LCBoYWNlX2Rldik7DQo+ID4gKw0KPiA+ICsJLyogSW5pdGlhbGl6
ZSBjcnlwdG8gaGFyZHdhcmUgZW5naW5lIHN0cnVjdHVyZSBmb3IgaGFzaCAqLw0KPiA+ICsJaGFj
ZV9kZXYtPmNyeXB0X2VuZ2luZV9oYXNoID0gY3J5cHRvX2VuZ2luZV9hbGxvY19pbml0KGhhY2Vf
ZGV2LT5kZXYsDQo+ID4gKwkJCQkJCQkgICAgICAgdHJ1ZSk7DQo+IA0KPiBUaGlzIHJldHVybnMg
TlVMTCBvbiBlcnJvciBhbmQgY3J5cHRvX2VuZ2luZV9zdGFydCgpIHdpbGwgY3Jhc2ggaW4gc3Vj
aCBhIGNhc2UuDQoNCkknbGwgcmV2aXNlIGl0IGFsc28sIHRoYW5rcy4NCg0KPiANCj4gPiArDQo+
ID4gKwlyYyA9IGNyeXB0b19lbmdpbmVfc3RhcnQoaGFjZV9kZXYtPmNyeXB0X2VuZ2luZV9oYXNo
KTsNCj4gPiArCWlmIChyYykNCj4gPiArCQlnb3RvIGVycl9lbmdpbmVfaGFzaF9zdGFydDsNCj4g
PiArDQo+ID4gKwl0YXNrbGV0X2luaXQoJmhhc2hfZW5naW5lLT5kb25lX3Rhc2ssIGFzcGVlZF9o
YWNlX2hhc2hfZG9uZV90YXNrLA0KPiA+ICsJCSAgICAgKHVuc2lnbmVkIGxvbmcpaGFjZV9kZXYp
Ow0KPiA+ICsNCj4gPiArCWhhY2VfZGV2LT5yZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZw
ZGV2LT5kZXYsIHJlcyk7DQo+ID4gKwlpZiAoIWhhY2VfZGV2LT5yZWdzKSB7DQo+ID4gKwkJZGV2
X2VycigmcGRldi0+ZGV2LCAiRmFpbGVkIHRvIG1hcCByZXNvdXJjZXNcbiIpOw0KPiA+ICsJCXJl
dHVybiAtRU5PTUVNOw0KPiANCj4gSSB0aGluayB0aGF0IGFsbCBkaXJlY3QgcmV0dXJucyBmcm9t
IGhlcmUgdG8gdGhlIGVuZCBvZiB0aGUgZnVuY3Rpb24gc2hvdWxkIGJlDQo+ICJnb3RvIGVycl9l
bmdpbmVfaGFzaF9zdGFydDsiLg0KDQpJJ2xsIG1vdmUgY3J5cHRvIGVuZ2luZSBzdGFydCBzdHVm
ZnMgdG8gYmVsb3csIHNvIGFsbCB0aGVzZSByZXR1cm5zIGNhbiBzdGF5IHRoZSBzYW1lLg0KDQo+
IA0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCS8qIEdldCBpcnEgbnVtYmVyIGFuZCByZWdpc3RlciBp
dCAqLw0KPiA+ICsJaGFjZV9kZXYtPmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQo+
ID4gKwlpZiAoIWhhY2VfZGV2LT5pcnEpIHsNCj4gPiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJG
YWlsZWQgdG8gZ2V0IGludGVycnVwdFxuIik7DQo+ID4gKwkJcmV0dXJuIC1FTlhJTzsNCj4gPiAr
CX0NCj4gPiArDQo+ID4gKwlyYyA9IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgaGFjZV9k
ZXYtPmlycSwgYXNwZWVkX2hhY2VfaXJxLCAwLA0KPiA+ICsJCQkgICAgICBkZXZfbmFtZSgmcGRl
di0+ZGV2KSwgaGFjZV9kZXYpOw0KPiA+ICsJaWYgKHJjKSB7DQo+ID4gKwkJZGV2X2VycigmcGRl
di0+ZGV2LCAiRmFpbGVkIHRvIHJlcXVlc3QgaW50ZXJydXB0XG4iKTsNCj4gPiArCQlyZXR1cm4g
cmM7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJLyogR2V0IGNsayBhbmQgZW5hYmxlIGl0ICovDQo+
ID4gKwloYWNlX2Rldi0+Y2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsIE5VTEwpOw0KPiA+
ICsJaWYgKElTX0VSUihoYWNlX2Rldi0+Y2xrKSkgew0KPiA+ICsJCWRldl9lcnIoJnBkZXYtPmRl
diwgIkZhaWxlZCB0byBnZXQgY2xrXG4iKTsNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiAr
CX0NCj4gPiArDQo+ID4gKwlyYyA9IGNsa19wcmVwYXJlX2VuYWJsZShoYWNlX2Rldi0+Y2xrKTsN
Cj4gPiArCWlmIChyYykgew0KPiA+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgIkZhaWxlZCB0byBl
bmFibGUgY2xvY2sgMHgleFxuIiwgcmMpOw0KPiA+ICsJCXJldHVybiByYzsNCj4gPiArCX0NCj4g
PiArDQo+ID4gKwkvKiBBbGxvY2F0ZSBETUEgYnVmZmVyIGZvciBoYXNoIGVuZ2luZSBpbnB1dCB1
c2VkICovDQo+ID4gKwloYXNoX2VuZ2luZS0+YWhhc2hfc3JjX2FkZHIgPQ0KPiA+ICsJCWRtYV9h
bGxvY19jb2hlcmVudCgmcGRldi0+ZGV2LA0KPiA+ICsJCQkJICAgQVNQRUVEX0hBU0hfU1JDX0RN
QV9CVUZfTEVOLA0KPiA+ICsJCQkJICAgJmhhc2hfZW5naW5lLT5haGFzaF9zcmNfZG1hX2FkZHIs
DQo+ID4gKwkJCQkgICBHRlBfS0VSTkVMKTsNCj4gDQo+IE1vc3Qgb2YgdGhlIHJlc291cmNlcyBh
cmUgZGV2bV8nZWQuIERvZXMgaXQgbWFrZSBzZW5zZSB0byB1c2UNCj4gZG1hbV9hbGxvY19jb2hl
cmVudCgpIGhlcmUgdG8gc2ltcGxpZnkgdGhlIC5yZW1vdmUgZnVuY3Rpb24/DQoNClRoYW5rcyBm
b3IgdGhlIHN1Z2dlc3Rpb24uIEknbGwgdXNlIGRtYW1fYWxsb2NfY29oZXJlbnQoKSBpbnN0ZWFk
Lg0KDQo+IA0KPiA+ICsJaWYgKCFoYXNoX2VuZ2luZS0+YWhhc2hfc3JjX2FkZHIpIHsNCj4gPiAr
CQlkZXZfZXJyKCZwZGV2LT5kZXYsICJGYWlsZWQgdG8gYWxsb2NhdGUgZG1hIGJ1ZmZlclxuIik7
DQo+ID4gKwkJcmMgPSAtRU5PTUVNOw0KPiA+ICsJCWdvdG8gY2xrX2V4aXQ7DQo+ID4gKwl9DQo+
ID4gKw0KPiA+ICsJYXNwZWVkX2hhY2VfcmVnaXN0ZXIoaGFjZV9kZXYpOw0KPiA+ICsNCj4gPiAr
CWRldl9pbmZvKCZwZGV2LT5kZXYsICJBU1BFRUQgQ3J5cHRvIEFjY2VsZXJhdG9yIHN1Y2Nlc3Nm
dWxseQ0KPiA+ICtyZWdpc3RlcmVkXG4iKTsNCj4gPiArDQo+IE5pdDogU29tZXRpbWVzIHlvdSBo
YXZlIEFTUEVFRCwgc29tZXRpbWVzIHlvdSBoYXZlIEFzcGVlZC4NCj4gDQoNClNhbWUgaGVyZS4N
Cg0KPiA+ICsJcmV0dXJuIHJjOw0KPiA+ICsNCj4gPiArY2xrX2V4aXQ6DQo+ID4gKwljbGtfZGlz
YWJsZV91bnByZXBhcmUoaGFjZV9kZXYtPmNsayk7DQo+ID4gK2Vycl9lbmdpbmVfaGFzaF9zdGFy
dDoNCj4gPiArCWNyeXB0b19lbmdpbmVfZXhpdChoYWNlX2Rldi0+Y3J5cHRfZW5naW5lX2hhc2gp
Ow0KPiA+ICsNCj4gPiArCXJldHVybiByYzsNCj4gPiArfQ0KPiA+ICsNCj4gDQo+IFsuLi5dDQo+
IA0KPiA+ICtNT0RVTEVfQVVUSE9SKCJOZWFsIExpdQ0KPiA+ICs8bmVhbF9saXUtU0FsWERtQW5t
T0FxREo2ZG8rL1NhUUBwdWJsaWMuZ21hbmUub3JnPiIpOw0KPiA+ICtNT0RVTEVfREVTQ1JJUFRJ
T04oIkFTUEVFRCBIQUNFIGRyaXZlciBDcnlwdG8gQWNjZWxlcmF0b3IiKTsNCj4gDQo+IE5pdDog
U29tZXRpbWVzIHlvdSBoYXZlIEFTUEVFRCwgc29tZXRpbWVzIHlvdSBoYXZlIEFzcGVlZC4NCg0K
U2FtZSBoZXJlLg0KDQo=
