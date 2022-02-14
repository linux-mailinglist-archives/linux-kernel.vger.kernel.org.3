Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8894B53F8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355483AbiBNO6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:58:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353443AbiBNO6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:58:04 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120077.outbound.protection.outlook.com [40.107.12.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D53649256
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:57:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGLM/Dt+3XtlP2fIvpU+KIU+Z1t847fZo8CN27a9dljcRcF121xT7Uv7aq5RbBoTv1AO55klGfNIT8+A/UXrDPlGnIkCA56RJWsw0yDNPTDuoKPWTozMRoXJJHYKTRCS/0Z3v3FiKD67p4AA3xoBS3jHDrASLs+ZmFFcgj2kjQj1mLwrUo2dZg6is0yOTxiulRQ5lW0ZrvuEFhyyxQJfDrBVvShypekcIu3cikGGziFtfpExRu2Hr0P6iYRZEXGBY84zI7caEuyxgYsHJi802HsGAgDcoYwR2gTgEGZwSrLcOIbNzDFaKo4EGRiILRgx2pkkx1ayDc3nu7Wo+lgLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tajIxZSKGkrG7ebFaAiFt3J+IlheA4Mf/ttf+3KgfX0=;
 b=iAMohK62ItMmGi9tvhsILsWRe3s4b7fqPC73Gg592MlaDaT/Fh7+3FjGCrrGHsZ+rL2TcizBEduh151uCogUfZvEt5AtKX/YTy+ocEZaddPLZZXzdCIQwUDaMJ6D1m5GAKIGTwLieyG5o/hjVsDtDt8X+6OnS8FR+GwJ5VN0l6NixjACanzXjuNPjD4LClw+J/xMOqoyPcDu3KXQfxZTmhmXTQL2qIcEGJmsE+HC/IxrxuqoAuEKBlUsJYoh1w9x0mXOzejeZUEQnVsawi9ay9WumL5FByJ836QH8CB2BDRa1oGVLvu7LrcC2vW0RI4hVVvaX2ubOaS6JNuDBGPfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAYP264MB4368.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:18c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 14:57:51 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%9]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 14:57:51 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Anshuman Khandual' <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v6] mm: Uninline copy_overflow()
Thread-Topic: [PATCH v6] mm: Uninline copy_overflow()
Thread-Index: AQHYIWvihpEL6XdIL0a0KjA537qokqySzsCAgAAbLgCAAB6+AIAACuYAgAAQD4A=
Date:   Mon, 14 Feb 2022 14:57:51 +0000
Message-ID: <ae9c5df2-0096-fec6-4416-cbbcc99f33ce@csgroup.eu>
References: <e1723b9cfa924bcefcd41f69d0025b38e4c9364e.1644819985.git.christophe.leroy@csgroup.eu>
 <50eed483-9f0a-7aee-1bfd-e89106a80424@arm.com>
 <1157d90c7335458cab4ef471c63a1d52@AcuMS.aculab.com>
 <3b8270fa-b89b-30c6-c1b8-285645215276@csgroup.eu>
 <f487114af1444881b495e0002de491b2@AcuMS.aculab.com>
In-Reply-To: <f487114af1444881b495e0002de491b2@AcuMS.aculab.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bde3a243-4f1a-4562-4155-08d9efca5fa1
x-ms-traffictypediagnostic: PAYP264MB4368:EE_
x-microsoft-antispam-prvs: <PAYP264MB43682B4F35872F9896C6BF4EED339@PAYP264MB4368.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cIgRxGyG0wQ0QoBi12Vi7CfzymL3e1PPwwaLXaYqXuCmGTG3eYWwz9AD9gmhmCMGnNDsr8g9XiEns1lK8CN4tdb3exG6pkMFT0hvid6o3QpfaHAsgFKFZeBJcgDytCHHyrz+R9gdfgNgkR+p7h4stuCElGcpc2JkNQ62oyEBNyuJfhzVzUkyTc1YpLNOdvycMWJzbBBXpCBOyIIH0yr/rIdFNTKwj2laletr0fFlgJa++YiRH0G1/ivubaaIZbX3GmCRZLSbDYNsAt0vspKd2iRO8MBuMbeTKvDPsgZ5vvdJkQKIqsjMFX7Kw6BoIWyNlTGsPX6G9WBMl/p5gZyQXXp6FNyUXIlNeJTG/wKFyQas8bC71luezQKzkLQGOk/w7TaIvtaHWHTVPGebYKyQCSvuQ9uIybUTTyomkQh91EJlfztBr5+3pw/VnVetX6GurV2QzfwroByV8BOYPiHSRAT2myjP79tlDMjNSwaX1dlIWEgnTOhHAv6WrndjW4iPuxpUOG7Q+UdbgGS6kiUapQIcqv9UhCrhIaQzrDhZRPMh9wY6Zn/0KUmczDWo775VQ6P5POGBU5kWUTiixq9632LsCgXfQtTHSiijq+RvecB8Px/J994+GbtEkn7yo3fH99faZCOPzWqaxT8KTK3rr1bybgEl1WLnPy8sf08TnWZdw+RltExHlI6q6Ow5sPRqKLz01OtqATHOkljmheLmMaNJo+8WzNPqbVlQpl/R6WDN9Edo6EzdYgXwONcLc8s9983fbi38zehE+CtAj8xTRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(36756003)(6486002)(86362001)(31686004)(6506007)(110136005)(31696002)(71200400001)(508600001)(6512007)(66446008)(83380400001)(316002)(54906003)(2906002)(64756008)(44832011)(2616005)(38100700002)(122000001)(8936002)(186003)(5660300002)(26005)(8676002)(4326008)(76116006)(66946007)(91956017)(66556008)(66476007)(66574015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkpkbEZrMHJCTHJTNWY3U2t0QmI1bUN2Z1BKVmlYdXRTS2IrYU5PdTh4RmNu?=
 =?utf-8?B?MWJ5TjVRU1k0VE1UbVgrcFU3cG1mU0dRZnBjbXlIM1p0SXpXSFpxVU8vTGw2?=
 =?utf-8?B?QmtoNVZPU1ZJUkt4YkwxY0Z1MWJiNnorOUtkMnVOUDlhWVpvS3BLV1NoYVh3?=
 =?utf-8?B?ZG0rTEZ3V2tXMUh3SHcxcEFmQWJxUjVyK3hwbFhjY29SUEREOW5XbVBKVGg5?=
 =?utf-8?B?YW1UMUdGN09nQWhRSVRGWjRzbkNyVDVmdFd0cnNNZTVUVXpJakpIYWppZlFS?=
 =?utf-8?B?d0JHV1AwVlE1c2FRMVZEczdrQzBXUnFaSHBjdmdDQ2tjbFlWQzZudGNRQlFv?=
 =?utf-8?B?a3BUd2o1cVNVNlk0R3p4MWVwNGZnVmlscWFRMkJKVTZqdnl0aGxhVkIrNTNk?=
 =?utf-8?B?REZIWlFMZUdHT2huaEwrWG9td3pZdHpKa2pPVmN6NGtoQk5IUkdFU0dCOFln?=
 =?utf-8?B?ZmVuZlY2REdZSDZ5aFRaUjU3bnh0UVhtZHhwRnhsMXg5dTJmZi9maWtyeWhS?=
 =?utf-8?B?OGM5Z3d5SGVjL2Znd3VmdkhaOC83RmFWQldKdStUVVRxazAwNnhQZWtiNGZU?=
 =?utf-8?B?SG0zaXpZelRMZmJkY2F1REdDRWZPMXNmWkp1dG85Q1lhVTZSR0VUVDM3Q0R2?=
 =?utf-8?B?a2lqUjhtR29IdkR3L1QrMjJuMDN3UkFCZ1dyOVBnemRNeWJuNk9oOVc5dEUr?=
 =?utf-8?B?aGVJcnZjamcvb0FlZC9DOHVqeXdBTzZGMjlmeHR5ek1MYnNsZkRRZTNnbVR3?=
 =?utf-8?B?YVFTVktuVEVqNEMyUG02TUFNSEp6Ym1acjFVdkJKVDkrMWFtbjVaTGIwMXB6?=
 =?utf-8?B?UTR5MVNFdlZSVGlpY0tEMVhZeVRYQjFRcDdTbWtzZzREbkpxcnNZZjdxaEkv?=
 =?utf-8?B?OU9weDdjOHFWZVhBTTlibVpUSmZnbG0wbFpwZ2pQemo5Y3E4QUczV0Y2NUV0?=
 =?utf-8?B?cmpLaytiYXlvZU1kRFEzRVpZUEQyQ3NFOEZwa3pZSmVLOWpUOVhsallnNmhI?=
 =?utf-8?B?TFBXbU9oMVh2N0xwWGFHNyszZEtmejJITHhXc0U3dlp1UXpFYkVXZWZ4eENq?=
 =?utf-8?B?Z2lBMmhYY1Z4WUFpTVBGanV0cHU0dk1Pcm1jRTVYR1BzMUU3L016cmdCbm1X?=
 =?utf-8?B?bkxSbkg0UFYweXAwbzYwVExlUDZTNHBub2puNGg5eGQrOGJFV0Y5a2pzaXRB?=
 =?utf-8?B?TEJnTHlxb2NMYWgyaS81N1IwbkxTdU16QUJDZ0ZVaS9SdXRiK0pOVjNMbnVJ?=
 =?utf-8?B?NmQvY3cvcHhrVDF1MEcrYmI3MmJFaUFDQUw5aUZtSDBqY3F3SGVIcUt4TUp3?=
 =?utf-8?B?a2UvYnFFc0I4alJ2UU0xUFFlaVVxTTVqRjNCTEdlTGhqMEtTNm4wU2xrWXEz?=
 =?utf-8?B?NTBPWGJLM3hHQTNhUXgwRVNsZkxWMEVHU3BLT2k5czRFd1dTT0xJOW82Um9k?=
 =?utf-8?B?OEhBYk1rUjRlem1ZOFBGUWQyUmM5V2kyMlhTY0JRSWJSWTd6R2UwZXZ1Zzlv?=
 =?utf-8?B?TWJQZXVUc01zUlJlMFdrRzdIZElnMFlwL0tFcC9FQ2djbkpwbnpMemJ4UjQr?=
 =?utf-8?B?RXBFMzdHa2RjNlExLzdhMnl1eXR5UTkxeVRrei9NL2ozVE9DL01UamdleW1x?=
 =?utf-8?B?bzdDRk9wQXdtR1lJZjIwV2VmUHNpWDM0aXhobXNjWXU3VmVMRWhuSGxrKzRm?=
 =?utf-8?B?YkdOM24yMjh1NGVNRnkvdzNrYzBkNmVJU2dyeXRmeHp6MkVkVnJWOHY1WXF6?=
 =?utf-8?B?WlM5cFFMaHJYR2FmTGQxbjB6NmhJZ3hkWkxIMnRpNFIrZmt4MGxnZ3J5ZjdR?=
 =?utf-8?B?YUNmcUErUGI5b082MmxicUZCOHVROTY0dDFzUE1yQncxbEorN0xTMEUxKzdj?=
 =?utf-8?B?K3RVUVJWUGxhMjgzQlpOckllcUxRNVVLb1NEMUF6czdzbTVLMlQ2TVlWQjIy?=
 =?utf-8?B?cjRzRERQVnZFS3dYVnhlQ0doUUpGaEF5TURSRDhOb1JLblZOUW1DdGxia3pw?=
 =?utf-8?B?V0lqTi9jR1hkQlUrSXNKZE85Z044cWo2STZTdW10amxWMWNRejhkNy9qSkVF?=
 =?utf-8?B?SGJJaERSa3pLclJRYTU0OVl0UHRDSm4xb09nS3ZzSk5wL3pxSlIrcHZicU8w?=
 =?utf-8?B?MmhtL0FQcXhVaHlnOHVCWExYWW5seFV5Vk9WaVQzaCtrMjFlemI3Y0c1OGwy?=
 =?utf-8?B?MC9STG42ajNwWnNlTmRTa2d6WUhaamJrU3BkNUFNU3J3b0hPMlZ2U21EL3N4?=
 =?utf-8?Q?zZdFWezdAwj+TRgd1JhVQ44EvpEKv05oA/CboBHKu8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7B7E33641CAAC45A7136DAB105E11EA@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bde3a243-4f1a-4562-4155-08d9efca5fa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 14:57:51.6159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y8/263wubwbfOAnSD/fY79fqID7UbS6WHreBMctw4e5aWWDQx4IYhHK5BRuwBiDMAQThAyHwPwB9O7JalvO8GJOXYjIEgMhAC1K5YCZj7qQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB4368
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE0LzAyLzIwMjIgw6AgMTU6MDAsIERhdmlkIExhaWdodCBhIMOpY3JpdMKgOg0KPiBG
cm9tOiBDaHJpc3RvcGhlIExlcm95DQo+PiBTZW50OiAxNCBGZWJydWFyeSAyMDIyIDEzOjIxDQo+
Pg0KPj4gTGUgMTQvMDIvMjAyMiDDoCAxMjozMSwgRGF2aWQgTGFpZ2h0IGEgw6ljcml0wqA6DQo+
Pj4gRnJvbTogQW5zaHVtYW4gS2hhbmR1YWwNCj4+Pj4gU2VudDogMTQgRmVicnVhcnkgMjAyMiAw
OTo1NA0KPj4+IC4uLg0KPj4+Pj4gV2l0aCAtV2lubGluZSwgR0NDIHRlbGxzOg0KPj4+Pj4NCj4+
Pj4+IAkvaW5jbHVkZS9saW51eC90aHJlYWRfaW5mby5oOjIxMjoyMDogd2FybmluZzogaW5saW5p
bmcgZmFpbGVkIGluIGNhbGwgdG8gJ2NvcHlfb3ZlcmZsb3cnOiBjYWxsDQo+Pj4+IGlzIHVubGlr
ZWx5IGFuZCBjb2RlIHNpemUgd291bGQgZ3JvdyBbLVdpbmxpbmVdDQo+Pj4+Pg0KPj4+Pj4gY29w
eV9vdmVyZmxvdygpIGlzIGEgbm9uIGNvbmRpdGlvbmFsIHdhcm5pbmcgY2FsbGVkIGJ5DQo+Pj4+
PiBjaGVja19jb3B5X3NpemUoKSBvbiBhbiBlcnJvciBwYXRoLg0KPj4+Pj4NCj4+Pj4+IGNoZWNr
X2NvcHlfc2l6ZSgpIGhhdmUgdG8gcmVtYWluIGlubGluZWQgaW4gb3JkZXIgdG8gYmVuZWZpdA0K
Pj4+Pj4gZnJvbSBjb25zdGFudCBmb2xkaW5nLCBidXQgY29weV9vdmVyZmxvdygpIGlzIG5vdCB3
b3J0aCBpbmxpbmluZy4NCj4+Pj4+DQo+Pj4+PiBVbmlubGluZSB0aGUgd2FybmluZyB3aGVuIENP
TkZJR19CVUcgaXMgc2VsZWN0ZWQuDQo+Pj4+Pg0KPj4+Pj4gV2hlbiBDT05GSUdfQlVHIGlzIG5v
dCBzZWxlY3RlZCwgV0FSTigpIGRvZXMgbm90aGluZyBzbyBza2lwIGl0Lg0KPj4+Pj4NCj4+Pj4+
IFRoaXMgcmVkdWNlcyB0aGUgc2l6ZSBvZiB2bWxpbnV4IGJ5IGFsbW9zdCA0a2J5dGVzLg0KPj4+
Pg0KPj4+DQo+Pj4+PiArdm9pZCBfX2NvcHlfb3ZlcmZsb3coaW50IHNpemUsIHVuc2lnbmVkIGxv
bmcgY291bnQpOw0KPj4+Pj4gKw0KPj4+Pj4gICAgc3RhdGljIGlubGluZSB2b2lkIGNvcHlfb3Zl
cmZsb3coaW50IHNpemUsIHVuc2lnbmVkIGxvbmcgY291bnQpDQo+Pj4+PiAgICB7DQo+Pj4+PiAt
CVdBUk4oMSwgIkJ1ZmZlciBvdmVyZmxvdyBkZXRlY3RlZCAoJWQgPCAlbHUpIVxuIiwgc2l6ZSwg
Y291bnQpOw0KPj4+Pj4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfQlVHKSkNCj4+Pj4+ICsJCV9f
Y29weV9vdmVyZmxvdyhzaXplLCBjb3VudCk7DQo+Pj4+PiAgICB9DQo+Pj4NCj4+Pj4gSnVzdCB3
b25kZXJpbmcsIGlzIHRoaXMgdGhlIG9ubHkgc3VjaCBzY2VuYXJpbyB3aGljaCByZXN1bHRzIGlu
DQo+Pj4+IGFuIGF2b2lkYWJsZSBibG9hdGVkIHZtbGludXggaW1hZ2UgPw0KPj4+DQo+Pj4gVGhl
IG1vcmUgaW50ZXJlc3RpbmcgcXVlc3Rpb24gaXMgd2hldGhlciB0aGUgY2FsbCB0byBfX2NvcHlf
b3ZlcmZsb3coKQ0KPj4+IGlzIGFjdHVhbGx5IHNpZ25pZmljYW50bHkgc21hbGxlciB0aGFuIHRo
ZSBvbmUgdG8gV0FSTigpPw0KPj4+IEFuZCBpZiBzbyB3aHkuDQo+Pj4NCj4+IHVuc2lnbmVkIGxv
bmcgdHN0X2NvcHlfdG9fdXNlcih2b2lkIF9fdXNlciAqdG8sIHVuc2lnbmVkIGxvbmcgbikNCj4+
IHsNCj4+IAlyZXR1cm4gY29weV90b191c2VyKHRvLCAmamlmZmllc182NCwgbik7DQo+PiB9DQo+
Pg0KPj4gV2l0aCB0aGUgcGF0Y2g6DQo+Pg0KPj4gMDAwMDNjNzggPHRzdF9jb3B5X3RvX3VzZXI+
Og0KPj4gICAgICAgM2M3ODoJMjggMDQgMDAgMDggCWNtcGx3aSAgcjQsOA0KPj4gICAgICAgM2M3
YzoJN2MgODUgMjMgNzggCW1yICAgICAgcjUscjQNCj4+ICAgICAgIDNjODA6CTQxIDgxIDAwIDEw
IAliZ3QgICAgIDNjOTAgPHRzdF9jb3B5X3RvX3VzZXIrMHgxOD4NCj4+ICAgICAgIDNjODQ6CTNj
IDgwIDAwIDAwIAlsaXMgICAgIHI0LDANCj4+IAkJCTNjODY6IFJfUFBDX0FERFIxNl9IQQlqaWZm
aWVzXzY0DQo+PiAgICAgICAzYzg4OgkzOCA4NCAwMCAwMCAJYWRkaSAgICByNCxyNCwwDQo+PiAJ
CQkzYzhhOiBSX1BQQ19BRERSMTZfTE8JamlmZmllc182NA0KPj4gICAgICAgM2M4YzoJNDggMDAg
MDAgMDAgCWIgICAgICAgM2M4YyA8dHN0X2NvcHlfdG9fdXNlcisweDE0Pg0KPj4gCQkJM2M4Yzog
Ul9QUENfUkVMMjQJX2NvcHlfdG9fdXNlcg0KPj4NCj4+ICAgICAgIDNjOTA6CTk0IDIxIGZmIGYw
IAlzdHd1ICAgIHIxLC0xNihyMSkNCj4+ICAgICAgIDNjOTQ6CTdjIDA4IDAyIGE2IAltZmxyICAg
IHIwDQo+PiAgICAgICAzYzk4OgkzOCA2MCAwMCAwOCAJbGkgICAgICByMyw4DQo+PiAgICAgICAz
YzljOgk5MCAwMSAwMCAxNCAJc3R3ICAgICByMCwyMChyMSkNCj4+ICAgICAgIDNjYTA6CTkwIDgx
IDAwIDA4IAlzdHcgICAgIHI0LDgocjEpDQo+PiAgICAgICAzY2E0Ogk0OCAwMCAwMCAwMSAJYmwg
ICAgICAzY2E0IDx0c3RfY29weV90b191c2VyKzB4MmM+DQo+PiAJCQkzY2E0OiBSX1BQQ19SRUwy
NAlfX2NvcHlfb3ZlcmZsb3cNCj4+ICAgICAgIDNjYTg6CTgwIGExIDAwIDA4IAlsd3ogICAgIHI1
LDgocjEpDQo+PiAgICAgICAzY2FjOgk4MCAwMSAwMCAxNCAJbHd6ICAgICByMCwyMChyMSkNCj4+
ICAgICAgIDNjYjA6CTdjIGEzIDJiIDc4IAltciAgICAgIHIzLHI1DQo+PiAgICAgICAzY2I0Ogk3
YyAwOCAwMyBhNiAJbXRsciAgICByMA0KPj4gICAgICAgM2NiODoJMzggMjEgMDAgMTAgCWFkZGkg
ICAgcjEscjEsMTYNCj4+ICAgICAgIDNjYmM6CTRlIDgwIDAwIDIwIAlibHINCj4+DQo+Pg0KPj4g
V2l0aG91dCB0aGUgcGF0Y2g6DQo+Pg0KPj4gMDAwMDNjODggPHRzdF9jb3B5X3RvX3VzZXI+Og0K
Pj4gICAgICAgM2M4ODoJMjggMDQgMDAgMDggCWNtcGx3aSAgcjQsOA0KPj4gICAgICAgM2M4YzoJ
N2MgODUgMjMgNzggCW1yICAgICAgcjUscjQNCj4+ICAgICAgIDNjOTA6CTQxIDgxIDAwIDEwIAli
Z3QgICAgIDNjYTAgPHRzdF9jb3B5X3RvX3VzZXIrMHgxOD4NCj4+ICAgICAgIDNjOTQ6CTNjIDgw
IDAwIDAwIAlsaXMgICAgIHI0LDANCj4+IAkJCTNjOTY6IFJfUFBDX0FERFIxNl9IQQlqaWZmaWVz
XzY0DQo+PiAgICAgICAzYzk4OgkzOCA4NCAwMCAwMCAJYWRkaSAgICByNCxyNCwwDQo+PiAJCQkz
YzlhOiBSX1BQQ19BRERSMTZfTE8JamlmZmllc182NA0KPj4gICAgICAgM2M5YzoJNDggMDAgMDAg
MDAgCWIgICAgICAgM2M5YyA8dHN0X2NvcHlfdG9fdXNlcisweDE0Pg0KPj4gCQkJM2M5YzogUl9Q
UENfUkVMMjQJX2NvcHlfdG9fdXNlcg0KPj4NCj4+ICAgICAgIDNjYTA6CTk0IDIxIGZmIGYwIAlz
dHd1ICAgIHIxLC0xNihyMSkNCj4+ICAgICAgIDNjYTQ6CTNjIDYwIDAwIDAwIAlsaXMgICAgIHIz
LDANCj4+IAkJCTNjYTY6IFJfUFBDX0FERFIxNl9IQQkucm9kYXRhLnN0cjEuNCsweDMwDQo+PiAg
ICAgICAzY2E4Ogk5MCA4MSAwMCAwOCAJc3R3ICAgICByNCw4KHIxKQ0KPj4gICAgICAgM2NhYzoJ
N2MgMDggMDIgYTYgCW1mbHIgICAgcjANCj4+ICAgICAgIDNjYjA6CTM4IDYzIDAwIDAwIAlhZGRp
ICAgIHIzLHIzLDANCj4+IAkJCTNjYjI6IFJfUFBDX0FERFIxNl9MTwkucm9kYXRhLnN0cjEuNCsw
eDMwDQo+PiAgICAgICAzY2I0OgkzOCA4MCAwMCAwOCAJbGkgICAgICByNCw4DQo+PiAgICAgICAz
Y2I4Ogk5MCAwMSAwMCAxNCAJc3R3ICAgICByMCwyMChyMSkNCj4+ICAgICAgIDNjYmM6CTQ4IDAw
IDAwIDAxIAlibCAgICAgIDNjYmMgPHRzdF9jb3B5X3RvX3VzZXIrMHgzND4NCj4+IAkJCTNjYmM6
IFJfUFBDX1JFTDI0CV9fd2Fybl9wcmludGsNCj4+ICAgICAgIDNjYzA6CTgwIGExIDAwIDA4IAls
d3ogICAgIHI1LDgocjEpDQo+PiAgICAgICAzY2M0OgkwZiBlMCAwMCAwMCAJdHd1aSAgICByMCww
DQo+PiAgICAgICAzY2M4Ogk4MCAwMSAwMCAxNCAJbHd6ICAgICByMCwyMChyMSkNCj4+ICAgICAg
IDNjY2M6CTdjIGEzIDJiIDc4IAltciAgICAgIHIzLHI1DQo+PiAgICAgICAzY2QwOgk3YyAwOCAw
MyBhNiAJbXRsciAgICByMA0KPj4gICAgICAgM2NkNDoJMzggMjEgMDAgMTAgCWFkZGkgICAgcjEs
cjEsMTYNCj4+ICAgICAgIDNjZDg6CTRlIDgwIDAwIDIwIAlibHINCj4gDQo+IEkgbWFrZSB0aGF0
IDMgZXh0cmEgaW5zdHJ1Y3Rpb25zLg0KPiBUd28gYXJlIG5lZWRlZCB0byBsb2FkIHRoZSBmb3Jt
YXQgc3RyaW5nLg0KPiBOb3Qgc3VyZSB3aHkgdGhlIHRoaXJkIGdldHMgYWRkZWQuDQoNClRoaXJk
IGluc3RydWN0aW9uIGlzICd0d3VpJywgdG8gJ3RyYXAnIGFuZCBnZXQgdGhlIHdhcm5pbmcgb29w
cy4NCg0KPiANCj4gTm90IHJlYWxseSBzaWduaWZpY2FudCBpbiB0aGUgMTItMTUgdGhlIGVycm9y
IGNhbGwgYWN0dWFsbHkgdGFrZXMuDQo+IEFsdGhvdWdoIGEgbG90IG9mIHRob3NlIGFyZSBqdXN0
IGdlbmVyYXRpbmcgdGhlIHN0YWNrIGZyYW1lDQo+IGluIG9yZGVyIHRvIGNhbGwgdGhlIGVycm9y
IGZ1bmN0aW9uIC0gYW5kIHdvdWxkbid0IGJlIHRoZXJlIGluDQo+IGEgbGVzcyB0cml2aWFsIGV4
YW1wbGUuDQoNCg0KWWVzLCBhZnRlciBsb29raW5nIG9uY2UgbW9yZSwgbWF5YmUgbWFraW5nIGl0
IF9fYWx3YXlzX2lubGluZSB3b3VsZCBiZSANCmVub3VnaC4NCg0KVGhlIHN0YXJ0aW5nIHBvaW50
IHdhcyB0aGF0IEkgZ290IGFsbW9zdCA1MCB0aW1lcyBjb3B5X292ZXJmbG93KCkgaW4gbXkgDQp2
bWxpbnV4LCBlYWNoIGhhdmluZyBpdHMgb3duIGZvcm1hdCBzdHJpbmcgYXMgd2VsbC4NCg0KU28g
bXkgcGF0Y2ggcmVkdWNlZCB2bWxpbnV4IHNpemUgYnkgMzkwOCBieXRlcy4NCg0KQnV0IHdpdGgg
X19hbHdheXNfaW5saW5lIEkgZ2V0IGEgcmVkdWN0aW9uIGJ5IDM1NjAgd2hpY2ggaXMgYWxtb3N0
IHRoZSBzYW1lLg0KDQpTbyBpZiB5b3UgcHJlZmVyLCBJIGNhbiBqdXN0IG1ha2UgY29weV9vdmVy
ZmxvdygpIF9fYWx3YXlzX2lubGluZSBhbmQgdm9pbGEuDQoNCg0KPiANCj4gTW9yZSBpbnRlcmVz
dGluZyB3b3VsZCBiZSBjaGFuZ2luZyBjb3B5X292ZXJmbG93KCkgdG8gcmV0dXJuIHRoZSBzaXpl
Lg0KPiBTbyBjb3B5X3RvX3VzZXIoKSBiZWNvbWVzOg0KPiANCj4gCWlmIChzaXplX3ZhbGlkKCkp
DQo+IAkJcmV0dXJuIF9jb3B5X3RvX3VzZXIoKTsNCj4gCXJldHVybiBjb3B5X292ZXJmbG93KCkN
Cg0KWWVzIHRoYXQncyBzb21ldGhpbmcgdG8gdHJ5LCBhbGx0aG91Z2ggaXQgbWVhbnMgY2hhbmdp
bmcgYWxsIGNhbGxlcnMgb2YgDQpjaGVja19jb3B5X3NpemUoKQ0KDQpDaHJpc3RvcGhl
