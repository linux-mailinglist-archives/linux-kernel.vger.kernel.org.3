Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9520258D1A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 03:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244555AbiHIBCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 21:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbiHIBCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 21:02:41 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BDA4C1CB32
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 18:02:38 -0700 (PDT)
Received: by ajax-webmail-mail-app4 (Coremail) ; Tue, 9 Aug 2022 09:02:18
 +0800 (GMT+08:00)
X-Originating-IP: [218.12.17.53]
Date:   Tue, 9 Aug 2022 09:02:18 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   duoming@zju.edu.cn
To:     "Thomas Gleixner" <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, jstultz@google.com, sboyd@kernel.org,
        edumazet@google.com
Subject: Re: [PATCH] timers: fix synchronization rules in comments of
 del_timer_sync
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <877d3irfze.ffs@tglx>
References: <20220701085535.17018-1-duoming@zju.edu.cn>
 <877d3irfze.ffs@tglx>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4a6d3b57.7607e.182801fb63f.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgAnYvwbsvFipJmEAg--.37634W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgERAVZdta+N6AABsm
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgpPbiBNb24sIDA4IEF1ZyAyMDIyIDE2OjAxOjU3ICswMjAwIFRob21hcyBHbGVpeG5l
ciB3cm90ZToKCj4gT24gRnJpLCBKdWwgMDEgMjAyMiBhdCAxNjo1NSwgRHVvbWluZyBaaG91IHdy
b3RlOgo+ID4gLSAqIFN5bmNocm9uaXphdGlvbiBydWxlczogQ2FsbGVycyBtdXN0IHByZXZlbnQg
cmVzdGFydGluZyBvZiB0aGUgdGltZXIsCj4gPiAtICogb3RoZXJ3aXNlIHRoaXMgZnVuY3Rpb24g
aXMgbWVhbmluZ2xlc3MuIEl0IG11c3Qgbm90IGJlIGNhbGxlZCBmcm9tCj4gPiAtICogaW50ZXJy
dXB0IGNvbnRleHRzIHVubGVzcyB0aGUgdGltZXIgaXMgYW4gaXJxc2FmZSBvbmUuIFRoZSBjYWxs
ZXIgbXVzdAo+ID4gLSAqIG5vdCBob2xkIGxvY2tzIHdoaWNoIHdvdWxkIHByZXZlbnQgY29tcGxl
dGlvbiBvZiB0aGUgdGltZXIncwo+ID4gLSAqIGhhbmRsZXIuIFRoZSB0aW1lcidzIGhhbmRsZXIg
bXVzdCBub3QgY2FsbCBhZGRfdGltZXJfb24oKS4gVXBvbiBleGl0IHRoZQo+ID4gLSAqIHRpbWVy
IGlzIG5vdCBxdWV1ZWQgYW5kIHRoZSBoYW5kbGVyIGlzIG5vdCBydW5uaW5nIG9uIGFueSBDUFUu
Cj4gPiArICogU3luY2hyb25pemF0aW9uIHJ1bGVzOiBDYWxsZXJzIG11c3QgcHJldmVudCByZXN0
YXJ0aW5nIG9mIHRoZSB0aW1lciBpbgo+ID4gKyAqIG90aGVyIHBsYWNlcyBleGNlcHQgZm9yIHRo
ZSB0aW1lcidzIGhhbmRsZXIsIG90aGVyd2lzZSB0aGlzIGZ1bmN0aW9uIGlzCj4gPiArICogbWVh
bmluZ2xlc3MuIEl0IG11c3Qgbm90IGJlIGNhbGxlZCBmcm9tIGludGVycnVwdCBjb250ZXh0cyB1
bmxlc3MgdGhlCj4gPiArICogdGltZXIgaXMgYW4gaXJxc2FmZSBvbmUuIFRoZSBjYWxsZXIgbXVz
dCBub3QgaG9sZCBsb2NrcyB3aGljaCB3b3VsZAo+ID4gKyAqIHByZXZlbnQgY29tcGxldGlvbiBv
ZiB0aGUgdGltZXIncyBoYW5kbGVyLiBUaGUgdGltZXIncyBoYW5kbGVyIG11c3QKPiA+ICsgKiBu
b3QgY2FsbCBhZGRfdGltZXJfb24oKS4KPiAKPiBJZiB3ZSBhcmUgbWFraW5nIHRoaXMgY29ycmVj
dDogV2hhdCdzIHNvIHNwZWNpYWwgYWJvdXQgYWRkX3RpbWVyX29uKCk/CgpUaGUgZGVsX3RpbWVy
X3N5bmMoKSBjb3VsZCBhbHNvIHN0b3AgYWRkX3RpbWVyX29uKCksIHRoZXJlIGlzIG5vdGhpbmcg
c3BlY2lhbAphYm91dCBhZGRfdGltZXJfb24oKS4gSSB0aGluayBjaGFuZ2UgdGhlIGFubm90YXRp
b24gdG8gdGhlIGZvbGxvd2luZyBpcyBiZXR0ZXIuCgpkaWZmIC0tZ2l0IGEva2VybmVsL3RpbWUv
dGltZXIuYyBiL2tlcm5lbC90aW1lL3RpbWVyLmMKaW5kZXggNzE3ZmNiOWZiMTQuLmRkNjIzMDE4
ZGJjIDEwMDY0NAotLS0gYS9rZXJuZWwvdGltZS90aW1lci5jCisrKyBiL2tlcm5lbC90aW1lL3Rp
bWVyLmMKQEAgLTEzNzUsMTEgKzEzNzUsMTEgQEAgc3RhdGljIGlubGluZSB2b2lkIGRlbF90aW1l
cl93YWl0X3J1bm5pbmcoc3RydWN0IHRpbWVyX2xpc3QgKnRpbWVyKSB7IH0KICAqIENQVXMuCiAg
KgogICogU3luY2hyb25pemF0aW9uIHJ1bGVzOiBDYWxsZXJzIG11c3QgcHJldmVudCByZXN0YXJ0
aW5nIG9mIHRoZSB0aW1lciwKLSAqIG90aGVyd2lzZSB0aGlzIGZ1bmN0aW9uIGlzIG1lYW5pbmds
ZXNzLiBJdCBtdXN0IG5vdCBiZSBjYWxsZWQgZnJvbQotICogaW50ZXJydXB0IGNvbnRleHRzIHVu
bGVzcyB0aGUgdGltZXIgaXMgYW4gaXJxc2FmZSBvbmUuIFRoZSBjYWxsZXIgbXVzdAotICogbm90
IGhvbGQgbG9ja3Mgd2hpY2ggd291bGQgcHJldmVudCBjb21wbGV0aW9uIG9mIHRoZSB0aW1lcidz
Ci0gKiBoYW5kbGVyLiBUaGUgdGltZXIncyBoYW5kbGVyIG11c3Qgbm90IGNhbGwgYWRkX3RpbWVy
X29uKCkuIFVwb24gZXhpdCB0aGUKLSAqIHRpbWVyIGlzIG5vdCBxdWV1ZWQgYW5kIHRoZSBoYW5k
bGVyIGlzIG5vdCBydW5uaW5nIG9uIGFueSBDUFUuCisgKiBvdGhlcndpc2UgdGhpcyBmdW5jdGlv
biBpcyBtZWFuaW5nbGVzcy4gSXQgY291bGQgYWxzbyBzdG9wIHBlcmlvZGljIHRpbWVyLgorICog
SXQgbXVzdCBub3QgYmUgY2FsbGVkIGZyb20gaW50ZXJydXB0IGNvbnRleHRzIHVubGVzcyB0aGUg
dGltZXIgaXMgYW4gaXJxc2FmZQorICogb25lLiBUaGUgY2FsbGVyIG11c3Qgbm90IGhvbGQgbG9j
a3Mgd2hpY2ggd291bGQgcHJldmVudCBjb21wbGV0aW9uIG9mIHRoZQorICogdGltZXIncyBoYW5k
bGVyLiBVcG9uIGV4aXQgdGhlIHRpbWVyIGlzIG5vdCBxdWV1ZWQgYW5kIHRoZSBoYW5kbGVyIGlz
IG5vdAorICogcnVubmluZyBvbiBhbnkgQ1BVLgoKQmVzdCByZWdhcmRzLApEdW9taW5nIFpob3U=

