Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B638C500B46
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiDNKky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239757AbiDNKku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:40:50 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00125.outbound.protection.outlook.com [40.107.0.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC577C158;
        Thu, 14 Apr 2022 03:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BU/Lnupc2fY274TGHmLpXsCdYVwkgX81POWWq/rK2oDIsqnKPk6ivjrb88TvX2lF5Mvb1pSAIBq4i4ESonZILAc04fg0VBDirKtyeY/rz12vdhUmZmHWb4m9QYj0kEc2rhnyORtKNDfLs5SSONuiCQErVmdmvkpuYaet8YwNpXGknvoY/ikjiajX1HZ9LV90wjcoVwqCbFycF4ldU+2sTVmunTl39xU/Jfj/S7/OtYYZ8EAqhWSNHypJsJ313ni0YpxuKrNo/QF0hnO6A8rW+G5Out8/tR7Tq/imYKZ9gw3gQU1ks2/M+QWXQjimyInmKqJZFw6qZgpUFMS40pyi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URY9qEJBjlaKY1MDY7UFOtcnaIWhDAw+33GRXQ3J9p8=;
 b=Yfe3EllXIpqFL/vlp2aA8K/e0cqyHiY4AF3bCuT1N6/WNSv1IXM/k1nqPpF3nd3ICqpJHMMNS+jTcApTYK5OVvHAGCnmRiy/t4Jb3X3H0h0ZykrO+EaEguVgfSye7ti1rlgL5aguVcJHvGeTZRMsBhazUTeq7X+K7oa6dnKd8bL9fZbvNytJdL/cE1T6g7XGHcKtc3Vz/KM3G5KUA3FTkJV3T5SSFgJnFvDfwG+TFKcA3cnJcPsB5XRSrP2n8jNdGkRmiLRmUbkRRQBb4qvhW989Jrgy1e/hYdSaJoIvYg0fE7OBg+POK7uGu+zB/GZpb7RDxEtmMQnOe5MbFlWcSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URY9qEJBjlaKY1MDY7UFOtcnaIWhDAw+33GRXQ3J9p8=;
 b=WD7mPXsl4ckaQDk3F61TOsSQ2UZZ2kYFVuXMQa3bHknCkz7z9dvHMjunHP5pAl159YUvpGiOi5QRuPT3G6p+3m8dWLvUyTJ1sXo33FLbAQUSgH2N4RW1+umq2JihVfDDarcqISll4tVMfQlsnJETj4PzBhJfeiwcc1QEjy+bUiE=
Received: from HE1PR0702MB3579.eurprd07.prod.outlook.com (2603:10a6:7:7e::13)
 by AS1PR07MB8567.eurprd07.prod.outlook.com (2603:10a6:20b:483::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.14; Thu, 14 Apr
 2022 10:38:23 +0000
Received: from HE1PR0702MB3579.eurprd07.prod.outlook.com
 ([fe80::4c70:1acf:a06e:265c]) by HE1PR0702MB3579.eurprd07.prod.outlook.com
 ([fe80::4c70:1acf:a06e:265c%7]) with mapi id 15.20.5186.006; Thu, 14 Apr 2022
 10:38:23 +0000
From:   "Rossler, Jakob (Nokia - DE/Ulm)" <jakob.rossler@nokia.com>
To:     Avri Altman <Avri.Altman@wdc.com>, Bean Huo <huobean@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sperson@micron.com" <sperson@micron.com>,
        Bean Huo <beanhuo@micron.com>
Subject: RE: [PATCH v1] mmc-utils: Add General command CMD56 read support
Thread-Topic: [PATCH v1] mmc-utils: Add General command CMD56 read support
Thread-Index: AQHYS3DkQP8GXcEVL0qBAdO6LQgtcqznSnCAgAMhnoCAABQtAIAEv6Qg
Date:   Thu, 14 Apr 2022 10:38:23 +0000
Message-ID: <HE1PR0702MB3579F880543CE671E40725FBF2EF9@HE1PR0702MB3579.eurprd07.prod.outlook.com>
References: <20220408174832.303915-1-huobean@gmail.com>
         <DM6PR04MB6575816F943FB2F0D4099CDFFCE89@DM6PR04MB6575.namprd04.prod.outlook.com>
 <9ac83fe9bc33cce4b8691d49bdd155587196a62a.camel@gmail.com>
 <DM6PR04MB65758A57DBA5BE8A33578BE9FCEA9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65758A57DBA5BE8A33578BE9FCEA9@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fa04218-0457-43f9-6ae4-08da1e02e6b7
x-ms-traffictypediagnostic: AS1PR07MB8567:EE_
x-microsoft-antispam-prvs: <AS1PR07MB8567E7EE4355D5C99543D958F2EF9@AS1PR07MB8567.eurprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bhUuRNTntZKo6E+fmLLj1Ba6SRfxzuHvE0EpCXLaUTFcgNV9Zhjxrq0WJ34YbUsBBfHdPaOLKjnso44TbXMpUpqO8cjCJozxU/2jmj3T8fir7P8rD26hgKgGf8wAmPBOs+eSCb66P+M6v0J0B8fxUgW45V3CC0CAOoePmAd7yviAE959ZCU5AU3H34MrDnhI2iMe6NxOVIBHRHSHth10WsZxjejgK6Or7/pQluxL7ZhrempIgjsXwLSBeXaqUYECpp2G+1r5nbmEBFcbgktf0fkRuTj2MXTATeMKnEytN7oRzdrTCdPy5DqHo/al2021TuivxXq88IVCwJ9i3kfJlr/7BsVTBkBN/SJGTHU4SKxuU1DnG1t0+Z1CkqP3DLLwxcwtzwHl8aRRVnSf5JsTpzLDR4TXjazfnvUVwsRQIPhabnhcXWtNVwGwMbrnDqen94/8CE7uDTVug5+88/Q2hFAftlV3oycux/LeSX3qmaLhF1/elSoqEjO0XMAYMGZKdGRo6ciD0uuHnJ1EpQp+OTQzIBQzoU72NTjkXZVWOFh4j3y6HoqfzlwoUYe+yaC5Bh7Xsg4FR0GyUBx+ixyBBiAIP1RtsGEmiyofrR2EX+6StZWVAU/cmyoLIivBIrSyPJGCzfow0bO5TlYQ5UnV6+vRRR8lTvMF2hJuqkTlRTvTPYyc6lCnNOtyj90PVwGT8SXyhPzlkZKr3DqTsJ/UfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0702MB3579.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(316002)(66946007)(5660300002)(33656002)(71200400001)(83380400001)(8936002)(7696005)(82960400001)(38070700005)(6506007)(2906002)(66446008)(53546011)(8676002)(66556008)(4326008)(54906003)(38100700002)(110136005)(52536014)(66476007)(122000001)(64756008)(55016003)(76116006)(508600001)(186003)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVJKeHYvTFRqZURKOEtXemhWM3NMb0RIUDZVYlJCS0xybGlPZXdJM0JkSWlk?=
 =?utf-8?B?cVBreGd6UWJyOXJYM2RWVzVqY1hPT3FCcEYxYkNJaTdrUWZQYUxUR3htL1hF?=
 =?utf-8?B?SmFwMWV0SHVoRURZYkJqSDZEelRzMVpJd3ptaFpINVNyTTJiQjVCRmcrd0R0?=
 =?utf-8?B?eWhXNVdacG1CYkNQb3M4RlZ6ajh1dkdHRzJYMlBqb2ZTZkdPR0c2QVdkTVhW?=
 =?utf-8?B?YlBiclQyaVhpZ1RqUDNwdFVUYTQwL0FmVldjdG1NU1BwWmVvajR3dzU3ZS9k?=
 =?utf-8?B?WW9sWEczNTlaUUZocG9kV204VmlSU3VnWE1HZ00yZzhRWU52N1lnQnkyVmJu?=
 =?utf-8?B?NzJrTlJ3T05EbWRrUkRmaGR3UDYwcm9CT1JLa041ckRadXRHb0xIUVIzZG1z?=
 =?utf-8?B?RkR6RnJCQmlGNE9UaS9SK25ZaEhFNnVTQWgxQWRUczA2MUhzdmRSYnQ0aWNK?=
 =?utf-8?B?OVhoRi9VZFJEV0JOWU92S044ZUhQZDFFYlQ1aEdCTklRL0NUTkhscnBuZ01F?=
 =?utf-8?B?MFVRNFZmWWNwSmV2YW5abTZCSGdxa0FHUjFkd0oyTFdDUzQzeExuUjhQYTlH?=
 =?utf-8?B?RFg0WDh2V0swbzNUV0dPYWNFaHIrUlRWQlVXN2Y4cTluM3RLdnRKKzVtbndz?=
 =?utf-8?B?Ulk5cHFtTHQyUzBaVFpmYWZiYVVKckVzbE5SWGNacUpyVzNqQW81bnIzTU0w?=
 =?utf-8?B?RitQWEJ1aG1rTjJBbFVFZkNyWGFlV0RWaUVZOWNsSE93VVpnbzFmYnlOZ2J6?=
 =?utf-8?B?Y2hGck5UK1F2QVR5VU1yaVFZY1NFNWdrZW1LaVphQ01xTTRzYXYwT0J2NkVy?=
 =?utf-8?B?TUVUNjBzL0JKeUtEWTBBcVFlNjlqVWIxbVVVaUc0QlpuL0JicTFyM2ZGKy85?=
 =?utf-8?B?eVNrMko1c2hXcHpiYUV1YjFEenpDcmNKcEV4WUFJTlFzalpTOVd3U2o2SHN0?=
 =?utf-8?B?VWMxWGdHNGNRZ2ovclFiUTh0R3JEZ0ZISERTMEc2QjhSUWxiM3h2RXY4TUxy?=
 =?utf-8?B?eTNzci9jYnhDVWdmZnIzUzZUYmE5WXlSM09yc3RJTXg5S1orK0JVbEFIU1FH?=
 =?utf-8?B?ekl6ZHhXQzR2NmZFUlU2VWQwb1JMZUV1KzBWSThwWDRxbGhCeDFHNHc2b1J0?=
 =?utf-8?B?SVJOVnhZSTRFNVZJMWZFcS9vLzJ0WmM4R3NaNkpNUGdsbjVkWWlhSGFRVWdR?=
 =?utf-8?B?ckhqYWlObTR1ZFlzSTVwQUdMYndKT002eWw3QnpOaU5rV2dDWE40bDZoakhu?=
 =?utf-8?B?UTRsaFNhNTdxQkxVU2ovSWVGbGZGR25Mc0xIREpwc2JtUTVBMS9oZFZ4VXJG?=
 =?utf-8?B?dTlpUlIrZ0RuSHVqV212cUxJMjU0RW5MNjNub2hGUkNTWGxlMFF4WElZR1Vk?=
 =?utf-8?B?b09RVEV1NUtibEhrUUNlTWpGTEM2eVl6OE9kWFBHcHNZcVFqZlF3TXoyY3BU?=
 =?utf-8?B?M3Iyd2ZiOTVzeWdINS8rMldLajkrbFYwWVJlT3ZWdjhNRXhPL3BhVlFmeE9F?=
 =?utf-8?B?RnpoZ1RuZUZaVnJ4SldTd3FlMkpRZnMxZkhtMXB0a2Ivc041M0xGWW1odHdW?=
 =?utf-8?B?NkJTc0c2VVovZGJrRW44UWd2MkpaS2FJNFdwOG9JdXBaNmV5MXZ1Skltc3Y2?=
 =?utf-8?B?SGc5ak1yaDdDMG5jK2VBZUFQdlB2a1V4T1Yvbm5OeHRSSHVZYS95MWxoYStB?=
 =?utf-8?B?QUQ1NnFLUEh0dzhNMG5SMllTOEMwOVBUcGUxSUJpTjl2UHFXa1A3VlJpTDRG?=
 =?utf-8?B?R2FTVkNSVzdFR3hrcUhQZncvVnY2b0tDQ0VudUdQTVFEVjFqVW85bWlZVGl5?=
 =?utf-8?B?b29yVGVZdGVlMEhJRUdnc0pwcnQzQ1ZPRTNqMlZKd1MyMk1hOGxMbzVnNlFy?=
 =?utf-8?B?dDI2YVNMcHE2d29rTFFQTWIxSFQwb0dzRVdLQkhRY3RBQ245cUpNajNsK2dE?=
 =?utf-8?B?QmR3UFlmNkFPelk4NFF5K1NaSVNVeTAxUmlDSmtneVNNSVFHMXNxWWN1TDMy?=
 =?utf-8?B?RTEvUnB3V1F1ZmN0b0k1SmZzVFdzRGp3SFM5clJSbFV4TDc5ak1iKzhlOVNB?=
 =?utf-8?B?ckEwekxKT3FNUzFTY2hVQ1IzaEpUeU5VVDM5czduNGxySXRoZ0p1bHBwODZx?=
 =?utf-8?B?anZoZU4xSG1ibnpNdUQ1cW5sTVlSV1g3WlhGdXAxVVk3bE5BbDRkYlNYakJz?=
 =?utf-8?B?T25rTHlxV09mTEdWZmxEZnVKL2pYVDFJTDhWajliSHg2K29tVFZVakZzc0tq?=
 =?utf-8?B?RXdNOStEWTRwL2FDbHN1MDZsR3RDWm9QVDkxSFZseUVhNy9LcUZoSGVnR2l0?=
 =?utf-8?B?OU9tditnSFU4K3R5RlZYaXhUbU9wTWdPalJtai9hdHc0SFNsQ0VjUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0702MB3579.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa04218-0457-43f9-6ae4-08da1e02e6b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 10:38:23.5582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CsYmk8fjadgHuvPMiZETEjFZkEE9CLjW09AF6FnuhMvrMzhPHirv/zg31RjluoReWapUZfZdBIE/nwaPYQ6hHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8567
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGVzdGVkLWJ5OiBSb3NzbGVyLCBKYWtvYiAoTm9raWEgLSBERS9VbG0pIDxqYWtvYi5yb3NzbGVy
QG5va2lhLmNvbT4NCg0KQmVzdCByZWdhcmRzDQpKYWtvYg0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogQXZyaSBBbHRtYW4gPEF2cmkuQWx0bWFuQHdkYy5jb20+IA0KU2VudDog
TW9uZGF5LCBBcHJpbCAxMSwgMjAyMiAxMjowNSBQTQ0KVG86IEJlYW4gSHVvIDxodW9iZWFuQGdt
YWlsLmNvbT47IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IGFkcmlhbi5odW50ZXJAaW50ZWwuY29t
DQpDYzogbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgUm9zc2xlciwgSmFrb2IgKE5va2lhIC0gREUvVWxtKSA8amFrb2Iucm9zc2xlckBub2tp
YS5jb20+OyBzcGVyc29uQG1pY3Jvbi5jb207IEJlYW4gSHVvIDxiZWFuaHVvQG1pY3Jvbi5jb20+
DQpTdWJqZWN0OiBSRTogW1BBVENIIHYxXSBtbWMtdXRpbHM6IEFkZCBHZW5lcmFsIGNvbW1hbmQg
Q01ENTYgcmVhZCBzdXBwb3J0DQoNCj4gT24gU2F0LCAyMDIyLTA0LTA5IGF0IDA5OjAzICswMDAw
LCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiA+ICsgICAgICAgbWVtc2V0KCZpZGF0YSwgMCwgc2l6
ZW9mKGlkYXRhKSk7DQo+ID4gPiArICAgICAgIGlkYXRhLndyaXRlX2ZsYWcgPSAwOw0KPiA+ID4g
KyAgICAgICBpZGF0YS5vcGNvZGUgPSBNTUNfR0VOX0NNRDsNCj4gPiA+ICsgICAgICAgaWRhdGEu
YXJnID0gYXJnOw0KPiA+IFByYWN0aWNhbGx5IGFyZyBpcyBub3QgbmVlZGVkLCBiZWNhdXNlIGJp
dHNbMS4uMzFdIGFyZSBtZWFuaW5nbGVzcy4NCj4gPiBNYXliZSBqdXN0IHNldDogaWRhdGEuYXJn
ID0gMTsNCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBBdnJpDQo+IFRoYW5rcyBmb3IgeW91ciByZXZp
ZXcuDQo+IA0KPiB5b3UgYXJlIHJpZ2h0IGFyZyBpcyBub3QgbmVlZGVkIGFjY29yZGluZyB0byBl
TU1DIHNwZWMuICBCdXQgYXMgSSANCj4gbWVudGlvbmVkIGluIHRoZSBjb21taXQgbWVzc2FnZSwg
Zm9yIHRoZSB1bml2ZXJzYWwgdXNlLiB3ZSBuZWVkIGl0IGZvciANCj4gdGhlIHZlbmRvci0gc3Bl
Y2lmaWMgYXJnLiBJIHdpbGwgY2hhbmdlIGl0IHRoYXQgaXRzIGFyZyB3aWxsIGJlIDEgYnkgDQo+
IGRlZmF1bHQgaWYgdGhlIHVzZXIgZG9lc24ndCBzcGVjaWZpYyBhcmcuDQpBY2suDQoNClRoYW5r
cywNCkF2cmkNCg0KPiANCj4gS2luZCByZWdhcmRzLA0KPiBCZWFuDQo+IA0KPiANCg0K
