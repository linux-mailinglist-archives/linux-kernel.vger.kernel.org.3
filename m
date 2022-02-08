Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AF54AE1DB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385800AbiBHTEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385768AbiBHTEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:04:41 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120044.outbound.protection.outlook.com [40.107.12.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070F9C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:04:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTKliQ6I6aqEvbec/RcAboIse5Q2g3J21F+nPAsGF1f1Z/ClgYUOHqr1phkxsuSK+oOq48Dz8NJrmYMGH/qdBv6XTmYOdilu8rhY4sgqFiNovlwzCZmMYEMCIObpVkRQe8CtHcPEmIngWdeexGBAWrlVL6ydeDGMm24m2g5S1wknlw601pXRRCooCa3A9i/UgMSXJW3FOFVAFG39SHuHql5IZL6ld+f530FAUUYkHcGdYB1mlnlPPMw2YRrLbsUWBfRVe1faTe3DczIm1QHDGXiPPQXWdomdtY1RbZBndWkorFVDEii3X6MPKJiRWDgA7jGxCvJVCjzx/rIXcPsPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXpCmX2snREFL/IFt5v/l86WCGij4azvUmwmbi5jMjo=;
 b=CmMxS37Z29N7ZL/VfUHf8wzA8TqvQNpaYtSoCsMvC8UOh3+DVfcubyVWXDQi5bUGzd9fWOSkC58lOjXLqD0OOhkI7F8+P0BwLbGVQExfqKeM5rIdTJWxut8sYLa4ERPGBaSE3TMfe4MfWUkIHcJEBrQBOj1aWR1VijKYIexdFWq+HRuCs4fSwA3JGEQVsf+wzGsEAxPN6R7FM4N2v3yK8WyEmMQcf+30p2xS4XhSGpSpxJ6zBMRTjdM6tBWOljVXQ0egfoDffwLNOpYpZ5vABKYl5gOP1KxaNBI3DHfX4HRiTQIpmeGQRGDEgjB1Bgu7I+5eoFHuBJRQwUgO8e3bnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB1898.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 19:04:36 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%9]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 19:04:36 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: Outline copy_overflow()
Thread-Topic: [PATCH] mm: Outline copy_overflow()
Thread-Index: AQHYHBJkq7mbG9/6hEGyy27arn6456yIjZ0AgAF3qoA=
Date:   Tue, 8 Feb 2022 19:04:36 +0000
Message-ID: <71382581-ffcb-dc1b-8719-ddbd7738fb4a@csgroup.eu>
References: <b9a31b025e729394e7081257870f0a0e73355a04.1644229010.git.christophe.leroy@csgroup.eu>
 <20220207124002.edd04bf6d2abac8a01e35144@linux-foundation.org>
In-Reply-To: <20220207124002.edd04bf6d2abac8a01e35144@linux-foundation.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fb0bc23-4750-4c48-772b-08d9eb35d99a
x-ms-traffictypediagnostic: PR0P264MB1898:EE_
x-microsoft-antispam-prvs: <PR0P264MB18985C9BA9E006D4D8E0BDBCED2D9@PR0P264MB1898.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qs+ufUHKegOQKOI/tDOhO9QP4FfPIMFJmdpBJ1Tt+9W6f+8Bsh2TfqyPCI/CTKvBfwnRrgCEW4MJUnX+oKBgHg2FzKJk3IdJ7mX918O5/5FiLPbgp05W7P4FIvLAaROpnqv4t5nP6bMcXA3HIb+4mnGXtwNffVgajKBBz+Uyj85py1q/bB3mQs3YJQPbiy4FRBVcgjGlcG/n5qO5pxhW0zT/xdTP9TnW039lPToKP/MWYPHHxAkhERd9kgYY5RVGNAHGtvp9+eaUgqwE0cH72hCJESqb3Jn+q4+gQ0hjIluy7PDhhdssWVZv/Kz9q1rnnsw6bhIruMp5iJ4JzzkfknTRNV6QTq/HQ54jatG0OyLNWmwKGMpqk3q3cmNQv4HPJFXeeMaG0ao9MU42qLWI09TB240rgLgaps8kq1sbhmFyYMfvFVpM/993VFWpPKizH0RyS1VLye4G1dnYnzECsCZYCgJf00bgWG9O08Kz6cAJA+rHVz0Eli9AsnS87end6V8S5G+ulnSiBMlP3TB4w6yoLdWfh8ZykzpELJuKfdEe95R/ms/r49Oc4LBZuaPglRLwDnLGiTjv78iAS0nKLOFVpuSeDVSAgqDQsBqoV61IEvFI8VRw9tr0lLW9RVxqRnsntkZOudkBLbledyQQ8qE1bCPpDw8iasU9A3mtsZnoh2V2H1qiPTRyPCeJndLoKKPrfOa1P9Y0fqeEEx3nuYvUsCTyqSkroKxyGKI+0wJ27Y1IJtc46J2vShmG9HblGyGDrLfy3JDxT2AmkxqIXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(5660300002)(6506007)(2616005)(44832011)(6512007)(38100700002)(4326008)(76116006)(91956017)(66946007)(8936002)(66446008)(36756003)(54906003)(26005)(186003)(8676002)(2906002)(66574015)(6486002)(508600001)(38070700005)(122000001)(6916009)(31696002)(31686004)(71200400001)(66556008)(316002)(86362001)(64756008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anpRNW9ZeEJteldrMTZsQ0lLa0lvMXM3MHVhWk1CdUFhUlhwRW1JODVWc3pH?=
 =?utf-8?B?cy9RWllLbld4cVNLRWYxU0doN3pWOHkrT0hiejBlNUVQT2FWd0RLUGg1RnZv?=
 =?utf-8?B?WXVnV3lWSERiVlFqV2VPK1pvMjdtbXFnTVdqMWVWUHh5OG1YNXdwejNJdjN5?=
 =?utf-8?B?cFkzcUt2eFRvOTBUdWpoVXkrOVBCbzhOUmZTQnNxYUFTOTJPZmdUTi9tVUpJ?=
 =?utf-8?B?R0paTmxqbUlvalZ6NHI2QVR6WktETFBZOGtxWklmWENFU0Q2UEJvRWJQUEJF?=
 =?utf-8?B?Q3QwdWFjTjhlSDBLTzRDNkFGZlRoZWVacExuS0VYbVhGSzlHdGQ0TGltWFJ3?=
 =?utf-8?B?Q1hxTVV6ZHYwTkI0ejh3Z0NWSFB4NUw3ZXAwdHVDUnR0SmowSHkrUnJETUlC?=
 =?utf-8?B?dnZVUVo5aWs4TVpDdnAzMmxqTE5xalRPWDZ3b3REU1NtNmU0ZDRpK1RvcXdO?=
 =?utf-8?B?b29LdEtWS3FQNmkyUHBWNEJhNjk2SWFkZGpWUkgzeHVza2JNNWtWbERERzhB?=
 =?utf-8?B?dDJIZDJnOS8yQ2d5TGtiYkNFaEZwU1l4Y01EYmhObkoxMkJUT0lESVBPTWpE?=
 =?utf-8?B?V1RTd0JhblBhRktacGNkRFFhelU5Y1pnYTZlMGlGSlV1MU1WbDFGbDJZd3Ev?=
 =?utf-8?B?d1JmeGhtSU1kSW1kZUpzQU11eFpycjE0ejNmZmROM3ZHeDFTdTkyNW0wMjFN?=
 =?utf-8?B?NkxqR1pHamdxM25EemFpTXFsSnd0aFpJY1NzMGVTem1LMDhPdXFnWWpIbVo0?=
 =?utf-8?B?RURtaTZ2b3MxcHMvYVhmMzNQb3BDYTJGTVdwanNabUJBNUVuYnQ4N0V5d3hp?=
 =?utf-8?B?Z2FrZHVxblc4SWQ0MzVEWEhkTTd2L3R1aDg0czBva2xJRjFGQmJJcmNaRktm?=
 =?utf-8?B?MEM3RkNoZmszNzlkeTR2QStMeFNYYjB3NnAxUElZdW85RVNOL3BmYTVPbzVp?=
 =?utf-8?B?MDlHS1I1SElpc0QwMmpraEN6QUYyWEtGRjIzRzUwaU1FSXBVbjhoWVl2VXFN?=
 =?utf-8?B?eG4rSHQ2Uk1NTlRXUC81NnhtTlBlOHZlSUdtR3FlYzJ0MVdXK2dBbHVpMS9p?=
 =?utf-8?B?WmVYU1VjVGp0eEhDRUR4d1lhSXdXaVVMKzA3V29Oem9QOHdmVXNTSUMxUEFa?=
 =?utf-8?B?QmN3QUJBWTNOV2o1N1oyU1N4T0ZKV3VMVWlHSE5HZTQ4ejRabmtnbUVIZGpU?=
 =?utf-8?B?SWxCSThPK1pGaVRROWhaTyt0VkRhbzBNNGVrdzBCYUpaNEJyYzZNZzZnZUtY?=
 =?utf-8?B?U1ZOK0tuOXZiUWQxbmtxeDZUSUF4dDljRnJQWlpkd0pHbmMzSHNvUDNUQXZo?=
 =?utf-8?B?ZElmMTFKbURSZEM3eXBhb285dWlTcHkwSDhjSEp5aEI5UUR2NThrandhRXNH?=
 =?utf-8?B?NGJweEJJUnZpN3dHK2ROWGF4SE14RTVmQUM2T2JLRW5nOGs0YzlsMHhKZlho?=
 =?utf-8?B?UlVud2lPUnh5MTVjV1MyM2pJQVpsVFVuSk9ySEFzRkxuM0ozbU5IS1didG5T?=
 =?utf-8?B?dldlN0lJc2hBdFJDZHVYQUhIV3JlYUpXSzVKZmsxNkFBU3pOUGZ1SnZlUTdl?=
 =?utf-8?B?SGViZWlOV1EvNnUzKzg2dEMrTW56YUVtZEFNRW5CQUZmbGJMeUVxSFlwaEFz?=
 =?utf-8?B?Q3g5VzVoK2VXZzh6UUhBVVZ1V3dRSjB5WFNaYlU5L1JjMm1BMHUvYlcvM0c3?=
 =?utf-8?B?SFNyNEdxcG45blc4RkZUU2pzcW80NE0wd0NpSDVOUnhDdzkvNnRUZGpZaC91?=
 =?utf-8?B?cDdKRTJSTkxMYTJTbzErVHllcmtkVGE2ajBMcHgrWDY1alJkMzMwbkRZR3l6?=
 =?utf-8?B?RVBUekxIRTQ3cytGak00U3dTOTQ3eXd0bkZsSUYxVHJZOHBCYitKanh6cHFX?=
 =?utf-8?B?Vkx1dHVqdlJpNWZYQXFMZGRLUHQ3dTJSaW9YTVNMRGMzUm5ZVlNYK3dGeGo4?=
 =?utf-8?B?U2E0OVpsN0V3S0xxejBtT0tXQ0VaTW5OSndzR2JYSlM1TkpkNzd4OTV2N1oz?=
 =?utf-8?B?TGc4MlM0cFdwNUp0Z2tuSTNEWkRUZFllVjZ2V3JVc1ViOGdQc0VrTkNpa1lL?=
 =?utf-8?B?VG51KytObDhWWnZpemNsMm44M0k1VlBlblVaaURaL3RwZnlFYzF1MHpTNm10?=
 =?utf-8?B?aHFlOVNlZmpDM3hpbFltdEptTElOTGxkOElKdk05TTJaVDZtQlJGcDdNK3FE?=
 =?utf-8?B?SVM2eSt6QitZOU4vNXFKR0FjOTFUVHR0aW5yYWFWMXZyUVZlUUNFSmRvU0ZF?=
 =?utf-8?Q?yqpm4YFpRYXKZCvEUg+igzZjiyB0pZs0sHJYYMyfvY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3756ED91A71F88418C0D81FCD58272EA@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb0bc23-4750-4c48-772b-08d9eb35d99a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 19:04:36.5271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cMp/1JHuDQen1nDOs4+iPpwfU6virQqaANA9zRG4nh89oEjBAqJL3qYLlbucA/Zon7DEYfkORQLhHBe/V+i88Vb4m+J4G57X7nInVrtLBQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1898
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA3LzAyLzIwMjIgw6AgMjE6NDAsIEFuZHJldyBNb3J0b24gYSDDqWNyaXTCoDoNCj4g
T24gTW9uLCAgNyBGZWIgMjAyMiAxMTo1NToxOCArMDEwMCBDaHJpc3RvcGhlIExlcm95IDxjaHJp
c3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOg0KPiANCj4+IFdoaWxlIGJ1aWxkaW5nIGEg
c21hbGwgY29uZmlnIHdpdGggQ09ORklHX0NDX09QVElNSVNFX0ZPUl9TSVpFLA0KPj4gSSBlbmRl
ZCB1cCB3aXRoIG1vcmUgdGhhbiA1MCB0aW1lcyB0aGUgZm9sbG93aW5nIGZ1bmN0aW9uIGluIHZt
bGludXg6DQo+Pg0KPj4gCWMwMDI0M2JjIDxjb3B5X292ZXJmbG93PjoNCj4+IAljMDAyNDNiYzoJ
OTQgMjEgZmYgZjAgCXN0d3UgICAgcjEsLTE2KHIxKQ0KPj4gCWMwMDI0M2MwOgk3YyA4NSAyMyA3
OCAJbXIgICAgICByNSxyNA0KPj4gCWMwMDI0M2M0Ogk3YyA2NCAxYiA3OCAJbXIgICAgICByNCxy
Mw0KPj4gCWMwMDI0M2M4OgkzYyA2MCBjMCA2MiAJbGlzICAgICByMywtMTYyODYNCj4+IAljMDAy
NDNjYzoJN2MgMDggMDIgYTYgCW1mbHIgICAgcjANCj4+IAljMDAyNDNkMDoJMzggNjMgNWUgZTUg
CWFkZGkgICAgcjMscjMsMjQyOTMNCj4+IAljMDAyNDNkNDoJOTAgMDEgMDAgMTQgCXN0dyAgICAg
cjAsMjAocjEpDQo+PiAJYzAwMjQzZDg6CTRiIGZmIDgyIDQ1IAlibCAgICAgIGMwMDFjNjFjIDxf
X3dhcm5fcHJpbnRrPg0KPj4gCWMwMDI0M2RjOgkwZiBlMCAwMCAwMCAJdHd1aSAgICByMCwwDQo+
PiAJYzAwMjQzZTA6CTgwIDAxIDAwIDE0IAlsd3ogICAgIHIwLDIwKHIxKQ0KPj4gCWMwMDI0M2U0
OgkzOCAyMSAwMCAxMCAJYWRkaSAgICByMSxyMSwxNg0KPj4gCWMwMDI0M2U4Ogk3YyAwOCAwMyBh
NiAJbXRsciAgICByMA0KPj4gCWMwMDI0M2VjOgk0ZSA4MCAwMCAyMCAJYmxyDQo+Pg0KPj4gVGhh
dCBmdW5jdGlvbiBiZWluZyBhIG5vbiBjb25kaXRpb25hbCB3YXJuaW5nIG9uIGFuIGVycm9yIHBh
dGgsDQo+PiBpdCBpcyBub3Qgd29ydGggaW5saW5pbmcuDQo+Pg0KPj4gT3V0bGluZSBpdC4NCj4g
DQo+ICJ1bmlubGluZSIgaXMgdGhlIGNvbnZlbnRpb25hbCB0ZXJtIGZvciB0aGlzLg0KPiANCj4+
IFRoaXMgcmVkdWNlcyB0aGUgc2l6ZSBvZiB2bWxpbnV4IGJ5IGFsbW9zdCA0a2J5dGVzLg0KPiAN
Cj4gRGlkIHlvdSBjb25zaWRlciB1bmlubGluaW5nIGNoZWNrX2NvcHlfc2l6ZSgpIGluc3RlYWQ/
DQo+IA0KDQpJZiB5b3UgdW5pbmxpbmUgY2hlY2tfY29weV9zaXplKCkgeW91IGxvb3NlIHRoZSBi
ZW5lZml0IG9mIGNvbnN0YW50IA0KZm9sZGluZyBhbmQgYnVpbGQgdGltZSBvdmVyZmxvdyBkZXRl
Y3Rpb24gZm9yIGNvbnN0YW50IHNpemVzLCBhbmQgSSdtIA0Kbm90IHN1cmUgX19idWlsdGluX29i
amVjdF9zaXplKCkgd29ya3MgYXQgYWxsIGlmIHVuaW5saW5lZC4NCg0KQ2hyaXN0b3BoZQ==
