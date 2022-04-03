Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592954F0D05
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 01:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376700AbiDCXpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 19:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242521AbiDCXpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 19:45:01 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2045.outbound.protection.outlook.com [40.107.113.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182C92E6AE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 16:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuRwkJUiDHFJcSAmbw/fXJ+Z9GWjM27xgxufD+uzrPJf8c+0zQc7J20OA45RZxyQvde3vnyGgBgb6YqZ2WB4XRrK9twuIO9Z99ZbLpIrYrxmkvOughi/+prVZ4DxcyYVQ627mHpbSU/YnGcJM4uMzHstIlaToDRZ2fuFrbgIIL4jDgWwNjJg2F2TZCVgyAqJMwdS8F71caCaWJ3gVvHCln+m3ciISdO/ccqwdiDsj13uD7GiDW/BJsR4s/rq/wpf5A4/66auf9kqtQKZQqCj6ihhDnccyPjIbIngc2WN5dVxzouIN1Ik9pQcrJsdoK7wDr6gfhOI/bnXZiuE6bcMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S09NEVAjLBgHWK+vuhyU1eO63wmdjBGuliaCFaLmozw=;
 b=jR51bShs99kdboLdjPBBaxGTpSJ3HaqkL4xo7Xyb6Q09bIYHjyXfImWFx2fLP4YTV3/VjL62RroQ5ruR2le106nzHi6figLuo2X6lLTLRWwicFutLC73/r5TxCg9n1UCKh8LQ0RAsnkQBcjrjIoiBVxd5A3WCfuPVOhpcWbm/Tf37E23CSW4/Z5MnxKGI4Wi33LW0GpC2ebn6h5wkeOboQ3eO7fWpvayn6vAjmat5bU2izsNPWpw17gVjW0ywaCYqRLgxKjolu9A5RDw4DOFT9vSs7tQjbCVaPRgTrRfrpXH87f5VJHDalXi07g7k3CBGKVX9irUtvFzGuRtwNEdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S09NEVAjLBgHWK+vuhyU1eO63wmdjBGuliaCFaLmozw=;
 b=Xa1IBLLe8TLIiI4ytoUDrpkKPotulFH9NWJO4orRcoFZcKLJCPgyI81j6sR/N0KsyxASzy3k0WwCfyn6WuqQpKiT971fHGPfwrNr4VMSVEDzWd5HKXw01gEaP2guJBEslkHu++aJZ4R9CNSaFiq7oVgOxF/vZoeihHAwppp2DRI=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB7481.jpnprd01.prod.outlook.com (2603:1096:400:f4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Sun, 3 Apr
 2022 23:42:56 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232%6]) with mapi id 15.20.5123.031; Sun, 3 Apr 2022
 23:42:56 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Liu Shixin <liushixin2@huawei.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question about hwpoison handling of 1GB hugepage
Thread-Topic: Question about hwpoison handling of 1GB hugepage
Thread-Index: AQHYRO39spkM6Er2D0SYmGhvNd4geaze3zIA
Date:   Sun, 3 Apr 2022 23:42:55 +0000
Message-ID: <20220403234250.GA2217943@hori.linux.bs1.fc.nec.co.jp>
References: <0af88a11-4dfe-9a4e-7b94-08f12caafcf3@huawei.com>
In-Reply-To: <0af88a11-4dfe-9a4e-7b94-08f12caafcf3@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 445b3c5c-0e7c-481f-eb74-08da15cbad97
x-ms-traffictypediagnostic: TYCPR01MB7481:EE_
x-microsoft-antispam-prvs: <TYCPR01MB74817FD1E5EC3B0D0FFB74F9E7E29@TYCPR01MB7481.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a70qzDWqXkjEmW1XBpGeoOtUocofK/xda78OxgJLzk4zQiR+vQgjtoecplftxmYoXfpezFiC9hQkVu3yzN4QItlkc7cmiF4gt5mL7vjTx8ee97UwDm50lgl4kloCOFjEbGcyMt0UlQ+LhtRheCI8hA6KIBH7aP4HSo7Rz2eJZhB0c4A1M8DGtrv2QNRv9Ld0DBAngXQdcgY6H8vM0I/tjgoxrm5uzL8bAWo6SOGjTWqGyFduVtZazZBNJoRurfJFnkRaO5BHWI7piV31LYhPcRk08pIDP7FfOdGtWwwegG36g6rFkcMpi4tvLqMZF57CeKb89PdrQTTZ7j3saJNcd8VeBXZuMqel32Ppb9KsYPwIAzVQElVr1anmkdCXu8kjhMIeZ3PzN767q1Xq6C9oiMH38rzyp14ndV4BywU6/73pbcRROMDgGBwo4sJYM3ElhIpafrvKKfDquV2MRJAWOfLGcBWV/hw0XIxVA305Z08iCBWZgqnZtMIv96yceFtAeOLGPekf+dcz1PNFsUyCAQf+jC6mIvZFjqd4mMXdu34JGZ51mhFjZ9zU5HwfsvMIBVJqjIALRQk7X0uwVM2PedzVXfYDaXsaNDqF4Mhu5K8zSoRMzIlJjsTPd+1diMvw+aXKg2L+9z2M5DkxdC89vN9qpSoz0vlsQ8KyBeCpQy7Y198t2FevjeOcaliWv4IvXxMeb6Y5J2S97MhG+sPpUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(316002)(33656002)(54906003)(6916009)(86362001)(38100700002)(66556008)(66476007)(66446008)(64756008)(66946007)(122000001)(8676002)(4326008)(82960400001)(71200400001)(6486002)(76116006)(508600001)(85182001)(1076003)(55236004)(186003)(6506007)(2906002)(83380400001)(9686003)(6512007)(8936002)(26005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXdXd3M0ODBWa0NwQjQ5OFF2MFJWMG9FUVhtZnVrRUU4SjRFUElDSnNEcXhn?=
 =?utf-8?B?QVdCQnViSmwrbWdvUHk0Q1JWa0l4ZERlT0VhdkUxdTFCT0FNNm9kYzZhekw3?=
 =?utf-8?B?QmNuMy92cGxwb2JodEZQbFdmRjEzYzFZWGpuZTdnVjFKeFhCdXRWYTFBQkwr?=
 =?utf-8?B?bmJqdEUwZ2V2U293OG5tMFFDd003WlhKckJKNkdLTVRNMlc4V1JJWjN3S2Z6?=
 =?utf-8?B?dUg4QWRDR2VRT1JOd0p1TDk2U2hGNk4wcDVsdU5ZVUEvTk5pZXRFWFYwbEln?=
 =?utf-8?B?Q2JuNHdaU2liUjNIQUFaOXNPVURxRmFTVURrNFZ6SEtBcUFTUUFDSy9yUUNQ?=
 =?utf-8?B?NkRqeFkyZTdFcjh5Wm5GWFdqdGFRNk93L0ZicVpsWnpSdDNIaVd3MlFvUTFO?=
 =?utf-8?B?ZjVuL3AzdkI4QnI4MmorekM5VThPVHBpL1A5R2JRL1RCSkl2YytsRzFoRWJ2?=
 =?utf-8?B?ejNIZ3liTjdMZmJkZFZrWjNPbGF6dHlxcWlrTEYvWnQ3MUkzQ3IxRCtnb1Ju?=
 =?utf-8?B?YU02L1RkdmRiaCs5YlhWR0sxSlhEMlhRc0EwcHVYbTFEYWczUEF2bkFVUUh4?=
 =?utf-8?B?UDl1Ym8xV2ttUDIwZnFGaG44V3VvdWdnNmt3UWhrTXp1eFI4RExPZGErZ2hp?=
 =?utf-8?B?bWxmYmo0MXh2YkpobmZvZDRxYTRxSWE5eSt4cmZXMTQwbnE1QVNscmRUVlNI?=
 =?utf-8?B?UFFPOVNpVkdPdUlNZS9ESTdSeWd6aGFVTDRqak4wcG5ZQkl4RERkTHpqemdV?=
 =?utf-8?B?VzBRR1dvZDdhNy9HVUxPaHNxTVp4ai9oV0tWSWV0dE93Q2FpdUJ3eG54WHVx?=
 =?utf-8?B?b2YzOHZEQmxJRmN0RTRnZ3ZoUmJSd25GTTBJR3N3VTJuM3YrQUtpQWxZcURY?=
 =?utf-8?B?VXp3K0RyMzNBMXhXblhOeTZwVFgvVlhKVStmTHhnSTQyWlRPaTkwVWNoMUU4?=
 =?utf-8?B?QXZiYjROTjVNRkFKM2NIanVzTS9jemlpem5VeXMrMWNzU2l0VXI2ME5hY2tD?=
 =?utf-8?B?NTlZLzZtZm5jaEFDanZtRWlFSDV5YnYwM0QyNFhoTWEwdlorMTJVdkhHNjc1?=
 =?utf-8?B?T0U3VS9xb3hNMzJpMGhUWGR2bFZNMnNVb3lESVBaY2xyRGtPczdkbUdwNlhQ?=
 =?utf-8?B?V29BRE5qNnFMUDFiRUtQbTFMaEhwcW8vZkFnc1MxUkRPc2lhQlVTR1U0ZmtD?=
 =?utf-8?B?eGpiU3BGSzVrcUplVy9QWEJNZHQvQVY4czIwSFd0VndWbnM4cVNxK3VQbTVu?=
 =?utf-8?B?RjlRZEo3ZWZVZWNYTXFFdFcyYW5iaFExSmJuOHN2NzE2LzFMSnhYU3lBblRs?=
 =?utf-8?B?cVJ2NGh6RVlBQUwwZ0pmR00wckdIRTdJTHo1ZHUyTVFLZnpOWWxvcUQ3eEts?=
 =?utf-8?B?YWhhc1dHRDhlTCtjV24wMlU4Ync0Z2NWZVpJY0tsVVIvalkwQlk2VWFkNjA0?=
 =?utf-8?B?aWdBNndsQys4a0lHMkhKbm1wbnBtc01PbUowSEE0MUFwQkN6Mi9RQW1oeFpi?=
 =?utf-8?B?UHpVMGF3aGFPMWhON0xaQjVCbGJRWmlsK0s3SHRHT1RmN09XeVdFWi9JMUNT?=
 =?utf-8?B?algxNFE3OHBPMDRFZ0JYbkpjRmNZdFA0Z2NJbFhOZHdRK2YvWXNQcmxnOUkw?=
 =?utf-8?B?T1pLeW4rck1vTWhVbTNFWUYyME9PemNVL3kvMjVYcmY5MnkzZ3RvRWdpYXZK?=
 =?utf-8?B?b3FLV2xIU1NkWE9Ob1lnaWFpdnE0YnlwUFVTc0diVysxVDZKb0VXRDlja3Bs?=
 =?utf-8?B?VXlnclRhZXQrUWs0SEswQ1RqVlhVaXlseDZHakRaYlNOc0VRZzVwQ0VNZXlG?=
 =?utf-8?B?NjhaMXkwbzBXWjA4WlYvVEU0a1VWUllJeFh3M1NvemRScHhRaGdnZkwwUlpC?=
 =?utf-8?B?TWNoUUc0alZ2S2RQS2NVSEpLOGFVNjVZenpPTE5adkMyYTE0Um5BTkYrNkhH?=
 =?utf-8?B?aUZoQ215ekt5UElXNU8yMG5iYzZOV1V1YS9hWk9PaXB6eTdLVE5meCtGeG4x?=
 =?utf-8?B?UllmZmlGVVdtR3lGU2x4TFoxQ2hSVU5ka1A1VlBKeDNVS0gzZnpFOXFZbGZR?=
 =?utf-8?B?YUdnYU9iZWZxYVlRZW5qWHphS0l4S1hvR0lIaW5KYi80SThwcjFlZEtZZGJv?=
 =?utf-8?B?V09UZlovYWlPN0pBN0kzWFYwcUltK0duTWk4RkxhM1ZuanpFWjNuUnd6blhX?=
 =?utf-8?B?aGd2eGIzbGZXNjdsRklETEozTXFHdXN6bWpEaWVHTEdZVUtjZ0RzSW9RcFZv?=
 =?utf-8?B?RFdXR3dsVnFYWDdUR0ZFOUliSTkxcHJ6NWdUbHg1MXp5S2dqUXdEUTZIL09J?=
 =?utf-8?B?UXNJSkJvZ1lvNUUwZ2E5V05DenBZcGhZZTY3TmhPTkJCdENmREt0VGphMFhp?=
 =?utf-8?Q?WgINIS/cA0Qcdq10=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C71435E2889FA4A8D9972A8FEFE4E28@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445b3c5c-0e7c-481f-eb74-08da15cbad97
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2022 23:42:55.8181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FC11OQA8Yl5npIgNAow9P9nKtjr9RsETSv4bdQATdwP85s8llhzEzb2B6cjHSbABhB7z83gMhnAaU/D+GXamtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7481
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXIgMzEsIDIwMjIgYXQgMDY6NTY6MjVQTSArMDgwMCwgTGl1IFNoaXhpbiB3cm90
ZToNCj4gSGksDQo+IA0KPiBSZWNlbnRseSwgSSBmb3VuZCBhIHByb2JsZW0gd2l0aCBod3BvaXNv
biAxR0IgaHVnZXBhZ2UuDQo+IEkgY3JlYXRlZCBhIHByb2Nlc3MgYW5kIG1hcHBlZCAxR0IgaHVn
ZXBhZ2UuIFRoaXMgcHJvY2VzcyB3aWxsIHRoZW4gZm9yayBhDQo+IGNoaWxkIHByb2Nlc3MgYW5k
IHdyaXRlL3JlYWQgdGhpcyAxR0IgaHVnZXBhZ2UuIFRoZW4gSSBpbmplY3QgaHdwb2lzb24gaW50
bw0KPiB0aGlzIDFHQiBodWdlcGFnZS4gVGhlIGNoaWxkIHByb2Nlc3MgdHJpZ2dlcnMgdGhlIG1l
bW9yeSBmYWlsdXJlIGFuZCBpcw0KPiBiZWluZyBraWxsZWQgYXMgZXhwZWN0ZWQuIEFmdGVyIHRo
aXMsIHRoZSBwYXJlbnQgcHJvY2VzcyB3aWxsIHRyeSB0byBmb3JrIGENCj4gbmV3IGNoaWxkIHBy
b2Nlc3MgYW5kIGRvIHRoZSBzYW1lIHRoaW5nLiBJdCBpcyBraWxsZWQgYWdhaW4gYW5kIGZpbmFs
bHkgaXQNCj4gZ29lcyBpbnRvIHN1Y2ggYW4gaW5maW5pdGUgbG9vcC4gSSBmb3VuZCB0aGlzIHdh
cyBjYXVzZWQgYnkNCj4gY29tbWl0IDMxMjg2YTg0ODRhOCAoIm1tOiBod3BvaXNvbjogZGlzYWJs
ZSBtZW1vcnkgZXJyb3IgaGFuZGxpbmcgb24gMUdCIGh1Z2VwYWdlIikNCg0KSGVsbG8gU2hpeGlu
LA0KDQpJdCdzIGxpdHRsZSB1bmNsZWFyIHRvIG1lIGFib3V0IHdoYXQgYmVoYXZpb3IgeW91IGFy
ZSBleHBlY3RpbmcgYW5kDQp3aGF0IHRoZSBpbmZpbml0ZSBsb29wIHJlcGVhdHMsIGNvdWxkIHlv
dSBleHBsYWluIGxpdHRsZSBtb3JlIGFib3V0IHRoZW0/DQooSSBicmllZmx5IHRyaWVkIHRvIHJl
cHJvZHVjZSBpdCwgYnV0IGRpZG4ndCBtYWtlIGl0Li4uKQ0KDQo+IA0KPiBJdCBsb29rcyBsaWtl
IHRoZXJlIGlzIGEgYnVnIGZvciBod3BvaXNvbiAxR0IgaHVnZXBhZ2Ugc28gSSB0cnkgdG8gcmVw
cm9kdWNlDQo+IHRoZSBidWcgZGVzY3JpYmVkLiBBZnRlciB0cnlpbmcgdG8gcmV2ZXJ0IHRoZSBw
YXRjaCBpbiBhbiBlYXJsaWVyIHZlcnNpb24gb2YNCj4gdGhlIGtlcm5lbCwgSSByZXByb2R1Y2Ug
dGhlIGJ1ZyBkZXNjcmliZWQuIFRoZW4gSSB0cnkgdG8gcmV2ZXJ0IHRoZSBwYXRjaCBpbg0KPiBs
YXRlc3QgdmVyc2lvbiwgYW5kIGZpbmQgdGhlIGJ1ZyBpcyBubyBsb25nZXIgcmVwcm9kdWNlZC4N
Cj4gDQo+IEkgY29tcGFyZSB0aGUgY29kZSBwYXRocyBvZiAxIEdCIGh1Z2VwYWdlIGFuZCAyIE1C
IGh1Z2VwYWdlIGZvciBzZWNvbmQgbWFkdmlzZShNQURWX0hXUE9JU09OKSwNCj4gYW5kIGZpbmQg
dGhhdCB0aGUgcHJvYmxlbSBpcyBjYXVzZWQgYmVjYXVzZSBpbiBndXBfcHVkX3JhbmdlKCksIHB1
ZF9ub25lKCkgYW5kDQo+IHB1ZF9odWdlKCkgYm90aCByZXR1cm4gZmFsc2UgYW5kIHRoZW4gdHJp
Z2dlciB0aGUgYnVnLiBCdXQgaW4gZ3VwX3BtZF9yYW5nZSgpLA0KPiB0aGUgcG1kX25vbmUoKSBp
cyBtb2RpZmllZCB0byBwbWRfcHJlc2VudCgpIHdoaWNoIHdpbGwgbWFrZSBjb2RlIHJldHVybiBk
aXJlY3RseS4NCj4gVGhlIEkgZmluZCB0aGF0IGl0IGlzIGNvbW1pdCAxNTQ5NDUyMGI3NzYgKCJt
bTogZml4IGd1cF9wdWRfcmFuZ2UiKSB3aGljaA0KPiBjYXVzZSBsYXRlc3QgdmVyc2lvbiBub3Qg
cmVwcm9kdWNlZC4gSSBiYWNrcG9ydCBjb21taXQgMTU0OTQ1MjBiNzc2IGluDQo+IGVhcmxpZXIg
dmVyc2lvbiBhbmQgZmluZCB0aGUgYnVnIGlzIG5vIGxvbmdlciByZXByb2R1Y2VkIGVpdGhlci4N
Cg0KVGhhbmsgeW91IGZvciB0aGUgYW5hbHlzaXMuDQpTbyB0aGlzIHBhdGNoIG1pZ2h0IG1ha2Ug
MzEyODZhODQ4NGE4IHVubmVjZXNzYXJ5LCB0aGF0J3MgYSBnb29kIG5ld3MuDQoNCj4gDQo+IFNv
IEknZCBsaWtlIHRvIGNvbnN1bHQgdGhhdCBpcyBpdCB0aGUgdGltZSB0byByZXZlcnQgY29tbWl0
IDMxMjg2YTg0ODRhOD8NCj4gT3IgaWYgd2UgbW9kaWZ5IHB1ZF9odWdlIHRvIGJlIHNpbWlsYXIg
d2l0aCBwbWRfaHVnZSwgaXMgaXQgc3VmZmljaWVudD8NCj4gDQo+IEkgYWxzbyBub3RpY2VkIHRo
ZXJlIGlzIGEgVE9ETyBjb21tZW50IGluIG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGIoKToNCj4gICAg
IC0gY29udmVyc2lvbiBvZiBhIHB1ZCB0aGF0IG1hcHMgYW4gZXJyb3IgaHVnZXRsYiBpbnRvIGh3
cG9pc29uDQo+ICAgICAgIGVudHJ5IHByb3Blcmx5IHdvcmtzLCBhbmQNCj4gICAgIC0gb3RoZXIg
bW0gY29kZSB3YWxraW5nIG92ZXIgcGFnZSB0YWJsZSBpcyBhd2FyZSBvZiBwdWQtYWxpZ25lZA0K
PiAgICAgICBod3BvaXNvbiBlbnRyaWVzLiANCg0KVGhlc2UgYXJlIHNpbXBseSBtaW5pbXVtIHJl
cXVpcmVtZW50cywgYnV0IG1pZ2h0IG5vdCBiZSBzdWZmaWNpZW50Lg0KV2UgbmVlZCB0ZXN0aW5n
ICh3aXRoIHJlbW92aW5nIDMxMjg2YTg0ODRhOCkgdG8gbWFrZSBzdXJlIHRoYXQNCnRoZXJlJ3Mg
bm8gaXNzdWVzIG9uIHNvbWUgY29ybmVyIGNhc2VzLg0KKEkgc3RhcnQgdG8gZXh0ZW5kIGV4aXN0
aW5nIGh1Z2V0bGItcmVsYXRlZCB0ZXN0Y2FzZXMgdG8gMUdCIG9uZXMuKQ0KDQpUaGFua3MsDQpO
YW95YSBIb3JpZ3VjaGkNCg0KPiANCj4gSSdtIG5vdCBzdXJlIHdoZXRoZXIgdGhlIGFib3ZlIGZp
eCBhcmUgc3VmZmljaWVudCwgc28gaXMgdGhlcmUgYW55dGhpbmcgZWxzZSBuZWVkDQo+IHRvIGFu
YWx5c2lzIHRoYXQgSSBoYXZlbid0IGNvbnNpZGVyZWQ/
