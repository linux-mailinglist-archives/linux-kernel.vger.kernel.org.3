Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA56B59F370
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbiHXGKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbiHXGKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:10:36 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120074.outbound.protection.outlook.com [40.107.12.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0D012ACB
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBHKZboTgkktK3ACBQpWjQ/wxTDLX0HAWx5cwmgcjK0b/LYQO/GB6hNEwaKKSXzL596EVgceL4DOFJ0nJSf29lrZWPS756A1zmeoa/JOJ/HQQhfy185n8+9Z7OXEPBny2P5fL/j6Mzg7+iUXc8SfE/MHNh4prjGpSLTw29RSXFwP6MYkQfJtgzOHoEQlXYsjhjIB1GJd1L0GcQIr0+AP2Ea1og4Te01QJFVKTxzqa5OpwuVMPdlZL2W2fAj6+yHAhi2GxPHBTw3WomL5bpmauNAGQwrnntzETog5jkc4P7bc2gr0ewq5t11RNNnogTXD3g88EGpNQ6efjcxxsS1hSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0vIpnmx+1WLS5KiI0N5hhneCRQGVWDFqIL+/649D0o=;
 b=UZVEv74LvK/SWIdCCjyqsMUSKrtZvvB8+Q8QE16nNdbi9u3suDLqjS9XDf0XKINBP9OZkYiNhiOevHHCOvD08DpnbULaDO1bRJe4u6k3JMWPdMJiiO9OCKjw2J2RihL0xJIDnrqfEKvHaqQLPW5JZ6wCCvFXB9IfbhX0JoYjsCTihy+a7hPpyAaaws2qFsx2PsU9GXCjIMxiYMwkgd2DGwlQWPhKA5qgHNHub7y9TQMbKGBYy6Os+AcSUHNLwNjEe7OhNgv+R9mR6VwgNDZmay6DGEw3cB2xU05h0XsyD2eSdRP3cODp60+xOBL/qBUpMNdtmLxkGGmBjCxpdrcQKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0vIpnmx+1WLS5KiI0N5hhneCRQGVWDFqIL+/649D0o=;
 b=jdZglbBpoTh2a1btIMBnBup6F3HpJ575jgGaIHdJw4NUQHrFylNFS6Jpddvo7v8wPmghKpE28Bmkr0h87cseydb9d8fFcmRhkNL8Y1vDUYkiGYmNvWxpl0eBdqgm9i3XUstbKVY61nywUJW+bo8IrGmiZp2KqwHc14yogx4B6VeyTC+yFNTxHD7+U/C4StALGgGr17FwEZ5CVPYBFnxncOrs/PajXEI1wekh8ETKcjVvMtQp+/W4qUQj0V2z7QPLblFu2pjkM3VuJu/eXNvBgVUhJ9X7sdaqYkYNZxB2Lp6u2VrWCC0Ncu7Rw/sY7hkXiJWBWZ5pupqeypQB+4FMeg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2387.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:34::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 06:10:31 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 06:10:31 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH linux-next] mm: fix used but uninitialized variable
Thread-Topic: [PATCH linux-next] mm: fix used but uninitialized variable
Thread-Index: AQHYt35XzsFKpFb3eUu3rI9AKkOHmq29kW8A
Date:   Wed, 24 Aug 2022 06:10:30 +0000
Message-ID: <8d8bfc81-b584-20f4-65ae-d626f019cdf4@csgroup.eu>
References: <20220824055637.10676-1-zhouzhouyi@gmail.com>
In-Reply-To: <20220824055637.10676-1-zhouzhouyi@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82c63b1c-d0f8-4926-9af9-08da85975941
x-ms-traffictypediagnostic: MR1P264MB2387:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2MIjk1UHH0roTIXDpPR5je7V1nXKkkqwcQ4/h/+k2l6Obme5KqgjuXVsaaPqdwCEVgPPbx8viDb1W1xcxrYejh5/qWyKhmq+/kNRcQFaDPr1gJrHcG0NQC4G1wXbCI/AuFTpOfmZCw2y1DBhp197T+zZdNozt37u1LwuWQjIwwy3WMNOY9YN+coW7SpKu8io3URsSZt6FkHNejckgs13Iz5+sYYTpPnbd3jbfCci3+mOcicpcArZpDjH5xZ9MC+/XJjuTKjm3WwWY/lBBKjM9yDzXXsBRHlVM7FCIxs87IsfVEBy2+AiHDVKGnBtIdx4XdyW7TFUImmn2O8IPSaa17cCFr/+M55bPaEL5I+xOk89T9wEPaPhd1hkKsqLxlDGbrMkmJrGT45FX/SGfpckE6RI+nJTiUYZVEzeGSKg09XOJ5Fw35JsaEsr5vqoTDfQbgrjOuEVqATx0TZhDRc8240DJ2NmrZVLnf7Ts2KAkorXJzlZsUJbiSfMzEmdEQlC7QJzqSCnbStbsNRhWiemvzmOPy8tLXUkGGNZBRmsnkBhvsS/gkI5KzbHT8M/qWSBAl/rlWMLEc1hPIVHEMrDMvVaQojUql1WJiWjMIdyh43GzvZnngDdVzUw5w8CpcIorrJrBbeVMt6211IyVeWs54pgxSn/W2kA6UldaNvh8i7s+mwAsinF69Vz8py93zB82Fd1Red3Q3biJs+kcM8+5rAyw3haNJvoOPJjVGsG4OHZ+z0U6pLf1r8bPze8xOmW0sxxb8o5yrE8Vbegs4gqPxo62aGDY5E6I9fFaykZCML+seMt1cvDIK5VP82WKO7WBeQ4yJCQQmwN3ZBj0g8g5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(346002)(376002)(136003)(366004)(396003)(38070700005)(122000001)(6506007)(83380400001)(2906002)(31686004)(38100700002)(36756003)(110136005)(316002)(71200400001)(8676002)(44832011)(5660300002)(41300700001)(8936002)(26005)(66574015)(2616005)(186003)(31696002)(66946007)(6486002)(66476007)(64756008)(66556008)(478600001)(76116006)(86362001)(66446008)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjdpS0lwNUpDVGdYT01WQkxUOFEybWRmOCtvVU5TdVpJb0RGdVRDUUZWeDRv?=
 =?utf-8?B?V2cwTUVUU3ExY2FEM1g2K3IrY0dxMXF6Z3FCaVpJa1FiTG1mOG5yRUY5TTUz?=
 =?utf-8?B?L2tnNEpGQ1V1NG4yNjc1R1NldnRtell0RlRsNWJzMU5odXZFMDZaNG5NMFBI?=
 =?utf-8?B?K0VOWnZWdHpybGFUcUNWYW5QU0VTY0pxa1puczhsK2ZKRTRTd3g3RkN0NFlC?=
 =?utf-8?B?eFBhMTdyQWhBTHJMV1FURG8rNHdic0JObERTZDBXZXdSRGhmTDhodEhoUWY0?=
 =?utf-8?B?dmlFUGFSVlBIQzdoNGpzLzNneUlGN25qS0NmRVZaRlB6d2VWSk8vL3VQY00y?=
 =?utf-8?B?dFp4MHNlRDBHcjY3bGJPaHRxaW5wQmE1Zmo1czlKVW5KTFVmWTRxMVJ3R0Nh?=
 =?utf-8?B?TXZOUkg2cmh2YlZUeTFTNGJXaUs2OGJ4RE40Q0oyWEV2NXUzK1QrMGt1cFFv?=
 =?utf-8?B?b2xwZ2owMVFuOFVic1VVQjJ2OEozaHpkN1JhVERHWGt2S3IwMFpPbit5UVhV?=
 =?utf-8?B?OUozcm0rQXlBNUZmcDVuaWVCWGJEaktkdlQvUTdadjkwUG5Fd1czL1QwdjR5?=
 =?utf-8?B?dXpsMi9ZUEkwN0RXL09JR0dUc3dVUE5mYWZuZEhBN0dLdzZRbE0zbFlVNkhR?=
 =?utf-8?B?anhxbTQ0MGh0WUNEQmVYU3ZXdHgwdEdja1FWc2p5MEhBZXRmWWlNQ2xWeTYr?=
 =?utf-8?B?VXdDR01xUnVwM2tKNEhWL3BCMHV2T0JaOTA5MzU0STBNQUo2MjVYSU9WQkVl?=
 =?utf-8?B?RExsTDYrRHREdHV0czZSNFB5WW1WalNackk0VlFuTFFpRm8rdWcvM2hnVDZ5?=
 =?utf-8?B?NlpjdjIyRVVNU2N0TmdnQ1cwSDJUbUg0WHZCZkpqbU9VZ2taVVBtbzZxS0pr?=
 =?utf-8?B?L0dqMmI0blhhcmVGTUlGdlpoZkdxYWRGWkJ4NDlqd01mQVE4YjBmZEZob1F5?=
 =?utf-8?B?SWlkSEc3MzdsdTY5Z1AzcDNmL2RnVVg2Qk5YYUg4S1RoVmxSek1ubk5wam13?=
 =?utf-8?B?QjQ1MzBjSVdpbHVRZDlRQ0Z3TlVRa2cxVnV1K2Y2cld3dW9lNUdmeTlHclJH?=
 =?utf-8?B?RnN6ajRzOFRGTWtJdHRnRmJiSHhKYnp0SFROT0R2dFQvUi9vUjJwZFpieGhT?=
 =?utf-8?B?aXl2YXdkcTZkaGpiM2VTMCtRN3pZZE1IL1JFL2kyNDVUSDV4dGxPTytZV0Zj?=
 =?utf-8?B?MkpOS3pCU0hLaVJ6SzhhUlRDaHplLzdmRE1BeXllRHFMRzh4L0pubGZTUUNr?=
 =?utf-8?B?K3c0b1plclAvMkc4bDdFK21xVld4RUtmYXhId3VMNkpNbTNZMysvZ3kwR0sz?=
 =?utf-8?B?VDVDeE5lNENFZFpGcU5vYXRVQXlXSlZXSDVKbkFaSHhDNFIrU1Voc2Z3UHRQ?=
 =?utf-8?B?bDlZcTNkU3hYM0FVZzdldkpqMk9QVytEUDdUOHR1Tlp5THVKRUthQW5qTGhP?=
 =?utf-8?B?cHFubzN2YUt3YTlYTGJseVQ1SFRNVVhqTzJBR3R4L3lUdnk4dUFqSlBQR3NE?=
 =?utf-8?B?emM0M05vSjRFSFhwQncrTm5XKzREZm14b3RiZ2VsOW1HMWtjSlUyQ0RjQXZ3?=
 =?utf-8?B?WGI5Nmc1V2NqUEFDUGRia0Y5ZU9wVWhnOEFMUlVWQkcvRGRGaXdMTXc5QitW?=
 =?utf-8?B?Zis3cS9jelJRL3pnRW1vaU16dy9oZDBRbEMybWpkTFBNMkN3WjAxcVpZdkxs?=
 =?utf-8?B?VVNoYTljSC9UdjlvVUJheEhHRDQzaTB6b2ppWURQRFJJQ3ZHMHVDSm9tS3pz?=
 =?utf-8?B?amQ5NDJzbGNzVEVaL1ZOWFFrOWJOSnRCaGRseUNZV3duVnpKSmxwMGZDUkRK?=
 =?utf-8?B?d2w3d1grV0YxM1pMSEFCMThDSGZoK0k5TnFhQkVHL1BDU0NaL1NqNm1tVEpn?=
 =?utf-8?B?U3pXWHNpSWFYZDduL0E5MVg1UXlMYW9yUjhTOWd6QVhnZ2Y2a1Nwa3ZnellU?=
 =?utf-8?B?c2tzRWl4Vkl5TjZqNnJrYWJtem01TWNTM3FXMDNHTmUyakw4YVNuUjVBT3p5?=
 =?utf-8?B?OXRmQi9KZWtiS1o3QW82T1FiVnhOeWltcWtzTXl1WTZpcFVrRlR5YjROYldI?=
 =?utf-8?B?TENyVXB3SEs1aGp6OFQyOHgxSURiUW1SSEVubmF6OENpUmpkRlh5amRVMnRr?=
 =?utf-8?B?M2g5RVdHQUxkYWxIc0JvZ3g0c1hqbFpCN3FEOWo5dnc3djBLUktFZzVpNE43?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C25B062C5678D143BF7BE5EBA1DC874E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c63b1c-d0f8-4926-9af9-08da85975941
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 06:10:31.0218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0APK/p6Bgj3OaBiMdz4U+w8Gjbuj9jTeTRNmCsxgyVSrXogJneJVj2JfY0MjXxMopHwBzFkFlJScuKW53nh8DPugJbO3IVIwnxe6It2U+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2387
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI0LzA4LzIwMjIgw6AgMDc6NTYsIFpob3V5aSBaaG91IGEgw6ljcml0wqA6DQo+IElu
IGZ1bmN0aW9uIHdhbGtfaHVnZXRsYl9yYW5nZSwgdGhlIGxvY2FsIHZhcmlhYmxlIGVyciBtYXkN
Cj4gYmUgdXNlZCB1bmluaXRpYWx6ZWQgd2hlbjoNCj4gb3BzLT5wdGVfaG9sZSBpbiBzaWRlIG9m
ICJlbHNlIGlmIChvcHMtPnB0ZV9ob2xlKSIgaXMgZmFsc2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBaaG91eWkgWmhvdSA8emhvdXpob3V5aUBnbWFpbC5jb20+DQo+IC0tLQ0KPiBEZWFyIG1tIERl
dmVsb3BlcnM6DQo+IA0KPiBXaGVuIEkgYnVpbGQga2VybmVsIHVzaW5nICJtYWtlIENDPWNsYW5n
LTE0Ig0KPiB0aGUgY29tcGlsZXIgY29tcGxhaW5zIGZvbGxvd2luZzoNCj4gDQo+IENDICAgICAg
bW0vcGFnZXdhbGsubw0KPiBtbS9wYWdld2Fsay5jOjMxODoxMjogZXJyb3I6IHZhcmlhYmxlICdl
cnInIGlzIHVzZWQgdW5pbml0aWFsaXplZCB3aGVuZXZlciAnaWYnIGNvbmRpdGlvbiBpcyBmYWxz
ZSBbLVdlcnJvciwtV3NvbWV0aW1lcy11bmluaXRpYWxpemVkXQ0KPiAgICAgICAgICAgICAgICAg
IGVsc2UgaWYgKG9wcy0+cHRlX2hvbGUpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+
fn5+fn5+fn5+fg0KPiBtbS9wYWdld2Fsay5jOjMyMTo3OiBub3RlOiB1bmluaXRpYWxpemVkIHVz
ZSBvY2N1cnMgaGVyZQ0KPiAgICAgICAgICAgICAgICAgIGlmIChlcnIpDQo+ICAgICAgICAgICAg
ICAgICAgICAgIF5+fg0KPiBtbS9wYWdld2Fsay5jOjMxODo4OiBub3RlOiByZW1vdmUgdGhlICdp
ZicgaWYgaXRzIGNvbmRpdGlvbiBpcyBhbHdheXMgdHJ1ZQ0KPiAgICAgICAgICAgICAgICAgIGVs
c2UgaWYgKG9wcy0+cHRlX2hvbGUpDQo+ICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+
fn5+fn5+fn4NCj4gbW0vcGFnZXdhbGsuYzozMTE6MTA6IG5vdGU6IGluaXRpYWxpemUgdGhlIHZh
cmlhYmxlICdlcnInIHRvIHNpbGVuY2UgdGhpcyB3YXJuaW5nDQo+ICAgICAgICAgICAgICAgICAg
aW50IGVycjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgPSAwDQo+IDEgZXJyb3IgZ2VuZXJhdGVkLg0KPiBtYWtlWzFdOiAqKiogW3Njcmlw
dHMvTWFrZWZpbGUuYnVpbGQ6MjUwOiBtbS9wYWdld2Fsay5vXSBFcnJvciAxDQo+IG1ha2U6ICoq
KiBbTWFrZWZpbGU6MjAwNjogbW1dIEVycm9yIDINCj4gDQo+IEkgaW5pdGlhbGl6ZSB0aGF0IHZh
cmlhYmxlIG91dHNpZGUgb2YgdGhlIGZvciBsb29wIGJlY2F1c2Ugd2UgY2FuIGFzc2lnbiAwIHRv
IGVycg0KPiBvbmx5IG9uY2UgaW4gdGhpcyBmdW5jdGlvbi4NCj4gDQo+IEFmdGVyIG15IGZpeCwg
SSBjYW4gY29tcGlsZSB0aGUga2VybmVsLg0KPiANCj4gTWFueSBUaGFua3MNCj4gWmhvdXlpDQo+
IC0tDQo+ICAgbW0vcGFnZXdhbGsuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tbS9wYWdld2Fsay5j
IGIvbW0vcGFnZXdhbGsuYw0KPiBpbmRleCA1NGIyYTFiZWVlYjMuLmI2ZWIzMzBlOGVjZCAxMDA2
NDQNCj4gLS0tIGEvbW0vcGFnZXdhbGsuYw0KPiArKysgYi9tbS9wYWdld2Fsay5jDQo+IEBAIC0z
MDYsOSArMzA2LDkgQEAgc3RhdGljIGludCB3YWxrX2h1Z2V0bGJfcmFuZ2UodW5zaWduZWQgbG9u
ZyBhZGRyLCB1bnNpZ25lZCBsb25nIGVuZCwNCj4gICAJdW5zaWduZWQgbG9uZyBobWFzayA9IGh1
Z2VfcGFnZV9tYXNrKGgpOw0KPiAgIAl1bnNpZ25lZCBsb25nIHN6ID0gaHVnZV9wYWdlX3NpemUo
aCk7DQo+ICAgCWNvbnN0IHN0cnVjdCBtbV93YWxrX29wcyAqb3BzID0gd2Fsay0+b3BzOw0KPiAr
CWludCBlcnIgPSAwOw0KDQpXaHkgZG8geW91IG1vdmUgaXQgYmFjayBvdXRzaWRlIG9mIHRoZSBm
b3IgbG9vcCBhbGx0aG91Z2ggaXQgaXMgDQpleGNsdXNpdmVseSB1c2VkIGluc2lkZSB0aGUgbG9v
cCA/DQoNCj4gICANCj4gICAJZm9yICg7IGFkZHIgPCBlbmQ7IGFkZHIgPSBuZXh0KSB7DQo+IC0J
CWludCBlcnI7DQoNCkFub3RoZXIgc29sdXRpb24gd291bGQgYmUgdG8gYWRkIGFuIGV4cGxpY2l0
IGVsc2UsIHNldHRpbmcgZXJyID0gMCBpbiANCnRoZSBpZi9lbHNlIGlmIHNlcXVlbmNlLg0KDQo+
ICAgCQlwdGVfdCAqcHRlID0gaHVnZV9wdGVfb2Zmc2V0KHdhbGstPm1tLCBhZGRyICYgaG1hc2ss
IHN6KTsNCj4gICANCj4gICAJCW5leHQgPSBodWdldGxiX2VudHJ5X2VuZChoLCBhZGRyLCBlbmQp
Ow==
