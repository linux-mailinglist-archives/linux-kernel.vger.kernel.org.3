Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2377B4B4E62
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351591AbiBNLcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:32:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351570AbiBNLaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:30:12 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26A0166AED
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:11:38 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-33-IItVuRDPNvWlDoJ-8YoAUQ-1; Mon, 14 Feb 2022 11:11:35 +0000
X-MC-Unique: IItVuRDPNvWlDoJ-8YoAUQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 14 Feb 2022 11:11:14 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 14 Feb 2022 11:11:13 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Helge Deller' <deller@gmx.de>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>
Subject: RE: [PATCH] fat: Use pointer to d_name[0] in put_user() for compat
 case
Thread-Topic: [PATCH] fat: Use pointer to d_name[0] in put_user() for compat
 case
Thread-Index: AQHYISaVap2r7qAO+E+IsFLjJVJIxKySvtowgAAIGvCAABwpAIAAAYyg
Date:   Mon, 14 Feb 2022 11:11:13 +0000
Message-ID: <01801d084adf442aa5b8dc4bf1eee771@AcuMS.aculab.com>
References: <YgmB01p+p45Cihhg@p100>
 <49a26b7a30254d9fb9653c2f815eaa28@AcuMS.aculab.com>
 <0ecb87dcc4cf42328f1f5a7d6abd08ed@AcuMS.aculab.com>
 <ffebaea4-8135-6e2e-fca1-8e9f118ef70b@gmx.de>
In-Reply-To: <ffebaea4-8135-6e2e-fca1-8e9f118ef70b@gmx.de>
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

RnJvbTogSGVsZ2UgRGVsbGVyDQo+IFNlbnQ6IDE0IEZlYnJ1YXJ5IDIwMjIgMTE6MDUNCj4gDQo+
IE9uIDIvMTQvMjIgMTA6MjYsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBGcm9tOiBEYXZpZCBM
YWlnaHQNCj4gPj4gU2VudDogMTQgRmVicnVhcnkgMjAyMiAwOToxMg0KPiA+Pg0KPiA+PiBGcm9t
OiBIZWxnZSBEZWxsZXINCj4gPj4+IFNlbnQ6IDEzIEZlYnJ1YXJ5IDIwMjIgMjI6MTANCj4gPj4+
DQo+ID4+PiBUaGUgcHV0X3VzZXIodmFsLHB0cikgbWFjcm8gd2FudHMgYSBwb2ludGVyIGluIHRo
ZSBzZWNvbmQgcGFyYW1ldGVyLCBidXQgaW4NCj4gPj4+IGZhdF9pb2N0bF9maWxsZGlyKCkgdGhl
IGRfbmFtZSBmaWVsZCByZWZlcmVuY2VzIGEgd2hvbGUgImFycmF5IG9mIGNoYXJzIi4NCj4gPj4+
IFVzdWFsbHkgdGhlIGNvbXBpbGVyIGF1dG9tYXRpY2FsbHkgY29udmVydHMgaXQgYW5kIHVzZXMg
YSBwb2ludGVyIHRvIHRoYXQNCj4gPj4+IGFycmF5LCBidXQgaXQncyBtb3JlIGNsZWFuIHRvIGV4
cGxpY2l0bHkgZ2l2ZSB0aGUgcmVhbCBwb2ludGVyIHRvIHdoZXJlIHNvbWV0aW5nDQo+ID4+PiBp
cyBwdXQsIHdoaWNoIGlzIGluIHRoaXMgY2FzZSB0aGUgZmlyc3QgY2hhcmFjdGVyIG9mIHRoZSBk
X25hbWVbXSBhcnJheS4NCj4gPj4NCj4gPj4gVGhhdCBqdXN0IGlzbid0IHRydWUuDQo+ID4+DQo+
ID4+IEluIEMgYm90aCB4LT5jaGFyX2FycmF5IGFuZCAmeC0+Y2hhcl9hcnJheVswXSBoYXZlIHRo
ZSBzYW1lIHR5cGUNCj4gPj4gJ2NoYXIgKicuDQo+ID4+DQo+ID4+IFRoZSAnYnVnJyBpcyBjYXVz
ZWQgYnkgcHV0X3VzZXIoKSB0cnlpbmcgdG8gZG86DQo+ID4+IAlfX3R5cGVvZl9fKHB0cikgX19w
dHIgPSBwdHI7DQo+ID4+IHdoZXJlIF9fdHlwZW9mX18gaXMgcmV0dXJuaW5nIGNoYXJbbl0gbm90
IGNoYXIgKi4NCj4gPj4NCj4gPj4gSSd2ZSB0cmllZCBhIGZldyB0aGluZ3MgYnV0IGNhbid0IGdl
dCBfX3R5cGVvZl9fIHRvDQo+ID4+IGdlbmVyYXRlIGEgc3VpdGFibGUgdHlwZSBmb3IgYm90aCBh
IHNpbXBsZSB0eXBlIGFuZCBhcnJheS4NCj4gPg0KPiA+IEFjdHVhbGx5IHRoZSBpc3N1ZSBpcyB0
aGF0IHB1dF91c2VyKCkgd3JpdGVzIGEgc2luZ2xlIHZhcmlhYmxlDQo+ID4gYW5kIG5lZWRzIGEg
cG9pbnRlciB0byBvbmUuDQo+ID4gU28gY2hhbmdpbmcgdG86DQo+ID4gCXB1dF91c2VyKDAsICZh
cnJheVswXSk7DQo+ID4gaXMgcHJvYmFibHkgZmluZS4NCj4gDQo+IE9rLg0KPiANCj4gPiBCdXQg
dGhlIGRlc2NyaXB0aW9uIGlzIGFsbCB3cm9uZy4NCj4gDQo+IEkgYWdyZWUgaXQgY2FuIGJlIGlt
cHJvdmVkLg0KPiBXb3VsZCB5b3UgbWluZCBwcm9wb3NpbmcgYSBiZXR0ZXIgZGVzY3JpcHRpb24/
DQoNCnB1dF91c2VyKCkgbmVlZHMgYSBwb2ludGVyIHRvIGEgc2ltcGxlIHR5cGUuDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

