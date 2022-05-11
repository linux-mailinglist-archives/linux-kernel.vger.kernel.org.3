Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E6A52383A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344412AbiEKQLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344380AbiEKQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:10:57 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2054.outbound.protection.outlook.com [40.107.114.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2476655D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNaa0m/ioFgoIVznnUU90AvDmOKFHZoOtymfzDB8BSMQC4QM0HtMKPDq6nRHGJf34bAL9/NbevUuzB0s/PNn9Yy0dr8FA0D7nuQcM4zmQ3OmVWWClnxpET19auqVI+Tz6wN2rZRSP+/r6FstGe62hBwQajnQJbdJD5Pe0gtunfozjunDp7wyxfc6NGck9V6ox1iWI9g1TdykgrgjW9uhKCvrtezsExvRfyYEe7TToS49vuV1KPB20sFQjPfIM1J5dowZzaHVIl67McMSk085kuCFIydhwkEjjJpRx2eLazAoPGUd1srpBgPmodDcORQGGzaTx7LbLsjS/P4vwLIf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qripg1bgbDkAAmn6HxWS+tp+k3/jKdQxEaHa+YpMhX0=;
 b=eeicusH9RbFqwhqqjJPk2Y9ZmajRW0vM3Ug/52AoZPlj/oLBw4ew5V+SVLhr7R6JjfJMAQWxcPb1oYJIShecG9+LtHC9bycn/JIGDDVltHwJXgP5Hm/fyKpgNx/ECIFbavE6xC6avy/5w+aIMPOUIgiGAbYC5lDNcgh/5KeRNY9UnxX31zHabZluNknYtaet+hPVf/gz2uiR4wiEQbt3wtXuvabQEDTYbCYD+ZoEzt12rPNSgpHb7YoYyjfJLid8icRtAEwF10GbdctqLD2ior2nMArOEHqx6z+zvIwPnGihjWYTmyS0QkADJ35IJAQIYJ4d3w57PssrBItTyENAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qripg1bgbDkAAmn6HxWS+tp+k3/jKdQxEaHa+YpMhX0=;
 b=lfy7f9KXWSqJOi5KehFcxYxCv/C5KuECgYpP8GF+7UCpixUsFdnQK9XAndZhKtu0WposmblRDQFu+n7pRJUjgJxWFJHs7mXYgoFG7gtB8ZsJkJ4Fylgy1OCJ6BovGefdrWYZ/CnE7OUD5L5/dH0QHgwMoeK2TBaLuim3z0L/tB8=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB8114.jpnprd01.prod.outlook.com (2603:1096:604:170::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 16:10:54 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8%7]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 16:10:53 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
Thread-Topic: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
Thread-Index: AQHYWe9WIfS7YLZ5REqhyMUPm2f3sK0DlLoAgAAZ3ICAAVXTgIARNKEAgAAayQCAAA8ZAIAADz2AgANssYCAABCmAA==
Date:   Wed, 11 May 2022 16:10:53 +0000
Message-ID: <20220511161052.GA224675@hori.linux.bs1.fc.nec.co.jp>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
 <20220427122049.GA3918978@hori.linux.bs1.fc.nec.co.jp>
 <bb1caf48-7e9d-61bf-e0dc-72fcc0228f28@redhat.com>
 <20220509072902.GB123646@hori.linux.bs1.fc.nec.co.jp>
 <6a5d31a3-c27f-f6d9-78bb-d6bf69547887@huawei.com>
 <Ynjl4JmLXkA47U8T@localhost.localdomain>
 <465902dc-d3bf-7a93-da04-839faddcd699@huawei.com>
 <0389eac1-af68-56b5-696d-581bb56878b9@redhat.com>
In-Reply-To: <0389eac1-af68-56b5-696d-581bb56878b9@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 300ccaa2-a52c-44d6-e6cc-08da3368d326
x-ms-traffictypediagnostic: OS3PR01MB8114:EE_
x-microsoft-antispam-prvs: <OS3PR01MB8114688EBB989DA90B6849F7E7C89@OS3PR01MB8114.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z+vJYImHvBSYEDeR5bO28Y5+D4VpCY6yegO3ely5Hzo/fGeF90JvmOlpOaWIGNDxs9VJvRNh421qE5D9B91NxRAG3uTZmMrKB45WXyHU1M5LOYuup0xRXVRyTHalUi4eEvlQ51K4ff8ypJv1Xe9o1hvifmWv8c9tOYClQDRnZwZciGV7FNJM66aDX4aHwr7LpnI2HloRlPCMKDkrsSzg4jDZirfqBN9jW5t2N2kXsAEQfTJLArQktaXzGRgAGNCsGedDZPktZBLfXStpSVqSf0fnvAGs2unsECtyGG9FXAKJuRdAgiiPEx0f1pIeHu5B0fz0IHfYnLsBH30S5Ndgi3RerNLSOTXxe0wPOMkzLIWN3XcdoTrV/Q+9QDb+EuIFZTtvc3BmAOV7i19pI6w41XwHh3WZt95zxfmPANKYtO1Aaz4ZqYMqKVtH/CQqkrDatNLSYK1Z2QjRyq6PGUxzNEOFhunkJGlwK4Bvisw03zvnGUb1uhpsVbt0V3+pO5pOJ3QojCajJRFNTPI7c35UtUURJaGPluE++XsQAzvVWfamarKzMR4ESxXdiu6P6BoAPAC1O1yERH5wtaxsE8/YAvL827c/fJfdgYJ59hezQnn/R0A2i2FdAJPOIKN95dcFhN5AeFTQEZgt6TBmB4hT1sE0ecEzUAVMhRcK5feAbAf7pUeIvDcFQhEB/3943Rwp/4rziRVu9RmEAA7dRUHGtJMIUGbS14o/+iXbCC+5mQ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(33656002)(64756008)(66446008)(66476007)(66556008)(5660300002)(6506007)(7416002)(86362001)(76116006)(71200400001)(186003)(1076003)(8676002)(4326008)(83380400001)(38070700005)(6916009)(6486002)(54906003)(38100700002)(26005)(85182001)(9686003)(6512007)(8936002)(508600001)(55236004)(53546011)(82960400001)(2906002)(316002)(122000001)(25903002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVlSbHhWVWYrcmQvWDd3MXFMYUJvRW04RVpjbWJ5Y1FCb1h5QzlyK0tqYi8x?=
 =?utf-8?B?Smo4RDUzQ3dqUWZuajNsWlk5NXNubEM1ejUyeEE5NGI3TVM1Mk5mSTVjUjZp?=
 =?utf-8?B?UUZWbjJVeFFxSkRmNHpVUEluK0oyUGdwN1ZkNklxK21iOG0yWDlXT3hURy9N?=
 =?utf-8?B?V3VmSmxyb1kzcUNPMmc5Mmc3bC81eEJIY284MTVqT1VZQXh1b1ltejhvaE9W?=
 =?utf-8?B?WWY5RjR2NEhzREFlYzJvY0xPS3lpQUsxZzFLZXJKR01aR1pDU0ZzYkNqdnpW?=
 =?utf-8?B?YjRMQTlITll2b1g0ZUN4MVZjcHBTcG84Tk1UcFFORUxzMGJxMmhWc29kM25q?=
 =?utf-8?B?bDVnTnl1ZHFINDhlbVlyNnhqdm50Zy9sWUI2Q0FkZEZVOFFTODZ1SXJEcTdv?=
 =?utf-8?B?Q2R2NGxaRUxZL2U3N0tKbDhkVDhQZ2RhYm1uYTNLMUVjUUZJd0RxNmFwRk1k?=
 =?utf-8?B?SEpWZVoxeGdJL1dBZ0RpZVRyZitHMXBYcVdRS0c1Nlc4U25MWCt4SlgrTFhU?=
 =?utf-8?B?Szc3ZW9lSU5TWklIdGdyZlQ0L0E5ZzVySDU4akZsMFBYMjhvdFo0NlNHYTNv?=
 =?utf-8?B?WWV4dmcrWk9Qdlh2bUFNYk5JaitSREVlUUdJMnN6eFFFaDVPKyszcEJyTnpa?=
 =?utf-8?B?Mk1WTW9jQnVPWkhiSVRVMlV0ZE9ybmlKNU40a3lQOTVTTFQyMDBNMy9BSnJa?=
 =?utf-8?B?VXJCQUd5R1ZrWWpJc04zWG90WXlLM3NlcG4wMVlZUlNYU3QwaFZkeCtEV0JV?=
 =?utf-8?B?bWtqYmNmdU1oNFdvUFlCNkNhR3RicFY3UDZWbXJiK2VCUFl2OFFxOU9RNk1q?=
 =?utf-8?B?WHlIRy9jUjFFVVo2M1FTUC9Sb1NyK1Y5cUFweTJJOFNwZ1hqUnQveXhLaTRa?=
 =?utf-8?B?alhPNllSNTd3a01pQytZeng0czBYVGJTZHRrc0VOWDI4c3FpdjFobHVFN0tJ?=
 =?utf-8?B?MnJPV0xTRjh0QUFsdG94ZWRMQ1BPUmxOQWUxMjJQR3pSUUE0Sk14SEpPL2h4?=
 =?utf-8?B?QUVsTVR3SU9jVy96MXZrN0VETU1DWU5JNElQdWNQTWxUaVhvck1QaGwwelhr?=
 =?utf-8?B?ZUJMVFViVkEzZUhsS2VCQVJpc1hEMGdBTktpRk1ZMzY2VHk2azNMbmZubk0v?=
 =?utf-8?B?Q0ZQQnkveGlRRXppU2E4djdnSnZBYmlCRndJeEVrcU1sRFZhYzBjVGV3MDYv?=
 =?utf-8?B?b3dVWVpSS0hUQW1RL3YrdFJJdStlU09kKzBpK0loWkRlZ2VqNDFwTXlNNVVi?=
 =?utf-8?B?WHprR09LSkpLblpVb2tKQVhzem85WWYxbVpqS0FlNHhDWGVFQ0R3dEZzN1k5?=
 =?utf-8?B?ZEl5T2RMZmFSRktBa1ZqUHFBMDZZK2dIWnpiVEJWbTZISXNnaUhhVUdZQUxj?=
 =?utf-8?B?bk1tOGcvOFlTUVZ2Tm5hYXpZY3ovc1kwT2lLYnZVRzd6MzJuMzhqeUJzMTlm?=
 =?utf-8?B?elFrdGVsbDYxblM2dHFyNDh3bkVZTjZFUkxxdk5EQ25tbTQzNkFZUWhVeXp6?=
 =?utf-8?B?d0VnbldkR205T2I1NEIySExhVkQ3WVlseVpDMmlPWGRZU09RaFdxMnU3Y2k5?=
 =?utf-8?B?Qi91YWE2WFlyWmlEeTltaUkzZzZvNTdHZC85VDdadmpNM0EyWlk5VndKL01i?=
 =?utf-8?B?ZFp1OUpUYi9OMkxpckNHS0gzeEVXVTdRMFppMlpyUnl4MWhya1Z0UnUvK0tK?=
 =?utf-8?B?bVFLNzYxa1hHYWVLUjAya0hhM3o0QmpBT1U3RVNlbHlRc3l1dWZwQVFnUm1T?=
 =?utf-8?B?L25peDlNdzZPQm52MUFmOURYSFNhZlNnZWtNUHVwNFp0WWNKdWU1T2NtTEdu?=
 =?utf-8?B?a01ENTE4c1BoZEYyWFNwTXV0Z1crNWJpd3dpZUN0NlNvTUhnU2VQRWV6VEww?=
 =?utf-8?B?OEo0UVpHVFpPT0JLQ2k0enVzVzhoREVZaHdWSFhCRVU3a0dCNW9QZnVZT0Q2?=
 =?utf-8?B?NE50WjhlbWEvbkRPekVFZEJoaFVkcWcwNE5ib2pBOFdqbkpMMDMydjlMZmQ1?=
 =?utf-8?B?Y0syemxWZFpZQi8xQWxxYTR4c2wzWGtwTmhTMkZDajA5d2tyQkhmcHhDSVRs?=
 =?utf-8?B?TnRrdTNtbUVOYVEvQStYRStlMExLTGE3clNLeDkzbDJVYjh6ZEVqb1FiUkZY?=
 =?utf-8?B?VGYyVTZzRGFWL1pPWVhYN0ZvaHlQVHhRNFlpN1M4MEZTOEg2b2RmU09TeXRY?=
 =?utf-8?B?S3RvN3ozT3BnMnlvbzJLREZYdmFhcjVJclRVRlc2YjN3dVQrb0xEeDNSOWJX?=
 =?utf-8?B?SzMvdFM5QlNwTURGbzlCaSt6cUdJUXJ3TmRmZ1ZlRUdkbE5TSUkvWVNUbDFI?=
 =?utf-8?B?K3k0TFFKaVVCSjQ5V0VzWDFUaVBKckNHQjZzd1EyWXNKSjVvdFlVZUNobFdP?=
 =?utf-8?Q?9HjVyHf0+BjM/G1A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0FF411A6A7BDD47A0A3BDBA7B5A5D23@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300ccaa2-a52c-44d6-e6cc-08da3368d326
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 16:10:53.8191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnmsyzXx36wnVb+ufe27yhZaFmenEvwvkUCHFb1HLat7Qv0crpZqUmhCE85T2/EgziWg1zaQiYlFGSbqY1yQFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMTEsIDIwMjIgYXQgMDU6MTE6MTdQTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6DQo+IE9uIDA5LjA1LjIyIDEyOjUzLCBNaWFvaGUgTGluIHdyb3RlOg0KPiA+IE9u
IDIwMjIvNS85IDE3OjU4LCBPc2NhciBTYWx2YWRvciB3cm90ZToNCj4gPj4gT24gTW9uLCBNYXkg
MDksIDIwMjIgYXQgMDU6MDQ6NTRQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90ZToNCj4gPj4+Pj4g
U28gdGhhdCBsZWF2ZXMgdXMgd2l0aCBlaXRoZXINCj4gPj4+Pj4NCj4gPj4+Pj4gMSkgRmFpbCBv
ZmZsaW5pbmcgLT4gbm8gbmVlZCB0byBjYXJlIGFib3V0IHJlb25saW5pbmcNCj4gPj4+DQo+ID4+
PiBNYXliZSBmYWlsIG9mZmxpbmluZyB3aWxsIGJlIGEgYmV0dGVyIGFsdGVybmF0aXZlIGFzIHdl
IGNhbiBnZXQgcmlkIG9mIG1hbnkgcmFjZXMNCj4gPj4+IGJldHdlZW4gbWVtb3J5IGZhaWx1cmUg
YW5kIG1lbW9yeSBvZmZsaW5lPyBCdXQgbm8gc3Ryb25nIG9waW5pb24uIDopDQo+ID4+DQo+ID4+
IElmIHRha2luZyBjYXJlIG9mIHRob3NlIHJhY2VzIGlzIG5vdCBhbiBoZXJjdWxlYW4gZWZmb3J0
LCBJJ2QgZ28gd2l0aA0KPiA+PiBhbGxvd2luZyBvZmZsaW5pbmcgKyBkaXNhbGxvdyByZS1vbmxp
bmluZy4NCj4gPj4gTWFpbmx5IGJlY2F1c2UgbWVtb3J5IFJBUyBzdHVmZi4NCj4gPiANCj4gPiBU
aGlzIGRvc2UgbWFrZSBzZW5zZSB0byBtZS4gVGhhbmtzLiBXZSBjYW4gdHJ5IHRvIHNvbHZlIHRo
b3NlIHJhY2VzIGlmDQo+ID4gb2ZmbGluaW5nICsgZGlzYWxsb3cgcmUtb25saW5pbmcgaXMgYXBw
bGllZC4gOikNCj4gPiANCj4gPj4NCj4gPj4gTm93LCB0byB0aGUgcmUtb25saW5pbmcgdGhpbmcs
IHdlJ2xsIGhhdmUgdG8gY29tZSB1cCB3aXRoIGEgd2F5IHRvIGNoZWNrDQo+ID4+IHdoZXRoZXIg
YSBzZWN0aW9uIGNvbnRhaW5zIGh3cG9pc29uZWQgcGFnZXMsIHNvIHdlIGRvIG5vdCBoYXZlIHRv
IGdvDQo+ID4+IGFuZCBjaGVjayBldmVyeSBzaW5nbGUgcGFnZSwgYXMgdGhhdCB3aWxsIGJlIHJl
YWxseSBzdWJvcHRpbWFsLg0KPiA+IA0KPiA+IFllcywgd2UgbmVlZCBhIHN0YWJsZSBhbmQgY2hl
YXAgd2F5IHRvIGRvIHRoYXQuDQo+IA0KPiBNeSBzaW1wbGlzdGljIGFwcHJvYWNoIHdvdWxkIGJl
IGEgc2ltcGxlIGZsYWcvaW5kaWNhdG9yIGluIHRoZSBtZW1vcnkgYmxvY2sgZGV2aWNlcw0KPiB0
aGF0IGluZGljYXRlcyB0aGF0IGFueSBwYWdlIGluIHRoZSBtZW1vcnkgYmxvY2sgd2FzIGh3cG9p
c29uZWQuIEl0J3MgZWFzeSB0bw0KPiBjaGVjayB0aGF0IGR1cmluZyBtZW1vcnkgb25saW5pbmcg
YW5kIGZhaWwgaXQuDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL21lbW9yeS5jIGIv
ZHJpdmVycy9iYXNlL21lbW9yeS5jDQo+IGluZGV4IDA4NGQ2N2ZkNTVjYy4uM2QwZWY4MTJlOTAx
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Jhc2UvbWVtb3J5LmMNCj4gKysrIGIvZHJpdmVycy9i
YXNlL21lbW9yeS5jDQo+IEBAIC0xODMsNiArMTgzLDkgQEAgc3RhdGljIGludCBtZW1vcnlfYmxv
Y2tfb25saW5lKHN0cnVjdCBtZW1vcnlfYmxvY2sgKm1lbSkNCj4gICAgICAgICBzdHJ1Y3Qgem9u
ZSAqem9uZTsNCj4gICAgICAgICBpbnQgcmV0Ow0KPiAgDQo+ICsgICAgICAgaWYgKG1lbS0+aHdw
b2lzb25lZCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUhXUE9JU09OOw0KPiArDQo+ICAg
ICAgICAgem9uZSA9IHpvbmVfZm9yX3Bmbl9yYW5nZShtZW0tPm9ubGluZV90eXBlLCBtZW0tPm5p
ZCwgbWVtLT5ncm91cCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXJ0
X3BmbiwgbnJfcGFnZXMpOw0KPiAgDQoNClRoYW5rcyBmb3IgdGhlIGlkZWEsIGEgc2ltcGxlIGZs
YWcgY291bGQgd29yayBpZiB3ZSBkb24ndCBoYXZlIHRvIGNvbnNpZGVyDQp1bnBvaXNvbi4gIElm
IHdlIG5lZWQgY29uc2lkZXIgdW5wb2lzb24sIHdlIG5lZWQgcmVtZW1iZXIgdGhlIGxhc3QgaHdw
b2lzb24NCnBhZ2UgaW4gdGhlIG1lbW9yeSBibG9jaywgc28gbWVtLT5od3BvaXNvbmVkIHNob3Vs
ZCBiZSB0aGUgY291bnRlciBvZg0KaHdwb2lzb24gcGFnZXMuDQoNCj4gDQo+IA0KPiBPbmNlIHRo
ZSBwcm9ibGVtYXRpYyBESU1NIHdvdWxkIGFjdHVhbGx5IGdldCB1bnBsdWdnZWQsIHRoZSBtZW1v
cnkgYmxvY2sgZGV2aWNlcw0KPiB3b3VsZCBnZXQgcmVtb3ZlZCBhcyB3ZWxsLiBTbyB3aGVuIGhv
dHBsdWdnaW5nIGEgbmV3IERJTU0gaW4gdGhlIHNhbWUNCj4gbG9jYXRpb24sIHdlIGNvdWxkIG9u
bGluZSB0aGF0IG1lbW9yeSBhZ2Fpbi4NCg0KV2hhdCBhYm91dCBQR19od3BvaXNvbiBmbGFncz8g
IHN0cnVjdCBwYWdlcyBhcmUgYWxzbyBmcmVlZCBhbmQgcmVhbGxvY2F0ZWQNCmluIHRoZSBhY3R1
YWwgRElNTSByZXBsYWNlbWVudD8NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hpDQoNCj4gDQo+
IEFub3RoZXIgcGxhY2UgdG8gc3RvcmUgdGhhdCB3b3VsZCBiZSB0aGUgbWVtb3J5IHNlY3Rpb24s
IHdlJ2QgdGhlbiBoYXZlIHRvIGNoZWNrDQo+IGFsbCB1bmRlcmx5aW5nIHNlY3Rpb25zIGhlcmUu
DQo+IA0KPiBXZSdyZSBhIGJpdCBzaG9ydCBvbiBmbGFncyBpbiB0aGUgbWVtb3J5IHNlY3Rpb24g
SSB0aGluaywgYnV0IHRoZXkgYXJlIGVhc2llciB0bw0KPiBsb29rdXAgZnJvbSBvdGhlciBjb2Rl
IGV2ZW50dWFsbHkgdGhlbiBtZW1vcnkgYmxvY2sgZGV2aWNlcy4=
