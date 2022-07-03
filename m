Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5818D5648B4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 19:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiGCRBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 13:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiGCRBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 13:01:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFD7615B;
        Sun,  3 Jul 2022 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656867690;
        bh=C3f07IvyTVhB+y3Q1h44bhbt9vRcIn4vLfeS+jIHjl4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UWg1iEGo6CeHvfMMIMMD9CoHT0jbVNvQN+at0B7mf3usRzdY1V7YQN10p7whaduf4
         Td0bpGFkBiZCRpROiY5W9x73UZkSpbeA/t5AzYKFhrP1WuM814C9xzxTtXsZBNGIlP
         dB6pbCgMy25/R0iizdNEA/ic2poIFkzPTjOdMz2Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.210]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MxlzI-1nPIwu0lH4-00zFlf; Sun, 03 Jul 2022 19:01:30 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v2 1/9] serial: core: only get RS485 termination GPIO if supported
Date:   Sun,  3 Jul 2022 19:00:31 +0200
Message-Id: <20220703170039.2058202-2-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:BNqEbx/9a7Pb1HYT5WcqGew1ocBgpWVPz7NMEroLwpfbbZWgiNG
 7ZgXhoo1Tbtpsx0c8O/Tr7rLINJO3+WiwvgZ5cKUVeGOXXxz6vLlB91Yvab8Z6dDulISFZ6
 RfJC5I4LfCOMl/2DuNx+yaeO7/pq2+uU/u0zO8R+liIAANAkdguZPE15z1YR4h8rGHuzPXC
 wR8nYf3FTb9S5SFa1lbdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oOHxaRj80UE=:FXzyBpuwcy/JGOnS5aO/lW
 Okq6c/8RULC3/s31QGDvwKmhxXuCI+RpcZwuJvTwctvF0AkUGt2H/sUiUM2lzAiJsvsHlkxft
 VbGjpoU77eMPiC9WXsHYImHUVXkXc7qPNDoCUvrt0Nc95/GHz/AczY1apx29If1P6fxQtdC2x
 GKJDPf2Wiui5VVaXfQj7v1OUpc/U2buXnJjUwrrgh6aL2ClzrH0RGPVYcNs99WXjLGcTo6lM1
 ehuJ0jBbEQ6RRBQUOH3DbEMn1C9HNBDyAURLhjIydo6YhemOIm/ejEiQyryXB5dTikblqLSEb
 KQmjaOk1g4EXtdi4g9bp7o7lKjWB1TQTXBoNKbDpDhMjb0LxBLWhxNJpQ8RXKqJy84DiXUiJ8
 7kJbXw00qPN5v5V9C11hRDi5Ayw6rZkVB87DVS+35ydmMm6LA+eGpasU5BSeuSQvvNQs/tRh2
 x2nSNm3i4z+O1QpSYoJjrm4Wkdh2H93IyMzORhYGWnFR/aVea8+pBfdTVe6nQ6WKor86v9R+Z
 u+zsH6NKK/4U9e8660hA9kUhXOy/8R8iDxhObv2TUgTWR686vcqc3YqCr8xRM7OqHPtYeMLKJ
 bnzR9/dm5vl3pvisfYe3YBGdT4dmgxCa+t/9JilOIdjkiOI5d7WDw1ebIaamCIZ8+grGUfGM1
 ivFitghN1blZXsYJncEElXX+YxMn630Tun5QABH1RsklORACj5tJWEKQaBgCZVMC9ZmKsDnBh
 Ht7Ux5vWBssGUHiiFbvIXtIjXANGBuKKR3JQThK4EKpyEHyvBXHmYHbBQ4QFmrWFx/HB+hWf9
 VooZW9sgqranC7d3CHKIJ6IBt9HA+ydMKIq3+u0mPzFYpkTdvhKJqih3OaIZkZANrEYjs3Xr2
 zd7aPMjN3lQs7ttcS+cemVL5/cx9y/LJP5E/g/9CVfMM8AhBdJP4CLr+PxKss/ytWIlCqii5E
 EDNU0mxEcx5tReyg3e4RgSrdRGbbaa5HXY63IXXyVxSzzist7x5o7vBAo6+lj2HWffuBFWOwB
 fFo9DUBgMHR2hBERTyicsUi/ugli6rcL9njTgY6kT+7WAY6X5l5nhNYoKyG7cTe6R2et0jLTK
 txuTm8H+E62W532aldkf+I/PVpgRHLb3mFLe5nGofHYGJQXaamKq3z1DQ==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIHVhcnRf
Z2V0X3JzNDg1X21vZGUoKSBvbmx5IHRyeSB0byBnZXQgYSB0ZXJtaW5hdGlvbiBHUElPIGlmIFJT
NDg1IGJ1cwp0ZXJtaW5hdGlvbiBpcyBzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlci4gVGhpcyBwcmV2
ZW50cyBmcm9tIGFsbG9jYXRpbmcKYW5kIGhvbGRpbmcgYSBHUElPIGRlc2NyaXB0b3IgZm9yIHRo
ZSBkcml2ZXJzIGxpZmV0aW1nIHRoYXQgd2lsbCBuZXZlciBiZQp1c2VkLgoKU2lnbmVkLW9mZi1i
eTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KLS0tCgpOT1RFOiAK
VGhpcyBwYXRjaCBmb2xsb3dzIHRoZSBkZXNpZ24gZGVjaXNpb24gdGhhdCAicnM0ODVfc3VwcG9y
dGVkIiBpcwpzZXQgYnkgdGhlIGRyaXZlciBhdCBpbml0aWFsaXphdGlvbiBhbmQgY2Fubm90IGJl
IG1vZGlmaWVkCmFmdGVyd2FyZHMuIEhvd2V2ZXIgdGhlIGJldHRlciBhcHByb2FjaCB3b3VsZCBi
ZSB0byBsZXQgdGhlIHNlcmlhbApjb3JlIG1vZGlmeSB0aGUgdGVybWluYXRpb24gR1BJTyBzdXBw
b3J0IHNldHRpbmcgYmFzZWQgb24gdGhlCmV4aXN0ZW5jZSBvZiBhIHRlcm1pbmF0aW9uIEdQSU8u
IElmICJyczQ4NV9zdXBwb3J0ZWQiIGlzIG5vdCBhIApyZWFkLW9ubHkgdmFsdWUgYW55IG1vcmUg
aW4gZnV0dXJlIHRoZSBsb2dpYyBpbXBsZW1lbnRlZCBpbiB0aGlzCnBhdGNoIHNob3VsZCBiZSBh
ZGp1c3RlZCBhY2NvcmRpbmdseS4KCiBkcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyB8
IDEwICsrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgYi9kcml2ZXJzL3R0eS9zZXJp
YWwvc2VyaWFsX2NvcmUuYwppbmRleCA4NWVmN2VmMDBiODIuLjM3Njg2NjNkZmE0ZCAxMDA2NDQK
LS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKKysrIGIvZHJpdmVycy90dHkv
c2VyaWFsL3NlcmlhbF9jb3JlLmMKQEAgLTM0MDQsNiArMzQwNCwxNiBAQCBpbnQgdWFydF9nZXRf
cnM0ODVfbW9kZShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQogCSAqLwogCXBvcnQtPnJzNDg1X3Rl
cm1fZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKGRldiwgInJzNDg1LXRlcm0iLAogCQkJ
CQkJCUdQSU9EX09VVF9MT1cpOworCisJaWYgKHBvcnQtPnJzNDg1X3Rlcm1fZ3BpbyAmJgorCSAg
ICAhKHBvcnQtPnJzNDg1X3N1cHBvcnRlZC0+ZmxhZ3MgJiBTRVJfUlM0ODVfVEVSTUlOQVRFX0JV
UykpIHsKKwkJZGV2X3dhcm4ocG9ydC0+ZGV2LAorCQkJIiVzICglZCk6IFJTNDg1IHRlcm1pbmF0
aW9uIGdwaW8gbm90IHN1cHBvcnRlZCBieSBkcml2ZXJcbiIsCisJCQlwb3J0LT5uYW1lLCBwb3J0
LT5saW5lKTsKKwkJZGV2bV9ncGlvZF9wdXQoZGV2LCBwb3J0LT5yczQ4NV90ZXJtX2dwaW8pOwor
CQlwb3J0LT5yczQ4NV90ZXJtX2dwaW8gPSBOVUxMOworCX0KKwogCWlmIChJU19FUlIocG9ydC0+
cnM0ODVfdGVybV9ncGlvKSkgewogCQlyZXQgPSBQVFJfRVJSKHBvcnQtPnJzNDg1X3Rlcm1fZ3Bp
byk7CiAJCXBvcnQtPnJzNDg1X3Rlcm1fZ3BpbyA9IE5VTEw7Ci0tIAoyLjI1LjEKCg==
