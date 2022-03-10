Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308214D3E28
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbiCJAak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbiCJAaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:30:20 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2041.outbound.protection.outlook.com [40.107.114.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C03125525
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:29:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asKctnXxbYhcV6njrIu68XsiQuVNgjxbx+0x3esNZIP2jXycaPRdSMkOLRiQJzaj0AFkXEC2ev5putAjk2D05ovEJppYDwitEs1mcRWaVnUM6JkxqBHZbTrjWfSMTXn9bRJDlf5XJHfVsgBQCYy2MCuqYht4HAhNKC99wkL1Z9iO95AVecxwRiXH88Y/DMwgA3y9RKWJbXXUg8Lo9EbbZFF1FFGjjSF0izgMeFkBDG+7Q+tnQjqf7/p1R66+Evn4nATHt821otN1Si4eBstUeHZ3y58ao1ZEZBElzXToZY6ITeUaN9yKvijBBkPgj6uLa5jRRDprcjPkHXNKbmxjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqvI46eLWXhkN6uhiTeBBWyMkg3nRdbYWebFTZIg7Rg=;
 b=ajeeUToigtwZNkjqh5UEN3gZr96HGceUv/J2k4BbVbOiFeirY/GX/pXPoE4nNMS82VXpLtNkMPhk6smmvQqHB5YsOhB/5dUFOD6DEcjK4NJGdVQ8YO7bLczTaH3tOjPO+sy1YKuZnsr6DLl6CPMLERZ0sDoOu+5826UQ0lpa5WWE+/hbERj0p/P9OMT4onxouyyA4Cs0hppEA16iNFBf/Fhfypo20IUTMlXrHcrDjmQQn2ChGa7lclgm9zAFfTumuM3+vDczJcFiLZ4P3jzT1dHszCEiJ6uKTcp3qMvfRCkurx50CbJ13eZmAoJXizJSNNiNBYcjMQjLUtkifjgYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqvI46eLWXhkN6uhiTeBBWyMkg3nRdbYWebFTZIg7Rg=;
 b=SAjpPzh21iyd85n/3P0fOxsBoLej4dI4+jTTLKEu29XZVyt7vosa/57O0/So8P8U8Gl64NxPkhvtS/Jw0zuiNepZZKsRQ3LluE7AilMEE8cpAkhYiiEDBH1o4bHk3lxZCVDsER/Ur1T27UUEITyXF7G4OCpHH5mfHkkCVluKeXI=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB6334.jpnprd01.prod.outlook.com (2603:1096:400:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 00:29:11 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d%9]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 00:29:11 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
Thread-Topic: [PATCH v1] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
Thread-Index: AQHYM5Y14jmZP4bIvUm8lwYXZPPhCKy3mZwAgAAiw4CAAAgugA==
Date:   Thu, 10 Mar 2022 00:29:11 +0000
Message-ID: <20220310002911.GA1580142@hori.linux.bs1.fc.nec.co.jp>
References: <20220309091449.2753904-1-naoya.horiguchi@linux.dev>
 <CAHbLzkrmHS+nPbw1YZj-rE-ECgRr2nD40d-ZbxPvf05o-rmNcA@mail.gmail.com>
 <84f27dae-43ce-f623-84ed-90ecbb3a6b0f@oracle.com>
In-Reply-To: <84f27dae-43ce-f623-84ed-90ecbb3a6b0f@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f890fc81-0dc0-471a-e9f7-08da022cff81
x-ms-traffictypediagnostic: TYCPR01MB6334:EE_
x-microsoft-antispam-prvs: <TYCPR01MB6334BE40304F9A1B435077ACE70B9@TYCPR01MB6334.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VeJKes5uwg66TmBFLWMC47hVXF9TeO1u6z2cIR+RL592StnUXnF/un6cQcohCX02duNUyZtkmJqcCFQjMU8JBuV2ZL57sQLvLCXdQF63cOuftZx08xXBa+x2U0zhwFu+1ThitI3XsuYi3RfpsBegDW1sPTMtCiEOnx3691rLCL1CK2/nvntXsgjo0qUkzrBQCtrieHG8O1ZOKBfm9n7buPhGCU/FdxM0rAi537coMOnTa7RBO6VbRMAvCzHfqKinbkKO1NFxMk39NNsWOpuhxMfNLeFbgwgLsU8x1nCaahX+tTmfHmBgmolgZvdxwHGH6dzIhz8EjAORNdnTnAAw1AatmMKU4oduQWVJdkr8fc/re/SrWSbkTzE1HbWT1smzePhQg7EdLBVfhQACeR7S51v6dLKt1VQ7cSyNB9ziRuqbWfalYZxxFzddTl1Eq7T+Zg5SSs+LzIP19Df49KgDSVKFc8W5B5O0ldLhmF7o8dCoYHaVVhkyhpew20n+pidQu+3ZpOIbNq2uvlIssZ0DqB/6ycn2nguisi27pJrza7TgxGSclNptJWJ1+3uHeUsbVqlErDZGczQYXY3vE1hHbKTmFe/BZIH23DvHop/lWU12i65cO/6KUWRxUYYEPVnCL9JZxo4gadUWNy9kQHpyD/1K5Nx7nHlyOTdmUOE6/jg/st19YgbnWGSLYV8/wJA0DHeaBz+F7e7P1q92QyBlsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(66556008)(66476007)(66446008)(64756008)(8676002)(508600001)(4326008)(5660300002)(85182001)(71200400001)(186003)(26005)(83380400001)(6506007)(76116006)(6512007)(66946007)(9686003)(53546011)(55236004)(8936002)(1076003)(86362001)(82960400001)(54906003)(6916009)(122000001)(316002)(2906002)(33656002)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d08wN2xPbDhUazZuNGU3aHdPTXI4d0hya254QVY4dTNBU005bGdmaUh5RzBM?=
 =?utf-8?B?bzg4dk8xdHdwTUEvQUVNUG5QZ2tmbUZORTdYaldZMUNNVlMvaDBaeVlLRElW?=
 =?utf-8?B?aS9udTN6bXVidEZLcGlzV2lIWWVXN3kranpFYlpndHZ5QVcyYmZybm1ZL3R2?=
 =?utf-8?B?ZmxhNGUreGJlRndJVHJUS0NQUFFlODh1VjRrNXlIdU5zelFVZ1drTnlKUUVW?=
 =?utf-8?B?cjF1Z0Fwd2t1cnpFQ1lxd2dRUHdOQ2lSQ3dxTXRPRzl5bTFJYytMSzdTS0R6?=
 =?utf-8?B?aVR6VXBEdkhGM2RIVEJQTjJmZ0VvbmhVckRjek4zWU83SUFzQzJBZGluUTY1?=
 =?utf-8?B?UUtOM01hb3Y4V0YvSjUrN2tvNlBObmRyR3loNDZYL1hnME9oUlFRU08xMUdn?=
 =?utf-8?B?TGhCcDZIWHdLTElwTkJNd0pLMGYzd1Y5bGhtSnBWMDB6RmgrLzJ0alp5VTl5?=
 =?utf-8?B?cjgya1p1YVdqdGFWaXRUdnZsYjZGSW1kWjN3Z2grV01rbjhLZ1RBaWhPYXEz?=
 =?utf-8?B?N1hERWdQaURZSmtmaDBPbXhhRG9SQkJEcXV2RUlBMlVaZjRueUhiUkNWWmdl?=
 =?utf-8?B?d1dRZVBlZ1lMUGhPQy9jNWJtYnBnSXlIL243NFZCcXd0Q2hmOVFUWmhpRkdL?=
 =?utf-8?B?cGxnTXFFWFVZMlhaL3J0SkVIbmtaVnN4cDRHaHFTVXlOMmtRU1ZpYjZsaDZ5?=
 =?utf-8?B?Tmk3WWVpN3JRWlRVS0xBelFLNkh6QkIrQlJ6WDg0dzd6WE11T1E2blZRbzBR?=
 =?utf-8?B?WEFKckRycDl4T0RPTzh1VndCVnc0Qlo2ZEF3d09DOFRmbWN2YVdmK0p2V2tt?=
 =?utf-8?B?SXNNc3VZK0o0TDcxNHNOaTdPTmNLSEpUZnY1M0hIUFFyeTZ4Vld1aU5SZXhr?=
 =?utf-8?B?OGpJanp1SldiWnQ0WlFzbFAxS2F1TzhSdVp1S05ZVkRJc3dseXhPaFkrRWhX?=
 =?utf-8?B?OE0xelFVTzJ2VVZOaWt0Wkd1b3p6bGVwdFVuOTRzcFhqdDdkS2xzTlNlUlhm?=
 =?utf-8?B?R0VSeDROOFRUTHgvdzh2dkJLNnlVb3NNQ01BODRucXF2QitsUWYyQ1RqUHB1?=
 =?utf-8?B?dFJESjhqSWFlT3BIV1RLRWpHSzJ2ZjZ3MnZsWDRCNGtZQllJOExsSThsZHRn?=
 =?utf-8?B?RW1QVGtoNFRzbzhDRXlURHpwU1hha2NlNnlLRWh0WmFHZ2lvVGFqT0RFaFJG?=
 =?utf-8?B?RlVoQ2N1aXpuYzlpdERkNENKRnhkR0xmZFNkaVFHNVRwOXJPbVRLbFNFY3da?=
 =?utf-8?B?bDFlR2E2cFhNQXYvRC9WOEdXWmRXM1J0aldpbTJMQXAyZkdsRXRndmV5NmNY?=
 =?utf-8?B?eWg3aE9ydm1iTzZ5c1lOWlE0ZUUwcGFtckk0YXFQcXhqbTA0NkNKQWVDOHJ5?=
 =?utf-8?B?SUpLUTlwZExqdjI1K1NvanNDM0YrWHowcjRzbCthU3U3R0N6WGFLbXBad3VP?=
 =?utf-8?B?NFluS2FveGNaSmd3TXZZSkFsRnU3bXpRa0ZFT25BRnQvYjFCWGtEZEZNbXdH?=
 =?utf-8?B?SjhvOVNCMmV6dXppU2p4anljM2p3eU9oditxSG9xRHFyUkdhRUdjM0NZZW9U?=
 =?utf-8?B?YnAvQks5YmpHTGUxVzMwVUF0WVg0L0JPM1pPYXB2b0hWK2ZxN3FjQ1dlQzdM?=
 =?utf-8?B?UFU1OFVYdW0yY3l2djhTY3pFcGIxb1dOVzlxV0pmdjhzSWppU3ZyR3JQd242?=
 =?utf-8?B?aThYRHFMR29jZ1J5TExzQ2tCcEF0aTNQOVRDQU9HbHphYndSZTNBckxIZmpk?=
 =?utf-8?B?Wm9uZllQc1pCd2Z1Q0ZhT0pDdHk3WE1SaTlxQlJZUGYrbGV1K1BGSWhydFdp?=
 =?utf-8?B?VGNnaW9BQ0NjUDloYVRpNE5YN1JZMmZ1T0hMSFZNMmU0MWdVeXFYanZuYWM5?=
 =?utf-8?B?ZEJRdmxWSnRZcUJod00wNno3R0o1RlZ1YVNzYUpYOE5oeUVzelVJMTdQSlA0?=
 =?utf-8?B?bCt1T0lRdTdrVTlLLzV0YWpybWsyQVBtVTR2OTZ5T0RGMlI1UmtWU1haK1VP?=
 =?utf-8?B?c2Nnc253NUhITExqMzBWRUlaY0FrMGhKbXhRTG1qUURNYmxZeDQ0S3NOSEI4?=
 =?utf-8?B?MEtaS21sUUpLN2JuL3NQRUQyUldBN0p5NFdzSnlxNnZPN2pyZndOSnpRMkxu?=
 =?utf-8?B?SHVqMXlIWUh4YUR5ZGtiU0JqdzFoaVkyRFVxM0ZyYVZqTjVGZzZlQ2toUHhW?=
 =?utf-8?Q?Si4PmyKcKwdjZ2+nNefWF3+zIFsfOJQnM94BmkiDele3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0F3119C25824E448CC5285FBC86CAB3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f890fc81-0dc0-471a-e9f7-08da022cff81
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 00:29:11.4242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YQsgIxjDIaiZSL7y6SVPOnc1F0ATDbaMIDFq3TBJCLq2XgqZkYlKKNBfuV80IIP9m4Mxc92wOHzrg9OIHr4L0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6334
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXIgMDksIDIwMjIgYXQgMDM6NTk6NTVQTSAtMDgwMCwgTWlrZSBLcmF2ZXR6IHdy
b3RlOg0KPiBPbiAzLzkvMjIgMTM6NTUsIFlhbmcgU2hpIHdyb3RlOg0KPiA+IE9uIFdlZCwgTWFy
IDksIDIwMjIgYXQgMToxNSBBTSBOYW95YSBIb3JpZ3VjaGkNCj4gPiA8bmFveWEuaG9yaWd1Y2hp
QGxpbnV4LmRldj4gd3JvdGU6DQo+ID4+DQo+ID4+IEZyb206IE5hb3lhIEhvcmlndWNoaSA8bmFv
eWEuaG9yaWd1Y2hpQG5lYy5jb20+DQo+ID4+DQo+ID4+IFRoZXJlIGlzIGEgcmFjZSBjb25kaXRp
b24gYmV0d2VlbiBtZW1vcnlfZmFpbHVyZV9odWdldGxiKCkgYW5kIGh1Z2V0bGINCj4gPj4gZnJl
ZS9kZW1vdGlvbiwgd2hpY2ggY2F1c2VzIHNldHRpbmcgUGFnZUhXUG9pc29uIGZsYWcgb24gdGhl
IHdyb25nIHBhZ2UNCj4gPj4gKHdoaWNoIHdhcyBhIGh1Z2V0bGIgd2hlbiBtZW1vcnlfZmFpbHJ1
ZSgpIHdhcyBjYWxsZWQsIGJ1dCB3YXMgcmVtb3ZlZA0KPiA+PiBvciBkZW1vdGVkIHdoZW4gbWVt
b3J5X2ZhaWx1cmVfaHVnZXRsYigpIGlzIGNhbGxlZCkuICBUaGlzIHJlc3VsdHMgaW4NCj4gPj4g
a2lsbGluZyB3cm9uZyBwcm9jZXNzZXMuICBTbyBzZXQgUGFnZUhXUG9pc29uIGZsYWcgd2l0aCBo
b2xkaW5nIHBhZ2UgbG9jaywNCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogTmFveWEgSG9yaWd1
Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBtbS9tZW1vcnkt
ZmFpbHVyZS5jIHwgMjcgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+ID4+ICAxIGZpbGUg
Y2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRp
ZmYgLS1naXQgYS9tbS9tZW1vcnktZmFpbHVyZS5jIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+
PiBpbmRleCBhYzY0OTJlMzY5NzguLmZlMjVlZWU4ZjlkNiAxMDA2NDQNCj4gPj4gLS0tIGEvbW0v
bWVtb3J5LWZhaWx1cmUuYw0KPiA+PiArKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ID4+IEBA
IC0xNDk0LDI0ICsxNDk0LDExIEBAIHN0YXRpYyBpbnQgbWVtb3J5X2ZhaWx1cmVfaHVnZXRsYih1
bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzKQ0KPiA+PiAgICAgICAgIGludCByZXM7DQo+ID4+
ICAgICAgICAgdW5zaWduZWQgbG9uZyBwYWdlX2ZsYWdzOw0KPiA+Pg0KPiA+PiAtICAgICAgIGlm
IChUZXN0U2V0UGFnZUhXUG9pc29uKGhlYWQpKSB7DQo+ID4+IC0gICAgICAgICAgICAgICBwcl9l
cnIoIk1lbW9yeSBmYWlsdXJlOiAlI2x4OiBhbHJlYWR5IGhhcmR3YXJlIHBvaXNvbmVkXG4iLA0K
PiA+PiAtICAgICAgICAgICAgICAgICAgICAgIHBmbik7DQo+ID4+IC0gICAgICAgICAgICAgICBy
ZXMgPSAtRUhXUE9JU09OOw0KPiA+PiAtICAgICAgICAgICAgICAgaWYgKGZsYWdzICYgTUZfQUNU
SU9OX1JFUVVJUkVEKQ0KPiA+PiAtICAgICAgICAgICAgICAgICAgICAgICByZXMgPSBraWxsX2Fj
Y2Vzc2luZ19wcm9jZXNzKGN1cnJlbnQsIHBhZ2VfdG9fcGZuKGhlYWQpLCBmbGFncyk7DQo+ID4+
IC0gICAgICAgICAgICAgICByZXR1cm4gcmVzOw0KPiA+PiAtICAgICAgIH0NCj4gPj4gLQ0KPiA+
PiAtICAgICAgIG51bV9wb2lzb25lZF9wYWdlc19pbmMoKTsNCj4gPj4gLQ0KPiA+PiAgICAgICAg
IGlmICghKGZsYWdzICYgTUZfQ09VTlRfSU5DUkVBU0VEKSkgew0KPiA+PiAgICAgICAgICAgICAg
ICAgcmVzID0gZ2V0X2h3cG9pc29uX3BhZ2UocCwgZmxhZ3MpOw0KPiA+IA0KPiA+IEknbSBub3Qg
YW4gZXhwZXJ0IG9mIGh1Z2V0bGIsIEkgbWF5IGJlIHdyb25nLiBJJ20gd29uZGVyaW5nIGhvdyB0
aGlzDQo+ID4gY291bGQgc29sdmUgdGhlIHJhY2U/IElzIHRoZSBiZWxvdyByYWNlIHN0aWxsIHBv
c3NpYmxlPw0KPiA+IA0KPiA+IF9fZ2V0X2h3cG9pc29uX3BhZ2UoKQ0KPiA+ICAgaGVhZCA9IGNv
bXBvdW5kX2hlYWQocGFnZSkNCj4gPiANCj4gPiBodWdldGxiIGRlbW90aW9uICgxRyAtLT4gMk0p
DQo+ID4gICBnZXRfaHdwb2lzb25faHVnZV9wYWdlKGhlYWQsICZodWdldGxiKTsNCj4gPiANCj4g
PiANCj4gPiBUaGVuIHRoZSBoZWFkIG1heSBwb2ludCB0byBhIDJNIHBhZ2UsIGJ1dCB0aGUgaHdw
b2lzb25lZCBzdWJwYWdlIGlzDQo+ID4gbm90IGluIHRoYXQgMk0gcmFuZ2U/DQo+IA0KPiBUaGF0
IGlzIGNvcnJlY3QuDQo+IA0KPiBJdCBpcyBhbHNvIHBvc3NpYmxlIHRoYXQgX19mcmVlX3BhZ2Vz
KHBhZ2UsIGh1Z2VfcGFnZV9vcmRlcihoKSkgY291bGQgaGF2ZQ0KPiBiZWVuIGNhbGxlZCBkdXJp
bmcgdGhpcyB3aW5kb3cuICBTbyBJSVVDLCBoZWFkIHdvdWxkIGhhdmUgYW4gaW5jcmVhc2VkIHJl
Zg0KPiBjb3VudCBhbmQgcGFnZXMgd291bGQgYmUgZnJlZWQgdG8gYnVkZHkgd2hlbiB0aGUgbWVt
b3J5IGVycm9yIGNvZGUgZHJvcHMgdGhlDQo+IHJlZi4gIEF0IHRoYXQgdGltZSwgaGVhZCB3b3Vs
ZCBiZSBtYXJrZWQgYXMgcG9pc29uZWQgd2hpY2ggY291bGQgYmUgZGlmZmVyZW50DQo+IHRoYW4g
YWN0dWFsIHBhZ2Ugd2l0aCBwb2lzb24uDQo+IA0KPiBBbiBpbmNyZWFzZWQgcmVmIGNvdW50LCBv
ciBwYWdlIGxvY2sgd2lsbCBub3QgcHJldmVudCBodWdldGxiIHBhZ2UgZGVtb3Rpb24NCj4gb3Ig
KGF0dGVtcHRpbmcpIHRvIGZyZWUgdG8gYnVkZHkgdG9kYXkuDQoNClNvcnJ5LCBJIG1pc3JlYWQg
dGhlIGFib3ZlIHJhY2UgaW4gbXkgcHJldmlvdXMgZW1haWwuIEkgcmV0aGluayBiZXR0ZXINCnNv
bHV0aW9uIHRvIGNvdmVyIHRoaXMuDQoNCj4gDQo+IFRoZXJlIGlzIGFscmVhZHkgYSBwYXRjaCBp
biBBbmRyZXcncyB0cmVlIHRvIG5vdCBkZW1vdGUgaHVnZXRsYiBwYWdlcyBtYXJrZWQNCj4gd2l0
aCBwb2lzb24uICBUaGlzIGF0IGxlYXN0IG1ha2VzIHRoZSBkZW1vdGUgY29kZSBwZXJmb3JtIHRo
ZSBzYW1lIGNoZWNrIGFzDQo+IGFsbG9jYXRpb24gY29kZS4gIFRoZSByYWNlIHdoaWNoIHN0YXJ0
ZWQgdGhpcyBkaXNjdXNzaW9uIGhhcyBiZWVuIHRoZXJlIGZvcg0KPiBhIHdoaWxlLiAgZGVtb3Rp
b24gb3BlbmVkIGFub3RoZXIgd2luZG93LCBidXQgdGhhdCBpcyBub3cgY2xvc2VkLg0KPiANCj4g
SU1PLCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gdGFrZSBhIHN0ZXAgYmFjayBhbmQgbG9vayBhdCB0
aGUgb3ZlcmFsbCBkZXNpZ24NCj4gYW5kIGRlY2lkZSBob3cgdG8gcHJvY2VlZC4gIFRoZXJlIGlz
IGFsc28gYW4gZWZmb3J0IHVuZGVyd2F5IHRvIHByb3ZpZGUgZG91YmxlDQo+IG1hcHBpbmcgb2Yg
aHVnZXRsYiBwYWdlcywgYW5kIG9uZSBvZiB0aGUgdGFyZ2V0IHVzZSBjYXNlcyBpcyBtZW1vcnkg
ZXJyb3INCj4gaGFuZGxpbmcuICBUaGlzIGVmZm9ydCBpcyBpbiB0aGUgdmVyeSBlYXJseSBzdGFn
ZXMsIGJ1dCBpdCB3aWxsIGNlcnRhaW5seQ0KPiByZXF1aXJlIHNldHRpbmcgcG9pc29uIG9uIHRo
ZSAoc3ViLSlwYWdlIHdpdGggYWN0dWFsIGVycm9yIHJhdGhlciB0aGFuDQo+IGhlYWQgcGFnZS4N
Cg0KU29tZW9uZSBtZW50aW9uZWQgdGhlIHNpbWlsYXIgcG9pbnQgd2hlbiBkaXNjdXNzaW5nICJm
cmVlaW5nIHZtZW1tYXAgcGFnZXMNCmZvciBodWdldGxiIiAgcGF0Y2hzZXQsIGFuZCB0aGVyZSB3
YXMgYW4gaWRlYSB0aGF0IGFjdHVhbCBlcnJvciBwYWdlIGlzDQpzdG9yZWQgaW4gcHJpdmF0ZSBm
aWVsZCBpbiB0aGUgZmlyc3QgdGFpbCBwYWdlIGluc3RlYWQgb2YgdXNpbmcgUEdfaHdwb2lzb24N
Cm9uIHJhdyBzdWJwYWdlcy4gIFRoYXQgc291bmRzIGdvb2QgdG8gbWUuDQoNCj4gUGVyaGFwcyBz
b21ldGhpbmcgbGlrZSB3aGF0IGlzIGRvbmUgZm9yIFRIUCB0b2RheS4gIE5vdGhpbmcgdG8NCj4g
YWRkcmVzcyB5ZXQsIGJ1dCBJIGp1c3Qgd2FudGVkIHRvIG5vdGUgdGhlcmUgd2lsbCBiZSBmdXR1
cmUgY2hhbmdlcyBpbiB0aGlzDQo+IGFyZWEuDQoNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnQuDQoN
Ci0gTmFveWEgSG9yaWd1Y2hp
