Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B114D9799
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346587AbiCOJ0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346576AbiCOJ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:26:31 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6921D369C4;
        Tue, 15 Mar 2022 02:25:19 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 15 Mar
 2022 17:25:17 +0800
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by
 IT-EXMB-1-125.meizu.com (172.16.1.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 15 Mar 2022 17:25:17 +0800
Received: from IT-EXMB-1-125.meizu.com ([fe80::7481:7d92:3801:4575]) by
 IT-EXMB-1-125.meizu.com ([fe80::7481:7d92:3801:4575%3]) with mapi id
 15.01.2308.014; Tue, 15 Mar 2022 17:25:17 +0800
From:   =?gb2312?B?sNe6xs7E?= <baihaowen@meizu.com>
To:     Heiko Carstens <hca@linux.ibm.com>
CC:     "freude@linux.ibm.com" <freude@linux.ibm.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYyXSBzMzkwOiBjcnlwdG86IFVzZSBtaW4oKSBpbnN0?=
 =?gb2312?Q?ead_of_doing_it_manually?=
Thread-Topic: [PATCH v2] s390: crypto: Use min() instead of doing it manually
Thread-Index: AQHYOELSbEbPEn7rqU+2mKCQuuOLcqy/o+WAgACIhJI=
Date:   Tue, 15 Mar 2022 09:25:17 +0000
Message-ID: <7842a724b1df489abf4b19ea61604d07@meizu.com>
References: <1647331264-13853-1-git-send-email-baihaowen@meizu.com>,<YjBZR6WoHYj6fvzm@osiris>
In-Reply-To: <YjBZR6WoHYj6fvzm@osiris>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.137.70]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aGksIEhlaWtvDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseSBhbmQgc3VnZ2VzdGlvbi4NCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogSGVpa28gQ2Fy
c3RlbnMgPGhjYUBsaW51eC5pYm0uY29tPg0Kt6LLzcqxvOQ6IDIwMjLE6jPUwjE1yNUgMTc6MTU6
NTENCsrVvP7IyzogsNe6xs7EDQqzrcvNOiBmcmV1ZGVAbGludXguaWJtLmNvbTsgZ29yQGxpbnV4
LmlibS5jb207IGFnb3JkZWV2QGxpbnV4LmlibS5jb207IGxpbnV4LXMzOTBAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQrW98ziOiBSZTogW1BBVENIIHYyXSBz
MzkwOiBjcnlwdG86IFVzZSBtaW4oKSBpbnN0ZWFkIG9mIGRvaW5nIGl0IG1hbnVhbGx5DQoNCk9u
IFR1ZSwgTWFyIDE1LCAyMDIyIGF0IDA0OjAxOjA0UE0gKzA4MDAsIEhhb3dlbiBCYWkgd3JvdGU6
DQo+IEZpeCBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOg0KPiBkcml2ZXJzL3MzOTAvY3J5
cHRvL3pjcnlwdF9lcDExbWlzYy5jOjExMTI6MjUtMjY6IFdBUk5JTkcgb3Bwb3J0dW5pdHkgZm9y
IG1pbigpDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEhhb3dlbiBCYWkgPGJhaWhhb3dlbkBtZWl6dS5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zMzkwL2NyeXB0by96Y3J5cHRfZXAxMW1pc2MuYyB8IDIg
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zMzkwL2NyeXB0by96Y3J5cHRfZXAxMW1pc2MuYyBiL2Ry
aXZlcnMvczM5MC9jcnlwdG8vemNyeXB0X2VwMTFtaXNjLmMNCj4gaW5kZXggOWNlNWE3MS4uYmIy
YTUyNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zMzkwL2NyeXB0by96Y3J5cHRfZXAxMW1pc2Mu
Yw0KPiArKysgYi9kcml2ZXJzL3MzOTAvY3J5cHRvL3pjcnlwdF9lcDExbWlzYy5jDQo+IEBAIC0x
MTA5LDcgKzExMDksNyBAQCBzdGF0aWMgaW50IGVwMTFfd3JhcGtleSh1MTYgY2FyZCwgdTE2IGRv
bWFpbiwNCj4gICAgICAgaWYgKGtiLT5oZWFkLnR5cGUgPT0gVE9LVFlQRV9OT05fQ0NBICYmDQo+
ICAgICAgICAgICBrYi0+aGVhZC52ZXJzaW9uID09IFRPS1ZFUl9FUDExX0FFUykgew0KPiAgICAg
ICAgICAgICAgIGhhc19oZWFkZXIgPSB0cnVlOw0KPiAtICAgICAgICAgICAgIGtleXNpemUgPSBr
Yi0+aGVhZC5sZW4gPCBrZXlzaXplID8ga2ItPmhlYWQubGVuIDoga2V5c2l6ZTsNCj4gKyAgICAg
ICAgICAgICBrZXlzaXplID0gbWluKChzaXplX3Qpa2ItPmhlYWQubGVuLCBrZXlzaXplKTsNCg0K
SSB3b3VsZCBhc3N1bWUgdGhhdCBjaGVja3BhdGNoIHdpbGwgbm93IHdhcm4gdGhhdCB0aGlzIGlz
IGFuDQpvcHBvcnR1bml0eSB0byB1c2UgbWluX3QoKS4uLg0KQW55d2F5LCBpdCBpcyB1cCB0byBI
YXJhbGQgdG8gZGVjaWRlIHdoYXQgZG8gd2l0aCB0aGlzLg0K
