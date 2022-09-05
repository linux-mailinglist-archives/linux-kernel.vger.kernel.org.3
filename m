Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753675AC9BB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 07:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbiIEFXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiIEFXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:23:10 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2045.outbound.protection.outlook.com [40.107.113.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424E92610A
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 22:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmjhncMZL3CgIXA9/P4t7HPWNLU5rX56i4hYJJiwkISx5UEHaaRQOgwta3HSpkx1jbYa16loszSYq4IJP7JZgzv1+numCIMnIqc4Mlw2SbKqUI2HL5uERoWuwx5XOBA4tm1jpM4sq1ANPQTZR0wuCldtwL41xPa0HlcoQoHbKVRcRMi0C8lAsDYdupaMy+BwoLp5FS/CTV0gIvIef7zz2IvZI2OXCjwmiqOsLlJ1sgZGQ1MlulrHvFlmbR+EhmaYzwMk6Ykko4FNqOMBZqwjDPtzxpoS6ijXkTDBXQL6G859ZYGVr62T5CEthrA/Ytf49LQXCihmuqFlYG2TeXv30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlpEGztt6zlb0Yi8uxbN2NEgYi009rOBbVDRjZOT7tY=;
 b=IXd9BBd/4rkklaSyRkoJD8QgWrHWF08Kf84scljlQS6PsjA493ANDaqUk+igQ55pFLdvOwSo5fxbboucG3z3GO/nBubxbysAD8r1x30Z523YwKLT2GVH/qcGmuL1bwqSYXNjcpeZQMTYbQcuAhWZGgcmtPa2oEvbY80gY+ZTu38C+AyOa5xMXg7wv7f9DjC3ODjTeinCWVXAacEdOAJfpTQK5NR3Jbv0Tmv/uA4MBldRZvI5TYgJles3BBRxXsqvtZZzsrRl5XSFchYcriOEcBqj/ZCKmYHK2gX1aAdsVNlq+Z5Q5jgd6TLjvrPxSweInvcHSpi9zb9th79jfbQNqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlpEGztt6zlb0Yi8uxbN2NEgYi009rOBbVDRjZOT7tY=;
 b=iay5c1f1DkeAZ5XBtQ1oSVuto4USu+hazi+iNofps/37HdpiCojfWxnrTGSfUVKHSoohQGpn+ADYpQXRZ0DmjKXgFW+8D01ahMEtu9GWS4FN5mjrTw2WpwJGISElQ+hteFOFQ/jRu4p/p6HWtx0XSyW7ws3YTT9Oo8MZwAWgBSI=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSYPR01MB5367.jpnprd01.prod.outlook.com (2603:1096:604:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 05:23:06 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5588.011; Mon, 5 Sep 2022
 05:23:06 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] mm, hwpoison: use ClearPageHWPoison() in
 memory_failure()
Thread-Topic: [PATCH 1/6] mm, hwpoison: use ClearPageHWPoison() in
 memory_failure()
Thread-Index: AQHYvG0pb/SZ2P1OjEuclVFeiln2la3QVkyA
Date:   Mon, 5 Sep 2022 05:23:06 +0000
Message-ID: <20220905052305.GB1355682@hori.linux.bs1.fc.nec.co.jp>
References: <20220830123604.25763-1-linmiaohe@huawei.com>
 <20220830123604.25763-2-linmiaohe@huawei.com>
In-Reply-To: <20220830123604.25763-2-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4da8132b-c5af-49b6-c877-08da8efeb688
x-ms-traffictypediagnostic: OSYPR01MB5367:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sv95wVT2h/W7nGcNGAKlUcAuReAZxtYPcxepk9Cdy6VcdwyjULDOHceyMMfbmyZEWW0gwjVj4cSq4F+sRAR2tpOYreuwVfSQ05w5F8SKG1qzAO7l+qvDWLuBxhISQJeyxvUk6nw5tsMlu/tjBs9irnhBRbiA36+nb/qtFzGHgMuJ+yUZ2uUYnmoUgGV5ZrRyM1IPhXtrKluG9fhuyNWNlClWsAPQHcDxlIROGiiKDMpl/uuj2+191kQVt3eufVJxJODTb9dQ+AGiIl0uVy0ZRQWDU0b0eDZX6ULHhG4eHlKs5ZGn/3CUeWTPeKTLalCyIv181PWevo+CkdxCYIzvrQVBxmX5Gg8wyZ/CQJj5kbbkuf7OMfS3qNiZ2mnPKHUb0GvvHJawG6A6FumxO/MRIQBAJN9OZuuDZ919ZY5JqRSc8jmnyTnnnILddHsLIIMlok3S4qI2OWMVf2iLL4x92VrL6URAfHsBAueuODB6OmJQkOy0+BGav4f46Akxc0LOpqbXtFY14XYdvEJsTLFn6M9slO5y008K8ZOjwUQRZhLio9TdauZl5HcVXQBpt+EVyALu2puIVOcGM3U7f2+ApY37KhaiZDSlbSxi1TEns6s8IvdQhzMkfNiOpRUCjl0Ua6PUebbYSKeDwWRvIrr/xROLX34gCvvBmpCF7ingjToNonZGKjJgcLQDEJcdc4vNb4aO7WgzH+oCRwvOvYL7CSt5kmZH5KAu5UXs90DWfaJk1ypk291uo6Q/h5BjWXe82Zwqx4+I/19d/lL1xQWAwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(6506007)(55236004)(186003)(5660300002)(1076003)(8936002)(9686003)(6512007)(6486002)(86362001)(33656002)(558084003)(85182001)(26005)(71200400001)(478600001)(41300700001)(82960400001)(38070700005)(316002)(8676002)(4326008)(76116006)(64756008)(66446008)(66476007)(66556008)(2906002)(66946007)(54906003)(6916009)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXluTnBGakpXUXN2eDdHM0dLcVRUSkMrU0U2bjJ4S2tkcmFRR3JlQ0VOVHN5?=
 =?utf-8?B?SnRiR2dYQWwxYnR4TnM0aXl0ODFxL0w3ZjMzUWpIUnFwNzlxVFkxQlB2d0hQ?=
 =?utf-8?B?bUg2NE41bENZN0tnakJaWU5tZUd2eHNXNXRFbG5RZThjZk1HNjhGQVRKd3hU?=
 =?utf-8?B?TjNOTnYrbVhmQVQ0OHR1RFdBUlByVHVaVzAvL1kvTE9JelZGT0tvb1E1eVdk?=
 =?utf-8?B?a0Z0VWpXMWc5Uno3WkoydU9BaTM3UDZyNlloZmlOMExqRW1WWjFJUkR6Rncz?=
 =?utf-8?B?bHcwS1h1V0JRZzNXK1JRcWJOZ2JzblNpZVp0Y2JlcnZxaWpieHo1N21HRXhn?=
 =?utf-8?B?aUJpM0NMeWhiTXRpekYrQWRGbEhZZXlRTlpUNWI2YW42QTh4b3NCRXRyMHhq?=
 =?utf-8?B?QUx5eFhGMW1YbkRCWEZ0YS91aW9XaE9QbmdMNmhmYlRyVW5DeTNKOEdXTmJy?=
 =?utf-8?B?NksvcEJPOCtxbWpld3RsWWV6MXg5QkJWeDNvQXdWVmJZQnpRY2kzMlNVc3Nz?=
 =?utf-8?B?MWtyeXhSeWRqK3AvUWU4MHdxeVJDNVY4YitXdjdBc0U5bjZFdFVLNFNpWkhC?=
 =?utf-8?B?Q3hoKzBGano3eEtMY2VjYTVRQmJLQlowWkhHZDNIMkt2WE1VYmd2V3d1ZWVK?=
 =?utf-8?B?UVE2S29MU0VIWHVINEpwdGdxb3pkajB1VE5pTEN5VHZoWW5oSExJRWt0Y3hE?=
 =?utf-8?B?Q3F4a2JVMFpXeXMzcjM0WDQ5NDVGZ3VjSUx4ZzVLbjlZd3hpc28xM3hNNzBN?=
 =?utf-8?B?dkNNbHlvblJNV2J2eHpidDBJczlQcUw3U1BvbXZ6UDNmcjkrSWFmcW1qOHhZ?=
 =?utf-8?B?Uy8xNVlPNDlJOFdXcUQyY3c4ZjJlVHlpajBzaHJ1Tm5WK2hvYU1vcVowc3hp?=
 =?utf-8?B?dmM5UHFYcFZhc2k2Y21UM21Md3Rpd2UvbjEwZnFTdHJRdHN1RzJoWUdNVXpz?=
 =?utf-8?B?TWNTWWN1ZGczbnVqWUVLbFdaUXZjVHM1ZFJDSTVoL2szWUtBWmRGR29ZQjB3?=
 =?utf-8?B?eWVqa1lzNjJyTDdOamZLM3VJdWRhcjFBMzRvMFlvbDlVRVNNMVFiQmJ6dzVD?=
 =?utf-8?B?eG5PSU1JUkNVbjF4cGhrYVFHSWNJT0xES2hoMXpmKzBQVUh6Rlg1dU5OK3Bs?=
 =?utf-8?B?OUY1MDJMRVNUVzA5ZU04WHZ6RDNEb2pCMFh4blJjUE1ld2ZWQ0NZUmVTbXpT?=
 =?utf-8?B?NUZSVS9wRXBKa3Qwc1NBejdxTTlvNk9pVUczeHp2R3J5OWU2Z3Z0YWRxbFdV?=
 =?utf-8?B?djFYVVo4WHZvdGFpcDNFWkV6cGwyZGZUUm00RXQwUUFEREpsZHhGYWhqZ2pK?=
 =?utf-8?B?YU82bGYyQUNmcDkvNGRjTGxGYTVpWVowZ0FnRjR0UWVJTWNmVXhZMFFHSFJ6?=
 =?utf-8?B?RlRLVWc5c0VpSkRGY2RpWTVrbUJqa0k1b21aU3B6T0pxSUE5cHd2QTcvK25I?=
 =?utf-8?B?VUlGdGZZcy96UGJFMjF1Y3YraitIUk5icHZXTVBzNm1NRGs2cmhZeXFqYU5m?=
 =?utf-8?B?bHQ1MGxjQzJDY2U2VVlTUUt1ZkRjSDVxZHlCTTRWUnNXbEpWUmtLVUZScGIr?=
 =?utf-8?B?ZDhlTExRem9BNUp2Z0V4UVBnM1Uvci9TR21GUGMzOHpiRGxpYi80YkM0NDE2?=
 =?utf-8?B?WXYxNjFKckEwUzVEMnVWVGw3a2dNTWt4WmlMZlZoU2JVNmFnQW5UTndFTS9o?=
 =?utf-8?B?ejNnOEVSZ2lmanFJczNLSGJyemVYN29qZlV3eHBjY3BNTGdSeUdYSkRPUUlT?=
 =?utf-8?B?VjZ5UW1EUVUrVU0xSlFDWnV6dWRJWGYrTzBMZzQvQVhWUmtHb1Vud3g4cDla?=
 =?utf-8?B?QjVqZk5CRXZTd0ovWHlWb0F0c2kvUHYxaTBGYmlsRTE2aHo5QnJlN2Q1ZXpn?=
 =?utf-8?B?endDaWUwSTRWUE1Oa1Mrb0QxQkNjT3lHUnQwMFR6SURZTmt5VDV2VWdSSHpH?=
 =?utf-8?B?UXZqSDZidGNJdUNyY0lpcFRWSmx2bTdnV0hRS3MrcnFvS3c2U0d6QmNOOGRu?=
 =?utf-8?B?cVhjUXhkLzEzMWVHNzZaNDNVUkVIZ0NvbjBBV2RMN3k2cXNXZFd0RVZ3WERP?=
 =?utf-8?B?RzZHczRZYm1ncFhmVTk2Rklldk0zeTRmNlU1cTFXbkc2djNWcVZtamZaejhj?=
 =?utf-8?B?SUFPVWRnaGp6VG5GR0hmTVhqMHppSHREZUpBN3pqRFU3UXg3aXlnYS9adEVt?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D96F90B1A71584F8A99D52831AE1477@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da8132b-c5af-49b6-c877-08da8efeb688
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 05:23:06.1132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZLInEKIAvEKGSLSf7pDRBF+rFrlyfqsYSglDtn8OmVHl4FTQJ007OdKBScQtY9rXJ2CBqVvqHov55xkii4zG+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5367
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMzAsIDIwMjIgYXQgMDg6MzU6NTlQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gVXNlIENsZWFyUGFnZUhXUG9pc29uKCkgaW5zdGVhZCBvZiBUZXN0Q2xlYXJQYWdlSFdQ
b2lzb24oKSB0byBjbGVhciBwYWdlDQo+IGh3cG9pc29uIGZsYWdzIHRvIGF2b2lkIHVubmVlZGVk
IGZ1bGwgbWVtb3J5IGJhcnJpZXIgb3ZlcmhlYWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWFv
aGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCg0KQWNrZWQtYnk6IE5hb3lhIEhvcmlndWNo
aSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+
