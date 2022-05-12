Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFD1524477
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348140AbiELEql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348010AbiELEqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:46:25 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2065.outbound.protection.outlook.com [40.107.114.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EF623BF1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjEZo4JB/zTViggpbUaGhQ0i3GSFewfAThKizVFmllrHF2VZgAstaIqJeDUl1LFNRQyKNLGUYDcPRp6Lfo8TFM8w8ysAqIRuf8SUfM3sxeFn7x6IP6mMA/gXA4wqiY/auuv+l+vsUHrCn+abyQEKuFV7FF8TyFXAtigFRGNDQCKsPWTfu/XK+91n5oLIYCXLd3f2DGLlTjqI7QS1YABPg9cgy3VyrHERZTEEWN9mzW1wR4VBx3ckJmPjRHX6sVAHcQEt0bwVwB6C/3Srb3m3ezPVcaZgLFC+p20c6C3fJt3MmuwMQzxm3/HdKeLuwH7iSfLsDd8l1mvmhrT2kWq4gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBRj3VKLtZwiC+4foeutiHE6oIlDOJqzWqUaTVbaGxg=;
 b=K4qwPNnwINE67Wq1TjE+Bv1jnAXuKbHSKD9BEfGtDn61jGk1Fj/1rfshGRsWWpMenQganAwo0j6MjTI6rXbD+eHeGObVMBSRIWqTu2VlyB1mh7tls0SAlfDnrDGpbLmULsAf4c/OROxHoh3OXuaD1yJWChalhYupR9umlEtRMwbUCEJMpLl1fhVwSIudBBP6DJzouNMEsFmC2G5CLbdrBafTPWeN2K3t3Qrdv2xZBzDfBl4LbB6Svn8n1n51AVFPcQn9Ts8lNPhktCseG4VojSr60zxZejm2TJ9IIRkwM5vUUJFGKgli0OUDD2/2JPr8SJbsGXYU7t9VwgaR6UENfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBRj3VKLtZwiC+4foeutiHE6oIlDOJqzWqUaTVbaGxg=;
 b=Nxp+ww4HXmBq35/oux4q3fSw83vUS8oDrKBnSjE+K8iO8O+W7N94pCFTiKH09+SX+56ov+EJ5pia1u9chLrRB+V+QYNin1/I1wfd5+gyb8nUFPNJp5C0zQMjGYbx9EWgaQe0HO4aLFA4r0iAR85KsXkDANgRFJMbTfyxadBQHhk=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB4120.jpnprd01.prod.outlook.com (2603:1096:604:4d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Thu, 12 May
 2022 04:46:17 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8%7]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 04:46:17 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        zhenwei pi <pizhenwei@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v1] mm,hwpoison: set PG_hwpoison for busy hugetlb pages
Thread-Topic: [PATCH v1] mm,hwpoison: set PG_hwpoison for busy hugetlb pages
Thread-Index: AQHYZUq6jUL1RAg6UkGx4+LoCthdFK0aAVCAgACLMICAAB9ZgA==
Date:   Thu, 12 May 2022 04:46:17 +0000
Message-ID: <20220512044617.GA235456@hori.linux.bs1.fc.nec.co.jp>
References: <20220511151955.3951352-1-naoya.horiguchi@linux.dev>
 <f0da4fcf-a4af-ccaa-32ce-55d9fda72203@oracle.com>
 <d7f24648-2af5-3998-d265-c441538ce5fc@huawei.com>
In-Reply-To: <d7f24648-2af5-3998-d265-c441538ce5fc@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cd26a38-751a-4f93-e1d4-08da33d25a5d
x-ms-traffictypediagnostic: OSBPR01MB4120:EE_
x-microsoft-antispam-prvs: <OSBPR01MB4120965DBD90A10EA055C9B5E7CB9@OSBPR01MB4120.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5fUzDEMKFa9mcbQ+hw0RP/NjUhx52vPZx8RQiT/clrQn/5mjOqXRIaHRPidnisycvVpJsnRkqQwC5DHZfvOGPtFJ873BJDSMZ2G26Fl3Ibh2W0jPiYGM7BvejUPIZoy0VURMASK3sA4CfGMpbxpisn6O8Y4u+T9OInhSMldc7gecxfAKHnYawn6HEnJRG4DrJS77NJvEPcIIqn6fu4dYAnvKAXIfjkCJ3C42iSJI3v49GEEKSEjvyinMH7vyJVlfPi+vLMuzWDCFaGOKPfH4zEyYUN71im9lJWAm+bpPrdxo+3Le2JlxnNsv2R5JH0b9fOXw5A2h9c/2qJWNnQ8lm2kodyoObFBFEUy4zpdR+0r3uXgYqocXYjyzxfyu1LsAqZVbPN0TjiUWYPCZSsFMriUUDW0iqRkIcZuWCvNVjVvHCusvdGxDbZfBoyTMRhdNsyejzSWvcbpKKaW60VNaHqx8xuD0XHIMbU99BKYojDoGQreFqhZ8S2UhiOwxhIpgLyi0ivvSliR/yPueLbrBRepY/l0bdnhIbwiIqNMbqtmfhaqxsgCW2GGb1hJ23KoyW/kzn4JGN00GM1SQxcc5iLbj/SsQfjrMJFsXWZQp9SvSpGbAakCdw/jH9sdGq8GF2Juq7dNut7FtXBAtxs581IUMrsnHeqrJSxKnkdu1P5uIv5bipSWy7DyxbT3RUcouOFLd5RhV4yv5fx261mmWJysOk4du8MyJMPejRZtASlJURrG+Bu8j2tZDQbnx0Sy4Dv9i8cuOqBtZ84yWM5kzc+EHqy+iN8Q/Rx1Y9rjHWAM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(86362001)(1076003)(6506007)(8936002)(186003)(71200400001)(82960400001)(85182001)(55236004)(38100700002)(38070700005)(66946007)(66446008)(6916009)(76116006)(54906003)(66556008)(66476007)(316002)(64756008)(8676002)(4326008)(122000001)(2906002)(83380400001)(508600001)(6486002)(966005)(5660300002)(9686003)(6512007)(33656002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0Q0NnZDbHlUQnlETHVYZFVxRW53T2xLSHVXSlR5RTJGZkxyMTl4dUpaVHQz?=
 =?utf-8?B?MlF1Wkk3MFJ4NWc1cGJ4QXJ2R01kWjRjZ3NFOVdVbUszYjA5MDlPUmVlZ1RJ?=
 =?utf-8?B?K0IydFBoN21BWFo4RjhiZ1Y1a3VYcU9mRThzYXMzSWRCcUpnYnhuU0NjK1pM?=
 =?utf-8?B?Y2toenZjbDYybjQ0Rm9UUy9aaTFremFYcUZMSXBjZ1dFb2UvOEwxV2t5MmNI?=
 =?utf-8?B?VDVJRHd3Z3JFdVhtL1dqTU05MTYxQzg3YUpOdERGR1E5RkZ3TU9mZnZNQ01m?=
 =?utf-8?B?aFZsbzJaSWw3bW1WRk13cmpsc0xhLzF3ek1SUFRyMHZXaGJCS3c2bnNDL093?=
 =?utf-8?B?c25qTzllbXhXcEo3QVpLcGZpNFZoVkVXYU1nUnNkNk5rLzRMVCtQcGcvK0dJ?=
 =?utf-8?B?T05UdTZPKzBwNE1hVU1aZEhjNXVkQmZia1hzS2FsZi9FMCs0YlVreW1vN1Fp?=
 =?utf-8?B?VkhKNk5RTkY3Zjd4aEk1cG9wMEI5Zi85a0IrQlM2K1BqcXFyZ1hkQWlZaUFC?=
 =?utf-8?B?a2RMeC9mNUJjemdwUC8vWE5ETFp0WFJzWnJRWTVvMVVPclllc1k5TEFyNEls?=
 =?utf-8?B?QmNyOVZNU0xjZCs2RCtDOXcwaVNCTDBqZzRrN2c3TXFmMzlqUXZqVDM1ZzRE?=
 =?utf-8?B?eVVUNE9Yb2l4eVZPZ2VnbjJ6WHJxWVpFWkxMbHJrZDZMYXJyRG52UHVyc0JE?=
 =?utf-8?B?TngvTnd2REpVZjlGSndES3JzSmZzR3J4VkJnS3NMQk0xblh3L014RkJRZ2or?=
 =?utf-8?B?eU9TcmJlL1VGeE1VV1hQNnpzVU53NTU1K2lWZ1c3TlM1VnRpN2NQdFdPV3po?=
 =?utf-8?B?Wml3TERnSzhtbnpGWlZzMEl3UmJlWVlGc0c0aTVHZEhCeEJ3OVZWaElhSWJk?=
 =?utf-8?B?cUZKZlJVU3prUTF6TzZISTQ1RUI0QVNSVjVKVFJKV1V5OGFzUm1wRFhwbHg5?=
 =?utf-8?B?OWxMbjArRGtlRDF3V25EWXVpcGJxQWFQL0E2cDBTWHNaTmJiZjl1YndHZnVP?=
 =?utf-8?B?c0JBRWZadDdpSmtwZFJta3pBcEZnZHkyMWpaQ0RjWDF3bEVScm10cVlQUVRU?=
 =?utf-8?B?ZVptVW4vKzNvTFc0NzBJTzUvWkthUDBzOFhzOE1UOFphcTlyZmI2YzFUTmRN?=
 =?utf-8?B?a0VkTDZZeEZ6SUtwQ2hhbnlTVkxXL3NlbkpZaGtyR05pQnVDbnNpdU9FL1lO?=
 =?utf-8?B?akJseGR5dENsdE5mM2pzSlA3c0JJS3dJWlhERWs2MHBmbjgrVWUza0h1QzRr?=
 =?utf-8?B?cHVGY3l5ajZPNEtHZHVxQ2xvTkg4cUY0QVpaRFNNdENmUGpyS2lxdjcybmN4?=
 =?utf-8?B?djhGZ3d1NnRYSlFDSDlsWjlVMmlreWxJQ2MzdjVJQ3hBRG54NzlZeFQrTmY1?=
 =?utf-8?B?dFd6MjBQdGF4dmhsWHQ3SkZKU2FQYkdYR3B5YzVTRjJkTEtxYWdrOGI1eUFT?=
 =?utf-8?B?aENKeW4yOWdsOFNlNFpYVHJnWGdoNXdMUTRSbEdqakZUSWtzRnZ0bk56VTlp?=
 =?utf-8?B?VFZjOWpzRGtwWFZXRDhwMWt6bmwyaWR2Y2s0dnpnT0dMaFJXSG9iWjdyaTRl?=
 =?utf-8?B?ZmozWCtZQnV2bjRTK2dRTTU5aFFsNStMTjZPSVJwUFNHeW1UVEo0ZlIrNDc2?=
 =?utf-8?B?TGJDVnlGZDZaVDcvSDVCS0FEOUl6UGk1bHMrTU5KUHc0VEprZHlycGxkV2xk?=
 =?utf-8?B?emMrOEJ3dG5lREdxTkt6a1lQSVljeWpFZCs1WFhyWE9kWlQ4c0tsOEttcnZt?=
 =?utf-8?B?NUpkZmlDYmtkVGw2YVMxUDJWQzh4NDl5dHRTVWhxWU1nd1NvWEg1QmRySUly?=
 =?utf-8?B?eEt4NW91OE1uSk9UR1dRZ1FxcmZOOWd6ejB5ODZkRTFVNUc2VDZXNXdPeW10?=
 =?utf-8?B?ZDBnb3pPdXhLZm5hazVuTWhZeVV5MTRjNWRJeXZSdmNQMGtmK2VaMEdZT2F5?=
 =?utf-8?B?Q1owMGxybDJiM29xVmVMYmZSUkhtekUvNGtBZUpYdC9IeHRiRStIV3ozUFFa?=
 =?utf-8?B?blU0K3laeFhja0R6WG9DeGMvL2liY0VURjhtdGxKeHhwMmRaOEtOMzNHTHpu?=
 =?utf-8?B?amc4Y1lmZHRPdmQ2NnIwUFF5VVdEcVdiazZ4SS9ienhlNUwyUXJiRFhQZ2Rs?=
 =?utf-8?B?SGlZeXViUS9RSmpnbEJKRkQveWRpYkNGSU5SZmFSdmNrcjh3ZDlYNytYSFJC?=
 =?utf-8?B?b2l3Wi9qWFVIS2dmNi9BUkpjR3hJYjQ0cDVFOFNEcGVEcXo4RERsaGw0TGkz?=
 =?utf-8?B?U3cyc1c5L3hTclorQ0ZPY1E4RzVubVZBU3VJN3pidjJkdzNpamhSWDRiYVJE?=
 =?utf-8?B?eGRFc3VOWG1leXdBOG9WdGlXVStaR2RWbzlxaWhpTHo2cWxUNXZFUUc2RTNu?=
 =?utf-8?Q?p1MoUs1/vrPf3HP0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2360F86F0ED3EE4FADBB47D14B990858@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd26a38-751a-4f93-e1d4-08da33d25a5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 04:46:17.8128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWzkKAIc6UodSynHFyYznIl7b2EYhDVDlJs8NKUBGXSw/plcW4PLKj5y82VD5ntWpz3P1nwhfZGx3a7EpvwyOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXkgMTIsIDIwMjIgYXQgMTA6NTQ6MDVBTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi81LzEyIDI6MzUsIE1pa2UgS3JhdmV0eiB3cm90ZToNCj4gPiBPbiA1LzEx
LzIyIDA4OjE5LCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4+IEZyb206IE5hb3lhIEhvcmln
dWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQo+ID4+DQo+ID4+IElmIG1lbW9yeV9mYWls
dXJlKCkgZmFpbHMgdG8gZ3JhYiBwYWdlIHJlZmNvdW50IG9uIGEgaHVnZXRsYiBwYWdlDQo+ID4+
IGJlY2F1c2UgaXQncyBidXN5LCBpdCByZXR1cm5zIHdpdGhvdXQgc2V0dGluZyBQR19od3BvaXNv
biBvbiBpdC4NCj4gPj4gVGhpcyBub3Qgb25seSBsb3NlcyBhIGNoYW5jZSBvZiBlcnJvciBjb250
YWlubWVudCwgYnV0IGJyZWFrcyB0aGUgcnVsZQ0KPiA+PiB0aGF0IGFjdGlvbl9yZXN1bHQoKSBz
aG91bGQgYmUgY2FsbGVkIG9ubHkgd2hlbiBtZW1vcnlfZmFpbHVyZSgpIGRvDQo+ID4+IGFueSBv
ZiBoYW5kbGluZyB3b3JrIChldmVuIGlmIHRoYXQncyBqdXN0IHNldHRpbmcgUEdfaHdwb2lzb24p
Lg0KPiA+PiBUaGlzIGluY29uc2lzdGVuY3kgY291bGQgaGFybSBjb2RlIG1haW50YWluYWJpbGl0
eS4NCj4gPj4NCj4gPj4gU28gc2V0IFBHX2h3cG9pc29uIGFuZCBjYWxsIGh1Z2V0bGJfc2V0X3Bh
Z2VfaHdwb2lzb24oKSBmb3Igc3VjaCBhIGNhc2UuDQo+IA0KPiBJJ20gc29ycnkgYnV0IHdoZXJl
IGlzIGh1Z2V0bGJfc2V0X3BhZ2VfaHdwb2lzb24oKSBkZWZpbmVkIGFuZCB1c2VkID8gSSBjYW4n
dCBmaW5kIGl0Lg0KDQpTb3JyeSwgdGhpcyBkZXBlbmRzIG9uIHRoZSB1bm1lcmdlZCBwYXRjaA0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vMjAyMjA0MjcwNDI4NDEuNjc4MzUxLTIt
bmFveWEuaG9yaWd1Y2hpQGxpbnV4LmRldi8NCiwgc28gc2hvdWxkIGNvbWUgYWZ0ZXIgdGhhdC4g
IEknbGwgZG8gYm90aCBpbnRvIGEgc2luZ2xlIHBhdGNoc2V0IG5leHQuDQoNCi4uLg0KPiA+PiBk
aWZmIC0tZ2l0IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4g
Pj4gaW5kZXggNmEyOGQwMjBhNGRhLi5lMzI2OWI5OTEwMTYgMTAwNjQ0DQo+ID4+IC0tLSBhL21t
L21lbW9yeS1mYWlsdXJlLmMNCj4gPj4gKysrIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+PiBA
QCAtMTUyNiw3ICsxNTI2LDggQEAgaW50IF9fZ2V0X2h1Z2VfcGFnZV9mb3JfaHdwb2lzb24odW5z
aWduZWQgbG9uZyBwZm4sIGludCBmbGFncykNCj4gPj4gIAkJCWNvdW50X2luY3JlYXNlZCA9IHRy
dWU7DQo+ID4+ICAJfSBlbHNlIHsNCj4gPj4gIAkJcmV0ID0gLUVCVVNZOw0KPiA+PiAtCQlnb3Rv
IG91dDsNCj4gPj4gKwkJaWYgKCEoZmxhZ3MgJiBNRl9OT19SRVRSWSkpDQo+ID4+ICsJCQlnb3Rv
IG91dDsNCj4gPj4gIAl9DQo+ID4gDQo+ID4gSGkgTmFveWEsDQo+ID4gDQo+ID4gV2UgYXJlIGlu
IHRoZSBlbHNlIGJsb2NrIGJlY2F1c2UgIUhQYWdlRnJlZWQoKSBhbmQgIUhQYWdlTWlncmF0YWJs
ZSgpLg0KPiA+IElJVUMsIHRoaXMgbGlrZWx5IG1lYW5zIHRoZSBwYWdlIGlzIGlzb2xhdGVkLiAg
T25lIGNvbW1vbiByZWFzb24gZm9yIGlzb2xhdGlvbg0KPiA+IGlzIG1pZ3JhdGlvbi4gIFNvLCB0
aGUgcGFnZSBjb3VsZCBiZSBpc29sYXRlZCBhbmQgb24gYSBsaXN0IGZvciBtaWdyYXRpb24uDQo+
ID4gDQo+ID4gSSB0b29rIGEgcXVpY2sgbG9vayBhdCB0aGUgaHVnZXRsYiBtaWdyYXRpb24gY29k
ZSBhbmQgZGlkIG5vdCBzZWUgYW55IGNoZWNrcw0KPiA+IGZvciBQYWdlSFdQb2lzb24gYWZ0ZXIg
YSBodWdldGxiIHBhZ2UgaXMgaXNvbGF0ZWQuICBJIGNvdWxkIGhhdmUgbWlzc2VkDQo+ID4gc29t
ZXRoaW5nPyAgSWYgdGhlcmUgYXJlIG5vIGNoZWNrcywgd2Ugd2lsbCByZWFkIHRoZSBQYWdlSFdQ
b2lzb24gcGFnZQ0KPiA+IGluIGtlcm5lbCBtb2RlIHdoaWxlIGNvcHlpbmcgdG8gdGhlIG1pZ3Jh
dGlvbiB0YXJnZXQuDQo+ID4gDQo+ID4gSXMgdGhpcyBhbiBpc3N1ZT8gIElzIGlzIHNvbWV0aGlu
ZyB3ZSBuZWVkIHRvIGJlIGNvbmNlcm5lZCB3aXRoPyAgTWVtb3J5DQo+ID4gZXJyb3JzIGNhbiBo
YXBwZW4gYXQgYW55IHRpbWUsIGFuZCBncmFjZWZ1bGx5IGhhbmRsaW5nIHRoZW0gaXMgYmVzdCBl
ZmZvcnQuDQo+IA0KPiBJdCBzZWVtcyBIV1BvaXNvbiBodWdldGxiIHBhZ2Ugd2lsbCBzdGlsbCBi
ZSBhY2Nlc3NlZCBiZWZvcmUgdGhpcyBwYXRjaC4gQ2FuIHdlIGRvIGENCj4gZ2V0X3BhZ2VfdW5s
ZXNzX3plcm8gZmlyc3QgaGVyZSB0byBlbnN1cmUgdGhhdCBodWdldGxiIHBhZ2UgbWlncmF0aW9u
IHNob3VsZCBmYWlsIGR1ZQ0KPiB0byB0aGlzIGV4dHJhIHBhZ2UgcmVmZXJlbmNlIGFuZCB0aHVz
IG5vdCBhY2Nlc3MgdGhlIHBhZ2UgY29udGVudD8gSWYgaHVnZXRsYiBwYWdlIGlzDQo+IGFscmVh
ZHkgZnJlZXplZCwgY29ycnVwdGVkIG1lbW9yeSB3aWxsIHN0aWxsIGJlIGNvbnN1bWVkIHRob3Vn
aC4gOigNCg0KUmlnaHQsIEkgaGF2ZSBubyBpZGVhIGFib3V0IHRoaXMgLi4uDQoNClRoYW5rcywN
Ck5hb3lhIEhvcmlndWNoaQ==
