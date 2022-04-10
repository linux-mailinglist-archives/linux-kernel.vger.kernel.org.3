Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC754FAD71
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbiDJKus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiDJKty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:49:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC17D5370F;
        Sun, 10 Apr 2022 03:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649587639;
        bh=JByECI7TAM6CgORkivVd7bXTA2zEkD7TRbKJYZRCVwU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Q0GmQdFVVtIDZEjsMvsKkTHWKuiQIUpuSnwVlh0O4VsrtgQSy0pfA9awKY9GygFGU
         xUZ49NTV32j0QL9mO8ilQsZaUvu+OjXj4yBwwEe22/3eGEPife4x8qFzDPnaGkrvcO
         sp0kUAquj+xqL4tN0IS6AgwMZPuvWSuPQak7sPqA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.230]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UZ6-1ncx8P38GQ-000YNM; Sun, 10
 Apr 2022 12:47:19 +0200
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
Subject: [PATCH v4 RESEND 8/9] serial: fsl_lpuart: remove redundant code in rs485_config functions
Date:   Sun, 10 Apr 2022 12:46:41 +0200
Message-Id: <20220410104642.32195-9-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
References: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:Z+XKmCv9ccGIK4kvzSz6jEc3jegf7kILeUSLei2lpJxdxHIULrQ
 rPYaRQSw/gut4KnzrGNgaRL613Z0dAXLTuKiOTrQJP5SYsbxvHaAwS14Aae2ObBk92jvEF7
 YZXbWfyY+4QcWEcob6oB8o2Qu01Fo6A0CC3iuS3v8KT0ruS6pS8fRVDxIzbVYkTYjzoraKu
 SeiqKOCxPZA/iIU8y1LIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+HQ5Fnn3+po=:XkIi68X6HUVmbNelzXpCkP
 nmMJiXiCoEzrXXxVSadBtPkTcM5QF82TcAqMzQ07MqHsKxIy9JqgPYAet2aQKD2x/tjsw2Bao
 a7BIaR2NSwizS1BwwDGyUWt2saQeXMWNzWmBUI7U+vOD7GhlUvaNztlx1mu3sVpwrlxP42++A
 IeV8GaTka+sGZt0ydub798tOHillaijOLEbFz74tGuEocRzLgwtq+tzNjcbQGMUBITAnqy6yZ
 Ta7iwJmh0rnkyYJZniz+R9UUQC+/yRjn1/xarZvKMrkDNBVGpLkdoM/gLNsApVwJyeDd8KLmj
 gejKoaXWDeNneTsOHThFD/V5CEJjhRnCIuyH17ohFWPgdDl0Ts7Y7puMOJsgKb4Aj/49Xiu+5
 M16bzcebi2grpMGgDGxWwPzLKD92KswEfyevC6P2BrPZECAcFoEqMhovDlMG7kf0F/P7A9rif
 nORqzePvaS39/W8QJVihVEB6fxAO5YOebE1TcVLqs226Ngse1PxB2U7AG74eqcijSSg4afx3A
 WFx/B4KWy69yRslv6auEdwjz8nR9kbJEIVaGS2zd6aqCGbLAtyE1gsCI2HSHq8mPFI5RTZ+Ho
 nCYV/BKLjnfBIEFvJYeorcDPfhGaluMLT0v+ahauppMJGYTbz4oQwG7maQasvILmRvTm8tmC0
 xftth2k18lrQ+Qn6gfeSVrAp96igKGB6zliPsTVR1nZmd/xNCqDWWwtGWk+xa4aabONO3y8Il
 u64SU7blmTEPkM74NlH24SyETEPh2z4S37m/VSBfG8pPwh8BDCII5UmHf/3bpa72eE5osIkvF
 pW+76T/UUcpflJBiAHFLJIkPzkwHDb99BoApdr/5LCIB0DYU2+HJhQa3/xR4IbNkrUwh7Eu5Z
 gy05WJMc1YodbpKz/Tui2/pyOxawMXGVuuOF2RsiblIum2jCAbG3LULr22wqAynzT5SFbpXqj
 WYzoAEgf1v//gBHY6k/WxsuPiAnP1vYwuEfxISwDVzLDrgmGkM8ERueB6alEWcslY6A1lZp9G
 o8tFY7UUQPJOm8umRMPKzdK0o8ZyNPXVgIVLOjp1IDTJsWmxhC+GBMfLHS3I57/KkZoF1Mla1
 phymVb20OGHnzE=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
L3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jCmluZGV4IDg3Nzg5ODcyZjQwMC4uOGZlYTdmZDkxNWQy
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
