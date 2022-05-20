Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25A552F57C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 00:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353790AbiETWIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 18:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243602AbiETWIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:08:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24A8C195908
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:08:04 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-266-ctS2yhHYNMyNXc6Epjlljw-1; Fri, 20 May 2022 23:08:00 +0100
X-MC-Unique: ctS2yhHYNMyNXc6Epjlljw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Fri, 20 May 2022 23:08:00 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Fri, 20 May 2022 23:08:00 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: RE: [PATCH] fs: prefer read_iter over read and write_iter over write
Thread-Topic: [PATCH] fs: prefer read_iter over read and write_iter over write
Thread-Index: AQHYbFCwvu9LSlrdFk+NviNR2+4IRK0nyjDggABuI4CAABnZcA==
Date:   Fri, 20 May 2022 22:08:00 +0000
Message-ID: <0da16e16caed4282ae97a86f1ba6f6db@AcuMS.aculab.com>
References: <20220520135103.166972-1-Jason@zx2c4.com>
 <39ed6917f2e64a07bad8dad63f8dceb4@AcuMS.aculab.com>
 <YogIg9FG7C/f98bf@zx2c4.com>
In-Reply-To: <YogIg9FG7C/f98bf@zx2c4.com>
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

RnJvbTogSmFzb24gQS4gRG9uZW5mZWxkDQo+IFNlbnQ6IDIwIE1heSAyMDIyIDIyOjMxDQo+IA0K
PiBIaSBEYXZpZCwNCj4gDQo+IE9uIEZyaSwgTWF5IDIwLCAyMDIyIGF0IDA5OjI0OjUwUE0gKzAw
MDAsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBGcm9tOiBKYXNvbiBBLiBEb25lbmZlbGQNCj4g
PiA+IFNlbnQ6IDIwIE1heSAyMDIyIDE0OjUxDQo+ID4gPg0KPiA+ID4gTW9zdCBrZXJuZWwgY29k
ZSBwcmVmZXJzIHJlYWRfaXRlciBvdmVyIHJlYWQgYW5kIHdyaXRlX2l0ZXIgb3ZlciB3cml0ZSwN
Cj4gPiA+IHlldCB0aGUgcmVhZCBmdW5jdGlvbiBwb2ludGVyIGlzIHRlc3RlZCBmaXJzdC4gUmV2
ZXJzZSB0aGVzZSBzbyB0aGF0IHRoZQ0KPiA+ID4gaXRlciBmdW5jdGlvbiBpcyBhbHdheXMgdXNl
ZCBmaXJzdC4NCj4gPg0KPiA+IFRoZXJlIHdpbGwgYmUgYSBtZWFzdXJhYmxlIHBlcmZvcm1hbmNl
IGhpdCBmb3IgdGhlIHh4eF9pdGVyIHZlcnNpb25zLg0KPiANCj4gSW5kZWVkLiBXZSBub3cgaGF2
ZSB0aGUgbWlzZm9ydHVuZSBvZiBhIDMlIGhpdCBvbiByYW5kb20uYywgcGVyIHRoaXMNCj4gc3Vi
LXRocmVhZDoNCg0KSSB3cm90ZSB0aGF0IGEgZmV3IGhvdXJzIGFnbyBhbmQgZm9yZ290IHRvIHNl
bmQgaXQgOi0oDQoNCj4gICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9Zb2V5K0ZPWU82
OWxTNXFQQHp4MmM0LmNvbS8NCj4gDQo+IFRoZSBob3BlIGlzIHRoYXQgaXQgZXZlbnR1YWxseSBi
ZWNvbWVzIGZhc3Rlci4uLiA6LVwNCg0KSSBzdXNwZWN0IGFsbCB0aGUgeHh4X2l0ZXIgZnVuY3Rp
b25zIG5lZWQgb3B0aW1pc2luZyBmb3INCnRoZSBjb21tb24gY2FzZSBvZiBhIHNpbmdsZSBidWZm
ZXIgaW4gdXNlcnNwYWNlLg0KDQpUaGF0IGFsc28gaW5jbHVkZXMgdGhlIGNvZGUgdG8gcmVhZCB0
aGUgaW92W10gZnJvbSB1c2VzcGFjZS4NCkF0IHRoZSBtb21lbnQgSSB0aGluayB0aGUgMzJiaXQg
Y29tcGF0IGNvZGUgaXMgYWN0dWFsbHkNCmZhc3RlciB0aGFuIHRoZSBuYXRpdmUgYW1kNjQgdmVy
c2lvbiENCkkndmUgd3JpdHRlbiBzb21lIHBhdGNoZXMgdG8gc3BlZWQgdGhhdCB1cC4NCkJ1dCB0
aGUgYmlnZ2VyIGltcHJvdmVtZW50cyBhbGwgaGl0IG1hc3NpdmUgY2hhbmdlcw0KdG8gdGhlIGlv
cmluZyBjb2RlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

