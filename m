Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053064C27B1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiBXJN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiBXJNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:13:24 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05810106B36
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:12:54 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-135-AAav-_ENONazwu5nYMLlXw-1; Thu, 24 Feb 2022 09:12:51 +0000
X-MC-Unique: AAav-_ENONazwu5nYMLlXw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 24 Feb 2022 09:12:51 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 24 Feb 2022 09:12:51 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Geert Uytterhoeven' <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>
CC:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] m68k: Implement "current_stack_pointer"
Thread-Topic: [PATCH] m68k: Implement "current_stack_pointer"
Thread-Index: AQHYKVzdWGzmeUZEQEqpz/PmAjDYBqyiaMrQ
Date:   Thu, 24 Feb 2022 09:12:51 +0000
Message-ID: <d75f1259c3e64387a161ebcb0448d594@AcuMS.aculab.com>
References: <20220224060448.1856091-1-keescook@chromium.org>
 <CAMuHMdVioQLy_T2LimgWdfWM=j=fomfpayuS1mbXnBLZj4gGQA@mail.gmail.com>
In-Reply-To: <CAMuHMdVioQLy_T2LimgWdfWM=j=fomfpayuS1mbXnBLZj4gGQA@mail.gmail.com>
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

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuDQo+IFNlbnQ6IDI0IEZlYnJ1YXJ5IDIwMjIgMDg6NTkN
Ci4uLg0KPiA+ICtyZWdpc3RlciB1bnNpZ25lZCBsb25nIGN1cnJlbnRfc3RhY2tfcG9pbnRlciBf
X2FzbV9fKCJzcCIpOw0KPiANCj4gSSBkb24ndCBrbm93IHdoYXQgSEFSREVORURfVVNFUkNPUFkg
ZG9lcywgc28gSSBkb24ndCBrbm93IGlmIHlvdSBuZWVkDQo+ICJ1c3AiIChzZWUgcmR1c3AoKSkg
b3IgInNwIj8NCg0KSEFSREVORURfVVNFUkNPUFkgc2lnbmlmaWNhbnRseSBzbG93cyBkb3duIHNv
bWUgc3lzdGVtcyBjYWxscw0KKGVzcGVjaWFsbHkgdGhpbmdzIGxpa2Ugc2VuZG1zZygpKSBieSB0
cnlpbmcgdG8gcnVuLXRpbWUgdmVyaWZ5DQp0aGF0IHRoZSBrZXJuZWwgYnVmZmVyIGRvZXNuJ3Qg
b3ZlcnJ1biBhIHN0YWNrIGZyYW1lIG9yIGttYWxsb2MoKWVkDQpidWZmZXIuDQoNCkkndmUgZ290
IG1lYXN1cmFibGUgaW1wcm92ZW1lbnRzIGJ5IGVpdGhlciB1c2luZyBfX2NvcHlfdG8vZnJvbV91
c2VyKCkNCih3aGljaCBza2lwcyB0aGUgdGVzdHMpIG9yIHVzZXJfYWNjZXNzX2JlZ2luKCkgYW5k
IF9fZ2V0X3VzZXIoKS4NCg0KQXQgdGhlIG1vbWVudCB0aGUgY29kZSBmb3IgcmVhZGluZyBhIGNv
bXBhdCBpb3ZlY1tdIGlzIGFjdHVhbGx5DQpmYXN0ZXIgdGhhbiB0aGF0IGZvciBhIG5hdGl2ZSBv
bmUhDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

