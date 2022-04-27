Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F6D5124E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbiD0WCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236499AbiD0WCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:02:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 048D9114E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:59:21 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-59-t9skdaEmPgSzXS7t39lYbQ-1; Wed, 27 Apr 2022 22:59:18 +0100
X-MC-Unique: t9skdaEmPgSzXS7t39lYbQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Wed, 27 Apr 2022 22:59:17 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Wed, 27 Apr 2022 22:59:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Philipp Hortmann' <philipp.g.hortmann@gmail.com>
CC:     Forest Bond <forest@alittletooquiet.net>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v3 3/3] staging: vt6655: Replace VNSvInPortD with ioread32
Thread-Topic: [PATCH v3 3/3] staging: vt6655: Replace VNSvInPortD with
 ioread32
Thread-Index: AQHYWftqR1H/yljgC0KSKJflip6fA60DZMOggACrU4CAADmJ0A==
Date:   Wed, 27 Apr 2022 21:59:17 +0000
Message-ID: <0b6873bcd7c54d71b1f0b84a61561261@AcuMS.aculab.com>
References: <cover.1651036713.git.philipp.g.hortmann@gmail.com>
 <7a5f7f98379fb2af2741f613f5ddda53e5d4813e.1651036713.git.philipp.g.hortmann@gmail.com>
 <Ymjaxby2vDJYz6KA@kroah.com>
 <b8853bc9a9d041009103b76bd02ce08d@AcuMS.aculab.com>
 <748780b1-12ba-34d0-1ce3-36b74b1b90b7@gmail.com>
In-Reply-To: <748780b1-12ba-34d0-1ce3-36b74b1b90b7@gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGhpbGlwcCBIb3J0bWFubg0KPiBTZW50OiAyNyBBcHJpbCAyMDIyIDIwOjEwDQo+IA0K
PiBPbiA0LzI3LzIyIDEwOjAxLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gQWN0dWFsbHkgSSBz
dXNwZWN0IHRoYXQgJ2lvYmFzZScgc2hvdWxkIGJlIGFuIF9faW9tZW0gc3RydWN0dXJlDQo+ID4g
cG9pbnRlciwgcHF3Q3VyclRTRiBhIHBvaW50IG9mIHRoZSBzYW1lIHR5cGUgYW5kIE1BQ19SRUdf
eHh4eA0KPiA+IHN0cnVjdHVyZSBtZW1iZXJzLg0KPiA+DQo+ID4gVGhlbiB0aGUgY29kZSBzaG91
bGQgYmUgdXNpbmcgcmVhZGwoKSBub3QgaW9yZWFkMzIoKS4NCj4gPiBJIHZlcnkgbXVjaCBkb3Vi
dCB0aGF0ICdpb2Jhc2UnIGlzIGluIFBDSSBJTyBzcGFjZS4NCj4gDQo+IEhpIERhdmlkLA0KPiAN
Cj4gaGVyZSBzb21lIGluZm9zIGFuZCBxdWVzdGlvbnM6DQo+IA0KPiAkIHN1ZG8gbHNwY2kgLXMg
MDE6MDUuMCAtdnZ2DQo+IDAxOjA1LjAgTmV0d29yayBjb250cm9sbGVyOiBWSUEgVGVjaG5vbG9n
aWVzLCBJbmMuIFZUNjY1NSBXaUZpIEFkYXB0ZXIsIDgwMi4xMWEvYi9nDQo+IAlTdWJzeXN0ZW06
IFZJQSBUZWNobm9sb2dpZXMsIEluYy4gVlQ2NjU1IFdpRmkgQWRhcHRlciwgODAyLjExYS9iL2cN
Ci4uLg0KPiAJUmVnaW9uIDA6IE1lbW9yeSBhdCBmN2MwMDAwMCAoMzItYml0LCBub24tcHJlZmV0
Y2hhYmxlKSBbc2l6ZT0yNTZdDQo+IAlSZWdpb24gMTogSS9PIHBvcnRzIGF0IGUwMDAgW3NpemU9
MjU2XQ0KLi4uDQo+IC0tLS0gSW4gZmlsZSBkZXZpY2VfbWFpbi5jIGxpbmUgMTY5OQ0KPiAJcHJp
di0+bWVtYWRkciA9IHBjaV9yZXNvdXJjZV9zdGFydChwY2lkLCAwKTsNCj4gCXByaXYtPmlvYWRk
ciA9IHBjaV9yZXNvdXJjZV9zdGFydChwY2lkLCAxKTsNCj4gCXByaXYtPnBvcnRfb2Zmc2V0ID0g
aW9yZW1hcChwcml2LT5tZW1hZGRyICYgUENJX0JBU0VfQUREUkVTU19NRU1fTUFTSywgMjU2KTsN
Cg0KV1RGIGlzIHRoYXQgbWFzaz8NClRoZSBkcml2ZXIgY29kZSBJJ3ZlIGdvdCBqdXN0IHVzZXMg
cGNpX2lvbWFwKHBjaV9kZXYsIGJhcl9udW1iZXIsIGxlbmd0aCk7DQpJdCB0aGVuIHVzZXMgcGNp
X2lvdW5tYXAocGNpX2RldiwgdmFkZHIpIHRvIGZyZWUgaXQuDQoNCj4gCWRldl9pbmZvKCZwY2lk
LT5kZXYsICJ2dDY2NTVfcHJvYmUgcHJpdi0+bWVtYWRkcjogJXggcHJpdi0+aW9hZGRyOiAleCIs
DQo+IHByaXYtPm1lbWFkZHIsIHByaXYtPmlvYWRkcik7DQo+IA0KPiAtLS0tLSBPdXRwdXQ6DQo+
IFsgICswLjAwMDAxOF0gdnQ2NjU1IDAwMDA6MDE6MDUuMDogdnQ2NjU1X3Byb2JlIHByaXYtPm1l
bWFkZHI6IGY3YzAwMDAwDQo+IHByaXYtPmlvYWRkcjogZTAwMA0KPiANCj4gDQo+IFNvIHBvcnRf
b2Zmc2V0IGlzIGRlcml2ZWQgZnJvbSBtZW1hZGRyLg0KPiANCj4gDQo+IC0tLS0tIEluIGZpbGUg
Y2FyZC5jIGxpbmUgNzQyDQo+IGJvb2wgQ0FSRGJHZXRDdXJyZW50VFNGKHN0cnVjdCB2bnRfcHJp
dmF0ZSAqcHJpdiwgdTY0ICpwcXdDdXJyVFNGKQ0KPiB7DQo+IAl2b2lkIF9faW9tZW0gKmlvYmFz
ZSA9IHByaXYtPnBvcnRfb2Zmc2V0Ow0KPiAuLi4NCj4gCVZOU3ZJblBvcnREKGlvYmFzZSArIE1B
Q19SRUdfVFNGQ05UUiwgKHUzMiAqKXBxd0N1cnJUU0YpOw0KPiANCj4gUGxlYXNlIHRlbGwgbWUg
aWYgeW91IG5lZWQgZnVydGhlciBpbmZvcyB0byBzZWUgaWYgaXQgaXMgUENJIElPIHNwYWNlLg0K
PiBJIHRoaW5rIGl0IGlzIG1lbW9yeS1tYXBwZWQuDQoNCkJBUiAwIGlzIG1lbW9yeSwgQkFSIDEg
SS9PLCBib3RoIGFsbW9zdCBjZXJ0YWlubHkgcmVmZXIgdG8gdGhlDQpzYW1lIHBoeXNpY2FsIGRl
dmljZSByZWdpc3RlcnMuDQpCYXNpY2FsbHkgUENJKGUpIEkvTyBzcGFjZSBpcyAobW9zdGx5KSBk
ZXByZWNhdGVkLg0KSXQgKHNvcnQgb2YpIGV4aXN0cyBzbyB0aGF0IFBDSSBoYXJkd2FyZSBjb3Vs
ZCByZXBsYWNlIHZlcnkgb2xkDQooZWcgSVNBKSBoYXJkd2FyZSB3aXRob3V0IHJlcXVpcmluZyBk
cml2ZXIgY2hhbmdlcy4NCg0KPiBTbyBpcyBpb3JlYWQzMiB3cm9uZywgcmlnaHQgb3IgY2FuIGl0
IGJlIHVzZWQ/DQoNCihBc3N1bWluZyB4ODYpDQppb3JlYWQzMigpIGhhcyB0byBjb250YWluIGEg
dGVzdCB0byBzZWUgd2hldGhlciB0aGUgYWRkcmVzcw0KaXMgYW4gJ2lvIGFkZHJlc3MnIG9yIGEg
J21lbW9yeSBhZGRyZXNzJy4NCkZvciB0aGUgZm9ybWVyIGFuICdpbncnIGluc3RydWN0aW9uIGlz
IGV4ZWN1dGVkIGZvciB0aGUgbGF0dGVyDQphIG5vcm1hbCBtZW1vcnkgYWNjZXNzIGluc3RydWN0
aW9uLg0KT1RPSCByZWFkbCgpIGlzIGp1c3QgYSBtZW1vcnkgYWNjZXNzICh3aXRoIGNvbXBpbGVy
IGJhcnJpZXJzKQ0KYW5kIGlzIGlubGluZWQgaW50byB0aGUgZHJpdmVyIG9iamVjdC4NCg0KU28g
aWYgeW91IHVzZWQgcHJpdi0+aW9hZGRyIHlvdSdkIGhhdmUgdG8gdXNlIGlvcmVhZDMyKCkuDQpT
aW5jZSB5b3UgYXJlIHVzaW5nIHRoZSBtZW1vcnkgc3BhY2UgYWRkcmVzc2VzIGZyb20gQkFSIDAN
CnlvdSBjYW4gdXNlIGlvcmVhZDMyKCkgYnV0IGl0IGlzIG1vcmUgZWZmaWNpZW50IHRvIHVzZSBy
ZWFkbCgpLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFt
bGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3Ry
YXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

