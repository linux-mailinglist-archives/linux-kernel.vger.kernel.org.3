Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B1154218A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiFHCRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352590AbiFHBtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 21:49:09 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2056.outbound.protection.outlook.com [40.107.113.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72DC12DBDB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blxFegx4JmUIhur9cZn4iiRFrgn40J0h5CBGbQBw+Ga+bXxuUYwLxPQ9aofK5SRq/PJ3839QCdAIXPTHd7Ls6ZKuvWAatAm/gNJvI77aTZwDr9t/7YRhZy2DXGdyTvRGmudL5RAFLcDlL9FLJ4b+TDrgjxWv+Gu+kaoAGovGAFDebEf7cL9/zgPHslMlJTtTb/UOUaJ0l+yO8htf6iif8P023/Azb9I5fuK6z0fvfeVC9V3+gBjHhXaNt9lbSaUZ6UR5fF1oqdUJdb2Edp+JjbuJsLa37qagdbXvS+GvfEz3uz09jfaurBz5S2P6HQUC7USQWij9ohYwj5tQXToXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjyx5XXdzf/kB2bhE5f4ngg3x+h3QW4I45XkwrHA7x8=;
 b=n0tMnrGiBaURuqQlNNB/iypFSXDQfBHrfEvNQ5whHfB5m64WuIHXt3x3nr/Ixm7a+Y9F/LwMCP76xtTM1JYFiiSFNn7P4C2pxbau+LbIvegVIhH08f4nbanozi+lPDVs1WQY9654MNnRFKyzQYjs50nGWMN9rA2UdGtbyLoRWFXQStKTUn2I8Gw32OgPeZ1+SHPo95BqEFShuIMXyQ2OuSaQiQ9R58+e4Vmnvee+4jW0FY9h7eeznOycJ0dhjpSqBK6jtJR9eGiOU7CRK/OXTWuYKTBF/7MPYYq8hYiRnWjXPN/imkPBuStc8eOTzlWEDReYTCxmssYAEOep0INCwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjyx5XXdzf/kB2bhE5f4ngg3x+h3QW4I45XkwrHA7x8=;
 b=KW9fHGcyQYmPU5zj/XDqsU+e1xAgUhWQUbh/JK5cBnCtHMflanfCnE8CXrdYWYLyjZrMpid+Peny/PuOZ0PpirvWAloGm2MslUTbmAH9JIscz4Wli2lCIUydlX8R3344fYZL1eikwNBknVWv2sQc/yOxrZJj7bUNLgbcBHP+Wn0=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYAPR01MB5263.jpnprd01.prod.outlook.com (2603:1096:404:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 22:42:10 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995%2]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 22:42:10 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add myself as a memory-failure reviewer
Thread-Topic: [PATCH] MAINTAINERS: add myself as a memory-failure reviewer
Thread-Index: AQHYen4YN/7nURNaD0+cUE3DAfCV0a1EiqkA
Date:   Tue, 7 Jun 2022 22:42:10 +0000
Message-ID: <20220607224210.GA1400450@hori.linux.bs1.fc.nec.co.jp>
References: <20220607145135.38670-1-linmiaohe@huawei.com>
In-Reply-To: <20220607145135.38670-1-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2595d85-cb97-4d09-acbb-08da48d6f5b3
x-ms-traffictypediagnostic: TYAPR01MB5263:EE_
x-microsoft-antispam-prvs: <TYAPR01MB5263447148C52B034F22ECD3E7A59@TYAPR01MB5263.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EjUp6pIqci4s/qaHj0gb0/MjoY187wkQDbv3HwtcrUEaQxL2AeQLXukR9b/xWVR9kKdNSiZSt6jl2SrWKx1k3Ei9t/lSK1BVn3rFtQ9/PONn50sVe7emCNRbe2ldu4NeMI5Fp4VwbXGmJyp4KHIcR2hvhAqnH2z4q8z2cFWC0qiFdsyxNy41oqbavDlAB0IepOwSi5/imcK1PRlynhjbHtY4gI4txDlaqz4bnPF79EuU3sp+MztIBy5wZTslZB9ArUck2r9+7BhYIQMTMDL4MF6yMK6CIiMNh2R31VesxqSkmVuL86ljlXayxLtsFiD1b4WaQvPHsF5RR6WrapSniayOdbGhaCy6zZZQOnN8MslFAJNrkGtSV0FQ/uGeEx1CMPpI/2vDDERw0kN51RENVOu+kUaqGUHPf3IBoPatSnoWM89NPqcZr5qbJP2uKAbgIQcc/jneoQbLrlfRy7U0ph5eDl1l848KBYmig/a+bgiUM1XRbQHNsQbceyKqVwE6JlRnn3nOgDRPCFcpFVp/7vmP5mw9LwldXMT6yUFkb1OhvCHqRHfyiEZupLiqcOu5FoTs1Rz3VacFmPxMRlnjfc0+Ms1uyrkQoxhDA59slrkfxZ00wYk5hNngv+C25PrnaiA0Z0KKi8ULnQlPPWOHmQoa7IvWskouwVE63u58oYPXmMnWLO5p9L4XYC87whVMY5VLQSMvKp9iZ0O1koyfaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(186003)(66946007)(6512007)(55236004)(1076003)(316002)(83380400001)(38100700002)(508600001)(8936002)(71200400001)(33656002)(86362001)(82960400001)(26005)(9686003)(122000001)(85182001)(66446008)(38070700005)(64756008)(5660300002)(6486002)(76116006)(2906002)(8676002)(54906003)(4326008)(66476007)(66556008)(6916009)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M05FeWlqOCtCVFpCanNPdWJ2dTJiVGNkV2ZDTGhuc3Zjcm50U1FSbkRrUkVj?=
 =?utf-8?B?aDk3ZGUxWmZWSjhGTjRGQUR0b3B0VTlRUVkyVWtCMTROM3NjdFVMdWFzcnJU?=
 =?utf-8?B?RTVNL1JTU1M1QWNYc1oySENxbVJaRUU4cHl4bWtNRHIwdytnNWVlV0VFVnJU?=
 =?utf-8?B?Mm1SdnlTaUJUMktweVMzZDU2SkhYdTFxTWIxZXAwSytlbzcwRUZObWgrL0NN?=
 =?utf-8?B?TnVLSjlNZGxGTEhzb1pWVnhoazJRWUtOQWw3d0xIYkdTcHdtSCs3NS91OVp5?=
 =?utf-8?B?d3lxUFlWQW4zQ1BURjFHTTI0WUZnbGx3NUFCUG54azE2Z2d3ZitjNFZUTlVp?=
 =?utf-8?B?MGpPNGszUzF3cWl1M1R3MDNTY0ZpRlVoWmF4dVNpclkwRDl4L2txTEtWZkZJ?=
 =?utf-8?B?TlhITjhpU3Q5TnhXRTdSYTFBRlp5Rk1aa3hiaW9HaUcvL0l6TzBYd0VOMTVy?=
 =?utf-8?B?M240MVErQkRDVm5jYytWZWcvdmd2Qi9iU1ZualNBd0Rvbi9Fdm03aCsvL0FY?=
 =?utf-8?B?Zk05Ry9YYkVJd3hiMEQ5TmhZVFYzd3d6MnE0WWJMWGNYL2NEcDRkQ0l5WjhC?=
 =?utf-8?B?OTllODFvSzR4Y1U4M2E2anhHZTN4SFJLY0NId3cyaDRsUmN6c3NvUVdvUEFp?=
 =?utf-8?B?SFY5V3haL3J4WnRkWjR6U3JjRzdVWW5saFRsWDBNdWJLVFUvR25BZ1FVY0JK?=
 =?utf-8?B?OVJCK2duQXZNR1h4Q0lkbGhEeTRXRFNaRW9lR2FLRE12SDJJQjlQY1hxeXh2?=
 =?utf-8?B?U1EwWGZhRmdkUTYyVjNsem9GR1U2aldPak1aUWM5Zit5NTVNbTZHckU5Ykpp?=
 =?utf-8?B?VnVKRzUwQmh5cTZmaVFENytZaXVrTy82eDdidDkxOUc2Q083YVd5ZnJFYnd4?=
 =?utf-8?B?d00rSHpTd2gyWmRCZlcrQVJ4Ukpja3hwU1JLMUpsNlZnOHpvZFJOYk9pS1Rz?=
 =?utf-8?B?b0NqSSt6a1ozdjJUa1oyU1pDYWlFRW5IbjdjSFhJajhrZys3L3kwVzdnUC92?=
 =?utf-8?B?VjQ5cDlZUE9YTWo5MnZ2VnRWblQvYkJYM2MycktSLzQyQnlwT0Q1OVd2U1da?=
 =?utf-8?B?QjhrWkdIMWJkMTFUbnNIdGZLWHVuUzh6WXhyaDFpbU00eTdaY3l6ZEZYMmIx?=
 =?utf-8?B?YlRTbnE5aC9PSDg1dndYY01Ucmp4eC91eWczZSsxYjFCUlZmMTlqMmVzWHk4?=
 =?utf-8?B?b2EvWnNOcnlmcjdKMVp6cXltQ1g1aTFoWUtVeDNxbnpYWnlydW5LNkFsMjN0?=
 =?utf-8?B?bnBWU25pazJKYm9FN0wrdi96c295MWdKeHowc3RhM0VKWkdzNU1VUHJnRCtI?=
 =?utf-8?B?RHhxQ0dqTW1qMTFkNzR3UWFsRXZiaEVEVXhxd1FpWHlyMDc3RVNvMjJPVzY0?=
 =?utf-8?B?S0c5eno4dDR3M04ya0RkbHFjd09wMGg0eGhXbHJhSVFQNlgvOTk4SWdMVURO?=
 =?utf-8?B?N2YzQnNESllCeVM5TFFIc280VTZnd0NuWWkrV3lMc1RWVGN5YXBrZDBYdkhL?=
 =?utf-8?B?NE9DdlNFY1UwSm43UFNCSjhmMGlNL0xVOFZJSXhka2RFZXc0dzh1bWQvSEUx?=
 =?utf-8?B?VUI4NUYxVXVqL0lMM1hIeFFLamc1SWxRaXg1ckFIWk44Nng2aTM2bzJTSGZK?=
 =?utf-8?B?cnlTc255MVp6ZFZOcGllQmZjaDF4Rlp3U2plY1lvbml5cGJSYStQcGdWZVEv?=
 =?utf-8?B?WXpva21xT1NTbjA1Y1RpemJGWXprS3N6U2Y3Q2FNaEZ3dGFzcEdOQlg5NnRo?=
 =?utf-8?B?WktNRkplWDF6bkJ4bkd3dUhXd0FHcjYyMEgxR3Q1aWt2d3lSYXZhZ05jSXlp?=
 =?utf-8?B?Y0xOZkdzUmZOcEIyVVU1QXA4NHpPbmlYTE1KaWJXa0w0dFdERWo3QWVqZXVP?=
 =?utf-8?B?NjlBOVQ0NnJmd0RSMmtBaXYvd20yZktQM0pCVlp5WDRxdzdJK0swbXA3UTZ1?=
 =?utf-8?B?bDRmakYzb29BQW9VeE5iek1tVFVCS3NPdzZUYWE2cUFWU0lHK3VoSFVSckhI?=
 =?utf-8?B?NFZwSE13SjREMHlzREVNYnQwWE5QV2ErMGM3ZDlrQ0Y0MVd3Z3ROazFkMnZE?=
 =?utf-8?B?UzNxc0crOWRJQSsvL1IzM0h4dUpZWDlZTVNxMkZtRitkcDBiWnI5c3lCRjFy?=
 =?utf-8?B?U1Mza0Vja2ptb2o1ZjgzZ3h2OWx2elFRYWxTUDI4aFVyNkcwMy9tb0FsQ0Fj?=
 =?utf-8?B?b0UrOXAweXBpVjNDNVNnUU9YRUExNlFMYXJEUFlTK0wxb3paUU1JTU05SVFv?=
 =?utf-8?B?Y0NPUVNmOVorbytDZ3k0R3lRV2dGSExnQUcwRHlDRjVmRmEvcmFNTlpjU2Qr?=
 =?utf-8?B?NlYvNE9HWkRqZGlBVnB6ZWs2dG1KYVV2UWNkL09taWFUa0l5SXpxWWh4Sk55?=
 =?utf-8?Q?T+Kw7VhlDOSgFmM0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E6F9697E6524A4384CB7B069CD0096E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2595d85-cb97-4d09-acbb-08da48d6f5b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 22:42:10.8271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NARxk4+Hw890I3EonmiL9UL8P0soqa46A3+vj1qgEzcMBsVcjFFoyJ1sFsSuw8JojEEpbAHhhPQkkIwuga4+SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5263
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMDcsIDIwMjIgYXQgMTA6NTE6MzVQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gSSBoYXZlIGJlZW4gZm9jdXNpbmcgb24gbW0gZm9yIHRoZSBwYXN0IHR3byB5ZWFycy4g
ZS5nLiBmaXhpbmcgYnVncywNCj4gY2xlYW5pbmcgdXAgdGhlIGNvZGUgYW5kIHJldmlld2luZy4g
SSB3b3VsZCBsaWtlIHRvIGhlbHAgbWFpbnRhaW5lcnMNCj4gYW5kIHBlb3BsZSB3b3JraW5nIG9u
IG1lbW9yeS1mYWlsdXJlIGJ5IHJldmlld2luZyB0aGVpciB3b3JrLg0KPiANCj4gTGV0IG1lIGJl
IENjJ2Qgb24gcGF0Y2hlcyByZWxhdGVkIHRvIG1lbW9yeS1mYWlsdXJlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+DQoNClRoYW5rIHlvdSBm
b3IgcmFpc2luZyBhIGhhbmQsIHRoaXMgaXMgcmVhbGx5IG5pY2UuDQoNCkFja2VkLWJ5OiBOYW95
YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KDQo+IC0tLQ0KPiAgTUFJTlRB
SU5FUlMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggNmU0YWQ0NTBiZjNj
Li42NDMwYWViZmUyOTYgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5U
QUlORVJTDQo+IEBAIC05MTM2LDYgKzkxMzYsNyBAQCBGOglkcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L3N0L3N0aS9odmENCj4gIA0KPiAgSFdQT0lTT04gTUVNT1JZIEZBSUxVUkUgSEFORExJTkcNCj4g
IE06CU5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQo+ICtSOglNaWFv
aGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCj4gIEw6CWxpbnV4LW1tQGt2YWNrLm9yZw0K
PiAgUzoJTWFpbnRhaW5lZA0KPiAgRjoJbW0vaHdwb2lzb24taW5qZWN0LmMNCj4gLS0gDQo+IDIu
MjMuMA==
