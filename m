Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783044D2037
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349699AbiCHS0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349711AbiCHS03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:26:29 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F505A14C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:24:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZvuSpTaMzL9mbHHMvRuDceBz9fXUSqtlO9mRw+5wQ+MFS6rd8/M6ga3lol5k1mdhIcQpfNjrJXB8oPwmkkV29okkJEtLDUDBMQM/5iye+g4JYbFOCcgb6PuAbjxeeHuCNdSKpp0I2QNIrLMT5aL071/nuiOC1x97DCrTU/jgfxG5aEmTDXCf7p0UtgYQfhWempNMDzNq23M9U5HxKRcHlOseXNjIXRiBQj7Yda1lIYEdNDN5yiTcoLtXCH2jSKo0kfB8QgotdmxAThEG6nWvgcSvbOWfqhTDnSs8OZ+EN3wAAW0imne/PCNag1msBtE7BZ3pJsJSiLdiqwXJ3Nlwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DTFkSBpdARB2LRvg7i+EoAb0Vpqh6KH3rDmI+VEn6o=;
 b=NCVK0vecMZJSQ/2+pTP9CIFrKNwZRbRrshgz3orZbdUKKipeEyc4TPQ/ZzTQyHpr1b6KapN2kO9IybCnpf0GYJNYBrktkIq93guvO1CGoBJJyfZiXKtkMBfUkA1qJfAiX/2hstKA6tozDcMZdA441FAGim4aSjdeQklYDTHJ+P6AoUwUuPIx7Fuwr2dJzmBe8PmTkH5+0dcMBU7E60wLLfdYAdFquX35fMldDdOO/EkPAVIgwe/Hmmii2WBjE9N3kMoN2sfcoOw4hdIhv1hCguoSZGaEojd40SRkfpST6mh5D4tZ/6LPN7YSp/sxNcPWoNIW6jkoCeoymZ88h6JafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DTFkSBpdARB2LRvg7i+EoAb0Vpqh6KH3rDmI+VEn6o=;
 b=IoLmst4hrXWUcKjKo3dkbjyuw+758g8TeyR2EF/upDQkAvtn7GPl7D3Gikn69Am+fQ6U396aXXBqmRZEBkTVte2yss5fIKXzmt5L2I2qMC9N8vEhzs4G7wD4AUHbGXxT6RFbvMkmncYFeDynl0P28nH/0ZP8oItRmIJLetFaYBg=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BL0PR05MB4899.namprd05.prod.outlook.com (2603:10b6:208:5c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.6; Tue, 8 Mar
 2022 18:24:02 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::7856:d027:55:4db6]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::7856:d027:55:4db6%2]) with mapi id 15.20.5061.018; Tue, 8 Mar 2022
 18:24:02 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v1 05/15] mm/rmap: convert RMAP flags to a proper distinct
 rmap_t type
Thread-Topic: [PATCH v1 05/15] mm/rmap: convert RMAP flags to a proper
 distinct rmap_t type
Thread-Index: AQHYMvdPNK2hKChpFkCilWEFljuBd6y1ulCAgAAO7QCAAAQygA==
Date:   Tue, 8 Mar 2022 18:24:01 +0000
Message-ID: <0FFA6BBC-766F-4ABC-821A-062632632475@vmware.com>
References: <20220308141437.144919-1-david@redhat.com>
 <20220308141437.144919-6-david@redhat.com>
 <D7AB3A84-3FFB-4E8D-9E68-BF721CC4C6FC@vmware.com>
 <CAHk-=wiYw9hb-EtjcQ2WDSh4TMCWjJmYitfAn=0y_gguhDtf8Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiYw9hb-EtjcQ2WDSh4TMCWjJmYitfAn=0y_gguhDtf8Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad6c66e8-5f31-4010-bb29-08da0130d20e
x-ms-traffictypediagnostic: BL0PR05MB4899:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BL0PR05MB48993612A1FCB7722A570333D0099@BL0PR05MB4899.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3iT9y3d2VZoz7uwv5j0Tb9VMnEDBA7qzAOOw9KAXF0gBLEsHE0fmk67ZDfJLUVqhVSneXqtQba6Rrfne5d34CCjaZvcRLdEqyW7RQl3yZeY5mCxPgNnLQ5hGNcIl5zt2JzvQ7xBWNg6JGyM5MdAmzDr6J/nEJGsKgHk3FUIEBpcQ+6DuXHB0FGadA0pqQL5keJc4ysafgcwAzVTY9z7s2tt4VHKbTquPxJk4aWjSEJ2/o6UrnpYmF0/9fu8K/SDYCT+lbMAL3yrGMMspUbt6Sh1m9YaGy62x/2HNuBwrTjCQegiEysnL9gi+xtTtWFn1jREUU5z1Wk365EceFlyh3+M4MJyVAX8D13NO7h747+3VMyiQk6d1S/dppAEettBHKJHcF5fLiIlyj3AkjbPgiHoygU6zOmq8wKGDYwbY/gu6p7POoxeQmXj93f/r6iImAYePOaOBOgmFFd5FT9p5XfFQKcuAu8ZIrPzXaQrj12VcdcmQkCLuRv8e3fqbC2IQ70GEJq7MHe1sy9gGLRPTthZKnk3oykgvXOGwg4Q9WDx7W+69ONgtH5TOWgOoczrYGjC4ya6TJc0OrMKCsw1KYTGznPFq1gGm86RcjuPNPd+H/AqjMVRGCKonbPCFZs9Ez3bLDDam0c86Y44Bk9wyZqpif7xq9nuyLN2Vs8ILtol4hcCdD+4sVuylhuyCBg4QzolC7B4eSabEy9oMpA5Oen6SETEopqBof7xkI6znNTAgroQv1ozDu+uyMNoG+qhZyKRK/+KMzCD/LyBg4z4nmRyECOfnTHSEPWOthBFz3bY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(6486002)(316002)(54906003)(38100700002)(26005)(2616005)(186003)(83380400001)(6506007)(6916009)(508600001)(71200400001)(33656002)(36756003)(53546011)(6512007)(38070700005)(5660300002)(86362001)(66446008)(4326008)(2906002)(7416002)(66476007)(76116006)(64756008)(8676002)(66946007)(8936002)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlJoSko0SE1qL0xWTkx5UnVxMHR0ek9BVWkycnd2TlU4U09WeEszSEZqcmsx?=
 =?utf-8?B?VnFSR05BQkhQckFOeDEwSStnWlRBZDFvY1ZuNkxoODEzWmNXeUEyK015Q2JC?=
 =?utf-8?B?c2VHWmx3MUZ3eEpiN3RReEhQUlE3cEhIZUU1SkdRazNGV2llenUrOTNSSjVP?=
 =?utf-8?B?R2U4RWdsVGtzTkM1RVA5dTZUYUNnTUJubmZCVUlSOUprbXdIVStDNTBWbGw3?=
 =?utf-8?B?eHpMVk1RUTN6dlBVdmNKY0RHSVpIQXZYUEIrZjdwa0JSTWpZNlBaQmxxd3dV?=
 =?utf-8?B?Q01JWXBHUVhRUmdaWEJmYmRpb2ZoTmpBQnlkeTcwVjNnd2J5cUdzZk9MQ0tO?=
 =?utf-8?B?S2g1enpkZEJ2blhkNzhvakFOQzNTcDlKYzlFb0RRODk4bDZjVXdhRlk0Z1ZZ?=
 =?utf-8?B?ZVVtV2s3L3pCeXNQRDEvNkU2ZHZuZ2dSMzJXNk9kV1VLbUxkTXZUaGRCWVM2?=
 =?utf-8?B?ZWxKdGtFNEhHNTFHbmN4TUVNUXBzbFRXczJhdlpaTzdiSXZ0bUtueU0zRkRK?=
 =?utf-8?B?ODZlOVFEQktvRk9TZ1dhTnV6RTJ3MUlXN0RlMEwyVzEvcFkxdEU3SWozcXpN?=
 =?utf-8?B?TEdNSjNRZ2ZYd2E4SHViZG85ZEt6d3psMmVkSml3ZkN6bUMycUZLdTcwUGxW?=
 =?utf-8?B?Q0hkbjh0clYyWFZ5UDlaVHNPdVdXbzJIUGRNREd3dGd6NDFFUkFwTGpTaHRC?=
 =?utf-8?B?RDNPb0cvU3A4dzdkU3R0dUNkUmFqdTJlTzZFQzFtdFlMeGZSN1dBaHlzc3No?=
 =?utf-8?B?MTltUVlMS3lQWlM0eXN0UWIxL3N0c3AxQnIxWFFIMWtZOWxaSUFKejhuRzZV?=
 =?utf-8?B?SXhqN0F0Sy9iOWQ3eCtXVzFaZDNsVDcyOHR0WEpna2hzTHI2cjhZWDEvVlhD?=
 =?utf-8?B?QjJONG1PTHRqR0xJQ1FYWVk0SGIyVm1YQTFpNFhHdG91dmY5S3dsclFJbFpH?=
 =?utf-8?B?bDRkREVWZ2dPYWc5RkwvSFB6UzFkcXpFRHlNdWU1RXRSZnlJNy9JQ29rKzFN?=
 =?utf-8?B?bnZyWDUxNGJFOHVqUVhUYW4wOUJVYXYyUUpMOHRZQWY0b25LVWQ4a3dsSDR4?=
 =?utf-8?B?QWUxSk0zOXU1RkZCdjNGeGdzckNMdFdzVjNsajRVS0MwRWU5VktmaG5LVUp5?=
 =?utf-8?B?dkNrbWpTbGVvNFFacHBCMm1QVC9KenJOb3NHUEtsVjZueHp4LzBkay9nbGlK?=
 =?utf-8?B?RDc2Vmd0cnplcm9Va3p1STYrLzV0b1BjN0VodGNFOUdBZmJwWUJGSlNlaGh2?=
 =?utf-8?B?ZlBOc2JDNWdNN2Y1MmxuYXVJWFIrSnNiZXdaRjl1alpBcFhZUjVHemMzakZW?=
 =?utf-8?B?N3o1dWZpbW5OS1ZjSDlOSzllT0EyUklieG4xUnRsTVIwZm5VSi8vYWd6aWU2?=
 =?utf-8?B?bkVQSHB1aHFuUlFCa1pZMy9wMGlINzdIRWZSa1ZabzE1cGI1bFNyemYxWmFE?=
 =?utf-8?B?MEgrb01TTDZYSjJINklaZnpPQlRkS0NRZ3lVSlgxa2h6M3VRUHpJZXNqNzFQ?=
 =?utf-8?B?NmJPUklRc0M5Nm9CNkYxOWNFWENwSC9GaVlaa1p1RFljWGQrWnJrUVc4VFEw?=
 =?utf-8?B?S21Rb1Qyb2FDOW1nRFFNb0R2dnJ2UEhmamRQTjFMMi8wKzlLdWwrZytVSDdw?=
 =?utf-8?B?OVRSd0h2TU5uTUpPYXhXYTdYZ3hCd29WcTZYTlVKRWZ4dkZzeThMS0cxT1hC?=
 =?utf-8?B?MWpPMjh0ZVRKcHQ2U3BuSVNBTTJpaThOMHY2eis1MnRnQWRnWWlRNHJLa016?=
 =?utf-8?B?a2dLcWl3Tkw2dFp6TFNxTGdrR1ozVy9UUmNGMTk0NUJGWHc3SGkzbzJFNTQ1?=
 =?utf-8?B?SHhvR3piZDg2RnY3Q0ZqNjArZjRVeWhSclY4ckplRVZuWXh6QUNRRytuMkNZ?=
 =?utf-8?B?aE1EWUhBTEM1Z2UrbEJQK3NOYi9pUTQyT095TlVYWWtqVnVTVmhRSVFFOVRD?=
 =?utf-8?Q?0hYvWC7COZlhuI+nvEK4hhZE2vOubEeh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46699E85E1111C43B8F38FF726795375@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6c66e8-5f31-4010-bb29-08da0130d20e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 18:24:01.9647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPsTN59f6TQ6QiD18lD7pUEQyq90FII3779fsbGEFOhun5v14KuG/y7bzkp5HuL+wT6rkxw42FX1wAeR8F/qkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB4899
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDgsIDIwMjIsIGF0IDEwOjA5IEFNLCBMaW51cyBUb3J2YWxkcyA8dG9ydmFs
ZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBNYXIgOCwgMjAy
MiBhdCA5OjE1IEFNIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4gDQo+
PiBJdCB3b3VsZCBiZSBtdWNoIGVhc2llciB0byByZWFkLiBUaGUgbGFzdCB0aW1lIEkgbWFkZSBz
dWNoIGEgc3VnZ2VzdGlvbiwNCj4+IEluZ28gc2FpZCAiSSBwZXJzb25hbGx5IGxpa2UgYml0Zmll
bGRzIGluIHRoZW9yeSDigKYgW2J1dF0gb2xkZXIgdmVyc2lvbnMgb2YNCj4+IEdDQyBkaWQgYSBy
ZWFsbHkgcG9vciBqb2Igb2Ygb3B0aW1pemluZyB0aGVtLuKAnQ0KPiANCj4gWWVhaCwgZXZlbiBu
b3QgdGhhdCBvbGQgdmVyc2lvbnMgaGFkIHNlcmlvdXMgaXNzdWVzLCBpaXJjLg0KPiANCj4gQml0
ZmllbGRzIGNhbiBsb29rIG5pY2UsIGJ1dCB0aGV5IGhhdmUgc29tZSBfc2VyaW91c18gc3ludGF4
IGlzc3Vlcy4NCj4gSW4gcGFydGljdWxhciwgdGhleSBhcmUgbmljZSB3aGVuIHlvdSB3YW50IHRv
ICp0ZXN0KiBvbmUgc2luZ2xlIGZpZWxkDQo+IChpZSBiaXQgaW4gdGhpcyBjYXNlKSwgYnV0IGJh
c2ljYWxseSBhdHJvY2lvdXNseSBiYWQgaW4gYWxtb3N0IGFsbA0KPiBvdGhlciBjaXJjdW1zdGFu
Y2VzLg0KPiANCj4gRm9yIGV4YW1wbGUsIHBhc3NpbmcgYSBiaXRmaWVsZCBhZ2dyZWdhdGUgYXMg
YW4gYXJndW1lbnQgaXMganVzdA0KPiBjcmF6eS4gT2gsIHlvdSBjYW4gZG8gaXQsIHdpdGggc3lu
dGF4IGxpa2UNCj4gDQo+ICAgIChzdHJ1Y3QgdHlwZSkgeyAuZmllbGQxID0gMSwgLmZpZWxkMyA9
IDEgfQ0KPiANCj4gYXMgdGhlIGFyZ3VtZW50IGJ1dCB3aGVuIHlvdSBzYXkgIm11Y2ggZWFzaWVy
IHRvIHJlYWQiIEkgbGF1Z2ggaW4geW91cg0KPiBmYWNlIGFuZCBjYWxsIHlvdXIgbW90aGVyIGEg
aGFtc3Rlci4NCj4gDQo+IEFuZCB0aGF0J3MgaWdub3JpbmcgYWxsIHRoZSBpc3N1ZXMgd2hlbiB5
b3Ugd2FudCB0byBjb21iaW5lIHR3bw0KPiBiaXRmaWVsZHMuIFlvdSBjYW4ndCBkbyBpdC4gVGhl
cmUgaXMgbm90aGluZyBsaWtlIHRoZSBiaW5hcnkgIm9yIg0KPiBvcGVyYXRvci4gQWdhaW4sIGl0
J3MgZWFzeSB0byBtb2RpZnkgKm9uZSogZmllbGQsIGJ1dCB0YWtpbmcgdHdvDQo+IGJpdGZpZWxk
cyBhbmQgbWVyZ2luZyB0aGVtPyBOb3QgZ29pbmcgdG8gaGFwcGVuLg0KPiANCj4gU28gbm8uIEJp
dGZpZWxkcyBoYXZlIHRoZWlyIHBsYWNlLCBidXQgdGhleSBhcmUgY2xvc2UgdG8gdXNlbGVzcyBh
cw0KPiAiZmxhZ3MiIHR5cGUgdGhpbmdzIHRoYXQgZ2V0IHBhc3NlZCBhcm91bmQgYXMgYXJndW1l
bnRzLCB1bmxlc3MgeW91DQo+IGhhdmUgdmVyeSB2ZXJ5IHNwZWNpZmljIGFuZCBsaW1pdGVkIHVz
ZS4NCg0KSSBzZWUgeW91ciBwb2ludCByZWdhcmRpbmcgcGFzc2luZyBhbiBhcmcuIFRoZSBvcuKA
mWluZyBvZiBiaXRmaWVsZHMNCmNhbiBlYXNpbHkgYmUgcmVzb2x2ZWQsIHVubGVzcyBJIGFtIG1p
c3Npbmcgc29tZXRoaW5nLCB3aXRoIGEgdW5pb24NCnRoYXQgaG9sZHMgdGhlIGFnZ3JlZ2F0ZSB2
YWx1ZSBhbmQgYW4gYW5vbnltb3VzIHN0cnVjdCB0aGF0IGhvbGRzDQp0aGUgaW5kaXZpZHVhbCBm
bGFncy4NCg0KQXQgdGhlIHRpbWUsIEkgdGhvdWdodCB0aGF0IGJpdGZpZWxkcyBhcmUgbXVjaCBi
ZXR0ZXIgZml0IGZvciBjcHVpZA0KZmllbGRzICh3aGljaCBhcmUgbm90IGp1c3QgZmxhZ3MpLg0K
DQpBbnlob3csIEkgd2lsbCByZWZyYWluIGZyb20gdXNpbmcgYml0ZmllbGRzIGZvciBmbGFncywg
aWYgb25seSBmb3INCnRoZSBzYWtlIG9mIG15IG1vdGhlci4gOikNCg0K
