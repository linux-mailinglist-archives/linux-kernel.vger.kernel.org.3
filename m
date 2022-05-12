Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23FF525254
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356377AbiELQS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345159AbiELQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:18:25 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10105.outbound.protection.outlook.com [40.107.1.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463C514ACB9;
        Thu, 12 May 2022 09:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIgliF7yL8Y2WzxBiKbAFu4T4AEGhbdRDy8/e6HudUqLdSZzpdmPKRFHz2QaidDxgTFigDa5I9/06LR/3rnTK8T3Xhkpuren8eHnx+TyVLlul5I+8hcuBoubCqp+1RAbjtnDSZA0/Aa4KSx1+dgqcNgm3tXIcEml+K8y3kvUels90LjN4vrJYbVNumluR28Hw7Pj5lzilbF1qlxhPJ0iKIYlHyAJVISK8gMZsF0KVDyaPzCF5s7wblqvuqXI5a63NZrJoaEck4lkyYwaE2eWjvrj3cAM5ZuZUkLAXgCh735PLY1ZtlBWg4+qLeOUc4JsKIxAhdbBPwLAx9C7SSURhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLdWTx1s9q+5qT/t6cSUh6bAuhdO1DQ73VJqJh5f3KE=;
 b=YlOiYAyyWPKzKtvFEnu8casfk4ZEnd7vULl+ConzktBKiOJva2+Jb2Ra6l/5QyF/6hdjn0uhPQVaf1s6qKwq8VOHHUs14EUFjioOrcmZuHyM+fxtpZrMSkRIp1U49o1jtKDl7yaqeubeUgZL8ICdIi4WiHJo7S671WqOSBfVjWUwaXgQqwYO+rccsGDWoHtqiK7UZmIbDdRXWa2BfqlQV2s0+WpTzgytGX2V39B8TyZUrMEfg89TkwpvaCxgo0SmKdSMrAqTSMAiaf6OJIhPVKL7dGGdv9r7OjAwNg1FpnEKYNsOu97OsM65Q/RSfx9BB5f17RQrTRZU406kNYJu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLdWTx1s9q+5qT/t6cSUh6bAuhdO1DQ73VJqJh5f3KE=;
 b=iezfp+k44NmzmlWa7f3ErugSYpVY3KWMoUuCAET+0fe7dm9/fhBrOFb7+WoF7pGpJUOx7+W72ygZyrYLCnFG8OW+zb3mMa1h5SFh2XCq6YeiStS5Z3+z2Ui5SEliQcYNzehLXAVIzE9vT6bFjkt+2yIHnfYo2TJIxQzX7NkYPc8=
Received: from AS8PR06MB7845.eurprd06.prod.outlook.com (2603:10a6:20b:3c4::16)
 by DBAPR06MB6645.eurprd06.prod.outlook.com (2603:10a6:10:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 16:18:21 +0000
Received: from AS8PR06MB7845.eurprd06.prod.outlook.com
 ([fe80::3da3:1757:e851:16ed]) by AS8PR06MB7845.eurprd06.prod.outlook.com
 ([fe80::3da3:1757:e851:16ed%9]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 16:18:20 +0000
From:   LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree <devicetree@vger.kernel.org>
Subject: RE: [PATCH V2 3/6] iio: accel: bmi088: modified the device name
Thread-Topic: [PATCH V2 3/6] iio: accel: bmi088: modified the device name
Thread-Index: AQHYZHjA/oFMmX3d+0urtsNRwwtc4q0a27sAgACPeaA=
Date:   Thu, 12 May 2022 16:18:20 +0000
Message-ID: <AS8PR06MB784537D5C27DE4D867CF5064D7CB9@AS8PR06MB7845.eurprd06.prod.outlook.com>
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20220510141753.3878390-4-Qing-wu.Li@leica-geosystems.com.cn>
 <CA+U=Dsqu_5JVyhs8juznQ5SyBx1V6Q5yT-fsnYuoYHX9ESE=Tg@mail.gmail.com>
In-Reply-To: <CA+U=Dsqu_5JVyhs8juznQ5SyBx1V6Q5yT-fsnYuoYHX9ESE=Tg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com.cn;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d0b4111-cc60-4d70-6c46-08da343307b2
x-ms-traffictypediagnostic: DBAPR06MB6645:EE_
x-microsoft-antispam-prvs: <DBAPR06MB66456B948E6FEF516B05D225D7CB9@DBAPR06MB6645.eurprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DFlDwLfYefJLy4WH5IILGGBkOC7dxHadTTFQFvviyeB3NH6t8LWnsgKRr0gFzvf37DZoxDaZnzHDwU3jCQ1hu8CWZ+YghFH9ZGJjNO3y9tW9QD580hTiFmQIohkw8FoKiK3FlRmravSpz5RvB38d9JdXxm294DTeMJ/Sc1gnj/YUI9LDM92OX4chlYacmVUE4KPdnXf+PoE7QVTRGFWBFTUK8FXmd1Egdf8HbzbvbhsB7BACYYtSfMlVTrEyFII19ho3PW/3sF/xPgpLgOqNulF42L6rfKninQ1Simi1wbghK3lP7rm0F++R0A2sGjRadd5Dwwgqcq6Uwe1ZAfoTonGB7s+RsMtasjoXISBrOViBNLDmjVQSAhmlI22Ftxvd/lgkg7gLEBISJyCJ5VySWYzWyZbOt1R8d8RnlHJHe8kYMDDeSgNreSzR3JUv/thge2mihpRliw0cvHZyf8LFgEF3ftPxdxsPYNmVVdd9VDWwo8dQJQhaMLqwHLGau1lm6ZArEHHnI5pyaEGFUpDSIdu+UZZKw4aNkDZX9B2hLs2k90ZPC6U9qdObHF9osAb/5lMENw6ToVikVH1yDDOSCBdkPB3MDvZTy1jgO43BhdGgiKmImtMSHtu7jNA6gzFg6cOXIEx82a/tjCtukf+gz+4P/iXMwLhDhuH0m/HWcAHe6UMWAzyRsoxzbPUEcUIG1rXkRCsJeKQn4MUfWDX31Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR06MB7845.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(66946007)(2906002)(66476007)(66556008)(86362001)(71200400001)(508600001)(55016003)(316002)(66446008)(64756008)(9686003)(33656002)(8676002)(4326008)(5660300002)(38070700005)(53546011)(6506007)(122000001)(83380400001)(38100700002)(52536014)(26005)(45080400002)(8936002)(186003)(7696005)(6916009)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eW9vUWlOQWhpLytCS1ZxRGRDY1FvWVRPM2tiam1FMlRQVC91UzFOci82QUZK?=
 =?utf-8?B?cE94ZDlhMUxQZnpneEZKQ0E3UElONUdsY0dGVlFJRzRDOGJvM2VRT0tUTXor?=
 =?utf-8?B?TEE5NWpQL1NCRWNINmp3RXY5a2hZSzVBZllibHZLek0zQzJpZGlUVkVpNFBQ?=
 =?utf-8?B?UEkwbkhldGp0Vk1reTRUMmhhNUpsM2paelBPdmorRTZ1M2pCUzB4TjVBdUVW?=
 =?utf-8?B?NVdxd0N3RWNJbXJQbHZNWHNRNk12QVd5dW41WWNSeWVlMWNOazdIUEkwUGk3?=
 =?utf-8?B?Sm55NGFsVjEzeHFMQUNlYXV6Nmp2YW9HWDdONzIxVXhuRE1ObTNlWnhnUmli?=
 =?utf-8?B?SmZyNzAyT0NCejZVZVBuQTFzUWxTRk1OU1BuSWNrY0pRQzh4VWpzMndrK3VV?=
 =?utf-8?B?LzdibDNHNkR5dHFJbTZlYlJpV1p1aEpTUjF2c1o0TE9WU0x5eXp4RGowVURY?=
 =?utf-8?B?OTRRd3BadjE0NHFIMlRhU0hYSkloSUhzNHI3MHFCQWFJTGJvWlZEOWVkeXlG?=
 =?utf-8?B?eTNxZlBJM0kyeVJuSVNRVkJOMnRnR0tqS1lRNHlPeE9YUGYzM3BaK1NjMUJM?=
 =?utf-8?B?U0t0S0djME1oUUNNZEFjT0U5MC9GSExSbDUzQ3F5WVZNakNHbyt4c0tNMmRh?=
 =?utf-8?B?bnBNRndZVVNCR29aK2Z5ZDlsdVRSMzNuQzBiV0VzQnkvNUN2SlNlbmU0T2xt?=
 =?utf-8?B?eHhlVUZKek9aNlVNV1JvQnA3clhvZG5pNy84dk41ZjJTeXFQYnI0WUo3U2g4?=
 =?utf-8?B?ZUNPTkVKck9WM2pvNUhoa2tHaXRSWWQ4LzE3bUhEM00ydGNEbVZmanVjV3N6?=
 =?utf-8?B?NUFsTWh5aFZDRlNNanU2MGJEK2I0b3VCZmpIK2prOEFPRGdoZWhUUnpUaVBC?=
 =?utf-8?B?dGIxZVFQdWtBZFNxOWNKeDN5SDNWN0c5SFVvNUlUSDFuQlZYUlQwaVd4YTBs?=
 =?utf-8?B?VU9YQlI2bnkwdlkyN0t6Vis3dTFFMzBMWmI0bXRsLzdMQmZPNjQwYmZXRStq?=
 =?utf-8?B?djJGMjFmSkRhejVXY283WHNwUXJycWZ5bWR4dU9KNFhFSmlyWFhYZFFvdUlX?=
 =?utf-8?B?RmhnT3BSalltbWFoR2RBR1MvMGpuVGxJTFE5RUVDNGdoTzJJU28wdmlpSm90?=
 =?utf-8?B?cFZ1OG9HTVhPV3lLbUg2WjB2Y05IL1ZpTU5LWUd2UUlEL2xndUo4Uktpbncw?=
 =?utf-8?B?UUNkS1d4UGpYU1FMWWRueldoVTRrUVJuUWpmRE54M2dNN0NUaEJKWU1oWnN4?=
 =?utf-8?B?ZDRtRWR6Tit5RjZTM1ozcy9Ha2lPcG1XdnhZSWlEdEduVnVwSnlaUUc2cnBE?=
 =?utf-8?B?Wmt3VWJzaHl1azRHVExTQzFYYXFaazJYd2ZpL0VzNnArZ2dRZFh6QVJyVm1D?=
 =?utf-8?B?VUFaU251bFRHTGY4UndFdWxleFNNMmMyNlRMSG9Fdzgzc0piVTgrNkhPbmE1?=
 =?utf-8?B?ZXJOcDF2YWhoVERTTXUzM2ZuOHZrLzc1OXE2RkxMakg4YUlXZUtOaE5LdGwr?=
 =?utf-8?B?cWJjVW1nQVlUclRPeSs3OVM2YVFaaW1HUEZTU09LUExGbk4yWHMzanhYdEwv?=
 =?utf-8?B?dzFyMkhtaTV3UDlMemFmMTVobkc2aVkveDVRWHlMKzNQRk1yTGZCRlRZT3Zq?=
 =?utf-8?B?M1dWeGFtWlBSOVhYV2FqYlUrL1pXbXdyRExFMHUvYUhHalIxSyt4UThPQ1c0?=
 =?utf-8?B?N0dqbkpQcUpCYnBTa0M3RUpHckVIa3V5emRjdmhUMzYrRWEzbngxNlpLdnk5?=
 =?utf-8?B?dDRZUWJvT2ZBalRiR2FZbEtPTzZSeUViSWMvd0oxSmFnT3M0dWl3TzhjZmFR?=
 =?utf-8?B?ZE9oVkNRVWJmN0V3WnJrNUxwU1lsK1l0OEhMSUZjVlNxWDlZRlRoaHNSSHY5?=
 =?utf-8?B?S01KampMdHl4Qm4vKzBReER3ZVVKUFJQblAzTEtoLzRKKzRHUU5HMHFiU202?=
 =?utf-8?B?eUUrbnhWcE8wdXJ2ZktmcDdiYXNoWm5BUHVhNUk4TVV0MlBQR04rV0F6d0pY?=
 =?utf-8?B?dnNIOHFMeFAwSTdXa2tHU01sVW05dGljbjNtSW9WZ2pkOUlSb1VIWjM3aUkr?=
 =?utf-8?B?YkQ1WVNXTjM1ak9aNkhKaUxIeTBNLy9VSGlxcjEvOG1rQUhkY3ljLytPejlV?=
 =?utf-8?B?NWVTTFRXbGlmc210VzdYVVB5WURnSk5DZjNDQ3hpOExCcFR2eDNxMXJBcWFy?=
 =?utf-8?B?U05Ud1ZJVXI5ZGduUldtcmpBcTJLZ2gyVlFtSVZHdGtFMzBuNEU3dWNHK2dm?=
 =?utf-8?B?UU1RKzZ6QS9jRG9vdmg5TWZmRGhPaUUvaHI1ajVudUc2WG1QMU5ZVFhWK1FL?=
 =?utf-8?B?akRtVVJlYmJCVUtpOVBDZ0tuU2RWRW1iZTZDeUxnMGRqMGZEN1MzenIvaXFF?=
 =?utf-8?Q?zbLzfeWVXLxehtVsZD+am8WexgkY1AHBeQVqX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR06MB7845.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0b4111-cc60-4d70-6c46-08da343307b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 16:18:20.3300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7TJ00GUdmIZb6gWX0sZESXuOwQVCxKs9aDgtN5NiYj5ozsmulpZQWVJSy8xsZ8UV6o7NE0BA6JirqNUrqUlDoseo8Kfhpf1r7R+FfshoQED4cNUdCQN1TmATAAw3ak17
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB6645
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXhhbmRydSBBcmRlbGVh
biA8YXJkZWxlYW5hbGV4QGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1heSAxMiwgMjAy
MiAzOjMyIFBNDQo+IFRvOiBMSSBRaW5nd3UgPFFpbmctd3UuTGlAbGVpY2EtZ2Vvc3lzdGVtcy5j
b20uY24+DQo+IENjOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsgTGFycy1Q
ZXRlciBDbGF1c2VuDQo+IDxsYXJzQG1ldGFmb28uZGU+OyBtY2hlaGFiK2h1YXdlaUBrZXJuZWwu
b3JnOyBsaW51eC1paW8NCj4gPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBMS01MIDxsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcNCj4gPHJvYmgrZHRAa2VybmVs
Lm9yZz47IE1pa2UgTG9vaWptYW5zIDxtaWtlLmxvb2lqbWFuc0B0b3BpYy5ubD47IGRldmljZXRy
ZWUNCj4gPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IFYyIDMvNl0gaWlvOiBhY2NlbDogYm1pMDg4OiBtb2RpZmllZCB0aGUgZGV2aWNlIG5hbWUNCj4g
DQo+IFRoaXMgZW1haWwgaXMgbm90IGZyb20gSGV4YWdvbuKAmXMgT2ZmaWNlIDM2NSBpbnN0YW5j
ZS4gUGxlYXNlIGJlIGNhcmVmdWwgd2hpbGUNCj4gY2xpY2tpbmcgbGlua3MsIG9wZW5pbmcgYXR0
YWNobWVudHMsIG9yIHJlcGx5aW5nIHRvIHRoaXMgZW1haWwuDQo+IA0KPiANCj4gT24gVHVlLCBN
YXkgMTAsIDIwMjIgYXQgNToxOCBQTSBMSSBRaW5nd3UNCj4gPFFpbmctd3UuTGlAbGVpY2EtZ2Vv
c3lzdGVtcy5jb20uY24+IHdyb3RlOg0KPiA+DQo+ID4gSXQgaXMgcG9zc2libGUgdG8gaGF2ZSBt
dWx0aXBsZSBzZW5zb3JzIGNvbm5lY3RlZCBvbiB0aGUgc2FtZQ0KPiA+IHBsYXRmb3JtLCBUbyBz
dXBwb3J0IG11bHRpcGxlIHNlbnNvcnMsIHRoZSBjb21taXQgbWFrZXMgaXQgcG9zc2libGUgdG8N
Cj4gPiBvYnRhaW4gdGhlIGRldmljZSBuYW1lIGJ5IHJlYWRpbmcgdGhlIGNoaXAgSUQgaW5zdGVh
ZCBvZiB0aGUgZGV2aWNlLXRyZWUNCj4gbmFtZS4NCj4gPiBUbyBiZSBjb21wYXRpYmxlIHdpdGgg
cHJldmlvdXMgdmVyc2lvbnMsIHJlbmFtIGJtaTA4OGEgdG8gYm1pMDg4LWFjY2VsLg0KPiANCj4g
Ly8gbXkgc3BlbGxjaGVjayBpbiBHTWFpbCBmb3VuZCB0aGlzIDpwDQo+IA0KPiB0eXBvOiByZW5h
bSAtPiByZW5hbWUNCj4gDQo+IEkgYWxzbyBoYXZlIGEgY29tbWVudCBhYm91dCBhIGR1cGxpY2F0
aW9uIHRoYXQgaXMgaGlnaGxpZ2h0ZWQgYnkgdGhpcyBjaGFuZ2UuDQo+IA0KPiBZb3UgY2FuIGRp
c3JlZ2FyZCBteSBjb21tZW50IGFib3V0IHRoZSBkdXBsaWNhdGlvbiBhbmQgbGVhdmUgdGhpcyBj
aGFuZ2UNCj4gYXMtaXMuDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTEkgUWluZ3d1IDxR
aW5nLXd1LkxpQGxlaWNhLWdlb3N5c3RlbXMuY29tLmNuPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2lpby9hY2NlbC9ibWkwODgtYWNjZWwtY29yZS5jIHwgNiArKystLS0NCj4gPiBkcml2ZXJzL2lp
by9hY2NlbC9ibWkwODgtYWNjZWwtc3BpLmMgIHwgNCArLS0tDQo+ID4gIGRyaXZlcnMvaWlvL2Fj
Y2VsL2JtaTA4OC1hY2NlbC5oICAgICAgfCAyICstDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaWlvL2FjY2VsL2JtaTA4OC1hY2NlbC1jb3JlLmMNCj4gPiBiL2RyaXZlcnMvaWlvL2FjY2Vs
L2JtaTA4OC1hY2NlbC1jb3JlLmMNCj4gPiBpbmRleCA4ZmVlMWQwMmU3NzMuLmRlMjM4NWU0ZGFk
NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9hY2NlbC9ibWkwODgtYWNjZWwtY29yZS5j
DQo+ID4gKysrIGIvZHJpdmVycy9paW8vYWNjZWwvYm1pMDg4LWFjY2VsLWNvcmUuYw0KPiA+IEBA
IC00NTksNyArNDU5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjDQo+ID4g
Ym1pMDg4X2FjY2VsX2NoYW5uZWxzW10gPSB7DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVj
dCBibWkwODhfYWNjZWxfY2hpcF9pbmZvIGJtaTA4OF9hY2NlbF9jaGlwX2luZm9fdGJsW10gPSB7
DQo+ID4gICAgICAgICBbMF0gPSB7DQo+ID4gLSAgICAgICAgICAgICAgIC5uYW1lID0gImJtaTA4
OGEiLA0KPiA+ICsgICAgICAgICAgICAgICAubmFtZSA9ICJibWkwODgtYWNjZWwiLA0KPiA+ICAg
ICAgICAgICAgICAgICAuY2hpcF9pZCA9IDB4MUUsDQo+ID4gICAgICAgICAgICAgICAgIC5jaGFu
bmVscyA9IGJtaTA4OF9hY2NlbF9jaGFubmVscywNCj4gPiAgICAgICAgICAgICAgICAgLm51bV9j
aGFubmVscyA9IEFSUkFZX1NJWkUoYm1pMDg4X2FjY2VsX2NoYW5uZWxzKSwNCj4gPiBAQCAtNTI0
LDcgKzUyNCw3IEBAIHN0YXRpYyBpbnQgYm1pMDg4X2FjY2VsX2NoaXBfaW5pdChzdHJ1Y3QNCj4g
PiBibWkwODhfYWNjZWxfZGF0YSAqZGF0YSkgIH0NCj4gPg0KPiA+ICBpbnQgYm1pMDg4X2FjY2Vs
X2NvcmVfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgcmVnbWFwICpyZWdtYXAsDQo+
ID4gLSAgICAgICBpbnQgaXJxLCBjb25zdCBjaGFyICpuYW1lLCBib29sIGJsb2NrX3N1cHBvcnRl
ZCkNCj4gPiArICAgICAgIGludCBpcnEsIGJvb2wgYmxvY2tfc3VwcG9ydGVkKQ0KPiA+ICB7DQo+
ID4gICAgICAgICBzdHJ1Y3QgYm1pMDg4X2FjY2VsX2RhdGEgKmRhdGE7DQo+ID4gICAgICAgICBz
dHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2Ow0KPiA+IEBAIC01NDUsNyArNTQ1LDcgQEAgaW50IGJt
aTA4OF9hY2NlbF9jb3JlX3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiBzdHJ1Y3QgcmVn
bWFwICpyZWdtYXAsDQo+ID4NCj4gPiAgICAgICAgIGluZGlvX2Rldi0+Y2hhbm5lbHMgPSBkYXRh
LT5jaGlwX2luZm8tPmNoYW5uZWxzOw0KPiA+ICAgICAgICAgaW5kaW9fZGV2LT5udW1fY2hhbm5l
bHMgPSBkYXRhLT5jaGlwX2luZm8tPm51bV9jaGFubmVsczsNCj4gPiAtICAgICAgIGluZGlvX2Rl
di0+bmFtZSA9IG5hbWUgPyBuYW1lIDogZGF0YS0+Y2hpcF9pbmZvLT5uYW1lOw0KPiA+ICsgICAg
ICAgaW5kaW9fZGV2LT5uYW1lID0gZGF0YS0+Y2hpcF9pbmZvLT5uYW1lOw0KPiANCj4gKHdpdGgg
dGhpcyBjaGFuZ2UpIGkgY2FuIGJldHRlciBzZWUsIGEgYml0IG9mIGR1cGxpY2F0aW9uIGJldHdl
ZW4gdGhlIHNwaV9kZXZpY2UNCj4gdGFibGUgYW5kIHRoZSBjaGlwX2luZm8gdGFibGUNCj4gDQo+
IHRoaXMgd2FzIG5vdCBpbnRyb2R1Y2VkIGJ5IHRoaXMgY2hhbmdlLCBidXQgaXQgd2FzIG1hZGUg
YSBiaXQgbW9yZSBvYnZpb3VzIGJ5DQo+IHRoaXMgY2hhbmdlOw0KPiANCj4gb25lIHdheSB0byBh
ZGRyZXNzIHRoaXMsIGlzIHRvIHJlbW92ZSB0aGUgYGNvbnN0IGNoYXIgKm5hbWU7YCBhbmQgY29u
dGludWUNCj4gdXNpbmcgdGhlIGBuYW1lYCBwcm92aWRlZCBhcyBhIHBhcmFtZXRlciBmcm9tIGJt
aTA4OF9hY2NlbF9jb3JlX3Byb2JlKCk7DQo+IChhcG9sb2dpZXMgaWYgSSBzZWVtIHRvIGhhdmUg
Y2hhbmdlZCBteSBtaW5kIChmcm9tIHRoZSBwcmV2aW91cyBjaGFuZ2VzZXQpLCBidXQNCj4gSSBk
aWQgbm90IHNlZSBpdCB0b28gd2VsbCBiZWZvcmUpDQo+IA0KPiBhbmQgd2UgY2FuIGNvbnZlcnQN
Cj4gDQo+IGVudW0gew0KPiAgICBJRF9CTUkwODgsDQo+ICAgIElEX0JNSTA4NSwNCj4gICAgLi4u
DQo+IH07DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBibWkwODhfYWNjZWxfY2hpcF9pbmZv
IGJtaTA4OF9hY2NlbF9jaGlwX2luZm9fdGJsW10gPSB7DQo+ICAgICAgICAgIFtJRF9CTUkwODhd
ID0gew0KPiAgICAgICAgICAgICAgICAgIC5jaGlwX2lkID0gMHgxRSwNCj4gICAgICAgICAgICAg
ICAgICAuY2hhbm5lbHMgPSBibWkwODhfYWNjZWxfY2hhbm5lbHMsDQo+ICAgICAgICAgICAgICAg
ICAubnVtX2NoYW5uZWxzID0gQVJSQVlfU0laRShibWkwODhfYWNjZWxfY2hhbm5lbHMpLA0KPiAg
ICAgICAgIH0sDQo+ICAgICAgICAgIFtJRF9CTUkwODVdID0gew0KPiAgICAgICAgICAuLi4uLi4u
Lg0KPiANClRoYW5rcyBBcmRlbGVhbiwNCg0KVGhlcmUgaXMgYSBjYXNlIHdoZXJlIHNvbWUgZGlm
ZmVyZW50IHNlbnNvcnMgYXJlIGNvbm5lY3RlZCB0byBvbmUgc3lzdGVtLCANCkZvciB1c2VyIHNw
YWNlIGlzIG5pY2UgaWYgY2FuIGRldGVjdCB3aGljaCBzZW5zb3IgaXMgcHJlc2VudCwgaWYgdXNp
bmcgdGhlIG5hbWUgaW4gc3BpX2RldmljZSB0YWJsZSwgDQp0aGUgbmFtZSBtYXkgYmUgaW5jb25z
aXN0ZW50IHdpdGggdGhlIGNvbm5lY3RlZCBzZW5zb3IuIFdoYXQncyB5b3VyIG9waW5pb24/DQoN
Cg0KPiA+ICAgICAgICAgaW5kaW9fZGV2LT5hdmFpbGFibGVfc2Nhbl9tYXNrcyA9IGJtaTA4OF9h
Y2NlbF9zY2FuX21hc2tzOw0KPiA+ICAgICAgICAgaW5kaW9fZGV2LT5tb2RlcyA9IElORElPX0RJ
UkVDVF9NT0RFOw0KPiA+ICAgICAgICAgaW5kaW9fZGV2LT5pbmZvID0gJmJtaTA4OF9hY2NlbF9p
bmZvOyBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL2lpby9hY2NlbC9ibWkwODgtYWNjZWwtc3Bp
LmMNCj4gPiBiL2RyaXZlcnMvaWlvL2FjY2VsL2JtaTA4OC1hY2NlbC1zcGkuYw0KPiA+IGluZGV4
IGRkMWUzZjZjZjIxMS4uMGZlZDAwODFlMWZkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlv
L2FjY2VsL2JtaTA4OC1hY2NlbC1zcGkuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2FjY2VsL2Jt
aTA4OC1hY2NlbC1zcGkuYw0KPiA+IEBAIC00Miw3ICs0Miw2IEBAIHN0YXRpYyBzdHJ1Y3QgcmVn
bWFwX2J1cyBibWkwODhfcmVnbWFwX2J1cyA9IHsNCj4gPiBzdGF0aWMgaW50IGJtaTA4OF9hY2Nl
bF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKSAgew0KPiA+ICAgICAgICAgc3RydWN0IHJl
Z21hcCAqcmVnbWFwOw0KPiA+IC0gICAgICAgY29uc3Qgc3RydWN0IHNwaV9kZXZpY2VfaWQgKmlk
ID0gc3BpX2dldF9kZXZpY2VfaWQoc3BpKTsNCj4gPg0KPiA+ICAgICAgICAgcmVnbWFwID0gZGV2
bV9yZWdtYXBfaW5pdCgmc3BpLT5kZXYsICZibWkwODhfcmVnbWFwX2J1cywNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICBzcGksICZibWkwODhfcmVnbWFwX2NvbmYpOyBAQCAtNTIsOCArNTEs
Nw0KPiBAQA0KPiA+IHN0YXRpYyBpbnQgYm1pMDg4X2FjY2VsX3Byb2JlKHN0cnVjdCBzcGlfZGV2
aWNlICpzcGkpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHJlZ21hcCk7DQo+
ID4gICAgICAgICB9DQo+ID4NCj4gPiAtICAgICAgIHJldHVybiBibWkwODhfYWNjZWxfY29yZV9w
cm9iZSgmc3BpLT5kZXYsIHJlZ21hcCwgc3BpLT5pcnEsDQo+IGlkLT5uYW1lLA0KPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRydWUpOw0KPiA+ICsgICAgICAgcmV0
dXJuIGJtaTA4OF9hY2NlbF9jb3JlX3Byb2JlKCZzcGktPmRldiwgcmVnbWFwLCBzcGktPmlycSwN
Cj4gPiArIHRydWUpOw0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGludCBibWkwODhfYWNjZWxf
cmVtb3ZlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpIGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMv
aWlvL2FjY2VsL2JtaTA4OC1hY2NlbC5oIGIvZHJpdmVycy9paW8vYWNjZWwvYm1pMDg4LWFjY2Vs
LmgNCj4gPiBpbmRleCA1YzI1ZjE2YjY3MmMuLmMzMmFmZTk2MDZhOCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2lpby9hY2NlbC9ibWkwODgtYWNjZWwuaA0KPiA+ICsrKyBiL2RyaXZlcnMvaWlv
L2FjY2VsL2JtaTA4OC1hY2NlbC5oDQo+ID4gQEAgLTEyLDcgKzEyLDcgQEAgZXh0ZXJuIGNvbnN0
IHN0cnVjdCByZWdtYXBfY29uZmlnDQo+ID4gYm1pMDg4X3JlZ21hcF9jb25mOyAgZXh0ZXJuIGNv
bnN0IHN0cnVjdCBkZXZfcG1fb3BzDQo+ID4gYm1pMDg4X2FjY2VsX3BtX29wczsNCj4gPg0KPiA+
ICBpbnQgYm1pMDg4X2FjY2VsX2NvcmVfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qg
cmVnbWFwICpyZWdtYXAsDQo+IGludCBpcnEsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IGNoYXIgKm5hbWUsIGJvb2wgYmxvY2tfc3VwcG9ydGVkKTsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYm9vbCBibG9ja19zdXBwb3J0ZWQpOw0KPiA+ICBpbnQgYm1p
MDg4X2FjY2VsX2NvcmVfcmVtb3ZlKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4NCj4gPiAgI2Vu
ZGlmIC8qIEJNSTA4OF9BQ0NFTF9IICovDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0K
