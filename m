Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19962512A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 06:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242420AbiD1EJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 00:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiD1EJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 00:09:16 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2083.outbound.protection.outlook.com [40.107.113.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCEA32EE6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fdm5sa46Cu9SIzQOFVwn1nwEN03QDP0FzUbiuh22oWGlTQxQz2CZ/2MKTHNoKSgWgqqoG/aG1oWNDfykn9OEArDO12v7Q0WcIdz/ljgksT6A8QcaTsu/0Yu86aQDgMPPHsUHLJsYWiEdkq36hWDPdQMXHxV9xmYnaf2SFtWArwwZhpauBLpwciRNu+wTDaqXdX2vrA4qMDZjg8/r9+oDLcGpoi+XHSrfWUFAgo6TUsUFi0uQeMdyGVHiZGSdGyXiMSkiv2EjTR9tO+bGditmT/D3mtnQlfxKVpzrAtCc96Xqpst8VvCPGXWU6XgbGGauwv/A8VOL6liEh21BKkTZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TaNww5Ijj2a/o3ZvooASZqThU5h1nHOIrUBD40ZzkU=;
 b=SPI0/Qw/N9CQFHyyQ/3rm6+jeY8MgRbB7k5kQhNfa4yb+hBSsgtCGzgKiAiH3BFW7UQox5ATXhzLZWgEvQ1HUeUN7ImcKBSlITW2WbXJIjDFkf5tK+ivuqLT8QLGE+ZmDJ48Ot9nyD8jfO3g+5hJHvMtm/7Ut2PI8q0nI2vhHkpQQQZkakv+5PAuvRFzc9kjA/3o392+J0Mb7yr31DxJ0mYCEOgamaZqTTqm69J/aCgi6FVhMCamHDBclXRuxw4VrT++ER/CyrAy0rBDUS5Cv6UJxRrWuBiqKIXfHvM50XGJM1gA00cjhY1biNmEuOPXGrDEX2VXZ5BT5kmNLXikNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TaNww5Ijj2a/o3ZvooASZqThU5h1nHOIrUBD40ZzkU=;
 b=lUVhg+JZVHmQr7QORv8s+hF+IzoEJ8uHjeWxYKKd9Kmw3ZkO168gXofyymSNP/J+TIMyR+zsTb+J/jdnBL/WMICWy+cdAq/FGIKe17VTJgO7j8IfZhOvHKTqELJi3VQyQHC8W7FGxeLrsFMVcQ3vnPpydZnkWdswKr9EOAGCnOc=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB4487.jpnprd01.prod.outlook.com (2603:1096:604:3a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 04:05:57 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::e58f:5f3b:6d28:b245]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::e58f:5f3b:6d28:b245%4]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 04:05:57 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v1 4/4] mm, memory_hotplug: fix inconsistent
 num_poisoned_pages on memory hotremove
Thread-Topic: [RFC PATCH v1 4/4] mm, memory_hotplug: fix inconsistent
 num_poisoned_pages on memory hotremove
Thread-Index: AQHYWe9cxqv4XAlb9UmiJ69Z/H+tBK0EqeQAgAAMwgA=
Date:   Thu, 28 Apr 2022 04:05:57 +0000
Message-ID: <20220428040556.GA3945421@hori.linux.bs1.fc.nec.co.jp>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <20220427042841.678351-5-naoya.horiguchi@linux.dev>
 <828cc111-40e8-88ed-bb50-fb185e5f0304@huawei.com>
In-Reply-To: <828cc111-40e8-88ed-bb50-fb185e5f0304@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f46bdd49-04f3-4f1e-c837-08da28cc65b7
x-ms-traffictypediagnostic: OSBPR01MB4487:EE_
x-microsoft-antispam-prvs: <OSBPR01MB448784C86550C4110D8E9513E7FD9@OSBPR01MB4487.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LWSASkDn5jTX3OO8mDnLxq1CpQiXDoIpUXBnGLpCgYk1nRiANkrZEb15MT2nnoIDdI5gkFfAjuncRJ56F8L4KFWMgIQcEkn0eVbBTuJ7CFRjzE5iRbOpD5wCO5NfGnlU4PTFQwqsxUCVz6ehXfFP6q4kIzAc9uQihKPFhN6Q3EMXgf7NrEy/m2q0WSVv0zb37YKL5rf8GnclvfXQruCcnNc9DHWYt9T6ol7oBW0DugB6SSsPvXk9E8pI98TJHc6TmzeDUQZMEePGYl0m2SsZLgnr0ErmalWuI19Z4/9bXHW1ti+xPfb/rvPcrcUF0PnRM3IR8YGAVHGbpFZhykZJvyVwHaS+V+PPvuWqbT0pR+no05+ojJE4/9ZyjbdoRTt8PhaA7VcGdKhhnqWYoLSLOHBmgEB59Xlx970kv9MMoUUDhpB/WZLnqBnWqB4ffriwYbNwfHUik30a7/KH7SPZhj/K2xfJJTl+vgeujpUBRaj4BmXwoxW4cmWP5i5MWrKJG03uZqfT0franwEZ+IMPjqnR/NmjVOW9XL4Zvp1a/iZrqz+e7ffmp1t759RiKgkIKG0anRrmFUQIQF2+tfp/XAehCJwJOwhX9ohngdo4f4xmC175UYilgKv1hsIKsrU00/Q1sy3h/Jsv9YFcsgznyCvEmC9kPllBOz44/LmHawx9KYB1Pom/GQy2FJMcJE4TPl0mpzKRyVrCjwjz9fSOzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(4744005)(9686003)(508600001)(83380400001)(4326008)(6506007)(6512007)(71200400001)(66556008)(66476007)(66446008)(186003)(55236004)(53546011)(6486002)(26005)(8936002)(7416002)(85182001)(5660300002)(2906002)(86362001)(8676002)(82960400001)(38100700002)(38070700005)(64756008)(122000001)(54906003)(6916009)(316002)(76116006)(66946007)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0N0eDNzOWhINkwwczE3U3VtWG41Z3U4aXFuVllOb0d0Q0pjZFlUL2xxUzJ6?=
 =?utf-8?B?d1Q3WWNUZFpLUjZGcUhhRmpwdXFNYStWUmQ1eWZjYlJZV2NTRGdLSS91MExM?=
 =?utf-8?B?ZStPNGl6Z0NwY0lKRG1EZGhIWmhub1JwamQ1SGlmZ1FvY1p6dE9xRlQrTnhQ?=
 =?utf-8?B?RDVZaVVRT2RxOENxZW1ib01RV1dTclgxNHZ3Ulp4UmpESUd4SVFjNzFsM2hh?=
 =?utf-8?B?anUwNUdtbExKSVJMNk5LanR5clBBN1hEVk95ZThpckVDR2ozaEdwVWU0RnBv?=
 =?utf-8?B?akNFRFgwRmN2dXdxMktzMkRucDk5RVJIMjYxMTdwTUN6U09RdCt2eXA0eWN3?=
 =?utf-8?B?SG1KVGlLMW9WUnB4MkcwclJVVElHd3l4Qjc5M3V2NW1ENjk1ZmhFbnNlOVB3?=
 =?utf-8?B?aWJXRGl2OFR2S2cxdy9ETFRvRUZBcHdVT2twd2M3clJGQ1N2UUtPaXRxTDc5?=
 =?utf-8?B?Rko5VWU5WGF1QjFMaHNuakQxM0NxQWFXajZlOE9iWWhQV2hKVUg4MEtiWUhK?=
 =?utf-8?B?aW9zQkNZbWdjZE9iS2plM2JGWVBsT3V3b2VOL1VhQzlUN0xqVmlUY1JpdDJ1?=
 =?utf-8?B?V2JKVmtncTZFeHVZMFVsZHlKcGRwVXhFTDNsZ1NJZ0RvRmxndGl3NU1KN25p?=
 =?utf-8?B?K2V3SFZRZTJadlJXczEwU1NObUhueFNERjA1cEdIN0FobHhZSG5SeDd3WlFO?=
 =?utf-8?B?aC9lR3NCZTg4YnhZdHpmTVczNWloUmduVjdoUDRhNEluUHFlTkxFZEhUL1Na?=
 =?utf-8?B?c0s5MWUzRlBsSHNEN0hyWDIrZWZGZnd3bnI3MUpXSnZkK1JHckJXZWJKdGVP?=
 =?utf-8?B?L2xNQkgzSHlYbUZHUWkrMjl2b0tNeGlJUXRtcFFrLzBYRHY4Y3RJZWFxWnBu?=
 =?utf-8?B?RGNocSt4YXhPcDNLSWczVVMxL2lKanBmMTE1cFpYcjljbDlISUtva2tndTdM?=
 =?utf-8?B?RHBVd3NRek5lSVU4ZXlVYkRzbStyR2JvUDBHa215YW1LdWwrL2piY21TTkhK?=
 =?utf-8?B?QitZa0NGY0lkQUlTc0lJcFpZZGE0YkxROVVoUHAvWEk2TmV5RXJ5SEVXbGJG?=
 =?utf-8?B?LzBvejNUMFkvMFl1Sis3MGxST0tKRGFlSVdBdFVCZUh0VWhWZGtqb3VCYnps?=
 =?utf-8?B?S1habXNERDZySnJGV0hzbFZDSXl6cktnTHRxa21uTFphL2tRNll4ZUY0dXlF?=
 =?utf-8?B?R1U5QmRacE1OaHZrd1JmTGpLbnhDS2UxWDFGUUZ2MDlub3Y2d0xwTUx0N0Vy?=
 =?utf-8?B?VVlSRXliV3FzQzZydmtETzgxSk1RZjJDbzhBUmhpaWU3TTBpcUpGZzRiVFZZ?=
 =?utf-8?B?ckZyV2dBZCsxUmNUYmlibnRsbkxLRnVBc0NmaTlkR2ZvSVo0WlFQKy9UNDRW?=
 =?utf-8?B?WEVSalFuUDBpUnJXNkRBN20zdm94QUlWMlBGd2VkZTJTVXNwdElnYVpQc0p3?=
 =?utf-8?B?eGFXa1l0bXRRTS9NQXpyNDgrQ3B0dUJidXF4UmkwcHhkclhNajV1UERDdTk1?=
 =?utf-8?B?d2RkOC84cGx6YWF4QmtYZ2JLUHdBajBOTVR4UEwwcTFKdXdTRi9ieTBIbWdr?=
 =?utf-8?B?all3NjNWSUN2anZqRzJLYXdOaXdCMEJIS1BremF3UkhVM3FpR0k4U0tweDNO?=
 =?utf-8?B?anlSYTZpYmlyeGVDWFYvUk92OWNBdjZFUC81ZkRTV05KaFI2bmZ5OHZ6N1Rq?=
 =?utf-8?B?ZnU0ZzlvdkZCdmtoY3ZOc1duUEV4ZjVCZ0RPbGhmTG5uM2xNTlJ6c1dxUVU0?=
 =?utf-8?B?VzlrWndYUHQ1Ri9KWkt1Ly9Xb2xidmNIbE4veXc3bTRDMTE5bElUZmNxL0d0?=
 =?utf-8?B?eXFxRGtGTjIrUkRtbHErKzl4S3V2WW5mVjU2TndXWDJjaEdNN2daZHVGRkdQ?=
 =?utf-8?B?RmpZN1E0OVJSYUpmbXZJOFpMME5TSytCZEc4eHZPRFAxb0xFSE54enBOUmYr?=
 =?utf-8?B?dnRhU3d2elhGRFZ1cDc0YjBvUElyR2FnekxqZmxIK0o0WmpLL2x0SFVFb0hC?=
 =?utf-8?B?RHZkcmlXdzJwRmc3bmEraGkxaDVxMUl4SEUvNjRaQ3RtM21tM1BaN1VscEdq?=
 =?utf-8?B?a25yL2JFNUlvcXkxUWtZRHFWTE5XcjdjdVByaXRaTVR6QWpJd1E1aW5lcXBl?=
 =?utf-8?B?S1pRK29WcFI2Wmh6a3BJeXZmWk8rWEpkZG13NkpxbjBSS2c2emxkZnBySmdq?=
 =?utf-8?B?Y0dyU0Y2MnpPMVVUdkdjUHNDc3VBSkN6ZDJtMHhncnpqY0JKbWJhMHlsa3l4?=
 =?utf-8?B?YXc2R2pocisrS2lEcEo5SlBJcTlLOW13V1JVdkRReE9IZFZ6Q3hkYTQzOXdG?=
 =?utf-8?B?Z0hmaDU3SDB2WkRmdFdiSWYvMCtWMW9xUlZub0hFa3BMMEFwVUcyczBlcWFM?=
 =?utf-8?Q?JRwW1vNCXFjmzBG8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB2F791A83CCE14A8BF90DC60C44EB1D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46bdd49-04f3-4f1e-c837-08da28cc65b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 04:05:57.1016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnWWAzkCeCVMEz60TzS3hQU/VpyyGq7tijvhEIX691+SK5pMrth97SzuoW7cwxILoSlhY8fxBcmL3F6HOGDRdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4487
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBcHIgMjgsIDIwMjIgYXQgMTE6MjA6MTZBTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi80LzI3IDEyOjI4LCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gRnJv
bTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiANCj4gPiBX
aGVuIG9mZmxpbmluZyBtZW1vcnkgc2VjdGlvbiB3aXRoIGh3cG9pc29uZWQgcGFnZXMsIHRoZSBo
d3BvaXNvbnMgYXJlDQo+ID4gY2FuY2VsZWQuIEJ1dCBudW1fcG9pc29uZWRfcGFnZXMgaXMgbm90
IHVwZGF0ZWQgZm9yIHRoYXQgZXZlbnQsIHNvIHRoZQ0KPiA+IGNvdW50ZXIgYmVjb21lcyBpbmNv
bnNpc3RlbnQuDQo+IA0KPiBJSVVDLCB0aGlzIHdvcmsgaXMgYWxyZWFkeSBkb25lIHZpYSBjbGVh
cl9od3BvaXNvbmVkX3BhZ2VzIHdoZW4gX19yZW1vdmVfcGFnZXMuDQo+IE9yIGFtIEkgbWlzcyBz
b21ldGhpbmc/DQoNCkFjdHVhbGx5IEkgaGFkIHRoZSBzYW1lIHF1ZXN0aW9uIHdoZW4gd3JpdGlu
ZyB0aGlzIHBhdGNoLCBhbmQgZm91bmQgdGhhdA0KX19yZW1vdmVfcGFnZXMoKSBzZWVtcyB0byBi
ZSBjYWxsZWQgZnJvbSBkZXZpY2UgbWVtb3J5IG9yIEhNTSwgYnV0IG5vdCBmcm9tDQpvZmZsaW5l
X3BhZ2VzKCkuICBJZiB5b3UgbWVhbiB0aGF0IHdlIGNvdWxkIG1ha2Ugb2ZmbGluZV9wYWdlcygp
IGNhbGwNCmNsZWFyX2h3cG9pc29uZWRfcGFnZXMoKSwgdGhhdCBzZWVtcyBwb3NzaWJsZSBhbmQg
SSdsbCBjb25zaWRlciBpdC4NCg0KQnV0IGFzIERhdmlkIGFuZCBPc2NhciBwb2ludGVkIG91dCBm
b3IgMC80LCByZW1vdmluZyBQYWdlSFdQb2lzb24gZmxhZ3MNCmluIG9mZmxpbmluZyBzZWVtcyBu
b3QgdG8gYmUgcmlnaHQgdGhpbmcsIHNvIEknZCBsaWtlIHRvIGhhdmUgc29tZSBjb25zZW5zdXMN
Cm9uIHdoYXQgd2F5IHRvIGdvIGZpcnN0Lg0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
