Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0245511A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiD0NG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbiD0NG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:06:56 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2066.outbound.protection.outlook.com [40.107.114.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B583541A4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXAH9X1iuPyZsM0T1XBWmLxAeO0vwq/0ltC+RPMsCQsWEjsWOlW+47t+aJ/4bFT9tW/X6e1g6tz7Gz9MR53y6Qyv+NqOWb5EN9KNq06tHW8kXYR1/5x9sRuxw0FlA9rqis2PUByNq/iv46cQcIonuKJArDsNfwGmD/vgN3Xgzwuy726gQTbZRk3CoDt6p95QpaLDULQD6wBEld1p1cK8qB0NZPqd/vDvDibmZtJFAILheAlvknVaqjCUUd/AlBJbL9zle079U/SSp5pgPhtCofRUsJHJhWNAAm/HcgAapvn8CGgLQ2i+o1CyEEzhrPkVD3B9oas7NG0U8OE4gSYSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B1COEwcYFY+smuwlF2MXEEl6NdtRUiQErrDe/8iEqo=;
 b=ZjrxP0kT9nUDY6HCqlUsIcCIXya43Wi2SoFBI3NpZ6F3z2QQqRjQG2mNtkSb/yomAQ1Li4xzYxwNLIH3fgGwWX6vtz9FaZNCyAUqRd+WVSpwpU2/OSPNKt47bx80hFWodAMzNj1L4yfh3jSb4Hvf7e/Ecnb5vWW7HNBYzl0owqMVSywCr8CWxYlUUgBN2sEWxL3x5ctbCFJ9eYCrXTGPT66D3x04jOmr6GWbPRUevMiyNxO1OyrgYnBG6/iR+bEcakkASQXGTyMo0Po7BojCiLN7mT3tI+BtBYIfZ1mz97KL5IdHTrWH4T91cOGKWZBHSfgKRh0xUmAYU69Z2FU0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B1COEwcYFY+smuwlF2MXEEl6NdtRUiQErrDe/8iEqo=;
 b=IPbB0ItDktAkJ9L0a/zp0X9iTlpU5kBXPsIKtRD0INpNc3aQyDM9+we6ITB3imynnqH+oBCwuWSrlipJKfkrba/IcPxQfZ0PZIa4mnacZ2J0CwpA8I6Q8zB9iNCYSMjxjbQiqkveQR9anqDXSWg7Qo2aXOZ+5c1WN7R7PkfudzY=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB6416.jpnprd01.prod.outlook.com (2603:1096:400:92::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 13:03:43 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::e58f:5f3b:6d28:b245]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::e58f:5f3b:6d28:b245%4]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 13:03:43 +0000
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
Subject: Re: [RFC PATCH v1 1/4] mm, hwpoison, hugetlb: introduce
 SUBPAGE_INDEX_HWPOISON to save raw error page
Thread-Topic: [RFC PATCH v1 1/4] mm, hwpoison, hugetlb: introduce
 SUBPAGE_INDEX_HWPOISON to save raw error page
Thread-Index: AQHYWe9W9tO6RJGlSkiUGSIFLMrw+60DWCuAgABiZgA=
Date:   Wed, 27 Apr 2022 13:03:43 +0000
Message-ID: <20220427130342.GA3915117@hori.linux.bs1.fc.nec.co.jp>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <20220427042841.678351-2-naoya.horiguchi@linux.dev>
 <5b956156-887b-1d91-7831-28a66db53c6a@huawei.com>
In-Reply-To: <5b956156-887b-1d91-7831-28a66db53c6a@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ceafe5f1-8c19-4c8f-8c0b-08da284e5b4f
x-ms-traffictypediagnostic: TYCPR01MB6416:EE_
x-microsoft-antispam-prvs: <TYCPR01MB6416341F8CFAD445DDD31E97E7FA9@TYCPR01MB6416.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ft9F9YpAA5iRCh3cN8z7dUj52rengpV7uTPUqvzzY/sbsRGPmC9CvP/YjiBEzvEb3xfMUlPF/MSpmlhxiNQekP6lQoyw4vB4xvvQXYJfbTv2P1HKxwHF792dqZ3nbamRbUsytcKfzFWkkvw6AVEdS2S42I8YudwO79XmCovAd04nWXSaNIl1AuJVuMVjP8wS3qHRg1yFHnmwwJRnpHIZKkytbk1yVVbM/RcdiD+o+12UF4wqhQsm0yVENY0OHapt7J4dfdL+bXpJYGqCufycwzbM5Hwx+xZRDwz3oN7ifurCYveEO7Wpt5RjyvqPqTERputk+rAbcBEeTdhB90AAXc0rEsF//oscUD3oea4SsWhsiyscKfShb2UqKY1ugtTSBglZ1Pymyn2xKmnMaI6lHkDzipiQ8dIF01jzvDz98jTWmKEKbsgPLuDk03JFb7HVer8FQV+9gYqkEd/wirMjv0gNFU3A1ZvaiwOkJCbJBly6yAyUmtL5obBJ28+25gR+mkzqqe4b3G88doK/sf7mZ/bGonHSFW92yrzUJGZQMwU9aSWBjzLQsMaYKHNsuqXfSFU0F89zig/E3rkdNF/5JjEg4fF2kpfFVu9AFngNmqwuY0EINumlDIVlzSVOd3WMkdSmnb3o7M0gwlf6tjtkg7M/0+FxWDVtKnFn42NYj53/f3Yntpb1IZ+6o3EFTw88AhlfL7Ak4kA6b5SxNsxyDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(316002)(6512007)(26005)(83380400001)(85182001)(9686003)(86362001)(64756008)(8936002)(55236004)(54906003)(33656002)(6506007)(53546011)(186003)(1076003)(122000001)(6916009)(508600001)(38100700002)(7416002)(2906002)(38070700005)(6486002)(71200400001)(82960400001)(4326008)(8676002)(76116006)(66946007)(66476007)(66556008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFpBQnNZRXorSCtvV3NCV0p1NUpKdFJKRUtvS0dNRHhvWW1Fak9vdHcxVmNi?=
 =?utf-8?B?dngxaDR4M08ySHVaeGRTV2RLSnRsbVpBL0M5VlhLK2N0cHNONHRKMmVkWFRh?=
 =?utf-8?B?d3B4K0x2NFpZVXVyT1JZQlIwdkMrSlJZaHpmN1kvSnRTaXY1Wm5yTGF2cDh2?=
 =?utf-8?B?blk5TElPbERFY0FVRWlFRHN0UHMwZnBrVHM2YlVubFdDL3pObnRoVmJ6ckkz?=
 =?utf-8?B?UmYzbXF6cEpEcGZ5T2NrRnIvcHd1YWhBQm5WSkRGdXdSZWVOUWpEdE1kR1VI?=
 =?utf-8?B?algrN05tbmRxRk1Xc0NCaHFyVGhMUHhjVVltK3Q5R0dZNnFCWDR0Q0pSM1hx?=
 =?utf-8?B?OUZuZVYwRWxkMDA3aE5MbnZ4MlNrUE8ybE9SV1hMUkZXWjBxbnZ6Yi9IazVZ?=
 =?utf-8?B?c2lZSW03NlpXb3FaZ2xlUVBNREpQb04xOURIV1h2dXl6eTdiNzhsbkhEMXRE?=
 =?utf-8?B?UCtrZXNNL1Z5Qm42N0Y0UlBTTDNQM1YyMnRwWnlIUkk2T0JmdzBoU3ZzU3ZW?=
 =?utf-8?B?QzlCZjAva3JpTHRKdDdjcktQNXpKTkMveU9HQWRXanFhYWlsK01yOFdlbTds?=
 =?utf-8?B?di9UYy92cGQ3cUlEYWJMRzRyNG80WStrbE8wL1dHS0piZTAydjFEQTZyc2VV?=
 =?utf-8?B?Mkg5VndibEJTWmhiZUowc1puajB0Qy8zTHluVjYyTjlDeUcxSHR0WHJ5amNC?=
 =?utf-8?B?TjNDWllzN09QUUtvSGFSRlg1NGlUbGJxcE9CWWVGTVV3azI5L09YbnFqeUJi?=
 =?utf-8?B?VXNrOEFjR3pPbVZlNXVRaE9CRTZ3TUxyb1VOQk1IYnJ3QTI5RGZzODZYeGVk?=
 =?utf-8?B?dkxXYno3NXRrN0tSZGY2RzYreE5ZczdjNUU3VmFYNjFRaW84cldrdHdGVHBq?=
 =?utf-8?B?dE8yV2NSaUdCc3N3enJxZGN1WVR5YUJRMkJCcjFsSC9IRnBDQkdKc2JuRVE1?=
 =?utf-8?B?bVZaei92eGppdVhqM3JMOFZyY0lJM0tacWhOWHhjWFlpb0dicDRTU2hHejds?=
 =?utf-8?B?TFIzZWhHSXREcHJRdlk4dkViYko0NnJRUHpXdXhweHdjN1RrYXhLWWlZdjVm?=
 =?utf-8?B?MzZNZHR3cmh1YXR3aGRaR0duby9xcmxrSUN4aFdCWERrUTFxdDB2dmJQK3kx?=
 =?utf-8?B?eDgwL0NjOFRIQ1dUaHRDNFNFbGVqVjZGZlBWbzhPaUM0NTJJbXIrNnF0VGJS?=
 =?utf-8?B?MXhndDJ3eWFjdDd4N3dwYzdVaE9abmtBSndIMG9iMVEzc0xNaXFKcDlseTQ3?=
 =?utf-8?B?SmFxckJrZkQxUkhMRjI2bUxDSzBSSkhCNWVSM2JhQTRIRDZOY1pXT0hSRTUy?=
 =?utf-8?B?elRUcUJoTUUzcHFvajZZZFY2WFFGVXNaVmdHa3JoNEhtbnBod01ITEl1UUZp?=
 =?utf-8?B?alZRNjhMRkdDd0IrM3NoUGUvMDhyU1dXcUVsWWdqejJWalV2RWtZbzdOTDdn?=
 =?utf-8?B?OHU4YWFlaVhrMVg5VHh5VjJTbGZxdVI2aXBaTitnOHpqYTZ4T1RMTHlTdXgy?=
 =?utf-8?B?YzNGR01SbTRyUkRMT0JkMWk1QUNlUXRkcC9WR2ZvWEVxdUIwUlp4dFhSNi9o?=
 =?utf-8?B?S01vV2F5R1dJR3k1Z1R1dXU1cjNQNE8xdy9vUUplSGFETVczQ2dMVmR4ays2?=
 =?utf-8?B?MU8wc0Z5WlNZWDBudy9FNnJiOWdjMUZPTGZBUHk0bjNrREdSQTh2aHZFTWtZ?=
 =?utf-8?B?anlkZUtlUjFjcU9qb3NmZCtuMklwZUp0VHBYN09tb0xCbjZ1OHZtMjJhV1ZV?=
 =?utf-8?B?OUtvd3Fvakl0b1Y1QUVOSUgvcmNWTmtCb3VvMGRsVXBXQkhvcW9EUVhBZzIr?=
 =?utf-8?B?NTJpajYzYSs0V0s4b05Ka2Z2ZWk1UU51T2dWS285TmY5T0lSaTZQODNnZDlK?=
 =?utf-8?B?MnM4NVZ4NGdsd0hWdjY1L1ZDN28vcDRRYTduODhmbmhYSDdrdklsMWZZNUZ4?=
 =?utf-8?B?RWxCanhGNGRDRXI5Z0VCdHUyZ1k1V05KbHlNRlVBWnhKYW8xR0RGYytkUHBK?=
 =?utf-8?B?ejdiSkM1WFREcTNBYzRkTnQ5bzd2b0F4aS92MGVvQXVCditiRGcwaE8veUFJ?=
 =?utf-8?B?aG5JSWNMSmljcG9HVEYwYUs1ejRnUitLbC9LMHJxZnpjNmVXYW9sVHQ2V2Fm?=
 =?utf-8?B?MUUzc2t0RjRJd1VXNTI3SlBUdVNlQ1lxS1k3MDlCL1htOTFiWkdTenZYRnBK?=
 =?utf-8?B?ZWIxVVMwaENRWXR3MjVuWUJLMWJMSE9Wd3NOSG11MGdZVTZvVHZOdGd3ZkZi?=
 =?utf-8?B?WjUxNzRZaEdENTRrNDZVYlNCVEVrQWQycXhic0pLRlhpMHdjOVRVTUdMS05V?=
 =?utf-8?B?Z2xvcUpIVzBjRXQzdFowdXYxZGh6RndGeWVVMW1WOSt2d2tOallRY0RHYURm?=
 =?utf-8?Q?rSMrFqzA7BWiP7JY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA5BFF46E9BE804499C0B7B3452F4D78@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceafe5f1-8c19-4c8f-8c0b-08da284e5b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 13:03:43.0534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNNvatJ7gFS2e7rpPUQC6/rKhXYTLPq1SAXTXH341TAGe/TpzZa995wcmTy4OCjByWDdGDf1B/aPPBbm+A9NXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6416
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBcHIgMjcsIDIwMjIgYXQgMDM6MTE6MzFQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi80LzI3IDEyOjI4LCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gRnJv
bTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiANCj4gPiBX
aGVuIGhhbmRsaW5nIG1lbW9yeSBlcnJvciBvbiBhIGh1Z2V0bGIgcGFnZSwgdGhlIGVycm9yIGhh
bmRsZXIgdHJpZXMgdG8NCj4gPiBkaXNzb2x2ZSBhbmQgdHVybiBpdCBpbnRvIDRrQiBwYWdlcy4g
IElmIGl0J3Mgc3VjY2Vzc2Z1bGx5IGRpc3NvbHZlZCwNCj4gPiBQYWdlSFdQb2lzb24gZmxhZyBp
cyBtb3ZlZCB0byB0aGUgcmF3IGVycm9yIHBhZ2UsIHNvIGJ1dCB0aGF0J3MgYWxsDQo+IA0KPiBz
L3NvIGJ1dC9zby8NCg0KRml4ZWQsIHRoYW5rIHlvdS4NCg0KPiANCj4gPiByaWdodC4gIEhvd2V2
ZXIsIGRpc3NvbHZlIHNvbWV0aW1lcyBmYWlscywgdGhlbiB0aGUgZXJyb3IgcGFnZSBpcyBsZWZ0
DQo+ID4gYXMgaHdwb2lzb25lZCBodWdlcGFnZS4gSXQncyB1c2VmdWwgaWYgd2UgY2FuIHJldHJ5
IHRvIGRpc3NvbHZlIGl0IHRvDQo+ID4gc2F2ZSBoZWFsdGh5IHBhZ2VzLCBidXQgdGhhdCdzIG5v
dCBwb3NzaWJsZSBub3cgYmVjYXVzZSB0aGUgaW5mb3JtYXRpb24NCj4gPiBhYm91dCB3aGVyZSB0
aGUgcmF3IGVycm9yIHBhZ2UgaXMgbG9zdC4NCj4gPiANCj4gPiBVc2UgdGhlIHByaXZhdGUgZmll
bGQgb2YgYSB0YWlsIHBhZ2UgdG8ga2VlcCB0aGF0IGluZm9ybWF0aW9uLiAgVGhlIGNvZGUNCj4g
DQo+IE9ubHkgb25lIHJhdyBlcnJvciBwYWdlIGlzIHNhdmVkIG5vdy4gU2hvdWxkIHRoaXMgYmUg
b2s/IEkgdGhpbmsgc28gYXMgbWVtb3J5DQo+IGZhaWx1cmUgc2hvdWxkIGJlIHJhcmUgYW55d2F5
Pw0KDQpUaGlzIGlzIGEgZ29vZCBwb2ludC4gIEl0IG1pZ2h0IGJlIHJhcmUsIGJ1dCBtYXliZSB3
ZSBuZWVkIHNvbWUgY29uc2lkZXJhdGlvbg0Kb24gaXQuIFNvbWUgaWRlYXMgaW4gbXkgbWluZCBi
ZWxvdyAuLi4NCg0KLSB1c2luZyBzdHJ1Y3QgcGFnZSBvZiBhbGwgc3VicGFnZXMgaXMgbm90IGNv
bXBhdGlibGUgd2l0aCBodWdldGxiX2ZyZWVfdm1lbW1hcCwNCiAgc28gaXQncyBub3QgZGVzaXJh
YmxlLg0KLSBkZWZpbmluZyBhIGxpbmtlZCBsaXN0IHN0YXJ0aW5nIGZyb20gaHBhZ2VbU1VCUEFH
RV9JTkRFWF9IV1BPSVNPTl0ucHJpdmF0ZQ0KICBtaWdodCBiZSBhIHNvbHV0aW9uIHRvIHNhdmUg
dGhlIG11bHRpcGxlIG9mZnNldHMuDQotIGhhY2tpbmcgYml0cyBpbiBocGFnZVtTVUJQQUdFX0lO
REVYX0hXUE9JU09OXS5wcml2YXRlIGZpZWxkIHRvIHNhdmUgb2Zmc2V0DQogIGluZm8gaW4gY29t
cHJlc3NlZCBmb3JtYXQuICBGb3IgZXhhbXBsZSwgZm9yIDJNQiBodWdlcGFnZSB0aGVyZSBjb3Vs
ZCBiZQ0KICA1MTIgb2Zmc2V0IG51bWJlcnMsIHNvIHdlIGNhbiBzYXZlIG9uZSBvZmZzZXQgd2l0
aCA5IGJpdHMgc3ViZmllbGQuDQogIFNvIHdlIGNhbiBzYXZlIHVwdG8gNyBvZmZzZXRzIGluIHRo
ZSBmaWVsZC4gIFRoaXMgaXMgbm90IGZsZXhpYmxlIGFuZA0KICBzdGlsbCBjYW4ndCBoYW5kbGUg
bWFueSBlcnJvcnMuDQotIG1haW50YWluaW5nIGdsb2JhbCBkYXRhIHN0cnVjdHVyZSB0byBzYXZl
IHRoZSBwZm4gb2YgYWxsIGh3cG9pc29uIHBhZ2VzDQogIGluIHRoZSBzeXN0ZW0uIFRoaXMgbWln
aHQgc291bmQgb3ZlcmtpbGxpbmcgZm9yIHRoZSBjdXJyZW50IHB1cnBvc2UsDQogIGJ1dCB0aGlz
IGRhdGEgc3RydWN0dXJlIG1pZ2h0IGJlIGhlbHBmdWwgZm9yIG90aGVyIHB1cnBvc2UsIHNvIGlu
IHRoZSBsb25nDQogIHJ1biBzb21lb25lIG1pZ2h0IGdldCBpbnRlcmVzdGVkIGluIGl0Lg0KDQo+
IA0KPiA+IHBhdGggb2Ygc2hyaW5raW5nIGh1Z2VwYWdlIHBvb2wgdXNlZCB0aGlzIGluZm8gdG8g
dHJ5IGRlbGF5ZWQgZGlzc29sdmUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTmFveWEgSG9y
aWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9s
aW51eC9odWdldGxiLmggfCAyNCArKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgbW0vaHVn
ZXRsYi5jICAgICAgICAgICAgfCAgOSArKysrKysrKysNCj4gPiAgbW0vbWVtb3J5LWZhaWx1cmUu
YyAgICAgfCAgMiArKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKykNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9odWdldGxiLmggYi9pbmNsdWRlL2xp
bnV4L2h1Z2V0bGIuaA0KPiA+IGluZGV4IGFjMmExZDc1OGE4MC4uNjg5ZTY5Y2I1NTZiIDEwMDY0
NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvaHVnZXRsYi5oDQo+ID4gKysrIGIvaW5jbHVkZS9s
aW51eC9odWdldGxiLmgNCj4gPiBAQCAtNDIsNiArNDIsOSBAQCBlbnVtIHsNCj4gPiAgCVNVQlBB
R0VfSU5ERVhfQ0dST1VQLAkJLyogcmV1c2UgcGFnZS0+cHJpdmF0ZSAqLw0KPiA+ICAJU1VCUEFH
RV9JTkRFWF9DR1JPVVBfUlNWRCwJLyogcmV1c2UgcGFnZS0+cHJpdmF0ZSAqLw0KPiA+ICAJX19N
QVhfQ0dST1VQX1NVQlBBR0VfSU5ERVggPSBTVUJQQUdFX0lOREVYX0NHUk9VUF9SU1ZELA0KPiA+
ICsjZW5kaWYNCj4gPiArI2lmZGVmIENPTkZJR19DR1JPVVBfSFVHRVRMQg0KPiA+ICsJU1VCUEFH
RV9JTkRFWF9IV1BPSVNPTiwNCj4gPiAgI2VuZGlmDQo+IA0KPiBEbyB3ZSByZWx5IG9uIHRoZSBD
T05GSUdfQ0dST1VQX0hVR0VUTEIgdG8gc3RvcmUgdGhlIHJhdyBlcnJvciBwYWdlPw0KDQpOby4g
SSBtZWFudCBDT05GSUdfTUVNT1JZX0ZBSUxVUkUuDQojIEkganVzdCBjb3BpZWQgYW5kIHBhc3Rl
ZCB0aGUgI2lmZGVmIGxpbmUganVzdCBhYm92ZSwgYW5kIGZvcmdldCB0byB1cGRhdGUNCiMgdGhl
IENPTkZJR18qIHBhcnQgOigNCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
