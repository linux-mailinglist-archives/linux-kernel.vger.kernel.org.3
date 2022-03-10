Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBF24D3DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbiCJACP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiCJACN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:02:13 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2066.outbound.protection.outlook.com [40.107.114.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C35A121532
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:01:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7FwaYDNTYWqgYhZmEf+z/rsDUjSXbiBdGDbufyDLRz4p3n1VW35ymJsPKXx0jTe97uC5K4aK4exDvt8bMG104xHFfeecYJkpSjDsqTwG2LwDch6kJ+C7OYH+zZnbYz+gyBriYkmY/w6AS0w55mS2WSHb7GcXjz0JCKpTW1wfKPHQ5jGhFa/GoIAGNOz45XKi4h4gl8Cqn6wo8E8488RcD2dnfgn8sOJTbc0apnbh9njhOVnoV+KdElePhqt5udd/0HvJixf0GrBrwDuaDRAALeN3dQz38U0oFTprSlb64BGuVEOkPJbEeDA6UL6RAZjz20i0OdsCC96ZKeSsiTIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=he4BZaU9Ku18DrRdNTgXDjzCEMJbAMO2Trya0ZJdXNs=;
 b=BUP9bxBA6Nrxfu9LTN2/WTM4DsCXs3ZlgkKlbCIDFiObwPtlJ1Nf+oSWVHccI1MB1mWBlyRnCyqbFAXxP1jzBPFXr5tWUBtytxSDSaTVqLz+dUuEU60cbX7kBFyKi6wD/uMvtGQA6n0cKXfGwL2Y+TzW7VRgBHT8f2cVdShDu2HZ1+LQaLkTnhh4OulFia2mNr3JBUKaNmGmjrSsAl/kq+CUK6w7dbPeXP6ol6hLblgUhUJntAXpmVt5ecIl385+q4Sx+2zlGzSB+HAQNhBMxBI2ysL7gnHjZsD5awrWeiS91tCpuXyBSHSATyL3wbs2WYAv0QXqHKzptNWEeen6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=he4BZaU9Ku18DrRdNTgXDjzCEMJbAMO2Trya0ZJdXNs=;
 b=AXKQuoXJA8nKF6/p/1ljiNfBPnIThprNwuR1G9jO+XtaxFKzbt1LMxYQHJSxLj8jYo8Ggs0pNnrNrDIWWpt5jy1kV+KsyI7y5mtbYX33yRA7rxRStCfwGTJnadju9cuYMdcwjOfiNwUN15t95+nDmRuZM3nUmMiqpd/WLoEwfx4=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY2PR01MB3131.jpnprd01.prod.outlook.com (2603:1096:404:70::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.18; Thu, 10 Mar
 2022 00:00:25 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d%9]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 00:00:25 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
Thread-Topic: [PATCH v1] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
Thread-Index: AQHYM5Y14jmZP4bIvUm8lwYXZPPhCKy3mZwAgAAi5gA=
Date:   Thu, 10 Mar 2022 00:00:25 +0000
Message-ID: <20220310000024.GA1577304@hori.linux.bs1.fc.nec.co.jp>
References: <20220309091449.2753904-1-naoya.horiguchi@linux.dev>
 <CAHbLzkrmHS+nPbw1YZj-rE-ECgRr2nD40d-ZbxPvf05o-rmNcA@mail.gmail.com>
In-Reply-To: <CAHbLzkrmHS+nPbw1YZj-rE-ECgRr2nD40d-ZbxPvf05o-rmNcA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3cecf9b-e1a1-4933-9193-08da0228fae9
x-ms-traffictypediagnostic: TY2PR01MB3131:EE_
x-microsoft-antispam-prvs: <TY2PR01MB3131E9D80F590FCC43410D9BE70B9@TY2PR01MB3131.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /fGdEiHgbcOOyoOIPgiBgVrGB6fUrjeZVrN0ZPP2TBOFrPxBlS2At8SiTtq0Jit1vwoyY+o84APgFdZWVTJI3Cjir1s8Sgeo6wEvz4685mEnU3GQeFNe1NdNgLc/A3JW33q6rpsVq1GZLYGrbXUc3GHaylqEgQ/hJcYf92DX0ocFD/hiJ0AYU9X3HWkcLrDNB81IHZ11W/7sNzIDhGjtLPqAkukJ88VlV39/ji0vfAfnLH93c8e+O46YhkrvomG4cfDSF0jyBekV7wvOAdXacRVvOIiMCQznBBH9soVk79Ep8IOhdS4M7QUKa2glbUcaOdj7Emcw4NWTmjLO/0nfDC4rKKuzA0P+ziNXBtSAnysiJ/Z7MHxDDXx2EOLAeUz5JBc5SOSqB3aYB8IDKUuUbWZrKx4NPSqzML9xq0Zs04LTN9NIQWrjeF1RK9onQHSSWdk5Gb6z5XImwXmsxcw2VQwYlEcos5z7qoj9PRmuW7VUALuXAuf1neG/HbVLvZNWVq48B4t9p/GWV7JD9VpVHB03ITqzdmo1Z7kUDrJ595TDHxMZOCtYpxR9O/L7O4B6vNidPeT1Qsq8UtJ01pGGKg/Rk6daF9seJFUl6acy0rlrgSLd+ltCgJXszwX+8H4y3evo1J7yGppnpn1Q4XtlC6t6OOfgQZP2a+cn3Sti3MQV/5ES1H2g1IX8nIs6A65F+c8gBf2TnWxJ/7lGe/v91M4bzujpYEGincZQ52tTdvJzlIkSYRXjOEr6OwnRN6DLKK3Vi3wovoN93/4DhTc5Q2/cSozicflBI5CltNKiYoc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(66946007)(6486002)(66446008)(2906002)(8676002)(4326008)(66476007)(64756008)(66556008)(76116006)(71200400001)(6506007)(26005)(186003)(53546011)(8936002)(6512007)(9686003)(1076003)(83380400001)(85182001)(55236004)(33656002)(86362001)(6916009)(966005)(316002)(122000001)(38070700005)(54906003)(38100700002)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXB4MWp6SS8zWXFwWW5lb3NTTTd4d0JlQXAySE9kMXQ4dVE0OHVXT2N0TG9Q?=
 =?utf-8?B?SHVSeVA4dTM1a2V1dnoySFYyUjdLQm5PNFllY3JYNmlSUWlVZ3BHeVpHSCtn?=
 =?utf-8?B?UXZyWS80Mk1oZ0tTQnVsR2llNDBaMmkvbHpJSUlqQ090bXg4Nm02Q1lyajVw?=
 =?utf-8?B?Ky9Peng2Zk8vNWlBa1htOWhkR0k2NklnL0k4SWcyQU9SRVBXV0dpUVFjZFBE?=
 =?utf-8?B?RUJvOW12ZWNKYlJQSFhyVHdyVHZKbTV0a2lwRllCek5QeEg3VTlJekM3d3dX?=
 =?utf-8?B?cUlYZlJxdzhpaFhWNGltcDdwTGNzV2dKWmI0M2NXSzBESXhjaDhZM3lZeEJq?=
 =?utf-8?B?UCt2RXhMRlNXQngzUHNMQ2REUjJMemE5ckw0T2dkd3dtaWV6SlMwMkNuUWh6?=
 =?utf-8?B?V05xRmJDWGtEVVJjdXRBYjExOFRqcXJTbG44ekJjM3ZXTFdRSlloUnAyVEYv?=
 =?utf-8?B?bVR5S2c5c21sNTg5a2tMeWpMR2twc3VYcnpMT0tVMFMvQUhlVXgrRmRiNmov?=
 =?utf-8?B?QUlLNGVCUHR0aFczTHBYL3I5WEtCWVVEYVJ0R1d2YUM1Z25la2ptYWpIdCth?=
 =?utf-8?B?ZTgzQkllWDY1V28vRUo0L0NOU3pxQnF5Wm9LbU4zYytuY0NQY254L0RZc1lr?=
 =?utf-8?B?aFRxcko1YTlJQUE2UmYvMVlmTUk1bngvMXhJTVlUQjAwTXVjYWlVTGxtOGNv?=
 =?utf-8?B?Q2xrbWR5WDMweldCaXNycTUwTlIyUVF5bFh5ajFrSC9uNGdpdGlUeUhsQ24w?=
 =?utf-8?B?R09MdWVRRlEzZlRhRCtuaFBCM3doY0trQ0tySldjOUEzY0x4ZjRvbXcvc3Ft?=
 =?utf-8?B?cnd2aURIL2tha2xKeWdRaG5WNWVleisreGpDL0J6YzAwQi94dWxUN3dwMFZj?=
 =?utf-8?B?b21CVHdnMEN1VllMWk1EZ0pXTEJPSVJIWjlOTWxvM0toQm5XV2lEZElPajA4?=
 =?utf-8?B?Y2lXSVlTbFpuR0JBdEtyT3creTJVVXZWSVZBbWdKK1lDdmJ1Nm1BcTQ5S2hR?=
 =?utf-8?B?L3BUd0crZnduVHNMM0xIeG9ycjYxeGpOU1ZWYU9PMmhPZjZoNzlzVWtYUG5n?=
 =?utf-8?B?WkNsbGlyY0F3RGl2b3BvbDJ1TGNuQ3FIT0dsbnEwamYxd21NZXJDTmYrdGZV?=
 =?utf-8?B?bDRSSk1xeXB3RnNDZjI0a0wxaW9wOW1VcE5mS3B6d05ibTJzNlpxSzFuNUpk?=
 =?utf-8?B?VnlYL010SGxGaWtRQnYzbUxsNThiaUMvOGE4N1B2Rk5KT3FlcHVKZWtPeGw3?=
 =?utf-8?B?dDJjZ0ZoVG4ycDBIRGRiMk1IcFV3YWtadDZTQ1NiTUlvS0FvRW5jU2NCc1Rr?=
 =?utf-8?B?MVY3ZHJlRTQ5VmgyTnQ3VTVVTzRheUwwSGhjK1NUdDVPRjRRWFdkekoyelBQ?=
 =?utf-8?B?TzBZUFVYdlZrampmNWNXRWlXbGNKNXhlUk8xd28xbEhHamJMSUVYSGRGYWh3?=
 =?utf-8?B?RWNPZWIwYXR6OVlFUzhaN0hLbkVDbTUvU3hMMjYwN0VJK1hxSXB1bjVlZGdN?=
 =?utf-8?B?d0xoNEltV1BnVWMzYUJLVFU3RVpMRmxFK2l2elFiZkp4a0I4L1VyQ0hYYU1P?=
 =?utf-8?B?d1JxSzlqeGM3YlYwa2lQVFhWRVBTSURpZXlmaHRudDVMMUFCcTN2RTNpRGlT?=
 =?utf-8?B?RjJ0VC82L2hQbVJYSnFOVnh5YVR1Wi90MjhoWk9RUDFQbHhIWkx4L0E3Szh0?=
 =?utf-8?B?RXQ2WTdzUzh6OU9HK3c3Skt1d2RLSXVpSkdLdVNraGNCWTcwQVg2dWlWOGxN?=
 =?utf-8?B?VFArZW8vV1hVcjVpMXlBWWJFcGcyNDBVdldzMC80SXQxRk4yWGF6ZzhTbWo5?=
 =?utf-8?B?bU9tQ3hQdnQ0VDZNRWpoOHhKVGJnSGlWVmNWcGlPT3NKK3luakRZanVCdDZw?=
 =?utf-8?B?UTlNZ1JZeURaMk1ucERUTy80ZlFOdHlxNVdQcnZodk5YQll2SEdJMDNVMzhj?=
 =?utf-8?B?VmRtajFvdndYck4zalBybitZQ21TUEFHL2NGd2hHaGZNVzRicGdxNUppbjhH?=
 =?utf-8?B?S0VlUVlxVzYrOUs4dVVLUmdZQUVtOEwzbHVOTzVNeS8zZjBaTmorTE8vMldv?=
 =?utf-8?B?K05sRjBKU2dHc3NaR3hpSlI0bk5VWkN0R1hhNkU5alk0bzcxVlNabVVIdzJZ?=
 =?utf-8?B?SVk1VVB1Q05KNXd3TEhQbkpSM3ZRNHN0RTBzalhka2lYMHlzT2RCYlFCSU5I?=
 =?utf-8?Q?swuik+fYIqeDJoAnqgnkMtxPqWj+qOltw7ZH8sYL3mdq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C65BC5A1B8EA7A41A36DFD65AB998630@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cecf9b-e1a1-4933-9193-08da0228fae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 00:00:25.6811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mln4sX7kmq8/XNWE0V6dxkRnoYSAW63crPCstx8O68ea4hvIA2RMkY1MLxz+UNlQHrYBwq1lbfnRW8t4t2UlYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXIgMDksIDIwMjIgYXQgMDE6NTU6MzBQTSAtMDgwMCwgWWFuZyBTaGkgd3JvdGU6
DQo+IE9uIFdlZCwgTWFyIDksIDIwMjIgYXQgMToxNSBBTSBOYW95YSBIb3JpZ3VjaGkNCj4gPG5h
b3lhLmhvcmlndWNoaUBsaW51eC5kZXY+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogTmFveWEgSG9y
aWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPg0KPiA+IFRoZXJlIGlzIGEgcmFj
ZSBjb25kaXRpb24gYmV0d2VlbiBtZW1vcnlfZmFpbHVyZV9odWdldGxiKCkgYW5kIGh1Z2V0bGIN
Cj4gPiBmcmVlL2RlbW90aW9uLCB3aGljaCBjYXVzZXMgc2V0dGluZyBQYWdlSFdQb2lzb24gZmxh
ZyBvbiB0aGUgd3JvbmcgcGFnZQ0KPiA+ICh3aGljaCB3YXMgYSBodWdldGxiIHdoZW4gbWVtb3J5
X2ZhaWxydWUoKSB3YXMgY2FsbGVkLCBidXQgd2FzIHJlbW92ZWQNCj4gPiBvciBkZW1vdGVkIHdo
ZW4gbWVtb3J5X2ZhaWx1cmVfaHVnZXRsYigpIGlzIGNhbGxlZCkuICBUaGlzIHJlc3VsdHMgaW4N
Cj4gPiBraWxsaW5nIHdyb25nIHByb2Nlc3Nlcy4gIFNvIHNldCBQYWdlSFdQb2lzb24gZmxhZyB3
aXRoIGhvbGRpbmcgcGFnZSBsb2NrLA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmFveWEgSG9y
aWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiAtLS0NCj4gPiAgbW0vbWVtb3J5
LWZhaWx1cmUuYyB8IDI3ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gPiBp
bmRleCBhYzY0OTJlMzY5NzguLmZlMjVlZWU4ZjlkNiAxMDA2NDQNCj4gPiAtLS0gYS9tbS9tZW1v
cnktZmFpbHVyZS5jDQo+ID4gKysrIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+IEBAIC0xNDk0
LDI0ICsxNDk0LDExIEBAIHN0YXRpYyBpbnQgbWVtb3J5X2ZhaWx1cmVfaHVnZXRsYih1bnNpZ25l
ZCBsb25nIHBmbiwgaW50IGZsYWdzKQ0KPiA+ICAgICAgICAgaW50IHJlczsNCj4gPiAgICAgICAg
IHVuc2lnbmVkIGxvbmcgcGFnZV9mbGFnczsNCj4gPg0KPiA+IC0gICAgICAgaWYgKFRlc3RTZXRQ
YWdlSFdQb2lzb24oaGVhZCkpIHsNCj4gPiAtICAgICAgICAgICAgICAgcHJfZXJyKCJNZW1vcnkg
ZmFpbHVyZTogJSNseDogYWxyZWFkeSBoYXJkd2FyZSBwb2lzb25lZFxuIiwNCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgIHBmbik7DQo+ID4gLSAgICAgICAgICAgICAgIHJlcyA9IC1FSFdQT0lT
T047DQo+ID4gLSAgICAgICAgICAgICAgIGlmIChmbGFncyAmIE1GX0FDVElPTl9SRVFVSVJFRCkN
Cj4gPiAtICAgICAgICAgICAgICAgICAgICAgICByZXMgPSBraWxsX2FjY2Vzc2luZ19wcm9jZXNz
KGN1cnJlbnQsIHBhZ2VfdG9fcGZuKGhlYWQpLCBmbGFncyk7DQo+ID4gLSAgICAgICAgICAgICAg
IHJldHVybiByZXM7DQo+ID4gLSAgICAgICB9DQo+ID4gLQ0KPiA+IC0gICAgICAgbnVtX3BvaXNv
bmVkX3BhZ2VzX2luYygpOw0KPiA+IC0NCj4gPiAgICAgICAgIGlmICghKGZsYWdzICYgTUZfQ09V
TlRfSU5DUkVBU0VEKSkgew0KPiA+ICAgICAgICAgICAgICAgICByZXMgPSBnZXRfaHdwb2lzb25f
cGFnZShwLCBmbGFncyk7DQo+IA0KPiBJJ20gbm90IGFuIGV4cGVydCBvZiBodWdldGxiLCBJIG1h
eSBiZSB3cm9uZy4gSSdtIHdvbmRlcmluZyBob3cgdGhpcw0KPiBjb3VsZCBzb2x2ZSB0aGUgcmFj
ZT8gSXMgdGhlIGJlbG93IHJhY2Ugc3RpbGwgcG9zc2libGU/DQo+IA0KPiBfX2dldF9od3BvaXNv
bl9wYWdlKCkNCj4gICBoZWFkID0gY29tcG91bmRfaGVhZChwYWdlKQ0KPiANCj4gaHVnZXRsYiBk
ZW1vdGlvbiAoMUcgLS0+IDJNKQ0KPiAgIGdldF9od3BvaXNvbl9odWdlX3BhZ2UoaGVhZCwgJmh1
Z2V0bGIpOw0KDQpUaGFua3MgZm9yIHRoZSBjb21tZW50Lg0KSSBhc3N1bWUgTWlhb2hlJ3MgcGF0
Y2ggYmVsb3cgaW50cm9kdWNlcyBhZGRpdGlvbmFsIGNoZWNrIHRvIGRldGVjdCB0aGUNCnJhY2Uu
ICBUaGUgcGF0Y2ggY2FsbHMgY29tcG91bmRfaGVhZCgpIGZvciB0aGUgcmF3IGVycm9yIHBhZ2Ug
YWdhaW4sIHNvDQp0aGUgZGVtb3Rpb24gY2FzZSBzaG91bGQgYmUgZGV0ZWN0ZWQuICBJJ2xsIG1h
a2UgdGhlIGRlcGVuZGVuY3kgY2xlYXIgaW4NCnRoZSBjb21taXQgbG9nLg0KDQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1tbS8yMDIyMDIyODE0MDI0NS4yNDU1Mi0yLWxpbm1pYW9oZUBo
dWF3ZWkuY29tLw0KDQo+IA0KPiANCj4gVGhlbiB0aGUgaGVhZCBtYXkgcG9pbnQgdG8gYSAyTSBw
YWdlLCBidXQgdGhlIGh3cG9pc29uZWQgc3VicGFnZSBpcw0KPiBub3QgaW4gdGhhdCAyTSByYW5n
ZT8NCj4gDQo+IA0KPiA+ICAgICAgICAgICAgICAgICBpZiAoIXJlcykgew0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGxvY2tfcGFnZShoZWFkKTsNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICBpZiAoaHdwb2lzb25fZmlsdGVyKHApKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBpZiAoVGVzdENsZWFyUGFnZUhXUG9pc29uKGhlYWQpKQ0KPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBudW1fcG9pc29uZWRfcGFnZXNfZGVjKCk7
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bmxvY2tfcGFnZShoZWFkKTsN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gQEAgLTE1NDQsMTMgKzE1MzEsMTYg
QEAgc3RhdGljIGludCBtZW1vcnlfZmFpbHVyZV9odWdldGxiKHVuc2lnbmVkIGxvbmcgcGZuLCBp
bnQgZmxhZ3MpDQo+ID4gICAgICAgICBwYWdlX2ZsYWdzID0gaGVhZC0+ZmxhZ3M7DQo+ID4NCj4g
PiAgICAgICAgIGlmIChod3BvaXNvbl9maWx0ZXIocCkpIHsNCj4gPiAtICAgICAgICAgICAgICAg
aWYgKFRlc3RDbGVhclBhZ2VIV1BvaXNvbihoZWFkKSkNCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICBudW1fcG9pc29uZWRfcGFnZXNfZGVjKCk7DQo+ID4gICAgICAgICAgICAgICAgIHB1dF9w
YWdlKHApOw0KPiA+ICAgICAgICAgICAgICAgICByZXMgPSAtRU9QTk9UU1VQUDsNCj4gPiAgICAg
ICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiArICAgICAgIGlm
IChUZXN0U2V0UGFnZUhXUG9pc29uKGhlYWQpKQ0KPiANCj4gQW5kIEkgZG9uJ3QgdGhpbmsgImhl
YWQiIGlzIHN0aWxsIHRoZSBoZWFkIHlvdSBleHBlY3RlZCBpZiB0aGUgcmFjZQ0KPiBoYXBwZW5l
ZC4gSSB0aGluayB3ZSBuZWVkIHRvIHJlLXJldHJpZXZlIHRoZSBoZWFkIG9uY2UgdGhlIHBhZ2UN
Cj4gcmVmY291bnQgaXMgYnVtcGVkIGFuZCBsb2NrZWQuDQoNCkkgdGhpbmsgdGhlIGFib3ZlIGp1
c3RpZmljYXRpb24gd29ya3MgZm9yIHRoaXMuDQpXaGVuIHRoZSBrZXJuZWwgcmVhY2hlcyB0aGlz
IGxpbmUsIHRoZSBodWdlcGFnZSBpcyBwcm9wZXJseSBwaW5uZWQgd2l0aG91dCBiZWluZw0KZnJl
ZWQgb3IgZGVtb3RlZCwgc28gImhlYWQiIGlzIHN0aWxsIHBvaW50aW5nIHRvIHRoZSBzYW1lIGhl
YWQgcGFnZSBhcyBleHBlY3RlZC4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hpDQoNCj4gDQo+
ID4gKyAgICAgICAgICAgICAgIGdvdG8gYWxyZWFkeV9od3BvaXNvbmVkOw0KPiA+ICsNCj4gPiAr
ICAgICAgIG51bV9wb2lzb25lZF9wYWdlc19pbmMoKTsNCj4gPiArDQo+ID4gICAgICAgICAvKg0K
PiA+ICAgICAgICAgICogVE9ETzogaHdwb2lzb24gZm9yIHB1ZC1zaXplZCBodWdldGxiIGRvZXNu
J3Qgd29yayByaWdodCBub3csIHNvDQo+ID4gICAgICAgICAgKiBzaW1wbHkgZGlzYWJsZSBpdC4g
SW4gb3JkZXIgdG8gbWFrZSBpdCB3b3JrIHByb3Blcmx5LCB3ZSBuZWVkDQo+ID4gQEAgLTE1NzYs
NiArMTU2NiwxMyBAQCBzdGF0aWMgaW50IG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGIodW5zaWduZWQg
bG9uZyBwZm4sIGludCBmbGFncykNCj4gPiAgb3V0Og0KPiA+ICAgICAgICAgdW5sb2NrX3BhZ2Uo
aGVhZCk7DQo+ID4gICAgICAgICByZXR1cm4gcmVzOw0KPiA+ICthbHJlYWR5X2h3cG9pc29uZWQ6
DQo+ID4gKyAgICAgICB1bmxvY2tfcGFnZShoZWFkKTsNCj4gPiArICAgICAgIHByX2VycigiTWVt
b3J5IGZhaWx1cmU6ICUjbHg6IGFscmVhZHkgaGFyZHdhcmUgcG9pc29uZWRcbiIsIHBmbik7DQo+
ID4gKyAgICAgICByZXMgPSAtRUhXUE9JU09OOw0KPiA+ICsgICAgICAgaWYgKGZsYWdzICYgTUZf
QUNUSU9OX1JFUVVJUkVEKQ0KPiA+ICsgICAgICAgICAgICAgICByZXMgPSBraWxsX2FjY2Vzc2lu
Z19wcm9jZXNzKGN1cnJlbnQsIHBhZ2VfdG9fcGZuKGhlYWQpLCBmbGFncyk7DQo+ID4gKyAgICAg
ICByZXR1cm4gcmVzOw0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGludCBtZW1vcnlfZmFpbHVy
ZV9kZXZfcGFnZW1hcCh1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzLA0KPiA+IC0tDQo+ID4g
Mi4yNS4xDQo+ID4=
