Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924644D3E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbiCJBQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbiCJBQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:16:18 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2045.outbound.protection.outlook.com [40.107.114.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C9012222B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:15:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvtHMcXAdmDtBN7m2JgNGn3kpafrMHPf1B0MvTzFB1dmv9pNEtjwWNvekslh9ks70s36SXFaSfQkYMhI4x0I5JsrL9Ys/0flbpzEe9/5wL5aEbks4OKaKvTr6dLOcpZuttDNwwUAQu1XZie6RhnTVLatdJCEEOCe73VXSktzax3L1XjiJyAPQ3c5pS7pI4LJctIrcVIuVq0eqNbKBvEwtHdzWbvpgCfD7WClZILkiB2hycFNznrl4q72pyGmo7E2ZE7oCav9mJBmR8fGYLPFkxaLsTASDZn08D8WmURZy/Ao+c3ZJ6TB7Sz7LcM5hWvtlUqArIXVZYu3TFUY5U9uGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXQxv7EWICTsdZaDjwXhI7gkryYgXo/vmgnxqgGRxjM=;
 b=QMnWZbYm5BZbseygz+Qy5Z+l8VexgQJ8msfHtwqd2jlj7Ld1WNeCuVgFrp2zu06fDw7vclmgz1ScN7p7/ZcA9VJwuUcBvdqRdsQtSCRkjzDacrKDYo0sEqs+F01sIVw95YOWJX42ExYMtNDCRekrFJnTT2O9JmoyF7Y5XXjMDTAW8fhBODd39xJ+jbgpWqJzddaoS/85/t4RQWH9aPVY0gv1s9a2x1cyfs9y+Zv9VDyN2XcYWobuyC87MNbrlkK4dPWXhVfPCSCJwgqvYL+vO4OR7KaLuw47sXLoXatMeWEsDH+fbnSQ76IsL2j+v09D+M1ob0SHONSWldbkcc9jPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXQxv7EWICTsdZaDjwXhI7gkryYgXo/vmgnxqgGRxjM=;
 b=LIBmZb4FhQo8l8pxTDdifnT7+MwIk3y7trrSDUjjPEq1/sfVNOp4W6bAbCBkmnaSnmYi57hA2lxckt0j/nhOPitiSiwGLbMkzfbw63hczaq9CinlzGRoZgqt2Dd3ZfrhMY53lnv60MSB8WG7flOY7dA92F3vxuVqZ9sbOefVDl8=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB8635.jpnprd01.prod.outlook.com (2603:1096:604:19b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Thu, 10 Mar
 2022 01:15:15 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d%9]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 01:15:15 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
Thread-Topic: [PATCH v1] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
Thread-Index: AQHYM5Y14jmZP4bIvUm8lwYXZPPhCKy3kogAgAA+4gA=
Date:   Thu, 10 Mar 2022 01:15:15 +0000
Message-ID: <20220310011514.GB1580142@hori.linux.bs1.fc.nec.co.jp>
References: <20220309091449.2753904-1-naoya.horiguchi@linux.dev>
 <20220309133010.0f04c2ac4939edbdb35723bb@linux-foundation.org>
In-Reply-To: <20220309133010.0f04c2ac4939edbdb35723bb@linux-foundation.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd5c38ff-169b-419a-e705-08da02336f1b
x-ms-traffictypediagnostic: OS3PR01MB8635:EE_
x-microsoft-antispam-prvs: <OS3PR01MB8635C7230B9AE52C8D63FFDFE70B9@OS3PR01MB8635.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3JHbfWl3McfecGb1UMHBNE0XB9ZMTflqVb5TNEcqRwMdb5kRsm3ALa6MMbWjggMxHIj/XULvOgAa3hJuwFOWlnWNjNmjij5p8jBUOLv7MdvGV3epLeFUgw/vlEVvVyGjaLSp4RxXnAXgDRUUUJLgj/HBCZQ+0rU5vQyW70oVs4JE9fP6Do6Lrg0C2UVAaMG/h+h4tVBXZ7PDR9KTFzXMume0dV2FUtUPkxDFWcVPLGFZWajmZ+HIIWx1xiVyniNbT9Dm6gqOe+q+bGmttG1CZGKzXUpR09iewGUc+R6U96N71qtPnGq95Z4rRcXHsVjUV3V7ln/7uPnFmlH7f+t+CT/6Vt5DQgepDZg50tyAzMafBtLyI36c15B6Huz3dsfAHgRS1/MW5Y17c3S4FurwH+vAcAGWZT4msfuyWLFBe+ADnG/KAKDDfmoIFoH/4LRu0XOm0lSRSPqR9+M2iucwqCwa8bgA13VTh/Ceqt60l2uwNU4jyExrr6C1FtLZumYUD93/uOkaHAkXuyuNi6B27oiXXvunHLeJ7hbIA/yOAIJEKbRxp6RovumgjCQExUJoWQsHjNK4LDjAVPxj/wU1gE+eGiQCQKN8czZMG2UBRsyxWBwYmM4VQAy86MZKlktmHEus6PkVovYx5srMHIetVcxCRIDhuPsKFnXLTGk3JT4GGHT/f6GphYywZYwEo8nhJOBC0NsTCbG4VhLTf3zQ0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(86362001)(85182001)(82960400001)(5660300002)(26005)(316002)(66556008)(64756008)(66446008)(66946007)(66476007)(83380400001)(508600001)(122000001)(6916009)(1076003)(186003)(71200400001)(38070700005)(4326008)(8676002)(6506007)(8936002)(9686003)(54906003)(2906002)(6512007)(38100700002)(33656002)(76116006)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDNoQksxb09GTDlRK25waFhGT21ZTkF6MmNNTmY5WXJXby9qMk9LdUNRbXFq?=
 =?utf-8?B?azNyNUdVdFFlR01GNmZZbWowYWJRVHFNU3ArbnMyTDhmUFhIaEoyTUhlTUcy?=
 =?utf-8?B?TllRY3Z3a0hZVk9EdWlVL1dBUjVrcmxuTHcxL0ZFK1I1Q0RMRnBPdkRPYmNa?=
 =?utf-8?B?cjZ0ekhzbkJwTVFENUJQbmk2RllndUpkeTFIY3BUZ05wcDFlU29OOWFrYjlD?=
 =?utf-8?B?QnJveTVUVmdUVnZtV3hKbHY2cGptSXoyNkU2QytWY1VRVmI4Q2VXMUVSMVZn?=
 =?utf-8?B?bmllODFQbHVHdGh2M3JNQ2o5bzNSQ0ZwQjVGS0lQbFp4bSs3ZWlzbEh0KzZp?=
 =?utf-8?B?OFphaGd5RTE5YTNMclFqTEJkcURzZFY1MDFKdEhuUWszMFJQNEVta1JnWmVu?=
 =?utf-8?B?N0FiREVISlZNcWVjRHcyc3Z5TllkVmYyRnJpdkdlczlKWW1rVnZiQTRBT2oy?=
 =?utf-8?B?L0JXSnBuTjJQSzJ4dmtKVkJpZmZyaDB3NDhGMHphY2J6MTRaWGlEUG9rYjFT?=
 =?utf-8?B?ZHhMNWJ4UmVqdXQyQXdERyt0eWl4Z2xKL3Y0OCtENSt6dk50OXo3NUJRN0tp?=
 =?utf-8?B?cER1Rk93a1dYU2ZmOTVKSUs1TzR0SzlLTDJBVkh2ZjBkVFJzN3M2b0tMUWc2?=
 =?utf-8?B?MmQ4MlllaURTK2xpME1PVGhRZUhQQjVhYklOZzZGRjJIbGF1K2ZJcU94bWNF?=
 =?utf-8?B?TGtTM3U5RzQ0SDhMRjNEV25nU1RiRklkMW9BSk1HcjkvQUcwL0daMk8yTXRs?=
 =?utf-8?B?aC84MllLNm5ZZ2FwUnpqOHlCQ3l1OHM2TnJrWE92b29vck84Ti9wYlpGUDFZ?=
 =?utf-8?B?Q1Q5L3J0b2loZ1UwaVNleEt3dmRid1hrRW55Q2ttOUJST0VTME0xQm0zK0V6?=
 =?utf-8?B?M296TVBVTnNWUjhKTGpzcStvZ3RyK3NvNlRWZFZxYW5mSGV4aHNHS3cvUnVh?=
 =?utf-8?B?dUVmeTlhREMyeVA5Qkw2UzdUS3lpbnZBcUdBaFdBTkhmMlhnZGx3ZHpTbTFn?=
 =?utf-8?B?Qm9ENTNWdG1qUmUxUm1HS0FhNG8zZjRSeHVYRkZJUHdsMjkzcFhCQVJRcTAz?=
 =?utf-8?B?b0dVc3ZRVy9TUjJiZ2FsNGlBc0JzZk1xdWZFeS9xN2RYaXZNZkpmdlNKOHow?=
 =?utf-8?B?eWgrZ3ErODhZSUJ5UmxpSGZzTTBxcmJJNU9PR042YjJvMXVNSXkxRE15ZVBT?=
 =?utf-8?B?WGYvODFOdjl3WnB4dnNpNC9rbHpSMXk1ZU1TaitPbFZObUxHbTZMUGxQd2c3?=
 =?utf-8?B?SnhkZHZHVTdIdm9veGsxdFFxT3FaVFNLaEdMUSsvYzhkc1AzYXFFZXBJWXFv?=
 =?utf-8?B?aHVRd1htWnlJbksrbE5oRzUrTzJrRGQzTlV0OEhTQkJqL0NtQ1VYUnhPY3Z6?=
 =?utf-8?B?N1FIbDdMd2RzYnJlekpyTHJYc1FudlJSU0QwQVF3ckJ4ajUwbjJUV3BRcDli?=
 =?utf-8?B?eUtFTFZaZjVsNzU4VDlpaUVJSEN4blFkczRrcm83UTB2VnRyakwvR3Voa0Uy?=
 =?utf-8?B?UjVydGJJSS9DY3JGMnRSTDl0VmpCSkRHclVNMXFtdFBmU2Y3RU42VmJjbTcw?=
 =?utf-8?B?ZkJHNHpEcmVVZkxmaVdvaCt0aTFzY3VWZXpyd2llVmVOTmJncjJyZzY2VElk?=
 =?utf-8?B?ZWlnWkdmMnhxZ2VDcUxndXhUVGRWZitsNnpUQzhwNHNSRHdzKzU2aGNjWUNu?=
 =?utf-8?B?OEQ1cUhRUFU5RGJwU1h2ZFdZVXZ2RmJFVTlxaXRCVlRrQjhOYTBwbnVUa2xQ?=
 =?utf-8?B?Uk5aQkM5bStnenJ5TFBRZ0pSVk5zZ2R1Z1dCSjV2UUpZOFlmNGp4UW1RYlh5?=
 =?utf-8?B?K0xPVDU2b3l6clVHL1Q5blVIVW9qdzQvcDgxVXBkQnNHclBIR000cmVnT0s3?=
 =?utf-8?B?U3YxREFOdERuU1hPbEN3UitrTDk5V3Qxa2Z4NlZ3TXk0aEl1cXBYZTdmVGR3?=
 =?utf-8?B?dkxPcnMrdFIrZ3lBSWNJd0Q3bUVWWXpVQVFmTlh1b09IYkx1LzNLZmkrTytM?=
 =?utf-8?B?dVZIelB6NUNnZVlMRzhGNkNoOTdtZTJNbWF4b3J2UURtTFNOZ0VGM2FlUEJk?=
 =?utf-8?B?VURjUlhONGlmbnZkRGpESmUyYlAvcHlRZVp1YWlCK2Z0WTR6UTZwR0I2Zlpv?=
 =?utf-8?B?WWYxUEdMbmxtSER6NUVqc2JPWElPZ01vdnNnUXN4bTdIcWRYaXl0ZXp3S2J5?=
 =?utf-8?Q?Q7r0OJVViCqNFl6HdCzd186NJoJuO5/jNRzNpF4BsR0K?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58AE6C3231D8E54091AA47C37BEED998@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5c38ff-169b-419a-e705-08da02336f1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 01:15:15.6252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbJ50U/+uqDIrWBJTs8dlSUj+anNclYCXzN+yMDGbnxgaH5KlG5f7CFaXW88+F0MXTw+c19f3jeU1q0XiqNXcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8635
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXIgMDksIDIwMjIgYXQgMDE6MzA6MTBQTSAtMDgwMCwgQW5kcmV3IE1vcnRvbiB3
cm90ZToNCj4gT24gV2VkLCAgOSBNYXIgMjAyMiAxODoxNDo0OSArMDkwMCBOYW95YSBIb3JpZ3Vj
aGkgPG5hb3lhLmhvcmlndWNoaUBsaW51eC5kZXY+IHdyb3RlOg0KPiANCj4gPiBUaGVyZSBpcyBh
IHJhY2UgY29uZGl0aW9uIGJldHdlZW4gbWVtb3J5X2ZhaWx1cmVfaHVnZXRsYigpIGFuZCBodWdl
dGxiDQo+ID4gZnJlZS9kZW1vdGlvbiwgd2hpY2ggY2F1c2VzIHNldHRpbmcgUGFnZUhXUG9pc29u
IGZsYWcgb24gdGhlIHdyb25nIHBhZ2UNCj4gPiAod2hpY2ggd2FzIGEgaHVnZXRsYiB3aGVuIG1l
bW9yeV9mYWlscnVlKCkgd2FzIGNhbGxlZCwgYnV0IHdhcyByZW1vdmVkDQo+ID4gb3IgZGVtb3Rl
ZCB3aGVuIG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGIoKSBpcyBjYWxsZWQpLiAgVGhpcyByZXN1bHRz
IGluDQo+ID4ga2lsbGluZyB3cm9uZyBwcm9jZXNzZXMuICBTbyBzZXQgUGFnZUhXUG9pc29uIGZs
YWcgd2l0aCBob2xkaW5nIHBhZ2UgbG9jaywNCj4gDQo+IFdoYXQgYXJlIHRoZSBydW50aW1lIGVm
ZmVjdHMgb2YgdGhpcz8gIERvIHdlIHRoaW5rIGEgLXN0YWJsZSBiYWNrcG9ydA0KPiBpcyBuZWVk
ZWQ/DQoNClRoZSBhY3R1YWwgdXNlci12aXNpYmxlIGVmZmVjdCBtaWdodCBiZSBvYnNjdXJlIGJl
Y2F1c2UgZXZlbiBpZg0KbWVtb3J5X2ZhaWx1cmUoKSB3b3JrcyBhcyBleHBlY3RlZCwgc29tZSBy
YW5kb20gcHJvY2VzcyBjb3VsZCBiZSBraWxsZWQuDQpUaGUgYWN0dWFsIGVycm9yIGlzIGxlZnQg
dW5oYW5kbGVkLCBzbyBubyBvbmUgcHJldmVudHMgbGF0ZXIgYWNjZXNzIHRvIGl0LA0Kd2hpY2gg
bWlnaHQgbGVhZCB0byBtb3JlIHNlcmlvdXMgcmVzdWx0cyBsaWtlIGNvbnN1bWluZyBjb3JydXB0
ZWQgZGF0YS4NClNvIEkgdGhpbmsgdGhhdCB0aGlzIGlzIHdvcnRoIHNlbmRpbmcgLXN0YWJsZSBi
YWNrcG9ydC4NCg0KQnV0IHVuZm9ydHVuYXRlbHkgdGhpcyBwYXRjaCBzdGlsbCBuZWVkcyB1cGRh
dGUsIGNvdWxkIHlvdSBkcm9wIHRoaXMgZnJvbQ0KbW1vdG0gZm9yIGEgd2hpbGU/DQoNCj4gDQo+
IEFyZSB3ZSBtaXNzaW5nIGEgcmVwb3J0ZWQtYnkgaGVyZT8gIEknbSB0b28gbGF6eSB0byBodW50
IGRvd24gd2hvIGl0IHdhcy4NCg0KSSBub3RpY2VkIHRoaXMgYnkgTWlrZSdzIGNvbW1lbnQsIHNv
IEknbGwgYWRkIGhpcyByZXBvcnRlZC1ieS4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
