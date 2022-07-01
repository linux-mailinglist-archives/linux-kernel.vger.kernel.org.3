Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB83E563260
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbiGALOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiGALOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:14:40 -0400
Received: from jari.cn (unknown [218.92.28.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BC1534650
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:14:38 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Fri, 1 Jul 2022
 19:09:15 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.66]
Date:   Fri, 1 Jul 2022 19:09:15 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ftrace: use strscpy to replace strlcpy
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <479ff932.d17.181b9735fdb.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3AG_b1b5irfdFAA--.864W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAICmFEYxsvOAAKsD
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
WHVlQmluZyBDaGVuIDxjaGVueHVlYmluZ0BqYXJpLmNuPgotLS0KIGtlcm5lbC90cmFjZS9mdHJh
Y2UuYyB8IDE4ICsrKysrKysrKy0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvdHJhY2UvZnRyYWNlLmMg
Yi9rZXJuZWwvdHJhY2UvZnRyYWNlLmMKaW5kZXggNjAxY2NmMWIyZjA5Li44ZDJhZDE0NzJmY2Ig
MTAwNjQ0Ci0tLSBhL2tlcm5lbC90cmFjZS9mdHJhY2UuYworKysgYi9rZXJuZWwvdHJhY2UvZnRy
YWNlLmMKQEAgLTU5MDIsNyArNTkwMiw3IEBAIGJvb2wgZnRyYWNlX2ZpbHRlcl9wYXJhbSBfX2lu
aXRkYXRhOwogc3RhdGljIGludCBfX2luaXQgc2V0X2Z0cmFjZV9ub3RyYWNlKGNoYXIgKnN0cikK
IHsKIAlmdHJhY2VfZmlsdGVyX3BhcmFtID0gdHJ1ZTsKLQlzdHJsY3B5KGZ0cmFjZV9ub3RyYWNl
X2J1Ziwgc3RyLCBGVFJBQ0VfRklMVEVSX1NJWkUpOworCXN0cnNjcHkoZnRyYWNlX25vdHJhY2Vf
YnVmLCBzdHIsIEZUUkFDRV9GSUxURVJfU0laRSk7CiAJcmV0dXJuIDE7CiB9CiBfX3NldHVwKCJm
dHJhY2Vfbm90cmFjZT0iLCBzZXRfZnRyYWNlX25vdHJhY2UpOwpAQCAtNTkxMCw3ICs1OTEwLDcg
QEAgX19zZXR1cCgiZnRyYWNlX25vdHJhY2U9Iiwgc2V0X2Z0cmFjZV9ub3RyYWNlKTsKIHN0YXRp
YyBpbnQgX19pbml0IHNldF9mdHJhY2VfZmlsdGVyKGNoYXIgKnN0cikKIHsKIAlmdHJhY2VfZmls
dGVyX3BhcmFtID0gdHJ1ZTsKLQlzdHJsY3B5KGZ0cmFjZV9maWx0ZXJfYnVmLCBzdHIsIEZUUkFD
RV9GSUxURVJfU0laRSk7CisJc3Ryc2NweShmdHJhY2VfZmlsdGVyX2J1Ziwgc3RyLCBGVFJBQ0Vf
RklMVEVSX1NJWkUpOwogCXJldHVybiAxOwogfQogX19zZXR1cCgiZnRyYWNlX2ZpbHRlcj0iLCBz
ZXRfZnRyYWNlX2ZpbHRlcik7CkBAIC01OTIyLDE0ICs1OTIyLDE0IEBAIHN0YXRpYyBpbnQgZnRy
YWNlX2dyYXBoX3NldF9oYXNoKHN0cnVjdCBmdHJhY2VfaGFzaCAqaGFzaCwgY2hhciAqYnVmZmVy
KTsKIAogc3RhdGljIGludCBfX2luaXQgc2V0X2dyYXBoX2Z1bmN0aW9uKGNoYXIgKnN0cikKIHsK
LQlzdHJsY3B5KGZ0cmFjZV9ncmFwaF9idWYsIHN0ciwgRlRSQUNFX0ZJTFRFUl9TSVpFKTsKKwlz
dHJzY3B5KGZ0cmFjZV9ncmFwaF9idWYsIHN0ciwgRlRSQUNFX0ZJTFRFUl9TSVpFKTsKIAlyZXR1
cm4gMTsKIH0KIF9fc2V0dXAoImZ0cmFjZV9ncmFwaF9maWx0ZXI9Iiwgc2V0X2dyYXBoX2Z1bmN0
aW9uKTsKIAogc3RhdGljIGludCBfX2luaXQgc2V0X2dyYXBoX25vdHJhY2VfZnVuY3Rpb24oY2hh
ciAqc3RyKQogewotCXN0cmxjcHkoZnRyYWNlX2dyYXBoX25vdHJhY2VfYnVmLCBzdHIsIEZUUkFD
RV9GSUxURVJfU0laRSk7CisJc3Ryc2NweShmdHJhY2VfZ3JhcGhfbm90cmFjZV9idWYsIHN0ciwg
RlRSQUNFX0ZJTFRFUl9TSVpFKTsKIAlyZXR1cm4gMTsKIH0KIF9fc2V0dXAoImZ0cmFjZV9ncmFw
aF9ub3RyYWNlPSIsIHNldF9ncmFwaF9ub3RyYWNlX2Z1bmN0aW9uKTsKQEAgLTY3MTQsOCArNjcx
NCw4IEBAIHN0YXRpYyBpbnQgZnRyYWNlX2dldF90cmFtcG9saW5lX2thbGxzeW0odW5zaWduZWQg
aW50IHN5bW51bSwKIAkJCWNvbnRpbnVlOwogCQkqdmFsdWUgPSBvcC0+dHJhbXBvbGluZTsKIAkJ
KnR5cGUgPSAndCc7Ci0JCXN0cmxjcHkobmFtZSwgRlRSQUNFX1RSQU1QT0xJTkVfU1lNLCBLU1lN
X05BTUVfTEVOKTsKLQkJc3RybGNweShtb2R1bGVfbmFtZSwgRlRSQUNFX1RSQU1QT0xJTkVfTU9E
LCBNT0RVTEVfTkFNRV9MRU4pOworCQlzdHJzY3B5KG5hbWUsIEZUUkFDRV9UUkFNUE9MSU5FX1NZ
TSwgS1NZTV9OQU1FX0xFTik7CisJCXN0cnNjcHkobW9kdWxlX25hbWUsIEZUUkFDRV9UUkFNUE9M
SU5FX01PRCwgTU9EVUxFX05BTUVfTEVOKTsKIAkJKmV4cG9ydGVkID0gMDsKIAkJcmV0dXJuIDA7
CiAJfQpAQCAtNzA0Niw3ICs3MDQ2LDcgQEAgZnRyYWNlX2Z1bmNfYWRkcmVzc19sb29rdXAoc3Ry
dWN0IGZ0cmFjZV9tb2RfbWFwICptb2RfbWFwLAogCQlpZiAob2ZmKQogCQkJKm9mZiA9IGFkZHIg
LSBmb3VuZF9mdW5jLT5pcDsKIAkJaWYgKHN5bSkKLQkJCXN0cmxjcHkoc3ltLCBmb3VuZF9mdW5j
LT5uYW1lLCBLU1lNX05BTUVfTEVOKTsKKwkJCXN0cnNjcHkoc3ltLCBmb3VuZF9mdW5jLT5uYW1l
LCBLU1lNX05BTUVfTEVOKTsKIAogCQlyZXR1cm4gZm91bmRfZnVuYy0+bmFtZTsKIAl9CkBAIC03
MTAwLDggKzcxMDAsOCBAQCBpbnQgZnRyYWNlX21vZF9nZXRfa2FsbHN5bSh1bnNpZ25lZCBpbnQg
c3ltbnVtLCB1bnNpZ25lZCBsb25nICp2YWx1ZSwKIAogCQkJKnZhbHVlID0gbW9kX2Z1bmMtPmlw
OwogCQkJKnR5cGUgPSAnVCc7Ci0JCQlzdHJsY3B5KG5hbWUsIG1vZF9mdW5jLT5uYW1lLCBLU1lN
X05BTUVfTEVOKTsKLQkJCXN0cmxjcHkobW9kdWxlX25hbWUsIG1vZF9tYXAtPm1vZC0+bmFtZSwg
TU9EVUxFX05BTUVfTEVOKTsKKwkJCXN0cnNjcHkobmFtZSwgbW9kX2Z1bmMtPm5hbWUsIEtTWU1f
TkFNRV9MRU4pOworCQkJc3Ryc2NweShtb2R1bGVfbmFtZSwgbW9kX21hcC0+bW9kLT5uYW1lLCBN
T0RVTEVfTkFNRV9MRU4pOwogCQkJKmV4cG9ydGVkID0gMTsKIAkJCXByZWVtcHRfZW5hYmxlKCk7
CiAJCQlyZXR1cm4gMDsKLS0gCjIuMjUuMQoKCg==
