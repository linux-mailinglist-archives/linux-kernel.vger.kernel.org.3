Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAAF4C6150
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiB1ClA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiB1Ck4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:40:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A2C6AA5C;
        Sun, 27 Feb 2022 18:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646015996;
        bh=b2y7rSofyMsAlLxNarbQCRJjCqiYzdU9dmvDBfCGMLU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JR1AKVuNiqUbEUxyLsIzhssXF9U04iy6wbasXIWcmPYcWOwJvuupuX1uddFXeogpZ
         Igz8/9xLnDe0p0aWHdBknWFv+R6f5be4m8UZ3HGhaJF+F7oEyj2PmyvBaIS/3Y+4R6
         FbdhhRQz9Q6v8Nl4MfPcx22jhW1XiIKwXCqnvXqM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAfUe-1nV5W81iES-00B2Hg; Mon, 28
 Feb 2022 03:39:56 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        u.kleine-koenig@pengutronix.de
Cc:     linux@armlinux.org.uk, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH v4 8/9] serial: fsl_lpuart: remove redundant code in rs485_config functions
Date:   Mon, 28 Feb 2022 03:39:27 +0100
Message-Id: <20220228023928.1067-9-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
References: <20220228023928.1067-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:XQdTAWN+hOCHQZI0v6PwJlCmNFGeLzfYONORxEzccuJo5JNkvy3
 LLjpCfNjS+SyndZBa+MKsmY2KvbzaO3kciBZ+FYB2TZLsPwtWHz4At+PqEUr9rvE5H5xc2x
 nAmhN97jHyt9gP8kJvALdVh996IQr0+jGMGXgVrAInjtwCeZiEnMgx+jcWkfUn/luA1Ngyh
 h3KdHQN5wKUJuISgYfiDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xCK482DrRnc=:5lU9ulK8+36KTJoyzoD0vk
 +P/p+0PDYAbyZ4UQNvt/bpM/kJmxA4pYmDCK95qVXJork8vvYnw8ruFeweH/PvmGSaApDTHh1
 Az/tVDrEz3Er3RB7OuOOUhFIshN/ZpgOzOgGxk90xI1QN4dWE+Cvd1y++v45p+K+t2YiDadCe
 LrBJSyV8XLDSccTCmIi18lU+li4jjZmNwFFuzYL1UUVwmrInpsMJmBE4plwYH3skq47e6ecQl
 6XslkiKzE7Df6gZCvjZl1kpSMKw1Py3dok/l6GhXVEAnfwZUBYSE5nNKo30xlWF8PsePP+DwK
 Bb9T2nw+XlkBFsd+aq/px+FMFSLPXMIxBvuRHaSCb3ZGdeg2JJ3YFo8ilLx4qxjApztFPXCQz
 S4icdn1oHul70PywIAcElMwqf7f30Z5xo4TIF5B3a/ZbPEcbkUYr9h2ouR/hk8u0um5gOg/eu
 2uIpWhmUGwkPeNUGgLP6lD5erLt/LvQgo0eLX8BxOv9uWG0atkB20J0Lz8U9Ly0SsFyBlBjWy
 dVR1NpmPqe97bOTayj8lAlVF8pASU+dddr9cp2PXbHzNRqkrA8WfaDeFCmuFsny5+ryG+G3DL
 FGVgCoqZm8y2o4ZK3R1ANcXVwcl79hwTNALkl8gMYMG5xJMn9idlCzEKBFaHNDB9ff4V6aUD4
 sOQ2f7m85Da3+4itnf7ShvhQ6ct44UUYiiW3gHUF58i2VAP/nlBd8ayrFb1vb8u4lNC2gB3Zb
 eWzn44IBEKq4crDyf1CHMm7s0BcFE1mD1OSVXa/LlXRXj7TxMi67iheev4xrz/zeQHrMKaAGi
 7CIJExyh9iwCI8DL3R+9+9F2qOiJx9TqWd7Pf5XbypfH2N1HpTQD1taLu4T92kXyjd5ZctcvG
 q93VbVjfUxgPHblv9p8hTlvUKwG1fHWmrUXyor05j/VuzBUxqUGI8Di2NkQ1Dz11wkXaCElqb
 syV/NuRUnFUnqvPrSG8/TMt5tAv7kv5ejJnerymMg0Xe6ntqCIRNk7sqg/6sFVNUbKwhV/De0
 aQ6QSi2Xyt2t+5f1LgX/5n5kslu4LKcqCzuS1sGOK6B8rb7uZMu3IOwkTrJbKgkO1RzeHU7Fd
 jaO8BDIuDCxWc0=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdWFydF9zZXRfcnM0ODVfY29uZmlnKCkgdGhlIHNlcmlhbCBjb3JlIGFscmVhZHkgZW5zdXJl
cyB0aGF0IG9ubHkgb25lIG9mCmJvdGggb3B0aW9ucyBSVFMgb24gc2VuZCBvciBSVFMgYWZ0ZXIg
c2VuZCBpcyBzZXQuIEl0IGFsc28gYXNzaWducyB0aGUKcGFzc2VkIHNlcmlhbF9yczQ4NSBzdHJ1
Y3QgdG8gdGhlIHVhcnQgcG9ydC4KClNvIHJlbW92ZSB0aGUgY2hlY2sgYW5kIHRoZSBhc3NpZ25t
ZW50IGZyb20gdGhlIGRyaXZlcnMgcnM0ODVfY29uZmlnKCkKZnVuY3Rpb24gdG8gYXZvaWQgcmVk
dW5kYW5jeS4KClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8TGlub1NhbmZpbGlwcG9A
Z214LmRlPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgfCAzMiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDMyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgYi9kcml2ZXJz
L3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jCmluZGV4IDdkOTBjNWE1MzBlZS4uYTIwMWJlNDRkNjhh
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jCisrKyBiL2RyaXZl
cnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMKQEAgLTEzNzcsMTkgKzEzNzcsNiBAQCBzdGF0aWMg
aW50IGxwdWFydF9jb25maWdfcnM0ODUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwKIAkJLyogRW5h
YmxlIGF1dG8gUlMtNDg1IFJUUyBtb2RlICovCiAJCW1vZGVtIHw9IFVBUlRNT0RFTV9UWFJUU0U7
CiAKLQkJLyoKLQkJICogUlRTIG5lZWRzIHRvIGJlIGxvZ2ljIEhJR0ggZWl0aGVyIGR1cmluZyB0
cmFuc2ZlciBfb3JfIGFmdGVyCi0JCSAqIHRyYW5zZmVyLCBvdGhlciB2YXJpYW50cyBhcmUgbm90
IHN1cHBvcnRlZCBieSB0aGUgaGFyZHdhcmUuCi0JCSAqLwotCi0JCWlmICghKHJzNDg1LT5mbGFn
cyAmIChTRVJfUlM0ODVfUlRTX09OX1NFTkQgfAotCQkJCVNFUl9SUzQ4NV9SVFNfQUZURVJfU0VO
RCkpKQotCQkJcnM0ODUtPmZsYWdzIHw9IFNFUl9SUzQ4NV9SVFNfT05fU0VORDsKLQotCQlpZiAo
cnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X1JUU19PTl9TRU5EICYmCi0JCQkJcnM0ODUtPmZsYWdz
ICYgU0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EKQotCQkJcnM0ODUtPmZsYWdzICY9IH5TRVJfUlM0
ODVfUlRTX0FGVEVSX1NFTkQ7Ci0KIAkJLyoKIAkJICogVGhlIGhhcmR3YXJlIGRlZmF1bHRzIHRv
IFJUUyBsb2dpYyBISUdIIHdoaWxlIHRyYW5zZmVyLgogCQkgKiBTd2l0Y2ggcG9sYXJpdHkgaW4g
Y2FzZSBSVFMgc2hhbGwgYmUgbG9naWMgSElHSApAQCAtMTQwMiw5ICsxMzg5LDYgQEAgc3RhdGlj
IGludCBscHVhcnRfY29uZmlnX3JzNDg1KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAJCQltb2Rl
bSB8PSBVQVJUTU9ERU1fVFhSVFNQT0w7CiAJfQogCi0JLyogU3RvcmUgdGhlIG5ldyBjb25maWd1
cmF0aW9uICovCi0Jc3BvcnQtPnBvcnQucnM0ODUgPSAqcnM0ODU7Ci0KIAl3cml0ZWIobW9kZW0s
IHNwb3J0LT5wb3J0Lm1lbWJhc2UgKyBVQVJUTU9ERU0pOwogCXJldHVybiAwOwogfQpAQCAtMTQy
OCwxOSArMTQxMiw2IEBAIHN0YXRpYyBpbnQgbHB1YXJ0MzJfY29uZmlnX3JzNDg1KHN0cnVjdCB1
YXJ0X3BvcnQgKnBvcnQsCiAJCS8qIEVuYWJsZSBhdXRvIFJTLTQ4NSBSVFMgbW9kZSAqLwogCQlt
b2RlbSB8PSBVQVJUTU9ERU1fVFhSVFNFOwogCi0JCS8qCi0JCSAqIFJUUyBuZWVkcyB0byBiZSBs
b2dpYyBISUdIIGVpdGhlciBkdXJpbmcgdHJhbnNmZXIgX29yXyBhZnRlcgotCQkgKiB0cmFuc2Zl
ciwgb3RoZXIgdmFyaWFudHMgYXJlIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIGhhcmR3YXJlLgotCQkg
Ki8KLQotCQlpZiAoIShyczQ4NS0+ZmxhZ3MgJiAoU0VSX1JTNDg1X1JUU19PTl9TRU5EIHwKLQkJ
CQlTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQpKSkKLQkJCXJzNDg1LT5mbGFncyB8PSBTRVJfUlM0
ODVfUlRTX09OX1NFTkQ7Ci0KLQkJaWYgKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9SVFNfT05f
U0VORCAmJgotCQkJCXJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORCkKLQkJ
CXJzNDg1LT5mbGFncyAmPSB+U0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EOwotCiAJCS8qCiAJCSAq
IFRoZSBoYXJkd2FyZSBkZWZhdWx0cyB0byBSVFMgbG9naWMgSElHSCB3aGlsZSB0cmFuc2Zlci4K
IAkJICogU3dpdGNoIHBvbGFyaXR5IGluIGNhc2UgUlRTIHNoYWxsIGJlIGxvZ2ljIEhJR0gKQEAg
LTE0NTMsOSArMTQyNCw2IEBAIHN0YXRpYyBpbnQgbHB1YXJ0MzJfY29uZmlnX3JzNDg1KHN0cnVj
dCB1YXJ0X3BvcnQgKnBvcnQsCiAJCQltb2RlbSB8PSBVQVJUTU9ERU1fVFhSVFNQT0w7CiAJfQog
Ci0JLyogU3RvcmUgdGhlIG5ldyBjb25maWd1cmF0aW9uICovCi0Jc3BvcnQtPnBvcnQucnM0ODUg
PSAqcnM0ODU7Ci0KIAlscHVhcnQzMl93cml0ZSgmc3BvcnQtPnBvcnQsIG1vZGVtLCBVQVJUTU9E
SVIpOwogCXJldHVybiAwOwogfQotLSAKMi4zNS4xCgo=
