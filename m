Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEFA5665C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiGEJE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiGEJEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:04:55 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2063.outbound.protection.outlook.com [40.107.114.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703DAEB9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 02:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xy44KLOJYc3lpIitO/2lAXqU5OaNQgfOnVk13pjIdCWux/aHCfUPewYoBErqEiaca6pN1r1iUEmy5tL1kCgEueeJ32hAkx4DWDNLcNQUQNWMnHLcbigsJlBJIe52sHYXnR6PH2CWEAjDgSuwbGFr0zqStlSM7NTjzcbdcYRH+cr5H/32flYfUc1TZXu4gegOH2nDIUhQ+LSZf3SxLFU981OFAxMjluNMqDOCfue692j6yh9oFvUEgz8KJPCRaGizqWiXiTr4rP5GIkY0ubHbMzh70OLLLh7iNFlW5yCvO3ghZrc1tHE6THMVMNpQ8r91+24H8uz77vLO7hz9P7ABNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/9z2hVoMNJJTMFplgL2EdzxpxGNP7BEvG1Q2Atgq4c=;
 b=b4jugej1MzM0oiFd61cnSmFGgs+48s68bkx+M+DNo6ZnoNKQiIIaPV7UbFm5XF6HJrCJ2KYMq9Ofi6uOo928OVwfJRTbNfKT/XpSz6Fnjx/4ymaH637M1UZUYVbDRd1ZsJB7ziDh5r4DnsdSbFLgJSqw2jVIscHes9tpe03K6Su+PiekAG+UFBverRWj0HzfhWSDvHz15lH0bimCPXbsH0etsoKSrCyXANb/UBDct5RaQ1I4yxUGVmFCubA1EVGLR5lRyo7CwYVzaRc4++4DH7DS3knPHbqNeZ/pwOp7/icexhMjcARDf6PCHwJzMd1QIp2LLYTXxCccyXvVp5ne8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/9z2hVoMNJJTMFplgL2EdzxpxGNP7BEvG1Q2Atgq4c=;
 b=dks7QB47DlJihaKDe2KjHA4W9HB4znzv7xrIEsLF5YYuvYi4Usr7w+GiWUEOjJiY7Tj0LFZPRoy9AhbO27DGQ98kAAZ3E+oenQihVxX+FrbZPfbpqGlcYhi/YHeTxVWXQo3KjeXdEXf1GmEKisebwatNOZpNStdnL7sw5B3YLF8=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB9399.jpnprd01.prod.outlook.com (2603:1096:604:1c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 09:04:52 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%6]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 09:04:51 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [mm-unstable PATCH v4 3/9] mm/hugetlb: make pud_huge() and
 follow_huge_pud() aware of non-present pud entry
Thread-Topic: [mm-unstable PATCH v4 3/9] mm/hugetlb: make pud_huge() and
 follow_huge_pud() aware of non-present pud entry
Thread-Index: AQHYkBltjTbP4FzSMUWtFssBDTgaY61vfF0A
Date:   Tue, 5 Jul 2022 09:04:51 +0000
Message-ID: <20220705090450.GB2508809@hori.linux.bs1.fc.nec.co.jp>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
 <20220704013312.2415700-4-naoya.horiguchi@linux.dev>
 <83aff2eb-7190-7f5d-d81d-3eff0f56c40e@huawei.com>
In-Reply-To: <83aff2eb-7190-7f5d-d81d-3eff0f56c40e@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69e7c13c-9c6b-4bd8-c5c7-08da5e656bcc
x-ms-traffictypediagnostic: OS3PR01MB9399:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YlholpAhI0Snh9lZkfSzeDKA09YEVf+KDqcgQQ7y3UJbhtTgFmNjsqi2qPlfYWjDOB5aJELPYKG+/3zBx6ikmJsPw0qvjOIUNk+k+dRR94UNxAv5umHV37D/Fgg4oZpPz1OGTAfyzyyJuU9NjK835ks4EsBLLrBXTOKZw8Wu2BG96EMdoYBWrIwbBdPpzzHW+V9n3bXh1CHADlgmqURuvYUnztOFQVjoFW5JOR8mX3TmnNMcexZHhXuwjSo9hUIBg4P/1ro+5jidYmveYK+SpQerC3fKK+yo16VVqSrOF3Pr2BPD3l1K4Rf+hMbkiCp7GMgSXypfhnwDIS+VjOg/TDxDbbncwvYgUK4d0vfZmMBU3b16QEBBOR37Ony+VsNEUMvMMdBJcMdy65QXbc3SAO9L5O01TKnO8w2ciw5XCdA229Z80qKS7ixq0D7K9UsAB2OCohKYHIBj6GHathSkTMhiKCwatGItnhaN+juNzq0rN+ylRhWXo4mpDMOjjTdIphr+TPc+yjSlXdC516nlGqOM+kOTaNznHQF62fN4/YwjSLWNOwGC+Mv3UfdkVBwYueO6bjB1UCzBfwoURkeLtLe4gTF4joRl7n4NWNJf/nBtHlx6HKphATzXhyUSFVscl+aKt+iMZxEe2Wwlrrs8mk/UPQGG7bMh6WSAP97L/GcHRU17ou10eQf/hpEC2RQHMXf0wmxIU1ggyXvR3DZsK0gY0Kx8s46apOk1zRrX90hoAEduV+TnC5Hc/yQKIGUiRswC3nJNSZjkmm9axbBi1cqJNmyN7O/5GvaO0EFp9DucMbYGL/Jo2R/p0FIIWmOKb6VgF0D1tuoaor3IJuyZqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(5660300002)(9686003)(6916009)(26005)(38070700005)(54906003)(478600001)(41300700001)(7416002)(8936002)(6486002)(6512007)(85182001)(82960400001)(38100700002)(71200400001)(53546011)(4326008)(55236004)(33656002)(186003)(83380400001)(66556008)(8676002)(86362001)(76116006)(66476007)(2906002)(316002)(66946007)(66446008)(64756008)(122000001)(6506007)(1076003)(14583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0JJM1Vndjh0V09UWkR6YkZ6R2lYRHc5SGJVQm5NNVFzMWxWcDZnTUwwU2JL?=
 =?utf-8?B?OTh4YmMvYzdUQ0l5M0lSSkV1VzMzMVRnR29YbC9qN1NNbnhPTFRsRkRRNkNU?=
 =?utf-8?B?bU95ek1vcFNsWTZJSlZ5QzB1ZkdnRktUcTQ1UlFyUW5qY0g3dGdDUkpFbFlH?=
 =?utf-8?B?Q0RUcGRxcjFpVEczVEdPSDVyeDQvZXM0Q2tBdjNiMVNRQnVxdEpITTlpMVlz?=
 =?utf-8?B?T3hWdU5aUVZrc1owTzZYbzl2WDdnNXBrVER5blgxSW4xM3Urc2w5eFlGRU5H?=
 =?utf-8?B?MTYrcnMwdGwzNXcySzVMT1pISDQyblhPYUVVVDFSbVRzL0p1SEhCWlk5VEtz?=
 =?utf-8?B?eDVBQlpVYzVmd0dGaUV6NXNIVm5tVllsYnlZd0FGWVArdXNYNG1IVWhGa0xj?=
 =?utf-8?B?Z0NvSW83ZmR4R0R5dHE1ZG9QSjNvaDZ5SVhreEYrOFhmVTBTdHVEY3NKWm9p?=
 =?utf-8?B?V1NQWnJ0L3djNHBHTWhmc1pCSUpxbjB3MUVKZTZqQ3pqVmpOeklGK0RVaTFQ?=
 =?utf-8?B?TzJwbGdXaWc2THI1cVkySldiZHBCV0JQYzVPS3I0NktmZGZoenBSWWYxbmFF?=
 =?utf-8?B?cXhxSEoyNzVDZXNhLzhHQmZ3WVBjbzlhR09mTzdGYjZzbnYreHpkdkdqTGxm?=
 =?utf-8?B?dlpuNjFVVUUrWkgzSnFNdUlOV3JoR1JLMlFQOFVwUE1rVnhpRnVuNWs2MEho?=
 =?utf-8?B?ZTVwSHhzUGJjUWxTQ285MlU2dldmRW9xbjNqUGNwZzF2OVViVWNrTkRkSm5n?=
 =?utf-8?B?UTJqUVpiWnMwM1FjNStKbFBYd3ZBc3RuOHMrdU9FZXpaNENma2FmejcvNXRX?=
 =?utf-8?B?N0dBUkRVdWtxbWpweFhaaHNBNkZuZk9sdEp0cUE1cVl3YXZodnRvWnhSZSt4?=
 =?utf-8?B?OFRSd1dGU0xrM3dTRW1rY3YrMzl5dFhCNDB6Z2JiRXlBSS9KSTgwSFhDaWRp?=
 =?utf-8?B?a3pGT2RjdDFES3l4Q3d0NEJEaWxoL1BIamNhMVRWQTRJbGQvU1cyM0RaQVdI?=
 =?utf-8?B?b0ZzOUNFUW9xd2tHYnZ5ZlhwSXFzT3lBa0c1ZFJ4K01oWERJeEFQVlBjbWpP?=
 =?utf-8?B?bWZQTERFb0hIMERVa1lNbmVJUzBCWW5zbHFsRUxSMkVkU1JUY1hXeVFJMmZj?=
 =?utf-8?B?WTlNQ2plMVB0ZVhGKzJXbDBBdkdJTFVwSmRHV0xUZlpZb3lVZ2pqMzNwQlJv?=
 =?utf-8?B?ZnVyUE9VdktMQ3ZTNXIzK2U5MkpyRVVRekRRZGRZY2FuNTlsWU13YWhrL1Jl?=
 =?utf-8?B?c20zTXBIajhUTXVnanpabWVIZy9XdDltT1B5bVlFV3NCaUtFOW5BZ2NSbTR2?=
 =?utf-8?B?eERhSzdTTjZvdHBTY29NUDR4Zk5nTE5MdG9hMXpoRUtrK28rc1kyREorNWYr?=
 =?utf-8?B?L1dwYkF1b2RvdFV5ZkFHaDRjNUlEeU4rc01vazkxUkJnblNpWlcwVnlQaGlq?=
 =?utf-8?B?Z2U0TnRzbGhSaXNNVDdJTnZzOHl3OXI4OUhSZ3phRG9aRTRjUmRyYk9TZFZN?=
 =?utf-8?B?dkZUYmtWSzJaUnptSS8xYlVxMElKbWhQYjBrWEtQRnd1MzV4ZzlsMUM5MEhR?=
 =?utf-8?B?LzVTVGxXUTVBejZwQ2RpWkllcUJsNElEU240Yy90azZ2OVNvZUU2dUdqMUhI?=
 =?utf-8?B?Yi9yM3VzMW81TmpROUhLRnpzWmVlZFhPQSt4cDB3ZHNwMnMwamRPaEFTamhn?=
 =?utf-8?B?UklyamdjZjFJUXFBMDBmZndsWis2MWhFWEQxQ3N6RmlGb2hTTENRM213Y0dk?=
 =?utf-8?B?R21TMG4xazlDOFZvcHpqZkg4NGpyZHdLS0xLZmd1Slg0OHp0cnRuUWJVbEhJ?=
 =?utf-8?B?T2VqaUpIS1RKblFtcDBnYi90WWdXenhwUUdSMm9Pa0wrUlByY3c2d2pSRVFw?=
 =?utf-8?B?dmtJcm5JbVNnWGt4anRLWmdiWHRFamhEbHJBVHlmTk1xaEduYUVNQUtHdEY3?=
 =?utf-8?B?c25wSzJWR3hxZXZCQ0hXV3BJSCtUa2FSVWs1YUZTa2FSOUdFdnRyb3hlelJI?=
 =?utf-8?B?RE9CbzJKdEF1d1ZFMzNjL01QYzBWU3BZQ2NGTFUvZTVCUWVUMmd5TFo3ektu?=
 =?utf-8?B?UE04UEJWQ2FBWHl3K3dQL3JObzFMNWIyQ2tiOExQdHNkVzlWbndhMC95cVo4?=
 =?utf-8?B?UE82WGs1Vi9TWWY3OVJ1TnpHazhZVWpBQVlCQVh4ZmdldG5PNlNOckdlOEl1?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A2D52CED0FDDE4A80AF885A6AF95524@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e7c13c-9c6b-4bd8-c5c7-08da5e656bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 09:04:51.9480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oy/EFLlHMi4lTyncquf/PfRdU7FrHbL4nu5kEJhzY/5v3lmjEIgqyvI1MbgelRzr8lQX2P8PTGBc1zUQfWzB4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9399
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdWwgMDUsIDIwMjIgYXQgMTA6NDY6MDlBTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi83LzQgOTozMywgTmFveWEgSG9yaWd1Y2hpIHdyb3RlOg0KPiA+IEZyb206
IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQo+ID4gDQo+ID4gZm9s
bG93X3B1ZF9tYXNrKCkgZG9lcyBub3Qgc3VwcG9ydCBub24tcHJlc2VudCBwdWQgZW50cnkgbm93
LiAgQXMgbG9uZyBhcw0KPiA+IEkgdGVzdGVkIG9uIHg4Nl82NCBzZXJ2ZXIsIGZvbGxvd19wdWRf
bWFzaygpIHN0aWxsIHNpbXBseSByZXR1cm5zDQo+ID4gbm9fcGFnZV90YWJsZSgpIGZvciBub24t
cHJlc2VudF9wdWRfZW50cnkoKSBkdWUgdG8gcHVkX2JhZCgpLCBzbyBubyBzZXZlcmUNCj4gPiB1
c2VyLXZpc2libGUgZWZmZWN0IHNob3VsZCBoYXBwZW4uICBCdXQgZ2VuZXJhbGx5IHdlIHNob3Vs
ZCBjYWxsDQo+ID4gZm9sbG93X2h1Z2VfcHVkKCkgZm9yIG5vbi1wcmVzZW50IHB1ZCBlbnRyeSBm
b3IgMUdCIGh1Z2V0bGIgcGFnZS4NCj4gPiANCj4gPiBVcGRhdGUgcHVkX2h1Z2UoKSBhbmQgZm9s
bG93X2h1Z2VfcHVkKCkgdG8gaGFuZGxlIG5vbi1wcmVzZW50IHB1ZCBlbnRyaWVzLg0KPiA+IFRo
ZSBjaGFuZ2VzIGFyZSBzaW1pbGFyIHRvIHByZXZpb3VzIHdvcmtzIGZvciBwdWQgZW50cmllcyBj
b21taXQgZTY2ZjE3ZmY3MTc3DQo+ID4gKCJtbS9odWdldGxiOiB0YWtlIHBhZ2UgdGFibGUgbG9j
ayBpbiBmb2xsb3dfaHVnZV9wbWQoKSIpIGFuZCBjb21taXQNCj4gPiBjYmVmODQ3OGJlZTUgKCJt
bS9odWdldGxiOiBwbWRfaHVnZSgpIHJldHVybnMgdHJ1ZSBmb3Igbm9uLXByZXNlbnQgaHVnZXBh
Z2UiKS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhv
cmlndWNoaUBuZWMuY29tPg0KPiA+IC0tLQ0KPiA+IHYyIC0+IHYzOg0KPiA+IC0gZml4ZWQgdHlw
b3MgaW4gc3ViamVjdCBhbmQgZGVzY3JpcHRpb24sDQo+ID4gLSBhZGRlZCBjb21tZW50IG9uIHB1
ZF9odWdlKCksDQo+ID4gLSBhZGRlZCBjb21tZW50IGFib3V0IGZhbGxiYWNrIGZvciBod3BvaXNv
bmVkIGVudHJ5LA0KPiA+IC0gdXBkYXRlZCBpbml0aWFsIGNoZWNrIGFib3V0IEZPTExfe1BJTixH
RVR9IGZsYWdzLg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3g4Ni9tbS9odWdldGxicGFnZS5jIHwgIDgg
KysrKysrKy0NCj4gPiAgbW0vaHVnZXRsYi5jICAgICAgICAgICAgICB8IDMyICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0v
aHVnZXRsYnBhZ2UuYyBiL2FyY2gveDg2L21tL2h1Z2V0bGJwYWdlLmMNCj4gPiBpbmRleCA1MDk0
MDhkYTBkYTEuLjZiMzAzMzg0NWM2ZCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9tbS9odWdl
dGxicGFnZS5jDQo+ID4gKysrIGIvYXJjaC94ODYvbW0vaHVnZXRsYnBhZ2UuYw0KPiA+IEBAIC0z
MCw5ICszMCwxNSBAQCBpbnQgcG1kX2h1Z2UocG1kX3QgcG1kKQ0KPiA+ICAJCShwbWRfdmFsKHBt
ZCkgJiAoX1BBR0VfUFJFU0VOVHxfUEFHRV9QU0UpKSAhPSBfUEFHRV9QUkVTRU5UOw0KPiA+ICB9
DQo+ID4gIA0KPiA+ICsvKg0KPiA+ICsgKiBwdWRfaHVnZSgpIHJldHVybnMgMSBpZiBAcHVkIGlz
IGh1Z2V0bGIgcmVsYXRlZCBlbnRyeSwgdGhhdCBpcyBub3JtYWwNCj4gPiArICogaHVnZXRsYiBl
bnRyeSBvciBub24tcHJlc2VudCAobWlncmF0aW9uIG9yIGh3cG9pc29uZWQpIGh1Z2V0bGIgZW50
cnkuDQo+ID4gKyAqIE90aGVyd2lzZSwgcmV0dXJucyAwLg0KPiA+ICsgKi8NCj4gPiAgaW50IHB1
ZF9odWdlKHB1ZF90IHB1ZCkNCj4gPiAgew0KPiA+IC0JcmV0dXJuICEhKHB1ZF92YWwocHVkKSAm
IF9QQUdFX1BTRSk7DQo+ID4gKwlyZXR1cm4gIXB1ZF9ub25lKHB1ZCkgJiYNCj4gPiArCQkocHVk
X3ZhbChwdWQpICYgKF9QQUdFX1BSRVNFTlR8X1BBR0VfUFNFKSkgIT0gX1BBR0VfUFJFU0VOVDsN
Cj4gPiAgfQ0KPiANCj4gUXVlc3Rpb246IElzIGFhcmNoNjQgc3VwcG9ydGVkIHRvbz8gSXQgc2Vl
bXMgYWFyY2g2NCB2ZXJzaW9uIG9mIHB1ZF9odWdlIG1hdGNoZXMNCj4gdGhlIHJlcXVpcmVtZW50
IG5hdHVyYWxseSBmb3IgbWUuDQoNCkkgdGhpbmsgdGhhdCBpZiBwbWRfaHVnZSgpIGFuZCBwdWRf
aHVnZSgpIHJldHVybiB0cnVlIGZvciBub24tcHJlc2VudA0KcG1kL3B1ZCBlbnRyaWVzLCB0aGF0
J3MgT0suICBPdGhlcndpc2Ugd2UgbmVlZCB1cGRhdGUgdG8gc3VwcG9ydCB0aGUNCm5ldyBmZWF0
dXJlLg0KDQpJbiBhYXJjaDY0LCB0aGUgYml0cyBpbiBwdGUvcG1kL3B1ZCByZWxhdGVkIHRvIHtw
bWQscHVkfV9wcmVzZW50KCkgYW5kDQp7cG1kLHB1ZH1faHVnZSgpIHNlZW0gbm90IHRvIG92ZXJs
YXAgd2l0aCB0aGUgYml0IHJhbmdlIGZvciBzd2FwIHR5cGUNCmFuZCBzd2FwIG9mZnNldCwgc28g
bWF5YmUgdGhhdCdzIGZpbmUuICBCdXQgSSByZWNvbW1lbmQgdG8gdGVzdCB3aXRoDQphcm02NCBp
ZiB5b3UgaGF2ZSBhY2Nlc3MgdG8gYWFyY2g2NCBzZXJ2ZXJzLg0KDQo+IA0KPiBBbnl3YXksIHRo
aXMgcGF0Y2ggbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IFJldmlld2VkLWJ5OiBNaWFvaGUgTGlu
IDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCg0KVGhhbmsgeW91IGZvciByZXZpZXdpbmcuDQoNCi0g
TmFveWEgSG9yaWd1Y2hp
