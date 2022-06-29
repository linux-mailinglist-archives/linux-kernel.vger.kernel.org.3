Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206AA55FB0A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiF2IuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiF2It7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:49:59 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1FE3CFEF;
        Wed, 29 Jun 2022 01:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEqiXc9+khUI2lZei2q7qK+cPvV4qVRdYcsqFw1RfCemm7dvweQovgB1X2BgEdSWHC7HGScUpbdT+iWgPhH8Dh8pjPy8CGLkL0aTeSRTOwZxg5ogJgvLSIv6NIee6jloMJkNBjkr6eS+u2j39Wyc+BIXyu+1lszJyturR+wPQEe58A5+WAaAvMmLMV4oLzz8D8RvedhPsirKPx3+kr8dQtegbCZI/HABIZ3sA3Syst4r6IMt2ofKswPWGrpconhb9Kci+Nqard66j5fHqSYcfRSfGv18PrgtlQAA66Ke9uHt79+GcGmmvlmd2TebJpR5SqTo962X6xaoKSnla1A+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uNXtWFHPlo7g9prVJuRiBnzy0WguIkxuQ/PLEK4stE=;
 b=ef67+XGNxr32EeP4aQo+moRVNzCb74dlKxVvxE6Se8Iwtq9+WGKQns29C+X2hZ8E6qo1Goxbvhs/gyidpAGx32cdDQZVFa+oByJvOPwV5Q60+XXJYhpfzRd/t/3ysJxvu+iEQnhF8YobWwrVIShkb4NfJqzXdvxx8q/HlxO8FdjTRmD0HTGIQXLG8uOXAy78w96Rt6/7Y5twmWcF1hWLwe3ASUBqdIlXC6UEaHTJ7nuArxI8B39Jm3wOAsxKytFcRk0g7jf2/Tj7j3woRqNknak6rU9G5EFQbdADpM15QUPK3S/MclFDRVRbZVTkjhXOytcYMOsmmCukMWc+z4FOTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uNXtWFHPlo7g9prVJuRiBnzy0WguIkxuQ/PLEK4stE=;
 b=FZ33FpAtuGmyLoiFNNyaJBhsf9T3Qr/x2p8NrtMjojoU147+Ru6pWPj9Dao2D2sUWduHAv1tP9auL3AKFRCkdvh6o9buA49v+fd/4MfsekAeeJIvAjhZ9a2bcctrbfsR3p3FMEUy9+kCMYPz1QtHpqzGlbM2P2bpI9LZEgAdDfoDVyrQLGOZ/Ks8DnBJv/QyAZjBkwnZ8nC2cwy71iGb9BQodKEkWkrysN4DzyMrt3rA69GcrMY1KcjR29ERN5Uck+Qk9m6X1xrvoUjhupqdCgTTbIToCwCKC54oAY2i84vP0ilhYMkGisC+7AuigUb5ORyjMkf2YitZU18N1jPSOQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TY2PR06MB3631.apcprd06.prod.outlook.com (2603:1096:404:f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 08:49:51 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 08:49:51 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v5 2/5] dt-bindings: clock: Add AST2500/AST2600 HACE reset
 definition
Thread-Topic: [PATCH v5 2/5] dt-bindings: clock: Add AST2500/AST2600 HACE
 reset definition
Thread-Index: AQHYi2cqlkV0h2M2LEWiJm1FKKQpMa1l43kAgAAgOSCAAAL6gIAAClow
Date:   Wed, 29 Jun 2022 08:49:51 +0000
Message-ID: <HK0PR06MB32021F63833C4C482CC616D580BB9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220629032008.1579899-1-neal_liu@aspeedtech.com>
 <20220629032008.1579899-3-neal_liu@aspeedtech.com>
 <b70e06e7-81fc-dfc1-f9c5-f83cb4a18293@linaro.org>
 <HK0PR06MB32025ACEE605D1016DD3B99D80BB9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <409af908-5e03-8df7-fcd5-7fab75cdfb34@linaro.org>
In-Reply-To: <409af908-5e03-8df7-fcd5-7fab75cdfb34@linaro.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0594a914-f27e-484b-b069-08da59ac54b3
x-ms-traffictypediagnostic: TY2PR06MB3631:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b16j94rjk8nYGzwtLPmia3NIAKwTEuD4aniBALFOHM3h4vqpzc+TGYn+FIiPTWMGJrn5KoOPADouNyd6VP5Z3qtbiFF29J0fEfccCO5diDM8jhMIBISJCohncimYuRJRMZuyGhIpeCiKW/cp303YnYbAwKLmJdQTi1Rs/TgoajGCtehlNXtYhb5jTv6O8r2ekUD9p+OjKGv9qJv3UPx6CGXmyDMLzbZalobG5GF8pbcOQfBVh4DDghZUt7EtuXYNPyhhndDFglU/W6zKS76HepBAoX9vHKA2os6GaUcUHVDGzaVgBz2bRcjNT77dmxyzGmRe2147Smj5Futf2lfRd1mH0rmU9tR1CPP71JBTQSnwQ/F2zAPYmZS1ic8G/eXy7aoNVbAWmmjrzfZPHjenAC7CwrIAz0bHdYaV3909ZLKdCJDlsIzBeXzJEjOSTKGqMs/PANARdXsIqa/h5/tCvHqlx+v7GNwPolU58s7ggC9wSK7qwegAlqM0YBd/Sq+EPwS2iHLpSfJVGFaseW5RJDGS7iR/8RGJ8kntXjmo59IRHkIrASJp1DtlJyK0PHD4WSFu2uiyRNok9uV667Gy96T6A/G8WLFOofSdW4V4aJwpw1vjdZay9ZEJsiA25KL1z/+zwdgMLO3l1h+IbiQDIywpcYEo0akwJTlSYgRyLI08XbgBpGcge0XcS/dWdiotjtT8nV7HMXwd6XoL1M+iSkMPZyI86fOMREHZt1MNFmEZihArLJ+D60ZWkTTMuJNHxN8VjEkf/4ePn4UjRQR5W85+5w5ywJTvBZ4jqtpujpCzJjE0HV7jYqfUshA4SXk8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39840400004)(376002)(396003)(366004)(346002)(107886003)(6506007)(86362001)(921005)(26005)(41300700001)(7696005)(6636002)(122000001)(478600001)(66946007)(316002)(53546011)(8936002)(33656002)(64756008)(4326008)(66446008)(66476007)(66556008)(83380400001)(9686003)(38100700002)(38070700005)(7416002)(76116006)(110136005)(5660300002)(55016003)(2906002)(186003)(71200400001)(52536014)(8676002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFJWV2xXMFZkczEzMFc1UkNqeklGamRwNTVXQlNFcjhLNHBEa2FNa2EzbUpM?=
 =?utf-8?B?U25VZlVqY0dXUTNxOGJjV2wrS3dnVUxFSU5GUGRTM3UzZ0NieUlCcEFmQ2Z0?=
 =?utf-8?B?M3pISnp4Q2Z3c21GSUtwTkVEdk1ObE9nRW1EM0FBVFZLQTVKT3lEbGlGSVVZ?=
 =?utf-8?B?UEVzVGIrcEhiZGx2TTJZRUg5WExiSG8yUnh1ZkZEaEN3dXdOTWZvY1Nyb2dU?=
 =?utf-8?B?d0ptRkI2UjkxdWRROGZycHhabnhhczFkbWt4VHI5YlUzZVVaRUt3bUdrbS9n?=
 =?utf-8?B?cnNVNHNKYVI2QUZLNUs1cWRiamg3VnBMTVBiTjdyem1sVVprYnV3OCs2VXpY?=
 =?utf-8?B?SjhPTlN0dStYcitPSHA4SGUzMUtCRnNVbXFRSFNJMjdoQUE4VCs4clhOVWg5?=
 =?utf-8?B?ZWx1YW9VNllaZmJoWmtkNGxwNXFRb0FLTk10K2NFbVNmLzdIb1ZHZzFJU3hj?=
 =?utf-8?B?aXkyODFFNmZweFc3ZGpLMEV1Q2tDUjdJNkFhSkpUWklDU0pLb3lqcDZPNnpa?=
 =?utf-8?B?VU13ditBSmZmRWMvOVY2eU85cGhhcUF5TEdzRmR0OWlhTkZuL2Vjb0piVDBz?=
 =?utf-8?B?NWFWcWJEdlRQaE5QV3dHdkxJVThLakxma3dhWHBNeTNyK0tqbnVPNER1ekE0?=
 =?utf-8?B?NE9GYlJFZ2FCV21IbUJEM2pQV1ZPTzNMU2o5RmZVRzhsTE1kV2JPVzZmRFda?=
 =?utf-8?B?ajVsOFZBcVFXOWFZeGR5WU5MUjBNaXJFTm5CbWgyc3loeXhJQlVzcmlsV2Fs?=
 =?utf-8?B?L1VvaVd2VXFIRmNnN3l6NFhYT1lJSENtWU1FVE1yb3NhNFlDVlA0WmFvM1VF?=
 =?utf-8?B?OC85SFB3M0E0czNWOHo3NmtPY0VmVk9aT3FqTWZQdm9HQVFLUTVrQURiSlN4?=
 =?utf-8?B?elF6TytSMDFoTmxlVXlEblZ6bVduSzQrSW5wT2E1TERPS2lJdmhTM0I5emdR?=
 =?utf-8?B?QjFCZkJHSDVXN05MNld4dEdoWVZMeW5JTEpYdEw1MWxobzQrUkxSVk1EM2I3?=
 =?utf-8?B?NFJ6QkxWak5UZkxTVHA0OXZmc3dwa0djLzdHT3NwaXBjZGNEVGNIellEcnRh?=
 =?utf-8?B?ZEI4cHZVOGFGcHE2WW0zZTJNTy95d1JxelZoWUgwVi9tZ1ZuOVRpTnJHT2RP?=
 =?utf-8?B?dmRPRHNjZXZWbWxjR0o1K29EZ25OaFpOcUhEdDhVcllhQXNsdXEyZ2JHeS9N?=
 =?utf-8?B?TVU3amlKNE9xNDV4ZXBaaFdiMmRJVXYvc2x0UVRMaE9ZVUF3MGQ3bGtDTVAr?=
 =?utf-8?B?RTlncTFxZXlDQisxMDNlZW0weE5VSjNtaThZdDlqZk84U0xLVGZNb2xaNG93?=
 =?utf-8?B?UGdGUnJ4T25YN1FLS2xIL0dyQ3JuNzZCay8zMjR6aVJyV2lVQ2xtZ1UySFJV?=
 =?utf-8?B?RUpvZkRCWlpMRUppY1l5eVZaM1B6aUM4akNkWTFTdTdTZG9QQ2llWGg4N3Vo?=
 =?utf-8?B?YndUVWVBRjlLazloTGxZTXovclBockE3YzlXMlA0YkcvWHJVc0E3Qnh5RUxl?=
 =?utf-8?B?enlMKzVBR3pKQ1BzMVZRMkVVTjU2TUJyUTRvQTBseWR1SkxzWVMvMDVjRWdv?=
 =?utf-8?B?akNiZWNMYzFyY2NKQkRQNUJFb3NIR0NVWVNEUEpHNHBZRWxXR0t4dW5GNEN0?=
 =?utf-8?B?dUVMdEJFUmhlS2V6WFRqT2JScXZPRTJPVC9FeUZUVVhUdzc1NzM4SHgzQ0Qr?=
 =?utf-8?B?cmZtQnBPU3JaS3hwcG9McTdTNVNsbzY3WVlaMG1PS0hpVFE1NHhpTXU1aVh2?=
 =?utf-8?B?MVdWSVVhN0F6S1h4OUcxbHFKcENKcTZjRnFGTzJ1bmVTZnVwdFdXSFM4TWln?=
 =?utf-8?B?b2hDZ0hXU3RTa05uSkhQM2xHaFk0dFA3amZ6WXZPcTNxc0dWVnVzeXB4ZkhY?=
 =?utf-8?B?a2VmRTdvc0xLR25yK0l2bjdmc2RhMkRRNEVvdDQ1clEwR2F5WndXRVdFTGd3?=
 =?utf-8?B?OXorOS85ZzI3THRtRnJ2QU1vbGs1UnhMRG9uL01YQ1dKTVp0YXFvd2VGbGNF?=
 =?utf-8?B?ZHJkWGNhaGpFOS9xUzFnaGZTdHF3R2tJRXBxYWg3VGlLSkp2L0FtbmpRNGlM?=
 =?utf-8?B?THJKNWlFeUYwbFVxWm5qMGd3UnZ3L2V2V1ZaRFNjNXpwb3NmZ041cXIxSDY5?=
 =?utf-8?Q?EV67LT5xi/+paLSEKsVJtetiq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0594a914-f27e-484b-b069-08da59ac54b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 08:49:51.6030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5QNUinfssUwmnxCYgpyer7+DKAKKtDT5WsMLhuOWEPn1//zGBME8xU1WJ1pYFpz7Oz0FtvoyM+XhXB2GsyAQaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB3631
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAyOS8wNi8yMDIyIDA5OjU5LCBOZWFsIExpdSB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9m
Lmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjksIDIw
MjIgMTo1OCBQTQ0KPiA+PiBUbzogTmVhbCBMaXUgPG5lYWxfbGl1QGFzcGVlZHRlY2guY29tPjsg
Q29yZW50aW4gTGFiYmUNCj4gPj4gPGNsYWJiZS5tb250am9pZUBnbWFpbC5jb20+OyBDaHJpc3Rv
cGhlIEpBSUxMRVQNCj4gPj4gPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZyPjsgUmFuZHkg
RHVubGFwDQo+ID4+IDxyZHVubGFwQGluZnJhZGVhZC5vcmc+OyBIZXJiZXJ0IFh1IDxoZXJiZXJ0
QGdvbmRvci5hcGFuYS5vcmcuYXU+Ow0KPiA+PiBEYXZpZCBTIC4gTWlsbGVyIDxkYXZlbUBkYXZl
bWxvZnQubmV0PjsgUm9iIEhlcnJpbmcNCj4gPj4gPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlz
enRvZiBLb3psb3dza2kNCj4gPj4gPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47
IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+Ow0KPiA+PiBBbmRyZXcgSmVmZmVyeSA8YW5k
cmV3QGFqLmlkLmF1PjsgRGhhbmFuamF5IFBoYWRrZQ0KPiA+PiA8ZGhwaGFka2VAbWljcm9zb2Z0
LmNvbT47IEpvaG5ueSBIdWFuZw0KPiA8am9obm55X2h1YW5nQGFzcGVlZHRlY2guY29tPg0KPiA+
PiBDYzogbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWNyeXB0b0B2Z2VyLmtl
cm5lbC5vcmc7DQo+ID4+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IEJNQy1TVyA8Qk1DLVNXQGFzcGVlZHRlY2guY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BB
VENIIHY1IDIvNV0gZHQtYmluZGluZ3M6IGNsb2NrOiBBZGQgQVNUMjUwMC9BU1QyNjAwDQo+ID4+
IEhBQ0UgcmVzZXQgZGVmaW5pdGlvbg0KPiA+Pg0KPiA+PiBPbiAyOS8wNi8yMDIyIDA1OjIwLCBO
ZWFsIExpdSB3cm90ZToNCj4gPj4+IEFkZCBIQUNFIHJlc2V0IGJpdCBkZWZpbml0aW9uIGZvciBB
U1QyNTAwL0FTVDI2MDAuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogTmVhbCBMaXUgPG5l
YWxfbGl1QGFzcGVlZHRlY2guY29tPg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogSm9obm55IEh1YW5n
IDxqb2hubnlfaHVhbmdAYXNwZWVkdGVjaC5jb20+DQo+ID4+PiBBY2tlZC1ieTogS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiA+Pj4gLS0tDQo+
ID4+PiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hc3BlZWQtY2xvY2suaCAgfCAzICsrLQ0K
PiA+Pj4gaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hc3QyNjAwLWNsb2NrLmggfCAxICsNCj4g
Pj4+ICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+
Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2FzcGVlZC1j
bG9jay5oDQo+ID4+PiBiL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLWNsb2NrLmgN
Cj4gPj4+IGluZGV4IDlmZjRmNmU0NTU4Yy4uNmUwNDBmN2MzNDI2IDEwMDY0NA0KPiA+Pj4gLS0t
IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hc3BlZWQtY2xvY2suaA0KPiA+Pj4gKysrIGIv
aW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hc3BlZWQtY2xvY2suaA0KPiA+Pj4gQEAgLTQ2LDEx
ICs0NiwxMiBAQA0KPiA+Pj4gICNkZWZpbmUgQVNQRUVEX1JFU0VUX01DVFAJCTENCj4gPj4+ICAj
ZGVmaW5lIEFTUEVFRF9SRVNFVF9BREMJCTINCj4gPj4+ICAjZGVmaW5lIEFTUEVFRF9SRVNFVF9K
VEFHX01BU1RFUgkzDQo+ID4+PiAtI2RlZmluZSBBU1BFRURfUkVTRVRfTUlDCQk0DQo+ID4+PiAr
I2RlZmluZSBBU1BFRURfUkVTRVRfSEFDRQkJNA0KPiA+Pg0KPiA+PiBJIGRpZCBub3QgYWNrIHN1
Y2ggY2hhbmdlLiBUaGlzIGlzIGEgc2lnbmlmaWNhbnQgY2hhbmdlIGZyb20gcHJldmlvdXMNCj4g
Pj4gdmVyc2lvbiwgaW52YWxpZGF0aW5nIG15IHByZXZpb3VzIGFjay4NCj4gPj4NCj4gPj4gVGhp
cyBicmVha3MgdGhlIEFCSSwgc28gTkFLIHdpdGhvdXQgcHJvcGVyIGV4cGxhbmF0aW9uIHdoeSBB
QkkgYnJlYWsNCj4gPj4gaXMgYWNjZXB0ZWQuDQo+ID4NCj4gPiBJIGNoYW5nZWQgdGhlIG9yaWdp
bmFsIGRlZmluZSAoTUlDKSBpbnRvIGRpZmZlcmVudCB2YWx1ZSAoc2VlIGJlbG93IGRpZmYpLCBh
bmQNCj4gYWRkIGEgbmV3IGRlZmluZSBmb3IgSEFDRS4NCj4gPiBIb3cgZG9lcyB0aGF0IGJyZWFr
IHRoZSBBQkk/IEknbGwgYmUgYXBwcmVjaWF0ZWQgaWYgeW91IGNhbiBleHBsYWluIGl0IG1vcmUN
Cj4gZGV0YWlscy4NCj4gPiBBbmQgc29ycnkgZm9yIG5vdCByZW1vdmUgYWNrIHdpdGggbmV3IGNo
YW5nZS4NCj4gDQo+IFllcywgdGhpcyBicmVha3MgQUJJLiBQcmV2aW91c2x5IHRoZSBBU1BFRURf
UkVTRVRfTUlDIGRlZmluZSBoYWQgdmFsdWUgb2YgNCwNCj4gbm93IGl0IGhhcyB2YWx1ZSBvZiBz
b21ldGhpbmcgZWxzZS4NCg0KR290IHlvdXIgcG9pbnQuIEknbGwgcmUtZGVmaW5lIEhBQ0Ugd2l0
aG91dCBtb2RpZnlpbmcgQUJJLg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQoNCg==
