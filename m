Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D87F46E0F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhLICkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:40:52 -0500
Received: from mail-sgaapc01on2132.outbound.protection.outlook.com ([40.107.215.132]:11104
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230183AbhLICkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:40:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMLOUULAsgpfwTzzWWiWKpQT6PPLddqfTnEfDp8VPfh5e51JQd2+T3o3gJMLxI6Ehh7sQCoULIfHTGZsQB9FmAiW8JVlRDNeg/cxS1fZqt7aMMtgQxCxoT3tjmXe2vV6YH4hO7ajixhkVeBqP+2XfL8PWhkxe3GwNzZL3+jC9KEcZWqtXBQhLKAxJLUfLH1J/1EWG3hqDZLh5dt6gFZyOhzQ611tf9ouHhs5XF8Hlp3hqVvQckxxOS9nREdOMaG1r4iVauJ3C47fW5ZglXrbYrVtkwdbGWYVVF+www09tdAmx11uRL53aYYZ427qGyDYmhZ2Ob/ZOgeV8M9OmJmtkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ly5JtBCecRfhUa+GBpaWAK1lZ0tVw/+wD9RclbW1BM=;
 b=oURSYDhm9h1LXQNfs/fXH9ZkrgRnCP2M34DNPUN/8Rtgx7LshKPvgNknjxZVowykqLkGhN9ksD9HXa0+0YNLh+gtJJefQ0bIqYKmgB/Swv/hmTh2HaogYPlThNII1lRFKxBza/ui+vsT2ZAI6sqIJSotZPm5tGXvnsg3CDWiQPpfXZ93IHDup0mtDSvJWeIzAAkRxa1DAUw5627nuAO7JYtK0lAQs1Oywb+tvFmRhrU7KsqSGqA+x0SYP2sHL+eJb3Ne31S892XMJKrpfHW4U6+Elva7iKhep5GRD9BRt1arZZ8i5aKyY9ou7129Fw1Q7+PAlwVkpXQyKf5+X2o2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ly5JtBCecRfhUa+GBpaWAK1lZ0tVw/+wD9RclbW1BM=;
 b=WlPWcWaUOdYfXjM9daonwvG8Fp7vnvH1QpOGFnQ+vj4uPkkRqSWSBqMmHa8k7NnO/xtZvWrGE+NC+Mkvpq3Elj7FK6kbc0tygX1vw+ojuPxuYC+YBSVLCCyq1UPcY3CRTigTMiUeTEXL4lL5KhqmHXQh/feSNqwHfIDBL/OAnn6h+2usak14GHNmBvmSfTqlfSAO5pilzlIO/ppFqXZjGg/Zkg0GEWOT7MM4G9Yd4Zr2m3ZPQFiKWYQRSM+mUdcZxBU1a00xLJ5iEMefu4bkxw4W+E+DShGVA0dkwvHOWMTZ2q5Rpk9JPXcggJwEn90jgn5fJWy3WQmTtGFbFNrT+g==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK2PR0601MB1843.apcprd06.prod.outlook.com (2603:1096:202:11::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Thu, 9 Dec
 2021 02:37:14 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::6d89:70e9:fcfe:e126]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::6d89:70e9:fcfe:e126%4]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 02:37:14 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
CC:     BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup failure in
 iKVM use case
Thread-Topic: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup failure in
 iKVM use case
Thread-Index: AQHX7BszI/63d6+3yEiIx/+xfvXqSKwpSLsAgAAkTIA=
Date:   Thu, 9 Dec 2021 02:37:13 +0000
Message-ID: <HK0PR06MB320271524E51BDFA922F070780709@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
         <20211208100545.1441397-3-neal_liu@aspeedtech.com>
 <391323f136e49387797d43e89b6e42cd95d916c2.camel@kernel.crashing.org>
In-Reply-To: <391323f136e49387797d43e89b6e42cd95d916c2.camel@kernel.crashing.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ed29eb4-13ca-4f4f-a3c3-08d9babccf21
x-ms-traffictypediagnostic: HK2PR0601MB1843:EE_
x-microsoft-antispam-prvs: <HK2PR0601MB1843698A1C45836AF839CC9B80709@HK2PR0601MB1843.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WBjiMunlvBbb+AswtnB03Af3lN03RGypJVKAvShK3Cjn4Z11PCrz35klYQxB9/jy1v7lYcaniafia/4nPuXbI2GqG+tZ+dh4cE3tHLHxLQ8HWtL6vl4AMTrG2XAMLFM0xAElYK+prRyeVLmPHMRblwpYqsIXIEI5uuvjovPKbZfXVu9ODR3QaD4AW2cs/rNerL+/fq7yhU8MrEWe3ndJhA00eawul7QGGkft5Gt7iRneIIL9d4kkNC3qIrcz4iNnpzQJQGUglBNrO5+DQ9nWwY079N75R3UIlCv3fZedrJ91QZFIQXtmER/qZWuY7nuP3+v2OXDXmG8anRFtCu9jIC3r8SatOUG6E3RnWO1WJYqfccYwauq8xm6D0Qlr/4AZRphMQwAw7w9haXXZgV2XYWImIzjhdbfykvIBxsP3rAZQd3zACUILcsiSN8lGIUwJkbSWFy0LQq8xGq55tkvnmzMKmBm5+4nCAUF9v7lEhr0xlR20NEcNA+1skiAOzRjY3TzE3O1vwh8iZASKbArgMoMUcAqTTWbXXIkLDq3vXQQ5I0tWopAgqfVBb3K2VEG1VhU3v876roSb2DfFkurucNDpeMKYBFw5/m/v/11tpzCUNeWKrgs68xqTO3ZS2IYGePgJuO1tHCL+FwIbeLf16H/pwAt0cxN0JAOpBTfSXQEaE8c7X/mOGXNYBaxn9lji5l09zZtZoFF/QM+h2HEYFVd1ibSteCpcCx/La+h2QHU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(366004)(39850400004)(9686003)(38100700002)(316002)(66446008)(38070700005)(66556008)(66946007)(7696005)(5660300002)(76116006)(66476007)(107886003)(64756008)(8936002)(2906002)(4326008)(921005)(86362001)(33656002)(122000001)(52536014)(508600001)(55016003)(7416002)(71200400001)(26005)(186003)(6506007)(110136005)(53546011)(83380400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFpJWUkyN3dIT2RVZ2NNN3J3T1duTUNCaHJQQXV0a0llbEJCRTVlckIybnNM?=
 =?utf-8?B?Kythc0dybEdKM2o1WWwvaFFQU2FSeGhrTFc0b2hNSnlQbzgyU1pzWkorV2Zp?=
 =?utf-8?B?M3hkQktOWjNHV1hvMzY1TERFQzVZNG03Y2F2clYzRzVwMnljTVN6L0llVUsw?=
 =?utf-8?B?WnpHaXdkUGRpS0NFNEVua3R1ZWxFS3hIdS93Z2N4dWpzWXFvUGpFZ0RrbWlK?=
 =?utf-8?B?MVVWajZGUEJYZ28wQjNVdTdZRGdPME9kdkZGSVQxUUVWVytLVUJnaHAwdlZM?=
 =?utf-8?B?NUZPNW0wTnBJYk9hSnFRSnBid25XdlZZQ3FIV2l6cTB2S05FZmhOZS9HUkRU?=
 =?utf-8?B?dkQ4ZitiZ3piOXlUUlplQTJPZUt5cURCVlI0dFcrRVpMbFZPQURweTZWbE9j?=
 =?utf-8?B?ZnN5V2NNSHJQYXlqbldTUDVxTVhsK1ZIbk5pVWZFZzRqeGVZdUh5ZFFpVVZD?=
 =?utf-8?B?c0tUT2l1N1JWdnA2UXdzTnJuZTV6T05NclJFOXJINGRReEhaMkI3T0IwOGFw?=
 =?utf-8?B?dHN0cUVjOEdSYXNCQUF0bENJSVpva0ZrQ1hXNlR5VHlUS0xUVWZBb3JvT3h3?=
 =?utf-8?B?dmlvTnQvQlhuMGFRWmV1UGtDMDN3RFU2TDZBS3ZSL3RsbXhmVkdWaGVONjZm?=
 =?utf-8?B?ZFFENWFRVVZDdWVOQlV4VEJkZnJ6MG0wRGorNGdyUFRGVEhlMWFPdUJTRk52?=
 =?utf-8?B?VXZQdXRYTXhPZ0J5TENBK0M3TW9oSVhIVkVBU0w3TEhGWTJodTNJdko0cmxS?=
 =?utf-8?B?eEI3SzNERUVZbVpwYjhMUC81bU1JaGZyTVBweXhQazE1ck9UWWt5dlBrQVo2?=
 =?utf-8?B?ME8vUkFSVitobk92d1dZSGpybGlyakFWaUJYS0Y3eHF1WTlQa21sYng2a1hF?=
 =?utf-8?B?MjdNaS83dTN2OWhMUDdwa3Iya2ZYVkx6dDhlbGJjRi9LendROGd4RTFmMzZZ?=
 =?utf-8?B?TUlscVNNZmhXUjhLdVNENVEzMklSVVAzVDZJTTlUcWhsVklQcVFUSlBkdkNs?=
 =?utf-8?B?UjlkRHYwMFptMkJLMXdZU1dQT2ZtbHBKMmJacTFsTzEzMkVWTkpLQ2NURmFT?=
 =?utf-8?B?Ni9WL1FiOVhVVFVaM1BSakVSaWJBc2dvZVVTRTdhSDJGa0pnUUtwRDJWUWxj?=
 =?utf-8?B?Qzc4RUdPN1FIRnAzNUhKNFFFdzc3ZFJROUU5QjByYUJFbFdhWG1sMWZKTXVs?=
 =?utf-8?B?N2FZOWdHaXZZNmZPTk5rdXFWVnFQYjd1Mk5KdGUwLyt6MXIySnZkZC9la0NE?=
 =?utf-8?B?NEd1aTkzanJYVVh3QUszTnhKbnFKRUxacHduSGpkaXlVL0EwYzBkbWZhcmhT?=
 =?utf-8?B?WnZOZ2x4MHRQenJodEI0WEMvR1JOU2Q0UXVOTnkrUzNJOG82SFRkN1BQcFIv?=
 =?utf-8?B?bTZQNXRrTWlZNVNhL0YvSWQ0SlNGNXk2RXd1djg3eDFHNjY5NWlDeEQyUG8r?=
 =?utf-8?B?eG5jclM5dk9OSm5ZVllHa2pzYXhzSE0xWS9kVngvMjY3UkhPY0o1ZGRIZ2Rl?=
 =?utf-8?B?dGRSRjg4REV1K3EyMVRaWEtSVlZla2RvV2pQbDA5NDFQVW1aTnQ0SE5yZzNk?=
 =?utf-8?B?K1JqMURoNm05SzdEMC91VlFObEpNWExxYVhXUEU4SkdnWFZnSmQ0eHQ4aS9p?=
 =?utf-8?B?aFJNajF1aFBMWGFZR1Y3UjBmL1I2cnZNbHhUUGRCSlZJTlkvREZzazFta09x?=
 =?utf-8?B?L3JFU2I0R2JMamx0MGtQSzZVRE9Hb294R1Z3dWxCMFpUMUZNMlYvcFFvZ3l2?=
 =?utf-8?B?WEc5dzgvNnVSMWd4OXhKbllqYllVWlNRL2t3OUlVbnFLZmxrdkRIRjVITlNz?=
 =?utf-8?B?OTF3aTFHREo3SjFSR1dIRVJaeUNkaWdFWkNPbURUVUxMWXR5dDdIWVFiR3ly?=
 =?utf-8?B?bnRXS0tFZnIvdlh2VCt4VXN5Nm1SU3ppRWpsZlA2bFZpUzdpUTI4cUlleWEw?=
 =?utf-8?B?TFFIN21XZllDcHhML2UwY1UwQW1Xa1NqRTdOSUhKNUgxaHFOMmJFdFRpZXpD?=
 =?utf-8?B?NnJoM05TOUJaSFhFN3YrVDM0elJDUzBTSktWcEFyMzVDcFpHOUc4MDZCa1Vi?=
 =?utf-8?B?by9oaHBrRWNyRUZBYkZhYndudWRvQ211SnF3dW5weUpoQldVSlFWemp5Z2h2?=
 =?utf-8?B?UjRPUFFkRG1MaGdCbHZVdlhicGF2K1RFWkdja2xHNHdYWXFhaEc5YW1lSGMv?=
 =?utf-8?Q?nS2iKJFZnfdNBRXoKNg38/0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed29eb4-13ca-4f4f-a3c3-08d9babccf21
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 02:37:13.9154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbn8E5IPf2IoNT62uwcIG6AVbnr08ThuCZec8Fqt2fkdKkxvFfvSc6A2PhtX2/4uDPygfQmC6Fxf4/F5a79eig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB1843
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCZW5qYW1pbiBIZXJyZW5zY2ht
aWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJl
ciA5LCAyMDIxIDg6MDUgQU0NCj4gVG86IE5lYWwgTGl1IDxuZWFsX2xpdUBhc3BlZWR0ZWNoLmNv
bT47IEZlbGlwZSBCYWxiaSA8YmFsYmlAa2VybmVsLm9yZz47DQo+IEdyZWcgS3JvYWgtSGFydG1h
biA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBKb2VsIFN0YW5sZXkNCj4gPGpvZWxAam1z
LmlkLmF1PjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bhai5pZC5hdT47IENhaSBIdW9xaW5nDQo+
IDxjYWlodW9xaW5nQGJhaWR1LmNvbT47IFRhbyBSZW4gPHJlbnRhby5idXB0QGdtYWlsLmNvbT47
IEp1bGlhIExhd2FsbA0KPiA8anVsaWEubGF3YWxsQGlucmlhLmZyPjsga2VybmVsIHRlc3Qgcm9i
b3QgPGxrcEBpbnRlbC5jb20+OyBTYXNoYSBMZXZpbg0KPiA8c2FzaGFsQGtlcm5lbC5vcmc+OyBs
aW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWFzcGVlZEBsaXN0
cy5vemxhYnMub3JnDQo+IENjOiBCTUMtU1cgPEJNQy1TV0Bhc3BlZWR0ZWNoLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MyAyLzRdIHVzYjogYXNwZWVkLXZodWI6IGZpeCByZW1vdGUgd2Fr
ZXVwIGZhaWx1cmUgaW4NCj4gaUtWTSB1c2UgY2FzZQ0KPiANCj4gT24gV2VkLCAyMDIxLTEyLTA4
IGF0IDE4OjA1ICswODAwLCBOZWFsIExpdSB3cm90ZToNCj4gPiBTaWduYWxpbmcgcmVtb3RlIHdh
a2V1cCBpZiBhbiBlbXVsYXRlZCBVU0IgZGV2aWNlIGhhcyBhbnkgYWN0aXZpdHkgaWYNCj4gPiB0
aGUgZGV2aWNlIGlzIGFsbG93ZWQgYnkgaG9zdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5l
YWwgTGl1IDxuZWFsX2xpdUBhc3BlZWR0ZWNoLmNvbT4NCj4gDQo+IEkgc3RpbGwgdGhpbmsgaXQg
c2hvdWxkIGZ1bmRhbWVudGFsbHkgYmUgdGhlIGRldmljZSBtYWtpbmcgdGhhdCBkZWNpc2lvbiwg
YnV0DQo+IHNpbmNlIHRoZXkgZG9uJ3QsIHRoaXMgaXMgYW4gYWNjZXB0YWJsZSB3b3JrYXJvdW5k
LCBidXQgcGxlYXNlLCBkb24ndCB3cml0ZSB0aGUNCj4gTU1JTyBvbiBldmVyeSBFUCBxdWV1ZS4g
RWl0aGVyIGtlZXAgdHJhY2sgb2YgdGhlIGJ1cyBiZWluZyBzdXNwZW5kZWQsIG9yDQo+IHR1cm4g
b24gdGhlIEFVVE8gYml0IGluIEhXIHdoZW4gd2FrZXVwX2VuIGlzIHNldC4NCj4gDQo+IENoZWVy
cywNCj4gQmVuLg0KPiANCg0KSSdtIGNvbmZ1c2VkLiBTaWduYWxpbmcgV2FrZXVwIHdoZW4gd2Fr
ZXVwX2VuIGlzIHNldCBpZiBpdCBoYXMgYW55IGVwIGFjdGl2aXRpZXMgaXMgbm90IGV4YWN0bHkg
d2hhdCB5b3Ugc2FpZD8NCndha2V1cF9lbiBpcyBzZXQgb25seSBpZiBob3N0IGFsbG93cyB0aGlz
IGRldmljZSBoYXZlIHdha2V1cCBjYXBhYmlsaXR5IGFuZCBidXMgYmVpbmcgc3VzcGVuZGVkLg0K
Tm9ybWFsIGVwIGFjdGl2aXRpZXMgd291bGQgbm90IHdyaXRlIHRoZSBNTUlPIGJlY2F1c2Ugd2Fr
ZXVwX2VuIGlzIG5vdCBzZXQuDQpUaGFua3MNCg0KLU5lYWwNCg0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL2FzcGVlZC12aHViL2Vwbi5jIHwgNSArKysrKw0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvZ2FkZ2V0L3VkYy9hc3BlZWQtdmh1Yi9lcG4uYw0KPiA+IGIvZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy9hc3BlZWQtdmh1Yi9lcG4uYw0KPiA+IGluZGV4IDkxNzg5MmNhODc1My4uY2NjMjM5
YjVjYzE3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXNwZWVkLXZo
dWIvZXBuLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2FzcGVlZC12aHViL2Vw
bi5jDQo+ID4gQEAgLTM4MSw2ICszODEsMTEgQEAgc3RhdGljIGludCBhc3Rfdmh1Yl9lcG5fcXVl
dWUoc3RydWN0IHVzYl9lcCoNCj4gPiB1X2VwLCBzdHJ1Y3QgdXNiX3JlcXVlc3QgKnVfcmVxLA0K
PiA+ICAJfSBlbHNlDQo+ID4gIAkJdV9yZXEtPmRtYSA9IDA7DQo+ID4NCj4gPiArCWlmIChlcC0+
ZGV2LT53YWtldXBfZW4pIHsNCj4gPiArCQlFUFZEQkcoZXAsICJXYWtldXAgaG9zdCBmaXJzdFxu
Iik7DQo+ID4gKwkJYXN0X3ZodWJfaHViX3dha2VfYWxsKHZodWIpOw0KPiA+ICsJfQ0KPiA+ICsN
Cj4gPiAgCUVQVkRCRyhlcCwgImVucXVldWUgcmVxIEAlcFxuIiwgcmVxKTsNCj4gPiAgCUVQVkRC
RyhlcCwgIiBsPSVkIGRtYT0weCV4IHplcm89JWQgbm9zaG9ydD0lZCBub2lycT0lZA0KPiBpc19p
bj0lZFxuIiwNCj4gPiAgCSAgICAgICB1X3JlcS0+bGVuZ3RoLCAodTMyKXVfcmVxLT5kbWEsIHVf
cmVxLT56ZXJvLA0KDQo=
