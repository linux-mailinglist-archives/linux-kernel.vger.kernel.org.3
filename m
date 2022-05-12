Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFA55257FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 00:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359303AbiELWtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 18:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359284AbiELWtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 18:49:22 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2057.outbound.protection.outlook.com [40.107.113.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3219284917
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asrZNaIQ07J7AzuTo9e6IiyZytwY7auXYJoOUcG4by8qxTO+5XWHmsQau0Eiyv3QdCYVrVjMuxuzbr0GXL7tiqKbBgvbOu/S+KZsVMzm6P2bHv5DKQdD1eZsf/8B0OcZO/QGdW3UzPn6CgQYEUOi66R6KQAkwKPpGjNHB/QBexfLOeKg+2Tb2M6orWgdQ6c1zFFvlNu+N4oe0VvvU6ZciMEf+uDelTx7FhlQhiOM1k6/msc1OVPGHHDw3svyqToP12hhKnv01+x9X3lDlM2W0TN6ALnLxZBVjQWEuAL8hJ4gcpDP2oBlgs0CcnjIOzh8+ysG+uew0qAa5cbhRpcTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6T2IcItluZgtOMhpdXyw6XvsWVvImznwtw7GePIwew8=;
 b=R2zMWs1C7uyDo9Z1zFqN4cgQaWnn1oOuTeg7Ru8o4jnsXF8MI7rY+tPLXOEfvxNPznmgY8xC3wnPtnZuL/ta/qiOi9mscphUA79jwQtFF314/Akjolcqnnr6Pdcmp+JmQnJi7mCSNd7xhY3jN9XluxGlq+iGi2EXzL0P+fwdDgh4gUlboUck500dlzdac6Pqhu/E+bbC1OBL246Doa3eLrPK85ies10fT2vBPDUMH3WCGJg4aj0pH5PYsxVH4BjeuEMuJxS9HWCJZn7zHsHSuktEiTHsyaTqPST601MNU5NIkYtGHblwj4NkeCtS0uyIEVYJOH0aDta75hnr/Lc8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T2IcItluZgtOMhpdXyw6XvsWVvImznwtw7GePIwew8=;
 b=Z7HgvlpckQx8zlZ6PLqSNvnzS8IqANrt7CgQ7JhP648gA96xDdL2fMSw541DE/Us+mB7icHe5m3NUPvzkRsJU7hPWstmrnnwLjWMUdbVrLfsmJB2uAXwzNvXipIH8w0nFeyTvzr/sq4nNke8KadsEGXftLAFy7Lph6oudoN56Ag=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY2PR01MB2874.jpnprd01.prod.outlook.com (2603:1096:404:7b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Thu, 12 May
 2022 22:49:18 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8%7]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 22:49:18 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Jane Chu <jane.chu@oracle.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 1/4] mm, hwpoison, hugetlb: introduce
 SUBPAGE_INDEX_HWPOISON to save raw error page
Thread-Topic: [RFC PATCH v1 1/4] mm, hwpoison, hugetlb: introduce
 SUBPAGE_INDEX_HWPOISON to save raw error page
Thread-Index: AQHYWe9W9tO6RJGlSkiUGSIFLMrw+60b7DwAgAAE6oA=
Date:   Thu, 12 May 2022 22:49:18 +0000
Message-ID: <20220512224917.GA277117@hori.linux.bs1.fc.nec.co.jp>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <20220427042841.678351-2-naoya.horiguchi@linux.dev>
 <9832f588-7d1b-edc2-2f20-da1990a8ab03@oracle.com>
In-Reply-To: <9832f588-7d1b-edc2-2f20-da1990a8ab03@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b99949f-6ef1-48cd-6960-08da3469a5a6
x-ms-traffictypediagnostic: TY2PR01MB2874:EE_
x-microsoft-antispam-prvs: <TY2PR01MB2874226D4026E346486523CBE7CB9@TY2PR01MB2874.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qKoC/hs/5NEnQ3wq8NexG3qw5ZfQ7XoPpKiTsxe9QbEKwBaHySpW0NxH9kXTrKjF3vv25csXcvtAIOlAhi5hL6oTY6PTBFTnSUMtXQdtEZmGt3MRg+yUzl9u7nJNaE5dG1s+q0hPB/d4glsTQgV4Lq3sDFTwYzhqOHkIN6aEJLMfOPezgT77QxzjvUxkS3IWaR0DsLx4Cl2qQyJCuwMxRvtrncxuYZTaJEgloB2YZWx/G25CbUc4KoZVlfiVdn5hlkheDFUEFEIi/ghfQcM1eTWD0aMfjYft7Jhrd8+lSa6mNmAoSV9JPJ3eNloQodC4Kou0Y9WyEykOYKgAGeSzxy0qP07VOugg/JJLTqvngaXqvQ4S5uLH10ciNDnmmYSssSxcv3qoVK7O1gfRjM1OMqL56xLVGLPKE5hqf9xlBQnDyf7ZwXWccyjrJDU7tMGJ7p0RUBwOd/NRoGYknvnZXrjdnml2kNrwCLvDxxNET+H1tiYa5GcxcCRsVLY+nzenK3utb8kjWXwBcxQKBOMym3iGM0mO40xmSfqQWXF1h+Ene19U7uVaIvpDn/fZeGljRt3dOSReIwBQm5JssHubj8yWWwGRVboF2ZKL80S6tNQgPs4MNE0EXrOfAj2v6PUuAxh/rQmZrid6K+ZbjOUoDFeSBpKz5mI6JQCwUy60GTI4RTYkXM5Gu1C3ko59zgtoZ5av5+wFw0ul06IWGAOqzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(33656002)(76116006)(66946007)(66556008)(66476007)(64756008)(8676002)(186003)(66446008)(4326008)(1076003)(83380400001)(86362001)(71200400001)(6512007)(6486002)(26005)(9686003)(316002)(54906003)(6916009)(55236004)(6506007)(53546011)(122000001)(82960400001)(85182001)(2906002)(7416002)(8936002)(5660300002)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzBXdUVOaU91Qlh5NUJQdXZaRmhjUzRPTC9TSG91VHZuNzQyaDFNZ1Z4UitL?=
 =?utf-8?B?cUdEWE1rNzhTMk5vNElUYzB3dzZuSk95Nm9rRTBVcVVPcDRQcFZMd2FDSy9Z?=
 =?utf-8?B?N3B6bWVSZE5NZkREejA0bXV3SmNNN3UyZXJwbnc4YWxIWWVma1FIZVB0WGZp?=
 =?utf-8?B?eTFyMjJZckNkQzZjbUZGUG5JcWdiSVdlMFVLcW5IREV1aU1mTlBGelc0bEpW?=
 =?utf-8?B?Umk2THNjbjR4UGczS2Y5bTVwdzhiSGtJM2EwRE5jbS9tS3pJYld4Rzhkbm1B?=
 =?utf-8?B?RTEzb3lBWjk2N2gyOVprdVlPSjRQYkEwa3Y3bi9sZ24xcG90NkpmZittUFk1?=
 =?utf-8?B?VHY5enZaR2ptajBoYVhHR2VtYXc2bGE3NWdPN3Q0WHdtRlcvRWZtNEJyZWY0?=
 =?utf-8?B?UW9EakxNWnFiekZPVHpROW5CazQrLzZGV0lqWWZzcTRyRWpGUklTaGI0aUVt?=
 =?utf-8?B?WlpBME5KbVlIZnpQMnoyVzBBOFpGclF1bVNzRUFtUDJySjVSU1Z1MklaeDMw?=
 =?utf-8?B?cjhMZlpXd1RvSldNd1ZkN0VMNkpRcWx0eUhSa2JhTWRwMFcyY2tBNmJJZzlz?=
 =?utf-8?B?c0FOWDFLb3VrUjBmOEIxM1gvTEpvNW5FV0pvUC9RZGJZbWkrd2RpWWVjNU9Z?=
 =?utf-8?B?dnFkakYyS2xkOVYyUHVBTkF4TzRWNU82c0xEQldoUUhKRE9Kb2VtbXkzdldY?=
 =?utf-8?B?eVVheDBJeU1zam5mL0pFYTA3QVAvSkFmb0pLa2dEVm9qQk9VbWNOSFRSSGRx?=
 =?utf-8?B?R1ZDMDhOdVcyU1FaNVlVK2FoNGI5WTNacG1WdEl6TjdOVkJjc2ZFNk5uQXZ6?=
 =?utf-8?B?Ylg1TTZWSzFadW9NN1ZOR3k1LzVKK2dnYlU0cW85MVR3NDBaU1hlU0xlVjNk?=
 =?utf-8?B?aTdIRlhhcUtPMkkwcEVBODBkSFZMUWtPUEdGRUdzMXVsSFNvdEt1ZXBuZ2FD?=
 =?utf-8?B?OWJIc3pQZkdPbm9TVlFhYy9ZOXdUWks0VFBZYWU0Qmwxb1R5WDRROXpqb1lI?=
 =?utf-8?B?R0VZWEpTcXdvN2lDSjRESFcvUjd3WmFnaWFWYnBrVmc5WCtlSVl4eG5hS1gv?=
 =?utf-8?B?cE15NlFxQWVyUm82Z3F6WDh3RnBxWmE1eUVGaU1oSENMSzNIVG04YjJYc2I4?=
 =?utf-8?B?YTV6TVhsNDUzR2ttaEkrYk9BaGgrWU5VblBlKy9GcUhqYlJKK0liTERQWW9q?=
 =?utf-8?B?bnc4RnkzUjM1ZHh1TEdNTFkzSE56TjBrYTFoc1BMc0MzR2RVelNhUWZIMzJ4?=
 =?utf-8?B?aHRldDhmaUNZWCtxNGxnUzM3NHRzUFpua0Z0SzRPQnRRU0JqN1o2aWZlMmwr?=
 =?utf-8?B?VEdkZzMvbVorbms1Z1VaSkExOXhzUmc4MGZ4b0pzZmFQR1NwMTVZUWtnQ09B?=
 =?utf-8?B?U2s0NXdROGQrNjFxMVdoWkgrYkhhWDRkY1JlTDhlNDFUeWZGSmdjUUxXTW84?=
 =?utf-8?B?TmxSUzViVjVQUzc4WWdhWUNBUVVuaGlHVjBlc1hwWGcrY25GdG1vKzZwUmps?=
 =?utf-8?B?dDJXWGJtSEhZUmtoWFo2Um9XdVlhc3ZCVENKaG9qQ0lSS3NLUVNKbzA2eHVT?=
 =?utf-8?B?bWtjNWdPcXU2a0ltU0ZnZ3Z5M0dTbW9ZU2pXU1FNdVFEK0RjTUJxVlNZeEQ1?=
 =?utf-8?B?T0RrZTNEaGkwY3pGZStRU2VmTkZ5L3o2S0F3bTFsTkhkakZKUkZ4RytJZ1Bz?=
 =?utf-8?B?RmtHV2laY1Q1WmxRVzZ0REN4ZmF6Snh5NmI5Ni9wc3M3VUlGRGc2VHVrQnNT?=
 =?utf-8?B?OXNBMjZLbG9Gbm44SVBCM2h0RVdGUGhtQmh5eHUyUU8yY1lGUWNueUl6OG91?=
 =?utf-8?B?OFZkeVhaeVJIclZQdXZubmZFeUZiZEhKbysyVmlOWUorTE0yUzJhTDU3dWdZ?=
 =?utf-8?B?SE9CUzZ4Tm9sZVhQSGpyTjNmWEx0MWxxWWFkWnJLaDVEY2s5Y2Q5SFU0RGdN?=
 =?utf-8?B?TkNQOUtyOEV0cTE4MjZCRDhLM0dTbG54cDNSZmtjbnJSVHc3c3B1U0dYdXdE?=
 =?utf-8?B?NEhtUnRUMWhQbHlyeGFnS3NxTS9oRjFKRjdBN3hqZS9SMElJd0RWd3VHNEov?=
 =?utf-8?B?bmM1Y1RHZTV5MCtZT0tVSWpXYWxLdG5FVi9BSG5ybkdtWmo5NGFzOS9ndG02?=
 =?utf-8?B?MDFQWm1qb3pHLzdHVk5GSFJQdm96cDZHdVg1QU1DYVFzSHAwRTdKa3pvd3Az?=
 =?utf-8?B?bHpiN0tGMHppMWxrN3NMWWFtZ3R5R1NQMHFSdEtaUTBqVTMzQmkvdksxWU80?=
 =?utf-8?B?WjRPWER5NDdCdUk4UDh4TzhUUFJ2R1FhTEd1WFR1MmZ6M0xrVzA1T0hER2NX?=
 =?utf-8?B?STlxdjVXRFg0VFJTenVYcG9oWDArZFR2ZWMzbkhaNFJzSjhxSmpzdTI5bHFj?=
 =?utf-8?Q?i7ZunVbN6nXZyoQM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1C8EEACE97FC941B168C4101DD9910C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b99949f-6ef1-48cd-6960-08da3469a5a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 22:49:18.1547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42Wu3ynFcxQO/58B2iumNPkrTqyQIlvblm9jfqBRIqhCXBNZitX1aLDAcXJbUGV3ZRj0uc0f8+WQsxKNW2Cn6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2874
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXkgMTIsIDIwMjIgYXQgMTA6MzE6NDJQTSArMDAwMCwgSmFuZSBDaHUgd3JvdGU6
DQo+IE9uIDQvMjYvMjAyMiA5OjI4IFBNLCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gRnJv
bTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiANCj4gPiBX
aGVuIGhhbmRsaW5nIG1lbW9yeSBlcnJvciBvbiBhIGh1Z2V0bGIgcGFnZSwgdGhlIGVycm9yIGhh
bmRsZXIgdHJpZXMgdG8NCj4gPiBkaXNzb2x2ZSBhbmQgdHVybiBpdCBpbnRvIDRrQiBwYWdlcy4g
IElmIGl0J3Mgc3VjY2Vzc2Z1bGx5IGRpc3NvbHZlZCwNCj4gPiBQYWdlSFdQb2lzb24gZmxhZyBp
cyBtb3ZlZCB0byB0aGUgcmF3IGVycm9yIHBhZ2UsIHNvIGJ1dCB0aGF0J3MgYWxsDQo+ID4gcmln
aHQuICBIb3dldmVyLCBkaXNzb2x2ZSBzb21ldGltZXMgZmFpbHMsIHRoZW4gdGhlIGVycm9yIHBh
Z2UgaXMgbGVmdA0Kbm5uPiA+IGFzIGh3cG9pc29uZWQgaHVnZXBhZ2UuIEl0J3MgdXNlZnVsIGlm
IHdlIGNhbiByZXRyeSB0byBkaXNzb2x2ZSBpdCB0bw0KPiA+IHNhdmUgaGVhbHRoeSBwYWdlcywg
YnV0IHRoYXQncyBub3QgcG9zc2libGUgbm93IGJlY2F1c2UgdGhlIGluZm9ybWF0aW9uDQo+ID4g
YWJvdXQgd2hlcmUgdGhlIHJhdyBlcnJvciBwYWdlIGlzIGxvc3QuDQo+ID4gDQo+ID4gVXNlIHRo
ZSBwcml2YXRlIGZpZWxkIG9mIGEgdGFpbCBwYWdlIHRvIGtlZXAgdGhhdCBpbmZvcm1hdGlvbi4g
IFRoZSBjb2RlDQo+ID4gcGF0aCBvZiBzaHJpbmtpbmcgaHVnZXBhZ2UgcG9vbCB1c2VkIHRoaXMg
aW5mbyB0byB0cnkgZGVsYXllZCBkaXNzb2x2ZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBO
YW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+IC0tLQ0KPiA+ICAg
aW5jbHVkZS9saW51eC9odWdldGxiLmggfCAyNCArKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgIG1tL2h1Z2V0bGIuYyAgICAgICAgICAgIHwgIDkgKysrKysrKysrDQo+ID4gICBtbS9tZW1v
cnktZmFpbHVyZS5jICAgICB8ICAyICsrDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDM1IGluc2Vy
dGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9odWdldGxiLmgg
Yi9pbmNsdWRlL2xpbnV4L2h1Z2V0bGIuaA0KPiA+IGluZGV4IGFjMmExZDc1OGE4MC4uNjg5ZTY5
Y2I1NTZiIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvaHVnZXRsYi5oDQo+ID4gKysr
IGIvaW5jbHVkZS9saW51eC9odWdldGxiLmgNCj4gPiBAQCAtNDIsNiArNDIsOSBAQCBlbnVtIHsN
Cj4gPiAgIAlTVUJQQUdFX0lOREVYX0NHUk9VUCwJCS8qIHJldXNlIHBhZ2UtPnByaXZhdGUgKi8N
Cj4gPiAgIAlTVUJQQUdFX0lOREVYX0NHUk9VUF9SU1ZELAkvKiByZXVzZSBwYWdlLT5wcml2YXRl
ICovDQo+ID4gICAJX19NQVhfQ0dST1VQX1NVQlBBR0VfSU5ERVggPSBTVUJQQUdFX0lOREVYX0NH
Uk9VUF9SU1ZELA0KPiA+ICsjZW5kaWYNCj4gPiArI2lmZGVmIENPTkZJR19DR1JPVVBfSFVHRVRM
Qg0KPiA+ICsJU1VCUEFHRV9JTkRFWF9IV1BPSVNPTiwNCj4gPiAgICNlbmRpZg0KPiA+ICAgCV9f
TlJfVVNFRF9TVUJQQUdFLA0KPiA+ICAgfTsNCj4gPiBAQCAtNzg0LDYgKzc4NywyNyBAQCBleHRl
cm4gaW50IGRpc3NvbHZlX2ZyZWVfaHVnZV9wYWdlKHN0cnVjdCBwYWdlICpwYWdlKTsNCj4gPiAg
IGV4dGVybiBpbnQgZGlzc29sdmVfZnJlZV9odWdlX3BhZ2VzKHVuc2lnbmVkIGxvbmcgc3RhcnRf
cGZuLA0KPiA+ICAgCQkJCSAgICB1bnNpZ25lZCBsb25nIGVuZF9wZm4pOw0KPiA+ICAgDQo+ID4g
KyNpZmRlZiBDT05GSUdfTUVNT1JZX0ZBSUxVUkUNCj4gPiArLyoNCj4gPiArICogcG9pbnRlciB0
byByYXcgZXJyb3IgcGFnZSBpcyBsb2NhdGVkIGluIGhwYWdlW1NVQlBBR0VfSU5ERVhfSFdQT0lT
T05dLnByaXZhdGUNCj4gPiArICovDQo+ID4gK3N0YXRpYyBpbmxpbmUgc3RydWN0IHBhZ2UgKmh1
Z2V0bGJfcGFnZV9od3BvaXNvbihzdHJ1Y3QgcGFnZSAqaHBhZ2UpDQo+ID4gK3sNCj4gPiArCXJl
dHVybiAodm9pZCAqKXBhZ2VfcHJpdmF0ZShocGFnZSArIFNVQlBBR0VfSU5ERVhfSFdQT0lTT04p
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgaHVnZXRsYl9zZXRfcGFn
ZV9od3BvaXNvbihzdHJ1Y3QgcGFnZSAqaHBhZ2UsDQo+ID4gKwkJCQkJc3RydWN0IHBhZ2UgKnBh
Z2UpDQo+ID4gK3sNCj4gPiArCXNldF9wYWdlX3ByaXZhdGUoaHBhZ2UgKyBTVUJQQUdFX0lOREVY
X0hXUE9JU09OLCAodW5zaWduZWQgbG9uZylwYWdlKTsNCj4gPiArfQ0KPiANCj4gV2hhdCBoYXBw
ZW5zIGlmIHRoZSAtPnByaXZhdGUgZmllbGQgaXMgYWxyZWFkeSBob2xkaW5nIGEgcG9pc29uZWQg
cGFnZSANCj4gcG9pbnRlcj8gIHRoYXQgaXMsIGluIGEgc2NlbmFyaW8gb2YgbXVsdGlwbGUgcG9p
c29uZWQgcGFnZXMgd2l0aGluIGEgDQo+IGh1Z2VwYWdlLCB3aGF0IHRvIGRvPyAgbWFyayB0aGUg
ZW50aXJlIGhwYWdlIHBvaXNvbmVkPw0KDQpIaSBKYW5lLA0KDQpDdXJyZW50IHZlcnNpb24gZG9l
cyBub3QgY29uc2lkZXIgbXVsdGlwbGUgcG9pc29uZWQgcGFnZXMgc2NlbmFyaW8sDQpzbyBpZiB0
aGF0IGhhcHBlbnMsIC0+cHJpdmF0ZSBmaWVsZCB3b3VsZCBiZSBzaW1wbHkgb3ZlcndyaXR0ZW4u
DQpCdXQgaW4gdGhpcyBwYXRjaCBodWdldGxiX3NldF9wYWdlX2h3cG9pc29uKCkgaXMgY2FsbGVk
IGp1c3QgYWZ0ZXINCiJpZiAoVGVzdFNldFBhZ2VIV1BvaXNvbihoZWFkKSkiIGNoZWNrLCBzbyBo
dWdldGxiX3NldF9wYWdlX2h3cG9pc29uKCkNCmlzIG5vdCBleHBlY3RlZCB0byBiZSBjYWxsZWQg
bW9yZSB0aGFuIG9uY2Ugb24gYSBzaW5nbGUgaHVnZXBhZ2UuDQoNCldoZW4gd2UgdHJ5IHRvIHN1
cHBvcnQgbXVsdGlwbGUgcG9pc29uIHNjZW5hcmlvLCB3ZSBtYXkgYWRkIHNvbWUgY29kZQ0KaW4g
ImFscmVhZHkgaHdwb2lzb25lZCIgcGF0aCB0byBzdG9yZSBhZGRpdGlvbmFsIGluZm8gYWJvdXQg
dGhlIHJhdw0KZXJyb3IgcGFnZS4gVGhlIGltcGxlbWVudGF0aW9uIGRldGFpbCBpcyBzdGlsbCB0
byBiZSBkZXRlcm1pbmVkLg0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
