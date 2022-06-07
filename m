Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A09E53F449
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbiFGDGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiFGDGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:06:09 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D041CFE22;
        Mon,  6 Jun 2022 20:06:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCARl7RN6CRzac07iev5PDqxWIe8SaTNnlX23nLKtcQ/IVNBl4I44G9SfOuMNUNnIkLNR7aHFYgc7hlnJFID/56RzMS+vteXOPq2nxKpT09uCTFTlCwTb1FlaR4hjbEvwtX1dNZOo0gYiTgEIo6Yv75IKtJY34KB6doUK1MUERtV9jw2RWneIt1v965B6o21G/iKtSgZDQwMTaEC2rP/3jkl0YIbQ/mT918Woc3KDglOK226QYp7tVeLDaU7vQGyf75h6b7jJCOMWEyqaEl8q9kohJ2AUe4Vpq8bmIlj45H9JLgwtMwk2wonmBWPmUukyMckSEKlVxMKr714fYQQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPuWlK8NqJcNJU03ybXD4+LcO0f73RDl0keBdAUE/DY=;
 b=d3ATQrUDQOriUv3T+VmumWg4xdbulY4KX06QjJQ7Lv/QPWbpquJBVtXQb9V6+0BwSBKTx4TRbKj/tqauv2gQZ4loi6XYPFMd4hd0UxutmAYS39jZgjH1mjVcYyx8ySb/CLZ3QPYJVoNr7pDlZ5qRovramTiyhm9kPGb4rUFnoSRC48SAEMnUsInquKq1sBkTvgzjStA1wSdTYvlSLPpVeu933l9t/YtKr9B6xiaHUHAEHD9WzF8uFJLjCI1ie+BfIzxSkbCqKRifhgph9cHwFkyGyw3f2isgtiWJoPDYE6tv4RMRCiYSMiDdGN37cQ23FZU3yIvEaczj38udABxwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPuWlK8NqJcNJU03ybXD4+LcO0f73RDl0keBdAUE/DY=;
 b=PAoGdFwuRbT9guAcChfGo4/H9/kL3jBscxq2lTz2bnVuJg5JRxHHJw/Xv7uWCN2wWek6zACnj1BblcSrSbOq5y+3B8VZU2gdmrRXjiLg50HkoaU9R5QMVu5klx795cjBNtSBjs6f7EyJ5oqu3b5b57w36RggbhS6iMEhmzAEE1K5ISZgnzBomjeimsA8DW46AekVjq1vWicoEDpGLnCC3U8yNqpSjoYyi18L8As+1d8y7T13w4Q5d5AHCLCEZKA1qiQLtWnjDGrtFlBLBCOJ12+ztcxaOejyz3/sVyRBm6YP/FqMzmbhinI+7DrZpZdgJvoMJl3GmPxTRuWymCk0EA==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (20.177.162.17) by
 PS2PR06MB3496.apcprd06.prod.outlook.com (20.179.113.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Tue, 7 Jun 2022 03:05:59 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 03:05:59 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Neal Liu <neal_liu@aspeedtech.com>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
Subject: RE: [PATCH v2 1/5] crypto: aspeed: Add HACE hash driver
Thread-Topic: [PATCH v2 1/5] crypto: aspeed: Add HACE hash driver
Thread-Index: AQHYeXGeSzQOPdHyakaer71NgsLgsa1Cr2KAgACTkRA=
Date:   Tue, 7 Jun 2022 03:05:59 +0000
Message-ID: <HK0PR06MB3202D3E4A6B48BCA5C4417D880A59@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220606064935.1458903-1-neal_liu@aspeedtech.com>
 <20220606064935.1458903-2-neal_liu@aspeedtech.com>
 <349c0714-5ec8-4233-0f0d-669e4ad3bf59@wanadoo.fr>
In-Reply-To: <349c0714-5ec8-4233-0f0d-669e4ad3bf59@wanadoo.fr>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4572522-e78f-4cff-0e94-08da4832a606
x-ms-traffictypediagnostic: PS2PR06MB3496:EE_
x-microsoft-antispam-prvs: <PS2PR06MB3496F555EEE6F0B62D545E1D80A59@PS2PR06MB3496.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C1ImpEVo1ZZx+ZiVk47MJ4NxXBwsqjK+vLcot3qV3wfCVL5Y+0raQnXENhM7c+tkAzJCAW2XQtgkLu1vktJ7A6LXRZpQeMsK7HAvj91k49mlc9+QfWsvO6530uwciHozs5VwWIg2YP9pSedqJdfTiCzxddzpAURoekX4bnsVF+PNbwW2o2hPWRNR4CSErjD2GHZ8i1Z8os7kGhP4KjSwPb+dkSA+1W1hbSHHxGPA8ayoewAoHyYZDvvhAaIYurJfeOOh+VtkUwYrKvS75dH1fyaZsuYofbzdKU16uQ7UMSrA9knmBXyLCPXMbRcNYovFd8iiL6Mkkomx+yoqyjVLFPzoAvPAX5uBxUV5ObhyHzFDcKlxttRLn9s/vKbcbi4/RRyRmEQkaFWu17GUYt/xqH0VJL5mzij0HUHb6RWAY//UK7qlEAcwrTfQ0e88BQTVnMkxnNg2Vrd0znOSbT6M6JKlyPaAS8Q7dLqBGqBy5gjiqId6WPZN3d6ZP/eJ06lJS5fKtWq0YI+8hE2OFvFvolz/36escPknDgPVVjWFZs35xDHXLtRQlSFhiCwwO6Xo2hRX9YDA/YLJwyjZ3GhPi6HNdaXTPT5GS13Y75DeGY6eEVvQjF3HZ7tUkjd984k9WxVyDJamTx1xSpIMsuI5VXL/+UQ+pzTNMp5WGLZG9OAC09S80+CObFLXd77QTOg9cvYHncvhzsco9GGz6V82NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8936002)(6862004)(8676002)(5660300002)(122000001)(7416002)(38070700005)(76116006)(66446008)(64756008)(66946007)(66556008)(66476007)(316002)(6200100001)(33656002)(55016003)(83380400001)(52536014)(86362001)(38100700002)(26005)(508600001)(66574015)(54906003)(71200400001)(6506007)(9686003)(7696005)(107886003)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjJ0MHFtYUIyNGZUa3UzUjZGWm1CQjljL1RrbTJlQ3JKYUVKVExPbUpXcTN4?=
 =?utf-8?B?V29KU3NZNllMNk5KQmlUT2VWZENXcS9JS2JTOHV3Ukh6WWljRFR6aXFPeHpY?=
 =?utf-8?B?ZG9rMTRXMUk5WWwyMDlaUlpjSXJGeXVlMXNMQ3pKSHZCTEV0U3FhdkVYcEZz?=
 =?utf-8?B?a1ZQV0pPTWNoUTlaQWFDNHhQazFzcDM3OTVNZ1dwYWVqbW1ZSytqZFdyMVV1?=
 =?utf-8?B?VUNZeHdGRTh0aWdVMkI5TmxwSUpHdkF4U3c2VWRMN09NWi9PT3F1eUJEUzJx?=
 =?utf-8?B?U1NqalZUYUZ0YmE5T05uZm51S1E5RlphR1JhckJ5amtpRGs1K0lnM0ZsdTRi?=
 =?utf-8?B?eVFWZHV6d2hRU3dudjRHWGtEVGYwS3dTT2xIOE5wNi9ySEtHZGtWb3BYNFBj?=
 =?utf-8?B?Z0JoR0c2aVZvb0FhSEIrU0NVcHd6SGVtTS9NeUhDK2VFQ3BPZFNiV1kybWlP?=
 =?utf-8?B?STJXTzV0enBXSzBlUm84TWplNmg4ODZLZkZibzJHVGZpRjRuQ0FOZWs0a1B5?=
 =?utf-8?B?cmFGU0ZzN240aW5NSURNZ3hLeTJaVUNteDNhUFhvK014aXplZXh0RG90TFp2?=
 =?utf-8?B?WUJ2bkNGRVZBMEJPNEhmNzNFbTVnNm5WTmtnNTNmeTdUVG1WQ3V5bXNDNUVY?=
 =?utf-8?B?NHhKR1ZyME1MYmkrRHhmRUxIbnlXWFdYNUg5YXYyalhmZ2EreGtQV2hWL1JV?=
 =?utf-8?B?NWhrMWJZYXFXaXpzbmVKYzBnYTQyMU9CU1RCOXcvRnNqUkVha0k2cFY4Q0kx?=
 =?utf-8?B?VXgyVXhyQXJ2TzI1UjdYYXVoRlJMbEppSEszQ2dDMGhhT2Q0TWtqR1RHbTMx?=
 =?utf-8?B?clZaUWN6K1I3UjdXOHAvOVhTNW1pRVVuSU1mWHhTVXdiZXQvbHB0dURFc24x?=
 =?utf-8?B?T0xwSmYrY0NueUtLTTUyQld4VHZOeklCdkltYTQ5aVkwazVqS050Nzl1dTBy?=
 =?utf-8?B?ck9xeHBOYk1CUFlidTU0UlBzQ2N2QTNWLy9idWhSRkg3eW1sWkhYUmNqOFl5?=
 =?utf-8?B?RlQwTHh1bFlTTjVYREFWSzd6SWpkdXNkQmdlem41Y0k2d0dNb2EwTE4xdzVi?=
 =?utf-8?B?Tk93d0V5eTNHODhRZFVkT293TzI0YUhMTjJaZ3FmRzV3K3FHdU8wSVJrU2VD?=
 =?utf-8?B?bEVjVHFOY2tsNlprSTV6UWNGOEJURkdLZmFUUHd5K1ljN0JBWi94c01ydXVl?=
 =?utf-8?B?VFlLSEt4bFpCSzAvYzJaT2EvcFFpY0tPWTluR0U0aWttWWx0T0xLdHZEUWs5?=
 =?utf-8?B?ajdvbmN3c0NGMGY2L1VQc1k5NGk5bG9MaDFrZ25Sb1pqaVFENjMrWjhwdzN4?=
 =?utf-8?B?VGtEUzgrOHkzN2lOVkhHTUR6UE5jWi82M1NSM3JEMjNLa1dnQ3JJU3N3bWFI?=
 =?utf-8?B?NUovaktVMXZOVFRoK3YweW90VjE3RUx1ZHp4cGNZNVIwK1FIZVp2MnI3czlH?=
 =?utf-8?B?VG1ubjFUVVI3ZmRJSy9IRnpEby9OcXQ5WWZCbjdRYnRYTy9kQU5odE4yNnJD?=
 =?utf-8?B?L0VKMDB1TmczaS8xR29vZkRVdDJQZGFlS1I1QU5tM2VWMWZTQkF4dmQySmlp?=
 =?utf-8?B?RkgrT1JKWU1XcTNQNk9vSXVLVlpIdE1rMldrTmRaZHlsTlNYMEFUQkk1ZCtp?=
 =?utf-8?B?T1JGcys3STlxNU45c2hKQVF0Lzg3cXlaVXltdnQrZ2dITTVZTFovZU5Ranlr?=
 =?utf-8?B?VnZkVG92amE0c2xDdlVJbE5ldmlZZUhzbHQrS1NhWEIwZDVQRTRvbStCNzNW?=
 =?utf-8?B?T3BSeDRDRHBtaFBKVzJlOUlDUFlseHlVaEU3NDJwaFdLazY3TkEzZFFJc1E4?=
 =?utf-8?B?RTZMTEx1eGd0Q01qUVUvTXkvOWRpYjVWQkVUUWoxWG1QN05RNU9aQTkzSm44?=
 =?utf-8?B?TXN0QnVDZ3l5U2pMS1dKVktBbjNmOFJ1bDAvTCs1cUJzZWRtalNza3haUkVP?=
 =?utf-8?B?bmtyRyt1OXZna3hIUFpoSFZUVDRxT09EZmJpRmlrWGVqaG5Tck1hTlRoUXJJ?=
 =?utf-8?B?UTZWUUw4OG9tYnlOYWhXT01SUHBDdDI1eEs0VEZ4cUl3ekhUT01VUlBjS25N?=
 =?utf-8?B?UFR2ZlVGay9wUFBEWHFBRmc5U0ZpdlovWklqNEEvcDNCQWtIbldJYTU1bldz?=
 =?utf-8?B?L1ErQ0k0dUZsekZNb1krR09VUTJBQVd0RjJ4cEJOWFdweUpOSnR2WEQxRno0?=
 =?utf-8?B?bmlIUTRHZFZPb2c2OGdFbzdJZGxHS0dIY09ESW90Uk5KM2xFS1U1SWRZUFNv?=
 =?utf-8?B?bEJkQTRsWUhRNWc0ZEQ4MXpyWVRTV29TeUVtM2hsQTB1T3ZrM0p0dmRQaHZZ?=
 =?utf-8?B?M1RydnFqeUZmZFdYTkFtalg0YjVQcnBUN0JuWTNNUkF1UXRSWXdEdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4572522-e78f-4cff-0e94-08da4832a606
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 03:05:59.6701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHRALuyBQuBshPrYaN3gTU7o7gdSXCBF8g6W2p5awMhpEOhS3LEEVgBzm8dlhyUBLahZ6jFu38N1lBEgpFEnpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3496
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBMZSAwNi8wNi8yMDIyIMOgIDA4OjQ5LCBOZWFsIExpdSBhIMOpY3JpdMKgOg0KPiA+IEhhc2gg
YW5kIENyeXB0byBFbmdpbmUgKEhBQ0UpIGlzIGRlc2lnbmVkIHRvIGFjY2VsZXJhdGUgdGhlIHRo
cm91Z2hwdXQNCj4gPiBvZiBoYXNoIGRhdGEgZGlnZXN0LCBlbmNyeXB0aW9uLCBhbmQgZGVjcnlw
dGlvbi4NCj4gPg0KPiA+IEJhc2ljYWxseSwgSEFDRSBjYW4gYmUgZGl2aWRlZCBpbnRvIHR3byBp
bmRlcGVuZGVudGx5IGVuZ2luZXMNCj4gPiAtIEhhc2ggRW5naW5lIGFuZCBDcnlwdG8gRW5naW5l
LiBUaGlzIHBhdGNoIGFpbXMgdG8gYWRkIEhBQ0UgaGFzaA0KPiA+IGVuZ2luZSBkcml2ZXIgZm9y
IGhhc2ggYWNjZWxlcmF0b3IuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOZWFsIExpdSA8bmVh
bF9saXVAYXNwZWVkdGVjaC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9obm55IEh1YW5nIDxq
b2hubnlfaHVhbmdAYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+IA0KPiBbLi4uXQ0KPiANCj4g
PiArc3RhdGljIGludCBhc3BlZWRfYWhhc2hfZG1hX3ByZXBhcmUoc3RydWN0IGFzcGVlZF9oYWNl
X2RldiAqaGFjZV9kZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBhc3BlZWRfZW5naW5lX2hhc2gg
Kmhhc2hfZW5naW5lID0gJmhhY2VfZGV2LT5oYXNoX2VuZ2luZTsNCj4gPiArCXN0cnVjdCBhaGFz
aF9yZXF1ZXN0ICpyZXEgPSBoYXNoX2VuZ2luZS0+YWhhc2hfcmVxOw0KPiA+ICsJc3RydWN0IGFz
cGVlZF9zaGFtX3JlcWN0eCAqcmN0eCA9IGFoYXNoX3JlcXVlc3RfY3R4KHJlcSk7DQo+ID4gKwlz
dHJ1Y3QgZGV2aWNlICpkZXYgPSBoYWNlX2Rldi0+ZGV2Ow0KPiA+ICsJaW50IGxlbmd0aCwgcmVt
YWluOw0KPiA+ICsJaW50IHJjID0gMDsNCj4gPiArDQo+ID4gKwlsZW5ndGggPSByY3R4LT50b3Rh
bCArIHJjdHgtPmJ1ZmNudDsNCj4gPiArCXJlbWFpbiA9IGxlbmd0aCAlIHJjdHgtPmJsb2NrX3Np
emU7DQo+ID4gKw0KPiA+ICsJQUhBU0hfREJHKGhhY2VfZGV2LCAibGVuZ3RoOjB4JXgsIHJlbWFp
bjoweCV4XG4iLCBsZW5ndGgsIHJlbWFpbik7DQo+ID4gKw0KPiA+ICsJaWYgKHJjdHgtPmJ1ZmNu
dCkNCj4gPiArCQltZW1jcHkoaGFzaF9lbmdpbmUtPmFoYXNoX3NyY19hZGRyLCByY3R4LT5idWZm
ZXIsIHJjdHgtPmJ1ZmNudCk7DQo+ID4gKw0KPiA+ICsJaWYgKHJjdHgtPnRvdGFsICsgcmN0eC0+
YnVmY250IDwgQVNQRUVEX0NSWVBUT19TUkNfRE1BX0JVRl9MRU4pIHsNCj4gPiArCQlzY2F0dGVy
d2Fsa19tYXBfYW5kX2NvcHkoaGFzaF9lbmdpbmUtPmFoYXNoX3NyY19hZGRyICsNCj4gPiArCQkJ
CQkgcmN0eC0+YnVmY250LCByY3R4LT5zcmNfc2csDQo+ID4gKwkJCQkJIHJjdHgtPm9mZnNldCwg
cmN0eC0+dG90YWwgLSByZW1haW4sIDApOw0KPiA+ICsJCXJjdHgtPm9mZnNldCArPSByY3R4LT50
b3RhbCAtIHJlbWFpbjsNCj4gPiArDQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCWRldl93YXJuKGRl
diwgIkhhc2ggZGF0YSBsZW5ndGggaXMgdG9vIGxhcmdlXG4iKTsNCj4gPiArCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlzY2F0dGVyd2Fsa19tYXBfYW5kX2NvcHkocmN0
eC0+YnVmZmVyLCByY3R4LT5zcmNfc2csDQo+ID4gKwkJCQkgcmN0eC0+b2Zmc2V0LCByZW1haW4s
IDApOw0KPiA+ICsNCj4gPiArCXJjdHgtPmJ1ZmNudCA9IHJlbWFpbjsNCj4gPiArCXJjdHgtPmRp
Z2VzdF9kbWFfYWRkciA9IGRtYV9tYXBfc2luZ2xlKGhhY2VfZGV2LT5kZXYsIHJjdHgtPmRpZ2Vz
dCwNCj4gPiArCQkJCQkgICAgICAgU0hBNTEyX0RJR0VTVF9TSVpFLA0KPiA+ICsJCQkJCSAgICAg
ICBETUFfQklESVJFQ1RJT05BTCk7DQo+ID4gKwlpZiAoZG1hX21hcHBpbmdfZXJyb3IoaGFjZV9k
ZXYtPmRldiwgcmN0eC0+ZGlnZXN0X2RtYV9hZGRyKSkgew0KPiA+ICsJCWRldl93YXJuKGhhY2Vf
ZGV2LT5kZXYsICJkbWFfbWFwKCkgcmN0eCBkaWdlc3QgZXJyb3JcbiIpOw0KPiA+ICsJCXJjID0g
LUVOT01FTTsNCj4gPiArCQlnb3RvIGZyZWU7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaGFzaF9l
bmdpbmUtPnNyY19sZW5ndGggPSBsZW5ndGggLSByZW1haW47DQo+ID4gKwloYXNoX2VuZ2luZS0+
c3JjX2RtYSA9IGhhc2hfZW5naW5lLT5haGFzaF9zcmNfZG1hX2FkZHI7DQo+ID4gKwloYXNoX2Vu
Z2luZS0+ZGlnZXN0X2RtYSA9IHJjdHgtPmRpZ2VzdF9kbWFfYWRkcjsNCj4gPiArDQo+ID4gKwly
ZXR1cm4gMDsNCj4gPiArDQo+ID4gK2ZyZWU6DQo+ID4gKwlkbWFfdW5tYXBfc2luZ2xlKGhhY2Vf
ZGV2LT5kZXYsIHJjdHgtPmRpZ2VzdF9kbWFfYWRkciwNCj4gPiArCQkJIFNIQTUxMl9ESUdFU1Rf
U0laRSwgRE1BX0JJRElSRUNUSU9OQUwpOw0KPiANCj4gSGVyZSwgZG1hX21hcF9zaW5nbGUoKSBo
YXMgZmFpbGVkLiBEbyB3ZSBuZWVkIHRvIHVubWFwPyAob3RoZXIgY2FsbHMgYmVsb3cNCj4gZG9u
J3QpDQo+IA0KDQpDb3JyZWN0LiBJIG1pc3MgdGhpcyBwYXJ0LiBJJ2xsIHJldmlzZSBpdCBpbiBu
ZXh0IHBhdGNoLCB0aGFua3MuDQoNCj4gPiArCXJldHVybiByYzsNCj4gPiArfQ0KPiA+ICsNCj4g
PiArLyoNCj4gPiArICogUHJlcGFyZSBETUEgYnVmZmVyIGFzIFNHIGxpc3QgYnVmZmVyIGJlZm9y
ZQ0KPiA+ICsgKiBoYXJkd2FyZSBlbmdpbmUgcHJvY2Vzc2luZy4NCj4gPiArICovDQo+ID4gK3N0
YXRpYyBpbnQgYXNwZWVkX2FoYXNoX2RtYV9wcmVwYXJlX3NnKHN0cnVjdCBhc3BlZWRfaGFjZV9k
ZXYNCj4gPiArKmhhY2VfZGV2KSB7DQo+ID4gKwlzdHJ1Y3QgYXNwZWVkX2VuZ2luZV9oYXNoICpo
YXNoX2VuZ2luZSA9ICZoYWNlX2Rldi0+aGFzaF9lbmdpbmU7DQo+ID4gKwlzdHJ1Y3QgYWhhc2hf
cmVxdWVzdCAqcmVxID0gaGFzaF9lbmdpbmUtPmFoYXNoX3JlcTsNCj4gPiArCXN0cnVjdCBhc3Bl
ZWRfc2hhbV9yZXFjdHggKnJjdHggPSBhaGFzaF9yZXF1ZXN0X2N0eChyZXEpOw0KPiA+ICsJc3Ry
dWN0IGFzcGVlZF9zZ19saXN0ICpzcmNfbGlzdDsNCj4gPiArCXN0cnVjdCBzY2F0dGVybGlzdCAq
czsNCj4gPiArCWludCBsZW5ndGgsIHJlbWFpbiwgc2dfbGVuLCBpOw0KPiA+ICsJaW50IHJjID0g
MDsNCj4gPiArDQo+ID4gKwlyZW1haW4gPSAocmN0eC0+dG90YWwgKyByY3R4LT5idWZjbnQpICUg
cmN0eC0+YmxvY2tfc2l6ZTsNCj4gPiArCWxlbmd0aCA9IHJjdHgtPnRvdGFsICsgcmN0eC0+YnVm
Y250IC0gcmVtYWluOw0KPiA+ICsNCj4gPiArCUFIQVNIX0RCRyhoYWNlX2RldiwgIiVzOjB4JXgs
ICVzOjB4JXgsICVzOjB4JXgsICVzOjB4JXhcbiIsDQo+ID4gKwkJICAicmN0eCB0b3RhbCIsIHJj
dHgtPnRvdGFsLCAiYnVmY250IiwgcmN0eC0+YnVmY250LA0KPiA+ICsJCSAgImxlbmd0aCIsIGxl
bmd0aCwgInJlbWFpbiIsIHJlbWFpbik7DQo+ID4gKw0KPiA+ICsJc2dfbGVuID0gZG1hX21hcF9z
ZyhoYWNlX2Rldi0+ZGV2LCByY3R4LT5zcmNfc2csIHJjdHgtPnNyY19uZW50cywNCj4gPiArCQkJ
ICAgIERNQV9UT19ERVZJQ0UpOw0KPiA+ICsJaWYgKCFzZ19sZW4pIHsNCj4gPiArCQlkZXZfd2Fy
bihoYWNlX2Rldi0+ZGV2LCAiZG1hX21hcF9zZygpIHNyYyBlcnJvclxuIik7DQo+ID4gKwkJcmMg
PSAtRU5PTUVNOw0KPiANCj4gRGlyZWN0IHJldHVybiwgYXMgZG9uZSBpbiB2MSwgbG9va3MgZmlu
ZSB0byBtZS4gQnV0IGl0IGlzIG1vc3RseSBhIG1hdHRlciBvZiB0ZXN0LCBJDQo+IGd1ZXNzLg0K
PiANCj4gPiArCQlnb3RvIGVuZDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlzcmNfbGlzdCA9IChz
dHJ1Y3QgYXNwZWVkX3NnX2xpc3QgKiloYXNoX2VuZ2luZS0+YWhhc2hfc3JjX2FkZHI7DQo+ID4g
KwlyY3R4LT5kaWdlc3RfZG1hX2FkZHIgPSBkbWFfbWFwX3NpbmdsZShoYWNlX2Rldi0+ZGV2LCBy
Y3R4LT5kaWdlc3QsDQo+ID4gKwkJCQkJICAgICAgIFNIQTUxMl9ESUdFU1RfU0laRSwNCj4gPiAr
CQkJCQkgICAgICAgRE1BX0JJRElSRUNUSU9OQUwpOw0KPiA+ICsJaWYgKGRtYV9tYXBwaW5nX2Vy
cm9yKGhhY2VfZGV2LT5kZXYsIHJjdHgtPmRpZ2VzdF9kbWFfYWRkcikpIHsNCj4gPiArCQlkZXZf
d2FybihoYWNlX2Rldi0+ZGV2LCAiZG1hX21hcCgpIHJjdHggZGlnZXN0IGVycm9yXG4iKTsNCj4g
PiArCQlyYyA9IC1FTk9NRU07DQo+ID4gKwkJZ290byBmcmVlX3NyY19zZzsNCj4gPiArCX0NCj4g
PiArDQo+ID4gKwlpZiAocmN0eC0+YnVmY250ICE9IDApIHsNCj4gPiArCQlyY3R4LT5idWZmZXJf
ZG1hX2FkZHIgPSBkbWFfbWFwX3NpbmdsZShoYWNlX2Rldi0+ZGV2LA0KPiA+ICsJCQkJCQkgICAg
ICAgcmN0eC0+YnVmZmVyLA0KPiA+ICsJCQkJCQkgICAgICAgcmN0eC0+YmxvY2tfc2l6ZSAqIDIs
DQo+ID4gKwkJCQkJCSAgICAgICBETUFfVE9fREVWSUNFKTsNCj4gPiArCQlpZiAoZG1hX21hcHBp
bmdfZXJyb3IoaGFjZV9kZXYtPmRldiwgcmN0eC0+YnVmZmVyX2RtYV9hZGRyKSkgew0KPiA+ICsJ
CQlkZXZfd2FybihoYWNlX2Rldi0+ZGV2LCAiZG1hX21hcCgpIHJjdHggYnVmZmVyIGVycm9yXG4i
KTsNCj4gPiArCQkJcmMgPSAtRU5PTUVNOw0KPiA+ICsJCQlnb3RvIGZyZWVfcmN0eF9kaWdlc3Q7
DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQlzcmNfbGlzdFswXS5waHlfYWRkciA9IHJjdHgtPmJ1
ZmZlcl9kbWFfYWRkcjsNCj4gPiArCQlzcmNfbGlzdFswXS5sZW4gPSByY3R4LT5idWZjbnQ7DQo+
ID4gKwkJbGVuZ3RoIC09IHNyY19saXN0WzBdLmxlbjsNCj4gPiArDQo+ID4gKwkJLyogTGFzdCBz
ZyBsaXN0ICovDQo+ID4gKwkJaWYgKGxlbmd0aCA9PSAwKQ0KPiA+ICsJCQlzcmNfbGlzdFswXS5s
ZW4gfD0gSEFTSF9TR19MQVNUX0xJU1Q7DQo+ID4gKwkJc3JjX2xpc3QrKzsNCj4gPiArCX0NCj4g
PiArDQo+ID4gKwlpZiAobGVuZ3RoICE9IDApIHsNCj4gPiArCQlmb3JfZWFjaF9zZyhyY3R4LT5z
cmNfc2csIHMsIHNnX2xlbiwgaSkgew0KPiA+ICsJCQlzcmNfbGlzdFtpXS5waHlfYWRkciA9IHNn
X2RtYV9hZGRyZXNzKHMpOw0KPiA+ICsNCj4gPiArCQkJaWYgKGxlbmd0aCA+IHNnX2RtYV9sZW4o
cykpIHsNCj4gPiArCQkJCXNyY19saXN0W2ldLmxlbiA9IHNnX2RtYV9sZW4ocyk7DQo+ID4gKwkJ
CQlsZW5ndGggLT0gc2dfZG1hX2xlbihzKTsNCj4gPiArDQo+ID4gKwkJCX0gZWxzZSB7DQo+ID4g
KwkJCQkvKiBMYXN0IHNnIGxpc3QgKi8NCj4gPiArCQkJCXNyY19saXN0W2ldLmxlbiA9IGxlbmd0
aDsNCj4gPiArCQkJCXNyY19saXN0W2ldLmxlbiB8PSBIQVNIX1NHX0xBU1RfTElTVDsNCj4gPiAr
CQkJCWxlbmd0aCA9IDA7DQo+ID4gKwkJCQlicmVhazsNCj4gPiArCQkJfQ0KPiA+ICsJCX0NCj4g
PiArCX0NCj4gPiArDQo+ID4gKwlpZiAobGVuZ3RoICE9IDApIHsNCj4gPiArCQlyYyA9IC1FSU5W
QUw7DQo+ID4gKwkJZ290byBmcmVlX3JjdHhfYnVmZmVyOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAr
CXJjdHgtPm9mZnNldCA9IHJjdHgtPnRvdGFsIC0gcmVtYWluOw0KPiA+ICsJaGFzaF9lbmdpbmUt
PnNyY19sZW5ndGggPSByY3R4LT50b3RhbCArIHJjdHgtPmJ1ZmNudCAtIHJlbWFpbjsNCj4gPiAr
CWhhc2hfZW5naW5lLT5zcmNfZG1hID0gaGFzaF9lbmdpbmUtPmFoYXNoX3NyY19kbWFfYWRkcjsN
Cj4gPiArCWhhc2hfZW5naW5lLT5kaWdlc3RfZG1hID0gcmN0eC0+ZGlnZXN0X2RtYV9hZGRyOw0K
PiA+ICsNCj4gPiArCWdvdG8gZW5kOw0KPiA+ICsNCj4gPiArZnJlZV9yY3R4X2J1ZmZlcjoNCj4g
PiArCWRtYV91bm1hcF9zaW5nbGUoaGFjZV9kZXYtPmRldiwgcmN0eC0+YnVmZmVyX2RtYV9hZGRy
LA0KPiA+ICsJCQkgcmN0eC0+YmxvY2tfc2l6ZSAqIDIsIERNQV9UT19ERVZJQ0UpOw0KPiANCj4g
SWYgInJjdHgtPmJ1ZmNudCA9PSAwIiB0aGUgY29ycmVzcG9uZG5pbmcgZG1hX21hcF9zaW5nbGUo
KSBoYXMgbm90IGJlZW4NCj4gY2FsbGVkLiBJcyBpdCBhbiBpc3N1ZT8gKHRoZSB0ZXN0IGV4aXN0
cyBpbiBhc3BlZWRfYWhhc2hfdXBkYXRlX3Jlc3VtZV9zZygpLCBzbw0KPiBJIGd1ZXNzIGl0IGlz
IG5lZWRlZCkNCj4gDQo+ID4gK2ZyZWVfcmN0eF9kaWdlc3Q6DQo+ID4gKwlkbWFfdW5tYXBfc2lu
Z2xlKGhhY2VfZGV2LT5kZXYsIHJjdHgtPmRpZ2VzdF9kbWFfYWRkciwNCj4gPiArCQkJIFNIQTUx
Ml9ESUdFU1RfU0laRSwgRE1BX0JJRElSRUNUSU9OQUwpOw0KPiA+ICtmcmVlX3NyY19zZzoNCj4g
PiArCWRtYV91bm1hcF9zZyhoYWNlX2Rldi0+ZGV2LCByY3R4LT5zcmNfc2csIHJjdHgtPnNyY19u
ZW50cywNCj4gPiArCQkgICAgIERNQV9UT19ERVZJQ0UpOw0KPiA+ICtlbmQ6DQo+ID4gKwlyZXR1
cm4gcmM7DQo+ID4gK30NCj4gPiArDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiArDQo+ID4gKyNkZWZp
bmUgSEFTSF9TR19MQVNUX0xJU1QgICAgICAgICAgICAgICBCSVQoMzEpDQo+IA0KPiBUYWIgYXMg
ZG9uZSBpbiB0aGUgb3RoZXIgI2RlZmluZT8NCg0KU3VyZSAhDQoNClsuLi5dDQo=
