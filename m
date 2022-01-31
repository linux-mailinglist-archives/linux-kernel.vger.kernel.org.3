Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C729A4A3D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 06:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiAaFok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 00:44:40 -0500
Received: from mail-tycjpn01on2083.outbound.protection.outlook.com ([40.107.114.83]:10049
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229711AbiAaFoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 00:44:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgLFdCQziCYP1nNpcX/k6hCFRq6JVYDAXYLbLMeaBrkU+Vh5XFfjJpc+X788jOAX7ZG8HGR1QIaYrHcgUoDxUZ9N+/zQXkxYkepgWRyQ7Sf9mOx8ra1WftI7ps7YUXb8hX4N204h3vUD0iEw6345WV/QybyjqjFiZIZ2246wvBzsRXyLcNK0AbC38tPRgFuFIoFt2F/YcT6OB6zsxHgACcnqybtmEF7iJWggdE1qs43FGCzhgn6KNZiCj+Czf1SyjWyDNh9cW/ZsN22SzDy3shIEELWhBmfkdnpsnulFcOyZIv9FzTjNWb5EwSSMWtNVDGzigtQ60xVetVMhy+QApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgOxlxycBzOC3h93FGETXDR5znjVjYE/YHLJmYyGPrk=;
 b=JttSCJcbPs6Q1HfROUSkF+jBoaSiFhMGRj0iNTapZpy6HwMNAT13ToZvVxpeXuPAzdZTv5XrqlpWXxrX87q99y/4Uhlq4Gzt/ZGDgDaDiJ5CLjpwywaT+lfj66yxZasWc/WBBgnTFFoa8cBGnZheu1yZBXmrLo2xdwylDQ8L21S+d+V4B/VunqVdq1InbQTFlOEhvNgHO8aVY9ZaBBopvLJtj4eb7gryoW2XwnMXi9jzVSJf908MYA1QAtLLqd9fuD95Ac5feN0Lx3DBPvsxS4sEcurVOmb8oBwJlrK0P9KXyjNlc0vHonBpp5ZS2oGWUBoywDT03U8TBiMMqB152A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgOxlxycBzOC3h93FGETXDR5znjVjYE/YHLJmYyGPrk=;
 b=ReFuRvuPgJTsxmjD0xDsfc8/VJHCENFcZmVCO1DRWJy5xx6pgAKg8sTwNm3tD9h7Mtbr7FK7UHkcwXELAjowtuJ6XoWfnmhRp4lNLa96XSHhF1q3uFbGdA2YZPw76gDMeHOIVuAd2ZELHo6ypKJwyLp+oB7nLBO2iuTJYeD6kCU=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSZPR01MB6752.jpnprd01.prod.outlook.com (2603:1096:604:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 05:44:35 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b%3]) with mapi id 15.20.4930.019; Mon, 31 Jan 2022
 05:44:35 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hwpoison: Check the subpage, not the head page
Thread-Topic: [PATCH] mm/hwpoison: Check the subpage, not the head page
Thread-Index: AQHYFXkOJ10HyUvEFEaIagy3eAzxlqx8DUOAgAAEfYCAAI6LAA==
Date:   Mon, 31 Jan 2022 05:44:35 +0000
Message-ID: <20220131054432.GA856839@hori.linux.bs1.fc.nec.co.jp>
References: <20220130013042.1906881-1-willy@infradead.org>
 <dcfa1ee5-1512-5e49-92c2-4a33ab59080@google.com>
 <Yfb/rVg1HYHkKBgO@casper.infradead.org>
In-Reply-To: <Yfb/rVg1HYHkKBgO@casper.infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bba925ea-0d1c-42ff-9411-08d9e47cc3a2
x-ms-traffictypediagnostic: OSZPR01MB6752:EE_
x-microsoft-antispam-prvs: <OSZPR01MB675268B07153187B16384227E7259@OSZPR01MB6752.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: trNyqQkXb1mJRjui9Ev7fIRhibrikh0Btes3osZbyQcps65HDbPxBR+F8ajumSE3nNztRlc5r006C3cZXuzgTOI2AI0tpR8BImROaVT1Ikqt4ak407P5op0mPEXgLNihM5aQsQkMNRdpG210uHjk1FUej8edONihP4ubFetVIUFY0aQzkCOsKwQADuMbUm6sFPXw5//wfxF/aObHMRtNaU6p4LcxJgVzZA1DPkmOQqqicxUCAIN4juqde7XOzNW0sa9kCBcwYKp/lgHSUk0l5tqvV/N6J2tik5Us4kSFEotl7q7dvTWCV9tSLDFp+LADI9kTSPeMcViP2V1lCb0CHDlW/x9s6u5T01N8PBjck5fDV0HyVVxWnwrwWM/EpCWhMXVrHK9OZU14579oOHdJfYNX/co2b/HGfHzUQc/xcC65yctbhkxcEL0pbdQfuFIy9jnjmGXVXhxxS+zuOhuO05Sde1YEVMuaHLWmpyeGgbVsSY70VMH5XYaO0gjB51atJ6vqaXTD9fkgbgAsBXBntQz2rJTDK/AjjKOWbDHgYzt71WxNMcNKREp32GVbqnLdfoJtO49/+WXb1GNRkZGKvyLknF+r+Ksbi8Y+lZL7q6p5YoIGkZtrtmFKBN6glUm4CdBFmo35jpjQXTOwYi+dYhHlPCf16T6IUdwZZdyC7uIvOd6PMvnWbnS99ADAUGWB11G130aujTyW71PnF1tmqezinVraDMfvvUDejhl6vMCpZUropU8s5IRnj49OAOXp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(64756008)(66476007)(66556008)(66446008)(66946007)(8936002)(4326008)(76116006)(86362001)(8676002)(83380400001)(38100700002)(33656002)(26005)(186003)(6486002)(1076003)(6916009)(316002)(5660300002)(71200400001)(122000001)(54906003)(85182001)(55236004)(9686003)(6512007)(6506007)(2906002)(38070700005)(82960400001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWRud0Nnb04xNlRRaGpQd0RnY3d6ZS8yQmtOcFJYZTNBdUJHZ1owOTNyOGdI?=
 =?utf-8?B?elpHWFM4WXpZWGZHR1pmWlhUc0pJT1JPWWRXZmFGeXVLRGZEUFcrZ2JJaStV?=
 =?utf-8?B?Qk81SlpKUEdMSjBsTlBFVS85aytNZmpuWUFCcnJtZzROZWtCaXNadXQrT3Jm?=
 =?utf-8?B?YUwvY2ZBRkk3UDNMS05BeFdNeTRDRXg5MUJlZG1tVzdmbm1hYVc3QkNZcGpZ?=
 =?utf-8?B?cWdTTnB0Z3Z0OXRyNDJFNmtpaVlRbkNSRzk5b1VuK1RTUFpvUGcyQ01ybG1w?=
 =?utf-8?B?WmNLbWd3WFNQY1M1SDlZd01ueUF0MGN1Ym1Bc2lBUXZvcGdQQ0NvUEFienl1?=
 =?utf-8?B?T2VTYm8wRmJteXBDSm1oT0NkMU5nKzV3RWNEVHI1UVpaUmxTcEVEbmEwL0lL?=
 =?utf-8?B?YU9IUFFnUWc2bHdON2VvcFFmbTJCVm5ZK01ycWZiNDQ5MTJmcXU3N1ZxZW5m?=
 =?utf-8?B?dERQcWdiUUYyOUpNSlBqdnl2TzJ4TXhVTlh0emxYTFY0QnJmb1g4NDZDaTdC?=
 =?utf-8?B?ZmV2d0ViZzlSdVlDOS9NU0piazdSQ0tVOUFTU1BPKzV1dHQ3eXN5VWM0YWVt?=
 =?utf-8?B?UEtVVGZydGRKUlV5SUl0TDFmVUJyRUxGb1RTRGZwSHEvV25salpjbDdWVHpX?=
 =?utf-8?B?TGQrN1hlM0R3VXRHYy9maTkvQnlrMlNQWXFLc20zVW5rZ1RQYm5VY3ZaT3dt?=
 =?utf-8?B?alRhajRFVnV3RFNmOUNXQ2wxd3hvUWM2WmY5UlRLck1KZ2dJSlFLb3k0OGZN?=
 =?utf-8?B?WWg5ek1iZ3FYVElEdjBRVy91MHF2VWpBK1phNVB6SGdGZm5NdlEzY0NhSity?=
 =?utf-8?B?WnZuZHV2VVNmL2FCanJqQnVCVFFqV2E3dUlyVUNTaUo4bmdGeGdTRTZJVlBk?=
 =?utf-8?B?OGNPME1aYWMvdS9ZazJXYm92ZjdyaExGbmN2elBYdGVpaFdrUnpaTk91UlM0?=
 =?utf-8?B?R0VsRk1kcG9NUEdnaUxOKzdGc3Q2N3N5RjRIRklTUnd3MytkcUl5R0N5REZ0?=
 =?utf-8?B?TjEvTEZFTTRIczB1QUlUUTVxc1lrU3Vzc1U1SUROQXViRXg0NXRpa1JTUEVN?=
 =?utf-8?B?TmltdWJweXBmTXJKNzhnRm1kSEwvRCtNU1l0NHZoaGZOUElmaGRiaWJBYmhY?=
 =?utf-8?B?dzg2VG1IU085Y3o4RGVDVE4weTlSeEoyS3F3S1RmZXZhbm1OWFVyZU1kVDg0?=
 =?utf-8?B?eUNVNUxxUS9ZUUpRUDkwMWJjZWY4YlYxMThnWjVLOU1HSnBPZVFwNmpRQWM0?=
 =?utf-8?B?YjRXQk4vdEo1NnQ1cFdGT2ViWXZUUk0zakMybzlnNmV2SGQzQnA0MnJmYmJs?=
 =?utf-8?B?dmpJcndEMmU3ZDFHaFEya2pkbFdWQkV0cTJoV1VqQWJCQi9LTjVkckk2d01F?=
 =?utf-8?B?Q0pVLzNIMGJkUkxuZEdXWXgzNXphNzd6NW1vQWJmaENudy9SakhQZHkzd1BJ?=
 =?utf-8?B?TWc4UXVxbURkQVd5TnZDNVo3YWlVejJ0YVl0YVYvMlhyRnYzay9RQ05SeUdZ?=
 =?utf-8?B?RVJ2N3B5NVZQcXVXUERXWUVmUFlHWVhZUElkOVZ1VVJIQ013YTdMYmZWV2hm?=
 =?utf-8?B?eDBUNE9Ldy8xYk1yUkc5S09GTGNZVm1MdkVEWGJ3S0lvKzJZN1dsekg3dktD?=
 =?utf-8?B?OTAwUS9OQS9najAyUGVJVlUyMGt5UlMwUmRDT0kwT2FBQWhJdVMrWGxudWJV?=
 =?utf-8?B?UCtCZ3I4WThxM2JIWnl4Z1BhckZ2U2VDS05XZmVCOGVOT0YxVTY4MVlBSmh6?=
 =?utf-8?B?S3hrcGI4WEsrWkRKajFHZVc3Z1JQN2hDMG13aGtpUXVvUzd2UlcxM1FpU1RS?=
 =?utf-8?B?ajhZaVpBT20vT2FIdUVzelE0bHdia0FXUXpSdU5zOUs4T0sza2RRSmFUd1lX?=
 =?utf-8?B?aFlZMFVnN2ZPdTV0Qkg1dFJsZUlBd2RQWHFhMDNZYkx0NUpVbkdrZkJzSk1w?=
 =?utf-8?B?TFFHYlVPR2RyVHk2UFFZNEpyNDZCckwxd3F1Z2d1Zm43QUxhTW1tZFdDMit4?=
 =?utf-8?B?YSs5Y0RwS0diMFdLeXdOQUZBcWNRclBYZVF6UEZlNGVBdkRUZzBVQlJYWjJS?=
 =?utf-8?B?MU1xbnFsNVBCZWF6RnYyOEhMeUJkck1GWklnekFYWnFSQXlla1dXcG5FSzl5?=
 =?utf-8?B?dVpYQXovQVdsWTMrazE2eFdta0p6R2UxUFh3NjRocFd0d3JtVFBqOHlXQThm?=
 =?utf-8?Q?Ef8CJxsxbvpxz31qtfjzCK7EHns2ecREOpjoQzX4ZoJr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D99F4866B0D4BB4690F1B7D7EF978D79@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba925ea-0d1c-42ff-9411-08d9e47cc3a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 05:44:35.7988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylLqbfH3gFWPNQMcj5i8Fv9pJylUynRPn5s6Qjlorxw16Xh/PsWZwc+WQd02vi77hSdBGtX9+b1TfP0+y5kgow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6752
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBKYW4gMzAsIDIwMjIgYXQgMDk6MTQ6MjFQTSArMDAwMCwgTWF0dGhldyBXaWxjb3gg
d3JvdGU6DQo+IE9uIFN1biwgSmFuIDMwLCAyMDIyIGF0IDEyOjU4OjE3UE0gLTA4MDAsIERhdmlk
IFJpZW50amVzIHdyb3RlOg0KPiA+IE9uIFN1biwgMzAgSmFuIDIwMjIsIE1hdHRoZXcgV2lsY294
IChPcmFjbGUpIHdyb3RlOg0KPiA+IA0KPiA+ID4gSGFyZHdhcmUgcG9pc29uIGlzIHRyYWNrZWQg
b24gYSBwZXItcGFnZSBiYXNpcywgbm90IG9uIHRoZSBoZWFkIHBhZ2UuDQo+ID4gPiANCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IE1hdHRoZXcgV2lsY294IChPcmFjbGUpIDx3aWxseUBpbmZyYWRlYWQu
b3JnPg0KPiA+ID4gLS0tDQo+ID4gPiAgbW0vcm1hcC5jIHwgNCArKy0tDQo+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4g
ZGlmZiAtLWdpdCBhL21tL3JtYXAuYyBiL21tL3JtYXAuYw0KPiA+ID4gaW5kZXggNmExZThjN2Y2
MjEzLi4wOWIwODg4ODEyMGUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9tbS9ybWFwLmMNCj4gPiA+ICsr
KyBiL21tL3JtYXAuYw0KPiA+ID4gQEAgLTE1NTMsNyArMTU1Myw3IEBAIHN0YXRpYyBib29sIHRy
eV90b191bm1hcF9vbmUoc3RydWN0IHBhZ2UgKnBhZ2UsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
dm1hLA0KPiA+ID4gIAkJLyogVXBkYXRlIGhpZ2ggd2F0ZXJtYXJrIGJlZm9yZSB3ZSBsb3dlciBy
c3MgKi8NCj4gPiA+ICAJCXVwZGF0ZV9oaXdhdGVyX3JzcyhtbSk7DQo+ID4gPiAgDQo+ID4gPiAt
CQlpZiAoUGFnZUhXUG9pc29uKHBhZ2UpICYmICEoZmxhZ3MgJiBUVFVfSUdOT1JFX0hXUE9JU09O
KSkgew0KPiA+ID4gKwkJaWYgKFBhZ2VIV1BvaXNvbihzdWJwYWdlKSAmJiAhKGZsYWdzICYgVFRV
X0lHTk9SRV9IV1BPSVNPTikpIHsNCj4gPiA+ICAJCQlwdGV2YWwgPSBzd3BfZW50cnlfdG9fcHRl
KG1ha2VfaHdwb2lzb25fZW50cnkoc3VicGFnZSkpOw0KPiA+ID4gIAkJCWlmIChQYWdlSHVnZShw
YWdlKSkgew0KPiA+ID4gIAkJCQlodWdldGxiX2NvdW50X3N1Yihjb21wb3VuZF9ucihwYWdlKSwg
bW0pOw0KPiA+ID4gQEAgLTE4NzMsNyArMTg3Myw3IEBAIHN0YXRpYyBib29sIHRyeV90b19taWdy
YXRlX29uZShzdHJ1Y3QgcGFnZSAqcGFnZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsDQo+
ID4gPiAgCQkJICogbWVtb3J5IGFyZSBzdXBwb3J0ZWQuDQo+ID4gPiAgCQkJICovDQo+ID4gPiAg
CQkJc3VicGFnZSA9IHBhZ2U7DQo+ID4gPiAtCQl9IGVsc2UgaWYgKFBhZ2VIV1BvaXNvbihwYWdl
KSkgew0KPiA+ID4gKwkJfSBlbHNlIGlmIChQYWdlSFdQb2lzb24oc3VicGFnZSkpIHsNCj4gPiA+
ICAJCQlwdGV2YWwgPSBzd3BfZW50cnlfdG9fcHRlKG1ha2VfaHdwb2lzb25fZW50cnkoc3VicGFn
ZSkpOw0KPiA+ID4gIAkJCWlmIChQYWdlSHVnZShwYWdlKSkgew0KPiA+ID4gIAkJCQlodWdldGxi
X2NvdW50X3N1Yihjb21wb3VuZF9ucihwYWdlKSwgbW0pOw0KPiA+IA0KPiA+IFRoaXMgbG9va3Mg
Y29ycmVjdC4gIENvcnJlY3QgbWUgaWYgSSdtIHdyb25nIHRoYXQgdGhpcyBpcyBmb3IgY29uc2lz
dGVuY3kgDQo+ID4gYW5kIGNsZWFudXAgYW5kIHRoYXQgdGhlcmUgaXMgbm8gYnVnIGJlaW5nIGZp
eGVkIGJ5IHRoaXMsIGhvd2V2ZXIuDQo+IA0KPiBPaCwgbm8sIEkgdGhpbmsgdGhlcmUncyBhIHJl
YWwgYnVnIGhlcmUuICBJdCdzIGp1c3QgdGhhdCB3ZSdyZSBsb29raW5nDQo+IGF0IGFuIHVuY29t
bW9uICYgaGVuY2UgcmFyZWx5LXRlc3RlZCBzY2VuYXJpbyAtLSBhIG1lbW9yeSBmYXVsdCBpbiB0
aGUNCj4gbWlkZGxlIG9mIGEgVEhQIChpbiBtYWlubGluZTsgb2J2aW91c2x5IGl0J2xsIGJlIGEg
bGl0dGxlIG1vcmUgY29tbW9uDQo+IHdpdGggYXJiaXRyYXJ5IHNpemVkIGZvbGlvcykuICBJIGRv
bid0IGRvIEhXUG9pc29uIHRlc3RpbmcgbXlzZWxmLCBzbw0KPiB0aGlzIHdhcyBieSBpbnNwZWN0
aW9uIGFuZCBub3QgZnJvbSB0ZXN0aW5nLiAgQSBzY2VuYXJpbyB3aGVyZSB0aGluZ3MNCj4gd291
bGQgZ28gd3JvbmcgaXMgYSBtZW1vcnkgZXJyb3Igb24gYSBub24taGVhZC1wYWdlIHdvdWxkIGdv
IHVubm90aWNlZA0KPiB3aGVuIG1pZ3JhdGluZyBvciB1bm1hcHBpbmcuICBDb250cmFyaXdpc2Us
IGlmIHRoZXJlJ3MgYSBoYXJkd2FyZSBlcnJvcg0KPiBvbiBhIGhlYWQgcGFnZSwgYWxsIHRoZSBz
dWJwYWdlcyBnZXQgdHJlYXRlZCBhcyBwb2lzb25lZCwgZXZlbiB0aG91Z2gNCj4gdGhleSBzaG91
bGRuJ3QgYmUuDQoNClRoYW5rIHlvdSBmb3IgcmVwb3J0aW5nLiAgQXMgeW91IHBvaW50IG91dCwg
dGhlIGN1cnJlbnQgY2hlY2sgZG9lcyBub3QNCmhhbmRsZSB0aHAgcHJvcGVybHkuICBUaGUgcmVh
c29uIG9mIGNoZWNraW5nIGhlYWQgcGFnZSBoZXJlIGlzIHRvIGhhbmRsZQ0KaHdwb2lzb25lZCBo
dWdldGxiICh3aGljaCBoYXMgUEdfaHdwb2lzb24gb24gdGhlIGhlYWQgcGFnZSBldmVuIGlmIHRo
ZSBlcnJvcg0KaXMgb24gYW55IG9mIHRhaWwgcGFnZSkuICBTbyBJIHRoaW5rIHRoYXQgdGhlIHBy
b3BlciBmaXggaXMgdG8gYWRkIGEgaGVscGVyDQpmdW5jdGlvbiB0byBjaGVjayBwYWdlIHR5cGUg
KG5vcm1hbCwgdGhwLCBvciBodWdldGxiKSBhcyB3ZWxsIGFzIFBhZ2VIV1BvaXNvbi4NCg0KVGhh
bmtzLA0KTmFveWEgSG9yaWd1Y2hp
