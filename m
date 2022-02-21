Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC02A4BD31E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 02:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245413AbiBUBc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 20:32:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbiBUBcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 20:32:54 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2058.outbound.protection.outlook.com [40.107.114.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E536260
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 17:32:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUBS3NcPSDjoIROwBF9wMJpuyEfcQYWgjv8MvTZpnseDBJhHPD6G7Xn/kWQTdjoLybksZm3tUKV4rQLvFAFGLrb2vkFwVLvxkuSIZnZvYrhy9vTBU9Q+imzdFuNN37eUfPmXMjzaDG3hGRFYFWExiSb4QdlLyZw42MP1cakXEOv5VYX0M0Qebao37sKrqSlIfZp/kh7Bg88zR5wV+2NxCVTt26wKdjBzoROvXiUv9Ki139IztR62EQryI3Xb1w+du3It+lLD0aZ1lKWFffgYBirg6McFZ/YzVb8bDZeBXAwzuis30pmriJGF8mfBXCrvnveuotVCZ+Ac1sh5w4CSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWtxD7YlGtREikh+HtTKaEBBf0+2UsIrKzs5q8NgsmU=;
 b=EZd2LrI7YwyvnwgeRRUFqsYW3vQJGmoLcSFnaGmeof+MAstvFESubJ5+z2xh5CepCHt8P7ckjaZaVpMiURtqB5ErxCcV6PE8NA2mI3OC4U+hgjSoEIPTuiId9D7zhfbcPtBVCacRoU3Xxo6Q11cPvvaeKDGymkwLqAi2Sc7nRVXmicHmYF+BSAAnwZtXNXKq3rnuqLTL0RfZsqpVoxg9h+vCE4NtyMX/VPOssX9edbnw3RdMPaqr8Z+MRct8IT3XcPkyEp13hX7yvG7578bpg5xW/uFUpZW1ysbEkxSPFVnMeNQ+Z/mg4xWhmTtQpA4kk1FnB5A9+9/RVUBlrr2uPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWtxD7YlGtREikh+HtTKaEBBf0+2UsIrKzs5q8NgsmU=;
 b=gaqfruXPdInjKcfYN0VFG9DJdqrGiGPnzHaJUC5jhucIaAZbkOhOwmy5fBZ2B8RaTYGsQ40srHzlbb8X61t5FmWe1nqQoHh7DtnUgpF1Op0zdPpJ8sPoTJpyI3tArZgwY2IWf15qmftYTjkGpJfKeVpW3XckXZoSiScPaQWl02w=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB3191.jpnprd01.prod.outlook.com (2603:1096:604:16::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.18; Mon, 21 Feb
 2022 01:32:30 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 01:32:30 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     luofei <luofei@unicloud.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] hw/poison: Add in-use hugepage hwpoison filter
 judgement
Thread-Topic: [PATCH v3 2/2] hw/poison: Add in-use hugepage hwpoison filter
 judgement
Thread-Index: AQHYJKwkVU0GJj2Wl0WLfUxlGeHKwqydPG8A
Date:   Mon, 21 Feb 2022 01:32:30 +0000
Message-ID: <20220221013230.GA4000411@hori.linux.bs1.fc.nec.co.jp>
References: <20220218094242.2056346-1-luofei@unicloud.com>
In-Reply-To: <20220218094242.2056346-1-luofei@unicloud.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5caf372-1660-44a0-3e66-08d9f4da06e7
x-ms-traffictypediagnostic: OSBPR01MB3191:EE_
x-microsoft-antispam-prvs: <OSBPR01MB3191FDDC87C6A7CB4E2A0A5BE73A9@OSBPR01MB3191.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jY+Vosg/+lW8wjg9vmsv/r34m1xloMeg74G35+s3OGpjSw0iNEqP4vhxl7737gjb4IdLWssEZRSDGVsGgyzajbZdRDW840EFF/lOv5QjBHcV9zJ7QEFr3DRrIWbakE6IVGT+8PS17yQuGORDMVtdLgyCppzH7oaavVLDKgf6CYGmV+Ckm6LEm/dTj/FO0d53pmwExw/w9mjHHJJ3UzXc30PyPOFoA9vT507npcrA6ZJhoMRLNDeJnzyblK0NEq86m1UuLCAlnuW1/uoveI7SEBup6EEVVnzjeJmeRT1+B63pa6Ocx4ijAziWlrbVpzkAcHSQgAsE8DRStc+7TtbEuvvwO7884csY5g4ZJpPaLHH3y5LLFnySI2fnu52gBwtLCLJ0GIGwjQRhWfj7+NFGOa6OWAdaZmzxRKfkqwDi+1DPTTgVzBkdYMM3BvN5/VSX7paGYiaxdCPug2vbezkBQQcnBeX2hQPs31mNC/NLc8je9nl6oUGVHwQhRUPSbD6jfPUbqjI07Putg1XL1JVAppVCbjgMbj9LWRCt1U85ZmudEMQvFy6gKn26b3C96nRKWi9aqJITSqh+NBT5BigjPaD1R8J8HJ4YumRFr2T71P5dWcO49d+R0e10M/gikBLick2tBAFzSXjcRtp8m8F33FDGG34k+HHrdm0t52p3Un4DVcsiMd7ksYry2OVMjQc65/4OTUFWDYh3cjXuKKGhsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(38070700005)(38100700002)(83380400001)(5660300002)(85182001)(2906002)(8936002)(33656002)(6916009)(54906003)(66476007)(8676002)(64756008)(66446008)(6486002)(6506007)(55236004)(186003)(26005)(66946007)(9686003)(66556008)(76116006)(6512007)(1076003)(122000001)(82960400001)(71200400001)(316002)(508600001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEQ5Z2FRQ0pQWGRvcVJMZkVJNys1Q09CN2d0UXRTYVBiVXNSNmptTFgzL1NV?=
 =?utf-8?B?NVBqWnVPdTlZZCtSRTd1eVBMNUNSMTJsRUc4MTRoRTk4ZDkxUkRZcnlxc1Nn?=
 =?utf-8?B?OFh0aklOcjZBWXYyNkw3cDg3OGhSMG5XejczcnBRUFVLckx0RWpzUUIvbUxh?=
 =?utf-8?B?NVpGRHkyL3pXRnd6bjMzSkh2YjQxajNSbWtZOWlPem05d0szcTVSWERvRVZu?=
 =?utf-8?B?N1M1ajhnUm9oVmxXYlpPMGdmYTAxa1laNXhsLzIrUjdqSHJBdTMrdFI1QVIy?=
 =?utf-8?B?RFVEekgvbm56Zi92RHpTejdKN01IaGUrM050bFZtT2F5OThXUmtsQ2RmQXpM?=
 =?utf-8?B?WU4ydXVEdHBKS0VVWXNuS0RBWjhwWmN6V1RZbTZMRkpOS1N3KzZULzVGbmlU?=
 =?utf-8?B?Q1ViODk5L0hCZk5JRHprTGFPZXRHdnBGQTNKUHcwalRuNUR1VXNFQ0dyZTFT?=
 =?utf-8?B?WkNTMWpqOXBFR1lza1FyTmVmeHpnMUpZS2hvVGJ6bUlZNjFLeHpkZWZZWmJx?=
 =?utf-8?B?TXJRZWtZc3lkcnI3VS9mc2gxRkN1eG56enBEb3FIMWsyT1Y3OXJ6eGVjeXo4?=
 =?utf-8?B?SmN1anhqK0dXTEZ0aERZa2lxNFl6SkJpY1F2Ti9XV0YvY0locE9NS01pQW9y?=
 =?utf-8?B?YW1FaE5QOTEwN1ZoSVUvWCs2N3hETmlpNEtaL3IrQmxsWGpLRXNWTjBlOHpx?=
 =?utf-8?B?YmdySXAzMVV4Q0JldnZlSERHdjJ5N2tvODBUTmNMVklFSVhDODNqVTBnU3Mv?=
 =?utf-8?B?TWpuUVpCeGhyKzJReEVQcDBCbWYyQjVNeFpVU2xNcFRScThqR3FKUWtLME1z?=
 =?utf-8?B?bGxhR1FtZENtVW9lM0lGaDNmWnk0ZFlGdTd0eHhtNWJOVk5DWXNNUjNlQzlk?=
 =?utf-8?B?YWwvN01YOWsvVmNFSGw4Q09OT0Uxa2lVUjhOVHJ1aWsxbURHdGJEOTlqU2tH?=
 =?utf-8?B?NFVQM0xKdHNieXJ4SFU5b1ZmUW55MTB1ZWxtWGJZejRGeFI2amltRFZHVktz?=
 =?utf-8?B?N3p3RFg2WS9zVUo5ZUZxdktjMUd4SHRGM0g2azBzL1Rid0xKQnAwNDFSOGV1?=
 =?utf-8?B?N1ZYUlFiZ2hqMkdzWExIRHB5a0NLK2c4YlFYeGpSVFJGa2dneU5Eenorckxo?=
 =?utf-8?B?emp0K1BmbE9FQlZ0UkZ5UGxBd1F6NW1QaXZma21YTGNUZTlnMDdWLysrRVBn?=
 =?utf-8?B?YWNkb3F2ME1oN3dJRUpvY0dXOEVseFJ6QTJ2d3JIRFl4dGsrLzg1NW0xc29x?=
 =?utf-8?B?QWFEaFhiellnU3VJaWdHcUhXa21zVTBYOFUrN3gvNEFzU0RwYjJzWEcra2dG?=
 =?utf-8?B?NGw0SGRXQmpCV1l5VjREd1hIMTRWMkhKNmtKTXR6S3dOWFhmMlRyRXZCY2xK?=
 =?utf-8?B?SEIwUURtYlp3cFJZWHNuQXduZjQ1cDBjZXpkU0dTVU5yTVpIbWpaNEI2Q0hu?=
 =?utf-8?B?b3pPQUpqd28zVWp0elJrR2Z5ZEtFcVYyR2hLTW1Ra1dqV285eVlUM0NJMG1x?=
 =?utf-8?B?Z1VNQzI5RmVJcEpKK3A1WU9EUDhLbFh5Q0wvalczaFFBTnhmaUEzeWdZSlo3?=
 =?utf-8?B?Sm1PWkxVWE9LKzZVWENnOXlvbFJpS25yNXZvU1lIRHB3Qmxqay9QUDZybDVu?=
 =?utf-8?B?b09VSEw0VW0zOG1ZTnpSTE44cjgxbHBzUmVnZmxCZnkraTFtaVBSeTV5ZHFi?=
 =?utf-8?B?YmVTVWNTb0t5ZTdyekZIOUlSYnR6Q3pCb2JCSjVSb1M2cmZzeE5IN3htcFJJ?=
 =?utf-8?B?WTJkQXJFQXJGSTZEQ1JiSUlLOHUzdzNXMTArQVFhZjBxR0lWWTVYeUNzVlZz?=
 =?utf-8?B?RmJXMzFiSnVtOHRiK2k3MWF5bmZtbWhSQ1pNd2ZVckZqYmtQYnlYb2t6cEFp?=
 =?utf-8?B?YjkzWEUxbjJnRmhEN2RWeXY1UFpxOHFTSVVGOXNLQmhnLzFQa3ArRHVCbmVB?=
 =?utf-8?B?VS9IdjBKREc3MXExWUFrMWdSaXZYZmw3S1BqWjhPMENoaXBJKzRsR3B1MjMx?=
 =?utf-8?B?a05odTVYcHRwR3htZTZHUzArc0ltSWp5bmJKVjl5OUNQNU9pMjNmV1pJZEIr?=
 =?utf-8?B?MzFuSjdkakphaUJEaTlhczVjOWZaMU5mY3oybC9GME5TdW1ydFl2dEt5Uldu?=
 =?utf-8?B?WHNkNlNCdGwrSldKeTg5QWhVRHZzaEU0WlpKZ2lvZk1jMFJ6TGswTExaaXBU?=
 =?utf-8?Q?h9K4bMNF0AjooHd8iJzQ0O+8DbsV090wPrhLc4FSZixl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49F6DA6DD042694689C861714C1ECE6B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5caf372-1660-44a0-3e66-08d9f4da06e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 01:32:30.5189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZlnfoCTUt7z94/5zC2dNPQG6UNaRQdRzkUyDNyQsXQROyTHHl/0dKwFYk/NEA0fhQjjq+39BqVjqJbzxZRUlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IyBwbGVhc2UgdXBkYXRlICJody9wb2lzb24iIGFzIHdlbGwuDQoNCk9uIEZyaSwgRmViIDE4LCAy
MDIyIGF0IDA0OjQyOjQyQU0gLTA1MDAsIGx1b2ZlaSB3cm90ZToNCj4gQWZ0ZXIgc3VjY2Vzc2Z1
bGx5IG9idGFpbmluZyB0aGUgcmVmZXJlbmNlIGNvdW50IG9mIHRoZSBodWdlDQo+IHBhZ2UsIGl0
IGlzIHN0aWxsIG5lY2Vzc2FyeSB0byBjYWxsIGh3cG9pc29uX2ZpbHRlcigpIHRvIG1ha2UgYQ0K
PiBmaWx0ZXIganVkZ2VtZW50LCBvdGhlcndpc2UgdGhlIGZpbHRlciBodWdlcGFnZSB3aWxsIGJl
IHVubWFwZWQNCj4gYW5kIHRoZSByZWxhdGVkIHByb2Nlc3MgbWF5IGJlIGtpbGxlZC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IGx1b2ZlaSA8bHVvZmVpQHVuaWNsb3VkLmNvbT4NCg0KQWNrZWQtYnk6
IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQoNCj4gLS0tDQo+ICBt
bS9tZW1vcnktZmFpbHVyZS5jIHwgMTEgKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBi
L21tL21lbW9yeS1mYWlsdXJlLmMNCj4gaW5kZXggNTlkNmQ5MzlhNzUyLi4xN2E3YjBhOTRhYjkg
MTAwNjQ0DQo+IC0tLSBhL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gKysrIGIvbW0vbWVtb3J5LWZh
aWx1cmUuYw0KPiBAQCAtMTU0OCw2ICsxNTQ4LDE3IEBAIHN0YXRpYyBpbnQgbWVtb3J5X2ZhaWx1
cmVfaHVnZXRsYih1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzKQ0KPiAgCWxvY2tfcGFnZSho
ZWFkKTsNCj4gIAlwYWdlX2ZsYWdzID0gaGVhZC0+ZmxhZ3M7DQo+ICANCj4gKwlpZiAoaHdwb2lz
b25fZmlsdGVyKHApKSB7DQo+ICsJCWlmIChUZXN0Q2xlYXJQYWdlSFdQb2lzb24oaGVhZCkpDQo+
ICsJCQludW1fcG9pc29uZWRfcGFnZXNfZGVjKCk7DQo+ICsJCXB1dF9wYWdlKHApOw0KPiArCQlp
ZiAoZmxhZ3MgJiBNRl9NQ0VfSEFORExFKQ0KPiArCQkJcmVzID0gLUVIV1BPSVNPTjsNCj4gKwkJ
ZWxzZQ0KPiArCQkJcmVzID0gMDsNCj4gKwkJZ290byBvdXQ7DQo+ICsJfQ0KPiArDQo+ICAJLyoN
Cj4gIAkgKiBUT0RPOiBod3BvaXNvbiBmb3IgcHVkLXNpemVkIGh1Z2V0bGIgZG9lc24ndCB3b3Jr
IHJpZ2h0IG5vdywgc28NCj4gIAkgKiBzaW1wbHkgZGlzYWJsZSBpdC4gSW4gb3JkZXIgdG8gbWFr
ZSBpdCB3b3JrIHByb3Blcmx5LCB3ZSBuZWVkDQo+IC0tIA0KPiAyLjI3LjA=
