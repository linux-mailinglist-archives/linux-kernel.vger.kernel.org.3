Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FEF52B12F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiEREQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiEREQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:16:48 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20705.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::705])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBA41929B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwQHbyKLcPUOJXqVK/pWZV1grzlDGUikrGH8SKHFi5PeACP+ctXKYDstkeBmht9x7IxDcq8noRgjs3uHQnOydOoU3mLnhwyWjV+ASpQ024TnTxJqaKTTW1mpCeFpkE894wTCXjk4RXAK9urpI2tMuZ8mpBFIp8VydznVvcorVm417bYWDdWsZma5pht5ah0n7RDd2DjKUmYfzuHTTCGSK4uAVOb//H3VlmzsAT+RJpXXSYCCJyGzwcaHwzG3e2DAfozGL5PWNuT5FoH4sJhJC36sTBpou6uNLyt2PRxzcbJ440TBX27H/W8HSa/YaN4AzMFeGW1jvmXnQnNTzyOC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0oQIHyMjb24N1LQlwURqL0XLRr2xNEYze2AApXH43M=;
 b=TwSbVvdHG7kE35QAQlku7A163clwZHVcUv6k52u15qkUoaIo3fGOU9lRiQrbBlrNtMcgXAP+qTD2dRljIzPm0qMljMbZYDqmSA+8Fv0VySlgKwwkmSrjWyQXrg5+hwggywMqs+RPcDCroWUft8rntu8dZf5Vx13ec2d8H6YjaJ9iFRXCmRnEgaTJ4jxqBqBUR4fpPZ/V1vnFK8D2V6G8jJNPgJpUIj0wx5pisBhgTlrhjk7l5LPyF5H5EHY7D77hUC7CWmXo90gopAEluY5YjDj94G27KsVG7tLjbfqqlgppepPevjZToW09ttfrhTy1mLrsa+9w6cRfbjizXTwT5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0oQIHyMjb24N1LQlwURqL0XLRr2xNEYze2AApXH43M=;
 b=deyzeigSt62BLgnxVefx+vaQt9YUcF0Vv4tLG3RAUZitNkJcgqI1BGdkaQX7updNKjRrUIhVXbjlozfoqNMZkFgA5AIjYZhBiRVeg3EkDTXcSaQHGJEAi1ugj5GrqM2oXqjpTrvNA52S8LT6kqvNl+2kFBC3gBN8WKqfQKXxm7U=
Received: from HK2PR06MB3554.apcprd06.prod.outlook.com (2603:1096:202:40::16)
 by SEZPR06MB5165.apcprd06.prod.outlook.com (2603:1096:101:4c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 04:16:41 +0000
Received: from HK2PR06MB3554.apcprd06.prod.outlook.com
 ([fe80::b165:bea5:2a76:615e]) by HK2PR06MB3554.apcprd06.prod.outlook.com
 ([fe80::b165:bea5:2a76:615e%6]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 04:16:40 +0000
From:   =?gb2312?B?zfXOxLui?= <wenhu.wang@vivo.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] uio: reset file private_data pointer after kfree
Thread-Topic: [PATCH] uio: reset file private_data pointer after kfree
Thread-Index: AdhqbZCUXl8GCnGpSf+D62lFoPY3Tw==
Date:   Wed, 18 May 2022 04:16:40 +0000
Message-ID: <HK2PR06MB3554789EC96D408ADDDC82F8E3D19@HK2PR06MB3554.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f13592bc-5bff-4af7-c316-08da3885355e
x-ms-traffictypediagnostic: SEZPR06MB5165:EE_
x-microsoft-antispam-prvs: <SEZPR06MB51654F7635C3E8D0B13D50EBE3D19@SEZPR06MB5165.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uj723vRRc0ttCn9tVKFM+sqG/WGvM3uBBXDstE8lKB04FsWrRAHZzjhhUOXWlg5Q8+bgQBYgZLBe8ZTNTCPSE0y9m/41kt9UJuKGjnFiMsvN2DXkWEEI22yKi9I3dNXY8XchYID5E8u2DQQxkjyW4/bf0WBi1IFZmn6YTU4cyW08hEzy0FNB46LcBzgpXB6xEY/fXt5HUK/FPWgkf+xMzsodFa7g0I4zHjKfYI3B+f0VirCifvzrMnPpD1G7XlwDsRZog8SF8UFus3+RW7ipQRDtw6BT45mUVt0J+qrXeMxrUrg4qeddEGc5mNmkGI9glw/EkSeh/hSsLPwEkr5iWkNdsGTkhSzzzpmV/5GwJ8F2N59cofW3q9Zkkv9s4AjbzPEOSzsEwLGkys3S//w2XpXVt5cvzdT8JHsm4TmBajHOSch0UX6hjxzqAIqLxXm9UzIH4ec6hnbQyv7WHj7qFR6+kDA7yhkz0yBrelfkM9zsaOObtqRiKbvNhfFUTsF6RpAUOx9H9uYMP2Up8JItYjswb8DX0oF8IZlETcyn0x0Tchz/AA/2Hbp/ImexRlQI1aqhSeKEK4RxcE1fvL46rXJ4BGYlnYHObHQiUXhbDXRFkH+HqoJW5DCtwS48+Vx6HidiHhLXMmjqTuol7pp7VmWTE/d9JNl1jkimAiLy92cIuGb6VvK0OPS5y+WmwiLR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3554.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(64756008)(66556008)(66476007)(66446008)(76116006)(8676002)(38070700005)(4326008)(508600001)(9686003)(122000001)(52536014)(26005)(8936002)(5660300002)(55016003)(38100700002)(71200400001)(83380400001)(2906002)(186003)(33656002)(85182001)(6916009)(7696005)(316002)(86362001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?STRIdkxZWXNqR081TGZJWU1aWm9iT2NkZ0I4UlpUZnFwRVFJaElGZFF0YmRD?=
 =?gb2312?B?T3ErZkxNVWZmMUVwRm94S3lScWt0emVDTWlOeUt2aVNqNkVsdWJpd1QramUw?=
 =?gb2312?B?NTliSDJhampscXV6eUNjeFkxTFMzcGNPaVRFTmZzRWljamd2ZTAyVVJSeXNZ?=
 =?gb2312?B?bWl4RWFNTjJqb04xYzEvTUhYU2JwaGlGLy84RExKRWNnWnNQUDRtSjl2MGlO?=
 =?gb2312?B?NkxQUXJkZkUyV0VXeUZIMm5EV3krSUlVVTFBOEs2aVRiSVYxUXlnV1hhMkc1?=
 =?gb2312?B?ZjExNUQ2Mnd6ZDJaME5OZmNpS2NpNWZSbUxTRHpnejRtamdmSmltb1BYZGtE?=
 =?gb2312?B?cmJNeFZIVVYraDdIOWtoMjhZQWxSOUQwZ3dQYm94YW9ISTQ4dW4xQXpGVGl5?=
 =?gb2312?B?KzZFenNGbWJ4QnFnSDM1cW9aamdZbzBtcWsvN25ia3Q2cXZ2WGJUR1lTa05i?=
 =?gb2312?B?RWdBcjhxTVYxMXRDQSs1bGc0U2I5WDVaTU9PR1pqU1IwT2tDZEE1cFlQZzY1?=
 =?gb2312?B?U3ZUeEZkRTk4ZnhkSG9YN3FTZzc1S0UrVjZLRGw1SlhESForaC9WSjByWmgy?=
 =?gb2312?B?aDJKek1qczlhNlBSTFFVbzg5QmEvR3ZiNDJJRjRCZjVIMkFObnpmZzJZWFdh?=
 =?gb2312?B?N2hGaldab0o1SGRsU2ZmRUg0VHpxbmxENFgwZ1VmOUN2b3pYckNvYTRxLzNy?=
 =?gb2312?B?TERJSlU5cDFUZHhIei9nR29lbGFWZTNsVS9VQ1lmR1BJcmU1cW9tUzRUNWFp?=
 =?gb2312?B?WTVCeWRUZzhEM3Z1b1lSeXZsVnZvellGejRmanVzZmoxYW1oc3JyWkdNQWRU?=
 =?gb2312?B?enlJRVIxc2RZd1hGVnlQRndRbTVvQ2pRQ2NOKy9XMXlRbDgwdjZnMStxU051?=
 =?gb2312?B?Y0NuUW5TTnpoVkRKcnlxSG1GL0kwMDIwS25XYXU0ajdVd3lmOVFzSFlQRTVP?=
 =?gb2312?B?SGRPb0dQRFNUTnFTdm5uQXRuWjZWWmJOTVNXRDhCT0NhS1ROOCthNGtxTzVj?=
 =?gb2312?B?SnBSYVVkK2tWaHRsb09nNTlzbHREbVl2SnhueTBLb3MzTnJBUzZjL05pNFZD?=
 =?gb2312?B?Q0IwalZIUEZhUE1BTzdBcnEvTnBHWFNtdTZLVG1CN2V3eWVXRUgzZWs4czF1?=
 =?gb2312?B?WlIxUkRhOStRcnluVGpjTGIvSFR2SG10M0JGdm9UNGY3N1h6TUtHVll2M2ow?=
 =?gb2312?B?a213dy9oRG1QZkVxc2swZEVhZUtHaHcwUlJhdk5ZbS9td3FsT2JkaWhxZHhI?=
 =?gb2312?B?dXhRcjlhWklrRGxLY2JzbzBsWW5mcElGdXpRbGZ0ZUxqVlNFRlZqZnFQQzYr?=
 =?gb2312?B?VWRsRWdEYnhsbGxaVzF0SVJNQ2ticnZVR1JTMFZtNSs5UVVJWG5WUk16ZFd2?=
 =?gb2312?B?ZndTQWp1WmNZdTlKT2NnZ2NnTCtBRXNJVHdNNk91dy9FdjB0S3ZzaDM0MXV3?=
 =?gb2312?B?Uzl6cm45UHViMXlSUVZQL013c1F5TkY1SC9FT1VYaTZCdlRnT3duQTcvNVBJ?=
 =?gb2312?B?KzlTSkE1NytHblpURnpHR0x2NnVXL0NLc3hQaTR4VWtkRWI1aWRHbUQybmdy?=
 =?gb2312?B?T0lpQllIQUpBVnVyVjJkTHE5WS9xRDcxbzRsQlM2MGZkUWE0YWF1QTZ4S2ZW?=
 =?gb2312?B?YkxIWjZkTHQ5czJnekIyNTgxa1czNjJQUm5JdDB5TERKNEZLbG9aWkFkQlNi?=
 =?gb2312?B?QjJaMEhYNWs2S1pIOGZCWlpKb3htam5CS1lXQ2E3OTVkd2Zhei9mS3FuSlow?=
 =?gb2312?B?V0NpVzlTWWNzazZwZzg4MzZ3c3RIdWpzNEVjbUt5cUZ1WHFGL1BKUzNTZEw3?=
 =?gb2312?B?RHdpMDFKL2REcWk3bnZyZGNGMlJWaEd0TkIyQ0xtZzZlTnBicTlpU3F6QWlW?=
 =?gb2312?B?anpoSElRZ3FLSFFCSC9uQ2phdit0N3poMTNxSDlUSHFneEd3Yk0wbzVqWnpN?=
 =?gb2312?B?dE9FSSthQlJVMnJGQldwZzVBcHJra1dwS3lwTEN2Tit3MVlTREc2MUUxb1pX?=
 =?gb2312?B?NFI0RTgyMHBFZHBmNHozRVV1aG9tQWxubllqOWlmTEVsRW9Ccno5d2lFakFT?=
 =?gb2312?B?UTI3dkh4VWtVWXNteEtQYTZNSlg3cnZxeVJTLzQ3VThyd0VaVHFjMHR3YU5z?=
 =?gb2312?B?ZUdtRU1oZkJIc3Z5ek83UEtscC83YnZpVWVMZGl6VzZnWHRwU0pReXByMFRS?=
 =?gb2312?B?S1JXbVQ4Z0c5cGxwc3U5OHdnT2RCTU8wbk8zTExXWVgxSkdlMEdsb0FxZFNR?=
 =?gb2312?B?MSt6R0hYdk5Qazd2cjl3a3JNNU9vTHVDcG9BNFpwdE43dkJuRHpYclNWQzlI?=
 =?gb2312?Q?YLbC0mMxBvZAsxFJcL?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3554.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13592bc-5bff-4af7-c316-08da3885355e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 04:16:40.2930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rY7cTwiacXq3M7T28FwvEBHcGDNGnepy3J4ycDuqS6bHpeWQA9PsrgMCQc7S7kssrd8UBJ/lREkfuHbCNinCgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5165
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogV2FuZyBXZW5odSBtYWlsdG86d2VuaHUud2FuZ0B2aXZvLmNvbQ0KDQpUaGUgcG9pbnRl
ciBwcml2YXRlX2RhdGUgc2hvdWxkIGJlIHJlc2V0IHRvIG51bGwgYWZ0ZXIgdGhlIG1lbW9yeQ0K
aXQgcG9pbnRlZCB0bywgd2hpY2ggd2FzIGFsbG9jZWQgZm9yIHVpb19saXN0ZW5lciBpbnN0YW5j
ZSwgd2FzIGZyZWVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBXYW5nIFdlbmh1IDx3ZW5odS53YW5nQHZp
dm8uY29tPg0KLS0tDQogZHJpdmVycy91aW8vdWlvLmMgfCAyICsrDQogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91aW8vdWlvLmMgYi9kcml2
ZXJzL3Vpby91aW8uYw0KaW5kZXggNDNhZmJiN2M1YWI5Li4xNTk1YTZlYjM1MmIgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL3Vpby91aW8uYw0KKysrIGIvZHJpdmVycy91aW8vdWlvLmMNCkBAIC01MDUs
NiArNTA1LDcgQEAgc3RhdGljIGludCB1aW9fb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1
Y3QgZmlsZSAqZmlsZXApDQogICAgICAgIHJldHVybiAwOw0KDQogZXJyX2luZm9vcGVuOg0KKyAg
ICAgICBmaWxlcC0+cHJpdmF0ZV9kYXRhID0gTlVMTDsNCiAgICAgICAga2ZyZWUobGlzdGVuZXIp
Ow0KDQogZXJyX2FsbG9jX2xpc3RlbmVyOg0KQEAgLTUzNiw2ICs1MzcsNyBAQCBzdGF0aWMgaW50
IHVpb19yZWxlYXNlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlcCkNCiAg
ICAgICAgICAgICAgICByZXQgPSBpZGV2LT5pbmZvLT5yZWxlYXNlKGlkZXYtPmluZm8sIGlub2Rl
KTsNCiAgICAgICAgbXV0ZXhfdW5sb2NrKCZpZGV2LT5pbmZvX2xvY2spOw0KDQorICAgICAgIGZp
bGVwLT5wcml2YXRlX2RhdGEgPSBOVUxMOw0KICAgICAgICBtb2R1bGVfcHV0KGlkZXYtPm93bmVy
KTsNCiAgICAgICAga2ZyZWUobGlzdGVuZXIpOw0KICAgICAgICBwdXRfZGV2aWNlKCZpZGV2LT5k
ZXYpOw0KLS0NCjIuMjUuMQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KDQqx
vtPKvP68sMbkuL28/sTayN2/ycTcuqzT0Lv6w9y6zS+78tL+y73Qxc+io6y99rmp1ri2qLj2yMu7
8rv6ubnKudPDoaPI9MT6t8e3orz+yMvWuLaoytW8/sjLu/LG5LT6wO3Iy6Osx+vO8Mq508OhorSr
sqWhori01sa78rTmtKK0y9PKvP7WrsjOus7E2sjdu/LG5Li9vP6ho8jnxPrO88rVsb7Tyrz+o6zH
67y00tS72Li0u/K157uwt73Kvc2o1qq3orz+yMujrLKivavUrcq808q8/qGiuL28/rywxuTL+dPQ
uLSxvsm+s/2ho9C70Luhow0KVGhlIGNvbnRlbnRzIG9mIHRoaXMgbWVzc2FnZSBhbmQgYW55IGF0
dGFjaG1lbnRzIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBhbmQvb3IgcHJpdmlsZWdlZCBpbmZv
cm1hdGlvbiBhbmQgYXJlIGludGVuZGVkIGV4Y2x1c2l2ZWx5IGZvciB0aGUgYWRkcmVzc2VlKHMp
LiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgbWVzc2FnZSBv
ciB0aGVpciBhZ2VudCwgcGxlYXNlIG5vdGUgdGhhdCBhbnkgdXNlLCBkaXNzZW1pbmF0aW9uLCBj
b3B5aW5nLCBvciBzdG9yYWdlIG9mIHRoaXMgbWVzc2FnZSBvciBpdHMgYXR0YWNobWVudHMgaXMg
bm90IGFsbG93ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgbWVzc2FnZSBpbiBlcnJvciwgcGxlYXNl
IG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJlcGx5IHRoZSBtZXNzYWdlIG9yIHBob25lIGFuZCBkZWxl
dGUgdGhpcyBtZXNzYWdlLCBhbnkgYXR0YWNobWVudHMgYW5kIGFueSBjb3BpZXMgaW1tZWRpYXRl
bHkuDQpUaGFuayB5b3UNCg==
