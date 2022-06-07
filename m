Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A4D53B92A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiFBMus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiFBMuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:50:44 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120078.outbound.protection.outlook.com [40.107.12.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F13D8CB3D;
        Thu,  2 Jun 2022 05:50:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOjWh8tcEPN9c7iuZYQcRNLASQhpWSyAz33vgxWR5VILMbCua6votkBY1X+3dlEsHVrHiJsa0nd4lEXYSZjbn0OyGwauwHITsxKEqmFA5poRcUUBgDDFYbuotJzi1F+SCyuAvBWWlwGVODYK42kZn/8QeBjpAJwIxM0tD7EW4GP6URwY+rhg1VndD6E2peCCVcXimayLPL1Ygoh7z4jYhVcOIYiz7iHIDxD1dhpd9C3y2CtBaILO3PlL+DJoHe32JVhUP1gNdlvtmoe5cUDC95bAGO8VygZlosqD+/wFSASwkWJIyxf+0QD7/pxm2UzArvqbt3mg3ZPoYabqhIS7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZG107phFFLeubObwgtm2R0ts9AgDuQURdPKUo4TVfE=;
 b=KW0N50dviR1tZ6RW6kuBCijnuSnAH+w9TFbVyQ0zokhPhs0YkgF//izNYw6THjg45s8gGee+uxsyZvB3j9Gr/Mo2jmqXh4rGpo9t7uw14ZJzVTBjnfJhipEb/KmL7n2GE5d0WIqyqH31bA2gQHeTdOsip7wWhkg3RiJoAeEf/lql545Kv7pRucaHoC9d4gM2uRCUwcs8DvLqOXEZ56t+oomd5XBRuwVgBU/Zojb54Gs4OZoqtkBH47RncQ36HvX+tBo+7KNEA+9hyR4w2zo3AAJLuvjYHbBuWptq6IcqzzJFJnVrGmFkddqpoi0bSysSzwedB+7YM0IfbuquXTvJEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZG107phFFLeubObwgtm2R0ts9AgDuQURdPKUo4TVfE=;
 b=MbU0Fb68Lbtr5tsP2bE5jN9GtjJf82pt64Hkl73ZWGLHNIZ2aaLX4GViP2ptSeXDOqjcCf+89dBbkDkt447axlkOU/mTWR0E45P4YBXZSVGE0MMo8ndsYA5S4ABZwANpCFq8gKwgIZ5qKFcwQwCdxpZoD3UinfpnISNQZOL+ikTfy3VZ/R1bPykh+XIT2ndQ7VIRG4LnCQBspNIWlYhH8y9dX1Sj0pDAhhyAqV/RjPV+pTbEr90SKhjZVi6u3az7DUO4mZZcM3lT1JfoCS6zaNK9bu7rrDj6llajepbO6HUeyfSS2wzFfwH8lzcoePYwRwm2v98eF5X4XlZA2Wp5Pw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB3925.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:250::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 12:50:40 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356%6]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 12:50:39 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Petr Mladek <pmladek@suse.com>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] livepatch: Remove klp_arch_set_pc() and asm/livepatch.h
Thread-Topic: [PATCH] livepatch: Remove klp_arch_set_pc() and asm/livepatch.h
Thread-Index: AQHYQmzcVzwq4WZnpECFcLJ2vYLmSKzWOdSAgFYkdQCAAIzGgIAPjtCA
Date:   Thu, 2 Jun 2022 12:50:39 +0000
Message-ID: <0a76550d-008d-0364-8244-4dae2981ea05@csgroup.eu>
References: <e029c7cfde436f6bbf99148ab14dc2da99add503.1648447981.git.christophe.leroy@csgroup.eu>
 <YkLsEUgxJkYbLZ7Z@alley> <e1840187-6032-9f75-d7a8-b2b2fc5cbb58@csgroup.eu>
 <YoulGX1p82IoEzST@alley>
In-Reply-To: <YoulGX1p82IoEzST@alley>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9785ae97-878a-4036-2489-08da44967f69
x-ms-traffictypediagnostic: PR1P264MB3925:EE_
x-microsoft-antispam-prvs: <PR1P264MB392548C551129C1F0764D0BFEDDE9@PR1P264MB3925.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VMuhAhoWlIiqLJ9ZmgRXP4cqNG9BuNjEVY83OsE4GBi8RKMxdUwuaV4YAXxeexbjI0HE/lHGanRPmGWC5Aq0symmi9/LXG0p04Jz9ZHGlKEpnIrQeWnbBGQLxf1jTXSrYhoW0vUckzoFva0oIRNKgyLltbpu3UU9e7fwHQpBAx1nwSbp9B4zEtNSyDAGU2v2WenxhCSVuAMxqodr+Yn60nwGluAq/MRMMw8E4+bmFe25XtMFpWdbHapegRXWh9NsR0FjgM09he85QoIdp4AEhvnahvLL9iajhU8uv0yzCzP3clxjioUAOgjEIYWwaK4HqTiZ2Ji3ywrhUUCeS5kQSnTAWk56qO/WAd4zB4rjoCHUnGXx6wHs6vV4YnOs79rC6dt40o2HFcsL/2PWe0OAfMS3HAKhymxG5g81oULru/cib2jgcW0PbUKGJkYPRJmdYdDuJ7FAmIJgqhU0tRAYjxE5H4nD7qneA+89UqWQEymM5bLQgYQ/oS4G6/OnotJJeUePwArnmHe5t8qymUW8sZ3TAQVBwFf3m5TAuXoLpofvF9SblUjG35VGBYDE8vl6DZH82hbsoBsUOaXMzXVm6sUeczw5xMyN8LaRPAmJkTqhKUrBtk8975DxbpnrEMOWb2WCnQxB9mor/4Rj3meaeeQE1KsCxcg4lkG1RXBiDMKidfKd+TA62dj+nzIXG18+lqQXvJNb2sAB+G5wNj/nd/6xtnTo8ab/ulsW28YlljCVVQNOh2v57RJqWKjCVy/e5tZKN5jhHzanEdbTTm+hFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(44832011)(64756008)(6486002)(8676002)(4326008)(122000001)(7416002)(66946007)(38070700005)(38100700002)(8936002)(5660300002)(71200400001)(2906002)(66476007)(6506007)(508600001)(54906003)(6512007)(76116006)(26005)(6916009)(83380400001)(91956017)(2616005)(316002)(66574015)(186003)(36756003)(31686004)(31696002)(86362001)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUttdGVSZHpIL0N0L0V6Vlh5a0tyYlhWUW13aVovZnA3dzBSRzRSMnZSelNw?=
 =?utf-8?B?NmFXcXI5N2Jwd3lkM3kwanZoZnBMQkdSNHY5b2NWeDNOVWMyY0pJNmhDdTlv?=
 =?utf-8?B?T1QrQzJWTWlXbFlTcDRNZk0xR2ZpMjJ2S3R4Mld4bWtSdkJKS0paVmtkT294?=
 =?utf-8?B?alRtbS9CelhYdmpzTEMvL090M3RoVUVVS2lCdjZZT1ZENXpheTB6em5NT3dI?=
 =?utf-8?B?ZThjd2ZUR1lIeGQyYjB2YW5zcWxuSVhzQUJhV0Z0bVlacHlxb2lsTTdjZmhw?=
 =?utf-8?B?QTJsd21mY2FlOHNDMU9FQW1VMFFTRlJwOWl4YjR3dDJLQ3k1NWNZN2NqZnBK?=
 =?utf-8?B?bjZzdXhYdENsODZkOElkTlNxYjhacU0yZmJQL0ZVVTVYVHhRWDMyYWxtNkFT?=
 =?utf-8?B?ZUVvVGYzYTQ4WkdYdUF2RlRUbmFsRlI0cWdKcWJhempyUUpTay9DRDVqQVpK?=
 =?utf-8?B?UTJFd2hhSVlHZk5xZTNzNTM1dUd6MlV6YXY3c3A2UWtpLzY2S3Ezc1lNQ3hD?=
 =?utf-8?B?WExhSlpMM0pqK0pZWHJIbndaalFQV0wxQU5GWENjMmRYL1Z1SzJqWFVLc0Nj?=
 =?utf-8?B?d0RrSW1DN0hwYndkNmgwMnRpaDNXNE4zcVVGTml6a3MzRUVmM0MySWtGU1VL?=
 =?utf-8?B?cllLSVhXMjlkNEhNUy9MRzkzRVY5R3NuUmJEelBSK0dSRmxsM3Bhc1FtcWha?=
 =?utf-8?B?VFJEVEJtSldoZ3RTK3EvN0k1b2VqK1JPN2NBckM3RGN1bHZwZ1BKVmd2c2s1?=
 =?utf-8?B?eFcyWjZ3MDVvekwveEllVENGemdJUldDeDZmUDZweE15dHNWMjUvM1ZVOFFF?=
 =?utf-8?B?VVFvVnJpVllFQWtxNmo0MVl3NFlvOXVXcXRPaGJsYzdRMSsyQ2pCRndRWFN3?=
 =?utf-8?B?dzdmSkMzNk52WkJzeFFUVkFBSXVYM3F3SnYwVU1CYVBCcDJIbWEydjFBMGw4?=
 =?utf-8?B?RDFSdWxlTmZPdkNnYkNtZzlYZGk3bmxWc3hPZUY0RjkvbHJxZkNDQitzSHFT?=
 =?utf-8?B?bzhMWmlRcXpRdFdOQ0lmMDVnTTJXdm5iOTlqMlppM3JpVUowMlRqRUtOa0ZT?=
 =?utf-8?B?Z2ZqTTdlZWI1QS9SeXhQRzl6WENCdDIrTzJZM2JSQ1d2UzhrSlB2TGcyS0R2?=
 =?utf-8?B?Q2pwelo4Z1A5VnJDK1J6NUhIRCtnb1FvdEhSV0s0RTUwQ0RzdGlkNFVnRnQv?=
 =?utf-8?B?VytraUtiZWhlOXNqR2E1MVJZNktMcjl6NU5qemdQY2V0TkQ5T3ZDeXF4MGVh?=
 =?utf-8?B?THN6UGRURFNrbWdNS1U3UjdabW5sTVhKUVNPRzQ2bVlJb0ZtblNPbW8xeTdh?=
 =?utf-8?B?YUgrWlNXQW5SN0pYbEtxVXpWWWo3cmVOTVFlU0hJUkxZanRoaXJZVmJBQk93?=
 =?utf-8?B?Ky9tVnhnMW55djFvYkRvVnJUdGVQWWM5cWlWRzBnTi9QdHdvMkNzNHJkUWMy?=
 =?utf-8?B?ajMzeWJZdFphS1YvRmI3aXJYN1J3cWFndnVjTTg3TVI0Zko1dFBaYjNScThE?=
 =?utf-8?B?N2RSTXRvVklWcEZoU1ZNaUxTTFFqeU9LK25VWkFtbUVNUFBJdG15bzhJbDlp?=
 =?utf-8?B?MjI4MURJVkxnZXRJUUR4a3YwWm9MTTllWktNNUhMZ0N0Q0dMa0NQVHZEM3dX?=
 =?utf-8?B?Rm1FaEFQNGE4RGNWTlRrS044eXl4QVo4SFpsYllFS3cwekNObHJaN2d0OFh3?=
 =?utf-8?B?MldoeW0wVHJCVGUvaGNjUWhSSHZEbitMcTQwSkRCcXhYTzlhNnRCdlJ2RkVO?=
 =?utf-8?B?M2c1OUZETnk3VnNkYXYyeitFT3psMHI5UE9NTlloS2xzL2p2U2FHU1ZjVkhK?=
 =?utf-8?B?cjBVcXpia3hmeHA5L0pFNWZ0eE03MjdvTFJMT2I2WkowU1c3VVdoWkswSldq?=
 =?utf-8?B?QUQzVFE5WXhTR05JbEU4NHJQKzRjMkpBSFpOTi8xbWJnek1VTXhSUWtFV0t6?=
 =?utf-8?B?WXlnTjhZYnBUOGdZNmxpS1BibHVUVFRrRjBRTTZHazlVbnZNY0w2WGtzVjVB?=
 =?utf-8?B?VzBNOGp4NXdta1RCek9TU1B4WDBBYkErNzFvbW9FbU8rNVdsL0EzT1JPU0pT?=
 =?utf-8?B?ZytGajljODNSQi9nU1RDQ1ZPSXJ4c1ZibDh6UnhSRlJ6OTFYZTFJV2ZPTW1x?=
 =?utf-8?B?RmpuWmNrRiszNWxtQzVnZ1pPamdZcG12RndvVktTanY5T3QrRmIrK1JqU2p5?=
 =?utf-8?B?MnFRMVQxZG1DVVBJZE12OTN0ckpnT2dPaTUreE5Ia2tiTVk5eWJIc2pWT3B0?=
 =?utf-8?B?WHhaMktVNVlxY09LVlprMmozSjV3Q3RIZ2MwNHgwNmMxY2JPczJPUE90SE9B?=
 =?utf-8?B?QnU3OXhYdUJDRXRvSmNhMDBXR0NnU0tLVW9aZjZmait1WktDdWJLVkpCSjcz?=
 =?utf-8?Q?2HWmMk1EcwOLzzq4a6x1vgSYHJ8eZ/fBWV9Ox?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B108D3FD38046145AFAD7916A1D6331D@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9785ae97-878a-4036-2489-08da44967f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 12:50:39.9570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/M+y0QZula+Lhluxn2LAoU0kq2GFm6kazBkuVuKzt2V8EUlxis0absFI7B0MKQvo+sAGJ75lZ2jsYefJS7NZBtY1s353mZikKL2ZTm+QFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3925
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGV0ciwNCg0KTGUgMjMvMDUvMjAyMiDDoCAxNzoxNSwgUGV0ciBNbGFkZWsgYSDDqWNyaXTC
oDoNCj4gT24gTW9uIDIwMjItMDUtMjMgMDY6NTE6NDcsIENocmlzdG9waGUgTGVyb3kgd3JvdGU6
DQo+Pg0KPj4NCj4+IExlIDI5LzAzLzIwMjIgw6AgMTM6MjIsIFBldHIgTWxhZGVrIGEgw6ljcml0
wqA6DQo+Pj4gT24gTW9uIDIwMjItMDMtMjggMDg6MjY6NDgsIENocmlzdG9waGUgTGVyb3kgd3Jv
dGU6DQo+Pj4+IEFsbCB0aHJlZSB2ZXJzaW9ucyBvZiBrbHBfYXJjaF9zZXRfcGMoKSBkbyBleGFj
dGx5IHRoZSBzYW1lOiB0aGV5DQo+Pj4+IGNhbGwgZnRyYWNlX2luc3RydWN0aW9uX3BvaW50ZXJf
c2V0KCkuDQo+Pj4+DQo+Pj4+IENhbGwgZnRyYWNlX2luc3RydWN0aW9uX3BvaW50ZXJfc2V0KCkg
ZGlyZWN0bHkgYW5kIHJlbW92ZQ0KPj4+PiBrbHBfYXJjaF9zZXRfcGMoKS4NCj4+Pj4NCj4+Pj4g
QXMga2xwX2FyY2hfc2V0X3BjKCkgd2FzIHRoZSBvbmx5IHRoaW5nIHJlbWFpbmluZyBpbiBhc20v
bGl2ZXBhdGNoLmgNCj4+Pj4gb24geDg2IGFuZCBzMzkwLCByZW1vdmUgYXNtL2xpdmVwYXRjaC5o
DQo+Pj4+DQo+Pj4+IGxpdmVwYXRjaC5oIHJlbWFpbnMgb24gcG93ZXJwYyBidXQgaXRzIGNvbnRl
bnQgaXMgZXhjbHVzaXZlbHkgdXNlZA0KPj4+PiBieSBwb3dlcnBjIHNwZWNpZmljIGNvZGUuDQo+
Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVy
b3lAY3Nncm91cC5ldT4NCj4+Pg0KPj4+IEFja2VkLWJ5OiBQZXRyIE1sYWRlayA8cG1sYWRla0Bz
dXNlLmNvbT4NCj4+Pg0KPj4+IEkgYW0gZ29pbmcgdG8gdGFrZSBpdCB2aWEgbGl2ZXBhdGNoL2xp
dmVwYXRjaC5naXQgZm9yIDUuMTkuIFdlIGFyZQ0KPj4+IGFscmVhZHkgaW4gdGhlIG1pZGRsZSBv
ZiB0aGUgbWVyZ2Ugd2luZG93IGFuZCB0aGlzIGlzIG5vdCBjcml0aWNhbC4NCj4+Pg0KPj4NCj4+
IEkgaGF2ZW4ndCBzZWVuIGl0IGluIGxpbnV4LW5leHQuDQo+Pg0KPj4gRG8geW91IHN0aWxsIHBs
YW4gdG8gdGFrZSBpdCBmb3IgNS4xOSA/DQo+IA0KPiBUaGFua3MgYSBsb3QgZm9yIHBvaW50aW5n
IHRoaXMgb3V0LiBJIGhhdmUgY29tcGxldGVseSBmb3Jnb3QgYWJvdXQNCj4gdGhpcyBwYXRjaCAv
b1wNCj4gDQo+IEkgaGF2ZSBqdXN0IHB1c2hlZCBpdCBpbnRvIGxpdmVwYXRjaGluZy9saXZlcGF0
Y2hpbmcuZ2l0LA0KPiBicmFuY2ggZm9yLTUuMTkvY2xlYW51cC4NCj4gDQo+IEkgYW0gZ29pbmcg
dG8gY3JlYXRlIHB1bGwgcmVxdWVzdCBmb3IgNS4xOSBieSB0aGUgZW5kIG9mIHRoaXMgd2Vlaw0K
PiBhZnRlciBpdCBnZXRzIGEgc3BpbiBpbiBsaW51eC1uZXh0Lg0KPiANCg0KSSBjYW4ndCBzZWUg
aXQgeWV0IGluIGxpbnVzIG1haW5saW5lIHRyZWUuIEFueSBpc3N1ZSA/DQoNClRoYW5rcw0KQ2hy
aXN0b3BoZQ==
