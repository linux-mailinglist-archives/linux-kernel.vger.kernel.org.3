Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38C556D429
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 06:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiGKE6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 00:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGKE6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:58:01 -0400
Received: from m151.mail.126.com (m151.mail.126.com [220.181.15.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA2F3F583;
        Sun, 10 Jul 2022 21:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=65ngY
        rvV3KMV1ztJX1Ell1RlOnJw2EPgc14cLkNCPL4=; b=Wa4dzib1IuoV9NNJg+sdf
        qwgtQymYcp47P9lG2HS8vDTpfwhwt5/lJc6hPbScROmKJvMoQpiMPZtUsRBRGdYr
        AnJHv+vyVupUufZfxC+lMqqk3LUCERiCAlTshBubRu1yhY7WNHKWAUZt9WhMza+M
        /wc8ouOk+OxmP4r6/20NPo=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr1
 (Coremail) ; Mon, 11 Jul 2022 12:57:52 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Mon, 11 Jul 2022 12:57:52 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: Re: [PATCH] input/serio: Fix refcount leak bug in
 i8042-sparcio
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <YsuWuJTQsMlQabqt@google.com>
References: <20220619073036.4067872-1-windhl@126.com>
 <YskI088DEjt39Dqm@google.com>
 <5b7bcbf5.3f6.181e5c0dcff.Coremail.windhl@126.com>
 <YsuWuJTQsMlQabqt@google.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <3da61037.1b03.181eb9ef491.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AcqowABHeLDRrctiG9UgAA--.48054W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizgk7F18RPeIWbwACsB
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCkF0IDIwMjItMDctMTEgMTE6MTk6MjAsICJEbWl0cnkgVG9yb2tob3YiIDxkbWl0cnkudG9y
b2tob3ZAZ21haWwuY29tPiB3cm90ZToKPk9uIFN1biwgSnVsIDEwLCAyMDIyIGF0IDA5OjM3OjEw
QU0gKzA4MDAsIExpYW5nIEhlIHdyb3RlOgo+PiBBdCAyMDIyLTA3LTA5IDEyOjQ5OjIzLCAiRG1p
dHJ5IFRvcm9raG92IiA8ZG1pdHJ5LnRvcm9raG92QGdtYWlsLmNvbT4gd3JvdGU6Cj4+ID5IaSBM
aWFuZywKPj4gPgo+PiA+T24gU3VuLCBKdW4gMTksIDIwMjIgYXQgMDM6MzA6MzZQTSArMDgwMCwg
TGlhbmcgSGUgd3JvdGU6Cj4+ID4+IEluIGk4MDQyX3BsYXRmb3JtX2luaXQoKSBhbmQgaTgwNDJf
cGxhdGZvcm1fZXhpdCgpLCB3ZSBuZWVkIGNhbGwKPj4gPj4gb2Zfbm9kZV9wdXQoKSB0byBrZWVw
IHJlZmNvdW50IGJhbGFuY2UuCj4+ID4+IAo+PiA+PiBTaWduZWQtb2ZmLWJ5OiBMaWFuZyBIZSA8
d2luZGhsQDEyNi5jb20+Cj4+ID4+IC0tLQo+PiA+PiAgZHJpdmVycy9pbnB1dC9zZXJpby9pODA0
Mi1zcGFyY2lvLmggfCA0ICsrKysKPj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykKPj4gPj4gCj4+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L3NlcmlvL2k4MDQyLXNw
YXJjaW8uaCBiL2RyaXZlcnMvaW5wdXQvc2VyaW8vaTgwNDItc3BhcmNpby5oCj4+ID4+IGluZGV4
IGZjZTc2ODEyODQzYi4uYTJhOWRiOTIyMGQ3IDEwMDY0NAo+PiA+PiAtLS0gYS9kcml2ZXJzL2lu
cHV0L3NlcmlvL2k4MDQyLXNwYXJjaW8uaAo+PiA+PiArKysgYi9kcml2ZXJzL2lucHV0L3Nlcmlv
L2k4MDQyLXNwYXJjaW8uaAo+PiA+PiBAQCAtMTA4LDYgKzEwOCw4IEBAIHN0YXRpYyBpbnQgX19p
bml0IGk4MDQyX3BsYXRmb3JtX2luaXQodm9pZCkKPj4gPj4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUg
KnJvb3QgPSBvZl9maW5kX25vZGVfYnlfcGF0aCgiLyIpOwo+PiA+PiAgCWNvbnN0IGNoYXIgKm5h
bWUgPSBvZl9nZXRfcHJvcGVydHkocm9vdCwgIm5hbWUiLCBOVUxMKTsKPj4gPj4gIAo+PiA+PiAr
CW9mX25vZGVfcHV0KHJvb3QpOwo+PiA+PiArCj4+ID4+ICAJaWYgKG5hbWUgJiYgIXN0cmNtcChu
YW1lLCAiU1VOVyxKYXZhU3RhdGlvbi0xIikpIHsKPj4gPj4gIAkJLyogSGFyZGNvZGVkIHZhbHVl
cyBmb3IgTXJDb2ZmZWUuICAqLwo+PiA+PiAgCQlpODA0Ml9rYmRfaXJxID0gaTgwNDJfYXV4X2ly
cSA9IDEzIHwgMHgyMDsKPj4gPj4gQEAgLTEzOSw2ICsxNDEsOCBAQCBzdGF0aWMgaW5saW5lIHZv
aWQgaTgwNDJfcGxhdGZvcm1fZXhpdCh2b2lkKQo+PiA+PiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAq
cm9vdCA9IG9mX2ZpbmRfbm9kZV9ieV9wYXRoKCIvIik7Cj4+ID4+ICAJY29uc3QgY2hhciAqbmFt
ZSA9IG9mX2dldF9wcm9wZXJ0eShyb290LCAibmFtZSIsIE5VTEwpOwo+PiA+PiAgCj4+ID4+ICsJ
b2Zfbm9kZV9wdXQocm9vdCk7Cj4+ID4+ICsKPj4gPj4gIAlpZiAoIW5hbWUgfHwgc3RyY21wKG5h
bWUsICJTVU5XLEphdmFTdGF0aW9uLTEiKSkKPj4gPj4gIAkJcGxhdGZvcm1fZHJpdmVyX3VucmVn
aXN0ZXIoJnNwYXJjX2k4MDQyX2RyaXZlcik7Cj4+ID4+ICB9Cj4+ID4KPj4gPlRoZXJlIGFscmVh
ZHkgd2FzIGFuIGF0dGVtcHQgdG8gZml4IHRoaXMgaXNzdWUgaW4gYSBzbGlnaHRseSBiZXR0ZXIg
d2F5LAo+PiA+dW5mb3J0dW5hdGVseSB0aGUgb3JpZ2luYWwgYXV0aG9yIGRpZCBub3QgZmluaXNo
IHRoZSB3b3JrOgo+PiA+Cj4+ID5odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAxODEyMTIx
NjM1NDguMjM3MjMtMS10aW55LndpbmR6ekBnbWFpbC5jb20vCj4+ID4KPj4gPlRoYW5rcy4KPj4g
Pgo+PiA+LS0gCj4+ID5EbWl0cnkKPj4gCj4+IEhpLCBEbWlydHJ5LAo+PiAKPj4gVGhhbmtzIGZv
ciByZXZpZXdpbmcgbXkgcGF0Y2ggY29kZS4KPj4gCj4+IFRoZSBMaSdzIHBhdGNoIGFkZHMgYSBo
ZWxwZXIgYW5kIGlzIGJldHRlciB0aGFuIG1pbmUuCj4KPlJpZ2h0LCBob3dldmVyIHRoZXJlIGlz
IGEgY29tcGlsZSBlcnJvciBpbiBMaSdzIHZlcnNpb24uIEl0IHdvdWxkIGJlCj5ncmVhdCBpZiBz
b21lb25lIGNvdWxkIGZpbmlzaCB0aGVpciB3b3JrLgo+Cj5UaGFua3MuCj4KPi0tIAo+RG1pdHJ5
CgoKVGhhbmtzLCAKCkknZCBsaWtlIHRvIGNvbnRpbnVlIExpJ3Mgd29yayBhbmQgY29tcGxldGUg
aXQgc29vbi4KCkxpYW5n
