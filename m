Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB954B7BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245044AbiBPATr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:19:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244853AbiBPATb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:19:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97E2D4C84;
        Tue, 15 Feb 2022 16:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644970726;
        bh=BQ5MyBCpjfg+yHv6OzKWHvUqGE9f+kW4GWjcO6Xbhrg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Dz12jh4ANy9mGmLaDvnvpB6Suvo2dMtVONY/FoEbGMR9Uzd3UGNJ0f/ySjBQMtfRT
         bKb5oX2Kodg4U/t8DEla21qObCRl3j2bqHL8KXVvzRWbLJM1hqZspDDGr7xm9a3TvM
         op7q34WgeNSbvFUUJAQQ7hUz7p1aeMQqT0Stnvfo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0JW-1o06c208y0-00kSRH; Wed, 16
 Feb 2022 01:18:46 +0100
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
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH 2 8/9] serial: fsl_lpuart: remove redundant code in rs485_config functions
Date:   Wed, 16 Feb 2022 01:18:02 +0100
Message-Id: <20220216001803.637-9-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216001803.637-1-LinoSanfilippo@gmx.de>
References: <20220216001803.637-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:P/8CsEWOtdAMBAgYCvJwzihfTUjSNmpksL/b7HGx4d+x+KZ+Aq5
 GDe5r5fjAQPth1LWFk/RyKy+qtkIBQz/E2LHhpvHNpgkpJbIMQok+PDGFSINGISuUgutAS5
 S0kOwaqwpPwogy0rb4nDgg/89JCHkCZs4YDbEDrHhvHwoQfSBnIghNqmTI7GlAQZTIBU1xe
 rV4ZGCdkwDmJR4ot70cnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:52WexnfShw4=:drvjfqfunKYHM+fpCmKW8S
 K++lOUwYbzYVqR+mjmOneD5ojZwnaaaTmJ7KZGTKZPVyKW60Re7EQTKq5Sb2Ubpgc5JgOSFDP
 4upLqhrTe0RS/bLjAEbXE11r0K6swVCxxvg0e2BaHNw38IVhbg2iWdiv/nCSeiETIdbWeqkmk
 o3qQogHTuR64jG+EaLAE9GcTQRn3M7QSTgVR7I9B6Z27EcCnXokiv4itGTJTlHUZa5uhLJuod
 7LkKHIj5W0rfhkQgAaVpTIFzRJpB3ZdXjArDCDauMrM69WxeWEKA9bJsRUFPW/5s1g9z0LAut
 O6BYpPNQ987YzYnetcF067t20/2/BcMUebzRWS9NDyLmvyeEh0aMUrdgqQn7VT3/NpqVaC/fo
 npHK7EBQBpeOt/KToVMmBbzZTnKveUXp6M6H1ocH0B/9g3XCvN39IAhguG9LKIQKJUHrwf3M0
 cwRaXRm2/GGWO0hO5rCVx7cruLaKh8ocTzyvKzEXCaj2C+9jBqL+H7gNbfLtGIyGoufw/Tr+p
 LrKg4H+Yls/MhjjabyflH9oZclYfGmLRFlhinblR8dTJC2RMOI28PXbe271mxhgU5MME4DdCH
 tG7tvJ3Rcd96edoNpGB8KS4jD3ZHm+nqh6D8yd2GOkNcLAIhV8uogsXe7DWfbFZaiOjZvv/EU
 zWZMyisGZIJLfHDkTGjnVR3NF6Zmp3fCzBrMoGRlIMLDmFUSoV00j6NXMffJp6JOfI4IefRnt
 UDz59onhesy9t7jFkbg7kGss5LCD9IN1DUgV05nMfcdPkCShizKYs9L+ARcxKxvKeEti4XUV/
 6luXNJjmtHlOWQzS6W+71Aa36hYDB/19EEzXlMOMO77oiEivC74/M7OeI/DdhgdjfkQHtTfla
 y+JPf5ochr/b8+sQx8IlNAIONuleXxmJB3qDi2z8xk9OfCB0djsDb58Q3N1zW0EMf1q1sPDTs
 Y4htZIssY9YnC5OH8Y4ybLDvfwWeIlMzAB9Iy+IOxrPwOC2lisZb9L1lHYAh2zMUiPa/BZbkx
 tswJfHhiKUaLSjRoCcXUYZAC6vDMnwaF0yZ388YwhJ6977YkBlhzjGliwd0XyBEVKyvdvPN3U
 m+oQDsS40NCVS8=
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
SVIpOwogCXJldHVybiAwOwogfQotLSAKMi4zNC4xCgo=
