Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443014BEF17
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbiBVBQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:16:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbiBVBQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:16:04 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DF324F2A;
        Mon, 21 Feb 2022 17:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645492512;
        bh=b2y7rSofyMsAlLxNarbQCRJjCqiYzdU9dmvDBfCGMLU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HHyhmPBXip9YYtenzshreMUrlHEgCwgJ6wWiL/edeehDc1L9FOIWnsma8Bu6uZZyD
         WkEX/X87zgvOP77rTQKWAm3o7zDefUjJz8HnuJ/nD1rhqTix3XlYzHJDUMyJssIx/h
         nshou38+ERYs0+EqfKUkYzd49GigfpK6SX/dsj9Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysRk-1o9SNJ303m-00vtVm; Tue, 22
 Feb 2022 02:15:11 +0100
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
Subject: [PATCH v3 8/9] serial: fsl_lpuart: remove redundant code in rs485_config functions
Date:   Tue, 22 Feb 2022 02:14:32 +0100
Message-Id: <20220222011433.8761-9-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
References: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:R0QwZ7CNF/l/mRVr+oYBpn8dTdTWnAg8vgoTGVXQ9Mtiola7ML7
 Mkl6ZXbpw9nxjwQ/YrMsXG2eychqcNDicAHEe+IabnCRP/RAvPcJ62XIxtBfpGAF+em2sek
 kUgKEtTAosYJNi0QhCrHzl2C/mYfmrhCSBRcRGlzm2+8QTn3h+O5RxxmHLTEkVJPxtuFdYE
 E+2R4PaSc8DQHuCuSPcyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DUG/ztOuIFI=:1BsmmNuF7gdS2hxGJQpIHJ
 5hpDyATXMN3pr7gBPEGWyh3vAF/XwBTer6Ej5JP4t+K/4C4kurCUZKMuYxzMi1Xz5NoUoNX4q
 9l21cWU4Pv7pui2RjU7YNu3FiQK4Jk4uZo3hVTqZpZYZ4mOt2G4IXi0xu8dtC7VzZqFtEThXo
 D29SNRRz0zJsS7fV1o7BzW4gUoreZ0i2W0PlFsaluRF8fRPmhmPoahynjwBo6z/S5xHadGD0f
 r9kO9UYv+aCI5meYUYrO37GTBHDxnrkHiDNCJStcWJ5WW3kDXH4DmXJlQsxljJpycdrL9hWqq
 9aZHwS3iRjn6zat858JCplxguKC2gb60qRDyg/A584yjHq6TGTo7j+gTNGSHv3j6yUCwyoem1
 YAZKrCL7KAJ7AhFcKb31/kMRwmGjH+NO7VFblWN7BvaKs/39vrNonBtrNa4dXTg8juV4WMHAQ
 yGOY0jpyh9hnVvC5c8rTv1LMBjJSgUuv8YhgTqYu7U237Bdz7O1nyGFqAyY9KjWCuvDJr96Dr
 FtGSJ+hKgcDpNQw410ctyRHiyJnmsJmTkXF0+HzfhZ6w2ysj5nmgNiCk01FyNGCcAYp6CfD7H
 i6dreZ1DgIj1Ydt2a/pJYynR0SBMxakK4ArPSrPSDt9YJ3dyvYJrCQf7TzbOckGf8qT/u53WP
 /wf0mcE5PUjp4+r0IAvbwp2q4yga+zS9oLatt3p+JxdA90Rl2raox8xM7B6GgWoAXTF4/nrXu
 7tAAHLRJtGjhmvwhvAdhCUh2HGey4qi4zfw70VImeH+FB9xXrh+R7jCRDeRiRYDPjWSQLF3xy
 TD+/+LDL/vZsi+SepeInxHaP1yzcsR8r7OlHicy7xO7mHclozUdbnkKmHgQDoc47l+0us0wB+
 UwkAf7bg+5d6r4RINRFrgbySE0XVnBq7lWHJyHpjAUuoKgLyCvAfmfpM1DvcYeQp9iiiL5UjW
 4HXjKxQF84bIRqbZbg8XgLD1Dv1CHmH+LbIiDvYhdt1Urv1AUtUH0kyJHzCu1gUu3monwdCoj
 pyZqFbfcmYieAK4/7HVQFjGYri+JtV30JpBymfzWn98afpf1m3RtLuxJ22RQn6rRrGjmZ1B2Q
 st6kdOr4Wviz+I=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
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
