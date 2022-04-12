Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E714FCF31
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348480AbiDLGBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 02:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbiDLGBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:01:46 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2057.outbound.protection.outlook.com [40.107.114.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C0E22B19
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 22:59:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffn5ZimvjfYW0IpTsAf8OA2uUw/0QmNY/iLR1Sbtx1ZxsGnrJhrdNygy+nwv8VjZGR8KsSLnl2/5H+yCDxBQd0kzWcv312zbJlbe6pfkk9wToiAGEzM/jXns/7sfdgNH5O199EXegCvJFT5MVh3FFyatXs711E1hMQrPYQ6+0/n0vkaaugXMSF8O2kQ2jj1xTJ/o5WYyTJP6cqtAdEfRi7ba2mXAxzCIFJIWpb99x95eqJe3zU1HijIc/oyl6GXaUBPoGOZ3TLIIvicUTN+pOPtlWwOlV5zqR9aqCnbwDTp8TlPd4qQ+tQjNkMdRGqg1IXma7JliMRo5pbMtRZ7icA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FyR+3Dt7dsIY5cyzxBw9039KVleorK8sdzhavhjM3c=;
 b=PRF5VVJ/k5X3q4fG5j9dQd4HLKTFCXbq0i15w3RL6NPvCgcrgIXOB8tX6Nrs963keZEPnpgh0OBMqFQeiZeYZI4J3mLnujX1iE4eOh2UmsKwAfytFC/OxAlFEGvjWVVadsBknse31xZ1oV5+Xku5ZtiwIv3i0a07Ps45zJs72FJHjYPeZqX2fS9YuKhU++NJlgP1EGXAUm1aZM1JhBe6auvjWfW0oVIEOKIbgI2qEYoondyqH+tZbRSgDAePJNngYqfMWL+Hcy9ww+jUQqDHPOMtjLjrDkXI3Sfc708ZUnOItmoH4uTr7f/0xCMbz0rVMihlu0qqLrHXAOQi8WliEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FyR+3Dt7dsIY5cyzxBw9039KVleorK8sdzhavhjM3c=;
 b=X9jmkmOXF9LDQz74oIZEEnuzQ58GdLKSUrFPq6EXvVKDG8ctk04sBkEuai5lF+VR3xUe0S5/wlfOah371Yv4afy3WWMrCoYkhAogisKaHS+5qOyo1Wxiu7v2asbEFCl5MMykiQaLYjV7ygRSKo8fxKUIUOW+3wVIPvtVKTNp/qI=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYAPR01MB4031.jpnprd01.prod.outlook.com (2603:1096:404:c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 05:59:23 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232%8]) with mapi id 15.20.5144.028; Tue, 12 Apr 2022
 05:59:23 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mm/memory-failure.c: dissolve truncated hugetlb page
Thread-Topic: [PATCH 3/3] mm/memory-failure.c: dissolve truncated hugetlb page
Thread-Index: AQHYSn/keBQQihCxBEyue1wskLydZazqtvEAgADjeICAADWAAA==
Date:   Tue, 12 Apr 2022 05:59:23 +0000
Message-ID: <20220412055922.GA3227993@hori.linux.bs1.fc.nec.co.jp>
References: <20220407130352.15618-1-linmiaohe@huawei.com>
 <20220407130352.15618-4-linmiaohe@huawei.com>
 <20220411131344.GA3188122@hori.linux.bs1.fc.nec.co.jp>
 <bc3284a7-1e02-996e-10b5-dd7cc983134e@huawei.com>
In-Reply-To: <bc3284a7-1e02-996e-10b5-dd7cc983134e@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 704fc6c2-334d-4e7b-c598-08da1c499836
x-ms-traffictypediagnostic: TYAPR01MB4031:EE_
x-microsoft-antispam-prvs: <TYAPR01MB4031A7857ABE298ED19D2AD4E7ED9@TYAPR01MB4031.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aNWqnsi7/+TuzZAGr4tYiQzfFLKZpiFjzoRPdcm4MZ4Qia/MQ4D4WnGdIc/zSAO0Qizvi4vlB9B1QzXHKb/o8hzSMYh52h+0R1nKPlFgFaSgoHl/vsh0WNvNs3qIEXCiFHPye8FLyTP5tEFbRr58vc2jSIPnJdwpWfFAT/ww0QOGPHNskFqB1EH0pjKPoj1K2eMzA2B+Q1wCSl7sPKg9PK7nK71Ec+9NP4HMebWYHAM8G4ytvErNf2jIoIFyaKLHEy01ytd5tZioo7+dcy0qbUQ2ZHSLa60HpYUC6FvdZmv/mfZMJsa3cq/9wWONNO44h6Pb0bfIHnokVXEdYCHV5Tsz0UjrfnRTz57FUtyQXjHmrZDpB23Efqavwh8mw2NXzFcmruawMs7Eib6JxxHYadd/PFUY+RIgjaCBghPKcV6da7IVzK0xTI5kW6IRfiS1LGIT2d7b2ZLz1ITjO9N7/TGJP540G474qzFyunqUw7AaUUUbb53NoMDD5lzC/Fc2L5SVMIF5AgjpA7/ky4IUrMZUPLNO1LMZ/XxLw3a0jxdXSgAw33gNhDWVWBQEfpZR99wABIO9tUu7Iodz8uknGYGnopo/PTCn67MS4Nq99/M0PaT5QKi5gjTdMCAKCqJ9G3FfFcEU/r+jLOLdTEkdWfeFcbuMG/tbFz/TSeDMolIrOVAyu/TJhcBczb9nsxZZWhsnat6hNpOolkW9v0L/zA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(82960400001)(85182001)(38100700002)(8676002)(64756008)(66476007)(66556008)(71200400001)(66446008)(76116006)(4326008)(66946007)(5660300002)(6512007)(9686003)(6506007)(33656002)(122000001)(6916009)(26005)(53546011)(316002)(186003)(6486002)(1076003)(508600001)(83380400001)(55236004)(86362001)(8936002)(2906002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzUwL1ExL1hxNmlMaklCS2Nkam0zcUd4WGM2NXZpemtlVkUvNGFmQnBFR3p5?=
 =?utf-8?B?S2daSjRwSkJKU1gzTXBXQnhRbDh2eHRxUkhvUTJkUzJoeVY5a05tb0Q1cXVS?=
 =?utf-8?B?cjIvTk9FOXdqeWc0RU5lRnJkZnhVblZCaDNYY3lNWTE3YzlwTTJsZk5KZlI2?=
 =?utf-8?B?dllqTXlRSE5YVUI5L1loekRqaTFmZWVJV2ZFeGMwWlNhSW1DN251ZDNoSkN0?=
 =?utf-8?B?NTdFMXA2M1EzbGpBcDdBOVRUcUFkenFMVndkditpMjVWeDVRMUJ5YUNkRHNJ?=
 =?utf-8?B?cmV4bFZ6bk1WTHVOWCttNUc1RjYxMm1DTFFnY3VNYWhKUVdBS3ZoN0tndmRE?=
 =?utf-8?B?NW1OMkUwRmNKdFpVVC9rS241Y1lmRW1ET1dBc3IwNlNoK0pmNWZTRzNoYnVC?=
 =?utf-8?B?Z1pIY1Q2aDEvcGt4M0E4NElqdUx4S1ptenFiMzJzb2JhTWRCZFNSU3B1OWZ0?=
 =?utf-8?B?ekJvTDVocldYNmdNNkp5cW9pTm5KZ255QkVGeTRwY1NPUzBLOElZSS82UVd3?=
 =?utf-8?B?VFc5bjBkWVRPMnRpM3llbVZwWHUxMVNtMmJDMFdNczFNUDFHdXFsaUhHWFkz?=
 =?utf-8?B?Ky9ZbG5nZ3cwUDVZVExDcDNaR1FEYWJFL0k2cTNWUUpZZVRXZHorYVlTMUsx?=
 =?utf-8?B?MG1HWFlZRGhtdTFvZ09RSndZSUg1UGFveG5tK0RFZ096cnZQUEdKeWVJK21U?=
 =?utf-8?B?QWdwY25mNWFKSDlmNytzODRzc0FZVk9NVVF3OW95WnJpUmJzUlBJMVJXQjVo?=
 =?utf-8?B?TUNPMkZEQkNmT2NlTnVyOTVxM05KTjF4VEZLeC84ZFJMQVNEYWtqdmJxaDhZ?=
 =?utf-8?B?OVpwekZhRks5WHVYRkVENWpXWkNNWVR2RjlMaWgzUDBQM1ZaUCtrN1pyVmNz?=
 =?utf-8?B?MTBxcllTNkFJL1pmcEsyLzFzUHlYK0w4WEVyUTJyNVpvaklrdjVVeEg2ZFdV?=
 =?utf-8?B?eGI3ZDBuSlZMYk5pN3dGRlJJOEQxTk55OVdkL2FXQVZER2Q0eEd6RVFnM2lB?=
 =?utf-8?B?cHJmK0ZXbVhxRWV4d25rOXBkc2tScUJYcmRaQ3l2S1c4MWkyMXVVUTFtekpm?=
 =?utf-8?B?UGJTY1c5ZitvMzVGTUtxelU1RjkvQzAvLzhhVlZ4bWtTMCtnZEpvalpwOXVq?=
 =?utf-8?B?OWdldm96MEJhaVB0SURnSFl3bGhPMmN0dDNpL2FQQVpROVl6dmpZZmc5NjBR?=
 =?utf-8?B?cEZ3SnBQTFpDaGlWV25WTFlRMk9laC9kdjI0RmxXemxQbFdhWW8yRW12MVBp?=
 =?utf-8?B?ZkI3L3hQcEQyRnJQOWtqWnZreHpzNjQ0U056dHVKR09vMDZLZDA0cTN5Zk9P?=
 =?utf-8?B?NTlSalZod1hEWENxOTFsbGZzNDA0UTJQM3U4eVFxbWZrNWphRXVtWmxlU21S?=
 =?utf-8?B?dnBhZ1Z1dXNyRWxTaElqRWlFUG1BMXVBcTljaFRQYTNMRnE0WHhJVGRlYnJx?=
 =?utf-8?B?Ung5eEhJelBVcW1YbktWcFo3UXRtVVhMS3BFbmQxZk5WdXVjSEdsaGhUVEY4?=
 =?utf-8?B?UGpXQzYrNklMUHl5dVNwMUZqM2ZzUjZlTi93bEpJdXVxaGRoTVcwU0dpSlJT?=
 =?utf-8?B?WERnTzd6dTBCU0VpVXRaNzNjNndaTlBkeVpzeW1MblZLeXFEN0JSL2wwMDhm?=
 =?utf-8?B?V1hFVzFsemxuQ2xIRTBFM2RGUlJTdW54ZHYyQjd1K2c1WCsvS1orQm5idllv?=
 =?utf-8?B?TG1PYTY1cnk5bFA4Sms2QlR3L0FTQVIwWXdveHF2L2FyaUN4bFFVNHNRbWZP?=
 =?utf-8?B?akdBVlFZZHJwT3ZiWHI2cFRHczNhRXg4ZHloaEpXRVAwVDRhV1VNaTdMelkx?=
 =?utf-8?B?L0U0Ym8wYzVQQTBUdlh2SkMrZjRBZFAzVi9kS1k0c2FtdlNCOVdVZk5YSXRq?=
 =?utf-8?B?TVdORUxrS3VSeWZBSTAzOFQ3VDJJQS93bXZBTGY5dGdKc2dZNXhSNkpNMXV6?=
 =?utf-8?B?djZpQTMrc01SVnE1YmFxNEpYbUJnMmJ4QnlLRTdibjFEZVZFeGYwZjJQVENz?=
 =?utf-8?B?TDFEZ3JIMFdGcngzZmJqN1RzS2IxNjNiaGVQbFZqUTl2ZUh6ZHJ1aHhtaTB5?=
 =?utf-8?B?blY3b0ZQaXBMTDA2ZnZ1RkNuTTFYcEFwOE5OMEhyY2NNbG5VVWhjSkVodGdB?=
 =?utf-8?B?TUlVVitldWZRWWNVZXpnTm5ibTNUYU0wSnVwemxmaFNKQW83TG1GMjRFREhl?=
 =?utf-8?B?VDFkSlp4SFV5eUZzTGh2ZUFVUU9ldGxUZmtIZS9YQzJpd0tUbVhQaWZkbTdu?=
 =?utf-8?B?cldhYWFuNUQ3K1dCdElFbnBUYlcrY096dGdZakQ0Vm9BZExVK3U0WnZBa2FC?=
 =?utf-8?B?TnVNVDJ3ZTVWUHQwMTljODRFNW5VQVdmR3EydS9HMFQ3dXJxM2wwK3RCN3lP?=
 =?utf-8?Q?4T9A2XryB0+4r8qs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82C80C41B1E7C64C9A8C687C54290352@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704fc6c2-334d-4e7b-c598-08da1c499836
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 05:59:23.6544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0OXvx6zBRBM3HigFU3u14Yc5tF/Mqe8x6ZSeM93F80XUaLgPhgH1BYOIFiPpvzB+LzCbVo3vPe5+OKIoo20SaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMTIsIDIwMjIgYXQgMTA6NDc6NTNBTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi80LzExIDIxOjEzLCBIT1JJR1VDSEkgTkFPWUEo5aCA5Y+jIOebtOS5nykg
d3JvdGU6DQo+ID4gSGkgTWlhb2hlLA0KPiA+IA0KPiA+IE9uIFRodSwgQXByIDA3LCAyMDIyIGF0
IDA5OjAzOjUyUE0gKzA4MDAsIE1pYW9oZSBMaW4gd3JvdGU6DQo+ID4+IElmIG1lX2h1Z2VfcGFn
ZSBtZWV0cyBhIHRydW5jYXRlZCBodWdlIHBhZ2UsIGhwYWdlIHdvbid0IGJlIGRpc3NvbHZlZA0K
PiA+IA0KPiA+IEkgbWlnaHQgbm90IHVuZGVyc3RhbmQgY29ycmVjdGx5IHdoYXQgInRydW5jYXRl
ZCBodWdlIHBhZ2UiIG1lYW5zLiAgSWYgaXQNCj4gPiBtZWFucyB0aGUgcGFnZSBwYXNzZWQgdG8g
bWVfaHVnZV9wYWdlKCkgYW5kIHRydW5jYXRlX2Vycm9yX3BhZ2UoKSBpcyBjYWxsZWQNCj4gPiBv
biBpdCwgdGhlIGVsc2UgYnJhbmNoIHlvdSdyZSB0cnlpbmcgdG8gdXBkYXRlIGlzIG5vdCBjaG9z
ZW4sIHNvIG1heWJlIGl0DQo+ID4gc291bmRzIGlycmVsZXZhbnQgdG8gbWU/ICBDb3VsZCB5b3Ug
ZWxhYm9yYXRlIGl0IG9yIHNoYXJlIHRoZSBwcm9jZWR1cmUgdG8NCj4gPiByZXByb2R1Y2UgdGhl
IGNhc2UgeW91IGNhcmUgYWJvdXQ/DQo+IA0KPiBTb3JyeSBmb3IgbWFraW5nIGNvbmZ1c2luZy4g
V2hhdCAndHJ1bmNhdGVkIGh1Z2V0bGIgcGFnZScgbWVhbnMgaXMgdGhhdCBhIGh1Z2VwYWdlIGlz
DQo+IHRydW5jYXRlZCBidXQgc3RpbGwgb24gdGhlIHdheSB0byBmcmVlLiBTbyBIUGFnZU1pZ3Jh
dGFibGUgaXMgc3RpbGwgc2V0IGFuZCB3ZSBtaWdodA0KPiBjb21lIGFjcm9zcyBpdCBoZXJlLiBE
b2VzIHRoaXMgbWFrZSBzZW5zZSBmb3IgeW91Pw0KDQpZZXMsIGl0IGRvZXMuIFRoYW5rIHlvdS4N
Cg0KPiANCj4gPiANCj4gPj4gZXZlbiBpZiB3ZSBob2xkIHRoZSBsYXN0IHJlZmNudC4gSXQncyBi
ZWNhdXNlIHRoZSB0cnVuY2F0ZWQgaHVnZSBwYWdlDQo+ID4+IGhhcyBOVUxMIHBhZ2VfbWFwcGlu
ZyB3aGlsZSBpdCdzIG5vdCBhbm9ueW1vdXMgcGFnZSB0b28uIFRodXMgd2UgbG9zZQ0KPiA+PiB0
aGUgbGFzdCBjaGFuY2UgdG8gZGlzc29sdmUgaXQgaW50byBidWRkeSB0byBzYXZlIGhlYWx0aHkg
c3VicGFnZXMuDQo+ID4+IFJlbW92ZSBQYWdlQW5vbiBjaGVjayB0byBoYW5kbGUgdGhlc2UgaHVn
ZSBwYWdlcyB0b28uDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IE1pYW9oZSBMaW4gPGxpbm1p
YW9oZUBodWF3ZWkuY29tPg0KPiA+PiAtLS0NCj4gPj4gIG1tL21lbW9yeS1mYWlsdXJlLmMgfCAz
ICstLQ0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBiL21tL21lbW9y
eS1mYWlsdXJlLmMNCj4gPj4gaW5kZXggYmQ1NjNmNDc2MzBjLi4zZjA1NGRiYjE2OWQgMTAwNjQ0
DQo+ID4+IC0tLSBhL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gPj4gKysrIGIvbW0vbWVtb3J5LWZh
aWx1cmUuYw0KPiA+PiBAQCAtMTA0Niw4ICsxMDQ2LDcgQEAgc3RhdGljIGludCBtZV9odWdlX3Bh
Z2Uoc3RydWN0IHBhZ2Vfc3RhdGUgKnBzLCBzdHJ1Y3QgcGFnZSAqcCkNCj4gPj4gIAkJICogaHVn
ZXBhZ2UsIHNvIHdlIGNhbiBmcmVlIGFuZCBkaXNzb2x2ZSBpdCBpbnRvIGJ1ZGR5IHRvDQo+ID4+
ICAJCSAqIHNhdmUgaGVhbHRoeSBzdWJwYWdlcy4NCj4gPj4gIAkJICovDQo+ID4+IC0JCWlmIChQ
YWdlQW5vbihocGFnZSkpDQo+ID4+IC0JCQlwdXRfcGFnZShocGFnZSk7DQo+ID4gDQo+ID4gSSB0
aGluayB0aGF0IHRoZSByZWFzb24gb2YgdGhpcyAiaWYgKFBhZ2VBbm9uKGhwYWdlKSkiIGlzIHRv
IG5vdCByZW1vdmUNCj4gPiBodWdlcGFnZXMgZm9yIGh1Z2V0bGJmcyBmaWxlcy4gIFVubGlrZSBh
bm9ueW1vdXMgaHVnZXBhZ2UsIGl0IGNhbiBiZQ0KPiA+IGFjY2Vzc2VkIGZyb20gZmlsZSBhZnRl
ciBlcnJvciBoYW5kbGluZywgc28gd2UgY2FuJ3Qgc2ltcGx5IGRpc3NvbHZlIGl0DQo+ID4gYmVj
YXVzZSBvdGhlcndpc2UgYW5vdGhlciBwcm9jZXNzIHJlYWRpbmcgdGhlIGh1Z2VwYWdlIHNlZXMg
emVyb2VkIG9uZQ0KPiA+IHdpdGhvdXQga25vd2luZyB0aGUgbWVtb3J5IGVycm9yLg0KPiANCj4g
SW4gdGhpcyBicmFuY2gsIHdlIGhhdmUgcHJlY29uZGl0aW9uIHRoYXQgcGFnZV9tYXBwaW5nIGlz
IE5VTEwuIFNvIGl0IGNhbid0IGJlIGh1Z2VwYWdlcw0KPiBmb3IgaHVnZXRsYmZzIGZpbGVzLiBJ
dCBzaG91bGQgYmUgYW5vbnltb3VzIGh1Z2VwYWdlcyBpbiBtb3N0IGNhc2VzLiBJZiBpdCdzIG5v
dCBhbm9ueW1vdXMNCj4gaHVnZXBhZ2VzIHRvbywgaS5lLiAoIXBhZ2VfbWFwcGluZyhocGFnZSkg
JiYgIVBhZ2VBbm9uKGhwYWdlKSksIGl0IGNvdWxkIGJlIGZyZWUgaHVnZXBhZ2VzDQo+IG9yICd0
cnVuY2F0ZWQgaHVnZXRsYiBwYWdlJy4gQnV0IHdlIGhhdmUgYWxyZWFkeSBoYW5kbGVkIHRoZSBm
cmVlIGh1Z2VwYWdlcyBjYXNlLCBpdCBzaG91bGQNCj4gYmUgJ3RydW5jYXRlZCBodWdldGxiIHBh
Z2UnIGhlcmUuIFNpbmNlIGl0J3Mgb24gdGhlIHdheSB0byBmcmVlLCB3ZSBzaG91bGQgcHV0IHRo
ZSByZWZjbnQNCj4gdG8gaW5jcmVhc2UgdGhlIGNoYW5jZSB0aGF0IHdlIGNhbiBmcmVlIGFuZCBk
aXNzb2x2ZSBpdCBpbnRvIGJ1ZGR5IHRvIHNhdmUgaGVhbHRoeSBzdWJwYWdlcy4NCj4gT3IgYW0g
SSBtaXNzIHNvbWV0aGluZz8NCg0KTm8sIGl0IHNvdW5kcyBjb3JyZWN0LiAgU28gSSBhZ3JlZSB3
aXRoIHJlbW92aW5nIHRoZSAiaWYiLiAgQ291bGQgeW91IGFsc28NCnVwZGF0ZSB0aGUgaW5saW5l
IGNvbW1lbnQganVzdCBhYm92ZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uPyAgV2Ugbm8gbG9uZ2Vy
DQpuZWVkIHRvIGxpbWl0ZWRseSBtZW50aW9uICJhbm9ueW1vdXMgaHVnZXBhZ2UiLg0KDQpUaGFu
a3MsDQpOYW95YSBIb3JpZ3VjaGk=
