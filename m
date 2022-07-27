Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3CE581D94
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 04:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbiG0CYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 22:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240179AbiG0CYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 22:24:15 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2059.outbound.protection.outlook.com [40.107.114.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88E13C8C3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 19:24:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBL+VofTE2rspyVd+5R561GVt/3AIS/CH467g+mLqhgVUiRf3cd/1F32L+W4jZBbVdsFA40Ml4r5TnRODqMOOvh0JXG1QezlymyuG4xKyC+5oZ3qxRFUj9s0stZrPF4ykhsTw7y+0ckVacJd14ROFXhuXSH6zLF0sxo3UIQ/y8Pe3dn/vp+4i8kK43HgwNQeG062VwfG0DKRs7Wr9w+up3ULgZyiNCZJL4vulgaDSB/pKr/INkCQAofDpFiUYE2F8QGKDvzkuer7bBzshye3JBj9pe0+J7KVDzIPxoLweHEjFuvkOkksddI9rTyZGKTZGS4yq2xOpZ4XYCm1k+70IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k51q8fbQSC4hzyT7RQRUuv7MKhAOvuAUhSNVFXtBwM=;
 b=Nw6uHMirLfb1iyEcToQlu+gfOxasG28h+OeI9EFsnH5ixolPmUVYhYjqlRCLxxL5v7CnGP7x89J2H18WM9r42flozeu8gFySA3U8ZwrTj0HIpH2umu14m3rsXMATtsX0Ctj2srlv5H5KhngQJ5C3UsHaVaysOEOQvc0M4b57rvUmVuJFiJyMhHNCq0wi8V7NWvZVQ/RYPnKQHMM9/z55rnI6maBmyCm2Ld/tyxuPoKdbofv9ARKbzyPwvtVa7tgoVJDLxV4dTi8FZRbeBwdoUusrZnFENS3N+uirc2cmPhAGFIZ3BwbGrHgLSAsI/lDMZ8/h4RrYSJkLMwqVLEvkAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k51q8fbQSC4hzyT7RQRUuv7MKhAOvuAUhSNVFXtBwM=;
 b=UwmXIR/BCI3tr5/8MWQWshzLAia0fREOCqToiblX8DoMQPw95ZmgFJwT5+9MvBil2iLLYVtEgiIPJ2pHq+95LIhFxNglGnJRnsnfQY7acPjLtxUZAsZ3MX93bNI9S10tGUM9uJUTxX9AUQig4l6D+xPqZINw/vwigtHT0rfO0Vs=
Received: from OS3PR01MB8586.jpnprd01.prod.outlook.com (2603:1096:604:19d::6)
 by TYAPR01MB2687.jpnprd01.prod.outlook.com (2603:1096:404:82::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Wed, 27 Jul
 2022 02:24:12 +0000
Received: from OS3PR01MB8586.jpnprd01.prod.outlook.com
 ([fe80::576:dca1:ffc6:de00]) by OS3PR01MB8586.jpnprd01.prod.outlook.com
 ([fe80::576:dca1:ffc6:de00%5]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 02:24:12 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memory-failure: convert to pr_fmt()
Thread-Topic: [PATCH] mm: memory-failure: convert to pr_fmt()
Thread-Index: AQHYoMZeP9C9GeMxy0m31905u5N9nK2RajWAgAAQJQCAAAP9AA==
Date:   Wed, 27 Jul 2022 02:24:12 +0000
Message-ID: <20220727022406.GA3350995@hori.linux.bs1.fc.nec.co.jp>
References: <20220726081046.10742-1-wangkefeng.wang@huawei.com>
 <20220727011203.GA3346517@hori.linux.bs1.fc.nec.co.jp>
 <1774d0f6-9607-0111-c940-f0bd2b4f7c75@huawei.com>
In-Reply-To: <1774d0f6-9607-0111-c940-f0bd2b4f7c75@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7399167-ee91-4674-ac5e-08da6f771817
x-ms-traffictypediagnostic: TYAPR01MB2687:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FwMNHpFib9kbo8pm9D73F3+HtAxT2EbaZnyEdTps0ekGWahHaZrdS6C0+6EV175rNQEmzk5kkJglOhLRPgKCUZAdS1WXd7PXVZpJHJB/93Z2q5qUKwZ9UawiQDDcpCddkwbkeeZnPiJmk435TU5qvnqxiBQubQjIBlfs5bioXBSZ7aWjCovaNjIV0Ry/WStQLe7DI6aChZHT2jgqF9lhL7yqk32nMA1Ckp0fpDXDfnibjhkl1+TwM3+LzGGbe/2URfGUJt164heSb7v9Fn2BPBsYvKRRuBZxUkWdhsfu8Hv4iQ7fMxy9peZs+HaKCafAamBQ8/k1seHgz2OjoSoPuZDvvad734W9jLd5QbM8pdiZ0sSRXKJG3ZlyQH+JyEj+C3lxgttB4K0OrZkFFpOfKnI06bCDQdUTf5ra4twlf4GNtebsb+NX131x/lSYinixf6g04cMGnrSH7UIMdDRLyBIKo19quurNjv1OUVO0OMvI1w4dyRSbtab4pTCyXT0KdJDy6iBTPtd+ruVOhIrtoJZctEUQuWehwzSW4d0jSjkMSbMswG96fMQuvKFV0jSHW4VlzncZBgE+4SJqmHhtLY7ML7/lh8SrJB5HQq6jXK0SF6zBO2+/EYbxuzEyVqf73GSGUSyPbnnk/pUqhakIgKmvyjl7FUkDw0xfHQvcT8c85usvX4Bba81rmC25BE0ZOgFA8fbBEK2qShjNa2TeHouAQBT28jw1bQS8T6D/aBumti/tQiPd7H1LJAQWWm3wX/PhmecHteEQFqGb0GJY8yt1FlNGO8Ci1G0tjhZTlS1uujwR1fmfj58/I0R49/Vd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8586.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(71200400001)(55236004)(6512007)(478600001)(53546011)(1076003)(6506007)(8936002)(5660300002)(26005)(186003)(9686003)(6486002)(64756008)(83380400001)(33656002)(316002)(66446008)(2906002)(38100700002)(6916009)(4326008)(122000001)(54906003)(66476007)(82960400001)(8676002)(41300700001)(76116006)(38070700005)(86362001)(85182001)(66946007)(66556008)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajNrdnZJaGtUU3Juazh1QWpzTjdrQjVDVXEvVk16NnBYandQSEI3NmxKS3NV?=
 =?utf-8?B?L0luUmswcWFxb2hMWEhZWlZ4UXB3dGdVNnBoNjNEZXZsTDBQemZza3I2bVNE?=
 =?utf-8?B?dTBPL3ZIL1ZjdkxUU1NOeE9PMWhReUJMTVhIdkgxREI5NWw0eGdaZHc3eGV6?=
 =?utf-8?B?MDlxOWhFbnVMTCsreEwxLzJ2QktNWTNwb3h3eVc5ZlhER2ZTQS95bHJVOUtL?=
 =?utf-8?B?RC9oZ0xIVTh6NE4xbUxJcHJlcGV3RHFYODNrTW11YVo4S2ZsZ01rUklIZUtt?=
 =?utf-8?B?V0o1UG9iMFU3ZkFGWFZxK3hGZ0g1aDltdnlKditqaG1QVk5ERHNneVRZOTls?=
 =?utf-8?B?SUZ4VStsZzB3eThBalJ6UnViNlEva3JRMzR3aXVoWUx2Zng2czNxUGRBSURY?=
 =?utf-8?B?K0tQdnpMeXc0RFdGcTVsL0ZRU1R4ME9NeUUyNldjek5uZk9xRVBEOXZydkdL?=
 =?utf-8?B?dXF0anRDY1lGelVSR3pOdkdrd1dQbDRoM2lYRFBNcGJBVTRhWkFKbzNiVnlO?=
 =?utf-8?B?REdDcmNIYjRMaThNOTlzT2R6ZC9uMVR5aXRJYVBOdGd2VnhVM2EwRFpqa2dS?=
 =?utf-8?B?Z0R0TjFicngweFlDMFhVTkM3cWQ0UmxuV2ZzdVZUUllIUlZ3VVZwdUppVUpY?=
 =?utf-8?B?NGs0VWR1TC9DeDA3SUlqZjBISGI0bkxzeWFNcHI3TVZuckZGOG1LRkpzT3Np?=
 =?utf-8?B?d1pLOVQvRDR0c3U4cmFUblZ2QjBYWGo2blhEZ21JTWpjWVloSVhucVdJREp5?=
 =?utf-8?B?WFdTblE5Qkcva3h6NEM4dHV6L0pVemlzbk5SUmh2Zm5Fa0p3TUsvbVR5YkJj?=
 =?utf-8?B?VHRQa01SMDQ0RXl3Tm5mNHhCQkt4Vnh6bVg1Q3hMYmt0NCtuWHZNUUlwUlh2?=
 =?utf-8?B?MWF2L2F4MC93d3lKaUtZL25RZXUyYWMxd2xJU0svL3p4UUg2MXVVQkZyZnp1?=
 =?utf-8?B?VHlEclVYOE1QRnozeTFTcFdwZmhkVzBaZ3owdkV5WU1LbE9pV2hZeFhYT2Fw?=
 =?utf-8?B?Q2J5c2IyZmRxSTdpN0thTzJONEMvT2JEYldSZkU4VVVCeVlHYUtJczl1VmIx?=
 =?utf-8?B?elovUmdNc2NIZVZuS1poVVRRV0ZUOUpzMFdUQ0lwaUxuVEhWRjZwTmFVdFRv?=
 =?utf-8?B?aHZkY25JbzQydmJIWWIyUkxFdUdtOUJjRHlvWVJCMjdONy9IQ1Z4YldZR0VG?=
 =?utf-8?B?Q21URjVCNjN4WVFYMW1JZ3dkTmdDUkNsTXNvbmFuVVZuZG45MkJqZkpJUHBy?=
 =?utf-8?B?VlpEUEwzOW5aNDdGb0xrVS9NcTZmR1Ruc1VkNlVOWS9mYmI2YTVJdVNxRm5i?=
 =?utf-8?B?K3lPSGNIaTFVUjVSOG0yeGhCczJTQmhtU3VYYjJtVEk2c25nWkxjQmVzS2pH?=
 =?utf-8?B?Z2IrRytXYTIrVFJ0YldDempKNWFoZUZwYnhtQmNPY0VweGl5QUFmSVY5aWs3?=
 =?utf-8?B?VmlFa3laV3RYNk5Cdm5Bd3pCNytRNzNSZXYyOHFpZ0oyWE0rRDdKK0NLV2tL?=
 =?utf-8?B?NUxRMzdLaDR2SVlNZWxJMGM0cE1jWjU4YzIvcnNpRDV5SGVtR1d2RUEzVzlx?=
 =?utf-8?B?bjRPbXFnS0tCUTBLM3BzbXpGZ1M5ODhEMlJQZ0pKb3BuU0p0SS9UN1V0RW9l?=
 =?utf-8?B?NDIvWE1BRk1yZDBHL1M0NmlaTVMvVjh2ZW1KeDdSaWxmNGVBU1BCdFBieDVI?=
 =?utf-8?B?NUZ1R0hCK1J5OVpZclZLMFFpd3ViWWVMOTN3NjZ1K0l2akVaSVpsMU5TOVpr?=
 =?utf-8?B?VTJmTWxTNXF0clFUZE1FTVpvdTVuZHdrcGtlSXAxaXVMOGx3UWpkTDdvcmVW?=
 =?utf-8?B?c3k0d3IxLzlTbjJSK202NHRraG41ZXN2b3pHaGtnN1JEMXFONC9GQTFyNWxj?=
 =?utf-8?B?UWprNjBrSStadjBqNENYVXdTK1VDVVk4cDIzOVRDU1ZrYmdsbTZZVmt0QWhq?=
 =?utf-8?B?NmlGTTk1a01KY0dUQnVhaWxuWVI2V21qT1hQdWx6cVJuUlFhUEtPaVIwdW9U?=
 =?utf-8?B?MnpTSkR3V1h5VFFBVk5MWHdSQXZiOHpkSjh3ajZzY3Y3T2ZGKzBnUzRtSVZE?=
 =?utf-8?B?Y2Nhbno0OW9ySDM5dnl0YlFZVGFnRzBEck53bkNtbUpuTWE4NFh4aXloY3Uv?=
 =?utf-8?B?MEFyNlVRbit1bkE4WHVOR0dJbWZRWDlCSXFFTWZIeTNkOFp3RTRxa2cwemVG?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98B4F132614FCE4E80FE8A525E633DCA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8586.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7399167-ee91-4674-ac5e-08da6f771817
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 02:24:12.1717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nh6y38o9WHgtQVy2+Sb7lCEzs5RyhdmzQHN7H+u6/u8FoKPdvrTfQIR1H1rAAWBf2JttL5X5mhinMQzcgDNGBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2687
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMTA6MDk6NTBBTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IA0KPiBPbiAyMDIyLzcvMjcgOToxMiwgSE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7Tk
uZ8pIHdyb3RlOg0KPiA+IE9uIFR1ZSwgSnVsIDI2LCAyMDIyIGF0IDA0OjEwOjQ2UE0gKzA4MDAs
IEtlZmVuZyBXYW5nIHdyb3RlOg0KPiA+ID4gVXNlIHByX2ZtdCB0byBwcmVmaXggcHJfPGxldmVs
PiBvdXRwdXQuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEtlZmVuZyBXYW5nIDx3YW5n
a2VmZW5nLndhbmdAaHVhd2VpLmNvbT4NCj4gPiBUaGVyZSdyZSBvdGhlciBjbGFzc2VzIG9mIHBy
ZWZpeGVzIGxpa2UgIlVucG9pc29uOiIgYW5kICJzb2Z0IG9mZmxpbmU6IiBpbg0KPiA+IG1tL21l
bW9yeS1mYWlsdXJlLmMuICBTbyBzaW1wbHkgYWRkaW5nIHN1YnN5c3RlbS13aWRlIHByX2ZtdCgp
IGNoYW5nZXMgdG8NCj4gPiBwcmludCBvdXQgdHdvIHByZWZpeGVzIGxpa2UgYmVsb3c6DQo+ID4g
DQo+ID4gICAgWyAxNDc5Ljg5MjM0OF0gTWVtb3J5IGZhaWx1cmU6IHNvZnQgb2ZmbGluZTogMHgx
YjgyMDA6IHBhZ2UgbWlncmF0aW9uIGZhaWxlZCAxLCB0eXBlIDB4NTdmZmZmYzAwYTAwMGModXB0
b2RhdGV8ZGlydHl8bWFwcGVkdG9kaXNrfHN3YXBiYWNrZWR8bm9kZT0xfHpvbmU9MnxsYXN0Y3B1
cGlkPTB4MWZmZmZmKQ0KPiA+IA0KPiA+ICAgIFsgMTQ4Ni44NzExMzBdIE1lbW9yeSBmYWlsdXJl
OiBVbnBvaXNvbjogU29mdHdhcmUtdW5wb2lzb25lZCBwYWdlIDB4MTRmMDANCj4gPiANCj4gPiBE
byB5b3UgaW50ZW5kIHRoaXMgY2hhbmdlPw0KPiANCj4gDQo+IEZpcnN0bHkgSSB0aGluayB0aGV5
IGFyZSBhbGwgaW4gbWVtb3J5IGZhaWx1cmUsIHdpdGggdGhpcyBwcmVmaXggaXMgbm8gYmFkDQo+
IGltcGFjdCwNCj4gDQo+IHNvZnRfb2ZmbGluZV9wYWdlKCkgYW5kIHVucG9pc29uX21lbW9yeSgp
wqAgYXJlIHVzZWQgYnkgZXJyb3IgaW5qZWN0aW9uLA0KDQpZZXMsIHRoaXMgaXMgcmlnaHQsIGFu
ZCBJIHRoaW5rIHRoYXQgdGVzdGluZyBzeXN0ZW1zIG1pZ2h0IHNhdmUgY29uc29sZQ0Kb3V0cHV0
IHRvIGRldGVjdCBpc3N1ZXMgYWZ0ZXJ3YXJkLCBzbyB0aGUgbG9uZ2VyIHByZWZpeCBtaWdodCBj
b25zdW1lIG1vcmUNCnN0b3JhZ2Ugb2Ygc3VjaCBzeXN0ZW1zLiAgU28gSSdkIGxpa2UgdG8ga2Vl
cCB0aGUgb3V0cHV0IHNob3J0ZXIgaWYgcG9zc2libGUuDQoNCj4gDQo+IGJ1dCBzb2Z0X29mZmxp
bmVfcGFnZSgpIGNvdWxkIGJlIHVzZWQgaW4gbWVtb3J5IGhvdHJlbW92ZSwNCj4gDQo+IHNvIGxl
dCdzIGFkZA0KPiANCj4gJyN1bmRlZiBwcl9mbXQnIGJlZm9yZSB1bnBvaXNvbl9wcl9pbmZvIGRl
ZmluaXRpb24sIG9wdGlvbnM/IHRoYW5rcy4NCg0KWWVzLCBJIGFncmVlIHdpdGggdGhpcyBhcHBy
b2FjaCwgdGhhbmsgeW91Lg0KDQotIE5hb3lhIEhvcmlndWNoaQ==
