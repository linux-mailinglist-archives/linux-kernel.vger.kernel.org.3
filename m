Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75C0475614
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241584AbhLOKSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:18:11 -0500
Received: from mail-tycjpn01on2091.outbound.protection.outlook.com ([40.107.114.91]:35075
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229757AbhLOKSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:18:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ga7PNDHFZxmbJey7tEew5iGfSSc0vn6zaXixB3gUAx19HJ5QXgGPxlqyVFa6OIsJkF3qaALTk3S61CyvARTdGXAD2225FxmiS2cZ1X7Yvp/8JLV9+NNlzm0kPOmNymSu9PZErDwUT5LJH5Uh6+UEoZ5/h8Iyx879KvMSFke9WLlfZ2+rP7nipji4HyCfmqQBswElFtkN1BYKjKEn/JPms2sB1i/deSbgasbZlg6sZ0T69pMsKnADgGKhPflJjcIxk/IJKOaTNXJnxsHMAGUeiJ71ZW9Bx8F5bF2i1sB/6dupA72I19PUpEMpm4CgL2wOEKkDBzzzhatp5I3Ezz4NNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYVCXGFe9sB5qAnR1+U/9Lmh84QNylP+CSSPEzE9HcA=;
 b=HHqbJBMUpWnfdBXTHqkblqaKxefcJOFcVwYpNBF9yIwBeNzFOaGTwX08OH6ZKRq2vSfiYOBECImhL8icci7ZYreHxoXDN05U3MS7CDLd+FNoG6hJG0u3J4JAxKkIsWhxRwEjEwVO2mntbS2Zz//HJJGsXuR0ihOcBdIsiUh+5VFWmounGSW4Z6EAaOWgJYMqLNdM5pE/eof7758BaAtudtpo44w5KHwZ1XOoy7Xau9P1bcRp9F3X3Oo+bAYQ7ZVa9ZkOizsfacPgUAPxsJDORaLh6eI8Kv2nb/t0G3LD9n02PZiVUxXUB74T/DliM+vxpKADJ67ZR7JOwUxDzPhmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYVCXGFe9sB5qAnR1+U/9Lmh84QNylP+CSSPEzE9HcA=;
 b=AuArxEa1dZqA83Q4ihjk3WIUO1b+eM9rDgEnfViWMuLIrIS1VAsMWDegSwFudjoODHTDsKIjSNry/Jw2psZGt4Jk7gINSuo8wdKuTcraujJ1pMhwpxlBUu+55iQ8cQ0B2+1RByFBDdMVlkCOGNc0PgoSQ7pg/nCuUrLQwP60SdQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB4181.jpnprd01.prod.outlook.com (2603:1096:604:4d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Wed, 15 Dec
 2021 10:18:08 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c0bd:405a:cdd3:f153]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c0bd:405a:cdd3:f153%8]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 10:18:08 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH resend v3] reset: renesas: Fix Runtime PM usage
Thread-Topic: [PATCH resend v3] reset: renesas: Fix Runtime PM usage
Thread-Index: AQHX8ZyTvvSDEnXpk0KdjFtp2puHL6wzViOA
Date:   Wed, 15 Dec 2021 10:18:08 +0000
Message-ID: <OS0PR01MB592202E7612FF6C0F0FCE76086769@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <ec24e13f-0530-b091-7a08-864577b9b3be@gmail.com>
In-Reply-To: <ec24e13f-0530-b091-7a08-864577b9b3be@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f3fe725-888a-4284-1ed0-08d9bfb430d2
x-ms-traffictypediagnostic: OSBPR01MB4181:EE_
x-microsoft-antispam-prvs: <OSBPR01MB418155C34617A770238E6C4586769@OSBPR01MB4181.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: //ievvgaO5tDZvq2P7ILJau+IkqTCBL+PPm3tbE6wDHRAPkEmjLA2Xyi2Glkj/f7aRxmVPRu2JMhW8wDVFpS6Ir4K6aLLaSARb6BvkcIfRHvfvkAEv6gVdexlQNLTkWfeQF+LrNWmqmA1ON+D6kWdPzhCjH+NIIMxnr+VQlbANGrfN0r6aOj8LSLsi4ECAasgbQyKTkTU1wQTVgL85EhCdlyzFVOsaNRV5xJU8To/7c3Sz1XLcSUzxvtBGY1Ia2jqJs0U4xOp+OuyY2loE31JWo6GLwQovlPFCno13nAwP5zEq3+8QZf8uvq931sYmbSDHql3snrtJRDuvXvH8Ah2mnwDzZL3SvwAYcByxMHTvhraqPh2U6is/7K9PV55z1vxOh4TvZ7ecrHM4ksyiSNNuR+n11NvelVHZSenhFYT48j3mtDOqYTSE8b3e6UR8y0LcGVJmSHJuolyOorbgBCRGEqTKfJBMbthwWCTQiJf3YcfV5KYldYL3aDt+0oKXevgynxXWf8qphaXcpBy1GKLXtOfXKx1dEddRNQp0095hNdGSvvzXcZERflOrD0m2BrHt3SEg0rlUmvoJCfm0qrVPR5dDk+lEzFpBrHIn/TYBlHwMA4xXZKXdFCJPFeuf3NIZWW/vIoZrGgYbPsLzo70OsAierRomJpAr2sZbAj9q/oWY79KfzcUsJeWiRsute0RdSL872Lub34fTtbbPoeRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66446008)(64756008)(122000001)(9686003)(186003)(508600001)(66946007)(55016003)(66556008)(66476007)(26005)(4326008)(316002)(76116006)(38100700002)(6506007)(110136005)(8936002)(38070700005)(52536014)(33656002)(5660300002)(7696005)(86362001)(83380400001)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTdYbzhCMnQvUWQwSUFzYitnVC9qa2tZVHNGem85WGJPK0g5YlErWWttcU9h?=
 =?utf-8?B?bjBFT3lRbFRvYklGNkQzekU0T1N6ZllSK3E1UTVNRG10UWRLeGwvMjFoNU9G?=
 =?utf-8?B?TkMrdnNRZXBoQ21BeTBwRElOWkZxTzM3RHpra0RVN0tUcHordjAxWVZLbUN2?=
 =?utf-8?B?R0NVVWk1Y2FqcHRPb3lQYVl3UE5rM0I3VXczd1k5ekJ4UHJ2K0F5ME9QNEM3?=
 =?utf-8?B?QVZiRFM3UjRXaGQ0Nis1MEV4Vnd3Y0NWWFlUa1lEWVc4bktIbXY2TnVmYnBa?=
 =?utf-8?B?YXAzSlUxd2NqOEdBKzA2b2lWTXBiS0JUdWtHU0hJTWJwZG5zNlBDTDNvKytW?=
 =?utf-8?B?QitnUTBjY2hnakpITHFTc3YzWldrN29RSkdDWDVBdW0zRDZSWUJ6SU50cEpt?=
 =?utf-8?B?LzBOVm03bWV5V2RTVDd5L2twRkd3VmswTjBXbnlwaXQ4eEhwVnZhWTNldG13?=
 =?utf-8?B?RFpmVFZvWHhMVUhPcEtCdHYveVlFZmxuWkh0QnoxZEJNMUxPc2pnN3htU3g4?=
 =?utf-8?B?bHNmNjVXL0NqNElMWFU0eDM3QVo3U1NDTE5Sd0swRVhCSHJRTmZlb0pPUXNj?=
 =?utf-8?B?UWNCdjVPMzBCUTRXS3p3ZFh0TVpUaU9Ka0JxWEJDcEFrWVoyWW4xNlNNT040?=
 =?utf-8?B?QlBpR3RCL0s0UWsySHBQeXpnRzVHY3pIKzd1OEgyZ3pvVmNSQXJWNmpGajRq?=
 =?utf-8?B?TldqdG1kRVhwRUFuSkhwRnhFZzJLSFRsTlpJb1JRSzZsZkpVMm9LQlZOOW9J?=
 =?utf-8?B?VWJGRmQ4TmJKMDErSWRwcmlqMVNEcy9NNU1HT0xqVzdVc25IKzJFYm4rVEJ1?=
 =?utf-8?B?bHE1eUhsVUtIcFJ1U1VwUHdzeEFPRmVUdm04OVpyQVNMRWxBME8zVjFweG1F?=
 =?utf-8?B?c0RNZmVnNndlVjBXcmtwd1ZpaHJpekZ3Y3dRejJ3U3NNZ3RaTE5iMEZCTHRW?=
 =?utf-8?B?UW9vNyt2MVhXNnpWUFk5WTdab281Vmt1RldST01YdjhMc0I0c09mOXo0MkRQ?=
 =?utf-8?B?RmczbWJ5bTkxM2pyQW12L2pNSnhxZHZ3cGNkbnAyRVk0amlicXFDVDJUMmx5?=
 =?utf-8?B?TFViVTk0aGNTZWJELzB2eWxKQzV3ZldyWEIvdE5jSTdhekQwNzNSMXlSQjNh?=
 =?utf-8?B?cmZpT0d3YUFyWXF4NHVEbnR1TWYxS2tTcGo2b2UrSFFlS3RabGQvZVFPNzU1?=
 =?utf-8?B?YU0zaWk4L3ZLVzFoTGFUd01lOEVORlZYc0pTR3U4NXJzYVdLNjFRd2VGQjZ1?=
 =?utf-8?B?bHNtSnNyeTg0RmNQVVRhNTdyNVMveEY5YUppOWw2QWpBUTh2c1p5Y0pBM0NG?=
 =?utf-8?B?b05RRlpxcTJQSG4yQXkrTXFlUW5YZkNMa2FoWkRHWUViWkFTNTFVSjFGWEFq?=
 =?utf-8?B?SVUrNmZ5eE1wS1d2dUVrNHZpeHRoaDVJWVl3MEtmeisxbXdXbDNaTHhqdzlP?=
 =?utf-8?B?SlZTYmJvTzlaWC9YZGZFVDkrUkZHSTJOY2d1ai9xcTgreEtXcjExc0tsNjdX?=
 =?utf-8?B?U0xkZmRlOEdYVnJGelJaMXNoMkQ5bmFkY1RFVUdzNFcvYnRScmRROHAxalp1?=
 =?utf-8?B?eEhlK2Iwei9TS09SMm84QlZzRVM0K2RxM2JueVc2RHVNSDRSS1FnMXM5R1pQ?=
 =?utf-8?B?bDJDc0xwWHdYOUpQSTZ6TENVMk9jUzQwcnEwbXoyWXlScm1zUmFmU0w2VFNr?=
 =?utf-8?B?WHM0eHk5LzZtdzh2a3U0dkdpbXFtSGNQcHByakUvak5RMFh3eDhjbHQ3dXZY?=
 =?utf-8?B?bDRZUnNta2llSEdYZ2MxTGNldWUvT0REajVaRTNLM2NWZmpOWEdhMDlRbE1Z?=
 =?utf-8?B?elAyQ08weUxtNTVrbFQ2ZEJQcjRQS3VNV2E4a1M4cm5wZGEveUlsM1NmdXRH?=
 =?utf-8?B?R1R4bzArWWlRa0tkbVF6VWUzRHBvSDdncEtaaGNzMVN6Q04yeS8zOHY3ZW9Y?=
 =?utf-8?B?cFc3aFA0OWZOVzhGK08xYUw0c1dPWWJ5V3NzSFNlWmdpNmFob0F2WUY4aXpi?=
 =?utf-8?B?UGFnY0VXQnhOaVR5WFd5d1QwSnlna1piNjh5VGdvZ2tJTjNEWmUzNVVQNjI3?=
 =?utf-8?B?YzhCd2FZTW95VXplcUVnZVJYdVR2U05ONkdadCs4ekhZZGwwZm5BRXI0V1g4?=
 =?utf-8?B?R2FwcmkvendjYkdWVnlyY2JyanF4MDZsaWxkbFhDbWhQSWFVMG15c2lKem56?=
 =?utf-8?B?aFZhTk9QR2ZtaUNtbEFFcnMyMnBSS2k3OGVNN1U1QUhjL1pHbUdwMFZNNldl?=
 =?utf-8?B?YnVsdDl2dW10UmZZSlFkTHVGbDlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3fe725-888a-4284-1ed0-08d9bfb430d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 10:18:08.2924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DckqnJahVVLCo4yBFMebKkb2EidVyYDxNHWAoSIo1+IL53RzHjvjOhbD9WhsmNX5BRI1c/E61jkMQUDat3NNJlJYk4PHNoxcUhhYW677jSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4181
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGVpbmVyLA0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaC4NCg0KPiBTdWJqZWN0OiBbUEFUQ0gg
cmVzZW5kIHYzXSByZXNldDogcmVuZXNhczogRml4IFJ1bnRpbWUgUE0gdXNhZ2UNCj4gDQo+IElm
IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoKSBmYWlscyB0aGVuIGl0IHJldHVybnMgdy9vIHRo
ZSBSUE0gdXNhZ2UNCj4gY291bnRlciBiZWluZyBpbmNyZW1lbnRlZC4gSW4gdGhpcyBjYXNlIGNh
bGwgcG1fcnVudGltZV9wdXQoKSBpbg0KPiByZW1vdmUoKSB3aWxsIHJlc3VsdCBpbiBhIHVzYWdl
IGNvdW50ZXIgaW1iYWxhbmNlLiBUaGVyZWZvcmUgY2hlY2sgdGhlDQo+IHJldHVybiBjb2RlIG9m
IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoKSBhbmQgYmFpbCBvdXQgaW4gY2FzZSBvZiBlcnJv
ci4NCj4gDQo+IEZpeGVzOiBiZWUwODU1OTcwMWYgKCJyZXNldDogcmVuZXNhczogQWRkIFJaL0cy
TCB1c2JwaHkgY29udHJvbCBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBIZWluZXIgS2FsbHdl
aXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KDQpDaGVlcnMsDQpCaWp1DQoNCj4gLS0tDQo+IHYyOg0K
PiAtIGJhaWwgb3V0IGluIGNhc2Ugb2YgZXJyb3IgaW5zdGVhZCBvZiBzd2l0Y2hpbmcgdG8gcG1f
cnVudGltZV9nZXRfc3luYygpDQo+IHYzOg0KPiAtIGFkZCBkZXZfZXJyX3Byb2JlKCkgaW4gY2Fz
ZSBvZiBlcnJvcg0KPiAtLS0NCj4gIGRyaXZlcnMvcmVzZXQvcmVzZXQtcnpnMmwtdXNicGh5LWN0
cmwuYyB8IDcgKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtcnpnMmwt
dXNicGh5LWN0cmwuYw0KPiBiL2RyaXZlcnMvcmVzZXQvcmVzZXQtcnpnMmwtdXNicGh5LWN0cmwu
Yw0KPiBpbmRleCBlMDcwNGZkMmIuLjQ2ZmNkMjIxOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9y
ZXNldC9yZXNldC1yemcybC11c2JwaHktY3RybC5jDQo+ICsrKyBiL2RyaXZlcnMvcmVzZXQvcmVz
ZXQtcnpnMmwtdXNicGh5LWN0cmwuYw0KPiBAQCAtMTM3LDcgKzEzNywxMiBAQCBzdGF0aWMgaW50
IHJ6ZzJsX3VzYnBoeV9jdHJsX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ICAJZGV2X3NldF9kcnZkYXRhKGRldiwgcHJpdik7DQo+IA0KPiAgCXBtX3J1bnRpbWVfZW5h
YmxlKCZwZGV2LT5kZXYpOw0KPiAtCXBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoJnBkZXYtPmRl
dik7DQo+ICsJZXJyb3IgPSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KCZwZGV2LT5kZXYpOw0K
PiArCWlmIChlcnJvciA8IDApIHsNCj4gKwkJcG1fcnVudGltZV9kaXNhYmxlKCZwZGV2LT5kZXYp
Ow0KPiArCQlyZXNldF9jb250cm9sX2Fzc2VydChwcml2LT5yc3RjKTsNCj4gKwkJcmV0dXJuIGRl
dl9lcnJfcHJvYmUoJnBkZXYtPmRldiwgZXJyb3IsDQo+ICJwbV9ydW50aW1lX3Jlc3VtZV9hbmRf
Z2V0IGZhaWxlZCIpOw0KPiArCX0NCj4gDQo+ICAJLyogcHV0IHBsbCBhbmQgcGh5IGludG8gcmVz
ZXQgc3RhdGUgKi8NCj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmcHJpdi0+bG9jaywgZmxhZ3MpOw0K
PiAtLQ0KPiAyLjM0LjENCg0K
