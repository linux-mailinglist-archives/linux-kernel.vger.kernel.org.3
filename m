Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37B251BE93
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiEEL6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359540AbiEEL5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:57:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8B48554A9
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:53:34 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-243-yWIO4Up6Mq2IuKgImtOi4w-1; Thu, 05 May 2022 12:53:32 +0100
X-MC-Unique: yWIO4Up6Mq2IuKgImtOi4w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Thu, 5 May 2022 12:53:31 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Thu, 5 May 2022 12:53:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Filipe Manana" <fdmanana@suse.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: RE: [patch 3/3] x86/fpu: Make FPU protection more robust
Thread-Topic: [patch 3/3] x86/fpu: Make FPU protection more robust
Thread-Index: AQHYYG+YWY1FRr4hzkKhJKBT7m/w1q0QJdtA///xC4CAABO40A==
Date:   Thu, 5 May 2022 11:53:31 +0000
Message-ID: <a97e89a40b6e49d497f8e165ef11ec16@AcuMS.aculab.com>
References: <YnDwjjdiSQ5Yml6E@hirez.programming.kicks-ass.net>
 <87fslpjomx.ffs@tglx> <YnKh96isoB7jiFrv@zx2c4.com> <87czgtjlfq.ffs@tglx>
 <YnLOXZp6WgH7ULVU@zx2c4.com> <87wnf1huwj.ffs@tglx>
 <YnMRwPFfvB0RlBow@zx2c4.com> <87mtfwiyqp.ffs@tglx>
 <YnMkRLcxczMxdE5z@zx2c4.com> <87h764ixjs.ffs@tglx>
 <YnOuqh4YZT8ww96W@zx2c4.com>
 <1f4918f734d14e3896071d3c7de1441d@AcuMS.aculab.com>
 <CAHmME9q+1dAg=H2RLDHd=CSCwO4PpL+YYMeDXO6uQ_wD+GNPhg@mail.gmail.com>
In-Reply-To: <CAHmME9q+1dAg=H2RLDHd=CSCwO4PpL+YYMeDXO6uQ_wD+GNPhg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gQS4gRG9uZW5m
ZWxkIDxKYXNvbkB6eDJjNC5jb20+DQo+IFNlbnQ6IDA1IE1heSAyMDIyIDEyOjM2DQo+IFRvOiBE
YXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBBQ1VMQUIuQ09NPg0KPiBDYzogVGhvbWFzIEdsZWl4
bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVh
ZC5vcmc+OyBCb3Jpc2xhdiBQZXRrb3YNCj4gPGJwQGFsaWVuOC5kZT47IExLTUwgPGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyB4ODZAa2VybmVsLm9yZzsgRmlsaXBlIE1hbmFuYQ0KPiA8
ZmRtYW5hbmFAc3VzZS5jb20+OyBsaW51eC1jcnlwdG9Admdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbcGF0Y2ggMy8zXSB4ODYvZnB1OiBNYWtlIEZQVSBwcm90ZWN0aW9uIG1vcmUgcm9i
dXN0DQo+IA0KPiBPbiBUaHUsIE1heSA1LCAyMDIyIGF0IDE6MzQgUE0gRGF2aWQgTGFpZ2h0IDxE
YXZpZC5MYWlnaHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiAuLi4NCj4gPiA+ICsgICAg
IGN5Y2xlc190IGVuZCwgc3RhcnQgPSBnZXRfY3ljbGVzKCk7DQo+ID4gPiAgICAgICBibGFrZTJz
X3VwZGF0ZSgmaW5wdXRfcG9vbC5oYXNoLCBpbiwgbmJ5dGVzKTsNCj4gPiA+ICsgICAgIGVuZCA9
IGdldF9jeWNsZXMoKTsNCj4gPg0KPiA+IElmIGdldF9jeWNsZXMoKSBpcyByZHRzYyB0aGVuIHRo
YXQgZ2l2ZXMgbWVhbmluZ2xlc3MgbnVtYmVycy4NCj4gPiBUaGUgY3B1IGNsb2NrIGZyZXF1ZW5j
eSB3aWxsIGNoYW5nZSBvbiB5b3UuDQo+ID4NCj4gPiBZb3UgY2FuIHVzZSBvbmUgb2YgdGhlIHBl
cmZvcm1hbmNlIGNvdW50ZXJzIHRvIGdldCBhbiBhY3R1YWwNCj4gDQo+IEluZGVlZC4gSW4gdGhl
IHByb2Nlc3Mgb2Ygd2lyaW5nIHVwIHJkcG1jIG5vdy4NCg0KSSd2ZSB1c2VkIHRoaXMgYmVmb3Jl
IG5vdy4NCkJ1dCB0aGUgbG9vcCBnZXR0aW5nIHRoZSBwbWMgdmFsdWUgaW4gbm9uLWRldGVybWlu
aXN0aWMuDQpTbyBJIHNvbWV0aW1lcyByZW1vdmUgaXQuDQpBbHNvIHlvdSBuZWVkIHRvIGFkZCBh
IHNlcmlhbGlzaW5nIGluc3RydWN0aW9uIC0gb3RoZXJ3aXNlDQp0aGUgcG1jIGdldCByZWFkIGJl
Zm9yZSB0aGUgY29kZSB5b3UgYXJlIG1lYXN1cmluZw0KYWN0dWFsbHkgZmluaXNoZXMuDQoNCkkn
dmUgdXNlZCBzaW1pbGFyIGNvZGUgdG8gbWVhc3VyZSBpdGVyYXRpb25zIG9uIHRoZSBpcCBjaGVj
a3N1bSBjb2RlLg0KQ2FuIHNob3cgaG93IG1hbnkgYnl0ZXMvY2xvY2sgdGhhdCBhY2hpZXZlcyBp
biBpdHMgaW5uZXIgbG9vcC4NCldoaWNoIGNhbiBtYXRjaCB3aGF0IHlvdSBtaWdodCBleHBlY3Qg
dGhlIGluc3RydWN0aW9ucyB0byBnZW5lcmF0ZS4NCg0KCURhdmlkDQoNCnN0YXRpYyBpbmxpbmUg
dW5zaWduZWQgaW50IHJkcG1jKHVuc2lnbmVkIGludCBjb3VudGVyKQ0Kew0KICAgICAgICB1bnNp
Z25lZCBpbnQgbG93LCBoaWdoOw0KDQogICAgICAgIGFzbSB2b2xhdGlsZSgicmRwbWMiIDogIj1h
IiAobG93KSwgIj1kIiAoaGlnaCkgOiAiYyIgKGNvdW50ZXIpKTsNCg0KICAgICAgICAvLyByZXR1
cm4gbG93IGJpdHMsIGNvdW50ZXIgbWlnaHQgdG8gMzIgb3IgNDAgYml0cyB3aWRlLg0KICAgICAg
ICByZXR1cm4gbG93Ow0KfQ0KDQpzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCByZHRzYyh2b2lk
KQ0Kew0KICAgICAgICB1bnNpZ25lZCBpbnQgbG93LCBoaWdoOw0KDQogICAgICAgIGFzbSB2b2xh
dGlsZSgicmR0c2MiIDogIj1hIiAobG93KSwgIj1kIiAoaGlnaCkpOw0KDQogICAgICAgIHJldHVy
biBsb3c7DQp9DQoNCnVuc2lnbmVkIGludCByZWFkX2NwdV9jeWNsZXModm9pZCkNCnsNCiAgICAg
ICAgc3RhdGljIHN0cnVjdCBwZXJmX2V2ZW50X2F0dHIgcGVyZl9hdHRyID0gew0KICAgICAgICAg
ICAgICAgIC50eXBlID0gUEVSRl9UWVBFX0hBUkRXQVJFLA0KICAgICAgICAgICAgICAgIC5jb25m
aWcgPSBQRVJGX0NPVU5UX0hXX0NQVV9DWUNMRVMsDQogICAgICAgICAgICAgICAgLnBpbm5lZCA9
IDEsDQogICAgICAgIH07DQogICAgICAgIHN0YXRpYyBfX3RocmVhZCBzdHJ1Y3QgcGVyZl9ldmVu
dF9tbWFwX3BhZ2UgKnBjOw0KICAgICAgICBzdGF0aWMgaW50IHBtY19mYWlsZWQ7DQoNCiAgICAg
ICAgdW5zaWduZWQgaW50IHNlcSwgaWR4LCBjb3VudDsNCg0KICAgICAgICBpZiAocG1jX2ZhaWxl
ZCkNCiAgICAgICAgICAgICAgICByZXR1cm4gcmR0c2MoKTsNCg0KICAgICAgICBpZiAoIXBjKSB7
DQogICAgICAgICAgICAgICAgaW50IHBlcmZfZmQ7DQogICAgICAgICAgICAgICAgcGVyZl9mZCA9
IHN5c2NhbGwoX19OUl9wZXJmX2V2ZW50X29wZW4sICZwZXJmX2F0dHIsIDAsIC0xLCAtMSwgMCk7
DQogICAgICAgICAgICAgICAgaWYgKHBlcmZfZmQgPCAwKSB7DQogICAgICAgICAgICAgICAgICAg
ICAgICBwbWNfZmFpbGVkID0gMTsNCiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZHRz
YygpOw0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICBwYyA9IG1tYXAoTlVMTCwg
c3lzY29uZihfU0NfUEFHRVNJWkUpLCBQUk9UX1JFQUQsIE1BUF9TSEFSRUQsIHBlcmZfZmQsIDAp
Ow0KICAgICAgICAgICAgICAgIGNsb3NlKHBlcmZfZmQpOw0KICAgICAgICAgICAgICAgIGlmIChw
YyA9PSBNQVBfRkFJTEVEKSB7DQogICAgICAgICAgICAgICAgICAgICAgICBwbWNfZmFpbGVkID0g
MTsNCiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZHRzYygpOw0KICAgICAgICAgICAg
ICAgIH0NCiAgICAgICAgfQ0KDQogICAgICAgIGRvIHsNCiAgICAgICAgICAgICAgICBzZXEgPSBw
Yy0+bG9jazsNCiAgICAgICAgICAgICAgICBhc20gdm9sYXRpbGUoIiI6OjoibWVtb3J5Iik7DQog
ICAgICAgICAgICAgICAgaWR4ID0gcGMtPmluZGV4Ow0KICAgICAgICAgICAgICAgIGlmICghaWR4
KSAvLyAgfHwgIXBjLT5jYXBfdXNlcl9yZHBtYykNCiAgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiAwOw0KICAgICAgICAgICAgICAgIGNvdW50ID0gcGMtPm9mZnNldCArIHJkcG1jKGlkeCAt
IDEpOw0KICAgICAgICAgICAgICAgIGFzbSB2b2xhdGlsZSgiIjo6OiJtZW1vcnkiKTsNCiAgICAg
ICAgfSB3aGlsZSAocGMtPmxvY2sgIT0gc2VxKTsNCg0KICAgICAgICByZXR1cm4gY291bnQ7DQp9
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

