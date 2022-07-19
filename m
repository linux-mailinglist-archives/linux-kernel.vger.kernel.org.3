Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A2A579276
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbiGSFaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbiGSFaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:30:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73D21183E;
        Mon, 18 Jul 2022 22:30:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfLR5ekgQUpxwZ2WUODYdaEa/sZm+9tt8pnvIPKTCVH40edLy4lgM3wmwln8OhlaFhYNByiLGhjiuQMA8iWT1H0tolMRRpo0VRU1n10T3FoDARXotFoSuQESLOipVhJa1quxGAaIWFm9ibeDSw9WaT/T52m9pVMqDLAswYpVBBGZNx0ZUdB23rW+2mr6lqzR3T4x59zvDBYwfUZrEQKVi5wgGhFKZoky7KjYuY5CBTWKK76v5NOsGh8ZDq6bi7taQHnwZ5cJ/SjsgJ+8Z3q1jJ3R2BRM5EQKNpSuEP11i6BZT9rc3WgcH41I5N2KvKoMKDysfTtI5CfkRjDjfFp2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFauMaplh30gvy+Idy57gwytWbQz06MZUwaqbBWcIYE=;
 b=D048+WcutuZsgSiHW6hxg0KsYn4F8JClr1WbtwpcOEyo/7hNLw8p5fQRm+rgYcv/17qmTfdhPFFT6YT2tJReuSXYj+sWHIQumuYILrBKIbEgoT0CZfAIVYmDHZzD4QUlXUu7J3PasplxIxxyxIWIISfYrNQ7H39EDonhxWZsh873NBwI9Iy9mAftAnHWHlfTrX7y6W7NYB5PWjcAJcQrbLty6R2tVojQMQ6hYLayyvoMl8uHg4a7axhmPMOOBboZHKPDSgVqXpTUYERj5vvun4qJlBs8Ybs0LRq7h6WOSw9Cp6R16vRFDjDI0GxTr9M4rzLaPx4H7p6e+8u3D22JcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFauMaplh30gvy+Idy57gwytWbQz06MZUwaqbBWcIYE=;
 b=09IV/ftvqSMbCOje2aPEjdlPmgfzX+ZUpZmj8sLkzEjTxkbgNrNk6S73MNxx1unLW9BILU3++28gN19x7ogV0JYBVz/pOxpEHEOezksSU8toVqO07vewOxa9O/JEwMQJNs8muKDZkRGLCE+UrialuaSy6ZlFW2YAKE7k4k/NDP4=
Received: from SA1PR05MB8311.namprd05.prod.outlook.com (2603:10b6:806:1e2::19)
 by MW4PR05MB8871.namprd05.prod.outlook.com (2603:10b6:303:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.7; Tue, 19 Jul
 2022 05:30:16 +0000
Received: from SA1PR05MB8311.namprd05.prod.outlook.com
 ([fe80::4841:cc3c:63a9:28c2]) by SA1PR05MB8311.namprd05.prod.outlook.com
 ([fe80::4841:cc3c:63a9:28c2%5]) with mapi id 15.20.5458.016; Tue, 19 Jul 2022
 05:30:16 +0000
From:   Ankit Jain <ankitja@vmware.com>
To:     Juri Lelli <juri.lelli@redhat.com>
CC:     "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sharan Turlapati <sturlapati@vmware.com>,
        Him Kalyan Bordoloi <bordoloih@vmware.com>,
        Keerthana Kalyanasundaram <keerthanak@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>
Subject: Re: [PATCH] sched/deadline: Fix BUG_ON condition for deboosted tasks
Thread-Topic: [PATCH] sched/deadline: Fix BUG_ON condition for deboosted tasks
Thread-Index: AQHYlv/naTAeq6v5SkONmwFBTShmLq19eIcAgAFmCICAADGWgIAEtrMAgABYHQCAARRKgA==
Date:   Tue, 19 Jul 2022 05:30:16 +0000
Message-ID: <B466E709-EFCF-4B27-B3F6-D7561C381BF7@vmware.com>
References: <20220713075014.411739-1-juri.lelli@redhat.com>
 <806a86d3-5204-145e-af46-023bf0142aa8@csail.mit.edu>
 <Ys/FiJ3tgc0CYDcu@localhost.localdomain>
 <D5F4086A-AD87-4CCB-B926-25713BBF00ED@vmware.com>
 <YtEbd2WjIOB6nXvr@localhost.localdomain>
 <DC16804A-D429-402E-B076-783B6373D21C@vmware.com>
 <YtVZokpe+l50EpWs@localhost.localdomain>
In-Reply-To: <YtVZokpe+l50EpWs@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d62fc9a-e6de-4c00-005c-08da6947c2fb
x-ms-traffictypediagnostic: MW4PR05MB8871:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TIMxpZvz0SRQATA59HaKbTN7i1DLVfzwqPmI0fkR9KSr+v9oq5snDS7v+jzocZBkNgJowFJmDU6sf6KIodSn/cnKiEY7ys8BCMO/R+rle5rpMurok6g98wOKkpG+8TqYg8YTagIpc0+eVdjSooQaAyQ2Txx/bLaOgby3V29pao3ma2C70UuYhPrriwyAu3CK5Sqp3rI0KaYahw5R4AMw/GnqxbrYOUvYTvdgIfXC0W+LvM2d7AcYVvEYbjlnQkcpA5eZzPTXJT63ywOER6D6U4Pw10NJId9a97ZybUSCRnSNGDPxbz5hokZ6lhWzzDGt8QY5Ja4f6Hsp4SDcxPBzCgYwMqqdHZQelK/HYDjZrhgSabL89leb1cTU/XoqtOGYiT96jD+oIuozxRgFtOAl3NVSvhtO+d0p6dRhBDuBrwQ/i4+3eurl64HOqW3kE39XyjGKuDmbhFxhxKn7kdBBTRyzAZiozSrmys2HRcnnbLP7RVLGQuPWZJgjdJPNt296hRrZk3gWBhHQIS+tXJSIXGvysaOpTX7u+6zsbh790DDAX1GADl4I6UJrjsUIjoHIbDWFRS1jac1hmMbbWG90lU3WsvzCDqc2pDivLvPoobKeCfl8h8tGCldLx4J5T2MIZhpmGFvmsgiCUH6lBoONkDhz2o5N+qu9s7cwO4N5d3y3CbtxdItTdOCUHRHK2JvynW6VT8fzUBjRc7+1eHnQlYvY5ad8hMzErVAZ8q/qPfiun+PXOyY/hn8x5iNkzYbZoz9Bgk272k968hUyjqYgpUmN5XiSnULZVtYVL21fU3ViRyWVJ2uDD0oAFaaui7QLKXV3cy7qg30HTO8wEBd4j2U8Dtlt3eRHdNnAqBd4940r4ye0mRyhh+O4ngF1xHnq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR05MB8311.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(33656002)(5660300002)(36756003)(2906002)(66556008)(8936002)(54906003)(91956017)(66446008)(66476007)(86362001)(316002)(7416002)(76116006)(4326008)(186003)(478600001)(71200400001)(122000001)(6916009)(8676002)(41300700001)(6512007)(38100700002)(26005)(6506007)(83380400001)(107886003)(6486002)(53546011)(2616005)(66946007)(64756008)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THRUUVBCakNQcWZIZkxCT3FHenU2WWZSMHpFMTlqR0ZWZnlwYlkvRUtOaVFH?=
 =?utf-8?B?RWtSeFAwd2VtQWRHNFBabXM1U3FZUEIrZGxtbkdVYzR4ZFcrQUpvODhlZ0Fu?=
 =?utf-8?B?T3lZK2JHUWcwSStwYzRwMVJGa3doQUVTMm9SMTZRRG8zMERVM09lbC96UVVJ?=
 =?utf-8?B?bVFIM3haMCtraTUyeFE5UkxjU3cvcU9FRHVFTDd5K09YeGYwNjEvVmE5akJZ?=
 =?utf-8?B?eEQvelBUZEkwWXNBYytjQ1k1WnludDJxMXc2WXN2NGZjU3FBcjlYRlY2WGdE?=
 =?utf-8?B?N2pab3VTY1lzNzhjdUtNVktYY1laZm9UZ2p2bmdtMW5sZ0M0QXhFdDdsZ0p4?=
 =?utf-8?B?RE9Wa2kxNnlhRnpkRGt4VkJ3NHdvTzRnbHQyMlN5di9MSmw1Z1JPOHdHd2VS?=
 =?utf-8?B?YjIyQWFrbHk2dlBYam5jNnRCZjMxeTJYd1VDN1kvemE0MTlxR2p3QUVzM2VO?=
 =?utf-8?B?YTJrbmQ3UjJHM3RWQXNWWEpnbS81MVBtSEtXZmJvcXJWamdrc0l4SVZsSkxi?=
 =?utf-8?B?cURqTk13YnFVM1NpZXN0bEVxbENkN2VxbU53aG5WN3hKVVJYenhnS1dtYndU?=
 =?utf-8?B?WTc4VFYwK2x4WkE5b1J1ZDFmL0s2ZHhlUElaYVc5TiswMGQzNndvUFp0VzAv?=
 =?utf-8?B?SHBJUldDb2doVXdHV3BaajNDTFNkSU9lVWxPYlQ4NlpZR0lvRWgwS0R3QmhE?=
 =?utf-8?B?VXhvR1ZvTmR3ZjViS29wUFFtZDdjT1YrQVhtRUpVNThaRXFyeUtzMm1jTmFT?=
 =?utf-8?B?alFsVlVmd3hURlZUYlJQWHZndDZQcW1nUEJDUVJYcndiS3JPeFRIQTBoOGtQ?=
 =?utf-8?B?WTB2UGQ5SzVsVW4yVmY0K0VKdi9wZkEyU2tObURGZzhOVjBmS0IzWGM0cHhu?=
 =?utf-8?B?bCtYMVN2aGdUdmJpaGFLUTI4YVNsb21EUEtKTVh6UFRmei90SFNSREc0bnRh?=
 =?utf-8?B?V1R0R0dMMEFFeU52TXdtcmxNb2VzQ3NvNHhXblR2SnBwSnlwMW9RYkZqK0Vl?=
 =?utf-8?B?dEdQcmZ3RU50VTM3dkhLOGFQaUxyS2wxdlNjWkJrL1JvaE1EZXAzRW5hK2RM?=
 =?utf-8?B?elhOdkkvSS9OMStIU2Jqc1BNVjdkT2dPaFlhUUxxZmxMRDBjcEdnUjVkNHAw?=
 =?utf-8?B?Y2ZWdDljeEMzV2hiR2VoWUZhdDVtSmNtcjE1WDJlMzloUkVibHZEeEJJdVgv?=
 =?utf-8?B?LzFzZTdwSThlWnQzZlFBVnFBaFZoYkcvaXNFbVNwNmhsUDBaeDZ6RE1DaS9Y?=
 =?utf-8?B?ZU5GVGg4dUtESG1PSTRldGl2c1RzY09qcmNzWnh6ZjNCcGpYdytoSE9PMEJo?=
 =?utf-8?B?Q2FUWEF4UDcwRWhTNDBpbHJyb0dSM0tYWENMR29LWnFWMWxLd2txRUhTdnRN?=
 =?utf-8?B?VnNXU0RCVmJMS1RDRjB6WkRUSTZzb3ZrSDFVdHFxNzYzQnBDa0JITTRZa21a?=
 =?utf-8?B?NVNsUHpQY3FkSDQvZEQ1ZVhXTGV1VzhJREdwR1ZrTUc2bEliR0hzTHdCZGFy?=
 =?utf-8?B?NlNPZDN4Q0NTOUxUWkhsVm5vRy9YQ3hiTUdaKzNNZU9aWVgwWXA5YzhSZUZY?=
 =?utf-8?B?ZU1GRVRMallBbFB4Yys4Y0dwcmt4a2dYK1RmNCtnaDQySTVPOFhVdm8wUjIz?=
 =?utf-8?B?K29rUXcyYUJtRVhXd2hyRXU5Rks1L0RtRURyZ2t5cDVvUGNER1ZteFB1dGF3?=
 =?utf-8?B?bzhJN0lYMUxtSElPWkZDbzFkM0ZlWkgrMmM3MnJUd0llanRJdVNONWhUcGN3?=
 =?utf-8?B?SDZIQ0dWTWYyV1FBcTJmYjVUZm9VcEI3WUFNMElDWkFJcStQUjlOWnJpcW9m?=
 =?utf-8?B?OWgwcWhiYWRiVno4VlNXMjdMTFVpS2FKL3ZrZ2MyZVJ5TnFFeXZhMjF0UUtv?=
 =?utf-8?B?Y014NVlPdjFRWGdHVWNkSTRGTlA4WDVmV2NYbmdIdFowblZ1VGxGQ3dNVTlT?=
 =?utf-8?B?WmRZTEgxaGRuYzdyQ3hPUTJ2WW96OUg5dlR5bkI1azlhcEkyNlRMbVZLNy9H?=
 =?utf-8?B?bXdrdklQb3ZldkEvV0dyYW5UMVgrTkIvZ0VSNXdrb3BPaWVubWo1NTVnK210?=
 =?utf-8?B?cFN6aTNmRmlWalFsOUpOYWxjQjMyWlRNSlNqMjhEdzFLSkxxb0FFSlV6Qldo?=
 =?utf-8?Q?wVaaW/eT2ai+AC8NMKjV4e4R/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7752B1519133534199198A4B0EDEA8ED@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR05MB8311.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d62fc9a-e6de-4c00-005c-08da6947c2fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 05:30:16.0545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RpPufMBIxJv4Bp2wD1XymB43hC282lCWdy1bmJ0X6abjBd83kkaSZTpU+fp02k58VZYpl67WDmOvSxobjBlrLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8871
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMTgtSnVsLTIwMjIsIGF0IDY6MzEgUE0sIEp1cmkgTGVsbGkgPGp1cmkubGVsbGlA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiDimqAgRXh0ZXJuYWwgRW1haWwNCj4gDQo+IE9uIDE4
LzA3LzIyIDA3OjQ2LCBBbmtpdCBKYWluIHdyb3RlOg0KPiANCj4gLi4uDQo+IA0KPj4gSGkgSnVy
aSwNCj4+IA0KPj4gQWN0dWFsbHksIHdoaWxlIHRlc3RpbmcgSSBhbHJlYWR5IGluY2x1ZGVkIGJl
bG93IGNvbW1pdHMgaW4gNC4xOS1ydCA6DQo+PiANCj4+IGZlZmYyZTY1ZWZkOGQ4NGNmODMxNjY4
ZTE4MmIyY2U3M2M2MDRiYmIgKHNjaGVkL2RlYWRsaW5lOiBVbnRocm90dGxlIFBJIGJvb3N0ZWQg
dGhyZWFkcyB3aGlsZQ0KPj4gZW5xdWV1aW5nKQ0KPj4gNDZmY2M0YjAwYzNjY2E4YWRiOWI3Yzlh
ZmRkNDk5ZjY0ZTQyNzEzNSAoc2NoZWQvZGVhZGxpbmU6IEZpeCBzdGFsZSB0aHJvdHRsaW5nIG9u
IGRlLS9ib29zdGVkIHRhc2tzKQ0KPj4gMjI3OWY1NDBlYTdkMDVmMjJkMmYwYzQyMjQzMTkzMzAy
Mjg1ODZiYyAoc2NoZWQvZGVhZGxpbmU6IEZpeCBwcmlvcml0eSBpbmhlcml0YW5jZSB3aXRoIG11
bHRpcGxlKQ0KPj4gMGUzODcyNDk5ZGUxYTEyMzBjZWY1MjIxNjA3ZDcxYWEwOTI2NGJkNSAoa2Vy
bmVsL3NjaGVkOiBSZW1vdmUgZGxfYm9vc3RlZCBmbGFnIGNvbW1lbnQpDQo+IA0KPiBJbnRlcmVz
dGluZy4NCj4gDQo+IElzIHRoZSB3b3JrbG9hZCB5b3UgYXJlIHVzaW5nIHRvIHRlc3QgdGhpcyBl
YXNpbHkgcmVwcm9kdWNpYmxlPyBJJ2QgbGlrZQ0KPiB0byB0cnkgdGhhdCBvdXQgb24gbXkgZW5k
IHRvIGNoZWNrIGlmIEkgc2VlIHRoZSBzYW1lIChvZiBjb3Vyc2UgdGhlDQo+IGlzc3VlIEkgd2Fz
IHdvcmtpbmcgb24gZ29lcyBhd2F5IHdpdGggbXkgZml4IDopLg0KPiANCj4gQmVzdCwNCj4gSnVy
aQ0KPiANCg0KSGkgSnVyaSwNCg0KVGhlIHRlc3Qgd2l0aCB3aGljaCBpIGFtIGFibGUgdG8gaGl0
IHRoZSBpc3N1ZSBpcyBhcyBmb2xsb3dzOg0KCeKAoiBTY2hlZHVsZSBTQ0hFRF9GSUZPLzU1IChz
Y2hlZF9wcmlvcml0eSA9IDU1KSB0YXNrcyBydW5uaW5nIGluZmluaXRlIGxvb3Agb24gYWxsIGlz
b2xhdGVkIGNvcmVzLg0KCeKAoiBzcHdhbiAzMC00MCBkb2NrZXIgY29udGFpbmVycyBpbiBsb29w
IChkb2NrZXIgbG9hZCAsIGRvY2tlciBydW4pDQoJ4oCiIEltbWVkaWF0ZWx5IGFmdGVyIHRoYXQg
c2NoZWR1bGUgU0NIRURfRklGTy81NSAoc2NoZWRfcHJpb3JpdHkgPSA1NSkgdGFza3MgcnVubmlu
ZyBpbmZpbml0ZSBsb29wIG9uIGFsbCBpc29sYXRlZCBjb3JlcyBhZ2Fpbi4NCgnigKIgQlVHX09O
IGdldHMgaGl0IGFsbW9zdCBldmVyeSB0aW1lLg0KU3lzdGVtIGNvbmZpZyBhcyBmb2xsb3dzOg0K
CeKAoiA0LjE5LXJ0IGtlcm5lbA0KCeKAoiA0MCBjcHUgKDAtMSBob3VzZWtlZXBpbmcsIDItMzkg
aXNvbCBjcHVzKQ0KCeKAoiBzdGFsbGQtMS4zLjAgd2l0aCB0aGUgZml4ZXMgZnJvbSBsYXRlc3Qg
dmVyc2lvbiAoZm9yIHRhc2sgc3RhcnZhdGlvbiBhdm9pZGFuY2UpLCAidHVuZWQiIHdpdGggcmVh
bC10aW1lIHByb2ZpbGUgDQoNClRoYW5rcy4NCg0K
