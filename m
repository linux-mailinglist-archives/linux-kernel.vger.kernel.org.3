Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27CA54DA81
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359123AbiFPGZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbiFPGZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:25:50 -0400
Received: from m1524.mail.126.com (m1524.mail.126.com [220.181.15.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D62F35256
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=oZmYr
        t1TXBesr3M6NYUwqG/UbHwgSwjMr941Rc7K/pQ=; b=a+FlnFJZM3RUwB9sRNKEl
        TPnRDD2veXat+izLtfZ3guTOhLhbxdFBbBW+159Q8AwlhwwEF77QwQo0Ak69ZLVB
        oTGfbbsVeNLnO/DtNEytXwA/ixtybo8zvlpaek/mPKhRtLvP6ECIwShORA4gEZF1
        iqVhVXGCFTjMpWPFkHbIjY=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr24
 (Coremail) ; Thu, 16 Jun 2022 14:25:12 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Thu, 16 Jun 2022 14:25:12 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Viresh Kumar" <viresh.kumar@linaro.org>
Cc:     vireshk@kernel.org, shiraz.linux.kernel@gmail.com, soc@kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] arch: arm: mach-spear: Add missing of_node_put() in
 time.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <20220616060605.jtbgai74w4f7ddyh@vireshk-i7>
References: <20220615123912.3965902-1-windhl@126.com>
 <20220616060605.jtbgai74w4f7ddyh@vireshk-i7>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5bab2e47.4324.1816b2ff063.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GMqowACHjyfJzKpiowg3AA--.9435W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizgciF18RPTZzhQABsO
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjItMDYtMTYgMTQ6MDY6MDUsICJWaXJlc2ggS3VtYXIiIDx2aXJlc2gua3VtYXJAbGlu
YXJvLm9yZz4gd3JvdGU6Cj5PbiAxNS0wNi0yMiwgMjA6MzksIExpYW5nIEhlIHdyb3RlOgo+PiBJ
biBzcGVhcl9zZXR1cF9vZl90aW1lcigpLCBvZl9maW5kX21hdGNoaW5nX25vZGUoKSB3aWxsIHJl
dHVybiBhCj4+IG5vZGUgcG9pbnRlciB3aXRoIHJlZmNvdW50IGluY3JlbWVudGQuIFdlIHNob3Vs
ZCB1c2Ugb2Zfbm9kZV9wdXQoKQo+PiBpbiBlYWNoIGZhaWwgcGF0aCBvciB3aGVuIGl0IGlzIG5v
dCB1c2VkIGFueW1vcmUuCj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBMaWFuZyBIZSA8d2luZGhsQDEy
Ni5jb20+Cj4+IC0tLQo+PiAgYXJjaC9hcm0vbWFjaC1zcGVhci90aW1lLmMgfCA2ICsrKysrLQo+
PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+PiAKPj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtc3BlYXIvdGltZS5jIGIvYXJjaC9hcm0vbWFjaC1z
cGVhci90aW1lLmMKPj4gaW5kZXggZDFmZGI2MDY2ZjdiLi5hMWI2NjM1YjRlY2IgMTAwNjQ0Cj4+
IC0tLSBhL2FyY2gvYXJtL21hY2gtc3BlYXIvdGltZS5jCj4+ICsrKyBiL2FyY2gvYXJtL21hY2gt
c3BlYXIvdGltZS5jCj4+IEBAIC0yMTcsMTYgKzIxNywyMCBAQCB2b2lkIF9faW5pdCBzcGVhcl9z
ZXR1cF9vZl90aW1lcih2b2lkKQo+PiAgCj4+ICAJaXJxID0gaXJxX29mX3BhcnNlX2FuZF9tYXAo
bnAsIDApOwo+PiAgCWlmICghaXJxKSB7Cj4+ICsJCW9mX25vZGVfcHV0KG5wKTsKPj4gIAkJcHJf
ZXJyKCIlczogTm8gaXJxIHBhc3NlZCBmb3IgdGltZXIgdmlhIERUXG4iLCBfX2Z1bmNfXyk7Cj4+
ICAJCXJldHVybjsKPj4gIAl9Cj4+ICAKPj4gIAlncHRfYmFzZSA9IG9mX2lvbWFwKG5wLCAwKTsK
Pj4gIAlpZiAoIWdwdF9iYXNlKSB7Cj4+ICsJCW9mX25vZGVfcHV0KG5wKTsKPj4gIAkJcHJfZXJy
KCIlczogb2YgaW9tYXAgZmFpbGVkXG4iLCBfX2Z1bmNfXyk7Cj4+ICAJCXJldHVybjsKPj4gIAl9
Cj4+IC0KPj4gKwkKPj4gKwlvZl9ub2RlX3B1dChucCk7Cj4+ICsJCj4+ICAJZ3B0X2NsayA9IGNs
a19nZXRfc3lzKCJncHQwIiwgTlVMTCk7Cj4+ICAJaWYgKElTX0VSUihncHRfY2xrKSkgewo+PiAg
CQlwcl9lcnIoIiVzOmNvdWxkbid0IGdldCBjbGsgZm9yIGdwdFxuIiwgX19mdW5jX18pOwo+Cj5T
aW5jZSB0aGlzIHJvdXRpbmUgYWxyZWFkeSBoYXZlIGVycm9yIGxhYmVscywgZm9yIGNvbnNpc3Rl
bmNlIGl0IHdvdWxkIGJlIGJldHRlcgo+dG8gYWRkIGFub3RoZXIgb25lICJlcnJfcHV0X25wIiBh
bmQgdXNlIGdvdG8gdG8gdGhhdCA/Cj4KPi0tIAo+dmlyZXNoCgoKVGhhbmtzIGZvciB5b3VyIHJl
cGx5LiBJIHdpbGwgbWFrZSBhIG5ldyBwYXRjaCBmb3IgdGhhdC4KCkxpYW5n
