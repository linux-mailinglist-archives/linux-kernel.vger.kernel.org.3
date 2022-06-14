Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA79454AA13
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352980AbiFNHJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353130AbiFNHJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:09:39 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2072.outbound.protection.outlook.com [40.107.113.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EE43B2BA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:09:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eL2R9tnnERrsecRJEvjbP81IwVBb2FNUYBc9EjQSUDdrlEzGCImvxmJGIBOXSgQoPpe18C7V1H8xOfqHxdVm+z1zTHC4xl2/+eV6lpB5lwqXYxIdAPZ5lW5drbcnbpHM2sKxO7rSb8tUX1aX3E6AVM7pSzXvSx4lvl8qcCDmRFLcGXIHJNNeyzQaiCiBkQOvaxds5saArK2XzYXGHroGYyAfGMqv/nriTFMxjPaLtMbIliW4EyLxl1mnYhUchSb8z8cpVAJ7sVCuIEzKnvVOjlp+gxA5r9xLNFixUsbaJxxsBtUisf2wC/aSFrd3lwx9qxBcrSzBmUZj6mZyPnGqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9tkQl82arLqNFv9V0HZupSi2L0QZlzmL3YNNs6g7So=;
 b=hnGDBuyy3RcBWNe/GQFuUNI6yhGgdGpnaNlkB3UIPVdmnWRWIrYQZuwq2gBBkUgt5ODhnh7CjvmA1t2SzY+1AAdEiNbtyo5MajXTeSjHNfkHsKnV7URt94wT0uKiuhDZ7HjDszLPnGlx66a6P1LShUiJF/8PBeKntNXnkh9KG8wYuJQZxtIubemcclXteh2IEKeNoY6UYa+UgDfPgNMWuiZ1MAR91bB3DewdnozsBNhvPYkRFdYrt1XvuMQop4pjWgujRLKiQtrjN0mIGrRQ/WmKg9OvHbAgvGxrS2649LJi3mRdsNDCH/kEkbbDs/a/28vRpEKMooF+OtVlX8xGuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9tkQl82arLqNFv9V0HZupSi2L0QZlzmL3YNNs6g7So=;
 b=Gl0EewZY6Owx6iYzpp1hdTquXpuIjMPK8vp3Nr3jac6N+z4gXlYItqXMp/Py0nykt+0gyZBspYtyZXTl3zbbTCUgKSluZb29NsttBzPs/CikiV2FY+3iBV9dPlSMRerDUU2Yxs3wwGCxQqJnb+SmdZQdSe65IF3H293Ol2wreDQ=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY2PR01MB2091.jpnprd01.prod.outlook.com (2603:1096:404:10::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Tue, 14 Jun
 2022 07:09:35 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::b00f:b11:37c6:29d0]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::b00f:b11:37c6:29d0%4]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 07:09:35 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>
Subject: Re: [PATCH v4 1/2] mm/memory-failure: introduce "hwpoisoned-pages"
 entry
Thread-Topic: [PATCH v4 1/2] mm/memory-failure: introduce "hwpoisoned-pages"
 entry
Thread-Index: AQHYf6hPooUNs/qNLUKEoEAupQBova1OfBUA
Date:   Tue, 14 Jun 2022 07:09:35 +0000
Message-ID: <20220614070934.GA1627546@hori.linux.bs1.fc.nec.co.jp>
References: <20220614043830.99607-1-pizhenwei@bytedance.com>
 <20220614043830.99607-2-pizhenwei@bytedance.com>
In-Reply-To: <20220614043830.99607-2-pizhenwei@bytedance.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbe9d614-d413-443f-b15b-08da4dd4d662
x-ms-traffictypediagnostic: TY2PR01MB2091:EE_
x-microsoft-antispam-prvs: <TY2PR01MB209159A0B34AB664BE3B2E91E7AA9@TY2PR01MB2091.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QgnZmAVVBOH68THm5ABVtiGPHdyEqdS5eqs4aIVDtLB0e3069YKlsnieCji+/AUVfMBCLtfqsBVLTEYPXYQeTpkrD0CchAhSYWBSk+2B7lHQ4IODRvbLa1dSu6kLubX9aSfFoQg8yfX64Qd912UlKcd5POzVbi6IibHKNzckulQu8Ymb6u1SR0QBuEHd2OCCxef5/IJGOLyOrk/dvS65h7+e3pZRXFfef650pNGlC+NIlhS8rE37VyGYrlZqd9iXV1L7CDAxvhPdsde3Y8vsYNr2J1nHy6XiUe7tBZ/xN1l32xsyx0ktLBWPU0ecKjWyGTfd2RTgCB6XqJgWJQqro06nv+qC7+beyEUsoR7d3D4ECLwusTaPWRJvAPyrGAgB565SEIe0mLwTbvaiulCAoJDq8MadNr0jiySrCtWa07EvoHQffyv7tMBLsOeIOhZDalwSxftQjbOIhBzoqT2gXA4tahvlIKCSYCNCtotry7jrxwGg7+YxD9Vyvkdaf7ODOcgqae1SycRSm/yXiTiKSNdIGi3p0l3Uk0dlqmudULMCNiePRffKDyRO5yh2uqfSdNGilYD3GvwyFPjb/YAXgfgEDoeqpCSQAZk2FSBYhwS2j52afbOGIkIKrvj5D+2YvGlIRvvJfZjiNKWJyR5lph2t51CdOXiJAdcIxpRMS3ZF9CoEVoAhidm2tWXImVVTFnag2O6CWc5PA4OcTYW06g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38070700005)(122000001)(71200400001)(6486002)(82960400001)(86362001)(8676002)(2906002)(8936002)(9686003)(66476007)(76116006)(66446008)(4326008)(66556008)(6916009)(64756008)(6512007)(26005)(1076003)(66946007)(508600001)(186003)(6506007)(316002)(55236004)(54906003)(38100700002)(83380400001)(5660300002)(33656002)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1FoS3Bkb1BYaGl6Y1B4NFk4ejZmNHQrZVZOL2tvb3ZDSTRhd21HL0dlcVMr?=
 =?utf-8?B?dkMwL2srNHNWaGhSNkNic2EwREs0WmNIM2hOSCt2MDZkaldCOFRMWDhEd3Ar?=
 =?utf-8?B?LzlaK3VSNkl1TFhQNEw2SmpVVXViMW12UlMrTEZFUE51MTM4L0xaNGVScXBt?=
 =?utf-8?B?OXhQUmxuRmNqbEptbkM5MmdLTks5Y0xBdlp6VXU4Y3ZhM3M3QnVoSXlmMW5y?=
 =?utf-8?B?QUR0am5Ea2dmY1VSSUxVOFdSeUlnZUE5dzlWNDNLWHhUeTFiWXJxU2p1OGdv?=
 =?utf-8?B?OWFPd1QyTElLdytaMTh2Q0srdzZZMEIrVXc1U3hNZEFKcU8zb2N6dERXNy9n?=
 =?utf-8?B?dkRSTmVJTktKejRHMlo0NDNnWHdxeVAwcXlubGJTM2wwRkp5YnZuY0JYbVZM?=
 =?utf-8?B?UXRUUlFLYURxTFpOQlBaSHh0S05zWHpCSzJnOGhybDFNc0dNK0I5SGJrQjFQ?=
 =?utf-8?B?RXpMYVBDb2NyR3NsSlZoMzlaN0NyeUJPZmVaRkQ4UGpvUlNTcTlvSEJTRHlX?=
 =?utf-8?B?dTltSmVRTm8xV2IrNTVSU3JRZ3NzaFJINkZtYkx4K3pnWHEydHdxZU1rZ3ZL?=
 =?utf-8?B?b0tBQiswTDlKM2crVWN6NW1BR2hNUzJTYS9yeTZxRlI4Y2VDcEQxNmNHaEc0?=
 =?utf-8?B?a2Q4cEpxbjRkSmtNSDhDYitHYWxZWEVtbmJZc09HVWJBM2JnUXBNMUVWd1NJ?=
 =?utf-8?B?SFNOU29aV2pqakQ1MjR3Y2ZxSG02SkkwRk5raUQrRVNEK0xRdUZXTFJEYzVU?=
 =?utf-8?B?UEY5cnFISEFMNnlGd1lWaEVJRlY3MG1oSHAydHJtVnpUaThIbG5VL0hramFJ?=
 =?utf-8?B?YnRKWmcwUW0wRWNlcGNSdHdEOWdEV0VJb25xakRHenVFNjZjcGRTdUh3L0Rq?=
 =?utf-8?B?UUNpWC9PeGE4N3RZc2pnMktyR01mckR3OTZCczJpYXVzM1JWQ2duVW5nZDcy?=
 =?utf-8?B?MVVsV3pUdWpEVm1BR3JrTmsyREJqKzlDOTZMN2x0V3lPNGRKakJhL0lBbmVW?=
 =?utf-8?B?bWxoanpxWDB6M2pXM0daSkx3cndIVExXajBtdE8zZGtLWVlTaHhHOTBvRUNI?=
 =?utf-8?B?c1Vaalo5NEtOUEFxazVHRWxHS2xmT1hiV3I4aHZrbmM3YkZ5eUxYejAyeURH?=
 =?utf-8?B?ems4TU1tbjlKbHRaRzExeHlGaGVLdlg0bVlUaDcxWS9kMUE4dU8zQ3NnMm1n?=
 =?utf-8?B?aWlsVFNQY2tkWDZYNjd4bFdveW05dGVJZjBsTnFqN21sYkQzSUxHY1pUWWdP?=
 =?utf-8?B?a2ZTQ3p3S3FNRU5zdm9qZGlyUEl6dEh5dmRSMFlzVlBuSkRiUEZ3MTNBUm5C?=
 =?utf-8?B?QndhU3poYmhRSm9CRG5hQkVoV2hWbXE3dmFFVUpGZWxPL0NXOU9MeHdmWll2?=
 =?utf-8?B?VXRyUVdlekFoN1ZNZGczejI3VHBhS2ErVnA0a3E3U3Ztd01xMTNrYlBhZzRX?=
 =?utf-8?B?RkcyNmhMOFVSOHNsdUJCd2FuQ21PWFcxMm9TQnRQVHgwaWNTekdjVTdWSDdL?=
 =?utf-8?B?WTNSTldUYmRBdDI1eUhXSi9rQkp2TExYWm1VTGwyZ25wcGdxTUxNQ2hOVWgv?=
 =?utf-8?B?TFpBdjBXbFB1ZEtnNG5RWVFCNldSbzZ6M1NzKzV6OTF1MXpDekkwaEVhWHBa?=
 =?utf-8?B?NUViWE5WdlAvemp1aXV0SUV2bFJmRzA3QzRlVTk5NERlUktPK3B4WFVkWnI1?=
 =?utf-8?B?MEQwV2p3b3Q3b0swN1VkVTdHelQzS21SUUQ1UVQwVEpuTW9qQmU2RnRJRmlk?=
 =?utf-8?B?Mjk5UlZRZU9qdE9VU1p1cnh0bmJrQ0NRNlBncjBkS1hGVkxOaTlWRDNSaTYx?=
 =?utf-8?B?MkVzekVUMkQxNmNIWllpTmpXUmRZcEFKWUhQOFNLTWRuYnZrWmRwb2lCbDlH?=
 =?utf-8?B?VG9TNFp3WlNMTEk2QW1CZ0JaWEJxeHJuNlBjSE5VM0tjMnV0WWgxTnhTRXhK?=
 =?utf-8?B?eFVvTjlEZHlQbEx1aTI5Z0hCUHFrS05CejhXMC9lU2JHRFRvcHJYMkdZa005?=
 =?utf-8?B?ZXNlRWMwc1RJeUFoM1o2ZytZaVltU1FmeTc2SGRsR2VYOTBtSGFCNkplSzNi?=
 =?utf-8?B?UCtnaFplQTNGWEZtM1BUREdrKzlqUEhQS2tUOFVMWVVlUk1Ic2laQlUzME1V?=
 =?utf-8?B?QnoxTG1QQ3hLRjFKWm9WVHRFUWh2QmFibGJsWGlnWHBmYWI2cWZyaThaTTJT?=
 =?utf-8?B?TlFySi9DUmQ3c0RKYnQxV2lYSWx4SWZiTFZYWkdodFY3djRLeVR0azhnRndT?=
 =?utf-8?B?ckhhSGdKL3dsMW9hODJRRVhtdWpOYmxaWWlqUUZUWEk3THVvbWxSZ2VpRVpG?=
 =?utf-8?B?Zk1aMHNEY056VnpUNFRLSWFHc2NNZjl6NXA2U3prdyttclZYb2tnOWVZSGNQ?=
 =?utf-8?Q?dmrLRrk1UonJesJg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E4544C75D9B8847A7C050750049019E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe9d614-d413-443f-b15b-08da4dd4d662
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 07:09:35.1231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQx1d25CkJT+DhUqXijQPl5M8QX2S+TL2/NenF4x2apdUPwdwTK6DRkLLLTNugk6w+W4Gq4SQ3aqJ2d8oxXGDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMTQsIDIwMjIgYXQgMTI6Mzg6MjlQTSArMDgwMCwgemhlbndlaSBwaSB3cm90
ZToNCj4gQWRkIGEgbmV3IGRlYnVnIGVudHJ5IHRvIHNob3cgdGhlIG51bWJlciBvZiBod3BvaXNv
bmVkIHBhZ2VzLiBBbmQNCj4gdXNlIG1vZHVsZV9nZXQvbW9kdWxlX3B1dCB0byBtYW5hZ2VyIHRo
aXMga2VybmVsIG1vZHVsZSwgZG9uJ3QgYWxsb3cNCj4gdG8gcmVtb3ZlIHRoaXMgbW9kdWxlIHVu
bGVzcyBod3BvaXNvbmVkLXBhZ2VzIGlzIHplcm8uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiB6aGVu
d2VpIHBpIDxwaXpoZW53ZWlAYnl0ZWRhbmNlLmNvbT4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9u
L3ZtL2h3cG9pc29uLnJzdCB8ICA0ICsrKysNCj4gIG1tL2h3cG9pc29uLWluamVjdC5jICAgICAg
ICAgIHwgMTkgKysrKysrKysrKysrKysrKysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi92bS9od3BvaXNvbi5yc3QgYi9Eb2N1bWVudGF0aW9uL3ZtL2h3cG9pc29uLnJzdA0KPiBpbmRl
eCBjNzQyZGUxNzY5ZDEuLmM4MzJhOGIxOTJkNCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlv
bi92bS9od3BvaXNvbi5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi92bS9od3BvaXNvbi5yc3QN
Cj4gQEAgLTE1NSw2ICsxNTUsMTAgQEAgVGVzdGluZw0KPiAgCWZsYWcgYml0cyBhcmUgZGVmaW5l
ZCBpbiBpbmNsdWRlL2xpbnV4L2tlcm5lbC1wYWdlLWZsYWdzLmggYW5kDQo+ICAJZG9jdW1lbnRl
ZCBpbiBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL21tL3BhZ2VtYXAucnN0DQo+ICANCj4gKyAg
aHdwb2lzb25lZC1wYWdlcw0KPiArCVRoZSBudW1iZXIgb2YgaHdwb2lzb25lZCBwYWdlcy4gVGhl
IGh3cG9pc29uIGtlcm5lbCBtb2R1bGUgY2FuIG5vdCBiZQ0KPiArCXJlbW92ZWQgdW5sZXNzIHRo
aXMgY291bnQgaXMgemVyby4NCj4gKw0KPiAgKiBBcmNoaXRlY3R1cmUgc3BlY2lmaWMgTUNFIGlu
amVjdG9yDQo+ICANCj4gICAgeDg2IGhhcyBtY2UtaW5qZWN0LCBtY2UtdGVzdA0KPiBkaWZmIC0t
Z2l0IGEvbW0vaHdwb2lzb24taW5qZWN0LmMgYi9tbS9od3BvaXNvbi1pbmplY3QuYw0KPiBpbmRl
eCA1YzBjZGRkODE1MDUuLjllNTIyZWNlZGVlZiAxMDA2NDQNCj4gLS0tIGEvbW0vaHdwb2lzb24t
aW5qZWN0LmMNCj4gKysrIGIvbW0vaHdwb2lzb24taW5qZWN0LmMNCj4gQEAgLTEwLDYgKzEwLDcg
QEANCj4gICNpbmNsdWRlICJpbnRlcm5hbC5oIg0KPiAgDQo+ICBzdGF0aWMgc3RydWN0IGRlbnRy
eSAqaHdwb2lzb25fZGlyOw0KPiArc3RhdGljIGF0b21pY190IGh3cG9pc29uZWRfcGFnZXM7DQo+
ICANCj4gIHN0YXRpYyBpbnQgaHdwb2lzb25faW5qZWN0KHZvaWQgKmRhdGEsIHU2NCB2YWwpDQo+
ICB7DQo+IEBAIC00OSwxNSArNTAsMjggQEAgc3RhdGljIGludCBod3BvaXNvbl9pbmplY3Qodm9p
ZCAqZGF0YSwgdTY0IHZhbCkNCj4gIGluamVjdDoNCj4gIAlwcl9pbmZvKCJJbmplY3RpbmcgbWVt
b3J5IGZhaWx1cmUgYXQgcGZuICUjbHhcbiIsIHBmbik7DQo+ICAJZXJyID0gbWVtb3J5X2ZhaWx1
cmUocGZuLCAwKTsNCj4gKwlpZiAoIWVycikgew0KPiArCQlXQVJOX09OKCF0cnlfbW9kdWxlX2dl
dChUSElTX01PRFVMRSkpOw0KPiArCQlhdG9taWNfaW5jKCZod3BvaXNvbmVkX3BhZ2VzKTsNCj4g
Kwl9DQoNClRoZXJlJ3MgYSBmZXcgb3RoZXIgaW50ZXJmYWNlcyB0byBnZW5lcmF0ZSAic29mdHdh
cmUtc2ltdWxhdGVkIG1lbW9yeSBlcnJvciINCmV2ZW50LCBpLmUuIG1hZHZpc2VfaW5qZWN0X2Vy
cm9yKCkgYW5kIGhhcmRfb2ZmbGluZV9wYWdlX3N0b3JlKCkuIFNvIHlvdSBuZWVkDQpoYW5kbGUg
c3VjaCBjb2RlIHBhdGguDQoNCj4gKw0KPiAgCXJldHVybiAoZXJyID09IC1FT1BOT1RTVVBQKSA/
IDAgOiBlcnI7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBpbnQgaHdwb2lzb25fdW5wb2lzb24odm9p
ZCAqZGF0YSwgdTY0IHZhbCkNCj4gIHsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICAJaWYgKCFjYXBh
YmxlKENBUF9TWVNfQURNSU4pKQ0KPiAgCQlyZXR1cm4gLUVQRVJNOw0KPiAgDQo+IC0JcmV0dXJu
IHVucG9pc29uX21lbW9yeSh2YWwpOw0KPiArCXJldCA9IHVucG9pc29uX21lbW9yeSh2YWwpOw0K
PiArCWlmICghcmV0KSB7DQo+ICsJCWF0b21pY19kZWMoJmh3cG9pc29uZWRfcGFnZXMpOw0KPiAr
CQltb2R1bGVfcHV0KFRISVNfTU9EVUxFKTsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gcmV0Ow0K
PiAgfQ0KPiAgDQo+ICBERUZJTkVfREVCVUdGU19BVFRSSUJVVEUoaHdwb2lzb25fZm9wcywgTlVM
TCwgaHdwb2lzb25faW5qZWN0LCAiJWxsaVxuIik7DQo+IEBAIC05OSw2ICsxMTMsOSBAQCBzdGF0
aWMgaW50IHBmbl9pbmplY3RfaW5pdCh2b2lkKQ0KPiAgCWRlYnVnZnNfY3JlYXRlX3U2NCgiY29y
cnVwdC1maWx0ZXItZmxhZ3MtdmFsdWUiLCAwNjAwLCBod3BvaXNvbl9kaXIsDQo+ICAJCQkgICAm
aHdwb2lzb25fZmlsdGVyX2ZsYWdzX3ZhbHVlKTsNCj4gIA0KPiArCWRlYnVnZnNfY3JlYXRlX2F0
b21pY190KCJod3BvaXNvbmVkLXBhZ2VzIiwgMDQwMCwgaHdwb2lzb25fZGlyLA0KPiArCQkJICAg
Jmh3cG9pc29uZWRfcGFnZXMpOw0KDQpJJ20gbm90IHN1cmUgaG93IHVzZWZ1bCB0aGlzIGludGVy
ZmFjZSBmcm9tIHVzZXJzcGFjZSAoY29udHJvbGxpbmcgdGVzdCBwcm9jZXNzDQp3aXRoIHRoaXM/
KS4gIERvIHdlIHJlYWxseSBuZWVkIHRvIGV4cG9zZSB0aGlzIHRvIHVzZXJzcGFjZT8gDQoNCg0K
VEJIIEkgZmVlbCB0aGF0IGFub3RoZXIgYXBwcm9hY2ggbGlrZSBiZWxvdyBpcyBtb3JlIGRlc2ly
YWJsZToNCg0KICAtIGRlZmluZSBhIG5ldyBmbGFnIGluICJlbnVtIG1mX2ZsYWdzIiAoZm9yIGV4
YW1wbGUgbmFtZWQgTUZfU1dfU0lNVUxBVEVEKSwNCiAgLSBzZXQgdGhlIGZsYWcgd2hlbiBjYWxs
aW5nIG1lbW9yeV9mYWlsdXJlKCkgZnJvbSB0aGUgdGhyZWUgY2FsbGVycw0KICAgIG1lbnRpb25l
ZCBhYm92ZSwNCiAgLSBkZWZpbmUgYSBnbG9iYWwgdmFyaWFibGUgKHR5cGVkIGJvb2wpIGluIG1t
L21lbW9yeV9mYWlsdXJlLmNfdG8gc2hvdyB0aGF0DQogICAgdGhlIHN5c3RlbSBoYXMgZXhwZXJp
ZW5jZWQgYSByZWFsIGhhcmR3YXJlIG1lbW9yeSBlcnJvciBldmVudHMuDQogIC0gb25jZSBtZW1v
cnlfZmFpbHVyZSgpIGlzIGNhbGxlZCB3aXRob3V0IE1GX1NXX1NJTVVMQVRFRCwgdGhlIG5ldyBn
bG9iYWwNCiAgICBib29sIHZhcmlhYmxlIGlzIHNldCwgYW5kIGFmdGVyd2FyZCB1bnBvaXNvbl9t
ZW1vcnkgYWx3YXlzIGZhaWxzIHdpdGgNCiAgICAtRU9QTk9UU1VQUC4NCg0KVGhhbmtzLA0KTmFv
eWEgSG9yaWd1Y2hp
