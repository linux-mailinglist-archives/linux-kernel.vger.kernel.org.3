Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A5955B51D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 04:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiF0CGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiF0CGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:06:16 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4322AF7;
        Sun, 26 Jun 2022 19:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMQJvvZn63G2sTj0Lz+6FgNYeWTXzlD1Waz16p1T1Kyyo0JhrdBJmT6nt0NtHRxfBDoRL0xdhHODpU4uK2mWwLKe+e7gxJeP3faxMjiph2D1766l+iQEli1Q2QacGvIUW23m4ApYoAiUoufx8LFfT7X0jRZqpo0XbJJHJ+t5OrYpr61EGR2Yz6EN2/7cGi6MQW0DvoYSlHByBjc1bNG8VVFLGDxeoOpcPZYUSU7ODrwRuDId/l5niYi3KChOl+43TMnaO10V4X1WCnpw5JPoFtIZUjq8XvT13BbvSWYJbNuw+mVlqC+gzk6CsX1eFH3oqarGjQwN+GmlPo/NzKw16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cRXW+L+EU4wk6Rb4qONffahFuf45o0zfJoxJRUSP78=;
 b=E4VDArvqWGZNCeO+4UloOurHpPjuX30k2qKogVe9cn1QY2oPpQtiVe/8TN5isKsCSNROdU3V2bguw7RjARjHluPp+31hnwS4gAx/p6Djo4mSIvKvwoLQ9h3e+Vqb1QIf/2mare/j7jz+Oqv78VBv0NdJCn5nk5vfPWGjOkptgdtK2p7hqQ5HztNlfJhtxJJZWhPFUej+gd/bpIm9QHQPBH4ODWFnpPB0qn9qFGGFXz+X5YilpA3SVZ5T1gdQAHDM9XEcQKYBUs+y1L6C7slgyME3ugxL7aNituvgYaImaw8GFgWVMQpKpcwJoTpbkkTfsu03xtVT0nS/y8iScP7vdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cRXW+L+EU4wk6Rb4qONffahFuf45o0zfJoxJRUSP78=;
 b=FS6Fi5sV/ioVRRcWCHSPCyzf3f/Pb1Kx/EnbmDvQ/LdkUEfdeq+f8aFPEURBt+Htgn049aDBtFfgqH8BjQeFWURf4umA3PAzZdELC/lQJfV1JcaPDNwMN/M8c2wfcuDJUaTM9lW4/g0gX4PICkYil4XyVrktxtUhkKu+Asn+75eR9zsq0CljiKUpUkXtcjN8dt+zpvLsQfPtgQLzYcNBCVUA8QNGfSx4g5aS2mFpIfxrpd9cjUHD+Fbj1N+rgT+4IRUUxTzBu/eG/z6IgcLTIP3MWkxLhDpubwlJGC6LHmMsjodfF9GV7gJzlPuUwItr+8XvL1u/B8Tl6788bCB+kg==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by PS2PR06MB3302.apcprd06.prod.outlook.com (2603:1096:300:6d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 02:06:06 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 02:06:06 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Dhananjay Phadke <dphadke@linux.microsoft.com>,
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
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 0/5] Add Aspeed crypto driver for hardware acceleration
Thread-Topic: [PATCH v4 0/5] Add Aspeed crypto driver for hardware
 acceleration
Thread-Index: AQHYh6oRMJbDpiWrGUu0QK4JHLyX1K1fd/6AgAMNVgA=
Date:   Mon, 27 Jun 2022 02:06:06 +0000
Message-ID: <HK0PR06MB3202A2C71562AB1F9202DEAD80B99@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220624090827.3909179-1-neal_liu@aspeedtech.com>
 <3dde4d8e-5f97-dc07-1763-981942d23f12@linux.microsoft.com>
In-Reply-To: <3dde4d8e-5f97-dc07-1763-981942d23f12@linux.microsoft.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5feffc1c-3785-48fb-bef4-08da57e19896
x-ms-traffictypediagnostic: PS2PR06MB3302:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e4h/4Io2dn6lrkDtumrG739fT/ieoN1VxGm/v5BW24Nj9+oE1sjd76vJMnC7M3HxKk/T8F+albvzAP/0XZfHznUjEnOjRxneFTf16K2qvEjU4oCRArT4d3f57Qcp8jXCrwB3i+v7e9tbasOXof1wf3Qgj35bhLHNS2LW24l9UBytdEJiqAejPeNwBrq4OQQQ5E33UET4YGeuW8/Mqmc1Kvv7wAbpY9kJxPoE7Gp97PX2A5gr4+nREyQfgwmGzf0NjFAVaijRSpfpD5aAzKU6xm7+87QuCVOOeMr7YbcnJrS/GuO8cAnPobpnsKPxQOerSGpo1P0PI/V7u71EJ20YQhERD3DK9+QOCM1WKlmE9nZtXUZzqAticvUfmX22tF5M+7+ajUKXrVWhF+Dk195EZkUP0aNZOeFU0dsIJF2ElqhcjtLaIzQuyRvmoDVjLBsGw50ogYuEzIgD+N4S2PoEMMhVbuj9qjy5d5jErRRfDKBhDKHleAhJmIxR3YfJ9JUQMyfAyHUuFdzcRVSFfGFZb4yFWMCZ6bnL3loHOJ/ABJQJC4OIL+bfhm6JeRiWHdV7ZPWenqAkf3+8KDHupaygMQH1HLpQd/OfXQfb8JnZQeAGN7dlelhRqAnDa3ePcBn4vdloOCcxdknghrcLr0YkMMKZGIOz7CXxHeJ5cF6z8xpEujTOlaR7jcPBLd/nh0oGh311c9mCaqfHpolCvaL0SkQuHVuW+YIgGdSWUJOTvbC+75/DA++Ps7NAcXF8HsFesH6/9WRfRFFACfLHnbHsqy5OkxxMKQm8TaohQd1u1Dhu9gPTl91q3O9xOdPnp4qV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(346002)(39840400004)(376002)(38100700002)(66556008)(53546011)(316002)(33656002)(4326008)(478600001)(5660300002)(2906002)(52536014)(76116006)(83380400001)(71200400001)(66476007)(55016003)(54906003)(66446008)(6636002)(7696005)(186003)(8676002)(7416002)(8936002)(6506007)(26005)(921005)(86362001)(122000001)(66946007)(110136005)(41300700001)(64756008)(38070700005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGRpZWYwempnaGl0SDRnSm5rSXRzTjE3L0NIby9IOFJYN2ZCT0V0S3FsTXVX?=
 =?utf-8?B?ZVFNTTYzVW1BR0p3UDRHMnFhNmI2MHNRM1o1ZkQ5b2xxY1ZXVS8ySkR5SnJZ?=
 =?utf-8?B?U2w5dk5JS0lBZ1dUM0RKcCt3WWJhZ3lvT0pFeVYvQy91OWZ2QXpkWk1EcklI?=
 =?utf-8?B?d29nZDhYNkhJVFBPc2txNTU4UEJxM1YrUkRXYmtuT0V6VFltTi9RcnBKTlBV?=
 =?utf-8?B?MlQ5U3dReldtZzR2VWo0M01VSURVS2MvS05ZSTZVV2pkWjArblU2NDZDNGtz?=
 =?utf-8?B?VEh1dWRoTTcvT1FLMmZJUGlLMDEzMUFMM0xpRzBSbmxSS1VYNi8vU1ZTaUZ4?=
 =?utf-8?B?ZHh1YmxyNGl4R3hmeGpIMkhyeTE1ZG4xKzhSVGVYU2VGOTRheTRsT0ZOU0RT?=
 =?utf-8?B?RWRNeTNkMldkMGUwZFlvS1BnZ21qVjZlYjByclhtUUVWQWtNYkdzNUhYMGVh?=
 =?utf-8?B?QTY5eEY1dkgzL1VDeCtVS1JZaXFPcjlpcUpPQWNML0V1Z2puNEFkeHpZTUJO?=
 =?utf-8?B?enpnZDc1dGVMSUxKUmJML29nZWVRRUhpNHplVzdJNFJuMXNaUnNTNTYwdmpW?=
 =?utf-8?B?aUlYdFVEaVN6OHZPS3N3R1FaRFoyMTdoa3B6UVU5bHNvVEV6ZFlKZVVhT0hO?=
 =?utf-8?B?bnFLUFVBNTVqVXdhQUZKeEtBREF2eXg2bnJ0S3ppUCtzK2hiTEM5S1IrTXRM?=
 =?utf-8?B?Z0dEalJJNFRsWmZwZGowUndhdmJlK1N5VWV0QTBxMGFVY3luK2RyWGdEVGhS?=
 =?utf-8?B?ZmY1RCt0QVdjVzY5MVd0SnZKWHNmK0FxbUJRQnhDZVFKa240ZHVsMDhFUzNL?=
 =?utf-8?B?dzhRU01HUlRIcTdWbytFb1o5U3Q4ZkxIc3lwZW5nM0dySEVqTUliMEJmQlk5?=
 =?utf-8?B?bWJtR0JsSnhlN2xHaG0xdElxbjZXWjc4TWhmQzdaaEczTE44NG4rSTNSTkJq?=
 =?utf-8?B?V1hyWkVkQk96dUliTXpDYXpQakorSE5qdWxnUGdvSkhZM1R2SmZGU1I5V2dt?=
 =?utf-8?B?blNOQ0N4TUEycGo4M0V1eHlHdWZBdGFiODhBVEJ5c0NPY1pGUGpYSUZ3Q2lw?=
 =?utf-8?B?S3pENkhZSGpQNlgvRG9uZTZId2sxS0VudURRd0N3eDNqUDlTYWlINmo2ZE9P?=
 =?utf-8?B?Y2Zqd09pbzQzSUxvR1hwOEJxckptQnhHOFloNEVkWkltbnJJcWNLc1RBdDFG?=
 =?utf-8?B?b0RZbVJFRHg4NXlZTHJTcEw0Q0FYQTNqNHZpeXpSQ1NEb3hWVlQ0azcxbTQz?=
 =?utf-8?B?NGNjT0tzRUxtcWIvY1N3UHhqVkZwb3MyTlg2cExwUXhRUy80eEFpZUxIeGlR?=
 =?utf-8?B?bGwxZzRPSnYxR1RhMEJveFByY0UvSG5YZGRSc0dab0JucWdyN0ZwTGhZZ3JD?=
 =?utf-8?B?UWhDN3EyOHplUmZjRlBnNHRVMGczZVR2VGJtTGRGM3c1RHhvdzBXZUI5emgr?=
 =?utf-8?B?M09VSEg1WGlOM1N1aDBJV1REK1Q0Y2s4cytXZzNQQUxRbU85blZwWWw2ampZ?=
 =?utf-8?B?eDZiWGhBQ1ByVC93OFBxYU1CSnd1RURUL1dMemdjYWtDdHJySG9OL0hYZXhW?=
 =?utf-8?B?c0o2VmFaM0RuOUc3NnJULzRxMXMwdDZxa0c1bXNOSXFSTWZhUTJ6ODMwRmMz?=
 =?utf-8?B?V2Y4TjZIL1RSdm5ONHYzT1M3NFErb3A3RjNCZHQxUjZ5ME9ZeGxJRDZVaktl?=
 =?utf-8?B?RHZXb2pGMXhnQWRkZ210bTVmS0UzQU8vbUxyblVqSSsyV3RTYm02aXd4YWlw?=
 =?utf-8?B?cmpCanJlVEVrVXQ4S3BxU29YVmhuaW5zcFJvTDF6QlV6WTRCU1Nid2xOK2or?=
 =?utf-8?B?QjdmSGpraWMwMit2cnI5UnFvMGd6NzBIZDdCWFJYdjMvRjBWejc0Uk5OYlhO?=
 =?utf-8?B?TEZVdnZiKzBqZVJZTzZnMjhTcllSRnNZK1V5djc3eXk4WmhMRUVTYjBCbHJi?=
 =?utf-8?B?Z1JKbUdYNTJxQWtob1g3dWVBdUJ4NFdUL2YvdzBuN25aYlhuZ1ZBOG5ZODdr?=
 =?utf-8?B?eGw4MFJLV3NXTGtIRUFHeEozVk01b1gzMERlenRpV0xRc004T2Z5YzRGdnBQ?=
 =?utf-8?B?a3R6M09BK2g4SDJRV2g0MkZFeFZUeDZCanltMU1sWVN5ZkpYdm5Oc055azJi?=
 =?utf-8?Q?xFX3mPPvXq17+jYJdRp9C/SgQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5feffc1c-3785-48fb-bef4-08da57e19896
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 02:06:06.5308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oWeyKVRvQ30FmeoIQVe/5zsvqKElRoL8iVsR2c0xGY05ExTpHRVtYhDWYAYKKhrbhcW+2NemCHIVT0NJZSJIjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3302
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSBOZWFsLA0KPiANCj4gT24gNi8yNC8yMDIyIDI6MDggQU0sIE5lYWwgTGl1IHdyb3RlOg0K
PiA+IEFzcGVlZCBIYXNoIGFuZCBDcnlwdG8gRW5naW5lIChIQUNFKSBpcyBkZXNpZ25lZCB0byBh
Y2NlbGVyYXRlIHRoZQ0KPiA+IHRocm91Z2hwdXQgb2YgaGFzaCBkYXRhIGRpZ2VzdCwgZW5jcnlw
dGlvbiBhbmQgZGVjcnlwdGlvbi4NCj4gPg0KPiA+IFRoZXNlIHBhdGNoZXMgYWltIHRvIGFkZCBB
c3BlZWQgaGFzaCAmIGNyeXB0byBkcml2ZXIgc3VwcG9ydC4NCj4gPiBUaGUgaGFzaCAmIGNyeXB0
byBkcml2ZXIgYWxzbyBwYXNzIHRoZSBydW4tdGltZSBzZWxmIHRlc3RzIHRoYXQgdGFrZQ0KPiA+
IHBsYWNlIGF0IGFsZ29yaXRobSByZWdpc3RyYXRpb24uDQo+ID4NCj4gPiBUZXN0ZWQtYnkgYmVs
b3cgY29uZmlnczoNCj4gPiAtIENPTkZJR19DUllQVE9fTUFOQUdFUl9ESVNBQkxFX1RFU1RTIGlz
IG5vdCBzZXQNCj4gPiAtIENPTkZJR19DUllQVE9fTUFOQUdFUl9FWFRSQV9URVNUUz15DQo+ID4g
LSBDT05GSUdfRE1BX0FQSV9ERUJVRz15DQo+ID4gLSBDT05GSUdfRE1BX0FQSV9ERUJVR19TRz15
DQo+ID4gLSBDT05GSUdfQ1BVX0JJR19FTkRJQU49eQ0KPiA+DQo+ID4gQ2hhbmdlIHNpbmNlIHYz
Og0KPiA+IC0gVXNlIGRtYW1fYWxsb2NfY29oZXJlbnQoKSBpbnN0ZWFkIHRvIG1hbmFnZSBkbWFf
YWxsb2NfY29oZXJlbnQoKS4NCj4gPiAtIEFkZCBtb3JlIGVycm9yIGhhbmRsZXIgb2YgZG1hX3By
ZXBhcmUoKSAmIGNyeXB0b19lbmdpbmVfc3RhcnQoKS4NCj4gPg0KPiA+IENoYW5nZSBzaW5jZSB2
MjoNCj4gPiAtIEZpeCBlbmRpYW5uZXNzIGlzc3VlLiBUZXN0ZWQgb24gYm90aCBsaXR0bGUgZW5k
aWFuICYgYmlnIGVuZGlhbg0KPiA+ICAgIHN5c3RlbS4NCj4gPiAtIFVzZSBjb21tb24gY3J5cHRv
IGhhcmR3YXJlIGVuZ2luZSBmb3IgZW5xdWV1ZSAmIGRlcXVldWUgcmVxdWVzdHMuDQo+ID4gLSBV
c2UgcHJlLWRlZmluZWQgSVZzIGZvciBTSEEtZmFtaWx5Lg0KPiA+IC0gUmV2aXNlIGVycm9yIGhh
bmRsZXIgZmxvdy4NCj4gPiAtIEZpeCBzb3J0cyBvZiBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuDQo+
ID4NCj4gPiBDaGFuZ2Ugc2luY2UgdjE6DQo+ID4gLSBBZGQgbW9yZSBlcnJvciBoYW5kbGVycywg
aW5jbHVkaW5nIERNQSBtZW1vcnkgYWxsb2NhdGUvZnJlZSwgRE1BDQo+ID4gICAgbWFwL3VubWFw
LCBjbG9jayBlbmFibGUvZGlzYWJsZSwgZXRjLg0KPiA+IC0gRml4IGNoZWNrIGRtYV9tYXAgZXJy
b3IgZm9yIGNvbmZpZyBETUFfQVBJX0RFQlVHLg0KPiA+IC0gRml4IGR0LWJpbmRpbmcgZG9jICYg
ZHRzIG5vZGUgbmFtaW5nLg0KPiA+DQo+ID4NCj4gPiBOZWFsIExpdSAoNSk6DQo+ID4gICAgY3J5
cHRvOiBhc3BlZWQ6IEFkZCBIQUNFIGhhc2ggZHJpdmVyDQo+ID4gICAgZHQtYmluZGluZ3M6IGNs
b2NrOiBBZGQgQVNUMjYwMCBIQUNFIHJlc2V0IGRlZmluaXRpb24NCj4gPiAgICBBUk06IGR0czog
YXNwZWVkOiBBZGQgSEFDRSBkZXZpY2UgY29udHJvbGxlciBub2RlDQo+ID4gICAgZHQtYmluZGlu
Z3M6IGNyeXB0bzogYWRkIGRvY3VtZW50YXRpb24gZm9yIGFzcGVlZCBoYWNlDQo+ID4gICAgY3J5
cHRvOiBhc3BlZWQ6IGFkZCBIQUNFIGNyeXB0byBkcml2ZXINCj4gDQo+IFRoZSBkcml2ZXIgY2xh
aW1zIGNvbXBhdGlibGUgd2l0aCBhc3BlZWQsYXN0MjUwMC1oYWNlLCBidXQgdGhlcmUncyBubw0K
PiBlcXVpdmFsZW50IGc1IERUUyBjaGFuZ2UgKHBhdGNoIDMvNSkgb3IgcmVzZXQgZGVmaW5pdGlv
biAocGF0Y2ggMi81KSBpbg0KPiBhc3BlZWQtY2xvY2suaD8gRWl0aGVyIGRyb3AgYXN0MjUwMCBj
b21wYXRpYmxlIGZyb20gdGhpcyBwYXRjaCBzZXJpZXMgb3IgZml4DQo+IHRoZXNlLg0KPiANCj4g
VGhhbmtzLA0KPiBEaGFuYW5qYXkNCg0KT2theSwgSSBtaXNzIHRoaXMgcGFydC4gSSdsbCBmaXgg
aXQgaW4gbmV4dCBwYXRjaC4NClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0K
