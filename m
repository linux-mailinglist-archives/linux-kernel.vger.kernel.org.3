Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5E34D6990
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 21:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiCKUjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 15:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiCKUje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:39:34 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2088.outbound.protection.outlook.com [40.107.100.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1A81D683D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 12:38:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMoV4Bg0+9++XD6Tx+ZBsEs7xFTu1p1WTJirNqJhTvCnnzOqOuHKLocIIYezc1al5dr+uLL6bJYIJKyBbccXiZiK/qodpzNt+D9OQLdvK372q2SPLqxDkGbEia7/ccnE2qGdW2je7fC8NYTEae/8H2t0jKNO5+0xZHxIkLDKZd3XESt33lw25kB3ffGfniwLG/wDWmBy0SYuIOZxiYsTmnhhFltwhvnPiBDSabbfRBoAed2Sd+GbL7lyMtBPNCGxx9rpvnKi1YelHnS+W4hEqHBB0SJTR2jMWFXjKWrydr4jKztwTXX/qkv4lH7d2prkjZBglskLfoQU/QnqJswV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLIhWIt6egpS0aR+9MbYyzLy3fBKnh0ITsSKMYQzlsQ=;
 b=m40M8aWhNXXkUlLpXL4kCtNxG+23wtgtqazbmXcSr/eh5BPqN/uHTMAGHqq2Ce6Y3Apv/QERrlbXw2f9IFCgqKse/Ayc+kwYIhJBgX7Eg5nap2OP3nqVn0ENXV4nU3Roo4lvCzSM8OOZExxDMVd/4AcEgsIDrN62IKSk/5mDM3qqs317+lw/oDw1Ngbn80hq6tc8A3gGMNEXe3tObuMoC7dhUPaz1k1qXY9jb7MwiLOG3pwlm4G+fkeGyw0nCJzan0dO+PmrO7dyqDoyOlixp+SwWfnq8hH72qaJ0dlXMh+LdGtMZM6rRUFBL00IqNI/WsfhG3c8Nmx3s3YAVnaYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLIhWIt6egpS0aR+9MbYyzLy3fBKnh0ITsSKMYQzlsQ=;
 b=F/Azx1kPzMFuvsHBGNgU+O+BSPwIgixwmeUZfNwGTIBifKeF4e4arZRs8IvmGOQsIEfgSOiD/eBqV3AoiXLu9k5uYUc/72Jxt1fF9grYUGB8f8DZq9IA8c9jgSdvaJRNwsNTdn2FWu9k9Q3SNLGHhQy/6/9yXNOzFZeh8xo7pCk=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BY3PR05MB8401.namprd05.prod.outlook.com (2603:10b6:a03:3c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.7; Fri, 11 Mar
 2022 20:38:27 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::6061:706:1081:df8b]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::6061:706:1081:df8b%5]) with mapi id 15.20.5081.007; Fri, 11 Mar 2022
 20:38:27 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RESEND PATCH v3 2/5] x86/mm: check exec permissions on fault
Thread-Topic: [RESEND PATCH v3 2/5] x86/mm: check exec permissions on fault
Thread-Index: AQHYNXs34FxnD5j+9kiqTRFDI355s6y6lS0AgAAPyIA=
Date:   Fri, 11 Mar 2022 20:38:27 +0000
Message-ID: <AC8D21EA-CD32-4F9F-B5C1-ED8804EC76FF@vmware.com>
References: <20220311190749.338281-1-namit@vmware.com>
 <20220311190749.338281-3-namit@vmware.com>
 <a2a43395-b848-a4f9-4065-109387680701@intel.com>
In-Reply-To: <a2a43395-b848-a4f9-4065-109387680701@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34f0524c-9bc0-4317-96b3-08da039f18d6
x-ms-traffictypediagnostic: BY3PR05MB8401:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BY3PR05MB8401CD114D83D55054FD557ED00C9@BY3PR05MB8401.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AgvnRl2USB4DJaGGPzagj2g3xl1zK57y813OrCFrqsIR63TeELK9SfzETuftCTXl+wqgmVUfDCOxSM6pjQI2SE3uU757Y9tSwclKsCuAGwwXZExeNH670E6NrR7PNLMs8IMy89ebYflUHq/Ju1eYv0tBN7QbPBbwYFE1DMkMUqDAOanxkCJrtdbcF6RE3vVQ+CBqMjNYFQ+C76UuuLqstNRu87qQB4kE6frruR5m1T8cDXNaj/0wdpj6k+e+p05iawl26hL3ApT73d8L5WxnxhN2+R9uCewzXDFGkEyE4eLJJLYiVkXyyNJCrjOqODXMHbVju33fBPXBarUOr8RyDLYM61AoBFKRsYXtQ2b8nRY24d2W+E/fqZn6YHQhxLCW+dYmyKNLvSiPaSOtMMW7KCAdkcvYemOw1OPQHwsbvwqZAtwQKDaapndVjQ9rO/E3Dc9J2qnj9a62LE+NqFtyx7cJd06W8w44wQRrfKWQuZZZi6Uc74V6RWWlkYwlRlsjeMJ3PIuvvUgw6Xa2Cze8ywmXqAnnVuMbAw3SvZjzKrUgYxaa7E85Wjk//R/021sQbUKVIfc8IaqBqB9HI+Ww4s5t+PXUnoW523+XCc0SOWMTCG7LJOzr9eaZ2rnHkLmiFpD2/wypImDFhr8Rvy7indMCUqOWhuGj7m7niw3+6bYe7mQ6n6ZElWrXIETBdcls7BAK2vHrl9W6CJTmoaFIZvqryUrTM6luVhHGk8mihKs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(5660300002)(76116006)(54906003)(186003)(2616005)(26005)(122000001)(7416002)(8936002)(38100700002)(83380400001)(6916009)(316002)(64756008)(66556008)(66476007)(66446008)(66946007)(8676002)(508600001)(2906002)(33656002)(6512007)(6506007)(36756003)(38070700005)(53546011)(86362001)(6486002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEthR3lzUExWRWczOWZNQXJLSDFtMXVQRFlWRjl5aVVRS1VtUHpDaGRSWUZr?=
 =?utf-8?B?UWVPMzcwOUtIMzdMemNyb0k2VWlIUGdoQlBlSlJOV1lueTZ0ZXF0TnNnWUQ3?=
 =?utf-8?B?d2VTV3M4ZVEwczBaOVlYS0RKUzEyaGNncFMxL0U5b1FFSS84dU1sMGJqdVJu?=
 =?utf-8?B?czVPSk5VUVl2MjBPTkVJVENlMER6ZTlReVFOdzhBZzBvZEZXM3crNFRaL1Fm?=
 =?utf-8?B?RHIyWmdGbEcrV3hwdHkzdTZYeUh5OGFMbnpWOW8rSjYvaFJ3SnlBU3VSSmJS?=
 =?utf-8?B?UlNzQk4xdmwwYmFhNnRxa2NCTkp3MzI0OEpDYkgwdFR3eHloeEpuK2pXbFIr?=
 =?utf-8?B?RS9yMjFDcWhaUW00VVhBNExEZE9hQlFPWWdoMnE0WEJON1RyQjkyck44Z0dB?=
 =?utf-8?B?Vzlqc1k1akpmQU1xOEJUZ1lnRTFuY2N1NWtzaCtmMlNldXdKUnR1VHRBV21Q?=
 =?utf-8?B?aTZWWmRDRU0zaCtFYnhQbmRvRHhVR2ppVzRMVHNDdHJNOC84QlZhWWdteXlh?=
 =?utf-8?B?UmpCaU1mYTN3SysvU2N5WVc4QzRuRFV4WVhEY0V0aW9SVEdtYnZuZThlWUF1?=
 =?utf-8?B?dUJUenhXRlZGQ0VsUHkvQXhNZHYxS3NhWHlJVFFrUWpqeEUxVlBBdjZ5VzhO?=
 =?utf-8?B?Rkh0dzNqM2hLOFR3V1ZSVS9YVEhqV2lNbUkxZ2VMSE1hdTVBREdFL2RRTHJ1?=
 =?utf-8?B?aW53UDhSWDBQalg5LzFJVXZDVUxqaEVxaGFBcG1YdXpxTm94U1R5ZjBtZVNm?=
 =?utf-8?B?cjJrZEp1eTgveHU5SHB4YVRBV2psQjVwbGJ6RzMvcmVpamtCNE1DblJTWW5I?=
 =?utf-8?B?ZGJUTWdqNk1oUHVuUmRLbzNsVCt1SENaT1RqREdHTXN5dzlCRWNyMmhDNXl6?=
 =?utf-8?B?cTNUMDlNKzl6eHZ4VlI5anA2NVNmOVN5a0pSblhFZHJzekhWMnpNYkZOcHJo?=
 =?utf-8?B?WGJVbTZ6NVV4WUFjdEIyTjVmNnBIdkV2RXVSWVgwc0M2dXFEcFZybU1NM0kx?=
 =?utf-8?B?Yk1tTElKT1NEQm96WkdNSitVUklvNVlYYmNHSEdYYmlyWGVkQVpIeHB0V0JB?=
 =?utf-8?B?bEZmODY1SUM2d2F5ajVDbStiZS9Iek45NU1iQlNhSjRldWk2VVMrdlBOZXRo?=
 =?utf-8?B?UjRiRk83THc3aW5YZ1ZoZ0dpR2s0SDVNVUZpOU4xRWhtdGNxbkJsdEhRZzA0?=
 =?utf-8?B?VW1ibTVwK3p4NFhpd0tqNWxtZmJXK3lNNm5HT05XYTMzUENHRFFjdjUzL1hp?=
 =?utf-8?B?ZzVhN3JZaUNRMHFsTzNWZkhmQ1FIMVpZeWZPbngxYlIxdlVUYVVYWlc2TDRP?=
 =?utf-8?B?RGZYNm0yYURPbUJFY0hBaUxmelowYWRycjhtWUsrL1pFM3RpdmF0YzUyN0pF?=
 =?utf-8?B?RHdhanBDWGhEQ1lUYk9PaEJEbEFXY1RqaDhDa1ZtQ3FlRlluU00yaVg4Q2dS?=
 =?utf-8?B?ako0STMvaE5aeTNyenI2R3gxWHNTMi82aWNNaEhJUlU0MmMyZ0lmMUtWK3ZD?=
 =?utf-8?B?a21PZlgzQ0tLZ0wxWEI0dHpJTVc2SmhDWkVuS0gwanBLK2FqMzNGUzJxUWIx?=
 =?utf-8?B?dlRBMWpWaldhc3N5enZRQk04enJDaTUxUVdkSktZK0pGcWJNUnNpaC9tT2NF?=
 =?utf-8?B?MmJHd0MxUUVpRjNKUDBzYUNhY2t2eHFnenROVnhWWHNnb1NjTGk0LzR1TVdw?=
 =?utf-8?B?My9nWTJSU2cyRW8vTUxCYXBUQ3pCQjZkY01iay9NSVZSd0I5K0ZsY2JWNXRr?=
 =?utf-8?B?SXUweVJ2bVNhUm9IYXRQeGc2eWN1SXJ3UmYyM3lzMHlMQzdQL0l6SWk0aW8x?=
 =?utf-8?B?cnNXaThFSS9lcUJwM1lrZ3RCaWxXV0ZSVXMvZVBUSjBmSVJqV3FtN1dLV2pX?=
 =?utf-8?B?NjlZQldiV2ozalZQQWtMWldyNGI0cWRWcyt5RTdyYmtrbjFweGJjUmQwdTVo?=
 =?utf-8?Q?nre7VOfeeMUcwWKOPa0uYUbC2gUO2jrl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA6ADDE0F99CC34C8DF9EDE7A557E20F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f0524c-9bc0-4317-96b3-08da039f18d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 20:38:27.7121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v44gSTezJdUwOZpUGGMaTZyKv9xI6QZnR1uFLldtrxvO+d5aDF2Z5LwH7xg57VBkaw0X8zK5haphvY+zui1O5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8401
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDExLCAyMDIyLCBhdCAxMTo0MSBBTSwgRGF2ZSBIYW5zZW4gPGRhdmUuaGFu
c2VuQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAzLzExLzIyIDExOjA3LCBOYWRhdiBBbWl0
IHdyb3RlOg0KPj4gRnJvbTogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4NCj4+IA0KPj4g
YWNjZXNzX2Vycm9yKCkgY3VycmVudGx5IGRvZXMgbm90IGNoZWNrIGZvciBleGVjdXRpb24gcGVy
bWlzc2lvbg0KPj4gdmlvbGF0aW9uLiBBcyBhIHJlc3VsdCwgc3B1cmlvdXMgcGFnZS1mYXVsdHMg
ZHVlIHRvIGV4ZWN1dGlvbiBwZXJtaXNzaW9uDQo+PiB2aW9sYXRpb24gY2F1c2UgU0lHU0VHVi4N
Cj4gDQo+IFRoaXMgaXMgYSBiaXQgbXVkZHkgb24gdGhlIHByb2JsZW0gc3RhdGVtZW50LiAgSSBn
ZXQgdGhhdCBzcHVyaW91cw0KPiBmYXVsdHMgY2FuIHRoZW9yZXRpY2FsbHkgY2F1c2UgdGhpcywg
YnV0ICpkbyogdGhleSBpbiBwcmFjdGljZSBvbg0KPiBjdXJyZW50IGtlcm5lbHM/DQo+IA0KPj4g
SXQgYXBwZWFycyBub3QgdG8gYmUgYW4gaXNzdWUgc28gZmFyLCBidXQgdGhlIG5leHQgcGF0Y2hl
cyBhdm9pZCBUTEINCj4+IGZsdXNoZXMgb24gcGVybWlzc2lvbiBwcm9tb3Rpb24sIHdoaWNoIGNh
biBsZWFkIHRvIHRoaXMgc2NlbmFyaW8uIG5vZGVqcw0KPj4gZm9yIGluc3RhbmNlIGNyYXNoZXMg
d2hlbiBUTEIgZmx1c2ggaXMgYXZvaWRlZCBvbiBwZXJtaXNzaW9uIHByb21vdGlvbi4NCj4gDQo+
IEJ5ICJpdCBhcHBlYXJzIG5vdCB0byBiZSBhbiBpc3N1ZSIsIGRvIHlvdSBtZWFuIHRoYXQgdGhp
cyBzdWJvcHRpbWFsDQo+IGJlaGF2aW9yIGNhbiBub3QgYmUgdHJpZ2dlcmVkLCBwZXJpb2Q/ICBP
ciwgaXQgY2FuIGJlIHRyaWdnZXJlZCBidXQNCj4gZm9sa3Mgc2VlbSBub3QgdG8gY2FyZSB0aGF0
IGl0IGNhbiBiZSB0cmlnZ2VyZWQ/DQo+IA0KPiBJICp0aGluayogdGhlc2UgY2FuIGJlIHRyaWdn
ZXJlZCB0b2RheS4gIEkgdGhpbmsgaXQgdGFrZXMgdHdvIHRocmVhZHMNCj4gdGhhdCBkbyBzb21l
dGhpbmcgbGlrZToNCj4gDQo+IAlUaHJlYWQgMQkJCVRocmVhZCAyDQo+IAk9PT09PT09PQkJCT09
PT09PT09DQo+IAlwdHIgPSBtYWxsb2MoKTsNCj4gCW1lbWNweShwdHIsICZjb2RlLCBsZW4pOw0K
PiAJZXhlY19ub3cgPSAxOw0KPiAJCQkJCXdoaWxlICghZXhlY19ub3cpOw0KPiAJCQkJCWNhbGwo
cHRyKTsJCQ0KPiAJCQkJCS8vIGZhdWx0CQ0KPiAJbXByb3RlY3QocHRyLCBQUk9UX0VYRUMsIGxl
bik7DQo+IAkJCQkJLy8gZmF1bHQgc2VlcyBWTV9FWEVDDQo+IA0KPiANCj4gQnV0IHRoYXQgaGFz
IGEgYnVnOiBleGVjX25vdyBpcyBzZXQgYmVmb3JlIHRoZSBtcHJvdGVjdCgpLiAgSXQncyBub3QN
Cj4gc2FuZSBjb2RlLg0KPiANCj4gQ2FuIGFueSBzYW5lIGNvZGUgdHJpZ2dlciB0aGlzPw0KDQpX
ZWxsLCByZWdhcmRpbmcgdGhpcyBxdWVzdGlvbiBhbmQgdGhlIHByZXZpb3VzIG9uZTogSSBkbyBu
b3QgdGhpbmsgdGhhdA0KdGhpcyBzY2VuYXJpbyBpcyBwb3NzaWJsZSB0b2RheSBzaW5jZSBtcHJv
dGVjdCgpIGhvbGRzIHRoZSBtbWFwX2xvY2sNCmZvciB3cml0ZS4gVGhlcmUgaXMgbm8gb3RoZXIg
Y29kZSB0aGF0IEkgYW0gYXdhcmUgb2YgdGhhdCB0b2dnbGVzDQp0aGUgTlggYml0IG9uIGEgcHJl
c2VudCBlbnRyeS4NCg0KQnV0IEkgd2lsbCBub3QgYmV0IG15IGxpZmUgb24gaXQuIFRoYXTigJlz
IHRoZSByZWFzb24gZm9yIHRoZSBzb21ld2hhdA0KdmFndWUgcGhyYXNpbmcgdGhhdCBJIHVzZWQu
DQoNCj4+IA0KPj4gaW5kZXggZDAwNzRjNmVkMzFhLi5hZDBlZjBhNjA4N2EgMTAwNjQ0DQo+PiAt
LS0gYS9hcmNoL3g4Ni9tbS9mYXVsdC5jDQo+PiArKysgYi9hcmNoL3g4Ni9tbS9mYXVsdC5jDQo+
PiBAQCAtMTEwNywxMCArMTEwNywyOCBAQCBhY2Nlc3NfZXJyb3IodW5zaWduZWQgbG9uZyBlcnJv
cl9jb2RlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkNCj4+IAkJCQkgICAgICAgKGVycm9y
X2NvZGUgJiBYODZfUEZfSU5TVFIpLCBmb3JlaWduKSkNCj4+IAkJcmV0dXJuIDE7DQo+PiANCj4+
IC0JaWYgKGVycm9yX2NvZGUgJiBYODZfUEZfV1JJVEUpIHsNCj4+ICsJaWYgKGVycm9yX2NvZGUg
JiAoWDg2X1BGX1dSSVRFIHwgWDg2X1BGX0lOU1RSKSkgew0KPj4gKwkJLyoNCj4+ICsJCSAqIENQ
VXMgYXJlIG5vdCBleHBlY3RlZCB0byBzZXQgdGhlIHR3byBlcnJvciBjb2RlIGJpdHMNCj4+ICsJ
CSAqIHRvZ2V0aGVyLCBidXQgdG8gZW5zdXJlIHRoYXQgaHlwZXJ2aXNvcnMgZG8gbm90IG1pc2Jl
aGF2ZSwNCj4+ICsJCSAqIHJ1biBhbiBhZGRpdGlvbmFsIHNhbml0eSBjaGVjay4NCj4+ICsJCSAq
Lw0KPj4gKwkJaWYgKChlcnJvcl9jb2RlICYgKFg4Nl9QRl9XUklURXxYODZfUEZfSU5TVFIpKSA9
PQ0KPj4gKwkJCQkJKFg4Nl9QRl9XUklURXxYODZfUEZfSU5TVFIpKSB7DQo+PiArCQkJV0FSTl9P
Tl9PTkNFKDEpOw0KPj4gKwkJCXJldHVybiAxOw0KPj4gKwkJfQ0KPiANCj4gYWNjZXNzX2Vycm9y
KCkgaXMgb25seSB1c2VkIG9uIHRoZSBkb191c2VyX2FkZHJfZmF1bHQoKSBzaWRlIG9mIHRoaW5n
cy4NCj4gQ2FuIHdlIHN0aWNrIHRoaXMgY2hlY2sgc29tZXdoZXJlIHRoYXQgYWxzbyB3b3JrcyBm
b3Iga2VybmVsIGFkZHJlc3MNCj4gZmF1bHRzPyAgVGhpcyBpcyBhIGdlbmVyaWMgc2FuaXR5IGNo
ZWNrLiAgSXQgY2FuIGFsc28gYmUgaW4gYSBzZXBhcmF0ZQ0KPiBwYXRjaC4NCg0KSSBjYW4gd3Jh
cCBpdCBpbiBhIGRpZmZlcmVudCBmdW5jdGlvbiBhbmQgYWxzbyBjYWxsIGl0IGZyb20NCmRvX2tl
cm5fYWRkcl9mYXVsdCgpIG9yIHNwdXJpb3VzX2tlcm5lbF9mYXVsdCgpLg0KDQpBbnlob3csIHNw
dXJpb3VzX2tlcm5lbF9mYXVsdCgpIHNob3VsZCBoYW5kbGUgc3B1cmlvdXMgZmF1bHRzIG9uDQpl
eGVjdXRhYmxlIGNvZGUgY29ycmVjdGx5LiANCg0KPiANCj4gQWxzbywgd2Ugc2hvdWxkICpwcm9i
YWJseSogc3RvcCB0YWxraW5nIGFib3V0IENQVXMgaGVyZS4gIElmIHRoZXJlJ3MNCj4gZXZlciBz
b21ldGhpbmcgd29ua3kgd2l0aCBlcnJvciBjb2RlIGJpdHMsIEknZCBwdXQgbXkgbW9uZXkgb24g
YSB3ZWlyZA0KPiBoeXBlcnZpc29yIGJlZm9yZSBhbnkga2luZCBvZiBDUFUgaXNzdWUuDQoNCkkg
dGhvdWdodCBJIG1hbmFnZSB0byBjb252ZXkgZXhhY3RseSB0aGF0IGluIHRoZSBjb21tZW50LiBD
YW4geW91IHByb3ZpZGUNCmEgYmV0dGVyIHBocmFzaW5nPw0KDQo+IA0KPj4gCQkvKiB3cml0ZSwg
cHJlc2VudCBhbmQgd3JpdGUsIG5vdCBwcmVzZW50OiAqLw0KPj4gLQkJaWYgKHVubGlrZWx5KCEo
dm1hLT52bV9mbGFncyAmIFZNX1dSSVRFKSkpDQo+PiArCQlpZiAoKGVycm9yX2NvZGUgJiBYODZf
UEZfV1JJVEUpICYmDQo+PiArCQkgICAgdW5saWtlbHkoISh2bWEtPnZtX2ZsYWdzICYgVk1fV1JJ
VEUpKSkNCj4+ICsJCQlyZXR1cm4gMTsNCj4+ICsNCj4+ICsJCS8qIGV4ZWMsIHByZXNlbnQgYW5k
IGV4ZWMsIG5vdCBwcmVzZW50OiAqLw0KPj4gKwkJaWYgKChlcnJvcl9jb2RlICYgWDg2X1BGX0lO
U1RSKSAmJg0KPj4gKwkJICAgIHVubGlrZWx5KCEodm1hLT52bV9mbGFncyAmIFZNX0VYRUMpKSkN
Cj4+IAkJCXJldHVybiAxOw0KPj4gKw0KPj4gCQlyZXR1cm4gMDsNCj4+IAl9DQo+IA0KPiBUaGlz
IGlzIGdldHRpbmcgcmVhbGx5IHVnbHkuICBJIHRoaW5rIHdlJ3ZlIGdvbmUgb3ZlciB0aGlzIGJl
Zm9yZSwgYnV0DQo+IGl0IGVzY2FwZXMgbWUuICBXaHkgZG8gd2UgbmVlZCBhIGNvbW1vbiAoWDg2
X1BGX1dSSVRFIHwgWDg2X1BGX0lOU1RSKQ0KPiBibG9jayBvZiBjb2RlPyAgV2h5IGNhbid0IHdl
IGp1c3QgYWRkIGEgc2ltcGxlIFg4Nl9QRl9JTlNOIGlmKCkgdGhhdA0KPiBtaXJyb3JzIHRoZSBj
dXJyZW50IFg4Nl9QRl9XUklURSBvbmU/DQo+IA0KPiANCj4gICAgICAgIGlmIChlcnJvcl9jb2Rl
ICYgWDg2X1BGX0lOU04pIHsNCj4gICAgICAgICAgICAgICAgLyogcHJlc2VudCBhbmQgbm90IGV4
ZWM6ICovDQo+ICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSghKHZtYS0+dm1fZmxhZ3MgJiBW
TV9FWEVDKSkpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDE7DQo+ICAgICAgICAg
ICAgICAgIHJldHVybiAwOw0KPiAgICAgICAgfQ0KDQpZb3UgYXJlIGNvcnJlY3QuIE15IGJhZC4g
SSB3aWxsIGZpeCBpdC4NCg0K
