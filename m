Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484684E36FB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 03:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiCVC5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 22:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbiCVC47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:56:59 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2085.outbound.protection.outlook.com [40.107.113.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEBB3A721C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnvuVq01I2wx7fvo9KZv1qQDytYzdJBm5lVYVUDKAg2AZBkDutRzJ0IwrrKutCGhbhCbcZqiuUFMvAQNl4J3iMAuhE6aVU2dg9IjT/MZNOLHspW2kACA4ws2thyLJK7Tjy707UwK15f6+rBVxDKDiqDVH8kHIqGqFUkYzxzfCfwBXGqOOccLxgh1CAncoj6p49yvji+dfLY9dEWkoHC2L3FHRMRrOq6BvH+9ez2k2Stx482xLddFuwwRPRphL9syu8g3ecjZgbdFX/JzDKoQw7JRqyNxCOk8IXzq87BzHJldX5BhO3rmFXIJ+pqRM76BzSNU5GpYGOWyOMhUoksxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3CnOfZtzevBzoRS8RL/yNY2dv5y+VQimy9zpj0aS1s=;
 b=LYi7dWbcbOJ6qIFS5XPXrZDOAVY9b/WdFPgKgSYk162PSSI/XxD2+9b4qbp7LSBtiQ7AetvIllUltmnu0MVplTFkv79PS0y1MbV0H5Kr7XOjY6EX7qV1yGKILUjWWRQVjU5qYR/nVIm+oH3uGlvRt5o8l5Ro1keOviH4pLwMepvPIgs4BHnvfYKSvhZu35TXRq/WwC/qB/2AaSPWpq/qxrCyO4I51xIZr5u6fn7WS49JBKHL957OmhkCBUsNYszLkeFhTwJ3rBfPK6rMh1/yiEL4+cmINcxRMsMQDTyTM0hyWq4+n0euSqV52eatJz+oiQKRK3PLQqagxc+2vk14kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3CnOfZtzevBzoRS8RL/yNY2dv5y+VQimy9zpj0aS1s=;
 b=Zw5XVtSXmMnA/Dal9mTjNRA9/7bo8FY6CuvGrl04azPBWVatiW/ZQn8xbSFI+KF0cb4h7tbYotmaCMiq/UgogcRp4JtHbAVnXBd0ndHMo5tTWKKDat7Io8mNAW8DvpxQ/mI62uUQ6kCyTOTGrIlbDGUF2w8HapCqpCtWqEsieag=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB9461.jpnprd01.prod.outlook.com (2603:1096:604:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Tue, 22 Mar
 2022 02:55:30 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d%8]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 02:55:30 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] mm/hwpoison: fix race between hugetlb free/demotion
 and memory_failure_hugetlb()
Thread-Topic: [PATCH v5] mm/hwpoison: fix race between hugetlb free/demotion
 and memory_failure_hugetlb()
Thread-Index: AQHYPYZPUV0YUqyZX0uAEo2rlZPAm6zKtYUA
Date:   Tue, 22 Mar 2022 02:55:30 +0000
Message-ID: <20220322025528.GA188243@hori.linux.bs1.fc.nec.co.jp>
References: <20220318051612.271802-1-naoya.horiguchi@linux.dev>
 <CAHbLzkrYf=jF2ZGLur5JpB_smoUkp51e2x1v5mr3CD5z73D=Ow@mail.gmail.com>
In-Reply-To: <CAHbLzkrYf=jF2ZGLur5JpB_smoUkp51e2x1v5mr3CD5z73D=Ow@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87c57d94-4bb5-4383-4363-08da0baf6d59
x-ms-traffictypediagnostic: OS3PR01MB9461:EE_
x-microsoft-antispam-prvs: <OS3PR01MB946194DE4AB1AA26E16DE5E9E7179@OS3PR01MB9461.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y4jVLDaIwcJSifC2wWTJBXx1ydfge8UEicvSNI2jhIbWeUe8Bv04EY9Fd8bu8OP1+Omi3q9gXn10flX3KQuJj2AHPwJBhYdbusJtkGPeJK+CKHv4KXz9cQwrU2KbOrljLual2MW9suLfnHVcGvrvUBsCkJdmLPT4YfvLdpepHD5YecwZyRMQbFPgb7oEr7Bx7trRaum0y2AvZjVr8oTFdc2v6gobgklfn1BL7wZY8ohZR9NbeLH8T+rn2zniMfxZIDE1+z6qd897pE2rDbKI3xo3JnqlXH1j9gsyobNUCoR6hS0f4mqRO+PjPlxZAOe1dKsmjL3Dj2KZf//b2FzH7yoMepRukgBpkFzqC2bJEtB1KG27hDzU3pmYcedkxeh+3lplfLiL1NQExg5yQKeuuoAN6S95vxEN5wWQWH4Hz0XkAmY1hSb1++hpeVaOlIrnSE/D2FM/aUFumzdf3N/oy1F1h6qOgP/+afHM6fmoiTD6qgndS8uMhqYQvhF9eRwIdX7Wc5fdp54nPuY1qQ2uAMv4ehbnexCGLJRtv9nevkpA5gVqIvmVAzjaGo3HoFn/IUmJ6U0HqcXxaYkSBCq33tL//TJdLeaGdDJ0iov1m5wMbu+v+HP2rfiG7Ts4/jOLrXLjgj52mtpr7+p9OjpgNuo7q0z71UVgY6Lib+u8N0s5dOOHwBEhssdc+2amCKDtpL1MEYPoVRQivDYVX1XiDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(86362001)(122000001)(38070700005)(1076003)(6916009)(82960400001)(54906003)(508600001)(5660300002)(2906002)(53546011)(6506007)(55236004)(316002)(38100700002)(9686003)(8936002)(83380400001)(33656002)(85182001)(186003)(26005)(66556008)(66476007)(66946007)(8676002)(66446008)(64756008)(4326008)(76116006)(71200400001)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW1KVFpqT3hLcnJCNHJObjVCYUV6LzJFTzR0NW5YUVd6cjhxanQybnQ3N0Rl?=
 =?utf-8?B?ODk4bkJoMU1WKy8weEFTZ2hqMmN2MWRwaTVkNms0MkpxSWkyNmwrbEwzNTE3?=
 =?utf-8?B?ZGFadWtwTzhuTE1RQ3RmNndJbTA3TWR0aXZjSHYyenZHZzgzd0xlL2RNWUFj?=
 =?utf-8?B?U1pRcHV0aFZ3T3djbCtkRFZVOVlZUUlici9nMGxTN2wxQU0rWElkV1REendN?=
 =?utf-8?B?K1I4dmVxS1hMN0ZIbTV6UGxMSGxnNUg4cDlsbUlPbmlRMFhRS2RMd3Frb3BY?=
 =?utf-8?B?bGFUVUlFOEFaNk9JV2grR29VZXJOY3Z0N3prZnp4TUZHQjlmZ2loL3RMdFNL?=
 =?utf-8?B?UUt0emRtZ2h6RHpQeVNBdnZQY2NLZzBLTzZZTERZN0h3d2pKUVpQWEVWTmpH?=
 =?utf-8?B?VHhQcEFNc0VGempKdFB5RVJhWlJnMHNGVzVVd2RSbnJNZVZVM1hvT0h4VFVI?=
 =?utf-8?B?d1NKbkpxZVhvY1pkUWt6U21waVRYYjNJVHJQZEEyMldGZ1FFZVppbER6VjlO?=
 =?utf-8?B?alhQYXBGL2U1MFp4S0IzVEdTM2lWenkyTzIwaDZEbCtkcU1GWEJGWXhOaXMw?=
 =?utf-8?B?SCtTeTl5b1BqYXByNEVzUXA2NHhnL05INjlWVG9nZFlOb000NkFiTlhNMFJ6?=
 =?utf-8?B?UTFCUUxYN3RRVVU2bFNPbFRmeGtiVHFaMllOalQ2R0JUc1V3TmR0QlE0MDUy?=
 =?utf-8?B?MUdTYjFFQ0JtTVFqZlQxVUtSQkt6VTNoRlBDWDMvWHg4ZnJLL0V3aHJXd0x3?=
 =?utf-8?B?OFpoSTA4c283Y2dpQkQySWZrMitmazE2VDI0YzVPVVBPcEdxVTBwWExuc0Iy?=
 =?utf-8?B?TEdDUDdPaUJhK3BYRm5vbFV3NEFtblZTWDZKMENxZFl3bmM1Z0REdXk5TXhw?=
 =?utf-8?B?bUNMQU5ObWxib2k5N2pqQ3VtQWtqbEw0c2VKMWkvNXBCY21aNXl4Z0FNN0Jk?=
 =?utf-8?B?Z1VTanhKSnpUc2xWMElNZkFZc1BJbDNNZVI0ZWhEKy90R0p4QzROTmlxR0Nv?=
 =?utf-8?B?Ym1qOU1pOW12VFBZWWNGSXhIeTJBTHFURHZ6emczU0dzZGMwWWxpTVlvc1cx?=
 =?utf-8?B?R3daN3RtQ1V1YWhzbDBNRFQ4QW05eVkyaHNtdE8vWWZCaW1JTW9PeWs2WUJM?=
 =?utf-8?B?bWJPY0tPbmFYbzhLWTIzRStuRG50K3RIM2lDcEhjR3ZScy9NSzBEam5MdjVq?=
 =?utf-8?B?Q3Q0cm1WL2htSkc3VTZYckZvbXArMmxSV3l2V2k0bnRFL2R6b1lEWitnR1NG?=
 =?utf-8?B?cnlMMXhWdWdYbEF1OTdMMFNqYklUTm1yekpwVUZmdGh5RTlUV2Q1VStYMTcw?=
 =?utf-8?B?eTAwZm15eHJJUEFNSzJzZk1INlpoQm9DcTNzd0REYW5UZVhScmk2NVhIN0tp?=
 =?utf-8?B?UFBCbjI0VGpSS2hDTEdoSFIzeTkwendRSk1WSnlNL2NFZm8wcTRaSGRiMHZO?=
 =?utf-8?B?ZmxRMmxPNElET3NPY1RBMVJvbjBsQjhPM3EyRE4rMWFLTkFveURiWGtpT1B2?=
 =?utf-8?B?VTROd3NzbFhWdVVBQ3h5Z3dSVHNPRG9Qcm4wUGxTNHZkUC9vQytsdEhGU2dY?=
 =?utf-8?B?bTRMQ0VUc3ZieDl0MmxHMTc3VUZCR2lhZzRMM2VnbUhyVGxSRGtmL1RsbG9O?=
 =?utf-8?B?VE5EQmZQdGJxcjl3YzJra01DNTFaeXBEUWpZZ0cwa2FlVFJMMUdjTkxDNVVK?=
 =?utf-8?B?YzlJUndvMkg1SXhwUWFWN29qTTErckwzZDJ5V1VtOHB2Z0dBbklUazhOSG0z?=
 =?utf-8?B?VjBNcE5STVF6ZzI3SHgxODl0V3cxMHdjcVR4MlRnQXNHaVd5VzVkZlB6TnJs?=
 =?utf-8?B?ZER3UjF5Uk0ydFp2clNlQVR1VFk1QnNrVTNleW9HR2dmeHVmK0V6emROZXlQ?=
 =?utf-8?B?aHpmSDNUcVlJZlFodWUva09SbXlKLzJVVTViK21jQXUzN0FKRGY2czVGVlFQ?=
 =?utf-8?B?SXpZNzRFN3BwRjlOS2IwNmt1UzFEeVkxK0cvYUs2bVBnZW50V2VySEVIVGlO?=
 =?utf-8?B?amZ0WHZxUmV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F95359BB08BC484785A131BFC5988D00@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c57d94-4bb5-4383-4363-08da0baf6d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 02:55:30.7001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZAJqhB+ryAjdZPeYyqmyxBY0mV9J+DxsUAGVPUT09rFeHIdjNwz62qkkSZFjlQ6lh4LArIZ2klIrEfZXQBS4qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9461
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXIgMjEsIDIwMjIgYXQgMDU6NDY6NDhQTSAtMDcwMCwgWWFuZyBTaGkgd3JvdGU6
DQo+IE9uIFRodSwgTWFyIDE3LCAyMDIyIGF0IDEwOjE2IFBNIE5hb3lhIEhvcmlndWNoaQ0KPiA8
bmFveWEuaG9yaWd1Y2hpQGxpbnV4LmRldj4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBOYW95YSBI
b3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+DQo+ID4gVGhlcmUgaXMgYSBy
YWNlIGNvbmRpdGlvbiBiZXR3ZWVuIG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGIoKSBhbmQgaHVnZXRs
Yg0KPiA+IGZyZWUvZGVtb3Rpb24sIHdoaWNoIGNhdXNlcyBzZXR0aW5nIFBhZ2VIV1BvaXNvbiBm
bGFnIG9uIHRoZSB3cm9uZyBwYWdlLg0KPiA+IFRoZSBvbmUgc2ltcGxlIHJlc3VsdCBpcyB0aGF0
IHdyb25nIHByb2Nlc3NlcyBjYW4gYmUga2lsbGVkLCBidXQgYW5vdGhlcg0KPiA+IChtb3JlIHNl
cmlvdXMpIG9uZSBpcyB0aGF0IHRoZSBhY3R1YWwgZXJyb3IgaXMgbGVmdCB1bmhhbmRsZWQsIHNv
IG5vIG9uZQ0KPiA+IHByZXZlbnRzIGxhdGVyIGFjY2VzcyB0byBpdCwgYW5kIHRoYXQgbWlnaHQg
bGVhZCB0byBtb3JlIHNlcmlvdXMgcmVzdWx0cw0KPiA+IGxpa2UgY29uc3VtaW5nIGNvcnJ1cHRl
ZCBkYXRhLg0KPiA+DQo+ID4gVGhpbmsgYWJvdXQgdGhlIGJlbG93IHJhY2Ugd2luZG93Og0KPiA+
DQo+ID4gICBDUFUgMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1BVIDINCj4g
PiAgIG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGINCj4gPiAgIHN0cnVjdCBwYWdlICpoZWFkID0gY29t
cG91bmRfaGVhZChwKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBodWdldGxiIHBhZ2UgbWlnaHQgYmUgZnJlZWQgdG8NCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBidWRkeSwgb3IgZXZlbiBjaGFuZ2VkIHRvIGFub3Ro
ZXINCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wb3Vu
ZCBwYWdlLg0KPiA+DQo+ID4gICBnZXRfaHdwb2lzb25fcGFnZSAtLSBwYWdlIGlzIG5vdCB3aGF0
IHdlIHdhbnQgbm93Li4uDQo+ID4NCj4gPiBUaGUgY29tcG91bmRfaGVhZCBpcyBjYWxsZWQgb3V0
c2lkZSBodWdldGxiX2xvY2ssIHNvIHRoZSBoZWFkIGlzIG5vdA0KPiA+IHJlbGlhYmxlLg0KPiA+
DQo+ID4gU28gc2V0IFBhZ2VIV1BvaXNvbiBmbGFnIGFmdGVyIHBhc3NpbmcgcHJlY2hlY2tzLiBB
bmQgdG8gZGV0ZWN0DQo+ID4gcG90ZW50aWFsIHZpb2xhdGlvbiwgdGhpcyBwYXRjaCBhbHNvIGlu
dHJvZHVjZXMgYSBuZXcgYWN0aW9uIHR5cGUNCj4gPiBNRl9NU0dfRElGRkVSRU5UX1BBR0VfU0la
RS4NCj4gPg0KPiA+IFJlcG9ydGVkLWJ5OiBNaWtlIEtyYXZldHogPG1pa2Uua3JhdmV0ekBvcmFj
bGUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1
Y2hpQG5lYy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1
YXdlaS5jb20+DQo+ID4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KLi4uDQo+ID4gQEAg
LTE1NDcsMjEgKzE1NDUsMzEgQEAgc3RhdGljIGludCBtZW1vcnlfZmFpbHVyZV9odWdldGxiKHVu
c2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3MpDQo+ID4gICAgICAgICAgKiBJZiB0aGlzIGhhcHBl
bnMganVzdCBiYWlsIG91dC4NCj4gPiAgICAgICAgICAqLw0KPiA+ICAgICAgICAgaWYgKCFQYWdl
SHVnZShwKSB8fCBjb21wb3VuZF9oZWFkKHApICE9IGhlYWQpIHsNCj4gPiArICAgICAgICAgICAg
ICAgaWYgKFRlc3RTZXRQYWdlSFdQb2lzb24ocCkpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgYWxyZWFkeV9od3BvaXNvbmVkID0gcGZuOw0KPiA+ICsgICAgICAgICAgICAgICBlbHNlDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbnVtX3BvaXNvbmVkX3BhZ2VzX2luYygpOw0KPiA+
ICAgICAgICAgICAgICAgICBhY3Rpb25fcmVzdWx0KHBmbiwgTUZfTVNHX0RJRkZFUkVOVF9QQUdF
X1NJWkUsIE1GX0lHTk9SRUQpOw0KPiANCj4gVGhlIGNvbW1pdCBsb2cgc2F5cyAidGhpcyBwYXRj
aCBhbHNvIGludHJvZHVjZXMgYSBuZXcgYWN0aW9uIHR5cGUNCj4gTUZfTVNHX0RJRkZFUkVOVF9Q
QUdFX1NJWkUiLCBidXQgaXQgaXMgbm90IGRlZmluZWQgaW4gdGhlIHBhdGNoIGFuZCBpdA0KPiBp
cyBjYWxsZWQgaGVyZS4gRGlkIEkgbWlzcyBzb21ldGhpbmc/DQoNClNvcnJ5LCB5b3UncmUgcmln
aHQuICBNRl9NU0dfRElGRkVSRU5UX1BBR0VfU0laRSBpcyBkZWZpbmVkIGluIHRoZSBzZXBhcmF0
ZQ0KcGF0Y2ggaW4gbW1vdG0sIGFuZCBkaXNhcHBlYXJlZCB3aGVuIHJlYmFzaW5nIChub3QgaW50
ZW5kZWQpLg0KSSB0aGluayBvZiByZWJhc2luZyB0aGlzIHRvIG1haW5saW5lIGFnYWluIHRvIGFw
cGx5IGNsZWFubHkgdG8gLXN0YWJsZSwNCmV4cGVjdGluZyBpdCB0byBhcHBsaWVkIGJlZm9yZSBv
dGhlciByZWNlbnQgaHdwb2lzb24gcGF0Y2hlcy4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
