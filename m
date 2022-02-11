Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625944B2582
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344514AbiBKMVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:21:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiBKMVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:21:21 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2E78EB0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:21:19 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-162-DXbbg0pDOby4ZKc9hJGobA-1; Fri, 11 Feb 2022 12:21:16 +0000
X-MC-Unique: DXbbg0pDOby4ZKc9hJGobA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 11 Feb 2022 12:21:15 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 11 Feb 2022 12:21:15 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dmitry Baryshkov' <dmitry.baryshkov@linaro.org>,
        Qing Wang <wangqing@vivo.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] media: qcom: use div64_u64() instead of do_div()
Thread-Topic: [PATCH] media: qcom: use div64_u64() instead of do_div()
Thread-Index: AQHYHmdc2KqcihxW0EasBc5qyOVNSayORPUg
Date:   Fri, 11 Feb 2022 12:21:14 +0000
Message-ID: <11c926109b394ae9bfc3230b68cdaf14@AcuMS.aculab.com>
References: <1644395913-4091-1-git-send-email-wangqing@vivo.com>
 <19b96972-cee7-937f-21ce-c78982ed2048@linaro.org>
In-Reply-To: <19b96972-cee7-937f-21ce-c78982ed2048@linaro.org>
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

RnJvbTogRG1pdHJ5IEJhcnlzaGtvdg0KPiBTZW50OiAxMCBGZWJydWFyeSAyMDIyIDEwOjE3DQo+
IA0KPiBPbiAwOS8wMi8yMDIyIDExOjM4LCBRaW5nIFdhbmcgd3JvdGU6DQo+ID4gRnJvbTogV2Fu
ZyBRaW5nIDx3YW5ncWluZ0B2aXZvLmNvbT4NCj4gPg0KPiA+IGRvX2RpdigpIGRvZXMgYSA2NC1i
eS0zMiBkaXZpc2lvbi4NCj4gPiBXaGVuIHRoZSBkaXZpc29yIGlzIHU2NCwgZG9fZGl2KCkgdHJ1
bmNhdGVzIGl0IHRvIDMyIGJpdHMsIHRoaXMgbWVhbnMgaXQNCj4gPiBjYW4gdGVzdCBub24temVy
byBhbmQgYmUgdHJ1bmNhdGVkIHRvIHplcm8gZm9yIGRpdmlzaW9uLg0KPiA+DQo+ID4gZml4IGRv
X2Rpdi5jb2NjaSB3YXJuaW5nOg0KPiA+IGRvX2RpdigpIGRvZXMgYSA2NC1ieS0zMiBkaXZpc2lv
biwgcGxlYXNlIGNvbnNpZGVyIHVzaW5nIGRpdjY0X3U2NCBpbnN0ZWFkLg0KPiANCj4gDQo+IE5B
Sw0KPiANCj4gVGhlIGRpdjY0X3U2NCBpcyBub3QgZXF1aXZhbGVudCB0byBkb19kaXYuIEl0IHJl
dHVybnMgdGhlIHF1b3RpZW50DQo+IHJhdGhlciB0aGFuIG1vZGlmeWluZyB0aGUgZmlyc3QgYXJn
LiBNb3Jlb3ZlciBpdCBpcyB1bm9wdGltYWwgb24gMzItYml0DQo+IGFyY2hlcy4NCj4gDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBXYW5nIFFpbmcgPHdhbmdxaW5nQHZpdm8uY29tPg0KPiA+IC0t
LQ0KPiA+ICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9xY29tL3ZlbnVzL3ZkZWMuYyB8IDIgKy0N
Cj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vcWNvbS92ZW51cy92ZGVj
LmMgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL3Fjb20vdmVudXMvdmRlYy5jDQo+ID4gaW5kZXgg
OTFkYTNmNS4uOTQxYTkwNA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vcWNvbS92
ZW51cy92ZGVjLmMNCj4gPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL3Fjb20vdmVudXMv
dmRlYy5jDQo+ID4gQEAgLTQzNSw3ICs0MzUsNyBAQCBzdGF0aWMgaW50IHZkZWNfc19wYXJtKHN0
cnVjdCBmaWxlICpmaWxlLCB2b2lkICpmaCwgc3RydWN0IHY0bDJfc3RyZWFtcGFybSAqYSkNCj4g
PiAgIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4NCj4gPiAgIAlmcHMgPSAodTY0KVVTRUNfUEVSX1NF
QzsNCj4gPiAtCWRvX2RpdihmcHMsIHVzX3Blcl9mcmFtZSk7DQo+ID4gKwlkaXY2NF91NjQoZnBz
LCB1c19wZXJfZnJhbWUpOw0KDQpUaGF0IG9uZSBpcyBwYXJ0aWN1bGFybHkgaW5zYW5lIHRvIGJl
Z2luIHdpdGguDQpXaHkgd2FzIGl0IGV2ZW4gZG9fZGl2KCk/DQpJIGd1ZXNzIGJlY2F1c2U6DQoJ
ZnBzID0gVVNFQ19QRVJfU0VDIC8gdXNfcGVyX2ZyYW1lOw0KY2F1c2VkIHRoZSBjb21waWxlciB0
byBjYWxsIHRoZSA2NGJpdCBkaXZpZGUgZnVuY3Rpb24gYmVjYXVzZSB0aGUgJ3VzX3Blcl9mcmFt
ZScNCmlzIDY0Yml0IC0gZXZlbiB0aG91Z2ggdGhlIGNvZGUgb25seSBtYWtlcyBzZW5zZSBpZiBp
dCBpcyBzbWFsbC4NCg0KVGhlIGNvcnJlY3QgZml4IGhlcmUgaXMgcHJvYmFibHkgdG8gY2hhbmdl
IHRoZSB0eXBlIG9mIHVzX3Blcl9mcmFtZSB0byAzMmJpdA0Kb3IganVzdCBkbzoNCglmcHMgPSBV
U0VDX1BFUl9GUkFNIC8gKHVuc2lnbmVkIGludCl1c19wZXJfZnJhbWUuDQoNCk9oLCBhbmQgZnBz
IGRlZmluaXRlbHkgZG9lc24ndCBuZWVkIHRvIGJlIDY0Yml0IGVpdGhlci4NCg0KSU1ITyBhbGwg
KGFuZCBJIG1lYW4gQUxMKSBvZiB0aGVzZSBwYXRjaGVzIHRvIGNoYW5nZSBkb19kaXYoKSB0byBk
aXY2NF91NjQoKQ0KbmVlZCBkcm9wcGluZy4NCk1heWJlIG9uZSBvciB0d28gYXJlIHJlYWwgcHJv
YmxlbXMsIGJ1dCB0aGUgc3Vycm91bmRpbmcgY29kZSBuZWVkcw0KY29ycmVjdGx5IGV4YW1pbmlu
Zy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBS
b2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9u
IE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

