Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3408E5AC9C1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 07:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiIEFY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiIEFYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:24:23 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2040.outbound.protection.outlook.com [40.107.114.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1419D218
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 22:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWmrvC+uMQ7onaTUS/vfekbT9firdYpFVnbUapPbWKuovV7DnkEY+dsUJ4CLDm0r4xu2MPCTlBqpCensrKBdv8y3cSLqVDbapsdx7EJIYXN5bAJQA18bNbRjwKVjUKRERXr8XnXCa4QoPz63UNzWe77JWxbyqMREWPjI3B1D4XeUn3beD4jx0OM0vBbibx2nzgCufdckAkQ1fpR4auniRm2fsLde8d6l8glagjbB56SBZJKKxS1drppdyGe+T0kZLOABNVTQXh5BNuIrD56OQqBYtgi6EZ7xBu62W5Mu6ZhK5v9quAeAxVF6lScZkGtXTkvzIWrgjGdZ4Z5pEf5vBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/lcw7njgAmZ9erUREWDZfdJlHMwEn38Pxy3PKX7e9g=;
 b=WdWWhiglHOG4vDaDVk27n3el86lzJWnjbPYFq0DjGeBQ8gzFVs8fHjbIIhcxBFSU0Tag1Q26gyaxiwdI50Ro7HtNxSEaYiAaN1EtQAmcDrfRo668IIkAaf3gpZOMzhdfw80gXhfzuv+e3C8GJgWiba6FhtwVzqSmtu+xvrY4AzuaX0z1buPZhUAts38/v6zzFwduFgwERrGI4O3WBCjC5o/1m/H0Z5m4pIKcUwBg5SM13gkiCpsm8v7IRHQtoDjazo7O5VT2LIiEeptbc5CdGumQKcVoVlhBuCI2QQuziVPGk/lrB6igQIkvw8tsQaIagyAjzl92WbI4AX6JveeLHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/lcw7njgAmZ9erUREWDZfdJlHMwEn38Pxy3PKX7e9g=;
 b=UfMbWuVQW04z24DTgRP2Vw85vo8yFU0GR6x5ysARVBOjghPWJwdLRlQcNFRFHBa0VgCwauqHcCrQQbv4iNsnkyLBq6mHgWVzQY/RliG51x4H9qt9Llk8b82Bxd2aSXneXq0MmEGNC/kkXtS+huaJP+g/sPDjQJgT2ShGz4lXxRI=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY3PR01MB9950.jpnprd01.prod.outlook.com (2603:1096:400:1dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 05:24:19 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5588.011; Mon, 5 Sep 2022
 05:24:19 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] mm, hwpoison: use num_poisoned_pages_sub() to
 decrease num_poisoned_pages
Thread-Topic: [PATCH 3/6] mm, hwpoison: use num_poisoned_pages_sub() to
 decrease num_poisoned_pages
Thread-Index: AQHYvG0pXJj6QsWyQEa/zzYKmj3WQ63QVqMA
Date:   Mon, 5 Sep 2022 05:24:19 +0000
Message-ID: <20220905052418.GC1355682@hori.linux.bs1.fc.nec.co.jp>
References: <20220830123604.25763-1-linmiaohe@huawei.com>
 <20220830123604.25763-4-linmiaohe@huawei.com>
In-Reply-To: <20220830123604.25763-4-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac1b5036-63ed-42ed-f422-08da8efee211
x-ms-traffictypediagnostic: TY3PR01MB9950:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6KKpSZkoHVDxBnXS/80Ep9VbrCZGa4sNL1zXhcXumFmyF40ANLyUDOU4rAEVYna0BPrgT84JK4+tRGU1IstUj/vF+wYAmf2nEXvZZtWQiPuT7ArLhHL/qdLR9uhIRZEdkW7pU/rveGBjNotDAgOZ70gxcCG0/OTyjg41gKKASOrDk46KhS5FgbcCbBREG93W8yfUJeLezhkcwmeVaO/hv58hmJMj5xxmNvFA559gbHED1MwXeBdBn+0WUjTGTsYhV4/mh8GFn6v0ktEuPKJPJRWGFjgX9JJk+gUH5K1oBB/6SQAWxHoCx8oWkzSsy3+cOfgxDYWYEYwBot25q9kOF7NrDZZx4N0mOXeSW5NquCdkXBRJXiUADNbIF9Egr3bJuGZTvoJ/IQ6vkSPrAVTp7fAFx6Idwi7NmGWUbv2Uqwn5vM0TJ5uMyslJKr/AgtP5x8gcdH9xrbSGomXb1OCPAy3/m25cOg4Ftw4ud+dn1Sr2zUQcwR0uTlzUMGA2xJWa3y/yvO+19cm/4C7fJim76KlDiuJJGTjue6Di4L7ET8NjrUAXB1og+xM+MMNyB8wPnn9pwPAnMBDkO54BKVT5IyWKVddKk0ULcnq3QX6Dmt9z1dotmV3VApiuY3imwtDJG3QW4hOtuoBHj3Hpu/z8kCr6QBlsEBuVuaXqON+w/dEG1MPB6+LrBWRu16YgIVdpWs/vH/Q8jdEN8iA+Kq7QirbLawvtRtW2hczKRgwhS2OrJJDb8cn8knDDlwUkcUSNbSExMcbyQ2A0Np4BPAs3PA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(71200400001)(6916009)(86362001)(55236004)(122000001)(38100700002)(316002)(54906003)(6486002)(76116006)(66946007)(66556008)(66476007)(66446008)(478600001)(82960400001)(8676002)(64756008)(4326008)(38070700005)(85182001)(33656002)(5660300002)(558084003)(1076003)(8936002)(41300700001)(6506007)(186003)(26005)(2906002)(6512007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3R0bzZ2T1FPWnNodklYMG1xK0dyTC9mVjk2RHBIRUdzOFF4aHFJdFY4NXN3?=
 =?utf-8?B?YkExNitHV3dhTjdJTVFBYWpKVWI4ODNOOEh0VzNoamh0dG1BWGh2cGhmUEJH?=
 =?utf-8?B?N2l4dnhRY3IxZG1ZWlNkZlo1VWRnTS9WUFM5d1JSbjI2V1JEMUNSZ2ZyMXc3?=
 =?utf-8?B?c1AxUkxTdzlJMzV3bXhtUXJjMEgxZ0J6SzlVWjhIclVLSjhYY2pQbS9rKzRW?=
 =?utf-8?B?YllVTmp5YmZyWlhKYU56SWs4cWFsRzQ5SlpxZFdnblRCNUh3L3lTcjl5bjdP?=
 =?utf-8?B?SXZEZ2pqZWkwNWk4NUpOVGY0a3JtUEorVjJKY0xDV25XUmNXWm8zb0VPYVFu?=
 =?utf-8?B?WUZJQWc1b2F3NFFBbHl4clFST2dxd0Mzckp0Yy9qb29uZUg5blRoNks5eW03?=
 =?utf-8?B?MFN1QUxUd3kwdnVDem1sejJBMFFNL2F5UVl6d3lqa1JaYU42cU9yNC9aWDQr?=
 =?utf-8?B?cDVPOEZld0x2WmtURE1wS094c0pTNzlXaVI0LzBGa1VkUmJTcTN3TEpydlYv?=
 =?utf-8?B?UC9yTWtKZnBlTHEzdUVZYTZjOXRXNFNvT0o4eEVZb1ZNYlgzQVJhYzFKR3Nq?=
 =?utf-8?B?TnpTaHArbXNiMzV0bWpSd2JFTGxQeFFoelBaMlBna3JNc3J3RnkrRVdHcnYx?=
 =?utf-8?B?azBDam5XY2VsRGtRQTFGYzN6eXNvUVVOSUZncGNuS1E4V3hLclFWcllQUjJL?=
 =?utf-8?B?UnNUU0ZrbERVY3l6S21wZ1o4bWlaMU93dmVNN3lHVFArcDhGbEhVMG42eE1z?=
 =?utf-8?B?eGF4TzNFVENZZUpzRXZLTkxmRysrQ1ZPZU94eUlOZnJ6bkJJUTJKWlV3d21M?=
 =?utf-8?B?a1V3anY1YS9zclV1ejRzVDNKaThPenBWVHhoLzZ6by9FVDhUbDg3UEo1NzlJ?=
 =?utf-8?B?Y0tyak9RYS9WUE1hbUMwNVhxK1laZVZsa2xCWW1pdXpZWXVuQUxjMXpOdHpl?=
 =?utf-8?B?blVpaXYreEpJMzd1d2orVVJhVjl4TmtOWEV3UlBveW54V1JDeStzRlN0WStv?=
 =?utf-8?B?aE9Wd2JmZURlalA4V3RhZkxXWjM1MlQ0UHhzTmtOc0d3UGNCbWNBT2I4RVdQ?=
 =?utf-8?B?UEpSbjNHUmNzNmZ0bWwwWlVRNTQva1BUNFRIMzkrdUFqdGc0QU1ZVjVHRVIr?=
 =?utf-8?B?NGJZWUZ0QWpzL3MyMFlLbWlWZEpuaWFTQTdvTk90MXNaQXpqaW5rNHRPL210?=
 =?utf-8?B?ZVJDekpseFVZZ3Q2R3NWdFVUMTlxd2ZONUpnTGJGVFN0N3F6ZTBLaWd3RUhF?=
 =?utf-8?B?d3YwUytQRlp3eHg3Q0VQN0lETE0yMVlRNnQ4K2FhamptZjhyUCtzU2Q3VzVW?=
 =?utf-8?B?WFVQSU1aVjYwMmFjUXdVZzU1dm9rZDQyK3BlRjRialUvNUVIbjBWR3JMdDI4?=
 =?utf-8?B?Wjc4ZWwxYkpWeU02MzA3d3VSL1RhcDk2RjFmMmtVWmVxY1Z3b0xXV0hKRlVi?=
 =?utf-8?B?OTlhUmRXQ3NMMEZpMkwzbXVBclRUK3MxVFp3Wml4RTV1TnlId09DQ0VTb1VX?=
 =?utf-8?B?azhTeU5QREpXcXhpZXlvWE11ck1RNG9kQ0NOQW9VN0RsR0tzYTJJT2JKeFEx?=
 =?utf-8?B?SWp1S0FaNzFsTmJoZVJKOVR0QTBQK1ZIR1FSVG9acjg4YitXcDQvWk5XbjRV?=
 =?utf-8?B?aVVsWVllYjUxbFd4anlFRkF3ZldoeGFpTVJxUnp4ZFd5a2pWZERhSloza21W?=
 =?utf-8?B?WUFQa3lMZVFDc21rdkFqSmxyaG5RdjRyTXFPWW9kdXduYk9GTlZQWDJReDFX?=
 =?utf-8?B?TERIWXdoREVYNmllcDA1WGxtR1VWeVM2ZUJHekZ0Nk9JYW03OUhWMExUWGVr?=
 =?utf-8?B?MUpOQUtMSXFKTEQ0VlZnMng2UnExc3dFL0k0cDArNXBwOFBEclFBODFyNlZl?=
 =?utf-8?B?aUg2MERxTjdhU0Ira3ZmM3VVKytWMTJKd1k2MFMvQmJEQ1Q2UEs1MkhDaCtF?=
 =?utf-8?B?bWdHRWYreWhXYlJ6QjdYd2pJaU93eVJkK0t6cVArd0grcmlsTHlpSFVVRXlL?=
 =?utf-8?B?akxQUXk1RVRiSEhuZVV0emxpY25hMktWTGhQNW1PWWZTUFJzK0x0d2p1YUhn?=
 =?utf-8?B?aitaTWpBMFZTSC9YdVVXYzhMUDBkSittTUJCNlRGeThoQ2xUOVBCYy8yNzBO?=
 =?utf-8?B?RWdlU0tOMXVVc1gwT1hEWFJncEo5V0N6Titra2pObXpvNjROa05XM3JFQUVq?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <562A792EA9012248B45AE82BF403FE04@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1b5036-63ed-42ed-f422-08da8efee211
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 05:24:19.1698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qmyxUmfY+cRF1O14bnAuhGf49V1b/+SAdaHjJ9LtYDWN/cV0ysKazGP8z3JjVZYgXEeI05DP1ExmH1zvIFjYkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9950
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMzAsIDIwMjIgYXQgMDg6MzY6MDFQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gVXNlIG51bV9wb2lzb25lZF9wYWdlc19zdWIoKSB0byBjb21iaW5lIG11bHRpcGxlIGF0
b21pYyBvcHMgaW50byBvbmUuIEFsc28NCj4gbnVtX3BvaXNvbmVkX3BhZ2VzX2RlYygpIGNhbiBi
ZSBraWxsZWQgYXMgdGhlcmUncyBubyBjYWxsZXIgbm93Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
TWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+DQoNCkFja2VkLWJ5OiBOYW95YSBIb3Jp
Z3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg==
