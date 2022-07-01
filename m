Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CE256329A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiGALbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiGALbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:31:38 -0400
Received: from jari.cn (unknown [218.92.28.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C49B8814BF;
        Fri,  1 Jul 2022 04:31:37 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Fri, 1 Jul 2022
 19:26:07 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.66]
Date:   Fri, 1 Jul 2022 19:26:07 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     sumit.semwal@linaro.org, christian.koenig@amd.com
Cc:     gustavo@padovan.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject:  [PATCH] dma-buf/sync_file: use strscpy to replace strlcpy
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6aad3bff.d1a.181b982d1b1.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3AG_P2b5i5PdFAA--.865W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAICmFEYxsvOAAQsZ
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
WHVlQmluZyBDaGVuIDxjaGVueHVlYmluZ0BqYXJpLmNuPgotLS0KIGRyaXZlcnMvZG1hLWJ1Zi9z
eW5jX2ZpbGUuYyB8IDggKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEtYnVmL3N5bmNfZmlsZS5j
IGIvZHJpdmVycy9kbWEtYnVmL3N5bmNfZmlsZS5jCmluZGV4IDNlYmVjMTlhOGUwMi4uYWY1Nzc5
OWM4NmNlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2RtYS1idWYvc3luY19maWxlLmMKKysrIGIvZHJp
dmVycy9kbWEtYnVmL3N5bmNfZmlsZS5jCkBAIC0xMzIsNyArMTMyLDcgQEAgRVhQT1JUX1NZTUJP
TChzeW5jX2ZpbGVfZ2V0X2ZlbmNlKTsKIGNoYXIgKnN5bmNfZmlsZV9nZXRfbmFtZShzdHJ1Y3Qg
c3luY19maWxlICpzeW5jX2ZpbGUsIGNoYXIgKmJ1ZiwgaW50IGxlbikKIHsKIAlpZiAoc3luY19m
aWxlLT51c2VyX25hbWVbMF0pIHsKLQkJc3RybGNweShidWYsIHN5bmNfZmlsZS0+dXNlcl9uYW1l
LCBsZW4pOworCQlzdHJzY3B5KGJ1Ziwgc3luY19maWxlLT51c2VyX25hbWUsIGxlbik7CiAJfSBl
bHNlIHsKIAkJc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UgPSBzeW5jX2ZpbGUtPmZlbmNlOwogCkBA
IC0xNzIsNyArMTcyLDcgQEAgc3RhdGljIHN0cnVjdCBzeW5jX2ZpbGUgKnN5bmNfZmlsZV9tZXJn
ZShjb25zdCBjaGFyICpuYW1lLCBzdHJ1Y3Qgc3luY19maWxlICphLAogCQlyZXR1cm4gTlVMTDsK
IAl9CiAJc3luY19maWxlLT5mZW5jZSA9IGZlbmNlOwotCXN0cmxjcHkoc3luY19maWxlLT51c2Vy
X25hbWUsIG5hbWUsIHNpemVvZihzeW5jX2ZpbGUtPnVzZXJfbmFtZSkpOworCXN0cnNjcHkoc3lu
Y19maWxlLT51c2VyX25hbWUsIG5hbWUsIHNpemVvZihzeW5jX2ZpbGUtPnVzZXJfbmFtZSkpOwog
CXJldHVybiBzeW5jX2ZpbGU7CiB9CiAKQEAgLTI2Miw5ICsyNjIsOSBAQCBzdGF0aWMgbG9uZyBz
eW5jX2ZpbGVfaW9jdGxfbWVyZ2Uoc3RydWN0IHN5bmNfZmlsZSAqc3luY19maWxlLAogc3RhdGlj
IGludCBzeW5jX2ZpbGxfZmVuY2VfaW5mbyhzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSwKIAkJCQkg
c3RydWN0IHN5bmNfZmVuY2VfaW5mbyAqaW5mbykKIHsKLQlzdHJsY3B5KGluZm8tPm9ial9uYW1l
LCBmZW5jZS0+b3BzLT5nZXRfdGltZWxpbmVfbmFtZShmZW5jZSksCisJc3Ryc2NweShpbmZvLT5v
YmpfbmFtZSwgZmVuY2UtPm9wcy0+Z2V0X3RpbWVsaW5lX25hbWUoZmVuY2UpLAogCQlzaXplb2Yo
aW5mby0+b2JqX25hbWUpKTsKLQlzdHJsY3B5KGluZm8tPmRyaXZlcl9uYW1lLCBmZW5jZS0+b3Bz
LT5nZXRfZHJpdmVyX25hbWUoZmVuY2UpLAorCXN0cnNjcHkoaW5mby0+ZHJpdmVyX25hbWUsIGZl
bmNlLT5vcHMtPmdldF9kcml2ZXJfbmFtZShmZW5jZSksCiAJCXNpemVvZihpbmZvLT5kcml2ZXJf
bmFtZSkpOwogCiAJaW5mby0+c3RhdHVzID0gZG1hX2ZlbmNlX2dldF9zdGF0dXMoZmVuY2UpOwot
LSAKMi4yNS4xCg==
