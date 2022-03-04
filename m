Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D68E4CCFF0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiCDI27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiCDI2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:28:55 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2075.outbound.protection.outlook.com [40.107.114.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A199427E2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:28:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0CLUT9RB4cVnPS7VPTKBr+tLrK7pAXATnYfmWD06YxndIqjPeiu+A+VLisd7KlgGtNMztQV7suPmQY+Sm+lvbNnlGREl5/Z/pABpqQVOK5DSmPGSG3sgkMqPlg30kFSozvqGRbyzxwawca0hUwCpTkQigteJeI+QEuDYTJgDR5GrE3hjQXZ6en/r6kLhpCKcSDudTw4uHdpLqnRwE9GTQbCqYkPCZsQNua1XsW3BXTTZij1xQ7eiibxMozkrMfcB429jcsBSlWRznWNKccXbVvXjomxFTgctA+TYgWaPFel+7Tfz4oYs0m994Ek2eIZsSOl+fCG4lRj+IZN50qasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgXQ19qwzUAEd3L8eHEO6Q8gXceyQLZXHTUbtlDGp7U=;
 b=mvCgpNltR5/PMNXen75jV6xBHZJteAZB0gKA0hk0T8gVbnlldSdeX0UInJ+9yCgvamlF54s40rC+SCOaiB3Y5VObUxwTyIrjYt9kASiJcIjxFDO/fcVRk+A/ssdi3bBArOkxE08CSOa3+kCAkK5T1+B3A5KP1G3r4tdeL+kRxh5mFCYN2Foj0n4kCPhvGRdOJs5lPAFco2owNFRSH+pGFiol/OPc+Jh3G+4PcPKteuWDd8pBCCFXV0UxyTUF3XY4LuUpOmrxLxwnkj5wkTz9iVNW0jgpIZ1KaWo3bfnu7OaocXR4hfOWpW/oPdREfYgyzZoeb7F3kzGAsVcXS4tpVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgXQ19qwzUAEd3L8eHEO6Q8gXceyQLZXHTUbtlDGp7U=;
 b=PyR5BZN2PYWjl/iscgcs0vxJzeGNSzXQbsJu3wgRGQ+M7B3uhwsNjexd/r/ofT14rMczxFnQ4BXy0JPWw2nozMJqoiIQ1pxZJlsMCYFc/EN6OUjtWw+lpjp6tGYiCm2weqfCcY8dcPRRjdTLiBwLazZoIuq9TUptPFYKcKtB+wM=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB4611.jpnprd01.prod.outlook.com (2603:1096:604:36::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 08:28:05 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::6565:8408:9726:83e]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::6565:8408:9726:83e%8]) with mapi id 15.20.5038.014; Fri, 4 Mar 2022
 08:28:05 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] mm/memory-failure.c: fix potential VM_BUG_ON_PAGE in
 split_huge_page_to_list
Thread-Topic: [PATCH 4/4] mm/memory-failure.c: fix potential VM_BUG_ON_PAGE in
 split_huge_page_to_list
Thread-Index: AQHYLKv9YOAnBZbcf0yzU4FaiEhmoqyu6jAA
Date:   Fri, 4 Mar 2022 08:28:05 +0000
Message-ID: <20220304082804.GC3778609@hori.linux.bs1.fc.nec.co.jp>
References: <20220228140245.24552-1-linmiaohe@huawei.com>
 <20220228140245.24552-5-linmiaohe@huawei.com>
In-Reply-To: <20220228140245.24552-5-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d77d47d4-8030-4959-27ef-08d9fdb8e7c5
x-ms-traffictypediagnostic: OSAPR01MB4611:EE_
x-microsoft-antispam-prvs: <OSAPR01MB4611E018212BCD50675F7F34E7059@OSAPR01MB4611.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ePwbGfriTTsTo41X4BI/PnFKCsYFnSOQhTpoebNrkccY/3knueQqkz+qVwDOtgE2PjPjL9cwM8dqhdKEbbmJObKlkKnbQOGTE+rmUY+5eC3XblrbrreOCizDq7RY8xygWeKGBv2qB2LuKxo414h/jJN4cRQP8YYWrxgRWbIZw5qNz8npiqy69/uLZR29oLxOUF3f3MkRO4BJtqSBybTnkLwR7NZofufyatnHKpTJ8aZUFAkpOmUbDbPqk/KNsjCBnYUJbzM9MirJ+nNJy4nftadRfHsdFrlRTiJ6y2oGZ12FzqV45R/Bcx2C3Ky+L4S1oyeol+MRPUiW/99QmnkoxYenM1aOMfXu6i3s0f9VDeVrOmu9dLHP2ITYgp1HKiNnvYFd1w5hCLZap2cPvt1UULuqyjAU2wgNr1KUXLV3sISlInPHnuUFwyiB/wzsDta7Ntbm2bazu0PGsA9a8E0Z59barXgCCbK80vN8zGkaPrCqo5rQ2UcR47+kVjiliSIcavLYWvoqEZOisCpQCgXY/Livd/ENp5llnFVJrVUXVWxLyOzaGOF0nA3csDwx8JtUjbaHJ1ebBFBLEDE3Whef8anMEJs/CBSgfNsHkjvk8TyYO8y+od99MD/kwickk8DFlPxwzuc5F2RtnDDADYD9GdQbI87ocm1drWOP23eHs6iCJkRL94rz3SYlU7YPA5IzK0lI10pEPdlzcT+P3zCF4e5msskbKQ3yy4YjSWJc2s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(316002)(26005)(76116006)(33656002)(186003)(6916009)(2906002)(66556008)(4326008)(8676002)(64756008)(54906003)(66446008)(83380400001)(71200400001)(508600001)(86362001)(38070700005)(122000001)(5660300002)(66946007)(38100700002)(8936002)(6486002)(82960400001)(6506007)(55236004)(9686003)(6512007)(85182001)(1076003)(14583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzZENkdneVplb0M3SFdlaUNTcVlLYy9uSTlQWEdhcTBzYUJDdWlsQ3NzRlpa?=
 =?utf-8?B?TSsxSklTajE1WncvY3VtbGgzdmxyN3RuT1RWYkMwSjNlOC9VcGRXckszdG5t?=
 =?utf-8?B?RG1iNDllN3NsWnk5UHFQNGhDeGdlNHlmS1NQVHRZNUYxRTF4TUlqd3R2SDJq?=
 =?utf-8?B?QTJlRTUyTVlTZFQ5ajY0eklIOTc5Y0kxVjhlNi85cGpQVWdmN0ZnaTY0eHdu?=
 =?utf-8?B?Vmx3dFNEelhwVDA0ZmhmNVJvR1N1aUdEUDZvYXVBcXhHVUtTZ2VIdmZra3ox?=
 =?utf-8?B?NHl3L25zdnNiWmdTOExjbnFmTTJ1L1k5Y1lQeWhsYzdxeFFKZmJXa293RnU1?=
 =?utf-8?B?Z09jUUpvZGRiZHI4VnlmSlJEakVERS9JNWlEbFVHSWZ1TVRQSzRKdjIrNjNR?=
 =?utf-8?B?Y1VLb0Nad0wvY1pVdTVMMHJ3TG1PVGhDdE1DSS9BNm9VVGNuR09CNE5IM3Jm?=
 =?utf-8?B?S0N4dDFUNFMxN3pabTUvRWdTdkZiU0hHRUhyOG1NdVR2TjU4Z2MwdE03d25B?=
 =?utf-8?B?R1pHWXVoaXdBSVNlV2NtajFESHIxdjUyMkpqd3IwRllDZGYwYnd3VmZCMWpG?=
 =?utf-8?B?d2lvaWFKc3krOFBORlorVHMyYVorbkNYMW1LaEl2VGhEM1BPQmRqbkFSYTFX?=
 =?utf-8?B?cDF6MExYV3dDcW1EQzRrSjQ3WDM3MkxPblBINTI2b1lqN01JSUdENEErM0Ft?=
 =?utf-8?B?ZWxwZ3pRdWpGQkMzcFRwbENiejQ4dDNPY1BNd3hoWHQwc2YzdUMwVFNCTzBK?=
 =?utf-8?B?bGNXdS91aVhDUDN3cklvS2I2L1pENm9DNTREZDA1MFVWY2JSZ3lkU3Q2UW9t?=
 =?utf-8?B?TUppeENaMi92WEdlRTRQNlBGdkFQL1NqMFBIY3JpUUtLdEk5R3Y2RGUxNXA4?=
 =?utf-8?B?S0VJUG8yamhhQVpZVW8zSDMycTFjMFdKVVEvWXpMbG4wMndSdTdvakJEcUVW?=
 =?utf-8?B?NDVvbVRDUURldWpLcThuWVQwMDFqOWFnZTM2cmxuOE1ER3RpdTZUNW9JYzln?=
 =?utf-8?B?Z2lUdW5xcTVkYUVsWEFrMWROYnR3dUFQWXdkL2dzaGRoVGJNbmhjMVJ4NGZm?=
 =?utf-8?B?OGVBbWNCUDdXbjB5UWhUNk9uNW9WUW5YbUFmR2VkQyttdHFWa3lxbnpmdmYy?=
 =?utf-8?B?dHN5SEllci90QVprT2hDMFBSQW95K0p2ZnJCRHRuNTFXUyt5U2lVeHJmOVpC?=
 =?utf-8?B?U0czWTBTZjV0VmYreHNxR05ienpKSk9acVRDbzV4OCtwYkxENGFWalF6TEJD?=
 =?utf-8?B?K2RPb3dnMnhXdkU4TklrbEplLytUMEdzdG9JZFY0bHV6dmxYTkgrNGRDd0hU?=
 =?utf-8?B?NWhMMWNaQnVTL3FkOHRBT21yd3dYWEtPQUx3cEh5bURyenl1bmJaRllJWnNk?=
 =?utf-8?B?ZmpRQ0hRcGR0RGRmdThEdk5hdnFHS1E0RHZFVkFDbmtRYzZBcURvVG14ejJX?=
 =?utf-8?B?UGRQK0toRVZRYTRuWmJ0RDh0MFBnWHlLeEdCUlVUa2wxRTlueTRrWkxRYTBE?=
 =?utf-8?B?Y0Qrdy9EV0tkSk1Ucmp6NzhvL3NNMkJHOGNUTjBhUGdOc01IOFBLeGZsazky?=
 =?utf-8?B?TERYeFNIckN4cFFKZWszL1J6WlYzelpBZlVFaHplZWZRQ2dkc091eEI2L2hs?=
 =?utf-8?B?NHdXQ29vdm1IZE5sNjVERHpXbldDYzc5UEpKZ3JjbUN3S3prZ1U2OHVwZklw?=
 =?utf-8?B?L0lMeG80QTJLZytXT2dEUDFxK3diT3p6Nmh6cHJVV21SZEhLNlMxdXFMVXIv?=
 =?utf-8?B?T0ZIWmZmaWZJU29USERhTnpPZks3WGhCakpTQ3E5aENUbHpPeE5pY0dBZDZF?=
 =?utf-8?B?WmF3RkdTNmFhMFdzanlJbVR3UEZDdlRYd3d0Y2pKNHJDMVhLTWZBVjRYZUc0?=
 =?utf-8?B?ZTlqMnNZcWxZclQvaVVjdWVQalpDRS90NjE4NW5SaXcxSUpWM1RuSlVvY3lp?=
 =?utf-8?B?RStCV3lLWlNUc1BxV3ExQjhZMjRGZkdoaG1VYXBHYlJwV2dDYmNQdkdRcWow?=
 =?utf-8?B?VmI0LzdQdWdrUkgrM05SYjA3VXQ3Skd3K3NEWkpXWGVTOVhDMnN4cm9JVklO?=
 =?utf-8?B?cWlGQVd0QUNDNFl0TEpyMStRQ2Q1SVp5eDRMRE9uTDdlOXdYQXFhVTVPeWh3?=
 =?utf-8?B?VjVBVmkwaVU5RmwyU09lR3U1aTUwZUEyQWZJSWtTUkRwUTFZMDFaZVRlbGlU?=
 =?utf-8?Q?qJ8cgjpfzW8VeDDQJKaSfiysq21jO/5bfuAyaFeebWir?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52AC7A353F86CE4FB8DAC78D0399332D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77d47d4-8030-4959-27ef-08d9fdb8e7c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 08:28:05.3278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6MDJjBE6K6iCTXLlW9xQyF92kv2gGZYRrZS/SN+pRKe8m9mXmK9FwJPZCCFg19EEiMV3f5ebB38oe1Ei3GcBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4611
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBGZWIgMjgsIDIwMjIgYXQgMTA6MDI6NDVQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gVGhlIGh1Z2UgemVybyBwYWdlIGNvdWxkIHJlYWNoIGhlcmUgYW5kIGlmIHdlIGV2ZXIg
dHJ5IHRvIHNwbGl0IGl0LCB0aGUNCj4gVk1fQlVHX09OX1BBR0Ugd2lsbCBiZSB0cmlnZ2VyZWQg
aW4gc3BsaXRfaHVnZV9wYWdlX3RvX2xpc3QoKS4gQWxzbyB0aGUNCj4gbm9uLWxydSBjb21wb3Vu
ZCBtb3ZhYmxlIHBhZ2VzIGNvdWxkIGJlIHRha2VuIGZvciB0cmFuc2h1Z2UgcGFnZXMuIFNraXAN
Cj4gdGhlc2UgcGFnZXMgYnkgY2hlY2tpbmcgUGFnZUxSVSBiZWNhdXNlIGh1Z2UgemVybyBwYWdl
IGlzbid0IGxydSBwYWdlIGFzDQo+IG5vbi1scnUgY29tcG91bmQgbW92YWJsZSBwYWdlcy4NCg0K
SXQgc2VlbXMgdGhhdCBtZW1vcnlfZmFpbHVyZSgpIGFsc28gZmFpbHMgYXQgZ2V0X2FueV9wYWdl
KCkgd2l0aCAiaHdwb2lzb246DQp1bmhhbmRsYWJsZSBwYWdlIiBtZXNzYWdlLg0KDQogIFsxNjQ3
OC4yMDM0NzRdIHBhZ2U6MDAwMDAwMDBiNmFjZGJkMSByZWZjb3VudDoxIG1hcGNvdW50OjAgbWFw
cGluZzowMDAwMDAwMDAwMDAwMDAwIGluZGV4OjB4MCBwZm46MHgxODEwYjQNCiAgWzE2NDc4LjIw
NjYxMl0gZmxhZ3M6IDB4NTdmZmZmYzA4MDEwMDAocmVzZXJ2ZWR8aHdwb2lzb258bm9kZT0xfHpv
bmU9MnxsYXN0Y3B1cGlkPTB4MWZmZmZmKQ0KICBbMTY0NzguMjA5NDExXSByYXc6IDAwNTdmZmZm
YzA4MDEwMDAgZmZmZmYxMWJjNjA0MmQwOCBmZmZmZjExYmM2MDQyZDA4IDAwMDAwMDAwMDAwMDAw
MDANCiAgWzE2NDc4LjIxMTkyMV0gcmF3OiAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDAwMDAwMDAw
MDAgMDAwMDAwMDFmZmZmZmZmZiAwMDAwMDAwMDAwMDAwMDAwDQogIFsxNjQ3OC4yMTQ0NzNdIHBh
Z2UgZHVtcGVkIGJlY2F1c2U6IGh3cG9pc29uOiB1bmhhbmRsYWJsZSBwYWdlDQogIFsxNjQ3OC4y
MTYzODZdIE1lbW9yeSBmYWlsdXJlOiAweDE4MTBiNDogcmVjb3ZlcnkgYWN0aW9uIGZvciB1bmtu
b3duIHBhZ2U6IElnbm9yZWQNCg0KV2UgY2FuJ3QgaGFuZGxlIGVycm9ycyBvbiBodWdlIChvciBu
b3JtYWwpIHplcm8gcGFnZSwgc28gdGhlIGN1cnJlbnQNCmJlaGF2aW9yIHNlZW1zIHRvIG1lIG1v
cmUgc3VpdGFibGUgdGhhbiAidW5zcGxpdCB0aHAiLg0KDQpPciBpZiB5b3UgaGF2ZSBzb21lIHBy
b2R1Y2VyIHRvIHJlYWNoIHRoZSBmb2xsb3dpbmcgcGF0aCB3aXRoIGh1Z2UgemVybw0KcGFnZSwg
Y291bGQgeW91IHNoYXJlIGl0Pw0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGkNCg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+DQo+IC0tLQ0K
PiAgbW0vbWVtb3J5LWZhaWx1cmUuYyB8IDE0ICsrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS1mYWls
dXJlLmMgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+IGluZGV4IDIzYmZkODA5ZGM4Yy4uYWM2NDky
ZTM2OTc4IDEwMDY0NA0KPiAtLS0gYS9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ICsrKyBiL21tL21l
bW9yeS1mYWlsdXJlLmMNCj4gQEAgLTE3OTIsNiArMTc5MiwyMCBAQCBpbnQgbWVtb3J5X2ZhaWx1
cmUodW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncykNCj4gIAl9DQo+ICANCj4gIAlpZiAoUGFn
ZVRyYW5zSHVnZShocGFnZSkpIHsNCj4gKwkJLyoNCj4gKwkJICogVGhlIG5vbi1scnUgY29tcG91
bmQgbW92YWJsZSBwYWdlcyBjb3VsZCBiZSB0YWtlbiBmb3INCj4gKwkJICogdHJhbnNodWdlIHBh
Z2VzLiBBbHNvIGh1Z2UgemVybyBwYWdlIGNvdWxkIHJlYWNoIGhlcmUNCj4gKwkJICogYW5kIGlm
IHdlIGV2ZXIgdHJ5IHRvIHNwbGl0IGl0LCB0aGUgVk1fQlVHX09OX1BBR0Ugd2lsbA0KPiArCQkg
KiBiZSB0cmlnZ2VyZWQgaW4gc3BsaXRfaHVnZV9wYWdlX3RvX2xpc3QoKS4gU2tpcCB0aGVzZQ0K
PiArCQkgKiBwYWdlcyBieSBjaGVja2luZyBQYWdlTFJVIGJlY2F1c2UgaHVnZSB6ZXJvIHBhZ2Ug
aXNuJ3QNCj4gKwkJICogbHJ1IHBhZ2UgYXMgbm9uLWxydSBjb21wb3VuZCBtb3ZhYmxlIHBhZ2Vz
Lg0KPiArCQkgKi8NCj4gKwkJaWYgKCFQYWdlTFJVKGhwYWdlKSkgew0KPiArCQkJcHV0X3BhZ2Uo
cCk7DQo+ICsJCQlhY3Rpb25fcmVzdWx0KHBmbiwgTUZfTVNHX1VOU1BMSVRfVEhQLCBNRl9JR05P
UkVEKTsNCj4gKwkJCXJlcyA9IC1FQlVTWTsNCj4gKwkJCWdvdG8gdW5sb2NrX211dGV4Ow0KPiAr
CQl9DQo+ICAJCS8qDQo+ICAJCSAqIFRoZSBmbGFnIG11c3QgYmUgc2V0IGFmdGVyIHRoZSByZWZj
b3VudCBpcyBidW1wZWQNCj4gIAkJICogb3RoZXJ3aXNlIGl0IG1heSByYWNlIHdpdGggVEhQIHNw
bGl0Lg0KPiAtLSANCj4gMi4yMy4w
