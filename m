Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815EC4CCFE5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiCDI1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiCDI1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:27:17 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2085.outbound.protection.outlook.com [40.107.114.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D14618BA5F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:26:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2HWZJ9y/QrDUVpZhrb3tNP1eQes5xQxQmdq73ZA30ncbNCCrMO6ZwTOvnhA14hqAJoUFQbw/6FfYPmC5eSYGLjettrXc6axqf3RPj+S7NFfHu9J8v7/UEl6bRd+rE3hd3EbRQIzQtDoFxdX4rrgd3Ldmuex8fToZImh38UIX0PeHmu9aDmAlhdXLNaRc+XtjehsE5T6jF5KyIWVR4MOIhkvPpKpdOb3JeHfnO+Y6HINxJ/eyRs4D4SS+Gxewew0CXgOrlYrY/sTdlikR1dAwFnRrAgzLUrDaX6hiPSQLSY2FJeZViFeShYktpMPQWQZUk4Ze6UR0G5TjnZxSSOAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmO2EG69RAAT1xO2gC6+GsevdmsaJOX+JLA42C9TTFA=;
 b=TWju6pnFutfS/zwhYDwcTCAYPxMUVxiXpM9K6hs5vLB/YCqUNczAE3psT0yFA0QBJLaQ2ESMcNMFkVmNBxeG+I10WGwuo+5u5UUlAa0Dnx0XnMzqMD/q7YxoN8KCs26DcfTVHYUo05c6VB6tYSqltMPTrd/fDDLsLMuJ00TVv8WfA828kNRKpsoq+nMfnw3s6HAg+ea/7tr6chvUeOpCl1dv5Lb/yoJ/3LXPpobi0cMPob3Nru765DTM+zogPAg3jmPCahtuad7byWtlCkireT03eGSSXhyo3J3RHzaaAWxJIL7rusxM4dMrHBDaEFZfzF/O7L98w/+LI2LSdFJ/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmO2EG69RAAT1xO2gC6+GsevdmsaJOX+JLA42C9TTFA=;
 b=QubY6u0ngjXMAALvsmrsA0FkNF8imHlvT/tKhFKhqa3gGLejqv/c8xnJ8AoxRcAGp5VfeEmOk9nBedUr6k8Deh2wivr6PoGWMWgRBVwgBi0cHb98p8/su+/l8yM7ZRFxLwyj+jMJSXPjbo4Q7kkFAP/bOp5X+uHBWbD3/BvRVnw=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB3638.jpnprd01.prod.outlook.com (2603:1096:604:44::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 4 Mar
 2022 08:26:25 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::6565:8408:9726:83e]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::6565:8408:9726:83e%8]) with mapi id 15.20.5038.014; Fri, 4 Mar 2022
 08:26:25 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] mm/memory-failure.c: fix race with changing page
 compound again
Thread-Topic: [PATCH 1/4] mm/memory-failure.c: fix race with changing page
 compound again
Thread-Index: AQHYLKv/m9lQFb/m9ESDNV8aDBIe4ayu6bkA
Date:   Fri, 4 Mar 2022 08:26:25 +0000
Message-ID: <20220304082624.GA3778609@hori.linux.bs1.fc.nec.co.jp>
References: <20220228140245.24552-1-linmiaohe@huawei.com>
 <20220228140245.24552-2-linmiaohe@huawei.com>
In-Reply-To: <20220228140245.24552-2-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c19306e5-86b1-4ae3-c275-08d9fdb8ac48
x-ms-traffictypediagnostic: OSBPR01MB3638:EE_
x-microsoft-antispam-prvs: <OSBPR01MB363849CFF8968D9453867B0DE7059@OSBPR01MB3638.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i9+JYR+m76UrvXG9DdEwEMXcUcmDRF134JF3wzcoanYkuyYy32TmsMQRXTvNeUFrA5ctp9g1LFLgv7hdHDWGUVn4ZZcdTNBPsQxoyn8y54+jlvXESMm2CKFb8BY7AUPLfEGkhki82s9faBGyOf45JG0sDlOeGrQY6y6RjY8oShc72apMdrxjS/l7ZYSdJqwE1aAJzi3XrmKWFjb5B+ixEQzSaY2wrhKsTcVts7DxAmMDfkWDG2qHkIEMxUVNqE1/xch9h9+KHi4EFT56A69ypJ7rkKvpuzYTKMWG8lomMJ2N0yZtG/SmhE30DL8zRCxBHQWNYnMKkNA9m9Nn/tt0ibHlf4UsIBo4zcdBLREJST+GjbXbF5/naMBW45xpaAf1BteRN2VPW0TPtK1nz6+oGl/LDaRRG4HVrZh4GvWo3sXG7kIIZEOPzSBhsZ2cLybXgmmSTip7KvdwysZdj7aHZt+lkFjxktMjybxOzYM76DvpxTmM0MJ3KMPf+2+qG1isFhZjE8CbZKS0W6vuabVZCMJc5/CNLZ99vwHcq9o01YYvlx0e0xgeNNlglBLudYJgjDtMcfiGiU+DenGP/2hwL5slQuW6knfv1aJ24D4jN59YNFYAZ+V9NN9cLX/HhsANeU+uEckw/e0/uZVOZeuOsoPyfoXnKw8IprLTjrvNvgemdkRJVXYQsHVqeoWNuHm0UWZxZ+yyjiBVaVIDSEOQqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(38070700005)(82960400001)(186003)(2906002)(9686003)(6506007)(54906003)(508600001)(6512007)(33656002)(316002)(55236004)(6916009)(85182001)(6486002)(71200400001)(76116006)(66946007)(1076003)(64756008)(66476007)(66556008)(66446008)(86362001)(4326008)(26005)(8676002)(38100700002)(122000001)(8936002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUZWS3R5a2oyVTRWUEhjaUp1bERHd28yUytpYk5aQWNyOHFOdC9QcnRGZXdB?=
 =?utf-8?B?QmlGYUZwbW94QndlYmVSUk0xcVZtVFk0RksrWU1PY3A0SlpDYVV6cXQrWW9Q?=
 =?utf-8?B?U3RBSWpjbDBmU0ExOU9lODNNZG02alNrMHVSREJlSmZoYi91eGJsUnNVY3hj?=
 =?utf-8?B?UmVQdURPVnk5ZkZKeGFPOHQvckwxYm1mQnRQNXo3OEhJZm9FM20yVFF4MDI0?=
 =?utf-8?B?T2J4NXp0QncwWVJSbWEvT2FsTEMwUUZvVzB4bWx6NXB6ZTVFWGJxREprMGlx?=
 =?utf-8?B?TmN0WmdBVjNSbytaR0gyTjYzNk5JdnNmQVhWMXdUZWxFVWdQVXp1MVNkMjZQ?=
 =?utf-8?B?SlpHOEgrcm80STBCd2wzQitqa3BzMG01RzdscDFGakV0dmV5a1h1YVBaOGhC?=
 =?utf-8?B?WXdNTzUxa0NpL0VnbTlEM3RMVDZ4cllLZnZiYm5xQXF2Z1VOMVFaYlNBL1lF?=
 =?utf-8?B?WklYMzdJZ1QwSTFpUldGTjRRYmJNQWpuNnFuS05Oc1dMUkVaN1FPRjh3NGJz?=
 =?utf-8?B?Wk5VOUQxSTNTSDJ1ZzE1VTZSemNibnFieGRReDdIeGRERjFDckc0SVlpTE92?=
 =?utf-8?B?b0ZjbmtQM3o0ZEZQT3lvVlhaWVF0cytFN1VIdHpXckx1M1ZDRGZQWExqWjRK?=
 =?utf-8?B?OUd5YUJxRWpxN1VWWGpMeEhFNEtZMHFTWElzaGc1UHlWeFhlQm8yK3IzVkJI?=
 =?utf-8?B?VHl4K0RsdXppZUlRbmhHeDREMFk4Z29JTXlidW42UVF0SjdwZUtZY3pSSU1B?=
 =?utf-8?B?ZktHQjgrNlYweXRNbjRsUWx6QXNDLzNDQmMzd3Z2b1BsaGRqVFhQWnA4NFRz?=
 =?utf-8?B?eHowQmpGYS9ETllocUlnVjhTa2RiOE9tT3R4WU01ZkpQUm8rdEJxaHhISzBZ?=
 =?utf-8?B?b1pDUURyN054YXFKUnRWWW4wVGxDeWhsL0FJbXYwWUlxeVhuSnpGT0lZUkQ5?=
 =?utf-8?B?QWM4aXJOTVIvcGNwY0hLcDVUZzFQSzkxV0FKM1h0anhNa0hOdzl0MmpUZVlJ?=
 =?utf-8?B?ZWV4cDdVU1lNT3lLbk5OdU93Qlluc3UvUVFoUXdrNC83Q2h5YWZZNVpHU0di?=
 =?utf-8?B?RzV4SEZUcU5uelIzVFdWeFllTXZLT1hPc1h3dDNCTGNYSVFYYk8rbExRc28z?=
 =?utf-8?B?ZlA2TjV2R2F2ZTlOTFRTQlVzamhFdFlPTzdFSy9hcWQzVGJmVmN1WWpRWEc0?=
 =?utf-8?B?VzVUS2JPaDBVOCtRcFBHY0F0Z0dRYjVDYlVmTUpkQmhxKzZhVlRjTDJUYUw3?=
 =?utf-8?B?TVY0NG5YdTZHdTFDNk1Ba0VTM2tWVmhzZVBLVXhlYWVROE82WUppSzQ4Ny8z?=
 =?utf-8?B?WnQ4QzRpbTZCOUtXUjJhdk5XRlRTUDF2Y0c0NDQyVldaOVFGaE82RE1QcnRj?=
 =?utf-8?B?UjltL2FxbEtYUFJQYU9WamdrcFd0OGtjTTJOd3dTVFhXazlxNFlZcUovYlh3?=
 =?utf-8?B?b3o0cm52elJIS1pHcDlhb2M4UTdVeTF2enQwTDVZdjBTd3hOMjg0ZEVPOU9B?=
 =?utf-8?B?eGs5TmRGcDFrRlpUNVl5enk5cmdEdXdCVkpkTFZPMlBuSHhBUlNYUlVNMXN5?=
 =?utf-8?B?MFdaWXViaW82L2tEODlNZzEwWDlEbTRnVTROa0FSQnJTMXg3OG5uMjg5MW1R?=
 =?utf-8?B?R21lUk9qV2dBU2srVVlZaVlQTzlUY2MwNEcyMGthV2FaZXp2b0lTTW93YjAz?=
 =?utf-8?B?TW9CMEdVc29qTHc5MEZZL2lJL0E2aU40WU9kUkFkOEhOK0luMnh4aDBXdEQ3?=
 =?utf-8?B?anpobXYwc09DOWQ4L01jUTBlNzVteEQ5YlptSVBKNUhjWWQ0VUtVV2V4b1R5?=
 =?utf-8?B?UVc3cnpORCs2ekRYY2h1bGxwTVdXWVBPc2tId1JXSi9neHVrVUdPT2FIamph?=
 =?utf-8?B?b0pMeGREMEk0KzlUNUJTY2RCUHdTSFlRNkIzWFU3OVE0T2lIOTcvdStwSyt2?=
 =?utf-8?B?VEdRV2NsbnNZUnhJK2I5Y2s2T1Ixb01zNFJJaHlVVEQ3RjNvUGFyczhJUCtK?=
 =?utf-8?B?KzFqWXN3Z2FzblVkL1ZoZzRHcFNxbnluSFBscThuTGthd29WM2NBLzZaL2p2?=
 =?utf-8?B?dWFLaUx1dVJIbVArNWRPVFAwUjNHdjZ4b3FRYzkwU05FN1lrREJDUklIVEI4?=
 =?utf-8?B?UzNsQjlka0o2U3N0M2ZldmNYZitxTGpESHNEVjRNak1qTVNmZjJKc0h6eSts?=
 =?utf-8?Q?ZVHczFPM//V8dHvc8NnbWCkaaGFYtOtvlqCtDq9vGBaB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5193FA7F278DC94EA172717EFF2DF1BD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19306e5-86b1-4ae3-c275-08d9fdb8ac48
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 08:26:25.5426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41HGttVmFYbnA8P55qAsSrmBUkXnkSUxIOTyB0ULKvK5WpgpdQV6eBu3PskT6ZtbxH9jZwNgf4OC6PyF03CdLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3638
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBGZWIgMjgsIDIwMjIgYXQgMTA6MDI6NDJQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gVGhlcmUgaXMgYSByYWNlIHdpbmRvdyB3aGVyZSB3ZSBnb3QgdGhlIGNvbXBvdW5kX2hl
YWQsIHRoZSBodWdldGxiIHBhZ2UNCj4gY291bGQgYmUgZnJlZWQgdG8gYnVkZHksIG9yIGV2ZW4g
Y2hhbmdlZCB0byBhbm90aGVyIGNvbXBvdW5kIHBhZ2UganVzdA0KPiBiZWZvcmUgd2UgdHJ5IHRv
IGdldCBod3BvaXNvbiBwYWdlLiBJZiB0aGlzIGhhcHBlbnMsIGp1c3QgYmFpbCBvdXQuDQoNCkkg
dGhpbmsgdGhhdCB3aGVuIHNvbWUgaHVnZXRsYiBwYWdlIGlzIGFib3V0IHRvIGNoYW5nZSBpbnRv
IG90aGVyIHR5cGUvc2l6ZQ0Kb2YgY29tcG91bmQgcGFnZSwgaXQgaGFzIHRvIGdvIHRocm91Z2gg
YnVkZHkgYWxsb2NhdG9yIGJlY2F1c2UgaHVnZXRsYiBwYWdlcw0KYXJlIG1haW50YWluZWQgaW4g
c2VwYXJhdGUgbWVtb3J5IGFsbG9jYXRvciBhbmQgdGhleSBuZXZlciBjaGFuZ2UgaW50byBvdGhl
cg0Kbm9ybWFsIHN0YXRlIGRpcmVjdGx5LiAgbWVtb3J5X2ZhaWx1cmVfaHVnZXRsYigpIHRha2Vz
IHJlZmNvdW50IGJlZm9yZQ0KbG9ja19wYWdlKCksIHNvIHRoZSBodWdldGxiIHBhZ2Ugc2VlbXMg
bm90IGNoYW5nZSBiZXR3ZWVuIGdldF9od3BvaXNvbl9wYWdlKCkNCmFuZCBsb2NrX3BhZ2UoKS4g
U28gaXQgdGhpcyBuZXcgY2hlY2sgcmVhbGx5IG5lY2Vzc2FyeT8NCg0KVGhhbmtzLA0KTmFveWEg
SG9yaWd1Y2hpDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pYW9oZSBMaW4gPGxpbm1pYW9oZUBo
dWF3ZWkuY29tPg0KPiAtLS0NCj4gIG1tL21lbW9yeS1mYWlsdXJlLmMgfCAxMSArKysrKysrKysr
Kw0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9tbS9tZW1vcnktZmFpbHVyZS5jIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiBpbmRleCA1NDQ0
YThlZjQ4NjcuLjBkN2M1ODM0MGE5OCAxMDA2NDQNCj4gLS0tIGEvbW0vbWVtb3J5LWZhaWx1cmUu
Yw0KPiArKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+IEBAIC0xNTM0LDYgKzE1MzQsMTcgQEAg
c3RhdGljIGludCBtZW1vcnlfZmFpbHVyZV9odWdldGxiKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQg
ZmxhZ3MpDQo+ICAJfQ0KPiAgDQo+ICAJbG9ja19wYWdlKGhlYWQpOw0KPiArDQo+ICsJLyoqDQo+
ICsJICogVGhlIHBhZ2UgY291bGQgaGF2ZSBjaGFuZ2VkIGNvbXBvdW5kIHBhZ2VzIGR1ZSB0byBy
YWNlIHdpbmRvdy4NCj4gKwkgKiBJZiB0aGlzIGhhcHBlbnMganVzdCBiYWlsIG91dC4NCj4gKwkg
Ki8NCj4gKwlpZiAoIVBhZ2VIdWdlKHApIHx8IGNvbXBvdW5kX2hlYWQocCkgIT0gaGVhZCkgew0K
PiArCQlhY3Rpb25fcmVzdWx0KHBmbiwgTUZfTVNHX0RJRkZFUkVOVF9DT01QT1VORCwgTUZfSUdO
T1JFRCk7DQo+ICsJCXJlcyA9IC1FQlVTWTsNCj4gKwkJZ290byBvdXQ7DQo+ICsJfQ0KPiArDQo+
ICAJcGFnZV9mbGFncyA9IGhlYWQtPmZsYWdzOw0KPiAgDQo+ICAJaWYgKGh3cG9pc29uX2ZpbHRl
cihwKSkgew0KPiAtLSANCj4gMi4yMy4w
