Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0030259D194
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbiHWG5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240059AbiHWG5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:57:22 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C385761703
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:57:20 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27N1Q66i029749
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:57:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pMLe2kfjgKSs4AJ7+zzBysQBZ+3J9A6y7MkaGCUKtGw=;
 b=WTak0qrPi5BNIiiEQlSpADmeAHxEeM81/gT6yHStDhsxkOit88DPOwXYxFzuMzP6uMEm
 hzJIFFBykpu7lEQ7yygQnM78dAyT1V7Y1fLwWj9u2WpVtypmNmYAjE/qltY6CibATMHZ
 /BngjgRjppbyb0jtK/kcGvijaX4B/Txgr90= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j4dka24t0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:57:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aafhSzw07tmmDRPJ0QPJAL7PQfprgt6oV9OztQhTrG+rLzeQCA/mNER8uNQmB6IUq2cHw+IlU7PXhp8YP++oAJUXeiuee90ICmVkJ5okadV9Qwux8iO6HdWigtNlJdh5HiZlH4G3yFofFW5KwbVqNrhZ9WPLgxpDIJy1RN/Ue2OfggCQnBPPC3UMz1qsYjsQzqjVs+CH7GV+kt4XrNkNrS2T6MHumdCL21ICnHtCSaO425pFSjQi7QRuX7PC90fR9CH0geiKGIok+6ykSho6OPhxuth1ALqFncqDJuD29p/WTFCAEXliuIL3WpIU+9czXIYfnZGwn+CANf5NBibUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMLe2kfjgKSs4AJ7+zzBysQBZ+3J9A6y7MkaGCUKtGw=;
 b=FUkcrjRiVvkS7iecgF6kiwkZTJ0ygoO4Y/VecOd5+NDKzYCgsAzbSJ+ZJS6BimxDvVMxDdK1ICGBp30fZnrR9YVFXc6M0X+mT2GtRtc/ZCJbAg21OTrCB7RtB1KPDN4h6qBctobzKzHGH8RJ+ULVqZRC0zpJzL43COzBcVTb5Y/5bllWBrgjnbd2YcuVc4neJFQE2IMGzeJEmhIFD7DaLIG5ZkOwePYBg805XYgw8V1TyTaIG4c4LqKfaIoovvQzC05CmpgwP7WhDDaIEf87do6RIgu20ivBsG1eRsresB/c3ORFPvB9l2Zu9vJFAF08jnwqpzWfkqlr3Zw1mewVpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CH2PR15MB3573.namprd15.prod.outlook.com (2603:10b6:610:e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.23; Tue, 23 Aug
 2022 06:57:17 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%8]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 06:57:17 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Kernel Team <Kernel-team@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, Song Liu <song@kernel.org>
Subject: Re: [RFC 0/5] vmalloc_exec for modules and BPF programs
Thread-Topic: [RFC 0/5] vmalloc_exec for modules and BPF programs
Thread-Index: AQHYs1RC3fzFDgbD7kKge/abI0eC0q27FhIAgAANe4CAAAYdAIAA1hSAgAAPrYCAAAUVAA==
Date:   Tue, 23 Aug 2022 06:57:16 +0000
Message-ID: <3E68D344-E053-4F32-91D0-2665508267BB@fb.com>
References: <20220818224218.2399791-1-song@kernel.org>
 <4D089469-B32B-4347-A811-B1E5EE011307@fb.com>
 <YwOwLYUXuSn5acIG@worktop.programming.kicks-ass.net>
 <7621DE6E-D71D-45D1-BAFA-46E882451DD9@fb.com>
 <YwRo43EBIWh7++Qn@worktop.programming.kicks-ass.net>
 <651923c7-8cd3-b3a9-a86f-909107104925@csgroup.eu>
In-Reply-To: <651923c7-8cd3-b3a9-a86f-909107104925@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9c10461-0cf6-4502-a034-08da84d4b75b
x-ms-traffictypediagnostic: CH2PR15MB3573:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dm1fPgWTypu+1p8NGjsQOrgBw2eTJnwoBj1DZ9AqYvN6UfKn1QuhXWulR+oYbzztRRUtr1GN83ukDVFQKhmDjWk8dEo8aMni9WXtpzwhB6zj2UlV9RDTYw8moTvixdD6ujDkfHzs/I49EwVTHlhNIt/hmncKThQHvvOFzxz3uTv7OmItbssxam0r5luWe3XOxbdScXsCI+oUrZ80jk6VHpo2mSgk0x/1lqzJtztivYIMryXq11qidWmCsZNasjRaKjcY6FbSmLK2l4Qs8oPSj67gRseHRo5IHYC2CCjzIDBBuWqD/FLejDlvBOuk25rUeCLqN128SfVirdfH2mDwy5DgRUwu0gOlC1pr52R+U4ggO0MRotDXq+wthVBG1FN9O0eNFd2T9S5ONmD176w5dekxHvZDCXfpQHHUYNlIfHM4Y5icaJ2G5Dxu8txrCPj1sxYh2U6wnSq6tUN6hUvzPacSR7f5UjOeB8j1wVmsiivIRWl7rYI+W1+ZLLFGyBAzD7J2ol40K5GT9pPQ42lPOYMHVJkt/1DSmKbBwN1AvfJYSKjvdxjiZy5oGVLw21l3jq7TMarTRT+pjrXOsLnpqYTQn86CLHKSllQmdLVLESZvaXZ/l4ignrqmE4+DoxrPpHSc8F2VA705/VTBzf6j8ALYKgM7xueUJZOgiOjsASk9CyL3JEcbb1CTiz5jWNvchIvwGIquXcpxz9iBlK6kJ1Wt5N2ttl7tHb3VmOeb9yQ/AmcmM9k72Z4wzanu5qowjJ1k7s3SYBXsghDP5I2NQoZoDmWCAaIsI31TxTyU9zs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(66574015)(2616005)(5660300002)(64756008)(6486002)(4326008)(7416002)(66476007)(91956017)(8936002)(66556008)(76116006)(66446008)(66946007)(478600001)(83380400001)(33656002)(36756003)(53546011)(6506007)(6512007)(186003)(71200400001)(41300700001)(8676002)(122000001)(38070700005)(86362001)(54906003)(316002)(6916009)(2906002)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3NxL21zOU9OTTJxUG9HVVVYMmN5YmpHLzVXcUx5dXl4UkpzZUZDUlVRSDFr?=
 =?utf-8?B?WG16NGFjamV0bUkxTkVQN1Z0bTdwMUw1UWtOcFoxNmhEaVFVbWkrajZiYWx2?=
 =?utf-8?B?ZlZ2V2FyOGRvVVRydlBYa0o3RlpCN3RXUmsvMURDNTl4d2Fvb01FK0Q4enpo?=
 =?utf-8?B?elgyMVUvMGdjZmk3NkRjSlBNRlNxaDhVQWFTV3VCdlVnNENEQ0krRlpVOTll?=
 =?utf-8?B?MGZ2cjdLT21mVDIvQjlNSTVVY2VycmNnbFlXM2lES0M2R0lkUWZRcytSRjgv?=
 =?utf-8?B?aFBVOHVwYS90U2prRUZwUXdDTDQ3NnhJbU9Sb2F0SG5RT1M4MDd6d1N0ZkY1?=
 =?utf-8?B?MmJHVGpuVG9lRWRDVlhqbjEzb3JqM29ab1ZhbU15SVhSdEw1NDRmUGFtajNV?=
 =?utf-8?B?QVQ1ZVZFSHE1T3VucGE5c0hSV0VZeDVja1dhK1hMS3kvaXM3L24zRTNScExn?=
 =?utf-8?B?Y0VyODdrZHJaTVVaaE9sRE5KT1BLa0IrbTNEOHl5cXpZeDVBelIzUExRZUxl?=
 =?utf-8?B?QXhYUSswNGRUZDZlVVRVd3FmVGhsTHdrRDBjZ2ovOHlxUWUrY2MyMXR6SzM0?=
 =?utf-8?B?aS8xQWY5QnJaL2dhQkgxbVVyNUZmOTdYTjhERjloZ2RrTE5mK1V0RHZhVzgr?=
 =?utf-8?B?WFVDV09xbEVQUEVwcTJGbzluREZwM3ozYlRvdlRCWjNEZUs3aVFFTzlyVlJP?=
 =?utf-8?B?Z3d5MUh0NUNZWnB5TE9VbWQ2bEhOaytDbU1XZ3lnWVhOL0sycDJSZWlPcmha?=
 =?utf-8?B?bHlkMTNVaFJudTk2TU1SVUpWMEpPT2dhbG82dXB4dnZkcVMyOVF3NUhabVhz?=
 =?utf-8?B?WWF4OUxsZWtlQWZGc3ROS0FzanFZaVJ2MlpYK1VHb01sbWNzNXE0RkREbUdj?=
 =?utf-8?B?MFFrd2txZ0lwdDVhOFlWR0xxaVRjTUtWb2x6WldIUnVhNkJzN1NxdG1DL0tO?=
 =?utf-8?B?MVpsTlRJak11dXNreWhNQWF0UmhDR0xtYmthc2RGR1VhUzUyWXNCKzQxdkRO?=
 =?utf-8?B?TlhQTFpSRkpXYS9EV0RVMjVKR2hBL0ZRdkVUUE9RdEtMZEhobDM0QytMUlAy?=
 =?utf-8?B?THhQZlJDVUd0Q0FvUHlrR1NxUXR3VDNUQmY2Nk9acnIxOTJCL0ZFN3FrMTdH?=
 =?utf-8?B?OHo0OFF1d0hXelRhSXVOUGhoUjN5Q1Z5WjdDRHZSaC9xcW5WRGM5R1VVMC9E?=
 =?utf-8?B?WlFodFBqdDRZc2NFVHRIVC8yUm9LNTdwZ01WcER5dHloN1BNVXBFTE9DdzlF?=
 =?utf-8?B?dVRTRS9tdVN2Y0txZGtUcVE0L254ekhNZXlXZHJwcVFiSmhrRnVueVNjcFF1?=
 =?utf-8?B?d3lDWnhiVVBEbGRGandISDFqTFBjekRSQW1xZzd0ZkV2dHR4NTE5YXVUdWNL?=
 =?utf-8?B?NmZnS0svNmlnUEwrcEZGb01PcE9EYkdieXNkNjV1Q0J3Yml3UU1WZjJOYkd6?=
 =?utf-8?B?Z3lsSnRjdDIxOE90RG00Vk43K05sOHh6S1JDUnR5TnVJTmZwcWFNdmxYN082?=
 =?utf-8?B?M1EzaGc4ajBKeFVmSFdIOFZ5K0JKOTA1R1h4TUl3eEh3c1E2dWJMalpxYk5m?=
 =?utf-8?B?aGdvKzUzeUtQL3NVQmdQS1FCa0d0amVvc3FEZ3JBOVdQRUVYenY0VFJIWWIz?=
 =?utf-8?B?ZzhnL3B0UWt4MGR4SkxmY25mUVRZZm9xbklOR09GNnJOdnZ5NkVZRVpDM252?=
 =?utf-8?B?QUZ5RGJiWTA5SHFpR0JQWmd4NGp3aW1wQUZLVzRuLzNLTC8wdDNpcGp6NmhK?=
 =?utf-8?B?RXlDZHh4TzZHZ2V1R1NNVUpHQWJEcGo3ZUJhQng4a3VDWm9tV1c3bmgrK3B6?=
 =?utf-8?B?c3V0alRGb3U5T2V0bWIwTythanl3UXN0eGRCVmFucW12dXZiTVRwZmwvUDFN?=
 =?utf-8?B?dW9aMmZwM01CcXhmaU9hcFgrOFh3V2d5T1loSC9LNEJDaEV3R3FOSlNCZndS?=
 =?utf-8?B?WDI0SjFvQXg4VGowQXN1U1pQSXJwM2xUcGxiSUVNMytGUm4ycnRjalNmZll4?=
 =?utf-8?B?b0I0c0dsbE16UG9jQVZmQjdlaWNxTlZ4VWR1QmhNYzRtMjlnOWRyU1FLWGRs?=
 =?utf-8?B?Tk9ZUTR3UXQwSUtiWHBkVExwYWw0d2NpeVdnOVB3ai9oT2tnNUY2RTdORnYw?=
 =?utf-8?B?RWZ4aWE2VEpWeWlCSjV4RWZVTFJhQnhaZTlqRkJwMDd0czhreG81TTB2N3cr?=
 =?utf-8?Q?fMPQDccch5tVGkndr0jlu0U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB89E3DE34E1F140808C1FA077C8FEAE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c10461-0cf6-4502-a034-08da84d4b75b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 06:57:16.9890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tr3/VqHwRGV73ysUGp3rwe3PsbQpCyOHbhYBd185dLsdRjAO5LHzF8+4MCaO7IqE/RUUGdAvp/NtoYrdxpEItA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3573
X-Proofpoint-GUID: o5E1hQgQ6n5DWXHMf5fy45KOEpzUG2TK
X-Proofpoint-ORIG-GUID: o5E1hQgQ6n5DWXHMf5fy45KOEpzUG2TK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_02,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDIyLCAyMDIyLCBhdCAxMTozOSBQTSwgQ2hyaXN0b3BoZSBMZXJveSA8Y2hy
aXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1PiB3cm90ZToNCj4gDQo+IA0KPiANCj4gTGUgMjMvMDgv
MjAyMiDDoCAwNzo0MiwgUGV0ZXIgWmlqbHN0cmEgYSDDqWNyaXQgOg0KPj4gT24gTW9uLCBBdWcg
MjIsIDIwMjIgYXQgMDQ6NTY6NDdQTSArMDAwMCwgU29uZyBMaXUgd3JvdGU6DQo+Pj4gDQo+Pj4g
DQo+Pj4+IE9uIEF1ZyAyMiwgMjAyMiwgYXQgOTozNCBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVy
ekBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IE9uIE1vbiwgQXVnIDIyLCAyMDIy
IGF0IDAzOjQ2OjM4UE0gKzAwMDAsIFNvbmcgTGl1IHdyb3RlOg0KPj4+Pj4gQ291bGQgeW91IHBs
ZWFzZSBzaGFyZSB5b3VyIGZlZWRiYWNrIG9uIHRoaXM/DQo+Pj4+IA0KPj4+PiBJJ3ZlIGxvb2tl
ZCBhdCBpdCBhbGwgb2YgNSBtaW51dGVzLCBzbyBwZXJoYXBzIEkndmUgbWlzc2VkIHNvbWV0aGlu
Zy4NCj4+Pj4gDQo+Pj4+IEhvd2V2ZXIsIEknbSBhIGxpdHRsZSBzdXJwcmlzZWQgeW91IHdlbnQg
d2l0aCBhIHNlY29uZCB0cmVlIGluc3RlYWQgb2YNCj4+Pj4gZG9pbmcgdGhlIHRvcC1kb3duIHRo
aW5nIGZvciBkYXRhLiBUaGUgd2F5IHlvdSBkaWQgaXQgbWFrZXMgaXQgaGFyZCB0bw0KPj4+PiBo
YXZlIGd1YXJkIHBhZ2VzIGJldHdlZW4gdGV4dCBhbmQgZGF0YS4NCj4+PiANCj4+PiBJIGRpZG4n
dCByZWFsaXplIHRoZSBpbXBvcnRhbmNlIG9mIHRoZSBndWFyZCBwYWdlcy4gQnV0IGl0IGlzIG5v
dCB0b28NCj4+IA0KPj4gSSdtIG5vdCBzdXJlIGhvdyBpbXBvcnRhbnQgaXQgaXMsIGp1c3Qgc2Vl
bXMgbGlrZSBhIGdvb2QgaWRlYSB0byB0cmFwDQo+PiBhbnlib2R5IHRyeWluZyB0byBjcm9zcyB0
aGF0IGRpdmlkZS4gQWxzbywgdG8gbWUgaXQgc2VlbXMgbGlrZSBhIGdvb2QNCj4+IGlkZWEgdG8g
aGF2ZSBhIHNpbmdsZSBsYXJnZSBjb250aWd1b3VzIHRleHQgcmVnaW9uIGluc3RlYWQgb2Ygc3Bs
aW50ZXJlZA0KPj4gMk0gcGFnZXMuDQo+PiANCj4+PiBoYXJkIHRvIGRvIGl0IHdpdGggdGhpcyBh
cHByb2FjaC4gRm9yIGVhY2ggMk1CIHRleHQgcGFnZSwgd2UgY2FuIHJlc2VydmUNCj4+PiA0a0Ig
b24gdGhlIGJlZ2lubmluZyBhbmQgZW5kIG9mIGl0LiBXb3VsZCB0aGlzIHdvcms/DQo+PiANCj4+
IFR5cGljYWxseSBhIGd1YXJkIHBhZ2UgaGFzIGRpZmZlcmVudCBwcm90ZWN0aW9ucyAoYXMgaW4g
bm9uZSB3aGF0IHNvDQo+PiBldmVyKSBzbyB0aGF0IGV2ZXJ5IGFjY2VzcyBnb2VzICpzcGxhdCou
ID4NCj4gDQo+IFRleHQgaXMgUk8tWCwgb24gc29tZSBhcmNoaXRlY3R1cmVzIGV2ZW4gb25seSBY
LiBTbyB0aGUgb25seSByZWFsIHRoaW5nIA0KPiB0byBwcm90ZWN0IGFnYWluc3QgaXMgYmFkIGV4
ZWN1dGlvbiwgaXNuJ3QgaXQgPy4gU28gSSBndWVzcyBoYXZpbmcgc29tZSANCj4gYXJlYXMgd2l0
aCBpbnZhbGlkIG9yIHRyYXAgaW5zdHJ1Y3Rpb25zIHdvdWxkIGJlIGVub3VnaCA/DQoNCkFncmVl
ZCB0aGF0IGZpbGxpbmcgd2l0aCB0cmFwIGluc3RydWN0aW9ucyBzaG91bGQgYmUgZW5vdWdoLiAN
Cg0KVGhhbmtzLA0KU29uZw0KDQo=
