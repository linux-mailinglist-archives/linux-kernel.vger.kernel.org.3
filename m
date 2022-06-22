Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76465540C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 05:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356377AbiFVDJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 23:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356433AbiFVDJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 23:09:27 -0400
Received: from m13110.mail.163.com (m13110.mail.163.com [220.181.13.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6F532E9C5;
        Tue, 21 Jun 2022 20:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=iXs7L
        R1EaZubeCgF4V20nqsxFMsXH0+Zl3GUrT9ynxU=; b=m3uZFftzlKmU8xyLuEcSU
        4WUeYiQ833y2KHgn2IdBjDucVTxTFvblZ5MDcRe1geHRVoTN8yInjZE6UpM1ZoaK
        6Ts7pPN0q55gO/M/NoOy6tbW0fC2VySzqUYIht6ozmn2lYm9Fs4dEGX1qDvaeZIl
        dMf0q9vy9LB1pomu8d1sxc=
Received: from slark_xiao$163.com ( [112.97.63.176] ) by
 ajax-webmail-wmsvr110 (Coremail) ; Wed, 22 Jun 2022 11:08:49 +0800 (CST)
X-Originating-IP: [112.97.63.176]
Date:   Wed, 22 Jun 2022 11:08:49 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Johan Hovold" <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] USB: serial: use kmemdup instead of kmalloc + memcpy
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <YrBx2eQYwiGcDC8m@hovoldconsulting.com>
References: <20220620105939.5128-1-slark_xiao@163.com>
 <YrBx2eQYwiGcDC8m@hovoldconsulting.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <10bf330.1519.18189624c34.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: bsGowADXQwfCh7JisOoRAA--.7103W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQEoZGBbD9CRLgAAsj
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIyLTA2LTIwIDIxOjEwOjQ5LCAiSm9oYW4gSG92b2xkIiA8am9oYW5Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj5PbiBNb24sIEp1biAyMCwgMjAyMiBhdCAwNjo1OTozOVBNICswODAwLCBTbGFy
ayBYaWFvIHdyb3RlOgo+PiBGb3IgY29kZSBuZWF0IHB1cnBvc2UsIHdlIGNhbiB1c2Uga21lbWR1
cCB0byByZXBsYWNlCj4+IGttYWxsb2MgKyBtZW1jcHkuCj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBT
bGFyayBYaWFvIDxzbGFya194aWFvQDE2My5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy91c2Ivc2Vy
aWFsL29wdGljb24uYyB8IDQgKy0tLQo+PiAgZHJpdmVycy91c2Ivc2VyaWFsL3NpZXJyYS5jICB8
IDQgKy0tLQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Ivc2VyaWFsL29wdGljb24uYyBiL2Ry
aXZlcnMvdXNiL3NlcmlhbC9vcHRpY29uLmMKPj4gaW5kZXggYWVkMjhjMzVjYWZmLi5iY2E2NzY2
YTYzZTYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdXNiL3NlcmlhbC9vcHRpY29uLmMKPj4gKysr
IGIvZHJpdmVycy91c2Ivc2VyaWFsL29wdGljb24uYwo+PiBAQCAtMjA4LDcgKzIwOCw3IEBAIHN0
YXRpYyBpbnQgb3B0aWNvbl93cml0ZShzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5LCBzdHJ1Y3QgdXNi
X3NlcmlhbF9wb3J0ICpwb3J0LAo+PiAgCXByaXYtPm91dHN0YW5kaW5nX2J5dGVzICs9IGNvdW50
Owo+PiAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnByaXYtPmxvY2ssIGZsYWdzKTsKPj4gIAo+
PiAtCWJ1ZmZlciA9IGttYWxsb2MoY291bnQsIEdGUF9BVE9NSUMpOwo+PiArCWJ1ZmZlciA9IGtt
ZW1kdXAoYnVmLCBjb3VudCwgR0ZQX0FUT01JQyk7Cj4+ICAJaWYgKCFidWZmZXIpCj4+ICAJCWdv
dG8gZXJyb3Jfbm9fYnVmZmVyOwo+PiAgCj4+IEBAIC0yMTYsOCArMjE2LDYgQEAgc3RhdGljIGlu
dCBvcHRpY29uX3dyaXRlKHN0cnVjdCB0dHlfc3RydWN0ICp0dHksIHN0cnVjdCB1c2Jfc2VyaWFs
X3BvcnQgKnBvcnQsCj4+ICAJaWYgKCF1cmIpCj4+ICAJCWdvdG8gZXJyb3Jfbm9fdXJiOwo+PiAg
Cj4+IC0JbWVtY3B5KGJ1ZmZlciwgYnVmLCBjb3VudCk7Cj4+IC0KPj4gIAl1c2Jfc2VyaWFsX2Rl
YnVnX2RhdGEoJnBvcnQtPmRldiwgX19mdW5jX18sIGNvdW50LCBidWZmZXIpOwo+PiAgCj4+ICAJ
LyogVGhlIGNvbm5lY3RlZCBkZXZpY2VzIGRvIG5vdCBoYXZlIGEgYnVsayB3cml0ZSBlbmRwb2lu
dCwKPgo+TG9va3MgbGlrZSB3ZSBoYXZlIHRoZSBzYW1lIHBhdHRlcm4gYWxzbyBpbiBnYXJtaW5f
d3JpdGVfYnVsaygpLiBDYXJlIHRvCj5pbmNsdWRlIHRoYXQgb25lIGFzIHdlbGw/Cj4KPkpvaGFu
Ck9rLCBJIHdpbGwgYWRkIGl0IGludG8gdGhlIHBhdGNoIGFzIHdlbGwgaW4gVjIuCg==
