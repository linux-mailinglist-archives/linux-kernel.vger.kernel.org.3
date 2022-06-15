Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBAB54C64F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348558AbiFOKek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348535AbiFOKeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:34:20 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2071.outbound.protection.outlook.com [40.107.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF42550459
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGDBUYJYzhXbeRjmB1e/zQIv/tFR5xvFAvEuRV//Hd+sJNmBFe7R4iOcewdkeGL9qT4M5L1vq05iJoTo8Cev4E8GxXsgg8gsp/uiJAjlyonhDMJ2EjzKB/coAnJe24VEixolBT5DMJaNZnAan9vS9Nm1mvEB9YK+abdCPRRTaH9mXngqhlHPhWX/xWZR5D/gVl6sb57mkp3IziAvYILVUbin5MrkWhef3p4c2/t31UJ9E+n8vGKaigsS/0md9EVi7iiRhuGcqudE2oBbrsrFx81ErdzU5Gv6/ZZu4IOVHwZ1EyRQQxiDU35rC+ST9bHWBacCqwMEk6yYJZh5Ipko0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRCpdvKlMQIyl83B12xK9itJNktUDNzY6THrohHiOQU=;
 b=IBFmaym1C5d1wmqARFsfSzcOqJbTae7iGHGnjJw/qhtn5NBq1YKJn63xW12YAlWdobdX0ytue3U0uIOPHTjWC4+sqNyXFFBJNqpCrRnpjGWXFVpK6GRq8Ws+ClfX0RwwgTtr2RwCyQAEfI26WHiwxxOzsegEkRHcXcQLB1GC6yumGlSSn3lEMfJ/KOaKX3f1u/iHEbardmU+FH8BUbhugWYvBkzDNtCQYV7JQwNXzSrC8DoYZbZiaAJmNwK3gsca+hEbSIp27QxjeXd0WyuOora/TOVIQce7PXxCYpKbCBaZVwPTHXKIA6X5yiLWVPQwI38cVHNrbhJUr0KW3rXQrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRCpdvKlMQIyl83B12xK9itJNktUDNzY6THrohHiOQU=;
 b=Tl185Kw5/QT5r7SniTp2EOf6PdDQfRlsBsXuC3s3joBP66n1izkhWY5fBri83gaiXl2SdegNgpzbNBsWWDhOyfKqjQywFnYPSlEP3cdznJrSYe5SpH/a2NbiDADtiTlvkx9Ug6ngVcF60+wyNY9EXOi5KIHsYkUjwvmW+BYKikU=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB8456.jpnprd01.prod.outlook.com (2603:1096:400:155::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Wed, 15 Jun
 2022 10:34:07 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::b00f:b11:37c6:29d0]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::b00f:b11:37c6:29d0%4]) with mapi id 15.20.5332.023; Wed, 15 Jun 2022
 10:34:07 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v6 1/1] mm/memory-failure: disable unpoison once hw error
 happens
Thread-Topic: [PATCH v6 1/1] mm/memory-failure: disable unpoison once hw error
 happens
Thread-Index: AQHYgJuBamhWlkQfpkaKBNnobMwn9K1QRakA
Date:   Wed, 15 Jun 2022 10:34:06 +0000
Message-ID: <20220615103406.GA1669251@hori.linux.bs1.fc.nec.co.jp>
References: <20220615093209.259374-1-pizhenwei@bytedance.com>
 <20220615093209.259374-2-pizhenwei@bytedance.com>
In-Reply-To: <20220615093209.259374-2-pizhenwei@bytedance.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a85f0bd-d02f-43bb-eb83-08da4eba9364
x-ms-traffictypediagnostic: TYCPR01MB8456:EE_
x-microsoft-antispam-prvs: <TYCPR01MB8456C16577C91A68B5D227BAE7AD9@TYCPR01MB8456.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SjqkpPo+B0JmICpeQ13RhPDgez8J2FMazTsYbCm6VrTaqooMYQGQKfSDNZM8AqT0Nr+1gYNOSIz8ONFj93DINu7kWsaDpkhQ6kfddi4rBjYPJ6m/ugi+NEAhrWGHXEJKM46zugAV1I9X5ClYBdY2sUhgAx8ICMaEtSg1dAUys7GzdpDk6Y4XchmcIc1DV9TeHyWXH1XZp0atuqElFntQ+uTJYB23alTFCKKbqDtUzM4nOZR5v1PYsTWQGZdy+bnJWhNM0DaYURMZZ2cb+eAAU82bxPFeHiBe54Yw/wbLFbkRkyxXSbX36l87zjtqEaPLGfLyc7jnTwEGjeRr2Nw35B85bCdgm5Zbky9yWg7DoRufb8qy5LthGW/6/4TfxaYXdnfdBBsC+ZfDNtZc8KI9JlFgRHpo9bmbSYXIDAEGKVD1Sr0SxtzraUMm881npNqoHaNSNxj4e7pYkBfCjR+8MTR6PeX5LFkt7wm2xzSVSRu47f5UFjn/y5VGuAuR+6rwIwKRlaEX7KYb8S0Oxl3og9SPSQ62Bo6r4LJuL3Xu37LF4t+i1dW37St0+Kn2rMje0pYqiwW+OFR0neB8IQ8v8xgocm8A8wxE6XAiuVuX7cmLzEwgCjdAoJX4RxPuHK5qJPkZJd3Y+cWj3pj5euUY6ao+QOHht+wV4zTRBSthAqaISzJYT1jWDWhSJ/4Mxg4G/pra1jNSnSKiaeT8nadBYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38070700005)(85182001)(76116006)(26005)(33656002)(2906002)(86362001)(316002)(66476007)(66446008)(83380400001)(64756008)(6512007)(9686003)(82960400001)(71200400001)(66946007)(6916009)(66556008)(8676002)(4326008)(54906003)(6486002)(38100700002)(122000001)(8936002)(508600001)(186003)(5660300002)(6506007)(55236004)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFBhb1FROGdMcjJRSzV2anhWcmV2RlMwaXNKNVVYN3VJTGEwV1paTjBDMUIr?=
 =?utf-8?B?RmZDTVoyelNVdlhKYTR0cXJOa080anBvTUt0eDJnbjVIKy9qQkY1L08xWjJI?=
 =?utf-8?B?V3JEeVoySTNKdk1EYzRiYXpsUVBUZElZZkRWbyttRHRFM2xhNkJaNllmdFdJ?=
 =?utf-8?B?VnNyREtYa0I3anhHMTQ3cG02UmdmU3ZlVkVpMWlZZTJLeUt4aXJFSTRkVWJD?=
 =?utf-8?B?RFJyWkhqMjZRTXpLWVM0MXVodTZqTDhnOWtaMTZ1RlZkZjJwYUJHMnFDNGJR?=
 =?utf-8?B?K3o0bjFJTVdSWFZqVHFtcDJQV1ZOeEpoUVNSSE9YMVFJYldYTkZTZXhKNXU1?=
 =?utf-8?B?dU5SZmRkL3Z5T2xNNkt2UkFVZ2M5WmVhQVlVWWtERE1SWWlpMXg3QlFiVDJh?=
 =?utf-8?B?TmtDdDlDemRTVGJIMmV3akI4M1lVcW9xNXJsbmllTjFWTGR0R2ZJdWdmckcz?=
 =?utf-8?B?SW12NmYxZm84VWlCUXZHd2U4SHkvZWJvWGtyUVdUeGtOaXdseE1TSk92YktJ?=
 =?utf-8?B?dzNEZVVFZjN4bzF3dEpBN2hneXdlVkxXdkNkMCt4Y1RWcWh0MExoQXNwUWhQ?=
 =?utf-8?B?NnNMMzJDUmV3YjFmam5HaFBxOWt1YXprOWJwVXcrWVRIeEhuOFBEWURJZTBN?=
 =?utf-8?B?V242RncwYVI3cVlQUWhyQzJqVjV4dFo3MllEN3RCOVZ2UjNSR3VPWThCN0xH?=
 =?utf-8?B?MkhjSzErMG5Bck9tWmdNZ0N5SVFkclNvS2JRSDI1WkNhU0dOaHdvM2grdWh5?=
 =?utf-8?B?QTVZVWRLb1JVSlh6RHRSMkJXRmgzUU9aTXFUV0hvUVNKMUVUaVpYNWdEQWFJ?=
 =?utf-8?B?Rzh5K0V1VlJTYzJtQTg0cWlwUHg0UUJkT2NZdlFHMHVnWnhxSnFsUW1lbVg3?=
 =?utf-8?B?ZzNDTnNzRG1KU2xjZlNGZEhNMzdtbms4UjJjRE5MTnkrb2NseHNYcDlvRWRr?=
 =?utf-8?B?aW96SmJwMGtrdHVmRWFzd2pRTWRrRk1Bb1Y1YUU1SCttbVdkeXdrbGUwZzdC?=
 =?utf-8?B?RHVFTnhKMFM3ZDgzYW1mT1FNckl3cTNPd201cUR0NHFPc28zaUp2YjZXQTBa?=
 =?utf-8?B?SHZraWJWM3FFQ0NpWVVUUS83NXhVM09Xc0ZRV2Y3U1Z6VU4yalpSOWhtb29y?=
 =?utf-8?B?V085bE0wTlJMT241VVdSTFVQWlo0VmYrUWsrK0dWSXk0VzRmV3FGZ0dnbnVK?=
 =?utf-8?B?aHBzQXJJQnpjTkZEdEVMcTkyRk1wdVdJSkhZcFRlV1Erd1Nibi9ZMU9KcDNM?=
 =?utf-8?B?bXFOM1FVSGJZUU5tRWQxUWRhY1V0YUFrZUhVWXJaeXF2TGo2ZHpHblVMSVMx?=
 =?utf-8?B?T0RHRE9UK0JBS0ZmSmFOQS8rMGRyeW15b2dYWklzbjR5VVZ6K3lHam9aS2JT?=
 =?utf-8?B?aEFJazNHWVBBQ1RPbklUeWtyeVRFcGdXVVhJYlFRYkhBZitJVmZEWkdJa2RU?=
 =?utf-8?B?MS9IKzRjSzd5VjlMOWdHcXJabEI2Q1l3enpPL21HbEczZjYxU3N1SFFWcEhK?=
 =?utf-8?B?bXFkV1RSUEhDV0YxdGE4YS9QM2N3Mm1Ud2djVm45UWNDMEN0Q0JjSTR4YnFM?=
 =?utf-8?B?YjliZTBnQWk0dXpveFdJdmJtaTNrY21YOHNqWHhyRFR4TnJ0VjI0SjJ1Tmtq?=
 =?utf-8?B?NTRzRDd3NkkyUzVQUENlUmlKYVEyaUhVQ1h3WGdiTUVaVytocnJRRkxEbkhN?=
 =?utf-8?B?S1U2ZTFQUk5pbmp5Nnd3SVd2dkNPOExDMWVNUTVDTURiTU9nZGtrTGNmYU5I?=
 =?utf-8?B?SzNDR1Z1WFdqSWR5R3p0MmJwd1hBcUNjbVNIVC83N1dPY0x4SEpvQnFEemsr?=
 =?utf-8?B?VS9YUEpqWHM0QnA0eXBobjlqblB1bU5RUEN2TDJJa3RXZ21JS3FRS0x0REhI?=
 =?utf-8?B?NFg3bjhQTkFlaTg5UnZ0K0xzbVBRL0QyRWRnRjBJNG1Sa2pEOXNEL3BpcFFI?=
 =?utf-8?B?dy9vUmdBbGFRK1ltTFoweGM2R3h2V0dUTXFJM1lLaSsyTkFnZ09Bbi9hNW1G?=
 =?utf-8?B?VkovNWxoLzdQeWp5djduR21pdzJuZzV1d2sxemwva0wyVWNpNTZIai9GcWpK?=
 =?utf-8?B?WlU2V0FVTkt4K2o3Njd3TlBSWXoyU3FxMGlDczU0WEJIYmdqOFhTTEszb0c0?=
 =?utf-8?B?dWo0MnJic1ZFdWh0RTFGNXpoQlpyU0tmSDEyaENHOExCL2tZT0F1ZTdHd01R?=
 =?utf-8?B?TzRqcnlUQmJpbzkvOHVLS0dYRDM1enFMM3dMMkp6cmVaR0I2RmtOc1o1cGtw?=
 =?utf-8?B?aEN3UG12aytHSUVBQmVsZ05XZmo4TURBSEJtZkpIRjFseTNYNzd5YnpDRzlx?=
 =?utf-8?B?RW96blJ3RVJ6VVErTzU5czJxNVIyamxvOTZyTTVpclZDQk9HMWMxVkxXNmQ1?=
 =?utf-8?Q?F0HcPo4mXirTqhac=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <008F59070A90EA4FB726BEFB9BC99F3B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a85f0bd-d02f-43bb-eb83-08da4eba9364
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 10:34:06.9782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: haV3QzoLWs7mwmXq4XQSKk8ps2BmbtAVu8th4HtuD8So03ksTRhuy+wEyVkk+XIPZp7VRNLzkojiG2zXNJ5IXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8456
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdW4gMTUsIDIwMjIgYXQgMDU6MzI6MDlQTSArMDgwMCwgemhlbndlaSBwaSB3cm90
ZToNCj4gQ3VycmVudGx5IHVucG9pc29uX21lbW9yeSh1bnNpZ25lZCBsb25nIHBmbikgaXMgZGVz
aWduZWQgZm9yIHNvZnQNCj4gcG9pc29uKGh3cG9pc29uLWluamVjdCkgb25seS4gU2luY2UgMTdm
YWUxMjk0YWQ5ZCwgdGhlIEtQVEUgZ2V0cw0KPiBjbGVhcmVkIG9uIGEgeDg2IHBsYXRmb3JtIG9u
Y2UgaGFyZHdhcmUgbWVtb3J5IGNvcnJ1cHRzLg0KPiANCj4gVW5wb2lzb25pbmcgYSBoYXJkd2Fy
ZSBjb3JydXB0ZWQgcGFnZSBwdXRzIHBhZ2UgYmFjayBidWRkeSBvbmx5LA0KPiB0aGUga2VybmVs
IGhhcyBhIGNoYW5jZSB0byBhY2Nlc3MgdGhlIHBhZ2Ugd2l0aCAqTk9UIFBSRVNFTlQqIEtQVEUu
DQo+IFRoaXMgbGVhZHMgQlVHIGR1cmluZyBhY2Nlc3Npbmcgb24gdGhlIGNvcnJ1cHRlZCBLUFRF
Lg0KPiANCj4gU3VnZ2VzdGVkIGJ5IERhdmlkJk5hb3lhLCBkaXNhYmxlIHVucG9pc29uIG1lY2hh
bmlzbSB3aGVuIGEgcmVhbCBIVyBlcnJvcg0KPiBoYXBwZW5zIHRvIGF2b2lkIEJVRyBsaWtlIHRo
aXM6DQo+IA0KPiAgVW5wb2lzb246IFNvZnR3YXJlLXVucG9pc29uZWQgcGFnZSAweDYxMjM0DQo+
ICBCVUc6IHVuYWJsZSB0byBoYW5kbGUgcGFnZSBmYXVsdCBmb3IgYWRkcmVzczogZmZmZjg4ODA2
MTIzNDAwMA0KPiAgI1BGOiBzdXBlcnZpc29yIHdyaXRlIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQ0K
PiAgI1BGOiBlcnJvcl9jb2RlKDB4MDAwMikgLSBub3QtcHJlc2VudCBwYWdlDQo+ICBQR0QgMmMw
MTA2NyBQNEQgMmMwMTA2NyBQVUQgMTA3MjY3MDYzIFBNRCAxMDM4MmIwNjMgUFRFIDgwMGZmZmZm
OWVkY2IwNjINCj4gIE9vcHM6IDAwMDIgWyMxXSBQUkVFTVBUIFNNUCBOT1BUSQ0KPiAgQ1BVOiA0
IFBJRDogMjY1NTEgQ29tbTogc3RyZXNzIEtkdW1wOiBsb2FkZWQgVGFpbnRlZDogRyAgIE0gICAg
ICAgT0UgICAgIDUuMTguMC5ibS4xLWFtZDY0ICM3DQo+ICBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0
YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSAuLi4NCj4gIFJJUDogMDAxMDpjbGVhcl9w
YWdlX2VybXMrMHg3LzB4MTANCj4gIENvZGU6IC4uLg0KPiAgUlNQOiAwMDAwOmZmZmZjOTAwMDEx
MDdiYzggRUZMQUdTOiAwMDAxMDI0Ng0KPiAgUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAw
MDAwMDAwMDAwMDkwMSBSQ1g6IDAwMDAwMDAwMDAwMDEwMDANCj4gIFJEWDogZmZmZmVhMDAwMTg0
OGQwMCBSU0k6IGZmZmZlYTAwMDE4NDhkNDAgUkRJOiBmZmZmODg4MDYxMjM0MDAwDQo+ICBSQlA6
IGZmZmZlYTAwMDE4NDhkMDAgUjA4OiAwMDAwMDAwMDAwMDAwOTAxIFIwOTogMDAwMDAwMDAwMDAw
MTI3Ng0KPiAgUjEwOiAwMDAwMDAwMDAwMDAwMDAzIFIxMTogMDAwMDAwMDAwMDAwMDAwMCBSMTI6
IDAwMDAwMDAwMDAwMDAwMDENCj4gIFIxMzogMDAwMDAwMDAwMDAwMDAwMCBSMTQ6IDAwMDAwMDAw
MDAxNDBkY2EgUjE1OiAwMDAwMDAwMDAwMDAwMDAxDQo+ICBGUzogIDAwMDA3ZmQ4YjIzMzM3NDAo
MDAwMCkgR1M6ZmZmZjg4ODEzZmQwMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+
ICBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+ICBD
UjI6IGZmZmY4ODgwNjEyMzQwMDAgQ1IzOiAwMDAwMDAwMTAyM2QyMDA1IENSNDogMDAwMDAwMDAw
MDc3MGVlMA0KPiAgRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBE
UjI6IDAwMDAwMDAwMDAwMDAwMDANCj4gIERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAw
MDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwDQo+ICBQS1JVOiA1NTU1NTU1NA0KPiAg
Q2FsbCBUcmFjZToNCj4gICA8VEFTSz4NCj4gICBwcmVwX25ld19wYWdlKzB4MTUxLzB4MTcwDQo+
ICAgZ2V0X3BhZ2VfZnJvbV9mcmVlbGlzdCsweGNhMC8weGUyMA0KPiAgID8gc3lzdmVjX2FwaWNf
dGltZXJfaW50ZXJydXB0KzB4YWIvMHhjMA0KPiAgID8gYXNtX3N5c3ZlY19hcGljX3RpbWVyX2lu
dGVycnVwdCsweDFiLzB4MjANCj4gICBfX2FsbG9jX3BhZ2VzKzB4MTdlLzB4MzQwDQo+ICAgX19m
b2xpb19hbGxvYysweDE3LzB4NDANCj4gICB2bWFfYWxsb2NfZm9saW8rMHg4NC8weDI4MA0KPiAg
IF9faGFuZGxlX21tX2ZhdWx0KzB4OGQ0LzB4ZWIwDQo+ICAgaGFuZGxlX21tX2ZhdWx0KzB4ZDUv
MHgyYTANCj4gICBkb191c2VyX2FkZHJfZmF1bHQrMHgxZDAvMHg2ODANCj4gICA/IGt2bV9yZWFk
X2FuZF9yZXNldF9hcGZfZmxhZ3MrMHgzYi8weDUwDQo+ICAgZXhjX3BhZ2VfZmF1bHQrMHg3OC8w
eDE3MA0KPiAgIGFzbV9leGNfcGFnZV9mYXVsdCsweDI3LzB4MzANCj4gDQo+IEZpeGVzOiA4NDdj
ZTQwMWRmMzkyICgiSFdQT0lTT046IEFkZCB1bnBvaXNvbmluZyBzdXBwb3J0IikNCj4gRml4ZXM6
IDE3ZmFlMTI5NGFkOWQgKCJ4ODYve21jZSxtbX06IFVubWFwIHRoZSBlbnRpcmUgcGFnZSBpZiB0
aGUgd2hvbGUgcGFnZSBpcyBhZmZlY3RlZCBhbmQgcG9pc29uZWQiKQ0KPiBDYzogTmFveWEgSG9y
aWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gQ2M6IERhdmlkIEhpbGRlbmJyYW5k
IDxkYXZpZEByZWRoYXQuY29tPg0KPiBDYzogT3NjYXIgU2FsdmFkb3IgPG9zYWx2YWRvckBzdXNl
LmRlPg0KPiBDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zz4NCj4gQWNrZWQtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiB6aGVud2VpIHBpIDxwaXpoZW53ZWlAYnl0ZWRhbmNlLmNvbT4NCg0KVGhh
bmsgeW91IHZlcnkgbXVjaC4NCg0KQWNrZWQtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9y
aWd1Y2hpQG5lYy5jb20+
