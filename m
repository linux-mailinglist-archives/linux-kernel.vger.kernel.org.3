Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA4A50ADAC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiDVCWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiDVCWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:22:08 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150049.outbound.protection.outlook.com [40.107.15.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B445948389;
        Thu, 21 Apr 2022 19:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBGm1CgVrwIilqhzSF4koLeIWICqvJeidJClGsm+t4/CWXaWmCu/yj1dtf3J7UuX7YolFQTCIjJirkv3Fi+6PS+Vu13ZIdAn5hNpH5HIxRvA8MTXGMUxTNHwhVNps5Opgei3LOxpc6n5Ngly6T7sM+9rlEu5cy0u5RndbQdKocIekRQHsDJKIkoV+oUHBEpbz09UJ6qk49BH7OIJaYkZLr4oLeRw2J0qa6XBIQREMY3F6Tost351F/ENVLq/rmv/iOZM0BT2E7wrN33GkfRMu5PVJ0UcuWviE7j6bGTkoH4NCkkVblXG4p+r0aScp14+eHMAt/xX+VjckBUwyeLlow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=altgA1rjBF1252W74caRk76yRlwx+HdfCMonRXqD8Ys=;
 b=kn3KgE1vaHCOJF+wxiWWuAkGZW/qUqKFP02FoI8KUXGwrKqgDcQNHisRAEAT1JZsQNZ8KJRmChm0muKiAdXiM0Hy52E0aCnElTxVsvyqKg6tRu9DsdGDgbyO/hR4uFdWJhSNWqYTa0CbKfTuF4l9GbUpVp160q+bywJ5RVSQ9qS2yJlxTTI3W89tNANSHqJr3xoSlvIOw+2NxaLSYSq4DcShdO6SD1kxImpy2dNvqc2seF+UZpSxRXFxnc0pNBRebKvPl7d+uvTh1Q+MbkBF4/ISfLrQAVeX2ox4VvXQSOu/Ep7KiSC471IiUAQ8mpPCV+Sx2SA84eIiD2kopRntVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=altgA1rjBF1252W74caRk76yRlwx+HdfCMonRXqD8Ys=;
 b=s51cq9Uza7FOSoc383k2zYa5uVw+niYx1YypJx1nbjoxulq0DcQhfumD7ynmGWVdnkc9W0erwFbFnaDssZRaGuIIgGC86N96msNoEaZRI49b6mWs49iMPu+1i2+ngbSKW4IfMBKJE/p3KsFel3UMQXkzfqrSt3JuwA9gxPhrJrw=
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by DB6PR0401MB2568.eurprd04.prod.outlook.com (2603:10a6:4:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 02:19:14 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 02:19:14 +0000
From:   Jerry Huang <jerry.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>, Michael Walle <michael@walle.cc>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Leo Li <leoyang.li@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>
Subject: RE: [EXT] Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech
 sx1301
Thread-Topic: [EXT] Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech
 sx1301
Thread-Index: AQHYVIiygEZn3a5TtE+wxprjnFe3kqz4tPoAgAFfCfCAAARPAIAAB12AgABOGQCAAA7AAIAAQLuAgAB38FA=
Date:   Fri, 22 Apr 2022 02:19:14 +0000
Message-ID: <VE1PR04MB64775BB830C830016243CACAFEF79@VE1PR04MB6477.eurprd04.prod.outlook.com>
References: <f6086989-a4c1-4223-fad0-79bd5719432e@linaro.org>
 <20220421094421.288672-1-michael@walle.cc>
 <YmFo+EntwxIsco/t@robh.at.kernel.org>
 <30f2f62406bab8225cc88013b414016d@walle.cc>
 <CAL_JsqJr0fvqL_6CL__Q6aY0AVD+gL4=g46Y=j2r=fJy9jDwGg@mail.gmail.com>
In-Reply-To: <CAL_JsqJr0fvqL_6CL__Q6aY0AVD+gL4=g46Y=j2r=fJy9jDwGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b6f631d-9037-4ca0-6a4c-08da24067eeb
x-ms-traffictypediagnostic: DB6PR0401MB2568:EE_
x-microsoft-antispam-prvs: <DB6PR0401MB25683B492F7A3DDD29BAC925FEF79@DB6PR0401MB2568.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 74sUM65nCrEKnyVMHD8FmSFSClmb49YMmDjnzPZ5ZhAQX8v83DtmfTQNfNDN8nLFJHdDmlVhwYu5TOVHIi/EhSvd5uMqd4FwXOe3rslsOrt5zeNUT8ARsKdqdh2mHT//szfl9HcOo9Ktgvt8quUMCer7GAlKz625CJrMZ68mVYgE4S0rT2KOIEWYqklbH4pHbkFlw2/WazwpDxkILSZzqq/W4XByIQcuPmWfPHlhlHennAW2pLqeJ8Og4KhJKtut+Fr11+k2797kdgrc8IEKB3h5MMJwTQ5bH05LRppSwLkn7RHiZ0WEh9IBpRlvmilawo4l3pZIaRwuiQIV8GvNRMe+CnQGPYUNnSfVYcjCEbHD/bQyJG26DYwMpTmFGlPztD+yf4gxLwX1TSTNbAncElw6Esq2vLo5h3vOz2ZkE63c0i7NICeMFAGtFI2j1He4aWQhPYTCmDJX3FQ0tTCZSWoU8RZfap/N+ZT2rv6npXdhKllQ9peaoAVmaTA11o8zeEqYJ7XEyx3JaAy8fFgKW6AyYeo/ThaACtOwIDJMqHYyKm0I4exIFshmIfAWpneOxgVR/7QmlOodf/3jJP1ASyVPiwo0GCpdu/rVhCgn1fm9W+r2K7WVeziNpLi9KVmoYVyYfHLdf7lnGW9BXw5uubXlXAcW/mvwqeUqeHVG2FNPHzdWsRl8VR2KfAYQde0Hr2CORILuJi3nqoDBUhybzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(66556008)(8676002)(71200400001)(66476007)(66946007)(4326008)(64756008)(66446008)(76116006)(54906003)(110136005)(33656002)(316002)(122000001)(86362001)(38100700002)(5660300002)(52536014)(8936002)(7416002)(55016003)(44832011)(38070700005)(2906002)(83380400001)(186003)(26005)(6506007)(7696005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDlCQ2hTRWVrQWNNem9mbUVvdmF6WC9QZy9SWjY1alhrbWNnZSs2SHduUHo1?=
 =?utf-8?B?MmZzL01OM1E1MEpOTUVycXJTTXJrVHd0RlVmUE5EVmhSbk5JMlZnOEFLNHE1?=
 =?utf-8?B?VGV3dmNYdVlXQmkvTUNVaTczMEhVZ3hTd1lhOVVQTFBpMGhiT2trTEQyZWJJ?=
 =?utf-8?B?TzkvYzUvdVdhS0VhQSt3OU1ObmdETURWWVFKMHpxaWhlRHN0WVNXSFNlYzlM?=
 =?utf-8?B?ZGhLWFZVRDYxWnlhQ05WbUVuUkRnOFA5UUk2cFdqMHV4WU1neXpWSGJ3ZWFn?=
 =?utf-8?B?SlcyQmZUR3pVSCsySkpYWWdCNHN3RE0wQjZpWnZBZUdySmlRaHlLVmdGWkd4?=
 =?utf-8?B?TTJEMTBJWjZ0V1BRdGNIa0hKL2dYdDNVRnFDVEx2VXNscnZpNVdub1dYQlpX?=
 =?utf-8?B?Qk9TNXgySVIrTE9JT3UrT2ErVGtrVG1IcGEvUVZ4S3BYMUNINDVJbUU0K1Vh?=
 =?utf-8?B?SFIxaitNVERZWEFjWDl0aVp1QmY2UjNkb1EwZzAwejJSQXRUcm9RR2dEa3JK?=
 =?utf-8?B?NnlLczJFcnVEaExoUmJMTCtXTXN3ZUZoVC93Z00vRDlQRXN1YzkxTUdRMFpv?=
 =?utf-8?B?R3lKY2RTMEppK1FvcktuaGJNVHdMeWc5b25PNmNGY09Ub1k5dEVkaWZZVFRx?=
 =?utf-8?B?cDRtT2NDMnpLa2g1bk95RTNGWWs5NVdZV0FOakFFelNuQ1RMWWlaTGtZZVhN?=
 =?utf-8?B?cW1URm1RYVQvRWQwSW1EQXFJdk5uZkFySEF6cGtsVHkvY3kvMzVJM2NacWRS?=
 =?utf-8?B?SDRRMkJQbU1sdnlhelN2MzdTeC9DcUdNZ2JkVnFDSmFHS3Nvd3lXY2hyOXV2?=
 =?utf-8?B?UENsdWNYcWNhRGFGVXhvY0hYWWRORVp6SEl2bDJxbWQzQys1TFgxUHl6TzJC?=
 =?utf-8?B?OEtqSVVZcHJwcUxXOWc5T3ZpeUluK3J5aG5SbWJ2cHE4a2JJNFllWThPNTYy?=
 =?utf-8?B?Uk80UmF5Yy9rcVNLNnhZeG9tTjBPYU5UaU5MWkt6L21SNXdFb0FWdFh6TlFC?=
 =?utf-8?B?azBvU29icXJ2MjNFaXlNdnAwZDR5YzhlTmlsdTIxcUd5SHJtNE9xS0ZuajZC?=
 =?utf-8?B?TUk1MFk0cCtLRTJXa21GK21TYmJVVld3YmlZTUVJNS9uMHd1eW92Y3dHa2kr?=
 =?utf-8?B?dnVQL0NkMTBEb0ZJT2VKSmFSQnBSNnZmQkpULzFJamxVdVQ2dHorRFkxS3Ey?=
 =?utf-8?B?UUFyZVY2MnFlb1dIa1V1bzl1cm1HeExnWWZxVGZzRkZXYlQrZnZISGFhTWYx?=
 =?utf-8?B?enhaOEorVUVyVTFtMmFJMUM5N3NTblRDTHA3a0xNY1QzendTUjVwZk44Kzlm?=
 =?utf-8?B?OWdVN0ZyWVQ3MFpjMk9MSFhleHZYYndza2Y1d3dEb2oyTmszSFlmVldWSE5m?=
 =?utf-8?B?ODAxZURwQnY3cVc2dWVkVU1ISWZ2S0E2QnUwK1NpbElucW1sbllKMDI0K0hq?=
 =?utf-8?B?dXNqbFFzcEhCNUhkallHMCs4VUFtbWxSYURuWFhSbUljeER4V3NjRm05aW0w?=
 =?utf-8?B?MFFnNU1kZ25kNWllOVAweUpYLzJzRHRRdHJtQUtIT09TUDluVTZaRC8rbkwy?=
 =?utf-8?B?UFhsN1VYNjZnKzVoSlMwN1BERFdqeFNCUHNUMEpZWVJuUTIwSmIzZWRZMVlr?=
 =?utf-8?B?YW5SVnF6QURDTkNkSVV2Y0pYYkVqSVNJZnE5M1lSdVlZa1RoR2N1TCtHNVQ3?=
 =?utf-8?B?YjhwVDhGOGVQdEtNZU5CR0tSTitDUXpXNGRKbzZvekxYRDlYM2hLZDF5Mi9a?=
 =?utf-8?B?eklFWGQxenJvR0tFMzJDYWNTelN0VmMxNTE1QytKWXRRYzZqTW91SDRGYzY4?=
 =?utf-8?B?dzFGamJiNDhWQytIakhiUndweXNXZzNEZ2diU0R3U01SQ3B2cVRSUTNZLzkx?=
 =?utf-8?B?S2dTUTdCaE5WODlMRXIxRTRvVFBCaGJDRmZBVGxsc1hUUkp4V0dzdG5ocjNl?=
 =?utf-8?B?NHdKb3M0TEw2M3N1WUhLMC96THRkZVpNSndLU1RKblBQS01EOWNRM0xiRFRs?=
 =?utf-8?B?bU1VMkR0MzFlSWtVakFEd1ZuWlNYL1cvTmNWNGp2dVU4aXF6UkJQQnBwZWYx?=
 =?utf-8?B?NTBCZDJPOXZzMlB1KzVodDUyM1M1ZGtmYXNNS2dnNnY0Vzk0UUo1SC94aHdj?=
 =?utf-8?B?M2xjR29VTnNmakdiSXowV2w3a3doOFAySmtEZ3JZWkdVSkY3RTVvSm9kSmY0?=
 =?utf-8?B?WVFpeDltL2RBTGlSZ2xXNjNvd3ZvNlc3K0puWHQzNnJnMjBCTVJTN0U3cFZl?=
 =?utf-8?B?QkcyUkI4VEM5RGU4UUJFZ3A5UmJuT0U3aGhkVFZKUWpJSzA2QUtzSDN3SjNj?=
 =?utf-8?B?TitDV2NScFErdXd0NXJ4QmdBbkUzMVpVOGJ3OFVGSGhGVnF6ZTN4QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6f631d-9037-4ca0-6a4c-08da24067eeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 02:19:14.3795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e58GnVQopbL1P9Z2eZvlFHWraPW4LnDIp4wsyRkoxSjaXBCerssQABDfZL31qCeIVtVuCVs5tAL/rfh2NEABOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2568
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFJvYiBIZXJyaW5nIDxyb2Jo
QGtlcm5lbC5vcmc+DQo+U2VudDogMjAyMuW5tDTmnIgyMuaXpSAzOjA4DQo+VG86IE1pY2hhZWwg
V2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+Q2M6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlz
enRvZi5rb3psb3dza2lAbGluYXJvLm9yZz47IE1hcmsgQnJvd24NCj48YnJvb25pZUBrZXJuZWwu
b3JnPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IEplcnJ5IEh1YW5nDQo+PGplcnJ5Lmh1
YW5nQG54cC5jb20+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+PGtyenlzenRvZi5rb3psb3dza2kr
ZHRAbGluYXJvLm9yZz47IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsNCj5saW51eC1hcm0t
a2VybmVsIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+Ow0KPmxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXNwaSA8bGludXgtc3BpQHZnZXIua2VybmVsLm9y
Zz47IFNoYXduIEd1bw0KPjxzaGF3bmd1b0BrZXJuZWwub3JnPjsgVmxhZGltaXIgT2x0ZWFuIDxv
bHRlYW52QGdtYWlsLmNvbT4NCj5TdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCAxLzIgdjRd
IGR0LWJpbmRpbmdzOiBkc3BpOiBhZGRlZCBmb3Igc2VtdGVjaCBzeDEzMDENCj4NCj5DYXV0aW9u
OiBFWFQgRW1haWwNCj4NCj5PbiBUaHUsIEFwciAyMSwgMjAyMiBhdCAxMDoxNiBBTSBNaWNoYWVs
IFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPiB3cm90ZToNCj4+DQo+PiBBbSAyMDIyLTA0LTIxIDE2
OjIzLCBzY2hyaWViIFJvYiBIZXJyaW5nOg0KPj4NCj4+ID4gV2hhdCdzIG5lZWRlZCBoZXJlIGlz
IGEgY29ubmVjdG9yIG5vZGUgKGFuZCBkcml2ZXIpIGZvciB0aGUgbWlrcm9idXMNCj4+ID4gc29j
a2V0LiBUaGUgY29ubmVjdG9yIG5vZGUncyBwdXJwb3NlIGlzIHRvIGRlY291cGxlIHRoZSBob3N0
IERUIGZyb20NCj4+ID4gYWRkLW9uIGJvYXJkIG92ZXJsYXkgRFQuIFNvbWV0aGluZyBsaWtlIHRo
aXM6DQo+Pg0KPj4gRnVubnkgSSBoYWQgYSBzaW1pbGFyIGlkZWEgdG8gaGF2ZSBhIGNvbm5lY3Rv
ciB3aXRoIGFsbCB0aGUNCj4+IHByb3BlcnRpZXMsIGJ1dCBJIGZhaWxlZCB0byBzZWUgaG93IHRo
YXQgd291bGQgYmUgb2YgYW55IGhlbHAuDQo+Pg0KPj4gRG8geW91IG1pbmQgYW4gZXhhbXBsZSBv
ZiBzdWNoIGFuIG92ZXJsYXk/IEp1ZGdpbmcgYnkgdGhlIHNwaSBhbmQgaTJjDQo+PiBzdWJub2Rl
LCBJIGd1ZXNzIGl0IHdpbGwgYW1lbmQgdGhlIGNvbm5lY3RvciBub2RlIGFuZCBmaWxsIGluIGl0
J3MNCj4+IGRldmljZXM/DQo+DQo+UmlnaHQuDQo+DQo+Pg0KPj4gQW5kIGFsbCB0aGUgY2hpbGQg
ZGV2aWNlIHByb3BlcnRpZXMgd2lsbCByZWZlcmVuY2UgdGhlIGNvbm5lY3RvciwNCj4+IGNvcnJl
Y3Q/DQo+DQo+UmlnaHQuDQo+DQo+Pg0KPj4gPiBjb25uZWN0b3Igew0KPj4gPiAgICAgICAvLyBB
bmQgYSBtb3JlIHNwZWNpZmljIGNvbXBhdGlibGUgaWYgcGlucyBjYW4gaGF2ZSBhbHQgZnVuY3M/
DQo+PiA+ICAgICAgIC8vIFNwZWMgdmVyc2lvbiBuZWVkZWQ/DQo+PiA+ICAgICAgIGNvbXBhdGli
bGUgPSAibWlrcm9idXMtc29ja2V0IjsNCj4+ID4NCj4+ID4gICAgICAgLy8gV2lsbCBuZWVkIHJl
Z3VsYXRvcnMgZGVmaW5lZCBpZiBjaGlsZCBkZXZpY2VzIGV4cGVjdA0KPj4gPiAgICAgICAvLyBy
ZWd1bGF0b3JzDQo+PiA+ICAgICAgIHZjYy0zMy1zdXBwbHkgPSA8JnJlZzMzPjsNCj4+ID4gICAg
ICAgdmNjLTUtc3VwcGx5ID0gPCZyZWc1dj47DQo+PiA+DQo+PiA+ICAgICAgIGkyYy1wYXJlbnQg
PSA8JmkyYzE+OyAvLyBBbHJlYWR5IGEgZGVmaW5lZCBwcm9wZXJ0eQ0KPj4gPiAgICAgICBzcGkt
cGFyZW50ID0gPCZzcGkwPjsgLy8gTmV3DQo+Pg0KPj4gdWFydC9zZXJpYWwgbmVlZGVkIHRvbz8N
Cj4NCj5ZZXMuIFNlcmlhbCBoYXMgdGhlIGV4dHJhIGlzc3VlIGluIHRoZSBrZXJuZWwgdGhhdCB0
dHkgdnMuIHNlcmRldiBhcmUgbXV0dWFsbHkNCj5leGNsdXNpdmUgYW5kIGRlY2lkZWQgYnkgcHJl
c2VuY2Ugb3Igbm90IG9mIGEgY2hpbGQgbm9kZSBmb3IgdGhlIFVBUlQuIFRoYXQgd291bGQNCj5u
ZWVkIHNvbWUgd29yayB0byBkeW5hbWljYWxseSBzd2l0Y2guIEkgdGhpbmsgSSBoYXZlIHNvbWUg
b2xkIHBhdGNoZXMgZG9pbmcgdGhhdCwNCj5idXQgdGhleSBwcm9iYWJseSBicmVhayBzb21lIGFz
cGVjdHMgb2YgVFRZIGV4cGVjdGF0aW9ucy4NCj4NCj4+DQo+PiA+DQo+PiA+ICAgICAgIC8vIFJT
VCBwaW4NCj4+ID4gICAgICAgcmVzZXQtZ3Bpb3MgPSA8JmdwaW8gNCAwPjsNCj4+ID4NCj4+ID4g
ICAgICAgLy8gcmVtYXAgJ0lOVCcgKGluZGV4IDApIHRvIGhvc3QgaW50ZXJydXB0DQo+PiA+ICAg
ICAgICNpbnRlcnJ1cHQtY2VsbHMgPSA8Mj47DQo+PiA+ICAgICAgICNhZGRyZXNzLWNlbGxzID0g
PDA+Ow0KPj4gPiAgICAgICBpbnRlcnJ1cHQtbWFwID0gPDAgMCAmZ3BpbyAzIDA+Ow0KPj4gPg0K
Pj4gPiAgICAgICBzcGkgew0KPj4NCj4+IEZvciBleGFtcGxlOg0KPj4NCj4+IG15LWRldmljZUAw
IHsNCj4+ICAgIHJlZyA9IDwwPjsgIC8vIHJlYWxseSBuZWVkZWQ/IHRoZXJlIGlzIG9ubHkgb25l
IFNQSSBDUyBsaW5lDQo+DQo+WWVzLCBuZWVkZWQuDQo+DQo+PiAgICBjb21wYXRpYmxlID0gIm15
LWRldmljZSI7DQo+PiAgICByZXNldC1ncGlvcyA9IC8vIG1heSBiZSBsZWZ0IHVuc2V0IGlmIGl0
J3Mgb3B0aW9uYWwsIGJ1dCB3aGF0DQo+PiAgICAgICAgICAgICAgICAgIC8vIHdoYXQgaWYgaXQg
aXMgYSByZXF1aXJlZCBwcm9wZXJ0eSBhbmQgaW4gaGFyZHdhcmUNCj4+ICAgICAgICAgICAgICAg
ICAgLy8gaXRzIGNvbm5lY3RlZCB0byB0aGUgUlNUIHBpbiBvZiB0aGUgbW9kdWxlPw0KPg0KPlBy
b2JhYmx5IHNob3VsZCBub3QgYmUgcmVxdWlyZWQgYW5kIHRoZSBjb25uZWN0b3IgZHJpdmVyIG1h
bmFnZXMgaXQuDQo+DQo+PiAgICBvdGhlci1ncGlvcyA9IDwmY29ubmVjdG9yIDI+Ow0KPj4gICAg
dmRkLXN1cHBseSA9IC8vIHdoYXQgY29tZXMgaGVyZT8gPCZjb25uZWN0b3IgVkNDXzMzPj8NCj4N
Cj5UaGF0IGhhcyB0byBiZSBmaWd1cmVkIG91dCwgYnV0ICotc3VwcGx5IGRvZXNuJ3QgdGFrZSBh
cmcgY2VsbHMgY3VycmVudGx5LiBQcm9iYWJseQ0KPnRoZSBjb25uZWN0b3IgbmVlZHMgdG8gZGVm
aW5lIGl0cyBvd24gcmVndWxhdG9yIG5vZGVzLg0KPg0KPj4gICAgaW50ZXJydXB0cy1leHRlbmRl
ZCA9IDwmY29ubmVjdG9yIDAgLi4+OyB9DQo+DQpTbywgaG93IHRvIGhhbmRsZSB0aGUgTWtjcm9C
dXMgY29ubmVjdG9yPyBBbnkgc3VnZ2VzdGlvbiBmb3IgZm9sbG93aW5nPw0KJmRzcGkyIHsNCiAg
ICAgICAgYnVzLW51bSA9IDwyPjsNCiAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KDQogICAgICAg
IC8qIE1pa2Nyb0J1czEgKi8NCiAgICAgICAgc3BpQDAgew0KICAgICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAibWlrY3JvZSxtaWtjcm9lLXNvY2tldCI7DQogICAgICAgICAgICAgICAgcmVnID0g
PDA+Ow0KICAgICAgICAgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDIwMDAwMDA+Ow0KICAg
ICAgICAgICAgICAgIGZzbCxzcGktY3Mtc2NrLWRlbGF5ID0gPDEwMDAwMDA+Ow0KICAgICAgICAg
ICAgICAgIGZzbCxzcGktc2NrLWNzLWRlbGF5ID0gPDUwPjsNCiAgICAgICAgfTsNCn07DQo=
