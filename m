Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2418953E09C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 06:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiFFEyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 00:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiFFEyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 00:54:47 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2060.outbound.protection.outlook.com [40.107.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5570C244468
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 21:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1BDrRICesgoNARNzMIdjTd3arNwUQtgbQaEmWZjHflmB4iZIdU972C1f40qsl00IeXCtd4KuK+Qbva2eDcC4NMYrAjGNkMm+rLyeIq4yG/wBAh6TB7/qbXnSZc6AAIM2n5WUsuGbgib7nuitbTYGo8ubqricCwBIb/Xo0UGNswWotE2rnQK2o7+GAlmec9oQ4O+rgBRUaA4Di9usL2maxxXLIe80HYnTxAmXWgin2CLjrq0d4voD059FN3dQ5ylMaMinTqCCBwI3OrcOqaBeyD+62jYz+/uTvYoZcCvo7HtiW6wCAsJ6qOCXr3CYyOpfqVHum1O3910nzW9tJAgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0g10NWqLrJKgS3jBReboGF6PfHLiDqa+f4148X84uCE=;
 b=jAnlEQ/r+M/7N73s93qh0lvzdLAu8yzXZP8Kuh2zw+YcPQuDtEU9K6BppxTJWH+A+UCLmS8r0Vt4kNxJrL5UiPVzxpOPYi95RpW/nphsLI20JOZkEGUkhBx3IruMGijYXJi3jTISnkbf9JS0yfDYIBTVR8rPpuURx5/o3TkPh8blrJmVxywEueD2vK8UkqNAee9OQrEQuh8FCj4Az+Xwe5vesLAkQUiYgT8FSK1QsENiJaHpctNv6Hb6RQkjz2xNg3bwe8jVEKr+t1JuSHTwgYNmh0X+ca4Y5gjtwuABmAFfUERQUwK5j6EqDBy2X+mOMEKFqMQ4aGj5DlXWMeVMJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0g10NWqLrJKgS3jBReboGF6PfHLiDqa+f4148X84uCE=;
 b=PGy+G8mY+Fs2AhJUccp243HR6cxA6GgvkxKLQ2Quj1rxZGZDEjBPPoZ6o0P93955UkcVPk+EkgGlmR9yGkeH5yY/vASs/xaWIk2gxBv+osqvGosn0+o67BpgXpZORYSU7BxHxu2/O1q6l4MrsqKT8eAuP64Vh2W7gFhIhVy3UM0=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB2899.jpnprd01.prod.outlook.com (2603:1096:603:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Mon, 6 Jun
 2022 04:32:03 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995%2]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 04:32:03 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: Re: [PATCH] mm/memory-failure: don't allow to unpoison hw
 corrupted page
Thread-Topic: Re: [PATCH] mm/memory-failure: don't allow to unpoison hw
 corrupted page
Thread-Index: AQHYd/77DaeB5sxRWU66b+I0guEwlK0/mYsAgACevACAAZR3AA==
Date:   Mon, 6 Jun 2022 04:32:03 +0000
Message-ID: <20220606043202.GA1328953@hori.linux.bs1.fc.nec.co.jp>
References: <20220604103229.3378591-1-pizhenwei@bytedance.com>
 <20220604115616.b7d5912ac5a37db608f67b78@linux-foundation.org>
 <584eedd3-9369-9df1-39e2-62e331abdcc0@bytedance.com>
In-Reply-To: <584eedd3-9369-9df1-39e2-62e331abdcc0@bytedance.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96dd5bf4-e6c9-45e8-9fa2-08da47758144
x-ms-traffictypediagnostic: OSAPR01MB2899:EE_
x-microsoft-antispam-prvs: <OSAPR01MB28990081346D9B018D209A7CE7A29@OSAPR01MB2899.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ib3HDSLYatp19SYTucg6byYyf9iL1zvwOc6D0exPflRi/hNsSMTqawE1As+QFBtFzo7S5yGVRMq67ZM1tMec983S6HN2gh/g3fm1NYKF0S8xgaNwRiCJ8s4Mjf6yy2JE9r6gZH+iaITpVyVRuqEQgyiZ9Uh/hE/G6YvibfQ3JTpAWObkVowWjKTbv3wz5efHkvsT7G5jSpxU/CFQ33iJrRek44GUXt9SvHkFbzdiaBmQz0iB9ogYBEw6nCqA31hH8nM32j583W6e68gd52y2ha6rY57atjZgNAQHvuPYIEqrOEp2emaPH+x8tW6DD05ax4aBHsxTtoI7+MH5m41vfosQS9fqYsEO6znIDVdkbZiS9axHO21GwgxQWzdx4wPKm/dIewBfHOrxi+LxC79k4+jKNIxg1qBhNpQx5+/7+Acof9HGtVIS2vEgO08nUsBNqqLTIg4TQwPqCeerigkxMMX2XyGcgh8zeDSpCOSUVWaZZGnwmavwEiCI5l3j2Y7unrU5OKudZsyDanRYDW37N/0EiqmPB84Ti0nLQNJWrwK4ZkprtC7iRsbM3C382vwpFYMY1vPOh18oPgHW855IanFI386DAdoJAnJmWa/J0HJDkX+ssPrBHCOKtOzs+JHUk3g9opyvvmUASSTy1sxZ/5bIgDOFJN9MB5uGnb0litnF7dKiskprSoyIqjpv4NFdUs1LliKJWRYZeweLdggLhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(83380400001)(186003)(54906003)(38100700002)(316002)(8936002)(6486002)(5660300002)(71200400001)(33656002)(508600001)(86362001)(76116006)(55236004)(85182001)(26005)(53546011)(6506007)(6512007)(9686003)(122000001)(38070700005)(64756008)(66446008)(82960400001)(2906002)(66556008)(8676002)(4326008)(66476007)(6916009)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEZYRDhEQzRyT2k1UzRTYzRMSVJnTi9hZithN3E1Qjk1REo2MHhlbnQ4VDJO?=
 =?utf-8?B?UWVSRUp6V0IzbHZYcDR1bHRpTFc1VzNGODZOYWd0NTNQd2JJQmN4Zk9lakdV?=
 =?utf-8?B?dGdHZ0w5b1lWM1lZUjQ4MEZYYTBuUi9VQi9RcnAyVXJNZnhkOE8yQXJrcEtG?=
 =?utf-8?B?U2tZUUJrQVVvR0JMRWRpODRmVTFENDlmREg5OTd0U1drclRhSUMvSHRSZWNL?=
 =?utf-8?B?VDhvbWJoSzA4WTdBV1RKQXNrSVBwTDN0bjArNDdCWWJVVTdEcTdyZ25JY1Ft?=
 =?utf-8?B?U1dNNHc5WEFXWElCMmFIZ2Q1SUp4eFdIM0tnekVqaXRoZ0RVUWJIT3d5ckl2?=
 =?utf-8?B?SGIyN0FPUUVLcmlBeDlJelluYXlyVW9KbjFkcUZhdFVPbFlJODIwbnI4NnZP?=
 =?utf-8?B?ZzRzek9tZWViWlNwUGFZVTE0VlE2Z1pJMDJ6Z1hWK2JBWlVidEM4eWR6dzUx?=
 =?utf-8?B?R3REZ1hDaytuSWJBaVRHK0FGN3grNktkYzlRd3pPcnBBakxKc0xNR3dDY3ky?=
 =?utf-8?B?VjdPMjV1LzZNQnd6NUgxVGhWUGdHeUNZNUw3N1lRTnEwaWppZTEza1ZBRDJG?=
 =?utf-8?B?WDU2YUtadnQ0RTl6cTRid2pEK3UvN3dLNVdYQWJpbzVTTWlpK3luSUFCTXpi?=
 =?utf-8?B?V21QRnJIOHRmSVl4bFU4RDh1a0M3WkZGLzZMTlp4dUFGbkp1TmNqNmN6WmFk?=
 =?utf-8?B?VENuZ215UkF3NGVtRFNVL1ZlTUl6c3BFcFNOUmRnZ3lBK2NxRi9OWU9LWS9T?=
 =?utf-8?B?OTJVVkFwa2k5REFsWmUwbnJFcHhYckNrRTlDU1NVcjVPd0dPTzFNZ29ubVFj?=
 =?utf-8?B?VENTU3greGwwZlFFd1d4RzI4anJnU0FTZU1mdlcyMG5xU2tBaDkxWTZtTVps?=
 =?utf-8?B?RDA3QVgvWVF0eUVwOVZDMEFTeThROU55RUxsNEdvVVRzV2JmSlBTWmd6eW1z?=
 =?utf-8?B?VDR0b0JidXl3cEc2eTJEcE01OXlvaTVOeUpIYndyZllmcDZ5ZWg3alNNSUFj?=
 =?utf-8?B?Zld1WVpyelFPVkJ4VkxXM0VXWnNRNG5FYmRLdzJ1dDM4bXczWFpxQVBnclds?=
 =?utf-8?B?bVR2TDFURC9LUjVGWnRNMWh1a3RxTEV2azFGVXJ2T211QzRXRTM1a0ZLbFpw?=
 =?utf-8?B?TVlrOGNkU2FiVUIrK2ROK3QzcThBNlpGZk5OOTM2QnVLNTljZ1U1VHlIVEpM?=
 =?utf-8?B?aTF0dmRld0pUTTFQUkpvZkg1N2FQZmhCNFJtZVVXTFhadDM0U0xkcnJXeUxk?=
 =?utf-8?B?QmZKSlVwZDF3S3JlTkxBck1sd1FEeVl2MmtOVTRKazRaTXZFTEhlSU5Zemp5?=
 =?utf-8?B?K3F3SHFaN21PbDJLeVdCelNaeFl0K0lDQWE3TVcrTjI2dnlXQUhxaWtBNlRG?=
 =?utf-8?B?Q1NZZzVubWdxdkt4dkRyUG1oVmhPdzcxanZWZERZWlpaT3pkMFY0RHFKWUxh?=
 =?utf-8?B?RVFrc3N6MmdqaXZFaFk4MGtmbFJPUGYzNW1Lakg0QUVoWFI1a3dMaGR4Q2tv?=
 =?utf-8?B?YVlHR2NOQ3FFcy8yUVdKVzQvYkJyd3RqVTQvQkhGNTZMS0dtbCtkNnNUbUd1?=
 =?utf-8?B?c3FmK1NKU0ZNZ0hxVitQWG0wY2FDYlpDaldqYW4yR0xBS3lyQkFjNFJSVkhl?=
 =?utf-8?B?OXRwaXpzYXNaS0dJUGplaTl5RU1DU24zQjdyM0hiNnI4aW1qUkc1eEdaZWlO?=
 =?utf-8?B?eGN2RjN4c1h1OWtCZElNcGQwcmhOSjFScHg5T0lUOG82SERWb2UxbWY4Rm1m?=
 =?utf-8?B?Qko1RlNCWFhlMHlCRFhtNWtONDhTTnJ2R01Jek5yb2JLUlczditUY1QvZTIy?=
 =?utf-8?B?ZE1QMS8xSmhNRk5iMkUySmdGRm9iYjhoQUIrN2k1dmMzLzRWNHprSmZBaVp1?=
 =?utf-8?B?cjliWitOQzA4TERQZjRlYXFkbmNHdWNYcjJES29RRzBuNTUrdWtLbFA4M0xQ?=
 =?utf-8?B?bkVncFVHOUMxMk1uOERoaklROVo4bm1zUnlxNHcyOUtoaHVOcEF3d1lSNjNy?=
 =?utf-8?B?MmQraFczUXkwS3FTaWQzQXh2UXNvWERvc1pmelVaeW84YmRkSUxYZ3p5Q055?=
 =?utf-8?B?dzU1WlI0clZBWWM0UHk3ZFFtdWNsT0o3aWhIRzlSbFM1c3pXU2hpdFhDUjVS?=
 =?utf-8?B?M01Ja3gzYm8zME05cW43R3VzOURCRUJOMVgyQVk1bHRhbmREbThFTC9EVS9V?=
 =?utf-8?B?eStsaktHb1pBNkk5dW42ZkpYNEVjb2hWbU1lZno0VmZRd0oybVlNN2gzSUxh?=
 =?utf-8?B?YVB0Q2J4MkMxK0tLSVhSZFRCaDltaGJXN1AraVU3bkZ6YWN4ckVIQStPYWpk?=
 =?utf-8?B?THFuTmwyTys1ekErVExMTnZFZ3NscDRqaUpOdnVDSXhxemZYN2NjaHd1d0lL?=
 =?utf-8?Q?x32SihV5My0USxgA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7474D3A91173548A052ED8D149BBC48@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dd5bf4-e6c9-45e8-9fa2-08da47758144
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 04:32:03.1381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55SKlOOOJa/tKWLTvf6xNrA99zw+Rely6Jcd+aj2nXsapwNy4bEgyJYcBNt1ThJo3hi+BfCOlW/xyMaBGOTPxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2899
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBKdW4gMDUsIDIwMjIgYXQgMTI6MjQ6MjRQTSArMDgwMCwgemhlbndlaSBwaSB3cm90
ZToNCj4gDQo+IA0KPiBPbiA2LzUvMjIgMDI6NTYsIEFuZHJldyBNb3J0b24gd3JvdGU6DQo+ID4g
T24gU2F0LCAgNCBKdW4gMjAyMiAxODozMjoyOSArMDgwMCB6aGVud2VpIHBpIDxwaXpoZW53ZWlA
Ynl0ZWRhbmNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gPiBDdXJyZW50bHkgdW5wb2lzb25fbWVt
b3J5KHVuc2lnbmVkIGxvbmcgcGZuKSBpcyBkZXNpZ25lZCBmb3Igc29mdA0KPiA+ID4gcG9pc29u
KGh3cG9pc29uLWluamVjdCkgb25seS4gVW5wb2lzb25pbmcgYSBoYXJkd2FyZSBjb3JydXB0ZWQg
cGFnZQ0KPiA+ID4gcHV0cyBwYWdlIGJhY2sgYnVkZHkgb25seSwgdGhpcyBsZWFkcyBCVUcgZHVy
aW5nIGFjY2Vzc2luZyBvbiB0aGUNCj4gPiA+IGNvcnJ1cHRlZCBLUFRFLg0KDQpUaGFuayB5b3Ug
Zm9yIHRoZSBwYXRjaC4gSSB0aGluayB0aGlzIHdpbGwgYmUgaGVscGZ1bCBmb3IgaW50ZWdyYXRp
b24gdGVzdGluZy4NCg0KWW91IG1lbnRpb24gImhhcmR3YXJlIGNvcnJ1cHRlZCBwYWdlIiBhcyB0
aGUgY29uZGl0aW9uIG9mIHRoaXMgYnVnLCBhbmQgSQ0KdGhpbmsgdGhhdCBpdCBtZWFucyBhIHJl
YWwgaGFyZHdhcmUgZXJyb3IsIGJ1dCB0aGlzIEJVRyBzZWVtcyB0byBiZQ0KdHJpZ2dlcmVkIHdo
ZW4gd2UgdXNlIG1jZS1pbmplY3Qgb3IgQVBFSSAodGhlc2UgYXJlIGFsc28gc29mdHdhcmUgaW5q
ZWN0aW9uDQp3aXRob3V0IGNvcnJ1cHRpbmcgdGhlIG1lbW9yeSBwaHlzaWNhbGx5KS4gU28gdGhl
IGFjdHVhbCBjb25kaXRpb24gaXMNCiJ3aGVuIG1lbW9yeV9mYWlsdXJlKCkgaXMgY2FsbGVkIGJ5
IE1DRSBoYW5kbGVyIj8NCg0KPiA+ID4gDQo+ID4gPiBEbyBub3QgYWxsb3cgdG8gdW5wb2lzb24g
aGFyZHdhcmUgY29ycnVwdGVkIHBhZ2UgaW4gdW5wb2lzb25fbWVtb3J5KCkNCj4gPiA+IHRvIGF2
b2lkIEJVRyBsaWtlIHRoaXM6DQo+ID4gPiANCj4gPiA+ICAgVW5wb2lzb246IFNvZnR3YXJlLXVu
cG9pc29uZWQgcGFnZSAweDYxMjM0DQo+ID4gPiAgIEJVRzogdW5hYmxlIHRvIGhhbmRsZSBwYWdl
IGZhdWx0IGZvciBhZGRyZXNzOiBmZmZmODg4MDYxMjM0MDAwDQo+ID4gDQo+ID4gVGhhbmtzLg0K
PiA+IA0KPiA+ID4gLS0tIGEvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+ID4gKysrIGIvbW0vbWVt
b3J5LWZhaWx1cmUuYw0KPiA+ID4gQEAgLTIwOTAsNiArMjA5MCw3IEBAIGludCB1bnBvaXNvbl9t
ZW1vcnkodW5zaWduZWQgbG9uZyBwZm4pDQo+ID4gPiAgIHsNCj4gPiA+ICAgCXN0cnVjdCBwYWdl
ICpwYWdlOw0KPiA+ID4gICAJc3RydWN0IHBhZ2UgKnA7DQo+ID4gPiArCXB0ZV90ICprcHRlOw0K
PiA+ID4gICAJaW50IHJldCA9IC1FQlVTWTsNCj4gPiA+ICAgCWludCBmcmVlaXQgPSAwOw0KPiA+
ID4gICAJc3RhdGljIERFRklORV9SQVRFTElNSVRfU1RBVEUodW5wb2lzb25fcnMsIERFRkFVTFRf
UkFURUxJTUlUX0lOVEVSVkFMLA0KPiA+ID4gQEAgLTIxMDEsNiArMjEwMiwxMyBAQCBpbnQgdW5w
b2lzb25fbWVtb3J5KHVuc2lnbmVkIGxvbmcgcGZuKQ0KPiA+ID4gICAJcCA9IHBmbl90b19wYWdl
KHBmbik7DQo+ID4gPiAgIAlwYWdlID0gY29tcG91bmRfaGVhZChwKTsNCj4gPiA+ICsJa3B0ZSA9
IHZpcnRfdG9fa3B0ZSgodW5zaWduZWQgbG9uZylwYWdlX3RvX3ZpcnQocCkpOw0KPiA+ID4gKwlp
ZiAoa3B0ZSAmJiAhcHRlX3ByZXNlbnQoKmtwdGUpKSB7DQo+ID4gPiArCQl1bnBvaXNvbl9wcl9p
bmZvKCJVbnBvaXNvbjogUGFnZSB3YXMgaGFyZHdhcmUgcG9pc29uZWQgJSNseFxuIiwNCj4gPiA+
ICsJCQkJIHBmbiwgJnVucG9pc29uX3JzKTsNCg0KVGhpcyBjYW4gcHJldmVudCB1bnBvaXNvbiBm
b3IgaHdwb2lzb24gb24gNGtCIHBhZ2VzLCBidXQgbm90IGZvciBodWdldGxiIHBhZ2VzLA0Kd2hl
cmUgSSBzZWUgdGhlIHNpbWlsYXIgQlVHIGFzIGZvbGxvd3MgKGV2ZW4gd2l0aCBhcHBseWluZyB5
b3VyIHBhdGNoKToNCg0KICBbICA5MTcuODA2NzEyXSBCVUc6IHVuYWJsZSB0byBoYW5kbGUgcGFn
ZSBmYXVsdCBmb3IgYWRkcmVzczogZmZmZjlmN2JiMzIwMTAwMA0KICBbICA5MTcuODEwMTQ0XSAj
UEY6IHN1cGVydmlzb3Igd3JpdGUgYWNjZXNzIGluIGtlcm5lbCBtb2RlDQogIFsgIDkxNy44MTI1
ODhdICNQRjogZXJyb3JfY29kZSgweDAwMDIpIC0gbm90LXByZXNlbnQgcGFnZQ0KICBbICA5MTcu
ODE1MDA3XSBQR0QgMTA0ODAxMDY3IFA0RCAxMDQ4MDEwNjcgUFVEIDEwMDA2YjA2MyBQTUQgMTA1
MmQwMDYzIFBURSA4MDBmZmZmZWNjZGZlMDYyDQogIFsgIDkxNy44MTg3NjhdIE9vcHM6IDAwMDIg
WyMxXSBQUkVFTVBUIFNNUCBQVEkNCiAgWyAgOTE3LjgyMDc1OV0gQ1BVOiAwIFBJRDogNzc3NCBD
b21tOiB0ZXN0X2FsbG9jX2dlbmUgVGFpbnRlZDogRyAgIE0gICAgICAgT0UgICAgIDUuMTguMC12
NS4xOC0yMjA2MDYtMDk0Mi0wMjktZ2U0ZGNjKyAjNDcNCiAgWyAgOTE3LjgyNTcyMF0gSGFyZHdh
cmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4x
NS4wLTEuZmMzNSAwNC8wMS8yMDE0DQogIFsgIDkxNy44Mjk3NjJdIFJJUDogMDAxMDpjbGVhcl9w
YWdlX2VybXMrMHg3LzB4MTANCiAgWyAgOTE3LjgzMTg2N10gQ29kZTogNDggODkgNDcgMTggNDgg
ODkgNDcgMjAgNDggODkgNDcgMjggNDggODkgNDcgMzAgNDggODkgNDcgMzggNDggOGQgN2YgNDAg
NzUgZDkgOTAgYzMgMGYgMWYgODAgMDAgMDAgMDAgMDAgYjkgMDAgMTAgMDAgMDAgMzEgYzAgPGYz
PiBhYSBjMyBjYyBjYyBjYyBjYyBjYyBjYyA0OCA4NSBmZiAwZiA4NCBkMyAwMCAwMCAwMCAwZiBi
NiAwZiA0Yw0KICBbICA5MTcuODQwNTQwXSBSU1A6IDAwMDA6ZmZmZmFiNDljMjVlYmRmMCBFRkxB
R1M6IDAwMDEwMjQ2DQogIFsgIDkxNy44NDI4MzldIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6
IGZmZmZkNTM4YzRjYzgwMDAgUkNYOiAwMDAwMDAwMDAwMDAxMDAwDQogIFsgIDkxNy44NDU4MzVd
IFJEWDogMDAwMDAwMDA4MDAwMDAwMCBSU0k6IDAwMDA3ZjJhZWI2MDAwMDAgUkRJOiBmZmZmOWY3
YmIzMjAxMDAwDQogIFsgIDkxNy44NDg2ODddIFJCUDogMDAwMDAwMDAwMDAwMDAwMCBSMDg6IDAw
MDAwMDAwMDAwMDAwMDAgUjA5OiAwMDAwMDAwMDAwMDAwMDAwDQogIFsgIDkxNy44NTEzNzddIFIx
MDogMDAwMDAwMDAwMDAwMDAwMiBSMTE6IGZmZmY5ZjdiODdlM2EyYTAgUjEyOiAwMDAwMDAwMDAw
MDAwMDAwDQogIFsgIDkxNy44NTQwMzVdIFIxMzogMDAwMDAwMDAwMDAwMDAwMSBSMTQ6IGZmZmZk
NTM4YzRjYzgwMDAgUjE1OiBmZmZmOWY3YmMwMDJhNWQ4DQogIFsgIDkxNy44NTY1MzldIEZTOiAg
MDAwMDdmMmFlYmFkMzc0MCgwMDAwKSBHUzpmZmZmOWY3YmJiYzAwMDAwKDAwMDApIGtubEdTOjAw
MDAwMDAwMDAwMDAwMDANCiAgWyAgOTE3Ljg1OTIyOV0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAw
MDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KICBbICA5MTcuODYxMTQ5XSBDUjI6IGZmZmY5Zjdi
YjMyMDEwMDAgQ1IzOiAwMDAwMDAwMTA3NzI2MDAzIENSNDogMDAwMDAwMDAwMDE3MGVmMA0KICBb
ICA5MTcuODYzNDMzXSBDYWxsIFRyYWNlOg0KICBbICA5MTcuODY0MjY2XSAgPFRBU0s+DQogIFsg
IDkxNy44NjQ5NjFdICBjbGVhcl9odWdlX3BhZ2UrMHgxNDcvMHgyNzANCiAgWyAgOTE3Ljg2NjIz
Nl0gIGh1Z2V0bGJfZmF1bHQrMHg0NDAvMHhhZDANCiAgWyAgOTE3Ljg2NzM2Nl0gIGhhbmRsZV9t
bV9mYXVsdCsweDI3MC8weDI5MA0KICBbICA5MTcuODY4NTMyXSAgZG9fdXNlcl9hZGRyX2ZhdWx0
KzB4MWMzLzB4NjgwDQogIFsgIDkxNy44Njk3NjhdICBleGNfcGFnZV9mYXVsdCsweDZjLzB4MTYw
DQogIFsgIDkxNy44NzA5MTJdICA/IGFzbV9leGNfcGFnZV9mYXVsdCsweDgvMHgzMA0KICBbICA5
MTcuODcyMDgyXSAgYXNtX2V4Y19wYWdlX2ZhdWx0KzB4MWUvMHgzMA0KICBbICA5MTcuODczMjIw
XSBSSVA6IDAwMzM6MHg3ZjJhZWI4YmEzNjcNCg0KSSBkb24ndCB0aGluayBvZiBhIHdvcmthcm91
bmQgZm9yIHRoaXMgbm93IC4uLg0KDQo+ID4gPiArCQlyZXR1cm4gLUVQRVJNOw0KDQpJcyAtRU9Q
Tk9UU1VQUCBhIGJldHRlciBlcnJvciBjb2RlPw0KDQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+
ICAgCW11dGV4X2xvY2soJm1mX211dGV4KTsNCj4gPiA+ICAgCWlmICghUGFnZUhXUG9pc29uKHAp
KSB7DQo+ID4gDQo+ID4gSSBndWVzcyB3ZSBkb24ndCB3YW50IHRvIGxldCBmYXVsdCBpbmplY3Rp
b24gY3Jhc2ggdGhlIGtlcm5lbCwgc28gYQ0KPiA+IGNjOnN0YWJsZSBzZWVtcyBhcHByb3ByaWF0
ZSBoZXJlLg0KPiA+IA0KPiA+IENhbiB3ZSB0aGluayB1cCBhIHN1aXRhYmxlIEZpeGVzOiBjb21t
aXQ/ICBJJ20gc3VzcGVjdGluZyB0aGlzIGJ1ZyBoYXMNCj4gPiBiZWVuIHRoZXJlIGZvciBhIGxv
bmcgdGltZT8NCj4gPiANCj4gDQo+IFN1cmUhDQo+IA0KPiAyMDA5LURlYy0xNiwgaHdwb2lzb25f
dW5wb2lzb24oKSB3YXMgaW50cm9kdWNlZCBpbnRvIGxpbnV4IGluIGNvbW1pdDoNCj4gODQ3Y2U0
MDFkZjM5MigiSFdQT0lTT046IEFkZCB1bnBvaXNvbmluZyBzdXBwb3J0IikNCj4gLi4uDQo+IFRo
ZXJlIGlzIG5vIGhhcmR3YXJlIGxldmVsIHVucG9pc2lvbmluZywgc28gdGhpcyBjYW5ub3QgYmUg
dXNlZCBmb3IgcmVhbA0KPiBtZW1vcnkgZXJyb3JzLCBvbmx5IGZvciBzb2Z0d2FyZSBpbmplY3Rl
ZCBlcnJvcnMuDQo+IC4uLg0KPiANCj4gV2UgY2FuIGZpbmQgdGhhdCB0aGlzIGZ1bmN0aW9uIHNo
b3VsZCBiZSB1c2VkIGZvciBzb2Z0d2FyZSBsZXZlbCB1bnBvaXNvbmluZw0KPiBvbmx5IGluIGJv
dGggY29tbWl0IGxvZyBhbmQgY29tbWVudCBpbiBzb3VyY2UgY29kZS4gdW5mb3J0dW5hdGVseSB0
aGVyZSBpcw0KPiBubyBjaGVjayBpbiBmdW5jdGlvbiBod3BvaXNvbl91bnBvaXNvbigpLg0KPiAN
Cj4gDQo+IDIwMjAtTWF5LTIwLCAxN2ZhZTEyOTRhZDlkKCJ4ODYve21jZSxtbX06IFVubWFwIHRo
ZSBlbnRpcmUgcGFnZSBpZiB0aGUgd2hvbGUNCj4gcGFnZSBpcyBhZmZlY3RlZCBhbmQgcG9pc29u
ZWQiKQ0KPiANCj4gVGhpcyBjbGVhcnMgS1BURSwgYW5kIGxlYWRzIEJVRyhkZXNjcmliZWQgaW4g
dGhpcyBwYXRjaCkgZHVyaW5nIHVucG9pc29uaW5nDQo+IHRoZSBoYXJkd2FyZSBjb3JydXB0ZWQg
cGFnZS4NCj4gDQo+IA0KPiBGaXhlczogODQ3Y2U0MDFkZjM5MigiSFdQT0lTT046IEFkZCB1bnBv
aXNvbmluZyBzdXBwb3J0IikNCj4gRml4ZXM6IDE3ZmFlMTI5NGFkOWQoIng4Ni97bWNlLG1tfTog
VW5tYXAgdGhlIGVudGlyZSBwYWdlIGlmIHRoZSB3aG9sZSBwYWdlDQo+IGlzIGFmZmVjdGVkIGFu
ZCBwb2lzb25lZCIpDQo+IA0KPiBDYzogV3UgRmVuZ2d1YW5nIDxmZW5nZ3Vhbmcud3VAaW50ZWwu
Y29tPg0KPiBDYzogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPi4NCg0KVGhhbmtzIGZv
ciBjaGVja2luZyB0aGUgaGlzdG9yeSwgSSBhZ3JlZSB3aXRoIHNlbmRpbmcgdG8gc3RhYmxlLg0K
DQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
