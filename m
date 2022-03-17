Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD14DC79C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbiCQNdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbiCQNcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:32:53 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2048.outbound.protection.outlook.com [40.107.113.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2181D67E9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 06:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOkdvQNF2t7yRvAmA1AmS/0h7NRh/5OgCntMBqktx57QEpdT/jaP9Iayr8TWifJz9rrv4xbFrCpi7MUGvzVr3WCUt27bYlmamRzsb9TmK4Mg9qIAhVWS/U2ku4w1qoY6m1MVUJXB0xqPz0gXDVn/JoMVYKGuslvBF8gkzvrFZ1us3htTlTWb1Usq3O6nu1ko5F/C+1ixWpBrskIqGPw1h4cJxNHcN4RVlqB5/RuG0eZIr0t884ezW6rA8DFbrlvKIGVKABIvOjNCFrggFrw9+KFade0oceJvCEYEngay89LgXt+ZV912JWBypn7jnuWv9BFQ/VTB26qE5joaIzTrbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhRi/zXp23eUJtR3nChOdxIk6Hynr0ZnJ6IG+9e9FAI=;
 b=AGvFlzSeyhXdEUnDe6XuR9EvaUjX0NiAqj0lxyvnp7/U4lEaWvSxFRXP57zlFXXP7Y8Y+FunU1kOxqRGjmRwzrZqHH2sv92PN+uVCQdfKrzULtFIRfEnfHB+A4S20cEJIjpOYnVAtran+WrtfFzOHHnEWVxYArS/JUuszf7WJxNsd9sa4u13i4d+mKEMx66nG5cYPvKjCrr9SwLFTs83oEGLLzqhD3hEbt8yau//2tXYGlaj/0B/dcDc31Hf2Go8IV2JMf9iek5LnFfw4uypI9FWRJmQlZD12oxl4xceR3rSY08EmyloSyiD2H6i/3WxNZva+SUnuon+AJIm6yOfxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhRi/zXp23eUJtR3nChOdxIk6Hynr0ZnJ6IG+9e9FAI=;
 b=JoX/Q/IstHlyddNdq275chPRioZqPzzSEZtTO56XyqtLltApbKnSY2bVDRyTlqwMLznVkp1Ie/Rxwg0IPBCUNABoihbnk0MuP5OSK27eGGvu3Cxtc3Q/KMy6b9xu6RYTmHuCxht3J0IzLWs2ciHdbM9X9KjyOWUQsjrQt/fSEjM=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYYPR01MB6989.jpnprd01.prod.outlook.com (2603:1096:400:d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 13:31:34 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d%9]) with mapi id 15.20.5061.028; Thu, 17 Mar 2022
 13:31:34 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] mm/hwpoison: fix race between hugetlb free/demotion
 and memory_failure_hugetlb()
Thread-Topic: [PATCH v4] mm/hwpoison: fix race between hugetlb free/demotion
 and memory_failure_hugetlb()
Thread-Index: AQHYOS5qe2phiMy5W0mKSLaDsA79SqzCnmmAgAD13IA=
Date:   Thu, 17 Mar 2022 13:31:34 +0000
Message-ID: <20220317133133.GA32934@hori.linux.bs1.fc.nec.co.jp>
References: <20220316120701.394061-1-naoya.horiguchi@linux.dev>
 <7362f9ee-81fa-702a-7a03-1a91ecf0b58e@oracle.com>
In-Reply-To: <7362f9ee-81fa-702a-7a03-1a91ecf0b58e@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9215815d-38ae-4fbb-3aab-08da081a748a
x-ms-traffictypediagnostic: TYYPR01MB6989:EE_
x-microsoft-antispam-prvs: <TYYPR01MB6989DFE69B400313CDA9AC2EE7129@TYYPR01MB6989.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2bhYrb1OLXM24lQf/586xW7uiPM4bQOXGWzJAH+EM6xhCAwNPTfHCqRXahmo8x6hhahkDcJ31++Ju/drbocvzZOU+SBp2oxVA8mKYfY1uNUahu8gxgh6hOZgsUkLCpmeR1pvC5t0gV3cjkYyLoQ+9WFO/JHIzRdCXb8Fgek0AUkbJZJEt5Ckgd0EikTWANCcKEb2gy+DtKTxpKJN2IGtNFHN/MMHmDvAFiYovgEnstajDQj/lpz+8cShX32JRmE/I9qc02ko43UuCYA0AzBh5gaGqIS2ek2mCfTVmekAUYUyyWzN93tlrTY5vtp/bQM0V8+KyOw9rfByNIIy4sFul92L/5Xb0qtnuirh0I+V3FMOhT83J61pa7Loaeq5KnvFNt0Lq5Z1/GXYau4Z3DinhRQobtVURZDp/Y1JXIBi5/GNx5t0We6FBx73DeFl0jvLMTzkvvIZ/USkipmxUA2EMU+PPg4gG734YuCn3NYVyvcuz1R5Do0hlXFXdE1WNruzfnVGPP3zIpZb0SbyiIhNQ28wTzay7Cec12zfPdQEL1tjqeAgK2XuqZ+A3Nq9kZMm4vcLi1L23zL/vQ8V/PUTrP/Dw8oLjRETqm+k7ONq7SxLA7pzy5acHGXdm+Scm9V4Cs7nT0XaeYGy9PSQXWN309iTrccppeu7O+OT0PiqMbyfYJmqHGUcwP5C8JAv/BA/obs9mdsvUEbY7thrGlvXPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(33656002)(122000001)(82960400001)(66946007)(38100700002)(76116006)(8936002)(83380400001)(5660300002)(508600001)(66556008)(86362001)(26005)(64756008)(66446008)(66476007)(4326008)(1076003)(186003)(53546011)(54906003)(55236004)(85182001)(6916009)(9686003)(6512007)(71200400001)(8676002)(2906002)(316002)(38070700005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWRiaWxyb1FWMVUvYzRENFZSL1l2cThvaC9vc3cyMHA5KzFFcmZja0JiWnhz?=
 =?utf-8?B?K0pJZThvNFhEV0lhQysxSTRISXBBYkRoaW9QeXAxY3dlZm1HbVJCR0dZdUhW?=
 =?utf-8?B?K0tVejdGVVkxMm9EZXhSWG43aE92UUlld0pKZkNKRUsycFpWeC85WlNRMkV3?=
 =?utf-8?B?aXBsenk4Vnh5K0doUFN1dDkwUTg3NWJheVRPL0tEbDVUR2kydkZVb2t4QjdS?=
 =?utf-8?B?amN5WDJYQkFkVG9kT1lpUk1seit5eGtHY1lBZFlQL0FpTVZaTXZVMDUvN01t?=
 =?utf-8?B?eXBVRFNvVzVZbWlpYklsZ0VjKy9FbW1oaDFIOXBaOGt0N2lId3V1bU94SnU5?=
 =?utf-8?B?L2VQRWhjYmQ4bklRbExuTTVBZlN3clJuMkk4WDE2SGlsd3p2cnpKSjU4KytV?=
 =?utf-8?B?eDd5OEZzZkR0b3BtQS9pN2lPMjV2T2xaMndVdmxZeS9JcUpycEMvdFRBNFpv?=
 =?utf-8?B?RThqOGpDb2kvbEROcXVFMTBUT0ovelRZRkthMVVxV2JVdk1iSk4reFozcWV3?=
 =?utf-8?B?Q2hlZVJNYzVpdHg0TDZmZUxhY0ZLTVdzQzZ2T1VuWHZvMVo4ZTc1aEtPekI2?=
 =?utf-8?B?QzdmMlVISWJ5UWZ0Q3FPVTBlQUp4OW5SdUlzaGFtNFVuR3hJZmZkNUwyTkEx?=
 =?utf-8?B?VVliRE9nODl5SXREcDJWeDdQZFI2MndxTzRFTjh5QVRzNWRrQ1MydnNGcUpQ?=
 =?utf-8?B?SGsycWxpMDZheGQvWkJZejFBWlNZaFQ4VnhEaGIwOUh2M2lOS01XQm5MbWFT?=
 =?utf-8?B?WDN1aFI2b3lkTWdUYnRHM3VFU3FoSmZkU00xM3JxWjVPSmJwaWNJaHJwMFNH?=
 =?utf-8?B?NTFtQmhzbmVqME0wZVNyVVUyTjVYZVZxK1NuMCtKS2p6QWdzSXlLcEErTnlx?=
 =?utf-8?B?RllubkxPTTZWRWdMNlIyNnh2aGd5VklCVDVjamlNN3lzZFI5Ym12eEFaMUE3?=
 =?utf-8?B?aWs1UGhQVExuMkZ0U2FXeEI0U3NxRTM4ZlZoZmltUC9xVWlmbzJaSVhqRitD?=
 =?utf-8?B?L1NCdnB4Q3o1SjVyMTdPSDZzY3dqSnNMZnozOWFsZEpCMHhVWlljZlc5cHYv?=
 =?utf-8?B?aGcxSmlFVnc4Y0xHRkhhS3V1ZkkweVFSNkRodDNtOHU0eDNtUklWQklvaDN4?=
 =?utf-8?B?cEdSVG16Uk5jQ1FsQ0FjKzlRTzY4STlLbTNaenY2a3RJMjkvMGVKUEhPK0dS?=
 =?utf-8?B?YzgxU2lGU25nL2Rrdk9nM2gvaUszcVpzVjEvWUxlMTZiNHJ4VERkWmRuRGcv?=
 =?utf-8?B?Z3prSW9MQVRoaUllWk4yamp4clRDRnhwQjV4WHFPY25TbEZ5bzZueXZuQVNu?=
 =?utf-8?B?ZTdHOWJnNVE4bUQwT3B1Myt4SjMyWDZkdTVacHhjTk9GVEo1VHZiVkpHMXhE?=
 =?utf-8?B?d1ZFOEk5RjRzVzhjUGR1QnZSUjhEMG0zYmV1ZFhZTjBPU00zN1lOanY5UWpX?=
 =?utf-8?B?bWVONXFCVU4rUTRIdTBkUGZVNFhsMFU1c1V2Zm4zR2ljYzZaaFowTFN0aUZp?=
 =?utf-8?B?Tk1hbjBRbWZEcFMwNTlnNlplckVVNzNhUndLNmlBQVg2a29SQzdGTldsays4?=
 =?utf-8?B?R3VnU0s4VWIvQWNaYlRDV3JSUUpPSUVNSmZ1WTRQYS9GR1pyeWVESmlqWFNa?=
 =?utf-8?B?alUyL0dVMmxHcHpFSC8zUmVEdFdFamdlN05EK3MyVWh0UDdjazdvNFk4YmdX?=
 =?utf-8?B?djlGZ2pWQWZPTktUbGNUT3ZtaS9RekFhcXlqZElSUGNOMU0vWTg3ekdVZFNC?=
 =?utf-8?B?aFBTVGt6eGRIbkhYYW16aEdIVUpFcVhtYVJRT2hLVFAzUjh5a0VtZWo2a0FB?=
 =?utf-8?B?ZlR6RU4yMlU0QVI2dGl0bDkwT3ZZQm93Y0N0UFJxUWVnWHB3Z3NYVllMUkNn?=
 =?utf-8?B?VHl2SWtEcVBqRkU2TkV1QXpMc2I1QVIvZ3J6RTR5c3dGbjFtbDZLMUpwNG5p?=
 =?utf-8?B?SVJacnZmM09WNWdmZld1N1NmUDBnaEZQU3dPcmpUd1E4azdpZTF2dkl1NFNS?=
 =?utf-8?B?elE0S2hRNHlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9047C8419D65443A0C744F01B3A897F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9215815d-38ae-4fbb-3aab-08da081a748a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 13:31:34.3109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9E2tMF3KMpVpxLS/C262CofEAxD6hD6URhtXXm7d9YuHe+37tU6pn/6gZCcscDsIO0wqxcSVp8GOjDRRx24hCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6989
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXIgMTYsIDIwMjIgYXQgMDM6NTE6MzVQTSAtMDcwMCwgTWlrZSBLcmF2ZXR6IHdy
b3RlOg0KPiBPbiAzLzE2LzIyIDA1OjA3LCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gRnJv
bTogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+DQo+ID4gDQo+ID4gVGhlcmUgaXMg
YSByYWNlIGNvbmRpdGlvbiBiZXR3ZWVuIG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGIoKSBhbmQgaHVn
ZXRsYg0KPiA+IGZyZWUvZGVtb3Rpb24sIHdoaWNoIGNhdXNlcyBzZXR0aW5nIFBhZ2VIV1BvaXNv
biBmbGFnIG9uIHRoZSB3cm9uZyBwYWdlLg0KPiA+IFRoZSBvbmUgc2ltcGxlIHJlc3VsdCBpcyB0
aGF0IHdyb25nIHByb2Nlc3NlcyBjYW4gYmUga2lsbGVkLCBidXQgYW5vdGhlcg0KPiA+IChtb3Jl
IHNlcmlvdXMpIG9uZSBpcyB0aGF0IHRoZSBhY3R1YWwgZXJyb3IgaXMgbGVmdCB1bmhhbmRsZWQs
IHNvIG5vIG9uZQ0KPiA+IHByZXZlbnRzIGxhdGVyIGFjY2VzcyB0byBpdCwgYW5kIHRoYXQgbWln
aHQgbGVhZCB0byBtb3JlIHNlcmlvdXMgcmVzdWx0cw0KPiA+IGxpa2UgY29uc3VtaW5nIGNvcnJ1
cHRlZCBkYXRhLg0KPiA+IA0KPiA+IFRoaW5rIGFib3V0IHRoZSBiZWxvdyByYWNlIHdpbmRvdzoN
Cj4gPiANCj4gPiAgIENQVSAxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUg
Mg0KPiA+ICAgbWVtb3J5X2ZhaWx1cmVfaHVnZXRsYg0KPiA+ICAgc3RydWN0IHBhZ2UgKmhlYWQg
PSBjb21wb3VuZF9oZWFkKHApOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGh1Z2V0bGIgcGFnZSBtaWdodCBiZSBmcmVlZCB0bw0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJ1ZGR5LCBvciBldmVuIGNoYW5nZWQgdG8g
YW5vdGhlcg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
bXBvdW5kIHBhZ2UuDQo+ID4gDQo+ID4gICBnZXRfaHdwb2lzb25fcGFnZSAtLSBwYWdlIGlzIG5v
dCB3aGF0IHdlIHdhbnQgbm93Li4uDQo+ID4gDQo+ID4gVGhlIGNvbXBvdW5kX2hlYWQgaXMgY2Fs
bGVkIG91dHNpZGUgaHVnZXRsYl9sb2NrLCBzbyB0aGUgaGVhZCBpcyBub3QNCj4gPiByZWxpYWJs
ZS4NCj4gPiANCj4gPiBTbyBzZXQgUGFnZUhXUG9pc29uIGZsYWcgYWZ0ZXIgcGFzc2luZyBwcmVj
aGVja3MuIEFuZCB0byBkZXRlY3QNCj4gPiBwb3RlbnRpYWwgdmlvbGF0aW9uLCB0aGlzIHBhdGNo
IGFsc28gaW50cm9kdWNlcyBhIG5ldyBhY3Rpb24gdHlwZQ0KPiA+IE1GX01TR19ESUZGRVJFTlRf
UEFHRV9TSVpFLg0KPiANCj4gVGhhbmtzIGZvciBzcXVhc2hpbmcgdGhlc2UgcGF0Y2hlcy4NCj4g
DQo+IEluIG15IHRlc3RpbmcsIHRoZXJlIGlzIGEgY2hhbmdlIGluIGJlaGF2aW9yIHRoYXQgbWF5
IG5vdCBiZSBpbnRlbmRlZC4NCj4gDQo+IE15IHRlc3Qgc3RyYXRlZ3kgaXM6DQo+IC0gYWxsb2Nh
dGUgdHdvIGh1Z2V0bGIgcGFnZXMNCj4gLSBjcmVhdGUgYSBtYXBwaW5nIHdoaWNoIHJlc2VydmVz
IHRob3NlIHR3byBwYWdlcywgYnV0IGRvZXMgbm90IGZhdWx0IHRoZW0gaW4NCj4gICAtIGFzIGEg
cmVzdWx0LCB0aGUgcGFnZXMgYXJlIG9uIHRoZSBmcmVlIGxpc3QgYnV0IGNhbiBub3QgYmUgZnJl
ZWQNCj4gLSBpbmplY3QgZXJyb3Igb24gYSBzdWJwYWdlIG9mIG9uZSBvZiB0aGUgaHVnZSBwYWdl
cw0KPiAgIC0gZWNobyAweFlZWSA+IC9zeXMva2VybmVsL2RlYnVnL2h3cG9pc29uL2NvcnJ1cHQt
cGZuDQo+IC0gbWVtb3J5IGVycm9yIGNvZGUgd2lsbCBjYWxsIGRpc3NvbHZlX2ZyZWVfaHVnZV9w
YWdlDQo+ICAgLSBkaXNzb2x2ZV9mcmVlX2h1Z2VfcGFnZSByZXR1cm5zIC1FQlVTWSBiZWNhdXNl
DQo+ICAgICBoLT5mcmVlX2h1Z2VfcGFnZXMgLSBoLT5yZXN2X2h1Z2VfcGFnZXMgPT0gMA0KPiAt
IFdlIG5ldmVyIGVuZCB1cCBzZXR0aW5nIFBvaXNvbiBvbiB0aGUgcGFnZSB3aXRoIGVycm9yIG9y
IGhlYWQgcGFnZQ0KPiAtIEh1Z2UgcGFnZSBzaXR0aW5nIG9uIGZyZWUgbGlzdCB3aXRoIGVycm9y
IGluIHN1YnBhZ2UgYW5kIG5vdCBtYXJrZWQNCj4gLSBodWdlIHBhZ2Ugd2l0aCBlcnJvciBjb3Vs
ZCBiZSBnaXZlbiB0byBhbiBhcHBsaWNhdGlvbiBvciByZXR1cm5lZCB0byBidWRkeQ0KPiANCj4g
UHJpb3IgdG8gdGhpcyBjaGFuZ2UsIFBvaXNvbiB3b3VsZCBiZSBzZXQgb24gdGhlIGhlYWQgcGFn
ZQ0KDQpZb3UncmUgcmlnaHQsIHRoaXMgaXMgbm90IGludGVuZGVkLg0KSSBzaG91bGQndmUga2Vw
dCBjdXJyZW50IGJlaGF2aW9yIGZvciB0aGlzIGNhc2UgKHNldCBQYWdlSFdQb2lzb24NCmZsYWcg
b24gdGhlIGhlYWQgcGFnZSwgYW5kIG5vIHJlZmNudCB0YWtlbiksIHNvIEknbGwgdXBkYXRlIHRo
ZSBwYXRjaC4NCg0KSW4gdGhpcyBjYXNlIHRoZSBod3BvaXNvbmVkIGh1Z2VwYWdlIHJlbWFpbnMg
aW4gZnJlZSBsaXN0LCBidXQNCmRlcXVldWVfaHVnZV9wYWdlX25vZGVfZXhhY3QoKSBjaGVja3Mg
dGhlIFBhZ2VIV1BvaXNvbiBmbGFnIG5vdCB0byBiZQ0KYWxsb2NhdGVkLCB0aGF0J3MgT0suICBJ
dCBtaWdodCBub3QgYmUgb3B0aW1hbCB0aGF0IHRoZSBod3BvaXNvbmVkIGZyZWUNCmh1Z2VwYWdl
IGlzIGluIHRoZSBsaXN0IGZvciBsb25nLCBzbyBzb21lIG1lY2hhbmlzbSB0byBoYW5kbGUgaXQg
aW4gYQ0KZGVsYXllZCBtYW5uZXIuICBPbmUgd2F5IGlzIHRvIGNhbGwgZGlzc29sdmVfZnJlZV9o
dWdlX3BhZ2UoKSB3aGVuIGENCmh3cG9pc29uZWQgcGFnZSBpcyBmb3VuZCBpbiBkZXF1ZXVlX2h1
Z2VfcGFnZV9ub2RlX2V4YWN0KCkuICBJZiB0aGUNCmRpc3NvbHZpbmcgc3VjY2VlZHMsIGl0J3Mg
T0suICBJZiBpdCBmYWlscywga2VlcCBpdCBhcy1pcyBleHBlY3RpbmcgdG8NCmJlIGRpc3NvbHZl
ZCBuZXh0IHRpbWUuDQoNCkFub3RoZXIgcmVsYXRlZCBwcm9ibGVtIGlzIHRoYXQgd2hlbiBod3Bv
aXNvbiBodWdlcGFnZSBpcyBsaXN0ZWQgaW4NCmZyZWUgbGlzdCwgdGhlIGluZm9ybWF0aW9uIGFi
b3V0IHJhdyBlcnJvciBvZmZzZXQgaXMgbG9zdC4gIFNvIGlmDQpodWdlcGFnZSBwb29sIGlzIHNo
cmlua2VkIGFuZCB0aGUgaHdwb2lzb24gaHVnZXBhZ2UgaXMgZnJlZWQgdG8gYnVkZHksDQp0aGUg
UGFnZUhXUG9pc29uIGZsYWcgcmVtYWlucyBvbiB0aGUgZXgtaGVhZCBwYWdlLiAgU28gd2UgbmVl
ZCBzb21laG93DQprZWVwIGVycm9yIG9mZnNldC4NCg0KQW55d2F5LCB0aGlzIHdpbGwgYmUgZG9u
ZSBpbiBzZXBhcmF0ZSB3b3JrLCBJJ2xsIGp1c3QgZml4IHRoZSBwcm9ibGVtDQp5b3UgbWVudGlv
bmVkLg0KDQpUaGFuayB5b3UgdmVyeSBtdWNoLA0KTmFveWEgSG9yaWd1Y2hpDQoNCj4gDQo+IEkg
ZG8gbm90IHRoaW5rIHRoaXMgd2FzIGFuIGludGVuZGVkIGNoYW5nZSBpbiBiZWhhdmlvci4gIEJ1
dCwgcGVyaGFwcyBpdCBpcw0KPiBhbGwgd2UgY2FuIGRvIGluIHRoaXMgY2FzZT8gIFNvcnJ5IGZv
ciBub3QgYmVpbmcgYWJsZSB0byBsb29rIG1vcmUgY2xvc2VseQ0KPiBhdCB0aGUgY29kZSByaWdo
dCBub3cuICAgDQo+IC0tIA0KPiBNaWtlIEtyYXZldHo=
