Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78EE4BAF19
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 02:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiBRBOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 20:14:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiBRBOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:14:10 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2046.outbound.protection.outlook.com [40.107.114.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A59115E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:13:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmyocmW8kUlDUB5nSFb0tGl+rcwroKcQqP1IoWtrGzW8/n86jVay+q7aPrj1YL1MoIaOH6b7PPc+/aFOXXbfeGLxDH1pA7bmYH5JrMzUDqF4yWgjl2D+LPUNzdOae8zwwq+EQDE8l8+MPopDJsGYbsTe4I5hrHC2ZudOhJt3PvLz4KS+Je0wI6D4x1Mj4l1kDlL+9/Tcz9EpMFviPbfaM1zLhpWcaF/4w5ZiIPbTc8ClvXj6Je1RB3wzWQqP26beqLYixH20ZQ23i31Fl6KNeF8K6yj40H52Tuvp4eGxpKEnZzQM9wVfHZj8Xa2kUfusBkgJsF6rH50nCjkO+tIx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQlJtQJg2v03+pyTgJ9oS6ongpWwF7IGiFtGEHXiQZw=;
 b=fU3TYo8ENDDKySZ3vOicWaay9+5oHW3s5036WkTw9MGq/nV5P70pGl97JzCYW3a0jKIL3Mv+rWbv/Ebnt2ohBu1QFZgtHVyHnywSbB2K276b/x+TaX447uc0g/4EkD3ywGx8DSTH3PMWGElHS72ZlsvHU8EqWbQ8r0d4Jd2xChs4iM8cbG8QLQQbMbPO2f953E8UsDotUzDTDJoFcPTx4L4JxxiS/6FUf/rKXliHGav4bhyTcqC+NGvyQ81q8iSyeN5QjnXozcMMnWw1wBd2o48eOl7rE9YkqGxt/BTQrO1r942XIMnispwc0mrRGTp0Cb54XbKwcuVs40ULhrbUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQlJtQJg2v03+pyTgJ9oS6ongpWwF7IGiFtGEHXiQZw=;
 b=ayTBFxaRIxfy0h25kAyF0hcZuZfv3AkjQJ90Bi2YGo6ckqkL9c0YtACGwv5D1uKCBMHBPUBCwsjnzT7b16zEXtzqll+PbXKlJx+fhYhaX9ZB1gzTc3eRAKhHgEFG8XOb7i6BxsxeobcNN1WWwXox39gaQRmEd+bE9PY7Q73GvQ8=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB8061.jpnprd01.prod.outlook.com (2603:1096:400:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 01:13:52 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b%4]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 01:13:52 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/8] mm/memory-failure.c: fix race with changing page
 more robustly
Thread-Topic: [PATCH v2 4/8] mm/memory-failure.c: fix race with changing page
 more robustly
Thread-Index: AQHYIxW8pgTqba8cB0mzvCCcra18l6yYg2iA
Date:   Fri, 18 Feb 2022 01:13:52 +0000
Message-ID: <20220218011351.GA2941369@hori.linux.bs1.fc.nec.co.jp>
References: <20220216091431.39406-1-linmiaohe@huawei.com>
 <20220216091431.39406-5-linmiaohe@huawei.com>
In-Reply-To: <20220216091431.39406-5-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83fc2698-f89e-43f3-aad4-08d9f27bed3e
x-ms-traffictypediagnostic: TYCPR01MB8061:EE_
x-microsoft-antispam-prvs: <TYCPR01MB80617AC2B38AECE4F7E94133E7379@TYCPR01MB8061.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n9GDmb4Aw0bV4u5g0HCA+X/MiKq/AxR1c8lqQWv5LNowD7MRervmcKoYu6+fGtQq1vowRSBEXLVJtr0wjWdmd5HfO7MCi9Ay7BBjjIRtF5q6GJlgsw7fEyd9dNzcU/axyxw5XLIAxS+dnubi1obZewB+ApExcCSa8SmmBmpdh93G2ZZ3+sRpASvwP0BKAst/7NKsuOTEuw95HhMYiJujChk884rSVYNVAgerwrwdcCpXtYHG/HVceHbO0oQVqaDC+FcduCqeilH+8b2pm6SKquDDvVR4UknJZ+Fqm3VkWp/CBXtVhpnPycPdU0y2iCZLizaFAIr1Elxw6gDskT6pmhnr6lRymTDbNEhk/y9svjYYoPTXjQCMqH4hJ4zmB0TQN0u+H5rQQncP/XjvReoc9hvAxvgIiIjvczAqiuZYZ8nWBVJsMaXsiz/6GfH7O9s9shhQGD49Yf/PQVCEuZtHvgUmlr5mgJXAk5Pvt/g9WRCClVBvlh2+6PXUEC7R71SrYjBnmLsE+mgP7kIpHRWQA6j4U3gD2xDoF6U1mWjI7RpgnLJQK2A0h2KpDYO9EbXOgQmjEIsyAiZ8nlg4NfAsZUHBloALf4tPbpohaTjRPiB4pGbr5ffyGiXDoYW6bI0wW7sETZn4XPLWmuI4WTqgvqLrCkbYi2fsZMQLZyjD3qEt7wBs8PXdTSkCUJCoy7dvaTwqA+7lw51+Chw61HStYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(9686003)(6512007)(2906002)(86362001)(5660300002)(316002)(508600001)(186003)(26005)(38070700005)(55236004)(6506007)(71200400001)(1076003)(83380400001)(38100700002)(122000001)(82960400001)(8676002)(66556008)(4326008)(66446008)(64756008)(54906003)(85182001)(66476007)(33656002)(6916009)(76116006)(6486002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3VCa1VTVHQzaWdhS2RET0N4cGQ0cmRSMG5mNHF4b1dNK1ZPcUNoZlgwQ3RO?=
 =?utf-8?B?ODh6UzloWnFpSVozZ28wYUxkVWRjSkQxbmtwWWx3N1hSWDVLZUpOd2FMRi85?=
 =?utf-8?B?clNqK1dhQmtVbkVvK2djL1Yzd0hOdnJkL3dvcUpIY2FJMUp3QXR4N3hrei9I?=
 =?utf-8?B?M0RMMzFxcFJOTG51bUI3bGdoM1JpSUFkeE5nYjZSTVhZc2xmR28wK3RrM0p0?=
 =?utf-8?B?aXBrUDQzVG0vZTRoeWtYL09tcm81eHZ1L1htSldYVkR3Smh1dmx4clNvYjNI?=
 =?utf-8?B?N2NiUmFFYktJbFlleEowaytQbXpFY2p6YktGOVVaRjFqSVJLNnZObTZhRVZ0?=
 =?utf-8?B?ZXlPOUx5RFBGOW5Qc2x4b3FzUzkrWWhMVHBvVUZEZ3ZOVlRoYnlXejRHUC9R?=
 =?utf-8?B?MklxdlQvOUdXNHF2V2V5RG90WmFHbDZHQUNBN1BYYTE5Q3RRVUJKR0xyUmtB?=
 =?utf-8?B?S3pvQm4wYlBEN0FOdGZ5SE0yQzlWUXBGeHdMcXhkanNwS3gvbTNSRDdHaUR4?=
 =?utf-8?B?akNhRWVXaEVQS0d2ODRNMnc2MGI3eEhCTzNyVFI1Q3FISXBKZTdjaERsTThy?=
 =?utf-8?B?dVhiY0VwN2E1TEIwWlpkUHpjQy9rQ0dOaFZ4RG9BaHVQN2tMUTVDd1dUMnB6?=
 =?utf-8?B?aUlPSm1MMGxucUhyTS9HMXB6ektER0tQR0dYY1lhRzBCQkx6OFp6MmY2UDFw?=
 =?utf-8?B?SjNlSXR2ckEwWHNQQlR4Q0tVNDNmV0luNVlpZ1hZV2VoaWVaZ3ZVbTNybkhC?=
 =?utf-8?B?Sk05c2k4YkxIU2JlRGRob1k4c2tDNVBjbjRWcnVwa0lBdEJUc3hNcE5lM20r?=
 =?utf-8?B?YTk0dXhNOE9Pd0MzMXg4OWhTaXAvMWVmWUY3K3F5aDNLcUhzTEJ3NkJmNVJ1?=
 =?utf-8?B?ZGRheVFNL0ZQQllXZHdsK09RTC9mRFJPQXlvQnpsMTIwWUErQm1YdkNyU1pE?=
 =?utf-8?B?Tnk2Z2ZCRXB1UmI2MXIzLzVWajZmbjR4ZU44M1M5SkZUbDR1K3lMSlArbE54?=
 =?utf-8?B?aGMrRE9sc2xQRnR6Wk50WEQrKzRTNnR4Zm4zdXd6QUNsRjNQU1lndGxYYWF6?=
 =?utf-8?B?dDhkcVBwaWhpSHZkOXZraUxVa2t0YzgzWm1BK2RYZk01WEorM1J4YWh1RHhU?=
 =?utf-8?B?K3JUQ2owOXhqVkV0SUJIc2VXMXBmZ1VFK1duS3BENTBZaHJLUExFMmFSQUlL?=
 =?utf-8?B?MWFuWWdWRmpQRFNkRkZTdVVZck1qOW1ndE1IYXVGUEQwK1FCSU5Mdk5Qd09y?=
 =?utf-8?B?RlBrcEJBd0UyNVlOeUxYcTZjVDdKT0xXR3JYOEpKZkFrbnpaSGVLeGJ5Rng3?=
 =?utf-8?B?QWY5YTRxYmJ4djhtMUpUUVZmbDU2QnEvakIramRZbnhhL1NtUVJLWEZITzlw?=
 =?utf-8?B?WjExWkVtV2srOVU0QVpZcEhGLy9oYnVFVHpzTThPU1FZUnF2amZ2Q0FHMWpO?=
 =?utf-8?B?a2hsV0k4UisxT0VCdWkwTStaRUZKSWNsRW5TTllZanpISnVLQTRsOUI3d1JJ?=
 =?utf-8?B?aVl2N1lhaGFnTktxRE5uUytDN1pOSWdTSXRNbXVPOExFdXU0ZFg2UDVMS3dS?=
 =?utf-8?B?cXNBY0hhc3crMmQ0aE1lb25uVTkvRE8vY1cweXB1bCtFWWJvVnNMS1Znbmw1?=
 =?utf-8?B?ZkF6MkEyTklhSHo1dmxqeEdPanlvU0lBazRCQmtDeVJsSW1mSE10cnFMaXIw?=
 =?utf-8?B?VmtXOFMzcFU2OFNIeGtRVUdSTTRHd3ZjMVpZb294bDVEZVlyZU4yUTN2MEU5?=
 =?utf-8?B?RU83YWIrcmtTRUdFWlNRbE1ZS1hZaUxRV3pRaHliKzg1UjhPWFF3dXFlcmsv?=
 =?utf-8?B?ZWNXQU1KSUZrVnpIV1p3Nm9sMEUvWXo3a0ZlL2llRjAyT0p0UjB6MXhYTHRF?=
 =?utf-8?B?NmRjaGhZeEZGM1FWUVFQeDhpZWloR05lOFlrejh4clNnMktLN2hTZzdBbXE2?=
 =?utf-8?B?amhlMG4zYWlyVUdRSmRzVjA5N0FSMFA0N0hTelpNcjhqSDBUZDIvdnVNNHRw?=
 =?utf-8?B?eUlrVUsrRnl1Q05MWlJvM0dEb1dyVHlxTDE5UnBDVkcvQUhPQXord0RnR0lK?=
 =?utf-8?B?SXp5TkgxQ0dvYmUzRFJ2bDI0SEkyK2Z1ZWg4MEdwbloveHpJOVVSOFJpZHFz?=
 =?utf-8?B?eXQ2cmoweUM0bTNGR0VMS3BlZ1VqL2NMRmhKaUlsU3JxRWNNMFdxTm5lWktv?=
 =?utf-8?Q?nOTQK89Q7rRuoALWZdDy+tbD20sTlZhwsrUKUq266Xu1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D74E28F23A052040A2DFAB36E54AECA0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fc2698-f89e-43f3-aad4-08d9f27bed3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 01:13:52.4373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w5Qt+LQgoa4EQhOJrT6KvXjdIxLSdqAKw96/fvxVvk7vM2uWhaPx4PkQmpywGOgUZSO/Xh0L/aHDg8mbZ0h/Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBGZWIgMTYsIDIwMjIgYXQgMDU6MTQ6MjdQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gV2UncmUgb25seSBpbnRlbmRlZCB0byBkZWFsIHdpdGggdGhlIG5vbi1Db21wb3VuZCBw
YWdlIGFmdGVyIHdlIHNwbGl0IHRocA0KPiBpbiBtZW1vcnlfZmFpbHVyZS4gSG93ZXZlciwgdGhl
IHBhZ2UgY291bGQgaGF2ZSBjaGFuZ2VkIGNvbXBvdW5kIHBhZ2VzIGR1ZQ0KPiB0byByYWNlIHdp
bmRvdy4gSWYgdGhpcyBoYXBwZW5zLCB3ZSBjb3VsZCB0cnkgYWdhaW4gdG8gaG9wZWZ1bGx5IGhh
bmRsZSB0aGUNCj4gcGFnZSBuZXh0IHJvdW5kLiBBbHNvIHJlbW92ZSB1bm5lZWRlZCBvcmlnX2hl
YWQuIEl0J3MgYWx3YXlzIGVxdWFsIHRvIHRoZQ0KPiBocGFnZS4gU28gd2UgY2FuIHVzZSBocGFn
ZSBkaXJlY3RseSBhbmQgcmVtb3ZlIHRoaXMgcmVkdW5kYW50IG9uZS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IE1pYW9oZSBMaW4gPGxpbm1pYW9oZUBodWF3ZWkuY29tPg0KPiAtLS0NCj4gIG1tL21l
bW9yeS1mYWlsdXJlLmMgfCAyMCArKysrKysrKysrKystLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEyIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
bW0vbWVtb3J5LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gaW5kZXggN2UyMDVk
OTFiMmQ3Li5kNjZmNjQyODg4YmUgMTAwNjQ0DQo+IC0tLSBhL21tL21lbW9yeS1mYWlsdXJlLmMN
Cj4gKysrIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiBAQCAtMTY5MCw3ICsxNjkwLDYgQEAgaW50
IG1lbW9yeV9mYWlsdXJlKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3MpDQo+ICB7DQo+ICAJ
c3RydWN0IHBhZ2UgKnA7DQo+ICAJc3RydWN0IHBhZ2UgKmhwYWdlOw0KPiAtCXN0cnVjdCBwYWdl
ICpvcmlnX2hlYWQ7DQo+ICAJc3RydWN0IGRldl9wYWdlbWFwICpwZ21hcDsNCj4gIAlpbnQgcmVz
ID0gMDsNCj4gIAl1bnNpZ25lZCBsb25nIHBhZ2VfZmxhZ3M7DQo+IEBAIC0xNzM2LDcgKzE3MzUs
NyBAQCBpbnQgbWVtb3J5X2ZhaWx1cmUodW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncykNCj4g
IAkJZ290byB1bmxvY2tfbXV0ZXg7DQo+ICAJfQ0KPiAgDQo+IC0Jb3JpZ19oZWFkID0gaHBhZ2Ug
PSBjb21wb3VuZF9oZWFkKHApOw0KPiArCWhwYWdlID0gY29tcG91bmRfaGVhZChwKTsNCj4gIAlu
dW1fcG9pc29uZWRfcGFnZXNfaW5jKCk7DQo+ICANCj4gIAkvKg0KPiBAQCAtMTgxNywxMyArMTgx
NiwxOCBAQCBpbnQgbWVtb3J5X2ZhaWx1cmUodW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncykN
Cj4gIAlsb2NrX3BhZ2UocCk7DQo+ICANCj4gIAkvKg0KPiAtCSAqIFRoZSBwYWdlIGNvdWxkIGhh
dmUgY2hhbmdlZCBjb21wb3VuZCBwYWdlcyBkdXJpbmcgdGhlIGxvY2tpbmcuDQo+IC0JICogSWYg
dGhpcyBoYXBwZW5zIGp1c3QgYmFpbCBvdXQuDQo+ICsJICogV2UncmUgb25seSBpbnRlbmRlZCB0
byBkZWFsIHdpdGggdGhlIG5vbi1Db21wb3VuZCBwYWdlIGhlcmUuDQo+ICsJICogSG93ZXZlciwg
dGhlIHBhZ2UgY291bGQgaGF2ZSBjaGFuZ2VkIGNvbXBvdW5kIHBhZ2VzIGR1ZSB0bw0KPiArCSAq
IHJhY2Ugd2luZG93LiBJZiB0aGlzIGhhcHBlbnMsIHdlIGNvdWxkIHRyeSBhZ2FpbiB0byBob3Bl
ZnVsbHkNCj4gKwkgKiBoYW5kbGUgdGhlIHBhZ2UgbmV4dCByb3VuZC4NCj4gIAkgKi8NCj4gLQlp
ZiAoUGFnZUNvbXBvdW5kKHApICYmIGNvbXBvdW5kX2hlYWQocCkgIT0gb3JpZ19oZWFkKSB7DQo+
IC0JCWFjdGlvbl9yZXN1bHQocGZuLCBNRl9NU0dfRElGRkVSRU5UX0NPTVBPVU5ELCBNRl9JR05P
UkVEKTsNCj4gLQkJcmVzID0gLUVCVVNZOw0KPiAtCQlnb3RvIHVubG9ja19wYWdlOw0KPiArCWlm
IChQYWdlQ29tcG91bmQocCkpIHsNCj4gKwkJaWYgKFRlc3RDbGVhclBhZ2VIV1BvaXNvbihwKSkN
Cj4gKwkJCW51bV9wb2lzb25lZF9wYWdlc19kZWMoKTsNCj4gKwkJdW5sb2NrX3BhZ2UocCk7DQo+
ICsJCXB1dF9wYWdlKHApOw0KPiArCQlmbGFncyAmPSB+TUZfQ09VTlRfSU5DUkVBU0VEOw0KDQpD
b3VsZCB5b3UgbGltaXQgdGhlIHJldHJ5IGNoYW5jZSBvbmx5IG9uY2UgYnkgdXNpbmcgdGhlIGxv
Y2FsIHZhcmlhYmxlDQoicmV0cnkiPyAgSXQgbWlnaHQgYmUgdmVyeSByYXJlIHRvIGhpdCB0aGUg
cmFjZSBtb3JlIHRoYW4gb25jZSBpbiBhIHNpbmdsZQ0KZXJyb3IgZXZlbnQsIGJ1dCBqdXN0IHRv
IGJlIHNhZmUgZnJvbSBwb3RlbnRpYWwgaW5maW5pdGUgbG9vcCAodGhhdCBjb3VsZCBiZQ0Kb3Bl
bmVkIGJ5IGZ1dHVyZSBjaGFuZ2VzKS4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hpDQoNCj4g
KwkJZ290byB0cnlfYWdhaW47DQo+ICAJfQ0KPiAgDQo+ICAJLyoNCj4gLS0gDQo+IDIuMjMuMA==
