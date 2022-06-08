Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6682B54264F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiFHETY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiFHERy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:17:54 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2054.outbound.protection.outlook.com [40.107.113.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947B32F449D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDNN8kBdJqfQLQalMWsR30YTzH5SKDRkbntvsBEU8SEPjdOOC9UYhOlXdUFJQ4+nu8LqpPXQtelmZRI4FldgX3kCt98nL5SKQfw59tlOW+Zw+NffDVYY/aazH3bx3hq/lLmQ2jg6CU4THeH/Soi5bgQrMhAgQNQ3abxAYw+MLXGkkwVTy2VwNaMHj1Yr8kJKkvcJST9Z1+38DJYqZtV3gFXWc66pyKm4mq4BYdvpSgSGCf/soaxPVGfzKZ+8HTVRLMhEnDKX6mKIQTExOI7kxvv3ytUGTMDvt6h2eT+M4vyzsL8IJaO/SqmpQqaxByywvmU2SLp8GFg98eg7Oo4K1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZWFq/y77ZRFpkcn/qazGGca2PQ2fLQmF2dwb0LLszk=;
 b=a6RoYCVsm0aMxdPADmYimurFXFvLODIutaRkpxHgp8FZDg78OaFn1jaKr256pKW4YrG71RR7Ag2rw8VHstvCDzmD+eZpHLLUywQ9TsKwICkh8YkAuT/I6/toWsojcYu4LKT/RFt7/WK8+MXFBuomv2VksBriezFSfseYc5VWbrx2PPIClqPJ3OccpugtQ6wppDSnuG/es+/J/Olu8RFxGwtAXtDuhcuQarV1ppDrEXCEczuzD+BWxnBkTUZ1KvfDb2qjwpStBwocstrT14JawmUZ19TbPnSHQr83lYj+I9875al+Go8eqyYlEcmC8xJvficzIiPq88W9/Q+8heHDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZWFq/y77ZRFpkcn/qazGGca2PQ2fLQmF2dwb0LLszk=;
 b=NNgd7VtedIjVYgSBfjzoFJdqQW9FJI+0jOqSqQcSUPHUJrPve03EM9SW75fRImDhKAqjWUh0X/TYZ65IXW5MHFpggG5tXv9sRbNMjqpRSXClnWcsFpxGd0rrB5tZVdu7aQSushx8hSn4breFrZjw3MOQs9Zs9suh77KPKpENWe8=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB2994.jpnprd01.prod.outlook.com (2603:1096:604:1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 8 Jun
 2022 01:40:16 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995%2]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 01:40:16 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v1 3/5] mm, hwpoison: make __page_handle_poison returns
 int
Thread-Topic: [PATCH v1 3/5] mm, hwpoison: make __page_handle_poison returns
 int
Thread-Index: AQHYdj6jFIOX5Z73QEStft+Eu71nz61D7u8AgADV+oA=
Date:   Wed, 8 Jun 2022 01:40:16 +0000
Message-ID: <20220608014015.GB1404644@hori.linux.bs1.fc.nec.co.jp>
References: <20220602050631.771414-1-naoya.horiguchi@linux.dev>
 <20220602050631.771414-4-naoya.horiguchi@linux.dev>
 <9d423acb-b671-1cf0-0432-76eb648de95b@huawei.com>
In-Reply-To: <9d423acb-b671-1cf0-0432-76eb648de95b@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8326520f-7be7-40e8-d591-08da48efd6fe
x-ms-traffictypediagnostic: OSAPR01MB2994:EE_
x-microsoft-antispam-prvs: <OSAPR01MB29946027979A34F9E142C9F5E7A49@OSAPR01MB2994.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eIZnNMA7POgMSN3TE8Df6zPjfGWmIMDc8b2iV3a3griQbC22fdK8q/uoQEhVHBVaJ+Z+t29ba0cf8UAYMeZWOzAZqNmOpJG3jFjXhorpdlr6YiFNNOcxC1XNtBuYUr5nUVJpSJ+hKvFDEgPpoQ4NH6ZYiSDjzxq5ZgL+6gWShIL/nkT9ejvfjqAbp/rqmDoGS597yXm7LaZUMt3Lg4mmHb/FqiieF8hTxXt2XOsdIRSj5RN/4VOxvlGo2GnhqpUGxMi5kL4hAw6tt387+e+9Okf6zT2NtDSoPB9DzXVAISPbvgeLdUjipCtqF27sTaZxDPIld+lfnloq5D+G3OspP/lPGQXrCjU6Y8SxgLBBpNtT9R4yr0Y6hj9AcWGgRUsYS2jHJ7zj+ZxiRKd4GJrx70zAzWdsTHpZr3Rz5C8l0zCAwUpSLlhCMt9E2lOyJM6EcDz5okSvszBdOnrJ1MRYpvV0KYVW29602WvRp62xXVxJtVbG09hpZxbiRtNNgjN1Zn7MXy0e/C5OwuUhhtDaDfH1PpBeJtVt9Vek0J/5OE0nWxvxmWj2qMdG/G8RLjUv0eMAoFfxIbD5tetXWwpJamBwHeFz4OSqZNNtHuic7CMmQx2CjVJd3U9PBjaAHU3xjKTwPvvFhgj7h/3le4sbmLtQ8sfnoKODBkoY8XvbFzuEPsjZ3jdXsnPqC3B1a18k9HmaspvQcRAzngNvNNyoNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(316002)(1076003)(6486002)(33656002)(8936002)(26005)(9686003)(6512007)(86362001)(83380400001)(53546011)(6506007)(55236004)(8676002)(7416002)(54906003)(64756008)(38100700002)(66446008)(66556008)(66476007)(186003)(4326008)(508600001)(5660300002)(122000001)(85182001)(82960400001)(38070700005)(2906002)(76116006)(71200400001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REVPRVVId2RVUmJBZkcyUUEzamJkMTl2Y3RpM2oxZmVNSXJjWE9IYzRwRmhL?=
 =?utf-8?B?dGJ5YU8rcGtHSHZ1SWhuZEFjYldXZVlSampDT0k0UnpIR2dZcmRoaW0yQkRV?=
 =?utf-8?B?QW1nTUROQzdzamVmSC9JK2xHQ3JRdTVZc0xmOUVUZHJpVkRBb0FXK2NXTXR5?=
 =?utf-8?B?NnBPTDZQTS9YOFh1TGg5dmE3R3M3TlNwUnZ0UFQ5ckNhTlJoWllOUmRiNlYw?=
 =?utf-8?B?dytZZ2xiSXRoOHJ5VFdNbHVKU0xZbHZBZkN3aitranYwQlFUZ3FEcXMrRkN1?=
 =?utf-8?B?YzdMVFByYVdQZzc2ZHFOdC85ejdkdHVsVmVxZEMxTk1hQ1pNYVZCcFZmWFM2?=
 =?utf-8?B?STFCZXY2UXdHZHFzZ1ZDL0FqandMV1BCQ1JyODExL3RjNXVndlVvcVNpbTF1?=
 =?utf-8?B?NnJ6eTZDN1FuaTJ6bEtMcWlmRnZLd2txeEl1TEpDcUltT0t2ck45V2QvUFZO?=
 =?utf-8?B?bUZySGJMNXdJazBUR1pvSWNsbXpRdzBPMkJ5S2hSNUliekZlV3NuK2JLMmlP?=
 =?utf-8?B?eGhUUmxSV25XSStoT1lDVU5UUzZXWFRKMmlxWU1xeWtTVUl3dGk0NkE1UldE?=
 =?utf-8?B?bVJ2L2VoSjdJakN3MWtEbUlWOERHUFhTMXJyMnR3S3dlLzd4eTBmOFpka0pE?=
 =?utf-8?B?MnlDQkFDRGtVTENBZ1UzbG9yL21rSVJnTllKTDNFWTB5QSt1eCthQlBGVTlp?=
 =?utf-8?B?TUNXRUc0VnhpYm1QaXN6Q1NzUlFoNVlKUlIwMlQ2a0JOa2JIdHhOV0N3Vmxr?=
 =?utf-8?B?d1JhQ0d3czlhNTg5SkJKdmI1RTFnanhuMVVnUldoWUlVblhNRVN0YXRsd01Y?=
 =?utf-8?B?NXlTY1pJK1YyMVFGNjUwSGxmd2xlYlZmREVTRXY4TWJGUm1CSUFaUmVXV3lJ?=
 =?utf-8?B?QUdpMXdyQ1hHWFVQb2NORVlSUEN1MVVhdllWN1BzS09LOGxkKzBFdFhjRWVo?=
 =?utf-8?B?NkdpaSt2MEI1bTh1L004QytxVjVOVGx0VklmY25CNDYrTStTMHRlSDlKbm1a?=
 =?utf-8?B?elVuZTB3Vnp1K1QrMCs5R0YzR3dnMHRZSDdiR3RIWWY3TEF0NVV1TmVoSm9x?=
 =?utf-8?B?cVFRbmJ1R3pDTU45Z2Y5eVJvZGUwT3V1RThpMG9lSTV4L1hTUmQyUzdFYVox?=
 =?utf-8?B?QWoyUEp4bkJ1WWNvTm43WXBaN2ROb0tQUlpLUzZOV2lMQm5kNEE5VHhwU1ho?=
 =?utf-8?B?clZYT3JTbjJoQVZSQ095OTFlZjk1dng1MlhzTy9lQzlod1Q0ck41SWZMRXVz?=
 =?utf-8?B?dWk5Z3JZTm5OQncwb2M1dWN2cHFleGVTbytoTm5oQlNoVXVEWHBmVGhpMUdk?=
 =?utf-8?B?Q2FrbncraDkybW05V2MvR1ZCSVFMR1JpclNJbGluc2llUm9kYnZEdDlUSEh1?=
 =?utf-8?B?TzhCcFo0U0hLajNRVy9CaENPek0rbmpuWDZUYzd3Nm01RkIyYXArRDBqaFJh?=
 =?utf-8?B?dHQ3T056a21QSXRLYUU2S081MzhkVk55U2tPQzVRM3EvM0wrdHZVdjlMb3Q0?=
 =?utf-8?B?NktMU0RFZkFzM2N2amxXQ0ZIcU1hMmdIaVVWTFpRYXR6TmxmUTY2YmRUUVNV?=
 =?utf-8?B?MVBTMFVsSi9FNkIwUXVremhoRjB3Z1JaeWRYaitxWEZVTkVjTDdOMzV6Y1Fz?=
 =?utf-8?B?OG1WN1lJUlVNNnhzNFRqSXd3RWlaSERrMDZkS2Vwb29uS2xhY3BWZk15WHpF?=
 =?utf-8?B?cWhuTll3OXVoOUphV3JxZFl3UlNjS1J0NFdaeHFubnhxTG44bnhiTDlGelR6?=
 =?utf-8?B?Z21qeTFlM3V3R04zUTlmSFdrdmoxc3hpZUkxU1d1NmJvTVRKRjh0cFhyS3FT?=
 =?utf-8?B?RS93Q01CK3NLQ2JVQWJxdFNHeVFTdFFkcWlFcnNIeDAwWi9UTGgrNlZjd21o?=
 =?utf-8?B?M0dpRmJ4bzM4VWNTMTU3Z3FlcU82WFJHcUlMOTgwL1BkcDJXeXlOdGxFbzJJ?=
 =?utf-8?B?ZHdHZ2JOczY4anFJSlErUTJ0b09BWWt1ZFBZV2NFVHAxNVJhZk5sNVFuV2xU?=
 =?utf-8?B?UmhmSVZlUXlQa0xqR290NDlPYXBNNXFEazcvNmUwUVpiYTlIQ0p4LzYxZmNV?=
 =?utf-8?B?ei8zRWVUdG5Qb2E4ZjUyTmhYS1RYWm5XUTJPTEcvMEwxTVFEK0tJQXUzWEdV?=
 =?utf-8?B?UDJQTWhneGNIRnd0dVNGWWxyOHR1b0l3aEFsYllITUNMeDc2UFI0WmtjNTRG?=
 =?utf-8?B?Vk5QTGVGMVZRWHFBTkM2eTduSjdMSDJLTFU2ditTclRsUVUvTHdyRURtcnAy?=
 =?utf-8?B?RTBHMXJhS0xNNHRhZmU3SFViRkRKL2tzVFRaVVVrNzBUS2VEVG9OZlZ2OXhN?=
 =?utf-8?B?d3pqaWJDUDJYUzlPMXpvMnd5bllLNENjRjVnM1pxL0dSN2I0b3k5K0xBMlJI?=
 =?utf-8?Q?l4ybaXYrVSdOSCh4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FD5EC378455724291DA6891986856BD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8326520f-7be7-40e8-d591-08da48efd6fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 01:40:16.7442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X8bPuGgQprx6JMJAzJjYwSOR3reW97lMPiNC0M5ST/3WDjT2v+kIgz8kE7tf6X5oBwL14WMRsCBkZZ/iqkRdzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2994
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMDcsIDIwMjIgYXQgMDg6NTQ6MjRQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi82LzIgMTM6MDYsIE5hb3lhIEhvcmlndWNoaSB3cm90ZToNCj4gPiBGcm9t
OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+IA0KPiA+IF9f
cGFnZV9oYW5kbGVfcG9pc29uKCkgcmV0dXJucyBib29sIHRoYXQgc2hvd3Mgd2hldGhlcg0KPiA+
IHRha2VfcGFnZV9vZmZfYnVkZHkoKSBoYXMgcGFzc2VkIG9yIG5vdCBub3cuICBCdXQgd2Ugd2ls
bCB3YW50IHRvDQo+ID4gZGlzdGluZ3Vpc2ggYW5vdGhlciBjYXNlIG9mICJkaXNzb2x2ZSBoYXMg
cGFzc2VkIGJ1dCB0YWtpbmcgb2ZmIGZhaWxlZCINCj4gPiBieSBpdHMgcmV0dXJuIHZhbHVlLiBT
byBjaGFuZ2UgdGhlIHR5cGUgb2YgdGhlIHJldHVybiB2YWx1ZS4NCj4gPiBObyBmdW5jdGlvbmFs
IGNoYW5nZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lh
LmhvcmlndWNoaUBuZWMuY29tPg0KPiA+IC0tLQ0KPiA+ICBtbS9tZW1vcnktZmFpbHVyZS5jIHwg
MTcgKysrKysrKysrKystLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS1mYWls
dXJlLmMgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ID4gaW5kZXggZmU2YTc5NjFkYzY2Li5mMTQ5
YTc4NjRjODEgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+ICsrKyBi
L21tL21lbW9yeS1mYWlsdXJlLmMNCj4gPiBAQCAtNjgsNyArNjgsMTMgQEAgaW50IHN5c2N0bF9t
ZW1vcnlfZmFpbHVyZV9yZWNvdmVyeSBfX3JlYWRfbW9zdGx5ID0gMTsNCj4gPiAgDQo+ID4gIGF0
b21pY19sb25nX3QgbnVtX3BvaXNvbmVkX3BhZ2VzIF9fcmVhZF9tb3N0bHkgPSBBVE9NSUNfTE9O
R19JTklUKDApOw0KPiA+ICANCj4gPiAtc3RhdGljIGJvb2wgX19wYWdlX2hhbmRsZV9wb2lzb24o
c3RydWN0IHBhZ2UgKnBhZ2UpDQo+ID4gKy8qDQo+ID4gKyAqIFJldHVybiB2YWx1ZXM6DQo+ID4g
KyAqICAgMTogICB0aGUgcGFnZSBpcyBkaXNzb2x2ZWQgKGlmIG5lZWRlZCkgYW5kIHRha2VuIG9m
ZiBmcm9tIGJ1ZGR5LA0KPiA+ICsgKiAgIDA6ICAgdGhlIHBhZ2UgaXMgZGlzc29sdmVkIChpZiBu
ZWVkZWQpIGFuZCBub3QgdGFrZW4gb2ZmIGZyb20gYnVkZHksDQo+ID4gKyAqICAgPCAwOiBmYWls
ZWQgdG8gZGlzc29sdmUuDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgaW50IF9fcGFnZV9oYW5kbGVf
cG9pc29uKHN0cnVjdCBwYWdlICpwYWdlKQ0KPiA+ICB7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+ICAN
Cj4gPiBAQCAtNzgsNyArODQsNyBAQCBzdGF0aWMgYm9vbCBfX3BhZ2VfaGFuZGxlX3BvaXNvbihz
dHJ1Y3QgcGFnZSAqcGFnZSkNCj4gPiAgCQlyZXQgPSB0YWtlX3BhZ2Vfb2ZmX2J1ZGR5KHBhZ2Up
Ow0KPiA+ICAJem9uZV9wY3BfZW5hYmxlKHBhZ2Vfem9uZShwYWdlKSk7DQo+ID4gIA0KPiA+IC0J
cmV0dXJuIHJldCA+IDA7DQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gIA0KPiA+ICBz
dGF0aWMgYm9vbCBwYWdlX2hhbmRsZV9wb2lzb24oc3RydWN0IHBhZ2UgKnBhZ2UsIGJvb2wgaHVn
ZXBhZ2Vfb3JfZnJlZXBhZ2UsIGJvb2wgcmVsZWFzZSkNCj4gPiBAQCAtODgsNyArOTQsNyBAQCBz
dGF0aWMgYm9vbCBwYWdlX2hhbmRsZV9wb2lzb24oc3RydWN0IHBhZ2UgKnBhZ2UsIGJvb2wgaHVn
ZXBhZ2Vfb3JfZnJlZXBhZ2UsIGJvbw0KPiA+ICAJCSAqIERvaW5nIHRoaXMgY2hlY2sgZm9yIGZy
ZWUgcGFnZXMgaXMgYWxzbyBmaW5lIHNpbmNlIGRpc3NvbHZlX2ZyZWVfaHVnZV9wYWdlDQo+ID4g
IAkJICogcmV0dXJucyAwIGZvciBub24taHVnZXRsYiBwYWdlcyBhcyB3ZWxsLg0KPiA+ICAJCSAq
Lw0KPiA+IC0JCWlmICghX19wYWdlX2hhbmRsZV9wb2lzb24ocGFnZSkpDQo+ID4gKwkJaWYgKF9f
cGFnZV9oYW5kbGVfcG9pc29uKHBhZ2UpIDw9IDApDQo+ID4gIAkJCS8qDQo+ID4gIAkJCSAqIFdl
IGNvdWxkIGZhaWwgdG8gdGFrZSBvZmYgdGhlIHRhcmdldCBwYWdlIGZyb20gYnVkZHkNCj4gPiAg
CQkJICogZm9yIGV4YW1wbGUgZHVlIHRvIHJhY3kgcGFnZSBhbGxvY2F0aW9uLCBidXQgdGhhdCdz
DQo+ID4gQEAgLTEwNDUsNyArMTA1MSw3IEBAIHN0YXRpYyBpbnQgbWVfaHVnZV9wYWdlKHN0cnVj
dCBwYWdlX3N0YXRlICpwcywgc3RydWN0IHBhZ2UgKnApDQo+ID4gIAkJICogc2F2ZSBoZWFsdGh5
IHN1YnBhZ2VzLg0KPiA+ICAJCSAqLw0KPiA+ICAJCXB1dF9wYWdlKGhwYWdlKTsNCj4gPiAtCQlp
ZiAoX19wYWdlX2hhbmRsZV9wb2lzb24ocCkpIHsNCj4gPiArCQlpZiAoX19wYWdlX2hhbmRsZV9w
b2lzb24ocCkgPiAwKSB7DQo+ID4gIAkJCXBhZ2VfcmVmX2luYyhwKTsNCj4gPiAgCQkJcmVzID0g
TUZfUkVDT1ZFUkVEOw0KPiA+ICAJCX0NCj4gPiBAQCAtMTU5NSw4ICsxNjAxLDcgQEAgc3RhdGlj
IGludCB0cnlfbWVtb3J5X2ZhaWx1cmVfaHVnZXRsYih1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZs
YWdzLCBpbnQgKmh1Z2V0bGINCj4gPiAgCSAqLw0KPiA+ICAJaWYgKHJlcyA9PSAwKSB7DQo+ID4g
IAkJdW5sb2NrX3BhZ2UoaGVhZCk7DQo+ID4gLQkJcmVzID0gTUZfRkFJTEVEOw0KPiANCj4gVGhp
cyBsb29rcyBsaWtlIGFuIHVuZXhwZWN0ZWQgY2hhbmdlLiByZXMgd2lsbCBiZSAwIGluc3RlYWQg
b2YgTUZfRkFJTEVEIGlmIF9fcGFnZV9oYW5kbGVfcG9pc29uIGZhaWxlZCB0bw0KPiBkaXNzb2x2
ZSBvciBub3QgdGFrZW4gb2ZmIGZyb20gYnVkZHkuIEJ1dCB0aGlzIGlzIGZpeGVkIGluIGxhdGVy
IHBhdGNoIGluIHRoaXMgc2VyaWVzLiBTbyBpdCBzaG91bGQgYmUgZmluZS4NCg0KQWgsIHlvdSdy
ZSByaWdodC4gdGhpcyBwYXRjaCBpcyBzdGF0ZWQgYXMgIm5vbiBmdW5jdGlvbmFsIGNoYW5nZSIg
YnV0IHRoYXQNCmlzIG5vdCB0cnVlIGR1ZSB0byB0aGlzLiAgU28gSSdsbCBtb3ZlIHRoaXMgbGlu
ZSBkZWxldGlvbiB0byA0LzUgaW4gdGhlIG5leHQNCnZlcnNpb24uDQoNCj4gDQo+IFJldmlld2Vk
LWJ5OiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCj4gDQo+IFRoYW5rcyENCg0K
VGhhbmsgeW91IDopDQoNCi0gTmFveWEgSG9yaWd1Y2hp
