Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1F6475667
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241684AbhLOKaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:30:10 -0500
Received: from mail-os0jpn01on2121.outbound.protection.outlook.com ([40.107.113.121]:35906
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241681AbhLOKaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:30:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih5aWrBfeER5ypt6yBcj1u1q6k8q3b5c5KuE0NQa4gcvo/43TLUMHHGsitZS5qdJoCvgFqRjmX63r2zk0dja+6RLAaP2exsZE1KfrFNsyHrbcVwobpE006pHVemcFPgxI/ElZlW9pjK66ZhMLdwSximK8BYkYz2FzSYmbNNvclJAeC8Hr/32cIEM44l+q2Mg8gKUbcERAUWfHv1f+LVrR4TI/Gm72HNMNXppqfcKSU3g+SYeo8QFbFb9BRjdv5KUF7L0kv3rc8nBEi4UstrZeJXJC0y+Lfup6hV1hLsAtTGIJQcAoCwrhQC5zJ+JIvZo3d96gTdpUqPicRj4nyIKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c01g0lxyDZW9R/PD5bQOjt+/63pzkK89Q9sLqqUwxOU=;
 b=b6W1VOf4IVj+ngY2N4sgpXQyLLkOwhj+pC4uz56OaPaJwrQal36o6664KJGBwks1ntCr0v0BPNJrgh4EsasVde2vSnSO63WfrpFSm8old6apOhP3MOFOdkgE5l11F26UuoOFyIf+ltBOzqQEGIH9o22hMbbJUpy8nQXdj1iz4NH0I2t7MatEFjj16PkkjM3RVfcefBbtbB/7PWsLH2+OFguT7sDtGUlfqpZlePTlUnJtuo3f4/4s0hXMx7nf3mLggzIVj9SL2vaWoIf2KG3AsZJ4O6ziD6WnQNHFzx5tcj2tG2ayVJietvD9lq7rQpSZcnVj+YU98U9jPCzh3duCfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c01g0lxyDZW9R/PD5bQOjt+/63pzkK89Q9sLqqUwxOU=;
 b=BVLrwN0eQwa9yywTQwEsQtulkIURBDdlHCpSI1iEd1z+QkerqSk/aSz3eEKx3gUdd+ZUZiybD6XqpeMj6T3OktOWU14ewMeK9Ar1OI97czPhkLwx/UD3pyOow6c+O/OnqGo9oIbAcgDO6J2o08XH1c3c+WUrWDSFPtL8GEfsvCU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB4022.jpnprd01.prod.outlook.com (2603:1096:604:46::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Wed, 15 Dec
 2021 10:30:04 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c0bd:405a:cdd3:f153]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c0bd:405a:cdd3:f153%8]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 10:30:04 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] reset: renesas: Check return value of
 reset_control_deassert()
Thread-Topic: [PATCH] reset: renesas: Check return value of
 reset_control_deassert()
Thread-Index: AQHX8Z4pYQJBmgMI/E63+jA2z5sYeawzWfnQ
Date:   Wed, 15 Dec 2021 10:30:04 +0000
Message-ID: <OS0PR01MB592247BCE3298FA97D0A2AAC86769@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <b2131908-0110-006b-862f-080517f3e2d8@gmail.com>
In-Reply-To: <b2131908-0110-006b-862f-080517f3e2d8@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40ac4533-f9ed-4d9b-da61-08d9bfb5db84
x-ms-traffictypediagnostic: OSBPR01MB4022:EE_
x-microsoft-antispam-prvs: <OSBPR01MB40223E3B2F2011CD7E7DF24986769@OSBPR01MB4022.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kzppJOwVtJABZnD392vxDXbxSezAeQsHXrq45M9nm8C4BrWPieYhhy/wMeIlOQejsXdgNoL43jtvKzDMXT1pzE6yn1Pq0stdH7NWM4lmYwXT2kpfmuMeBJKkexkgab81dVWa/9zUNtdycGGCG7c37pTUL/uolBWgdCxUv3/Yue6eHyPXL/O0Dl7A2UR5QytYi4Ib6C4IhirLBdWMa2n+ZXmy9UDxZUhYE1y1dLVNmOpGhk5Qas1wR6qnrsxlLOo0zDYanOh8PWmNhF2rnu4tBs92eB/jsGjfBII7zX4acDP9nztBV/LnJ3zct3g1HoqVtSayDKZ/XkZSo0H3RH2ud2RpHfGk1I2njz+WqgtlqCqj4LIj5M0T3ukrSk2JiZA8Bw3xCncJX41aVX7YvwWyuNW6//1FUG5hJNVUl3bwUOE2QcojXZ1wD04Uj7B7n4OIuCguZfrR5Lgtf06pXkwG+JnAjO3out9UAO88Kq/8BcZFVnyRZPWyMpO4NhDI9lN9tBy5WNgfX0+MjEoF/hq6tUOlfa4uMaid/HKVxSGSWyWpgcKsOi7cd8sr5EQVCcfvh++n7noxpoGgjYHBDPUPhPqoURRw/fLTr7y9wGAbzF5VHoKQ1OgkO7dgs1iQyQubIWa7HQoYW0csn9O43mQy4VPRl0F4am5db41sg5KDPLkVUQwSiE7RdmPXtVtblCC/zYwxSMK2bt3VOlSKoftCfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(86362001)(186003)(83380400001)(122000001)(38100700002)(7696005)(26005)(8676002)(66476007)(66446008)(5660300002)(4326008)(55016003)(38070700005)(33656002)(8936002)(508600001)(76116006)(2906002)(71200400001)(110136005)(52536014)(64756008)(66556008)(316002)(66946007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzQyNXFickxnemRBVkxpUGJKUWgweGNJemRzNFhUWGNaVmlxcS9IMW9pQWNZ?=
 =?utf-8?B?Mm9LS1lqNDRLUytDckZuaGcrMzJ6UEtuS2tFbnA0L2lTZkQ5aXZacSt3eXNm?=
 =?utf-8?B?eUJXTmlFTExKZlR0eFo1SDVZRlBvekhRVHhkMUs5dWJlcXJhSjlGdUduTGZV?=
 =?utf-8?B?VUViZTdtSy9RQ1BVbVR6MDYrQWJEc29pRktnVHFGRS9UMWsvdjFsS2RyNktH?=
 =?utf-8?B?U2N3bmFxbE13UVpReThRaVg4cnRDOFVMUUhOSm1qYXE4amozVm53VWRxdE9H?=
 =?utf-8?B?YVR0dHk5YndPM0luS3IwcTJreEd5NkxKQVUxbFJGZWRoaER6K3FybVFjSFhO?=
 =?utf-8?B?Zm1DYVdrQlM5WWFtVU9qYzUvbThCOUsxWDhXbEtFbEZSV1lFZVAwVm0zb1Ew?=
 =?utf-8?B?VmtBZDVxeFZvQ0ZFL2c4b2ZIOG9jMkJYUnVzVlNkNFMyWWd0QXRhb0dXNzl1?=
 =?utf-8?B?RVRyM1Ixa2E0cGVjdjR6NXIwMElsMEpwUjhQWmhBUTFvZXhGYnBYSjNwaFQ4?=
 =?utf-8?B?a2ZUUFprVVJtdjQ3dDZzTUx3ZHY3WndzVWcyVUZ1N3BGNUNmdUpBbENiSWNS?=
 =?utf-8?B?VWJIdkZxR2pEdXJqREFBSkE2djlaVGc2OGVpWlVDNjhEMEFMZy9EUk9OQ1hZ?=
 =?utf-8?B?bnVRUFJWTmtVRUlPMExmZU5ZS01jWDMvTTgxSHgvcmpOaTlERTdTZ2hkK2dG?=
 =?utf-8?B?NExqbXJZR1lFK0tsbWtrdk5GcVRUQ0M0b0VMYkExOHZlTGgybWtKV2RySkp6?=
 =?utf-8?B?SnUydktSYUxSRzdWVzNNN04wbzZKOVQ2WkJ1NFVJZ3l0L2U3dkJRZ2xnZTlh?=
 =?utf-8?B?SDRGbFVVZVB5Y1grQk1qWk5zRFNDeDkyeGRSTXF2Wm1ZOU9ub1ZzeGppRXd5?=
 =?utf-8?B?Rm5aT1Qxa1NMZDZSdVpHdDRqYzU5MjBXNFMrV1lKN3JZeWpTTVVncGNVdlVt?=
 =?utf-8?B?TFF0d0JRYnIrWHNzczJhSzg0QmRKc2gxbmJMaGdZQ0ZKMkpub0ltUitabGgz?=
 =?utf-8?B?bWxSa3c4STF6b2ZzQU1xQnJBSW5YNmJOaEhYYVE0ZWFhUE1uMVc2Rit0YW8w?=
 =?utf-8?B?NjM1RUNOWElWZHpMM3hhb0RDRzR3eS95c2F1ZG43ZFRBWElVQTJ2Tk9mdEFs?=
 =?utf-8?B?em5DK1o1VDFOeUZuYmxmMTZ2UWtaa0d3N0Q5VUtWa2tWNk1FTUpUTkhKNVIw?=
 =?utf-8?B?Qy96Sk1zR0EybEV3aFhmMGxITi9pSHk2Yzk2ZU9VZWJ0VmdxblpSaC95NUVE?=
 =?utf-8?B?dzZONG1nYjVHakVialphWVV1ei9GeEhSeHA5YUYrcG9tZ2VlMlVnb0VNVVdV?=
 =?utf-8?B?M2hoY3A1eU1GUlUwdm9VdGJTVWVYRDE4STBDMDVvMkZoV2RObzRzRlVZc2U5?=
 =?utf-8?B?L3dic2Uwakd6MUFndEZIYjJrUzdCdGJQTW9uK3RnTXBmaEpHbkp4eTljVGZV?=
 =?utf-8?B?aVZBYkwwamd1bGE4bFNEK01iUUlnUkl4TXUvclRVNGM4RndRS0NHQVlKMFhp?=
 =?utf-8?B?Y0JXRkY0NDRPVFV3cXpNMk1SanFiUDB4L0xUWGpjTVpsNHNOTHg2dUNuTmVq?=
 =?utf-8?B?dzZGdU9iMHRaMzZkMDV0b1NTWTVreTNUYzZnSlVlZnduMTNpaFZsS05tVUdI?=
 =?utf-8?B?WkI4SFZ5Uys3M2ZyL1ArY2Q5UGhCT2l2ZWdVRmpZK3EwRldlbXd3ZnNNZFN3?=
 =?utf-8?B?ZXRVK1hNczZ5ZFEyd1N0RWlyT0lwR3hEUlZGaE1qbG1uL3g4WEpwRkp2WEFj?=
 =?utf-8?B?QTBUZjR2dzlVbk56UGh3R21EeWF2NGNzblg0VjVWd2dzRnFncXJrWmhhc3pX?=
 =?utf-8?B?dkR1YklMNGovdmFlZlpObWJDNWpWakN2akNJQU1ralF0Rm93eVRDT0VGemQz?=
 =?utf-8?B?RXBYRm5HeFhVd0NLMVlrR2ZhYk5aM2hDZEF1eGk1c05LeTZFNVdjYnZ3eWp0?=
 =?utf-8?B?aFFyVmxXUFozeEQvNGxzb0g3ZDh3VWtiRm90WWZxN2pJeEYwZ04vRjJtRUtu?=
 =?utf-8?B?SFF1Rmd1S3pVU251alZtUFhiR1VrS0xRQllyMUVXL0ppT3ZBUSt0VnMrOGxy?=
 =?utf-8?B?RzRvRVZOSWtCVCtnVXhhNnR5NGVuVjBKdkVudWdpRW9sdnJDMHdsTlZyZXlV?=
 =?utf-8?B?cmtyWi9sZGJ1UU1YSFJzVlFkeWE0ZVNzSHFwWjhFZUlBRWNBUnJxd2Vnc1J5?=
 =?utf-8?B?VXpNWmFaUUJzNTRqUk96TmdQZXIrZEhYanJQVm0wd0NGdzI1SkdNRGNuVkht?=
 =?utf-8?B?RDJ4eHQ2LytGalJuNnAxaDVHOU5nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ac4533-f9ed-4d9b-da61-08d9bfb5db84
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 10:30:04.2120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gdZWkQ5qRxsB/iUve+EdWsyQZsGp1NK9YHfENJNrGfCAoXXL8YHKie+jXboKR/PyT59iALDzN7CLXN5YnOXubQwT7ph1hDly2Ww6nvQkw44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4022
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBIZWluZXIsDQoNClRoYW5rcyBmb3IgdGhlIHBhdGNoDQoNCj4gU3ViamVjdDogW1BBVENI
XSByZXNldDogcmVuZXNhczogQ2hlY2sgcmV0dXJuIHZhbHVlIG9mDQo+IHJlc2V0X2NvbnRyb2xf
ZGVhc3NlcnQoKQ0KPiANCj4gRGVhc3NlcnRpbmcgdGhlIHJlc2V0IGlzIHZpdGFsLCB0aGVyZWZv
cmUgYmFpbCBvdXQgaW4gY2FzZSBvZiBlcnJvci4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogQmlqdSBE
YXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIZWluZXIg
S2FsbHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogQmlqdSBEYXMg
PGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KDQpDaGVlcnMsDQpCaWp1DQoNCj4gLS0tDQo+
ICBkcml2ZXJzL3Jlc2V0L3Jlc2V0LXJ6ZzJsLXVzYnBoeS1jdHJsLmMgfCA0ICsrKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3Jlc2V0L3Jlc2V0LXJ6ZzJsLXVzYnBoeS1jdHJsLmMNCj4gYi9kcml2
ZXJzL3Jlc2V0L3Jlc2V0LXJ6ZzJsLXVzYnBoeS1jdHJsLmMNCj4gaW5kZXggMWU4MzE1MDM4Li5h
OGRkZTQ2MDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtcnpnMmwtdXNicGh5
LWN0cmwuYw0KPiArKysgYi9kcml2ZXJzL3Jlc2V0L3Jlc2V0LXJ6ZzJsLXVzYnBoeS1jdHJsLmMN
Cj4gQEAgLTEyMSw3ICsxMjEsOSBAQCBzdGF0aWMgaW50IHJ6ZzJsX3VzYnBoeV9jdHJsX3Byb2Jl
KHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCXJldHVybiBkZXZfZXJyX3By
b2JlKGRldiwgUFRSX0VSUihwcml2LT5yc3RjKSwNCj4gIAkJCQkgICAgICJmYWlsZWQgdG8gZ2V0
IHJlc2V0XG4iKTsNCj4gDQo+IC0JcmVzZXRfY29udHJvbF9kZWFzc2VydChwcml2LT5yc3RjKTsN
Cj4gKwllcnJvciA9IHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQocHJpdi0+cnN0Yyk7DQo+ICsJaWYg
KGVycm9yKQ0KPiArCQlyZXR1cm4gZXJyb3I7DQo+IA0KPiAgCXByaXYtPnJjZGV2Lm9wcyA9ICZy
emcybF91c2JwaHlfY3RybF9yZXNldF9vcHM7DQo+ICAJcHJpdi0+cmNkZXYub2ZfcmVzZXRfbl9j
ZWxscyA9IDE7DQo+IC0tDQo+IDIuMzQuMQ0KDQo=
