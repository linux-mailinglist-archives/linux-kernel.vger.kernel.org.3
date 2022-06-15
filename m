Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2EA54C2BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346709AbiFOHjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbiFOHjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:39:23 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2053.outbound.protection.outlook.com [40.107.113.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C04393DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6H4mHbt5ei0IgjGYIXwbpq2QuYQ0CJ2TAQ36Crh5+Esz+nJYGYqpHqO/APB8HARB9Cvj2uyglxUe3r7k2whwuCrgonML40GKcbAYs95W9wFeG6V+qo8NZ0fmLEyaNyD6lnzWPQUngk/w50eWEA/u2e6QXLARlEYvuXgyHSWMbWSyZBoi3cDPS7XxC4pSZ99s5PdPH/j6plOugTphO39/mCOmSf2pwycLa1KNLsVqi9OVbawcf/PUsWJxiJ79u99OAoQ7w8DCUkvJ1W6KOSeXNdKX1tIqlq92QYiAMvZDBRtbssTqQkpqeh1+65zv3Ryx4KY67SrN0CCMawhcZH4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tvVBxtMj9lhs3M+IBtzzT346HUceXqsrY9Gvpm2LZs=;
 b=kVGBelF6mTCQEq0Pyc4PP/SEZgEwG+7ijhonarsfJLC6ylDaY3Z23UG7/JmXRfhmNlW0rj4NE1GiT6Z5pdnMPjFD71nH79BjmvgNEGzILbZ+SRPh5HHOORaU2ZirPZOYSHnKVIS2dvMmepFhgFwoDzN1q9sqBCx5N1CfCLcpmgyJcL8F3SBSn140GgxwMSU+qn3KNl5jwN4V0LlXnUrNkUqqPJ7A1sxZ9vBDLbJH3StnqHQKbF7Tw9kV5uRJMiTnvjW4mMzbS7D2edsf6W6J66aP/jjNW5rKKSbhP/v7/mJGD+pL624lu02RjEHTOAAMWJIBfZwqVdV39o1fYLHjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tvVBxtMj9lhs3M+IBtzzT346HUceXqsrY9Gvpm2LZs=;
 b=E4dAx56bg9xAyZEbtFDcNvhr+odV+3qonGZ1U7kiHGnGZd4ZJ/bon2Z0NqiribOSxzOpsVsvaw6RQJBtI2HIgV0qgb6vWSY22fDGxAwrPCU20b61ukdz6EIEl3fRmMBt+pUiJuejo0SMKX6NZV0VvX5eBple19ykOeaEx5YOO2g=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSZPR01MB6565.jpnprd01.prod.outlook.com (2603:1096:604:f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.11; Wed, 15 Jun
 2022 07:39:20 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::b00f:b11:37c6:29d0]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::b00f:b11:37c6:29d0%4]) with mapi id 15.20.5332.023; Wed, 15 Jun 2022
 07:39:20 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>,
        zhenwei pi <pizhenwei@bytedance.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: Re: [PATCH v5 1/1] mm/memory-failure: disable unpoison once hw
 error happens
Thread-Topic: Re: [PATCH v5 1/1] mm/memory-failure: disable unpoison once hw
 error happens
Thread-Index: AQHYgFxZplLfJ1ijo0OLciOaJo4Kla1P3rsAgAAPN4CAAAlrAIAAHfWA
Date:   Wed, 15 Jun 2022 07:39:20 +0000
Message-ID: <20220615073919.GA1663556@hori.linux.bs1.fc.nec.co.jp>
References: <20220615020005.246295-1-pizhenwei@bytedance.com>
 <20220615020005.246295-2-pizhenwei@bytedance.com>
 <Yqle3M18fuEJE0qn@localhost.localdomain>
 <dbe19d10-beb1-bbdc-7935-3e1cfa46e3e8@bytedance.com>
 <YqlzhlrjJhqvUV4I@localhost.localdomain>
In-Reply-To: <YqlzhlrjJhqvUV4I@localhost.localdomain>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44235951-a195-48e1-19c5-08da4ea228dc
x-ms-traffictypediagnostic: OSZPR01MB6565:EE_
x-microsoft-antispam-prvs: <OSZPR01MB65654132416DCC9BF8B165A7E7AD9@OSZPR01MB6565.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2i1XugGmYYIZQJxIOzT/wjO3Rxt7qbmO5aBL7Hdsm8uBmYu8U0yXUs/LGyH/Y8ChrFsgktPuwkCFM16i1tInKGcOi4fgZnve+QG0JmtzC9K+/3hX2qYV8Ht79DT6tRmqZypVQFTLls/oR20mKZz6HX60b4dt1zTVSvSy49+AEAQiXFb+SRxyEz/VvuFx5M02f7XcwZSftnMXC8soBEvkdGfSO0hlQDud0ZhD83XBbQIZYA5Dc5zCea8fGn9WFls8p2Oev77nI3dahiLNDrcEtgH1rfEoGz6KsKhSNbe5Nb0vmt1p+sP9TT+eGOs6APviN7N0gdxC8TrErppYETM+h/9ROljoo+yipfiLDimVkyV7ghHNbO+65oYFJGE4MVSy3DdziFLQdgBVCQj125T5wvbmYRBFZa6jcdzYs0hs3MOF9X06UHRb69e1XAPi5xfcos/8vUPl6iiuHEQf7oHw7FlF+vsbkueU73z/wUFK/n/JjVZFMWCgrBdJ+v0Qtx19hdmkHfjbzr2VuI+r04j2zS/xBjxSr5T0cdegOMd0O0eHNiTTzoqRNTWhCefVCXFX9XjIgfvQCOmyO+8VjepDkyZTcFARNuQuLUqShLM6f8ZGEFgflUFXZe+S54ZKAko61AngWjn0Sl1XA2VV2mOxLUQhmRQCEuQyWrpzAtjd5rR733GvKdq7mqBNif8mAovK/yq+gY0RnOpmyQHfRV3RQ6kabCTMlkBuyr9B4oGuruVJbtu4n/n9DC71sXzPGTSm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(55236004)(122000001)(5660300002)(66476007)(64756008)(66556008)(6486002)(66446008)(86362001)(8936002)(71200400001)(508600001)(8676002)(2906002)(33656002)(76116006)(66946007)(4326008)(82960400001)(83380400001)(6512007)(26005)(6506007)(316002)(85182001)(38070700005)(1076003)(110136005)(38100700002)(186003)(54906003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFR1RWpqS3UrOFNpMlBqTzJieG0wVFlQOTE2TzQ3QTNsaTY0UHZpbFZkY1ZS?=
 =?utf-8?B?dW1tZ3pVMDlJNmJjMGlwTmU2SVNleEQxalhza3pidHU3czlGN1dnSTF6Nzkw?=
 =?utf-8?B?TWtpTnFJTXB4QW1iSWl5UE5yK2VBRUxHSnBsZWZDdS9xTG9mZy9ZelB1cURk?=
 =?utf-8?B?R3htVmV6TzFIUTRpSHpTRHhsZkR2L255TWE2RVRFS0tGS05ZbFNvNG81QUJS?=
 =?utf-8?B?d2RvOEYvbGIvSitLZy8rdlVRaVNEQldxNnFMZm0ySkcxdExWdEplZmM3SThE?=
 =?utf-8?B?TWI2YzdpYTZibzY3RVlubjc0YzZEeG02Mld0STluZElCOGZCWS9YVDBHSlc2?=
 =?utf-8?B?T2d1Rnk0Mk02UmlOemRBOTFVVzdhbWpYaFlybElrN0U2Tk9wMnZzcDR2d0J4?=
 =?utf-8?B?RUwrZitTTVZueFJxQUZRaEUvUURMU0tickNZUkJpYVNmUkhMRU5nc1R3Y2Fm?=
 =?utf-8?B?Zi80dWJNejZUc3dFZVdDaXA3bjc2K1V1Kzl6RVhvRVhDYWhXYUpkQlFEcWhw?=
 =?utf-8?B?T1VHb0pVL2xyK0M4RXFId1FuY2Z4b3RUSndFQUpKd01tRktrTDNKdG1ianZH?=
 =?utf-8?B?ZDVEU1RKcFZNUzRXN1R1OFlsQnhkV0dnbVp0Y2F1TC9sblpqZmgzZ2dCc0Er?=
 =?utf-8?B?UGFqOHRZSkhMdXc0QUNxUTVQZkI4NGpING9mR25qVXZNOWpDZUF2LzdURXZS?=
 =?utf-8?B?RlowNkVKSzd6cHFSanpWYWRSUnJBeG03Wk5mU3YzN1FnbTIxOC8yUDl4NlBZ?=
 =?utf-8?B?bmwwbHFtUjNTNDkyeW5FZ1ZXUFlERGVOK2RMaHJSTXVkcE9TbnNTK3ROaEJh?=
 =?utf-8?B?UUJWemVNV3ZqSGpzTHNwU1ZnandSeFhSV1dKOVA3RmF2NW9kVFVNbzJ4YmZ5?=
 =?utf-8?B?SmNzVXNBL3hPTWtUczhjdXdZZCs1WHJYcnRlaTFsbmR6ZVduRXVzTk5tRVRW?=
 =?utf-8?B?U0dJRjU5VEtFb2NWM0pMSVM3ZlhBcU1GR1EwejJOZUNua2tFa1MxQ0NldHFl?=
 =?utf-8?B?TlRnczlrTkh0T0RkazczZVRHMlA4dkRZZ1lKVGJmVm0wN3lsQzd0ZEpvREFR?=
 =?utf-8?B?aFdIMnY2Y0ZNVlJRdkxkZW95cmZJc0tISjYzK0hINFhHOHRGSWwyNC96MDN6?=
 =?utf-8?B?b3FWYjVXbWsrcVIxOUUwZW52SmE3ZmFnTGpKOFVzM0x2OEVYNExZQVpRUWhG?=
 =?utf-8?B?aCtJOGlCZFZqalYzQTBMMDZWN1ZLMnZjdlZQbzJmZlJBeEdOcDlVUHlrRXZj?=
 =?utf-8?B?Mjl6MGNCTVNiaTlmWmVBY2t1M0kvTnByMlNuVjhjQVFzOUhkUFlIR2ZreWN4?=
 =?utf-8?B?a3ZqQUIyOHJTakJkejZTZzNOVFZOTWJVcWVKb2pEb2RidHkzOXhqbXJtUlJD?=
 =?utf-8?B?OFhFYXZMNkZTdEs1cFFXRjFueUZhQ2JWSS9panBQS05OcW1DeTA2YVFHM3A4?=
 =?utf-8?B?YTFaSG11UWc5Z1NOQ2RtS1dWRUZqQlBOTlUzZ0I2b2Q2WHV5MWMxTXVBU1Vu?=
 =?utf-8?B?WUE0WGJSU01uS0thWXVHQUFXQTg2TE45MmY3L1pNUmxpZ1lNZnIvaTFQZUtW?=
 =?utf-8?B?YXNTTXFFZy9yY3hLWjRnVFU0R3ozK2NkWUhPUmJtSGJJc0MzbnpaVjd1LytN?=
 =?utf-8?B?RzloNHVYNDF4YnNDaGt0aEI0UzBXOXVkMzlMM2o5ZDR3NjVwMlMrZkJacDlw?=
 =?utf-8?B?VGdFUDNjeVV3NUpBWU1ZQTFBcGJrbXkxS3IyVGVubHRZcTZnV0R6TEFVNk0y?=
 =?utf-8?B?OENYSWZ0WG5PL2ZMUXdlVjg5OENxK0hMSmt2K1R3NGtrdVA2UXdxSXJOTDBD?=
 =?utf-8?B?TFM0REU5a0ROYUtwWUpkd0RScktIQWl2c005VjdYWFNqRFdBOWNqc3NKMzZE?=
 =?utf-8?B?eHZpWHl2UUpVYWNwZjlLN1NrTmFFNkhqSVNtclNxRHIyS25yL2Y3NFhwM1VC?=
 =?utf-8?B?RFR6ZnpJazdybW14d052V2ROcmUyVGEzbGhTUFUrTzhveGxIVGQ1UlkyaW1J?=
 =?utf-8?B?WVZGMFNQTHVLQnNHV3ZoU1FZdzAzeHpqbzVRVXplb0ttZmlwSUFtOVhwbUYr?=
 =?utf-8?B?RjJISVNCNGtOWmxjdno5cUUyeEp0RlFFUFl4Rkg0SFAzOGxwc2RQQVF6Szda?=
 =?utf-8?B?M2w0bGRqR21VbE5vQWg0L3d0bEF0MnFTWVdyd21JZzNjb0dtc1ZtVHlrZTIx?=
 =?utf-8?B?NGRwZVFYWGxZa0FuWmk5SUp5RldidWhwZEhheTdFQnFmdVlFK2d5ejdWZHRV?=
 =?utf-8?B?ZTJQcU05dmcwVHVoYUIzR2dqNkhEUFVVY29lM2J5UkRKd2tNR2hIRzE1cXI5?=
 =?utf-8?B?TkxsMURJd3U4VnpESUdmS25jL1hsV3RWVGxzeTAyb3hDeXdjZU9ZRmppMVpk?=
 =?utf-8?Q?eAWV0ur9WCHG5wkQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E18BD5BC51D3044B49129C5B731F0A8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44235951-a195-48e1-19c5-08da4ea228dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 07:39:20.3371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uMuoc7TkySIyU4aqk81G7pBKjXLYpIsuyB10vLAJO/BpOgUE5nFFn25s9iBCWM/bhLbpuFVNymb3KhgFw5sXhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6565
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdW4gMTUsIDIwMjIgYXQgMDc6NTI6MDZBTSArMDIwMCwgT3NjYXIgU2FsdmFkb3Ig
d3JvdGU6DQo+IE9uIFdlZCwgSnVuIDE1LCAyMDIyIGF0IDAxOjE4OjIzUE0gKzA4MDAsIHpoZW53
ZWkgcGkgd3JvdGU6DQo+ID4gSGksDQo+ID4gDQo+ID4gQmVjYXVzZSBtZW1vcnlfZmFpbHVyZSgp
IG1heSBiZSBjYWxsZWQgYnkgaGFyZHdhcmUgZXJyb3IgcmFuZG9tbHksDQo+ID4gaHdfbWVtb3J5
X2ZhaWx1cmUgc2hvdWxkIGJlIHByb3RlY3RlZCBieSBtZl9tdXRleCB0byBhdm9pZCB0aGlzIGNh
c2U6DQo+ID4gaW50IHVucG9pc29uX21lbW9yeSh1bnNpZ25lZCBsb25nIHBmbikNCj4gPiB7DQo+
ID4gICAgIC4uLg0KPiA+ICAgICBpZiAoaHdfbWVtb3J5X2ZhaWx1cmUpIHsNCj4gPiAgICAgfQ0K
PiA+ICAgICAuLi4gLS0+IG1lbW9yeV9mYWlsdXJlKCkgaGFwcGVucywgYW5kIG1hcmsgaHdfbWVt
b3J5X2ZhaWx1cmUgYXMgdHJ1ZQ0KPiA+ICAgICBtdXRleF9sb2NrKCZtZl9tdXRleCk7DQoNCkkg
dGhpbmsgdGhhdCB0aGlzIHJhY2UgY2FuIGNhdXNlIHRoZSByZXBvcnRlZCBwcm9ibGVtIChod19t
ZW1vcnlfZmFpbHVyZSBpcw0KdW5yZWxpYWJsZSBvdXRzaWRlIG1mX211dGV4KSwgc28gd2UgbmVl
ZCBwdXQgdGhlIGNoZWNrIGluIG1mX211dGV4IGZvciB0aGUgcHJvcGVyIGZpeC4NCg0KVGhhbmtz
LA0KTmFveWEgSG9yaWd1Y2hpDQoNCj4gDQo+IFllYWgsIEkgYW0gYXdhcmUgb2YgdGhhdC4NCj4g
QnV0IG9uY2UgbWVtb3J5X2ZhaWx1cmUoKSBzZXRzIGh3X21lbW9yeV9mYWlsdXJlIHRvIHRydWUs
IGl0IGRvZXMgbm90IHJlYWxseSBtYXR0ZXINCj4gd2hldGhlciB1bnBvaXNvbl9tZW1vcnkoKSBj
aGVja3MgdGhhdCB3aGlsZSBob2xkaW5nIG9yIG5vdCB0aGUgbG9jaywgZG9lcyBpdD8NCj4gDQo+
IE5vdGUgdGhhdCBpdCBkb2VzIG5vdCByZWFsbHkgbWF0dGVyIGluIHRoZSBlbmQsIGJ1dCBJIGFt
IGp1c3QgY3VyaW91cyB3aGV0aGVyDQo+IHRoZXJlIGlzIGFueSBzdHJvbmcgaW1wZWRpbWVudCB0
byB0aGF0LiANCj4gDQo+IA0KPiAtLSANCj4gT3NjYXIgU2FsdmFkb3INCj4gU1VTRSBMYWJz
