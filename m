Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D9D55D914
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiF0HYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiF0HYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:24:52 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2085.outbound.protection.outlook.com [40.107.113.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6BD302
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQMNeHqnsM6fKo34zfqc+UTP4OAgHGwsQdmUF8X53lB2b3qlY4hsvwzJ6tSev7jnbCnWImW+5cyOaHKr73LtcLX0/zryfQG6AZ8z7O+GwZg/VyHKrYXlilF2pBPh9/MBTspLzamRpPFhHHpSBE2xkkpKqL/8LwrNK/R6jujMayhNk3XkomD7nJPLgNUNUfpBVkBfIXFJGin9+nVx4gG1AF6EeSuxTd4eWcxCjtlyvsB1e/DjN2l94zXBjh4aeN+m3k8iqgVhQhGtBLhgKy5RjaqhSTAvFFS4+fNsM10ble/KQ+6oQn3pcFwGB3zmjjVWLcudwTzww2Af5zuQaUh/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQz7F3eupufvjjHWuuYjO1xomumZvc5cWquppCQVKec=;
 b=QcMoTQWSjnyhtJOsYutnsTFaotJO3NbhDn3HVWHZhx3TSyNPckzF4F+QT+edTJ5ttoThpRIyXXv9PQfXBQHcMTISILa33XJUj6ii0OhYdDdvANqDDxsLAEHia2cndmr7jXjOBn4TylhvbPnBKla/ruSod6qTahmHsOT728ytY7tF+OCaOunl9pfjI1Fw9oXDLWJe/a9PedSqf8+bUvFTwfEsKb/lGZPHRF+VSxO9M4KWcEFW6ki1Pl3Y5Ny+vCZCPdtCPF9jwPb8WF2sA9D6ofHTI4fUq7IRfmxxqPuFWr2ZA8Pf4nhJXxC+e2/49wT6BDx3KL+kU9EDgjc97oGSSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQz7F3eupufvjjHWuuYjO1xomumZvc5cWquppCQVKec=;
 b=Y4tbLcMyU34R66KxET4CXvytfr18ykHRfepPxLl2X++t72fB9pvd71Au5gpHFdGuJL8gTR39s3VJEc6DcBzYQc4ahHGJXxcd5XuARzuWUvGiB4Zxh1LrYa1mp6juqOrlBDmfNcB4QSV1uERptSN+tGITv/RJ+ZyrjG4Zt4dLQkM=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB7411.jpnprd01.prod.outlook.com (2603:1096:400:f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 07:24:49 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 07:24:49 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 3/9] mm/hugetlb: make pud_huge() and huge_pud() aware
 of non-present pud entry
Thread-Topic: [PATCH v2 3/9] mm/hugetlb: make pud_huge() and huge_pud() aware
 of non-present pud entry
Thread-Index: AQHYh1xVdMLvq+UuwkSi6Bx3h6yk0q1f4P6AgAL+QAA=
Date:   Mon, 27 Jun 2022 07:24:49 +0000
Message-ID: <20220627072448.GE2159330@hori.linux.bs1.fc.nec.co.jp>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-4-naoya.horiguchi@linux.dev>
 <098b5a5c-2c05-4e22-b1ba-81f858391cd6@huawei.com>
In-Reply-To: <098b5a5c-2c05-4e22-b1ba-81f858391cd6@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbc3c5da-c235-4810-fecd-08da580e1eb4
x-ms-traffictypediagnostic: TYCPR01MB7411:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2KN2YO/fdLIOG1m3tvA4e0KGnrhwTGj+7gdJXyUDkTneDaYr9Mz90FIOYoK6t5vd8rB1mPui8Jwx9MfSriArPEWsRt9gnGYT0a5iTyi5tOmOqAFBOzMqnJQZcjVFId610jijdnZFWieC4/ZAahgBhGKdsJDZK/NkT08OzwXN9EA6Gr3/c1R3TvDxXsxBNdWSe3uhOYsNIDplM4OAvhn8xkEBuX5YAdFkUpR530CDVsn0Kr8eGOLJpiYjWSHzEVVmB/j3z19RVzCOrCTvWhAfFUjC/Pk/Xe7sEnNU4IXhO144DWoP9gXXhGcE1pWP2R1IKPXyLpBYrjFN7nxL3PCxJjPKD2SJ8/JDv4hSvbxDckyBM0smeaAqSebwe69bXJlgV+f9DAKZMG25HjmHr26eCoD+nb47rnlu7RCH5Wife7aCK7+DFgARSL2UFIs+wCnGT7z7zhgU1PMHGOoVdX5gm/uTNBILelweahJIQi+5BiCXo9i2mlJd0dU/q27T1rPyZD3AMRaujpaAJNZq96HOq81w2+dq6pZpFOKZamtbyP5NDoQ9ULDDJxlynuSRNnLT+Cjlp94VCRN/fG/hpdtOqfaO1bUBTEw60fCTPj2oI98wMA1eJ1V6oEJuU0r2Cl3Fhc6P9fZmNbqdXgkEsMCMzSp95GT7pdrqEeHgfZDeeuEtnOT/4Ug3ZvGVfdbMnSAyVyRRt/Nm+chfsgXR5m3P50MaatOoMmI5xv8SkDeEVnDdKtV7k36bHVEayH60x418PEQmrGi6apLpuV0d7m7Dckk0ars+3PcTFUGQ/zj0iV1zAqlEM5Yjvob4NGEG++Aa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(54906003)(71200400001)(6512007)(41300700001)(1076003)(26005)(6916009)(9686003)(186003)(85182001)(6486002)(478600001)(66476007)(316002)(2906002)(5660300002)(6506007)(8936002)(83380400001)(55236004)(7416002)(53546011)(33656002)(66946007)(82960400001)(66446008)(38100700002)(76116006)(122000001)(4326008)(38070700005)(64756008)(86362001)(66556008)(8676002)(14583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1NzZU1YZnRFUW54UmhySUMwNEViR29LVTE0STkxcnFWaHFBNVRLendlVHMw?=
 =?utf-8?B?WGVMc1lVbFI3RCtiOWlhZlRBMFZwMk5YT20yMzNBUCtOUzhYdjd5K2V6M04r?=
 =?utf-8?B?dlBqd3VsdHVZelpUVlF0WEloUGRESlNwUDJuNnJqSUhObkUxWnVnQ3NrUzkz?=
 =?utf-8?B?Rnl6ck0ybitaWi9MTlU0c3BORU1PelJVbyt1UWRobXAzQzhNNHZ2M082NzQz?=
 =?utf-8?B?bFJDN1NVTnJXVXpaNUdXWFM0ZEtSbGZtWnhiUWtSQUZmVHkzcUZHUEd2L1dL?=
 =?utf-8?B?V2Y5Vk1KVVFoOGlOMWp6SzN2cUEwZWloenNXTk93YnpYRVZWWmVLNVkwOWhO?=
 =?utf-8?B?cVhoS1YvY0U5YjYvWThIcE1DL1pUQ1p2T0FRS09hbWt5TWhwV0V5Q2JRSU1N?=
 =?utf-8?B?Vms0TXlLV1cvdS8waDRETk42S0tZaWlTeEJ4R3VVQjl4RlMzSTkwbmRoYjBB?=
 =?utf-8?B?Q3dFNFRzUXVzcVhYeHhlbm9jdlR5aTZ3L2Y4YzI5RGN5dkMxVitWQllIeThz?=
 =?utf-8?B?OTZIUW9saE1Fdzg4c0JNU2V1a1hlNThPQy8ycFZyWm83L0NPcTd6QzBpOXlH?=
 =?utf-8?B?T1FxL3pqeVhTeGw1dmpzckhXTVBRMVU5NHBWVWN3dVJ4UG5uZlZYZ2tldENP?=
 =?utf-8?B?bG1GRTgzK0FEV3dSUjN3K1hmY0MzZ0xaQkdwN1VoTm9xRUxRV1BuaFB1RUts?=
 =?utf-8?B?Rk9GNkdKMUl3SWNNSGc2YzhpbCtKZGdEMGVubzZOaUtyaFR4YkEyY1Y0Q3RR?=
 =?utf-8?B?QVBUdHdadWRXY0tZSURXSTVWT284QzNQb1JYUC9kOFY4QkJEYmg1QXd6MnB1?=
 =?utf-8?B?aUtyYWorVGRIQkw4OTdsQ0VGbVRSNG5lUnhSMm9YNlNyckJiWGJVSnNQWkMw?=
 =?utf-8?B?QytySjdqVVhqckMvdlZYbFJNdTkxTmdsTHRHdG1Pcmc4OVJxZDY2cDliRDBr?=
 =?utf-8?B?UW1seldyOUhuUGgyT3VLZmc1Z2pYa3FtRmlzM0dCMkFoZnZGbXpsR1RvaHdF?=
 =?utf-8?B?TG1pTXJpajIxejVUamdHUW1BQmtsbzJqQ0t6bVpkcWRQVXRXYXhzS1pUejZ5?=
 =?utf-8?B?czhGRzh5clZLZ1NjbzBiRDBBVng1ZXlrY2Z5aXNtejNYUHJVR2lxUUdTei9V?=
 =?utf-8?B?Z2U3bFJZUlBvT0crcnNaa0poa0pvYXF6MUtBb1RlY1R0NmlrRlZjSTBhMHBh?=
 =?utf-8?B?bkxQc21FTjBuNG9TSjN4U0phVjlCeWRRS0JtSGFlWU1SQ3NDTEtCWmorenhh?=
 =?utf-8?B?TDdIdHpnVWFHZWk1UzdaVGY3ZE9RVUZwbWU5YUVZRHJpNWpDS3ByaG5wZkRJ?=
 =?utf-8?B?c0p2dFU1YXg0aFFrcHhudVJtcXFTTVJRYllUTTZ1ampBajNJMHlZTzE5K29W?=
 =?utf-8?B?WitEVElQc1oxb3VHTVNrWWJIZ2tCSEVkTjE3VHlJMFl5ZUpRVVc2Yzh4U2hF?=
 =?utf-8?B?Tk82SlZrK3kyT1EwMXQ4VzExNnI4RHJ6RVQwWGNxUFBEZVRrVnhmenBkOVkv?=
 =?utf-8?B?anhZMWpsNzFreVRQbkM2RFNXaExsL3EwQjVheDFtRGFyS1dwMjRCU1BIL2hJ?=
 =?utf-8?B?U3JxaXpHVFBpY05MQTdZdlF5MkZFRmFHMTRUSzJ5OGdHTVhndlpBbldPaloy?=
 =?utf-8?B?a2ZRdTFGbnN1OUhJbFY3c3dMQXJtcWJKNCsxZUdXVnllTTdTV0ZVOHpTeE9s?=
 =?utf-8?B?TVBvQnp1OHVZR2I2a0tkZGU4cklBazNaU1NQYlcrekhHMmgyandrY1Z6RFNy?=
 =?utf-8?B?dlIwb1puOW84M1dTQUZ4RUZWVG5tem8yWThOTngvSXFUZTY4NGZOSDdIMnJI?=
 =?utf-8?B?Nk5CZndOc0FmYVRZTDJzLzNsZ1hSM0l1WUVxeWpWREF3Y2NDdVB3RCtnYURN?=
 =?utf-8?B?MnE1bmF4ZEltWmhNQWk3d3kzcHpjMmJoUGVOWGd1Q2NoOTJWenZiOUp3Uk92?=
 =?utf-8?B?VFFVZkxNazhhd1NkWnJuRnVzN3l0ckNnODg3UXV5cGhOMUV0RzVoMUd3TGxq?=
 =?utf-8?B?eDhLRlQ2OWRKNm92Q1ZDYm5qd1BCOVgvaEhRZUhmRHZzbWh1Vldzejg5OCtP?=
 =?utf-8?B?VWRtOTNOT3UyQW5KNE8rT0tvRnd4U3paMlZZbFJ5bU5GaG04WGE1d3ZsV1BS?=
 =?utf-8?B?RUNDckZ2NlNBWWp6SWtkT0p2U2poTGRSbFIyaGFiWkpRN0ExUXcrckFCRnhi?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADFE135F4C09584C88E2F6F8AB3E189B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc3c5da-c235-4810-fecd-08da580e1eb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 07:24:49.4154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpXGkDyOcB9IRMjs4lPj+FRo+bfE7jFZyxDs7Quio0PpO3FpZpRCmxUKx50IcMJP1uVVtvlvGOAxRgyGU0lekA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7411
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBKdW4gMjUsIDIwMjIgYXQgMDU6NDI6MTdQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi82LzI0IDc6NTEsIE5hb3lhIEhvcmlndWNoaSB3cm90ZToNCj4gPiBGcm9t
OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+IA0KPiA+IGZv
bGxvd19wdWRfbWFzaygpIGRvZXMgbm90IHN1cHBvcnQgbm9uLXByZXNlbnQgcHVkIGVudHJ5IG5v
dy4gIEFzIGxvbmcgYXMNCj4gPiBJIHRlc3RlZCBvbiB4ODZfNjQgc2VydmVyLCBmb2xsb3dfcHVk
X21hc2soKSBzdGlsbCBzaW1wbHkgcmV0dXJucw0KPiA+IG5vX3BhZ2VfdGFibGUoKSBmb3Igbm9u
LXByZXNlbnRfcHVkX2VudHJ5KCkgZHVlIHRvIHB1ZF9iYWQoKSwgc28gbm8gc2V2ZXJlDQo+ID4g
dXNlci12aXNpYmxlIGVmZmVjdCBzaG91bGQgaGFwcGVuLiAgQnV0IGdlbmVyYWxseSB3ZSBzaG91
bGQgY2FsbA0KPiA+IGZvbGxvd19odWdlX3B1ZCgpIGZvciBub24tcHJlc2VudCBwdWQgZW50cnkg
Zm9yIDFHQiBodWdldGxiIHBhZ2UuDQo+ID4gDQo+ID4gVXBkYXRlIHB1ZF9odWdlKCkgYW5kIGh1
Z2VfcHVkKCkgdG8gaGFuZGxlIG5vbi1wcmVzZW50IHB1ZCBlbnRyaWVzLiAgVGhlDQo+ID4gY2hh
bmdlcyBhcmUgc2ltaWxhciB0byBwcmV2aW91cyB3b3JrcyBmb3IgcHVkIGVudHJpZXMgY29tbWl0
IGU2NmYxN2ZmNzE3Nw0KPiA+ICgibW0vaHVnZXRsYjogdGFrZSBwYWdlIHRhYmxlIGxvY2sgaW4g
Zm9sbG93X2h1Z2VfcG1kKCkiKSBhbmQgY29tbWl0DQo+ID4gY2JlZjg0NzhiZWU1ICgibW0vaHVn
ZXRsYjogcG1kX2h1Z2UoKSByZXR1cm5zIHRydWUgZm9yIG5vbi1wcmVzZW50IGh1Z2VwYWdlIiku
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3Vj
aGlAbmVjLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC94ODYvbW0vaHVnZXRsYnBhZ2UuYyB8ICAz
ICsrLQ0KPiA+ICBtbS9odWdldGxiLmMgICAgICAgICAgICAgIHwgMjYgKysrKysrKysrKysrKysr
KysrKysrKysrKy0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9odWdldGxicGFn
ZS5jIGIvYXJjaC94ODYvbW0vaHVnZXRsYnBhZ2UuYw0KPiA+IGluZGV4IGEwZDAyM2NiNDI5Mi4u
NWZiODZmYjQ5YmE4IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L21tL2h1Z2V0bGJwYWdlLmMN
Cj4gPiArKysgYi9hcmNoL3g4Ni9tbS9odWdldGxicGFnZS5jDQo+ID4gQEAgLTcwLDcgKzcwLDgg
QEAgaW50IHBtZF9odWdlKHBtZF90IHBtZCkNCj4gPiAgDQo+IA0KPiBObyBzdHJvbmcgb3Bpbmlv
biBidXQgYSBjb21tZW50IHNpbWlsYXIgdG8gcG1kX2h1Z2UgbWlnaHQgYmUgYmV0dGVyPw0KPiAN
Cj4gLyoNCj4gICogcG1kX2h1Z2UoKSByZXR1cm5zIDEgaWYgQHBtZCBpcyBodWdldGxiIHJlbGF0
ZWQgZW50cnksIHRoYXQgaXMgbm9ybWFsDQo+ICAqIGh1Z2V0bGIgZW50cnkgb3Igbm9uLXByZXNl
bnQgKG1pZ3JhdGlvbiBvciBod3BvaXNvbmVkKSBodWdldGxiIGVudHJ5Lg0KPiAgKiBPdGhlcndp
c2UsIHJldHVybnMgMC4NCj4gICovDQoNCk9LLCBJJ2xsIGFkZCBzb21lLg0KDQo+IA0KPiA+ICBp
bnQgcHVkX2h1Z2UocHVkX3QgcHVkKQ0KPiA+ICB7DQo+ID4gLQlyZXR1cm4gISEocHVkX3ZhbChw
dWQpICYgX1BBR0VfUFNFKTsNCj4gPiArCXJldHVybiAhcHVkX25vbmUocHVkKSAmJg0KPiA+ICsJ
CShwdWRfdmFsKHB1ZCkgJiAoX1BBR0VfUFJFU0VOVHxfUEFHRV9QU0UpKSAhPSBfUEFHRV9QUkVT
RU5UOw0KPiA+ICB9DQo+ID4gICNlbmRpZg0KPiA+ICANCj4gPiBkaWZmIC0tZ2l0IGEvbW0vaHVn
ZXRsYi5jIGIvbW0vaHVnZXRsYi5jDQo+ID4gaW5kZXggZjU5ZjQzYzA2NjAxLi5iN2FlNWY3M2Yz
YjIgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vaHVnZXRsYi5jDQo+ID4gKysrIGIvbW0vaHVnZXRsYi5j
DQo+ID4gQEAgLTY5NDYsMTAgKzY5NDYsMzQgQEAgc3RydWN0IHBhZ2UgKiBfX3dlYWsNCj4gPiAg
Zm9sbG93X2h1Z2VfcHVkKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCB1bnNpZ25lZCBsb25nIGFkZHJl
c3MsDQo+ID4gIAkJcHVkX3QgKnB1ZCwgaW50IGZsYWdzKQ0KPiA+ICB7DQo+ID4gKwlzdHJ1Y3Qg
cGFnZSAqcGFnZSA9IE5VTEw7DQo+ID4gKwlzcGlubG9ja190ICpwdGw7DQo+ID4gKwlwdGVfdCBw
dGU7DQo+ID4gKw0KPiA+ICAJaWYgKGZsYWdzICYgKEZPTExfR0VUIHwgRk9MTF9QSU4pKQ0KPiA+
ICAJCXJldHVybiBOVUxMOw0KPiANCj4gU2hvdWxkIHRoZSBhYm92ZSBjaGVjayBiZSBtb2RpZmll
ZD8gSXQgc2VlbXMgdGhlIGJlbG93IHRyeV9ncmFiX3BhZ2UgbWlnaHQgbm90IGdyYWIgdGhlIHBh
Z2UgYXMNCj4gZXhwZWN0ZWQgKGFzIE1pa2UgcG9pbnRlZCBvdXQpLiBPciB0aGUgZXh0cmEgcGFn
ZSByZWZjbnQgaXMgdW5uZWVkZWQ/DQoNClllcywgdGhpcyBjaGVjayBzaG91bGQgYmUgdXBkYXRl
ZC4NCg0KPiANCj4gPiAgDQo+ID4gLQlyZXR1cm4gcHRlX3BhZ2UoKihwdGVfdCAqKXB1ZCkgKyAo
KGFkZHJlc3MgJiB+UFVEX01BU0spID4+IFBBR0VfU0hJRlQpOw0KPiA+ICtyZXRyeToNCj4gPiAr
CXB0bCA9IGh1Z2VfcHRlX2xvY2soaHN0YXRlX3NpemVsb2coUFVEX1NISUZUKSwgbW0sIChwdGVf
dCAqKXB1ZCk7DQo+ID4gKwlpZiAoIXB1ZF9odWdlKCpwdWQpKQ0KPiA+ICsJCWdvdG8gb3V0Ow0K
PiA+ICsJcHRlID0gaHVnZV9wdGVwX2dldCgocHRlX3QgKilwdWQpOw0KPiA+ICsJaWYgKHB0ZV9w
cmVzZW50KHB0ZSkpIHsNCj4gPiArCQlwYWdlID0gcHVkX3BhZ2UoKnB1ZCkgKyAoKGFkZHJlc3Mg
JiB+UFVEX01BU0spID4+IFBBR0VfU0hJRlQpOw0KPiA+ICsJCWlmIChXQVJOX09OX09OQ0UoIXRy
eV9ncmFiX3BhZ2UocGFnZSwgZmxhZ3MpKSkgew0KPiA+ICsJCQlwYWdlID0gTlVMTDsNCj4gPiAr
CQkJZ290byBvdXQ7DQo+ID4gKwkJfQ0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQlpZiAoaXNfaHVn
ZXRsYl9lbnRyeV9taWdyYXRpb24ocHRlKSkgew0KPiA+ICsJCQlzcGluX3VubG9jayhwdGwpOw0K
PiA+ICsJCQlfX21pZ3JhdGlvbl9lbnRyeV93YWl0KG1tLCAocHRlX3QgKilwdWQsIHB0bCk7DQo+
ID4gKwkJCWdvdG8gcmV0cnk7DQo+ID4gKwkJfQ0KPiANCj4gQWdhaW4uIE5vIHN0cm9uZyBvcGlu
aW9uIGJ1dCBhIGNvbW1lbnQgc2ltaWxhciB0byBmb2xsb3dfaHVnZV9wbWQgbWlnaHQgYmUgYmV0
dGVyPw0KPiANCj4gLyoNCj4gICogaHdwb2lzb25lZCBlbnRyeSBpcyB0cmVhdGVkIGFzIG5vX3Bh
Z2VfdGFibGUgaW4NCj4gICogZm9sbG93X3BhZ2VfbWFzaygpLg0KPiAgKi8NCg0KV2lsbCBhZGQg
Y29tbWVudCBvbiB0aGlzIHRvby4gVGhhbmsgeW91Lg0KDQotIE5hb3lhIEhvcmlndWNoaQ==
