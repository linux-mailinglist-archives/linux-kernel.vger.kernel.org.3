Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE16B53B3A0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiFBGev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiFBGes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:34:48 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2111.outbound.protection.outlook.com [40.107.255.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DB721D4B2;
        Wed,  1 Jun 2022 23:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEojlJXP8E7bynyhl3WQNVEQqkw//EsNPNvMCJkphicq0OiZ6/HkRPe1MDIVm0ujlFIBMeOeDOhmxuLw/nY4P1HEtBBSKi5zZhBY1mPzqvzCqv26K/mFGh+Xe5oguUVqVONkOI9GIfOtqfQ/irBJ2biZYBH2c6Tovlvh1nVX7+kPgM3E3wfPG4Rnu6BTdKl55jlkG+tQpY5fQfCPN2AcT/GeFkV1rmKR4rNN8PwlHZFVgaQ95KND4VnWoQIk9zqW6KGyZOv03RY/zl2N146OPD9byg5EnJVFE+V7dplZV4VqETUirMo6tIqBJer1pp9eFkDruc/fiBIQJbFnv1Yn1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0EOc1X0k15ahJi5YRyOYV0Sts8fuf7S+KagChawD+U=;
 b=NVVobBrmuGhxiPuPTfQc5l6ZZ7oXvEC56ZEHaXWAq+pmoL6C0eRcDOR6oIBJoQmC6B8Zk55ZkEwRVZtu6NXcI7Q7Owqo94pzP5zG8bo21ALs+m0SCAxQ5nq9kHZGLSNqmTjpnJNrdoChtKDKTRe5z4Kp7xgTvdHvzii8aJ0UDf1Q4/NRsDqCtS8lLqaxBJ7Bya5+JeSDMTgWePyzLzIQiM8VSF6kRen8LJ+XxBzZQGwxHvGFBWvaLR3rs8KrUQ1hDBF/aKMKLBDG499Sm1A9HthrvljJLY4+/6vMAx/tXlpcdZWPSpWCJIn24GgUhTuhlJ6n+tJcDNQdu44a3kNNEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0EOc1X0k15ahJi5YRyOYV0Sts8fuf7S+KagChawD+U=;
 b=g889zCZEsMH1U71pbglhHPBiIP3DvyZkcJYWSz2UwX7gZWLEV8F6Ypu/QSMxZ5cR5JlO0yhhLfOo5QEam2WX17JENT33K+eQ3NXNHKJKW8oYI9HEJGjP1e6FCWLfXheNooNenEpJvxLDr5iJLH+HspuEYGVbOE3NlpXh7Zc/S48vBwURNhPFl1Fdz2uPqCEUuFEMHWEfstKjdXaxEGW2e+B1v95JtuItxiYeJQRNSav/J5lVRG+xEeZc5vhQ415tMNqAgo6GTFQNXN6kdiLuFDDi5ZBN+/EWyOf/In572EEiGHxaRsmPtwrejbUwsao9x4SmudHs9aSXnQbaqcJVxA==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by PSAPR06MB4792.apcprd06.prod.outlook.com (2603:1096:301:9d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 06:34:40 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237%7]) with mapi id 15.20.5293.019; Thu, 2 Jun 2022
 06:34:40 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/5] crypto: aspeed: Add HACE hash driver
Thread-Topic: [PATCH 1/5] crypto: aspeed: Add HACE hash driver
Thread-Index: AQHYdXpgV+xzTk0fKkKH13lAbtmvOa06/V4AgACoZ/A=
Date:   Thu, 2 Jun 2022 06:34:39 +0000
Message-ID: <HK0PR06MB320268D5DCFB8FF3B4D8EB5E80DE9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
 <20220601054204.1522976-2-neal_liu@aspeedtech.com>
 <dd525d8b-3cb3-e843-4a79-64f50c0fe8a7@wanadoo.fr>
In-Reply-To: <dd525d8b-3cb3-e843-4a79-64f50c0fe8a7@wanadoo.fr>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b86ec70-5f4e-45a8-faf5-08da4461f899
x-ms-traffictypediagnostic: PSAPR06MB4792:EE_
x-microsoft-antispam-prvs: <PSAPR06MB4792D2C862C5DF69C617592E80DE9@PSAPR06MB4792.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fm/AXQojgsJfiwjmCpaOcQMyYwcUGj9pMgyG3LYZ3oQKhlhUQwMXW3XzI3q/C6OGdLcWgZ+Ut7qwYgEQjIwi4bo8+6+H4bqBTkUlpk/nzaz7gJbf7Kb3c7ZLM/l0sj1p27HePKoRJOUnpNaIJTzYv5WxFqcU1A9gFP55gWT1SARcW3IBgTVnwOxbisgYilPE1da2sk9NVdTWByYWvS/CBwRItIpvrCwT9VK8RLCdXd2+4cPT4bPp6tSa11FeK/9JzXJIqVan+2yH46vkf4u4OoqvuRPT9pAA6FfERxHYCDTGwZAe+oXr6OJ7NSWdqGWYAxddu0rMV4I42JuhSUwnJdhgjBsTh86hwpDkSvLKwB6DUdYES4yXpWfM1SwmXrainKGVSuKetegYkvuWZVBh4Xc9+vKfW0CyxT4qi7aZquygMks4ktopxTS6hsWOJr5j1uzEIlGKr0pouRCG/IbA97I/EHPRizPdD7oLDzUhnUvZ7i1ZIO8NBnvoNjqA92VZuIi9kOqgicEfmBrFu6gOzy8pbV4YzXYuiHhWW9xlzty7M7Of1XLIhNSM4v4BLItneRvy9T4xJOHutVHDBEPh7TGE3SO6tq2NGkHZJkKUS97IUTC83x/WKeBQ4zOi10b/3bHi93yq5o0Ki5Cv7g6BT1NLCCI+CHZAeNvdrlm0mNJsvGvfFqbjsPIwnIZ8LxwKYJvhalaGMDULpyh5ujtOlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(366004)(136003)(39850400004)(376002)(346002)(64756008)(38070700005)(122000001)(186003)(66574015)(83380400001)(8676002)(4326008)(2906002)(8936002)(7416002)(33656002)(5660300002)(52536014)(55016003)(41300700001)(54906003)(66446008)(66556008)(71200400001)(110136005)(6506007)(7696005)(66476007)(9686003)(26005)(76116006)(66946007)(38100700002)(86362001)(6636002)(508600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXRVQ0hldTlaNzR2K0xJcFZqZWx1YzEzTmtzM2NpcDBPS0QxUGVxRzJ2c1dt?=
 =?utf-8?B?WHJodHRUQjE2S0FTbkl4b1BlS1NnR01jSW9LREE2NVVCWTNlbi82dnZaS1RU?=
 =?utf-8?B?aHliM1dZWTcwdndaSU5zR25ZN2xUdXZqdFA4UGMwZ0lsZVY2eE1HZkxPekRF?=
 =?utf-8?B?NjNrSVppYXlhNVVOSkVPZTRJQ1dOMzRFZnRaNWVOTkp4OTVNeWF1aUZLSy9Z?=
 =?utf-8?B?Z3pkSURrUE80QlFHSUt2UUhvL0o4YUJhYksrQnNVckhvbUg4cHZWM0lxQk9M?=
 =?utf-8?B?aXp5Wkl3bUtyajd5UEo1UmpxYVVTRWxRNmpQOHdFdXB6NStvMHVwRkVxNWo2?=
 =?utf-8?B?WFlmWlN5dHRxMVlKU1RhcmRQNk1Xb2lyVVB4TjNaWm9LSHdxVkZxNU1oQVhi?=
 =?utf-8?B?ZlUrRnhKTzZibXZjTk1oRG9QcHo2NHUzN2wxNjdma054MG5SSXV1Skk0TGhm?=
 =?utf-8?B?bnhnUjY1RnIyL0pCYTZxenBINUtETmhVbjY5MlVNM2dGaDY0SWE2dnJXV3Vp?=
 =?utf-8?B?RTFtWk5lQkZxN2g3UkJTc0ZlTno1UXlYd21tdFRaTkF1bWFqcmdzTlY5QWRs?=
 =?utf-8?B?M0pka3ZGc1NnUnY1Tk1JT0gyM1JDQTg5RmxoKzhhc3FhZ0UydmM5cU9JQUdN?=
 =?utf-8?B?VjA0NUZYeVdpSXVMcWVTZm1JMnlBb2FhV0V1WlJhRjY0cms3WHdxSkFwblF4?=
 =?utf-8?B?RGVLYjZBanUySXdrSW05N0JnMi9CV2R2d0dRbXRFYkJURERXaHAzdHR1dElK?=
 =?utf-8?B?Tkh3RVh2WFEyZjFYbEZOK2I0UWVlZkNmVXU4TzhicXRXemdtaWNFRU42T2g4?=
 =?utf-8?B?NVVxQzNmY25CYk9nUEV0M1VWQUtPa2dPbWFUemRxVHJCNEtWWklNcmo1bTJR?=
 =?utf-8?B?Q0lybW1FUjNQTlQwejBId1NJQlRPemNIbUZFNGY4UDZtQi9nUmlLNGVVeEdx?=
 =?utf-8?B?bTFhb1Jkb0lTVWVQdU5zQUpnT2VJOXFjR3dic1o1d2lQQWgraWFDU3VEY3dJ?=
 =?utf-8?B?KzVOZEVuUFpaZjV3UkNWM1V1SWw2VURMQWR6V2laU1NPaVEwVytGWEVCZEFy?=
 =?utf-8?B?cUpIQnNpV3Z3My8zMTBUMHlZa1ovemtUZUZiVm1kVjVoV3VYRytuYXhlbUQw?=
 =?utf-8?B?V1ZyWUdkbFF3OElzV3JiemtHYmszNFd1TThnbzdsbC9tVnlPQlcxTU9sdng1?=
 =?utf-8?B?OWZkRlB6TTZWTGZ6bUc5d3o3bFR3UTM3YzZxVkF5bCtsTFZldExtVmFZOFRE?=
 =?utf-8?B?RDl1TlVyWkxDWktaU2JXbkdyV0lxcEZLRE1naW5hbDNNWFJCNUVBQ0VER3ho?=
 =?utf-8?B?YmtBMTFQbmlRNGErNnhkR0ZDQXEwVHFwcThySXg0ZjdlSzIzSHlQTncxRzk3?=
 =?utf-8?B?V1d2QzB0T2xuanhGMkpJcjhaUUlPRjRFUEFRUnZlczVZZm1RbzZBU01pakV1?=
 =?utf-8?B?TUdCblZWbmJrMFRvOENCVWRvRHFZakdVb3F5TzBkVDlDM0xKT0tQdkFvekgv?=
 =?utf-8?B?dXdzbytJUFEwTnU0ditsNkNMSHlsRjVVcFdtOElKdDRpcjBoTkVkd3NWZjVD?=
 =?utf-8?B?blNwMzVWenRzait4VkR5Q1oxT1RvRzJqTUFXdktPeGtKZ2ZmbnVqTm0yYnA4?=
 =?utf-8?B?VERUV1FkUGJvSTlsQ0xjay90U2pxTSs5L3hQY2crbWZ6QnppUm12b0FNVW1h?=
 =?utf-8?B?dkNMUi9PMHFOeEhVd3lGNG5UN3VYZThyeVVtVnZ3akVsRkwxOTdhZjJab3pa?=
 =?utf-8?B?Yksvem1YOTE3VTA3dmR2TjREdG02L1U2cXdoQmhtQjhPcWRtVEg5eGxzdDdl?=
 =?utf-8?B?WlRINVN1cFNnUyt4QUNZQllNaWFBTk1iU0NRbVFQemRqdEZrdmJSNFBEZVhq?=
 =?utf-8?B?TkRlRTNYcWEzbC9TSzlVUkYvb1BUeWRMYkorYmNNcWR2cFV5Y05vN0tOQkUy?=
 =?utf-8?B?N1dxa3ovd2h0TmRpRjlzbXZDeGlkcGpmNk5lNXFTazlCVUprMlZBc0EyZmhG?=
 =?utf-8?B?bnR5K25sUnA2SXZ0OEphOG81ZzlmVWQvejZpQ3dvUG9ENFp4Q21SU2JJY0xl?=
 =?utf-8?B?ZkdpRkNLbTFyekxNcGwzRUpNRWRzWU1oTDdzVWpPenZiNnZhK0lXak9vTWlY?=
 =?utf-8?B?dUVhaWJ0SE5PUzhiVzBiQiszZW5oMHFUUm9VNlhBY1V4NUhvTk4wRE5sR1Mz?=
 =?utf-8?B?UE1aWmJwZW1wQmlSS1R6M3hEQzZ6WjVyNEt1N2p2aDdKNnFlc2NNRkJZakZa?=
 =?utf-8?B?NGhRRlI4d1QxZHFpS2htVjNvRnhDc2JGN0NyN2RlNHQwWWF3VW1HMzJjalpz?=
 =?utf-8?B?dnQxMWhNT0t1NU1jNVpaZVAveTNlSjgreUZyek13R29Cdm5xenlSSkVtOWVp?=
 =?utf-8?Q?bmbfnqt8Soa7cedU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b86ec70-5f4e-45a8-faf5-08da4461f899
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 06:34:39.9547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gaZ/ilAJDCpvEZI/2qPGejOzXdRFJHpTRKN98H71aQYzgbem27xDbsq3SIqPxI1/QAgEHmjFX/Z60tEc/n8tCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4792
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSwNCj4gDQo+IExlIDAxLzA2LzIwMjIgw6AgMDc6NDIsIE5lYWwgTGl1IGEgw6ljcml0wqA6
DQo+ID4gSGFzaCBhbmQgQ3J5cHRvIEVuZ2luZSAoSEFDRSkgaXMgZGVzaWduZWQgdG8gYWNjZWxl
cmF0ZSB0aGUgdGhyb3VnaHB1dA0KPiA+IG9mIGhhc2ggZGF0YSBkaWdlc3QsIGVuY3J5cHRpb24s
IGFuZCBkZWNyeXB0aW9uLg0KPiA+DQo+ID4gQmFzaWNhbGx5LCBIQUNFIGNhbiBiZSBkaXZpZGVk
IGludG8gdHdvIGluZGVwZW5kZW50bHkgZW5naW5lcw0KPiA+IC0gSGFzaCBFbmdpbmUgYW5kIENy
eXB0byBFbmdpbmUuIFRoaXMgcGF0Y2ggYWltcyB0byBhZGQgSEFDRSBoYXNoDQo+ID4gZW5naW5l
IGRyaXZlciBmb3IgaGFzaCBhY2NlbGVyYXRvci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5l
YWwgTGl1IDxuZWFsX2xpdUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2hu
bnkgSHVhbmcgPGpvaG5ueV9odWFuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIE1B
SU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA3ICsNCj4gPiAgIGRy
aXZlcnMvY3J5cHRvL0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAgICAxICsNCj4gPiAgIGRy
aXZlcnMvY3J5cHRvL01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAgICAxICsNCj4gPiAgIGRy
aXZlcnMvY3J5cHRvL2FzcGVlZC9LY29uZmlnICAgICAgICAgICAgfCAgIDIyICsNCj4gPiAgIGRy
aXZlcnMvY3J5cHRvL2FzcGVlZC9NYWtlZmlsZSAgICAgICAgICAgfCAgICA2ICsNCj4gPiAgIGRy
aXZlcnMvY3J5cHRvL2FzcGVlZC9hc3BlZWQtaGFjZS1oYXNoLmMgfCAxMzM1DQo+ICsrKysrKysr
KysrKysrKysrKysrKysNCj4gPiAgIGRyaXZlcnMvY3J5cHRvL2FzcGVlZC9hc3BlZWQtaGFjZS5j
ICAgICAgfCAgMjEwICsrKysNCj4gPiAgIGRyaXZlcnMvY3J5cHRvL2FzcGVlZC9hc3BlZWQtaGFj
ZS5oICAgICAgfCAgMTc5ICsrKw0KPiA+ICAgOCBmaWxlcyBjaGFuZ2VkLCAxNzYxIGluc2VydGlv
bnMoKykNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2NyeXB0by9hc3BlZWQvS2Nv
bmZpZw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY3J5cHRvL2FzcGVlZC9NYWtl
ZmlsZQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY3J5cHRvL2FzcGVlZC9hc3Bl
ZWQtaGFjZS1oYXNoLmMNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2NyeXB0by9h
c3BlZWQvYXNwZWVkLWhhY2UuYw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY3J5
cHRvL2FzcGVlZC9hc3BlZWQtaGFjZS5oDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5F
UlMgYi9NQUlOVEFJTkVSUyBpbmRleA0KPiA+IGU4YzUyZDAxOTJhNi4uYzAyMGUwODkzZWVkIDEw
MDY0NA0KPiANCj4gWy4uLl0NCj4gDQo+ID4gK2ludCBhc3BlZWRfcmVnaXN0ZXJfaGFjZV9oYXNo
X2FsZ3Moc3RydWN0IGFzcGVlZF9oYWNlX2RldiAqaGFjZV9kZXYpDQo+ID4gK3sNCj4gPiArCWlu
dCByYywgaTsNCj4gPiArDQo+ID4gKwlBSEFTSF9EQkcoaGFjZV9kZXYsICJcbiIpOw0KPiA+ICsN
Cj4gPiArCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGFzcGVlZF9haGFzaF9hbGdzKTsgaSsr
KSB7DQo+ID4gKwkJYXNwZWVkX2FoYXNoX2FsZ3NbaV0uaGFjZV9kZXYgPSBoYWNlX2RldjsNCj4g
PiArCQlyYyA9IGNyeXB0b19yZWdpc3Rlcl9haGFzaCgmYXNwZWVkX2FoYXNoX2FsZ3NbaV0uYWxn
LmFoYXNoKTsNCj4gPiArCQlpZiAocmMpDQo+ID4gKwkJCXJldHVybiByYzsNCj4gPiArCX0NCj4g
PiArDQo+ID4gKwlpZiAoaGFjZV9kZXYtPnZlcnNpb24gIT0gQVNUMjYwMF9WRVJTSU9OKQ0KPiA+
ICsJCXJldHVybiAwOw0KPiA+ICsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGFz
cGVlZF9haGFzaF9hbGdzX2c2KTsgaSsrKSB7DQo+ID4gKwkJYXNwZWVkX2FoYXNoX2FsZ3NfZzZb
aV0uaGFjZV9kZXYgPSBoYWNlX2RldjsNCj4gPiArCQlyYyA9IGNyeXB0b19yZWdpc3Rlcl9haGFz
aCgmYXNwZWVkX2FoYXNoX2FsZ3NfZzZbaV0uYWxnLmFoYXNoKTsNCj4gPiArCQlpZiAocmMpDQo+
ID4gKwkJCXJldHVybiByYzsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gDQo+
IFNob3VsZCB0aGVyZSBiZSBzb21lIGtpbmQgb2YgZXJyb3IgaGFuZGxpbmcgaGVyZSwgaW4gb3Jk
ZXIgdG8gdW5kbyB0aGluZ3MNCj4gYWxyZWFkeSBkb25lIGlmIGFuIGVycm9yIG9jY3VyZXM/DQo+
IA0KDQpObyBuZWVkLiAucmVtb3ZlIGZ1bmN0aW9uIHdvdWxkIGRvIHRoZSBlcnJvciBoYW5kbGlu
ZyBzdHVmZnMuDQoNCj4gDQo+ID4gK30NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8v
YXNwZWVkL2FzcGVlZC1oYWNlLmMNCj4gYi9kcml2ZXJzL2NyeXB0by9hc3BlZWQvYXNwZWVkLWhh
Y2UuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5m
MjViMTNkMTIwZTgNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9jcnlwdG8v
YXNwZWVkL2FzcGVlZC1oYWNlLmMNCj4gDQo+IFsuLi5dDQo+IA0KPiA+ICtzdGF0aWMgaW50IGFz
cGVlZF9oYWNlX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gK3sNCj4g
PiArCWNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKmhhY2VfZGV2X2lkOw0KPiA+ICsJc3RydWN0
IGFzcGVlZF9lbmdpbmVfaGFzaCAqaGFzaF9lbmdpbmU7DQo+ID4gKwlzdHJ1Y3QgYXNwZWVkX2hh
Y2VfZGV2ICpoYWNlX2RldjsNCj4gPiArCXN0cnVjdCByZXNvdXJjZSAqcmVzOw0KPiA+ICsJaW50
IHJjOw0KPiA+ICsNCj4gPiArCWhhY2VfZGV2ID0gZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHNp
emVvZihzdHJ1Y3QgYXNwZWVkX2hhY2VfZGV2KSwNCj4gPiArCQkJCUdGUF9LRVJORUwpOw0KPiA+
ICsJaWYgKCFoYWNlX2RldikNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKwlo
YWNlX2Rldl9pZCA9IG9mX21hdGNoX2RldmljZShhc3BlZWRfaGFjZV9vZl9tYXRjaGVzLCAmcGRl
di0+ZGV2KTsNCj4gPiArCWlmICghaGFjZV9kZXZfaWQpIHsNCj4gPiArCQlkZXZfZXJyKCZwZGV2
LT5kZXYsICJGYWlsZWQgdG8gbWF0Y2ggaGFjZSBkZXYgaWRcbiIpOw0KPiA+ICsJCXJldHVybiAt
RUlOVkFMOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWhhY2VfZGV2LT5kZXYgPSAmcGRldi0+ZGV2
Ow0KPiA+ICsJaGFjZV9kZXYtPnZlcnNpb24gPSAodW5zaWduZWQgbG9uZyloYWNlX2Rldl9pZC0+
ZGF0YTsNCj4gPiArCWhhc2hfZW5naW5lID0gJmhhY2VfZGV2LT5oYXNoX2VuZ2luZTsNCj4gPiAr
DQo+ID4gKwlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0s
IDApOw0KPiA+ICsNCj4gPiArCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGhhY2VfZGV2KTsN
Cj4gPiArDQo+ID4gKwlzcGluX2xvY2tfaW5pdCgmaGFzaF9lbmdpbmUtPmxvY2spOw0KPiA+ICsJ
dGFza2xldF9pbml0KCZoYXNoX2VuZ2luZS0+ZG9uZV90YXNrLCBhc3BlZWRfaGFjZV9oYXNoX2Rv
bmVfdGFzaywNCj4gPiArCQkgICAgICh1bnNpZ25lZCBsb25nKWhhY2VfZGV2KTsNCj4gPiArCXRh
c2tsZXRfaW5pdCgmaGFzaF9lbmdpbmUtPnF1ZXVlX3Rhc2ssIGFzcGVlZF9oYWNlX2hhc2hfcXVl
dWVfdGFzaywNCj4gPiArCQkgICAgICh1bnNpZ25lZCBsb25nKWhhY2VfZGV2KTsNCj4gPiArCWNy
eXB0b19pbml0X3F1ZXVlKCZoYXNoX2VuZ2luZS0+cXVldWUsDQo+IEFTUEVFRF9IQVNIX1FVRVVF
X0xFTkdUSCk7DQo+ID4gKw0KPiA+ICsJaGFjZV9kZXYtPnJlZ3MgPSBkZXZtX2lvcmVtYXBfcmVz
b3VyY2UoJnBkZXYtPmRldiwgcmVzKTsNCj4gPiArCWlmICghaGFjZV9kZXYtPnJlZ3MpIHsNCj4g
PiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJGYWlsZWQgdG8gbWFwIHJlc291cmNlc1xuIik7DQo+
ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaGFjZV9kZXYtPmly
cSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQo+ID4gKwlpZiAoIWhhY2VfZGV2LT5pcnEp
IHsNCj4gPiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJGYWlsZWQgdG8gZ2V0IGludGVycnVwdFxu
Iik7DQo+ID4gKwkJcmV0dXJuIC1FTlhJTzsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyYyA9IGRl
dm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgaGFjZV9kZXYtPmlycSwgYXNwZWVkX2hhY2VfaXJx
LCAwLA0KPiA+ICsJCQkgICAgICBkZXZfbmFtZSgmcGRldi0+ZGV2KSwgaGFjZV9kZXYpOw0KPiA+
ICsJaWYgKHJjKSB7DQo+ID4gKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiRmFpbGVkIHRvIHJlcXVl
c3QgaW50ZXJydXB0XG4iKTsNCj4gPiArCQlyZXR1cm4gcmM7DQo+ID4gKwl9DQo+ID4gKw0KPiA+
ICsJaGFjZV9kZXYtPnljbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgInljbGsiKTsNCj4g
PiArCWlmIChJU19FUlIoaGFjZV9kZXYtPnljbGspKSB7DQo+ID4gKwkJZGV2X2VycigmcGRldi0+
ZGV2LCAiRmFpbGVkIHRvIGdldCB5Y2xrXG4iKTsNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4g
PiArCX0NCj4gPiArDQo+ID4gKwlyYyA9IGNsa19wcmVwYXJlX2VuYWJsZShoYWNlX2Rldi0+eWNs
ayk7DQo+ID4gKwlpZiAocmMpIHsNCj4gPiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJGYWlsZWQg
dG8gZW5hYmxlIGNsb2NrIDB4JXhcbiIsIHJjKTsNCj4gPiArCQlyZXR1cm4gcmM7DQo+IA0KPiBU
aGlzIGlzIG5vdCB1bmRvbmUsIG5laXRoZXIgaWYgYW4gZXJyb3Igb2NjdXJlcyBhZnRlciBpdCwg
bm9yIGluIHRoZQ0KPiAucmVtb3ZlIGZ1bmN0aW9uLg0KDQpZb3UncmUgY29ycmVjdC4gSSdsbCBh
ZGQgZXJyb3IgaGFuZGxpbmcgaW4gLnJlbW92ZSBmdW5jdGlvbi4NClRoYW5rcyBmb3IgeW91ciBz
dWdnZXN0aW9uLg0KDQo+IA0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWhhc2hfZW5naW5lLT5haGFz
aF9zcmNfYWRkciA9DQo+ID4gKwkJZG1hX2FsbG9jX2NvaGVyZW50KCZwZGV2LT5kZXYsDQo+ID4g
KwkJCQkgICBBU1BFRURfSEFTSF9TUkNfRE1BX0JVRl9MRU4sDQo+ID4gKwkJCQkgICAmaGFzaF9l
bmdpbmUtPmFoYXNoX3NyY19kbWFfYWRkciwNCj4gPiArCQkJCSAgIEdGUF9LRVJORUwpOw0KPiA+
ICsJaWYgKCFoYXNoX2VuZ2luZS0+YWhhc2hfc3JjX2FkZHIpIHsNCj4gPiArCQlkZXZfZXJyKCZw
ZGV2LT5kZXYsICJGYWlsZWQgdG8gYWxsb2NhdGUgZG1hIGJ1ZmZlclxuIik7DQo+ID4gKwkJcmV0
dXJuIC1FTk9NRU07DQo+ID4gKwl9DQo+IA0KPiBTYW1lIGhlcmUsIHRoaXMgc2kgbm90IHVuZG9u
ZSBpbiB0aGUgLnJlbW92ZSBmdW5jdGlvbi4NCg0KU2FtZSBoZXJlLg0KDQo+IA0KPiA+ICsNCj4g
PiArCXJjID0gYXNwZWVkX2hhY2VfcmVnaXN0ZXIoaGFjZV9kZXYpOw0KPiA+ICsJaWYgKHJjKSB7
DQo+ID4gKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiRmFpbGVkIHRvIHJlZ2lzdGVyIGhhc2ggYWxn
LCByYzoweCV4XG4iLCByYyk7DQo+IA0KPiBJcyB0aGlzIHJlYWxseSBhbiBlcnJvciBpZiBmaW5h
bHkgd2UgY29udGludWUgYW5kIHJldHVybiAwIChzdWNjZXNzKSBhdA0KPiB0aGUgZW5kPw0KDQpJ
IGFzc3VtZSBpZiBzb21lIGFsZyByZWdpc3RlciBmYWlsZWQsIHNvbWUgYWxnIHJlZ2lzdGVyIHBh
c3MsIHRoZSBkcml2ZXIgc3RpbGwgd29ya3MgZmluZS4NClNvIG5vIG5lZWQgdG8gZmFpbCBkcml2
ZXIgcHJvYmUuDQoNCj4gDQo+ID4gKwkJcmMgPSAwOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWRl
dl9pbmZvKCZwZGV2LT5kZXYsICJBU1BFRUQgQ3J5cHRvIEFjY2VsZXJhdG9yIHN1Y2Nlc3NmdWxs
eQ0KPiByZWdpc3RlcmVkXG4iKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gcmM7DQo+ID4gK30NCj4g
PiArDQo+ID4gK3N0YXRpYyBpbnQgYXNwZWVkX2hhY2VfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBhc3BlZWRfaGFjZV9kZXYgKmhhY2Vf
ZGV2ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ID4gKwlzdHJ1Y3QgYXNwZWVkX2Vu
Z2luZV9oYXNoICpoYXNoX2VuZ2luZSA9ICZoYWNlX2Rldi0+aGFzaF9lbmdpbmU7DQo+ID4gKw0K
PiA+ICsJYXNwZWVkX2hhY2VfdW5yZWdpc3RlcihoYWNlX2Rldik7DQo+IA0KPiBTaG91bGQgdGhp
cyBiZSBkb25lIGV2ZW4gaWYgYXNwZWVkX2hhY2VfcmVnaXN0ZXIoKSBmYWlsZWQgaW4gdGhlIHBy
b2JlPw0KDQpDcnlwdG8gY29yZSB3b3VsZCBjaGVjayBpZiB0aGUgYWxnIGlzIHJlZ2lzdGVyZWQg
b3Igbm90LCBzbyBubyBuZWVkIHRvIGNoZWNrIGhlcmUuDQoNCj4gDQo+IEp1c3QgbXkgMmMsDQo+
IENKDQo+IA0KPiANCj4gPiArDQo+ID4gKwl0YXNrbGV0X2tpbGwoJmhhc2hfZW5naW5lLT5kb25l
X3Rhc2spOw0KPiA+ICsJdGFza2xldF9raWxsKCZoYXNoX2VuZ2luZS0+cXVldWVfdGFzayk7DQo+
ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+IA0KPiBbLi4uXQ0K
