Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA5656D444
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 07:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiGKFT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 01:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGKFTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 01:19:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788DF13E22
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 22:19:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXLfDRyYozVFA+8bIrM8tWYPIk9qw+MznwH1dh5awCmwriTEL8HSd5SyzM4mI/c/N0uohBKDys60UlHgxJusjB8FauI91msLlPL99emdPfRzDkcFFHZSw5wjNFVqqygsZ7uiAXNPBmq0UC1Dp5dbi1DenStF/iW/GkxvcPxBubP/zVpX3Pj6jF8avi64YlfttwJpLWIZ1PPyVrJhuJG62lC0fAo9t0KhtzCynH8m6oQmYkcBO62qN2DW/6yCIAQBs7pdwQ+iRX7JXwp2XM6QUn5k8V1McFn+Eo0uomyOJumRno88rv7UhdaYNX4aun6sYeXewq1Ny87ZZZSGXvAIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJDG+14lGfO8dzpvmJ0i3ztIjbTD9iG/AuPRrajISns=;
 b=VYeNktUF9oUfd4vUgz9CNoDIh73POddlCYyl7A7qkFqmO1w8C9GfabL3T19HjDUuXo3oX9AGTkiXVRNAQ5RLG/Brf4SDxNdqJBUbZQ8/oaR5rQED3DHfsCXN2RAnExGp5dGHpQmw8g/Fiz6WlAu/1WhF42QSo2HSwT4alBnF5cZzeYsuD9JsGHIKxqoRDWaYOQNFkCzO7h18vGLMhgAvaZ5T6wrfL6xyfhTnNTjBW4SuKD+c6UEUByDtOqU3d2TkL3axRGnOLGIQ9T/Ty9zx4ct9GJF6easlvWYxN6XtUCgQllO1M4ztNV4/6dAGLjFprmxCfI/ObwMxyqHJb7E2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJDG+14lGfO8dzpvmJ0i3ztIjbTD9iG/AuPRrajISns=;
 b=icU/I2GiP9yqKr/Z4tGIrzcY/Zmo4hD/Lq1SF5VNyj35PAw8AOesJx4Jr52Buioavcw/Wv2Z8xUXGRQ2i1OAzIs6MqhsFnkotkaTJDPRA06gOuHj3h/y9hOdhrESxKvJPm+RLXCSebdy1wSOq6eQbglN7jH0MxbRA8Bwm0DtD8Y=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BN7PR05MB4033.namprd05.prod.outlook.com (2603:10b6:406:90::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.10; Mon, 11 Jul
 2022 05:19:19 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%5]) with mapi id 15.20.5438.011; Mon, 11 Jul 2022
 05:19:19 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/mm/tlb: ignore f->new_tlb_gen when zero
Thread-Topic: [PATCH] x86/mm/tlb: ignore f->new_tlb_gen when zero
Thread-Index: AQHYkqF/mvVmWIh+yUS8DjEvdZIjBK10jraAgAAlg4CAAB63gIAD01iA
Date:   Mon, 11 Jul 2022 05:19:19 +0000
Message-ID: <E38090A1-63CE-4679-B68C-D053923D7268@vmware.com>
References: <20220708003053.158480-1-namit@vmware.com>
 <c5edb95c-3ca3-9339-47d6-6304f9bfd708@intel.com>
 <4F7D1BBF-9695-4DE2-A40E-2D2546B2BAAE@vmware.com>
 <2e4d0193-1c5a-ec30-53a1-8009370cde36@intel.com>
In-Reply-To: <2e4d0193-1c5a-ec30-53a1-8009370cde36@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f720e9d-295f-4b6a-907c-08da62fce872
x-ms-traffictypediagnostic: BN7PR05MB4033:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T6gFSpBRICtzpjK3q6HiAfrPjk6YD3zzFFN920/oYHvehwhaWlVLTbAEh9+HdCeZQTMLR5y20KxcoCrXrFElaCGqW1wEqMIY+P3rRSBcWtoksRC+5wVVXE+UqizXE3UOghVaep5GqHwkaltizwnGJWhVxk75gVD+C0tkHxmuPYDhS09Dv3PWy5+wGvYJmOOKgddQdiZYjOhk/u5druOYRNvUnpTJ6nfJjCh+Xjmo4m5oZy8iHRifrKAVdcmpcwz/Ub1wrSxk3lT/O7tTud+Ek0cQazVi8t71sAPKKPmT789gdT/NKk1Gdt+R0TIkSJqIXTY1ziXiKNzjWiQwCM/BI97U7nqUFT6KC8besAvOD1llx1sjKA1qq+f+WsTvzmHK2rn6Iso6UhZCmvcej8HiZu2eqWmoLC+qQowjZThvlmdUbJtiaIO9BhRUBD4JgA8acpXo9Puy2G3fFN0hY5351JoG10AlijBNuaosGLkNW/wnvFKJOtpuh1r1b56I1wvck/Pua/n/HgqbvA+NF+cu12Fnvuu3p9zA1y4BXTEgiVH5A2ZKAojUD696McZ2RFLf/Lp9IlJL7eeDISiugxOL5U4UE35Roxs1Q9LviqYIowtcXVoduErVRA/r2OSdmzuGOQ/lHEJ1vivrFb6jJ7muIl8J+x3SBogRL/8X/WNW7sFBLjndMvQAmiZQoLXgI/ry2sJmD6lkq30Ls0UaKEXq0frekUMP9Z/I3UOIpxGA9myw28m1NQasLrJEQoYb9h/03i7r41yhwI7iWP7OiZ132BiCXj0CW2RgAST+X83V2zEkK3Hb7qdAhWQhzQleLFb8PICkp6lMH8JhCQJnaJo0MqTwtYMf4yvDD22Xmyb/CCESSv8rAU1J30OJHv8MqFUFL8DP4lmU5FWbUnuD8kwY+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(38100700002)(2906002)(36756003)(316002)(33656002)(7416002)(122000001)(83380400001)(5660300002)(76116006)(66476007)(8936002)(53546011)(8676002)(86362001)(66446008)(66556008)(6506007)(6512007)(4326008)(26005)(54906003)(2616005)(38070700005)(6916009)(71200400001)(186003)(41300700001)(64756008)(6486002)(66946007)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnEvNW5YK2pSNU10TDBFbjlmKzBYanVJbVlHOGdTdk9oNHVQM0Y0YTIxWGF6?=
 =?utf-8?B?N1RWZjM4L2p5SGJqUndESkdmRTRXZUlXV3k4MTNpK284dlJIVUpmSDVTdk5z?=
 =?utf-8?B?cjVvT2hWN0FJUnVNdG41VGwvc2w4NzcxWFNLaXB5N3EwZkEzUVRiN1I0YWp4?=
 =?utf-8?B?dWt6eHVUd0ZyVFV5MmM2OG1NL2RJREtpamt4dzQ3OXQyNVRvMG9qZlc5NHJT?=
 =?utf-8?B?cEtrV2tsZFlaVmNPYlJ1UHhXdElveGpvV0tMT0JCNDl5YUF5akN3NmFjdmda?=
 =?utf-8?B?S0FMSVRKYWtLcmR3OVZiU3FCYXFvL3paTlpueWw4bGV4MWEyS25ObGk4SU9j?=
 =?utf-8?B?SGkwS2ZGakJiWTM3RTdwSnFkdHBtZGtmUS93N1pRdFpqK2MxVHhuY2p4cXZs?=
 =?utf-8?B?M2lZZTdnRERETHlrWDNoK1lOSTkzd3BKU04wdTRiK2tSaUxnUUZUaXVwOHpn?=
 =?utf-8?B?bDVVWHJYL2c5WGsvcURKcUEzdEFxNXc3ekdBeVFvVmlGQk04Vm1iT0phQURQ?=
 =?utf-8?B?SjgxM0Z4eWxrdlZKZ1NlUlpXc2ZEdTBza1EwQzhpRkRFU2QzY2dlQ3ROMzVv?=
 =?utf-8?B?Q3o1Q2t3dWNxZVF2S2RvOGpKWW1NK0NOM1FYOWdQK0RnWDZuNGJ3WnBtWjF1?=
 =?utf-8?B?U0w2ZzFQV1haYmw4NHQ3RVhNek9XcmVlYWhsMThMMGEwLzhCdU1YNjQrUm1y?=
 =?utf-8?B?L1owSG1COU9SMENERHhzTE5WM0szK1FlbUxjL2N6ZE5RU1lYVlpGdjJtRHpL?=
 =?utf-8?B?UDMyUlBBWnNVazhodjI4eFd1YklwdVEyUTdMUXo5RmdEMzBZMmFSRXFzczhJ?=
 =?utf-8?B?UW8rNnUyRXgvYi90VExuVytNRzdVSDJ4MmI0MHFYa1MwSTQzK3hpSWtScldU?=
 =?utf-8?B?RUtSdDA4WGMzMlg1NkVaTm9zaWswLzIxUDJ1Qm9PaFhQMldjK2hMRVUrbzF3?=
 =?utf-8?B?dVM1eklIZHUvT04vVGpPMnlkc3ZoYXUyMjdaaHBEVSs3NUg2U2NXdHhKN2Vr?=
 =?utf-8?B?dUVwL0FSU3FlVTJQbmlRMUkyTk5zQ0kzblFyR1ptNEFOTFlJVWRKQ1JvYW9N?=
 =?utf-8?B?cmJXR0g4R2dsR0RiOUZlTnlHdVVmVWpEWHB1M3hSWXNONVJVR2NoRU9yVTUw?=
 =?utf-8?B?NGxBNDhCTmlWTEJBeTA4MFExV1BqdmJSUEp1ZG5DVlJxWHNjeW5jZUZLVkwv?=
 =?utf-8?B?b0d2T25Lcnc5ZHdpaDg2VFpva2NOQzNmaWIvMFZ1VzZvM2N1bUc5NW04bWtT?=
 =?utf-8?B?bU5NeDBZNGVoZUhweEVwUk5jckR5dlJJZVBLbTVLbW4zcE9JYXBIeTA5ODVE?=
 =?utf-8?B?Sk9YcW1ZSGsxNkJGclpDaWtBZkFQYkt1OEt3L01HNGpWV0FvRVBBb3lNUDRR?=
 =?utf-8?B?bWVtdHc5NEsrZmZRaWxhVmJqb1IrWGs3OE4wMW9zbUovZmZlZXFOWDJCcUls?=
 =?utf-8?B?OFpNQlhSODVaYjVUajExNHVZNzJwNnJ2UmdyVGhmSkFxa3Z6VGM4aUVDdndn?=
 =?utf-8?B?dkxpZGtnK3lXcHpYQ1VXSnpabEYwRzRXTHVuMHBkVGdrTW05RzJlMGxiWGU3?=
 =?utf-8?B?Sytub1RNWk9HT3N5MUNCZ0RJV0FOVmdlZ2tXM0oxOGdNTGRONTlwU0ZlTmFK?=
 =?utf-8?B?WTZWa2NrckNpM0FuY1c3MUpJMkhGV0FDQmZKbnNsUTB1S203ZWFNVWg1ZTFY?=
 =?utf-8?B?NWxaQTA4WkhURWxPYzg0Mk1hbTdHWGNuOHhRSkV3ZEkyY0pDQitFTFFKUXN4?=
 =?utf-8?B?Q04xUnJXWFlTRVhtK1hmTGxneGFYeDJVRk1qeVhrZndjSDNtVkpHVmFNeW5S?=
 =?utf-8?B?K0Ywbzl3MERxeVBZcEo1eWlMUmpLbTVHNEpIV0FXZnZqVDBLSU1hZytrWm1U?=
 =?utf-8?B?VFkzdThVWHlTZWg0ejhnWlA0T242dnNMOElDYmh4akN1RmRIYU1halV2ZHlL?=
 =?utf-8?B?VStNQTZWYlRVdWhXbFVMOHc5b01BWGJndmVXd0ZLeGRmcHRxQlZCUHcwaGpY?=
 =?utf-8?B?TnFFdmJwNTZjbE1rQTdHOWszeWR3SUk5eG9tLyttVCtPV2JaRzNZS2lBT2Zi?=
 =?utf-8?B?aHIwVVRWNkJnNm1lQ2t4QTRoNG8zTnRxeGtKMUFNMkZueDZaTmJjRkdKQ2cy?=
 =?utf-8?Q?DHA30E3Spul+VKTuNcIvEkZ2e?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41ECE7341A03594E81CF80F01B03AC82@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f720e9d-295f-4b6a-907c-08da62fce872
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 05:19:19.6824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJEqUPt1GKNcN8QImzCTww7Al/umGke646DLQuHAiPJmexpOAnLNUq0/vSX1E7RD4EHFU7C8kyfAbfhQ5uKaPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4033
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSnVsIDgsIDIwMjIsIGF0IDExOjU0IEFNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50
ZWwuY29tPiB3cm90ZToNCg0KPiDimqAgRXh0ZXJuYWwgRW1haWwNCj4gDQo+IE9uIDcvOC8yMiAx
MDowNCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+IE9uIEp1bCA4LCAyMDIyLCBhdCA3OjQ5IEFNLCBE
YXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPiB3cm90ZToNCj4+PiBPbiA3LzcvMjIg
MTc6MzAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+Pj4gWW91IG1pZ2h0IHdhbnQgdG8gZml4IHRoZSBj
bG9jayBvbiB0aGUgc3lzdGVtIGZyb20gd2hpY2ggeW91IHNlbnQgdGhpcy4NCj4+PiBJIHdhcyBy
ZWFsbHkgc2NyYXRjaGluZyBteSBoZWFkIHRyeWluZyB0byBmaWd1cmUgb3V0IGhvdyB5b3UgZ290
IHRoaXMNCj4+PiBwYXRjaCBvdXQgYmVmb3JlIEh1Z2gncyBidWcgcmVwb3J0Lg0KPj4+IA0KPj4+
PiBGcm9tOiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KPj4+PiANCj4+Pj4gQ29tbWl0
IGFhNDQyODQ5NjBkNSAoIng4Ni9tbS90bGI6IEF2b2lkIHJlYWRpbmcgbW1fdGxiX2dlbiB3aGVu
DQo+Pj4+IHBvc3NpYmxlIikgaW50cm9kdWNlZCBhbiBvcHRpbWl6YXRpb24gb2Ygc2tpcHBpbmcg
dGhlIGZsdXNoIGlmIHRoZSBUTEINCj4+Pj4gZ2VuZXJhdGlvbiB0aGF0IGlzIGZsdXNoZWQgKGFz
IHByb3ZpZGVkIGluIGZsdXNoX3RsYl9pbmZvKSB3YXMgYWxyZWFkeQ0KPj4+PiBmbHVzaGVkLg0K
Pj4+PiANCj4+Pj4gSG93ZXZlciwgYXJjaF90bGJiYXRjaF9mbHVzaCgpIGRvZXMgbm90IHByb3Zp
ZGUgYW55IGdlbmVyYXRpb24gaW4NCj4+Pj4gZmx1c2hfdGxiX2luZm8uIEFzIGEgcmVzdWx0LCB0
cnlfdG9fdW5tYXBfb25lKCkgd291bGQgbm90IHBlcmZvcm0gYW55DQo+Pj4+IFRMQiBmbHVzaGVz
Lg0KPj4+PiANCj4+Pj4gRml4IGl0IGJ5IGNoZWNraW5nIHdoZXRoZXIgZi0+bmV3X3RsYl9nZW4g
aXMgbm9uemVyby4gWmVybyB2YWx1ZSBpcw0KPj4+PiBhbnlob3cgaXMgYW4gaW52YWxpZCBnZW5l
cmF0aW9uIHZhbHVlLg0KPj4+IA0KPj4+IEl0IGlzLCBidXQgdGhlIGNoZWNrIGJlbG93IHVzZXMg
J2YtPmVuZCA9PSBUTEJfRkxVU0hfQUxMJyBhcyB0aGUgbWFya2VyDQo+Pj4gZm9yIGYtPm5ld190
bGJfZ2VuIGJlaW5nIGludmFsaWQuICBCZWluZyBjb25zaXN0ZW50IHNlZW1zIGxpa2UgYSBnb29k
DQo+Pj4gaWRlYSBvbiB0aGlzIHN0dWZmLg0KPj4gDQo+PiBJZiB3ZSBnZXQgYSByZXF1ZXN0IHRv
IGRvIGEgZmx1c2gsIHJlZ2FyZGxlc3Mgd2hldGhlciBmdWxsIG9yIHBhcnRpYWwsDQo+PiB0aGF0
IGxvZ2ljYWxseSB3ZSBoYXZlIGFscmVhZHkgZG9uZSwgdGhlcmUgaXMgbm90IHJlYXNvbiB0byBk
byBpdC4NCj4+IA0KPj4gSSB0aGVyZWZvcmUgZG8gbm90IHNlZSBhIHJlYXNvbiB0byBsb29rIG9u
IGYtPmVuZC4gSSB0aGluayB0aGF0IGxvb2tpbmcNCj4+IGF0IHRoZSBnZW5lcmF0aW9uIGlzIHZl
cnkgaW50dWl0aXZlLiBJZiB5b3Ugd2FudCwgSSBjYW4gYWRkIGEgY29uc3RhbnQNCj4+IHN1Y2gg
YXMgVExCX0dFTkVSQVRJT05fSU5WQUxJRC4NCj4gDQo+IFRoYXQncyBhIGdvb2QgcG9pbnQuDQo+
IA0KPiBCdXQsIF9teV8gcG9pbnQgd2FzIHRoYXQgdGhlcmUgd2FzIG9ubHkgcmVhbGx5IG9uZSBy
ZWFkIHNpdGUgb2YNCj4gZi0+bmV3X3RsYl9nZW4gaW4gZmx1c2hfdGxiX2Z1bmMoKS4gIFRoYXQg
c2l0ZSBpcyBndWFyZGVkIGJ5IHRoZSAiZi0+ZW5kDQo+ICE9IFRMQl9GTFVTSF9BTEwiIGNoZWNr
IHdoaWNoIHByZXZlbnRlZCBpdCBmcm9tIG1ha2luZyB0aGUgc2FtZSBlcnJvcg0KPiB0aGF0IHlv
dXIgcGF0Y2ggZGlkLg0KPiANCj4gV2hhdGV2ZXIgd2UgZG8sIGl0IHdvdWxkIGJlIG5pY2UgdG8g
aGF2ZSBhICpzaW5nbGUqIHdheSB0byBjaGVjayBmb3INCj4gImRvZXMgZi0+bmV3X3RsYl9nZW4g
aGF2ZSBhbiBhY3R1YWwsIHZhbGlkIGJpdCBvZiB0bGIgZ2VuIGRhdGEgaW4gaXQ/Ig0KPiANCj4g
VXNpbmcgc29tZXRoaW5nIGxpa2UgVExCX0dFTkVSQVRJT05fSU5WQUxJRCBzZWVtcyByZWFzb25h
YmxlIHRvIG1lLg0KDQpJIGFtIG5vdCBzdXJlIHRoYXQgSSBmdWxseSB1bmRlcnN0b29kIHdoYXQg
eW91IG1lYW50LiBJIHVuZGVyc3RhbmQgeW91IGRvDQp3YW50IFRMQl9HRU5FUkFUSU9OX0lOVkFM
SUQsIGFuZCBJIHRoaW5rIHlvdSBhc2sgZm9yIHNvbWUgYXNzZXJ0aW9ucyB0bw0KcmVnYXJkIHRv
IHRoZSBleHBlY3RlZCByZWxhdGlvbnNoaXAgYmV0d2VlbiBUTEJfR0VORVJBVElPTl9JTlZBTElE
IGFuZA0KVExCX0ZMVVNIX0FMTC4gSSB0aGluayB0aGF0IGluIG9yZGVyIHRvIHNob3J0ZW4gdGhl
IGRpc2N1c3Npb24sIEnigJlsbCBzZW5kIHYyDQoodmVyeSBzb29uKSBhbmQgeW91IHdpbGwgY29t
bWVudCBvbiB0aGUgcGF0Y2ggaXRzZWxmLg0KDQpJIGRpZCBydW4gdGhlIHRlc3RzIGFnYWluIHRv
IG1lYXN1cmUgcGVyZm9ybWFuY2UgYXMgeW91IGFza2VkIGZvciwgYW5kIHRoZQ0KcmVzdWx0cyBh
cmUgc2ltaWxhciAod2lsbC1pdC1zY2FsZSB0bGJfZmx1c2gxL3RocmVhZHMpOiAxMSUgc3BlZWR1
cCB3aXRoIDQ1DQpjb3Jlcy4NCg0KV2l0aG91dCBhYTQ0Mjg0OTYwZDU6DQoNCnRhc2tzLHByb2Nl
c3Nlcyxwcm9jZXNzZXNfaWRsZSx0aHJlYWRzLHRocmVhZHNfaWRsZSxsaW5lYXINCg0KMCwwLDEw
MCwwLDEwMCwwDQoxLDE1Njc4Miw5Ny44OSwxNTcwMjQsOTcuOTIsMTU3MDI0DQo1LDcwNzg3OSw4
OS42MCwzMjIwMTUsODkuNjksNzg1MTIwDQoxMCwxMzExOTY4LDc5LjIxLDQ5MDg4MSw3OS42OCwx
NTcwMjQwDQoxNSwxNDk4NzYyLDY4LjgyLDU1Mzk1OCw2OS43MSwyMzU1MzYwDQoyMCwxNDgzMDU3
LDU4LjQ1LDU5ODkzOSw2MC4wMCwzMTQwNDgwDQoyNSwxNDI4MTA1LDQ4LjA3LDYyNjE3OSw1MC40
NiwzOTI1NjAwDQozMCwxNjQ4OTkyLDM3Ljc3LDY0Mzk1NCw0MS4zNiw0NzEwNzIwDQozNSwxODYx
MzAxLDI3LjUwLDY3MTU3MCwzMi42Myw1NDk1ODQwDQo0MCwyMDM4Mjc4LDE3LjE3LDY2OTQ3MCwy
NC4wMyw2MjgwOTYwDQo0NSwyMTQwNDEyLDYuNzEsNjczNjMzLDE1LjI3LDcwNjYwODANCg0KV2l0
aCBhYTQ0Mjg0OTYwZDUgKyBwZW5kaW5nIHBhdGNoOg0KDQowLDAsMTAwLDAsMTAwLDANCjEsMTU3
OTM1LDk3LjkzLDE1NTM1MSw5Ny45MywxNTc5MzUNCjUsNzEwNDUwLDg5LjYwLDMyNDk4MSw4OS43
MCw3ODk2NzUNCjEwLDEyOTE5MzUsNzkuMjEsNDk4NDk2LDc5LjU3LDE1NzkzNTANCjE1LDE1MTUz
MjMsNjguODEsNTc1ODIxLDY5LjY4LDIzNjkwMjUNCjIwLDE1NDUxNzIsNTguNDYsNjI1NTIxLDYw
LjA1LDMxNTg3MDANCjI1LDE1MDEwMTUsNDguMDksNjc1ODU2LDUwLjYyLDM5NDgzNzUNCjMwLDE2
ODIzMDgsMzcuODAsNzA1MjQyLDQxLjU1LDQ3MzgwNTANCjM1LDE4NTA0NjQsMjcuNTIsNzE3NzI0
LDMyLjMzLDU1Mjc3MjUNCjQwLDIwMzA3MjYsMTcuMTcsNzM0NjEwLDIzLjk5LDYzMTc0MDANCjQ1
LDIxMzY0MDEsNi43MSw3NDcyNTcsMTYuMDcsNzEwNzA3NQ0KDQoNCg==
