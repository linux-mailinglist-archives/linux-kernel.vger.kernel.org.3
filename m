Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022BA5ACC3E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbiIEHVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbiIEHU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:20:28 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2049.outbound.protection.outlook.com [40.107.114.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF883AE49
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeg6LG3bDeWEvjKRPwRmL14FkW4bBdFli6P3B7ntjZ1y9me2tgST7vTwBFOaNI2fU3rVDVK/+yT2Zk+OU1uI6ZJeZNK4PkdSXQuwfbTzhpbNEX7NLBQUPv0CK6+YEMWAwruU/PVqq7dCCWeLkhMwtsR5BTpUU/XQodGKFNH4wTpgFACVC1MUmzIo9/SCOxHbEdd517sr05qz3AjHRj5vp6TBwEDOVtEPFnG7J5UEJWp0rCWCFQmsCN8cdBDq0Ad/iyRBjAZS1iWa7YhQUdbD24AwclqkwEASDnb5VSlYLTemT4VgVg81oi9Y1POi98+3TVIJiZaf5+BTL9TrIu6U6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVbtkJfGz5NiJXi2d8ngbpAOtUuToxuhf+g60DBRTlk=;
 b=RXAib6O1ALgMB10r+elcUybfmNSDBBryOVK5DLYizL+PlfjZPlfZo7sN4+Ji3/mKupp6O+snzk9ZOA1L39DQ8WJ5KH2tlbaf+V1KwrRa8u5oWtkIGZW5uCFmAF7mQHzAHq52J3aVXs41DNuV7I5yqZolR/WqTKVa5zS4N8OoMyqHhJOPB5HTLIe3fQzCvKmhkfqvE2TMRDEqzukMuxb9YL88gqpWqPN7jz/I1Qw+WHkQl+WcL0FAH+I2sMJJzeGfPHX4a10BY+iYu5FtLMGPvDXE6XeVfXlqNudP6qny58Wb2Tmys8r6hPDVbpoL4QfJJVeWmDjFTC/AfE+AswWY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVbtkJfGz5NiJXi2d8ngbpAOtUuToxuhf+g60DBRTlk=;
 b=XovjFlAoJD00fU3lFCr24JUUsf5lpiD0SQyOXGO0P21Hs6t5OPDMCZXKm3P5ipcQRtVuqhu+YsVfJ5a1AdnQhOGPTkicLwEyHi14YrREJOYNaCXdDfNdyS6jR6Ri+L0H6lQzNyACRXlybmMe4IK/Ym3099Hx119JTpT0bpsO9uM=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB10840.jpnprd01.prod.outlook.com (2603:1096:400:26e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 07:15:43 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5588.011; Mon, 5 Sep 2022
 07:15:43 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] mm, hwpoison: use __PageMovable() to detect non-lru
 movable pages
Thread-Topic: [PATCH 2/6] mm, hwpoison: use __PageMovable() to detect non-lru
 movable pages
Thread-Index: AQHYvG0tDdoAExJA9UaLkJKIiB3aRq3QVjKAgAAZaoCAAAYnAA==
Date:   Mon, 5 Sep 2022 07:15:43 +0000
Message-ID: <20220905071542.GA1364147@hori.linux.bs1.fc.nec.co.jp>
References: <20220830123604.25763-1-linmiaohe@huawei.com>
 <20220830123604.25763-3-linmiaohe@huawei.com>
 <20220905052243.GA1355682@hori.linux.bs1.fc.nec.co.jp>
 <1f7ee86e-7d28-0d8c-e0de-b7a5a94519e8@huawei.com>
In-Reply-To: <1f7ee86e-7d28-0d8c-e0de-b7a5a94519e8@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aff0271b-e031-4139-952c-08da8f0e722f
x-ms-traffictypediagnostic: TYCPR01MB10840:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IAVzrLnYSb4TlhIRAoBmH4jINukkyLQD4FPVnDdrhZaV4pbw4tbuX1PyA9GmSFHFNPU3m55GyvedmohpHQh20SkUMbO7dRwTuWkf4ke206XgkwOSIiF876f9X+60htxGAYwRDWPtiTb6M0vwPj7NZgYwpWvOfNDC9XIZipfdbnyQi8mpIneMwrHkik39WOqxDAfsegBHj3DTCCAlL/jZ9HXUeBJQHbuzDTyUYKfBgzp/MhBTgiXc2ZHOOyZ829AQk4QC2Z/3GEKklo+GoAQ66NTs6peSMUE3shH4N8fqWrhjm1FgG14JS/LrJzVlKLL8Pm9HdY2H3duOjaJqx0B1PeZS70ntbeLBFg9vtwhmC2Oi6Tn++w+gZWEWElv0k+jj0PaIqNXILgmOjHUabVqBh+affUQosDdEaDEkqdkIGBN514uOuDMTJn71eLVWBhtKKYaC9Uia8grfp6qzOf/orX7XwhzN/Y/ibH1LX9/lGwt5fkpyuxVkPEHBoQVYBpEP5MF65ju9yIgM8bdEpRGq0KZq3TKXl1MmoIXH0E+OckphfudScKKB77tBvnBalUwGadGJucow7vJXzTwSepvqg9Si0k3g9F6ZuuTdB/d/EHxlpI3PqfAu/sAtb27ZnffvyTP90qVC1aLj6Cy3bMtQK8R5BXClDofhUh05p1N+kUw2xzK7hw342g3wI3c8sLn2wBPX2+nE0R2qnuWEeQqjMRkqTxwPDQ+8Vx4YtOae0/pb3rDltc3eTNWE3Fbelbn+qHgSXTaM9zrclFdUVljzeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(41300700001)(71200400001)(478600001)(2906002)(9686003)(26005)(6506007)(6512007)(66556008)(66476007)(66446008)(4326008)(66946007)(76116006)(8676002)(38070700005)(85182001)(33656002)(86362001)(6486002)(53546011)(54906003)(6916009)(316002)(122000001)(82960400001)(38100700002)(186003)(1076003)(5660300002)(64756008)(8936002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjVWOTdkZHRWTGFMc2dlOHEvaS91RTY3VzBsTmFORHBMWUplaEdVQWNIZWpY?=
 =?utf-8?B?RFFRMk1nMFFRS1FyYlRYc2dwc0pyenBBVUUzaE0yQm15R1dqYnc4ZVdZT1pI?=
 =?utf-8?B?YTBlZjBWY3JGQWM0VHhqbTJCSU8ramRyMzVISTRVQ0FMaWpZSmlVS2t4ME15?=
 =?utf-8?B?V3E5OFVNVyszRzdBRFdVN0xHMjYrQUROaDFOKzFaa3dtOUNMc0JXZEtRaWtP?=
 =?utf-8?B?Y0MwcjI3OWdVZVF4U0ZmVTdDemZGam1DcUpabmJVNlpLTEpYTHZFZmlHbi9H?=
 =?utf-8?B?a1IvOS9WL1hxVFdBZ25hMXNDQWZmQU16Unl3ekpzM05yMEdRTHBYYmdaeFZV?=
 =?utf-8?B?M0JYMjNWdUJWRU9TTkt3SHlHMTk3cmhTWGwyTEhreEtvQ3FRV0ZQczRycnRM?=
 =?utf-8?B?YUZGb2h0OHdXSktmU0VEK0ZDZlI5cTc1a2NvM3piU0tXVTUvYW1TVkwydW1a?=
 =?utf-8?B?SmdTV0toZUJjSmNzTWhRczdST2tQZzNvS3M5RDQyR1UzbUN0TUYwOVNGM0pt?=
 =?utf-8?B?R1ZWZzNFUG9Pam1PYyt2bE1ndDkxTkltcFJPN3RiSk83WU5ueDZVMUQ4ams0?=
 =?utf-8?B?bWFGNDZKVXF0VXF2WVJnYmhWanFxOWlHRksxTFJhUUI4Z2dkek54RGxTajZE?=
 =?utf-8?B?OXM3UHExekhDU1pwRkZwSWIrZHNHQkhjSHpnTTVPak1Td1k0MXQ1OUhnYk4y?=
 =?utf-8?B?L0Q0VEZzOU1pQzVSaEpFV21xV1RheTkxZEUwUUtiVTc3M0Jpd0ZURlU4UkFF?=
 =?utf-8?B?WEFSWDdhenFQRitvaVdZVzRkczJJWkZLaFlocGYyMEszNzNFZmZ2azBQQ2dW?=
 =?utf-8?B?bUxOT1hnRnhIaVBjempLdFhQc3lZTnJRZ0docnlLV2xxRXJRdUtPbDlDRGZG?=
 =?utf-8?B?dDR0WHZSNVdBWE01bVdKNjBQeU9HdEMzQzl2SjNDSFlKRGRmNFYzeUpndGow?=
 =?utf-8?B?Z0ZwZlFXMGplM3RGRlRUeUk0VzlmdzRya3ZKa0E3VEVONmttUzlMRzVUd2VS?=
 =?utf-8?B?Q2prOW9ucWZrRGRtNC9YWU9BYUZSSEF3Z3FaNTJ4NTlySWZVcG9VQSsvUjVF?=
 =?utf-8?B?UFpkeVBqeHV5UHVyN25uQUo5ZkJVVCs0QkpCYTRHSjMyanQrZ3hkMWJJczJ6?=
 =?utf-8?B?V1dvY0djMTBiRi9vUm1Mb0V1TTY3UXhlTktTdVhpUzFsS0ZoclZYQU5pRTY3?=
 =?utf-8?B?MXp0YUtqV0pKOW1kd1I4ZStaYnlRbDlTV0ZsREdBT3cxUkxCT25wZFIvaVN1?=
 =?utf-8?B?dlV2bGVJUFZ2UE1Rc29FcGhLTVRqaGZDSFFyeUJnV2VGcXZlRStFM1ZMTC9I?=
 =?utf-8?B?ZlE3bGhIVkd0TWRqTTZiTW9uY2wzNnkwWVk4bVBnd1JGdStOZHU1TEtrUjVZ?=
 =?utf-8?B?YlNEOHVadG1ZWVFrOUg3dVN6K0pLKy9YekRMbmx4QXF2M3Y2c202TmsrZVJD?=
 =?utf-8?B?bzlvVEEvZGRxZE5MV2tiazFqc1pqS3NJSG1Uc0l6TGxPTWhNa2RHb01DMVQx?=
 =?utf-8?B?NjlON0NkaXZxWkpEVHFSWDFnZ3VreHBBR0h1Ui9FNk9SYWJESExDdHNXeklr?=
 =?utf-8?B?RmZYWVU3d0s5U2hUL2VCUGIwSER0RGU3dUJMYnRaeEszKytWY2ovZ0NSVFYv?=
 =?utf-8?B?OWFpNEVvYlM1NzA3NGcvaFMzVXQ4UDRBcE1KYXlXMXhOQTJSTG1SZEhMZzBa?=
 =?utf-8?B?c1BRc1BVSUdmVk4vWXAzRHV1d3ExZURLclpTYjFBSGhjQVBoZlF4N1gweEth?=
 =?utf-8?B?TW55NEVBeDhvcUlsM1paekkyUUE4U0x3V1J5SmZiS0hXWTVnZWhhRm5laDRq?=
 =?utf-8?B?SUc1VEhabGdGbHkxekgzNG1URmZLbWh1UVhmQnpGVVE3SlQwN2ZiNFJpQWhp?=
 =?utf-8?B?YXM1UjJsb0E5UHdabFc1d0NoSEQ0eUF0NTBkR1RHZDEvdFhkQ3pCeSs5K0dI?=
 =?utf-8?B?ejhWTTFGQjFZcHhsYzZDTUVMMUQrSDVhWm1WQitwaTBuUXBZeXQ0T0RObWJy?=
 =?utf-8?B?bzFUbm1ZZkg4WHRUMU9JREZwNDM4V3l1L0xQTFhOYzhIT3hHZmJETE0vVmtK?=
 =?utf-8?B?OWo0ZjFRazZkOCtTaTM2N21NVzgwUWMzRW8wcExmSSswbkdsd2tFWHFqM2xM?=
 =?utf-8?B?V2x6RE5sejZEU1Q4NHhPeTFqc3pQQzFFV1RTWlJQTmFiVXFkU2FjZThJRXky?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41DB1791986F2B4FB57B9FB3CEBD838F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff0271b-e031-4139-952c-08da8f0e722f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 07:15:43.3912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cBIkYvhNoAuSFYWsJ3mwFjKrLuKwcULVii3NTmEGYu0UGm4wawiFLtJSc/WJ9e2wv1gHdcSZ7fbAQrou6pBxBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10840
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBTZXAgMDUsIDIwMjIgYXQgMDI6NTM6NDFQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi85LzUgMTM6MjIsIEhPUklHVUNISSBOQU9ZQSjloIDlj6Mg55u05LmfKSB3
cm90ZToNCj4gPiBIaSBNaWFvaGUsDQo+ID4gDQo+ID4gT24gVHVlLCBBdWcgMzAsIDIwMjIgYXQg
MDg6MzY6MDBQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90ZToNCj4gPj4gSXQncyBtb3JlIHJlY29t
bWVuZGVkIHRvIHVzZSBfX1BhZ2VNb3ZhYmxlKCkgdG8gZGV0ZWN0IG5vbi1scnUgbW92YWJsZQ0K
PiA+PiBwYWdlcy4gV2UgY2FuIGF2b2lkIGJ1bXBpbmcgcGFnZSByZWZjbnQgdmlhIGlzb2xhdGVf
bW92YWJsZV9wYWdlKCkgZm9yDQo+ID4+IHRoZSBpc29sYXRlZCBscnUgcGFnZXMuIEFsc28gaWYg
cGFnZXMgYmVjb21lIFBhZ2VMUlUganVzdCBhZnRlciB0aGV5J3JlDQo+ID4+IGNoZWNrZWQgYnV0
IGJlZm9yZSB0cnlpbmcgdG8gaXNvbGF0ZSB0aGVtLCBpc29sYXRlX2xydV9wYWdlKCkgd2lsbCBi
ZQ0KPiA+PiBjYWxsZWQgdG8gZG8gdGhlIHJpZ2h0IHdvcmsuDQo+ID4gDQo+ID4gR29vZCBwb2lu
dCwgbm9uLWxydSBtb3ZhYmxlIHBhZ2UgaXMgY3VycmVudGx5IGhhbmRsZWQgYnkgaXNvbGF0ZV9s
cnVfcGFnZSgpLA0KPiA+IHdoaWNoIGFsd2F5cyBmYWlscy4gIFRoaXMgbWVhbnMgdGhhdCB3ZSBs
b3N0IHRoZSBjaGFuY2Ugb2Ygc29mdC1vZmZsaW5pbmcNCj4gPiBmb3IgYW55IG5vbi1scnUgbW92
YWJsZSBwYWdlLiAgU28gdGhpcyBwYXRjaCBpbXByb3ZlcyB0aGUgc2l0dWF0aW9uLg0KPiANCj4g
Tm9uLWxydSBtb3ZhYmxlIHBhZ2Ugd2lsbCBzdGlsbCBiZSBoYW5kbGVkIGJ5IGlzb2xhdGVfbW92
YWJsZV9wYWdlKCkgYmVmb3JlIHRoZSBjb2RlIGNoYW5nZQ0KPiBhcyB0aGV5IGRvbid0IGhhdmUg
UGFnZUxSVSBzZXQuIFRoZSBjdXJyZW50IHNpdHVhdGlvbiBpcyB0aGF0IHRoZSBpc29sYXRlZCBM
UlUgcGFnZXMgYXJlDQo+IHBhc3NlZCB0byBpc29sYXRlX21vdmFibGVfcGFnZSgpIHVuY29ycmVj
dGx5LiBUaGlzIG1pZ2h0IG5vdCBodXJ0LiBCdXQgdGhlIGNoYW5jZSB0aGF0IHBhZ2VzDQo+IGJl
Y29tZSB1bi1pc29sYXRlZCBhbmQgdGh1cyBhdmFpbGFibGUganVzdCBhZnRlciBjaGVja2luZyBj
b3VsZCBiZSBzZWl6ZWQgd2l0aCB0aGlzIHBhdGNoLg0KDQpPSywgdGhhbmsgeW91IGZvciBjb3Jy
ZWN0IG1lLg0KDQo+IA0KPiA+IA0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBNaWFvaGUgTGlu
IDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBtbS9tZW1vcnktZmFpbHVy
ZS5jIHwgMiArLQ0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9tbS9tZW1vcnktZmFpbHVyZS5jIGIvbW0v
bWVtb3J5LWZhaWx1cmUuYw0KPiA+PiBpbmRleCBhOTIzYTZkZGU4NzEuLjM5NjZmYTZhYmUwMyAx
MDA2NDQNCj4gPj4gLS0tIGEvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+PiArKysgYi9tbS9tZW1v
cnktZmFpbHVyZS5jDQo+ID4+IEBAIC0yNDA0LDcgKzI0MDQsNyBAQCBFWFBPUlRfU1lNQk9MKHVu
cG9pc29uX21lbW9yeSk7DQo+ID4+ICBzdGF0aWMgYm9vbCBpc29sYXRlX3BhZ2Uoc3RydWN0IHBh
Z2UgKnBhZ2UsIHN0cnVjdCBsaXN0X2hlYWQgKnBhZ2VsaXN0KQ0KPiA+PiAgew0KPiA+PiAgCWJv
b2wgaXNvbGF0ZWQgPSBmYWxzZTsNCj4gPj4gLQlib29sIGxydSA9IFBhZ2VMUlUocGFnZSk7DQo+
ID4+ICsJYm9vbCBscnUgPSAhX19QYWdlTW92YWJsZShwYWdlKTsNCj4gPiANCj4gPiBJdCBzZWVt
cyB0aGF0IFBBR0VfTUFQUElOR19NT1ZBQkxFIGlzIG5vdCBzZXQgZm9yIGh1Z2V0bGIgcGFnZXMs
IHNvDQo+ID4gbHJ1IGJlY29tZXMgdHJ1ZSBmb3IgdGhlbS4gIFRoZW4sIGlmIGlzb2xhdGVfaHVn
ZXRsYigpIHN1Y2NlZWRzLA0KPiA+IGluY19ub2RlX3BhZ2Vfc3RhdGUoKSBpcyBjYWxsZWQgZm9y
IGh1Z2V0bGIgcGFnZXMsIG1heWJlIHRoYXQncyBub3QgZXhwZWN0ZWQuDQo+IA0KPiBZZXMsIHRo
YXQncyB1bmV4cGVjdGVkLiBUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMgb3V0Lg0KPiANCj4gPiAN
Cj4gPj4gIA0KPiA+PiAgCWlmIChQYWdlSHVnZShwYWdlKSkgew0KPiA+PiAgCQlpc29sYXRlZCA9
ICFpc29sYXRlX2h1Z2V0bGIocGFnZSwgcGFnZWxpc3QpOw0KPiA+ICAgICAgICAgfSBlbHNlIHsN
Cj4gPiAgICAgICAgICAgICAgICAgaWYgKGxydSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICBpc29sYXRlZCA9ICFpc29sYXRlX2xydV9wYWdlKHBhZ2UpOw0KPiA+ICAgICAgICAgICAgICAg
ICBlbHNlDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgaXNvbGF0ZWQgPSAhaXNvbGF0ZV9t
b3ZhYmxlX3BhZ2UocGFnZSwgSVNPTEFURV9VTkVWSUNUQUJMRSk7DQo+ID4gDQo+ID4gICAgICAg
ICAgICAgICAgIGlmIChpc29sYXRlZCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBsaXN0
X2FkZCgmcGFnZS0+bHJ1LCBwYWdlbGlzdCk7DQo+ID4gICAgICAgICB9DQo+ID4gDQo+ID4gICAg
ICAgICBpZiAoaXNvbGF0ZWQgJiYgbHJ1KQ0KPiA+ICAgICAgICAgICAgICAgICBpbmNfbm9kZV9w
YWdlX3N0YXRlKHBhZ2UsIE5SX0lTT0xBVEVEX0FOT04gKw0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHBhZ2VfaXNfZmlsZV9scnUocGFnZSkpOw0KPiA+IA0KPiA+IHNv
LCBob3cgYWJvdXQgbW92aW5nIHRoaXMgaWYgYmxvY2sgaW50byB0aGUgYWJvdmUgZWxzZSBibG9j
az8NCj4gPiBUaGVuLCB0aGUgYXV0b21hdGljIHZhcmlhYmxlIGxydSBjYW4gYmUgbW92ZWQgaW50
byB0aGUgZWxzZSBibG9jay4NCj4gDQo+IERvIHlvdSBtZWFuIHNvbWV0aGluZyBsaWtlIGJlbG93
Pw0KPiANCj4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS1mYWlsdXJlLmMgYi9tbS9tZW1vcnktZmFp
bHVyZS5jDQo+IGluZGV4IGRmM2JmMjY2ZWViZi4uNDg3ODBmM2E2MWQzIDEwMDY0NA0KPiAtLS0g
YS9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ICsrKyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gQEAg
LTI0MDQsMjQgKzI0MDQsMjUgQEAgRVhQT1JUX1NZTUJPTCh1bnBvaXNvbl9tZW1vcnkpOw0KPiAg
c3RhdGljIGJvb2wgaXNvbGF0ZV9wYWdlKHN0cnVjdCBwYWdlICpwYWdlLCBzdHJ1Y3QgbGlzdF9o
ZWFkICpwYWdlbGlzdCkNCj4gIHsNCj4gICAgICAgICBib29sIGlzb2xhdGVkID0gZmFsc2U7DQo+
IC0gICAgICAgYm9vbCBscnUgPSAhX19QYWdlTW92YWJsZShwYWdlKTsNCj4gDQo+ICAgICAgICAg
aWYgKFBhZ2VIdWdlKHBhZ2UpKSB7DQo+ICAgICAgICAgICAgICAgICBpc29sYXRlZCA9ICFpc29s
YXRlX2h1Z2V0bGIocGFnZSwgcGFnZWxpc3QpOw0KPiAgICAgICAgIH0gZWxzZSB7DQo+ICsgICAg
ICAgICAgICAgICBib29sIGxydSA9ICFfX1BhZ2VNb3ZhYmxlKHBhZ2UpOw0KPiArDQo+ICAgICAg
ICAgICAgICAgICBpZiAobHJ1KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBpc29sYXRlZCA9
ICFpc29sYXRlX2xydV9wYWdlKHBhZ2UpOw0KPiAgICAgICAgICAgICAgICAgZWxzZQ0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICBpc29sYXRlZCA9ICFpc29sYXRlX21vdmFibGVfcGFnZShwYWdl
LCBJU09MQVRFX1VORVZJQ1RBQkxFKTsNCj4gDQo+IC0gICAgICAgICAgICAgICBpZiAoaXNvbGF0
ZWQpDQo+ICsgICAgICAgICAgICAgICBpZiAoaXNvbGF0ZWQpIHsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgbGlzdF9hZGQoJnBhZ2UtPmxydSwgcGFnZWxpc3QpOw0KPiArICAgICAgICAgICAg
ICAgICAgICAgICBpZiAobHJ1KQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlu
Y19ub2RlX3BhZ2Vfc3RhdGUocGFnZSwgTlJfSVNPTEFURURfQU5PTiArDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYWdlX2lzX2ZpbGVfbHJ1
KHBhZ2UpKTsNCj4gKyAgICAgICAgICAgICAgIH0NCj4gICAgICAgICB9DQo+IA0KPiAtICAgICAg
IGlmIChpc29sYXRlZCAmJiBscnUpDQo+IC0gICAgICAgICAgICAgICBpbmNfbm9kZV9wYWdlX3N0
YXRlKHBhZ2UsIE5SX0lTT0xBVEVEX0FOT04gKw0KPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBwYWdlX2lzX2ZpbGVfbHJ1KHBhZ2UpKTsNCj4gLQ0KPiAgICAgICAgIC8qDQo+
ICAgICAgICAgICogSWYgd2Ugc3VjY2VlZCB0byBpc29sYXRlIHRoZSBwYWdlLCB3ZSBncmFiYmVk
IGFub3RoZXIgcmVmY291bnQgb24NCj4gICAgICAgICAgKiB0aGUgcGFnZSwgc28gd2UgY2FuIHNh
ZmVseSBkcm9wIHRoZSBvbmUgd2UgZ290IGZyb20gZ2V0X2FueV9wYWdlcygpLg0KPiANCg0KWWVz
LCB0aGF0J3MgZXhhY3RseSB3aGF0IEkgdGhvdWdodCBvZi4NCg0KVGhhbmtzLA0KTmFveWEgSG9y
aWd1Y2hp
