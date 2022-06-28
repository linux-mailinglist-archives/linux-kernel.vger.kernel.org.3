Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCDF55E1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343659AbiF1Iid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344258AbiF1IiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:38:14 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2078.outbound.protection.outlook.com [40.107.114.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805F92B4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSfV1ezBP+BnSWDlqAlMjWz3kvAYRkQKsnrhIR8YQISYm3hggqfl5TVpWVCnBrdRqTUwlC1aw10YbgeLiJdpGxGUAEgo4EfGYKA6J4jj33UC79wTHDEnlZb0QsuY8jzih1crpexOJlo1FWLoXkyx9kpfdo6m3m5JS4X66HEgV4Cwg9R7dP+hY2dN9SMAGmr4K0nZLJKpBm6rhzKryE6qbFpCxi5z5xCUsOEfuBPLiWDfecxpJ+HSm0LfhqETVHxc146aIMeWCv9mejL33lqqcJDQ29DTXTO+5Ak4c1biHplS3Symngel8BHVlYNrO3HjfSA7YfuQQ/iEcqcHmLShfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAGnw70ZDSJQ9M0FxGW3o45TcHxzec07Mrp53fXPOO0=;
 b=dWGKhFGn86/VYM2V2xyMYfk70sBfr3U3tsUa8QSCY4SlGuRBqV+rqJgGZ/cSBUtQdJwBawcNf+4tWJd5SczRxJtoZLIFwRs42k/2Tp6M2+txJhYgKls0GAwKVJGu8anmJXVgkwkL0CfJ83/yvMDemX9vnyU5vN5FIgOYPqQAUe25C63D+bPrjzMt+uNqQ7jz4RAVGK00HYxHiPi29bEoka5KlaKVniVuY8F6Kp67WkTuaVskao41NItxipLRj79p+Iyk8Pc6cUJqk0R5eKDUCbA1Yr6uMnnoFVTwBB0eMFs2W4rmzCYD8CVWZqmOo49nuWPkjbPnFRqLWzA9uo0W6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAGnw70ZDSJQ9M0FxGW3o45TcHxzec07Mrp53fXPOO0=;
 b=B3Xt1GAX0KW2zvV38zWL9CQLB8ghPvrvg1/evf5CWkCN9f0w3HrHIYOmHAvJtshYxjj4xqv9WsFDDOR6zXpIAVBcWgsQJkaj7Oe5uh7gb8eQoys9QbUxcZWhNcM3I31HU8JgbZ1dCmofh7WiqypGbHfFtN3S4w0fo0wjYzCTHIA=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYAPR01MB4974.jpnprd01.prod.outlook.com (2603:1096:404:120::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 08:38:09 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 08:38:09 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/9] mm/hugetlb: remove checking hstate_is_gigantic()
 in return_unused_surplus_pages()
Thread-Topic: [PATCH v2 1/9] mm/hugetlb: remove checking hstate_is_gigantic()
 in return_unused_surplus_pages()
Thread-Index: AQHYh1xSoNvgTy1mRUSP6G7yMyIF8K1d1LUAgABeaQCAAAM+gIAABVoAgACx4YCAA9qpgIAAvr+AgAD/EQA=
Date:   Tue, 28 Jun 2022 08:38:08 +0000
Message-ID: <20220628083808.GB2206088@hori.linux.bs1.fc.nec.co.jp>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-2-naoya.horiguchi@linux.dev>
 <0b69e3ef-0123-4575-b68d-4d9b2067aa0e@huawei.com>
 <YrVv3gKMxbu/dwCs@FVFYT0MHHV2J.usts.net>
 <e9a22524-d9f6-1018-a712-00adb90d432a@huawei.com>
 <20220624083428.GA2070418@hori.linux.bs1.fc.nec.co.jp>
 <YrYMS5sATPzEgUxb@monkey>
 <20220627060231.GA2159330@hori.linux.bs1.fc.nec.co.jp>
 <Yrnn+QS8JCMT/3JV@monkey>
In-Reply-To: <Yrnn+QS8JCMT/3JV@monkey>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8c8d204-0603-4d98-cc99-08da58e1877a
x-ms-traffictypediagnostic: TYAPR01MB4974:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SMV8YQWayax1abCXpBPaEdU/DYTuNZlru6Nm+W+FXWVfQPH2/kD+q4PwCbEt5tI51nvPPO9UZgSpM0jPfntB7SSjUcUB5nxh4BxxnI5vpSlZkXNxYzF/z4KEDubIG4SnEHFs7BgEE7ki+z2HRDDspA+FXlKkbfP/tjLgYW1W51n3NtGSFYoFA2PnUG00BQIXtedx4oy/c+ybubeXaBE1T9Rbd4qV1zPMw2UYNTM1vzvnUUDLZq5e1RUGwwXzb7mlZ4UNCEGL5VVt+4eX6mLL2TqYpZA08tsV5BJU+29Ydsi7B0Od4pmXZYfYjhSnIFI1n3e0ZEkr2UnPj+FfEEs/yStMLj0AYcvjgibPpvd2VMSa49l2iq35B19Yw/rGNG6NpOmV30XFK5jUYHLWcSbKFk/bRCK0kFtLQH2zeRm1hkBF/p07oexv12sXG7YJpZpZt6uUpUzyps3TS/9cceaWqmL8vR4mOhOPU6y7dIIMqcppgp68gI1Iih5slfQGSbj5yWIrfO1Px3IsytIQ6A2KG78pQyg1b+0Fi2VarUfjRm3Ld0602ayHwG8T4GY/BHgkkGKxREVCyhghMu73a6SIbDST75qS+9dLSc8Ard1c+9S8qFQ8kzyGncHqdggSIM6bCN+AA+r6JPAxm4vAm90GGa5xDaj9avNNHYuYytJfh5D3tk84p2VbMQGncXqv/ecPKA35vwLhtG0YpY2wAviqTP9YZgWnZLITd2Dj/ArRjGadUUQ5ghac/AD8QRJZCnIg9t2YJRjAabivyf1GhJgge2FpsVgEIko9CMpqul7cDGw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(2906002)(7416002)(33656002)(55236004)(6916009)(478600001)(6486002)(82960400001)(8936002)(83380400001)(66446008)(66946007)(66476007)(38100700002)(64756008)(66556008)(1076003)(4326008)(85182001)(41300700001)(71200400001)(76116006)(6512007)(122000001)(186003)(316002)(26005)(38070700005)(9686003)(6506007)(86362001)(8676002)(54906003)(53546011)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGZuQzV2TGNzS0tHRGVrVEh3bEVjUVdaS2k0amsrRjIrRG1ZQkdrOFgxdmZi?=
 =?utf-8?B?Znc2STZqdnVsWHMrQ2RPR0k3QUxMVE8wMHNZL3lGWTJUMkR3TXpjQ05XL1ZH?=
 =?utf-8?B?L3dqdEhKaHpEanFyamRncVhzSDdDeXVuODhVMEV1Q1hhbWhLTFBSZmNuR3hI?=
 =?utf-8?B?MS9QWm95aHNTU3lObVVWSlZteXJXa1o3NjdITFRUWHlLaDhTcWp3Q2hmSVpl?=
 =?utf-8?B?emRhbkl4K2N0SDZTYmQ1bjZ6V2hteFl1eU9aQnZGSDFFbkhuZytCQy9QQnZU?=
 =?utf-8?B?dVB6U1plbGpxYnZYdWtyaEZDR0ZaWEZyb0V2dEZaelZLYWJDUnVqeFl2Sm9u?=
 =?utf-8?B?MnNpSjVwU0t2WTNkQ0cwS0p3d2dkYkxZaEM3eS9COE9JVTlrWnBiMW1CSjNQ?=
 =?utf-8?B?TXhiOHNqOGt0YXNzNXBpalBVd0k3RklvZUF1UkZiNEwraTRHbURnZ0VWMS9S?=
 =?utf-8?B?Z21SNjJIajFjUVVkMERHQ0wwUVFVK0Y4MkxiMW1KeWQ4VnNFeU1nZVNRRGEz?=
 =?utf-8?B?c1lpZldkWkpTT0xaQ3duVS9XRVJJdUVoejkrTEQwanFPQWVMSS9PQThtWXFh?=
 =?utf-8?B?ZGV6YTZuMzczcWMwODBhMnQzaVpDaTNRM2F3TTc1czQwMm0vclB5VTRZYnNi?=
 =?utf-8?B?MmpKbWpma3RjUlBNYnhiWWtuVGRONUZEQVNUMGMxZUllTldtQi9SMlR0dkhG?=
 =?utf-8?B?UnhGMnEzOGs3QU1Vd3I5cjNEZGdLN2wzSWkzbkttVlU1YmNSeGJubU04b3cw?=
 =?utf-8?B?Y2FUVDIzUy9XUE1XVEI5YWx5M1NpK0J3bENMdDI1b3FDYSt3MUkxdktYOC9w?=
 =?utf-8?B?c3BEMzBsQ3E1eWJvZGRJdC9QYzlJemR2Nm1IWEd0SUNKc0ZLQzZDc3NRTDJI?=
 =?utf-8?B?dW1vb1N4dWhZYmNCWW5yMGhaeTFQRkZ3TmFCcG5YL0NyOFZ5SnBIQzAxRFhv?=
 =?utf-8?B?eWZycklrZ0FRWjZEY1BSRnNGSU1ySWVvL0pObjRiUjVZalRBWm1vUHBjTEgz?=
 =?utf-8?B?TlFoMWlyNXdRVTNWZU8wZWMycHBUUW9SSjJlMGtUalRlaHlwa29LL0tkWkJr?=
 =?utf-8?B?RU11S3UybWZSbS85MWFGaXpkZTdIZWNSRXV4Vm9Jb3hVcnZBVHBmRnZic0Zz?=
 =?utf-8?B?d1lScHRHRXRWa0xsYmdNZTJ0YStSUXhRN0psTFRYN3U0ZXM0TEFvQ2ZYL2Zy?=
 =?utf-8?B?Z3BFMG1qQTMrNGdFcnJTV2JvVzIyTmlETTdOdDRVMHgyMThMRk4zV1l3Mzkv?=
 =?utf-8?B?RzZnRXdodklxc0J4cjNBOWZ5NG56Qk5FMEpzNFI1TGZBcThoL0k3UXd6ay9J?=
 =?utf-8?B?dkJwRlRtV2NJa3FYbkhVQUg4Mk5CcGZuN2o3Wk9nUE1yU2RKN3pNaERnaWQ3?=
 =?utf-8?B?T2trWG44bTNOMFY2ZDBERHJkTFpIeFZYQ1M1eDd0U0hrMlZHY0JVc1lzYVlU?=
 =?utf-8?B?L2l2U2NBVXFYN2l5L0RKdnpSR1hEOHJSSC9nYzFXenhsNVZBTTZ1L0pya2NJ?=
 =?utf-8?B?cW9RS085NENFclRGNE1BMFJpbXEwTGx3QTV0d0VHR1ZRYlQ4T1VnZlpTaTdU?=
 =?utf-8?B?S2s1R3Z3SGhzNGNsUTFOUkRzd1BqQm4zaEgzTnFZaTVHOWQ5N293d1QxS2tV?=
 =?utf-8?B?Z1Uzb1VVaTVURUtRcDNiQ0FFUkM4N25TbW1sWmFYZ1Y4ZnNqZEVPNCtMOWRh?=
 =?utf-8?B?VjNTZHlqTU83SmJLMHA1dXhGcjhjWjNHTnRDbjdwVnNKWFhUQjdyZE9xRnRU?=
 =?utf-8?B?bnVTcjJiMm03TGZqSkIxSG5mSlBESlhoQ1RPYlJwU1BNeUZJMTZCMTFkVHhq?=
 =?utf-8?B?Qi9TNzIySlV5NzdpYmdZWktVWENZbVpxY1RIMlI1cFU5dVFKWjYwODArOXZr?=
 =?utf-8?B?WFU3eWJTY3llcHljZVR2UW5kb2J3VmZFblpIVFoxRmYzU3FIbzdQTXJ2S0I5?=
 =?utf-8?B?cU5rSWpNenBHV2F4QVNHemdJaFVVZEVlVk5CWkh1bDd6cXREeVdpdDMxUDhX?=
 =?utf-8?B?MVF2ckJhMFNJdEJJOW0xbGh3WFRKWUdyQTF0WENpcG02NFNabklFZ0M3SVBC?=
 =?utf-8?B?dEIwbjhlZUJVZkcvWVJQVUw1Q0tiOEl2d0o3UEo0c2lpWVNrMHJET2Jmdksx?=
 =?utf-8?B?bnpaNWpFeE81K0puU1VUVmhyY1pXR1VOcmhOOTI1SDEwd2JRMmp1T3NIKzBN?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <230E9C4B82BCE046BBB1A0FCA63682F5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c8d204-0603-4d98-cc99-08da58e1877a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 08:38:09.0048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPSBAW7hY/ODEybr3LxS9XrTB+80TGBOhZlmgtBGMD4ddRiC4eDA/mMElpjml+Jk3A4oBPiJAll00u2/je/cJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4974
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKdW4gMjcsIDIwMjIgYXQgMTA6MjU6MTNBTSAtMDcwMCwgTWlrZSBLcmF2ZXR6IHdy
b3RlOg0KPiBPbiAwNi8yNy8yMiAwNjowMiwgSE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p
IHdyb3RlOg0KPiA+IE9uIEZyaSwgSnVuIDI0LCAyMDIyIGF0IDEyOjExOjA3UE0gLTA3MDAsIE1p
a2UgS3JhdmV0eiB3cm90ZToNCj4gPiA+IE9uIDA2LzI0LzIyIDA4OjM0LCBIT1JJR1VDSEkgTkFP
WUEo5aCA5Y+jIOebtOS5nykgd3JvdGU6DQo+ID4gPiA+IE9uIEZyaSwgSnVuIDI0LCAyMDIyIGF0
IDA0OjE1OjE5UE0gKzA4MDAsIE1pYW9oZSBMaW4gd3JvdGU6DQo+ID4gPiA+ID4gT24gMjAyMi82
LzI0IDE2OjAzLCBNdWNodW4gU29uZyB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIEZyaSwgSnVuIDI0
LCAyMDIyIGF0IDEwOjI1OjQ4QU0gKzA4MDAsIE1pYW9oZSBMaW4gd3JvdGU6DQo+ID4gPiA+ID4g
Pj4gT24gMjAyMi82LzI0IDc6NTEsIE5hb3lhIEhvcmlndWNoaSB3cm90ZToNCj4gPiA+ID4gPiA+
Pj4gRnJvbTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiA+
ID4gPiA+Pg0KPiA+ID4gPiA+ID4+IElJVUMgaXQgbWlnaHQgYmUgYmV0dGVyIHRvIGRvIHRoZSBi
ZWxvdyBjaGVjazoNCj4gPiA+ID4gPiA+PiAJLyoNCj4gPiA+ID4gPiA+PiAJICogQ2Fubm90IHJl
dHVybiBnaWdhbnRpYyBwYWdlcyBjdXJyZW50bHkgaWYgcnVudGltZSBnaWdhbnRpYyBwYWdlDQo+
ID4gPiA+ID4gPj4gCSAqIGFsbG9jYXRpb24gaXMgbm90IHN1cHBvcnRlZC4NCj4gPiA+ID4gPiA+
PiAJICovDQo+ID4gPiA+ID4gPj4gCWlmIChoc3RhdGVfaXNfZ2lnYW50aWMoaCkgJiYgIWdpZ2Fu
dGljX3BhZ2VfcnVudGltZV9zdXBwb3J0ZWQoKSkNCj4gPiA+ID4gPiA+PiAJCWdvdG8gb3V0Ow0K
PiA+ID4gPiA+ID4+DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoZSBjaGFuZ2UgbG9va3Mg
Z29vZCB0byBtZS4gSG93ZXZlciwgdGhlIGNvbW1lbnRzIGFib3ZlIGlzIHVubmVjZXNzYXJ5DQo+
ID4gPiA+ID4gPiBzaW5jZSBnaWdhbnRpY19wYWdlX3J1bnRpbWVfc3VwcG9ydGVkKCkgaXMgc3Ry
YWlnaHRmb3J3YXJkLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFncmVlLiBUaGUgY29tbWVudHMg
Y2FuIGJlIHJlbW92ZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGFuayB5b3UsIGJvdGguIEFkZGlu
ZyAhZ2lnYW50aWNfcGFnZV9ydW50aW1lX3N1cHBvcnRlZCB3aXRob3V0IGNvbW1lbnQNCj4gPiA+
ID4gbWFrZXMgc2Vuc2UgdG8gbWUuDQo+ID4gPiANCj4gPiA+IFRoZSBjaGFuZ2UgYWJvdmUgbWFr
ZXMgc2Vuc2UgdG8gbWUuICBIb3dldmVyLCAuLi4NCj4gPiA+IA0KPiA+ID4gSWYgd2UgbWFrZSB0
aGUgY2hhbmdlIGFib3ZlLCB3aWxsIHdlIGhhdmUgdGhlIHNhbWUgc3RyYW5nZSBzaXR1YXRpb24g
ZGVzY3JpYmVkDQo+ID4gPiBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ugd2hlbiAhZ2lnYW50aWNfcGFn
ZV9ydW50aW1lX3N1cHBvcnRlZCgpIGlzIHRydWU/DQo+ID4gPiANCj4gPiA+IElJVUMsICFnaWdh
bnRpY19wYWdlX3J1bnRpbWVfc3VwcG9ydGVkIGltcGxpZXMgdGhhdCBnaWdhbnRpYyBodWdldGxi
DQo+ID4gPiBwYWdlcyBjYW4gbm90IGJlIGFsbG9jYXRlZCBvciBmcmVlZCBhdCBydW4gdGltZS4g
IFRoZXkgY2FuIG9ubHkgYmUNCj4gPiA+IGFsbG9jYXRlZCBhdCBib290IHRpbWUuICBTbywgdGhl
cmUgc2hvdWxkIE5FVkVSIGJlIHN1cnBsdXMgZ2lnYW50aWMNCj4gPiA+IHBhZ2VzIGlmICFnaWdh
bnRpY19wYWdlX3J1bnRpbWVfc3VwcG9ydGVkKCkuDQo+ID4gDQo+ID4gSSBoYXZlIHRoZSBzYW1l
IHVuZGVyc3RhbmRpbmcgYXMgdGhlIGFib3ZlLg0KPiA+IA0KPiA+ID4gIFRvIGF2b2lkIHRoaXMg
c2l0dWF0aW9uLA0KPiA+ID4gcGVyaGFwcyB3ZSBzaG91bGQgY2hhbmdlIHNldF9tYXhfaHVnZV9w
YWdlcyBhcyBmb2xsb3dzIChub3QgdGVzdGVkKT8NCj4gPiANCj4gPiBUaGUgc3VnZ2VzdGVkIGRp
ZmYgbG9va3MgY2xlYXJlciBhYm91dCB3aGF0IGl0IGRvZXMsIHNvIEknZCBsaWtlIHRvIHRha2Ug
aXQNCj4gPiBpbiB0aGUgbmV4dCB2ZXJzaW9uLiAgVGhlbiwgd2hhdCBkbyB3ZSBkbyBvbiB0aGUg
ImlmIChoc3RhdGVfaWZfZ2lnYW50aWMoKSkiDQo+ID4gY2hlY2sgaW4gcmV0dXJuX3VudXNlZF9z
dXJwbHVzX3BhZ2VzIGluIHRoZSBvcmlnaW5hbCBzdWdnZXN0aW9uPyAgU2hvdWxkIGl0DQo+ID4g
YmUga2VwdCBhcyBpcywgb3IgcmVtb3ZlZCwgb3IgY2hlY2tlZCB3aXRoICFnaWdhbnRpY19wYWdl
X3J1bnRpbWVfc3VwcG9ydGVkKCk/DQo+ID4gSSBndWVzcyB0aGF0IHRoZSBuZXcgY2hlY2tzIHBy
ZXZlbnQgY2FsbGluZyByZXR1cm5fdW51c2VkX3N1cnBsdXNfcGFnZXMoKQ0KPiA+IGR1cmluZyBw
b29sIHNocmlua2luZywgc28gdGhlIGNoZWNrIHNlZW1zIG5vdCBuZWNlc3NhcnkgYW55IG1vcmUu
DQo+IA0KPiBNeSBmaXJzdCB0aG91Z2h0IHdhcyB0byBrZWVwIHRoZSBjaGVjayBpbiByZXR1cm5f
dW51c2VkX3N1cnBsdXNfcGFnZXMoKSBhcyBpdA0KPiBpcyBjYWxsZWQgaW4gb3RoZXIgY29kZSBw
YXRocy4gIEhvd2V2ZXIsIGl0IFNIT1VMRCBvbmx5IHRyeSB0byBmcmVlIHN1cnBsdXMNCj4gaHVn
ZXRsYiBwYWdlcy4gIFdpdGggdGhlIG1vZGlmaWNhdGlvbnMgdG8gc2V0X21heF9odWdlX3BhZ2Vz
IHdlIHdpbGwgbm90DQo+IGhhdmUgYW55IHN1cnBsdXMgZ2lnYW50aWMgcGFnZXMgaWYgIWdpZ2Fu
dGljX3BhZ2VfcnVudGltZV9zdXBwb3J0ZWQsIHNvDQo+IHRoZSBjaGVjayBjYW4gYmUgcmVtb3Zl
ZC4NCj4gDQo+IEFsc28gbm90ZSB0aGF0IHdlIG5ldmVyIHRyeSB0byBkeW5hbWljYWxseSBhbGxv
Y2F0ZSBzdXJwbHVzIGdpZ2FudGljIHBhZ2VzLg0KPiBUaGlzIGFsc28gaXMgbGVmdCBvdmVyIGZy
b20gdGhlIHRpbWUgd2hlbiB3ZSBjb3VsZCBub3QgZWFzaWx5IGFsbG9jYXRlIGENCj4gZ2lnYW50
aWMgcGFnZSBhdCBydW50aW1lLiAgSXQgd291bGQgbm90IHN1cnByaXNlIG1lIGlmIHNvbWVvbmUg
Zm91bmQgYSB1c2UNCj4gY2FzZSB0byBlYXNlIHRoaXMgcmVzdHJpY3Rpb24gaW4gdGhlIGZ1dHVy
ZS4gIEVzcGVjaWFsbHkgc28gaWYgMUcgVEhQIHN1cHBvcnQNCj4gaXMgZXZlciBhZGRlZC4gIElm
IHRoaXMgaGFwcGVucywgdGhlIGNoZWNrIHdvdWxkIGJlIG5lY2Vzc2FyeSBhbmQgSSB3b3VsZA0K
PiBndWVzcyB0aGF0IGl0IHdvdWxkIG5vdCBiZSBhZGRlZC4NCj4gDQo+IFNvcnJ5IGZvciB0aGlu
a2luZyBvdXIgbG91ZCEhISAgQWx0aG91Z2ggbm90IG5lY2Vzc2FyeSwgaXQgJ21pZ2h0JyBiZSBh
IGdvb2QNCj4gaWRlYSB0byBsZWF2ZSB0aGUgY2hlY2sgYmVjYXVzZSBpdCB3b3VsZCBiZSBvdmVy
bG9va2VkIGlmIGR5bmFtaWMgYWxsb2NhdGlvbg0KPiBvZiBnaWdhbnRpYyBzdXJwbHVzIHBhZ2Vz
IGlzIGV2ZXIgYWRkZWQuICBJIGRvIG5vdCBoYXZlIGEgc3Ryb25nIG9waW5pb24uDQoNCk9LLCBz
byBsZXQncyBrZWVwIHRoZSBjaGVjay4NCg0KPiANCj4gUC5TLiBUaGlzIGFsc28gcmVtaW5kcyBt
ZSB0aGF0IGEgc2ltaWxhciBjaGVjayBzaG91bGQgYmUgYWRkZWQgdG8gdGhlDQo+IGRlbW90ZSBo
dWdldGxiIGNvZGUgcGF0aC4gIEl0IHdvdWxkIGJlIGJhZCBpZiAhZ2lnYW50aWNfcGFnZV9ydW50
aW1lX3N1cHBvcnRlZA0KPiBhbmQgd2UgZGVtb3RlZCBhIGdpZ2FudGljIHBhZ2UgaW50byBudW1l
cm91cyBub24tZ2lnYW50aWMgcGFnZXMuICBJIHdpbGwNCj4gc2VuZCBhIHBhdGNoLg0KDQpTb3Vu
ZHMgbmljZS4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
