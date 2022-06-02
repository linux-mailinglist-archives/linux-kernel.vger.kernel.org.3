Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5536153B360
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiFBGM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiFBGMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:12:20 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2053.outbound.protection.outlook.com [40.107.113.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3167A27D0DA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:12:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8GXmpChsEaabzXiAskiF3O9sWv7qX+SEjPXO2NrBL2xbHZhbKpOLpPoFbrfXX87Eq8dcQfF8PZvZzPB0hiGzKoxZOMjKJobjOp3ut+AcLJNZcFop0HZj9YifAYqzUuAFWLlhkzSCvtYJW/IpgWpWd/1aK2KPoXkbigL1E419XT3fCjmpR0RZxD7dEI5OXL+Oays2W5VFPgiK2brYAH7Rhw39sJd/tJebo/nv3tSIJ/xhqCNnoin/UJz8MpuYP3DAYfYAY1jY1LdCQzmY3aOwNFFqUiNRWa4CFcRdsHkySt6MOU80BLatYH75E2V7fLmXZqp52N6zBSD2vUzJqjEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N44qt7NT4AXvpLnyRJiyXkFmoA7wHS+AORhp6t6BKFA=;
 b=BzQ012DoWMp4cMKVzs6cGuiUDtY8KYE3ltSBvGrfV2mswR8fI1t+xbbdXIUXFUJum+C3e51RPEXNgb7lRl9Mkcaj6S+4wil1jF6AGyyV+x+ylvfYi0vdnQf3Qu7j+QC3mTNggwlPZMhLFj6Z5tGhh9JTmjpVgCKlP04S5NbNB0CuYcJmPNqMVEx4acj8Tu8qbYfJYfSuqPgLE2v1c46Svj43lGd4BHzQ2wv65hByCPq0ehXWeALAu2TFgHQxumkNqkRU+G69rK6Ycc/+SGwSK85JfhvpQKZ/Zi2f4JsAr/iuP5VcP13BHV1TMyXtw8QNwJd+n9lDPG2sho6DZCMj2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N44qt7NT4AXvpLnyRJiyXkFmoA7wHS+AORhp6t6BKFA=;
 b=Usq/xfCHXlKQyriNbU3eJ0IXhjwzlp3kA8rNOnT1Lu47eGnQWdLU6F3g9DTJBUAW4e1rPHUVOkh26+ZGCHXLRhfYATqji9HZ8t2oOCbWTK4CiT5oPR3lmA1ZtojGJ3ucqIZAw4bPvLmjtplZcHidyVpIs4X5SHgiofNlTFUGgMY=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB5015.jpnprd01.prod.outlook.com (2603:1096:604:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Thu, 2 Jun
 2022 06:12:05 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995%2]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 06:12:05 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        zhenwei pi <pizhenwei@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mm,hwpoison: set PG_hwpoison for busy hugetlb pages
Thread-Topic: [PATCH v1] mm,hwpoison: set PG_hwpoison for busy hugetlb pages
Thread-Index: AQHYZUq6jUL1RAg6UkGx4+LoCthdFK0aAVCAgACmyoCAAHFtgIAgqz6A
Date:   Thu, 2 Jun 2022 06:12:05 +0000
Message-ID: <20220602061203.GB1172281@hori.linux.bs1.fc.nec.co.jp>
References: <20220511151955.3951352-1-naoya.horiguchi@linux.dev>
 <f0da4fcf-a4af-ccaa-32ce-55d9fda72203@oracle.com>
 <20220512043253.GA242760@hori.linux.bs1.fc.nec.co.jp>
 <7395dbe7-7be6-6ef7-7728-a118471caa5a@huawei.com>
In-Reply-To: <7395dbe7-7be6-6ef7-7728-a118471caa5a@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c95f5eb-1119-4bc6-5240-08da445ed131
x-ms-traffictypediagnostic: OSBPR01MB5015:EE_
x-microsoft-antispam-prvs: <OSBPR01MB50157D7AC95CBD0481448FA6E7DE9@OSBPR01MB5015.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SW0pVvyMg+B7nMtI7hpLWoU/2hN7bUV5TEFg4jJdxdioW8E85Mk9kfAl5nniUfdaBtLwvQlUTKA20HJcH14Nek5oJVM7AuyLpJlD+Qxl90ymV7tEaoXzOKx1IWz6smAjDDUHYL8iEAOVjklV/eab5VQf1jcIrVLq2JTr+M256kR+CwDPL1yrB+PYqLvGbymfWTS+oS25k3v9hDe+o/sYxYgqlKe/4Hcxi4Pxo0wwBSBQj0BFxA2tjVesfafNo75k5/2fEmZJrUoxYc6ikKpkGxjBUkl2QNaCyN/Bf4cc5RWGbxdQbPMb8dT/4tPsnR+04iwaULaXRJDJVo5Hm0crmA0eiZ89TAXLeGgoqbnara1o34QQGHPpJc1FLjXzUOVcJyt1ytUNnz3IIDY8MSZIiXe26HkiZ3bRJXjanoT4P8Gjdx7XpqMB8b3264ZC/EJuL2cbi+WpHjoQltCRJB8g80lErVNPrYrYay0oEavYc6Xq2bBD39WevpjzcDrhh566RmqIFdqCJI2a/hQ+DqAl0XWtiBRWU849Gt9HEBdwsV8Q+bWuCxcarBpyUZ/7gh+vn3v1+ZZddr978YhRxGVHw/zPepNbyKXmqGo5kv4CEddnivzUsYY7WR+71zstgpjTo+ovF0qE7T/UpmCat/6XGCqOGpBnIOsqRDteOqj2eNmtrsbOo7OG8K9EFRr1cyg9LWmY5NLmdWmGx/fHiGGy32RVNzGsNswo/kEH7l+KbvaCTLE7OLGLbcWFs9rc7OeB/9OQOP5WHLJJrQ+RHMn5Ykekr472nDe9f1fFuPVKd/Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6916009)(6512007)(9686003)(85182001)(83380400001)(316002)(26005)(54906003)(508600001)(33656002)(55236004)(53546011)(8936002)(4326008)(6486002)(966005)(122000001)(2906002)(5660300002)(38070700005)(76116006)(8676002)(64756008)(66446008)(66476007)(66556008)(38100700002)(66946007)(71200400001)(186003)(1076003)(86362001)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUk3aTZyY1YyZFM3R3RQRW9LVjQ4c3N6NXBmbHl4cEhPb0M1WEkydDdZbHZk?=
 =?utf-8?B?Yjd1eFRXelQ2cUM5OElabS9hYjNXTUJnTEhIc0kzSllxZDFDakRpZE1ybE5w?=
 =?utf-8?B?MWw3bUxtOGQrL2NxSVNCa2tHNkovd0RlVTlkSU9LYS9KenBHcDdBOEgrRCtl?=
 =?utf-8?B?dHdmeDVLM2lya2tNbHhBczQwOE1iZ2VuY09wQTNVRUtYZTIrYm80VTBORmhN?=
 =?utf-8?B?SWh6OUZmYStiaXhQV2ZSZEUzVXVnTUhGUmNHUXVQNGM3aFJ3T0ZmbU5qS2dJ?=
 =?utf-8?B?Ujdkd1FJVmFLbEpJaVd0dmgwMzhkbVpEM0s1WVlUdEx2QzNSR2ZWNlluN3RY?=
 =?utf-8?B?elVsSmRoWjZtOE9Bakw5Z0NTd2kremtBTHo5c0tmZGN5S3VRSi9uNnd4RGFC?=
 =?utf-8?B?UC85N1FUd0tBNTc1K3NwNjc2dW9rREZRSG1rblJCK3I2dFZzYWNqU1Bodk5l?=
 =?utf-8?B?YW5EQm55NGdOeWdOS0J5NTFaeFQ5Nnp4Q2YwQ2VJbzNrVlRnUFJjRk03dGpP?=
 =?utf-8?B?ZkFPRmFIanc5eGkzTzh0MXJXcDd5VmNldXhERXZ6d3hWdnZMQ0lsUEYyWmlw?=
 =?utf-8?B?VW96aXcyMWRUUituL09HUi9LK0lKbzBJeGhkTEd3ZWFQblMyaTYyMHRITnVI?=
 =?utf-8?B?SzJYNEc5SklEbEo0dnJuQ0dhOWNHaXpCQ3ZkblpVUnpPaVQzSDkrUWY5WGIy?=
 =?utf-8?B?emNCVjJtTE1ZaG5OQjF2eVlobm12TVVVTnFUL243eUcrbEdTVjNNbHIwNmhJ?=
 =?utf-8?B?Z1gxRDh5K2pKUjlhUTVWSUZIb0VEcnVrd2IyT1c3bWM1aVE3RmFLU3U1Y2lH?=
 =?utf-8?B?eTNJZHk5WlhHMkRXR1BVM0hQT2s3TnJJZ3BzK0VpS0pZUUFncjNyL0pkVmw1?=
 =?utf-8?B?bGpFUlJUWmpMRzZMcXNYVzBxZnlXMWtGOFREV0E2NmdlQlhvOGU4NjZEY2l5?=
 =?utf-8?B?WGk0ZmpGZ3pMeTBKWnlYSmlKRnFKTUVTZjF0aTYxV3ZQRk9DNkw0clJTMHZK?=
 =?utf-8?B?M2RaQ3dKWU5NbUUwY0ZBUGxTdTVldGZqZWFKTEVTUHAvMFAvZHd4ZlJBS2s3?=
 =?utf-8?B?SWNOdDNMTTNwNy9lempxWUlzc0xhOFZiOGNFVHROMUUwdzRMR3piNWhmQVJt?=
 =?utf-8?B?emdKNFRLbzlhVUsxNzVkL21qMlpVMTZIMGxMQk51bzRYTm9MUTZQRXdjbE9k?=
 =?utf-8?B?SWo3ZGQrM3hmQjAyNVY1SjdmWE40NzVuQkNNWlNSOHBiUTgwTDRKeXpSRDUx?=
 =?utf-8?B?SUp0RGo2bWpzWHAxSE1QeHNsQ2NPblRLbjVtOTRjZXhocmVnZlo3YVJ6NGxS?=
 =?utf-8?B?d2NVZjdNdzk4S3ZwSXRKaFBuTElnTTdLeUNkakRvL2FLMzZnU2ZxdUs1MWJI?=
 =?utf-8?B?MVBhVTJvR2Mvd0p4Z09tenJ2S1NjWGlueVc3dmFIQzA4UlJSZnBiSzhXc0xk?=
 =?utf-8?B?WFA0WjlWZXJRNnVGZmI0Y1NCcVlURXMwWGtIbGxsbmdIbUpJNk9YUlo4Yitz?=
 =?utf-8?B?b01lbVIxdHJCUFVIVWRvdldJK2lKZklxSXZBeTF1TVVsdkxFcS9zQk9UNmhU?=
 =?utf-8?B?TW5iRFhQNlZxNzBJMnYvdzY1bFpqVi9DTkRpNGgxTHU0Q0kvWGNFZEFMdVlI?=
 =?utf-8?B?bUNRbUtvcmVyYTlDQU53dWVKM3dDMEluY3U2Q1FTMkl1dkdMakZCdGFMV3hw?=
 =?utf-8?B?bFIyaUJCS1d6R1MrUEx6ZG5WbmdqV2RUYXVHSzhsZDJjL2duOGFGMlowbTJn?=
 =?utf-8?B?bXc3UENHbGVVYWlqc21SUUxiYjlaa0s3ZFBBdTFQUTVXWnZYVXNDeHU2amsr?=
 =?utf-8?B?bTFkUGFhOCs3QnNxVm04WUhoN1dTN2Z2ci9nWEZQQkJwaWQ5QVF3RGw5SDk3?=
 =?utf-8?B?Rm5kSHMzR20xbVlxRTdZNU5FY3RGM2ZmSEJxbm9TZ1RDbGZ6REJrOTluSVJY?=
 =?utf-8?B?aDBLblh2SVVwYnphZHNneTJhb1pmdVhaTENHUlFBNHdaeG5BR2x1cHVrMTl3?=
 =?utf-8?B?cVY0QXNrME1HOFRGN0dud2RzVW90cUVwOENOajdnVlZGUk4rOFRFRXRabGZo?=
 =?utf-8?B?cGZHaTlxeFZIOXJwTmlVTmFNV2JkM3lxeldKL09EOFp3dVBPc2R0MjVCS1Mz?=
 =?utf-8?B?V2J4NWlNbGV6ZW81SHAwTlNLVkpwY1E0NVdqUTRwU2dXMDI5aUNEQ05xRnpX?=
 =?utf-8?B?WDgrN0d6a0ZhL09YMnVPOXhFK2JRclRjeENJU3Axa0FmU3Q0bVNSK3F3SEFR?=
 =?utf-8?B?dlBPT0p2RkFZZUk0V1FZUHV3TXYyNlBpdjZOY1hrNXByVWlEL1d1KzFOajB4?=
 =?utf-8?B?WWpWZTJSQ0NMLzZOY2pJUHdlM3pQQ2VLMUxOS0ZURVhEYXljaHp6Si8rWU1w?=
 =?utf-8?Q?n7qEv6S0YD8/cRN4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B04CDE2AAD4A714B8C18604FF9AEF2A1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c95f5eb-1119-4bc6-5240-08da445ed131
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 06:12:05.3475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNti+WfzExjMtNnkkoRIRbNDvkZVTXFV4/OPH8USrF7+fZyPUnVQE/N2yUpZbNsQoqAlfK1y5zv8pbvdozvbzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXkgMTIsIDIwMjIgYXQgMDc6MTg6NTFQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi81LzEyIDEyOjMyLCBIT1JJR1VDSEkgTkFPWUEo5aCA5Y+jIOebtOS5nykg
d3JvdGU6DQo+ID4gT24gV2VkLCBNYXkgMTEsIDIwMjIgYXQgMTE6MzU6NTVBTSAtMDcwMCwgTWlr
ZSBLcmF2ZXR6IHdyb3RlOg0KPiA+PiBPbiA1LzExLzIyIDA4OjE5LCBOYW95YSBIb3JpZ3VjaGkg
d3JvdGU6DQo+ID4+PiBGcm9tOiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMu
Y29tPg0KPiA+Pj4NCj4gPj4+IElmIG1lbW9yeV9mYWlsdXJlKCkgZmFpbHMgdG8gZ3JhYiBwYWdl
IHJlZmNvdW50IG9uIGEgaHVnZXRsYiBwYWdlDQo+ID4+PiBiZWNhdXNlIGl0J3MgYnVzeSwgaXQg
cmV0dXJucyB3aXRob3V0IHNldHRpbmcgUEdfaHdwb2lzb24gb24gaXQuDQo+ID4+PiBUaGlzIG5v
dCBvbmx5IGxvc2VzIGEgY2hhbmNlIG9mIGVycm9yIGNvbnRhaW5tZW50LCBidXQgYnJlYWtzIHRo
ZSBydWxlDQo+ID4+PiB0aGF0IGFjdGlvbl9yZXN1bHQoKSBzaG91bGQgYmUgY2FsbGVkIG9ubHkg
d2hlbiBtZW1vcnlfZmFpbHVyZSgpIGRvDQo+ID4+PiBhbnkgb2YgaGFuZGxpbmcgd29yayAoZXZl
biBpZiB0aGF0J3MganVzdCBzZXR0aW5nIFBHX2h3cG9pc29uKS4NCj4gPj4+IFRoaXMgaW5jb25z
aXN0ZW5jeSBjb3VsZCBoYXJtIGNvZGUgbWFpbnRhaW5hYmlsaXR5Lg0KPiA+Pj4NCj4gPj4+IFNv
IHNldCBQR19od3BvaXNvbiBhbmQgY2FsbCBodWdldGxiX3NldF9wYWdlX2h3cG9pc29uKCkgZm9y
IHN1Y2ggYSBjYXNlLg0KPiA+Pj4NCj4gPj4+IEZpeGVzOiA0MDVjZTA1MTIzNmMgKCJtbS9od3Bv
aXNvbjogZml4IHJhY2UgYmV0d2VlbiBodWdldGxiIGZyZWUvZGVtb3Rpb24gYW5kIG1lbW9yeV9m
YWlsdXJlX2h1Z2V0bGIoKSIpDQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBOYW95YSBIb3JpZ3VjaGkg
PG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgaW5jbHVkZS9saW51
eC9tbS5oICB8IDEgKw0KPiA+Pj4gIG1tL21lbW9yeS1mYWlsdXJlLmMgfCA4ICsrKystLS0tDQo+
ID4+PiAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW0uaCBiL2luY2x1ZGUvbGlu
dXgvbW0uaA0KPiA+Pj4gaW5kZXggZDQ0NmU4MzRhM2U1Li4wNGRlMGMzZTRmOWYgMTAwNjQ0DQo+
ID4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L21tLmgNCj4gPj4+ICsrKyBiL2luY2x1ZGUvbGludXgv
bW0uaA0KPiA+Pj4gQEAgLTMxODcsNiArMzE4Nyw3IEBAIGVudW0gbWZfZmxhZ3Mgew0KPiA+Pj4g
IAlNRl9NVVNUX0tJTEwgPSAxIDw8IDIsDQo+ID4+PiAgCU1GX1NPRlRfT0ZGTElORSA9IDEgPDwg
MywNCj4gPj4+ICAJTUZfVU5QT0lTT04gPSAxIDw8IDQsDQo+ID4+PiArCU1GX05PX1JFVFJZID0g
MSA8PCA1LA0KPiA+Pj4gIH07DQo+ID4+PiAgZXh0ZXJuIGludCBtZW1vcnlfZmFpbHVyZSh1bnNp
Z25lZCBsb25nIHBmbiwgaW50IGZsYWdzKTsNCj4gPj4+ICBleHRlcm4gdm9pZCBtZW1vcnlfZmFp
bHVyZV9xdWV1ZSh1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzKTsNCj4gPj4+IGRpZmYgLS1n
aXQgYS9tbS9tZW1vcnktZmFpbHVyZS5jIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+Pj4gaW5k
ZXggNmEyOGQwMjBhNGRhLi5lMzI2OWI5OTEwMTYgMTAwNjQ0DQo+ID4+PiAtLS0gYS9tbS9tZW1v
cnktZmFpbHVyZS5jDQo+ID4+PiArKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ID4+PiBAQCAt
MTUyNiw3ICsxNTI2LDggQEAgaW50IF9fZ2V0X2h1Z2VfcGFnZV9mb3JfaHdwb2lzb24odW5zaWdu
ZWQgbG9uZyBwZm4sIGludCBmbGFncykNCj4gPj4+ICAJCQljb3VudF9pbmNyZWFzZWQgPSB0cnVl
Ow0KPiA+Pj4gIAl9IGVsc2Ugew0KPiA+Pj4gIAkJcmV0ID0gLUVCVVNZOw0KPiA+Pj4gLQkJZ290
byBvdXQ7DQo+ID4+PiArCQlpZiAoIShmbGFncyAmIE1GX05PX1JFVFJZKSkNCj4gPj4+ICsJCQln
b3RvIG91dDsNCj4gPj4+ICAJfQ0KPiA+Pg0KPiA+PiBIaSBOYW95YSwNCj4gPj4NCj4gPj4gV2Ug
YXJlIGluIHRoZSBlbHNlIGJsb2NrIGJlY2F1c2UgIUhQYWdlRnJlZWQoKSBhbmQgIUhQYWdlTWln
cmF0YWJsZSgpLg0KPiA+PiBJSVVDLCB0aGlzIGxpa2VseSBtZWFucyB0aGUgcGFnZSBpcyBpc29s
YXRlZC4gIE9uZSBjb21tb24gcmVhc29uIGZvciBpc29sYXRpb24NCj4gPj4gaXMgbWlncmF0aW9u
LiAgU28sIHRoZSBwYWdlIGNvdWxkIGJlIGlzb2xhdGVkIGFuZCBvbiBhIGxpc3QgZm9yIG1pZ3Jh
dGlvbi4NCj4gPiANCj4gPiBZZXMsIGFuZCBJIGFsc28gZGV0ZWN0ZWQgdGhpcyBpc3N1ZSBieSB0
ZXN0aW5nIHJhY2UgYmV0d2VlbiBodWdlcGFnZSBhbGxvY2F0aW9uDQo+ID4gYW5kIG1lbW9yeV9m
YWlsdXJlKCkuIA0KPiA+IA0KPiA+Pg0KPiA+PiBJIHRvb2sgYSBxdWljayBsb29rIGF0IHRoZSBo
dWdldGxiIG1pZ3JhdGlvbiBjb2RlIGFuZCBkaWQgbm90IHNlZSBhbnkgY2hlY2tzDQo+ID4+IGZv
ciBQYWdlSFdQb2lzb24gYWZ0ZXIgYSBodWdldGxiIHBhZ2UgaXMgaXNvbGF0ZWQuICBJIGNvdWxk
IGhhdmUgbWlzc2VkDQo+ID4+IHNvbWV0aGluZz8gIElmIHRoZXJlIGFyZSBubyBjaGVja3MsIHdl
IHdpbGwgcmVhZCB0aGUgUGFnZUhXUG9pc29uIHBhZ2UNCj4gPj4gaW4ga2VybmVsIG1vZGUgd2hp
bGUgY29weWluZyB0byB0aGUgbWlncmF0aW9uIHRhcmdldC4NCj4gPiANCj4gPiBZZXMsIHRoYXQg
Y291bGQgaGFwcGVuLiAgVGhpcyBwYXRjaCBkb2VzIG5vdCBhZmZlY3Qgb25nb2luZyBodWdlcGFn
ZSBtaWdyYXRpb24uDQo+ID4gQnV0IGFmdGVyIHRoZSBtaWdyYXRpb24gc291cmNlIGh1Z2VwYWdl
IGlzIGZyZWVkLCB0aGUgUEdfaHdwb2lzb24gc2hvdWxkIHdvcmsNCj4gPiB0byBwcmV2ZW50IHJl
dXNpbmcuDQo+ID4gDQo+ID4+DQo+ID4+IElzIHRoaXMgYW4gaXNzdWU/ICBJcyBpcyBzb21ldGhp
bmcgd2UgbmVlZCB0byBiZSBjb25jZXJuZWQgd2l0aD8gIE1lbW9yeQ0KPiA+PiBlcnJvcnMgY2Fu
IGhhcHBlbiBhdCBhbnkgdGltZSwgYW5kIGdyYWNlZnVsbHkgaGFuZGxpbmcgdGhlbSBpcyBiZXN0
IGVmZm9ydC4NCj4gPiANCj4gPiBSaWdodCwgc28gZG9pbmcgbm90aGluZyBmb3IgdGhpcyBjYXNl
IGNvdWxkIGJlIE9LIGlmIGRvaW5nIHNvbWV0aGluZyBjYXVzZXMNCj4gPiBzb21lIGlzc3VlcyBv
ciBtYWtlcyBjb2RlIHRvbyBjb21wbGljYXRlZC4gIFRoZSBtb3RpdmF0aW9uIG9mIHRoaXMgcGF0
Y2ggaXMNCj4gPiB0aGF0IG5vdyBJIHRoaW5rIG1lbW9yeV9mYWlsdXJlKCkgc2hvdWxkIGRvIHNv
bWV0aGluZyAoYXQgbGVhc3Qgc2V0dGluZw0KPiA+IFBHX2h3cG9pc29uKSB1bmxlc3MgdGhlIHBh
Z2UgaXMgYWxyZWFkeSBod3BvaXNvbmVkIG9yIHJlamVjdGVkIGJ5DQo+ID4gaHdwb2lzb25fZmls
dGVyKCksIGJlY2F1c2Ugb2YgdGhlIGVmZmVjdCBhZnRlciBmcmVlIGFzIG1lbnRpb25lZCBhYm92
ZS4NCj4gPiANCj4gPiBUaGlzIGlzIGFsc28gZXhwZWN0ZWQgaW4gb3RoZXIgY2FzZSB0b28uIEZv
ciBleGFtcGxlLCBzbGFiIGlzIGEgdW5oYW5kbGFibGUNCj4gPiB0eXBlIG9mIHBhZ2UsIGJ1dCB3
ZSBkbyBzZXQgUEdfaHdwb2lzb24uICBUaGlzIGZsYWcgc2hvdWxkIG5vdCBhZmZlY3QgYW55IG9m
DQo+ID4gb25nb2luZyBzbGFiLXJlbGF0ZWQgcHJvY2VzcywgYnV0IHRoYXQncyBPSyBiZWNhdXNl
IGl0IGJlY29tZXMgZWZmZWN0aXZlDQo+ID4gYWZ0ZXIgdGhlIHNsYWIgcGFnZSBpcyBmcmVlZC4N
Cj4gPiANCj4gPiBTbyB0aGlzIHBhdGNoIGlzIGludGVuZGVkIHRvIGFsaWduIHRvIHRoZSBiZWhh
dmlvci4gIEFsbG93aW5nIGh1Z2VwYWdlDQo+ID4gbWlncmF0aW9uIHRvIGRvIHNvbWV0aGluZyBn
b29kIHVzaW5nIFBHX2h3cG9pc29uIHNlZW1zIHRvIG1lIGFuIHVuc29sdmVkDQo+ID4gc2VwYXJh
dGUgaXNzdWUuDQo+IA0KPiBJIHRlbmQgdG8gYWdyZWUgd2l0aCBOYW95YS4gQW5kIGNvdWxkIHdl
IHRyeSB0byBkbyBpdCBiZXR0ZXI/IElNSE8sIHdlIGNvdWxkIGRvIGENCj4gZ2V0X3BhZ2VfdW5s
ZXNzX3plcm8gaGVyZSB0byBlbnN1cmUgdGhhdCBodWdldGxiIHBhZ2UgbWlncmF0aW9uIHdpbGwg
ZmFpbCBkdWUgdG8NCj4gdGhpcyBleHRyYSBwYWdlIHJlZmVyZW5jZSBhbmQgdGh1cyBwcmV2ZW50
aW5nIHRoZSBwYWdlIGNvbnRlbnQgZnJvbSBiZWluZyBhY2Nlc3NlZC4NCj4gRG9lcyB0aGlzIHdv
cms/IE9yIGFtIEkgbWlzcyBzb21ldGhpbmc/DQoNClNvcnJ5IGZvciBteSBtaXNzaW5nIHRvIGFu
c3dlcmluZyB0aGUgcXVlc3Rpb24sDQoNClRha2luZyBwYWdlIHJlZmNvdW50IHRvIHByZXZlbnQg
cGFnZSBtaWdyYXRpb24gY291bGQgd29yay4gIE9uZSBjb25jZXJuIGlzDQpob3cgd2UgY2FuIGRp
c3Rpbmd1aXNoIGh1Z2VwYWdlcyB1bmRlciBtaWdyYXRpb24gYW5kIHRob3NlIHVuZGVyIGFsbG9j
YXRpb24NCmZyb20gYnVkZHkuICBNYXliZSB0aGlzIHdhcyBhbHNvIG1lbnRpb25lZCBpbiBkaXNj
dXNzaW9uIG92ZXIgDQpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvY29tbWl0LzQw
NWNlMDUxMjM2Y2M2NWIzMGJiZmU0OTBiMjhjZTYwYWU2YWVkODUNCiwgdGhlcmUncyBhIHNtYWxs
IHdpbmRvdyB3aGVyZSBhbiBhbGxvY2F0aW5nIGNvbXBvdW5kIHBhZ2UgaXMgcmVmY291bnRlZCBh
bmQNCmh1Z2VwYWdlIChoYXZpbmcgZGVjb25zdHJ1Y3RvciBDT01QT1VORF9QQUdFX0RUT1IpLCBh
bmQgbm90IHByb3RlY3RlZCBieQ0KaHVnZXRsYl9sb2NrLCBzbyBzaW1wbHkgZ2V0X3BhZ2VfdW5s
ZXNzX3plcm8oKSBtaWdodCBub3Qgd29yayAobWlnaHQgYnJlYWsNCmFsbG9jYXRpb24gY29kZSku
DQpJZiB3ZSBoYXZlIG1vcmUgcmVsaWFibGUgaW5kaWNhdG9yIHRvIGVuc3VyZSB0aGF0IGEgaHVn
ZXBhZ2UgaXMgdW5kZXIgbWlncmF0aW9uLA0KdGhhdCB3b3VsZCBiZSBoZWxwZnVsLg0KDQpUaGFu
a3MsDQpOYW95YSBIb3JpZ3VjaGk=
