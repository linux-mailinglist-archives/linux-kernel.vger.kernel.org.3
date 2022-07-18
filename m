Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C518D577CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiGRHqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiGRHqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:46:06 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-bgr052101064013.outbound.protection.outlook.com [52.101.64.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B644BF5C;
        Mon, 18 Jul 2022 00:46:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2SZI1P0BfX9wKyBm/0/zMeyutuqBo/PfOYyxM8+BV+MoKJ6BiQL3GGHriexWybjUAyOMmFALKrQUcHGrQ04fKrklVVXOnbB0XsNafiDAYlsfCXGm9m0u1ZFuNxlLstWTvzdC64ncmj5vbscGrBlIgDHAtaDZEeDIfRyVLgr9POa5z4kkWAT/0vYNHILh+UEaS5qw0LH7gJBRDZXrrbHmUs65uteliW7FlDvyCM+oWASZy9EIQ0CbUUjsUixe5g/WPKaPLS+f3GqHPsr2K4q/dZeOI2VzE/aRBt6jWH/Jbk5wPqMwZFgJvUBj1alhrcEtCgTG2o1BksiTYQrCEsSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8DzEViN92BWFWy7MVKiqiKrLpUtSvFuCM9hCtuHAYY=;
 b=Mt2YjEn18M/qI473hmafyl4OwOjEAaQvRkQVgBXYrpfTJDEsZp3Z7WW/xTelgs75Xf0ICK7+cP4cPOOfOpsnNmTMnhefeZR03yoy/UHXG55umSHYI6+i8oFgoxyru6ww9D+IGtrPU4qZKR26OEt+OwbR9mmaXmh9VpRrBpRTrnlLQBJzFV69fTk9I+8IAhvsYTg9AP1UoXoyI3tLUbaJr4Ogb2YloqukKKvs2yRsYRxjOjPSk5CLeYjULonpLngWmx13dZ5jZoiHfCcF4X1BNtxpAZhTynOab6xFXkl4v46vsX1bNclQVXf7F+vurFXwpPeKdB6j5cYQRwVx0oO6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8DzEViN92BWFWy7MVKiqiKrLpUtSvFuCM9hCtuHAYY=;
 b=yxUwvCvpJlD8Otq3OtMYod1MDMvHc4fm54JzejytwRo1Y+MuwiWYA2eEa15YAhe/ZvlLN1447AkR3XRucimeX+O8LVvbRTtH5/UcIet5yc62T++CjBIUQDhKm9Qzdoa5hvBKxyANt/BaXq/whtWcEX+GR683rj+XYFMg+/3AK6I=
Received: from SA1PR05MB8311.namprd05.prod.outlook.com (2603:10b6:806:1e2::19)
 by DM5PR05MB3497.namprd05.prod.outlook.com (2603:10b6:4:44::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.16; Mon, 18 Jul
 2022 07:46:01 +0000
Received: from SA1PR05MB8311.namprd05.prod.outlook.com
 ([fe80::4841:cc3c:63a9:28c2]) by SA1PR05MB8311.namprd05.prod.outlook.com
 ([fe80::4841:cc3c:63a9:28c2%5]) with mapi id 15.20.5458.015; Mon, 18 Jul 2022
 07:46:01 +0000
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
Thread-Index: AQHYlv/naTAeq6v5SkONmwFBTShmLq19eIcAgAFmCICAADGWgIAEtrMA
Date:   Mon, 18 Jul 2022 07:46:01 +0000
Message-ID: <DC16804A-D429-402E-B076-783B6373D21C@vmware.com>
References: <20220713075014.411739-1-juri.lelli@redhat.com>
 <806a86d3-5204-145e-af46-023bf0142aa8@csail.mit.edu>
 <Ys/FiJ3tgc0CYDcu@localhost.localdomain>
 <D5F4086A-AD87-4CCB-B926-25713BBF00ED@vmware.com>
 <YtEbd2WjIOB6nXvr@localhost.localdomain>
In-Reply-To: <YtEbd2WjIOB6nXvr@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1aea305e-ecff-4f16-6ecc-08da68918f6e
x-ms-traffictypediagnostic: DM5PR05MB3497:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Kjwx8AEF5bRiWLE1ZT5QijdjepEYY8CeCKerIxMQ1Bz9GV/pUvmYYkojnZ/Pv2ddASlacOWiEwkK4tbeRjLVEcoqLQBG3FV+VXUe0Qhysemj23i7viG+Ba6tTyKvNctTCw+Y4haj6a0rjdILCoEZqPdPkWY2gBqpeolMJ5mFkCraROirrZESQuNcI4CspxEdksZ53cQAVe3HX4zNjYfy80Rw5KVNrCECPwTrz/khZ2VDAO4JHBb52K7/iL2NXARl4ij5nAngPOyKMwxl4ZVhwHbDBL6OMTa6vY3o03wIo59Qk1M95u3yAVNYix3Ct1X2Gghl2c5hznFQvcQ/YW9c5MXrZa3AXXI844R3PIFeXvg5JkU0t1K0fm+QK1HkjPm4fMuTjNN492dsNWF2ODNju7vNINzI6G0YdgqPhLNluTA5oaVSM5qwBh/vTUrrnsgkMH/TNf4FVxuhHA+Dl16ZcQY/s72HZ9+y/k3EDhFYzCbmEJErlSEx5/ZGxFcu0bRSQwgJqpZ8BHwvGZjuu6Km7KiPL42AKmHNpqvrghhMb9cM1uxPSkKNtl3rEGStnwsHCY995yLedlSiaf/zFrn2PJL4PHvTIaftGJIHDANoOpGUemjyt3Jc/lVpReXM/Qjs1leUzQjxl0vDM8F5iKMKKMRwuyZQ6jF9+FXPIsPlob+H2xXbXIUqNEMpXqjFETmzjJVniaiILA7Jt4ZmUnkybZ+MGSY+gcexJMDNaqsuRnNzj15+avsCo7YssBiyur+hoBHdYL+cHqJM456SGN4xRWs6RdD18ah2aIxFPt3jc5JvkGOovjhmlEf/dIAV8O5bkhCsfKljb78lfML0J0dIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR05MB8311.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(7416002)(8936002)(5660300002)(66946007)(66556008)(66476007)(8676002)(4326008)(64756008)(66446008)(76116006)(33656002)(38100700002)(122000001)(2906002)(36756003)(38070700005)(71200400001)(45080400002)(6486002)(478600001)(54906003)(91956017)(6916009)(316002)(186003)(53546011)(107886003)(41300700001)(83380400001)(6506007)(26005)(2616005)(6512007)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzRwOUlrbGdLSUxrSlNhWGZRYVRSYmpMMlhCb29pN3RPTDlIU2JrS3NNVE9G?=
 =?utf-8?B?cmhxZjNqMFkzckNWNnp5dDlzOTk3U0RpRVhTdUVLOGlkYStwcGZFOHlsbmVz?=
 =?utf-8?B?QmN5ZGNGTXVHUjdsN29mZEZXbWJoTHVPUWJuOG1QdWtMSk9oK0hNV0NrL2Nt?=
 =?utf-8?B?ZEVIRTJJNnZyN2tRVEFwNEhSdkFHL3gyMld4WmxCNzVmaUdhNDBTUWhKODhD?=
 =?utf-8?B?aXMwSWIzMGgrcTZkYUdlcXNJdDlYT0JIbUJmRUlLL0hqT0EvL2ZEaWlncGhu?=
 =?utf-8?B?OEZKVXlTNCtEbnk4SEpjYjBHRk42YVZmMWtzVHloOThPUmU0VDdFUG9rbm1l?=
 =?utf-8?B?Q2pZaXc2S040bkFJc2RmL0tvV3lHOEhEU0RSUjUybjNIY3lJQWRQMmhOVEdq?=
 =?utf-8?B?aW9PaFZyd3lHekc2aGQ5azlTVVA5WEZYTEF6VTFjOEJvQkRnY25kUzc3TVE5?=
 =?utf-8?B?b013aUdMZXJKQXNaSElTMmdleHk2NnFmSFFsam9jNmc0blk0L2NYVWVUb0J4?=
 =?utf-8?B?RU16SXZScm1MMnhNMFJtcDAvTkQvSWUvb2ZPSnk3Q0RMQVVoS1ZIRysvYzV6?=
 =?utf-8?B?VEwzOU1vYUJMZExFOUkwcDVNa3phaDhYK2IvRUdrcjd5Rks0enJ5VFBJYXpx?=
 =?utf-8?B?eFp2UTI5TGJmUit0NG9XWmYxUitjRllBYXlkOW8zekJZRDliU2JQR2NRVjk4?=
 =?utf-8?B?a1VuWEo5Rm0xTmFLM0lpRVN4NFZ5QUl4eUV6RmZnUzVsWEhFSnF2d3M2Smtp?=
 =?utf-8?B?NTVGSXo3eHdBaUZ5TSs5dURiTFR6a09VT0RLU0pDbG5OeURIM3NZRHZLZlhy?=
 =?utf-8?B?T2dTbzdCMDh1U09yaWg0aXlnay84VXNac1hQdXNycDNNWFQ1MjF0TkF3cU01?=
 =?utf-8?B?VmxuMWNqL2hhRGRkOVBkd01yZ3ZXWWt2eDQxYnYwRC9rWkhLYVZpTFRTdUNJ?=
 =?utf-8?B?MzJQYWV1RUlXRUp5ZmRKaG9ZaE80NEhyOHFFOE5HZkxJaytlenhHMElZSUtN?=
 =?utf-8?B?Y2huQ2hlck8vSjU5UFlBNzcvY2FVNkRZck90dWRUam13WE0zbjNZN0RRTFFH?=
 =?utf-8?B?VW5BZ3g2MklmVVd5bEYzVGcxMGQ3SGx5YVpvL1ArR1VVQUV2bklUTElCdXo4?=
 =?utf-8?B?aDZIWm9EdWRhVEVGcit2cStkK29EVDQxcWw2cmZGdWN3RHlvczF2Mktmc1Ex?=
 =?utf-8?B?MUJyWXltWklvaEhud0tyeGpTMkFlb1BrUVFoVUZCa0tIOStyamVaamthQmpv?=
 =?utf-8?B?dHJaWTRqNTAwTU4yNWhxelUvTGovVEppV3UvamRHY3Rlbk1mVms4UFJhOGNH?=
 =?utf-8?B?dlFsb3IybTFoTWNFakZZZ1dhL0pyNGoyZWJMTzY4d291Y21YaXdyWVNRdGMy?=
 =?utf-8?B?MTNYYzlMeVlycFNtSCtqWkloLytLU2JITitmTUlmdWhxTHprUmJzMjgrVGVZ?=
 =?utf-8?B?ZDhYM1NlS1pzUGhXL3prbHIwQU5DN2drYUtzcG9pcld3K1ZTNi94QVJSdUJx?=
 =?utf-8?B?TWgzV2t1bzBFdHBpS3IycmFyUHNSR0xOSXZ5c2JVMmtwY0F6ek5xTnNIR1lj?=
 =?utf-8?B?V1k3QlZjc09jSmpyUkxmYzJhSXpUSG9pK09odm1MbFJtc3o2OHl1a0xmYURq?=
 =?utf-8?B?WmRIMjlFQkpIUUsySHBHNTdpc1ZJYnhRM3dTMllXaUoyeTlsSDF4ejd4aFFq?=
 =?utf-8?B?TTUzQ0trQURlM29BZXMyTncyVjZQOUJZZHM4Rlk5R24zUVRxK2h6Nkh6ZzUy?=
 =?utf-8?B?MkgrNmY2aVFLbmVKbGJCamNDWkJHcnJOMXJBRzRhRDZlakhzUmM0YXRzblJM?=
 =?utf-8?B?TWJVbE05YWMxM1dPWUtoQ3JGcGthN0NlaDl1MFZPMGtVU1ZESVZKWmNaMXcy?=
 =?utf-8?B?NDEwUytQckhOVUVMaS9OM2FseWxKOGROSWw3VjdqUlNlQVN3VHVZZG05UGhw?=
 =?utf-8?B?RTVrek1iV0RqaVNKcGNxNS9wWCs5a2NWTzdJNExoczRPdHlSRzJsdWRrL1Jj?=
 =?utf-8?B?emlrVmxzWjhJRlZ5UE9YaGlzL2d4ejd5b29RTlRJUktITFpoN1NHaEtBQjIx?=
 =?utf-8?B?T0RtY0pZOXljc2NRN0tiQURoNVh3TGZtQk1XbEFYVldUWlZhWGRaWEtLb2Fl?=
 =?utf-8?Q?YBOaoaWbwdybBg0uCmTL0z0+x?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EAC49F4871EAE43B1B16D503567A8D5@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR05MB8311.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aea305e-ecff-4f16-6ecc-08da68918f6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 07:46:01.1803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVA9jNYGjz+OnQ9+1g0FLAmJ/YkmmHmuYaWHGKlAaf1on8MA6Y5r3BKi4RvR6rP/APfSuNCpquTC4IWw0aw6PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR05MB3497
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMTUtSnVsLTIwMjIsIGF0IDE6MTcgUE0sIEp1cmkgTGVsbGkgPGp1cmkubGVsbGlA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiDimqAgRXh0ZXJuYWwgRW1haWwNCj4gDQo+IEhpLA0K
PiANCj4gT24gMTUvMDcvMjIgMDQ6NDksIEFua2l0IEphaW4gd3JvdGU6DQo+IA0KPiBbLi4uXQ0K
PiANCj4+IEhpIEp1cmksDQo+PiANCj4+IEkgdHJpZWQgdGhlIHBhdGNoIGJ1dCBpdCBzdGlsbCBo
aXQgdGhlIEJVR19PTi4NCj4+IA0KPj4gWyAgMTYzLjA5NDA5NF0gLS0tLS0tLS0tLS0tWyBjdXQg
aGVyZSBdLS0tLS0tLS0tLS0tDQo+PiBbICAxNjMuMDk0MDk1XSBrZXJuZWwgQlVHIGF0IGtlcm5l
bC9zY2hlZC9kZWFkbGluZS5jOjE1MjUhDQo+PiBbICAxNjMuMDk0MTAzXSBpbnZhbGlkIG9wY29k
ZTogMDAwMCBbIzFdIFBSRUVNUFQgU01QIFBUSQ0KPj4gWyAgMTYzLjA5NDEwNV0gQ1BVOiAwIFBJ
RDogNTQ5NCBDb21tOiBzdGFsbGQvMzQgTm90IHRhaW50ZWQgNC4xOS4yNDctcnQxMDgtMTAucGgz
LXJ0ICMxLXBob3Rvbg0KPj4gWyAgMTYzLjA5NDEwN10gSGFyZHdhcmUgbmFtZTogVk13YXJlLCBJ
bmMuIFZNd2FyZSBWaXJ0dWFsIFBsYXRmb3JtLzQ0MEJYIERlc2t0b3AgUmVmZXJlbmNlIFBsYXRm
b3JtLCBCSU9TIDYuMDAgMDcvMDMvMjAxOA0KPj4gWyAgMTYzLjA5NDExM10gUklQOiAwMDEwOmVu
cXVldWVfdGFza19kbCsweDM1ZC8weDlkMA0KPj4gWyAgMTYzLjA5NDExNV0gQ29kZTogODMgYzQg
MTAgNWIgNDEgNWMgNDEgNWQgNDEgNWUgNDEgNWYgNWQgYzMgOGIgNTYgNzQgODUgZDIgMGYgODgg
OTEgZmQgZmYgZmYgODAgYTYgMGMgMDMgMDAgMDAgZmUgNDEgODMgZTUgMjAgMGYgODUNCj4+IFsg
IDE2My4wOTQxMTZdIFJTUDogMDAxODpmZmZmOWI5Mjg2NTM3ZTQwIEVGTEFHUzogMDAwMTAwNDYN
Cj4+IFsgIDE2My4wOTQxMThdIFJBWDogZmZmZmZmZmY4NDBiZGVkMCBSQlg6IGZmZmY4ZGRhMDdj
NDgwMDAgUkNYOiAwMDAwMDAwMDAwMDAyMDAwDQo+PiBbICAxNjMuMDk0MTE5XSBSRFg6IDAwMDAw
MDAwMDAwMDAwNzggUlNJOiBmZmZmOGRkYTA3YzQ4MDAwIFJESTogZmZmZjhkZGRiNzlhODdjMA0K
Pj4gWyAgMTYzLjA5NDEyMF0gUkJQOiBmZmZmOWI5Mjg2NTM3ZTc4IFIwODogMDAwMDAwMDAwMDAw
MDAwMCBSMDk6IDAwMDAwMDAwMDAwMDAwN2YNCj4+IFsgIDE2My4wOTQxMjFdIFIxMDogZmZmZjli
OTI4NjUzN2U2OCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiBmZmZmOWI5Mjg2NTM3ZWYwDQo+
PiBbICAxNjMuMDk0MTIxXSBSMTM6IDAwMDAwMDAwMDAwMDAwMDAgUjE0OiBmZmZmOGRkZGI3OWE4
N2MwIFIxNTogZmZmZjhkZGEwN2M0ODJiOA0KPj4gWyAgMTYzLjA5NDEyM10gRlM6ICAwMDAwN2Y4
MWEyN2U0NzAwKDAwMDApIEdTOmZmZmY4ZGRiYjc2MDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAw
MDAwMDAwMA0KPj4gWyAgMTYzLjA5NDEyNF0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENS
MDogMDAwMDAwMDA4MDA1MDAzMw0KPj4gWyAgMTYzLjA5NDEyNV0gQ1IyOiAwMDAwN2Y4NWU2Y2Zj
NGMwIENSMzogMDAwMDAwMDIzMzc0NDAwNCBDUjQ6IDAwMDAwMDAwMDA3NjA2YjANCj4+IFsgIDE2
My4wOTQxNzZdIERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIy
OiAwMDAwMDAwMDAwMDAwMDAwDQo+PiBbICAxNjMuMDk0MTc3XSBEUjM6IDAwMDAwMDAwMDAwMDAw
MDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMA0KPj4gWyAgMTYz
LjA5NDE3N10gUEtSVTogNTU1NTU1NTQNCj4+IFsgIDE2My4wOTQxNzhdIENhbGwgVHJhY2U6DQo+
PiBbICAxNjMuMDk0MTgzXSAgPyBkZXF1ZXVlX3Rhc2tfZGwrMHgzOC8weDFkMA0KPj4gWyAgMTYz
LjA5NDE4OF0gIF9fc2NoZWRfc2V0c2NoZWR1bGVyKzB4MmUyLzB4OGUwDQo+PiBbICAxNjMuMDk0
MTkxXSAgX194NjRfc3lzX3NjaGVkX3NldGF0dHIrMHg3NC8weGIwDQo+PiBbICAxNjMuMDk0MTk0
XSAgZG9fc3lzY2FsbF82NCsweDYwLzB4MWIwDQo+PiBbICAxNjMuMDk0MjAwXSAgZW50cnlfU1lT
Q0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhOQ0KPj4gWyAgMTYzLjA5NDIwMV0gUklQOiAw
MDMzOjB4N2Y4MWI2ZmZlMzE5DQo+PiBbICAxNjMuMDk0MjAyXSBDb2RlOiAwMCBmMyBjMyA2NiAy
ZSAwZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCAwZiAxZiA0MCAwMCA0OCA4OSBmOCA0OCA4OSBmNyA0
OCA4OSBkNiA0OCA4OSBjYSA0ZCA4OSBjMiA0ZCA4OSBjOCA0YyA4YiA0Yw0KPj4gWyAgMTYzLjA5
NDIwM10gUlNQOiAwMDJiOjAwMDA3ZjgxYTI3ZTNlMjggRUZMQUdTOiAwMDAwMDIwNiBPUklHX1JB
WDogMDAwMDAwMDAwMDAwMDEzYQ0KPj4gWyAgMTYzLjA5NDIwNV0gUkFYOiBmZmZmZmZmZmZmZmZm
ZmRhIFJCWDogMDAwMDAwMDAwMDAwMTUwYSBSQ1g6IDAwMDA3ZjgxYjZmZmUzMTkNCj4+IFsgIDE2
My4wOTQyMDVdIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDA3ZjgxYTI3ZTNlNTAgUkRJ
OiAwMDAwMDAwMDAwMDAxNTBhDQo+PiBbICAxNjMuMDk0MjA2XSBSQlA6IDAwMDAwMDAwMDAwMDE1
MGEgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAzMA0KPj4gWyAgMTYz
LjA5NDIwN10gUjEwOiAwMDAwN2Y4MGYwMDAyMDkwIFIxMTogMDAwMDAwMDAwMDAwMDIwNiBSMTI6
IDAwMDA1NTYzMDZkZTdhMjANCj4+IFsgIDE2My4wOTQyMDhdIFIxMzogMDAwMDAwMDAwMDAwMDAw
MiBSMTQ6IDAwMDA1NTYzMDZiYTM1NzAgUjE1OiAwMDAwN2Y4MWEyN2U0NzAwDQo+PiBbICAxNjMu
MDk0MjEwXSBNb2R1bGVzIGxpbmtlZCBpbjogaXB0X01BU1FVRVJBREUgbmZfY29ubnRyYWNrX25l
dGxpbmsgbmZuZXRsaW5rIHhmcm1fdXNlciB4ZnJtX2FsZ28geHRfYWRkcnR5cGUgYnJfbmV0Zmls
dGVyIGJyaWRnZSBzdHANCj4+IFsgIDE2My4wOTk1MTJdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAw
MDAwMDAwMDIgXS0tLQ0KPj4gDQo+PiANCj4+IEluIGVucXVldWVfdGFza19kbCgpOg0KPj4gDQo+
PiB9IGVsc2UgaWYgKCFkbF9wcmlvKHAtPm5vcm1hbF9wcmlvKSkgew0KPj4gIOKApg0KPj4gIEJV
R19PTighKGZsYWdzICYgRU5RVUVVRV9SRVBMRU5JU0gpKTsNCj4+ICByZXR1cm47DQo+PiB9DQo+
PiANCj4+IEkgb2JzZXJ2ZSBmbGFncyB2YWx1ZSBhcyAoRU5RVUVVRV9SRVNUT1JFIHwgIEVOUVVF
VUVfTk9DTE9DSykNCj4gDQo+IFRoYW5rcyBmb3IgdGVzdGluZyENCj4gDQo+IEhvd2V2ZXIsIGl0
IGxvb2tzIGxpa2UgNC4xOS1ydCBpcyBhdCBsZWFzdCBtaXNzaW5nIGNvbW1pdCA0NmZjYzRiMDBj
M2NjDQo+ICgic2NoZWQvZGVhZGxpbmU6IEZpeCBzdGFsZSB0aHJvdHRsaW5nIG9uIGRlLS9ib29z
dGVkIHRhc2tzIikgYW5kIGNvbW1pdA0KPiAyMjc5ZjU0MGVhN2QwICgic2NoZWQvZGVhZGxpbmU6
IEZpeCBwcmlvcml0eSBpbmhlcml0YW5jZSB3aXRoIG11bHRpcGxlDQo+IHNjaGVkdWxpbmcgY2xh
c3NlcyIpIHRoYXQgbWlnaHQgYmUgcGxheWluZyBhbHNvIGEgcm9sZSBoZXJlLg0KPiANCj4gQmVz
dCwNCj4gSnVyaQ0KPiANCg0KSGkgSnVyaSwNCg0KQWN0dWFsbHksIHdoaWxlIHRlc3RpbmcgSSBh
bHJlYWR5IGluY2x1ZGVkIGJlbG93IGNvbW1pdHMgaW4gNC4xOS1ydCA6DQoNCmZlZmYyZTY1ZWZk
OGQ4NGNmODMxNjY4ZTE4MmIyY2U3M2M2MDRiYmIgKHNjaGVkL2RlYWRsaW5lOiBVbnRocm90dGxl
IFBJIGJvb3N0ZWQgdGhyZWFkcyB3aGlsZQ0KIGVucXVldWluZykNCjQ2ZmNjNGIwMGMzY2NhOGFk
YjliN2M5YWZkZDQ5OWY2NGU0MjcxMzUgKHNjaGVkL2RlYWRsaW5lOiBGaXggc3RhbGUgdGhyb3R0
bGluZyBvbiBkZS0vYm9vc3RlZCB0YXNrcykNCjIyNzlmNTQwZWE3ZDA1ZjIyZDJmMGM0MjI0MzE5
MzMwMjI4NTg2YmMgKHNjaGVkL2RlYWRsaW5lOiBGaXggcHJpb3JpdHkgaW5oZXJpdGFuY2Ugd2l0
aCBtdWx0aXBsZSkNCjBlMzg3MjQ5OWRlMWExMjMwY2VmNTIyMTYwN2Q3MWFhMDkyNjRiZDUgKGtl
cm5lbC9zY2hlZDogUmVtb3ZlIGRsX2Jvb3N0ZWQgZmxhZyBjb21tZW50KQ0KDQpUaGFua3MsDQpB
bmtpdA0KDQo=
