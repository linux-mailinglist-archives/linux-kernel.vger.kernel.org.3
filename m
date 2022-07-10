Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4597E56CF9A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiGJPEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGJPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:03:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4B164DB;
        Sun, 10 Jul 2022 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657465411;
        bh=0pVEiaSU9V9cl2GANnDMVx6RJaK7jU5KH3ahskRO4Gg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Zg56N7v3dhgcT2JpchdQkdecj9PKXc9rVXqdeHJds1yeeAS+qP3YbY2KJHs6lzBdL
         Gfi6qM2KJCC7657SAEqTEihuWVjXxaLIZ5RoLdS+YkaSfxaIwSZjj7s+0SgP/K7rO2
         y/FCXHTI8+EXglTRSC8Dpvys0/f5EZjIFHkdtmso=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.243]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MbzyP-1nZq8r4Apj-00dVRC; Sun, 10 Jul 2022 17:03:31 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v3 4/8] serial: core: move sanitizing of RS485 delays into own function
Date:   Sun, 10 Jul 2022 17:03:18 +0200
Message-Id: <20220710150322.2846170-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710150322.2846170-1-LinoSanfilippo@gmx.de>
References: <20220710150322.2846170-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:1s9YVDSEdiONONi+fKcJr5fa2mYHrQpCwIex2wcxL5QhRWNh9Dj
 v6BNo3hqd4hRMMWwckcjWVyu4iWGISgsYuhFjAug3MImXW81A8zdMgaNReO+7OY4XK1RY6D
 6Y7jQyc2XnLYT7FOostwqpX92OFT227XOylsUi9bxbZ6Kn1yIh9slqv3OVf+yuE7GMdzg9i
 MK+5sOCGffhmQqSvWcpmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+0u/mHrmuAo=:LwO3azg2BUo2EFtcw4L69N
 OvRGnUSXza4kT9XoPiQfCGpXQApGKPmCyNI7d1vN8Dvb6U29wgFJenNrK+JkwXJil3jSA3nU6
 iaon84x9/RYh+DyLv1SbecD5BtIoHSzP2OinW3QqbSciBpbIU/hB80TeU8lhPzAQFGubw8d0d
 ouV3CMXiD2J4SAi2QWs2B+vvmMTMRTNimHQDbNuOcdvW6g0k0y9lTA4JzuKIf/bFJh6xhiCPo
 likMLQO5nvVLkFTJhVdaiSxv5H+mAGd7zHesPVqghNVomHAx4TqHvILPpQqG9EBjQj7YKqjXF
 bLZNY6qePBJSR8Md/nhUcbUWxokiKoi+0UwVcxwOxkfdFAUQr60hxNj0rLPC9A6fPzEoqiNvW
 Mo3aZMBK4OK7X258NUF5Ezc47i34QXqcDDVKbOj/XPs2iNdP9uGBezZNZvf30A2AxHwkSpDLa
 4jPFh1i36Aj/znr38oRhgzIxDW6wxa4oJgrS0aAYrTKP/eDR1A4L2qPzO+Pvw6aCvgvbU/Nde
 epBXZ0YF9ZmFzNOZZsVyTmqaRuxzHgVyXopL88MFFqdxHmPP5csP4DnfpnbSTU2ZXh4lHErs9
 opfKOejVkuF5T7rV4TdN32zqbAIlBUl1OZpImkAOc2n5Hgw2AgzvMQbHhDmHmSO5qxHDdp9Nx
 L+UW0iRR+0+09zgA/eQhKK2U1UK1CYAWlic1Q8JtF/CrI+FcZfyTjaWqs1qvqdB7icvOgj6rB
 Lp9CWasqEykZchIJOFi0M3y1CLP7PCdYovhCVYHWnQ/GvTJNoRqkbv27gfCgCvLBWHqutnSio
 JlHTyCgM0vT7PQ0K0ZRCf/x5cn0sfN9N6PWFDoYk5g7ScKpxKrruKiUURT5bi/rzaaOkzE2zB
 jk44TtY78+uDL37WV4w0ZI4/PvERV53ZtQ5HZ2haBkNIPt/SaAmUo66/pU+q5aVmWwbHz3qcj
 fxejD3w6A4F/3maTuRKbZ14hLvE/F74WEwO9FF3YUH2bKiOpqe2vq36GegBdY8WtRX7zwVOd5
 8gE2Bo1+GzvDyzVBbvHw8Fgkqmj1BmG3/kLbdBkdKEEMRXmPEBFOw4Tz6+Oq8m4fyp+2jGFgY
 9awCYiftoZNuj2Lt6PzhYCtP+Dm+s1FvTZZzRECbBJazDgRgJOdQ7rPzg==
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
NjEyYTk3Nzg4MzQxLi41OTQzY2IzNTU1NmYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Nlcmlh
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
