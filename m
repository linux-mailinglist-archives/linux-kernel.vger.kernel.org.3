Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C484B5421AC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiFHEU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiFHEMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:12:49 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on20614.outbound.protection.outlook.com [IPv6:2a01:111:f403:7010::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AFD2C1AD0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4qE74FhUYy96S8/bZY9tgBIS2LbsinecgXlxaCIRFFTCTUFojQ++u6U8m9JVmrUVb8gvxyJz2OCeGNZ3d/MSrCvl+w31CQDPQel+Wjhpo6JO5IzQVDAK9o8odcOz05b3RVtpWl9wzPj1nEAJ+ya7Vj9VD4flfBkiGTHF2II5I8VQ8BbNwdF+jIOQMEnh16U6am4hoM2/9NLU2HsEMUsGzIza/0kIMe3blVdXVIX3VP7mNnEgje17VdJFEIPcyNyBE/3gJW5UeJmiJzdz0HO33w3RvGM4MQgy5udS1zToRSDRarEJqBz6gJvQHeIwE/I1GkZgQJfPV0o9m0KuTL2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dng2s9wnVw7rsOkD6UzX/zhfchlJmJppxXKNdWnCTEA=;
 b=EyCEhEynkWxD5n26J3id6qz4GmsRX1XdpJpv9KnK14W9vADrvPyaeBjpZO7mbmVISPVWeUOGpnT+JzTwB6g7WMwGA4S0lX2vtSWjD3zfM+MALdwrRi33MDlzJGcOVTKuHESiJofqiqCQzM/9kL4Dw+NDIO+wKDeod0MxQJL+5M1wSaNon2gJ4/phqi4KGJ5zcZL1oRVMjBrAPoEmQqSLe7m+yqipNo9DryuaZB+GsV+Sgk/HXMxGRe4PMSz/sUyYZZfOrMsV621O3wOpln4MmDGP95P9OPfVIftnSlFSJ6UGLOZdrT3iW24Yl5ram3oOI5Bu8OMnXyWEXdtQm70l2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dng2s9wnVw7rsOkD6UzX/zhfchlJmJppxXKNdWnCTEA=;
 b=AAlYQ+14s9Pu+58I+kTd9YkL4O69bA68PYwYBbifo2xa8RW55WXT+HWOZ/b5HTBHFDnkqeyU5tPe6D1pvpZecuEMIT26E0zpHCeT04DvyLRFnPTJoSl9Qbgidm6Upx7osfS4uABFPsuYu43LMdz592Z4330RAgZQBr+6WDS6FjY=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYAPR01MB5643.jpnprd01.prod.outlook.com (2603:1096:404:8057::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 01:31:30 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995%2]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 01:31:30 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/5] mm, hwpoison, hugetlb: introduce
 SUBPAGE_INDEX_HWPOISON to save raw error page
Thread-Topic: [PATCH v1 1/5] mm, hwpoison, hugetlb: introduce
 SUBPAGE_INDEX_HWPOISON to save raw error page
Thread-Index: AQHYdj6gtm58OI51HUigubpQzc/jOa1D8bCAgADQwYA=
Date:   Wed, 8 Jun 2022 01:31:30 +0000
Message-ID: <20220608013125.GA1404644@hori.linux.bs1.fc.nec.co.jp>
References: <20220602050631.771414-1-naoya.horiguchi@linux.dev>
 <20220602050631.771414-2-naoya.horiguchi@linux.dev>
 <ea4cc6c8-a772-dce0-a7a3-4c3ceb31735f@redhat.com>
In-Reply-To: <ea4cc6c8-a772-dce0-a7a3-4c3ceb31735f@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c020ffdb-18cc-4dbb-8b2a-08da48ee9d0d
x-ms-traffictypediagnostic: TYAPR01MB5643:EE_
x-microsoft-antispam-prvs: <TYAPR01MB5643CDC5A45E8D381170D1B7E7A49@TYAPR01MB5643.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U2MWL0qkP6LQ5y3XaHT7dd9BpitFQY7FiWFGE1fqp2iMmADFf3qLyGM6hL66CW3g/b9J1LLJXXuYPgmbp8qLkK6lBaUK6dqDC1GEI+Awy6RqyeILzb9wprO15FzAgVrnaTSzfU6CCABErRA9VfdH1aq3D4J67lSynM2qgjPtU8Dq9sJBlCkMO6dF/262wnSQV7/MSYU6Z4oEQ9kENkmHsjHCSoCUOzBLN4/KxiagKYPILkT38VD8dJg5SZ/ekYQANcHV1dkkVx7k6G3KxjORobIBxsIkHVlZrHX4zyoOXs2U7CI145NO9aOJ3bfoE28RHaxRNWBpMqS57QIGmJ7IJAHJkix0PrjE4UNnyhAJwWoYct4Q2sANu7H2xybrkXo9mAvWQHp8kvB8hOJFcSGXthMg3t+f2N1+TDhkhtudhXgwDOcBs+KTC2tYZcq6fqHSRUW+5fgUQ879KwGKPZO1t4oUnQnDlI5sYdfAfLrmNgjx5+aRc0IMXa9NhM2duApYkUvgey/pZ6iU1jJ1JR7wQcSgInN8HuJ/0cF0fbT1cvKHfKVt5EmQd6CsQBaL5zO8Ic3UU1CICPfhP+tF7lda1dip/KTKYZPCjyhUz55Z6nJG9JKXoiO8Xp7ds/ZAG4X9KW5g65H8DOgk5IdPK7imK0evE0pSSt5XU3gMhlzunGcIh00TdN3NL835IHKxTfNkehbupoXAxys/Lo+RXAj6ZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(66946007)(4326008)(2906002)(83380400001)(38070700005)(71200400001)(6512007)(9686003)(26005)(1076003)(54906003)(316002)(6916009)(6506007)(186003)(53546011)(55236004)(33656002)(76116006)(5660300002)(66476007)(66446008)(508600001)(82960400001)(8676002)(64756008)(38100700002)(7416002)(85182001)(122000001)(66556008)(6486002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWQrdEx1bEdjYk9sRGNXbG1IQmZrQkNVdTV0d3lUNzkyOEZOb3N3SjJLeThm?=
 =?utf-8?B?M2hBeHdvc1BhTzJSclQzNjlMcE9OK3hodzZzMC9oS1pHWlFabm9jV0UrTG9n?=
 =?utf-8?B?OUlRNGlEVnNNRXo5M3RMbUJpcm9GZFJ6TlhuaEFWeXd1VG5DSm80aW9BVEFn?=
 =?utf-8?B?a1JPWlBOQlo5RmRFblJUeE5NOUJTMmYxdUJVdEI0eFZITHRTcnJ4V3RSYnJN?=
 =?utf-8?B?UUNjOVJ4bDRYcmFPRU1Va3pCM2xqWms5aUQycFUxYVNrWnE2UVdoTEtkSnVz?=
 =?utf-8?B?ZzRTeThCUSt2Si9qeXZBdEh1blVrR0lTeTVhMUNqSVNyNUpmRzNtbk9VcnFH?=
 =?utf-8?B?RCtKZ2dDWnA4ZVhaRG8xeDBOUGo1WnZkbTFqaFB0ZlYxb3g2dUtRSEZJdFU4?=
 =?utf-8?B?VUlEeUdhZ2h2eEsvRStmaW8zVkRPanlVVElaS1VLRUYreTZuNFhaeTlOc096?=
 =?utf-8?B?dFJBUWRJY2M5V2Z5TWN5V3dXdFhyZWV2SVQrME1VbkVPZGpCNG9ZK2RweFgw?=
 =?utf-8?B?UUZrTElOcmZMRlJ1THJTMVdSTFJhYW9RaXNORWp4cWh0elFKVEtkM20wc3Jr?=
 =?utf-8?B?U1NFZDRGNGZaczRZbUg0UTJCUmxWTVZrd3o4N3FLYWhFcUhTaWVSL0tyaDNZ?=
 =?utf-8?B?U1hpN0xzb3Y4NkNrcUpMYzJKYlBnZ3haWWZoZjRTTkNZYy9QOW9GSGJISVg4?=
 =?utf-8?B?YllwVS9YUTNjV2RjckJZY0ZSSm9ielRlSDlGUE5wVkZldFB0bGdCdkJ5Y091?=
 =?utf-8?B?ekZpaU1FR3RuRm9uTG1iTmhQbzlSYzNCelB4aUpVKzREOEV2SDNYcGkwcGhL?=
 =?utf-8?B?ejBPZU1sVWFZSk9qTHR5WG1qWWVzc21qbytKZW5MZm9SbC9ONkIxQVhoSkQ2?=
 =?utf-8?B?RUZWUjhXbWNFdXBCamtIWVhQcWUvYzdHa2l4aCt2blUvTHlMcmZyYTh3UEJk?=
 =?utf-8?B?Q3dPS1ZQVmZzeHJVWm5BeVlGMDFuVVE4U3lQWnRPSTZPRVlRNFZBbmtRQ2dU?=
 =?utf-8?B?STFGanFPZUswRy9HbGlpSmU2WjNCNHFXdGhLclNvSmllM3RmRTY2NHBhQ20y?=
 =?utf-8?B?OCtXOHpPd01YQ29kdUFaRThCREVXallac012eXdmaEpkY3FlNDdSNVEyWG1M?=
 =?utf-8?B?TEh6bE9RVnRIT040L2pReml4ODZzWEQ5b3NLRms1RVB4dUlZbks5bkdEajdi?=
 =?utf-8?B?WkZsbnRvUG5hbjI3VkpNQzh1QUlLVEMxNXY0eTRYQVZDbUpyM1RxU1JzRC9m?=
 =?utf-8?B?QTJiNE1xQU1qM1lBK1RqakQ5Q01lRnk5MjRsL0VjTDY1QU5TQy9iYjAvckI0?=
 =?utf-8?B?VTAwVDdHVGF4QlJwK0cxalRVYThYNE12cXc1SFRSTzV4NXliMVZCTWxOU0Zt?=
 =?utf-8?B?RXdLd0g2bGpRYjZHZ2pzR2RJUXQ0K3dtSWI0ek1Fc1ZBWGJXUWwxM3RRK1VG?=
 =?utf-8?B?VjJqMEFab1l6YU5jOXUrOGg1Z0dFOXE0dWg2b3JOdW5CK3dQWkpSbnlTOHpY?=
 =?utf-8?B?cDQ1ajlrUGc4YTdlMldaS05rSzgvM2JNWjdDOThqZGo5ZU9HR0c4K2p2UmNh?=
 =?utf-8?B?R2R2cHhqcThkQ0ZLNyt3b1oxVCthU1JiVFVteFBxc2s5aW9TcnhuTmkvM250?=
 =?utf-8?B?eTFFTTdmOGRXYXlyVVRZR3VYclBZR3R2Ui9FWHd4L09ib2E3djVuOXlHMnJC?=
 =?utf-8?B?eVVXbG1vck5XZmpEckdEYzYwdUhRV21JZlRRR0N5NUN4OGMzU0lDcEZGc3g3?=
 =?utf-8?B?V2h4SjVVb3pzanEzNjhPdjltaXREczBHWVdzbGgveEdzVG90VnEwVFZQUGVE?=
 =?utf-8?B?bGNoSEJIR1lFdlQ0RE5zUW9tUnVhdTYvdllueGZJSTlNbHlXTitBbTNkeXp1?=
 =?utf-8?B?MitRTm5RY1NGdWlxWWVUZWt3LzY2YmJCMllZcVVsV3QwUDZCQlE4SFV1Q29B?=
 =?utf-8?B?SFN1WVczL3JWTGwwSkJha2FvUkIyakE5WExtc1huTnJVSjFNQ2FxZWYvbExM?=
 =?utf-8?B?TkNCTFRiNVBxdnZZU3phVy9zbkh0eU92QUZPWUMwZXUxU0dLb25EZTVJdm1M?=
 =?utf-8?B?c2c1RTVMQlhrK3V5aTJRb0x3c256dksrNkx2eVVvMDA5N002QjNEdTFnZ3VE?=
 =?utf-8?B?cXVuK2s0MUhDTzlpMkZ2L0lmT2hnaWJPbmpaMlhrRGlkK0NZZmsxUXh2UE1D?=
 =?utf-8?B?Tm9jZE42eVlGazRWRHMyN3ducElRU1dBOTN0OFBVdjk0b251N1lmN3d4dHcz?=
 =?utf-8?B?ZmNFajFENm5FY01GWGlhMGYvTGtFYVpiOHI0TGRCUHIvc3VFbUdnOVNXWXJ3?=
 =?utf-8?B?cEt2V1QyN0hmNlMwUGVJS0dPNEJ3UEtFbEgvbzVSRHVCVGtodzJyVms2NXd1?=
 =?utf-8?Q?cEjGhQLUHT1U3jck=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1317FE238E97F4D9D33748AE0C7B9DF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c020ffdb-18cc-4dbb-8b2a-08da48ee9d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 01:31:30.0517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6lA9EyO/OtQcqv25OOK0UfV3r2A9xqgKtdC4rsD84TWrEvIEtPmf+cA/3Dubbjw99vQPHofTpEGS3gJybNz00Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5643
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMDcsIDIwMjIgYXQgMDM6MDQ6MTVQTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6DQo+IE9uIDAyLjA2LjIyIDA3OjA2LCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+
ID4gRnJvbTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiAN
Cj4gPiBXaGVuIGhhbmRsaW5nIG1lbW9yeSBlcnJvciBvbiBhIGh1Z2V0bGIgcGFnZSwgdGhlIGVy
cm9yIGhhbmRsZXIgdHJpZXMgdG8NCj4gPiBkaXNzb2x2ZSBhbmQgdHVybiBpdCBpbnRvIDRrQiBw
YWdlcy4gIElmIGl0J3Mgc3VjY2Vzc2Z1bGx5IGRpc3NvbHZlZCwNCj4gPiBQYWdlSFdQb2lzb24g
ZmxhZyBpcyBtb3ZlZCB0byB0aGUgcmF3IGVycm9yIHBhZ2UsIHNvIHRoYXQncyBhbGwgcmlnaHQu
DQo+ID4gSG93ZXZlciwgZGlzc29sdmUgc29tZXRpbWVzIGZhaWxzLCB0aGVuIHRoZSBlcnJvciBw
YWdlIGlzIGxlZnQgYXMNCj4gPiBod3BvaXNvbmVkIGh1Z2VwYWdlLiBJdCdzIHVzZWZ1bCBpZiB3
ZSBjYW4gcmV0cnkgdG8gZGlzc29sdmUgaXQgdG8gc2F2ZQ0KPiA+IGhlYWx0aHkgcGFnZXMsIGJ1
dCB0aGF0J3Mgbm90IHBvc3NpYmxlIG5vdyBiZWNhdXNlIHRoZSBpbmZvcm1hdGlvbiBhYm91dA0K
PiA+IHdoZXJlIHRoZSByYXcgZXJyb3IgcGFnZSBpcyBsb3N0Lg0KPiA+IA0KPiA+IFVzZSB0aGUg
cHJpdmF0ZSBmaWVsZCBvZiBhIHRhaWwgcGFnZSB0byBrZWVwIHRoYXQgaW5mb3JtYXRpb24uICBU
aGUgY29kZQ0KPiA+IHBhdGggb2Ygc2hyaW5raW5nIGh1Z2VwYWdlIHBvb2wgdXNlZCB0aGlzIGlu
Zm8gdG8gdHJ5IGRlbGF5ZWQgZGlzc29sdmUuDQo+ID4gVGhpcyBvbmx5IGtlZXBzIG9uZSBod3Bv
aXNvbiBwYWdlIGZvciBub3csIHdoaWNoIG1pZ2h0IGJlIE9LIGJlY2F1c2UgaXQncw0KPiA+IHNp
bXBsZSBhbmQgbXVsdGlwbGUgaHdwb2lzb24gcGFnZXMgaW4gYSBodWdlcGFnZSBjYW4gYmUgcmFy
ZS4gQnV0IGl0IGNhbg0KPiA+IGJlIGV4dGVuZGVkIGluIHRoZSBmdXR1cmUuDQo+ID4gDQo+ID4N
Cj4gDQo+IEJ1dCB3aGF0IHdvdWxkIGhhcHBlbiBub3cgaWYgeW91IGhhdmUgbXVsdGlwbGUgc3Vj
Y2Vzc2l2ZSBNQ0UgZXZlbnRzIG9uDQo+IHN1Y2ggYSBwYWdlIG5vdz8NCg0KVGhlIDJuZCBhbmQg
bGF0ZXIgZXZlbnRzIGFyZSBpZ25vcmVkIGR1ZSB0byAiYWxyZWFkeSBod3BvaXNvbmVkIGh1Z2Vw
YWdlIiwNCnRoaXMgbWlnaHQgbm90IGJlIGdvb2Qgd2hlbiB0aGUgaHdwb2lzb25lZCBodWdlcGFn
ZSBpcyBmcmVlZC9kaXNzb2x2ZWQgbGF0ZXIuDQpTbyBhIHRlbXBvcmFsIHdvcmthcm91bmQgaXMg
dG8gcmVtZW1iZXIgImh1Z2VwYWdlIGhhcyBtdWx0aXBsZSBod3BvaXNvbiBwYWdlcyINCmFuZCBk
aXNhYmxlIGZyZWUvZGlzc29sdmUgZm9yIHN1Y2ggaHVnZXBhZ2VzLg0KDQpUaGFua3MsDQpOYW95
YSBIb3JpZ3VjaGk=
