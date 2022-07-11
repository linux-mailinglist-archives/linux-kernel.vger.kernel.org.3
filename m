Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5AD57059D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiGKObr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGKObo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:31:44 -0400
Received: from jari.cn (unknown [218.92.28.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9F6A61D96
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:31:42 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Mon, 11 Jul
 2022 22:26:12 +0800 (GMT+08:00)
X-Originating-IP: [182.148.15.109]
Date:   Mon, 11 Jul 2022 22:26:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject:  [PATCH] tracing: use strscpy to replace strlcpy
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <49ec0969.e32.181eda74871.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwA3QnAEM8xi4uRIAA--.910W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAECmFEYxs0ZwADsC
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
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
WHVlQmluZyBDaGVuIDxjaGVueHVlYmluZ0BqYXJpLmNuPgotLS0KIGtlcm5lbC90cmFjZS90cmFj
ZV9ib290LmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC90cmFjZS90cmFjZV9ib290LmMgYi9r
ZXJuZWwvdHJhY2UvdHJhY2VfYm9vdC5jCmluZGV4IDc3ODIwMGRkOGVkZS4uMmJmNzY1NTBiYjRl
IDEwMDY0NAotLS0gYS9rZXJuZWwvdHJhY2UvdHJhY2VfYm9vdC5jCisrKyBiL2tlcm5lbC90cmFj
ZS90cmFjZV9ib290LmMKQEAgLTMxLDcgKzMxLDcgQEAgdHJhY2VfYm9vdF9zZXRfaW5zdGFuY2Vf
b3B0aW9ucyhzdHJ1Y3QgdHJhY2VfYXJyYXkgKnRyLCBzdHJ1Y3QgeGJjX25vZGUgKm5vZGUpCiAK
IAkvKiBDb21tb24gZnRyYWNlIG9wdGlvbnMgKi8KIAl4YmNfbm9kZV9mb3JfZWFjaF9hcnJheV92
YWx1ZShub2RlLCAib3B0aW9ucyIsIGFub2RlLCBwKSB7Ci0JCWlmIChzdHJsY3B5KGJ1ZiwgcCwg
QVJSQVlfU0laRShidWYpKSA+PSBBUlJBWV9TSVpFKGJ1ZikpIHsKKwkJaWYgKHN0cnNjcHkoYnVm
LCBwLCBBUlJBWV9TSVpFKGJ1ZikpID49IEFSUkFZX1NJWkUoYnVmKSkgewogCQkJcHJfZXJyKCJT
dHJpbmcgaXMgdG9vIGxvbmc6ICVzXG4iLCBwKTsKIAkJCWNvbnRpbnVlOwogCQl9CkBAIC04Nyw3
ICs4Nyw3IEBAIHRyYWNlX2Jvb3RfZW5hYmxlX2V2ZW50cyhzdHJ1Y3QgdHJhY2VfYXJyYXkgKnRy
LCBzdHJ1Y3QgeGJjX25vZGUgKm5vZGUpCiAJY29uc3QgY2hhciAqcDsKIAogCXhiY19ub2RlX2Zv
cl9lYWNoX2FycmF5X3ZhbHVlKG5vZGUsICJldmVudHMiLCBhbm9kZSwgcCkgewotCQlpZiAoc3Ry
bGNweShidWYsIHAsIEFSUkFZX1NJWkUoYnVmKSkgPj0gQVJSQVlfU0laRShidWYpKSB7CisJCWlm
IChzdHJzY3B5KGJ1ZiwgcCwgQVJSQVlfU0laRShidWYpKSA+PSBBUlJBWV9TSVpFKGJ1ZikpIHsK
IAkJCXByX2VycigiU3RyaW5nIGlzIHRvbyBsb25nOiAlc1xuIiwgcCk7CiAJCQljb250aW51ZTsK
IAkJfQpAQCAtNDg2LDcgKzQ4Niw3IEBAIHRyYWNlX2Jvb3RfaW5pdF9vbmVfZXZlbnQoc3RydWN0
IHRyYWNlX2FycmF5ICp0ciwgc3RydWN0IHhiY19ub2RlICpnbm9kZSwKIAogCXAgPSB4YmNfbm9k
ZV9maW5kX3ZhbHVlKGVub2RlLCAiZmlsdGVyIiwgTlVMTCk7CiAJaWYgKHAgJiYgKnAgIT0gJ1ww
JykgewotCQlpZiAoc3RybGNweShidWYsIHAsIEFSUkFZX1NJWkUoYnVmKSkgPj0gQVJSQVlfU0la
RShidWYpKQorCQlpZiAoc3Ryc2NweShidWYsIHAsIEFSUkFZX1NJWkUoYnVmKSkgPj0gQVJSQVlf
U0laRShidWYpKQogCQkJcHJfZXJyKCJmaWx0ZXIgc3RyaW5nIGlzIHRvbyBsb25nOiAlc1xuIiwg
cCk7CiAJCWVsc2UgaWYgKGFwcGx5X2V2ZW50X2ZpbHRlcihmaWxlLCBidWYpIDwgMCkKIAkJCXBy
X2VycigiRmFpbGVkIHRvIGFwcGx5IGZpbHRlcjogJXNcbiIsIGJ1Zik7CkBAIC00OTQsNyArNDk0
LDcgQEAgdHJhY2VfYm9vdF9pbml0X29uZV9ldmVudChzdHJ1Y3QgdHJhY2VfYXJyYXkgKnRyLCBz
dHJ1Y3QgeGJjX25vZGUgKmdub2RlLAogCiAJaWYgKElTX0VOQUJMRUQoQ09ORklHX0hJU1RfVFJJ
R0dFUlMpKSB7CiAJCXhiY19ub2RlX2Zvcl9lYWNoX2FycmF5X3ZhbHVlKGVub2RlLCAiYWN0aW9u
cyIsIGFub2RlLCBwKSB7Ci0JCQlpZiAoc3RybGNweShidWYsIHAsIEFSUkFZX1NJWkUoYnVmKSkg
Pj0gQVJSQVlfU0laRShidWYpKQorCQkJaWYgKHN0cnNjcHkoYnVmLCBwLCBBUlJBWV9TSVpFKGJ1
ZikpID49IEFSUkFZX1NJWkUoYnVmKSkKIAkJCQlwcl9lcnIoImFjdGlvbiBzdHJpbmcgaXMgdG9v
IGxvbmc6ICVzXG4iLCBwKTsKIAkJCWVsc2UgaWYgKHRyaWdnZXJfcHJvY2Vzc19yZWdleChmaWxl
LCBidWYpIDwgMCkKIAkJCQlwcl9lcnIoIkZhaWxlZCB0byBhcHBseSBhbiBhY3Rpb246ICVzXG4i
LCBwKTsKLS0gCjIuMjUuMQo=
