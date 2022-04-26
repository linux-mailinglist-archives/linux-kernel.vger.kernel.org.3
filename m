Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ABA50ED9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbiDZAev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbiDZAet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:34:49 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2050.outbound.protection.outlook.com [40.107.113.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EB41A06E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koq3rUcT/rjo7xyfAW4IvNd8uFl4aWiAsDCTuAjG8GAV07yxNiYwslONS7+qpDWw+jxi7+iRuqcVMltJZFTgAvpfQ9kP0uG2JHA8PUxJJ8pNhRHVv/BRHm5buN0jR9X9QNTTs0BFFn44GNT8itVw8I67OOK461jGKcMllFSfS7opj107X9R1GJEOSmpFjE7KXzBk05agFqO9kweGNT/ajVOFgNfnrNfWXWo/h4C0fkV+hZnKMlubHJqSKqrMHjqacNntOPir9lkKC4M1TqtAEg9YJ6zNPaiT6yFKklxyq83HiRnnDbnnOY6pNMy2sQFEjV+/BDN5ST+xjWtzgUKw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NV0z5pkHZgToLAJ2SQQbN7pyyMFO7ZnHgKKCIh3VGBo=;
 b=cv/NzNueH+ue6i1klskpmwQvJtZpsoyO7OfhezXawkWD1JiZICg4VHaockVclhZq3c7jymWsBCilScluOkgd7XFHGurb06gOskLli6nKDniPxUOalp9cjJW6KMpb1kT3zLCKEMiwKHr3W2Zq5+JHNaLVt1tsKkoBu0llthwzMvKSDTIDCy8ibqehRtfof/joNkl5AIT7tt6iwQ4L1FfQNPl+qti4/ZUxgHkBZrdgqRkKvmhoQvcg04tXCz76+L353EJ4FsJGn7Anmn/L/eAP7wmR+rLx6tNEOkiO8xh7W9wA/8QPNb4blmLoh5JacX0nEL5Q3YRzYW5vdf4BTlTkAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NV0z5pkHZgToLAJ2SQQbN7pyyMFO7ZnHgKKCIh3VGBo=;
 b=gLtDOLV7dRxTboLXkfYy8Xh5JVpVDHO8bXZUtHpDLrn9bJkg2Da+KsttatLtWkUU2gjfD4M579IkvfgbAPdFdMst3wEf+6VTRLD7kyAJv+QhIy5h+KFWLoOd/LGQjypdfi6UyXCcVRlU6yqHvPMe9PwkgV5vOhiBn0FTZMw8E98=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYAPR01MB5104.jpnprd01.prod.outlook.com (2603:1096:404:12d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 00:31:19 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::e58f:5f3b:6d28:b245]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::e58f:5f3b:6d28:b245%4]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 00:31:19 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     David Hildenbrand <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "surenb@google.com" <surenb@google.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] mm/swapfile: unuse_pte can map random data if swap
 read fails
Thread-Topic: [PATCH v3 1/3] mm/swapfile: unuse_pte can map random data if
 swap read fails
Thread-Index: AQHYV7s04sjKvB31sE2FEmou2La8+6z/0l4AgABvDICAABFegIABB6UA
Date:   Tue, 26 Apr 2022 00:31:18 +0000
Message-ID: <20220426003118.GA3829204@hori.linux.bs1.fc.nec.co.jp>
References: <20220424091105.48374-1-linmiaohe@huawei.com>
 <20220424091105.48374-2-linmiaohe@huawei.com>
 <20220425010804.GA3746096@hori.linux.bs1.fc.nec.co.jp>
 <febd6309-b2a5-ef79-daa2-8000af09e291@redhat.com>
 <3ab987be-614a-4757-4124-26bb09d3f160@huawei.com>
In-Reply-To: <3ab987be-614a-4757-4124-26bb09d3f160@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab5d628d-d0fe-4ff9-20cd-08da271c14eb
x-ms-traffictypediagnostic: TYAPR01MB5104:EE_
x-microsoft-antispam-prvs: <TYAPR01MB51041B49E573A9015A39FD70E7FB9@TYAPR01MB5104.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jKFFl5bv5Uth0oEwUTAZE84/BBcqPDV9+d/+3pSVV1JX0H5ajkQrG2aLFXTe1A+FPWDIg4KrwEgZSaP7PgN3QGHNXZZMGR5BmIlgC1z7Cb4ChP3xXcP8tF9upu205Ijpix50RitIOCsx/7BQgVUERiNsqiAbP4Mednce2v7y6t7maSqcOx43uk2XxweX836z/DShtQzr68Q+T3iHcYwZoIok9lcN2rLfLL0GcbGenh+ISyFDCCQx65S/CH2JU7GQjQbnnAqfZmjZG2/nXmO7UDE5jY+TXMeZC6eKy0IeHvicyeiIQZXjbZNDK+k+wEtgxyG4Ym64BvBGFIYOCQc0ap0kQ+ayH/2owMaOPdd8UdPIWhg0fACMsD6UcPN//fgLDFCK1haj2gd35htj9sQBZLR7GTf6rbHHeOB6IjxnHRunCygTeTXjgJXXWLh+lPhVEhcY/hn3u0TdsZpa/fxQVgXB0HTgvRDyLIO+hBdNxjtozhgaWGAkIpbViUc0NuAESmM6eC3svaPAe9F7x07LkNL0wXdxM6VMvm8Bpf9g8r/KRFTIaGYwTY4EDCGWIOeRNJOyEZQ+ASYoPXrZ4l3CXz8m3ejTHPSkIKb3R7YHPMFfCsMxqDcXe+q9WOKVFeidQxp86KjUBMjNA8wLdIyD4/8SUYM5T5TTtZac0OrG92roJlj5+vmUSaRf1JWkN8lLox/lq+wXhzwNSbLnSRs3JQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(122000001)(7416002)(38070700005)(38100700002)(316002)(86362001)(186003)(66446008)(8936002)(5660300002)(54906003)(6916009)(6486002)(71200400001)(83380400001)(33656002)(55236004)(82960400001)(2906002)(53546011)(508600001)(8676002)(6506007)(6512007)(4326008)(9686003)(26005)(76116006)(66946007)(85182001)(66556008)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkp5MklWQnpLR0V4Y3ptbFExOVYrWEhKcXpHQ1dWbWNyNEJQSFhJMFk5ekRD?=
 =?utf-8?B?LytaWUVWNElaSThaR25sWHVjd3NVR2VnNFBpYVRaLzlMNk1ueCt1T2daWkZk?=
 =?utf-8?B?M1ZvcjJ6OUU0SFRYZXhtTlpHWjJPd0J2MDlHVHVnR1R1LzVGMlZQeGlwWXU5?=
 =?utf-8?B?NFhtN2NnaFg2eDZhSkNieEV6RTRQT09Da3owYzlPeVhmMkEvbkR1bVBpVGdn?=
 =?utf-8?B?WElhM1pXdytjQ0NMSEZ5ekIrams1Tk11S2ZONktyd0ZWeXY2c2VhQmx0WTRq?=
 =?utf-8?B?dG80SmVhakZMSmFjeUZSVFZjRjBDZnppZ0VkWTVGT0pHSW55YmxoZXR5OER6?=
 =?utf-8?B?eDQzK0ZOZHhHL1lVN05tb2YvSXh0eFpSVzh5ajNLdnVXcE9VdGg2dXl5UVNE?=
 =?utf-8?B?QmlmSUk2T2I0Q3ZKQXdIaW1GMi9DNFFzbUZPZVcwNDVUSTVvZHlMVXU0Tjht?=
 =?utf-8?B?T0hjSnZWYkVHeFpmTXc0THFzZU9yVXhBa2kxbE4xNUJBSHFsZkVrWGF5cHZl?=
 =?utf-8?B?MTIrUWV5emdaNHJuSDNUTmtWanlhclEzY1A2WmhyOGhQRklFVTBhOExORksv?=
 =?utf-8?B?VWpLWk5DamhEdXRDdlk5ZVdzbW90N2toNXMvZzZmUFFTWWdqNmlZRzU4OEwr?=
 =?utf-8?B?UmZjQ2VOQ1BEaWdSa2prSVVMMldraTJOVnpMM0Z1U1pXeGtEZktWKzN3NTZW?=
 =?utf-8?B?R0hwbUFLNG9WR2pBZm5HQlpLMk9WY0doWFdiZWZ3K09qbnFJYVUwLzRjSlFh?=
 =?utf-8?B?cXFhTXlPb1kxUGRXL2p4bDVScFhEOCtscm1FaEtlSlN4Ty85L2UzQ2tDcTNl?=
 =?utf-8?B?VUkxOXBUd1VxMEZGYklYdnB6VlUzMjZRN0NKQXM2MGlHRmxNNkhxRzBvN2Zn?=
 =?utf-8?B?UjE1RVpvOWtqNDVQU0taWFZ4cTdUd2ZJQUZoSkcxSEtCZEVSc0FxKzFJcmVm?=
 =?utf-8?B?NTJqa21aQU1DNlBJUDYyNzNPUE50SHZ3S2ZNaFNaUGtRWTMwTm1hK1haYmdv?=
 =?utf-8?B?d1BKMXVpbnozUHVFRWFLSy9pVUJSRTQvcU1xdzNVUlJnSGFKYUdDelRZbk42?=
 =?utf-8?B?Nk1uMC84aDVqMnBoMytzYm5Oc1NjUGl1SG9vSkFUbXBYeEJwU0VYTDRCVjNp?=
 =?utf-8?B?NkpBTlNFeEtCYm1pRXp1NjcvUllxZFM1M1paUGFWdFA2dTN6eEltZUZ0UHd1?=
 =?utf-8?B?STBaSnFqTkdGeVB0UTdlTks5RUZQMG12Vkp6ek9xVjlMbWRMbTZRNk5ZazVM?=
 =?utf-8?B?Yit6VEs4YTJ4K1A2V2x0VG9PaktHQ2hvWVB4enhZUWxGU3B1R0xPS1RmNXMy?=
 =?utf-8?B?M0NERWpkNzVsMnFrVGRRTmF5blNlOHhwc0hIUnE4blIvYktZUkV3YjEvY1V6?=
 =?utf-8?B?akRxK1lmTmNGMllUZEUzaDVxa2VhbmY4dFlvU2YxMzY4aklUWjg3WXllSGFZ?=
 =?utf-8?B?MTllOU1aUTNMUjBxQTE0c2ZDWFdmcUNwSWh1ZnA0NEgwaWRxc0lMOHpkOUR6?=
 =?utf-8?B?eG9ULzViaEVLRG00dUc3UE1nd2lPUVV6emdNZEY1eFowZkxUaUpjeU5jVlFs?=
 =?utf-8?B?d2xocHVsSEJVeUlzQW1BVzhvV0NQSEpKTjZOUlFDMkM2NUtpRm9KVUlwSGRa?=
 =?utf-8?B?Ukl3SFkxWTFIN2Q4Q1M2OWU0bFN6UmhGVnptOFhsK0h0dTBBSmgxMVN6V1JD?=
 =?utf-8?B?MEhaT3J2ckNNRlBYb0p1N0NIYkVyUjdBRmVGTWVzemt6MTNrZkdBc1VkSGhl?=
 =?utf-8?B?SGNHS3IwYVlRMmNMdTVxQ0IvajloTzYyWTNuWE9HM3Zaa3h0UkxNNTlRazFs?=
 =?utf-8?B?aG5taUdzdGM2UWM5ekRrV1gxVXlhYkdSVCswUTRSRjF6RzkrdE1Kb2dHNjcv?=
 =?utf-8?B?MC9iRjVvaGI5M0NvNWdVQkNnSlF2NWIrQytsSU1PNE5jQ3NlcFljbkc2Ujkz?=
 =?utf-8?B?ZWpqY2MyVFVkNkVHTDA4QkJ3T201SXo2SkMrMVgyanduYnVIV3FONGZadWNi?=
 =?utf-8?B?dHFMSGJ3aHI4TGxYS0NEUWl2UkJMWjJiTGNLOHRHZjQ1SkUydVU1eWpiUEI1?=
 =?utf-8?B?Ni9kZnY4UzRNMG1YV2kzMVBnclFXbXoxcDQwYldaSStKQ3BzRk9vaGU3T0d5?=
 =?utf-8?B?Y2NER2ViUmhHbk1YamxlaXhncCtPSnJ2TjYyT1pWQkt5WjRTNHlkT003TEVH?=
 =?utf-8?B?QUtGTTJldzVDamtnVVJrL0E2UTlNNU82SEhqaDBoSWZlOUpPcEZaVGNUWDQ5?=
 =?utf-8?B?UTdqai9CS3E3OURaRWFjRzllOWpkWFVyUGNIR1ZhbGp4bXhreGRTSDhqK3Zx?=
 =?utf-8?B?a0dPRTN3U3IvUUJWMUJMRE1aUnJRZE1kU1FNTlp6Q1ZQNFpQS3U2bkpqWHhF?=
 =?utf-8?Q?97R7dVrZR1POZAnM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EDADEFBBA2433449215B01E0C61A453@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5d628d-d0fe-4ff9-20cd-08da271c14eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 00:31:18.9242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+ztZ1fE1me9YdL8HgT6T+HDtlrUeccTX5Yhn8XZvyI+Ll8uVC5WsOgxwnYrl+uPKcXR2TrQPR37KqU3mx7Sfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMDQ6NDc6NDFQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi80LzI1IDE1OjQ1LCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4gPiBP
biAyNS4wNC4yMiAwMzowOCwgSE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8pIHdyb3RlOg0K
PiA+PiBPbiBTdW4sIEFwciAyNCwgMjAyMiBhdCAwNToxMTowM1BNICswODAwLCBNaWFvaGUgTGlu
IHdyb3RlOg0KPiA+Pj4gVGhlcmUgaXMgYSBidWcgaW4gdW51c2VfcHRlKCk6IHdoZW4gc3dhcCBw
YWdlIGhhcHBlbnMgdG8gYmUgdW5yZWFkYWJsZSwNCj4gPj4+IHBhZ2UgZmlsbGVkIHdpdGggcmFu
ZG9tIGRhdGEgaXMgbWFwcGVkIGludG8gdXNlciBhZGRyZXNzIHNwYWNlLiAgSW4gY2FzZQ0KPiA+
Pj4gb2YgZXJyb3IsIGEgc3BlY2lhbCBzd2FwIGVudHJ5IGluZGljYXRpbmcgc3dhcCByZWFkIGZh
aWxzIGlzIHNldCB0byB0aGUNCj4gPj4+IHBhZ2UgdGFibGUuICBTbyB0aGUgc3dhcGNhY2hlIHBh
Z2UgY2FuIGJlIGZyZWVkIGFuZCB0aGUgdXNlciB3b24ndCBlbmQgdXANCj4gPj4+IHdpdGggYSBw
ZXJtYW5lbnRseSBtb3VudGVkIHN3YXAgYmVjYXVzZSBhIHNlY3RvciBpcyBiYWQuICBBbmQgaWYg
dGhlIHBhZ2UNCj4gPj4+IGlzIGFjY2Vzc2VkIGxhdGVyLCB0aGUgdXNlciBwcm9jZXNzIHdpbGwg
YmUga2lsbGVkIHNvIHRoYXQgY29ycnVwdGVkIGRhdGENCj4gPj4+IGlzIG5ldmVyIGNvbnN1bWVk
LiAgT24gdGhlIG90aGVyIGhhbmQsIGlmIHRoZSBwYWdlIGlzIG5ldmVyIGFjY2Vzc2VkLCB0aGUN
Cj4gPj4+IHVzZXIgd29uJ3QgZXZlbiBub3RpY2UgaXQuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9m
Zi1ieTogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+DQo+ID4+PiBBY2tlZC1ieTog
RGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+ID4+DQo+ID4+IEhpIE1pYW9o
ZSwNCj4gPj4NCj4gPj4gVGhpcyBidWcgc291bmRzIHJlbGF0aXZlbHkgc2VyaW91cyB0byBtZSwg
YW5kIGl0IHNlZW1zIG9sZCwgc28gaXMgaXQgd29ydGgNCj4gPj4gc2VuZGluZyB0byAtc3RhYmxl
Pw0KPiA+IA0KPiA+IEknbSBub3Qgc3VyZSBpZiB0aGlzIGlzIHdvcnRoIC1zdGFibGUsIGJ1dCBu
byBzdHJvbmcgb3Bpbmlvbi4NCj4gDQo+IEkgaGF2ZSBubyBzdHJvbmcgb3BpbmlvbiB0b28uIEkn
bSBqdXN0IGFmcmFpZCBzb21lb25lIG1pZ2h0IHJ1biBpbnRvIGl0LiBCdXQgc3dhcG9mZiBpcw0K
PiBleHBlY3RlZCB0byBiZSBhIHJhcmUgb3BlcmF0aW9uIGFueXdheS4uLg0KPiANCj4gPiANCj4g
PiBUaGUgZG9fc3dhcF9wYWdlKCkgcGFydCB3YXMgYWRkZWQgaW4gMjAwNToNCj4gPiANCj4gPiBj
b21taXQgYjgxMDc0ODAwYjk4YWM1MGI2NGQ0YzhkMzRlOGFiZjBmZGE1ZTNkMQ0KPiA+IEF1dGhv
cjogS2lyaWxsIEtvcm90YWV2IDxkZXZAc3cucnU+DQo+ID4gRGF0ZTogICBNb24gTWF5IDE2IDIx
OjUzOjUwIDIwMDUgLTA3MDANCj4gPiANCj4gPiAgICAgW1BBVENIXSBkb19zd2FwX3BhZ2UoKSBj
YW4gbWFwIHJhbmRvbSBkYXRhIGlmIHN3YXAgcmVhZCBmYWlscw0KPiA+ICAgICANCj4gPiAgICAg
VGhlcmUgaXMgYSBidWcgaW4gZG9fc3dhcF9wYWdlKCk6IHdoZW4gc3dhcCBwYWdlIGhhcHBlbnMg
dG8gYmUgdW5yZWFkYWJsZSwNCj4gPiAgICAgcGFnZSBmaWxsZWQgd2l0aCByYW5kb20gZGF0YSBp
cyBtYXBwZWQgaW50byB1c2VyIGFkZHJlc3Mgc3BhY2UuICBUaGUgZml4IGlzDQo+ID4gICAgIHRv
IGNoZWNrIGZvciBQYWdlVXB0b2RhdGUgYW5kIHNlbmQgU0lHQlVTIGluIGNhc2Ugb2YgZXJyb3Iu
DQo+ID4gICAgIA0KPiA+ICAgICBTaWduZWQtT2ZmLUJ5OiBLaXJpbGwgS29yb3RhZXYgPGRldkBz
dy5ydT4NCj4gPiAgICAgU2lnbmVkLU9mZi1CeTogQWxleGV5IEt1em5ldHNvdiA8a3V6bmV0QG1z
Mi5pbnIuYWMucnU+DQo+ID4gICAgIEFja2VkLWJ5OiBIdWdoIERpY2tpbnMgPGh1Z2hAdmVyaXRh
cy5jb20+DQo+ID4gICAgIFNpZ25lZC1vZmYtYnk6IEFuZHJldyBNb3J0b24gPGFrcG1Ab3NkbC5v
cmc+DQo+ID4gICAgIFNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0Bvc2Rs
Lm9yZz4NCj4gPiANCj4gPiBTbyB0aGUgZG9fc3dhcF9wYWdlKCkgcGFydCBoYXMgYmVlbiBmaXhl
ZCBmb3IgcXVpdGUgYSB3aGlsZSBhbHJlYWR5Lg0KPiANCj4gRG9lcyB0aGlzIG1lYW4gb25seSBk
b19zd2FwX3BhZ2UgbWFwcyByYW5kb20gZGF0YSBpZiBzd2FwIHJlYWQgZmFpbHMgaXMgb2JzZXJ2
ZWQgZnJvbSB0aGF0IHRpbWUgb24/DQo+IFNvIHRoaXMgbWlnaHQgbm90IGJlIHdvcnRoIC1zdGFi
bGUgYXMgaXQncyBuZXZlciBzZWVuIG1vcmUgdGhhbiBhIGRlY2FkZT8NCg0KT0ssIGJvdGggY2hv
aWNlcyBzZWVtcyBwb3NzaWJsZSwgc28gbm90IHNlbmRpbmcgdG8gLXN0YWJsZSBpcyBmaW5lIHRv
IG1lLg0KSXQncyBmaW5hbGx5IHVwIHRvIHlvdS4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
