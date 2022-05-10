Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303DE52123D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbiEJKgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239723AbiEJKf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:35:59 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2057.outbound.protection.outlook.com [40.107.114.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3028C8878C
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAnZYgUxWvlxCGpRMxJ8BKucR8fOgil5iQtI9/zzIhtf0DE9MgFnGS9vOFBBtumrMK35WTdsq0ynSHp4mvlETB14Qtmv4s5o/PgJvKKaBYDaN/BH0yDT4Gr0RSB2BojL65cNirU2cF7dmcfNu7hULPNAYYC6zAIsKhccuMF8NGqQjBMoYP5croT6VrWh9RhYDJvpJpA6gGLE8feuzXjElSRAWN+WwZOSixFaDqDXiBKwPskoI+7lwhVBzzGDoU8JigY7GjG8OCkTb+cINsqrrXu4+56gPrcOlg8D0dL6gOfmQnwHU5Ak0JGCtr4V6K0/e9cQrUQpc0AvsdDLPjK48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKSGSmuE82bK8113x8/4MqGvD+hcmgyd8sPmrQ/64GQ=;
 b=NPtXjf0apj1+pK9x8f7LDNOPOOOZ3wWqOS8m8Pcqa89saKw9OafQee2Avb0MSh/V9+Nfzp0Ng9L0VfUkNmlW48THio33BjaL7hQaZJlctw8IoA+wI7ylfycSzI6jmHsOSuCpg4F8JeMJ/QMP3BioSbtEr78RwpnF7q0GpF5ncuzRIxxVR1euuzFBS3HcOfB1aAvcbZZeQxbMJBrlHwrOklG+lmTeDxtCk7YJDG+XTv4G4Q7OKZ7HpR1DKXZd0f5neLp/U5uFVOxNu7uUC84UdutoSFPq5MrQ0l/wYcKw9Jo2z5fndZ5ZT1Tp3jt4saCuq7kOqHI8PUBFluC8UeNAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKSGSmuE82bK8113x8/4MqGvD+hcmgyd8sPmrQ/64GQ=;
 b=fmO09fX37IR9bakTnxMt83hdVDacjGquXJ1qWzMxA9s3xrGZLuPXv/9iaHsR8sVdqwEkmt6TNUbdJ8Aw/Z8WQxuOu/J9huzB9ntcIKXKecdv/fETX9HY6oghtBxnDiTQVuL4t8UHGvrGHg3ps4kCEy5oRLgo1mSCqNGHTMGqYpU=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB4709.jpnprd01.prod.outlook.com (2603:1096:604:79::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 10:31:59 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 10:31:59 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/hwpoison: use pr_err() instead of dump_page() in
 get_any_page()
Thread-Topic: [PATCH v2] mm/hwpoison: use pr_err() instead of dump_page() in
 get_any_page()
Thread-Index: AQHYZBWU+c33rRXyd0yVW8AaV9c1aK0X6i8A
Date:   Tue, 10 May 2022 10:31:58 +0000
Message-ID: <20220510103158.GA174652@hori.linux.bs1.fc.nec.co.jp>
References: <20220427053220.719866-1-naoya.horiguchi@linux.dev>
 <YnnNteG8+V6dTNna@casper.infradead.org>
In-Reply-To: <YnnNteG8+V6dTNna@casper.infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ea8980b-5275-49f6-945b-08da3270503d
x-ms-traffictypediagnostic: OSBPR01MB4709:EE_
x-microsoft-antispam-prvs: <OSBPR01MB470989FADDEBB1EB77E23653E7C99@OSBPR01MB4709.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YyIN9eiBSP0VZIOwb/pOB++qu2IPifR7wuwW4T/3AsbJQBRnr8a44cOPSaglPMCAVVCBoaXzW3KNQuk7L3p3N5vnJgllvPb8amfTvcPKU1RcD9hSWUcwK3a3g2OivgxkyVmtZVc8KSZTWUTy52vP0xJtimQmCdfmtEqawR9RwaWG6bAyr4sMA87HiADCqXnXMOa7opzPliyfr5DF6xA0mUY+q/U+ZgbqvnvGqAdZ/AoSIgarSjMmWx2x9gDt5ZVc8RFYCcUMAOdAsawokijZLB9KJx1SX1V9yWFDEy7v+S8D8EEHDYluOjfrNxhZFG4BjvFCNgjSCXq3ErkerPRpFNnxR4zZPXypN3ve8e2Ka3bfqQTv21EFLvuqqWIiaLOAsJOIDb0KaezNInRg0RqXL6QXWIg/CqhbueNm+bO6mjsIo/SHoYJ6jp82KP2/Evh6IaErgNHvUZnq0lXvueTew8P/hg9HOOta6ftVfiEDPFCnEhv7/mkjtOHS4iqAbIj7v/R2iYUtpYkTyjyy9qAqZ2bg7BbOlU4qNG16lsZxCeuwqcQkqwMnnYhIbuALT/bQ1NYAEVmqab3uZIElU3lN/qB258pRSc2GOjRBl+XRsgonKB+kR7DpyxxSrL0ktAK0Sb7/rgQtj8ExW8FuZ0NtjEHkpcbCUqbaioyImUh+OlceuGjzoYitRqQKjjdi4ewoMCJD9JZt/HW28QKaZEIFcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(86362001)(38100700002)(122000001)(5660300002)(85182001)(38070700005)(8936002)(6506007)(83380400001)(1076003)(7416002)(66556008)(316002)(66946007)(6486002)(64756008)(66446008)(9686003)(508600001)(82960400001)(66476007)(6512007)(26005)(76116006)(4326008)(54906003)(8676002)(55236004)(6916009)(71200400001)(2906002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEdTSEFUZkdBaktqaWs0UUpTeVZEcTl4MHAvaW9pbjRVeFhpVmhJa0FHL3M5?=
 =?utf-8?B?cTdOUzRLVzJhK1huRk9wVHFHdldhbXlBUE1YV0w1QWhTYU1ieFF1R25JZ1FW?=
 =?utf-8?B?M2VQOG0yL01sQ2VrOUI1Z0d5SFhZR3pTWE45ZDh0Yzl4anUxcDFNZHJMTXFi?=
 =?utf-8?B?TXZiMUFKWTcxQ20wU3RRcklWdHBQUUVHeVcvci8yejVuMkJSWE9meXV1bzVR?=
 =?utf-8?B?KzN6Y1k1RzhSYjB6Tm1rWVZXeXNkY0ZINzRCT1p3UFV3bi9JWUhPOCsvbnlt?=
 =?utf-8?B?dmFYN25ZVWgvL3lmaDcvYVBCanIyL1ZKWFhwUnlTSXMzL2RMNW85bkdBcFpu?=
 =?utf-8?B?NXlCeENSaFFkbjR2Rk05b3NoM1hscHRMdUFVNXVNOTdJblg2Z3ZZTndoMjZK?=
 =?utf-8?B?ZnJJb1Vobmt5YTFhL3kvN0xOYmZFdGlBMC9WemorL09nNE1VOVNRV3pWMDVy?=
 =?utf-8?B?QXZGcUNXODJPZ0ZVdkJoVUE5eVR1NWVaTHhJdTZUc3lZSkdMQUxCMkhRWm9v?=
 =?utf-8?B?WThwVmN3T1ZBT2hQTlRGREEvTXl0NFY1MXJpZHM0OU84bEc3TUZaMW54MzBU?=
 =?utf-8?B?ZUFUcEpTanVIYk9GSEhORy9PbDd1T2toSU9PdDZhWFBOTUR1VVkvMENrZHNC?=
 =?utf-8?B?SnVaZU04SUowTy9DajN4dmlMcmthVXZnWlY0T1BKMm5KL2tHWjlKVERBYmlp?=
 =?utf-8?B?YXVYdmpRazVNSlpLY1dPRXRwZTBoWS91Q1pRaG1nSi8rS21EUlR2eFl2dUdu?=
 =?utf-8?B?QVlNZEpaWVJYbmtqeHpjU2JMU21RZXhrQklvY21aTnRkVyszVTM2RitlN21U?=
 =?utf-8?B?S00rVUhoR3lNTFgxTEo1TlJCeW9PR21uL1JnakN6KzIvdUhHc2pKY2FrVHoz?=
 =?utf-8?B?VU1ucUdSUG1ETC9DN29zV2FtK1lGUmp5TXBZb1J1OFpZUUZrQTIrak1hNzJW?=
 =?utf-8?B?aHFrN25nWEZidzJkUXFVdnVXbE5NOVJEYmxzeUhpWkFRK3lLNWo1OFVSckUw?=
 =?utf-8?B?NitSZW9la2d0eTZBcWx0aGRMakxtRFlRbmNOcXFMSEJBT2lwZzFJUUlwV1kr?=
 =?utf-8?B?dEc2WTRGWGhValFlbmU2RUh6YjByYno1eGRQTS8zY0Zucnp3ZXh5QllrL00r?=
 =?utf-8?B?MTVCQ1MzaVE3aWc5TGJjbW4wMUE3eDNHNjl0MVhmbjAveWt0RWxHajdJbkRO?=
 =?utf-8?B?aWdBVW9zMndCWjNVN1FYNzJYSFFxaUREUEQySHNOaFoxanZMbWRac2M2aUpG?=
 =?utf-8?B?bnpCUmVCOU1HaFhhODQ0bTZTb1J0eWZmTERqWkI2dURkTTFJcHFDbFRMMS9E?=
 =?utf-8?B?UzhnQ3lrVlk1WGFkeDAzQ0Q4NGxkWnRYQVFoSWdZM1FNcnp0ODJFYVN3ZnBk?=
 =?utf-8?B?dTkzczkwa1BQWUN0MjJ6SWRpUlpLSnRzVGhJNUhrMDc3NGo4bkZ0ZndDWlJw?=
 =?utf-8?B?MmZ4WWRuaVo3L1BlS2dFRUlraGlteEZ5ckFTRG5ZZG1tRmNRSnlKdmg1Z2hY?=
 =?utf-8?B?ZnJmL2d1Y0VEUEtWT0lEMUFBem9sWkZZMXdFUStjMmpCZjdYWVlwd1J0dGtZ?=
 =?utf-8?B?LzBUQWsvK3lTdWcxblUyNFNOb0xFSElBM0crTkp5aXhEVTYrbTFkMytKcGZI?=
 =?utf-8?B?d0Q0KzAvSlBueWR0dGFKVjFlZC9nYUw4YlA2OXorbllNMWYxeS9GNGJJdXlB?=
 =?utf-8?B?YnMzSDBOV1pkZ0swMnd5SGVWSDZ3NFBZTjR2Ui8xNmpldVZhTDFTd1l0YUVz?=
 =?utf-8?B?bVlLeUdobXBDR1BQMTdwM09CTzhZbk5SbmZaWldUQ3NOdkU5TDZZVWFrazJL?=
 =?utf-8?B?RmRnUDhzZlRoeUxGT25QM0ord0s1eG03M2VVdGpTM1E3VmY0bkdVbWVYOXJF?=
 =?utf-8?B?cFdkbHFra0NFUHlzL3NnSzFsUmNLWUFucjVVazZmS09jWUFhWTNFTXpCbkp4?=
 =?utf-8?B?OWtBR3JmbktwaEhibitleG1mWEE2UkRzdWNramt2eEF2a1JLbW1ZbW80R2F6?=
 =?utf-8?B?Z2N3L2dHRmhmMHQ4NTJOczBTSWRZdGNHRjV5a3VteW9pcGRmZHRmRFpzZUhI?=
 =?utf-8?B?VGU2SFJHMVVPVFJMTFRrL0NmR1ViTUlUNHc5TVR0UG80d1FMVkp2ZDA0QnZi?=
 =?utf-8?B?TDkzZHhTK3ZENk94YjFlV08rSGVwcEl1UThtcHdtL1pzckJ2Zmk3WHRxbnYw?=
 =?utf-8?B?bGpmeG00Zy8vMXlLcmUwSG05YXY4emFGYzdMUUVBRVpJSEp3OVJxZDRhampW?=
 =?utf-8?B?cnA3bzFNcW5vMDF6TnBGZ3c1ZXZlczRzdWI5RDc1WFlENVVEOFFHL3I1V2Ir?=
 =?utf-8?B?QnhzbGR5eGhrQm4ralJURkJnUHo0TnBUK1NLVFdlZk9GQjZXaFIwQk1oS2da?=
 =?utf-8?Q?b8gu/UNlv2kOpJok=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFED077042FFE74A95F4E724242C7074@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea8980b-5275-49f6-945b-08da3270503d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 10:31:59.0129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVqpVKAAFmMPmryUza/N7npt23/egZXL88SckGd3lUwDzJVr+q6S+TnsHOTPeq3x599hpQYt4a09oSN9sGfW8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4709
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXkgMTAsIDIwMjIgYXQgMDM6Mjg6MDVBTSArMDEwMCwgTWF0dGhldyBXaWxjb3gg
d3JvdGU6DQo+IE9uIFdlZCwgQXByIDI3LCAyMDIyIGF0IDAyOjMyOjIwUE0gKzA5MDAsIE5hb3lh
IEhvcmlndWNoaSB3cm90ZToNCj4gPiBGcm9tOiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmln
dWNoaUBuZWMuY29tPg0KPiA+IA0KPiA+IFRoZSBmb2xsb3dpbmcgVk1fQlVHX09OX0ZPTElPKCkg
aXMgdHJpZ2dlcmVkIHdoZW4gbWVtb3J5IGVycm9yIGV2ZW50DQo+ID4gaGFwcGVucyBvbiB0aGUg
KHRocC9mb2xpbykgcGFnZXMgd2hpY2ggYXJlIGFib3V0IHRvIGJlIGZyZWVkOg0KPiANCj4gU28g
dGhlIHJlYWwgcHJvYmxlbSBpcyB0aGF0IHdlJ3JlIGNhbGxpbmcgZHVtcF9wYWdlKCkgd2hlbiB3
ZSBkb24ndA0KPiBoYXZlIGEgcmVmZXJlbmNlIHRvIHRoZSBwYWdlLCByaWdodD8gIE90aGVyd2lz
ZSBpdCB3b3VsZG4ndCBiZSBmcmVlZC4NCg0KUmlnaHQsIHRoYXQncyB0aGUgcHJvYmxlbS4NCg0K
PiANCj4gPiAgb3V0Og0KPiA+ICAJaWYgKHJldCA9PSAtRUlPKQ0KPiA+IC0JCWR1bXBfcGFnZShw
LCAiaHdwb2lzb246IHVuaGFuZGxhYmxlIHBhZ2UiKTsNCj4gPiArCQlwcl9lcnIoIk1lbW9yeSBm
YWlsdXJlOiAlI2x4OiB1bmhhbmRsYWJsZSBwYWdlLlxuIiwgcGFnZV90b19wZm4ocCkpOw0KPiAN
Cj4gSXQgd291bGQgYmUgbmljZSB0byBnZXQgc29tZSBtb3JlIGluZm9ybWF0aW9uIG91dCBvZiB0
aGUgcGFnZSB0aGFuIHRoYXQNCj4gLC4uIGJ1dCB0YWtpbmcgYSByZWZjb3VudCBpbnNpZGUgZHVt
cF9wYWdlKCkgY29uZmxpY3RzIHdpdGggdGhlIG90aGVyDQo+ICJ3b3VsZCBiZSBuaWNlIiwgd2hp
Y2ggaXMgZm9yIGR1bXBfcGFnZSgpIHRvIHRha2UgYSBjb25zdCBzdHJ1Y3QgcGFnZSAqDQo+IHNv
IHdlIGNhbiAoZWcpIG1ha2UgZm9saW9fdGVzdF91cHRvZGF0ZSgpIHRha2UgYSBjb25zdCBzdHJ1
Y3QgZm9saW8gKi4NCj4gDQo+IFdlJ3ZlIGhhZCBzb21lIG90aGVyIHByb2JsZW1zIHdpdGggaW5j
b25zaXN0ZW50IHBhZ2VzIGJlaW5nIHByaW50ZWQgaW4NCj4gZHVtcF9wYWdlKCkuICBJdCBjYW4g
YmUgcXVpdGUgY29uZnVzaW5nIHdoZW4gZGVidWdnaW5nLiAgSSBzdGlsbCBkb24ndA0KPiBoYXZl
IGEgZ29vZCBzb2x1dGlvbiB0byB0aGF0IGVpdGhlci4NCj4gDQo+IEkgZG8gaGF2ZSBhIHByb3Bv
c2FsIGZvciByZWZvcm1pbmcgbWFwY291bnQgd2hpY2ggd2lsbCBzb2x2ZSB0aGlzDQo+IHBhcnRp
Y3VsYXIgcHJvYmxlbSwgYnV0IEknbSBub3QgcXVpdGUgc3VyZSB3aGVuIEknbGwgZ2V0IHRvIGl0
Lg0KPiBUaGlzIHBhdGNoIGlzIHByb2JhYmx5IHRoZSBiZXN0IHRoaW5nIHRvIGRvIGZvciBub3cu
DQoNClRoYW5rIHlvdSBmb3IgdGhlIGNvbW1lbnQuICBTbyBJIGxlYXZlIHRoaXMgY29kZSBzaW1w
bGUgKG9yIHNvbWUNCmh3cG9pc29uIHNwZWNpZmljIGR1bXBfcGFnZSgpIGlmIHNvbWVvbmUgaGF2
ZSBnb29kIGlkZWFzKSB1bnRpbCBzb21lDQp1bHRpbWF0ZSBzb2x1dGlvbiBpcyByZWFkeSBmb3Ig
dXBzdHJlYW0uDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ==
