Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4056756BEF1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbiGHRKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiGHRKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:10:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D51B19C3D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 10:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VL54pK4gJSbi1ALjvRY195uTf9ALyXAAz/CFrLlV+vDBF7xoh9rITS0Y2H/E9GhbjKDn4cQ4NuVMtk5s66k5IksqQIiOwgQaxEq5DknWEeIcfY11dUgGmTvs9RiNgSSkR8BYPYwIgmmC8EZeWKNC6IMp7WDYUMO0Ig5qutTkBophbQuXt1UeUWpmF0gNIvzvgqX0sXKaUOx6lmQv+KgPsETDYqyXHIUu97CeIiTK3s2TtIYq6n61C5iZGrY/EwnYCOFrmY02P3EZsqIqW1st6y2ldiHNbLL72JWgYqgNuyVEPGl0oEddD7duMTZvyOTM0O2DDTS9Hk5s8+9bNJGDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QX1abBjdw0cWtfhMXHZodWnZeA9biHeQdKraNyGYJA=;
 b=mi8KMFO7QDpzGg6mZcQRU8/+LEgvn/mHfkBfyBtQiB2mjzOETZ2hmegRvnrkzcqWDXpCuOtVMy4/WFOFEe+Sd2jaAW9e9OT3+3PIGNIxvDegUvtB1DroOvz+eQPN0xuPVFzBrmEgFxWQRtc7bDiiR10F57v/9RKUqRDB/DyPVj0H3YHelTOYMXjt+rpbBNoGKdgCuRaiIbUD8yOYv5IzI25r8oUNVykjLtog2CjTVFBKVhxyFZPctNwP+lDUmGH+/usTxc4MWU93wBGoXjxGfduw+m2KOynR9PDay51OtSDI+0IcsSfK5hQ8KZgIYk+9dyVT6pUzpG3qMmBrnCY8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QX1abBjdw0cWtfhMXHZodWnZeA9biHeQdKraNyGYJA=;
 b=aVdHxNfDgf3BTBOkooptkhF40hjxAvrBQ8vVYBlZdMGKJDdlcv3iW2aM44DAYMgtZwsn0QTFm8hOsiCGuaMpGn0xvL5BvTQ7XWDMuaXBhdKfv/QIqYgDuOkxQXZm/4/gQjdvXbpamQsDxpBQvtgcPB7k4b8SFKLk7ldkPG2Pq6Q=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by MWHPR05MB3152.namprd05.prod.outlook.com (2603:10b6:300:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Fri, 8 Jul
 2022 17:09:59 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%6]) with mapi id 15.20.5417.021; Fri, 8 Jul 2022
 17:09:59 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/mm/tlb: ignore f->new_tlb_gen when zero
Thread-Topic: [PATCH] x86/mm/tlb: ignore f->new_tlb_gen when zero
Thread-Index: AQHYkqF/mvVmWIh+yUS8DjEvdZIjBK10WcwAgAA7bICAABxnAIAAAeOAgAACVoA=
Date:   Fri, 8 Jul 2022 17:09:59 +0000
Message-ID: <3276DF39-328E-497A-9EF4-A2A348C19D92@vmware.com>
References: <20220708003053.158480-1-namit@vmware.com>
 <b573a9c6-2ee0-20dc-1f28-84d3a81d40a2@redhat.com>
 <283d7660-000a-81af-1d6b-4fdedcb6dfd8@intel.com>
 <A604C6DA-5E5D-43F1-B63F-EF9D145CACCE@vmware.com>
 <a486ad3f-8fb6-c37b-9e7e-c6ba1a841b57@intel.com>
In-Reply-To: <a486ad3f-8fb6-c37b-9e7e-c6ba1a841b57@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c014007-c001-40d9-d23f-08da6104b0a2
x-ms-traffictypediagnostic: MWHPR05MB3152:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f22yfyIdTIJZsCb0ZOA5af9FlNsXoHJvnQI8JOcQ1xM6pTLnJF0bEYsV16u+xknwYq1YUdvttUiks2hQTAgJZoDq+Xd6MYkzEOC3qicYCtpIoheqQg4diyv0JNKiu3WkEBZGus9WLdCjxKQHWSr+HCpswt9OdFQM96a03w6VV4mDkJwT1/t1b35ZSrXrHq0rs32naVNwgXAi4MgxBwLmTKUlnn5L9VZj4Dd1OMCMYs+d6GIhSy82ZoAADVudNmd6xJd5ffhof8KMv8+1YeSwUL+fS3ofs/7HVjlh1NWW+KkrpzAy1QYk7BOxR4spY82iUwEnkbNqNsiR+G1bj1kzy7nBTcpLmBSw/8cfEIMmzvAhVTrYy3+2YyELHpLRhPTNdL5NPBI+IJxopm+PkQcly0xHyCD5q/5rNS9RdLyozcZT8GCR9sBK5vFmJ+3oWWm6fIhEamo1PZLatxCZYDjJMCf/URBS2jdD14MzojBvWO9Ys/QwsmCZkx/vhWAs6J/e4iumjywfZB3mVNMZhXC2bypnF3U/c5ZW0sN9crPRsf9ehPtib0Dn+WIRyw5iz+JsWFKbYaCrGZNmzJJHccd/+xtsK/RC4H/Ka7fOqblNpat2viC+HBD30Tu3kjwYX8cScNE2W9WeUvXKteVp8JvRJnf/uNL0bjH8gCOyK5v2ek3O6TSIEjGkRdDs6b41r8kjSaxLDR4OXqREZDZueFOhw9TXTG/aPlTO7aDURl+nbPY3oCQv68ezp97en0FEcjwD+NIDK73kTRbxFpJsBSjFSYLmrL6378kHvHhfqZuvFa9xi1STaoWmXC3xUQWX72ciBRwhpLUdxoI+YocpMIij4esNgszwsT8eqwixHmQ156A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(122000001)(38070700005)(54906003)(6916009)(186003)(316002)(38100700002)(36756003)(4744005)(8936002)(2906002)(5660300002)(7416002)(33656002)(76116006)(2616005)(41300700001)(71200400001)(4326008)(64756008)(66556008)(478600001)(66946007)(8676002)(66446008)(66476007)(86362001)(6506007)(26005)(6512007)(53546011)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTMwRkRvN2dIeUt1eVJYL0JlK0VITVdIQmkyNW5XaGxvR0tiQUZtdnNKWGYx?=
 =?utf-8?B?VE5DcUM5OHhWa0h4UnpLZkRtRHdJRVNVU1h0Q3dxYk9qTktLTjZPcmRyTDh2?=
 =?utf-8?B?bkk5L254NmVtTVo0N1dxeVJJVVhTbkMwNVlEb0FndzNMY2VrNzhwa2xldzZJ?=
 =?utf-8?B?NU5SbmRnYmN2Rjk4MU9nWHV0Uk0zOXIzaFVtRFRSK3hQWTFOZlZHZzdZd0F4?=
 =?utf-8?B?ZUh1WXpuTEZDWmFiOXpFZTY1VHRIMGUwcmlycFljVTJldU1CTzRHbS9BeHYx?=
 =?utf-8?B?L21uVzFHbGd2cUNSSHU5YU9FRlptK2xYeE80Z0VlZDJXazdTcEo5Wm84cmoy?=
 =?utf-8?B?UVdJWFNUK1hSZ3dqYnc0ZVRrTkpHSDQzSVg3dGgwL1R1WGlpaHkyd1ZVYkxZ?=
 =?utf-8?B?ZWVwbDBldmF6azZuVUhPL3ZHMmJPSVJTSXV2bVVqSGtCWGhPQ3QxOFZRa0NG?=
 =?utf-8?B?bWMxQk1wcG5ORXVsSDR2a1RQYmJhcDVoSHA1dkltRER5Y2JVN2RKQkZKUkZz?=
 =?utf-8?B?M2RibkpTcU1MczlsSkY5eGVUbFNieTdDRjZzamREYzNhMGpHYjMvUWhEaDI4?=
 =?utf-8?B?dGVGeUJJSnhnTVFMeXAybHFhZ1pxUWU2S3FieUViWk02eFc2M2dEKzNWY25E?=
 =?utf-8?B?dkM5eWVJWHBMTmNSNmI5Ym13dnQyWEFmTGNYQzBBL2M5YWY5eTJ5ejFSY2hK?=
 =?utf-8?B?ME9GZ3Fud2lTc0VhZmdrRk4vb2EvMndhVldiWWhPSHo0YVoxbEovY3l4OTBl?=
 =?utf-8?B?MjVoRURvN3VYMEh0WEVJK0h1RU9NZDdlUVllYmZYODJYeUp4UVFKZXBBTXF0?=
 =?utf-8?B?QlBwR2o3dDFGbFRxN0pWOGNrN28zMVEwY01vMVpTL3RkcmVtT1JOaVIrV0d3?=
 =?utf-8?B?NG9RS25MWWFUZHhkUk9xRnFlSVAyRlo5aG5tckdPa2NKVmZZNXJ1bjZOMEht?=
 =?utf-8?B?VDVwNDczTDQvaklXQ2FBT29nYnMxWjZwWXl0RGlDN1pLRmN5eTVOSFBZcUcr?=
 =?utf-8?B?ckUxTEFySU1VU2FoV3R5RGV2eUI1TVRJK1hsVGVyR09tbmFEcFJ5WE4yNzRx?=
 =?utf-8?B?RkZWVW9UNzU4MUhMTDI0cEVTM1kzTnJndzdxYlpseFRpRmQvTThqdkZEYTF2?=
 =?utf-8?B?bjNRbENBcUhPdHhCa01sSHpNT3lsM1RZSTBTNVdQc0FhbWNOYTdUUXFqcDVB?=
 =?utf-8?B?ZWR4U1pjQVZuRU95QjNBY2RkUWxSUFkrSUFnUjg0Nks5ZktoZDRsQUw4VUM2?=
 =?utf-8?B?R3h6bDdtbURsOTNiRHlscGxjaGs0TFpMVTNhdE1ZenFvMFlLZk00dDJHdHcw?=
 =?utf-8?B?SnoxOU9FUVB6NDVXYW1NMGdqcUhJcmREZWxWNDVweUduOW1vRjR1QnczZUt3?=
 =?utf-8?B?U2laWWtCUERtaHlNUjFRR255MmVhT0pBMmNoaDV6c0NFcHg0UG8zMnd5L2ZI?=
 =?utf-8?B?R3U4MWRvbUpqU25CN2hwUnBSLzkyWEh5bHhtbmtVZiszUlJNQW1PVHN1MllV?=
 =?utf-8?B?dGdsdXlOT2hrbXdxSkEwcDVIWnFrRThmV1VtS2VVMEVIV1E1cGJHZUlyMm9S?=
 =?utf-8?B?R1IySlNza2RjekhuVGNCNHY0NGdlNC9oWjRjNitHV0dQVDZselVFaHpPMDYr?=
 =?utf-8?B?aEF4UDQzODU5dXh4dk5qSUkwYmxGVkZ3T3Y1UjBQdWlkOTJsL3RiamtKZ1hG?=
 =?utf-8?B?S3JPb0lDVjBoaHJQM2pNbUJjOEQ5NzhUeGg4YWhkMmlZT2VKMmREQkExL2Vw?=
 =?utf-8?B?RHlVUy81MTlvVDQrVGZHNG9xQ2F4dHNMOVMxMG9YTFN1bWNsdVIxVUgzQzJI?=
 =?utf-8?B?SC9iTUc4bE5zem92OHB3dGNEOHU2Y21iM2d1OEIwUnNMeWFudGVvUUMya2F6?=
 =?utf-8?B?b1NMTTVOZnNNT0FvVXorU2tVem5tQTU0RHh4OVU5SCtNS0hFblNEL0pVUWFw?=
 =?utf-8?B?TGs1RXRWcnA2OVYvTktwelRhaEh1Nkh1ejc2NjNRVC9XNlVuVGVmQlRCd3lE?=
 =?utf-8?B?MnkwSTYwMWUybDRkbW1nNWtOTjRHZkxUbjRtdjVWWlNvcldXNHZIbVc1NnNO?=
 =?utf-8?B?UmtmSWZ6bHJzWjhwNGlmZ1VEMmkralMrSlFmdUZFOE45ajZsb3hKWkQzNHNw?=
 =?utf-8?Q?ujxTRw7xzs3GDq9ZJOBqdcFzh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28513E32EAF31F4C8398F01ABF77C883@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c014007-c001-40d9-d23f-08da6104b0a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 17:09:59.7414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TioSMiImSgmlonCEpraJnqWCB+XYTBuw9amG8plTEclhxpluCEPKb7rakpn+5uHKtHKVBxGTZN0BxjK1EcFGtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB3152
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSnVsIDgsIDIwMjIsIGF0IDEwOjAxIEFNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50
ZWwuY29tPiB3cm90ZToNCg0KPiDimqAgRXh0ZXJuYWwgRW1haWwNCj4gDQo+IE9uIDcvOC8yMiAw
OTo1NCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+IFNpbmNlIHRoZSBidWcgd2FzIG5vdCBkdXJpbmcg
TUFEVl9ET05UTkVFRCB0aGVyZSBpcyBubyByZWFzb24gZm9yIHRoZQ0KPj4gcmVzdWx0cyB0byBi
ZSBhbnkgZGlmZmVyZW50Lg0KPj4gDQo+PiBGYW1vdXMgbGFzdCB3b3Jkcz8NCj4gDQo+IENvbnNp
ZGVyaW5nIHRoYXQgeW91ciBwYXRjaCBicm9rZSB0aGUga2VybmVsIGEgd2F5IHRoYXQgc3VycHJp
c2VkIHVzDQo+IGFsbCwgSSB0aGluayBjYXV0aW9uIGlzIHdhcnJhbnRlZC4gIFJlLXJ1bm5pbmcg
YSBtaWNyb2JlbmNobWFyayB0aGF0DQo+IHRha2VzIGZpdmUgbWludXRlcyBhbmQgc3RyZXNzZXMg
dGhpbmdzIGEgYml0IGlzIHRoZSBsZWFzdCB5b3UgY2FuIGRvLCBJDQo+IHRoaW5rLg0KDQpJIHdp
bGwgc2VuZCBpdCBsYXRlciB0b2RheS4gSSB3YXMganVzdCBwb2ludGluZyB0aGF0IHRoZSBmYWls
aW5nIGNvZGUtcGF0aA0KaXMgZGlmZmVyZW50IHRoYW4gdGhlIG9uZSBJIG1lYXN1cmVkLg0KDQo=
