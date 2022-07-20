Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A41957BCBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241058AbiGTRgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241074AbiGTRgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:36:15 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-bgr052101064001.outbound.protection.outlook.com [52.101.64.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083D0DFB7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYWKznO6ZFrYlf053TD0eOwo2Obfw7bTBAsQAqgTsqxcRP+BkLjB3YXFqbM4stwd/QYDpxWRhROiVK1xR45URvASXm5tSjoDjZAva2t2x5B7GAq93sYyowfSKa9XznSR7KiHLkpS24p5x1k7nopil9mFOfyoJSTVzuj8yXxBBOxpZBmeZLTMPVwZ+BAQ/0ij5QeyTDDAPmM3AMz1XkKSjdQ+NahFX++QmMYpe+ATG+PEZrNPOiiajHF5KPCIR6wsByupjjQc/dtgHhL2RHq23FKbDYShCMbe6bO8XBOncEab6WmSowsQjPybZJ2/FwImfy/wmgdkIjO4OVbsbLOpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc5YfH09Uc/4YfAv8J7zi7ivBF44wbJm4zJyeMbxsu4=;
 b=bXF4D0N7/37urgXEB37DXvRhUyKM6vP2MoAbGwCAFTyqzln/6hbZEa0mM7xNDLH5F2NyTcdbgfZ4InMEVo+Wr1q0box9G1H9uPqUKs7ftwXxSjRlMSU49D2i4/CS5v7h6RsUR925XPriqGoUetvHlaHmFIGtyKfQnh2TyMIOW/c+YRCShYbkG00jdsz/9iKw0LKInVMOkfT5pbsVYz3P9YvNh7Zzkpx1o1rLZ8EWLa3gSTE1UAR2LqKL7XMPfinENC5aNXij778NKrEtLJuZtnxpAkv2BL2mdyNISMZcJ0a6/agNv3wr/D3fW5OXSzVo/ZJu6jLyDwUsJSBqW2aMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc5YfH09Uc/4YfAv8J7zi7ivBF44wbJm4zJyeMbxsu4=;
 b=nX1LYv/uHlO6nIp230ntwsubvggR5HCvR+xCL5ef36Ny9kO6pocloBPRCm6qIMmLyKpKIlSPn957q8bFYajtQ02V9P8wampsgmnqTi089Q7qRSrDGHEK0XByvUi0MHezObx6JhWDq+rXrojyXcuwrvm+Z293Li9OI4qK0TE2mns=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BN7PR05MB4498.namprd05.prod.outlook.com (2603:10b6:406:fd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.15; Wed, 20 Jul
 2022 17:36:11 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0%7]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 17:36:11 +0000
From:   Nadav Amit <namit@vmware.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
Thread-Topic: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
Thread-Index: AQHYmt3UDYXRE1Mixk6cAVqRRHRrrq2HBGsAgACEQIA=
Date:   Wed, 20 Jul 2022 17:36:11 +0000
Message-ID: <99AFB0A0-B2F8-420A-8164-1705EC14B255@vmware.com>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-2-namit@vmware.com>
 <09d84297-65d5-a3df-fdc0-a7168cdb0798@redhat.com>
In-Reply-To: <09d84297-65d5-a3df-fdc0-a7168cdb0798@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 685a3600-106a-489c-8cc6-08da6a76568e
x-ms-traffictypediagnostic: BN7PR05MB4498:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NycbCzvF1uasbQJQ934qvLVzZJP728gUZdZjCEruyP1Lf3pjBum5rzFFUOAEkHVSdyO5eJbs/lQXrILaFw65hk9WSu+0xkHLRlc72RCQAUf8lKOlbcuD95izBrQSiKBiPDRVnlevsnLpf80TocCgSX9ypBJ5G46UueE4daunc6a+rQFWTi33Z448nreCean7CU1+qW5U3xMilK7sZ5knvX/QeIMx9o/mXbiI+FosV25ZCwDWnMdIj3vfurfOHqaMCg1sq6GlJXoX3O3hn1kQXcYaYcimMhWP/DJ4f5Ajft90nHJV55wt+7DIiX9kxxdHoujxMV2QpjX2k2yAJk/qCc2Vwf52SfusS56jLrTKX1Gf0tBIT9Yfl3PVVyWeRVr/RXWvYGdi9s3yMP0VFzhpwHgshv0AWvbB0V/lmW2C/zyS3v2/0hvNigHB0MJqD1YVdjDH0VRgZocCtqN1RQEDfJQMJGkeKNSW8YErMvEYi94ekVoBHoJMVvNgD0887jfNujRpKISm/VvAmvcmqnZXojEvxFz9UAYd5646Brs3XLvbiYO3OoAD8+wyQGmT+cQ90QcjVm5i7LMhX5E1SnQur/9lUwQuTiO4pE7wySx/lSIJhDQDOB47l1ePNPQ0MmX19ZVlEM84O9azI/tOKK/GCmOa0f6aqyQunML1eOkEn8hvAFaSLuZ9BIVuaVZe/zzAoDAI4hoIR+xDQQr7mBRildfBHvVe9Yj9ApawjuRBzW7+3CG/VtYKpjmFxdlrQ4ojQaZVwD9PaB5vHL2Vgis6OTj835BDYBNYTAg3T9zDR1UoaN09nP4KBk6+WXOAI8Mj4B3e9HMYV3FsjWZpJVnBoS5B4oKtkg0veBYmfE0u4OU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(6486002)(478600001)(71200400001)(6916009)(38070700005)(54906003)(83380400001)(86362001)(26005)(53546011)(33656002)(316002)(41300700001)(66556008)(64756008)(36756003)(76116006)(6512007)(5660300002)(6506007)(186003)(66446008)(66946007)(66476007)(7416002)(2616005)(8676002)(4326008)(8936002)(2906002)(38100700002)(122000001)(14143004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODlTeUtTVzE5cXd0b3p0SEpybkJ3N1Zray9XRTQ2OGllcnZqdjNNOU5pUXRX?=
 =?utf-8?B?bkx6ZG52SDdYWmhpdDd0dGwzNjJpSTFYUzY3ajRzUUtyYmNvMjY5U0kvdWZv?=
 =?utf-8?B?d3AzM1JOd0JESHVRK3dlbHI4bGttN3JFdktOVHVXRHM0emRuUmtiT1gyTllq?=
 =?utf-8?B?Y3ZSL2NyZmVYZml4Zko2a2krSHVvMlR6blNuVWxQQ3djUXByWTlxTXk2azBV?=
 =?utf-8?B?VG9iQmlJUE4wMGduM0VCWjNja1lxbUQzMEM1UTJJaTdaRURiUHZiS3JoRi93?=
 =?utf-8?B?ZkpkZHJkRXJ3RXg0bWRTUHJSNU92UDd3N0lLNEhMMzBsUHpnY3hBbUx6NUw3?=
 =?utf-8?B?OVlHZkRTZUZZbmxKWlRYSzlxTWl4NWc0dnRUUVNBWFh0bVJLVlhaK3FBWFZp?=
 =?utf-8?B?cnI2TjFENUdKWDNZa2pvUnNkbm5jS3BpQUcwZHhMaTF2bWN3cjFCWkdKT1ZU?=
 =?utf-8?B?RHh2clp3eDF3d3JwMzA2czFTWmFzb2hqRlhhRVlZZGdiUS81dFRVeFExSXlx?=
 =?utf-8?B?RElHVHBzQ0lrS1dWOFlMRTluT09ZMFpNVGVpZE5HY2lYZC9LU0RTb1pIMU5t?=
 =?utf-8?B?TStjZzNHTzNiSW1MSXdBa2RqN1Vmak5Ja2pqU1h4VjE2UGJiNjVueWJjV3FB?=
 =?utf-8?B?cHlPTDYvZGFjUVhkcGpGT3RlL3lPU3ovNldqUEN6ODlnY0lwN0JkZ3F1VW5K?=
 =?utf-8?B?ekFDMVlCNmg2dlgwM0dKdm9VQzBvNDJ4cHdmWk5aV2hnMW5aWGlIREQyTE9z?=
 =?utf-8?B?VVJVd0ZXTU1reGFGdjgwT2RuUGxRejRKOHd3Vkk0WVpQYTk2OUxUbSt3a1l1?=
 =?utf-8?B?WG5VNk9YN1pDems4aG11R09pSTh1VkRsMlIvVm9CcnFzK2ZLN3lTRDdMU1V5?=
 =?utf-8?B?Q1Z4alI5K0lxNkVwemZQeFNaRmhlWkczbjhWcTRHOHVrTmtkYXBzaytKazJW?=
 =?utf-8?B?V1cxV0tJd0VNWXBnV1I0aEp5TkRlVG0rSFZGMmlPdmJlRThOMFgxMnV6R2hG?=
 =?utf-8?B?MUdTaWYxaUtoUDVPTm5WaU5MYWNhT24zSEFGL3g1dzJXeFptcm1BaUpRR1Bw?=
 =?utf-8?B?aTEwa2xyTjZ4SHZTK1FTK1ZXa2wvTUN4eVRaL3NoQTdnTEJBdndlWitFUWhF?=
 =?utf-8?B?bW9lY0drYS9uc0J4MkN6eWxrQjFTaEExTUQwdW1kTHZjNkIxd2xtMHV4R1Br?=
 =?utf-8?B?VFZrZm1lSTErb1BDMFhXRjEwaEtaNjBkc2hJU0t4c1p1MXoyTHJwYnczcGJm?=
 =?utf-8?B?ZHdGdUMzSjAxNEs2OEhYcUc2ZUJUeThMc1NnTWd4aW9FRGdlNVR2RS9wV09D?=
 =?utf-8?B?Wjd5WGdIYVJmWk1zd3VJVWJEeFk5N2RLSXNoa2FEbWpmakZJQXdGN0p3Q1Zw?=
 =?utf-8?B?THZYZnQzc1FIMnFYR3RuTzdRUFU5YUtHZ1R4VXl3ME50K1QwUmgrL0xNY082?=
 =?utf-8?B?L0QzekFZRkhsSlZWblBOTGlIb1JiSVQwNGhGeDlmdTl5TXhCbk81K1A1U08w?=
 =?utf-8?B?bVQvY0FkTS9lcFVqOFNSUmJVNXMwYnNlSHBJNmpIZ0N1UUJ4dzBQVlIvWnBx?=
 =?utf-8?B?OHg2djVoZ0ppc3hCK3RLOFZ2cGdCMk1GR3V6aXQ4QkV0dUFGN1RkQ2xpVGI0?=
 =?utf-8?B?SmpmN2k5QkNQQzNVWk5LT3lzQXcrK1M0TGd2SnZOZ1ZwdjV3SnNwcDg0OWJu?=
 =?utf-8?B?TkFTUzZEaWdiQWVpRWZxSi9oOEthV0lEeXY2RHpLV0hqZEduS0J1eWk1dS9w?=
 =?utf-8?B?UHY5QWtZUFJSL003eUNKbmJRbm5zYzcwL29IVjlCOGEzTi9KdlNZRks5NkUx?=
 =?utf-8?B?MTZEYXNWTjN6MjNGcmkwRk01amFvTHZjeFg2YVdPa09ubHNHRWFFaVZNUTFE?=
 =?utf-8?B?TGJFVjl3c3NSc1U3RmwveG1zM3VpMlNCSDc0N1NjOWRyODA4cDBqQVRUeVVv?=
 =?utf-8?B?T21vYytTOUxBQWJNbVpRTlBCK2hMMXkxRjIvU1dsME9WYWpBWUtFVlpTQ3Jv?=
 =?utf-8?B?Z0Z1RVkzRkcxdzZqckxZZDJ3S1cvRTd4eEhRcHJlZWttK0gyVVFTbjQvV3dp?=
 =?utf-8?B?eTE3TVJTRXBESVVrUHVvd1lNNHkrUDE1UnMvZUdhaHc1SElaR05QR010YllS?=
 =?utf-8?Q?r5psEz7JFjgjYeYUZdL0vSE3Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <941C34D77A4B274F89D83B028F0705B3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685a3600-106a-489c-8cc6-08da6a76568e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 17:36:11.6901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nlit6nhGn5ZwbzLNVbw3n1GtbjhFwJHXgYcKID07LMl7CsVdGlSE3TET4RVsnbS3eElc9fO11oggM2iBMkN5SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4498
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSnVsIDIwLCAyMDIyLCBhdCAyOjQyIEFNLCBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVk
aGF0LmNvbT4gd3JvdGU6DQoNCj4g4pqgIEV4dGVybmFsIEVtYWlsDQo+IA0KPiBPbiAxOC4wNy4y
MiAxNDowMSwgTmFkYXYgQW1pdCB3cm90ZToNCj4+IEZyb206IE5hZGF2IEFtaXQgPG5hbWl0QHZt
d2FyZS5jb20+DQo+PiANCj4+IFdoZW4gdXNlcmZhdWx0ZmQgbWFrZXMgYSBQVEUgd3JpdGFibGUs
IGl0IGNhbiBub3cgY2hhbmdlIHRoZSBQVEUNCj4+IGRpcmVjdGx5LCBpbiBzb21lIGNhc2VzLCB3
aXRob3V0IGdvaW5nIHRyaWdnZXJpbmcgYSBwYWdlLWZhdWx0IGZpcnN0Lg0KPj4gWWV0LCBkb2lu
ZyBzbyBtaWdodCBsZWF2ZSB0aGUgUFRFIHRoYXQgd2FzIHdyaXRlLXVucHJvdGVjdGVkIGFzIG9s
ZCBhbmQNCj4+IGNsZWFuLiBBdCBsZWFzdCBvbiB4ODYsIHRoaXMgd291bGQgY2F1c2UgYSA+NTAw
IGN5Y2xlcyBvdmVyaGVhZCB3aGVuIHRoZQ0KPj4gUFRFIGlzIGZpcnN0IGFjY2Vzc2VkLg0KPj4g
DQo+PiBVc2UgTU1fQ1BfV0lMTF9ORUVEIHRvIHNldCB0aGUgUFRFIGFzIHlvdW5nIGFuZCBkaXJ0
eSB3aGVuIHVzZXJmYXVsdGZkDQo+PiBnZXRzIGEgaGludCB0aGF0IHRoZSBwYWdlIGlzIGxpa2Vs
eSB0byBiZSB1c2VkLiBBdm9pZCBjaGFuZ2luZyB0aGUgUFRFDQo+PiB0byB5b3VuZyBhbmQgZGly
dHkgaW4gb3RoZXIgY2FzZXMgdG8gYXZvaWQgZXhjZXNzaXZlIHdyaXRlYmFjayBhbmQNCj4+IG1l
c3Npbmcgd2l0aCB0aGUgcGFnZSByZWNsYW1hdGlvbiBsb2dpYy4NCj4+IA0KPj4gQ2M6IEFuZHJl
YSBBcmNhbmdlbGkgPGFhcmNhbmdlQHJlZGhhdC5jb20+DQo+PiBDYzogQW5kcmV3IENvb3BlciA8
YW5kcmV3LmNvb3BlcjNAY2l0cml4LmNvbT4NCj4+IENjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxp
bnV4LWZvdW5kYXRpb24ub3JnPg0KPj4gQ2M6IEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwu
b3JnPg0KPj4gQ2M6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+DQo+
PiBDYzogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+PiBDYzogUGV0ZXIg
WHUgPHBldGVyeEByZWRoYXQuY29tPg0KPj4gQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4NCj4+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4N
Cj4+IENjOiBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPg0KPj4gQ2M6IFl1IFpoYW8gPHl1
emhhb0Bnb29nbGUuY29tPg0KPj4gQ2M6IE5pY2sgUGlnZ2luIDxucGlnZ2luQGdtYWlsLmNvbT4N
Cj4+IC0tLQ0KPj4gaW5jbHVkZS9saW51eC9tbS5oIHwgMiArKw0KPj4gbW0vbXByb3RlY3QuYyB8
IDkgKysrKysrKystDQo+PiBtbS91c2VyZmF1bHRmZC5jIHwgOCArKysrKystLQ0KPj4gMyBmaWxl
cyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbS5oIGIvaW5jbHVkZS9saW51eC9tbS5oDQo+PiBpbmRl
eCA5Y2MwMmE3ZTUwM2IuLjRhZmQ3NWNlNTg3NSAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvbW0uaA0KPj4gKysrIGIvaW5jbHVkZS9saW51eC9tbS5oDQo+PiBAQCAtMTk4OCw2ICsxOTg4
LDggQEAgZXh0ZXJuIHVuc2lnbmVkIGxvbmcgbW92ZV9wYWdlX3RhYmxlcyhzdHJ1Y3Qgdm1fYXJl
YV9zdHJ1Y3QgKnZtYSwNCj4+IC8qIFdoZXRoZXIgdGhpcyBjaGFuZ2UgaXMgZm9yIHdyaXRlIHBy
b3RlY3RpbmcgKi8NCj4+ICNkZWZpbmUgTU1fQ1BfVUZGRF9XUCAoMVVMIDw8IDIpIC8qIGRvIHdw
ICovDQo+PiAjZGVmaW5lIE1NX0NQX1VGRkRfV1BfUkVTT0xWRSAoMVVMIDw8IDMpIC8qIFJlc29s
dmUgd3AgKi8NCj4+ICsvKiBXaGV0aGVyIHRvIHRyeSB0byBtYXJrIGVudHJpZXMgYXMgZGlydHkg
YXMgdGhleSBhcmUgdG8gYmUgd3JpdHRlbiAqLw0KPj4gKyNkZWZpbmUgTU1fQ1BfV0lMTF9ORUVE
ICgxVUwgPDwgNCkNCj4+ICNkZWZpbmUgTU1fQ1BfVUZGRF9XUF9BTEwgKE1NX0NQX1VGRkRfV1Ag
fCBcDQo+PiBNTV9DUF9VRkZEX1dQX1JFU09MVkUpDQo+PiANCj4+IGRpZmYgLS1naXQgYS9tbS9t
cHJvdGVjdC5jIGIvbW0vbXByb3RlY3QuYw0KPj4gaW5kZXggOTk2YTk3ZTIxM2FkLi4zNGMyZGZi
NjhjNDIgMTAwNjQ0DQo+PiAtLS0gYS9tbS9tcHJvdGVjdC5jDQo+PiArKysgYi9tbS9tcHJvdGVj
dC5jDQo+PiBAQCAtODIsNiArODIsNyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBjaGFuZ2VfcHRl
X3JhbmdlKHN0cnVjdCBtbXVfZ2F0aGVyICp0bGIsDQo+PiBib29sIHByb3RfbnVtYSA9IGNwX2Zs
YWdzICYgTU1fQ1BfUFJPVF9OVU1BOw0KPj4gYm9vbCB1ZmZkX3dwID0gY3BfZmxhZ3MgJiBNTV9D
UF9VRkZEX1dQOw0KPj4gYm9vbCB1ZmZkX3dwX3Jlc29sdmUgPSBjcF9mbGFncyAmIE1NX0NQX1VG
RkRfV1BfUkVTT0xWRTsNCj4+ICsgYm9vbCB3aWxsX25lZWQgPSBjcF9mbGFncyAmIE1NX0NQX1dJ
TExfTkVFRDsNCj4+IA0KPj4gdGxiX2NoYW5nZV9wYWdlX3NpemUodGxiLCBQQUdFX1NJWkUpOw0K
Pj4gDQo+PiBAQCAtMTcyLDYgKzE3Myw5IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIGNoYW5nZV9w
dGVfcmFuZ2Uoc3RydWN0IG1tdV9nYXRoZXIgKnRsYiwNCj4+IHB0ZW50ID0gcHRlX2NsZWFyX3Vm
ZmRfd3AocHRlbnQpOw0KPj4gfQ0KPj4gDQo+PiArIGlmICh3aWxsX25lZWQpDQo+PiArIHB0ZW50
ID0gcHRlX21reW91bmcocHRlbnQpOw0KPj4gKw0KPj4gLyoNCj4+ICogSW4gc29tZSB3cml0YWJs
ZSwgc2hhcmVkIG1hcHBpbmdzLCB3ZSBtaWdodCB3YW50DQo+PiAqIHRvIGNhdGNoIGFjdHVhbCB3
cml0ZSBhY2Nlc3MgLS0gc2VlDQo+PiBAQCAtMTg3LDggKzE5MSwxMSBAQCBzdGF0aWMgdW5zaWdu
ZWQgbG9uZyBjaGFuZ2VfcHRlX3JhbmdlKHN0cnVjdCBtbXVfZ2F0aGVyICp0bGIsDQo+PiAqLw0K
Pj4gaWYgKChjcF9mbGFncyAmIE1NX0NQX1RSWV9DSEFOR0VfV1JJVEFCTEUpICYmDQo+PiAhcHRl
X3dyaXRlKHB0ZW50KSAmJg0KPiANCj4gDQo+IFdoeSB3b3VsZCB3ZSB3YW50IHRvIGNoZWNrIGlm
IHdlIGNhbiBzZXQgc29tZXRoaW5nIHdyaXRhYmxlIGlmIGl0DQo+IGFscmVhZHkgKmlzKiB3cml0
YWJsZT8gVGhhdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8gbWUuDQoNCldlIGNoZWNrICFwdGVfd3Jp
dGUoKS4gV2hhdCBhbSBJIG1pc3NpbmcgaW4geW91ciBxdWVzdGlvbj8NCg0KSGF2aW5nIHNhaWQg
dGhhdCwgSSBkbyBub3RpY2Ugbm93IHRoYXQgcHRlX21rZGlydHkoKSBzaG91bGQgbm90IGJlIGRv
bmUNCm9ubHkgdGhpcyBjb25kaXRpb24gaXMgZnVsZmlsbGVkLiBJbnN0ZWFkIHdlIHNob3VsZCBq
dXN0IGhhdmUNCnNvbWV0aGluZyBsaWtlOg0KDQogICAgICAgICAgICAgICAgICAgICAgIGlmICh3
aWxsX25lZWQpIHsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwdGVudCA9IHB0ZV9t
a3lvdW5nKHB0ZW50KTsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAocHRlX3dy
aXRlKHB0ZW50KSkNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHB0ZW50
ID0gcHRlX21rZGlydHkocHRlbnQpOw0KICAgICAgICAgICAgICAgICAgICAgICB9DQoNCkJ1dCBJ
IGRvIG5vdCB0aGluayB0aGlzIGFuc3dlcnMgeW91ciBxdWVzdGlvbiwgd2hpY2ggSSBkaWQgbm90
IHVuZGVyc3RhbmQuDQoNCg==
