Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231115A85B4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiHaSen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiHaSeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:34:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787422B18C;
        Wed, 31 Aug 2022 11:30:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkpnvIMAcRGZo8fLE8k50xrjrnhyAEQAT2QZydbqmFH3gF7xe/HtLq+Uf4EXt1D2Zo4j2hV2E1lvzeEqUUXjHYh5WBotAiH117tzZQpmJ6iSf8UQlARckCHAnlRk2vzmncp88USGmyPtEKcOi/Y7+vy7gDXGEzLKgmkTmlkWJMGrDdRXCGwM4eL4VcCkyGM0d3QHpXHTd3LTGd/KSLCzmBxgmJPHzYG1FzWJpXpK0rLGFdFwCiQGGC6fba8QCy8K8o2P8jqUnFZ7h8oNNADDK6VjkRYHFrI4wJSMEVVpxvQfmN3tMZ607szfUqVD2sXGNhB5HRuxotZDsA6f6GCuHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuPer6piXF1Yft1HJnHGEFQ0Zc6CiafubZoQsmcG69Q=;
 b=hzBIrlEP5B5aUkgJHFgTWsPYxSHoTsBroOeSFk6Mme8kDJ03vT8WAAeEgaIpjD/Yt6Oi8Nxj1jPr2ltBu7MyeJc88lkv7ZQ7/t+xCePgA+h57Xd9IX1xmxzS+o0HPAOp76FEHnxDg8sJRuclofIkHR1tcLCk3ZwcYUBpxHR7eZGNTyBMVf92ORS3ZhqqVYNJgh0yGwWBjYrXL+Uui+ZZZO1rziIMkZU1xlAdDa7u2b7dFS5zXY/oE+lZsTkiR2vTNLlMWwKi5ClzPQHhw68dCKio2zXW6CcNq8/3v9Jejqr/vuuWeGtq4olYKZIoec80EPJM0Emvju8D4hiuPWb+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuPer6piXF1Yft1HJnHGEFQ0Zc6CiafubZoQsmcG69Q=;
 b=hz1g/FLjs9+PMJVkm1K5WEu/+BsA1otHgU/3mpwvLL3EcxwgrteLTh1HJY2M6qk7vNRcmZvkYCq4wrDt21jMp6wJxknTPjajnOmzBCF54v0uP+5lLHTn5EoZScwf5NlrSSwrhVZE2MnLEtbdx6Nc2y3VGujX4dWDzwjp5jffYpQ=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 18:28:46 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 18:28:46 +0000
From:   "Larson, Bradley" <Bradley.Larson@amd.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Brad Larson <brad@pensando.io>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 04/17] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
Thread-Topic: [PATCH v6 04/17] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
Thread-Index: AQHYtM841nPgSBs2aEa7V9yGUi8o5a25ozYAgA/CLYA=
Date:   Wed, 31 Aug 2022 18:28:46 +0000
Message-ID: <0c2ac76e-45ff-b5a1-f33a-177eea04c17d@amd.com>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-5-brad@pensando.io>
 <20220821174952.5i5pfftxt53dmqv3@mobilestation>
In-Reply-To: <20220821174952.5i5pfftxt53dmqv3@mobilestation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b756c3b3-1173-4154-719f-08da8b7ea430
x-ms-traffictypediagnostic: DS0PR12MB6583:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zux/CSNiMOWx7t6G10ArGAkp8tUj2jZ+LIpn5GsU2MdzAKNPy0SG6V1TxD/OaWwoKtlLAp3gtPU4/k2/AsxXnl78t6GkOyNp6cw+GTlkCs+Bh70kAeu5XQVxzEssJyTRehZ7ukpY9yc3Nqp5ovsD4shaMKngSJasqoYH+7FYWGBxtJPlGfWFi9fmhUKlBRne0tZ55bMs5s4St/j1PWkVSJaWgMYani7RFikULa7iZ/hRZ7MzHzXs35fromtwhu4Bdiab2iLMXk/6W7if/7zK+4dmym/8sQx058MB+ovvX1Of2m1PZC4tTmrthKuTWuQ2Y5VFZjPqpaw6ScN4iKwTCEhc2QLxLyNjLJmEaaUmxU46FQIm1zY0pb3Wv54xmGvpKCABCw3pnaUknF4JI/5krpwU+W7Xe3jRRtB+EUJn/tjEl8bTy2UoQH207UFOM5bfZ3Vm2yDwpzD93W+jgdu1YtRLMiZKHhcRfm0CO8pkaSkeIkrYrIFh1X89GTQA/icsVf+YAesLK4dzdwqCjsqJsI/FKun9qUcF/qrkNjojCX/5AK+bieQOpmR50MCfWatgHSc7GvlZTo2vWoKzPrj89q/YjRfPlUCNn8SYnVxUttL3g4N2eYqP3XrBgoU8Tcgjn9c1RBxxQbee3t+SRaqIt4Z8UFyANWu8gZgXctiwIzyfiJmoTUOeY8fGUX43ZvOXpFQPwYLL0B49zbnWWT6Sc8gio6LMPoFgN8RehhdCz1W84EYXiFxtF4pE81yx0iBQsEdxDeCZaT2CMY/YfFeLgEHGhKu65xBgkiN3jbjyRgjh+4tc0w5OO2VPVzhB9DBY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(966005)(186003)(54906003)(316002)(45080400002)(66946007)(8676002)(31686004)(71200400001)(110136005)(66556008)(91956017)(4326008)(66476007)(31696002)(76116006)(6486002)(64756008)(66446008)(86362001)(36756003)(478600001)(5660300002)(8936002)(7416002)(41300700001)(38070700005)(2616005)(122000001)(6506007)(26005)(2906002)(38100700002)(53546011)(83380400001)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlIxU1NQbGE0R3BpNTZDMXRXVzBWSzRPbHltV0w0SXdpRWtUQVNjM2lJMUJu?=
 =?utf-8?B?TWRzaFpMQ3pqQmJQdlVabzFhWkl5NGhHVnlaaUxuZFkxcm5KcnF3R1d6dDJI?=
 =?utf-8?B?VncrZUlMVDcyNHVsdENrMWEwMUdwNmZsQnBtWnJURDdpSExLcHRjNmJ6Wmov?=
 =?utf-8?B?c1Rsb0FuS1J3SGtOK0RZVGhZbnFCWlBXN2gxZmJOcjRKalRhSGs2M0s4TFAy?=
 =?utf-8?B?elI4WTJXVE1ib1BpcjRlMDFxOGtzSWluTy90NHQvcVBFZ09ZOG1OeEVrdEll?=
 =?utf-8?B?YTB6U3dUZ3R2ZzF3ZmVjWGpIcTRaTVJXdXY5Y2JlajN3dzMrZFZDcFBvVTYx?=
 =?utf-8?B?dDM0blZNZDBwU25zN3EzdnhTazdocHAzNkZJK1JwTmtzTHRFeStDb1gzQnIw?=
 =?utf-8?B?S085ZW1tbFhkNDl2RUZ0cklQdTg5OFNNTFhyemlKUTNFc2o1UXNJYk9Yb2Fi?=
 =?utf-8?B?TXMrNTNpSlVXbm55YWFLSE1HT1o5N21Ga1BlTzZzL29nYjFiSmhCMDVpZTRr?=
 =?utf-8?B?TnZCN3A4NnVoTGVucWN6U0Q0ZkUzRUdxZHgyQzJtTGMvMkg1UkRPYVk4S3Ux?=
 =?utf-8?B?S2hLc3FvWGxaMFA5MHFIUmliYWF6Y1hzbk4ybFVXR3o5ZUVIdjgweWxsdzRD?=
 =?utf-8?B?cWFQVzJET0FDMVY5aEJtYklzejFyV2xHY2FkRVhQbUFtdzJOQnZTSzVDZ0Rr?=
 =?utf-8?B?WjdYT0VQTHlFeHIrbU1lN0pSRUxRNlRHVFBMV0xUMkVkZG80dkdJRlI5akh6?=
 =?utf-8?B?cWllNUEwRkhrN3FVOVlxWm1DN2lrYnE1RDc0Q2tTTE42clFSWHZvOWVFS0Iv?=
 =?utf-8?B?L0pjM0dSM3dPYVcyOWJlTW5nTVhEeVZDUEJJVjk3RDJwRkVOOFN6QTR5WFUv?=
 =?utf-8?B?ZnlOWnNuK2thOEMvU0o2UnRWQ3VKcmh2US9RTmE0dktSeEhNNnBXRVhMZVBS?=
 =?utf-8?B?Y2pLYXRJSjNQWDc1WFJFYnJMLzNxOWNwSTU0ZWUxZzdVR24rSVE4Ym9wK1RJ?=
 =?utf-8?B?SzNINmRWbnpPU0lJL0ZoVndrY3g2WVFmSGlyYTlXWEgxQk1heGpPcTlKWXlr?=
 =?utf-8?B?eCtqdjU0dE4wb0h5L1NrUkEyQXBmYncrZjhzWmJpK3F2bU9JV2pGOE0vZlEx?=
 =?utf-8?B?RnV3Yk1ZZFBmZXpUckhZalhvMXY2SjVERzY4cDNNb0lwS25LVmszTWVtejdS?=
 =?utf-8?B?QWNEc2t5YzYveU96RDkyN3pUem4zN3JSb2ZoNVQ4ekhma3Z1blJSVFpPcncz?=
 =?utf-8?B?ZjdEN0RJU3diekRZNHhDMmNZVUJ0dys3cGNIR2h4WG9BN2k1eVJjeHBUQmVK?=
 =?utf-8?B?YmtKV0FjUVlJZ28zMlNKcldlZDY5WDNUQmZIZzFlUEpEN3dsNUUxRkNIRnFK?=
 =?utf-8?B?U3V0R0RlY1gxKzNVWFI2NVBNalZEcFJKTEVLM3VnMXk2cS9XUWZYTmttRXV3?=
 =?utf-8?B?OHk3YXBqS1QvbjVrbys0WExRTzFSMk5FWENZTGV1M1NSRWZjaXJkSTdCOWhq?=
 =?utf-8?B?S1NUNUxTZ1VJZk55OFhLRUVQNHUyMWhEeVA4MHNPU0oycExlKy9CN0t4bUFa?=
 =?utf-8?B?ZFhKZkNzRURvMHpTOEhlZkhNVDh5cTFhMTFyWW9BL3hCdXRYcTl4RnF1a0c3?=
 =?utf-8?B?NCttMDhHaXYxK2s1RXluVTdzUW4vaHRsQWRqZ0RnZlJ6bmJFdXpCOWNxTjVR?=
 =?utf-8?B?M3ViSHNLM2Y0aDlzUmducTREOUk5Qkc4WDJ6K1NqR2xQbXdjbyswdC9RQjNR?=
 =?utf-8?B?d08wd2pmRVJvNHFPYS9vUzhEdFNSZTNrYVloOUNLOXRTRGU0ckcxaWxuRTNR?=
 =?utf-8?B?SUpRS0NxeGVYTFNVQjc4VG1JQmJGczlqdmVpY2dZS3lYRU5wN21LamJXSTlS?=
 =?utf-8?B?NXFwSkJ4Z2xIb2ZyejB2UFVJU3FHZlVVQklmNUZUNU9ZSFg2cGkzYXd4RGZH?=
 =?utf-8?B?RXFoaStveTBNTDY3V0M0L3pXY3VicEVLVG5UYVZHK0U2cnVjeEpuTTM0czhR?=
 =?utf-8?B?SXAzb0tWSGNkVk1LUTc3SVlHem5SYkE1bUszOXBvMmNTamMrb3l6a1Zmc25j?=
 =?utf-8?B?RVZIekh0NFVJcjVtUkIwTURQS09PMWxRa3ptdmlOQzYrNTBvS2VHNnBoU0cx?=
 =?utf-8?Q?kmQk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93B02C02605CA84D980E5CBFDBA398FA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b756c3b3-1173-4154-719f-08da8b7ea430
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 18:28:46.2499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Dd76RQ/9C6OEAMnPdWFiNjlPoAqypWDhY++GQbq4X62zcSwgSc3Wx0pLnjU5vC3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMS8yMiAxMDo0OSBBTSwgU2VyZ2UgU2VtaW4gd3JvdGU6DQo+IE9uIFNhdCwgQXVnIDIw
LCAyMDIyIGF0IDEyOjU3OjM3UE0gLTA3MDAsIEJyYWQgTGFyc29uIHdyb3RlOg0KPj4gRnJvbTog
QnJhZCBMYXJzb24gPGJsYXJzb25AYW1kLmNvbT4NCj4+DQo+PiBUaGUgQU1EIFBlbnNhbmRvIEVs
YmEgU29DIGhhcyBpbnRlZ3JhdGVkIHRoZSBEVyBBUEIgU1BJIENvbnRyb2xsZXINCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBCcmFkIExhcnNvbiA8YmxhcnNvbkBhbWQuY29tPg0KPj4gLS0tDQo+PiAg
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zbnBzLGR3LWFwYi1zc2kueWFtbCAgICAgIHwg
MTEgKysrKysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9z
bnBzLGR3LWFwYi1zc2kueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
cGkvc25wcyxkdy1hcGItc3NpLnlhbWwNCj4+IGluZGV4IDM3YzNjMjcyNDA3ZC4uNDAzZDY0MTZm
N2FjIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nw
aS9zbnBzLGR3LWFwYi1zc2kueWFtbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NwaS9zbnBzLGR3LWFwYi1zc2kueWFtbA0KPj4gQEAgLTM3LDYgKzM3LDE1IEBA
IGFsbE9mOg0KPj4gICAgICAgZWxzZToNCj4+ICAgICAgICAgcmVxdWlyZWQ6DQo+PiAgICAgICAg
ICAgLSBpbnRlcnJ1cHRzDQo+PiArICAtIGlmOg0KPj4gKyAgICAgIHByb3BlcnRpZXM6DQo+PiAr
ICAgICAgICBjb21wYXRpYmxlOg0KPj4gKyAgICAgICAgICBjb250YWluczoNCj4+ICsgICAgICAg
ICAgICBlbnVtOg0KPj4gKyAgICAgICAgICAgICAgLSBhbWQscGVuc2FuZG8tZWxiYS1zcGkNCj4+
ICsgICAgdGhlbjoNCj4+ICsgICAgICByZXF1aXJlZDoNCj4+ICsgICAgICAgIC0gYW1kLHBlbnNh
bmRvLWVsYmEtc3lzY29uDQo+IFBsZWFzZSBhZGQgdGhlICJhbWQscGVuc2FuZG8tZWxiYS1zeXNj
b24iIHByb3BlcnR5IGRlZmluaXRpb24gYXMgSQ0KPiBhc2tlZCBoZXJlOg0KPiBodHRwczovL25h
bTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZs
b3JlLmtlcm5lbC5vcmclMkZsa21sJTJGMjAyMjA3MDQxMzE4MTAua2Fia3V5NmU0cW1oZm0zbiU0
MG1vYmlsZXN0YXRpb24lMkYmYW1wO2RhdGE9MDUlN0MwMSU3Q2JyYWRsZXkubGFyc29uJTQwYW1k
LmNvbSU3QzFjNGY4MjJjODE0MjQwNDg4NzM1MDhkYTgzOWQ5MGZjJTdDM2RkODk2MWZlNDg4NGU2
MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzk2NzAxMDAxOTI0NTg5NCU3Q1Vua25vd24l
N0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJ
NklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0YT14bDlPVTlQ
OVFLM3dMSGMyNWhRWkszOTN5bFVMZDQxcWM0SEIyWnQlMkYwQlElM0QmYW1wO3Jlc2VydmVkPTAN
Cg0KUHJvcG9zaW5nIHRoaXMgYWRkaXRpb246DQoNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zcGkvc25wcyxkdy1hcGItc3NpLnlhbWwNCisrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc25wcyxkdy1hcGItc3NpLnlhbWwNCkBAIC0xNDgs
NiArMTQ4LDE1IEBAIHByb3BlcnRpZXM6DQogwqDCoMKgwqDCoMKgIG9mIHRoZSBkZXNpZ253YXJl
IGNvbnRyb2xsZXIsIGFuZCB0aGUgdXBwZXIgbGltaXQgaXMgYWxzbyBzdWJqZWN0IHRvDQogwqDC
oMKgwqDCoMKgIGNvbnRyb2xsZXIgY29uZmlndXJhdGlvbi4NCg0KK8KgIGFtZCxwZW5zYW5kby1l
bGJhLXN5c2NvbjoNCivCoMKgwqAgJHJlZjogIi9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRp
b25zL3BoYW5kbGUtYXJyYXkiDQorwqDCoMKgIG1heEl0ZW1zOiAxDQorwqDCoMKgIGRlc2NyaXB0
aW9uOg0KK8KgwqDCoMKgwqAgQSBwaGFuZGxlIHRvIHN5c2NvbiB1c2VkIHRvIGFjY2VzcyB0aGUg
c3BpIGNoaXAtc2VsZWN0IG92ZXJyaWRlIA0KcmVnaXN0ZXIuDQorwqDCoMKgIGl0ZW1zOg0KK8Kg
wqDCoMKgwqAgLSBpdGVtczoNCivCoMKgwqDCoMKgwqDCoCAtIGRlc2NyaXB0aW9uOiBwaGFuZGxl
IHRvIHRoZSBzeXNjb24gbm9kZQ0KKw0KIMKgcGF0dGVyblByb3BlcnRpZXM6DQogwqDCoCAiXi4q
QFswLTlhLWZdKyQiOg0KIMKgwqDCoMKgIHR5cGU6IG9iamVjdA0KDQpSZWdhcmRzLA0KQnJhZA0K
