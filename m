Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47753573414
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbiGMKYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbiGMKYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:24:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0993DBD6AA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:24:19 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-219-CLD2JCRYMxC7Om6KS1TDPw-1; Wed, 13 Jul 2022 11:24:17 +0100
X-MC-Unique: CLD2JCRYMxC7Om6KS1TDPw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Wed, 13 Jul 2022 11:24:15 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Wed, 13 Jul 2022 11:24:15 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrey Semashev' <andrey.semashev@gmail.com>,
        'Yu-Jen Chang' <arthurchang09@gmail.com>
CC:     "andy@kernel.org" <andy@kernel.org>,
        "akinobu.mita@gmail.com" <akinobu.mita@gmail.com>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] lib/string.c: Optimize memchr()
Thread-Topic: [PATCH 2/2] lib/string.c: Optimize memchr()
Thread-Index: AQHYlf/m+SYzYfFyd0Sny8eSVHr68K18CeuggAAJgkmAAAQUQA==
Date:   Wed, 13 Jul 2022 10:24:15 +0000
Message-ID: <658586b208ea4339b3ead19378484434@AcuMS.aculab.com>
References: <20220710142822.52539-1-arthurchang09@gmail.com>
 <20220710142822.52539-3-arthurchang09@gmail.com>
 <3a1b50d2-a7aa-3e89-56fe-5d14ef9da22f@gmail.com>
 <CAD4RrFPihC+8LScC1RJ5GfOsLs4kze0QwALS1ykNH_m89Z1NGg@mail.gmail.com>
 <48db247e-f6fd-cb4b-7cc5-455bf26bb153@gmail.com>
 <CAD4RrFPfwu4Ascj5tdz8qq2Qgnu5GN2eHjVwMW5AqUa1H7JapA@mail.gmail.com>
 <49a8be9269ee47de9fc2d0d7f09eb0b1@AcuMS.aculab.com>
 <5d14cf64-46b7-dc37-bbb8-dd6be82d06af@gmail.com>
 <999057a9-d209-323b-90eb-5756b7c0e91e@gmail.com>
In-Reply-To: <999057a9-d209-323b-90eb-5756b7c0e91e@gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5kcmV5IFNlbWFzaGV2DQo+IFNlbnQ6IDEzIEp1bHkgMjAyMiAxMTowMw0KPiANCj4g
T24gNy8xMy8yMiAxMjo0OSwgQW5kcmV5IFNlbWFzaGV2IHdyb3RlOg0KPiA+IE9uIDcvMTMvMjIg
MTI6MzksIERhdmlkIExhaWdodCB3cm90ZToNCj4gPj4gRnJvbTogWXUtSmVuIENoYW5nDQo+ID4+
PiBTZW50OiAxMiBKdWx5IDIwMjIgMTU6NTkNCj4gPj4gLi4uDQo+ID4+Pj4gSSB0aGluayB5b3Un
cmUgbWlzc2luZyB0aGUgcG9pbnQuIExvYWRzIGF0IHVuYWxpZ25lZCBhZGRyZXNzZXMgbWF5IG5v
dA0KPiA+Pj4+IGJlIGFsbG93ZWQgYnkgaGFyZHdhcmUgdXNpbmcgY29udmVudGlvbmFsIGxvYWQg
aW5zdHJ1Y3Rpb25zIG9yIG1heSBiZQ0KPiA+Pj4+IGluZWZmaWNpZW50LiBHaXZlbiB0aGF0IHRo
aXMgbWVtY2hyIGltcGxlbWVudGF0aW9uIGlzIHVzZWQgYXMgYSBmYWxsYmFjaw0KPiA+Pj4+IHdo
ZW4gbm8gaGFyZHdhcmUtc3BlY2lmaWMgdmVyc2lvbiBpcyBhdmFpbGFibGUsIHlvdSBzaG91bGQg
YmUNCj4gPj4+PiBjb25zZXJ2YXRpdmUgd3J0LiBoYXJkd2FyZSBjYXBhYmlsaXRpZXMgYW5kIGJl
aGF2aW9yLiBZb3Ugc2hvdWxkDQo+ID4+Pj4gcHJvYmFibHkgaGF2ZSBhIHByZS1hbGlnbm1lbnQg
bG9vcC4NCj4gPj4+DQo+ID4+PiBHb3QgaXQuIEkgYWRkICBwcmUtYWxpZ25tZW50IGxvb3AuIEl0
IGFsaWducyB0aGUgYWRkcmVzcyB0byA4IG9yIDRieXRlcy4NCj4gPj4NCj4gPj4gVGhhdCBzaG91
bGQgYmUgcHJlZGljYXRlZCBvbiAhSEFTX0VGRklDSUVOVF9VTkFMSUdORURfQUNDRVNTLg0KPiA+
Pg0KPiA+PiAuLi4NCj4gPj4+ICAgICAgICAgZm9yICg7IHAgPD0gZW5kIC0gODsgcCArPSA4KSB7
DQo+ID4+PiAgICAgICAgICAgICB2YWwgPSAqKHU2NCopcCBeIG1hc2s7DQo+ID4+PiAgICAgICAg
ICAgICBpZiAoKHZhbCArIDB4ZmVmZWZlZmVmZWZlZmVmZnVsbCkNCj4gPj4+ICYgKH52YWwgJiAw
eDgwODA4MDgwODA4MDgwODB1bGwpKQ0KPiA+Pj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+
Pg0KPiA+PiBJIHdvdWxkIGFkZCBhIGNvdXBsZSBvZiBjb21tZW50cywgbGlrZToNCj4gPj4gCS8v
IENvbnZlcnQgdG8gY2hlY2sgZm9yIHplcm8gYnl0ZS4NCj4gPj4gCS8vIFN0YW5kYXJkIGNoZWNr
IGZvciBhIHplcm8gYnl0ZSBpbiBhIHdvcmQuDQo+ID4+IChCdXQgbm90IHRoZSBiaWcgNCBsaW5l
IGV4cGxhbmF0aW9uIHlvdSBoYWQuDQo+ID4+DQo+ID4+IEl0IGlzIGFsc28gd29ydGggbG9va2lu
ZyBhdCBob3cgdGhhdCBjb2RlIGNvbXBpbGVzDQo+ID4+IG9uIDMyYml0IGFyY2ggdGhhdCBkb24n
dCBoYXZlIGEgY2FycnkgZmxhZy4NCj4gPj4gVGhhdCBpcyBldmVyeXRoaW5nIGJhc2VkIG9uIE1J
UFMsIGluY2x1ZGluZyByaXNjdi4NCj4gPg0KPiA+IEl0IG1heSBiZSB3b3J0aCBsb29raW5nIGF0
IGhvdyBnbGliYyBkb2VzIGl0Og0KPiA+DQo+ID4NCj4gaHR0cHM6Ly9zb3VyY2V3YXJlLm9yZy9n
aXQvP3A9Z2xpYmMuZ2l0O2E9YmxvYjtmPXN0cmluZy9tZW1jaHIuYztoPTQyMmJjZDBjZDY0NmVh
NDY3MTFhNTdmYTNjYmRiOGEzMzI5DQo+IGZjMzAyO2hiPXJlZnMvaGVhZHMvcmVsZWFzZS8yLjM1
L21hc3RlciNsNDYNCj4gPg0KPiA+IFRoZXkgZG8gdXNlIDMyLWJpdCB3b3JkcyBvbiAzMi1iaXQg
dGFyZ2V0cyBhbmQgNjQtYml0IG9uIDY0LWJpdCBvbmVzLiBJDQo+ID4gdGhpbmsgbWVtY2hyIGlu
IHRoZSBrZXJuZWwgc2hvdWxkIGZvbGxvdyB0aGlzLg0KPiANCj4gQWxzbywgaWYgYnkgY2hhbmNl
IHRoaXMgb3B0aW1pemF0aW9uIGlzIGFpbWVkIGZvciB4ODYtNjQsIGl0IG1heSBiZQ0KPiB3b3J0
aCBhZGRpbmcgYW4gYXJjaC1zcGVjaWZpYyB2ZXJzaW9uIHRoYXQgdXNlcyBFUk1TLg0KDQpEb24n
dCBiZWxpZXZlIGV2ZXJ5dGhpbmcgeW91IHNlZSBpbiBnbGliYy4NClRoZSBjb21tb24gY2FzZXMg
aW4gdGhlIGtlcm5lbCBhcmUgZGlmZmVyZW50IGZyb20gdGhlIG9uZXMgdGhleQ0KdGVuZCB0byBv
cHRpbWlzZSBmb3IuLg0KDQpZb3UgbWlnaHQgdHJ5IHVzaW5nOg0KCSNkZWZpbmUgR0VOX01BU0so
eCkgKHggKiAodW5zaWduZWQgbG9uZykweDAxMDEwMTAxMDEwMTAxMDF1bGwpDQpmb3IgdGhlIG1h
c2sgYW5kIHRoZSB0d28gY29uc3RhbnRzLg0KVGhlbiBtYWtlIGFsbCB0aGUgdmFyaWFibGVzICds
b25nJy4NCg0KSSdtIG5vdCBhdCBhbGwgc3VyZSB3aGF0IHRoZSB0ZXN0IGZvciBmYXN0IG11bHRp
cGx5IGlzIGFib3V0Lg0KSXQgbWF5IGJlIHZlcnkgaGlzdG9yaWMsIGZvciBtb2Rlcm4gY3B1IGdl
bmVyYXRpbmcgdGhlIDY0Yml0DQpjb25zdGFudCBpcyBsaWtlbHkgdG8gYmUgbW9yZSBwcm9ibGVt
YXRpYyAoY2hlY2sgYXJtNjQpLg0KSWYgdGhlIGlucHV0IHZhbHVlIGlzICd1bnNpZ25lZCBjaGFy
JyAob3IgbWFza2VkKSB0aGVuIHRoZQ0KY29tcGlsZXIgbWF5IGRlY2lkZSB0byBkbyB0aGUgcmVw
ZWF0ZWQgPDw9IGl0c2VsZi4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

