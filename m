Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8406D4F62FD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiDFPL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbiDFPLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:11:32 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on0602.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1f::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81FA5031FA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7BZYRebtZskcKQmlaNr+/5EVO4hnmURtewR13i5oTsFq8nrHQQ1DgrCC/7vY87fcctJmcAebTsCI+qIsj+eSowoyeoZT8tLBPzedgfqlE0dFM8w2SVCG1lRX9FnTl/JEP5KD11PUOo79eiIY/R0p5kB9A3mothmQ8+K0+sbXcGltl5KfaEqD0f3d8JHbAsfEXpuAFbtHcb7VUtYi2l76G9qIpmgelD0hAtk3JWAzwRlcrq6ulRCLI1tC5OecsvCNC+cG379YbB1g6BQhucZL2xYBvVXD9qRYMxlY50bpghDM6CfPxHfnFXj8CZU02YSaxj1y0PcQeiftP2e+28GsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVoiFQNIxLJduN4sGaKvHdHfMCGy2GBELva1EALHn+A=;
 b=N/IsFwQn593Y81viKjNhNAJt5cgj4vE0LoY37FcZQtIlFOPfxFsF113uGVkRPTYeoYWMNrOf05mKQfjokAhzDidQV5XqVAtIeq+wQpsdw+8m3QLJFgHrQYxTRuJnB3MHHx2LksZaRD34lf2bs5EO8D5BfFVCCbvR1NR/+FjFzSehx2GsRphvp6MbaJxV7IZzsxOHCbMZLb/FOeRvN2xuJF0e/YX+4IU7tRvNxbQ4v0A4xAj8ay0xWa8Ea+B1V6/IMTySP/2yIvozhr3U6fgSdU6qI52Yjv0+DnppzwtWONj/c52CAjocRpGi+3PpwcZHG7WCyRVsq4Xhne43GC8SLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVoiFQNIxLJduN4sGaKvHdHfMCGy2GBELva1EALHn+A=;
 b=U3aOOMFVBNUw7pd5R2s5j8VlfXMlQJrnMkp8uuioRy15bvGLQ15vvDiqO0ExcdDTM1W6kCkAP98g1NmaV0WfWEEXKOLcv21FudCDqtmXl39VNF62ebrqLOJkUfQtFlfO+vSJa5ikYxLfglFmvkgO8/GzOJMVJJTwsLpQ4UCJKZg=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (2603:10a6:803:49::27)
 by AM8PR04MB7810.eurprd04.prod.outlook.com (2603:10a6:20b:237::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19; Wed, 6 Apr
 2022 11:48:31 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::81be:ee44:be2a:727c]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::81be:ee44:be2a:727c%4]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 11:48:31 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Li <frank.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
Subject: RE: [PATCH] extcon: ptn5150: add usb role class support
Thread-Topic: [PATCH] extcon: ptn5150: add usb role class support
Thread-Index: AQHYSZwctDdaLIQeZ06BuvStsTM0tqziq1kAgAAXF/A=
Date:   Wed, 6 Apr 2022 11:48:31 +0000
Message-ID: <VI1PR04MB4333FE5742667FBE8AAACD2789E79@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <1649238142-27564-1-git-send-email-jun.li@nxp.com>
 <4ad9e733-7d8b-a73b-c59e-d9b6d5e58498@linaro.org>
In-Reply-To: <4ad9e733-7d8b-a73b-c59e-d9b6d5e58498@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48f24d9c-2a70-4eb1-3b7f-08da17c35f69
x-ms-traffictypediagnostic: AM8PR04MB7810:EE_
x-microsoft-antispam-prvs: <AM8PR04MB781043B6F476895C8212D12489E79@AM8PR04MB7810.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hEF3dUJqdP1IhZuY8dkiX+IUOOTr13qeedRLoFgK0KXSaZPl2BpEiSh5DEeKoFFMs3ZKdzqxUV6HU+T/qT//0g1qq7uoXiNOUHwt9pKh3R99IrHOHG4cdxJeSFRauhD+AHlSTocUbCMp7XluzeHLPN7btbOh/vmh2EWB2iLYCST/+TI5qPGvvbFTZWZX0fe01sRE4Za2S80HTBmu6BtscD/lwGE76yQ6k3QdIHAZR7mr6QswNn63XBfjSZ5EhbTlFH6pc1j4vfXP9POZY08eYHIHzvA5Nz0kA2voNp8LMz1nUNxg1xAdhG7frUXkQR4rFdXoGEwnaM2s17C9cQcTu1gdkjYVEm/7elax3ad3Jg8VO8WJ5W8Sq6Wg/FpTgYwcd8uRlQdxyh0c3UQhVq6ytOL4T1zWv8J9uXmysZoCsDHRdAdRJ3t2g4ELfLT9+SYtw3yt9F+vj1ixOCiIYX3L6TJAsPmhsmj1oJjoVrN58QDAvhH9pvY8A2dgjDSnmGIuHFPutjLPuiuHYaSGFjF9HvIV3N3fsooK99Xqv2ORm9TEXA1vdYSJ1Yaq+eJbx0BqDea/bZR+vWzYrWqPfagl8Gyo90qufrTflL34OC0ZQIPGD/bwXliXu/9zo3PvgxeDHmaMy701ycXytqsBeK/AJ29+Dmv6EMxbvCOAfs2kjoqJn+Xx6iP3JuloX44ktIrBRGpMztqN5Meae+bLUTROJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4333.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(71200400001)(33656002)(508600001)(83380400001)(64756008)(66476007)(55016003)(4326008)(66446008)(66946007)(76116006)(8676002)(66556008)(122000001)(38100700002)(7696005)(6506007)(52536014)(53546011)(54906003)(9686003)(86362001)(110136005)(2906002)(316002)(44832011)(38070700005)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkwyRGRGdlFhSlBIZVdZcml4emdVemxuOURoanUzN3FKa21US0MwbExiZHJ5?=
 =?utf-8?B?UTNpVG1HOFJWckxkWVI2czBXazdwWktLeG9BaHJDVlB0SlM2UnJGRWJ1cFdy?=
 =?utf-8?B?ZnZXZjh6TGJ2THk1dUFpNkFWMFZmL0lIZGJ1emVHb0ZMT1dla21naWR1YjNu?=
 =?utf-8?B?ZHNsQncrditqTTNCNEt0NXQ1OFpTNkJlTTM2RjBIazVBTzRVdWZhOFRpbUlq?=
 =?utf-8?B?V09ENXRrTlRhQnBJOWZmSFpiOGZxQUwzTUllc2hFRzRXR3ZtV1RPQWlkZkZ6?=
 =?utf-8?B?TmFDQkxLWkM0NU9aU1RRbWp6RG80ejBzNUlxclRDRk1iV0FOYXBoenRYYU5w?=
 =?utf-8?B?NUV1OTFxTGNSeWZlbEY5QzdsUDQ1cnV3ZDZDYVg1ZEFRV2lUazlZS2NHeFo4?=
 =?utf-8?B?S3ovd1FNOCtHTHI2eFhQSGwzcXZPVUExM2d1T1N4d0lURmpnQzJoSkVtWmwz?=
 =?utf-8?B?M1d6V0VYU3U1R2lteHZ2a2kzMi8yVllMd0JZMDh5KzQwbDk5ayt3UTR1Vzl6?=
 =?utf-8?B?N3g5TGpHeHB1Nk1rcDRicnhUczZDWnJJaGljK3piQ1FyRjRTckZsNDgrYWxQ?=
 =?utf-8?B?RWcvaXZ4b1VLVjQrVXZ0bzVaNGs4NFVMMDJPQWVTb0xNbzZUYjZLYjVxb3dS?=
 =?utf-8?B?bnVtejJzV1lhTkU0bTExbzhKNlVKYSt3ckN1TVpEaUZTdTZjSno1ZVM4a1VH?=
 =?utf-8?B?REk0MEtEcC9jVEtrRHhoaTVSUEZzQkpSSnBVQzhiRTdWQjlES0RBY2w0ci9T?=
 =?utf-8?B?U2FqOWF6Q2Mxd051OUh1NUlMYk1sTmZmVzNsU0NubWQ2TlVzZjVEbGNiUVZ5?=
 =?utf-8?B?TnFQTWVxRTdCcHBXQ1NHRzJZVzhIQ3JvOXQ0eTdrR3JpL29sMnFRNlBmdmZL?=
 =?utf-8?B?MG9NUE5WZkhRUDNtZ2lCWW9qUHgzREhsTTdsSDRWQkdlK3Y5L2hEdHBXa1FZ?=
 =?utf-8?B?bHFVRUdkSkdJZy9wenN2Lzd3RXpJcUR6d0RObEhXK2d1OVZMTndGbTJ6MEVl?=
 =?utf-8?B?amxXR2FxUjRheW9aeVh1VDVoMVZlUm5tQ1E1VzdRcXpsZ1dUK0hPdUxjRUlW?=
 =?utf-8?B?c0x4WWtBallIYTlISG83YlZBWmFWUFBKdHMzL1dITDNMeDFpNkJqT3cwMTRU?=
 =?utf-8?B?cHhBZ0d4Ulg2S3RBZ3JDUVV1aUJWckVhRExSVEZTK3MycnVJQjF4S1kweURH?=
 =?utf-8?B?bElUZmJsb1pmTk1sUi9qZE4vQ0hzM0ozdmtGdUdVeDByREF3WUFtVWVwalU4?=
 =?utf-8?B?VGZHSEFNYUlwT2FTVzlQaG5tMForaEN2ZmZyemx1eG9rSmZKY1pYK3ZHR1c4?=
 =?utf-8?B?OVZabEdhbGtJNS80MDBtMlZNK2RnVVNNeWNFZjRyeTA3NUZyQm53UllyNmhQ?=
 =?utf-8?B?dG5QL0VEaVpBVHFSNFYxanVxeSs2VkloT1pGQ3c3cFdFZUJ0Tm1jTFR1UWow?=
 =?utf-8?B?UFBsVko1cjU0R0JLclFPSjJlRlBhb1h4QVVaQ0NHNkdGUVN4UTRUOEl5RExO?=
 =?utf-8?B?T3RobXNSalh0QWF2a1kxUlgrSkNJTjdPaHI3ZWJHZWl1NG9IMVZ3STkvQS85?=
 =?utf-8?B?NEowNmp1WktOV2Y5UTdiLzFubnkxWklvRlQzZ1VveC9MZFV3cU1QYndXNTBu?=
 =?utf-8?B?UHpRM2NxNm5OcERtN1VVcTAraUR0aVZMWno1eCtSbmF0ZnNUcWlESFBML0xt?=
 =?utf-8?B?b1JGaHJsb3M1RjIrbXlzNlh2bHFMVVdFMjY4YTcxZ2Fha0JZOC9LT3VBcFV1?=
 =?utf-8?B?RURUdk96K1RwK3loMGFDTW4rb3UvOWdjWUhIelhpdHRtWXYvNi8xcnhSaE9N?=
 =?utf-8?B?MGhwdnJhZkh3djlvRmlDVHlpc0JzbWFmTnZGUVNaUElEekg2YUR1TS83YnBP?=
 =?utf-8?B?dGFtRThlK0xjeitueTZ5ZVBaNlh1UFNNK2N3bnhmMFBnQ3NKRDdhcS9MS2hI?=
 =?utf-8?B?N3lmTmtEbnY2cnFCL21SUnljRUM5SEFPUWYxTFA4bm1yN0I1NGZLVi9ZbjBj?=
 =?utf-8?B?aDJydCtuVFd4WXhrbllrZ01Sd0ZBcGJjM1RZMTJuT015MlkzY0k2L3BFVHRP?=
 =?utf-8?B?RDdUVkcwOFRJQUkxRnBTOXgrQThyZ1gxUjJnaXBPeHZZQS9uT3U2c3BmRlJB?=
 =?utf-8?B?aUw5Y0p5eXlIazNxa0ZRaE9WVDh4ZDBheG5DdGJEZWdsdUtBeHN0dXA4b3Fk?=
 =?utf-8?B?VWMxdkxqdXVYdU85bTRCeHdqdDdodnB2djU2SG9QM2lnZHhkSHNMOTJ3VXJE?=
 =?utf-8?B?QTVpUGxRR3V2MXFLV2VPNDFPaHVQTVdldW9PQ2krbzFJRTVMT0tCZitqNzY1?=
 =?utf-8?Q?C8uI8jIWCFMXL7gr/9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4333.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f24d9c-2a70-4eb1-3b7f-08da17c35f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 11:48:31.1577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71mrK+37E5+jE/fe511XscO3GtB+4swhBHahqfqxKxnYsV7sAxOC62A26PgdYJum
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7810
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IEFwcmlsIDYsIDIwMjIgNjoxNiBQTQ0KPiBUbzogSnVuIExpIDxqdW4ubGlAbnhwLmNvbT47IG15
dW5nam9vLmhhbUBzYW1zdW5nLmNvbTsNCj4gY3cwMC5jaG9pQHNhbXN1bmcuY29tDQo+IENjOiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47
IFh1IFlhbmcNCj4gPHh1LnlhbmdfMkBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBl
eHRjb246IHB0bjUxNTA6IGFkZCB1c2Igcm9sZSBjbGFzcyBzdXBwb3J0DQo+IA0KPiBPbiAwNi8w
NC8yMDIyIDExOjQyLCBMaSBKdW4gd3JvdGU6DQo+ID4gQWRkIHN1cHBvcnQgb2YgdXNiIHJvbGUg
Y2xhc3MgY29uc3VtZXIgdG8gZG8gcm9sZSBzd2l0Y2guDQo+IA0KPiBQbGVhc2UgbWVudGlvbiBh
bHNvIHdoeSB5b3UgYXJlIGRvaW5nIHRoaXMuDQoNCldpbGwgaW1wcm92ZSBpbiB2Mi4NCg0KPiAN
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExpIEp1biA8anVuLmxpQG54cC5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvZXh0Y29uL0tjb25maWcgICAgICAgICAgfCAgMSArDQo+ID4gIGRyaXZl
cnMvZXh0Y29uL2V4dGNvbi1wdG41MTUwLmMgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9leHRjb24vS2NvbmZpZyBiL2RyaXZlcnMvZXh0Y29uL0tj
b25maWcNCj4gPiBpbmRleCAwZDQyZTQ5MTA1ZGQuLjk4MjhhZGU3ODdhOCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2V4dGNvbi9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9leHRjb24vS2Nv
bmZpZw0KPiA+IEBAIC0xMzIsNiArMTMyLDcgQEAgY29uZmlnIEVYVENPTl9QVE41MTUwDQo+ID4g
IAl0cmlzdGF0ZSAiTlhQIFBUTjUxNTAgQ0MgTE9HSUMgVVNCIEVYVENPTiBzdXBwb3J0Ig0KPiA+
ICAJZGVwZW5kcyBvbiBJMkMgJiYgKEdQSU9MSUIgfHwgQ09NUElMRV9URVNUKQ0KPiA+ICAJc2Vs
ZWN0IFJFR01BUF9JMkMNCj4gPiArCXNlbGVjdCBVU0JfUk9MRV9TV0lUQ0gNCj4gDQo+IFlvdSBk
byBub3QgbmVlZCB0byBzZWxlY3QgaXQuIERyaXZlciB3aWxsIHdvcmsgd2l0aG91dCByb2xlIHN3
aXRjaCwNCj4gd29uJ3QgaXQ/IElmIGl0IHdvcmtzLCB0aGVuIHByb2JhYmx5IGl0IHNob3VsZCBi
ZSBqdXN0IGltcGx5Lg0KDQpPa2F5LCB1c2Igcm9sZSBjbGFzcyBwcm92aWRlciBzaG91bGQgZW5h
YmxlIHRoaXMgZm9yIG1lLCB3aWxsIGRyb3AgaXQuDQoNCj4gDQo+ID4gIAloZWxwDQo+ID4gIAkg
IFNheSBZIGhlcmUgdG8gZW5hYmxlIHN1cHBvcnQgZm9yIFVTQiBwZXJpcGhlcmFsIGFuZCBVU0Ig
aG9zdA0KPiA+ICAJICBkZXRlY3Rpb24gYnkgTlhQIFBUTjUxNTAgQ0MgKENvbmZpZ3VyYXRpb24g
Q2hhbm5lbCkgbG9naWMgY2hpcC4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9leHRjb24vZXh0
Y29uLXB0bjUxNTAuYw0KPiBiL2RyaXZlcnMvZXh0Y29uL2V4dGNvbi1wdG41MTUwLmMNCj4gPiBp
bmRleCA1YjlhM2NmOGRmMjYuLjgyMWIwZjM5MDMwOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2V4dGNvbi9leHRjb24tcHRuNTE1MC5jDQo+ID4gKysrIGIvZHJpdmVycy9leHRjb24vZXh0Y29u
LXB0bjUxNTAuYw0KPiA+IEBAIC0xNyw2ICsxNyw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9z
bGFiLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9leHRjb24tcHJvdmlkZXIuaD4NCj4gPiAgI2lu
Y2x1ZGUgPGxpbnV4L2dwaW8vY29uc3VtZXIuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3VzYi9y
b2xlLmg+DQo+ID4NCj4gPiAgLyogUFRONTE1MCByZWdpc3RlcnMgKi8NCj4gPiAgI2RlZmluZSBQ
VE41MTUwX1JFR19ERVZJQ0VfSUQJCQkweDAxDQo+ID4gQEAgLTUyLDYgKzUzLDcgQEAgc3RydWN0
IHB0bjUxNTBfaW5mbyB7DQo+ID4gIAlpbnQgaXJxOw0KPiA+ICAJc3RydWN0IHdvcmtfc3RydWN0
IGlycV93b3JrOw0KPiA+ICAJc3RydWN0IG11dGV4IG11dGV4Ow0KPiA+ICsJc3RydWN0IHVzYl9y
b2xlX3N3aXRjaCAqcm9sZV9zdzsNCj4gPiAgfTsNCj4gPg0KPiA+ICAvKiBMaXN0IG9mIGRldGVj
dGFibGUgY2FibGVzICovDQo+ID4gQEAgLTg1LDYgKzg3LDEyIEBAIHN0YXRpYyB2b2lkIHB0bjUx
NTBfY2hlY2tfc3RhdGUoc3RydWN0IHB0bjUxNTBfaW5mbw0KPiAqaW5mbykNCj4gPiAgCQlleHRj
b25fc2V0X3N0YXRlX3N5bmMoaW5mby0+ZWRldiwgRVhUQ09OX1VTQl9IT1NULCBmYWxzZSk7DQo+
ID4gIAkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKGluZm8tPnZidXNfZ3Bpb2QsIDApOw0KPiA+
ICAJCWV4dGNvbl9zZXRfc3RhdGVfc3luYyhpbmZvLT5lZGV2LCBFWFRDT05fVVNCLCB0cnVlKTsN
Cj4gPiArDQo+ID4gKwkJcmV0ID0gdXNiX3JvbGVfc3dpdGNoX3NldF9yb2xlKGluZm8tPnJvbGVf
c3csIFVTQl9ST0xFX0RFVklDRSk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJZGV2X2Vycihp
bmZvLT5kZXYsICJmYWlsZWQgdG8gc2V0IGRldmljZSByb2xlOiAlZFxuIiwNCj4gPiArCQkJCXJl
dCk7DQo+ID4gKw0KPiA+ICAJCWJyZWFrOw0KPiA+ICAJY2FzZSBQVE41MTUwX1VGUF9BVFRBQ0hF
RDoNCj4gPiAgCQlleHRjb25fc2V0X3N0YXRlX3N5bmMoaW5mby0+ZWRldiwgRVhUQ09OX1VTQiwg
ZmFsc2UpOw0KPiA+IEBAIC05NSw2ICsxMDMsMTIgQEAgc3RhdGljIHZvaWQgcHRuNTE1MF9jaGVj
a19zdGF0ZShzdHJ1Y3QgcHRuNTE1MF9pbmZvDQo+ICppbmZvKQ0KPiA+ICAJCQlncGlvZF9zZXRf
dmFsdWVfY2Fuc2xlZXAoaW5mby0+dmJ1c19ncGlvZCwgMSk7DQo+ID4NCj4gPiAgCQlleHRjb25f
c2V0X3N0YXRlX3N5bmMoaW5mby0+ZWRldiwgRVhUQ09OX1VTQl9IT1NULCB0cnVlKTsNCj4gPiAr
DQo+ID4gKwkJcmV0ID0gdXNiX3JvbGVfc3dpdGNoX3NldF9yb2xlKGluZm8tPnJvbGVfc3csIFVT
Ql9ST0xFX0hPU1QpOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCWRldl9lcnIoaW5mby0+ZGV2
LCAiZmFpbGVkIHRvIHNldCBob3N0IHJvbGU6ICVkXG4iLA0KPiA+ICsJCQkJcmV0KTsNCj4gPiAr
DQo+IA0KPiANCj4gSW5zdGVhZCBvZiBoYXZpbmcgdXNiX3JvbGVfc3dpdGNoX3NldF9yb2xlKCkg
aW4gdHdvIHBsYWNlcywgaG93IGFib3V0Og0KPiAxLiBzZXR0aW5nIGxvY2FsIHZhcmlhYmxlIHRv
IFVTQl9ST0xFX0hPU1QvVVNCX1JPTEVfTk9ORQ0KPiAyLiByZXR1cm4gb24gZGVmYXVsdA0KPiAz
LiBvbmUgY2FsbCB0byB1c2Jfcm9sZV9zd2l0Y2hfc2V0X3JvbGUoKSBvdXRzaWRlIG9mIHRoZSBj
YXNlPw0KPiANCj4gU2hvdWxkIGNyZWF0ZSBsZXNzIGNvZGUuDQoNClllcywgdGhpcyB3aWxsIGJl
IGJldHRlciwgSSB3aWxsIHVwZGF0ZSBpbiB2Mi4NCg0KPiANCj4gPiAgCQlicmVhazsNCj4gPiAg
CWRlZmF1bHQ6DQo+ID4gIAkJYnJlYWs7DQo+ID4gQEAgLTEzMyw2ICsxNDcsMTMgQEAgc3RhdGlj
IHZvaWQgcHRuNTE1MF9pcnFfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QNCj4gKndvcmspDQo+ID4g
IAkJCWV4dGNvbl9zZXRfc3RhdGVfc3luYyhpbmZvLT5lZGV2LA0KPiA+ICAJCQkJCUVYVENPTl9V
U0IsIGZhbHNlKTsNCj4gPiAgCQkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKGluZm8tPnZidXNf
Z3Bpb2QsIDApOw0KPiA+ICsNCj4gPiArCQkJcmV0ID0gdXNiX3JvbGVfc3dpdGNoX3NldF9yb2xl
KGluZm8tPnJvbGVfc3csDQo+ID4gKwkJCQkJCSAgICAgICBVU0JfUk9MRV9OT05FKTsNCj4gPiAr
CQkJaWYgKHJldCkNCj4gPiArCQkJCWRldl9lcnIoaW5mby0+ZGV2LA0KPiA+ICsJCQkJCSJmYWls
ZWQgdG8gc2V0IG5vbmUgcm9sZTogJWRcbiIsDQo+ID4gKwkJCQkJcmV0KTsNCj4gPiAgCQl9DQo+
ID4gIAl9DQo+ID4NCj4gPiBAQCAtMTk0LDYgKzIxNSwxNCBAQCBzdGF0aWMgaW50IHB0bjUxNTBf
aW5pdF9kZXZfdHlwZShzdHJ1Y3QgcHRuNTE1MF9pbmZvDQo+ICppbmZvKQ0KPiA+ICAJcmV0dXJu
IDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBwdG41MTUwX3B1dF9yb2xlX3N3KHZv
aWQgKmRhdGEpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBwdG41MTUwX2luZm8gKmluZm8gPSBkYXRh
Ow0KPiA+ICsNCj4gPiArCWNhbmNlbF93b3JrX3N5bmMoJmluZm8tPmlycV93b3JrKTsNCj4gDQo+
IFRoaXMgbG9va3MgaW5kZXBlbmRlbnQgYW5kIHNob3VsZCBiZSBleGVjdXRlZCBhbHdheXMgLSBl
dmVuIGlmIGdldHRpbmcNCj4gcm9sZV9zdyBpbiBwcm9iZSBkb2VzIG5vdCBzdWNjZWVkLg0KDQpB
Z3JlZWQsIEkgd2lsbCBhZGQgb25lIHBhdGNoIHRvIG1ha2UgdGhpcyBhY3Rpb24gdGFrZW4gaW4g
YWxsIGNhc2VzLg0KDQpUaGFua3MNCkxpIEp1bg0KDQo+IA0KPiA+ICsJdXNiX3JvbGVfc3dpdGNo
X3B1dChpbmZvLT5yb2xlX3N3KTsNCj4gPiArfQ0KPiA+ICsNCj4gDQo+IA0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
