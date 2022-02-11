Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1414B24B9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349596AbiBKLrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:47:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiBKLrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:47:06 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EA4AF16
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:47:04 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-217-ln17n9CfNWGBOaqr2sn8hg-1; Fri, 11 Feb 2022 11:47:01 +0000
X-MC-Unique: ln17n9CfNWGBOaqr2sn8hg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 11 Feb 2022 11:46:59 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 11 Feb 2022 11:46:59 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Masahiro Yamada' <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
CC:     Ryan Cai <ycaibb@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kconfig: fix missing fclose() on error paths
Thread-Topic: [PATCH] kconfig: fix missing fclose() on error paths
Thread-Index: AQHYHhxu7b1VG5ftFUSTiQXyYGw6EKyOPQUA
Date:   Fri, 11 Feb 2022 11:46:59 +0000
Message-ID: <37efb2079f5443feaf4f0b10e15a57db@AcuMS.aculab.com>
References: <20220208062618.1869210-1-masahiroy@kernel.org>
 <CAK7LNASojfnOaAmgwwCsA9J-nhYtRzJx8AKmy8OpRm50uWfegQ@mail.gmail.com>
In-Reply-To: <CAK7LNASojfnOaAmgwwCsA9J-nhYtRzJx8AKmy8OpRm50uWfegQ@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFzYWhpcm8gWWFtYWRhDQo+IFNlbnQ6IDEwIEZlYnJ1YXJ5IDIwMjIgMDA6NTQNCj4g
Pg0KPiA+IFRoZSBmaWxlIGlzIG5vdCBjbG9zZWQgd2hlbiBmZXJyb3IoKSBmYWlscy4NCj4gPg0K
PiA+IEZpeGVzOiAwMGQ2NzRjYjM1MzYgKCJrY29uZmlnOiByZWZhY3RvciBjb25mX3dyaXRlX2Rl
cCgpIikNCj4gPiBGaXhlczogNTdkZGQwN2M0NTYwICgia2NvbmZpZzogcmVmYWN0b3IgY29uZl93
cml0ZV9hdXRvY29uZigpIikNCj4gPiBSZXBvcnRlZC1ieTogUnlhbiBDYWkgPHljYWliYkBnbWFp
bC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFzYWhpcm8gWWFtYWRhIDxtYXNhaGlyb3lAa2Vy
bmVsLm9yZz4NCj4gPiAtLS0NCj4gDQo+IA0KPiBBcHBsaWVkIHRvIGxpbnV4LWtidWlsZC9maXhl
cy4NCj4gDQo+IA0KPiA+DQo+ID4gIHNjcmlwdHMva2NvbmZpZy9jb25mZGF0YS5jIHwgMTIgKysr
KysrLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9rY29uZmlnL2NvbmZkYXRhLmMg
Yi9zY3JpcHRzL2tjb25maWcvY29uZmRhdGEuYw0KPiA+IGluZGV4IDU5NzE3YmUzMTIxMC4uMTY4
OTdjYjhjZWZkIDEwMDY0NA0KPiA+IC0tLSBhL3NjcmlwdHMva2NvbmZpZy9jb25mZGF0YS5jDQo+
ID4gKysrIGIvc2NyaXB0cy9rY29uZmlnL2NvbmZkYXRhLmMNCj4gPiBAQCAtOTc5LDEwICs5Nzks
MTAgQEAgc3RhdGljIGludCBjb25mX3dyaXRlX2F1dG9jb25mX2NtZChjb25zdCBjaGFyICphdXRv
Y29uZl9uYW1lKQ0KPiA+DQo+ID4gICAgICAgICBmcHJpbnRmKG91dCwgIlxuJChkZXBzX2NvbmZp
Zyk6IDtcbiIpOw0KPiA+DQo+ID4gLSAgICAgICBpZiAoZmVycm9yKG91dCkpIC8qIGVycm9yIGNo
ZWNrIGZvciBhbGwgZnByaW50ZigpIGNhbGxzICovDQo+ID4gLSAgICAgICAgICAgICAgIHJldHVy
biAtMTsNCj4gPiAtDQo+ID4gKyAgICAgICByZXQgPSBmZXJyb3Iob3V0KTsgLyogZXJyb3IgY2hl
Y2sgZm9yIGFsbCBmcHJpbnRmKCkgY2FsbHMgKi8NCj4gPiAgICAgICAgIGZjbG9zZShvdXQpOw0K
PiA+ICsgICAgICAgaWYgKHJldCkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC0xOw0KDQpU
aGVyZSdzIG5vdCBtdWNoIHBvaW50IGNhbGxpbmcgZmVycm9yKCkgdW5sZXNzIHlvdSBjYWxsIGZm
bHVzaCgpIGZpcnN0Lg0KDQpTaW1pbGFybHkgdGhlcmUncyBhYm91dCB6ZXJvIHBvaW50IGluIGNo
ZWNraW5nIHRoZSByZXR1cm4gZnJvbSBmcHJpbnRmKCkuDQpBdCBsZWFzdCBJJ3ZlIG5ldmVyIGZv
dW5kIGFueSBkaXN0cm8gYWRkaW5nICdtdXN0X2NoZWNrJyB0byBmcHJpbnRmKCkuDQooJ211c3Rf
bm90X2NoZWNrJyB3b3VsZCBiZSBtb3JlIGFwcHJvcHJpYXRlISkNCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

