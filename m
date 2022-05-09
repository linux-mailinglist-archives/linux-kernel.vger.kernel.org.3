Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF6051F6C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 10:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiEIINo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237611AbiEIIBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:01:32 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on20622.outbound.protection.outlook.com [IPv6:2a01:111:f403:7010::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AEB3E5EA
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9tQZ/RD8Rj0N9haIYqRNsdIBTp6QXaxmVpqKeBtc3kwPg9m3/9u3IPmcigoq216gztz+3VGgjEG9/46O6ao4xUEIczv134YieGadpa6OqnVYnJiZRHB3XwsN5z2HBxQV0t3l+bq7xNWUlbfoMhn2DQKz2YYTUpG94kZY7ankM+4vXBlhWSEkXctanAiA0XkO8Opwth9XBmTWf4NsMpnuo0Oq8R2HBrjKKLYm1h0Z9ecUxofG9YiiHD3KC6jj/ZXrdZU3KF9RC/3uCt/1TNrFd5hdtpwT8bXPfGQf8hWGiCRhdZbdU/miCotrquMwoYqOSPXvd103Cr5j1YA9SbNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5Vs6RAuVrkoEQ2O372ZV2gO4z4Pbfl0oNIZyaVJxAA=;
 b=ncafwWT8gCQw3DMLw6XiQbOGQXCBP7DkR6WKSnlJZr9jjGZ/M32biYwMDKbWvebAB9dyB/cl5oDVCMqGCS9Snoz3Lbq2ULLEcfHcdlyyNT7pWtKlXlkcY8nALVwL65/Wow/so9CCB9YYZIfUBuVGJVTqMviewdtkmYbljC2LmzFR40wTuiCYBJR7032ljUTsnRb0z8GYapkg3e/JbZV7lnarq/AF8NojkjC8vYGwyKKB8I3EvgsmzTRat3UX+SGalWRASKW6xyWKAEdbPIj7QYW76cHUhQx9ve8nt3eGrmmrYx3orYMQDxLLCGhYsBSTgaukMxwoP9+7BGWS+Rp6xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5Vs6RAuVrkoEQ2O372ZV2gO4z4Pbfl0oNIZyaVJxAA=;
 b=cLmyiUjYuNdn130g3Nv6w6lPkJzrLDvT7ypmD9pxpHHP4TDzo4CQBwOtxXIW1TrfkR3Yd6kWdH4L9h+h6Ua79V0YyPuouZ6jI6gG2IvtrpVddp3HRSj3HiL/OCeJE9pt3ROPHsFqspyTm9wOsUGj5Ugi6GMf65zovI92mMYRibA=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYAPR01MB3792.jpnprd01.prod.outlook.com (2603:1096:404:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 07:55:49 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 07:55:48 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v1 2/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove
 memory section with hwpoisoned hugepage
Thread-Topic: [RFC PATCH v1 2/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove
 memory section with hwpoisoned hugepage
Thread-Index: AQHYWe9YcUyBIKlo9keOjg616USyLK0GmCQAgA+oYAA=
Date:   Mon, 9 May 2022 07:55:48 +0000
Message-ID: <20220509075548.GC123646@hori.linux.bs1.fc.nec.co.jp>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <20220427042841.678351-3-naoya.horiguchi@linux.dev>
 <9bdddf53-b01a-9665-04c3-0146efc1404d@huawei.com>
In-Reply-To: <9bdddf53-b01a-9665-04c3-0146efc1404d@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e830c3e8-ead4-4544-685f-08da319154d3
x-ms-traffictypediagnostic: TYAPR01MB3792:EE_
x-microsoft-antispam-prvs: <TYAPR01MB3792C07E0897E16A26D4229BE7C69@TYAPR01MB3792.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kilOPcCWe6w5uc+rnVVSsYlQ1XwENuzfPR7JNTYOgDzU7vb/ce6rozxC8FRFqdlDDtozl+hH0ZKtTPCw4KZ7sIGTEUTg1S1d+4fcwWb07h2TlHXmZasl7qNlcAhcovkJFPg6hPuVrmWZx+TOO7eQ/WjA515J4vyzrbAp7fPX3ItcYaQ7rzmuEAFRj7uXAskmDMlRKt3GccDxp5+LqJww1KrHD6g6w20uw8c3bY4S+NDMV1os5kxsus0njhvExhoMWGT5t5MbEg2nqmJ1SkcgautjedfV71V1mSiL+RdeNeyRKCEHNnr9JTjk4mztYa/t1Uz1XppZfOSQKKVv4ydVMQKN4DR1eU10dWRc1hB1OjbTsMfSSSFz/pIWqpqL127MOYJv/rBg3oWd3IgY6KyxBeBEGGjRKAEEb8CdfgoScKyNfOzs02z1zRFeblA/0/GfNW/PLebXe0YvZSGVI5TAcRCcqzssIOWvXnPuymdF8EH33BVQ6BpvEmlO+QpcrK7hC34sqy3PAl6R0DjryulD0CgeeZFnMRv/rASdjKhAwPbjXAjxIxwXbBK8wI2gMg2iQ8s5m6yhWcJf56OEgj7Yi6Y2fPlVsXZGid2yPESsJWeSziw9+PyBadB5SNEBtWB093vdk3TOhaDCeLyDZ4ksRCHuWWThtlcQIXva9hnPPphkrezp1ON1HbHU+c/8u2yCtutvzbAIyJdPq4zW9L2mbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(4326008)(8676002)(1076003)(508600001)(53546011)(6486002)(9686003)(26005)(55236004)(86362001)(38070700005)(6506007)(38100700002)(316002)(66476007)(64756008)(66556008)(66446008)(76116006)(66946007)(54906003)(82960400001)(6916009)(33656002)(6512007)(2906002)(85182001)(8936002)(5660300002)(7416002)(83380400001)(186003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1kyTTUxeXVJLzl4d0Yvb0NPK01JMlNTU010dzRmOFZla2hBR1lDVDFoMFZN?=
 =?utf-8?B?NkYvcFpPU1YzSVN1NHIrSkZRejNZNnRqdndIUVVyMVJSYk4vVEZOVDk3cVBY?=
 =?utf-8?B?VUZORDJ2bE8xTG45a3NmRFhyY2tSblhMTkFLOU9UaXErWnZUSkhLT2ljd2NR?=
 =?utf-8?B?R2VLOU8rM2pIMUZPbHBkT1MzaFhTQllHanhNc01WMVVuRGlSdk5ndlV1TUln?=
 =?utf-8?B?eGplNnNRMVpmTk9YYUdrRy84NWRkL2NOTnpkTXJyMlVzTlhHWkhTcTlyUFVK?=
 =?utf-8?B?aUtua0tWZm1iRGN6M0pZbEM2bExmZjk4Q1lXelJTMTNwdGw0c0RkcVhCZ1BB?=
 =?utf-8?B?MjJ6dFBEaEQzY21Sdldha0p1ZGQ5ZnJmZjVpTHNoSzFqMnM5UVdEWllTbTY4?=
 =?utf-8?B?STc1MlVtTUJQRkhOZTFYdmIyc3lkOEhwMy9vY3pxc0JaRDE4ZmRFMXFmZnp4?=
 =?utf-8?B?UzFCc0pGdmx4YjR4QlM0TGsyK3lMMjZJbm8rQ0loMkFmZThsTmdBejlpOE5X?=
 =?utf-8?B?YTA5cjN1VmZKcG5uZEtKQzRXb3M2bXB5Wi9MbWEwK1QveW04ZnRGbldiN3VG?=
 =?utf-8?B?ZXgyeDVScVJ5cTZDVVllNWdMWWJPcU9HRzlhTUhiRDYvM2p2ekIwTFlscXdw?=
 =?utf-8?B?a3FlYk9obWthUXJnQWdwZHV5Q1NTNXRUZng0eGd1Ny9qSmp2b3ZuWkY0MlpX?=
 =?utf-8?B?eGU2cDlPZGlPVEJ1ZGhkbHhRcUVwVEk4dGs2NUJJVWRmclpmUlEwT1VhSWVC?=
 =?utf-8?B?NFZScHlRc2t0TUp3RUIwTUNkdVNVM2p2Vk4rZDd3aXd2TW9FL0VIbHl6SVU3?=
 =?utf-8?B?ZWI1UHIwUFJqSCt6MER0cGVkYzU0dkF5L053SHlwT1hsck9NZ0ZlLzJiamZa?=
 =?utf-8?B?Y3V1L3VnNTdtUHQwcVFwOGRZMUh4YU0xeW9ORlFKQzRFNFlScmwrMnBsR3dX?=
 =?utf-8?B?SHhaMlYwbGNCY2t0NjA0QnFvcjF0NXBQWmFsSENYQVd4WW45cXhKZkx4WGx6?=
 =?utf-8?B?R0ZqRDdQYXB1TXFXQktWd3ZEVjFtTkpMU3QwMHpuMGJHU241Y3pzbCtaOGY1?=
 =?utf-8?B?TVZaVEowcllBVnpqRU1OTjhPSlRUVEUvT3paa0RXK3VDelRrbmpSWVY2dGx5?=
 =?utf-8?B?TXFOT0pvb3VsS3pYYlA2UjRDMXZVd1Y4VnNVaVl3RXNNOWhVcTc5Vzh6Uzk0?=
 =?utf-8?B?SHVveUxoYmRhTWdTNXhNaldPZVlUY3FrOUZoU05ETG5CTGo2OXo2STVrL3Fk?=
 =?utf-8?B?SDg0TzhQcGdZb29kbnRtR0pHMnVlMk9lei9PcE1DTjdMZFF4SXdGaHRkbUlY?=
 =?utf-8?B?UThSUUJSclUyaG8zMnVKMGMwY3NPZGtaSCtUM2xENzBCTnp2ZEp5dWp3SkRJ?=
 =?utf-8?B?ZE1WRzNXMkY1dzJWTzE4clRCdDhHQWhsdWpoMWNHdEU3SFEvV2ZOTExMUllF?=
 =?utf-8?B?cm5HcU1WMUpOVUZ0RDFONnlEbDVBU0V6bHVVNnIxZUtibi9BL08wSjlFQ0Ry?=
 =?utf-8?B?ZG40QjRRT09xeEUxWTZhM0FxN2lIeWZRZ3lCZUJWM21YWHdvYWp3SWtreGli?=
 =?utf-8?B?dmhFL2MxWFNhMXQyL2oyWGVPUml2a0Qyb1l3ck9rRlJWWk9jdWRBMEx2MUI3?=
 =?utf-8?B?dmZWNVFlV0phUGkwWjA2SUgwM2RRZ05NS0dJRVFnd0ZxQUtDaXNIak11Vm1E?=
 =?utf-8?B?Z0l6RW0xaTk2SitJZFRHYlRVT2pXRnNhRG5RanNQU3NFemVkZ2I3d1lzT1do?=
 =?utf-8?B?S3FPNDJ4UmtDQ29lMDZKQjgvZHFVVlU5ekMyMFp1OThFejZaaVN5ekIzQ0Vi?=
 =?utf-8?B?MGVQZmRxY3lNeGd6Mkp5RXpib0EwZDBra281MzF0T0RVVmtoNTdHOFpNYnRI?=
 =?utf-8?B?c2JyN1M3WVhMVlVFME4za2Uza3BZUjBmMmRPSlNETUxVc0dCQ1plQVNWaVFz?=
 =?utf-8?B?bnV4Z1M2TWhQVVE4NS9Iei8zaEtUWWdIZVZoSkdncm9vU1pVcTUrQzRpM3lE?=
 =?utf-8?B?TmZOZEIvcGJMZnJBU2lyUmxxRnhIRXMza0FFRjFPWWswcmd3R0pGTE5SSHlr?=
 =?utf-8?B?YjZuMDlWRDJpWDFTbVlIMEJmaW00S2tKNmp6YW1PZTFoek5vNGJ2dTZrQ3Nl?=
 =?utf-8?B?ajBLS1RxWkZWSUVwRDU0V1J6U0p3dWtDWjJPNUhTbnpoRVdqR25XZ0NsZ0Ev?=
 =?utf-8?B?Y1R5Q2JicnJoZmM4alArWkVFN2FiNHhKYjRwemRiYTVqZWJacW92MkFFKzRD?=
 =?utf-8?B?TmZxWHhBYlk2eXlTNFpVWGNPUWY1SEVKODdPaDNmZzE2b0tKcE10cE1WTThH?=
 =?utf-8?B?SlhoT20yWFFiYUhlNnFlK3FpV3NqdFltcGsvZjh3REQ3UHZCdGtnbVB6MG9u?=
 =?utf-8?Q?fLAeeY0Czn3Fi2zc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5F3FBF5F5B6664F9CE1A90280ED57C4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e830c3e8-ead4-4544-685f-08da319154d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 07:55:48.9193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZBqdJCX6oUqqm7eno5OoWJQf6d3NxxtzWCxSu7HCiWYBnWLBUJJkTEIqmBE9CxPDNWwzDe/Ob0zCaE3GrjmfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3792
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBcHIgMjksIDIwMjIgYXQgMDQ6NDk6MTZQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi80LzI3IDEyOjI4LCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gRnJv
bTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiANCj4gPiBI
V1BvaXNvbmVkIHBhZ2UgaXMgbm90IHN1cHBvc2VkIHRvIHByZXZlbnQgbWVtb3J5IGhvdHJlbW92
ZSwgYnV0DQo+ID4gY3VycmVudGx5IHRoaXMgZG9lcyBub3QgcHJvcGVybHkgd29yayBmb3IgaHdw
b2lzb25lZCBodWdlcGFnZXMgYW5kIHRoZQ0KPiA+IGtlcm5lbCB0cmllcyB0byBtaWdyYXRlIHRo
ZW0sIHdoaWNoIGNvdWxkIGNhdXNlIGNvbnN1bWluZyBjb3JydXB0ZWQNCj4gPiBkYXRhLg0KPiA+
IA0KPiA+IE1vdmUgZGlzc29sdmVfZnJlZV9odWdlX3BhZ2VzKCkgYmVmb3JlIHNjYW5fbW92YWJs
ZV9wYWdlcygpLiBUaGlzIGlzDQo+ID4gYmVjYXVzZSB0aGUgcmVzdWx0IG9mIHRoZSBtb3ZhYmxl
IGNoZWNrIGRlcGVuZHMgb24gdGhlIHJlc3VsdCBvZiB0aGUNCj4gPiBkaXNzb2x2ZS4gIE5vdyBk
ZWxheWVkIGRpc3NvbHZlIGlzIGF2YWlsYWJsZSwgc28gaHdwb2lzb25lZCBodWdlcGFnZXMNCj4g
PiBjYW4gYmUgdHVybmVkIGludG8gNGtCIGh3cG9pc29uIHBhZ2Ugd2hpY2ggbWVtb3J5IGhvdHBs
dWcgY2FuIGhhbmRsZS4NCj4gPiANCj4gPiBBbmQgY2xlYXIgSFBhZ2VNaWdyYXRhYmxlIHBzZXVk
byBmbGFnIGZvciBod3BvaXNvbmVkIGh1Z2VwYWdlcy4gVGhpcyBpcw0KPiA+IGFsc28gaW1wb3J0
YW50IGJlY2F1c2UgZGlzc29sdmVfZnJlZV9odWdlX3BhZ2UoKSBjYW4gZmFpbC4gIFNvIGl0J3MN
Cj4gPiBzdGlsbCBuZWNlc3NhcnkgdG8gcHJldmVudCBkb19taWdyYXRlX3BhZ2VzKCkgZnJvbSB0
cnlpbmcgdG8gbWlncmF0ZQ0KPiA+IGh3cG9pc29uIGh1Z2VwYWdlcy4NCj4gPiANCj4gPiBSZXBv
cnRlZC1ieTogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgbW0vaHVnZXRsYi5jICAgICAgICB8IDExICsrKysrKysrKysrDQo+ID4gIG1tL21lbW9y
eS1mYWlsdXJlLmMgfCAgMiArKw0KPiA+ICBtbS9tZW1vcnlfaG90cGx1Zy5jIHwgMjMgKysrKysr
KysrKystLS0tLS0tLS0tLS0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCsp
LCAxMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbW0vaHVnZXRsYi5jIGIv
bW0vaHVnZXRsYi5jDQo+ID4gaW5kZXggNjg2N2VhODM0NWQxLi45NWIxZGI4NTJjYTkgMTAwNjQ0
DQo+ID4gLS0tIGEvbW0vaHVnZXRsYi5jDQo+ID4gKysrIGIvbW0vaHVnZXRsYi5jDQo+ID4gQEAg
LTIxNTksNiArMjE1OSwxNyBAQCBpbnQgZGlzc29sdmVfZnJlZV9odWdlX3BhZ2VzKHVuc2lnbmVk
IGxvbmcgc3RhcnRfcGZuLCB1bnNpZ25lZCBsb25nIGVuZF9wZm4pDQo+ID4gIA0KPiA+ICAJZm9y
IChwZm4gPSBzdGFydF9wZm47IHBmbiA8IGVuZF9wZm47IHBmbiArPSAxIDw8IG1pbmltdW1fb3Jk
ZXIpIHsNCj4gPiAgCQlwYWdlID0gcGZuX3RvX3BhZ2UocGZuKTsNCj4gPiArDQo+ID4gKwkJaWYg
KFBhZ2VIdWdlKHBhZ2UpICYmIFBhZ2VIV1BvaXNvbihwYWdlKSkgew0KPiA+ICsJCQkvKg0KPiA+
ICsJCQkgKiBSZWxlYXNlIHRoZSBsYXN0IHJlZmNvdW50IGZyb20gaHdwb2lzb24gdG8gdHVybiBp
bnRvDQo+ID4gKwkJCSAqIGEgZnJlZSBodWdlcGFnZS4NCj4gPiArCQkJICovDQo+ID4gKwkJCWlm
IChwYWdlX2NvdW50KHBhZ2UpID09IDEpDQo+ID4gKwkJCQlwdXRfcGFnZShwYWdlKTsNCj4gPiAr
CQkJcGFnZSA9IGh1Z2V0bGJfcGFnZV9od3BvaXNvbihwYWdlKTsNCj4gPiArCQl9DQo+ID4gKw0K
PiANCj4gVGhpcyBwYXRjaCBsb29rcyBnb29kIHRvIG1lLiBUaGFua3MhDQo+IA0KPiBPbmUgcXVl
c3Rpb246IENhbiB0aGlzIGh1Z2VwYWdlIGJlIHB1dCBpbnRvIGJ1ZGR5IHN5c3RlbT8gSW4gZnJl
ZV9odWdlX3BhZ2UsDQo+IGlmIGgtPnN1cnBsdXNfaHVnZV9wYWdlc19ub2RlW25pZF0gPiAwLCBo
dWdlcGFnZSBtaWdodCBiZSBwdXQgaW50byBidWRkeSB2aWENCj4gdXBkYXRlX2FuZF9mcmVlX3Bh
Z2UuIFNvIGl0J3Mgbm90IFBhZ2VIdWdlIGFueW1vcmUgYW5kIHdvbid0IGJlIGRpc3NvbHZlZC4g
SWYNCj4gdGhpcyBoYXBwZW5zLCB0aGUgInJhdyBlcnJvciBwYWdlIiBpcyBzdGlsbCBtaXNzZWQg
YW5kIG1pZ2h0IGJlIGFjY2Vzc2VkIGxhdGVyLg0KDQpZZXMsIHRoaXMgcHV0X3BhZ2UoKSBjb3Vs
ZCBmcmVlIHBhZ2VzIGRpcmVjdGx5IGludG8gYnVkZHkuICBJbiBzdWNoIGNhc2UsIEkNCmV4cGVj
dCBfX3VwZGF0ZV9hbmRfZnJlZV9wYWdlKCkgdG8gbW92ZSB0aGUgUGFnZUhXcG9pc29uIGZsYWcg
dG8gdGhlIHJhdyBlcnJvcg0KcGFnZSwgc28gSSB0aGluayB0aGUgZmluYWwgcmVzdWx0IHNob3Vs
ZCBiZSB0aGUgc2FtZS4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
