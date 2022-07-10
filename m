Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898C856CC3A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 04:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiGJCIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 22:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGJCIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 22:08:22 -0400
X-Greylist: delayed 1861 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Jul 2022 19:08:19 PDT
Received: from m1564.mail.126.com (m1564.mail.126.com [220.181.15.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5792240B8;
        Sat,  9 Jul 2022 19:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=WFSNP
        JpuFwKyWrFFhWsrKhOuZQcpVRI7jra+CFun2n4=; b=W81/vhCqkxlEdzAL4oRkE
        J5wXAQhSvDx06iN5XnU51iBp9sRYPzuM5Ow4FpEe/5TnwsCwRUmHAN2rlRgnLcMJ
        IBIpDwoOGfZ4qrkB0TPj1hSKb/U9hYvBpgb/22k/vKqQ5B0Cf+k0ROpqyxLfSctl
        2TBu+w4KQjAJ/Rw28Qst6Q=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr64
 (Coremail) ; Sun, 10 Jul 2022 09:37:10 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Sun, 10 Jul 2022 09:37:10 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] input/serio: Fix refcount leak bug in i8042-sparcio
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <YskI088DEjt39Dqm@google.com>
References: <20220619073036.4067872-1-windhl@126.com>
 <YskI088DEjt39Dqm@google.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5b7bcbf5.3f6.181e5c0dcff.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: QMqowAD3BnNHLcpiobZIAA--.51094W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7QU5F1pEAXnn2QABsf
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgpBdCAyMDIyLTA3LTA5IDEyOjQ5OjIzLCAiRG1pdHJ5IFRvcm9raG92IiA8ZG1pdHJ5LnRv
cm9raG92QGdtYWlsLmNvbT4gd3JvdGU6Cj5IaSBMaWFuZywKPgo+T24gU3VuLCBKdW4gMTksIDIw
MjIgYXQgMDM6MzA6MzZQTSArMDgwMCwgTGlhbmcgSGUgd3JvdGU6Cj4+IEluIGk4MDQyX3BsYXRm
b3JtX2luaXQoKSBhbmQgaTgwNDJfcGxhdGZvcm1fZXhpdCgpLCB3ZSBuZWVkIGNhbGwKPj4gb2Zf
bm9kZV9wdXQoKSB0byBrZWVwIHJlZmNvdW50IGJhbGFuY2UuCj4+IAo+PiBTaWduZWQtb2ZmLWJ5
OiBMaWFuZyBIZSA8d2luZGhsQDEyNi5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy9pbnB1dC9zZXJp
by9pODA0Mi1zcGFyY2lvLmggfCA0ICsrKysKPj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKykKPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L3NlcmlvL2k4MDQyLXNwYXJj
aW8uaCBiL2RyaXZlcnMvaW5wdXQvc2VyaW8vaTgwNDItc3BhcmNpby5oCj4+IGluZGV4IGZjZTc2
ODEyODQzYi4uYTJhOWRiOTIyMGQ3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lucHV0L3Nlcmlv
L2k4MDQyLXNwYXJjaW8uaAo+PiArKysgYi9kcml2ZXJzL2lucHV0L3NlcmlvL2k4MDQyLXNwYXJj
aW8uaAo+PiBAQCAtMTA4LDYgKzEwOCw4IEBAIHN0YXRpYyBpbnQgX19pbml0IGk4MDQyX3BsYXRm
b3JtX2luaXQodm9pZCkKPj4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKnJvb3QgPSBvZl9maW5kX25v
ZGVfYnlfcGF0aCgiLyIpOwo+PiAgCWNvbnN0IGNoYXIgKm5hbWUgPSBvZl9nZXRfcHJvcGVydHko
cm9vdCwgIm5hbWUiLCBOVUxMKTsKPj4gIAo+PiArCW9mX25vZGVfcHV0KHJvb3QpOwo+PiArCj4+
ICAJaWYgKG5hbWUgJiYgIXN0cmNtcChuYW1lLCAiU1VOVyxKYXZhU3RhdGlvbi0xIikpIHsKPj4g
IAkJLyogSGFyZGNvZGVkIHZhbHVlcyBmb3IgTXJDb2ZmZWUuICAqLwo+PiAgCQlpODA0Ml9rYmRf
aXJxID0gaTgwNDJfYXV4X2lycSA9IDEzIHwgMHgyMDsKPj4gQEAgLTEzOSw2ICsxNDEsOCBAQCBz
dGF0aWMgaW5saW5lIHZvaWQgaTgwNDJfcGxhdGZvcm1fZXhpdCh2b2lkKQo+PiAgCXN0cnVjdCBk
ZXZpY2Vfbm9kZSAqcm9vdCA9IG9mX2ZpbmRfbm9kZV9ieV9wYXRoKCIvIik7Cj4+ICAJY29uc3Qg
Y2hhciAqbmFtZSA9IG9mX2dldF9wcm9wZXJ0eShyb290LCAibmFtZSIsIE5VTEwpOwo+PiAgCj4+
ICsJb2Zfbm9kZV9wdXQocm9vdCk7Cj4+ICsKPj4gIAlpZiAoIW5hbWUgfHwgc3RyY21wKG5hbWUs
ICJTVU5XLEphdmFTdGF0aW9uLTEiKSkKPj4gIAkJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIo
JnNwYXJjX2k4MDQyX2RyaXZlcik7Cj4+ICB9Cj4KPlRoZXJlIGFscmVhZHkgd2FzIGFuIGF0dGVt
cHQgdG8gZml4IHRoaXMgaXNzdWUgaW4gYSBzbGlnaHRseSBiZXR0ZXIgd2F5LAo+dW5mb3J0dW5h
dGVseSB0aGUgb3JpZ2luYWwgYXV0aG9yIGRpZCBub3QgZmluaXNoIHRoZSB3b3JrOgo+Cj5odHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAxODEyMTIxNjM1NDguMjM3MjMtMS10aW55LndpbmR6
ekBnbWFpbC5jb20vCj4KPlRoYW5rcy4KPgo+LS0gCj5EbWl0cnkKCkhpLCBEbWlydHJ5LAoKVGhh
bmtzIGZvciByZXZpZXdpbmcgbXkgcGF0Y2ggY29kZS4KClRoZSBMaSdzIHBhdGNoIGFkZHMgYSBo
ZWxwZXIgYW5kIGlzIGJldHRlciB0aGFuIG1pbmUuCgpUaGFua3MgYWdhaW4sCgpMaWFuZyAK
