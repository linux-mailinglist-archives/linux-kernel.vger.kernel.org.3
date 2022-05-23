Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3852D530BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiEWITL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiEWITJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:19:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9FD513FB3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:19:02 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-35-yelfvzMZOpeqA2HWpRXpXQ-1; Mon, 23 May 2022 09:18:59 +0100
X-MC-Unique: yelfvzMZOpeqA2HWpRXpXQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 23 May 2022 09:18:59 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 23 May 2022 09:18:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jens Axboe' <axboe@kernel.dk>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fs: prefer read_iter over read and write_iter over write
Thread-Topic: [PATCH] fs: prefer read_iter over read and write_iter over write
Thread-Index: AQHYbFCwvu9LSlrdFk+NviNR2+4IRK0nyjDggABuI4CAABnZcP//82QAgAPZ0QA=
Date:   Mon, 23 May 2022 08:18:59 +0000
Message-ID: <ec2a3eb465d244338b922f50ff5f7fd4@AcuMS.aculab.com>
References: <20220520135103.166972-1-Jason@zx2c4.com>
 <39ed6917f2e64a07bad8dad63f8dceb4@AcuMS.aculab.com>
 <YogIg9FG7C/f98bf@zx2c4.com>
 <0da16e16caed4282ae97a86f1ba6f6db@AcuMS.aculab.com>
 <471e5654-49d7-9023-62b4-fc98483b1d89@kernel.dk>
In-Reply-To: <471e5654-49d7-9023-62b4-fc98483b1d89@kernel.dk>
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

RnJvbTogSmVucyBBeGJvZQ0KPiBTZW50OiAyMCBNYXkgMjAyMiAyMzoxOA0KPiANCj4gT24gNS8y
MC8yMiA0OjA4IFBNLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4+ICAgIGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xrbWwvWW9leStGT1lPNjlsUzVxUEB6eDJjNC5jb20vDQo+ID4+DQo+ID4+IFRo
ZSBob3BlIGlzIHRoYXQgaXQgZXZlbnR1YWxseSBiZWNvbWVzIGZhc3Rlci4uLiA6LVwNCj4gPg0K
PiA+IEkgc3VzcGVjdCBhbGwgdGhlIHh4eF9pdGVyIGZ1bmN0aW9ucyBuZWVkIG9wdGltaXNpbmcg
Zm9yDQo+ID4gdGhlIGNvbW1vbiBjYXNlIG9mIGEgc2luZ2xlIGJ1ZmZlciBpbiB1c2Vyc3BhY2Uu
DQo+ID4NCj4gPiBUaGF0IGFsc28gaW5jbHVkZXMgdGhlIGNvZGUgdG8gcmVhZCB0aGUgaW92W10g
ZnJvbSB1c2VzcGFjZS4NCj4gPiBBdCB0aGUgbW9tZW50IEkgdGhpbmsgdGhlIDMyYml0IGNvbXBh
dCBjb2RlIGlzIGFjdHVhbGx5DQo+ID4gZmFzdGVyIHRoYW4gdGhlIG5hdGl2ZSBhbWQ2NCB2ZXJz
aW9uIQ0KPiA+IEkndmUgd3JpdHRlbiBzb21lIHBhdGNoZXMgdG8gc3BlZWQgdGhhdCB1cC4NCj4g
PiBCdXQgdGhlIGJpZ2dlciBpbXByb3ZlbWVudHMgYWxsIGhpdCBtYXNzaXZlIGNoYW5nZXMNCj4g
PiB0byB0aGUgaW9yaW5nIGNvZGUuDQo+IA0KPiBEbyB5b3UgaGF2ZSBhIGxpbmsgdG8gdGhvc2Ug
cGF0Y2hlcz8gSSBjYW4gY2VydGFpbmx5IGhlbHAgd2l0aCB0aGUNCj4gaW9fdXJpbmcgc2lkZSBv
ZiB0aGluZ3MsIGFuZCBJIGhhdmUgYSBnZW51aW5lIGludGVyZXN0IGluIGltcHJvdmluZyB0aGUN
Cj4gY29yZSBhbmQgZ2V0dGluZyB0aGUgaXRlciBzaWRlIHVwIHRvIHNudWZmLg0KDQpJJ2xsIHNl
ZSBpZiBJIGNhbiBmaW5kIHRoZW0uDQpTb21lIGJpdHMgb2YgdGhlIGxhc3QgcGF0Y2ggc2V0IGRp
ZCBnZXQgYXBwbGllZC4NCg0KT25lIGFpbSB3YXMgdG8gY2hhbmdlIGFsbCB0aGUgY2FsbGVycyBv
ZiBpbXBvcnRfaW92ZWMoKQ0KdG8gdXNlIGEgc3RydWN0dXJlIHRoYW4gY29udGFpbmVkIGJvdGgg
dGhlICdpb3ZfaXRlcicgYW5kDQp0aGUgJ2lvdnN0YWNrW10nLg0KVGhlIGxpZmV0aW1lcyBvZiB0
aGUgdHdvIHN0cnVjdHVyZXMgYXJlIGVmZmVjdGl2ZWx5IGlkZW50aWNhbC4NCnVzdWFsbHkgdGhl
eSBhcmUgYm90aCBhbGxvY2F0ZWQgb24gc3RhY2sgdG9nZXRoZXIuDQoNCk1lcmdpbmcgdGhlbSB3
b3VsZCBzaWduaWZpY2FudGx5IHNpbXBsaWZ5IHRoZSBjYWxsZXJzDQphbmQgcmVkdWNlIHRoZSBu
dW1iZXIgb2YgcGFyYW1ldGVycyBwYXNzZWQgdGhyb3VnaA0KbXVsdGlwbGUgbGF5ZXJzIG9mIGZ1
bmN0aW9ucyAtIGVzcGVjaWFsbHkgcG9pbnRlcnMNCnBhc3NlZCBieSB2YWx1ZS4NCg0KVGhhdCBj
aGFuZ2UgbmVlZHMgd29yayBkb25lIHRvIHRoZSBpb191cmluZyBjb2RlIHRvIHNhbml0aXNlDQp0
aGUgd2F5IGl0IHVzZXMgdGhlIGlvdnN0YWNrW10gY2FjaGUgYW5kIGFueSBleHRlbmRlZCBrbWFs
bG9jKCllZA0KY29weS4NCg0KSSBuZWVkIHRvIGxvb2sgZWxzZXdoZXJlIGZvciB0aGUgb3B0aW1p
c2F0aW9uIHRvIGltcG9ydF9pb3ZlYygpDQppdHNlbGYuDQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

