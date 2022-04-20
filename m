Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4F350823D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359848AbiDTHfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359818AbiDTHe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:34:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95AF63B57B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:32:07 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-165-jcx-0iaIPGatONrL5yGJ_Q-1; Wed, 20 Apr 2022 08:32:04 +0100
X-MC-Unique: jcx-0iaIPGatONrL5yGJ_Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Wed, 20 Apr 2022 08:32:02 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Wed, 20 Apr 2022 08:32:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'He Zhe' <zhe.he@windriver.com>, Kees Cook <keescook@chromium.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "svens@linux.ibm.com" <svens@linux.ibm.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC 2/8] arm64: stacktrace: Add arch_within_stack_frames
Thread-Topic: [PATCH RFC 2/8] arm64: stacktrace: Add arch_within_stack_frames
Thread-Index: AQHYU/YpuaYuTiSSXEqj2VkDLnuG5qz4aD5A
Date:   Wed, 20 Apr 2022 07:32:01 +0000
Message-ID: <9e5c394e82ec44e1887ebebe777a97f2@AcuMS.aculab.com>
References: <20220418132217.1573072-1-zhe.he@windriver.com>
 <20220418132217.1573072-3-zhe.he@windriver.com>
 <202204181457.9DE190CE@keescook>
 <b328bed3-ebb9-6fba-9585-79946262c40f@windriver.com>
In-Reply-To: <b328bed3-ebb9-6fba-9585-79946262c40f@windriver.com>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFRoYW5rcyBmb3IgZG9pbmcgdGhpcyBpbXBsZW1lbnRhdGlvbiEgT25lIHJlYXNvbiB1c2Vy
Y29weSBoYXJkZW5pbmcNCj4gPiBkaWRuJ3QgcGVyc3VlIGRvaW5nIGEgImZ1bGwiIHN0YWNrdHJh
Y2Ugd2FzIGJlY2F1c2UgaXQgc2VlbWVkIHJlbGF0aXZlbHkNCj4gPiBleHBlbnNpdmUuIERpZCB5
b3UgZG8gYW55IHVzZXJjb3B5LWhlYXZpbHkgd29ya2xvYWQgdGVzdGluZyB0byBzZWUgaWYNCj4g
PiB0aGVyZSB3YXMgYSBub3RpY2VhYmxlIHBlcmZvcm1hbmNlIGltcGFjdD8NCg0KTG9vayBhdCBh
bnl0aGluZyB0aGF0IHVzZXMgc2VuZG1zZygpLg0KSXQgaXMgbm90aWNlYWJseSBtb3JlIGV4cGVu
c2l2ZSB0aGFuIHNlbmR0bygpLg0KQWxsIHRoZSBleHRyYSBjb3B5X2Zyb21fdXNlcigpIGNhdXNl
IG1lYXN1cmFibGUgc2xvdyBzbG93ZG93bnMuDQpVc2luZyBfX2NvcHlfZnJvbV91c2VyKCkodG8g
YXZvaWQgJ2hhcmRlbmRpbmcnKSBpbiB0aGUgc29ja2V0IGNvZGUNCmFuZCB3aGVuIHJlYWRpbmcg
dGhlIGlvdltdIGdpdmVzIGEgbWVhc3VyYWJsZSBpbXByb3ZlbWVudC4NCg0KCURhdmlkDQoNCi0N
ClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBN
aWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxl
cykNCg==

