Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA356FD08
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 11:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiGKJuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 05:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiGKJtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 05:49:19 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2082.outbound.protection.outlook.com [40.107.113.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D9FACEDB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZnitXzwBY1+p9K0EpCMWCzc4f6dzuYBkUjhbHljz5s82VyXaXvK/l3zfyewy/+I3U4GXZhtj8zacebuEvJhYz1wsAvz1lfWba55lJsfzyE/Re1SVU5hln6EHPSsdo+DapMRS4y6o9Kp63qC6rPDtAKgFXb2sWX3Xa6kxvs7x+CsdyGpy9KIbUz6B8UYRzPEsy7M56PwCcuN0MovrKtgZd3YhF8dsspFmeyTZquyfuIrXCUJV0H1JB6r++61Vbq+ODDg/Aetx/WKvxZ33GQyqGOdgtCDa025HLNEmTOp2KlRuyneXcvh1Z+2Ai5Mj6ehCjomZbLaLNSXTqEn9chDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nh9g7t/UyyqVINQfTmR3betTWGqYlS8VgjUcNSawREc=;
 b=BxJDxDGo7d/HpCR+xNecL7AFHJLBJggKJCiXZLxiCOIxpohXwewUxLsUP2jQN84IhAYYx3BgAk6YooPIzCZ0mxWqYRkxP1eJKBKKBrq2/SR52p2HekEP6JK7SWbtOGjJmLxRlN+ZLNtKUcnaudd1euzx7Gkr43p6xlEWhgExj2EXcWY9IKgjXUdfpY/yNDYB1oo9xUj5JeRi/8rd3PXumShwZKbV9qI0JHX7hC0+4ZVqvOK7+63tN2TrKzn7fgA4kqNWyR9J63cV3JLP/MbbJ9KBiUONtNk0GCDtDqD1ULPAD16eveIQ+I76kJGGCtRy+pBGTWYNAiIha1LjeeI76A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nh9g7t/UyyqVINQfTmR3betTWGqYlS8VgjUcNSawREc=;
 b=ewTzW+8LdNPySv7NFjCuXe8Y/lko4nmBDANmm292782JdaGrGbskgw/6jXhXQVJCRoBNCJeBo5FjYPImmx3bsMTZKJXejYscYIcOAAS16+X3cfmdKkewx9s5TVIUM5m7tzx/PIDA2lpgayX9TDunV0wVdfrJHmkyLAdQFIpeK74=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB3797.jpnprd01.prod.outlook.com (2603:1096:604:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Mon, 11 Jul
 2022 09:24:01 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 09:24:01 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [mm-unstable PATCH v5 4/8] mm, hwpoison: make unpoison aware of
 raw error info in hwpoisoned hugepage
Thread-Topic: [mm-unstable PATCH v5 4/8] mm, hwpoison: make unpoison aware of
 raw error info in hwpoisoned hugepage
Thread-Index: AQHYlPUoUwdWWwIys0CRkgeP8Ka/g6145f0A
Date:   Mon, 11 Jul 2022 09:24:01 +0000
Message-ID: <20220711092400.GA2741993@hori.linux.bs1.fc.nec.co.jp>
References: <20220708053653.964464-1-naoya.horiguchi@linux.dev>
 <20220708053653.964464-5-naoya.horiguchi@linux.dev>
 <3c66e7f6-e499-9802-409a-a32404fc87cc@huawei.com>
In-Reply-To: <3c66e7f6-e499-9802-409a-a32404fc87cc@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 939af9f6-e6ee-4df4-11c8-08da631f17b2
x-ms-traffictypediagnostic: OSBPR01MB3797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ebtji+ZD3OmGkY4OZJIWuJZFKGeOCgnQgWY3NAwZm/+fbvK52dvcyjVlbHOa14I47UtsDRdRd9mzOBt0bIVBunSXbBFghs4pJnK1ZvQI8hrURNEJj/x86gdGqnFSHk3WbH3OcBXXUy5DFH2CA44WCInIoQ0ELULSL2Qi2IYrjCAW0+xjkzBOxqSR9Zxi1bmMz72OwJkm8KAndIvQOBSXPrJNN3K6tM7zVUrHUj16T1qLqrJLLbR37A5yUkfQ8Yl4d129UU+puVLBCL/5ZS/Guhucxnur3pk++yIKa2qdtbYMIgTJ6o9fqLXh2DMIU++GRI6KwnyEde1Gp+AHrTp5Ct/BawqySCnSYjO83gKERvgs1j9/idNshCvWyyYkGbQ2IpMQdC5Kj1RveAp7GQqIFSIC8x7oeBMYi7J0XR43639/WYurHd0bSUGyy1i29zm/v/ZrXNcIhnLbojm0kyhnYxydzfaE+47X+EsZIYP4gjp+5WWfT2cXPwTsYv6DppQ4pMv1OP8xSMd+jKm9az0uKnxFv0WHZjs9k4TY3J8Uh6kqb9zf2Gi3ed/MD4eA+LV9q6RGRxkVsRjrp1g6HxVLJpdcI3/V1tH6eTr5D5JPjEbUmg58NZKLMrPIhfMls2BRe2Zed9VdRmXuopV3pyLUhDAYaTPxFJ2buwRFAyMFy7SgydU2VPFcJrhfwelTcZuwtQM3eYGO0d/rNdZEx5cyGrPlXK9t+vPENicLEH477DD5+kEDDne7kH6W6bfLO5b6VWBNLsjCVmuBpAvGGZQF9+p4qx4m+YRoqy40anPbOGrXY34/hCG11GuMbc/ufdKS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(38100700002)(186003)(122000001)(5660300002)(83380400001)(66446008)(66946007)(6916009)(4326008)(316002)(71200400001)(66476007)(85182001)(66556008)(9686003)(82960400001)(8676002)(64756008)(33656002)(26005)(86362001)(54906003)(6506007)(76116006)(2906002)(478600001)(8936002)(6486002)(41300700001)(6512007)(1076003)(38070700005)(7416002)(55236004)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alY2a1AvdDJSc1BsTm5TZlZLd00yRlhDZHlsUFZtbFRnQVE4WlFZaWxsNnRx?=
 =?utf-8?B?MlZVa252amhTN1RZdVFkdFlSU3cvOVowRGpPUWxodTZUQXVrMktiUmx2NWNj?=
 =?utf-8?B?M1k5NkduQ0I4eVY4Y1NSdEF4SjB2NjdjQlB5aEV0OHZKc0VqMFZOZExzZmNU?=
 =?utf-8?B?QWdiSjc0ZXNwVjBLMHp2ZU90T21DQnFjQm9FSzF0VS9XUDlJOVBwNkViam16?=
 =?utf-8?B?RjIwWXV4cHpxQ3V0TmFYLzB1dU1LRHNDUWdFQStFMEUyNzJtRVdZVkwvUHJF?=
 =?utf-8?B?am16THRSbEMxK2dMWE14OFZpbDVJZXo4UmEvY2M2ZU4xcUwwb1c4MGN4TVM5?=
 =?utf-8?B?YzBOSGI4c0VCZ0dldlp0Tk1ZVC9nNCtKQm8rUmgxWDJ6THR6RDc5eW84NmQy?=
 =?utf-8?B?ZkdrTFo2d0hHWE1HOEJKUVFWZmVQZ2tpUm1HRFJCbnFXS0dYbmRqNEtVUVhz?=
 =?utf-8?B?UzJKQ3MwZEFub0MyK0lVTDlLcTZURzF3K0hjbE5zcWx0ci92TG5tQWU2Wlow?=
 =?utf-8?B?eW5qajE4L3JYcngrbzRqSnFpd2oweGVsdGZXMDMyM3ZlbFBpM0ZPVVNmT0Fh?=
 =?utf-8?B?WDJXK3NBVXQ5Yno1T0RTeUpNMnA2L0ZmMjdFSnR4Z2wxTnZNVHh5Sy83MExz?=
 =?utf-8?B?SkFlZzVsOXB2YlArQTkvOG83U3BaM2h0QTZGNUtONWFibUliTGRXRUhhOVl4?=
 =?utf-8?B?SHg0VzVKeTJoNDRidS95blp6UGp4VURhS20zUUxQYmc3RXlvdXFScVVoUFRn?=
 =?utf-8?B?RVU2ejcrTmNKbTk0YzVSRnBiaEhXVlk3SnBQOXoxQ2cwZnRJTzZ3QjhmZnBp?=
 =?utf-8?B?aXk5aHovYm5GZ3hlc1VKRDc1WmtSa2gzb1JKM1hOczk1R2J2Y1d1Yys2VE5m?=
 =?utf-8?B?SGFocndpOU03a0VmRVVab3lnWllUQnRQcHV0d0tpcHBQUVloQlQ4VHU4RkxS?=
 =?utf-8?B?ZjEvc3RnQzAvLzFWK0Q2OGs2NmlEZTNmUGlwaXY1WDcrQnlYaUxMQy8xb1lm?=
 =?utf-8?B?S29aeC9GY0hQU3QyVjZ0Ti9vclZOTkk4RWFSVjQwNmxkZlVmWGdjb2NLN210?=
 =?utf-8?B?RzdWMlMzeFkyTHZHVFgwMWovdWZWZ1lEVnhWTzZhT0MxakdHL0RKU2MvdzZ0?=
 =?utf-8?B?MzN0RjlGdFVuNURJY2VzOWdqSnlPSlRaWFVWWXl2K1ZSRkdWUTY0UzFtWVdH?=
 =?utf-8?B?WjYzUmc4azQ5aVdBdGg2a2txbWVmc3dmTFVSTU1Tdk9pcm96azBKZ1lvb01D?=
 =?utf-8?B?VGFMSERhYVNoRzZDUE8zRkd3TUo5VzBpdGZIZURqMkMvYm0zc1RtcUc1V0RQ?=
 =?utf-8?B?NlVFeWV5YVpxZEFPcUsrdFNxN3FBekE0SkIycytBUHpSVXNKZkJIdklIS2lS?=
 =?utf-8?B?WHlBMlRPSDRhSDkzRU9wdVhIQXRnaUlFWVF0WXpOT21La0xmMkVCajhHQ2VL?=
 =?utf-8?B?R09BSnV4dXovWC8wMXFPZlRLemxOZXNVQURSQktoQjlwaFMzZmxEQWttSVVQ?=
 =?utf-8?B?TGQzM0xVVmNmVUJJM2gycWtTRnpRRUhQK29qaFBOS2o4ZGpUTUVJcXJVamUz?=
 =?utf-8?B?SFlxelRPOXZCQ3piU0treWExYUNNMXIzRUhUSWV1ZElYU2gralBUSWRFTFB6?=
 =?utf-8?B?UVQ2ZTNKTExkZjlGdXk1bU9sRDJTd0w1QWpaQlViU0lnU0NtNWg5alVzUmxo?=
 =?utf-8?B?a0xieUwyaGJ6QzczdTl4OVVIemRESW1lSXdENzdQcjNvWjB3UVBsUkY1Nk9I?=
 =?utf-8?B?NTRDZFB6WlI3RklyWE5lZW5Ya0ZCa3ZCU3ovMUNIblZBMHlSSXV5Z2lsWGZV?=
 =?utf-8?B?cDA5Z1BVTzBscm40VzNIaEs5R0lLUnZsZDdYa0pSLzBFb1ZmSUt2ai9BYkRs?=
 =?utf-8?B?RkpFQUVnMFhqbTlUUkNkd1RwcXdoVWR5MVFjdWlQWDNhMXpkREYwUmtPc2xw?=
 =?utf-8?B?RVh1NHc3RG8wNmZWai9NbnZ6aWdEMHo0UzZLTE9oZ0ZvckQ4ZVJLaTdReDJl?=
 =?utf-8?B?aFp1bHY5RnZtRlFjdllpbEYrSmpvSnZmKzhiQ3JQU2drMisrOGVLNS9oNmMz?=
 =?utf-8?B?bVc3NHR4aGU1QzZ5eUpXMUR3TjNEU1hhMElKbjBRUVpLZzNyMTR5R3cra0k3?=
 =?utf-8?B?RmJPblAzNmc3QzNwQnREVGg0RTFWZmtQcDIwcFk5dCtjalBYY1M3R1JuS2JI?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3295CCE1238E8C42B9F09355221EA55F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939af9f6-e6ee-4df4-11c8-08da631f17b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 09:24:01.8872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5h5xyp0re2DJegVkWuuaRNcwA99ov2uNUkUTqdMoIPF69WDhYReGPr4LtogB3dDYquoK5CIdixv0jKjLP+raAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3797
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKdWwgMTEsIDIwMjIgYXQgMDM6MDk6MDFQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi83LzggMTM6MzYsIE5hb3lhIEhvcmlndWNoaSB3cm90ZToNCj4gPiBGcm9t
OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+IA0KPiA+IFJh
dyBlcnJvciBpbmZvIGxpc3QgbmVlZHMgdG8gYmUgcmVtb3ZlZCB3aGVuIGh3cG9pc29uZWQgaHVn
ZXRsYiBpcw0KPiA+IHVucG9pc29uZWQuICBBbmQgdW5wb2lzb24gaGFuZGxlciBuZWVkcyB0byBr
bm93IGhvdyBtYW55IGVycm9ycyB0aGVyZQ0KPiA+IGFyZSBpbiB0aGUgdGFyZ2V0IGh1Z2VwYWdl
LiBTbyBhZGQgdGhlbS4NCj4gPiANCj4gPiBIUGFnZVZtZW1tYXBPcHRpbWl6ZWQoaHBhZ2UpIGFu
ZCBIUGFnZVJhd0h3cFVucmVsaWFibGUoaHBhZ2UpKSBjYW4ndCBiZQ0KPiA+IHVucG9pc29uZWQs
IHNvIGxldCdzIHNraXAgdGhlbS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYW95YSBIb3Jp
Z3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+IFJlcG9ydGVkLWJ5OiBrZXJuZWwg
dGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiB2NCAtPiB2NToNCj4gPiAt
IGZpeCB0eXBlIG9mIHJldHVybiB2YWx1ZSBvZiBmcmVlX3Jhd19od3BfcGFnZXMoKQ0KPiA+ICAg
KGZvdW5kIGJ5IGtlcm5lbCB0ZXN0IHJvYm90KSwNCj4gPiAtIHByZXZlbnQgdW5wb2lzb24gZm9y
IEhQYWdlVm1lbW1hcE9wdGltaXplZCBhbmQgSFBhZ2VSYXdId3BVbnJlbGlhYmxlLg0KPiA+IC0t
LQ0KLi4uDQo+ID4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS1mYWlsdXJlLmMgYi9tbS9tZW1vcnkt
ZmFpbHVyZS5jDQo+ID4gaW5kZXggNjgzM2M1ZTRiNDEwLi44OWU3NGVjOGE5NWYgMTAwNjQ0DQo+
ID4gLS0tIGEvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+ICsrKyBiL21tL21lbW9yeS1mYWlsdXJl
LmMNCj4gPiBAQCAtMTcyMCwyMiArMTcyMCw0MSBAQCBzdGF0aWMgaW50IGh1Z2V0bGJfc2V0X3Bh
Z2VfaHdwb2lzb24oc3RydWN0IHBhZ2UgKmhwYWdlLCBzdHJ1Y3QgcGFnZSAqcGFnZSkNCj4gPiAg
CXJldHVybiByZXQ7DQo+ID4gIH0NCj4gPiAgDQo+ID4gLWludCBodWdldGxiX2NsZWFyX3BhZ2Vf
aHdwb2lzb24oc3RydWN0IHBhZ2UgKmhwYWdlKQ0KPiA+ICtzdGF0aWMgbG9uZyBmcmVlX3Jhd19o
d3BfcGFnZXMoc3RydWN0IHBhZ2UgKmhwYWdlLCBib29sIG1vdmVfZmxhZykNCj4gDQo+IE5PIHN0
cm9uZyBvcGluaW9uOiBNYXliZSB0aGUgcmV0dXJuIHR5cGUgc2hvdWxkIGJlICJ1bnNpZ25lZCIg
YXMgaXQgYWx3YXlzID49IDAgPw0KDQpZZXMsIHdpbGwgdXBkYXRlLg0KDQo+IA0KPiA+ICB7DQo+
ID4gIAlzdHJ1Y3QgbGxpc3RfaGVhZCAqaGVhZDsNCj4gPiAgCXN0cnVjdCBsbGlzdF9ub2RlICp0
LCAqdG5vZGU7DQo+ID4gKwlsb25nIGNvdW50ID0gMDsNCj4gPiAgDQo+ID4gLQlpZiAoIUhQYWdl
UmF3SHdwVW5yZWxpYWJsZShocGFnZSkpDQo+ID4gLQkJQ2xlYXJQYWdlSFdQb2lzb24oaHBhZ2Up
Ow0KPiA+ICsJLyoNCj4gPiArCSAqIEhQYWdlVm1lbW1hcE9wdGltaXplZCBodWdlcGFnZXMgY2Fu
J3QgYmUgdW5wb2lzb25lZCBiZWNhdXNlDQo+ID4gKwkgKiBzdHJ1Y3QgcGFnZXMgZm9yIHRhaWwg
cGFnZXMgYXJlIHJlcXVpcmVkIHRvIGZyZWUgaHdwb2lzb25lZA0KPiA+ICsJICogaHVnZXBhZ2Vz
LiAgSFBhZ2VSYXdId3BVbnJlbGlhYmxlIGh1Z2VwYWdlcyBzaG91bGRuJ3QgYmUNCj4gPiArCSAq
IHVucG9pc29uZWQgYnkgZGVmaW5pdGlvbi4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKEhQYWdlVm1l
bW1hcE9wdGltaXplZChocGFnZSkgfHwgSFBhZ2VSYXdId3BVbnJlbGlhYmxlKGhwYWdlKSkNCj4g
PiArCQlyZXR1cm4gMDsNCj4gPiAgCWhlYWQgPSByYXdfaHdwX2xpc3RfaGVhZChocGFnZSk7DQo+
ID4gIAlsbGlzdF9mb3JfZWFjaF9zYWZlKHRub2RlLCB0LCBoZWFkLT5maXJzdCkgew0KPiA+ICAJ
CXN0cnVjdCByYXdfaHdwX3BhZ2UgKnAgPSBjb250YWluZXJfb2YodG5vZGUsIHN0cnVjdCByYXdf
aHdwX3BhZ2UsIG5vZGUpOw0KPiA+ICANCj4gPiAtCQlTZXRQYWdlSFdQb2lzb24ocC0+cGFnZSk7
DQo+ID4gKwkJaWYgKG1vdmVfZmxhZykNCj4gPiArCQkJU2V0UGFnZUhXUG9pc29uKHAtPnBhZ2Up
Ow0KPiA+ICAJCWtmcmVlKHApOw0KPiA+ICsJCWNvdW50Kys7DQo+ID4gIAl9DQo+ID4gIAlsbGlz
dF9kZWxfYWxsKGhlYWQpOw0KPiA+IC0JcmV0dXJuIDA7DQo+ID4gKwlyZXR1cm4gY291bnQ7DQo+
ID4gK30NCj4gPiArDQo+ID4gK2ludCBodWdldGxiX2NsZWFyX3BhZ2VfaHdwb2lzb24oc3RydWN0
IHBhZ2UgKmhwYWdlKQ0KPiANCj4gSXQgc2VlbXMgdGhlIHJldHVybiB2YWx1ZSBpcyB1bnVzZWQ/
DQoNClllcywgdGhlIHJldHVybiB2YWx1ZSBpcyBub3QgbmVlZGVkIG5vdy4NCg0KPiANCj4gPiAr
ew0KPiA+ICsJaW50IHJldCA9IC1FQlVTWTsNCj4gPiArDQo+ID4gKwlpZiAoIUhQYWdlUmF3SHdw
VW5yZWxpYWJsZShocGFnZSkpDQo+ID4gKwkJcmV0ID0gIVRlc3RDbGVhclBhZ2VIV1BvaXNvbiho
cGFnZSk7DQo+ID4gKwlmcmVlX3Jhd19od3BfcGFnZXMoaHBhZ2UsIHRydWUpOw0KPiA+ICsJcmV0
dXJuIHJldDsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgLyoNCj4gPiBAQCAtMTg3OSw2ICsxODk4LDEw
IEBAIHN0YXRpYyBpbmxpbmUgaW50IHRyeV9tZW1vcnlfZmFpbHVyZV9odWdldGxiKHVuc2lnbmVk
IGxvbmcgcGZuLCBpbnQgZmxhZ3MsIGludCAqDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+
ICANCj4gPiArc3RhdGljIGlubGluZSBsb25nIGZyZWVfcmF3X2h3cF9wYWdlcyhzdHJ1Y3QgcGFn
ZSAqaHBhZ2UsIGJvb2wgbW92ZV9mbGFnKQ0KPiANCj4gSWYgcmV0dXJuIHR5cGUgaXMgY2hhbmdl
ZCwgcmVtZW1iZXIgdG8gY2hhbmdlIGhlcmUgdG9vLg0KDQpPSy4NCg0KPiA+ICt7DQo+ID4gKwly
ZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICAjZW5kaWYJLyogQ09ORklHX0hVR0VUTEJfUEFHRSAqLw0K
PiA+ICANCj4gPiAgc3RhdGljIGludCBtZW1vcnlfZmFpbHVyZV9kZXZfcGFnZW1hcCh1bnNpZ25l
ZCBsb25nIHBmbiwgaW50IGZsYWdzLA0KPiA+IEBAIC0yMjg0LDYgKzIzMDcsNyBAQCBpbnQgdW5w
b2lzb25fbWVtb3J5KHVuc2lnbmVkIGxvbmcgcGZuKQ0KPiA+ICAJc3RydWN0IHBhZ2UgKnA7DQo+
ID4gIAlpbnQgcmV0ID0gLUVCVVNZOw0KPiA+ICAJaW50IGZyZWVpdCA9IDA7DQo+ID4gKwlsb25n
IGNvdW50ID0gMTsNCj4gPiAgCXN0YXRpYyBERUZJTkVfUkFURUxJTUlUX1NUQVRFKHVucG9pc29u
X3JzLCBERUZBVUxUX1JBVEVMSU1JVF9JTlRFUlZBTCwNCj4gPiAgCQkJCQlERUZBVUxUX1JBVEVM
SU1JVF9CVVJTVCk7DQo+ID4gIA0KPiA+IEBAIC0yMzMxLDYgKzIzNTUsMTMgQEAgaW50IHVucG9p
c29uX21lbW9yeSh1bnNpZ25lZCBsb25nIHBmbikNCj4gPiAgDQo+ID4gIAlyZXQgPSBnZXRfaHdw
b2lzb25fcGFnZShwLCBNRl9VTlBPSVNPTik7DQo+ID4gIAlpZiAoIXJldCkgew0KPiA+ICsJCWlm
IChQYWdlSHVnZShwKSkgew0KPiA+ICsJCQljb3VudCA9IGZyZWVfcmF3X2h3cF9wYWdlcyhwYWdl
LCBmYWxzZSk7DQo+IA0KPiBJdCBzZWVtcyB0aGUgY3VycmVudCBiZWhhdmlvciBpczogaWYgYW55
IHN1YnBhZ2Ugb2YgYSBodWdldGxiIHBhZ2UgaXMgdW5wb2lzb25lZCwgdGhlbiBhbGwgb2YgdGhl
DQo+IGh3cG9pc29uZWQgc3VicGFnZXMgd2lsbCBiZSB1bnBvaXNvbmVkLiBJJ20gbm90IHN1cmUg
d2hldGhlciB0aGlzIGlzIHdoYXQgd2Ugd2FudC4NCg0KQmFzaWNhbGx5IHJhd19od3BfaW5mbyBp
cyBub3QgYXZhaWxhYmxlIHRvIHVzZXJzcGFjZSAoaXQgbWlnaHQgYmUgcmVjb3JkZWQNCmluIGRt
ZXNnIGJ1dCBub3QgYXZhaWxhYmxlIHZpYSAvcHJvYy9rcGFnZWZsYWdzKSwgc28gdW5wb2lzb25p
bmcgZXJyb3INCnN1YnBhZ2VzIG9uZS1ieS1vbmUgaXMgc29tZXRpbWVzIGJvdGhlcmluZy4gIElm
IHNvbWVvbmUgd291bGQgbGlrZSB0bw0KdW5wb2lzb24gb25lLWJ5LW9uZSAoSSBleHBlY3Qgbm9i
b2R5IHdvdWxkKSwgSSBjYW4gZG8gdGhpcy4NCg0KPiBUaGFua3MuDQoNClRoYW5rIHlvdSENCg0K
LSBOYW95YSBIb3JpZ3VjaGk=
