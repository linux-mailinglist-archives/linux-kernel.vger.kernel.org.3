Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ACE4FBBB1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345968AbiDKMH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbiDKMHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:07:53 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2097.outbound.protection.outlook.com [40.107.23.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90D23AA43;
        Mon, 11 Apr 2022 05:05:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxbNdyHi8Zyj3QsPBGEnQzRTImpdccqkJRuUXnXDUV0xGpFnZpX0HvMa/fvO0mYIqWVSZz1WHWMg9Ee3cm8WSZ3CqwhFZsirLfRbbxt5MGWG7ivX6VFxgyX6oYf9UL1aEB7ftv9ziYEk5NCfZ8e2qoIKT1JrphtvUovzQKW1gVm5bktADWZmVfrPTR/Dyn/yU/79v/RXu85wQJ84HzHHC40xPwIYBZj02tZNtmreCkTSmFV0HcYg5hjepeF08ysAZValHZwFyOmLn3RwxTJxOorV7TGuYpAezbckQEHK2J41JBp0sVi4zTGw+kJBesm6KBKkMTeFfGWlIp/PotAjFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUdgluxbOBy9DTXs/LzzM/sVIrtWZ+mmT1j+BFU9hso=;
 b=SCJHTy73OuFc0POQmeYMkbBh6hudYKd2R3z6udFIca6RKMZCW27bA/0xS5OqePnUJoCt7+jrrQ0iS+lEW5Ztc8+4nvKYFunClC3WZnh1bJ5Fk57SlxNyeVocondKvhaBDrDSmfNk9qABaKv/CaCE9lVh4Cx7ZSTOys6ZXrCQSYfoBcoJ2++FhSQThgOAwL438jk7Ln67ZCcfcRzOu8k1t9bEsqo/HGck+2/IVSosN/h3zX4havqlFuIB0WOqUWocQ8/10fnaSWB4tzSn7dKPPgFe+xX9PCSGlqawjTCgUbPfKGcIZhXA2bjvCNN2Qf3Y3Xyyhcacn+L9gT883dXdPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUdgluxbOBy9DTXs/LzzM/sVIrtWZ+mmT1j+BFU9hso=;
 b=iB8CaT/sBGuBMHm61Eq17ONDvhlGA8TyfdlzVQ/nNUTKE09uXaO9jPaJ4/ywBi509wiX53pCa0/drlLURVIU6v+TsufIHsS3rfliBfc1bRAqni25fEOUMhfMxEc1sJLS/MU6qAHWAs2JFlJ5s12pwmbE4MF/fDQ+gcc/Vb8k1ic=
Received: from ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::14)
 by ZRAP278MB0463.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 12:05:36 +0000
Received: from ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
 ([fe80::e9e8:9f72:60fb:764d]) by ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
 ([fe80::e9e8:9f72:60fb:764d%3]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 12:05:36 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "linmq006@gmail.com" <linmq006@gmail.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: stmpe-adc: Fix wait_for_completion_timeout return
 value check
Thread-Topic: [PATCH] iio: stmpe-adc: Fix wait_for_completion_timeout return
 value check
Thread-Index: AQHYTY85OSoU7TvO+UiefovZ9TLxCazqnceA
Date:   Mon, 11 Apr 2022 12:05:36 +0000
Message-ID: <8b40cdebc07ff7ca29aa9fc03b8d9c40754ab4bd.camel@toradex.com>
References: <20220411103032.14038-1-linmq006@gmail.com>
In-Reply-To: <20220411103032.14038-1-linmq006@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f8741d2-8748-4c98-7aa5-08da1bb3967f
x-ms-traffictypediagnostic: ZRAP278MB0463:EE_
x-microsoft-antispam-prvs: <ZRAP278MB0463113ADC1BA869AB10822CF4EA9@ZRAP278MB0463.CHEP278.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: atquCx+hD0DfEr8W3MN/EjbimM1VdJSoOnFktfc2I3zNxRi9q3ynpoqOwG0vGeXx6IpDC4aftSKF4+6ifOT0e+84aaJYJjxMlWRmOJk2uxb1YJp28N48G1QaZs7sjoqC5XHjv7ydJqGVKR6/fgz/2nvna9ETH8gSMeuWK36B8mG62isDARKwW2/C51gjXtfhXRysxrpF8QkKvixsTejLOBW8rioh52EKe/7aSIk89D2/+yDTuXJzfV20rly2h1eSVZfk/dtYxZ6KaOFe6g9v2BnD4eJvR9vfrvrLA/zfbCpeM/HYWj/ffyD5c2sCnpwx/MAwtfbZaxZ6H7ydiMieyNOQw3YRdHmAvES5MJpqELU+tDpr8JzX+xM+DBBPLdVLHrZB6dU//Sg4eefHTPu3XjBwe3SCafaf/+M0QmtZ+Q/afJtVuOmET1MBfHInSNHzr5LxELmJOkbhGkKMCOY9iCDOuDmB4RFEnYg+v49W9EmtFTQeAjO5QKEDGRWRRloymVgNmUGxQgOj5mwJJP6Tvtrwok9EGMoSKTgjUJLI8t8KYb3gO2ZwGZKUXxsdU0XFvFkiYHuNf9SlnJW+1x+RSy6l6oeSWFx4ouLNvcYHvVhfLDT9TPlAktJOVM4/rq5QP6i7tVZn9f/TnvrGvVI17FCAsiEPW4wzILzqo+x4W1xkAWQsT51G+Rkd7tc1yuH7f6EX6GumXfEsJ7LdMrpsFuG2HbQRYpCBVHQWJpfAr7c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(136003)(346002)(396003)(376002)(39850400004)(366004)(66446008)(38100700002)(122000001)(64756008)(86362001)(8676002)(6486002)(66946007)(2616005)(508600001)(38070700005)(71200400001)(76116006)(8936002)(921005)(66476007)(110136005)(66556008)(316002)(2906002)(6506007)(44832011)(6512007)(83380400001)(26005)(186003)(7416002)(5660300002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHVMWHpIcXhBQ3Z0dDBWcnk0b0ZPT2JCWXY2RjJ1YndXYzd5R3pFa1M3LzVs?=
 =?utf-8?B?USt4TGtjZlBRZ09FRjIvQ3RFUGJnaElhSWt1d2hXaWl4c1QyNEc4cE1vNE5D?=
 =?utf-8?B?OWh4eGV5OUlzVE5ORlJURkQ2ZmZIVldYR25MTVZUTE5NdThSZjUwMkU0ZW5s?=
 =?utf-8?B?Y2FOU1kzTTFXUWVIT2I5MUttZ09iYXZTTjd5VVduQTdLaUxBUzMzVTdwTWlw?=
 =?utf-8?B?SVdxTWhEaTlURTRlaHl6RGZQaFRVMktaOVZXRXJONHl6N0lFeE9LVU1odEFV?=
 =?utf-8?B?cXU3WThkSEJZUkxPcWRVZ1hudlg0TjJxcmcyNUZBWGcxS3BuV0YvRDZqMi85?=
 =?utf-8?B?UWZob0l4eVpLZFpiV3FsVVBFdy9DMEVJTm9IMHNqUUtQRFJhTEwrcjZtY0lG?=
 =?utf-8?B?SGErYW9QRkVCU2pzTktmY2JrUjJOVDJCaUh3dlNJQ0tMOVlHUENXT2xaUVRu?=
 =?utf-8?B?QmIwL3lpclV4ZGc4dVJkYlV0UDBTUnhxT2pZTFk5U0RSRVlYbUZ1TlllTHJt?=
 =?utf-8?B?UVVEYnBFdzdiWW10RDR0LzdlaERWVTRrZzhPM3JOTUFqclhIODY0c0Nxd25j?=
 =?utf-8?B?NTZBb1VDbHBDNTBwTEhVZ1hOMTY2Sy9jbzZkaFJ4NzRickVWVm4rcGpGMkxB?=
 =?utf-8?B?VXI5Z1I4VzdMUVl5S1VPZUtaaUZydzNQMXlsUWNWNEZGdzVXS0JKaUoxQlZN?=
 =?utf-8?B?dzBGRXRSZk8wbmkrbG5Zd1o0MiszdFVVNjZQUlVPQWhnQ0R4OEJlQjhKTFc5?=
 =?utf-8?B?bTVXd0JHU2o5Y1pMczNKQTJENm5EdFFjZTBxSlc0RXdsMGFBdFBCcXJjZjNY?=
 =?utf-8?B?OVZoV1ZiNnNQYVdCNXFtT3JEK01nUW5WbzB6RithbGd1VThSQ2N1NUV6VkZj?=
 =?utf-8?B?Nko3YTZNem1lNFlFT1BrMHdDWkZab1lCbnZmWUU0Y2FpOThieStienk1Nk1I?=
 =?utf-8?B?emJxR2JMTU1FRGZNQ0ZGMnY4Kzgvb1B4NnpoYWkrTEZGOCsyaXZ6QVBvaTBn?=
 =?utf-8?B?NGVOa05XelViT011TmJmMCtiSjBjQWNXRXpydEYwOWRtRVR6VmphSFJrUjJP?=
 =?utf-8?B?T2FoUXQ1Q2J3Z1F0ZTY4RmZFbGN0WDFIbHN3MU1haXBwQ2JuTlZ0YzdlRnJC?=
 =?utf-8?B?NXRzajBIeWtub2dUekpScFNZMVZ2SXA2SG5vU29mR2N5Q3ltN2pxWENsRlFz?=
 =?utf-8?B?ZlpyMUxjOTBHRnd0UHN4Uld0Qkx4cjBXV01jL2ZONDRnZEk4TWtNVGRseGVW?=
 =?utf-8?B?Y0R0Tm9mT3NaN3RoNlp2SUxXN1JhNTYzeFh0Wkh0QWY2U2xLZnVzajUvMDB4?=
 =?utf-8?B?R1FraXNQUzh1dFZ5dXlrQjIyY1Vua1g1QUo1OS9CL0FKRE1BMVlZdWxzbTdx?=
 =?utf-8?B?WllycFhON2hTSURuTDNQTFBoK1ZlMzBLTW1rOVM2QnFXTlZqV1pQOVU1eUpJ?=
 =?utf-8?B?OXVTVEgvU0NsODg3MlR6T0piRXBaOXFKQVkwcFduT1F5Zi9xL1krSXI0cWFI?=
 =?utf-8?B?SUU0anBOM2VTRzRvTXlUWWpPTWJ5U2pkeVdZaXJnWTlzQlp0SHoxOWFITnZB?=
 =?utf-8?B?OUhiRWovd1Q5SUROOEVwZFdiSldQUjNyMjgzdlVIL3BJNUs5RStmM3B1L3B3?=
 =?utf-8?B?TFdYZ3ErMEQ2Z0FHNStCdnVhdEJFYko3VVVYNkdUZndlTG1xQ0FWL09SUGdx?=
 =?utf-8?B?N0hNR3pxWGthZmY4UjFsdlA3STB4cVZIMGNCcTVYdVpGbVpobW9RaDhDTGNY?=
 =?utf-8?B?VHZMY0VwaWRhcnFtTkMvSktjNzVxaTZkVHl0OVhKVHdCQittaDlCMkVIQjBN?=
 =?utf-8?B?RkdwbVRMZ2ZnTU1iY1FXb0I2SGhGNVhBM0RGRDg1UVZiRTJVZFVZTW0wMGU2?=
 =?utf-8?B?WDZxWEtpOUphNDNDanMyNG45L2ZMcHloMTU5SVZGV1pKS3pUQ1B6MjBNVFFi?=
 =?utf-8?B?c2I0QnpxS2Y4UUdEZk9iVkpZUERWTkZqUVBZSVZzSXg1N2lQNkF0MG9CTjVD?=
 =?utf-8?B?N2w2Vlpka0RQQ1ZBSFE0aWptQ0pzWkhaQm9hOVlWbWpnWHBtMnpVS3hIaUpH?=
 =?utf-8?B?SVRuMS9GWGFyZzdJUzR0akdJUFllM2VjR1RoT3o4bHhxdEo4T0NBd2w0ckZE?=
 =?utf-8?B?MWhMU3Zsc3ZyTWNUdWMrRnhINXovb1h0U0xoTjN1Kzg0aEo1eVNWUlRTNlRp?=
 =?utf-8?B?V0EwVXN1YndtcndLdGJyQ3VuRUcySkFpbE54SGFVOEhqQ2dxQm50WXMxS2tN?=
 =?utf-8?B?Smt3MnhZV2xoUWRZUmh5dmZHbllZVkJWL1dUMGQ4QXdYMmowUkF1eFY1VGRZ?=
 =?utf-8?B?YUszN2dXbTVyZ0lTMlRJdmlBeW5yTzREcjlFMUMrNU1VU3ZmdWZZU2YyMTIv?=
 =?utf-8?Q?RpaldQU1NGZc3H90OczLhd3bU+8yqOU4HWmF2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7F31950D8C1F74BA7D2B61A6D3D8498@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8741d2-8748-4c98-7aa5-08da1bb3967f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 12:05:36.3286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihLUaI9c8kdLUwW0VrVQ4HCmz1mP3RvEdvoKePAzVh4eoGA51rFDo9beHIebVwgIdKGPoerHcjKshqkusdPUZdAK0D40+Yvv5oGuahtfGJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTA0LTExIGF0IDEwOjMwICswMDAwLCBNaWFvcWlhbiBMaW4gd3JvdGU6DQo+
IHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgpIHJldHVybnMgdW5zaWduZWQgbG9uZyBub3Qg
bG9uZy4NCj4gaXQgcmV0dXJucyAwIGlmIHRpbWVkIG91dCwgYW5kIHBvc2l0aXZlIGlmIGNvbXBs
ZXRlZC4NCj4gVGhlIGNoZWNrIGZvciA8PSAwIGlzIGFtYmlndW91cyBhbmQgc2hvdWxkIGJlID09
IDAgaGVyZQ0KPiBpbmRpY2F0aW5nIHRpbWVvdXQgd2hpY2ggaXMgdGhlIG9ubHkgZXJyb3IgY2Fz
ZQ0KDQpIZWxsbyBhbmQgdGhhbmtzIGZvciB5b3VyIGZpeC4gQW55IHNwZWNpZmljIHJlYXNvbiB5
b3UgZGlkbid0IGFwcGx5IHRoaXMNCmFsc28gaW4gZnVuY3Rpb24gc3RtcGVfcmVhZF90ZW1wPw0K
DQpQaGlsaXBwZQ0KDQo+IA0KPiBGaXhlczogZTgxM2RkZTZmODMzICgiaWlvOiBzdG1wZS1hZGM6
IFVzZQ0KPiB3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBN
aWFvcWlhbiBMaW4gPGxpbm1xMDA2QGdtYWlsLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9paW8v
YWRjL3N0bXBlLWFkYy5jIHwgNCArKy0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMv
c3RtcGUtYWRjLmMgYi9kcml2ZXJzL2lpby9hZGMvc3RtcGUtYWRjLmMNCj4gaW5kZXggZDJkNDA1
Mzg4NDk5Li5kNDc1ZDFjMTdiZmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9zdG1w
ZS1hZGMuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvc3RtcGUtYWRjLmMNCj4gQEAgLTYxLDcg
KzYxLDcgQEAgc3RydWN0IHN0bXBlX2FkYyB7DQo+IMKgc3RhdGljIGludCBzdG1wZV9yZWFkX3Zv
bHRhZ2Uoc3RydWN0IHN0bXBlX2FkYyAqaW5mbywNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyBjb25zdCAqY2hhbiwgaW50ICp2YWwpDQo+IMKg
ew0KPiAtwqDCoMKgwqDCoMKgwqBsb25nIHJldDsNCj4gK8KgwqDCoMKgwqDCoMKgdW5zaWduZWQg
bG9uZyByZXQ7DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBtdXRleF9sb2NrKCZpbmZvLT5sb2Nr
KTsNCj4gwqANCj4gQEAgLTc5LDcgKzc5LDcgQEAgc3RhdGljIGludCBzdG1wZV9yZWFkX3ZvbHRh
Z2Uoc3RydWN0IHN0bXBlX2FkYw0KPiAqaW5mbywNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoHJl
dCA9IHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmaW5mby0+Y29tcGxldGlvbiwNCj4gU1RN
UEVfQURDX1RJTUVPVVQpOw0KPiDCoA0KPiAtwqDCoMKgwqDCoMKgwqBpZiAocmV0IDw9IDApIHsN
Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJldCA9PSAwKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgc3RtcGVfcmVnX3dyaXRlKGluZm8tPnN0bXBlLCBTVE1QRV9SRUdfQURDX0lO
VF9TVEEsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBTVE1QRV9BRENfQ0goaW5mby0+Y2hhbm5lbCkpOw0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG11dGV4X3VubG9jaygmaW5mby0+bG9jayk7DQoNCg==
