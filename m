Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB7D5245E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350461AbiELGgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350457AbiELGgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:36:04 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2072.outbound.protection.outlook.com [40.107.113.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F346309
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkMyjvB3ykM0yVVmNk5ID/zxt9PvmGP0vU4+yrqRpXk+atYtD9ou3msI+5NPkiQbSLpLQAw+aDDazFFOl4+4plyjCl52Fibn2TS5IuUsuFlSbYuUhtcnR7rRrNbzHtpN7TpT34KKD6PTSiJ3l3rA5SNgGG4OyaSEoi/2fEf9iA6Myom8luKveuOsalKcOn3SQ63xdqcGX6JxttHuxrh2SZJ+2z0tasPmdNqvSNMt19m8x1JO5d5M6NkhcCoghonXDpI0iFxqw63NJEJF7cGLVM1swmKlHw+e7+8SoqSbFWomAcKERFx1MEtJb6Bw2CUFwFi4jEJAtHveC2mjaohY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDd74z6Ee/25GtkxtDHbBNh7kUACtXQr8j7A3WbeTAA=;
 b=aE0A3eUfYA9zwQIXCJWe+kL1DT1NA9CzmdtYJ7LX4kmtZYR47TGOKpoOHCFFtN29PtZQkuY63GMXlpyFzdeytUnY/Evxayfg/rRmFRc3yyeoL8R7ZuJ9r8ipiU/cw4zZjeBjO+z3q1g+joS9pKG0RPIYwFpiAOniaLv1Ft1oQuGYe+nBGI3gDGNz/W63CGH5LSVB13ILr6QayKozeU2YaKgKhr1w4m7IiUNEXfkAGQwpjKIoNk35z6qshoXHfM90i280VFYazM4m/ojd9B79n031FPUN14dGVxE3O5gDNebahPyOngYOuxB0OFSMqCqYHl5FbexXbRNIFq2CyGPn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDd74z6Ee/25GtkxtDHbBNh7kUACtXQr8j7A3WbeTAA=;
 b=TcRBeuswK3F/IOPGaIE2xB4lC27z1PB4dwZ0/k3agrJ3Tad4FrY7iXlhzGYLYvrwWr940KPfQWEbSaxJWTRVqxyitksWUanrT+xRR9hxRvZRxqT5gPzzaru6/LJVBnFcOQ81IyO6MxSUeC/CO6kuKZA7DrrGjGVvtb3j9Qis4Xc=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB6512.jpnprd01.prod.outlook.com (2603:1096:400:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 06:35:59 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8%7]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 06:35:59 +0000
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
Thread-Index: AQHYWe9WIfS7YLZ5REqhyMUPm2f3sK0DlLoAgAAZ3ICAAVXTgIARNKEAgAAayQCAAA8ZAIAADz2AgANssYCAABCmAIAAA02AgADuaAA=
Date:   Thu, 12 May 2022 06:35:59 +0000
Message-ID: <20220512063558.GA249122@hori.linux.bs1.fc.nec.co.jp>
References: <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
 <20220427122049.GA3918978@hori.linux.bs1.fc.nec.co.jp>
 <bb1caf48-7e9d-61bf-e0dc-72fcc0228f28@redhat.com>
 <20220509072902.GB123646@hori.linux.bs1.fc.nec.co.jp>
 <6a5d31a3-c27f-f6d9-78bb-d6bf69547887@huawei.com>
 <Ynjl4JmLXkA47U8T@localhost.localdomain>
 <465902dc-d3bf-7a93-da04-839faddcd699@huawei.com>
 <0389eac1-af68-56b5-696d-581bb56878b9@redhat.com>
 <20220511161052.GA224675@hori.linux.bs1.fc.nec.co.jp>
 <6986a8dd-7211-fb4d-1d66-5b203cad1aab@redhat.com>
In-Reply-To: <6986a8dd-7211-fb4d-1d66-5b203cad1aab@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad42937e-c0bb-419d-6bef-08da33e1ad1c
x-ms-traffictypediagnostic: TYCPR01MB6512:EE_
x-microsoft-antispam-prvs: <TYCPR01MB65121F29F7DBFC9CDAE18087E7CB9@TYCPR01MB6512.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZSbNeAuS7HAhsTV9o3qVQ6JVXu2D4oBCw/7+VHo6ZabOUpBtiJxbnfSdo/7xzYa/GSDrtV57DIowzip0WQOtqtEgRrTTdLNX+MV+f5nlKm2YGsePdiPkNBVmWslAVlNA/P50yokGre0MWEfFm4HbQJx10uy6lSaY66aubQu7Z06vQHLrHIMesU2ucrBgYjpCoNqYP9+xtFZjYSEXsPhRKz8ZYXT/r75SqrMI/gwW1vdIERS7D1u82Ky7Iddn3PRX+WUPVR6rvzvOAUmJ6DAqayRYPW82PU3zoqyolqGTWCHXHMDooba6Q+rfvUoSk49Tk4SgRk1Dcb9njO36fLlFlcMjZsxNBpNG1sbJ+xAwceCo8r8wElYf7bN9ONmYDgZTXm42oZFededttWj7q2xHA7qlvqwK17z0SYGvK4Qhm2+K28AT6+lijNNjucedpmcn7SwNakkDJlgH+il/6L9gDb5P+RMuhRExouRg+31i6oy8haE9/rLxt/6BorJi2IUqQX7MIt3OASjLNeDCFDW+1zGgQsI0NCWPLXEXnvk3jvW+CFFWadPr66bZFbwyEAUwEn7WS0ok/mAnjhXa77k56XzU19Jv0s+8eDiwSSuM4tSW10aAkWJRzQNky098l75DX7zCpep/m3oap/kQ57paM5DQfdqr+eky7IueuijaHQpMrAcsOrSLSbO7y60aRMMQ9rCe/bd2REidcFuA635AEVPflv/AoAA+Dgo685GSXz0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(85182001)(5660300002)(2906002)(33656002)(7416002)(82960400001)(83380400001)(122000001)(53546011)(6506007)(55236004)(38100700002)(38070700005)(186003)(76116006)(66946007)(1076003)(8936002)(4326008)(66556008)(8676002)(66476007)(66446008)(26005)(6512007)(6916009)(64756008)(316002)(9686003)(6486002)(54906003)(508600001)(71200400001)(86362001)(25903002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S09mM2tHbnA5OFBKVGNra01YaWVoTHYzSTI5ejdHZVhPL2plNVlKbzBHdFBn?=
 =?utf-8?B?akY0Q21iOU1tblEvRUpGNzFZWFVSdUtvQTRCY1Y5VGtuZEQxOWRTNUE5d0ZJ?=
 =?utf-8?B?QzhIV0NNTlRMQ2wxVThkdmNIcXNwMnpoZ1c1MmlDN3VmTEtLcFpkaklkMUJv?=
 =?utf-8?B?aEFHVGNkSUZ2NHUxQ1VQOFpNWjFUdzF0cThFUFJBS1o1elhsZmJWZWtUTlhp?=
 =?utf-8?B?T21EVXdrbFBOUUFBeCtuemkvSWRhQTBzYlhOaEZwUDh6UzBIWHZrSWdkc0pE?=
 =?utf-8?B?T0RvcGU4a09sZ1BMVlJNNTQwa29wUFJhWlZiM2VqeHBkUlFNNGpBNjVnWXVt?=
 =?utf-8?B?YStmY0YxUzRCRENuYm02UDFIWEhSTmNYbHpMakh5bis4WHFvQVdidEgvQmNS?=
 =?utf-8?B?M0Z1OTMyWUJ0eUl0YTAySDQ5NnVlUnJ3T2ViK1YwOFBxbXdWeHpsRnBaYUNh?=
 =?utf-8?B?L1RWS3Via25YY0JqZXYyMkxHNXYwMHc1UEZxTURVanVnN2J3Rzk2RTRSeGU2?=
 =?utf-8?B?ZHZBNlVHTDdWVWFtQURFY3JlaUc1NSthRXpGeXlmR1k1QndvZFFrZEtPc1Zs?=
 =?utf-8?B?dEtONDRRT0pVZkduZDREQ0c2eHBtMHMzZjBYNjYzbFZaTXBSbFFMUXgxOWl4?=
 =?utf-8?B?WGNmWU5qTVl4dnp5WFlzSCs3TjNYWXZjZU02Z04xczNqZXJLSkVvclltamVI?=
 =?utf-8?B?SVQ1UlVacGluSjZwbzFLWmZzei9OSWhXOHEvUWF1UVNsSVE3cHZPeHQ4ZGpt?=
 =?utf-8?B?NXRwbHAwZkhEcFY4UHQ3NnZsMVd3bWR4SnMvNHZmK1JDQm9mUFBuWldwTytq?=
 =?utf-8?B?TjZlVVl0cGJkWWZPOElmaVJxQUdRMzlJSHVGcTVvNUx0cWZzcW1hVmNmRkVh?=
 =?utf-8?B?S3FleHhQcnVtRkVCQ1IzeU9BOVBReGY2UEJRVTdsOWJxVSt1dUVSMklsUnpL?=
 =?utf-8?B?SUpxU09UYlM4K2wvR0puWXlLS1RHSmtxa1MrL1hiM2NWcjFnRWVLR0tXQ1JX?=
 =?utf-8?B?cWc2WVB2cGE2MWVMTVBpZk5ZRVRwNGkyZTVnQ2hPSEFlT1RjNDhKbHNFUExi?=
 =?utf-8?B?TUorREpJQzRxbFhiRFVTYmdDb3QyT2tBZ01CeDQwcEgyRzFPNnc5VXhZZjlr?=
 =?utf-8?B?aFR0L0t6SzQrQyszeDh1aHFYMWNNa2pXVkN5RjRDNGVIbGJVOGtFeEkrNlg0?=
 =?utf-8?B?K3h1c1Jtd0YzNzZyek1YRmRrcUFYdXh3UlR1R3dLSElpVWRHQ200YTlFUjZH?=
 =?utf-8?B?Y0V1VzRCOUtyenlQUHRWQXFwbVhZSEpQaExjamtmZFVHSURDY2l2VDJXYUlt?=
 =?utf-8?B?TURSYytUekdkWkl3VWFJUHBlWVJoZW9MTnlkM3A4ZlFPVHpSb2NNdXgraFIw?=
 =?utf-8?B?RXU3LzZKMkdXL0oxbnRyUVl1NWJMMGFiNmJKbzFDMlZpVnE2S3V2WkhRVGRo?=
 =?utf-8?B?TUxiSDJZZ09ya3djSXZCbHhhYW9WOUdob3pMbGxHZDVRQXlrb05SZHN6MTN6?=
 =?utf-8?B?QkZMV0tHRkhQSitZY0ZlVXVac09RVlcvUGROK0JEV1VlSUtEcEpEVk56T0Yr?=
 =?utf-8?B?YTRpamxHdXZjWWIrYXZrdGhQaGprSjNOTzNLdExNWWdMRnltbDREL3oxb0V1?=
 =?utf-8?B?UzM4SndtVXIyVktRWDRJcUd5TVZUQTR4K0Q2Q1gzeEFyT0NBRmloNFFUNmMy?=
 =?utf-8?B?U3QyVjlFWjA1ZTU5QWI2aE1YQmlKbHFhRENMRU1UcEM0VmhLd0llTzJnOVEv?=
 =?utf-8?B?QlJ5K05Mc2pKZDA0OGgyNHU4blNtbXFrWUg0WVdSTkU5eG5sTGZHeHU4WUdF?=
 =?utf-8?B?dGFEYzBHTzhKOGxHcnBGQTkzNEQ4VndReVpOckRtbWE1Z1lMVXlUVkFiZXRI?=
 =?utf-8?B?b3pJK3VPRmdmYzZJK3VWKzY5bkZ5WGljd0RIN2FHWEg3cjVNd2pDWUx6aG1k?=
 =?utf-8?B?L0xtb01qM3Bqc0VRdy9oTnJBTDNPb2pFNzlBNDByMTJqdHVVY1B6My9IYjU1?=
 =?utf-8?B?azZzM3UrL0xXMjR2ZVNEMlJYZ3VVT0FEUTd4eTJ4SW84bit2VTFoaTZrb0k3?=
 =?utf-8?B?UXp3bkJ6WDIrZDlraHFXRmY4Z3NhU1VzcExKOExoTDVTcGVucStxSGVuZ1pq?=
 =?utf-8?B?K2pOWldTSkQwdEkwZ0lTTXVYNm5wVGVHQkIzb0hEMWpPQkZRUzJsMysrZWoz?=
 =?utf-8?B?ak0yM2RQejcxTW5heHlCcURRVjZ2K1VGdmszNW1RcEtkT1FEbTk4ckhPeXdh?=
 =?utf-8?B?L014ZWx4cUxDelFLV2p6OTFORjkvZEc5d3ZwWER2Ym5XNFFnYnVISHkyeDJh?=
 =?utf-8?B?ejJNZEE4MU5MNHVVMHBRZEwydE9YK0N4Ym9WU0xocXV5cVM3VkxNVnRMOWNj?=
 =?utf-8?Q?xBtRQCLCpyzkznrU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FA44CEB9FF3D2429F4D9C1D9BA9F598@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad42937e-c0bb-419d-6bef-08da33e1ad1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 06:35:59.0857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4t68nK2DpjNGBbxTkomiNV6vk0bHBq6PRe0c/Ep0RPJRGswzalHIivE8kxFnaZB+YHCrhYTOnLc+3PAtR3BZMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6512
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMTEsIDIwMjIgYXQgMDY6MjI6NDFQTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6DQo+IE9uIDExLjA1LjIyIDE4OjEwLCBIT1JJR1VDSEkgTkFPWUEo5aCA5Y+jIOeb
tOS5nykgd3JvdGU6DQo+ID4gT24gV2VkLCBNYXkgMTEsIDIwMjIgYXQgMDU6MTE6MTdQTSArMDIw
MCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+ID4+IE9uIDA5LjA1LjIyIDEyOjUzLCBNaWFv
aGUgTGluIHdyb3RlOg0KPiA+Pj4gT24gMjAyMi81LzkgMTc6NTgsIE9zY2FyIFNhbHZhZG9yIHdy
b3RlOg0KPiA+Pj4+IE9uIE1vbiwgTWF5IDA5LCAyMDIyIGF0IDA1OjA0OjU0UE0gKzA4MDAsIE1p
YW9oZSBMaW4gd3JvdGU6DQo+ID4+Pj4+Pj4gU28gdGhhdCBsZWF2ZXMgdXMgd2l0aCBlaXRoZXIN
Cj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IDEpIEZhaWwgb2ZmbGluaW5nIC0+IG5vIG5lZWQgdG8gY2Fy
ZSBhYm91dCByZW9ubGluaW5nDQo+ID4+Pj4+DQo+ID4+Pj4+IE1heWJlIGZhaWwgb2ZmbGluaW5n
IHdpbGwgYmUgYSBiZXR0ZXIgYWx0ZXJuYXRpdmUgYXMgd2UgY2FuIGdldCByaWQgb2YgbWFueSBy
YWNlcw0KPiA+Pj4+PiBiZXR3ZWVuIG1lbW9yeSBmYWlsdXJlIGFuZCBtZW1vcnkgb2ZmbGluZT8g
QnV0IG5vIHN0cm9uZyBvcGluaW9uLiA6KQ0KPiA+Pj4+DQo+ID4+Pj4gSWYgdGFraW5nIGNhcmUg
b2YgdGhvc2UgcmFjZXMgaXMgbm90IGFuIGhlcmN1bGVhbiBlZmZvcnQsIEknZCBnbyB3aXRoDQo+
ID4+Pj4gYWxsb3dpbmcgb2ZmbGluaW5nICsgZGlzYWxsb3cgcmUtb25saW5pbmcuDQo+ID4+Pj4g
TWFpbmx5IGJlY2F1c2UgbWVtb3J5IFJBUyBzdHVmZi4NCj4gPj4+DQo+ID4+PiBUaGlzIGRvc2Ug
bWFrZSBzZW5zZSB0byBtZS4gVGhhbmtzLiBXZSBjYW4gdHJ5IHRvIHNvbHZlIHRob3NlIHJhY2Vz
IGlmDQo+ID4+PiBvZmZsaW5pbmcgKyBkaXNhbGxvdyByZS1vbmxpbmluZyBpcyBhcHBsaWVkLiA6
KQ0KPiA+Pj4NCj4gPj4+Pg0KPiA+Pj4+IE5vdywgdG8gdGhlIHJlLW9ubGluaW5nIHRoaW5nLCB3
ZSdsbCBoYXZlIHRvIGNvbWUgdXAgd2l0aCBhIHdheSB0byBjaGVjaw0KPiA+Pj4+IHdoZXRoZXIg
YSBzZWN0aW9uIGNvbnRhaW5zIGh3cG9pc29uZWQgcGFnZXMsIHNvIHdlIGRvIG5vdCBoYXZlIHRv
IGdvDQo+ID4+Pj4gYW5kIGNoZWNrIGV2ZXJ5IHNpbmdsZSBwYWdlLCBhcyB0aGF0IHdpbGwgYmUg
cmVhbGx5IHN1Ym9wdGltYWwuDQo+ID4+Pg0KPiA+Pj4gWWVzLCB3ZSBuZWVkIGEgc3RhYmxlIGFu
ZCBjaGVhcCB3YXkgdG8gZG8gdGhhdC4NCj4gPj4NCj4gPj4gTXkgc2ltcGxpc3RpYyBhcHByb2Fj
aCB3b3VsZCBiZSBhIHNpbXBsZSBmbGFnL2luZGljYXRvciBpbiB0aGUgbWVtb3J5IGJsb2NrIGRl
dmljZXMNCj4gPj4gdGhhdCBpbmRpY2F0ZXMgdGhhdCBhbnkgcGFnZSBpbiB0aGUgbWVtb3J5IGJs
b2NrIHdhcyBod3BvaXNvbmVkLiBJdCdzIGVhc3kgdG8NCj4gPj4gY2hlY2sgdGhhdCBkdXJpbmcg
bWVtb3J5IG9ubGluaW5nIGFuZCBmYWlsIGl0Lg0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9iYXNlL21lbW9yeS5jIGIvZHJpdmVycy9iYXNlL21lbW9yeS5jDQo+ID4+IGluZGV4IDA4
NGQ2N2ZkNTVjYy4uM2QwZWY4MTJlOTAxIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2Jhc2Uv
bWVtb3J5LmMNCj4gPj4gKysrIGIvZHJpdmVycy9iYXNlL21lbW9yeS5jDQo+ID4+IEBAIC0xODMs
NiArMTgzLDkgQEAgc3RhdGljIGludCBtZW1vcnlfYmxvY2tfb25saW5lKHN0cnVjdCBtZW1vcnlf
YmxvY2sgKm1lbSkNCj4gPj4gICAgICAgICBzdHJ1Y3Qgem9uZSAqem9uZTsNCj4gPj4gICAgICAg
ICBpbnQgcmV0Ow0KPiA+PiAgDQo+ID4+ICsgICAgICAgaWYgKG1lbS0+aHdwb2lzb25lZCkNCj4g
Pj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUhXUE9JU09OOw0KPiA+PiArDQo+ID4+ICAgICAg
ICAgem9uZSA9IHpvbmVfZm9yX3Bmbl9yYW5nZShtZW0tPm9ubGluZV90eXBlLCBtZW0tPm5pZCwg
bWVtLT5ncm91cCwNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXJ0
X3BmbiwgbnJfcGFnZXMpOw0KPiA+PiAgDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB0aGUgaWRlYSwg
YSBzaW1wbGUgZmxhZyBjb3VsZCB3b3JrIGlmIHdlIGRvbid0IGhhdmUgdG8gY29uc2lkZXINCj4g
PiB1bnBvaXNvbi4gIElmIHdlIG5lZWQgY29uc2lkZXIgdW5wb2lzb24sIHdlIG5lZWQgcmVtZW1i
ZXIgdGhlIGxhc3QgaHdwb2lzb24NCj4gPiBwYWdlIGluIHRoZSBtZW1vcnkgYmxvY2ssIHNvIG1l
bS0+aHdwb2lzb25lZCBzaG91bGQgYmUgdGhlIGNvdW50ZXIgb2YNCj4gPiBod3BvaXNvbiBwYWdl
cy4NCj4gDQo+IFJpZ2h0LCBidXQgdW5wb2lzb25pbmcrbWVtb3J5IG9mZmxpbmluZyttZW1vcnkg
b25saW5pbmcgaXMgYSB5ZXQgbW9yZQ0KPiBleHRyZW1lIHVzZSBjYXNlIHdlIGRvbid0IGhhdmUg
dG8gYm90aGVyIGFib3V0IEkgdGhpbmsuDQoNCk9LLiBNYXliZSBzdGFydGluZyB3aXRoIHNpbXBs
ZSBvbmUgaXMgZmluZS4NCg0KPiANCj4gPiANCj4gPj4NCj4gPj4NCj4gPj4gT25jZSB0aGUgcHJv
YmxlbWF0aWMgRElNTSB3b3VsZCBhY3R1YWxseSBnZXQgdW5wbHVnZ2VkLCB0aGUgbWVtb3J5IGJs
b2NrIGRldmljZXMNCj4gPj4gd291bGQgZ2V0IHJlbW92ZWQgYXMgd2VsbC4gU28gd2hlbiBob3Rw
bHVnZ2luZyBhIG5ldyBESU1NIGluIHRoZSBzYW1lDQo+ID4+IGxvY2F0aW9uLCB3ZSBjb3VsZCBv
bmxpbmUgdGhhdCBtZW1vcnkgYWdhaW4uDQo+ID4gDQo+ID4gV2hhdCBhYm91dCBQR19od3BvaXNv
biBmbGFncz8gIHN0cnVjdCBwYWdlcyBhcmUgYWxzbyBmcmVlZCBhbmQgcmVhbGxvY2F0ZWQNCj4g
PiBpbiB0aGUgYWN0dWFsIERJTU0gcmVwbGFjZW1lbnQ/DQo+IA0KPiBPbmNlIG1lbW9yeSBpcyBv
ZmZsaW5lLCB0aGUgbWVtbWFwIGlzIHN0YWxlIGFuZCBpcyBubyBsb25nZXINCj4gdHJ1c3R3b3J0
aHkuIEl0IGdldHMgcmVpbml0aWFsaXplIGR1cmluZyBtZW1vcnkgb25saW5pbmcgLS0gc28gYW55
DQo+IHByZXZpb3VzIFBHX2h3cG9pc29uIGlzIG92ZXJyaWRkZW4gYXQgbGVhc3QgdGhlcmUuIElu
IHNvbWUgc2V0dXBzLCB3ZQ0KPiBldmVuIHBvaXNvbiB0aGUgd2hvbGUgbWVtbWFwIHZpYSBwYWdl
X2luaXRfcG9pc29uKCkgZHVyaW5nIG1lbW9yeSBvZmZsaW5pbmcuDQo+IA0KPiBBcGFydCBmcm9t
IHRoYXQsIHdlIHNob3VsZCBiZSBmcmVlaW5nIHRoZSBtZW1tYXAgaW4gYWxsIHJlbGV2YW50IGNh
c2VzDQo+IHdoZW4gcmVtb3ZpbmcgbWVtb3J5LiBJIHJlbWVtYmVyIHRoZXJlIGFyZSBhIGNvdXBs
ZSBvZiBjb3JuZXIgY2FzZXMsIGJ1dA0KPiB3ZSBkb24ndCByZWFsbHkgaGF2ZSB0byBjYXJlIGFi
b3V0IHRoYXQuDQoNCk9LLCBzbyB0aGVyZSBzZWVtcyBubyBuZWVkIHRvIG1hbmlwdWxhdGUgc3Ry
dWN0IHBhZ2VzIGZvciBod3BvaXNvbiBpbg0KYWxsIHJlbGV2YW50IGNhc2VzLg0KDQpUaGFua3Ms
DQpOYW95YSBIb3JpZ3VjaGk=
