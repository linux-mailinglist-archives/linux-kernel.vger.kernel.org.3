Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30AA56C456
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239391AbiGHUCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGHUCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:02:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133931A38A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:02:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARmfcmbnunPIbbUARDW0OX1qV4/g8MahelDbhoKGb33BN2IZx8LXvYxmVot7JkGMvtULKsb5QbzIQlmSdlEY5hYgpiSwZ0PLJlIfIUNvR7AIEjwP1FvHTfY2pGqeiKTp/BqqRGSfLwVe6r7RpKV05zpej6Sfwjld+hR4iFqz1UdrxmrlShyXUyU9f9gLMnxzz8VcWeQbP3xvLk5TkYOwNMtT0NOfJkFA4nArFIb/2wF2IE7iPGRMiUTABHZA2x1cRr9qdvGoG1qjaZDrX4N8nvVrdXf7zYI4h0aMhw88XilIBjUy2gnTYHwQxDpJeGAp3DIw+xM1pkydwd3vM1yhiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqKyEvdEQbedG9moUKV8dMqUjBwHmfYWyh8tp2H7ndw=;
 b=d1eXcgUn8EeEUm1P4qd/o5+Z1/d4JFJ0CxQYJfoFVAnU8Fmc/pp8qrt6UjQgSjJBKqu1hHK0MZmf9egenY8YwCWMA1RNVbDWMC9RgB5/7qxgbQhk7HikfTlBfcOgn3YwT3V+ytD6Z2hkp9IQFCWVZJt+bJ4paR5VmB40P97rVP84s5QLcgiFAFt5jz22jafbmIBgfWMPgYiZGbnUU2jhz4p1L/zJRK6oSOk23l5HQq+sZTWOeNAgDMvXe/dhOQJxZNM9mieVPKi6dV4kTzmMAkd9ByyG4Xbxopd1fcKFKJ6Az/SEHM9IRjZxBRNviTvyAp1aFQXtPZfqW3NqUMRzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqKyEvdEQbedG9moUKV8dMqUjBwHmfYWyh8tp2H7ndw=;
 b=QLsr89LiVYZkC5ElgxPXv9p6/7QaBSAEMcq8K0l8nt51bPbS8tk0/9fvJEiSMAI/9Gvv7+5knqnj+jxVvA95AVsC2Yc7LJypgoEizK35MrjGSkoq+r4yXuieQy203u7BvLkE6ZyAWE5pmZerYC9LiLUXnjSADWlG2zIBE2Hej5Q=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by MN2PR05MB6831.namprd05.prod.outlook.com (2603:10b6:208:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 20:02:05 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%6]) with mapi id 15.20.5417.021; Fri, 8 Jul 2022
 20:02:05 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Hugh Dickins <hughd@google.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] x86/mm/tlb: ignore f->new_tlb_gen when zero
Thread-Topic: [PATCH] x86/mm/tlb: ignore f->new_tlb_gen when zero
Thread-Index: AQHYkqF/mvVmWIh+yUS8DjEvdZIjBK102rCAgAALPAA=
Date:   Fri, 8 Jul 2022 20:02:05 +0000
Message-ID: <49C173B5-CF12-44AA-BE00-689E99E65C23@vmware.com>
References: <20220708003053.158480-1-namit@vmware.com>
 <4eccbb3a-2b5a-039-e934-da451e469929@google.com>
In-Reply-To: <4eccbb3a-2b5a-039-e934-da451e469929@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38f03cff-0def-412a-913b-08da611cbb35
x-ms-traffictypediagnostic: MN2PR05MB6831:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SMSvOTcgcMWwPySBeBfNsqiirMsjIKU+l0x7vITZHcb1iNEEQt6+1HQ2bZmQQ4MV/4UEuDMRaicsLKZ83neeikbJZVGznzE9TejrRC55U/rxL+1XMh6rpmNqcLm1BDXpzHMTPooaxThUaGw3u+YoErRX36JEU0UqNYfDD1Qt20YS4oL0IbTeDiGIBR33DfifNo124ciIZuCgQawEj5iTW+IFphYnJmasEmVcAP/dmW2WZ9Cw7jo3JBV3/7drS0+now9DYnmAMoEckSI9QNG/xLnQEMYilTtesPgTboz2uQRi1VMk0339zwTgFolyfoneMh4NhNvevDzhnqKXnP6iEbs830WQ6zx/RK5JmvwKY3Pgyw5wXWlD0tXz34z3595yA1V5+VdRdK+6ntympi4dUqbSkJqEyznAvVHVkDDHmRoDKQNgFeB6lAzkQ+YTEmeE3DNauqSGFEicVvaL1JnLGtb9jzIlQA3oLuyMduvED0+sDDZTb6csRl8f5fLmgeL1/lqnrUGNIFrXx/7pCuIExm06fU7Vo+spVV6pJsiaT7WBAvbWYEq3FOyeD9aN0p480z5orasrDF4baBFcnvmYS092mkwAd0dKyQvupWHa6avXnvxfoJKEns4QpEmEYlQcPRPwaR48g7tjFwgte8uZJ4ta7AxRR6sUYCgX3B4XoL4rFm2aaWSh0FxLwnMwApBq++vl+IKpxq23vXxVeYxqwtI9pNyXQGzHdr4kzrpy9EiucVQFYoit11jfNI24crUJAJ2F7jKAkW+18tEW9l1SLrekM9wMfY6cVV4blihBIqUary1isMh6/j/5DzBOvRbdycScu0xQUuW7jp1430YIWTKlcBkH4UA4vZZQkKlTQk6Ffw0twW5y8OHhGj4G0p/5Wr8TG6JS6gR2NVopXJfsqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(186003)(2616005)(4326008)(38100700002)(54906003)(38070700005)(83380400001)(66946007)(36756003)(6916009)(8676002)(64756008)(71200400001)(76116006)(66556008)(316002)(66446008)(66476007)(53546011)(86362001)(478600001)(6486002)(7416002)(33656002)(41300700001)(6512007)(6506007)(122000001)(5660300002)(2906002)(26005)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STYwbHdlMTNFb25qUW9OWkcrK1hyaG5lOFhjSzA0UUU4WWFBU21DNlFCeG5J?=
 =?utf-8?B?V2MxeVROZmxKbnB3RGlMWlVBNk13YTJjZThzd3hPZjBzRkRadVhBYnhVQjBq?=
 =?utf-8?B?TU1hYnUwaXYrZ2drWTdOWmpML3FtRU1GTU04bTQ0RG84NG9KWklFa0NFbENu?=
 =?utf-8?B?aDZxTHc2UUZmdkZSaHNLSGcwZ1pmNSs3OGVUMDN5UEc3M3d0RVQxdk9PYWhD?=
 =?utf-8?B?d21ieGpqdDNEdjgvcS9BUW9JUHV3aW5hblM2V3lvemRzcVV2aHcwdjFJNjRP?=
 =?utf-8?B?T3E0ZnFFQlpidHRzTWxhbmZLOE9wYXVDVVR3dlFjYjJFb3R5VThjTElROXBy?=
 =?utf-8?B?Rlo2b1RhNG1iUTJSN3Q2dDRUSDBjZGRuNCs1dmpiY2ViVi9KRENhaXBGSHNM?=
 =?utf-8?B?NmpqSUVNa3J4STF0NmtpOTVkMlEzbkhKTExpMzF6Q1hwaldHK0FiVUlmdzVy?=
 =?utf-8?B?QnpyRis3QkpuVEJISEdsTVlyaHU5VVVBeTlpYU5Xdks1MGhtNnNlYWFHSFNG?=
 =?utf-8?B?bnBJK2lkYUhxMWNrWFFRUnI0UVpDWVZmMzhNbjNzZlJ4ZWFVQ0w2V1hTMnZQ?=
 =?utf-8?B?MmVvTXV0YXpvM294TUtuWVFFN25nSFpZa2xxaGN0RFBBUkw5Z0tUbDNZd2Rh?=
 =?utf-8?B?Ni9RQTVsMmQxQnlXOXFqcDRrakhXdjVhTDJuUXhJRC9HZjJIa1EyYTliK0Jm?=
 =?utf-8?B?RUlQNWVvYjh1bnNNS1ZYQWs0dDJaVUVWMzhOaS8wNm1hQTloVUYvbStBRU1u?=
 =?utf-8?B?Z29wMVFjSTlSdm5hMmFzSGZ3aEdBOWI0V2ZINk8xejVhYWFyVWhhY2tnT0Vi?=
 =?utf-8?B?NDRGbzBMNEdWZUhXRUN5ZVl1d2Y3MndJMTVSWHMzajQvWVJqVjVSenV1NnBW?=
 =?utf-8?B?UVJQUWtzNHVFUDZVREtKNHU2WGZlRkM2bTF2M2hITVpteHlVVjI0VjVFZVFq?=
 =?utf-8?B?SGxDU1NjM245L0N3NC96c29waXFPN0gyNFl2Tm1RVHdXQVB1S05IMGV0TU9F?=
 =?utf-8?B?d0JtUGxmSHNKRFZ6S3ZPQlN5bHdNWVlXZkh6d3A2TithZWw0dWU5ZmtGY0lO?=
 =?utf-8?B?OUVoNHBsa05pRnErRFdYQUhwZHJwY2J0QW9mTmNlWkExbW1OTE95TkxUaTFN?=
 =?utf-8?B?U21BeGZUaGZ3QjBoZ05lNFBPRVlnYURDOEN1Z1d2UnF3aUY4YngvcDJEYWx0?=
 =?utf-8?B?QmpWeVRNRENwKzlFdzIyeUd2UUF4UFpDQUZJVzJMS3RSdnQ2YU1wVnlTOXBU?=
 =?utf-8?B?dUppNndGYWZIWjhzZDMvTkw2L05UdVNEM3h4S3NXVWZSK1djVGVJRTdyR3Nr?=
 =?utf-8?B?R01jRTVKUVhOdTdSV1BlYzdsRFFKL1R1R1pJL3J3V3JwODhNSEwyN1VYQThx?=
 =?utf-8?B?MVVZMk5iT3hRM3ZTNkVrN0pZUFltbXpDNWtldis1MTNjQ1BtMmpSYXJzNWVp?=
 =?utf-8?B?T1o5NXk4c2cxTGJFNm1XcncxQzdscE9nOTJGd3ZIT3VLNjVqZjk1N25sMGkv?=
 =?utf-8?B?UW9ZMTU1YmhLYXRKcHpRcnhKSGs5OUJXYUJETG5Xb1orMDFGcno1L3JuZlU5?=
 =?utf-8?B?SC9aNnVhVkRwYXlQUGE2L2p0S0RLUVZoQUJ5QXJQTUpVZzZCV2xrSFRwK0NQ?=
 =?utf-8?B?cW93MHJWWE50TC8wbytrMkFjbEVIM0twcXczam43dlNCV3d5Z3Z3cEtXVUcz?=
 =?utf-8?B?L0hqSGZTekFPYk80dlFpY1YrY1dnd2RrWGU5RHM3Q29KK05NRjB0WlNpSDF0?=
 =?utf-8?B?MnllTXZ5RmtuSVB1KzdUcWtvMjdqNmowUittai9LYnd6dkU4ckpTM3NKeXdG?=
 =?utf-8?B?alFQUWwvdDcraStJSi8ycHVNd1pkSEl2TkpjOVFRNFJsaWdxOFB6ZE8rWU1W?=
 =?utf-8?B?UmlZL2F3S1BBNFFUVXgxUE4yREg5RHZlUmxyQ0RoR3Q3cnhCanlmNW9kbDN6?=
 =?utf-8?B?UWR4WXlreVNvT0dxTDdhK0VlaU9heDhab2lOODRXN1A3M2toeS92dHV0M3lW?=
 =?utf-8?B?K0hvT3ZuVHJsTmdYTUE4TmdZS1l3RkZJRFdKUFI4SERoSGtDQTJFQUpSa0cx?=
 =?utf-8?B?QUJVQTZnOEk5ak9icGhrQUt2U2FQQk5lMk5kK0xabm5CUko1UnRHN3ZtUG8y?=
 =?utf-8?Q?c9RXeN19UmDWW+D9h8+S2MJvb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7EC096ECC9D8E4B89BDBA1AA975FB7E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f03cff-0def-412a-913b-08da611cbb35
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 20:02:05.1363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2jrttuuTeqEkX0i6iW1cS9yJRcUVMe9WmWsh9GR+t7QVhJuKht/WLdpSUp+uE1Yv4xRul3u8fYHDEcsrALuHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6831
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSnVsIDgsIDIwMjIsIGF0IDEyOjIxIFBNLCBIdWdoIERpY2tpbnMgPGh1Z2hkQGdvb2dsZS5j
b20+IHdyb3RlOg0KDQo+IOKaoCBFeHRlcm5hbCBFbWFpbA0KPiANCj4gT24gVGh1LCA3IEp1bCAy
MDIyLCBOYWRhdiBBbWl0IHdyb3RlOg0KPiANCj4+IEZyb206IE5hZGF2IEFtaXQgPG5hbWl0QHZt
d2FyZS5jb20+DQo+PiANCj4+IENvbW1pdCBhYTQ0Mjg0OTYwZDUgKCJ4ODYvbW0vdGxiOiBBdm9p
ZCByZWFkaW5nIG1tX3RsYl9nZW4gd2hlbg0KPj4gcG9zc2libGUiKSBpbnRyb2R1Y2VkIGFuIG9w
dGltaXphdGlvbiBvZiBza2lwcGluZyB0aGUgZmx1c2ggaWYgdGhlIFRMQg0KPj4gZ2VuZXJhdGlv
biB0aGF0IGlzIGZsdXNoZWQgKGFzIHByb3ZpZGVkIGluIGZsdXNoX3RsYl9pbmZvKSB3YXMgYWxy
ZWFkeQ0KPj4gZmx1c2hlZC4NCj4+IA0KPj4gSG93ZXZlciwgYXJjaF90bGJiYXRjaF9mbHVzaCgp
IGRvZXMgbm90IHByb3ZpZGUgYW55IGdlbmVyYXRpb24gaW4NCj4+IGZsdXNoX3RsYl9pbmZvLiBB
cyBhIHJlc3VsdCwgdHJ5X3RvX3VubWFwX29uZSgpIHdvdWxkIG5vdCBwZXJmb3JtIGFueQ0KPj4g
VExCIGZsdXNoZXMuDQo+PiANCj4+IEZpeCBpdCBieSBjaGVja2luZyB3aGV0aGVyIGYtPm5ld190
bGJfZ2VuIGlzIG5vbnplcm8uIFplcm8gdmFsdWUgaXMNCj4+IGFueWhvdyBpcyBhbiBpbnZhbGlk
IGdlbmVyYXRpb24gdmFsdWUuDQo+PiANCj4+IEluIGFkZGl0aW9uLCBhZGQgdGhlIG1pc3Npbmcg
dW5saWtlbHkoKSBhbmQganVtcCB0byBnZXQgdHJhY2luZyByaWdodC4NCj4+IA0KPj4gRml4ZXM6
IGFhNDQyODQ5NjBkNSAoIng4Ni9tbS90bGI6IEF2b2lkIHJlYWRpbmcgbW1fdGxiX2dlbiB3aGVu
IHBvc3NpYmxlIikNCj4+IFJlcG9ydGVkLWJ5OiBIdWdoIERpY2tpbnMgPGh1Z2hkQGdvb2dsZS5j
b20+DQo+PiBDYzogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4+
IENjOiBQZXRlciBaaWpsc3RyYSAoSW50ZWwpIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCj4+IENj
OiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IE5h
ZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+DQo+IA0KPiBUaGFua3MgYSBsb3QgZm9yIHlvdXIg
cmFwaWQgcmVzcG9uc2UgYW5kIHRoaW5raW5nIGl0IHRocm91Z2gNCj4gKGJlZm9yZSBJIGdvdCBh
cm91bmQgdG8gYW55ICJub3BjaWQiIG9yICJub3B0aSIgZXhwZXJpbWVudHMpLg0KPiANCj4gSSd2
ZSBiZWVuIHRlc3RpbmcgdGhpcyBvbmUgZm9yIGEgZmV3IGhvdXJzIG5vdywgYW5kIG5vIHByb2Js
ZW1zIHNlZW4uDQo+IEkgZXhwZWN0IHlvdSdsbCBiZSBzZW5kaW5nIGFub3RoZXIgdmVyc2lvbiwg
bWF5YmUgbmV4dCB3ZWVrLCBtZWV0aW5nDQo+IERhdmUncyBjb25jZXJuczsgYnV0IHdhbnRlZCB0
byByZWFzc3VyZSB0aGF0IHlvdSBoYXZlIGNvcnJlY3RseQ0KPiBpZGVudGlmaWVkIHRoZSBpc3N1
ZSBhbmQgZml4ZWQgaXQgd2l0aCB0aGlzIC0gdGhhbmtzLg0KDQpUaGFua3MsIEh1Z2guIFNvcnJ5
IGFnYWluIGZvciBteSBtaXN0YWtlLg0KDQpDYW4gSSBwbGVhc2UgaGF2ZSB5b3VyIOKAnFRlc3Rl
ZC1ieeKAnT8NCg0K
