Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73845338E6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiEYI5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiEYI5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:57:00 -0400
Received: from jari.cn (unknown [218.92.28.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D060F67
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:56:55 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Wed, 25 May
 2022 16:51:01 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.40]
Date:   Wed, 25 May 2022 16:51:01 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     hpa@zytor.com, rppt@kernel.org, akpm@linux-foundation.org,
        daniel.kiper@oracle.com, konrad@kernel.org,
        ross.philipson@oracle.com, jszhang@kernel.org,
        andriy.shevchenko@linux.intel.com, jgross@suse.com,
        mlombard@redhat.com, linux-kernel@vger.kernel.org
Subject:  [PATCH] x86/setup: use strscpy to replace strlcpy
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <730f0fef.a33.180fa69880f.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwAXIW_17Y1i5gQ4AA--.631W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAOCmFEYxsksAAMsA
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ClRoZSBzdHJsY3B5IHNob3VsZCBub3QgYmUgdXNlZCBiZWNhdXNlIGl0IGRvZXNuJ3QgbGltaXQg
dGhlIHNvdXJjZQpsZW5ndGguIFByZWZlcnJlZCBpcyBzdHJzY3B5LgoKU2lnbmVkLW9mZi1ieTog
WHVlQmluZyBDaGVuIDxjaGVueHVlYmluZ0BqYXJpLmNuPgotLS0KIGFyY2gveDg2L2tlcm5lbC9z
ZXR1cC5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3NldHVwLmMgYi9hcmNoL3g4
Ni9rZXJuZWwvc2V0dXAuYwppbmRleCBjOTViOWFjNWE0NTcuLmY5NWVhYmEyYzhhZCAxMDA2NDQK
LS0tIGEvYXJjaC94ODYva2VybmVsL3NldHVwLmMKKysrIGIvYXJjaC94ODYva2VybmVsL3NldHVw
LmMKQEAgLTg3OSwxOCArODc5LDE4IEBAIHZvaWQgX19pbml0IHNldHVwX2FyY2goY2hhciAqKmNt
ZGxpbmVfcCkKIAogI2lmZGVmIENPTkZJR19DTURMSU5FX0JPT0wKICNpZmRlZiBDT05GSUdfQ01E
TElORV9PVkVSUklERQotCXN0cmxjcHkoYm9vdF9jb21tYW5kX2xpbmUsIGJ1aWx0aW5fY21kbGlu
ZSwgQ09NTUFORF9MSU5FX1NJWkUpOworCXN0cnNjcHkoYm9vdF9jb21tYW5kX2xpbmUsIGJ1aWx0
aW5fY21kbGluZSwgQ09NTUFORF9MSU5FX1NJWkUpOwogI2Vsc2UKIAlpZiAoYnVpbHRpbl9jbWRs
aW5lWzBdKSB7CiAJCS8qIGFwcGVuZCBib290IGxvYWRlciBjbWRsaW5lIHRvIGJ1aWx0aW4gKi8K
IAkJc3RybGNhdChidWlsdGluX2NtZGxpbmUsICIgIiwgQ09NTUFORF9MSU5FX1NJWkUpOwogCQlz
dHJsY2F0KGJ1aWx0aW5fY21kbGluZSwgYm9vdF9jb21tYW5kX2xpbmUsIENPTU1BTkRfTElORV9T
SVpFKTsKLQkJc3RybGNweShib290X2NvbW1hbmRfbGluZSwgYnVpbHRpbl9jbWRsaW5lLCBDT01N
QU5EX0xJTkVfU0laRSk7CisJCXN0cnNjcHkoYm9vdF9jb21tYW5kX2xpbmUsIGJ1aWx0aW5fY21k
bGluZSwgQ09NTUFORF9MSU5FX1NJWkUpOwogCX0KICNlbmRpZgogI2VuZGlmCiAKLQlzdHJsY3B5
KGNvbW1hbmRfbGluZSwgYm9vdF9jb21tYW5kX2xpbmUsIENPTU1BTkRfTElORV9TSVpFKTsKKwlz
dHJzY3B5KGNvbW1hbmRfbGluZSwgYm9vdF9jb21tYW5kX2xpbmUsIENPTU1BTkRfTElORV9TSVpF
KTsKIAkqY21kbGluZV9wID0gY29tbWFuZF9saW5lOwogCiAJLyoKLS0gCjIuMzYuMQoKCg==
