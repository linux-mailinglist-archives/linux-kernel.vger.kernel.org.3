Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA72E5301BB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 09:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbiEVHwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 03:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiEVHwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 03:52:00 -0400
Received: from jari.cn (unknown [218.92.28.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48AEE167F8;
        Sun, 22 May 2022 00:51:54 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 22 May
 2022 15:46:18 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.156]
Date:   Sun, 22 May 2022 15:46:18 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6ZmI5a2m5YW1?= <chenxuebing@jari.cn>
To:     tsbogend@alpha.franken.de
Cc:     catalin.marinas@arm.com, rdunlap@infradead.org, rppt@kernel.org,
        rafael.j.wysocki@intel.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mips: setup: use strscpy to replace strlcpy
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <533ed227.9dd.180eabb3189.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwA3QW9K6oliBek2AA--.600W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAKCmFEYxsjpwAJsR
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ClRoZSBzdHJsY3B5IHNob3VsZCBub3QgYmUgdXNlZCBiZWNhdXNlIGl0IGRvZXNuJ3QgbGltaXQg
dGhlIHNvdXJjZQpsZW5ndGguIFByZWZlcnJlZCBpcyBzdHJzY3B5LgoKU2lnbmVkLW9mZi1ieTog
WHVlQmluZyBDaGVuIDxjaGVueHVlYmluZ0BqYXJpLmNuPgotLS0KIGFyY2gvbWlwcy9rZXJuZWwv
c2V0dXAuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9rZXJuZWwvc2V0dXAuYyBiL2FyY2gv
bWlwcy9rZXJuZWwvc2V0dXAuYwppbmRleCBlZjczYmExZTBlYzEuLmFkM2FlYTgxZDBlMiAxMDA2
NDQKLS0tIGEvYXJjaC9taXBzL2tlcm5lbC9zZXR1cC5jCisrKyBiL2FyY2gvbWlwcy9rZXJuZWwv
c2V0dXAuYwpAQCAtNTU0LDcgKzU1NCw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBib290Y21kbGlu
ZV9pbml0KHZvaWQpCiAJICogdW5tb2RpZmllZC4KIAkgKi8KIAlpZiAoSVNfRU5BQkxFRChDT05G
SUdfQ01ETElORV9PVkVSUklERSkpIHsKLQkJc3RybGNweShib290X2NvbW1hbmRfbGluZSwgYnVp
bHRpbl9jbWRsaW5lLCBDT01NQU5EX0xJTkVfU0laRSk7CisJCXN0cnNjcHkoYm9vdF9jb21tYW5k
X2xpbmUsIGJ1aWx0aW5fY21kbGluZSwgQ09NTUFORF9MSU5FX1NJWkUpOwogCQlyZXR1cm47CiAJ
fQogCkBAIC01NjYsNyArNTY2LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IGJvb3RjbWRsaW5lX2lu
aXQodm9pZCkKIAkgKiBib290X2NvbW1hbmRfbGluZSB0byB1bmRvIGFueXRoaW5nIGVhcmx5X2lu
aXRfZHRfc2Nhbl9jaG9zZW4oKSBkaWQuCiAJICovCiAJaWYgKElTX0VOQUJMRUQoQ09ORklHX01J
UFNfQ01ETElORV9CVUlMVElOX0VYVEVORCkpCi0JCXN0cmxjcHkoYm9vdF9jb21tYW5kX2xpbmUs
IGJ1aWx0aW5fY21kbGluZSwgQ09NTUFORF9MSU5FX1NJWkUpOworCQlzdHJzY3B5KGJvb3RfY29t
bWFuZF9saW5lLCBidWlsdGluX2NtZGxpbmUsIENPTU1BTkRfTElORV9TSVpFKTsKIAllbHNlCiAJ
CWJvb3RfY29tbWFuZF9saW5lWzBdID0gMDsKIApAQCAtNjI4LDcgKzYyOCw3IEBAIHN0YXRpYyB2
b2lkIF9faW5pdCBhcmNoX21lbV9pbml0KGNoYXIgKipjbWRsaW5lX3ApCiAJbWVtYmxvY2tfc2V0
X2JvdHRvbV91cCh0cnVlKTsKIAogCWJvb3RjbWRsaW5lX2luaXQoKTsKLQlzdHJsY3B5KGNvbW1h
bmRfbGluZSwgYm9vdF9jb21tYW5kX2xpbmUsIENPTU1BTkRfTElORV9TSVpFKTsKKwlzdHJzY3B5
KGNvbW1hbmRfbGluZSwgYm9vdF9jb21tYW5kX2xpbmUsIENPTU1BTkRfTElORV9TSVpFKTsKIAkq
Y21kbGluZV9wID0gY29tbWFuZF9saW5lOwogCiAJcGFyc2VfZWFybHlfcGFyYW0oKTsKLS0gCjIu
MzYuMQoKCg==
