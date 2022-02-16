Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CB54B7CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbiBPBoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:44:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244340AbiBPBo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:44:29 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2055.outbound.protection.outlook.com [40.107.113.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50BFF9F87
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:44:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZlHJO/dDBUG941Ehup7PxAzcfIqfuVggrC6Tabx9zW3BGfqXkB7nR0dn+xMALzluog59mV5o2Z/KKEb9RJYkkMS5A4Lb6PBrC6oSbmmUPwIvEOKJO5WAtTNe8jbAw/tMwH39Denw+prtEdAp3WkPq2s/cJ7PZSI37l7E+X9H+Z4se49dMaVHO/KGmtnlGEElPa2EL9LECXI2W4Y4c1ohMyrT7NNQIlCQpCE63wSM7m63ZMX/Jp8q7ltIAkvrGizc0skA6b6hukRSYwc5fsCl++tHG3RUrqglBgazz06TJTY9cdKZTixhDm/rJh0OT1pHXK5PSPTTiparQiRRhgpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFs52DhMfiDZENVUAsebfFCTUyFJSNQhZ2xGNdXSwz0=;
 b=B5frJb8VgKWmS+glhHMu/YWhhHy+UG34Z8XmKulMHTJnH6UER7YDgerTWCuAln9Ln6nALPLo3fUFyf/yuc4ZRVQ8L8z+3olOGzDehcCkcqlKgreTb+ilP5h2UQkio21QDzlsayXrvdsLAbpDbAlrM5wLsgl24J51N08sODcs789x5xw206SsrmUeRRR7DdUJvZTbp4T4yOcZBotNHoIe9Yr4704OSa8b1obL8KueWE95VnwofFhNZ5BuXPLHHJwpRj2Ab7u++l9Uy/c4ATD4LjNT4yA4weK8WcpYiXWUDgfTO0bjnGSJL0X/9nDDAcKbe4I128WNVWYJAn/BKfzU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFs52DhMfiDZENVUAsebfFCTUyFJSNQhZ2xGNdXSwz0=;
 b=WJvsEnAD6rdFkNgZ0nGAPmd53PivYd0LAgeWhoZt53uxDtuGDqNcVaTnVHAQ+dYKc7gJxIsJCBfsYq56hnHSKcfOlzy/iydvH/MDlUzxbpFcrSIzCVJTI9f0PShYBjLdsNEmWJA7NjIR2a3W9MTrcU9lWZacVHsZwwrJhl0EGZ4=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB2901.jpnprd01.prod.outlook.com (2603:1096:604:1d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 01:44:13 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b%4]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 01:44:13 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     luofei <luofei@unicloud.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hwpoison: In-use hugepage need filter judgement and
 filter return value should be consistent
Thread-Topic: [PATCH] mm/hwpoison: In-use hugepage need filter judgement and
 filter return value should be consistent
Thread-Index: AQHYHlynfb1BQ//iNUSEDyAAmKAuHqyVcKyA
Date:   Wed, 16 Feb 2022 01:44:13 +0000
Message-ID: <20220216014413.GA2233606@hori.linux.bs1.fc.nec.co.jp>
References: <20220210085846.902394-1-luofei@unicloud.com>
In-Reply-To: <20220210085846.902394-1-luofei@unicloud.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80b4ddf6-053f-4075-d9f2-08d9f0edd5fd
x-ms-traffictypediagnostic: OSBPR01MB2901:EE_
x-microsoft-antispam-prvs: <OSBPR01MB290109D233B4D173F7C8B9A8E7359@OSBPR01MB2901.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Sb/mBgO7ceP0NqQCfvFLSYQc7I1tST3/aiztlInVxhfBEqThEs29CS3V0qKe618J3AjmDUCIWSqXKDHhWstjct/Q+/UNzC3YqEv5V2bWpPH2qdQJJ43iOOLKgnDTRcPLbSSkGNFOY8pqBKyoC+xVdbG/rHPUtObbABbB/kW1WykVzUScgk6mzLBLaDW34qF0dVAn0ODvJua8QAsafim4XFxNRfzTjLAJcky5B3FQ0OWKEhPqFlP07AR99qtCJAHakZibqRvAm4V04PoB8QL7+hclLVcm3PNkjXKZEdV4UH/LXLxDB8ytCLdUrqPsR7GFdK4q1n3hd6ti9IqVStJ47NhPDyOYtwPxB8y1i0BV+4/sci8EM+IZ76zGCyf4ddO2yStoHD1xcCtaEv+o/JFw3NhdEGYxsQ1QktXY36+ihhkoFlqUhLoEJnNQeqBaEldMVkyI+trk7B55XmvUHDiZOLMGlYWIdnmrqryxJXhHJX/5VhZc34uUUfR/czmpSB9bsnTMgpSp2C96tD31zYw1TzTBb5gVuvPNg/4/msyc291HlVZIoN+crcNuiI86DwiSTJz8Dyzg2bDyweoTZj6QxCgN4J1Fal7P6yeAn2V/ISyKhE6B3KueG6INumg8A3+YhSMObgZjnHziQfq+T5wUPofWn0rYTSMMqTqScCzeXNCy/3yI1nepmNKXgzYx78+zIxg1L/BPrDaKqzjullqrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(8676002)(66446008)(6486002)(122000001)(6916009)(38070700005)(64756008)(4326008)(54906003)(85182001)(66556008)(66476007)(5660300002)(76116006)(8936002)(38100700002)(66946007)(316002)(71200400001)(82960400001)(83380400001)(6506007)(2906002)(9686003)(6512007)(55236004)(33656002)(508600001)(186003)(1076003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUVHQXBObEJkelFxdFJUQThMalFuS084RGpkUEhaa204WUtHM3VVTEFQQnNL?=
 =?utf-8?B?WFRFYTVTdml1ZllNVHlsRU8wZkh2SFBpUGdjNzhoczNrREFxUHJwTnEvN0J3?=
 =?utf-8?B?bHQ0WUdiVkF6d3BQNlJyZktvUWI2ZXErNE92bHpMQ1FJbFFMTm4xbTJNWjBa?=
 =?utf-8?B?bTFrNThwWjZkcTB0WkZCVXFPWjQrdURMclBDbHd3aytwdHFxdWFKcTJyejBG?=
 =?utf-8?B?NWlrUHBrbUE4NGY4Y2hsdWNzUmU3U2pOQndrdzFmUzNuRENxVDhacWNBMWZ1?=
 =?utf-8?B?ZllVTng1WU9IUGZrRjI0ek1EVEIyZmFSbzcxR0lTTFN6M2FwUkRJTi9CRTM5?=
 =?utf-8?B?RmxjNjhFTEVPQ2Z0YjV1czNBQUYxdGk3Ryt0NTRIbzZjVnZMQ1l1N1VKSkhL?=
 =?utf-8?B?ZzF3N3V5bFBDVS9wUWpiQnllN0daeXg5L043SWQ0VENHa2JUK0g2QS9qUG1p?=
 =?utf-8?B?emljOEcrLzh0Z1l6WkNUSktsK3R0cmQvczFNVDlWRzdUYndkemowa0pvSzdQ?=
 =?utf-8?B?UWxLWTdKcGVmMHh6WDlWQnQvV0k4TmZyMmJaakpqdmxSMzFFVmFhblkvVVY0?=
 =?utf-8?B?V2g4WEV3ZFNlTW1uclVsdHFXNVBkenlWSGZ3WmpEMVRBWk83YUtmaTJIZmZN?=
 =?utf-8?B?WjBuV0RneUZrT3JEb2F5eGUrUWZjYWF3aXozeXZ0QURaUFpGeEo2LzhhVTZ6?=
 =?utf-8?B?OXQ4bDdFSDdoY3E1clR2bEEyNXJ0ZVhmdjAwOEhxU1h1SnBaQ0dSMXhVZVdV?=
 =?utf-8?B?U2hMSWZCWUl2aDVPOU5jSXRsWmU3TFA0emFTdWZLTmxvUi9TRkVYZnBHNTIy?=
 =?utf-8?B?UFExZzhyMmZPalVrTXNzYkJQcnpvS0FTK0E0b09QSUFGWlNnbDVHUFVGV3Na?=
 =?utf-8?B?d0s4MGcrRzdVSGlFUjhtSmZxVXAzYVhtaXJoZnBEaWg3MEg1ZFdaZW5UaVl0?=
 =?utf-8?B?UkpvWkYrMXNoV2h3SE8zOTVKZnQ5ZFBRYWVXanM3NXYzZ05KaUhEWVZ3U2E3?=
 =?utf-8?B?RkM4cDFFdEpOUlBhOHJYNS96TFBzYWtBK2FxSVgzUDhpUXZ6TVZwSXoyRklS?=
 =?utf-8?B?UmM3K2RFQ0NvbDA1R3pEbDluOVNRdkVweW8xa0J2OWVMMC9nTGtpbUhLY2t1?=
 =?utf-8?B?YVFubFEwU1hxam5ZK1NhWG5PMC83ZUdoNHdHcjJ3T0JKRm1Tb3BpMVFEOWtJ?=
 =?utf-8?B?aXYzUHFuYk0xMnhzUmJNU282ZXdSVW8vL0xSc1lsRi9qSTY4RWtZRHpnMGdn?=
 =?utf-8?B?Y0ltYmY5YWdEYUVodk5jTEkwY1ZJMHF3dHRPYmEwVnNvRUxlbmtiQ3hVMGVn?=
 =?utf-8?B?T3dPckZYeExLUDB6Y25xMWd5Qmx1OWVwQmliRlhVeVZOcWJ5ODlNYUs3UWZX?=
 =?utf-8?B?QXF0ME00TVg4QWpsOFRXWUtuWCtHUmU2d2R3NnptVktuSkdUZDhxYlZjRk96?=
 =?utf-8?B?c3hxWjdQdlQvRFpBVWJsQjlIR3hwaWdaOWJhV3FuYTkwcXdyL3RsYlBtd3RF?=
 =?utf-8?B?NHRJOU91NlJseDZXNlRVa0l0OStHSTU2bVVjT1EwYmI3NUNhSStydVQ5aEdS?=
 =?utf-8?B?MW1TVUZVMzltczE0ejFYenVBeFJtTmFYV2krL1UxS2xWVlgxUWxaenJMa3NH?=
 =?utf-8?B?Vnlpa3dzaytEcUlUaDEvT2RnNnNEanVrbUFNVW55VVJOVDJwTk5PN1FKb1Z2?=
 =?utf-8?B?N2lTUnhYK2I5RlF0QnFjNVZ5NGlUdjBYeFppT0VzMHJCYTd2dU5mMjRja1dp?=
 =?utf-8?B?djYwS3o4bm91L3lrMGhMOUFtenhGU3lVclhUaFVKSXlvOE9wbStmL0ZOOWFr?=
 =?utf-8?B?ZVpCYU9YNjBKNjVnWHdaUGxzaFRMK1VRaFNZOGp4NnJzbjl3akNLZTlFMjN4?=
 =?utf-8?B?TXI0M0E5L0Ztc1JqZmVUR2tTdDFQMkYzcktlakFsT0NtczhZSEIxWUR3NWpQ?=
 =?utf-8?B?akVvSGVjL2tqajRSMDFobTJ0aldGS0pENlRlWEZ4cmFvU3hyNmFtRENrRURZ?=
 =?utf-8?B?cytMdFZxcS9RWVNyUzc3cDNFYXNld0U0S3JHeE9ONjhmTTd6eFA2cEpPNHhY?=
 =?utf-8?B?bkpHODRyMmw1eE1NZ21mVFI4aVRDdTJvQ0lrUmFicUsyVVZoTHZCSFQ1a0xY?=
 =?utf-8?B?Z2RYRzNWUGh0K3RBbUpURFQ5c21JbTFSbE0vNTZrMGNZcUpISjlYeWVVNk54?=
 =?utf-8?Q?jwK1L8CAqC82SdsOxgkPmev4TdtSg+UkLIWWPn9bejJk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E896ACAC5141343A08264B78AF605FE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b4ddf6-053f-4075-d9f2-08d9f0edd5fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 01:44:13.7109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zlPw+99+hwYhSa2UP3Otq4vHBD2HKUfBgrRQsc6K5Qu3ja0NVMuIqjVGAsw/BqhniezsIApyUlFU+x25XYeh/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2901
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBGZWIgMTAsIDIwMjIgYXQgMDM6NTg6NDZBTSAtMDUwMCwgbHVvZmVpIHdyb3RlOg0K
PiBBZnRlciBzdWNjZXNzZnVsbHkgb2J0YWluaW5nIHRoZSByZWZlcmVuY2UgY291bnQgb2YgdGhl
IGh1Z2UNCj4gcGFnZSwgaXQgaXMgc3RpbGwgbmVjZXNzYXJ5IHRvIGNhbGwgaHdwb2lzb25fZmls
dGVyKCkgdG8gbWFrZSBhDQo+IGZpbHRlciBqdWRnZW1lbnQsIG90aGVyd2lzZSB0aGUgZmlsdGVy
IHBhZ2Ugd2lsbCBiZSB1bm1hcGVkIGFuZA0KPiB0aGUgcmVsYXRlZCBwcm9jZXNzIG1heSBiZSBr
aWxsZWQuDQo+IA0KPiBBbHNvIHdoZW4gdGhlIGh1Z2UgcGFnZSBtZWV0cyB0aGUgZmlsdGVyIGNv
bmRpdGlvbnMsIGl0IHNob3VsZA0KPiBub3QgYmUgcmVnYXJkZWQgYXMgc3VjY2Vzc2Z1bCBtZW1v
cnlfZmFpbHVyZSgpIHByb2Nlc3NpbmcsIGJ1dA0KPiBzaG91bGQgcmV0dXJuIGFuIGVycm9yIGNv
ZGUgdG8gaW5mb3JtIHRoZSBjYWxsZXIsIG90aGVyd2lzZSB0aGUNCj4gY2FsbGVyIHJlZ2FyZHMg
dGhlIGVycm9yIHBhZ2UgaGFzIGJlZW4gaWRlbnRpZmllZCBhbmQgaXNvbGF0ZWQsDQo+IHdoaWNo
IG1heSBsZWFkIHRvIGNhbGxpbmcgc2V0X21jZV9ub3NwZWMoKSB0byBjaGFuZ2UgcGFnZSBhdHRy
aWJ1dGUuDQoNCkhpIGx1b2ZlaSwNCg0KSSBhZ3JlZSB3aXRoIGluc2VydGluZyBhbm90aGVyIGh3
cG9pc29uX2ZpbHRlcigpIGJsb2NrIHdoaWNoIHdhcw0Kc2ltcGx5IG1pc3NlZC4gVGhhbmtzIGZv
ciBwb2ludGluZyBpdCBvdXQuDQoNCj4gDQo+IE1lYW53aGlsZSwgd2hlbiBjYWxsaW5nIGh3cG9p
c29uX2ZpbHRlcigpIHRvIGRldGVybWluZSB0aGF0IGEgcGFnZQ0KPiBuZWVkcyB0byBiZSBmaWx0
ZXJlZCwgaXQgaXMgYmV0dGVyIHRvIGtlZXAgdGhlIHNhbWUgRUJVU1kgcmV0dXJuDQo+IHZhbHVl
LCBzbyB0aGF0IHRoZSBjYWxsZXIgY2FuIHJlY29nbml6ZSB0aGF0IG1lbW9yeV9mYWlsdXJlKCkg
ZGlkDQo+IG5vdCBzdWNjZXNzZnVsbHkgcHJvY2VzcyB0aGUgZXJyb3IgcGFnZS4NCg0KSUlSQywg
aHdwb2lzb25fZmlsdGVyKCkgaXMgZXhwZWN0ZWQgdG8gaWdub3JlIGVycm9yIGV2ZW50cyBvbg0K
aXJyZWxldmFudCB0YXJnZXQgKHBhZ2V8ZGV2aWNlfGNncm91cCkgZm9yIHRlc3RlcnMgdG8gZm9j
dXMgb24NCm5vbi1maWx0ZXJlZCBldmVudHMuICBTbyBmaWx0ZXJlZCBldmVudHMgc2hvdWxkIG5v
dCBiZSBjb25zaWRlcmVkDQphcyBlcnJvci1oYW5kbGluZyBmYWlsdXJlcyAob3RoZXJ3aXNlIHRl
c3RlcnMgY2FuJ3QgZWFzaWx5DQpkaXN0aW5ndWlzaCB0aGVtIGZyb20gcmVhbCBlcnJvci1oYW5k
bGluZyBmYWlsdXJlcykuDQoNCkJ1dCB5ZXMsIHRoZSBNQ0UgaGFuZGxlciBkZXBlbmRzIG9uIHRo
ZSByZXR1cm4gdmFsdWUgb2YgbWVtb3J5X2ZhaWx1cmUoKSwNCnNvIGZpbHRlcmVkIGV2ZW50cyBz
aG91bGRuJ3QgYmUgY29uc2lkZXJlZCBhcyBlcnJvci1oYW5kbGluZydzIHN1Y2Nlc3Nlcy4NClNv
IG9uZSBwb3NzaWJsZSBhcHByb2FjaCBpcyB0aGF0IHdlIGludHJvZHVjZSBhIG5ldyBtZl9mbGFn
cyB0byBzaG93IHRoYXQNCm1lbW9yeV9mYWlsdXJlKCkgaXMgY2FsbGVkIGZyb20gTUNFIGhhbmRs
ZXIgKG5vdCBmcm9tIGh3cG9pc29uIGluamVjdG9yKSwNCmFuZCB3ZSBzd2l0Y2ggcmV0dXJuIGNv
ZGUgd2hlbiBod3BvaXNvbl9maWx0ZXIgZmFpbGVkIGJ5IHRoaXMgZmxhZy4NCkNvdWxkIHlvdSB0
cnkgaXQgaWYgdGhpcyBhcHByb2FjaCB3b3JrcyBmb3IgeW91PyAgT3IgaWYgeW91IGhhdmUgYW55
IGJldHRlcg0KaWRlYSwgZmVlbCBmcmVlIHRvIHNoYXJlIGl0Lg0KDQpUaGFua3MsDQpOYW95YSBI
b3JpZ3VjaGkNCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogbHVvZmVpIDxsdW9mZWlAdW5pY2xvdWQu
Y29tPg0KPiAtLS0NCj4gIG1tL2h3cG9pc29uLWluamVjdC5jIHwgIDIgKy0NCj4gIG1tL21lbW9y
eS1mYWlsdXJlLmMgIHwgMTIgKysrKysrKysrKy0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDExIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbW0vaHdwb2lz
b24taW5qZWN0LmMgYi9tbS9od3BvaXNvbi1pbmplY3QuYw0KPiBpbmRleCBhZmY0ZDI3ZWMyMzUu
LjRlY2Q3N2NkMWRlZCAxMDA2NDQNCj4gLS0tIGEvbW0vaHdwb2lzb24taW5qZWN0LmMNCj4gKysr
IGIvbW0vaHdwb2lzb24taW5qZWN0LmMNCj4gQEAgLTQ0LDcgKzQ0LDcgQEAgc3RhdGljIGludCBo
d3BvaXNvbl9pbmplY3Qodm9pZCAqZGF0YSwgdTY0IHZhbCkNCj4gIAkgKi8NCj4gIAllcnIgPSBo
d3BvaXNvbl9maWx0ZXIoaHBhZ2UpOw0KPiAgCWlmIChlcnIpDQo+IC0JCXJldHVybiAwOw0KPiAr
CQlyZXR1cm4gLUVCVVNZOw0KPiAgDQo+ICBpbmplY3Q6DQo+ICAJcHJfaW5mbygiSW5qZWN0aW5n
IG1lbW9yeSBmYWlsdXJlIGF0IHBmbiAlI2x4XG4iLCBwZm4pOw0KPiBkaWZmIC0tZ2l0IGEvbW0v
bWVtb3J5LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gaW5kZXggOTdhOWVkOGY4
N2E5Li5hY2Y5N2ZiMjY1OWEgMTAwNjQ0DQo+IC0tLSBhL21tL21lbW9yeS1mYWlsdXJlLmMNCj4g
KysrIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiBAQCAtMTUyNiw3ICsxNTI2LDcgQEAgc3RhdGlj
IGludCBtZW1vcnlfZmFpbHVyZV9odWdldGxiKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3Mp
DQo+ICAJCQkJaWYgKFRlc3RDbGVhclBhZ2VIV1BvaXNvbihoZWFkKSkNCj4gIAkJCQkJbnVtX3Bv
aXNvbmVkX3BhZ2VzX2RlYygpOw0KPiAgCQkJCXVubG9ja19wYWdlKGhlYWQpOw0KPiAtCQkJCXJl
dHVybiAwOw0KPiArCQkJCXJldHVybiAtRUJVU1k7DQo+ICAJCQl9DQo+ICAJCQl1bmxvY2tfcGFn
ZShoZWFkKTsNCj4gIAkJCXJlcyA9IE1GX0ZBSUxFRDsNCj4gQEAgLTE1NDUsNiArMTU0NSwxMyBA
QCBzdGF0aWMgaW50IG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGIodW5zaWduZWQgbG9uZyBwZm4sIGlu
dCBmbGFncykNCj4gIAlsb2NrX3BhZ2UoaGVhZCk7DQo+ICAJcGFnZV9mbGFncyA9IGhlYWQtPmZs
YWdzOw0KPiAgDQo+ICsJaWYgKGh3cG9pc29uX2ZpbHRlcihwKSkgew0KPiArCQlpZiAoVGVzdENs
ZWFyUGFnZUhXUG9pc29uKGhlYWQpKQ0KPiArCQkJbnVtX3BvaXNvbmVkX3BhZ2VzX2RlYygpOw0K
PiArCQl1bmxvY2tfcGFnZShoZWFkKTsNCj4gKwkJcmVzID0gLUVCVVNZDQo+ICsJCWdvdG8gb3V0
Ow0KPiArCX0NCj4gIAkvKg0KPiAgCSAqIFRPRE86IGh3cG9pc29uIGZvciBwdWQtc2l6ZWQgaHVn
ZXRsYiBkb2Vzbid0IHdvcmsgcmlnaHQgbm93LCBzbw0KPiAgCSAqIHNpbXBseSBkaXNhYmxlIGl0
LiBJbiBvcmRlciB0byBtYWtlIGl0IHdvcmsgcHJvcGVybHksIHdlIG5lZWQNCj4gQEAgLTE2MTMs
NyArMTYyMCw3IEBAIHN0YXRpYyBpbnQgbWVtb3J5X2ZhaWx1cmVfZGV2X3BhZ2VtYXAodW5zaWdu
ZWQgbG9uZyBwZm4sIGludCBmbGFncywNCj4gIAkJZ290byBvdXQ7DQo+ICANCj4gIAlpZiAoaHdw
b2lzb25fZmlsdGVyKHBhZ2UpKSB7DQo+IC0JCXJjID0gMDsNCj4gKwkJcmMgPSAtRUJVU1k7DQo+
ICAJCWdvdG8gdW5sb2NrOw0KPiAgCX0NCj4gIA0KPiBAQCAtMTgzNyw2ICsxODQ0LDcgQEAgaW50
IG1lbW9yeV9mYWlsdXJlKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3MpDQo+ICAJCQludW1f
cG9pc29uZWRfcGFnZXNfZGVjKCk7DQo+ICAJCXVubG9ja19wYWdlKHApOw0KPiAgCQlwdXRfcGFn
ZShwKTsNCj4gKwkJcmVzID0gLUVCVVNZOw0KPiAgCQlnb3RvIHVubG9ja19tdXRleDsNCj4gIAl9
DQo+ICANCj4gLS0gDQo+IDIuMjcuMA==
