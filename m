Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAED56C07C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbiGHRER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbiGHREP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:04:15 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-bgr052101064008.outbound.protection.outlook.com [52.101.64.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87005A2FB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 10:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9DjpV918pP3pGmm6gB1M0nsz69ZmmgUunDhHI19XV4A8ArW+wbyYRh0Kss0I8SDO8c9jpHpcmApQFwvrPROnpG6Tb6bC+IkPozlU/PZ6wmsVD4ADE+Ak6xq/tBPrtnwO7LcwXV1jeheWrn1lO+JvKIFiPLFcydaHCucYT7VcN+8M6YX2YndWQdq8ercI/K0z/+Eaz1qSprKqqirpQpD+A84y/zHIrKw6Y+i7slGukiIfTRKkF9PXSlTcSG3t5Au1NJFXP230noKzaPWpE+P+Ysne4NU0Te7HzbY6jr0REzBwkI/gcfsgxYTu+eeVC0WNHLmyf9heQ9RDW446DXapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZwDiGELKbdB6lRPgxWvzE0N0Zb1h1E3XmzalNk01Mg=;
 b=k1kY4stLcbd1B6GJHqYOqwP6n+Hv0xL/Mu+ftHBY48gxcsNkCKfapmFHPKv0tMj57GDX+T5QZgORmUv+eMCRFE+tjYPqrpwBmLc41Bt5EKTcWsS9ddbfyRZwJt2mbKICnjn/czPQGgfaW6n1uVE4JlcVb3vUiyOn+lY62eChMm1tqKFMs8xMn6KmbaBryAmPh7In63Q8hjtG26SaPIF5IXwstyV4SJDf6OrfjxR5yirEO4ZynRq+YU3DykVmyWcUTsrFhesoLMABYuq21e+idd3l8yqIvMStR4+UHITizmoWb6DJSWnbFnTION4bwtADA1nKA3nGw/UdP6VZZUuAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZwDiGELKbdB6lRPgxWvzE0N0Zb1h1E3XmzalNk01Mg=;
 b=tnmEOOgvjGNTihFZH6U1q6s6gpAlsedOryLhAWyOwFUW7V/+znwbncVAvsxaB8OGPTtd5MtgqDR8pvbJy3U1+Jk85RCcGAozppvdUgPqkGYtjauIGs6/0mspZhvOSm9oYWWXUgesFLxCw7WuusWRXCnP8+kuDkyQ5Psywvd1IMM=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB4920.namprd05.prod.outlook.com (2603:10b6:a03:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 17:04:12 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%6]) with mapi id 15.20.5417.021; Fri, 8 Jul 2022
 17:04:12 +0000
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
Thread-Index: AQHYkqF/mvVmWIh+yUS8DjEvdZIjBK10jraAgAAlg4A=
Date:   Fri, 8 Jul 2022 17:04:12 +0000
Message-ID: <4F7D1BBF-9695-4DE2-A40E-2D2546B2BAAE@vmware.com>
References: <20220708003053.158480-1-namit@vmware.com>
 <c5edb95c-3ca3-9339-47d6-6304f9bfd708@intel.com>
In-Reply-To: <c5edb95c-3ca3-9339-47d6-6304f9bfd708@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7bd94e6-e57e-4f0e-aceb-08da6103e18d
x-ms-traffictypediagnostic: BYAPR05MB4920:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: okgkHusUNytcLlNNaMPrlIhGcS8/aL+ORhD/TLbnvujZf0HTebmKIquIH1GugUZT1AMt87vixi1ZfIX6B+iuUOTb5rOfyPmhPYGKsPjOoB/XZpMMpiZWe0JSxPqoE0HUQ7MLLZjeAjcyZANP++/7aJfwuEkXCI96g4BglYWdbliAIEs7tILJDpOQhEEe9Ckp+eXwb9lYXJkP1iwNnsxmqfXHEyLo1xYKJHJvAmWzfJheHVQYkVyY7/eHQMZDk06XEgB0Z3OPckMy6OoR4DfZN0pbwKHieaVX3lBAb3PUHROw6Hb2t9tod01jnrMgb9fP1EMg8TORR3T/tslyfMEZ3S00nBQMVYWdu/YPMilC77WdvLEbf+LIt8ihmfW+0VHm28ylAflRl65KPBP0PmwEQQ7yPgh21Tlk5JryJjpHY6U6P9SURYW6xEZr9Nm+wcUIssChCi1mNlgjmBVyrQ3TXmiDeriGcqHqBUgb9LYAwACE6sP859p5llHtdm1Icxt/F1X6731ryRKUICvPpCsirleofJlFHi6P4rIYRmvGG6gxqfwVbEBozTqjKJ/b1iT+/drO2LWjZwWAm9zAsVFTV8AGfUAzUo5vkpYlBkO96I0VstiW3wl1orLMSXDklZPZ5D7NoSxM72NSEvsqvZAtZRqcsY4+EwuLbRxMIazlD7BL+F74/mRwdT7XD46DHRq6ggAuAf6bkT7AKEzjRTyogVAPl4HJVqFHmgbRJnPyMrWCgUm+BjAiFAQR29YR5r3lqq3KOCUIcc2oJd2zU9wFWI6IBrUyt7CibJ1dQu2pTrTU6KOs4POsdgqRsxhnUzQo5YEHVvqovUHbcadP74U6w7MBnO5zne/74rHTk+mYwgzc+FQLlNW3QkN6WtDISG8JnZLwqb3+cINf/mhykpE7gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(38070700005)(5660300002)(41300700001)(7416002)(33656002)(122000001)(8936002)(6506007)(26005)(54906003)(6512007)(316002)(53546011)(6916009)(186003)(6486002)(478600001)(36756003)(86362001)(2616005)(38100700002)(83380400001)(4326008)(8676002)(66476007)(2906002)(66946007)(64756008)(76116006)(66446008)(71200400001)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEZ0aGN4MzZHYmlDQjVDZlN6czNnNDNtYWJzMlluR0VIRHE5UW4wWlFQZHdt?=
 =?utf-8?B?YWlQaXN5Qi8wLzA3MnNNbXM3RnJuWGhFc2J1UGdaZDM4QWZwT0pyWURZSWgr?=
 =?utf-8?B?V1ZmNDEwSFJiNmJXamhLTzVMbDNtaHAwVVB6R0Y3TVBVYUxWZzhqZDVtVm5G?=
 =?utf-8?B?Vy9Rb0lLNjJGejdhUG5ZNXZIUUY2THFmRTI5L0M4czhoWEI1b1Z4cFc5VCtP?=
 =?utf-8?B?djNodXFsQmROUE5rbkI5MzRRdWZHaFhsQmkwOTFXVTd5Q2JHY3lsZmo0eit1?=
 =?utf-8?B?dG1UTVgyOENhYlhsZzk5R3MxalloVWsxZ25tWHdMMnRMZVg2RG9yam1PR3RW?=
 =?utf-8?B?eW1WYTN3dnJrTzNUdzJJd202ckIxb2RUeDY1Vy9EaVN6ZkZZNkhUK0x2QVVt?=
 =?utf-8?B?N2hIbWRsczBKNEEwZmJKbE5LVnN1allkRjI0Q2Rjc24zNHpYbXBYR0d2bEtm?=
 =?utf-8?B?RTU5cVEvMFdxS0hDdjErYTZsK1dad1ltZHlxYmI2MnY2MERwbkJFcWxkb3J3?=
 =?utf-8?B?b3dTQUJyMCs5aFllQkNNN1pMZ1hLcytNMm82Q3h4S2V0bVhtU2hETCtsMW5m?=
 =?utf-8?B?VDZ5bkUxQkNZY2NXSE9LM3pzeU5tOWZtUEhLQ2lnZ1lxSnk0eE55U1ZuZm5U?=
 =?utf-8?B?UEpyRHgxbDFlVnJTRjN2MGNwWFEvbnZvSFRuZU84VjR3UDgvRXpJVk5WQnZy?=
 =?utf-8?B?bytqS1cyMEdZc3E5NHBTZGtJeDgyNitnTG55K2hUd29yRTZtK0gxekZ3Z2E0?=
 =?utf-8?B?aDFHQ2pWUEM1L2tWREJsTFk5bnpYSnBjRlB1V3ZtdVQ4R0hQQkZ5Y3p2MmQv?=
 =?utf-8?B?ZFh3ZlRYS2xwMVpxUTBOL2RRMmEyWi9HU0hvMTFna0RSMGhaT0xsUTNTdGtx?=
 =?utf-8?B?RDJsSGI1WGMxcHl6aEpoUEFCVm1GeTRSNGtTc081anFyUzFLWTExY2xCdmJH?=
 =?utf-8?B?b0RBOGJMNnFXNlllWGxxcDZqek1tcWY1VHdrRWliSHFJY1BiUEk5S1NqYmdO?=
 =?utf-8?B?VWVXYlhIODFiUnozVlNyb2lIOVgyZVNyeC9jVFlzWjdTRWszYnBsanRnSHZO?=
 =?utf-8?B?SVo0WlRvalI1ZTBNMEF1eS92VEFsOHp6QnpwQWcxUTJKREFBbEtUQmIxd0Vr?=
 =?utf-8?B?VE9PVFRaUDNUQjRjelVDa284eXFWTVZBRURKTzZzTFlYdG40ajlteG93RGpk?=
 =?utf-8?B?bnh4V0ZqbHFvMnJTUUFwdTFJWUVGb08zaWdWVGVsVzdRL0hzelpYUlJUay9a?=
 =?utf-8?B?SEFlMWpWRW9pdVQzbkNVbmdlZHBwcjV2S3h6TlVXZ0RDN3pPakhvYnlvbHdl?=
 =?utf-8?B?enpCRTByc1hCdHVXY212MVMrWnpLMmRXc1pvY1RkVWdNTHpWRldjc0ZXalFN?=
 =?utf-8?B?eEg4TjA5c3FaYTI0RFAweHNyV01WMXFWMWZzUmxBTVhhUVQ2bXRJSXB4QXJN?=
 =?utf-8?B?NVRNUmVJSFdPMHFxOWJBN284OFZsZWV0RjlTb2xRdU9leEdWLzV4b0xRR0Z6?=
 =?utf-8?B?THh6RitZcGxpclhLRk1zSVBvSTZYcHZiZlZ6cXUvaDVUV3I4S08wNXdzZElO?=
 =?utf-8?B?SjlwdXZ1bmhscjhFSU1iWitPcC9ZWGFlamVTbHZIWXRNbjY5Wnk1STE1VG5S?=
 =?utf-8?B?QSsweWV5ZzlBbXpkZjZZQzNjRjFEZ3FMaFlPMnNtK2dvcXB5WWUxK1lRdi90?=
 =?utf-8?B?YlJCUUM4T210SGtNejYzQlNmQnJaVWViZkVkclRiQ05BWko5T3FaV05UNkdZ?=
 =?utf-8?B?blhiUGpmRlFTM3JuWTR0ZHpXdUZLOGxKV1JrK0xTb1UzbXdiT1JBcUx1emFl?=
 =?utf-8?B?eWhBVXdPbis1aXVPY1loSFl6RTBRYXlqZjdKUDE3SHlxTFJHb2ZRSE5kVlhK?=
 =?utf-8?B?RzdhbEFRYmkwUjlkS0ZTd2R1QXdENWZDU0JrOWE3c1BSREVvNjBWcjZnbDBi?=
 =?utf-8?B?c3JSWnc5eHg2UWZHOUVhTTBkc0x2Sk9maVhyMjJUZEhDT29HV1V1Mk5ONEY0?=
 =?utf-8?B?NHZaMVNlUGxaTVFqaVV3WklSbGd1ZTZzUmFDUzNSSDYzdlFtdnlQWlN6TmNQ?=
 =?utf-8?B?dTI5TWhWRnJnTUVhY1hDK0I1UUNtUDBPWk9MVkNiazVtRWRSS1hkaGpTUmxR?=
 =?utf-8?Q?+nlzQdjPhCZLayo0ZGHuI/15L?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC020D062C82DC4083E6ED504C5DBC50@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bd94e6-e57e-4f0e-aceb-08da6103e18d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 17:04:12.2832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSnBsu3Ib0DmAIlWhXdSyl9JUYWBoTpHizxa/XDFi4VM5ZdkyqZQumXVpVWC7MM0+JEnJD3bC15QAG2RuD7atw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4920
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSnVsIDgsIDIwMjIsIGF0IDc6NDkgQU0sIERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBpbnRl
bC5jb20+IHdyb3RlOg0KDQo+IOKaoCBFeHRlcm5hbCBFbWFpbA0KPiANCj4gT24gNy83LzIyIDE3
OjMwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPiANCj4gWW91IG1pZ2h0IHdhbnQgdG8gZml4IHRoZSBj
bG9jayBvbiB0aGUgc3lzdGVtIGZyb20gd2hpY2ggeW91IHNlbnQgdGhpcy4NCj4gSSB3YXMgcmVh
bGx5IHNjcmF0Y2hpbmcgbXkgaGVhZCB0cnlpbmcgdG8gZmlndXJlIG91dCBob3cgeW91IGdvdCB0
aGlzDQo+IHBhdGNoIG91dCBiZWZvcmUgSHVnaCdzIGJ1ZyByZXBvcnQuDQo+IA0KPj4gRnJvbTog
TmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4NCj4+IA0KPj4gQ29tbWl0IGFhNDQyODQ5NjBk
NSAoIng4Ni9tbS90bGI6IEF2b2lkIHJlYWRpbmcgbW1fdGxiX2dlbiB3aGVuDQo+PiBwb3NzaWJs
ZSIpIGludHJvZHVjZWQgYW4gb3B0aW1pemF0aW9uIG9mIHNraXBwaW5nIHRoZSBmbHVzaCBpZiB0
aGUgVExCDQo+PiBnZW5lcmF0aW9uIHRoYXQgaXMgZmx1c2hlZCAoYXMgcHJvdmlkZWQgaW4gZmx1
c2hfdGxiX2luZm8pIHdhcyBhbHJlYWR5DQo+PiBmbHVzaGVkLg0KPj4gDQo+PiBIb3dldmVyLCBh
cmNoX3RsYmJhdGNoX2ZsdXNoKCkgZG9lcyBub3QgcHJvdmlkZSBhbnkgZ2VuZXJhdGlvbiBpbg0K
Pj4gZmx1c2hfdGxiX2luZm8uIEFzIGEgcmVzdWx0LCB0cnlfdG9fdW5tYXBfb25lKCkgd291bGQg
bm90IHBlcmZvcm0gYW55DQo+PiBUTEIgZmx1c2hlcy4NCj4+IA0KPj4gRml4IGl0IGJ5IGNoZWNr
aW5nIHdoZXRoZXIgZi0+bmV3X3RsYl9nZW4gaXMgbm9uemVyby4gWmVybyB2YWx1ZSBpcw0KPj4g
YW55aG93IGlzIGFuIGludmFsaWQgZ2VuZXJhdGlvbiB2YWx1ZS4NCj4gDQo+IEl0IGlzLCBidXQg
dGhlIGNoZWNrIGJlbG93IHVzZXMgJ2YtPmVuZCA9PSBUTEJfRkxVU0hfQUxMJyBhcyB0aGUgbWFy
a2VyDQo+IGZvciBmLT5uZXdfdGxiX2dlbiBiZWluZyBpbnZhbGlkLiAgQmVpbmcgY29uc2lzdGVu
dCBzZWVtcyBsaWtlIGEgZ29vZA0KPiBpZGVhIG9uIHRoaXMgc3R1ZmYuDQoNCklmIHdlIGdldCBh
IHJlcXVlc3QgdG8gZG8gYSBmbHVzaCwgcmVnYXJkbGVzcyB3aGV0aGVyIGZ1bGwgb3IgcGFydGlh
bCwNCnRoYXQgbG9naWNhbGx5IHdlIGhhdmUgYWxyZWFkeSBkb25lLCB0aGVyZSBpcyBub3QgcmVh
c29uIHRvIGRvIGl0Lg0KDQpJIHRoZXJlZm9yZSBkbyBub3Qgc2VlIGEgcmVhc29uIHRvIGxvb2sg
b24gZi0+ZW5kLiBJIHRoaW5rIHRoYXQgbG9va2luZw0KYXQgdGhlIGdlbmVyYXRpb24gaXMgdmVy
eSBpbnR1aXRpdmUuIElmIHlvdSB3YW50LCBJIGNhbiBhZGQgYSBjb25zdGFudA0Kc3VjaCBhcyBU
TEJfR0VORVJBVElPTl9JTlZBTElELg0KDQo+IA0KPj4gSW4gYWRkaXRpb24sIGFkZCB0aGUgbWlz
c2luZyB1bmxpa2VseSgpIGFuZCBqdW1wIHRvIGdldCB0cmFjaW5nIHJpZ2h0Lg0KPiANCj4gVGhl
cmUgYXJlIGN1cnJlbnRseSBmaXZlIHJvdXRlcyBvdXQgb2YgZmx1c2hfdGxiX2Z1bmMoKToNCj4g
KiBUaHJlZSBlYXJseSByZXR1cm5zDQo+ICogT25lICdnb3RvIGRvbmUnDQo+ICogT25lIGltcGxp
Y2l0IHJldHVybg0KPiANCj4gVGhlIHRyYWNpbmcgY29kZSBkb2Vzbid0IGdldCBydW4gZm9yIGFu
eSBvZiB0aGUgZWFybHkgcmV0dXJucywgYnV0DQo+IHRoYXQncyBpbnRlbnRpb25hbCBiZWNhdXNl
IHRoZXkgZG9uJ3QgKmFjdHVhbGx5KiBmbHVzaCB0aGUgVExCLiAgV2UNCj4gZG9uJ3Qgd2FudCB0
byByZWNvcmQgdGhhdCBmbHVzaF90bGJfZnVuYygpIGZsdXNoZWQgdGhlIFRMQiB3aGVuIGl0DQo+
IGRpZG4ndC4gIFRoZXJlJ3MgYW5vdGhlciB0cmFjZXBvaW50IG9uIHRoZSBUTEJfUkVNT1RFX1NF
TkRfSVBJIHNpZGUgdG8NCj4gdGVsbCB3aGVyZSB0aGUgZmx1c2hlcyB3ZXJlIHJlcXVlc3RlZC4N
Cj4gDQo+IFRoYXQgc2FpZCwgSSB0aGluayB0aGUNCj4gDQo+ICAgICAgICBpZiAodW5saWtlbHko
bG9jYWxfdGxiX2dlbiA9PSBtbV90bGJfZ2VuKSkNCj4gICAgICAgICAgICAgICAgZ290byBkb25l
Ow0KPiANCj4gaXMgYXJndWFibHkgYnVnZ3ksIGFzIGlzIHRoZSAnZ290byBkb25lJyBpbiB0aGlz
IGh1bms6DQoNCkkgd2FzIGp1c3QgdHJ5aW5nIHRvIGZvbGxvdyBpdCBmb3IgY29uc2lzdGVuY3ku
IFdpbGwgcmVtb3ZlLg0KDQo+IA0KPiBXZSBtaWdodCB3YW50IHRvIChldmVudHVhbGx5KSB0aGlu
ayBhYm91dCBkb2luZyBzb21ldGhpbmcgbGlrZSB0aGUNCj4gYXR0YWNoZWQgcGF0Y2ggdG8gbWFr
ZSB0aGUgc2tpcHBlZCBmbHVzaGVzIGV4cGxpY2l0IGluIHRoZSB0cmFjaW5nIGFuZA0KPiBtYWtl
IHRoZSByZXR1cm4gcGF0aHMgb3V0IG9mIHRoaXMgZnVuY3Rpb24gbW9yZSBjb25zaXN0ZW50Lg0K
DQpUaGF04oCZcyBmaW5lIHdpdGggbWUuIEkganVzdCByZWNvbW1lbmQgdGhhdCB5b3UgaGF2ZSBh
IHNpbmdsZSB0cmFjaW5nIGNhbGwgaW4NCnRoZSBmdW5jdGlvbiwgc2luY2UgaGF2aW5nIHRvbyBt
YW55IHJ1aW5zIHRoZSBnZW5lcmF0ZWQgY29kZS4NCg0K
