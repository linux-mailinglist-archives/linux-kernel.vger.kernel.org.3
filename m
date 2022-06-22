Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F3D554FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359618AbiFVPsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359503AbiFVPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:47:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E933C4AE;
        Wed, 22 Jun 2022 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655912840;
        bh=ng3CY5sBLo9HzL9eQ6cr+vyMggjXbLYmrX0EBHYnCIE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hxE6QMAWXz8YpSwjcicr3QOu28G1YDOM0vvGeIpeGDRQ3TkpGCJZxqvrLmOX8oIEU
         DIzVsoSlu+uP/XDoIeMqVIcm0kWq31QAngdg8EPZPRSOgSE4mVE6pPjVgWHeFTAbvP
         +pWdS4EK36cll96Ze7Z3lbTmVJBDmYN5NcCU44Us=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.2.22]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpDJd-1nKCVr0uzP-00qlEB; Wed, 22
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
Subject: [PATCH 2/8] serial: core, 8250: set RS485 termination gpio in serial core
Date:   Wed, 22 Jun 2022 17:46:53 +0200
Message-Id: <20220622154659.8710-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:cmEZCvLPWTj25EBlWIAqA2P+RVwRJduESTOZ6QXNayL1PnA2PFD
 0AYCcgcDpyZyU1uKG7YhQ++CwAbtQV9walYKTr0oUVIw1H6X+yxQ+klCIsAfKRbGDmJwiy7
 PM71d0xXn5O472U+OsJHEVvVqwUapk9CxxdVgZHJ/me28HSLuCrmcg6R3RJPEUbMRbPF/3o
 vPQXt2ygjo0IVkr3v+bvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5DQqlhHqeBQ=:NL07DEelmlp2U6m+kzaU9M
 tPEfKRnlZrnoQk3PwrBtsZwwCP2O2E4mG9RB/PI5VFjpbOxwo4wEuOo47ORqcJGS+QwMpevKw
 X7ah1Xc6qakmoFb9kaPpXO81Ko1adePtnz/o+8uOJfiH4dlTrWgLh/q+U/AAYZDHQhjeqv4X2
 Jh22L5o1iBU5zEbt1wlFL2Hse1wxsi3Fqg7WacHlaWE8J9d6sVezzedskcI88qOzdieEwAnIZ
 X+V0mA3ECAvTf+qt9OKxAyaHcs0I5l6r25kvzkabyAuJ2gFbOmf8AfdjqNJVAT2EpPITBUI0v
 ZfAoLaHKOZpRzPduNFWT/e7iubchvJVXItYBjPbq9J76YYgo/YLLCzWQsVMXHnD9E5GTd8lEl
 cXxQTJl8w3Q5ikjH+a44gJg79bB7Mx4QV7ndMn3PwD+hItrV1vCyOfpiygjAaMtBl9Uf+Iew6
 7DTAQGRoL9xWoTqyGUEZtSp2amz63/RL6fw+EEGiH3wqFBv3Pcw2vZqI9i2iioIJNY+pNR9kn
 zBOKuwrbDQosOrs3T70/FmfifARVva+iL0kEhFXUBYQgYaxRgnir8Ybm0BmaL+tfLGTHq5/SL
 l6Cwj0vAoX7VlpRazahpf+u9z3QVYkH5WS014EArFY77HrvgGcbB8tcFovfmbcynWwNhS/NW+
 jY8GF5rq+5r/AKssxNRrggscwa2k8f0GsRzEEoLLKxHjK5IGPYP1mwRh7gQBE02toKYG6Rrc7
 ho3vnCgJNtkJqWUPeXBA9uKQQqzvewym1favEUzIhRoghqogGZGZLpUpTJ5vFPYhCvoe8mDkS
 ooRxFwqhOUlcGVuAen+l8Vxf+dt9BTUvikMEm52fpxPyjLvlPiYyMV0AtRCxAbYfZkMTO41pr
 QwG7SpQ3aB4TuPnajfNAiluvHQSn8Gvea3gb+MYgqbpfSItXl3bFMJvXt5iuV9G5nob05an5P
 pi/OYt3fBIAKl1CTkqUBI+xh47Gz6upzAlhCHmnQyCh7+Lq6L3D7GuGd5rHpXJ6UpRZM8cTnN
 QhGlg2jQiU8AYRSzPf2xoaqiy+InRAJIdzszOlVDqwy7JLH1nM9AIXGtxiZzzmM0U4q1EU8Vr
 IQIF1RMxzhxtMkXToM02bxagV3Gu3G3Gv3G5He+4oisrrCu3MpUTSEmVA==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIHNlcmlh
bDgyNTBfZW00ODVfY29uZmlnKCkgdGhlIHRlcm1pbmF0aW9uIEdQSU8gaXMgc2V0IHdpdGggdGhl
IHVhcnRfcG9ydApzcGlubG9jayBoZWxkLiBUaGlzIGlzIGFuIGlzc3VlIGlmIHNldHRpbmcgdGhl
IEdQSU8gbGluZSBjYW4gc2xlZXAgKGUuZy4Kc2luY2UgdGhlIGNvbmNlcm5pbmcgR1BJTyBleHBh
bmRlciBpcyBjb25uZWN0ZWQgdmlhIFNQSSBvciBJMkMpLgoKRml4IHRoaXMgYnkgc2V0dGluZyB0
aGUgdGVybWluYXRpb24gbGluZSBvdXRzaWRlIG9mIHRoZSB1YXJ0X3BvcnQgc3BpbmxvY2sKaW4g
dGhlIHNlcmlhbCBjb3JlLgoKVGhpcyBhbHNvIG1ha2VzIHNldHRpbmcgdGhlIHRlcm1pbmF0aW9u
IEdQSU8gZ2VuZXJpYyBmb3IgYWxsIHVhcnQgZHJpdmVycy4KClNpZ25lZC1vZmYtYnk6IExpbm8g
U2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+Ci0tLQogZHJpdmVycy90dHkvc2Vy
aWFsLzgyNTAvODI1MF9wb3J0LmMgfCAgMyAtLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxf
Y29yZS5jICAgIHwgMTIgKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsLzgy
NTAvODI1MF9wb3J0LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuYwppbmRl
eCAzZTNkNzg0YWE2MjguLjUyNDVjMTc5Y2M1MSAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2Vy
aWFsLzgyNTAvODI1MF9wb3J0LmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9w
b3J0LmMKQEAgLTY3NSw5ICs2NzUsNiBAQCBpbnQgc2VyaWFsODI1MF9lbTQ4NV9jb25maWcoc3Ry
dWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IHNlcmlhbF9yczQ4NSAqcnM0ODUpCiAJCXJzNDg1
LT5mbGFncyAmPSB+U0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EOwogCX0KIAotCWdwaW9kX3NldF92
YWx1ZShwb3J0LT5yczQ4NV90ZXJtX2dwaW8sCi0JCQlyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVf
VEVSTUlOQVRFX0JVUyk7Ci0KIAkvKgogCSAqIEJvdGggc2VyaWFsODI1MF9lbTQ4NV9pbml0KCkg
YW5kIHNlcmlhbDgyNTBfZW00ODVfZGVzdHJveSgpCiAJICogYXJlIGlkZW1wb3RlbnQuCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyBiL2RyaXZlcnMvdHR5L3Nl
cmlhbC9zZXJpYWxfY29yZS5jCmluZGV4IDAxNWY0ZTFkYTY0Ny4uYjM4NzM3NmU2ZmEyIDEwMDY0
NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYworKysgYi9kcml2ZXJzL3R0
eS9zZXJpYWwvc2VyaWFsX2NvcmUuYwpAQCAtMTM1MiwxMiArMTM1MiwyMyBAQCBzdGF0aWMgdm9p
ZCB1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBzdHJ1
Y3Qgc2VyaWFsX3JzNAogCW1lbXNldChyczQ4NS0+cGFkZGluZywgMCwgc2l6ZW9mKHJzNDg1LT5w
YWRkaW5nKSk7CiB9CiAKK3N0YXRpYyB2b2lkIHVhcnRfc2V0X3JzNDg1X3Rlcm1pbmF0aW9uKHN0
cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCisJCQkJICAgICAgIGNvbnN0IHN0cnVjdCBzZXJpYWxfcnM0
ODUgKnJzNDg1KQoreworCWlmICghcG9ydC0+cnM0ODVfdGVybV9ncGlvIHx8ICEocnM0ODUtPmZs
YWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpKQorCQlyZXR1cm47CisKKwlncGlvZF9zZXRfdmFsdWVf
Y2Fuc2xlZXAocG9ydC0+cnM0ODVfdGVybV9ncGlvLAorCQkJCSAhIShyczQ4NS0+ZmxhZ3MgJiBT
RVJfUlM0ODVfVEVSTUlOQVRFX0JVUykpOworfQorCiBpbnQgdWFydF9yczQ4NV9jb25maWcoc3Ry
dWN0IHVhcnRfcG9ydCAqcG9ydCkKIHsKIAlzdHJ1Y3Qgc2VyaWFsX3JzNDg1ICpyczQ4NSA9ICZw
b3J0LT5yczQ4NTsKIAlpbnQgcmV0OwogCiAJdWFydF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODUocG9y
dCwgcnM0ODUpOworCXVhcnRfc2V0X3JzNDg1X3Rlcm1pbmF0aW9uKHBvcnQsIHJzNDg1KTsKIAog
CXJldCA9IHBvcnQtPnJzNDg1X2NvbmZpZyhwb3J0LCByczQ4NSk7CiAJaWYgKHJldCkKQEAgLTE0
MDAsNiArMTQxMSw3IEBAIHN0YXRpYyBpbnQgdWFydF9zZXRfcnM0ODVfY29uZmlnKHN0cnVjdCB1
YXJ0X3BvcnQgKnBvcnQsCiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsKIAl1YXJ0X3Nhbml0aXpl
X3NlcmlhbF9yczQ4NShwb3J0LCAmcnM0ODUpOworCXVhcnRfc2V0X3JzNDg1X3Rlcm1pbmF0aW9u
KHBvcnQsICZyczQ4NSk7CiAKIAlzcGluX2xvY2tfaXJxc2F2ZSgmcG9ydC0+bG9jaywgZmxhZ3Mp
OwogCXJldCA9IHBvcnQtPnJzNDg1X2NvbmZpZyhwb3J0LCAmcnM0ODUpOwotLSAKMi4zNi4xCgo=
