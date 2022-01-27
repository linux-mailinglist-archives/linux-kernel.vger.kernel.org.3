Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDBB49DDFE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbiA0JcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:32:11 -0500
Received: from mail-eopbgr90051.outbound.protection.outlook.com ([40.107.9.51]:25938
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238575AbiA0JcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:32:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrxItg6Zl1EL0MkggVIKPfa/0+dcyyZfw4kNRFGZZziyVJGsfLYNJuCjT04Jd0z9I3a0JhBn/td5XTUw+HunSXAvwhNvUYIlyogI/79uC5pVSzEnC3vI8mhiZ4kp0d++ZgKghmfZDKFZRmcgldCJXx0Ejirxy/6vjzJcYoF8Pysl3LRKCJD5LgcmGMD9qNehI4uhQtCy+S54gRn4wAInAvVVj2iNgpQcQ9qNX+JMWnMqy/mu7BxL1UgCLphtlqAx7FKzcB6NQPC2D9a0H57hrlXhcKlbUIK8vbsyny295MdEE/wJ1Z41g6kBeppnmVhrl09wm6kZz3N9rRzSVWTfqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+zA5dMgjiOJuixq4tMOi8GZf4GMyGcme5WbDD9LTPk=;
 b=Nubls7+tFdjPpogtpsVla7JqxSVbjZSHnveeFuoMvVHPkpEj16dRXfVA3v5oviiSMpxaMk53QeHGDvbtt1f+cG9eOAsnUKNrU5nfIc5CCOjNvpMxUGLeD7iIZ5ejA/CtAM+i4uIt0mnmpWWhC/QigaoTmtV0dUgr/PgBLkEH07ZGGO4CCJXvV/I/itAkH82R7GOrSLERcEpnAQbgKL0/vuj0t78GN85Zyu1fWTeZJAQbz8B9vdbG6UU/mHEMcdnhSqUB4ItFn6YoMdINQmTBLXLBqkq3lPzaQLGZ48LNDDjl826vy9DmAEzB0lIK4IVFXvEeqH4JJ047XnWnVsgD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2783.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 09:32:06 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 09:32:06 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Ralph Siemsen <ralph.siemsen@linaro.org>,
        Kees Cook <keescook@chromium.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: at25 eeprom driver: NULL pointer dereference (bisected to
 af40d16042d6 ("Merge v5.15-rc5 into char-misc-next"))
Thread-Topic: at25 eeprom driver: NULL pointer dereference (bisected to
 af40d16042d6 ("Merge v5.15-rc5 into char-misc-next"))
Thread-Index: AQHYEumHonw39ZYrPEejtSnBtbGghqx1srMAgADo94A=
Date:   Thu, 27 Jan 2022 09:32:06 +0000
Message-ID: <17598be4-c5f5-c9ae-ee24-652fc06f36ce@csgroup.eu>
References: <3887fe1b-58ac-902d-a4ef-1f8825d55aa6@csgroup.eu>
 <20220126193816.GA3763305@maple.netwinder.org>
In-Reply-To: <20220126193816.GA3763305@maple.netwinder.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 113f8a34-2163-4c84-c1be-08d9e177e27a
x-ms-traffictypediagnostic: PAZP264MB2783:EE_
x-microsoft-antispam-prvs: <PAZP264MB2783C60470BA7D2AB426D3C4ED219@PAZP264MB2783.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1tD06PMr1A03SCYmEZInOULqdCDv+7lU/nMQb6GPeP1CfCnTrxSu9pWTBmfzByhCvUFHZr/Alijj24eQBSlm+Y+pFEPMHBTQvmMefB/pawuCQHN9OJwO+CxN7DxRPDKGTB+K63ELbV86iImx4/yVsyhZrAHM1oDVja4HEhk29aiARuUdW0zMhPaNkJrd8HdEIMpPt6rigUgKkLFFhBUcv/7JuYD/64oxipwDF8/ewrJPFsAy6Bi1AxbHCpNTPZTcS7UmkjHiZkV1drHJFqppqPdG7Zf8/qZAJO2ugA9uT3t3TkVVQN5CkzraaDBjiFWV3JPx4H98FoZp1mFFjN6vWxXcj8tY61nAuzdV9zjFSz93pb3crGFN4t+nBkAKRpgeYwsQylKBc1h2Pokm6sO1cOD+8QHntLyXQRu/5rG9vYkIcMGVUWf7oGcxgAxRngw61zhPdcUSNeQJLmsJQwRjoyKkyDXnWrxuQKXUAJcfN6dqUKphv/lGBKh5nsaG/temBZvOYseRno6oTucUDptejfVpjqlqVkunq0wjwvlk8Fm1b9/ZFuCXssCqSnqbUrVLHL9s99hbUGOy4QyVCXx5DMTMKhWnw3A3y055Zhb/SkWurqsUksqWe/+EYCiyVPskosLcN4btbFfuApcTKar5JFqKiAbgsgNo/KBanZ8ztJzSwcs3q0sAoZI1krF96ZTHNibLya4p5gJtCM7/nYYuGD5pkUYQv74td570DmQDkOwdODZaE0nycft7IT9xymy+/JsGyYGcNWCety/nniq2ulxYSHlg1W7zkgEpJhfupwDd/zxLmxF0CxvxUpxg1mvfe3gaMlHDxxrv1IvrrWb4uVyG1BfeF4hZP5qq+sZ/ZTw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(966005)(54906003)(110136005)(38100700002)(26005)(186003)(38070700005)(71200400001)(6506007)(508600001)(2616005)(36756003)(4744005)(86362001)(6512007)(31686004)(66476007)(8936002)(8676002)(66556008)(4326008)(64756008)(66446008)(76116006)(66946007)(31696002)(2906002)(44832011)(316002)(5660300002)(122000001)(91956017)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0R2b1piVW5qNEpkZm9qUTdtOHYveEVsSmVqY0hrK0tQNjIyaGU4WjBibnUv?=
 =?utf-8?B?Wmk3U1NTZWpYUXBaTnByTW9DcCtwYVNDSzRvOXdGcWV6RHFKcTBHUjN5dCtp?=
 =?utf-8?B?MG5iYmNIS0NuRW9pUThzNTNpYTNsSUhqT1NpOTBSWXJPU0NkMGJPVHBPVlBD?=
 =?utf-8?B?SU5Rc0xQaUdIRUQ4bm5QN2UxemhrM3VnZjlabkloTmdYSi9JaitqRXVURE8x?=
 =?utf-8?B?cVVsbVhFN3R6T2l0ZGpFNHhaOXk1OGI5L0lsancweGNCUS95bE05YnpISlI2?=
 =?utf-8?B?Q2pQQ0VBV0R0Q2Q0dTN6TE11UDVnZklFeFVYTC9iSGNVRmgxZXNYRFVWell5?=
 =?utf-8?B?cUd4akRkL29YOThLWTVCNHhKandHZjNTaURld1hHVE9yNFN6OVJkb05BVUti?=
 =?utf-8?B?ME00NXpCaE83Q0dIMk5uM0Z1VExnZTBJTi9WSHlBQ1Ard3hZOHdjWEN0Zng5?=
 =?utf-8?B?aGVtb2liRi9hSHFqMXFZSmhXN21SOFlmSW5tdlRhMEtYMTViL1B6RThjSWV5?=
 =?utf-8?B?c0Q4eGcycVRwS0FYNUZTMmZxZjhNdEJCQ1lNWCtZMFk0NENpYzByc3hFSnI0?=
 =?utf-8?B?NEZzSTh5Q2R6eFdZdHNyTHBLbXJmNmhTU3RnWW5wR1VMajhEQ3NqMUFhV3JV?=
 =?utf-8?B?aGlDdVZVVllFYTNvQjJSdEY4Yk4rajVLZm8zMUhQWkNEcVpsMUZRU1JVeVRL?=
 =?utf-8?B?OTBHT0F6Sm1sTldmenpaUW95c0pWSmI3c1JkenFEZXd5R1c0cG92N1hrL2NM?=
 =?utf-8?B?ejE0TDRpd3NQM2lkTHc5V1hWcyt2eDZuZW5zQS80ellTVXJZMzBsNE1XU1M2?=
 =?utf-8?B?RDBKOTRzK0RSd1lrbmhJeCszMzNqS0lJVy9QN29FaXQ3N25GN1JkckxabUdX?=
 =?utf-8?B?L0luRkt6cWpMUHhmWEltajI3Ni9NWjdsSEQ5ZDlKK1I0VWVZeFlmaWZ6TFU1?=
 =?utf-8?B?T0tLQllxaVhuTDk0K3h0V3pFZ1RncTZOWDdZeEpIMlFoMDFZK2NTdmlKdWhF?=
 =?utf-8?B?Q3pjRXorTGtpZDBNYzUzb2wrTWpsV1VwSG1wMEpKUytuYmR2Z2I3U0Q3aXdw?=
 =?utf-8?B?ck8wL0FaeWxldytrRTQrT21xRzVzY1l1bURSckZFa3RTdkdGV2NnRUFUZ0t1?=
 =?utf-8?B?QjM3cWRWYkc3cEc0QmhlU0MxYWpNZW1WQm5zRy9uWmFZL2c3WS9oOUliSjR3?=
 =?utf-8?B?VURka2xJSkQ4QnoxWmRXYjhvblMvVE12TTRwM1lJQjQxYWJLbkkrUkNaWkto?=
 =?utf-8?B?T0pVRWJGOW16SzVjZXRFTm44c082czVkNFFMSGo1U0daSDNvaExlY3k4TVJx?=
 =?utf-8?B?bWZUL0w4S2tMeWdFV3piYVlWTzl1UHlNTFU0S2hJeFhHaDU5Rm0yZkdLZENp?=
 =?utf-8?B?QjVPYTd3SlVMM21OOTd3cVhCZ0J5MGxOeVBaZWtQemNZa3pLMk9pZmF0eTNO?=
 =?utf-8?B?Wk5LRXlOYmg1UkpoQ25VcWZXMm0zVy9nRmZKTDF2WUJCbzdjZ2JVSFpuQ3NE?=
 =?utf-8?B?R1pmU2RPdmVaVHZEZVVsbktCeDRaZzBtaDRZYmZhK3NVa0xEUktQVTdCdXo1?=
 =?utf-8?B?L3RoWVZZS3VlY1I3NXFGQWlGUklsRlpEdHJDSHlIZ0o4Qi9jVFVnQk1DZzVu?=
 =?utf-8?B?TksyaUtFUXBRNFd3c250d215Y2ZuZ01zZVowUGlxRy9OL0N0RFM0U0lvWEtI?=
 =?utf-8?B?LzVpNnpES1FqOEhMS2huZ3lpV1c4UE1waVFBeUhic3RSd3RVK3pXZGU5U1pO?=
 =?utf-8?B?SjVHWHNFd2ZNQVl3REhHTmgrTlN4dlA4K3dQS2pSTzF4anYxSHp6RHlJTFla?=
 =?utf-8?B?cUtMUys1ZmUrd1ZjeEJqWlYvRjFnV20yQ0ZCbUFVMnlWcmxVNlVwUTVhblhw?=
 =?utf-8?B?cU1ZekJ1M3UvTGhyNXN0YjFQVi9rS01Obmo2NmhoM0hib2pUSGdXcDZQZjJi?=
 =?utf-8?B?NWRVTnhGcVJIOHF0VjgzS3BiLzI4Z20rY3RYSUc0MHRpQlNlK1BaQVVLUXl4?=
 =?utf-8?B?aUhYbytsNTlYVTF4UU9tbytjOVdZSDVhajcxQk01QU1kNmRWbzM4aUtDa2tY?=
 =?utf-8?B?NzJCenN4OGVFWDRwUWloN09Zd2lNdjRBbGhGeCswTXd1QUFhMjhJUjkwU2Fh?=
 =?utf-8?B?YWQ5Zm5kOWk3MitIUitRcFZQcW1wa2NRT3ZFL21ZcDlYdEd2L1dvdWxLazlP?=
 =?utf-8?B?UWlnK1N3MG9ZYmZUVkNlRXJrb29lb0p0SUt3TTNjVEJxcGNwdmtxSE5rUjlY?=
 =?utf-8?Q?k4TE6cXVYAH1RMG7XjrHbN/9FWr+se4SE2JUuP03oI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <757DE4DB41569E498BD982F7DFC287A6@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 113f8a34-2163-4c84-c1be-08d9e177e27a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 09:32:06.6220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7yShNopjmkCEwlkWBbkc7QRhcss7Go+DQT3wkHmjucuQdJc1HPYuJq/WOLQgsgjvibJqtfT6V+7LuV5i1urc39T3iTUWyO1jIDnk4f5lxOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2783
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI2LzAxLzIwMjIgw6AgMjA6MzgsIFJhbHBoIFNpZW1zZW4gYSDDqWNyaXTCoDoNCj4g
SGkgQ2hyaXN0b3BoZSwNCj4gDQo+IE9uIFdlZCwgSmFuIDI2LCAyMDIyIGF0IDA3OjE4OjQyUE0g
KzAwMDAsIENocmlzdG9waGUgTGVyb3kgd3JvdGU6DQo+PiBHZXR0aW5nIGJlbG93IE9vcHMgb24g
Ym9vdC4NCj4+DQo+PiB2NS4xNiBpcyBPSywgdjUuMTctcmMxIGhhcyB0aGUgcHJvYmxlbQ0KPj4N
Cj4+IEJpc2VjdGVkIHRvIGFmNDBkMTYwNDJkNiAoIk1lcmdlIHY1LjE1LXJjNSBpbnRvIGNoYXIt
bWlzYy1uZXh0IiksIGJpc2VjdA0KPj4gbG9nIGFmdGVyIHRoZSBvb3BzIGR1bXAuDQo+Pg0KPj4g
SSdtIGEgYml0IHB1enpsZWQgdG8gZW5kIHVwIG9uIGEgbWVyZ2UgY29tbWl0LCB0aGF0IGNvbW1p
dCBkb2Vzbid0IHNob3cNCj4+IGFueSBkaWZmIHdpdGggJ2dpdCBzaG93JyBidXQgaGFzIGEgaHVn
ZSBsaXN0IG9mIGNoYW5nZXMgd2l0aCAnZ2l0IHNob3cNCj4+IC0tc3RhdCcuIEkgbXVzdCBiZSBt
aXNzaW5nIHNvbWV0aGluZy4NCj4gDQo+IFRoZXJlIGlzIGEgbWlzdGFrZSBpbiB0aGUgbWVyZ2Ug
Y29tbWl0LiBUaGUgZml4IGlzIGhlcmU6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDIyMDExODE4MjAwMy4zMzg1MDE5LTEta2Vlc2Nvb2tAY2hyb21pdW0ub3JnLw0KPiANCg0KSXQg
Zml4ZXMgdGhlIHByb2JsZW0sIHRoYW5rcy4NCg0KRldJVywgeW91IGNhbiBhZGQgdG8gdGhhdCBw
YXRjaDoNCg0KVGVzdGVkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNz
Z3JvdXAuZXU+DQoNClRoYW5rcw0KQ2hyaXN0b3BoZQ==
