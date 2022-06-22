Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ADA554FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359600AbiFVPsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359515AbiFVPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:47:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAF13DDFA;
        Wed, 22 Jun 2022 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655912840;
        bh=Rq3KFvxDtHALFh/DnfsS+evHIUI8vMe3n1/DQWqfHUk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XZgcm2aBHskXKxiq1sdoU/43+QwTkbYSXsznvKnZHkWP4CKG+g7l3NCchoiBEIASO
         B8/Vby+1wlyuEGZz+T0B7DidPFM+D4hvQg39WtlLzGMjgcqMhcv+coNCt8+hT7tYXT
         e2fKbQAEGRU5lD+ltxxhFJqOb2QaYQCPFtxuIE5w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.22]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUZ4-1nL1am2Tt6-00pvse; Wed, 22
 Jun 2022 17:47:20 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH 3/8] serial: core: move sanitizing of RS485 delays into own function
Date:   Wed, 22 Jun 2022 17:46:54 +0200
Message-Id: <20220622154659.8710-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:dCXH7+GWeAl4LLMvcxAw/fQZwalG9+Q0N9n2K5X3mltot8aufOr
 a8QPrBg2BcpkehxEVEfYsj+RupRw8ld0OVbpgqKeJ81SaOV9GahIzZhkoM2P0rT3F4OTHVe
 n0uYYWPpwxrZ0dPM5Pr/CLtk+ipDxGZuiYItznVAa/DyR5DDAk5rrpIZahEkRnMQiDRQe43
 dKYpZ18+7ncDJKL8HCLMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XHc42tvAbiY=:b4cx0cCtuwlmp9ujNfsxpR
 y5IqNGaQd0LQFZC+yXxyh236zCMLFJAWsAAB+GTim5bhcEkjZ9gKPTW3Z2XtRlDEYvPRhFmUo
 l75WPgilFh+ARmzDgTIFaf7oi7YoPPmkeoPjXg+3HffqR1zIRKLqu94dwqKdqD8I0wAGCNn9m
 LcDdvnD40zPyE4vTjB5oKncTQkWwJInRCFyi5yi5+ZZNbBiPasmjFscX4mlYnR60lelleHkXG
 Z4lDx4LVYt2uCpYNme/4BuSFcnru083kqjlibTPIYuuLzsu/ahvNwSGRjRmUtBLv+7qrax1cR
 BbJ4DEghTi8sAU2Uo6Jr9hxz0wBS7qPOgOrUS6Fx13kr2EKe8Zet7zdYT9BM2eQiVy+qmMPsA
 PwOUteVdaEBKbLugXgHvWG3uI8LesI/2Vfj95jMFYnImRAeCtntmp41b+uGN2uNUDQNQZ9t/Q
 //fy/5UWrrN+1xVMOPTHhlri30clMjAywBvD9gAZkXHwlJOrVnp74n2oX28MCdiH7+cr4tXrG
 DxPZE7uZsAC/CMUtjsE2UXRlBxftwTtNkA2lH55IiwxiArIbNpCpRkmFYPpm6plCZgpZtQyBB
 ctH8Df8PVONbqSy+eFWxHVRsSpDS6tEfym/t+7zeuMF+p73vEN15HkDPKYy6SMLf4+5gZKBbP
 LZ5dfvzk89iEjIyGSFrmxSWutoryJDD0zPWcrQMwTsY9rQIoyEp7uJ2nErI4KSwUarBa5oMjv
 DwlWdU+qv5hHLdAI/tjRxq+Ugn7MkdiOiHIVo30HaPB/mfBeY5g4CWfm6wiLcen4aln0gGldq
 3c7Xg2fvWhPv4OSW+EUNHeEmDDSpjyBOiH6/J6CBxGbJikVRifSMKaQCBFOvlKMjEy5CUiSlz
 6zbKydB1rQ/2NiWJSkR8tyQO15jhvuSKgje8Wxd2+DQzFpkCo9YOcvLNJ66QVlzxQqFfGHkxC
 XHVxcJ2MWX631NOaGQk1PXbnuc9zv89L1FgFl6T2c2iahVicWl7Ep916xuHV/6WjskNvb+GG0
 Y+58/8YDEY9jPkSWX5rYiGo6anGAb7fnSHbL05m3OCP5YgmajBDo2nYnc098DMtvnUd7qykqZ
 TSJWhF3uQgRTZqa/BJVBTHXcpsYcEv7CH/aXxXGNR46g9o/q1lYYJ+nlw==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCk1vdmUgdGhl
IHNhbml0aXppbmcgb2YgUlM0ODUgZGVsYXlzIG91dCBvZiB1YXJ0X3Nhbml0aXplX3NlcmlhbF9y
czQ4NSgpCmludG8gdGhlIG5ldyBmdW5jdGlvbiB1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NV9k
ZWxheXMoKS4KClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1
bmJ1cy5jb20+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgfCA0NiArKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlv
bnMoKyksIDIwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9z
ZXJpYWxfY29yZS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKaW5kZXggYjM4
NzM3NmU2ZmEyLi5mYTZhY2FkZDdkMGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9z
ZXJpYWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCkBAIC0x
Mjk3LDI3ICsxMjk3LDkgQEAgc3RhdGljIGludCB1YXJ0X2NoZWNrX3JzNDg1X2ZsYWdzKHN0cnVj
dCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBzZXJpYWxfcnM0ODUgKnIKIAlyZXR1cm4gMDsKIH0K
IAotc3RhdGljIHZvaWQgdWFydF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODUoc3RydWN0IHVhcnRfcG9y
dCAqcG9ydCwgc3RydWN0IHNlcmlhbF9yczQ4NSAqcnM0ODUpCitzdGF0aWMgdm9pZCB1YXJ0X3Nh
bml0aXplX3NlcmlhbF9yczQ4NV9kZWxheXMoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwKKwkJCQkJ
ICAgICAgc3RydWN0IHNlcmlhbF9yczQ4NSAqcnM0ODUpCiB7Ci0JdTMyIHN1cHBvcnRlZF9mbGFn
cyA9IHBvcnQtPnJzNDg1X3N1cHBvcnRlZC0+ZmxhZ3M7Ci0KLQlpZiAoIShyczQ4NS0+ZmxhZ3Mg
JiBTRVJfUlM0ODVfRU5BQkxFRCkpIHsKLQkJbWVtc2V0KHJzNDg1LCAwLCBzaXplb2YoKnJzNDg1
KSk7Ci0JCXJldHVybjsKLQl9Ci0KLQkvKiBwaWNrIHNhbmUgc2V0dGluZ3MgaWYgdGhlIHVzZXIg
aGFzbid0ICovCi0JaWYgKChzdXBwb3J0ZWRfZmxhZ3MgJiAoU0VSX1JTNDg1X1JUU19PTl9TRU5E
fFNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORCkpICYmCi0JICAgICEocnM0ODUtPmZsYWdzICYgU0VS
X1JTNDg1X1JUU19PTl9TRU5EKSA9PQotCSAgICAhKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9S
VFNfQUZURVJfU0VORCkpIHsKLQkJZGV2X3dhcm5fcmF0ZWxpbWl0ZWQocG9ydC0+ZGV2LAotCQkJ
IiVzICglZCk6IGludmFsaWQgUlRTIHNldHRpbmcsIHVzaW5nIFJUU19PTl9TRU5EIGluc3RlYWRc
biIsCi0JCQlwb3J0LT5uYW1lLCBwb3J0LT5saW5lKTsKLQkJcnM0ODUtPmZsYWdzIHw9IFNFUl9S
UzQ4NV9SVFNfT05fU0VORDsKLQkJcnM0ODUtPmZsYWdzICY9IH5TRVJfUlM0ODVfUlRTX0FGVEVS
X1NFTkQ7Ci0JCXN1cHBvcnRlZF9mbGFncyB8PSBTRVJfUlM0ODVfUlRTX09OX1NFTkR8U0VSX1JT
NDg1X1JUU19BRlRFUl9TRU5EOwotCX0KLQogCWlmICghcG9ydC0+cnM0ODVfc3VwcG9ydGVkLT5k
ZWxheV9ydHNfYmVmb3JlX3NlbmQpIHsKIAkJaWYgKHJzNDg1LT5kZWxheV9ydHNfYmVmb3JlX3Nl
bmQpIHsKIAkJCWRldl93YXJuX3JhdGVsaW1pdGVkKHBvcnQtPmRldiwKQEAgLTEzNDUsOSArMTMy
NywzMyBAQCBzdGF0aWMgdm9pZCB1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NShzdHJ1Y3QgdWFy
dF9wb3J0ICpwb3J0LCBzdHJ1Y3Qgc2VyaWFsX3JzNAogCQkJIiVzICglZCk6IFJUUyBkZWxheSBh
ZnRlciBzZW5kaW5nIGNsYW1wZWQgdG8gJXUgbXNcbiIsCiAJCQlwb3J0LT5uYW1lLCBwb3J0LT5s
aW5lLCByczQ4NS0+ZGVsYXlfcnRzX2FmdGVyX3NlbmQpOwogCX0KK30KKworc3RhdGljIHZvaWQg
dWFydF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0
IHNlcmlhbF9yczQ4NSAqcnM0ODUpCit7CisJdTMyIHN1cHBvcnRlZF9mbGFncyA9IHBvcnQtPnJz
NDg1X3N1cHBvcnRlZC0+ZmxhZ3M7CisKKwlpZiAoIShyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVf
RU5BQkxFRCkpIHsKKwkJbWVtc2V0KHJzNDg1LCAwLCBzaXplb2YoKnJzNDg1KSk7CisJCXJldHVy
bjsKKwl9CisKKwkvKiBwaWNrIHNhbmUgc2V0dGluZ3MgaWYgdGhlIHVzZXIgaGFzbid0ICovCisJ
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
bmcsIDAsIHNpemVvZihyczQ4NS0+cGFkZGluZykpOwogfQotLSAKMi4zNi4xCgo=
