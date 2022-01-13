Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A96248D274
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 07:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiAMGwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 01:52:18 -0500
Received: from mail-os0jpn01on2053.outbound.protection.outlook.com ([40.107.113.53]:40003
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230110AbiAMGwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 01:52:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qtm33q6IQqAdlLXOLoR/6+ztrQ6L1EULjXO5xQw3VSJluX2u7XCPdEqIPMSP51rQ/tvUn2tAdkL7tjpaOULxvZHHCLRwsSnQ2vM0oevOMZowK+KHl+1ltnDYpr8/Y/IRRXk8I/BSrkqa99pKFk7nMPZ6wXW6cQyfptcFDIttnL0F6bY3Sggg2ypwcHc3oUBV0ziyk3joNiUNeTkokTaHYbeYYd7Y5OaEZoGptmRIlOdrKE9hlMf9N2lm1XVfzyBMNKTzEWXChnvmMsMiv9TkNao0OKqrI30jfbIH9hlqwnURpTwvgme25eie66cnrRTTsxw2LXkhKbzglsamxIqT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEYCuoXL0RFRBIXzR/CEcR5NZ/imG1RGh64Jgozo5J8=;
 b=SgcRMTOSkhzEs/E049dGOi1mPIRayj/QQAu2Uv0C650FmHpCDTQZEkpwNcCw8yRrW4B/Fvk9v13WZkF67Re2xZHxVBQ4W2RgD9Oo7hIf+VYSss3HrhgqvhM6+QJO0B+vGniBPiU8L7MNjEFq4HHeMrsuu78GI+1so02i1ojGGHC2QH/tbZt/nHH77WXM9APihm86LhMA2JCl/IZJgSrNuHxqSL54NK6qSQ4ZPnXHYCkibIlxJzJgD3SXtaDE0SjCXZKTlmra+m5beh4oyFvK7dWxC0h9Gn3+ztD/sWamzFQitdfP8yCUb2mc0OvkKPJoPcgmo1w+JG+mec9T1bE+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEYCuoXL0RFRBIXzR/CEcR5NZ/imG1RGh64Jgozo5J8=;
 b=SHlYJmIvGq79Wm/mxWdMfYb1ePT7LDOYrOiU9XbyvMgdoaVQUa80iaez1E4GAJh76/LkpBtMS3b1c8MKX+2SrXz4NZrebONIX0jT6gO58xzp/y/5u/e8TdR6hoCfzjjzOYekmI65qf11n5eHEpQBRRLu3d4nJkxjua+4GT6Gi24=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYWPR01MB8791.jpnprd01.prod.outlook.com (2603:1096:400:16b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 06:52:15 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c50:c0ca:1256:1c07]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c50:c0ca:1256:1c07%4]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 06:52:15 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Youquan Song <youquan.song@intel.com>
Subject: Re: [PATCH] mm/hwpoison: Fix error page recovered but reported "not
 recovered"
Thread-Topic: [PATCH] mm/hwpoison: Fix error page recovered but reported "not
 recovered"
Thread-Index: AQHYA/8T45gLFHjYTEKkStvcjzS+D6xfUyOAgADnpoCAAFFmgA==
Date:   Thu, 13 Jan 2022 06:52:15 +0000
Message-ID: <20220113065211.GA2947732@hori.linux.bs1.fc.nec.co.jp>
References: <20220107194450.1687264-1-tony.luck@intel.com>
 <20220112121145.GA889650@u2004>
 <Yd+H00eSqZb+RsTv@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <Yd+H00eSqZb+RsTv@agluck-desk2.amr.corp.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c48ee48d-ad04-450c-b426-08d9d6613bea
x-ms-traffictypediagnostic: TYWPR01MB8791:EE_
x-microsoft-antispam-prvs: <TYWPR01MB8791449045521DBE9F0EDD07E7539@TYWPR01MB8791.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RrM2/t2OmZWsEVocjb90/hIGemmvmRyGJsKDNyg8DbojrQnC+2fg9GBMduBu7ibEpXHGc18gwdXTtPwIaT4W6Rgc0hOmZlLYu/nPB/biZ6gzCzUjyK1Y8lKeKFJwZXPwwOdmVKO0tR8gjxify37Q1DER/XRXiazdflw3DYxbUWdiXgk3pzCUqOiID9spRVmKs8WbBCZYVIJY1etmI84inZ9JJ5Sh7RLsPAIs+dnRbBRG1uoYd1HakVUB0gri6hCsbwqJ1p90eZvLW49fAJdBz6r2MA4n514JM3WIooum/1ZzxupD3pozdRnBxWtPahy+JFmQWsGrtbbwmdVEQ9XFW8UGlyyFH0z0LMv3O81gVpFRbH9rVeczDdJOqppQm+pEl2VV8WjVGYTdH+x7OJDwkPRmHlu6M+cQ/APtNefuz0cMDatO4/VDU8fA0AD32kU0ddNyjf3DOieD0HoJtbTunJhL9NwC+7Tlq92kVyQd2OHIXt6vQXmhJw0jwOB4421u6KH9NzyDMd2i/vIbunHZ0TDia8Mwx3MRFZTmJd/FbwbH+MNuvzW9Zf6o6RR0dX4HJMcLwqLccG+pZpdZjjHtVDs4vkqKgoRUSCQk1mINorigtz4jYpc6EQudh2seqzt/b2HV6FkT7sd0dllz5HGDr/GGwx3JNywC7vNrtzunwa3gt882671pz97R155/lKTHx5ZUbslTYbLOAAM/D7Q+Iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(6506007)(26005)(66446008)(6512007)(1076003)(6486002)(55236004)(85182001)(38070700005)(66556008)(66946007)(5660300002)(186003)(76116006)(64756008)(9686003)(316002)(83380400001)(82960400001)(8936002)(54906003)(122000001)(2906002)(86362001)(4326008)(71200400001)(508600001)(66476007)(38100700002)(8676002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTZ0c2V2enlPUEhuMjVtRkdlRkJvUTJISFJOdEs1ckhYVFU2Q24zSjhyUUtB?=
 =?utf-8?B?bjd0WjhrYWZ5dmJJaGM4MFFXZnVjQXp4TXMrYWhDdmRBNHJCZlJjbzFodEpL?=
 =?utf-8?B?VG1DMWtENGFQdHBWejJMRUZVZmFzb0haZjViWTZMWUZHUUZuck9STy9HMzBB?=
 =?utf-8?B?SmRoMGxjUHM0L3BqQzJQcVZxTFRRRHdKNHJqRjh6N2dRS3V2UkNBS3hhZU1q?=
 =?utf-8?B?c2xvVll1aXFDbkpxRktrODFXbm1jdmJJS1NqbWVwQjQ0YmtWcVF3K3JTTmtr?=
 =?utf-8?B?ZnBhRmFSOEhxOFlwQmpiOVdpYmpUQWl1UzZpN2kxWkhyT0E3WVhDRTBLSm9S?=
 =?utf-8?B?dVhPSmY2QUt3RWl0bVdRVytOVkhBV2lJbU0vU2JJcnhWbzI4ZEZ3bWhiWFdB?=
 =?utf-8?B?RTd5MU1raFVGS3ZmRy9kMWRNSTVwYjY3RS9pcnJoZkQvZEJtSHVscDhNd21t?=
 =?utf-8?B?c0hwTjBxc3o2c3EvYmlnNGllU0JwL3RUZHRkNDV1dDU1VzM5cEozSEU1U0JF?=
 =?utf-8?B?WWFuY2xEaW9tUzFTcmppUis5S2Z3NGIweDc2NGhzbE1OcjVrd3QxeVhPcVRs?=
 =?utf-8?B?QlVyTWFPbk1JQlBIdTJnRGFnamY5OXFodENsaVM1Um1yT0MwakZqWlYyN2E1?=
 =?utf-8?B?a2R2MDRtNy84UFpTVFF3V09XSlNGSm0rOGhZQThhaDlLdHJSQVpHck81WWhG?=
 =?utf-8?B?NThXbkl1c0JEQy9kekFCWEpIRTJJT0J3OG9OYms5SExaUWp5Z2s0UDhhNnR5?=
 =?utf-8?B?anRxbGZwVEptSkFlWGEySGpERFUrRjVISnN6RVBPK0lqQnJKMVFrNlk4dTRM?=
 =?utf-8?B?SUs5STMzcTN5NWJzaXFFd2Z2RTZ1MEdiVkxtRHFnSWEwRG9VdDdNa0gvMDhW?=
 =?utf-8?B?YTVOQVY0ZEwrZnR1ZzRCYlpjS1A2cStNNTV5ZXh4djhWZWttZjJVY2VoSHBH?=
 =?utf-8?B?S0FXRlJaSXV4d1NHWkxRSlN4WnpuK1ZUNDRpVk1OTmpHVng3MW56djltUDR3?=
 =?utf-8?B?cTJEek5mdEg0N3RXM2JLUkRXMEh0MUdtK0w4b21ZYmZoTENUQ25YMWhBU2VY?=
 =?utf-8?B?ZWFFZkNlSS9vdmdVd043OVA1cUkwK2pKempsWC9EQTl2UVlIVnpJVWZDSytN?=
 =?utf-8?B?aFZYaVNSamQ1MXgzSS9qRGNQTHBacmlHZzBJUUhWYVU3bXpEZWxRdEZYWmU4?=
 =?utf-8?B?Sk9CaDlkY2tUTjJpSlVFcXpmV0Eya1p1TjV6eXA1QjNnYVNEZE9hdldoZEUy?=
 =?utf-8?B?dkZ0NFU4TjR4MmJ3YlRwQ0JTcGF1TFdabVZSQm1sOTkxS2VGbkNSdUl0ZFVZ?=
 =?utf-8?B?RWtsdmRoR3NwSlZFb204TzVaUU5WUTdwMmRGUHJRUkgyZll1Y001NlBZNENi?=
 =?utf-8?B?cW0vaWpmaG1DMVhOVXRIbGZCVE9reURpbjJud2pVb3p0cXF6Q0Q0QUpPNjlN?=
 =?utf-8?B?MDRzVE1DV0Jibjh4SGFocWV4TnRpSTFSMzFUVVlwMDMyZlIxSm5HQkZvdnpQ?=
 =?utf-8?B?S0FHdGNqdlhPOW5YY3pwRVFsN3R6YnU4WjFueHhVME54QS9JYU8xeks5ajhl?=
 =?utf-8?B?ODd3MVI2QlcrZk9YZEJBb1dXcU5ITlpWQ0sxUFU1a3ExSDNmWkNLaHk1MGNH?=
 =?utf-8?B?dHpEdWN0UXVnTkZpY0ptc3lvdi9YUXFmekhnZlM3amkzaytIczNtaVRVbWdv?=
 =?utf-8?B?cHlXVUE5VEJNbXJ3dlZOVXh0RVNjdE5wQmtNVEpNVGRwMUlpNHlkNllhaHlE?=
 =?utf-8?B?VVZVUE1DdkRaK1Z3WTdmTnJNLzJQSDljRlVObGlrYkNlb0s3Q0ExUzRwQ2FI?=
 =?utf-8?B?T2ZtSEUwYXRXNlR5dkErYk5WV2JJT1VicUJCTEpoSGVIbUNiTU9wSW1uMTlx?=
 =?utf-8?B?dFdzZU4xWFhwK0lLdmowQ0RUUWNEcmg1bTNSVWN6R3VWbUY2RFdqNlgxQkdH?=
 =?utf-8?B?emFOVmhwaWVDWTZWNFJOWmZUd3JpVHFMMGpwa1lRL29yZWJkSE8xY0RMYjBJ?=
 =?utf-8?B?S0xjZ084U1pxTk1mTnI4OGg5b1BxaGlBdEdsRDMwMlRqTjlncWFjZHk1Z2dU?=
 =?utf-8?B?eS84R1dveFE3bmpvWlphZHY4aWJkSm1ycVg2SUFQMnNTbS93ODBON3VDZmVN?=
 =?utf-8?B?bVQyMkZFbFdhSHp5Wm44RmkzUGxTWlJxMndUdjQxeU40OHZJZG5EQzlyZGZo?=
 =?utf-8?Q?iBCk3jrkG/72O4Gsd1p0U3c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93D1412CA329674CB337D5C0436586F8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48ee48d-ad04-450c-b426-08d9d6613bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 06:52:15.4576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f185IqDAZB4N8rnIogHFX9+lGHQRSKfGW74rW5O8HI8CrgemuazMTsASyBoiai0ufXzx6UyPWF3QKphcTIhCng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8791
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKYW4gMTIsIDIwMjIgYXQgMDY6MDA6NTFQTSAtMDgwMCwgTHVjaywgVG9ueSB3cm90
ZToNCj4gT24gV2VkLCBKYW4gMTIsIDIwMjIgYXQgMDk6MTE6NDVQTSArMDkwMCwgTmFveWEgSG9y
aWd1Y2hpIHdyb3RlOg0KPiA+IE9uIEZyaSwgSmFuIDA3LCAyMDIyIGF0IDExOjQ0OjUwQU0gLTA4
MDAsIFRvbnkgTHVjayB3cm90ZToNCj4gPiA+IEZyb206IFlvdXF1YW4gU29uZyA8eW91cXVhbi5z
b25nQGludGVsLmNvbT4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS1mYWlsdXJlLmMg
Yi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ID4gaW5kZXggMTRhZTVjMThlNzc2Li40YzliZDFkMzcz
MDEgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+ICsrKyBiL21tL21l
bW9yeS1mYWlsdXJlLmMNCj4gPiBAQCAtNzA3LDggKzcwNywxMCBAQCBzdGF0aWMgaW50IGtpbGxf
YWNjZXNzaW5nX3Byb2Nlc3Moc3RydWN0IHRhc2tfc3RydWN0ICpwLCB1bnNpZ25lZCBsb25nIHBm
biwNCj4gPiAgCQkJICAgICAgKHZvaWQgKikmcHJpdik7DQo+ID4gIAlpZiAocmV0ID09IDEgJiYg
cHJpdi50ay5hZGRyKQ0KPiA+ICAJCWtpbGxfcHJvYygmcHJpdi50aywgcGZuLCBmbGFncyk7DQo+
ID4gKwllbHNlDQo+ID4gKwkJcmV0ID0gMDsNCj4gPiAgCW1tYXBfcmVhZF91bmxvY2socC0+bW0p
Ow0KPiA+IC0JcmV0dXJuIHJldCA/IC1FRkFVTFQgOiAtRUhXUE9JU09OOw0KPiA+ICsJcmV0dXJu
IHJldCA+IDAgPyAtRUhXUE9JU09OIDogLUVGQVVMVDsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgc3Rh
dGljIGNvbnN0IGNoYXIgKmFjdGlvbl9uYW1lW10gPSB7DQo+IA0KPiBZZXMuIFRoaXMgZml4ZXMg
dGhlIHByb2JsZW0gKGFuZCB5b3VyIGV4cGxhbmF0aW9uIGhlbHBlZA0KPiBtZSB1bmRlcnN0YW5k
IHRoaXMgY29kZSBiZXR0ZXIpLg0KPiANCg0KVGhhbmsgeW91IGZvciBjb25maXJtaW5nLiAgSSBq
dXN0IHNlbnQgdjIuDQoNCj4gRmVsbCBmcmVlIHRvIHRha2UgYW55IHdvcmRzIHlvdSBuZWVkIGZy
b20gdGhlIG9yaWdpbmFsIHBhdGNoDQo+IGNvbW1lbnQgYW5kIHN3aXRjaCB0bzoNCj4gDQo+IFJl
cG9ydGVkLWJ5OiBZb3VxdWFuIFNvbmcgPHlvdXF1YW4uc29uZ0BpbnRlbC5jb20+DQo+IA0KPiBU
aGFua3MgZm9yIGxvb2tpbmcgKGFuZCBmaXhpbmchKQ0KDQpZb3VyIHdlbGNvbWUgOikNCg0KLSBO
YW95YQ==
