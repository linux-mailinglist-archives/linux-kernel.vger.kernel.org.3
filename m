Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8065AC9C2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 07:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiIEFZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiIEFZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:25:24 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2041.outbound.protection.outlook.com [40.107.113.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D192BC0C
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 22:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CE4/pqiDTBSziWly0NUOcQEHRtqQjxqIGyv9h7K4xEDq/KNN0LT7gJMI17FBaHhfbR/VY6hWWPQGN1Bl/V+97K8v2HNrM48L6ERlyjgDwzTREQtmXbOkCMP6DeGIPqasurI2ONMdVghvsuiJnd1fgexHKGzwmACK9qFoWEvLAZoKOwi9vY1Kst2AtZBc2W0Xu3v/l4zIzocbewHJeBH/DU669dYFC86497w5EqIXG4uZgJANfO7jkmLrSUeK0G68X+olV9SLlaAbRbJRfC5Ij/J/U3gaaYiV5rQcF5jLjv+qJqx2LZ6gvuFXAjtYzolAAebADkqHnyLnq0XouroUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQCq1woHc3Ychh6M4GlKIrYGIeGZg7JKKqQKIEOi5kM=;
 b=g6mapje4m56kO1dTvWR1pPF0WAqzUKSyMcFSRQlYc3ZBNY6Vqz9XPfcHfuwipYvdOYmZtwLGDYFMwgpt5KLX+5lu6ImQqbKumh5LdrRQ65/MY0u4yrTioi9Sx0HHRx5j4rV/YC+6e5L5cFVDMv2r47dtkLXCc4GQvjcyMgwNmC92gSI56Fl4PQ7PdN+W+v0xhu46DARidq4fJS+iQ+6le5nBkX1xkRrZv6k3y5XiM5upNV9e8+81Ky2nTTOvVA6SaifgS6JGOVI7M/X+wAOYyyPvhmb+M1UjFYuuL2LO44w/syW5564dyYLOsxR9dta17C7yogwuDszowtXHvOFe5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQCq1woHc3Ychh6M4GlKIrYGIeGZg7JKKqQKIEOi5kM=;
 b=Csd9eSAFpbjpLE7QhmGRunAMb0Ww5KRUXTswAKUg4CBHxoDREYZQOTvPiMi+MbaFIBNNQoMFSJzkcyotrbO/tfNtgdHPAkcpbh2DVbs72QpJtFWfNVmRxq8R1+5WJsg3BMj4BgCecsu+EusAPX2xMPF47vCP1ZxyUrh/tLgXngA=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS0PR01MB5921.jpnprd01.prod.outlook.com (2603:1096:604:ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 05:25:21 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5588.011; Mon, 5 Sep 2022
 05:25:21 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] mm, hwpoison: check PageTable() explicitly in
 hwpoison_user_mappings()
Thread-Topic: [PATCH 5/6] mm, hwpoison: check PageTable() explicitly in
 hwpoison_user_mappings()
Thread-Index: AQHYvG0pD+b+k0RoK0qWf6vcZcGYTa3QVu0A
Date:   Mon, 5 Sep 2022 05:25:21 +0000
Message-ID: <20220905052520.GE1355682@hori.linux.bs1.fc.nec.co.jp>
References: <20220830123604.25763-1-linmiaohe@huawei.com>
 <20220830123604.25763-6-linmiaohe@huawei.com>
In-Reply-To: <20220830123604.25763-6-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 520fa00d-38b6-475e-c195-08da8eff06ff
x-ms-traffictypediagnostic: OS0PR01MB5921:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wz+I0qli9XYpb1H6ALtyQyE83UFFIVp56Q5pg78sci/4FQljLYK750cL6HI49PmzDvW0qfAlstdK4X/abRmazieTnDQzfsCO1G4HB7lmx5BWLKubnIvAur24/mEDAgB1SAUvkTSzpJXh8HcBYezN1nmi4v2mXsRl7pBb5I447ysvN+glHCwm2e71pmwe9vX7mUr1fRE1oVlgmlxKZz8uyjP6Po5T8JdrOeSLQf3HuXCv3UZfPU5jyn4n+F4Y1ASckYrPIHqYt5N9k9k7JbH2t1sy/RrxUNm5soeYdP7W/H/bs/4BRX/r0oZ1oxICsMSCshupd/SNrV6WgXXWRYjTUDFaEz+Cg+HtmMOJZDjQ7dTIEX+rS12J/TGoXlHdwX5ZfnMg+v7zjfPuwR96/r960ORkXm3xJpGHeubQ9EVYftN2P76kDHYz2axyAscBTOa+MVseZNHmU0g5gsmH1GJARN9Cu0LQUR35K3f10GEe7ibIXyfJcw6zIm1QWniW5x2HRb4N8UdMDeljlawc8GP4HewLApqqkAY+tSMEued9op5vvCyc8PeIvgtATpvqmMF+BT01W188aiJ2LmH57ipiDNjfv1IJAjKL9VQ5oyS+4EToMsz3eCLPFGlJV6BuPZa6Fw5HS7uPpmMIQfVTdDgXRNdKb3VDEXHMoRHiXNTa4ti9kfgSfzvj3W/wria15xaqRkZbceLJGiEkThoajZ0GTzp7NykV34s2U3MOiK1wabkWLQN7DD62rH2Uu/VyaQzaVueKRazhVOtlMiwsHAvY+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(38100700002)(6916009)(85182001)(122000001)(54906003)(33656002)(478600001)(71200400001)(6486002)(316002)(86362001)(82960400001)(38070700005)(41300700001)(9686003)(55236004)(6506007)(26005)(1076003)(2906002)(4326008)(66446008)(76116006)(66946007)(66556008)(66476007)(8676002)(186003)(8936002)(64756008)(4744005)(5660300002)(6512007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cS9CVXdKaEFjTDM5Y2thUGduaEhPWkhnVGdNWVVtMmhQYkZBOTJWVDZYU3F4?=
 =?utf-8?B?SVJCQUdmYjFRRU53eGRKc2g3MFdrOG9HaHpXYkh2cGFnMFY1c010Slk2Mmh1?=
 =?utf-8?B?MmNzK2VKV3RIejFHeFVnQzY5Ym9rTWxCU09YN0JHQnFFc0IraGdzR3NxZmh1?=
 =?utf-8?B?S3RncHVBQUVCQzhEREhaMW1wdyt4bTRLdUg0MkVnQWxHVjA4L3UyVmNNRjg2?=
 =?utf-8?B?Q3Z1OUdlL2ROejFhd3kvbGo4ZVhST3oxOU45NVVYQ1RoUnVPVDR2Wnllak1H?=
 =?utf-8?B?bFBvcnFXVlhOWC9OalVvMjhHOFhNQlppem5lRGNIcDVHaUh3WVhzb3kyM1I0?=
 =?utf-8?B?SlFmUHI3Z2Z6NTRlNEM3dEdYcHlVSVlFdW50T3B6SkhvVjl3UjUxUkZrbVpr?=
 =?utf-8?B?aE94ZkxhbmNXK0FTSHg0cnF3QkNaNjhqTnNibk5QNkZJSG1wUmtDY0Q1cUl5?=
 =?utf-8?B?ZEQ4bFhwc2hQT3ZOS0RaSm9kcit5WGJqQWR0T3h4ZENuanV6MnZxeXhmT2NE?=
 =?utf-8?B?TTY3NkRJKzVIcUlabkFXNWFtUHM2SEFSMElEYzZwY1Q0QW9uZnJuTGIwSzFs?=
 =?utf-8?B?MzRiRUJ4eExFQTgzNXI4RC84enNoUW42RkVnZVEyUU9zVkhsbTR3WDBabnky?=
 =?utf-8?B?ekpXN1RFV3YyWFFIUW5HbW1ob0FNQVMzTTJ4RStkZlkvb1JDNitIUUM0ZzVC?=
 =?utf-8?B?em5qMUJVNHNpcnpZSnhIWDIzUis2TTdsdVo1ZVdwVFlLQ3FuOVJiNUsxckxx?=
 =?utf-8?B?TExLUmNVWHF0RUJDMFg2VnZyTFdIOGczQjB2KzFMb1VFMkVuenJjbkdLV0Ji?=
 =?utf-8?B?eW1VZms0dzFaTVFPNVN1REw3OURZQ1RLVU1LVFkva0lnaVordGV2bFRGRk9l?=
 =?utf-8?B?aVFjWjZEeFQ5TDFiTUFDeGIrNFdPUmRNSDRUWlZXOEg1T3Y0LzJJcVJYMGpW?=
 =?utf-8?B?Vm1YMWREcTFiWXE3VG50OUNqNXViYi9NOHozeVR1ajRWNHJDY1NkckJuRUF0?=
 =?utf-8?B?NEtSa0UzdkFaUzAySDNiZUxkbUlxWmpOb3VTYllMeElBekFuaUM4dnpJOTFz?=
 =?utf-8?B?Nk1TN3dXTG4xdjRKZzVaVjIrNDZvWTloZ3drTGJQOEFUMEw1cGlkZUZEWVVo?=
 =?utf-8?B?NVpwVmI2NnlDeXdUYnRXaTd2ak5KUWFDU0d6bG5Sa29JK29EdnF0T0RNRG96?=
 =?utf-8?B?a0MwZ1NlV29xWGJCcVBCc1NqbEhTbWhnRURMVC83clhwUGlIakJNR3ZGSlhV?=
 =?utf-8?B?RFAyOFVxQ3BlVzV5bzZFS1BvSjIwMVdZeGF4bStGbTAyL3I5KzlMdHNIeS92?=
 =?utf-8?B?UnltN0FySUl6VUJrOUVUeUJTUmR1dnJuRTgvbnI3SlFmWGRJVGIzOUxsa1RU?=
 =?utf-8?B?aFYwMUI2VjE2V2Mwdm1nN1VHcFVLaVVsZjBPQWxRYlB1UnNYbE5IUWlkVG5I?=
 =?utf-8?B?SUJadVRzRXBpVXNPRjhna1ErZTZiNnV4aGNWM0Z1Z2FhMGdFUXZFQXhEaXZQ?=
 =?utf-8?B?U2lBZDBTZE9SWFlFRWZGd01YSVRoTHBZUnEyR3cySGlkaGdvaWw1QkdTdEdp?=
 =?utf-8?B?K3hDQ1hhQ011SnVyYU1rOEZFK0V0cGllV055d0JMdXBXcjlQWUlYQmxKc0ZH?=
 =?utf-8?B?dURIS1pRdnBLZEI3MGU3b2NWL2JQZEdEdXRhQ2d2MEJZS2ZSZWwycGc1Q0pr?=
 =?utf-8?B?NUcxN0hkcjFyYUpMSUNIQWxkMmpwN2R2cTFFS2U1eGhpUXhoNzh0ajdoOEp2?=
 =?utf-8?B?RytKZ0pkakZWR0tRbU5RUnBUbHFtcnk4SHpSdWxBK1RoVmdTbnJZRTlkV2xz?=
 =?utf-8?B?VG51ZlpsLzNqbG9CTjNwM2llZWdGaDhZUmRqNlEzcG03VjFkMUpTN3lHc3VO?=
 =?utf-8?B?QVUrK0hYY3hNVTlYNjlQM2c0Y2tKREJySDhleC9RK0NPM1dxSzkvb3VTK0FM?=
 =?utf-8?B?ZHlISkFkeHNLR0FnMnhNQUwxSk9ZYUhWaE1NWnk0TFFkSkZOZlF0bTRUZWFQ?=
 =?utf-8?B?Y2RyaEpZZ1Y4U3g3ZDN6ejNFelRHQzJxSk0vOWQ1VWxVZ2gvZ3RDN2tNMENj?=
 =?utf-8?B?KzkwckJWS281b21wcVF4TnA0cUdIT1ptQUttaWZGOFhUcldBQ3BVYkVocEps?=
 =?utf-8?B?dFVya1FGNndZbWMzQnpmS0MvOU1KTDRNdTVGWllpL1poY3JsWm42bmVPRlB1?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58255D0307DB1C40996C6217F0C1972F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520fa00d-38b6-475e-c195-08da8eff06ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 05:25:21.1419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V7woTEOJghuOXHgFvcs+/UG7AXqf/2Ap3l3+oUL/ZBy3D6tVEuavFovwMWLKwZ/VFfDWPQ9SnkMSwx0Nqxa5lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5921
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMzAsIDIwMjIgYXQgMDg6MzY6MDNQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gUGFnZVRhYmxlIGNhbid0IGJlIGhhbmRsZWQgYnkgbWVtb3J5X2ZhaWx1cmUoKS4gRmls
dGVyIGl0IG91dCBleHBsaWNpdGx5IGluDQo+IGh3cG9pc29uX3VzZXJfbWFwcGluZ3MoKS4gVGhp
cyB3aWxsIGFsc28gbWFrZSBjb2RlIG1vcmUgY29uc2lzdGVudCB3aXRoIHRoZQ0KPiByZWxldmFu
dCBjaGVjayBpbiB1bnBvaXNvbl9tZW1vcnkoKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pYW9o
ZSBMaW4gPGxpbm1pYW9oZUBodWF3ZWkuY29tPg0KDQpBY2tlZC1ieTogTmFveWEgSG9yaWd1Y2hp
IDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4=
