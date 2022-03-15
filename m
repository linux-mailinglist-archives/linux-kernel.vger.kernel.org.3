Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615824D9263
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344352AbiCOB7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbiCOB7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:59:48 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB86DED2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/t7yqU95FGzdzs+/UqfdzBufdPjPb7yOaqLMPlm7Kni2A2xnJRXN3BOKkR8gT1vjLMHxzDZseoEZiXTOlQjBV07l4QDWSj9BqUZPDpd1MLsRHxg6LSNu1glnHCtJeRoYcA4imAvDI/S9fmvFHl7/A3wVVCeQnF6WqR0Crwv1bWG3hbWaEdqntQgEH4v0ZCBwPplRoiVoYCg7VfvpWgMVcFsqVwAIDjKPvjBv/0KBO0omaaPMbeVZM4Nhl/ksGKJ4FYfJcYFqOaJIrIWuB8GtYjO03sZl298W4lV3tiAoLsP0ow9Nq+c16ZAK1MPwQTiskmeyvcpaTLO2++q9pa/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eISllaBoQ6N9p8jwlE7brM8m+tu2Z4PiipfZdE8aelU=;
 b=VvCdVBVT+eZ+gyb6hO3nk7Fd5mhdJ0YgMhvMH7P9WdiuZQNmZJMlfgcRi5R042BbjBh/pE5gfzdPG6zpFqVbhXyUHHpGJVIZRpaiuoOTZC0e0kOUblMtxJDT/dptASJ01pivvWlERImQ5L7qxQgKxGHAAWchjpEQghLuKtD6ViEOvcDB/kpr8C1oY/xjg24sxIfLJj15l0M2hgE6gKL4HJ5YhbVbwyJ4/agPvBVvjNp/DDuM80qfPak9DiilbMGuIZdbqDPSa+XtKdFTK8eUwrmeKjPjoc350ytIhnFHQZJEnQMV4d919FpzKYikhZ2eZhRdq2HEIOthjltXprd01Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eISllaBoQ6N9p8jwlE7brM8m+tu2Z4PiipfZdE8aelU=;
 b=TKPx/7bzHEQxdtcVXaVPyjrVe4mBhjskP1zO3bykZyobPbexVmLliGTzL2YkN8OArkDYojL5NfqdUMlWUHv+nmJChcrE81vuzZ2qFVQH95DuH8ALL37ATC1eRsXxTHJ7OBKR2LlPxDgHi/9o4+Zyq1XA5OsHNzLGGJsogf/gmJM=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SI2PR06MB5067.apcprd06.prod.outlook.com (2603:1096:4:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 01:58:30 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 01:58:30 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sched: topology: make cache topology separate from cpu
 topology
Thread-Topic: [PATCH] sched: topology: make cache topology separate from cpu
 topology
Thread-Index: AQHYNH6wtHW6B7ixb027761a5egjaKy4qoqAgACydgyAAHYBAIAAAhW+gAAFIYCAAAqIMIAAJLWAgAWpZBU=
Date:   Tue, 15 Mar 2022 01:58:30 +0000
Message-ID: <SL2PR06MB3082ED191BF8892367A3465EBD109@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
 <CAKfTPtAvbpUUaOqP3gmOT7fLk8-7v70LzBUiQ-vgDvc7ZZujag@mail.gmail.com>
 <SL2PR06MB30828CF9FF2879AFC9DC53D2BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtBM9WBEgP_PpRHNaATvp9FrBeV2NXhg_EAp4xYtBZYCWQ@mail.gmail.com>
 <SL2PR06MB30826C314139509EC4778C1BBD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtA=dy4M2OK+GqvPDo9D8YBZAHbEpM-YPVZEyEUjEJKU5g@mail.gmail.com>
 <SL2PR06MB308268BDF646BFA0FC9A4590BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtCVV_cpBty7xH8Gea8HdjNzfiE3Kd882i7Pffvrv3p1zw@mail.gmail.com>
In-Reply-To: <CAKfTPtCVV_cpBty7xH8Gea8HdjNzfiE3Kd882i7Pffvrv3p1zw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 3dba9f85-a5b2-a444-3692-327db1dfb0c8
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c28c37fe-6959-4caa-b2ea-08da06274dc2
x-ms-traffictypediagnostic: SI2PR06MB5067:EE_
x-microsoft-antispam-prvs: <SI2PR06MB5067E6E9301E4EAE63D21F2ABD109@SI2PR06MB5067.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SUS4y/moFJx2/zuGVa/LM8ltZoufNtKPl8X7jM7eLrnVu3ZF1oLPDYCauNYmaXNXZLl5rvv5ri/wR59juHfGKExgFSOWtwA68WcDmEPS3NJYjiTUc9vxlWPWXZ/ZIMMiQ+0oN7LNxMjWRLxJv8Rqu+qWkV1LXnyxyALlUNgAh0d4mRcvWgaJVwul/s+h+eyxCA5qsq/afZdNtXquYXLnzzNWH/rC2F94V69XJcdM85ZTGdE96siDRQ9OxExKZ4gIuKKNnM6nmUcha8dhY5KaMC57uRZY5Copzwc1/C00p41Ua9gRQLDnef/L4eZdwN9wrkO63zV3jcg70BMT8titSGY4sM5S/PbkMFZV145F+ScGQF9IG+UwFJFaAI8M724LfK56xO9bSG1lhPnD7YCTg4F59WignDzmBFrsXd+bYUECA5vpBYh95zjIgtSFHg+J4bKwlBqAd8KwmucPx5sKh1oRr9WjgNQCRbG0ItiJihV6Ji1sMyXqoYZv4rkP2B/rpwUnag1YGo+ien+w2w/EhzkVhNgB8DOTZt7wIRwVsIdYbVzIUr/Fwx13k+SB68hyWU1HhaJ/ZDSPA4xnKDQNPhILx+7fffvBC9w2PRX2UT8MpwZMi9LpqxoMv6i3Th/IxGfWWqszuzjJXvQfdo7ra8Is9YgzM2JCt+YhrY+OM25t1/11/UwdM5K6io2dTFGT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(2906002)(66446008)(66556008)(85182001)(76116006)(91956017)(64756008)(66946007)(66476007)(52536014)(33656002)(8676002)(4326008)(5660300002)(7416002)(38100700002)(8936002)(6916009)(316002)(54906003)(186003)(26005)(7696005)(9686003)(55016003)(83380400001)(508600001)(6506007)(38070700005)(86362001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmlXMy96NTU4Sk1XbHZRVStuVGkyWmJLcFFBVENCblY5WDlQSUJBbSt1V1BR?=
 =?utf-8?B?MjZqRDQxbHQ0Yk4rSTJ4K0RmWHFoLzAvYXNNaTZvSWtuK25QRXZJZHljbC9h?=
 =?utf-8?B?YjByaTd3eTdYKzc0dGZYby9iS0tJeEFmWStZbE9SeUFCQzBCMFFQZUJmeUhq?=
 =?utf-8?B?bHlPOWdINDVzWGVWeFcrODBoZnhrWlhTQU5HNXcxdGE5WE02Y1JIMG1kbWR5?=
 =?utf-8?B?U0JSeU5pTU9sVnVVMjBvei81OU11MEkrR0NxOVlLc2g5ZzEzeVczUytSMkF2?=
 =?utf-8?B?aWpNRnBnSUQvUUFNSlpEcHJBY1MrMm5oTmZuMGlrQ3B1Z2twazJQa3FrM0JM?=
 =?utf-8?B?U1I1aVBxWDFDYWJjQlhoSkMwa2pidUFEd0tSdFZZdlBhLzR0UXM1ZDJSS2VI?=
 =?utf-8?B?VFpuSGZ3TkplRCsyd3BmY3NRSEg0MHFaVUpUWWxlbHhxQlZqcVloNW1SUXN2?=
 =?utf-8?B?R0VKQi84b1l6V0k3QlFKN2E1ejZVTXpwam5IZ29laVp0Z0QvNUdCUk95ZWU2?=
 =?utf-8?B?VVBJOFZQRjQ1Z1pSaXJwbktyYTliajl1bURNZzJzN2hhajBiU0ExU2pnZHBS?=
 =?utf-8?B?cmdiWGh4cEh3c1Q4K1MvU3NOZFFBcEVBTXZ1c0RFRDNtSHZYU1ZiM0gvdU4y?=
 =?utf-8?B?eHpVRyt5dEdab0dNREJ0bmdnNmNyQTc3Q2MwTURTUmp2ZzNGVjFwcFRCSlhJ?=
 =?utf-8?B?aWZEUzBMQTlPUkRJWTZQUHQrOXJKZldrWHhwZUFId3dyZVUzT0NYL0tlVVhh?=
 =?utf-8?B?VkRqWFZaaWppV2ZvditqMFEyK1lDOEt0WUtmM3hTMitkS2hhR3ltb2M0Nnk5?=
 =?utf-8?B?NTE5TVN5eEMrNkR5NCtRTk9BOC93azZYb0d5L1A3YVQwZXc1SWxSRnQzR0Y1?=
 =?utf-8?B?dzg0LzVvU0lUNzkxVUE2Mkk2NnBtUWFzNEZkWGZTSmorVW85Znk5TCt2bE5q?=
 =?utf-8?B?ZnVCbjJ3L2NtWVY2U3JSTWZnVFVob1ozQVVmOWZvOG50bkp4VFFaelVrRXVa?=
 =?utf-8?B?ZmtZSEVXKzFwditPejVZRkhCSStrSTJUWGFqZ1J1UStqZm1XbWlQTmhXUndF?=
 =?utf-8?B?bHQ1WmFSSzlmMmQ2RHVHbGpsNEpBYW5zOVpJQXdpVElkbFRmZjhxR2k3NWxK?=
 =?utf-8?B?UUdDUDVtVUFUZHc2NHI1Qkl4VnFlUE5lZlJCWnJyRWhnL0V4UEFKQzFadkJq?=
 =?utf-8?B?RU55WXdTN0N5R1IxWVBuVlQzMVdvWXVXRGoxRXFMY0RQUi9jeFEyWXIvWkR0?=
 =?utf-8?B?dE4xbXBsN2V0VFNlVXI2ZTNGakhUV2psWUxNYkhQUlhaVzRDck9GN0lXKzlm?=
 =?utf-8?B?aEZhdEo1SE9DdDY1b29ZWmkwMHhLZ2VyOVJMT2hYUzdnYUJpaGc2eVFNenpW?=
 =?utf-8?B?aW1WekgvL3dZb3NVcHlUd3ZTbFVQS0pGZ1dvZlAyWkwzWkZQSmlGUEVTQTVl?=
 =?utf-8?B?R1ZIQmNDNXZBVVBVVk1NVU0wVXRjS0pzaVRLOGRkYU5tenc3RHgzSnVuZUc2?=
 =?utf-8?B?dEZ0VldDZ05DYjFYL0NsNVV1NU9TdkNYZDdaTnRyQ0dPY2lXRDMzemwyNk5q?=
 =?utf-8?B?eVpFbmhMZG83UUJITEw3ZnRqN0FzSHN5Z3VFemY2czZUNEpmN2dTSnVMa1R3?=
 =?utf-8?B?djNydnE4cTNKaXFTYlpUcGVEYUlucENYbGZ5S2puYzVmWHpoUFZCVGZkbnBs?=
 =?utf-8?B?NmRjKzlvRW50b3hUWVpscFZEenhQaWtwV3grditBQTRnTTNxS1huK2l2MnZ5?=
 =?utf-8?B?d1NBVzU0Y0hGODNMUlRaOVBFaWhXQzVSTlA0cWRNQ2l4RzBRbThUNUdnZ1o2?=
 =?utf-8?B?ckl1U1JzdU1hU1hReWQ1VjEyZ1d6bVZLM2QzNUpLWUh4Q1hjMW9HNjMreStx?=
 =?utf-8?B?d2lnUFJTdWVFLzdNQ2xMaVUvcE11Z0JGbTRybTdadzMyZ1pMb0FUdUV0TFEz?=
 =?utf-8?Q?njfXzs18wLU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28c37fe-6959-4caa-b2ea-08da06274dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 01:58:30.0380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vf47TZZiwRJEoGT2wmHwxC4uOExkPT4NPhYKtmLQ95hkuW6F5Db5lcJVHFx5v6HB0R2hnH1XKambDkxOx0DaWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5067
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+Cj4+Cj4+ID4+Cj4+ID4+Cj4+ID4+ID4+Cj4+ID4+ID4+Cj4+ID4+ID4+ID5PbiBUaHUsIDEw
IE1hciAyMDIyIGF0IDEzOjU5LCBRaW5nIFdhbmcgPHdhbmdxaW5nQHZpdm8uY29tPiB3cm90ZToK
Pj4gPj4gPj4gPj4KPj4gPj4gPj4gPj4gRnJvbTogV2FuZyBRaW5nIDx3YW5ncWluZ0B2aXZvLmNv
bT4KPj4gPj4gPj4gPj4KPj4gPj4gPj4gPj4gU29tZSBhcmNoaXRlY3R1cmVzKGUuZy4gQVJNNjQp
LCBjYWNoZXMgYXJlIGltcGxlbWVudGVkIGJlbG93Ogo+PiA+PiA+PiA+PiBjbHVzdGVyOsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKioqKioqIGNsdXN0ZXIgMCAqKioq
KsKgwqDCoMKgwqAgKioqKioqIGNsdXN0ZXIgMSAqKioqKgo+PiA+PiA+PiA+PiBjb3JlOsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoCAx
wqDCoMKgwqDCoMKgwqDCoMKgIDLCoMKgwqDCoMKgIDPCoMKgwqDCoMKgwqDCoMKgwqAgNMKgwqDC
oMKgwqAgNcKgwqDCoMKgwqDCoMKgwqDCoMKgIDbCoMKgwqDCoMKgIDcKPj4gPj4gPj4gKGFkZCBj
YWNoZSBsZXZlbCAxKcKgwqDCoMKgwqDCoMKgIGMwwqDCoMKgIGMxwqDCoMKgwqDCoMKgwqAgYzLC
oMKgwqAgYzPCoMKgwqDCoMKgwqDCoMKgIGM0wqDCoMKgIGM1wqDCoMKgwqDCoMKgwqDCoCBjNsKg
wqDCoCBjNwo+PiA+PiA+PiA+PiBjYWNoZShMZXZlbG4pOsKgwqDCoMKgwqDCoMKgwqAgKipjYWNo
ZTAqKsKgICoqY2FjaGUxKirCoCAqKmNhY2hlMioqwqAgKipjYWNoZTMqKgo+PiA+PiA+PiAoYWRk
IGNhY2hlIGxldmVsIDMpwqDCoMKgwqDCoMKgwqAgKioqKioqKioqKioqKnNoYXJlIGxldmVsIDMg
Y2FjaGUgKioqKioqKioqKioqKioqCj4+ID4+ID4+ID4+IHNkX2xsY19pZChjdXJyZW50KTrCoMKg
wqDCoCAwwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgIDDCoMKgwqDC
oMKgwqDCoMKgwqAgNMKgwqDCoMKgwqAgNMKgwqDCoMKgwqDCoMKgwqDCoMKgIDTCoMKgwqDCoMKg
IDQKPj4gPj4gPj4gPj4gc2RfbGxjX2lkKHNob3VsZCBiZSk6IDDCoMKgwqDCoMKgIDDCoMKgwqDC
oMKgwqDCoMKgwqAgMsKgwqDCoMKgwqAgMsKgwqDCoMKgwqDCoMKgwqDCoCA0wqDCoMKgwqDCoCA0
wqDCoMKgwqDCoMKgwqDCoMKgwqAgNsKgwqDCoMKgwqAgNgo+PiA+PiA+PiA+Pgo+PiA+PiA+PiBI
ZXJlLCBuIGFsd2F5cyBiZSAyIGluIEFSTTY0LCBidXQgb3RoZXJzIGFyZSBhbHNvIHBvc3NpYmxl
Lgo+PiA+PiA+PiBjb3JlWzAsMV0gZm9ybSBhIGNvbXBsZXgoQVJNVjkpLMKgIHdoaWNoIHNoYXJl
IEwyIGNhY2hlLCBjb3JlWzIsM10gaXMgdGhlIHNhbWUuCj4+ID4+ID4+Cj4+ID4+ID4+ID4+IENh
Y2hlcyBhbmQgY3B1cyBoYXZlIGRpZmZlcmVudCB0b3BvbG9neSwgdGhpcyBjYXVzZXMgY3B1c19z
aGFyZV9jYWNoZSgpCj4+ID4+ID4+ID4+IHJldHVybiB0aGUgd3JvbmcgdmFsdWUsIHdoaWNoIHdp
bGwgYWZmZWN0IHRoZSBDUFUgbG9hZCBiYWxhbmNlLgo+PiA+PiA+PiA+Pgo+PiA+PiA+PiA+V2hh
dCBkb2VzIHlvdXIgY3VycmVudCBzY2hlZHVsZXIgdG9wb2xvZ3nCoCBsb29rIGxpa2U/Cj4+ID4+
ID4+ID4KPj4gPj4gPj4gPkZvciBDUFUgMCB0byAzLCBkbyB5b3UgaGF2ZSB0aGUgYmVsb3cgPwo+
PiA+PiA+PiA+RElFIFswwqDCoMKgwqAgLcKgwqDCoMKgIDNdIFs0LTddCj4+ID4+ID4+ID5NQ8Kg
IFswXSBbMV0gWzJdIFszXQo+PiA+PiA+Pgo+PiA+PiA+PiBUaGUgY3VycmVudCBzY2hlZHVsZXIg
dG9wb2xvZ3kgY29uc2lzdGVudCB3aXRoIENQVSB0b3BvbG9neToKPj4gPj4gPj4gRElFwqAgWzAt
N10KPj4gPj4gPj4gTUPCoCBbMC0zXSBbNC03XcKgIChTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTKQo+
PiA+PiA+PiBNb3N0IEFuZHJvaWQgcGhvbmVzIGhhdmUgdGhpcyB0b3BvbG9neS4KPj4gPj4gPj4g
Pgo+PiA+PiA+PiA+QnV0IHlvdSB3b3VsZCBsaWtlIHNvbWV0aGluZyBsaWtlIGJlbG93IGZvciBj
cHUgMC0xIGluc3RlYWQgPwo+PiA+PiA+PiA+RElFIFswwqDCoMKgwqAgLcKgwqDCoMKgIDNdIFs0
LTddCj4+ID4+ID4+ID5DTFMgWzAgLSAxXSBbMiAtIDNdCj4+ID4+ID4+ID5NQ8KgIFswXSBbMV0K
Pj4gPj4gPj4gPgo+PiA+PiA+PiA+d2l0aCBTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTIG9ubHkgc2V0
IHRvIE1DIGxldmVsID8KPj4gPj4gPj4KPj4gPj4gPj4gV2UgZG9uJ3QgY2hhbmdlIHRoZSBjdXJy
ZW50IHNjaGVkdWxlciB0b3BvbG9neSwgYnV0IHRoZQo+PiA+PiA+PiBjYWNoZSB0b3BvbG9neSBz
aG91bGQgYmUgc2VwYXJhdGVkIGxpa2UgYmVsb3c6Cj4+ID4+ID4KPj4gPj4gPlRoZSBzY2hlZHVs
ZXIgdG9wb2xvZ3kgaXMgbm90IG9ubHkgY3B1IHRvcG9sb2d5IGJ1dCBhIG1peGVkIG9mIGNwdSBh
bmQKPj4gPj4gPmNhY2hlL21lbW9yeSBjYWNoZSB0b3BvbG9neQo+PiA+PiA+Cj4+ID4+ID4+IFsw
LTddwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHNo
YXJlZCBsZXZlbCAzIGNhY2hlICkKPj4gPj4gPj4gWzAtMV0gWzItM11bNC01XVs2LTddwqDCoCAo
c2hhcmVkIGxldmVsIDIgY2FjaGUgKQo+PiA+PiA+Cj4+ID4+ID5TbyB5b3UgZG9uJ3TCoCBib3Ro
ZXIgdGhlIGludGVybWVkaWF0ZSBjbHVzdGVyIGxldmVsIHdoaWNoIGlzIGV2ZW4gc2ltcGxlci4K
Pj4gPj4gPnlvdSBoYXZlIHRvIG1vZGlmeSBnZW5lcmljIGFyY2ggdG9wb2xvZ3kgc28gdGhhdCBj
cHVfY29yZWdyb3VwX21hc2sKPj4gPj4gPnJldHVybnMgdGhlIGNvcnJlY3QgY3B1IG1hc2sgZGly
ZWN0bHkuCj4+ID4+ID4KPj4gPj4gPllvdSB3aWxsIG5vdGljZSBhIGxsY19zaWJsaW5nIGZpZWxk
IHRoYXQgaXMgY3VycmVudGx5IHVzZWQgYnkgYWNwaSBidXQKPj4gPj4gPm5vdCBEVCB0byByZXR1
cm4gbGxjIGNwdSBtYXNrCj4+ID4+ID4KPj4gPj4gY3B1X3RvcG9sb2d5W10ubGxjX3NpYmxpbmcg
ZGVzY3JpYmUgdGhlIGxhc3QgbGV2ZWwgY2FjaGUgb2Ygd2hvbGUgc3lzdGVtLAo+PiA+PiBub3Qg
aW4gdGhlIHNjaGVkX2RvbWFpbi4KPj4gPj4KPj4gPj4gaW4gdGhlIGFib3ZlIGNhY2hlIHRvcG9s
b2d5LCBsbGNfc2libGluZyBpcyAweGZmKFswLTddKSAsIGl0IGRlc2NyaWJlcwo+PiA+Cj4+ID5J
ZiBsbGNfc2libGluZyB3YXMgMHhmZihbMC03XSBvbiB5b3VyIHN5c3RlbSwgeW91IHdvdWxkIGhh
dmUgb25seSBvbmUgbGV2ZWw6Cj4+ID5NQ1swLTddCj4+Cj4+IFNvcnJ5LCBidXQgSSBkb24ndCBn
ZXQgaXQsIHdoeSBsbGNfc2libGluZyB3YXMgMHhmZihbMC03XSBtZWFucyBNQ1swLTddPwo+PiBJ
biBvdXIgc3lzdGVtKEFuZHJvaWQpLCBsbGNfc2libGluZyBpcyBpbmRlZWQgMHhmZihbMC03XSkg
LCBiZWNhdXNlIHRoZXkKPj4gc2hhcmVkIHRoZSBsbGMoTDMpLCBidXQgd2UgYWxzbyBoYXZlIHR3
byBsZXZlbDoKPj4gRElFIFswLTddCj4+IE1DIFswLTNdWzQtNl0KPj4gSXQgbWFrZXMgc2Vuc2Us
IFswLTNdIGFyZSBsaXR0bGUgY29yZXMsIFs0LTddIGFyZSBiaXQgY29yZXMsIHNlIG9ubHkgdXAg
bWlncmF0ZQo+PiB3aGVuIG1pc2ZpdC4gV2Ugd29uJ3QgY2hhbmdlIGl0Lgo+Pgo+PiA+Cj4+ID4+
IHRoZSBMMyBjYWNoZSBzaWJsaW5nLCBidXQgc2RfbGxjX2lkIGRlc2NyaWJlcyB0aGUgbWF4aW11
bSBzaGFyZWQgY2FjaGUKPj4gPj4gaW4gc2QsIHdoaWNoIHNob3VsZCBiZSBbMC0xXSBpbnN0ZWFk
IG9mIFswLTNdLgo+PiA+Cj4+ID5zZF9sbGNfaWQgZGVzY3JpYmVzIHRoZSBsYXN0IHNjaGVkX2Rv
bWFpbiB3aXRoIFNEX1NIQVJFX1BLR19SRVNPVVJDRVMuCj4+ID5JZiB5b3Ugd2FudCBsbGMgdG8g
YmUgWzAtM10gbWFrZSBzdXJlIHRoYXQgdGhlCj4+ID5zY2hlZF9kb21haW5fdG9wb2xvZ3lfbGV2
ZWwgYXJyYXkgcmV0dXJucyB0aGUgY29ycmVjdCBjcHVtYXNrIHdpdGgKPj4gPnRoaXMgZmxhZwo+
Pgo+PiBBY3R1cmVseSwgd2Ugd2FudCBzZF9sbGMgdG8gYmUgWzAtMV0gWzItM10sIGJ1dCBpZiB0
aGUgTUMgZG9tYWluIGRvbid0IGhhdmUKPgo+c2RfbGxjX2lkIHJlZmVycyB0byBhIHNjaGVkdWxl
ciBkb21haW4gYnV0IHlvdXIgcGF0Y2ggYnJlYWtzIHRoaXMgc28KPmlmIHlvdSB3YW50IGEgbGxj
IHRoYXQgcmVmbGVjdHMgdGhpcyB0b3BvOsKgIFswLTFdIFsyLTNdIHlvdSBtdXN0Cj5wcm92aWRl
IGEgc2NoZWRfZG9tYWluIGxldmVsIHdpdGggdGhpcyB0b3BvCgpNYXliZSB3ZSBzaG91bGQgYWRk
IGEgc2hhcmVkLWNhY2hlIGxldmVsKFNDKSwgbGlrZSB3aGF0IENMUyBkb2VzOgoKRElFwqAgWzAt
N10gKHNoYXJlZCBsZXZlbCAzIGNhY2hlLCBTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTKQpNQ8KgIFsw
LTNdIFs0LTddwqAgKG5vdCBTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTKQpDTFMgIChpZiBuZWNlc3Nh
cnkpClNDICAgIFswLTFdWzItM11bNC01XVs2LTddIChzaGFyZWQgbGV2ZWwgMiBjYWNoZSwgU0Rf
U0hBUkVfUEtHX1JFU09VUkNFUykKU01UIChpZiBuZWNlc3NhcnkpCgpTQyBtZWFucyBhIGNvdXBs
ZSBvZiBDUFVzIHdoaWNoIGFyZSBwbGFjZWQgY2xvc2VseSBieSBzaGFyaW5nIAptaWQtbGV2ZWwg
Y2FjaGVzLCBidXQgbm90IGVub3VnaCB0byBiZSBhIGNsdXN0ZXIuCj4KPnNpZGUgcXVlc3Rpb24s
IHdoeSBkb24ndCB5b3Ugd2FudCBsbGMgdG8gYmUgdGhlIEwzIG9uZSA/CgpZZXMsIHdlIHNob3Vs
ZCBzZXQgU0RfU0hBUkVfUEtHX1JFU09VUkNFUyB0byBESUUsIGJ1dCB3ZSBhbHNvIHdhbnQgdG8K
cmVwcmVzZW50IHRoZSBtaWQtbGV2ZWwgY2FjaGVzIHRvIGltcHJvdmUgdGhyb3VnaHB1dC4KClRo
YW5rcywKV2FuZwo+Cj4+IFNEX1NIQVJFX1BLR19SRVNPVVJDRVMgZmxhZywgdGhlIHNkX2xsYyB3
aWxsIGJlIFswXVsxXVsyXVszXS4gSXQncyBub3QgdHJ1ZS4KPgo+VGhlIG9ubHkgZW50cnkgcG9p
bnQgZm9yIGRlc2NyaWJpbmcgdGhlIHNjaGVkdWxlciBkb21haW4gaXMgdGhlCj5zY2hlZF9kb21h
aW5fdG9wb2xvZ3lfbGV2ZWwgYXJyYXkgd2hpY2ggcHJvdmlkZXMgc29tZSBjcHVtYXNrIGFuZCBz
b21lCj5hc3NvY2lhdGVkIGZsYWdzLiBCeSBkZWZhdWx0LCBTRF9TSEFSRV9QS0dfUkVTT1VSQ0VT
IGlzIHNldCBmb3IKPnNjaGVkdWxlciBNQyBsZXZlbCB3aGljaCBpbXBsaWVzIHRoYXQgdGhlIGNw
dXMgc2hhcmVkIHRoZWlyIGNhY2hlLiBJZgo+dGhpcyBpcyBub3QgdGhlIGNhc2UgZm9yIHlvdXIg
c3lzdGVtLCB5b3Ugc2hvdWxkIGVpdGhlciByZW1vdmUgdGhpcwo+ZmxhZyBvciB1cGRhdGUgdGhl
IGNwdW1hc2sgdG8gcmVmbGVjdCB3aGljaCBDUFVzIHJlYWxseSBzaGFyZSB0aGVpcgo+Y2FjaGVz
Lgo+Cj4+Cj4+IFNvIHdlIG11c3Qgc2VwYXJhdGUgc2RfbGxjIGZyb20gc2QgdG9wb2xvZ3ksIG9y
IHRoZSBkZW1hbmQgY2Fubm90IGJlCj4+IG1ldCBpbiBhbnkgY2FzZSB1bmRlciB0aGUgZXhpc3Rp
bmcgbWVjaGFuaXNtLgo+Cj5UaGVyZSBpcyBhIGRlZmF1bHQgYXJyYXkgd2l0aCBESUUsIE1DLCBD
TFMgYW5kIFNNVCBsZXZlbHMgd2l0aAo+U0RfU0hBUkVfUEtHX1JFU09VUkNFUyBzZXQgdXAgdG8g
TUMgd2hpY2ggaXMgY29uc2lkZXJlZCB0byBiZSB0aGUgTExDCj5idXQgYSBkaWZmZXJlbnQgYXJy
YXkgdGhhbiB0aGUgZGVmYXVsdCBvbmUgY2FuIGJlIHByb3ZpZGVkIHdpdGgKPnNldF9zY2hlZF90
b3BvbG9neSgpCj4KPlRoYW5rcwo+VmluY2VudAo+Cj4+Cj4+IFRoYW5rcywKPj4gV2FuZwo+Pg==
