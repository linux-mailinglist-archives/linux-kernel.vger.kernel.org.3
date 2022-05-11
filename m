Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0678522E18
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242517AbiEKISy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243478AbiEKISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:18:47 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2040.outbound.protection.outlook.com [40.107.113.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274A6E5294
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c57olqj37nRIeR3JnZsrBw+/uFAkbBFRygtF8OATPfNabacDdzUuWHx3/7MHPvEzgeVFW6Q3d8Gwnb7x2kWrFGOYAWmIwfEoYgNWAFaUxii+4gJVmA5J2kIp9JzURC20IRqe5C+Ilc1SyzB4QQ0/SNR99ZoPisUdPhAJw912d+6A0i02JK0fjlQOZPLy0jEN+6Q0BZ9kdFpLUk2xJazn3cqcmxY9So7gbb7yg+p8D8bPZyV18N1YQL1Z5tX01IL0LqEudELlTqXaA3e1TZ0g6ymK1dEgy1ZmtMIE/8jWuhPfi9T+ZhKpS0+0G66KvDtDl83GfJOzvxk/RkNkIRP5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkJ5+89vozbTbXxhquitIgYWs0F4ZotaBbZngtusEqY=;
 b=JR6PeO4fAfkGjhVsNoNtcyA3KQVtHqUR2FY+wiEtLuG9M4lh5q7AawzrWpjJ6xumjNj9BsPpEx/pcpqby8Aqmq8FhgV38ud2/83SSIXSQ39h3C0e6htNbpUa5JCAUWWn2XtoGhpvv8v/Jt4LRv/D+FHqePOWPs4IPRqddD8ofJrF7tTCq1Q0D4wm+6uXpf9uWg1/KNl1xMhswwuIm5xFiskqInbp5jdzdi8fH1UwymazX7yx50JWchSJH7oy7YzUp1EMHSvX+suBqtBL+cU7smaZbVdvDdglE7Zl2w+Swoju3TtjTSP2rCQ5PphhN8PoJYBo3z2sXVXM58+MDaEdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkJ5+89vozbTbXxhquitIgYWs0F4ZotaBbZngtusEqY=;
 b=RqwEfU72d8cQcLv99tRPuDCWBPRi8f9y0yNi3uuZKUxC7uX9CUjnCkoL1a5cmNZhOkmxZ/0eHGMahbFAhn1qfqK4Ws/E/207R2jD/b3cLUedF59DaOuKKfw4+VPclRlYdgHWSmC7+AtkfRTFgMMVeRbphrbb5osjBaVae/GF3HY=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYWPR01MB9772.jpnprd01.prod.outlook.com (2603:1096:400:224::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 08:18:42 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 08:18:42 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] mm/memory-failure.c: add hwpoison_filter for soft
 offline
Thread-Topic: [PATCH v2 3/5] mm/memory-failure.c: add hwpoison_filter for soft
 offline
Thread-Index: AQHYY5Qa/g+4/gc4Kk6YZoMBiiXf0q0ZWEoA
Date:   Wed, 11 May 2022 08:18:42 +0000
Message-ID: <20220511081842.GA211620@hori.linux.bs1.fc.nec.co.jp>
References: <20220509105641.491313-1-pizhenwei@bytedance.com>
 <20220509105641.491313-4-pizhenwei@bytedance.com>
In-Reply-To: <20220509105641.491313-4-pizhenwei@bytedance.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 772249d4-2ae4-4d47-456e-08da3326dc8c
x-ms-traffictypediagnostic: TYWPR01MB9772:EE_
x-microsoft-antispam-prvs: <TYWPR01MB97720094E57ABCCAE0A832D2E7C89@TYWPR01MB9772.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hlep+EHL9QsSybdiN/tgKIivP0q/31rmwLYDKRog3FdwvSUdQCGPjR/A6nE2k8fkvmHM7cedUTnJ8OoiuVSpUmHRdIfF4VI3pcS8VTfnt/zYycjYYnKIPs0nu3TpqfWIJIXo2DMabp9tCjSejT7kOFl3tc/ceFML2/Lhhzw33Syqi8Vfs8nR7ne2Z4VcsABZxoU0lm2X4InYTE87+SOs2Vksgb0PGRhkYSODSfIBYk9pT/6/pVtG0CXXOQwpGEFXtsSn8NkoomBxyryXzAetbQzR/ZQ198M9PGzFTkK6/Z05IYg0KeqxK4Nodgqt9cPtJ5e3jUSaNSCC4uq7sLPm3CUpjqImc1jxFfwiJQrbCFZSjCHk0rE1B+Ic1WIN1eZA2+zM7Y4zEUupWS1FIsbwCCtAhWUX9Ab02TpgJk7pdodAo9EBiI9FZktSsHcZ7QZ3+5mZtL6vdTtiCNK95+j1k4CuAlouIDThqSkV9oGVZ8ss65UILR+AGs77WizimH84zuWE28qAFKpZ9DDG5lEsEx7b6MG5/8/cCIvmb/hetbxvLGjOs46w2Z21v4TN0PB8pQ+bdI3Zm1PwIUdTawesUvCw7C6AKQRL0hILW1octSxWKb68PpQB1j6ehUGKSnjbwoqZEQjSfqrftEtZOjpHvpBTeqI0vdQMsGDUBd8tq6bm22gekyYWx2wTWfjyhTHQhpKkLS+uzTEa8QWT5XFXKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(4326008)(5660300002)(64756008)(4744005)(6506007)(76116006)(8936002)(26005)(6512007)(66946007)(9686003)(66476007)(55236004)(66446008)(66556008)(82960400001)(122000001)(508600001)(38100700002)(38070700005)(83380400001)(8676002)(71200400001)(54906003)(86362001)(1076003)(6916009)(316002)(186003)(2906002)(85182001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2V0RzJtR0YrU2VuWDVtQ0hiRnBPb2FKT09vdXZpNkZXdUoyY3VTT0Q0dCtq?=
 =?utf-8?B?YmF2bXhFUE15RXV1ZUpWbEw4YjN2aWRodHlMNHM0dzdobXlqUWtKb21SZlpO?=
 =?utf-8?B?WW9xV1RzLzU5a3E4Y3Rzcy9MNHhscUNZeUxsY3dNMStwN3hrOHdrUFY3QVZN?=
 =?utf-8?B?d3EzSU1xeU9BU3hPbHZpVHhxajR3YWE5YjMxZCtuZEhETEdkWGxTREdBYzUz?=
 =?utf-8?B?OVhUMERJbWl1ZEFkWkU3eDkxQmtuZjk1MnVRTGNPdjBTWnl2M09JRkRNVWxO?=
 =?utf-8?B?V1lnUWZvNkFaNTIycUV3Q0d3aFdOempIVnc3QXlvZUVicFg3ckpnYVB0ZTBq?=
 =?utf-8?B?ZFZJcE5SYngyTzlHMEcwZzNSRmtIbm5oQVRNL3FRTzh6Ly9BZ2wwTndQajJs?=
 =?utf-8?B?KzFrNFBCWTZBR1RZMjQ2VG9idGNCLzhRS0lYV3IwN0ZzSUNsQStoanVrREww?=
 =?utf-8?B?QXh1eWp5MjMzcFlNa2dhbDVCeTJWaDJVaVdJU3VsQ2MwUk9DMjEwL2xwaXJM?=
 =?utf-8?B?THRWc2lOTEdZM2x0SCtSZi9xR0NRRWNZU0s5QkJORWw0SDNFaVpDVXlLV0cw?=
 =?utf-8?B?VnZZNE1rc0RGMFI3OFFzUWluSDg2NE14NGVNd1hWODgzT0xwQkVRSUdvMkMy?=
 =?utf-8?B?SWZPUlMzR2ErbHc5WWZnaW5uNWdkWUJBV2JXbFRWRWNMVVdzS1hCSDBKMnBh?=
 =?utf-8?B?ejQ5MGFKam80T0lMck9OaEFtd1pWR0ZiT0JjSm9ic2hIS3c2WndiaFUrSFF2?=
 =?utf-8?B?UVFwWFpJRDFMMEhyeHo3TWROMWIxV0VZakJMNDZjc1FXYVNVYWppNG9DeDg1?=
 =?utf-8?B?V3pVcE05Ny9kWnEyTGxuejV3Y3FEMTlaNml3NnNmcFZZZlg2Y0c3QVVnRDB3?=
 =?utf-8?B?RVRrMmQwTVo0NUwyZEd6NlRIYzBEamtFc0poS05SM01mWVBTMUFtVldUbExC?=
 =?utf-8?B?Z3FYL1dTa3puaDhJZ3NUaVdoY2QyTFVPYTVnTjRma3VXS2E5UEpUZGNRbC85?=
 =?utf-8?B?Q21uaGo2SUNlYndBMTZlMVZ6NkY3WVdkL1hRZXl0VFhzQTVUdUxoMGR0VjNG?=
 =?utf-8?B?UVNlcEJsL3puYjVNbm9YU2h5N0h6YkVoZndGSjIyM29sYXI5akFhdlhxWkFq?=
 =?utf-8?B?TnlqSk9uanJxNlJ0TGNtelhlRXNqQ0J3dkp1cWZCZEErbmltcUFhSGJkKzdL?=
 =?utf-8?B?VFR5c21FU3BCNGtSVWJIOXNwekpEZFVJZml2eFdsNFZGQm4yckdVMWJHbXgy?=
 =?utf-8?B?cDJDS0lvN2FOdFFjODdTeXpqaXhodVkzbjZyd2hPRUIzVEJkSjFLSk0zUzFR?=
 =?utf-8?B?ZFVMNnVyYmhFcFlHTW1seWNHWUd1UzlhYllUemRDYkFBYXJJS1hPLzkzMklo?=
 =?utf-8?B?d2JGU25SV2tUcVVSZFo1ZEdaT1BjaEZ6aUVEQ2FUTXpTcHMrY20xaGtldklk?=
 =?utf-8?B?bUFCaW5pbmROVERRQzJKMVMxZS9EQW1nTUNaeU16S3NnOFlBUFV1NWJjOENQ?=
 =?utf-8?B?TUtUb0YxdE1zT0YycGdiVCtqNmVNNGNnMFh2RUVGOFA2RVp6QUJMYU1IcURh?=
 =?utf-8?B?aFE4R3l0M2ZXT3RIWWtkS1ZRRkJEZXc5em1RZ2JKSDdRTVJIZnZ1NEFBemlp?=
 =?utf-8?B?M2RnQUFyOE05ZEpLL2R0bE0xaS9sZXpTMW9UMW1ZbXZoWFVrUStubDg4TnNL?=
 =?utf-8?B?T1V5U1J0eEtWRE5XSVordm1GanNEQUs1TkdXYTFCZnVzTi9hMVBDZUJmKzNo?=
 =?utf-8?B?SFU2alg1aDljUkRFRFNoaFRQTmRYS3FOU0dDMDArc3preGdJRXhxQTNWQmdC?=
 =?utf-8?B?eUlGNXd6YWdNV2tpeVQ4UkJLNkFodUxGNm14TmF0ZWZqTDhSSEdQTEhUVTZn?=
 =?utf-8?B?UFQrZ0N2NkRjNDB2d1VJNUN0c2ZwUU5YcE0wSW0xR2NwN2dyMzU5M0lMc3Nw?=
 =?utf-8?B?ZU93NnEybzhKaXFCY0ZhTEQrVGV1Ulh0Z0xzODVPVTN6RytKdkRWeUdrc1Qy?=
 =?utf-8?B?VWh0NE41d1YrSG0wMGdsSE1TWXpOWFUzN2tCY0xSY1VVdFhYV2ZEVjg5WWhp?=
 =?utf-8?B?MEVsU051KzZxOTFrWE4xWFpzdG1PMm44cTYxNDJLelhmbU5NVHRsaU1xSVZN?=
 =?utf-8?B?SUhQMEx2ajNkRUtKUXh2WVVVbWVtTUdxWTJ5VTU5Z0RRVi9wYkZ4MmFjZjM3?=
 =?utf-8?B?Q2k4N2w0dERjTU4wSEZ4MHdUNCtQemhLbUNRL05zQis2UFpMcjV2R0RrcVlX?=
 =?utf-8?B?cXJPbWEzdlgydW1vaUVtU2ovUEJIVFJBUEpVY1Zha3ZNN0Q5WTNYam9KcCtG?=
 =?utf-8?B?Y1oxZFBqQTQvR0ZZcW9Iclhlb2Y2ZVJrYkh4a2hwTjQ2N05HRXFObHZRdkVN?=
 =?utf-8?Q?6vSHB8YttzZ2Ilm8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2396539EB97F7245A48F9174EA4E3553@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772249d4-2ae4-4d47-456e-08da3326dc8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 08:18:42.7675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DSDR9bEwBIcOCQxW9/23sn3TeAzOwbZXXnDqUWvL/TRuLhupfZeCazzXKwhkJjFFx0712iPpXLLufm3EziT4gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9772
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXkgMDksIDIwMjIgYXQgMDY6NTY6MzlQTSArMDgwMCwgemhlbndlaSBwaSB3cm90
ZToNCj4gaHdwb2lzb25fZmlsdGVyIGlzIG1pc3NpbmcgaW4gdGhlIHNvZnQgb2ZmbGluZSBwYXRo
LCB0aGlzIGxlYWRzIGFuDQo+IGlzc3VlOiBhZnRlciBlbmFibGluZyB0aGUgY29ycnVwdCBmaWx0
ZXIsIHRoZSB1c2VyIHByb2Nlc3Mgc3RpbGwgaGFzDQo+IGEgY2hhbmNlIHRvIGluamVjdCBod3Bv
aXNvbiBmYXVsdCBieQ0KPiBtYWR2aXNlKGFkZHIsIGxlbiwgTUFEVl9TT0ZUX09GRkxJTkUpIGF0
IFBGTiB3aGljaCBpcyBleHBlY3RlZCB0bw0KPiByZWplY3QuDQo+IA0KPiBBbHNvIGRvIGEgbWlu
b3IgY2hhbmdlIGluIGNvbW1lbnQgb2YgbWVtb3J5X2ZhaWx1cmUoKS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IHpoZW53ZWkgcGkgPHBpemhlbndlaUBieXRlZGFuY2UuY29tPg0KDQpMb29rcyBnb29k
IHRvIG1lLCB0aGFuayB5b3UuDQoNCkFja2VkLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhv
cmlndWNoaUBuZWMuY29tPg==
