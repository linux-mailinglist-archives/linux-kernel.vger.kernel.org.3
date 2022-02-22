Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD504BF2AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiBVH2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:28:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiBVH2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:28:30 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E30931BF;
        Mon, 21 Feb 2022 23:28:04 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21M7Rrh86004372, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21M7Rrh86004372
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Feb 2022 15:27:53 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 22 Feb 2022 15:27:52 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 15:27:52 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::a0f1:14d7:38a1:7026]) by
 RTEXMBS01.realtek.com.tw ([fe80::a0f1:14d7:38a1:7026%5]) with mapi id
 15.01.2308.021; Tue, 22 Feb 2022 15:27:52 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Ricky WU <ricky_wu@realtek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
Thread-Topic: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
Thread-Index: AQHYJ7nTpeKajlBmYU+vTOb/+dRQew==
Date:   Tue, 22 Feb 2022 07:27:52 +0000
Message-ID: <fb7cda69c5c244dfa579229ee2f0da83@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.81.102]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMjIgpFekyCAwNjoyMzowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWZ0ZXIgMW1zIHN0YWJpbGl6aW5nIHRoZSB2b2x0YWdlIHRpbWUNCmFkZCAiSG9zdCBwcm92aWRl
cyBhdCBsZWFzdCA3NCBDbG9ja3MNCmJlZm9yZSBpc3N1aW5nIGZpcnN0IGNvbW1hbmQiIHRoYXQg
aXMNCnNwZWMgZGVmaW5pdGlvbg0KDQpTaWduZWQtb2ZmLWJ5OiBSaWNreSBXdSA8cmlja3lfd3VA
cmVhbHRlay5jb20+DQotLS0NCiBkcml2ZXJzL21tYy9ob3N0L3J0c3hfcGNpX3NkbW1jLmMgfCA3
ICsrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL21tYy9ob3N0L3J0c3hfcGNpX3NkbW1jLmMgYi9kcml2ZXJzL21tYy9ob3N0L3J0
c3hfcGNpX3NkbW1jLmMNCmluZGV4IDJhM2YxNGFmZTlmOC4uZTAxNmQ3MjBlNDUzIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9tbWMvaG9zdC9ydHN4X3BjaV9zZG1tYy5jDQorKysgYi9kcml2ZXJzL21t
Yy9ob3N0L3J0c3hfcGNpX3NkbW1jLmMNCkBAIC05NDAsMTAgKzk0MCwxNyBAQCBzdGF0aWMgaW50
IHNkX3Bvd2VyX29uKHN0cnVjdCByZWFsdGVrX3BjaV9zZG1tYyAqaG9zdCkNCiAJaWYgKGVyciA8
IDApDQogCQlyZXR1cm4gZXJyOw0KIA0KKwltZGVsYXkoMSk7DQorDQogCWVyciA9IHJ0c3hfcGNp
X3dyaXRlX3JlZ2lzdGVyKHBjciwgQ0FSRF9PRSwgU0RfT1VUUFVUX0VOLCBTRF9PVVRQVVRfRU4p
Ow0KIAlpZiAoZXJyIDwgMCkNCiAJCXJldHVybiBlcnI7DQogDQorCS8qIHNlbmQgaW5pdCA3NCBj
bG9ja3MgKi8NCisJcnRzeF9wY2lfd3JpdGVfcmVnaXN0ZXIocGNyLCBTRF9CVVNfU1RBVCwgU0Rf
Q0xLX1RPR0dMRV9FTiwgU0RfQ0xLX1RPR0dMRV9FTik7DQorCW1kZWxheSg1KTsNCisJcnRzeF9w
Y2lfd3JpdGVfcmVnaXN0ZXIocGNyLCBTRF9CVVNfU1RBVCwgU0RfQ0xLX1RPR0dMRV9FTiwgMCk7
DQorDQogCWlmIChQQ0lfUElEKHBjcikgPT0gUElEXzUyNjEpIHsNCiAJCS8qDQogCQkgKiBJZiB0
ZXN0IG1vZGUgaXMgc2V0IHN3aXRjaCB0byBTRCBFeHByZXNzIG1hbmRhdG9yaWx5LA0KLS0gDQoy
LjI1LjE=
