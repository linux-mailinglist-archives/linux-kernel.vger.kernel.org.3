Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C55E520DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbiEJGVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 02:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiEJGVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 02:21:11 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2045.outbound.protection.outlook.com [40.107.114.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCB126087E
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 23:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7MqWO4nz9YfVdzMslpevmaWnNeXXZlUQkXC5uU4P8A6X2OhgElSLUKQb0dS9lp9pRF61EnV0ZSyoxzvWivzrnR0WNVuoElhuY8GiznpJBbGHKraFLP/hEHmmKuUI4XQm9d9IwEpJEAZd/9I4J1LsJqPbzoOQx9dloLkbHAISMSioz7ACLuMXrwiiUJurHpfceVJoAz8WETxGzOYa2NbcHO1RjUaNrbzkfButM/5U8S+SGdY8wVljxO0ApZTCHjNfiBz2IuN+qlxhvu5FLoLt6sH75pWTpiYC7HSTIGFSeVjF3YoZfk83JAYy6bwIjQGWwQ17p4Z9vyXhYvUX1Uq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5t+JYH1I0zdsz57WyAn8dq5rAYcBRtjdAs/4MGYCeM=;
 b=ZWbWEZxe6aapggIs2pKdNGkJOJ4DAs9W6VyOaiXMnkYIj/koJOQN2rGGxj+L6pCTHxdSEEhXonywlGxxkuNSrWQWQnWqghva4il4sLyLk0KuRh64apzWT+AoIaZkkrRT2RZsrnlIfZGOjV2Lax4M8MiUmvK713tfRUXfk/hxQSwlTeD0Z7zzlKVW8m6heJwXl6+3fnZgWr+PbgEFh6lSu4IdmNG2TV+ZhYmDnUDYblWyLgTQwDB+rBjMe51y/aL67avxjZ9ZmiJ4CY7z+E6FJgWfw5JFpEIEG4oA4uIh9SADGVMCC8KVkW1u2fUAz3YD9YR3Wl8hvT1oiXqNMZ6enA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5t+JYH1I0zdsz57WyAn8dq5rAYcBRtjdAs/4MGYCeM=;
 b=kbSgRwJimhb9egA5/nzpfNqIx7LklmNiZTmGCz7XCarzKnmk+dt8E8G1SQ+9wB1TAyXuf/d1ZF7kcb1l9RD+ZQAA2Y5GZMj8WN7pSkEsEU14VA76921WoN+BU8EMk0OpX7d2HMdNgKbLQzWBswzLc8mfVtIaobiePPTI/1cpZ00=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB2369.jpnprd01.prod.outlook.com (2603:1096:603:3a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Tue, 10 May
 2022 06:17:13 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 06:17:12 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "david@redhat.com" <david@redhat.com>,
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
Thread-Index: AQHYV7s04sjKvB31sE2FEmou2La8+60Xu7UA
Date:   Tue, 10 May 2022 06:17:12 +0000
Message-ID: <20220510061712.GA162496@hori.linux.bs1.fc.nec.co.jp>
References: <20220424091105.48374-1-linmiaohe@huawei.com>
 <20220424091105.48374-2-linmiaohe@huawei.com>
In-Reply-To: <20220424091105.48374-2-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0641684a-0486-4a65-7210-08da324cb909
x-ms-traffictypediagnostic: OSAPR01MB2369:EE_
x-microsoft-antispam-prvs: <OSAPR01MB236955DB895E4D5F4FDEC501E7C99@OSAPR01MB2369.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YUs9NseDq2he5RkFO5r1L+UCrpCTM9mhjDsEKPjAxB5fA1wlJj0waakMwmM1YgcE7eq8eDVKFT3/VGrCm8latp+lXsp7TA7CCl/k2jeGsi30Y8Hv7VfonBvY1trSwNgv36dR7eJQmPX2qzpTFVNOc+nH77EbymkWEDE1CZYO8oaMUfNDix8sMVk6F2zKEzRsJ2fopssEVmz7AaqPi/YF+0dBrhp9KbiEw0svZUQ0/cjK9B6Ou1hUfjfcGU5UAjvVTn4alFPSGv7t7uyObBCLepeN/hIHHBi1/BAQ+vq2CuGWcT34SzFJUk51k4nHZ8R/MYk1Yf1BOKmns1loou039AB7FY8mrs9lSefrYIZU4PrMckaLvqlj2hSUrtFp0nQ0sN2ZvaeRVEBq8sJcxC3I0sdrzAr/2vkiucTxuh8NybOHeyl8SG8TGjYaLkdMPHn3I+mP+Hj4PYl840ofw5kN5wSv7XTJ+RJmBSZHfDQeccJ9ljzk7UpFiatHBXPPJH1/4L/zqRUx1Bkf3FXKE3SeVydfGuooIP5y4etVGwOVR/MBcEW730AUMcyE1nGWzvqmk0FvHi00i6cJvjY0bJ0mHGrXtavtvryu6J28Vt85s/Hf4Au8Y+vwXm3gt2G4OLgT1hxme8Pk/Uvl/+Q2FEdzD4i4NyrASg02OkGbZWluSBYuoA/Ef7d4sdAUYyYpf92l7MFZZCatwaf36yXRgHCp2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6512007)(71200400001)(66446008)(8676002)(4326008)(9686003)(64756008)(38070700005)(55236004)(2906002)(6506007)(8936002)(508600001)(6486002)(86362001)(66476007)(1076003)(33656002)(83380400001)(5660300002)(54906003)(186003)(316002)(66556008)(6916009)(122000001)(85182001)(76116006)(66946007)(82960400001)(38100700002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEpwU3VGK0taWUZVZ2s5SGw3VWl4V1Mrd2xRUUgrcVVqOFVibWJVYnFSdWRL?=
 =?utf-8?B?dUp3VGt4amVoalNqdytHV3RlOC9ydi9Mc3VsNVpuOEFzZVZpMHAvcXdoRVly?=
 =?utf-8?B?eUFRaGVERkppRFdwK3NYU1hQYkIvd2IvNFVzSUtTSUFQRm5RMi9IRG9qbHRN?=
 =?utf-8?B?anlyN0dtekNWblQ4VWRySzNlTHdDbGJiRUZSTWF5OGFtczhlWVBrM2lJdE95?=
 =?utf-8?B?TjJIcUxEY2I0bVdzSnR5cjBZZ1cvcEVZWmxIQUNjWTlWOFBtMUg2cVdXdzZs?=
 =?utf-8?B?ZFdwTlJlRUd3d01IWGpETmUrdDdXbC9CNUF0dXBsUmlqeEwxR3hSY0wxbHM3?=
 =?utf-8?B?ZGRSUkFFMFd0UGRyWlhzNU5ua3VhZnprczNBYkExOHYwRVYwZnlPYmpJbVZl?=
 =?utf-8?B?cFZ1aXNUK2k3SVQ1clRvQzhKRG5EZldKRGl2RjFOWjVFT1FsWHN4U3AzR2F0?=
 =?utf-8?B?QTVmblNadysxUC9PNG1hcXA2bVA1U1AvY04rNVI0dStPOFVnQjBNMUxVMlZ1?=
 =?utf-8?B?SjcyVTNVK00vbmNBNXRjYTU4dFlUa1VpdUlMa21oRDRsWnFWRXJMZGFFNTBV?=
 =?utf-8?B?d1hKMHRxZ0hyZnZxdFZMYm1JMU5qM1B5RFM3TVNXR0FEMFpxclB5YUwwenRT?=
 =?utf-8?B?R0pzc3VMZzdyZVhKbXF1UUJTanAyWnZOSmJKcVRWZ2FaeXdmV3JTandOMlRF?=
 =?utf-8?B?ZEJZWmZ2MVJIcWxFU1FTMGNRR3hyaEpqZ2RRcmFFWlh6K0EvaVRwM0V4a3lM?=
 =?utf-8?B?UWJsVFJUSitYUlBnZDFYVUMzblNXVmdVQUMxbEx1ekV0U05jd0FDTkJkY2t3?=
 =?utf-8?B?YTJ0N0dhRE5jRjdRRnAyek5wZFhmQ1NRSk1BU3RRYzVYSmJIaWJTdjcza2xn?=
 =?utf-8?B?Z3MwVFV4YW5TS0NFaXdud3liNXVveEFENStnRU94VFk5cGNEaDAxN3RubndT?=
 =?utf-8?B?NzFNS0lSanhGZEV2cnpnSDEyWVFWbGlQRTIvQzQ3WHJNc0Q3eFVJRGhqUWh0?=
 =?utf-8?B?ODdaVWNLL09OaGYrR2RWdUNGQlZteGp3eUdKV012TFVabW5SNXZXU1ljK1BH?=
 =?utf-8?B?ZTFSczVFNStleFlkcFIxVnNhK1pQN2dxMEE3aXo2Rzd1S1B3SDRsVGVtOGFQ?=
 =?utf-8?B?dlB4dVo2M2dhb1FqSUpVaEFJdlFwNlQ1Mldrb0oyRHhvMk9nbUUxeE5DY2U4?=
 =?utf-8?B?dnBEbEUwTFhnRURvcU1Hb0o5QkUyOGNBNFlPellCN1VNV1ZOVkVDMktTcmh2?=
 =?utf-8?B?U2ZML0hjbWM3amIrY0RYYThtaXVKQytDZVB0WmhqZHFoVVhOQjNIN0J2TWc3?=
 =?utf-8?B?aWxlUGpHV3Y0UHlpUHVUQVBGeFBkbEd5b0pldHBuQTZTblpwaGJ2WWlXcWdF?=
 =?utf-8?B?UXNEQkk3VmJtdGxVTVJCN1YzY2hoSDRmendQaC83eFBSbXdWeW1aeHplbG41?=
 =?utf-8?B?Um9kNTRFWThoNDJwbUNha1gwQmk3NVZPMk5saTNBVFBLcnU5aVR6Rklza2ZE?=
 =?utf-8?B?TkI1RW9yWFJML2hiOXdVak1GYVQvMU15L09mWlRkOW5Ob2JuN0kwRFpSbmYx?=
 =?utf-8?B?ZmZJOEVBOExEem1DOWVXZHdZQ29RQmhtY3V6OGZ0QzBjYmlmVlQ5UDFrRktT?=
 =?utf-8?B?RVhmOTMzOUxTOVAyVU0zUjM0MTIrMk91WnFqN3FZMW5JOXlvUHREZEx3T3Vh?=
 =?utf-8?B?MFp2L1laZklxN0lHU1VpQXFUaEpDbW5YTHJ5Zll1OXVrSWMraG5kaDF0M0Yr?=
 =?utf-8?B?SGYyelE1d3BXQmlYWDMrTWo5elJ6a3JvTDJoUDFWMWR6NzVtK3ZseUNxYnh2?=
 =?utf-8?B?Q3VocitWdmJkUEFIYzVNRHh4aGJJbmZkU29TTUtwd2pWNzFUVWxXT0FzQjB6?=
 =?utf-8?B?UERFNEJJK2pmME8vYkxlck9aOWtWejBwUXJTUTB4dngySFppZUFWcjNzZks2?=
 =?utf-8?B?ZkF4Rkl3cXhIZWxLVzZLdmtzV0J5TUVRMkhNUitKL0hTNmpyYnpxTk1MYm5G?=
 =?utf-8?B?NW12NFVNNTdzcWs0UHppZE1OTEVxbGFFRElTbzlESVVTYXIrSlVzdmd4Y1I0?=
 =?utf-8?B?REhtdW1TU1Z5QWlKVW5MMWR1cElTUTVGRjRBTmY0UnMvR25vc3Jpd1VrRUhD?=
 =?utf-8?B?NW85OFBOMEUrZkhYQ3hOdVkzWnJIbVRKdkVObGtYR0FXZDdEUVZlaWlpRUdY?=
 =?utf-8?B?WlZXZXprK1EzZ1hEcmFkSE56MzV6TVNHdUduY3JBUW1UYkF1ZUVTR3NHdms3?=
 =?utf-8?B?M1RrdDh3TnhaZWsrNWRaVTRDUzlJRFhmcXZlTm83MnpWdG9yQjhnV0FLZmRD?=
 =?utf-8?B?WXdneXNxd3pRMGJpV21tYXp6bE4vVFc0QnhFSTJLTGpaWm1FS3BFMkIrNUZt?=
 =?utf-8?Q?/yPcssH4bOpTh9VI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2F7DDAE8887CF41AA0A34192CC90636@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0641684a-0486-4a65-7210-08da324cb909
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 06:17:12.9497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEeLB9ky5jc2h7k2SpLeBkM88mamvR/XvdKBxWxdbBOGfWkjjCQyuvXHKT8EKrF4oOBMCR6wU8uMkWD7KV9oww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2369
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBBcHIgMjQsIDIwMjIgYXQgMDU6MTE6MDNQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gVGhlcmUgaXMgYSBidWcgaW4gdW51c2VfcHRlKCk6IHdoZW4gc3dhcCBwYWdlIGhhcHBl
bnMgdG8gYmUgdW5yZWFkYWJsZSwNCj4gcGFnZSBmaWxsZWQgd2l0aCByYW5kb20gZGF0YSBpcyBt
YXBwZWQgaW50byB1c2VyIGFkZHJlc3Mgc3BhY2UuICBJbiBjYXNlDQo+IG9mIGVycm9yLCBhIHNw
ZWNpYWwgc3dhcCBlbnRyeSBpbmRpY2F0aW5nIHN3YXAgcmVhZCBmYWlscyBpcyBzZXQgdG8gdGhl
DQo+IHBhZ2UgdGFibGUuICBTbyB0aGUgc3dhcGNhY2hlIHBhZ2UgY2FuIGJlIGZyZWVkIGFuZCB0
aGUgdXNlciB3b24ndCBlbmQgdXANCj4gd2l0aCBhIHBlcm1hbmVudGx5IG1vdW50ZWQgc3dhcCBi
ZWNhdXNlIGEgc2VjdG9yIGlzIGJhZC4gIEFuZCBpZiB0aGUgcGFnZQ0KPiBpcyBhY2Nlc3NlZCBs
YXRlciwgdGhlIHVzZXIgcHJvY2VzcyB3aWxsIGJlIGtpbGxlZCBzbyB0aGF0IGNvcnJ1cHRlZCBk
YXRhDQo+IGlzIG5ldmVyIGNvbnN1bWVkLiAgT24gdGhlIG90aGVyIGhhbmQsIGlmIHRoZSBwYWdl
IGlzIG5ldmVyIGFjY2Vzc2VkLCB0aGUNCj4gdXNlciB3b24ndCBldmVuIG5vdGljZSBpdC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1pYW9oZSBMaW4gPGxpbm1pYW9oZUBodWF3ZWkuY29tPg0KPiBB
Y2tlZC1ieTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQoNCldoZW4gSSBy
ZXByb2R1Y2VkIHRoZSBpc3N1ZSAoZ2VuZXJhdGVkIHJlYWQgZXJyb3Igd2l0aCBkbS1kdXN0KSwg
SSBzYXcNCmluZmluaXRlIGxvb3AgaW4gdGhlIHdoaWxlIGxvb3AgaW4gc2htZW1fdW51c2VfaW5v
ZGUoKSAoYW5kIHRoaXMgaGFwcGVucw0KZXZlbiB3aXRoIHRoaXMgcGF0Y2gpLiBJIGNvbmZpcm1l
ZCB0aGF0IHNobWVtX3N3YXBpbl9wYWdlKCkgcmV0dXJucyAtRUlPLA0KYnV0IHNobWVtX3VudXNl
X3N3YXBfZW50cmllcygpIGRvZXMgbm90IHJldHVybiB0aGUgZXJyb3IgdG8gdGhlIGNhbGxlcnMs
DQpzbyB0aGUgd2hpbGUgbG9vcCBpbiBzaG1lbV91bnVzZV9pbm9kZSgpIHNlZW1zIG5vdCBicmVh
ay4NCg0KU28gbWF5YmUgeW91IG5lZWQgbW9yZSBjb2RlIGFyb3VuZCBzaG1lbV91bnVzZV9pbm9k
ZSgpIHRvIGhhbmRsZSB0aGUgZXJyb3I/DQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ==
