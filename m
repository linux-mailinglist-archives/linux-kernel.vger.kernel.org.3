Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B6F4DA72A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 02:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352886AbiCPBCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 21:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239502AbiCPBCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 21:02:04 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2052.outbound.protection.outlook.com [40.107.114.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6920A5DA59
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 18:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZNt3M95qrG/mb5ZrYOmpFW9yrIlSnLMs7dUxlmjB12dynUKGJ0G946wI9WKjS/pfzbkLwPeq1BuS9VESPvXJHpZBaitDbxCAuobE6GoxylcsQc6DMvPJUM7NkP04nf/PllzA3ae6pArebo/N0kntDWSoxB2rxz6weAQf8pvGppfNfynmP+cVpRyM/s0EN+uRfdwGCX8nYTji1EcDAsr14J7OLLo2drZo7A5VdibBS+AJGzKoK3Mm0gyBQ4q3UNy5nkoDnb5/+kCsoRKcp/wKqsWm3vAU0DpNzzToaP4FkQfUWUd/h44BLPNV5VqFwibQO2npdk9faHu7jpdJh97hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+MjYDLNIuw8HpRvOVE/ellDkZ8jDD0t4c+wzMGaakU=;
 b=Bo8t62k0JcdXCUUsBZ+ttDozmvExQ7kbGxkRVry/eHELGQm8aeOHOTZqXy/EZ1l7Oz4QAJEtkxVFgRhLByG6TTGylzNQkB//oawZZym+wo5Yx+7kiFe/tE7QR/QL0tEbZd605LLdmiryAJAW4M1+KmHve+T515LzGfVco2fw9pyCCuZ9WOo/7/ftVvbFGkMqil0WTLNuwOJIPhZS2hQLMPUGbEpNeWNvuSa9RvM19nWbM3SEmCvcxkTlo2pUrk4WpGbAiOpmLqvuAs1y8L6dyiy2pxrNZp1YlWkeRTbccm9RKhaBPAl1pC+yBdBtsXwfN3tzuBBDh+MVm7dDeu0Jfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+MjYDLNIuw8HpRvOVE/ellDkZ8jDD0t4c+wzMGaakU=;
 b=fYgM9t3FVQyQWlGga7rYftE03aG7RVtBQyWwQdRZvzeE8a7KGhdtKmc6Pbbc0+WkaUX7HS5r3k3Ecp96SZsiKAD5C/mnEjb1/TSf0ClgWQu2EyP1mXBieIURs+ZbLrlTiluDSwyaK7FrMnz0zjQ82YFaAkXz/2/ytBi3NE7RQUo=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYAPR01MB4253.jpnprd01.prod.outlook.com (2603:1096:404:c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Wed, 16 Mar
 2022 01:00:46 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d%9]) with mapi id 15.20.5061.028; Wed, 16 Mar 2022
 01:00:46 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
Thread-Topic: [PATCH v2] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
Thread-Index: AQHYN0kvr9WFFzF7cEKi9v9L2L7MeKy+dpSAgAF7wICAAIkngIAAsO2AgAAHjYA=
Date:   Wed, 16 Mar 2022 01:00:45 +0000
Message-ID: <20220316010045.GA3732295@hori.linux.bs1.fc.nec.co.jp>
References: <20220314021337.333781-1-naoya.horiguchi@linux.dev>
 <58732610-36a4-1f05-c09d-a5536013772d@huawei.com>
 <20220315054935.GA3454497@hori.linux.bs1.fc.nec.co.jp>
 <1770029b-fd59-4eb1-c891-5a2ba4beef9c@huawei.com>
 <68c2b93d-b6a5-5b17-cfb1-722b2d4412b5@oracle.com>
In-Reply-To: <68c2b93d-b6a5-5b17-cfb1-722b2d4412b5@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 894cd289-b204-40ec-33b9-08da06e86745
x-ms-traffictypediagnostic: TYAPR01MB4253:EE_
x-microsoft-antispam-prvs: <TYAPR01MB4253483991703BCE352C59D3E7119@TYAPR01MB4253.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VmSxnWf2/zU7VwM9NPdy5Uxtrukjr+sYHkHfThObNwpgFyGsxBFQsjKnccHPnnPwhbw9xz6QkicMKQIoZk/WQNMU1uA5fg8hvx9jnCWR+bzBPFr8Zff2heG2s7RMd7+xellUL0C3jjbSiKdDG6mnUBhNbYj7Dzer8kJy+ECOc5t/lECePlW6P+MedSeEf5w5uHbdwbcs9ZfwxdMUbZOrSv6kajzV4I25a6hkOGYm9ahfJMntwLa9xcOjVv3ME1jD6Bjgh1TI6uq4satwuT2odei205OLl1nbs0tJpaYq8kO6sy5oIuZmc/u+kMRMh9kSK3bDDZyXziwd8i/obI0JzLaCx5LE4oxYkIhoc8iqPGwW/3qew2b/rfdlEsaipxIwloVZs7DPXa3Czu37Ob3ljQ/uN+e8IsyV6AHFiC38F3W6dmM2aFNAebv2po2olstXUyUvlTUDY59oawRHEIP6rUlUHcf1PJsiHunrFGT3gd97FXeebbTVVA+BcybvmeTxrlOuMnC5c2eiAVad16OCqzi09MmmGdqRCqjPgnAJzXZiysFGUQGiSWlic8UkASKDLnfcAsB1KA2DRdLKZm+y8WvXV6dE9PgZG//BxJfqS0HE+XLL7S88+/s1+KjcPGpgyiiF6UVK+3f02wTcVtcQ0rMaNcIOnOYMuAI7567t/hqzijHvCivxYhSpTrB32Pnw+Ly2peFly0cNNh9NSthHxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(83380400001)(1076003)(5660300002)(26005)(508600001)(71200400001)(55236004)(85182001)(9686003)(6506007)(53546011)(6512007)(33656002)(186003)(6486002)(82960400001)(86362001)(38070700005)(316002)(66476007)(66446008)(64756008)(66946007)(66556008)(6916009)(54906003)(2906002)(76116006)(122000001)(38100700002)(4326008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkI3RndrMTExeVo2Nk1CMTlMcG5kNVZHbTZ1QVEwMmR5aUllU2FlZnlCMFl6?=
 =?utf-8?B?SlYvbi84RG5KT3lzNTFidlZFdHo1M0lGTmNwclIvbm1Mb29FSkxkNnJQMnhW?=
 =?utf-8?B?b3A3UWdJM3FHaVpmZ2ZvanVFOHk0eHIrZGQ5b1ZCbEk4dUdraWtsOEd4OVNK?=
 =?utf-8?B?emI2YXRNenUxUGJwMzJjSlBCOVdYQm1jRTNObDJpek41Y3d1VS9nT2cyRnBU?=
 =?utf-8?B?aDBQSm1zYUZjU1JsZTV4RUhFS1ROMXpQYm54cFg0S0UydkR3aVA3M2tWaC9w?=
 =?utf-8?B?dlVpZ0lnOE55ditQY3JPMWpGNkRUdkRhSm9wemJGSWZScUU3ZU1YVHgwSlVz?=
 =?utf-8?B?MGlyMjcxVkdVUzZkd0dGSmk1bTEydlB3MTFoMTZWOTZtVmtUM3c0T3FzMkNE?=
 =?utf-8?B?NjhPM0NHZUVoclB5MjVlQ2ZST2NBNm9tWlJOSk5vUXRTSGRkMjhLSXNoeTJH?=
 =?utf-8?B?MlFtemFGeURzcStwdHBMaGNBWTdwZ29rTXY3UU5ULzI3eDRRakZTcVorZW4z?=
 =?utf-8?B?dFMvWUZia2R4bFdseWRRS1Z2WW00cldoOVRiNHpwVEt3WG9EWjFaVjY3ZEsx?=
 =?utf-8?B?Zi9LLzJCM1kwMVVob2k2QVdsTTlBcGkrdTI2WHJIdW1jVW43MGlnRmhEMmFn?=
 =?utf-8?B?MC84bEJXazMyQm41eWNEbzByMm1LU3RuMTd6UHdvc0EvakoxODROcDhoTmdE?=
 =?utf-8?B?dXRUTDZLVmhOQ3YrL2NnRjZ6ZkgweUxRbS9HMlZEN1gySlRYajRwSjI5NlhM?=
 =?utf-8?B?NGhCUE5iajYrb2daMnJxaTJ5WlVncDB0ekFBVFVIYVZXTEl0TDZaUmQzM3Na?=
 =?utf-8?B?aFZGSE41aWtpa2pKRW9wL0tQcjUzME1HTUtMemFTOWkyZC8ray80SVhvc2hI?=
 =?utf-8?B?OE96eXBOa3ZkVjEybUZEODZjeW13emJUZlRHZVN3T1pWbG9laG9TK3FKeGVl?=
 =?utf-8?B?eXJiMFpKSlFmY0xZVUhFOUFNN01mOElIaVV3bkIzV0JrYWFpZ0NMa2pHejly?=
 =?utf-8?B?eXZoUkxVWW4yMTdzRnVOSkFCeEdnNFRGYTkyN0RHLzdvRzF0bjVudHFHc1ds?=
 =?utf-8?B?bHFQYWhkRGJQRzVPRngvM2xwQUdrVlRxSCtoM2V3T2RUYUhkNjZ0cFJ6T1hM?=
 =?utf-8?B?TmdQV08vUUo2Y0EvekhTSDZZM2ZmOGNFV29kN1BhdkFjb1BxblN3MjBWd0w3?=
 =?utf-8?B?L3U1TUMrRlBwZEJmTGZzdlZjRzdIRStOWjAzUGdvZXRhRER6Zm00RGthSVhD?=
 =?utf-8?B?NWNqeDlsZVdyMkFsU1NZbGNkVEJ6OVNrQjhtVXRJN1lmQ2JjUHNBNDZmcDVE?=
 =?utf-8?B?Z045dGs2K0ppVkNJUDlhSlg3Skd2TFJ3eXpCcFZaNlZnN3NiSXBOak0zbVg5?=
 =?utf-8?B?TFlNcjNEQmZIQzNGQ3JpMFBlRzFuaTloRHNvNjlIbmxjTG1NRTZxMzNLeEM1?=
 =?utf-8?B?YWtCeFJGakk4RThMajZKWkJsZXdpZU45UmdiRGdYK21scUZPQlp1dm5mOUg0?=
 =?utf-8?B?L1poMlljL0daTUR5WEZpcnpLUFNiZUF2WG9kWHlFNXl5KytQcC9VaU1pamlM?=
 =?utf-8?B?SE5qTEk4VEE1VUlUeGRaNDE2ejZyRFJYNWQxOFNSQ2V4cGFmbnd3WHk0K21m?=
 =?utf-8?B?NjhFclFBODV0aERUN3lOQXMwWDNMSlJPMlVvR1RjL1lqTFFsTFhPdU1EZzEw?=
 =?utf-8?B?Z2Z1WUlFcFNVdTQzd0tVVkZyaWlPQ1IzUTd3cExhbkJUNG9XRlpudVZyNUtX?=
 =?utf-8?B?Q09iZUwwTTFESlM3ckhWSGJid0MvaE1peHVJdHcxQ0JHQXkvcjVJc2xrSjZH?=
 =?utf-8?B?eU9sUTJlQ0RuRFBnQklSYlVybTRlRGpKc0VxcHlHZE5ZOEo3L2Nkc09VS0kr?=
 =?utf-8?B?YmtnSFRnRVYzc1lRa2llTmszanFqZFR5VGNxRFhJYW9scjk0dWxUZnRHaVRN?=
 =?utf-8?B?elZhSEp5b0Z6RUNGYWx5dXZ0TzM5M2ZHQlVMY0JkbVYwY283elg2VllrQ2lF?=
 =?utf-8?B?OUZtdiswZnNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79584712CA4F2C47B9A257763856F9BB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894cd289-b204-40ec-33b9-08da06e86745
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 01:00:45.8927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wHx88R6nrGLnecGZhaDlghWM/lZUJcDKJBwt6jLgDiJ2T/cLMmLGB5JVgB9rP9kSBVuEik6cdpJZPUUUtRcTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4253
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXIgMTUsIDIwMjIgYXQgMDU6MzM6NDNQTSAtMDcwMCwgTWlrZSBLcmF2ZXR6IHdy
b3RlOg0KPiBPbiAzLzE1LzIyIDA3OjAwLCBNaWFvaGUgTGluIHdyb3RlOg0KPiA+IE9uIDIwMjIv
My8xNSAxMzo0OSwgSE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8pIHdyb3RlOg0KPiA+PiBP
biBNb24sIE1hciAxNCwgMjAyMiBhdCAwMzoxMDoyNVBNICswODAwLCBNaWFvaGUgTGluIHdyb3Rl
Og0KPiA+Pj4gT24gMjAyMi8zLzE0IDEwOjEzLCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4+
Pj4gRnJvbTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPj4+
Pg0KPiA+Pj4+IFRoZXJlIGlzIGEgcmFjZSBjb25kaXRpb24gYmV0d2VlbiBtZW1vcnlfZmFpbHVy
ZV9odWdldGxiKCkgYW5kIGh1Z2V0bGINCj4gPj4+PiBmcmVlL2RlbW90aW9uLCB3aGljaCBjYXVz
ZXMgc2V0dGluZyBQYWdlSFdQb2lzb24gZmxhZyBvbiB0aGUgd3JvbmcgcGFnZQ0KPiA+Pj4+ICh3
aGljaCB3YXMgYSBodWdldGxiIHdoZW4gbWVtb3J5X2ZhaWx1cmUoKSB3YXMgY2FsbGVkLCBidXQg
d2FzIHJlbW92ZWQNCj4gPj4+PiBvciBkZW1vdGVkIHdoZW4gbWVtb3J5X2ZhaWx1cmVfaHVnZXRs
YigpIGlzIGNhbGxlZCkuICBUaGlzIHJlc3VsdHMgaW4NCj4gPj4+PiBraWxsaW5nIHdyb25nIHBy
b2Nlc3Nlcy4gIFNvIHNldCBQYWdlSFdQb2lzb24gZmxhZyB3aXRoIGhvbGRpbmcgcGFnZSBsb2Nr
LA0KPiA+Pj4NCj4gPj4+IEl0IHNlZW1zIGhvbGQgcGFnZSBsb2NrIGNvdWxkIG5vdCBoZWxwIHNv
bHZlIHRoaXMgcmFjZSBjb25kaXRpb24gYXMgaHVnZXRsYg0KPiA+Pj4gcGFnZSBkZW1vdGlvbiBp
cyBub3QgcmVxdWlyZWQgdG8gaG9sZCB0aGUgcGFnZSBsb2NrLiBDb3VsZCB5b3UgcGxlYXNlIGV4
cGxhaW4NCj4gPj4+IHRoaXMgYSBiaXQgbW9yZT8NCj4gPj4NCj4gPj4gU29ycnksIHRoZSBsYXN0
IGxpbmUgaW4gdGhlIHBhcmFncmFwaCBuZWVkIGNoYW5nZS4gV2hhdCBwcmV2ZW50cyB0aGUgY3Vy
cmVudA0KPiA+PiByYWNlIGlzIGh1Z2V0bGJfbG9jaywgbm90IHBhZ2UgbG9jay4gIFRoZSBwYWdl
IGxvY2sgaXMgaGVyZSB0byBwcmV2ZW50IHRoZQ0KPiA+PiByYWNlIHdpdGggaHVnZXBhZ2UgYWxs
b2NhdGlvbiAobm90IGRpcmVjdGx5IHJlbGF0ZWQgdG8gdGhlIGN1cnJlbnQgaXNzdWUsDQo+ID4+
IGJ1dCBpdCdzIHN0aWxsIG5lY2Vzc2FyeSkuDQo+ID4gDQo+ID4gTWFueSB0aGFua3MgZm9yIGNs
YXJpZnlpbmcgdGhpcy4NCj4gPiANCj4gPj4NCj4gPj4+DQo+ID4+PiBCVFc6SXMgdGhlcmUgc29t
ZSB3b3JkcyBtaXNzaW5nIG9yIGhlcmUgc2hvdWxkIGJlICdwYWdlIGxvY2suJyBpbnN0ZWFkIG9m
ICdwYWdlIGxvY2ssJyA/DQo+ID4+DQo+ID4+IEkgc2hvdWxkIHVzZSBhIHBlcmlvZCBoZXJlLCBJ
J2xsIGZpeCBpdC4NCj4gPj4NCj4gPj4gWy4uLl0NCj4gPj4NCj4gPj4+PiBAQCAtMTUwMywyNCAr
MTUwMiwxMSBAQCBzdGF0aWMgaW50IG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGIodW5zaWduZWQgbG9u
ZyBwZm4sIGludCBmbGFncykNCj4gPj4+PiAgCWludCByZXM7DQo+ID4+Pj4gIAl1bnNpZ25lZCBs
b25nIHBhZ2VfZmxhZ3M7DQo+ID4+Pj4gIA0KPiA+Pj4+IC0JaWYgKFRlc3RTZXRQYWdlSFdQb2lz
b24oaGVhZCkpIHsNCj4gPj4+PiAtCQlwcl9lcnIoIk1lbW9yeSBmYWlsdXJlOiAlI2x4OiBhbHJl
YWR5IGhhcmR3YXJlIHBvaXNvbmVkXG4iLA0KPiA+Pj4+IC0JCSAgICAgICBwZm4pOw0KPiA+Pj4+
IC0JCXJlcyA9IC1FSFdQT0lTT047DQo+ID4+Pj4gLQkJaWYgKGZsYWdzICYgTUZfQUNUSU9OX1JF
UVVJUkVEKQ0KPiA+Pj4+IC0JCQlyZXMgPSBraWxsX2FjY2Vzc2luZ19wcm9jZXNzKGN1cnJlbnQs
IHBhZ2VfdG9fcGZuKGhlYWQpLCBmbGFncyk7DQo+ID4+Pj4gLQkJcmV0dXJuIHJlczsNCj4gPj4+
PiAtCX0NCj4gPj4+PiAtDQo+ID4+Pj4gLQludW1fcG9pc29uZWRfcGFnZXNfaW5jKCk7DQo+ID4+
Pj4gLQ0KPiA+Pj4+ICAJaWYgKCEoZmxhZ3MgJiBNRl9DT1VOVF9JTkNSRUFTRUQpKSB7DQo+ID4+
Pj4gIAkJcmVzID0gZ2V0X2h3cG9pc29uX3BhZ2UocCwgZmxhZ3MpOw0KPiA+Pj4+ICAJCWlmICgh
cmVzKSB7DQo+ID4+Pg0KPiA+Pj4gSW4gdGhpcyAocmVzID09IDApIGNhc2UsIGh1Z2V0bGIgcGFn
ZSBjb3VsZCBiZSBkaXNzb2x2ZWQgdmlhIF9fcGFnZV9oYW5kbGVfcG9pc29uLg0KPiA+Pj4gQnV0
IHNpbmNlIFBhZ2VIV1BvaXNvbiBpcyBub3Qgc2V0IHlldCwgd2UgY2FuJ3Qgc2V0IHRoZSBQYWdl
SFdQb2lzb24gdG8gdGhlIGNvcnJlY3QNCj4gPj4+IHBhZ2UuIFRoaW5rIGFib3V0IHRoZSBiZWxv
dyBjb2RlIGluIGRpc3NvbHZlX2ZyZWVfaHVnZV9wYWdlOg0KPiA+Pj4gCS8qDQo+ID4+PiAJICog
TW92ZSBQYWdlSFdQb2lzb24gZmxhZyBmcm9tIGhlYWQgcGFnZSB0byB0aGUgcmF3DQo+ID4+PiAJ
ICogZXJyb3IgcGFnZSwgd2hpY2ggbWFrZXMgYW55IHN1YnBhZ2VzIHJhdGhlciB0aGFuDQo+ID4+
PiAJICogdGhlIGVycm9yIHBhZ2UgcmV1c2FibGUuDQo+ID4+PiAJICovDQo+ID4+PiAJaWYgKFBh
Z2VIV1BvaXNvbihoZWFkKSAmJiBwYWdlICE9IGhlYWQpIHsNCj4gPj4+IAkJU2V0UGFnZUhXUG9p
c29uKHBhZ2UpOw0KPiA+Pj4gCQlDbGVhclBhZ2VIV1BvaXNvbihoZWFkKTsNCj4gPj4+IAl9DQo+
ID4+Pg0KPiA+Pj4gU2V0UGFnZUhXUG9pc29uIHdvbid0IGJlIGNhbGxlZCBmb3IgdGhlIGVycm9y
IHBhZ2UuIE9yIGFtIEkgbWlzcyBzb21ldGhpbmc/DQo+ID4+DQo+ID4+IE5vLCB5b3UncmUgcmln
aHQuICBXZSBuZWVkIGNhbGwgcGFnZV9oYW5kbGVfcG9pc29uKCkgaW5zdGVhZCBvZg0KPiA+PiBf
X3BhZ2VfaGFuZGxlX3BvaXNvbigpLg0KPiA+Pg0KPiA+PiBAQCAtMTUxMiw3ICsxNTEyLDcgQEAg
c3RhdGljIGludCBtZW1vcnlfZmFpbHVyZV9odWdldGxiKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQg
ZmxhZ3MpDQo+ID4+ICAJCQl9DQo+ID4+ICAJCQl1bmxvY2tfcGFnZShoZWFkKTsNCj4gPj4gIAkJ
CXJlcyA9IE1GX0ZBSUxFRDsNCj4gPj4gLQkJCWlmIChfX3BhZ2VfaGFuZGxlX3BvaXNvbihwKSkg
ew0KPiA+PiArCQkJaWYgKHBhZ2VfaGFuZGxlX3BvaXNvbihwLCB0cnVlLCBmYWxzZSkpIHsNCj4g
Pj4gIAkJCQlwYWdlX3JlZl9pbmMocCk7DQo+ID4+ICAJCQkJcmVzID0gTUZfUkVDT1ZFUkVEOw0K
PiA+PiAgCQkJfQ0KPiA+Pg0KPiA+IA0KPiA+IFRoaXMgb25lIGxvb2tzIGdvb2QgdG8gbWUuDQo+
IA0KPiBJIG11c3QgYmUgbWlzc2luZyBzb21ldGhpbmcuICBJdCBzZWVtcyBwYWdlX2hhbmRsZV9w
b2lzb24oKSBjYWxscw0KPiBfX3BhZ2VfaGFuZGxlX3BvaXNvbiBhbmQgdGh1cyBkaXNzb2x2ZV9m
cmVlX2h1Z2VfcGFnZSBiZWZvcmUNCj4gU2V0UGFnZUhXUG9pc29uLg0KPiANCj4gSSBjb3VsZCBl
YXNpbHkgYmUgbWlzc2luZyBzb21lIHBhdGNoZXMsIGJ1dCB0aGF0IGlzIHRoZSBvcmRlciBvZiBj
YWxscw0KPiBpbiB0aGUgY29kZSBJIGFtIGxvb2tpbmcgYXQuDQoNClNvcnJ5IGZvciBteSBsYWNr
IG9mIHdvcmRzLCBtYXliZSB0aGUgc2l0dWF0aW9uIGlzIGEgbGl0dGxlIGNvbXBsaWNhdGVkLg0K
cGFnZV9oYW5kbGVfcG9pc29uKCkgY2FuIGJlIGNhbGxlZCBib3RoIGJlZm9yZSBhbmQgYWZ0ZXIg
U2V0UGFnZUhXUG9pc29uLg0KImJlZm9yZSBTZXRQYWdlSFdQb2lzb24iIGNhc2UgaXMgd2hlbiBj
YWxsZWQgZnJvbSBtZW1vcnlfZmFpbHVyZSgpIGZvcg0KaW4tdXNlIHBhZ2VzLiAiYWZ0ZXIgU2V0
UGFnZUhXUG9pc29uIiBjYXNlIGlzIHdoZW4gY2FsbGVkIGZyb20gc29mdCBvZmZsaW5lLg0KU28g
dGhlIGFib3ZlIGNoYW5nZSBpcyBpbnRlbmRlZCB0byBtb3ZlICJtZW1vcnlfZmFpbHVyZSgpIGZv
ciBmcmVlIGh1Z2VwYWdlIg0KZnJvbSAiYmVmb3JlIFNldFBhZ2VIV1BvaXNvbiIgY2FzZSB0byAi
YWZ0ZXIgU2V0UGFnZUhXUG9pc29uIiBjYXNlLg0KDQpCVFcsIEkgZm91bmQgbXlzZWxmIHRoZSBp
c3N1ZSBpbiB0aGUgYWJvdmUgZGlmZiwgSSBoYXZlIHRvIHJlbW92ZSB0aGUNCnBhZ2VfcmVmX2lu
YygpIGluIGl0IGJlY2F1c2UgcGFnZV9oYW5kbGVfcG9pc29uKCkgY2FsbHMgaXQgaW5zaWRlIGl0
Lg0KSSdsbCBzaGFyZSB0aGUgdXBkYXRlZCBwYXRjaCBzb29uLg0KDQpUaGFua3MsDQpOYW95YSBI
b3JpZ3VjaGk=
