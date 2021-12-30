Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21A7481998
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 06:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhL3FXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 00:23:19 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:18420 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhL3FXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 00:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640841798; x=1672377798;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=L1e9498bWz/LtBjJsbEIUS9ddO5rKm/gsYV0E7N8HkA=;
  b=AcnnMIa2eeJrcewONuza+optGWzqgBCyKmsBlxf6vBv7s/f01GErFEIi
   jS1Ggn1Oi56LpevSd0Zk9n2lysG+qq/8dqDw5VKuuW+0OICpEEtpkDfpD
   Alay7pUHYvXffPXiuALcN5MzPSTaGvPji3aYS7A5kwfacMArXiA5DONtA
   jeDgMn9qTgmHWJwXv+7gP6NDwdENsU8w4HEuPOi/EKwvd/sk4l4eC7QT6
   /KZQKCADQuENTs4uGXhQ7oCSqbnhI0lOGJO/QtS0UlCYMBNaA1RS+ZbGd
   ZMH7r2QgtKyWlaDiCZSlRYiE7co6n5P6YUqEwWfE20Ag+c9CzDZSnsiHY
   g==;
X-IronPort-AV: E=Sophos;i="5.88,247,1635177600"; 
   d="scan'208";a="301227765"
Received: from mail-mw2nam08lp2169.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.169])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2021 13:23:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNMNZIBRZEvczKXY/7xvSQs4tIH8Z5sMoa1k0IxAa/VcJaeT1droP7gakX7eZ1jPANoewgVOXk+bavA1xKR+xzA+RDUlBQl36Z4GlBxgWOSREbq9NeqThfWhQmb9sexCv5VPOHAySs38/yZFioQvXzs7gNcTUUCGqNMTqlcNOr/mun5SWPDT9DXxGAdavBtdfIM6xqy7y1fDzcLwb2zRMQmUjahfAtIg+temgCFIL5Q2EjajKwjyGRpKyJOv0C30qAbmrbzcqSynZvOhZs5Z7ZRa5AaVGFwBNYTCKolvDRqhI9ju0JzkZoobEGpxBQNqrmzWRxZeeqMzKiRSk69eoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1e9498bWz/LtBjJsbEIUS9ddO5rKm/gsYV0E7N8HkA=;
 b=j3lsgHCSGiRT1omqR1aMrQcRsaZrOOljEgIINYxNfXcDmHJuxjJ1+kWHS5vsgFvAbuBI1z5K0btYoeJXdjZk2244WkujIw8xqizQvcYSM6JvR9JC5KD8vyMTzKE/CzRUHEm1LEwk3wFDaYyt0L4y8sDT8VqMIesUswRUxcT8eiYZCbrO+rH8otDfBbhIsVcZxG9wm5MykmeDnrCVWJyhAXNz/0Gb1mGh0w9Jy3u7fXH9oyxD2xy8jNLe7FzJelPaV6F7rcISr3Jn4Mbb0fPnl2BWSRsPuNcsxdMbF1nUcl0B0HNqZxBs2PHMb00gpICqnulQrc/4cAqju2kYIyVzMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1e9498bWz/LtBjJsbEIUS9ddO5rKm/gsYV0E7N8HkA=;
 b=wRxkAyjcBcoJhNFb4c2+xp+6MeNtUBrDnDt0UWi7PVnAVrlZMq0X9FzFYEmY8l7Xelu9ugVgq+nmYhUNklBsG+epoJI6toKZrr5cC+yfywPY8VdX5ePhWte4pYHHEhtAYZ/4ReWANpIZHm+TVO3ca8rwrKQ4O/rbirGnCENI3sA=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB0252.namprd04.prod.outlook.com (2603:10b6:3:6f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 30 Dec
 2021 05:23:16 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e58a:8ae5:2f73:35ea]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e58a:8ae5:2f73:35ea%8]) with mapi id 15.20.4844.013; Thu, 30 Dec 2021
 05:23:16 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: canaan: remove useless select of non-existing
 config SYSCON
Thread-Topic: [PATCH] riscv: canaan: remove useless select of non-existing
 config SYSCON
Thread-Index: AQHX/O3cc7ndk+KhFk2dULDeAuPYaaxKgNQA
Date:   Thu, 30 Dec 2021 05:23:15 +0000
Message-ID: <4cffedae85c9d847a5285a2f91cb369c48ebe9c9.camel@wdc.com>
References: <20211229192458.25138-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20211229192458.25138-1-lukas.bulwahn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.2 (3.42.2-1.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a3b6c44-c4db-4d56-a019-08d9cb547b92
x-ms-traffictypediagnostic: DM5PR04MB0252:EE_
x-microsoft-antispam-prvs: <DM5PR04MB02526141F8E4FF3043F55E91E7459@DM5PR04MB0252.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rh3DddSd3hkGNgReWe9CoKTXFLNmzYg/02ebsGGzTuu109vDMOqnzyY6t5Q3ld1pIOGmux8uogkO8ZAI0JbaT9os7eXB9dzy9+1+YiZ1FIbFYPLCSyZwpl/lM1vawKKuiuS2aHhPizwoGXNC9+QvyRP9ex1vel5/utu88Xfc6puCQd5qUnualmTWhi4TR6RLxDyTo7eQa0NjYHt/1ZJp86dP635jn2KgZWnsWOy+MNpZwYg1M1bKkqBKSRI2DtMc+lfROgq4twH+cQ4RHV33AzOW2atLyotkn7P1mzZVxyYjvpbdYngG86Jy+5mPyWuSdpO7Psgo6gDNG1q4xaDgR6pExkpJblYRgoAcGkSOOERr4CLYbQq7gsDanyWSkWyhZo7IdxpcMx7ieqkUWHqJ+UPWKaIeBo/vzfMO56lGzVl1Bbc235lIuB2Wm6t9edKS+ATgI4vipgBcQ8ehypPNFCY7dRbqTCJJhktsQCzTjqyREybkX8Z5ZlWyZHBjZ/QTwHAqWc4Wj+bCo8XbnrGzEaeJ9t+F6Wk2X9qx/tLC7nkvFLGLg1lyBwXIsyqtjWR+Fv+yMQMNmrLrjdDCOK2+H+kZINso7aNfG3Y63l8DCgjLsS8AduhTgkdEkTb1TZ99F62m7+7rxeSx4jGiRVh26QZLxFrBmpYmkMieQWzgZ84CvueCEGIYOQlAX0Pwupvt9ZyCsDo7s4VsUwt2kwRgjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(316002)(508600001)(54906003)(4001150100001)(110136005)(2906002)(66946007)(186003)(66446008)(86362001)(38100700002)(5660300002)(26005)(64756008)(4744005)(36756003)(66476007)(91956017)(76116006)(6486002)(38070700005)(6512007)(122000001)(83380400001)(2616005)(8936002)(82960400001)(8676002)(4326008)(6506007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2MrVnlLN2w4QlA3aFVaTkRzWnVWU2l6UFFoQnhFSHVJaEEvL0xjejltdWV3?=
 =?utf-8?B?UzFtdHcwY0k4MFJZVXpEU2dBR0wxaUx0V0xsZVk3U1p6dVBVZWE0R2ZTd0pw?=
 =?utf-8?B?ZjRabTNKSFVleEpwblhvYzZ4YVZHRzUrK3N4ZnpSZ1dsZzJMN2xoRjk5SU5O?=
 =?utf-8?B?UEl6dDBZOWRjNThMcCt3ajhFcmk2UUZIb2loWDh0Q1dpUS9iMjBLelhHSVRi?=
 =?utf-8?B?ZWtKbjUvM3J5eGEyZFo1ZmtOZkorTDZQQW1lMytUYXdTT2dzd0pPKzk1UkFv?=
 =?utf-8?B?YVpaL1hsOWp6ZmRGM0RXRm5rRUdpRDkyS3lMcVE4TVRTZ3VtbGxIclRQdSth?=
 =?utf-8?B?WWJNUDU5L2FVNHI3eWlWRStwSW1XVTVhanE4aHMvR1JKeDdhYXdiOXh4NGU2?=
 =?utf-8?B?SFJYeDVwL3hnaWpFdkUvaVJFbkhZeU9DRzBTTFZoaEVCb01JUjVHdzhaNE9s?=
 =?utf-8?B?V09MT1NRQ1E3b011WFVTb1lRbmw0b2FXTkFwMmc3NDA1MmgvaXJ4dzExOFRU?=
 =?utf-8?B?TnRyOHpLWi9HT0IwT0hZcmlWWlB5Wmh0R3FOWDdOZmY0Z2NXVjdEcDR4QURB?=
 =?utf-8?B?Z1psbTZObVIzT2RvZTN1dVlPSlFMZ2Q5WmpSLzRYMk9Kcko4a0VBYlpTc2lC?=
 =?utf-8?B?QjVHeWtVZzJKdmU4cjFKUVZlWmh0SGw4TUl4cWZWb0VZTVdaYmpTS1c1TmdV?=
 =?utf-8?B?RXVCWU0rTEZkT21FZjY5d2NocW13MzRiakQvSlFFMFE1ekg4SGp3WEJMVGd6?=
 =?utf-8?B?RExBTGNWRDhYbk5NM3JPSHRBbUdVU2VwdjdZaisybnRUMHQ2Y3ZzSUZ2elMz?=
 =?utf-8?B?NjlRZWpIS0xsWUExaUxBZkozQTRpVEtuWGhWTzlhbWlQeC84Tnk5NDlDbWpu?=
 =?utf-8?B?OXdONmY0cXdsS1FHbDRqWko2WlNSYmFLbHVNdUdmSzVWQ212dXpvT3BRbWJ2?=
 =?utf-8?B?elljekM3bytiRXMzUkprMDE0cVlYeHM4ZUxaSVAxckZ6dFl2NERxWGliR0pk?=
 =?utf-8?B?TXlHSDBRQ0I4ajBhQkZpeE1OTEJzZGUrZ1RIS05OdHhLMUxJTFA5Vmd6Tm5O?=
 =?utf-8?B?WjhzNXYxSWxaUHBoa1hCWDJpakhuY3F6S3Znc1VjRXZQWDlrd1FPK0dWTjg1?=
 =?utf-8?B?bXUrWmgyVnYvNjR5ZmVULzJGT0dTb1BDRi95OWdZcHVGTURyZUQyNmtXaG1I?=
 =?utf-8?B?dWN0cmJwOVNqcDFBZGIxUm1QZ1A3Q3JzN2JrV0FUZ0VqRUg1TGlsejFNQkNh?=
 =?utf-8?B?WW1TVjZFREQ1YkJJWkZLOEc4bzlaUjJCTm1GYnh0MnB3TFBzNUxhWTFiSXVY?=
 =?utf-8?B?WUt2Si9NYkFKc0RmWGduaGNtRTVhSnR0TzlPVE1YZWk0aWZYRDZ5ZmoxbDVR?=
 =?utf-8?B?U2dVYXdpTE1WN0JWL1NQckhZQmhWcUk2NUthS2hSSGJIQ2ZiOFFKN1ZsYTB5?=
 =?utf-8?B?clpLczN3STFrUk1hNWFNN1RGTkxyOHowYmFPRGFEZ0sweFBWSURwV3JrS3Ji?=
 =?utf-8?B?VUJEbDdTQXJ3TEJZelhyc0tzbWhSVU1UcGJCUjMrS285QkVid2FZUmt4b1hW?=
 =?utf-8?B?Ui9JcElYanVwV1lvU3ZhV2w4TkczVitmOXM0djhyREIrc29QNmJZbWR5NHgx?=
 =?utf-8?B?TmtBTS9MR1pkaXhjTVAwQm9GY3FjSkJ0dThrZnNRYnZ6c2FCNVF3Y3BuNTM3?=
 =?utf-8?B?NE82MkpwSGtrMUdnak9YOEE4ekxJQno1a2ptMVlnS25QdE1KQ1N5ZEVlYVJz?=
 =?utf-8?B?anFyemFDWXpBcnQzZVFtNk1RczRUR1p5ZFVkMm5NblJIZ3pUVmxzM3RESlYx?=
 =?utf-8?B?a1FSQk56VWhacXJta3prL2hPV3FaY0pUbXFzZGNUNVhaV0gwTGt6aHFNbVNG?=
 =?utf-8?B?M3NOdmNSUklDNis0ZFJqa0RYdFJkK251ckRVN0l1Y0p1N3dQR0p3c3luUmlB?=
 =?utf-8?B?YkhkeUlxWmRCS3pmWkcvTDZIRG9wMTAwN0J6N0Q1V3BKZ0FHK0YzemlYRFl6?=
 =?utf-8?B?VkZUZ3M5OFl4ejhsdklXNy9BUlcvRWpGdEJvZCs4OXRUcW1TSXhwdEpUYmVt?=
 =?utf-8?B?bTlvYlRCb0k4VWNCWlpZVXhzT3dPN3gvSXpTNHRISEtJd1RsbWxJMDI0MjVj?=
 =?utf-8?B?bzVVdXZlWkdEYUxnNTJoVGQyVWZhSTZxUUFjNTdzemtVR3Q4dDhGVmtuWVVm?=
 =?utf-8?Q?GTeXvoFSw4Xw/lzN3OZaawo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72E372D5F33F9A4D8544E776B53D4908@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3b6c44-c4db-4d56-a019-08d9cb547b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2021 05:23:15.9272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCsFP73SZhY0HDI8J0z2t9AtTxTD+x7UXVbgwB42n4TkuK2srI2aqCWdkMfj0B9YNDoebyLCCdFXmbU/XfyqcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTEyLTI5IGF0IDIwOjI0ICswMTAwLCBMdWthcyBCdWx3YWhuIHdyb3RlOg0K
PiBUaGUgY29uZmlnIFNZU0NPTiBuZXZlciBleGlzdGVkIGluIHRoZSBrZXJuZWwgcmVwb3NpdG9y
eTsgc28sIHRoZSBzZWxlY3Qgb2YNCj4gdGhhdCBjb25maWcgaW4gLi9kcml2ZXJzL3NvYy9jYW5h
YW4vS2NvbmZpZyBoYXMgbm8gZWZmZWN0Lg0KPiANCj4gUHJlc3VtYWJseSwgdGhpcyB3YXMganVz
dCBzb21lIG1pc3Rha2UsIGFzc3VtaW5nIHNvbWUgc3ltbWV0cnkgaW4gaGFuZGxpbmcNCj4gYW5k
IG5hbWluZyBvZiBjb25maWdzIHRoYXQgc2ltcGx5IGRvZXMgbm90IGV4aXN0Lg0KPiANCj4gUmVt
b3ZlIHRoaXMgdXNlbGVzcyBzZWxlY3Qgb2YgYSBub24tZXhpc3RpbmcgY29uZmlnLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTHVrYXMgQnVsd2FobiA8bHVrYXMuYnVsd2FobkBnbWFpbC5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9zb2MvY2FuYWFuL0tjb25maWcgfCAxIC0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvY2FuYWFu
L0tjb25maWcgYi9kcml2ZXJzL3NvYy9jYW5hYW4vS2NvbmZpZw0KPiBpbmRleCA4NTMwOTZiN2U4
NGMuLjI1MjdjZjU3NTdlYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvY2FuYWFuL0tjb25m
aWcNCj4gKysrIGIvZHJpdmVycy9zb2MvY2FuYWFuL0tjb25maWcNCj4gQEAgLTUsNyArNSw2IEBA
IGNvbmZpZyBTT0NfSzIxMF9TWVNDVEwNCj4gIAlkZXBlbmRzIG9uIFJJU0NWICYmIFNPQ19DQU5B
QU4gJiYgT0YNCj4gIAlkZWZhdWx0IFNPQ19DQU5BQU4NCj4gICAgICAgICAgc2VsZWN0IFBNDQo+
IC0gICAgICAgIHNlbGVjdCBTWVNDT04NCj4gICAgICAgICAgc2VsZWN0IE1GRF9TWVNDT04NCj4g
IAloZWxwDQo+ICAJICBDYW5hYW4gS2VuZHJ5dGUgSzIxMCBTb0Mgc3lzdGVtIGNvbnRyb2xsZXIg
ZHJpdmVyLg0KDQpNeSBiYWQgOikNCg0KUmV2aWV3ZWQtYnk6IERhbWllbiBMZSBNb2FsIDxkYW1p
ZW4ubGVtb2FsQHdkYy5jb20+DQoNCi0tIA0KRGFtaWVuIExlIE1vYWwNCldlc3Rlcm4gRGlnaXRh
bCBSZXNlYXJjaA0KDQo=
