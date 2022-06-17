Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B761754FAAB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382840AbiFQPzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiFQPzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:55:46 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F30C721273
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=ZnZX5
        Q0+NPKUJePrwnn9fmW65V1WrQgp0nzaW/v3k08=; b=NimC0iTpIv5u4o6TxN4Zo
        r/Y1r/XxgGlfh/JndV0ENJqHRPxJXWWpC7raJHJUzWNldTEc9qT8ciJXb4FZTDmF
        7jTrEqNLy+gd1qNX2p4CwQpTuuWOtXhWxp44T0oUEFMPCnjcKH9qkq+dFk4gmo0o
        0OaFyYXnh2Wdwu7cJBgkqs=
Received: from windhl$126.com ( [123.112.70.164] ) by ajax-webmail-wmsvr50
 (Coremail) ; Fri, 17 Jun 2022 23:54:58 +0800 (CST)
X-Originating-IP: [123.112.70.164]
Date:   Fri, 17 Jun 2022 23:54:58 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Philipp Zabel" <p.zabel@pengutronix.de>
Cc:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, saravanak@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] arm: mach-imx: Fix refcount leak bug in src
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <fb559ee2b165eeb83f40086ded8c44231cabd372.camel@pengutronix.de>
References: <20220617121235.4047670-1-windhl@126.com>
 <fb559ee2b165eeb83f40086ded8c44231cabd372.camel@pengutronix.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <b4135bf.840f.181725fed70.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowAAnffHTo6xieL04AA--.57943W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuA0jF2JVj6jD7QACs9
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCkF0IDIwMjItMDYtMTcgMjM6Mzk6NDMsICJQaGlsaXBwIFphYmVsIiA8cC56YWJlbEBwZW5n
dXRyb25peC5kZT4gd3JvdGU6Cj5IaSwKPgo+T24gRnIsIDIwMjItMDYtMTcgYXQgMjA6MTIgKzA4
MDAsIExpYW5nIEhlIHdyb3RlOgo+PiBJbiBpbXg3X3NyY19pbml0KCksIG9mX2ZpbmRfY29tcGF0
aWJsZV9ub2RlKCkgd2lsbCByZXR1cm4gYSBub2RlCj4+IHBvaW50ZXIgd2l0aCByZWZjb3VudCBp
bmNyZW1lbnRlZC4gV2Ugc2hvdWxkIHVzZSBvZl9ub2RlX3B1dCgpIHdoZW4KPj4gaXQgaXMgbm90
IHVzZWQgYW55bW9yZS4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IExpYW5nIEhlIDx3aW5kaGxAMTI2
LmNvbT4KPj4gLS0tCj4+IMKgYXJjaC9hcm0vbWFjaC1pbXgvc3JjLmMgfCAyICsrCj4+IMKgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+PiAKPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L21hY2gtaW14L3NyYy5jIGIvYXJjaC9hcm0vbWFjaC1pbXgvc3JjLmMKPj4gaW5kZXggNTlhOGU4
Y2M0NDY5Li5mZmYyNzc2ZjkxODAgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvYXJtL21hY2gtaW14L3Ny
Yy5jCj4+ICsrKyBiL2FyY2gvYXJtL21hY2gtaW14L3NyYy5jCj4+IEBAIC0xOTUsNiArMTk1LDcg
QEAgdm9pZCBfX2luaXQgaW14N19zcmNfaW5pdCh2b2lkKQo+PiDCoAkJcmV0dXJuOwo+PiDCoAo+
PiAKPj4gCj4+IAo+PiDCoAlzcmNfYmFzZSA9IG9mX2lvbWFwKG5wLCAwKTsKPj4gKwlvZl9ub2Rl
X3B1dChucCk7Cj4KPlRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLiBUaGVyZSBpcyBhbm90aGVyIGlu
c3RhbmNlIG9mIHRoaXMgcGF0dGVybiBhCj5mZXcgbGluZXMgYWJvdmUsIGluIGlteF9zcmNfaW5p
dCgpLgo+Cj5yZWdhcmRzCj5QaGlsaXBwCgpUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIHJlcGx5
LCBQaGlsaXBwLgoKIEluIGZhY3QsIEkgaGF2ZSBjb25maXJtZWQgaWYgdGhlcmUgaXMgYW55IGV4
aXN0ZWQgc2FtZSBwYXRjaCBpbiAKbG9yZS5rZXJuZWwub3JnIGJlZm9yZSBJIGJlZ2luIHRvIHNl
bmQgbXkgcGF0Y2guCgpTbyB0aGVyZSBpcyBpbmRlZWQgYSBwYXRjaCByZXBvcnRlZCBieSBNaWFv
cWlhbiBmb3IgaW14X3NyY19pbml0KCkuCkhvd2V2ZXIsIHRoYXQgcGF0Y2ggZG9lcyBub3QgY29u
c2lkZXIgdGhlIGJ1ZyBpbiBpbXg3X3NyY19pbml0KCkuCgpUaGFua3MgYWdhaW4uCgpMaWFuZwoK
Cg==
