Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DC856D02C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiGJQqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiGJQpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:45:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CF413E89;
        Sun, 10 Jul 2022 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657471497;
        bh=+8xtH88YOOLsZPGBk+8MayK28Z9P5RAmhj5fFk999no=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jfm793oRyRcXyfwlGzzOSIU31lMCstduoZgtZd0UDoy0z+B5C3QRzOLGIlORDil6b
         qvxegme7Ka1Hv3wlD93nO6+bUBtCavSHMobIl9rHPyFhkliQWVwxDw1gR/6MqZJZf8
         uH1e/HXkrx20TgZODby3FbHz4LW+Oom5bjieN/ag=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mz9Z5-1nNa8Z3urr-00wFbb; Sun, 10 Jul 2022 18:44:57 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v4 4/8] serial: core: move sanitizing of RS485 delays into own function
Date:   Sun, 10 Jul 2022 18:44:38 +0200
Message-Id: <20220710164442.2958979-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
References: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:/B4QTguHrmwHQ+n+io6jRV1yTm9GIglViqwMlUnseveP4s/0FGJ
 YhcgE0zBR36vqgdwY71AnhhcetsI6YPnFolco3+Dj9YsbfJ06w/3ihOZPLvvrAyK90ilfAg
 OHkxi+xJqlgXlApudIfuir6Ja+uv1y1YvLCWFUMkaKPi0CE+37rYz4c7UQwMlnP3kAMTHgp
 9l0lzRsfN0qa1Pqkmx6gw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AMXfJa/0vG0=:VlvViT77U1oKOJG19IuxGQ
 AGz6OUxHm27Lcg2N7oS9RUGSgs1kX9+p6+gsuEQxXDCkw/QTvqUplQRdNPHBZSt5mP5e+WwsZ
 x+NsaH25xoXM1WsRIYZdNUJLxfqWxEoS59lSaqXtRK/3bBF8gdjKG4KWvfotsABrM5iSE0C1q
 MkmbtLQUMVnaBuOa9Hoglv9N/xfzLI37Cfg5hIxdG+MbO9blic1qAXog0cWBCRPK/W+x66duB
 2jT/+Odd8Ft5twBvffNQSQGQmSyl4S5DsrSDdZ9BXqdMSPC/8CBkyaYLcHksXcEMZmBdRhDi+
 gLEiP4f69GalR5U5xt61fsYq/HUm/c4D+DvvlxSvhXeLpXSs7wHQq5DnFConnW/uwnd12PQxQ
 CD3bKEsf9/7LwysRiy9zL2dYrjj/VkPWdxfhBbB/SO6LRxAj8mv39l+mdAb927kpAyxd2p+/V
 MNPo95t2yt8kwP/iYX6/SvFlInubnZUS59DmWVXFDvKoC4zFtTO4c1XJLor7cbPZe4BPRBLR5
 L1h/X0BML9eeH4Q+OsegGEQdYXXdtebCUpYrLAZZ+GuxhOh3atUYHlRjgjf1gATfN+6U9dfP+
 mhFo0l1S2cKpzS5zqr0Psgwf4wsDand6JEB6cr6eXIMEzly3VQmAL2QQbdCfNJOgRAmbdMm4i
 VfyhUnzY6I8PWxP9GkAeMscM0PDzwidgTwaFaT986uh2+7QMIUUeUlIwBjTb6Y3BaTOm4kRBG
 wxLsQGjxv609NKiYlB+em/agJ3s4J6rF0eAAeL4ERC5YGItU110r0lUOCOZwDShvL/CZ+2aau
 DvD3Ln93fvmxv6OEoIizJNlefXJNDQKQ9rbwo/fbygUkoNMtcfgfoB0Lj0NbK6hsIRIkbKlpc
 6Eldz5GWPruXZU2J+aMhFvqN7q0/cD7eqzzXffUNIsGRZDEw+ISlxPzzR5Oa6PuOFbR/wB6CX
 hgwiYyABhy3VHow6zpXdW4YmGB+zv7Rm+UY6vM+oeYwm3AVHePtD7JQrdSQLFgdm81gsMvtc3
 R/w5KKj39M0ugXlmLQSxat7A+GJ1LuvQI3Fgl1F9gl8pIubr8smD8P+UazWx4b8aDb6e6Su9u
 7WJQCHZ7ukMVMMRMLpRKvwBzayiaRuBNhQQkjMzPkNMYppidAAGf7+ebg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCk1vdmUgdGhl
IHNhbml0aXppbmcgb2YgUlM0ODUgZGVsYXlzIG91dCBvZiB1YXJ0X3Nhbml0aXplX3NlcmlhbF9y
czQ4NSgpCmludG8gdGhlIG5ldyBmdW5jdGlvbiB1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NV9k
ZWxheXMoKS4KClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1
bmJ1cy5jb20+ClJldmlld2VkLWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51
eC5pbnRlbC5jb20+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgfCA0NiAr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2Vy
dGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9zZXJpYWxfY29yZS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKaW5kZXgg
MDQ3ZWM1MWRiZDQxLi4zMTU4ZjA1YTMyOGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9zZXJpYWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCkBA
IC0xMzAyLDI3ICsxMzAyLDkgQEAgc3RhdGljIGludCB1YXJ0X2NoZWNrX3JzNDg1X2ZsYWdzKHN0
cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBzZXJpYWxfcnM0ODUgKnIKIAlyZXR1cm4gMDsK
IH0KIAotc3RhdGljIHZvaWQgdWFydF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODUoc3RydWN0IHVhcnRf
cG9ydCAqcG9ydCwgc3RydWN0IHNlcmlhbF9yczQ4NSAqcnM0ODUpCitzdGF0aWMgdm9pZCB1YXJ0
X3Nhbml0aXplX3NlcmlhbF9yczQ4NV9kZWxheXMoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwKKwkJ
CQkJICAgICAgc3RydWN0IHNlcmlhbF9yczQ4NSAqcnM0ODUpCiB7Ci0JdTMyIHN1cHBvcnRlZF9m
bGFncyA9IHBvcnQtPnJzNDg1X3N1cHBvcnRlZC5mbGFnczsKLQotCWlmICghKHJzNDg1LT5mbGFn
cyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSkgewotCQltZW1zZXQocnM0ODUsIDAsIHNpemVvZigqcnM0
ODUpKTsKLQkJcmV0dXJuOwotCX0KLQotCS8qIHBpY2sgc2FuZSBzZXR0aW5ncyBpZiB0aGUgdXNl
ciBoYXNuJ3QgKi8KLQlpZiAoKHN1cHBvcnRlZF9mbGFncyAmIChTRVJfUlM0ODVfUlRTX09OX1NF
TkR8U0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EKSkgJiYKLQkgICAgIShyczQ4NS0+ZmxhZ3MgJiBT
RVJfUlM0ODVfUlRTX09OX1NFTkQpID09Ci0JICAgICEocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1
X1JUU19BRlRFUl9TRU5EKSkgewotCQlkZXZfd2Fybl9yYXRlbGltaXRlZChwb3J0LT5kZXYsCi0J
CQkiJXMgKCVkKTogaW52YWxpZCBSVFMgc2V0dGluZywgdXNpbmcgUlRTX09OX1NFTkQgaW5zdGVh
ZFxuIiwKLQkJCXBvcnQtPm5hbWUsIHBvcnQtPmxpbmUpOwotCQlyczQ4NS0+ZmxhZ3MgfD0gU0VS
X1JTNDg1X1JUU19PTl9TRU5EOwotCQlyczQ4NS0+ZmxhZ3MgJj0gflNFUl9SUzQ4NV9SVFNfQUZU
RVJfU0VORDsKLQkJc3VwcG9ydGVkX2ZsYWdzIHw9IFNFUl9SUzQ4NV9SVFNfT05fU0VORHxTRVJf
UlM0ODVfUlRTX0FGVEVSX1NFTkQ7Ci0JfQotCiAJaWYgKCFwb3J0LT5yczQ4NV9zdXBwb3J0ZWQu
ZGVsYXlfcnRzX2JlZm9yZV9zZW5kKSB7CiAJCWlmIChyczQ4NS0+ZGVsYXlfcnRzX2JlZm9yZV9z
ZW5kKSB7CiAJCQlkZXZfd2Fybl9yYXRlbGltaXRlZChwb3J0LT5kZXYsCkBAIC0xMzUwLDkgKzEz
MzIsMzMgQEAgc3RhdGljIHZvaWQgdWFydF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODUoc3RydWN0IHVh
cnRfcG9ydCAqcG9ydCwgc3RydWN0IHNlcmlhbF9yczQKIAkJCSIlcyAoJWQpOiBSVFMgZGVsYXkg
YWZ0ZXIgc2VuZGluZyBjbGFtcGVkIHRvICV1IG1zXG4iLAogCQkJcG9ydC0+bmFtZSwgcG9ydC0+
bGluZSwgcnM0ODUtPmRlbGF5X3J0c19hZnRlcl9zZW5kKTsKIAl9Cit9CisKK3N0YXRpYyB2b2lk
IHVhcnRfc2FuaXRpemVfc2VyaWFsX3JzNDg1KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVj
dCBzZXJpYWxfcnM0ODUgKnJzNDg1KQoreworCXUzMiBzdXBwb3J0ZWRfZmxhZ3MgPSBwb3J0LT5y
czQ4NV9zdXBwb3J0ZWQuZmxhZ3M7CisKKwlpZiAoIShyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVf
RU5BQkxFRCkpIHsKKwkJbWVtc2V0KHJzNDg1LCAwLCBzaXplb2YoKnJzNDg1KSk7CisJCXJldHVy
bjsKKwl9CisKKwkvKiBQaWNrIHNhbmUgc2V0dGluZ3MgaWYgdGhlIHVzZXIgaGFzbid0ICovCisJ
aWYgKChzdXBwb3J0ZWRfZmxhZ3MgJiAoU0VSX1JTNDg1X1JUU19PTl9TRU5EfFNFUl9SUzQ4NV9S
VFNfQUZURVJfU0VORCkpICYmCisJICAgICEocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X1JUU19P
Tl9TRU5EKSA9PQorCSAgICAhKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9SVFNfQUZURVJfU0VO
RCkpIHsKKwkJZGV2X3dhcm5fcmF0ZWxpbWl0ZWQocG9ydC0+ZGV2LAorCQkJIiVzICglZCk6IGlu
dmFsaWQgUlRTIHNldHRpbmcsIHVzaW5nIFJUU19PTl9TRU5EIGluc3RlYWRcbiIsCisJCQlwb3J0
LT5uYW1lLCBwb3J0LT5saW5lKTsKKwkJcnM0ODUtPmZsYWdzIHw9IFNFUl9SUzQ4NV9SVFNfT05f
U0VORDsKKwkJcnM0ODUtPmZsYWdzICY9IH5TRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7CisJCXN1
cHBvcnRlZF9mbGFncyB8PSBTRVJfUlM0ODVfUlRTX09OX1NFTkR8U0VSX1JTNDg1X1JUU19BRlRF
Ul9TRU5EOworCX0KIAogCXJzNDg1LT5mbGFncyAmPSBzdXBwb3J0ZWRfZmxhZ3M7CiAKKwl1YXJ0
X3Nhbml0aXplX3NlcmlhbF9yczQ4NV9kZWxheXMocG9ydCwgcnM0ODUpOworCiAJLyogUmV0dXJu
IGNsZWFuIHBhZGRpbmcgYXJlYSB0byB1c2Vyc3BhY2UgKi8KIAltZW1zZXQocnM0ODUtPnBhZGRp
bmcwLCAwLCBzaXplb2YocnM0ODUtPnBhZGRpbmcwKSk7CiAJbWVtc2V0KHJzNDg1LT5wYWRkaW5n
MSwgMCwgc2l6ZW9mKHJzNDg1LT5wYWRkaW5nMSkpOwotLSAKMi4yNS4xCgo=
