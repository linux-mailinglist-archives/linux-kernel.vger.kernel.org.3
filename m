Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C66251D758
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391662AbiEFMOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391656AbiEFMOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:14:49 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2129.outbound.protection.outlook.com [40.107.114.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6695933D;
        Fri,  6 May 2022 05:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyxlWbHvIzvCz9ErGH4H2ZSBHhWl0owNGYC4jWM+w/E3tQTimSu1m3WCJH80S9OsAEHVLNC1YUZudtknKc1RwKrGpO834ZvX0jmBauHaeYCaOtYQxLRsxzYW8GaEu72uEnVBDNy8gKizTtctcbr7J8iQLOHwvXIrzRSRgs8dw8/DsLGGRfVDXfuHfU/pwqyNfBgyg0i4hRssPTuFDwTeQoY24EonDrQGZeXuzBtBX73ZmBg227QKPbrmlAkrqtZox0qSlMmZPaR6Z2In7K9Cx/OmA0GZO8RJCmKHjybluJABdJDToQcJ0vVWEl3T431s5uSCkNpQJhZwVJWAh/HSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mbza+BIVwVCPc319THHiFMNVtWGa2JUpnH6nDBvZLAk=;
 b=BTS1vLRbQckT1Mn/wu8y85y5rCHXrgD20neAT7B5pfEQJk54agkrT3PLQZPlImhjxT+GusfN3s9GVcKf6kTagxrG45zhG27tWZINPSsmxLEpJc+ZJaB6AeoToXTopwsV3MoNFOMQGHWe6yV2k6edTdTS1aU/ZqxfVoDlDy3sbi7afdGEzBNRCs1aS8rKtkP0ojGXiiXRmD+P8NsAuyw0nU7OuFKHhUrix3qP69+SPXBAgi0/EayI70a8GUoLc0Q9NPExU6XyTzW9EliEXlAEqQgnf+bIo4i35dZMZjyA56GH5NGIybKAU0252aQD4bGwXVnXo1PwvXauJrMfQoOQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mbza+BIVwVCPc319THHiFMNVtWGa2JUpnH6nDBvZLAk=;
 b=PLDzvBxcNuY8tof/mtSVd1Lwy+Fp2ygw/7A3nTVnpxV+jEjUst6GFsCScnZcLUzYKhe0X+tqlVFsRcJMGvrHp9fIUHAZ8Ry30rrdbpzE9z0f9b3Cc1teRfLLWbU4Yr0nYgQOx/Z6eNSN+Mmn4dA228TLjYnFnFvFTsLPxMUNLJI=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by TYYPR01MB6894.jpnprd01.prod.outlook.com (2603:1096:400:d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 6 May
 2022 12:11:00 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::541f:37c5:2149:bbb4]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::541f:37c5:2149:bbb4%9]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 12:11:00 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: RE: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stack the
 resets instead of indexing
Thread-Topic: [RFC PATCH 2/4] clk: renesas: rzg2l-cpg: Add support to stack
 the resets instead of indexing
Thread-Index: AQHYYLbVZusSN6uyHkGFU4WhZ5VwLK0QryBggAEPAwCAAAH7gA==
Date:   Fri, 6 May 2022 12:11:00 +0000
Message-ID: <TYCPR01MB59337E4D599F0E69D81E308086C59@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220505193143.31826-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB592225B5A5E1BA7D250C466786C29@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8shz+Wbj84vjaw=_Sys1TW45HC2RMy4fy_5QBR-hvNGFg@mail.gmail.com>
In-Reply-To: <CA+V-a8shz+Wbj84vjaw=_Sys1TW45HC2RMy4fy_5QBR-hvNGFg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bea7d854-e775-4478-9aa9-08da2f597bdd
x-ms-traffictypediagnostic: TYYPR01MB6894:EE_
x-microsoft-antispam-prvs: <TYYPR01MB6894F0FFAD08B7AB67BA8BAD86C59@TYYPR01MB6894.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BgmwsjGHCPr2upUzYqCFoAERyxbCbWbDBQa1RB4bU/rrWQPJ26OTPyUCnBmbM7w8b+3L2+M5bpmP/ydox9UNJJHypSS6Z2AcITIdO1Piw7Dzwzm8QHwfnZyvFRmpVCZv3DyxS1flQR2WnY3muuaG1E0kgy61eSpf1KtFilRnB3LVzcAQZL0WJTXsSnZDndSHW6TWBTe7YLCPU/WUIA/v+7NsuTewkDbdR2pHLsP20DSzjoeV8S5tRDD7b0/YYlGFBoHHythJO2LOKxO4vKbPkoY8zBxJpwujJH7Iv2Kyhib8y47QzFfto7JTZvT085ZAVY7UKZAQFMqwslk90kagpymkZfxt3iLORCtWN2xlM15N2ZElV7szWy7N8cammylWvblTe7g5emhDii8/PhZ7GqGxnVBK8Zvi+6Cf6exQ9XEJxChKtTI8CzU4rxDp++Eu37WeqdP7IFM3f2F74tkjRT/W4rRtgMi82B/jU5WXr6ZYevZI7r4NthrOL8OLS383o/MudtAjfNpji+gztgn5XDAVShokRo39vooNI7CIyUGxEO2FunsJXEnuXTsDLIJyLJUxbJQMb2jyoYChFdzpX6SJ86pBx/cI5cxKh6i+TmcOEw0iDqMQCNUy1LReHsKwJphI+d4ubV6gM7qiyxynIxOh5Pyc6N5CMWo1p/wT4zAeso/XyrhG99PamY7Q/6LVY1qmxUi3coWh2VNZSnY/QSwPkTN/UPSioaLcqibAHxdMbGh5VAlC7uvwhoywialltAuqOZ9tXUTxjpJ3njW7BbiHs2DHWSQULfB8j7hSNWM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(122000001)(64756008)(4326008)(6506007)(76116006)(316002)(8676002)(66446008)(66556008)(66476007)(53546011)(66946007)(107886003)(8936002)(52536014)(6916009)(7696005)(54906003)(38070700005)(38100700002)(26005)(9686003)(33656002)(2906002)(83380400001)(7416002)(71200400001)(508600001)(5660300002)(86362001)(966005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVF5TGFNU2NuQks0ZGpsb21CTFNJcElRZG5kTHhheWtlZlBzVnpNY05CY1pI?=
 =?utf-8?B?M2syamtOTkVvZnVDOThuS1gwUmtsaWxrT0dOeEM4RWllMUpiQWdvVE5jbFZk?=
 =?utf-8?B?ZDhFQ0JjbjhaZ2xyY1lOU0x4TWJWRDhBZGplL29qRTBNUmhaT1kwbmtiY3VD?=
 =?utf-8?B?NEJsdFpWRVUwaVBHVkU5TjJNek13MW5zM0tzSjg5bENEb0FvWEtkeC9SN205?=
 =?utf-8?B?Tk1LUnJFZ3dQZHBkMEd4K3NMUmhzV0V4clJ5VkdFdnJIRUphTzRsRkI4TTlq?=
 =?utf-8?B?cm9ueld1OXVkVTlnaWVQMmMxaTFYSXV2YmNpRFJ3QllBMmlFZ3hSeEU1Zkcr?=
 =?utf-8?B?QU5Vcno1eWJWZitNU2tNUE92TStoYVlhaGFmSjVTWmZhenZxSTJXVDdPdVBG?=
 =?utf-8?B?NVU5NXNDQk8xMXk4L21ZYjMrUzh2eUhpM2dVaHBnY1U0dkhjZW9GVUlUY1ZB?=
 =?utf-8?B?bGJhZ0hUekpGVWJYOWhmR1VlK2gwRW1sK1hjUlJsRXpBRzg5Y3RpVWxISGNS?=
 =?utf-8?B?d3oxZVRhSDBNNkx0OVczakZsT0l1VnNxMnNwd2IvSFlpMUJ2WDkvOTBMNGN0?=
 =?utf-8?B?RXRmUUQxSlg4b3ZUVWVMTnhNTzd0ODVMU1hxQjVRTS94eEdNM08ycEJBTDUx?=
 =?utf-8?B?WWQ5ZFR4Wi91SkxOTGFob040NTQvMXpLK3lmZmhtaEE5YlBOVmpnbDlDZVpG?=
 =?utf-8?B?MldqRmR0aWFWZnF4S3B3U1NxRWJrcXM1bUNaRVlYMW1Oak5UWXBkKzdURWMx?=
 =?utf-8?B?WkxDdEdNVk5CWGFPR25IZXcrM29EMHZJdVJWalNnTUxzRVp0RXowN2xEM1VP?=
 =?utf-8?B?ZW1jL0pTYnlreDFGM01TRDR3bUd0VmgvWUpQVFRCeXBtQXBGejdmM0I3UzFj?=
 =?utf-8?B?SmQwU1hnY2hJemVsaWN2dnFkazlMOVlmbEppRXgvcFo1YTI4d2ZLSFNlWXFp?=
 =?utf-8?B?NEZiMVRadWdIc2dITktIcys3V0dRYnJJaWhYVUJSSnNGb3JlTUdNT3NQYklZ?=
 =?utf-8?B?ZFdweno5amVRVWJFSVdjVG1EZE5HbjVuQlVGWlNZL2p5RVphU1NHL08rbVFa?=
 =?utf-8?B?Lzk0dEM5Y2ExRUVTcXhDRXNQMUg5cDA2aVVjZEkxOUlIODQ4Rkd6Z1pEN05H?=
 =?utf-8?B?cG45cXVrMWhVMUdUczlIbVJETkdKNElDMlUxK1BQV2Z2c2hxYnZhbEZPdTdH?=
 =?utf-8?B?NGJFcnNaSTA3L2J4L0F1U0c2bWh4SW9pZmlleVQ0blB2OU9NMkpFOTh6ZEdD?=
 =?utf-8?B?VlQ2a1l1QXhiU0t2bXlXVjYxODBnTld6NStrYVZKdEJUT2N6cFRaTGlPa1Rz?=
 =?utf-8?B?OTdidVAvTyt0eG50QytjWngrcG5KbzRVRHJ5U0w0L3U5d0dva25qNmZpSDJG?=
 =?utf-8?B?a25vVzIwcGROL283QllKRTJicHpaNEZrek5DeW1QY1F3MkFJcE15RXp4WU4r?=
 =?utf-8?B?THduRFZUdVliNC9TMVVlVi9Gb2FtdWhlcVBJdFcvNUVtdTJMaHRtMkc2OHJ5?=
 =?utf-8?B?eWlVbUtFazJicTRjZDI2NkUzdFN4TDhBdlk4bkNSSnJvRlZNUjl3aEdoanFz?=
 =?utf-8?B?ZmJqWnFYVEFoajVwQ3hOL1BldFZCU1BLN1RJRjdnQVNaV3pWNkhlM0xwWGJa?=
 =?utf-8?B?cmVoWkthMFBBRkpIQXdUTlBUSTJKRlV2R1dJQlQxM3lnS1pMV1p1QzBXd2tn?=
 =?utf-8?B?YUVYZ2FFN21xWU1GNUkyR3R5R3A0Y1pnZkJoLzFlT1ZFWmtvOGNJdnJBREoy?=
 =?utf-8?B?eFVxb3NPM29DQW14bEcxWDFCQ09ZYUF0Ri9NN3hSQW5yV2Z5N21BS24yUWNm?=
 =?utf-8?B?WjJvVWU5UjNQdmdWRC81Zi83ektCd2ZldGRqazdZdCszSHh5TW01d1hqM240?=
 =?utf-8?B?VXBZU1A0YlRNVTZISloxR3hoNHZESW5XMVE5a1hId3ZXUHNlRFNySGFtcjZ2?=
 =?utf-8?B?Y0VXVFFCTnhJVDRQWVNrQisrWWVOSERtWXZNRWRja01hWlhtZWkrT0ZGRWFu?=
 =?utf-8?B?djNmNHNDZVZ6U2tnQUIyTmlpSFl0NXFYL2JBZzBzamRaVlNrUEdGYzVjK2ZG?=
 =?utf-8?B?Um9zbUphK2ZGSHZvdmQxSGZpZGZwOVdibWFUTjhtMGRMMVJrL2NjU05xalls?=
 =?utf-8?B?djFrb3p1OVkvVFFOVDFkM08wMzA3VUs4a01HR0FtY2NYNjhYZTExcmFoTXZV?=
 =?utf-8?B?SHZIU3pKVkc4QWN2b01zMnFUajIxdTVvQThrWWFKV0xhTWpGN0phVnB2dXRk?=
 =?utf-8?B?UDFYVmJkUndlV0YxZGE0elRwbFJ3VHU2WGtZUFh4YlUwRXJFUGxMUklqTkIw?=
 =?utf-8?B?emdGOUtqaG5oMEdDREFEVDQxenBWUDZGV0lsRVN3eWJQVU52ejNKMkdjUHNR?=
 =?utf-8?Q?9z9KwVosfy8Nul8I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea7d854-e775-4478-9aa9-08da2f597bdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 12:11:00.2748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARbpB7c1mhBmTfIZ9lHqog4upn+0gExQM7G8aPkHnyFzq1OiJn3AbASwBFurO/5VHGD8dw8AdxX06N124gegcPLnnFEA3dw/pyojKdGSQuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6894
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUHJhYmhha2FyLA0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAyLzRdIGNsazogcmVuZXNh
czogcnpnMmwtY3BnOiBBZGQgc3VwcG9ydCB0byBzdGFjaw0KPiB0aGUgcmVzZXRzIGluc3RlYWQg
b2YgaW5kZXhpbmcNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSByZXZp
ZXcuDQo+IA0KPiBPbiBUaHUsIE1heSA1LCAyMDIyIGF0IDg6NDggUE0gQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIExhZCBQcmFiaGFrYXIs
DQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSBwYXRjaC4NCj4gPg0KPiA+ID4gU3ViamVjdDogW1JG
QyBQQVRDSCAyLzRdIGNsazogcmVuZXNhczogcnpnMmwtY3BnOiBBZGQgc3VwcG9ydCB0bw0KPiA+
ID4gc3RhY2sgdGhlIHJlc2V0cyBpbnN0ZWFkIG9mIGluZGV4aW5nDQo+ID4gPg0KPiA+ID4gSW5z
dGVhZCBvZiBpbmRleGluZyB0aGUgcmVzZXRzLCBzdGFjayB0aGVtIGFuZCBpbnN0ZWFkIGNyZWF0
ZSBhbiBpZA0KPiA+ID4gbWVtYmVyIGluIHN0cnVjdCByemcybF9yZXNldCB0byBzdG9yZSB0aGUg
aW5kZXguIFdpdGggdGhpcyBhcHByb2FjaA0KPiA+ID4gZm9yIGV2ZXJ5IGlkIHdlIHdpbGwgaGF2
ZSB0byBsb29wIHRocm91Z2ggdGhlIHJlc2V0cyBhcnJheSB0byBtYXRjaCB0aGUNCj4gaWQuDQo+
ID4gPg0KPiA+ID4gVGhpcyBpbiBwcmVwYXJhdGlvbiB0byBhZGQgc3VwcG9ydCBmb3IgUmVuZXNh
cyBSWi9GaXZlIENQRyBpbg0KPiA+ID4gcjlhMDdnMDQzLSBjcGcuYyBmaWxlIHdoZXJlIHRoZSBy
ZXNldHMgYXJyYXkgd2lsbCBiZSBzcGxpdCB1cCBpbnRvDQo+ID4gPiB0aHJlZSBpLmUuIGNvbW1v
biBhbmQgdHdvIFNvQyBzcGVjaWZpYy4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMYWQg
UHJhYmhha2FyDQo+ID4gPiA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29t
Pg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9jbGsvcmVuZXNhcy9yemcybC1jcGcuYyB8IDc2
DQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0gZHJpdmVycy9jbGsvcmVu
ZXNhcy9yemcybC1jcGcuaCB8DQo+ID4gPiA0ICstDQo+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA2
MyBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jbGsvcmVuZXNhcy9yemcybC1jcGcuYw0KPiA+ID4gYi9kcml2ZXJzL2Nsay9y
ZW5lc2FzL3J6ZzJsLSBjcGcuYyBpbmRleCAxY2UzNWY2NTY4MmIuLjk0ZmUzMDdlYzRjNQ0KPiA+
ID4gMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2Nsay9yZW5lc2FzL3J6ZzJsLWNwZy5jDQo+
ID4gPiArKysgYi9kcml2ZXJzL2Nsay9yZW5lc2FzL3J6ZzJsLWNwZy5jDQo+ID4gPiBAQCAtNjgx
LDE0ICs2ODEsMzcgQEAgcnpnMmxfY3BnX3JlZ2lzdGVyX21vZF9jbGsoY29uc3Qgc3RydWN0DQo+
ID4gPiByemcybF9tb2RfY2xrICptb2QsDQo+ID4gPg0KPiA+ID4gICNkZWZpbmUgcmNkZXZfdG9f
cHJpdih4KSAgICAgY29udGFpbmVyX29mKHgsIHN0cnVjdCByemcybF9jcGdfcHJpdiwNCj4gPiA+
IHJjZGV2KQ0KPiA+ID4NCj4gPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHJ6ZzJsX3Jlc2V0DQo+
ID4gPiArKnJ6ZzJsX2dldF9yZXNldF9wdHIoc3RydWN0IHJ6ZzJsX2NwZ19wcml2ICpwcml2LA0K
PiA+ID4gKyAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgaWQpDQo+ID4gPiArDQo+ID4g
PiArew0KPiA+ID4gKyAgICAgY29uc3Qgc3RydWN0IHJ6ZzJsX2NwZ19pbmZvICppbmZvID0gcHJp
di0+aW5mbzsNCj4gPiA+ICsgICAgIHVuc2lnbmVkIGludCBpOw0KPiA+ID4gKw0KPiA+ID4gKyAg
ICAgZm9yIChpID0gMDsgaSA8IHByaXYtPm51bV9yZXNldHM7IGkrKykgew0KPiA+ID4gKyAgICAg
ICAgICAgICBpZiAoaW5mby0+cmVzZXRzW2ldLmlkID09IGlkKQ0KPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiAmaW5mby0+cmVzZXRzW2ldOw0KPiA+ID4gKyAgICAgfQ0KPiA+DQo+
ID4gSXMgaXQgbm90IHBvc3NpYmxlIHRvIHVzZSBzaGFyZWQgcmVzZXQgbGlrZSBSWi9HMkwgYW5k
IFJaL1YyTD8sIHdoaWNoDQo+ID4gaGFzIG9wdGltYWwgbWVtb3J5IGFuZCBwZXJmb3JtYW5jZSB3
aXNlIHdlIGNhbiBhdm9pZCBiaWdnZXIgbG9vcC4NCj4gPg0KPiA+IExpa2UgYWRkaW5nIExhc3Qg
aW5kZXggb2YgUlovRml2ZSBhcyBsYXN0IHJlc2V0IGluZGV4IGFuZCBIYW5kbGUNCj4gPiBSWi9H
MlVMIHNwZWNpZmljIGFzIGludmFsaWQgcmVzZXQgaW5kZXggaW4geGxhdGU/Pw0KPiA+DQo+IFNv
IHdlIHdpbGwgaGF2ZSB0byBtYWludGFpbiBhbiBhcnJheSBpZCdzIHdoaWNoIGFyZSBpbnZhbGlk
IHRvIFJaL0ZpdmUgU29DLg0KPiBGb3IgdGhpcyB0b28gd2Ugd2lsbCBoYXZlIHRvIGxvb3AgYXQg
cnVudGltZSBpdHNlbGYuIFRoZSBhcnJheSBmb3IgaW52YWxpZA0KPiBpbmRleCB3aWxsIGJlIGJp
ZyB0b28uDQoNCkFzIHBlciBbMV0sIGl0IHdpbGwgYmUgMjUgcmVzZXRzLg0KDQppZiB5b3UgaW52
YWxpZGF0ZSBSWi9HMkwgc3BlY2lmaWMgcmVzZXRzIGluIHByb2JlLCB0aGVyZSBpcyBubyBydW50
aW1lIG92ZXJoZWFkLg0Kd2hlbiBhIGRldmljZSBtYXRjaCBmb3VuZCwgdGhlIGluZm8tPnJlc2V0
X2NhbGxiYWNrKCkgd2hpY2ggaXMgbWVudGlvbmVkIGluIHRoZSBuZXh0IG1haWwNCmFuZCBpbnZh
bGlkYXRlIHRoZSByZXNldHMocmVzZXRzW2lkXS5vZmYgPSAwKQ0KDQppZSwNCg0KaWYoaW5mby0+
cmVzZXRfY2FsbGJhY2spDQogaW5mby0+cmVzZXRfY2FsbGJhY2soKTsNCg0KYW5kIG9uIHI5YTA3
ZzA0My1jcGcuYywgbWFrZSByZXNldHNbaWRdLm9mZiA9IDAgdG8gaW52YWxpZGF0ZSB0aGUgcmVz
ZXRzLg0KDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9n
ZWVydC9yZW5lc2FzLWRyaXZlcnMuZ2l0L3RyZWUvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9y
OWEwN2cwNDMtY3BnLmgNCg0KDQoNCg0KPiANCj4gPg0KPiA+ID4gKw0KPiA+ID4gKyAgICAgcmV0
dXJuIE5VTEw7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gIHN0YXRpYyBpbnQgcnpnMmxfY3Bn
X3Jlc2V0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQo+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBpZCkgIHsNCj4gPiA+ICAgICAgIHN0cnVj
dCByemcybF9jcGdfcHJpdiAqcHJpdiA9IHJjZGV2X3RvX3ByaXYocmNkZXYpOw0KPiA+ID4gLSAg
ICAgY29uc3Qgc3RydWN0IHJ6ZzJsX2NwZ19pbmZvICppbmZvID0gcHJpdi0+aW5mbzsNCj4gPiA+
IC0gICAgIHVuc2lnbmVkIGludCByZWcgPSBpbmZvLT5yZXNldHNbaWRdLm9mZjsNCj4gPiA+IC0g
ICAgIHUzMiBkaXMgPSBCSVQoaW5mby0+cmVzZXRzW2lkXS5iaXQpOw0KPiA+ID4gLSAgICAgdTMy
IHdlID0gZGlzIDw8IDE2Ow0KPiA+ID4gKyAgICAgY29uc3Qgc3RydWN0IHJ6ZzJsX3Jlc2V0ICpy
ZXNldDsNCj4gPiA+ICsgICAgIHVuc2lnbmVkIGludCByZWc7DQo+ID4gPiArICAgICB1MzIgZGlz
LCB3ZTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIHJlc2V0ID0gcnpnMmxfZ2V0X3Jlc2V0X3B0cihw
cml2LCBpZCk7DQo+ID4gPiArICAgICBpZiAoIXJlc2V0KQ0KPiA+ID4gKyAgICAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIHJlZyA9IHJlc2V0LT5vZmY7DQo+
ID4gPiArICAgICBkaXMgPSBCSVQocmVzZXQtPmJpdCk7DQo+ID4gPiArICAgICB3ZSA9IGRpcyA8
PCAxNjsNCj4gPiA+DQo+ID4gPiAgICAgICBkZXZfZGJnKHJjZGV2LT5kZXYsICJyZXNldCBpZDol
bGQgb2Zmc2V0OjB4JXhcbiIsIGlkLA0KPiA+ID4gQ0xLX1JTVF9SKHJlZykpOw0KPiA+ID4NCj4g
PiA+IEBAIC03MDgsOSArNzMxLDE2IEBAIHN0YXRpYyBpbnQgcnpnMmxfY3BnX2Fzc2VydChzdHJ1
Y3QNCj4gPiA+IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCj4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBpZCkgIHsNCj4gPiA+ICAgICAgIHN0cnVjdCBy
emcybF9jcGdfcHJpdiAqcHJpdiA9IHJjZGV2X3RvX3ByaXYocmNkZXYpOw0KPiA+ID4gLSAgICAg
Y29uc3Qgc3RydWN0IHJ6ZzJsX2NwZ19pbmZvICppbmZvID0gcHJpdi0+aW5mbzsNCj4gPiA+IC0g
ICAgIHVuc2lnbmVkIGludCByZWcgPSBpbmZvLT5yZXNldHNbaWRdLm9mZjsNCj4gPiA+IC0gICAg
IHUzMiB2YWx1ZSA9IEJJVChpbmZvLT5yZXNldHNbaWRdLmJpdCkgPDwgMTY7DQo+ID4gPiArICAg
ICBjb25zdCBzdHJ1Y3QgcnpnMmxfcmVzZXQgKnJlc2V0Ow0KPiA+ID4gKyAgICAgdW5zaWduZWQg
aW50IHJlZzsNCj4gPiA+ICsgICAgIHUzMiB2YWx1ZTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIHJl
c2V0ID0gcnpnMmxfZ2V0X3Jlc2V0X3B0cihwcml2LCBpZCk7DQo+ID4gPiArICAgICBpZiAoIXJl
c2V0KQ0KPiA+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiA+ICsNCj4gPiA+
ICsgICAgIHJlZyA9IHJlc2V0LT5vZmY7DQo+ID4gPiArICAgICB2YWx1ZSA9IEJJVChyZXNldC0+
Yml0KSA8PCAxNjsNCj4gPiA+DQo+ID4gPiAgICAgICBkZXZfZGJnKHJjZGV2LT5kZXYsICJhc3Nl
cnQgaWQ6JWxkIG9mZnNldDoweCV4XG4iLCBpZCwNCj4gPiA+IENMS19SU1RfUihyZWcpKTsNCj4g
PiA+DQo+ID4gPiBAQCAtNzIyLDExICs3NTIsMTcgQEAgc3RhdGljIGludCByemcybF9jcGdfZGVh
c3NlcnQoc3RydWN0DQo+ID4gPiByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQo+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBpZCkgIHsNCj4gPiA+ICAg
ICAgIHN0cnVjdCByemcybF9jcGdfcHJpdiAqcHJpdiA9IHJjZGV2X3RvX3ByaXYocmNkZXYpOw0K
PiA+ID4gLSAgICAgY29uc3Qgc3RydWN0IHJ6ZzJsX2NwZ19pbmZvICppbmZvID0gcHJpdi0+aW5m
bzsNCj4gPiA+IC0gICAgIHVuc2lnbmVkIGludCByZWcgPSBpbmZvLT5yZXNldHNbaWRdLm9mZjsN
Cj4gPiA+IC0gICAgIHUzMiBkaXMgPSBCSVQoaW5mby0+cmVzZXRzW2lkXS5iaXQpOw0KPiA+ID4g
LSAgICAgdTMyIHZhbHVlID0gKGRpcyA8PCAxNikgfCBkaXM7DQo+ID4gPiArICAgICBjb25zdCBz
dHJ1Y3QgcnpnMmxfcmVzZXQgKnJlc2V0Ow0KPiA+ID4gKyAgICAgdW5zaWduZWQgaW50IHJlZzsN
Cj4gPiA+ICsgICAgIHUzMiBkaXMsIHZhbHVlOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgcmVzZXQg
PSByemcybF9nZXRfcmVzZXRfcHRyKHByaXYsIGlkKTsNCj4gPiA+ICsgICAgIGlmICghcmVzZXQp
DQo+ID4gPiArICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ID4NCj4gPiA+ICsgICAg
IHJlZyA9IHJlc2V0LT5vZmY7DQo+ID4gPiArICAgICBkaXMgPSBCSVQocmVzZXQtPmJpdCk7DQo+
ID4gPiArICAgICB2YWx1ZSA9IChkaXMgPDwgMTYpIHwgZGlzOw0KPiA+ID4gICAgICAgZGV2X2Ri
ZyhyY2Rldi0+ZGV2LCAiZGVhc3NlcnQgaWQ6JWxkIG9mZnNldDoweCV4XG4iLCBpZCwNCj4gPiA+
ICAgICAgICAgICAgICAgQ0xLX1JTVF9SKHJlZykpOw0KPiA+ID4NCj4gPiA+IEBAIC03MzgsOSAr
Nzc0LDE2IEBAIHN0YXRpYyBpbnQgcnpnMmxfY3BnX3N0YXR1cyhzdHJ1Y3QNCj4gPiA+IHJlc2V0
X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
dW5zaWduZWQgbG9uZyBpZCkgIHsNCj4gPiA+ICAgICAgIHN0cnVjdCByemcybF9jcGdfcHJpdiAq
cHJpdiA9IHJjZGV2X3RvX3ByaXYocmNkZXYpOw0KPiA+ID4gLSAgICAgY29uc3Qgc3RydWN0IHJ6
ZzJsX2NwZ19pbmZvICppbmZvID0gcHJpdi0+aW5mbzsNCj4gPiA+IC0gICAgIHVuc2lnbmVkIGlu
dCByZWcgPSBpbmZvLT5yZXNldHNbaWRdLm9mZjsNCj4gPiA+IC0gICAgIHUzMiBiaXRtYXNrID0g
QklUKGluZm8tPnJlc2V0c1tpZF0uYml0KTsNCj4gPiA+ICsgICAgIGNvbnN0IHN0cnVjdCByemcy
bF9yZXNldCAqcmVzZXQ7DQo+ID4gPiArICAgICB1bnNpZ25lZCBpbnQgcmVnOw0KPiA+ID4gKyAg
ICAgdTMyIGJpdG1hc2s7DQo+ID4gPiArDQo+ID4gPiArICAgICByZXNldCA9IHJ6ZzJsX2dldF9y
ZXNldF9wdHIocHJpdiwgaWQpOw0KPiA+ID4gKyAgICAgaWYgKCFyZXNldCkNCj4gPiA+ICsgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArDQo+ID4gPiArICAgICByZWcgPSByZXNl
dC0+b2ZmOw0KPiA+ID4gKyAgICAgYml0bWFzayA9IEJJVChyZXNldC0+Yml0KTsNCj4gPiA+DQo+
ID4gPiAgICAgICByZXR1cm4gIShyZWFkbChwcml2LT5iYXNlICsgQ0xLX01SU1RfUihyZWcpKSAm
IGJpdG1hc2spOyAgfSBAQA0KPiA+ID4gLQ0KPiA+ID4gNzU2LDEwICs3OTksMTEgQEAgc3RhdGlj
IGludCByemcybF9jcGdfcmVzZXRfeGxhdGUoc3RydWN0DQo+ID4gPiByZXNldF9jb250cm9sbGVy
X2RldiAqcmNkZXYsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qg
c3RydWN0IG9mX3BoYW5kbGVfYXJncw0KPiAqcmVzZXRfc3BlYykgIHsNCj4gPiA+ICAgICAgIHN0
cnVjdCByemcybF9jcGdfcHJpdiAqcHJpdiA9IHJjZGV2X3RvX3ByaXYocmNkZXYpOw0KPiA+ID4g
LSAgICAgY29uc3Qgc3RydWN0IHJ6ZzJsX2NwZ19pbmZvICppbmZvID0gcHJpdi0+aW5mbzsNCj4g
PiA+ICAgICAgIHVuc2lnbmVkIGludCBpZCA9IHJlc2V0X3NwZWMtPmFyZ3NbMF07DQo+ID4gPiAr
ICAgICBjb25zdCBzdHJ1Y3QgcnpnMmxfcmVzZXQgKnJlc2V0Ow0KPiA+ID4NCj4gPiA+IC0gICAg
IGlmIChpZCA+PSByY2Rldi0+bnJfcmVzZXRzIHx8ICFpbmZvLT5yZXNldHNbaWRdLm9mZikgew0K
PiA+ID4gKyAgICAgcmVzZXQgPSByemcybF9nZXRfcmVzZXRfcHRyKHByaXYsIGlkKTsNCj4gPiA+
ICsgICAgIGlmICghcmVzZXQpIHsNCj4gPiA+ICAgICAgICAgICAgICAgZGV2X2VycihyY2Rldi0+
ZGV2LCAiSW52YWxpZCByZXNldCBpbmRleCAldVxuIiwgaWQpOw0KPiA+ID4gICAgICAgICAgICAg
ICByZXR1cm4gLUVJTlZBTDsNCj4gPiA+ICAgICAgIH0NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2Nsay9yZW5lc2FzL3J6ZzJsLWNwZy5oDQo+ID4gPiBiL2RyaXZlcnMvY2xrL3JlbmVzYXMv
cnpnMmwtIGNwZy5oIGluZGV4IDkyYzg4ZjQyY2E3Zi4uYTk5ZjJiYTc4NjhmDQo+ID4gPiAxMDA2
NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvY2xrL3JlbmVzYXMvcnpnMmwtY3BnLmgNCj4gPiA+ICsr
KyBiL2RyaXZlcnMvY2xrL3JlbmVzYXMvcnpnMmwtY3BnLmgNCj4gPiA+IEBAIC0xNTIsMTIgKzE1
MiwxNCBAQCBzdHJ1Y3QgcnpnMmxfbW9kX2NsayB7DQo+ID4gPiAgICogQGJpdDogcmVzZXQgYml0
DQo+ID4gPiAgICovDQo+ID4gPiAgc3RydWN0IHJ6ZzJsX3Jlc2V0IHsNCj4gPiA+ICsgICAgIHVu
c2lnbmVkIGludCBpZDsNCj4gPg0KPiA+IE5vdyB5b3UgYXJlIGFkZGluZyA0IGJ5dGVzIHRvIGVh
Y2ggcmVzZXQgZW50cnkgaW4gdGhlIExVVC4NCj4gPg0KPiBBZ3JlZWQsIG9uIHRoZSBvdGhlciBo
YW5kIHdlIGFyZSBzYXZpbmcgc3BhY2Ugb24gdGhlIGVudHJpZXMgKGZvciBleGFtcGxlDQo+IG5v
dCBhbGwgdGhlIHJlc2V0IGVudHJpZXMgYXJlIGxpc3RlZCBpbiB0aGUgYXJyYXkgYW5kIHRoZSBh
cnJheSBsZW5ndGggd2lsbA0KPiBhbHdheXMgYmUgZXF1YWwgdG8gbGFzdCBpbmRleCkNCg0KTm90
IG5vdywgQnV0IGV2ZW50dWFsbHkgd2Ugd2lsbCBmaWxsIGFsbCB0aGUgcmVzZXRzLCB0aGF0IGlz
IHJlYXNvbiBpdCBpcyBkZWNsYXJlZCBpbiBoZWFkZXIgZmlsZS4NCg0KQ2hlZXJzLA0KQmlqdQ0K
DQoNCj4gPg0KPiA+ID4gICAgICAgdTE2IG9mZjsNCj4gPiA+ICAgICAgIHU4IGJpdDsNCj4gPiA+
ICB9Ow0KPiA+DQo+ID4gPg0KPiA+ID4gICNkZWZpbmUgREVGX1JTVChfaWQsIF9vZmYsIF9iaXQp
ICAgICBcDQo+ID4gPiAtICAgICBbX2lkXSA9IHsgXA0KPiA+ID4gKyAgICAgeyBcDQo+ID4gPiAr
ICAgICAgICAgICAgIC5pZCA9IChfaWQpLCBcDQo+ID4gPiAgICAgICAgICAgICAgIC5vZmYgPSAo
X29mZiksIFwNCj4gPiA+ICAgICAgICAgICAgICAgLmJpdCA9IChfYml0KSBcDQo+ID4gPiAgICAg
ICB9DQo+ID4gPiAtLQ0KPiA+ID4gMi4yNS4xDQo+ID4NCg==
